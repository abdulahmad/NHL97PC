/* Game routines that talk to hardware are replaced at their entry by a jump to host code (or by a plain ret). */
#include <stdio.h>
#include "host.h"
#include <string.h>
#include <stdlib.h>
#include <SDL.h>

#ifdef _WIN32
#define SYM(s) "_" s
#else
#define SYM(s) s
#endif

void patch_bytes(void *at, const void *bytes, size_t n)
{
    memcpy(at, bytes, n);
}

static void stub_zero(void *at)
{
    static const uint8_t code[] = { 0x31, 0xC0, 0xC3 };
    patch_bytes(at, code, sizeof code);
}

void patch_jmp(void *from, void *to)
{
    uint8_t code[5];
    int32_t rel = (int32_t)((uintptr_t)to - ((uintptr_t)from + 5));
    code[0] = 0xE9;
    memcpy(code + 1, &rel, 4);
    patch_bytes(from, code, 5);
}

#ifdef _WIN32
/* __setenvp_ (D7C08) would load FS with the DOS/4GW environment selector (FS is the TEB on Windows). Build the same table from the flat
 * block (cstart.c): environ at 14F09C, the flag bytes at 14F0A0, the block pointer at 12442D. This was an empty stub, so environ stayed 0,
 * getenv_ (C2CF7) returned 0 for everything and the sound code (CE0CB: BLASTER, D6128: ULTRASND) found no card: no sound on Windows. */
#define ORIG_ENVIRON  SYM__environ
#define ORIG_ENVFLAGS SYM____env_mask
void host_setenvp(void)
{
    static char *env[65];
    static uint8_t flags[64];
    uint32_t blk;
    char *p;
    int n = 0;
    if (*(uint32_t *)GAME_ADDR(ORIG_ENVIRON)) return;
    memcpy(&blk, GAME_ADDR(ORIG_CRT_ENV), 4);
    p = (char *)(uintptr_t)blk;
    for (; p && *p && n < 64; p += strlen(p) + 1) { env[n++] = p; TRACE("env %s\n", p); }
    env[n] = 0;
    *(uint32_t *)GAME_ADDR(ORIG_ENVIRON) = (uint32_t)(uintptr_t)env;
    *(uint32_t *)GAME_ADDR(ORIG_ENVFLAGS) = (uint32_t)(uintptr_t)flags;
}

__attribute__((naked)) static void setenvp_entry(void)
{
    __asm__ volatile("pushal\n\tcall _host_setenvp\n\tpopal\n\tret");
}
#endif

volatile int intro_skip;
volatile int intro_title;
volatile int host_allow_irq;

void host_set_deadline(uint32_t ticks)
{
    uint32_t *count = (uint32_t *)GAME_ADDR(ORIG_TICKCOUNT);
    uint32_t *dead = (uint32_t *)GAME_ADDR(ORIG_TICKDEADLINE);
    if (intro_skip) ticks = 0;
    *dead = *count + ticks;
}

/* Spinning on tickcount in host code deadlocks on Windows: plat_kick_game only delivers IRQs when EIP is in the game image, so
 * the PIT handler never runs and WaitTicks(1) at the end of a TGV (PlayTGV) hangs forever. That matched "freeze after Pioneer /
 * freeze when skipping EA or Pioneer". Allow the kick while we wait, and sleep so the main thread can raise the timer and poll input. */
/* Waiting in the host for the game's clock. The timer interrupt has to reach the game thread meanwhile. It used to be put into
 * the thread wherever it was (host_allow_irq), also inside a Windows system call (the sleep): there the changed context was now
 * and then lost, the interrupt counted as taken but its handler never ran, and no interrupt came again (the clock stopped for
 * good: the intro hung in WaitTickDeadline, the start of an online test hung on one side). Now the thread sleeps while nothing is
 * pending and, while an interrupt is, spins in host_safe_spin: a pause loop of a few instructions with no system call, where
 * plat_kick_game may put an interrupt at any instruction. */
__asm__(".text\n\t.globl " SYM("host_safe_spin") "\n" SYM("host_safe_spin") ":\n\t"
        "1:\n\tpause\n\tdecl %ecx\n\tjnz 1b\n\tret\n\t"
        ".globl " SYM("host_safe_spin_end") "\n" SYM("host_safe_spin_end") ":\n\tnop\n");
void host_idle_once(void)                   /* one wait step on the game thread: interrupts can come meanwhile */
{
    if (irq_deliverable()) {
        uint32_t n = 4000;                        /* a few hundred microseconds: the main thread kicks about every millisecond */
        __asm__ volatile("call " SYM("host_safe_spin") : "+c"(n) : : "memory", "cc");
    } else plat_sleep_ms(1);
}
void host_wait_until(volatile uint32_t *count, uint32_t until)
{
    while ((int32_t)(*count - until) < 0) host_idle_once();
}

void host_wait_ticks(uint32_t ticks)
{
    uint32_t *count = (uint32_t *)GAME_ADDR(ORIG_TICKCOUNT);
    uint32_t until;
    if (intro_skip) ticks = 0;
    until = *count + ticks;
    if (netplay_vtime_wait(until, 0)) return;   /* online: the clock is the steps' (netplay.c) */
    host_wait_until(count, until);
}

/* WaitTickDeadline: wait for the deadline SetTickDeadline set (the CD audio's 5-tick pauses, the disk speed test) */
void host_wait_deadline(void)
{
    uint32_t *count = (uint32_t *)GAME_ADDR(ORIG_TICKCOUNT);
    uint32_t until = *(uint32_t *)GAME_ADDR(ORIG_TICKDEADLINE);
    if (netplay_vtime_wait(until, 0)) return;
    host_wait_until(count, until);
}

/* TickDeadlinePassed: 1 once tickcount has reached the deadline (unsigned, as the original's sbb), else 0. The callers spin on it
 * (fades, palette steps); online the clock only moves with the steps, so each poll that is not there yet moves it one tick. */
uint32_t host_deadline_passed(void)
{
    volatile uint32_t *count = (volatile uint32_t *)GAME_ADDR(ORIG_TICKCOUNT);
    uint32_t until = *(uint32_t *)GAME_ADDR(ORIG_TICKDEADLINE);
    if (*count < until) netplay_vtime_wait(until, 1);
    return *count >= until;
}

__attribute__((naked)) static void wait_deadline_entry(void)
{
    __asm__ volatile(
        "pushal\n\t"
        "call " SYM("host_wait_deadline") "\n\t"
        "popal\n\t"
        "ret");
}

__attribute__((naked)) static void deadline_passed_entry(void)     /* eax the answer (96 clobbers ebx, 97 edx: both kept) */
{
    __asm__ volatile(
        "push %ecx\n\tpush %edx\n\t"
        "call " SYM("host_deadline_passed") "\n\t"
        "pop %edx\n\tpop %ecx\n\t"
        "ret");
}

__attribute__((naked)) static void set_deadline_entry(void)
{
    __asm__ volatile(
        "movl 4(%esp), %eax\n\t"
        "pushal\n\t"
        "push %eax\n\t"
        "call " SYM("host_set_deadline") "\n\t"
        "addl $4, %esp\n\t"
        "popal\n\t"
        "ret");
}

__attribute__((naked)) static void wait_ticks_entry(void)
{
    __asm__ volatile(
        "movl 4(%esp), %eax\n\t"
        "pushal\n\t"
        "push %eax\n\t"
        "call " SYM("host_wait_ticks") "\n\t"
        "addl $4, %esp\n\t"
        "popal\n\t"
        "ret");
}

/* The TGV player waits for vertical retrace before writing a palette chunk (WaitRetrace then 256× outsb to 3C9). The original busy-waits
 * with ~100000 port reads; each `in` is a privilege trap here, so a palette keyframe stalled for seconds and looked like a freeze, and
 * video_present could sample the DAC mid-write (one wrong frame every few seconds). Sleep until the emulated retrace edge instead. */
void host_wait_retrace(void)
{
    int64_t now, ph;
    /* host_allow_irq stays 0: a timer interrupt put into the host while it sleeps here froze the game now and then (the wait is at
     * most two frames; ticks that come meanwhile are queued and taken right after) */
    {                                            /* leave retrace first (the original's loopne; NHL 97 has no mode switch) */
        for (;;) {
            now = intro_skip ? plat_now_ns() * 40 : plat_now_ns();
            ph = now % 14285714LL;
            if (ph >= 1200000) break;
            plat_sleep_ms(0);
        }
    }
    for (;;) {                                   /* enter retrace */
        now = intro_skip ? plat_now_ns() * 40 : plat_now_ns();
        ph = now % 14285714LL;
        if (ph < 1200000) break;
        if (14285714LL - ph > 2000000) plat_sleep_ms((int)((14285714LL - ph) / 1000000));
        else plat_sleep_ms(0);
    }
    video_on_retrace();                     /* apply pending page flip when no TGV palette chunk follows */
    *(uint32_t *)GAME_ADDR(ORIG_RETRACE_COUNT) = 0x186A0;
}

__attribute__((naked)) static void wait_retrace_entry(void)
{
    __asm__ volatile(
        "pushal\n\t"
        "call " SYM("host_wait_retrace") "\n\t"
        "popal\n\t"
        "ret");
}

void osk_hook_install(void);
void install_rdtsc_traps(void);

/* The Watcom start-up (__sys_init_387_emulator, 121AD0) ends with four fldz: it leaves the x87 register stack "4 empty / 4 full",
 * also with a real FPU. EA's hand-written maths needs more than the four registers left: the model loader overflowed the stack while
 * it read the players' chest and shoulder model, a real FPU answers a masked overflow with NaN, and the model's fourth vertex stayed
 * NaN for the whole game. The projection (sub_FFBE0) turned it into x = 80000000h, the polygon was clipped at the left edge of the
 * screen, and each player dragged rows of jersey colour from x = 0 (the "streaks"); the crest on the chest was never drawn right.
 * DOSBox's FPU ignores the overflow and simply overwrites the dummy zeros, so the game works there. The four fldz (121AF3) are
 * replaced by nops in the loaded image: the stack starts empty, and every push lands where DOSBox would have put it.
 * NHL97_X87DUMMIES=1 keeps them (to see the streaks again). */
static void install_x87_stack_fix(void)
{
    static const uint8_t fldz4[8] = { 0xD9, 0xEE, 0xD9, 0xEE, 0xD9, 0xEE, 0xD9, 0xEE };
    uint8_t *p = GAME_ADDR(SYM___sys_init_387_emulator + 0x23);   /* 1.0 121AF3 */
    const char *e = getenv("NHL97_X87DUMMIES");
    if (e && *e && *e != '0') return;
    if (memcmp(p, fldz4, 8) || p[-6] != 0xD9 || p[-5] != 0x2D) { fprintf(stderr, "overrides: the four fldz at 121AF3 not found, not patched\n"); return; }
    memset(p, 0x90, 8);
}

/* WaitTicks (FC2D9) runs the task list (sub_F9A88) until tickcount has moved on by the ticks asked for. Online the clock only
 * moves with the steps (netplay.c), so a WaitTicks inside a step (the sound code's, with the game's sound on) spun for ever. In a
 * session the clock is moved on by those ticks at once and the task list runs once (the same on both machines); otherwise the
 * original runs (its first 10 bytes replayed here). */
uint32_t wt_tick_addr, wt_task, wt_back;   /* read by the stub */
int host_wait_ticks_online(uint32_t ticks)
{
    volatile uint32_t *count = (volatile uint32_t *)GAME_ADDR(ORIG_TICKCOUNT);
    return netplay_vtime_wait(*count + ticks, 0);
}
__attribute__((naked)) static void wait_ticks_online_entry(void)
{
    __asm__ volatile(
        "movl 4(%esp), %eax\n\t"
        "pushal\n\t"
        "push %eax\n\t"
        "call " SYM("host_wait_ticks_online") "\n\t"
        "addl $4, %esp\n\t"
        "testl %eax, %eax\n\t"
        "popal\n\t"
        "je 1f\n\t"
        "pushal\n\t"
        "call *" SYM("wt_task") "\n\t"
        "popal\n\t"
        "ret\n"
        "1:\n\t"
        "movl 4(%esp), %eax\n\t"
        "movl " SYM("wt_tick_addr") ", %edx\n\t"
        "movl (%edx), %edx\n\t"
        "jmp *" SYM("wt_back"));
}
static void install_wait_ticks_online(void)
{
    uint8_t *p = GAME_ADDR(ORIG_WAITTICKS);
    if (p[0] != 0x8B || p[1] != 0x44 || p[2] != 0x24 || p[3] != 0x04 || p[4] != 0x8B || p[5] != 0x15 || p[15] != 0xE8) {
        fprintf(stderr, "overrides: WaitTicks starts %02X %02X, not patched\n", p[0], p[1]); return; }
    wt_tick_addr = (uint32_t)(uintptr_t)GAME_ADDR(ORIG_TICKCOUNT);
    wt_task = (uint32_t)(uintptr_t)(p + 20 + *(int32_t *)(p + 16));
    wt_back = (uint32_t)(uintptr_t)(p + 10);
    patch_jmp(p, wait_ticks_online_entry);
}

/* The streamed EA audio (SCHl..SCEl chunks; sub_4A6F8 and sub_4A74C's two copies of it) hands the next chunk of the stream to sub_108BA0 when
 * sub_3FBE4 returns neither 0 nor -1. sub_3FBE4 also returns -2 (FFFFFFFEh) when the stream has stopped (state 0Eh, set by the
 * stream service sub_3EF68), and sub_108BA0 then reads the chunk header at address -2. The library's own callers skip every small
 * negative answer; these three only skip -1. Online play (states loaded while the sound card and the stream's file go on) reaches
 * the stopped state at once and crashed both machines at the first step. The je after cmp eax,-1 (4A731, 4A87E, 4A9F9) becomes jle:
 * every negative answer is "no chunk". A real chunk is a game address, never negative. */
static void install_stream_guard(void)
{
    const uint32_t at[3] = { SYM_PumpMusicStream + 0x39, SYM_FeedMusicStream_105 + 0x2D, SYM_FeedMusicStream_277 + 0x36 };
    int i;
    for (i = 0; i < 3; i++) {
        uint8_t *p = GAME_ADDR(at[i]);
        if (p[-3] != 0x83 || p[-2] != 0xF8 || p[-1] != 0xFF || p[0] != 0x74 || p[2] != 0xE8) {
            fprintf(stderr, "overrides: the audio stream check at %X not found, not patched\n", (unsigned)at[i]); continue; }
        p[0] = 0x7E;
    }
}

/* A whole game frame on the screen at a time. The game copies each finished frame to the banked screen (BlitFrameToScreen, 1047D0,
 * 640x480 is five 64 KB banks), while the main thread turns the screen memory into a picture whenever it presents. A present that
 * came between two banks showed the top of the new frame over the bottom of the old one: a frame that jumped for a moment now and
 * then, most visible while the camera moves. The copy now holds the video lock (it is recursive: the bank switches inside take it
 * too), so a present waits the fraction of a millisecond the copy takes. The routine is rebuilt here from its own bytes. */
volatile uint32_t blit_funcs, blit_core;
__attribute__((naked)) static void blit_frame_entry(void)
{
    __asm__ volatile(
        "pushal\n\tcall " SYM("video_palette_lock") "\n\tpopal\n\t"
        "pushl %ebx\n\t"
        "movl 8(%esp), %eax\n\tmovl 12(%esp), %edx\n\tmovl " SYM("blit_funcs") ", %ecx\n\tmovl 16(%esp), %ebx\n\t"
        "call *" SYM("blit_core") "\n\t"
        "popl %ebx\n\t"
        "pushal\n\tcall " SYM("video_palette_unlock") "\n\tpopal\n\t"
        "ret");
}
static void install_whole_frames(void)
{
    static const uint8_t head[] = { 0x53, 0x8B, 0x44, 0x24, 0x08, 0x8B, 0x54, 0x24, 0x0C, 0xB9 };
    static const uint8_t mid[] = { 0x8B, 0x5C, 0x24, 0x10, 0xE8 };
    uint8_t *f = GAME_ADDR(SYM_BlitFrameToScreen);
    int32_t rel;
    if (getenv("NHL97_TORN")) return;                          /* a test aid: the old way */
    if (memcmp(f, head, sizeof head) || memcmp(f + 14, mid, sizeof mid) || f[23] != 0x5B || f[24] != 0xC3) {
        fprintf(stderr, "BlitFrameToScreen is not as expected, frames are not kept whole\n");
        return;
    }
    memcpy((void *)&blit_funcs, f + 10, 4);
    memcpy(&rel, f + 19, 4);
    blit_core = (uint32_t)(uintptr_t)(f + 23 + rel);
    patch_jmp(f, (void *)blit_frame_entry);
}

void install_overrides(void)
{
    install_whole_frames();
    osk_hook_install();
#ifdef _WIN32
    patch_jmp(GAME_ADDR(ORIG_SETENVP), setenvp_entry);
#endif
    stub_zero(GAME_ADDR(ORIG_HOOK387));
    stub_zero(GAME_ADDR(ORIG_UNHOOK387));
    stub_zero(GAME_ADDR(ORIG_VIDSAVE));
    stub_zero(GAME_ADDR(ORIG_VIDRESTORE));
    if (GAME_ADDR(ORIG_SETDEADLINE)[0] == 0x8B) patch_jmp(GAME_ADDR(ORIG_SETDEADLINE), set_deadline_entry);
    /* NHL 97's WaitTicks runs the task list (sub_F9A88) while it waits: it is left as it is (the timer interrupt still reaches
     * the game while its code spins). */
    (void)wait_ticks_entry;
    if (GAME_ADDR(ORIG_WAITDEADLINE)[0] == 0xA1) patch_jmp(GAME_ADDR(ORIG_WAITDEADLINE), wait_deadline_entry);
    else fprintf(stderr, "overrides: WaitTickDeadline starts %02X, not patched\n", GAME_ADDR(ORIG_WAITDEADLINE)[0]);
    if (GAME_ADDR(ORIG_DEADLINEPASSED)[0] == 0x8B && (GAME_ADDR(ORIG_DEADLINEPASSED)[1] == 0x1D || GAME_ADDR(ORIG_DEADLINEPASSED)[1] == 0x15))   /* 97: mov edx */
        patch_jmp(GAME_ADDR(ORIG_DEADLINEPASSED), deadline_passed_entry);
    else fprintf(stderr, "overrides: TickDeadlinePassed starts %02X %02X, not patched\n", GAME_ADDR(ORIG_DEADLINEPASSED)[0], GAME_ADDR(ORIG_DEADLINEPASSED)[1]);
    if (GAME_ADDR(ORIG_WAITRETRACE)[0] == 0xBA || (GAME_ADDR(ORIG_WAITRETRACE)[0] == 0x66 && GAME_ADDR(ORIG_WAITRETRACE)[1] == 0xBA))   /* 97: 66 BA DA 03, mov dx */ patch_jmp(GAME_ADDR(ORIG_WAITRETRACE), wait_retrace_entry);
    if (GAME_ADDR(ORIG_WAITRETRACE2)[0] == 0xBA || (GAME_ADDR(ORIG_WAITRETRACE2)[0] == 0x66 && GAME_ADDR(ORIG_WAITRETRACE2)[1] == 0xBA))   /* 97: 66 BA DA 03, mov dx */ patch_jmp(GAME_ADDR(ORIG_WAITRETRACE2), wait_retrace_entry);
    if (GAME_ADDR(ORIG_WAITRETRACE3)[0] == 0xBA || (GAME_ADDR(ORIG_WAITRETRACE3)[0] == 0x66 && GAME_ADDR(ORIG_WAITRETRACE3)[1] == 0xBA))   /* 97: 66 BA DA 03, mov dx */ patch_jmp(GAME_ADDR(ORIG_WAITRETRACE3), wait_retrace_entry);
    install_flag_traps();
    install_rdtsc_traps();
    install_x87_stack_fix();
    install_stream_guard();
    install_wait_ticks_online();
}
