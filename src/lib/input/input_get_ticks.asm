; Input: GetTicks, TicksSince, TicksSinceLast, SetTickDeadline, WaitTickDeadline and 2 more.
bits 32
%include "hockey.inc"
section s_FC280 progbits alloc exec nowrite align=1
extern LastTickCount, RunIdleHandlers, tickcount, tickdeadline
global GetTicks, TicksSince, TicksSinceLast, SetTickDeadline, WaitTickDeadline, TickDeadlinePassed, WaitTicks
;-----------------------------------------------------------------------------
; GetTicks                                     FC280  96 PC, medium confidence
; Returns the timer tick count
;-----------------------------------------------------------------------------
GetTicks:
        mov eax, dword [tickcount]
        ret
;-----------------------------------------------------------------------------
; TicksSince                                   FC286  96 PC, medium confidence
; (start): ticks since the given tick count
;-----------------------------------------------------------------------------
TicksSince:
        mov eax, dword [tickcount]
        sub eax, dword [byte esp+04h]
        ret
;-----------------------------------------------------------------------------
; TicksSinceLast                                  FC290  97 PC, low confidence
; Returns the timer ticks since the last call; followed by the tick reset
;-----------------------------------------------------------------------------
TicksSinceLast:
        mov edx, dword [LastTickCount]
        mov eax, dword [tickcount]
        mov dword [LastTickCount], eax
        LD sub, eax, edx
        ret
        LD xor, eax, eax
        mov dword [tickcount], eax
        ret
;-----------------------------------------------------------------------------
; SetTickDeadline                                                 FC2AB  96 PC
; (ticks): sets the tick deadline that many ticks from now
;-----------------------------------------------------------------------------
SetTickDeadline:
        mov eax, dword [byte esp+04h]
        add eax, dword [tickcount]
        mov dword [tickdeadline], eax
        ret
;-----------------------------------------------------------------------------
; WaitTickDeadline                                                FC2BB  96 PC
; Waits until the tick deadline has passed
;-----------------------------------------------------------------------------
WaitTickDeadline:
        mov eax, dword [tickcount]
        sub eax, dword [tickdeadline]
        js short WaitTickDeadline
        ret
;-----------------------------------------------------------------------------
; TickDeadlinePassed                           FC2C9  96 PC, medium confidence
; Returns 1 when the tick deadline has passed, else 0
;-----------------------------------------------------------------------------
TickDeadlinePassed:
        mov edx, dword [tickcount]
        sub edx, dword [tickdeadline]
        LD sbb, eax, eax
        inc eax
        ret
;-----------------------------------------------------------------------------
; WaitTicks                                                       FC2D9  96 PC
; (ticks): waits that many ticks, running the idle handlers
;-----------------------------------------------------------------------------
WaitTicks:
        mov eax, dword [byte esp+04h]
        mov edx, dword [tickcount]
        LD add, eax, edx
        push eax
        push byte 0
.1:
        call RunIdleHandlers
        mov edx, dword [tickcount]
        sub edx, dword [byte esp+04h]
        js short .1
        add esp, byte 8
        ret
