; DOS/4GW: __DPMI_hosted_.
bits 32
%include "hockey.inc"
section s_13AC11 progbits alloc exec nowrite align=1
extern _Extender, DpmiHostedFlag
global __DPMI_hosted_
;-----------------------------------------------------------------------------
; __DPMI_hosted_                                               13AC11  library
; Run-time library: whether the program runs under a DPMI host
;-----------------------------------------------------------------------------
__DPMI_hosted_:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 8
        cmp dword [DpmiHostedFlag], byte 0
        jne near .3
        xor eax, eax
        mov al, byte [_Extender]
        cmp eax, byte 1
        je short .1
        mov ax, 1686h
        int 2Fh
        test ax, ax
        jne short .2
.1:
        mov esi, esp
        xor ah, ah
        xor dl, dl
        mov byte [esp], ah
        xor dh, dh
        mov byte [byte esp+01h], ah
        mov word [byte esp+02h], dx
        mov edx, ds
        mov byte [byte esp+04h], ah
        push ds
        mov ds, edx
        mov ax, 400h
        int 31h
        mov byte [esi], ah
        mov byte [byte esi+01h], al
        mov word [byte esi+02h], bx
        mov byte [byte esi+04h], cl
        mov byte [byte esi+05h], dh
        mov byte [byte esi+06h], dl
        pop ds
        xor eax, eax
        movzx esi, byte [byte esp+01h]
        mov al, byte [esp]
        add eax, esi
        test eax, eax
        jle short .2
        mov dword [DpmiHostedFlag], 1
        jmp short .3
.2:
        mov dword [DpmiHostedFlag], 0FFFFFFFFh
.3:
        mov eax, dword [DpmiHostedFlag]
        add esp, byte 8
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
