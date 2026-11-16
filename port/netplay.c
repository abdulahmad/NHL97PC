/* SPDX-License-Identifier: MIT
 * Copyright (c) 2026 abdulahmad and contributors
 *
 * Online play with rollback, NHL 97's part (the same design as the NHL 96 port's netplay.c). Two machines run the same game;
 * Overbar's core (overbar/net.h) guesses the other machine's buttons so a step never waits, and when a guess was wrong a state
 * from before it is loaded and the steps since are played again (overbar/rollback.h: the game's memory and the game thread's
 * stack). The session glue (Online page, its settings file, waiting for the other machine) is Overbar's overbar/netgame.h.
 *
 *   - Input records. The timer callback InputRecordTimer polls the controllers (PollControllers: the 8 slot words, SlotWords,
 *     and the flag word HotKeyFlags) and every 3 ticks pushes a record into a ring of 5 (InputRecordRing, 14h bytes: the 8 slot
 *     words, the flags, the ticks). GameLoop asks InputRecordAvail, takes a record (TakeInputRecord) and runs the simulation for
 *     it (RunSimFrames), then draws a frame. In a session the callback does nothing and InputRecordAvail asks this file: once per
 *     pass of the loop it is one step of the session, with both machines' slot words and flags (host: slot 0, guest: slot 1),
 *     3 ticks. The states are taken there.
 *   - The game's clock (tickcount) counts 3 a step in a session instead of the timer interrupt's ticks, so it is the same on
 *     both machines and goes back with a state.
 *   - The in-game menus (RunInGameMenu, called from GameLoop: pause, intermission, end of game) are left out in a session; the
 *     record's pause bit is dropped. The game goes on.
 *   - Start: PlayGame, after the Online page's Host / Connect. The host's game options (the 130h block from GLOBAL.SET), its
 *     game set-up (teams, user logs, the 8 controller set-up bytes) and both random seeds (EA's and the C library's) go to the
 *     guest; slot 0 plays the host's team, slot 1 the other, each machine reads its own controller into its slot. Each
 *     machine's own options and set-up come back when that game is over.
 * The hooks run in the game thread; the main thread polls the socket (netplay_main_poll). */
#include "host.h"
#include "overbar_client.h"
#include "season.h"
#include "overbar/net.h"
#include "overbar/netgame.h"
#include "overbar/rollback.h"
#include <SDL.h>
#include <string.h>

#ifdef _WIN32
#define SYM(s) "_" s
#else
#define SYM(s) s
#endif
#ifndef NHL97_BUILD
#define NHL97_BUILD "unknown"
#endif

/* ---- the game's code and data (original linear addresses) ---- */
#define O_PLAYGAME     SYM_PlayGame            /* PlayGame: push 28h (5 bytes), call __CHK ... */
#define O_LOOP         SYM_GameLoop            /* GameLoop, up to the next routine */
#define O_LOOP_END     SYM_InitGameDisplay     /* InitGameDisplay, the routine after GameLoop */
#define O_SAMPLER      SYM_InputRecordTimer    /* push ebx, ecx, edx, esi, edi, ebp */
#define O_AVAIL        SYM_InputRecordAvail    /* push 4 / call __CHK / mov eax, InputRecordCount / ret */
#define O_READPADS     SYM_PollControllers     /* the controllers into SlotWords, the hot keys into HotKeyFlags */
#define O_INITPADS     SYM_InitSlotTable       /* InitSlotTable(eax: the 8 controller set-up bytes): SlotWords' high bytes, the teams */
#define O_MENU         SYM_RunInGameMenu
#define O_STREAMSVC    0x3EF68u                /* sub_3EF68, the audio stream service */
#define O_NEXTCHUNK    0x3FBE4u                /* sub_3FBE4, the stream's next chunk (0: none) */
#define O_TICK_ISR     SYM_TimerISR            /* has inc dword [tickcount] (FF 05 addr) */
#define O_CSEED_FN     SYM_GetRandState        /* mov eax, <the C library's rand state> / ret */
#define D_EASEED       SYM_seed                /* randomd0's state */
#define D_QCOUNT       SYM_InputRecordCount
#define D_QHEAD        SYM_InputRecordHead
#define D_QRING        SYM_InputRecordRing
#define D_SLOTS        SYM_SlotWords           /* 8 words: high byte device (bits 0-2) and team (bit 7), low byte buttons */
#define D_FLAGS        SYM_HotKeyFlags
#define D_MENUFLAG     SYM_InGameMenuRequest
#define D_OPTS         SYM_dword_1AC810        /* the options block of GLOBAL.SET (magic, install mode, then the game's options) */
#define D_SETUP        SYM_unk_1ACB44          /* the game set-up: +1 the teams, +5 the user logs, +10Dh the 8 controller bytes */
#define OPTS_SKIP      8u                      /* the magic and the install mode stay each machine's */
#define OPTS_N         0x130u
#define SETUP_N        0x115u                  /* the teams, the user logs and the controller bytes; the key sets after them stay */
#define PADCFG         0x10Du
#define REC_N          0x14u
#define STEP_TICKS     3u
#define VTIME_START    0x01000000u             /* tickcount at a session's first step (above anything the loading left) */
#define G32(o) (*(volatile uint32_t *)GAME_ADDR(o))

/* ---- the state ---- */
volatile int nh_sim;                    /* a session drives the game (the hooks are on) */
volatile int nh_quiet;                  /* a replay is running: nothing is shown */
static int nh_ok, nh_me, nh_dead, nh_regions_log;
static uint32_t nh_given;               /* this pass of the loop has had its step (in the states) */
static uint32_t nh_steps;               /* steps run (in the states) */
static uint32_t nh_hi;                  /* the most steps made: below it a step is a replay (no waiting) */
static int64_t nh_next_ns;              /* when the next new step is due */
static uint16_t nh_local[2];            /* this machine's slot word and flags */
static uint16_t nh_all[OB_NET_MAX_PADS];
static uint8_t my_cfg;                  /* this machine's controller byte (device, team) */
volatile uint32_t *nh_tick_ptr;         /* tickcount */
volatile uint32_t nh_vtime, nh_rt_ticks;
void *nh_pg_cont, *nh_sit_cont, *nh_loop, *nh_menu;
static ob_net *nh_net;
static ob_rollback *nh_rb;
static SDL_mutex *nh_lock;
static char *nh_stack_base;

/* the machine's own options and set-up, put back when the session's game is over */
static struct { uint8_t opts[OPTS_N], setup[SETUP_N]; } nh_saved;

typedef struct nh_settings {
    uint32_t magic, version;
    uint32_t ea_seed, c_seed, host_cfg;
    uint8_t opts[OPTS_N];
    uint8_t setup[SETUP_N];
} nh_settings;
#define NH_MAGIC 0x4F373948u            /* "H97O" */

void snap_set_stack_base(void *base) { nh_stack_base = (char *)base; }
int netplay_running(void) { return nh_sim; }

static volatile uint32_t *cseed_ptr(void)
{
    const uint8_t *p = GAME_ADDR(O_CSEED_FN);
    uint32_t a;
    if (p[0] != 0xB8 || p[5] != 0xC3) return NULL;
    memcpy(&a, p + 1, 4);
    return (volatile uint32_t *)(uintptr_t)a;
}

/* game routines: Watcom's register calls keep every register but eax */
static void game_call0(void *fn) { ((void (*)(void))fn)(); }
static void game_call_eax(void *fn, uint32_t eax)
{
    __asm__ volatile("call *%[f]" : "+a"(eax) : [f] "r"(fn) : "memory", "cc", "ecx", "edx");
}

/* ---- the states: the game's image without the input it reads live, the host's step counters, then dos.c's (DOS memory, the
 * DPMI blocks). The keyboard's key table, the controller words and the hot keys stay as they are when a state is loaded, so a key
 * held now stays held. ---- */
static const struct { uint32_t lo, hi; } live[] = {
    { 0x16D8ACu, 0x16D8B4u },           /* PollControllers' hot key repeat times */
    { 0x16D8FCu, 0x16D90Cu },           /* SlotWords */
    { 0x170764u, 0x170814u },           /* the keyboard handler: key table and its flags */
    { 0x1CD244u, 0x1CD24Eu },           /* Ctrl, Alt, HotKeyFlags */
};

static int nh_regions(void *user, ob_snap_region *r, int max)
{
    uint32_t at = OBJ1_BASE;
    int n = 0, i;
    (void)user;
    for (i = 0; i < (int)(sizeof live / sizeof *live); i++) {
        if (n >= max) return -1;
        r[n].p = GAME_ADDR(at); r[n].n = live[i].lo - at; n++;
        at = live[i].hi;
    }
    if (n + 3 > max) return -1;
    r[n].p = GAME_ADDR(at); r[n].n = OBJ1_BASE + GAME_SPAN - at; n++;
    r[n].p = &nh_given; r[n].n = sizeof nh_given; n++;
    r[n].p = &nh_steps; r[n].n = sizeof nh_steps; n++;
    return dos_snap_regions(r, n, max);
}

static uint32_t nh_hold(void *user) { uint32_t v = (uint32_t)vif; (void)user; vif = 0; return v; }   /* no interrupt meanwhile */
static void nh_release(void *user, uint32_t tag, int loaded) { (void)user; (void)loaded; vif = (int)tag; }

static void lock(void) { SDL_LockMutex(nh_lock); }
static void unlock(void) { SDL_UnlockMutex(nh_lock); }
static int trylock(void) { return SDL_TryLockMutex(nh_lock); }

static int nh_frame(void *user)
{
    int r;
    (void)user;
    lock();
    ob_netgame_where = "ob_net_frame";
    r = nh_net ? ob_net_frame(nh_net, 1, nh_local, nh_all) : -1;
    ob_netgame_where = "";
    unlock();
    return r;
}

/* what the desync check compares: both random states, the clock, the steps, the record ring, the players' positions */
static uint64_t sim_hash(void)
{
    uint64_t h = 1469598103934665603ULL;
    volatile uint32_t *cs = cseed_ptr();
    uint32_t v[4];
    const uint8_t *q;
    size_t k;
    int i;
    v[0] = G32(D_EASEED); v[1] = cs ? *cs : 0; v[2] = *nh_tick_ptr; v[3] = nh_steps;
    for (q = (const uint8_t *)v, k = 0; k < sizeof v; k++) { h ^= q[k]; h *= 1099511628211ULL; }
    for (q = GAME_ADDR(D_QRING), k = 0; k < 5 * REC_N; k++) { h ^= q[k]; h *= 1099511628211ULL; }
    for (i = 0; i < 16; i++)                        /* where everyone is: SortCords' positions and speeds (+1Ch..+38h of each 108h) */
        for (q = GAME_ADDR(SYM_SortCords) + i * 0x108 + 0x1C, k = 0; k < 0x1C; k++) { h ^= q[k]; h *= 1099511628211ULL; }
    return h;
}

/* this machine's slot word and flags for a new step: the game's own reader with only this machine's controller in the slot
 * table (the others read nothing), as its timer callback would; then the slot words as they were (NHL97_AUTOPAD: made up) */
static void read_local(uint32_t step)
{
    uint16_t *slots = (uint16_t *)GAME_ADDR(D_SLOTS), saved[8], w;
    int i;
    if (getenv("NHL97_AUTOPAD")) {
        w = (uint16_t)(((my_cfg & 0x87u) << 8) | (step < 100u ? 0u : (1u + step / 6u % 8u) | (step % 13u == 5u ? 0x10u : 0)));
        nh_local[0] = w; nh_local[1] = 0;
        return;
    }
    memcpy(saved, slots, sizeof saved);
    for (i = 0; i < 8; i++) slots[i] = (uint16_t)(i == nh_me ? (my_cfg & 0x87u) << 8 : 0);
    game_call0(GAME_ADDR(O_READPADS));
    w = slots[nh_me];
    nh_local[0] = (uint16_t)((saved[nh_me] & 0xFF00u) | (w & 0x00FFu));     /* the device bits as both machines have them */
    nh_local[1] = (uint16_t)(*(volatile uint16_t *)GAME_ADDR(D_FLAGS) & ~1u);   /* no pause online */
    memcpy(slots, saved, sizeof saved);
}

static void push_record(void)
{
    uint32_t head = G32(D_QHEAD);
    uint8_t *rec = GAME_ADDR(D_QRING) + head * REC_N;
    uint16_t w[10];
    int i;
    memcpy(w, GAME_ADDR(D_SLOTS), 16);
    for (i = 0; i < 8; i++) w[i] &= 0xFF00u;
    w[0] = nh_all[0];                               /* slot 0: the host's word, slot 1: the guest's */
    w[1] = nh_all[2];
    w[8] = (uint16_t)((nh_all[1] | nh_all[3]) & ~1u);
    w[9] = STEP_TICKS;
    memcpy(rec, w, REC_N);
    G32(D_QHEAD) = (head + 1) % 5;
    G32(D_QCOUNT) = G32(D_QCOUNT) + 1;
}

static void log_step(uint32_t cnt)
{
    char line[200] = "";
    lock();
    if (nh_net) ob_net_status(nh_net, line, sizeof line);
    unlock();
    fprintf(stderr, "rollback: at %.1f s, step %u; %s; %s\n", plat_now_ns() / 1e9, (unsigned)cnt, ob_rollback_stats(nh_rb), line);
    if (nh_regions_log) {
        uint64_t h[64];
        int n = ob_rollback_region_hashes(nh_rb, h, 64), i;
        fprintf(stderr, "regions at step %u:", (unsigned)cnt);
        for (i = 0; i < n; i++) fprintf(stderr, " %d:%08x", i, (unsigned)(h[i] ^ (h[i] >> 32)));
        fprintf(stderr, "\n");
    }
}

int netplay_vtime_wait(uint32_t until, int one)
{
    int32_t left;
    unsigned hz;
    if (!nh_vtime || !nh_tick_ptr) return 0;
    left = (int32_t)(until - *nh_tick_ptr);
    if (left <= 0) return 1;
    if (one) left = 1;
    hz = irq_pit_hz() ? irq_pit_hz() : 100;
    if (!nh_quiet) plat_sleep_ms((int)((uint64_t)left * 1000u / hz) > 0 ? (int)((uint64_t)left * 1000u / hz) : 1);
    *nh_tick_ptr += (uint32_t)left;                 /* the same on both machines: the same waits at the same points */
    return 1;
}

/* the session has ended in the game: it plays on here alone (the other slot gets no more buttons) */
static void go_local(void)
{
    nh_sim = 0;
    nh_quiet = 0;
    nh_vtime = 0;
    nh_dead = 1;
}

/* One step: wait for its time when it is a new one, then ask the core (which may load a state and come back here). */
static int make_step(void)
{
    uint32_t cnt;
    int r;
    int64_t wait_from = 0;
    unsigned hz = irq_pit_hz() ? irq_pit_hz() : 100;
    for (;;) {
        lock();
        cnt = nh_net ? ob_net_step_count(nh_net) : 0;
        unlock();
        if (cnt >= nh_hi) {                         /* a new step: at the record rate, 3 ticks of the game's timer */
            int64_t now = plat_now_ns();
            if (!nh_next_ns || now - nh_next_ns > 200000000LL) nh_next_ns = now;
            if (now < nh_next_ns) { plat_sleep_ms(1); continue; }
            read_local(cnt);
            if (!nh_vtime) {                        /* the first step: from here the clock counts steps, from the same value on both */
                nh_rt_ticks = *nh_tick_ptr;
                *nh_tick_ptr = VTIME_START;
                nh_vtime = 1;
                if (ob_netgame_test()) fprintf(stderr, "online: first step at %.1f s (game clock was %u)\n", plat_now_ns() / 1e9, (unsigned)nh_rt_ticks);
            }
        }
        r = ob_rollback_frame(nh_rb, nh_frame, NULL);
        if (r == OB_NET_RUN) break;
        if (r < 0) return -1;
        if (!wait_from) wait_from = plat_now_ns();
        else if (wait_from > 0 && plat_now_ns() - wait_from > 3000000000LL && ob_netgame_test()) {
            char line[200];
            lock();
            if (nh_net) ob_net_status(nh_net, line, sizeof line); else line[0] = 0;
            unlock();
            fprintf(stderr, "online: step %u waits over 3 s: %s\n", (unsigned)cnt, line);
            wait_from = -1;                         /* once a step */
        }
        plat_sleep_ms(1);                           /* OB_NET_WAIT: the others are behind */
    }
    lock();
    nh_quiet = ob_net_replaying(nh_net);
    cnt = ob_net_step_count(nh_net);
    unlock();
    if (cnt > nh_hi) { nh_hi = cnt; nh_next_ns += (int64_t)STEP_TICKS * 1000000000LL / (int64_t)hz; }
    if ((cnt - 1) % 60 == 0) {
        uint64_t h = sim_hash();
        lock();
        if (nh_net) ob_net_check(nh_net, cnt - 1, h);
        unlock();
    }
    nh_steps = cnt;
    *nh_tick_ptr += STEP_TICKS;
    push_record();
    if (!nh_quiet && cnt % 200 == 0 && ob_netgame_test()) log_step(cnt);
    return 0;
}

/* InputRecordAvail (GameLoop's "is there a record?", and the line-up loop's): in a session, one step a pass */
/* Offline frame pacing (Video page, Frame rate; video.c frames_mode). The game draws whenever no input record is waiting, and much
 * of what moves on the screen (the camera's moves between plays, some animation) moves a step per drawn frame, not per record. On
 * a Pentium 75-100 the drawing took about as long as a record (3 ticks, about 34 a second); a modern CPU drew hundreds of frames a
 * second and those ran 10x too fast (and the busy loop stuttered).
 *   Pentium 100: after a frame the loop waits for the next record (at most 100 ms, in case the records stop): one frame a record.
 *   60 fps: no frame sooner than 1/60 s after the last one; a record that comes meanwhile is run first.
 *   Unlocked: as fast as it can (the original on a fast CPU). NHL97_FRAMES=pentium100 / 60 / free overrides the setting. */
extern volatile int frames_mode;
static int nh_drew;
static int64_t nh_drew_ns;
static uint32_t paced_avail(uint32_t c)
{
    static int env = -2;
    int mode;
    if (env == -2) {
        const char *e = getenv("NHL97_FRAMES");
        env = !e ? -1 : !strcmp(e, "free") || !strcmp(e, "unlocked") ? 2 : !strcmp(e, "60") ? 1 : 0;
    }
    mode = env >= 0 ? env : frames_mode;
    if (!c && (mode == 0 ? nh_drew : mode == 1)) {
        int64_t until = mode == 1 ? nh_drew_ns + 1000000000 / 60 : plat_now_ns() + 100000000;
        while (!(c = G32(D_QCOUNT)) && plat_now_ns() < until) host_idle_once();
    }
    nh_drew = !c;                                   /* no record: the loop draws a frame now */
    if (!c) nh_drew_ns = plat_now_ns();
    return c;
}

uint32_t nh_avail(void)
{
    uint32_t c = G32(D_QCOUNT);
    if (!nh_sim) return paced_avail(c);
    if (c) return c;
    if (nh_given) { nh_given = 0; return 0; }       /* this pass had its step: now it draws */
    if (make_step()) { go_local(); return G32(D_QCOUNT); }
    nh_given = 1;
    return G32(D_QCOUNT);
}

/* ---- the start and end of the session's game ---- */
static uint8_t *setup_ptr(void) { return GAME_ADDR(D_SETUP); }

static void make_settings(nh_settings *s)
{
    volatile uint32_t *cs = cseed_ptr();
    memset(s, 0, sizeof *s);
    s->magic = NH_MAGIC; s->version = 1;
    s->ea_seed = G32(D_EASEED);
    s->c_seed = cs ? *cs : 0;
    s->host_cfg = my_cfg;
    memcpy(s->opts, GAME_ADDR(D_OPTS), OPTS_N);
    memcpy(s->setup, setup_ptr(), SETUP_N);
}

static void apply_settings(const nh_settings *s)
{
    volatile uint32_t *cs = cseed_ptr();
    uint8_t *su = setup_ptr(), *cfg = su + PADCFG;
    int i;
    memcpy(GAME_ADDR(D_OPTS) + OPTS_SKIP, s->opts + OPTS_SKIP, OPTS_N - OPTS_SKIP);
    memcpy(su, s->setup, SETUP_N);
    for (i = 0; i < 8; i++)                         /* slot 0 the host's team, slot 1 the other; nobody in 2-7 (device 2: keys) */
        cfg[i] = (uint8_t)(i == 0 ? 2u | (s->host_cfg & 0x80u) : i == 1 ? 2u | (~s->host_cfg & 0x80u) : 0);
    game_call_eax(GAME_ADDR(O_INITPADS), (uint32_t)(uintptr_t)cfg);
    G32(D_EASEED) = s->ea_seed;
    if (cs) *cs = s->c_seed;
}

/* this machine's controller: the first of its 8 set-up bytes with a device that a person plays (2 and up) */
static int find_mine(void)
{
    const uint8_t *cfg = setup_ptr() + PADCFG;
    int i;
    for (i = 0; i < 8; i++)
        if ((cfg[i] & 7u) >= 2) { my_cfg = cfg[i]; return 0; }
    return -1;
}

void nh_playgame_enter(void)
{
    char identity[200];
    nh_settings mine;
    const nh_settings *theirs;
    size_t size = 0;
    ob_net_game g;
    ob_rollback_game rg;
    if (!nh_ok || !ob_netgame_armed()) return;
    if (G32(SYM_dword_16DA9C)) { ob_netgame_set_why("the game's own modem or network play is on"); return; }
    if (find_mine()) { ob_netgame_set_why("pick a controller for one of the teams first"); return; }
    if (!nh_rb) {
        memset(&rg, 0, sizeof rg);
        rg.regions = nh_regions;
        rg.watch = plat_write_watch;
        rg.hold = nh_hold;
        rg.release = nh_release;
        rg.slots = 32;
        nh_rb = ob_rollback_new(&rg, nh_stack_base);
        if (!nh_rb) { ob_netgame_set_why("no memory for the rollback states"); return; }
    }
    snprintf(identity, sizeof identity, "nhl97pc %s rollback1 sound %s", NHL97_BUILD, getenv("NHL97_SOUND") ? getenv("NHL97_SOUND") : "game");
    make_settings(&mine);
    memset(&g, 0, sizeof g);
    g.identity = identity;
    g.pads = 4;                                     /* two 16-bit pads a machine: its slot word and its flags */
    g.settings = &mine;
    g.settings_size = sizeof mine;
    g.states = ob_rollback_states(nh_rb);
    nh_net = ob_netgame_begin(&g);
    if (!nh_net) return;
    port_season_bind_net(nh_net);
    lock();
    theirs = (const nh_settings *)ob_net_settings(nh_net, &size);
    nh_me = (ob_net_my_pads(nh_net) & 1) ? 0 : 1;
    unlock();
    if (!theirs || size != sizeof *theirs || theirs->magic != NH_MAGIC || theirs->version != 1) {
        port_season_unbind_net();
        lock(); ob_net_quit(nh_net); unlock();
        ob_netgame_end("the host's settings are not this version's");
        nh_net = NULL;
        return;
    }
    memcpy(nh_saved.opts, GAME_ADDR(D_OPTS), OPTS_N);
    memcpy(nh_saved.setup, setup_ptr(), SETUP_N);
    apply_settings(theirs);
    my_cfg = (uint8_t)(2u | ((nh_me == 0 ? theirs->host_cfg : ~theirs->host_cfg) & 0x80u) | (my_cfg & 7u));
    nh_given = 0; nh_steps = 0; nh_hi = 0; nh_next_ns = 0; nh_dead = 0; nh_quiet = 0;
    nh_vtime = 0;                                   /* (the loading still runs on the timer's ticks: it waits on them) */
    nh_sim = 1;
    if (ob_netgame_test()) fprintf(stderr, "online: session on, this machine plays slot %d (controller byte %02x)\n", nh_me, (unsigned)my_cfg);
}

/* GameLoop has returned: the clock is the timer's again (the end screens wait on it) */
void nh_game_over(void)
{
    if (!nh_sim) return;
    nh_vtime = 0;
    nh_quiet = 0;
}

void nh_playgame_exit(void)
{
    if (!nh_net) return;
    nh_sim = 0; nh_vtime = 0; nh_quiet = 0;
    ob_rollback_reset(nh_rb);
    port_season_unbind_net();
    ob_netgame_end(nh_dead ? NULL : "the game is over");
    nh_net = NULL;
    memcpy(GAME_ADDR(D_OPTS), nh_saved.opts, OPTS_N);
    memcpy(setup_ptr(), nh_saved.setup, SETUP_N);
}

void nh_menu_skip(void) { G32(D_MENUFLAG) = 0; }

/* ---- the stubs ---- */
__attribute__((naked)) static void pg_entry(void)        /* PlayGame: around the whole game */
{
    __asm__ volatile(
        "pushal\n\tcall " SYM("nh_playgame_enter") "\n\tpopal\n\t"
        "pushl $2f\n\t"
        "pushl $0x28\n\tjmp *" SYM("nh_pg_cont") "\n"
        "2:\n\tpushal\n\tcall " SYM("nh_playgame_exit") "\n\tpopal\n\tret");
}

__attribute__((naked)) static void sit_entry(void)       /* InputRecordTimer, the record timer: nothing in a session */
{
    __asm__ volatile(
        "cmpl $0, " SYM("nh_sim") "\n\tjne 1f\n\t"
        "pushl %ebx\n\tpushl %ecx\n\tpushl %edx\n\tpushl %esi\n\tpushl %edi\n\tpushl %ebp\n\tjmp *" SYM("nh_sit_cont") "\n"
        "1:\n\tret");
}

__attribute__((naked)) static void avail_stub(void)      /* InputRecordAvail: eax the count (popal takes eax from 28(%esp)) */
{
    __asm__ volatile(
        "pushal\n\tcall " SYM("nh_avail") "\n\tmovl %eax, 28(%esp)\n\tpopal\n\tret");
}

__attribute__((naked)) static void menu_stub(void)
{
    __asm__ volatile(
        "cmpl $0, " SYM("nh_sim") "\n\tje 1f\n\tpushal\n\tcall " SYM("nh_menu_skip") "\n\tpopal\n\tret\n"
        "1:\n\tjmp *" SYM("nh_menu"));
}

__attribute__((naked)) static void loop_stub(void)       /* PlayGame's call of GameLoop: then the game is over */
{
    __asm__ volatile("call *" SYM("nh_loop") "\n\tpushal\n\tcall " SYM("nh_game_over") "\n\tpopal\n\tret");
}

/* the timer interrupt's inc dword [tickcount]: in a session a count of the host's instead (the steps move tickcount) */
__attribute__((naked)) static void tick_stub(void)
{
    __asm__ volatile(
        "cmpl $0, " SYM("nh_vtime") "\n\tjne 1f\n\t"
        "pushl %eax\n\tmovl " SYM("nh_tick_ptr") ", %eax\n\tincl (%eax)\n\tpopl %eax\n\tret\n"
        "1:\n\tincl " SYM("nh_rt_ticks") "\n\tret");
}

/* The streamed audio (the stream service sub_3EF68 and its "next chunk" sub_3FBE4) is not part of a session. Its buffers and
 * its state are in the game's memory, so a loaded state takes them back, while the sound card's DMA and the stream file's
 * position go on: the service then found its stream stopped, or waited for ever (the loop at 3EF88) for an event that had already
 * happened. In a session (muted anyway: audio.c) the service does nothing and there is never a next chunk. */
void *nh_svc_cont, *nh_chunk_cont;
__attribute__((naked)) static void svc_entry(void)       /* sub_3EF68: push ebx, esi, edi, ebp / sub esp, 4 */
{
    __asm__ volatile(
        "cmpl $0, " SYM("nh_sim") "\n\tjne 1f\n\t"
        "pushl %ebx\n\tpushl %esi\n\tpushl %edi\n\tpushl %ebp\n\tsubl $4, %esp\n\tjmp *" SYM("nh_svc_cont") "\n"
        "1:\n\tret");
}
__attribute__((naked)) static void chunk_entry(void)     /* sub_3FBE4: push ebx, esi / mov eax, [esp+0Ch] */
{
    __asm__ volatile(
        "cmpl $0, " SYM("nh_sim") "\n\tjne 1f\n\t"
        "pushl %ebx\n\tpushl %esi\n\tmovl 12(%esp), %eax\n\tjmp *" SYM("nh_chunk_cont") "\n"
        "1:\n\txorl %eax, %eax\n\tret");
}

static void set_call(uint8_t *p, void *to)
{
    int32_t rel = (int32_t)((uintptr_t)to - ((uintptr_t)p + 5));
    patch_bytes(p + 1, &rel, 4);
}

static int has_addr(const uint8_t *p, uint32_t orig)     /* the 4 bytes at p are the address of orig */
{
    uint32_t v;
    memcpy(&v, p, 4);
    return v == (uint32_t)(uintptr_t)GAME_ADDR(orig);
}

/* the call rel32 sites in [lo, hi) that go to target (a byte scan: every E8 whose target is target) */
static int find_calls(uint32_t lo, uint32_t hi, uint32_t target, uint8_t **out, int max)
{
    uint8_t *p = GAME_ADDR(lo), *end = GAME_ADDR(hi) - 5;
    int n = 0;
    for (; p <= end; p++) {
        int32_t rel;
        if (*p != 0xE8) continue;
        memcpy(&rel, p + 1, 4);
        if (p + 5 + rel != GAME_ADDR(target)) continue;
        if (n < max) out[n] = p;
        n++;
    }
    return n;
}

/* after install_overrides, before the game thread starts */
void netplay_install(void)
{
    static const uint8_t pg_head[5] = { 0x68, 0x28, 0, 0, 0 }, sit_head[6] = { 0x53, 0x51, 0x52, 0x56, 0x57, 0x55 };
    const uint8_t *a = GAME_ADDR(O_AVAIL);
    uint8_t *tick = NULL, *menus[8], *loops[2];
    int ok = 1, nmenu, nloop, i;
    if (!nh_lock) nh_lock = SDL_CreateMutex();
    nh_regions_log = getenv("NHL97_REGIONS") != NULL;
    if (memcmp(GAME_ADDR(O_PLAYGAME), pg_head, 5) || memcmp(GAME_ADDR(O_SAMPLER), sit_head, 6)) ok = 0;
    for (i = 0; i < 64 && !tick; i++) {             /* TimerISR's inc dword [tickcount] */
        uint8_t *p = GAME_ADDR(O_TICK_ISR) + i;
        if (p[0] == 0xFF && p[1] == 0x05 && has_addr(p + 2, ORIG_TICKCOUNT)) tick = p;
    }
    if (!tick) ok = 0;
    if (a[0] != 0x68 || a[1] != 4 || a[5] != 0xE8 || a[10] != 0xA1 || !has_addr(a + 11, D_QCOUNT) || a[15] != 0xC3) ok = 0;
    nmenu = find_calls(O_LOOP, O_LOOP_END, O_MENU, menus, 8);
    nloop = find_calls(O_PLAYGAME, O_PLAYGAME + 0x400, O_LOOP, loops, 2);
    if (nmenu != 3 || nloop != 1 || !cseed_ptr() || !nh_lock) ok = 0;
    if (!ok) {
        fprintf(stderr, "online play: the game's code is not as expected, not available (menu calls %d, loop calls %d)\n", nmenu, nloop);
        return;
    }
    nh_tick_ptr = (volatile uint32_t *)GAME_ADDR(ORIG_TICKCOUNT);
    nh_pg_cont = GAME_ADDR(O_PLAYGAME + 5);
    nh_sit_cont = GAME_ADDR(O_SAMPLER + 6);
    nh_loop = GAME_ADDR(O_LOOP);
    nh_menu = GAME_ADDR(O_MENU);
    patch_jmp(GAME_ADDR(O_PLAYGAME), (void *)pg_entry);
    patch_jmp(GAME_ADDR(O_SAMPLER), (void *)sit_entry);
    patch_jmp(GAME_ADDR(O_AVAIL), (void *)avail_stub);
    {
        uint8_t code[6];
        int32_t rel = (int32_t)((uintptr_t)tick_stub - ((uintptr_t)tick + 5));
        code[0] = 0xE8; memcpy(code + 1, &rel, 4); code[5] = 0x90;
        patch_bytes(tick, code, sizeof code);
    }
    for (i = 0; i < nmenu; i++) set_call(menus[i], (void *)menu_stub);
    set_call(loops[0], (void *)loop_stub);
    {
        static const uint8_t svc_head[7] = { 0x53, 0x56, 0x57, 0x55, 0x83, 0xEC, 0x04 }, chunk_head[6] = { 0x53, 0x56, 0x8B, 0x44, 0x24, 0x0C };
        if (!memcmp(GAME_ADDR(O_STREAMSVC), svc_head, 7) && !memcmp(GAME_ADDR(O_NEXTCHUNK), chunk_head, 6)) {
            nh_svc_cont = GAME_ADDR(O_STREAMSVC + 7);
            nh_chunk_cont = GAME_ADDR(O_NEXTCHUNK + 6);
            patch_jmp(GAME_ADDR(O_STREAMSVC), (void *)svc_entry);
            patch_jmp(GAME_ADDR(O_NEXTCHUNK), (void *)chunk_entry);
        } else fprintf(stderr, "online play: the audio stream service is not as expected, not patched\n");
    }
    nh_ok = 1;
}

/* ---- the main thread ---- */
void netplay_main_poll(void)
{
    if (nh_lock) ob_netgame_main_poll();
    if (nh_lock && SDL_TryLockMutex(nh_lock) == 0) {
        port_season_poll();
        SDL_UnlockMutex(nh_lock);
    }
}

static int page_is_open(void) { return overbar_client_open(); }

void netplay_online_setup(ob_host *h)
{
    static char ini[1024];
    ob_netgame_cfg c;
    char *base = SDL_GetBasePath();
    if (!nh_lock) nh_lock = SDL_CreateMutex();
    snprintf(ini, sizeof ini, "%shockey-online.ini", base ? base : "");
    SDL_free(base);
    memset(&c, 0, sizeof c);
    c.title = "NHL 97 (SDL2 port)";
    c.ini_path = ini;
    c.env = "NHL97";
    c.how = "both players: start a new exhibition game";
    c.pads_per_player = 2;
    c.test_port = 41970;
    c.lock = lock;
    c.unlock = unlock;
    c.trylock = trylock;
    c.sleep_ms = plat_sleep_ms;
    c.page_is_open = page_is_open;
    c.open_page = overbar_client_online_open;
    c.close_page = overbar_client_close;
    ob_netgame_setup(h, &c);
}
