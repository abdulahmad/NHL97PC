; Watcom C runtime: toupper_.
bits 32
%include "hockey.inc"
section s_1269F5 progbits alloc exec nowrite align=1
global toupper_
;-----------------------------------------------------------------------------
; toupper_                                                     1269F5  library
; Run-time library toupper: a character to upper case
;-----------------------------------------------------------------------------
toupper_:
        cmp eax, byte 61h
        jl short .1
        cmp eax, byte 7Ah
        jg short .1
        sub eax, byte 20h
.1:
        ret
