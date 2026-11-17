; 3D library: BuildReciprocalTable.
bits 32
%include "hockey.inc"
section s_10AFF8 progbits alloc exec nowrite align=1
extern ReciprocalBase, ReciprocalTable
global BuildReciprocalTable
        db 00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; BuildReciprocalTable                           10B000  97 PC, low confidence
; Fills the table of fixed-point reciprocals used by the polygon fillers
;-----------------------------------------------------------------------------
BuildReciprocalTable:
        push ebx
        push ecx
        push edx
        xor edx, edx
        mov ecx, 4
        mov dword [ReciprocalTable], edx
.1:
        mov edx, 1
        mov ebx, ecx
        add ecx, byte 4
        mov eax, 0
        div ebx
        inc eax
        mov dword [dword ecx+ReciprocalBase], eax
        cmp ecx, 1004h
        jne short .1
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
