; Watcom C runtime: bcopy, _os_handle, QueueFreeChain, QueueInit, QueueNoOp and 6 more.
bits 32
%include "hockey.inc"
section s_100A68 progbits alloc exec nowrite align=1
global bcopy, _os_handle, QueueFreeChain, QueueInit, QueueNoOp, QueuePeek, QueueTakeTail, QueueTakeHead
global QueueInsert, QueueFreeAll, QueueCount
;-----------------------------------------------------------------------------
; bcopy                                       100A68  97 PC, medium confidence
; (src, dst, n): copies n bytes, backwards when they overlap (BSD order)
;-----------------------------------------------------------------------------
bcopy:
        push ebp
        LD mov, ebp, esp
        push ebx
        push esi
        push edi
        mov esi, dword [byte ebp+08h]
        mov edi, dword [byte ebp+0Ch]
        mov ecx, dword [byte ebp+010h]
        LD cmp, edi, esi
        ja short .2
        cld
        cmp ecx, byte 10h
        jge short .1
        rep movsb
        pop edi
        pop esi
        pop ebx
        leave
        ret
.1:
        LD mov, eax, edi
        mov edx, dword [esi]
        db 0F7h,0D8h                            ; insn: neg eax
        db 089h,017h                            ; insn: mov [edi],edx
        and eax, byte 3
        lea esi, [eax+esi]
        lea edi, [eax+edi]
        LD sub, ecx, eax
        LD mov, ebx, ecx
        shr ecx, 2
        rep movsd
        LD mov, ecx, ebx
        and ecx, byte 3
        rep movsb
        pop edi
        pop esi
        pop ebx
        leave
        ret
.2:
        std
        lea esi, [byte ecx+esi-04h]
        lea edi, [byte ecx+edi-04h]
        shr ecx, 2
        rep movsd
        mov ecx, dword [byte ebp+010h]
        and ecx, byte 3
        lea esi, [byte esi+03h]
        lea edi, [byte edi+03h]
        rep movsb
        cld
        pop edi
        pop esi
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; _os_handle                                                   100AD0  library
; Run-time library: returns the operating system handle of a file handle
;-----------------------------------------------------------------------------
_os_handle:
        mov eax, dword [byte esp+04h]
        ret
        db 08Dh,040h,00h
        mov edx, dword [byte esp+08h]
        mov eax, dword [byte esp+04h]
        mov eax, dword [eax]
        test eax, eax
        je short .2
.1:
        dec edx
        cmp edx, byte 0FFFFFFFFh
        je short .2
        mov eax, dword [eax]
        test eax, eax
        jne short .1
.2:
        ret
        db 090h
;-----------------------------------------------------------------------------
; QueueFreeChain                                 100AF4  97 PC, low confidence
; Frees a chain of queue entries
;-----------------------------------------------------------------------------
QueueFreeChain:
        push ebx
        push esi
        push edi
        push ebp
        mov ebx, dword [byte esp+014h]
        mov edx, dword [byte esp+018h]
        xor ecx, ecx
        test edx, edx
        je near .7
        mov esi, dword [ebx]
        test esi, esi
        jbe near .7
        mov edi, dword [byte ebx+08h]
        cmp edx, edi
        jne short .2
        mov ecx, 1
        mov eax, esi
        sub eax, ecx
        mov esi, dword [byte ebx+0Ch]
        mov dword [ebx], eax
        cmp edi, esi
        jne short .1
        mov dword [byte ebx+08h], 0
        mov eax, dword [byte ebx+08h]
        jmp short .5
.1:
        mov eax, dword [edi]
        mov dword [byte ebx+08h], eax
        jmp short .6
.2:
        mov ebp, dword [edi]
        mov eax, edi
        test ebp, ebp
        je short .4
.3:
        cmp edx, dword [eax]
        je short .4
        mov eax, dword [eax]
        cmp dword [eax], byte 0
        jne short .3
.4:
        mov esi, dword [eax]
        test esi, esi
        je short .6
        cmp edx, esi
        jne short .6
        mov ecx, 1
        sub dword [ebx], ecx
        mov esi, dword [esi]
        mov dword [eax], esi
        cmp edx, dword [byte ebx+0Ch]
        jne short .6
.5:
        mov dword [byte ebx+0Ch], eax
.6:
        test ecx, ecx
        je short .7
        mov dword [edx], 0
        or byte [byte ebx+04h], 1
.7:
        mov eax, ecx
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; QueueInit                                      100B88  97 PC, low confidence
; Clears a queue header
;-----------------------------------------------------------------------------
QueueInit:
        mov eax, dword [byte esp+04h]
        mov edx, dword [byte esp+08h]
        mov dword [byte eax+018h], 0
        mov dword [eax], 0
        mov dword [byte eax+04h], 0
        mov dword [byte eax+08h], 0
        mov dword [byte eax+0Ch], 0
        test edx, edx
        jne short .1
        mov edx, _os_handle
.1:
        mov dword [byte eax+010h], edx
        mov edx, dword [byte esp+0Ch]
        mov dword [byte eax+014h], edx
        lea eax, [byte eax+00h]
;-----------------------------------------------------------------------------
; QueueNoOp                                      100BC8  97 PC, low confidence
; Does nothing (empty queue hook)
;-----------------------------------------------------------------------------
QueueNoOp:
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; QueuePeek                                      100BCC  97 PC, low confidence
; Returns the head of a queue with interrupts off
;-----------------------------------------------------------------------------
QueuePeek:
        push ebx
        mov edx, dword [byte esp+08h]
        mov ebx, dword [byte esp+0Ch]
        pushf
        pop eax
        and eax, 200h
        cli
        test ebx, ebx
        je short .2
        mov ecx, dword [byte edx+08h]
        mov dword [ebx], ecx
        mov ecx, dword [edx]
        mov dword [byte edx+08h], ebx
        inc ecx
        mov dword [edx], ecx
        cmp dword [ebx], byte 0
        jne short .1
        mov dword [byte edx+0Ch], ebx
.1:
        or byte [byte edx+04h], 1
.2:
        pushf
        and dword [esp], 0FFFFFDFFh
        or dword [esp], eax
        popf
        pop ebx
        ret
;-----------------------------------------------------------------------------
; QueueTakeTail                                  100C08  97 PC, low confidence
; Takes the last entry of a queue with interrupts off
;-----------------------------------------------------------------------------
QueueTakeTail:
        push ebx
        push esi
        mov edx, dword [byte esp+0Ch]
        mov ebx, dword [byte esp+010h]
        pushf
        pop eax
        and eax, 200h
        cli
        test ebx, ebx
        je short .3
        mov ecx, dword [byte edx+0Ch]
        mov dword [ebx], 0
        mov esi, dword [edx]
        mov dword [byte edx+0Ch], ebx
        inc esi
        mov dword [edx], esi
        test ecx, ecx
        jne short .1
        mov dword [byte edx+08h], ebx
        jmp short .2
.1:
        mov dword [ecx], ebx
.2:
        or byte [byte edx+04h], 1
.3:
        pushf
        and dword [esp], 0FFFFFDFFh
        or dword [esp], eax
        popf
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; QueueTakeHead                                  100C50  97 PC, low confidence
; Takes the first entry of a queue with interrupts off
;-----------------------------------------------------------------------------
QueueTakeHead:
        push ebx
        mov edx, dword [byte esp+08h]
        pushf
        pop eax
        and eax, 200h
        cli
        mov ebx, dword [byte edx+08h]
        test ebx, ebx
        je short .3
        cmp ebx, dword [byte edx+0Ch]
        jne short .1
        mov dword [byte edx+0Ch], 0
        mov ecx, dword [byte edx+0Ch]
        jmp short .2
.1:
        mov ecx, dword [ebx]
.2:
        mov dword [byte edx+08h], ecx
        dec dword [edx]
        mov dword [ebx], 0
.3:
        or byte [byte edx+04h], 1
        pushf
        and dword [esp], 0FFFFFDFFh
        or dword [esp], eax
        popf
        mov eax, ebx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push esi
        push edi
        push ebp
        mov edx, dword [byte esp+014h]
        pushf
        pop eax
        and eax, 200h
        cli
        mov ebx, dword [byte edx+0Ch]
        mov ecx, eax
        test ebx, ebx
        je short .8
        mov esi, dword [edx]
        dec esi
        mov edi, dword [byte edx+08h]
        mov dword [edx], esi
        cmp ebx, edi
        je short .6
        mov dword [byte edx+0Ch], edi
.4:
        mov eax, dword [byte edx+0Ch]
        mov ebp, dword [eax]
        cmp ebx, ebp
        je short .5
        mov dword [byte edx+0Ch], ebp
        jmp short .4
.5:
        mov dword [eax], 0
        jmp short .7
.6:
        mov dword [byte edx+08h], 0
        mov eax, dword [byte edx+08h]
        mov dword [byte edx+0Ch], eax
.7:
        mov dword [ebx], 0
.8:
        or byte [byte edx+04h], 1
        mov eax, ecx
        pushf
        and dword [esp], 0FFFFFDFFh
        or dword [esp], eax
        popf
        mov eax, ebx
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueueInsert                                    100D04  97 PC, low confidence
; Inserts an entry into a queue with interrupts off
;-----------------------------------------------------------------------------
QueueInsert:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, dword [byte esp+018h]
        pushf
        pop eax
        and eax, 200h
        cli
        mov edx, dword [byte esp+01Ch]
        mov dword [esp], eax
        test edx, edx
        je short .6
        mov ebx, dword [byte esi+014h]
        push ebx
        push edx
        xor edi, edi
        call dword [byte esi+010h]
        mov ebp, eax
        mov eax, dword [esi]
        add esp, byte 8
        inc eax
        mov ebx, dword [byte esi+08h]
        mov dword [esi], eax
        test ebx, ebx
        je short .2
.1:
        mov edx, dword [byte esi+014h]
        push edx
        push ebx
        call dword [byte esi+010h]
        add esp, byte 8
        cmp eax, ebp
        jae short .2
        mov edi, ebx
        mov ebx, dword [ebx]
        test ebx, ebx
        jne short .1
.2:
        mov eax, dword [byte esp+01Ch]
        mov dword [eax], ebx
        test edi, edi
        jne short .3
        mov dword [byte esi+08h], eax
        jmp short .4
.3:
        mov dword [edi], eax
.4:
        test ebx, ebx
        jne short .5
        mov eax, dword [byte esp+01Ch]
        mov dword [byte esi+0Ch], eax
.5:
        or byte [byte esi+04h], 1
.6:
        mov eax, dword [esp]
        pushf
        and dword [esp], 0FFFFFDFFh
        or dword [esp], eax
        popf
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; QueueFreeAll                                   100D8C  97 PC, low confidence
; Frees every entry of a queue
;-----------------------------------------------------------------------------
QueueFreeAll:
        push ebx
        mov ecx, dword [byte esp+0Ch]
        pushf
        pop eax
        and eax, 200h
        cli
        mov ebx, eax
        test ecx, ecx
        je short .1
        push ecx
        mov edx, dword [byte esp+0Ch]
        push edx
        call QueueFreeChain
        add esp, byte 8
        mov edx, eax
.1:
        mov eax, ebx
        pushf
        and dword [esp], 0FFFFFDFFh
        or dword [esp], eax
        popf
        mov eax, edx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; QueueCount                                     100DC4  97 PC, low confidence
; Returns the count of a queue
;-----------------------------------------------------------------------------
QueueCount:
        mov eax, dword [byte esp+04h]
        mov eax, dword [eax]
        ret
