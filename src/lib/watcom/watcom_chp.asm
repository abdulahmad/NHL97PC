; Watcom C runtime: __CHP, SaveStackSegment, __CHK, __GRO, __STK.
bits 32
%include "hockey.inc"
section s_FC21A progbits alloc exec nowrite align=1
extern __fatal_runtime_error_, _STACKLOW, SavedStackSegment, str_StackOverflow
global __CHP, SaveStackSegment, __CHK, __GRO, __STK
;-----------------------------------------------------------------------------
; __CHP                                                         FC21A  library
; Run-time library: rounds the x87 top of stack to an integer (chop)
;-----------------------------------------------------------------------------
__CHP:
        push eax
        wait
        fnstcw word [esp]
        wait
        push dword [esp]
        mov byte [byte esp+01h], 1Fh
        fldcw word [esp]
        frndint
        fldcw word [byte esp+04h]
        wait
        lea esp, [byte esp+08h]
        ret
        db 00h
;-----------------------------------------------------------------------------
; SaveStackSegment                                FC238  97 PC, low confidence
; Records the stack segment at start-up
;-----------------------------------------------------------------------------
SaveStackSegment:
        o16 mov word [SavedStackSegment], ss
        ret
;-----------------------------------------------------------------------------
; __CHK                                                         FC240  library
; Run-time library: stack overflow check
;-----------------------------------------------------------------------------
__CHK:
        xchg eax, dword [byte esp+04h]
        call __STK
        mov eax, dword [byte esp+04h]
        ret 4
;-----------------------------------------------------------------------------
; __GRO                                                         FC250  library
; Run-time library: stack grow check
;-----------------------------------------------------------------------------
__GRO:
        ret 4
;-----------------------------------------------------------------------------
; __STK                                                         FC253  library
; Run-time library: stack check on routine entry
;-----------------------------------------------------------------------------
__STK:
        cmp eax, esp
        jae short .1
        sub eax, esp
        neg eax
        cmp eax, dword [_STACKLOW]
        jbe short .1
        ret
.1:
        mov ax, ss
        cmp ax, word [SavedStackSegment]
        je short .2
        ret
.2:
        mov eax, str_StackOverflow
        mov edx, 1
        call __fatal_runtime_error_
