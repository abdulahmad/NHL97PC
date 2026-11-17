; EA library: CreateBitmapFromBlock, CreateBitmapForMem, CreateBitmapCore, SinLookup, CosLookup.
bits 32
%include "hockey.inc"
section s_1258A3 progbits alloc exec nowrite align=1
extern AllocMemBlockEx, bcopy, CompactMemListDown, CompactMemListUp, findmemblock, memlist1, MemLock, MemLockHandle
extern MemUnlock, PushMemDescriptor, SetBlockGuard, SinTable, str_RESIZE
global CreateBitmapFromBlock, CreateBitmapForMem, CreateBitmapCore, SinLookup, CosLookup
        db 090h
;-----------------------------------------------------------------------------
; CreateBitmapFromBlock                          1258A4  97 PC, low confidence
; Finds a memory block and creates a bitmap header for it; followed by the
; variant that does not mark it shared
;-----------------------------------------------------------------------------
CreateBitmapFromBlock:
        push ebx
        push byte 1
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        call findmemblock
        add esp, byte 4
        push eax
        call CreateBitmapCore
        add esp, byte 0Ch
        pop ebx
        ret
        push ebx
        push byte 0
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        call findmemblock
        add esp, byte 4
        push eax
        call CreateBitmapCore
        add esp, byte 0Ch
        pop ebx
        ret
        push ebx
        push byte 1
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        call CreateBitmapCore
        add esp, byte 0Ch
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CreateBitmapForMem                             1258FC  97 PC, low confidence
; Creates a bitmap header for memory the caller already holds
;-----------------------------------------------------------------------------
CreateBitmapForMem:
        push ebx
        push byte 0
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        call CreateBitmapCore
        add esp, byte 0Ch
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CreateBitmapCore                               125914  97 PC, low confidence
; Allocates the bitmap descriptor in its memory list and fills in size, depth
; and pixel pointer
;-----------------------------------------------------------------------------
CreateBitmapCore:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov edi, dword [byte esp+01Ch]
        mov eax, dword [byte edi+018h]
        and eax, 0F00h
        shr eax, 8
        mov edx, dword [MemLockHandle]
        mov dword [esp], eax
        mov esi, eax
        shl eax, 2
        push edx
        sub eax, esi
        mov esi, memlist1
        shl eax, 3
        mov ebx, edi
        add esi, eax
        call MemLock
        add esp, byte 4
        mov eax, dword [byte edi+020h]
        mov ecx, dword [edi]
        mov ebp, dword [byte esi+08h]
        mov eax, dword [eax]
        mov edx, dword [byte esi+014h]
        mov edi, eax
        mov eax, dword [byte esp+020h]
        sub edi, ecx
        mov ecx, dword [byte esi+08h]
        add eax, edx
        not ebp
        add eax, ecx
        and edi, ebp
        and ebp, eax
        mov eax, dword [byte esp+020h]
        test eax, eax
        jge short .1
        mov ebp, eax
        cmp eax, byte 0FFFFFFFFh
        je short .1
        mov esi, dword [MemLockHandle]
        push esi
        call MemUnlock
        add esp, byte 4
        jmp near .9
.1:
        xor ecx, ecx
        mov dword [byte esp+04h], ecx
.2:
        cmp ebp, edi
        jg short .4
        test ebp, ebp
        jl short .4
        mov eax, dword [byte esp+020h]
        mov dword [byte ebx+010h], ebp
        mov dword [byte ebx+014h], eax
        cmp dword [byte esi+014h], byte 0
        je short .3
        push ebx
        call SetBlockGuard
        add esp, byte 4
.3:
        mov esi, dword [MemLockHandle]
        push esi
        call MemUnlock
        add esp, byte 4
        mov eax, dword [byte esp+020h]
        jmp near .10
.4:
        mov eax, dword [byte ebx+020h]
        test byte [byte eax+018h], 18h
        je short .7
        cmp dword [byte esp+04h], byte 0
        jne short .7
        push ebx
        mov ecx, dword [byte esi+04h]
        push ecx
        call CompactMemListDown
        add esp, byte 8
        test eax, eax
        je short .6
.5:
        mov eax, dword [byte ebx+020h]
        mov edx, dword [ebx]
        mov edi, dword [byte esi+08h]
        mov eax, dword [eax]
        not edi
        sub eax, edx
        and edi, eax
        jmp short .2
.6:
        mov dword [byte esp+04h], 1
        jmp short .2
.7:
        test byte [byte ebx+018h], 10h
        je near .8
        mov edx, dword [byte ebx+020h]
        push edx
        mov ecx, dword [esi]
        push ecx
        call CompactMemListUp
        add esp, byte 8
        test eax, eax
        jne short .5
        push eax
        mov esi, dword [byte esp+04h]
        push esi
        mov ebp, dword [byte esp+028h]
        push ebp
        push str_RESIZE
        call AllocMemBlockEx
        mov esi, eax
        add esp, byte 10h
        test eax, eax
        je short .8
        mov ecx, dword [byte ebx+014h]
        push ecx
        mov edi, dword [eax]
        push edi
        mov ebp, dword [ebx]
        push ebp
        call bcopy
        mov edi, dword [byte ebx+024h]
        mov eax, dword [byte ebx+020h]
        mov dword [byte edi+020h], eax
        mov edi, dword [byte ebx+024h]
        mov dword [byte eax+024h], edi
        mov eax, dword [byte esi+024h]
        mov dword [byte eax+020h], ebx
        mov eax, dword [byte esi+020h]
        mov dword [byte eax+024h], ebx
        mov eax, dword [esi]
        mov dword [ebx], eax
        mov eax, dword [byte esi+020h]
        mov dword [byte ebx+020h], eax
        mov eax, dword [byte esi+024h]
        mov dword [byte ebx+024h], eax
        mov eax, dword [byte esi+014h]
        mov dword [byte ebx+014h], eax
        add esp, byte 0Ch
        mov eax, dword [byte esi+010h]
        push esi
        mov dword [byte ebx+010h], eax
        call PushMemDescriptor
        add esp, byte 4
        mov eax, dword [MemLockHandle]
        push eax
        call MemUnlock
        add esp, byte 4
        mov eax, dword [byte esp+020h]
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.8:
        mov eax, dword [MemLockHandle]
        push eax
        call MemUnlock
        add esp, byte 4
        cmp dword [byte esp+020h], byte 0
        jge short .9
        mov eax, edi
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.9:
        xor eax, eax
.10:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SinLookup                                      125AE0  97 PC, low confidence
; Returns the sine of a 10-bit angle from the quarter-wave table
;-----------------------------------------------------------------------------
SinLookup:
        mov eax, dword [byte esp+04h]
        shl ah, 7
        LD sbb, edx, edx
        LD add, ah, ah
        LD sbb, ecx, ecx
        LD xor, eax, ecx
        and eax, 0FFh
        LD sub, eax, ecx
        mov eax, dword [nosplit eax*4+SinTable]
        LD xor, eax, edx
        LD sub, eax, edx
        ret
;-----------------------------------------------------------------------------
; CosLookup                                      125B02  97 PC, low confidence
; Returns the cosine of a 10-bit angle from the quarter-wave table
;-----------------------------------------------------------------------------
CosLookup:
        mov eax, dword [byte esp+04h]
        lea ecx, [dword eax+0100h]
        shl ch, 7
        LD sbb, edx, edx
        LD add, ch, ch
        LD sbb, ecx, ecx
        LD xor, eax, ecx
        and eax, 0FFh
        LD sub, eax, ecx
        mov eax, dword [nosplit eax*4+SinTable]
        LD xor, eax, edx
        LD sub, eax, edx
        ret
        db 00h,00h
        mul edx
        mov dword [esi], eax
        mov dword [byte esi+04h], edx
        ret
        imul edx
        mov dword [esi], eax
        mov dword [byte esi+04h], edx
        ret
