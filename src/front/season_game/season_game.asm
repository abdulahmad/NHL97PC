; Season game screen: game panels, all-star day and starting the next season game.
bits 32
%include "hockey.inc"
section s_3812E progbits alloc exec nowrite align=1
extern AllStarDay, AllStarLogoArt, BlankMenuItem, BlitArt, BlitShape, BuildAllStarTeams, ClearScreen, ConvertArtNew
extern CreateBitmap, DaysToYear, DrawArt, DrawFrameBox, DrawScreenBackground, DrawShadedLogo, DrawShadowBox, DrawShapeBlended
extern DrawTextAligned, ExitScreen, FadeInScreen, FillStatBar, FindGameRecord, FindNextSeasonGame, FindShape, FindShapeQuiet
extern FinishLeagueGame, FreeBitmap, FreeDbBlock, FreeLogoArt, FreeMemBlock, FrontMusicOn, GameOptionFlags, GameSettings
extern GetLangText, InitMenuItems, InitShapeListBox, LoadDataFile, LoadFrontEndSfx, LoadTeamLogo, MakeColor, MatchupLogoArt
extern MatchupLogoIds, MatchupLogoPos, MenuScreenBitmap, MusicEnabled, OpenArtArchive, OpenDataLibrary, OpenLeagueFile, PeriodAwayTeam
extern PeriodHomeTeam, PlayoffTeams, PlayoffUserActive, PlayoffUserHuman, PlayoffUserIndex, PlayoffUserReplay, PlaySfx, PresentScreen
extern Random32, ResetClipWindow, RunMenu, RunScrollList, ScreenFrameItem, ScreenTitleItem, SeasonActive, SeasonAwayTeam
extern SeasonBackground, SeasonDate, SeasonDay, SeasonDefaultUser, SeasonFileName, SeasonFilePath, SeasonFont, SeasonGameCount
extern SeasonGameDayOffsets, SeasonGameIndex, SeasonGameMenuJumpTable, SeasonHomeTeam, SeasonLastAway, SeasonLastGame, SeasonLastHome, SeasonMonthDays
extern SeasonOpponent, SeasonOpponentJumpTable, SeasonOpponentTextJumpTable, SeasonPanelArt, SeasonPanelShown, SeasonPanelText, SeasonPhase, SeasonPlayedFlag
extern SeasonScreenArt, SeasonScreenState, SeasonStartYears, SeasonUserActive, SeasonUserHuman, SeasonUserIndex, SeasonUserReplay, SeasonUserTeam
extern SecondsToSamples, ServiceIdle, SetClipWindow, SetDrawTarget, SetHighlightText, SetScreenTarget, SetTextColor, ShadowShape
extern ShowMessageBox, ShowScreen, SimulateGame, SparkleFrame, SparkleTable, SparkleTime, SparkleTimer, SparkleX
extern SparkleY, sprintf_, StartSeasonGame, StopAllSfx, str_AB00, str_AB01, str_AB02, str_AB03
extern str_AB04, str_AB05, str_ALST, str_BACK, str_BH00, str_BT00, str_BT02d, str_CDD
extern str_D_DrawSeasonGamePanel, str_FAN0, str_G_DrawLockedGame, str_LOCK, str_LOGO, str_Logo02dFsh, str_LT00, str_PANL
extern str_Punct_DrawLockedGame, str_Punct_DrawSeasonGamePanel, str_SDSD, str_SIM0, str_TITL, tickcount, UpdateGameRecord, UpdateTeamLines
extern WaitIconCount, WaitIconFrame, WaitIconOn, WaitIconShown, WaitIconTime, WaitSoundTime, WipeScreen
global SeasonGameScreen, SeasonGameScreen_13F, SeasonGameScreen_14D, SeasonGameScreen_17B, SeasonGameScreen_182, SeasonGameScreen_1DA, SeasonGameScreen_1E3, SeasonGameScreen_1EC
global SeasonGameScreen_1F3, SeasonGameScreen_238, SeasonGameScreen_2B1, SeasonGameScreen_2CF, SeasonGameScreen_3D3, SeasonGameScreen_3DF, SeasonGameScreen_3EB, SetSeasonUserTeam
global InitSeasonGameScreen, InitSeasonGameScreen_472, TeamHasGamesLeft, FindTeamGame, DrawMatchupLogo, DrawAllStarLogo, DrawGameScore, DrawGameScoreLine
global FindUserOpponent, FindUserOpponent_14D, FindUserOpponent_14E, DrawLockedGame, DrawSeasonGamePanel, SetPlayedTeams, IsAllStarDay, GetAllStarDate
global StartNextSeasonGame, AnimateWaitIcon, AnimateSparkle, AnimateSparkle_6B
;-----------------------------------------------------------------------------
; SeasonGameScreen                                3812E  97 PC, low confidence
; From RunSeasonMenus / RunPlayoffMenus: the next-game screen (HOME / AWAY teams; play, simulate or
; continue, with the "team not present", "unplayed games" and "no games left" messages)
;-----------------------------------------------------------------------------
SeasonGameScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 4F4h, 0
        sub ebp, 82h
        cmp byte [FrontMusicOn], 0
        je short .1
        call MusicEnabled
.1:
        lea eax, [dword ebp-0472h]
        mov dword [SparkleY], eax
        lea eax, [byte ebp+01Eh]
        mov dword [WaitIconShown], 0
        mov dword [SeasonDay], eax
        lea eax, [byte ebp+042h]
        mov dword [SparkleFrame], 0
        mov dword [SeasonGameCount], eax
        lea eax, [byte ebp-0Ah]
        mov dword [WaitIconCount], 0
        mov dword [WaitIconTime], eax
        lea eax, [byte ebp+066h]
        mov dword [WaitIconFrame], 0
        mov dword [SeasonScreenState], eax
        lea eax, [byte ebp-072h]
        mov dword [WaitIconOn], 1
        mov dword [MatchupLogoArt], eax
        call GetAllStarDate
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 53h
        call LoadDataFile
        mov dword [AllStarLogoArt], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 54h
        call LoadDataFile
        push byte 0
        push dword 1E0h
        push dword 280h
        mov dword [SeasonBackground], eax
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [SeasonScreenArt], eax
        call SetSeasonUserTeam
        test eax, eax
        je short .2
        call StartNextSeasonGame
        mov word [SeasonLastGame], ax
        jmp short .3
.2:
        mov dword [SeasonOpponent], 5
        mov word [SeasonLastGame], 0FFFFh
.3:
        lea edx, [dword ebp-0232h]
        lea eax, [dword ebp-0472h]
        call InitSeasonGameScreen
        mov eax, dword [SeasonScreenArt]
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte eax+02Ch]
        xor edi, edi
        call WipeScreen
        jmp short SeasonGameScreen_182.6
SeasonGameScreen_13F:
        call ShowScreen
        mov esi, 1Ah
        mov edi, ecx
        jmp short SeasonGameScreen_182.6
SeasonGameScreen_14D:
        call FadeInScreen
        mov edi, ecx
        cmp dword [SeasonPlayedFlag], byte 0
        je short .4
        mov esi, 1Fh
        jmp short SeasonGameScreen_182.6
.4:
        mov eax, dword [SeasonOpponent]
        mov esi, 1Ah
        cmp eax, byte 5
        ja short SeasonGameScreen_182.6
        jmp dword [nosplit cs:eax*4+SeasonOpponentJumpTable]
SeasonGameScreen_17B:
        mov esi, 0Eh
        jmp short SeasonGameScreen_182.6
SeasonGameScreen_182:
        push byte 1
        mov eax, 24Ch
.5:
        mov edx, 1
        xor ecx, ecx
        xor ebx, ebx
        call GetLangText
        call ShowMessageBox
.6:
        test edi, edi
        jne near SeasonGameScreen_3EB.17
        lea eax, [byte ebp+07Eh]
        push edi
        mov ecx, AnimateSparkle_6B
        mov ebx, 0FFFFFFFFh
        push eax
        lea edx, [dword ebp-0472h]
        mov eax, 7
        call RunMenu
        cmp dword [byte ebp+07Eh], byte 6
        ja short .6
        mov ebx, dword [byte ebp+07Eh]
        lea ecx, [byte edi+01h]
        imul eax, ebx, byte 52h
        jmp dword [nosplit cs:ebx*4+SeasonGameMenuJumpTable]
SeasonGameScreen_1DA:
        push byte 1
        mov eax, 24Dh
        jmp short SeasonGameScreen_182.5
SeasonGameScreen_1E3:
        push byte 1
        mov eax, 24Eh
        jmp short SeasonGameScreen_182.5
SeasonGameScreen_1EC:
        call ExitScreen
        jmp short SeasonGameScreen_182.6
SeasonGameScreen_1F3:
        cmp dword [SeasonGameIndex], byte 0
        jle short SeasonGameScreen_182.6
        push dword [SeasonScreenArt]
        dec dword [SeasonGameIndex]
.7:
        call SetDrawTarget
        add esp, byte 4
        xor eax, eax
        call DrawSeasonGamePanel
        call SetScreenTarget
        push edi
        mov eax, dword [SeasonScreenArt]
        push edi
.8:
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        jmp near SeasonGameScreen_182.6
SeasonGameScreen_238:
        mov ebx, dword [dword eax+ebp-0458h]
        mov edx, dword [dword eax+ebp-044Ch]
        movsx ecx, word [byte ebx+06h]
        movsx ebx, word [byte ebx+04h]
        add ecx, dword [dword eax+ebp-0448h]
        add edx, ebx
        push ecx
        add edx, byte 0Fh
        mov ebx, dword [SeasonScreenArt]
        push edx
        push dword [byte ebx+02Ch]
        mov edx, 9
        push dword [SeasonGameCount]
        mov ebx, dword [dword eax+ebp-044Ch]
        push dword [SeasonDay]
        mov eax, edx
        call RunScrollList
        cmp eax, dword [SeasonGameIndex]
        je near SeasonGameScreen_182.6
        test eax, eax
        jl near SeasonGameScreen_182.6
        cmp eax, byte 9
        jge near SeasonGameScreen_182.6
        push dword [SeasonScreenArt]
        mov dword [SeasonGameIndex], eax
        jmp near SeasonGameScreen_1F3.7
SeasonGameScreen_2B1:
        cmp dword [SeasonGameIndex], byte 8
        jge near SeasonGameScreen_182.6
        push dword [SeasonScreenArt]
        inc dword [SeasonGameIndex]
        jmp near SeasonGameScreen_1F3.7
SeasonGameScreen_2CF:
        push dword [dword eax+ebp-0448h]
        push dword [dword eax+ebp-044Ch]
        push dword [dword eax+ebp-0458h]
        call BlitArt
        add esp, byte 0Ch
        cmp dword [SeasonOpponent], byte 0
        jne near .16
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 20h
        je short .9
        cmp dword [SeasonActive], byte 0
        je short .10
.9:
        mov ebx, 1
        jmp short .11
.10:
        xor ebx, ebx
.11:
        movsx eax, word [SeasonLastGame]
        mov edx, ebx
        call SimulateGame
        cmp dword [SeasonPlayedFlag], byte 0
        je short .12
        movzx ax, byte [PeriodHomeTeam]
        mov word [SeasonLastHome], ax
        movzx ax, byte [PeriodAwayTeam]
        mov dword [SeasonPlayedFlag], 0
        mov word [SeasonLastAway], ax
        jmp short .13
.12:
        mov eax, 1
        call FinishLeagueGame
.13:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 20h
        je short .14
        cmp dword [SeasonActive], byte 0
        je short .15
.14:
        test ebx, ebx
        jne short .15
        mov esi, 1Ah
        inc edi
        jmp near SeasonGameScreen_182.6
.15:
        call StartNextSeasonGame
        push dword [SeasonScreenArt]
        mov word [SeasonLastGame], ax
        call SetDrawTarget
        add esp, byte 4
        mov eax, 1
        call DrawSeasonGamePanel
        call SetScreenTarget
        push byte 0
        mov eax, dword [SeasonScreenArt]
        push byte 0
        jmp near SeasonGameScreen_1F3.8
.16:
        mov eax, dword [SeasonOpponent]
        dec eax
        cmp eax, byte 4
        ja near SeasonGameScreen_182.6
        jmp dword [nosplit cs:eax*4+SeasonOpponentTextJumpTable]
SeasonGameScreen_3D3:
        push byte 1
        mov eax, 1E5h
        jmp near SeasonGameScreen_182.5
SeasonGameScreen_3DF:
        push byte 1
        mov eax, 1E6h
        jmp near SeasonGameScreen_182.5
SeasonGameScreen_3EB:
        push byte 1
        mov eax, 1E7h
        jmp near SeasonGameScreen_182.5
.17:
        xor ebx, ebx
.18:
        mov edx, dword [MatchupLogoArt]
        mov eax, ebx
        push dword [edx+eax*4]
        call FreeBitmap
        inc ebx
        add esp, byte 4
        cmp ebx, byte 1Ah
        jl short .18
        cmp dword [SeasonPanelShown], byte 0
        je short .19
        mov eax, SeasonPanelShown
        call FreeDbBlock
.19:
        mov dword [SeasonPanelShown], 0
        cmp dword [SeasonFont], byte 0
        je short .20
        push dword [SeasonFont]
        call FreeMemBlock
        add esp, byte 4
.20:
        push dword [SeasonScreenArt]
        call FreeBitmap
        add esp, byte 4
        push dword [SeasonBackground]
        call FreeMemBlock
        add esp, byte 4
        push dword [AllStarLogoArt]
        call FreeMemBlock
        add esp, byte 4
        cmp byte [FrontMusicOn], 0
        je short .21
        cmp dword [SeasonPlayedFlag], byte 0
        jne short .21
        call LoadFrontEndSfx
.21:
        mov eax, esi
        lea esp, [dword ebp+082h]
        pop ebp
        jmp near FindUserOpponent_14E
;-----------------------------------------------------------------------------
; SetSeasonUserTeam                               385C3  97 PC, low confidence
; Season schedule screen: works out which team the user follows (playoff pick
; or the season's user team)
;-----------------------------------------------------------------------------
SetSeasonUserTeam:
        push ebx
        push edx
        mov eax, dword [GameSettings]
        and eax, byte 70h
        mov edx, 1
        cmp eax, byte 10h
        jne short .2
        cmp dword [SeasonActive], byte 0
        jne short .2
        mov eax, dword [SeasonDefaultUser]
.1:
        mov dword [SeasonUserIndex], eax
        jmp near .7
.2:
        movzx eax, byte [PlayoffUserIndex]
        mov dword [SeasonUserIndex], eax
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .4
        cmp dword [SeasonUserIndex], byte 0
        jl short .3
        cmp eax, dword [SeasonUserIndex]
        jle short .3
        mov eax, dword [SeasonUserIndex]
        shl eax, 2
        mov ebx, dword [dword eax+PlayoffTeams]
        cmp ebx, dword [SeasonDefaultUser]
        jne short .3
        mov dword [SeasonHomeTeam], ebx
        mov eax, edx
        pop edx
        pop ebx
        ret
.3:
        mov eax, dword [SeasonDefaultUser]
        xor edx, edx
        jmp short .1
.4:
        cmp dword [SeasonUserIndex], byte 0
        jl short .5
        cmp dword [SeasonUserIndex], byte 10h
        jl short .6
.5:
        mov dword [SeasonUserIndex], 0
.6:
        mov eax, dword [SeasonUserIndex]
        mov eax, dword [nosplit eax*4+PlayoffTeams]
.7:
        mov dword [SeasonHomeTeam], eax
        mov eax, edx
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; InitSeasonGameScreen                            38675  97 PC, low confidence
; From SeasonGameScreen: sets up its menu items and art (BACK, TITL,
; AB00-AB05, BH00, BT00) and the HOME / AWAY labels
;-----------------------------------------------------------------------------
InitSeasonGameScreen:
        push ebx
        push ecx
        push esi
        push edi
        enter 14h, 0
        push eax
        mov ebx, edx
        mov edx, eax
        mov eax, 7
        mov dword [byte ebp-04h], 0
        call InitMenuItems
.1:
        mov eax, dword [byte ebp-04h]
        shl eax, 6
        lea edx, [ebx+eax]
        imul eax, dword [byte ebp-04h], byte 52h
        add eax, dword [byte ebp-018h]
        inc dword [byte ebp-04h]
        mov dword [byte eax+014h], edx
        cmp dword [byte ebp-04h], byte 7
        jl short .1
        push dword [SeasonScreenArt]
        call SetDrawTarget
        add esp, byte 4
        push str_BACK
        push dword [AllStarLogoArt]
        call FindShape
        add esp, byte 8
        push eax
        mov dword [SeasonPanelArt], eax
        call BlitShape
        add esp, byte 4
        push str_TITL
        push dword [SeasonBackground]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        mov eax, dword [SeasonScreenArt]
        mov edi, dword [byte ebp-018h]
        mov esi, ScreenTitleItem
        mov eax, dword [byte eax+02Ch]
        add esp, byte 4
        mov ebx, eax
        mov edx, eax
        mov ecx, 52h
        call DrawScreenBackground
        rep movsb
        mov eax, dword [byte ebp-018h]
        mov ecx, 52h
        mov edi, eax
        mov dword [eax], 0
        mov esi, BlankMenuItem
        lea edi, [byte edi+052h]
        rep movsb
        mov ecx, 52h
        mov edi, eax
        mov dword [byte eax+052h], 1
        mov esi, ScreenFrameItem
        lea edi, [dword edi+0A4h]
        push str_AB02
        mov ebx, str_AB00
        rep movsb
        lea edx, [dword eax+0F6h]
        mov dword [dword eax+0A4h], 2
        mov ecx, str_AB01
        mov eax, dword [AllStarLogoArt]
        call InitShapeListBox
        push str_BH00
        mov edx, dword [byte ebp-018h]
        mov ecx, str_BH00
        mov ebx, str_BT00
        mov eax, dword [SeasonBackground]
        add edx, 148h
        call InitShapeListBox
        push str_AB05
        mov edx, dword [byte ebp-018h]
        mov ecx, str_AB04
        mov ebx, str_AB03
        mov eax, dword [AllStarLogoArt]
        add edx, 19Ah
        call InitShapeListBox
        push str_SIM0
        mov edx, dword [byte ebp-018h]
        mov ecx, str_SIM0
        mov eax, dword [SeasonBackground]
        add edx, 1ECh
        mov ebx, ecx
        call InitShapeListBox
        push str_SIM0
        lea eax, [byte ebp-014h]
        push eax
        mov dword [byte ebp-04h], 0
        call sprintf_
        add esp, byte 8
.2:
        mov al, byte [byte ebp-04h]
        add al, 30h
        mov byte [byte ebp-011h], al
        lea eax, [byte ebp-014h]
        push eax
        push dword [SeasonBackground]
        call FindShape
        mov edx, eax
        mov eax, dword [byte ebp-04h]
        add esp, byte 8
        inc dword [byte ebp-04h]
        mov dword [nosplit eax*4+SparkleTable], edx
        cmp dword [byte ebp-04h], byte 4
        jl short .2
        mov dword [byte ebp-04h], 0
.3:
        mov eax, dword [byte ebp-04h]
        add eax, byte 9
        mov ebx, 0Ch
        cdq
        idiv ebx
        push edx
        push str_BT02d
        lea eax, [byte ebp-014h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-014h]
        push eax
        push dword [SeasonBackground]
        mov ebx, dword [byte ebp-04h]
        call FindShape
        mov edx, eax
        mov eax, dword [SeasonDay]
        add esp, byte 8
        mov dword [eax+ebx*4], edx
        lea eax, [byte ebp-014h]
        push eax
        push dword [SeasonBackground]
        mov byte [byte ebp-013h], 48h
        call FindShape
        mov edx, eax
        mov eax, dword [SeasonGameCount]
        inc dword [byte ebp-04h]
        add esp, byte 8
        mov dword [eax+ebx*4], edx
        cmp dword [byte ebp-04h], byte 9
        jl short .3
        push str_FAN0
        lea eax, [byte ebp-014h]
        push eax
        mov dword [byte ebp-04h], 0
        call sprintf_
        add esp, byte 8
.4:
        mov al, byte [byte ebp-04h]
        add al, 30h
        mov byte [byte ebp-011h], al
        lea eax, [byte ebp-014h]
        push eax
        push dword [AllStarLogoArt]
        call FindShape
        mov ebx, dword [WaitIconTime]
        mov edx, eax
        mov eax, dword [byte ebp-04h]
        add esp, byte 8
        inc dword [byte ebp-04h]
        mov dword [ebx+eax*4], edx
        cmp dword [byte ebp-04h], byte 0Ah
        jl short .4
        push str_LT00
        lea eax, [byte ebp-014h]
        push eax
        mov dword [byte ebp-04h], 0
        call sprintf_
        add esp, byte 8
.5:
        mov al, byte [byte ebp-04h]
        add al, 30h
        mov byte [byte ebp-011h], al
        lea eax, [byte ebp-014h]
        push eax
        push dword [AllStarLogoArt]
        call FindShape
        mov ebx, dword [SeasonScreenState]
        mov edx, eax
        mov eax, dword [byte ebp-04h]
        add esp, byte 8
        inc dword [byte ebp-04h]
        mov dword [ebx+eax*4], edx
        cmp dword [byte ebp-04h], byte 6
        jl short .5
        mov eax, 52h
        mov dword [SeasonPanelShown], 0
        call OpenDataLibrary
        push dword [SeasonScreenArt]
        call SetDrawTarget
        add esp, byte 4
        push dword [SeasonHomeTeam]
        push str_Logo02dFsh
        lea eax, [byte ebp-014h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, 3
        mov dword [SeasonAwayTeam], 0
        call SecondsToSamples
        call WaitSoundTime
        push byte 0
        lea eax, [byte ebp-014h]
        push eax
        call OpenArtArchive
        add esp, byte 8
        mov dword [SeasonFont], eax
        test eax, eax
        je short .6
        push str_LOGO
        push eax
        call FindShapeQuiet
        add esp, byte 8
        mov dword [SeasonAwayTeam], eax
.6:
        push byte 28h
        mov ecx, 1B8h
        mov ebx, 6Ch
        mov eax, dword [SeasonScreenArt]
        push byte 5Ah
        mov edx, 14h
        mov eax, dword [byte eax+02Ch]
        call DrawShadowBox
        push dword 40FF80h
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 90h
        call GetLangText
        push eax
        push dword 1BFh
        push byte 78h
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        push dword 0FF4040h
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 91h
        call GetLangText
        push eax
        push dword 1CCh
        push byte 78h
        push byte 0
        mov ebx, 5Ah
        call DrawTextAligned
        mov ecx, 28h
        mov edx, 1B8h
        add esp, byte 10h
        mov eax, 6Ch
        mov dword [byte ebp-04h], 0
        call DrawFrameBox
        call SetHighlightText
.7:
        imul eax, dword [byte ebp-04h], byte 52h
        add eax, dword [byte ebp-018h]
        cmp dword [byte eax+01Ah], byte 0
        je short .8
        push dword [byte eax+02Ah]
        push dword [byte eax+026h]
        push dword [byte eax+01Ah]
        call DrawArt
        add esp, byte 0Ch
.8:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 7
        jl short .7
        mov dword [byte ebp-04h], 0
.9:
        push byte 0
        push byte 42h
        push byte 48h
        call CreateBitmap
        mov edx, dword [byte ebp-04h]
        mov ebx, eax
        mov eax, dword [MatchupLogoArt]
        add esp, byte 0Ch
        mov dword [eax+edx*4], ebx
        mov eax, edx
        call LoadTeamLogo
        mov eax, dword [MatchupLogoArt]
        push dword [eax+edx*4]
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        call ClearScreen
        add esp, byte 4
        push byte 2
        push byte 0FFFFFFF4h
        push dword [ShadowShape]
        push dword 6666h
        call DrawShapeBlended
        add esp, byte 10h
        inc dword [byte ebp-04h]
        call FreeLogoArt
        cmp dword [byte ebp-04h], byte 1Ah
        jl short .9
        push dword [SeasonScreenArt]
        call SetDrawTarget
        add esp, byte 4
        mov eax, 1
        call DrawSeasonGamePanel
InitSeasonGameScreen_472:
        leave
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        push ecx
        push esi
        mov ecx, ebx
        jmp short .11
.10:
        mov ebx, edx
        mov esi, dword [byte eax+020h]
        shl ebx, 4
        add ebx, esi
        movsx esi, byte [ebx]
        cmp esi, ecx
        je short .12
        movsx ebx, byte [byte ebx+01h]
        cmp ebx, ecx
        je short .12
        inc edx
.11:
        movsx ebx, word [byte eax+02h]
        cmp edx, ebx
        jl short .10
.12:
        mov eax, edx
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; TeamHasGamesLeft                                38B1A  97 PC, low confidence
; Whether a team still has a game in the schedule list; returns 1 if so
;-----------------------------------------------------------------------------
TeamHasGamesLeft:
        push ebx
        push ecx
        push esi
        mov ecx, edx
        mov edx, dword [GameSettings]
        and edx, byte 70h
        cmp edx, byte 10h
        jne short .2
        cmp word [SeasonLastHome], byte 0
        jge short .2
.1:
        mov eax, 1
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        movsx ebx, word [byte eax+02h]
.3:
        dec ebx
        test ebx, ebx
        jge short .5
.4:
        xor eax, eax
        pop esi
        pop ecx
        pop ebx
        ret
.5:
        mov edx, ebx
        mov esi, dword [byte eax+020h]
        shl edx, 4
        add edx, esi
        movsx esi, byte [edx]
        cmp esi, ecx
        je short .6
        movsx edx, byte [byte edx+01h]
        cmp edx, ecx
        jne short .3
.6:
        shl ebx, 4
        mov eax, dword [byte eax+020h]
        cmp byte [byte ebx+eax+02h], 0
        jl short .1
        jmp short .4
;-----------------------------------------------------------------------------
; FindTeamGame                                    38B77  97 PC, low confidence
; Returns the index of the last scheduled game that involves the given team,
; -1 if none
;-----------------------------------------------------------------------------
FindTeamGame:
        push ebx
        push ecx
        push esi
        mov ecx, edx
        movsx ebx, word [byte eax+02h]
        jmp short .2
.1:
        mov edx, ebx
        mov esi, dword [byte eax+020h]
        shl edx, 4
        add edx, esi
        movsx esi, byte [edx]
        cmp esi, ecx
        je short .3
        movsx edx, byte [byte edx+01h]
        cmp edx, ecx
        je short .3
.2:
        dec ebx
        test ebx, ebx
        jge short .1
        mov ebx, 0FFFFFFFFh
.3:
        mov eax, ebx
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawMatchupLogo                                 38BAB  97 PC, low confidence
; Draws a team logo in a slot of the season game panel
;-----------------------------------------------------------------------------
DrawMatchupLogo:
        push ecx
        mov ecx, eax
        mov eax, edx
        push dword [nosplit edx*4+str_Punct_DrawLockedGame]
        mov edx, ecx
        mov eax, dword [nosplit eax*4+MatchupLogoPos]
        push dword [nosplit edx*4+str_G_DrawLockedGame]
        add eax, byte 53h
        push eax
        mov eax, dword [nosplit edx*4+MatchupLogoIds]
        add eax, byte 4Ch
        push eax
        mov eax, dword [SeasonScreenArt]
        mov edx, dword [byte eax+02Ch]
        mov eax, ebx
        mov ebx, dword [MatchupLogoArt]
        xor ecx, ecx
        mov eax, dword [ebx+eax*4]
        push byte 0
        mov ebx, 10h
        mov eax, dword [byte eax+02Ch]
        call DrawShadedLogo
        pop ecx
        ret
;-----------------------------------------------------------------------------
; DrawAllStarLogo                                 38BFC  97 PC, low confidence
; Draws the All-Star logo in a slot of the season game panel
;-----------------------------------------------------------------------------
DrawAllStarLogo:
        push ebx
        push ecx
        push esi
        push edi
        mov edi, eax
        mov ebx, edx
        push dword [MenuScreenBitmap]
        push str_ALST
        push dword [AllStarLogoArt]
        call FindShape
        add esp, byte 8
        push eax
        call ConvertArtNew
        mov edx, ebx
        mov esi, eax
        mov eax, dword [nosplit edx*4+str_Punct_DrawLockedGame]
        add esp, byte 8
        dec eax
        dec eax
        mov edx, dword [nosplit edx*4+MatchupLogoPos]
        push eax
        mov eax, edi
        add edx, byte 53h
        push dword [nosplit eax*4+str_G_DrawLockedGame]
        mov eax, dword [nosplit eax*4+MatchupLogoIds]
        push edx
        add eax, byte 4Ch
        xor ecx, ecx
        push eax
        mov eax, dword [SeasonScreenArt]
        mov ebx, 18h
        push byte 2
        mov edx, dword [byte eax+02Ch]
        mov eax, esi
        call DrawShadedLogo
        push esi
        call FreeMemBlock
        add esp, byte 4
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawGameScore                                   38C79  97 PC, low confidence
; Draws a game result in a slot of the season game panel ("W 3-2" style)
;-----------------------------------------------------------------------------
DrawGameScore:
        push esi
        push edi
        enter 14h, 0
        mov esi, eax
        mov edi, edx
        mov dword [byte ebp-010h], ebx
        mov dword [byte ebp-014h], ecx
        mov ebx, dword [byte ebp+010h]
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, dword [byte ebp-010h]
        movsx edx, word [byte ebx+04h]
        mov ecx, dword [nosplit eax*4+str_G_DrawLockedGame]
        sub ecx, edx
        mov eax, dword [nosplit eax*4+MatchupLogoIds]
        mov edx, ecx
        add eax, byte 4Ch
        sar edx, 1
        add eax, edx
        mov dword [byte ebp-04h], eax
        mov eax, dword [byte ebp-014h]
        mov edx, dword [nosplit eax*4+MatchupLogoPos]
        add edx, byte 53h
        add edx, dword [nosplit eax*4+str_Punct_DrawLockedGame]
        movsx eax, word [byte ebx+06h]
        sub edx, eax
        dec edx
        push edx
        push dword [byte ebp-04h]
        push ebx
        mov dword [byte ebp-08h], edx
        call DrawArt
        mov eax, edi
        mov edx, dword [byte esi+020h]
        shl eax, 4
        add eax, edx
        add esp, byte 0Ch
        movsx edx, byte [byte eax+02h]
        mov cl, byte [byte eax+02h]
        mov dword [byte ebp-0Ch], edx
        movsx edx, byte [byte eax+03h]
        cmp cl, byte [byte eax+03h]
        jle short .2
        movsx eax, byte [eax]
        cmp eax, dword [byte ebp+014h]
        jne short .1
        mov eax, 92h
        jmp short .6
.1:
        mov eax, 93h
        jmp short .6
.2:
        jge short .5
        movsx eax, byte [eax]
        cmp eax, dword [byte ebp+014h]
        jne short .3
        mov eax, 93h
        jmp short .4
.3:
        mov eax, 92h
.4:
        call GetLangText
        shl edi, 4
        mov esi, dword [byte esi+020h]
        movsx edx, byte [byte edi+esi+03h]
        mov dword [byte ebp-0Ch], edx
        movsx edx, byte [byte edi+esi+02h]
        jmp short .7
.5:
        mov eax, 94h
.6:
        call GetLangText
.7:
        push edx
        push dword [byte ebp-0Ch]
        movzx eax, byte [eax]
        push eax
        mov eax, dword [byte ebp-08h]
        push str_CDD
        add eax, byte 3
        push eax
        movsx eax, word [byte ebx+04h]
        sar eax, 1
        add eax, dword [byte ebp-04h]
        push eax
        push byte 1
        call DrawTextAligned
        add esp, byte 1Ch
        leave
        pop edi
        pop esi
        ret 8
;-----------------------------------------------------------------------------
; DrawGameScoreLine                               38D84  97 PC, low confidence
; Draws a game result with both team names in a slot of the season game panel
;-----------------------------------------------------------------------------
DrawGameScoreLine:
        push ecx
        push esi
        push edi
        mov edi, eax
        mov esi, edx
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, edi
        movsx edi, word [byte ebx+04h]
        mov edx, dword [nosplit eax*4+str_G_DrawLockedGame]
        sub edx, edi
        mov eax, dword [nosplit eax*4+MatchupLogoIds]
        mov edi, edx
        add eax, byte 4Ch
        sar edi, 1
        add edi, eax
        mov eax, esi
        mov edx, dword [nosplit eax*4+MatchupLogoPos]
        add edx, byte 53h
        add edx, dword [nosplit eax*4+str_Punct_DrawLockedGame]
        movsx eax, word [byte ebx+06h]
        sub edx, eax
        lea esi, [byte edx-01h]
        push esi
        push edi
        push ebx
        call DrawArt
        add esp, byte 0Ch
        movsx eax, word [SeasonLastAway]
        push eax
        mov eax, 24Bh
        movsx edx, word [SeasonLastHome]
        call GetLangText
        push eax
        push edx
        mov eax, 24Ah
        add esi, byte 3
        call GetLangText
        push eax
        movsx eax, word [byte ebx+04h]
        push str_SDSD
        sar eax, 1
        push esi
        add eax, edi
        push eax
        push byte 1
        call DrawTextAligned
        add esp, byte 20h
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; FindUserOpponent                                38E26  97 PC, low confidence
; Finds the opponent of the user's team in the current scheduled game
;-----------------------------------------------------------------------------
FindUserOpponent:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 4, 0
        movsx edx, word [SeasonLastGame]
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        add eax, edx
        movsx ecx, byte [eax]
        cmp ecx, dword [SeasonUserIndex]
        jne short .1
        movsx ecx, byte [byte eax+01h]
.1:
        mov eax, dword [SeasonUserTeam]
        mov esi, ecx
        xor ebx, ebx
        jmp short .3
.2:
        mov edx, ebx
        shl edx, 4
        mov dword [byte ebp-04h], edx
        mov edx, dword [byte eax+020h]
        add edx, dword [byte ebp-04h]
        movsx edi, byte [edx]
        cmp esi, edi
        je short .4
        movsx edx, byte [byte edx+01h]
        cmp edx, esi
        je short .4
        inc ebx
.3:
        movsx edx, word [byte eax+02h]
        cmp ebx, edx
        jl short .2
.4:
        mov eax, dword [SeasonUserTeam]
.5:
        mov edx, ebx
        movsx ebx, word [byte eax+02h]
        cmp edx, ebx
        jge short .8
        mov ebx, edx
        mov esi, dword [byte eax+020h]
        shl ebx, 4
        cmp byte [byte esi+ebx+02h], 0
        jl short .8
        mov esi, ecx
        lea ebx, [byte edx+01h]
        jmp short .7
.6:
        mov edx, ebx
        mov edi, dword [byte eax+020h]
        shl edx, 4
        add edx, edi
        movsx edi, byte [edx]
        cmp esi, edi
        je short .5
        movsx edx, byte [byte edx+01h]
        cmp edx, esi
        je short .5
        inc ebx
.7:
        movsx edx, word [byte eax+02h]
        cmp ebx, edx
        jl short .6
        jmp short .5
.8:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .11
        cmp dword [SeasonActive], byte 0
        jne short .11
        imul eax, dword [SeasonUserIndex], byte 1Ch
        test byte [dword eax+SeasonUserHuman], 1
        jne short .9
        imul eax, ecx, byte 1Ch
        test byte [dword eax+SeasonUserHuman], 1
        je short .10
.9:
        mov dword [SeasonOpponent], 1
        jmp near FindUserOpponent_14D
.10:
        movsx ebx, word [SeasonLastGame]
        cmp edx, ebx
        jge short FindUserOpponent_14D
        test byte [dword eax+SeasonUserActive], 1
        je short FindUserOpponent_14D
        mov dword [SeasonOpponent], 2
        jmp short FindUserOpponent_14D
.11:
        imul eax, dword [SeasonUserIndex], byte 1Ch
        test byte [dword eax+PlayoffUserHuman], 1
        jne short .12
        imul eax, ecx, byte 1Ch
        test byte [dword eax+PlayoffUserHuman], 1
        je short .13
.12:
        mov dword [SeasonOpponent], 3
        jmp short FindUserOpponent_14D
.13:
        movsx ebx, word [SeasonLastGame]
        cmp edx, ebx
        jge short FindUserOpponent_14D
        test byte [dword eax+PlayoffUserActive], 1
        je short FindUserOpponent_14D
        mov dword [SeasonOpponent], 4
FindUserOpponent_14D:
        leave
FindUserOpponent_14E:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawLockedGame                                  38F7A  97 PC, low confidence
; Draws the lock symbol over a game slot that cannot be played yet
;-----------------------------------------------------------------------------
DrawLockedGame:
        push ebx
        push ecx
        push esi
        push edi
        enter 8, 0
        mov esi, eax
        shl esi, 2
        mov eax, dword [dword esi+MatchupLogoIds]
        mov edi, edx
        add eax, byte 4Ch
        shl edi, 2
        mov dword [byte ebp-04h], eax
        mov eax, dword [dword edi+MatchupLogoPos]
        push byte 3
        add eax, byte 53h
        push dword 0FFFFFF50h
        mov dword [byte ebp-08h], eax
        call MakeColor
        mov edx, dword [byte ebp-08h]
        add esp, byte 4
        mov ecx, dword [dword edi+str_Punct_DrawLockedGame]
        mov ebx, dword [dword esi+str_G_DrawLockedGame]
        push eax
        add ecx, byte 6
        add ebx, byte 6
        mov eax, dword [byte ebp-04h]
        sub edx, byte 3
        sub eax, byte 3
        call FillStatBar
        cmp dword [SeasonOpponent], byte 0
        je near InitSeasonGameScreen_472
        push str_LOCK
        push dword [AllStarLogoArt]
        call FindShape
        movsx edx, word [byte eax+04h]
        mov ebx, dword [dword esi+str_G_DrawLockedGame]
        sub ebx, edx
        mov edx, ebx
        sar edx, 1
        mov ebx, dword [dword edi+str_Punct_DrawLockedGame]
        add dword [byte ebp-04h], edx
        movsx edx, word [byte eax+06h]
        sub ebx, edx
        mov edx, ebx
        sar edx, 1
        add esp, byte 8
        add dword [byte ebp-08h], edx
        push dword [byte ebp-08h]
        push dword [byte ebp-04h]
        push eax
        call DrawArt
        add esp, byte 0Ch
        jmp near InitSeasonGameScreen_472
        push edx
        mov edx, dword [GameSettings]
        and edx, byte 70h
        cmp edx, byte 10h
        jne short .1
        cmp dword [SeasonActive], byte 0
        je short .2
.1:
        mov eax, dword [nosplit eax*4+PlayoffTeams]
.2:
        pop edx
        ret
;-----------------------------------------------------------------------------
; DrawSeasonGamePanel                             39052  97 PC, low confidence
; From SeasonGameScreen: draws the team panel (PANL) from the league file:
; records ("%c %d-%d" W / L / T), scores ("%s %d-%s %d"), LOCK marks
;-----------------------------------------------------------------------------
DrawSeasonGamePanel:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 28h, 0
        mov ebx, eax
        mov eax, dword [GameSettings]
        and eax, byte 70h
        mov dword [byte ebp-010h], 1
        cmp eax, byte 10h
        jne short .3
        cmp dword [SeasonActive], byte 0
        je short .3
        movzx eax, byte [PlayoffUserIndex]
        mov dword [SeasonUserIndex], eax
        test eax, eax
        jl short .1
        cmp eax, byte 10h
        jge short .1
        mov eax, dword [nosplit eax*4+PlayoffTeams]
        cmp eax, dword [SeasonDefaultUser]
        jne short .1
        mov dword [byte ebp-010h], 1
        jmp short .2
.1:
        mov dword [byte ebp-010h], 0
.2:
        cmp dword [SeasonPanelShown], byte 0
        jne short .3
        mov edx, SeasonPanelShown
        mov eax, SeasonFilePath
        call OpenLeagueFile
        test eax, eax
        jne short .3
        mov dword [SeasonPanelShown], eax
.3:
        push str_PANL
        push dword [AllStarLogoArt]
        call FindShape
        add esp, byte 8
        mov dword [byte ebp-01Ch], eax
        cmp dword [byte ebp-010h], byte 0
        je short .4
        cmp word [SeasonLastGame], byte 0
        jge short .4
        mov edx, dword [SeasonUserIndex]
        mov eax, dword [SeasonUserTeam]
        call FindTeamGame
        mov word [SeasonLastGame], ax
.4:
        test ebx, ebx
        je near .9
        cmp dword [byte ebp-010h], byte 0
        je near .9
        xor esi, esi
.5:
        mov ax, word [nosplit esi*4+str_Punct_DrawSeasonGamePanel]
        inc eax
        mov ebx, 1
        movsx edx, ax
        movsx eax, word [nosplit esi*2+SeasonStartYears]
        call DaysToYear
        mov bx, word [nosplit esi*4+SeasonMonthDays]
        mov edx, eax
        add ebx, eax
        cmp dword [SeasonPlayedFlag], byte 0
        jne short .7
        movsx edi, word [SeasonLastGame]
        mov eax, dword [SeasonUserTeam]
        shl edi, 4
        mov eax, dword [byte eax+020h]
        add eax, edi
        cmp dx, word [byte eax+04h]
        ja short .8
        cmp bx, word [byte eax+04h]
.6:
        jbe short .8
        mov dword [SeasonGameIndex], esi
        jmp short .9
.7:
        cmp ax, word [SeasonDate]
        ja short .8
        cmp bx, word [SeasonDate]
        jmp short .6
.8:
        inc esi
        cmp esi, byte 9
        jl short .5
.9:
        mov eax, dword [SeasonGameIndex]
        mov ax, word [nosplit eax*4+str_Punct_DrawSeasonGamePanel]
        inc eax
        movsx edx, ax
        mov eax, dword [SeasonGameIndex]
        mov ebx, 1
        movsx eax, word [nosplit eax*2+SeasonStartYears]
        xor edi, edi
        call DaysToYear
        mov dword [byte ebp-04h], eax
        jmp short .11
.10:
        mov edx, edi
        mov eax, dword [byte eax+020h]
        shl edx, 4
        mov ax, word [byte edx+eax+04h]
        cmp ax, word [byte ebp-04h]
        jae short .12
        inc edi
.11:
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [byte eax+02h]
        cmp edi, edx
        jl short .10
.12:
        test edi, edi
        jne near .19
        mov edx, edi
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        mov ax, word [byte edx+eax+04h]
        cmp ax, word [byte ebp-04h]
        jbe near .19
        cmp dword [SeasonPanelShown], byte 0
        je near .20
        mov dword [byte ebp-08h], edi
        jmp short .14
.13:
        mov edx, dword [byte ebp-08h]
        mov eax, dword [byte eax+020h]
        shl edx, 4
        mov ax, word [byte edx+eax+04h]
        cmp ax, word [byte ebp-04h]
        jae short .15
        inc dword [byte ebp-08h]
.14:
        mov eax, dword [SeasonPanelShown]
        movsx edx, word [byte eax+02h]
        cmp edx, dword [byte ebp-08h]
        jg short .13
.15:
        mov eax, dword [SeasonHomeTeam]
        mov dword [byte ebp-018h], eax
        mov esi, dword [byte ebp-08h]
        mov edx, dword [byte ebp-018h]
        mov eax, dword [SeasonPanelShown]
        jmp short .17
.16:
        mov ebx, esi
        shl ebx, 4
        mov dword [byte ebp-024h], ebx
        mov ebx, dword [byte eax+020h]
        add ebx, dword [byte ebp-024h]
        movsx ecx, byte [ebx]
        cmp edx, ecx
        je short .18
        movsx ebx, byte [byte ebx+01h]
        cmp ebx, edx
        je short .18
        inc esi
.17:
        movsx ebx, word [byte eax+02h]
        cmp esi, ebx
        jl short .16
.18:
        mov dword [byte ebp-08h], esi
        jmp short .20
.19:
        mov dword [byte ebp-08h], 270Fh
.20:
        cmp dword [byte ebp-010h], byte 0
        je short .24
        cmp dword [SeasonOpponent], byte 5
        je short .24
        mov edx, dword [SeasonUserIndex]
        mov ebx, dword [SeasonUserTeam]
        jmp short .22
.21:
        mov eax, edi
        mov esi, dword [byte ebx+020h]
        shl eax, 4
        add eax, esi
        movsx esi, byte [eax]
        cmp esi, edx
        je short .23
        movsx eax, byte [byte eax+01h]
        cmp eax, edx
        je short .23
        inc edi
.22:
        movsx eax, word [byte ebx+02h]
        cmp edi, eax
        jl short .21
.23:
        cmp dword [SeasonPlayedFlag], byte 0
        jne short .25
        call FindUserOpponent
        jmp short .25
.24:
        cmp dword [SeasonOpponent], byte 0
        jne short .25
        mov dword [SeasonOpponent], 5
.25:
        cmp dword [byte ebp-010h], byte 0
        je short .28
        movsx edx, word [SeasonLastGame]
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov ebx, dword [byte eax+020h]
        cmp byte [byte edx+ebx+02h], 0
        jl short .28
        test edi, edi
        jl short .28
        movsx edx, word [byte eax+02h]
        cmp edi, edx
        jge short .28
        mov edx, dword [SeasonUserIndex]
        mov ebx, eax
        jmp short .27
.26:
        mov esi, edi
        mov eax, dword [byte ebx+020h]
        shl esi, 4
        add eax, esi
        movsx esi, byte [eax]
        cmp esi, edx
        je short .28
        movsx eax, byte [byte eax+01h]
        cmp eax, edx
        je short .28
        inc edi
.27:
        movsx eax, word [byte ebx+02h]
        cmp edi, eax
        jl short .26
.28:
        mov edx, dword [SeasonGameIndex]
        mov eax, dword [SeasonDay]
        shl edx, 2
        add edx, eax
        mov eax, dword [SparkleY]
        mov edx, dword [edx]
        mov dword [dword eax+0162h], edx
        mov edx, dword [SeasonGameIndex]
        mov eax, dword [SeasonGameCount]
        shl edx, 2
        add edx, eax
        mov eax, dword [SparkleY]
        mov edx, dword [edx]
        mov dword [dword eax+016Ah], edx
        mov eax, dword [SparkleY]
        mov dword [dword eax+0166h], edx
        mov eax, dword [SparkleY]
        push dword [dword eax+0172h]
        push dword [dword eax+016Eh]
        push dword [dword eax+0162h]
        call BlitArt
        add esp, byte 0Ch
        cmp dword [SeasonAwayTeam], byte 0
        je near .29
        mov eax, dword [SeasonAwayTeam]
        movsx eax, word [byte eax+06h]
        add eax, byte 53h
        push eax
        push byte 53h
        push byte 4Ch
        push byte 49h
        call SetClipWindow
        add esp, byte 10h
        push dword [SeasonPanelArt]
        call BlitShape
        mov eax, dword [SeasonAwayTeam]
        movsx edx, word [byte eax+06h]
        add esp, byte 4
        add edx, byte 53h
        push edx
        movsx eax, word [byte eax+04h]
        push byte 53h
        lea edx, [byte eax+04Fh]
        push edx
        add eax, byte 4Ch
        push eax
        call SetClipWindow
        add esp, byte 10h
        push dword [SeasonPanelArt]
        call BlitShape
        add esp, byte 4
        mov eax, dword [SeasonAwayTeam]
        push byte 53h
        movsx eax, word [byte eax+04h]
        push byte 50h
        add eax, byte 52h
        push eax
        push byte 49h
        call SetClipWindow
        add esp, byte 10h
        push dword [SeasonPanelArt]
        call BlitShape
        mov eax, dword [SeasonAwayTeam]
        movsx edx, word [byte eax+06h]
        add esp, byte 4
        lea ebx, [byte edx+056h]
        push ebx
        add edx, byte 53h
        movsx eax, word [byte eax+04h]
        push edx
        add eax, byte 52h
        push eax
        push byte 49h
        call SetClipWindow
        add esp, byte 10h
        push dword [SeasonPanelArt]
        call BlitShape
        add esp, byte 4
        push dword 1E0h
        push byte 0
        push dword 280h
        push byte 0
        call SetClipWindow
        add esp, byte 10h
        push byte 53h
        push byte 4Ch
        push dword [SeasonAwayTeam]
        call BlitArt
        add esp, byte 0Ch
.29:
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        mov ebx, 7
        xor esi, esi
        call SetTextColor
.30:
        mov eax, dword [SeasonGameIndex]
        mov eax, dword [nosplit eax*4+SeasonGameDayOffsets]
        add eax, esi
        cdq
        idiv ebx
        mov eax, dword [nosplit edx*4+SeasonPanelText]
        call GetLangText
        push eax
        mov edx, dword [nosplit esi*4+MatchupLogoIds]
        mov eax, dword [nosplit esi*4+str_G_DrawLockedGame]
        add edx, byte 4Ch
        sar eax, 1
        push byte 55h
        add eax, edx
        push eax
        push byte 1
        inc esi
        call DrawTextAligned
        add esp, byte 10h
        cmp esi, ebx
        jl short .30
        xor esi, esi
        jmp near .53
.31:
        call ServiceIdle
        mov eax, esi
        mov ebx, 7
        cdq
        idiv ebx
        mov eax, esi
        mov dword [byte ebp-028h], edx
        cdq
        idiv ebx
        push byte 0FFFFFFFFh
        mov dword [byte ebp-0Ch], eax
        call MakeColor
        add esp, byte 4
        mov dword [byte ebp-014h], eax
        cmp dword [byte ebp-010h], byte 0
        je near .44
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [byte eax+02h]
        cmp edi, edx
        jge near .41
        mov edx, edi
        mov eax, dword [byte eax+020h]
        shl edx, 4
        add eax, edx
        movzx edx, word [byte ebp-04h]
        movzx ebx, word [byte eax+04h]
        add edx, esi
        cmp ebx, edx
        jne near .41
        mov ebx, dword [GameSettings]
        movsx edx, byte [eax]
        and ebx, byte 70h
        cmp edx, dword [SeasonUserIndex]
        jne short .34
        movsx eax, byte [byte eax+01h]
        mov edx, eax
        cmp ebx, byte 10h
        jne short .32
        cmp dword [SeasonActive], byte 0
        jne short .32
        mov ebx, eax
        jmp short .33
.32:
        mov ebx, dword [nosplit edx*4+PlayoffTeams]
.33:
        push dword 40FF80h
        jmp short .37
.34:
        mov eax, edx
        cmp ebx, byte 10h
        jne short .35
        cmp dword [SeasonActive], byte 0
        je short .36
.35:
        mov edx, dword [nosplit eax*4+PlayoffTeams]
.36:
        push dword 0FF4040h
        mov ebx, edx
.37:
        call MakeColor
        add esp, byte 4
        mov dword [byte ebp-014h], eax
        mov edx, dword [byte ebp-0Ch]
        mov eax, dword [byte ebp-028h]
        call DrawMatchupLogo
        mov ebx, edi
        mov eax, dword [SeasonUserTeam]
        shl ebx, 4
        mov edx, dword [byte eax+020h]
        cmp byte [byte edx+ebx+02h], 0
        jl short .38
        mov ecx, dword [byte ebp-0Ch]
        push dword [SeasonUserIndex]
        mov ebx, dword [byte ebp-028h]
        push dword [byte ebp-01Ch]
        mov edx, edi
        call DrawGameScore
.38:
        mov edx, dword [SeasonUserIndex]
        mov eax, dword [SeasonUserTeam]
        jmp short .40
.39:
        mov ebx, edi
        mov ecx, dword [byte eax+020h]
        shl ebx, 4
        add ebx, ecx
        movsx ecx, byte [ebx]
        cmp edx, ecx
        je short .41
        movsx ebx, byte [byte ebx+01h]
        cmp ebx, edx
        je short .41
.40:
        inc edi
        movsx ebx, word [byte eax+02h]
        cmp edi, ebx
        jl short .39
.41:
        cmp dword [SeasonPlayedFlag], byte 0
        je short .42
        movzx eax, word [byte ebp-04h]
        lea edx, [eax+esi]
        movzx eax, word [SeasonDate]
        cmp edx, eax
        jne short .44
        jmp short .43
.42:
        movsx edx, word [SeasonLastGame]
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        movzx ebx, word [byte ebp-04h]
        add eax, edx
        add ebx, esi
        movzx edx, word [byte eax+04h]
        cmp edx, ebx
        jne short .44
        cmp byte [byte eax+02h], 0
        jge short .44
.43:
        mov edx, dword [byte ebp-0Ch]
        mov eax, dword [byte ebp-028h]
        call DrawLockedGame
.44:
        cmp dword [SeasonPanelShown], byte 0
        je near .51
        mov eax, dword [SeasonPanelShown]
        movsx edx, word [byte eax+02h]
        cmp edx, dword [byte ebp-08h]
        jle near .51
        mov edx, dword [byte ebp-08h]
        mov eax, dword [byte eax+020h]
        shl edx, 4
        movzx ebx, word [byte ebp-04h]
        add eax, edx
        add ebx, esi
        movzx edx, word [byte eax+04h]
        cmp edx, ebx
        jne near .51
        movsx ebx, byte [eax]
        cmp ebx, dword [byte ebp-018h]
        jne short .45
        push dword 40FF80h
        movsx ebx, byte [byte eax+01h]
        jmp short .46
.45:
        push dword 0FF4040h
.46:
        call MakeColor
        add esp, byte 4
        mov dword [byte ebp-014h], eax
        mov edx, dword [byte ebp-0Ch]
        mov eax, dword [byte ebp-028h]
        call DrawMatchupLogo
        mov edx, dword [byte ebp-08h]
        mov eax, dword [SeasonPanelShown]
        shl edx, 4
        mov ebx, dword [byte eax+020h]
        cmp byte [byte edx+ebx+02h], 0
        jl short .47
        push dword [byte ebp-018h]
        mov ecx, dword [byte ebp-0Ch]
        mov ebx, dword [byte ebp-028h]
        push dword [byte ebp-01Ch]
        mov edx, dword [byte ebp-08h]
        call DrawGameScore
.47:
        mov edx, dword [byte ebp-08h]
        mov ebx, dword [byte ebp-018h]
        mov eax, dword [SeasonPanelShown]
        inc edx
        mov dword [byte ebp-020h], ebx
        jmp short .49
.48:
        mov ebx, edx
        mov ecx, dword [byte eax+020h]
        shl ebx, 4
        add ebx, ecx
        movsx ecx, byte [ebx]
        cmp ecx, dword [byte ebp-020h]
        je short .50
        movsx ebx, byte [byte ebx+01h]
        cmp ebx, dword [byte ebp-020h]
        je short .50
        inc edx
.49:
        movsx ebx, word [byte eax+02h]
        cmp edx, ebx
        jl short .48
.50:
        mov dword [byte ebp-08h], edx
.51:
        movzx edx, word [byte ebp-04h]
        movzx eax, word [SeasonDate]
        add edx, esi
        cmp edx, eax
        jne short .52
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 20h
        je short .52
        mov edx, dword [byte ebp-0Ch]
        mov eax, dword [byte ebp-028h]
        call DrawAllStarLogo
        cmp word [SeasonLastHome], byte 0
        jl short .52
        mov ebx, dword [byte ebp-01Ch]
        mov edx, dword [byte ebp-0Ch]
        mov eax, dword [byte ebp-028h]
        call DrawGameScoreLine
.52:
        mov eax, dword [byte ebp-014h]
        call SetTextColor
        inc esi
        mov eax, dword [byte ebp-0Ch]
        push esi
        mov eax, dword [nosplit eax*4+MatchupLogoPos]
        push str_D_DrawSeasonGamePanel
        add eax, byte 56h
        push eax
        mov eax, dword [byte ebp-028h]
        mov edx, dword [nosplit eax*4+MatchupLogoIds]
        add edx, byte 4Ch
        add edx, dword [nosplit eax*4+str_G_DrawLockedGame]
        sub edx, byte 3
        push edx
        push byte 2
        call DrawTextAligned
        add esp, byte 14h
.53:
        mov eax, dword [SeasonGameIndex]
        cmp esi, dword [nosplit eax*4+SeasonMonthDays]
        jl near .31
        push dword 198h
        push byte 0
        push dword 280h
        push byte 0
        call SetClipWindow
        mov eax, dword [SeasonScreenState]
        add esp, byte 10h
        push dword [eax]
        call BlitShape
        mov eax, dword [SeasonScreenState]
        add esp, byte 4
        push dword [byte eax+0Ch]
        call BlitShape
        add esp, byte 4
        call ResetClipWindow
        jmp near FindUserOpponent_14D
;-----------------------------------------------------------------------------
; SetPlayedTeams                                  397FD  97 PC, low confidence
; Copies the two teams of the game just played into the season state
;-----------------------------------------------------------------------------
SetPlayedTeams:
        movzx ax, byte [PeriodHomeTeam]
        mov word [SeasonLastHome], ax
        movzx ax, byte [PeriodAwayTeam]
        mov dword [SeasonPlayedFlag], 0
        mov word [SeasonLastAway], ax
        ret
;-----------------------------------------------------------------------------
; IsAllStarDay                                    39824  97 PC, low confidence
; In a season: whether today is the All-Star game day; returns 1 if so
;-----------------------------------------------------------------------------
IsAllStarDay:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .1
        cmp dword [SeasonActive], byte 0
        jne short .1
        call GetAllStarDate
        cmp ax, word [AllStarDay]
        jne short .1
        mov eax, 1
        ret
.1:
        xor eax, eax
        ret
;-----------------------------------------------------------------------------
; GetAllStarDate                                  39851  97 PC, low confidence
; Returns the day number of the All-Star game (earlier in a short season)
;-----------------------------------------------------------------------------
GetAllStarDate:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .1
        cmp dword [SeasonPhase], byte 2
        jne short .1
        mov word [SeasonDate], 88DCh
        jmp short .2
.1:
        mov word [SeasonDate], 890Bh
.2:
        mov ax, word [SeasonDate]
        ret
;-----------------------------------------------------------------------------
; StartNextSeasonGame                             39882  97 PC, low confidence
; Season: finds the next game to play, builds the All-Star teams on that day
; and sets up the matchup
;-----------------------------------------------------------------------------
StartNextSeasonGame:
        push ebx
        push edx
        push esi
        push edi
        enter 195Ch, 0
        mov edx, dword [SeasonUserIndex]
        mov eax, dword [SeasonUserTeam]
        call TeamHasGamesLeft
        test eax, eax
        jne short .1
        mov eax, 0FFFFFFFFh
        mov dword [SeasonOpponent], 5
        jmp near .11
.1:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        mov dword [SeasonOpponent], 0
        cmp eax, byte 10h
        jne short .2
        cmp dword [SeasonActive], byte 0
        jne short .2
        mov esi, dword [SeasonDefaultUser]
        jmp short .3
.2:
        movzx esi, byte [PlayoffUserIndex]
.3:
        mov eax, dword [SeasonUserTeam]
        shl esi, 3
        mov eax, dword [byte eax+014h]
        lea edi, [byte ebp-0Ch]
        add esi, eax
        movsd
        movsd
        lea ebx, [byte ebp-04h]
        lea edx, [byte ebp-0Ch]
        mov eax, dword [SeasonUserTeam]
        call FindNextSeasonGame
        test eax, eax
        jne short .4
        mov eax, dword [SeasonUserTeam]
        mov ax, word [byte eax+02h]
        dec eax
        mov dword [byte ebp-04h], eax
.4:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .5
        cmp word [SeasonLastHome], byte 0
        jge short .5
        movsx edx, word [byte ebp-04h]
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        mov ax, word [byte edx+eax+04h]
        cmp ax, word [SeasonDate]
        jbe short .5
        call BuildAllStarTeams
        mov eax, dword [GameOptionFlags]
        and dword [byte eax+01h], 0FFF03FFFh
        or dword [byte eax+01h], 68000h
        mov eax, dword [GameOptionFlags]
        and word [byte eax+03h], 0FC0Fh
        or word [byte eax+03h], 1B0h
        mov dword [SeasonPlayedFlag], 1
        jmp near .10
.5:
        movsx ebx, word [byte ebp-04h]
        mov dword [SeasonPlayedFlag], 0
        mov edx, dword [SeasonUserTeam]
        shl ebx, 4
        mov eax, dword [byte edx+020h]
        mov ax, word [byte ebx+eax+04h]
        mov word [AllStarDay], ax
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .6
        cmp dword [SeasonActive], byte 0
        jne short .6
        mov edx, dword [byte edx+020h]
        movsx edx, byte [edx+ebx]
        mov eax, dword [GameOptionFlags]
        and edx, byte 3Fh
        and dword [byte eax+01h], 0FFF03FFFh
        shl edx, 0Eh
        or dword [byte eax+01h], edx
        movsx ebx, word [byte ebp-04h]
        mov edx, dword [SeasonUserTeam]
        shl ebx, 4
        mov edx, dword [byte edx+020h]
        movsx edx, byte [byte edx+ebx+01h]
        jmp short .7
.6:
        movsx ebx, word [byte ebp-04h]
        mov edx, dword [SeasonUserTeam]
        shl ebx, 4
        mov edx, dword [byte edx+020h]
        movsx edx, byte [edx+ebx]
        mov edx, dword [nosplit edx*4+PlayoffTeams]
        mov eax, dword [GameOptionFlags]
        and edx, byte 3Fh
        and dword [byte eax+01h], 0FFF03FFFh
        shl edx, 0Eh
        or dword [byte eax+01h], edx
        movsx ebx, word [byte ebp-04h]
        mov edx, dword [SeasonUserTeam]
        shl ebx, 4
        mov edx, dword [byte edx+020h]
        movsx edx, byte [byte edx+ebx+01h]
        mov edx, dword [nosplit edx*4+PlayoffTeams]
.7:
        mov eax, dword [GameOptionFlags]
        and edx, byte 3Fh
        and word [byte eax+03h], 0FC0Fh
        shl edx, 14h
        or dword [byte eax+01h], edx
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .8
        cmp dword [SeasonActive], byte 0
        jne short .8
        imul eax, dword [SeasonDefaultUser], byte 1Ch
        movsx edx, word [byte ebp-04h]
        mov dword [dword eax+SeasonUserReplay], edx
        jmp short .9
.8:
        movzx eax, byte [PlayoffUserIndex]
        imul eax, byte 1Ch
        movsx edx, word [byte ebp-04h]
        mov dword [dword eax+PlayoffUserReplay], edx
.9:
        movsx edx, word [byte ebp-04h]
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov ebx, dword [byte eax+020h]
        movsx edx, byte [edx+ebx]
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        lea edx, [dword ebp-0195Ch]
        call FindGameRecord
        lea eax, [dword ebp-0195Ch]
        call UpdateTeamLines
        lea eax, [dword ebp-0195Ch]
        call UpdateGameRecord
        movsx edx, word [byte ebp-04h]
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov ebx, dword [byte eax+020h]
        movsx edx, byte [byte edx+ebx+01h]
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        lea edx, [dword ebp-0195Ch]
        call FindGameRecord
        lea eax, [dword ebp-0195Ch]
        call UpdateTeamLines
        lea eax, [dword ebp-0195Ch]
        mov ebx, SeasonFileName
        call UpdateGameRecord
        movsx edx, word [byte ebp-04h]
        mov eax, dword [SeasonUserTeam]
        call StartSeasonGame
.10:
        mov eax, dword [byte ebp-04h]
.11:
        leave
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AnimateWaitIcon                                 39B20  97 PC, low confidence
; Draws the next frame of the waiting animation on the season screen every
; few ticks
;-----------------------------------------------------------------------------
AnimateWaitIcon:
        push ebx
        push ecx
        push edx
        push esi
        mov eax, dword [tickcount]
        mov ebx, eax
        mov esi, eax
        cmp eax, dword [WaitIconFrame]
        jbe short .1
        mov eax, dword [WaitIconShown]
        mov ecx, dword [WaitIconTime]
        push dword [ecx+eax*4]
        call BlitShape
        mov ecx, 0Ah
        add dword [WaitIconShown], byte 2
        xor edx, edx
        mov eax, dword [WaitIconShown]
        div ecx
        add ebx, byte 0Ch
        add esp, byte 4
        mov dword [WaitIconFrame], ebx
        mov dword [WaitIconShown], edx
.1:
        cmp esi, dword [WaitIconCount]
        jbe short .2
        mov ebx, dword [WaitIconOn]
        mov eax, dword [WaitIconTime]
        push dword [eax+ebx*4]
        call BlitShape
        mov ebx, 0Ah
        add dword [WaitIconOn], byte 2
        xor edx, edx
        mov eax, dword [WaitIconOn]
        div ebx
        add esi, byte 0Eh
        add esp, byte 4
        mov dword [WaitIconCount], esi
        mov dword [WaitIconOn], edx
.2:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AnimateSparkle                                  39BB6  97 PC, low confidence
; Draws a random sparkle shape on the screen every few ticks
;-----------------------------------------------------------------------------
AnimateSparkle:
        push ebx
        push ecx
        push edx
        mov eax, dword [tickcount]
        mov ebx, eax
        cmp eax, dword [SparkleFrame]
        jbe short .1
        push dword 198h
        push byte 0
        push dword 280h
        push byte 0
        call SetClipWindow
        add esp, byte 10h
        call Random32
        mov ecx, 6
        xor edx, edx
        div ecx
        mov eax, edx
        mov edx, dword [SeasonScreenState]
        push dword [edx+eax*4]
        call BlitShape
        add esp, byte 4
        call ResetClipWindow
        call Random32
        mov ecx, 12Ch
        xor edx, edx
        div ecx
        add edx, ebx
        add edx, byte 0Ah
        mov dword [SparkleFrame], edx
.1:
        pop edx
        pop ecx
        pop ebx
        ret
AnimateSparkle_6B:
        call AnimateWaitIcon
        call AnimateSparkle
        push ebx
        push ecx
        push edx
        push esi
        mov eax, dword [tickcount]
        mov esi, eax
        xor ebx, ebx
        cmp eax, dword [SparkleTime]
        jbe near .5
        mov eax, dword [SparkleY]
        cmp dword [dword eax+01F0h], byte 1
        jne short .3
        call Random32
        mov ecx, 3
        xor edx, edx
        div ecx
        mov ebx, 1
        cmp edx, dword [SparkleX]
        jl short .2
        inc edx
.2:
        mov eax, dword [SparkleY]
        mov dword [SparkleX], edx
        push dword [dword eax+0216h]
        push dword [dword eax+0212h]
        push dword [nosplit edx*4+SparkleTable]
        add esi, byte 4
        call BlitArt
        add esp, byte 0Ch
        mov dword [SparkleTime], esi
.3:
        test bx, bx
        jne short .4
        cmp word [SparkleTimer], byte 0
        je short .4
        call StopAllSfx
        mov word [SparkleTimer], bx
.4:
        test bx, bx
        je short .5
        cmp word [SparkleTimer], byte 0
        jne short .5
        mov eax, 309h
        call PlaySfx
        mov word [SparkleTimer], 1
.5:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
