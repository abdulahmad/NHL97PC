; 3D library: AddVec3, SubVec3, ScaleVec3.
bits 32
%include "hockey.inc"
section s_10C8B0 progbits alloc exec nowrite align=1
extern VecLengthOf
global AddVec3, SubVec3, ScaleVec3
;-----------------------------------------------------------------------------
; AddVec3                                        10C8B0  97 PC, low confidence
; Adds two 3-component vectors
;-----------------------------------------------------------------------------
AddVec3:
        push ebx
        push esi
        push edi
        push ebp
        mov ecx, dword [byte esp+014h]
        mov ebx, dword [byte esp+018h]
        mov edx, dword [byte esp+01Ch]
        mov eax, dword [ecx]
        mov esi, dword [ebx]
        add eax, esi
        mov dword [edx], eax
        mov eax, dword [byte ecx+04h]
        mov edi, dword [byte ebx+04h]
        add eax, edi
        mov dword [byte edx+04h], eax
        mov eax, dword [byte ecx+08h]
        mov ebp, dword [byte ebx+08h]
        add eax, ebp
        mov dword [byte edx+08h], eax
        mov eax, edx
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SubVec3                                        10C8E8  97 PC, low confidence
; Subtracts one 3-component vector from another
;-----------------------------------------------------------------------------
SubVec3:
        push ebx
        push esi
        push edi
        push ebp
        mov ecx, dword [byte esp+014h]
        mov ebx, dword [byte esp+018h]
        mov edx, dword [byte esp+01Ch]
        mov eax, dword [ecx]
        mov esi, dword [ebx]
        sub eax, esi
        mov dword [edx], eax
        mov eax, dword [byte ecx+04h]
        mov edi, dword [byte ebx+04h]
        sub eax, edi
        mov dword [byte edx+04h], eax
        mov eax, dword [byte ecx+08h]
        mov ebp, dword [byte ebx+08h]
        sub eax, ebp
        mov dword [byte edx+08h], eax
        mov eax, edx
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ScaleVec3                                      10C920  97 PC, low confidence
; Multiplies a 3-component vector by a 16.16 factor
;-----------------------------------------------------------------------------
ScaleVec3:
        push ebx
        push esi
        mov esi, dword [byte esp+0Ch]
        mov ebx, dword [byte esp+010h]
        mov ecx, dword [byte esp+014h]
        mov edx, ebx
        mov eax, dword [esi]
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov dword [ecx], eax
        mov edx, ebx
        mov eax, dword [byte esi+04h]
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov dword [byte ecx+04h], eax
        mov edx, ebx
        mov eax, dword [byte esi+08h]
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov dword [byte ecx+08h], eax
        mov eax, ecx
        pop esi
        pop ebx
        ret
        push ebx
        push esi
        push edi
        sub esp, byte 0Ch
        mov ebx, dword [byte esp+01Ch]
        mov edx, dword [byte esp+020h]
        mov eax, dword [ebx]
        mov ecx, dword [edx]
        sub eax, ecx
        mov dword [esp], eax
        mov eax, dword [byte ebx+04h]
        mov esi, dword [byte edx+04h]
        sub eax, esi
        mov dword [byte esp+04h], eax
        mov eax, dword [byte ebx+08h]
        mov edi, dword [byte edx+08h]
        sub eax, edi
        mov dword [byte esp+08h], eax
        mov eax, esp
        push eax
        call VecLengthOf
        add esp, byte 4
        add esp, byte 0Ch
        pop edi
        pop esi
        pop ebx
        ret
