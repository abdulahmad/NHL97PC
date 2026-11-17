; Game view: model names, game graphics and video, drawing the game frame.
bits 32
%include "hockey.inc"
section s_4B49E progbits alloc exec nowrite align=1
extern __STOSB, AddDisplayView, AddPaletteRange, ArenaArchive, ArenaArt, BuildGamePalette, BuildReciprocalTable, CameraStateRecords
extern DebugTagStr, DrawCameraDebug, DrawCameraDebugMarks, DrawFarSide, DrawFrameNoop, DrawIceMarkers, DrawNearSide, DrawNetsHook
extern DrawPlayerNames, DrawPlayersSorted, DrawPuckArrow, DrawRinkOverlay, DrawRinkPass, DrawScoreboard, DrawTextAt, F32_neg2040
extern F32_neg4264, FlashTimer, FloatsToInts, FrameBuffer, FrameDrawList, FrameObjectCount, FreeCameraDebug, FreeDisplayViews
extern FreeGameModels, FreeRinkModel, GameGraphicsFlags, GameGraphicsMode, GameGraphicsReady, GameVideoMode, HideView, IdentityRemap
extern InitCamera, InitDisplayViews, InitPaletteManager, InitRinkProjection, InitRinkView, LoadAiIcons, LoadGameModels, LoadGoalieMask
extern LoadRinkLines, LoadRinkModel, MatchColor, ModelCount, ModelList, ModelNameCount, ModelNamePtrs, ModelNames
extern NoOpDraw, ObjectPositions, OpenArenaArchive, PresentGameView, ProjectCoordInt, ProjectionCenter, QuantizeAllRanges, Random32
extern RenderTicks, RenderTimer, RenderTimersOn, RinkLineArt, RunCameraScene, SaveViewOrigin, ScaleFloatsToInts, ScaleModelLods
extern SelectCameraView, SelectFont, ServiceIdle, SetModelExtraFlags, SetRinkPalette, SetRinkTransform, SetScreenScale, SetTextColors
extern SetupTeamModels, SetVideoMode, SetViewDrawTarget, SetViewInterlaced, SetViewOrigin, SetViewScale, SetViewSize, ShowLoadingBar
extern ShutdownPaletteManager, SortIndices, StartCameraPath, str_Frntend, str_Ice, str_JBUG, str_Marks, str_Player
extern str_Puck, str_Punct_DrawRinkSurface, str_Render, strncpy_, TextureCount, UpdateBenchCheer, UpdateCrowdReaction, UpdateGoalLight
extern UpdateViewDistance, UpdateViewMatrix, ViewDistanceTable, ViewScreenHeight, ViewScreenWidth, WritePaletteRegs
global GameGfxInitVector, NoOpPlatformHook, RefreshViewDistance, AddModelName, FindModelName, InitGameGraphics, InitGameVideo, ResetRenderTimersJumpTable
global ResetRenderTimers, ResetRenderTimers_27, ResetRenderTimers_33, ResetRenderTimers_3D, ResetRenderTimers_47, FreeGameGraphics, DrawModelList, DrawGameFrame
global RedrawGameView, ScoreboardZeroVector, str_Light
        db 00h,00h
GameGfxInitVector:                              ; used by InitGameGraphics
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0FAh,044h
;-----------------------------------------------------------------------------
; NoOpPlatformHook                                4B4AC  97 PC, low confidence
; Does nothing (empty platform hook)
;-----------------------------------------------------------------------------
NoOpPlatformHook:
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RefreshViewDistance                             4B4B0  97 PC, low confidence
; Refreshes the camera view distance
;-----------------------------------------------------------------------------
RefreshViewDistance:
        push esi
        push edi
        mov edi, ViewDistanceTable
        mov esi, eax
        movsd
        movsd
        movsd
        call UpdateViewDistance
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; AddModelName                                    4B4C4  97 PC, low confidence
; Adds a model name to the model name table
;-----------------------------------------------------------------------------
AddModelName:
        push esi
        push edi
        sub esp, byte 4
        mov edi, edx
        mov dword [esp], ebx
        mov esi, ecx
        mov edx, dword [ModelList]
        lea ecx, [nosplit edx*8+00h]
        add ecx, edx
        shl ecx, 2
        mov ebx, edx
        add ecx, ModelNames
        inc ebx
        mov dword [nosplit edx*4+ModelNamePtrs], ecx
        mov edx, dword [ModelNameCount]
        mov dword [ModelList], ebx
        lea ebx, [byte edx+01h]
        mov dword [ModelNameCount], ebx
        mov ebx, 8
        mov dword [byte ecx+08h], edx
        mov edx, eax
        mov eax, ecx
        call strncpy_
        mov dword [byte ecx+01Ch], esi
        mov eax, dword [esp]
        mov dword [byte ecx+014h], edi
        mov dword [byte ecx+018h], eax
        mov eax, dword [byte esp+010h]
        mov dword [byte ecx+0Ch], eax
        mov eax, dword [byte esp+014h]
        mov dword [byte ecx+020h], eax
        mov eax, dword [byte ecx+08h]
        add esp, byte 4
        pop edi
        pop esi
        ret 8
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FindModelName                                   4B540  97 PC, low confidence
; Finds a model in the model name table
;-----------------------------------------------------------------------------
FindModelName:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebx, eax
        mov eax, ModelNames
        mov ecx, dword [ModelList]
        xor edx, edx
        test ecx, ecx
        jle short .6
        mov esi, dword [ModelList]
.1:
        cmp ebx, dword [byte eax+08h]
        je short .3
        jmp short .5
.2:
        mov ecx, 9
        mov edi, eax
        lea esi, [byte eax+024h]
        inc edx
        add eax, byte 24h
        rep movsd
.3:
        mov ebx, dword [ModelList]
        dec ebx
        cmp edx, ebx
        jl short .2
        mov ebp, dword [ModelList]
        dec ebp
        mov dword [ModelList], ebp
        test ebp, ebp
        jle short .6
        mov edx, ModelNames
        lea ebx, [nosplit ebp*4+00h]
        xor eax, eax
.4:
        mov dword [dword eax+ModelNamePtrs], edx
        add eax, byte 4
        add edx, byte 24h
        cmp eax, ebx
        jge short .6
        jmp short .4
.5:
        inc edx
        add eax, byte 24h
        cmp edx, esi
        jl short .1
.6:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; InitGameGraphics                                4B5C4  97 PC, low confidence
; From PlayGame, LoadReplay and ReturnToGame: loads the arena, rink, players'
; art and camera for a game
;-----------------------------------------------------------------------------
InitGameGraphics:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov ebp, eax
        mov dword [GameVideoMode], eax
        call BuildReciprocalTable
        push dword 42C80000h
        call SetViewScale
        push byte 64h
        call SetScreenScale
        add esp, byte 4
        mov eax, dword [byte ebp+028h]
        xor edx, edx
        mov ebx, 0E7h
        call InitDisplayViews
        call ServiceIdle
        xor edx, edx
        mov eax, 3Ch
        mov dword [ModelList], edx
        call ShowLoadingBar
        call ServiceIdle
        call InitPaletteManager
        mov eax, str_Render
        call AddPaletteRange
        mov ebx, 0EFh
        mov edx, 0E8h
        mov dword [ArenaArchive], eax
        mov eax, str_Ice
        call AddPaletteRange
        mov ebx, 0F8h
        mov edx, 0F0h
        mov dword [ArenaArt], eax
        mov eax, str_Marks
        call AddPaletteRange
        mov ebx, 0FEh
        mov edx, 0F9h
        mov dword [RinkLineArt], eax
        mov eax, str_Frntend
        call AddPaletteRange
        mov dword [GameGraphicsReady], eax
        mov eax, 41h
        call ShowLoadingBar
        mov edx, dword [byte ebp+03Ch]
        mov eax, dword [byte ebp+038h]
        call LoadRinkModel
        mov eax, 0FFFFFFFFh
        call OpenArenaArchive
        mov eax, 46h
        call ShowLoadingBar
        call ServiceIdle
        push dword 0FF000000h
        call MatchColor
        add esp, byte 4
        mov al, byte [dword eax+IdentityRemap]
        and eax, 0FFh
        push eax
        push byte 0FFFFFFFFh
        call MatchColor
        add esp, byte 4
        mov al, byte [dword eax+IdentityRemap]
        and eax, 0FFh
        push eax
        call SetTextColors
        add esp, byte 8
        call SaveViewOrigin
        mov ebx, dword [byte ebp+034h]
        mov edx, dword [byte ebp+030h]
        mov eax, dword [byte ebp+02Ch]
        call LoadGameModels
        mov eax, 4Bh
        call ShowLoadingBar
        call ServiceIdle
        mov edx, dword [ModelCount]
        xor eax, eax
        call LoadGoalieMask
        call ServiceIdle
        mov eax, 50h
        call ShowLoadingBar
        mov eax, 1
        mov edx, dword [TextureCount]
        call LoadGoalieMask
        mov ebx, dword [byte ebp+02Ch]
        xor edi, edi
        test ebx, ebx
        jle short .2
        mov esi, ObjectPositions
.1:
        mov ecx, DrawPlayersSorted
        push esi
        mov ebx, UpdateViewMatrix
        mov eax, str_Player
        push byte 1
        mov edx, esi
        inc edi
        call AddModelName
        mov ecx, dword [byte ebp+02Ch]
        add esi, 760h
        cmp edi, ecx
        jl short .1
.2:
        mov edi, esp
        mov esi, GameGfxInitVector
        mov edx, esp
        mov eax, esp
        movsd
        movsd
        movsd
        call UpdateViewDistance
        mov esi, dword [GameGraphicsFlags]
        push esi
        mov ecx, InitRinkView
        mov ebx, InitRinkProjection
        push byte 2
        mov edx, ProjectionCenter
        mov eax, str_Puck
        call AddModelName
        mov eax, 55h
        call ShowLoadingBar
        call ServiceIdle
        call QuantizeAllRanges
        mov eax, 0FFh
        call BuildGamePalette
        call SetupTeamModels
        call LoadRinkLines
        mov eax, 5Ah
        xor edx, edx
        call ShowLoadingBar
        call LoadAiIcons
        call InitCamera
        mov eax, 19h
        call StartCameraPath
        xor edx, edx
        xor eax, eax
        call SelectCameraView
        call ServiceIdle
        mov eax, 5Fh
        mov edi, 0FFFFFFFFh
        call ShowLoadingBar
        mov dword [GameGraphicsMode], edi
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; InitGameVideo                                   4B80C  97 PC, low confidence
; From PlayGame, LoadReplay: sets the game video mode (SetVideoMode) and the
; view window
;-----------------------------------------------------------------------------
InitGameVideo:
        push ebx
        push ecx
        push edx
        sub esp, 300h
        mov eax, dword [GameVideoMode]
        mov edx, dword [byte eax+04h]
        mov eax, dword [eax]
        mov ecx, 300h
        call SetVideoMode
        mov eax, esp
        xor edx, edx
        call __STOSB
        mov eax, esp
        push eax
        push dword 100h
        push byte 0
        call WritePaletteRegs
        mov eax, dword [GameVideoMode]
        xor ebx, ebx
        add esp, byte 0Ch
        mov edx, dword [byte eax+0Ch]
        mov eax, dword [byte eax+08h]
        call AddDisplayView
        mov edx, dword [GameVideoMode]
        mov dword [FrameBuffer], eax
        mov ebx, dword [byte edx+01Ch]
        mov edx, dword [byte edx+018h]
        call SetViewSize
        mov edx, dword [GameVideoMode]
        mov eax, dword [FrameBuffer]
        mov ebx, dword [byte edx+014h]
        mov edx, dword [byte edx+010h]
        call SetViewOrigin
        mov eax, dword [GameVideoMode]
        cmp dword [byte eax+020h], byte 0
        je short .1
        mov eax, dword [FrameBuffer]
        call SetViewInterlaced
.1:
        mov eax, dword [GameVideoMode]
        cmp dword [byte eax+024h], byte 0
        je short .2
        mov eax, dword [FrameBuffer]
        call HideView
.2:
        mov edx, dword [GameVideoMode]
        mov eax, dword [FrameBuffer]
        mov ebx, dword [byte edx+01Ch]
        mov edx, dword [byte edx+018h]
        call SetViewSize
        add esp, 300h
        pop edx
        pop ecx
        pop ebx
        ret
ResetRenderTimersJumpTable:                     ; jump table for the switch cases of ResetRenderTimers
        dd ResetRenderTimers_27
        dd ResetRenderTimers_47
        dd ResetRenderTimers_3D
        dd ResetRenderTimers_33
;-----------------------------------------------------------------------------
; ResetRenderTimers                               4B8DC  97 PC, low confidence
; Resets the render timers after a cut (faceoff, replay, stoppage)
;-----------------------------------------------------------------------------
ResetRenderTimers:
        push edx
        xor edx, edx
        mov dword [RenderTicks], eax
        mov dword [RenderTimersOn], edx
        mov dword [RenderTimer], edx
        mov dword [FlashTimer], edx
        cmp eax, byte 3
        ja short ResetRenderTimers_47
        jmp dword [nosplit cs:eax*4+ResetRenderTimersJumpTable]
ResetRenderTimers_27:
        mov dword [RenderTimersOn], 1
        pop edx
        ret
ResetRenderTimers_33:
        mov dword [FlashTimer], 1
ResetRenderTimers_3D:
        mov dword [RenderTimer], 1
ResetRenderTimers_47:
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FreeGameGraphics                                4B928  97 PC, low confidence
; From PlayGame, LoadReplay, ReplayScreen: frees what InitGameGraphics loaded
; (FreeRinkModel ...)
;-----------------------------------------------------------------------------
FreeGameGraphics:
        call FreeRinkModel
        call FreeGameModels
        call ShutdownPaletteManager
        call FreeDisplayViews
        jmp near FreeCameraDebug
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawModelList                                   4B944  97 PC, low confidence
; Draws every model in the model list
;-----------------------------------------------------------------------------
DrawModelList:
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov edi, eax
        mov dword [byte esp+04h], edx
        mov dword [byte esp+08h], ebx
        mov dword [esp], ecx
        mov edx, dword [ModelList]
        xor esi, esi
        test edx, edx
        jle short .5
        xor ecx, ecx
.1:
        mov ebx, dword [dword ecx+ModelNamePtrs]
        mov ebp, dword [byte ebx+014h]
        test ebp, ebp
        je short .2
        fild dword [byte esp+04h]
        mov edx, ebp
        fcomp dword [byte ebp+00h]
        fnstsw ax
        sahf
        jae short .4
        fild dword [byte esp+08h]
        fcomp dword [byte ebp+00h]
        fnstsw ax
        sahf
        jb short .4
        fild dword [esp]
        fcomp dword [byte ebp+08h]
        fnstsw ax
        sahf
        jae short .4
        fild dword [byte esp+01Ch]
        fcomp dword [byte ebp+08h]
        fnstsw ax
        sahf
        jb short .4
        jmp short .3
.2:
        test edi, edi
        je short .4
.3:
        mov eax, dword [byte ebx+020h]
        call dword [byte ebx+01Ch]
.4:
        mov ebx, dword [ModelList]
        inc esi
        add ecx, byte 4
        cmp esi, ebx
        jl short .1
.5:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        mov edx, dword [ModelList]
        xor ebx, ebx
        test edx, edx
        jle short .8
        xor edx, edx
.6:
        mov eax, dword [dword edx+ModelNamePtrs]
        cmp dword [byte eax+0Ch], byte 1
        jne short .7
        mov eax, dword [byte eax+020h]
        call SetModelExtraFlags
.7:
        mov ecx, dword [ModelList]
        inc ebx
        add edx, byte 4
        cmp ebx, ecx
        jl short .6
.8:
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawGameFrame                                   4BA00  97 PC, low confidence
; Draws one frame of the game view (rink, objects, overlays); from Gameloop,
; the pause menu, RunIntermission, RunOpeningFrames and the replay
;-----------------------------------------------------------------------------
DrawGameFrame:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        mov edx, dword [GameGraphicsMode]
        test edx, edx
        jge short .1
        mov eax, 1
        jmp short .2
.1:
        sub eax, edx
.2:
        mov ecx, dword [FrameObjectCount]
        mov dword [GameGraphicsMode], esi
        test ecx, ecx
        jne short .3
        call RunCameraScene
.3:
        mov eax, dword [FrameBuffer]
        call SetViewDrawTarget
        cmp dword [RenderTimer], byte 0
        je short .4
        push DebugTagStr
        call SelectFont
        add esp, byte 4
        push byte 0
        call Random32
        push eax
        call MatchColor
        add esp, byte 4
        push eax
        call SetTextColors
        mov eax, dword [ViewScreenHeight]
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        push eax
        mov eax, dword [ViewScreenWidth]
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        push eax
        push str_JBUG
        call DrawTextAt
        add esp, byte 0Ch
.4:
        call SaveViewOrigin
        mov ebx, esp
        mov edx, CameraStateRecords+253h
        mov eax, 9
        call ScaleFloatsToInts
        lea ebx, [byte esp+024h]
        mov edx, CameraStateRecords+7
        mov eax, 3
        call FloatsToInts
        mov edx, esp
        lea eax, [byte esp+024h]
        call SetRinkTransform
        mov eax, esi
        call UpdateBenchCheer
        mov eax, esi
        call UpdateCrowdReaction
        mov eax, esi
        call UpdateGoalLight
        mov eax, esi
        call DrawScoreboard
        call DrawRinkOverlay
        call ScaleModelLods
        mov ebp, dword [ModelList]
        xor ebx, ebx
        test ebp, ebp
        jle short .6
        xor edx, edx
.5:
        mov ecx, dword [dword edx+ModelNamePtrs]
        mov eax, dword [byte ecx+020h]
        inc ebx
        call dword [byte ecx+018h]
        mov dword [dword edx+FrameDrawList], eax
        mov eax, dword [ModelList]
        add edx, byte 4
        cmp ebx, eax
        jl short .5
.6:
        push ModelNamePtrs
        push FrameDrawList
        mov edx, dword [ModelList]
        push edx
        call SortIndices
        add esp, byte 0Ch
        call DrawRinkPass
        call SetRinkPalette
        call DrawNetsHook
        call NoOpDraw
        xor edx, edx
.7:
        cmp dword [dword edx+ObjectPositions], 44FF0000h
        jge short .8
        fld dword [dword edx+ObjectPositions]
        fcomp dword [F32_neg2040]
        fnstsw ax
        sahf
        jbe short .8
        mov eax, ObjectPositions
        add eax, edx
        call DrawIceMarkers
.8:
        add edx, 760h
        cmp edx, 5FE0h
        jne short .7
        call DrawNearSide
        call DrawFrameNoop
        call DrawCameraDebug
        call DrawCameraDebugMarks
        fld dword [CameraStateRecords+0Fh]
        fcomp dword [F32_neg4264]
        fnstsw ax
        sahf
        jae short .9
        push dword 12C0h
        mov ecx, 0FFFFEF58h
        mov ebx, 7F8h
        mov edx, 0FFFFF808h
        mov eax, 1
        call DrawModelList
        push dword 0FFFFEF58h
        mov ecx, 0FFFFED40h
        jmp near .11
.9:
        cmp dword [CameraStateRecords+0Fh], 45854000h
        jle short .10
        push dword 10A8h
        mov ecx, 0FFFFED40h
        mov ebx, 7F8h
        mov edx, 0FFFFF808h
        mov eax, 1
        call DrawModelList
        push dword 12C0h
        mov ecx, 10A8h
        jmp short .11
.10:
        push dword 0FFFFEF58h
        mov ecx, 0FFFFED40h
        mov ebx, 7F8h
        mov edx, 0FFFFF808h
        mov eax, 1
        call DrawModelList
        push dword 12C0h
        mov ecx, 10A8h
        mov ebx, 7F8h
        mov edx, 0FFFFF808h
        mov eax, 1
        call DrawModelList
        push dword 10A8h
        mov ecx, 0FFFFEF58h
.11:
        mov ebx, 7F8h
        mov edx, 0FFFFF808h
        mov eax, 1
        call DrawModelList
        call DrawFarSide
        call DrawPlayerNames
        xor edx, edx
.12:
        cmp dword [dword edx+ObjectPositions], 44FF0000h
        jge short .13
        fld dword [dword edx+ObjectPositions]
        fcomp dword [F32_neg2040]
        fnstsw ax
        sahf
        jbe short .13
        mov eax, ObjectPositions
        add eax, edx
        call DrawPuckArrow
.13:
        add edx, 760h
        cmp edx, 5FE0h
        jne short .12
        add esp, byte 30h
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RedrawGameView                                  4BCB4  97 PC, low confidence
; Redraws the game view at the current camera
;-----------------------------------------------------------------------------
RedrawGameView:
        jmp near PresentGameView
        db 00h,00h,00h,00h,00h,00h,00h
ScoreboardZeroVector:                           ; used by DrawScoreboard
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
str_Light:                                      ; string "light"; used by LoadOpeningArt
        db 06Ch,069h,067h,068h,074h,00h,00h,00h
        push ebx
        sub esp, byte 4
        mov dword [esp], edx
        mov ebx, dword [str_Punct_DrawRinkSurface]
        cmp ebx, dword [byte eax+08h]
        jl short .1
        xor eax, eax
        add esp, byte 4
        pop ebx
        ret
.1:
        fild dword [esp]
        sub esp, byte 4
        fstp dword [esp]
        sub esp, byte 4
        fild dword [byte eax+08h]
        fstp dword [esp]
        call ProjectCoordInt
        add esp, byte 4
        pop ebx
        ret
