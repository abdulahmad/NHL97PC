/* Online play is not wired into NHL 97 yet: the NHL 96 port's netplay.c hooks the game loop at 96 addresses (its input records,
 * the in-game menu, the period end), which 97 has elsewhere. Until those are found, the host runs without it: no Online page,
 * the game clock is the timer interrupt's. Rollback comes back through Overbar's ob_net / ob_netgame with 97's own hooks. */
#include "host.h"
#include "overbar_client.h"

void netplay_install(void) {}
void netplay_main_poll(void) {}
int netplay_vtime_wait(uint32_t until, int one) { (void)until; (void)one; return 0; }
int netplay_running(void) { return 0; }
void netplay_online_setup(ob_host *h) { (void)h; }
void snap_set_stack_base(void *base) { (void)base; }
volatile int nh_quiet;
