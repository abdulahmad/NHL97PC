; The stats menu.
bits 32
%include "hockey.inc"
section s_85CFD progbits alloc exec nowrite align=1
extern BlitConverted, BlitShape2, ClearLinkAbort, ConvertArtXY, CreateBitmap, DosFileInfo, DrawEntryRow, DrawShadowBox
extern DrawStatTable, FindGameRecord, FindShape, FreeBitmap, FreeDbBlock, FreeMemBlock, FrontEndExit, FrontMusicOn
extern FrontShapeFile, GameRecordIds, GameSettings, GetLangText, HistoryScreen, InitMenuItems, LinkGameActive, LinkReceiveBlock
extern LinkSendBlock, LoadDataFile, OpenLeagueFile, PlayerRatingsScreen, PlayerStatsScreen, PlaySfx, PresentScreen, RestoreMenuView
extern RunMenu, RunUserRecords, RunVideoOptions, ScreenTitleItem, SeasonDbKey, SecondsToSamples, SetDrawTarget, SetScreenTarget
extern SetupMenuView, ShowMessageBox, sprintf_, StatsMenuChoice, StatsMenuDrawn, StatsMenuMode, StatsTablesScreen, str_BACK4
extern str_DATAREPLAYNDX, str_GL00, str_GR00, str_Mous3, str_SY00, str_SY01, str_SY02, str_SY02d
extern str_SY03, str_SY04, str_SY05, str_SY06, TeamStatsScreen, WaitSoundTime
global RunStatsMenuJumpTable, RunStatsMenu, RunStatsMenu_6E, RunStatsMenu_82, RunStatsMenu_9E, RunStatsMenu_A5, RunStatsMenu_AC, RunStatsMenu_B3
global RunStatsMenu_BA, RunStatsMenu_C1, StatsMenuScreen
RunStatsMenuJumpTable:                          ; jump table for the switch cases of RunStatsMenu
        dd RunStatsMenu_6E
        dd RunStatsMenu_82
        dd RunStatsMenu_A5
        dd RunStatsMenu_BA
        dd RunStatsMenu_AC
        dd RunStatsMenu_C1
        dd RunStatsMenu_B3
        dd RunStatsMenu_9E
;-----------------------------------------------------------------------------
; RunStatsMenu                                 85D1D  96 PC, medium confidence
; From the main menu, the season menus and the play-offs: runs the team stats
; and player stats screens, frees their tables after
;-----------------------------------------------------------------------------
RunStatsMenu:
        push ebx
        push ecx
        push edx
        push esi
        enter 1954h, 0
        mov ebx, 64h
        mov byte [StatsMenuDrawn], 1
        mov esi, 1Ah
        cmp byte [FrontEndExit], 0
        je short RunStatsMenu_82.4
        lea edx, [byte ebp-04h]
        mov eax, SeasonDbKey
        call OpenLeagueFile
        xor ecx, ecx
.1:
        mov edx, ecx
        mov eax, dword [byte ebp-04h]
        shl edx, 3
        mov eax, dword [byte eax+01Ch]
        add eax, edx
        lea edx, [dword ebp-01954h]
        inc ecx
        call FindGameRecord
        movsx edx, word [dword ebp-0C4Dh]
        mov dword [nosplit ecx*4+GameRecordIds], edx
        cmp ecx, byte 10h
        jl short .1
        lea eax, [byte ebp-04h]
        call FreeDbBlock
        and byte [GameSettings], 8Fh
        jmp short RunStatsMenu_82.4
RunStatsMenu_6E:
        call StatsMenuScreen
        mov ebx, eax
        cmp eax, byte 1Ah
        jne short .2
        mov ebx, esi
        jmp short RunStatsMenu_82.4
.2:
        mov esi, eax
        jmp short RunStatsMenu_82.4
RunStatsMenu_82:
        call TeamStatsScreen
.3:
        mov ebx, eax
.4:
        cmp ebx, byte 1Ah
        je short RunStatsMenu_C1.5
        lea eax, [byte ebx-064h]
        cmp eax, byte 7
        ja short .4
        jmp dword [nosplit cs:eax*4+RunStatsMenuJumpTable]
RunStatsMenu_9E:
        call StatsTablesScreen
        jmp short RunStatsMenu_82.3
RunStatsMenu_A5:
        call HistoryScreen
        jmp short RunStatsMenu_82.3
RunStatsMenu_AC:
        call PlayerStatsScreen
        jmp short RunStatsMenu_82.3
RunStatsMenu_B3:
        call RunVideoOptions
        jmp short RunStatsMenu_82.3
RunStatsMenu_BA:
        call RunUserRecords
        jmp short RunStatsMenu_82.3
RunStatsMenu_C1:
        movzx ebx, byte [FrontEndExit]
        xor edx, edx
        xor eax, eax
        call PlayerRatingsScreen
        jmp short RunStatsMenu_82.3
.5:
        cmp dword [StatsMenuMode], byte 0
        je short .6
        push dword [StatsMenuMode]
        call FreeBitmap
        mov dword [StatsMenuMode], 0
        add esp, byte 4
.6:
        mov byte [StatsMenuDrawn], 0
        leave
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; StatsMenuScreen                                 85E1E  97 PC, low confidence
; Runs the stats menu screen
;-----------------------------------------------------------------------------
StatsMenuScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 494h, 0
        sub ebp, 82h
        lea edx, [dword ebp-0412h]
        mov eax, 9
        call InitMenuItems
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 24h
        call LoadDataFile
        mov dword [byte ebp+06Eh], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 25h
        call LoadDataFile
        mov ebx, eax
        mov dword [byte ebp+072h], eax
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push str_BACK4
        push ebx
        call FindShape
        mov edx, 1E0h
        mov esi, eax
        add esp, byte 8
        mov dword [byte ebp+06Ah], eax
        movsx eax, word [byte eax+06h]
        push byte 0
        sub edx, eax
        push edx
        push dword 280h
        call CreateBitmap
        add esp, byte 0Ch
        mov ebx, eax
        mov dword [byte ebp+066h], eax
        call SetScreenTarget
        movsx eax, word [byte esi+06h]
        push eax
        push byte 0
        push dword [byte ebx+02Ch]
        call ConvertArtXY
        add esp, byte 0Ch
        call PresentScreen
        mov edx, 1E0h
        movsx eax, word [byte esi+06h]
        sub edx, eax
        push edx
        xor ecx, ecx
        mov eax, dword [byte ebx+02Ch]
        push dword 280h
        mov edx, 10h
        xor ebx, ebx
        mov dword [byte ebp+076h], 0FFFFFFFFh
        call DrawShadowBox
        cmp dword [StatsMenuMode], byte 0
        jne short .1
        push byte 0
        movsx eax, word [byte esi+06h]
        push eax
        push dword 280h
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [StatsMenuMode], eax
        call SetDrawTarget
        add esp, byte 4
        push esi
        call BlitShape2
        jmp short .2
.1:
        push dword [StatsMenuMode]
        call SetDrawTarget
.2:
        add esp, byte 4
        xor ebx, ebx
.3:
        push ebx
        push str_SY02d
        lea eax, [byte ebp+05Ah]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+05Ah]
        push eax
        push dword [byte ebp+072h]
        call FindShape
        add esp, byte 8
        mov esi, eax
        push byte 0
        movsx eax, word [byte eax+06h]
        push eax
        movsx eax, word [byte esi+04h]
        push eax
        call CreateBitmap
        mov dword [byte ebp+ebx*4+03Eh], eax
        add esp, byte 0Ch
        movsx edx, word [byte esi+0Eh]
        push edx
        movsx edx, word [byte esi+0Ch]
        push edx
        push dword [byte eax+02Ch]
        inc ebx
        call ConvertArtXY
        add esp, byte 0Ch
        cmp ebx, byte 7
        jl short .3
        mov ecx, 8
        mov ebx, 0Ah
        mov edx, 41h
        mov eax, dword [byte ebp+06Ah]
        lea edi, [dword ebp-0412h]
        mov esi, ScreenTitleItem
        call DrawEntryRow
        mov ecx, 52h
        lea eax, [dword ebp-0182h]
        mov edx, dword [byte ebp+072h]
        push eax
        rep movsb
        push str_SY00
        mov ecx, str_SY00
        lea eax, [dword ebp-03C0h]
        mov ebx, ecx
        mov dword [dword ebp-0412h], 0
        call DrawStatTable
        lea eax, [dword ebp-0142h]
        push eax
        mov ecx, str_SY01
        mov edx, dword [byte ebp+072h]
        push str_SY01
        mov ebx, ecx
        lea eax, [dword ebp-036Eh]
        call DrawStatTable
        lea eax, [dword ebp-0102h]
        push eax
        mov ecx, str_SY02
        mov edx, dword [byte ebp+072h]
        push str_SY02
        mov ebx, ecx
        lea eax, [dword ebp-031Ch]
        call DrawStatTable
        lea eax, [dword ebp-0C2h]
        push eax
        mov ecx, str_SY03
        mov edx, dword [byte ebp+072h]
        push str_SY03
        mov ebx, ecx
        lea eax, [dword ebp-02CAh]
        call DrawStatTable
        lea eax, [dword ebp-082h]
        push eax
        mov ecx, str_SY04
        mov edx, dword [byte ebp+072h]
        push str_SY04
        mov ebx, ecx
        lea eax, [dword ebp-0278h]
        call DrawStatTable
        lea eax, [byte ebp-042h]
        push eax
        mov ecx, str_SY05
        mov edx, dword [byte ebp+072h]
        push str_SY05
        mov ebx, ecx
        lea eax, [dword ebp-0226h]
        call DrawStatTable
        lea eax, [byte ebp-02h]
        push eax
        mov ecx, str_SY06
        mov edx, dword [byte ebp+072h]
        push str_SY06
        mov ebx, ecx
        lea eax, [dword ebp-01D4h]
        call DrawStatTable
        xor ebx, ebx
.4:
        lea esi, [byte ebx+01h]
        imul eax, esi, byte 52h
        mov edx, dword [byte ebp+ebx*4+03Eh]
        mov edx, dword [byte edx+02Ch]
        mov ebx, esi
        mov dword [dword eax+ebp-03F8h], edx
        cmp esi, byte 7
        jl short .4
        call SetScreenTarget
        push dword [byte ebp+06Ah]
        call BlitShape2
        mov eax, dword [byte ebp+06Ah]
        add esp, byte 4
        movsx eax, word [byte eax+06h]
        push eax
        push byte 0
        mov eax, dword [byte ebp+066h]
        push dword [byte eax+02Ch]
        call BlitConverted
        add esp, byte 0Ch
        push str_GL00
        push dword [byte ebp+06Eh]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        push str_GR00
        push dword [byte ebp+06Eh]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        call PresentScreen
        push dword [byte ebp+066h]
        call FreeBitmap
        add esp, byte 4
.5:
        cmp dword [byte ebp+076h], byte 0FFFFFFFFh
        jne near .14
        push str_Mous3
        push dword [FrontShapeFile]
        call FindShape
        movsx edx, word [byte eax+06h]
        mov eax, dword [StatsMenuMode]
        mov eax, dword [byte eax+04h]
        add esp, byte 8
        sub eax, edx
        push eax
        push str_Mous3
        push dword [FrontShapeFile]
        xor ebx, ebx
        call FindShape
        movsx ecx, word [byte eax+04h]
        mov eax, 280h
        add esp, byte 8
        sub eax, ecx
        xor edx, edx
        mov ecx, eax
        xor eax, eax
        call SetupMenuView
        push byte 3
        lea eax, [byte ebp+062h]
        mov ebx, 0FFFFFFFFh
        lea edx, [dword ebp-0412h]
        push eax
        xor ecx, ecx
        mov eax, 8
        call RunMenu
        mov byte [StatsMenuChoice], al
        call RestoreMenuView
        cmp dword [byte ebp+062h], byte 0
        jne short .6
        mov dword [byte ebp+076h], 1Ah
        jmp short .7
.6:
        mov eax, dword [byte ebp+062h]
        add eax, byte 64h
        mov dword [byte ebp+076h], eax
.7:
        push str_DATAREPLAYNDX
        call DosFileInfo
        add esp, byte 4
        test eax, eax
        je short .8
        mov byte [byte ebp+07Eh], 59h
        jmp short .9
.8:
        mov byte [byte ebp+07Eh], 4Eh
.9:
        cmp dword [LinkGameActive], byte 0
        je short .11
        call ClearLinkAbort
        test eax, eax
        je short .10
        mov edx, 1
        lea eax, [byte ebp+07Eh]
        xor ebx, ebx
        call LinkSendBlock
        mov edx, 1
        lea eax, [byte ebp+07Ah]
        xor ebx, ebx
        call LinkReceiveBlock
        jmp short .12
.10:
        mov edx, 1
        lea eax, [byte ebp+07Ah]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 1
        lea eax, [byte ebp+07Eh]
        xor ebx, ebx
        call LinkSendBlock
        jmp short .12
.11:
        mov byte [byte ebp+07Ah], 4Eh
.12:
        cmp dword [byte ebp+076h], byte 6Ah
        jne short .13
        cmp byte [byte ebp+07Eh], 4Eh
        jne short .13
        cmp byte [byte ebp+07Ah], 4Eh
        jne short .13
        push byte 1
        mov eax, 257h
        mov edx, 1
        mov dword [byte ebp+076h], 0FFFFFFFFh
        xor ecx, ecx
        xor ebx, ebx
        call GetLangText
        call ShowMessageBox
.13:
        cmp dword [byte ebp+076h], byte 6Ah
        jne near .5
        cmp dword [LinkGameActive], byte 0
        je near .5
        mov eax, 304h
        mov dword [byte ebp+076h], 0FFFFFFFFh
        call PlaySfx
        jmp near .5
.14:
        push dword [byte ebp+072h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+06Eh]
        xor ebx, ebx
        call FreeMemBlock
        add esp, byte 4
.15:
        push dword [byte ebp+ebx*4+03Eh]
        call FreeBitmap
        inc ebx
        add esp, byte 4
        cmp ebx, byte 7
        jl short .15
        cmp byte [FrontMusicOn], 0
        je short .16
        push dword [StatsMenuMode]
        call FreeBitmap
        mov dword [StatsMenuMode], 0
        add esp, byte 4
.16:
        mov eax, dword [byte ebp+076h]
        lea esp, [dword ebp+082h]
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
