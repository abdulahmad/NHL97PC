; Watcom C runtime: __sigabort_, __sigfpe_handler_, signal_, raise_, _chain_intr_ and 1 more.
bits 32
%include "hockey.inc"
section s_13B7B5 progbits alloc exec nowrite align=1
extern __grab_int23_, __grab_int_ctrl_break_, __math1err_, __restore_int23_, __restore_int_ctrl_break_, __set_errno_, __terminate_, AbortHandler
extern SigFpeHandler, SignalHookFpu, SignalTable
global __sigabort_, __sigfpe_handler_, signal_, raise_JumpTable, raise_, raise__2A, raise__3F, raise__4A
global raise__73, raise__96, _chain_intr_, __log87_err_
;-----------------------------------------------------------------------------
; __sigabort_                                                  13B7B5  library
; Run-time library: raises SIGABRT
;-----------------------------------------------------------------------------
__sigabort_:
        mov eax, 1
        jmp near raise_
;-----------------------------------------------------------------------------
; __sigfpe_handler_                                            13B7BF  library
; Run-time library: the floating point exception signal handler
;-----------------------------------------------------------------------------
__sigfpe_handler_:
        push edx
        push esi
        sub esp, byte 4
        mov edx, dword [SigFpeHandler]
        mov dword [esp], edx
        cmp edx, byte 1
        je short .1
        cmp edx, byte 2
        je short .1
        cmp edx, byte 3
        je short .1
        mov esi, 2
        mov edx, eax
        mov eax, esi
        mov dword [SigFpeHandler], esi
        call dword [esp]
.1:
        add esp, byte 4
        pop esi
        pop edx
        ret
;-----------------------------------------------------------------------------
; signal_                                                      13B7F4  library
; Run-time library signal: sets the handler of a signal
;-----------------------------------------------------------------------------
signal_:
        push ebx
        mov ebx, eax
        cmp eax, byte 1
        jl short .1
        cmp eax, byte 0Ch
        jle short .2
.1:
        mov eax, 9
        call __set_errno_
        mov eax, 3
        pop ebx
        ret
.2:
        mov dword [AbortHandler], __sigabort_
        cmp eax, byte 4
        jne short .4
        cmp edx, byte 2
        jne short .3
        call __restore_int23_
        jmp short .7
.3:
        cmp edx, byte 3
        je short .7
        call __grab_int23_
        jmp short .7
.4:
        cmp eax, byte 7
        jne short .6
        cmp edx, byte 2
        jne short .5
        call __restore_int_ctrl_break_
        jmp short .7
.5:
        cmp edx, byte 3
        je short .7
        call __grab_int_ctrl_break_
        jmp short .7
.6:
        cmp eax, byte 2
        jne short .7
        cmp edx, eax
        je short .7
        cmp edx, byte 3
        je short .7
        call SignalHookFpu
.7:
        mov eax, dword [nosplit ebx*4+SignalTable]
        mov dword [nosplit ebx*4+SignalTable], edx
        pop ebx
        ret
raise_JumpTable:                                ; jump table for the switch cases of raise_
        dd raise__3F
        dd raise__2A
        dd raise__96
        dd raise__4A
        dd raise__96
        dd raise__96
        dd raise__73
        dd raise__96
        dd raise__96
        dd raise__96
        dd raise__96
        dd raise__96
;-----------------------------------------------------------------------------
; raise_                                                       13B8A9  library
; Run-time library raise: sends a signal to the program
;-----------------------------------------------------------------------------
raise_:
        push ebx
        push ecx
        push edx
        push edi
        push ebp
        sub esp, byte 4
        mov edx, eax
        shl eax, 2
        mov ebx, dword [dword eax+SignalTable]
        mov dword [esp], ebx
        lea ebx, [byte edx-01h]
        cmp ebx, byte 0Bh
        ja near raise__96.5
        jmp dword [nosplit cs:ebx*4+raise_JumpTable]
raise__2A:
        mov eax, 8Ch
        call __sigfpe_handler_
.1:
        xor eax, eax
.2:
        add esp, byte 4
        pop ebp
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
raise__3F:
        cmp dword [esp], byte 2
        jne short raise__4A
        call __terminate_
raise__4A:
        mov edi, dword [esp]
        cmp edi, byte 1
        je short raise__2A.1
        cmp edi, byte 2
        je short raise__2A.1
        cmp edi, byte 3
        je short raise__2A.1
        mov dword [nosplit edx*4+SignalTable], 2
        call __restore_int23_
.3:
        mov eax, edx
.4:
        call dword [esp]
        jmp short raise__2A.1
raise__73:
        mov ebx, dword [esp]
        cmp ebx, byte 1
        je short raise__2A.1
        cmp ebx, byte 2
        je short raise__2A.1
        cmp ebx, byte 3
        je short raise__2A.1
        mov dword [dword eax+SignalTable], 2
        call __restore_int_ctrl_break_
        jmp short raise__4A.3
raise__96:
        mov ebp, dword [esp]
        cmp ebp, byte 1
        je short raise__2A.1
        cmp ebp, byte 2
        je short raise__2A.1
        cmp ebp, byte 3
        je short raise__2A.1
        mov ecx, 2
        mov eax, edx
        mov dword [nosplit edx*4+SignalTable], ecx
        jmp short raise__4A.4
.5:
        mov eax, 0FFFFFFFFh
        jmp near raise__2A.2
        db 00h
;-----------------------------------------------------------------------------
; _chain_intr_                                                 13B96C  library
; Run-time library _chain_intr: jumps to another interrupt handler
;-----------------------------------------------------------------------------
_chain_intr_:
        mov ecx, eax
        mov eax, edx
        mov esp, ebp
        xchg ecx, dword [byte ebp+028h]
        xchg eax, dword [byte ebp+02Ch]
        pop gs
        pop fs
        pop es
        pop ds
        pop edi
        pop esi
        pop ebp
        pop ebx
        pop ebx
        pop edx
        retf
;-----------------------------------------------------------------------------
; __log87_err_                                                 13B985  library
; Run-time library: reports an x87 log domain error
;-----------------------------------------------------------------------------
__log87_err_:
        push ebp
        mov ebp, esp
        push eax
        push ebx
        push edx
        mov eax, dword [byte ebp+010h]
        and eax, byte 1Fh
        cmp eax, byte 8
        je short .1
        mov edx, dword [byte ebp+0Ch]
        mov ebx, dword [byte ebp+08h]
        test edx, 7FFFFFFFh
        jne short .1
        test ebx, ebx
        jne short .1
        or ax, 1080h
        jmp short .2
.1:
        or ax, 1040h
.2:
        lea edx, [byte ebp+08h]
        call __math1err_
        pop edx
        pop ebx
        pop eax
        pop ebp
        ret 0Ch
        db 00h
