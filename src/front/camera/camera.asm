; Game camera: spline, ease and smoothing, targets, motion and projection.
bits 32
%include "hockey.inc"
section s_5D2E5 progbits alloc exec nowrite align=1
extern CameraStateRecords, CamSmoothMinX, CamSmoothMinY, CamSmoothStepX, CamSmoothStepY, ClearIfNaN, ClipProjectPoints, F32_2_CameraEasePoint
extern F32_2_CameraSplinePoint, F32_2_SetCameraTarget, F32_2_UpdateCameraMotion, F32_3_CameraEasePoint, F32_3_CameraSplinePoint, F32_3_SetCameraTarget, F32_3_UpdateCameraMotion, F32_50p0_View
extern F32_ViewAngle, F64_0p1_CameraSplinePoint, F64_3p14159_CameraSmoothStep, F64_6p28319_CameraSmoothStep, F64_neg3p14159_CameraSmoothStep, F64_neg6p28319_CameraSmoothStep, FloatsToInts, MatMul
extern MatRotX, MatRotY, MatTranspose, ProjectPoints, str_Punct_DrawRinkSurface, VecAdd, VecMulMat, VecSub
global CameraSplinePoint, CameraLerpPoint, CameraEasePoint, ResetCameraState, CopyCameraState, CameraSmoothStep, SetCameraTarget, SetCameraPathTarget
global SetCameraSplineTarget, UpdateCameraMotion, SnapCamera, BuildCameraMatrix, UpdateCameraProjection, ProjectRinkPoints, InitCameraParams
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; CameraSplinePoint                               5D2F0  97 PC, low confidence
; Camera motion: point on the camera spline
;-----------------------------------------------------------------------------
CameraSplinePoint:
        push ebx
        push ecx
        push ebp
        mov ebp, esp
        sub esp, byte 18h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov eax, dword [byte eax+08h]
        mov eax, dword [eax]
        mov dword [byte esp+014h], eax
        cmp edx, byte 0Ch
        jge short .1
        mov ecx, edx
        jmp short .2
.1:
        mov ecx, 0Ch
.2:
        mov edx, dword [ebx]
        mov eax, dword [byte ebx+04h]
        fld dword [edx]
        fsub dword [eax]
        mov eax, ecx
        shl ecx, 2
        add ecx, eax
        xor edx, edx
        add ecx, ecx
        fstp dword [byte esp+010h]
        test ecx, ecx
        jle near .6
.3:
        fld dword [byte esp+014h]
        fld dword [byte ebx+0Ch]
        fmul st1
        fld dword [byte ebx+010h]
        fmul dword [byte esp+010h]
        faddp
        fmul qword [F64_0p1_CameraSplinePoint]
        fld st1
        fmul qword [F64_0p1_CameraSplinePoint]
        fld dword [byte ebx+014h]
        fchs
        fxch st2
        fsubp st3
        fxch
        fstp dword [byte esp+08h]
        fxch
        fstp dword [byte esp+0Ch]
        fld dword [byte esp+010h]
        fxch
        fadd st1
        fld dword [byte esp+0Ch]
        fxch
        fstp st2
        fxch
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+08h]
        fnstsw ax
        sahf
        jae short .4
        mov eax, dword [byte esp+08h]
        mov dword [byte esp+0Ch], eax
.4:
        fld dword [byte esp+0Ch]
        fcomp dword [byte ebx+014h]
        fnstsw ax
        sahf
        jbe short .5
        mov eax, dword [byte ebx+014h]
        mov dword [byte esp+0Ch], eax
.5:
        mov eax, dword [byte esp+0Ch]
        inc edx
        mov dword [byte esp+014h], eax
        cmp edx, ecx
        jl short .3
.6:
        mov eax, dword [byte ebx+04h]
        fld dword [byte esp+010h]
        fadd dword [eax]
        mov eax, dword [ebx]
        fstp dword [eax]
        mov eax, dword [byte ebx+08h]
        mov edx, dword [byte esp+014h]
        mov dword [eax], edx
        mov esp, ebp
        pop ebp
        pop ecx
        pop ebx
        ret
        push edx
        fld dword [byte esp+08h]
        fld dword [byte esp+010h]
        fld st0
        fsub dword [byte esp+08h]
        fxch st2
        fsubrp
        fxch
        fmul dword [F32_3_CameraSplinePoint]
        fxch
        fmul dword [F32_2_CameraSplinePoint]
        fxch
        fld dword [byte esp+014h]
        fxch
        fsub st1
        mov edx, dword [byte esp+0Ch]
        fld dword [byte esp+0Ch]
        fmul dword [F32_2_CameraSplinePoint]
        mov dword [byte eax+08h], edx
        mov edx, dword [byte esp+08h]
        fld dword [byte esp+0Ch]
        faddp st3
        mov dword [byte eax+0Ch], edx
        fxch st2
        faddp st3
        fsubrp
        fxch
        fstp dword [eax]
        fstp dword [byte eax+04h]
        pop edx
        ret 10h
;-----------------------------------------------------------------------------
; CameraLerpPoint                                 5D428  97 PC, low confidence
; Camera motion: linear step toward the target point
;-----------------------------------------------------------------------------
CameraLerpPoint:
        push edx
        sub esp, byte 4
        mov edx, dword [eax]
        mov dword [esp], edx
        fld dword [byte esp+0Ch]
        fld dword [esp]
        fmul st1
        fadd dword [byte eax+04h]
        fmul st1
        fadd dword [byte eax+08h]
        fmulp
        fadd dword [byte eax+0Ch]
        fst dword [esp]
        add esp, byte 4
        pop edx
        ret 4
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CameraEasePoint                                 5D454  97 PC, low confidence
; Camera motion: eased step toward the target point
;-----------------------------------------------------------------------------
CameraEasePoint:
        sub esp, byte 4
        fld dword [eax]
        fmul dword [F32_3_CameraEasePoint]
        fld st0
        fld dword [byte esp+08h]
        fxch
        fmul st1
        fld dword [byte eax+04h]
        fmul dword [F32_2_CameraEasePoint]
        fxch
        fstp st3
        faddp st2
        fmulp
        fld st0
        fadd dword [byte eax+08h]
        fstp st1
        add esp, byte 4
        ret 4
        db 090h
;-----------------------------------------------------------------------------
; ResetCameraState                                5D488  97 PC, low confidence
; Clears the camera state block
;-----------------------------------------------------------------------------
ResetCameraState:
        push edx
        mov edx, eax
        shl eax, 3
        sub eax, edx
        shl eax, 2
        add eax, CameraStateRecords+093h
        mov edx, dword [byte esp+08h]
        mov dword [byte eax+0Ch], edx
        mov edx, dword [byte esp+0Ch]
        mov dword [byte eax+010h], edx
        mov edx, dword [byte esp+010h]
        mov dword [byte eax+014h], edx
        pop edx
        ret 0Ch
        db 08Dh,040h,00h
        push edx
        mov eax, dword [byte esp+08h]
        mov dword [CameraStateRecords+09Fh], eax
        mov eax, dword [byte esp+0Ch]
        mov dword [CameraStateRecords+0A3h], eax
        mov eax, dword [byte esp+010h]
        mov dword [CameraStateRecords+0A7h], eax
        mov eax, CameraStateRecords+093h
        add eax, byte 1Ch
        mov edx, dword [byte esp+08h]
        mov dword [byte eax+0Ch], edx
        mov edx, dword [byte esp+0Ch]
        mov dword [byte eax+010h], edx
        mov edx, dword [byte esp+010h]
        mov dword [byte eax+014h], edx
        mov eax, CameraStateRecords+093h
        add eax, byte 38h
        mov edx, dword [byte esp+08h]
        mov dword [byte eax+0Ch], edx
        mov edx, dword [byte esp+0Ch]
        mov dword [byte eax+010h], edx
        mov edx, dword [byte esp+010h]
        mov dword [byte eax+014h], edx
        pop edx
        ret 0Ch
        db 08Bh,0C0h
        push edx
        mov eax, CameraStateRecords+093h
        add eax, byte 54h
        mov edx, dword [byte esp+08h]
        mov dword [byte eax+0Ch], edx
        mov edx, dword [byte esp+0Ch]
        mov dword [byte eax+010h], edx
        mov edx, dword [byte esp+010h]
        mov dword [byte eax+014h], edx
        mov eax, CameraStateRecords+093h
        add eax, byte 70h
        mov edx, dword [byte esp+08h]
        mov dword [byte eax+0Ch], edx
        mov edx, dword [byte esp+0Ch]
        mov dword [byte eax+010h], edx
        mov edx, dword [byte esp+010h]
        mov dword [byte eax+014h], edx
        mov eax, CameraStateRecords+093h
        add eax, 8Ch
        mov edx, dword [byte esp+08h]
        mov dword [byte eax+0Ch], edx
        mov edx, dword [byte esp+0Ch]
        mov dword [byte eax+010h], edx
        mov edx, dword [byte esp+010h]
        mov dword [byte eax+014h], edx
        pop edx
        ret 0Ch
        db 08Bh,0C0h
        push edx
        mov eax, CameraStateRecords+093h
        add eax, 0A8h
        mov edx, dword [byte esp+08h]
        mov dword [byte eax+0Ch], edx
        mov edx, dword [byte esp+0Ch]
        mov dword [byte eax+010h], edx
        mov edx, dword [byte esp+010h]
        mov dword [byte eax+014h], edx
        pop edx
        ret 0Ch
;-----------------------------------------------------------------------------
; CopyCameraState                                 5D594  97 PC, low confidence
; Copies the camera position and target into the work block
;-----------------------------------------------------------------------------
CopyCameraState:
        push ebx
        push ecx
        push edx
        mov byte [dword eax+CameraStateRecords], 1
        lea edx, [nosplit eax*4+00h]
        mov ebx, eax
        shl eax, 3
        mov ecx, CameraStateRecords+7
        sub eax, ebx
        add ecx, edx
        mov ebx, CameraStateRecords+23h
        mov dword [nosplit eax*4+CameraStateRecords+093h], ecx
        add ebx, edx
        add edx, CameraStateRecords+3Fh
        mov dword [nosplit eax*4+CameraStateRecords+097h], ebx
        mov dword [nosplit eax*4+CameraStateRecords+09Bh], edx
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CameraSmoothStep                                5D5DC  97 PC, low confidence
; Camera motion: smoothed step of position and target
;-----------------------------------------------------------------------------
CameraSmoothStep:
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        and esp, byte 0FFFFFFF8h
        cmp eax, byte 3
        jl short .2
        cmp eax, byte 5
        jg short .2
        fld dword [edx]
        fsub dword [byte ebp+08h]
        fst qword [byte esp+08h]
        fcomp qword [F64_3p14159_CameraSmoothStep]
        fnstsw ax
        sahf
        jbe short .1
        fld dword [edx]
        fadd qword [F64_neg6p28319_CameraSmoothStep]
        mov eax, 1
        fstp dword [edx]
        jmp short .3
.1:
        fld qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_CameraSmoothStep]
        fnstsw ax
        sahf
        jae short .2
        fld dword [edx]
        fld st0
        fadd qword [F64_6p28319_CameraSmoothStep]
        mov eax, 1
        fstp st1
        fstp dword [edx]
        jmp short .3
.2:
        xor eax, eax
.3:
        mov esp, ebp
        pop ebp
        ret 4
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        fld dword [byte ebp+08h]
        fsub dword [byte ebp+0Ch]
        fstp dword [byte esp+010h]
        cmp eax, byte 3
        jl short .5
        cmp eax, byte 5
        jg short .5
        fld dword [byte esp+010h]
        fst qword [esp]
        fcomp qword [CamSmoothMinX]
        fnstsw ax
        sahf
        jbe short .4
        fld qword [esp]
        fadd qword [CamSmoothStepX]
        fstp dword [byte esp+010h]
.4:
        fld dword [byte esp+010h]
        fst qword [byte esp+08h]
        fcomp qword [CamSmoothMinY]
        fnstsw ax
        sahf
        jae short .5
        fld qword [byte esp+08h]
        fadd qword [CamSmoothStepY]
        fstp dword [byte esp+010h]
.5:
        fld dword [byte esp+010h]
        mov esp, ebp
        pop ebp
        ret 8
        db 090h
;-----------------------------------------------------------------------------
; SetCameraTarget                                 5D6A8  97 PC, low confidence
; Sets where the camera moves to
;-----------------------------------------------------------------------------
SetCameraTarget:
        push ebx
        push ecx
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov dword [byte esp+010h], edx
        shl eax, 3
        add eax, ecx
        mov ebx, CameraStateRecords+157h
        shl eax, 2
        add ebx, eax
        lea eax, [byte ebp+010h]
        call ClearIfNaN
        test eax, eax
        jne near .1
        lea eax, [byte ebp+014h]
        call ClearIfNaN
        test eax, eax
        jne near .1
        fild dword [byte esp+010h]
        fld1
        fdivrp
        mov byte [dword ecx+CameraStateRecords], 2
        mov eax, dword [nosplit ecx*4+CameraStateRecords+7]
        mov dword [byte ebx+010h], eax
        fld dword [nosplit ecx*4+CameraStateRecords+3Fh]
        mov dword [byte ebx+01Ch], 0
        mov eax, ecx
        fstp dword [byte ebx+014h]
        mov dword [byte ebx+020h], edx
        lea edx, [byte ebx+010h]
        fstp dword [byte ebx+018h]
        push dword [byte ebp+010h]
        call CameraSmoothStep
        fild dword [byte ebx+020h]
        fld dword [nosplit ecx*4+CameraStateRecords+3Fh]
        fmul st1
        fld dword [byte ebp+014h]
        mov eax, dword [nosplit ecx*4+CameraStateRecords+7]
        fmulp st2
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte ebp+010h]
        mov dword [byte esp+08h], eax
        fld dword [byte esp+0Ch]
        fld dword [byte esp+08h]
        fsub dword [byte esp+0Ch]
        fxch
        fsub dword [byte ebp+010h]
        fxch
        fmul dword [F32_3_SetCameraTarget]
        fxch
        fmul dword [F32_2_SetCameraTarget]
        fxch
        fsub st3
        fxch st2
        fst dword [byte esp+04h]
        fmul dword [F32_2_SetCameraTarget]
        mov eax, dword [byte esp+04h]
        fld dword [byte esp+04h]
        mov dword [byte ebx+08h], eax
        mov eax, dword [byte esp+0Ch]
        faddp st4
        mov dword [byte ebx+0Ch], eax
        fxch st3
        faddp
        fxch st2
        fsubp
        fxch
        fstp dword [ebx]
        fstp dword [byte ebx+04h]
.1:
        mov esp, ebp
        pop ebp
        pop ecx
        pop ebx
        ret 8
;-----------------------------------------------------------------------------
; SetCameraPathTarget                             5D7A4  97 PC, low confidence
; Sets a camera target reached along a path
;-----------------------------------------------------------------------------
SetCameraPathTarget:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebx, eax
        mov esi, edx
        shl eax, 3
        add eax, ebx
        mov ebp, CameraStateRecords+157h
        shl eax, 2
        add ebp, eax
        lea eax, [nosplit ebx*8+00h]
        push byte 0
        sub eax, ebx
        mov edi, CameraStateRecords+093h
        shl eax, 2
        lea ecx, [nosplit ebx*4+00h]
        add edi, eax
        mov eax, ebx
        push dword [dword ecx+CameraStateRecords+23h]
        call SetCameraTarget
        mov byte [dword ebx+CameraStateRecords], 3
        mov eax, CameraStateRecords+5Bh
        add eax, ecx
        mov dword [edi], eax
        mov eax, CameraStateRecords+77h
        add eax, ecx
        mov dword [byte edi+08h], eax
        mov eax, CameraStateRecords+23h
        add eax, ecx
        xor edx, edx
        mov dword [byte edi+04h], eax
        mov dword [dword ecx+CameraStateRecords+77h], edx
        mov eax, dword [dword ecx+CameraStateRecords+23h]
        mov dword [dword ecx+CameraStateRecords+5Bh], eax
        mov dword [byte ebp+020h], esi
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push edx
        mov ebx, eax
        lea eax, [byte esp+0Ch]
        call ClearIfNaN
        test eax, eax
        jne short .1
        lea eax, [byte esp+010h]
        call ClearIfNaN
        test eax, eax
        jne short .1
        mov eax, dword [byte esp+0Ch]
        mov dword [CameraStateRecords+2Fh], eax
        mov eax, dword [byte esp+010h]
        mov edx, ebx
        mov dword [CameraStateRecords+33h], eax
        mov eax, 3
        call SetCameraPathTarget
        mov eax, 4
        mov edx, ebx
        call SetCameraPathTarget
.1:
        pop edx
        pop ebx
        ret 8
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetCameraSplineTarget                           5D878  97 PC, low confidence
; Sets a camera target reached along a spline
;-----------------------------------------------------------------------------
SetCameraSplineTarget:
        push ecx
        push esi
        mov ecx, eax
        mov esi, edx
        push dword [ebx]
        push dword [edx]
        mov edx, eax
        xor eax, eax
        call SetCameraTarget
        push dword [byte ebx+04h]
        mov eax, 1
        mov edx, ecx
        push dword [byte esi+04h]
        call SetCameraTarget
        push dword [byte ebx+08h]
        mov eax, 2
        mov edx, ecx
        push dword [byte esi+08h]
        call SetCameraTarget
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
        push ebx
        push edx
        mov ebx, eax
        push dword [byte esp+010h]
        mov edx, eax
        mov eax, 3
        push dword [byte esp+010h]
        call SetCameraTarget
        push dword [byte esp+018h]
        mov eax, 4
        mov edx, ebx
        push dword [byte esp+018h]
        call SetCameraTarget
        pop edx
        pop ebx
        ret 10h
        db 08Dh,040h,00h
        push edx
        push byte 0
        mov edx, eax
        mov eax, 6
        push dword [byte esp+0Ch]
        call SetCameraTarget
        pop edx
        ret 4
        db 090h
;-----------------------------------------------------------------------------
; UpdateCameraMotion                              5D900  97 PC, low confidence
; Moves the camera one frame toward its target
;-----------------------------------------------------------------------------
UpdateCameraMotion:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        mov ebp, dword [byte esp+034h]
        mov dword [byte esp+010h], eax
        mov esi, edx
        lea eax, [byte esp+030h]
        call ClearIfNaN
        test eax, eax
        je short .1
        mov eax, dword [nosplit edx*4+CameraStateRecords+23h]
        mov dword [byte esp+030h], eax
.1:
        lea edx, [nosplit esi*4+00h]
        add edx, CameraStateRecords+7
        mov eax, esi
        push dword [byte esp+030h]
        call CameraSmoothStep
        cmp dword [byte esp+010h], byte 1
        jge short .2
        mov dword [byte esp+010h], 1
.2:
        lea ecx, [nosplit esi*4+00h]
        cmp ebp, byte 4
        jb short .3
        jbe near .9
        cmp ebp, byte 5
        je near .10
        jmp near .11
.3:
        test ebp, ebp
        jne near .11
        lea eax, [nosplit esi*8+00h]
        sub eax, esi
        mov edi, CameraStateRecords+093h
        shl eax, 2
        mov dl, byte [dword esi+CameraStateRecords]
        add edi, eax
        cmp dl, 2
        jb short .4
        lea eax, [nosplit esi*8+00h]
        add eax, esi
        mov ebx, CameraStateRecords+157h
        shl eax, 2
        add ebx, eax
        cmp dl, 2
        jbe short .5
        cmp dl, 3
        je near .7
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 8
.4:
        cmp dl, 1
        jne near .11
        mov eax, dword [byte esp+030h]
        mov edx, dword [byte esp+010h]
        mov dword [dword ecx+CameraStateRecords+23h], eax
        mov eax, edi
        call CameraSplinePoint
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 8
.5:
        mov eax, dword [byte esp+030h]
        mov dword [dword ecx+CameraStateRecords+23h], eax
        mov eax, dword [byte esp+010h]
        mov ebp, dword [byte ebx+01Ch]
        add ebp, eax
        mov edx, dword [byte ebx+020h]
        mov dword [byte ebx+01Ch], ebp
        cmp ebp, edx
        jl short .6
        mov eax, ebx
        push dword 3F800000h
        call CameraLerpPoint
        push dword 3F800000h
        mov eax, ebx
        fstp dword [dword ecx+CameraStateRecords+7]
        call CameraEasePoint
        fmul dword [byte ebx+018h]
        mov ah, 1
        fstp dword [dword ecx+CameraStateRecords+3Fh]
        mov byte [dword esi+CameraStateRecords], ah
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 8
.6:
        fild dword [byte ebx+01Ch]
        fmul dword [byte ebx+018h]
        mov eax, ebx
        fstp dword [esp]
        push dword [esp]
        call CameraLerpPoint
        push dword [esp]
        mov eax, ebx
        fstp dword [dword ecx+CameraStateRecords+7]
        call CameraEasePoint
        fmul dword [byte ebx+018h]
        fstp dword [dword ecx+CameraStateRecords+3Fh]
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 8
.7:
        mov eax, dword [byte esp+030h]
        mov dword [dword ecx+CameraStateRecords+23h], eax
        mov eax, dword [byte esp+010h]
        mov edx, dword [byte ebx+020h]
        cmp eax, edx
        jle short .8
        mov eax, edi
        call CameraSplinePoint
        mov eax, esi
        call CopyCameraState
        fld dword [dword ecx+CameraStateRecords+77h]
        fld dword [dword ecx+CameraStateRecords+5Bh]
        mov eax, dword [byte esp+010h]
        push ebp
        fxch
        fstp dword [dword ecx+CameraStateRecords+3Fh]
        fstp dword [dword ecx+CameraStateRecords+7]
        mov edi, dword [byte ebx+020h]
        mov edx, esi
        sub eax, edi
        push dword [byte esp+034h]
        call UpdateCameraMotion
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 8
.8:
        mov edx, eax
        mov eax, edi
        call CameraSplinePoint
        fild dword [byte ebx+020h]
        fld1
        fdivrp
        fild dword [byte ebx+020h]
        fxch
        fstp dword [byte ebx+018h]
        fmul dword [dword ecx+CameraStateRecords+77h]
        fild dword [byte esp+010h]
        fmul dword [byte ebx+018h]
        fild dword [byte ebx+020h]
        fld dword [dword ecx+CameraStateRecords+3Fh]
        fmul st1
        mov eax, dword [dword ecx+CameraStateRecords+7]
        fld dword [dword ecx+CameraStateRecords+77h]
        mov dword [byte esp+014h], eax
        fmulp st2
        fld dword [byte esp+014h]
        fxch st4
        fadd dword [dword ecx+CameraStateRecords+5Bh]
        fld st0
        fsub dword [byte esp+014h]
        fxch st5
        fsubrp
        fxch st4
        fmul dword [F32_3_UpdateCameraMotion]
        fxch st4
        fmul dword [F32_2_UpdateCameraMotion]
        fxch st4
        fsub st2
        fxch
        fst dword [byte esp+0Ch]
        fmul dword [F32_2_UpdateCameraMotion]
        mov eax, dword [byte esp+0Ch]
        fxch st3
        fstp dword [byte esp+04h]
        mov dword [byte ebx+08h], eax
        mov eax, dword [byte esp+014h]
        push dword [byte esp+04h]
        mov dword [byte ebx+0Ch], eax
        fld dword [byte esp+010h]
        faddp st2
        mov eax, ebx
        fxch
        faddp st3
        fsubrp
        fxch
        fstp dword [ebx]
        fstp dword [byte ebx+04h]
        call CameraLerpPoint
        push dword [byte esp+04h]
        mov eax, ebx
        fstp dword [dword ecx+CameraStateRecords+7]
        call CameraEasePoint
        fmul dword [byte ebx+018h]
        mov eax, dword [byte esp+010h]
        fstp dword [dword ecx+CameraStateRecords+3Fh]
        sub dword [byte ebx+020h], eax
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 8
.9:
        mov eax, dword [byte esp+030h]
        xor edi, edi
        mov dword [dword ecx+CameraStateRecords+7], eax
        mov dword [dword ecx+CameraStateRecords+3Fh], edi
        fld dword [dword ecx+CameraStateRecords+7]
        mov eax, esi
        fstp dword [dword ecx+CameraStateRecords+23h]
        call CopyCameraState
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 8
.10:
        fld dword [dword ecx+CameraStateRecords+7]
        fsub dword [byte esp+030h]
        fild dword [byte esp+010h]
        fdivp
        mov eax, dword [byte esp+030h]
        mov dword [dword ecx+CameraStateRecords+7], eax
        fld dword [dword ecx+CameraStateRecords+7]
        mov eax, esi
        fstp dword [dword ecx+CameraStateRecords+23h]
        fstp dword [dword ecx+CameraStateRecords+3Fh]
        call CopyCameraState
.11:
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 8
        db 090h
;-----------------------------------------------------------------------------
; SnapCamera                                      5DC1C  97 PC, low confidence
; Puts the camera at its target at once
;-----------------------------------------------------------------------------
SnapCamera:
        push ecx
        push esi
        mov ecx, eax
        mov esi, edx
        push ebx
        push dword [edx]
        xor edx, edx
        call UpdateCameraMotion
        push ebx
        mov edx, 1
        mov eax, ecx
        push dword [byte esi+04h]
        call UpdateCameraMotion
        push ebx
        mov edx, 2
        mov eax, ecx
        push dword [byte esi+08h]
        call UpdateCameraMotion
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; BuildCameraMatrix                               5DC50  97 PC, low confidence
; Builds the camera matrix
;-----------------------------------------------------------------------------
BuildCameraMatrix:
        push ebx
        push ecx
        push edx
        sub esp, byte 48h
        mov ebx, eax
        mov edx, dword [byte esp+060h]
        push edx
        push dword [byte esp+05Ch]
        mov edx, 3
        mov ecx, dword [byte esp+068h]
        call UpdateCameraMotion
        push ecx
        mov edx, 4
        mov eax, ebx
        push dword [byte esp+060h]
        call UpdateCameraMotion
        push dword [CameraStateRecords+13h]
        lea eax, [byte esp+04h]
        mov ebx, CameraStateRecords+253h
        call MatRotX
        push dword [CameraStateRecords+17h]
        lea eax, [byte esp+028h]
        lea edx, [byte esp+04h]
        call MatRotY
        lea eax, [byte esp+024h]
        call MatMul
        add esp, byte 48h
        pop edx
        pop ecx
        pop ebx
        ret 0Ch
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; UpdateCameraProjection                          5DCBC  97 PC, low confidence
; Updates the projection from the camera field of view
;-----------------------------------------------------------------------------
UpdateCameraProjection:
        push edx
        mov edx, dword [byte esp+0Ch]
        push edx
        mov edx, 6
        push dword [byte esp+0Ch]
        call UpdateCameraMotion
        mov eax, dword [CameraStateRecords+1Fh]
        mov dword [F32_ViewAngle], eax
        pop edx
        ret 8
        db 08Bh,0C0h
        push ebx
        push edx
        sub esp, byte 48h
        push dword [CameraStateRecords+13h]
        lea eax, [byte esp+028h]
        mov ebx, CameraStateRecords+253h
        call MatRotX
        push dword [CameraStateRecords+17h]
        lea eax, [byte esp+04h]
        lea edx, [byte esp+028h]
        call MatRotY
        mov eax, esp
        call MatMul
        mov eax, dword [CameraStateRecords+1Fh]
        mov dword [F32_ViewAngle], eax
        add esp, byte 48h
        pop edx
        pop ebx
        ret
        db 090h
        push ecx
        push esi
        sub esp, byte 0Ch
        mov ecx, edx
        mov esi, ebx
        mov ebx, esp
        mov edx, CameraStateRecords+7
        call VecSub
        mov edx, CameraStateRecords+253h
        mov eax, esp
        mov ebx, ecx
        call VecMulMat
        test esi, esi
        je short .1
        mov eax, 1
        mov ebx, esi
        mov edx, ecx
        call ProjectPoints
.1:
        fld dword [byte ecx+08h]
        fcomp dword [F32_50p0_View]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        add esp, byte 0Ch
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ProjectRinkPoints                               5DD74  97 PC, low confidence
; Projects the rink reference points to the screen
;-----------------------------------------------------------------------------
ProjectRinkPoints:
        push ecx
        push esi
        sub esp, byte 0Ch
        mov ecx, edx
        mov esi, ebx
        mov ebx, esp
        mov edx, CameraStateRecords+7
        call VecSub
        mov edx, CameraStateRecords+253h
        mov eax, esp
        mov ebx, ecx
        call VecMulMat
        test esi, esi
        je short .1
        mov eax, 1
        mov ebx, esi
        mov edx, ecx
        call ClipProjectPoints
.1:
        fld dword [byte ecx+08h]
        fcomp dword [F32_50p0_View]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        add esp, byte 0Ch
        pop esi
        pop ecx
        ret
        db 090h
        push ecx
        push esi
        sub esp, byte 24h
        mov esi, edx
        mov ecx, ebx
        fild dword [eax]
        lea ebx, [byte esp+0Ch]
        mov edx, CameraStateRecords+7
        fstp dword [byte esp+018h]
        fild dword [byte eax+04h]
        fstp dword [byte esp+01Ch]
        fild dword [byte eax+08h]
        lea eax, [byte esp+018h]
        fstp dword [byte esp+020h]
        call VecSub
        mov ebx, esp
        mov edx, CameraStateRecords+253h
        lea eax, [byte esp+0Ch]
        call VecMulMat
        mov edx, esp
        mov eax, 3
        mov ebx, esi
        call FloatsToInts
        test ecx, ecx
        je short .2
        mov edx, esp
        mov eax, 1
        mov ebx, ecx
        call ProjectPoints
.2:
        mov edx, dword [str_Punct_DrawRinkSurface]
        mov eax, dword [byte esi+08h]
        cmp eax, edx
        setg al
        and eax, 0FFh
        add esp, byte 24h
        pop esi
        pop ecx
        ret
        push ebx
        push ecx
        push esi
        sub esp, byte 24h
        mov esi, eax
        mov ecx, edx
        mov edx, esp
        mov eax, CameraStateRecords+253h
        call MatTranspose
        mov ebx, ecx
        mov edx, esp
        mov eax, esi
        call VecMulMat
        mov edx, CameraStateRecords+7
        mov ebx, ecx
        mov eax, ecx
        call VecAdd
        add esp, byte 24h
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; InitCameraParams                                5DE74  97 PC, low confidence
; Sets the starting camera parameters
;-----------------------------------------------------------------------------
InitCameraParams:
        push edx
        xor edx, edx
.1:
        mov eax, edx
        inc edx
        call CopyCameraState
        cmp edx, byte 7
        jl short .1
        push dword 42C80000h
        push dword 3E4CCCCDh
        xor eax, eax
        push dword 40E00000h
        call ResetCameraState
        push dword 42C80000h
        push dword 3E4CCCCDh
        mov eax, 1
        push dword 40E00000h
        call ResetCameraState
        push dword 42C80000h
        push dword 3E4CCCCDh
        mov eax, 2
        push dword 40E00000h
        call ResetCameraState
        push dword 3DA0D97Ch
        push dword 3E4CCCCDh
        mov eax, 3
        push dword 40E00000h
        call ResetCameraState
        push dword 3DA0D97Ch
        push dword 3E4CCCCDh
        mov eax, 4
        push dword 40E00000h
        call ResetCameraState
        push dword 3DA0D97Ch
        push dword 3E4CCCCDh
        mov eax, 5
        push dword 40E00000h
        call ResetCameraState
        push dword 3D00ADFDh
        push dword 3E4CCCCDh
        mov eax, 6
        push dword 40E00000h
        mov edx, 3F060A92h
        call ResetCameraState
        mov dword [CameraStateRecords+3Bh], edx
        mov dword [CameraStateRecords+1Fh], edx
        pop edx
        ret
