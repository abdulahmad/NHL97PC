; EA library: PrintBoxedText.
bits 32
%include "hockey.inc"
section s_1169EE progbits alloc exec nowrite align=1
extern DrawTextBoxedAt, vsprintf_
global PrintBoxedText
        db 00h,00h
;-----------------------------------------------------------------------------
; PrintBoxedText                                 1169F0  97 PC, low confidence
; Formats text like printf and draws it on a box at x, y
;-----------------------------------------------------------------------------
PrintBoxedText:
        push ebx
        sub esp, 104h
        lea eax, [dword esp+0118h]
        lea ebx, [dword esp+0100h]
        mov edx, dword [dword esp+0114h]
        mov dword [dword esp+0100h], eax
        mov eax, esp
        call vsprintf_
        mov edx, dword [dword esp+0110h]
        push edx
        mov ebx, dword [dword esp+0110h]
        push ebx
        lea eax, [byte esp+08h]
        push eax
        call DrawTextBoxedAt
        add esp, byte 0Ch
        xor ecx, ecx
        mov dword [dword esp+0100h], ecx
        add esp, 104h
        pop ebx
        ret
