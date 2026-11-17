; Video: VesaSetMode, VesaSetWindow.
bits 32
%include "hockey.inc"
section s_10312F progbits alloc exec nowrite align=1
extern int386_, ModeTableNumber, VesaGetModeInfo, VesaSetModeCall, VesaWindowActive, VgaSetModeNoClear, VideoModeIndex
global VesaSetMode, VesaSetWindow
        db 090h
;-----------------------------------------------------------------------------
; VesaSetMode                                    103130  97 PC, low confidence
; Sets a VESA mode, or a VGA mode below 100h
;-----------------------------------------------------------------------------
VesaSetMode:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, 100h
        shl eax, 4
        mov esi, dword [dword eax+ModeTableNumber]
        cmp esi, 100h
        jge short .1
        push byte 13h
        mov ebx, 1
        call VgaSetModeNoClear
        add esp, byte 4
        jmp short .3
.1:
        mov edx, esp
        mov eax, esi
        call VesaGetModeInfo
        mov ebx, eax
        test eax, eax
        je short .3
        mov edx, dword [VideoModeIndex]
        xor ebx, eax
        test edx, edx
        je short .2
        test byte [esp], 80h
        je short .2
        mov eax, esi
        or ah, 0C0h
        push eax
        call VesaSetModeCall
        add esp, byte 4
        cmp ax, 4Fh
        jne short .2
        mov ebx, 2
.2:
        test ebx, ebx
        jne short .3
        or si, 8000h
        push esi
        call VesaSetModeCall
        add esp, byte 4
        cmp ax, 4Fh
        jne short .3
        mov ebx, 1
.3:
        mov eax, ebx
        add esp, 100h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; VesaSetWindow                                  1031C0  97 PC, low confidence
; Moves the VESA bank window to a given position
;-----------------------------------------------------------------------------
VesaSetWindow:
        push ebx
        sub esp, byte 1Ch
        cmp dword [VesaWindowActive], byte 0
        jne short .2
        mov ebx, 800h
        mov word [byte esp+08h], ax
        mov word [esp], bx
        mov ebx, eax
        mov word [byte esp+014h], dx
        sar ebx, 10h
        mov eax, edx
        mov edx, esp
        mov word [byte esp+04h], bx
        sar eax, 10h
        mov ebx, esp
        mov word [byte esp+010h], ax
        mov eax, 31h
        call int386_
        cmp dword [byte esp+018h], byte 0
        je short .1
        xor eax, eax
        add esp, byte 1Ch
        pop ebx
        ret
.1:
        xor eax, eax
        xor edx, edx
        mov ax, word [byte esp+04h]
        mov dx, word [byte esp+08h]
        shl eax, 10h
        add eax, edx
        mov dword [VesaWindowActive], eax
.2:
        mov eax, dword [VesaWindowActive]
        add esp, byte 1Ch
        pop ebx
        ret
