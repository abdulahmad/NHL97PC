; Watcom C runtime: strupr_.
bits 32
%include "hockey.inc"
section s_115874 progbits alloc exec nowrite align=1
global strupr_
;-----------------------------------------------------------------------------
; strupr_                                                      115874  library
; Run-time library strupr: makes a string upper case
;-----------------------------------------------------------------------------
strupr_:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov edx, eax
.1:
        mov al, byte [edx]
        test al, al
        je short .3
        sub al, 61h
        xor ebx, ebx
        mov bl, al
        cmp ebx, byte 19h
        jg short .2
        add al, 41h
        mov byte [edx], al
.2:
        inc edx
        jmp short .1
.3:
        mov eax, ecx
        pop edx
        pop ecx
        pop ebx
        ret
