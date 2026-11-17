; EA library: LoadNamedResource, LoadNamedResourceEx, LoadNameFile.
bits 32
%include "hockey.inc"
section s_119542 progbits alloc exec nowrite align=1
extern AllocMemBlockFull, ArchiveEntryOffset, CurrentArchiveName, DosCloseFile, DosOpenFile, DosReadFile, DosSeekFile, FindCachedFile
extern LoadFileHook, MemDescPtr, ResourceArchive, ResourceArchiveData, ResourceArchiveSize
global LoadNamedResource, LoadNamedResourceEx, LoadNameFile
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; LoadNamedResource                              119550  97 PC, low confidence
; Loads a named resource from the data folder
;-----------------------------------------------------------------------------
LoadNamedResource:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        call CurrentArchiveName
        mov edx, dword [byte esp+03Ch]
        push edx
        lea ebx, [byte esp+0Ch]
        push ebx
        lea ebx, [byte esp+0Ch]
        push ebx
        lea ebx, [byte esp+0Ch]
        push ebx
        push eax
        call DosOpenFile
        add esp, byte 14h
        cmp dword [byte esp+08h], byte 0
        jne short .3
        mov edx, dword [byte esp+02Ch]
        xor esi, esi
        test edx, edx
        jle short .2
        mov eax, dword [byte esp+034h]
        mov ebx, dword [byte esp+02Ch]
.1:
        inc esi
        mov dword [eax], 0
        add eax, byte 4
        cmp esi, ebx
        jl short .1
.2:
        xor eax, eax
        jmp near .13
.3:
        mov ecx, dword [ResourceArchiveData]
        push ecx
        mov esi, dword [ResourceArchive]
        push esi
        mov edi, dword [byte esp+08h]
        push edi
        mov ebp, 1
        call DosReadFile
        add esp, byte 0Ch
        mov edi, dword [ResourceArchiveData]
        mov eax, dword [byte esp+02Ch]
        mov dword [byte esp+0Ch], ebp
        xor ebp, ebp
        test eax, eax
        jle near .12
        mov eax, dword [byte esp+034h]
        mov ebx, dword [byte esp+030h]
        mov dword [byte esp+010h], eax
.4:
        mov eax, dword [ebx]
        push eax
        lea esi, [nosplit ebp*4+00h]
        call FindCachedFile
        add esp, byte 4
        test eax, eax
        je short .5
        add esi, dword [byte esp+034h]
        mov dword [esi], eax
        jmp near .11
.5:
        mov edx, dword [byte esp+03Ch]
        push edx
        mov ecx, dword [ebx]
        push ecx
        mov esi, dword [ResourceArchive]
        push esi
        call ArchiveEntryOffset
        mov esi, eax
        add esp, byte 0Ch
        test eax, eax
        jne short .6
        mov dword [byte esp+0Ch], eax
        jmp short .8
.6:
        mov eax, dword [ResourceArchiveSize]
        mov eax, dword [eax]
        mov dword [byte esp+014h], eax
        cmp esi, edi
        je short .7
        push esi
        mov edi, dword [byte esp+04h]
        push edi
        call DosSeekFile
        add esp, byte 8
        mov edi, esi
.7:
        mov edx, dword [byte esp+03Ch]
        push edx
        mov ecx, dword [byte esp+03Ch]
        push ecx
        mov eax, dword [byte esp+01Ch]
        push eax
        add edi, eax
        mov eax, dword [ebx]
        push eax
        call AllocMemBlockFull
        add esp, byte 10h
        mov esi, eax
        test eax, eax
        je short .8
        mov edx, dword [byte esp+014h]
        push edx
        mov ecx, dword [eax]
        push ecx
        mov eax, dword [byte esp+08h]
        push eax
        call DosReadFile
        add esp, byte 0Ch
.8:
        cmp dword [LoadFileHook], byte 0
        je short .9
        mov eax, dword [byte esp+03Ch]
        push eax
        mov edx, dword [byte esp+03Ch]
        push edx
        mov ecx, dword [ebx]
        push ecx
        push esi
        call dword [LoadFileHook]
        add esp, byte 10h
        mov esi, eax
.9:
        test esi, esi
        jne short .10
        mov dword [byte esp+0Ch], esi
.10:
        mov eax, dword [byte esp+010h]
        mov dword [eax], esi
.11:
        mov ecx, dword [byte esp+010h]
        mov esi, dword [byte esp+02Ch]
        add ebx, byte 4
        add ecx, byte 4
        inc ebp
        mov dword [byte esp+010h], ecx
        cmp ebp, esi
        jl near .4
.12:
        mov edi, dword [esp]
        push edi
        call DosCloseFile
        add esp, byte 4
        mov eax, dword [byte esp+0Ch]
.13:
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        push ebx
        push esi
        push byte 1
        mov edx, dword [byte esp+01Ch]
        push edx
        mov ebx, dword [byte esp+01Ch]
        push ebx
        mov ecx, dword [byte esp+01Ch]
        push ecx
        mov esi, dword [byte esp+01Ch]
        push esi
        call LoadNamedResource
        add esp, byte 14h
        pop esi
        pop ebx
        ret
        db 090h
        push ebx
        push esi
        push byte 0
        mov edx, dword [byte esp+01Ch]
        push edx
        mov ebx, dword [byte esp+01Ch]
        push ebx
        mov ecx, dword [byte esp+01Ch]
        push ecx
        mov esi, dword [byte esp+01Ch]
        push esi
        call LoadNamedResource
        add esp, byte 14h
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LoadNamedResourceEx                            119730  97 PC, low confidence
; Calls LoadNamedResource with its options
;-----------------------------------------------------------------------------
LoadNamedResourceEx:
        push ebx
        push esi
        push edi
        push ebp
        mov edi, dword [byte esp+014h]
        mov ebx, dword [byte esp+01Ch]
        mov edx, dword [byte esp+024h]
        push edx
        mov ecx, dword [byte esp+024h]
        push ecx
        push ebx
        mov esi, dword [byte esp+024h]
        push esi
        push edi
        call LoadNamedResource
        xor esi, esi
        add esp, byte 14h
        mov ebp, eax
        test edi, edi
        jle short .3
.1:
        mov eax, dword [ebx]
        test eax, eax
        je short .2
        push eax
        call MemDescPtr
        add esp, byte 4
        mov dword [ebx], eax
.2:
        inc esi
        add ebx, byte 4
        cmp esi, edi
        jl short .1
.3:
        mov eax, ebp
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LoadNameFile                                   119780  97 PC, low confidence
; Loads a list of names (logo names) from the data folder
;-----------------------------------------------------------------------------
LoadNameFile:
        push ebx
        push esi
        push byte 1
        mov edx, dword [byte esp+01Ch]
        push edx
        mov ebx, dword [byte esp+01Ch]
        push ebx
        mov ecx, dword [byte esp+01Ch]
        push ecx
        mov esi, dword [byte esp+01Ch]
        push esi
        call LoadNamedResourceEx
        add esp, byte 14h
        pop esi
        pop ebx
        ret
        db 090h
        push ebx
        push esi
        push byte 0
        mov edx, dword [byte esp+01Ch]
        push edx
        mov ebx, dword [byte esp+01Ch]
        push ebx
        mov ecx, dword [byte esp+01Ch]
        push ecx
        mov esi, dword [byte esp+01Ch]
        push esi
        call LoadNamedResourceEx
        add esp, byte 14h
        pop esi
        pop ebx
        ret
