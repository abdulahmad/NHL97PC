; Watcom C runtime: strncmp_.
bits 32
%include "hockey.inc"
section s_1131E4 progbits alloc exec nowrite align=1
global strncmp_
;-----------------------------------------------------------------------------
; strncmp_                                                     1131E4  library
; Run-time library strncmp: compares at most n characters
;-----------------------------------------------------------------------------
strncmp_:
        push ecx
.1:
        test ebx, ebx
        jne short .3
.2:
        xor eax, eax
        pop ecx
        ret
.3:
        mov cl, byte [eax]
        mov ch, byte [edx]
        cmp cl, ch
        je short .4
        xor ebx, ebx
        xor eax, eax
        mov bl, cl
        mov al, ch
        sub ebx, eax
        mov eax, ebx
        pop ecx
        ret
.4:
        cmp byte [eax], 0
        je short .2
        inc eax
        inc edx
        dec ebx
        jmp short .1
