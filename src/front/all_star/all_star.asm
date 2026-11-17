; All-star teams: picking and drawing the all-star teams.
bits 32
%include "hockey.inc"
section s_E9429 progbits alloc exec nowrite align=1
extern AllocMemBlock, AllocNetBuffer, AllStarArena, AllStarArtDigits, AllStarAwayLines, AllStarCandidateCount, AllStarCandidates, AllStarConference
extern AllStarDay, AllStarDefenceKeyBase, AllStarDefenceStatKeys, AllStarForwardKeyBase, AllStarForwardStatKeys, AllStarHomeLines, AllStarItems, AllStarLastSpeech
extern AllStarLineData, AllStarLineDataAway, AllStarListArea, AllStarListBitmap, AllStarListChoice, AllStarLists, AllStarListSide, AllStarLogoData
extern AllStarLogoSlots, AllStarLogoSlotsPrev, AllStarLogoTables, AllStarNameArea, AllStarNameBitmap, AllStarPickArea, AllStarPickOrder, AllStarPicks
extern AllStarPlayers, AllStarRoster, AllStarRosterBase, AllStarScreenBitmap, AllStarScrollArea, AllStarShapeFile, AllStarSide, AllStarSlot
extern AllStarSlotArea, AllStarSlotFirst, AllStarSlotLayer, AllStarSlotOrder, AllStarSlotOrderNext, AllStarSlotOrderPrev, AllStarSlotPicked, AllStarSlotPlayers
extern AllStarSlotShape, AllStarSoundOn, AllStarSoundState, AllStarSoundTick, AllStarStatBitmap, AllStarTeamArea, AllStarTeamBitmap, AllStarTeamCode
extern AllStarTeamIds, AllStarTeamList, AutoLineData, AwayGoalieIndex, BlankMenuItem, BlitArt, BlitShape, BuildAllStarRecords
extern ChangeMenuMusic, ClearAndBuildLines, ClearScreen, ConvertArtXY, CreateBitmap, DbKeyBuffer, DrawArt, DrawHighlightBar
extern DrawScreenBackground, DrawScrollBar, DrawShadedLogo, DrawShapeBlended, DrawStatsBackground, DrawTextAligned, ExitScreen, FadeInScreen
extern FillRect, FindGameRecord, FindPlayerRecord, FindPlayerStat, FindShape, FindTeamStat, FreeBitmap, FreeLogoArt
extern FreeMemBlock, FreeScrollList, FreeStatsBitmap, FrontEndExit, FrontMusicOn, FrontShapeFile, GameLogCount, GetAllStarDate
extern GetLangText, HideWorkingBox, HomeGoalieIndex, homelines, HomeTeamCode, HomeTeamName, IndexEntryList, InitListBox
extern InitMenuItems, InitScrollList, InitShapeListBox, KeysEqual, LinkGameActive, LoadDataFile, LoadFrontEndSfx, LoadTeamLogo
extern MakeColor, MeasureText, memset_, PeriodAwayTeam, PeriodHomeTeam, PlayerStatsScreen, PlayScreenMovie, PlaySfx
extern PositionAbbrev, PresentScreen, qsort_, Random32, ReadBigEndian, ResetClipWindow, RunMenu, RunScrollList
extern ScreenFrameItem, ScreenTitleItem, ScrollDown, ScrollToMouse, ScrollUp, SeasonFileName, SeasonUserTeam, SecondsToSamples
extern ServiceIdle, SetClipWindow, SetDrawTarget, SetHighlightText, SetListSelection, SetMatchupTeams, SetNormalText, SetScreenTarget
extern SetScrollBarPos, SetTextColor, ShadowShape, ShowMessageBox, ShowPopupScreen, ShowScreen, ShowStatsScreen, ShowWorkingBox
extern sprintf_, StatsBackItem, StatsTablesScreen, StopAllSfx, str_100, str_1BOT6, str_1TOP6, str_2BOT6
extern str_2TOP6, str_3BOT6, str_3TOP6, str_AB006, str_AB016, str_AB026, str_AB036, str_AB046
extern str_AB056, str_AB062, str_AB072, str_AB082, str_AB092, str_AB102, str_AB112, str_AllStarAirecs
extern str_AllStarGoalieInfo, str_AllStarPlayerInfo, str_AllStarRawPlrs, str_AllStarRosters, str_AllStarStatrecs, str_AR00, str_AR02d3, str_AT00
extern str_BAK02, str_BAK12, str_C, str_C_DrawAllStarTeam, str_D3, str_D_DrawAllStarTeam, str_EastAllStars, str_EC002
extern str_EC012, str_FrANKGBarchard, str_LB005, str_LB02d7, str_LH00, str_MB005, str_MB02d2, str_MB044
extern str_MB082, str_MB12, str_MB16, str_MB20, str_POWR3, str_Punct_LoadAllStarArt, str_REF, str_Refpack
extern str_S_DrawAllStarList, str_TITL15, str_WC002, str_WC012, str_WestAllStars, strcpy_, tickcount, UpdateWorkingBox
extern WaitSoundTime, WipeScreen
global BuildAllStarTeams, BuildAllStarTeams_4B, AllStarScreen, AllStarSound, AllStarSound_1E0, InitAllStarScreen, FreeAllStarScreen, DrawAllStarConference
global ShowAllStarArt, DrawAllStarHighlight, DrawAllStarTeam, DrawAllStarTeam_68E, DrawAllStarTeam_6C5, DrawAllStarSlot, DrawAllStarSelection, DrawAllStarList
global LoadAllStarLogo, LoadAllStarArt, AllStarNextTeam, AllStarPrevTeam, AllStarNextSlot, AllStarPrevSlot, ClearAllStarPicks, AllStarPicksDone
global FindAllStarPick, FindFreeAllStarSlot, FindFreeAllStarSlot_31, AllStarPickTaken, AllStarPickPlayer, AllStarAddPick, AllStarRemovePick, AllStarTogglePick
global AllStarSlotPosition, CompareAllStarGoalie, CompareAllStarKey, AddAllStarCandidate, PickAllStarCandidates, PickAllStarPlayers, PickAllStarPlayers_4C2, PickAllStarPlayers_4C3
global InitAllStarTeams, AllocAllStarRosters, DrawAllStarPickList
;-----------------------------------------------------------------------------
; BuildAllStarTeams                               E9429  97 PC, low confidence
; From the season code: sets up the two All-Star teams (InitAllStarTeams,
; AllocAllStarRosters, PickAllStarPlayers)
;-----------------------------------------------------------------------------
BuildAllStarTeams:
        push ecx
        push edx
        call InitAllStarTeams
        call AllocAllStarRosters
        call PickAllStarPlayers
        push dword [AllStarCandidates]
        call FreeMemBlock
        add esp, byte 4
        push dword [AllStarPicks]
        call FreeMemBlock
        add esp, byte 4
        push dword [AllStarPickOrder]
        call FreeMemBlock
        add esp, byte 4
        push dword [AllStarPlayers]
        call FreeMemBlock
        mov eax, 1
BuildAllStarTeams_4B:
        add esp, byte 4
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; AllStarScreen                                   E947A  97 PC, low confidence
; From RunSeasonMenus: the All-Star screen (conference pages WC00 / EC00,
; player lists, BAK0 / BAK1)
;-----------------------------------------------------------------------------
AllStarScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 2028h, 0
        sub ebp, 82h
        lea eax, [dword ebp-01FA6h]
        mov dword [AllStarItems], eax
        lea eax, [dword ebp-028Eh]
        mov dword [AllStarTeamList], eax
        lea eax, [dword ebp-018Eh]
        mov dword [AllStarNameArea], eax
        lea eax, [dword ebp-013Eh]
        mov dword [AllStarPickArea], eax
        lea eax, [dword ebp-0EEh]
        mov dword [byte ebp+07Eh], 0
        mov dword [AllStarTeamArea], eax
        lea eax, [dword ebp-0A6h]
        xor edx, edx
        mov dword [AllStarSlotArea], eax
        lea eax, [byte ebp+0Ah]
.1:
        imul ebx, edx, byte 34h
        lea ecx, [eax+ebx]
        mov dword [nosplit edx*4+AllStarLogoData], ecx
        lea ecx, [byte ebp-05Eh]
        inc edx
        add ebx, ecx
        mov dword [nosplit edx*4+AllStarRosterBase], ebx
        cmp edx, byte 2
        jl short .1
        call SetHighlightText
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 3
        lea edx, [dword ebp-0F4Eh]
        call SecondsToSamples
        call WaitSoundTime
        call AllocAllStarRosters
        lea eax, [dword ebp-01FA6h]
        call InitAllStarScreen
        xor eax, eax
        call DrawAllStarConference
        mov eax, dword [AllStarConference]
        mov dword [byte ebp+07Ah], 0
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte eax+02Ch]
        xor esi, esi
        jmp near .26
.2:
        cmp dword [byte ebp+072h], byte 0Bh
        jb near .27
        jbe near .28
        cmp dword [byte ebp+072h], byte 0Ch
        jbe near .30
        lea eax, [dword ebp-028Eh]
        xor edx, edx
        call ScrollDown
        jmp near .29
.3:
        cmp dword [byte ebp+072h], byte 4
        jb short .4
        jbe near .13
        cmp dword [byte ebp+072h], byte 6
        jb near .15
        jbe near .17
        cmp dword [byte ebp+072h], byte 7
        jbe near .20
        jmp near .21
.4:
        cmp dword [byte ebp+072h], byte 1
        jb short .5
        jbe short .8
        cmp dword [byte ebp+072h], byte 2
        jbe near .11
        jmp near .12
.5:
        cmp dword [byte ebp+072h], byte 0
        jne near .40
        call ShowScreen
        call AllStarPicksDone
        test eax, eax
        jne short .6
        push byte 1
        mov ecx, 1
        mov edx, 2
        mov eax, 1C2h
        xor ebx, ebx
        call GetLangText
        call ShowMessageBox
        mov esi, eax
        test eax, eax
        je short .7
        call PickAllStarPlayers
        jmp short .7
.6:
        call ClearAndBuildLines
        inc esi
.7:
        mov edi, 1Ch
        jmp near .35
.8:
        call FadeInScreen
        call AllStarPicksDone
        test eax, eax
        jne short .9
        push byte 1
        mov ecx, 1
        mov edx, 2
        mov eax, 1C2h
        xor ebx, ebx
        call GetLangText
        call ShowMessageBox
        mov esi, eax
        test eax, eax
        je short .10
        call PickAllStarPlayers
        jmp short .10
.9:
        call ClearAndBuildLines
        inc esi
.10:
        mov edi, 0Eh
        cmp byte [FrontMusicOn], 0
        je near .35
        test esi, esi
        je near .35
        mov dword [byte ebp+07Eh], 1
        jmp near .35
.11:
        call ExitScreen
        jmp near .35
.12:
        cmp dword [AllStarSide], byte 0
        sete al
        movzx eax, al
        mov dword [AllStarSide], eax
        mov eax, 2
        call DrawAllStarConference
        jmp near .34
.13:
        imul eax, dword [byte ebp+072h], byte 52h
        mov eax, dword [dword eax+ebp-01F8Ch]
        movsx edx, word [byte eax+06h]
        imul eax, dword [byte ebp+072h], byte 52h
        add edx, dword [dword eax+ebp-01F7Ch]
        imul eax, dword [byte ebp+072h], byte 52h
        mov eax, dword [dword eax+ebp-01F8Ch]
        push edx
        movsx edx, word [byte eax+04h]
        imul eax, dword [byte ebp+072h], byte 52h
        add edx, dword [dword eax+ebp-01F80h]
        add edx, byte 0Ah
        mov eax, dword [AllStarConference]
        push edx
        push dword [byte eax+02Ch]
        mov eax, dword [AllStarSide]
        push dword [nosplit eax*4+AllStarLogoTables]
        push dword [nosplit eax*4+AllStarLogoData]
        imul eax, dword [byte ebp+072h], byte 52h
        mov eax, dword [dword eax+ebp-01F8Ch]
        movsx ecx, word [byte eax+06h]
        imul eax, dword [byte ebp+072h], byte 52h
        add ecx, dword [dword eax+ebp-01F7Ch]
        imul eax, dword [byte ebp+072h], byte 52h
        mov edx, 8
        mov ebx, dword [dword eax+ebp-01F80h]
        mov eax, 0Dh
        call RunScrollList
        test eax, eax
        jl near .35
        cmp eax, byte 0Dh
        jge near .35
        imul edx, dword [AllStarSide], byte 0Dh
        movzx ebx, byte [dword edx+eax+AllStarSlotPlayers]
        mov edx, dword [AllStarSide]
        cmp ebx, dword [nosplit edx*4+AllStarSlot]
        je near .35
        imul edx, byte 0Dh
        movzx edx, byte [dword edx+eax+AllStarSlotPlayers]
        mov eax, dword [AllStarSide]
        mov dword [nosplit eax*4+AllStarSlot], edx
        cmp dword [nosplit eax*4+AllStarSlotPicked], byte 0
        jge short .14
        mov dword [nosplit eax*4+AllStarSlotFirst], esi
.14:
        lea eax, [dword ebp-028Eh]
        xor ebx, ebx
        xor edx, edx
        call SetScrollBarPos
        jmp near .33
.15:
        imul eax, dword [byte ebp+072h], byte 52h
        mov eax, dword [dword eax+ebp-01F8Ch]
        movsx eax, word [byte eax+06h]
        lea edx, [eax+eax*8]
        imul eax, dword [byte ebp+072h], byte 52h
        mov eax, dword [dword eax+ebp-01F7Ch]
        sub eax, edx
        push eax
        imul eax, dword [byte ebp+072h], byte 52h
        mov eax, dword [dword eax+ebp-01F8Ch]
        movsx edx, word [byte eax+04h]
        imul eax, dword [byte ebp+072h], byte 52h
        mov eax, dword [dword eax+ebp-01F80h]
        add eax, edx
        add eax, byte 0Ah
        push eax
        mov eax, dword [AllStarConference]
        push dword [byte eax+02Ch]
        imul eax, dword [byte ebp+072h], byte 52h
        mov eax, dword [dword eax+ebp-01F8Ch]
        movsx ecx, word [byte eax+06h]
        imul eax, dword [byte ebp+072h], byte 52h
        lea ecx, [ecx+ecx*8]
        mov eax, dword [dword eax+ebp-01F7Ch]
        sub eax, ecx
        mov ecx, eax
        imul eax, dword [byte ebp+072h], byte 52h
        mov dword [byte ebp+076h], 9
        mov edx, dword [byte ebp+076h]
        push dword [AllStarListArea]
        mov ebx, dword [dword eax+ebp-01F80h]
        mov eax, dword [AllStarListSide]
        push dword [AllStarScrollArea]
        mov eax, dword [nosplit eax*4+AllStarLists]
        call RunScrollList
        mov edx, dword [AllStarListSide]
        cmp eax, dword [nosplit edx*4+AllStarListChoice]
        je near .35
        test eax, eax
        jl near .35
        cmp eax, dword [nosplit edx*4+AllStarLists]
        jge near .35
        mov ebx, 1
        mov dword [nosplit edx*4+AllStarListChoice], eax
.16:
        mov eax, 1
        mov edx, 0FFFFFFFFh
        call DrawAllStarHighlight
        mov eax, ebx
        call DrawAllStarSelection
        jmp near .35
.17:
        call ClearAllStarPicks
.18:
        mov edx, 0FFFFFFFFh
.19:
        mov eax, 1
        call DrawAllStarList
        jmp near .34
.20:
        mov eax, dword [AllStarSide]
        mov edx, 0FFFFFFFEh
        mov dword [nosplit eax*4+AllStarSlotFirst], 0FFFFFFFFh
        mov dword [nosplit eax*4+AllStarSlotPicked], esi
        call PickAllStarPlayers
        mov eax, 1
        call DrawAllStarTeam
        jmp short .18
.21:
        mov eax, dword [AllStarSide]
        cmp dword [nosplit eax*4+AllStarSlotFirst], byte 0
        jl near .22
        imul edx, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov eax, dword [AllStarPlayers]
        movsx ebx, word [dword edx+eax+0D05h]
        mov eax, dword [AllStarSide]
        imul eax, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov edx, dword [AllStarPlayers]
        movsx eax, word [dword edx+eax+01281h]
        add ebx, eax
        mov eax, dword [AllStarSide]
        cmp ebx, dword [nosplit eax*4+AllStarSlotFirst]
        jle short .22
        call AllStarTogglePick
        mov edx, eax
        mov eax, dword [AllStarSide]
        mov dword [nosplit eax*4+AllStarSlotPicked], edx
        mov edx, dword [nosplit eax*4+AllStarSlotFirst]
        mov dword [nosplit eax*4+AllStarSlotFirst], 0FFFFFFFFh
        mov eax, 1
        call DrawAllStarTeam
        mov eax, dword [AllStarSide]
        mov edx, dword [nosplit eax*4+AllStarSlotPicked]
        jmp near .19
.22:
        mov eax, dword [AllStarSide]
        shl eax, 2
        cmp dword [dword eax+AllStarSlotPicked], byte 0
        jl near .34
        cmp dword [dword eax+AllStarSlotPicked], byte 16h
        jge near .34
        call AllStarSlotPosition
        mov edx, dword [AllStarSide]
        mov edx, dword [nosplit edx*4+AllStarSlotPicked]
        lea eax, [byte edx+01h]
        call AllStarPickPlayer
        mov ebx, eax
        mov eax, dword [AllStarSide]
        mov dword [nosplit eax*4+AllStarSlotPicked], ebx
        mov eax, 1
        call DrawAllStarList
        mov eax, dword [AllStarSide]
        shl eax, 2
        cmp dword [dword eax+AllStarSlotPicked], byte 0
        jl near .34
        mov edx, dword [dword eax+AllStarSlotPicked]
        jmp near .19
.23:
        lea eax, [dword ebp-01CC4h]
        call ShowPopupScreen
        call FreeAllStarScreen
        mov byte [FrontEndExit], 0
        call PlayerStatsScreen
.24:
        call SetHighlightText
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        lea edx, [dword ebp-0F4Eh]
        call SetTextColor
        lea eax, [dword ebp-01FA6h]
        call InitAllStarScreen
        xor eax, eax
        call DrawAllStarConference
        mov eax, dword [AllStarConference]
        mov edx, 0FFFFFFFFh
.25:
        mov eax, dword [byte eax+02Ch]
.26:
        call WipeScreen
        jmp near .35
.27:
        lea eax, [dword ebp-01C72h]
        call ShowPopupScreen
        call FreeAllStarScreen
        call StatsTablesScreen
        jmp short .24
.28:
        lea eax, [dword ebp-028Eh]
        xor edx, edx
        call ScrollUp
.29:
        mov edx, 0FFFFFFFEh
        mov eax, 1
        call DrawAllStarTeam
        jmp near .35
.30:
        mov ebx, eax
        xor edx, edx
        lea eax, [dword ebp-028Eh]
        call ScrollToMouse
        mov eax, dword [byte ebp+07Ah]
        cmp eax, dword [dword ebp-026Ah]
        je near .35
        mov edx, 0FFFFFFFEh
        mov eax, 1
        call DrawAllStarTeam
        mov eax, dword [dword ebp-026Ah]
        mov dword [byte ebp+07Ah], eax
        jmp short .35
.31:
        call AllStarPrevSlot
.32:
        mov edx, eax
        mov eax, dword [AllStarSide]
        shl eax, 2
        cmp edx, dword [dword eax+AllStarSlot]
        je short .35
        xor ebx, ebx
        mov dword [dword eax+AllStarSlot], edx
        lea eax, [dword ebp-028Eh]
        xor edx, edx
        call SetScrollBarPos
        mov eax, dword [AllStarSide]
        shl eax, 2
        cmp dword [dword eax+AllStarSlotFirst], byte 0
        jl short .33
        mov dword [dword eax+AllStarSlotFirst], esi
.33:
        mov eax, 1
        mov edx, 0FFFFFFFFh
        call ShowAllStarArt
        mov eax, 1
        call DrawAllStarTeam
.34:
        call DrawAllStarPickList
.35:
        test esi, esi
        jne near .42
        lea eax, [byte ebp+072h]
        push esi
        mov ecx, AllStarSound
        mov ebx, 0FFFFFFFFh
        push eax
        lea edx, [dword ebp-01FA6h]
        mov eax, 33h
        call RunMenu
        cmp dword [byte ebp+072h], byte 9
        jb near .3
        jbe near .23
        cmp dword [byte ebp+072h], byte 0Eh
        jb near .2
        jbe near .31
        cmp dword [byte ebp+072h], byte 10h
        jb short .36
        mov eax, dword [AllStarListSide]
        shl eax, 2
        cmp dword [byte ebp+072h], byte 10h
        jbe short .37
        cmp dword [byte ebp+072h], byte 11h
        jbe short .38
        cmp dword [byte ebp+072h], byte 32h
        je short .39
        jmp near .40
.36:
        call AllStarNextSlot
        jmp near .32
.37:
        cmp dword [dword eax+AllStarListChoice], byte 0
        jle short .35
        mov ebx, 1
        dec dword [dword eax+AllStarListChoice]
        jmp near .16
.38:
        mov edx, dword [dword eax+AllStarLists]
        dec edx
        cmp edx, dword [dword eax+AllStarListChoice]
        jle near .35
        mov ebx, 1
        inc dword [dword eax+AllStarListChoice]
        jmp near .16
.39:
        call ShowStatsScreen
        call FreeAllStarScreen
        cmp dword [LinkGameActive], byte 0
        sete al
        movzx edx, al
        mov eax, 0E8h
        call PlayScreenMovie
        call ChangeMenuMusic
        call SetHighlightText
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        lea edx, [dword ebp-0F4Eh]
        call SetTextColor
        lea eax, [dword ebp-01FA6h]
        call InitAllStarScreen
        xor eax, eax
        call DrawAllStarConference
        mov eax, dword [AllStarConference]
        xor edx, edx
        jmp near .25
.40:
        cmp dword [byte ebp+072h], byte 12h
        jl short .41
        cmp dword [byte ebp+072h], byte 1Ch
        jge short .41
        mov eax, dword [byte ebp+072h]
        sub eax, byte 12h
        add eax, dword [dword ebp-026Ah]
        call AllStarNextTeam
        jmp near .34
.41:
        cmp dword [byte ebp+072h], byte 1Ch
        jl near .34
        cmp dword [byte ebp+072h], byte 33h
        jge near .34
        mov eax, dword [byte ebp+072h]
        sub eax, byte 1Ch
        call AllStarPrevTeam
        jmp near .34
.42:
        call SetNormalText
        call FreeAllStarScreen
        push dword [AllStarCandidates]
        call FreeMemBlock
        add esp, byte 4
        push dword [AllStarPicks]
        call FreeMemBlock
        add esp, byte 4
        push dword [AllStarPickOrder]
        call FreeMemBlock
        add esp, byte 4
        push dword [AllStarPlayers]
        call FreeMemBlock
        add esp, byte 4
        cmp dword [byte ebp+07Eh], byte 0
        je short .43
        call LoadFrontEndSfx
.43:
        mov eax, edi
        lea esp, [dword ebp+082h]
        pop ebp
        jmp near PickAllStarPlayers_4C3
;-----------------------------------------------------------------------------
; AllStarSound                                    E9CB5  97 PC, low confidence
; Plays an all-star screen sound
;-----------------------------------------------------------------------------
AllStarSound:
        push ebx
        push ecx
        push edx
        push esi
        enter 8, 0
        mov eax, dword [tickcount]
        mov esi, eax
        xor ebx, ebx
        cmp eax, dword [AllStarSoundTick]
        jle near AllStarSound_1E0
        call Random32
        mov ecx, 3
        xor edx, edx
        div ecx
        cmp edx, dword [AllStarLastSpeech]
        jl short .1
        inc edx
.1:
        mov eax, dword [AllStarItems]
        mov dword [AllStarLastSpeech], edx
        cmp dword [dword eax+01F0h], byte 1
        jne short .3
        add edx, byte 8
        push edx
        push str_MB02d2
        lea eax, [byte ebp-08h]
        push eax
        call sprintf_
        mov eax, dword [AllStarItems]
        add esp, byte 0Ch
        push dword [dword eax+0216h]
        push dword [dword eax+0212h]
.2:
        lea eax, [byte ebp-08h]
        push eax
        push dword [AllStarShapeFile]
        call FindShape
        add esp, byte 8
        push eax
        mov ebx, 1
        jmp near .8
.3:
        cmp dword [dword eax+0242h], byte 1
        jne short .4
        add edx, byte 0Ch
        push edx
        push str_MB02d2
        lea eax, [byte ebp-08h]
        push eax
        call sprintf_
        mov eax, dword [AllStarItems]
        add esp, byte 0Ch
        push dword [dword eax+0268h]
        push dword [dword eax+0264h]
        jmp short .2
.4:
        cmp dword [dword eax+0294h], byte 1
        jne short .6
        mov ebx, 1
        cmp dword [AllStarSoundState], byte 0
        je near .9
        jg short .5
        add edx, byte 4
.5:
        push edx
        push str_MB02d2
        lea eax, [byte ebp-08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, dword [AllStarItems]
        push dword [dword eax+02BAh]
        push dword [dword eax+02B6h]
        lea eax, [byte ebp-08h]
        push eax
        push dword [AllStarShapeFile]
        call FindShape
        add esp, byte 8
        push eax
        jmp near .8
.6:
        cmp dword [dword eax+02E6h], byte 1
        jne short .7
        add edx, byte 10h
        push edx
        push str_MB02d2
        lea eax, [byte ebp-08h]
        push eax
        call sprintf_
        mov eax, dword [AllStarItems]
        add esp, byte 0Ch
        push dword [dword eax+030Ch]
        push dword [dword eax+0308h]
        jmp near .2
.7:
        cmp dword [dword eax+0338h], byte 1
        jne short .9
        add edx, byte 14h
        push edx
        push str_MB02d2
        lea eax, [byte ebp-08h]
        push eax
        call sprintf_
        mov eax, dword [AllStarItems]
        add esp, byte 0Ch
        push dword [dword eax+035Eh]
        push dword [dword eax+035Ah]
        lea eax, [byte ebp-08h]
        push eax
        push dword [AllStarShapeFile]
        call FindShape
        add esp, byte 8
        push eax
        mov ebx, 1
.8:
        call BlitArt
        add esp, byte 0Ch
.9:
        add esi, byte 4
        mov dword [AllStarSoundTick], esi
        test bx, bx
        je short .10
        cmp word [AllStarSoundOn], byte 0
        jne short .10
        mov eax, 309h
        call PlaySfx
        mov word [AllStarSoundOn], 1
.10:
        test bx, bx
        jne short AllStarSound_1E0
        cmp word [AllStarSoundOn], byte 0
        je short AllStarSound_1E0
        call StopAllSfx
        mov word [AllStarSoundOn], bx
AllStarSound_1E0:
        leave
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; InitAllStarScreen                               E9E9B  97 PC, low confidence
; From AllStarScreen: loads its art and sets up the menu items (BAK0, TITL,
; LB%02d, AR%02d)
;-----------------------------------------------------------------------------
InitAllStarScreen:
        push ebx
        push ecx
        push esi
        push edi
        enter 8, 0
        push eax
        mov edi, edx
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 6Eh
        call LoadDataFile
        mov dword [AllStarShapeFile], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 6Fh
        call LoadDataFile
        push byte 0
        push dword 1E0h
        push dword 280h
        mov dword [AllStarScreenBitmap], eax
        call CreateBitmap
        mov edx, dword [byte ebp-0Ch]
        add esp, byte 0Ch
        mov dword [AllStarConference], eax
        mov eax, 33h
        xor esi, esi
        call InitMenuItems
.1:
        mov eax, esi
        shl eax, 6
        lea edx, [edi+eax]
        imul eax, esi, byte 52h
        add eax, dword [byte ebp-0Ch]
        mov dword [byte eax+022h], 0
        mov dword [byte eax+014h], edx
        push byte 1
        mov edx, dword [byte eax+022h]
        mov ecx, 1
        mov dword [byte eax+01Eh], edx
        mov ebx, 1E0h
        mov dword [byte eax+01Ah], edx
        mov edx, 280h
        inc esi
        call InitListBox
        cmp esi, byte 33h
        jl short .1
        push dword [AllStarConference]
        call SetDrawTarget
        add esp, byte 4
        push str_BAK02
        push dword [AllStarScreenBitmap]
        call FindShape
        add esp, byte 8
        push eax
        mov dword [byte ebp-08h], eax
        call BlitShape
        add esp, byte 4
        push str_TITL15
        push dword [AllStarShapeFile]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        mov eax, dword [AllStarConference]
        mov edi, dword [byte ebp-0Ch]
        mov eax, dword [byte eax+02Ch]
        add esp, byte 4
        mov ebx, eax
        mov edx, eax
        mov esi, StatsBackItem
        call DrawScreenBackground
        mov eax, dword [AllStarConference]
        mov ebx, 19Ah
        mov edx, 12Ch
        mov eax, dword [byte eax+02Ch]
        mov ecx, 52h
        call DrawStatsBackground
        lea edi, [dword edi+01004h]
        rep movsb
        mov eax, dword [byte ebp-0Ch]
        mov ecx, 52h
        mov esi, ScreenTitleItem
        mov edi, eax
        mov dword [dword eax+01004h], 32h
        rep movsb
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
        push str_WC002
        mov ebx, str_WC002
        rep movsb
        lea edx, [dword eax+0F6h]
        mov dword [dword eax+0A4h], 2
        mov ecx, str_WC012
        mov eax, dword [AllStarShapeFile]
        call InitShapeListBox
        call LoadAllStarLogo
        push str_LB005
        mov edx, dword [byte ebp-0Ch]
        mov ecx, str_LH00
        mov ebx, str_LB005
        mov eax, dword [AllStarScreenBitmap]
        add edx, 148h
        call InitShapeListBox
        mov edx, dword [byte ebp-0Ch]
        mov ecx, str_AT00
        xor eax, eax
        mov ebx, str_AR00
        call ShowAllStarArt
        call LoadAllStarArt
        push str_AR00
        mov eax, dword [AllStarShapeFile]
        add edx, 19Ah
        call InitShapeListBox
        mov edx, dword [byte ebp-0Ch]
        xor eax, eax
        mov ecx, str_MB082
        call DrawAllStarHighlight
        push str_MB082
        mov eax, dword [AllStarShapeFile]
        add edx, 1ECh
        mov ebx, ecx
        call InitShapeListBox
        push str_MB12
        mov edx, dword [byte ebp-0Ch]
        mov ecx, str_MB12
        mov eax, dword [AllStarShapeFile]
        add edx, 23Eh
        mov ebx, ecx
        call InitShapeListBox
        push str_MB005
        mov edx, dword [byte ebp-0Ch]
        mov ecx, str_MB005
        mov eax, dword [AllStarShapeFile]
        add edx, 290h
        mov ebx, ecx
        call InitShapeListBox
        push str_MB16
        mov edx, dword [byte ebp-0Ch]
        mov ecx, str_MB16
        mov eax, dword [AllStarShapeFile]
        add edx, 2E2h
        mov ebx, ecx
        call InitShapeListBox
        push str_MB20
        mov edx, dword [byte ebp-0Ch]
        mov ecx, str_MB20
        mov eax, dword [AllStarShapeFile]
        add edx, 334h
        mov ebx, ecx
        call InitShapeListBox
        push byte 0
        push byte 0
        push dword 0B4h
        push dword 80h
        push dword 266h
        mov edx, dword [byte ebp-0Ch]
        mov ecx, 0Ah
        push dword [byte ebp-08h]
        mov ebx, 19h
        push byte 0
        mov eax, dword [AllStarTeamList]
        add edx, 386h
        call InitScrollList
        mov eax, dword [byte ebp-0Ch]
        mov dword [dword eax+03ACh], 266h
        push str_1TOP6
        mov dword [dword eax+03B0h], 80h
        push dword [FrontShapeFile]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp-0Ch]
        push str_2TOP6
        mov dword [dword edx+03A0h], eax
        push dword [FrontShapeFile]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp-0Ch]
        push str_3TOP6
        mov dword [dword edx+03A4h], eax
        push dword [FrontShapeFile]
        call FindShape
        mov edx, dword [byte ebp-0Ch]
        mov dword [dword edx+03A8h], eax
        mov eax, dword [dword edx+03A0h]
        mov dword [dword edx+0450h], 266h
        mov edx, 134h
        movsx eax, word [byte eax+06h]
        add esp, byte 8
        sub edx, eax
        mov eax, dword [byte ebp-0Ch]
        push str_1BOT6
        mov dword [dword eax+0454h], edx
        push dword [FrontShapeFile]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp-0Ch]
        push str_2BOT6
        mov dword [dword edx+0444h], eax
        push dword [FrontShapeFile]
        call FindShape
        mov edx, dword [byte ebp-0Ch]
        add esp, byte 8
        mov dword [dword edx+0448h], eax
        push str_3BOT6
        push dword [FrontShapeFile]
        call FindShape
        mov edx, dword [byte ebp-0Ch]
        mov ebx, str_AB006
        mov dword [dword edx+044Ch], eax
        add esp, byte 8
        mov edx, dword [AllStarConference]
        mov eax, dword [AllStarTeamList]
        mov ecx, str_AB016
        call DrawScrollBar
        push str_AB026
        mov edx, dword [byte ebp-0Ch]
        mov eax, dword [AllStarScreenBitmap]
        add edx, 47Ch
        call InitShapeListBox
        push str_AB056
        mov edx, dword [byte ebp-0Ch]
        mov ecx, str_AB046
        mov ebx, str_AB036
        mov eax, dword [AllStarScreenBitmap]
        add edx, 4CEh
        call InitShapeListBox
        push str_AB082
        mov edx, dword [byte ebp-0Ch]
        mov ecx, str_AB072
        mov ebx, str_AB062
        mov eax, dword [AllStarScreenBitmap]
        add edx, 520h
        call InitShapeListBox
        push str_AB112
        mov edx, dword [byte ebp-0Ch]
        mov ecx, str_AB102
        mov ebx, str_AB092
        mov eax, dword [AllStarScreenBitmap]
        add edx, 572h
        call InitShapeListBox
        push dword [AllStarConference]
        xor esi, esi
        call SetDrawTarget
        add esp, byte 4
.2:
        imul eax, esi, byte 52h
        add eax, dword [byte ebp-0Ch]
        cmp dword [byte eax+01Ah], byte 0
        je short .3
        push dword [byte eax+02Ah]
        push dword [byte eax+026h]
        push dword [byte eax+01Ah]
        call DrawArt
        add esp, byte 0Ch
.3:
        inc esi
        cmp esi, byte 12h
        jl short .2
        push byte 0
        push dword 0EAh
        push dword 0A0h
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push byte 6Ch
        push dword 96h
        mov dword [AllStarNameBitmap], eax
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push byte 36h
        push dword 96h
        mov dword [AllStarStatBitmap], eax
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push dword 0B4h
        push dword 136h
        mov dword [AllStarListBitmap], eax
        call CreateBitmap
        add esp, byte 0Ch
        push dword 80h
        mov dword [AllStarTeamBitmap], eax
        mov eax, dword [AllStarNameBitmap]
        push byte 0
        push dword [byte eax+02Ch]
        call ConvertArtXY
        add esp, byte 0Ch
        push dword 80h
        mov eax, dword [AllStarStatBitmap]
        push dword 0AAh
        push dword [byte eax+02Ch]
        call ConvertArtXY
        add esp, byte 0Ch
        push dword 11Eh
        mov eax, dword [AllStarListBitmap]
        push dword 0AAh
        push dword [byte eax+02Ch]
        call ConvertArtXY
        add esp, byte 0Ch
        push dword 80h
        mov eax, dword [AllStarTeamBitmap]
        push dword 14Ah
        push dword [byte eax+02Ch]
        call ConvertArtXY
        add esp, byte 0Ch
        mov dword [byte ebp-04h], 0Ah
        mov edi, 80h
        push dword [AllStarNameBitmap]
        xor esi, esi
        call SetDrawTarget
        add esp, byte 4
.4:
        lea eax, [byte esi+01Ch]
        imul eax, byte 52h
        push byte 12h
        mov ecx, 96h
        mov edx, dword [byte ebp-04h]
        mov ebx, edi
        inc esi
        add eax, dword [byte ebp-0Ch]
        add edi, byte 12h
        call InitListBox
        cmp esi, byte 0Dh
        jl short .4
        mov edi, 80h
        mov dword [byte ebp-04h], 0AAh
        xor esi, esi
.5:
        lea eax, [byte esi+029h]
        imul eax, byte 52h
        push byte 12h
        mov ecx, 96h
        mov edx, dword [byte ebp-04h]
        mov ebx, edi
        inc esi
        add eax, dword [byte ebp-0Ch]
        add edi, byte 12h
        call InitListBox
        cmp esi, byte 6
        jl short .5
        mov edi, 11Eh
        mov dword [byte ebp-04h], 0AAh
        xor esi, esi
.6:
        lea eax, [byte esi+02Fh]
        imul eax, byte 52h
        push byte 12h
        mov ecx, 96h
        mov edx, dword [byte ebp-04h]
        mov ebx, edi
        inc esi
        add eax, dword [byte ebp-0Ch]
        add edi, byte 12h
        call InitListBox
        cmp esi, byte 3
        jl short .6
        mov edi, 80h
        mov dword [byte ebp-04h], 14Ah
        xor esi, esi
.7:
        lea eax, [byte esi+012h]
        imul eax, byte 52h
        push byte 12h
        mov ecx, 118h
        mov edx, dword [byte ebp-04h]
        mov ebx, edi
        inc esi
        add eax, dword [byte ebp-0Ch]
        add edi, byte 12h
        call InitListBox
        cmp esi, byte 0Ah
        jl short .7
        push str_POWR3
        push dword [AllStarScreenBitmap]
        call FindShape
        mov dword [AllStarSlotShape], eax
        add esp, byte 8
        movsx ebx, word [byte eax+06h]
        push byte 0
        sub ebx, byte 8
        movsx edi, word [byte eax+04h]
        push ebx
        sub edi, byte 0Ch
        push edi
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        xor esi, esi
        mov dword [AllStarSlotLayer], eax
        call SetDrawTarget
        add esp, byte 4
        jmp short .9
.8:
        imul eax, esi, dword 7E0h
        cdq
        idiv edi
        mov edx, 0FFE0h
        and eax, 7E0h
        sub edx, eax
        push edx
        push ebx
        mov eax, edi
        push byte 1
        sub eax, esi
        push byte 0
        dec eax
        push eax
        inc esi
        call FillRect
        add esp, byte 14h
.9:
        cmp esi, edi
        jl short .8
        jmp near DrawAllStarTeam_6C5
;-----------------------------------------------------------------------------
; FreeAllStarScreen                               EA52D  97 PC, low confidence
; Frees the all-star screen
;-----------------------------------------------------------------------------
FreeAllStarScreen:
        push ecx
        push edx
        mov eax, dword [AllStarTeamList]
        call FreeScrollList
        push dword [AllStarSlotLayer]
        call FreeBitmap
        add esp, byte 4
        push dword [AllStarNameBitmap]
        call FreeBitmap
        add esp, byte 4
        push dword [AllStarStatBitmap]
        call FreeBitmap
        add esp, byte 4
        push dword [AllStarListBitmap]
        call FreeBitmap
        add esp, byte 4
        push dword [AllStarTeamBitmap]
        call FreeBitmap
        add esp, byte 4
        push dword [AllStarConference]
        call FreeBitmap
        add esp, byte 4
        push dword [AllStarShapeFile]
        call FreeMemBlock
        add esp, byte 4
        push dword [AllStarScreenBitmap]
        call FreeMemBlock
        add esp, byte 4
        call FreeStatsBitmap
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; DrawAllStarConference                           EA5B1  97 PC, low confidence
; From AllStarScreen: draws the conference page (WC00 / WC01 or EC00 / EC01
; art) and its player list (DrawAllStarList)
;-----------------------------------------------------------------------------
DrawAllStarConference:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        push dword [AllStarConference]
        call SetDrawTarget
        add esp, byte 4
        cmp dword [AllStarSide], byte 0
        jne short .1
        push str_WC002
        mov ecx, str_WC012
        mov ebx, str_WC002
        jmp short .2
.1:
        push str_EC002
        mov ecx, str_EC012
        mov ebx, str_EC002
.2:
        mov edx, dword [AllStarItems]
        mov eax, dword [AllStarShapeFile]
        add edx, 0F6h
        call InitShapeListBox
        xor eax, eax
        call ShowAllStarArt
        xor eax, eax
        call DrawAllStarHighlight
        mov eax, dword [AllStarItems]
        push dword [dword eax+0120h]
        push dword [dword eax+011Ch]
        push dword [dword eax+0110h]
        call DrawArt
        add esp, byte 0Ch
        mov edx, 0FFFFFFFFh
        mov eax, esi
        call DrawAllStarList
        mov edx, 0FFFFFFFFh
        mov eax, esi
        call DrawAllStarTeam
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ShowAllStarArt                                  EA64E  97 PC, low confidence
; Shows the all-star art
;-----------------------------------------------------------------------------
ShowAllStarArt:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        mov eax, dword [AllStarSide]
        mov edx, dword [nosplit eax*4+AllStarSlot]
        movzx edx, byte [dword edx+AllStarLogoSlots]
        mov eax, dword [nosplit eax*4+AllStarLogoData]
        shl edx, 2
        add eax, edx
        mov edx, dword [AllStarItems]
        mov eax, dword [eax]
        mov dword [dword edx+0162h], eax
        mov eax, dword [AllStarSide]
        mov ecx, dword [nosplit eax*4+AllStarSlot]
        movzx ecx, byte [dword ecx+AllStarLogoSlots]
        mov edx, dword [nosplit eax*4+AllStarLogoTables]
        shl ecx, 2
        mov eax, dword [AllStarItems]
        mov edx, dword [ecx+edx]
        mov dword [dword eax+016Ah], edx
        mov eax, dword [AllStarItems]
        mov dword [dword eax+0166h], edx
        test ebx, ebx
        je short .1
        call SetScreenTarget
.1:
        mov eax, dword [AllStarItems]
        push dword [dword eax+0172h]
        push dword [dword eax+016Eh]
        push dword [dword eax+0162h]
        call DrawArt
        add esp, byte 0Ch
        test ebx, ebx
        je short .2
        call PresentScreen
.2:
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawAllStarHighlight                            EA6EB  97 PC, low confidence
; Draws the all-star highlight
;-----------------------------------------------------------------------------
DrawAllStarHighlight:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        cmp dword [AllStarListSide], byte 0
        jne short .1
        mov eax, dword [AllStarNameArea]
        mov dword [AllStarScrollArea], eax
        mov eax, dword [AllStarPickArea]
        jmp short .2
.1:
        mov eax, dword [AllStarTeamArea]
        mov dword [AllStarScrollArea], eax
        mov eax, dword [AllStarSlotArea]
.2:
        mov dword [AllStarListArea], eax
        mov eax, dword [AllStarListSide]
        mov edx, dword [nosplit eax*4+AllStarListChoice]
        mov eax, dword [AllStarScrollArea]
        shl edx, 2
        add edx, eax
        mov eax, dword [AllStarItems]
        mov edx, dword [edx]
        mov dword [dword eax+01B4h], edx
        mov eax, dword [AllStarListSide]
        mov edx, dword [nosplit eax*4+AllStarListChoice]
        mov eax, dword [AllStarListArea]
        shl edx, 2
        add edx, eax
        mov eax, dword [AllStarItems]
        mov edx, dword [edx]
        mov dword [dword eax+01BCh], edx
        mov eax, dword [AllStarItems]
        mov dword [dword eax+01B8h], edx
        test ebx, ebx
        je short .3
        call SetScreenTarget
.3:
        mov eax, dword [AllStarItems]
        push dword [dword eax+01C4h]
        push dword [dword eax+01C0h]
        push dword [dword eax+01B4h]
        call DrawArt
        add esp, byte 0Ch
        test ebx, ebx
        je short .4
        call PresentScreen
.4:
        pop edx
        pop ecx
        pop ebx
        ret
        push esi
        mov esi, eax
        push ecx
        push ebx
        push edx
        push dword 0FFFFFF50h
        mov ebx, 10h
        call MakeColor
        mov edx, eax
        mov eax, dword [AllStarConference]
        add esp, byte 4
        mov ecx, esi
        mov eax, dword [byte eax+02Ch]
        call DrawHighlightBar
        pop esi
        ret
;-----------------------------------------------------------------------------
; DrawAllStarTeam                                 EA7CF  97 PC, low confidence
; Draws an all-star team
;-----------------------------------------------------------------------------
DrawAllStarTeam:
        push ebx
        push ecx
        push esi
        push edi
        enter 28h, 0
        push eax
        mov edi, edx
        mov eax, dword [AllStarSide]
        imul eax, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov edx, dword [AllStarPlayers]
        add eax, edx
        movsx edx, word [dword eax+0D05h]
        movsx eax, word [dword eax+01281h]
        add edx, eax
        mov eax, dword [AllStarTeamList]
        mov dword [byte ebp-010h], edx
        call SetListSelection
        push str_BAK12
        push dword [AllStarScreenBitmap]
        call FindShape
        mov ebx, eax
        add esp, byte 8
        mov esi, eax
        cmp edi, byte 0FFFFFFFFh
        jne near .5
        cmp dword [byte ebp-02Ch], byte 0
        je near .3
        push dword [AllStarConference]
        call SetDrawTarget
        add esp, byte 4
        push dword 1E0h
        push byte 0
        push dword 280h
        push dword 14Ah
        call SetClipWindow
        add esp, byte 10h
        push ebx
        call BlitShape
        mov eax, dword [AllStarItems]
        add esp, byte 4
        push dword [dword eax+0172h]
        push dword [dword eax+016Eh]
        push dword [dword eax+0162h]
        call DrawArt
        mov eax, dword [AllStarItems]
        add esp, byte 0Ch
        push dword [dword eax+04A6h]
        push dword [dword eax+04A2h]
        push dword [dword eax+0496h]
        call DrawArt
        mov eax, dword [AllStarItems]
        add esp, byte 0Ch
        push dword [dword eax+04F8h]
        push dword [dword eax+04F4h]
        push dword [dword eax+04E8h]
        call DrawArt
        mov eax, dword [AllStarItems]
        add esp, byte 0Ch
        push dword [dword eax+01C4h]
        push dword [dword eax+01C0h]
        push dword [dword eax+01B4h]
        call DrawArt
        mov eax, dword [AllStarItems]
        add esp, byte 0Ch
        push dword [dword eax+054Ah]
        push dword [dword eax+0546h]
        push dword [dword eax+053Ah]
        call DrawArt
        mov eax, dword [AllStarItems]
        add esp, byte 0Ch
        push dword [dword eax+059Ch]
        push dword [dword eax+0598h]
        push dword [dword eax+058Ch]
        call DrawArt
        mov eax, dword [AllStarItems]
        add esp, byte 0Ch
        cmp dword [dword eax+02AAh], byte 0
        je short .1
        push dword [dword eax+02BAh]
        push dword [dword eax+02B6h]
        push dword [dword eax+02AAh]
        call DrawArt
        add esp, byte 0Ch
.1:
        call SetScreenTarget
        movsx eax, word [byte esi+0Eh]
        movsx edx, word [byte esi+06h]
        add edx, eax
        push edx
        push eax
        push dword 280h
        push dword 14Ah
        call SetClipWindow
        add esp, byte 10h
        push byte 0
        mov eax, dword [AllStarConference]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call ResetClipWindow
        call PresentScreen
        mov eax, dword [tickcount]
        lea edx, [byte eax+014h]
.2:
        mov eax, dword [tickcount]
        cmp edx, eax
        jle short .3
        call ServiceIdle
        jmp short .2
.3:
        push dword [AllStarConference]
        call SetDrawTarget
        movsx eax, word [byte esi+0Eh]
        movsx edx, word [byte esi+06h]
        add esp, byte 4
        add edx, eax
        push edx
        push eax
        push dword 280h
        push dword 14Ah
        call SetClipWindow
        add esp, byte 10h
        push str_BAK02
        push dword [AllStarScreenBitmap]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        mov eax, dword [AllStarItems]
        add esp, byte 4
        push dword [dword eax+0172h]
        push dword [dword eax+016Eh]
        push dword [dword eax+0162h]
        call DrawArt
        mov eax, dword [AllStarItems]
        add esp, byte 0Ch
        push dword [dword eax+04A6h]
        push dword [dword eax+04A2h]
        push dword [dword eax+0496h]
        call DrawArt
        mov eax, dword [AllStarItems]
        add esp, byte 0Ch
        push dword [dword eax+04F8h]
        push dword [dword eax+04F4h]
        push dword [dword eax+04E8h]
        call DrawArt
        mov eax, dword [AllStarItems]
        add esp, byte 0Ch
        push dword [dword eax+01C4h]
        push dword [dword eax+01C0h]
        push dword [dword eax+01B4h]
        call DrawArt
        mov eax, dword [AllStarItems]
        add esp, byte 0Ch
        cmp dword [dword eax+02AAh], byte 0
        je short .4
        push dword [dword eax+02BAh]
        push dword [dword eax+02B6h]
        push dword [dword eax+02AAh]
        call DrawArt
        add esp, byte 0Ch
.4:
        call ResetClipWindow
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarSlot]
        call LoadTeamLogo
        mov eax, 960000h
        mov ebx, dword [ShadowShape]
        cdq
        movsx ecx, word [byte ebx+04h]
        idiv ecx
        movsx ebx, word [byte ebx+06h]
        imul ebx, eax
        push byte 0
        sar ebx, 10h
        push ebx
        push dword 96h
        mov dword [byte ebp-028h], eax
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [byte ebp-024h], eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        call ClearScreen
        add esp, byte 4
        push byte 0
        push byte 0
        push dword [ShadowShape]
        push dword [byte ebp-028h]
        call DrawShapeBlended
        add esp, byte 10h
        call FreeLogoArt
        push ebx
        push dword 96h
        push dword 0ACh
        mov eax, dword [AllStarConference]
        xor ecx, ecx
        push dword 1F0h
        mov edx, dword [byte eax+02Ch]
        mov eax, dword [byte ebp-024h]
        push byte 0
        mov ebx, 10h
        mov eax, dword [byte eax+02Ch]
        call DrawShadedLogo
        push dword [byte ebp-024h]
        call FreeBitmap
        add esp, byte 4
        mov eax, dword [AllStarTeamList]
        call FreeScrollList
        push byte 0
        push byte 0
        push dword 0B4h
        push dword 80h
        mov eax, dword [AllStarConference]
        push dword 266h
        mov ebx, dword [byte ebp-010h]
        mov ecx, 0Ah
        push dword [byte eax+02Ch]
        mov edx, dword [AllStarItems]
        push byte 0
        add edx, 386h
        mov eax, dword [AllStarTeamList]
        call InitScrollList
        mov edx, dword [AllStarConference]
        mov eax, dword [AllStarTeamList]
        call DrawScrollBar
        push dword [AllStarConference]
        call SetDrawTarget
        mov eax, dword [AllStarTeamBitmap]
        mov eax, dword [byte eax+02Ch]
        add esp, byte 4
        movsx edx, word [byte eax+0Eh]
        push edx
        movsx edx, word [byte eax+0Ch]
        push edx
        push eax
        call ConvertArtXY
        add esp, byte 0Ch
.5:
        push dword [AllStarConference]
        call SetDrawTarget
        add esp, byte 4
        test edi, edi
        jl short .6
        mov eax, dword [AllStarTeamList]
        lea edx, [byte edi+01h]
        sub edx, dword [byte eax+024h]
        imul edx, byte 12h
        add edx, 80h
        push edx
        mov edx, edi
        sub edx, dword [byte eax+024h]
        imul eax, edx, byte 12h
        add eax, 80h
        push eax
        jmp short .7
.6:
        cmp edi, byte 0FFFFFFFEh
        jne short .8
        push dword 134h
        push dword 80h
.7:
        push dword 262h
        push dword 14Ah
        call SetClipWindow
        mov eax, dword [AllStarTeamBitmap]
        add esp, byte 10h
        push dword [byte eax+02Ch]
        call BlitShape
        add esp, byte 4
.8:
        mov eax, dword [AllStarSide]
        imul eax, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov edx, dword [AllStarPlayers]
        movsx eax, word [dword edx+eax+0D05h]
        mov dword [byte ebp-010h], eax
        mov eax, dword [AllStarTeamList]
        mov dword [byte ebp-014h], 80h
        mov eax, dword [byte eax+024h]
        mov dword [byte ebp-018h], 14Eh
        mov dword [byte ebp-0Ch], eax
        jmp near .15
.9:
        test edi, edi
        jl short .10
        cmp edi, dword [byte ebp-0Ch]
        jne near .14
.10:
        mov eax, dword [AllStarSide]
        mov edx, dword [byte ebp-0Ch]
        cmp edx, dword [nosplit eax*4+AllStarSlotFirst]
        jne short .11
        push byte 12h
        push dword 118h
        push dword [byte ebp-014h]
        push dword 0FFFFFF50h
        call MakeColor
        mov edx, dword [AllStarConference]
        mov ebx, 10h
        mov ecx, 14Ah
        mov edx, dword [byte edx+02Ch]
        add esp, byte 4
        mov dword [byte ebp-024h], edx
        mov edx, eax
        mov eax, dword [byte ebp-024h]
        call DrawHighlightBar
.11:
        mov eax, dword [AllStarSide]
        mov edx, dword [byte ebp-0Ch]
        shl eax, 2
        cmp edx, dword [byte ebp-010h]
        jge short .12
        imul edx, dword [dword eax+AllStarSlot], dword 194Fh
        mov ebx, dword [AllStarPlayers]
        add ebx, edx
        imul edx, dword [byte ebp-0Ch], byte 38h
        add edx, ebx
        mov eax, dword [dword eax+AllStarSlot]
        mov bl, byte [dword edx+0D0Bh]
        movzx edx, byte [dword edx+0D0Ah]
        shl eax, 2
        mov dword [byte ebp-020h], edx
        mov edx, dword [AllStarPicks]
        add eax, edx
        imul edx, dword [byte ebp-0Ch], dword 0BCh
        mov eax, dword [eax]
        add eax, edx
        mov byte [byte ebp-08h], bl
        jmp short .13
.12:
        imul edx, dword [dword eax+AllStarSlot], dword 194Fh
        mov ebx, dword [AllStarPlayers]
        add edx, ebx
        mov ebx, dword [byte ebp-0Ch]
        sub ebx, dword [byte ebp-010h]
        imul ecx, ebx, byte 38h
        add edx, ecx
        mov eax, dword [dword eax+AllStarSlot]
        movzx edx, byte [dword edx+01284h]
        shl eax, 2
        mov dword [byte ebp-020h], edx
        mov edx, dword [AllStarPicks]
        add eax, edx
        lea edx, [byte ebx+019h]
        imul edx, dword 0BCh
        mov eax, dword [eax]
        add eax, edx
        mov byte [byte ebp-08h], 47h
.13:
        mov dl, byte [byte eax+018h]
        add eax, byte 8
        mov byte [byte ebp-04h], dl
        mov dword [byte ebp-01Ch], eax
        movzx eax, byte [byte ebp-08h]
        call PositionAbbrev
        movzx eax, al
        push eax
        mov ebx, dword [byte ebp-014h]
        push str_C_DrawAllStarTeam
        add ebx, byte 4
        push ebx
        push dword [byte ebp-018h]
        push byte 0
        call DrawTextAligned
        add esp, byte 14h
        push dword [byte ebp-020h]
        push str_D_DrawAllStarTeam
        mov eax, dword [byte ebp-018h]
        push ebx
        add eax, byte 10h
        push eax
        push byte 0
        call DrawTextAligned
        add esp, byte 14h
        movzx eax, byte [byte ebp-04h]
        push eax
        push str_C
        mov eax, dword [byte ebp-018h]
        push ebx
        add eax, byte 28h
        push eax
        push byte 0
        call DrawTextAligned
        add esp, byte 14h
        push dword [byte ebp-01Ch]
        mov eax, dword [byte ebp-018h]
        push ebx
        add eax, byte 3Ch
        push eax
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
.14:
        inc dword [byte ebp-0Ch]
        add dword [byte ebp-014h], byte 12h
.15:
        mov eax, dword [AllStarTeamList]
        mov eax, dword [byte eax+024h]
        add eax, byte 0Ah
        cmp eax, dword [byte ebp-0Ch]
        jg near .9
        mov edx, edi
        xor ebx, ebx
        xor eax, eax
        call DrawAllStarSelection
        cmp dword [byte ebp-02Ch], byte 0
        je near DrawAllStarTeam_6C5
        call SetScreenTarget
        test edi, edi
        jl short .17
        mov eax, dword [AllStarTeamList]
        lea edx, [byte edi+01h]
        sub edx, dword [byte eax+024h]
        imul edx, byte 12h
        sub edi, dword [byte eax+024h]
        imul eax, edi, byte 12h
        add edx, 80h
        push edx
        add eax, 80h
        push eax
.16:
        push dword 262h
        jmp short .19
.17:
        cmp edi, byte 0FFFFFFFEh
        jne short .18
        push dword 134h
        push dword 80h
        jmp short .16
.18:
        movsx eax, word [byte esi+0Eh]
        movsx edx, word [byte esi+06h]
        add edx, eax
        push edx
        push eax
        push dword 280h
.19:
        push dword 14Ah
DrawAllStarTeam_68E:
        call SetClipWindow
        add esp, byte 10h
        push byte 0
        mov eax, dword [AllStarConference]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        push dword 1E0h
        push byte 0
        push dword 280h
        push byte 0
        call SetClipWindow
        add esp, byte 10h
        call PresentScreen
DrawAllStarTeam_6C5:
        leave
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawAllStarSlot                                 EAE9A  97 PC, low confidence
; Draws an all-star slot
;-----------------------------------------------------------------------------
DrawAllStarSlot:
        push esi
        push edi
        enter 4, 0
        mov edi, eax
        mov esi, edx
        mov eax, dword [AllStarSlotLayer]
        push edx
        mov eax, dword [byte eax+02Ch]
        add esi, byte 4
        push edi
        movsx eax, word [byte eax+06h]
        push dword [AllStarSlotShape]
        mov dword [byte ebp-04h], eax
        call DrawArt
        mov eax, dword [byte ebp-04h]
        add esp, byte 0Ch
        add eax, esi
        push eax
        add edi, byte 6
        push esi
        add ebx, edi
        push ebx
        push edi
        call SetClipWindow
        add esp, byte 10h
        push esi
        mov eax, dword [AllStarSlotLayer]
        push edi
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        push dword 1E0h
        push byte 0
        push dword 280h
        push byte 0
        call SetClipWindow
        add esp, byte 10h
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; DrawAllStarSelection                            EAF08  97 PC, low confidence
; Draws the all-star selection
;-----------------------------------------------------------------------------
DrawAllStarSelection:
        push ecx
        push esi
        push edi
        enter 14h, 0
        push eax
        mov edi, edx
        mov dword [byte ebp-010h], ebx
        push dword [AllStarConference]
        call SetDrawTarget
        add esp, byte 4
        cmp dword [byte ebp-018h], byte 0
        je short .4
        test edi, edi
        jge short .1
        push dword 134h
        push dword 80h
        jmp short .2
.1:
        mov eax, dword [AllStarTeamList]
        lea edx, [byte edi+01h]
        sub edx, dword [byte eax+024h]
        imul edx, byte 12h
        add edx, 80h
        push edx
        mov edx, edi
        sub edx, dword [byte eax+024h]
        imul eax, edx, byte 12h
        add eax, 80h
        push eax
.2:
        push dword 262h
        push dword 1E6h
        call SetClipWindow
        add esp, byte 10h
        cmp dword [byte ebp-010h], byte 0
        je short .3
        mov eax, dword [AllStarTeamBitmap]
        push dword [byte eax+02Ch]
        call BlitShape
        add esp, byte 4
.3:
        push dword 1E0h
        push byte 0
        push dword 280h
        push byte 0
        call SetClipWindow
        add esp, byte 10h
.4:
        mov eax, dword [AllStarSide]
        imul eax, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov dword [byte ebp-04h], 80h
        mov edx, dword [AllStarPlayers]
        mov dword [byte ebp-0Ch], 1E6h
        mov esi, dword [AllStarTeamList]
        movsx eax, word [dword edx+eax+0D05h]
        mov esi, dword [byte esi+024h]
        mov dword [byte ebp-08h], eax
        jmp near .11
.5:
        test edi, edi
        jl short .6
        cmp edi, esi
        jne near .10
.6:
        mov eax, dword [AllStarSide]
        cmp esi, dword [nosplit eax*4+AllStarSlotFirst]
        jne short .7
        cmp dword [byte ebp-010h], byte 0
        je short .7
        push byte 12h
        push byte 7Ch
        push dword [byte ebp-04h]
        push dword 0FFFFFF50h
        call MakeColor
        mov ecx, dword [AllStarConference]
        mov ebx, 10h
        add esp, byte 4
        mov edx, dword [byte ecx+02Ch]
        mov ecx, 1E6h
        mov dword [byte ebp-014h], edx
        mov edx, eax
        mov eax, dword [byte ebp-014h]
        call DrawHighlightBar
.7:
        mov ecx, dword [AllStarSlotLayer]
        mov ecx, dword [byte ecx+02Ch]
        movsx ecx, word [byte ecx+04h]
        cmp esi, dword [byte ebp-08h]
        jge short .8
        cmp dword [AllStarListSide], byte 0
        jne short .8
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarSlot]
        mov edx, dword [AllStarPickOrder]
        shl eax, 2
        add eax, edx
        imul edx, esi, byte 27h
        mov eax, dword [eax]
        add eax, edx
        lea edx, [byte eax+010h]
        mov eax, dword [AllStarListSide]
        mov eax, dword [nosplit eax*4+AllStarListChoice]
        mov eax, dword [nosplit eax*4+AllStarDefenceStatKeys]
        jmp short .9
.8:
        cmp esi, dword [byte ebp-08h]
        jl short .10
        cmp dword [AllStarListSide], byte 1
        jne short .10
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarSlot]
        mov edx, dword [AllStarPickOrder]
        shl eax, 2
        add eax, edx
        mov edx, esi
        sub edx, dword [byte ebp-08h]
        add edx, byte 19h
        imul edx, byte 27h
        mov eax, dword [eax]
        add edx, eax
        mov eax, dword [AllStarListSide]
        mov eax, dword [nosplit eax*4+AllStarListChoice]
        add edx, byte 10h
        mov eax, dword [nosplit eax*4+AllStarForwardStatKeys]
.9:
        movzx eax, byte [edx+eax]
        add eax, byte 0Ah
        imul eax, ecx
        add eax, byte 0Ch
        mov ebx, 19h
        cdq
        idiv ebx
        mov edx, dword [byte ebp-04h]
        mov ebx, eax
        mov eax, dword [byte ebp-0Ch]
        add edx, byte 3
        call DrawAllStarSlot
.10:
        add dword [byte ebp-04h], byte 12h
        inc esi
.11:
        mov eax, dword [AllStarTeamList]
        mov eax, dword [byte eax+024h]
        add eax, byte 0Ah
        cmp esi, eax
        jl near .5
        cmp dword [byte ebp-018h], byte 0
        je short .14
        call SetScreenTarget
        test edi, edi
        jge short .12
        push dword 134h
        push dword 80h
        jmp short .13
.12:
        mov eax, dword [AllStarTeamList]
        lea edx, [byte edi+01h]
        sub edx, dword [byte eax+024h]
        imul edx, byte 12h
        sub edi, dword [byte eax+024h]
        imul edi, byte 12h
        add edx, 80h
        push edx
        add edi, 80h
        push edi
.13:
        push dword 262h
        push dword 1E6h
        call SetClipWindow
        add esp, byte 10h
        push byte 0
        mov eax, dword [AllStarConference]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call ResetClipWindow
        call PresentScreen
.14:
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; DrawAllStarList                                 EB175  97 PC, low confidence
; All-star screen: the "Forwards" / "Defence" / "Goalies" lists
;-----------------------------------------------------------------------------
DrawAllStarList:
        push ebx
        push ecx
        push esi
        push edi
        enter 0Ch, 0
        push eax
        push edx
        push dword [AllStarConference]
        call SetDrawTarget
        add esp, byte 4
        cmp dword [byte ebp-010h], byte 2
        jne near .3
        push str_BAK12
        push dword [AllStarScreenBitmap]
        call FindShape
        add esp, byte 8
        push dword 1E0h
        push byte 0
        push dword 140h
        push byte 0
        mov esi, eax
        mov dword [byte ebp-08h], eax
        call SetClipWindow
        add esp, byte 10h
        push esi
        call BlitShape
        add esp, byte 4
        call ResetClipWindow
        mov eax, dword [AllStarItems]
        cmp dword [dword eax+02AAh], byte 0
        je short .1
        push dword [dword eax+02BAh]
        push dword [dword eax+02B6h]
        push dword [dword eax+02AAh]
        call DrawArt
        add esp, byte 0Ch
.1:
        call SetScreenTarget
        mov eax, dword [byte ebp-08h]
        mov edx, dword [byte ebp-08h]
        movsx eax, word [byte eax+0Eh]
        movsx edx, word [byte edx+06h]
        add edx, eax
        push edx
        push eax
        push dword 140h
        push byte 0
        call SetClipWindow
        add esp, byte 10h
        push byte 0
        mov eax, dword [AllStarConference]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call ResetClipWindow
        call PresentScreen
        mov eax, dword [tickcount]
        lea edx, [byte eax+014h]
.2:
        mov eax, dword [tickcount]
        cmp edx, eax
        jle short .3
        call ServiceIdle
        jmp short .2
.3:
        cmp dword [byte ebp-010h], byte 1
        je near .4
        push dword [AllStarConference]
        call SetDrawTarget
        add esp, byte 4
        push dword 1E0h
        push byte 0
        push dword 0DCh
        push byte 0
        call SetClipWindow
        add esp, byte 10h
        push str_BAK02
        push dword [AllStarScreenBitmap]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        call ResetClipWindow
        mov eax, dword [AllStarSide]
        add eax, byte 1Ah
        call LoadTeamLogo
        mov eax, 8C0000h
        mov esi, dword [ShadowShape]
        cdq
        movsx ebx, word [byte esi+04h]
        idiv ebx
        movsx ebx, word [byte esi+06h]
        imul ebx, eax
        push byte 0
        sar ebx, 10h
        push ebx
        push dword 8Ch
        mov edi, eax
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
        push edi
        call DrawShapeBlended
        add esp, byte 10h
        call FreeLogoArt
        push ebx
        push dword 8Ch
        push dword 0ACh
        xor ecx, ecx
        push byte 0
        mov eax, dword [AllStarConference]
        mov ebx, 10h
        push byte 0
        mov edx, dword [byte eax+02Ch]
        mov eax, dword [byte esi+02Ch]
        call DrawShadedLogo
        push esi
        call FreeBitmap
        add esp, byte 4
        push dword [AllStarConference]
        call SetDrawTarget
        mov eax, dword [AllStarNameBitmap]
        mov eax, dword [byte eax+02Ch]
        add esp, byte 4
        movsx edx, word [byte eax+0Eh]
        push edx
        movsx edx, word [byte eax+0Ch]
        push edx
        push eax
        call ConvertArtXY
        add esp, byte 0Ch
.4:
        cmp dword [byte ebp-014h], byte 0
        jl short .5
        mov eax, dword [byte ebp-014h]
        add eax, byte 1Ch
        imul eax, byte 52h
        mov edi, dword [AllStarItems]
        add edi, eax
        mov eax, dword [byte edi+026h]
        mov edi, dword [byte edi+02Ah]
        mov dword [byte ebp-04h], eax
        lea eax, [byte edi+012h]
        push eax
        mov eax, dword [byte ebp-04h]
        push edi
        add eax, 96h
        push eax
        push dword [byte ebp-04h]
        jmp short .6
.5:
        push dword 1E0h
        push byte 0
        push dword 280h
        push byte 0
.6:
        call SetClipWindow
        add esp, byte 10h
        mov eax, dword [AllStarNameBitmap]
        push dword [byte eax+02Ch]
        call BlitShape
        mov eax, dword [AllStarStatBitmap]
        add esp, byte 4
        push dword [byte eax+02Ch]
        call BlitShape
        mov eax, dword [AllStarListBitmap]
        add esp, byte 4
        push dword [byte eax+02Ch]
        call BlitShape
        add esp, byte 4
        mov eax, 261h
        call GetLangText
        push eax
        push byte 6Eh
        push byte 24h
        push byte 0
        mov esi, eax
        call DrawTextAligned
        add esp, byte 10h
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push eax
        push byte 2
        push esi
        call MeasureText
        add esp, byte 4
        push eax
        push byte 7Eh
        mov dword [byte ebp-04h], 24h
        push byte 24h
        mov edi, 80h
        xor esi, esi
        call FillRect
        add esp, byte 14h
.7:
        lea eax, [byte esi+01h]
        push eax
        push str_D3
        lea eax, [byte edi+04h]
        push eax
        mov eax, dword [byte ebp-04h]
        sub eax, byte 6
        push eax
        push byte 2
        call DrawTextAligned
        add esp, byte 14h
        cmp dword [byte ebp-014h], byte 0
        jl short .8
        cmp esi, dword [byte ebp-014h]
        jne near .10
.8:
        imul edx, esi, dword 125h
        mov eax, dword [AllStarSide]
        shl eax, 2
        mov ebx, dword [dword eax+AllStarLineData]
        cmp byte [dword edx+ebx+0BBh], 0
        je near .10
        cmp esi, dword [dword eax+AllStarSlotPicked]
        jne short .9
        push byte 12h
        push dword 96h
        push edi
        push dword 0FFFFFF50h
        mov ebx, 10h
        call MakeColor
        mov edx, eax
        mov eax, dword [AllStarConference]
        add esp, byte 4
        mov ecx, 0Ah
        mov eax, dword [byte eax+02Ch]
        call DrawHighlightBar
.9:
        imul ebx, esi, dword 125h
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarLineData]
        movzx eax, byte [dword ebx+eax+0BBh]
        push eax
        push str_C
        lea eax, [byte edi+04h]
        push eax
        push dword [byte ebp-04h]
        push byte 0
        mov dword [byte ebp-0Ch], eax
        call DrawTextAligned
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarLineData]
        add eax, 0A3h
        add eax, ebx
        add esp, byte 14h
        add eax, byte 8
        push eax
        push str_S_DrawAllStarList
        mov eax, dword [byte ebp-04h]
        push dword [byte ebp-0Ch]
        add eax, byte 14h
        push eax
        push byte 0
        call DrawTextAligned
        add esp, byte 14h
.10:
        inc esi
        add edi, byte 12h
        cmp esi, byte 0Dh
        jl near .7
        mov eax, 262h
        call GetLangText
        push eax
        push byte 6Eh
        push dword 0C4h
        push byte 0
        mov ebx, eax
        call DrawTextAligned
        add esp, byte 10h
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push eax
        push byte 2
        push ebx
        call MeasureText
        add esp, byte 4
        push eax
        push byte 7Eh
        push dword 0C4h
        mov dword [byte ebp-04h], 0C4h
        mov edi, 80h
        call FillRect
        add esp, byte 14h
        jmp near .15
.11:
        lea eax, [byte esi-0Ch]
        push eax
        push str_D3
        lea eax, [byte edi+04h]
        push eax
        mov eax, dword [byte ebp-04h]
        sub eax, byte 6
        push eax
        push byte 2
        call DrawTextAligned
        add esp, byte 14h
        cmp dword [byte ebp-014h], byte 0
        jl short .12
        cmp esi, dword [byte ebp-014h]
        jne near .14
.12:
        imul edx, esi, dword 125h
        mov eax, dword [AllStarSide]
        shl eax, 2
        mov ebx, dword [dword eax+AllStarLineData]
        cmp byte [dword edx+ebx+0BBh], 0
        je near .14
        cmp esi, dword [dword eax+AllStarSlotPicked]
        jne short .13
        push byte 12h
        push dword 96h
        push edi
        push dword 0FFFFFF50h
        mov ebx, 10h
        call MakeColor
        mov edx, eax
        mov eax, dword [AllStarConference]
        add esp, byte 4
        mov ecx, 0AAh
        mov eax, dword [byte eax+02Ch]
        call DrawHighlightBar
.13:
        imul edx, esi, dword 125h
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarLineData]
        add eax, edx
        movzx eax, byte [dword eax+0BBh]
        push eax
        push str_C
        lea ebx, [byte edi+04h]
        push ebx
        push dword [byte ebp-04h]
        push byte 0
        mov dword [byte ebp-0Ch], edx
        call DrawTextAligned
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarLineData]
        add eax, 0A3h
        add eax, dword [byte ebp-0Ch]
        add esp, byte 14h
        add eax, byte 8
        push eax
        mov eax, dword [byte ebp-04h]
        push ebx
        add eax, byte 14h
        push eax
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
.14:
        inc esi
        add edi, byte 12h
.15:
        cmp esi, byte 13h
        jl near .11
        mov eax, 263h
        call GetLangText
        push eax
        push dword 10Ch
        push dword 0C4h
        push byte 0
        mov ebx, eax
        call DrawTextAligned
        add esp, byte 10h
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push eax
        push byte 2
        push ebx
        call MeasureText
        add esp, byte 4
        push eax
        push dword 11Ch
        mov dword [byte ebp-04h], 0C4h
        push dword 0C4h
        mov edi, 11Eh
        xor esi, esi
        call FillRect
        add esp, byte 14h
.16:
        lea eax, [byte esi+01h]
        push eax
        push str_D3
        lea eax, [byte edi+04h]
        push eax
        mov eax, dword [byte ebp-04h]
        sub eax, byte 6
        push eax
        push byte 2
        call DrawTextAligned
        add esp, byte 14h
        cmp dword [byte ebp-014h], byte 0
        jl short .17
        lea eax, [byte esi+013h]
        cmp eax, dword [byte ebp-014h]
        jne near .19
.17:
        imul edx, esi, dword 125h
        mov eax, dword [AllStarSide]
        shl eax, 2
        mov ebx, dword [dword eax+AllStarLineData]
        cmp byte [dword edx+ebx+01D5Ah], 0
        je near .19
        lea edx, [byte esi+013h]
        cmp edx, dword [dword eax+AllStarSlotPicked]
        jne short .18
        push byte 12h
        push dword 96h
        push edi
        push dword 0FFFFFF50h
        call MakeColor
        mov edx, dword [AllStarConference]
        mov ebx, 10h
        mov ecx, 0AAh
        mov edx, dword [byte edx+02Ch]
        add esp, byte 4
        mov dword [byte ebp-0Ch], edx
        mov edx, eax
        mov eax, dword [byte ebp-0Ch]
        call DrawHighlightBar
.18:
        imul ebx, esi, dword 125h
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarLineData]
        movzx eax, byte [dword ebx+eax+01D5Ah]
        push eax
        push str_C
        lea eax, [byte edi+04h]
        push eax
        push dword [byte ebp-04h]
        push byte 0
        mov dword [byte ebp-0Ch], eax
        call DrawTextAligned
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarLineData]
        add eax, 1D42h
        add eax, ebx
        add esp, byte 14h
        add eax, byte 8
        push eax
        mov eax, dword [byte ebp-04h]
        push dword [byte ebp-0Ch]
        add eax, byte 14h
        push eax
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
.19:
        inc esi
        add edi, byte 12h
        cmp esi, byte 3
        jl near .16
        call ResetClipWindow
        cmp dword [byte ebp-010h], byte 0
        je near DrawAllStarTeam_6C5
        call SetScreenTarget
        cmp dword [byte ebp-014h], byte 0
        jge short .21
        cmp dword [byte ebp-010h], byte 2
        jne short .20
        mov eax, dword [byte ebp-08h]
        mov edx, dword [byte ebp-08h]
        movsx eax, word [byte eax+0Eh]
        movsx edx, word [byte edx+06h]
        add edx, eax
        push edx
        push eax
        push dword 140h
        push byte 0
        jmp near DrawAllStarTeam_68E
.20:
        push dword 16Ah
        push dword 80h
        push dword 140h
        push byte 0Ah
        jmp near DrawAllStarTeam_68E
.21:
        mov edi, dword [byte ebp-014h]
        add edi, byte 1Ch
        imul edi, byte 52h
        mov eax, dword [AllStarItems]
        add edi, eax
        mov eax, dword [byte edi+026h]
        mov edi, dword [byte edi+02Ah]
        mov dword [byte ebp-04h], eax
        lea eax, [byte edi+012h]
        push eax
        mov eax, dword [byte ebp-04h]
        push edi
        add eax, 96h
        push eax
        push dword [byte ebp-04h]
        jmp near DrawAllStarTeam_68E
;-----------------------------------------------------------------------------
; LoadAllStarLogo                                 EB840  97 PC, low confidence
; Loads the all-star logo
;-----------------------------------------------------------------------------
LoadAllStarLogo:
        push ebx
        push ecx
        push edx
        enter 10h, 0
        xor ebx, ebx
.1:
        cmp ebx, byte 14h
        jl short .2
        cmp ebx, byte 15h
        jle short .3
.2:
        push ebx
        jmp short .4
.3:
        mov eax, 29h
        sub eax, ebx
        push eax
.4:
        push str_LB02d7
        lea eax, [byte ebp-010h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-010h]
        push eax
        push dword [AllStarScreenBitmap]
        call FindShape
        mov edx, eax
        movzx eax, byte [dword ebx+AllStarSlotOrder]
        mov eax, dword [nosplit eax*4+AllStarLogoData]
        movzx ecx, byte [dword ebx+AllStarLogoSlots]
        add esp, byte 8
        mov dword [eax+ecx*4], edx
        lea eax, [byte ebp-010h]
        push eax
        push dword [AllStarScreenBitmap]
        mov byte [byte ebp-0Fh], 48h
        call FindShape
        mov edx, eax
        movzx eax, byte [dword ebx+AllStarSlotOrder]
        inc ebx
        mov eax, dword [nosplit eax*4+AllStarLogoTables]
        movzx ecx, byte [dword ebx+AllStarLogoSlotsPrev]
        add esp, byte 8
        mov dword [eax+ecx*4], edx
        cmp ebx, byte 1Ah
        jl near .1
        leave
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadAllStarArt                                  EB8DA  97 PC, low confidence
; Loads the all-star art
;-----------------------------------------------------------------------------
LoadAllStarArt:
        push ebx
        push ecx
        push edx
        push esi
        enter 3Ch, 0
        lea eax, [byte ebp-03Bh]
        mov dword [AllStarDefenceStatKeys], eax
        lea eax, [byte ebp-03Ah]
        mov dword [AllStarDefenceStatKeys+4], eax
        lea eax, [byte ebp-038h]
        mov dword [AllStarDefenceStatKeys+8], eax
        lea eax, [byte ebp-037h]
        mov dword [AllStarDefenceStatKeys+0Ch], eax
        lea eax, [byte ebp-036h]
        mov dword [AllStarDefenceStatKeys+10h], eax
        lea eax, [byte ebp-035h]
        mov dword [AllStarDefenceStatKeys+14h], eax
        lea eax, [byte ebp-034h]
        mov dword [AllStarDefenceStatKeys+18h], eax
        lea eax, [byte ebp-033h]
        mov dword [AllStarDefenceStatKeys+1Ch], eax
        lea eax, [byte ebp-032h]
        mov dword [AllStarDefenceStatKeys+20h], eax
        lea eax, [byte ebp-031h]
        mov dword [AllStarDefenceStatKeys+24h], eax
        lea eax, [byte ebp-030h]
        mov dword [AllStarDefenceStatKeys+28h], eax
        lea eax, [byte ebp-02Fh]
        mov dword [AllStarDefenceStatKeys+2Ch], eax
        lea eax, [byte ebp-02Dh]
        lea esi, [byte ebp-03Ch]
        mov dword [AllStarDefenceStatKeys+30h], eax
        lea eax, [byte ebp-02Ch]
        mov ebx, 0Eh
        mov dword [AllStarDefenceStatKeys+34h], eax
        xor eax, eax
        jmp short .2
.1:
        inc eax
        sub dword [nosplit eax*4+AllStarDefenceKeyBase], esi
.2:
        cmp eax, ebx
        jl short .1
        lea eax, [byte ebp-023h]
        mov dword [AllStarForwardStatKeys], eax
        lea eax, [byte ebp-022h]
        mov dword [AllStarForwardStatKeys+4], eax
        lea eax, [byte ebp-021h]
        mov dword [AllStarForwardStatKeys+8], eax
        lea eax, [byte ebp-020h]
        mov dword [AllStarForwardStatKeys+0Ch], eax
        lea eax, [byte ebp-01Fh]
        mov dword [AllStarForwardStatKeys+10h], eax
        lea eax, [byte ebp-01Eh]
        mov dword [AllStarForwardStatKeys+14h], eax
        lea eax, [byte ebp-01Ch]
        lea esi, [byte ebp-024h]
        mov dword [AllStarForwardStatKeys+18h], eax
        lea eax, [byte ebp-01Bh]
        mov dword [AllStarLists], ebx
        mov dword [AllStarForwardStatKeys+1Ch], eax
        lea eax, [byte ebp-018h]
        mov ebx, 9
        mov dword [AllStarForwardStatKeys+20h], eax
        xor eax, eax
        jmp short .4
.3:
        inc eax
        sub dword [nosplit eax*4+AllStarForwardKeyBase], esi
.4:
        cmp eax, ebx
        jl short .3
        mov dword [AllStarCandidateCount], ebx
        xor ebx, ebx
        jmp short .6
.5:
        push dword [nosplit ebx*4+str_Punct_LoadAllStarArt]
        push str_AR02d3
        lea eax, [byte ebp-010h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-010h]
        push eax
        push dword [AllStarShapeFile]
        mov esi, ebx
        call FindShape
        mov edx, eax
        mov eax, dword [AllStarNameArea]
        add esp, byte 8
        mov dword [eax+esi*4], edx
        lea eax, [byte ebp-010h]
        push eax
        push dword [AllStarShapeFile]
        mov byte [byte ebp-0Fh], 54h
        call FindShape
        mov edx, dword [AllStarPickArea]
        inc ebx
        add esp, byte 8
        mov dword [edx+esi*4], eax
.6:
        cmp ebx, dword [AllStarLists]
        jl short .5
        mov byte [byte ebp-0Eh], 47h
        xor ebx, ebx
        jmp short .8
.7:
        mov al, byte [nosplit ebx*4+AllStarArtDigits]
        add al, 30h
        mov byte [byte ebp-0Dh], al
        lea eax, [byte ebp-010h]
        push eax
        mov byte [byte ebp-0Fh], 52h
        push dword [AllStarShapeFile]
        mov esi, ebx
        call FindShape
        mov edx, eax
        mov eax, dword [AllStarTeamArea]
        add esp, byte 8
        mov dword [eax+esi*4], edx
        lea eax, [byte ebp-010h]
        push eax
        push dword [AllStarShapeFile]
        mov byte [byte ebp-0Fh], 54h
        call FindShape
        mov edx, dword [AllStarSlotArea]
        inc ebx
        add esp, byte 8
        mov dword [edx+esi*4], eax
.8:
        cmp ebx, dword [AllStarCandidateCount]
        jl short .7
        jmp near AllStarSound_1E0
;-----------------------------------------------------------------------------
; AllStarNextTeam                                 EBA9B  97 PC, low confidence
; Switches to the next all-star team
;-----------------------------------------------------------------------------
AllStarNextTeam:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        mov eax, dword [AllStarSide]
        shl eax, 2
        mov ecx, dword [AllStarListSide]
        cmp dword [dword eax+AllStarSlotPicked], byte 0
        jl short .1
        mov edx, dword [dword eax+AllStarSlotPicked]
        mov dword [dword eax+AllStarSlotPicked], 0FFFFFFFFh
        mov eax, 1
        call DrawAllStarList
.1:
        mov eax, dword [AllStarSide]
        shl eax, 2
        cmp ebx, dword [dword eax+AllStarSlotFirst]
        je near .3
        mov edx, dword [dword eax+AllStarSlotFirst]
        mov dword [dword eax+AllStarSlotFirst], ebx
        test edx, edx
        jl short .2
        mov eax, 1
        call DrawAllStarTeam
.2:
        mov eax, dword [AllStarSide]
        mov edx, dword [nosplit eax*4+AllStarSlotFirst]
        mov eax, 1
        call DrawAllStarTeam
        mov eax, dword [AllStarSide]
        imul ebx, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov edx, dword [AllStarPlayers]
        movsx edx, word [dword edx+ebx+0D05h]
        cmp edx, dword [nosplit eax*4+AllStarSlotFirst]
        setle al
        movzx eax, al
        mov dword [AllStarListSide], eax
        cmp ecx, eax
        je short .3
        mov eax, 1
        mov ebx, 1
        mov edx, 0FFFFFFFFh
        call DrawAllStarHighlight
        mov eax, ebx
        call DrawAllStarSelection
.3:
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AllStarPrevTeam                                 EBB68  97 PC, low confidence
; Switches to the previous all-star team
;-----------------------------------------------------------------------------
AllStarPrevTeam:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        mov eax, dword [AllStarSide]
        shl eax, 2
        mov ecx, dword [AllStarListSide]
        cmp dword [dword eax+AllStarSlotFirst], byte 0
        jl short .1
        mov edx, dword [dword eax+AllStarSlotFirst]
        mov dword [dword eax+AllStarSlotFirst], 0FFFFFFFFh
        mov eax, 1
        call DrawAllStarTeam
.1:
        mov eax, dword [AllStarSide]
        shl eax, 2
        cmp ebx, dword [dword eax+AllStarSlotPicked]
        je short .3
        mov edx, dword [dword eax+AllStarSlotPicked]
        mov dword [dword eax+AllStarSlotPicked], ebx
        test edx, edx
        jl short .2
        mov eax, 1
        call DrawAllStarList
.2:
        mov eax, dword [AllStarSide]
        mov edx, dword [nosplit eax*4+AllStarSlotPicked]
        mov eax, 1
        call DrawAllStarList
        mov eax, dword [AllStarSide]
        cmp dword [nosplit eax*4+AllStarSlotPicked], byte 13h
        setge al
        movzx eax, al
        mov dword [AllStarListSide], eax
        cmp ecx, eax
        je short .3
        mov eax, 1
        mov ebx, 1
        mov edx, 0FFFFFFFFh
        call DrawAllStarHighlight
        mov eax, ebx
        call DrawAllStarSelection
.3:
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AllStarNextSlot                                 EBC19  97 PC, low confidence
; Moves to the next all-star slot
;-----------------------------------------------------------------------------
AllStarNextSlot:
        push ebx
        push edx
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarSlot]
        mov edx, eax
.1:
        cmp eax, byte 19h
        jge short .2
        movzx ebx, byte [dword eax+AllStarSlotOrderNext]
        inc eax
        cmp ebx, dword [AllStarSide]
        jne short .1
        mov edx, eax
.2:
        mov eax, edx
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AllStarPrevSlot                                 EBC45  97 PC, low confidence
; Moves to the previous all-star slot
;-----------------------------------------------------------------------------
AllStarPrevSlot:
        push ebx
        push edx
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarSlot]
        mov edx, eax
.1:
        test eax, eax
        jle short .2
        movzx ebx, byte [dword eax+AllStarSlotOrderPrev]
        dec eax
        cmp ebx, dword [AllStarSide]
        jne short .1
        mov edx, eax
.2:
        mov eax, edx
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ClearAllStarPicks                               EBC70  97 PC, low confidence
; Clears the all-star picks
;-----------------------------------------------------------------------------
ClearAllStarPicks:
        push ebx
        push edx
        xor eax, eax
.1:
        imul ebx, eax, dword 125h
        mov edx, dword [AllStarSide]
        mov edx, dword [nosplit edx*4+AllStarLineData]
        mov byte [dword edx+ebx+0BBh], 0
        mov edx, dword [AllStarSide]
        mov edx, dword [nosplit edx*4+AllStarLineData]
        mov byte [dword edx+ebx+0ABh], 0
        mov edx, dword [AllStarSide]
        mov edx, dword [nosplit edx*4+AllStarLineData]
        inc eax
        mov byte [dword edx+ebx+0160h], 0
        cmp eax, byte 19h
        jl short .1
        xor eax, eax
.2:
        imul ebx, eax, dword 125h
        mov edx, dword [AllStarSide]
        mov edx, dword [nosplit edx*4+AllStarLineData]
        mov byte [dword edx+ebx+01D5Ah], 0
        mov edx, dword [AllStarSide]
        mov edx, dword [nosplit edx*4+AllStarLineData]
        inc eax
        mov byte [dword edx+ebx+01D4Ah], 0
        cmp eax, byte 3
        jl short .2
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AllStarPicksDone                                EBCFA  97 PC, low confidence
; Returns whether the all-star picks are complete
;-----------------------------------------------------------------------------
AllStarPicksDone:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, 1
        xor edx, edx
.1:
        xor eax, eax
.2:
        imul esi, eax, dword 125h
        mov ecx, dword [nosplit edx*4+AllStarLineData]
        cmp byte [dword ecx+esi+0BBh], 0
        jne short .3
        xor ebx, ebx
.3:
        inc eax
        cmp eax, byte 13h
        jl short .2
        xor eax, eax
.4:
        imul ecx, eax, dword 125h
        mov esi, dword [nosplit edx*4+AllStarLineData]
        cmp byte [dword ecx+esi+01D5Ah], 0
        jne short .5
        xor ebx, ebx
.5:
        inc eax
        cmp eax, byte 3
        jl short .4
        inc edx
        cmp edx, byte 2
        jl short .1
        mov eax, ebx
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FindAllStarPick                                 EBD54  97 PC, low confidence
; Finds an all-star pick
;-----------------------------------------------------------------------------
FindAllStarPick:
        push ebx
        push ecx
        push esi
        mov ecx, edx
        mov ebx, 0FFFFFFFFh
        jmp short .3
.1:
        mov edx, dword [AllStarSide]
        mov esi, dword [nosplit edx*4+AllStarLineData]
        imul edx, eax, dword 125h
        cmp byte [dword edx+esi+0BBh], 0
        jne short .2
        mov ebx, eax
        jmp short .4
.2:
        inc eax
.3:
        cmp eax, ecx
        jl short .1
.4:
        mov eax, ebx
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FindFreeAllStarSlot                             EBD8C  97 PC, low confidence
; Finds a free all-star slot
;-----------------------------------------------------------------------------
FindFreeAllStarSlot:
        push ebx
        push ecx
        push edx
        mov edx, 0FFFFFFFFh
        xor eax, eax
.1:
        mov ebx, dword [AllStarSide]
        mov ecx, dword [nosplit ebx*4+AllStarLineData]
        imul ebx, eax, dword 125h
        cmp byte [dword ecx+ebx+01D5Ah], 0
        jne short .2
        mov edx, eax
        jmp short FindFreeAllStarSlot_31
.2:
        inc eax
        cmp eax, byte 3
        jl short .1
FindFreeAllStarSlot_31:
        mov eax, edx
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AllStarPickTaken                                EBDC3  97 PC, low confidence
; Returns whether a player is already picked
;-----------------------------------------------------------------------------
AllStarPickTaken:
        push ebx
        push ecx
        push esi
        push edi
        enter 14h, 0
        mov edi, eax
        mov ecx, edx
        mov eax, dword [AllStarSide]
        imul eax, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov edx, dword [AllStarPlayers]
        movsx eax, word [dword edx+eax+0D05h]
        xor esi, esi
        cmp edi, eax
        jge near .4
        xor ebx, ebx
.1:
        mov eax, dword [AllStarSide]
        shl eax, 2
        mov edx, dword [dword eax+AllStarLineData]
        mov dword [byte ebp-010h], edx
        imul edx, ebx, dword 125h
        mov dword [byte ebp-0Ch], edx
        mov edx, dword [byte ebp-010h]
        add edx, dword [byte ebp-0Ch]
        cmp byte [dword edx+0160h], 0
        je short .3
        imul edx, edi, byte 38h
        imul eax, dword [dword eax+AllStarSlot], dword 194Fh
        mov dword [byte ebp-014h], eax
        mov eax, dword [AllStarPlayers]
        add eax, dword [byte ebp-014h]
        add eax, 0D09h
        add eax, edx
        lea edx, [byte eax+018h]
        mov eax, dword [byte ebp-010h]
        add eax, 0A3h
        add eax, dword [byte ebp-0Ch]
        call KeysEqual
        test eax, eax
        je short .3
.2:
        inc esi
        mov dword [ecx], ebx
        jmp near .7
.3:
        inc ebx
        cmp ebx, byte 13h
        jl short .1
        jmp short .7
.4:
        xor ebx, ebx
        sub edi, eax
.5:
        mov eax, dword [AllStarSide]
        shl eax, 2
        mov edx, dword [dword eax+AllStarLineData]
        mov dword [byte ebp-04h], edx
        imul edx, ebx, dword 125h
        mov dword [byte ebp-08h], edx
        mov edx, dword [byte ebp-04h]
        add edx, dword [byte ebp-08h]
        cmp byte [dword edx+01D5Ah], 0
        je short .6
        imul eax, dword [dword eax+AllStarSlot], dword 194Fh
        mov edx, dword [AllStarPlayers]
        add eax, edx
        imul edx, edi, byte 38h
        add eax, 1283h
        add eax, edx
        lea edx, [byte eax+018h]
        mov eax, dword [byte ebp-04h]
        add eax, 1D42h
        add eax, dword [byte ebp-08h]
        call KeysEqual
        test eax, eax
        je short .6
        add ebx, byte 13h
        jmp short .2
.6:
        inc ebx
        cmp ebx, byte 3
        jl short .5
.7:
        mov eax, esi
        jmp near DrawAllStarTeam_6C5
;-----------------------------------------------------------------------------
; AllStarPickPlayer                               EBEDA  97 PC, low confidence
; Picks a player for the all-star team
;-----------------------------------------------------------------------------
AllStarPickPlayer:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        mov edx, 0FFFFFFFFh
        cmp eax, byte 16h
        jl short .1
        xor ebx, eax
.1:
        mov eax, ebx
        jmp short .4
.2:
        mov ecx, dword [AllStarSide]
        mov esi, dword [nosplit ecx*4+AllStarLineData]
        imul ecx, eax, dword 125h
        cmp byte [dword ecx+esi+0BBh], 0
        je short .3
        mov edx, eax
        jmp short .5
.3:
        inc eax
.4:
        cmp eax, byte 13h
        jl short .2
.5:
        test edx, edx
        jge short .9
        lea eax, [byte ebx-013h]
        test eax, eax
        jge short .8
        xor eax, eax
        jmp short .8
.6:
        mov ecx, dword [AllStarSide]
        mov esi, dword [nosplit ecx*4+AllStarLineData]
        imul ecx, eax, dword 125h
        cmp byte [dword ecx+esi+01D5Ah], 0
        je short .7
        lea edx, [byte eax+013h]
        jmp short .9
.7:
        inc eax
.8:
        cmp eax, byte 3
        jl short .6
.9:
        test edx, edx
        jge short .14
        lea ecx, [byte ebx-01h]
        cmp ecx, byte 13h
        jle short .10
        mov ecx, 13h
.10:
        xor eax, eax
        jmp short .13
.11:
        imul edi, eax, dword 125h
        mov esi, dword [AllStarSide]
        mov esi, dword [nosplit esi*4+AllStarLineData]
        add esi, edi
        cmp byte [dword esi+0BBh], 0
        je short .12
        mov edx, eax
        jmp short .14
.12:
        inc eax
.13:
        cmp eax, ecx
        jl short .11
.14:
        test edx, edx
        jge short .19
        lea ecx, [byte ebx-014h]
        cmp ecx, byte 3
        jle short .15
        mov ecx, 3
.15:
        xor eax, eax
        jmp short .18
.16:
        mov ebx, dword [AllStarSide]
        mov esi, dword [nosplit ebx*4+AllStarLineData]
        imul ebx, eax, dword 125h
        cmp byte [dword esi+ebx+01D5Ah], 0
        je short .17
        lea edx, [byte eax+013h]
        jmp short .19
.17:
        inc eax
.18:
        cmp eax, ecx
        jl short .16
.19:
        mov eax, edx
        jmp near PickAllStarPlayers_4C3
;-----------------------------------------------------------------------------
; AllStarAddPick                                  EBFCE  97 PC, low confidence
; Adds an all-star pick
;-----------------------------------------------------------------------------
AllStarAddPick:
        push ebx
        push ecx
        push esi
        push edi
        enter 8, 0
        push eax
        mov eax, dword [AllStarSide]
        mov ebx, dword [nosplit eax*4+AllStarSlot]
        mov esi, dword [AllStarPicks]
        shl ebx, 2
        add ebx, esi
        imul esi, edx, dword 0BCh
        mov ebx, dword [ebx]
        add ebx, esi
        mov dword [byte ebp-08h], ebx
        imul ebx, dword [byte ebp-0Ch], dword 125h
        mov esi, dword [nosplit eax*4+AllStarLineData]
        mov ecx, 2Fh
        lea edi, [dword esi+ebx+0A3h]
        mov esi, dword [byte ebp-08h]
        rep movsd
        mov eax, dword [AllStarSide]
        imul esi, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov edi, dword [AllStarPlayers]
        add esi, edi
        imul edi, edx, byte 38h
        mov eax, dword [nosplit eax*4+AllStarLineData]
        mov cl, byte [dword edi+esi+0D0Ah]
        mov byte [dword ebx+eax+015Fh], cl
        mov eax, dword [AllStarSide]
        imul esi, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov ecx, dword [AllStarPlayers]
        add esi, ecx
        mov eax, dword [nosplit eax*4+AllStarLineData]
        mov cl, byte [dword edi+esi+0D0Bh]
        mov byte [dword ebx+eax+0160h], cl
        mov eax, dword [AllStarSide]
        imul esi, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov ecx, dword [AllStarPlayers]
        mov eax, dword [nosplit eax*4+AllStarLineData]
        add esi, ecx
        add ebx, eax
        mov al, byte [dword edi+esi+0D09h]
        mov byte [dword ebx+0161h], al
        xor ebx, ebx
        imul ecx, dword [byte ebp-0Ch], dword 125h
.1:
        mov eax, dword [AllStarSide]
        imul edi, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov esi, dword [AllStarPlayers]
        add edi, esi
        imul esi, edx, byte 38h
        add esi, edi
        imul edi, ebx, byte 7
        mov eax, dword [nosplit eax*4+AllStarLineData]
        add eax, ecx
        add esi, edi
        lea edi, [dword edi+eax+01B2h]
        lea esi, [dword esi+0D0Ch]
        mov dword [byte ebp-04h], ecx
        inc ebx
        movsd
        movsw
        movsb
        cmp ebx, byte 3
        jl short .1
        mov eax, dword [AllStarSide]
        mov ebx, dword [nosplit eax*4+AllStarSlot]
        mov esi, dword [AllStarCandidates]
        shl ebx, 2
        add ebx, esi
        imul esi, edx, byte 3Dh
        imul edx, byte 27h
        mov ebx, dword [ebx]
        add ebx, esi
        mov esi, dword [nosplit eax*4+AllStarLineData]
        add esi, ecx
        mov ecx, 21h
        lea edi, [dword esi+0164h]
        lea esi, [byte ebx+018h]
        rep movsb
        mov eax, dword [AllStarSide]
        mov ebx, dword [AllStarPickOrder]
        mov edi, dword [nosplit eax*4+AllStarLineData]
        mov esi, dword [nosplit eax*4+AllStarSlot]
        add edi, dword [byte ebp-04h]
        mov esi, dword [ebx+esi*4]
        lea edi, [dword edi+0189h]
        lea esi, [byte edx+esi+010h]
        movsd
        movsd
        movsd
        movsd
        movsd
        movsw
        movsb
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarLineData]
        add eax, 0A3h
        mov ebx, 12h
        add eax, dword [byte ebp-04h]
        xor edx, edx
        add eax, 0FDh
        call memset_
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarLineData]
        add eax, dword [byte ebp-04h]
        mov byte [dword eax+01C7h], 0
        jmp near DrawAllStarTeam_6C5
;-----------------------------------------------------------------------------
; AllStarRemovePick                               EC19E  97 PC, low confidence
; Removes an all-star pick
;-----------------------------------------------------------------------------
AllStarRemovePick:
        push ebx
        push ecx
        push esi
        push edi
        enter 8, 0
        push eax
        mov eax, dword [AllStarSide]
        mov esi, dword [nosplit eax*4+AllStarSlot]
        mov ebx, dword [AllStarPicks]
        shl esi, 2
        add ebx, esi
        lea esi, [byte edx+019h]
        imul esi, dword 0BCh
        mov ebx, dword [ebx]
        add ebx, esi
        mov dword [byte ebp-08h], ebx
        imul ebx, dword [byte ebp-0Ch], dword 125h
        mov esi, dword [nosplit eax*4+AllStarLineData]
        mov ecx, 2Fh
        lea edi, [dword esi+ebx+01D42h]
        mov esi, dword [byte ebp-08h]
        rep movsd
        mov eax, dword [AllStarSide]
        imul esi, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov edi, dword [AllStarPlayers]
        add esi, edi
        imul edi, edx, byte 38h
        mov eax, dword [nosplit eax*4+AllStarLineData]
        mov cl, byte [dword edi+esi+01284h]
        mov byte [dword ebx+eax+01DFEh], cl
        mov eax, dword [AllStarSide]
        imul esi, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov ecx, dword [AllStarPlayers]
        mov eax, dword [nosplit eax*4+AllStarLineData]
        add esi, ecx
        add eax, ebx
        mov bl, byte [dword edi+esi+01283h]
        mov byte [dword eax+01E00h], bl
        xor ebx, ebx
        imul ecx, dword [byte ebp-0Ch], dword 125h
.1:
        mov eax, dword [AllStarSide]
        imul esi, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov edi, dword [AllStarPlayers]
        add edi, esi
        imul esi, edx, byte 38h
        add esi, edi
        imul edi, ebx, byte 7
        mov eax, dword [nosplit eax*4+AllStarLineData]
        add eax, ecx
        add esi, edi
        lea edi, [dword edi+eax+01E51h]
        lea esi, [dword esi+01286h]
        mov dword [byte ebp-04h], ecx
        inc ebx
        movsd
        movsw
        movsb
        cmp ebx, byte 3
        jl short .1
        mov eax, dword [AllStarSide]
        mov esi, dword [AllStarCandidates]
        mov ebx, dword [nosplit eax*4+AllStarSlot]
        add edx, byte 19h
        shl ebx, 2
        mov dword [byte ebp-08h], edx
        add ebx, esi
        imul esi, edx, byte 3Dh
        mov edi, dword [nosplit eax*4+AllStarLineData]
        add edi, ecx
        mov edx, dword [ebx]
        mov ecx, 25h
        lea edi, [dword edi+01E03h]
        lea esi, [byte edx+esi+018h]
        rep movsb
        mov eax, dword [AllStarSide]
        mov edx, dword [nosplit eax*4+AllStarSlot]
        mov ebx, dword [AllStarPickOrder]
        shl edx, 2
        add edx, ebx
        imul ebx, dword [byte ebp-08h], byte 27h
        mov edi, dword [nosplit eax*4+AllStarLineData]
        add edi, dword [byte ebp-04h]
        mov esi, dword [edx]
        lea edi, [dword edi+01E28h]
        lea esi, [byte esi+ebx+010h]
        movsd
        movsd
        movsd
        movsd
        movsw
        movsb
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarLineData]
        add eax, 1D42h
        xor edx, edx
        add eax, dword [byte ebp-04h]
        mov ebx, 0Dh
        add eax, 0FDh
        call memset_
        mov eax, dword [AllStarSide]
        mov eax, dword [nosplit eax*4+AllStarLineData]
        add eax, dword [byte ebp-04h]
        mov byte [dword eax+01E66h], 0
        jmp near DrawAllStarTeam_6C5
;-----------------------------------------------------------------------------
; AllStarTogglePick                               EC34D  97 PC, low confidence
; Picks or removes an all-star player
;-----------------------------------------------------------------------------
AllStarTogglePick:
        push ebx
        push ecx
        push edx
        push esi
        enter 84h, 0
        sub ebp, 82h
        mov eax, dword [AllStarSide]
        shl eax, 2
        imul ebx, dword [dword eax+AllStarSlot], dword 194Fh
        mov edx, dword [AllStarPlayers]
        add ebx, edx
        movsx edx, word [dword ebx+0D05h]
        cmp edx, dword [dword eax+AllStarSlotFirst]
        jle near .7
        imul edx, dword [dword eax+AllStarSlotFirst], byte 38h
        add ebx, edx
        test byte [dword ebx+0D09h], 4
        je short .1
        mov eax, 0C0h
        call GetLangText
        push eax
        mov eax, 0C7h
        call GetLangText
        push eax
        lea eax, [byte ebp-02h]
        push eax
        mov edx, 1
        call sprintf_
        add esp, byte 0Ch
        xor ecx, ecx
        xor ebx, ebx
        push byte 1
        lea eax, [byte ebp-02h]
        mov esi, 0FFFFFFFFh
        jmp short .5
.1:
        cmp byte [dword ebx+0D0Bh], 44h
        jne short .6
        lea edx, [byte ebp+07Eh]
        mov eax, dword [dword eax+AllStarSlotFirst]
        call AllStarPickTaken
        test eax, eax
        jne near .9
        mov edx, 13h
        mov eax, 0Dh
        call FindAllStarPick
        mov esi, eax
        test eax, eax
        jl short .3
.2:
        mov ebx, dword [AllStarSide]
        mov edx, dword [nosplit ebx*4+AllStarSlotFirst]
        call AllStarAddPick
        jmp near .10
.3:
        push byte 1
        mov eax, 1C3h
.4:
        mov edx, 1
        xor ecx, ecx
        xor ebx, ebx
        call GetLangText
.5:
        call ShowMessageBox
        jmp near .10
.6:
        lea edx, [byte ebp+07Eh]
        mov eax, dword [dword eax+AllStarSlotFirst]
        call AllStarPickTaken
        test eax, eax
        jne near .9
        mov edx, 0Dh
        call FindAllStarPick
        mov esi, eax
        test eax, eax
        jge short .2
        push byte 1
        mov eax, 1C4h
        jmp short .4
.7:
        lea edx, [byte ebp+07Eh]
        mov eax, dword [dword eax+AllStarSlotFirst]
        call AllStarPickTaken
        test eax, eax
        jne short .9
        call FindFreeAllStarSlot
        mov ebx, eax
        mov esi, eax
        test eax, eax
        jl short .8
        mov eax, dword [AllStarSide]
        imul esi, dword [nosplit eax*4+AllStarSlot], dword 194Fh
        mov edx, dword [AllStarPlayers]
        movsx edx, word [dword edx+esi+0D05h]
        mov eax, dword [nosplit eax*4+AllStarSlotFirst]
        sub eax, edx
        mov edx, eax
        mov eax, ebx
        call AllStarRemovePick
        lea esi, [byte ebx+013h]
        jmp short .10
.8:
        push byte 1
        mov eax, 1C5h
        jmp near .4
.9:
        mov esi, dword [byte ebp+07Eh]
.10:
        mov eax, esi
        lea esp, [dword ebp+082h]
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AllStarSlotPosition                             EC4DB  97 PC, low confidence
; Returns the position of an all-star slot
;-----------------------------------------------------------------------------
AllStarSlotPosition:
        push edx
        mov eax, dword [AllStarSide]
        shl eax, 2
        cmp dword [dword eax+AllStarSlotPicked], byte 13h
        jge short .1
        mov edx, dword [dword eax+AllStarLineData]
        imul eax, dword [dword eax+AllStarSlotPicked], dword 125h
        mov byte [dword edx+eax+0BBh], 0
        mov eax, dword [AllStarSide]
        mov edx, dword [nosplit eax*4+AllStarLineData]
        imul eax, dword [nosplit eax*4+AllStarSlotPicked], dword 125h
        mov byte [dword edx+eax+0ABh], 0
        mov eax, dword [AllStarSide]
        mov edx, dword [nosplit eax*4+AllStarLineData]
        imul eax, dword [nosplit eax*4+AllStarSlotPicked], dword 125h
        mov byte [dword edx+eax+0160h], 0
        pop edx
        ret
.1:
        mov edx, dword [dword eax+AllStarSlotPicked]
        sub edx, byte 13h
        imul edx, dword 125h
        mov eax, dword [dword eax+AllStarLineData]
        mov byte [dword edx+eax+01D5Ah], 0
        mov eax, dword [AllStarSide]
        mov edx, dword [nosplit eax*4+AllStarSlotPicked]
        sub edx, byte 13h
        imul edx, dword 125h
        mov eax, dword [nosplit eax*4+AllStarLineData]
        mov byte [dword edx+eax+01D4Ah], 0
        pop edx
        ret
;-----------------------------------------------------------------------------
; CompareAllStarGoalie                            EC588  97 PC, low confidence
; Sort helper: goalies first for the all-star picks
;-----------------------------------------------------------------------------
CompareAllStarGoalie:
        push ebx
        push ecx
        mov ebx, eax
        mov eax, edx
        mov edx, ebx
        cmp byte [byte ebx+0Ah], 44h
        sete bl
        movzx ebx, bl
        mov ecx, ebx
        cmp byte [byte eax+0Ah], 44h
        sete bl
        movzx ebx, bl
        xor ebx, ecx
        jne short .5
        mov bx, word [eax]
        cmp bx, word [edx]
        jne short .4
        mov bx, word [byte eax+02h]
        cmp bx, word [byte edx+02h]
        jne short .3
        mov bx, word [byte eax+04h]
        cmp bx, word [byte edx+04h]
        jne short .1
        movsx eax, word [byte eax+06h]
        movsx edx, word [byte edx+06h]
        sub edx, eax
        mov eax, edx
        pop ecx
        pop ebx
        ret
.1:
        movsx ebx, bx
        movsx eax, word [byte edx+04h]
.2:
        sub ebx, eax
        mov eax, ebx
        pop ecx
        pop ebx
        ret
.3:
        movsx ebx, bx
        movsx eax, word [byte edx+02h]
        jmp short .2
.4:
        movsx eax, bx
        movsx edx, word [edx]
        sub eax, edx
        pop ecx
        pop ebx
        ret
.5:
        cmp byte [byte eax+0Ah], 44h
        jne short .6
        mov eax, 0FFFFFFFFh
        pop ecx
        pop ebx
        ret
.6:
        mov eax, 1
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CompareAllStarKey                               EC60D  97 PC, low confidence
; Sort helper: compares all-star picks by key
;-----------------------------------------------------------------------------
CompareAllStarKey:
        push ebx
        mov bl, byte [byte eax+0Ah]
        cmp bl, byte [byte edx+0Ah]
        jne short .6
        mov bx, word [edx]
        cmp bx, word [eax]
        jne short .5
        mov bx, word [byte edx+02h]
        cmp bx, word [byte eax+02h]
        jne short .4
        mov bx, word [byte edx+04h]
        cmp bx, word [byte eax+04h]
        jne short .2
        movsx ebx, word [byte eax+06h]
        movsx eax, word [byte edx+06h]
.1:
        sub ebx, eax
        mov eax, ebx
        pop ebx
        ret
.2:
        movsx edx, bx
        movsx eax, word [byte eax+04h]
.3:
        sub edx, eax
        mov eax, edx
        pop ebx
        ret
.4:
        movsx edx, bx
        movsx eax, word [byte eax+02h]
        jmp short .3
.5:
        movsx ebx, word [eax]
        movsx eax, word [edx]
        jmp short .1
.6:
        cmp bl, 47h
        jne short .7
        mov eax, 0FFFFFFFFh
        pop ebx
        ret
.7:
        mov eax, 1
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AddAllStarCandidate                             EC671  97 PC, low confidence
; Adds an all-star candidate
;-----------------------------------------------------------------------------
AddAllStarCandidate:
        push esi
        push edi
        enter 14h, 0
        push eax
        push ecx
        mov dword [byte ebp-0Ch], 0
        mov dword [byte ebp-04h], ebx
        mov dword [byte ebp-08h], edx
        jmp near .9
.1:
        imul ebx, dword [byte ebp-08h], byte 0Bh
        add ebx, dword [byte ebp+010h]
        xor esi, esi
        movzx eax, byte [byte ebx+08h]
        xor ecx, ecx
        mov dword [byte ebp-010h], eax
        movzx ebx, byte [byte ebx+09h]
.2:
        imul edi, ecx, dword 125h
        mov eax, dword [byte ebp-018h]
        cmp byte [dword edi+eax+0160h], 0
        je short .3
        imul eax, dword [byte ebp-010h], dword 194Fh
        mov dword [byte ebp-014h], eax
        mov edx, dword [byte ebp-014h]
        mov eax, dword [AllStarPlayers]
        add edx, eax
        imul eax, ebx, byte 38h
        add edx, 0D09h
        add eax, edx
        lea edx, [byte eax+018h]
        mov eax, dword [byte ebp-018h]
        add eax, 0A3h
        add eax, edi
        call KeysEqual
        test eax, eax
        je short .3
        inc esi
        jmp short .4
.3:
        inc ecx
        cmp ecx, byte 13h
        jl short .2
.4:
        test esi, esi
        jne near .8
        imul edx, dword [byte ebp-010h], dword 194Fh
        mov eax, dword [AllStarPlayers]
        add eax, edx
        imul edx, ebx, byte 38h
        test byte [dword edx+eax+0D09h], 4
        jne near .8
.5:
        imul eax, dword [byte ebp-04h], dword 125h
        add eax, dword [byte ebp-018h]
        cmp byte [dword eax+0160h], 0
        je short .6
        inc dword [byte ebp-04h]
        jmp short .5
.6:
        imul edi, ebx, dword 0BCh
        mov edx, dword [byte ebp-010h]
        mov ecx, dword [AllStarPicks]
        mov esi, dword [ecx+edx*4]
        mov ecx, 2Fh
        add esi, edi
        lea edi, [dword eax+0A3h]
        rep movsd
        imul esi, ebx, byte 27h
        mov ecx, dword [AllStarPickOrder]
        mov ecx, dword [ecx+edx*4]
        lea edi, [dword eax+0189h]
        lea esi, [byte ecx+esi+010h]
        movsd
        movsd
        movsd
        movsd
        movsd
        movsw
        movsb
        imul esi, ebx, byte 3Dh
        mov ecx, dword [AllStarCandidates]
        mov edx, dword [ecx+edx*4]
        lea esi, [byte edx+esi+018h]
        imul edx, dword [byte ebp-08h], byte 0Bh
        lea edi, [dword eax+0164h]
        mov ecx, 21h
        rep movsb
        imul esi, dword [byte ebp-010h], dword 194Fh
        imul edi, ebx, byte 38h
        add edx, dword [byte ebp+010h]
        mov dl, byte [byte edx+0Ah]
        mov byte [dword eax+0160h], dl
        mov edx, dword [AllStarPlayers]
        add edx, esi
        mov dl, byte [dword edx+edi+0D0Ah]
        mov byte [dword eax+015Fh], dl
        mov edx, dword [AllStarPlayers]
        add edx, esi
        mov dl, byte [dword edx+edi+0D09h]
        and dl, 0FDh
        xor ecx, ecx
        mov byte [dword eax+0161h], dl
.7:
        imul eax, dword [byte ebp-010h], dword 194Fh
        imul edi, ecx, byte 7
        mov edx, dword [AllStarPlayers]
        add eax, edx
        imul edx, ebx, byte 38h
        add eax, edx
        lea esi, [eax+edi]
        imul eax, dword [byte ebp-04h], dword 125h
        add eax, dword [byte ebp-018h]
        lea esi, [dword esi+0D0Ch]
        lea edi, [dword edi+eax+01B2h]
        inc ecx
        movsd
        movsw
        movsb
        cmp ecx, byte 3
        jl short .7
        inc dword [byte ebp-04h]
        inc dword [byte ebp-0Ch]
.8:
        inc dword [byte ebp-08h]
.9:
        mov eax, dword [byte ebp-0Ch]
        cmp eax, dword [byte ebp-01Ch]
        jl near .1
        leave
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; PickAllStarCandidates                           EC82C  97 PC, low confidence
; Picks the all-star candidates
;-----------------------------------------------------------------------------
PickAllStarCandidates:
        push ebx
        push ecx
        push esi
        push edi
        enter 10h, 0
        push eax
        push edx
        mov dword [byte ebp-08h], 0
        xor ebx, ebx
        jmp near .9
.1:
        imul eax, dword [byte ebp-08h], byte 0Bh
        add eax, dword [byte ebp-018h]
        xor esi, esi
        xor ecx, ecx
        movzx edx, byte [byte eax+08h]
        movzx eax, byte [byte eax+09h]
        mov dword [byte ebp-04h], edx
        mov dword [byte ebp-0Ch], eax
.2:
        imul edi, ecx, dword 125h
        mov eax, dword [byte ebp-014h]
        cmp byte [dword edi+eax+01D5Ah], 0
        je short .3
        imul eax, dword [byte ebp-04h], dword 194Fh
        mov edx, dword [AllStarPlayers]
        add edx, eax
        imul eax, dword [byte ebp-0Ch], byte 38h
        add edx, 1283h
        add eax, edx
        lea edx, [byte eax+018h]
        mov eax, dword [byte ebp-014h]
        add eax, 1D42h
        mov dword [byte ebp-010h], eax
        mov eax, edi
        add eax, dword [byte ebp-010h]
        call KeysEqual
        test eax, eax
        je short .3
        inc esi
        jmp short .4
.3:
        inc ecx
        cmp ecx, byte 3
        jl short .2
.4:
        test esi, esi
        jne near .8
        imul edx, dword [byte ebp-04h], dword 194Fh
        mov eax, dword [AllStarPlayers]
        add edx, eax
        imul eax, dword [byte ebp-0Ch], byte 38h
        test byte [dword edx+eax+01283h], 4
        jne near .8
.5:
        imul eax, ebx, dword 125h
        add eax, dword [byte ebp-014h]
        cmp byte [dword eax+01D5Ah], 0
        je short .6
        cmp ebx, byte 3
        jge short .6
        inc ebx
        jmp short .5
.6:
        cmp ebx, byte 3
        je near DrawAllStarTeam_6C5
        mov edx, dword [byte ebp-04h]
        mov eax, dword [AllStarPicks]
        mov esi, dword [eax+edx*4]
        imul eax, ebx, dword 125h
        mov ecx, dword [byte ebp-0Ch]
        add ecx, byte 19h
        mov dword [byte ebp-010h], ecx
        imul ecx, dword 0BCh
        add eax, dword [byte ebp-014h]
        lea edi, [dword eax+01D42h]
        add esi, ecx
        mov ecx, 2Fh
        rep movsd
        imul esi, dword [byte ebp-010h], byte 27h
        mov ecx, dword [AllStarPickOrder]
        mov ecx, dword [ecx+edx*4]
        lea edi, [dword eax+01E28h]
        lea esi, [byte ecx+esi+010h]
        movsd
        movsd
        movsd
        movsd
        movsw
        movsb
        imul esi, dword [byte ebp-010h], byte 3Dh
        mov ecx, dword [AllStarCandidates]
        mov edx, dword [ecx+edx*4]
        lea edi, [dword eax+01E03h]
        mov ecx, 25h
        lea esi, [byte edx+esi+018h]
        rep movsb
        imul edi, dword [byte ebp-04h], dword 194Fh
        imul esi, dword [byte ebp-0Ch], byte 38h
        mov edx, dword [AllStarPlayers]
        add edx, edi
        mov dl, byte [dword edx+esi+01284h]
        mov byte [dword eax+01DFEh], dl
        mov ecx, dword [AllStarPlayers]
        add ecx, edi
        mov dl, byte [dword ecx+esi+01283h]
        and dl, 0FDh
        xor ecx, ecx
        mov byte [dword eax+01E00h], dl
        imul edx, dword [byte ebp-04h], dword 194Fh
.7:
        imul esi, dword [byte ebp-0Ch], byte 38h
        imul edi, ecx, byte 7
        mov eax, dword [AllStarPlayers]
        add eax, edx
        add esi, eax
        imul eax, ebx, dword 125h
        add esi, edi
        add eax, dword [byte ebp-014h]
        lea esi, [dword esi+01286h]
        lea edi, [dword edi+eax+01E51h]
        inc ecx
        movsd
        movsw
        movsb
        cmp ecx, byte 3
        jl short .7
        inc ebx
.8:
        inc dword [byte ebp-08h]
.9:
        cmp ebx, byte 3
        jl near .1
        jmp near DrawAllStarTeam_6C5
        push ebx
        push ecx
        push edx
        mov ecx, eax
        xor eax, eax
        xor edx, edx
.10:
        imul ebx, eax, dword 125h
        cmp byte [dword ecx+ebx+0160h], 0
        je short .11
        inc edx
.11:
        inc eax
        cmp eax, byte 0Dh
        jl short .10
        jmp near FindFreeAllStarSlot_31
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov eax, 0Dh
        xor edx, edx
.12:
        imul ebx, eax, dword 125h
        cmp byte [dword ecx+ebx+0160h], 0
        je short .13
        inc edx
.13:
        inc eax
        cmp eax, byte 13h
        jl short .12
        jmp near FindFreeAllStarSlot_31
        push ebx
        push ecx
        mov ebx, eax
        mov ecx, edx
        xor eax, eax
        jmp short .15
.14:
        imul edx, eax, byte 0Bh
        cmp byte [byte edx+ebx+0Ah], 44h
        je short .16
        inc eax
.15:
        cmp eax, ecx
        jl short .14
.16:
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PickAllStarPlayers                              ECA57  97 PC, low confidence
; Allocates "all star player info" / "all star goalie info", sorts the
; season's players and goalies (qsort) and picks the All-Stars
;-----------------------------------------------------------------------------
PickAllStarPlayers:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 40h, 0
        mov eax, dword [SeasonUserTeam]
        mov edi, 0DF7h
        mov dword [byte ebp-020h], 1ADh
        movsx eax, word [eax]
        mov dword [byte ebp-010h], 0
        mov dword [byte ebp-018h], eax
.1:
        push byte 0
        push edi
        push str_AllStarPlayerInfo
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword [byte ebp-020h]
        mov esi, dword [byte ebp-010h]
        push str_AllStarGoalieInfo
        mov ebx, edi
        mov dword [byte ebp+esi*4-040h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        xor edx, edx
        mov dword [byte ebp+esi*4-028h], eax
        mov eax, dword [byte ebp+esi*4-040h]
        call memset_
        mov ebx, dword [byte ebp-020h]
        mov eax, dword [byte ebp+esi*4-028h]
        xor edx, edx
        inc dword [byte ebp-010h]
        call memset_
        cmp dword [byte ebp-010h], byte 2
        jl short .1
        mov dword [byte ebp-038h], 0
        mov dword [byte ebp-02Ch], 0
        mov dword [byte ebp-030h], 0
        mov dword [byte ebp-010h], 0
        mov dword [byte ebp-034h], 0
        jmp near .11
.2:
        mov ecx, eax
        mov eax, dword [AllStarPicks]
        mov ebx, dword [byte ebp-010h]
        mov eax, dword [eax+ecx*4]
        mov dword [byte ebp-0Ch], 0
        mov dword [byte ebp-01Ch], eax
        mov eax, dword [AllStarCandidates]
        movzx ebx, byte [dword ebx+AllStarSlotOrder]
        mov ecx, dword [eax+ecx*4]
        jmp near .4
.3:
        imul eax, dword [byte ebp-0Ch], byte 3Dh
        imul edx, dword [byte ebp+ebx*4-030h], byte 0Bh
        mov esi, dword [byte ebp+ebx*4-040h]
        add eax, ecx
        add esi, edx
        mov dx, word [byte eax+01Eh]
        mov word [esi], dx
        imul edx, dword [byte ebp+ebx*4-030h], byte 0Bh
        mov esi, dword [byte ebp+ebx*4-040h]
        add esi, edx
        mov dx, word [byte eax+01Ah]
        mov word [byte esi+02h], dx
        imul edx, dword [byte ebp+ebx*4-030h], byte 0Bh
        mov dword [byte ebp-014h], edx
        mov esi, dword [byte ebp-014h]
        mov edx, dword [byte ebp+ebx*4-040h]
        add esi, edx
        mov dx, word [byte eax+028h]
        mov word [byte esi+04h], dx
        imul esi, dword [byte ebp-0Ch], dword 0BCh
        add esi, dword [byte ebp-01Ch]
        movzx dx, byte [byte esi+08h]
        and dl, 0DFh
        sub edx, byte 41h
        shl edx, 0Ah
        mov dword [byte ebp-08h], edx
        movzx dx, byte [byte esi+09h]
        and dl, 0DFh
        sub edx, byte 41h
        shl edx, 5
        movzx si, byte [byte esi+0Ah]
        mov dword [byte ebp-04h], edx
        mov edx, dword [byte ebp-08h]
        and esi, byte 0FFFFFFDFh
        or edx, dword [byte ebp-04h]
        sub esi, byte 41h
        or edx, esi
        mov dword [byte ebp-04h], edx
        imul edx, dword [byte ebp+ebx*4-030h], byte 0Bh
        mov esi, dword [byte ebp+ebx*4-040h]
        add edx, esi
        mov esi, dword [byte ebp-04h]
        mov word [byte edx+06h], si
        imul esi, dword [byte ebp+ebx*4-030h], byte 0Bh
        mov edx, dword [byte ebp+ebx*4-040h]
        add esi, edx
        mov dl, byte [byte ebp-010h]
        mov byte [byte esi+08h], dl
        imul edx, dword [byte ebp+ebx*4-030h], byte 0Bh
        mov esi, dword [byte ebp+ebx*4-040h]
        add esi, edx
        mov dl, byte [byte ebp-0Ch]
        mov byte [byte esi+09h], dl
        imul esi, dword [byte ebp+ebx*4-030h], byte 0Bh
        mov edx, dword [AllStarPlayers]
        add edx, edi
        imul edi, dword [byte ebp-0Ch], byte 38h
        add edi, edx
        mov edx, dword [byte ebp+ebx*4-040h]
        add esi, edx
        mov dl, byte [dword edi+0D0Bh]
        mov byte [byte esi+0Ah], dl
        inc dword [byte ebp-0Ch]
        inc dword [byte ebp+ebx*4-030h]
.4:
        imul edi, dword [byte ebp-010h], dword 194Fh
        mov eax, dword [AllStarPlayers]
        movsx eax, word [dword edi+eax+0D05h]
        cmp eax, dword [byte ebp-0Ch]
        jg near .3
        mov dword [byte ebp-0Ch], 0
        jmp near .10
.5:
        mov esi, dword [byte ebp-0Ch]
        add esi, byte 19h
        imul esi, byte 3Dh
        mov eax, ebx
        add esi, ecx
        shl eax, 2
        cmp word [byte esi+018h], byte 0
        jne short .6
        imul edx, dword [byte eax+ebp-038h], byte 0Bh
        mov eax, dword [byte eax+ebp-028h]
        mov word [edx+eax], 7FFFh
        jmp short .7
.6:
        imul edx, dword [byte eax+ebp-038h], byte 0Bh
        mov eax, dword [byte eax+ebp-028h]
        add eax, edx
        mov dx, word [byte esi+030h]
        mov word [eax], dx
.7:
        mov eax, dword [byte ebp-0Ch]
        add eax, byte 19h
        imul eax, byte 3Dh
        mov esi, ebx
        add eax, ecx
        shl esi, 2
        cmp word [byte eax+032h], byte 0
        jle short .8
        movsx edx, word [byte eax+034h]
        imul edx, dword 3E8h
        movsx eax, word [byte eax+032h]
        mov dword [byte ebp-014h], eax
        mov eax, edx
        cdq
        idiv dword [byte ebp-014h]
        mov edi, eax
        imul eax, dword [byte esi+ebp-038h], byte 0Bh
        mov edx, dword [byte esi+ebp-028h]
        mov word [byte edx+eax+02h], di
        jmp short .9
.8:
        imul eax, dword [byte esi+ebp-038h], byte 0Bh
        mov edx, dword [byte esi+ebp-028h]
        mov word [byte edx+eax+02h], 0
.9:
        imul esi, dword [byte ebp+ebx*4-038h], byte 0Bh
        mov eax, dword [byte ebp-0Ch]
        add eax, byte 19h
        imul edx, eax, byte 3Dh
        mov dword [byte ebp-014h], esi
        mov esi, dword [byte ebp+ebx*4-028h]
        add esi, dword [byte ebp-014h]
        mov dx, word [byte ecx+edx+018h]
        mov word [byte esi+04h], dx
        imul esi, eax, dword 0BCh
        add esi, dword [byte ebp-01Ch]
        movzx di, byte [byte esi+09h]
        movzx dx, byte [byte esi+08h]
        and edi, byte 0FFFFFFDFh
        and dl, 0DFh
        sub edi, byte 41h
        sub edx, byte 41h
        shl edi, 5
        shl edx, 0Ah
        or edi, edx
        movzx dx, byte [byte esi+0Ah]
        and dl, 0DFh
        mov esi, edi
        sub edx, byte 41h
        or esi, edx
        imul edx, dword [byte ebp+ebx*4-038h], byte 0Bh
        mov dword [byte ebp-04h], esi
        mov esi, dword [byte ebp+ebx*4-028h]
        add edx, esi
        mov esi, dword [byte ebp-04h]
        mov word [byte edx+06h], si
        imul esi, dword [byte ebp+ebx*4-038h], byte 0Bh
        mov edx, dword [byte ebp+ebx*4-028h]
        add esi, edx
        mov dl, byte [byte ebp-010h]
        mov byte [byte esi+08h], dl
        imul esi, dword [byte ebp+ebx*4-038h], byte 0Bh
        mov edx, dword [byte ebp+ebx*4-028h]
        add esi, edx
        mov dl, byte [byte ebp-0Ch]
        mov byte [byte esi+09h], dl
        imul esi, dword [byte ebp+ebx*4-038h], byte 0Bh
        mov edx, dword [byte ebp+ebx*4-028h]
        mov byte [byte edx+esi+0Ah], 47h
        inc dword [byte ebp-0Ch]
        inc dword [byte ebp+ebx*4-038h]
.10:
        imul eax, dword [byte ebp-010h], dword 194Fh
        mov edx, dword [AllStarPlayers]
        movsx eax, word [dword edx+eax+01281h]
        cmp eax, dword [byte ebp-0Ch]
        jg near .5
        inc dword [byte ebp-010h]
.11:
        mov eax, dword [byte ebp-010h]
        cmp eax, dword [byte ebp-018h]
        jl near .2
        mov dword [byte ebp-010h], 0
.12:
        mov esi, dword [byte ebp-010h]
        mov ecx, CompareAllStarGoalie
        mov ebx, 0Bh
        mov edx, dword [byte ebp+esi*4-030h]
        mov eax, dword [byte ebp+esi*4-040h]
        call qsort_
        mov ecx, CompareAllStarKey
        mov ebx, 0Bh
        mov edx, dword [byte ebp+esi*4-038h]
        mov eax, dword [byte ebp+esi*4-028h]
        inc dword [byte ebp-010h]
        call qsort_
        cmp dword [byte ebp-010h], byte 2
        jl short .12
        mov dword [byte ebp-010h], 0
.13:
        cmp dword [byte ebp-010h], byte 0
        jne short .14
        mov esi, AutoLineData
        jmp short .15
.14:
        mov esi, homelines
.15:
        mov word [dword esi+01D40h], 3
        mov ecx, esi
        mov word [dword esi+0A1h], 13h
        xor edx, edx
        xor eax, eax
.16:
        imul ebx, eax, dword 125h
        cmp byte [dword ecx+ebx+0160h], 0
        je short .17
        inc edx
.17:
        inc eax
        cmp eax, byte 0Dh
        jl short .16
        mov eax, dword [byte ebp-010h]
        mov ecx, 0Dh
        xor ebx, ebx
        push dword [byte ebp+eax*4-040h]
        sub ecx, edx
        mov eax, esi
        xor edx, edx
        call AddAllStarCandidate
        mov eax, 0Dh
        mov ecx, esi
        xor edx, edx
        or byte [dword esi+0F1Dh], 2
.18:
        imul ebx, eax, dword 125h
        cmp byte [dword ecx+ebx+0160h], 0
        je short .19
        inc edx
.19:
        inc eax
        cmp eax, byte 13h
        jl short .18
        mov eax, dword [byte ebp-010h]
        mov dword [byte ebp-018h], edx
        mov ebx, dword [byte ebp+eax*4-040h]
        mov ecx, dword [byte ebp+eax*4-030h]
        xor edx, edx
        jmp short .21
.20:
        imul eax, edx, byte 0Bh
        cmp byte [byte ebx+eax+0Ah], 44h
        je short .22
        inc edx
.21:
        cmp edx, ecx
        jl short .20
.22:
        mov edi, dword [byte ebp-010h]
        mov ecx, 6
        mov ebx, 6
        mov eax, esi
        push dword [byte ebp+edi*4-040h]
        sub ecx, dword [byte ebp-018h]
        call AddAllStarCandidate
        mov eax, esi
        mov edx, dword [byte ebp+edi*4-028h]
        mov dword [byte ebp-0Ch], 0
        call PickAllStarCandidates
        or byte [dword esi+0204Ah], 2
        jmp short .24
.23:
        imul edx, dword [byte ebp-0Ch], dword 125h
        lea eax, [dword esi+01D42h]
        add edx, eax
        movsx eax, word [byte esi+066h]
        call SetMatchupTeams
        mov edx, eax
        mov eax, dword [byte ebp-0Ch]
        inc dword [byte ebp-0Ch]
        mov word [dword esi+eax*2+020B1h], dx
.24:
        movsx eax, word [dword esi+01D40h]
        cmp eax, dword [byte ebp-0Ch]
        jg short .23
        inc dword [byte ebp-010h]
        cmp dword [byte ebp-010h], byte 2
        jl near .13
        call ClearAndBuildLines
        mov dword [byte ebp-010h], 0
.25:
        mov esi, dword [byte ebp-010h]
        push dword [byte ebp+esi*4-040h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+esi*4-028h]
        inc dword [byte ebp-010h]
        call FreeMemBlock
        add esp, byte 4
        cmp dword [byte ebp-010h], byte 2
        jl short .25
PickAllStarPlayers_4C2:
        leave
PickAllStarPlayers_4C3:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; InitAllStarTeams                                ECF20  97 PC, low confidence
; Names the two teams "West All Stars" / "East All Stars" and clears them
;-----------------------------------------------------------------------------
InitAllStarTeams:
        push ebx
        push edx
        push esi
        push edi
        mov edi, SeasonFileName
        mov esi, DbKeyBuffer
        movsd
        movsd
        mov esi, dword [SeasonUserTeam]
        mov edi, AllStarTeamIds
        lea esi, [byte esi+04h]
        movsd
        movsd
        call GetAllStarDate
        mov edi, AllStarHomeLines
        mov esi, DbKeyBuffer
        mov word [AllStarTeamCode], 131Eh
        mov word [AllStarDay], ax
        movsd
        movsd
        mov edi, AllStarAwayLines
        mov esi, DbKeyBuffer
        mov ebx, 2123h
        xor edx, edx
        movsd
        movsd
        mov eax, AutoLineData
        mov byte [PeriodAwayTeam], 0
        mov byte [PeriodHomeTeam], 0
        call memset_
        mov ebx, 2123h
        mov eax, homelines
        xor edx, edx
        call memset_
        mov ebx, 36h
        mov edx, 0FFh
        mov eax, HomeGoalieIndex
        call memset_
        mov ebx, 36h
        mov edx, 0FFh
        mov eax, AwayGoalieIndex
        call memset_
        mov edx, str_WestAllStars
        mov eax, AllStarRoster
        call strcpy_
        mov edx, str_EastAllStars
        mov eax, HomeTeamName
        call strcpy_
        mov eax, AutoLineData
        call BuildAllStarRecords
        mov eax, homelines
        call BuildAllStarRecords
        mov word [IndexEntryList], 1Ah
        mov word [HomeTeamCode], 1Bh
        mov word [AllStarArena], 15h
        mov word [GameLogCount], 0
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AllocAllStarRosters                             ED01F  97 PC, low confidence
; Allocates the "all star rosters", "all star airecs", "all star raw plrs"
; and "all star statrecs" blocks and fills them from the season database
;-----------------------------------------------------------------------------
AllocAllStarRosters:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 24h, 0
        mov dword [byte ebp-024h], 0
        mov dword [byte ebp-020h], 0
        xor ebx, ebx
.1:
        movzx edx, byte [dword ebx+AllStarSlotOrder]
        mov eax, edx
        mov ecx, dword [byte ebp+edx*4-024h]
        imul edx, byte 0Dh
        lea esi, [byte ecx+01h]
        mov byte [dword ecx+edx+AllStarSlotPlayers], bl
        inc ebx
        mov dword [byte ebp+eax*4-024h], esi
        cmp ebx, byte 1Ah
        jl short .1
        xor ebx, ebx
.2:
        xor ecx, ecx
.3:
        imul eax, ebx, byte 0Dh
        movzx eax, byte [dword ecx+eax+AllStarSlotPlayers]
        mov byte [dword eax+AllStarLogoSlots], cl
        inc ecx
        cmp ecx, byte 0Dh
        jl short .3
        inc ebx
        cmp ebx, byte 2
        jl short .2
        mov ebx, 1
        jmp short .5
.4:
        mov dword [AllStarSide], ebx
        mov dword [nosplit ebx*4+AllStarSlot], 0FFFFFFFFh
        call AllStarNextSlot
        dec ebx
        mov edx, eax
        mov eax, dword [AllStarSide]
        mov dword [nosplit ebx*4+AllStarRosterBase], 0
        mov dword [nosplit ebx*4+AllStarCandidateCount], 0
        mov dword [nosplit eax*4+AllStarSlotFirst], 0
        mov dword [nosplit eax*4+AllStarSlotPicked], 0FFFFFFFFh
        mov dword [nosplit eax*4+AllStarSlot], edx
.5:
        test ebx, ebx
        jge short .4
        mov esi, dword [SeasonUserTeam]
        mov dword [AllStarLineData], AutoLineData
        mov dword [AllStarLineDataAway], homelines
        movsx esi, word [esi]
        imul eax, esi, dword 194Fh
        push byte 0
        push eax
        push str_AllStarRosters
        call AllocMemBlock
        mov dword [AllStarPlayers], eax
        imul eax, esi, dword 444h
        mov ebx, esi
        add esp, byte 0Ch
        shl ebx, 2
        push byte 0
        add eax, ebx
        push eax
        push str_AllStarAirecs
        call AllocMemBlock
        mov dword [AllStarPickOrder], eax
        imul eax, esi, dword 1490h
        add esp, byte 0Ch
        push byte 0
        add eax, ebx
        push eax
        push str_AllStarRawPlrs
        call AllocMemBlock
        mov dword [AllStarPicks], eax
        imul eax, esi, dword 6ACh
        add esp, byte 0Ch
        push byte 0
        add eax, ebx
        push eax
        push str_AllStarStatrecs
        call AllocMemBlock
        mov edi, dword [AllStarPickOrder]
        mov edx, dword [AllStarPicks]
        add esp, byte 0Ch
        mov dword [AllStarCandidates], eax
        add edi, ebx
        add edx, ebx
        add eax, ebx
        mov dword [byte ebp-04h], edx
        mov dword [byte ebp-08h], eax
        xor ebx, ebx
        jmp short .7
.6:
        imul eax, ebx, dword 444h
        mov ecx, ebx
        lea edx, [edi+eax]
        mov eax, dword [AllStarPickOrder]
        mov dword [eax+ecx*4], edx
        imul eax, ebx, dword 1490h
        mov edx, dword [byte ebp-04h]
        add edx, eax
        mov eax, dword [AllStarPicks]
        mov dword [eax+ecx*4], edx
        imul edx, ebx, dword 6ACh
        mov eax, dword [AllStarCandidates]
        add edx, dword [byte ebp-08h]
        inc ebx
        mov dword [eax+ecx*4], edx
.7:
        cmp ebx, esi
        jl short .6
        mov eax, 1E4h
        mov edx, esi
        call GetLangText
        call ShowWorkingBox
        xor ebx, ebx
        jmp near .13
.8:
        lea eax, [byte ebx+01h]
        imul edx, ebx, dword 194Fh
        call UpdateWorkingBox
        mov eax, dword [AllStarPlayers]
        mov ecx, ebx
        add edx, eax
        mov eax, dword [SeasonUserTeam]
        shl ecx, 3
        mov eax, dword [byte eax+01Ch]
        add eax, ecx
        call FindGameRecord
        mov ecx, dword [AllStarPicks]
        mov eax, ebx
        mov edx, dword [ecx+eax*4]
        mov edi, dword [AllStarPickOrder]
        mov dword [byte ebp-04h], edx
        mov edx, dword [AllStarCandidates]
        mov edi, dword [edi+eax*4]
        mov eax, dword [edx+eax*4]
        xor ecx, ecx
        mov dword [byte ebp-08h], eax
        jmp short .10
.9:
        imul edx, ecx, dword 0BCh
        mov dword [byte ebp-01Ch], edx
        mov edx, dword [byte ebp-04h]
        add edx, dword [byte ebp-01Ch]
        mov dword [byte ebp-01Ch], edx
        imul edx, ecx, byte 38h
        add eax, 0D09h
        mov dword [byte ebp-018h], edx
        add eax, edx
        mov edx, dword [byte ebp-01Ch]
        add eax, byte 18h
        call FindPlayerRecord
        imul edx, ecx, byte 27h
        mov eax, dword [AllStarPlayers]
        add eax, dword [byte ebp-010h]
        add eax, 0D09h
        add eax, dword [byte ebp-018h]
        add eax, byte 18h
        add edx, edi
        call FindPlayerStat
        imul edx, ecx, byte 3Dh
        mov eax, dword [AllStarPlayers]
        add eax, dword [byte ebp-010h]
        add eax, 0D09h
        add eax, dword [byte ebp-018h]
        add edx, dword [byte ebp-08h]
        add eax, byte 20h
        inc ecx
        call FindTeamStat
.10:
        imul eax, ebx, dword 194Fh
        mov dword [byte ebp-010h], eax
        mov eax, dword [AllStarPlayers]
        add eax, dword [byte ebp-010h]
        movsx edx, word [dword eax+0D05h]
        cmp ecx, edx
        jl near .9
        xor ecx, ecx
        jmp short .12
.11:
        lea edx, [byte ecx+019h]
        mov dword [byte ebp-01Ch], edx
        imul edx, dword 0BCh
        mov dword [byte ebp-018h], edx
        mov edx, dword [byte ebp-04h]
        add edx, dword [byte ebp-018h]
        mov dword [byte ebp-014h], edx
        imul edx, ecx, byte 38h
        add eax, 1283h
        mov dword [byte ebp-018h], edx
        add eax, edx
        mov edx, dword [byte ebp-014h]
        add eax, byte 18h
        call FindPlayerRecord
        imul edx, dword [byte ebp-01Ch], byte 27h
        mov eax, dword [AllStarPlayers]
        add eax, dword [byte ebp-0Ch]
        add eax, 1283h
        add eax, dword [byte ebp-018h]
        add eax, byte 18h
        add edx, edi
        call FindPlayerStat
        imul edx, dword [byte ebp-01Ch], byte 3Dh
        mov eax, dword [AllStarPlayers]
        add eax, dword [byte ebp-0Ch]
        add eax, 1283h
        add eax, dword [byte ebp-018h]
        add edx, dword [byte ebp-08h]
        add eax, byte 20h
        inc ecx
        call FindTeamStat
.12:
        imul eax, ebx, dword 194Fh
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [AllStarPlayers]
        add eax, dword [byte ebp-0Ch]
        movsx edx, word [dword eax+01281h]
        cmp ecx, edx
        jl near .11
        inc ebx
.13:
        cmp ebx, esi
        jl near .8
        call HideWorkingBox
        jmp near PickAllStarPlayers_4C2
        push ecx
        push edx
        push dword [AllStarCandidates]
        call FreeMemBlock
        add esp, byte 4
        push dword [AllStarPicks]
        call FreeMemBlock
        add esp, byte 4
        push dword [AllStarPickOrder]
        call FreeMemBlock
        add esp, byte 4
        push dword [AllStarPlayers]
        call FreeMemBlock
        jmp near BuildAllStarTeams_4B
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
;-----------------------------------------------------------------------------
; DrawAllStarPickList                             ED3C1  97 PC, low confidence
; Draws the list of all-star picks
;-----------------------------------------------------------------------------
DrawAllStarPickList:
        push ebx
        push ecx
        push edx
        mov eax, dword [AllStarSide]
        shl eax, 2
        cmp dword [dword eax+AllStarSlotFirst], byte 0
        jl near .2
        imul edx, dword [dword eax+AllStarSlot], dword 194Fh
        mov ebx, dword [AllStarPlayers]
        add edx, ebx
        movsx ebx, word [dword edx+0D05h]
        movsx edx, word [dword edx+01281h]
        add edx, ebx
        cmp edx, dword [dword eax+AllStarSlotFirst]
        jle near .2
        push str_MB005
        mov ecx, str_MB005
        mov edx, dword [AllStarItems]
        mov eax, dword [AllStarShapeFile]
        add edx, 290h
        mov ebx, ecx
        mov dword [AllStarSoundState], 1
.1:
        call InitShapeListBox
        push dword [AllStarConference]
        call SetDrawTarget
        mov eax, dword [AllStarItems]
        add esp, byte 4
        push dword [dword eax+02BAh]
        push dword [dword eax+02B6h]
        push dword [dword eax+02AAh]
        call DrawArt
        add esp, byte 0Ch
        call SetScreenTarget
        mov eax, dword [AllStarItems]
        push dword [dword eax+02BAh]
        push dword [dword eax+02B6h]
        push dword [dword eax+02AAh]
        call DrawArt
        add esp, byte 0Ch
        call PresentScreen
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        mov eax, dword [AllStarSide]
        shl eax, 2
        cmp dword [dword eax+AllStarSlotPicked], byte 0
        jl short .3
        cmp dword [dword eax+AllStarSlotPicked], byte 16h
        jge short .3
        push str_MB044
        mov ecx, str_MB044
        mov edx, dword [AllStarItems]
        mov eax, dword [AllStarShapeFile]
        add edx, 290h
        mov ebx, ecx
        mov dword [AllStarSoundState], 0FFFFFFFFh
        jmp near .1
.3:
        mov eax, dword [AllStarItems]
        mov dword [AllStarSoundState], 0
        cmp dword [dword eax+02AAh], byte 0
        je near .4
        push dword [AllStarConference]
        call SetDrawTarget
        add esp, byte 4
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, dword [AllStarItems]
        mov edx, dword [dword eax+02AAh]
        movsx ebx, word [byte edx+06h]
        push ebx
        movsx edx, word [byte edx+04h]
        push edx
        push dword [dword eax+02BAh]
        push dword [dword eax+02B6h]
        call FillRect
        add esp, byte 14h
        call SetScreenTarget
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, dword [AllStarItems]
        mov edx, dword [dword eax+02AAh]
        movsx ebx, word [byte edx+06h]
        push ebx
        movsx edx, word [byte edx+04h]
        push edx
        push dword [dword eax+02BAh]
        push dword [dword eax+02B6h]
        call FillRect
        add esp, byte 14h
        call PresentScreen
.4:
        mov eax, dword [AllStarItems]
        add eax, 290h
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
        db 00h,00h,00h,00h,00h,00h,00h
        push ebx
        push ecx
        push edx
        push esi
        mov eax, 84h
        call AllocNetBuffer
        mov ecx, eax
        mov esi, eax
        test eax, eax
        je near .5
        mov ebx, 84h
        xor edx, edx
        call memset_
        mov dword [ecx], 524546h
        mov dword [byte ecx+04h], 84h
        mov dword [byte ecx+08h], 64h
        mov dword [byte ecx+014h], 0C0000h
        mov ah, byte [byte ecx+0Ch]
        mov dword [byte ecx+018h], 400h
        or ah, 0Fh
        mov dword [byte ecx+01Ch], 0
        mov dl, ah
        mov byte [byte ecx+0Ch], ah
        and dl, 0EFh
        lea eax, [byte ecx+024h]
        mov byte [byte ecx+0Ch], dl
        mov edx, str_FrANKGBarchard
        mov dword [byte ecx+020h], 0
        call strcpy_
        mov edx, str_100
        lea eax, [byte ecx+044h]
        call strcpy_
        mov edx, str_REF
        lea eax, [byte ecx+04Ch]
        call strcpy_
        mov edx, str_Refpack
        lea eax, [byte ecx+054h]
        call strcpy_
        mov edx, str_Refpack
        lea eax, [byte ecx+064h]
        call strcpy_
.5:
        mov eax, esi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
        push ebx
        push ecx
        push edx
        mov ebx, eax
        mov edx, 2
        call ReadBigEndian
        xor ecx, ecx
        cmp eax, 10FBh
        je short .6
        mov edx, 2
        mov eax, ebx
        call ReadBigEndian
        cmp eax, 11FBh
        jne short .7
.6:
        mov ecx, 64h
.7:
        mov eax, ecx
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push edx
        mov ebx, eax
        mov edx, 2
        call ReadBigEndian
        cmp eax, 10FBh
        jne short .8
        mov edx, 3
        lea eax, [byte ebx+02h]
        jmp short .9
.8:
        mov edx, 3
        lea eax, [byte ebx+05h]
.9:
        call ReadBigEndian
        pop edx
        pop ebx
        ret
