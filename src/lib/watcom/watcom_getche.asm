; Watcom C runtime: getche_.
bits 32
%include "hockey.inc"
section s_1326EF progbits alloc exec nowrite align=1
extern UngetChar
global getche_
;-----------------------------------------------------------------------------
; getche_                                                      1326EF  library
; Run-time library getche: reads a key and echoes it
;-----------------------------------------------------------------------------
getche_:
        push edx
        xor edx, edx
        mov eax, dword [UngetChar]
        mov dword [UngetChar], edx
        test eax, eax
        jne short .1
        mov ah, 1
        int 21h
        and eax, 0FFh
.1:
        pop edx
        ret
