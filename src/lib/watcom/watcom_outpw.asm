; Watcom C runtime: outpw_.
bits 32
%include "hockey.inc"
section s_13A2B7 progbits alloc exec nowrite align=1
global outpw_
;-----------------------------------------------------------------------------
; outpw_                                                       13A2B7  library
; Run-time library outpw: writes a word to an I/O port
;-----------------------------------------------------------------------------
outpw_:
        push ebx
        mov ebx, eax
        mov eax, edx
        mov edx, ebx
        out dx, ax
        pop ebx
        ret
