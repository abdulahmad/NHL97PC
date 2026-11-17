; EA library: GrabLargestBlock, InitMemoryPool, InitMemoryPoolDefault, InitMemoryPoolArgs.
bits 32
%include "hockey.inc"
section s_1197F6 progbits alloc exec nowrite align=1
extern _nexpand_, _nfree_, _nmalloc_, _nmsize_, AddHighMemRegion, AddMemRegion, AddMemRegions, InitMemDescriptors
extern int386_, MemFreeBytes, MemFreeStart, MemListEnd, MemLock, MemLockHandle, MemPoolBase, MemPoolCount
extern MemPoolEnd, MemPoolSize, MemPoolSizes, MemPoolTable, memset_, MemUnlock, ResetMemLock, str_MBDOS
extern str_MBRAM2, TrimMemList
global GrabLargestBlock, InitMemoryPool, InitMemoryPoolDefault, InitMemoryPoolArgs
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; GrabLargestBlock                               119800  97 PC, low confidence
; Allocates the largest block the memory manager gives, trying smaller sizes
;-----------------------------------------------------------------------------
GrabLargestBlock:
        push ebx
        mov edx, dword [byte esp+08h]
        test edx, edx
        jne short .1
        mov edx, 4000000h
.1:
        mov eax, edx
        call _nmalloc_
        mov ebx, eax
        test eax, eax
        jne short .2
        sub edx, 10000h
        test edx, edx
        jge short .1
.2:
        test ebx, ebx
        jne short .3
        xor eax, eax
        pop ebx
        ret
.3:
        mov edx, 4000000h
        mov eax, ebx
        call _nexpand_
        mov eax, ebx
        call _nmsize_
        mov edx, eax
        mov eax, ebx
        call _nfree_
        mov eax, edx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; InitMemoryPool                                 119850  97 PC, low confidence
; Sets up the game's memory pool from DOS extender memory
;-----------------------------------------------------------------------------
InitMemoryPool:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 44h
        mov esi, dword [byte esp+060h]
        call ResetMemLock
        push eax
        mov ebx, 40h
        mov dword [MemLockHandle], eax
        call MemLock
        add esp, byte 4
        mov eax, MemPoolTable
        xor edx, edx
        call memset_
        mov edx, dword [byte esp+05Ch]
        xor ebp, ebp
        test edx, edx
        je short .4
        lea ebx, [edx+esi]
        push ebx
        call GrabLargestBlock
        sub eax, esi
        add esp, byte 4
        cmp eax, 4000h
        jge short .1
        mov eax, 4000h
        jmp short .2
.1:
        push ebx
        call GrabLargestBlock
        add esp, byte 4
        sub eax, esi
.2:
        mov ebx, dword [byte esp+05Ch]
        mov edx, eax
        cmp eax, ebx
        jle short .3
        mov edx, ebx
.3:
        mov eax, edx
        jmp short .7
.4:
        push ebp
        call GrabLargestBlock
        sub eax, esi
        add esp, byte 4
        cmp eax, 4000h
        jge short .5
        mov eax, 4000h
        jmp short .6
.5:
        push ebp
        call GrabLargestBlock
        add esp, byte 4
        sub eax, esi
.6:
        mov edx, eax
.7:
        and al, 0F0h
        inc ebp
        call _nmalloc_
        mov dword [MemPoolBase], eax
        mov dword [nosplit ebp*4+MemPoolSizes], eax
        mov ebx, dword [MemPoolBase]
        lea eax, [ebx+edx]
        mov edx, dword [byte esp+058h]
        lea edi, [nosplit edx*4+00h]
        push edx
        push ebx
        mov dword [MemPoolEnd], eax
        add edi, edx
        call InitMemDescriptors
        add esp, byte 8
        push byte 0
        push byte 0
        push byte 10h
        mov eax, dword [MemPoolEnd]
        push byte 10h
        shl edi, 3
        push eax
        mov eax, dword [MemPoolBase]
        add eax, edi
        push eax
        push byte 0
        push str_MBRAM2
        call AddMemRegion
        mov edi, dword [MemPoolEnd]
        mov edx, dword [MemPoolBase]
        add esp, byte 20h
        sub edi, edx
        mov ebx, dword [byte esp+068h]
        mov dword [byte esp+040h], edi
        test ebx, ebx
        jne short .8
        mov dword [byte esp+068h], 8000h
.8:
        mov edx, 100h
        mov ebx, 0C000h
        mov eax, 31h
        mov word [byte esp+01Ch], dx
        mov word [byte esp+020h], bx
        mov ebx, esp
        lea edx, [byte esp+01Ch]
        call int386_
        xor eax, eax
        mov ecx, 100h
        mov ax, word [byte esp+04h]
        mov edx, dword [byte esp+068h]
        shl eax, 4
        mov ebx, dword [byte esp+064h]
        sub eax, edx
        mov word [byte esp+01Ch], cx
        mov dword [MemPoolSize], eax
        test ebx, ebx
        je short .9
        cmp eax, ebx
        jle short .9
        mov dword [MemPoolSize], ebx
.9:
        mov eax, dword [MemPoolSize]
        test eax, eax
        jg short .10
        xor eax, eax
        mov ax, word [byte esp+04h]
        shl eax, 4
        mov dword [byte esp+068h], eax
        jmp short .11
.10:
        mov ebx, esp
        sar eax, 4
        lea edx, [byte esp+01Ch]
        mov word [byte esp+020h], ax
        mov eax, 31h
        call int386_
        xor eax, eax
        mov ax, word [byte esp+0Ch]
        mov dword [MemPoolCount], eax
        xor eax, eax
        mov ax, word [esp]
        shl eax, 4
        mov dword [byte esp+038h], eax
        xor eax, eax
        mov ax, word [byte esp+04h]
        shl eax, 4
        mov dword [MemPoolSize], eax
.11:
        cmp dword [byte esp+068h], byte 0
        je short .12
        mov eax, 100h
        mov edx, 0C000h
        mov ebx, esp
        mov word [byte esp+01Ch], ax
        mov word [byte esp+020h], dx
        lea edx, [byte esp+01Ch]
        mov eax, 31h
        call int386_
        mov eax, dword [byte esp+04h]
        mov ebx, 100h
        dec eax
        lea edx, [byte esp+01Ch]
        mov word [byte esp+020h], ax
        xor eax, eax
        mov word [byte esp+01Ch], bx
        mov ax, word [byte esp+020h]
        mov ebx, esp
        mov dword [byte esp+068h], eax
        mov eax, 31h
        call int386_
        xor eax, eax
        mov ax, word [byte esp+0Ch]
        mov dword [byte esp+03Ch], eax
.12:
        lea ebx, [nosplit ebp*4+00h]
.13:
        cmp ebx, byte 3Ch
        jge short .14
        mov ecx, dword [byte esp+05Ch]
        push ecx
        call GrabLargestBlock
        and al, 0F0h
        add esp, byte 4
        mov edx, eax
        cmp eax, 2710h
        jl short .14
        call _nmalloc_
        mov ecx, dword [byte esp+040h]
        add edi, edx
        add ecx, edx
        add edx, eax
        push edx
        push eax
        push byte 0
        inc ebp
        mov dword [dword ebx+MemPoolTable], eax
        push str_MBRAM2
        add ebx, byte 4
        mov dword [byte esp+050h], ecx
        call AddHighMemRegion
        add esp, byte 10h
        jmp short .13
.14:
        cmp dword [byte esp+05Ch], byte 0
        je short .15
        mov eax, dword [byte esp+040h]
        mov edx, dword [byte esp+05Ch]
        cmp eax, edx
        jle short .15
        sub eax, edx
        cmp eax, esi
        jle short .15
        mov esi, eax
.15:
        sub edi, esi
        test esi, esi
        jle short .17
.16:
        push byte 0
        call MemListEnd
        add esp, byte 4
        test eax, eax
        je short .17
        call _nfree_
        push byte 0
        call TrimMemList
        sub esi, eax
        add esp, byte 4
        test esi, esi
        jg short .16
.17:
        neg esi
        cmp esi, 2710h
        jle short .18
        mov eax, esi
        call _nmalloc_
        add esi, eax
        push esi
        push eax
        push byte 0
        push str_MBRAM2
        mov dword [nosplit ebp*4+MemPoolTable], eax
        call AddHighMemRegion
        add esp, byte 10h
.18:
        mov ecx, dword [MemPoolSize]
        test ecx, ecx
        jle short .19
        push byte 0
        push byte 0
        push byte 10h
        mov eax, dword [byte esp+044h]
        push byte 10h
        add eax, ecx
        push eax
        mov eax, dword [byte esp+04Ch]
        push eax
        push dword 200h
        push byte 0
        push str_MBDOS
        add edi, ecx
        call AddMemRegions
        add esp, byte 24h
.19:
        cmp dword [byte esp+068h], byte 0
        je short .20
        mov ecx, 101h
        mov eax, dword [byte esp+03Ch]
        mov ebx, esp
        lea edx, [byte esp+01Ch]
        mov word [byte esp+028h], ax
        mov eax, 31h
        mov word [byte esp+01Ch], cx
        call int386_
.20:
        mov ecx, dword [MemLockHandle]
        mov ebx, 0A0000h
        push ecx
        mov dword [MemFreeBytes], edi
        mov dword [MemFreeStart], ebx
        call MemUnlock
        add esp, byte 4
        mov eax, edi
        add esp, byte 44h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; InitMemoryPoolDefault                          119BC8  97 PC, low confidence
; Sets up the memory pool with the default size
;-----------------------------------------------------------------------------
InitMemoryPoolDefault:
        push byte 0
        push byte 0
        push byte 0
        push dword 0F42400h
        mov edx, dword [byte esp+014h]
        push edx
        call InitMemoryPool
        add esp, byte 14h
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; InitMemoryPoolArgs                             119BE4  97 PC, low confidence
; Sets up the memory pool with the given sizes
;-----------------------------------------------------------------------------
InitMemoryPoolArgs:
        push ebx
        push byte 0
        mov edx, dword [byte esp+014h]
        push edx
        push byte 0
        mov ebx, dword [byte esp+018h]
        push ebx
        mov ecx, dword [byte esp+018h]
        push ecx
        call InitMemoryPool
        add esp, byte 14h
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        mov edx, dword [byte esp+010h]
        push edx
        push byte 0
        mov ebx, dword [byte esp+014h]
        push ebx
        push byte 0
        mov ecx, dword [byte esp+018h]
        push ecx
        call InitMemoryPool
        add esp, byte 14h
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push esi
        sub esp, byte 38h
        xor edx, edx
.1:
        mov ebx, dword [dword edx+MemPoolTable]
        test ebx, ebx
        je short .2
        mov eax, ebx
        call _nfree_
.2:
        add edx, byte 4
        cmp edx, byte 40h
        jne short .1
        mov eax, MemPoolTable
        mov ebx, edx
        xor edx, edx
        call memset_
        cmp dword [MemPoolCount], byte 0
        je short .3
        mov edx, 101h
        lea ebx, [byte esp+01Ch]
        mov ax, word [MemPoolCount]
        mov word [esp], dx
        mov word [byte esp+0Ch], ax
        mov edx, esp
        mov eax, 31h
        xor esi, esi
        call int386_
        mov dword [MemPoolCount], esi
.3:
        add esp, byte 38h
        pop esi
        pop ebx
        ret
