; Watcom C runtime: __null_int23_exit_, exit_, _exit_.
bits 32
%include "hockey.inc"
section s_1197C7 progbits alloc exec nowrite align=1
extern ExitHook, FpuExitHook, Int23Hook, start_28F
global __null_int23_exit_, exit_, _exit_
;-----------------------------------------------------------------------------
; __null_int23_exit_                                           1197C7  library
; Run-time library: empty Ctrl+C exit hook
;-----------------------------------------------------------------------------
__null_int23_exit_:
        ret
;-----------------------------------------------------------------------------
; exit_                                                        1197C8  library
; Run-time library exit: runs the exit routines and ends the program
;-----------------------------------------------------------------------------
exit_:
        push edx
        mov edx, eax
        call dword [ExitHook]
        call dword [Int23Hook]
        mov eax, edx
        call _exit_
        pop edx
        ret
;-----------------------------------------------------------------------------
; _exit_                                                       1197E0  library
; Run-time library _exit: ends the program at once
;-----------------------------------------------------------------------------
_exit_:
        push edx
        mov edx, eax
        call dword [Int23Hook]
        call dword [FpuExitHook]
        mov eax, edx
        jmp near start_28F
