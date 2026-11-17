; Watcom C runtime: atoi_.
bits 32
%include "hockey.inc"
section s_1194D5 progbits alloc exec nowrite align=1
extern _IsTable
global atoi_
;-----------------------------------------------------------------------------
; atoi_                                                        1194D5  library
; Run-time library atoi: a decimal string to an integer
;-----------------------------------------------------------------------------
atoi_:
        push ebx
        push ecx
        push edx
.1:
        mov dl, byte [eax]
        inc dl
        and edx, 0FFh
        mov dl, byte [dword edx+_IsTable]
        and dl, 2
        and edx, 0FFh
        je short .2
        inc eax
        jmp short .1
.2:
        mov cl, byte [eax]
        mov dl, cl
        cmp edx, byte 2Bh
        je short .3
        cmp edx, byte 2Dh
        jne short .4
.3:
        inc eax
.4:
        xor ebx, ebx
.5:
        mov dl, byte [eax]
        inc dl
        and edx, 0FFh
        mov dl, byte [dword edx+_IsTable]
        and dl, 20h
        and edx, 0FFh
        je short .6
        imul ebx, byte 0Ah
        xor edx, edx
        mov dl, byte [eax]
        add ebx, edx
        inc eax
        sub ebx, byte 30h
        jmp short .5
.6:
        xor eax, eax
        mov al, cl
        cmp eax, byte 2Dh
        jne short .7
        neg ebx
.7:
        mov eax, ebx
        pop edx
        pop ecx
        pop ebx
        ret
