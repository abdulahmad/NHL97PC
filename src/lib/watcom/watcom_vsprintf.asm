; Watcom C runtime: vsprintf_.
bits 32
%include "hockey.inc"
section s_12226C progbits alloc exec nowrite align=1
extern __prtf_, mem_putc__0
global vsprintf_
;-----------------------------------------------------------------------------
; vsprintf_                                                    12226C  library
; Run-time library vsprintf: formats into a string
;-----------------------------------------------------------------------------
vsprintf_:
        push ecx
        push esi
        mov esi, eax
        mov ecx, mem_putc__0
        call __prtf_
        mov byte [esi+eax], 0
        pop esi
        pop ecx
        ret
