; EA library: RegisterStreamBank.
bits 32
%include "hockey.inc"
section s_10A866 progbits alloc exec nowrite align=1
extern SoundBankTable
global RegisterStreamBank
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; RegisterStreamBank                             10A868  97 PC, low confidence
; Stores a streamed sample bank in a free bank slot and clears its sample
; table
;-----------------------------------------------------------------------------
RegisterStreamBank:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        mov ecx, dword [SoundBankTable]
        xor edx, edx
        xor eax, eax
        test ecx, ecx
        jne short .3
.1:
        mov ecx, eax
        mov dword [dword eax+SoundBankTable], ebx
        xor eax, eax
.2:
        add eax, byte 4
        mov ebx, dword [dword ecx+SoundBankTable]
        mov dword [byte ebx+eax+04h], 0
        cmp eax, 200h
        jne short .2
        mov eax, edx
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        add eax, byte 8
        inc edx
        cmp eax, 100h
        jge short .4
        cmp dword [dword eax+SoundBankTable], byte 0
        je short .1
        jmp short .3
.4:
        mov eax, 0FFFFFFF7h
        pop edx
        pop ecx
        pop ebx
        ret
