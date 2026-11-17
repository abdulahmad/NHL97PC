; Season menus: new season, season menu screens.
bits 32
%include "hockey.inc"
section s_8E997 progbits alloc exec nowrite align=1
extern _dos_gettime_, AddPlayerStat, AddPlayerStatAt, AllocMemBlock, AllStarScreen, BlankMenuItem, BlitArt, BlitClippedY
extern BlitShape, BlitShape2, BuildSeasonSchedule, ClearLinkAbort, ClearTeamInjuries, CreateBitmap, CreateSeasonFile, CreateSeasonSchedule
extern DosFileInfo, DrawArt, DrawScreenBackground, DrawSeasonTitle, DrawShapeAtOwnPos, DrawShapeCore, DrawStatTable, DrawTeamLogoBanner
extern DrawTextAligned, EditTextField, ExhibitionData, ExitScreen, FadeInScreen, FindGameRecord, FindSeasonReplay, FindShape
extern FindShapeList, FindTeamRecord, FreeBitmap, FreeDbBlock, FreeExhibitionFile, FreeMemBlock, FrontEndExit, FrontMusicOn
extern gameopts, GetLangText, GlobalSetVersion, InitMenuItems, LangTextHandle, LangTextLoaded, LinkGameActive, LinkReceiveBlock
extern LinkScreensDone, LinkSendBlock, LinkTransferReady, LinkTransferSetup, LoadDataFile, LoadExhibitionFile, LoadNameIndex, MakeColor
extern MakeDirPath, MakeGoalieStatKey, MakeLeagueKeyBase, MakeStandingsKey, MatchupNote, memcpy_, memset_, MusicEnabled
extern NameIndexFree, NameIndexLimit, NameIndexLoad, NameIndexNew, NewSeasonArtOffsets, NewSeasonBannerTeams, NewSeasonItems, NewSeasonShapes
extern NewSeasonTeamOrderLarge, NewSeasonTeamOrderMid, NewSeasonTeamOrderSmall, NewSeasonUserCount, OpenLeagueFile, PlayMenuGameFlag, PlayoffColumns, PlayoffDbKey
extern PlayoffRounds, PlayoffRoundsJumpTable, PlayoffTreeScreen, PlaySfx, PresentScreen, rand_, Random32, ResetExhibitionFile
extern RosterScreen, RunMenu, RunStatsMenu, SaveDataFileNew, ScreenFrameItem, ScreenTitleItem, ScreenWipeMode, SeasonActive
extern SeasonCreated, SeasonDateShapes, SeasonDefaultUser, SeasonFilePath, SeasonFlags, SeasonGameScreen, SeasonGameShapes, SeasonIntroScreen
extern SeasonLastAway, SeasonLastHome, SeasonLengthJumpTable, SeasonMenuExit, SeasonMenuItems, SeasonMenuShapeLists, SeasonName, SeasonNameShapes
extern SeasonPhase, SeasonRandomSeed, SeasonRecordShapes, SeasonScheduleData, SeasonSettingsPath, SeasonSetupScreen, SeasonSlot, SeasonSparkleShapes
extern SeasonSparkleSoundOn, SeasonTypeCode, SeasonUserActive, SeasonUserHuman, SeasonUserRecords, SeasonUserTeam, SeasonYearText, SecondsToSamples
extern SetDrawTarget, SetHighlightText, SetRegionRect, SetScreenTarget, SetTextColor, ShowMessageBox, ShowPopupScreen, ShowScreen
extern sprintf_, srand_, StandingsColumns, StandingsScreen, StopAllSfx, str_000E, str_000W, str_011R
extern str_012R013R014R, str_11SR, str_12SR13SR14SR, str_BGES, str_BGWS, str_Delstring, str_DIV1, str_DIV2
extern str_DIV3, str_DIV4, str_DT00, str_DT00DT01DT02DT03, str_DT01, str_DT02, str_EC00, str_EC01
extern str_F_NewSeasonScreen, str_LBL1LBL2LBL3LBR1LBR2LTL1L, str_LBL1LBL2LBL3LBR1LBR2LTL1L2, str_LG02d, str_Menu2, str_Newmenu, str_Punct_SeasonMenuScreen, str_RL00
extern str_RL00RL01RL02RL03, str_RL01, str_RL02, str_SD00, str_SD00SD01SD02SD03, str_SD01, str_SD02, str_SEAS04dSET
extern str_SEASONNDX, str_SG00, str_SG00SG01SG02SG03, str_SG01, str_SG02, str_SN00, str_SN00SN01SN02SN03, str_SN01
extern str_SN02, str_SR00, str_SR00SR01SR02SR03, str_SR01, str_SR02, str_SS3, str_SSEASONNDX, str_TTLE
extern str_TTLW, str_WC00, str_WC01, strcat_, strcpy_, strlen_, UpdateGameRecord, WaitSoundTime
extern WipeScreen, WriteLeagueHeader
global RunNewSeason, RunNewSeason_DD, RunNewSeason_E6, RunNewSeason_EF, RunNewSeason_F8, RunNewSeason_16F, RunNewSeason_17B, RunNewSeason_187
global RunNewSeason_193, NewSeasonSound, NewSeasonScreen, NewSeasonScreen_DCB, NewSeasonScreen_DCE, CreateSeason, CreateSeason_55B, CreateSeason_561
global CreateSeason_562, RunSeasonMenus, SeasonMenuSparkle, SeasonMenuScreen
;-----------------------------------------------------------------------------
; RunNewSeason                                    8E997  97 PC, low confidence
; Screen 6: sets up a new season (copies the set-up, NewSeasonScreen, roster,
; import agents)
;-----------------------------------------------------------------------------
RunNewSeason:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 14h, 0
        mov ebx, 525h
        mov eax, SeasonName
        xor edx, edx
        call memset_
        mov ebx, 1E7h
        mov edx, GlobalSetVersion
        mov eax, SeasonName
        mov esi, 6
        call memcpy_
        mov dword [gameopts], SeasonName
        push byte 1
        cmp dword [LinkGameActive], byte 0
        je short .1
        call ClearLinkAbort
        test eax, eax
        jne short .1
        mov ecx, 1
        jmp short .2
.1:
        mov ecx, 2
.2:
        mov eax, 4
        mov edx, 1Eh
        call GetLangText
        mov ebx, eax
        mov eax, MatchupNote
        call EditTextField
        test eax, eax
        je near RunNewSeason_F8
        mov eax, 6
        call GetLangText
        mov dword [byte ebp-010h], eax
        mov eax, 7
        mov ecx, 1
        call GetLangText
        mov dword [byte ebp-0Ch], eax
        mov eax, 8
        lea ebx, [byte ebp-014h]
        call GetLangText
        push byte 0
        mov dword [byte ebp-08h], eax
        mov eax, 5
        mov edx, 4
        call GetLangText
        call ShowMessageBox
        mov edi, eax
        lea ebx, [byte eax-01h]
        mov dword [SeasonPhase], ebx
        cmp eax, byte 3
        ja short RunNewSeason_F8.3
        jmp dword [nosplit cs:eax*4+SeasonLengthJumpTable]
RunNewSeason_DD:
        mov byte [SeasonTypeCode], 52h
        jmp short RunNewSeason_F8.3
RunNewSeason_E6:
        mov byte [SeasonTypeCode], 32h
        jmp short RunNewSeason_F8.3
RunNewSeason_EF:
        mov byte [SeasonTypeCode], 19h
        jmp short RunNewSeason_F8.3
RunNewSeason_F8:
        mov esi, 1
.3:
        cmp esi, byte 6
        jne short .4
        mov eax, 0Ah
        call GetLangText
        mov dword [byte ebp-010h], eax
        mov eax, 0Bh
        call GetLangText
        mov dword [byte ebp-0Ch], eax
        mov eax, 0Ch
        mov ecx, 1
        call GetLangText
        mov dword [byte ebp-08h], eax
        mov eax, 0Dh
        lea ebx, [byte ebp-014h]
        call GetLangText
        push byte 0
        mov dword [byte ebp-04h], eax
        mov eax, 9
        mov edx, 5
        call GetLangText
        call ShowMessageBox
        mov edi, eax
        test eax, eax
        jne short .5
.4:
        mov esi, 1
.5:
        lea eax, [byte edi-01h]
        cmp eax, byte 3
        ja short RunNewSeason_193.6
        jmp dword [nosplit cs:eax*4+PlayoffRoundsJumpTable]
RunNewSeason_16F:
        mov dword [PlayoffRounds], 7
        jmp short RunNewSeason_193.6
RunNewSeason_17B:
        mov dword [PlayoffRounds], 5
        jmp short RunNewSeason_193.6
RunNewSeason_187:
        mov dword [PlayoffRounds], 3
        jmp short RunNewSeason_193.6
RunNewSeason_193:
        mov dword [PlayoffRounds], 1
.6:
        cmp esi, byte 1
        jne short .7
        mov dword [ScreenWipeMode], 3
.7:
        mov eax, ExhibitionData
        call LoadExhibitionFile
        test eax, eax
        jne short .8
        call ResetExhibitionFile
        mov eax, ExhibitionData
        call LoadExhibitionFile
.8:
        cmp dword [LinkTransferReady], byte 0
        jne short .9
        mov eax, dword [ExhibitionData]
        call LinkTransferSetup
        mov dword [LinkTransferReady], 1
.9:
        cmp esi, byte 1
        je short .12
        cmp esi, byte 0Ch
        je short .12
        cmp esi, byte 6
        jb short .9
        jbe short .10
        cmp esi, byte 19h
        je short .11
        jmp short .9
.10:
        mov eax, dword [ExhibitionData]
        call NewSeasonScreen
        mov esi, eax
        jmp short .9
.11:
        xor eax, eax
        mov esi, 6
        call RosterScreen
        cmp dword [LinkGameActive], byte 0
        jne short .9
        mov eax, ExhibitionData
        call FreeExhibitionFile
        mov eax, ExhibitionData
        call LoadExhibitionFile
        jmp short .9
.12:
        mov eax, ExhibitionData
        call FreeExhibitionFile
        mov eax, esi
        jmp near NewSeasonScreen_DCE
;-----------------------------------------------------------------------------
; NewSeasonSound                                  8EBDF  97 PC, low confidence
; Plays a new season screen sound
;-----------------------------------------------------------------------------
NewSeasonSound:
        push ebx
        push ecx
        push edx
        push esi
        call Random32
        mov ebx, 32h
        xor edx, edx
        div ebx
        xor esi, esi
        test edx, edx
        jne short .1
        call Random32
        mov ebx, 0Ah
        xor edx, edx
        div ebx
        push dword [nosplit edx*4+SeasonSparkleShapes]
        call DrawShapeAtOwnPos
        add esp, byte 4
.1:
        xor ebx, ebx
.2:
        lea eax, [byte ebx+010h]
        imul edx, eax, byte 52h
        mov eax, dword [NewSeasonItems]
        cmp dword [byte edx+eax+04h], byte 1
        jne short .3
        call Random32
        mov esi, 3
        xor edx, edx
        div esi
        mov eax, edx
        imul edx, ebx, byte 0Ch
        push dword [dword edx+eax*4+SeasonMenuShapeLists]
        mov esi, 1
        call BlitShape2
        add esp, byte 4
.3:
        inc ebx
        cmp ebx, byte 2
        jl short .2
        test esi, esi
        je short .4
        cmp dword [SeasonSparkleSoundOn], byte 0
        jne short .4
        mov eax, 309h
        call PlaySfx
        mov dword [SeasonSparkleSoundOn], 1
.4:
        test esi, esi
        jne short .5
        cmp dword [SeasonSparkleSoundOn], byte 0
        je short .5
        call StopAllSfx
        mov dword [SeasonSparkleSoundOn], esi
.5:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; NewSeasonScreen                              8EC93  96 PC, medium confidence
; The new season set-up screen (rul1-3, set1-2 buttons, bt01 / bt02): rules
; and settings, then creates the season
;-----------------------------------------------------------------------------
NewSeasonScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 4E8h, 0
        push eax
        mov dword [byte ebp-024h], 0
        mov dword [byte ebp-02Ch], 0FFFFFFFFh
        cmp byte [FrontMusicOn], 0
        je short .1
        call MusicEnabled
.1:
        push byte 0
        push dword 616h
        lea eax, [byte ebp-04h]
        push str_Newmenu
        mov dword [byte ebp-04Ch], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [NewSeasonItems], eax
        mov edx, eax
        mov eax, 13h
        call InitMenuItems
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 3Bh
        call LoadDataFile
        mov dword [byte ebp-01Ch], eax
        mov dword [byte ebp-020h], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 3Ah
        call LoadDataFile
        mov edx, eax
        mov dword [byte ebp-034h], eax
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push str_000W
        push edx
        call FindShape
        add esp, byte 8
        mov esi, eax
        mov dword [byte ebp-08h], eax
        push str_TTLW
        movsx eax, word [byte eax+0Eh]
        push dword [byte ebp-01Ch]
        mov dword [byte ebp-0Ch], eax
        call FindShape
        add esp, byte 8
        push SeasonMenuShapeLists
        push str_012R013R014R
        push dword [byte ebp-01Ch]
        mov dword [byte ebp-030h], eax
        call FindShapeList
        add esp, byte 0Ch
        push NewSeasonShapes
        push str_12SR13SR14SR
        push dword [byte ebp-01Ch]
        call FindShapeList
        add esp, byte 0Ch
        push byte 0
        push dword 1E0h
        push dword 280h
        mov ebx, esi
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [byte ebp-03Ch], eax
        mov edx, esi
        mov eax, esi
        mov ecx, 52h
        call DrawScreenBackground
        mov edi, dword [NewSeasonItems]
        mov esi, ScreenTitleItem
        rep movsb
        mov eax, dword [NewSeasonItems]
        mov dword [eax], 0
        mov esi, dword [NewSeasonItems]
        mov ecx, 52h
        lea edi, [byte esi+052h]
        mov esi, BlankMenuItem
        rep movsb
        mov eax, dword [NewSeasonItems]
        mov dword [byte eax+052h], 1
        mov esi, dword [NewSeasonItems]
        mov ecx, 52h
        lea edi, [dword esi+05C4h]
        mov esi, ScreenFrameItem
        rep movsb
        push str_WC00
        mov eax, dword [NewSeasonItems]
        push dword [byte ebp-01Ch]
        mov dword [dword eax+05C4h], 12h
        call FindShape
        add esp, byte 8
        push str_WC01
        mov edx, eax
        mov eax, dword [NewSeasonItems]
        push dword [byte ebp-01Ch]
        mov dword [dword eax+04E8h], edx
        call FindShape
        add esp, byte 8
        push str_WC01
        mov edx, eax
        mov eax, dword [NewSeasonItems]
        push dword [byte ebp-01Ch]
        mov dword [dword eax+04ECh], edx
        call FindShape
        add esp, byte 8
        push str_011R
        mov edx, eax
        mov eax, dword [NewSeasonItems]
        push dword [byte ebp-01Ch]
        mov dword [dword eax+04F0h], edx
        call FindShape
        mov edx, eax
        mov eax, dword [NewSeasonItems]
        mov dword [dword eax+0542h], edx
        mov esi, dword [NewSeasonItems]
        mov eax, edx
        add esp, byte 8
        mov dword [dword esi+053Eh], eax
        push str_11SR
        mov eax, dword [NewSeasonItems]
        push dword [byte ebp-01Ch]
        mov dword [dword eax+053Ah], edx
        call FindShape
        mov edx, eax
        mov eax, dword [NewSeasonItems]
        mov dword [dword eax+0594h], edx
        mov eax, dword [NewSeasonItems]
        mov dword [dword eax+0590h], edx
        mov eax, dword [NewSeasonItems]
        mov esi, 0Fh
        add esp, byte 8
        mov dword [dword eax+058Ch], edx
.2:
        imul eax, esi, byte 52h
        mov dword [byte ebp-044h], eax
        mov eax, dword [NewSeasonItems]
        add eax, dword [byte ebp-044h]
        mov edx, dword [byte eax+01Ah]
        movsx edx, word [byte edx+0Ch]
        mov dword [byte eax+026h], edx
        mov eax, dword [NewSeasonItems]
        add eax, dword [byte ebp-044h]
        mov edx, dword [byte eax+01Ah]
        movsx edx, word [byte edx+0Eh]
        mov dword [byte eax+02Ah], edx
        mov edi, dword [NewSeasonItems]
        add edi, dword [byte ebp-044h]
        mov eax, dword [byte edi+01Ah]
        movsx edx, word [byte eax+06h]
        mov ebx, dword [byte edi+02Ah]
        push edx
        mov edx, dword [byte edi+026h]
        mov edi, esi
        movsx ecx, word [byte eax+04h]
        shl edi, 6
        lea eax, [dword ebp-04E8h]
        sub edi, 80h
        add edi, eax
        mov eax, edi
        call SetRegionRect
        mov eax, dword [NewSeasonItems]
        add eax, dword [byte ebp-044h]
        mov dword [byte eax+014h], edi
        mov eax, dword [NewSeasonItems]
        add eax, dword [byte ebp-044h]
        inc esi
        mov dword [byte eax+010h], 4
        cmp esi, byte 12h
        jl short .2
        push SeasonSparkleShapes
        push str_LBL1LBL2LBL3LBR1LBR2LTL1L
        push dword [byte ebp-034h]
        call FindShapeList
        add esp, byte 0Ch
        push dword [byte ebp-03Ch]
        call SetDrawTarget
        add esp, byte 4
        push dword [byte ebp-08h]
        call BlitShape2
        add esp, byte 4
        push dword [byte ebp-030h]
        mov esi, 1
        call BlitShape2
        add esp, byte 4
.3:
        push dword [nosplit esi*4+SeasonSparkleShapes]
        call DrawShapeAtOwnPos
        inc esi
        inc esi
        add esp, byte 4
        cmp esi, byte 8
        jl short .3
        xor esi, esi
.4:
        cmp esi, byte 6
        jle short .5
        lea eax, [byte esi-07h]
        mov dword [byte ebp-014h], 1
        mov dword [byte ebp-018h], eax
        jmp short .6
.5:
        mov dword [byte ebp-014h], 0
        mov dword [byte ebp-018h], esi
.6:
        push byte 0
        push byte 5Ah
        push byte 5Ah
        call CreateBitmap
        mov edx, esi
        add esp, byte 0Ch
        shl edx, 2
        push eax
        mov dword [byte ebp-044h], edx
        mov dword [dword edx+ebp-0B4h], eax
        call SetDrawTarget
        mov eax, dword [byte ebp-0Ch]
        add esp, byte 4
        sub eax, dword [nosplit esi*8+NewSeasonArtOffsets]
        push eax
        mov eax, dword [nosplit esi*8+str_F_NewSeasonScreen]
        neg eax
        push eax
        push dword [byte ebp-08h]
        call BlitArt
        add esp, byte 0Ch
        mov eax, dword [nosplit esi*8+NewSeasonArtOffsets]
        push dword 5999h
        sub eax, dword [byte ebp-0Ch]
        push eax
        imul eax, dword [byte ebp-014h], byte 7
        mov ebx, dword [byte ebp-044h]
        mov ecx, dword [byte ebp-08h]
        push dword [nosplit esi*8+str_F_NewSeasonScreen]
        mov edx, 10h
        push byte 28h
        add eax, dword [byte ebp-018h]
        mov ebx, dword [dword ebx+ebp-0B4h]
        push byte 2Dh
        movzx eax, byte [dword eax+NewSeasonBannerTeams]
        call DrawTeamLogoBanner
        push dword [byte ebp-03Ch]
        call SetDrawTarget
        add esp, byte 4
        mov eax, dword [byte ebp-044h]
        push dword [nosplit esi*8+NewSeasonArtOffsets]
        mov eax, dword [dword eax+ebp-0B4h]
        push dword [nosplit esi*8+str_F_NewSeasonScreen]
        push dword [byte eax+02Ch]
        inc esi
        call BlitArt
        add esp, byte 0Ch
        cmp esi, byte 0Dh
        jl near .4
        mov eax, dword [byte ebp-03Ch]
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte eax+02Ch]
        call WipeScreen
        push dword [byte ebp-03Ch]
        xor esi, esi
        call FreeBitmap
        add esp, byte 4
.7:
        cmp esi, byte 6
        jle short .8
        lea eax, [byte esi-07h]
        mov dword [byte ebp-014h], 1
        mov dword [byte ebp-018h], eax
        jmp short .9
.8:
        mov dword [byte ebp-014h], 0
        mov dword [byte ebp-018h], esi
.9:
        push byte 0
        push byte 5Ah
        push byte 5Ah
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        mov edi, esi
        push byte 5Ah
        shl edi, 2
        push byte 5Ah
        mov dword [byte edi+ebp-080h], eax
        call CreateBitmap
        add esp, byte 0Ch
        push dword [byte edi+ebp-080h]
        mov dword [dword edi+ebp-0E8h], eax
        call SetDrawTarget
        mov eax, esi
        shl eax, 3
        mov dword [byte ebp-044h], eax
        mov edx, dword [byte ebp-044h]
        mov eax, dword [byte ebp-0Ch]
        add esp, byte 4
        sub eax, dword [dword edx+NewSeasonArtOffsets]
        push eax
        mov eax, dword [dword edx+str_F_NewSeasonScreen]
        neg eax
        push eax
        push dword [byte ebp-08h]
        call BlitArt
        add esp, byte 0Ch
        push dword [dword edi+ebp-0E8h]
        call SetDrawTarget
        mov edx, dword [byte ebp-044h]
        mov eax, dword [byte ebp-0Ch]
        add esp, byte 4
        sub eax, dword [dword edx+NewSeasonArtOffsets]
        push eax
        mov eax, dword [dword edx+str_F_NewSeasonScreen]
        neg eax
        push eax
        push dword [byte ebp-08h]
        call BlitArt
        mov eax, dword [byte ebp-044h]
        add esp, byte 0Ch
        mov eax, dword [dword eax+NewSeasonArtOffsets]
        push dword 5999h
        sub eax, dword [byte ebp-0Ch]
        push eax
        mov eax, dword [byte ebp-044h]
        push dword [dword eax+str_F_NewSeasonScreen]
        imul eax, dword [byte ebp-014h], byte 7
        mov edx, dword [byte ebp-018h]
        mov ecx, dword [byte ebp-08h]
        push byte 28h
        mov ebx, dword [byte edi+ebp-080h]
        add edx, eax
        push byte 2Dh
        mov dword [byte ebp-038h], edx
        movzx eax, byte [dword edx+NewSeasonBannerTeams]
        mov edx, 20h
        call DrawTeamLogoBanner
        mov eax, dword [byte ebp-044h]
        mov eax, dword [dword eax+NewSeasonArtOffsets]
        push dword 5999h
        sub eax, dword [byte ebp-0Ch]
        push eax
        mov eax, dword [byte ebp-044h]
        mov ecx, dword [byte ebp-08h]
        push dword [dword eax+str_F_NewSeasonScreen]
        mov edx, 20h
        push byte 28h
        mov eax, dword [byte ebp-038h]
        mov ebx, dword [dword edi+ebp-0E8h]
        push byte 2Dh
        movzx eax, byte [dword eax+NewSeasonBannerTeams]
        call DrawTeamLogoBanner
        push dword [dword edi+ebp-0E8h]
        call SetDrawTarget
        add esp, byte 4
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, dword [byte ebp-038h]
        movzx eax, byte [dword eax+NewSeasonBannerTeams]
        imul eax, byte 1Ch
        add eax, SeasonUserRecords
        push eax
        push byte 46h
        push byte 2Dh
        push byte 1
        call DrawTextAligned
        mov eax, dword [byte ebp-038h]
        movzx eax, byte [dword eax+NewSeasonBannerTeams]
        imul eax, byte 1Ch
        add esp, byte 10h
        add eax, SeasonUserRecords
        call strlen_
        mov edx, eax
        lea eax, [byte esi+02h]
        imul eax, byte 52h
        test edx, edx
        je short .10
        mov ebx, dword [dword edi+ebp-0E8h]
        mov edx, dword [NewSeasonItems]
        mov ebx, dword [byte ebx+02Ch]
        mov dword [byte edx+eax+01Ah], ebx
        mov ebx, dword [dword edi+ebp-0E8h]
        mov edx, dword [NewSeasonItems]
        mov ebx, dword [byte ebx+02Ch]
        mov dword [byte edx+eax+01Eh], ebx
        mov edx, dword [NewSeasonItems]
        mov edi, dword [dword edi+ebp-0E8h]
        add eax, edx
        mov edx, dword [byte edi+02Ch]
        mov dword [byte eax+022h], edx
        jmp short .11
.10:
        mov edx, dword [dword edi+ebp-0B4h]
        mov ebx, dword [NewSeasonItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ebx+eax+01Ah], edx
        mov edx, dword [byte edi+ebp-080h]
        mov edi, dword [NewSeasonItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte edi+eax+022h], edx
        mov ebx, edx
        mov edx, dword [NewSeasonItems]
        mov dword [byte edx+eax+01Eh], ebx
.11:
        lea eax, [byte esi+02h]
        imul eax, byte 52h
        mov dword [byte ebp-044h], eax
        mov eax, dword [NewSeasonItems]
        add eax, dword [byte ebp-044h]
        mov dword [byte eax+010h], 4
        mov eax, esi
        lea edx, [dword ebp-04E8h]
        shl eax, 6
        add eax, edx
        mov edx, dword [NewSeasonItems]
        add edx, dword [byte ebp-044h]
        push byte 63h
        mov dword [byte edx+014h], eax
        mov ecx, 63h
        mov ebx, dword [nosplit esi*8+NewSeasonArtOffsets]
        mov edx, dword [nosplit esi*8+str_F_NewSeasonScreen]
        call SetRegionRect
        mov eax, dword [NewSeasonItems]
        add eax, dword [byte ebp-044h]
        mov edx, dword [nosplit esi*8+str_F_NewSeasonScreen]
        mov dword [byte eax+026h], edx
        mov eax, dword [NewSeasonItems]
        add eax, dword [byte ebp-044h]
        mov edx, dword [nosplit esi*8+NewSeasonArtOffsets]
        inc esi
        mov dword [byte eax+02Ah], edx
        cmp esi, byte 0Dh
        jl near .7
.12:
        cmp dword [byte ebp-02Ch], byte 0FFFFFFFFh
        jne near .42
        push byte 3
        lea eax, [byte ebp-048h]
        mov ecx, NewSeasonSound
        mov ebx, 0FFFFFFFFh
        push eax
        mov edx, dword [NewSeasonItems]
        mov eax, 12h
        call RunMenu
        mov edx, eax
        cmp dword [byte ebp-048h], byte 0Fh
        jb short .13
        jbe near .22
        cmp dword [byte ebp-048h], byte 11h
        jb near .20
        jbe near .21
        cmp dword [byte ebp-048h], byte 12h
        je near .19
        jmp near .33
.13:
        cmp dword [byte ebp-048h], byte 0
        jbe short .14
        cmp dword [byte ebp-048h], byte 1
        je short .15
        jmp near .33
.14:
        call ShowScreen
        mov dword [byte ebp-02Ch], 1
        jmp short .12
.15:
        call FadeInScreen
        mov dword [NewSeasonUserCount], 0
        xor esi, esi
.16:
        imul eax, esi, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        jne short .17
        inc dword [NewSeasonUserCount]
.17:
        inc esi
        cmp esi, byte 1Ah
        jl short .16
        cmp dword [NewSeasonUserCount], byte 0
        jne short .18
        push byte 0
        mov eax, 30h
        mov ecx, 1
        lea ebx, [byte ebp-04Ch]
        mov edx, ecx
        call GetLangText
        call ShowMessageBox
        jmp near .12
.18:
        mov eax, dword [dword ebp-04ECh]
        mov dword [byte ebp-02Ch], 0Ch
        call CreateSeason
        jmp near .12
.19:
        call ExitScreen
        jmp near .12
.20:
        mov eax, dword [NewSeasonItems]
        add eax, 520h
        call ShowPopupScreen
        mov eax, 2
        call SeasonSetupScreen
        jmp near .12
.21:
        mov eax, dword [NewSeasonItems]
        add eax, 572h
        mov dword [byte ebp-02Ch], 19h
        call ShowPopupScreen
        jmp near .12
.22:
        xor byte [byte ebp-024h], 1
        cmp dword [byte ebp-024h], byte 0
        je short .23
        push str_000E
        push dword [byte ebp-034h]
        call FindShape
        add esp, byte 8
        push str_TTLE
        push dword [byte ebp-020h]
        mov dword [byte ebp-08h], eax
        call FindShape
        add esp, byte 8
        push str_EC00
        push dword [byte ebp-020h]
        mov dword [byte ebp-030h], eax
        call FindShape
        add esp, byte 8
        push str_EC01
        mov edx, eax
        mov eax, dword [NewSeasonItems]
        push dword [byte ebp-020h]
        mov dword [dword eax+04E8h], edx
        call FindShape
        add esp, byte 8
        push str_EC01
        jmp short .24
.23:
        push str_000W
        push dword [byte ebp-034h]
        call FindShape
        add esp, byte 8
        push str_TTLW
        push dword [byte ebp-020h]
        mov dword [byte ebp-08h], eax
        call FindShape
        add esp, byte 8
        push str_WC00
        push dword [byte ebp-020h]
        mov dword [byte ebp-030h], eax
        call FindShape
        add esp, byte 8
        push str_WC01
        mov edx, eax
        mov eax, dword [NewSeasonItems]
        push dword [byte ebp-020h]
        mov dword [dword eax+04E8h], edx
        call FindShape
        add esp, byte 8
        push str_WC01
.24:
        mov edx, eax
        mov eax, dword [NewSeasonItems]
        push dword [byte ebp-020h]
        mov dword [dword eax+04ECh], edx
        call FindShape
        mov edx, eax
        mov eax, dword [NewSeasonItems]
        add esp, byte 8
        mov dword [dword eax+04F0h], edx
        mov ebx, dword [byte ebp-08h]
        mov edx, ebx
        mov eax, ebx
        xor esi, esi
        call DrawScreenBackground
.25:
        cmp esi, byte 7
        jge short .26
        cmp dword [byte ebp-024h], byte 0
        je short .26
        mov dword [byte ebp-014h], 3
        mov dword [byte ebp-018h], esi
.26:
        cmp esi, byte 6
        jle short .27
        cmp dword [byte ebp-024h], byte 0
        je short .27
        lea eax, [byte esi-07h]
        mov dword [byte ebp-014h], 2
        mov dword [byte ebp-018h], eax
.27:
        cmp esi, byte 7
        jge short .28
        cmp dword [byte ebp-024h], byte 0
        jne short .28
        mov dword [byte ebp-014h], 0
        mov dword [byte ebp-018h], esi
.28:
        cmp esi, byte 6
        jle short .29
        cmp dword [byte ebp-024h], byte 0
        jne short .29
        lea eax, [byte esi-07h]
        mov dword [byte ebp-014h], 1
        mov dword [byte ebp-018h], eax
.29:
        mov eax, esi
        mov edi, esi
        shl eax, 2
        shl edi, 3
        push dword [dword eax+ebp-0B4h]
        mov dword [byte ebp-010h], eax
        call SetDrawTarget
        mov eax, dword [byte ebp-0Ch]
        add esp, byte 4
        sub eax, dword [dword edi+NewSeasonArtOffsets]
        push eax
        mov eax, dword [dword edi+str_F_NewSeasonScreen]
        neg eax
        push eax
        push dword [byte ebp-08h]
        call BlitArt
        mov eax, dword [byte ebp-010h]
        add esp, byte 0Ch
        push dword [byte eax+ebp-080h]
        call SetDrawTarget
        mov eax, dword [byte ebp-0Ch]
        add esp, byte 4
        sub eax, dword [dword edi+NewSeasonArtOffsets]
        push eax
        mov eax, dword [dword edi+str_F_NewSeasonScreen]
        neg eax
        push eax
        push dword [byte ebp-08h]
        call BlitArt
        mov eax, dword [byte ebp-010h]
        add esp, byte 0Ch
        push dword [dword eax+ebp-0E8h]
        call SetDrawTarget
        mov eax, dword [byte ebp-0Ch]
        add esp, byte 4
        sub eax, dword [dword edi+NewSeasonArtOffsets]
        push eax
        mov eax, dword [dword edi+str_F_NewSeasonScreen]
        neg eax
        push eax
        push dword [byte ebp-08h]
        call BlitArt
        add esp, byte 0Ch
        mov eax, dword [dword edi+NewSeasonArtOffsets]
        push dword 5999h
        sub eax, dword [byte ebp-0Ch]
        push eax
        imul eax, dword [byte ebp-014h], byte 7
        mov ebx, dword [byte ebp-010h]
        mov edx, dword [byte ebp-018h]
        push dword [dword edi+str_F_NewSeasonScreen]
        mov ecx, dword [byte ebp-08h]
        push byte 28h
        mov ebx, dword [dword ebx+ebp-0B4h]
        add edx, eax
        push byte 2Dh
        mov dword [byte ebp-028h], edx
        movzx eax, byte [dword edx+NewSeasonBannerTeams]
        mov edx, 10h
        call DrawTeamLogoBanner
        mov eax, dword [dword edi+NewSeasonArtOffsets]
        push dword 5999h
        sub eax, dword [byte ebp-0Ch]
        push eax
        mov ebx, dword [byte ebp-010h]
        mov ecx, dword [byte ebp-08h]
        push dword [dword edi+str_F_NewSeasonScreen]
        mov edx, 20h
        push byte 28h
        mov eax, dword [byte ebp-028h]
        mov ebx, dword [byte ebx+ebp-080h]
        push byte 2Dh
        movzx eax, byte [dword eax+NewSeasonBannerTeams]
        call DrawTeamLogoBanner
        mov eax, dword [dword edi+NewSeasonArtOffsets]
        push dword 5999h
        sub eax, dword [byte ebp-0Ch]
        push eax
        mov ebx, dword [byte ebp-010h]
        mov ecx, dword [byte ebp-08h]
        push dword [dword edi+str_F_NewSeasonScreen]
        mov edx, 20h
        push byte 28h
        mov eax, dword [byte ebp-028h]
        mov ebx, dword [dword ebx+ebp-0E8h]
        push byte 2Dh
        movzx eax, byte [dword eax+NewSeasonBannerTeams]
        call DrawTeamLogoBanner
        mov eax, dword [byte ebp-028h]
        movzx eax, byte [dword eax+NewSeasonBannerTeams]
        imul eax, byte 1Ch
        add eax, SeasonUserRecords
        call strlen_
        mov edx, eax
        lea eax, [byte esi+02h]
        imul eax, byte 52h
        test edx, edx
        je near .30
        mov edx, dword [byte ebp-010h]
        mov edx, dword [dword edx+ebp-0E8h]
        mov ebx, dword [NewSeasonItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ebx+eax+01Ah], edx
        mov edx, dword [byte ebp-010h]
        mov edx, dword [dword edx+ebp-0E8h]
        mov ebx, dword [NewSeasonItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ebx+eax+01Eh], edx
        mov eax, dword [byte ebp-010h]
        push dword [dword eax+ebp-0E8h]
        call SetDrawTarget
        mov eax, dword [byte ebp-0Ch]
        add esp, byte 4
        sub eax, dword [dword edi+NewSeasonArtOffsets]
        push eax
        mov eax, dword [dword edi+str_F_NewSeasonScreen]
        neg eax
        push eax
        push dword [byte ebp-08h]
        call BlitArt
        add esp, byte 0Ch
        mov eax, dword [dword edi+NewSeasonArtOffsets]
        push dword 5999h
        sub eax, dword [byte ebp-0Ch]
        push eax
        mov ebx, dword [byte ebp-010h]
        mov ecx, dword [byte ebp-08h]
        push dword [dword edi+str_F_NewSeasonScreen]
        mov edx, 20h
        push byte 28h
        mov eax, dword [byte ebp-028h]
        mov ebx, dword [dword ebx+ebp-0E8h]
        push byte 2Dh
        movzx eax, byte [dword eax+NewSeasonBannerTeams]
        call DrawTeamLogoBanner
        mov eax, dword [byte ebp-010h]
        push dword [dword eax+ebp-0E8h]
        call SetDrawTarget
        add esp, byte 4
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, dword [byte ebp-028h]
        movzx eax, byte [dword eax+NewSeasonBannerTeams]
        imul eax, byte 1Ch
        add eax, SeasonUserRecords
        push eax
        push byte 46h
        push byte 2Dh
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        jmp short .31
.30:
        mov edx, dword [byte ebp-010h]
        mov edx, dword [dword edx+ebp-0B4h]
        mov edi, dword [NewSeasonItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte edi+eax+01Ah], edx
        mov edx, dword [byte ebp-010h]
        mov edx, dword [byte edx+ebp-080h]
        mov ebx, dword [NewSeasonItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ebx+eax+01Eh], edx
.31:
        inc esi
        cmp esi, byte 0Dh
        jl near .25
        call SetScreenTarget
        push dword [byte ebp-08h]
        call BlitShape2
        add esp, byte 4
        push dword [byte ebp-030h]
        mov esi, 1
        call BlitShape2
        add esp, byte 4
.32:
        push dword [nosplit esi*4+SeasonSparkleShapes]
        call DrawShapeAtOwnPos
        inc esi
        inc esi
        add esp, byte 4
        cmp esi, byte 8
        jl short .32
        call PresentScreen
        jmp near .12
.33:
        mov esi, dword [byte ebp-048h]
        shl esi, 2
        cmp dword [byte ebp-024h], byte 0
        je short .35
        cmp dword [byte ebp-048h], byte 8
        jle short .34
        mov edi, dword [dword esi+NewSeasonTeamOrderLarge]
        jmp short .36
.34:
        mov edi, dword [dword esi+NewSeasonTeamOrderMid]
        jmp short .36
.35:
        mov edi, dword [dword esi+NewSeasonTeamOrderSmall]
.36:
        imul esi, edi, byte 1Ch
        push byte 1
        mov eax, 2Fh
        mov ebx, SeasonUserRecords
        call GetLangText
        mov ecx, edx
        add ebx, esi
        mov edx, 0Ah
        mov dword [byte ebp-040h], ebx
        mov ebx, eax
        mov eax, dword [byte ebp-040h]
        call EditTextField
        mov eax, dword [byte ebp-040h]
        call strlen_
        imul ebx, dword [byte ebp-048h], byte 52h
        mov edx, eax
        mov eax, dword [byte ebp-048h]
        shl eax, 2
        test edx, edx
        je near .38
        mov edx, dword [dword eax+ebp-0F0h]
        mov eax, dword [NewSeasonItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ebx+eax+01Ah], edx
        mov eax, dword [byte ebp-048h]
        mov edx, dword [dword ebp+eax*4-0F0h]
        imul eax, byte 52h
        mov ebx, dword [NewSeasonItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ebx+eax+01Eh], edx
        mov eax, dword [byte ebp-048h]
        push dword [dword ebp+eax*4-0F0h]
        call SetDrawTarget
        mov eax, dword [byte ebp-048h]
        mov edx, dword [byte ebp-0Ch]
        add esp, byte 4
        sub edx, dword [nosplit eax*8+LangTextHandle]
        mov eax, dword [nosplit eax*8+LangTextLoaded]
        push edx
        neg eax
        push eax
        push dword [byte ebp-08h]
        call BlitArt
        mov eax, dword [byte ebp-048h]
        add esp, byte 0Ch
        mov edx, dword [nosplit eax*8+LangTextHandle]
        push dword 5999h
        sub edx, dword [byte ebp-0Ch]
        push edx
        push dword [nosplit eax*8+LangTextLoaded]
        push byte 28h
        mov ecx, dword [byte ebp-08h]
        mov ebx, dword [dword ebp+eax*4-0F0h]
        push byte 2Dh
        mov edx, 20h
        mov eax, edi
        call DrawTeamLogoBanner
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        push dword [byte ebp-040h]
        push byte 46h
        push byte 2Dh
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov byte [dword esi+SeasonUserActive], 1
        cmp dword [LinkGameActive], byte 0
        je short .37
        call ClearLinkAbort
        test eax, eax
        jne short .37
        mov byte [dword esi+SeasonUserHuman], 2
        jmp short .39
.37:
        imul eax, edi, byte 1Ch
        mov byte [dword eax+SeasonUserHuman], 0
        jmp short .39
.38:
        mov eax, dword [dword eax+ebp-0BCh]
        mov edx, dword [NewSeasonItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte edx+ebx+01Ah], eax
        mov eax, dword [byte ebp-048h]
        mov edx, dword [dword ebp+eax*4-088h]
        imul eax, byte 52h
        mov ebx, dword [NewSeasonItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ebx+eax+01Eh], edx
        mov byte [dword esi+SeasonUserActive], 0
.39:
        mov dword [NewSeasonUserCount], 0
        xor esi, esi
        imul eax, edi, byte 1Ch
.40:
        cmp byte [dword eax+SeasonUserActive], 1
        jne short .41
        inc dword [NewSeasonUserCount]
.41:
        inc esi
        cmp esi, byte 1Ah
        jl short .40
        jmp near .12
.42:
        xor esi, esi
.43:
        push dword [dword ebp+esi*4-0B4h]
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp+esi*4-080h]
        call FreeBitmap
        add esp, byte 4
        push dword [dword ebp+esi*4-0E8h]
        inc esi
        call FreeBitmap
        add esp, byte 4
        cmp esi, byte 0Dh
        jl short .43
        push dword [NewSeasonItems]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp-034h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp-020h]
        call FreeMemBlock
        add esp, byte 4
        cmp byte [FrontMusicOn], 0
        je short NewSeasonScreen_DCB
        call MusicEnabled
NewSeasonScreen_DCB:
        mov eax, dword [byte ebp-02Ch]
NewSeasonScreen_DCE:
        leave
        jmp near CreateSeason_562
;-----------------------------------------------------------------------------
; CreateSeason                                    8FA67  97 PC, low confidence
; Creates the new season: seeds rand from the time, picks a free SEAS%04d.SET
; name and adds it to SEASON.NDX
;-----------------------------------------------------------------------------
CreateSeason:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 1D9Ch, 0
        sub ebp, 82h
        mov esi, eax
        lea eax, [byte ebp+07Ah]
        call _dos_gettime_
        movzx eax, byte [byte ebp+07Bh]
        movzx edx, byte [byte ebp+07Ah]
        imul edx, eax
        movzx eax, byte [byte ebp+07Ch]
        imul eax, edx
        mov ebx, 0FCFFCFFCh
        call srand_
        xor edx, edx
        call rand_
        div ebx
        mov dword [SeasonRandomSeed], edx
        cmp dword [LinkGameActive], byte 0
        je short .2
        call ClearLinkAbort
        test eax, eax
        je short .1
        mov edx, 4
        mov eax, SeasonRandomSeed
        xor ebx, ebx
        call LinkSendBlock
        jmp short .2
.1:
        mov edx, 4
        mov eax, SeasonRandomSeed
        xor ebx, ebx
        call LinkReceiveBlock
.2:
        lea edx, [byte ebp+076h]
        mov eax, PlayoffDbKey
        call OpenLeagueFile
        cmp dword [LinkGameActive], byte 0
        jne short .4
        movzx eax, byte [SeasonTypeCode]
        imul eax, byte 1Ah
        cdq
        LD sub, eax, edx
        sar eax, 1
        lea ebx, [byte ebp+072h]
        cwde
        mov edx, esi
        mov edi, SeasonScheduleData
        call CreateSeasonSchedule
.3:
        lea eax, [byte ebp+032h]
        lea esi, [byte ebp+032h]
        call AddPlayerStat
        jmp near .6
.4:
        call ClearLinkAbort
        test eax, eax
        je short .5
        lea eax, [byte ebp+06Ah]
        call MakeLeagueKeyBase
        lea eax, [byte ebp+062h]
        mov edx, 8
        call MakeStandingsKey
        lea eax, [byte ebp+05Ah]
        xor ebx, ebx
        call MakeGoalieStatKey
        lea eax, [byte ebp+06Ah]
        call LinkSendBlock
        mov edx, 8
        lea eax, [byte ebp+062h]
        xor ebx, ebx
        call LinkSendBlock
        mov edx, 8
        lea eax, [byte ebp+05Ah]
        xor ebx, ebx
        call LinkSendBlock
        lea eax, [byte ebp+062h]
        push eax
        movzx eax, byte [SeasonTypeCode]
        imul eax, byte 1Ah
        cdq
        LD sub, eax, edx
        sar eax, 1
        lea ecx, [byte ebp+06Ah]
        lea ebx, [byte ebp+072h]
        cwde
        mov edx, esi
        mov edi, SeasonScheduleData
        call CreateSeasonFile
        jmp near .3
.5:
        mov edx, 8
        lea eax, [byte ebp+06Ah]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 8
        lea eax, [byte ebp+062h]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 8
        lea eax, [byte ebp+05Ah]
        xor ebx, ebx
        call LinkReceiveBlock
        lea eax, [byte ebp+062h]
        push eax
        movzx eax, byte [SeasonTypeCode]
        imul eax, byte 1Ah
        cdq
        LD sub, eax, edx
        sar eax, 1
        lea ecx, [byte ebp+06Ah]
        lea ebx, [byte ebp+072h]
        cwde
        mov edx, esi
        mov edi, SeasonScheduleData
        call CreateSeasonFile
        lea edx, [byte ebp+05Ah]
        lea eax, [byte ebp+032h]
        lea esi, [byte ebp+032h]
        call AddPlayerStatAt
.6:
        movsd
        movsd
        mov dword [byte ebp+07Eh], 0
.7:
        xor eax, eax
.8:
        imul edx, dword [byte ebp+07Eh], byte 1Ah
        add edx, eax
        inc eax
        mov byte [dword edx+ebp-03CAh], 0
        cmp eax, byte 1Ah
        jl short .8
        inc dword [byte ebp+07Eh]
        cmp dword [byte ebp+07Eh], byte 1Ah
        jl short .7
        xor edi, edi
        mov dword [byte ebp+07Eh], edi
        jmp near .14
.9:
        cmp byte [SeasonTypeCode], 52h
        je short .11
        cmp byte [SeasonTypeCode], 32h
        jne short .10
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [byte ebp+076h]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        add eax, edx
        movsx edx, byte [eax]
        imul edx, byte 1Ah
        movsx eax, byte [byte eax+01h]
        add eax, edx
        cmp byte [dword eax+ebp-03CAh], 0
        je short .11
.10:
        cmp byte [SeasonTypeCode], 19h
        jne near .13
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [byte ebp+076h]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        add eax, edx
        movsx edx, byte [eax]
        imul edx, byte 1Ah
        movsx eax, byte [byte eax+01h]
        add eax, edx
        cmp byte [dword eax+ebp-03CAh], 0
        jne near .13
.11:
        mov eax, dword [byte ebp+07Eh]
        mov edx, dword [byte ebp+076h]
        mov ebx, dword [byte ebp+072h]
        mov esi, edi
        shl eax, 4
        mov ecx, dword [byte edx+020h]
        mov edx, dword [byte ebx+020h]
        shl esi, 4
        mov bl, byte [ecx+eax]
        mov byte [edx+esi], bl
        mov ebx, dword [byte ebp+076h]
        mov edx, dword [byte ebp+072h]
        mov ebx, dword [byte ebx+020h]
        mov edx, dword [byte edx+020h]
        mov bl, byte [byte ebx+eax+01h]
        mov byte [byte edx+esi+01h], bl
        mov ebx, dword [byte ebp+076h]
        mov edx, dword [byte ebx+020h]
        mov ebx, dword [byte ebp+072h]
        mov ebx, dword [byte ebx+020h]
        mov dx, word [byte edx+eax+06h]
        mov word [byte esi+ebx+06h], dx
        mov edx, dword [byte ebp+076h]
        mov ebx, dword [byte ebp+072h]
        mov edx, dword [byte edx+020h]
        mov ebx, dword [byte ebx+020h]
        mov dx, word [byte edx+eax+04h]
        mov word [byte esi+ebx+04h], dx
        mov esi, dword [byte ebp+076h]
        mov esi, dword [byte esi+020h]
        movsx edx, byte [esi+eax]
        imul edx, byte 1Ah
        movsx esi, byte [byte esi+eax+01h]
        add esi, edx
        inc byte [dword esi+ebp-03CAh]
        cmp byte [SeasonTypeCode], 32h
        je short .12
        mov ebx, dword [byte ebp+076h]
        mov edx, dword [byte ebx+020h]
        add eax, edx
        movsx edx, byte [byte eax+01h]
        imul edx, byte 1Ah
        movsx eax, byte [eax]
        add eax, edx
        inc byte [dword eax+ebp-03CAh]
.12:
        inc edi
.13:
        inc dword [byte ebp+07Eh]
.14:
        mov eax, dword [byte ebp+076h]
        movsx eax, word [byte eax+02h]
        cmp eax, dword [byte ebp+07Eh]
        jg near .9
        mov eax, dword [byte ebp+072h]
        call WriteLeagueHeader
        mov esi, dword [byte ebp+072h]
        mov edi, SeasonFilePath
        lea esi, [byte esi+04h]
        mov edx, 1
        xor ebx, ebx
        movsd
        movsd
        lea eax, [byte ebp-06Eh]
        mov byte [SeasonCreated], 1
        mov word [SeasonLastHome], 0FFFFh
        mov word [SeasonLastAway], 0FFFFh
        call MakeDirPath
        lea eax, [byte ebp-06Eh]
        push eax
        push str_SSEASONNDX
        lea eax, [dword ebp-0BEh]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [dword ebp-0BEh]
        push eax
        call DosFileInfo
        add esp, byte 4
        test eax, eax
        jne short .15
        mov edx, str_SEASONNDX
        lea eax, [byte ebp-06Eh]
        call NameIndexNew
        jmp short .16
.15:
        mov edx, str_SEASONNDX
        lea eax, [byte ebp-06Eh]
        call NameIndexLoad
.16:
        mov esi, eax
        mov eax, esi
        call NameIndexLimit
        push eax
        push str_SEAS04dSET
        lea eax, [byte ebp-01Eh]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-01Eh]
        push eax
        lea eax, [byte ebp-06Eh]
        push eax
        push str_SS3
        lea eax, [dword ebp-0BEh]
        push eax
        call sprintf_
        add esp, byte 10h
        mov eax, esi
        mov dword [byte ebp+07Eh], 0
        call NameIndexLimit
        mov dword [SeasonSlot], eax
.17:
        imul ebx, dword [byte ebp+07Eh], byte 1Ch
        cmp byte [dword ebx+SeasonUserRecords], 0
        jne short .18
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [byte ebp+072h]
        shl edx, 3
        mov eax, dword [byte eax+014h]
        add eax, edx
        lea edx, [dword ebp-0126h]
        call FindTeamRecord
        mov eax, SeasonUserRecords
        lea edx, [dword ebp-0E8h]
        add eax, ebx
        call strcpy_
.18:
        inc dword [byte ebp+07Eh]
        cmp dword [byte ebp+07Eh], byte 1Ah
        jl short .17
        lea eax, [byte ebp+072h]
        call FreeDbBlock
        lea eax, [byte ebp+076h]
        call FreeDbBlock
        push dword 525h
        push SeasonName
        lea eax, [dword ebp-0BEh]
        push eax
        mov ebx, MatchupNote
        call SaveDataFileNew
        add esp, byte 0Ch
        lea edx, [byte ebp-01Eh]
        mov eax, esi
        call LoadNameIndex
        mov edx, eax
        mov eax, 1
        call NameIndexFree
        cmp dword [SeasonUserTeam], byte 0
        je short .19
        mov eax, SeasonUserTeam
        call FreeDbBlock
.19:
        mov edx, SeasonUserTeam
        mov eax, SeasonFilePath
        call OpenLeagueFile
        mov dword [gameopts], SeasonName
        test byte [SeasonFlags], 1
        je short .20
        call BuildSeasonSchedule
.20:
        mov dword [byte ebp+07Eh], 0
        jmp near .22
.21:
        mov edx, dword [byte ebp+07Eh]
        mov ecx, 36h
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        lea edi, [dword ebp-01C93h]
        add eax, edx
        lea edx, [dword ebp-01D1Ah]
        lea esi, [dword ebp-01D02h]
        call FindGameRecord
        rep movsb
        mov eax, dword [dword ebp-01015h]
        mov word [dword ebp-01C5Dh], ax
        mov eax, dword [dword ebp-0A99h]
        mov word [dword ebp-016E3h], ax
        mov eax, dword [dword ebp-09EFh]
        mov ebx, 578h
        mov word [dword ebp-01639h], ax
        mov eax, dword [dword ebp-0475h]
        lea edx, [dword ebp-01011h]
        mov word [dword ebp-010BFh], ax
        lea eax, [dword ebp-01C5Bh]
        call memcpy_
        mov ebx, 0A8h
        lea edx, [dword ebp-0A97h]
        lea eax, [dword ebp-016E1h]
        call memcpy_
        mov ebx, 578h
        lea edx, [dword ebp-09EDh]
        lea eax, [dword ebp-01637h]
        call memcpy_
        mov ebx, 0A8h
        lea edx, [dword ebp-0473h]
        lea eax, [dword ebp-010BDh]
        call memcpy_
        lea eax, [dword ebp-01D1Ah]
        inc dword [byte ebp+07Eh]
        call UpdateGameRecord
.22:
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [eax]
        cmp edx, dword [byte ebp+07Eh]
        jg near .21
        lea eax, [byte ebp+076h]
        call FreeDbBlock
CreateSeason_55B:
        lea esp, [dword ebp+082h]
CreateSeason_561:
        pop ebp
CreateSeason_562:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; RunSeasonMenus                                  8FFCF  96 PC, low confidence
; From RunFrontEnd: loads SEASON.NDX and runs the season screens
;-----------------------------------------------------------------------------
RunSeasonMenus:
        push edx
        mov edx, 0Ch
        cmp dword [SeasonMenuExit], byte 0
        je short .7
        mov edx, 1Ch
        mov dword [SeasonMenuExit], 0
        jmp short .7
.1:
        cmp edx, byte 0Ch
        jb short .2
        jbe short .5
        cmp edx, byte 19h
        je near .9
        jmp short .7
.2:
        cmp edx, byte 2
        je near .11
        jmp short .7
.3:
        call SeasonIntroScreen
.4:
        mov edx, 0Ch
        jmp short .7
.5:
        cmp dword [SeasonActive], byte 0
        je short .8
        call PlayoffTreeScreen
.6:
        mov edx, eax
.7:
        cmp edx, byte 1
        je near .14
        cmp edx, byte 0Eh
        je near .14
        cmp edx, byte 1Ch
        jb short .1
        jbe short .12
        cmp edx, byte 1Eh
        jb short .10
        jbe short .3
        cmp edx, byte 1Fh
        je short .13
        jmp short .7
.8:
        call SeasonMenuScreen
        jmp short .6
.9:
        mov eax, 1
        mov edx, 0Ch
        call RosterScreen
        jmp short .7
.10:
        call StandingsScreen
        jmp short .4
.11:
        mov edx, 0Ch
        mov byte [FrontEndExit], 0
        call RunStatsMenu
        jmp short .7
.12:
        call SeasonGameScreen
        mov edx, eax
        cmp eax, byte 1Ah
        jne short .7
        jmp short .4
.13:
        call AllStarScreen
        jmp short .6
.14:
        cmp edx, byte 0Eh
        jne short .15
        call ClearTeamInjuries
        mov dword [LinkScreensDone], 1
.15:
        mov eax, edx
        pop edx
        ret
;-----------------------------------------------------------------------------
; SeasonMenuSparkle                               900AE  97 PC, low confidence
; Plays a season menu sound and sparkle
;-----------------------------------------------------------------------------
SeasonMenuSparkle:
        push ebx
        push ecx
        push edx
        push esi
        call Random32
        mov ebx, 32h
        xor edx, edx
        div ebx
        xor esi, esi
        test edx, edx
        jne short .1
        call Random32
        mov ebx, 0Ah
        xor edx, edx
        div ebx
        push dword [nosplit edx*4+SeasonSparkleShapes]
        call DrawShapeAtOwnPos
        add esp, byte 4
.1:
        xor ebx, ebx
.2:
        lea eax, [byte ebx+02h]
        imul edx, eax, byte 52h
        mov eax, dword [SeasonMenuItems]
        cmp dword [byte edx+eax+04h], byte 1
        jne short .3
        call Random32
        mov esi, 3
        xor edx, edx
        div esi
        mov eax, edx
        imul edx, ebx, byte 0Ch
        push dword [dword edx+eax*4+SeasonMenuShapeLists]
        mov esi, 1
        call BlitShape2
        add esp, byte 4
.3:
        inc ebx
        cmp ebx, byte 6
        jl short .2
        test esi, esi
        je short .4
        cmp dword [SeasonSparkleSoundOn], byte 0
        jne short .4
        mov eax, 309h
        call PlaySfx
        mov dword [SeasonSparkleSoundOn], 1
.4:
        test esi, esi
        jne short .5
        cmp dword [SeasonSparkleSoundOn], byte 0
        je short .5
        call StopAllSfx
        mov dword [SeasonSparkleSoundOn], esi
.5:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SeasonMenuScreen                                90162  96 PC, low confidence
; The season menu (stn1-3, sta1-3, bt%02d buttons) of the current season
;-----------------------------------------------------------------------------
SeasonMenuScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 9C0h, 0
        call SetHighlightText
        mov dword [byte ebp-02Ch], 0FFFFFFFFh
        mov dword [byte ebp-024h], 3
        mov byte [byte ebp-010h], 0
        mov byte [byte ebp-0Ch], 0
        mov byte [byte ebp-08h], 0
        mov byte [byte ebp-04h], 0
        mov byte [byte ebp-014h], 1
        xor esi, esi
.1:
        imul eax, esi, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        jne short .2
        mov eax, dword [nosplit esi*4+PlayoffColumns]
        mov dword [byte ebp-024h], eax
.2:
        inc esi
        cmp esi, byte 1Ah
        jl short .1
        mov dword [gameopts], SeasonName
        call SeasonYearText
        push byte 0
        push dword 3E8h
        push str_Delstring
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 0B88h
        push str_Menu2
        mov dword [byte ebp-034h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [SeasonMenuItems], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 47h
        call LoadDataFile
        mov ebx, eax
        mov dword [byte ebp-018h], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 46h
        call LoadDataFile
        mov esi, eax
        mov dword [byte ebp-020h], eax
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push SeasonMenuShapeLists
        push str_SD00SD01SD02SD03
        push ebx
        call FindShapeList
        add esp, byte 0Ch
        push NewSeasonShapes
        push str_RL00RL01RL02RL03
        push ebx
        call FindShapeList
        add esp, byte 0Ch
        push SeasonNameShapes
        push str_SN00SN01SN02SN03
        push ebx
        call FindShapeList
        add esp, byte 0Ch
        push SeasonRecordShapes
        push str_SR00SR01SR02SR03
        push ebx
        call FindShapeList
        add esp, byte 0Ch
        push SeasonGameShapes
        push str_SG00SG01SG02SG03
        push ebx
        call FindShapeList
        add esp, byte 0Ch
        push SeasonDateShapes
        push str_DT00DT01DT02DT03
        push ebx
        call FindShapeList
        add esp, byte 0Ch
        push SeasonSparkleShapes
        push str_LBL1LBL2LBL3LBR1LBR2LTL1L2
        push esi
        call FindShapeList
        add esp, byte 0Ch
        mov eax, 24h
        mov edx, dword [SeasonMenuItems]
        call InitMenuItems
        cmp dword [byte ebp-024h], byte 3
        jne short .3
        push str_BGWS
        jmp short .4
.3:
        push str_BGES
.4:
        push esi
        call FindShape
        add esp, byte 8
        mov dword [byte ebp-01Ch], eax
        mov ebx, dword [byte ebp-01Ch]
        mov ecx, 52h
        mov edx, ebx
        mov eax, ebx
        mov esi, ScreenTitleItem
        call DrawScreenBackground
        mov edi, dword [SeasonMenuItems]
        rep movsb
        mov eax, dword [SeasonMenuItems]
        mov dword [eax], 0
        mov esi, dword [SeasonMenuItems]
        mov ecx, 52h
        lea edi, [byte esi+052h]
        mov esi, BlankMenuItem
        rep movsb
        mov eax, dword [SeasonMenuItems]
        mov dword [byte eax+052h], 1
        mov esi, dword [SeasonMenuItems]
        mov ecx, 52h
        lea edi, [dword esi+0B36h]
        mov esi, ScreenFrameItem
        rep movsb
        mov eax, dword [SeasonMenuItems]
        mov dword [dword eax+0B36h], 23h
        lea eax, [dword ebp-09C0h]
        push eax
        mov ebx, str_SD00
        mov edx, dword [byte ebp-018h]
        push str_SD02
        mov eax, dword [SeasonMenuItems]
        mov ecx, str_SD01
        add eax, 0A4h
        call DrawStatTable
        lea eax, [dword ebp-0980h]
        push eax
        mov ecx, str_RL01
        mov ebx, str_RL00
        push str_RL02
        mov eax, dword [SeasonMenuItems]
        mov edx, dword [byte ebp-018h]
        add eax, 0F6h
        call DrawStatTable
        lea eax, [dword ebp-0940h]
        push eax
        mov ecx, str_SN01
        mov ebx, str_SN00
        push str_SN02
        mov eax, dword [SeasonMenuItems]
        mov edx, dword [byte ebp-018h]
        add eax, 148h
        call DrawStatTable
        lea eax, [dword ebp-0900h]
        push eax
        mov ecx, str_SR01
        mov ebx, str_SR00
        push str_SR02
        mov eax, dword [SeasonMenuItems]
        mov edx, dword [byte ebp-018h]
        add eax, 19Ah
        call DrawStatTable
        lea eax, [dword ebp-08C0h]
        push eax
        mov ecx, str_SG01
        mov ebx, str_SG00
        push str_SG02
        mov eax, dword [SeasonMenuItems]
        mov edx, dword [byte ebp-018h]
        add eax, 1ECh
        call DrawStatTable
        lea eax, [dword ebp-0880h]
        push eax
        mov ecx, str_DT01
        mov ebx, str_DT00
        push str_DT02
        mov eax, dword [SeasonMenuItems]
        mov edx, dword [byte ebp-018h]
        add eax, 23Eh
        call DrawStatTable
        cmp dword [byte ebp-024h], byte 3
        jne short .5
        lea eax, [dword ebp-01C0h]
        push eax
        mov ecx, str_WC01
        mov ebx, str_WC00
        push str_WC01
        jmp short .6
.5:
        lea eax, [dword ebp-01C0h]
        push eax
        mov ecx, str_EC01
        mov ebx, str_EC00
        push str_EC01
.6:
        mov eax, dword [SeasonMenuItems]
        mov edx, dword [byte ebp-018h]
        add eax, 0AE4h
        call DrawStatTable
        xor esi, esi
.7:
        cmp dword [nosplit esi*4+StandingsColumns], byte 1
        jne short .8
        movzx eax, byte [byte ebp-010h]
        imul eax, byte 1Eh
        mov dword [byte ebp-028h], 64h
        add eax, 0C8h
        inc byte [byte ebp-010h]
        mov dword [byte ebp-030h], eax
.8:
        cmp dword [nosplit esi*4+StandingsColumns], byte 2
        jne short .9
        movzx eax, byte [byte ebp-08h]
        imul eax, byte 1Eh
        mov dword [byte ebp-028h], 14Dh
        add eax, 0C8h
        inc byte [byte ebp-08h]
        mov dword [byte ebp-030h], eax
.9:
        cmp dword [nosplit esi*4+StandingsColumns], byte 8
        jne short .10
        movzx eax, byte [byte ebp-0Ch]
        imul eax, byte 1Eh
        mov dword [byte ebp-028h], 64h
        add eax, 0C8h
        inc byte [byte ebp-0Ch]
        mov dword [byte ebp-030h], eax
.10:
        cmp dword [nosplit esi*4+StandingsColumns], byte 4
        jne short .11
        movzx eax, byte [byte ebp-04h]
        imul eax, byte 1Eh
        mov dword [byte ebp-028h], 14Dh
        add eax, 0C8h
        inc byte [byte ebp-04h]
        mov dword [byte ebp-030h], eax
.11:
        push byte 20h
        push byte 14h
        push dword 0A0h
        call CreateBitmap
        add esp, byte 0Ch
        push byte 20h
        mov ebx, esi
        push byte 14h
        shl ebx, 2
        push dword 0A0h
        mov dword [dword ebx+ebp-0118h], eax
        call CreateBitmap
        add esp, byte 0Ch
        push byte 20h
        push byte 14h
        push dword 0A0h
        mov dword [dword ebx+ebp-0180h], eax
        call CreateBitmap
        mov dword [dword ebx+ebp-0B0h], eax
        imul eax, esi, byte 1Ch
        add esp, byte 0Ch
        cmp byte [dword eax+SeasonUserActive], 1
        jne near .21
        xor ebx, ebx
.12:
        mov eax, esi
        shl eax, 2
        cmp ebx, byte 1
        jb short .13
        jbe short .15
        cmp ebx, byte 2
        je short .16
        jmp short .18
.13:
        test ebx, ebx
        jne short .18
        push dword [dword eax+ebp-0118h]
        call SetDrawTarget
        imul eax, esi, byte 1Ch
        add esp, byte 4
        cmp byte [dword eax+SeasonUserHuman], 1
        je short .14
        push byte 0FFFFFFFFh
        jmp short .17
.14:
        push dword 0FFAAAAAAh
        jmp short .17
.15:
        push dword [dword eax+ebp-0180h]
        call SetDrawTarget
        add esp, byte 4
        push dword 0FF00AAAAh
        jmp short .17
.16:
        push dword [dword eax+ebp-0B0h]
        call SetDrawTarget
        add esp, byte 4
        push dword 0FFFFFF50h
.17:
        call MakeColor
        add esp, byte 4
        call SetTextColor
.18:
        cmp dword [nosplit esi*4+PlayoffColumns], byte 3
        jne short .19
        mov eax, dword [byte ebp-01Ch]
        movsx eax, word [byte eax+0Eh]
        sub eax, dword [byte ebp-030h]
        push eax
        mov eax, dword [byte ebp-028h]
        neg eax
        push eax
        push str_BGWS
        jmp short .20
.19:
        mov eax, dword [byte ebp-01Ch]
        movsx eax, word [byte eax+0Eh]
        sub eax, dword [byte ebp-030h]
        push eax
        mov eax, dword [byte ebp-028h]
        neg eax
        push eax
        push str_BGES
.20:
        push dword [byte ebp-020h]
        call FindShape
        add esp, byte 8
        push eax
        call BlitClippedY
        add esp, byte 0Ch
        push esi
        push str_LG02d
        lea eax, [byte ebp-048h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-048h]
        push eax
        push dword [byte ebp-020h]
        call FindShape
        add esp, byte 8
        push byte 0
        push byte 0
        push eax
        call DrawArt
        imul eax, esi, byte 1Ch
        add esp, byte 0Ch
        add eax, SeasonUserRecords
        push eax
        push byte 0
        push byte 3Ch
        push byte 0
        inc ebx
        call DrawTextAligned
        add esp, byte 10h
        cmp ebx, byte 3
        jl near .12
        jmp near .24
.21:
        cmp byte [dword eax+SeasonUserActive], 0
        jne near .24
        push dword [dword ebx+ebp-0118h]
        call SetDrawTarget
        add esp, byte 4
        push dword 0FF505050h
        call MakeColor
        add esp, byte 4
        call SetTextColor
        cmp dword [dword ebx+PlayoffColumns], byte 3
        jne short .22
        mov eax, dword [byte ebp-01Ch]
        movsx eax, word [byte eax+0Eh]
        sub eax, dword [byte ebp-030h]
        push eax
        mov eax, dword [byte ebp-028h]
        neg eax
        push eax
        push str_BGWS
        jmp short .23
.22:
        mov eax, dword [byte ebp-01Ch]
        movsx eax, word [byte eax+0Eh]
        sub eax, dword [byte ebp-030h]
        push eax
        mov eax, dword [byte ebp-028h]
        neg eax
        push eax
        push str_BGES
.23:
        push dword [byte ebp-020h]
        call FindShape
        add esp, byte 8
        push eax
        call BlitClippedY
        add esp, byte 0Ch
        push esi
        push str_LG02d
        lea eax, [byte ebp-048h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-048h]
        push eax
        push dword [byte ebp-020h]
        call FindShape
        add esp, byte 8
        push byte 0
        push byte 0
        push eax
        call DrawArt
        imul eax, esi, byte 1Ch
        add esp, byte 0Ch
        add eax, SeasonUserRecords
        push eax
        push byte 0
        push byte 3Ch
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
.24:
        lea ebx, [byte esi+08h]
        imul ebx, byte 52h
        mov eax, dword [SeasonMenuItems]
        mov edx, dword [byte ebp-028h]
        mov dword [byte ebx+eax+026h], edx
        mov eax, dword [SeasonMenuItems]
        mov edx, dword [byte ebp-030h]
        mov dword [byte ebx+eax+02Ah], edx
        imul eax, esi, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        jne near .26
        mov eax, esi
        shl eax, 2
        mov edx, dword [byte ebp-024h]
        cmp edx, dword [dword eax+PlayoffColumns]
        jne near .26
        cmp byte [byte ebp-014h], 0
        je short .25
        mov edi, dword [dword eax+ebp-0B0h]
        mov edx, dword [SeasonMenuItems]
        mov ecx, dword [byte edi+02Ch]
        mov dword [byte edx+ebx+01Ah], ecx
        mov edx, dword [dword eax+ebp-0B0h]
        mov edi, dword [SeasonMenuItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte edi+ebx+01Eh], edx
        mov eax, dword [dword eax+ebp-0B0h]
        mov edx, dword [SeasonMenuItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte edx+ebx+022h], eax
        mov byte [byte ebp-014h], 0
        mov dword [SeasonDefaultUser], esi
        jmp near .27
.25:
        mov edi, dword [dword eax+ebp-0118h]
        mov edx, dword [SeasonMenuItems]
        mov ecx, dword [byte edi+02Ch]
        mov dword [byte edx+ebx+01Ah], ecx
        mov edi, dword [dword eax+ebp-0B0h]
        mov edx, dword [SeasonMenuItems]
        mov ecx, dword [byte edi+02Ch]
        mov dword [byte edx+ebx+01Eh], ecx
        mov eax, dword [dword eax+ebp-0B0h]
        mov edx, dword [SeasonMenuItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte edx+ebx+022h], eax
        jmp short .27
.26:
        mov eax, esi
        shl eax, 2
        mov edx, dword [byte ebp-024h]
        cmp edx, dword [dword eax+PlayoffColumns]
        jne short .27
        lea edi, [byte esi+08h]
        imul edi, byte 52h
        mov edx, dword [dword eax+ebp-0118h]
        mov ebx, dword [SeasonMenuItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte edi+ebx+01Ah], edx
        mov edx, dword [dword eax+ebp-0118h]
        mov ebx, dword [SeasonMenuItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte edi+ebx+01Eh], edx
        mov edx, dword [dword eax+ebp-0118h]
        mov eax, dword [SeasonMenuItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte edi+eax+022h], edx
.27:
        mov edx, dword [byte ebp-024h]
        cmp edx, dword [nosplit esi*4+PlayoffColumns]
        jne short .28
        lea edx, [byte esi+08h]
        imul edx, byte 52h
        mov eax, dword [SeasonMenuItems]
        mov dword [byte edx+eax+010h], 4
        mov eax, esi
        shl eax, 6
        lea edi, [dword ebp-09C0h]
        add eax, 180h
        push byte 14h
        add edi, eax
        mov eax, dword [SeasonMenuItems]
        mov ecx, 0A0h
        mov ebx, dword [byte ebp-030h]
        mov dword [byte edx+eax+014h], edi
        mov edx, dword [byte ebp-028h]
        mov eax, edi
        call SetRegionRect
.28:
        inc esi
        cmp esi, byte 1Ah
        jl near .7
        push byte 0
        push dword 1E0h
        push dword 280h
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov edi, eax
        call SetDrawTarget
        add esp, byte 4
        push dword [byte ebp-01Ch]
        call BlitShape
        add esp, byte 4
        cmp dword [byte ebp-024h], byte 3
        jne short .29
        push str_TTLW
        push dword [byte ebp-018h]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_DIV3
        push dword [byte ebp-018h]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_DIV4
        jmp short .30
.29:
        push str_TTLE
        push dword [byte ebp-018h]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_DIV1
        push dword [byte ebp-018h]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_DIV2
.30:
        push dword [byte ebp-018h]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        mov esi, 1
.31:
        push dword [nosplit esi*4+SeasonSparkleShapes]
        call DrawShapeAtOwnPos
        inc esi
        inc esi
        add esp, byte 4
        cmp esi, byte 8
        jl short .31
        xor esi, esi
.32:
        lea edx, [byte esi+02h]
        imul edx, byte 52h
        mov eax, dword [SeasonMenuItems]
        push dword [byte edx+eax+02Ah]
        push dword [byte edx+eax+026h]
        push dword [byte edx+eax+01Ah]
        inc esi
        call DrawShapeCore
        add esp, byte 0Ch
        cmp esi, byte 6
        jl short .32
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte edi+02Ch]
        call WipeScreen
.33:
        mov eax, dword [byte ebp-01Ch]
        call DrawSeasonTitle
.34:
        cmp dword [byte ebp-02Ch], byte 0FFFFFFFFh
        jne near .83
        push byte 3
        lea eax, [byte ebp-040h]
        mov ecx, SeasonMenuSparkle
        mov ebx, 0FFFFFFFFh
        push eax
        mov edx, dword [SeasonMenuItems]
        mov eax, 23h
        call RunMenu
        cmp dword [byte ebp-040h], byte 4
        jb short .36
        jbe near .46
        cmp dword [byte ebp-040h], byte 7
        jb short .35
        jbe near .52
        cmp dword [byte ebp-040h], byte 22h
        jb near .79
        jbe near .67
        cmp dword [byte ebp-040h], byte 23h
        je near .42
        jmp near .79
.35:
        cmp dword [byte ebp-040h], byte 5
        jbe near .50
        jmp near .51
.36:
        cmp dword [byte ebp-040h], byte 1
        jb short .37
        jbe short .38
        cmp dword [byte ebp-040h], byte 2
        jbe short .43
        jmp near .45
.37:
        cmp dword [byte ebp-040h], byte 0
        jne near .79
        call ShowScreen
        mov dword [byte ebp-02Ch], 1
        jmp near .34
.38:
        call FadeInScreen
        imul eax, dword [SeasonDefaultUser], byte 1Ch
        cmp byte [dword eax+SeasonUserHuman], 1
        jne short .41
        push byte 1
        mov edx, 1
        mov eax, 7Eh
.39:
        xor ecx, ecx
        xor ebx, ebx
.40:
        call GetLangText
        call ShowMessageBox
        jmp near .34
.41:
        mov dword [byte ebp-02Ch], 1Ch
        jmp near .34
.42:
        call ExitScreen
        jmp near .34
.43:
        mov eax, dword [SeasonMenuItems]
        add eax, 0A4h
        mov dword [byte ebp-02Ch], 1Dh
.44:
        call ShowPopupScreen
        jmp near .34
.45:
        mov eax, dword [SeasonMenuItems]
        add eax, 0F6h
        call ShowPopupScreen
        mov eax, 2
        call SeasonSetupScreen
        jmp near .34
.46:
        cmp dword [LinkGameActive], byte 0
        jne short .47
        push byte 0
        mov eax, 248h
        mov ecx, 1
        xor ebx, ebx
        mov edx, ecx
        jmp short .40
.47:
        imul eax, dword [SeasonDefaultUser], byte 1Ch
        cmp byte [dword eax+SeasonUserHuman], 2
        jne short .48
        mov byte [dword eax+SeasonUserHuman], 0
        jmp near .33
.48:
        cmp byte [dword eax+SeasonUserHuman], 1
        jne short .49
        push byte 0
        mov eax, 249h
        mov ecx, 1
        xor ebx, ebx
        mov edx, ecx
        call GetLangText
        call ShowMessageBox
        jmp near .33
.49:
        cmp byte [dword eax+SeasonUserHuman], 0
        jne near .33
        mov byte [dword eax+SeasonUserHuman], 2
        jmp near .33
.50:
        mov eax, dword [SeasonMenuItems]
        add eax, 19Ah
        mov dword [byte ebp-02Ch], 19h
        jmp near .44
.51:
        mov eax, dword [SeasonMenuItems]
        add eax, 1ECh
        mov dword [byte ebp-02Ch], 2
        jmp near .44
.52:
        mov eax, 7Fh
        call GetLangText
        xor ebx, ebx
        xor esi, esi
        mov edx, eax
        mov eax, dword [byte ebp-034h]
        mov dword [byte ebp-03Ch], ebx
        call strcpy_
.53:
        imul eax, esi, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        jne short .54
        inc dword [byte ebp-03Ch]
.54:
        cmp esi, dword [SeasonDefaultUser]
        je short .55
        imul eax, esi, byte 1Ch
        cmp byte [dword eax+SeasonUserHuman], 1
        jne short .56
.55:
        imul edx, esi, byte 1Ch
        mov eax, dword [byte ebp-034h]
        add edx, SeasonUserRecords
        call strcat_
        mov edx, str_Punct_SeasonMenuScreen
        mov eax, dword [byte ebp-034h]
        inc ebx
        call strcat_
.56:
        inc esi
        cmp esi, byte 1Ah
        jl short .53
        cmp ebx, dword [byte ebp-03Ch]
        jne short .57
        push byte 1
        mov eax, 80h
        mov edx, 1
        jmp near .39
.57:
        push byte 1
        mov ecx, 1
        mov edx, 2
        mov eax, dword [byte ebp-034h]
        xor ebx, ebx
        call ShowMessageBox
        test eax, eax
        je near .34
        mov byte [byte ebp-014h], 1
        xor esi, esi
.58:
        cmp esi, dword [SeasonDefaultUser]
        je short .59
        imul eax, esi, byte 1Ch
        cmp byte [dword eax+SeasonUserHuman], 1
        jne near .64
.59:
        imul eax, esi, byte 1Ch
        push dword 0FF505050h
        mov byte [dword eax+SeasonUserActive], 0
        call MakeColor
        add esp, byte 4
        call SetTextColor
        push dword [dword ebp+esi*4-0118h]
        call SetDrawTarget
        lea eax, [byte esi+08h]
        imul eax, byte 52h
        add esp, byte 4
        cmp dword [nosplit esi*4+PlayoffColumns], byte 3
        jne short .60
        mov edx, dword [SeasonMenuItems]
        add eax, edx
        mov edx, dword [byte ebp-01Ch]
        movsx edx, word [byte edx+0Eh]
        sub edx, dword [byte eax+02Ah]
        mov eax, dword [byte eax+026h]
        push edx
        neg eax
        push eax
        push str_BGWS
        jmp short .61
.60:
        mov edx, dword [SeasonMenuItems]
        add eax, edx
        mov edx, dword [byte ebp-01Ch]
        movsx edx, word [byte edx+0Eh]
        sub edx, dword [byte eax+02Ah]
        mov eax, dword [byte eax+026h]
        push edx
        neg eax
        push eax
        push str_BGES
.61:
        push dword [byte ebp-020h]
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        push esi
        push str_LG02d
        lea eax, [byte ebp-048h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-048h]
        push eax
        push dword [byte ebp-020h]
        call FindShape
        add esp, byte 8
        push byte 0
        push byte 0
        push eax
        call DrawArt
        imul eax, esi, byte 1Ch
        add esp, byte 0Ch
        add eax, SeasonUserRecords
        push eax
        push byte 0
        push byte 3Ch
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        push dword [dword ebp+esi*4-0B0h]
        call SetDrawTarget
        lea eax, [byte esi+08h]
        imul eax, byte 52h
        add esp, byte 4
        cmp dword [nosplit esi*4+PlayoffColumns], byte 3
        jne short .62
        mov edx, dword [SeasonMenuItems]
        add eax, edx
        mov edx, dword [byte ebp-01Ch]
        movsx edx, word [byte edx+0Eh]
        sub edx, dword [byte eax+02Ah]
        mov eax, dword [byte eax+026h]
        push edx
        neg eax
        push eax
        push str_BGWS
        jmp short .63
.62:
        mov edx, dword [SeasonMenuItems]
        add eax, edx
        mov edx, dword [byte ebp-01Ch]
        movsx edx, word [byte edx+0Eh]
        sub edx, dword [byte eax+02Ah]
        mov eax, dword [byte eax+026h]
        push edx
        neg eax
        push eax
        push str_BGES
.63:
        push dword [byte ebp-020h]
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        push esi
        push str_LG02d
        lea eax, [byte ebp-048h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-048h]
        push eax
        push dword [byte ebp-020h]
        call FindShape
        add esp, byte 8
        push byte 0
        push byte 0
        push eax
        call DrawArt
        imul eax, esi, byte 1Ch
        add esp, byte 0Ch
        add eax, SeasonUserRecords
        push eax
        push byte 0
        push byte 3Ch
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
.64:
        inc esi
        cmp esi, byte 1Ah
        jl near .58
        xor esi, esi
.65:
        imul eax, esi, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        jne short .66
        cmp byte [byte ebp-014h], 0
        je short .66
        lea edx, [byte esi+08h]
        imul edx, byte 52h
        mov eax, dword [dword ebp+esi*4-0B0h]
        mov ebx, dword [SeasonMenuItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte edx+ebx+01Ah], eax
        mov byte [byte ebp-014h], 0
        mov dword [SeasonDefaultUser], esi
.66:
        inc esi
        cmp esi, byte 1Ah
        jl short .65
        jmp near .34
.67:
        cmp dword [byte ebp-024h], byte 3
        jne near .68
        push str_BGES
        push dword [byte ebp-020h]
        call FindShape
        mov esi, eax
        add esp, byte 8
        mov ebx, eax
        mov edx, eax
        mov dword [byte ebp-01Ch], eax
        call DrawScreenBackground
        lea eax, [dword ebp-01C0h]
        push eax
        mov ecx, str_EC01
        mov ebx, str_EC00
        push str_EC01
        mov eax, dword [SeasonMenuItems]
        mov edx, dword [byte ebp-018h]
        add eax, 0AE4h
        call DrawStatTable
        push edi
        call SetDrawTarget
        add esp, byte 4
        push esi
        call BlitShape
        add esp, byte 4
        push str_TTLE
        push dword [byte ebp-018h]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_DIV1
        push dword [byte ebp-018h]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_DIV2
        push dword [byte ebp-018h]
        call FindShape
        add esp, byte 8
        push eax
        mov dword [byte ebp-024h], 0Ch
        jmp near .69
.68:
        push str_BGWS
        push dword [byte ebp-020h]
        call FindShape
        mov esi, eax
        add esp, byte 8
        mov ebx, eax
        mov edx, eax
        mov dword [byte ebp-01Ch], eax
        call DrawScreenBackground
        lea eax, [dword ebp-01C0h]
        push eax
        mov ecx, str_WC01
        mov ebx, str_WC00
        push str_WC01
        mov eax, dword [SeasonMenuItems]
        mov edx, dword [byte ebp-018h]
        add eax, 0AE4h
        call DrawStatTable
        push edi
        call SetDrawTarget
        add esp, byte 4
        push esi
        call BlitShape
        add esp, byte 4
        push str_TTLW
        push dword [byte ebp-018h]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_DIV3
        push dword [byte ebp-018h]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_DIV4
        push dword [byte ebp-018h]
        call FindShape
        add esp, byte 8
        push eax
        mov dword [byte ebp-024h], 3
.69:
        call BlitShape
        add esp, byte 4
        mov esi, 1
.70:
        push dword [nosplit esi*4+SeasonSparkleShapes]
        call DrawShapeAtOwnPos
        inc esi
        inc esi
        add esp, byte 4
        cmp esi, byte 8
        jl short .70
        xor esi, esi
.71:
        lea eax, [byte esi+02h]
        imul edx, eax, byte 52h
        mov eax, dword [SeasonMenuItems]
        push dword [byte edx+eax+02Ah]
        push dword [byte edx+eax+026h]
        push dword [byte edx+eax+01Ah]
        inc esi
        call DrawShapeCore
        add esp, byte 0Ch
        cmp esi, byte 6
        jl short .71
        call SetScreenTarget
        push byte 0
        push byte 0
        push dword [byte edi+02Ch]
        call BlitArt
        add esp, byte 0Ch
        xor esi, esi
        call PresentScreen
.72:
        mov eax, esi
        lea ebx, [byte esi+08h]
        imul ebx, byte 52h
        shl eax, 2
        mov edx, dword [byte ebp-024h]
        cmp edx, dword [dword eax+PlayoffColumns]
        jne near .77
        imul edx, esi, byte 1Ch
        cmp byte [dword edx+SeasonUserActive], 1
        jne short .75
        cmp esi, dword [SeasonDefaultUser]
        jne short .73
        mov eax, dword [dword eax+ebp-0B0h]
        jmp short .74
.73:
        mov eax, dword [dword eax+ebp-0118h]
.74:
        mov edx, dword [SeasonMenuItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte edx+ebx+01Ah], eax
        lea edx, [byte esi+08h]
        imul edx, byte 52h
        mov dword [byte ebp-038h], edx
        mov edx, dword [SeasonMenuItems]
        mov ebx, dword [dword ebp+esi*4-0B0h]
        add edx, dword [byte ebp-038h]
        mov ebx, dword [byte ebx+02Ch]
        mov dword [byte edx+01Eh], ebx
        mov edx, dword [SeasonMenuItems]
        mov eax, dword [dword ebp+esi*4-0B0h]
        add edx, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte edx+022h], eax
        jmp short .76
.75:
        mov ecx, dword [SeasonMenuItems]
        mov edx, dword [dword eax+ebp-0118h]
        add ecx, ebx
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ecx+01Ah], edx
        mov ecx, dword [SeasonMenuItems]
        mov edx, dword [dword eax+ebp-0118h]
        add ecx, ebx
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ecx+01Eh], edx
        mov eax, dword [dword eax+ebp-0118h]
        mov edx, dword [SeasonMenuItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte edx+ebx+022h], eax
.76:
        lea edx, [byte esi+08h]
        imul edx, byte 52h
        mov ebx, esi
        shl ebx, 6
        mov eax, dword [SeasonMenuItems]
        add ebx, 180h
        mov dword [byte edx+eax+010h], 4
        lea eax, [dword ebp-09C0h]
        add eax, ebx
        mov dword [byte ebp-038h], eax
        mov eax, dword [SeasonMenuItems]
        mov ebx, dword [byte ebp-038h]
        mov dword [byte edx+eax+014h], ebx
        mov eax, dword [SeasonMenuItems]
        push byte 14h
        mov ecx, 0A0h
        mov ebx, dword [byte edx+eax+02Ah]
        mov edx, dword [byte edx+eax+026h]
        mov eax, dword [byte ebp-038h]
        call SetRegionRect
        jmp short .78
.77:
        mov eax, dword [SeasonMenuItems]
        mov dword [byte ebx+eax+022h], 0
        mov edx, dword [byte ebx+eax+022h]
        mov eax, dword [SeasonMenuItems]
        mov dword [byte ebx+eax+01Eh], edx
        mov eax, dword [SeasonMenuItems]
        mov dword [byte ebx+eax+01Ah], edx
        mov eax, dword [SeasonMenuItems]
        mov dword [byte ebx+eax+010h], 0
.78:
        inc esi
        cmp esi, byte 1Ah
        jl near .72
        jmp near .33
.79:
        mov ebx, dword [byte ebp-040h]
        sub ebx, byte 8
        imul eax, ebx, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        jne near .33
        imul eax, dword [SeasonDefaultUser], byte 1Ch
        cmp byte [dword eax+SeasonUserHuman], 0
        je short .80
        cmp byte [dword eax+SeasonUserHuman], 1
        jne short .81
.80:
        mov eax, dword [SeasonDefaultUser]
        shl eax, 2
        mov edx, dword [dword eax+PlayoffColumns]
        cmp edx, dword [byte ebp-024h]
        jne short .82
        mov edx, dword [SeasonDefaultUser]
        add edx, byte 8
        imul edx, byte 52h
        mov eax, dword [dword eax+ebp-0118h]
        mov ecx, dword [SeasonMenuItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte ecx+edx+01Ah], eax
        jmp short .82
.81:
        mov eax, dword [SeasonDefaultUser]
        shl eax, 2
        mov edx, dword [dword eax+PlayoffColumns]
        cmp edx, dword [byte ebp-024h]
        jne short .82
        mov edx, dword [dword eax+ebp-0180h]
        mov eax, dword [SeasonDefaultUser]
        add eax, byte 8
        imul eax, byte 52h
        mov ecx, dword [SeasonMenuItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ecx+eax+01Ah], edx
.82:
        imul ecx, dword [byte ebp-040h], byte 52h
        mov edx, dword [dword ebp+ebx*4-0B0h]
        mov eax, dword [SeasonMenuItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ecx+eax+01Ah], edx
        mov dword [SeasonDefaultUser], ebx
        jmp near .33
.83:
        mov eax, dword [SeasonDefaultUser]
        call FindSeasonReplay
        test eax, eax
        je short .84
        cmp dword [byte ebp-02Ch], byte 1Ch
        jne short .84
        mov dword [byte ebp-02Ch], 0Eh
        mov dword [PlayMenuGameFlag], 1
.84:
        push dword [byte ebp-020h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp-018h]
        xor esi, esi
        call FreeMemBlock
        add esp, byte 4
.85:
        push dword [dword ebp+esi*4-0B0h]
        call FreeBitmap
        add esp, byte 4
        push dword [dword ebp+esi*4-0118h]
        call FreeBitmap
        add esp, byte 4
        push dword [dword ebp+esi*4-0180h]
        inc esi
        call FreeBitmap
        add esp, byte 4
        cmp esi, byte 1Ah
        jl short .85
        push dword [byte ebp-034h]
        call FreeMemBlock
        add esp, byte 4
        push dword [SeasonMenuItems]
        call FreeMemBlock
        add esp, byte 4
        push edi
        call FreeBitmap
        add esp, byte 4
        call SeasonSettingsPath
        jmp near NewSeasonScreen_DCB
