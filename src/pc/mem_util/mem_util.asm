; Memory helpers: cleared blocks, copies and key compares.
bits 32
%include "hockey.inc"
section s_E2269 progbits alloc exec nowrite align=1
extern AllocMemData, bcopy, FreeMemBlock, ZeroMem
global AllocClearBlock, AllocClearBlock20, FreePtr, CopyBytesOk, CopyAndClear, ZeroBytesOk, CompareKeyBytes
        db 00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; AllocClearBlock                                 E2270  97 PC, low confidence
; (tag, size, &ptr): allocates a block (flag 0), clears it and stores it;
; returns 1, or 0 when out of memory
;-----------------------------------------------------------------------------
AllocClearBlock:
        push ecx
        push esi
        mov esi, edx
        push byte 0
        push edx
        push eax
        mov dword [ebx], 0
        call AllocMemData
        add esp, byte 0Ch
        mov dword [ebx], eax
        test eax, eax
        je short .1
        push esi
        push eax
        call ZeroMem
        mov eax, 1
        add esp, byte 8
.1:
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AllocClearBlock20                               E22A0  97 PC, low confidence
; AllocClearBlock with allocation flag 20h
;-----------------------------------------------------------------------------
AllocClearBlock20:
        push ecx
        push esi
        mov esi, edx
        push byte 20h
        push edx
        push eax
        mov dword [ebx], 0
        call AllocMemData
        add esp, byte 0Ch
        mov dword [ebx], eax
        test eax, eax
        je short .1
        push esi
        push eax
        call ZeroMem
        mov eax, 1
        add esp, byte 8
.1:
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FreePtr                                      E22D0  97 PC, medium confidence
; (&ptr): frees the block and clears the pointer; returns 1, or 0 when it was
; already null
;-----------------------------------------------------------------------------
FreePtr:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        mov edx, dword [eax]
        test edx, edx
        je short .1
        push edx
        call FreeMemBlock
        mov eax, 1
        add esp, byte 4
        mov dword [ebx], 0
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        xor eax, eax
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CopyBytesOk                                     E22FC  97 PC, low confidence
; Copies bytes and returns 1
;-----------------------------------------------------------------------------
CopyBytesOk:
        push ecx
        push ebx
        push edx
        push eax
        call bcopy
        mov eax, 1
        add esp, byte 0Ch
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CopyAndClear                                    E2310  97 PC, low confidence
; Copies bytes and clears the rest
;-----------------------------------------------------------------------------
CopyAndClear:
        push ecx
        push esi
        mov esi, eax
        push ebx
        push edx
        push eax
        call bcopy
        add esp, byte 0Ch
        push ebx
        push esi
        call ZeroMem
        mov eax, 1
        add esp, byte 8
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ZeroBytesOk                                     E2334  97 PC, low confidence
; Clears bytes and returns 1
;-----------------------------------------------------------------------------
ZeroBytesOk:
        push ecx
        push edx
        push eax
        call ZeroMem
        mov eax, 1
        add esp, byte 8
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CompareKeyBytes                                 E2348  97 PC, low confidence
; Compares two keys byte by byte
;-----------------------------------------------------------------------------
CompareKeyBytes:
        push ecx
        push esi
.1:
        xor ecx, ecx
        movzx esi, byte [eax]
        mov cl, byte [edx]
        sub esi, ecx
        mov ecx, esi
        jne short .3
        mov esi, ebx
        dec ebx
        test esi, esi
        jle short .3
        mov esi, eax
        mov cl, byte [esi]
        inc eax
        test cl, cl
        jne short .2
        xor eax, eax
        pop esi
        pop ecx
        ret
.2:
        inc edx
        jmp short .1
.3:
        mov eax, ecx
        pop esi
        pop ecx
        nop
        ret
