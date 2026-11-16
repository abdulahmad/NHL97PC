/* SPDX-License-Identifier: MIT
 * Copyright (c) 2026 abdulahmad and contributors
 *
 * The game camera at the original pace, whatever the frame rate. NHL 97 moves its camera a step per drawn frame (the eases toward
 * the goal, the orbits, the moves after a faceoff win), so above the frame rate of a Pentium 100 (one picture per input record, 3
 * ticks) every camera move ran too fast. With Frame rate at 60 fps or Unlocked, the camera here runs once per 3 ticks of the frame
 * time DrawGameFrame is given (as on a Pentium 100, with the same elapsed ticks), and the frames in between are drawn with the
 * camera blended between its last two states: smooth, and one camera step (30 ms) behind. At Pentium 100 and online nothing
 * changes. NHL97_CAMBLEND=0 turns this off (the camera then steps once per frame again).
 *
 * DrawGameFrame (4BA00, eax the frame's time in ticks) calls RunCameraScene (1B85C: the scene step, then UpdateGameCamera) with
 * the ticks since the last frame. Its entry is wrapped (before: decide; after: put the camera's true state back, so the game
 * logic between frames never sees a blended one) and that call goes to cam_run.
 *
 * The camera's state: CameraStateRecords (1B9058-1B92D0, the matrix at +253h), the camera variables (19D0A4-19D38C) and
 * F32_ViewAngle (16B72C). The renderer's own copies (CameraYaw .. CameraFlags, 170254-170278) are left out: other drawing
 * writes them every frame at times. A blended frame mixes each float of the two
 * states; integers, pointers and a float that jumped (a cut, an angle wrapping round) take the newer state. */
#include "host.h"
#include <SDL.h>
#include <math.h>
#include <string.h>

#ifdef _WIN32
#define SYM(s) "_" s
#else
#define SYM(s) s
#endif

#define O_DRAW        0x4BA00u        /* DrawGameFrame: push ebx, ecx, edx, esi, ebp / sub esp, 30h (8 bytes) */
#define O_RUNCAM      0x1B85Cu        /* RunCameraScene(eax = ticks since the last frame) */
#define STEP_TICKS    3

static const struct { uint32_t lo, hi; } cam_regions[] = {
    { 0x1B9058u, 0x1B92D0u }, { 0x19D0A4u, 0x19D38Cu }, { 0x16B72Cu, 0x16B730u },
};
#define NREG (int)(sizeof cam_regions / sizeof *cam_regions)
#define CAM_BYTES ((0x1B92D0u - 0x1B9058u) + (0x19D38Cu - 0x19D0A4u) + 4u)

int nh_frames_mode(void);             /* netplay.c: 0 Pentium 100, 1 60 fps, 2 unlocked (the setting or NHL97_FRAMES) */
int netplay_running(void);

void *cam_draw_cont, *cam_runcam, *cam_body;
static uint32_t cur[CAM_BYTES / 4], prev[CAM_BYTES / 4], mix[CAM_BYTES / 4];
static int have_cur, have_prev, blended, do_step, cam_off = -1;
static int32_t last_t, step_t;
static int64_t step_ns;
volatile uint32_t cam_elapsed;        /* read by cam_run_stub */

static void save(uint32_t *to)
{
    uint8_t *d = (uint8_t *)to;
    int i;
    for (i = 0; i < NREG; i++) { uint32_t n = cam_regions[i].hi - cam_regions[i].lo; memcpy(d, GAME_ADDR(cam_regions[i].lo), n); d += n; }
}

static void load(const uint32_t *from)
{
    const uint8_t *s = (const uint8_t *)from;
    int i;
    for (i = 0; i < NREG; i++) { uint32_t n = cam_regions[i].hi - cam_regions[i].lo; memcpy(GAME_ADDR(cam_regions[i].lo), s, n); s += n; }
}

/* the floats a blended frame mixes (field-aligned: CameraStateRecords starts with 7 bytes of flags); everything else in the
 * regions is the newer state as it is */
static const struct { uint32_t lo, hi; } blend_ranges[] = {
    { 0x1B905Fu, 0x1B907Bu },           /* CameraStateRecords +7 .. +23h: the current position and angles */
    { 0x1B92ABu, 0x1B92CFu },           /*   +253h: the view matrix (3x3) */
    { 0x19D188u, 0x19D1B8u },           /* CameraPos .. CameraFocusVec */
    { 0x19D31Cu, 0x19D348u },           /* CameraEye .. CameraFovTarget */
    { 0x16B72Cu, 0x16B730u },           /* F32_ViewAngle */
};
static int blend_word[CAM_BYTES / 4];   /* the byte offset in the state of each float to mix, -1 ends */

static void blend_init(void)
{
    unsigned k, n = 0;
    for (k = 0; k < sizeof blend_ranges / sizeof *blend_ranges; k++) {
        uint32_t a;
        for (a = blend_ranges[k].lo; a + 4 <= blend_ranges[k].hi; a += 4) {
            uint32_t off = 0;
            int r;
            for (r = 0; r < NREG; r++) {
                if (a >= cam_regions[r].lo && a + 4 <= cam_regions[r].hi) { blend_word[n++] = (int)(off + (a - cam_regions[r].lo)); break; }
                off += cam_regions[r].hi - cam_regions[r].lo;
            }
        }
    }
    blend_word[n] = -1;
}

static void blend(float frac)
{
    const uint8_t *pb = (const uint8_t *)prev, *cb = (const uint8_t *)cur;
    uint8_t *mb = (uint8_t *)mix;
    int i;
    memcpy(mix, cur, sizeof mix);
    for (i = 0; blend_word[i] >= 0; i++) {
        float a, b, m;
        int o = blend_word[i];
        memcpy(&a, pb + o, 4); memcpy(&b, cb + o, 4);
        if (!isfinite(a) || !isfinite(b) || a == b) continue;
        m = fabsf(a) > fabsf(b) ? fabsf(a) : fabsf(b);
        if (fabsf(b - a) > (m * 0.5f > 1.0f ? m * 0.5f : 1.0f)) continue;    /* a cut or an angle wrapping round */
        m = a + (b - a) * frac;
        memcpy(mb + o, &m, 4);
    }
    load(mix);
    blended = 1;
}

static int active(void)
{
    if (cam_off < 0) { const char *e = getenv("NHL97_CAMBLEND"); cam_off = e && *e == '0'; }
    return !cam_off && !netplay_running() && nh_frames_mode() != 0;
}

/* before a frame is drawn: t is DrawGameFrame's eax */
static uint32_t now_state[CAM_BYTES / 4];
static unsigned n_step, n_changed, n_blend, n_frames;
static int64_t log_ns;
static int cam_log = -1;
static void log_counts(void)                 /* NHL97_CAMLOG=1: every 2 s, how the frames went */
{
    int64_t now;
    if (cam_log < 0) cam_log = getenv("NHL97_CAMLOG") != NULL;
    if (!cam_log) return;
    now = plat_now_ns();
    if (now - log_ns < 2000000000) return;
    fprintf(stderr, "camera: %u frames, %u steps (%u after a change of the game's), %u blended\n", n_frames, n_step, n_changed, n_blend);
    n_frames = n_step = n_changed = n_blend = 0;
    log_ns = now;
}
static uint32_t first_diff(const uint32_t *a, const uint32_t *b)      /* the original address of the first word that differs */
{
    unsigned i, off;
    int r;
    for (i = 0; i < CAM_BYTES / 4 && a[i] == b[i]; i++) ;
    if (i == CAM_BYTES / 4) return 0;
    off = i * 4;
    for (r = 0; r < NREG; r++) {
        uint32_t n = cam_regions[r].hi - cam_regions[r].lo;
        if (off < n) return cam_regions[r].lo + off;
        off -= n;
    }
    return 0;
}
void cam_begin(int32_t t)
{
    blended = 0;
    if (!active() || !have_cur) { do_step = 2; last_t = t; return; }     /* 2: the original call, its own ticks */
    save(now_state);
    n_frames++;
    log_counts();
    if (memcmp(now_state, cur, sizeof cur)) {          /* the game changed the camera since (a new view, a scene): its turn now */
        if (cam_log > 0 && n_changed < 3) fprintf(stderr, "camera: the game changed %06X\n", (unsigned)first_diff(now_state, cur));
        do_step = 1; n_step++; n_changed++;
        cam_elapsed = (uint32_t)(t - step_t > 0 && t >= step_t ? t - step_t : 1);
        have_prev = 0;                                  /* no blend across a change of the game's */
    } else if (t - step_t >= STEP_TICKS || t < step_t) {      /* the camera's turn (or the time went back: a replay rewound) */
        do_step = 1; n_step++;
        cam_elapsed = (uint32_t)(t < step_t ? 1 : t - step_t);
    } else {
        int64_t per = (int64_t)STEP_TICKS * 1000000000 / (irq_pit_hz() ? irq_pit_hz() : 100);
        float frac = (float)(plat_now_ns() - step_ns) / (float)per;
        do_step = 0;
        if (have_prev) n_blend++;
        if (have_prev) blend(frac < 0 ? 0 : frac > 1 ? 1 : frac);
    }
    last_t = t;
}

/* RunCameraScene's call in DrawGameFrame: returns 1 when the original is to run (cam_elapsed ticks) */
int cam_should_run(void) { return do_step; }

/* after the camera ran */
void cam_ran(void)
{
    if (!active()) { have_cur = 1; save(cur); have_prev = 0; step_t = last_t; step_ns = plat_now_ns(); return; }
    if (have_cur) { memcpy(prev, cur, sizeof cur); have_prev = 1; }
    save(cur);
    have_cur = 1;
    step_t = last_t;
    step_ns = plat_now_ns();
    if (have_prev) blend(0.0f);           /* draw one step behind: the frames up to the next step blend from here */
}

/* after the frame: the game goes on with the camera's true state */
void cam_end(void)
{
    if (blended) {                       /* only the floats the blend wrote, and only where the game has not written since */
        uint8_t now[CAM_BYTES];
        const uint8_t *cb = (const uint8_t *)cur, *mb = (const uint8_t *)mix;
        int i;
        save((uint32_t *)now);
        for (i = 0; blend_word[i] >= 0; i++) {
            int o = blend_word[i];
            if (!memcmp(now + o, mb + o, 4)) memcpy(now + o, cb + o, 4);
        }
        load((const uint32_t *)now);
    }
    blended = 0;
}

__attribute__((naked)) static void draw_body(void)
{
    __asm__ volatile(
        "pushl %ebx\n\tpushl %ecx\n\tpushl %edx\n\tpushl %esi\n\tpushl %ebp\n\tsubl $0x30, %esp\n\tjmp *" SYM("cam_draw_cont"));
}

__attribute__((naked)) static void draw_entry(void)
{
    __asm__ volatile(
        "pushal\n\tpushl %eax\n\tcall " SYM("cam_begin") "\n\taddl $4, %esp\n\tpopal\n\t"
        "call *" SYM("cam_body") "\n\t"
        "pushal\n\tcall " SYM("cam_end") "\n\tpopal\n\tret");
}

volatile uint32_t cam_orig_ticks;
__attribute__((naked)) static void cam_run_stub(void)   /* eax: the ticks DrawGameFrame worked out (ours are used when blending) */
{
    __asm__ volatile(
        "movl %eax, " SYM("cam_orig_ticks") "\n\t"
        "pushal\n\tcall " SYM("cam_should_run") "\n\tmovl %eax, 28(%esp)\n\tpopal\n\t"
        "testl %eax, %eax\n\tje 1f\n\t"
        "cmpl $2, %eax\n\tje 2f\n\t"
        "movl " SYM("cam_elapsed") ", %eax\n\tjmp 3f\n"
        "2:\n\tmovl " SYM("cam_orig_ticks") ", %eax\n"
        "3:\n\t"
        "call *" SYM("cam_runcam") "\n\t"
        "pushal\n\tcall " SYM("cam_ran") "\n\tpopal\n"
        "1:\n\tret");
}

void camera_install(void)
{
    static const uint8_t head[8] = { 0x53, 0x51, 0x52, 0x56, 0x55, 0x83, 0xEC, 0x30 };
    uint8_t *d = GAME_ADDR(O_DRAW), *p, *call = NULL;
    for (p = d + 8; p < d + 0x80; p++) {
        int32_t rel;
        if (*p != 0xE8) continue;
        memcpy(&rel, p + 1, 4);
        if (p + 5 + rel == GAME_ADDR(O_RUNCAM)) { call = p; break; }
    }
    if (memcmp(d, head, 8) || !call) { fprintf(stderr, "camera: DrawGameFrame is not as expected, not patched\n"); return; }
    cam_draw_cont = d + 8;
    cam_runcam = GAME_ADDR(O_RUNCAM);
    cam_body = (void *)draw_body;
    {
        int32_t rel = (int32_t)((uintptr_t)cam_run_stub - ((uintptr_t)call + 5));
        patch_bytes(call + 1, &rel, 4);
    }
    blend_init();
    patch_jmp(d, (void *)draw_entry);
}
