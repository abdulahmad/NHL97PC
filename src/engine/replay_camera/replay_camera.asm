; Replay camera modes: follow, drag, orbit, free, turn, move and zoom.
bits 32
%include "hockey.inc"
section s_1D1DC progbits alloc exec nowrite align=1
extern __CHP, ActiveCameraScene, CameraDebugOn, CameraDebugText, CameraElevation, CameraFovTarget, CameraLookAt, CameraMode
extern CameraOrbitBase, CameraOrbitSpeed, CameraPathTime, CameraPos, CameraSceneArg, CameraSceneCenter, CameraSceneDist, CameraSceneFunc
extern CameraSceneYaw, CameraStateRecords, CameraTracking, CameraViewSel, CameraViewX, CameraViewY, CameraViewZ, DebugTagStr
extern DrawCameraPath, DrawTextAt, F32_0p001, F32_50, F32_6, F32_80, F32_neg2000_ReplayCamDrag, F32_neg2000_ReplayCamMove
extern F32_neg4800, F32_neg4800_ReplayCamMove, F32_neg50, F64_0p01_ReplayCamTurn, F64_0p1, F64_0p2, F64_0p714286, F64_100
extern F64_1p05, F64_3_ReplayCamDrag, F64_3p14159_ReplayCamTurn, F64_6p28319_ReplayCamTurn, F64_neg3p14159_ReplayCamTurn, F64_neg6p28319_ReplayCamTurn, GetCameraTarget, hypot_
extern IF@ATAN2, MatchColor, MatRotY, MatTranspose, ProjectPointInt, PtrPuckFlags, ReplayCameraActive, ReplayCamPitch
extern ReplayCamPos, ReplayCamTarget, ReplayCamYaw, SavedCameraView, SelectCameraView, SelectFont, SetTextColors, sprintf_
extern StartCameraPath, str_DDD, TryStickTouch, VecAdd, VecDistance, VecLength, VecMulMat, VecNormalizeTo
extern VecSub
global ReplayCameraOn, ReplayCameraOff, DrawCameraDebug, ReplayCamFollowMode, ReplayCamDrag, ReplayCamRestorePath, ReplayCamOrbitMode, ReplayCamOrbit
global ReplayCamStop, ReplayCamFreeMode, ReplayCamTurn, ReplayCamMove, ReplayCamZoomMode, ReplayCamZoom, ReplayCamClearFlag
;-----------------------------------------------------------------------------
; ReplayCameraOn                                  1D1DC  97 PC, low confidence
; Hands the camera to the instant replay controls
;-----------------------------------------------------------------------------
ReplayCameraOn:
        push edx
        mov ah, 1
        xor edx, edx
        mov byte [ReplayCameraActive], ah
        mov eax, 1
        mov dword [ActiveCameraScene], edx
        call StartCameraPath
        mov eax, dword [SavedCameraView]
        xor edx, edx
        sar eax, 10h
        call SelectCameraView
        pop edx
        ret
;-----------------------------------------------------------------------------
; ReplayCameraOff                                 1D208  97 PC, low confidence
; Gives the camera back to the game after the instant replay
;-----------------------------------------------------------------------------
ReplayCameraOff:
        push edx
        xor ah, ah
        xor edx, edx
        mov byte [ReplayCameraActive], ah
        mov eax, 1
        call StartCameraPath
        mov eax, dword [SavedCameraView]
        xor edx, edx
        sar eax, 10h
        call SelectCameraView
        pop edx
        ret
        db 08Bh,0C0h
        add dword [CameraSceneArg], eax
        call dword [CameraSceneFunc]
        ret
        db 08Dh,040h,00h
        push ebx
        push ebp
        mov ebp, esp
        sub esp, byte 8
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        fld dword [ebx]
        fsub dword [edx]
        fabs
        fld dword [byte ebp+0Ch]
        fstp qword [esp]
        fcomp qword [esp]
        fnstsw ax
        sahf
        jbe short .1
        xor eax, eax
        jmp short .3
.1:
        fld dword [byte ebx+08h]
        fsub dword [byte edx+08h]
        fabs
        fcomp qword [esp]
        fnstsw ax
        sahf
        jbe short .2
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop ebx
        ret 4
.2:
        mov eax, 1
.3:
        mov esp, ebp
        pop ebp
        pop ebx
        ret 4
        db 08Dh,040h,00h
        fld dword [byte eax+08h]
        fsub dword [byte edx+08h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [eax]
        fsub dword [edx]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        ret
;-----------------------------------------------------------------------------
; DrawCameraDebug                                 1D2A8  97 PC, low confidence
; From DrawGameFrame when CameraDebugOn is set: draws the camera target and
; prints its "(%d,%d,%d)" position
;-----------------------------------------------------------------------------
DrawCameraDebug:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 5Ch
        cmp dword [CameraDebugOn], byte 0
        je near .4
        lea edi, [byte esp+028h]
        mov esi, CameraSceneCenter
        mov edx, CameraStateRecords+7
        xor ebx, ebx
        movsd
        movsd
        movsd
        lea eax, [byte esp+028h]
        mov dword [byte esp+02Ch], ebx
        lea ebx, [byte esp+034h]
        call VecSub
        lea ebx, [byte esp+040h]
        mov edx, CameraStateRecords+253h
        lea eax, [byte esp+034h]
        call VecMulMat
        cmp dword [byte esp+048h], 42C80000h
        jl near .4
        cmp dword [CameraTracking], byte 12h
        jne short .1
        cmp dword [ReplayCamTarget], byte 0FFFFFFFFh
        je short .2
.1:
        push dword 0FF00AA00h
        jmp short .3
.2:
        push dword 0FFAA0000h
.3:
        call MatchColor
        add esp, byte 4
        push eax
        lea eax, [byte esp+02Ch]
        push dword 40800000h
        push eax
        push byte 0
        call DrawCameraPath
        cmp dword [CameraDebugText], byte 0
        je near .4
        lea edx, [byte esp+04Ch]
        lea eax, [byte esp+040h]
        call ProjectPointInt
        fld dword [byte esp+030h]
        fld dword [byte esp+02Ch]
        fld dword [byte esp+028h]
        fxch st2
        call __CHP
        fxch
        call __CHP
        fxch
        fistp dword [byte esp+054h]
        fistp dword [byte esp+058h]
        mov eax, dword [byte esp+054h]
        mov edx, dword [byte esp+058h]
        push eax
        call __CHP
        push edx
        fistp dword [byte esp+060h]
        mov ebx, dword [byte esp+060h]
        push ebx
        push str_DDD
        lea eax, [byte esp+010h]
        push eax
        call sprintf_
        add esp, byte 14h
        push DebugTagStr
        call SelectFont
        add esp, byte 4
        push dword 0FF000000h
        call MatchColor
        add esp, byte 4
        push eax
        push dword 0FF000000h
        call MatchColor
        add esp, byte 4
        push eax
        call SetTextColors
        add esp, byte 8
        mov ecx, dword [byte esp+050h]
        add ecx, byte 2
        push ecx
        mov edi, dword [byte esp+050h]
        push edi
        lea eax, [byte esp+08h]
        push eax
        mov dword [byte esp+05Ch], ecx
        call DrawTextAt
        add esp, byte 0Ch
        push dword 0FF000000h
        mov ebp, dword [byte esp+050h]
        mov eax, dword [byte esp+054h]
        inc ebp
        inc eax
        mov dword [byte esp+050h], ebp
        mov dword [byte esp+054h], eax
        call MatchColor
        add esp, byte 4
        push eax
        push byte 0FFFFFFFFh
        call MatchColor
        add esp, byte 4
        push eax
        call SetTextColors
        add esp, byte 8
        mov edx, dword [byte esp+050h]
        push edx
        mov ebx, dword [byte esp+050h]
        push ebx
        lea eax, [byte esp+08h]
        push eax
        call DrawTextAt
        add esp, byte 0Ch
.4:
        add esp, byte 5Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push edx
        push esi
        push edi
        mov eax, dword [CameraTracking]
        mov edx, 1
        call GetCameraTarget
        mov dword [CameraDebugOn], edx
        test eax, eax
        je short .5
        mov edi, CameraSceneCenter
        mov esi, eax
        movsd
        movsd
        movsd
.5:
        pop edi
        pop esi
        pop edx
        ret
        db 08Bh,0C0h
        push edx
        xor edx, edx
        mov dword [CameraDebugOn], edx
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplayCamFollowMode                             1D480  97 PC, low confidence
; Replay camera: follow mode, keeps the target in view
;-----------------------------------------------------------------------------
ReplayCamFollowMode:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edx, 3
        mov ecx, 1
        mov eax, dword [CameraTracking]
        xor ebx, ebx
        mov dword [CameraViewY], edx
        mov dword [CameraViewX], ebx
        mov dword [CameraViewZ], ecx
        mov dword [CameraMode], ebx
        mov dword [CameraViewSel], ebx
        mov dword [ReplayCamPitch], ebx
        mov dword [ReplayCamYaw], ebx
        call GetCameraTarget
        mov dword [CameraDebugOn], ecx
        test eax, eax
        je short .1
        mov edi, CameraSceneCenter
        mov esi, eax
        movsd
        movsd
        movsd
.1:
        mov edx, 64h
        mov eax, 12h
        mov ebx, 0FFFFFFFFh
        call StartCameraPath
        mov dword [ReplayCamTarget], ebx
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ReplayCamDrag                                   1D4FC  97 PC, low confidence
; Replay camera: moves the camera with the mouse or pad while a button is
; held
;-----------------------------------------------------------------------------
ReplayCamDrag:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 20h
        and esp, byte 0FFFFFFF8h
        mov dword [byte esp+018h], eax
        mov dword [byte esp+01Ch], edx
        fild dword [byte esp+018h]
        fild dword [byte esp+01Ch]
        fstp qword [byte esp+08h]
        mov ecx, dword [byte esp+0Ch]
        mov esi, dword [byte esp+08h]
        push ecx
        fstp qword [byte esp+04h]
        push esi
        mov eax, dword [byte esp+0Ch]
        mov edx, 461C3C00h
        push eax
        mov dword [byte esp+01Ch], edx
        mov edx, dword [byte esp+0Ch]
        push edx
        call hypot_
        fld qword [byte esp+08h]
        fld qword [esp]
        call IF@ATAN2
        fadd dword [CameraStateRecords+17h]
        fchs
        fld st0
        fsin
        fxch
        fcos
        fxch st2
        fmul qword [F64_3_ReplayCamDrag]
        fxch
        fmul st1
        fxch st2
        fmulp
        fld dword [ReplayCamYaw]
        fld dword [ReplayCamPitch]
        fxch st3
        fsubr st1
        fxch st2
        fsubr st3
        fxch st2
        fstp st1
        fmul qword [F64_0p714286]
        fxch
        fstp st2
        fxch
        fmul qword [F64_0p714286]
        xor edi, edi
        fxch
        fstp dword [ReplayCamYaw]
        fst dword [ReplayCamPitch]
        fld dword [ReplayCamYaw]
        fadd dword [CameraSceneCenter]
        fxch
        fadd dword [CameraSceneDist]
        fxch
        fstp dword [CameraSceneCenter]
        mov ecx, dword [CameraSceneCenter]
        fstp dword [CameraSceneDist]
        cmp ecx, 44FA0000h
        jle short .1
        mov eax, 44FA0000h
        fld dword [ReplayCamYaw]
        mov dword [CameraSceneCenter], eax
        fchs
        fmul qword [F64_0p2]
        jmp short .2
.1:
        fld dword [CameraSceneCenter]
        fcomp dword [F32_neg2000_ReplayCamDrag]
        fnstsw ax
        sahf
        jae short .3
        fld dword [ReplayCamYaw]
        mov esi, 0C4FA0000h
        fchs
        fmul qword [F64_0p2]
        mov dword [CameraSceneCenter], esi
.2:
        fstp dword [ReplayCamYaw]
.3:
        cmp dword [CameraSceneDist], 45960000h
        jle short .4
        fld dword [ReplayCamPitch]
        mov esi, 45960000h
        fchs
        fmul qword [F64_0p2]
        mov dword [CameraSceneDist], esi
        jmp short .5
.4:
        fld dword [CameraSceneDist]
        fcomp dword [F32_neg4800]
        fnstsw ax
        sahf
        jae short .6
        fld dword [ReplayCamPitch]
        mov ecx, 0C5960000h
        fchs
        fmul qword [F64_0p2]
        mov dword [CameraSceneDist], ecx
.5:
        fstp dword [ReplayCamPitch]
.6:
        xor eax, eax
        mov edx, dword [CameraTracking]
        mov dword [CameraSceneYaw], eax
        cmp edx, byte 12h
        jne near .19
        xor ebx, ebx
        xor ecx, ecx
.7:
        cmp ebx, byte 12h
        je near .18
        cmp ebx, byte 14h
        je near .18
        cmp ebx, byte 11h
        je near .18
        cmp ebx, byte 19h
        jl short .8
        cmp ebx, byte 21h
        jle near .18
.8:
        mov eax, ebx
        call GetCameraTarget
        mov edx, eax
        mov esi, eax
        test eax, eax
        je near .18
        fld dword [edx]
        fsub dword [CameraSceneCenter]
        fabs
        fcomp qword [F64_100]
        fnstsw ax
        sahf
        jbe short .9
        mov edx, ecx
        jmp short .11
.9:
        fld dword [byte edx+08h]
        fsub dword [CameraSceneDist]
        fabs
        fcomp qword [F64_100]
        fnstsw ax
        sahf
        jbe short .10
        mov edx, ecx
        jmp short .11
.10:
        mov edx, 1
.11:
        test edx, edx
        je near .18
        fld dword [CameraSceneDist]
        fsub dword [byte esi+08h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [CameraSceneCenter]
        fsub dword [esi]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        ja near .19
        cmp ebx, dword [ReplayCamTarget]
        je near .19
        mov edi, CameraSceneCenter
        mov dword [ReplayCamTarget], ebx
        movsd
        movsd
        movsd
        xor esi, esi
        mov edi, dword [ReplayCamYaw]
        mov dword [CameraSceneYaw], esi
        cmp edi, 42480000h
        jle short .12
        fld dword [ReplayCamYaw]
        fadd dword [F32_neg50]
        fstp dword [ReplayCamYaw]
        jmp short .14
.12:
        fld dword [ReplayCamYaw]
        fcomp dword [F32_neg50]
        fnstsw ax
        sahf
        jae short .13
        fld dword [ReplayCamYaw]
        fadd dword [F32_50]
        fstp dword [ReplayCamYaw]
        jmp short .14
.13:
        mov dword [ReplayCamYaw], esi
.14:
        cmp dword [ReplayCamPitch], 42480000h
        jle short .15
        fld dword [ReplayCamPitch]
        fadd dword [F32_neg50]
        fstp dword [ReplayCamPitch]
        jmp short .17
.15:
        fld dword [ReplayCamPitch]
        fcomp dword [F32_neg50]
        fnstsw ax
        sahf
        jae short .16
        fld dword [ReplayCamPitch]
        fadd dword [F32_50]
        fstp dword [ReplayCamPitch]
        mov edi, ebx
        jmp short .19
.16:
        xor ecx, ecx
        mov dword [ReplayCamPitch], ecx
.17:
        mov edi, ebx
        jmp short .19
.18:
        inc ebx
        cmp ebx, byte 10h
        jle near .7
.19:
        cmp ebx, byte 10h
        jle short .20
        mov esi, 0FFFFFFFFh
        mov edi, esi
        mov dword [ReplayCamTarget], esi
.20:
        mov eax, edi
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplayCamRestorePath                            1D828  97 PC, low confidence
; Replay camera: puts the saved camera path back
;-----------------------------------------------------------------------------
ReplayCamRestorePath:
        push ebx
        push edx
        xor edx, edx
        mov ebx, dword [ReplayCamTarget]
        mov dword [CameraDebugOn], edx
        cmp ebx, byte 0FFFFFFFFh
        je short .1
        mov edx, 64h
        mov eax, ebx
        call StartCameraPath
.1:
        mov dword [ReplayCamTarget], 0FFFFFFFFh
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ReplayCamOrbitMode                              1D858  97 PC, low confidence
; Replay camera: starts orbit mode around the target
;-----------------------------------------------------------------------------
ReplayCamOrbitMode:
        push ebx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov esi, 3
        mov ebp, 1
        xor edx, edx
        mov eax, 5
        mov dword [ReplayCamPitch], edx
        mov dword [ReplayCamYaw], edx
        mov dword [CameraViewX], edx
        mov dword [CameraViewY], esi
        mov dword [CameraMode], edx
        mov dword [CameraViewSel], eax
        mov eax, dword [CameraTracking]
        mov dword [CameraViewZ], ebp
        call GetCameraTarget
        test eax, eax
        jne short .1
        mov eax, 12h
        call StartCameraPath
        mov eax, dword [CameraTracking]
        call GetCameraTarget
.1:
        test eax, eax
        je short .2
        mov ebx, esp
        mov edx, eax
        mov eax, CameraStateRecords+7
        call VecSub
        call VecLength
        fstp dword [CameraPathTime]
        jmp short .3
.2:
        mov dword [CameraPathTime], 447A0000h
.3:
        mov eax, dword [CameraTracking]
        mov ebx, 1
        call GetCameraTarget
        mov dword [CameraDebugOn], ebx
        test eax, eax
        je short .4
        mov edi, CameraSceneCenter
        mov esi, eax
        movsd
        movsd
        movsd
.4:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ReplayCamOrbit                                  1D914  97 PC, low confidence
; Replay camera: orbits and zooms around the target from the input
;-----------------------------------------------------------------------------
ReplayCamOrbit:
        push ebx
        push ecx
        push esi
        sub esp, byte 64h
        mov ecx, eax
        mov ebx, edx
        mov edx, CameraPos
        mov eax, CameraElevation
        call VecDistance
        fld dword [CameraOrbitSpeed]
        fsub dword [CameraOrbitBase]
        fdiv st1
        mov edx, ecx
        lea eax, [nosplit edx*4+00h]
        fxch
        fmul dword [F32_0p001]
        add eax, edx
        add eax, eax
        mov dword [byte esp+044h], eax
        fild dword [byte esp+044h]
        fxch st2
        fsubr qword [F64_1p05]
        fxch st2
        fmul st2
        fxch
        fstp dword [byte esp+060h]
        fmul dword [byte esp+060h]
        fadd dword [ReplayCamYaw]
        fstp dword [ReplayCamYaw]
        fcomp qword [F64_0p1]
        fnstsw ax
        sahf
        jae short .1
        test ebx, ebx
        jg short .1
        xor edx, edx
        mov dword [ReplayCamPitch], edx
        jmp short .2
.1:
        lea eax, [nosplit ebx*4+00h]
        add eax, ebx
        add eax, eax
        mov dword [byte esp+044h], eax
        fild dword [byte esp+044h]
        fmul dword [byte esp+060h]
        fsubr dword [ReplayCamPitch]
        fstp dword [ReplayCamPitch]
.2:
        fld dword [byte esp+060h]
        fmul dword [F32_80]
        fld dword [ReplayCamYaw]
        fxch
        fstp dword [byte esp+050h]
        fcomp dword [byte esp+050h]
        fnstsw ax
        sahf
        jbe short .3
        mov eax, dword [byte esp+050h]
        jmp short .4
.3:
        fld dword [ReplayCamYaw]
        fld dword [byte esp+050h]
        fchs
        fstp dword [byte esp+04Ch]
        fcomp dword [byte esp+04Ch]
        fnstsw ax
        sahf
        jae short .5
        mov eax, dword [byte esp+04Ch]
.4:
        mov dword [ReplayCamYaw], eax
.5:
        fld dword [byte esp+060h]
        fmul dword [F32_80]
        fld dword [ReplayCamPitch]
        fxch
        fstp dword [byte esp+054h]
        fcomp dword [byte esp+054h]
        fnstsw ax
        sahf
        jbe short .6
        mov eax, dword [byte esp+054h]
        jmp short .7
.6:
        fld dword [ReplayCamPitch]
        fld dword [byte esp+054h]
        fchs
        fstp dword [byte esp+048h]
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        jae short .8
        mov eax, dword [byte esp+048h]
.7:
        mov dword [ReplayCamPitch], eax
.8:
        fld dword [byte esp+060h]
        fmul dword [F32_6]
        fld dword [ReplayCamYaw]
        fxch
        fstp dword [byte esp+058h]
        fcomp dword [byte esp+058h]
        fnstsw ax
        sahf
        jbe short .9
        fld dword [ReplayCamYaw]
        fsub dword [byte esp+058h]
        fstp dword [ReplayCamYaw]
        jmp short .11
.9:
        fld dword [byte esp+058h]
        fchs
        fcomp dword [ReplayCamYaw]
        fnstsw ax
        sahf
        jbe short .10
        fld dword [ReplayCamYaw]
        fadd dword [byte esp+058h]
        fstp dword [ReplayCamYaw]
        jmp short .11
.10:
        xor ebx, ebx
        mov dword [ReplayCamYaw], ebx
.11:
        fld dword [byte esp+060h]
        fmul dword [F32_6]
        fld dword [ReplayCamPitch]
        fxch
        fstp dword [byte esp+05Ch]
        fcomp dword [byte esp+05Ch]
        fnstsw ax
        sahf
        jbe short .12
        fld dword [ReplayCamPitch]
        fsub dword [byte esp+05Ch]
        fstp dword [ReplayCamPitch]
        jmp short .14
.12:
        fld dword [byte esp+05Ch]
        fchs
        fcomp dword [ReplayCamPitch]
        fnstsw ax
        sahf
        jbe short .13
        fld dword [ReplayCamPitch]
        fadd dword [byte esp+05Ch]
        fstp dword [ReplayCamPitch]
        jmp short .14
.13:
        xor ecx, ecx
        mov dword [ReplayCamPitch], ecx
.14:
        mov edx, esp
        mov eax, dword [ReplayCamYaw]
        lea ebx, [byte esp+024h]
        mov dword [byte esp+030h], eax
        mov eax, dword [ReplayCamPitch]
        xor esi, esi
        mov dword [byte esp+034h], eax
        mov eax, CameraStateRecords+253h
        mov dword [byte esp+038h], esi
        call MatTranspose
        mov edx, esp
        lea eax, [byte esp+030h]
        call VecMulMat
        lea ebx, [byte esp+030h]
        lea edx, [byte esp+024h]
        mov eax, CameraStateRecords+7
        call VecAdd
        lea ebx, [byte esp+030h]
        mov edx, CameraPos
        lea eax, [byte esp+030h]
        call VecSub
        lea eax, [byte esp+030h]
        push eax
        mov ebx, CameraLookAt
        push dword [CameraPathTime]
        lea edx, [byte esp+038h]
        call VecNormalizeTo
        mov eax, CameraPos
        call VecAdd
        mov eax, dword [CameraTracking]
        xor edx, edx
        call StartCameraPath
        add esp, byte 64h
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ReplayCamStop                                   1DB8C  97 PC, low confidence
; Replay camera: stops the current camera move
;-----------------------------------------------------------------------------
ReplayCamStop:
        push edx
        xor edx, edx
        mov dword [CameraDebugOn], edx
        mov dword [CameraViewSel], edx
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ReplayCamFreeMode                               1DBA0  97 PC, low confidence
; Replay camera: starts free mode
;-----------------------------------------------------------------------------
ReplayCamFreeMode:
        push ebx
        push edx
        sub esp, byte 0Ch
        xor edx, edx
        xor eax, eax
        mov ebx, 3
        call StartCameraPath
        mov eax, CameraSceneCenter
        mov dword [CameraViewY], ebx
        xor edx, edx
        mov ebx, esp
        mov dword [CameraMode], edx
        mov dword [CameraViewX], edx
        mov edx, CameraStateRecords+7
        call VecSub
        mov ebx, ReplayCamPos
        mov edx, CameraStateRecords+253h
        mov eax, esp
        call VecMulMat
        add esp, byte 0Ch
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplayCamTurn                                   1DBF0  97 PC, low confidence
; Replay camera: turns the free camera from the input
;-----------------------------------------------------------------------------
ReplayCamTurn:
        push ebx
        push ebp
        mov ebp, esp
        sub esp, byte 54h
        and esp, byte 0FFFFFFF8h
        mov dword [byte esp+050h], eax
        fild dword [byte esp+050h]
        fmul qword [F64_0p01_ReplayCamTurn]
        fsubr dword [CameraFovTarget]
        fst dword [CameraFovTarget]
        fst qword [byte esp+048h]
        fcomp qword [F64_3p14159_ReplayCamTurn]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+048h]
        fadd qword [F64_neg6p28319_ReplayCamTurn]
        jmp short .2
.1:
        fld qword [byte esp+048h]
        fcomp qword [F64_neg3p14159_ReplayCamTurn]
        fnstsw ax
        sahf
        jae short .3
        fld qword [byte esp+048h]
        fadd qword [F64_6p28319_ReplayCamTurn]
.2:
        fstp dword [CameraFovTarget]
.3:
        fld dword [CameraFovTarget]
        sub esp, byte 4
        fchs
        fstp dword [esp]
        lea eax, [byte esp+04h]
        xor ebx, ebx
        call MatRotY
        mov dword [byte esp+034h], ebx
        mov dword [byte esp+030h], ebx
        mov ebx, edx
        neg ebx
        lea eax, [nosplit ebx*4+00h]
        add eax, ebx
        shl eax, 3
        mov edx, esp
        mov dword [byte esp+044h], eax
        lea ebx, [byte esp+024h]
        fild dword [byte esp+044h]
        lea eax, [byte esp+030h]
        fstp dword [byte esp+038h]
        call VecMulMat
        mov ebx, CameraLookAt
        lea edx, [byte esp+024h]
        mov eax, ebx
        call VecAdd
        mov esp, ebp
        pop ebp
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplayCamMove                                   1DCB0  97 PC, low confidence
; Replay camera: moves the free camera from the input
;-----------------------------------------------------------------------------
ReplayCamMove:
        push ebx
        push edx
        sub esp, byte 30h
        mov edx, esp
        mov eax, CameraStateRecords+253h
        lea ebx, [byte esp+024h]
        call MatTranspose
        mov edx, esp
        mov eax, ReplayCamPos
        call VecMulMat
        mov ebx, CameraSceneCenter
        mov edx, CameraStateRecords+7
        lea eax, [byte esp+024h]
        call VecAdd
        xor edx, edx
        mov ebx, dword [CameraSceneCenter]
        mov dword [CameraSceneYaw], edx
        cmp ebx, 44FA0000h
        jle short .1
        mov dword [CameraSceneCenter], 44FA0000h
        jmp short .2
.1:
        fld dword [CameraSceneCenter]
        fcomp dword [F32_neg2000_ReplayCamMove]
        fnstsw ax
        sahf
        jae short .2
        mov dword [CameraSceneCenter], 0C4FA0000h
.2:
        cmp dword [CameraSceneDist], 45960000h
        jle short .3
        mov dword [CameraSceneDist], 45960000h
        jmp short .4
.3:
        fld dword [CameraSceneDist]
        fcomp dword [F32_neg4800_ReplayCamMove]
        fnstsw ax
        sahf
        jae short .4
        mov dword [CameraSceneDist], 0C5960000h
.4:
        add esp, byte 30h
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ReplayCamZoomMode                               1DD5C  97 PC, low confidence
; Replay camera: starts zoom mode
;-----------------------------------------------------------------------------
ReplayCamZoomMode:
        push ebx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov ebx, 3
        mov esi, dword [CameraTracking]
        xor edx, edx
        mov dword [CameraViewY], ebx
        mov dword [CameraViewX], edx
        mov dword [CameraMode], edx
        test esi, esi
        jne short .1
        mov edx, 64h
        mov eax, 12h
        call StartCameraPath
.1:
        mov eax, dword [CameraTracking]
        mov ebx, esp
        call GetCameraTarget
        mov edx, eax
        mov eax, CameraStateRecords+7
        mov edi, 1
        call VecSub
        call VecLength
        mov eax, dword [CameraTracking]
        fstp dword [CameraPathTime]
        call GetCameraTarget
        mov dword [CameraDebugOn], edi
        test eax, eax
        je short .2
        mov edi, CameraSceneCenter
        mov esi, eax
        movsd
        movsd
        movsd
.2:
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplayCamZoom                                   1DDE4  97 PC, low confidence
; Replay camera: zooms in or out from the input
;-----------------------------------------------------------------------------
ReplayCamZoom:
        push ebx
        push esi
        sub esp, byte 40h
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        shl eax, 3
        mov edx, dword [CameraTracking]
        mov dword [byte esp+03Ch], eax
        test edx, edx
        je short .3
        fild dword [byte esp+03Ch]
        fadd dword [CameraPathTime]
        fstp dword [CameraPathTime]
        mov esi, dword [CameraPathTime]
        cmp esi, 43E10000h
        jge short .1
        mov dword [CameraPathTime], 43E10000h
        jmp short .2
.1:
        cmp esi, 461C3C00h
        jle short .2
        mov dword [CameraPathTime], 461C3C00h
.2:
        lea ebx, [byte esp+024h]
        mov edx, CameraPos
        mov eax, CameraStateRecords+7
        call VecSub
        lea eax, [byte esp+024h]
        push eax
        mov ebx, CameraLookAt
        push dword [CameraPathTime]
        lea edx, [byte esp+02Ch]
        call VecNormalizeTo
        mov eax, CameraPos
        jmp short .4
.3:
        fild dword [byte esp+03Ch]
        mov eax, CameraStateRecords+253h
        lea ebx, [byte esp+030h]
        mov dword [byte esp+028h], edx
        mov dword [byte esp+024h], edx
        mov edx, esp
        fstp dword [byte esp+02Ch]
        call MatTranspose
        mov edx, esp
        lea eax, [byte esp+024h]
        call VecMulMat
        mov ebx, CameraLookAt
        lea edx, [byte esp+030h]
        mov eax, CameraStateRecords+7
.4:
        call VecAdd
        add esp, byte 40h
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ReplayCamClearFlag                              1DEB8  97 PC, low confidence
; Replay camera: clears the camera mode flag
;-----------------------------------------------------------------------------
ReplayCamClearFlag:
        push edx
        xor edx, edx
        mov dword [CameraDebugOn], edx
        pop edx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        call TryStickTouch
        mov edx, dword [PtrPuckFlags]
        add eax, eax
        mov dword [byte edx+060h], eax
        ret
