; Video: VesaSetBank, VesaSetModeCall, VgaSetModeNoClear.
bits 32
%include "hockey.inc"
section s_102D3C progbits alloc exec nowrite align=1
extern VesaBank, VesaBankFunc, VesaBankShift
global VesaSetBank, VesaSetBankJumpTable, VesaSetBank_47, VesaSetModeCall, VgaSetModeNoClear
;-----------------------------------------------------------------------------
; VesaSetBank                                    102D3C  97 PC, low confidence
; Switches the VESA bank window when the wanted bank differs
;-----------------------------------------------------------------------------
VesaSetBank:
        cmp al, byte [VesaBankShift]
        je short VesaSetBank_47
        mov byte [VesaBankShift], al
        cmp eax, byte 0
        jl short VesaSetBank_47
        push edx
        mov edx, dword [VesaBank]
        jmp dword [nosplit edx*4+VesaSetBankJumpTable]
VesaSetBankJumpTable:                           ; jump table for the switch cases of VesaSetBank
        dd .1
        dd VesaSetBank_47.2
.1:
        push ebx
        push ecx
        push ebp
        push esi
        push edi
        mov ecx, dword [VesaBankFunc]
        shl al, cl
        movzx edx, al
        mov eax, 4F05h
        LD xor, ebx, ebx
        int 10h
        pop edi
        pop esi
        pop ebp
        pop ecx
        pop ebx
        pop edx
VesaSetBank_47:
        ret
.2:
        push ebx
        push ecx
        push ebp
        push esi
        push edi
        mov ecx, dword [VesaBankFunc]
        shl al, cl
        movzx edx, al
        push edx
        mov eax, 4F05h
        LD xor, ebx, ebx
        int 10h
        pop edx
        mov eax, 4F05h
        mov ebx, 1
        int 10h
        pop edi
        pop esi
        pop ebp
        pop ecx
        pop ebx
        pop edx
        ret
;-----------------------------------------------------------------------------
; VesaSetModeCall                                102DB2  97 PC, low confidence
; Calls the VESA BIOS to set a mode
;-----------------------------------------------------------------------------
VesaSetModeCall:
        push ebx
        mov ebx, dword [byte esp+08h]
        mov ax, 4F02h
        push ebp
        db 056h                                 ; insn: push esi
        db 057h                                 ; insn: push edi
        int 10h
        pop edi
        pop esi
        pop ebp
        pop ebx
        ret
;-----------------------------------------------------------------------------
; VgaSetModeNoClear                              102DC5  97 PC, low confidence
; Sets a VGA BIOS mode without clearing video memory
;-----------------------------------------------------------------------------
VgaSetModeNoClear:
        push ebp
        push esi
        push edi
        mov eax, 92h
        int 10h
        mov eax, dword [byte esp+010h]
        int 10h
        pop edi
        pop esi
        pop ebp
        ret
        push ebx
        push ebp
        push esi
        push edi
        push ecx
        LD mov, ecx, eax
        mov eax, 4F07h
        mov ebx, 0
        int 10h
        pop ecx
        pop edi
        pop esi
        pop ebp
        pop ebx
        ret
        push ebx
        push ebp
        push esi
        push edi
        push ecx
        movzx ebx, al
        movzx edx, dx
        mov eax, 4F05h
        int 10h
        pop ecx
        pop edi
        pop esi
        pop ebp
        pop ebx
        ret
