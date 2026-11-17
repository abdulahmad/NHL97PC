; EA library: FileExistsPath, FileSizePath, LoadFileAlloc, LoadFileAllocQuiet, LoadFileInto and 2 more.
bits 32
%include "hockey.inc"
section s_106CC1 progbits alloc exec nowrite align=1
extern AllocMemBlockFull, DosCloseFile, DosOpenFile, DosReadFile, FindCachedFile, LastLoadedSize, LoadFileHook
global FileExistsPath, FileSizePath, LoadFileAlloc, LoadFileAllocQuiet, LoadFileInto, LoadFileIntoQuiet, LoadFileCore
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; FileExistsPath                                 106CD0  97 PC, low confidence
; Returns whether a file exists
;-----------------------------------------------------------------------------
FileExistsPath:
        push ebx
        sub esp, byte 0Ch
        push byte 1
        lea eax, [byte esp+04h]
        push eax
        lea eax, [byte esp+0Ch]
        push eax
        lea eax, [byte esp+014h]
        push eax
        mov edx, dword [byte esp+024h]
        push edx
        call DosOpenFile
        add esp, byte 14h
        mov ebx, dword [byte esp+08h]
        push ebx
        call DosCloseFile
        add esp, byte 4
        mov eax, dword [esp]
        add esp, byte 0Ch
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FileSizePath                                   106D08  97 PC, low confidence
; Returns the size of a file
;-----------------------------------------------------------------------------
FileSizePath:
        push ebx
        sub esp, byte 0Ch
        push byte 0
        lea eax, [byte esp+04h]
        push eax
        lea eax, [byte esp+0Ch]
        push eax
        lea eax, [byte esp+014h]
        push eax
        mov edx, dword [byte esp+024h]
        push edx
        call DosOpenFile
        add esp, byte 14h
        mov ebx, dword [byte esp+08h]
        push ebx
        call DosCloseFile
        add esp, byte 4
        mov eax, dword [esp]
        add esp, byte 0Ch
        pop ebx
        ret
        db 090h
        push ebx
        sub esp, byte 0Ch
        mov edx, dword [byte esp+018h]
        push edx
        lea eax, [byte esp+04h]
        push eax
        lea eax, [byte esp+0Ch]
        push eax
        lea eax, [byte esp+014h]
        push eax
        mov ebx, dword [byte esp+024h]
        push ebx
        call DosOpenFile
        add esp, byte 14h
        mov ecx, dword [byte esp+08h]
        push ecx
        call DosCloseFile
        add esp, byte 4
        mov eax, dword [esp]
        add esp, byte 0Ch
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; LoadFileAlloc                                  106D80  97 PC, low confidence
; Loads a file into a new block
;-----------------------------------------------------------------------------
LoadFileAlloc:
        push ebx
        push byte 1
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        call LoadFileCore
        add esp, byte 0Ch
        test eax, eax
        je short .1
        mov eax, dword [eax]
.1:
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LoadFileAllocQuiet                             106DA0  97 PC, low confidence
; Loads a file into a new block without the error message
;-----------------------------------------------------------------------------
LoadFileAllocQuiet:
        push ebx
        push byte 0
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        call LoadFileCore
        add esp, byte 0Ch
        test eax, eax
        je short .1
        mov eax, dword [eax]
.1:
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        mov ecx, dword [byte esp+010h]
        push ecx
        call LoadFileCore
        add esp, byte 0Ch
        test eax, eax
        je short .2
        mov eax, dword [eax]
.2:
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadFileInto                                   106DE0  97 PC, low confidence
; Loads a file into a buffer
;-----------------------------------------------------------------------------
LoadFileInto:
        push ebx
        push byte 1
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        call LoadFileCore
        add esp, byte 0Ch
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LoadFileIntoQuiet                              106DF8  97 PC, low confidence
; Loads a file into a buffer without the error message
;-----------------------------------------------------------------------------
LoadFileIntoQuiet:
        push ebx
        push byte 0
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        call LoadFileCore
        add esp, byte 0Ch
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LoadFileCore                                   106E10  97 PC, low confidence
; Loads a file
;-----------------------------------------------------------------------------
LoadFileCore:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov esi, dword [byte esp+020h]
        mov edi, dword [byte esp+028h]
        push esi
        call FindCachedFile
        add esp, byte 4
        mov ebx, eax
        test eax, eax
        jne short .2
        push edi
        lea eax, [byte esp+0Ch]
        push eax
        lea eax, [byte esp+0Ch]
        push eax
        lea eax, [byte esp+0Ch]
        push eax
        push esi
        call DosOpenFile
        add esp, byte 14h
        mov edx, dword [byte esp+08h]
        test edx, edx
        je short .2
        push edi
        mov ebx, dword [byte esp+028h]
        push ebx
        push edx
        push esi
        call AllocMemBlockFull
        add esp, byte 10h
        mov ebx, eax
        test eax, eax
        je short .1
        mov ebp, dword [byte esp+08h]
        push ebp
        mov edx, dword [eax]
        push edx
        mov ecx, dword [byte esp+08h]
        push ecx
        call DosReadFile
        add esp, byte 0Ch
        mov eax, dword [byte esp+08h]
        mov dword [LastLoadedSize], eax
.1:
        mov ebp, dword [esp]
        push ebp
        call DosCloseFile
        add esp, byte 4
.2:
        cmp dword [LoadFileHook], byte 0
        je short .3
        push edi
        mov edx, dword [byte esp+028h]
        push edx
        push esi
        push ebx
        call dword [LoadFileHook]
        add esp, byte 10h
        mov ebx, eax
.3:
        mov eax, ebx
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
