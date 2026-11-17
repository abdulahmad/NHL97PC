; 3D library: MultiplyMatrix.
bits 32
%include "hockey.inc"
section s_12D4B8 progbits alloc exec nowrite align=1
global MultiplyMatrix
;-----------------------------------------------------------------------------
; MultiplyMatrix                                 12D4B8  97 PC, low confidence
; Multiplies two 3x3 fixed-point matrices
;-----------------------------------------------------------------------------
MultiplyMatrix:
        push ebp
        LD mov, ebp, esp
        push ebx
        push esi
        push edi
        mov esi, dword [byte ebp+08h]
        mov ebx, dword [byte ebp+0Ch]
        mov edi, dword [byte ebp+010h]
        mov ecx, 9
        push ebp
.1:
        mov eax, dword [esi]
        imul dword [ebx]
        shrd eax, edx, 10h
        LD mov, ebp, eax
        mov eax, dword [byte esi+04h]
        imul dword [byte ebx+0Ch]
        shrd eax, edx, 10h
        LD add, ebp, eax
        mov eax, dword [byte esi+08h]
        imul dword [byte ebx+018h]
        shrd eax, edx, 10h
        LD add, ebp, eax
        mov dword [edi], ebp
        add edi, byte 4
        cmp cl, 7
        je short .2
        cmp cl, 4
        je short .2
        add ebx, byte 4
        dec ecx
        jne short .1
        pop ebp
        pop edi
        pop esi
        pop ebx
        leave
        ret
.2:
        sub ebx, byte 8
        add esi, byte 0Ch
        dec ecx
        jne short .1
