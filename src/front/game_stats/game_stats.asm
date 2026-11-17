; Game stats screens: team and player pages.
bits 32
%include "hockey.inc"
section s_A7D7C progbits alloc exec nowrite align=1
extern AllocMemBlock, AllocStatTable, AutoLineData, BlitArt, BlitShape, ClearScreen, ConvertArtXY, CreateBitmap
extern DrawArt, DrawFrameBox, DrawScreenBackground, DrawScrollBar, DrawShadedLogo, DrawShadowBox, DrawShapeBlended, DrawStatTableArt
extern DrawStatTableRows, DrawTextAligned, ExitScreen, FindShape, FirstPenaltyEntry, FirstScoringEntry, FormatGoalLine, FreeBitmap
extern FreeLogoArt, FreeMemBlock, FreeScrollList, FreeStatTable, FrontMusicOn, FrontShapeFile, GameLogCount, gameopts
extern gameover, GameStatsAnimSoundOn, GameStatsBackFile, GameStatsColumn, GameStatsDrawn, GameStatsLine, GameStatsList, GameStatsPage
extern GameStatsRow, GameStatsScroll, GameStatsSoundOn, GameStatsSpeechCount, GameStatsTable, GameStatsTeam, GameStatsTitleFile, GetLangText
extern GoalTypeSuffix, homelines, InitListBox, InitMenuItems, InitScrollList, InitShapeListBox, LoadDataFile, LoadTeamLogo
extern MakeColor, NextPenaltyEntry, NextScoringEntry, PeriodEntryCount, PlaySfx, PositionAbbrev, PostGameLastSpeech, PresentScreen
extern Random32, ResetClipWindow, RunMenu, ScoringAwayLayer, ScoringEntryCount, ScoringEntryText, ScoringHomeLayer, ScoringLogPrevMinute
extern ScreenFrameItem, ScreenTitleItem, ScrollDown, ScrollToMouse, ScrollUp, SecondsToSamples, SetClipWindow, SetDrawTarget
extern SetHighlightText, SetNormalText, SetScreenTarget, SetStatCell, SetStatCellFlag, SetStatColumn, SetStatRowWidth, SetTextColor
extern ShadowShape, ShowPopupScreen, ShowScreen, SortStatTable, sprintf_, StatsLineAssists, StatsLineGoals, StatsLineNames
extern StatsLinePenalties, StatsLinePoints, StatsLineTotals, StopAllSfx, str_00, str_1BOT3, str_1TOP3, str_2BOT3
extern str_2TOP3, str_3BOT3, str_3TOP3, str_BACK6, str_BAK2, str_BOTM2, str_BoxScores, str_CDCS
extern str_D01d, str_D_DrawTeamStatLine, str_DD, str_GameStatMenu, str_GameStatRegn, str_GS00, str_GS01, str_GS02d
extern str_GS04, str_GS05, str_GS08, str_GS09, str_GS12, str_GS13, str_GS16, str_GS17
extern str_GS20, str_GS21, str_GS24, str_GS25, str_PlayerStats, str_SD4, str_TITL7, str_TTL2
extern tickcount, WaitSoundTime, WipeScreen
global GameStatsScreenJumpTable, GameStatsScreen, GameStatsScreen_143, GameStatsScreen_14E, GameStatsScreen_19A, GameStatsScreen_205, GameStatsScreen_24A, GameStatsScreen_294
global GameStatsScreen_2D9, GameStatsScreen_39D, InitGameStatsScreen, FreeGameStats, InitGameStatsList, GameStatsPlayersPage, DrawTeamGameStats, DrawTeamStatLine
global DrawScoringLogo, DrawScoringSummary, ShowGameStatsPage, FormatPlayerStatLine, DrawPlayerStatsPage, BuildPlayerStatsTable, GameStatsSound, GameStatsAnim
GameStatsScreenJumpTable:                       ; jump table for the switch cases of GameStatsScreen
        dd GameStatsScreen_143
        dd GameStatsScreen_14E
        dd GameStatsScreen_19A
        dd GameStatsScreen_205
        dd GameStatsScreen_24A
        dd GameStatsScreen_294
        dd GameStatsScreen_2D9
        dd GameStatsScreen_39D
;-----------------------------------------------------------------------------
; GameStatsScreen                              A7D9C  96 PC, medium confidence
; The game statistics screen (BKGD, BANNER, SBACK, page arrows AR00-AR11, puck cursor BALL): pages of
; DrawGameStats, mouse and pad, the modem chat box and sync on a modem game
;-----------------------------------------------------------------------------
GameStatsScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 404h
        push byte 0
        push dword 1DCAh
        push str_GameStatMenu
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 1740h
        push str_GameStatRegn
        mov ebx, eax
        mov esi, eax
        call AllocMemBlock
        lea edx, [dword esp+025Ch]
        mov dword [GameStatsTable], edx
        lea edx, [byte esp+0Ch]
        mov dword [StatsLineNames], edx
        lea edx, [dword esp+035Ch]
        mov dword [StatsLineGoals], edx
        lea edx, [dword esp+0390h]
        mov dword [StatsLineAssists], edx
        lea edx, [dword esp+03C4h]
        add esp, byte 0Ch
        mov dword [StatsLinePoints], edx
        lea edx, [dword esp+03ECh]
        mov dword [GameStatsColumn], ebx
        mov dword [StatsLineTotals], edx
        lea edx, [dword esp+03F4h]
        mov dword [dword esp+0400h], eax
        mov dword [StatsLinePenalties], edx
        call InitGameStatsScreen
        call GameStatsPlayersPage
        mov eax, dword [GameStatsList]
        xor edi, edi
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte eax+02Ch]
        xor ebp, ebp
        call WipeScreen
.1:
        cmp dword [GameStatsPage], byte 1
        je short .2
        push byte 3
        lea eax, [dword esp+0400h]
        mov ecx, GameStatsSound
        mov ebx, 0FFFFFFFFh
        push eax
        mov edx, esi
        mov eax, 0Ah
        jmp short .4
.2:
        cmp dword [GameStatsDrawn], byte 0
        jne short .3
        push byte 3
        lea eax, [dword esp+0400h]
        mov ecx, GameStatsAnim
        mov ebx, 0FFFFFFFFh
        push eax
        mov edx, esi
        mov eax, 5Dh
        jmp short .4
.3:
        push byte 3
        lea eax, [dword esp+0400h]
        mov ecx, GameStatsAnim
        mov ebx, 0FFFFFFFFh
        push eax
        mov edx, esi
        mov eax, 2Ch
.4:
        call RunMenu
        mov ecx, dword [dword esp+03FCh]
        cmp ecx, byte 7
        ja near GameStatsScreen_39D.12
        mov edx, ecx
        jmp dword [nosplit cs:edx*4+GameStatsScreenJumpTable]
GameStatsScreen_143:
        call ShowScreen
        inc ebp
        jmp near GameStatsScreen_39D.16
GameStatsScreen_14E:
        mov edx, dword [GameStatsList]
        push edx
        call FreeBitmap
        add esp, byte 4
        call ExitScreen
        push byte 0
        push dword 1E0h
        push dword 280h
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [GameStatsList], eax
        call SetScreenTarget
        push byte 0
        mov eax, dword [GameStatsList]
        push byte 0
        mov ebx, dword [byte eax+02Ch]
        push ebx
        call ConvertArtXY
        add esp, byte 0Ch
        jmp near GameStatsScreen_39D.15
GameStatsScreen_19A:
        imul eax, ecx, byte 52h
        add eax, esi
        call ShowPopupScreen
        cmp dword [GameStatsPage], byte 1
        jne short .5
        mov eax, dword [StatsLineNames]
        call FreeStatTable
.5:
        mov eax, dword [GameStatsPage]
        inc eax
        mov dword [GameStatsPage], eax
        cmp eax, byte 2
        jle short .6
        xor ebx, ebx
        mov dword [GameStatsPage], ebx
.6:
        call GameStatsPlayersPage
        xor edi, edi
        call SetScreenTarget
        push edi
        mov eax, dword [GameStatsList]
        push edi
        mov ecx, dword [byte eax+02Ch]
        push ecx
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        cmp dword [GameStatsPage], byte 1
        jne near GameStatsScreen_39D.16
        jmp near GameStatsScreen_39D.13
GameStatsScreen_205:
        mov eax, dword [GameStatsTable]
        xor edx, ecx
        call ScrollUp
        mov eax, dword [GameStatsTable]
        cmp edi, dword [byte eax+024h]
        je near GameStatsScreen_39D.16
        call SetScreenTarget
        mov eax, dword [GameStatsPage]
        cmp eax, byte 1
        jb short .7
        jbe short .7
        cmp eax, byte 2
        jne short .7
        xor eax, eax
        call ShowGameStatsPage
.7:
        mov edi, dword [GameStatsTable]
        mov edi, dword [byte edi+024h]
        jmp near GameStatsScreen_39D.15
GameStatsScreen_24A:
        mov ecx, dword [GameStatsTable]
        mov ebx, eax
        xor edx, edx
        mov eax, ecx
        call ScrollToMouse
        mov eax, dword [GameStatsTable]
        cmp edi, dword [byte eax+024h]
        je near GameStatsScreen_39D.16
        call SetScreenTarget
        mov eax, dword [GameStatsPage]
        cmp eax, byte 1
        jb short .8
        jbe short .8
        cmp eax, byte 2
        jne short .8
        xor eax, eax
        call ShowGameStatsPage
.8:
        mov edi, dword [GameStatsTable]
        mov edi, dword [byte edi+024h]
        jmp near GameStatsScreen_39D.15
GameStatsScreen_294:
        mov eax, dword [GameStatsTable]
        xor edx, ecx
        call ScrollDown
        mov eax, dword [GameStatsTable]
        cmp edi, dword [byte eax+024h]
        je near GameStatsScreen_39D.16
        call SetScreenTarget
        mov eax, dword [GameStatsPage]
        cmp eax, byte 1
        jb short .9
        jbe short .9
        cmp eax, byte 2
        jne short .9
        xor eax, eax
        call ShowGameStatsPage
.9:
        mov edi, dword [GameStatsTable]
        mov edi, dword [byte edi+024h]
        jmp near GameStatsScreen_39D.15
GameStatsScreen_2D9:
        cmp dword [GameStatsTeam], byte 0
        sete al
        and eax, 0FFh
        mov dword [GameStatsTeam], eax
        mov eax, dword [GameStatsList]
        push eax
        call SetDrawTarget
        add esp, byte 4
        push str_BAK2
        mov edx, dword [GameStatsBackFile]
        push edx
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_TTL2
        mov ebx, dword [GameStatsTitleFile]
        push ebx
        call FindShape
        add esp, byte 8
        push eax
        xor ebx, ebx
        call BlitShape
        add esp, byte 4
.10:
        mov eax, dword [GameStatsColumn]
        add eax, ebx
        cmp dword [byte eax+01Ah], byte 0
        je short .11
        mov edx, dword [byte eax+02Ah]
        push edx
        mov ecx, dword [byte eax+026h]
        push ecx
        mov edx, dword [byte eax+01Ah]
        push edx
        call DrawArt
        add esp, byte 0Ch
.11:
        add ebx, byte 52h
        cmp ebx, 0A4h
        jne short .10
        mov eax, dword [StatsLineNames]
        call FreeStatTable
        mov eax, 1
        call DrawPlayerStatsPage
        mov eax, dword [StatsLineNames]
        call DrawStatTableRows
        call SetScreenTarget
        push byte 0
        mov eax, dword [GameStatsList]
        push byte 0
        mov ebx, dword [byte eax+02Ch]
        push ebx
        call BlitArt
        add esp, byte 0Ch
        jmp short GameStatsScreen_39D.14
GameStatsScreen_39D:
        cmp dword [GameStatsDrawn], byte 0
        sete al
        and eax, 0FFh
        mov dword [GameStatsDrawn], eax
        mov eax, dword [StatsLineNames]
        call FreeStatTable
        xor eax, eax
        call DrawPlayerStatsPage
        mov eax, dword [StatsLineNames]
        call DrawStatTableRows
        call SetScreenTarget
        push byte 0
        mov eax, dword [GameStatsList]
        push byte 0
        mov ebx, dword [byte eax+02Ch]
        push ebx
        call BlitArt
        add esp, byte 0Ch
        jmp short .14
.12:
        mov edx, dword [dword esp+03FCh]
        push eax
        xor ecx, ecx
        xor ebx, ebx
        mov eax, dword [StatsLineNames]
        sub edx, byte 0Ah
        call SortStatTable
.13:
        mov eax, dword [StatsLineNames]
        call DrawStatTableRows
        call SetScreenTarget
.14:
        mov eax, dword [StatsLineNames]
        call DrawStatTableArt
.15:
        call PresentScreen
.16:
        test ebp, ebp
        je near GameStatsScreen.1
        cmp dword [GameStatsPage], byte 1
        jne short .17
        mov eax, dword [StatsLineNames]
        call FreeStatTable
.17:
        mov edi, dword [dword esp+0400h]
        call FreeGameStats
        push edi
        call FreeMemBlock
        add esp, byte 4
        push esi
        call FreeMemBlock
        add esp, byte 4
        add esp, 404h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; InitGameStatsScreen                             A8204  97 PC, low confidence
; From GameStatsScreen: creates its bitmap and menu items and loads its art
; (LoadDataFile; BACK, BOTM)
;-----------------------------------------------------------------------------
InitGameStatsScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebx, eax
        mov eax, dword [gameopts]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        call LoadTeamLogo
        mov edx, dword [ShadowShape]
        mov eax, dword [byte edx+02h]
        sar eax, 10h
        imul eax, dword 0B333h
        mov edx, dword [byte edx+04h]
        sar edx, 10h
        imul edx, dword 0B333h
        push byte 0
        sar edx, 10h
        push edx
        sar eax, 10h
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [ScoringHomeLayer], eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        call ClearScreen
        add esp, byte 4
        push byte 0
        push byte 0
        mov edx, dword [ShadowShape]
        push edx
        push dword 0B333h
        call DrawShapeBlended
        add esp, byte 10h
        call FreeLogoArt
        mov eax, dword [gameopts]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        shr eax, 1Ah
        call LoadTeamLogo
        mov edx, dword [ShadowShape]
        mov eax, dword [byte edx+02h]
        sar eax, 10h
        imul eax, dword 0B333h
        mov edx, dword [byte edx+04h]
        sar edx, 10h
        imul edx, dword 0B333h
        push byte 0
        sar edx, 10h
        push edx
        sar eax, 10h
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [ScoringAwayLayer], eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        call ClearScreen
        add esp, byte 4
        push byte 0
        push byte 0
        mov ecx, dword [ShadowShape]
        push ecx
        push dword 0B333h
        call DrawShapeBlended
        add esp, byte 10h
        call FreeLogoArt
        mov eax, 5Dh
        mov edx, dword [GameStatsColumn]
        call InitMenuItems
        mov edx, ebx
        xor eax, eax
.1:
        mov ebx, dword [GameStatsColumn]
        add eax, byte 52h
        mov dword [byte ebx+eax-03Eh], edx
        add edx, byte 40h
        cmp eax, 1DCAh
        jne short .1
        push byte 0
        push dword 1E0h
        push dword 280h
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [GameStatsList], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 0Fh
        call LoadDataFile
        mov dword [GameStatsTitleFile], eax
        mov eax, 3
        mov edx, 20h
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 0Eh
        xor esi, esi
        call LoadDataFile
        mov ebp, dword [GameStatsList]
        mov dword [GameStatsBackFile], eax
        push ebp
        mov dword [GameStatsRow], esi
        mov dword [GameStatsLine], esi
        call SetDrawTarget
        add esp, byte 4
        push str_BACK6
        mov eax, dword [GameStatsBackFile]
        push eax
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_BOTM2
        mov edx, dword [GameStatsBackFile]
        push edx
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        mov ah, byte [FrontMusicOn]
        add esp, byte 4
        test ah, ah
        je short .2
        mov ebx, dword [GameStatsBackFile]
        push ebx
        call FreeMemBlock
        add esp, byte 4
        mov dword [GameStatsBackFile], esi
.2:
        push str_TITL7
        mov esi, dword [GameStatsTitleFile]
        push esi
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        mov eax, dword [GameStatsList]
        mov esi, ScreenTitleItem
        mov eax, dword [byte eax+02Ch]
        add esp, byte 4
        mov ebx, eax
        mov edx, eax
        mov ecx, 14h
        call DrawScreenBackground
        mov edi, dword [GameStatsColumn]
        rep movsd
        movsw
        mov eax, dword [GameStatsColumn]
        mov dword [eax], 0
        mov edi, dword [GameStatsColumn]
        mov ecx, 14h
        mov esi, ScreenFrameItem
        lea edi, [byte edi+052h]
        rep movsd
        movsw
        mov eax, dword [GameStatsColumn]
        xor edi, edi
        mov dword [byte eax+052h], 1
        mov dword [GameStatsScroll], edi
        mov dword [GameStatsPage], edi
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FreeGameStats                                   A8480  97 PC, low confidence
; Frees the game stats screen
;-----------------------------------------------------------------------------
FreeGameStats:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp dword [GameStatsScroll], byte 0
        je short .1
        mov eax, dword [GameStatsTable]
        call FreeScrollList
.1:
        mov ebx, dword [GameStatsLine]
        test ebx, ebx
        je short .2
        push ebx
        call FreeMemBlock
        xor esi, esi
        add esp, byte 4
        mov dword [GameStatsLine], esi
.2:
        mov edi, dword [GameStatsRow]
        test edi, edi
        je short .3
        push edi
        call FreeBitmap
        xor eax, eax
        add esp, byte 4
        mov dword [GameStatsRow], eax
.3:
        mov edx, dword [ScoringHomeLayer]
        push edx
        call FreeBitmap
        add esp, byte 4
        mov ebx, dword [ScoringAwayLayer]
        push ebx
        call FreeBitmap
        add esp, byte 4
        mov ecx, dword [GameStatsList]
        push ecx
        call FreeBitmap
        mov esi, dword [GameStatsBackFile]
        add esp, byte 4
        test esi, esi
        je short .4
        push esi
        call FreeMemBlock
        add esp, byte 4
.4:
        mov ebp, dword [GameStatsTitleFile]
        push ebp
        call FreeMemBlock
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; InitGameStatsList                               A8524  97 PC, low confidence
; Sets up the game stats list
;-----------------------------------------------------------------------------
InitGameStatsList:
        push esi
        push edi
        push ebp
        mov esi, eax
        mov edi, edx
        mov ebp, ebx
        mov ebx, ecx
        mov ecx, dword [byte esp+010h]
        push byte 0
        push byte 0
        push ebp
        push edx
        push eax
        mov edx, dword [byte esp+028h]
        push edx
        push byte 0
        mov edx, dword [GameStatsColumn]
        mov eax, dword [GameStatsTable]
        add edx, 0F6h
        call InitScrollList
        mov eax, dword [GameStatsColumn]
        mov dword [dword eax+011Ch], esi
        mov eax, dword [GameStatsColumn]
        mov dword [dword eax+0120h], edi
        push str_1TOP3
        mov ebx, dword [FrontShapeFile]
        push ebx
        call FindShape
        mov edx, dword [GameStatsColumn]
        add esp, byte 8
        mov dword [dword edx+0110h], eax
        push str_2TOP3
        mov ecx, dword [FrontShapeFile]
        push ecx
        call FindShape
        mov edx, dword [GameStatsColumn]
        add esp, byte 8
        mov dword [dword edx+0114h], eax
        push str_3TOP3
        mov eax, dword [FrontShapeFile]
        push eax
        call FindShape
        mov edx, dword [GameStatsColumn]
        add esp, byte 8
        mov dword [dword edx+0118h], eax
        push str_1BOT3
        mov edx, dword [FrontShapeFile]
        push edx
        call FindShape
        mov edx, dword [GameStatsColumn]
        add esp, byte 8
        mov dword [dword edx+01B4h], eax
        push str_2BOT3
        mov ebx, dword [FrontShapeFile]
        push ebx
        call FindShape
        mov edx, dword [GameStatsColumn]
        add esp, byte 8
        mov dword [dword edx+01B8h], eax
        push str_3BOT3
        mov ecx, dword [FrontShapeFile]
        push ecx
        call FindShape
        mov edx, dword [GameStatsColumn]
        mov dword [dword edx+01BCh], eax
        mov eax, dword [GameStatsColumn]
        mov dword [dword eax+01C0h], esi
        mov eax, dword [GameStatsColumn]
        mov edx, dword [dword eax+01B4h]
        mov edx, dword [byte edx+04h]
        add edi, ebp
        sar edx, 10h
        sub edi, edx
        mov esi, 1
        mov dword [dword eax+01C4h], edi
        add esp, byte 8
        mov dword [GameStatsScroll], esi
        pop ebp
        pop edi
        pop esi
        ret 8
        db 090h
        push ebx
        push ecx
        push edx
        mov dword [byte eax+022h], 0
        push byte 1
        mov edx, dword [byte eax+022h]
        mov ecx, 1
        mov dword [byte eax+01Eh], edx
        mov ebx, 1E0h
        mov dword [byte eax+01Ah], edx
        mov edx, 280h
        call InitListBox
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; GameStatsPlayersPage                            A8694  97 PC, low confidence
; From GameStatsScreen: the "player stats" page (GS buttons, the three stars'
; tops 1TOP-3BOT)
;-----------------------------------------------------------------------------
GameStatsPlayersPage:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edx, dword [GameStatsList]
        push edx
        xor ebx, ebx
        call SetDrawTarget
        add esp, byte 4
.1:
        mov eax, dword [GameStatsColumn]
        add eax, ebx
        mov ecx, dword [byte eax+01Ah]
        test ecx, ecx
        je short .2
        mov esi, dword [byte eax+02Ah]
        push esi
        mov edi, dword [byte eax+026h]
        push edi
        push ecx
        call DrawArt
        add esp, byte 0Ch
.2:
        add ebx, byte 52h
        cmp ebx, 0A4h
        jne short .1
        mov eax, dword [GameStatsLine]
        test eax, eax
        je short .3
        push eax
        call FreeMemBlock
        xor ebx, ebx
        add esp, byte 4
        mov dword [GameStatsLine], ebx
.3:
        mov ecx, dword [GameStatsRow]
        test ecx, ecx
        je short .4
        push ecx
        call FreeBitmap
        xor edi, edi
        add esp, byte 4
        mov dword [GameStatsRow], edi
.4:
        cmp dword [GameStatsScroll], byte 0
        je short .6
        mov eax, dword [GameStatsTable]
        mov esi, 0F6h
        call FreeScrollList
        mov edi, 1
.5:
        mov eax, dword [GameStatsColumn]
        add eax, esi
        mov dword [byte eax+022h], 0
        mov edx, 280h
        mov ebx, dword [byte eax+022h]
        push edi
        mov dword [byte eax+01Eh], ebx
        mov ecx, edi
        mov dword [byte eax+01Ah], ebx
        mov ebx, 1E0h
        add esi, byte 52h
        call InitListBox
        cmp esi, 1ECh
        jne short .5
        xor eax, eax
        mov dword [GameStatsScroll], eax
.6:
        mov eax, dword [GameStatsColumn]
        mov edi, dword [dword eax+02A4h]
        mov esi, 334h
        add edi, 80h
.7:
        mov eax, dword [GameStatsColumn]
        mov dword [byte esi+eax+014h], edi
        mov eax, dword [GameStatsColumn]
        add eax, esi
        push byte 1
        mov dword [byte eax+022h], 0
        mov ecx, 1
        mov ebx, dword [byte eax+022h]
        mov edx, 280h
        mov dword [byte eax+01Eh], ebx
        add edi, byte 40h
        mov dword [byte eax+01Ah], ebx
        mov ebx, 1E0h
        add esi, byte 52h
        call InitListBox
        cmp esi, 1DCAh
        jne short .7
        mov eax, dword [GameStatsColumn]
        add eax, 1ECh
        mov dword [byte eax+022h], 0
        push byte 1
        mov edx, dword [byte eax+022h]
        mov ecx, 1
        mov dword [byte eax+01Eh], edx
        mov ebx, 1E0h
        mov dword [byte eax+01Ah], edx
        mov edx, 280h
        call InitListBox
        mov eax, dword [GameStatsColumn]
        add eax, 23Eh
        mov dword [byte eax+022h], 0
        push byte 1
        mov edx, dword [byte eax+022h]
        mov ecx, 1
        mov dword [byte eax+01Eh], edx
        mov ebx, 1E0h
        mov dword [byte eax+01Ah], edx
        mov edx, 280h
        call InitListBox
        cmp dword [GameStatsPage], byte 0
        jle short .8
        call SetHighlightText
        jmp short .9
.8:
        call SetNormalText
.9:
        mov eax, dword [GameStatsPage]
        mov esi, 13h
        cmp eax, byte 1
        jb short .10
        jbe near .14
        cmp eax, byte 2
        je near .16
        jmp near .24
.10:
        test eax, eax
        jne near .24
        cmp dword [GameStatsBackFile], byte 0
        jne short .11
        mov eax, 3
        mov edx, 20h
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 0Eh
        call LoadDataFile
        mov dword [GameStatsBackFile], eax
.11:
        push str_BACK6
        mov ebx, dword [GameStatsBackFile]
        push ebx
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_BOTM2
        mov ecx, dword [GameStatsBackFile]
        push ecx
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_TITL7
        mov edi, dword [GameStatsTitleFile]
        push edi
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        mov ebp, dword [GameStatsBackFile]
        push ebp
        mov ebx, str_GS08
        call FreeMemBlock
        add esp, byte 4
        xor eax, eax
        mov ecx, str_GS09
        mov dword [GameStatsBackFile], eax
        call DrawScoringLogo
        push str_GS08
        mov edx, dword [GameStatsColumn]
        mov eax, dword [GameStatsTitleFile]
        add edx, 0A4h
        call InitShapeListBox
        mov eax, dword [GameStatsColumn]
        mov ecx, dword [dword eax+0BEh]
        shl esi, 4
        mov ebx, 1B4h
        mov edx, dword [byte ecx+04h]
        add eax, 0A4h
        sar edx, 10h
        mov ecx, dword [byte ecx+02h]
        push edx
        sar ecx, 10h
        mov edx, 104h
        add esi, byte 14h
        call InitListBox
        mov ecx, 4Ah
        push esi
        mov ebx, 28h
        mov eax, dword [GameStatsList]
        push dword 230h
        mov edx, 14h
        mov eax, dword [byte eax+02Ch]
        call DrawShadowBox
        mov ebx, 230h
        mov edx, 4Ch
        mov eax, 28h
        mov ecx, esi
        call DrawFrameBox
        call DrawTeamGameStats
        mov edx, dword [GameStatsList]
        push edx
        mov ebx, 0A4h
        call SetDrawTarget
        add esp, byte 4
.12:
        mov eax, dword [GameStatsColumn]
        add eax, ebx
        mov edx, dword [byte eax+01Ah]
        test edx, edx
        je short .13
        mov ecx, dword [byte eax+02Ah]
        push ecx
        mov esi, dword [byte eax+026h]
        push esi
        push edx
        call DrawArt
        add esp, byte 0Ch
.13:
        add ebx, byte 52h
        cmp ebx, 1ECh
        je near .24
        jmp short .12
.14:
        mov ecx, dword [GameStatsBackFile]
        test ecx, ecx
        je short .15
        push ecx
        call FreeMemBlock
        add esp, byte 4
.15:
        mov eax, 3
        mov edx, 20h
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 101h
        call LoadDataFile
        push str_BAK2
        push eax
        mov dword [GameStatsBackFile], eax
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_TTL2
        mov edi, dword [GameStatsTitleFile]
        push edi
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push byte 0
        push dword 640h
        push str_PlayerStats
        mov ebx, str_GS04
        xor ebp, ebp
        call AllocMemBlock
        mov ecx, str_GS05
        mov edx, dword [GameStatsColumn]
        add esp, byte 0Ch
        mov dword [GameStatsLine], eax
        mov dword [GameStatsTeam], ebp
        push str_GS04
        mov eax, dword [GameStatsTitleFile]
        add edx, 0A4h
        mov dword [GameStatsDrawn], ebp
        call InitShapeListBox
        mov eax, 1
        call DrawPlayerStatsPage
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.16:
        mov ebx, dword [GameStatsBackFile]
        test ebx, ebx
        je short .17
        push ebx
        call FreeMemBlock
        add esp, byte 4
.17:
        mov eax, 3
        mov edx, 20h
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 0Eh
        call LoadDataFile
        push str_BACK6
        push eax
        mov dword [GameStatsBackFile], eax
        call FindShape
        add esp, byte 8
        push eax
        mov edi, eax
        call BlitShape
        add esp, byte 4
        push str_BOTM2
        mov ebp, dword [GameStatsBackFile]
        push ebp
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_TITL7
        mov eax, dword [GameStatsTitleFile]
        push eax
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        mov ah, byte [FrontMusicOn]
        add esp, byte 4
        test ah, ah
        je short .18
        mov edx, dword [GameStatsBackFile]
        push edx
        xor ebx, ebx
        call FreeMemBlock
        add esp, byte 4
        mov dword [GameStatsBackFile], ebx
.18:
        push str_GS00
        mov ecx, str_GS01
        mov ebx, str_GS00
        mov edx, dword [GameStatsColumn]
        mov eax, dword [GameStatsTitleFile]
        add edx, 0A4h
        call InitShapeListBox
        mov edx, dword [GameStatsColumn]
        mov eax, dword [dword edx+0BEh]
        mov ebx, dword [byte eax+04h]
        mov ecx, dword [byte eax+02h]
        sar ebx, 10h
        sar ecx, 10h
        lea eax, [dword edx+0A4h]
        push ebx
        mov edx, 104h
        mov ebx, 1B4h
        call InitListBox
        call DrawScoringSummary
        mov ebx, esi
        mov dword [ScoringEntryCount], eax
        shl ebx, 4
        cmp eax, byte 10h
        jle short .19
        push edi
        mov edx, 5Ah
        push byte 10h
        mov ecx, eax
        mov eax, 262h
        call InitGameStatsList
        mov edx, dword [GameStatsList]
        mov eax, dword [GameStatsTable]
        call DrawScrollBar
        jmp short .21
.19:
        mov esi, 0F6h
        mov edi, 1
.20:
        mov eax, dword [GameStatsColumn]
        add eax, esi
        mov dword [byte eax+022h], 0
        mov edx, 280h
        mov ebx, dword [byte eax+022h]
        push edi
        mov dword [byte eax+01Eh], ebx
        mov ecx, edi
        mov dword [byte eax+01Ah], ebx
        mov ebx, 1E0h
        add esi, byte 52h
        call InitListBox
        cmp esi, 1ECh
        jne short .20
.21:
        mov ebx, dword [GameStatsList]
        push ebx
        call SetDrawTarget
        mov ebx, 0A4h
        add esp, byte 4
.22:
        mov eax, dword [GameStatsColumn]
        add eax, ebx
        mov ecx, dword [byte eax+01Ah]
        test ecx, ecx
        je short .23
        mov esi, dword [byte eax+02Ah]
        push esi
        mov edi, dword [byte eax+026h]
        push edi
        push ecx
        call DrawArt
        add esp, byte 0Ch
.23:
        add ebx, byte 52h
        cmp ebx, 1ECh
        jne short .22
        mov eax, dword [GameStatsList]
        call ShowGameStatsPage
.24:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawTeamGameStats                               A8C5C  97 PC, low confidence
; Game stats: the team comparison rows (score, shots, power play, breakaways,
; one timers, faceoffs, body checks, passing...)
;-----------------------------------------------------------------------------
DrawTeamGameStats:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        push byte 0FFFFFFFFh
        mov ebp, 13h
        call MakeColor
        add esp, byte 4
        mov edi, 5Ah
        xor esi, esi
        call SetTextColor
.1:
        test esi, esi
        jne short .2
        mov edx, 64h
        mov eax, AutoLineData
        jmp short .3
.2:
        mov edx, 21Ch
        mov eax, homelines
.3:
        mov ecx, 13h
        mov ebx, 5Ah
        inc esi
        call DrawTeamStatLine
        cmp esi, byte 2
        jl short .1
        mov eax, 12Ah
        call GetLangText
        push eax
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 12Bh
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 12Ch
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 12Dh
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 12Eh
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 24Fh
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 12Fh
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 130h
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 131h
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 132h
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 133h
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 134h
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 135h
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 136h
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 137h
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 138h
        call GetLangText
        push eax
        add edi, ebp
        push edi
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawTeamStatLine                                A8E84  97 PC, low confidence
; Draws a team stats line
;-----------------------------------------------------------------------------
DrawTeamStatLine:
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov esi, eax
        mov edi, edx
        mov ebp, ecx
        mov eax, dword [dword eax+020B7h]
        sar eax, 10h
        push eax
        push str_D_DrawTeamStatLine
        push ebx
        push edx
        push byte 1
        call DrawTextAligned
        mov eax, dword [dword esi+020B5h]
        add esp, byte 14h
        sar eax, 10h
        push eax
        push str_D_DrawTeamStatLine
        add ebx, ebp
        push ebx
        push edi
        push byte 1
        add ebx, ebp
        call DrawTextAligned
        mov dx, word [dword esi+020B7h]
        add esp, byte 14h
        test dx, dx
        jle near .1
        mov eax, dword [dword esi+020B7h]
        sar eax, 10h
        mov dword [byte esp+04h], eax
        mov edx, eax
        shl eax, 2
        sub eax, edx
        shl eax, 3
        add edx, eax
        mov eax, dword [dword esi+020B5h]
        sar eax, 10h
        mov dword [esp], eax
        shl edx, 2
        mov ecx, dword [esp]
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov ecx, eax
        mov eax, dword [byte esp+04h]
        mov dword [byte esp+04h], eax
        mov edx, dword [byte esp+04h]
        shl eax, 5
        sub eax, edx
        shl eax, 2
        add edx, eax
        shl edx, 3
        mov eax, edx
        sar edx, 1Fh
        idiv dword [esp]
        mov dword [byte esp+04h], eax
        mov eax, ecx
        mov edx, ecx
        shl eax, 2
        add eax, edx
        mov edx, dword [byte esp+04h]
        add eax, eax
        sub edx, eax
        push edx
        push ecx
        push str_D01d
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 18h
        jmp short .2
.1:
        push str_00
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
.2:
        mov eax, dword [dword esi+020C9h]
        sar eax, 10h
        push eax
        push str_D_DrawTeamStatLine
        add ebx, ebp
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        mov edx, dword [dword esi+020CFh]
        sar edx, 10h
        add edx, byte 3Bh
        mov ecx, 3Ch
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        add esp, byte 14h
        push eax
        push str_D_DrawTeamStatLine
        add ebx, ebp
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        mov eax, dword [dword esi+020CBh]
        add esp, byte 14h
        sar eax, 10h
        push eax
        push str_D_DrawTeamStatLine
        add ebx, ebp
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        mov eax, dword [dword esi+020BDh]
        add esp, byte 14h
        sar eax, 10h
        push eax
        push str_D_DrawTeamStatLine
        add ebx, ebp
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        mov eax, dword [dword esi+020DDh]
        add esp, byte 14h
        sar eax, 10h
        push eax
        mov eax, dword [dword esi+020DFh]
        sar eax, 10h
        push eax
        push str_DD
        add ebx, ebp
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        mov eax, dword [dword esi+020D7h]
        add esp, byte 18h
        sar eax, 10h
        push eax
        mov eax, dword [dword esi+020D9h]
        sar eax, 10h
        push eax
        push str_DD
        add ebx, ebp
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        mov eax, dword [dword esi+020E1h]
        add esp, byte 18h
        sar eax, 10h
        push eax
        mov eax, dword [dword esi+020E3h]
        sar eax, 10h
        push eax
        push str_DD
        add ebx, ebp
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        mov eax, dword [dword esi+020C5h]
        add esp, byte 18h
        sar eax, 10h
        push eax
        push str_D_DrawTeamStatLine
        add ebx, ebp
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        mov eax, dword [dword esi+020E5h]
        sar eax, 10h
        push eax
        push str_D_DrawTeamStatLine
        add ebx, ebp
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        mov eax, dword [dword esi+020D3h]
        add esp, byte 14h
        sar eax, 10h
        push eax
        mov eax, dword [dword esi+020D1h]
        sar eax, 10h
        push eax
        push str_DD
        add ebx, ebp
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        mov edx, dword [dword esi+020D5h]
        sar edx, 10h
        add edx, byte 3Bh
        mov ecx, 3Ch
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        add esp, byte 18h
        push eax
        push str_D_DrawTeamStatLine
        add ebx, ebp
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        mov eax, dword [dword esi+020E7h]
        add esp, byte 14h
        sar eax, 10h
        push eax
        mov eax, dword [dword esi+020E9h]
        sar eax, 10h
        push eax
        push str_DD
        add ebx, ebp
        push ebx
        push edi
        push byte 1
        add ebx, ebp
        call DrawTextAligned
        mov cx, word [dword esi+020E9h]
        add esp, byte 18h
        test cx, cx
        jle short .3
        mov eax, dword [dword esi+020E9h]
        sar eax, 10h
        mov dword [byte esp+04h], eax
        lea edx, [nosplit eax*4+00h]
        sub edx, eax
        shl edx, 3
        add edx, eax
        mov ecx, dword [dword esi+020E7h]
        shl edx, 2
        sar ecx, 10h
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov ebp, eax
        mov eax, dword [byte esp+04h]
        mov edx, eax
        shl edx, 5
        sub edx, eax
        shl edx, 2
        add edx, eax
        shl edx, 3
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov edx, ebp
        mov ecx, eax
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        add eax, eax
        sub ecx, eax
        push ecx
        push ebp
        push str_D01d
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 18h
        jmp short .4
.3:
        push str_00
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
.4:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; DrawScoringLogo                                 A91AC  97 PC, low confidence
; Draws the logo in the scoring summary
;-----------------------------------------------------------------------------
DrawScoringLogo:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, dword [ScoringHomeLayer]
        mov esi, dword [byte esi+02Ch]
        mov ebx, 0ACh
        mov eax, dword [byte esi+04h]
        mov edx, dword [byte esi+02h]
        sar eax, 10h
        sar edx, 10h
        push eax
        sar eax, 1
        push edx
        sub ebx, eax
        mov eax, edx
        mov edx, 9Ch
        sar eax, 1
        push ebx
        sub edx, eax
        xor ecx, ecx
        push edx
        mov ebx, 10h
        mov edx, dword [GameStatsList]
        push byte 0
        mov eax, esi
        mov edx, dword [byte edx+02Ch]
        call DrawShadedLogo
        mov esi, dword [ScoringAwayLayer]
        mov esi, dword [byte esi+02Ch]
        mov eax, dword [byte esi+04h]
        sar eax, 10h
        mov edx, dword [byte esi+02h]
        push eax
        sar edx, 10h
        mov ebx, 0ACh
        push edx
        sar eax, 1
        sar edx, 1
        sub ebx, eax
        mov eax, 1E4h
        push ebx
        sub eax, edx
        xor ecx, ecx
        push eax
        mov ebx, 10h
        mov edx, dword [GameStatsList]
        push byte 0
        mov eax, esi
        mov edx, dword [byte edx+02Ch]
        call DrawShadedLogo
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawScoringSummary                              A9240  97 PC, low confidence
; Game stats: the scoring and penalty summary by period ("No scoring.",
; "Penalties - none")
;-----------------------------------------------------------------------------
DrawScoringSummary:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        call DrawScoringLogo
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov ax, word [GameLogCount]
        mov ebx, 13h
        test ax, ax
        jle short .1
        cwde
        mov al, byte [nosplit eax*8+ScoringLogPrevMinute]
        and eax, 0FFh
        jmp short .2
.1:
        mov eax, 0FFFFFFFFh
.2:
        mov dword [byte esp+0Ch], eax
        lea ebp, [nosplit eax*4+00h]
        xor edi, edi
        add ebp, byte 4
        test eax, eax
        jl short .6
.3:
        movsx edx, di
        mov eax, edx
        call FirstPenaltyEntry
        add ebp, eax
        mov eax, edx
        call ScoringEntryText
        test eax, eax
        jle short .4
        add ebp, eax
        jmp short .5
.4:
        inc ebp
.5:
        mov edx, dword [byte esp+0Ch]
        inc edi
        cmp edi, edx
        jle short .3
.6:
        mov edi, ebx
        shl edi, 4
        lea esi, [byte edi+014h]
        mov ecx, 4Ch
        push esi
        mov edx, 14h
        mov eax, dword [GameStatsList]
        push dword 278h
        mov ebx, 4
        mov eax, dword [byte eax+02Ch]
        call DrawShadowBox
        mov ebx, dword [GameStatsList]
        push ebx
        call SetDrawTarget
        mov ebx, 278h
        mov edx, 4Ch
        add esp, byte 4
        mov eax, 4
        mov ecx, esi
        call DrawFrameBox
        push byte 0
        push edi
        push dword 23Ah
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [GameStatsRow], eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0FFFFFFA6h
        mov eax, dword [GameStatsList]
        push byte 0FFFFFFD8h
        mov ecx, dword [byte eax+02Ch]
        push ecx
        call BlitArt
        add esp, byte 0Ch
        xor esi, esi
        lea eax, [byte ebp+01h]
        push esi
        shl eax, 7
        push eax
        push str_BoxScores
        xor edi, edi
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [GameStatsLine], eax
        mov eax, dword [byte esp+0Ch]
        xor ecx, ecx
        test eax, eax
        jl near .17
        mov ebx, 139h
        mov edx, 0FFFFFFFEh
        mov dword [byte esp+04h], ebx
        mov dword [byte esp+08h], edx
.7:
        cmp edi, byte 3
        jge short .8
        mov eax, dword [byte esp+04h]
        call GetLangText
        push eax
        mov eax, dword [GameStatsLine]
        add eax, esi
        push eax
        call sprintf_
        add esp, byte 8
        jmp short .10
.8:
        cmp dword [byte esp+0Ch], byte 3
        jne short .9
        mov eax, 13Ch
        call GetLangText
        push eax
        mov eax, dword [GameStatsLine]
        add eax, esi
        push eax
        call sprintf_
        add esp, byte 8
        jmp short .10
.9:
        mov edx, dword [byte esp+08h]
        push edx
        mov eax, 13Ch
        call GetLangText
        push eax
        mov eax, dword [GameStatsLine]
        push str_SD4
        add eax, esi
        push eax
        call sprintf_
        add esp, byte 10h
.10:
        movsx eax, di
        call NextPenaltyEntry
        add esi, 80h
        test eax, eax
        je short .12
.11:
        test eax, eax
        je short .13
        inc ecx
        mov edx, dword [GameStatsLine]
        mov ebx, ecx
        add edx, esi
        call GoalTypeSuffix
        movsx eax, di
        call PeriodEntryCount
        add esi, 80h
        jmp short .11
.12:
        mov eax, 13Dh
        call GetLangText
        push eax
        mov eax, dword [GameStatsLine]
        add eax, esi
        push eax
        call sprintf_
        add esi, 80h
        add esp, byte 8
.13:
        mov eax, dword [GameStatsLine]
        mov byte [esi+eax], 0
        lea eax, [dword esi+0100h]
        mov dword [esp], eax
        movsx eax, di
        add esi, 80h
        call FirstScoringEntry
        mov edx, eax
        mov ebx, eax
        test eax, eax
        je short .15
        mov eax, 13Eh
        call GetLangText
        push eax
        mov eax, dword [GameStatsLine]
        add esi, eax
        push esi
        call sprintf_
        add esp, byte 8
        mov esi, dword [esp]
        test edx, edx
        je short .16
.14:
        mov edx, dword [GameStatsLine]
        mov eax, ebx
        add edx, esi
        call FormatGoalLine
        movsx eax, di
        call NextScoringEntry
        add esi, 80h
        mov ebx, eax
        test eax, eax
        jne short .14
        jmp short .16
.15:
        mov eax, 13Fh
        call GetLangText
        push eax
        mov eax, dword [GameStatsLine]
        add esi, eax
        push esi
        call sprintf_
        add esp, byte 8
        mov esi, dword [esp]
.16:
        mov edx, dword [byte esp+08h]
        mov ebx, dword [byte esp+04h]
        mov eax, dword [GameStatsLine]
        inc edi
        inc edx
        inc ebx
        mov byte [esi+eax], 0
        mov eax, dword [byte esp+0Ch]
        add esi, 80h
        mov dword [byte esp+08h], edx
        mov dword [byte esp+04h], ebx
        cmp edi, eax
        jle near .7
.17:
        mov eax, ebp
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
; ShowGameStatsPage                               A9504  97 PC, low confidence
; Shows a game stats page
;-----------------------------------------------------------------------------
ShowGameStatsPage:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebx, dword [GameStatsColumn]
        mov edx, dword [dword ebx+0110h]
        mov ebp, 13h
        test edx, edx
        je short .1
        mov ebx, dword [GameStatsTable]
        mov ebx, dword [byte ebx+024h]
        shl ebx, 7
        jmp short .2
.1:
        xor ebx, ebx
.2:
        test eax, eax
        jne short .4
        jmp near .7
.3:
        mov eax, dword [GameStatsLine]
        add eax, ebx
        push eax
        push edi
        push byte 28h
        inc esi
        push byte 0
        add ebx, 80h
        add edi, ebp
        call DrawTextAligned
        add esp, byte 10h
        cmp esi, byte 10h
        jl short .5
        jmp near .10
.4:
        push eax
        call SetDrawTarget
        add esp, byte 4
        mov edi, 5Ah
        push edi
        mov eax, dword [GameStatsRow]
        push byte 28h
        mov edx, dword [byte eax+02Ch]
        push edx
        xor esi, esi
        call BlitArt
        add esp, byte 0Ch
.5:
        cmp esi, dword [ScoringEntryCount]
        jl short .3
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        mov eax, dword [GameStatsLine]
        add eax, ebx
        push eax
        push edi
        push byte 28h
        inc esi
        push byte 0
        add ebx, 80h
        add edi, ebp
        call DrawTextAligned
        add esp, byte 10h
        cmp esi, byte 10h
        jl short .8
        jmp short .9
.7:
        mov ecx, dword [GameStatsList]
        push ecx
        call SetDrawTarget
        add esp, byte 4
        mov edi, 5Ah
        push edi
        mov eax, dword [GameStatsRow]
        push byte 28h
        mov esi, dword [byte eax+02Ch]
        push esi
        call BlitArt
        add esp, byte 0Ch
        xor esi, esi
.8:
        cmp esi, dword [ScoringEntryCount]
        jl short .6
.9:
        call SetScreenTarget
        mov eax, dword [GameStatsRow]
        mov eax, dword [byte eax+02Ch]
        mov ebx, dword [byte eax+04h]
        sar ebx, 10h
        add ebx, byte 5Ah
        mov eax, dword [byte eax+02h]
        push ebx
        sar eax, 10h
        push byte 5Ah
        add eax, byte 28h
        push eax
        push byte 28h
        call SetClipWindow
        add esp, byte 10h
        push byte 0
        mov eax, dword [GameStatsList]
        push byte 0
        mov esi, dword [byte eax+02Ch]
        push esi
        call BlitArt
        add esp, byte 0Ch
        call ResetClipWindow
        call PresentScreen
.10:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FormatPlayerStatLine                            A9640  97 PC, low confidence
; Formats a player stats line
;-----------------------------------------------------------------------------
FormatPlayerStatLine:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        cmp dword [GameStatsTeam], byte 0
        jne short .1
        mov dword [esp], AutoLineData
        jmp short .2
.1:
        mov dword [esp], homelines
.2:
        cmp dword [GameStatsDrawn], byte 0
        jne near .6
        mov ecx, dword [esp]
        xor ebx, ebx
        xor edi, edi
        add ecx, 1A0h
        jmp short .5
.3:
        mov eax, dword [StatsLineAssists]
        mov word [ebx+eax], 0
.4:
        mov ax, word [byte esi+02h]
        mov dx, word [esi]
        add edx, eax
        mov eax, dword [StatsLineGoals]
        mov word [ebx+eax], dx
        mov edx, dword [byte esi+06h]
        sar edx, 10h
        add edx, byte 3Bh
        mov esi, 3Ch
        mov eax, edx
        sar edx, 1Fh
        idiv esi
        add ebx, byte 2
        mov edx, eax
        mov eax, dword [StatsLinePoints]
        add ecx, 125h
        inc edi
        mov word [byte ebx+eax-02h], dx
.5:
        mov eax, dword [esp]
        mov eax, dword [dword eax+09Fh]
        sar eax, 10h
        cmp edi, eax
        jge near .14
        mov dx, word [byte ecx+0Eh]
        mov esi, ecx
        test dx, dx
        jle short .3
        movsx edx, word [ecx]
        imul edx, dword 3E8h
        mov ebp, dword [byte ecx+0Ch]
        sar ebp, 10h
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        mov edx, eax
        mov eax, dword [StatsLineAssists]
        mov word [ebx+eax], dx
        jmp short .4
.6:
        mov esi, dword [esp]
        xor ebx, ebx
        xor edi, edi
        add esi, 1E3Fh
        jmp near .13
.7:
        mov dx, word [byte esi+02h]
        mov ecx, esi
        test dx, dx
        jle short .8
        mov ebp, dword [esi]
        mov eax, dword [byte esi+06h]
        sar ebp, 10h
        sar eax, 10h
        mov edx, ebp
        sub edx, eax
        imul edx, dword 3E8h
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        mov edx, eax
        mov eax, dword [StatsLineAssists]
        mov word [ebx+eax], dx
        jmp short .9
.8:
        mov eax, dword [StatsLineAssists]
        mov word [ebx+eax], 0
.9:
        cmp word [gameover], byte 0
        je short .11
        cmp word [ecx], byte 0
        jle short .10
        mov edx, dword [byte ecx+06h]
        sar edx, 10h
        imul edx, dword 57E40h
        movsx ebp, word [ecx]
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        mov edx, eax
        mov eax, dword [StatsLinePenalties]
        mov word [ebx+eax], dx
        jmp short .12
.10:
        mov eax, dword [StatsLinePenalties]
        mov word [ebx+eax], 0
        jmp short .12
.11:
        mov eax, dword [StatsLinePenalties]
        mov word [ebx+eax], 0FFFFh
.12:
        mov ax, word [byte ecx+08h]
        mov dx, word [byte ecx+02h]
        sub edx, eax
        mov eax, dword [StatsLineTotals]
        mov word [ebx+eax], dx
        movsx edx, word [ecx]
        add edx, byte 3Bh
        mov ecx, 3Ch
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        add ebx, byte 2
        mov edx, eax
        mov eax, dword [StatsLinePoints]
        add esi, 125h
        inc edi
        mov word [byte ebx+eax-02h], dx
.13:
        mov eax, dword [esp]
        mov eax, dword [dword eax+01D3Eh]
        sar eax, 10h
        cmp edi, eax
        jl near .7
.14:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawPlayerStatsPage                             A9800  97 PC, low confidence
; Draws the player stats page
;-----------------------------------------------------------------------------
DrawPlayerStatsPage:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        test eax, eax
        je near .3
        cmp dword [GameStatsTeam], byte 0
        jne short .1
        push str_GS24
        mov ecx, str_GS25
        mov eax, dword [gameopts]
        mov edx, dword [GameStatsColumn]
        mov ebx, str_GS24
        add edx, 1ECh
        mov esi, dword [byte eax+01h]
        mov eax, dword [GameStatsTitleFile]
        shl esi, 0Ch
        jmp short .2
.1:
        push str_GS20
        mov ecx, str_GS21
        mov eax, dword [gameopts]
        mov edx, dword [GameStatsColumn]
        mov ebx, str_GS20
        add edx, 1ECh
        mov esi, dword [byte eax+01h]
        mov eax, dword [GameStatsTitleFile]
        shl esi, 6
.2:
        call InitShapeListBox
        shr esi, 1Ah
        mov eax, esi
        call LoadTeamLogo
        mov eax, dword [ShadowShape]
        mov edx, dword [byte eax+04h]
        sar edx, 10h
        push edx
        mov edx, dword [byte eax+02h]
        sar edx, 10h
        push edx
        push dword 82h
        push dword 0C8h
        mov ebx, 10h
        mov edx, dword [GameStatsList]
        push byte 0
        xor ecx, ecx
        mov edx, dword [byte edx+02Ch]
        call DrawShadedLogo
        call FreeLogoArt
        push dword 12Ch
        mov ecx, 54h
        mov ebx, 0Ah
        mov eax, dword [GameStatsList]
        push dword 26Ch
        mov edx, 14h
        mov eax, dword [byte eax+02Ch]
        call DrawShadowBox
        mov ebx, dword [GameStatsList]
        push ebx
        call SetDrawTarget
        mov ecx, 12Ch
        mov ebx, 26Ch
        add esp, byte 4
        mov edx, 54h
        mov eax, 0Ah
        call DrawFrameBox
.3:
        cmp dword [GameStatsDrawn], byte 0
        jne short .4
        push str_GS16
        mov ecx, str_GS17
        mov ebx, str_GS16
        jmp short .5
.4:
        push str_GS12
        mov ecx, str_GS13
        mov ebx, str_GS12
.5:
        mov edx, dword [GameStatsColumn]
        mov eax, dword [GameStatsTitleFile]
        add edx, 23Eh
        call InitShapeListBox
        mov eax, dword [GameStatsColumn]
        add eax, 0F6h
        mov dword [byte eax+022h], 0
        push byte 1
        mov edx, dword [byte eax+022h]
        mov ecx, 1
        mov dword [byte eax+01Eh], edx
        mov ebx, 1E0h
        mov dword [byte eax+01Ah], edx
        mov edx, 280h
        call InitListBox
        mov eax, dword [GameStatsColumn]
        add eax, 148h
        mov dword [byte eax+022h], 0
        push byte 1
        mov edx, dword [byte eax+022h]
        mov ecx, 1
        mov dword [byte eax+01Eh], edx
        mov ebx, 1E0h
        mov dword [byte eax+01Ah], edx
        mov edx, 280h
        call InitListBox
        mov eax, dword [GameStatsColumn]
        add eax, 19Ah
        mov dword [byte eax+022h], 0
        push byte 1
        mov edx, dword [byte eax+022h]
        mov ecx, 1
        mov dword [byte eax+01Eh], edx
        mov ebx, 1E0h
        mov dword [byte eax+01Ah], edx
        mov edx, 280h
        call InitListBox
        mov ebx, 0A4h
.6:
        mov eax, dword [GameStatsColumn]
        add eax, ebx
        mov esi, dword [byte eax+01Ah]
        test esi, esi
        je short .7
        mov edi, dword [byte eax+02Ah]
        push edi
        mov ebp, dword [byte eax+026h]
        push ebp
        push esi
        call DrawArt
        add esp, byte 0Ch
.7:
        add ebx, byte 52h
        cmp ebx, 23Eh
        jne short .6
        call BuildPlayerStatsTable
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; BuildPlayerStatsTable                           A9A10  97 PC, low confidence
; Builds the player stats table
;-----------------------------------------------------------------------------
BuildPlayerStatsTable:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        call FormatPlayerStatLine
        cmp dword [GameStatsTeam], byte 0
        jne short .1
        mov dword [byte esp+04h], AutoLineData
        jmp short .2
.1:
        mov dword [byte esp+04h], homelines
.2:
        mov esi, dword [GameStatsDrawn]
        test esi, esi
        jne near .15
        mov ebx, dword [byte esp+04h]
        xor edx, edx
        lea ecx, [dword ebx+0ABh]
        jmp short .4
.3:
        xor eax, eax
        push ecx
        mov al, byte [dword ebx+0BBh]
        push eax
        xor eax, eax
        mov al, byte [dword ebx+015Fh]
        push eax
        xor eax, eax
        mov al, byte [dword ebx+0160h]
        call PositionAbbrev
        and eax, 0FFh
        push eax
        mov eax, dword [GameStatsLine]
        push str_CDCS
        add eax, esi
        add ebx, 125h
        push eax
        add ecx, 125h
        inc edx
        call sprintf_
        add esi, byte 40h
        add esp, byte 18h
.4:
        mov eax, dword [byte esp+04h]
        mov eax, dword [dword eax+09Fh]
        sar eax, 10h
        cmp edx, eax
        jl short .3
        mov edx, dword [GameStatsList]
        mov ebx, dword [byte edx+02Ch]
        push ebx
        push byte 14h
        push byte 2Dh
        push dword 104h
        push byte 64h
        mov edx, dword [GameStatsColumn]
        push byte 1Eh
        mov ecx, dword [dword edx+0348h]
        push ecx
        add edx, 334h
        mov esi, dword [StatsLineNames]
        push edx
        mov ebx, 0Bh
        mov ecx, 0Ah
        push byte 6
        mov edx, eax
        mov eax, esi
        call AllocStatTable
        mov eax, dword [byte esp+04h]
        xor ebp, ebp
        add eax, 1A0h
        xor esi, esi
        mov dword [esp], eax
        mov eax, dword [byte esp+04h]
        mov dword [byte esp+018h], esi
        mov dword [byte esp+014h], eax
        jmp near .14
.5:
        mov eax, dword [byte esp+014h]
        mov dh, byte [dword eax+015Fh]
        mov edi, dword [esp]
        cmp dh, 0Ah
        jae short .6
        mov edx, dword [byte esp+018h]
        mov ecx, 7
        mov ebx, dword [GameStatsLine]
        mov eax, dword [StatsLineNames]
        add ebx, edx
        mov edx, esi
        jmp short .7
.6:
        mov eax, dword [byte esp+018h]
        mov ecx, 8
        mov ebx, dword [GameStatsLine]
        mov edx, esi
        add ebx, eax
        mov eax, dword [StatsLineNames]
.7:
        call SetStatColumn
        mov eax, dword [StatsLineNames]
        mov ecx, edi
        mov edx, esi
        xor ebx, ebx
        call SetStatCell
        mov ebx, 1
        mov eax, dword [StatsLineNames]
        lea ecx, [byte edi+02h]
        mov edx, esi
        call SetStatCell
        mov ebx, 2
        mov ecx, dword [StatsLineGoals]
        mov eax, dword [StatsLineNames]
        mov edx, esi
        add ecx, ebp
        call SetStatCell
        mov ebx, 3
        mov eax, dword [StatsLineNames]
        lea ecx, [byte edi+06h]
        mov edx, esi
        call SetStatCell
        mov ebx, 4
        mov eax, dword [StatsLineNames]
        lea ecx, [byte edi+04h]
        mov edx, esi
        call SetStatCell
        mov ebx, 5
        mov eax, dword [StatsLineNames]
        lea ecx, [byte edi+010h]
        mov edx, esi
        call SetStatCell
        mov ebx, 6
        mov eax, dword [StatsLineNames]
        lea ecx, [byte edi+0Eh]
        mov edx, esi
        call SetStatCell
        mov ebx, 7
        mov ecx, dword [StatsLineAssists]
        mov eax, dword [StatsLineNames]
        mov edx, esi
        add ecx, ebp
        call SetStatCell
        mov ebx, 8
        mov eax, dword [StatsLineNames]
        lea ecx, [byte edi+0Ch]
        mov edx, esi
        call SetStatCell
        mov ebx, 9
        mov eax, dword [StatsLineNames]
        lea ecx, [byte edi+0Ah]
        mov edx, esi
        call SetStatCell
        mov ebx, 0Ah
        mov ecx, dword [StatsLinePoints]
        mov eax, dword [StatsLineNames]
        mov edx, esi
        add ecx, ebp
        call SetStatCell
        mov eax, dword [byte esp+014h]
        mov al, byte [dword eax+0160h]
        cmp al, 44h
        jb short .8
        jbe short .11
        cmp al, 4Ch
        jb short .12
        jbe short .9
        cmp al, 52h
        je short .10
        jmp short .12
.8:
        cmp al, 43h
        jne short .12
        mov ebx, 1
        jmp short .13
.9:
        mov ebx, 2
        jmp short .13
.10:
        mov ebx, 4
        jmp short .13
.11:
        mov ebx, 8
        jmp short .13
.12:
        xor ebx, ebx
.13:
        mov ecx, dword [byte esp+014h]
        mov eax, dword [StatsLineNames]
        mov edx, esi
        mov edi, dword [byte esp+018h]
        call SetStatRowWidth
        add ebp, byte 2
        mov ebx, dword [esp]
        add ecx, 125h
        inc esi
        add edi, byte 40h
        add ebx, 125h
        mov dword [byte esp+014h], ecx
        mov dword [byte esp+018h], edi
        mov dword [esp], ebx
.14:
        mov eax, dword [byte esp+04h]
        mov eax, dword [dword eax+09Fh]
        sar eax, 10h
        cmp esi, eax
        jl near .5
        mov eax, 18Fh
        mov ebx, 4
        call GetLangText
        xor edx, edx
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 190h
        mov ebx, 4
        mov edx, 1
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 191h
        mov ebx, 4
        mov edx, 2
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 192h
        mov ebx, 9
        mov edx, 3
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 144h
        mov ebx, 4
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov edx, ebx
        mov eax, esi
        call SetStatCellFlag
        mov eax, 193h
        mov ebx, 4
        mov edx, 5
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 194h
        mov ebx, 4
        mov edx, 6
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 195h
        mov ebx, 6
        mov edx, 7
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 146h
        mov ebx, 4
        mov edx, 8
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 145h
        mov ebx, 4
        mov edx, 9
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 147h
        mov ebx, 4
        mov edx, 0Ah
        jmp near .22
.15:
        mov ebx, dword [byte esp+04h]
        xor ecx, ecx
        xor edx, edx
        lea esi, [dword ebx+01D4Ah]
        mov edi, 47h
        jmp short .17
.16:
        xor eax, eax
        push esi
        mov al, byte [dword ebx+01D5Ah]
        push eax
        xor eax, eax
        mov al, byte [dword ebx+01DFEh]
        push eax
        mov eax, edi
        call PositionAbbrev
        and eax, 0FFh
        push eax
        mov eax, dword [GameStatsLine]
        push str_CDCS
        add eax, edx
        add ebx, 125h
        push eax
        add esi, 125h
        inc ecx
        call sprintf_
        add edx, byte 40h
        add esp, byte 18h
.17:
        mov eax, dword [byte esp+04h]
        mov eax, dword [dword eax+01D3Eh]
        sar eax, 10h
        cmp ecx, eax
        jl short .16
        mov edx, dword [GameStatsList]
        mov edi, dword [byte edx+02Ch]
        push edi
        push byte 14h
        push byte 2Dh
        push dword 104h
        push byte 64h
        mov edx, dword [GameStatsColumn]
        push byte 1Eh
        mov ebp, dword [dword edx+0348h]
        mov ebx, 8
        push ebp
        add edx, 334h
        mov esi, dword [StatsLineNames]
        push edx
        mov edx, dword [byte esp+024h]
        xor ecx, ecx
        push byte 6
        mov cl, byte [dword edx+01D40h]
        mov edx, eax
        mov eax, esi
        call AllocStatTable
        xor eax, eax
        mov dword [byte esp+010h], eax
        mov eax, dword [byte esp+04h]
        xor edi, edi
        mov dword [byte esp+08h], eax
        add eax, 1E3Fh
        xor esi, esi
        mov dword [byte esp+0Ch], eax
        jmp near .21
.18:
        mov eax, dword [byte esp+08h]
        mov dl, byte [dword eax+01DFEh]
        mov ebp, dword [byte esp+0Ch]
        cmp dl, 0Ah
        jae short .19
        mov ecx, dword [byte esp+010h]
        mov ebx, dword [GameStatsLine]
        mov eax, dword [StatsLineNames]
        mov edx, esi
        add ebx, ecx
        mov ecx, 7
        jmp short .20
.19:
        mov edx, dword [byte esp+010h]
        mov ecx, 8
        mov ebx, dword [GameStatsLine]
        mov eax, dword [StatsLineNames]
        add ebx, edx
        mov edx, esi
.20:
        call SetStatColumn
        mov eax, dword [StatsLineNames]
        lea ecx, [byte ebp+02h]
        mov edx, esi
        xor ebx, ebx
        call SetStatCell
        mov ebx, 1
        mov ecx, dword [StatsLineTotals]
        mov eax, dword [StatsLineNames]
        mov edx, esi
        add ecx, edi
        call SetStatCell
        mov ebx, 2
        mov ecx, dword [StatsLineAssists]
        mov eax, dword [StatsLineNames]
        mov edx, esi
        add ecx, edi
        call SetStatCell
        mov ebx, 3
        mov eax, dword [StatsLineNames]
        lea ecx, [byte ebp+08h]
        mov edx, esi
        call SetStatCell
        mov ebx, 4
        mov ecx, dword [StatsLinePenalties]
        mov eax, dword [StatsLineNames]
        mov edx, esi
        add ecx, edi
        call SetStatCell
        mov ebx, 5
        mov ecx, dword [StatsLinePoints]
        mov eax, dword [StatsLineNames]
        mov edx, esi
        add ecx, edi
        call SetStatCell
        mov ebx, 6
        mov eax, dword [StatsLineNames]
        lea ecx, [byte ebp+04h]
        mov edx, esi
        call SetStatCell
        mov ebx, 7
        mov eax, dword [StatsLineNames]
        lea ecx, [byte ebp+06h]
        mov edx, esi
        add edi, byte 2
        call SetStatCell
        mov ebp, dword [byte esp+08h]
        mov eax, dword [byte esp+0Ch]
        mov edx, dword [byte esp+010h]
        inc esi
        add ebp, 125h
        add eax, 125h
        add edx, byte 40h
        mov dword [byte esp+08h], ebp
        mov dword [byte esp+0Ch], eax
        mov dword [byte esp+010h], edx
.21:
        mov eax, dword [byte esp+04h]
        mov eax, dword [dword eax+01D3Eh]
        sar eax, 10h
        cmp esi, eax
        jl near .18
        mov eax, 194h
        mov ebx, 4
        call GetLangText
        xor edx, edx
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 196h
        mov ebx, 4
        mov edx, 1
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 197h
        mov ebx, 6
        mov edx, 2
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 198h
        mov ebx, 4
        mov edx, 3
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 199h
        mov ebx, 0Ah
        mov edx, 4
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 147h
        mov ebx, 4
        mov edx, 5
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 18Fh
        mov ebx, 4
        mov edx, 6
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        mov eax, 190h
        mov ebx, 4
        mov edx, 7
.22:
        call GetLangText
        mov esi, dword [StatsLineNames]
        mov ecx, eax
        mov eax, esi
        call SetStatCellFlag
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; GameStatsSound                                  AA170  97 PC, low confidence
; Plays a game stats sound
;-----------------------------------------------------------------------------
GameStatsSound:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov eax, dword [tickcount]
        mov edx, dword [GameStatsSpeechCount]
        mov ebx, eax
        cmp eax, edx
        jle near .5
        mov eax, dword [GameStatsColumn]
        cmp dword [dword eax+0A8h], byte 1
        jne near .4
        cmp word [GameStatsSoundOn], byte 0
        jne short .1
        mov eax, 309h
        mov esi, 1
        call PlaySfx
        mov word [GameStatsSoundOn], si
.1:
        call Random32
        mov ecx, 3
        xor edx, edx
        div ecx
        cmp edx, dword [PostGameLastSpeech]
        jl short .2
        inc edx
.2:
        mov edi, dword [GameStatsPage]
        mov dword [PostGameLastSpeech], edx
        test edi, edi
        jne short .3
        add edx, byte 8
.3:
        push edx
        push str_GS02d
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        mov ebp, dword [GameStatsTitleFile]
        push ebp
        call FindShape
        mov edx, dword [GameStatsColumn]
        mov dword [dword edx+0C2h], eax
        mov eax, dword [GameStatsColumn]
        add esp, byte 8
        mov edx, dword [dword eax+0CEh]
        push edx
        mov ecx, dword [dword eax+0CAh]
        push ecx
        mov esi, dword [dword eax+0C2h]
        push esi
        add ebx, byte 4
        call BlitArt
        add esp, byte 0Ch
        mov dword [GameStatsSpeechCount], ebx
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        cmp word [GameStatsSoundOn], byte 0
        je short .5
        xor ebx, ebx
        call StopAllSfx
        mov word [GameStatsSoundOn], bx
.5:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; GameStatsAnim                                   AA274  97 PC, low confidence
; Animates the game stats screen
;-----------------------------------------------------------------------------
GameStatsAnim:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov eax, dword [tickcount]
        mov edx, dword [GameStatsSpeechCount]
        mov esi, eax
        xor ebx, ebx
        cmp eax, edx
        jle near .13
        mov eax, dword [GameStatsColumn]
        cmp dword [dword eax+0A8h], byte 1
        jne short .2
        call Random32
        mov ecx, 3
        xor edx, edx
        div ecx
        mov ebp, dword [PostGameLastSpeech]
        mov ebx, 1
        cmp edx, ebp
        jl short .1
        inc edx
.1:
        mov dword [PostGameLastSpeech], edx
        add edx, byte 4
        push edx
        push str_GS02d
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        mov eax, dword [GameStatsTitleFile]
        push eax
        call FindShape
        mov edx, dword [GameStatsColumn]
        mov dword [dword edx+0C2h], eax
        mov eax, dword [GameStatsColumn]
        add esp, byte 8
        mov edx, dword [dword eax+0CEh]
        push edx
        mov ecx, dword [dword eax+0CAh]
        push ecx
        mov edi, dword [dword eax+0C2h]
        push edi
        jmp near .10
.2:
        cmp dword [dword eax+01F0h], byte 1
        jne near .6
        call Random32
        mov ecx, 3
        xor edx, edx
        div ecx
        mov edi, dword [PostGameLastSpeech]
        mov ebx, 1
        cmp edx, edi
        jl short .3
        inc edx
.3:
        mov ebp, dword [GameStatsTeam]
        mov dword [PostGameLastSpeech], edx
        test ebp, ebp
        jne short .4
        add edx, byte 18h
        jmp short .5
.4:
        add edx, byte 14h
.5:
        push edx
        push str_GS02d
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        mov eax, dword [GameStatsTitleFile]
        push eax
        call FindShape
        mov edx, dword [GameStatsColumn]
        mov dword [dword edx+020Ah], eax
        mov eax, dword [GameStatsColumn]
        add esp, byte 8
        mov edx, dword [dword eax+0216h]
        push edx
        mov ecx, dword [dword eax+0212h]
        push ecx
        mov edi, dword [dword eax+020Ah]
        push edi
        jmp near .10
.6:
        mov ebp, dword [dword eax+0242h]
        cmp ebp, byte 1
        jne near .11
        call Random32
        mov ecx, 3
        xor edx, edx
        div ecx
        mov eax, dword [PostGameLastSpeech]
        mov ebx, 1
        cmp edx, eax
        jl short .7
        add edx, ebp
.7:
        mov ecx, dword [GameStatsDrawn]
        mov dword [PostGameLastSpeech], edx
        test ecx, ecx
        jne short .8
        add edx, byte 10h
        jmp short .9
.8:
        add edx, byte 0Ch
.9:
        push edx
        push str_GS02d
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        mov edi, dword [GameStatsTitleFile]
        push edi
        call FindShape
        mov edx, dword [GameStatsColumn]
        mov dword [dword edx+025Ch], eax
        mov eax, dword [GameStatsColumn]
        add esp, byte 8
        mov ebp, dword [dword eax+0268h]
        push ebp
        mov edx, dword [dword eax+0264h]
        push edx
        mov ecx, dword [dword eax+025Ch]
        push ecx
.10:
        add esi, byte 4
        call BlitArt
        add esp, byte 0Ch
        mov dword [GameStatsSpeechCount], esi
.11:
        test bx, bx
        je short .12
        cmp word [GameStatsAnimSoundOn], byte 0
        jne short .12
        mov eax, 309h
        mov ecx, 1
        call PlaySfx
        mov word [GameStatsAnimSoundOn], cx
.12:
        test bx, bx
        jne short .13
        cmp word [GameStatsAnimSoundOn], byte 0
        je short .13
        call StopAllSfx
        mov word [GameStatsAnimSoundOn], bx
.13:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
