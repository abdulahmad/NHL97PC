; Roster screens: lists, panels, player cards and injuries.
bits 32
%include "hockey.inc"
section s_C755B progbits alloc exec nowrite align=1
extern AllocMemBlock, BlankMenuItem, BlitArt, BlitShape, BuildRosterLines, CheckRosterLimits, ClearScreen, ConvertArtXY
extern CreateBitmap, DbKeyBuffer, DeletionCount, DrawArt, DrawFrameBox, DrawHighlightBar, DrawRatingBars_157, DrawRatingBars_158
extern DrawScreenBackground, DrawScrollBar, DrawShadedLogo, DrawShadowBox, DrawShapeBlended, DrawTextAligned, ExitScreen, FadeInScreen
extern FillRect, FindGameRecord, FindPlayerRecord, FindPlayerStat, FindShape, FindShapeList, FindTeamRecord, FreeBitmap
extern FreeExhibitionFile, FreeLogoArt, FreeMemBlock, FreeScrollList, FrontMusicOn, gameopts, GameSettings, GetLangText
extern InitMenuItems, InitScrollList, InitShapeListBox, KeysEqual, LoadDataFile, LoadFakeExhibition, LoadFileAllocQuiet, LoadFrontEndSfx
extern LoadTeamLogo, MakeColor, MeasureText, memset_, MusicEnabled, PlayerOverall, PlayerRatingsScreen, PlayMenuSfx
extern PlayoffStarted, PlayoffTeams, PlayoffUserActive, PlayoffUserHuman, PlayoffUserLocked, PlaySfx, PositionAbbrev, PresentScreen
extern Random32, RateTrade, ResetClipWindow, ResetExhibitionRosters, RosterBackFile, RosterChanged, RosterData, RosterEditOpen
extern RosterEditScreen, RosterFreeAgents, RosterInfoAnim, RosterInfoLoaded, RosterLastSpeech, RosterListArea, RosterListBox, RosterLogoBitmap
extern RosterMenuArea, RosterMenuItems, RosterMode, RosterOtherListBox, RosterOtherTeam, RosterPanelBitmap, RosterPanelLayers, RosterPanelShape
extern RosterPlayerInfo, RosterRow, RosterScreenJumpTable, RosterScreenOpen, RosterScreenReady, RosterScrollArea, RosterScrollList, RosterShapeFile
extern RosterSoundOn, RosterSpeechAway, RosterSpeechCount, RosterSpeechHome, RosterSpeechTrade, RosterTeam, RosterTeams, RosterTitleRight
extern RosterTitleShape, RosterTitleWidth, RosterTitleX, RosterTitleY, RosterTradeOn, RosterTradeScreen, RunMenu, RunScrollList
extern SaveDataFile, SaveTrades, ScreenFrameItem, ScreenTitleItem, ScrollDown, ScrollToMouse, ScrollUp, SeasonActive
extern SeasonCreated, SeasonDefaultUser, SeasonUserActive, SeasonUserHuman, SeasonUserLocked, SeasonUserTeam, SecondsToSamples, SetClipWindow
extern SetDrawTarget, SetHighlightText, SetListSelection, SetNormalText, SetScreenTarget, SetScrollBarPos, SetTextColor, ShadowShape
extern ShowMessageBox, ShowPopupScreen, ShowScreen, ShowTradeRejected, ShowTradeRejected_100, ShowTradeRejected_102, sprintf_, str_2d2
extern str_2dSS, str_7_SetupRosterLists, str_ATL0, str_ATL1, str_ATL2, str_ATL3, str_ATL4, str_ATL5
extern str_ATR0, str_ATR1, str_ATR2, str_ATR3, str_ATR4, str_ATR5, str_BACK11, str_CDCS2
extern str_CM002, str_CM00CM01CM02CM03, str_CM012, str_DeletionIndices, str_DF002, str_DF00DF01DF02DF03, str_GB00, str_GB01
extern str_GB02, str_GB03, str_GB04, str_I_SetupRosterLists, str_LB004, str_LB01, str_LB02, str_LB02d5
extern str_LB03, str_LB04, str_LD002, str_LD01, str_LD02, str_LD03, str_LD04, str_MTR2
extern str_Punct_DrawRosterList, str_Punct_InitRosterScreen, str_RosinfoAna, str_RosPlrInfo, str_RosterMenu, str_RosterPlayerInfo, str_RosterRegions, str_SeasRosArray
extern str_TITL11, str_TR00, str_TR00TR01TR02TR03, str_TR01, str_TR04, str_X_DrawRosterList, str_X_InitRosterScreen, str_X_SetupRosterLists
extern str_X_ShowRosterLogo, strcat_, strlen_, tickcount, UnlinkJump, WaitSoundTime, WipeScreen
global RosterScreen, RosterScreen_11C, RosterScreen_157, RosterScreen_172, RosterScreen_246, RosterScreen_2EC, RosterScreen_3B9, RosterScreen_42C
global RosterScreen_49B, RosterScreen_4ED, RosterScreen_53E, RosterScreen_596, RosterScreen_5AB, RosterScreen_5AF, RosterScreen_5CF, RosterScreen_5D3
global RosterScreen_604, RosterScreen_615, RosterScreen_624, RosterScreen_65B, RosterScreen_66C, GetRosterPlayerNumber, PlayRosterSound, SetRosterMode
global LoadRosterInfoAnim, FreeRosterInfoAnim, FreeRosterInfoAnim_4A, AllocRosterInfo, SkaterOverall, GoalieOverall, LoadRosterData, InitRosterData
global FreeRosterData, DrawRosterRow, DrawRosterList, DrawRosterList_86F, DrawRosterLogo, ShowRosterLogo, DrawRosterTitle, CreateRosterPanel
global FreeRosterPanel, InitRosterScreen, FreeRosterScreen, DrawRosterPanel, SetupRosterLists, LoadRosterArt, SetRosterButtons, InitListBox
global DrawPlayerCard, DrawPlayerCard_2B8, DrawPlayerCardText, DrawRosterDetails, SetRosterArrows, RedrawRosterScreen, CheckRosterInjuries, GetPlayerStatLine
;-----------------------------------------------------------------------------
; RosterScreen                                    C755B  96 PC, low confidence
; The roster screen: trades between teams, signing free agents (FREEAGNT.DB),
; creating players, by team lists (s1__-s4__)
;-----------------------------------------------------------------------------
RosterScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 310h, 0
        push eax
        sub ebp, 82h
        lea edi, [byte ebp+062h]
        mov esi, DbKeyBuffer
        movsd
        movsd
        lea edi, [byte ebp+06Ah]
        lea esi, [byte ebp+062h]
        movsd
        movsd
        mov dword [byte ebp+07Eh], 0
        cmp byte [FrontMusicOn], 0
        je short .1
        call MusicEnabled
.1:
        lea eax, [byte ebp-026h]
        mov dword [RosterScrollArea], eax
        lea eax, [dword ebp-08Eh]
        push byte 0
        mov dword [RosterListArea], eax
        lea eax, [byte ebp+052h]
        push dword 0CD0h
        mov dword [RosterMenuArea], eax
        lea eax, [byte ebp+042h]
        push str_RosterMenu
        mov dword [RosterMenuItems], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 0A00h
        push str_RosterRegions
        mov ebx, eax
        mov edi, eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp+076h], eax
        lea eax, [dword ebp-028Eh]
        push byte 0FFFFFFFFh
        mov dword [RosterListBox], eax
        lea eax, [dword ebp-018Eh]
        mov dword [RosterRow], ebx
        mov dword [RosterOtherListBox], eax
        call MakeColor
        add esp, byte 4
        call SetTextColor
        call SetRosterMode
        mov edx, ebx
        mov dword [RosterMode], eax
        mov esi, eax
        call InitRosterData
        mov eax, 28h
        xor ebx, ebx
        call InitMenuItems
.2:
        mov eax, ebx
        mov edx, dword [byte ebp+076h]
        shl eax, 6
        add edx, eax
        imul eax, ebx, byte 52h
        inc ebx
        mov dword [byte edi+eax+014h], edx
        cmp ebx, byte 28h
        jl short .2
        call InitRosterScreen
        push str_BACK11
        push dword [RosterBackFile]
        call FindShape
        mov dword [byte ebp+07Ah], eax
        mov eax, dword [RosterPanelBitmap]
        add esp, byte 8
.3:
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte eax+02Ch]
        call WipeScreen
        jmp near RosterScreen_66C.29
RosterScreen_11C:
        call ShowScreen
        cmp dword [RosterEditOpen], byte 0
        je short .4
        push byte 1
        mov ecx, 1
        mov edx, 2
        mov eax, 0D4h
        xor ebx, ebx
        call GetLangText
        call ShowMessageBox
        mov dword [byte ebp+07Eh], eax
        jmp near RosterScreen_66C.29
.4:
        inc dword [byte ebp+07Eh]
        jmp near RosterScreen_66C.29
RosterScreen_157:
        call FadeInScreen
        call FreeRosterScreen
        call SaveTrades
        mov dword [byte ebp+07Eh], 1
        jmp near RosterScreen_66C.29
RosterScreen_172:
        call FreeRosterPanel
        push dword [RosterBackFile]
        call FreeMemBlock
        add esp, byte 4
        call ExitScreen
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 1Ch
        call LoadDataFile
        mov dword [RosterBackFile], eax
        mov eax, str_BACK11
        push eax
        push dword [RosterBackFile]
        call FindShape
        add esp, byte 8
        mov dword [RosterPanelShape], eax
        call LoadRosterArt
        push dword [RosterPanelBitmap]
        call SetDrawTarget
        add esp, byte 4
        push dword [RosterPanelShape]
        call BlitShape
        add esp, byte 4
        call DrawRosterTitle
        call ShowRosterLogo
        call CreateRosterPanel
        push dword [RosterPanelBitmap]
        call SetDrawTarget
        add esp, byte 4
        xor edx, edx
        xor eax, eax
        call DrawRosterList
        mov eax, 1
        xor edx, edx
        call DrawRosterList
        xor eax, eax
        xor ebx, ebx
        call DrawRosterDetails
.5:
        imul eax, ebx, byte 52h
        add eax, edi
        cmp dword [byte eax+01Ah], byte 0
        je short .6
        push dword [byte eax+02Ah]
        push dword [byte eax+026h]
        push dword [byte eax+01Ah]
        call DrawArt
        add esp, byte 0Ch
.6:
        inc ebx
        cmp ebx, byte 14h
        jl short .5
        jmp near RosterScreen_66C.29
RosterScreen_246:
        cmp dword [RosterChanged], byte 0
        je near RosterScreen_66C.29
        cmp dword [RosterTradeOn], byte 0
        je near RosterScreen_66C.29
        call CheckRosterInjuries
        test eax, eax
        jne near RosterScreen_66C.29
        call ShowTradeRejected
        test eax, eax
        jne near RosterScreen_66C.29
        call CheckRosterLimits
        test eax, eax
        jne near RosterScreen_66C.29
        call RosterTradeScreen
        mov edx, 1
        xor eax, eax
        call DrawRosterList
        mov edx, 1
        mov eax, edx
        call DrawRosterList
        imul eax, dword [RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        xor ebx, ebx
        movsx edx, word [byte edx+eax+072h]
        lea eax, [dword ebp-028Eh]
        call SetScrollBarPos
        imul edx, dword [RosterOtherTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        xor ebx, ebx
        movsx edx, word [byte edx+eax+072h]
        lea eax, [dword ebp-018Eh]
        call SetScrollBarPos
        jmp near RosterScreen_66C.28
RosterScreen_2EC:
        cmp dword [RosterMode], byte 0
        jne near RosterScreen_66C.29
        push byte 1
        mov eax, 0D5h
        mov ecx, 1
        mov edx, 2
        xor ebx, ebx
        call GetLangText
        call ShowMessageBox
        cmp eax, byte 1
        jne near RosterScreen_66C.29
        call ResetExhibitionRosters
        mov ebx, 1
        mov edx, esi
        xor eax, eax
        call LoadRosterData
        mov ebx, 1
        mov edx, esi
        mov eax, ebx
        call LoadRosterData
        imul eax, dword [RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        xor ebx, ebx
        movsx edx, word [byte edx+eax+072h]
        lea eax, [dword ebp-028Eh]
        call SetScrollBarPos
        imul edx, dword [RosterOtherTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        xor ebx, ebx
        movsx edx, word [byte edx+eax+072h]
        lea eax, [dword ebp-018Eh]
        call SetScrollBarPos
        mov edx, 1
        xor eax, eax
        call DrawRosterList
        mov edx, 1
        mov eax, edx
        call DrawRosterList
        call SetRosterArrows
        mov eax, 1
        call DrawRosterDetails
        mov dword [RosterEditOpen], 1
        jmp near RosterScreen_66C.29
RosterScreen_3B9:
        call ShowPopupScreen
        lea edx, [byte ebp+062h]
        xor eax, eax
        call GetRosterPlayerNumber
        lea edx, [byte ebp+06Ah]
        mov eax, 1
        call GetRosterPlayerNumber
        cmp byte [FrontMusicOn], 0
        je short .7
        call FreeRosterInfoAnim
        test eax, eax
        je near RosterScreen_66C.29
.7:
        cmp dword [RosterScreenOpen], byte 0
        je short .8
        call FreeRosterScreen
.8:
        lea edx, [byte ebp+06Ah]
        lea eax, [byte ebp+062h]
        xor ebx, ebx
        call PlayerRatingsScreen
        cmp byte [FrontMusicOn], 0
        je short .9
        call LoadRosterInfoAnim
.9:
        cmp dword [RosterScreenOpen], byte 0
        je short .10
        call InitRosterScreen
.10:
        mov eax, dword [RosterPanelBitmap]
        jmp near RosterScreen.3
RosterScreen_42C:
        xor eax, eax
        call SetRosterButtons
        test eax, eax
        je near RosterScreen_66C.29
        imul eax, dword [byte ebp+072h], byte 52h
        mov edx, dword [byte edi+eax+01Ah]
        movsx edx, word [byte edx+04h]
        add edx, dword [byte edi+eax+026h]
        push dword [byte edi+eax+02Ah]
        add edx, byte 0Ah
        push edx
        mov edx, dword [RosterPanelBitmap]
        mov ecx, dword [byte edi+eax+02Ah]
        push dword [byte edx+02Ch]
        mov ebx, dword [byte edi+eax+026h]
        push dword [RosterMenuItems]
        mov edx, 4
        push dword [RosterMenuArea]
        mov eax, edx
        call RunScrollList
        xor edx, edx
.11:
        mov ebx, eax
        call RosterEditScreen
        test ebx, ebx
        jne short .12
        mov eax, dword [RosterPanelShape]
        mov dword [byte ebp+07Ah], eax
.12:
        call SetRosterArrows
        jmp near RosterScreen_66C.29
RosterScreen_49B:
        mov eax, 1
        call SetRosterButtons
        test eax, eax
        je near RosterScreen_66C.29
        imul eax, dword [byte ebp+072h], byte 52h
        mov edx, dword [byte edi+eax+026h]
        push dword [byte edi+eax+02Ah]
        sub edx, byte 1Eh
        push edx
        mov edx, dword [RosterPanelBitmap]
        mov ecx, dword [byte edi+eax+02Ah]
        push dword [byte edx+02Ch]
        mov ebx, dword [byte edi+eax+026h]
        push dword [RosterMenuItems]
        mov edx, 4
        push dword [RosterMenuArea]
        mov eax, edx
        call RunScrollList
        mov edx, 1
        jmp short RosterScreen_42C.11
RosterScreen_4ED:
        mov ebx, dword [byte eax+01Ah]
        movsx ecx, word [byte ebx+06h]
        movsx ebx, word [byte ebx+04h]
        add ecx, dword [byte eax+02Ah]
        add ebx, dword [byte eax+026h]
        push ecx
        add ebx, byte 0Ah
        mov edx, dword [RosterPanelBitmap]
        push ebx
        push dword [byte edx+02Ch]
        mov ebx, dword [byte eax+026h]
        push dword [RosterListArea]
        mov edx, 0Ah
        push dword [RosterScrollArea]
        mov eax, dword [RosterScrollList]
        call RunScrollList
        xor ebx, ebx
        jmp short .14
.13:
        inc ebx
.14:
        cmp ebx, dword [RosterScrollList]
        jl short .13
        push byte 0
        mov ebx, dword [byte ebp+072h]
        jmp short RosterScreen_596.18
RosterScreen_53E:
        mov ebx, dword [byte eax+01Ah]
        mov edx, dword [byte eax+026h]
        movsx ecx, word [byte ebx+06h]
        movsx ebx, word [byte ebx+04h]
        add ecx, dword [byte eax+02Ah]
        add edx, ebx
        push ecx
        add edx, byte 0Ah
        push edx
        mov edx, dword [RosterPanelBitmap]
        push dword [byte edx+02Ch]
        mov ebx, dword [byte eax+026h]
        push dword [RosterListArea]
        mov eax, dword [RosterScrollList]
        push dword [RosterScrollArea]
        mov edx, 0Ah
        call RunScrollList
        xor ebx, ebx
        jmp short .16
.15:
        inc ebx
.16:
        cmp ebx, dword [RosterScrollList]
        jl short .15
        push byte 0
        mov ebx, dword [byte ebp+072h]
        mov edx, 1
        jmp short RosterScreen_5AF.20
RosterScreen_596:
        push byte 0FFFFFFFFh
.17:
        mov ebx, 8
        mov eax, dword [RosterTeam]
.18:
        mov ecx, esi
        push dword [byte ebp+07Ah]
        xor edx, edx
        jmp short RosterScreen_5AF.21
RosterScreen_5AB:
        push byte 1
        jmp short RosterScreen_596.17
RosterScreen_5AF:
        push byte 0FFFFFFFFh
.19:
        mov ebx, 9
        mov edx, 1
        mov eax, dword [RosterOtherTeam]
.20:
        push dword [byte ebp+07Ah]
        mov ecx, esi
.21:
        call RedrawRosterScreen
        jmp near RosterScreen_66C.29
RosterScreen_5CF:
        push byte 1
        jmp short RosterScreen_5AF.19
RosterScreen_5D3:
        lea eax, [dword ebp-028Eh]
        xor edx, edx
        call ScrollUp
.22:
        imul edx, dword [RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        add edx, eax
        mov eax, dword [dword ebp-026Ah]
        mov word [byte edx+072h], ax
        mov edx, 1
        xor eax, eax
        jmp short RosterScreen_624.25
RosterScreen_604:
        lea eax, [dword ebp-028Eh]
        mov ebx, edx
        xor edx, edx
        call ScrollToMouse
        jmp short RosterScreen_5D3.22
RosterScreen_615:
        lea eax, [dword ebp-028Eh]
        xor edx, edx
        call ScrollDown
        jmp short RosterScreen_5D3.22
RosterScreen_624:
        lea eax, [dword ebp-018Eh]
        xor edx, edx
        call ScrollUp
.23:
        imul eax, dword [RosterOtherTeam], dword 32C6h
        mov edx, dword [RosterTeams]
.24:
        add edx, eax
        mov eax, dword [dword ebp-016Ah]
        mov word [byte edx+072h], ax
        mov edx, 1
        mov eax, edx
.25:
        call DrawRosterList
        jmp short RosterScreen_66C.29
RosterScreen_65B:
        lea eax, [dword ebp-018Eh]
        mov ebx, edx
        xor edx, edx
        call ScrollToMouse
        jmp short RosterScreen_624.23
RosterScreen_66C:
        lea eax, [dword ebp-018Eh]
        xor edx, edx
        call ScrollDown
        imul edx, dword [RosterOtherTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        jmp short RosterScreen_624.24
.26:
        cmp dword [byte ebp+072h], byte 14h
        jl short .30
        cmp dword [byte ebp+072h], byte 1Eh
        jge short .30
        mov eax, dword [byte ebp+072h]
        xor edx, edx
        sub eax, byte 14h
.27:
        call DrawPlayerCard
        call SetRosterArrows
.28:
        mov eax, 1
        call DrawRosterDetails
.29:
        cmp dword [byte ebp+07Eh], byte 0
        jne short .31
        push byte 3
        lea eax, [byte ebp+072h]
        mov ecx, PlayRosterSound
        mov ebx, 0FFFFFFFFh
        push eax
        mov edx, edi
        mov eax, 28h
        call RunMenu
        mov edx, eax
        cmp dword [byte ebp+072h], byte 13h
        ja short .26
        mov ebx, dword [byte ebp+072h]
        imul eax, ebx, byte 52h
        add eax, edi
        jmp dword [nosplit cs:ebx*4+RosterScreenJumpTable]
.30:
        cmp dword [byte ebp+072h], byte 1Eh
        jl short .29
        cmp dword [byte ebp+072h], byte 28h
        jge short .29
        mov eax, dword [byte ebp+072h]
        mov edx, 1
        sub eax, byte 1Eh
        jmp short .27
.31:
        call FreeRosterScreen
        mov eax, esi
        call FreeRosterData
        push dword [byte ebp+076h]
        call FreeMemBlock
        add esp, byte 4
        push edi
        call FreeMemBlock
        add esp, byte 4
        cmp byte [FrontMusicOn], 0
        je near ShowTradeRejected_102
        cmp dword [dword ebp-0292h], byte 0
        je near ShowTradeRejected_102
        call LoadFrontEndSfx
        jmp near ShowTradeRejected_102
;-----------------------------------------------------------------------------
; GetRosterPlayerNumber                           C7CA4  97 PC, low confidence
; Returns the jersey number of a roster slot
;-----------------------------------------------------------------------------
GetRosterPlayerNumber:
        push ebx
        imul edx, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        add eax, edx
        cmp byte [byte eax+071h], 0
        jbe short .1
        movzx edx, byte [byte eax+06Eh]
        mov eax, dword [eax]
        movsx ebx, word [dword eax+0D05h]
        cmp edx, ebx
        jl short .1
        sub edx, ebx
        movsx ebx, word [dword eax+01281h]
        cmp edx, ebx
        jl short .1
        movsx eax, word [dword eax+0132Bh]
        sub edx, ebx
        cmp edx, eax
.1:
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PlayRosterSound                                 C7CE8  97 PC, low confidence
; Plays a roster screen sound and builds its message
;-----------------------------------------------------------------------------
PlayRosterSound:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov eax, dword [tickcount]
        mov edi, eax
        xor esi, esi
        cmp eax, dword [RosterSpeechCount]
        jle near DrawRatingBars_158
        call Random32
        mov ebx, 3
        xor edx, edx
        div ebx
        mov ebx, edx
        cmp edx, dword [RosterLastSpeech]
        jl short .1
        lea ebx, [byte edx+01h]
.1:
        mov eax, dword [RosterRow]
        mov dword [RosterLastSpeech], ebx
        cmp dword [dword eax+0FAh], byte 1
        jne short .2
        cmp dword [RosterChanged], byte 0
        je short .2
        cmp dword [RosterTradeOn], byte 0
        je short .2
        mov edx, dword [nosplit ebx*4+RosterSpeechHome]
        mov dword [dword eax+0114h], edx
        mov eax, dword [RosterRow]
        push dword [dword eax+0120h]
        push dword [dword eax+011Ch]
        push dword [dword eax+0114h]
        mov esi, 1
        call BlitArt
        add esp, byte 0Ch
.2:
        mov eax, dword [RosterRow]
        cmp dword [dword eax+014Ch], byte 1
        jne short .3
        cmp dword [RosterMode], byte 0
        jne short .3
        mov edx, dword [nosplit ebx*4+RosterSpeechAway]
        mov dword [dword eax+0166h], edx
        mov eax, dword [RosterRow]
        push dword [dword eax+0172h]
        push dword [dword eax+016Eh]
        push dword [dword eax+0166h]
        mov esi, 1
        call BlitArt
        add esp, byte 0Ch
.3:
        mov eax, dword [RosterRow]
        cmp dword [dword eax+019Eh], byte 1
        jne short .4
        mov edx, dword [nosplit ebx*4+RosterSpeechTrade]
        mov dword [dword eax+01B8h], edx
        mov eax, dword [RosterRow]
        push dword [dword eax+01C4h]
        push dword [dword eax+01C0h]
        push dword [dword eax+01B8h]
        mov esi, 1
        call BlitArt
        add esp, byte 0Ch
.4:
        add edi, byte 4
        mov dword [RosterSpeechCount], edi
        test si, si
        jne short .5
        cmp word [RosterSoundOn], byte 0
        je short .5
        mov eax, 309h
        call PlayMenuSfx
        mov word [RosterSoundOn], si
.5:
        test si, si
        je near DrawRatingBars_158
        cmp word [RosterSoundOn], byte 0
        jne near DrawRatingBars_158
        mov eax, 309h
        call PlaySfx
        mov word [RosterSoundOn], 1
        jmp near DrawRatingBars_158
        push esi
        enter 14h, 0
        mov esi, eax
        push ecx
        push ebx
        push edx
        push str_2dSS
        push eax
        call sprintf_
        add esp, byte 14h
        mov eax, esi
        call strlen_
        mov edx, eax
        inc eax
        mov byte [edx+esi], 20h
.6:
        cmp eax, byte 19h
        jge short .7
        mov edx, eax
        inc eax
        mov byte [edx+esi], 2Eh
        jmp short .6
.7:
        push dword [byte ebp+0Ch]
        push str_2d2
        mov byte [esi+eax], 0
        lea eax, [byte ebp-014h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea edx, [byte ebp-014h]
        mov eax, esi
        call strcat_
        leave
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; SetRosterMode                                   C7EAE  97 PC, low confidence
; Sets the roster screen mode from the game mode flags
;-----------------------------------------------------------------------------
SetRosterMode:
        push edx
        test byte [GameSettings], 70h
        jne short .1
        mov dword [RosterScrollList], 1Ah
        xor eax, eax
        pop edx
        ret
.1:
        mov edx, dword [GameSettings]
        and edx, byte 70h
        cmp edx, byte 10h
        jne short .3
        mov dword [RosterScrollList], 1Ah
        cmp dword [SeasonActive], byte 0
        je short .2
        mov eax, 2
        mov dword [RosterScrollList], edx
        pop edx
        ret
.2:
        cmp byte [SeasonCreated], 0
        je short .5
        mov eax, 1
        pop edx
        ret
.3:
        cmp edx, byte 20h
        jne short .6
        cmp byte [PlayoffStarted], 0
        je short .4
        mov dword [RosterScrollList], 10h
        mov eax, 2
        pop edx
        ret
.4:
        mov dword [RosterScrollList], 1Ah
.5:
        xor eax, eax
.6:
        pop edx
        ret
;-----------------------------------------------------------------------------
; LoadRosterInfoAnim                              C7F31  97 PC, low confidence
; Roster screen: loads "rosinfo!.ana"
;-----------------------------------------------------------------------------
LoadRosterInfoAnim:
        push ebx
        push ecx
        push edx
        push esi
        xor ebx, ebx
        cmp dword [RosterInfoLoaded], byte 0
        jne near .5
        push ebx
        push str_RosinfoAna
        call LoadFileAllocQuiet
        add esp, byte 8
        mov dword [RosterTeams], eax
        test eax, eax
        je short .5
        mov ebx, 1
        mov dword [RosterInfoLoaded], 1
        xor eax, eax
        jmp short .4
.1:
        imul ecx, eax, dword 32C6h
        imul edx, eax, dword 194Fh
        cmp dword [RosterMode], byte 0
        jne short .2
        mov esi, dword [RosterData]
        add esi, 0DF4h
        jmp short .3
.2:
        mov esi, dword [RosterFreeAgents]
.3:
        add esi, edx
        mov edx, dword [RosterTeams]
        mov dword [ecx+edx], esi
        inc eax
.4:
        cmp eax, dword [RosterScrollList]
        jl short .1
        mov eax, str_RosinfoAna
        call UnlinkJump
.5:
        mov eax, ebx
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FreeRosterInfoAnim                              C7FBC  97 PC, low confidence
; Roster screen: frees the "rosinfo!.ana" animation
;-----------------------------------------------------------------------------
FreeRosterInfoAnim:
        push ebx
        push ecx
        push edx
        xor ebx, ebx
        cmp dword [RosterInfoLoaded], byte 0
        je short FreeRosterInfoAnim_4A
        push dword [RosterInfoAnim]
        push dword [RosterTeams]
        push str_RosinfoAna
        call SaveDataFile
        add esp, byte 0Ch
        test eax, eax
        je short FreeRosterInfoAnim_4A
        push dword [RosterTeams]
        call FreeMemBlock
        add esp, byte 4
        mov dword [RosterInfoLoaded], ebx
        mov dword [RosterTeams], ebx
        mov ebx, 1
FreeRosterInfoAnim_4A:
        mov eax, ebx
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AllocRosterInfo                                 C800C  97 PC, low confidence
; Allocates the "rosPlrInfo" and "seasRosArray" tables of the roster screen
;-----------------------------------------------------------------------------
AllocRosterInfo:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 4, 0
        mov eax, dword [SeasonUserTeam]
        movsx ebx, word [eax]
        imul ebx, dword 32C6h
        push byte 0
        push ebx
        mov esi, 1
        push str_RosPlrInfo
        mov dword [RosterInfoLoaded], esi
        mov dword [RosterInfoAnim], ebx
        call AllocMemBlock
        add esp, byte 0Ch
        xor edx, edx
        mov dword [RosterTeams], eax
        call memset_
        mov eax, dword [SeasonUserTeam]
        movsx ebx, word [eax]
        imul ebx, dword 194Fh
        push byte 20h
        push ebx
        push str_SeasRosArray
        call AllocMemBlock
        add esp, byte 0Ch
        xor edx, edx
        mov dword [RosterFreeAgents], eax
        call memset_
        xor ecx, ecx
        jmp short .4
.1:
        imul edi, ecx, dword 194Fh
        mov eax, ecx
        shl eax, 3
        mov edx, dword [RosterFreeAgents]
        mov dword [byte ebp-04h], eax
        mov eax, dword [byte ebx+01Ch]
        add edx, edi
        add eax, dword [byte ebp-04h]
        call FindGameRecord
        test eax, eax
        jne short .2
        xor esi, esi
        jmp short .3
.2:
        mov eax, dword [RosterFreeAgents]
        add eax, edi
        call BuildRosterLines
.3:
        inc ecx
.4:
        mov ebx, dword [SeasonUserTeam]
        movsx eax, word [ebx]
        cmp ecx, eax
        jl short .1
        mov eax, esi
        jmp near DrawRatingBars_157
;-----------------------------------------------------------------------------
; SkaterOverall                                   C80C8  97 PC, low confidence
; Works out a skater's overall rating from the rating bytes
;-----------------------------------------------------------------------------
SkaterOverall:
        push ebx
        push edx
        xor edx, edx
        test eax, eax
        je short .1
        movzx dx, byte [byte eax+02h]
        movzx bx, byte [byte eax+01h]
        add ebx, edx
        movzx dx, byte [byte eax+03h]
        add edx, ebx
        movzx bx, byte [byte eax+04h]
        add ebx, edx
        movzx dx, byte [byte eax+05h]
        add ebx, edx
        movzx dx, byte [byte eax+06h]
        add edx, ebx
        movzx bx, byte [byte eax+07h]
        add ebx, edx
        movzx dx, byte [byte eax+08h]
        add ebx, edx
        movzx dx, byte [byte eax+09h]
        add ebx, edx
        movzx dx, byte [byte eax+0Ah]
        add ebx, edx
        movzx dx, byte [byte eax+0Bh]
        add ebx, edx
        movzx dx, byte [byte eax+0Ch]
        add edx, ebx
.1:
        mov eax, edx
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; GoalieOverall                                   C8127  97 PC, low confidence
; Works out a goalie's overall rating from the rating bytes
;-----------------------------------------------------------------------------
GoalieOverall:
        push ebx
        push edx
        xor edx, edx
        test eax, eax
        je short .1
        movzx dx, byte [byte eax+02h]
        movzx bx, byte [byte eax+01h]
        add ebx, edx
        movzx dx, byte [byte eax+03h]
        add edx, ebx
        movzx bx, byte [byte eax+04h]
        add ebx, edx
        movzx dx, byte [byte eax+05h]
        add ebx, edx
        movzx dx, byte [byte eax+06h]
        add edx, ebx
        movzx bx, byte [byte eax+07h]
        add ebx, edx
        movzx dx, byte [byte eax+08h]
        add ebx, edx
        movzx dx, byte [byte eax+09h]
        add ebx, edx
        movzx dx, byte [byte eax+0Ah]
        add ebx, edx
        movzx dx, byte [byte eax+0Ch]
        add edx, ebx
.1:
        mov eax, edx
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadRosterData                                  C817F  97 PC, low confidence
; Loads a team's roster, players and stats
;-----------------------------------------------------------------------------
LoadRosterData:
        push ecx
        push esi
        push edi
        enter 10h, 0
        push eax
        push edx
        mov esi, dword [nosplit eax*4+RosterTeam]
        imul edx, esi, dword 32C6h
        mov eax, dword [RosterTeams]
        mov dword [byte ebp-04h], 1
        test byte [byte edx+eax+06Ah], 1
        je short .1
        test ebx, ebx
        je near .35
.1:
        imul edi, esi, dword 32C6h
        mov eax, dword [RosterTeams]
        mov byte [byte edi+eax+071h], 0
        imul eax, esi, dword 194Fh
        cmp dword [byte ebp-018h], byte 0
        jne short .3
        cmp dword [RosterData], byte 0
        je near .9
        mov edx, dword [RosterData]
        add edx, 0DF4h
        lea ecx, [edx+eax]
        mov eax, dword [RosterTeams]
        or byte [byte edi+eax+06Ah], 4
.2:
        mov eax, dword [RosterTeams]
        or byte [byte edi+eax+06Ah], 8
        jmp near .10
.3:
        cmp dword [RosterFreeAgents], byte 0
        je near .9
        imul ebx, esi, byte 1Ch
        mov ecx, dword [RosterFreeAgents]
        add ecx, eax
        cmp dword [byte ebp-018h], byte 1
        jne short .7
        cmp byte [dword ebx+SeasonUserLocked], 0
        je short .4
        mov eax, dword [RosterTeams]
        or byte [byte edi+eax+06Ah], 4
        jmp short .5
.4:
        mov eax, dword [RosterTeams]
        and byte [byte edi+eax+06Ah], 0FBh
.5:
        imul ebx, esi, byte 1Ch
        cmp byte [dword ebx+SeasonUserActive], 1
        jne short .6
        cmp byte [dword ebx+SeasonUserHuman], 1
        je short .6
        imul eax, esi, dword 32C6h
        mov edx, dword [RosterTeams]
        or byte [byte edx+eax+06Ah], 8
        jmp short .10
.6:
        imul ebx, esi, dword 32C6h
        mov eax, dword [RosterTeams]
        and byte [byte ebx+eax+06Ah], 0F7h
        jmp short .10
.7:
        mov eax, dword [RosterTeams]
        and byte [byte edi+eax+06Ah], 0FBh
        cmp byte [dword ebx+PlayoffUserActive], 1
        jne short .8
        cmp byte [dword ebx+PlayoffUserHuman], 1
        jne near .2
.8:
        imul edx, esi, dword 32C6h
        mov eax, dword [RosterTeams]
        and byte [byte edx+eax+06Ah], 0F7h
        jmp short .10
.9:
        mov dword [byte ebp-04h], 0
.10:
        cmp dword [byte ebp-04h], byte 0
        je near .35
        imul ebx, esi, dword 32C6h
        mov eax, dword [RosterTeams]
        mov dword [ebx+eax], ecx
        mov eax, dword [RosterTeams]
        add eax, ebx
        lea edx, [byte eax+04h]
        lea eax, [byte ecx+010h]
        call FindTeamRecord
        imul edx, esi, dword 32C6h
        mov eax, dword [RosterTeams]
        or byte [byte ebx+eax+06Ah], 1
        mov eax, dword [RosterTeams]
        and byte [byte ebx+eax+06Ah], 0FDh
        mov eax, dword [RosterTeams]
        mov word [byte ebx+eax+072h], 0
        xor ebx, ebx
.11:
        mov eax, dword [RosterTeams]
        inc ebx
        add eax, edx
        mov byte [byte ebx+eax+06Dh], 0
        cmp ebx, byte 3
        jl short .11
        imul edi, esi, dword 32C6h
        mov ax, word [dword ecx+0D05h]
        add ax, word [dword ecx+0132Bh]
        mov bx, word [dword ecx+01281h]
        add ax, word [dword ecx+018A5h]
        add ebx, eax
        mov eax, dword [RosterTeams]
        mov word [byte edx+eax+074h], bx
        xor ebx, ebx
        jmp near .13
.12:
        imul eax, ebx, byte 27h
        mov edx, dword [RosterTeams]
        add edx, edi
        add edx, byte 76h
        mov dword [byte ebp-0Ch], eax
        add edx, eax
        imul eax, ebx, byte 38h
        mov dword [byte ebp-010h], eax
        lea eax, [dword ecx+0D09h]
        add eax, dword [byte ebp-010h]
        mov dword [byte ebp-010h], eax
        add eax, byte 28h
        call FindPlayerStat
        imul edx, ebx, dword 0BCh
        mov eax, dword [RosterTeams]
        add eax, edi
        add eax, 8FEh
        add edx, eax
        mov eax, dword [byte ebp-010h]
        add eax, byte 18h
        call FindPlayerRecord
        mov eax, dword [RosterTeams]
        add eax, edi
        add eax, byte 76h
        mov edx, 1
        add eax, dword [byte ebp-0Ch]
        call PlayerOverall
        mov dword [byte ebp-010h], eax
        mov eax, dword [RosterTeams]
        add eax, edi
        add eax, dword [byte ebp-0Ch]
        mov dl, byte [byte ebp-010h]
        mov byte [dword eax+09Bh], dl
        mov eax, dword [RosterTeams]
        add eax, edi
        add eax, byte 76h
        add eax, dword [byte ebp-0Ch]
        add eax, byte 10h
        call SkaterOverall
        mov edx, eax
        mov eax, dword [RosterTeams]
        add eax, edi
        mov dword [byte ebp-0Ch], eax
        lea eax, [ebx+ebx]
        mov dword [byte ebp-010h], eax
        mov eax, dword [byte ebp-0Ch]
        add eax, dword [byte ebp-010h]
        mov word [dword eax+03256h], dx
        mov eax, dword [RosterTeams]
        inc ebx
        add eax, edi
        mov byte [dword ebx+eax+0321Dh], 0
.13:
        movsx eax, word [dword ecx+0D05h]
        cmp ebx, eax
        jl near .12
        xor ebx, ebx
        imul edi, esi, dword 32C6h
        jmp near .15
.14:
        mov eax, dword [RosterTeams]
        add eax, edi
        mov dword [byte ebp-010h], eax
        imul eax, ebx, byte 27h
        mov edx, dword [byte ebp-010h]
        add edx, 445h
        mov dword [byte ebp-010h], eax
        add edx, eax
        imul eax, ebx, byte 38h
        mov dword [byte ebp-0Ch], eax
        lea eax, [dword ecx+01283h]
        add eax, dword [byte ebp-0Ch]
        mov dword [byte ebp-08h], eax
        add eax, byte 28h
        call FindPlayerStat
        imul edx, ebx, dword 0BCh
        mov eax, dword [RosterTeams]
        add eax, edi
        mov dword [byte ebp-0Ch], edx
        lea edx, [dword eax+01B5Ah]
        mov eax, dword [byte ebp-08h]
        add eax, byte 18h
        add edx, dword [byte ebp-0Ch]
        call FindPlayerRecord
        mov eax, dword [RosterTeams]
        add eax, edi
        add eax, 445h
        xor edx, edx
        add eax, dword [byte ebp-010h]
        call PlayerOverall
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [RosterTeams]
        add eax, edi
        add eax, dword [byte ebp-010h]
        mov dl, byte [byte ebp-0Ch]
        mov byte [dword eax+0466h], dl
        mov eax, dword [RosterTeams]
        add eax, edi
        add eax, 445h
        add eax, dword [byte ebp-010h]
        add eax, byte 10h
        call GoalieOverall
        mov edx, eax
        mov eax, dword [RosterTeams]
        add eax, edi
        mov dword [byte ebp-08h], eax
        lea eax, [ebx+ebx]
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [byte ebp-08h]
        add eax, dword [byte ebp-0Ch]
        mov word [dword eax+03288h], dx
        mov eax, dword [RosterTeams]
        inc ebx
        add eax, edi
        mov byte [dword ebx+eax+03236h], 0
.15:
        movsx eax, word [dword ecx+01281h]
        cmp ebx, eax
        jl near .14
        xor ebx, ebx
        imul edi, esi, dword 32C6h
        jmp near .17
.16:
        imul eax, ebx, byte 27h
        mov edx, dword [RosterTeams]
        add edx, edi
        add edx, 4BAh
        mov dword [byte ebp-08h], eax
        add edx, eax
        imul eax, ebx, byte 38h
        mov dword [byte ebp-0Ch], eax
        lea eax, [dword ecx+0132Dh]
        add eax, dword [byte ebp-0Ch]
        mov dword [byte ebp-0Ch], eax
        add eax, byte 28h
        call FindPlayerStat
        imul edx, ebx, dword 0BCh
        mov eax, dword [RosterTeams]
        add eax, edi
        add eax, 1D8Eh
        add edx, eax
        mov eax, dword [byte ebp-0Ch]
        add eax, byte 18h
        call FindPlayerRecord
        mov eax, dword [RosterTeams]
        add eax, edi
        add eax, 4BAh
        mov edx, 1
        add eax, dword [byte ebp-08h]
        call PlayerOverall
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [RosterTeams]
        add eax, edi
        add eax, dword [byte ebp-08h]
        mov dl, byte [byte ebp-0Ch]
        mov byte [dword eax+04DFh], dl
        mov eax, dword [RosterTeams]
        add eax, edi
        add eax, 4BAh
        add eax, dword [byte ebp-08h]
        add eax, byte 10h
        call SkaterOverall
        mov edx, eax
        mov eax, dword [RosterTeams]
        add eax, edi
        mov dword [byte ebp-08h], eax
        lea eax, [ebx+ebx]
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [byte ebp-08h]
        add eax, dword [byte ebp-0Ch]
        mov word [dword eax+0328Eh], dx
        mov eax, dword [RosterTeams]
        inc ebx
        add eax, edi
        mov byte [dword ebx+eax+03239h], 0
.17:
        movsx eax, word [dword ecx+0132Bh]
        cmp ebx, eax
        jl near .16
        xor ebx, ebx
        imul edi, esi, dword 32C6h
        jmp near .19
.18:
        mov eax, dword [RosterTeams]
        add eax, edi
        mov dword [byte ebp-0Ch], eax
        imul eax, ebx, byte 27h
        mov edx, dword [byte ebp-0Ch]
        add edx, 889h
        mov dword [byte ebp-08h], eax
        add edx, eax
        imul eax, ebx, byte 38h
        mov dword [byte ebp-0Ch], eax
        lea eax, [dword ecx+018A7h]
        add eax, dword [byte ebp-0Ch]
        mov dword [byte ebp-0Ch], eax
        add eax, byte 28h
        call FindPlayerStat
        imul eax, ebx, dword 0BCh
        mov edx, dword [RosterTeams]
        add edx, edi
        add edx, 2FEAh
        add edx, eax
        mov eax, dword [byte ebp-0Ch]
        add eax, byte 18h
        call FindPlayerRecord
        mov eax, dword [RosterTeams]
        add eax, edi
        add eax, 889h
        xor edx, edx
        add eax, dword [byte ebp-08h]
        call PlayerOverall
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [RosterTeams]
        add eax, edi
        add eax, dword [byte ebp-08h]
        mov dl, byte [byte ebp-0Ch]
        mov byte [dword eax+08AAh], dl
        mov eax, dword [RosterTeams]
        add eax, edi
        add eax, 889h
        add eax, dword [byte ebp-08h]
        add eax, byte 10h
        call GoalieOverall
        mov edx, eax
        mov eax, dword [RosterTeams]
        add eax, edi
        mov dword [byte ebp-08h], eax
        lea eax, [ebx+ebx]
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [byte ebp-08h]
        add eax, dword [byte ebp-0Ch]
        mov word [dword eax+032C0h], dx
        mov eax, dword [RosterTeams]
        inc ebx
        add eax, edi
        mov byte [dword ebx+eax+03252h], 0
.19:
        movsx eax, word [dword ecx+018A5h]
        cmp ebx, eax
        jl near .18
        cmp dword [byte ebp-018h], byte 0
        jne near .34
        mov eax, dword [RosterData]
        cmp word [eax], byte 0
        jle near .34
        xor edi, edi
        jmp near .33
.20:
        xor ebx, ebx
        jmp short .23
.21:
        imul edx, edi, byte 38h
        mov eax, dword [RosterData]
        mov dword [byte ebp-08h], edx
        mov edx, dword [dword eax+0383C1h]
        imul eax, ebx, byte 38h
        mov dword [byte ebp-0Ch], eax
        lea eax, [dword ecx+0D09h]
        add eax, dword [byte ebp-0Ch]
        add edx, dword [byte ebp-08h]
        add eax, byte 18h
        add edx, byte 18h
        call KeysEqual
        test eax, eax
        je short .22
        imul eax, esi, dword 32C6h
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp-0Ch]
        or byte [dword ebx+eax+0321Eh], 20h
.22:
        inc ebx
.23:
        movsx eax, word [dword ecx+0D05h]
        cmp ebx, eax
        jl short .21
        xor ebx, ebx
        jmp short .26
.24:
        imul edx, edi, byte 38h
        mov eax, dword [RosterData]
        mov eax, dword [dword eax+0383C1h]
        add eax, edx
        lea edx, [byte eax+018h]
        imul eax, ebx, byte 38h
        mov dword [byte ebp-0Ch], eax
        lea eax, [dword ecx+01283h]
        add eax, dword [byte ebp-0Ch]
        add eax, byte 18h
        call KeysEqual
        test eax, eax
        je short .25
        imul eax, esi, dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        or byte [dword ebx+eax+03237h], 20h
.25:
        inc ebx
.26:
        movsx eax, word [dword ecx+01281h]
        cmp ebx, eax
        jl short .24
        xor ebx, ebx
        jmp short .29
.27:
        imul edx, edi, byte 38h
        mov eax, dword [RosterData]
        mov eax, dword [dword eax+0383C1h]
        add eax, edx
        lea edx, [byte eax+018h]
        imul eax, ebx, byte 38h
        mov dword [byte ebp-0Ch], eax
        lea eax, [dword ecx+0132Dh]
        add eax, dword [byte ebp-0Ch]
        add eax, byte 18h
        call KeysEqual
        test eax, eax
        je short .28
        imul eax, esi, dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        or byte [dword ebx+eax+0323Ah], 20h
.28:
        inc ebx
.29:
        movsx eax, word [dword ecx+0132Bh]
        cmp ebx, eax
        jl short .27
        xor ebx, ebx
        jmp short .32
.30:
        imul edx, edi, byte 38h
        mov eax, dword [RosterData]
        mov dword [byte ebp-0Ch], edx
        mov edx, dword [dword eax+0383C1h]
        imul eax, ebx, byte 38h
        mov dword [byte ebp-08h], eax
        lea eax, [dword ecx+018A7h]
        add eax, dword [byte ebp-08h]
        add edx, dword [byte ebp-0Ch]
        add eax, byte 18h
        add edx, byte 18h
        call KeysEqual
        test eax, eax
        je short .31
        imul eax, esi, dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        or byte [dword ebx+eax+03253h], 20h
.31:
        inc ebx
.32:
        movsx eax, word [dword ecx+018A5h]
        cmp ebx, eax
        jl short .30
        inc edi
.33:
        mov eax, dword [RosterData]
        movsx eax, word [eax]
        cmp edi, eax
        jl near .20
.34:
        mov eax, dword [byte ebp-014h]
        call RateTrade
.35:
        mov eax, dword [byte ebp-04h]
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; InitRosterData                                  C885D  97 PC, low confidence
; Roster screen: allocates "deletion indices" and "roster player info" and
; fills them (LoadRosterData)
;-----------------------------------------------------------------------------
InitRosterData:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov esi, 1
        mov dword [RosterTeam], 0
        mov dword [RosterData], 0
        mov dword [RosterFreeAgents], 0
        mov dword [RosterEditOpen], 0
        mov dword [RosterTradeOn], 0
        mov dword [RosterOtherTeam], esi
        cmp eax, esi
        jb short .1
        jbe near .9
        cmp eax, byte 2
        je near .21
        jmp near .35
.1:
        test eax, eax
        jne near .35
        mov eax, dword [gameopts]
        mov edx, dword [byte eax+01h]
        shl edx, 0Ch
        shr edx, 1Ah
        mov dword [RosterTeam], edx
        mov eax, dword [byte eax+01h]
        shl eax, 6
        shr eax, 1Ah
        mov dword [RosterOtherTeam], eax
        test edx, edx
        jl short .2
        cmp edx, byte 1Ah
        jl short .4
.2:
        cmp dword [RosterOtherTeam], byte 0
        je short .3
        mov dword [RosterTeam], 0
        jmp short .4
.3:
        mov dword [RosterTeam], 1
.4:
        cmp dword [RosterOtherTeam], byte 0
        jl short .5
        cmp dword [RosterOtherTeam], byte 1Ah
        jl short .7
.5:
        cmp dword [RosterTeam], byte 0
        je short .6
        mov dword [RosterOtherTeam], 0
        jmp short .7
.6:
        mov dword [RosterOtherTeam], 1
.7:
        mov eax, dword [RosterTeam]
        cmp eax, dword [RosterOtherTeam]
        jne short .8
        inc eax
        mov ebx, 1Ah
        cdq
        idiv ebx
        mov dword [RosterOtherTeam], edx
.8:
        push byte 20h
        push dword 7D0h
        push str_DeletionIndices
        mov dword [RosterChanged], 1
        mov dword [DeletionCount], 0
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 5281Ch
        mov ebx, 5281Ch
        mov dword [RosterInfoAnim], 5281Ch
        push str_RosterPlayerInfo
        mov dword [RosterInfoLoaded], 1
        mov dword [RosterPlayerInfo], eax
        call AllocMemBlock
        add esp, byte 0Ch
        xor edx, edx
        mov dword [RosterTeams], eax
        call memset_
        mov eax, RosterData
        call LoadFakeExhibition
        test eax, eax
        jne near .20
        jmp near DrawRatingBars_158
.9:
        mov dword [RosterOtherTeam], 0FFFFFFFFh
        mov eax, dword [SeasonDefaultUser]
        mov edx, 0FFFFFFFFh
        mov dword [RosterTeam], eax
        xor eax, eax
.10:
        cmp eax, dword [RosterTeam]
        je short .12
        imul ebx, eax, byte 1Ch
        cmp byte [dword ebx+SeasonUserActive], 1
        jne short .12
        test edx, edx
        jge short .11
        mov edx, eax
.11:
        imul ebx, eax, byte 1Ch
        cmp byte [dword ebx+SeasonUserHuman], 1
        je short .12
        cmp byte [dword ebx+SeasonUserLocked], 0
        je short .12
        mov dword [RosterChanged], 1
        mov dword [RosterOtherTeam], eax
        jmp short .13
.12:
        inc eax
        cmp eax, byte 1Ah
        jl short .10
.13:
        cmp dword [RosterOtherTeam], byte 0
        jge short .17
        test edx, edx
        jl short .14
        mov dword [RosterOtherTeam], edx
        jmp short .16
.14:
        cmp dword [RosterTeam], byte 0
        je short .15
        mov dword [RosterOtherTeam], 0
        jmp short .16
.15:
        mov dword [RosterOtherTeam], 1
.16:
        mov dword [RosterChanged], 0
.17:
        imul eax, dword [RosterTeam], byte 1Ch
        cmp byte [dword eax+SeasonUserLocked], 0
        je short .18
        imul eax, dword [RosterOtherTeam], byte 1Ch
        cmp byte [dword eax+SeasonUserLocked], 0
        je short .18
        mov dword [RosterChanged], 1
        jmp short .19
.18:
        mov dword [RosterChanged], 0
.19:
        call AllocRosterInfo
        and esi, eax
.20:
        mov ebx, 1
        mov edx, edi
        xor eax, eax
        call LoadRosterData
        mov ebx, 1
        mov edx, edi
        and esi, eax
        mov eax, ebx
        call LoadRosterData
        and eax, esi
        jmp near DrawRatingBars_158
.21:
        mov dword [RosterTeam], 0FFFFFFFFh
        mov dword [RosterOtherTeam], 0FFFFFFFFh
        mov ecx, 0FFFFFFFFh
        mov dword [RosterChanged], 0
        xor eax, eax
        mov edx, ecx
.22:
        imul ebx, eax, byte 1Ch
        cmp byte [dword ebx+PlayoffUserActive], 1
        jne short .25
        test edx, edx
        jge short .23
        mov edx, eax
        jmp short .24
.23:
        test ecx, ecx
        jge short .24
        mov ecx, eax
.24:
        imul ebx, eax, byte 1Ch
        cmp byte [dword ebx+PlayoffUserHuman], 1
        je short .25
        cmp byte [dword ebx+PlayoffUserLocked], 0
        je short .25
        mov dword [RosterTeam], eax
        jmp short .26
.25:
        inc eax
        cmp eax, byte 10h
        jl short .22
.26:
        cmp dword [RosterTeam], byte 0
        jge short .28
        test edx, edx
        jl short .27
        mov dword [RosterTeam], edx
        jmp short .28
.27:
        mov dword [RosterTeam], 0
.28:
        xor eax, eax
.29:
        cmp eax, dword [RosterTeam]
        je short .30
        imul ebx, eax, byte 1Ch
        cmp byte [dword ebx+PlayoffUserActive], 1
        jne short .30
        cmp byte [dword ebx+PlayoffUserHuman], 1
        je short .30
        cmp byte [dword ebx+PlayoffUserLocked], 0
        je short .30
        mov dword [RosterOtherTeam], eax
        jmp short .31
.30:
        inc eax
        cmp eax, byte 10h
        jl short .29
.31:
        cmp dword [RosterOtherTeam], byte 0
        jge near .19
        test edx, edx
        jl short .32
        cmp edx, dword [RosterTeam]
        je short .32
        mov dword [RosterOtherTeam], edx
        jmp near .19
.32:
        test ecx, ecx
        jl short .33
        mov dword [RosterOtherTeam], ecx
        jmp near .19
.33:
        cmp dword [RosterTeam], byte 0
        je short .34
        mov dword [RosterOtherTeam], 0
        jmp near .19
.34:
        mov dword [RosterOtherTeam], 1
        jmp near .19
.35:
        xor eax, eax
        jmp near DrawRatingBars_158
;-----------------------------------------------------------------------------
; FreeRosterData                                  C8BEE  97 PC, low confidence
; Frees the roster data
;-----------------------------------------------------------------------------
FreeRosterData:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        cmp dword [RosterTeams], byte 0
        je short .1
        push dword [RosterTeams]
        call FreeMemBlock
        mov dword [RosterTeams], 0
        mov dword [RosterInfoLoaded], 0
        mov dword [RosterInfoAnim], 0
        add esp, byte 4
.1:
        cmp dword [RosterFreeAgents], byte 0
        je short .2
        push dword [RosterFreeAgents]
        call FreeMemBlock
        mov dword [RosterFreeAgents], 0
        add esp, byte 4
.2:
        cmp dword [RosterPlayerInfo], byte 0
        je short .3
        push dword [RosterPlayerInfo]
        call FreeMemBlock
        mov dword [RosterPlayerInfo], 0
        add esp, byte 4
.3:
        cmp ebx, byte 1
        jae short .4
        test ebx, ebx
        jne short .4
        cmp dword [RosterData], byte 0
        je short .4
        mov eax, RosterData
        call FreeExhibitionFile
        mov dword [RosterData], ebx
.4:
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawRosterRow                                   C8C90  97 PC, low confidence
; Draws one row of the roster list
;-----------------------------------------------------------------------------
DrawRosterRow:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 14h, 0
        push eax
        mov dword [byte ebp-0Ch], 16h
        mov esi, eax
        mov eax, dword [nosplit eax*8+str_Punct_DrawRosterList]
        mov dword [byte ebp-04h], 14h
        mov dword [byte ebp-010h], eax
        mov eax, dword [nosplit esi*8+str_X_DrawRosterList]
        mov dword [byte ebp-014h], 0
        mov dword [byte ebp-08h], eax
        cmp esi, byte 1
        jne short .1
        mov dword [byte ebp-04h], 1Eh
.1:
        mov eax, dword [byte ebp-018h]
        imul edi, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        xor esi, esi
        movsx edi, word [byte edi+eax+072h]
        jmp short .3
.2:
        imul edx, dword [byte ebp-04h], byte 52h
        push dword [byte ebp-0Ch]
        mov ecx, 0B4h
        mov ebx, dword [byte ebp-08h]
        mov eax, dword [RosterRow]
        inc edi
        add eax, edx
        mov edx, dword [byte ebp-010h]
        inc esi
        call InitListBox
        mov eax, dword [byte ebp-0Ch]
        inc dword [byte ebp-04h]
        add dword [byte ebp-08h], eax
.3:
        cmp esi, byte 0Ah
        jge short .4
        mov eax, dword [byte ebp-018h]
        imul eax, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+0D05h]
        cmp edi, eax
        jl short .2
.4:
        mov eax, dword [byte ebp-018h]
        imul eax, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+0D05h]
        sub edi, eax
        jmp short .6
.5:
        imul eax, dword [byte ebp-04h], byte 52h
        push dword [byte ebp-0Ch]
        mov ecx, 0B4h
        mov ebx, dword [byte ebp-08h]
        mov edx, dword [RosterRow]
        inc edi
        add eax, edx
        mov edx, dword [byte ebp-010h]
        inc esi
        call InitListBox
        mov eax, dword [byte ebp-0Ch]
        inc dword [byte ebp-04h]
        add dword [byte ebp-08h], eax
.6:
        cmp esi, byte 0Ah
        jge short .7
        mov eax, dword [byte ebp-018h]
        imul edx, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+01281h]
        cmp edi, eax
        jl short .5
.7:
        test esi, esi
        jle short .8
        cmp esi, byte 0Ah
        jge short .8
        mov eax, dword [byte ebp-0Ch]
        inc dword [byte ebp-014h]
        inc esi
        add dword [byte ebp-08h], eax
.8:
        mov eax, dword [byte ebp-018h]
        imul eax, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+01281h]
        sub edi, eax
        jmp short .10
.9:
        imul eax, dword [byte ebp-04h], byte 52h
        push dword [byte ebp-0Ch]
        mov ecx, 0B4h
        mov ebx, dword [byte ebp-08h]
        mov edx, dword [RosterRow]
        inc edi
        add eax, edx
        mov edx, dword [byte ebp-010h]
        inc esi
        call InitListBox
        mov eax, dword [byte ebp-0Ch]
        inc dword [byte ebp-04h]
        add dword [byte ebp-08h], eax
.10:
        cmp esi, byte 0Ah
        jge short .11
        mov eax, dword [byte ebp-018h]
        imul edx, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+0132Bh]
        cmp edi, eax
        jl short .9
.11:
        mov eax, dword [byte ebp-018h]
        imul edx, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+0132Bh]
        sub edi, eax
        jmp short .13
.12:
        imul eax, dword [byte ebp-04h], byte 52h
        push dword [byte ebp-0Ch]
        mov ecx, 0B4h
        mov ebx, dword [byte ebp-08h]
        mov edx, dword [RosterRow]
        inc edi
        add eax, edx
        mov edx, dword [byte ebp-010h]
        inc esi
        call InitListBox
        mov eax, dword [byte ebp-0Ch]
        inc dword [byte ebp-04h]
        add dword [byte ebp-08h], eax
.13:
        cmp esi, byte 0Ah
        jge short .15
        mov eax, dword [byte ebp-018h]
        imul eax, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+018A5h]
        cmp edi, eax
        jl short .12
        jmp short .15
.14:
        imul edx, dword [byte ebp-04h], byte 52h
        push byte 1
        mov ecx, 1
        mov ebx, 1E0h
        mov eax, dword [RosterRow]
        inc esi
        add eax, edx
        mov edx, 280h
        inc dword [byte ebp-04h]
        call InitListBox
.15:
        mov eax, esi
        sub eax, dword [byte ebp-014h]
        cmp eax, byte 0Ah
        jl short .14
        jmp near DrawRatingBars_157
;-----------------------------------------------------------------------------
; DrawRosterList                                  C8EDC  97 PC, low confidence
; Roster screen: the "Team Roster" / "Additional Players" lists
;-----------------------------------------------------------------------------
DrawRosterList:
        push ebx
        push ecx
        push esi
        push edi
        enter 0A0h, 0
        sub ebp, 82h
        mov edi, eax
        mov dword [byte ebp+036h], edx
        and edi, byte 1
        mov eax, dword [nosplit edi*8+str_Punct_DrawRosterList]
        add eax, byte 8
        mov dword [byte ebp+06Eh], eax
        mov eax, dword [nosplit edi*8+str_X_DrawRosterList]
        add eax, byte 6
        mov dword [byte ebp+07Ah], 0
        mov dword [byte ebp+07Eh], eax
        mov eax, dword [nosplit edi*8+str_X_DrawRosterList]
        mov dword [byte ebp+076h], 16h
        sub eax, byte 16h
        mov dword [byte ebp+03Eh], 14h
        sub eax, byte 6
        mov dword [byte ebp+03Ah], 1
        mov dword [byte ebp+072h], eax
        cmp edi, byte 1
        jne short .1
        mov dword [byte ebp+03Eh], 1Eh
.1:
        imul esi, dword [nosplit edi*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        movsx esi, word [byte esi+eax+072h]
        mov eax, edi
        call DrawRosterRow
        push dword [RosterPanelBitmap]
        call SetDrawTarget
        add esp, byte 4
        mov eax, dword [nosplit edi*4+RosterPanelLayers]
        push dword [byte eax+02Ch]
        call BlitShape
        imul eax, dword [nosplit edi*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add esp, byte 4
        cmp byte [byte edx+eax+071h], 0
        jbe near .5
        mov dword [byte ebp+06Ah], 0
        jmp short .4
.2:
        mov eax, dword [byte ebp+06Ah]
        movzx edx, byte [byte ebx+eax+06Eh]
        movsx eax, word [byte ebx+072h]
        sub edx, eax
        mov eax, edx
        test edx, edx
        jl short .3
        cmp edx, byte 0Ah
        jge short .3
        add eax, dword [byte ebp+03Eh]
        imul eax, byte 52h
        push dword [byte ebp+076h]
        mov edx, dword [RosterRow]
        push dword 0B4h
        push dword [byte edx+eax+02Ah]
        push dword 0FF0000AAh
        mov ebx, dword [nosplit edi*8+str_Punct_DrawRosterList]
        call MakeColor
        mov edx, eax
        add esp, byte 4
        mov eax, dword [RosterPanelBitmap]
        mov ecx, ebx
        mov ebx, 10h
        mov eax, dword [byte eax+02Ch]
        call DrawHighlightBar
.3:
        inc dword [byte ebp+06Ah]
.4:
        imul ebx, dword [nosplit edi*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        add ebx, eax
        movzx eax, byte [byte ebx+071h]
        cmp eax, dword [byte ebp+06Ah]
        jg short .2
.5:
        call SetHighlightText
        xor ebx, ebx
        jmp near .11
.6:
        cmp dword [byte ebp+07Ah], byte 0
        jne near .7
        mov eax, dword [byte ebp+072h]
        add eax, dword [byte ebp+076h]
        push eax
        mov eax, dword [byte ebp+05Ah]
        mov eax, dword [dword eax+RosterPanelLayers]
        mov eax, dword [byte eax+02Ch]
        movsx eax, word [byte eax+0Ch]
        push dword [byte ebp+072h]
        lea edx, [dword eax+0B4h]
        push edx
        push eax
        call SetClipWindow
        add esp, byte 10h
        push dword [RosterPanelShape]
        call BlitShape
        add esp, byte 4
        push dword 0FFFFFF50h
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 0D6h
        call GetLangText
        push eax
        mov dword [byte ebp+032h], eax
        call MeasureText
        add esp, byte 4
        mov eax, dword [byte ebp+072h]
        push dword [byte ebp+032h]
        add eax, byte 6
        push eax
        mov eax, dword [byte ebp+05Ah]
        mov eax, dword [dword eax+RosterPanelLayers]
        mov eax, dword [byte eax+02Ch]
        movsx edx, word [byte eax+04h]
        sar edx, 1
        movsx eax, word [byte eax+0Ch]
        add eax, edx
        push eax
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        inc dword [byte ebp+07Ah]
        call ResetClipWindow
.7:
        imul eax, dword [nosplit edi*4+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add ecx, eax
        imul eax, esi, dword 0BCh
        mov dword [byte ebp+032h], ecx
        add ecx, 8FEh
        add ecx, eax
        add ecx, byte 8
        push ecx
        imul ecx, esi, byte 38h
        add eax, dword [byte ebp+032h]
        movzx eax, byte [dword eax+0916h]
        push eax
        mov eax, dword [byte ebp+032h]
        mov eax, dword [eax]
        add eax, ecx
        mov dword [byte ebp+04Ah], ecx
        movzx ecx, byte [dword eax+0D0Ah]
        push ecx
        movzx eax, byte [dword eax+0D0Bh]
        call PositionAbbrev
        movzx eax, al
        push eax
        push str_CDCS2
        lea eax, [byte ebp-01Eh]
        push eax
        call sprintf_
        imul eax, dword [nosplit edi*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        add eax, dword [byte ebp+04Ah]
        add esp, byte 18h
        test byte [dword eax+0D09h], 4
        je short .8
        push dword 0FF8080h
        jmp short .10
.8:
        test byte [dword eax+0D09h], 1
        je short .9
        push dword 0FFFF80h
        jmp short .10
.9:
        push byte 0FFFFFFFFh
.10:
        call MakeColor
        add esp, byte 4
        call SetTextColor
        lea eax, [byte ebp-01Eh]
        push eax
        push dword [byte ebp+07Eh]
        push dword [byte ebp+06Eh]
        push byte 0
        inc esi
        inc ebx
        call DrawTextAligned
        mov eax, dword [byte ebp+076h]
        add esp, byte 10h
        add dword [byte ebp+07Eh], eax
.11:
        cmp ebx, byte 0Ah
        jge short .12
        mov eax, edi
        shl eax, 2
        mov dword [byte ebp+05Ah], eax
        imul eax, dword [dword eax+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+0D05h]
        cmp esi, eax
        jl near .6
.12:
        imul eax, dword [nosplit edi*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+0D05h]
        sub esi, eax
        jmp near .18
.13:
        cmp dword [byte ebp+07Ah], byte 0
        jne near .14
        mov eax, dword [byte ebp+072h]
        add eax, dword [byte ebp+076h]
        push eax
        mov eax, dword [byte ebp+062h]
        mov eax, dword [dword eax+RosterPanelLayers]
        mov eax, dword [byte eax+02Ch]
        movsx eax, word [byte eax+0Ch]
        push dword [byte ebp+072h]
        lea edx, [dword eax+0B4h]
        push edx
        push eax
        call SetClipWindow
        add esp, byte 10h
        push dword [RosterPanelShape]
        call BlitShape
        add esp, byte 4
        push dword 0FFFFFF50h
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 0D6h
        call GetLangText
        push eax
        mov dword [byte ebp+032h], eax
        call MeasureText
        add esp, byte 4
        mov eax, dword [byte ebp+072h]
        push dword [byte ebp+032h]
        add eax, byte 6
        push eax
        mov eax, dword [byte ebp+062h]
        mov eax, dword [dword eax+RosterPanelLayers]
        mov eax, dword [byte eax+02Ch]
        movsx edx, word [byte eax+04h]
        sar edx, 1
        movsx eax, word [byte eax+0Ch]
        add eax, edx
        push eax
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        inc dword [byte ebp+07Ah]
        call ResetClipWindow
.14:
        imul eax, dword [nosplit edi*4+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add ecx, eax
        imul eax, esi, dword 0BCh
        mov dword [byte ebp+032h], ecx
        add ecx, 1B5Ah
        add ecx, eax
        add ecx, byte 8
        push ecx
        imul ecx, esi, byte 38h
        add eax, dword [byte ebp+032h]
        movzx eax, byte [dword eax+01B72h]
        push eax
        mov eax, dword [byte ebp+032h]
        mov eax, dword [eax]
        add eax, ecx
        mov dword [byte ebp+052h], ecx
        movzx ecx, byte [dword eax+01284h]
        push ecx
        movzx eax, byte [dword eax+01285h]
        call PositionAbbrev
        movzx eax, al
        push eax
        push str_CDCS2
        lea eax, [byte ebp-01Eh]
        push eax
        call sprintf_
        imul eax, dword [nosplit edi*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        add eax, dword [byte ebp+052h]
        add esp, byte 18h
        test byte [dword eax+01283h], 4
        je short .15
        push dword 0FF8080h
        jmp short .17
.15:
        test byte [dword eax+01283h], 1
        je short .16
        push dword 0FFFF80h
        jmp short .17
.16:
        push byte 0FFFFFFFFh
.17:
        call MakeColor
        add esp, byte 4
        call SetTextColor
        lea eax, [byte ebp-01Eh]
        push eax
        push dword [byte ebp+07Eh]
        push dword [byte ebp+06Eh]
        push byte 0
        inc esi
        inc ebx
        call DrawTextAligned
        mov eax, dword [byte ebp+076h]
        add esp, byte 10h
        add dword [byte ebp+07Eh], eax
.18:
        cmp ebx, byte 0Ah
        jge short .19
        mov eax, edi
        shl eax, 2
        mov dword [byte ebp+062h], eax
        imul eax, dword [dword eax+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+01281h]
        cmp esi, eax
        jl near .13
.19:
        mov eax, edi
        shl eax, 2
        imul edx, dword [dword eax+RosterTeam], dword 32C6h
        mov dword [byte ebp+04Eh], eax
        mov eax, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+01281h]
        sub esi, eax
        test ebx, ebx
        jle near .26
        cmp ebx, byte 0Ah
        jge near .26
        push dword 0FFFFFF50h
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 0D7h
        call GetLangText
        push eax
        mov dword [byte ebp+032h], eax
        call MeasureText
        mov eax, dword [byte ebp+04Eh]
        mov eax, dword [dword eax+RosterPanelLayers]
        mov eax, dword [byte eax+02Ch]
        add esp, byte 4
        movsx edx, word [byte eax+04h]
        push dword [byte ebp+032h]
        sar edx, 1
        movsx eax, word [byte eax+0Ch]
        push dword [byte ebp+07Eh]
        add eax, edx
        push eax
        push byte 1
        inc dword [byte ebp+07Ah]
        jmp near .25
.20:
        cmp dword [byte ebp+07Ah], byte 0
        jne near .21
        mov eax, dword [byte ebp+072h]
        add eax, dword [byte ebp+076h]
        push eax
        mov eax, dword [byte ebp+066h]
        mov eax, dword [dword eax+RosterPanelLayers]
        mov eax, dword [byte eax+02Ch]
        movsx eax, word [byte eax+0Ch]
        push dword [byte ebp+072h]
        lea edx, [dword eax+0B4h]
        push edx
        push eax
        call SetClipWindow
        add esp, byte 10h
        push dword [RosterPanelShape]
        call BlitShape
        add esp, byte 4
        push dword 0FFFFFF50h
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 0D7h
        call GetLangText
        push eax
        mov dword [byte ebp+032h], eax
        call MeasureText
        add esp, byte 4
        mov eax, dword [byte ebp+072h]
        push dword [byte ebp+032h]
        add eax, byte 6
        push eax
        mov eax, dword [byte ebp+066h]
        mov eax, dword [dword eax+RosterPanelLayers]
        mov eax, dword [byte eax+02Ch]
        movsx edx, word [byte eax+04h]
        sar edx, 1
        movsx eax, word [byte eax+0Ch]
        add edx, eax
        push edx
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        inc dword [byte ebp+07Ah]
        call ResetClipWindow
.21:
        imul eax, dword [nosplit edi*4+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add ecx, eax
        imul eax, esi, dword 0BCh
        mov dword [byte ebp+032h], ecx
        add ecx, 1D8Eh
        add ecx, eax
        add ecx, byte 8
        push ecx
        imul ecx, esi, byte 38h
        add eax, dword [byte ebp+032h]
        movzx eax, byte [dword eax+01DA6h]
        push eax
        mov eax, dword [byte ebp+032h]
        mov eax, dword [eax]
        add eax, ecx
        mov dword [byte ebp+042h], ecx
        movzx ecx, byte [dword eax+0132Eh]
        push ecx
        movzx eax, byte [dword eax+0132Fh]
        call PositionAbbrev
        movzx eax, al
        push eax
        push str_CDCS2
        lea eax, [byte ebp-01Eh]
        push eax
        call sprintf_
        imul eax, dword [nosplit edi*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        add eax, dword [byte ebp+042h]
        add esp, byte 18h
        test byte [dword eax+0132Dh], 4
        je short .22
        push dword 0FF8080h
        jmp short .24
.22:
        test byte [dword eax+0132Dh], 1
        je short .23
        push dword 0FFFF80h
        jmp short .24
.23:
        push dword 0C0FFC0h
.24:
        call MakeColor
        add esp, byte 4
        call SetTextColor
        lea eax, [byte ebp-01Eh]
        push eax
        push dword [byte ebp+07Eh]
        push dword [byte ebp+06Eh]
        push byte 0
        inc esi
.25:
        inc ebx
        call DrawTextAligned
        mov eax, dword [byte ebp+076h]
        add esp, byte 10h
        add dword [byte ebp+07Eh], eax
.26:
        cmp ebx, byte 0Ah
        jge short .27
        mov eax, edi
        shl eax, 2
        mov dword [byte ebp+066h], eax
        imul eax, dword [dword eax+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+0132Bh]
        cmp esi, eax
        jl near .20
.27:
        imul edx, dword [nosplit edi*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+0132Bh]
        sub esi, eax
        jmp near .32
.28:
        imul eax, esi, dword 0BCh
        add ecx, 2FEAh
        add ecx, eax
        add ecx, byte 8
        add eax, dword [byte ebp+05Eh]
        push ecx
        movzx eax, byte [dword eax+03002h]
        push eax
        imul eax, esi, byte 38h
        mov dword [byte ebp+046h], eax
        mov eax, dword [byte ebp+056h]
        add eax, dword [byte ebp+046h]
        movzx ecx, byte [dword eax+018A8h]
        push ecx
        movzx eax, byte [dword eax+018A9h]
        call PositionAbbrev
        movzx eax, al
        push eax
        push str_CDCS2
        lea eax, [byte ebp-01Eh]
        push eax
        call sprintf_
        imul eax, dword [dword edx+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        add eax, dword [byte ebp+046h]
        add esp, byte 18h
        test byte [dword eax+018A7h], 4
        je short .29
        push dword 0FF8080h
        jmp short .31
.29:
        test byte [dword eax+018A7h], 1
        je short .30
        push dword 0FFFF80h
        jmp short .31
.30:
        push dword 0C0FFC0h
.31:
        call MakeColor
        add esp, byte 4
        call SetTextColor
        lea eax, [byte ebp-01Eh]
        push eax
        push dword [byte ebp+07Eh]
        push dword [byte ebp+06Eh]
        push byte 0
        inc esi
        inc ebx
        call DrawTextAligned
        mov eax, dword [byte ebp+076h]
        add esp, byte 10h
        add dword [byte ebp+07Eh], eax
.32:
        cmp ebx, byte 0Ah
        jge short .33
        mov edx, edi
        shl edx, 2
        imul eax, dword [dword edx+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add ecx, eax
        mov eax, dword [ecx]
        mov dword [byte ebp+056h], eax
        movsx eax, word [dword eax+018A5h]
        mov dword [byte ebp+05Eh], ecx
        cmp esi, eax
        jl near .28
.33:
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        call SetNormalText
        cmp dword [byte ebp+036h], byte 0
        je short .34
        call SetScreenTarget
        mov ebx, dword [nosplit edi*4+RosterPanelLayers]
        mov ebx, dword [byte ebx+02Ch]
        movsx eax, word [byte ebx+0Eh]
        movsx edx, word [byte ebx+06h]
        add edx, eax
        push edx
        sub eax, dword [byte ebp+076h]
        push eax
        movsx edx, word [byte ebx+04h]
        movsx eax, word [byte ebx+0Ch]
        add edx, eax
        push edx
        push eax
        call SetClipWindow
        add esp, byte 10h
        push byte 0
        mov eax, dword [RosterPanelBitmap]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call ResetClipWindow
        call PresentScreen
.34:
        imul eax, dword [nosplit edi*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        movsx edx, word [byte edx+eax+074h]
        inc edx
        mov eax, dword [nosplit edi*4+RosterListBox]
        call SetListSelection
        mov edx, dword [RosterPanelBitmap]
        mov eax, dword [nosplit edi*4+RosterListBox]
        call DrawScrollBar
        mov eax, dword [byte ebp+03Ah]
DrawRosterList_86F:
        lea esp, [dword ebp+082h]
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawRosterLogo                                  C9757  97 PC, low confidence
; Draws the team logo on the roster screen
;-----------------------------------------------------------------------------
DrawRosterLogo:
        push ecx
        push esi
        push edi
        enter 4, 0
        push eax
        mov eax, edx
        call LoadTeamLogo
        mov eax, dword [ShadowShape]
        movsx edi, word [byte eax+04h]
        imul edi, dword 0B333h
        movsx eax, word [byte eax+06h]
        imul eax, dword 0B333h
        push byte 0
        sar eax, 10h
        push eax
        sar edi, 10h
        push edi
        mov dword [byte ebp-04h], eax
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov esi, eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        call ClearScreen
        add esp, byte 4
        push byte 0
        push byte 0
        push dword [ShadowShape]
        push dword 0B333h
        call DrawShapeBlended
        add esp, byte 10h
        call FreeLogoArt
        push dword [byte ebp-04h]
        mov eax, dword [byte ebp-04h]
        mov edx, dword [byte ebx+04h]
        sar eax, 1
        push edi
        sub edx, eax
        mov eax, edi
        push edx
        sar eax, 1
        mov edx, dword [ebx]
        sub edx, eax
        push edx
        xor ecx, ecx
        mov ebx, 0Ch
        push byte 0
        mov eax, dword [byte esi+02Ch]
        mov edx, dword [byte ebp-08h]
        call DrawShadedLogo
        push esi
        call FreeBitmap
        add esp, byte 4
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; ShowRosterLogo                                  C97FF  97 PC, low confidence
; Shows the team logo panel
;-----------------------------------------------------------------------------
ShowRosterLogo:
        push ebx
        push ecx
        push edx
        enter 20h, 0
        mov dword [byte ebp-01Ch], 0BEh
        mov dword [byte ebp-020h], 98h
        mov edx, dword [RosterTeam]
        cmp dword [RosterScrollList], byte 1Ah
        jge short .1
        mov edx, dword [nosplit edx*4+PlayoffTeams]
.1:
        mov eax, dword [RosterPanelBitmap]
        lea ebx, [byte ebp-020h]
        mov eax, dword [byte eax+02Ch]
        call DrawRosterLogo
        mov dword [byte ebp-020h], 1EAh
        mov dword [byte ebp-01Ch], 0BEh
        mov edx, dword [RosterOtherTeam]
        cmp dword [RosterScrollList], byte 1Ah
        jge short .2
        mov edx, dword [nosplit edx*4+PlayoffTeams]
.2:
        mov eax, dword [RosterPanelBitmap]
        lea ebx, [byte ebp-020h]
        mov eax, dword [byte eax+02Ch]
        call DrawRosterLogo
        mov eax, dword [RosterTitleRight]
        sub eax, dword [str_X_ShowRosterLogo]
        push eax
        mov eax, dword [RosterTitleX]
        add eax, 0B4h
        mov edx, 14h
        sub eax, dword [str_Punct_DrawRosterList]
        mov ecx, dword [str_X_ShowRosterLogo]
        push eax
        mov eax, dword [RosterPanelBitmap]
        mov ebx, dword [str_Punct_DrawRosterList]
        sub ecx, byte 6
        mov eax, dword [byte eax+02Ch]
        call DrawShadowBox
        leave
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawRosterTitle                                 C98B1  97 PC, low confidence
; Draws the roster screen title
;-----------------------------------------------------------------------------
DrawRosterTitle:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        call SetNormalText
        push byte 32h
        mov ecx, 1AAh
        mov ebx, 58h
        mov eax, dword [RosterPanelBitmap]
        push dword 8Ch
        mov edx, 14h
        mov eax, dword [byte eax+02Ch]
        call DrawShadowBox
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 0F5h
        call GetLangText
        push eax
        push dword 1B4h
        push byte 64h
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        push dword 0C0FFC0h
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 0F6h
        call GetLangText
        push eax
        push dword 1C6h
        push byte 64h
        push byte 0
        mov ebx, 8Ch
        call DrawTextAligned
        mov ecx, 36h
        add esp, byte 10h
        mov edx, 1AAh
        mov eax, 58h
        call DrawFrameBox
        push byte 32h
        mov ecx, 1AAh
        mov ebx, 1A2h
        mov eax, dword [RosterPanelBitmap]
        push dword 8Ch
        mov edx, 14h
        mov eax, dword [byte eax+02Ch]
        call DrawShadowBox
        push dword 0FFFF80h
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 0CAh
        call GetLangText
        push eax
        push dword 1B4h
        push dword 1AEh
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        push dword 0FF8080h
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 0C9h
        call GetLangText
        push eax
        push dword 1C6h
        push dword 1AEh
        push byte 0
        mov ebx, 8Ch
        call DrawTextAligned
        mov ecx, 36h
        add esp, byte 10h
        mov edx, 1AAh
        mov eax, 1A2h
        call DrawFrameBox
        call SetHighlightText
        mov eax, dword [RosterTitleY]
        mov esi, dword [str_X_ShowRosterLogo]
        mov ebx, dword [RosterTitleWidth]
        mov edi, dword [RosterTitleRight]
        sub esi, byte 6
        sub edi, dword [str_X_ShowRosterLogo]
        sub ebx, eax
        mov ecx, edi
        mov edx, esi
        call DrawFrameBox
        mov eax, dword [str_Punct_DrawRosterList]
        mov ebx, dword [RosterTitleX]
        sub eax, byte 6
        add ebx, 0B4h
        mov ecx, edi
        sub ebx, eax
        mov edx, esi
        add ebx, byte 6
        call DrawFrameBox
        jmp near DrawRatingBars_158
;-----------------------------------------------------------------------------
; CreateRosterPanel                               C9A45  97 PC, low confidence
; Creates the roster panel bitmap
;-----------------------------------------------------------------------------
CreateRosterPanel:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, 0DCh
        push dword [RosterPanelBitmap]
        mov esi, 0B4h
        call SetDrawTarget
        xor ebx, ebx
        add esp, byte 4
.1:
        push byte 0
        push edi
        push esi
        call CreateBitmap
        add esp, byte 0Ch
        push dword [nosplit ebx*8+str_X_DrawRosterList]
        push dword [nosplit ebx*8+str_Punct_DrawRosterList]
        mov dword [nosplit ebx*4+RosterPanelLayers], eax
        push dword [byte eax+02Ch]
        inc ebx
        call ConvertArtXY
        add esp, byte 0Ch
        cmp ebx, byte 2
        jl short .1
        mov edi, dword [RosterTitleRight]
        push byte 0
        sub edi, dword [str_X_ShowRosterLogo]
        mov esi, dword [RosterTitleWidth]
        push edi
        sub esi, dword [RosterTitleY]
        push esi
        call CreateBitmap
        add esp, byte 0Ch
        push dword [str_X_ShowRosterLogo]
        push dword [RosterTitleY]
        mov dword [RosterLogoBitmap], eax
        push dword [byte eax+02Ch]
        call ConvertArtXY
        add esp, byte 0Ch
        push dword [RosterLogoBitmap]
        call SetDrawTarget
        add esp, byte 4
        call DrawRosterPanel
        jmp near DrawRatingBars_158
;-----------------------------------------------------------------------------
; FreeRosterPanel                                 C9AEE  97 PC, low confidence
; Frees the roster panel bitmap
;-----------------------------------------------------------------------------
FreeRosterPanel:
        push ebx
        push ecx
        push edx
        xor ebx, ebx
.1:
        mov eax, ebx
        shl eax, 2
        cmp dword [dword eax+RosterPanelLayers], byte 0
        je short .2
        push dword [dword eax+RosterPanelLayers]
        call FreeBitmap
        add esp, byte 4
.2:
        inc ebx
        mov dword [nosplit ebx*4+RosterPanelShape], 0
        cmp ebx, byte 3
        jl short .1
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; InitRosterScreen                                C9B24  97 PC, low confidence
; From RosterScreen: loads the roster screen art (LoadDataFile 1Ch; BACK,
; TITL) and draws its panels
;-----------------------------------------------------------------------------
InitRosterScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 8, 0
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 1Dh
        call LoadDataFile
        mov dword [RosterShapeFile], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 1Ch
        call LoadDataFile
        push str_BACK11
        push eax
        mov dword [RosterBackFile], eax
        call FindShape
        add esp, byte 8
        push str_TITL11
        mov esi, eax
        mov dword [byte ebp-04h], eax
        push dword [RosterShapeFile]
        mov dword [RosterPanelShape], eax
        call FindShape
        add esp, byte 8
        push byte 0
        push dword 1E0h
        push dword 280h
        mov ebx, eax
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [RosterPanelBitmap], eax
        call SetDrawTarget
        add esp, byte 4
        push esi
        call BlitShape
        add esp, byte 4
        push ebx
        call BlitShape
        add esp, byte 4
        call ShowRosterLogo
        mov eax, dword [RosterPanelBitmap]
        mov eax, dword [byte eax+02Ch]
        mov esi, ScreenTitleItem
        mov ebx, eax
        mov edx, eax
        mov ecx, 52h
        call DrawScreenBackground
        mov edi, dword [RosterRow]
        rep movsb
        mov eax, dword [RosterRow]
        mov dword [eax], 0
        mov esi, dword [RosterRow]
        mov ecx, 52h
        lea edi, [byte esi+052h]
        mov esi, BlankMenuItem
        rep movsb
        mov eax, dword [RosterRow]
        mov dword [byte eax+052h], 1
        mov esi, dword [RosterRow]
        mov ecx, 52h
        lea edi, [dword esi+0A4h]
        mov esi, ScreenFrameItem
        rep movsb
        mov eax, dword [RosterRow]
        mov dword [dword eax+0A4h], 2
        push dword [RosterPanelBitmap]
        call SetDrawTarget
        add esp, byte 4
        call DrawRosterTitle
        call CreateRosterPanel
        push dword [RosterPanelBitmap]
        call SetDrawTarget
        add esp, byte 4
        mov dword [byte ebp-08h], 0DCh
        xor edi, edi
        call LoadRosterArt
        call SetupRosterLists
.1:
        lea eax, [edi+edi*2]
        lea edx, [byte eax+0Eh]
        imul eax, dword [nosplit edi*4+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        movsx ebx, word [byte ebx+eax+074h]
        imul eax, edx, byte 52h
        push byte 0
        push byte 0
        push dword [byte ebp-08h]
        push dword [nosplit edi*8+str_X_InitRosterScreen]
        push dword [nosplit edi*8+str_Punct_InitRosterScreen]
        push dword [byte ebp-04h]
        mov ecx, 0Ah
        push byte 0
        mov edx, dword [RosterRow]
        inc ebx
        add edx, eax
        mov eax, dword [nosplit edi*4+RosterListBox]
        call InitScrollList
        imul edx, dword [nosplit edi*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        mov ebx, dword [RosterPanelBitmap]
        movsx edx, word [byte edx+eax+072h]
        mov eax, dword [nosplit edi*4+RosterListBox]
        call SetScrollBarPos
        mov edx, dword [RosterPanelBitmap]
        mov eax, dword [nosplit edi*4+RosterListBox]
        inc edi
        call DrawScrollBar
        cmp edi, byte 2
        jl near .1
        push dword [RosterPanelBitmap]
        call SetDrawTarget
        add esp, byte 4
        call SetRosterArrows
        xor edx, edx
        xor eax, eax
        call DrawRosterList
        mov eax, 1
        xor edx, edx
        call DrawRosterList
        xor eax, eax
        xor edi, edi
        call DrawRosterDetails
.2:
        imul esi, edi, byte 52h
        mov eax, dword [RosterRow]
        add esi, eax
        cmp dword [byte esi+01Ah], byte 0
        je short .3
        push dword [byte esi+02Ah]
        push dword [byte esi+026h]
        push dword [byte esi+01Ah]
        call DrawArt
        add esp, byte 0Ch
.3:
        inc edi
        cmp edi, byte 14h
        jl short .2
        mov eax, 1
        mov dword [RosterScreenReady], 0
        jmp near DrawRatingBars_157
;-----------------------------------------------------------------------------
; FreeRosterScreen                                C9D84  97 PC, low confidence
; From RosterScreen: frees the roster screen art once (RosterScreenReady guard)
;-----------------------------------------------------------------------------
FreeRosterScreen:
        push ecx
        push edx
        cmp dword [RosterScreenReady], byte 0
        jne short .2
        xor edx, edx
.1:
        mov eax, dword [nosplit edx*4+RosterListBox]
        inc edx
        call FreeScrollList
        cmp edx, byte 2
        jl short .1
        call FreeRosterPanel
        push dword [RosterPanelBitmap]
        call FreeBitmap
        add esp, byte 4
        push dword [RosterShapeFile]
        call FreeMemBlock
        add esp, byte 4
        push dword [RosterBackFile]
        call FreeMemBlock
        mov dword [RosterScreenReady], 1
        add esp, byte 4
.2:
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; DrawRosterPanel                                 C9DDF  97 PC, low confidence
; Draws the roster panel
;-----------------------------------------------------------------------------
DrawRosterPanel:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 1Ch, 0
        push str_MTR2
        push dword [RosterBackFile]
        call FindShape
        add esp, byte 8
        push byte 10h
        push dword 0AFh
        push eax
        call BlitArt
        add esp, byte 0Ch
        push dword 0FF0000h
        call MakeColor
        add esp, byte 4
        push dword 0FF00h
        mov ebx, eax
        mov dword [byte ebp-08h], eax
        call MakeColor
        add esp, byte 4
        push ebx
        push byte 3
        mov edi, 6
        push edi
        push byte 14h
        push dword 0B4h
        mov dword [byte ebp-0Ch], eax
        call FillRect
        add esp, byte 14h
        push ebx
        push byte 3
        push edi
        mov dword [byte ebp-04h], 0B4h
        push dword 0D1h
        mov dword [byte ebp-010h], 14h
        mov dword [byte ebp-014h], 60h
        push dword 0B4h
        mov esi, 30h
        xor ebx, ebx
        jmp short .2
.1:
        mov eax, dword [byte ebp-08h]
        imul eax, ebx
        cdq
        idiv esi
        mov edx, dword [byte ebp-0Ch]
        and eax, dword [byte ebp-08h]
        or edx, eax
        push edx
        mov eax, dword [byte ebp-010h]
        push byte 1
        add eax, dword [byte ebp-014h]
        push edi
        mov dword [byte ebp-018h], eax
        add eax, ebx
        push eax
        push dword [byte ebp-04h]
        mov dword [byte ebp-01Ch], edx
        call FillRect
        add esp, byte 14h
        push dword [byte ebp-01Ch]
        mov eax, dword [byte ebp-018h]
        push byte 1
        sub eax, ebx
        push edi
        dec eax
        push eax
        push dword [byte ebp-04h]
        inc ebx
.2:
        call FillRect
        add esp, byte 14h
        cmp ebx, esi
        jl short .1
        xor ebx, ebx
        jmp short .4
.3:
        mov eax, esi
        sub eax, ebx
        imul eax, dword [byte ebp-0Ch]
        cdq
        idiv esi
        mov edx, dword [byte ebp-08h]
        and eax, dword [byte ebp-0Ch]
        or edx, eax
        mov eax, dword [byte ebp-010h]
        push edx
        add eax, dword [byte ebp-014h]
        push byte 1
        mov dword [byte ebp-018h], eax
        add eax, ebx
        push edi
        add eax, esi
        push eax
        push dword [byte ebp-04h]
        mov dword [byte ebp-01Ch], edx
        call FillRect
        add esp, byte 14h
        mov eax, dword [byte ebp-018h]
        push dword [byte ebp-01Ch]
        sub eax, ebx
        push byte 1
        dec eax
        push edi
        sub eax, esi
        push eax
        push dword [byte ebp-04h]
        inc ebx
        call FillRect
        add esp, byte 14h
.4:
        cmp ebx, esi
        jl short .3
        jmp near DrawRatingBars_157
;-----------------------------------------------------------------------------
; SetupRosterLists                                C9F18  97 PC, low confidence
; Sets up the roster list boxes
;-----------------------------------------------------------------------------
SetupRosterLists:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 0Ch, 0
        push RosterSpeechHome
        push str_TR00TR01TR02TR03
        push dword [RosterShapeFile]
        call FindShapeList
        add esp, byte 0Ch
        push RosterSpeechAway
        push str_DF00DF01DF02DF03
        push dword [RosterShapeFile]
        call FindShapeList
        add esp, byte 0Ch
        push RosterSpeechTrade
        push str_CM00CM01CM02CM03
        push dword [RosterShapeFile]
        mov ebx, str_TR00
        call FindShapeList
        add esp, byte 0Ch
        mov ecx, str_TR01
        mov edx, dword [RosterRow]
        push str_TR00
        mov eax, dword [RosterShapeFile]
        add edx, 0F6h
        call InitShapeListBox
        push str_DF002
        mov ecx, str_DF002
        mov edx, dword [RosterRow]
        mov eax, dword [RosterShapeFile]
        add edx, 148h
        mov ebx, ecx
        call InitShapeListBox
        push str_CM002
        mov ecx, str_CM012
        mov ebx, str_CM002
        mov edx, dword [RosterRow]
        mov eax, dword [RosterShapeFile]
        add edx, 19Ah
        xor esi, esi
        call InitShapeListBox
.1:
        mov eax, esi
        call SetRosterButtons
        mov edx, eax
        lea eax, [byte esi+06h]
        imul eax, byte 52h
        test edx, edx
        jne short .2
        push str_GB00
        mov ecx, str_GB00
        mov edx, dword [RosterRow]
        mov ebx, ecx
        jmp short .3
.2:
        push str_LD002
        mov ecx, str_LD002
        mov edx, dword [RosterRow]
        mov ebx, str_LB004
.3:
        add edx, eax
        mov eax, dword [RosterShapeFile]
        call InitShapeListBox
        inc esi
        cmp esi, byte 2
        jl short .1
        mov eax, dword [RosterRow]
        mov esi, dword [dword eax+0206h]
        mov ebx, 178h
        movsx edx, word [byte esi+06h]
        add eax, 1ECh
        push edx
        movsx ecx, word [byte esi+04h]
        mov edx, 37h
        call InitListBox
        mov eax, dword [RosterRow]
        mov esi, dword [dword eax+0258h]
        mov ebx, 178h
        add eax, 23Eh
        movsx edx, word [byte esi+06h]
        movsx ecx, word [byte esi+04h]
        push edx
        mov edx, 1C2h
        xor esi, esi
        call InitListBox
.4:
        mov eax, dword [nosplit esi*4+RosterTeam]
        mov edx, dword [RosterScrollArea]
        shl eax, 2
        add edx, eax
        lea eax, [byte esi+08h]
        imul eax, byte 52h
        mov ebx, dword [RosterRow]
        mov edx, dword [edx]
        mov dword [byte ebx+eax+01Ah], edx
        mov ebx, dword [RosterListArea]
        mov edx, dword [nosplit esi*4+RosterTeam]
        mov edi, dword [RosterRow]
        mov edx, dword [ebx+edx*4]
        mov dword [byte edi+eax+01Eh], edx
        mov ebx, edx
        mov edx, dword [RosterRow]
        mov dword [byte edx+eax+022h], ebx
        mov edx, dword [RosterRow]
        add eax, edx
        mov edi, dword [byte eax+01Ah]
        mov ebx, dword [nosplit esi*8+str_I_SetupRosterLists]
        movsx edx, word [byte edi+06h]
        movsx ecx, word [byte edi+04h]
        push edx
        mov edx, dword [nosplit esi*8+str_7_SetupRosterLists]
        inc esi
        call InitListBox
        cmp esi, byte 2
        jl short .4
        push str_ATL2
        mov ecx, str_ATL1
        mov ebx, str_ATL0
        mov edx, dword [RosterRow]
        mov eax, dword [RosterBackFile]
        add edx, 334h
        call InitShapeListBox
        push str_ATL5
        mov ecx, str_ATL4
        mov ebx, str_ATL3
        mov edx, dword [RosterRow]
        mov eax, dword [RosterBackFile]
        add edx, 386h
        mov dword [byte ebp-0Ch], 0B4h
        call InitShapeListBox
        push str_ATR2
        mov ecx, str_ATR1
        mov ebx, str_ATR0
        mov edx, dword [RosterRow]
        mov eax, dword [RosterBackFile]
        add edx, 3D8h
        mov dword [byte ebp-04h], 16h
        call InitShapeListBox
        push str_ATR5
        mov ecx, str_ATR4
        mov ebx, str_ATR3
        mov edx, dword [RosterRow]
        mov eax, dword [RosterBackFile]
        add edx, 42Ah
        mov esi, 14h
        call InitShapeListBox
        mov eax, dword [str_Punct_DrawRosterList]
        mov edi, dword [str_X_DrawRosterList]
        mov dword [byte ebp-08h], eax
.5:
        imul edx, esi, byte 52h
        push dword [byte ebp-04h]
        mov ecx, dword [byte ebp-0Ch]
        mov eax, dword [RosterRow]
        mov ebx, edi
        add edi, dword [byte ebp-04h]
        add eax, edx
        mov edx, dword [byte ebp-08h]
        inc esi
        call InitListBox
        cmp esi, byte 1Eh
        jl short .5
        mov esi, 1Eh
        mov eax, dword [RosterTitleX]
        mov edi, dword [str_X_SetupRosterLists]
        mov dword [byte ebp-08h], eax
.6:
        imul edx, esi, byte 52h
        push dword [byte ebp-04h]
        mov ecx, dword [byte ebp-0Ch]
        mov eax, dword [RosterRow]
        mov ebx, edi
        add edi, dword [byte ebp-04h]
        add eax, edx
        mov edx, dword [byte ebp-08h]
        inc esi
        call InitListBox
        cmp esi, byte 28h
        jl short .6
        mov eax, 1
        jmp near DrawRatingBars_157
;-----------------------------------------------------------------------------
; LoadRosterArt                                   CA206  97 PC, low confidence
; Loads the roster screen art
;-----------------------------------------------------------------------------
LoadRosterArt:
        push ebx
        push ecx
        push edx
        push esi
        enter 8, 0
        xor ebx, ebx
        jmp near .5
.1:
        cmp dword [RosterScrollList], byte 1Ah
        jge short .2
        mov eax, dword [nosplit ebx*4+PlayoffTeams]
        jmp short .3
.2:
        mov eax, ebx
.3:
        cmp eax, byte 14h
        jl short .4
        cmp eax, byte 15h
        jg short .4
        mov edx, 29h
        sub edx, eax
        mov eax, edx
.4:
        add eax, byte 5
        push eax
        push str_LB02d5
        lea eax, [byte ebp-08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-08h]
        push eax
        push dword [RosterBackFile]
        mov esi, ebx
        call FindShape
        mov edx, eax
        mov eax, dword [RosterScrollArea]
        add esp, byte 8
        mov dword [eax+esi*4], edx
        lea eax, [byte ebp-08h]
        push eax
        push dword [RosterBackFile]
        mov byte [byte ebp-07h], 44h
        call FindShape
        mov edx, eax
        mov eax, dword [RosterListArea]
        inc ebx
        add esp, byte 8
        mov dword [eax+esi*4], edx
.5:
        cmp ebx, dword [RosterScrollList]
        jl near .1
        mov eax, 1
        leave
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SetRosterButtons                                CA2A7  97 PC, low confidence
; Sets up the roster buttons
;-----------------------------------------------------------------------------
SetRosterButtons:
        push ebx
        push ecx
        push edx
        imul eax, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        xor ebx, ebx
        test byte [byte edx+eax+06Ah], 8
        je short .1
        push str_LB04
        push dword [RosterShapeFile]
        call FindShape
        add esp, byte 8
        mov edx, eax
        mov eax, dword [RosterMenuArea]
        push str_LD04
        mov dword [eax], edx
        push dword [RosterShapeFile]
        call FindShape
        add esp, byte 8
        mov edx, eax
        mov eax, dword [RosterMenuItems]
        push str_LB02
        mov dword [eax], edx
        push dword [RosterShapeFile]
        call FindShape
        add esp, byte 8
        mov edx, eax
        mov eax, dword [RosterMenuArea]
        push str_LD02
        mov dword [byte eax+08h], edx
        push dword [RosterShapeFile]
        call FindShape
        mov edx, eax
        mov eax, dword [RosterMenuItems]
        mov ebx, 1
        jmp short .2
.1:
        push str_GB04
        push dword [RosterShapeFile]
        call FindShape
        mov edx, eax
        mov eax, dword [RosterMenuItems]
        mov dword [eax], edx
        add esp, byte 8
        mov eax, dword [RosterMenuArea]
        push str_GB02
        mov dword [eax], edx
        push dword [RosterShapeFile]
        call FindShape
        mov edx, eax
        mov eax, dword [RosterMenuItems]
        mov dword [byte eax+08h], edx
        mov eax, dword [RosterMenuArea]
.2:
        add esp, byte 8
        mov dword [byte eax+08h], edx
        cmp dword [RosterMode], byte 0
        jne short .3
        push str_LB03
        push dword [RosterShapeFile]
        call FindShape
        add esp, byte 8
        mov edx, eax
        mov eax, dword [RosterMenuArea]
        push str_LD03
        mov dword [byte eax+04h], edx
        push dword [RosterShapeFile]
        call FindShape
        add esp, byte 8
        mov edx, eax
        mov eax, dword [RosterMenuItems]
        push str_LB01
        mov dword [byte eax+04h], edx
        push dword [RosterShapeFile]
        call FindShape
        add esp, byte 8
        mov edx, eax
        mov eax, dword [RosterMenuArea]
        push str_LD01
        mov dword [byte eax+0Ch], edx
        push dword [RosterShapeFile]
        call FindShape
        mov edx, eax
        mov eax, dword [RosterMenuItems]
        mov ebx, 1
        jmp short .4
.3:
        push str_GB03
        push dword [RosterShapeFile]
        call FindShape
        mov edx, eax
        mov eax, dword [RosterMenuItems]
        mov dword [byte eax+04h], edx
        add esp, byte 8
        mov eax, dword [RosterMenuArea]
        push str_GB01
        mov dword [byte eax+04h], edx
        push dword [RosterShapeFile]
        call FindShape
        mov edx, eax
        mov eax, dword [RosterMenuItems]
        mov dword [byte eax+0Ch], edx
        mov eax, dword [RosterMenuArea]
.4:
        add esp, byte 8
        mov dword [byte eax+0Ch], edx
        jmp near FreeRosterInfoAnim_4A
;-----------------------------------------------------------------------------
; InitListBox                                     CA44C  97 PC, low confidence
; Sets up a list box
;-----------------------------------------------------------------------------
InitListBox:
        push esi
        push ebp
        mov ebp, esp
        mov esi, ecx
        mov dword [byte eax+010h], 4
        mov dword [byte eax+02Ah], ebx
        mov ecx, dword [byte eax+014h]
        mov dword [byte eax+026h], edx
        mov dword [ecx], edx
        mov ecx, dword [byte eax+014h]
        mov dword [byte ecx+04h], ebx
        mov ecx, dword [byte eax+014h]
        add esi, edx
        mov dword [byte ecx+08h], esi
        mov ecx, dword [byte eax+014h]
        mov dword [byte ecx+0Ch], ebx
        mov ecx, dword [byte eax+014h]
        mov dword [byte ecx+010h], esi
        mov ecx, dword [byte ebp+0Ch]
        add ecx, ebx
        mov ebx, dword [byte eax+014h]
        mov dword [byte ebx+014h], ecx
        mov ebx, dword [byte eax+014h]
        mov dword [byte ebx+018h], edx
        mov eax, dword [byte eax+014h]
        mov dword [byte eax+01Ch], ecx
        pop ebp
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; DrawPlayerCard                                  CA49A  97 PC, low confidence
; Draws the player card
;-----------------------------------------------------------------------------
DrawPlayerCard:
        push ebx
        push ecx
        push esi
        push edi
        enter 24h, 0
        push eax
        mov esi, edx
        imul edx, dword [nosplit edx*4+RosterTeam], dword 32C6h
        mov dword [byte ebp-014h], 0FFFFFFFFh
        mov dword [byte ebp-010h], 16h
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [RosterTeams]
        mov dword [byte ebp-020h], 1
        xor ebx, ebx
        movsx eax, word [byte edx+eax+072h]
        xor edi, edi
        add dword [byte ebp-028h], eax
        jmp short .3
.1:
        movzx eax, byte [byte edi+eax+06Eh]
        cmp eax, dword [byte ebp-028h]
        jne short .2
        inc ebx
        jmp short .4
.2:
        inc edi
.3:
        imul eax, dword [nosplit esi*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        movzx edx, byte [byte eax+071h]
        cmp edi, edx
        jl short .1
.4:
        test ebx, ebx
        jne short .6
        jmp short .7
.5:
        mov dl, byte [byte eax+06Fh]
        inc edi
        mov byte [byte eax+06Eh], dl
.6:
        mov edx, esi
        shl edx, 2
        imul eax, dword [dword edx+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add eax, ecx
        movzx ecx, byte [byte eax+071h]
        dec ecx
        add eax, edi
        cmp edi, ecx
        jl short .5
        mov byte [byte eax+06Eh], 0
        imul eax, dword [dword edx+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        dec byte [byte edx+eax+071h]
        jmp short .9
.7:
        mov edx, esi
        shl edx, 2
        imul eax, dword [dword edx+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add eax, ecx
        cmp byte [byte eax+071h], 3
        jae short .8
        inc byte [byte eax+071h]
        imul eax, dword [dword edx+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        add edi, eax
        mov al, byte [byte ebp-028h]
        mov byte [byte edi+06Eh], al
        jmp short .9
.8:
        movzx edx, byte [byte eax+070h]
        mov dword [byte ebp-014h], edx
        mov dl, byte [byte ebp-028h]
        mov byte [byte eax+070h], dl
.9:
        mov eax, dword [byte ebp-0Ch]
        add eax, byte 14h
        mov dword [byte ebp-04h], eax
        cmp esi, byte 1
        jne short .10
        add dword [byte ebp-04h], byte 0Ah
.10:
        imul edi, dword [byte ebp-04h], byte 52h
        mov eax, dword [RosterRow]
        add edi, eax
        mov eax, dword [byte edi+026h]
        push dword [RosterPanelBitmap]
        mov dword [byte ebp-08h], eax
        mov edi, dword [byte edi+02Ah]
        call SetDrawTarget
        mov eax, dword [byte ebp-010h]
        add esp, byte 4
        add eax, edi
        push eax
        mov eax, dword [byte ebp-08h]
        push edi
        add eax, 0B4h
        push eax
        push dword [byte ebp-08h]
        call SetClipWindow
        add esp, byte 10h
        mov eax, dword [nosplit esi*4+RosterPanelLayers]
        push dword [byte eax+02Ch]
        call BlitShape
        add esp, byte 4
        test ebx, ebx
        jne short .11
        push dword [byte ebp-010h]
        push dword 0B4h
        push edi
        push dword 0FF0000AAh
        mov ebx, 10h
        call MakeColor
        mov edx, eax
        mov eax, dword [RosterPanelBitmap]
        add esp, byte 4
        mov ecx, dword [byte ebp-08h]
        mov eax, dword [byte eax+02Ch]
        call DrawHighlightBar
.11:
        push byte 0
        mov eax, dword [byte ebp-08h]
        mov edx, dword [byte ebp-028h]
        add eax, byte 8
        lea ecx, [byte edi+06h]
        mov dword [byte ebp-01Ch], eax
        mov ebx, eax
        mov eax, esi
        call DrawPlayerCardText
        call SetScreenTarget
        mov eax, dword [byte ebp-010h]
        add eax, edi
        push eax
        mov eax, dword [byte ebp-08h]
        push edi
        add eax, 0B4h
        push eax
        push dword [byte ebp-08h]
        mov dword [byte ebp-018h], eax
        call SetClipWindow
        add esp, byte 10h
        push byte 0
        mov eax, dword [RosterPanelBitmap]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        cmp dword [byte ebp-014h], byte 0
        jl near .12
        mov ebx, esi
        shl ebx, 2
        imul edx, dword [dword ebx+RosterTeam], dword 32C6h
        mov eax, dword [byte ebp-0Ch]
        sub dword [byte ebp-04h], eax
        mov eax, dword [RosterTeams]
        movsx eax, word [byte edx+eax+072h]
        mov edx, dword [byte ebp-014h]
        sub edx, eax
        mov dword [byte ebp-0Ch], edx
        test edx, edx
        jl near .12
        cmp edx, byte 0Ah
        jge near .12
        add dword [byte ebp-04h], edx
        imul eax, dword [byte ebp-04h], byte 52h
        mov edi, dword [RosterRow]
        push dword [RosterPanelBitmap]
        mov edi, dword [byte edi+eax+02Ah]
        call SetDrawTarget
        mov eax, dword [byte ebp-010h]
        add esp, byte 4
        add eax, edi
        push eax
        push edi
        push dword [byte ebp-018h]
        push dword [byte ebp-08h]
        mov dword [byte ebp-024h], eax
        call SetClipWindow
        add esp, byte 10h
        mov eax, dword [dword ebx+RosterPanelLayers]
        push dword [byte eax+02Ch]
        call BlitShape
        add esp, byte 4
        mov ebx, dword [byte ebp-01Ch]
        mov edx, dword [byte ebp-014h]
        push byte 0
        lea ecx, [byte edi+06h]
        mov eax, esi
        call DrawPlayerCardText
        call SetScreenTarget
        push dword [byte ebp-024h]
        push edi
        push dword [byte ebp-018h]
        push dword [byte ebp-08h]
        call SetClipWindow
        add esp, byte 10h
        push byte 0
        mov eax, dword [RosterPanelBitmap]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
.12:
        call ResetClipWindow
        mov eax, dword [byte ebp-020h]
DrawPlayerCard_2B8:
        leave
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawPlayerCardText                              CA758  97 PC, low confidence
; Draws the text of the player card
;-----------------------------------------------------------------------------
DrawPlayerCardText:
        push esi
        push edi
        enter 88h, 0
        sub ebp, byte 7Eh
        mov esi, eax
        mov dword [byte ebp+07Ah], ebx
        mov dword [byte ebp+076h], ecx
        mov eax, edx
        mov ebx, esi
        shl ebx, 2
        imul ecx, dword [dword ebx+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add ecx, edx
        mov edx, dword [ecx]
        movsx esi, word [dword edx+0D05h]
        cmp eax, esi
        jge near .5
        imul esi, eax, dword 0BCh
        lea edi, [dword ecx+08FEh]
        add edi, esi
        add edi, byte 8
        push edi
        movzx ecx, byte [dword ecx+esi+0916h]
        push ecx
        imul ecx, eax, byte 38h
        movzx eax, byte [dword ecx+edx+0D0Ah]
        push eax
        movzx eax, byte [dword ecx+edx+0D0Bh]
        call PositionAbbrev
        movzx eax, al
        push eax
        push str_CDCS2
        lea eax, [byte ebp-0Ah]
        push eax
        call sprintf_
        imul eax, dword [dword ebx+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        add eax, ecx
        add esp, byte 18h
        test byte [dword eax+0D09h], 4
        je short .2
.1:
        push dword 0FF8080h
        jmp near .8
.2:
        test byte [dword eax+0D09h], 1
        je short .4
.3:
        push dword 0FFFF80h
        jmp near .8
.4:
        push byte 0FFFFFFFFh
        jmp near .8
.5:
        sub eax, esi
        movsx esi, word [dword edx+01281h]
        cmp eax, esi
        jge short .6
        imul esi, eax, dword 0BCh
        lea edi, [dword ecx+01B5Ah]
        add edi, esi
        add edi, byte 8
        push edi
        movzx ecx, byte [dword ecx+esi+01B72h]
        push ecx
        imul ecx, eax, byte 38h
        movzx eax, byte [dword ecx+edx+01284h]
        push eax
        movzx eax, byte [dword ecx+edx+01285h]
        call PositionAbbrev
        movzx eax, al
        push eax
        push str_CDCS2
        lea eax, [byte ebp-0Ah]
        push eax
        call sprintf_
        imul eax, dword [dword ebx+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        add eax, ecx
        add esp, byte 18h
        test byte [dword eax+01283h], 4
        jne near .1
        test byte [dword eax+01283h], 1
        jne near .3
        jmp near .4
.6:
        sub eax, esi
        movsx esi, word [dword edx+0132Bh]
        cmp eax, esi
        jge near .7
        imul esi, eax, dword 0BCh
        lea edi, [dword ecx+01D8Eh]
        add edi, esi
        add edi, byte 8
        push edi
        movzx ecx, byte [dword ecx+esi+01DA6h]
        push ecx
        imul ecx, eax, byte 38h
        movzx eax, byte [dword ecx+edx+0132Eh]
        push eax
        movzx eax, byte [dword ecx+edx+0132Fh]
        call PositionAbbrev
        movzx eax, al
        push eax
        push str_CDCS2
        lea eax, [byte ebp-0Ah]
        push eax
        call sprintf_
        imul eax, dword [dword ebx+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        add eax, ecx
        add esp, byte 18h
        test byte [dword eax+0132Dh], 4
        jne near .1
        test byte [dword eax+0132Dh], 1
        jne near .3
        push dword 0C0FFC0h
        jmp near .8
.7:
        sub eax, esi
        movsx esi, word [dword edx+018A5h]
        cmp eax, esi
        jge near .9
        imul esi, eax, dword 0BCh
        lea edi, [dword ecx+02FEAh]
        add edi, esi
        add edi, byte 8
        push edi
        movzx ecx, byte [dword ecx+esi+03002h]
        push ecx
        imul ecx, eax, byte 38h
        movzx eax, byte [dword ecx+edx+018A8h]
        push eax
        movzx eax, byte [dword ecx+edx+018A9h]
        call PositionAbbrev
        movzx eax, al
        push eax
        push str_CDCS2
        lea eax, [byte ebp-0Ah]
        push eax
        call sprintf_
        imul edx, dword [dword ebx+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [edx+eax]
        add eax, ecx
        add esp, byte 18h
        test byte [dword eax+018A7h], 4
        jne near .1
        test byte [dword eax+018A7h], 1
        jne near .3
        push dword 0C0FFC0h
.8:
        call MakeColor
        add esp, byte 4
        call SetTextColor
.9:
        call SetHighlightText
        lea eax, [byte ebp-0Ah]
        push eax
        push dword [byte ebp+076h]
        push dword [byte ebp+07Ah]
        push dword [dword ebp+08Eh]
        call DrawTextAligned
        add esp, byte 10h
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        call SetNormalText
        lea esp, [byte ebp+07Eh]
        pop ebp
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; DrawRosterDetails                               CAA0F  97 PC, low confidence
; Draws the details of the selected player
;-----------------------------------------------------------------------------
DrawRosterDetails:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 14h, 0
        push eax
        push dword [RosterPanelBitmap]
        call SetDrawTarget
        mov eax, dword [RosterLogoBitmap]
        add esp, byte 4
        push dword [byte eax+02Ch]
        call BlitShape
        add esp, byte 4
        cmp dword [RosterTradeOn], byte 0
        je near .4
        mov dword [byte ebp-014h], 0
        mov dword [byte ebp-010h], 0
        xor edi, edi
.1:
        xor esi, esi
        jmp short .3
.2:
        movzx edx, byte [byte esi+eax+06Eh]
        mov eax, edi
        inc esi
        call GetPlayerStatLine
        add dword [byte ebx+ebp-014h], eax
.3:
        mov ebx, edi
        shl ebx, 2
        imul edx, dword [dword ebx+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        add eax, edx
        movzx edx, byte [byte eax+071h]
        cmp esi, edx
        jl short .2
        inc edi
        cmp edi, byte 2
        jl short .1
        mov ebx, dword [RosterLogoBitmap]
        mov ebx, dword [byte ebx+02Ch]
        movsx eax, word [byte ebx+0Ch]
        add eax, 0B4h
        mov dword [byte ebp-08h], eax
        mov eax, dword [byte ebp-010h]
        sub eax, dword [byte ebp-014h]
        imul eax, byte 60h
        mov esi, 87h
        cdq
        idiv esi
        mov dword [byte ebp-0Ch], eax
        movsx eax, word [byte ebx+0Eh]
        mov ebx, dword [byte ebp-0Ch]
        add eax, byte 14h
        push dword 0FF000000h
        add ebx, eax
        call MakeColor
        add esp, byte 4
        push eax
        push byte 4
        push byte 6
        add ebx, byte 5Eh
        push ebx
        push dword [byte ebp-08h]
        call FillRect
        add esp, byte 14h
.4:
        mov dword [byte ebp-0Ch], 16h
        mov dword [byte ebp-08h], 136h
        xor esi, esi
.5:
        test esi, esi
        jne short .6
        mov eax, dword [str_X_ShowRosterLogo]
        add eax, byte 0Ah
        mov dword [byte ebp-04h], eax
        jmp short .7
.6:
        mov eax, dword [RosterLogoBitmap]
        mov eax, dword [byte eax+04h]
        sar eax, 1
        imul eax, esi
        mov edx, dword [str_X_ShowRosterLogo]
        add edx, eax
        mov dword [byte ebp-04h], edx
.7:
        push dword 0FFFFFF50h
        call MakeColor
        add esp, byte 4
        call SetTextColor
        imul edx, dword [nosplit esi*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        add eax, edx
        add eax, byte 42h
        push eax
        push dword [byte ebp-04h]
        push dword [byte ebp-08h]
        push byte 1
        xor edi, edi
        call DrawTextAligned
        mov eax, dword [byte ebp-0Ch]
        add esp, byte 10h
        jmp short .9
.8:
        push byte 1
        mov ecx, dword [byte ebp-04h]
        mov ebx, dword [byte ebp-08h]
        movzx edx, byte [byte edi+eax+06Eh]
        mov eax, esi
        call DrawPlayerCardText
        mov eax, dword [byte ebp-0Ch]
        inc edi
.9:
        add dword [byte ebp-04h], eax
        imul eax, dword [nosplit esi*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        movzx edx, byte [byte eax+071h]
        cmp edi, edx
        jl short .8
        inc esi
        cmp esi, byte 2
        jl near .5
        cmp dword [byte ebp-018h], byte 0
        je near DrawRatingBars_157
        call SetScreenTarget
        mov eax, dword [RosterLogoBitmap]
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+04h]
        movsx edx, word [byte ebx+0Eh]
        add esi, edx
        push esi
        mov eax, dword [eax]
        push edx
        movsx edx, word [byte ebx+0Ch]
        add eax, edx
        push eax
        push edx
        call SetClipWindow
        add esp, byte 10h
        push byte 0
        mov eax, dword [RosterPanelBitmap]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call ResetClipWindow
        call PresentScreen
        jmp near DrawRatingBars_157
;-----------------------------------------------------------------------------
; SetRosterArrows                                 CABF2  97 PC, low confidence
; Sets up the roster scroll arrows
;-----------------------------------------------------------------------------
SetRosterArrows:
        push ecx
        push edx
        imul eax, dword [RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        cmp byte [byte edx+eax+071h], 0
        jbe short .1
        imul eax, dword [RosterOtherTeam], dword 32C6h
        cmp byte [byte edx+eax+071h], 0
        jbe short .1
        mov dword [RosterTradeOn], 1
        jmp short .2
.1:
        mov dword [RosterTradeOn], 0
.2:
        cmp dword [RosterChanged], byte 0
        je short .3
        cmp dword [RosterTradeOn], byte 0
        je short .3
        push str_TR00
        push dword [RosterShapeFile]
        call FindShape
        add esp, byte 8
        mov edx, eax
        mov eax, dword [RosterRow]
        push str_TR01
        mov dword [dword eax+0110h], edx
        push dword [RosterShapeFile]
        call FindShape
        add esp, byte 8
        mov edx, eax
        mov eax, dword [RosterRow]
        push str_TR01
        mov dword [dword eax+0114h], edx
        push dword [RosterShapeFile]
        call FindShape
        mov edx, eax
        mov eax, dword [RosterRow]
        add esp, byte 8
        mov dword [dword eax+0118h], edx
        pop edx
        pop ecx
        ret
.3:
        push str_TR04
        push dword [RosterShapeFile]
        call FindShape
        mov edx, eax
        mov eax, dword [RosterRow]
        mov dword [dword eax+0118h], edx
        mov eax, dword [RosterRow]
        mov dword [dword eax+0114h], edx
        mov eax, dword [RosterRow]
        add esp, byte 8
        mov dword [dword eax+0110h], edx
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; RedrawRosterScreen                              CACE0  97 PC, low confidence
; Redraws the whole roster screen
;-----------------------------------------------------------------------------
RedrawRosterScreen:
        push esi
        push edi
        enter 10h, 0
        mov esi, edx
        mov dword [byte ebp-04h], ecx
        cmp dword [byte ebp+014h], byte 0
        je short .2
        add eax, dword [byte ebp+014h]
        add eax, dword [RosterScrollList]
        cdq
        idiv dword [RosterScrollList]
        mov eax, edx
        cmp edx, dword [RosterTeam]
        je short .1
        cmp edx, dword [RosterOtherTeam]
        jne short .2
.1:
        add eax, dword [byte ebp+014h]
        add eax, dword [RosterScrollList]
        cdq
        idiv dword [RosterScrollList]
        mov eax, edx
.2:
        cmp eax, dword [RosterTeam]
        je near .12
        cmp eax, dword [RosterOtherTeam]
        je near .12
        test eax, eax
        jl near .12
        cmp eax, dword [RosterScrollList]
        jge near .12
        imul edi, ebx, byte 52h
        mov ecx, dword [RosterScrollArea]
        mov edx, eax
        mov dword [nosplit esi*4+RosterTeam], eax
        shl edx, 2
        mov eax, dword [RosterRow]
        mov ebx, dword [ecx+edx]
        mov dword [byte edi+eax+01Ah], ebx
        mov ecx, dword [RosterListArea]
        mov eax, dword [RosterRow]
        mov ebx, dword [ecx+edx]
        mov dword [byte edi+eax+01Eh], ebx
        mov eax, dword [RosterListArea]
        add edx, eax
        mov eax, dword [RosterRow]
        mov edx, dword [edx]
        xor ebx, ebx
        mov dword [byte edi+eax+022h], edx
        mov edx, dword [byte ebp-04h]
        mov eax, esi
        call LoadRosterData
        push dword [RosterPanelBitmap]
        call SetDrawTarget
        add esp, byte 4
        push dword [byte ebp+010h]
        call BlitShape
        add esp, byte 4
        call DrawRosterTitle
        call ShowRosterLogo
        push dword [RosterPanelBitmap]
        call SetDrawTarget
        mov eax, dword [RosterLogoBitmap]
        mov eax, dword [byte eax+02Ch]
        movsx edx, word [byte eax+0Eh]
        add esp, byte 4
        sub edx, byte 6
        movsx edi, word [byte eax+0Ch]
        mov dword [byte ebp-08h], edx
        mov ebx, edi
        mov ecx, dword [byte ebp-08h]
        movsx edx, word [byte eax+04h]
        movsx eax, word [byte eax+06h]
        mov dword [byte ebp-010h], edx
        push eax
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [RosterPanelBitmap]
        push edx
        mov edx, 14h
        mov eax, dword [byte eax+02Ch]
        call DrawShadowBox
        mov ecx, dword [byte ebp-0Ch]
        mov ebx, dword [byte ebp-010h]
        mov edx, dword [byte ebp-08h]
        mov eax, edi
        call DrawFrameBox
        mov eax, dword [RosterPanelLayers]
        mov eax, dword [byte eax+02Ch]
        movsx edi, word [byte eax+0Ch]
        mov eax, dword [RosterTitleShape]
        mov eax, dword [byte eax+02Ch]
        movsx edx, word [byte eax+0Ch]
        movsx eax, word [byte eax+04h]
        sub edi, byte 6
        add edx, eax
        sub edx, edi
        mov ecx, dword [byte ebp-0Ch]
        add edx, byte 6
        mov eax, edi
        mov dword [byte ebp-010h], edx
        mov ebx, edx
        mov edx, dword [byte ebp-08h]
        xor edi, edi
        call DrawFrameBox
.3:
        mov eax, dword [nosplit edi*4+RosterPanelLayers]
        mov eax, dword [byte eax+02Ch]
        movsx edx, word [byte eax+0Eh]
        push edx
        movsx edx, word [byte eax+0Ch]
        push edx
        push eax
        inc edi
        call ConvertArtXY
        add esp, byte 0Ch
        cmp edi, byte 3
        jl short .3
        push dword [RosterLogoBitmap]
        call SetDrawTarget
        add esp, byte 4
        call DrawRosterPanel
        push dword [RosterPanelBitmap]
        call SetDrawTarget
        add esp, byte 4
        mov eax, esi
        xor edx, edx
        call DrawRosterList
        cmp dword [byte ebp-04h], byte 0
        jne short .5
.4:
        mov dword [RosterChanged], 1
        jmp short .7
.5:
        cmp dword [byte ebp-04h], byte 1
        jne short .6
        imul ecx, dword [RosterTeam], byte 1Ch
        cmp byte [dword ecx+SeasonUserLocked], 0
        je short .6
        imul eax, dword [RosterOtherTeam], byte 1Ch
        cmp byte [dword eax+SeasonUserLocked], 0
        je short .6
        cmp byte [dword ecx+SeasonUserActive], 1
        je short .4
        cmp byte [dword eax+SeasonUserActive], 1
        je short .4
.6:
        mov dword [RosterChanged], 0
.7:
        call SetRosterArrows
        xor eax, eax
        call DrawRosterDetails
        mov eax, esi
        lea edi, [byte esi+06h]
        imul edi, byte 52h
        call SetRosterButtons
        test eax, eax
        jne short .8
        push str_GB00
        push dword [RosterShapeFile]
        call FindShape
        mov edx, eax
        mov eax, dword [RosterRow]
        mov dword [byte edi+eax+022h], edx
        mov eax, dword [RosterRow]
        mov dword [byte edi+eax+01Eh], edx
        mov eax, dword [RosterRow]
        add esp, byte 8
        mov dword [byte edi+eax+01Ah], edx
        jmp short .9
.8:
        push str_LB004
        push dword [RosterShapeFile]
        call FindShape
        add esp, byte 8
        mov edx, eax
        mov eax, dword [RosterRow]
        push str_LD002
        mov dword [byte edi+eax+01Ah], edx
        push dword [RosterShapeFile]
        call FindShape
        mov edx, eax
        mov eax, dword [RosterRow]
        mov dword [byte edi+eax+022h], edx
        mov eax, edx
        mov edx, dword [RosterRow]
        add esp, byte 8
        mov dword [byte edx+edi+01Eh], eax
.9:
        imul eax, dword [nosplit esi*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        movsx edx, word [byte edx+eax+074h]
        inc edx
        mov eax, dword [nosplit esi*4+RosterListBox]
        call SetListSelection
        imul eax, dword [nosplit esi*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        xor ebx, ebx
        movsx edx, word [byte edx+eax+072h]
        mov eax, dword [nosplit esi*4+RosterListBox]
        call SetScrollBarPos
        mov edx, dword [RosterPanelBitmap]
        mov eax, dword [nosplit esi*4+RosterListBox]
        call DrawScrollBar
        call SetScreenTarget
        test esi, esi
        jne short .10
        push dword 1A4h
        push esi
        push dword [RosterTitleWidth]
        push esi
        jmp short .11
.10:
        push dword 1A4h
        push byte 0
        push dword 280h
        push dword [RosterTitleY]
.11:
        call SetClipWindow
        add esp, byte 10h
        push byte 0
        mov eax, dword [RosterPanelBitmap]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call ResetClipWindow
        call PresentScreen
.12:
        leave
        pop edi
        pop esi
        ret 8
;-----------------------------------------------------------------------------
; CheckRosterInjuries                             CB041  97 PC, low confidence
; Roster: the "Roster Violation: %c. %s is injured." check
;-----------------------------------------------------------------------------
CheckRosterInjuries:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 88h, 0
        sub ebp, 82h
        xor esi, esi
        mov dword [byte ebp+07Ah], esi
.1:
        mov dword [byte ebp+07Eh], 0
        jmp near .9
.2:
        mov edx, dword [ebx]
        mov eax, dword [byte ebp+07Eh]
        movsx ecx, word [dword edx+0D05h]
        movzx eax, byte [byte ebx+eax+06Eh]
        cmp eax, ecx
        jge short .3
        imul ecx, eax, byte 38h
        add edx, ecx
        test byte [dword edx+0D09h], 4
        je near .7
        imul eax, dword 0BCh
        add ebx, 8FEh
        jmp near .6
.3:
        sub eax, ecx
        movsx ecx, word [dword edx+01281h]
        cmp eax, ecx
        jge short .4
        imul ecx, eax, byte 38h
        add edx, ecx
        test byte [dword edx+01283h], 4
        je short .7
        imul eax, dword 0BCh
        add ebx, 1B5Ah
        jmp short .6
.4:
        sub eax, ecx
        movsx ecx, word [dword edx+0132Bh]
        cmp eax, ecx
        jge short .5
        imul ecx, eax, byte 38h
        add edx, ecx
        test byte [dword edx+0132Dh], 4
        je short .7
        imul eax, dword 0BCh
        add ebx, 1D8Eh
        jmp short .6
.5:
        sub eax, ecx
        movsx ecx, word [dword edx+018A5h]
        cmp eax, ecx
        jge short .7
        imul ecx, eax, byte 38h
        add edx, ecx
        test byte [dword edx+018A7h], 4
        je short .7
        imul eax, dword 0BCh
        add ebx, 2FEAh
.6:
        mov esi, 1
        lea edi, [ebx+eax]
.7:
        test esi, esi
        je short .8
        lea eax, [byte edi+08h]
        push eax
        movzx eax, byte [byte edi+018h]
        push eax
        mov eax, 0D8h
        call GetLangText
        push eax
        lea eax, [byte ebp-06h]
        push eax
        call sprintf_
        add esp, byte 10h
        mov edx, 1
        xor ecx, ecx
        push byte 1
        xor ebx, ebx
        lea eax, [byte ebp-06h]
        call ShowMessageBox
        jmp short .10
.8:
        inc dword [byte ebp+07Eh]
.9:
        mov eax, dword [byte ebp+07Ah]
        imul ebx, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        add ebx, eax
        movzx eax, byte [byte ebx+071h]
        cmp eax, dword [byte ebp+07Eh]
        jg near .2
.10:
        test esi, esi
        jne near ShowTradeRejected_100
        inc dword [byte ebp+07Ah]
        cmp dword [byte ebp+07Ah], byte 2
        jl near .1
        jmp near ShowTradeRejected_100
;-----------------------------------------------------------------------------
; GetPlayerStatLine                               CB192  97 PC, low confidence
; Returns a player's stat line
;-----------------------------------------------------------------------------
GetPlayerStatLine:
        push ebx
        push ecx
        push esi
        imul eax, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        add ebx, eax
        mov eax, dword [ebx]
        movsx esi, word [dword eax+0D05h]
        xor ecx, ecx
        cmp edx, esi
        jge short .1
        imul edx, byte 27h
        movzx ecx, byte [dword edx+ebx+09Bh]
        jmp short .4
.1:
        sub edx, esi
        movsx esi, word [dword eax+01281h]
        cmp edx, esi
        jge short .2
        imul edx, byte 27h
        movzx ecx, byte [dword edx+ebx+0466h]
        jmp short .4
.2:
        sub edx, esi
        movsx esi, word [dword eax+0132Bh]
        cmp edx, esi
        jge short .3
        imul edx, byte 27h
        movzx ecx, byte [dword edx+ebx+04DFh]
        jmp short .4
.3:
        movsx eax, word [dword eax+018A5h]
        sub edx, esi
        cmp edx, eax
        jge short .4
        imul edx, byte 27h
        movzx ecx, byte [dword edx+ebx+08AAh]
.4:
        mov eax, ecx
        pop esi
        pop ecx
        pop ebx
        ret
