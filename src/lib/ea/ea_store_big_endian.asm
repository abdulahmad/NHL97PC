; EA library: StoreBigEndian, StoreLittleEndian.
bits 32
%include "hockey.inc"
section s_123FA8 progbits alloc exec nowrite align=1
global StoreBigEndian, StoreLittleEndian
;-----------------------------------------------------------------------------
; StoreBigEndian                                 123FA8  97 PC, low confidence
; Stores a value byte by byte, most significant first
;-----------------------------------------------------------------------------
StoreBigEndian:
        mov eax, dword [byte esp+04h]
        mov edx, dword [byte esp+08h]
        mov ecx, dword [byte esp+0Ch]
        lea eax, [byte ecx+eax-01h]
        sub ecx, byte 1
        jl short .2
.1:
        mov byte [eax], dl
        shr edx, 8
        sub ecx, byte 1
        lea eax, [byte eax-01h]
        jge short .1
.2:
        ret
;-----------------------------------------------------------------------------
; StoreLittleEndian                              123FCB  97 PC, low confidence
; Stores a value byte by byte, least significant first
;-----------------------------------------------------------------------------
StoreLittleEndian:
        mov eax, dword [byte esp+04h]
        mov edx, dword [byte esp+08h]
        mov ecx, dword [byte esp+0Ch]
        sub ecx, byte 1
        jl short .2
.1:
        mov byte [eax], dl
        shr edx, 8
        sub ecx, byte 1
        lea eax, [byte eax+01h]
        jge short .1
.2:
        ret
