; 3D library: BuildSpanOffsets.
bits 32
%include "hockey.inc"
section s_122DEB progbits alloc exec nowrite align=1
global BuildSpanOffsets
        db 00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; BuildSpanOffsets                               122DF0  97 PC, low confidence
; Fills the column offset table by stepping source coordinates in 16.16 fixed
; point
;-----------------------------------------------------------------------------
BuildSpanOffsets:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov edi, dword [byte esp+018h]
        mov ebx, dword [byte esp+01Ch]
        mov esi, dword [byte esp+020h]
        mov eax, dword [byte esp+02Ch]
        mov ebp, dword [byte esp+030h]
        inc ebp
        sar ebp, 1
        test ebp, ebp
        jle near .5
        lea edx, [byte eax-01h]
        test eax, edx
        jne short .4
        xor edx, edx
        jmp short .2
.1:
        shr eax, 1
        inc edx
.2:
        cmp eax, byte 1
        ja short .1
        mov eax, edx
.3:
        mov edx, esi
        sar edx, 10h
        mov cl, al
        shl edx, cl
        mov dword [esp], edx
        mov edx, ebx
        mov ecx, dword [esp]
        sar edx, 10h
        add ecx, edx
        mov dword [edi], ecx
        mov ecx, dword [byte esp+028h]
        mov edx, dword [byte esp+024h]
        add esi, ecx
        add ebx, edx
        mov edx, esi
        sar edx, 10h
        mov cl, al
        shl edx, cl
        mov dword [esp], edx
        mov edx, ebx
        mov ecx, dword [esp]
        sar edx, 10h
        add edi, byte 8
        add ecx, edx
        mov edx, dword [byte esp+024h]
        mov dword [byte edi-04h], ecx
        mov ecx, dword [byte esp+028h]
        add ebx, edx
        add esi, ecx
        dec ebp
        je short .5
        jmp short .3
.4:
        mov edx, esi
        sar edx, 10h
        imul edx, eax
        mov ecx, ebx
        sar ecx, 10h
        add ecx, edx
        mov dword [edi], ecx
        mov ecx, dword [byte esp+028h]
        mov edx, dword [byte esp+024h]
        add esi, ecx
        add ebx, edx
        mov edx, esi
        sar edx, 10h
        imul edx, eax
        mov dword [esp], edx
        mov edx, ebx
        mov ecx, dword [esp]
        sar edx, 10h
        add edi, byte 8
        add ecx, edx
        mov edx, dword [byte esp+024h]
        mov dword [byte edi-04h], ecx
        mov ecx, dword [byte esp+028h]
        add ebx, edx
        add esi, ecx
        dec ebp
        jne short .4
.5:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
