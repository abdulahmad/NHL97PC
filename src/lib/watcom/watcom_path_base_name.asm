; Watcom C runtime: PathBaseName, SetBlockGuard, CheckBlockGuards.
bits 32
%include "hockey.inc"
section s_12149F progbits alloc exec nowrite align=1
extern findmemblock, MemBlockGuards, memlist1, MemLock, MemLockHandle, MemUnlock, StoreBigEndian
global PathBaseName, SetBlockGuard, CheckBlockGuards
        db 00h
;-----------------------------------------------------------------------------
; PathBaseName                                   1214A0  97 PC, low confidence
; Returns the file name part of a path
;-----------------------------------------------------------------------------
PathBaseName:
        push ebx
        mov eax, dword [byte esp+08h]
        mov bl, byte [eax]
        mov edx, eax
        test bl, bl
        je short .4
.1:
        mov cl, byte [eax]
        cmp cl, 5Ch
        je short .2
        cmp cl, 3Ah
        je short .2
        cmp cl, 2Fh
        jne short .3
.2:
        lea edx, [byte eax+01h]
.3:
        mov bh, byte [byte eax+01h]
        inc eax
        test bh, bh
        jne short .1
.4:
        mov eax, edx
        pop ebx
        ret
        db 00h,00h,00h
;-----------------------------------------------------------------------------
; SetBlockGuard                                  1214D0  97 PC, low confidence
; Marks a block as guarded and writes the guard word at its end; followed by
; the guard check
;-----------------------------------------------------------------------------
SetBlockGuard:
        push ebx
        mov eax, dword [byte esp+08h]
        or byte [byte eax+019h], 40h
        push byte 4
        mov ebx, dword [byte eax+014h]
        mov edx, dword [eax]
        push dword 42454E44h
        add edx, ebx
        push edx
        call StoreBigEndian
        add esp, byte 0Ch
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        mov ebx, dword [byte esp+08h]
        mov ah, byte [byte ebx+019h]
        mov edx, 1
        test ah, 40h
        je short .1
        mov eax, dword [ebx]
        add eax, dword [byte ebx+014h]
        mov ecx, 4
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp eax, 42454E44h
        je short .1
        xor edx, edx
.1:
        mov eax, edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CheckBlockGuards                               12152C  97 PC, low confidence
; Walks every memory list and checks the guard word of each guarded block
;-----------------------------------------------------------------------------
CheckBlockGuards:
        push ebx
        push esi
        push edi
        push ebp
        mov eax, 1
        xor edi, edi
        xor ebp, ebp
.1:
        test eax, eax
        jne short .2
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.2:
        cmp ebp, dword [dword edi+MemBlockGuards]
        je short .5
        mov edx, dword [dword edi+memlist1]
        mov esi, dword [dword edi+MemBlockGuards]
.3:
        mov edx, dword [byte edx+020h]
        mov ah, byte [byte edx+019h]
        mov ebx, 1
        test ah, 40h
        je short .4
        mov eax, dword [edx]
        add eax, dword [byte edx+014h]
        mov ecx, 4
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp eax, 42454E44h
        je short .4
        mov ebx, ebp
.4:
        mov eax, ebx
        test ebx, ebx
        je short .5
        cmp edx, esi
        jne short .3
.5:
        add edi, byte 18h
        cmp edi, 180h
        jl short .1
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        push byte 1
        call CheckBlockGuards
        add esp, byte 4
        ret
        db 090h
        push byte 0
        call CheckBlockGuards
        add esp, byte 4
        ret
        db 00h,00h,00h,00h,00h
        push ebx
        push esi
        mov edx, dword [byte esp+0Ch]
        push edx
        call findmemblock
        add esp, byte 4
        mov ecx, dword [MemLockHandle]
        push ecx
        mov ebx, eax
        call MemLock
        mov eax, dword [byte ebx+018h]
        add esp, byte 4
        and al, 0F8h
        mov esi, dword [MemLockHandle]
        or al, 9
        push esi
        mov dword [byte ebx+018h], eax
        call MemUnlock
        add esp, byte 4
        mov eax, ebx
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        mov ebx, dword [byte esp+08h]
        mov edx, dword [MemLockHandle]
        push edx
        call MemLock
        mov eax, dword [byte ebx+018h]
        add esp, byte 4
        and al, 0F8h
        mov ecx, dword [MemLockHandle]
        or al, 9
        push ecx
        mov dword [byte ebx+018h], eax
        call MemUnlock
        add esp, byte 4
        mov eax, ebx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push esi
        mov edx, dword [byte esp+0Ch]
        push edx
        call findmemblock
        add esp, byte 4
        mov ecx, dword [MemLockHandle]
        push ecx
        mov ebx, eax
        call MemLock
        mov eax, dword [byte ebx+018h]
        add esp, byte 4
        and al, 0F8h
        mov edx, dword [byte esp+010h]
        or al, 8
        mov esi, dword [MemLockHandle]
        or edx, eax
        push esi
        mov dword [byte ebx+018h], edx
        call MemUnlock
        add esp, byte 4
        mov eax, ebx
        pop esi
        pop ebx
        ret
        push ebx
        mov ebx, dword [byte esp+08h]
        mov edx, dword [MemLockHandle]
        push edx
        call MemLock
        mov eax, dword [byte ebx+018h]
        add esp, byte 4
        and al, 0F8h
        mov edx, dword [byte esp+0Ch]
        or al, 8
        mov ecx, dword [MemLockHandle]
        or edx, eax
        push ecx
        mov dword [byte ebx+018h], edx
        call MemUnlock
        add esp, byte 4
        mov eax, ebx
        pop ebx
        ret
        db 090h
