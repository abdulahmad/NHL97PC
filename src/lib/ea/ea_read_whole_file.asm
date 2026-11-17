; EA library: ReadWholeFile.
bits 32
%include "hockey.inc"
section s_10AE10 progbits alloc exec nowrite align=1
extern DosCloseFile, DosOpenFile, DosReadFile, ReadResourceHeader, unpack
global ReadWholeFile
;-----------------------------------------------------------------------------
; ReadWholeFile                                  10AE10  97 PC, low confidence
; Opens a file, reads it all into memory and closes it
;-----------------------------------------------------------------------------
ReadWholeFile:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        push byte 0
        lea eax, [byte esp+0Ch]
        push eax
        lea eax, [byte esp+0Ch]
        push eax
        lea eax, [byte esp+0Ch]
        push eax
        mov edx, dword [byte esp+030h]
        push edx
        call DosOpenFile
        add esp, byte 14h
        mov ebx, dword [byte esp+08h]
        test ebx, ebx
        jne short .1
        xor eax, eax
        jmp near .4
.1:
        push byte 0
        push ebx
        mov esi, dword [byte esp+0Ch]
        push esi
        mov edi, dword [byte esp+0Ch]
        push edi
        call ReadResourceHeader
        add esp, byte 10h
        mov esi, eax
        test eax, eax
        jne short .2
        mov edx, dword [esp]
        push edx
        call DosCloseFile
        add esp, byte 4
        xor eax, eax
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.2:
        mov ebp, dword [byte esp+08h]
        mov ebx, eax
        cmp eax, ebp
        jge short .3
        mov ebx, ebp
.3:
        mov eax, dword [byte esp+024h]
        mov edx, dword [byte esp+08h]
        add ebx, eax
        sub ebx, edx
        push edx
        add ebx, 100h
        push ebx
        mov edi, dword [byte esp+08h]
        push edi
        call DosReadFile
        add esp, byte 0Ch
        push byte 0
        mov ebp, dword [byte esp+028h]
        push ebp
        push ebx
        call unpack
        add esp, byte 0Ch
        mov eax, dword [esp]
        push eax
        call DosCloseFile
        add esp, byte 4
        mov eax, esi
.4:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h
