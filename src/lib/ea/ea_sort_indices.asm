; EA library: SortIndices.
bits 32
%include "hockey.inc"
section s_100934 progbits alloc exec nowrite align=1
extern SortKeyOffset, SortStride
global SortIndices
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; SortIndices                                 100940  95 PC, medium confidence
; Sort library: sort n indices by their keys (n, keys, indices)
;-----------------------------------------------------------------------------
SortIndices:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov edi, dword [byte esp+038h]
        mov edx, 1
        mov ebx, dword [byte esp+030h]
        mov dword [byte esp+04h], edx
        mov edx, dword [SortKeyOffset]
        mov eax, 4
        cmp edx, ebx
        jge short .2
        mov esi, dword [byte esp+030h]
.1:
        mov ecx, dword [byte esp+04h]
        mov edx, dword [dword eax+SortKeyOffset]
        inc ecx
        add eax, byte 4
        mov dword [byte esp+04h], ecx
        cmp edx, esi
        jl short .1
.2:
        mov eax, dword [byte esp+04h]
        shl eax, 2
        mov dword [esp], eax
.3:
        mov ebp, dword [esp]
        mov eax, dword [byte esp+04h]
        sub ebp, byte 4
        mov edx, dword [byte esp+030h]
        dec eax
        mov esi, dword [dword ebp+SortStride]
        mov dword [esp], ebp
        mov dword [byte esp+04h], eax
        mov dword [byte esp+014h], esi
        cmp esi, edx
        jge near .7
        lea eax, [nosplit esi*4+00h]
        mov ebx, dword [byte esp+034h]
        lea edx, [eax+edi]
        add eax, ebx
        mov dword [byte esp+010h], edx
        mov dword [byte esp+0Ch], eax
.4:
        mov eax, dword [byte esp+0Ch]
        mov eax, dword [eax]
        mov dword [byte esp+018h], eax
        mov eax, dword [byte esp+010h]
        mov eax, dword [eax]
        mov dword [byte esp+08h], eax
        mov eax, dword [byte esp+014h]
        sub eax, esi
.5:
        mov ebx, dword [byte esp+034h]
        lea ecx, [nosplit eax*4+00h]
        add ebx, ecx
        mov ebp, dword [byte esp+018h]
        cmp ebp, dword [ebx]
        jle short .6
        lea edx, [eax+esi]
        mov ebp, dword [byte esp+034h]
        shl edx, 2
        add ebp, edx
        mov ebx, dword [ebx]
        mov dword [byte ebp+00h], ebx
        sub eax, esi
        mov ebx, dword [ecx+edi]
        mov dword [edx+edi], ebx
        test eax, eax
        jge short .5
.6:
        mov edx, dword [byte esp+034h]
        mov ebx, dword [byte esp+018h]
        mov ecx, dword [byte esp+0Ch]
        mov ebp, dword [byte esp+014h]
        add eax, esi
        add ecx, byte 4
        inc ebp
        mov dword [edx+eax*4], ebx
        mov edx, dword [byte esp+08h]
        mov ebx, dword [byte esp+010h]
        mov dword [byte esp+0Ch], ecx
        mov dword [byte esp+014h], ebp
        add ebx, byte 4
        mov dword [edi+eax*4], edx
        mov edx, dword [byte esp+030h]
        mov dword [byte esp+010h], ebx
        cmp ebp, edx
        jl near .4
.7:
        cmp esi, byte 1
        jg near .3
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 00h
