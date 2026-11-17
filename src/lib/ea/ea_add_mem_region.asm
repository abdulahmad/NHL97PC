; EA library: AddMemRegion, AddMemRegions, AddHighMemRegion, TrimMemList, MemListEnd and 5 more.
bits 32
%include "hockey.inc"
section s_FA5B8 progbits alloc exec nowrite align=1
extern AllocMemBlockEx, MemBlockGuards, MemDescriptorTop, memlist1, MemListEndFunc, MemLock, MemLockHandle, MemUnlock
extern PresentScreen, sprintf_, str_GAP, str_HIGHMEM, str_LOW8s, strncpy_
global AddMemRegion, AddMemRegions, AddHighMemRegion, TrimMemList, MemListEnd, AllocMemBlockFixed, AllocMemBlockMovable, AllocMemBlock
global AllocMemData, AllocMemBlockFull
;-----------------------------------------------------------------------------
; AddMemRegion                                    FA5B8  97 PC, low confidence
; Adds a region of memory to a memory list as a named LOW block range
;-----------------------------------------------------------------------------
AddMemRegion:
        push ebx
        push esi
        mov ecx, dword [byte esp+010h]
        mov ebx, ecx
        and ebx, 0F00h
        sar ebx, 8
        lea edx, [nosplit ebx*4+00h]
        sub edx, ebx
        mov ebx, memlist1
        shl edx, 3
        mov eax, dword [byte esp+01Ch]
        add ebx, edx
        dec eax
        mov dword [byte ebx+08h], eax
        mov eax, dword [byte esp+020h]
        dec eax
        mov dword [byte ebx+0Ch], eax
        mov eax, dword [byte esp+024h]
        mov edx, dword [byte esp+028h]
        mov dword [byte ebx+010h], eax
        test edx, edx
        je short .1
        mov edx, 4
.1:
        mov esi, dword [byte esp+0Ch]
        mov dword [byte ebx+014h], edx
        mov edx, dword [MemDescriptorTop]
        push esi
        mov eax, dword [byte edx+020h]
        push str_LOW8s
        mov dword [MemDescriptorTop], eax
        lea eax, [byte edx+04h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov dword [byte edx+014h], 0
        mov eax, dword [byte esp+014h]
        mov dword [edx], eax
        mov eax, dword [byte edx+014h]
        mov dword [byte edx+010h], eax
        mov eax, ecx
        mov dword [byte edx+024h], 0
        or ah, 80h
        mov dword [byte edx+018h], eax
        mov dword [ebx], edx
        mov edx, dword [MemDescriptorTop]
        push esi
        mov eax, dword [byte edx+020h]
        push str_HIGHMEM
        mov dword [MemDescriptorTop], eax
        lea eax, [byte edx+04h]
        push eax
        call sprintf_
        mov dword [byte edx+014h], 0
        or cx, 8020h
        mov dword [byte edx+020h], 0
        add esp, byte 0Ch
        mov dword [byte edx+018h], ecx
        mov eax, dword [byte esp+018h]
        mov dword [edx], eax
        mov eax, dword [byte edx+014h]
        mov dword [byte edx+010h], eax
        mov eax, dword [ebx]
        mov dword [byte ebx+04h], edx
        mov dword [byte eax+020h], edx
        mov eax, dword [ebx]
        mov dword [byte edx+024h], eax
        mov eax, ebx
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; AddMemRegions                                   FA6A0  97 PC, low confidence
; Adds each region of a list of memory areas to the memory lists
;-----------------------------------------------------------------------------
AddMemRegions:
        push ebx
        push esi
        push edi
        push ebp
        mov edx, dword [byte esp+018h]
        and edx, 0F00h
        sar edx, 8
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, dword [byte esp+034h]
        push edx
        mov ecx, dword [byte esp+034h]
        push ecx
        mov esi, dword [byte esp+034h]
        mov ebx, memlist1
        push esi
        mov edi, dword [byte esp+034h]
        mov ebp, dword [byte esp+030h]
        push edi
        shl eax, 3
        push ebp
        add ebx, eax
        mov eax, dword [byte esp+034h]
        push eax
        mov edx, dword [byte esp+034h]
        push edx
        mov ecx, dword [byte esp+030h]
        push ecx
        call AddMemRegion
        mov ecx, dword [ebx]
        mov edx, dword [byte ebx+04h]
        add esp, byte 20h
        mov ecx, dword [ecx]
        mov edi, dword [edx]
        mov esi, eax
        cmp ecx, edi
        jne short .1
        mov edx, dword [eax]
        mov dword [ebx], edx
        jmp short .2
.1:
        mov ecx, dword [eax]
        mov dword [byte edx+020h], ecx
        mov edx, ecx
        mov ecx, dword [byte ebx+04h]
        mov dword [byte edx+024h], ecx
        mov edx, dword [eax]
        mov ebp, dword [ecx]
        mov edx, dword [edx]
        sub edx, ebp
        mov dword [byte ecx+010h], edx
        mov ecx, dword [byte ebx+04h]
        mov dword [byte ecx+014h], edx
.2:
        mov eax, dword [byte eax+04h]
        mov dword [byte ebx+04h], eax
        mov eax, esi
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AddHighMemRegion                                FA734  97 PC, low confidence
; Adds the HIGHMEM region to a memory list with a GAP block for the hole
; below it
;-----------------------------------------------------------------------------
AddHighMemRegion:
        push ebx
        push esi
        push edi
        mov edx, dword [byte esp+014h]
        mov eax, edx
        and eax, 0F00h
        sar eax, 8
        lea ecx, [nosplit eax*4+00h]
        sub ecx, eax
        mov esi, memlist1
        shl ecx, 3
        mov ebx, dword [byte esp+010h]
        add esi, ecx
        mov ecx, dword [MemDescriptorTop]
        push ebx
        mov eax, dword [byte ecx+020h]
        push str_HIGHMEM
        mov dword [MemDescriptorTop], eax
        lea eax, [byte ecx+04h]
        push eax
        call sprintf_
        mov dword [byte ecx+014h], 0
        mov dword [byte ecx+010h], 0
        or dx, 8020h
        mov dword [byte ecx+020h], 0
        add esp, byte 0Ch
        mov dword [byte ecx+018h], edx
        mov eax, dword [byte esp+01Ch]
        mov dword [ecx], eax
        mov ebx, 0Ch
        mov eax, dword [byte esi+04h]
        mov edx, str_GAP
        add eax, byte 4
        call strncpy_
        mov eax, dword [byte esi+04h]
        mov dword [byte eax+020h], ecx
        mov eax, dword [byte esi+04h]
        mov dword [byte ecx+024h], eax
        mov edx, dword [byte esp+018h]
        mov edi, dword [eax]
        sub edx, edi
        mov dword [byte eax+010h], edx
        mov eax, edx
        mov edx, dword [byte ecx+024h]
        mov dword [byte edx+014h], eax
        mov dword [byte esi+04h], ecx
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push esi
        push edi
        push ebp
        mov edi, dword [MemDescriptorTop]
        mov ecx, dword [byte esp+018h]
        mov edx, dword [byte esp+014h]
        and edx, 0F00h
        sar edx, 8
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov ebx, memlist1
        shl eax, 3
        add ebx, eax
        mov eax, dword [ebx]
        cmp eax, dword [byte ebx+04h]
        je short .2
.1:
        mov edx, dword [eax]
        add edx, dword [byte eax+010h]
        cmp ecx, edx
        je short .2
        mov eax, dword [byte eax+020h]
        cmp eax, dword [byte ebx+04h]
        jne short .1
.2:
        mov edx, dword [byte eax+020h]
        mov esi, dword [eax]
        mov ecx, dword [edx]
        mov ebp, dword [byte eax+010h]
        sub ecx, esi
        mov esi, dword [byte ebx+04h]
        sub ecx, ebp
        cmp edx, esi
        jne short .3
        mov dword [byte eax+010h], 0
        mov dword [byte eax+020h], 0
        mov esi, dword [byte eax+010h]
        mov dword [byte eax+014h], esi
        mov dword [byte ebx+04h], eax
        jmp short .4
.3:
        mov esi, dword [edx]
        mov ebp, dword [byte edx+010h]
        add ebp, esi
        mov esi, dword [eax]
        sub ebp, esi
        mov dword [byte eax+010h], ebp
        mov dword [byte eax+014h], ebp
        mov esi, dword [byte edx+020h]
        mov dword [byte eax+020h], esi
        mov dword [byte edx+024h], eax
.4:
        mov dword [byte edx+020h], edi
        mov ebp, dword [ebx]
        mov edi, edx
        cmp eax, ebp
        jne short .5
        mov dword [byte ebp+010h], 0
        mov edx, dword [byte ebp+010h]
        mov dword [byte ebp+014h], edx
.5:
        mov eax, dword [ebx]
        cmp eax, dword [byte ebx+04h]
        jne short .6
        mov eax, dword [ebx]
        mov dword [byte eax+020h], edi
        mov dword [byte ebx+04h], 0
        mov edi, eax
        mov eax, dword [byte ebx+04h]
        mov dword [ebx], eax
.6:
        mov eax, ecx
        mov dword [MemDescriptorTop], edi
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; TrimMemList                                     FA8AC  97 PC, low confidence
; Releases the last block of a memory list and returns how much space it
; freed
;-----------------------------------------------------------------------------
TrimMemList:
        push ebx
        push esi
        push edi
        push ebp
        mov edx, dword [byte esp+014h]
        and edx, 0F00h
        sar edx, 8
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, memlist1
        shl eax, 3
        add edx, eax
        mov ebx, dword [byte edx+04h]
        test ebx, ebx
        jne short .1
        mov eax, 0FFFFFFFFh
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.1:
        mov eax, dword [byte ebx+024h]
        mov ecx, dword [ebx]
        mov esi, dword [eax]
        mov edi, dword [byte eax+010h]
        mov dword [byte eax+020h], 0
        sub ecx, esi
        mov dword [byte eax+010h], 0
        mov esi, ecx
        mov ecx, dword [byte eax+010h]
        mov dword [byte eax+014h], ecx
        mov ecx, dword [MemDescriptorTop]
        mov dword [byte edx+04h], eax
        mov dword [byte ebx+020h], ecx
        sub esi, edi
        mov ebp, dword [edx]
        mov dword [MemDescriptorTop], ebx
        cmp eax, ebp
        jne short .2
        mov dword [byte ebp+020h], ebx
        mov dword [byte edx+04h], 0
        mov eax, dword [byte edx+04h]
        mov dword [MemDescriptorTop], ebp
        mov dword [edx], eax
.2:
        mov eax, esi
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        mov ebx, dword [byte esp+08h]
.3:
        push ebx
        call TrimMemList
        add esp, byte 4
        cmp eax, byte 0FFFFFFFFh
        jne short .3
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; MemListEnd                                      FA954  97 PC, low confidence
; Returns the end address of the last block of a memory list; followed by the
; free slot search
;-----------------------------------------------------------------------------
MemListEnd:
        mov edx, dword [byte esp+04h]
        and edx, 0F00h
        sar edx, 8
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, memlist1
        mov edx, dword [byte eax+04h]
        test edx, edx
        jne short .1
        xor eax, eax
        ret
.1:
        mov eax, dword [byte edx+024h]
        mov edx, dword [eax]
        mov eax, dword [byte eax+010h]
        add eax, edx
        ret
        db 090h
        push ebx
        mov ebx, dword [MemBlockGuards]
        xor edx, edx
        xor eax, eax
        test ebx, ebx
        jne short .3
.2:
        mov eax, edx
        shl eax, 8
        pop ebx
        ret
.3:
        add eax, byte 18h
        inc edx
        cmp eax, 180h
        jge short .4
        cmp dword [dword eax+MemBlockGuards], byte 0
        je short .2
        jmp short .3
.4:
        xor eax, eax
        pop ebx
        ret
        mov dword [MemListEndFunc], PresentScreen
        ret
        db 090h
;-----------------------------------------------------------------------------
; AllocMemBlockFixed                              FA9C4  97 PC, low confidence
; Allocates a named block under the memory lock with the fixed flag set
;-----------------------------------------------------------------------------
AllocMemBlockFixed:
        push ebx
        push esi
        push edi
        push ebp
        mov ebp, dword [byte esp+014h]
        mov edi, dword [byte esp+018h]
        mov ebx, dword [byte esp+01Ch]
        mov edx, dword [MemLockHandle]
        mov esi, 1
        test edx, edx
        je short .1
        push edx
        call MemLock
        add esp, byte 4
.1:
        push esi
        push ebx
        push edi
        push ebp
        call AllocMemBlockEx
        mov esi, dword [MemLockHandle]
        add esp, byte 10h
        mov ebx, eax
        test esi, esi
        je short .2
        push esi
        call MemUnlock
        add esp, byte 4
.2:
        mov eax, ebx
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AllocMemBlockMovable                            FAA14  97 PC, low confidence
; Allocates a named block under the memory lock without the fixed flag
;-----------------------------------------------------------------------------
AllocMemBlockMovable:
        push ebx
        push esi
        push edi
        push ebp
        mov ebp, dword [byte esp+014h]
        mov edi, dword [byte esp+018h]
        mov ebx, dword [byte esp+01Ch]
        mov edx, dword [MemLockHandle]
        xor esi, esi
        test edx, edx
        je short .1
        push edx
        call MemLock
        add esp, byte 4
.1:
        push esi
        push ebx
        push edi
        push ebp
        call AllocMemBlockEx
        mov esi, dword [MemLockHandle]
        add esp, byte 10h
        mov ebx, eax
        test esi, esi
        je short .2
        push esi
        call MemUnlock
        add esp, byte 4
.2:
        mov eax, ebx
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; AllocMemBlock                                                   FAA64  95 PC
; Memory manager: allocate a named block (name, size, flags), e.g. "DMAN",
; "HIST"; under the memory lock
;-----------------------------------------------------------------------------
AllocMemBlock:
        push ebx
        push esi
        push edi
        push ebp
        mov edi, dword [byte esp+014h]
        mov ebp, dword [byte esp+018h]
        mov ebx, dword [byte esp+01Ch]
        mov edx, dword [MemLockHandle]
        mov esi, 1
        test edx, edx
        je short .1
        push edx
        call MemLock
        add esp, byte 4
.1:
        push esi
        push ebx
        push ebp
        push edi
        call AllocMemBlockEx
        mov esi, dword [MemLockHandle]
        add esp, byte 10h
        mov ebx, eax
        test esi, esi
        je short .2
        push esi
        call MemUnlock
        add esp, byte 4
.2:
        mov eax, dword [ebx]
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AllocMemData                                    FAAB4  97 PC, low confidence
; Allocates a named block under the memory lock and returns its data pointer
;-----------------------------------------------------------------------------
AllocMemData:
        push ebx
        push esi
        push edi
        push ebp
        mov ebp, dword [byte esp+014h]
        mov esi, dword [byte esp+018h]
        mov edi, dword [byte esp+01Ch]
        mov edx, dword [MemLockHandle]
        xor ebx, ebx
        test edx, edx
        je short .1
        push edx
        call MemLock
        add esp, byte 4
.1:
        push ebx
        push edi
        push esi
        push ebp
        call AllocMemBlockEx
        mov esi, dword [MemLockHandle]
        add esp, byte 10h
        mov ebx, eax
        test esi, esi
        je short .2
        push esi
        call MemUnlock
        add esp, byte 4
.2:
        test ebx, ebx
        je short .3
        mov eax, dword [ebx]
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.3:
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        push ebx
        push esi
        push edi
        push ebp
        mov ebp, dword [byte esp+014h]
        mov edi, dword [byte esp+018h]
        mov esi, dword [byte esp+01Ch]
        mov edx, dword [MemLockHandle]
        mov ebx, dword [byte esp+020h]
        test edx, edx
        je short .4
        push edx
        call MemLock
        add esp, byte 4
.4:
        push ebx
        push esi
        push edi
        push ebp
        call AllocMemBlockEx
        mov esi, dword [MemLockHandle]
        add esp, byte 10h
        mov ebx, eax
        test esi, esi
        je short .5
        push esi
        call MemUnlock
        add esp, byte 4
.5:
        test ebx, ebx
        je short .6
        mov eax, dword [ebx]
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.6:
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AllocMemBlockFull                               FAB68  97 PC, low confidence
; Allocates a named block under the memory lock with every option passed
; through
;-----------------------------------------------------------------------------
AllocMemBlockFull:
        push ebx
        push esi
        push edi
        push ebp
        mov edx, dword [MemLockHandle]
        test edx, edx
        je short .1
        push edx
        call MemLock
        add esp, byte 4
.1:
        mov ecx, dword [byte esp+020h]
        push ecx
        mov esi, dword [byte esp+020h]
        push esi
        mov edi, dword [byte esp+020h]
        push edi
        mov ebp, dword [byte esp+020h]
        push ebp
        call AllocMemBlockEx
        mov ebx, eax
        mov eax, dword [MemLockHandle]
        add esp, byte 10h
        test eax, eax
        je short .2
        push eax
        call MemUnlock
        add esp, byte 4
.2:
        mov eax, ebx
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
