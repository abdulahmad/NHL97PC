; 3D library: SetProjectionCenter, PerspectiveScale, ProjectCoord, ProjectCoordInt, ProjectPoints and 7 more.
bits 32
%include "hockey.inc"
section s_FFA9C progbits alloc exec nowrite align=1
extern __fpatan_wrap, CameraCosYaw, CameraPitch, CameraSinYaw, CameraYaw, F32_0p5_SetProjectionCenter, F32_1p0_View, F32_65536_SetProjectionCenter
extern F64_0p5_SetProjectionCenter, MathErrorFlags, ProjAspect, ProjCenterX, ProjCenterY, ProjDetailScale, ProjOffsetX, ProjOffsetY
extern ProjScaleX, ProjScaleY, RinkLineWidth, str_D_ProjectPointsPersp, ViewCenterY
global SetProjectionCenter, PerspectiveScale, ProjectCoord, ProjectCoordInt, ProjectPoints, ProjectPointsWithZ, ProjectPointsWithZ_DF, ProjectPointsToScreen
global ProjectPointInt, ClipProjectPoints, ProjectPointFloat, IF@ATAN, IF@ATAN2
;-----------------------------------------------------------------------------
; SetProjectionCenter                             FFA9C  97 PC, low confidence
; 3D library: sets the screen centre of the projection from the view size and
; origin
;-----------------------------------------------------------------------------
SetProjectionCenter:
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov esi, dword [byte esp+024h]
        mov eax, dword [byte esp+020h]
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov edi, dword [CameraYaw]
        add eax, edi
        mov edx, esi
        mov dword [ViewCenterY], eax
        sar edx, 1Fh
        mov eax, esi
        LD sub, eax, edx
        sar eax, 1
        lea edi, [byte esp+04h]
        fild dword [ViewCenterY]
        fadd qword [F64_0p5_SetProjectionCenter]
        mov esi, dword [CameraPitch]
        fstp dword [ProjOffsetY]
        add eax, esi
        mov esi, esp
        mov dword [str_D_ProjectPointsPersp], eax
        mov eax, dword [ViewCenterY]
        fild dword [str_D_ProjectPointsPersp]
        shl eax, 10h
        fadd qword [F64_0p5_SetProjectionCenter]
        mov dword [byte esp+08h], eax
        mov eax, dword [str_D_ProjectPointsPersp]
        fstp dword [ProjOffsetX]
        shl eax, 10h
        fild dword [byte esp+08h]
        mov dword [byte esp+08h], eax
        fstp dword [ProjCenterX]
        fild dword [byte esp+08h]
        lea eax, [byte esp+01Ch]
        fstp dword [ProjCenterY]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fild dword [byte esp+020h]
        fmul dword [byte esp+04h]
        fmul dword [F32_0p5_SetProjectionCenter]
        fdiv dword [esp]
        fst dword [ProjDetailScale]
        fmul dword [F32_1p0_View]
        fld dword [ProjDetailScale]
        fmul dword [F32_65536_SetProjectionCenter]
        fxch
        fst dword [ProjAspect]
        fmul dword [F32_65536_SetProjectionCenter]
        mov eax, CameraSinYaw
        fld dword [ProjDetailScale]
        fxch st2
        fstp dword [ProjScaleY]
        fstp dword [ProjScaleX]
        fistp dword [eax]
        fld dword [ProjAspect]
        fchs
        mov eax, CameraCosYaw
        fistp dword [eax]
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        ret 0Ch
;-----------------------------------------------------------------------------
; PerspectiveScale                                FFBA4  97 PC, low confidence
; 3D library: focal length divided by depth
;-----------------------------------------------------------------------------
PerspectiveScale:
        fld dword [ProjDetailScale]
        fdiv dword [byte esp+04h]
        ret 4
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ProjectCoord                                    FFBB4  97 PC, low confidence
; 3D library: projects one coordinate: value times focal length over depth
;-----------------------------------------------------------------------------
ProjectCoord:
        fld dword [byte esp+08h]
        fmul dword [ProjDetailScale]
        fdiv dword [byte esp+04h]
        ret 8
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ProjectCoordInt                                 FFBC8  97 PC, low confidence
; 3D library: projects one coordinate to an integer screen position
;-----------------------------------------------------------------------------
ProjectCoordInt:
        fld dword [byte esp+08h]
        fmul dword [ProjScaleY]
        fdiv dword [byte esp+04h]
        push eax
        fistp dword [esp]
        pop eax
        ret 8
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ProjectPoints                                   FFBE0  97 PC, low confidence
; 3D library: projects a list of view-space points to the screen
;-----------------------------------------------------------------------------
ProjectPoints:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ecx, eax
        mov edi, edx
        mov esi, ebx
        shl eax, 2
        sub eax, ecx
        lea edx, [nosplit eax*4+00h]
        lea eax, [nosplit ecx*8+00h]
        add eax, byte 4
        add eax, ebx
        mov ebx, dword [RinkLineWidth]
        add edx, edi
        test ebx, ebx
        je short .2
        mov ebx, eax
.1:
        test ecx, ecx
        je near .4
        sub ebx, byte 8
        dec ecx
        mov ebp, dword [byte edx-04h]
        sub edx, byte 0Ch
        test ebp, 7FFFFFFFh
        je short .1
        fld dword [ProjDetailScale]
        fdiv dword [byte edx+08h]
        fld dword [edx]
        fxch
        fstp dword [esp]
        fmul dword [esp]
        lea eax, [nosplit ecx*8+00h]
        fadd dword [ProjOffsetY]
        add eax, esi
        fistp dword [eax]
        fld dword [byte edx+04h]
        fmul dword [esp]
        fsubr dword [ProjOffsetX]
        mov eax, ebx
        fistp dword [eax]
        jmp short .1
.2:
        mov ebx, eax
.3:
        test ecx, ecx
        je short .4
        sub ebx, byte 8
        dec ecx
        mov edi, dword [byte edx-04h]
        sub edx, byte 0Ch
        test edi, 7FFFFFFFh
        je short .3
        fld1
        fdiv dword [byte edx+08h]
        fld dword [edx]
        fmul dword [ProjDetailScale]
        fxch
        fstp dword [byte esp+04h]
        fmul dword [byte esp+04h]
        lea eax, [nosplit ecx*8+00h]
        fadd dword [ProjOffsetY]
        add eax, esi
        fistp dword [eax]
        fld dword [byte edx+04h]
        fmul dword [ProjAspect]
        fmul dword [byte esp+04h]
        fsubr dword [ProjOffsetX]
        mov eax, ebx
        fistp dword [eax]
        jmp short .3
.4:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; ProjectPointsWithZ                              FFCC4  97 PC, low confidence
; 3D library: projects a list of points to the screen and keeps their depth
;-----------------------------------------------------------------------------
ProjectPointsWithZ:
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 8
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov edi, edx
        mov esi, ebx
        shl eax, 2
        sub eax, ecx
        lea edx, [nosplit eax*4+00h]
        lea eax, [nosplit ecx*8+00h]
        add eax, byte 4
        add eax, ebx
        mov ebx, dword [RinkLineWidth]
        add edx, edi
        test ebx, ebx
        je short .2
        mov ebx, eax
        xor edi, edi
.1:
        test ecx, ecx
        je near ProjectPointsWithZ_DF
        sub ebx, byte 8
        dec ecx
        mov eax, dword [byte edx-04h]
        sub edx, byte 0Ch
        cmp edi, eax
        je short .1
        fild dword [byte edx+08h]
        fdivr dword [ProjDetailScale]
        fild dword [edx]
        fxch
        fstp dword [esp]
        fmul dword [esp]
        lea eax, [nosplit ecx*8+00h]
        fadd dword [ProjOffsetY]
        add eax, esi
        fistp dword [eax]
        fild dword [byte edx+04h]
        fmul dword [esp]
        fsubr dword [ProjOffsetX]
        mov eax, ebx
        fistp dword [eax]
        jmp short .1
.2:
        mov ebx, eax
        xor edi, edi
.3:
        test ecx, ecx
        je short ProjectPointsWithZ_DF
        sub ebx, byte 8
        dec ecx
        mov eax, dword [byte edx-04h]
        sub edx, byte 0Ch
        cmp edi, eax
        je short .3
        fild dword [byte edx+08h]
        fld1
        fdivrp
        fild dword [edx]
        fmul dword [ProjDetailScale]
        fxch
        fstp dword [byte esp+04h]
        fmul dword [byte esp+04h]
        lea eax, [nosplit ecx*8+00h]
        fadd dword [ProjOffsetY]
        add eax, esi
        fistp dword [eax]
        fild dword [byte edx+04h]
        fmul dword [ProjAspect]
        fmul dword [byte esp+04h]
        fsubr dword [ProjOffsetX]
        mov eax, ebx
        fistp dword [eax]
        jmp short .3
ProjectPointsWithZ_DF:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ProjectPointsToScreen                           FFDAC  97 PC, low confidence
; 3D library: projects a list of points to integer screen positions
;-----------------------------------------------------------------------------
ProjectPointsToScreen:
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 8
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov edi, edx
        mov esi, ebx
        shl eax, 2
        sub eax, ecx
        lea edx, [nosplit eax*4+00h]
        lea eax, [nosplit ecx*8+00h]
        add eax, byte 4
        add eax, ebx
        mov ebx, dword [RinkLineWidth]
        add edx, edi
        test ebx, ebx
        je short .2
        mov ebx, eax
        xor edi, edi
.1:
        test ecx, ecx
        je short ProjectPointsWithZ_DF
        sub ebx, byte 8
        dec ecx
        mov eax, dword [byte edx-04h]
        sub edx, byte 0Ch
        cmp edi, eax
        je short .1
        fild dword [byte edx+08h]
        fdivr dword [ProjScaleY]
        fild dword [edx]
        fxch
        fstp dword [esp]
        fmul dword [esp]
        lea eax, [nosplit ecx*8+00h]
        fadd dword [ProjCenterX]
        add eax, esi
        fistp dword [eax]
        fild dword [byte edx+04h]
        fmul dword [esp]
        fsubr dword [ProjCenterY]
        mov eax, ebx
        fistp dword [eax]
        jmp short .1
.2:
        mov ebx, eax
        xor edi, edi
.3:
        test ecx, ecx
        je near ProjectPointsWithZ_DF
        sub ebx, byte 8
        dec ecx
        mov eax, dword [byte edx-04h]
        sub edx, byte 0Ch
        cmp edi, eax
        je short .3
        fild dword [byte edx+08h]
        fld1
        fdivrp
        fild dword [edx]
        fmul dword [ProjScaleY]
        fxch
        fstp dword [byte esp+04h]
        fmul dword [byte esp+04h]
        lea eax, [nosplit ecx*8+00h]
        fadd dword [ProjCenterX]
        add eax, esi
        fistp dword [eax]
        fild dword [byte edx+04h]
        fmul dword [ProjScaleX]
        fmul dword [byte esp+04h]
        fsubr dword [ProjCenterY]
        mov eax, ebx
        fistp dword [eax]
        jmp short .3
        db 090h
;-----------------------------------------------------------------------------
; ProjectPointInt                                 FFE8C  97 PC, low confidence
; 3D library: projects one point to integer screen coordinates
;-----------------------------------------------------------------------------
ProjectPointInt:
        push ebx
        sub esp, byte 4
        mov ebx, eax
        test dword [byte eax+08h], 7FFFFFFFh
        je short .1
        fld1
        fdiv dword [byte eax+08h]
        fld dword [ebx]
        fmul dword [ProjDetailScale]
        fxch
        fstp dword [esp]
        fmul dword [esp]
        fadd dword [ProjOffsetY]
        mov eax, edx
        fistp dword [eax]
        fld dword [byte ebx+04h]
        fmul dword [ProjAspect]
        fmul dword [esp]
        fsubr dword [ProjOffsetX]
        lea eax, [byte edx+04h]
        fistp dword [eax]
.1:
        add esp, byte 4
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ClipProjectPoints                               FFED8  97 PC, low confidence
; 3D library: clips a list of points against the near plane and projects them
;-----------------------------------------------------------------------------
ClipProjectPoints:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov ecx, eax
        mov dword [byte esp+010h], edx
        mov dword [byte esp+0Ch], ebx
        lea edx, [nosplit eax*4+00h]
        mov esi, dword [byte esp+0Ch]
        sub edx, eax
        lea ebx, [nosplit eax*8+00h]
        add esi, ebx
        shl edx, 2
        mov dword [byte esp+04h], esi
        lea esi, [byte edx-030h]
        lea edi, [byte edx-024h]
        lea ebp, [byte edx-018h]
        lea ebx, [byte edx-0Ch]
        mov edx, dword [byte esp+010h]
        add edx, esi
        mov dword [byte esp+08h], edx
        mov edx, dword [byte esp+010h]
        mov esi, dword [byte esp+010h]
        add edi, edx
        add edx, ebp
        mov ebp, dword [RinkLineWidth]
        add ebx, esi
        test ebp, ebp
        je near .8
        mov ebp, ebx
        mov esi, edx
        mov ebx, dword [byte esp+08h]
        mov edx, dword [byte esp+04h]
.1:
        cmp ecx, byte 4
        jl near .6
        test dword [byte ebp+08h], 7FFFFFFFh
        je short .2
        fld dword [byte ebp+00h]
        fld dword [ProjDetailScale]
        fdiv dword [byte ebp+08h]
        fxch
        fmul st1
        fadd dword [ProjOffsetY]
        fstp dword [byte edx-08h]
        fmul dword [byte ebp+04h]
        fsubr dword [ProjOffsetX]
        fstp dword [byte edx-04h]
.2:
        test dword [byte esi+08h], 7FFFFFFFh
        je short .3
        fld dword [esi]
        fld dword [ProjDetailScale]
        fdiv dword [byte esi+08h]
        fxch
        fmul st1
        fadd dword [ProjOffsetY]
        fstp dword [byte edx-010h]
        fmul dword [byte esi+04h]
        fsubr dword [ProjOffsetX]
        fstp dword [byte edx-0Ch]
.3:
        test dword [byte edi+08h], 7FFFFFFFh
        je short .4
        fld dword [edi]
        fld dword [ProjDetailScale]
        fdiv dword [byte edi+08h]
        fxch
        fmul st1
        fadd dword [ProjOffsetY]
        fstp dword [byte edx-018h]
        fmul dword [byte edi+04h]
        fsubr dword [ProjOffsetX]
        fstp dword [byte edx-014h]
.4:
        test dword [byte ebx+08h], 7FFFFFFFh
        je short .5
        fld dword [ebx]
        fld dword [ProjDetailScale]
        fdiv dword [byte ebx+08h]
        fxch
        fmul st1
        fadd dword [ProjOffsetY]
        fstp dword [byte edx-020h]
        fmul dword [byte ebx+04h]
        fsubr dword [ProjOffsetX]
        fstp dword [byte edx-01Ch]
.5:
        sub esi, byte 30h
        sub edi, byte 30h
        sub ebx, byte 30h
        sub edx, byte 20h
        sub ecx, byte 4
        sub ebp, byte 30h
        jmp near .1
.6:
        lea edx, [nosplit ecx*4+00h]
        mov ebp, dword [byte esp+010h]
        sub edx, ecx
        mov eax, dword [byte esp+0Ch]
        shl edx, 2
        lea ebx, [nosplit ecx*8+00h]
        add edx, ebp
        add ebx, eax
.7:
        test ecx, ecx
        jle near .16
        sub ebx, byte 8
        dec ecx
        mov esi, dword [byte edx-04h]
        sub edx, byte 0Ch
        test esi, 7FFFFFFFh
        je short .7
        fld dword [edx]
        fld dword [ProjDetailScale]
        fdiv dword [byte edx+08h]
        fxch
        fmul st1
        fadd dword [ProjOffsetY]
        fstp dword [ebx]
        fmul dword [byte edx+04h]
        fsubr dword [ProjOffsetX]
        fstp dword [byte ebx+04h]
        jmp short .7
.8:
        mov ebp, dword [byte esp+08h]
        mov esi, ebx
        mov ebx, edx
        mov edx, dword [byte esp+04h]
.9:
        cmp ecx, byte 4
        jl near .14
        test dword [byte esi+08h], 7FFFFFFFh
        je short .10
        fld1
        fld dword [esi]
        fmul dword [ProjDetailScale]
        fxch
        fdiv dword [byte esi+08h]
        fxch
        fmul st1
        fadd dword [ProjOffsetY]
        fstp dword [byte edx-08h]
        fld dword [byte esi+04h]
        fmul dword [ProjAspect]
        fmulp
        fsubr dword [ProjOffsetX]
        fstp dword [byte edx-04h]
.10:
        test dword [byte ebx+08h], 7FFFFFFFh
        je short .11
        fld1
        fld dword [ebx]
        fmul dword [ProjDetailScale]
        fxch
        fdiv dword [byte ebx+08h]
        fxch
        fmul st1
        fadd dword [ProjOffsetY]
        fstp dword [byte edx-010h]
        fld dword [byte ebx+04h]
        fmul dword [ProjAspect]
        fmulp
        fsubr dword [ProjOffsetX]
        fstp dword [byte edx-0Ch]
.11:
        test dword [byte edi+08h], 7FFFFFFFh
        je short .12
        fld1
        fld dword [edi]
        fmul dword [ProjDetailScale]
        fxch
        fdiv dword [byte edi+08h]
        fxch
        fmul st1
        fadd dword [ProjOffsetY]
        fstp dword [byte edx-018h]
        fld dword [byte edi+04h]
        fmul dword [ProjAspect]
        fmulp
        fsubr dword [ProjOffsetX]
        fstp dword [byte edx-014h]
.12:
        test dword [byte ebp+08h], 7FFFFFFFh
        je short .13
        fld1
        fld dword [byte ebp+00h]
        fmul dword [ProjDetailScale]
        fxch
        fdiv dword [byte ebp+08h]
        fxch
        fmul st1
        fadd dword [ProjOffsetY]
        fstp dword [byte edx-020h]
        fld dword [byte ebp+04h]
        fmul dword [ProjAspect]
        fmulp
        fsubr dword [ProjOffsetX]
        fstp dword [byte edx-01Ch]
.13:
        sub ebx, byte 30h
        sub edi, byte 30h
        sub ebp, byte 30h
        sub edx, byte 20h
        sub ecx, byte 4
        sub esi, byte 30h
        jmp near .9
.14:
        lea edx, [nosplit ecx*4+00h]
        mov eax, dword [byte esp+010h]
        sub edx, ecx
        mov esi, dword [byte esp+0Ch]
        shl edx, 2
        lea ebx, [nosplit ecx*8+00h]
        add edx, eax
        add ebx, esi
.15:
        test ecx, ecx
        jle short .16
        sub ebx, byte 8
        dec ecx
        mov edi, dword [byte edx-04h]
        sub edx, byte 0Ch
        test edi, 7FFFFFFFh
        je short .15
        fld1
        fld dword [edx]
        fmul dword [ProjDetailScale]
        fxch
        fdiv dword [byte edx+08h]
        fxch
        fmul st1
        fadd dword [ProjOffsetY]
        fstp dword [ebx]
        fld dword [byte edx+04h]
        fmul dword [ProjAspect]
        fmulp
        fsubr dword [ProjOffsetX]
        fstp dword [byte ebx+04h]
        jmp short .15
.16:
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ProjectPointFloat                              1001F8  97 PC, low confidence
; 3D library: projects one point to float screen coordinates when it is in
; front of the camera
;-----------------------------------------------------------------------------
ProjectPointFloat:
        push ebx
        sub esp, byte 4
        mov ebx, eax
        fldz
        fcomp dword [byte eax+08h]
        fnstsw ax
        sahf
        jae short .1
        fld1
        fld dword [ebx]
        fmul dword [ProjDetailScale]
        fxch
        fdiv dword [byte ebx+08h]
        fxch
        fmul st1
        fadd dword [ProjOffsetY]
        fstp dword [edx]
        fld dword [byte ebx+04h]
        fmul dword [ProjAspect]
        fmulp
        fsubr dword [ProjOffsetX]
        fstp dword [byte edx+04h]
.1:
        add esp, byte 4
        pop ebx
        ret
;-----------------------------------------------------------------------------
; IF@ATAN                                                      10023C  library
; Run-time library atan core
;-----------------------------------------------------------------------------
IF@ATAN:
        fld1
        test byte [MathErrorFlags], 1
        jne short .1
        fpatan
        jmp short .2
.1:
        call __fpatan_wrap
.2:
        ret
;-----------------------------------------------------------------------------
; IF@ATAN2                                                     100251  library
; Run-time library atan2 core
;-----------------------------------------------------------------------------
IF@ATAN2:
        fxch
        test byte [MathErrorFlags], 1
        jne short .1
        fpatan
        jmp short .2
.1:
        call __fpatan_wrap
.2:
        ret
        fld qword [byte esp+04h]
        call IF@ATAN
        ret 8
        fld qword [byte esp+0Ch]
        fld qword [byte esp+04h]
        call IF@ATAN2
        ret 10h
