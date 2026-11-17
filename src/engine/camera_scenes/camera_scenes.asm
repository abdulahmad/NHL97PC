; Camera scenes: penalties, intermission, opening, fights, faceoffs, menus, goals and penalty shots.
bits 32
%include "hockey.inc"
section s_1B85B progbits alloc exec nowrite align=1
extern ActiveCameraScene, CameraCenter, CameraElevation, CameraEye, CameraFlagsByte, CameraFocus, CameraFollowObj, CameraHeading
extern CameraHeight, CameraLookAt, CameraPathActive, CameraPathPoints, CameraPathTime, CameraPathVec, CameraPos, CameraSceneArg
extern CameraSceneCenter, CameraSceneDist, CameraSceneFunc, CameraSceneId, CameraScenesEnabled, CameraScenesOn, CameraSceneStep, CameraSceneYaw
extern CameraViewPair, CameraViewSel, CameraViewX, CameraViewY, CameraZoom, DrawClockOverlay, F32_1000, F32_1500
extern F32_2000_PenaltySceneStep, F32_2040_PenaltyCameraDistance, F32_750, F32_neg1000_FaceoffCloseupScene, F32_neg1000_MenuOrbitScene, F32_neg1500, F32_neg200, F32_neg2000_FaceoffCameraScene2
extern F32_neg300, F32_neg400, F32_neg700_MenuOrbitScene, F32_neg750, F64_0p01_OpeningCameraStep, F64_30, F64_3p14159_OpeningCameraStep, F64_6p28319_OpeningCameraStep
extern F64_neg3p14159_OpeningCameraStep, F64_neg6p28319_OpeningCameraStep, FaceoffCloseupInit, FaceoffDropScene, FaceoffSweepInit, FadeGamePalette, FightCameraReady, FightCameraStart
extern FightSceneActive, FightSceneState, FightSceneTimer, FreeMemBlock, gameopts, GetCameraTarget, gmode, GoalCameraFrom
extern GoalCameraTo, GoalSceneActive, GoalSceneCamFrom, GoalSceneCamTo, hypot_, IntermissionActive, IntermissionCamPath, IntermissionTimes
extern LoadOpeningArt, LoadResourceDataShared, MenuCamPos, MenuCamTarget, MenuOrbitAngle, ObjectPositions, OpeningCamActive, OpeningCamData
extern OpeningCamFrame, OpeningCamFrames, PenaltyCamDistance, PenaltyCamTimer, PenaltySceneDist, PenaltySceneYaw, PenShotSceneState, PenShotSceneTimer
extern penshottimer, rand_, ReplayCameraActive, ResetSceneCamera, SavedCameraView, SceneSavedView, SceneStepCount, SelectCameraView
extern SetArtArchive, SetCameraFocus, SetCameraHeight, SetCameraPathPoint, SetCameraPathPoints, SetCameraSpline, SetCameraTarget, SetCameraView
extern SnapCamera, sprintf_, StartCameraPath, str_ArenaViv, str_IntroD3cp, TargetPointObj, UpdateCameraMotion, UpdateGameCamera
global RunCameraScene, CameraNoop, CanStartCameraScene, SetCameraSceneFunc, PenaltyCameraDistance, PenaltySceneStepJumpTable, PenaltySceneStep, PenaltySceneStep_1C
global PenaltySceneStep_73, PenaltySceneStep_C6, PenaltySceneStep_108, PenaltyCameraScene, IntermissionSceneStep, IntermissionCameraScene, EndOpeningCamera, OpeningCameraStep
global LoadOpeningCamera, FightSceneStep, FightCameraScene, SetFightCameraReady, SceneReturnToView, FaceoffCameraScene, FaceoffSceneStep, FaceoffCloseupScene
global FaceoffSweepStep, FaceoffSweepScene, FaceoffCameraScene2, MenuCameraScene, MenuOrbitStep, MenuOrbitScene, PenShotSceneStep, PenaltyShotCameraScene
global EndPenShotScene, GoalSceneStep, GoalCameraScene, FaceoffDropSceneStep, FaceoffDropCameraScene, RestoreGameCamera, PenaltyCallSceneStep, PenaltyCallCameraScene
global SetFaceoffEndFlag
        db 090h
;-----------------------------------------------------------------------------
; RunCameraScene                                  1B85C  97 PC, low confidence
; Calls the current camera scene step function when one is set
;-----------------------------------------------------------------------------
RunCameraScene:
        push ebx
        push edx
        mov ebx, eax
        cmp dword [ActiveCameraScene], byte 0
        je short .1
        test eax, eax
        je short .1
        add dword [CameraSceneArg], eax
        call dword [CameraSceneFunc]
.1:
        mov edx, dword [CameraViewSel]
        mov eax, ebx
        call UpdateGameCamera
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CameraNoop                                      1B88C  97 PC, low confidence
; Empty camera scene step
;-----------------------------------------------------------------------------
CameraNoop:
        xor eax, eax
        LD mov, eax, eax
;-----------------------------------------------------------------------------
; CanStartCameraScene                             1B890  97 PC, low confidence
; (priority 1-7): whether a scripted camera scene of this priority may start now (none running, or a higher
; priority than the running one; 0 ends the scene)
;-----------------------------------------------------------------------------
CanStartCameraScene:
        push ebx
        push edx
        mov ebx, 2
        test eax, eax
        jne short .1
        mov bl, 1
        mov dword [ActiveCameraScene], eax
        xor dh, dh
        mov eax, 1
        mov byte [CameraScenesOn], bl
        mov byte [CameraFlagsByte], dh
        pop edx
        pop ebx
        ret
.1:
        cmp byte [ReplayCameraActive], 0
        jne short .6
        cmp eax, byte 7
        jne short .2
        mov edx, dword [gameopts]
        test byte [byte edx+02h], 20h
        jne short .6
.2:
        cmp byte [IntermissionActive], 0
        je short .3
        cmp eax, byte 7
        je short .6
.3:
        cmp byte [CameraScenesOn], 0
        je short .4
        cmp eax, byte 1
        jne short .6
.4:
        cmp dword [ActiveCameraScene], byte 0
        je short .5
        movsx edx, bx
        cmp eax, edx
        jge short .6
.5:
        mov eax, 1
        pop edx
        pop ebx
        ret
.6:
        xor eax, eax
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetCameraSceneFunc                              1B90C  97 PC, low confidence
; Sets the function that drives the camera each frame for the current scene
;-----------------------------------------------------------------------------
SetCameraSceneFunc:
        push ecx
        push edx
        mov ecx, 1
        xor edx, edx
        mov dword [CameraSceneFunc], eax
        mov dword [CameraSceneStep], edx
        mov dword [ActiveCameraScene], ecx
        mov dword [CameraSceneArg], edx
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PenaltyCameraDistance                           1B930  97 PC, low confidence
; Returns how far the camera stays from the penalized player in the penalty
; scene
;-----------------------------------------------------------------------------
PenaltyCameraDistance:
        push eax
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        and esp, byte 0FFFFFFF8h
        mov edx, dword [PenaltyCamTimer]
        mov eax, edx
        shl eax, 4
        sub eax, edx
        shl eax, 2
        sub eax, edx
        shl eax, 5
        add eax, ObjectPositions
        cmp dword [eax], 44FF0000h
        jle short .1
        xor esi, esi
        mov dword [byte esp+04h], esi
        jmp short .4
.1:
        fld dword [F32_2040_PenaltyCameraDistance]
        fild dword [PenaltyCamDistance]
        fsubr dword [byte eax+08h]
        fxch
        fsub dword [eax]
        fldz
        fxch
        fstp dword [byte esp+08h]
        fcompp
        fnstsw ax
        sahf
        je short .2
        mov dword [esp], 0FFFFFE0Ch
        jmp short .3
.2:
        mov dword [esp], 1F4h
.3:
        fild dword [esp]
        fabs
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+010h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fstp dword [byte esp+04h]
.4:
        fld dword [byte esp+04h]
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop eax
        ret
        db 08Dh,040h,00h
PenaltySceneStepJumpTable:                      ; jump table for the switch cases of PenaltySceneStep
        dd PenaltySceneStep_1C
        dd PenaltySceneStep_73
        dd PenaltySceneStep_C6
        dd PenaltySceneStep_108
;-----------------------------------------------------------------------------
; PenaltySceneStep                                1B9D4  97 PC, low confidence
; Camera step of the penalty scene: follows the penalized player to the box
;-----------------------------------------------------------------------------
PenaltySceneStep:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov eax, dword [CameraSceneStep]
        cmp eax, byte 3
        ja near PenaltySceneStep_108.1
        jmp dword [nosplit cs:eax*4+PenaltySceneStepJumpTable]
PenaltySceneStep_1C:
        call PenaltyCameraDistance
        fcomp dword [F32_2000_PenaltySceneStep]
        fnstsw ax
        sahf
        ja near PenaltySceneStep_108.1
        push byte 0
        mov esi, 43C80000h
        push dword 43C80000h
        mov edx, 190h
        xor ecx, ecx
        mov eax, 1
        mov dword [CameraViewY], ecx
        mov dword [CameraHeight], esi
        call SetCameraTarget
        mov ebp, dword [CameraSceneStep]
        inc ebp
        mov dword [CameraSceneArg], ecx
        mov dword [CameraSceneStep], ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PenaltySceneStep_73:
        cmp dword [CameraSceneArg], 0C8h
        jl near PenaltySceneStep_108.1
        mov edx, dword [PenaltyCamDistance]
        lea eax, [nosplit edx*4+00h]
        push dword 190h
        sub eax, edx
        push dword [nosplit eax*4+PenaltySceneDist]
        push dword [nosplit eax*4+PenaltySceneYaw]
        call SetCameraFocus
        mov ebx, dword [CameraSceneStep]
        xor edx, edx
        inc ebx
        mov dword [CameraSceneArg], edx
        mov dword [CameraSceneStep], ebx
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PenaltySceneStep_C6:
        cmp dword [CameraSceneArg], 190h
        jl short PenaltySceneStep_108.1
        mov edx, 8
        mov eax, CameraPathPoints
        mov esi, 8
        call SetCameraView
        xor edi, edi
        mov ebp, dword [CameraSceneStep]
        mov dword [CameraPathActive], esi
        inc ebp
        mov dword [CameraSceneArg], edi
        mov dword [CameraSceneStep], ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PenaltySceneStep_108:
        cmp dword [CameraSceneArg], 190h
        jl short .1
        mov eax, FaceoffSweepStep
        mov ebx, 0BF490FDBh
        call SetCameraSceneFunc
        xor edx, edx
        mov eax, 0FFFFFFFFh
        mov dword [SceneStepCount], ebx
        mov ebx, 32h
        call FadeGamePalette
.1:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PenaltyCameraScene                              1BB18  97 PC, low confidence
; From asspenalty: scripted camera scene, priority 6 (SetCameraView 8,
; StartCameraPath, PenaltySceneStep per frame)
;-----------------------------------------------------------------------------
PenaltyCameraScene:
        push ebx
        push esi
        push edi
        push ebp
        mov ebx, eax
        mov eax, 6
        call CanStartCameraScene
        test eax, eax
        je short .1
        mov esi, PenaltySceneStep
        mov edi, 1
        mov eax, CameraPathPoints
        mov ebp, 8
        mov dword [PenaltyCamTimer], ebx
        mov dword [PenaltyCamDistance], edx
        xor edx, edx
        mov dword [CameraSceneFunc], esi
        mov dword [CameraSceneArg], edx
        mov dword [CameraSceneStep], edx
        mov edx, 8
        mov dword [ActiveCameraScene], edi
        call SetCameraView
        mov edx, 12Ch
        lea eax, [byte ebx+04h]
        mov dword [CameraPathActive], ebp
        call StartCameraPath
        mov dword [CameraScenesEnabled], edi
        call DrawClockOverlay
.1:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; IntermissionSceneStep                           1BB94  97 PC, low confidence
; Camera step of the intermission scene: slow move over the rink
;-----------------------------------------------------------------------------
IntermissionSceneStep:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov eax, dword [CameraSceneStep]
        test eax, eax
        jbe short .1
        cmp eax, byte 1
        je short .2
        jmp short .3
.1:
        cmp dword [CameraSceneArg], 3E8h
        jl short .3
        mov ecx, 1
        mov ebx, IntermissionTimes
        mov edx, IntermissionCamPath
        mov eax, 4
        call SetCameraSpline
        mov edi, dword [CameraSceneStep]
        xor esi, esi
        inc edi
        mov dword [CameraSceneArg], esi
        mov dword [CameraSceneStep], edi
        jmp short .3
.2:
        cmp dword [CameraSceneArg], 0C80h
        jl short .3
        mov ebx, IntermissionTimes
        mov edx, IntermissionCamPath
        mov ecx, eax
        mov eax, 4
        call SetCameraSpline
        xor ebx, ebx
        mov dword [CameraSceneArg], ebx
.3:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; IntermissionCameraScene                         1BC18  97 PC, low confidence
; Starts the intermission camera scene
;-----------------------------------------------------------------------------
IntermissionCameraScene:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov edx, 8
        mov eax, CameraPathPoints
        mov esi, IntermissionSceneStep
        mov edi, 1
        mov ebp, 4B0h
        call SetCameraView
        xor ebx, ebx
        xor ecx, ecx
        mov edx, 8
        mov eax, 11h
        mov dword [CameraSceneArg], ebx
        mov dword [CameraSceneStep], ebx
        mov dword [CameraSceneFunc], esi
        mov dword [ActiveCameraScene], edi
        mov edi, CameraLookAt
        mov dword [CameraPathActive], edx
        mov edx, 1F4h
        mov esi, IntermissionCamPath
        call StartCameraPath
        mov edx, IntermissionCamPath
        mov eax, 1
        mov dword [esp], ebp
        mov dword [CameraViewX], ebx
        mov ebx, esp
        movsd
        movsd
        movsd
        call SetCameraSpline
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; EndOpeningCamera                                1BCA8  97 PC, low confidence
; Ends the opening camera move and hands the camera to the game view
;-----------------------------------------------------------------------------
EndOpeningCamera:
        push ebx
        push ecx
        push edx
        cmp dword [OpeningCamActive], byte 0
        je short .1
        mov ebx, dword [OpeningCamFrame]
        push ebx
        call FreeMemBlock
        add esp, byte 4
        xor eax, eax
        xor ecx, ecx
        call LoadOpeningArt
        mov dword [ActiveCameraScene], ecx
        mov dword [OpeningCamActive], ecx
.1:
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; OpeningCameraStep                               1BCDC  97 PC, low confidence
; Camera step of the opening scene: the fly-in over the arena before the
; first faceoff
;-----------------------------------------------------------------------------
OpeningCameraStep:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 2Ch
        and esp, byte 0FFFFFFF8h
        fild dword [CameraSceneArg]
        fmul qword [F64_30]
        fmul qword [F64_0p01_OpeningCameraStep]
        fst dword [byte esp+018h]
        push eax
        fistp dword [esp]
        pop eax
        mov edx, dword [OpeningCamData]
        mov dword [byte esp+01Ch], eax
        cmp eax, edx
        jl short .1
        cmp dword [OpeningCamActive], byte 0
        je near .7
        mov eax, dword [OpeningCamFrame]
        push eax
        call FreeMemBlock
        add esp, byte 4
        xor eax, eax
        xor edx, edx
        call LoadOpeningArt
        mov dword [ActiveCameraScene], edx
        mov dword [OpeningCamActive], edx
        jmp near .7
.1:
        mov edx, eax
        shl eax, 2
        sub eax, edx
        mov edx, dword [OpeningCamFrames]
        shl eax, 3
        add edx, eax
        mov eax, dword [OpeningCamData]
        mov ebx, dword [byte esp+01Ch]
        dec eax
        cmp eax, ebx
        jle near .5
        lea ebx, [byte edx+018h]
        fld dword [ebx]
        fild dword [byte esp+01Ch]
        fsubr dword [byte esp+018h]
        fxch
        fsub dword [edx]
        fxch
        fstp dword [byte esp+018h]
        fmul dword [byte esp+018h]
        fadd dword [edx]
        fstp dword [esp]
        fld dword [byte ebx+04h]
        fsub dword [byte edx+04h]
        fmul dword [byte esp+018h]
        fadd dword [byte edx+04h]
        fstp dword [byte esp+04h]
        fld dword [byte ebx+08h]
        fsub dword [byte edx+08h]
        fmul dword [byte esp+018h]
        fadd dword [byte edx+08h]
        fstp dword [byte esp+08h]
        fld dword [byte ebx+010h]
        fsub dword [byte edx+010h]
        fst dword [byte esp+028h]
        fst qword [byte esp+020h]
        fcomp qword [F64_3p14159_OpeningCameraStep]
        fnstsw ax
        sahf
        jbe short .2
        fld qword [byte esp+020h]
        fadd qword [F64_neg6p28319_OpeningCameraStep]
        jmp short .3
.2:
        fld qword [byte esp+020h]
        fcomp qword [F64_neg3p14159_OpeningCameraStep]
        fnstsw ax
        sahf
        jae short .4
        fld qword [byte esp+020h]
        fadd qword [F64_6p28319_OpeningCameraStep]
.3:
        fstp dword [byte esp+028h]
.4:
        fld dword [byte esp+028h]
        fld dword [byte ebx+0Ch]
        fsub dword [byte edx+0Ch]
        fxch
        fld dword [byte esp+018h]
        fxch
        fmul st1
        fxch st2
        fmul st1
        fld dword [byte ebx+014h]
        fsub dword [byte edx+014h]
        fxch st3
        fadd dword [byte edx+010h]
        fxch st3
        fmulp st2
        fxch st2
        fstp dword [byte esp+0Ch]
        fxch
        fadd dword [byte edx+0Ch]
        fxch
        fadd dword [byte edx+014h]
        fxch
        fstp dword [byte esp+010h]
        fstp dword [byte esp+014h]
        jmp short .6
.5:
        mov edi, esp
        mov esi, edx
        movsd
        movsd
        movsd
        mov eax, dword [byte edx+0Ch]
        mov dword [byte esp+010h], eax
        mov eax, dword [byte edx+010h]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte edx+014h]
        mov dword [byte esp+014h], eax
.6:
        mov esi, esp
        mov ebx, 4
        mov edx, esp
        xor ecx, ecx
        mov edi, CameraLookAt
        mov dword [CameraViewX], ecx
        xor eax, eax
        movsd
        movsd
        movsd
        call SnapCamera
        push ecx
        push dword [byte esp+010h]
        push dword [byte esp+018h]
        call SetCameraPathPoint
        push byte 4
        mov eax, dword [byte esp+018h]
        mov edx, 6
        push eax
        mov dword [CameraFollowObj], eax
        xor eax, eax
        mov dword [CameraFocus], ecx
        call UpdateCameraMotion
.7:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadOpeningCamera                               1BEA4  97 PC, low confidence
; From OpeningSequence: loads the opening camera path intro%d.3cp from
; arena.viv
;-----------------------------------------------------------------------------
LoadOpeningCamera:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov edx, 8
        mov eax, CameraPathPoints
        call SetCameraView
        mov edx, 8
        mov eax, 1
        mov dword [CameraPathActive], edx
        call LoadOpeningArt
        push byte 1
        push str_IntroD3cp
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, str_ArenaViv
        call SetArtArchive
        push byte 20h
        lea eax, [byte esp+04h]
        push eax
        call LoadResourceDataShared
        add esp, byte 8
        mov dword [OpeningCamFrame], eax
        xor eax, eax
        mov ebx, 1
        call SetArtArchive
        mov edx, dword [OpeningCamFrame]
        mov edi, OpeningCameraStep
        lea eax, [byte edx+04h]
        mov ebp, ebx
        mov dword [OpeningCamFrames], eax
        xor ecx, ecx
        mov eax, dword [edx]
        mov edx, dword [OpeningCamFrames]
        mov dword [OpeningCamData], eax
        mov dword [OpeningCamActive], ebx
        mov dword [CameraSceneArg], ecx
        mov dword [CameraSceneStep], ecx
        mov dword [CameraSceneFunc], edi
        mov dword [ActiveCameraScene], ebx
        mov dword [CameraViewX], ecx
        mov edi, CameraLookAt
        mov esi, edx
        mov ebx, 4
        xor eax, eax
        movsd
        movsd
        movsd
        call SnapCamera
        mov edx, dword [OpeningCamFrames]
        push ecx
        push dword [byte edx+010h]
        push dword [byte edx+0Ch]
        call SetCameraPathPoint
        mov eax, dword [OpeningCamFrames]
        mov ebx, ebp
        push byte 4
        mov eax, dword [byte eax+014h]
        mov edx, 6
        push eax
        mov dword [CameraFollowObj], eax
        xor eax, eax
        mov dword [CameraFocus], ecx
        call UpdateCameraMotion
        mov dword [CameraScenesEnabled], ebx
        call DrawClockOverlay
        mov dword [CameraSceneId], ebx
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FightSceneStep                                  1BFC0  97 PC, low confidence
; Camera step of the fight scene: circles the fighters
;-----------------------------------------------------------------------------
FightSceneStep:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov eax, dword [CameraSceneStep]
        cmp eax, byte 1
        jb short .1
        jbe near .2
        cmp eax, byte 2
        je near .3
        jmp near .4
.1:
        test eax, eax
        jne near .4
        cmp word [FightCameraReady], byte 0
        je near .4
        mov edx, 64h
        mov edi, CameraSceneCenter
        mov dword [CameraSceneArg], eax
        inc eax
        mov esi, CameraPos
        mov dword [CameraSceneStep], eax
        mov eax, 12h
        movsd
        movsd
        movsd
        call StartCameraPath
        push dword 190h
        push byte 0
        mov edi, 457A0000h
        push dword 0C4FF0000h
        xor esi, esi
        call SetCameraFocus
        push byte 0
        mov edx, 1F4h
        push dword 457A0000h
        mov eax, 1
        mov dword [CameraViewY], esi
        mov dword [CameraHeight], edi
        call SetCameraTarget
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        cmp dword [CameraSceneArg], 1F4h
        jl near .4
        mov edi, 43FA0000h
        mov eax, 44FF0000h
        mov edx, 190h
        xor ebp, ebp
        mov dword [CameraSceneYaw], edi
        mov dword [CameraSceneCenter], eax
        mov eax, 12h
        mov dword [CameraSceneDist], ebp
        call StartCameraPath
        mov ebx, dword [CameraSceneStep]
        inc ebx
        mov dword [CameraSceneArg], ebp
        mov dword [CameraSceneStep], ebx
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        cmp dword [CameraSceneArg], 0C8h
        jl short .4
        push dword 1F4h
        push byte 0
        mov ecx, 43FA0000h
        push dword 44070000h
        mov edx, 1F4h
        call SetCameraFocus
        push byte 0
        xor ebx, ebx
        push dword 43FA0000h
        mov eax, 1
        mov dword [CameraViewY], ebx
        mov dword [CameraHeight], ecx
        call SetCameraTarget
.4:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FightCameraScene                                1C108  97 PC, low confidence
; From StartFight: scripted camera scene, priority 2 (follows the two
; fighters, FightSceneStep per frame)
;-----------------------------------------------------------------------------
FightCameraScene:
        push ebx
        push ecx
        push esi
        push ebp
        mov ecx, eax
        mov ebx, edx
        mov eax, 2
        call CanStartCameraScene
        test eax, eax
        je near .6
        mov edx, 8
        mov eax, CameraPathPoints
        mov ebp, FightSceneStep
        call SetCameraView
        add ecx, byte 4
        add ebx, byte 4
        xor esi, esi
        mov edx, 8
        mov eax, 1
        mov dword [CameraSceneArg], esi
        mov dword [CameraSceneStep], esi
        mov dword [CameraSceneFunc], ebp
        mov dword [FightSceneTimer], ecx
        mov dword [CameraPathActive], edx
        xor edx, edx
        mov dword [FightSceneState], ebx
        mov word [FightCameraReady], dx
        mov edx, dword [CameraPos]
        mov dword [ActiveCameraScene], eax
        cmp edx, 44C08000h
        jg short .1
        cmp dword [CameraHeading], 45866000h
        jle short .2
.1:
        mov byte [FightSceneActive], 1
        jmp short .3
.2:
        xor ah, ah
        mov byte [FightSceneActive], ah
.3:
        cmp byte [FightSceneActive], 0
        jne short .4
        push dword 1F4h
        mov edx, dword [FightSceneState]
        push dword 0BFC90FDBh
        jmp short .5
.4:
        push dword 1F4h
        mov edx, dword [FightSceneState]
        push dword 0C096CBE4h
.5:
        mov eax, dword [FightSceneTimer]
        push dword 447A0000h
        call FightCameraStart
        push byte 0
        mov esi, 43960000h
        push dword 43960000h
        mov edx, 1F4h
        xor ecx, ecx
        mov eax, 1
        mov dword [CameraViewY], ecx
        mov dword [CameraHeight], esi
        call SetCameraTarget
.6:
        pop ebp
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetFightCameraReady                             1C210  97 PC, low confidence
; Marks the fight camera as in place
;-----------------------------------------------------------------------------
SetFightCameraReady:
        mov word [FightCameraReady], 1
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SceneReturnToView                               1C21C  97 PC, low confidence
; Moves the camera from a scene back to the normal game view
;-----------------------------------------------------------------------------
SceneReturnToView:
        push ebx
        push edx
        cmp dword [CameraSceneArg], byte 64h
        jle short .1
        mov eax, dword [SceneSavedView]
        xor edx, edx
        mov ebx, 64h
        call SelectCameraView
        mov edx, 10000h
        mov eax, 0FFFFFFFFh
        call FadeGamePalette
        xor ebx, ebx
        mov dword [ActiveCameraScene], ebx
.1:
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        push esi
        mov ecx, eax
        mov ebx, 64h
        mov eax, 0FFFFFFFFh
        xor edx, edx
        mov esi, 1
        call FadeGamePalette
        mov dword [SceneSavedView], ecx
        mov dword [ActiveCameraScene], esi
        xor edx, edx
        mov ecx, SceneReturnToView
        mov dword [CameraSceneArg], edx
        mov dword [CameraSceneStep], edx
        mov dword [CameraSceneFunc], ecx
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FaceoffCameraScene                              1C29C  97 PC, low confidence
; From puckfaceoff: scripted camera scene, priority 7 (path 18h)
;-----------------------------------------------------------------------------
FaceoffCameraScene:
        push ebx
        push edx
        mov eax, 7
        call CanStartCameraScene
        test eax, eax
        je short .1
        cmp byte [GoalSceneActive], 0
        jne short .1
        mov edx, 8
        mov eax, CameraPathPoints
        call SetCameraView
        mov edx, 8
        mov eax, 18h
        mov dword [CameraPathActive], edx
        mov edx, 0C8h
        mov ebx, 1
        call StartCameraPath
        mov dword [CameraSceneId], ebx
.1:
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FaceoffSceneStep                                1C2EC  97 PC, low confidence
; Camera step of the faceoff scene
;-----------------------------------------------------------------------------
FaceoffSceneStep:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp dword [CameraSceneArg], 258h
        jl short .1
        push byte 0
        mov ebx, 0Ah
        mov ecx, 447A0000h
        mov esi, 0C0490FDBh
        mov edi, 0BC3EA2F2h
        mov eax, 442F0000h
        push dword 442F0000h
        mov edx, 190h
        xor ebp, ebp
        mov dword [CameraViewX], ebx
        mov dword [CameraPathTime], ecx
        mov dword [CameraPathVec], esi
        mov dword [CameraViewPair], edi
        mov dword [CameraHeight], eax
        mov eax, 1
        mov dword [CameraViewY], ebp
        call SetCameraTarget
        mov dword [ActiveCameraScene], ebp
.1:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FaceoffCloseupScene                             1C360  97 PC, low confidence
; Starts the close-up camera on the faceoff circle
;-----------------------------------------------------------------------------
FaceoffCloseupScene:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 2Ch
        lea edi, [byte esp+024h]
        mov esi, FaceoffCloseupInit
        mov ecx, FaceoffSceneStep
        mov eax, 9
        movsd
        movsd
        xor edx, edx
        mov esi, 1
        lea edi, [byte esp+018h]
        mov dword [CameraSceneArg], edx
        mov dword [CameraSceneStep], edx
        mov dword [CameraSceneFunc], ecx
        mov dword [ActiveCameraScene], esi
        call GetCameraTarget
        mov esi, eax
        movsd
        movsd
        movsd
        fld dword [CameraZoom]
        mov esi, 9
        fcomp dword [F32_neg1000_FaceoffCloseupScene]
        fnstsw ax
        sahf
        jbe near .2
        fldz
        fcomp dword [byte esp+020h]
        fnstsw ax
        sahf
        jbe short .1
        mov eax, 0Fh
        lea edi, [byte esp+018h]
        call GetCameraTarget
        mov esi, eax
        movsd
        movsd
        movsd
        mov esi, 0Fh
.1:
        fld dword [byte esp+018h]
        fld dword [byte esp+020h]
        fld st0
        mov edx, 44BB8000h
        mov eax, dword [byte esp+018h]
        mov ebx, 447A0000h
        xor ecx, ecx
        mov dword [byte esp+04h], edx
        mov dword [byte esp+0Ch], eax
        mov dword [byte esp+010h], ebx
        mov dword [TargetPointObj], ecx
        fxch st2
        fadd dword [F32_neg1000_FaceoffCloseupScene]
        fxch
        fadd dword [F32_neg1500]
        fxch st2
        fadd dword [F32_neg1000_FaceoffCloseupScene]
        fxch st2
        fstp dword [byte esp+08h]
        fxch
        fstp dword [byte esp+014h]
        fstp dword [esp]
        jmp short .4
.2:
        fldz
        fcomp dword [byte esp+020h]
        fnstsw ax
        sahf
        jae short .3
        mov eax, 0Fh
        lea edi, [byte esp+018h]
        call GetCameraTarget
        mov esi, eax
        movsd
        movsd
        movsd
        mov esi, 0Fh
.3:
        fld dword [byte esp+018h]
        fld dword [byte esp+020h]
        fld st0
        mov edi, 44BB8000h
        mov eax, dword [byte esp+018h]
        mov ebp, 447A0000h
        mov dword [byte esp+04h], edi
        mov dword [byte esp+0Ch], eax
        mov dword [byte esp+010h], ebp
        fxch st2
        fadd dword [F32_neg1000_FaceoffCloseupScene]
        fxch
        fadd dword [F32_1500]
        fxch st2
        fadd dword [F32_1000]
        fxch st2
        fstp dword [byte esp+08h]
        fxch
        fstp dword [byte esp+014h]
        mov eax, 40490FDBh
        fstp dword [esp]
        mov dword [TargetPointObj], eax
.4:
        lea ebx, [byte esp+024h]
        mov edx, esp
        mov eax, 2
        xor ecx, ecx
        call SetCameraSpline
        mov eax, esi
        mov edi, CameraSceneCenter
        call GetCameraTarget
        mov esi, eax
        mov edx, 0C8h
        mov eax, 12h
        movsd
        movsd
        movsd
        call StartCameraPath
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FaceoffSweepStep                                1C4F4  97 PC, low confidence
; Camera step of the sweep down to the faceoff circle
;-----------------------------------------------------------------------------
FaceoffSweepStep:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        mov eax, dword [CameraSceneStep]
        cmp eax, byte 1
        jb short .1
        jbe near .2
        cmp eax, byte 2
        je near .3
        jmp near .4
.1:
        test eax, eax
        jne near .4
        cmp dword [CameraSceneArg], byte 64h
        jl near .4
        mov esi, 0C5188000h
        mov edi, 43480000h
        mov ebp, 0C5A28000h
        mov eax, 45188000h
        mov edx, 459C4000h
        mov ebx, 45A28000h
        mov ecx, 8
        mov dword [byte esp+0Ch], esi
        mov dword [byte esp+010h], edi
        mov dword [byte esp+014h], ebp
        mov dword [esp], eax
        mov dword [byte esp+04h], edx
        mov edx, 8
        mov eax, CameraPathPoints
        mov esi, 1
        mov edi, 447A0000h
        call SetCameraView
        xor ebp, ebp
        mov eax, 10h
        mov dword [CameraPathActive], ecx
        mov dword [CameraViewX], esi
        xor edx, edx
        mov dword [CameraPathTime], edi
        call StartCameraPath
        mov eax, 442F0000h
        push byte 4
        mov edi, CameraEye
        mov edx, esi
        push dword 442F0000h
        mov dword [CameraHeight], eax
        xor eax, eax
        mov dword [CameraViewY], ebp
        call UpdateCameraMotion
        mov dword [CameraViewY], esi
        lea esi, [byte esp+0Ch]
        mov dword [byte esp+08h], ebx
        movsd
        movsd
        movsd
        mov ebx, 64h
        mov esi, esp
        mov edi, CameraCenter
        mov edx, 10000h
        mov eax, 0FFFFFFFFh
        movsd
        movsd
        movsd
        call FadeGamePalette
        mov ecx, dword [CameraSceneStep]
        inc ecx
        mov dword [CameraSceneArg], ebp
        mov dword [CameraSceneStep], ecx
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        cmp dword [CameraSceneArg], byte 64h
        jl near .4
        push byte 0
        mov eax, 451C4000h
        push dword 451C4000h
        mov edx, 7D0h
        xor ebp, ebp
        mov dword [CameraHeight], eax
        mov eax, 1
        mov dword [CameraViewY], ebp
        call SetCameraTarget
        mov ebx, dword [CameraSceneStep]
        inc ebx
        mov dword [CameraSceneArg], ebp
        mov dword [CameraSceneStep], ebx
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        cmp dword [CameraSceneArg], 258h
        jl short .4
        push dword 7D0h
        push dword [CameraHeading]
        mov ecx, 458CA000h
        push dword [CameraPos]
        mov edx, 7D0h
        call SetCameraFocus
        push byte 0
        xor ebx, ebx
        push dword 458CA000h
        mov eax, 1
        mov dword [CameraViewY], ebx
        mov dword [CameraHeight], ecx
        call SetCameraTarget
        mov dword [ActiveCameraScene], ebx
.4:
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ecx, FaceoffSweepStep
        mov esi, 1
        mov edi, 0BF490FDBh
        mov ebx, 32h
        xor edx, edx
        mov eax, 0FFFFFFFFh
        mov dword [CameraSceneArg], edx
        mov dword [CameraSceneStep], edx
        mov dword [CameraSceneFunc], ecx
        mov dword [ActiveCameraScene], esi
        mov dword [SceneStepCount], edi
        call FadeGamePalette
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FaceoffSweepScene                               1C70C  97 PC, low confidence
; Starts the camera sweep down to the faceoff circle
;-----------------------------------------------------------------------------
FaceoffSweepScene:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 28h
        fldz
        lea edi, [byte esp+018h]
        mov edx, 453E0000h
        mov ebx, 458CA000h
        mov esi, FaceoffSweepInit
        xor ecx, ecx
        mov dword [esp], edx
        mov dword [byte esp+04h], ebx
        movsd
        movsd
        mov dword [byte esp+08h], ecx
        fcomp dword [CameraZoom]
        fnstsw ax
        sahf
        jbe short .1
        mov ebx, 45960000h
        mov dword [byte esp+0Ch], edx
        mov edx, 45BB8000h
        mov dword [byte esp+014h], ebx
        mov dword [byte esp+010h], edx
        jmp short .2
.1:
        mov edi, 45BB8000h
        mov ebp, 0C5960000h
        mov dword [byte esp+0Ch], edx
        mov dword [byte esp+010h], edi
        mov dword [byte esp+014h], ebp
.2:
        mov ecx, 17h
        mov esi, 18h
        mov ebx, 12Ch
        lea edx, [byte esp+020h]
        mov eax, 2
        mov dword [byte esp+020h], ecx
        mov dword [byte esp+024h], esi
        call SetCameraPathPoints
        lea ebx, [byte esp+018h]
        mov edx, esp
        mov eax, 2
        xor ecx, ecx
        call SetCameraSpline
        add esp, byte 28h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FaceoffCameraScene2                             1C7B4  97 PC, low confidence
; From puckfaceoff: scripted camera scene, priority 7, one of two random
; camera moves
;-----------------------------------------------------------------------------
FaceoffCameraScene2:
        push ebx
        push ecx
        push edx
        mov eax, 7
        call CanStartCameraScene
        test eax, eax
        je near .5
        mov dword [CameraScenesEnabled], 1
        call DrawClockOverlay
        call rand_
        mov edx, eax
        mov ebx, 2
        sar edx, 1Fh
        idiv ebx
        cmp dword [CameraZoom], 44FA0000h
        jge short .3
        fld dword [CameraZoom]
        fcomp dword [F32_neg2000_FaceoffCameraScene2]
        fnstsw ax
        sahf
        jbe short .3
        test edx, edx
        jbe short .1
        cmp edx, byte 1
        je short .2
        jmp short .4
.1:
        call FaceoffCloseupScene
        jmp short .4
.2:
        mov eax, FaceoffSweepStep
        mov ecx, 0BF490FDBh
        mov ebx, 32h
        call SetCameraSceneFunc
        xor edx, edx
        mov eax, 0FFFFFFFFh
        mov dword [SceneStepCount], ecx
        call FadeGamePalette
        jmp short .4
.3:
        call FaceoffSweepScene
.4:
        mov dword [CameraSceneId], 1
.5:
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; MenuCameraScene                                 1C854  97 PC, low confidence
; Starts the camera scene shown behind the in-game menus
;-----------------------------------------------------------------------------
MenuCameraScene:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edx, 8
        mov eax, CameraPathPoints
        mov ecx, 3F060A92h
        mov edi, CameraLookAt
        mov esi, MenuCamPos
        call SetCameraView
        xor ebx, ebx
        mov edx, 8
        push byte 4
        mov dword [CameraFocus], ebx
        xor eax, eax
        push dword 3F060A92h
        mov dword [CameraPathActive], edx
        mov edx, 6
        mov dword [CameraFollowObj], ecx
        call UpdateCameraMotion
        mov edx, MenuCamPos
        mov dword [CameraViewX], ebx
        xor eax, eax
        mov ebx, 4
        movsd
        movsd
        movsd
        call SnapCamera
        mov edi, CameraSceneCenter
        mov esi, MenuCamTarget
        mov eax, 12h
        xor edx, edx
        movsd
        movsd
        movsd
        call StartCameraPath
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; MenuOrbitStep                                   1C8DC  97 PC, low confidence
; Camera step of the slow orbit behind the in-game menus
;-----------------------------------------------------------------------------
MenuOrbitStep:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov eax, dword [MenuOrbitAngle]
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        cmp eax, dword [CameraSceneArg]
        jg near .6
        mov ebx, 4541C000h
        fld dword [CameraZoom]
        mov dword [byte esp+04h], ebx
        fcomp dword [F32_neg400]
        fnstsw ax
        sahf
        jae short .1
        mov esi, 0C4AF0000h
        mov ecx, 43C80000h
        mov dword [byte esp+08h], esi
        mov dword [esp], ecx
        jmp short .4
.1:
        cmp dword [CameraZoom], 43C80000h
        jle short .2
        mov ebx, 44AF0000h
        mov edx, 43C80000h
        mov dword [byte esp+08h], ebx
        mov dword [esp], edx
        jmp short .4
.2:
        fldz
        fcomp dword [CameraElevation]
        fnstsw ax
        sahf
        jbe short .3
        mov eax, 0C3C80000h
        mov ebp, 0C4AF0000h
        mov dword [byte esp+08h], eax
        mov dword [esp], ebp
        jmp short .4
.3:
        mov edi, 0C3C80000h
        mov esi, 44AF0000h
        mov dword [byte esp+08h], edi
        mov dword [esp], esi
.4:
        mov esi, esp
        mov edi, MenuCamPos
        mov eax, 11h
        movsd
        movsd
        movsd
        call GetCameraTarget
        mov esi, eax
        mov eax, dword [MenuOrbitAngle]
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov edi, MenuCamTarget
        movsd
        movsd
        movsd
        xor edi, edi
        mov esi, esp
        mov dword [CameraViewX], edi
        mov edi, CameraLookAt
        movsd
        movsd
        movsd
        mov dword [byte esp+0Ch], eax
        test eax, eax
        jle short .5
        lea ebx, [byte esp+0Ch]
        mov edx, esp
        mov eax, 1
        xor ecx, ecx
        call SetCameraSpline
        jmp short .6
.5:
        mov ebx, 4
        mov edx, esp
        xor eax, eax
        call SnapCamera
.6:
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; MenuOrbitScene                                  1C9F0  97 PC, low confidence
; Starts the slow orbit behind the in-game menus
;-----------------------------------------------------------------------------
MenuOrbitScene:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, 3F060A92h
        push byte 4
        xor edx, edx
        xor eax, eax
        push dword 3F060A92h
        mov dword [CameraFocus], edx
        mov edx, 6
        mov dword [CameraFollowObj], ecx
        call UpdateCameraMotion
        test ebx, ebx
        je near .1
        mov edi, MenuOrbitStep
        mov ebp, 1
        mov edx, 8
        mov eax, CameraPathPoints
        xor ecx, ecx
        mov dword [MenuOrbitAngle], ebx
        mov dword [CameraSceneArg], ecx
        mov dword [CameraSceneStep], ecx
        mov dword [CameraSceneFunc], edi
        mov dword [ActiveCameraScene], ebp
        call SetCameraView
        mov eax, 8
        mov edx, ebx
        mov dword [CameraPathActive], eax
        mov eax, 11h
        shl edx, 2
        call GetCameraTarget
        sub edx, ebx
        mov esi, eax
        mov eax, edx
        sar edx, 1Fh
        shl edx, 2
        LD sbb, eax, edx
        sar eax, 2
        mov edi, CameraSceneCenter
        movsd
        movsd
        movsd
        fld dword [CameraSceneYaw]
        fld dword [CameraSceneCenter]
        fadd dword [F32_neg200]
        fxch
        fadd dword [F32_neg300]
        fxch
        fstp dword [CameraSceneCenter]
        mov edx, eax
        mov eax, 12h
        fstp dword [CameraSceneYaw]
        call StartCameraPath
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov edx, 8
        mov eax, CameraPathPoints
        mov esi, 8
        mov edi, 43FA0000h
        mov ebp, 4541C000h
        mov ebx, 4
        call SetCameraView
        mov eax, 0C47A0000h
        mov dword [CameraPathActive], esi
        mov dword [esp], edi
        mov dword [byte esp+04h], ebp
        xor edx, edx
        mov esi, esp
        mov edi, CameraLookAt
        mov dword [byte esp+08h], eax
        mov dword [CameraViewX], edx
        mov edx, esp
        xor eax, eax
        movsd
        movsd
        movsd
        call SnapCamera
        mov eax, 11h
        mov edi, CameraSceneCenter
        call GetCameraTarget
        mov esi, eax
        mov ebx, 447A0000h
        xor edx, edx
        movsd
        movsd
        movsd
        mov eax, 12h
        fld dword [CameraSceneCenter]
        fld dword [CameraSceneYaw]
        mov esi, esp
        mov edi, MenuCamPos
        mov dword [CameraSceneDist], ebx
        fxch
        fadd dword [F32_neg1000_MenuOrbitScene]
        fxch
        fadd dword [F32_neg700_MenuOrbitScene]
        fxch
        fstp dword [CameraSceneCenter]
        fstp dword [CameraSceneYaw]
        call StartCameraPath
        movsd
        movsd
        movsd
        mov edi, MenuCamTarget
        mov esi, CameraSceneCenter
        movsd
        movsd
        movsd
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PenShotSceneStep                                1CB9C  97 PC, low confidence
; Camera step of the penalty shot scene: follows the shooter in on the goalie
;-----------------------------------------------------------------------------
PenShotSceneStep:
        push ebx
        push ecx
        push edx
        cmp dword [CameraSceneArg], 1F4h
        jl short .1
        push byte 0
        mov ecx, 447A0000h
        push dword 447A0000h
        mov edx, 258h
        xor ebx, ebx
        mov eax, 1
        mov dword [CameraViewY], ebx
        mov dword [CameraHeight], ecx
        call SetCameraTarget
.1:
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PenaltyShotCameraScene                          1CBD8  97 PC, low confidence
; From assrefpenshot: scripted camera scene, priority 3 (penshottimer)
;-----------------------------------------------------------------------------
PenaltyShotCameraScene:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ebx, eax
        mov eax, 3
        call CanStartCameraScene
        test eax, eax
        je near .2
        mov edi, PenShotSceneStep
        mov ebp, 1
        mov eax, dword [penshottimer]
        mov dword [PenShotSceneTimer], ebx
        add edx, byte 4
        xor ecx, ecx
        sar eax, 10h
        mov dword [CameraSceneArg], ecx
        mov dword [CameraSceneStep], ecx
        mov dword [CameraSceneFunc], edi
        mov dword [ActiveCameraScene], ebp
        add ebx, byte 2
        mov dword [byte esp+04h], edx
        mov dword [PenShotSceneState], eax
        mov dword [esp], ebx
        call ResetSceneCamera
        push dword 190h
        lea edx, [byte esp+04h]
        push dword 442F0000h
        mov ebx, 258h
        call SetCameraHeight
        mov eax, 2
        call SetCameraPathPoints
        test eax, eax
        je short .1
        mov edx, 3FA00000h
        mov eax, 9
        mov dword [CameraPathVec], ecx
        mov dword [CameraPathTime], edx
        mov dword [CameraViewX], eax
.1:
        push byte 0
        mov esi, 451C4000h
        push dword 451C4000h
        mov edx, 190h
        mov eax, 1
        xor ecx, ecx
        mov edi, 1
        mov dword [CameraViewY], ecx
        mov dword [CameraHeight], esi
        call SetCameraTarget
        mov dword [CameraSceneId], edi
.2:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; EndPenShotScene                                 1CCBC  97 PC, low confidence
; Ends the penalty shot camera scene
;-----------------------------------------------------------------------------
EndPenShotScene:
        push ebx
        push edx
        mov eax, dword [PenShotSceneTimer]
        add eax, byte 2
        mov dword [FightSceneTimer], eax
        mov eax, dword [PenShotSceneState]
        mov ebx, 12Ch
        add eax, byte 4
        mov edx, FightSceneTimer
        mov dword [FightSceneState], eax
        mov eax, 2
        call SetCameraPathPoints
        xor edx, edx
        mov dword [ActiveCameraScene], edx
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; GoalSceneStep                                   1CCF8  97 PC, low confidence
; Camera step of the goal scene: follows the scorer's celebration
;-----------------------------------------------------------------------------
GoalSceneStep:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 18h
        lea edi, [byte esp+0Ch]
        mov esi, GoalSceneCamFrom
        movsd
        movsd
        movsd
        mov edi, esp
        mov esi, GoalSceneCamTo
        movsd
        movsd
        movsd
        cmp dword [CameraSceneArg], 2BCh
        jl short .1
        push byte 0
        mov ecx, 451C4000h
        push dword 451C4000h
        mov edx, 5DCh
        mov eax, 1
        mov esi, 1
        xor ebx, ebx
        mov edi, CameraEye
        mov dword [CameraViewY], ebx
        mov dword [CameraHeight], ecx
        call SetCameraTarget
        mov dword [CameraViewY], esi
        lea esi, [byte esp+0Ch]
        movsd
        movsd
        movsd
        mov esi, esp
        mov edi, CameraCenter
        xor ah, ah
        movsd
        movsd
        movsd
        mov byte [GoalSceneActive], ah
.1:
        add esp, byte 18h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; GoalCameraScene                                 1CD80  97 PC, low confidence
; From Goal: scripted camera scene, priority 5 (GoalSceneStep per frame)
;-----------------------------------------------------------------------------
GoalCameraScene:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 20h
        mov ebx, eax
        lea edi, [byte esp+0Ch]
        mov esi, GoalCameraFrom
        movsd
        movsd
        movsd
        mov edi, esp
        mov esi, GoalCameraTo
        mov eax, 5
        movsd
        movsd
        movsd
        call CanStartCameraScene
        test eax, eax
        je near .3
        mov edi, GoalSceneStep
        mov ebp, 1
        mov ah, 1
        xor ecx, ecx
        add ebx, byte 4
        mov dword [CameraSceneArg], ecx
        mov dword [CameraSceneStep], ecx
        mov dword [CameraSceneFunc], edi
        mov dword [ActiveCameraScene], ebp
        mov cl, byte [gmode]
        mov byte [GoalSceneActive], ah
        test cl, 2
        je short .1
        test edx, edx
        sete al
        xor edx, edx
        mov dl, al
.1:
        test edx, edx
        sete al
        and eax, 0FFh
        lea ecx, [byte eax+02h]
        mov edx, 8
        mov eax, CameraPathPoints
        call SetCameraView
        mov eax, 8
        mov dword [byte esp+018h], ecx
        mov dword [byte esp+01Ch], ebx
        mov dword [CameraPathActive], eax
        call ResetSceneCamera
        push dword 190h
        lea edx, [byte esp+01Ch]
        push dword 442F0000h
        mov ebx, 12Ch
        call SetCameraHeight
        mov eax, 2
        call SetCameraPathPoints
        test eax, eax
        je short .2
        mov ebx, 3F99999Ah
        mov edx, 9
        xor ecx, ecx
        mov dword [CameraPathTime], ebx
        mov dword [CameraPathVec], ecx
        mov dword [CameraViewX], edx
.2:
        mov esi, 1
        mov edi, CameraEye
        mov dword [CameraViewY], esi
        lea esi, [byte esp+0Ch]
        movsd
        movsd
        movsd
        mov esi, esp
        mov edi, CameraCenter
        movsd
        movsd
        movsd
.3:
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FaceoffDropSceneStep                            1CE98  97 PC, low confidence
; Camera step while the referee drops the puck
;-----------------------------------------------------------------------------
FaceoffDropSceneStep:
        push ebx
        push edx
        push edi
        push ebp
        mov eax, dword [CameraSceneStep]
        cmp eax, byte 1
        jb short .1
        jbe near .2
        cmp eax, byte 2
        je near .5
        pop ebp
        pop edi
        pop edx
        pop ebx
        ret
.1:
        test eax, eax
        jne near .6
        cmp dword [CameraSceneArg], 96h
        jl near .6
        mov dword [CameraSceneArg], eax
        inc eax
        mov edx, 8
        mov dword [CameraSceneStep], eax
        mov eax, CameraPathPoints
        mov ebp, 8
        call SetCameraView
        mov eax, 1
        xor edx, edx
        mov dword [CameraPathActive], ebp
        call StartCameraPath
        mov eax, dword [SavedCameraView]
        xor edx, edx
        sar eax, 10h
        call SelectCameraView
        mov eax, 1
        xor edx, edx
        call StartCameraPath
        xor eax, eax
        mov dword [CameraScenesEnabled], eax
        pop ebp
        pop edi
        pop edx
        pop ebx
        ret
.2:
        cmp dword [CameraSceneArg], byte 1Eh
        jl near .6
        cmp dword [CameraPathActive], byte 4
        jge short .3
        push byte 4
        mov edx, 3E800000h
        xor eax, eax
        push dword 3E800000h
        mov dword [CameraFollowObj], edx
        mov edx, 6
        mov dword [CameraFocus], eax
        jmp short .4
.3:
        mov ebp, 3F000000h
        push byte 4
        mov edx, 6
        xor edi, edi
        xor eax, eax
        push dword 3F000000h
        mov dword [CameraFocus], edi
        mov dword [CameraFollowObj], ebp
.4:
        call UpdateCameraMotion
        mov edx, 8
        mov eax, CameraPathPoints
        mov ebx, 8
        call SetCameraView
        mov edx, 10000h
        mov eax, 0FFFFFFFFh
        mov dword [CameraPathActive], ebx
        mov ebx, 64h
        call FadeGamePalette
        inc dword [CameraSceneStep]
        pop ebp
        pop edi
        pop edx
        pop ebx
        ret
.5:
        cmp byte [FaceoffDropScene], 0
        je short .6
        mov eax, 1
        xor edx, edx
        call StartCameraPath
        mov eax, dword [SavedCameraView]
        mov edx, 12Ch
        sar eax, 10h
        call SelectCameraView
        mov edx, 0FFFFFFFFh
        xor ebx, ebx
        mov dword [CameraSceneId], edx
        xor dl, dl
        mov dword [ActiveCameraScene], ebx
        mov byte [FaceoffDropScene], dl
.6:
        pop ebp
        pop edi
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FaceoffDropCameraScene                          1D008  97 PC, low confidence
; From puckfaceoff2: scripted camera scene, priority 1 (FaceoffDropSceneStep per frame)
;-----------------------------------------------------------------------------
FaceoffDropCameraScene:
        push ebx
        push edx
        push esi
        push edi
        mov eax, 1
        call CanStartCameraScene
        test eax, eax
        je near .3
        xor ah, ah
        mov edx, 8
        mov byte [IntermissionActive], ah
        mov byte [FaceoffDropScene], ah
        mov eax, CameraPathPoints
        call SetCameraView
        mov dword [CameraPathActive], 8
        cmp byte [CameraScenesOn], 0
        je short .1
        mov eax, dword [gameopts]
        test byte [byte eax+02h], 20h
        jne short .2
.1:
        mov ebx, 32h
        mov eax, 0FFFFFFFFh
        xor edx, edx
        call FadeGamePalette
.2:
        mov esi, FaceoffDropSceneStep
        xor bh, bh
        mov edi, 1
        mov byte [CameraScenesOn], bh
        mov dword [CameraSceneFunc], esi
        xor ebx, ebx
        mov dword [ActiveCameraScene], edi
        mov dword [CameraSceneArg], ebx
        mov dword [CameraSceneStep], ebx
.3:
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; RestoreGameCamera                               1D09C  97 PC, low confidence
; Restores the camera view saved before a scene
;-----------------------------------------------------------------------------
RestoreGameCamera:
        push edx
        mov eax, 1
        xor edx, edx
        call StartCameraPath
        mov eax, dword [SavedCameraView]
        xor edx, edx
        sar eax, 10h
        call SelectCameraView
        pop edx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PenaltyCallSceneStep                            1D0BC  97 PC, low confidence
; Camera step while the referee signals a penalty
;-----------------------------------------------------------------------------
PenaltyCallSceneStep:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 10h
        mov edi, esp
        mov esi, CameraPos
        movsd
        movsd
        movsd
        cmp dword [CameraSceneArg], 0C8h
        jl near .3
        fld dword [CameraZoom]
        fcomp dword [byte esp+08h]
        fnstsw ax
        sahf
        jbe short .1
        fld dword [byte esp+08h]
        fadd dword [F32_750]
        jmp short .2
.1:
        fld dword [byte esp+08h]
        fadd dword [F32_neg750]
.2:
        fstp dword [byte esp+08h]
        mov ebx, 12Ch
        mov esi, esp
        mov edx, esp
        mov eax, 1
        mov edi, CameraLookAt
        xor ecx, ecx
        mov dword [byte esp+0Ch], ebx
        mov dword [CameraViewX], ecx
        lea ebx, [byte esp+0Ch]
        movsd
        movsd
        movsd
        call SetCameraSpline
        push byte 0
        mov edi, 43FA0000h
        push dword 43FA0000h
        mov edx, 190h
        xor esi, esi
        mov eax, 1
        mov dword [CameraViewY], esi
        mov dword [CameraHeight], edi
        call SetCameraTarget
        mov dword [ActiveCameraScene], esi
.3:
        add esp, byte 10h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PenaltyCallCameraScene                          1D16C  97 PC, low confidence
; Starts the camera scene of a penalty call
;-----------------------------------------------------------------------------
PenaltyCallCameraScene:
        push ebx
        push edx
        push esi
        push edi
        push ebp
        mov ebx, eax
        mov eax, 4
        call CanStartCameraScene
        test eax, eax
        je short .1
        mov esi, PenaltyCallSceneStep
        mov edi, 1
        mov eax, CameraPathPoints
        xor edx, edx
        mov ebp, 8
        mov dword [CameraSceneArg], edx
        mov dword [CameraSceneStep], edx
        mov dword [CameraSceneFunc], esi
        mov edx, 8
        mov dword [ActiveCameraScene], edi
        call SetCameraView
        mov edx, 0C8h
        lea eax, [byte ebx+04h]
        mov dword [CameraPathActive], ebp
        call StartCameraPath
.1:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetFaceoffEndFlag                               1D1D4  97 PC, low confidence
; Sets the flag that ends the faceoff camera scene
;-----------------------------------------------------------------------------
SetFaceoffEndFlag:
        mov byte [FaceoffDropScene], 1
        ret
