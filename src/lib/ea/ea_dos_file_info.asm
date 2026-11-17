; EA library: DosFileInfo.
bits 32
%include "hockey.inc"
section s_10AED0 progbits alloc exec nowrite align=1
extern DosCloseFile, DosOpenReadOnly
global DosFileInfo
;-----------------------------------------------------------------------------
; DosFileInfo                                    10AED0  97 PC, low confidence
; Opens a file to learn whether it exists and its size, then closes it
;-----------------------------------------------------------------------------
DosFileInfo:
        push ebx
        sub esp, byte 0Ch
        mov eax, esp
        push eax
        lea eax, [byte esp+08h]
        push eax
        lea eax, [byte esp+010h]
        push eax
        mov edx, dword [byte esp+020h]
        push edx
        call DosOpenReadOnly
        add esp, byte 10h
        mov ebx, dword [byte esp+08h]
        push ebx
        call DosCloseFile
        add esp, byte 4
        cmp dword [byte esp+08h], byte 0
        je short .1
        mov dword [byte esp+08h], 1
.1:
        mov eax, dword [byte esp+08h]
        add esp, byte 0Ch
        pop ebx
        ret
