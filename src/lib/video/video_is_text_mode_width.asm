; Video: IsTextModeWidth, SaveTextScreen, RestoreTextScreen.
bits 32
%include "hockey.inc"
section s_130545 progbits alloc exec nowrite align=1
extern AllocMemBlockFixed, bcopy, MemDescPtr, RestoreVideoState, SaveVideoState, str_SaveText, UnlinkMemBlockLocked
global IsTextModeWidth, SaveTextScreen, RestoreTextScreen
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; IsTextModeWidth                                130550  97 PC, low confidence
; Returns whether the saved video state is a text mode of 40, 80, 100, 128 or
; 132 columns
;-----------------------------------------------------------------------------
IsTextModeWidth:
        push ebx
        push edx
        push esi
        mov ebx, dword [eax]
        xor edx, edx
        cmp ebx, byte 28h
        je short .1
        cmp ebx, byte 50h
        je short .1
        cmp ebx, byte 64h
        je short .1
        cmp ebx, 80h
        je short .1
        cmp ebx, 84h
        jne short .2
.1:
        mov ebx, dword [byte eax+04h]
        cmp ebx, byte 18h
        jl short .2
        cmp ebx, byte 42h
        jg short .2
        mov esi, dword [byte eax+08h]
        test esi, esi
        jl short .2
        cmp esi, dword [eax]
        jg short .2
        mov edx, 1
.2:
        mov eax, edx
        pop esi
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SaveTextScreen                                 13059C  97 PC, low confidence
; Saves the DOS text screen and cursor at start-up so it can be put back on
; exit
;-----------------------------------------------------------------------------
SaveTextScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 10h
        mov eax, esp
        call SaveVideoState
        mov eax, esp
        xor edi, edi
        call IsTextModeWidth
        test eax, eax
        je short .1
        mov esi, dword [esp]
        imul esi, dword [byte esp+04h]
        add esi, esi
        push edi
        lea eax, [byte esi+018h]
        push eax
        push str_SaveText
        call AllocMemBlockFixed
        add esp, byte 0Ch
        push eax
        mov edi, eax
        call MemDescPtr
        add esp, byte 4
        mov ebx, eax
        push byte 10h
        mov dword [eax], 10h
        add eax, byte 8
        push eax
        mov dword [byte eax-04h], esi
        lea eax, [byte esp+08h]
        push eax
        call bcopy
        add esp, byte 0Ch
        push esi
        add ebx, byte 18h
        push ebx
        push dword 0B8000h
        call bcopy
        add esp, byte 0Ch
.1:
        mov eax, edi
        add esp, byte 10h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; RestoreTextScreen                              13061C  97 PC, low confidence
; Puts the saved DOS text screen, video mode and cursor back on exit
;-----------------------------------------------------------------------------
RestoreTextScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 20h
        mov ebx, eax
        test eax, eax
        je short .2
        push eax
        call MemDescPtr
        add esp, byte 4
        mov esi, dword [eax]
        push esi
        lea edx, [byte esp+014h]
        push edx
        mov edi, eax
        add eax, byte 8
        push eax
        mov ebp, dword [byte eax-04h]
        call bcopy
        add esp, byte 0Ch
        mov eax, esp
        call SaveVideoState
        mov eax, dword [byte esp+01Ch]
        mov edx, dword [byte esp+04h]
        cmp eax, edx
        jle short .1
        mov dword [byte esp+01Ch], edx
.1:
        lea eax, [byte esp+010h]
        call RestoreVideoState
        push ebp
        add edi, byte 8
        push dword 0B8000h
        add esi, edi
        push esi
        call bcopy
        add esp, byte 0Ch
        push ebx
        call UnlinkMemBlockLocked
        add esp, byte 4
.2:
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
