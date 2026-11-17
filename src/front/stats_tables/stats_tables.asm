; Team and league stats screens and their columns.
bits 32
%include "hockey.inc"
section s_ADB4F progbits alloc exec nowrite align=1
extern AllocMemBlock, AllocStatTable, AllocStatTable_2AA, BlankMenuItem, BlitArt, BlitClippedY, BlitShape2, ChangeMenuMusic
extern ClearScreen, ConvertArtNew, CreateBitmap, DrawArt, DrawScreenBackground, DrawShadedLogo, DrawShapeBlended, DrawSpriteScaledBy
extern DrawStatsBackground, DrawStatTable, DrawStatTableRows, DrawTextAligned, ExitScreen, ExportStatTable, FadeInScreen, FindGameRecord
extern FindPlayerRecord, FindPlayerStat, FindShape, FindShapeList, FindTeamRecord, FindTeamStat, FreeBitmap, FreeDbBlock
extern FreeMemBlock, FreeStatsBitmap, FreeStatTable, FrontEndExit, FrontMusicOn, GameSettings, GetLangText, HideLinkBox
extern InitMenuItems, KeysEqual, LinkGameActive, LinkSyncMenu, LinkSyncScreen, LoadDataFile, LoadFrontEndSfx, MakeColor
extern memset_, MenuScreenBitmap, MusicEnabled, OpenArtArchiveErr, OpenDataLibrary, OpenLeagueFile, PlayMenuSfx, PlayoffDbKey
extern PlayoffStatsPath, PlayoffTeams, PlayScreenMovie, PlaySfx, PresentScreen, rand_, RestoreStatsScreen, RunMenu
extern RunScrollList, SaveStatsScreen, ScreenFrameItem, SeasonActive, SeasonDbKey, SeasonFilePath, SeasonStatsPath, SecondsToSamples
extern ServiceIdle, SetDrawTarget, SetHighlightText, SetNormalText, SetScreenTarget, SetTextColor, ShowLinkMessage, ShowStatScreen
extern ShowStatsScreen, SortStatTable, SortStatTableBy, sprintf_, StandingsColumns, StatsArrowDown, StatsArrowUp, StatsBackArt
extern StatsBackItem, StatsColumn, StatsColumnFields, StatsHeaderShape, StatsMenuDrawn, StatsMenuItems, StatsMenuMode, StatsPlayoffMode
extern StatsRowShape, StatsShapeLists, StatsSoundPlayed, StatsSparkleShape, StatTableAlpha, StatTableColumns, StatTableSortColumn, StatTableSortText
extern str_00006, str_Ai, str_Avg, str_Avgt, str_CSS, str_Gai, str_Gnameptrs, str_Gnames
extern str_Gstats, str_High, str_LABL, str_LAHL, str_LB02d2, str_LB26, str_LH02d, str_LH26
extern str_LOGO02dFSH, str_LOGO6, str_Menu4, str_Mpick, str_Nameptrs, str_Names, str_NHLP2, str_Pkpct
extern str_Pppct, str_Pstats, str_Pts, str_Punct_StatsTablesScreen, str_RABL, str_RAHL, str_Rawteams, str_Reg
extern str_Rosters, str_RS00, str_RS01, str_RS01RS02RS03, str_RS02, str_RS04, str_RS05, str_RS05RS06RS07
extern str_RS06, str_RS08, str_RS09, str_RS09RS10RS11, str_RS09RS11RS11, str_RS10, str_RS12, str_RS13
extern str_RS13RS14RS15, str_RS14, str_RS16, str_RS17, str_RS17RS18RS19, str_RS18, str_RS20, str_RS21
extern str_RS21RS22RS23, str_RS22, str_RS24, str_RS25, str_RS25RS26RS27, str_RS26, str_RS28, str_RS29
extern str_RS29RS30RS31, str_RS30, str_RS32, str_RS33, str_RS33RS34RS35, str_RS34, str_RS36, str_RS37
extern str_RS37RS38RS39, str_RS38, str_SD02dSD02d, str_SD02dSDD, str_SDDSD, str_SDDSD2, str_SDDSDD, str_SgPros
extern str_SgPrts, str_SgRos, str_SgRts, str_STTL, str_TS00, str_TS01, str_TS02, str_TS03
extern str_TS04, str_TS05, str_TS06, str_TS07, str_TS08, str_TS09, str_TS10, str_TS11
extern str_TS12, str_TS13, str_TS14, str_TS15, str_TS16, str_TS17, str_TS18, str_TS19
extern str_TS20, str_TS21, str_TS22, str_TS23, str_TS24, str_TS25, str_TS26, str_TS27
extern str_TS28, str_TS29, str_TS30, str_TS31, str_TS32, str_TS33, str_TS34, str_TS35
extern str_TS36, str_TS37, str_TS38, str_TS39, str_TS40, str_TS41, str_TS42, str_TS43
extern str_TS44, str_TS45, str_TS46, str_TS47, str_TS48, str_TS49, str_TS50, str_TS51
extern str_TS52, str_TTL0, str_TTL1, strlen_, TeamStatsBarEnd, TeamStatsBarShape, TeamStatsBitmap, TeamStatsGlowShape
extern TeamStatsLogoShape, TeamStatsNameShape, TeamStatsPanelShape, TeamStatsShapeBottom, TeamStatsShapeTop, WaitSoundTime, WipeScreen
global TeamStatsSound, TeamStatsScreenJumpTable, TeamStatsScreen, TeamStatsScreen_FC4, TeamStatsScreen_1027, TeamStatsScreen_108A, TeamStatsScreen_10ED, TeamStatsScreen_13BC
global TeamStatsScreen_13C3, StatsScreenSound, StatsTablesScreenJumpTable, StatsTablesScreen, StatsTablesScreen_B17, StatsTablesScreen_BC9, StatsTablesScreen_C68, StatsTablesScreen_D0E
global BuildTeamStatsTable, SetSkaterStatColumns, SetGoalieStatColumns, SetTeamStatColumns, UserRecordScaleSteps, UserRecordScaleHalf, UserRecordScalePair, UserRecordScaleQuarter
;-----------------------------------------------------------------------------
; TeamStatsSound                                  ADB4F  97 PC, low confidence
; Plays a team stats sound
;-----------------------------------------------------------------------------
TeamStatsSound:
        push ebx
        push ecx
        push edx
        xor ebx, ebx
        xor edx, edx
.1:
        lea eax, [byte ebx+01h]
        imul ecx, eax, byte 52h
        mov eax, dword [StatsMenuItems]
        cmp dword [byte ecx+eax+04h], byte 1
        jne short .2
        call rand_
        mov ecx, 3
        cdq
        idiv ecx
        mov eax, edx
        imul edx, ebx, byte 0Ch
        push dword [dword edx+eax*4+StatsShapeLists]
        call BlitShape2
        mov edx, 1
        add esp, byte 4
.2:
        inc ebx
        cmp ebx, byte 5
        jl short .1
        test edx, edx
        je short .3
        cmp dword [StatsSoundPlayed], byte 0
        jne short .3
        mov eax, 309h
        call PlaySfx
        mov dword [StatsSoundPlayed], 1
.3:
        test edx, edx
        jne short .4
        cmp dword [StatsSoundPlayed], byte 0
        je short .4
        mov eax, 309h
        call PlayMenuSfx
        mov dword [StatsSoundPlayed], edx
.4:
        pop edx
        pop ecx
        pop ebx
        ret
TeamStatsScreenJumpTable:                       ; jump table for the switch cases of TeamStatsScreen
        dd TeamStatsScreen_FC4
        dd TeamStatsScreen_1027
        dd TeamStatsScreen_108A
        dd TeamStatsScreen_10ED
;-----------------------------------------------------------------------------
; TeamStatsScreen                                 ADBE6  96 PC, low confidence
; From RunStatsMenu: the team stats screen ("pts", "pppct", "pkpct", "avgt",
; "high"; "menu" / "reg"; SetTeamStatColumns)
;-----------------------------------------------------------------------------
TeamStatsScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 2F8h, 0
        sub ebp, 82h
        push byte 0
        push byte 14h
        push dword 1B8h
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push byte 34h
        push str_Pts
        mov dword [byte ebp+02Ah], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push byte 34h
        push str_Pppct
        mov dword [byte ebp+032h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push byte 34h
        push str_Pkpct
        mov dword [byte ebp+04Eh], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push byte 68h
        push str_Avgt
        mov dword [byte ebp+036h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push byte 68h
        push str_High
        mov dword [byte ebp+062h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 2432h
        push str_Menu4
        mov dword [byte ebp+05Eh], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 1A00h
        push str_Reg
        mov dword [StatsMenuItems], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        mov dword [byte ebp+046h], 0FFFFFFFFh
        mov dword [byte ebp+07Ah], 0
        push dword 29206h
        mov dword [byte ebp+01Eh], 0
        mov dword [byte ebp+066h], 0
        push str_SgRos
        mov dword [byte ebp+06Ah], 0
        mov dword [byte ebp+076h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp+052h], eax
        push byte 0
        push dword 0A5Ch
        push str_SgRts
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 194F0h
        push str_SgPros
        mov dword [byte ebp+04Ah], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 660h
        push str_SgPrts
        mov dword [byte ebp+056h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push byte 20h
        push str_Pts
        mov dword [byte ebp+042h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push byte 20h
        push str_Pppct
        mov dword [byte ebp+03Eh], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push byte 20h
        push str_Pkpct
        mov dword [byte ebp+03Ah], eax
        call AllocMemBlock
        mov edx, dword [StatsMenuItems]
        add esp, byte 0Ch
        mov dword [byte ebp+02Eh], eax
        mov eax, 71h
        call InitMenuItems
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 28h
        call LoadDataFile
        mov ecx, eax
        mov dword [byte ebp+022h], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 29h
        call LoadDataFile
        mov ebx, eax
        mov dword [byte ebp+07Eh], eax
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push str_00006
        push ecx
        call FindShape
        add esp, byte 8
        push str_STTL
        push ebx
        mov dword [byte ebp+072h], eax
        call FindShape
        add esp, byte 8
        mov dword [byte ebp+026h], eax
        call SetHighlightText
        cmp byte [FrontEndExit], 0
        je short .1
        mov dword [byte ebp+066h], SeasonDbKey
        mov dword [byte ebp+06Ah], PlayoffDbKey
        jmp short .4
.1:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 20h
        jne short .2
        mov dword [StatsPlayoffMode], 1
        mov dword [byte ebp+066h], PlayoffStatsPath
        jmp short .4
.2:
        mov dword [byte ebp+06Ah], SeasonFilePath
        cmp dword [SeasonActive], byte 0
        je short .3
        mov dword [byte ebp+066h], SeasonStatsPath
.3:
        mov dword [StatsPlayoffMode], 0
.4:
        cmp dword [byte ebp+06Ah], byte 0
        je short .5
        lea edx, [byte ebp+0Eh]
        mov eax, dword [byte ebp+06Ah]
        call OpenLeagueFile
.5:
        cmp dword [byte ebp+066h], byte 0
        je short .6
        lea edx, [byte ebp+012h]
        mov eax, dword [byte ebp+066h]
        call OpenLeagueFile
.6:
        cmp dword [byte ebp+06Ah], byte 0
        je near .12
        xor ebx, ebx
.7:
        imul ecx, ebx, dword 194Fh
        mov eax, dword [byte ebp+0Eh]
        mov edx, ebx
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add ecx, dword [byte ebp+052h]
        add eax, edx
        mov edx, ecx
        call FindGameRecord
        movzx ax, byte [byte ecx+050h]
        movzx dx, byte [byte ecx+052h]
        add eax, eax
        lea esi, [ebx+ebx]
        add edx, eax
        mov eax, dword [byte ebp+032h]
        mov word [esi+eax], dx
        add esi, dword [byte ebp+04Eh]
        cmp word [byte ecx+06Dh], byte 0
        je short .8
        movsx eax, word [byte ecx+06Fh]
        imul eax, dword 3E8h
        movsx ecx, word [byte ecx+06Dh]
        cdq
        idiv ecx
        mov word [esi], ax
        jmp short .9
.8:
        mov word [esi], 0
.9:
        imul eax, ebx, dword 194Fh
        lea ecx, [ebx+ebx]
        add eax, dword [byte ebp+052h]
        add ecx, dword [byte ebp+036h]
        cmp word [byte eax+067h], byte 0
        je short .10
        movsx edx, word [byte eax+06Bh]
        imul edx, dword 3E8h
        movsx esi, word [byte eax+067h]
        mov eax, edx
        cdq
        idiv esi
        mov edx, 3E8h
        sub edx, eax
        mov word [ecx], dx
        jmp short .11
.10:
        mov word [ecx], 0
.11:
        imul edx, ebx, byte 66h
        mov eax, dword [byte ebp+0Eh]
        mov ecx, ebx
        mov eax, dword [byte eax+014h]
        shl ecx, 3
        add edx, dword [byte ebp+04Ah]
        add eax, ecx
        inc ebx
        call FindTeamRecord
        cmp ebx, byte 1Ah
        jl near .7
.12:
        cmp dword [byte ebp+066h], byte 0
        je near .19
        xor ebx, ebx
        jmp near .18
.13:
        imul ecx, ebx, dword 194Fh
        mov eax, dword [byte ebp+012h]
        mov edx, ebx
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add ecx, dword [byte ebp+056h]
        add eax, edx
        mov edx, ecx
        call FindGameRecord
        movzx dx, byte [byte ecx+050h]
        movzx ax, byte [byte ecx+052h]
        add edx, edx
        lea esi, [ebx+ebx]
        add edx, eax
        mov eax, dword [byte ebp+03Eh]
        mov word [esi+eax], dx
        add esi, dword [byte ebp+03Ah]
        cmp word [byte ecx+06Dh], byte 0
        je short .14
        movsx eax, word [byte ecx+06Fh]
        imul eax, dword 3E8h
        movsx ecx, word [byte ecx+06Dh]
        cdq
        idiv ecx
        mov word [esi], ax
        jmp short .15
.14:
        mov word [esi], 0
.15:
        imul eax, ebx, dword 194Fh
        lea ecx, [ebx+ebx]
        add eax, dword [byte ebp+056h]
        add ecx, dword [byte ebp+02Eh]
        cmp word [byte eax+067h], byte 0
        je short .16
        movsx edx, word [byte eax+069h]
        imul edx, dword 3E8h
        movsx esi, word [byte eax+067h]
        mov eax, edx
        cdq
        idiv esi
        mov edx, 3E8h
        sub edx, eax
        mov word [ecx], dx
        jmp short .17
.16:
        mov word [ecx], 0
.17:
        imul edx, ebx, byte 66h
        mov eax, dword [byte ebp+012h]
        mov ecx, ebx
        mov eax, dword [byte eax+014h]
        shl ecx, 3
        add edx, dword [byte ebp+042h]
        add eax, ecx
        inc ebx
        call FindTeamRecord
.18:
        mov eax, dword [byte ebp+012h]
        movsx eax, word [eax]
        cmp ebx, eax
        jl near .13
.19:
        cmp dword [byte ebp+06Ah], byte 0
        je short .20
        cmp dword [StatsPlayoffMode], byte 0
        jne short .20
        push dword [byte ebp+0Eh]
        push dword [byte ebp+036h]
        push dword [byte ebp+04Eh]
        mov eax, dword [byte ebp+076h]
        push dword [byte ebp+032h]
        mov ebx, dword [byte ebp+04Ah]
        push byte 1Ah
        mov edx, dword [byte ebp+052h]
        add eax, 140h
        push dword [byte ebp+072h]
        mov ecx, dword [StatsMenuItems]
        push eax
        add ecx, 1ECh
        lea eax, [dword ebp-0276h]
        call SetTeamStatColumns
        mov eax, dword [byte ebp+0Eh]
        jmp short .21
.20:
        cmp dword [byte ebp+066h], byte 0
        je short .22
        cmp dword [StatsPlayoffMode], byte 0
        je short .22
        push dword [byte ebp+012h]
        push dword [byte ebp+02Eh]
        push dword [byte ebp+03Ah]
        mov eax, dword [byte ebp+076h]
        push dword [byte ebp+03Eh]
        mov ebx, dword [byte ebp+042h]
        push byte 10h
        mov edx, dword [byte ebp+056h]
        add eax, 140h
        push dword [byte ebp+072h]
        mov ecx, dword [StatsMenuItems]
        push eax
        add ecx, 1ECh
        lea eax, [dword ebp-0276h]
        call SetTeamStatColumns
        mov eax, dword [byte ebp+012h]
.21:
        mov dword [byte ebp+05Ah], eax
.22:
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        xor ebx, ebx
        call SetTextColor
.23:
        mov eax, dword [byte ebp+062h]
        mov edx, ebx
        mov dword [eax+edx*4], 0
        mov eax, dword [byte ebp+05Eh]
        xor ecx, ecx
        mov dword [eax+edx*4], 0
        jmp near .32
.24:
        mov edx, dword [dword ebp-0268h]
        mov dl, byte [edx+ebx]
        cmp dl, 5
        jb short .25
        mov eax, dword [dword ebp-026Eh]
        imul eax, ecx
        add eax, ebx
        shl eax, 2
        add eax, dword [dword ebp-0264h]
        cmp dl, 5
        jbe short .27
        cmp dl, 7
        jbe short .26
        cmp dl, 0Dh
        je short .28
        jmp short .30
.25:
        cmp dl, 4
        jne short .30
.26:
        mov eax, dword [dword ebp-026Eh]
        imul eax, ecx
        add eax, ebx
        shl eax, 2
        add eax, dword [dword ebp-0264h]
        mov eax, dword [eax]
        movsx eax, word [eax]
        jmp short .29
.27:
        mov eax, dword [eax]
        movzx eax, byte [eax]
        jmp short .29
.28:
        mov eax, dword [eax]
        movsx eax, word [eax]
        mov esi, 3Ch
        cdq
        idiv esi
.29:
        mov dword [byte ebp+06Eh], eax
.30:
        imul esi, dword [byte ebp+06Eh], byte 64h
        mov edx, ebx
        mov eax, dword [byte ebp+062h]
        shl edx, 2
        add dword [edx+eax], esi
        mov eax, dword [byte ebp+05Eh]
        add eax, edx
        mov edx, dword [byte ebp+06Eh]
        cmp edx, dword [eax]
        jle short .31
        mov dword [eax], edx
.31:
        inc ecx
.32:
        mov esi, dword [byte ebp+05Ah]
        movsx esi, word [esi]
        cmp ecx, esi
        jl near .24
        mov ecx, ebx
        shl ecx, 2
        add ecx, dword [byte ebp+062h]
        mov eax, dword [ecx]
        cdq
        idiv esi
        inc ebx
        mov dword [ecx], eax
        cmp ebx, byte 12h
        jl near .23
        mov edx, 10h
        lea eax, [dword ebp-0276h]
        mov ebx, dword [byte ebp+072h]
        call SortStatTableBy
        mov edx, ebx
        mov eax, ebx
        mov ecx, 52h
        call DrawScreenBackground
        mov ebx, 190h
        mov edx, 12Ch
        mov eax, dword [byte ebp+072h]
        mov esi, BlankMenuItem
        call DrawStatsBackground
        mov edi, dword [StatsMenuItems]
        rep movsb
        mov eax, dword [StatsMenuItems]
        mov dword [eax], 0
        mov esi, dword [StatsMenuItems]
        mov ecx, 52h
        lea edi, [dword esi+0238Eh]
        mov esi, ScreenFrameItem
        rep movsb
        mov eax, dword [StatsMenuItems]
        mov dword [dword eax+0238Eh], 6Fh
        mov esi, dword [StatsMenuItems]
        mov ecx, 52h
        lea edi, [dword esi+023E0h]
        mov esi, StatsBackItem
        rep movsb
        push dword [byte ebp+076h]
        mov eax, dword [StatsMenuItems]
        mov ebx, str_TS48
        mov edx, dword [byte ebp+07Eh]
        mov dword [dword eax+023E0h], 70h
        push str_TS50
        mov eax, dword [StatsMenuItems]
        mov ecx, str_TS49
        add eax, byte 52h
        call DrawStatTable
        push str_TS49
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS50
        push dword [byte ebp+07Eh]
        mov dword [StatsShapeLists], eax
        call FindShape
        add esp, byte 8
        push str_TS51
        push dword [byte ebp+07Eh]
        mov dword [TeamStatsShapeTop], eax
        call FindShape
        mov dword [TeamStatsShapeBottom], eax
        mov eax, dword [byte ebp+076h]
        add esp, byte 8
        add eax, byte 40h
        cmp dword [StatsPlayoffMode], byte 0
        je short .33
        push eax
        mov ecx, str_TS05
        mov ebx, str_TS04
        push str_TS06
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 0A4h
        call DrawStatTable
        push str_TS05
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS06
        push dword [byte ebp+07Eh]
        mov dword [StatsHeaderShape], eax
        call FindShape
        add esp, byte 8
        push str_TS07
        jmp short .34
.33:
        push eax
        mov ecx, str_TS01
        mov ebx, str_TS00
        push str_TS02
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 0A4h
        call DrawStatTable
        push str_TS01
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS02
        push dword [byte ebp+07Eh]
        mov dword [StatsHeaderShape], eax
        call FindShape
        add esp, byte 8
        push str_TS03
.34:
        push dword [byte ebp+07Eh]
        mov dword [TeamStatsLogoShape], eax
        call FindShape
        add esp, byte 8
        mov dword [TeamStatsNameShape], eax
        mov eax, dword [byte ebp+076h]
        add eax, 80h
        push eax
        mov ecx, str_TS09
        mov ebx, str_TS08
        push str_TS10
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 0F6h
        call DrawStatTable
        push str_TS09
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS10
        push dword [byte ebp+07Eh]
        mov dword [StatsRowShape], eax
        call FindShape
        add esp, byte 8
        push str_TS11
        push dword [byte ebp+07Eh]
        mov dword [TeamStatsBarShape], eax
        call FindShape
        mov dword [TeamStatsBarEnd], eax
        mov eax, dword [byte ebp+076h]
        add esp, byte 8
        add eax, 0C0h
        push eax
        mov ecx, str_TS52
        mov edx, dword [byte ebp+07Eh]
        push str_TS52
        mov eax, dword [StatsMenuItems]
        mov ebx, ecx
        add eax, 148h
        call DrawStatTable
        push str_TS52
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS52
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowUp], eax
        call FindShape
        add esp, byte 8
        push str_TS52
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowDown], eax
        call FindShape
        add esp, byte 8
        mov dword [TeamStatsPanelShape], eax
        mov eax, dword [byte ebp+076h]
        add eax, 100h
        push eax
        mov ecx, str_TS45
        mov ebx, str_TS44
        push str_TS46
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 19Ah
        call DrawStatTable
        push str_TS45
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS46
        push dword [byte ebp+07Eh]
        mov dword [StatsSparkleShape], eax
        call FindShape
        add esp, byte 8
        push str_TS47
        push dword [byte ebp+07Eh]
        mov dword [TeamStatsGlowShape], eax
        call FindShape
        add esp, byte 8
        push byte 0
        push dword 1E0h
        push dword 280h
        mov dword [TeamStatsBitmap], eax
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov ebx, eax
        mov esi, eax
        call SetDrawTarget
        add esp, byte 4
        push dword [byte ebp+072h]
        call BlitShape2
        add esp, byte 4
        push dword [byte ebp+026h]
        call BlitShape2
        add esp, byte 4
        cmp dword [StatsMenuMode], byte 0
        je short .35
        mov edx, dword [StatsMenuMode]
        mov eax, dword [byte ebx+02Ch]
        mov ebx, 10h
        call ShowStatScreen
        jmp short .36
.35:
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte ebx+02Ch]
        call WipeScreen
.36:
        push esi
        call FreeBitmap
        add esp, byte 4
        jmp near .72
.37:
        xor eax, eax
.38:
        add eax, byte 70h
        call RunMenu
        mov edx, eax
        cmp dword [byte ebp+016h], byte 3
        jb short .39
        jbe near .60
        cmp dword [byte ebp+016h], byte 5
        jb near .66
        jbe near TeamStatsScreen_10ED.76
        cmp dword [byte ebp+016h], byte 6Fh
        jb near TeamStatsScreen_10ED.79
        jbe short .41
        cmp dword [byte ebp+016h], byte 70h
        je short .42
        jmp near TeamStatsScreen_10ED.79
.39:
        cmp dword [byte ebp+016h], byte 1
        jb short .40
        jbe short .43
        jmp short .44
.40:
        cmp dword [byte ebp+016h], byte 0
        jne near TeamStatsScreen_10ED.79
        call FadeInScreen
        mov dword [byte ebp+046h], 1Ah
        jmp near .72
.41:
        call SetNormalText
        call ExitScreen
        call SetHighlightText
        jmp near .72
.42:
        call ShowStatsScreen
        call SaveStatsScreen
        cmp dword [LinkGameActive], byte 0
        sete al
        movzx edx, al
        mov eax, 0ECh
        call PlayScreenMovie
        call RestoreStatsScreen
        jmp near .72
.43:
        mov dword [byte ebp+046h], 64h
        jmp near .72
.44:
        cmp dword [byte ebp+06Ah], byte 0
        je near .45
        mov edx, dword [byte ebp+05Ah]
        mov eax, dword [byte ebp+06Ah]
        add edx, byte 4
        call KeysEqual
        test eax, eax
        je near .45
        cmp dword [byte ebp+066h], byte 0
        je near .47
        mov dword [StatsPlayoffMode], 1
        lea eax, [dword ebp-0276h]
        movsx esi, word [StatTableSortColumn]
        call FreeStatTable
        mov eax, dword [byte ebp+076h]
        add eax, byte 40h
        push eax
        mov ecx, str_TS05
        mov ebx, str_TS04
        push str_TS06
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 0A4h
        call DrawStatTable
        push str_TS05
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS06
        push dword [byte ebp+07Eh]
        mov dword [StatsHeaderShape], eax
        call FindShape
        add esp, byte 8
        push str_TS07
        push dword [byte ebp+07Eh]
        mov dword [TeamStatsLogoShape], eax
        call FindShape
        add esp, byte 8
        push dword [byte ebp+012h]
        push dword [byte ebp+02Eh]
        mov ebx, dword [byte ebp+042h]
        push dword [byte ebp+03Ah]
        mov dword [TeamStatsNameShape], eax
        push dword [byte ebp+03Eh]
        mov eax, dword [byte ebp+076h]
        push byte 10h
        mov edx, dword [byte ebp+056h]
        add eax, 140h
        push dword [byte ebp+072h]
        mov ecx, dword [StatsMenuItems]
        push eax
        add ecx, 1ECh
        lea eax, [dword ebp-0276h]
        call SetTeamStatColumns
        mov eax, dword [byte ebp+012h]
        jmp near .46
.45:
        cmp dword [byte ebp+06Ah], byte 0
        je near .47
        mov edx, dword [byte ebp+05Ah]
        mov eax, dword [byte ebp+066h]
        add edx, byte 4
        call KeysEqual
        test eax, eax
        je near .47
        cmp dword [byte ebp+06Ah], byte 0
        je near .47
        mov dword [StatsPlayoffMode], 0
        call SetScreenTarget
        mov eax, dword [StatsBackArt]
        push dword [byte eax+02Ch]
        call BlitShape2
        add esp, byte 4
        call PresentScreen
        mov eax, dword [byte ebp+076h]
        add eax, byte 40h
        push eax
        mov ebx, str_TS00
        mov ecx, str_TS01
        push str_TS02
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 0A4h
        call DrawStatTable
        push str_TS01
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS02
        push dword [byte ebp+07Eh]
        mov dword [StatsHeaderShape], eax
        call FindShape
        add esp, byte 8
        push str_TS03
        push dword [byte ebp+07Eh]
        mov dword [TeamStatsLogoShape], eax
        call FindShape
        add esp, byte 8
        mov dword [TeamStatsNameShape], eax
        lea eax, [dword ebp-0276h]
        movsx esi, word [StatTableSortColumn]
        call FreeStatTable
        push dword [byte ebp+0Eh]
        push dword [byte ebp+036h]
        push dword [byte ebp+04Eh]
        mov ebx, dword [byte ebp+04Ah]
        push dword [byte ebp+032h]
        mov eax, dword [byte ebp+076h]
        push byte 1Ah
        mov edx, dword [byte ebp+052h]
        add eax, 140h
        push dword [byte ebp+072h]
        mov ecx, dword [StatsMenuItems]
        push eax
        add ecx, 1ECh
        lea eax, [dword ebp-0276h]
        call SetTeamStatColumns
        mov eax, dword [byte ebp+0Eh]
.46:
        movsx edx, si
        mov dword [byte ebp+05Ah], eax
        lea eax, [dword ebp-0276h]
        call SortStatTableBy
.47:
        xor ebx, ebx
.48:
        mov eax, dword [byte ebp+062h]
        mov edx, ebx
        mov dword [eax+edx*4], 0
        mov eax, dword [byte ebp+05Eh]
        xor ecx, ecx
        mov dword [eax+edx*4], 0
        jmp near .59
.49:
        mov eax, dword [dword ebp-0268h]
        mov al, byte [ebx+eax]
        cmp al, 6
        jb short .51
        jbe short .52
        cmp al, 9
        jb short .50
        mov edx, dword [dword ebp-026Eh]
        imul edx, ecx
        add edx, ebx
        shl edx, 2
        add edx, dword [dword ebp-0264h]
        cmp al, 9
        jbe short .55
        cmp al, 0Dh
        je short .54
        jmp short .57
.50:
        cmp al, 7
        je short .53
        jmp short .57
.51:
        cmp al, 4
        jb short .57
        ja short .53
.52:
        mov eax, dword [dword ebp-026Eh]
        imul eax, ecx
        add eax, ebx
        shl eax, 2
        add eax, dword [dword ebp-0264h]
        mov eax, dword [eax]
        movsx eax, word [eax]
        jmp short .56
.53:
        mov eax, dword [dword ebp-026Eh]
        imul eax, ecx
        add eax, ebx
        shl eax, 2
        add eax, dword [dword ebp-0264h]
        mov eax, dword [eax]
        movzx eax, byte [eax]
        jmp short .56
.54:
        mov eax, dword [edx]
        mov eax, dword [eax]
        mov esi, 3Ch
        cdq
        idiv esi
        jmp short .56
.55:
        mov eax, dword [edx]
        movzx eax, word [eax]
.56:
        mov dword [byte ebp+06Eh], eax
.57:
        imul esi, dword [byte ebp+06Eh], byte 64h
        mov edx, ebx
        mov eax, dword [byte ebp+062h]
        shl edx, 2
        add dword [edx+eax], esi
        mov eax, dword [byte ebp+05Eh]
        add eax, edx
        mov edx, dword [byte ebp+06Eh]
        cmp edx, dword [eax]
        jle short .58
        mov dword [eax], edx
.58:
        inc ecx
.59:
        mov esi, dword [byte ebp+05Ah]
        movsx esi, word [esi]
        cmp ecx, esi
        jl near .49
        mov ecx, ebx
        shl ecx, 2
        add ecx, dword [byte ebp+062h]
        mov eax, dword [ecx]
        cdq
        idiv esi
        inc ebx
        mov dword [ecx], eax
        cmp ebx, byte 12h
        jl near .48
        jmp near .72
.60:
        inc dword [byte ebp+07Ah]
        cmp dword [byte ebp+07Ah], byte 3
        jne short .61
        mov dword [byte ebp+07Ah], 0
.61:
        mov eax, dword [byte ebp+076h]
        add eax, 80h
        cmp dword [byte ebp+07Ah], byte 1
        jb short .62
        jbe short .63
        cmp dword [byte ebp+07Ah], byte 2
        je near .64
        jmp near .66
.62:
        cmp dword [byte ebp+07Ah], byte 0
        jne near .66
        push eax
        mov ecx, str_TS09
        mov ebx, str_TS08
        push str_TS10
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 0F6h
        call DrawStatTable
        push str_TS09
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS10
        push dword [byte ebp+07Eh]
        mov dword [StatsRowShape], eax
        call FindShape
        add esp, byte 8
        push str_TS11
        jmp near .65
.63:
        push eax
        mov ecx, str_TS13
        mov ebx, str_TS12
        push str_TS14
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 0F6h
        call DrawStatTable
        push str_TS13
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS14
        push dword [byte ebp+07Eh]
        mov dword [StatsRowShape], eax
        call FindShape
        add esp, byte 8
        push str_TS15
        jmp short .65
.64:
        push eax
        mov ecx, str_TS17
        mov ebx, str_TS16
        push str_TS18
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 0F6h
        call DrawStatTable
        push str_TS17
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS18
        push dword [byte ebp+07Eh]
        mov dword [StatsRowShape], eax
        call FindShape
        add esp, byte 8
        push str_TS19
.65:
        push dword [byte ebp+07Eh]
        mov dword [TeamStatsBarShape], eax
        call FindShape
        add esp, byte 8
        mov dword [TeamStatsBarEnd], eax
.66:
        cmp dword [byte ebp+016h], byte 4
        jne short .69
        inc dword [byte ebp+01Eh]
        cmp dword [byte ebp+07Ah], byte 0
        je short .68
        cmp dword [byte ebp+07Ah], byte 1
        jne short .67
        cmp dword [byte ebp+01Eh], byte 1
        jg short .68
.67:
        cmp dword [byte ebp+07Ah], byte 2
        jne short .69
        cmp dword [byte ebp+01Eh], byte 3
        jle short .69
.68:
        mov dword [byte ebp+01Eh], 0
.69:
        mov eax, dword [byte ebp+076h]
        add eax, 0C0h
        cmp dword [byte ebp+07Ah], byte 1
        jb short .70
        jbe near .73
        cmp dword [byte ebp+07Ah], byte 2
        je near .75
        jmp short .72
.70:
        cmp dword [byte ebp+07Ah], byte 0
        jne short .72
        push eax
        mov ecx, str_TS52
        mov edx, dword [byte ebp+07Eh]
        push str_TS52
        mov eax, dword [StatsMenuItems]
        mov ebx, ecx
        add eax, 148h
        call DrawStatTable
        push str_TS52
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS52
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowUp], eax
        call FindShape
        add esp, byte 8
        push str_TS52
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowDown], eax
        call FindShape
        mov edx, 10h
.71:
        add esp, byte 8
        mov dword [TeamStatsPanelShape], eax
        lea eax, [dword ebp-0276h]
        call SortStatTableBy
.72:
        cmp dword [byte ebp+046h], byte 0FFFFFFFFh
        jne near TeamStatsScreen_10ED.83
        lea eax, [dword ebp-0276h]
        call DrawStatTableRows
        call SetScreenTarget
        push dword [dword ebp-0247h]
        mov eax, dword [byte ebp-02Fh]
        push dword [dword ebp-024Bh]
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        mov ebx, 0FFFFFFFFh
        call PresentScreen
        push byte 3
        lea eax, [byte ebp+016h]
        mov ecx, TeamStatsSound
        mov edx, dword [StatsMenuItems]
        push eax
        cmp dword [StatsPlayoffMode], byte 0
        je near .37
        cmp byte [FrontEndExit], 0
        je near .37
        mov eax, 1
        jmp near .38
.73:
        cmp dword [byte ebp+01Eh], byte 0
        jne short .74
        push eax
        mov ecx, str_TS25
        mov ebx, str_TS24
        push str_TS26
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 148h
        call DrawStatTable
        push str_TS25
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS26
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowUp], eax
        call FindShape
        add esp, byte 8
        push str_TS27
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowDown], eax
        call FindShape
        mov edx, 4
        jmp near .71
.74:
        push eax
        mov ecx, str_TS21
        mov ebx, str_TS20
        push str_TS22
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 148h
        call DrawStatTable
        push str_TS21
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS22
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowUp], eax
        call FindShape
        add esp, byte 8
        push str_TS23
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowDown], eax
        call FindShape
        mov edx, 8
        jmp near .71
.75:
        cmp dword [byte ebp+01Eh], byte 3
        ja near .72
        mov edx, dword [byte ebp+01Eh]
        jmp dword [nosplit cs:edx*4+TeamStatsScreenJumpTable]
TeamStatsScreen_FC4:
        push eax
        mov ecx, str_TS41
        mov ebx, str_TS40
        push str_TS42
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 148h
        call DrawStatTable
        push str_TS41
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS42
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowUp], eax
        call FindShape
        add esp, byte 8
        push str_TS43
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowDown], eax
        call FindShape
        mov edx, 5
        jmp near TeamStatsScreen.71
TeamStatsScreen_1027:
        push eax
        mov ecx, str_TS33
        mov ebx, str_TS32
        push str_TS34
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 148h
        call DrawStatTable
        push str_TS33
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS34
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowUp], eax
        call FindShape
        add esp, byte 8
        push str_TS35
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowDown], eax
        call FindShape
        mov edx, 6
        jmp near TeamStatsScreen.71
TeamStatsScreen_108A:
        push eax
        mov ecx, str_TS29
        mov ebx, str_TS28
        push str_TS30
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 148h
        call DrawStatTable
        push str_TS29
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS30
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowUp], eax
        call FindShape
        add esp, byte 8
        push str_TS31
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowDown], eax
        call FindShape
        mov edx, 9
        jmp near TeamStatsScreen.71
TeamStatsScreen_10ED:
        push eax
        mov ecx, str_TS37
        mov ebx, str_TS36
        push str_TS38
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Eh]
        add eax, 148h
        call DrawStatTable
        push str_TS37
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_TS38
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowUp], eax
        call FindShape
        add esp, byte 8
        push str_TS39
        push dword [byte ebp+07Eh]
        mov dword [StatsArrowDown], eax
        call FindShape
        mov edx, 0Ah
        jmp near TeamStatsScreen.71
.76:
        cmp dword [LinkGameActive], byte 0
        jne short .77
        lea eax, [dword ebp-0276h]
        call ExportStatTable
        jmp near TeamStatsScreen.72
.77:
        cmp eax, byte 2
        jne short .78
        lea eax, [dword ebp-0276h]
        call ExportStatTable
        call LinkSyncMenu
        jmp near TeamStatsScreen.72
.78:
        mov eax, 237h
        call GetLangText
        call LinkSyncScreen
        jmp near TeamStatsScreen.72
.79:
        lea ecx, [byte ebp+01Ah]
        mov ebx, StatsColumn
        push edx
        mov edx, dword [byte ebp+016h]
        lea eax, [dword ebp-0276h]
        sub edx, byte 6
        call SortStatTable
        cmp dword [byte ebp+01Ah], byte 0FFFFFFFFh
        je near TeamStatsScreen.72
        cmp dword [byte ebp+01Ah], byte 0
        je near TeamStatsScreen.72
        push dword [byte ebp+02Ah]
        call SetDrawTarget
        mov eax, dword [byte ebp+072h]
        movsx eax, word [byte eax+0Eh]
        add esp, byte 4
        sub eax, 82h
        push eax
        mov eax, dword [byte ebp+072h]
        movsx eax, word [byte eax+0Ch]
        sub eax, byte 64h
        push eax
        push dword [byte ebp+072h]
        call BlitArt
        add esp, byte 0Ch
        cmp dword [byte ebp+01Ah], byte 9
        je short .80
        cmp dword [byte ebp+01Ah], byte 0Dh
        jne short .81
.80:
        mov eax, dword [byte ebp+01Ah]
        shl eax, 2
        add eax, dword [byte ebp+05Eh]
        mov eax, dword [eax]
        mov ebx, 0Ah
        cdq
        idiv ebx
        push eax
        mov eax, 23Dh
        call GetLangText
        mov ebx, dword [byte ebp+01Ah]
        shl ebx, 2
        add ebx, dword [byte ebp+062h]
        push eax
        mov eax, dword [ebx]
        mov ecx, 0Ah
        cdq
        idiv ecx
        mov ecx, 64h
        cdq
        idiv ecx
        mov ecx, 3E8h
        jmp short .82
.81:
        mov eax, dword [byte ebp+01Ah]
        shl eax, 2
        add eax, dword [byte ebp+05Eh]
        push dword [eax]
        mov eax, 23Dh
        call GetLangText
        mov ebx, dword [byte ebp+01Ah]
        shl ebx, 2
        add ebx, dword [byte ebp+062h]
        push eax
        mov eax, dword [ebx]
        mov ecx, 64h
        cdq
        idiv ecx
.82:
        mov eax, dword [ebx]
        push edx
        cdq
        idiv ecx
        push eax
        mov eax, 23Eh
        call GetLangText
        push eax
        push str_SDDSD
        lea eax, [byte ebp-026h]
        push eax
        call sprintf_
        add esp, byte 1Ch
        lea eax, [byte ebp-026h]
        push eax
        push byte 0
        push dword 0DCh
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        call SetScreenTarget
        push dword 82h
        mov eax, dword [byte ebp+02Ah]
        push byte 64h
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        jmp near TeamStatsScreen.72
.83:
        lea eax, [dword ebp-0276h]
        call FreeStatTable
        push dword [byte ebp+022h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+07Eh]
        call FreeMemBlock
        add esp, byte 4
        call SetNormalText
        push dword [byte ebp+02Ah]
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp+032h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+04Eh]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+036h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+062h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+05Eh]
        call FreeMemBlock
        add esp, byte 4
        push dword [StatsMenuItems]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+076h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+052h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+04Ah]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+056h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+042h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+03Eh]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+03Ah]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+02Eh]
        call FreeMemBlock
        add esp, byte 4
        call FreeStatsBitmap
        cmp dword [byte ebp+06Ah], byte 0
        je short .84
        lea eax, [byte ebp+0Eh]
        call FreeDbBlock
.84:
        cmp dword [byte ebp+066h], byte 0
        je short .85
        lea eax, [byte ebp+012h]
        call FreeDbBlock
.85:
        call SetNormalText
        mov eax, dword [byte ebp+046h]
TeamStatsScreen_13BC:
        lea esp, [dword ebp+082h]
        pop ebp
TeamStatsScreen_13C3:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; StatsScreenSound                                AEFAF  97 PC, low confidence
; Plays a stats screen sound
;-----------------------------------------------------------------------------
StatsScreenSound:
        push ebx
        push ecx
        push edx
        xor ebx, ebx
        xor edx, edx
.1:
        lea eax, [byte ebx+01h]
        imul eax, byte 52h
        mov ecx, dword [StatsMenuItems]
        cmp dword [byte ecx+eax+04h], byte 1
        jne short .2
        call rand_
        mov ecx, 3
        cdq
        idiv ecx
        imul eax, ebx, byte 0Ch
        push dword [dword eax+edx*4+StatsShapeLists]
        call BlitShape2
        mov edx, 1
        add esp, byte 4
.2:
        inc ebx
        cmp ebx, byte 4
        jl short .1
        mov eax, dword [StatsMenuItems]
        cmp dword [dword eax+01F0h], byte 1
        jne short .3
        call rand_
        mov ebx, 3
        cdq
        idiv ebx
        push dword [nosplit edx*4+StatsSparkleShape]
        call BlitShape2
        mov edx, 1
        add esp, byte 4
.3:
        test edx, edx
        je short .4
        cmp dword [StatsSoundPlayed], byte 0
        jne short .4
        mov eax, 309h
        call PlaySfx
        mov dword [StatsSoundPlayed], 1
.4:
        test edx, edx
        jne short .5
        cmp dword [StatsSoundPlayed], byte 0
        je short .5
        mov eax, 309h
        call PlayMenuSfx
        mov dword [StatsSoundPlayed], edx
.5:
        pop edx
        pop ecx
        pop ebx
        ret
StatsTablesScreenJumpTable:                     ; jump table for the switch cases of StatsTablesScreen
        dd StatsTablesScreen_B17
        dd StatsTablesScreen_BC9
        dd StatsTablesScreen_C68
        dd StatsTablesScreen_D0E
;-----------------------------------------------------------------------------
; StatsTablesScreen                               AF074  97 PC, low confidence
; Runs the team stats screen
;-----------------------------------------------------------------------------
StatsTablesScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 3E0h, 0
        sub ebp, 82h
        mov dword [byte ebp+04Ah], 0
        mov dword [byte ebp+042h], 0
        mov dword [byte ebp+0Ah], 2
        mov dword [byte ebp+032h], 0FFFFFFFFh
        mov dword [byte ebp+02h], 0
        mov dword [byte ebp-02h], 0
        mov dword [byte ebp+02Eh], 0
        mov dword [byte ebp+012h], 0
        mov byte [byte ebp+07Eh], 0
        mov dword [byte ebp+04Eh], 0
        cmp byte [FrontMusicOn], 0
        je short .1
        call MusicEnabled
.1:
        push byte 0
        push byte 14h
        push dword 1B8h
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push dword 7D0h
        push str_Punct_StatsTablesScreen
        mov dword [byte ebp+02Ah], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 29206h
        push str_Rosters
        mov dword [byte ebp+022h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 0A5Ch
        push str_Rawteams
        mov dword [byte ebp+05Ah], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 9858h
        push str_Ai
        mov dword [byte ebp+06Ah], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 1E78h
        push str_Gai
        mov dword [byte ebp+056h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 0EE48h
        push str_Pstats
        mov dword [byte ebp+03Ah], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 2FA8h
        push str_Gstats
        mov dword [byte ebp+052h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 36C6h
        push str_Mpick
        mov dword [byte ebp+03Eh], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 2880h
        push str_Reg
        mov dword [StatsMenuItems], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp+072h], eax
        push byte 0
        push dword 0C350h
        push str_Names
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 2710h
        push str_Gnames
        mov edi, eax
        mov dword [byte ebp+026h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 0FA0h
        push str_Nameptrs
        mov esi, eax
        mov dword [byte ebp+01Eh], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 320h
        push str_Gnameptrs
        mov dword [byte ebp+05Eh], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push byte 40h
        push str_Avg
        mov dword [byte ebp+046h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push byte 40h
        push str_High
        mov ebx, 0C350h
        mov dword [byte ebp+06Eh], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp+062h], eax
        xor edx, edx
        mov eax, edi
        call memset_
        mov ebx, 2710h
        mov eax, esi
        xor edx, edx
        call memset_
        xor ebx, ebx
.2:
        imul eax, ebx, byte 32h
        mov edx, dword [byte ebp+026h]
        add edx, eax
        mov eax, ebx
        shl eax, 2
        add eax, dword [byte ebp+05Eh]
        inc ebx
        mov dword [eax], edx
        cmp ebx, 3E8h
        jl short .2
        xor ebx, ebx
.3:
        imul eax, ebx, byte 32h
        mov edx, dword [byte ebp+01Eh]
        add edx, eax
        mov eax, ebx
        shl eax, 2
        add eax, dword [byte ebp+046h]
        inc ebx
        mov dword [eax], edx
        cmp ebx, 0C8h
        jl short .3
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        cmp byte [FrontEndExit], 0
        je short .4
        mov dword [byte ebp+04Ah], SeasonDbKey
        mov dword [byte ebp+042h], PlayoffDbKey
        jmp short .7
.4:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 20h
        jne short .5
        mov dword [StatsPlayoffMode], 1
        mov dword [byte ebp+04Ah], PlayoffStatsPath
        jmp short .7
.5:
        mov dword [byte ebp+042h], SeasonFilePath
        cmp dword [SeasonActive], byte 0
        je short .6
        mov dword [byte ebp+04Ah], SeasonStatsPath
        jmp short .7
.6:
        mov dword [StatsPlayoffMode], 0
.7:
        mov eax, 1E4h
        call GetLangText
        call ShowLinkMessage
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        cmp dword [byte ebp+042h], byte 0
        je short .8
        cmp dword [StatsPlayoffMode], byte 0
        jne short .8
        lea edx, [byte ebp+06h]
        mov eax, dword [byte ebp+042h]
        jmp short .9
.8:
        cmp dword [StatsPlayoffMode], byte 0
        je short .10
        cmp dword [byte ebp+04Ah], byte 0
        je short .10
        lea edx, [byte ebp+06h]
        mov eax, dword [byte ebp+04Ah]
.9:
        call OpenLeagueFile
.10:
        mov eax, 1Eh
        xor edx, edx
        call LoadDataFile
        mov ebx, eax
        mov dword [byte ebp+016h], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 1Fh
        call LoadDataFile
        mov dword [byte ebp+07Ah], eax
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        je short .14
        mov eax, 39h
        call OpenDataLibrary
        cmp dword [StatsPlayoffMode], byte 0
        jne short .11
        push dword [StatsColumn]
        jmp short .12
.11:
        mov eax, dword [StatsColumn]
        push dword [nosplit eax*4+PlayoffTeams]
.12:
        push str_LOGO02dFSH
        lea eax, [byte ebp-036h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        cmp dword [byte ebp+04Eh], byte 0
        je short .13
        push dword [byte ebp+04Eh]
        call FreeMemBlock
        add esp, byte 4
.13:
        push byte 0
        lea eax, [byte ebp-036h]
        push eax
        call OpenArtArchiveErr
        add esp, byte 8
        push dword [MenuScreenBitmap]
        push str_LOGO6
        push eax
        mov dword [byte ebp+04Eh], eax
        jmp short .15
.14:
        push dword [MenuScreenBitmap]
        push str_NHLP2
        push ebx
.15:
        call FindShape
        add esp, byte 8
        push eax
        call ConvertArtNew
        add esp, byte 8
        mov dword [byte ebp+066h], eax
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        cmp byte [FrontMusicOn], 0
        jne short .16
        push byte 0
        push dword 12Ch
        push dword 12Ch
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [byte ebp+036h], eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        call ClearScreen
        add esp, byte 4
        push byte 0
        push byte 0
        push dword [byte ebp+066h]
        push dword 14CCCh
        call DrawShapeBlended
        add esp, byte 10h
.16:
        call PresentScreen
        push str_00006
        push dword [byte ebp+016h]
        call FindShape
        add esp, byte 8
        push str_TTL1
        mov esi, eax
        push dword [byte ebp+07Ah]
        mov dword [byte ebp+01Ah], eax
        call FindShape
        add esp, byte 8
        push byte 0
        push dword 1E0h
        push dword 280h
        mov edi, eax
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov ebx, eax
        mov dword [byte ebp+076h], eax
        call SetDrawTarget
        add esp, byte 4
        push esi
        call BlitShape2
        add esp, byte 4
        push edi
        call BlitShape2
        add esp, byte 4
        cmp byte [FrontMusicOn], 0
        je short .17
        push byte 78h
        push dword 8Ch
        push dword [byte ebp+066h]
        push dword 14CCCh
        call DrawSpriteScaledBy
        add esp, byte 10h
        jmp short .18
.17:
        push dword 12Ch
        push dword 12Ch
        push byte 78h
        mov eax, dword [byte ebp+036h]
        push dword 8Ch
        mov edx, dword [byte ebx+02Ch]
        xor ecx, ecx
        push byte 0
        mov ebx, 10h
        mov eax, dword [byte eax+02Ch]
        call DrawShadedLogo
.18:
        call PresentScreen
        mov eax, 0ABh
        mov edx, dword [StatsMenuItems]
        call InitMenuItems
        push dword [byte ebp+03Eh]
        push dword [byte ebp+052h]
        push dword [byte ebp+046h]
        push dword [byte ebp+05Eh]
        mov ecx, dword [byte ebp+05Ah]
        push dword [byte ebp+03Ah]
        lea ebx, [byte ebp-02h]
        push dword [byte ebp+056h]
        lea edx, [byte ebp+02h]
        push dword [byte ebp+06Ah]
        mov eax, dword [byte ebp+06h]
        call BuildTeamStatsTable
        push dword [byte ebp+062h]
        push dword [byte ebp+06Eh]
        push dword [byte ebp+02h]
        mov ecx, dword [byte ebp+076h]
        push dword [byte ebp+052h]
        mov ebx, dword [byte ebp+072h]
        push dword [byte ebp+05Eh]
        lea eax, [dword ebp-035Eh]
        push dword [byte ebp+056h]
        mov edx, dword [StatsMenuItems]
        push dword [byte ebp+06Ah]
        add ebx, 200h
        push dword [byte ebp+05Ah]
        add edx, 2E2h
        push dword [byte ebp+06h]
        mov ecx, dword [byte ecx+02Ch]
        call SetSkaterStatColumns
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        je short .19
        mov eax, dword [StatsColumn]
        mov ax, word [nosplit eax*2+StatsColumnFields]
        shl eax, 3
        movsx edx, ax
        lea eax, [dword ebp-035Eh]
        jmp short .20
.19:
        lea eax, [dword ebp-035Eh]
        xor edx, edx
.20:
        call SortStatTableBy
        call SetHighlightText
        mov eax, dword [byte ebp+076h]
        mov eax, dword [byte eax+02Ch]
        mov ebx, eax
        mov edx, eax
        mov ecx, 52h
        call DrawScreenBackground
        mov eax, dword [byte ebp+076h]
        mov ebx, 1A4h
        mov edx, 12Ch
        mov eax, dword [byte eax+02Ch]
        mov esi, BlankMenuItem
        call DrawStatsBackground
        mov edi, dword [StatsMenuItems]
        rep movsb
        mov eax, dword [StatsMenuItems]
        mov dword [eax], 0
        mov esi, dword [StatsMenuItems]
        mov ecx, 52h
        lea edi, [dword esi+03622h]
        mov esi, ScreenFrameItem
        rep movsb
        mov eax, dword [StatsMenuItems]
        mov dword [dword eax+03622h], 0A9h
        mov esi, dword [StatsMenuItems]
        mov ecx, 52h
        lea edi, [dword esi+03674h]
        mov esi, StatsBackItem
        rep movsb
        push dword [byte ebp+072h]
        mov eax, dword [StatsMenuItems]
        mov ebx, str_RS00
        mov edx, dword [byte ebp+07Ah]
        mov dword [dword eax+03674h], 0AAh
        push str_RS02
        mov eax, dword [StatsMenuItems]
        mov ecx, str_RS01
        add eax, byte 52h
        call DrawStatTable
        push StatsShapeLists
        push str_RS01RS02RS03
        push dword [byte ebp+07Ah]
        call FindShapeList
        mov eax, dword [byte ebp+072h]
        add esp, byte 0Ch
        add eax, byte 40h
        cmp dword [StatsPlayoffMode], byte 0
        je short .21
        push eax
        mov ecx, str_RS13
        mov ebx, str_RS12
        push str_RS14
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Ah]
        add eax, 0A4h
        call DrawStatTable
        push StatsHeaderShape
        push str_RS13RS14RS15
        jmp short .22
.21:
        push eax
        mov ecx, str_RS09
        mov ebx, str_RS08
        push str_RS10
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Ah]
        add eax, 0A4h
        call DrawStatTable
        push StatsHeaderShape
        push str_RS09RS10RS11
.22:
        push dword [byte ebp+07Ah]
        call FindShapeList
        add esp, byte 0Ch
        mov eax, dword [byte ebp+072h]
        add eax, 80h
        push eax
        mov ecx, str_RS17
        mov ebx, str_RS16
        push str_RS18
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Ah]
        add eax, 0F6h
        call DrawStatTable
        push StatsRowShape
        push str_RS17RS18RS19
        push dword [byte ebp+07Ah]
        call FindShapeList
        mov eax, dword [byte ebp+072h]
        add esp, byte 0Ch
        add eax, 0C0h
        push eax
        mov ebx, str_RS32
        mov ecx, str_RS33
        push str_RS34
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Ah]
        add eax, 148h
        call DrawStatTable
        push StatsArrowUp
        push str_RS33RS34RS35
        push dword [byte ebp+07Ah]
        call FindShapeList
        mov eax, dword [byte ebp+072h]
        add esp, byte 0Ch
        add eax, 100h
        push eax
        mov ecx, str_LB26
        mov edx, dword [byte ebp+07Ah]
        push str_LB26
        mov eax, dword [StatsMenuItems]
        mov ebx, ecx
        add eax, 19Ah
        call DrawStatTable
        mov eax, dword [byte ebp+072h]
        add eax, 140h
        push eax
        mov ecx, str_RS05
        mov ebx, str_RS04
        push str_RS06
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Ah]
        add eax, 1ECh
        call DrawStatTable
        push StatsSparkleShape
        push str_RS05RS06RS07
        push dword [byte ebp+07Ah]
        call FindShapeList
        mov eax, dword [byte ebp+072h]
        add esp, byte 0Ch
        add eax, 180h
        push eax
        mov ebx, str_LABL
        mov ecx, str_LAHL
        push str_LAHL
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+016h]
        add eax, 23Eh
        call DrawStatTable
        mov eax, dword [byte ebp+072h]
        add eax, 1C0h
        push eax
        mov ecx, str_RAHL
        mov ebx, str_RABL
        push str_RAHL
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+016h]
        add eax, 290h
        call DrawStatTable
        call HideLinkBox
        cmp dword [StatsMenuMode], byte 0
        je short .23
        mov eax, dword [byte ebp+076h]
        mov ebx, 10h
        mov edx, dword [StatsMenuMode]
        mov eax, dword [byte eax+02Ch]
        call ShowStatScreen
        jmp short .24
.23:
        mov eax, dword [byte ebp+076h]
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte eax+02Ch]
        call WipeScreen
.24:
        cmp dword [byte ebp+032h], byte 0FFFFFFFFh
        jne near StatsTablesScreen_D0E.113
        lea eax, [dword ebp-035Eh]
        call DrawStatTableRows
        call SetScreenTarget
        push dword [dword ebp-032Fh]
        mov eax, dword [dword ebp-0117h]
        push dword [dword ebp-0333h]
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        xor esi, esi
        call PresentScreen
        cmp byte [FrontEndExit], 0
        je short .26
        cmp dword [byte ebp+012h], byte 0
        jne short .25
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        jne short .25
        mov esi, 0EBh
.25:
        cmp dword [byte ebp+012h], byte 1
        jne short .26
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        jne short .26
        mov esi, 0E9h
.26:
        test esi, esi
        jne short .27
        mov eax, dword [StatsBackArt]
        push dword [byte eax+02Ch]
        call BlitShape2
        add esp, byte 4
.27:
        cmp byte [StatsMenuDrawn], 0
        jne short .28
        mov edx, dword [StatsMenuItems]
        mov eax, 1
        add edx, byte 52h
        call InitMenuItems
.28:
        push byte 3
        lea eax, [byte ebp+0Ah]
        mov ecx, StatsScreenSound
        mov ebx, 0FFFFFFFFh
        mov edx, dword [StatsMenuItems]
        push eax
        test esi, esi
        setg al
        movzx eax, al
        add eax, 0AAh
        call RunMenu
        mov edx, eax
        cmp dword [byte ebp+0Ah], byte 5
        jb short .30
        cmp dword [byte ebp+0Ah], byte 5
        jbe near StatsTablesScreen_D0E.57
        cmp dword [byte ebp+0Ah], byte 8
        jb short .29
        jbe near StatsTablesScreen_D0E.80
        cmp dword [byte ebp+0Ah], 0A9h
        jb near StatsTablesScreen_D0E.91
        jbe short .32
        cmp dword [byte ebp+0Ah], 0AAh
        je short .33
        jmp near StatsTablesScreen_D0E.91
.29:
        cmp dword [byte ebp+0Ah], byte 6
        jbe near StatsTablesScreen_D0E.69
        jmp near StatsTablesScreen_D0E.72
.30:
        cmp dword [byte ebp+0Ah], byte 2
        jb short .31
        jbe short .35
        cmp dword [byte ebp+0Ah], byte 3
        jbe near .44
        jmp near StatsTablesScreen_BC9.50
.31:
        cmp dword [byte ebp+0Ah], byte 0
        ja short .34
        call FadeInScreen
        mov dword [byte ebp+032h], 1Ah
        jmp near StatsTablesScreen_D0E.100
.32:
        call SetNormalText
        call ExitScreen
        call SetHighlightText
        jmp near StatsTablesScreen_D0E.100
.33:
        call ShowStatsScreen
        cmp dword [LinkGameActive], byte 0
        sete al
        movzx edx, al
        mov eax, esi
        mov byte [byte ebp+07Eh], 1
        call PlayScreenMovie
        call ChangeMenuMusic
        jmp near StatsTablesScreen_D0E.100
.34:
        mov dword [byte ebp+032h], 64h
        jmp near StatsTablesScreen_D0E.100
.35:
        cmp dword [StatsPlayoffMode], byte 0
        je short .37
        cmp dword [byte ebp+042h], byte 0
        je short .37
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        je short .36
        mov eax, dword [StatsColumn]
        mov eax, dword [nosplit eax*4+PlayoffTeams]
        mov dword [StatsColumn], eax
.36:
        mov dword [StatsPlayoffMode], 0
        lea eax, [byte ebp+06h]
        lea edx, [byte ebp+06h]
        call FreeDbBlock
        mov eax, dword [byte ebp+042h]
        call OpenLeagueFile
        mov eax, dword [byte ebp+072h]
        add eax, byte 40h
        push eax
        mov ecx, str_RS09
        mov ebx, str_RS08
        push str_RS10
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Ah]
        add eax, 0A4h
        call DrawStatTable
        push StatsHeaderShape
        push str_RS09RS11RS11
        jmp near .43
.37:
        cmp dword [StatsPlayoffMode], byte 0
        jne near .44
        cmp dword [byte ebp+04Ah], byte 0
        je near .44
        xor ebx, ebx
        xor edx, edx
        jmp short .40
.38:
        mov eax, dword [nosplit ebx*4+PlayoffTeams]
        cmp eax, dword [StatsColumn]
        jne short .39
        mov edx, 1
        mov dword [StatsColumn], ebx
.39:
        inc ebx
.40:
        cmp ebx, byte 10h
        jge short .41
        test edx, edx
        je short .38
.41:
        test edx, edx
        jne short .42
        mov dword [StatsColumn], 0FFFFFFFFh
.42:
        mov dword [StatsPlayoffMode], 1
        lea eax, [byte ebp+06h]
        lea edx, [byte ebp+06h]
        call FreeDbBlock
        mov eax, dword [byte ebp+04Ah]
        call OpenLeagueFile
        mov eax, dword [byte ebp+072h]
        add eax, byte 40h
        push eax
        mov ecx, str_RS13
        mov ebx, str_RS12
        push str_RS14
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Ah]
        add eax, 0A4h
        call DrawStatTable
        push StatsHeaderShape
        push str_RS13RS14RS15
.43:
        push dword [byte ebp+07Ah]
        call FindShapeList
        add esp, byte 0Ch
        push dword [byte ebp+03Eh]
        mov byte [byte ebp+07Eh], 1
        push dword [byte ebp+052h]
        lea ebx, [byte ebp-02h]
        push dword [byte ebp+046h]
        mov dword [byte ebp+02h], 0
        push dword [byte ebp+05Eh]
        mov ecx, dword [byte ebp+05Ah]
        push dword [byte ebp+03Ah]
        lea edx, [byte ebp+02h]
        push dword [byte ebp+056h]
        mov eax, dword [byte ebp+06h]
        push dword [byte ebp+06Ah]
        mov dword [byte ebp-02h], 0
        call BuildTeamStatsTable
.44:
        cmp dword [byte ebp+0Ah], byte 3
        jne short .45
        inc dword [byte ebp+012h]
        cmp dword [byte ebp+012h], byte 3
        jle short .45
        mov dword [byte ebp+012h], 0
.45:
        cmp dword [byte ebp+012h], byte 3
        ja near StatsTablesScreen_BC9.50
        mov esi, dword [byte ebp+072h]
        mov eax, dword [byte ebp+072h]
        mov ebx, dword [byte ebp+012h]
        add esi, 200h
        add eax, 80h
        jmp dword [nosplit cs:ebx*4+StatsTablesScreenJumpTable]
StatsTablesScreen_B17:
        push eax
        mov ecx, str_RS17
        mov ebx, str_RS16
        push str_RS18
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Ah]
        add eax, 0F6h
        call DrawStatTable
        push StatsRowShape
        push str_RS17RS18RS19
        push dword [byte ebp+07Ah]
        call FindShapeList
        add esp, byte 0Ch
        lea eax, [dword ebp-035Eh]
        call FreeStatTable
        push dword [byte ebp+062h]
        push dword [byte ebp+06Eh]
        push dword [byte ebp+02h]
        push dword [byte ebp+052h]
        mov ebx, esi
        push dword [byte ebp+05Eh]
        mov ecx, dword [byte ebp+076h]
        push dword [byte ebp+056h]
        lea eax, [dword ebp-035Eh]
        push dword [byte ebp+06Ah]
        mov edx, dword [StatsMenuItems]
        push dword [byte ebp+05Ah]
        mov ecx, dword [byte ecx+02Ch]
        push dword [byte ebp+06h]
        add edx, 2E2h
        call SetSkaterStatColumns
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        je short .49
        mov eax, dword [StatsColumn]
        mov ax, word [nosplit eax*2+StatsColumnFields]
        shl eax, 3
.46:
        movsx edx, ax
.47:
        lea eax, [dword ebp-035Eh]
.48:
        call SortStatTableBy
        jmp near StatsTablesScreen_BC9.50
.49:
        lea eax, [dword ebp-035Eh]
        xor edx, edx
        jmp short .48
StatsTablesScreen_BC9:
        push eax
        mov ecx, str_RS21
        mov ebx, str_RS20
        push str_RS22
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Ah]
        add eax, 0F6h
        call DrawStatTable
        push StatsRowShape
        push str_RS21RS22RS23
        push dword [byte ebp+07Ah]
        call FindShapeList
        add esp, byte 0Ch
        lea eax, [dword ebp-035Eh]
        call FreeStatTable
        push dword [byte ebp+062h]
        push dword [byte ebp+06Eh]
        push dword [byte ebp+022h]
        push dword [byte ebp-02h]
        push dword [byte ebp+03Eh]
        mov ebx, esi
        push dword [byte ebp+046h]
        mov ecx, dword [byte ebp+076h]
        push dword [byte ebp+03Ah]
        lea eax, [dword ebp-035Eh]
        push dword [byte ebp+06Ah]
        mov edx, dword [StatsMenuItems]
        push dword [byte ebp+05Ah]
        mov ecx, dword [byte ecx+02Ch]
        push dword [byte ebp+06h]
        add edx, 2E2h
        call SetGoalieStatColumns
.50:
        cmp dword [byte ebp+0Ah], byte 4
        jne near StatsTablesScreen_D0E.54
        cmp dword [byte ebp+02Eh], byte 0
        jne near StatsTablesScreen_D0E.53
        mov dword [byte ebp+02Eh], 1
        jmp near StatsTablesScreen_D0E.54
StatsTablesScreen_C68:
        push eax
        mov ecx, str_RS25
        mov ebx, str_RS24
        push str_RS26
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Ah]
        add eax, 0F6h
        call DrawStatTable
        push StatsRowShape
        push str_RS25RS26RS27
        push dword [byte ebp+07Ah]
        call FindShapeList
        add esp, byte 0Ch
        lea eax, [dword ebp-035Eh]
        call FreeStatTable
        push dword [byte ebp+062h]
        push dword [byte ebp+06Eh]
        push dword [byte ebp+02h]
        push dword [byte ebp+052h]
        mov ebx, esi
        push dword [byte ebp+05Eh]
        mov ecx, dword [byte ebp+076h]
        push dword [byte ebp+056h]
        lea eax, [dword ebp-035Eh]
        push dword [byte ebp+06Ah]
        mov edx, dword [StatsMenuItems]
        push dword [byte ebp+05Ah]
        mov ecx, dword [byte ecx+02Ch]
        push dword [byte ebp+06h]
        add edx, 2E2h
        call SetSkaterStatColumns
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        je short .51
        mov eax, dword [StatsColumn]
        mov ax, word [nosplit eax*2+StatsColumnFields]
        shl eax, 3
        or al, 2
        jmp near StatsTablesScreen_B17.46
.51:
        mov edx, 2
        jmp near StatsTablesScreen_B17.47
StatsTablesScreen_D0E:
        push eax
        mov ecx, str_RS29
        mov ebx, str_RS28
        push str_RS30
        mov eax, dword [StatsMenuItems]
        mov edx, dword [byte ebp+07Ah]
        add eax, 0F6h
        call DrawStatTable
        push StatsRowShape
        push str_RS29RS30RS31
        push dword [byte ebp+07Ah]
        call FindShapeList
        add esp, byte 0Ch
        lea eax, [dword ebp-035Eh]
        call FreeStatTable
        push dword [byte ebp+062h]
        push dword [byte ebp+06Eh]
        push dword [byte ebp+02h]
        push dword [byte ebp+052h]
        mov ebx, esi
        push dword [byte ebp+05Eh]
        mov ecx, dword [byte ebp+076h]
        push dword [byte ebp+056h]
        lea eax, [dword ebp-035Eh]
        push dword [byte ebp+06Ah]
        mov edx, dword [StatsMenuItems]
        push dword [byte ebp+05Ah]
        mov ecx, dword [byte ecx+02Ch]
        push dword [byte ebp+06h]
        add edx, 2E2h
        call SetSkaterStatColumns
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        je short .52
        mov eax, dword [StatsColumn]
        mov ax, word [nosplit eax*2+StatsColumnFields]
        shl eax, 3
        or al, 4
        jmp near StatsTablesScreen_B17.46
.52:
        mov edx, 4
        jmp near StatsTablesScreen_B17.47
.53:
        mov dword [byte ebp+02Eh], 0
.54:
        mov ebx, dword [byte ebp+072h]
        add ebx, 0C0h
        cmp dword [byte ebp+02Eh], byte 0
        jne short .56
        mov ax, word [StatTableSortColumn]
        and al, 0FEh
        movsx edx, ax
        lea eax, [dword ebp-035Eh]
        mov ecx, str_RS33
        call SortStatTableBy
        push ebx
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [StatsMenuItems]
        push str_RS34
        mov ebx, str_RS32
        add eax, 148h
        call DrawStatTable
        push StatsArrowUp
        push str_RS33RS34RS35
.55:
        push dword [byte ebp+07Ah]
        call FindShapeList
        add esp, byte 0Ch
        jmp near .100
.56:
        mov ax, word [StatTableSortColumn]
        or al, 1
        movsx edx, ax
        lea eax, [dword ebp-035Eh]
        mov ecx, str_RS37
        call SortStatTableBy
        push ebx
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [StatsMenuItems]
        push str_RS38
        mov ebx, str_RS36
        add eax, 148h
        call DrawStatTable
        push StatsArrowUp
        push str_RS37RS38RS39
        jmp short .55
.57:
        xor ebx, ebx
        jmp near .63
.58:
        cmp dword [StatsPlayoffMode], byte 0
        je short .59
        push dword [nosplit ebx*4+PlayoffTeams]
        jmp short .60
.59:
        push ebx
.60:
        push str_LB02d2
        lea eax, [byte ebp-036h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-036h]
        push eax
        push dword [byte ebp+016h]
        call FindShape
        mov edx, eax
        mov eax, ebx
        shl eax, 2
        mov dword [dword eax+ebp-010Ah], edx
        add esp, byte 8
        cmp dword [StatsPlayoffMode], byte 0
        je short .61
        push dword [dword eax+PlayoffTeams]
        jmp short .62
.61:
        push ebx
.62:
        push str_LH02d
        lea eax, [byte ebp-036h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-036h]
        push eax
        push dword [byte ebp+016h]
        inc ebx
        call FindShape
        add esp, byte 8
        mov dword [dword ebp+ebx*4-0A2h], eax
.63:
        mov eax, dword [byte ebp+06h]
        movsx eax, word [eax]
        cmp ebx, eax
        jl near .58
        push str_LB26
        push dword [byte ebp+07Ah]
        call FindShape
        add esp, byte 8
        push str_LH26
        push dword [byte ebp+07Ah]
        mov dword [dword ebp-010Eh], eax
        call FindShape
        mov dword [dword ebp-0A2h], eax
        mov eax, dword [StatsMenuItems]
        mov ecx, dword [dword eax+01C4h]
        add esp, byte 8
        add ecx, byte 14h
        mov edx, dword [dword eax+01C0h]
        push ecx
        sub edx, byte 14h
        push edx
        mov edx, dword [byte ebp+076h]
        mov ebx, dword [dword eax+01C0h]
        push dword [byte edx+02Ch]
        lea edx, [dword ebp-0A2h]
        mov eax, dword [byte ebp+06h]
        push edx
        lea edx, [dword ebp-010Eh]
        movsx eax, word [eax]
        push edx
        inc eax
        mov edx, 0Ah
        call RunScrollList
        mov dword [byte ebp+0Ah], eax
        cmp eax, byte 0FFFFFFFFh
        je short .64
        lea edx, [byte eax-01h]
        mov dword [StatsColumn], edx
        mov ebx, dword [StatsMenuItems]
        mov eax, dword [dword ebp+eax*4-010Eh]
        mov dword [dword ebx+01B4h], eax
        mov eax, dword [byte ebp+0Ah]
        mov edx, dword [StatsMenuItems]
        mov eax, dword [dword ebp+eax*4-0A2h]
        mov dword [dword edx+01B8h], eax
        mov eax, dword [byte ebp+0Ah]
        mov ebx, dword [StatsMenuItems]
        mov eax, dword [dword ebp+eax*4-0A2h]
        mov dword [dword ebx+01BCh], eax
.64:
        mov ax, word [StatTableSortColumn]
        xor ah, ah
        and al, 7
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        je short .66
        mov edx, dword [StatsColumn]
        mov dx, word [nosplit edx*2+StatsColumnFields]
.65:
        shl edx, 3
        or eax, edx
.66:
        movsx edx, ax
        lea eax, [dword ebp-035Eh]
        call SortStatTableBy
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        jne short .68
        push str_TTL1
.67:
        push dword [byte ebp+07Ah]
        call FindShape
        add esp, byte 8
        mov ebx, eax
        call SetScreenTarget
        push ebx
        call BlitShape2
        add esp, byte 4
        mov byte [byte ebp+07Eh], 1
        jmp near .99
.68:
        push str_TTL0
        jmp short .67
.69:
        cmp dword [LinkGameActive], byte 0
        jne short .70
        lea eax, [dword ebp-035Eh]
        call ExportStatTable
        jmp near .100
.70:
        cmp eax, byte 2
        jne short .71
        lea eax, [dword ebp-035Eh]
        call ExportStatTable
        call LinkSyncMenu
        jmp near .100
.71:
        mov eax, 237h
        call GetLangText
        call LinkSyncScreen
        jmp near .100
.72:
        dec dword [StatsColumn]
        cmp dword [StatsColumn], byte 0FFFFFFFEh
        jne short .73
        mov eax, dword [byte ebp+06h]
        movsx eax, word [eax]
        dec eax
        mov dword [StatsColumn], eax
.73:
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        je near .78
        cmp dword [StatsPlayoffMode], byte 0
        je short .74
        mov eax, dword [StatsColumn]
        push dword [nosplit eax*4+PlayoffTeams]
        jmp short .75
.74:
        push dword [StatsColumn]
.75:
        push str_LB02d2
        lea eax, [byte ebp-036h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-036h]
        push eax
        push dword [byte ebp+016h]
        call FindShape
        mov edx, eax
        mov eax, dword [StatsMenuItems]
        mov dword [dword eax+01B4h], edx
        add esp, byte 8
        cmp dword [StatsPlayoffMode], byte 0
        je short .76
        mov eax, dword [StatsColumn]
        push dword [nosplit eax*4+PlayoffTeams]
        jmp short .77
.76:
        push dword [StatsColumn]
.77:
        push str_LH02d
        lea eax, [byte ebp-036h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-036h]
        push eax
        push dword [byte ebp+016h]
        jmp short .79
.78:
        push str_LB26
        push dword [byte ebp+07Ah]
        call FindShape
        add esp, byte 8
        push str_LH26
        mov edx, eax
        mov eax, dword [StatsMenuItems]
        push dword [byte ebp+07Ah]
        mov dword [dword eax+01B4h], edx
.79:
        call FindShape
        mov edx, eax
        mov eax, dword [StatsMenuItems]
        mov dword [dword eax+01BCh], edx
        mov eax, dword [StatsMenuItems]
        add esp, byte 8
        mov dword [dword eax+01B8h], edx
        mov ax, word [StatTableSortColumn]
        xor ah, ah
        and al, 7
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        je near .66
        mov ebx, dword [StatsColumn]
        mov dx, word [nosplit ebx*2+StatsColumnFields]
        jmp near .65
.80:
        mov eax, dword [byte ebp+06h]
        inc dword [StatsColumn]
        movsx eax, word [eax]
        cmp eax, dword [StatsColumn]
        jne short .81
        mov dword [StatsColumn], 0FFFFFFFFh
.81:
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        je near .86
        cmp dword [StatsPlayoffMode], byte 0
        je short .82
        mov eax, dword [StatsColumn]
        push dword [nosplit eax*4+PlayoffTeams]
        jmp short .83
.82:
        push dword [StatsColumn]
.83:
        push str_LB02d2
        lea eax, [byte ebp-036h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-036h]
        push eax
        push dword [byte ebp+016h]
        call FindShape
        mov edx, eax
        mov eax, dword [StatsMenuItems]
        mov dword [dword eax+01B4h], edx
        add esp, byte 8
        cmp dword [StatsPlayoffMode], byte 0
        je short .84
        mov eax, dword [StatsColumn]
        push dword [nosplit eax*4+PlayoffTeams]
        jmp short .85
.84:
        push dword [StatsColumn]
.85:
        push str_LH02d
        lea eax, [byte ebp-036h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-036h]
        push eax
        push dword [byte ebp+016h]
        jmp short .87
.86:
        push str_LB26
        push dword [byte ebp+07Ah]
        call FindShape
        add esp, byte 8
        push str_LH26
        mov edx, eax
        mov eax, dword [StatsMenuItems]
        push dword [byte ebp+07Ah]
        mov dword [dword eax+01B4h], edx
.87:
        call FindShape
        mov edx, eax
        mov eax, dword [StatsMenuItems]
        mov dword [dword eax+01BCh], edx
        mov eax, dword [StatsMenuItems]
        add esp, byte 8
        mov dword [dword eax+01B8h], edx
        mov ax, word [StatTableSortColumn]
        xor ah, ah
        mov byte [byte ebp+07Eh], 1
        and al, 7
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        je short .88
        mov ebx, dword [StatsColumn]
        mov dx, word [nosplit ebx*2+StatsColumnFields]
        shl edx, 3
        or eax, edx
.88:
        movsx edx, ax
        lea eax, [dword ebp-035Eh]
        call SortStatTableBy
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        jne short .89
        push str_TTL1
        jmp short .90
.89:
        push str_TTL0
.90:
        push dword [byte ebp+07Ah]
        call FindShape
        add esp, byte 8
        mov ebx, eax
        call SetScreenTarget
        push ebx
        call BlitShape2
        add esp, byte 4
        jmp near .99
.91:
        cmp dword [byte ebp+0Ah], byte 8
        jle near .100
        lea ecx, [byte ebp+0Eh]
        lea eax, [dword ebp-035Eh]
        push edx
        mov edx, dword [byte ebp+0Ah]
        xor ebx, ebx
        sub edx, byte 9
        call SortStatTable
        cmp dword [byte ebp+0Eh], byte 0FFFFFFFFh
        je near .100
        cmp dword [byte ebp+0Eh], byte 0
        je near .100
        push dword [byte ebp+02Ah]
        call SetDrawTarget
        add esp, byte 4
        push dword 0FFFFFF7Eh
        mov eax, dword [byte ebp+076h]
        push byte 0FFFFFF9Ch
        push dword [byte eax+02Ch]
        call BlitArt
        mov ebx, dword [byte ebp+0Eh]
        shl ebx, 2
        add esp, byte 0Ch
        add ebx, dword [byte ebp+062h]
        cmp dword [byte ebp+0Eh], byte 2
        jne short .93
        mov eax, dword [ebx]
        mov ecx, 0Ch
        cdq
        idiv ecx
        mov eax, dword [ebx]
        push edx
        cdq
        idiv ecx
        push eax
        mov eax, 23Dh
        call GetLangText
        push eax
        mov eax, dword [byte ebp+0Eh]
        shl eax, 2
        add eax, dword [byte ebp+06Eh]
        mov eax, dword [eax]
        mov ebx, 64h
        cdq
        idiv ebx
        mov ebx, eax
        cdq
        idiv ecx
        mov eax, ebx
        push edx
        cdq
        idiv ecx
        push eax
        mov eax, 23Eh
        call GetLangText
        push eax
        push str_SDDSDD
.92:
        lea eax, [byte ebp-036h]
        push eax
        call sprintf_
        add esp, byte 20h
        jmp near .98
.93:
        cmp dword [byte ebp+0Eh], byte 6
        jne short .94
        cmp dword [byte ebp+012h], byte 1
        jne short .94
        mov eax, dword [ebx]
        mov ecx, 64h
        cdq
        idiv ecx
        mov eax, dword [ebx]
        push edx
        cdq
        idiv ecx
        push eax
        mov eax, 23Dh
        call GetLangText
        mov ebx, dword [byte ebp+0Eh]
        shl ebx, 2
        add ebx, dword [byte ebp+06Eh]
        push eax
        mov eax, dword [ebx]
        cdq
        idiv ecx
        mov eax, dword [ebx]
        push edx
        cdq
        idiv ecx
        push eax
        mov eax, 23Eh
        call GetLangText
        push eax
        push str_SD02dSD02d
        jmp short .92
.94:
        cmp dword [byte ebp+0Eh], byte 8
        jne short .95
        cmp dword [byte ebp+012h], byte 1
        jne short .95
        mov ebx, dword [byte ebp+0Eh]
        shl ebx, 2
        add ebx, dword [byte ebp+062h]
        mov eax, dword [ebx]
        mov ecx, 0Ah
        cdq
        idiv ecx
        mov eax, dword [ebx]
        push edx
        cdq
        idiv ecx
        push eax
        mov eax, 23Dh
        call GetLangText
        mov ebx, dword [byte ebp+0Eh]
        shl ebx, 2
        add ebx, dword [byte ebp+06Eh]
        push eax
        mov eax, dword [ebx]
        mov ecx, 3E8h
        cdq
        idiv ecx
        mov eax, edx
        mov ecx, 0Ah
        cdq
        idiv ecx
        push eax
        mov eax, dword [ebx]
        mov ecx, 3E8h
        cdq
        idiv ecx
        push eax
        mov eax, 23Eh
        call GetLangText
        push eax
        push str_SD02dSDD
        jmp near .92
.95:
        mov eax, dword [byte ebp+0Eh]
        mov edx, dword [byte ebp+06Eh]
        shl eax, 2
        add edx, eax
        add eax, dword [byte ebp+062h]
        cmp dword [edx], byte 0
        jl short .96
        push dword [eax]
        mov eax, 23Dh
        call GetLangText
        mov ebx, dword [byte ebp+0Eh]
        shl ebx, 2
        add ebx, dword [byte ebp+06Eh]
        push eax
        mov eax, dword [ebx]
        mov ecx, 64h
        cdq
        idiv ecx
        mov eax, dword [ebx]
        push edx
        cdq
        idiv ecx
        push eax
        mov eax, 23Eh
        call GetLangText
        push eax
        push str_SDDSD
        jmp short .97
.96:
        push dword [eax]
        mov eax, 23Dh
        call GetLangText
        mov ebx, dword [byte ebp+0Eh]
        shl ebx, 2
        add ebx, dword [byte ebp+06Eh]
        push eax
        mov eax, dword [ebx]
        neg eax
        mov ecx, 64h
        cdq
        idiv ecx
        mov eax, dword [ebx]
        push edx
        cdq
        idiv ecx
        push eax
        mov eax, 23Eh
        call GetLangText
        push eax
        push str_SDDSD2
.97:
        lea eax, [byte ebp-036h]
        push eax
        call sprintf_
        add esp, byte 1Ch
.98:
        lea eax, [byte ebp-036h]
        push eax
        push byte 0
        push dword 0DCh
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        call SetScreenTarget
        push dword 82h
        mov eax, dword [byte ebp+02Ah]
        push byte 64h
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
.99:
        call PresentScreen
.100:
        cmp byte [byte ebp+07Eh], 0
        je near StatsTablesScreen.24
        lea eax, [dword ebp-035Eh]
        call DrawStatTableRows
        call SetScreenTarget
        push dword [dword ebp-032Fh]
        mov eax, dword [dword ebp-0117h]
        push dword [dword ebp-0333h]
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        push dword [byte ebp+066h]
        call FreeMemBlock
        add esp, byte 4
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        je short .104
        mov eax, 39h
        call OpenDataLibrary
        cmp dword [StatsPlayoffMode], byte 0
        jne short .101
        push dword [StatsColumn]
        jmp short .102
.101:
        mov eax, dword [StatsColumn]
        push dword [nosplit eax*4+PlayoffTeams]
.102:
        push str_LOGO02dFSH
        lea eax, [byte ebp-036h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        cmp dword [byte ebp+04Eh], byte 0
        je short .103
        push dword [byte ebp+04Eh]
        call FreeMemBlock
        add esp, byte 4
.103:
        push byte 0
        lea eax, [byte ebp-036h]
        push eax
        call OpenArtArchiveErr
        add esp, byte 8
        push dword [MenuScreenBitmap]
        push str_LOGO6
        push eax
        mov dword [byte ebp+04Eh], eax
        jmp short .105
.104:
        push dword [MenuScreenBitmap]
        push str_NHLP2
        push dword [byte ebp+016h]
.105:
        call FindShape
        add esp, byte 8
        push eax
        call ConvertArtNew
        add esp, byte 8
        mov dword [byte ebp+066h], eax
        cmp byte [FrontMusicOn], 0
        jne short .106
        push dword [byte ebp+036h]
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        call ClearScreen
        add esp, byte 4
        push byte 0
        push byte 0
        push dword [byte ebp+066h]
        push dword 14CCCh
        call DrawShapeBlended
        add esp, byte 10h
.106:
        push dword [byte ebp+076h]
        call SetDrawTarget
        add esp, byte 4
        push dword [byte ebp+01Ah]
        call BlitShape2
        add esp, byte 4
        cmp dword [StatsColumn], byte 0FFFFFFFFh
        jne short .107
        push str_TTL1
        jmp short .108
.107:
        push str_TTL0
.108:
        push dword [byte ebp+07Ah]
        call FindShape
        add esp, byte 8
        mov ebx, eax
        push ebx
        call BlitShape2
        add esp, byte 4
        xor ebx, ebx
.109:
        imul edx, ebx, byte 52h
        mov eax, dword [StatsMenuItems]
        add eax, edx
        cmp dword [byte eax+01Ah], byte 0
        je short .110
        push dword [byte eax+02Ah]
        push dword [byte eax+026h]
        push dword [byte eax+01Ah]
        call DrawArt
        add esp, byte 0Ch
.110:
        inc ebx
        cmp ebx, byte 8
        jl short .109
        cmp byte [FrontMusicOn], 0
        je short .111
        push byte 78h
        push dword 8Ch
        push dword [byte ebp+066h]
        push dword 14CCCh
        call DrawSpriteScaledBy
        add esp, byte 10h
        jmp short .112
.111:
        push dword 12Ch
        push dword 12Ch
        push byte 78h
        mov edx, dword [byte ebp+076h]
        mov eax, dword [byte ebp+036h]
        push dword 8Ch
        mov ebx, 10h
        xor ecx, ecx
        push byte 0
        mov edx, dword [byte edx+02Ch]
        mov eax, dword [byte eax+02Ch]
        call DrawShadedLogo
.112:
        push dword [dword ebp-0117h]
        call SetDrawTarget
        mov eax, dword [dword ebp-032Fh]
        add esp, byte 4
        neg eax
        push eax
        mov eax, dword [dword ebp-0333h]
        neg eax
        push eax
        mov eax, dword [byte ebp+076h]
        push dword [byte eax+02Ch]
        call BlitClippedY
        add esp, byte 0Ch
        lea eax, [dword ebp-035Eh]
        call DrawStatTableRows
        call SetScreenTarget
        push byte 0
        mov eax, dword [byte ebp+076h]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        push dword [dword ebp-032Fh]
        mov eax, dword [dword ebp-0117h]
        push dword [dword ebp-0333h]
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        mov byte [byte ebp+07Eh], 0
        call PresentScreen
        jmp near StatsTablesScreen.24
.113:
        lea eax, [dword ebp-035Eh]
        call FreeStatTable
        push dword [byte ebp+016h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+07Ah]
        call FreeMemBlock
        add esp, byte 4
        cmp dword [byte ebp+04Eh], byte 0
        je short .114
        push dword [byte ebp+04Eh]
        call FreeMemBlock
        add esp, byte 4
.114:
        push dword [byte ebp+066h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+022h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+05Ah]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+06Ah]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+056h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+03Ah]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+052h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+03Eh]
        call FreeMemBlock
        add esp, byte 4
        push dword [StatsMenuItems]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+072h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+026h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+01Eh]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+05Eh]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+046h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+06Eh]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+062h]
        call FreeMemBlock
        add esp, byte 4
        lea eax, [byte ebp+06h]
        call FreeDbBlock
        push dword [byte ebp+02Ah]
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp+076h]
        call FreeBitmap
        add esp, byte 4
        cmp byte [FrontMusicOn], 0
        jne short .115
        push dword [byte ebp+036h]
        call FreeBitmap
        add esp, byte 4
.115:
        call FreeStatsBitmap
        call SetNormalText
        cmp byte [FrontMusicOn], 0
        je short .116
        call LoadFrontEndSfx
.116:
        mov eax, dword [byte ebp+032h]
        jmp near TeamStatsScreen_13BC
;-----------------------------------------------------------------------------
; BuildTeamStatsTable                             B0906  97 PC, low confidence
; Builds the team stats table
;-----------------------------------------------------------------------------
BuildTeamStatsTable:
        push esi
        push edi
        enter 0D4h, 0
        sub ebp, byte 66h
        mov edi, eax
        mov esi, edx
        mov dword [byte ebp+05Eh], ecx
        mov dword [byte ebp+062h], 0
        jmp near .12
.1:
        imul edx, dword [byte ebp+062h], dword 194Fh
        mov ecx, dword [byte ebp+062h]
        mov eax, dword [byte edi+01Ch]
        shl ecx, 3
        add eax, ecx
        add edx, dword [byte ebp+05Eh]
        call FindGameRecord
        imul edx, dword [byte ebp+062h], byte 66h
        mov eax, dword [byte edi+014h]
        add eax, ecx
        add edx, dword [byte ebp+076h]
        xor ecx, ecx
        call FindTeamRecord
        jmp short .3
.2:
        call ServiceIdle
        imul eax, ecx, byte 38h
        imul edx, dword [esi], byte 3Dh
        mov dword [byte ebp+052h], eax
        mov eax, dword [byte ebp+056h]
        add eax, 0D09h
        add eax, dword [byte ebp+052h]
        mov dword [byte ebp+04Eh], eax
        add eax, byte 20h
        add edx, dword [dword ebp+08Ah]
        call FindTeamStat
        mov eax, dword [byte ebp+04Eh]
        lea edx, [byte ebp-06Eh]
        add eax, byte 18h
        call FindPlayerRecord
        imul edx, dword [esi], byte 27h
        mov eax, dword [byte ebp+04Eh]
        add eax, byte 28h
        add edx, dword [byte ebp+07Ah]
        call FindPlayerStat
        lea eax, [byte ebp-056h]
        push eax
        lea eax, [byte ebp-066h]
        push eax
        mov eax, dword [byte ebp+056h]
        add eax, dword [byte ebp+052h]
        movzx eax, byte [dword eax+0D0Bh]
        push eax
        mov eax, dword [esi]
        shl eax, 2
        push str_CSS
        add eax, dword [dword ebp+082h]
        push dword [eax]
        inc ecx
        call sprintf_
        add esp, byte 14h
        inc dword [esi]
.3:
        imul eax, dword [byte ebp+062h], dword 194Fh
        mov edx, dword [byte ebp+05Eh]
        add edx, eax
        movsx eax, word [dword edx+0D05h]
        mov dword [byte ebp+056h], edx
        cmp ecx, eax
        jl near .2
        xor ecx, ecx
        jmp short .5
.4:
        call ServiceIdle
        imul eax, ecx, byte 38h
        imul edx, dword [esi], byte 3Dh
        mov dword [byte ebp+04Eh], eax
        mov eax, dword [byte ebp+05Ah]
        add eax, 132Dh
        add eax, dword [byte ebp+04Eh]
        mov dword [byte ebp+052h], eax
        add eax, byte 20h
        add edx, dword [dword ebp+08Ah]
        call FindTeamStat
        mov eax, dword [byte ebp+052h]
        lea edx, [byte ebp-06Eh]
        add eax, byte 18h
        call FindPlayerRecord
        imul edx, dword [esi], byte 27h
        mov eax, dword [byte ebp+052h]
        add eax, byte 28h
        add edx, dword [byte ebp+07Ah]
        call FindPlayerStat
        lea eax, [byte ebp-056h]
        push eax
        lea eax, [byte ebp-066h]
        push eax
        mov eax, dword [byte ebp+05Ah]
        add eax, dword [byte ebp+04Eh]
        movzx eax, byte [dword eax+0132Fh]
        push eax
        mov eax, dword [esi]
        shl eax, 2
        push str_CSS
        add eax, dword [dword ebp+082h]
        push dword [eax]
        inc ecx
        call sprintf_
        add esp, byte 14h
        inc dword [esi]
.5:
        imul eax, dword [byte ebp+062h], dword 194Fh
        mov edx, dword [byte ebp+05Eh]
        add edx, eax
        movsx eax, word [dword edx+0132Bh]
        mov dword [byte ebp+05Ah], edx
        cmp ecx, eax
        jl near .4
        xor ecx, ecx
        jmp near .8
.6:
        call ServiceIdle
        imul eax, dword [ebx], byte 3Dh
        mov dword [byte ebp+052h], eax
        mov eax, dword [dword ebp+08Eh]
        add eax, dword [byte ebp+052h]
        mov dword [byte ebp+052h], eax
        imul eax, ecx, byte 38h
        add edx, 1283h
        add eax, edx
        mov edx, dword [byte ebp+052h]
        mov dword [byte ebp+052h], eax
        add eax, byte 20h
        call FindTeamStat
        mov eax, dword [byte ebp+052h]
        lea edx, [byte ebp-06Eh]
        add eax, byte 18h
        call FindPlayerRecord
        imul edx, dword [ebx], byte 27h
        mov eax, dword [byte ebp+052h]
        add eax, byte 28h
        add edx, dword [byte ebp+07Eh]
        call FindPlayerStat
        lea eax, [byte ebp-056h]
        push eax
        lea eax, [byte ebp-066h]
        push eax
        mov eax, dword [ebx]
        push byte 47h
        shl eax, 2
        push str_CSS
        add eax, dword [dword ebp+086h]
        push dword [eax]
        call sprintf_
        imul eax, dword [ebx], byte 3Dh
        add eax, dword [dword ebp+08Eh]
        add esp, byte 14h
        cmp word [byte eax+030h], byte 0
        jne short .7
        cmp dword [byte eax+02Ah], byte 0
        jne short .7
        mov word [byte eax+030h], 0FFFFh
.7:
        inc ecx
        inc dword [ebx]
.8:
        imul edx, dword [byte ebp+062h], dword 194Fh
        add edx, dword [byte ebp+05Eh]
        movsx eax, word [dword edx+01281h]
        cmp ecx, eax
        jl near .6
        xor ecx, ecx
        jmp near .11
.9:
        call ServiceIdle
        imul eax, dword [ebx], byte 3Dh
        mov dword [byte ebp+052h], eax
        mov eax, dword [dword ebp+08Eh]
        add eax, dword [byte ebp+052h]
        mov dword [byte ebp+052h], eax
        imul eax, ecx, byte 38h
        add edx, 18A7h
        add eax, edx
        mov edx, dword [byte ebp+052h]
        mov dword [byte ebp+052h], eax
        add eax, byte 20h
        call FindTeamStat
        mov eax, dword [byte ebp+052h]
        lea edx, [byte ebp-06Eh]
        add eax, byte 18h
        call FindPlayerRecord
        imul edx, dword [ebx], byte 27h
        mov eax, dword [byte ebp+052h]
        add eax, byte 28h
        add edx, dword [byte ebp+07Eh]
        call FindPlayerStat
        lea eax, [byte ebp-056h]
        push eax
        lea eax, [byte ebp-066h]
        push eax
        mov eax, dword [ebx]
        push byte 47h
        shl eax, 2
        push str_CSS
        add eax, dword [dword ebp+086h]
        push dword [eax]
        call sprintf_
        imul eax, dword [ebx], byte 3Dh
        add eax, dword [dword ebp+08Eh]
        add esp, byte 14h
        cmp word [byte eax+030h], byte 0
        jne short .10
        cmp dword [byte eax+02Ah], byte 0
        jne short .10
        mov word [byte eax+030h], 0FFFFh
.10:
        inc ecx
        inc dword [ebx]
.11:
        imul edx, dword [byte ebp+062h], dword 194Fh
        add edx, dword [byte ebp+05Eh]
        movsx eax, word [dword edx+018A5h]
        cmp ecx, eax
        jl near .9
        inc dword [byte ebp+062h]
.12:
        movsx eax, word [edi]
        cmp eax, dword [byte ebp+062h]
        jg near .1
        lea esp, [byte ebp+066h]
        pop ebp
        pop edi
        pop esi
        ret 1Ch
;-----------------------------------------------------------------------------
; SetSkaterStatColumns                            B0C05  97 PC, low confidence
; Stats lists: the skater column titles (Team, #, Height, Weight, GP, G, A,
; P, +/-, PIM, PPG, SHG, Shots...)
;-----------------------------------------------------------------------------
SetSkaterStatColumns:
        push esi
        push edi
        enter 28h, 0
        mov edi, dword [byte ebp+028h]
        mov esi, eax
        push ecx
        push byte 14h
        push byte 2Dh
        push dword 0E6h
        push dword 96h
        push byte 1Eh
        push ebx
        push edx
        mov ecx, 0Ah
        push byte 6
        mov ebx, 0Dh
        mov edx, edi
        call AllocStatTable
        xor edi, edi
        xor ebx, ebx
        jmp near .12
.1:
        xor ecx, ecx
        jmp near .6
.2:
        imul eax, ebx, byte 66h
        add eax, dword [byte ebp+018h]
        add eax, byte 26h
        mov dword [byte ebp-028h], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
        mov edx, dword [byte ebp-028h]
        mov dword [eax], edx
        imul eax, ecx, byte 38h
        mov edx, dword [byte ebp-014h]
        add edx, 0D09h
        add eax, edx
        inc eax
        mov dword [byte ebp-028h], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        inc eax
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
        mov edx, dword [byte ebp-028h]
        mov dword [eax], edx
        imul eax, edi, byte 27h
        mov edx, dword [byte ebp+01Ch]
        add edx, eax
        mov dword [byte ebp-028h], edx
        lea eax, [byte edx+021h]
        mov dword [byte ebp-024h], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        inc eax
        inc eax
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
        mov edx, dword [byte ebp-024h]
        mov dword [eax], edx
        mov eax, dword [byte ebp-028h]
        add eax, byte 23h
        mov dword [byte ebp-028h], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        add eax, byte 3
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
        mov edx, dword [byte ebp-028h]
        mov dword [eax], edx
        imul eax, edi, byte 3Dh
        add eax, dword [byte ebp+024h]
        mov dword [byte ebp-08h], 0
        cmp byte [byte eax+038h], 0
        je short .3
        mov dword [byte ebp-08h], 1
.3:
        imul eax, ebx, dword 194Fh
        mov edx, dword [byte ebp+014h]
        add edx, eax
        imul eax, ecx, byte 38h
        add eax, edx
        cmp byte [dword eax+0D0Bh], 44h
        jne short .4
        or byte [byte ebp-08h], 4
        jmp short .5
.4:
        or byte [byte ebp-08h], 2
.5:
        movsx eax, word [nosplit ebx*2+StatsColumnFields]
        mov edx, dword [StatTableColumns]
        shl eax, 3
        inc ecx
        or dword [byte ebp-08h], eax
        lea eax, [edi+edi]
        add eax, edx
        mov edx, dword [byte ebp-08h]
        inc edi
        mov word [eax], dx
.6:
        imul eax, ebx, dword 194Fh
        mov edx, dword [byte ebp+014h]
        add edx, eax
        movsx eax, word [dword edx+0D05h]
        mov dword [byte ebp-014h], edx
        cmp ecx, eax
        jl near .2
        xor ecx, ecx
        jmp near .11
.7:
        imul eax, ebx, byte 66h
        add eax, dword [byte ebp+018h]
        add eax, byte 26h
        mov dword [byte ebp-028h], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
        mov edx, dword [byte ebp-028h]
        mov dword [eax], edx
        imul eax, ecx, byte 38h
        mov dword [byte ebp-028h], eax
        mov eax, dword [byte ebp-018h]
        add eax, 132Dh
        add eax, dword [byte ebp-028h]
        inc eax
        mov dword [byte ebp-024h], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        inc eax
        shl eax, 2
        mov dword [byte ebp-028h], eax
        mov eax, dword [byte esi+012h]
        add eax, dword [byte ebp-028h]
        mov edx, dword [byte ebp-024h]
        mov dword [eax], edx
        imul eax, edi, byte 27h
        mov edx, dword [byte ebp+01Ch]
        add edx, eax
        mov dword [byte ebp-024h], edx
        lea eax, [byte edx+021h]
        mov dword [byte ebp-028h], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        inc eax
        inc eax
        shl eax, 2
        mov dword [byte ebp-04h], eax
        mov eax, dword [byte esi+012h]
        add eax, dword [byte ebp-04h]
        mov edx, dword [byte ebp-028h]
        mov dword [eax], edx
        mov eax, dword [byte ebp-024h]
        add eax, byte 23h
        mov dword [byte ebp-04h], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        add eax, byte 3
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
        mov edx, dword [byte ebp-04h]
        mov dword [eax], edx
        imul eax, edi, byte 3Dh
        add eax, dword [byte ebp+024h]
        mov dword [byte ebp-08h], 0
        cmp byte [byte eax+038h], 0
        je short .8
        mov dword [byte ebp-08h], 1
.8:
        imul eax, ebx, dword 194Fh
        mov edx, dword [byte ebp+014h]
        add edx, eax
        imul eax, ecx, byte 38h
        add eax, edx
        cmp byte [dword eax+0132Fh], 44h
        jne short .9
        or byte [byte ebp-08h], 4
        jmp short .10
.9:
        or byte [byte ebp-08h], 2
.10:
        movsx eax, word [nosplit ebx*2+StatsColumnFields]
        mov edx, dword [StatTableColumns]
        shl eax, 3
        inc ecx
        or dword [byte ebp-08h], eax
        lea eax, [edi+edi]
        add eax, edx
        mov edx, dword [byte ebp-08h]
        inc edi
        mov word [eax], dx
.11:
        imul eax, ebx, dword 194Fh
        mov edx, dword [byte ebp+014h]
        add edx, eax
        movsx eax, word [dword edx+0132Bh]
        mov dword [byte ebp-018h], edx
        cmp ecx, eax
        jl near .7
        inc ebx
.12:
        mov eax, dword [byte ebp+010h]
        movsx eax, word [eax]
        cmp ebx, eax
        jl near .1
        xor ebx, ebx
        jmp near .18
.13:
        mov dword [byte ebp-010h], 0
        xor ecx, ecx
        jmp short .16
.14:
        mov eax, dword [edx]
        cmp byte [ecx+eax], 20h
        jne short .15
        inc dword [byte ebp-010h]
.15:
        inc ecx
.16:
        mov eax, ebx
        mov edx, dword [byte ebp+020h]
        shl eax, 2
        add edx, eax
        mov eax, dword [edx]
        call strlen_
        cmp ecx, eax
        jae short .17
        cmp dword [byte ebp-010h], byte 1
        jl short .14
.17:
        mov eax, ebx
        shl eax, 2
        mov dword [byte ebp-04h], eax
        mov eax, dword [byte ebp+020h]
        add eax, dword [byte ebp-04h]
        mov edx, dword [eax]
        mov eax, dword [StatTableAlpha]
        add eax, dword [byte ebp-04h]
        mov dword [eax], edx
        mov eax, dword [StatTableSortText]
        add eax, dword [byte ebp-04h]
        add edx, ecx
        mov dword [eax], edx
        imul eax, ebx, byte 3Dh
        mov ecx, dword [byte esi+08h]
        imul ecx, ebx
        add ecx, byte 4
        shl ecx, 2
        mov dword [byte ebp-04h], ecx
        mov ecx, dword [byte esi+012h]
        add eax, dword [byte ebp+024h]
        add ecx, dword [byte ebp-04h]
        lea edx, [byte eax+018h]
        mov dword [ecx], edx
        lea edx, [byte eax+01Ah]
        mov dword [byte ebp-04h], edx
        mov edx, dword [byte esi+08h]
        imul edx, ebx
        add edx, byte 5
        mov ecx, dword [byte esi+012h]
        shl edx, 2
        add ecx, edx
        mov edx, dword [byte ebp-04h]
        mov dword [ecx], edx
        mov ecx, dword [byte esi+08h]
        imul ecx, ebx
        add ecx, byte 6
        shl ecx, 2
        mov dword [byte ebp-04h], ecx
        mov ecx, dword [byte esi+012h]
        add ecx, dword [byte ebp-04h]
        lea edx, [byte eax+01Ch]
        mov dword [ecx], edx
        lea edx, [byte eax+01Eh]
        mov dword [byte ebp-04h], edx
        mov edx, dword [byte esi+08h]
        imul edx, ebx
        add edx, byte 7
        mov ecx, dword [byte esi+012h]
        shl edx, 2
        add ecx, edx
        mov edx, dword [byte ebp-04h]
        mov dword [ecx], edx
        lea edx, [byte eax+028h]
        mov dword [byte ebp-04h], edx
        mov edx, dword [byte esi+08h]
        imul edx, ebx
        add edx, byte 8
        mov ecx, dword [byte esi+012h]
        shl edx, 2
        add ecx, edx
        mov edx, dword [byte ebp-04h]
        mov dword [ecx], edx
        lea edx, [byte eax+024h]
        mov dword [byte ebp-04h], edx
        mov edx, dword [byte esi+08h]
        imul edx, ebx
        add edx, byte 9
        mov ecx, dword [byte esi+012h]
        shl edx, 2
        add ecx, edx
        mov edx, dword [byte ebp-04h]
        mov dword [ecx], edx
        lea edx, [byte eax+020h]
        mov dword [byte ebp-01Ch], edx
        mov ecx, dword [byte esi+08h]
        imul ecx, ebx
        add ecx, byte 0Ah
        mov edx, dword [byte esi+012h]
        shl ecx, 2
        add ecx, edx
        mov edx, dword [byte ebp-01Ch]
        mov dword [ecx], edx
        lea edx, [byte eax+022h]
        mov dword [byte ebp-04h], edx
        mov edx, dword [byte esi+08h]
        imul edx, ebx
        add edx, byte 0Bh
        mov ecx, dword [byte esi+012h]
        shl edx, 2
        add ecx, edx
        mov edx, dword [byte ebp-04h]
        mov dword [ecx], edx
        lea edx, [byte eax+026h]
        mov eax, dword [byte esi+08h]
        imul eax, ebx
        add eax, byte 0Ch
        mov ecx, dword [byte esi+012h]
        shl eax, 2
        add eax, ecx
        inc ebx
        mov dword [eax], edx
.18:
        cmp ebx, edi
        jl near .13
        mov eax, 15Ah
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        mov byte [eax], 8
        mov eax, dword [byte esi+027h]
        mov dword [eax], edx
        mov eax, 0BAh
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        inc eax
        mov byte [eax], 5
        mov eax, dword [byte esi+027h]
        add eax, byte 4
        mov dword [eax], edx
        mov eax, 0F2h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        inc eax
        inc eax
        mov byte [eax], 7
        mov eax, dword [byte esi+027h]
        add eax, byte 8
        mov dword [eax], edx
        mov eax, 15Bh
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 3
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 0Ch
        mov dword [eax], edx
        mov eax, 140h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 4
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 10h
        mov dword [eax], edx
        mov eax, 141h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 5
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 14h
        mov dword [eax], edx
        mov eax, 142h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 6
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 18h
        mov dword [eax], edx
        mov eax, 143h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 7
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 1Ch
        mov dword [eax], edx
        mov eax, 159h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 8
        mov byte [eax], 9
        mov eax, dword [byte esi+027h]
        add eax, byte 20h
        mov dword [eax], edx
        mov eax, 144h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 9
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 24h
        mov dword [eax], edx
        mov eax, 145h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 0Ah
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 28h
        mov dword [eax], edx
        mov eax, 146h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 0Bh
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 2Ch
        mov dword [eax], edx
        mov eax, 12Bh
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 0Ch
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 30h
        xor ebx, ebx
        mov dword [eax], edx
.19:
        mov eax, dword [byte ebp+02Ch]
        mov edx, ebx
        mov dword [eax+edx*4], 0
        mov eax, dword [byte ebp+030h]
        xor ecx, ecx
        mov dword [eax+edx*4], 0
        jmp near .29
.20:
        mov eax, dword [byte esi+0Eh]
        mov al, byte [ebx+eax]
        cmp al, 6
        jb short .21
        cmp al, 7
        jbe short .22
        cmp al, 9
        jb near .27
        jbe short .25
        cmp al, 0Dh
        je short .24
        jmp near .27
.21:
        cmp al, 4
        jb near .27
        ja short .23
.22:
        mov eax, dword [byte esi+08h]
        imul eax, ecx
        add eax, ebx
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
        mov eax, dword [eax]
        movsx eax, word [eax]
        jmp short .26
.23:
        mov eax, dword [byte esi+08h]
        imul eax, ecx
        add eax, ebx
        shl eax, 2
        mov dword [byte ebp-04h], eax
        mov eax, dword [byte esi+012h]
        add eax, dword [byte ebp-04h]
        mov eax, dword [eax]
        movzx eax, byte [eax]
        jmp short .26
.24:
        mov eax, dword [byte esi+08h]
        imul eax, ecx
        add eax, ebx
        shl eax, 2
        mov dword [byte ebp-04h], eax
        mov eax, dword [byte esi+012h]
        add eax, dword [byte ebp-04h]
        mov eax, dword [eax]
        mov eax, dword [eax]
        mov dword [byte ebp-04h], 3Ch
        cdq
        idiv dword [byte ebp-04h]
        jmp short .26
.25:
        mov eax, dword [byte esi+08h]
        imul eax, ecx
        add eax, ebx
        shl eax, 2
        mov dword [byte ebp-04h], eax
        mov eax, dword [byte esi+012h]
        add eax, dword [byte ebp-04h]
        mov eax, dword [eax]
        movsx eax, word [eax]
.26:
        mov dword [byte ebp-0Ch], eax
.27:
        imul edx, dword [byte ebp-0Ch], byte 64h
        mov eax, ebx
        shl eax, 2
        mov dword [byte ebp-020h], eax
        mov eax, dword [byte ebp+02Ch]
        add eax, dword [byte ebp-020h]
        add dword [eax], edx
        mov eax, dword [byte ebp+030h]
        add eax, dword [byte ebp-020h]
        mov edx, dword [byte ebp-0Ch]
        cmp edx, dword [eax]
        jle short .28
        mov dword [eax], edx
.28:
        inc ecx
.29:
        cmp ecx, edi
        jl near .20
        mov ecx, ebx
        shl ecx, 2
        add ecx, dword [byte ebp+02Ch]
        mov eax, dword [ecx]
        cdq
        idiv edi
        inc ebx
        mov dword [ecx], eax
        cmp ebx, byte 0Dh
        jl near .19
        jmp near AllocStatTable_2AA
;-----------------------------------------------------------------------------
; SetGoalieStatColumns                            B1248  97 PC, low confidence
; Stats lists: the goalie column titles (GP, Minutes, G.A.A., Shots, S%, GA,
; SO, ENG...)
;-----------------------------------------------------------------------------
SetGoalieStatColumns:
        push esi
        push edi
        enter 2Ch, 0
        mov edi, dword [byte ebp+028h]
        mov esi, eax
        push ecx
        push byte 14h
        push byte 2Dh
        push dword 0E6h
        push dword 96h
        push byte 1Eh
        push ebx
        push edx
        mov ecx, 0Ah
        push byte 6
        mov ebx, 0Fh
        mov edx, edi
        call AllocStatTable
        xor edi, edi
        xor ebx, ebx
        jmp near .8
.1:
        xor ecx, ecx
        jmp near .4
.2:
        imul eax, ebx, byte 66h
        add eax, dword [byte ebp+018h]
        lea edx, [byte eax+026h]
        mov eax, dword [byte esi+08h]
        imul eax, edi
        shl eax, 2
        mov dword [byte ebp-02Ch], eax
        mov eax, dword [byte esi+012h]
        add eax, dword [byte ebp-02Ch]
        mov dword [eax], edx
        imul eax, ecx, byte 38h
        mov edx, dword [byte ebp-018h]
        add edx, 1283h
        add eax, edx
        inc eax
        mov dword [byte ebp-02Ch], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        inc eax
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
        mov edx, dword [byte ebp-02Ch]
        mov dword [eax], edx
        imul eax, edi, byte 27h
        mov edx, dword [byte ebp+01Ch]
        add edx, eax
        mov dword [byte ebp-02Ch], edx
        lea eax, [byte edx+01Dh]
        mov dword [byte ebp-020h], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        inc eax
        inc eax
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
        mov edx, dword [byte ebp-020h]
        mov dword [eax], edx
        mov eax, dword [byte ebp-02Ch]
        add eax, byte 1Fh
        mov dword [byte ebp-02Ch], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        add eax, byte 3
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
        mov edx, dword [byte ebp-02Ch]
        mov dword [eax], edx
        imul eax, edi, byte 3Dh
        add eax, dword [byte ebp+024h]
        mov dword [byte ebp-08h], 0
        cmp byte [byte eax+03Ch], 0
        je short .3
        mov dword [byte ebp-08h], 1
.3:
        movsx eax, word [nosplit ebx*2+StatsColumnFields]
        shl eax, 3
        or dword [byte ebp-08h], eax
        lea eax, [edi+edi]
        mov dword [byte ebp-02Ch], eax
        mov eax, dword [StatTableColumns]
        inc ecx
        add eax, dword [byte ebp-02Ch]
        mov edx, dword [byte ebp-08h]
        inc edi
        mov word [eax], dx
.4:
        imul eax, ebx, dword 194Fh
        mov edx, dword [byte ebp+014h]
        add edx, eax
        movsx eax, word [dword edx+01281h]
        mov dword [byte ebp-018h], edx
        cmp ecx, eax
        jl near .2
        xor ecx, ecx
        jmp near .7
.5:
        imul eax, ebx, byte 66h
        add eax, dword [byte ebp+018h]
        add eax, byte 26h
        mov dword [byte ebp-02Ch], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
        mov edx, dword [byte ebp-02Ch]
        mov dword [eax], edx
        imul eax, ecx, byte 38h
        mov edx, dword [byte ebp-014h]
        add edx, 18A7h
        add eax, edx
        inc eax
        mov dword [byte ebp-020h], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        inc eax
        shl eax, 2
        mov dword [byte ebp-02Ch], eax
        mov eax, dword [byte esi+012h]
        add eax, dword [byte ebp-02Ch]
        mov edx, dword [byte ebp-020h]
        mov dword [eax], edx
        imul eax, edi, byte 27h
        mov edx, dword [byte ebp+01Ch]
        add edx, eax
        mov dword [byte ebp-04h], edx
        lea eax, [byte edx+01Dh]
        mov dword [byte ebp-02Ch], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        inc eax
        inc eax
        shl eax, 2
        mov dword [byte ebp-020h], eax
        mov eax, dword [byte esi+012h]
        add eax, dword [byte ebp-020h]
        mov edx, dword [byte ebp-02Ch]
        mov dword [eax], edx
        mov eax, dword [byte ebp-04h]
        add eax, byte 1Fh
        mov dword [byte ebp-020h], eax
        mov eax, dword [byte esi+08h]
        imul eax, edi
        add eax, byte 3
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
        mov edx, dword [byte ebp-020h]
        mov dword [eax], edx
        imul eax, edi, byte 3Dh
        add eax, dword [byte ebp+024h]
        mov dword [byte ebp-08h], 0
        cmp byte [byte eax+03Ch], 0
        je short .6
        mov dword [byte ebp-08h], 1
.6:
        movsx eax, word [nosplit ebx*2+StatsColumnFields]
        shl eax, 3
        or dword [byte ebp-08h], eax
        lea eax, [edi+edi]
        mov dword [byte ebp-020h], eax
        mov eax, dword [StatTableColumns]
        inc ecx
        add eax, dword [byte ebp-020h]
        mov edx, dword [byte ebp-08h]
        inc edi
        mov word [eax], dx
.7:
        imul eax, ebx, dword 194Fh
        mov edx, dword [byte ebp+014h]
        add edx, eax
        movsx eax, word [dword edx+018A5h]
        mov dword [byte ebp-014h], edx
        cmp ecx, eax
        jl near .5
        inc ebx
.8:
        mov eax, dword [byte ebp+010h]
        movsx eax, word [eax]
        cmp ebx, eax
        jl near .1
        xor ebx, ebx
        jmp near .16
.9:
        mov dword [byte ebp-010h], 0
        xor ecx, ecx
        jmp short .12
.10:
        mov eax, dword [edx]
        cmp byte [ecx+eax], 20h
        jne short .11
        inc dword [byte ebp-010h]
.11:
        inc ecx
.12:
        mov eax, ebx
        mov edx, dword [byte ebp+020h]
        shl eax, 2
        add edx, eax
        mov eax, dword [edx]
        call strlen_
        cmp ecx, eax
        jae short .13
        cmp dword [byte ebp-010h], byte 1
        jl short .10
.13:
        mov eax, ebx
        shl eax, 2
        mov edx, dword [byte ebp+020h]
        mov dword [byte ebp-020h], eax
        add edx, eax
        mov eax, dword [StatTableAlpha]
        add eax, dword [byte ebp-020h]
        mov edx, dword [edx]
        mov dword [eax], edx
        mov eax, dword [StatTableSortText]
        add eax, dword [byte ebp-020h]
        add edx, ecx
        mov dword [eax], edx
        imul eax, ebx, byte 3Dh
        add eax, dword [byte ebp+024h]
        lea edx, [byte eax+018h]
        mov dword [byte ebp-04h], edx
        mov edx, dword [byte esi+08h]
        imul edx, ebx
        add edx, byte 4
        shl edx, 2
        mov dword [byte ebp-020h], edx
        mov edx, dword [byte esi+012h]
        add edx, dword [byte ebp-020h]
        mov ecx, dword [byte ebp-04h]
        mov dword [edx], ecx
        lea edx, [byte eax+02Ah]
        mov dword [byte ebp-020h], edx
        mov edx, dword [byte esi+08h]
        imul edx, ebx
        add edx, byte 5
        mov ecx, dword [byte esi+012h]
        shl edx, 2
        add edx, ecx
        mov ecx, dword [byte ebp-020h]
        mov dword [edx], ecx
        lea edx, [byte eax+030h]
        mov dword [byte ebp-028h], edx
        mov edx, dword [byte esi+08h]
        imul edx, ebx
        add edx, byte 6
        mov ecx, dword [byte esi+012h]
        shl edx, 2
        add edx, ecx
        mov ecx, dword [byte ebp-028h]
        mov dword [edx], ecx
        lea edx, [byte eax+032h]
        mov dword [byte ebp-020h], edx
        mov edx, dword [byte esi+08h]
        imul edx, ebx
        add edx, byte 7
        mov ecx, dword [byte esi+012h]
        shl edx, 2
        add edx, ecx
        mov ecx, dword [byte ebp-020h]
        mov dword [edx], ecx
        lea ecx, [ebx+ebx]
        add ecx, dword [byte ebp+02Ch]
        cmp word [byte eax+032h], byte 0
        je short .14
        movsx edx, word [byte eax+034h]
        imul edx, dword 3E8h
        movsx eax, word [byte eax+032h]
        mov dword [byte ebp-020h], eax
        mov eax, edx
        cdq
        idiv dword [byte ebp-020h]
        mov word [ecx], ax
        jmp short .15
.14:
        mov word [ecx], 0
.15:
        mov edx, dword [byte ebp+02Ch]
        lea eax, [ebx+ebx]
        add edx, eax
        mov eax, dword [byte esi+08h]
        imul eax, ebx
        add eax, byte 8
        mov ecx, dword [byte esi+012h]
        shl eax, 2
        add eax, ecx
        mov dword [eax], edx
        imul eax, ebx, byte 3Dh
        mov edx, dword [byte esi+08h]
        imul edx, ebx
        add edx, byte 9
        shl edx, 2
        mov dword [byte ebp-020h], edx
        mov edx, dword [byte esi+012h]
        add eax, dword [byte ebp+024h]
        add edx, dword [byte ebp-020h]
        lea ecx, [byte eax+02Eh]
        mov dword [edx], ecx
        lea edx, [byte eax+020h]
        mov dword [byte ebp-04h], edx
        mov edx, dword [byte esi+08h]
        imul edx, ebx
        add edx, byte 0Ah
        shl edx, 2
        mov dword [byte ebp-020h], edx
        mov edx, dword [byte esi+012h]
        add edx, dword [byte ebp-020h]
        mov ecx, dword [byte ebp-04h]
        mov dword [edx], ecx
        lea edx, [byte eax+028h]
        mov dword [byte ebp-024h], edx
        mov edx, dword [byte esi+08h]
        imul edx, ebx
        add edx, byte 0Bh
        mov ecx, dword [byte esi+012h]
        shl edx, 2
        add edx, ecx
        mov ecx, dword [byte ebp-024h]
        mov dword [edx], ecx
        lea edx, [byte eax+022h]
        mov dword [byte ebp-020h], edx
        mov edx, dword [byte esi+08h]
        imul edx, ebx
        add edx, byte 0Ch
        shl edx, 2
        mov dword [byte ebp-04h], edx
        mov edx, dword [byte esi+012h]
        add edx, dword [byte ebp-04h]
        mov ecx, dword [byte ebp-020h]
        mov dword [edx], ecx
        lea edx, [byte eax+024h]
        mov dword [byte ebp-04h], edx
        mov edx, dword [byte esi+08h]
        imul edx, ebx
        add edx, byte 0Dh
        mov ecx, dword [byte esi+012h]
        shl edx, 2
        add edx, ecx
        mov ecx, dword [byte ebp-04h]
        mov dword [edx], ecx
        lea edx, [byte eax+026h]
        mov eax, dword [byte esi+08h]
        imul eax, ebx
        add eax, byte 0Eh
        mov ecx, dword [byte esi+012h]
        shl eax, 2
        add eax, ecx
        inc ebx
        mov dword [eax], edx
.16:
        cmp ebx, edi
        jl near .9
        mov eax, 15Ah
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        mov byte [eax], 8
        mov eax, dword [byte esi+027h]
        mov dword [eax], edx
        mov eax, 0BAh
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        inc eax
        mov byte [eax], 5
        mov eax, dword [byte esi+027h]
        add eax, byte 4
        mov dword [eax], edx
        mov eax, 0F2h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        inc eax
        inc eax
        mov byte [eax], 7
        mov eax, dword [byte esi+027h]
        add eax, byte 8
        mov dword [eax], edx
        mov eax, 15Bh
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 3
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 0Ch
        mov dword [eax], edx
        mov eax, 140h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 4
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 10h
        mov dword [eax], edx
        mov eax, 147h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 5
        mov byte [eax], 0Dh
        mov eax, dword [byte esi+027h]
        add eax, byte 14h
        mov dword [eax], edx
        mov eax, 6Eh
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 6
        mov byte [eax], 0Ah
        mov eax, dword [byte esi+027h]
        add eax, byte 18h
        mov dword [eax], edx
        mov eax, 12Bh
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 7
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 1Ch
        mov dword [eax], edx
        mov eax, 15Ch
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 8
        mov byte [eax], 6
        mov eax, dword [byte esi+027h]
        add eax, byte 20h
        mov dword [eax], edx
        mov eax, 148h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 9
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 24h
        mov dword [eax], edx
        mov eax, 149h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 0Ah
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 28h
        mov dword [eax], edx
        mov eax, 14Ah
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 0Bh
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 2Ch
        mov dword [eax], edx
        mov eax, 141h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 0Ch
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 30h
        mov dword [eax], edx
        mov eax, 142h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 0Dh
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 34h
        mov dword [eax], edx
        mov eax, 143h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 0Eh
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 38h
        xor ebx, ebx
        mov dword [eax], edx
.17:
        mov eax, dword [byte ebp+030h]
        mov edx, ebx
        mov dword [eax+edx*4], 0
        mov eax, dword [byte ebp+034h]
        xor ecx, ecx
        mov dword [eax+edx*4], 0
        jmp near .32
.18:
        mov eax, dword [byte esi+0Eh]
        mov al, byte [ebx+eax]
        cmp al, 6
        jb short .20
        cmp al, 7
        jbe short .23
        cmp al, 0Ah
        jb short .19
        jbe short .21
        cmp al, 0Dh
        je short .25
        jmp near .28
.19:
        cmp al, 9
        je near .26
        jmp near .28
.20:
        cmp al, 4
        jb near .28
        jbe short .23
        jmp short .24
.21:
        mov eax, dword [byte esi+08h]
        imul eax, ecx
        add eax, ebx
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
.22:
        mov eax, dword [eax]
        movsx eax, word [eax]
        jmp short .27
.23:
        mov eax, dword [byte esi+08h]
        imul eax, ecx
        add eax, ebx
        shl eax, 2
        mov dword [byte ebp-04h], eax
        mov eax, dword [byte esi+012h]
        add eax, dword [byte ebp-04h]
        jmp short .22
.24:
        mov eax, dword [byte esi+08h]
        imul eax, ecx
        add eax, ebx
        shl eax, 2
        mov dword [byte ebp-04h], eax
        mov eax, dword [byte esi+012h]
        add eax, dword [byte ebp-04h]
        mov eax, dword [eax]
        movzx eax, byte [eax]
        jmp short .27
.25:
        mov eax, dword [byte esi+08h]
        imul eax, ecx
        add eax, ebx
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
        mov eax, dword [eax]
        mov dword [byte ebp-04h], 3Ch
        mov eax, dword [eax]
        cdq
        idiv dword [byte ebp-04h]
        jmp short .27
.26:
        mov eax, dword [byte esi+08h]
        imul eax, ecx
        add eax, ebx
        mov edx, dword [byte esi+012h]
        shl eax, 2
        add eax, edx
        mov eax, dword [eax]
        movzx eax, word [eax]
.27:
        mov dword [byte ebp-0Ch], eax
.28:
        mov eax, ebx
        shl eax, 2
        mov dword [byte ebp-01Ch], eax
        mov eax, dword [byte ebp+030h]
        mov edx, dword [byte esi+0Eh]
        add eax, dword [byte ebp-01Ch]
        cmp byte [edx+ebx], 0Ah
        je short .29
        imul edx, dword [byte ebp-0Ch], byte 64h
        jmp short .30
.29:
        mov edx, dword [byte ebp-0Ch]
.30:
        add dword [eax], edx
        mov eax, ebx
        shl eax, 2
        add eax, dword [byte ebp+034h]
        mov edx, dword [byte ebp-0Ch]
        cmp edx, dword [eax]
        jle short .31
        mov dword [eax], edx
.31:
        inc ecx
.32:
        cmp ecx, edi
        jl near .18
        mov ecx, ebx
        shl ecx, 2
        add ecx, dword [byte ebp+030h]
        mov eax, dword [ecx]
        cdq
        idiv edi
        inc ebx
        mov dword [ecx], eax
        cmp ebx, byte 0Fh
        jl near .17
        leave
        pop edi
        pop esi
        ret 28h
;-----------------------------------------------------------------------------
; SetTeamStatColumns                              B1922  97 PC, low confidence
; Stats lists: the team column titles (GP, W, L, T, points, GF, GA, PPG, PP%,
; PK%, streaks...)
;-----------------------------------------------------------------------------
SetTeamStatColumns:
        push esi
        push edi
        enter 18h, 0
        mov esi, eax
        mov dword [byte ebp-08h], edx
        mov dword [byte ebp-04h], ebx
        push dword [byte ebp+014h]
        push byte 14h
        push byte 32h
        push byte 78h
        push dword 96h
        push byte 32h
        push dword [byte ebp+010h]
        push ecx
        mov ebx, 12h
        push byte 8
        mov edx, dword [byte ebp+018h]
        mov ecx, 0Ah
        call AllocStatTable
        xor eax, eax
        jmp near .7
.1:
        imul edx, eax, byte 66h
        add edx, dword [byte ebp-04h]
        lea ecx, [byte edx+03Eh]
        mov ebx, dword [StatTableAlpha]
        mov edx, eax
        mov dword [ebx+edx*4], ecx
        mov ebx, dword [StatTableSortText]
        mov dword [ebx+edx*4], ecx
        imul edx, eax, dword 194Fh
        mov ebx, dword [byte esi+08h]
        imul ebx, eax
        shl ebx, 2
        mov dword [byte ebp-014h], ebx
        mov ebx, dword [byte esi+012h]
        add edx, dword [byte ebp-08h]
        add ebx, dword [byte ebp-014h]
        lea ecx, [byte edx+04Eh]
        mov dword [ebx], ecx
        lea ebx, [byte edx+050h]
        mov dword [byte ebp-014h], ebx
        mov ebx, dword [byte esi+08h]
        imul ebx, eax
        inc ebx
        mov ecx, dword [byte esi+012h]
        shl ebx, 2
        add ebx, ecx
        mov ecx, dword [byte ebp-014h]
        mov dword [ebx], ecx
        mov ebx, dword [byte esi+08h]
        imul ebx, eax
        inc ebx
        inc ebx
        shl ebx, 2
        mov dword [byte ebp-014h], ebx
        mov ebx, dword [byte esi+012h]
        add ebx, dword [byte ebp-014h]
        lea ecx, [byte edx+051h]
        mov dword [ebx], ecx
        lea ebx, [byte edx+052h]
        mov dword [byte ebp-014h], ebx
        mov ebx, dword [byte esi+08h]
        imul ebx, eax
        add ebx, byte 3
        mov ecx, dword [byte esi+012h]
        shl ebx, 2
        add ebx, ecx
        mov ecx, dword [byte ebp-014h]
        mov dword [ebx], ecx
        mov ecx, dword [byte ebp+01Ch]
        lea ebx, [eax+eax]
        add ecx, ebx
        mov dword [byte ebp-014h], ecx
        mov ecx, dword [byte esi+08h]
        imul ecx, eax
        add ecx, byte 4
        mov edi, dword [byte esi+012h]
        shl ecx, 2
        add ecx, edi
        mov edi, dword [byte ebp-014h]
        mov dword [ecx], edi
        lea ecx, [byte edx+063h]
        mov dword [byte ebp-014h], ecx
        mov ecx, dword [byte esi+08h]
        imul ecx, eax
        add ecx, byte 5
        mov edi, dword [byte esi+012h]
        shl ecx, 2
        add ecx, edi
        mov edi, dword [byte ebp-014h]
        mov dword [ecx], edi
        lea ecx, [byte edx+065h]
        mov edi, dword [byte esi+08h]
        imul edi, eax
        add edi, byte 6
        shl edi, 2
        mov dword [byte ebp-014h], edi
        mov edi, dword [byte esi+012h]
        add edi, dword [byte ebp-014h]
        mov dword [edi], ecx
        mov ecx, dword [byte esi+08h]
        imul ecx, eax
        add ecx, byte 7
        shl ecx, 2
        mov dword [byte ebp-014h], ecx
        mov ecx, dword [byte esi+012h]
        add ecx, dword [byte ebp-014h]
        lea edi, [byte edx+06Fh]
        mov dword [ecx], edi
        mov ecx, dword [byte esi+08h]
        imul ecx, eax
        add ecx, byte 8
        shl ecx, 2
        mov dword [byte ebp-014h], ecx
        mov ecx, dword [byte esi+012h]
        add ecx, dword [byte ebp-014h]
        lea edi, [byte edx+06Dh]
        mov dword [ecx], edi
        mov ecx, dword [byte ebp+020h]
        add ecx, ebx
        mov dword [byte ebp-014h], ecx
        mov ecx, dword [byte esi+08h]
        imul ecx, eax
        add ecx, byte 9
        mov edi, dword [byte esi+012h]
        shl ecx, 2
        add ecx, edi
        mov edi, dword [byte ebp-014h]
        mov dword [ecx], edi
        lea ecx, [byte edx+069h]
        mov dword [byte ebp-018h], ecx
        mov ecx, dword [byte esi+08h]
        imul ecx, eax
        add ecx, byte 0Ah
        mov edi, dword [byte esi+012h]
        shl ecx, 2
        add ecx, edi
        mov edi, dword [byte ebp-018h]
        mov dword [ecx], edi
        lea ecx, [byte edx+06Bh]
        mov dword [byte ebp-014h], ecx
        mov ecx, dword [byte esi+08h]
        imul ecx, eax
        add ecx, byte 0Bh
        mov edi, dword [byte esi+012h]
        shl ecx, 2
        add ecx, edi
        mov edi, dword [byte ebp-014h]
        mov dword [ecx], edi
        lea ecx, [byte edx+067h]
        mov dword [byte ebp-010h], ecx
        mov ecx, dword [byte esi+08h]
        imul ecx, eax
        add ecx, byte 0Ch
        shl ecx, 2
        mov dword [byte ebp-014h], ecx
        mov ecx, dword [byte esi+012h]
        add ecx, dword [byte ebp-014h]
        mov edi, dword [byte ebp-010h]
        mov dword [ecx], edi
        mov ecx, dword [byte ebp+024h]
        add ecx, ebx
        mov dword [byte ebp-014h], ecx
        mov ecx, dword [byte esi+08h]
        imul ecx, eax
        add ecx, byte 0Dh
        mov edi, dword [byte esi+012h]
        shl ecx, 2
        add ecx, edi
        mov edi, dword [byte ebp-014h]
        mov dword [ecx], edi
        lea ecx, [byte edx+079h]
        mov dword [byte ebp-0Ch], ecx
        mov ecx, dword [byte esi+08h]
        imul ecx, eax
        add ecx, byte 0Eh
        mov edi, dword [byte esi+012h]
        shl ecx, 2
        add ecx, edi
        mov edi, dword [byte ebp-0Ch]
        mov dword [ecx], edi
        lea ecx, [byte edx+07Dh]
        mov dword [byte ebp-014h], ecx
        mov ecx, dword [byte esi+08h]
        imul ecx, eax
        add ecx, byte 0Fh
        shl ecx, 2
        mov dword [byte ebp-010h], ecx
        mov ecx, dword [byte esi+012h]
        add ecx, dword [byte ebp-010h]
        mov edi, dword [byte ebp-014h]
        mov dword [ecx], edi
        lea ecx, [dword edx+081h]
        mov dword [byte ebp-010h], ecx
        mov ecx, dword [byte esi+08h]
        imul ecx, eax
        add ecx, byte 10h
        mov edi, dword [byte esi+012h]
        shl ecx, 2
        add ecx, edi
        mov edi, dword [byte ebp-010h]
        mov dword [ecx], edi
        mov ecx, dword [byte esi+08h]
        imul ecx, eax
        add ecx, byte 11h
        shl ecx, 2
        mov dword [byte ebp-010h], ecx
        mov ecx, dword [byte esi+012h]
        add ecx, dword [byte ebp-010h]
        lea edi, [dword edx+085h]
        mov dword [ecx], edi
        movsx edx, word [dword edx+0D07h]
        mov edx, dword [nosplit edx*4+StandingsColumns]
        cmp edx, byte 2
        jb short .2
        jbe short .3
        cmp edx, byte 4
        jb short .6
        jbe short .5
        cmp edx, byte 8
        je short .4
        jmp short .6
.2:
        cmp edx, byte 1
        jne short .6
        mov edx, dword [StatTableColumns]
        mov word [edx+ebx], 15h
        jmp short .6
.3:
        mov edx, dword [StatTableColumns]
        mov word [edx+ebx], 16h
        jmp short .6
.4:
        mov edx, dword [StatTableColumns]
        mov word [edx+ebx], 19h
        jmp short .6
.5:
        mov edx, dword [StatTableColumns]
        mov word [edx+ebx], 1Ah
.6:
        inc eax
.7:
        cmp eax, dword [byte ebp+018h]
        jl near .1
        mov eax, 140h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        mov dword [eax], edx
        mov eax, 14Bh
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        inc eax
        mov byte [eax], 5
        mov eax, dword [byte esi+027h]
        add eax, byte 4
        mov dword [eax], edx
        mov eax, 14Ch
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        inc eax
        inc eax
        mov byte [eax], 5
        mov eax, dword [byte esi+027h]
        add eax, byte 8
        mov dword [eax], edx
        mov eax, 14Dh
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 3
        mov byte [eax], 5
        mov eax, dword [byte esi+027h]
        add eax, byte 0Ch
        mov dword [eax], edx
        mov eax, 6Dh
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 4
        mov byte [eax], 5
        mov eax, dword [byte esi+027h]
        add eax, byte 10h
        mov dword [eax], edx
        mov eax, 14Eh
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 5
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 14h
        mov dword [eax], edx
        mov eax, 148h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 6
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 18h
        mov dword [eax], edx
        mov eax, 14Fh
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 7
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 1Ch
        mov dword [eax], edx
        mov eax, 150h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 8
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 20h
        mov dword [eax], edx
        mov eax, 151h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 9
        mov byte [eax], 6
        mov eax, dword [byte esi+027h]
        add eax, byte 24h
        mov dword [eax], edx
        mov eax, 146h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 0Ah
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 28h
        mov dword [eax], edx
        mov eax, 264h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 0Bh
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 2Ch
        mov dword [eax], edx
        mov eax, 153h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 0Ch
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 30h
        mov dword [eax], edx
        mov eax, 154h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 0Dh
        mov byte [eax], 6
        mov eax, dword [byte esi+027h]
        add eax, byte 34h
        mov dword [eax], edx
        mov eax, 155h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 0Eh
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 38h
        mov dword [eax], edx
        mov eax, 156h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 0Fh
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 3Ch
        mov dword [eax], edx
        mov eax, 157h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 10h
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 40h
        mov dword [eax], edx
        mov eax, 158h
        call GetLangText
        mov edx, eax
        mov eax, dword [byte esi+0Eh]
        add eax, byte 11h
        mov byte [eax], 4
        mov eax, dword [byte esi+027h]
        add eax, byte 44h
        mov dword [eax], edx
        leave
        pop edi
        pop esi
        ret 1Ch
UserRecordScaleSteps:                           ; used by UpdateUserRecords
        db 00h,00h,02h,00h,00h,00h,03h,00h,00h,00h,04h,00h
UserRecordScaleHalf:                            ; used by UpdateUserRecords
        db 00h,00h,01h,00h,00h,080h,01h,00h,00h,00h,00h,00h
UserRecordScalePair:                            ; used by UpdateUserRecords
        db 00h,00h,01h,00h,00h,080h,01h,00h
UserRecordScaleQuarter:                         ; used by UpdateUserRecords
        db 00h,00h,01h,00h,00h,040h,01h,00h,00h,080h,01h,00h
