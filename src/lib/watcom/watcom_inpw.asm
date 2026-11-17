; Watcom C runtime: inpw_.
bits 32
%include "hockey.inc"
section s_13A241 progbits alloc exec nowrite align=1
global inpw_
;-----------------------------------------------------------------------------
; inpw_                                                        13A241  library
; Run-time library inpw: reads a word from an I/O port
;-----------------------------------------------------------------------------
inpw_:
        push edx
        mov edx, eax
        sub eax, eax
        in ax, dx
        pop edx
        ret
