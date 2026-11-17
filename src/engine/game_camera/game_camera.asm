; Game camera: targets, zoom, tracking, spline paths and views.
bits 32
%include "hockey.inc"
section s_191F6 progbits alloc exec nowrite align=1
extern __CHP, BuildCameraMatrix, CameraAngles, CameraCenter, CameraDebugLimit, CameraDebugMarks, CameraDebugMask, CameraDistance
extern CameraElevation, CameraEye, CameraFlagsByte, CameraFocus, CameraFocusVec, CameraFollowObj, CameraFov, CameraFovTarget
extern CameraHeading, CameraHeight, CameraLag, CameraLookAt, CameraMode, CameraPathActive, CameraPathCount, CameraPathPoints
extern CameraPathTime, CameraPathVec, CameraPos, CameraSceneCenter, CameraSpeed, CameraStateRecords, CameraTargetObj, CameraTargetPoints
extern CameraTargetPtr, CameraTracking, CameraViewDefs, CameraViewFar, CameraViewNames, CameraViewNear, CameraViewPair, CameraViewParams
extern CameraViewSel, CameraViewTable, CameraViewX, CameraViewY, CameraViewZ, CameraZoom, F32_0p000232558, F32_0p000357143
extern F32_100, F32_10_UpdateCameraView, F32_1340, F32_2, F32_20, F32_2000, F32_2040, F32_20_DrawCameraDebugMarks
extern F32_3600, F32_400, F32_4000, F32_4100, F32_4800, F32_500, F32_700, F32_CameraNear
extern F32_neg0p000147059, F32_neg0p000188679, F32_neg1, F32_neg10, F32_neg1000, F32_neg1000_UpdateCameraZoom, F32_neg1050, F32_neg1340
extern F32_neg1800, F32_neg20, F32_neg2000, F32_neg3600, F32_neg4000, F32_neg4000_UpdateCameraZoom, F32_neg4100, F32_neg4600
extern F32_neg500, F32_neg500_UpdateCameraView, F32_neg700, F64_0p000333333, F64_0p0004, F64_0p38, F64_0p45, F64_0p7536
extern F64_0p785398, F64_0p85, F64_10, F64_1371p5, F64_1p2_UpdateCameraView, F64_2p5, F64_3, F64_3p14159
extern F64_3p14159_DampCameraMotion, F64_4, F64_6p28319, F64_6p66667, F64_8, F64_neg0p000357143, F64_neg0p000454545, F64_neg0p5
extern F64_neg0p7536, F64_neg0p85, F64_neg3p14159, F64_neg3p14159_DampCameraMotion, F64_neg4, F64_neg6p28319, F64_neg99p9, FillRectColor
extern GetLangText, hypot_, IF@ATAN2, IF@DPOW, InitCameraParams, MatchColor, MatRotY, ObjectPositions
extern ProjOffsetX, ProjOffsetY, RinkCameraPoints, RinkViewPoints, ScoreboardAngle, ScoreboardCorners, ScoreboardOn, SetCameraMode
extern SetCameraPathTarget, SetCameraSplineTarget, SetCameraTarget, SetTextColors, SnapCamera, SplineCoefs, SplineCoefsX, SplineCoefsY
extern SplineCount, SplineIndex, SplinePoints, SplineStep, str_CHASE, str_THRILLCAMTm, str_USERCHASE, strcpy_
extern TargetPointObj, TargetPoints, TargetVecX, TargetVecY, TargetVecZ, UpdateCameraMotion, UpdateCameraProjection, VecAdd
extern VecDistance, VecLength, VecMulMat, VecNormalizeTo, VecScale, VecSub, ViewDistanceTable
global GetCameraTarget, GetTargetPoint, UpdateCameraViewJumpTable, UpdateCameraView, UpdateCameraView_28, UpdateCameraView_54, UpdateCameraView_AC, UpdateCameraView_11B
global UpdateCameraView_1AC, UpdateCameraView_272, UpdateCameraView_326, UpdateCameraView_461, UpdateCameraView_5F0, UpdateCameraView_7F5, UpdateCameraView_8D3, UpdateCameraZoomJumpTable
global UpdateCameraZoom, UpdateCameraZoom_21, UpdateCameraZoom_169, UpdateCameraZoom_221, UpdateCameraZoom_232, UpdateCameraZoom_3CB, UpdateCameraTrackJumpTable, UpdateCameraTrack
global UpdateCameraTrack_30, UpdateCameraTrack_8E, UpdateCameraTrack_19B, UpdateCameraTrack_22F, UpdateCameraTrack_2D2, EaseAngle, EaseCameraAnglesJumpTable, EaseCameraAngles
global EaseCameraAngles_15, EaseCameraAngles_29, EaseCameraAngles_40, EaseCameraAngles_57, SetCameraViewJumpTable, SetCameraView, SetCameraView_16, SetCameraView_AF
global SetCameraView_14F, SetCameraView_1EF, SetCameraView_25A, SetCameraView_2CE, SetCameraView_36E, SetCameraView_40E, SetCameraView_4AE, SetCameraView_532
global SetCameraView_5A5, SetCameraView_608, BuildSplinePath, SetCameraSpline, SetCameraHeight, SetCameraFocus, SetCameraPathPoint, StartCameraPath
global SetCameraPathPoints, FightCameraStart, ResetSceneCamera, SelectCameraView, UpdateGameCamera, DampCameraMotion, ToggleCameraFollow, InitCamera
global DrawCameraDebugMarks
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; GetCameraTarget                                 191F8  97 PC, low confidence
; (target 4-10h and up): the position record of a camera target (player
; records at ObjectPositions, then fixed targets); 0 when none
;-----------------------------------------------------------------------------
GetCameraTarget:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 68h
        cmp eax, byte 4
        jl near .4
        cmp eax, byte 10h
        jg near .4
        mov ebx, eax
        shl eax, 4
        sub eax, ebx
        shl eax, 2
        sub eax, ebx
        shl eax, 5
        add eax, ObjectPositions
        lea ebx, [dword eax-01D80h]
        lea edi, [byte esp+03Ch]
        mov esi, ebx
        movsd
        movsd
        movsd
        mov eax, esp
        push dword [byte ebx+0Ch]
        call MatRotY
        lea eax, [byte ebx+070h]
        mov edx, esp
        lea ebx, [byte esp+030h]
        call VecMulMat
        mov ebx, TargetVecX
        mov edx, CameraStateRecords+7
        lea eax, [byte esp+03Ch]
        call VecSub
        call VecLength
        fst dword [byte esp+060h]
        fcomp dword [F32_2000]
        fnstsw ax
        sahf
        jbe short .1
        mov dword [byte esp+05Ch], 3F000000h
        jmp short .3
.1:
        fld dword [byte esp+060h]
        fcomp dword [F32_500]
        fnstsw ax
        sahf
        jae short .2
        mov dword [byte esp+05Ch], 3F800000h
        jmp short .3
.2:
        fld dword [byte esp+060h]
        fadd dword [F32_neg500]
        fmul qword [F64_0p000333333]
        fld1
        fsubrp
        fstp dword [byte esp+05Ch]
.3:
        lea eax, [byte esp+030h]
        push eax
        push dword [byte esp+060h]
        mov ebx, TargetVecX
        call VecScale
        mov edx, eax
        lea eax, [byte esp+03Ch]
        call VecAdd
        mov eax, TargetVecX
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        cmp eax, byte 13h
        jb short .6
        jbe near .10
        cmp eax, byte 17h
        jb short .5
        cmp eax, byte 18h
        jbe near .11
        lea ebx, [nosplit eax*4+00h]
        sub ebx, eax
        shl ebx, 2
        cmp eax, byte 1Dh
        jbe near .18
        cmp eax, byte 21h
        jbe near .19
        jmp near .25
.5:
        cmp eax, byte 14h
        jbe near .21
        jmp near .14
.6:
        cmp eax, byte 2
        jb short .7
        cmp eax, byte 3
        jbe near .20
        cmp eax, byte 11h
        jb near .25
        jbe near .17
        jmp short .8
.7:
        cmp eax, byte 1
        je short .9
        xor eax, eax
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        mov eax, CameraSceneCenter
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov eax, ViewDistanceTable
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        mov eax, dword [ScoreboardOn]
        test eax, eax
        je near .26
        mov eax, ScoreboardAngle
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        mov ebx, 43480000h
        mov edx, 0C4FF0000h
        mov dword [TargetVecY], ebx
        mov dword [TargetVecX], edx
        jne short .12
        mov dword [byte esp+054h], 0FFFFFE0Ch
        jmp short .13
.12:
        mov dword [byte esp+054h], 1F4h
.13:
        fild dword [byte esp+054h]
        mov eax, TargetVecX
        fstp dword [TargetVecZ]
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.14:
        mov ebp, 43480000h
        mov edi, 44FF0000h
        mov dword [TargetVecY], ebp
        mov dword [TargetVecX], edi
        cmp eax, byte 16h
        jne short .15
        mov dword [byte esp+058h], 0FFFFFE0Ch
        jmp short .16
.15:
        mov dword [byte esp+058h], 1F4h
.16:
        fild dword [byte esp+058h]
        mov eax, TargetVecX
        fstp dword [TargetVecZ]
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.17:
        mov ecx, 45228000h
        xor edx, edx
        mov eax, TargetVecX
        mov dword [TargetVecX], edx
        mov dword [TargetVecY], ecx
        mov dword [TargetVecZ], edx
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.18:
        mov eax, RinkCameraPoints
        add eax, ebx
        sub eax, byte 54h
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.19:
        mov eax, RinkViewPoints
        add eax, ebx
        sub eax, byte 0Ch
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.20:
        lea ebx, [byte eax-02h]
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        mov edi, TargetVecX
        lea esi, [nosplit eax*4+ScoreboardCorners]
        movsd
        movsd
        movsd
        fld dword [TargetVecY]
        fadd dword [F32_100]
        mov eax, TargetVecX
        fstp dword [TargetVecY]
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.21:
        mov ebp, dword [CameraTargetObj]
        xor ebx, ebx
        xor esi, esi
        mov dword [byte esp+050h], ebx
        mov dword [byte esp+04Ch], ebx
        mov dword [byte esp+048h], ebx
        mov dword [byte esp+064h], ebx
        test ebp, ebp
        jle short .24
        xor ecx, ecx
.22:
        mov eax, dword [dword ecx+CameraTargetPtr]
        call GetCameraTarget
        test eax, eax
        je short .23
        lea ebx, [byte esp+024h]
        push ebx
        push dword [dword ecx+CameraTargetPoints]
        call VecScale
        lea ebx, [byte esp+048h]
        mov edx, eax
        lea eax, [byte esp+048h]
        call VecAdd
        fld dword [byte esp+064h]
        fadd dword [dword ecx+CameraTargetPoints]
        fstp dword [byte esp+064h]
.23:
        mov ebp, dword [CameraTargetObj]
        inc esi
        add ecx, byte 4
        cmp esi, ebp
        jl short .22
.24:
        fld1
        fdiv dword [byte esp+064h]
        push TargetVecX
        sub esp, byte 4
        lea eax, [byte esp+050h]
        fstp dword [esp]
        call VecScale
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.25:
        xor eax, eax
.26:
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; GetTargetPoint                                  19540  97 PC, low confidence
; Returns the point the game camera looks at: the puck, its carrier or the
; object the scene follows
;-----------------------------------------------------------------------------
GetTargetPoint:
        push ebx
        cmp eax, byte 4
        jl short .1
        cmp eax, byte 10h
        jg short .1
        lea ebx, [byte eax-04h]
        mov eax, ebx
        shl eax, 4
        sub eax, ebx
        shl eax, 2
        sub eax, ebx
        shl eax, 5
        mov ebx, dword [dword eax+TargetPoints]
        mov dword [edx], ebx
        jmp near .10
.1:
        cmp eax, byte 11h
        jb short .3
        jbe short .7
        cmp eax, byte 15h
        jb short .2
        cmp eax, byte 16h
        jbe short .6
        cmp eax, byte 18h
        jbe short .5
        jmp short .9
.2:
        cmp eax, byte 12h
        je short .4
        jmp short .9
.3:
        cmp eax, byte 2
        jb short .9
        jbe short .7
        cmp eax, byte 3
        je short .8
        jmp short .9
.4:
        mov eax, dword [TargetPointObj]
        mov dword [edx], eax
        mov eax, 1
        pop ebx
        ret
.5:
        mov dword [edx], 3FC90FDBh
        mov eax, 1
        pop ebx
        ret
.6:
        mov dword [edx], 0BFC90FDBh
        mov eax, 1
        pop ebx
        ret
.7:
        mov dword [edx], 0
        mov eax, 1
        pop ebx
        ret
.8:
        mov dword [edx], 40490FDBh
        mov eax, 1
        pop ebx
        ret
.9:
        xor eax, eax
        pop ebx
        ret
.10:
        mov eax, 1
        pop ebx
        ret
        push esi
        push edi
        mov esi, eax
        mov eax, dword [CameraTracking]
        call GetCameraTarget
        test eax, eax
        je short .11
        lea edi, [dword esi+0E4h]
        mov esi, eax
        movsd
        movsd
        movsd
.11:
        pop edi
        pop esi
        ret
UpdateCameraViewJumpTable:                      ; jump table for the switch cases of UpdateCameraView
        dd UpdateCameraView_8D3
        dd UpdateCameraView_54
        dd UpdateCameraView_28
        dd UpdateCameraView_AC
        dd UpdateCameraView_8D3
        dd UpdateCameraView_8D3
        dd UpdateCameraView_8D3
        dd UpdateCameraView_11B
        dd UpdateCameraView_272
        dd UpdateCameraView_326
        dd UpdateCameraView_1AC
        dd UpdateCameraView_461
        dd UpdateCameraView_5F0
        dd UpdateCameraView_7F5
;-----------------------------------------------------------------------------
; UpdateCameraView                                1963C  97 PC, low confidence
; (camera, ...): per frame, the camera by its view kind (+24h, 0-0Dh)
;-----------------------------------------------------------------------------
UpdateCameraView:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 168h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov eax, edx
        mov edx, dword [byte ecx+024h]
        cmp edx, byte 0Dh
        ja near UpdateCameraView_8D3
        jmp dword [nosplit cs:edx*4+UpdateCameraViewJumpTable]
UpdateCameraView_28:
        cmp dword [CameraTracking], byte 0
        je near UpdateCameraView_8D3
        lea ebx, [dword ecx+0FCh]
        lea edx, [dword ecx+0108h]
        lea eax, [dword ecx+0E4h]
        call VecAdd
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
UpdateCameraView_54:
        cmp dword [CameraTracking], byte 0
        je near UpdateCameraView_8D3
        lea edx, [dword ecx+0E4h]
        lea ebx, [dword esp+0CCh]
        lea eax, [dword ecx+0F0h]
        call VecSub
        lea eax, [dword esp+0CCh]
        push eax
        lea edx, [dword esp+0D0h]
        push dword [dword ecx+0114h]
        lea ebx, [dword ecx+0FCh]
        call VecNormalizeTo
        lea eax, [dword ecx+0E4h]
        call VecAdd
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
UpdateCameraView_AC:
        cmp dword [CameraTracking], byte 0
        je near UpdateCameraView_8D3
        lea ebx, [dword ecx+0FCh]
        lea edx, [dword ecx+0108h]
        lea eax, [dword ecx+0E4h]
        call VecAdd
        lea edx, [dword ecx+0E4h]
        lea ebx, [dword esp+0B4h]
        lea eax, [dword ecx+0FCh]
        call VecSub
        lea eax, [dword esp+0B4h]
        push eax
        lea edx, [dword esp+0B8h]
        push dword [dword ecx+0114h]
        lea ebx, [dword ecx+0FCh]
        call VecNormalizeTo
        lea eax, [dword ecx+0E4h]
        call VecAdd
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
UpdateCameraView_11B:
        mov edx, dword [SplineCount]
        sub edx, byte 1Eh
        cmp eax, edx
        jl short .2
        mov ebx, dword [SplineIndex]
        mov eax, dword [SplineStep]
        cmp eax, ebx
        jge short .1
        mov esi, dword [SplineCount]
        mov eax, dword [nosplit eax*4+SplinePoints]
        mov edx, dword [SplineStep]
        add esi, eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov ebx, SplineCoefsY
        shl eax, 2
        add ebx, eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, SplineCoefsX
        shl eax, 2
        add edx, eax
        mov eax, esi
        mov dword [SplineCount], esi
        call SetCameraSplineTarget
        inc dword [SplineStep]
        jmp short .3
.1:
        xor ecx, ecx
        mov dword [CameraViewX], ecx
        jmp short .3
.2:
        sub dword [SplineCount], eax
.3:
        mov edi, CameraLookAt
        mov esi, CameraStateRecords+7
        movsd
        movsd
        movsd
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
UpdateCameraView_1AC:
        lea edx, [dword esp+0150h]
        mov eax, dword [CameraTracking]
        call GetTargetPoint
        test eax, eax
        je near UpdateCameraView_8D3
        xor esi, esi
        mov eax, dword [CameraPathTime]
        mov dword [dword esp+013Ch], esi
        mov dword [dword esp+0138h], esi
        mov dword [dword esp+0140h], eax
        fld dword [dword ecx+0128h]
        fadd dword [dword ecx+0118h]
        lea ebx, [dword esp+012Ch]
        fstp dword [dword ecx+0118h]
        fld dword [dword esp+0150h]
        fadd dword [dword ecx+0118h]
        mov eax, esp
        fstp dword [dword esp+0150h]
        push dword [dword esp+0150h]
        lea edx, [byte esp+04h]
        call MatRotY
        lea eax, [dword esp+0138h]
        call VecMulMat
        lea ebx, [dword esp+012Ch]
        lea eax, [dword esp+012Ch]
        lea edx, [dword ecx+0E4h]
        call VecAdd
        mov eax, dword [dword esp+012Ch]
        mov dword [dword ecx+0FCh], eax
        mov eax, dword [CameraStateRecords+0Bh]
        mov dword [dword ecx+0100h], eax
        mov eax, dword [dword esp+0134h]
        mov dword [dword ecx+0104h], eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
UpdateCameraView_272:
        lea edx, [dword esp+014Ch]
        mov eax, dword [CameraTracking]
        call GetTargetPoint
        test eax, eax
        je near UpdateCameraView_8D3
        fld dword [dword esp+014Ch]
        lea ebx, [dword esp+0F0h]
        lea edx, [byte esp+024h]
        xor esi, esi
        mov eax, dword [CameraPathTime]
        mov dword [dword esp+0A0h], esi
        fadd dword [CameraPathVec]
        mov dword [dword esp+0A4h], eax
        fstp dword [dword esp+014Ch]
        push dword [dword esp+014Ch]
        lea eax, [byte esp+028h]
        mov dword [dword esp+0A0h], esi
        call MatRotY
        lea eax, [dword esp+09Ch]
        call VecMulMat
        lea ebx, [dword esp+0F0h]
        mov edx, CameraPos
        lea eax, [dword esp+0F0h]
        call VecAdd
        mov eax, dword [dword esp+0F0h]
        fld dword [CameraStateRecords+0Bh]
        mov dword [CameraLookAt], eax
        mov eax, dword [dword esp+0F8h]
        fstp dword [CameraHeight]
        mov dword [CameraFocusVec], eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
UpdateCameraView_326:
        mov eax, dword [CameraTargetPtr]
        call GetCameraTarget
        test eax, eax
        je near UpdateCameraView_8D3
        lea edi, [dword esp+0FCh]
        mov esi, eax
        movsd
        movsd
        movsd
        mov eax, dword [CameraViewTable]
        call GetCameraTarget
        test eax, eax
        je near UpdateCameraView_8D3
        lea edi, [dword esp+0114h]
        lea ebx, [dword esp+0D8h]
        mov esi, eax
        lea edx, [dword esp+0FCh]
        lea eax, [dword esp+0114h]
        movsd
        movsd
        movsd
        call VecSub
        fld dword [dword esp+0E0h]
        fld dword [dword esp+0D8h]
        call IF@ATAN2
        sub esp, byte 4
        fadd dword [CameraPathVec]
        lea eax, [byte esp+070h]
        fstp dword [esp]
        call MatRotY
        fld dword [dword esp+0E0h]
        fld dword [CameraPathTime]
        xor eax, eax
        fstp qword [dword esp+0144h]
        mov dword [dword esp+0124h], eax
        mov dword [dword esp+0120h], eax
        sub esp, byte 8
        fstp qword [esp]
        fld dword [dword esp+0E0h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fmul qword [dword esp+0144h]
        fstp dword [dword esp+0128h]
        cmp dword [dword esp+0128h], 449C4000h
        jge short .4
        mov dword [dword esp+0128h], 449C4000h
.4:
        lea ebx, [dword esp+0114h]
        lea edx, [byte esp+06Ch]
        lea eax, [dword esp+0120h]
        call VecMulMat
        lea ebx, [dword esp+0114h]
        mov edx, CameraPos
        lea eax, [dword esp+0114h]
        call VecAdd
        mov eax, dword [dword esp+0114h]
        fld dword [CameraStateRecords+0Bh]
        mov dword [CameraLookAt], eax
        mov eax, dword [dword esp+011Ch]
        fstp dword [CameraHeight]
        mov dword [CameraFocusVec], eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
UpdateCameraView_461:
        mov eax, dword [CameraTargetPtr]
        call GetCameraTarget
        test eax, eax
        je near UpdateCameraView_8D3
        lea edi, [dword esp+0108h]
        mov esi, eax
        movsd
        movsd
        movsd
        mov eax, dword [CameraViewTable]
        call GetCameraTarget
        test eax, eax
        je near UpdateCameraView_8D3
        lea edi, [dword esp+0E4h]
        lea ebx, [dword esp+0A8h]
        mov esi, eax
        lea edx, [dword esp+0108h]
        lea eax, [dword esp+0E4h]
        movsd
        movsd
        movsd
        call VecSub
        fld dword [dword esp+0B0h]
        fld dword [dword esp+0A8h]
        call IF@ATAN2
        fadd dword [CameraPathVec]
        fld dword [F32_CameraNear]
        fxch
        fstp dword [dword esp+0160h]
        fcomp qword [F64_neg99p9]
        fnstsw ax
        sahf
        jne short .5
        mov eax, dword [dword esp+0160h]
        mov dword [F32_CameraNear], eax
.5:
        fld dword [F32_CameraNear]
        fsub dword [dword esp+0160h]
        fldz
        fxch
        fstp dword [dword esp+015Ch]
        fcomp dword [dword esp+015Ch]
        fnstsw ax
        sahf
        jae short .6
        mov eax, dword [dword esp+015Ch]
        mov dword [dword esp+0164h], eax
        jmp short .7
.6:
        fld dword [dword esp+015Ch]
        fchs
        fstp dword [dword esp+0164h]
.7:
        fld dword [dword esp+0164h]
        fcomp qword [F64_0p785398]
        fnstsw ax
        sahf
        jbe short .8
        lea eax, [byte esp+048h]
        push dword [dword esp+0160h]
        call MatRotY
        mov eax, dword [dword esp+0160h]
        mov dword [F32_CameraNear], eax
        jmp short .9
.8:
        lea eax, [byte esp+048h]
        push dword [F32_CameraNear]
        call MatRotY
.9:
        lea edx, [byte esp+048h]
        xor ebx, ebx
        mov eax, dword [CameraPathTime]
        mov dword [dword esp+094h], ebx
        mov dword [dword esp+090h], ebx
        mov dword [dword esp+098h], eax
        lea ebx, [dword esp+0E4h]
        lea eax, [dword esp+090h]
        call VecMulMat
        lea ebx, [dword esp+0E4h]
        mov edx, CameraPos
        lea eax, [dword esp+0E4h]
        call VecAdd
        mov eax, dword [dword esp+0E4h]
        fld dword [CameraStateRecords+0Bh]
        mov dword [CameraLookAt], eax
        mov eax, dword [dword esp+0ECh]
        fstp dword [CameraHeight]
        mov dword [CameraFocusVec], eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
UpdateCameraView_5F0:
        mov ah, byte [CameraFlagsByte]
        lea esi, [dword ecx+0108h]
        test ah, ah
        jne near .11
        mov edi, dword [dword ecx+0ECh]
        cmp edi, 43FA0000h
        jge short .10
        fld dword [dword ecx+0ECh]
        lea eax, [dword esp+0C0h]
        fadd dword [F32_neg500_UpdateCameraView]
        push eax
        fmul dword [F32_neg0p000188679]
        sub esp, byte 4
        fadd qword [F64_1p2_UpdateCameraView]
        mov eax, esi
        fstp dword [esp]
        call VecScale
        mov dword [dword ecx+02ACh], 3EDF66F3h
        jmp near .14
.10:
        cmp edi, 44FA0000h
        jle near .13
        fld dword [dword ecx+0ECh]
        lea eax, [dword esp+0C0h]
        fadd dword [F32_neg2000]
        push eax
        fmul dword [F32_0p000357143]
        sub esp, byte 4
        fld1
        fsubrp
        mov eax, esi
        fstp dword [esp]
        call VecScale
        mov dword [dword ecx+02ACh], 3DB2B8C3h
        jmp near .14
.11:
        fld dword [dword ecx+0ECh]
        fcomp dword [F32_neg500_UpdateCameraView]
        fnstsw ax
        sahf
        jbe short .12
        fld dword [dword ecx+0ECh]
        lea eax, [dword esp+0C0h]
        fadd dword [F32_neg500_UpdateCameraView]
        push eax
        fmul dword [F32_0p000232558]
        sub esp, byte 4
        fadd qword [F64_1p2_UpdateCameraView]
        mov eax, esi
        fstp dword [esp]
        call VecScale
        mov dword [dword ecx+02ACh], 3EDF66F3h
        jmp short .14
.12:
        fld dword [dword ecx+0ECh]
        fcomp dword [F32_neg2000]
        fnstsw ax
        sahf
        jae short .13
        fld dword [dword ecx+0ECh]
        lea eax, [dword esp+0C0h]
        fadd dword [F32_neg2000]
        push eax
        fmul dword [F32_neg0p000147059]
        sub esp, byte 4
        fld1
        fsubrp
        mov eax, esi
        fstp dword [esp]
        call VecScale
        mov dword [dword ecx+02ACh], 3DB2B8C3h
        jmp short .14
.13:
        lea edi, [dword esp+0C0h]
        lea esi, [dword ecx+0108h]
        movsd
        movsd
        movsd
.14:
        cmp dword [CameraTracking], byte 0
        je short .15
        lea ebx, [dword ecx+0FCh]
        lea edx, [dword esp+0C0h]
        lea eax, [dword ecx+0E4h]
        call VecAdd
.15:
        fld dword [dword ecx+0F0h]
        fsub dword [dword ecx+0E4h]
        fldz
        fxch
        fstp dword [dword esp+0158h]
        fcomp dword [dword esp+0158h]
        fnstsw ax
        sahf
        jae short .16
        mov eax, dword [dword esp+0158h]
        mov dword [dword esp+0154h], eax
        jmp short .17
.16:
        fld dword [dword esp+0158h]
        fchs
        fstp dword [dword esp+0154h]
.17:
        fld dword [dword esp+0154h]
        fcomp dword [F32_20]
        fnstsw ax
        sahf
        jbe near UpdateCameraView_8D3
        fld dword [dword ecx+0F0h]
        fcomp dword [dword ecx+0E4h]
        fnstsw ax
        sahf
        jbe short .18
        fld dword [dword ecx+0FCh]
        fadd dword [F32_neg10]
        fstp dword [dword ecx+0FCh]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.18:
        fld dword [dword ecx+0FCh]
        fadd dword [F32_10_UpdateCameraView]
        fstp dword [dword ecx+0FCh]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
UpdateCameraView_7F5:
        fld dword [dword ecx+0ECh]
        fcomp dword [F32_neg1800]
        fnstsw ax
        sahf
        jbe short .19
        cmp dword [dword ecx+0ECh], 447A0000h
        jge short .19
        fld dword [dword ecx+0ECh]
        fadd dword [F32_neg1000]
        lea eax, [dword esp+0C0h]
        fmul qword [F64_1p2_UpdateCameraView]
        push eax
        fmul qword [F64_neg0p000357143]
        sub esp, byte 4
        fld1
        faddp
        lea eax, [dword ecx+0108h]
        fstp dword [esp]
        call VecScale
        jmp short .21
.19:
        fld dword [dword ecx+0ECh]
        fcomp dword [F32_neg1800]
        fnstsw ax
        sahf
        jae short .20
        fld dword [dword ecx+0ECh]
        fcomp dword [F32_neg4000]
        fnstsw ax
        sahf
        jbe short .20
        fld dword [F32_neg4000]
        fsub dword [dword ecx+0ECh]
        lea eax, [dword esp+0C0h]
        fmul qword [F64_1p2_UpdateCameraView]
        push eax
        fmul qword [F64_neg0p000454545]
        sub esp, byte 4
        fld1
        faddp
        lea eax, [dword ecx+0108h]
        fstp dword [esp]
        call VecScale
        jmp short .21
.20:
        lea edi, [dword esp+0C0h]
        lea esi, [dword ecx+0108h]
        movsd
        movsd
        movsd
.21:
        cmp dword [CameraTracking], byte 0
        je short UpdateCameraView_8D3
        lea ebx, [dword ecx+0FCh]
        lea edx, [dword esp+0C0h]
        lea eax, [dword ecx+0E4h]
        call VecAdd
UpdateCameraView_8D3:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
UpdateCameraZoomJumpTable:                      ; jump table for the switch cases of UpdateCameraZoom
        dd UpdateCameraZoom_3CB
        dd UpdateCameraZoom_169
        dd UpdateCameraZoom_3CB
        dd UpdateCameraZoom_232
        dd UpdateCameraZoom_221
        dd UpdateCameraZoom_21
;-----------------------------------------------------------------------------
; UpdateCameraZoom                                19F30  97 PC, low confidence
; (camera): the camera distance by its zoom mode (+28h, 0-5)
;-----------------------------------------------------------------------------
UpdateCameraZoom:
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 28h
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov eax, dword [byte eax+028h]
        cmp eax, byte 5
        ja near UpdateCameraZoom_3CB
        jmp dword [nosplit cs:eax*4+UpdateCameraZoomJumpTable]
UpdateCameraZoom_21:
        fld dword [dword esi+0FCh]
        fcomp dword [F32_neg1050]
        fnstsw ax
        sahf
        jae short .1
        mov dword [dword esi+0FCh], 0C4834000h
.1:
        cmp dword [dword esi+0FCh], 44834000h
        jle short .2
        mov dword [dword esi+0FCh], 44834000h
.2:
        cmp byte [CameraFlagsByte], 0
        jne near .5
        fld dword [dword esi+0104h]
        fcomp dword [F32_neg4600]
        fnstsw ax
        sahf
        jae short .3
        mov dword [dword esi+0104h], 0C58FC000h
.3:
        cmp dword [dword esi+0104h], 447A0000h
        jle short .4
        mov dword [dword esi+0104h], 447A0000h
.4:
        fld dword [dword esi+0104h]
        fld st0
        fmul qword [F64_0p0004]
        fmul st1
        fld qword [F64_3]
        fld st2
        call IF@DPOW
        fld qword [F64_8]
        fld qword [F64_10]
        call IF@DPOW
        fdivr qword [F64_4]
        fmulp
        faddp
        fxch
        fmul qword [F64_0p7536]
        faddp
        fadd qword [F64_1371p5]
        fstp dword [dword esi+0100h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        ret
.5:
        fld dword [dword esi+0104h]
        fcomp dword [F32_neg1000_UpdateCameraZoom]
        fnstsw ax
        sahf
        jae short .6
        mov dword [dword esi+0104h], 0C47A0000h
.6:
        cmp dword [dword esi+0104h], 458FC000h
        jle short .7
        mov dword [dword esi+0104h], 458FC000h
.7:
        fld dword [dword esi+0104h]
        fld st0
        fmul qword [F64_0p0004]
        fmul st1
        fld qword [F64_3]
        fld st2
        call IF@DPOW
        fld qword [F64_8]
        fld qword [F64_10]
        call IF@DPOW
        fdivr qword [F64_neg4]
        fmulp
        faddp
        fxch
        fmul qword [F64_neg0p7536]
        faddp
        fadd qword [F64_1371p5]
        fstp dword [dword esi+0100h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        ret
UpdateCameraZoom_169:
        fld dword [dword esi+0FCh]
        fcomp dword [dword esi+0278h]
        fnstsw ax
        sahf
        jae short .8
        mov eax, dword [dword esi+0278h]
        mov dword [dword esi+0FCh], eax
.8:
        fld dword [dword esi+0FCh]
        fcomp dword [dword esi+0284h]
        fnstsw ax
        sahf
        jbe short .9
        mov eax, dword [dword esi+0284h]
        mov dword [dword esi+0FCh], eax
.9:
        fld dword [dword esi+0100h]
        fcomp dword [dword esi+027Ch]
        fnstsw ax
        sahf
        jae short .10
        mov eax, dword [dword esi+027Ch]
        mov dword [dword esi+0100h], eax
.10:
        fld dword [dword esi+0100h]
        fcomp dword [dword esi+0288h]
        fnstsw ax
        sahf
        jbe short .11
        mov eax, dword [dword esi+0288h]
        mov dword [dword esi+0100h], eax
.11:
        fld dword [dword esi+0104h]
        fcomp dword [dword esi+0280h]
        fnstsw ax
        sahf
        jae short .12
        mov eax, dword [dword esi+0280h]
        mov dword [dword esi+0104h], eax
.12:
        fld dword [dword esi+0104h]
        fcomp dword [dword esi+028Ch]
        fnstsw ax
        sahf
        jbe near UpdateCameraZoom_3CB
        mov eax, dword [dword esi+028Ch]
        mov dword [dword esi+0104h], eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        ret
UpdateCameraZoom_221:
        cmp eax, byte 4
        jne short UpdateCameraZoom_232
        mov eax, dword [dword esi+027Ch]
        mov dword [dword esi+0100h], eax
UpdateCameraZoom_232:
        fld dword [dword esi+0FCh]
        fabs
        fld dword [dword esi+0104h]
        fabs
        mov dword [byte esp+01Ch], 43480000h
        fxch
        fstp dword [byte esp+08h]
        fst dword [byte esp+010h]
        fadd dword [F32_neg4100]
        fld dword [byte esp+08h]
        fxch
        fstp dword [byte esp+014h]
        fcomp dword [F32_1340]
        fnstsw ax
        sahf
        jae short .13
        fld dword [byte esp+010h]
        fcomp dword [F32_4800]
        fnstsw ax
        sahf
        jb near .19
        mov eax, dword [byte esp+014h]
        mov dword [byte esp+020h], eax
        jmp short .15
.13:
        fld dword [byte esp+08h]
        fadd dword [F32_neg1340]
        fld dword [byte esp+010h]
        fxch
        fstp dword [byte esp+018h]
        fcomp dword [F32_4100]
        fnstsw ax
        sahf
        jae short .14
        fld dword [byte esp+08h]
        fcomp dword [F32_2040]
        fnstsw ax
        sahf
        jb near .19
        mov eax, dword [byte esp+018h]
        mov dword [byte esp+020h], eax
        jmp short .15
.14:
        fld dword [byte esp+014h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fstp dword [byte esp+020h]
.15:
        fld dword [byte esp+020h]
        fcomp dword [F32_700]
        fnstsw ax
        sahf
        jbe near .19
        fld dword [byte esp+020h]
        fadd dword [F32_neg700]
        fst dword [byte esp+020h]
        fmul qword [F64_0p38]
        fld dword [byte esp+01Ch]
        fxch
        fadd st1
        fld dword [byte esp+020h]
        fxch
        fstp st2
        fxch
        fstp dword [byte esp+01Ch]
        fcomp dword [F32_3600]
        fnstsw ax
        sahf
        jbe short .18
        fld dword [byte esp+020h]
        fadd dword [F32_neg3600]
        fld dword [F32_400]
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jae short .16
        mov dword [byte esp+024h], 43C80000h
        jmp short .17
.16:
        mov eax, dword [byte esp+0Ch]
        mov dword [byte esp+024h], eax
.17:
        fld dword [byte esp+024h]
        fmul qword [F64_2p5]
        fadd dword [byte esp+01Ch]
        fstp dword [byte esp+01Ch]
.18:
        fld dword [byte esp+020h]
        fcomp dword [F32_4000]
        fnstsw ax
        sahf
        jbe short .19
        fld dword [byte esp+020h]
        fadd dword [F32_neg4000_UpdateCameraZoom]
        fmul qword [F64_0p45]
        fadd dword [byte esp+01Ch]
        fstp dword [byte esp+01Ch]
.19:
        fld dword [dword esi+0100h]
        fcomp dword [byte esp+01Ch]
        fnstsw ax
        sahf
        jae short .20
        mov eax, dword [byte esp+01Ch]
        mov dword [dword esi+0100h], eax
.20:
        cmp dword [dword esi+0100h], 45BB8000h
        jle short UpdateCameraZoom_3CB
        lea edi, [dword esi+0FCh]
        lea esi, [dword esi+0F0h]
        movsd
        movsd
        movsd
UpdateCameraZoom_3CB:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
UpdateCameraTrackJumpTable:                     ; jump table for the switch cases of UpdateCameraTrack
        dd UpdateCameraTrack_2D2
        dd UpdateCameraTrack_30
        dd UpdateCameraTrack_2D2
        dd UpdateCameraTrack_19B
        dd UpdateCameraTrack_22F
        dd UpdateCameraTrack_8E
;-----------------------------------------------------------------------------
; UpdateCameraTrack                               1A31C  97 PC, low confidence
; (camera): follows the camera path target by its track mode (+2Ch, 0-5)
;-----------------------------------------------------------------------------
UpdateCameraTrack:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 54h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        cmp dword [CameraTracking], byte 0
        je near UpdateCameraTrack_2D2
        mov eax, dword [byte eax+02Ch]
        cmp eax, byte 5
        ja near UpdateCameraTrack_2D2
        jmp dword [nosplit cs:eax*4+UpdateCameraTrackJumpTable]
UpdateCameraTrack_30:
        mov ebx, esp
        mov edx, CameraStateRecords+7
        lea eax, [dword ecx+0E4h]
        call VecSub
        fld dword [byte esp+08h]
        fld dword [esp]
        call IF@ATAN2
        fchs
        fstp dword [dword ecx+02A0h]
        fld dword [byte esp+08h]
        fld dword [byte esp+04h]
        fstp qword [byte esp+0Ch]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+08h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fld qword [byte esp+0Ch]
        call IF@ATAN2
        fstp dword [dword ecx+029Ch]
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
UpdateCameraTrack_8E:
        mov ebx, esp
        mov edx, CameraStateRecords+7
        lea eax, [dword ecx+0E4h]
        call VecSub
        fld dword [byte esp+08h]
        fld dword [esp]
        call IF@ATAN2
        fchs
        fstp dword [dword ecx+02A0h]
        fld dword [byte esp+08h]
        fld dword [byte esp+04h]
        fstp qword [byte esp+0Ch]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+08h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fld qword [byte esp+0Ch]
        call IF@ATAN2
        fld dword [dword ecx+02A0h]
        fcos
        fldz
        fxch st2
        fstp dword [dword ecx+029Ch]
        fstp qword [byte esp+02Ch]
        fcomp qword [byte esp+02Ch]
        fnstsw ax
        sahf
        jae short .1
        mov eax, dword [byte esp+02Ch]
        mov dword [byte esp+034h], eax
        mov eax, dword [byte esp+030h]
        mov dword [byte esp+038h], eax
        jmp short .2
.1:
        fld qword [byte esp+02Ch]
        fchs
        fstp qword [byte esp+034h]
.2:
        fld qword [byte esp+034h]
        fcomp qword [F64_0p85]
        fnstsw ax
        sahf
        jbe short .5
        fld dword [dword ecx+02A0h]
        fcos
        fldz
        fxch
        fstp qword [byte esp+044h]
        fcomp qword [byte esp+044h]
        fnstsw ax
        sahf
        jae short .3
        mov eax, dword [byte esp+044h]
        mov dword [byte esp+03Ch], eax
        mov eax, dword [byte esp+048h]
        mov dword [byte esp+040h], eax
        jmp short .4
.3:
        fld qword [byte esp+044h]
        fchs
        fstp qword [byte esp+03Ch]
.4:
        fld qword [byte esp+03Ch]
        fadd qword [F64_neg0p85]
        fmul qword [F64_6p66667]
        fmul dword [dword ecx+0134h]
        fadd dword [dword ecx+0130h]
        fstp dword [dword ecx+0100h]
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov eax, dword [dword ecx+0130h]
        mov dword [dword ecx+0100h], eax
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
UpdateCameraTrack_19B:
        mov ebx, esp
        mov edx, CameraStateRecords+7
        lea eax, [dword ecx+0E4h]
        call VecSub
        fld dword [byte esp+08h]
        fld dword [byte esp+04h]
        fstp qword [byte esp+0Ch]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+08h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fld qword [byte esp+0Ch]
        call IF@ATAN2
        fstp dword [dword ecx+029Ch]
        mov eax, dword [CameraStateRecords+7]
        mov dword [byte esp+014h], eax
        mov eax, dword [dword ecx+0278h]
        mov dword [byte esp+01Ch], eax
        fld dword [dword ecx+0284h]
        fsub dword [byte esp+01Ch]
        fstp dword [byte esp+024h]
        test dword [byte esp+024h], 7FFFFFFFh
        jne short .6
        xor eax, eax
        mov dword [byte esp+04Ch], eax
        jmp short .7
.6:
        fld dword [byte esp+014h]
        fsub dword [byte esp+01Ch]
        fdiv dword [byte esp+024h]
        fstp dword [byte esp+04Ch]
.7:
        fld dword [dword ecx+02B4h]
        fld dword [byte esp+04Ch]
        jmp near UpdateCameraTrack_22F.10
UpdateCameraTrack_22F:
        mov ebx, esp
        mov edx, CameraStateRecords+7
        lea eax, [dword ecx+0E4h]
        call VecSub
        fld dword [byte esp+08h]
        fld dword [byte esp+04h]
        fstp qword [byte esp+0Ch]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+08h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fld qword [byte esp+0Ch]
        call IF@ATAN2
        fstp dword [dword ecx+029Ch]
        mov eax, dword [CameraStateRecords+0Fh]
        mov dword [byte esp+018h], eax
        mov eax, dword [dword ecx+0280h]
        mov dword [byte esp+020h], eax
        fld dword [dword ecx+028Ch]
        fsub dword [byte esp+020h]
        fstp dword [byte esp+028h]
        test dword [byte esp+028h], 7FFFFFFFh
        jne short .8
        xor esi, esi
        mov dword [byte esp+050h], esi
        jmp short .9
.8:
        fld dword [byte esp+018h]
        fsub dword [byte esp+020h]
        fdiv dword [byte esp+028h]
        fstp dword [byte esp+050h]
.9:
        fld dword [dword ecx+02B4h]
        fld dword [byte esp+050h]
.10:
        fadd qword [F64_neg0p5]
        fmulp
        fadd dword [dword ecx+02B0h]
        fstp dword [dword ecx+02A0h]
UpdateCameraTrack_2D2:
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; EaseAngle                                       1A5F8  97 PC, low confidence
; Moves an angle toward a target angle by a fraction of the difference,
; taking the short way round
;-----------------------------------------------------------------------------
EaseAngle:
        push ecx
        push ebp
        mov ebp, esp
        sub esp, byte 18h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        fld dword [ebx]
        fabs
        fld dword [ecx]
        fsub dword [edx]
        fst dword [byte esp+014h]
        fst qword [byte esp+0Ch]
        fxch
        fstp dword [esp]
        fcomp qword [F64_3p14159]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+0Ch]
        fadd qword [F64_neg6p28319]
        fstp dword [byte esp+014h]
.1:
        fld dword [byte esp+014h]
        fst qword [byte esp+04h]
        fcomp qword [F64_neg3p14159]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+04h]
        fadd qword [F64_6p28319]
        fstp dword [byte esp+014h]
.2:
        fld dword [byte esp+014h]
        fcomp dword [esp]
        fnstsw ax
        sahf
        jbe short .3
        fld dword [edx]
        fadd dword [esp]
        jmp short .4
.3:
        fld dword [esp]
        fchs
        fcomp dword [byte esp+014h]
        fnstsw ax
        sahf
        jbe short .5
        fld dword [edx]
        fsub dword [esp]
.4:
        fstp dword [ecx]
.5:
        mov esp, ebp
        pop ebp
        pop ecx
        ret
EaseCameraAnglesJumpTable:                      ; jump table for the switch cases of EaseCameraAngles
        dd EaseCameraAngles_57
        dd EaseCameraAngles_15
        dd EaseCameraAngles_40
        dd EaseCameraAngles_29
;-----------------------------------------------------------------------------
; EaseCameraAngles                                1A690  97 PC, low confidence
; Eases the camera's heading, pitch and roll toward their targets each frame
;-----------------------------------------------------------------------------
EaseCameraAngles:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov eax, dword [byte eax+030h]
        cmp eax, byte 3
        ja short EaseCameraAngles_57
        jmp dword [nosplit cs:eax*4+EaseCameraAnglesJumpTable]
EaseCameraAngles_15:
        lea ebx, [dword ecx+02ACh]
        lea edx, [dword ecx+02A8h]
        lea eax, [dword ecx+029Ch]
        jmp short EaseCameraAngles_40.1
EaseCameraAngles_29:
        lea ebx, [dword ecx+02ACh]
        lea edx, [dword ecx+02A8h]
        lea eax, [dword ecx+029Ch]
        call EaseAngle
EaseCameraAngles_40:
        lea ebx, [dword ecx+02B4h]
        lea edx, [dword ecx+02B0h]
        lea eax, [dword ecx+02A0h]
.1:
        call EaseAngle
EaseCameraAngles_57:
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
        push edx
        mov edx, dword [byte eax+034h]
        test edx, edx
        jbe short .2
        cmp edx, byte 3
        jne short .2
        mov edx, dword [dword eax+02C4h]
        mov dword [dword eax+02C8h], edx
.2:
        pop edx
        ret
        db 090h
SetCameraViewJumpTable:                         ; jump table for the switch cases of SetCameraView
        dd SetCameraView_16
        dd SetCameraView_AF
        dd SetCameraView_14F
        dd SetCameraView_4AE
        dd SetCameraView_25A
        dd SetCameraView_2CE
        dd SetCameraView_40E
        dd SetCameraView_36E
        dd SetCameraView_532
        dd SetCameraView_5A5
        dd SetCameraView_608
        dd SetCameraView_608
        dd SetCameraView_608
        dd SetCameraView_1EF
;-----------------------------------------------------------------------------
; SetCameraView                                1A740  97 PC, medium confidence
; (camera, view 0-0Dh): fills a camera record (CameraPathPoints) with the view's
; name (GetLangText) and settings
;-----------------------------------------------------------------------------
SetCameraView:
        push ebx
        push esi
        push edi
        mov ebx, eax
        cmp edx, byte 0Dh
        ja near SetCameraView_608
        jmp dword [nosplit cs:edx*4+SetCameraViewJumpTable]
SetCameraView_16:
        mov eax, 86h
        call GetLangText
        mov edx, eax
        mov eax, ebx
        mov esi, CameraViewDefs
        call strcpy_
        lea edi, [dword ebx+0108h]
        mov dword [byte ebx+024h], 2
        movsd
        movsd
        movsd
        mov esi, CameraViewDefs+0Ch
        lea edi, [dword ebx+0278h]
        mov dword [byte ebx+028h], 1
        movsd
        movsd
        movsd
        mov esi, CameraViewDefs+18h
        lea edi, [dword ebx+0284h]
        movsd
        movsd
        movsd
        mov dword [byte ebx+030h], 3
        mov dword [dword ebx+02A8h], 0BF9A5AEEh
        mov dword [dword ebx+02ACh], 0
        mov dword [dword ebx+02B0h], 0
        mov dword [dword ebx+02B4h], 0
        mov dword [dword ebx+0128h], 0
        mov dword [byte ebx+034h], 3
        mov dword [dword ebx+02C4h], 3EB44674h
        pop edi
        pop esi
        pop ebx
        ret
SetCameraView_AF:
        mov eax, 87h
        call GetLangText
        mov edx, eax
        mov eax, ebx
        mov esi, CameraViewDefs+24h
        call strcpy_
        lea edi, [dword ebx+0108h]
        mov dword [byte ebx+024h], 2
        movsd
        movsd
        movsd
        mov esi, CameraViewDefs+30h
        lea edi, [dword ebx+0278h]
        mov dword [byte ebx+028h], 1
        movsd
        movsd
        movsd
        mov esi, CameraViewDefs+3Ch
        lea edi, [dword ebx+0284h]
        movsd
        movsd
        movsd
        mov dword [byte ebx+02Ch], 3
        mov dword [dword ebx+02B0h], 0
        mov dword [dword ebx+02B4h], 3E8A3D71h
        mov dword [dword ebx+0128h], 0
        mov dword [byte ebx+030h], 1
        mov dword [dword ebx+02A8h], 0BF67E910h
        mov dword [dword ebx+02ACh], 3DCCCCCDh
        mov dword [byte ebx+034h], 3
        mov dword [dword ebx+02C4h], 3EDBA5E3h
        pop edi
        pop esi
        pop ebx
        ret
SetCameraView_14F:
        mov eax, 88h
        call GetLangText
        mov edx, eax
        mov eax, ebx
        mov esi, CameraViewDefs+24h
        call strcpy_
        lea edi, [dword ebx+0108h]
        mov dword [byte ebx+024h], 2
        movsd
        movsd
        movsd
        mov esi, CameraViewDefs+54h
        lea edi, [dword ebx+0278h]
        mov dword [byte ebx+028h], 1
        movsd
        movsd
        movsd
        mov esi, CameraViewDefs+60h
        lea edi, [dword ebx+0284h]
        movsd
        movsd
        movsd
        mov dword [byte ebx+02Ch], 3
        mov dword [dword ebx+02B0h], 0
        mov dword [dword ebx+02B4h], 3E8A3D71h
        mov dword [dword ebx+0128h], 0
        mov dword [byte ebx+030h], 1
        mov dword [dword ebx+02A8h], 0BF67E910h
        mov dword [dword ebx+02ACh], 3DCCCCCDh
        mov dword [byte ebx+034h], 3
        mov dword [dword ebx+02C4h], 3EDBA5E3h
        pop edi
        pop esi
        pop ebx
        ret
SetCameraView_1EF:
        mov edx, str_CHASE
        call strcpy_
        mov dword [byte ebx+024h], 1
        mov dword [dword ebx+0114h], 453B8000h
        mov esi, CameraViewDefs+78h
        lea edi, [dword ebx+0278h]
        mov dword [byte ebx+028h], 1
        movsd
        movsd
        movsd
        mov esi, CameraViewDefs+84h
        lea edi, [dword ebx+0284h]
        movsd
        movsd
        movsd
        mov dword [byte ebx+02Ch], 1
        mov dword [byte ebx+030h], 0
        mov dword [dword ebx+0128h], 0
        mov dword [byte ebx+034h], 3
        mov dword [dword ebx+02C4h], 3F060A92h
        pop edi
        pop esi
        pop ebx
        ret
SetCameraView_25A:
        mov eax, 8Ah
        call GetLangText
        mov edx, eax
        mov eax, ebx
        call strcpy_
        mov dword [byte ebx+024h], 1
        mov dword [dword ebx+0114h], 451C4000h
        mov esi, CameraViewDefs+090h
        lea edi, [dword ebx+0278h]
        mov dword [byte ebx+028h], 1
        movsd
        movsd
        movsd
        mov esi, CameraViewDefs+09Ch
        lea edi, [dword ebx+0284h]
        movsd
        movsd
        movsd
        mov dword [byte ebx+02Ch], 1
        mov dword [byte ebx+030h], 0
        mov dword [dword ebx+0128h], 0
        mov dword [byte ebx+034h], 3
        mov dword [dword ebx+02C4h], 3F226E98h
        pop edi
        pop esi
        pop ebx
        ret
SetCameraView_2CE:
        mov eax, 8Bh
        call GetLangText
        mov edx, eax
        mov eax, ebx
        mov esi, CameraViewDefs+0A8h
        call strcpy_
        lea edi, [dword ebx+0108h]
        mov dword [byte ebx+024h], 0Dh
        movsd
        movsd
        movsd
        mov esi, CameraViewDefs+0B4h
        lea edi, [dword ebx+0278h]
        mov dword [byte ebx+028h], 1
        movsd
        movsd
        movsd
        mov esi, CameraViewDefs+0C0h
        lea edi, [dword ebx+0284h]
        movsd
        movsd
        movsd
        mov dword [byte ebx+02Ch], 3
        mov dword [dword ebx+02B0h], 0
        mov dword [dword ebx+02B4h], 3F20D97Ch
        mov dword [dword ebx+0128h], 0
        mov dword [byte ebx+030h], 1
        mov dword [dword ebx+02A8h], 0BF169446h
        mov dword [dword ebx+02ACh], 3DCCCCCDh
        mov dword [byte ebx+034h], 3
        mov dword [dword ebx+02C4h], 3F060A92h
        pop edi
        pop esi
        pop ebx
        ret
SetCameraView_36E:
        mov eax, 8Dh
        call GetLangText
        mov edx, eax
        mov eax, ebx
        mov esi, CameraViewDefs+0FCh
        call strcpy_
        lea edi, [dword ebx+0108h]
        mov dword [byte ebx+024h], 2
        movsd
        movsd
        movsd
        mov esi, CameraViewDefs+0CCh
        lea edi, [dword ebx+0278h]
        mov dword [byte ebx+028h], 1
        movsd
        movsd
        movsd
        mov esi, CameraViewDefs+0D8h
        lea edi, [dword ebx+0284h]
        movsd
        movsd
        movsd
        mov dword [dword ebx+0128h], 0
        mov dword [byte ebx+02Ch], 4
        mov dword [dword ebx+02B0h], 0BFC90FF9h
        mov dword [dword ebx+02B4h], 0BE4CCCCDh
        mov dword [byte ebx+030h], 1
        mov dword [dword ebx+02A8h], 0BF666666h
        mov dword [dword ebx+02ACh], 3DCCCCCDh
        mov dword [byte ebx+034h], 3
        mov dword [dword ebx+02C4h], 3EC703B0h
        pop edi
        pop esi
        pop ebx
        ret
SetCameraView_40E:
        mov eax, 8Ch
        call GetLangText
        mov edx, eax
        mov eax, ebx
        mov esi, CameraViewDefs+0FCh
        call strcpy_
        lea edi, [dword ebx+0108h]
        mov dword [byte ebx+024h], 2
        movsd
        movsd
        movsd
        mov esi, CameraViewDefs+0E4h
        lea edi, [dword ebx+0278h]
        mov dword [byte ebx+028h], 1
        movsd
        movsd
        movsd
        mov esi, CameraViewDefs+0F0h
        lea edi, [dword ebx+0284h]
        movsd
        movsd
        movsd
        mov dword [byte ebx+02Ch], 1
        mov dword [dword ebx+0128h], 0
        mov dword [byte ebx+030h], 3
        mov dword [dword ebx+02A8h], 0BF24C2F8h
        mov dword [dword ebx+02ACh], 3DCCCCCDh
        mov dword [dword ebx+02B0h], 0BFC90FF9h
        mov dword [dword ebx+02B4h], 3EDC28F6h
        mov dword [byte ebx+034h], 3
        mov dword [dword ebx+02C4h], 3F060A92h
        pop edi
        pop esi
        pop ebx
        ret
SetCameraView_4AE:
        mov eax, 89h
        call GetLangText
        mov edx, eax
        mov eax, ebx
        mov esi, CameraViewDefs+6Ch
        call strcpy_
        lea edi, [dword ebx+0108h]
        mov dword [byte ebx+024h], 0Ch
        movsd
        movsd
        movsd
        mov dword [byte ebx+028h], 5
        mov dword [byte ebx+02Ch], 3
        mov dword [dword ebx+02B0h], 0
        mov dword [dword ebx+02B4h], 3E32B8C3h
        mov dword [dword ebx+0128h], 0
        mov dword [byte ebx+030h], 1
        mov dword [dword ebx+02A8h], 0BF5F66F3h
        mov dword [dword ebx+02ACh], 3EDF66F3h
        mov dword [byte ebx+034h], 3
        mov dword [dword ebx+02C4h], 3F060A92h
        pop edi
        pop esi
        pop ebx
        ret
SetCameraView_532:
        mov edx, str_THRILLCAMTm
        mov edi, CameraLookAt
        mov esi, CameraStateRecords+7
        call strcpy_
        fld dword [CameraStateRecords+13h]
        fld dword [CameraStateRecords+17h]
        fld dword [CameraStateRecords+1Fh]
        movsd
        movsd
        movsd
        xor edx, edx
        fxch st2
        fstp dword [CameraFov]
        fstp dword [CameraFovTarget]
        fstp dword [CameraFollowObj]
        mov dword [CameraViewZ], edx
        mov dword [CameraViewX], edx
        mov dword [CameraViewY], edx
        mov dword [CameraMode], edx
        mov dword [CameraFocus], edx
        mov dword [CameraViewPair], edx
        mov dword [CameraViewNear], edx
        mov dword [CameraViewFar], edx
        pop edi
        pop esi
        pop ebx
        ret
SetCameraView_5A5:
        mov edx, str_USERCHASE
        call strcpy_
        mov edx, CameraPos
        mov eax, CameraStateRecords+7
        mov dword [byte ebx+024h], 1
        call VecDistance
        mov dword [byte ebx+028h], 4
        fstp dword [dword ebx+0114h]
        fld dword [CameraStateRecords+0Bh]
        mov dword [byte ebx+02Ch], 1
        mov dword [byte ebx+030h], 0
        mov dword [dword ebx+0128h], 0
        mov dword [byte ebx+034h], 0
        fstp dword [dword ebx+027Ch]
        mov eax, dword [CameraStateRecords+1Fh]
        mov dword [dword ebx+02C4h], eax
SetCameraView_608:
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; BuildSplinePath                                 1AD4C  97 PC, low confidence
; Builds the spline coefficients of a camera path through its control points
;-----------------------------------------------------------------------------
BuildSplinePath:
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        and esp, byte 0FFFFFFF8h
        mov dword [byte esp+04h], eax
        mov dword [byte esp+0Ch], edx
        mov edi, ebx
        mov dword [esp], ecx
        cmp eax, byte 1
        jle near .5
        mov ebx, dword [byte ebp+010h]
        lea ecx, [byte edx+0Ch]
        test ebx, ebx
        je short .1
        mov edx, eax
        shl eax, 2
        sub eax, edx
        mov edx, dword [byte esp+0Ch]
        shl eax, 2
        add edx, eax
        mov ebx, edi
        sub edx, byte 0Ch
        mov eax, ecx
        call VecSub
        jmp short .2
.1:
        mov edx, CameraStateRecords+7
        mov ebx, edi
        mov eax, ecx
        call VecSub
.2:
        mov eax, dword [esp]
        fild dword [eax]
        fld1
        fdivrp
        push edi
        mov esi, 1
        sub esp, byte 4
        mov eax, edi
        fstp dword [esp]
        mov ecx, dword [byte esp+08h]
        call VecScale
        mov eax, dword [byte esp+04h]
        add edi, byte 0Ch
        sub eax, esi
        add ecx, byte 4
        mov dword [byte esp+08h], eax
        jmp short .4
.3:
        add eax, dword [byte esp+0Ch]
        lea edx, [byte eax-0Ch]
        mov ebx, edi
        add eax, byte 0Ch
        call VecSub
        fild dword [ecx]
        fld1
        fdivrp
        push edi
        add ecx, byte 4
        inc esi
        sub esp, byte 4
        mov eax, edi
        fstp dword [esp]
        add edi, byte 0Ch
        call VecScale
.4:
        imul eax, esi, byte 0Ch
        cmp esi, dword [byte esp+08h]
        jl short .3
        cmp dword [byte ebp+010h], byte 0
        je short .5
        mov edx, dword [byte esp+04h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov esi, dword [byte esp+0Ch]
        shl eax, 2
        add eax, esi
        lea edx, [byte eax-018h]
        mov ebx, edi
        mov eax, esi
        call VecSub
        fild dword [ecx]
        fld1
        fdivrp
        push edi
        sub esp, byte 4
        mov eax, edi
        fstp dword [esp]
        call VecScale
        jmp short .6
.5:
        mov esi, SplineCoefs
        movsd
        movsd
        movsd
.6:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; SetCameraSpline                                 1AE58  97 PC, low confidence
; Starts the camera along a spline path: control points, length and speed
;-----------------------------------------------------------------------------
SetCameraSpline:
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebp, eax
        mov esi, edx
        mov dword [esp], ebx
        test eax, eax
        jle near .4
        xor ebx, ebx
        mov edx, 7
        mov dword [CameraViewY], ebx
        mov dword [CameraViewX], edx
        cmp eax, byte 0Ah
        jle short .1
        mov ebp, 0Ah
.1:
        mov ebx, SplineCoefsY
        push ecx
        mov edx, esi
        mov eax, ebp
        mov ecx, dword [byte esp+04h]
        mov dword [SplineIndex], ebp
        call BuildSplinePath
        xor eax, eax
        test ebp, ebp
        jle short .3
        mov ebx, dword [esp]
        mov edx, esi
.2:
        mov esi, dword [ebx]
        mov dword [nosplit eax*4+SplinePoints], esi
        imul esi, eax, byte 0Ch
        add ebx, byte 4
        lea edi, [dword esi+SplineCoefsX]
        mov esi, edx
        inc eax
        add edx, byte 0Ch
        movsd
        movsd
        movsd
        cmp eax, ebp
        jl short .2
.3:
        mov eax, dword [esp]
        mov eax, dword [eax]
        mov dword [SplineCount], eax
        mov eax, dword [esp]
        mov ebx, SplineCoefsY
        mov edx, SplineCoefsX
        mov eax, dword [eax]
        mov ecx, 1
        call SetCameraSplineTarget
        mov dword [SplineStep], ecx
.4:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        ret
        push ebx
        push ecx
        push esi
        push edi
        sub esp, byte 4
        mov dword [esp], edx
        mov edi, CameraLookAt
        xor edx, edx
        mov esi, eax
        mov dword [CameraViewX], edx
        mov ebx, dword [esp]
        movsd
        movsd
        movsd
        test ebx, ebx
        jle short .5
        mov ebx, esp
        mov edx, eax
        xor ecx, ecx
        mov eax, 1
        call SetCameraSpline
        jmp short .6
.5:
        mov ebx, 4
        mov edx, eax
        xor eax, eax
        call SnapCamera
.6:
        add esp, byte 4
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetCameraHeight                                 1AF4C  97 PC, low confidence
; Sets the camera height (CameraHeight), at once or eased over frames
;-----------------------------------------------------------------------------
SetCameraHeight:
        push ebx
        push edx
        mov edx, dword [byte esp+010h]
        mov eax, dword [byte esp+0Ch]
        xor ebx, ebx
        mov dword [CameraHeight], eax
        mov dword [CameraViewY], ebx
        test edx, edx
        jle short .1
        push byte 0
        push eax
        mov eax, 1
        call SetCameraTarget
        pop edx
        pop ebx
        ret 8
.1:
        push byte 4
        mov edx, 1
        push eax
        xor eax, eax
        call UpdateCameraMotion
        pop edx
        pop ebx
        ret 8
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetCameraFocus                                  1AF90  97 PC, low confidence
; Sets the camera focus x / z (CameraLookAt, CameraFocusVec), at once or eased
;-----------------------------------------------------------------------------
SetCameraFocus:
        push ebx
        push edx
        mov ebx, dword [byte esp+014h]
        mov eax, dword [byte esp+0Ch]
        xor edx, edx
        mov dword [CameraLookAt], eax
        mov eax, dword [byte esp+010h]
        mov dword [CameraViewX], edx
        mov dword [CameraFocusVec], eax
        test ebx, ebx
        jle short .1
        push byte 0
        mov edx, ebx
        xor eax, eax
        push dword [byte esp+010h]
        call SetCameraTarget
        push byte 0
        mov eax, 2
        mov edx, ebx
        push dword [byte esp+014h]
        call SetCameraTarget
        pop edx
        pop ebx
        ret 0Ch
.1:
        mov ebx, 4
        mov edx, CameraLookAt
        xor eax, eax
        call SnapCamera
        pop edx
        pop ebx
        ret 0Ch
        push ebx
        push edx
        mov edx, dword [byte esp+010h]
        mov eax, dword [byte esp+0Ch]
        xor ebx, ebx
        mov dword [CameraFollowObj], eax
        mov dword [CameraFocus], ebx
        test edx, edx
        jle short .2
        push byte 0
        push eax
        mov eax, 6
        call SetCameraTarget
        pop edx
        pop ebx
        ret 8
.2:
        push byte 4
        mov edx, 6
        push eax
        xor eax, eax
        call UpdateCameraMotion
        pop edx
        pop ebx
        ret 8
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetCameraPathPoint                              1B034  97 PC, low confidence
; Sets the camera path point (CameraFov, CameraFovTarget), at once or eased
;-----------------------------------------------------------------------------
SetCameraPathPoint:
        push ebx
        push edx
        mov ebx, dword [byte esp+014h]
        mov eax, dword [byte esp+0Ch]
        xor edx, edx
        mov dword [CameraFov], eax
        mov eax, dword [byte esp+010h]
        mov dword [CameraViewZ], edx
        mov dword [CameraFovTarget], eax
        test ebx, ebx
        jle short .1
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
        pop edx
        pop ebx
        ret 0Ch
.1:
        push byte 4
        push eax
        xor eax, eax
        push dword [byte esp+014h]
        call BuildCameraMatrix
        pop edx
        pop ebx
        ret 0Ch
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; StartCameraPath                                 1B09C  97 PC, low confidence
; (path, ticks): starts a camera path (CameraTracking) for the game camera
;-----------------------------------------------------------------------------
StartCameraPath:
        push ebx
        push ecx
        push esi
        push edi
        mov ebx, eax
        mov ecx, edx
        test eax, eax
        je short .1
        call GetCameraTarget
        test eax, eax
        je near .5
.1:
        mov edx, 1
        mov dword [CameraTracking], ebx
        mov eax, ebx
        mov dword [CameraViewZ], edx
        call GetCameraTarget
        test eax, eax
        je short .2
        mov edi, CameraPos
        mov esi, eax
        movsd
        movsd
        movsd
.2:
        mov eax, CameraPathPoints
        call UpdateCameraTrack
        test ecx, ecx
        jle short .3
        fld dword [CameraFov]
        fld dword [CameraFovTarget]
        mov eax, 3
        fxch
        fstp dword [CameraStateRecords+2Fh]
        mov edx, ecx
        fstp dword [CameraStateRecords+33h]
        call SetCameraPathTarget
        mov eax, 4
        mov edx, ecx
        call SetCameraPathTarget
        jmp short .4
.3:
        push byte 4
        push dword [CameraFovTarget]
        xor eax, eax
        push dword [CameraFov]
        call BuildCameraMatrix
.4:
        mov eax, 1
.5:
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        push esi
        mov ecx, dword [byte esp+01Ch]
        mov ebx, eax
        mov edx, 8
        mov eax, CameraPathPoints
        call SetCameraView
        mov edx, 8
        mov esi, 3
        mov dword [CameraPathActive], edx
        mov edx, ecx
        mov eax, ecx
        sar edx, 1Fh
        idiv esi
        mov edx, eax
        mov eax, ebx
        call StartCameraPath
        test eax, eax
        je short .6
        mov eax, dword [byte esp+014h]
        mov ebx, 8
        mov dword [CameraPathTime], eax
        mov eax, dword [byte esp+018h]
        mov dword [CameraViewX], ebx
        mov dword [CameraPathVec], eax
.6:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 0Ch
        db 090h
        push edx
        mov eax, dword [byte esp+08h]
        mov dword [CameraPathTime], eax
        mov eax, dword [byte esp+0Ch]
        mov edx, 0Ah
        mov dword [CameraPathVec], eax
        mov eax, dword [byte esp+010h]
        mov dword [CameraViewX], edx
        mov dword [CameraViewPair], eax
        pop edx
        ret 0Ch
        db 090h
;-----------------------------------------------------------------------------
; SetCameraPathPoints                             1B1CC  97 PC, low confidence
; Fills the control points of the camera path from the current camera and the
; target view
;-----------------------------------------------------------------------------
SetCameraPathPoints:
        push ecx
        push ebp
        mov ebp, esp
        sub esp, byte 8
        and esp, byte 0FFFFFFF8h
        mov dword [byte esp+04h], eax
        fild dword [byte esp+04h]
        fld1
        fdivrp
        mov ebx, 14h
        mov ecx, 1
        mov dword [CameraTargetObj], eax
        mov dword [CameraTracking], ebx
        mov dword [CameraViewZ], ecx
        fstp dword [esp]
        test eax, eax
        jle short .2
        mov ecx, dword [byte esp+04h]
        xor eax, eax
        shl ecx, 2
.1:
        add eax, byte 4
        mov ebx, dword [edx]
        mov dword [dword eax+CameraTargetObj], ebx
        mov ebx, dword [esp]
        add edx, byte 4
        mov dword [dword eax+CameraPathCount], ebx
        cmp eax, ecx
        jl short .1
.2:
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop ecx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push ebp
        mov ebp, esp
        sub esp, byte 8
        and esp, byte 0FFFFFFF8h
        mov dword [byte esp+04h], eax
        fild dword [byte esp+04h]
        fld1
        fdivrp
        mov ebx, 14h
        mov eax, dword [byte ebp+010h]
        mov ecx, 5
        mov dword [CameraViewNear], eax
        mov eax, dword [byte ebp+014h]
        mov dword [CameraTracking], ebx
        mov dword [CameraViewFar], eax
        mov eax, dword [byte esp+04h]
        mov dword [CameraViewZ], ecx
        mov dword [CameraTargetObj], eax
        fstp dword [esp]
        test eax, eax
        jle short .4
        mov ecx, dword [byte esp+04h]
        xor eax, eax
        shl ecx, 2
.3:
        add eax, byte 4
        mov ebx, dword [edx]
        mov dword [dword eax+CameraTargetObj], ebx
        mov ebx, dword [esp]
        add edx, byte 4
        mov dword [dword eax+CameraPathCount], ebx
        cmp eax, ecx
        jl short .3
.4:
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop ecx
        pop ebx
        ret 0Ch
        db 08Bh,0C0h
        push ebx
        push ecx
        push esi
        sub esp, byte 8
        mov ecx, 442F0000h
        mov dword [esp], eax
        mov dword [byte esp+04h], edx
        mov edx, 8
        mov eax, CameraPathPoints
        xor ebx, ebx
        call SetCameraView
        push byte 0
        mov edx, 8
        push dword 442F0000h
        mov eax, 1
        mov dword [CameraViewY], ebx
        mov dword [CameraHeight], ecx
        mov dword [CameraPathActive], edx
        mov edx, 190h
        mov ebx, dword [byte esp+028h]
        call SetCameraTarget
        mov edx, esp
        mov eax, 2
        call SetCameraPathPoints
        test eax, eax
        je short .5
        mov eax, dword [byte esp+018h]
        mov esi, 9
        mov dword [CameraPathTime], eax
        mov eax, dword [byte esp+01Ch]
        mov dword [CameraViewX], esi
        mov dword [CameraPathVec], eax
.5:
        add esp, byte 8
        pop esi
        pop ecx
        pop ebx
        ret 0Ch
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FightCameraStart                                1B340  97 PC, low confidence
; Moves the camera to the fight view around the two fighting players
;-----------------------------------------------------------------------------
FightCameraStart:
        push ebx
        push ecx
        push esi
        push edi
        sub esp, byte 8
        mov ecx, 442F0000h
        mov dword [esp], eax
        mov dword [byte esp+04h], edx
        mov edx, 8
        mov eax, CameraPathPoints
        xor ebx, ebx
        call SetCameraView
        push byte 0
        mov edx, 8
        push dword 442F0000h
        mov eax, 1
        mov dword [CameraViewY], ebx
        mov dword [CameraHeight], ecx
        mov dword [CameraPathActive], edx
        mov edx, 190h
        mov ebx, dword [byte esp+02Ch]
        call SetCameraTarget
        mov edx, esp
        mov eax, 2
        call SetCameraPathPoints
        test eax, eax
        je short .1
        mov edi, 3
        mov eax, dword [byte esp+01Ch]
        mov esi, 0Bh
        mov dword [CameraViewY], edi
        mov dword [CameraPathTime], eax
        mov eax, dword [byte esp+020h]
        mov dword [CameraViewX], esi
        mov dword [CameraPathVec], eax
.1:
        add esp, byte 8
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 0Ch
        db 090h
;-----------------------------------------------------------------------------
; ResetSceneCamera                                1B3D8  97 PC, low confidence
; Ends a camera scene: clears the scene function and puts the camera back on
; the game view
;-----------------------------------------------------------------------------
ResetSceneCamera:
        push edx
        mov edx, 8
        mov eax, CameraPathPoints
        call SetCameraView
        mov dword [CameraPathActive], 8
        pop edx
        ret
;-----------------------------------------------------------------------------
; SelectCameraView                             1B3F4  97 PC, medium confidence
; (view, ticks): picks the game camera view (mod 10) with SetCameraView and
; moves the camera to it
;-----------------------------------------------------------------------------
SelectCameraView:
        push ebx
        push ecx
        push esi
        mov ebx, eax
        mov ecx, edx
        mov edx, eax
        mov esi, 0Ah
        sar edx, 1Fh
        idiv esi
        mov eax, CameraPathPoints
        mov dword [CameraPathActive], edx
        call SetCameraView
        cmp byte [CameraFlagsByte], 0
        je short .1
        mov eax, CameraPathPoints
        call DampCameraMotion
.1:
        test ecx, ecx
        jle near .3
        mov edx, dword [CameraViewSel]
        xor eax, eax
        call UpdateGameCamera
        xor ebx, ebx
        fld dword [CameraLookAt]
        fld dword [CameraHeight]
        fld dword [CameraFocusVec]
        fld dword [CameraFov]
        fld dword [CameraFovTarget]
        fld dword [CameraViewParams]
        fld dword [CameraFollowObj]
        fxch st6
        fstp dword [CameraStateRecords+23h]
        fxch st4
        fstp dword [CameraStateRecords+27h]
        fxch st2
        fstp dword [CameraStateRecords+2Bh]
        fstp dword [CameraStateRecords+2Fh]
        fstp dword [CameraStateRecords+33h]
        fstp dword [CameraStateRecords+37h]
        fstp dword [CameraStateRecords+3Bh]
.2:
        mov edx, ecx
        mov eax, ebx
        inc ebx
        call SetCameraPathTarget
        cmp ebx, byte 7
        jge short .4
        jmp short .2
.3:
        mov edx, 4
        xor eax, eax
        xor ebx, ebx
        mov dword [CameraViewSel], edx
        call UpdateGameCamera
        mov dword [CameraViewSel], ebx
        call SetCameraMode
.4:
        mov edx, CameraPathPoints
        mov eax, CameraViewNames
        call strcpy_
        pop esi
        pop ecx
        pop ebx
        lea eax, [byte eax+00h]
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; UpdateGameCamera                                1B4E4  97 PC, low confidence
; Per-frame game camera: runs the scene function or follows the target with
; the chosen camera view
;-----------------------------------------------------------------------------
UpdateGameCamera:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ecx, eax
        mov ebp, edx
        fld dword [CameraStateRecords+13h]
        fld dword [CameraStateRecords+17h]
        mov edi, CameraElevation
        mov esi, CameraStateRecords+7
        fld dword [CameraStateRecords+1Fh]
        movsd
        movsd
        movsd
        mov eax, dword [CameraTracking]
        fxch st2
        fstp dword [CameraDistance]
        fstp dword [CameraAngles]
        fstp dword [CameraLag]
        call GetCameraTarget
        test eax, eax
        je short .1
        mov edi, CameraPos
        mov esi, eax
        movsd
        movsd
        movsd
.1:
        mov eax, CameraPathPoints
        mov edx, ecx
        call UpdateCameraView
        mov ebx, ebp
        mov eax, CameraPathPoints
        mov edx, CameraLookAt
        call UpdateCameraZoom
        mov eax, ecx
        call SnapCamera
        mov eax, CameraPathPoints
        call UpdateCameraTrack
        mov eax, CameraPathPoints
        call EaseCameraAngles
        push ebp
        push dword [CameraFovTarget]
        mov eax, ecx
        push dword [CameraFov]
        call BuildCameraMatrix
        mov eax, dword [CameraFocus]
        test eax, eax
        jbe short .2
        cmp eax, byte 3
        jne short .2
        mov eax, dword [CameraSpeed]
        mov dword [CameraFollowObj], eax
.2:
        push ebp
        mov eax, ecx
        push dword [CameraFollowObj]
        call UpdateCameraProjection
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DampCameraMotion                                1B5B0  97 PC, low confidence
; Smooths the camera position toward its goal so the view does not jump
;-----------------------------------------------------------------------------
DampCameraMotion:
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        fld dword [dword eax+0108h]
        fmul dword [F32_neg1]
        fld dword [dword eax+0110h]
        fmul dword [F32_neg1]
        fld dword [dword eax+02B0h]
        fst qword [byte esp+08h]
        fxch st2
        fstp dword [dword eax+0108h]
        fstp dword [dword eax+0110h]
        fcomp qword [F64_3p14159_DampCameraMotion]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+08h]
        fadd qword [F64_neg3p14159_DampCameraMotion]
        jmp short .2
.1:
        fld qword [byte esp+08h]
        fadd qword [F64_3p14159_DampCameraMotion]
.2:
        fstp dword [dword edx+02B0h]
        fld dword [dword edx+0278h]
        fld dword [dword edx+02B4h]
        fchs
        mov eax, dword [dword edx+0284h]
        fld dword [dword edx+0280h]
        mov dword [byte esp+04h], eax
        fxch
        fstp dword [dword edx+02B4h]
        fld dword [byte esp+04h]
        fxch st2
        fchs
        fxch st2
        fchs
        mov eax, dword [dword edx+028Ch]
        fxch st2
        fstp dword [dword edx+0284h]
        mov dword [esp], eax
        fxch
        fstp dword [dword edx+0278h]
        fld dword [esp]
        fxch
        fchs
        fxch
        fchs
        fxch
        fstp dword [dword edx+028Ch]
        fstp dword [dword edx+0280h]
        mov esp, ebp
        pop ebp
        pop edx
        ret
;-----------------------------------------------------------------------------
; ToggleCameraFollow                              1B67C  97 PC, low confidence
; Switches the camera between following the puck and following the controlled
; player
;-----------------------------------------------------------------------------
ToggleCameraFollow:
        push ebx
        push ecx
        push edx
        mov eax, CameraPathPoints
        call DampCameraMotion
        cmp dword [CameraPathActive], byte 3
        jne short .1
        fld dword [CameraZoom]
        fsub dword [CameraHeading]
        fmul dword [F32_2]
        fsubr dword [CameraZoom]
        fstp dword [CameraZoom]
.1:
        mov ebx, 4
        xor eax, eax
        xor ecx, ecx
        mov edx, ebx
        mov dword [CameraViewSel], ebx
        call UpdateGameCamera
        mov dword [CameraViewSel], ecx
        call SetCameraMode
        mov ah, byte [CameraFlagsByte]
        test ah, ah
        sete al
        mov byte [CameraFlagsByte], al
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; InitCamera                                      1B6E8  97 PC, low confidence
; Sets the camera to its start view and clears the scene state at the start
; of a game
;-----------------------------------------------------------------------------
InitCamera:
        jmp near InitCameraParams
        db 08Dh,040h,00h
        push edx
        push esi
        push edi
        mov edx, 1
        lea esi, [byte esp+010h]
        mov edi, CameraEye
        mov dword [CameraViewY], edx
        movsd
        movsd
        movsd
        lea esi, [byte esp+01Ch]
        mov edi, CameraCenter
        movsd
        movsd
        movsd
        pop edi
        pop esi
        pop edx
        ret 18h
;-----------------------------------------------------------------------------
; DrawCameraDebugMarks                            1B71C  97 PC, low confidence
; Debug: draws markers at the camera target and path points
;-----------------------------------------------------------------------------
DrawCameraDebugMarks:
        push ebx
        push ecx
        push edx
        push edi
        push ebp
        sub esp, byte 8
        test dword [CameraDebugMask], 7FFFFFFFh
        je near .1
        push dword 0FF00AA00h
        call MatchColor
        fld dword [ProjOffsetX]
        fld dword [ProjOffsetY]
        fld st0
        add esp, byte 4
        fxch st2
        call __CHP
        fistp dword [esp]
        push eax
        fadd dword [F32_20_DrawCameraDebugMarks]
        mov ebx, dword [byte esp+04h]
        call __CHP
        fistp dword [byte esp+04h]
        push ebx
        mov ecx, dword [byte esp+08h]
        fadd dword [F32_neg20]
        push ecx
        call __CHP
        push ebx
        fistp dword [byte esp+010h]
        mov edi, dword [byte esp+010h]
        push edi
        call FillRectColor
        add esp, byte 14h
        push dword 0FF00AA00h
        call MatchColor
        fld dword [ProjOffsetX]
        fld dword [ProjOffsetY]
        fld dword [ProjOffsetX]
        add esp, byte 4
        fxch
        call __CHP
        fistp dword [byte esp+04h]
        push eax
        fxch
        fadd dword [F32_20_DrawCameraDebugMarks]
        fxch
        fadd dword [F32_neg20]
        fxch
        call __CHP
        fistp dword [byte esp+04h]
        mov ebp, dword [byte esp+04h]
        mov eax, dword [byte esp+08h]
        push ebp
        call __CHP
        push eax
        fistp dword [byte esp+010h]
        mov edx, dword [byte esp+010h]
        push edx
        push eax
        call FillRectColor
        add esp, byte 14h
.1:
        add esp, byte 8
        pop ebp
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
        push ecx
        push edx
        cmp eax, dword [CameraDebugLimit]
        jne short .3
        cmp dword [CameraDebugMarks], byte 0
        je short .2
        push dword 0FFAA0000h
        call MatchColor
        add esp, byte 4
        push eax
        push byte 0FFFFFFFFh
        jmp short .4
.2:
        push dword 0FF00AA00h
        call MatchColor
        add esp, byte 4
        push eax
        push byte 0FFFFFFFFh
        jmp short .4
.3:
        push byte 0FFFFFFFFh
        call MatchColor
        add esp, byte 4
        push eax
        push dword 0FF000000h
.4:
        call MatchColor
        add esp, byte 4
        push eax
        call SetTextColors
        add esp, byte 8
        pop edx
        pop ecx
        ret
