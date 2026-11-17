; Game overlays: view size, video mode keys, scoreboard, clock, penalty and message panels.
bits 32
%include "hockey.inc"
section s_15AC2 progbits alloc exec nowrite align=1
extern __CHP, AddOverlayWindow, AwayPanelValue, AwaySkaters, AwPlayerFlags, AwPlayersInBox, AwScore, awtmstruct
extern CameraViewNames, ClearScreen, ClearViewInterlaced, ClockFontLarge, ClockFontSmall, ClockPanelFunc, ClockShown, ClockShownMinutes
extern ClockShownSeconds, CreateBitmap, DisplayFlags, DrawArt, DrawGlyph_494, DrawGlyphFn, DrawShapeScaledBy, DrawTextAligned
extern DrawTextAt, DrawTextBoxedAt, F32_0p5, F32_65536, FillPolygon, FillRect, FillRectColor, FillRectCorners
extern FreeBitmap, gameclock, GetLangText, GetLowestPen, GoalScorerPanelBlank, gsp, HideView, HmPlayerFlags
extern HmPlayersInBox, HmScore, hmtmstruct, HomeSkaters, InjuryPanelBlank, MatchColor, MeasureText, MessagePanel
extern MessagePanelIds, NextVideoMode, OverlayPanelFuncs, OverlayPanelQueue, PanelArtLarge, PanelArtSmall, PanelNameBuf, PenaltyNameIds
extern PenaltyPanelBlank, PenaltyPanelIds, PenaltyShotPanelBlank, PeriodAwayTeam, PeriodHomeTeam, PeriodPanelBlank, PrevVideoMode, rand_
extern RefreshOverlayWindow, RemoveOverlayWindow, ReplayPlaying, ScorePanelAway, ScorePanelHome, ScorePanelValues, ScreenWidth, SelectFont
extern SetDrawTarget, SetTextColor, SetTextColors, SetVideoMode, SetViewInterlaced, SetViewOrigin, SetViewSize, ShowView
extern SortCords, SpecialTeamsPanelBlank, sprintf_, StatsPanelOn, StatsPanelPlayer, str_2d01d, str_2d02d, str_CloseParen
extern str_CommaSpace, str_D_ChangeViewSize, str_Doubled, str_DSS, str_DXD, str_Interlaced, str_Normal, str_Punct
extern str_Punct_DrawGoalScorerPanel, str_S_DrawPenaltyPanel, str_SD, str_SD2, str_SDCS, str_SDSS, str_SDSS2, str_SS
extern str_SSD, str_SSDD, str_SSS, strcat_, strcpy_, TeamLineSlots, TextAlign, TextColor
extern TextColorTable, VideoModeChanged, VideoModePanelMode, VideoModeSel, ViewScreenHeight, ViewScreenWidth, ViewSizeIndex, ViewWindowH
extern ViewWindowW, ViewWindowX, ViewWindowY
global ChangeViewSize, SetViewWindow, PrevVideoModeKey, PrevVideoModeKey_20A, PrevVideoModeKey_20E, PrevVideoModeKey_216, PrevVideoModeKey_217, NextVideoModeKey
global ApplyDisplayFlags, RemoveOverlayPanel, DrawPanelArtScaled, DrawPanelPlayerCard, GetPlayerNumber, GetPlayerPanelName, GetPlayerName, TeamNameField
global DrawMessagePanel, DrawMessagePanel_15D, DrawMessagePanel_15F, DrawVideoModePanel, DrawPenaltyPanel, DrawPenaltyPanel_26F, DrawPenaltyShotPanel, DrawSpecialTeamsPanel
global DrawPenaltyShotPanel_48E, DrawPenaltyShotPanel_49A, DrawPenaltyShotPanel_4D7, DrawInjuryPanel, DrawPeriodPanel, DrawGoalScorerPanel, DrawGameClock, DrawPowerPlayClock
global DrawPowerPlayClock_18E, DrawClockPanel, PowerPlayPanel, UpdateScoreboardPanel, HomeTeamPanel, AwayTeamPanel, HomeStatPanel, AwayStatPanel
global QueueOverlayPanel, OpenFreeOverlay, ClearOverlayWindows, RefreshOverlayWindows, ChkShowStatsPanel, ChkPowerPlayPanel, SetOverlayFont, DrawGameOverlays
global IsOverlayShown, FaceoffCloseupInit, FaceoffSweepInit, GoalSceneCamFrom, GoalSceneCamTo, GoalCameraFrom, GoalCameraTo
;-----------------------------------------------------------------------------
; ChangeViewSize                               15AC2  97 PC, medium confidence
; (+1 / -1): the game view size in steps of 10 between 28h and 64h percent
; (str_D_ChangeViewSize), then the view window
;-----------------------------------------------------------------------------
ChangeViewSize:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 4, 0
        cmp ax, 1
        jne short .1
        add word [str_D_ChangeViewSize], byte 0Ah
        cmp word [str_D_ChangeViewSize], byte 64h
        jle short .2
        mov word [str_D_ChangeViewSize], 64h
        jmp near PrevVideoModeKey_216
.1:
        cwde
        cmp eax, byte 0FFFFFFFFh
        jne short .2
        sub word [str_D_ChangeViewSize], byte 0Ah
        cmp word [str_D_ChangeViewSize], byte 28h
        jge short .2
        mov word [str_D_ChangeViewSize], 28h
        jmp near PrevVideoModeKey_216
.2:
        mov eax, dword [ViewScreenWidth]
        movsx ebx, word [str_D_ChangeViewSize]
        imul eax, ebx
        mov ecx, 64h
        cdq
        idiv ecx
        mov ecx, eax
        mov eax, dword [ViewScreenHeight]
        imul eax, ebx
        mov ebx, 64h
        cdq
        idiv ebx
        mov ebx, eax
        mov eax, dword [ViewSizeIndex]
        test byte [byte eax+04h], 2
        je short .3
        sar ebx, 1
.3:
        mov eax, dword [ViewScreenWidth]
        cdq
        LD sub, eax, edx
        sar eax, 1
        mov edi, eax
        mov eax, ecx
        cdq
        LD sub, eax, edx
        sar eax, 1
        sub edi, eax
        mov eax, dword [ViewSizeIndex]
        mov dword [byte ebp-04h], eax
        mov eax, dword [ViewScreenHeight]
        cdq
        LD sub, eax, edx
        sar eax, 1
        mov esi, eax
        mov eax, dword [byte ebp-04h]
        test byte [byte eax+04h], 2
        je short .4
        sub esi, ebx
        jmp short .5
.4:
        mov eax, ebx
        cdq
        LD sub, eax, edx
        sar eax, 1
        sub esi, eax
.5:
        mov eax, dword [ViewSizeIndex]
        mov dword [ViewWindowW], ecx
        mov dword [ViewWindowH], ebx
        mov dword [ViewWindowX], edi
        mov edx, ecx
        mov dword [ViewWindowY], esi
        call SetViewSize
        mov eax, dword [ViewSizeIndex]
        mov ebx, esi
        mov edx, edi
        call SetViewOrigin
        jmp near PrevVideoModeKey_216
;-----------------------------------------------------------------------------
; SetViewWindow                                   15BC5  97 PC, low confidence
; The game view window from the view size and the screen size (ViewScreenWidth x
; ViewScreenHeight)
;-----------------------------------------------------------------------------
SetViewWindow:
        push ebx
        push ecx
        push edx
        imul eax, dword [ViewScreenHeight], byte 2Dh
        mov ebx, 0C8h
        cdq
        idiv ebx
        mov ebx, dword [ViewScreenHeight]
        sub ebx, eax
        mov eax, dword [ViewSizeIndex]
        mov ecx, dword [ViewScreenWidth]
        test byte [byte eax+04h], 2
        je short .1
        sar ebx, 1
.1:
        mov dword [ViewWindowX], 0
        mov dword [ViewWindowY], 0
        mov eax, dword [ViewSizeIndex]
        mov dword [ViewWindowW], ecx
        mov edx, ecx
        mov dword [ViewWindowH], ebx
        call SetViewSize
        mov eax, dword [ViewSizeIndex]
        xor ebx, ebx
        xor edx, edx
        call SetViewOrigin
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrevVideoModeKey                                15C30  97 PC, low confidence
; From GameFunctionKeys (F11 range): clears the overlays, PrevVideoMode,
; SetVideoMode and rebuilds the overlay windows
;-----------------------------------------------------------------------------
PrevVideoModeKey:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 18h, 0
        cmp dword [VideoModeChanged], byte 0
        jne near .9
        cmp dword [DisplayFlags], byte 0
        jne near .9
        call ClearOverlayWindows
        lea eax, [byte ebp-018h]
        call PrevVideoMode
        mov edx, dword [byte ebp-014h]
        mov eax, dword [byte ebp-018h]
        call SetVideoMode
        mov eax, dword [byte ebp-018h]
        mov dword [VideoModePanelMode], eax
        mov eax, dword [byte ebp-014h]
        mov dword [VideoModeSel], eax
        cmp eax, 100h
        jl short .1
        mov eax, dword [ViewSizeIndex]
        call SetViewInterlaced
        mov dword [VideoModeChanged], 1
        jmp short .2
.1:
        mov eax, dword [ViewSizeIndex]
        call ClearViewInterlaced
        mov dword [VideoModeChanged], 0
.2:
        mov eax, dword [ViewSizeIndex]
        call ShowView
        movsx ebx, word [str_D_ChangeViewSize]
        mov eax, dword [ViewScreenWidth]
        imul eax, ebx
        mov ecx, 64h
        cdq
        idiv ecx
        mov ecx, eax
        mov eax, dword [ViewScreenHeight]
        imul eax, ebx
        mov ebx, 64h
        cdq
        idiv ebx
        mov ebx, eax
        mov eax, dword [ViewSizeIndex]
        mov dword [DisplayFlags], 0
        test byte [byte eax+04h], 2
        je short .3
        sar ebx, 1
.3:
        mov eax, dword [ViewScreenWidth]
        cdq
        LD sub, eax, edx
        sar eax, 1
        mov edi, eax
        mov eax, ecx
        cdq
        LD sub, eax, edx
        sar eax, 1
        sub edi, eax
        mov eax, dword [ViewSizeIndex]
        mov dword [byte ebp-04h], eax
        mov eax, dword [ViewScreenHeight]
        cdq
        LD sub, eax, edx
        sar eax, 1
        mov esi, eax
        mov eax, dword [byte ebp-04h]
        test byte [byte eax+04h], 2
        je short .4
        sub esi, ebx
        jmp short .5
.4:
        mov eax, ebx
        cdq
        LD sub, eax, edx
        sar eax, 1
        sub esi, eax
.5:
        mov eax, dword [ViewSizeIndex]
        mov dword [ViewWindowW], ecx
        mov dword [ViewWindowH], ebx
        mov dword [ViewWindowX], edi
        mov edx, ecx
        mov dword [ViewWindowY], esi
        call SetViewSize
        mov eax, dword [ViewSizeIndex]
        mov ebx, esi
        mov edx, edi
        call SetViewOrigin
        cmp dword [ViewScreenHeight], 12Ch
        jge short .6
        push dword [ClockFontSmall]
        jmp short .7
.6:
        push dword [ClockFontLarge]
.7:
        call SelectFont
        add esp, byte 4
        test byte [HmPlayerFlags], 2
        je short .8
        movsx eax, word [AwaySkaters]
        push eax
        push byte 0
        push byte 9
        call QueueOverlayPanel
        mov dword [ScorePanelHome], 0FFFFFFFFh
        add esp, byte 0Ch
.8:
        test byte [AwPlayerFlags], 2
        je near PrevVideoModeKey_20A
        movsx eax, word [HomeSkaters]
        push eax
        push byte 0
        push byte 0Ah
        call QueueOverlayPanel
        mov dword [ScorePanelAway], 0FFFFFFFFh
        add esp, byte 0Ch
        jmp short PrevVideoModeKey_20A
.9:
        cmp dword [DisplayFlags], byte 0
        je short .10
        mov eax, dword [ViewSizeIndex]
        mov dword [VideoModeChanged], 0
        call ClearViewInterlaced
        mov eax, dword [ViewSizeIndex]
        mov dword [DisplayFlags], 0
        call ShowView
        jmp short PrevVideoModeKey_20A
.10:
        mov eax, dword [ViewSizeIndex]
        mov dword [VideoModeChanged], 1
        call SetViewInterlaced
        mov eax, dword [ViewSizeIndex]
        mov dword [DisplayFlags], 1
        call HideView
PrevVideoModeKey_20A:
        push byte 50h
        push byte 2
PrevVideoModeKey_20E:
        call QueueOverlayPanel
        add esp, byte 8
PrevVideoModeKey_216:
        leave
PrevVideoModeKey_217:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; NextVideoModeKey                                15E4D  97 PC, low confidence
; From GameFunctionKeys (F12): clears the overlays, NextVideoMode,
; SetVideoMode and rebuilds the overlay windows
;-----------------------------------------------------------------------------
NextVideoModeKey:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 18h, 0
        cmp dword [VideoModeChanged], byte 0
        je short .1
        cmp dword [DisplayFlags], byte 0
        je short .2
.1:
        cmp dword [VideoModeSel], 100h
        jge near .9
.2:
        call ClearOverlayWindows
        lea eax, [byte ebp-018h]
        call NextVideoMode
        mov edx, dword [byte ebp-014h]
        mov eax, dword [byte ebp-018h]
        call SetVideoMode
        mov eax, dword [byte ebp-018h]
        mov dword [VideoModePanelMode], eax
        mov eax, dword [byte ebp-014h]
        mov dword [VideoModeSel], eax
        mov eax, dword [ViewSizeIndex]
        call ClearViewInterlaced
        mov eax, dword [ViewSizeIndex]
        mov dword [VideoModeChanged], 0
        call ShowView
        movsx ebx, word [str_D_ChangeViewSize]
        mov eax, dword [ViewScreenWidth]
        imul eax, ebx
        mov ecx, 64h
        cdq
        idiv ecx
        mov ecx, eax
        mov eax, dword [ViewScreenHeight]
        imul eax, ebx
        mov ebx, 64h
        cdq
        idiv ebx
        mov ebx, eax
        mov eax, dword [ViewSizeIndex]
        mov dword [DisplayFlags], 0
        test byte [byte eax+04h], 2
        je short .3
        sar ebx, 1
.3:
        mov eax, dword [ViewScreenWidth]
        cdq
        LD sub, eax, edx
        sar eax, 1
        mov esi, eax
        mov eax, ecx
        cdq
        LD sub, eax, edx
        sar eax, 1
        sub esi, eax
        mov eax, dword [ViewScreenHeight]
        cdq
        LD sub, eax, edx
        sar eax, 1
        mov edi, dword [ViewSizeIndex]
        mov dword [byte ebp-04h], esi
        mov esi, eax
        test byte [byte edi+04h], 2
        je short .4
        sub esi, ebx
        jmp short .5
.4:
        mov eax, ebx
        cdq
        LD sub, eax, edx
        sar eax, 1
        sub esi, eax
.5:
        mov eax, dword [byte ebp-04h]
        mov dword [ViewWindowW], ecx
        mov dword [ViewWindowH], ebx
        mov edx, ecx
        mov dword [ViewWindowX], eax
        mov eax, dword [ViewSizeIndex]
        mov dword [ViewWindowY], esi
        call SetViewSize
        mov edx, dword [byte ebp-04h]
        mov eax, dword [ViewSizeIndex]
        mov ebx, esi
        call SetViewOrigin
        cmp dword [ViewScreenHeight], 12Ch
        jge short .6
        push dword [ClockFontSmall]
        jmp short .7
.6:
        push dword [ClockFontLarge]
.7:
        call SelectFont
        add esp, byte 4
        test byte [HmPlayerFlags], 2
        je short .8
        movsx eax, word [AwaySkaters]
        push eax
        push byte 0
        push byte 9
        call QueueOverlayPanel
        mov dword [ScorePanelHome], 0FFFFFFFFh
        add esp, byte 0Ch
.8:
        test byte [AwPlayerFlags], 2
        je near PrevVideoModeKey_20A
        movsx eax, word [HomeSkaters]
        push eax
        push byte 0
        push byte 0Ah
        call QueueOverlayPanel
        mov dword [ScorePanelAway], 0FFFFFFFFh
        add esp, byte 0Ch
        jmp near PrevVideoModeKey_20A
.9:
        cmp dword [DisplayFlags], byte 0
        je short .10
        mov eax, dword [ViewSizeIndex]
        call ShowView
        mov dword [DisplayFlags], 0
        jmp near PrevVideoModeKey_20A
.10:
        mov eax, dword [ViewSizeIndex]
        call HideView
        mov eax, dword [ViewSizeIndex]
        mov dword [DisplayFlags], 1
        call SetViewInterlaced
        mov dword [VideoModeChanged], 1
        jmp near PrevVideoModeKey_20A
;-----------------------------------------------------------------------------
; ApplyDisplayFlags                               1603A  97 PC, low confidence
; Sets the doubled / interlaced display flags (VideoModeChanged, DisplayFlags) in
; the screen record
;-----------------------------------------------------------------------------
ApplyDisplayFlags:
        cmp dword [VideoModeChanged], byte 0
        je short .1
        mov eax, dword [ViewSizeIndex]
        call SetViewInterlaced
        jmp short .2
.1:
        mov eax, dword [ViewSizeIndex]
        call ClearViewInterlaced
.2:
        cmp dword [DisplayFlags], byte 0
        je short .3
        mov eax, dword [ViewSizeIndex]
        jmp near HideView
.3:
        mov eax, dword [ViewSizeIndex]
        jmp near ShowView
        push edx
        mov eax, OverlayPanelQueue
        xor edx, edx
.4:
        cmp dword [eax], byte 0
        je short .5
        inc edx
        add eax, byte 0Ch
        cmp edx, byte 0Ah
        jl short .4
        xor eax, eax
.5:
        pop edx
        ret
;-----------------------------------------------------------------------------
; RemoveOverlayPanel                           16090  97 PC, medium confidence
; (kind): takes the queued panels of a kind out of the panel queue
;-----------------------------------------------------------------------------
RemoveOverlayPanel:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, OverlayPanelQueue
        xor esi, esi
.1:
        cmp dword [ebx], byte 0
        je short .3
        cmp edi, dword [byte ebx+04h]
        jne short .3
        test edi, edi
        jl short .2
        cmp edi, byte 9
        jge short .2
        mov word [MessagePanel], 0FFFFh
.2:
        mov eax, dword [ebx]
        mov eax, dword [byte eax+02Ch]
        call RemoveOverlayWindow
        push dword [ebx]
        call FreeBitmap
        add esp, byte 4
        mov dword [ebx], 0
.3:
        inc esi
        add ebx, byte 0Ch
        cmp esi, byte 0Ah
        jl short .1
        jmp near PrevVideoModeKey_217
;-----------------------------------------------------------------------------
; DrawPanelArtScaled                              160E2  97 PC, low confidence
; Draws a piece of overlay panel art scaled to the panel size; takes the art
; and the panel rectangle
;-----------------------------------------------------------------------------
DrawPanelArtScaled:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 40h, 0
        mov ecx, 0Eh
        lea edi, [byte ebp-040h]
        mov esi, ScreenWidth
        rep movsd
        test eax, eax
        je short .1
        mov ebx, dword [PanelArtSmall]
        jmp short .2
.1:
        mov ebx, dword [PanelArtLarge]
.2:
        fld dword [byte ebp+01Ch]
        fcomp dword [F32_0p5]
        fnstsw ax
        sahf
        jne short .3
        movsx eax, word [byte ebx+06h]
        mov esi, dword [byte ebp+024h]
        sar eax, 1
        sub esi, eax
        push esi
        movsx eax, word [byte ebx+04h]
        mov esi, dword [byte ebp+020h]
        sar eax, 1
        sub esi, eax
        push esi
        push ebx
        call DrawArt
        add esp, byte 0Ch
        jmp near .4
.3:
        fld dword [byte ebp+01Ch]
        fmul dword [F32_65536]
        push byte 20h
        movsx eax, word [byte ebx+06h]
        call __CHP
        fistp dword [byte ebp-04h]
        mov edx, dword [byte ebp-04h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        add eax, eax
        mov edx, dword [byte ebp-04h]
        push eax
        movsx eax, word [byte ebx+04h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        add eax, eax
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        mov esi, eax
        mov eax, dword [eax]
        push esi
        sar eax, 1
        mov edi, dword [byte esi+04h]
        mov dword [byte ebp-08h], eax
        call SetDrawTarget
        add esp, byte 4
        push dword 0FFh
        call ClearScreen
        add esp, byte 4
        push byte 0
        push byte 0
        mov eax, dword [byte ebp-04h]
        push ebx
        add eax, eax
        push eax
        call DrawShapeScaledBy
        add esp, byte 10h
        lea eax, [byte ebp-040h]
        push eax
        sar edi, 1
        call SetDrawTarget
        mov eax, dword [byte ebp+024h]
        add esp, byte 4
        sub eax, edi
        push eax
        mov eax, dword [byte ebp+020h]
        sub eax, dword [byte ebp-08h]
        push eax
        push dword [byte esi+02Ch]
        call DrawArt
        add esp, byte 0Ch
        push esi
        call FreeBitmap
        add esp, byte 4
.4:
        leave
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 0Ch
;-----------------------------------------------------------------------------
; DrawPanelPlayerCard                             161F0  97 PC, low confidence
; Draws a player card on an overlay panel: picture, number, name and stats of
; the given player
;-----------------------------------------------------------------------------
DrawPanelPlayerCard:
        push esi
        push edi
        enter 30h, 0
        mov esi, eax
        mov edi, edx
        mov dword [byte ebp-08h], ebx
        mov dword [byte ebp-0Ch], ecx
        cmp dword [ViewScreenHeight], 12Ch
        jge short .1
        imul eax, dword [ViewScreenWidth], dword 226h
        jmp short .2
.1:
        imul eax, dword [ViewScreenWidth], dword 1C2h
.2:
        mov ebx, 280h
        cdq
        idiv ebx
        mov dword [byte ebp-030h], eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .3
        imul eax, dword [ViewScreenHeight], byte 41h
        jmp short .4
.3:
        imul eax, dword [ViewScreenHeight], byte 37h
.4:
        mov ebx, 190h
        cdq
        idiv ebx
        mov ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .5
        imul eax, dword [ViewScreenHeight], byte 0Ah
        jmp short .6
.5:
        imul eax, dword [ViewScreenHeight], byte 14h
.6:
        mov ecx, 190h
        cdq
        idiv ecx
        add ebx, eax
        mov dword [byte ebp-02Ch], ebx
        cmp dword [ViewScreenHeight], 12Ch
        jge short .7
        imul eax, dword [ViewScreenWidth], dword 258h
        jmp short .8
.7:
        imul eax, dword [ViewScreenWidth], dword 1F4h
.8:
        mov ebx, 280h
        cdq
        idiv ebx
        mov dword [byte ebp-028h], eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .9
        imul eax, dword [ViewScreenHeight], byte 0Ah
        jmp short .10
.9:
        imul eax, dword [ViewScreenHeight], byte 14h
.10:
        mov ebx, 190h
        cdq
        idiv ebx
        mov ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .11
        imul eax, dword [ViewScreenHeight], byte 41h
        jmp short .12
.11:
        imul eax, dword [ViewScreenHeight], byte 37h
.12:
        mov ecx, 190h
        cdq
        idiv ecx
        add ebx, eax
        mov dword [byte ebp-024h], ebx
        cmp dword [ViewScreenHeight], 12Ch
        jge short .13
        imul eax, dword [ViewScreenWidth], dword 258h
        jmp short .14
.13:
        imul eax, dword [ViewScreenWidth], dword 1F4h
.14:
        mov ebx, 280h
        cdq
        idiv ebx
        mov dword [byte ebp-020h], eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .15
        imul eax, dword [ViewScreenHeight], byte 0Ah
        jmp short .16
.15:
        imul eax, dword [ViewScreenHeight], byte 14h
.16:
        mov ebx, 190h
        cdq
        idiv ebx
        push esi
        mov dword [byte ebp-01Ch], eax
        call SetDrawTarget
        add esp, byte 4
        push dword 0FEh
        call ClearScreen
        add esp, byte 4
        push byte 0
        push byte 0
        lea eax, [byte ebp-030h]
        push eax
        push byte 3
        push dword 0FFh
        call FillPolygon
        add esp, byte 14h
        push dword 0FF0000AAh
        call MatchColor
        add esp, byte 4
        push eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .17
        imul eax, dword [ViewScreenHeight], byte 0Ah
        jmp short .18
.17:
        imul eax, dword [ViewScreenHeight], byte 14h
.18:
        mov ebx, 190h
        cdq
        idiv ebx
        mov ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .19
        mov ecx, 0Ah
        jmp short .20
.19:
        mov ecx, 0Eh
.20:
        mov eax, dword [ViewScreenWidth]
        shl eax, 2
        mov dword [byte ebp-04h], 280h
        cdq
        idiv dword [byte ebp-04h]
        add eax, ecx
        add ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .21
        mov eax, 0FFFFFFFDh
        jmp short .22
.21:
        xor eax, eax
.22:
        add eax, ebx
        push eax
        imul eax, dword [ViewScreenWidth], dword 1C2h
        mov ebx, 280h
        cdq
        idiv ebx
        push eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .23
        imul eax, dword [ViewScreenHeight], byte 0Ah
        jmp short .24
.23:
        imul eax, dword [ViewScreenHeight], byte 14h
.24:
        mov ebx, 190h
        cdq
        idiv ebx
        mov ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .25
        mov ecx, 0Ah
        jmp short .26
.25:
        mov ecx, 0Eh
.26:
        mov eax, dword [ViewScreenWidth]
        shl eax, 2
        mov dword [byte ebp-04h], 280h
        cdq
        idiv dword [byte ebp-04h]
        add eax, ecx
        add ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .27
        mov eax, 0FFFFFFFDh
        jmp short .28
.27:
        xor eax, eax
.28:
        add eax, ebx
        push eax
        imul eax, dword [ViewScreenWidth], byte 7Dh
        mov ebx, 280h
        cdq
        idiv ebx
        push eax
        call FillRectColor
        add esp, byte 14h
        push dword 0FF0000AAh
        call MatchColor
        add esp, byte 4
        push eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .29
        imul eax, dword [ViewScreenHeight], byte 0Ah
        jmp short .30
.29:
        imul eax, dword [ViewScreenHeight], byte 14h
.30:
        mov ebx, 190h
        cdq
        idiv ebx
        mov ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .31
        mov ecx, 0Ah
        jmp short .32
.31:
        mov ecx, 0Eh
.32:
        imul eax, dword [ViewScreenWidth], byte 5
        mov dword [byte ebp-04h], 280h
        cdq
        idiv dword [byte ebp-04h]
        add eax, ecx
        add ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .33
        mov eax, 0FFFFFFFDh
        jmp short .34
.33:
        xor eax, eax
.34:
        add eax, ebx
        push eax
        imul eax, dword [ViewScreenWidth], dword 1C2h
        mov ebx, 280h
        cdq
        idiv ebx
        push eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .35
        imul eax, dword [ViewScreenHeight], byte 0Ah
        jmp short .36
.35:
        imul eax, dword [ViewScreenHeight], byte 14h
.36:
        mov ebx, 190h
        cdq
        idiv ebx
        mov ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .37
        mov ecx, 0Ah
        jmp short .38
.37:
        mov ecx, 0Eh
.38:
        imul eax, dword [ViewScreenWidth], byte 5
        mov dword [byte ebp-04h], 280h
        cdq
        idiv dword [byte ebp-04h]
        add eax, ecx
        add ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .39
        mov eax, 0FFFFFFFDh
        jmp short .40
.39:
        xor eax, eax
.40:
        add eax, ebx
        push eax
        imul eax, dword [ViewScreenWidth], byte 7Dh
        mov ebx, 280h
        cdq
        idiv ebx
        push eax
        call FillRectColor
        add esp, byte 14h
        push dword 0FFh
        cmp dword [ViewScreenHeight], 12Ch
        jge short .41
        imul eax, dword [ViewScreenHeight], byte 0Ah
        jmp short .42
.41:
        imul eax, dword [ViewScreenHeight], byte 14h
.42:
        mov ebx, 190h
        cdq
        idiv ebx
        push eax
        push dword [esi]
        push byte 0
        push byte 0
        call FillRect
        add esp, byte 14h
        push dword 0FFh
        cmp dword [ViewScreenHeight], 12Ch
        jge short .43
        imul eax, dword [ViewScreenHeight], byte 0Ah
        jmp short .44
.43:
        imul eax, dword [ViewScreenHeight], byte 14h
.44:
        mov ebx, 190h
        cdq
        idiv ebx
        mov ecx, dword [byte esi+04h]
        sub ecx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .45
        imul eax, dword [ViewScreenHeight], byte 41h
        jmp short .46
.45:
        imul eax, dword [ViewScreenHeight], byte 37h
.46:
        mov ebx, 190h
        cdq
        idiv ebx
        sub ecx, eax
        push ecx
        push dword [esi]
        cmp dword [ViewScreenHeight], 12Ch
        jge short .47
        imul eax, dword [ViewScreenHeight], byte 41h
        jmp short .48
.47:
        imul eax, dword [ViewScreenHeight], byte 37h
.48:
        mov ebx, 190h
        cdq
        idiv ebx
        mov ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .49
        imul eax, dword [ViewScreenHeight], byte 0Ah
        jmp short .50
.49:
        imul eax, dword [ViewScreenHeight], byte 14h
.50:
        mov ecx, 190h
        cdq
        idiv ecx
        add eax, ebx
        push eax
        push byte 0
        call FillRect
        add esp, byte 14h
        call SetOverlayFont
        cmp edi, byte 2
        jne short .51
        call rand_
        cdq
        idiv edi
        mov edi, edx
.51:
        imul eax, dword [ViewScreenWidth], byte 32h
        mov ebx, 280h
        cdq
        idiv ebx
        cmp dword [ViewScreenHeight], 12Ch
        jge short .52
        mov edx, dword [byte esi+04h]
        sar edx, 1
        push edx
        push eax
        mov eax, edi
        push dword 3E4CCCCDh
        jmp short .53
.52:
        mov edx, dword [byte esi+04h]
        sar edx, 1
        push edx
        push eax
        mov eax, edi
        push dword 3F000000h
.53:
        call DrawPanelArtScaled
        movsx esi, word [gameclock]
        movsx eax, word [StatsPanelPlayer]
        sub eax, esi
        mov esi, eax
        cmp word [gameclock], byte 3Ch
        jge short .54
        cmp word [StatsPanelOn], byte 0
        je short .54
        lea esi, [byte eax-01h]
.54:
        mov eax, esi
        mov ebx, 3Ch
        cdq
        idiv ebx
        mov eax, esi
        push edx
        cdq
        idiv ebx
        push eax
        push str_2d02d
        lea eax, [byte ebp-018h]
        push eax
        call sprintf_
        add esp, byte 10h
        cmp dword [ViewScreenHeight], 12Ch
        jl near .58
        imul eax, dword [ViewScreenHeight], byte 0Ah
        mov ebx, 190h
        cdq
        idiv ebx
        imul ecx, dword [ViewScreenHeight], byte 14h
        mov ebx, eax
        mov eax, ecx
        mov esi, 190h
        cdq
        idiv esi
        cmp dword [ViewScreenHeight], 12Ch
        jge short .56
        lea edx, [byte ebp-018h]
        push edx
        jl short .55
        mov ebx, eax
.55:
        mov eax, dword [ViewScreenHeight]
        add eax, eax
        mov ecx, 190h
        cdq
        idiv ecx
        add eax, ebx
        push eax
        imul eax, dword [ViewScreenWidth], dword 1C2h
        mov ebx, 280h
        cdq
        idiv ebx
        mov ebx, eax
        lea eax, [byte ebp-018h]
        push eax
        call MeasureText
        add esp, byte 4
        sub ebx, eax
        push ebx
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        jmp short .58
.56:
        jl short .57
        mov ebx, eax
.57:
        mov eax, dword [ViewScreenHeight]
        add eax, eax
        mov ecx, 190h
        cdq
        idiv ecx
        add eax, ebx
        push eax
        imul eax, dword [ViewScreenWidth], dword 1C2h
        mov ebx, 280h
        cdq
        idiv ebx
        mov ebx, eax
        lea eax, [byte ebp-018h]
        push eax
        call MeasureText
        add esp, byte 4
        sub ebx, eax
        push ebx
        lea eax, [byte ebp-018h]
        push eax
        call DrawTextAt
        add esp, byte 0Ch
.58:
        imul eax, dword [ViewScreenHeight], byte 0Ah
        mov ebx, 190h
        cdq
        idiv ebx
        imul ecx, dword [ViewScreenHeight], byte 14h
        mov ebx, eax
        mov eax, ecx
        mov esi, 190h
        cdq
        idiv esi
        cmp dword [ViewScreenHeight], 12Ch
        jge short .60
        push dword [byte ebp-08h]
        jl short .59
        mov ebx, eax
.59:
        mov eax, dword [ViewScreenHeight]
        add eax, eax
        mov ecx, 190h
        cdq
        idiv ecx
        add eax, ebx
        push eax
        imul eax, dword [ViewScreenWidth], byte 7Dh
        mov ebx, 280h
        cdq
        idiv ebx
        push eax
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        jmp short .62
.60:
        jl short .61
        mov ebx, eax
.61:
        mov eax, dword [ViewScreenHeight]
        add eax, eax
        mov ecx, 190h
        cdq
        idiv ecx
        add eax, ebx
        push eax
        imul eax, dword [ViewScreenWidth], byte 7Dh
        mov ebx, 280h
        cdq
        idiv ebx
        push eax
        push dword [byte ebp-08h]
        call DrawTextAt
        add esp, byte 0Ch
.62:
        cmp dword [ViewScreenHeight], 12Ch
        jge near .69
        push dword [byte ebp-0Ch]
        jge short .63
        mov ebx, 0Ah
        jmp short .64
.63:
        mov ebx, 0Eh
.64:
        mov eax, dword [ViewScreenWidth]
        shl eax, 2
        mov ecx, 280h
        cdq
        idiv ecx
        add ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .65
        mov eax, 0FFFFFFFDh
        jmp short .66
.65:
        xor eax, eax
.66:
        lea ecx, [ebx+eax]
        mov eax, dword [ViewScreenHeight]
        add eax, eax
        mov ebx, 190h
        cdq
        idiv ebx
        add ecx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .67
        imul eax, dword [ViewScreenHeight], byte 0Ah
        jmp short .68
.67:
        imul eax, dword [ViewScreenHeight], byte 14h
.68:
        cdq
        idiv ebx
        add eax, ecx
        push eax
        imul eax, dword [ViewScreenWidth], byte 7Dh
        mov ebx, 280h
        cdq
        idiv ebx
        push eax
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        jmp near .76
.69:
        jge short .70
        mov ebx, 0Ah
        jmp short .71
.70:
        mov ebx, 0Eh
.71:
        mov eax, dword [ViewScreenWidth]
        shl eax, 2
        mov ecx, 280h
        cdq
        idiv ecx
        add ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .72
        mov eax, 0FFFFFFFDh
        jmp short .73
.72:
        xor eax, eax
.73:
        lea ecx, [ebx+eax]
        mov eax, dword [ViewScreenHeight]
        add eax, eax
        mov ebx, 190h
        cdq
        idiv ebx
        add ecx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .74
        imul eax, dword [ViewScreenHeight], byte 0Ah
        jmp short .75
.74:
        imul eax, dword [ViewScreenHeight], byte 14h
.75:
        cdq
        idiv ebx
        add eax, ecx
        push eax
        imul eax, dword [ViewScreenWidth], byte 7Dh
        mov ebx, 280h
        cdq
        idiv ebx
        push eax
        push dword [byte ebp-0Ch]
        call DrawTextAt
        add esp, byte 0Ch
.76:
        cmp dword [ViewScreenHeight], 12Ch
        jge near .83
        push dword [byte ebp+010h]
        jge short .77
        mov ebx, 0Ah
        jmp short .78
.77:
        mov ebx, 0Eh
.78:
        mov eax, dword [ViewScreenWidth]
        shl eax, 2
        mov ecx, 280h
        cdq
        idiv ecx
        add ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .79
        mov eax, 0FFFFFFFDh
        jmp short .80
.79:
        xor eax, eax
.80:
        lea ecx, [eax+ebx]
        mov eax, dword [ViewScreenHeight]
        add eax, eax
        mov ebx, 190h
        cdq
        idiv ebx
        add ecx, ecx
        add ecx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .81
        imul eax, dword [ViewScreenHeight], byte 0Ah
        jmp short .82
.81:
        imul eax, dword [ViewScreenHeight], byte 14h
.82:
        cdq
        idiv ebx
        add eax, ecx
        push eax
        imul eax, dword [ViewScreenWidth], byte 7Dh
        mov ebx, 280h
        cdq
        idiv ebx
        push eax
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        jmp near .90
.83:
        jge short .84
        mov ebx, 0Ah
        jmp short .85
.84:
        mov ebx, 0Eh
.85:
        mov eax, dword [ViewScreenWidth]
        shl eax, 2
        mov ecx, 280h
        cdq
        idiv ecx
        add ebx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .86
        mov eax, 0FFFFFFFDh
        jmp short .87
.86:
        xor eax, eax
.87:
        lea ecx, [eax+ebx]
        mov eax, dword [ViewScreenHeight]
        add eax, eax
        mov ebx, 190h
        cdq
        idiv ebx
        add ecx, ecx
        add ecx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .88
        imul eax, dword [ViewScreenHeight], byte 0Ah
        jmp short .89
.88:
        imul eax, dword [ViewScreenHeight], byte 14h
.89:
        cdq
        idiv ebx
        add eax, ecx
        push eax
        imul eax, dword [ViewScreenWidth], byte 7Dh
        mov ebx, 280h
        cdq
        idiv ebx
        push eax
        push dword [byte ebp+010h]
        call DrawTextAt
        add esp, byte 0Ch
.90:
        leave
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; GetPlayerNumber                                 16AD0  97 PC, low confidence
; Returns the jersey number of a player from the team roster record
;-----------------------------------------------------------------------------
GetPlayerNumber:
        push edx
        mov edx, dword [dword eax+0FEh]
        mov edx, dword [dword edx+0108h]
        cmp byte [dword eax+0A6h], 19h
        jge short .1
        movsx eax, byte [dword eax+0A6h]
        imul eax, dword 125h
        movzx eax, byte [dword edx+eax+015Fh]
        pop edx
        ret
.1:
        movsx eax, byte [dword eax+0A6h]
        sub eax, byte 19h
        imul eax, dword 125h
        movzx eax, byte [dword edx+eax+01DFEh]
        pop edx
        ret
;-----------------------------------------------------------------------------
; GetPlayerPanelName                              16B17  97 PC, low confidence
; Builds the short name of a player shown on an overlay panel (initial and
; last name)
;-----------------------------------------------------------------------------
GetPlayerPanelName:
        push edx
        mov edx, dword [dword eax+0FEh]
        mov edx, dword [dword edx+0108h]
        cmp dword [ViewScreenHeight], 12Ch
        jge short .3
        cmp byte [dword eax+0A6h], 19h
        jge short .1
        movsx eax, byte [dword eax+0A6h]
        imul eax, dword 125h
        mov al, byte [dword edx+eax+0BBh]
        jmp short .2
.1:
        movsx eax, byte [dword eax+0A6h]
        sub eax, byte 19h
        imul eax, dword 125h
        mov al, byte [dword edx+eax+01D5Ah]
.2:
        mov byte [PanelNameBuf], al
        mov eax, PanelNameBuf
        pop edx
        ret
.3:
        cmp byte [dword eax+0A6h], 19h
        jge short .4
        movsx eax, byte [dword eax+0A6h]
        imul eax, dword 125h
        add edx, 0A3h
        jmp short .5
.4:
        movsx eax, byte [dword eax+0A6h]
        sub eax, byte 19h
        imul eax, dword 125h
        add edx, 1D42h
.5:
        add eax, edx
        add eax, byte 18h
        pop edx
        ret
;-----------------------------------------------------------------------------
; GetPlayerName                                   16BAD  97 PC, low confidence
; Copies the full name of a player from the team roster record into a buffer
;-----------------------------------------------------------------------------
GetPlayerName:
        push edx
        mov edx, dword [dword eax+0FEh]
        mov edx, dword [dword edx+0108h]
        cmp byte [dword eax+0A6h], 19h
        jge short .1
        movsx eax, byte [dword eax+0A6h]
        imul eax, dword 125h
        add edx, 0A3h
        jmp short .2
.1:
        movsx eax, byte [dword eax+0A6h]
        sub eax, byte 19h
        imul eax, dword 125h
        add edx, 1D42h
.2:
        add eax, edx
        add eax, byte 8
        pop edx
        ret
;-----------------------------------------------------------------------------
; TeamNameField                                   16BF5  97 PC, low confidence
; Returns the team name field of a team record
;-----------------------------------------------------------------------------
TeamNameField:
        add eax, byte 3Eh
        ret
;-----------------------------------------------------------------------------
; DrawMessagePanel                                16BF9  97 PC, low confidence
; Draws the in-game message overlay: frame, title and text lines picked by
; the message type
;-----------------------------------------------------------------------------
DrawMessagePanel:
        push esi
        push edi
        enter 24h, 0
        mov esi, eax
        mov edi, ebx
        add dword [ecx], byte 4
        mov ecx, dword [ecx]
        mov ecx, dword [byte ecx-04h]
        cmp ecx, byte 0FFFFFFFFh
        je near DrawMessagePanel_15F.7
        movsx eax, word [MessagePanel]
        cmp eax, ecx
        jg near DrawMessagePanel_15F.7
        cmp eax, byte 0FFFFFFFFh
        je short .1
        call RemoveOverlayPanel
.1:
        mov word [MessagePanel], cx
        mov dword [byte esi+04h], ecx
        call SetOverlayFont
        mov eax, dword [nosplit ecx*4+MessagePanelIds]
        call GetLangText
        mov edx, eax
        lea eax, [byte ebp-024h]
        call strcpy_
        imul eax, dword [ViewScreenWidth], byte 14h
        mov ebx, 280h
        cdq
        idiv ebx
        mov ebx, eax
        lea eax, [byte ebp-024h]
        push eax
        call MeasureText
        lea ecx, [eax+ebx]
        mov eax, ecx
        mov ebx, 4
        cdq
        idiv ebx
        add esp, byte 4
        test edx, edx
        je short .2
        sub ecx, edx
.2:
        cmp dword [ViewScreenHeight], 12Ch
        jge short .3
        mov ebx, 0Ah
        jmp short .4
.3:
        mov ebx, 0Eh
.4:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov dword [byte ebp-04h], 190h
        cdq
        idiv dword [byte ebp-04h]
        push byte 20h
        add eax, ebx
        push eax
        push ecx
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [esi], eax
        push dword [esi]
        mov dword [byte esi+08h], edi
        call SetDrawTarget
        add esp, byte 4
        push dword 0FEh
        call ClearScreen
        add esp, byte 4
        call SetOverlayFont
        imul eax, dword [ViewScreenWidth], byte 0Ah
        mov ecx, 280h
        cdq
        idiv ecx
        mov ebx, dword [ViewScreenHeight]
        shl ebx, 2
        mov ecx, eax
        mov eax, ebx
        mov edi, 190h
        cdq
        idiv edi
        cmp dword [ViewScreenHeight], 12Ch
        jge short .5
        lea edx, [byte ebp-024h]
        push edx
        push eax
        push ecx
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        jmp short .6
.5:
        push eax
        push ecx
        lea eax, [byte ebp-024h]
        push eax
        call DrawTextAt
        add esp, byte 0Ch
.6:
        cmp dword [VideoModeChanged], byte 0
        sete al
        movzx eax, al
        shl eax, 4
        or al, 8
        mov ecx, eax
        mov eax, dword [esi]
        mov ebx, dword [byte eax+02Ch]
        imul eax, dword [ViewScreenHeight], byte 14h
        mov esi, 190h
        cdq
        idiv esi
        mov edx, eax
DrawMessagePanel_15D:
        xor eax, eax
DrawMessagePanel_15F:
        call AddOverlayWindow
.7:
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; DrawVideoModePanel                           16D61  97 PC, medium confidence
; The screen mode panel ("%d x %d", Doubled / Interlaced / Normal)
;-----------------------------------------------------------------------------
DrawVideoModePanel:
        push esi
        push edi
        enter 38h, 0
        mov esi, eax
        mov edi, ebx
        call SetOverlayFont
        mov eax, 200h
        call RemoveOverlayPanel
        mov dword [byte esi+04h], 200h
        add dword [ecx], byte 4
        cmp edx, byte 1
        jne short .1
        mov edx, CameraViewNames
        lea eax, [byte ebp-038h]
        call strcpy_
        jmp short .5
.1:
        cmp edx, byte 2
        jne short .5
        push dword [VideoModeSel]
        push dword [VideoModePanelMode]
        push str_DXD
        lea eax, [byte ebp-038h]
        push eax
        call sprintf_
        add esp, byte 10h
        cmp dword [VideoModeChanged], byte 0
        je short .3
        cmp dword [DisplayFlags], byte 0
        je short .2
        mov edx, str_Doubled
        jmp short .4
.2:
        mov edx, str_Interlaced
        jmp short .4
.3:
        mov edx, str_Normal
.4:
        lea eax, [byte ebp-038h]
        call strcat_
.5:
        imul eax, dword [ViewScreenWidth], byte 14h
        mov ebx, 280h
        cdq
        idiv ebx
        mov ebx, eax
        lea eax, [byte ebp-038h]
        push eax
        call MeasureText
        add esp, byte 4
        lea ecx, [eax+ebx]
        cmp dword [ViewScreenHeight], 12Ch
        jge short .6
        mov ebx, 0Ah
        jmp short .7
.6:
        mov ebx, 0Eh
.7:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov dword [byte ebp-04h], 190h
        cdq
        idiv dword [byte ebp-04h]
        push byte 20h
        add eax, ebx
        push eax
        push ecx
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [esi], eax
        push dword [esi]
        mov dword [byte esi+08h], edi
        call SetDrawTarget
        add esp, byte 4
        push dword 0FEh
        call ClearScreen
        add esp, byte 4
        call SetOverlayFont
        imul eax, dword [ViewScreenWidth], byte 0Ah
        mov ecx, 280h
        cdq
        idiv ecx
        mov ebx, dword [ViewScreenHeight]
        shl ebx, 2
        mov ecx, eax
        mov eax, ebx
        mov edi, 190h
        cdq
        idiv edi
        cmp dword [ViewScreenHeight], 12Ch
        jge short .8
        lea edx, [byte ebp-038h]
        push edx
        push eax
        push ecx
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        jmp short .9
.8:
        push eax
        push ecx
        lea eax, [byte ebp-038h]
        push eax
        call DrawTextAt
        add esp, byte 0Ch
.9:
        cmp dword [VideoModeChanged], byte 0
        sete al
        movzx ecx, al
        shl ecx, 4
        mov eax, dword [esi]
        xor edx, edx
        or cl, 8
        mov ebx, dword [byte eax+02Ch]
        jmp near DrawMessagePanel_15D
;-----------------------------------------------------------------------------
; DrawPenaltyPanel                             16ED0  97 PC, medium confidence
; Overlay panel kind 1: the penalty call (game text "Penalty", "for", the
; infraction, "2 Minutes" / "5 Minute Major", "and a Game Misconduct")
;-----------------------------------------------------------------------------
DrawPenaltyPanel:
        push esi
        push edi
        enter 0F4h, 0
        push eax
        push ebx
        sub ebp, 82h
        mov edx, ecx
        mov ecx, 14h
        lea edi, [byte ebp-022h]
        mov esi, PenaltyPanelBlank
        mov eax, 100h
        rep movsd
        call RemoveOverlayPanel
        mov eax, dword [byte ebp-076h]
        mov dword [byte eax+04h], 100h
        add dword [edx], byte 4
        mov eax, dword [edx]
        add eax, byte 4
        mov bx, word [byte eax-08h]
        mov dword [edx], eax
        add eax, byte 4
        mov si, word [byte eax-08h]
        mov dword [edx], eax
        mov ax, word [byte eax-04h]
        mov word [byte ebp+07Eh], ax
        movsx eax, bx
        imul eax, dword 108h
        mov ebx, SortCords
        add ebx, eax
        imul eax, dword [ViewScreenWidth], dword 1F4h
        mov ecx, 280h
        cdq
        idiv ecx
        mov ecx, eax
        imul eax, dword [ViewScreenHeight], byte 5Ah
        mov edi, 190h
        cdq
        idiv edi
        push byte 20h
        push eax
        push ecx
        call CreateBitmap
        mov edx, dword [byte ebp-076h]
        mov dword [edx], eax
        mov eax, dword [byte ebp-07Ah]
        add esp, byte 0Ch
        mov dword [byte edx+08h], eax
        mov eax, ebx
        call GetPlayerName
        push eax
        mov eax, ebx
        call GetPlayerPanelName
        push eax
        mov eax, ebx
        call GetPlayerNumber
        push eax
        mov eax, 7
        call GetLangText
        push eax
        mov edx, dword [byte ebp+07Eh]
        push str_SDSS
        lea eax, [byte ebp-072h]
        xor dh, dh
        push eax
        and dl, 7
        call sprintf_
        add esp, byte 18h
        test byte [byte ebp+07Eh], 10h
        je near .3
        test byte [byte ebp+07Eh], 7
        je short .1
        movsx eax, dx
        sar eax, 1
        mov eax, dword [nosplit eax*4+PenaltyNameIds]
        call GetLangText
        push eax
        push str_S_DrawPenaltyPanel
        lea eax, [byte ebp+02Eh]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, 29h
        call GetLangText
        mov edx, eax
        lea eax, [byte ebp+02Eh]
        call strcat_
        jmp short .2
.1:
        mov eax, 21h
        call GetLangText
        mov edx, eax
        lea eax, [byte ebp+02Eh]
        call strcpy_
.2:
        movsx eax, si
        mov eax, dword [nosplit eax*4+PenaltyPanelIds]
        call GetLangText
        push eax
        mov eax, 28h
        call GetLangText
        push eax
        push str_SS
        lea eax, [byte ebp-022h]
        push eax
        call sprintf_
        add esp, byte 10h
        jmp near .5
.3:
        cmp si, byte 1Dh
        jne short .4
        mov eax, 17h
        call GetLangText
        push eax
        mov eax, 28h
        call GetLangText
        push eax
        mov eax, 1Fh
        call GetLangText
        push eax
        push str_SSS
        lea eax, [byte ebp+02Eh]
        push eax
        call sprintf_
        add esp, byte 14h
        mov eax, 18h
        call GetLangText
        push eax
        mov eax, 28h
        call GetLangText
        push eax
        mov eax, 1Dh
        call GetLangText
        push eax
        push str_SSS
        lea eax, [byte ebp-022h]
        push eax
        call sprintf_
        add esp, byte 14h
        jmp short .5
.4:
        mov eax, 28h
        call GetLangText
        push eax
        movsx eax, dx
        sar eax, 1
        mov eax, dword [nosplit eax*4+PenaltyNameIds]
        call GetLangText
        push eax
        push str_SS
        lea eax, [byte ebp+02Eh]
        push eax
        call sprintf_
        movsx eax, si
        add esp, byte 10h
        mov eax, dword [nosplit eax*4+PenaltyPanelIds]
        call GetLangText
        push eax
        push str_S_DrawPenaltyPanel
        lea eax, [byte ebp-022h]
        push eax
        call sprintf_
        add esp, byte 0Ch
.5:
        lea eax, [byte ebp-022h]
        lea ecx, [byte ebp+02Eh]
        lea edx, [byte ebp-072h]
        push eax
        test byte [dword ebx+0BFh], 40h
        sete al
        movzx esi, al
        mov eax, dword [byte ebp-076h]
        mov ebx, edx
        mov edx, esi
        mov eax, dword [eax]
        call DrawPanelPlayerCard
        cmp dword [VideoModeChanged], byte 0
        sete al
        movzx eax, al
        mov ecx, eax
        mov eax, dword [byte ebp-076h]
        mov eax, dword [eax]
        mov ebx, dword [byte eax+02Ch]
        imul eax, dword [ViewScreenHeight], dword 140h
        mov esi, 190h
        cdq
        idiv esi
DrawPenaltyPanel_26F:
        shl ecx, 4
        or cl, 8
        mov edx, eax
        xor eax, eax
        call AddOverlayWindow
        lea esp, [dword ebp+082h]
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; DrawPenaltyShotPanel                         17158  97 PC, medium confidence
; Overlay panel kind 8: "Penalty Shot", the shooter "against" the goalie
;-----------------------------------------------------------------------------
DrawPenaltyShotPanel:
        push esi
        push edi
        enter 0F0h, 0
        push eax
        push ebx
        sub ebp, 0CEh
        mov ebx, ecx
        mov ecx, 14h
        lea edi, [byte ebp-022h]
        mov esi, PenaltyShotPanelBlank
        mov eax, 100h
        rep movsd
        call RemoveOverlayPanel
        mov eax, dword [byte ebp-026h]
        mov dword [byte eax+04h], 100h
        add dword [ebx], byte 4
        mov eax, dword [ebx]
        mov ax, word [byte eax-04h]
        cwde
        imul eax, dword 108h
        mov ebx, SortCords
        add ebx, eax
        mov eax, dword [dword ebx+0102h]
        mov ax, word [dword eax+0FCh]
        test ax, ax
        jl near DrawPenaltyShotPanel_4D7
        cwde
        imul eax, dword 108h
        mov esi, SortCords
        add esi, eax
        imul eax, dword [ViewScreenWidth], dword 1F4h
        mov ecx, 280h
        cdq
        idiv ecx
        mov ecx, eax
        imul eax, dword [ViewScreenHeight], byte 5Ah
        mov edi, 190h
        cdq
        idiv edi
        push byte 20h
        push eax
        push ecx
        call CreateBitmap
        mov edx, dword [byte ebp-026h]
        mov dword [edx], eax
        mov eax, dword [byte ebp-02Ah]
        add esp, byte 0Ch
        mov dword [byte edx+08h], eax
        mov eax, 8
        call GetLangText
        push eax
        push str_S_DrawPenaltyPanel
        lea eax, [byte ebp+07Eh]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, ebx
        call GetPlayerName
        push eax
        mov eax, ebx
        call GetPlayerPanelName
        push eax
        mov eax, ebx
        call GetPlayerNumber
        push eax
        push str_DSS
        lea eax, [byte ebp+02Eh]
        push eax
        call sprintf_
        add esp, byte 14h
        mov eax, esi
        call GetPlayerName
        push eax
        mov eax, esi
        call GetPlayerPanelName
        push eax
        mov eax, esi
        call GetPlayerNumber
        push eax
        mov eax, 35h
        call GetLangText
        push eax
        push str_SDSS2
        lea eax, [byte ebp-022h]
        push eax
        lea ecx, [byte ebp+02Eh]
        call sprintf_
        add esp, byte 18h
        lea eax, [byte ebp-022h]
        mov esi, dword [byte ebp-026h]
        push eax
        lea eax, [byte ebp+07Eh]
        test byte [dword ebx+0BFh], 40h
        sete dl
        mov esi, dword [esi]
        movzx edx, dl
        mov ebx, eax
        mov eax, esi
        call DrawPanelPlayerCard
        cmp dword [VideoModeChanged], byte 0
        sete al
        movzx eax, al
        mov ecx, eax
        mov eax, dword [byte ebp-026h]
        mov eax, dword [eax]
        mov ebx, dword [byte eax+02Ch]
        imul eax, dword [ViewScreenHeight], dword 140h
        cdq
        idiv edi
        jmp near DrawPenaltyShotPanel_49A.30
;-----------------------------------------------------------------------------
; DrawSpecialTeamsPanel                        172C7  97 PC, medium confidence
; Overlay panel kind 9: specialty teams tonight / this season, power play and
; penalty killing (game text 33h-37h)
;-----------------------------------------------------------------------------
DrawSpecialTeamsPanel:
        push esi
        push edi
        enter 0F0h, 0
        push eax
        push ebx
        sub ebp, 0CEh
        mov ecx, 14h
        lea edi, [byte ebp+02Eh]
        mov esi, SpecialTeamsPanelBlank
        rep movsd
        movsx eax, word [HmPlayersInBox]
        movsx ebx, word [AwPlayersInBox]
        sub eax, ebx
        mov ebx, eax
        je near DrawPenaltyShotPanel_4D7
        mov eax, 100h
        call RemoveOverlayPanel
        mov eax, dword [byte ebp-026h]
        mov dword [byte eax+04h], 100h
        imul eax, dword [ViewScreenWidth], dword 1F4h
        mov ecx, 280h
        cdq
        idiv ecx
        mov ecx, eax
        imul eax, dword [ViewScreenHeight], byte 5Ah
        mov esi, 190h
        cdq
        idiv esi
        push byte 20h
        push eax
        push ecx
        call CreateBitmap
        mov edx, dword [byte ebp-026h]
        mov dword [edx], eax
        mov eax, dword [byte ebp-02Ah]
        add esp, byte 0Ch
        mov dword [byte edx+08h], eax
        test ebx, ebx
        setl al
        movzx eax, al
        test eax, eax
        je short .1
        mov eax, awtmstruct
        jmp short .2
.1:
        mov eax, hmtmstruct
.2:
        mov eax, dword [dword eax+0108h]
        cmp word [dword eax+020CBh], byte 0
        jne near .22
        mov eax, 34h
        call GetLangText
        push eax
        push str_S_DrawPenaltyPanel
        lea eax, [byte ebp-022h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        test ebx, ebx
        setl al
        movzx eax, al
        test eax, eax
        je short .3
        mov eax, awtmstruct
        jmp short .4
.3:
        mov eax, hmtmstruct
.4:
        mov eax, dword [dword eax+0108h]
        cmp word [dword eax+087h], byte 0
        je near .11
        test ebx, ebx
        setl al
        movzx eax, al
        test eax, eax
        je short .5
        mov eax, awtmstruct
        jmp short .6
.5:
        mov eax, hmtmstruct
.6:
        mov eax, dword [dword eax+0108h]
        movsx edx, word [dword eax+089h]
        imul edx, byte 64h
        test ebx, ebx
        setl al
        movzx eax, al
        test eax, eax
        je short .7
        mov eax, awtmstruct
        jmp short .8
.7:
        mov eax, hmtmstruct
.8:
        mov eax, dword [dword eax+0108h]
        movsx ecx, word [dword eax+087h]
        mov eax, edx
        cdq
        idiv ecx
        push eax
        mov eax, 36h
        call GetLangText
        push eax
        test ebx, ebx
        setl al
        movzx eax, al
        test eax, eax
        je short .9
        mov eax, awtmstruct
        jmp short .10
.9:
        mov eax, hmtmstruct
.10:
        mov eax, dword [dword eax+0108h]
        call TeamNameField
        push eax
        push str_SSD
        lea eax, [byte ebp+07Eh]
        push eax
        call sprintf_
        add esp, byte 14h
        jmp short .12
.11:
        mov byte [byte ebp+07Eh], 0
.12:
        test ebx, ebx
        setg al
        movzx eax, al
        test eax, eax
        je short .13
        mov eax, awtmstruct
        jmp short .14
.13:
        mov eax, hmtmstruct
.14:
        mov eax, dword [dword eax+0108h]
        cmp word [dword eax+08Dh], byte 0
        je near .21
        test ebx, ebx
        setg al
        movzx eax, al
        test eax, eax
        je short .15
        mov eax, awtmstruct
        jmp short .16
.15:
        mov eax, hmtmstruct
.16:
        mov eax, dword [dword eax+0108h]
        movsx edx, word [dword eax+08Bh]
        imul edx, byte 64h
        test ebx, ebx
        setg al
        movzx eax, al
        test eax, eax
        je short .17
        mov eax, awtmstruct
        jmp short .18
.17:
        mov eax, hmtmstruct
.18:
        mov eax, dword [dword eax+0108h]
        movsx ecx, word [dword eax+08Dh]
        mov eax, edx
        cdq
        idiv ecx
        mov edx, 64h
        sub edx, eax
        push edx
        mov eax, 37h
        call GetLangText
        push eax
        test ebx, ebx
        setg al
        movzx eax, al
        test eax, eax
        je short .19
        mov eax, awtmstruct
        jmp short .20
.19:
        mov eax, hmtmstruct
.20:
        mov eax, dword [dword eax+0108h]
        call TeamNameField
        push eax
        push str_SSD
        lea eax, [byte ebp+02Eh]
        push eax
        call sprintf_
        add esp, byte 14h
        jmp near .29
.21:
        mov byte [byte ebp+02Eh], 0
        jmp near .29
.22:
        mov eax, 33h
        call GetLangText
        push eax
        push str_S_DrawPenaltyPanel
        lea eax, [byte ebp-022h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        test ebx, ebx
        setl al
        movzx eax, al
        test eax, eax
        je short .23
        mov eax, awtmstruct
        jmp short .24
.23:
        mov eax, hmtmstruct
.24:
        mov eax, dword [dword eax+0108h]
        movsx eax, word [dword eax+020CBh]
        push eax
        test ebx, ebx
        setl al
        movzx eax, al
        test eax, eax
        je short .25
        mov eax, awtmstruct
        jmp short .26
.25:
        mov eax, hmtmstruct
.26:
        mov eax, dword [dword eax+0108h]
        movsx eax, word [dword eax+020CDh]
        push eax
        mov eax, 36h
        call GetLangText
        push eax
        test ebx, ebx
        setl al
        movzx eax, al
        test eax, eax
        je short .27
        mov eax, awtmstruct
        jmp short .28
.27:
        mov eax, hmtmstruct
.28:
        mov eax, dword [dword eax+0108h]
        call TeamNameField
        push eax
        push str_SSDD
        lea eax, [byte ebp+07Eh]
        push eax
        call sprintf_
        mov byte [byte ebp+02Eh], 0
        add esp, byte 18h
.29:
        lea eax, [byte ebp+02Eh]
        lea ecx, [byte ebp+07Eh]
        lea edx, [byte ebp-022h]
        push eax
        test ebx, ebx
        setg al
DrawPenaltyShotPanel_48E:
        movzx esi, al
        mov eax, dword [byte ebp-026h]
        mov ebx, edx
        mov edx, esi
        mov eax, dword [eax]
DrawPenaltyShotPanel_49A:
        call DrawPanelPlayerCard
        cmp dword [VideoModeChanged], byte 0
        sete al
        movzx eax, al
        mov ecx, eax
        mov eax, dword [byte ebp-026h]
        mov eax, dword [eax]
        mov ebx, dword [byte eax+02Ch]
        imul eax, dword [ViewScreenHeight], dword 140h
        mov esi, 190h
        cdq
        idiv esi
.30:
        shl ecx, 4
        or cl, 8
        mov edx, eax
        xor eax, eax
        call AddOverlayWindow
DrawPenaltyShotPanel_4D7:
        lea esp, [dword ebp+0CEh]
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; DrawInjuryPanel                              17639  97 PC, medium confidence
; Overlay panel kind 10: "Injury" with "#%d %s %s"
;-----------------------------------------------------------------------------
DrawInjuryPanel:
        push esi
        push edi
        enter 0F0h, 0
        push eax
        push ebx
        sub ebp, 0CEh
        mov edx, ecx
        mov ecx, 14h
        lea edi, [byte ebp+07Eh]
        mov esi, InjuryPanelBlank
        mov eax, 100h
        rep movsd
        call RemoveOverlayPanel
        mov eax, dword [byte ebp-026h]
        mov dword [byte eax+04h], 100h
        add dword [edx], byte 4
        mov eax, dword [edx]
        mov ax, word [byte eax-04h]
        cwde
        imul eax, dword 108h
        mov ebx, SortCords
        add ebx, eax
        imul eax, dword [ViewScreenWidth], dword 1F4h
        mov ecx, 280h
        cdq
        idiv ecx
        mov ecx, eax
        imul eax, dword [ViewScreenHeight], byte 5Ah
        mov esi, 190h
        cdq
        idiv esi
        push byte 20h
        push eax
        push ecx
        call CreateBitmap
        mov edx, dword [byte ebp-026h]
        mov dword [edx], eax
        mov eax, dword [byte ebp-02Ah]
        add esp, byte 0Ch
        mov dword [byte edx+08h], eax
        mov eax, 31h
        call GetLangText
        push eax
        push str_S_DrawPenaltyPanel
        lea eax, [byte ebp-022h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, ebx
        call GetPlayerName
        push eax
        mov eax, ebx
        call GetPlayerPanelName
        push eax
        mov eax, ebx
        call GetPlayerNumber
        push eax
        push str_DSS
        lea eax, [byte ebp+02Eh]
        push eax
        lea ecx, [byte ebp+02Eh]
        call sprintf_
        add esp, byte 14h
        lea eax, [byte ebp+07Eh]
        lea edx, [byte ebp-022h]
        push eax
        test byte [dword ebx+0BFh], 40h
        sete al
        jmp near DrawPenaltyShotPanel_48E
;-----------------------------------------------------------------------------
; DrawPeriodPanel                              1771B  97 PC, medium confidence
; Overlay panel kind 11: "Period" with "%s %s" / "%s   %d"
;-----------------------------------------------------------------------------
DrawPeriodPanel:
        push esi
        push edi
        enter 0F0h, 0
        push eax
        push ebx
        sub ebp, 0CEh
        mov ecx, 14h
        lea edi, [byte ebp-022h]
        mov esi, PeriodPanelBlank
        mov eax, 100h
        rep movsd
        call IsOverlayShown
        test eax, eax
        jne near DrawPenaltyShotPanel_4D7
        mov eax, dword [byte ebp-026h]
        mov dword [byte eax+04h], 100h
        imul eax, dword [ViewScreenWidth], dword 1F4h
        mov ebx, 280h
        cdq
        idiv ebx
        mov ebx, eax
        imul eax, dword [ViewScreenHeight], byte 5Ah
        mov ecx, 190h
        cdq
        idiv ecx
        push byte 20h
        push eax
        push ebx
        mov ebx, dword [byte ebp-026h]
        call CreateBitmap
        mov dword [ebx], eax
        mov eax, dword [byte ebp-02Ah]
        add esp, byte 0Ch
        mov dword [byte ebx+08h], eax
        mov eax, 30h
        call GetLangText
        push eax
        movsx eax, word [gsp]
        add eax, byte 2Ch
        call GetLangText
        push eax
        push str_SS
        lea eax, [byte ebp+07Eh]
        push eax
        call sprintf_
        add esp, byte 10h
        movzx eax, byte [PeriodAwayTeam]
        push eax
        mov eax, dword [AwScore]
        call TeamNameField
        push eax
        push str_SD
        lea eax, [byte ebp+02Eh]
        push eax
        call sprintf_
        add esp, byte 10h
        movzx eax, byte [PeriodHomeTeam]
        push eax
        mov eax, dword [HmScore]
        call TeamNameField
        push eax
        push str_SD
        lea eax, [byte ebp-022h]
        push eax
        lea ecx, [byte ebp+02Eh]
        call sprintf_
        add esp, byte 10h
        lea eax, [byte ebp-022h]
        mov edx, 2
        push eax
        mov eax, dword [ebx]
        lea ebx, [byte ebp+07Eh]
        jmp near DrawPenaltyShotPanel_49A
;-----------------------------------------------------------------------------
; DrawGoalScorerPanel                          17818  97 PC, medium confidence
; Overlay panel kind 2: the goal scorer ("Goal", "Shorthanded", "Empty Net",
; "Unassisted"; "%s - #%d %c. %s")
;-----------------------------------------------------------------------------
DrawGoalScorerPanel:
        push esi
        push edi
        enter 0F8h, 0
        push eax
        push ebx
        sub ebp, 82h
        mov edx, ecx
        mov ecx, 14h
        lea edi, [byte ebp-026h]
        mov esi, GoalScorerPanelBlank
        mov eax, 100h
        rep movsd
        call RemoveOverlayPanel
        mov eax, dword [byte ebp-07Ah]
        mov dword [byte eax+04h], 100h
        add dword [edx], byte 4
        mov eax, dword [edx]
        add eax, byte 4
        mov di, word [byte eax-08h]
        mov dword [edx], eax
        add eax, byte 4
        mov bx, word [byte eax-08h]
        mov dword [edx], eax
        add eax, byte 4
        mov si, word [byte eax-08h]
        mov dword [edx], eax
        add eax, byte 4
        mov cx, word [byte eax-08h]
        mov dword [edx], eax
        mov ax, word [byte eax-04h]
        mov edx, dword [byte ebp-07Ah]
        mov dword [byte ebp+07Ah], eax
        mov eax, dword [byte ebp-07Eh]
        mov word [byte ebp+07Eh], cx
        mov dword [byte edx+08h], eax
        cmp word [byte ebp+07Ah], byte 0
        je short .1
        mov eax, dword [AwScore]
        jmp short .2
.1:
        mov eax, dword [HmScore]
.2:
        mov ecx, eax
        cmp di, byte 19h
        jge short .5
        movsx edi, di
        imul edi, dword 125h
        add eax, 0A3h
        add eax, edi
        lea edx, [byte eax+08h]
        cmp dword [ViewScreenHeight], 12Ch
        jge short .4
.3:
        push edx
        movzx edx, byte [byte eax+018h]
        push edx
        movzx eax, byte [dword eax+0BCh]
        push eax
        mov eax, 23h
        call GetLangText
        push eax
        push str_SDCS
        jmp short .6
.4:
        push edx
        lea edx, [byte eax+018h]
        push edx
        movzx eax, byte [dword eax+0BCh]
        push eax
        mov eax, 23h
        call GetLangText
        push eax
        push str_SDSS
        jmp short .6
.5:
        movsx edi, di
        lea edx, [byte edi-019h]
        imul edx, dword 125h
        add eax, 1D42h
        add eax, edx
        lea edx, [byte eax+08h]
        cmp dword [ViewScreenHeight], 12Ch
        jl short .3
        push edx
        lea edx, [byte eax+018h]
        push edx
        movzx eax, byte [dword eax+0BCh]
        push eax
        mov eax, 23h
        call GetLangText
        push eax
        push str_SDSS
.6:
        lea eax, [byte ebp-076h]
        push eax
        call sprintf_
        add esp, byte 18h
        mov byte [byte ebp-026h], 0
        test byte [byte ebp+07Eh], 1
        je short .7
        mov eax, 24h
        jmp short .8
.7:
        test byte [byte ebp+07Eh], 2
        je short .9
        mov eax, 25h
.8:
        call GetLangText
        mov edx, eax
        lea eax, [byte ebp-026h]
        call strcpy_
.9:
        test byte [byte ebp+07Eh], 4
        je short .11
        cmp byte [byte ebp-026h], 0
        je short .10
        mov edx, str_Punct
        lea eax, [byte ebp-026h]
        call strcat_
.10:
        mov eax, 26h
        call GetLangText
        mov edx, eax
        lea eax, [byte ebp-026h]
        call strcat_
.11:
        mov edx, str_Punct_DrawGoalScorerPanel
        lea eax, [byte ebp+02Ah]
        call strcpy_
        test bx, bx
        jl near .16
        cmp bx, byte 19h
        jge short .12
        movsx eax, bx
        imul eax, dword 125h
        lea edx, [dword ecx+0A3h]
        jmp short .13
.12:
        movsx eax, bx
        sub eax, byte 19h
        imul eax, dword 125h
        lea edx, [dword ecx+01D42h]
.13:
        add eax, edx
        lea edx, [byte eax+08h]
        lea eax, [byte ebp+02Ah]
        call strcat_
        test si, si
        jl short .18
        mov edx, str_CommaSpace
        lea eax, [byte ebp+02Ah]
        call strcat_
        cmp si, byte 19h
        jge short .15
        movsx eax, si
        imul edx, eax, dword 125h
        lea eax, [dword ecx+0A3h]
        add eax, edx
.14:
        lea edx, [byte eax+08h]
        jmp short .17
.15:
        movsx eax, si
        sub eax, byte 19h
        imul eax, dword 125h
        add ecx, 1D42h
        add eax, ecx
        jmp short .14
.16:
        mov eax, 27h
        call GetLangText
        mov edx, eax
.17:
        lea eax, [byte ebp+02Ah]
        call strcat_
.18:
        mov edx, str_CloseParen
        lea eax, [byte ebp+02Ah]
        call strcat_
        imul eax, dword [ViewScreenHeight], byte 5Ah
        mov ebx, 190h
        cdq
        idiv ebx
        push byte 20h
        push eax
        imul eax, dword [ViewScreenWidth], dword 1F4h
        mov ebx, 280h
        cdq
        idiv ebx
        push eax
        call CreateBitmap
        mov edx, dword [byte ebp-07Ah]
        add esp, byte 0Ch
        mov dword [edx], eax
        lea eax, [byte ebp-026h]
        push eax
        mov eax, dword [byte ebp+07Ah]
        xor al, 1
        movsx edx, ax
        mov eax, dword [byte ebp-07Ah]
        lea ebx, [byte ebp-076h]
        lea ecx, [byte ebp+02Ah]
        mov eax, dword [eax]
        call DrawPanelPlayerCard
        cmp dword [VideoModeChanged], byte 0
        sete al
        movzx eax, al
        mov ecx, eax
        mov eax, dword [byte ebp-07Ah]
        mov eax, dword [eax]
        mov ebx, dword [byte eax+02Ch]
        imul eax, dword [ViewScreenHeight], dword 140h
        mov edi, 190h
        cdq
        idiv edi
        jmp near DrawPenaltyPanel_26F
;-----------------------------------------------------------------------------
; DrawGameClock                                17AD1  96 PC, medium confidence
; Draws the game clock "%2d:%02d" (or "%2d.%01d" under a minute)
;-----------------------------------------------------------------------------
DrawGameClock:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 14h, 0
        mov ebx, eax
        cmp word [gameclock], byte 3Ch
        jle short .1
        movsx eax, word [gameclock]
        cmp eax, dword [ClockShownMinutes]
        je near PrevVideoModeKey_216
.1:
        cmp word [gameclock], byte 3Dh
        jge short .2
        movsx eax, word [StatsPanelOn]
        cmp eax, dword [ClockShownSeconds]
        je near PrevVideoModeKey_216
.2:
        movsx eax, word [gameclock]
        mov dword [ClockShownMinutes], eax
        movsx eax, word [StatsPanelOn]
        push ebx
        mov dword [ClockShownSeconds], eax
        call SetDrawTarget
        add esp, byte 4
        cmp dword [ViewScreenHeight], 12Ch
        jge short .3
        push dword [ClockFontSmall]
        jmp short .4
.3:
        push dword [ClockShown]
.4:
        call SelectFont
        add esp, byte 4
        cmp word [gameclock], byte 3Bh
        jne short .5
        push dword 0FEh
        call ClearScreen
        add esp, byte 4
.5:
        push dword 0FEh
        push dword 0FFFFFF50h
        call MatchColor
        add esp, byte 4
        push eax
        call SetTextColors
        movsx ecx, word [gameclock]
        mov eax, ecx
        mov esi, 3Ch
        cdq
        idiv esi
        mov esi, eax
        mov eax, ecx
        mov edi, 3Ch
        cdq
        idiv edi
        add esp, byte 8
        mov ecx, edx
        test esi, esi
        jle short .6
        push edx
        push esi
        push str_2d02d
        jmp short .7
.6:
        movsx eax, word [StatsPanelOn]
        imul eax, byte 0Ah
        cdq
        shl edx, 4
        LD sbb, eax, edx
        sar eax, 4
        push eax
        push ecx
        push str_2d01d
.7:
        lea eax, [byte ebp-014h]
        push eax
        call sprintf_
        add esp, byte 10h
        imul eax, dword [ViewScreenWidth], byte 6
        mov ecx, 280h
        cdq
        idiv ecx
        imul esi, dword [ViewScreenHeight], byte 0Eh
        mov ecx, eax
        mov eax, esi
        mov edi, 190h
        cdq
        idiv edi
        cmp dword [ViewScreenHeight], 12Ch
        jge short .8
        push eax
        add ecx, byte 0Ah
        jmp short .9
.8:
        push eax
.9:
        push ecx
        lea eax, [byte ebp-014h]
        push eax
        call DrawTextBoxedAt
        add esp, byte 0Ch
        mov eax, dword [byte ebx+02Ch]
        call RefreshOverlayWindow
        jmp near PrevVideoModeKey_216
;-----------------------------------------------------------------------------
; DrawPowerPlayClock                              17C2C  97 PC, low confidence
; Draws the "Power Play" countdown next to the game clock ("%2d:%02d")
;-----------------------------------------------------------------------------
DrawPowerPlayClock:
        push ebx
        push ecx
        push edx
        push esi
        enter 14h, 0
        mov ebx, eax
        movsx eax, word [gameclock]
        cmp eax, dword [ClockShownMinutes]
        je near DrawPowerPlayClock_18E
        mov dword [ClockShownMinutes], eax
        call GetLowestPen
        movsx esi, ax
        test esi, esi
        jne short .1
        mov eax, 700h
        call RemoveOverlayPanel
        jmp near DrawPowerPlayClock_18E
.1:
        push ebx
        call SetDrawTarget
        add esp, byte 4
        cmp dword [ViewScreenHeight], 12Ch
        jge short .2
        push dword [ClockFontLarge]
        jmp short .3
.2:
        push dword [ClockShown]
.3:
        call SelectFont
        add esp, byte 4
        imul eax, dword [ViewScreenHeight], byte 14h
        mov ecx, 190h
        cdq
        idiv ecx
        mov edx, dword [byte ebx+04h]
        sub edx, eax
        imul eax, dword [ViewScreenWidth], byte 64h
        push dword 0FEh
        mov ecx, 280h
        push edx
        cdq
        idiv ecx
        push eax
        imul eax, dword [ViewScreenHeight], byte 0Ah
        mov ecx, 190h
        cdq
        idiv ecx
        push eax
        push byte 0
        call FillRect
        add esp, byte 14h
        push dword 0FEh
        push dword 0FFFFFF50h
        call MatchColor
        add esp, byte 4
        push eax
        call SetTextColors
        mov eax, esi
        mov ecx, 3Ch
        cdq
        idiv ecx
        add esp, byte 8
        mov eax, esi
        push edx
        cdq
        idiv ecx
        push eax
        push str_2d02d
        lea eax, [byte ebp-014h]
        push eax
        call sprintf_
        imul eax, dword [ViewScreenHeight], byte 18h
        mov esi, 190h
        cdq
        idiv esi
        add esp, byte 10h
        push eax
        imul eax, dword [ViewScreenWidth], byte 6
        mov ecx, 280h
        cdq
        idiv ecx
        push eax
        lea eax, [byte ebp-014h]
        push eax
        call DrawTextBoxedAt
        add esp, byte 0Ch
        call SetOverlayFont
        cmp dword [ViewScreenHeight], 12Ch
        jge short .4
        mov eax, 36h
        call GetLangText
        push eax
        imul eax, dword [ViewScreenHeight], byte 37h
        cdq
        idiv esi
        push eax
        imul eax, dword [ViewScreenWidth], byte 6
        mov esi, 280h
        cdq
        idiv esi
        push eax
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        jmp short .5
.4:
        imul eax, dword [ViewScreenHeight], byte 37h
        cdq
        idiv esi
        push eax
        imul eax, dword [ViewScreenWidth], byte 6
        mov ecx, 280h
        cdq
        idiv ecx
        push eax
        mov eax, 36h
        call GetLangText
        push eax
        call DrawTextAt
        add esp, byte 0Ch
.5:
        mov eax, dword [byte ebx+02Ch]
        call RefreshOverlayWindow
DrawPowerPlayClock_18E:
        leave
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawClockPanel                                  17DC0  96 PC, low confidence
; The clock panel (overlay kind table ClockPanelFunc entry 0): removes panels
; 300h / 700h and draws the clock (DrawGameClock)
;-----------------------------------------------------------------------------
DrawClockPanel:
        push esi
        push edi
        mov esi, eax
        mov edi, ebx
        mov eax, 300h
        call RemoveOverlayPanel
        mov eax, 700h
        mov dword [byte esi+04h], 300h
        call RemoveOverlayPanel
        imul eax, dword [ViewScreenWidth], byte 64h
        mov ebx, 280h
        cdq
        idiv ebx
        mov ebx, eax
        imul eax, dword [ViewScreenHeight], byte 37h
        mov ecx, 190h
        cdq
        idiv ecx
        push byte 20h
        push eax
        push ebx
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [esi], eax
        call SetDrawTarget
        add esp, byte 4
        push dword 0FEh
        call ClearScreen
        mov dword [byte esi+08h], edi
        mov dword [ClockShownMinutes], 0FFFFFFFFh
        add esp, byte 4
        mov eax, dword [esi]
        call DrawGameClock
        mov dword [ClockShownMinutes], 0FFFFFFFFh
        cmp dword [ReplayPlaying], byte 0
        je short .1
        cmp dword [VideoModeChanged], byte 0
        sete al
        movzx eax, al
        mov ecx, eax
        mov eax, dword [esi]
        mov ebx, dword [byte eax+02Ch]
        imul eax, dword [ViewScreenHeight], dword 0F0h
        jmp short .2
.1:
        cmp dword [VideoModeChanged], byte 0
        sete al
        movzx eax, al
        mov ecx, eax
        mov eax, dword [esi]
        mov ebx, dword [byte eax+02Ch]
        imul eax, dword [ViewScreenHeight], dword 140h
.2:
        mov esi, 190h
        cdq
        idiv esi
        mov esi, eax
        imul eax, dword [ViewScreenWidth], dword 1F4h
        mov edi, 280h
        cdq
        idiv edi
        shl ecx, 4
        or cl, 8
        mov edx, esi
        call AddOverlayWindow
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; PowerPlayPanel                                  17EB6  97 PC, low confidence
; Draws the power play overlay: team, time left on the penalty and players in
; the box
;-----------------------------------------------------------------------------
PowerPlayPanel:
        push esi
        push edi
        enter 8, 0
        mov esi, eax
        mov dword [byte ebp-08h], ebx
        mov eax, 700h
        call RemoveOverlayPanel
        mov dword [byte esi+04h], 700h
        add dword [ecx], byte 4
        mov eax, dword [ecx]
        cmp word [byte eax-04h], byte 0
        setl al
        movzx edi, al
        imul eax, dword [ViewScreenWidth], dword 0BEh
        mov ebx, 280h
        cdq
        idiv ebx
        mov ebx, eax
        imul eax, dword [ViewScreenHeight], byte 4Bh
        mov ecx, 190h
        cdq
        idiv ecx
        push byte 20h
        push eax
        push ebx
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [esi], eax
        call SetDrawTarget
        add esp, byte 4
        push dword 0FEh
        call ClearScreen
        imul eax, dword [ViewScreenHeight], byte 0Ah
        mov ecx, 190h
        cdq
        idiv ecx
        add esp, byte 4
        push dword 0FFh
        push eax
        push ebx
        push byte 0
        push byte 0
        mov dword [ClockShownMinutes], 0
        call FillRect
        imul eax, dword [ViewScreenHeight], byte 0Ah
        mov ecx, 190h
        cdq
        idiv ecx
        add esp, byte 14h
        push dword 0FFh
        push eax
        imul eax, dword [ViewScreenHeight], byte 41h
        cdq
        idiv ecx
        push ebx
        push eax
        push byte 0
        call FillRect
        imul eax, dword [ViewScreenWidth], dword 96h
        mov ebx, 280h
        cdq
        idiv ebx
        imul ecx, dword [ViewScreenHeight], byte 28h
        mov ebx, eax
        mov eax, ecx
        mov dword [byte ebp-04h], 190h
        cdq
        idiv dword [byte ebp-04h]
        add esp, byte 14h
        cmp dword [ViewScreenHeight], 12Ch
        jle short .1
        push eax
        push ebx
        push dword 3F000000h
        jmp short .2
.1:
        push eax
        push ebx
        push dword 3E4CCCCDh
.2:
        test edi, edi
        sete al
        movzx eax, al
        call DrawPanelArtScaled
        mov eax, dword [byte ebp-08h]
        mov dword [byte esi+08h], eax
        mov eax, dword [esi]
        call DrawPowerPlayClock
        cmp dword [VideoModeChanged], byte 0
        sete al
        movzx eax, al
        mov ecx, eax
        mov eax, dword [esi]
        mov ebx, dword [byte eax+02Ch]
        imul eax, dword [ViewScreenHeight], dword 140h
        mov esi, 190h
        cdq
        idiv esi
        mov esi, eax
        imul eax, dword [ViewScreenWidth], dword 1C2h
        mov edi, 280h
        cdq
        idiv edi
        shl ecx, 4
        or cl, 8
        mov edx, esi
        jmp near DrawMessagePanel_15F
;-----------------------------------------------------------------------------
; UpdateScoreboardPanel                           18025  97 PC, low confidence
; Redraws the score and clock overlay when the score, period or time changes
;-----------------------------------------------------------------------------
UpdateScoreboardPanel:
        push ebx
        push ecx
        push esi
        push edi
        enter 28h, 0
        mov ebx, eax
        mov dword [byte ebp-08h], edx
        mov eax, edx
        shl eax, 2
        movsx edx, word [gameclock]
        cmp edx, dword [dword eax+ScorePanelHome]
        jne short .1
        mov ecx, dword [byte ebp-08h]
        movsx edx, word [nosplit ecx*2+HomeSkaters]
        cmp edx, dword [dword eax+ScorePanelValues]
        je near .57
.1:
        mov eax, dword [byte ebp-08h]
        movsx edx, word [gameclock]
        mov dword [nosplit eax*4+ScorePanelHome], edx
        movsx edx, word [nosplit eax*2+HomeSkaters]
        movsx esi, word [AwPlayersInBox]
        mov dword [nosplit eax*4+ScorePanelValues], edx
        movsx eax, word [HmPlayersInBox]
        sub eax, esi
        mov esi, eax
        call SetOverlayFont
        push ebx
        call SetDrawTarget
        imul eax, dword [ViewScreenWidth], byte 64h
        mov ecx, 280h
        cdq
        idiv ecx
        add esp, byte 4
        mov ecx, eax
        cmp dword [byte ebp-08h], byte 0
        je short .2
        mov eax, dword [byte ebx+02Ch]
        push dword 0FFh
        movsx eax, word [byte eax+06h]
        push eax
        push ecx
        push byte 0
        push byte 0
        call FillRect
        add esp, byte 14h
        mov eax, dword [byte ebx+02Ch]
        push dword 0FEh
        movsx eax, word [byte eax+06h]
        test esi, esi
        setne dl
        movzx edx, dl
        lea ecx, [byte edx+01h]
        cdq
        idiv ecx
        push eax
        imul eax, dword [ViewScreenWidth], byte 64h
        mov ecx, 280h
        cdq
        idiv ecx
        push eax
        push byte 0
        push byte 0
        jmp short .3
.2:
        mov eax, dword [byte ebx+02Ch]
        push dword 0FFh
        movsx eax, word [byte eax+06h]
        push eax
        imul eax, dword [ViewScreenWidth], byte 3Ch
        push ecx
        mov ecx, 280h
        cdq
        idiv ecx
        push byte 0
        push eax
        call FillRect
        add esp, byte 14h
        mov eax, dword [byte ebx+02Ch]
        push dword 0FEh
        movsx eax, word [byte eax+06h]
        test esi, esi
        setne dl
        movzx edx, dl
        lea ecx, [byte edx+01h]
        cdq
        idiv ecx
        push eax
        imul eax, dword [ViewScreenWidth], byte 64h
        mov ecx, 280h
        cdq
        idiv ecx
        push eax
        imul eax, dword [ViewScreenWidth], byte 3Ch
        cdq
        idiv ecx
        push byte 0
        push eax
.3:
        call FillRect
        add esp, byte 14h
        test esi, esi
        jne short .4
        mov dword [byte ebp-014h], 3
        mov dword [byte ebp-010h], esi
        jmp short .8
.4:
        jle short .5
        cmp dword [byte ebp-08h], byte 0
        je short .6
.5:
        test esi, esi
        jge short .7
        cmp dword [byte ebp-08h], byte 0
        je short .7
.6:
        mov dword [byte ebp-014h], 5
        mov dword [byte ebp-010h], 4
        jmp short .8
.7:
        mov dword [byte ebp-014h], 7
        mov dword [byte ebp-010h], 6
.8:
        mov eax, dword [byte ebp-010h]
        xor esi, esi
        mov dword [byte ebp-0Ch], eax
        jmp near .56
.9:
        movsx edx, word [byte ebp-0Ch]
        movsx eax, word [byte ebp-08h]
        call TeamLineSlots
        movsx edi, ax
        cmp edi, 0BB8h
        jle short .10
        push dword 0FF00AA00h
        jmp short .13
.10:
        cmp edi, 7D0h
        jle short .11
        push dword 0FFFFFF50h
        jmp short .13
.11:
        cmp edi, 3E8h
        jle short .12
        push dword 0FFFF8000h
        jmp short .13
.12:
        push dword 0FFAA0000h
.13:
        call MatchColor
        add esp, byte 4
        mov ecx, eax
        imul eax, edi, byte 64h
        cdq
        shl edx, 0Ch
        LD sbb, eax, edx
        sar eax, 0Ch
        mov edi, eax
        cmp dword [byte ebp-08h], byte 0
        je near .18
        push ecx
        cmp dword [ViewScreenHeight], 12Ch
        jge short .14
        mov eax, 0Ah
        jmp short .15
.14:
        mov eax, 0Eh
.15:
        push eax
        mov eax, dword [ViewScreenWidth]
        imul eax, edi
        mov ecx, 280h
        cdq
        idiv ecx
        push eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .16
        mov ecx, 0Ah
        jmp short .17
.16:
        mov ecx, 0Eh
.17:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov dword [byte ebp-04h], 190h
        cdq
        idiv dword [byte ebp-04h]
        mov edx, esi
        add eax, ecx
        imul edx, eax
        mov eax, dword [ViewScreenHeight]
        mov ecx, 190h
        shl eax, 2
        mov dword [byte ebp-04h], edx
        cdq
        idiv ecx
        add eax, dword [byte ebp-04h]
        push eax
        mov eax, dword [ViewScreenWidth]
        imul eax, edi
        mov ecx, 280h
        cdq
        idiv ecx
        mov ecx, eax
        imul eax, dword [ViewScreenWidth], byte 64h
        mov dword [byte ebp-04h], 280h
        cdq
        idiv dword [byte ebp-04h]
        sub eax, ecx
        jmp near .23
.18:
        push ecx
        cmp dword [ViewScreenHeight], 12Ch
        jge short .19
        mov eax, 0Ah
        jmp short .20
.19:
        mov eax, 0Eh
.20:
        push eax
        mov eax, dword [ViewScreenWidth]
        imul eax, edi
        mov ecx, 280h
        cdq
        idiv ecx
        push eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .21
        mov ecx, 0Ah
        jmp short .22
.21:
        mov ecx, 0Eh
.22:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov dword [byte ebp-04h], 190h
        cdq
        idiv dword [byte ebp-04h]
        add ecx, eax
        mov eax, dword [ViewScreenHeight]
        shl eax, 2
        mov dword [byte ebp-04h], 190h
        cdq
        idiv dword [byte ebp-04h]
        imul ecx, esi
        add eax, ecx
        push eax
        imul eax, dword [ViewScreenWidth], byte 3Ch
        mov ecx, 280h
        cdq
        idiv ecx
.23:
        push eax
        call FillRect
        add esp, byte 14h
        mov eax, dword [byte ebp-08h]
        movsx eax, word [nosplit eax*2+HomeSkaters]
        cmp eax, dword [byte ebp-0Ch]
        jne near .38
        cmp dword [byte ebp-08h], byte 0
        je near .30
        push byte 0FFFFFFFFh
        call MatchColor
        add esp, byte 4
        push eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .24
        mov ecx, 0Ah
        jmp short .25
.24:
        mov ecx, 0Eh
.25:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov dword [byte ebp-04h], 190h
        cdq
        idiv dword [byte ebp-04h]
        mov edx, esi
        add eax, ecx
        imul edx, eax
        mov eax, dword [ViewScreenHeight]
        mov ecx, 190h
        shl eax, 2
        mov dword [byte ebp-04h], edx
        cdq
        idiv ecx
        mov edx, dword [byte ebp-04h]
        add edx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .26
        mov eax, 0Ah
        jmp short .27
.26:
        mov eax, 0Eh
.27:
        add eax, edx
        dec eax
        push eax
        imul eax, dword [ViewScreenWidth], byte 64h
        mov ecx, 280h
        cdq
        idiv ecx
        dec eax
        push eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .28
        mov ecx, 0Ah
        jmp short .29
.28:
        mov ecx, 0Eh
.29:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov dword [byte ebp-04h], 190h
        cdq
        idiv dword [byte ebp-04h]
        add eax, ecx
        mov ecx, esi
        imul ecx, eax
        mov eax, dword [ViewScreenHeight]
        shl eax, 2
        mov dword [byte ebp-04h], 190h
        cdq
        idiv dword [byte ebp-04h]
        add eax, ecx
        push eax
        mov eax, dword [ViewScreenWidth]
        imul eax, edi
        mov ecx, 280h
        cdq
        idiv ecx
        mov ecx, eax
        imul eax, dword [ViewScreenWidth], byte 64h
        mov edi, 280h
        cdq
        idiv edi
        sub eax, ecx
        jmp near .37
.30:
        push byte 0FFFFFFFFh
        call MatchColor
        add esp, byte 4
        push eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .31
        mov ecx, 0Ah
        jmp short .32
.31:
        mov ecx, 0Eh
.32:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov dword [byte ebp-04h], 190h
        cdq
        idiv dword [byte ebp-04h]
        add ecx, eax
        mov eax, dword [ViewScreenHeight]
        shl eax, 2
        mov dword [byte ebp-04h], 190h
        cdq
        idiv dword [byte ebp-04h]
        imul ecx, esi
        add ecx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .33
        mov eax, 0Ah
        jmp short .34
.33:
        mov eax, 0Eh
.34:
        add eax, ecx
        dec eax
        push eax
        mov eax, dword [ViewScreenWidth]
        imul eax, edi
        mov ecx, 280h
        cdq
        idiv ecx
        mov ecx, eax
        imul eax, dword [ViewScreenWidth], byte 3Ch
        mov edi, 280h
        cdq
        idiv edi
        add eax, ecx
        dec eax
        push eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .35
        mov ecx, 0Ah
        jmp short .36
.35:
        mov ecx, 0Eh
.36:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov edi, 190h
        cdq
        idiv edi
        mov edi, esi
        add eax, ecx
        imul edi, eax
        mov eax, dword [ViewScreenHeight]
        shl eax, 2
        mov ecx, 190h
        cdq
        idiv ecx
        add eax, edi
        push eax
        imul eax, dword [ViewScreenWidth], byte 3Ch
        mov ecx, 280h
        cdq
        idiv ecx
.37:
        push eax
        call FillRectCorners
        add esp, byte 14h
.38:
        lea eax, [byte esi+01h]
        cmp dword [byte ebp-0Ch], byte 4
        jge short .39
        push eax
        mov eax, 22h
        jmp short .41
.39:
        cmp dword [byte ebp-0Ch], byte 6
        jge short .40
        push eax
        mov eax, 2Ah
        jmp short .41
.40:
        push eax
        mov eax, 2Bh
.41:
        call GetLangText
        push eax
        push str_SD2
        lea eax, [byte ebp-028h]
        push eax
        call sprintf_
        add esp, byte 10h
        cmp dword [byte ebp-08h], byte 0
        je near .48
        cmp dword [ViewScreenHeight], 12Ch
        jge short .45
        lea eax, [byte ebp-028h]
        push eax
        jge short .42
        mov ecx, 0Ah
        jmp short .43
.42:
        mov ecx, 0Eh
.43:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov edi, 190h
        cdq
        idiv edi
        mov edi, esi
        add eax, ecx
        imul edi, eax
        mov eax, dword [ViewScreenHeight]
        shl eax, 2
        mov ecx, 190h
        cdq
        idiv ecx
        add eax, edi
        push eax
        push byte 0
.44:
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        jmp near .55
.45:
        jge short .46
        mov ecx, 0Ah
        jmp short .47
.46:
        mov ecx, 0Eh
.47:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov edi, 190h
        cdq
        idiv edi
        mov edi, esi
        add eax, ecx
        imul edi, eax
        mov eax, dword [ViewScreenHeight]
        shl eax, 2
        mov ecx, 190h
        cdq
        idiv ecx
        add eax, edi
        push eax
        push byte 0
        jmp near .54
.48:
        cmp dword [ViewScreenHeight], 12Ch
        jge short .51
        lea eax, [byte ebp-028h]
        push eax
        jge short .49
        mov ecx, 0Ah
        jmp short .50
.49:
        mov ecx, 0Eh
.50:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov edi, 190h
        cdq
        idiv edi
        add eax, ecx
        mov ecx, esi
        imul ecx, eax
        mov eax, dword [ViewScreenHeight]
        shl eax, 2
        cdq
        idiv edi
        add eax, ecx
        push eax
        imul eax, dword [ViewScreenWidth], dword 0A0h
        mov ecx, 280h
        cdq
        idiv ecx
        mov edi, eax
        lea eax, [byte ebp-028h]
        push eax
        call MeasureText
        add esp, byte 4
        sub edi, eax
        push edi
        jmp near .44
.51:
        jge short .52
        mov ecx, 0Ah
        jmp short .53
.52:
        mov ecx, 0Eh
.53:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov edi, 190h
        cdq
        idiv edi
        mov edi, esi
        add eax, ecx
        imul edi, eax
        mov eax, dword [ViewScreenHeight]
        shl eax, 2
        mov ecx, 190h
        cdq
        idiv ecx
        add eax, edi
        push eax
        imul eax, dword [ViewScreenWidth], dword 0A0h
        mov ecx, 280h
        cdq
        idiv ecx
        mov edi, eax
        lea eax, [byte ebp-028h]
        push eax
        call MeasureText
        add esp, byte 4
        sub edi, eax
        push edi
.54:
        lea eax, [byte ebp-028h]
        push eax
        call DrawTextAt
        add esp, byte 0Ch
.55:
        inc dword [byte ebp-0Ch]
        inc esi
.56:
        mov eax, dword [byte ebp-014h]
        sub eax, dword [byte ebp-010h]
        cmp esi, eax
        jle near .9
        mov eax, dword [byte ebx+02Ch]
        call RefreshOverlayWindow
.57:
        leave
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; HomeTeamPanel                                   1870B  97 PC, low confidence
; Draws the home team overlay panel (name, logo, score)
;-----------------------------------------------------------------------------
HomeTeamPanel:
        push esi
        push edi
        enter 4, 0
        mov esi, eax
        mov edi, ebx
        cmp dword [eax], byte 0
        jne near .5
        mov eax, 500h
        call RemoveOverlayPanel
        mov eax, 501h
        call RemoveOverlayPanel
        mov dword [byte esi+04h], 500h
        imul eax, dword [ViewScreenWidth], dword 0A0h
        mov ebx, 280h
        cdq
        idiv ebx
        mov ecx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .1
        mov ebx, 0Ah
        jmp short .2
.1:
        mov ebx, 0Eh
.2:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov dword [byte ebp-04h], 190h
        cdq
        idiv dword [byte ebp-04h]
        add ebx, eax
        push byte 20h
        shl ebx, 2
        push ebx
        push ecx
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [esi], eax
        push dword [esi]
        mov dword [byte esi+08h], edi
        call SetDrawTarget
        add esp, byte 4
        push dword 0FFh
        call ClearScreen
        imul eax, dword [ViewScreenWidth], byte 1Eh
        mov ecx, 280h
        cdq
        idiv ecx
        sar ebx, 1
        add esp, byte 4
        cmp dword [ViewScreenHeight], 12Ch
        jle short .3
        push ebx
        push eax
        mov eax, 1
        push dword 3E800000h
        jmp short .4
.3:
        push ebx
        push eax
        mov eax, 1
        push dword 3DCCCCCDh
.4:
        call DrawPanelArtScaled
        mov dword [ScorePanelValues], 0FFFFFFFFh
        xor edx, edx
        mov eax, dword [esi]
        call UpdateScoreboardPanel
        cmp dword [VideoModeChanged], byte 0
        sete al
        movzx eax, al
        mov ecx, eax
        mov eax, dword [esi]
        mov ebx, dword [byte eax+02Ch]
        imul eax, dword [ViewScreenHeight], byte 28h
        mov esi, 190h
        cdq
        idiv esi
        shl ecx, 4
        or cl, 8
        mov edx, eax
        xor eax, eax
        call AddOverlayWindow
.5:
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; AwayTeamPanel                                   1882A  97 PC, low confidence
; Draws the away team overlay panel (name, logo, score)
;-----------------------------------------------------------------------------
AwayTeamPanel:
        push esi
        push edi
        enter 4, 0
        mov esi, eax
        cmp dword [eax], byte 0
        jne near .5
        mov eax, 600h
        call RemoveOverlayPanel
        mov eax, 601h
        call RemoveOverlayPanel
        mov dword [byte esi+04h], 600h
        imul eax, dword [ViewScreenWidth], dword 0A0h
        mov ecx, 280h
        cdq
        idiv ecx
        mov ecx, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .1
        mov edi, 0Ah
        jmp short .2
.1:
        mov edi, 0Eh
.2:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov dword [byte ebp-04h], 190h
        cdq
        idiv dword [byte ebp-04h]
        add edi, eax
        push byte 20h
        shl edi, 2
        push edi
        push ecx
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [esi], eax
        call SetDrawTarget
        add esp, byte 4
        push dword 0FFh
        call ClearScreen
        imul eax, dword [ViewScreenWidth], dword 82h
        mov ecx, 280h
        cdq
        idiv ecx
        sar edi, 1
        add esp, byte 4
        cmp dword [ViewScreenHeight], 12Ch
        jle short .3
        push edi
        push eax
        xor eax, eax
        push dword 3E800000h
        jmp short .4
.3:
        push edi
        push eax
        xor eax, eax
        push dword 3DCCCCCDh
.4:
        call DrawPanelArtScaled
        mov dword [byte esi+08h], ebx
        mov dword [AwayPanelValue], 0FFFFFFFFh
        mov edx, 1
        mov eax, dword [esi]
        call UpdateScoreboardPanel
        cmp dword [VideoModeChanged], byte 0
        sete al
        movzx eax, al
        mov ecx, eax
        mov eax, dword [esi]
        mov ebx, dword [byte eax+02Ch]
        imul eax, dword [ViewScreenHeight], byte 28h
        mov esi, 190h
        cdq
        idiv esi
        mov esi, eax
        imul eax, dword [ViewScreenWidth], dword 1E0h
        mov edi, 280h
        cdq
        idiv edi
        shl ecx, 4
        or cl, 8
        mov edx, esi
        call AddOverlayWindow
.5:
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; HomeStatPanel                                   18958  97 PC, low confidence
; Draws the home team statistics overlay (shots, goals, power play)
;-----------------------------------------------------------------------------
HomeStatPanel:
        push esi
        push edi
        enter 28h, 0
        mov esi, eax
        mov dword [byte ebp-08h], ebx
        call SetOverlayFont
        cmp dword [esi], byte 0
        jne near .14
        mov eax, 500h
        call RemoveOverlayPanel
        mov eax, 501h
        call RemoveOverlayPanel
        mov dword [byte esi+04h], 501h
        add dword [ecx], byte 4
        mov eax, dword [ecx]
        mov eax, dword [byte eax-04h]
        cmp eax, byte 4
        jge short .1
        inc eax
        push eax
        mov eax, 22h
        jmp short .3
.1:
        cmp eax, byte 6
        jge short .2
        sub eax, byte 3
        push eax
        mov eax, 2Ah
        jmp short .3
.2:
        sub eax, byte 5
        push eax
        mov eax, 2Bh
.3:
        call GetLangText
        push eax
        push str_SD2
        lea eax, [byte ebp-028h]
        push eax
        call sprintf_
        add esp, byte 10h
        imul eax, dword [ViewScreenWidth], dword 0A0h
        mov ebx, 280h
        cdq
        idiv ebx
        mov edi, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .4
        mov ebx, 0Ah
        jmp short .5
.4:
        mov ebx, 0Eh
.5:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov ecx, 190h
        cdq
        idiv ecx
        add ebx, eax
        push byte 20h
        lea ebx, [ebx+ebx*2]
        push ebx
        push edi
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [esi], eax
        call SetDrawTarget
        add esp, byte 4
        push dword 0FFh
        call ClearScreen
        add esp, byte 4
        push dword 0FEh
        cmp dword [ViewScreenHeight], 12Ch
        jge short .6
        mov ecx, 0Ah
        jmp short .7
.6:
        mov ecx, 0Eh
.7:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov dword [byte ebp-04h], 190h
        cdq
        idiv dword [byte ebp-04h]
        add eax, ecx
        push eax
        push edi
        cmp dword [ViewScreenHeight], 12Ch
        jge short .8
        mov ecx, 0Ah
        jmp short .9
.8:
        mov ecx, 0Eh
.9:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov edi, 190h
        cdq
        idiv edi
        add eax, ecx
        push eax
        push byte 0
        call FillRect
        mov eax, ebx
        mov ecx, 3
        cdq
        idiv ecx
        imul edi, dword [ViewScreenWidth], dword 0A0h
        mov ecx, eax
        mov eax, edi
        mov dword [byte ebp-04h], 280h
        cdq
        idiv dword [byte ebp-04h]
        add esp, byte 14h
        mov edi, eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .10
        lea eax, [byte ebp-028h]
        push eax
        push ecx
        push eax
        call MeasureText
        add esp, byte 4
        sub edi, eax
        push edi
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        jmp short .11
.10:
        push ecx
        lea eax, [byte ebp-028h]
        push eax
        call MeasureText
        add esp, byte 4
        sub edi, eax
        push edi
        lea eax, [byte ebp-028h]
        push eax
        call DrawTextAt
        add esp, byte 0Ch
.11:
        imul eax, dword [ViewScreenWidth], byte 1Eh
        mov ecx, 280h
        cdq
        idiv ecx
        sar ebx, 1
        cmp dword [ViewScreenHeight], 12Ch
        jle short .12
        push ebx
        push eax
        mov eax, 1
        push dword 3E800000h
        jmp short .13
.12:
        push ebx
        push eax
        mov eax, 1
        push dword 3DCCCCCDh
.13:
        call DrawPanelArtScaled
        mov eax, dword [byte ebp-08h]
        mov dword [byte esi+08h], eax
        cmp dword [VideoModeChanged], byte 0
        sete al
        movzx eax, al
        shl eax, 4
        or al, 8
        mov ecx, eax
        mov eax, dword [esi]
        mov ebx, dword [byte eax+02Ch]
        imul eax, dword [ViewScreenHeight], byte 28h
        mov esi, 190h
        cdq
        idiv esi
        mov edx, eax
        xor eax, eax
        call AddOverlayWindow
.14:
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; AwayStatPanel                                   18B81  97 PC, low confidence
; Draws the away team statistics overlay (shots, goals, power play)
;-----------------------------------------------------------------------------
AwayStatPanel:
        push esi
        push edi
        enter 1Ch, 0
        mov esi, eax
        mov dword [byte ebp-08h], ebx
        call SetOverlayFont
        cmp dword [esi], byte 0
        jne near .14
        mov eax, 600h
        call RemoveOverlayPanel
        mov eax, 601h
        call RemoveOverlayPanel
        mov dword [byte esi+04h], 601h
        add dword [ecx], byte 4
        imul eax, dword [ViewScreenWidth], dword 0A0h
        mov ebx, dword [ecx]
        mov ecx, 280h
        cdq
        idiv ecx
        mov ebx, dword [byte ebx-04h]
        mov dword [byte ebp-04h], eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .1
        mov ecx, 0Ah
        jmp short .2
.1:
        mov ecx, 0Eh
.2:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov edi, 190h
        cdq
        idiv edi
        add eax, ecx
        push byte 20h
        lea edi, [eax+eax*2]
        push edi
        push dword [byte ebp-04h]
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [esi], eax
        call SetDrawTarget
        add esp, byte 4
        cmp ebx, byte 4
        jge short .3
        inc ebx
        push ebx
        mov eax, 22h
        jmp short .5
.3:
        cmp ebx, byte 6
        jge short .4
        sub ebx, byte 3
        push ebx
        mov eax, 2Ah
        jmp short .5
.4:
        sub ebx, byte 5
        push ebx
        mov eax, 2Bh
.5:
        call GetLangText
        push eax
        push str_SD2
        lea eax, [byte ebp-01Ch]
        push eax
        call sprintf_
        add esp, byte 10h
        push dword 0FFh
        call ClearScreen
        add esp, byte 4
        push dword 0FEh
        cmp dword [ViewScreenHeight], 12Ch
        jge short .6
        mov ebx, 0Ah
        jmp short .7
.6:
        mov ebx, 0Eh
.7:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov ecx, 190h
        cdq
        idiv ecx
        add eax, ebx
        push eax
        push dword [byte ebp-04h]
        cmp dword [ViewScreenHeight], 12Ch
        jge short .8
        mov ebx, 0Ah
        jmp short .9
.8:
        mov ebx, 0Eh
.9:
        mov eax, dword [ViewScreenHeight]
        shl eax, 3
        mov ecx, 190h
        cdq
        idiv ecx
        add eax, ebx
        push eax
        push byte 0
        call FillRect
        mov eax, edi
        mov ebx, 3
        cdq
        idiv ebx
        add esp, byte 14h
        cmp dword [ViewScreenHeight], 12Ch
        jge short .10
        lea ebx, [byte ebp-01Ch]
        push ebx
        push eax
        push byte 0
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        jmp short .11
.10:
        push eax
        push byte 0
        lea eax, [byte ebp-01Ch]
        push eax
        call DrawTextAt
        add esp, byte 0Ch
.11:
        imul eax, dword [ViewScreenWidth], dword 82h
        mov ebx, 280h
        cdq
        idiv ebx
        sar edi, 1
        cmp dword [ViewScreenHeight], 12Ch
        jle short .12
        push edi
        push eax
        xor eax, eax
        push dword 3E800000h
        jmp short .13
.12:
        push edi
        push eax
        xor eax, eax
        push dword 3DCCCCCDh
.13:
        call DrawPanelArtScaled
        mov eax, dword [byte ebp-08h]
        mov dword [byte esi+08h], eax
        cmp dword [VideoModeChanged], byte 0
        sete al
        movzx eax, al
        mov ecx, eax
        mov eax, dword [esi]
        mov ebx, dword [byte eax+02Ch]
        imul eax, dword [ViewScreenHeight], byte 28h
        mov esi, 190h
        cdq
        idiv esi
        mov esi, eax
        imul eax, dword [ViewScreenWidth], dword 1E0h
        mov edi, 280h
        cdq
        idiv edi
        shl ecx, 4
        or cl, 8
        mov edx, esi
        call AddOverlayWindow
.14:
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; QueueOverlayPanel                            18D8A  96 PC, medium confidence
; (kind, a, b, c): puts a panel in a free slot of the 3-panel queue (kind 3
; waits 2EE0h), from BuildEventLines
;-----------------------------------------------------------------------------
QueueOverlayPanel:
        push ebx
        push ecx
        push edx
        push esi
        enter 4, 0
        cmp dword [ReplayPlaying], byte 0
        jne near DrawPowerPlayClock_18E
        mov eax, OverlayPanelQueue
        xor edx, edx
.1:
        cmp dword [eax], byte 0
        je short .2
        inc edx
        add eax, byte 0Ch
        cmp edx, byte 0Ah
        jl short .1
        xor eax, eax
.2:
        test eax, eax
        je near DrawPowerPlayClock_18E
        lea edx, [byte ebp+020h]
        mov dword [byte eax+04h], 0FFFFFFFFh
        mov dword [byte ebp-04h], edx
        mov edx, dword [byte ebp+018h]
        shl edx, 2
        cmp dword [dword edx+OverlayPanelFuncs], byte 0
        je short .3
        lea ecx, [byte ebp-04h]
        mov esi, edx
        mov ebx, dword [byte ebp+01Ch]
        mov edx, dword [byte ebp+018h]
        call dword [dword esi+OverlayPanelFuncs]
.3:
        mov dword [byte ebp-04h], 0
        jmp near DrawPowerPlayClock_18E
;-----------------------------------------------------------------------------
; OpenFreeOverlay                                 18DF7  97 PC, low confidence
; Finds a free overlay window slot, allocates its bitmap and adds it to the
; overlay list; returns the slot
;-----------------------------------------------------------------------------
OpenFreeOverlay:
        push ebx
        push ecx
        push edx
        enter 4, 0
        mov eax, OverlayPanelQueue
        xor edx, edx
.1:
        cmp dword [eax], byte 0
        je short .2
        inc edx
        add eax, byte 0Ch
        cmp edx, byte 0Ah
        jl short .1
        xor eax, eax
.2:
        test eax, eax
        je short .3
        lea ecx, [byte ebp-04h]
        mov edx, 3
        mov dword [byte eax+04h], 0FFFFFFFFh
        xor ebx, ebx
        call dword [ClockPanelFunc]
.3:
        leave
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ClearOverlayWindows                          18E35  97 PC, medium confidence
; Removes and frees all ten game overlay windows (OverlayPanelQueue),
; RemoveOverlayWindow on each
;-----------------------------------------------------------------------------
ClearOverlayWindows:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, OverlayPanelQueue
        xor esi, esi
.1:
        cmp dword [ebx], byte 0
        je short .2
        mov eax, dword [ebx]
        mov eax, dword [byte eax+02Ch]
        call RemoveOverlayWindow
        push dword [ebx]
        call FreeBitmap
        add esp, byte 4
.2:
        inc esi
        mov dword [ebx], 0
        add ebx, byte 0Ch
        cmp esi, byte 0Ah
        jl short .1
        mov word [MessagePanel], 0FFFFh
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; RefreshOverlayWindows                        18E76  97 PC, medium confidence
; Asks every open overlay window to be drawn again
;-----------------------------------------------------------------------------
RefreshOverlayWindows:
        push ebx
        push edx
        mov edx, OverlayPanelQueue
        xor ebx, ebx
.1:
        cmp dword [edx], byte 0
        je short .2
        mov eax, dword [edx]
        mov eax, dword [byte eax+02Ch]
        call RefreshOverlayWindow
.2:
        inc ebx
        add edx, byte 0Ch
        cmp ebx, byte 0Ah
        jl short .1
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ChkShowStatsPanel                               18E9A  97 PC, low confidence
; Opens the statistics overlay at a stoppage when the option is on and none
; is shown
;-----------------------------------------------------------------------------
ChkShowStatsPanel:
        push ebx
        push edx
        movsx eax, word [gameclock]
        mov ebx, 78h
        cdq
        idiv ebx
        cmp edx, byte 5
        jne short .2
        cmp word [StatsPanelOn], byte 0Ah
        jge short .2
        push dword 1F4h
.1:
        push byte 3
        call QueueOverlayPanel
        mov eax, 1
        add esp, byte 8
        pop edx
        pop ebx
        ret
.2:
        cmp word [gameclock], byte 41h
        jne short .3
        cmp word [StatsPanelOn], byte 0Ah
        jge short .3
        push byte 0
        jmp short .1
.3:
        xor eax, eax
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ChkPowerPlayPanel                               18EEE  97 PC, low confidence
; Opens or closes the power play overlay as penalties start and end
;-----------------------------------------------------------------------------
ChkPowerPlayPanel:
        push ebx
        push ecx
        push edx
        movsx eax, word [AwPlayersInBox]
        movsx ebx, word [HmPlayersInBox]
        sub ebx, eax
        je short .1
        movsx eax, word [gameclock]
        mov ecx, 1Eh
        cdq
        idiv ecx
        cmp edx, byte 0Fh
        jne short .1
        push ebx
        push dword 12Ch
        push edx
        call QueueOverlayPanel
        mov eax, 1
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        xor eax, eax
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        push edx
        movsx eax, word [gameclock]
        mov ebx, 5Ah
        cdq
        idiv ebx
        cmp edx, byte 1Eh
        jne short .2
        push dword 1F4h
        push byte 0Eh
        call QueueOverlayPanel
        mov eax, 1
        add esp, byte 8
        pop edx
        pop ebx
        ret
.2:
        xor eax, eax
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SetOverlayFont                                  18F67  97 PC, low confidence
; Selects the font and colours used to draw text on the overlay panels
;-----------------------------------------------------------------------------
SetOverlayFont:
        push ebx
        push ecx
        push edx
        cmp dword [ViewScreenHeight], 12Ch
        jge short .1
        mov eax, dword [ClockFontSmall]
        jmp short .2
.1:
        mov eax, dword [ClockFontLarge]
.2:
        cmp eax, dword [TextColor]
        je short .3
        push eax
        call SelectFont
        add esp, byte 4
.3:
        cmp dword [TextAlign], byte 1
        jne short .4
        push byte 0FFFFFFFFh
        call MatchColor
        add esp, byte 4
        call SetTextColor
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        push dword 0FFAAAAAAh
        call MatchColor
        add esp, byte 4
        push eax
        push byte 0FFFFFFFFh
        call MatchColor
        add esp, byte 4
        push eax
        xor ebx, ebx
        call SetTextColors
        add esp, byte 8
.5:
        lea eax, [byte ebx+030h]
        mov edx, eax
        shl edx, 13h
        shl eax, 0Bh
        add edx, eax
        mov eax, ebx
        shl eax, 3
        add eax, 180h
        add eax, edx
        push eax
        inc ebx
        call MatchColor
        add esp, byte 4
        mov dword [nosplit ebx*4+TextColorTable], eax
        cmp ebx, byte 10h
        jl short .5
        mov dword [DrawGlyphFn], DrawGlyph_494
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawGameOverlays                             1900F  96 PC, medium confidence
; (ticks): per frame draws the overlay for the view state,
; the queued panels, the clock, time-left and score panels
;-----------------------------------------------------------------------------
DrawGameOverlays:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 8, 0
        mov edi, eax
        call ChkShowStatsPanel
        mov dword [byte ebp-04h], 0
        mov dword [byte ebp-08h], 0
        mov ebx, OverlayPanelQueue
        xor esi, esi
.1:
        cmp dword [ebx], byte 0
        je short .3
        cmp dword [byte ebx+08h], byte 0
        jle short .3
        sub dword [byte ebx+08h], edi
        cmp dword [byte ebx+08h], byte 0
        jg short .3
        cmp dword [byte ebx+04h], byte 0
        jl short .2
        cmp dword [byte ebx+04h], byte 9
        jge short .2
        mov word [MessagePanel], 0FFFFh
.2:
        mov eax, dword [ebx]
        mov eax, dword [byte eax+02Ch]
        call RemoveOverlayWindow
        push dword [ebx]
        call FreeBitmap
        add esp, byte 4
        mov dword [ebx], 0
.3:
        cmp dword [ebx], byte 0
        je short .4
        cmp dword [byte ebx+04h], 300h
        jne short .4
        mov eax, dword [ebx]
        mov dword [byte ebp-08h], 1
        call DrawGameClock
        jmp short .8
.4:
        cmp dword [ebx], byte 0
        je short .5
        cmp dword [byte ebx+04h], 700h
        jne short .5
        mov eax, dword [ebx]
        mov dword [byte ebp-04h], 1
        call DrawPowerPlayClock
        jmp short .8
.5:
        cmp dword [ebx], byte 0
        je short .6
        cmp dword [byte ebx+04h], 500h
        jne short .6
        mov eax, dword [ebx]
        xor edx, edx
        jmp short .7
.6:
        cmp dword [ebx], byte 0
        je short .8
        cmp dword [byte ebx+04h], 600h
        jne short .8
        mov edx, 1
        mov eax, dword [ebx]
.7:
        call UpdateScoreboardPanel
.8:
        inc esi
        add ebx, byte 0Ch
        cmp esi, byte 0Ah
        jl near .1
        cmp dword [byte ebp-08h], byte 0
        jne near PrevVideoModeKey_216
        cmp dword [byte ebp-04h], byte 0
        jne near PrevVideoModeKey_216
        call ChkPowerPlayPanel
        test eax, eax
        jne near PrevVideoModeKey_216
        movsx eax, word [gameclock]
        mov ebx, 5Ah
        cdq
        idiv ebx
        cmp edx, byte 1Eh
        jne near PrevVideoModeKey_216
        push dword 1F4h
        push byte 0Eh
        jmp near PrevVideoModeKey_20E
;-----------------------------------------------------------------------------
; IsOverlayShown                               19133  97 PC, medium confidence
; Returns nonzero when the given overlay window is open
;-----------------------------------------------------------------------------
IsOverlayShown:
        push ebx
        push edx
        mov ebx, eax
        mov eax, OverlayPanelQueue
        xor edx, edx
.1:
        cmp dword [eax], byte 0
        je short .2
        cmp ebx, dword [byte eax+04h]
        jne short .2
        mov eax, 1
        pop edx
        pop ebx
        ret
.2:
        inc edx
        add eax, byte 0Ch
        cmp edx, byte 0Ah
        jl short .1
        xor eax, eax
        pop edx
        pop ebx
        ret
        db 00h,00h,00h,00h,0FFh,0C4h,00h,00h,0C8h,042h,00h,00h,096h,0C5h,00h,00h
        db 0FFh,044h,00h,00h,07Ah,045h,00h,00h,096h,045h
FaceoffCloseupInit:                             ; used by FaceoffCloseupScene
        db 02Ch,01h,00h,00h,02Ch,01h,00h,00h
FaceoffSweepInit:                               ; used by FaceoffSweepScene
        db 0F4h,01h,00h,00h,0F4h,01h,00h,00h
GoalSceneCamFrom:                               ; used by GoalSceneStep
        db 00h,0C0h,05h,0C5h,00h,00h,048h,043h,00h,020h,099h,0C5h
GoalSceneCamTo:                                 ; used by GoalSceneStep
        db 00h,0C0h,05h,045h,00h,080h,0BBh,044h,00h,020h,099h,045h
GoalCameraFrom:                                 ; used by GoalCameraScene
        db 00h,080h,018h,0C5h,00h,00h,0C8h,043h,00h,080h,0A2h,0C5h
GoalCameraTo:                                   ; used by GoalCameraScene
        db 00h,080h,018h,045h,00h,080h,0BBh,044h,00h,080h,0A2h,045h
        push eax
        push ebx
        push ebp
        mov ebp, esp
        sub esp, byte 8
        and esp, byte 0FFFFFFF8h
        fld dword [byte ebp+018h]
        fsub dword [byte ebp+014h]
        fstp dword [esp]
        test dword [esp], 7FFFFFFFh
        jne short .1
        xor ebx, ebx
        mov dword [byte esp+04h], ebx
        jmp short .2
.1:
        fld dword [byte ebp+010h]
        fsub dword [byte ebp+014h]
        fdiv dword [esp]
        fstp dword [byte esp+04h]
.2:
        fld dword [byte esp+04h]
        mov esp, ebp
        pop ebp
        pop ebx
        pop eax
        ret 0Ch
