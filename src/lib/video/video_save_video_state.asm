; Video: SaveVideoState, RestoreVideoState.
bits 32
%include "hockey.inc"
section s_138F20 progbits alloc exec nowrite align=1
global SaveVideoState, RestoreVideoState
;-----------------------------------------------------------------------------
; SaveVideoState                                 138F20  97 PC, low confidence
; Saves the BIOS video mode, rows, columns and cursor
;-----------------------------------------------------------------------------
SaveVideoState:
        push esi
        push edi
        push ebp
        LD mov, edi, eax
        LD xor, eax, eax
        mov ax, word [044Ah]
        mov dword [edi], eax
        add edi, byte 4
        LD xor, eax, eax
        mov al, byte [0484h]
        mov dword [edi], eax
        add edi, byte 4
        LD xor, eax, eax
        mov al, byte [0450h]
        mov dword [edi], eax
        add edi, byte 4
        LD xor, eax, eax
        mov al, byte [0451h]
        mov dword [edi], eax
        add edi, byte 4
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; RestoreVideoState                              138F5A  97 PC, low confidence
; Restores the saved BIOS video state
;-----------------------------------------------------------------------------
RestoreVideoState:
        push esi
        push edi
        push ebp
        LD mov, esi, eax
        mov eax, dword [esi]
        add esi, byte 4
        mov eax, dword [esi]
        add esi, byte 4
        mov eax, dword [esi]
        add esi, byte 4
        mov byte [0450h], al
        mov eax, dword [esi]
        add esi, byte 4
        mov byte [0451h], al
        pop ebp
        pop edi
        pop esi
        ret
