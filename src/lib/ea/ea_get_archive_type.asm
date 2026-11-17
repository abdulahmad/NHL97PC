; EA library: GetArchiveType, GetArchiveHeaderSize, FindArchiveEntry, ArchiveEntryOffset and 4 more.
bits 32
%include "hockey.inc"
section s_121DDC progbits alloc exec nowrite align=1
extern ArchiveHeader, strchr_, strcpy_, stricmp_, strlen_
global GetArchiveType, GetArchiveHeaderSize, FindArchiveEntry, ArchiveEntryOffset, ArchiveEntryOffsetAt, LocateArchiveEntry, LocateArchiveEntries, mem_putc__0
        db 00h,00h,00h,00h
;-----------------------------------------------------------------------------
; GetArchiveType                                 121DE0  97 PC, low confidence
; Returns the archive format of a buffer: 1 for the old C0FB archive, 2 for
; BIGF, 0 for neither
;-----------------------------------------------------------------------------
GetArchiveType:
        push ebx
        mov ebx, dword [byte esp+08h]
        xor edx, edx
        test ebx, ebx
        je short .2
        mov ecx, 2
        mov eax, ebx
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp eax, 0C0FBh
        jne short .1
        mov edx, 1
        mov eax, edx
        pop ebx
        ret
.1:
        mov ecx, 4
        mov eax, ebx
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp eax, 42494746h
        jne short .2
        mov edx, 2
.2:
        mov eax, edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; GetArchiveHeaderSize                           121E38  97 PC, low confidence
; Returns the size of an archive's directory header for its format
;-----------------------------------------------------------------------------
GetArchiveHeaderSize:
        push ebx
        mov ebx, dword [byte esp+08h]
        mov edx, dword [byte esp+0Ch]
        push edx
        push ebx
        call GetArchiveType
        add esp, byte 8
        cmp eax, byte 1
        jb short .3
        jbe short .1
        cmp eax, byte 2
        je short .2
        xor eax, eax
        pop ebx
        ret
.1:
        mov ecx, 2
        lea eax, [byte ebx+02h]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        add eax, byte 4
        pop ebx
        ret
.2:
        mov ecx, 4
        lea eax, [byte ebx+0Ch]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        pop ebx
        ret
.3:
        xor eax, eax
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FindArchiveEntry                               121E94  97 PC, low confidence
; Searches an archive directory for an entry by name or index and returns its
; offset and size
;-----------------------------------------------------------------------------
FindArchiveEntry:
        push ebx
        push esi
        push edi
        push ebp
        mov edi, dword [byte esp+014h]
        mov ebx, dword [byte esp+018h]
        mov edx, dword [byte esp+028h]
        push edx
        push edi
        call GetArchiveHeaderSize
        add esp, byte 8
        mov ecx, dword [byte esp+028h]
        push ecx
        lea ebp, [edi+eax]
        push edi
        xor esi, esi
        call GetArchiveType
        add esp, byte 8
        cmp eax, byte 1
        jb near .15
        jbe short .1
        cmp eax, byte 2
        je near .8
        jmp near .15
.1:
        add edi, byte 6
        cmp edi, ebp
        jae near .15
        mov ecx, dword [byte esp+01Ch]
.2:
        test ebx, ebx
        jne short .3
        cmp esi, ecx
        je short .4
.3:
        test ebx, ebx
        je short .7
        lea eax, [byte edi+06h]
        mov edx, ebx
        call stricmp_
        test eax, eax
        jne short .7
.4:
        mov esi, dword [byte esp+020h]
        test esi, esi
        je short .5
        mov ecx, 3
        mov eax, edi
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov dword [esi], eax
.5:
        mov ebp, dword [byte esp+024h]
        test ebp, ebp
        je short .6
        mov ecx, 3
        lea eax, [byte edi+03h]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov dword [byte ebp+00h], eax
.6:
        lea eax, [byte edi+06h]
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.7:
        lea eax, [byte edi+06h]
        call strlen_
        add edi, eax
        add edi, byte 7
        inc esi
        cmp edi, ebp
        jb short .2
        jmp near .15
.8:
        add edi, byte 10h
        cmp edi, ebp
        jae near .15
.9:
        test ebx, ebx
        jne short .10
        cmp esi, dword [byte esp+01Ch]
        je short .11
.10:
        test ebx, ebx
        je short .14
        lea eax, [byte edi+08h]
        mov edx, ebx
        call stricmp_
        test eax, eax
        jne short .14
.11:
        mov edx, dword [byte esp+020h]
        test edx, edx
        je short .12
        mov ecx, 4
        mov eax, edi
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov dword [edx], eax
.12:
        mov ebx, dword [byte esp+024h]
        test ebx, ebx
        je short .13
        mov ecx, 4
        lea eax, [byte edi+04h]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov dword [ebx], eax
.13:
        lea eax, [byte edi+08h]
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.14:
        lea eax, [byte edi+08h]
        call strlen_
        add edi, eax
        add edi, byte 9
        inc esi
        cmp edi, ebp
        jb short .9
.15:
        mov eax, dword [byte esp+020h]
        test eax, eax
        je short .16
        mov dword [eax], 0
.16:
        mov edx, dword [byte esp+024h]
        test edx, edx
        je short .17
        mov dword [edx], 0
.17:
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ArchiveEntryOffset                             12200C  97 PC, low confidence
; Returns the offset of a named entry in an archive
;-----------------------------------------------------------------------------
ArchiveEntryOffset:
        push ebx
        sub esp, byte 4
        mov edx, dword [byte esp+014h]
        push edx
        push ArchiveHeader
        lea eax, [byte esp+08h]
        push eax
        push byte 0
        mov ebx, dword [byte esp+020h]
        push ebx
        mov ecx, dword [byte esp+020h]
        push ecx
        call FindArchiveEntry
        add esp, byte 18h
        mov eax, dword [esp]
        add esp, byte 4
        pop ebx
        ret
        db 090h
        push ebx
        sub esp, byte 4
        push byte 1
        push ArchiveHeader
        lea eax, [byte esp+08h]
        push eax
        push byte 0
        mov edx, dword [byte esp+020h]
        push edx
        mov ebx, dword [byte esp+020h]
        push ebx
        call FindArchiveEntry
        add esp, byte 18h
        mov eax, dword [esp]
        add esp, byte 4
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ArchiveEntryOffsetAt                           122068  97 PC, low confidence
; Returns the offset of an archive entry by index
;-----------------------------------------------------------------------------
ArchiveEntryOffsetAt:
        push ebx
        sub esp, byte 4
        push byte 0
        push ArchiveHeader
        lea eax, [byte esp+08h]
        push eax
        push byte 0
        mov edx, dword [byte esp+020h]
        push edx
        mov ebx, dword [byte esp+020h]
        push ebx
        call FindArchiveEntry
        add esp, byte 18h
        mov eax, dword [esp]
        add esp, byte 4
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LocateArchiveEntry                             122094  97 PC, low confidence
; Returns a pointer to a named entry inside an archive in memory, or 0
;-----------------------------------------------------------------------------
LocateArchiveEntry:
        push ebx
        push esi
        push edi
        sub esp, byte 4
        mov edx, dword [byte esp+01Ch]
        push edx
        push ArchiveHeader
        lea eax, [byte esp+08h]
        push eax
        xor ebx, ebx
        push ebx
        mov ecx, dword [byte esp+028h]
        push ecx
        mov esi, dword [byte esp+028h]
        push esi
        call FindArchiveEntry
        add esp, byte 18h
        mov edi, dword [esp]
        test edi, edi
        je short .1
        lea ebx, [esi+edi]
.1:
        mov eax, ebx
        add esp, byte 4
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push byte 1
        mov edx, dword [byte esp+010h]
        push edx
        mov ecx, dword [byte esp+010h]
        push ecx
        xor ebx, ebx
        call ArchiveEntryOffset
        add esp, byte 0Ch
        test eax, eax
        je short .2
        mov ebx, dword [byte esp+08h]
        add ebx, eax
.2:
        mov eax, ebx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        xor ebx, ebx
        push ebx
        mov edx, dword [byte esp+010h]
        push edx
        mov ecx, dword [byte esp+010h]
        push ecx
        call ArchiveEntryOffset
        add esp, byte 0Ch
        test eax, eax
        je short .3
        mov ebx, dword [byte esp+08h]
        add ebx, eax
.3:
        mov eax, ebx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LocateArchiveEntries                           122120  97 PC, low confidence
; Splits a comma-separated list of names and stores a pointer to each entry
; of the archive
;-----------------------------------------------------------------------------
LocateArchiveEntries:
        push ebx
        push esi
        push edi
        push ebp
        mov ebp, dword [byte esp+014h]
        mov esi, dword [byte esp+018h]
        mov edi, dword [byte esp+01Ch]
.1:
        mov edx, 2Ch
        mov eax, esi
        call strchr_
        mov ebx, eax
        test eax, eax
        je short .2
        mov byte [eax], 0
.2:
        push byte 0
        push esi
        push ebp
        add edi, byte 4
        call LocateArchiveEntry
        add esp, byte 0Ch
        mov dword [byte edi-04h], eax
        test ebx, ebx
        je short .3
        mov byte [ebx], 2Ch
        inc ebx
        mov esi, ebx
.3:
        test ebx, ebx
        jne short .1
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push byte 1
        mov edx, dword [byte esp+014h]
        push edx
        mov ebx, dword [byte esp+014h]
        push ebx
        mov ecx, dword [byte esp+014h]
        push ecx
        call LocateArchiveEntries
        add esp, byte 10h
        pop ebx
        ret
        push ebx
        push byte 0
        mov edx, dword [byte esp+014h]
        push edx
        mov ebx, dword [byte esp+014h]
        push ebx
        mov ecx, dword [byte esp+014h]
        push ecx
        call LocateArchiveEntries
        add esp, byte 10h
        pop ebx
        ret
        push ebx
        push esi
        mov esi, dword [byte esp+0Ch]
        xor ebx, ebx
        push ebx
        push esi
        call GetArchiveType
        add esp, byte 8
        cmp eax, byte 1
        jb short .7
        jbe short .4
        cmp eax, byte 2
        je short .5
        mov eax, ebx
        pop esi
        pop ebx
        ret
.4:
        mov ecx, 2
        lea eax, [byte esi+04h]
        jmp short .6
.5:
        mov ecx, 4
        lea eax, [byte esi+08h]
.6:
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov ebx, eax
.7:
        mov eax, ebx
        pop esi
        pop ebx
        ret
        db 090h
        push ebx
        sub esp, byte 4
        push byte 0
        push ArchiveHeader
        lea eax, [byte esp+08h]
        push eax
        mov edx, dword [byte esp+01Ch]
        push edx
        push byte 0
        mov ebx, dword [byte esp+020h]
        push ebx
        call FindArchiveEntry
        add esp, byte 18h
        test eax, eax
        je short .8
        mov ecx, dword [esp]
        lea eax, [ebx+ecx]
.8:
        add esp, byte 4
        pop ebx
        ret
        db 090h
        push ebx
        mov ebx, dword [byte esp+010h]
        push byte 0
        push byte 0
        push byte 0
        mov edx, dword [byte esp+018h]
        push edx
        push byte 0
        mov ecx, dword [byte esp+01Ch]
        push ecx
        call FindArchiveEntry
        add esp, byte 18h
        test eax, eax
        je short .9
        mov edx, eax
        mov eax, ebx
        call strcpy_
        mov eax, ebx
        pop ebx
        ret
.9:
        mov byte [ebx], 0
        pop ebx
        ret
;-----------------------------------------------------------------------------
; mem_putc__0                                                  122259  library
; Run-time library: stores one character into a memory string stream (vsprintf output)
;-----------------------------------------------------------------------------
mem_putc__0:
        push ebx
        push ecx
        mov ebx, edx
        mov edx, dword [eax]
        lea ecx, [byte edx+01h]
        mov dword [eax], ecx
        mov byte [edx], bl
        inc dword [byte eax+010h]
        pop ecx
        pop ebx
        ret
