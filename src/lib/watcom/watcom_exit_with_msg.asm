; Watcom C runtime: __exit_with_msg_, __fatal_runtime_error_.
bits 32
%include "hockey.inc"
section s_121DBA progbits alloc exec nowrite align=1
extern __EnterWVIDEO_, WriteConsoleMessage
global __exit_with_msg_, __fatal_runtime_error_
;-----------------------------------------------------------------------------
; __exit_with_msg_                                             121DBA  library
; Run-time library: prints a message and exits
;-----------------------------------------------------------------------------
__exit_with_msg_:
        jmp near WriteConsoleMessage
;-----------------------------------------------------------------------------
; __fatal_runtime_error_                                       121DBF  library
; Run-time library: prints a fatal run-time error and exits
;-----------------------------------------------------------------------------
__fatal_runtime_error_:
        push ebx
        push ecx
        mov ebx, eax
        mov ecx, edx
        mov edx, ds
        call __EnterWVIDEO_
        test eax, eax
        jne short .1
        mov edx, ecx
        mov eax, ebx
        call WriteConsoleMessage
.1:
        pop ecx
        pop ebx
        ret
