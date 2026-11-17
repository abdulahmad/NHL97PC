; 3D library: ProjectPointsPersp.
bits 32
%include "hockey.inc"
section s_12D2F3 progbits alloc exec nowrite align=1
extern CameraCosYaw, CameraFlags, CameraSinYaw, str_D_ProjectPointsPersp, ViewCenterY
global ProjectPointsPersp
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; ProjectPointsPersp                             12D300  97 PC, low confidence
; Projects a list of view-space points to the screen with perspective
;-----------------------------------------------------------------------------
ProjectPointsPersp:
        push ebx
        push esi
        push edi
        push ebp
        mov ebp, dword [byte esp+014h]
        mov ebx, dword [byte esp+018h]
        mov ecx, dword [byte esp+01Ch]
        cmp ebp, byte 4
        jl near .10
.1:
        mov edi, ecx
        mov esi, ebx
        cmp dword [byte esi+08h], byte 0
        jle short .2
        mov eax, dword [esi]
        imul dword [CameraSinYaw]
        idiv dword [byte esi+08h]
        add eax, dword [ViewCenterY]
        mov dword [edi], eax
        mov eax, dword [byte esi+04h]
        imul dword [CameraCosYaw]
        idiv dword [byte esi+08h]
        add eax, dword [str_D_ProjectPointsPersp]
        mov dword [byte edi+04h], eax
        jmp short .3
.2:
        mov dword [edi], 80000000h
        mov dword [byte edi+04h], 80000000h
        or dword [CameraFlags], byte 1
.3:
        add ecx, byte 8
        add ebx, byte 0Ch
        mov edi, ecx
        mov esi, ebx
        cmp dword [byte esi+08h], byte 0
        jle short .4
        mov eax, dword [esi]
        imul dword [CameraSinYaw]
        idiv dword [byte esi+08h]
        add eax, dword [ViewCenterY]
        mov dword [edi], eax
        mov eax, dword [byte esi+04h]
        imul dword [CameraCosYaw]
        idiv dword [byte esi+08h]
        add eax, dword [str_D_ProjectPointsPersp]
        mov dword [byte edi+04h], eax
        jmp short .5
.4:
        mov dword [edi], 80000000h
        mov dword [byte edi+04h], 80000000h
        or dword [CameraFlags], byte 1
.5:
        add ecx, byte 8
        add ebx, byte 0Ch
        mov edi, ecx
        mov esi, ebx
        cmp dword [byte esi+08h], byte 0
        jle short .6
        mov eax, dword [esi]
        imul dword [CameraSinYaw]
        idiv dword [byte esi+08h]
        add eax, dword [ViewCenterY]
        mov dword [edi], eax
        mov eax, dword [byte esi+04h]
        imul dword [CameraCosYaw]
        idiv dword [byte esi+08h]
        add eax, dword [str_D_ProjectPointsPersp]
        mov dword [byte edi+04h], eax
        jmp short .7
.6:
        mov dword [edi], 80000000h
        mov dword [byte edi+04h], 80000000h
        or dword [CameraFlags], byte 1
.7:
        add ecx, byte 8
        add ebx, byte 0Ch
        mov edi, ecx
        mov esi, ebx
        sub ebp, byte 4
        cmp dword [byte esi+08h], byte 0
        jle short .8
        mov eax, dword [esi]
        imul dword [CameraSinYaw]
        idiv dword [byte esi+08h]
        add eax, dword [ViewCenterY]
        mov dword [edi], eax
        mov eax, dword [byte esi+04h]
        imul dword [CameraCosYaw]
        idiv dword [byte esi+08h]
        add eax, dword [str_D_ProjectPointsPersp]
        mov dword [byte edi+04h], eax
        jmp short .9
.8:
        mov dword [edi], 80000000h
        mov dword [byte edi+04h], 80000000h
        or dword [CameraFlags], byte 1
.9:
        add ebx, byte 0Ch
        add ecx, byte 8
        cmp ebp, byte 4
        jge near .1
.10:
        cmp ebp, byte 1
        jl short .13
        mov edi, ecx
        mov esi, ebx
        cmp dword [byte esi+08h], byte 0
        jle short .11
        mov eax, dword [esi]
        imul dword [CameraSinYaw]
        idiv dword [byte esi+08h]
        add eax, dword [ViewCenterY]
        mov dword [edi], eax
        mov eax, dword [byte esi+04h]
        imul dword [CameraCosYaw]
        idiv dword [byte esi+08h]
        add eax, dword [str_D_ProjectPointsPersp]
        mov dword [byte edi+04h], eax
        jmp short .12
.11:
        mov dword [edi], 80000000h
        mov dword [byte edi+04h], 80000000h
        or dword [CameraFlags], byte 1
.12:
        dec ebp
        add ebx, byte 0Ch
        add ecx, byte 8
        jmp short .10
.13:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
