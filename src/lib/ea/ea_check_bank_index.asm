; EA library: CheckBankIndex.
bits 32
%include "hockey.inc"
section s_1072B4 progbits alloc exec nowrite align=1
extern SoundBankTable
global CheckBankIndex
;-----------------------------------------------------------------------------
; CheckBankIndex                                 1072B4  97 PC, low confidence
; Returns 0 when a bank index is valid and in use, otherwise an error
;-----------------------------------------------------------------------------
CheckBankIndex:
        test eax, eax
        jl short .1
        cmp eax, byte 20h
        jl short .2
.1:
        mov eax, 0FFFFFFF8h
        ret
.2:
        cmp dword [nosplit eax*8+SoundBankTable], byte 0
        jne short .3
        mov eax, 0FFFFFFF8h
        ret
.3:
        xor eax, eax
        ret
