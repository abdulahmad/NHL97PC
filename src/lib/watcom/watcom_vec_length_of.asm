; Watcom C runtime: VecLengthOf.
bits 32
%include "hockey.inc"
section s_12D6A0 progbits alloc exec nowrite align=1
extern vecdist
global VecLengthOf
;-----------------------------------------------------------------------------
; VecLengthOf                                    12D6A0  97 PC, low confidence
; Returns the length of a 3-component vector
;-----------------------------------------------------------------------------
VecLengthOf:
        push ebx
        mov eax, dword [byte esp+08h]
        mov edx, dword [byte eax+08h]
        push edx
        mov ebx, dword [byte eax+04h]
        push ebx
        mov ecx, dword [eax]
        push ecx
        call vecdist
        add esp, byte 8
        push eax
        call vecdist
        add esp, byte 8
        pop ebx
        ret
        db 00h
