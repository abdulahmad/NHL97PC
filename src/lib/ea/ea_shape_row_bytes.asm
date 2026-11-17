; EA library: ShapeRowBytes.
bits 32
%include "hockey.inc"
section s_122D8D progbits alloc exec nowrite align=1
extern ShadeTable
global ShapeRowBytes
        db 00h,00h,00h
;-----------------------------------------------------------------------------
; ShapeRowBytes                                  122D90  97 PC, low confidence
; Returns the number of bytes in one row of a shape for its pixel format
;-----------------------------------------------------------------------------
ShapeRowBytes:
        push ebx
        mov edx, dword [byte esp+08h]
        mov eax, dword [edx]
        and eax, 0FFh
        cmp eax, byte 7Bh
        jne short .1
        mov eax, dword [byte edx+02h]
        sar eax, 10h
        pop ebx
        ret
.1:
        mov eax, edx
        mov eax, dword [eax]
        and eax, byte 7Fh
        mov al, byte [dword eax+ShadeTable]
        mov ebx, eax
        cmp eax, byte 0Fh
        jne short .2
        mov ebx, 10h
.2:
        mov ecx, dword [byte edx+02h]
        sar ecx, 10h
        imul ebx, ecx
        mov eax, dword [edx]
        and eax, 0F0h
        cmp eax, byte 40h
        jne short .3
        lea eax, [byte ebx+0Fh]
        and al, 0F0h
        sar eax, 3
        pop ebx
        ret
.3:
        lea eax, [byte ebx+07h]
        and al, 0F8h
        sar eax, 3
        pop ebx
        ret
