; 3D library: FixedSinCos.
bits 32
%include "hockey.inc"
section s_115899 progbits alloc exec nowrite align=1
extern IdentityRemap, SinCosLookup
global FixedSinCos, FixedSinCos_70
        db 00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; FixedSinCos                                    1158A0  97 PC, low confidence
; Graphics library: sine and cosine of a fixed-point angle from the table
;-----------------------------------------------------------------------------
FixedSinCos:
        push ebx
        sub esp, byte 8
        mov eax, esp
        push eax
        lea eax, [byte esp+08h]
        push eax
        mov eax, dword [byte esp+018h]
        sar eax, 6
        push eax
        call SinCosLookup
        add esp, byte 0Ch
        mov edx, dword [byte esp+010h]
        and edx, byte 3Fh
        imul edx, dword 6487Eh
        mov eax, dword [esp]
        sar eax, 2
        sar edx, 9
        imul eax, edx
        mov ebx, dword [byte esp+04h]
        sar eax, 15h
        add ebx, eax
        mov eax, dword [byte esp+014h]
        mov dword [eax], ebx
        mov eax, dword [byte esp+04h]
        sar eax, 2
        imul eax, edx
        mov edx, dword [esp]
        sar eax, 15h
        sub edx, eax
        mov eax, dword [byte esp+018h]
        mov dword [eax], edx
        add esp, byte 8
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
FixedSinCos_70:
        push ecx
        push esi
        push edi
        mov edi, eax
        mov ecx, edx
        mov esi, ebx
        xor eax, eax
        test ebx, ebx
        jle near .7
.1:
        mov edx, eax
        sar edx, 1
        add edx, edi
        test al, 1
        je short .2
        mov dl, byte [edx]
        and edx, 0FFh
        sar edx, 4
        jmp short .3
.2:
        mov dl, byte [edx]
        and dl, 0Fh
        and edx, 0FFh
.3:
        and edx, 0FFh
        mov dl, byte [dword edx+IdentityRemap]
        test dl, dl
        je short .6
        mov ebx, eax
        sar ebx, 1
        add ebx, ecx
        test al, 1
        je short .4
        mov bl, byte [ebx]
        and bl, 0Fh
        and ebx, 0FFh
        and edx, 0FFh
        shl edx, 4
        jmp short .5
.4:
        mov bl, byte [ebx]
        and bl, 0F0h
        and ebx, 0FFh
        and edx, 0FFh
.5:
        or edx, ebx
        mov bl, dl
        mov edx, eax
        sar edx, 1
        mov byte [ecx+edx], bl
.6:
        inc eax
        cmp eax, esi
        jl short .1
.7:
        pop edi
        pop esi
        pop ecx
        ret
