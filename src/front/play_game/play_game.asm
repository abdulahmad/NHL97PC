; Playing a menu game: logos, results and finishing a league game.
bits 32
%include "hockey.inc"
section s_AADEF progbits alloc exec nowrite align=1
extern AddReplayIndexEntry, AllocCrusherBuffers, AllocMemBlock, AllStarDay, AppendToTransfer, AwayUserSlot, bcopy, CheckLeagueInjuries
extern ClearLinkAbort, ClearScreen, ClockFontLarge, ClockFontSmall, ControlSetup, ConvertArtNew, CopyControlSettings, CopyToTransfer
extern CreateBitmap, CreateExhibitionFile, DaysToYear, DbKeyBuffer, DrawShapeBlended, FindGameRecord, FindReplayIndexEntry, FindShape
extern FreeBitmap, FreeFrontEnd, FreeLangText, FreeMemBlock, FreeTransferBuffers, GameLogoBitmap, GameLogoShape, gameopts
extern GameSettings, GetLangText, HideWorkingBox, HomeUserSlot, InIntermission, InitFrontEnd, InitGameAudio, InitGameSounds
extern KeyboardControls, KeysEqual, LinesChangedInGame, LinkGameActive, LinkReceiveBlock, LinkReceiveData, LinkSendBlock, LinkSendData
extern LinkSyncMenu, LoadDataFileLib, LoadFileAlloc, LoadLangTextB, memcmp_, memcpy_, OpenDataLibrary, OpenReplayFile
extern PanelArtLarge, PanelArtSmall, PeriodHomeTeam, PlayGame, PlayMenuGameFlag, PlayoffColumns, PlayoffGameCount, PlayoffOpponents
extern PlayoffPairings, PlayoffRandomSeed, PlayoffRound, PlayoffRoundBits, PlayoffRoundGames, PlayoffRounds, PlayoffRoundSlots, PlayoffSettingsPath
extern PlayoffStarted, PlayoffTeamNames, PlayoffTeams, PlayoffUserActive, PlayoffUserIndex, PlayoffUserRecords, PlayoffUserReplay, PlayoffWinsNeeded
extern SaveExhibitionResult, SaveReplayFile, SaveSeasonResult, SeasonActive, SeasonDefaultUser, SeasonFileName, SeasonRandomSeed, SeasonSettingsPath
extern SeasonStatsPath, SeasonUserActive, SeasonUserRecords, SeasonUserReplay, SeasonUserTeam, SecondsToSamples, SelectFont, SetDrawTarget
extern ShowLoadingBar, ShowLoadingScreen, ShowWorkingBox, SimulateGame, SortStandings, sprintf_, StartSeasonGame, str_DEBUG
extern str_Gdata, str_Logo02dQfs2, str_LOGO5, str_Replaybuf2, str_Ros2, str_UnpackLogo, str_Xferdata, UnpackedSize
extern UnpackShared, UpdateGameRecord, UpdateTeamLines, UpdateWorkingBox, ViewScreenHeight, WaitSoundTime, WriteLeagueHeader
global LoadGameLogos, FreeGameText, PlayMenuGame, SendGameResult, SendGameResult_32D, SaveGameResults, SaveGameResults_B2F, SaveGameResults_B30
global AdvanceSeasonDate, FinishLeagueGame
;-----------------------------------------------------------------------------
; LoadGameLogos                                   AADEF  97 PC, low confidence
; From PlayGame: the in-game language text (LoadLangTextB) and the team logos
; "logo%02d.qfs"
;-----------------------------------------------------------------------------
LoadGameLogos:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 20h, 0
        mov eax, dword [GameSettings]
        shl eax, 1Ch
        shr eax, 1Eh
        xor edx, edx
        call LoadLangTextB
        mov eax, 2Fh
        call LoadDataFileLib
        mov dword [ClockFontLarge], eax
        xor edx, edx
        mov eax, 0D4h
        call LoadDataFileLib
        mov dword [ClockFontSmall], eax
        cmp dword [ViewScreenHeight], 12Ch
        jge short .1
        push eax
        jmp short .2
.1:
        push dword [ClockFontLarge]
.2:
        call SelectFont
        add esp, byte 4
        mov eax, 32h
        call OpenDataLibrary
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        mov eax, dword [gameopts]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        push eax
        push str_Logo02dQfs2
        lea eax, [byte ebp-020h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        push byte 0
        lea eax, [byte ebp-020h]
        push eax
        call LoadFileAlloc
        add esp, byte 8
        push byte 0
        push eax
        mov esi, eax
        call UnpackedSize
        add esp, byte 4
        push eax
        push str_UnpackLogo
        call AllocMemBlock
        add esp, byte 0Ch
        push eax
        push esi
        mov ebx, eax
        call UnpackShared
        add esp, byte 8
        push byte 0
        push str_LOGO5
        push ebx
        call FindShape
        add esp, byte 8
        movsx edx, word [byte eax+06h]
        mov eax, 8000h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        push eax
        push str_LOGO5
        push ebx
        call FindShape
        add esp, byte 8
        movsx edx, word [byte eax+04h]
        mov eax, 8000h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push byte 10h
        push str_LOGO5
        push ebx
        mov dword [GameLogoShape], eax
        call FindShape
        add esp, byte 8
        push eax
        call ConvertArtNew
        mov edi, eax
        add esp, byte 8
        push dword [GameLogoShape]
        call SetDrawTarget
        add esp, byte 4
        push dword 0FFh
        call ClearScreen
        add esp, byte 4
        push byte 0
        push byte 0
        push edi
        push dword 8000h
        call DrawShapeBlended
        mov eax, dword [GameLogoShape]
        add esp, byte 10h
        mov eax, dword [byte eax+02Ch]
        push esi
        mov dword [PanelArtSmall], eax
        call FreeMemBlock
        add esp, byte 4
        push ebx
        call FreeMemBlock
        add esp, byte 4
        push edi
        call FreeMemBlock
        add esp, byte 4
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        mov eax, dword [gameopts]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        shr eax, 1Ah
        push eax
        push str_Logo02dQfs2
        lea eax, [byte ebp-020h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        push byte 0
        lea eax, [byte ebp-020h]
        push eax
        call LoadFileAlloc
        add esp, byte 8
        push byte 0
        push eax
        mov esi, eax
        call UnpackedSize
        add esp, byte 4
        push eax
        push str_UnpackLogo
        call AllocMemBlock
        add esp, byte 0Ch
        push eax
        push esi
        mov ebx, eax
        call UnpackShared
        add esp, byte 8
        push byte 0
        push str_LOGO5
        push ebx
        call FindShape
        add esp, byte 8
        movsx edx, word [byte eax+06h]
        mov eax, 8000h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        push eax
        push str_LOGO5
        push ebx
        call FindShape
        add esp, byte 8
        movsx edx, word [byte eax+04h]
        mov eax, 8000h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [GameLogoBitmap], eax
        push byte 10h
        push str_LOGO5
        push ebx
        call FindShape
        add esp, byte 8
        push eax
        call ConvertArtNew
        add esp, byte 8
        push dword [GameLogoBitmap]
        mov edi, eax
        call SetDrawTarget
        add esp, byte 4
        push dword 0FFh
        call ClearScreen
        add esp, byte 4
        push byte 0
        push byte 0
        push edi
        push dword 8000h
        call DrawShapeBlended
        mov eax, dword [GameLogoBitmap]
        add esp, byte 10h
        mov eax, dword [byte eax+02Ch]
        push esi
        mov dword [PanelArtLarge], eax
        call FreeMemBlock
        add esp, byte 4
        push ebx
        call FreeMemBlock
        add esp, byte 4
        push edi
        call FreeMemBlock
        add esp, byte 4
        leave
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FreeGameText                                    AB0A6  97 PC, low confidence
; Frees the game text and art
;-----------------------------------------------------------------------------
FreeGameText:
        push ecx
        push edx
        call FreeLangText
        push dword [ClockFontLarge]
        call FreeMemBlock
        add esp, byte 4
        push dword [ClockFontSmall]
        call FreeMemBlock
        add esp, byte 4
        push dword [GameLogoShape]
        call FreeBitmap
        add esp, byte 4
        push dword [GameLogoBitmap]
        call FreeBitmap
        add esp, byte 4
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; PlayMenuGame                                 AB0E8  96 PC, medium confidence
;
; Plays a game started from the menus: by game mode (optflags bits 4-6: exhibition, season, playoffs, modem)
; picks the game options block, loads the goal sprites (GloL/GloR or GhiL/GhiR), PlayGame, then saves the
; result for the mode (season / playoff update, modem end) and runs PostGameScreens; 12h on a modem game
;-----------------------------------------------------------------------------
PlayMenuGame:
        push ebx
        push ecx
        push edx
        push esi
        call ShowLoadingScreen
        cmp dword [LinkGameActive], byte 0
        je near .4
        call ClearLinkAbort
        test eax, eax
        je short .1
        mov edx, 4A78h
        mov eax, SeasonFileName
        xor ebx, ebx
        call LinkSendBlock
        call LinkSyncMenu
        jmp short .4
.1:
        push eax
        push dword 4A78h
        push str_DEBUG
        xor ebx, ebx
        call AllocMemBlock
        mov edx, 4A78h
        add esp, byte 0Ch
        mov ecx, eax
        mov esi, eax
        call LinkReceiveBlock
        mov ebx, 16h
        mov eax, SeasonFileName
        mov edx, ecx
        call memcmp_
        test eax, eax
        jne short .2
        mov ebx, 4A52h
        mov eax, PeriodHomeTeam
        lea edx, [byte ecx+026h]
        call memcmp_
        test eax, eax
        je short .3
.2:
        push dword 4A78h
        push SeasonFileName
        push esi
        call bcopy
        add esp, byte 0Ch
.3:
        call LinkSyncMenu
        push esi
        call FreeMemBlock
        add esp, byte 4
.4:
        call FreeFrontEnd
        call InitGameAudio
        mov edx, ControlSetup
        mov eax, KeyboardControls
        call CopyControlSettings
        mov eax, 37h
        call ShowLoadingBar
        mov dword [LinesChangedInGame], 1
        mov eax, dword [PlayMenuGameFlag]
        mov dword [InIntermission], 0
        call PlayGame
        mov dword [PlayMenuGameFlag], 0
        mov dword [LinesChangedInGame], 0
        call FreeLangText
        push dword [ClockFontLarge]
        call FreeMemBlock
        add esp, byte 4
        push dword [ClockFontSmall]
        call FreeMemBlock
        add esp, byte 4
        push dword [GameLogoShape]
        call FreeBitmap
        add esp, byte 4
        push dword [GameLogoBitmap]
        call FreeBitmap
        add esp, byte 4
        cmp dword [InIntermission], byte 0
        setne al
        movzx edx, al
        xor eax, eax
        call InitGameSounds
        call InitFrontEnd
        mov eax, edx
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SendGameResult                                  AB240  97 PC, low confidence
; Sends the game result over the link
;-----------------------------------------------------------------------------
SendGameResult:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 14h, 0
        push byte 0
        push dword 4A78h
        push str_Xferdata
        call AllocMemBlock
        mov dword [byte ebp-04h], eax
        mov eax, dword [SeasonUserTeam]
        add esp, byte 0Ch
        movsx edx, word [byte eax+02h]
        mov eax, 227h
        mov dword [byte ebp-08h], 0
        call GetLangText
        call ShowWorkingBox
        jmp near .23
.1:
        mov edx, dword [GameSettings]
        and edx, byte 70h
        cmp edx, byte 10h
        jne short .2
        mov edx, dword [byte ebp-08h]
        mov eax, dword [byte eax+020h]
        shl edx, 4
        add eax, edx
        movsx edx, byte [eax]
        imul edx, byte 1Ch
        cmp byte [dword edx+SeasonUserActive], 1
        je short .3
        movsx eax, byte [byte eax+01h]
        imul eax, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        je short .3
.2:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 20h
        jne near .22
        mov edx, dword [byte ebp-08h]
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        add eax, edx
        movsx edx, byte [eax]
        imul edx, byte 1Ch
        cmp byte [dword edx+PlayoffUserActive], 1
        je short .3
        movsx eax, byte [byte eax+01h]
        imul eax, byte 1Ch
        cmp byte [dword eax+PlayoffUserActive], 1
        jne near .22
.3:
        mov esi, dword [byte ebp-08h]
        mov eax, dword [SeasonUserTeam]
        shl esi, 4
        mov eax, dword [byte eax+020h]
        add eax, esi
        mov edx, DbKeyBuffer
        add eax, byte 8
        call KeysEqual
        test eax, eax
        je short .4
        mov dword [byte ebp-010h], 0
        jmp short .6
.4:
        mov eax, dword [SeasonUserTeam]
        mov eax, dword [byte eax+020h]
        add eax, esi
        mov edx, dword [byte ebp-04h]
        add eax, byte 8
        call FindReplayIndexEntry
        mov eax, dword [byte ebp-04h]
        cmp dword [dword eax+04A74h], byte 0FFFFFFFFh
        jne short .5
        mov dword [byte ebp-010h], 0FFFFFFFFh
        jmp short .6
.5:
        mov eax, dword [dword eax+04A74h]
        inc eax
        mov dword [byte ebp-010h], eax
.6:
        call ClearLinkAbort
        test eax, eax
        je short .7
        mov edx, 4
        lea eax, [byte ebp-010h]
        xor ebx, ebx
        call LinkSendBlock
        mov edx, 4
        lea eax, [byte ebp-014h]
        xor ebx, ebx
        call LinkReceiveBlock
        jmp short .8
.7:
        mov edx, 4
        lea eax, [byte ebp-014h]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 4
        lea eax, [byte ebp-010h]
        xor ebx, ebx
        call LinkSendBlock
.8:
        mov eax, dword [byte ebp-014h]
        cmp eax, dword [byte ebp-010h]
        jbe short .9
        mov edx, 1
        xor eax, eax
        jmp short .12
.9:
        mov eax, dword [byte ebp-010h]
        cmp eax, dword [byte ebp-014h]
        jbe short .10
        mov eax, 1
        jmp short .11
.10:
        xor eax, eax
.11:
        xor edx, edx
.12:
        test eax, eax
        je near .15
        call AllocCrusherBuffers
        mov eax, dword [byte ebp-04h]
        cmp dword [dword eax+04A70h], byte 0
        je short .13
        push byte 0
        push dword [dword eax+04A70h]
        push str_Replaybuf2
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp-0Ch], eax
.13:
        mov edx, 4A78h
        mov eax, dword [byte ebp-04h]
        call CopyToTransfer
        mov eax, dword [byte ebp-04h]
        cmp dword [dword eax+04A70h], byte 0
        je short .14
        mov edx, dword [byte ebp-0Ch]
        call OpenReplayFile
        mov edx, dword [byte ebp-04h]
        mov eax, dword [byte ebp-0Ch]
        mov edx, dword [dword edx+04A70h]
        call CopyToTransfer
        push dword [byte ebp-0Ch]
        call FreeMemBlock
        add esp, byte 4
.14:
        mov eax, 1
        call LinkSendData
        call FreeTransferBuffers
        jmp near .19
.15:
        test edx, edx
        je near .19
        call AllocCrusherBuffers
        call LinkReceiveData
        mov edx, 4A78h
        mov eax, dword [byte ebp-04h]
        call AppendToTransfer
        mov eax, dword [byte ebp-04h]
        cmp dword [dword eax+04A70h], byte 0
        je short .16
        push byte 0
        push dword [dword eax+04A70h]
        push str_Replaybuf2
        call AllocMemBlock
        mov edx, dword [byte ebp-04h]
        add esp, byte 0Ch
        mov edx, dword [dword edx+04A70h]
        mov dword [byte ebp-0Ch], eax
        call AppendToTransfer
        jmp short .17
.16:
        mov dword [byte ebp-0Ch], 0
.17:
        mov eax, 1
        mov ebx, dword [byte ebp-04h]
        mov edx, dword [byte ebp-0Ch]
        call FreeTransferBuffers
        mov eax, dword [byte ebp-04h]
        mov ebx, dword [dword ebx+04A70h]
        call AddReplayIndexEntry
        mov eax, dword [byte ebp-04h]
        cmp dword [dword eax+04A70h], byte 0
        je short .18
        push dword [byte ebp-0Ch]
        call FreeMemBlock
        add esp, byte 4
.18:
        mov ebx, 4A78h
        mov edx, dword [byte ebp-04h]
        mov eax, SeasonFileName
        mov esi, dword [byte ebp-08h]
        call memcpy_
        mov eax, dword [SeasonUserTeam]
        shl esi, 4
        mov eax, dword [byte eax+020h]
        lea edi, [byte esi+eax+08h]
        mov esi, dword [byte ebp-04h]
        movsd
        movsd
.19:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 20h
        je short .20
        cmp dword [SeasonActive], byte 0
        je short .21
.20:
        call HideWorkingBox
        call SaveGameResults
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [byte eax+02h]
        mov eax, 227h
        call GetLangText
        call ShowWorkingBox
.21:
        mov eax, dword [byte ebp-08h]
        call UpdateWorkingBox
.22:
        inc dword [byte ebp-08h]
.23:
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [byte eax+02h]
        cmp edx, dword [byte ebp-08h]
        jg near .1
        call HideWorkingBox
        call SaveGameResults
        push dword [byte ebp-04h]
        call FreeMemBlock
        add esp, byte 4
SendGameResult_32D:
        leave
        jmp near SaveGameResults_B30
;-----------------------------------------------------------------------------
; SaveGameResults                                 AB573  97 PC, low confidence
; Saves the results of a game to the league
;-----------------------------------------------------------------------------
SaveGameResults:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 0E4h, 0
        sub ebp, 82h
        push byte 0
        push dword 4A78h
        push str_Gdata
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp+072h], 0
        push byte 0
        mov dword [byte ebp+062h], 0
        mov dword [byte ebp+05Ah], 0
        push dword 194Fh
        mov dword [byte ebp+05Eh], 0
        mov dword [byte ebp+076h], 0FFFFFFFFh
        push str_Ros2
        mov dword [byte ebp+07Ah], 0
        mov dword [byte ebp+066h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp+06Ah], eax
        jmp near .11
.1:
        cmp edx, byte 10h
        jne near .5
        cmp dword [SeasonActive], byte 0
        jne near .5
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte eax+020h]
        shl edx, 4
        add eax, edx
        movsx ecx, byte [eax]
        imul ecx, byte 1Ch
        cmp byte [dword ecx+SeasonUserActive], 1
        je short .2
        movsx eax, byte [byte eax+01h]
        imul eax, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        jne near .8
.2:
        mov ecx, dword [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        shl ecx, 4
        mov eax, dword [byte eax+020h]
        add eax, ecx
        movsx edx, byte [byte eax+02h]
        cmp edx, byte 0FFFFFFFFh
        jne near .8
        mov edx, DbKeyBuffer
        add eax, byte 8
        call KeysEqual
        test eax, eax
        jne near .8
        mov eax, dword [SeasonUserTeam]
        mov esi, dword [byte eax+020h]
        mov dx, word [byte ecx+esi+04h]
        mov word [AllStarDay], dx
        mov esi, dword [byte eax+020h]
        movsx edx, byte [ecx+esi]
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        mov edx, dword [byte ebp+06Ah]
        call FindGameRecord
        mov eax, dword [byte ebp+06Ah]
        call UpdateTeamLines
        mov eax, dword [SeasonUserTeam]
        mov eax, dword [byte eax+020h]
        movsx eax, byte [ecx+eax]
        imul eax, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        je short .3
        mov eax, dword [byte ebp+06Ah]
        call UpdateGameRecord
.3:
        mov ebx, dword [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        shl ebx, 4
        mov ecx, dword [byte eax+020h]
        movsx edx, byte [byte ecx+ebx+01h]
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        mov edx, dword [byte ebp+06Ah]
        call FindGameRecord
        mov eax, dword [byte ebp+06Ah]
        call UpdateTeamLines
        mov eax, dword [SeasonUserTeam]
        mov eax, dword [byte eax+020h]
        movsx eax, byte [byte ebx+eax+01h]
        imul eax, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        je short .4
        mov eax, dword [byte ebp+06Ah]
        call UpdateGameRecord
.4:
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        add eax, edx
        mov edx, dword [byte ebp+066h]
        add eax, byte 8
        call FindReplayIndexEntry
        mov eax, dword [byte ebp+066h]
        cmp dword [dword eax+04A74h], byte 0FFFFFFFFh
        jne near .8
        movsx edx, word [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        call SaveExhibitionResult
        jmp near .8
.5:
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        add eax, edx
        movsx ecx, byte [eax]
        imul ecx, byte 1Ch
        cmp byte [dword ecx+PlayoffUserActive], 1
        je short .6
        movsx eax, byte [byte eax+01h]
        imul eax, byte 1Ch
        cmp byte [dword eax+PlayoffUserActive], 1
        jne short .8
.6:
        mov ecx, dword [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        shl ecx, 4
        mov eax, dword [byte eax+020h]
        add eax, ecx
        movsx edx, byte [byte eax+02h]
        cmp edx, byte 0FFFFFFFFh
        jne short .8
        mov edx, DbKeyBuffer
        add eax, byte 8
        call KeysEqual
        test eax, eax
        jne short .8
        mov eax, dword [SeasonUserTeam]
        mov eax, dword [byte eax+020h]
        add eax, ecx
        mov edx, dword [byte ebp+066h]
        add eax, byte 8
        call FindReplayIndexEntry
        mov eax, dword [byte ebp+066h]
        cmp dword [dword eax+04A74h], byte 0FFFFFFFFh
        jne short .7
        movsx edx, word [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        call SaveExhibitionResult
.7:
        mov eax, dword [byte ebp+07Ah]
        call SaveReplayFile
.8:
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        movsx eax, byte [byte edx+eax+02h]
        cmp eax, byte 0FFFFFFFFh
        je short .9
        mov eax, dword [byte ebp+07Ah]
        mov dword [byte ebp+072h], eax
.9:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .10
        cmp dword [SeasonActive], byte 0
.10:
        inc dword [byte ebp+07Ah]
.11:
        mov eax, dword [SeasonUserTeam]
        mov edx, dword [GameSettings]
        movsx ebx, word [byte eax+02h]
        and edx, byte 70h
        cmp ebx, dword [byte ebp+07Ah]
        jg near .1
        cmp edx, byte 10h
        jne near .16
        cmp dword [SeasonActive], byte 0
        jne near .16
        mov dword [byte ebp+07Ah], 0
        mov dword [byte ebp+062h], 1
        jmp short .15
.12:
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte eax+020h]
        shl edx, 4
        add eax, edx
        movsx ecx, byte [eax]
        imul ecx, byte 1Ch
        cmp byte [dword ecx+SeasonUserActive], 1
        je short .13
        movsx eax, byte [byte eax+01h]
        imul eax, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        jne short .14
.13:
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        movsx eax, byte [byte edx+eax+02h]
        cmp eax, byte 0FFFFFFFFh
        jne short .14
        mov dword [byte ebp+062h], 0
.14:
        inc dword [byte ebp+07Ah]
.15:
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [byte eax+02h]
        cmp edx, dword [byte ebp+07Ah]
        jg short .12
        cmp dword [byte ebp+062h], byte 0
        je short .16
        dec edx
        mov dword [byte ebp+072h], edx
.16:
        mov eax, dword [byte ebp+072h]
        mov dword [byte ebp+07Ah], eax
        jmp short .19
.17:
        mov ecx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+072h]
        mov eax, dword [byte eax+020h]
        shl ecx, 4
        shl edx, 4
        add ecx, eax
        add eax, edx
        mov dx, word [byte ecx+04h]
        cmp dx, word [byte eax+04h]
        jne short .18
        mov eax, dword [byte ebp+07Ah]
        mov dword [byte ebp+072h], eax
.18:
        inc dword [byte ebp+07Ah]
.19:
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [byte eax+02h]
        cmp edx, dword [byte ebp+07Ah]
        jg short .17
        mov dword [byte ebp+07Ah], 0
        jmp near .27
.20:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne near .23
        cmp dword [SeasonActive], byte 0
        jne near .23
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        add eax, edx
        movsx ecx, byte [eax]
        imul ecx, byte 1Ch
        cmp byte [dword ecx+SeasonUserActive], 0
        jne near .26
        movsx ecx, byte [byte eax+01h]
        imul ecx, byte 1Ch
        cmp byte [dword ecx+SeasonUserActive], 0
        jne near .26
        movsx eax, byte [byte eax+02h]
        cmp eax, byte 0FFFFFFFFh
        jne near .26
        cmp eax, dword [byte ebp+076h]
        jne short .21
        mov eax, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+072h]
        mov dword [byte ebp+076h], eax
        sub edx, eax
        mov eax, 236h
        call GetLangText
        call ShowWorkingBox
        jmp short .22
.21:
        mov eax, dword [byte ebp+07Ah]
        sub eax, dword [byte ebp+076h]
        call UpdateWorkingBox
.22:
        mov esi, dword [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        shl esi, 4
        mov ecx, dword [byte eax+020h]
        mov dx, word [byte ecx+esi+04h]
        mov word [AllStarDay], dx
        mov ecx, dword [byte eax+020h]
        movsx edx, byte [ecx+esi]
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        mov edx, dword [byte ebp+06Ah]
        call FindGameRecord
        mov eax, dword [byte ebp+06Ah]
        call UpdateTeamLines
        mov eax, dword [byte ebp+06Ah]
        call UpdateGameRecord
        mov eax, dword [SeasonUserTeam]
        mov ecx, dword [byte eax+020h]
        movsx edx, byte [byte ecx+esi+01h]
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        mov edx, dword [byte ebp+06Ah]
        call FindGameRecord
        mov eax, dword [byte ebp+06Ah]
        mov ebx, SeasonFileName
        call UpdateTeamLines
        mov eax, dword [byte ebp+06Ah]
        movsx edx, word [byte ebp+07Ah]
        call UpdateGameRecord
        mov eax, dword [SeasonUserTeam]
        call StartSeasonGame
        mov eax, dword [byte ebp+07Ah]
        xor edx, edx
        mov ebx, SeasonFileName
        call SimulateGame
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        call SaveSeasonResult
        jmp near .26
.23:
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        add eax, edx
        movsx edx, byte [eax]
        imul ecx, edx, byte 1Ch
        cmp byte [dword ecx+PlayoffUserActive], 0
        jne near .26
        movsx ecx, byte [byte eax+01h]
        imul ecx, byte 1Ch
        cmp byte [dword ecx+PlayoffUserActive], 0
        jne near .26
        movsx eax, byte [byte eax+02h]
        cmp eax, byte 0FFFFFFFFh
        jne near .26
        cmp edx, eax
        je near .26
        cmp eax, dword [byte ebp+076h]
        jne short .24
        mov eax, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+072h]
        mov dword [byte ebp+076h], eax
        sub edx, eax
        mov eax, 236h
        call GetLangText
        call ShowWorkingBox
        jmp short .25
.24:
        mov eax, dword [byte ebp+07Ah]
        sub eax, dword [byte ebp+076h]
        call UpdateWorkingBox
.25:
        mov esi, dword [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        shl esi, 4
        mov ecx, dword [byte eax+020h]
        mov dx, word [byte ecx+esi+04h]
        mov word [AllStarDay], dx
        mov ecx, dword [byte eax+020h]
        movsx edx, byte [ecx+esi]
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        mov edx, dword [byte ebp+06Ah]
        call FindGameRecord
        mov eax, dword [byte ebp+06Ah]
        call UpdateTeamLines
        mov eax, dword [byte ebp+06Ah]
        call UpdateGameRecord
        mov eax, dword [SeasonUserTeam]
        mov edx, dword [byte eax+020h]
        movsx edx, byte [byte edx+esi+01h]
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        mov edx, dword [byte ebp+06Ah]
        call FindGameRecord
        mov eax, dword [byte ebp+06Ah]
        mov ebx, SeasonFileName
        call UpdateTeamLines
        mov eax, dword [byte ebp+06Ah]
        movsx edx, word [byte ebp+07Ah]
        call UpdateGameRecord
        mov eax, dword [SeasonUserTeam]
        call StartSeasonGame
        mov edx, 1
        mov eax, dword [byte ebp+07Ah]
        mov ebx, SeasonFileName
        call SimulateGame
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        call SaveSeasonResult
        mov eax, dword [byte ebp+07Ah]
        call SaveReplayFile
.26:
        inc dword [byte ebp+07Ah]
.27:
        mov eax, dword [byte ebp+07Ah]
        cmp eax, dword [byte ebp+072h]
        jle near .20
        cmp dword [byte ebp+076h], byte 0FFFFFFFFh
        je short .28
        call HideWorkingBox
.28:
        mov dword [byte ebp+076h], 0FFFFFFFFh
        cmp dword [byte ebp+062h], byte 0
        je near .41
        mov eax, dword [SeasonRandomSeed]
        mov dword [byte ebp+07Ah], 0
        mov dword [PlayoffRandomSeed], eax
.29:
        mov eax, dword [byte ebp+07Ah]
        mov dword [nosplit eax*4+PlayoffTeams], 0FFFFFFFFh
        inc dword [byte ebp+07Ah]
        mov dword [nosplit eax*4+PlayoffTeamNames], 0
        cmp dword [byte ebp+07Ah], byte 1Fh
        jl short .29
        mov dword [PlayoffGameCount], 0
        mov byte [PlayoffRound], 0
        mov byte [PlayoffStarted], 1
        lea edx, [byte ebp+03Ah]
        mov eax, dword [PlayoffRounds]
        and byte [PlayoffRoundBits], 0F8h
        and eax, byte 7
        mov ebx, dword [SeasonUserTeam]
        or dword [PlayoffRoundBits], eax
        lea eax, [byte ebp+01Eh]
        mov dword [byte ebp+07Ah], 0
        call SortStandings
.30:
        mov ecx, dword [byte ebp+07Ah]
        movzx ecx, byte [byte ecx+ebp+01Eh]
        imul esi, ecx, byte 1Ch
        mov edx, ecx
        shl edx, 3
        cmp dword [nosplit ecx*4+PlayoffColumns], byte 3
        jne short .32
        cmp dword [byte ebp+05Ah], byte 8
        jge short .31
        mov eax, dword [byte ebp+05Ah]
        imul edi, dword [nosplit eax*4+HomeUserSlot], byte 1Ch
        lea esi, [dword esi+SeasonUserRecords]
        lea edi, [dword edi+PlayoffUserRecords]
        movsd
        movsd
        movsd
        movsd
        movsd
        movsd
        movsd
        mov esi, dword [nosplit eax*4+HomeUserSlot]
        mov dword [nosplit esi*4+PlayoffTeams], ecx
        mov ecx, dword [SeasonUserTeam]
        mov ebx, dword [byte ecx+014h]
        add edx, ebx
        lea edi, [byte ebp+esi*8-062h]
        mov esi, edx
        movsd
        movsd
.31:
        inc dword [byte ebp+05Ah]
        jmp short .34
.32:
        cmp dword [byte ebp+05Eh], byte 8
        jge short .33
        mov eax, dword [byte ebp+05Eh]
        imul edi, dword [nosplit eax*4+AwayUserSlot], byte 1Ch
        lea esi, [dword esi+SeasonUserRecords]
        lea edi, [dword edi+PlayoffUserRecords]
        movsd
        movsd
        movsd
        movsd
        movsd
        movsd
        movsd
        mov esi, dword [nosplit eax*4+AwayUserSlot]
        mov dword [nosplit esi*4+PlayoffTeams], ecx
        mov ecx, dword [SeasonUserTeam]
        mov ecx, dword [byte ecx+014h]
        add ecx, edx
        lea edi, [byte ebp+esi*8-062h]
        mov esi, ecx
        movsd
        movsd
.33:
        inc dword [byte ebp+05Eh]
.34:
        inc dword [byte ebp+07Ah]
        cmp dword [byte ebp+07Ah], byte 1Ah
        jl near .30
        lea eax, [byte ebp+056h]
        lea ebx, [byte ebp-062h]
        mov edx, 10h
        mov ecx, dword [SeasonUserTeam]
        push eax
        mov eax, 69h
        mov dword [byte ebp+07Ah], 0
        call CreateExhibitionFile
        jmp near .40
.35:
        mov dword [byte ebp+06Eh], 0
.36:
        cmp dword [byte ebp+07Ah], byte 0
        je short .37
        cmp dword [byte ebp+07Ah], byte 1
        je short .37
        cmp dword [byte ebp+07Ah], byte 4
        je short .37
        cmp dword [byte ebp+07Ah], byte 6
        jne near .38
.37:
        mov al, byte [byte ebp+06Eh]
        mov ecx, dword [byte ebp+07Ah]
        add al, al
        shl ecx, 3
        mov byte [byte ebp+07Eh], al
        mov eax, dword [byte ebp+056h]
        add ecx, dword [byte ebp+06Eh]
        mov eax, dword [byte eax+020h]
        shl ecx, 4
        mov dl, byte [byte ebp+07Eh]
        mov byte [ecx+eax], dl
        mov eax, dword [byte ebp+056h]
        mov eax, dword [byte eax+020h]
        inc dl
        mov byte [byte ecx+eax+01h], dl
        movzx ax, byte [PlayoffRound]
        imul esi, eax, byte 0Eh
        mov ebx, 1
        mov edx, 5
        mov eax, 7CCh
        call DaysToYear
        mov edx, eax
        add edx, esi
        mov esi, dword [byte ebp+07Ah]
        add esi, esi
        mov eax, dword [byte ebp+056h]
        add edx, esi
        mov eax, dword [byte eax+020h]
        inc edx
        mov word [byte ecx+eax+04h], dx
        mov eax, dword [byte ebp+056h]
        mov eax, dword [byte eax+020h]
        mov word [byte ecx+eax+06h], 730h
        mov eax, dword [byte ebp+056h]
        mov dl, byte [byte ebp+07Eh]
        mov eax, dword [byte eax+020h]
        add dl, 8
        mov byte [byte ecx+eax+040h], dl
        mov eax, dword [byte ebp+056h]
        mov dl, byte [byte ebp+07Eh]
        mov eax, dword [byte eax+020h]
        add dl, 9
        mov byte [byte ecx+eax+041h], dl
        movzx ax, byte [PlayoffRound]
        imul edi, eax, byte 0Eh
        jmp near .39
.38:
        mov al, byte [byte ebp+06Eh]
        mov ecx, dword [byte ebp+07Ah]
        add al, al
        shl ecx, 3
        mov byte [byte ebp+07Eh], al
        mov eax, dword [byte ebp+056h]
        add ecx, dword [byte ebp+06Eh]
        mov eax, dword [byte eax+020h]
        shl ecx, 4
        mov dl, byte [byte ebp+07Eh]
        mov byte [byte ecx+eax+01h], dl
        mov eax, dword [byte ebp+056h]
        mov eax, dword [byte eax+020h]
        inc dl
        mov byte [ecx+eax], dl
        movzx si, byte [PlayoffRound]
        imul esi, byte 0Eh
        mov ebx, 1
        mov edx, 5
        mov eax, 7CCh
        call DaysToYear
        mov edx, eax
        add edx, esi
        mov esi, dword [byte ebp+07Ah]
        add esi, esi
        mov eax, dword [byte ebp+056h]
        add edx, esi
        mov eax, dword [byte eax+020h]
        inc edx
        mov word [byte ecx+eax+04h], dx
        mov eax, dword [byte ebp+056h]
        mov eax, dword [byte eax+020h]
        mov word [byte ecx+eax+06h], 730h
        mov eax, dword [byte ebp+056h]
        mov dl, byte [byte ebp+07Eh]
        mov eax, dword [byte eax+020h]
        add dl, 8
        mov byte [byte ecx+eax+041h], dl
        mov eax, dword [byte ebp+056h]
        mov dl, byte [byte ebp+07Eh]
        mov eax, dword [byte eax+020h]
        add dl, 9
        mov byte [byte ecx+eax+040h], dl
        movzx di, byte [PlayoffRound]
        imul edi, byte 0Eh
.39:
        mov ebx, 1
        mov edx, 5
        mov eax, 7CCh
        call DaysToYear
        add eax, edi
        add esi, eax
        mov eax, dword [byte ebp+056h]
        mov eax, dword [byte eax+020h]
        mov word [byte ecx+eax+044h], si
        mov eax, dword [byte ebp+056h]
        mov eax, dword [byte eax+020h]
        mov word [byte ecx+eax+046h], 730h
        inc dword [byte ebp+06Eh]
        cmp dword [byte ebp+06Eh], byte 4
        jl near .36
        inc dword [byte ebp+07Ah]
.40:
        mov eax, dword [PlayoffRoundBits]
        and eax, byte 7
        cmp eax, dword [byte ebp+07Ah]
        ja near .35
        mov byte [PlayoffStarted], 1
        mov eax, dword [byte ebp+056h]
        mov dword [SeasonActive], 1
        mov dword [SeasonUserTeam], eax
.41:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 20h
        je short .42
        cmp dword [SeasonActive], byte 0
        je near .59
.42:
        call AdvanceSeasonDate
        xor eax, eax
        mov dword [byte ebp+07Ah], eax
        jmp short .46
.43:
        mov edx, dword [byte ebp+07Ah]
        mov ecx, dword [byte ecx+020h]
        shl edx, 4
        add ecx, edx
        movsx esi, byte [ecx]
        imul esi, byte 1Ch
        cmp byte [dword esi+PlayoffUserActive], 1
        jne short .44
        movsx edx, byte [byte ecx+02h]
        cmp edx, byte 0FFFFFFFFh
        jne short .44
        mov eax, 1
.44:
        mov edx, dword [byte ebp+07Ah]
        mov ecx, dword [SeasonUserTeam]
        shl edx, 4
        mov ecx, dword [byte ecx+020h]
        add ecx, edx
        movsx esi, byte [byte ecx+01h]
        imul esi, byte 1Ch
        cmp byte [dword esi+PlayoffUserActive], 1
        jne short .45
        movsx edx, byte [byte ecx+02h]
        cmp edx, byte 0FFFFFFFFh
        jne short .45
        mov eax, 1
.45:
        inc dword [byte ebp+07Ah]
.46:
        mov ecx, dword [SeasonUserTeam]
        movsx edx, word [byte ecx+02h]
        cmp edx, dword [byte ebp+07Ah]
        jle short .47
        test eax, eax
        je short .43
.47:
        test eax, eax
        jne near .59
        mov dword [byte ebp+07Ah], eax
.48:
        inc dword [byte ebp+07Ah]
        cmp dword [byte ebp+07Ah], byte 10h
        jl short .48
.49:
        cmp byte [PlayoffRound], 4
        je near .59
        test eax, eax
        jne near .59
        mov dword [byte ebp+07Ah], eax
        jmp near .54
.50:
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte eax+020h]
        shl edx, 4
        add eax, edx
        movsx edx, byte [eax]
        cmp edx, byte 0FFFFFFFFh
        je short .53
        movsx eax, byte [byte eax+02h]
        cmp eax, byte 0FFFFFFFFh
        jne short .53
        cmp eax, dword [byte ebp+076h]
        jne short .51
        mov eax, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+072h]
        mov dword [byte ebp+076h], eax
        sub edx, eax
        mov eax, 236h
        call GetLangText
        call ShowWorkingBox
        jmp short .52
.51:
        mov eax, dword [byte ebp+07Ah]
        sub eax, dword [byte ebp+076h]
        call UpdateWorkingBox
.52:
        movsx edx, word [byte ebp+07Ah]
        mov ebx, SeasonFileName
        mov eax, dword [SeasonUserTeam]
        call StartSeasonGame
        mov edx, 1
        mov eax, dword [byte ebp+07Ah]
        mov ebx, SeasonFileName
        call SimulateGame
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [SeasonUserTeam]
        call SaveSeasonResult
        mov eax, dword [byte ebp+07Ah]
        call SaveReplayFile
.53:
        inc dword [byte ebp+07Ah]
.54:
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [byte eax+02h]
        cmp edx, dword [byte ebp+07Ah]
        jg near .50
        call AdvanceSeasonDate
        xor eax, eax
        mov dword [byte ebp+07Ah], eax
        jmp short .58
.55:
        mov edx, dword [byte ebp+07Ah]
        mov ecx, dword [byte ecx+020h]
        shl edx, 4
        add ecx, edx
        movsx esi, byte [ecx]
        imul esi, byte 1Ch
        cmp byte [dword esi+PlayoffUserActive], 1
        jne short .56
        movsx edx, byte [byte ecx+02h]
        cmp edx, byte 0FFFFFFFFh
        jne short .56
        mov eax, 1
.56:
        mov edx, dword [byte ebp+07Ah]
        mov ecx, dword [SeasonUserTeam]
        shl edx, 4
        mov ecx, dword [byte ecx+020h]
        add ecx, edx
        movsx esi, byte [byte ecx+01h]
        imul esi, byte 1Ch
        cmp byte [dword esi+PlayoffUserActive], 1
        jne short .57
        movsx edx, byte [byte ecx+02h]
        cmp edx, byte 0FFFFFFFFh
        jne short .57
        mov eax, 1
.57:
        inc dword [byte ebp+07Ah]
.58:
        mov ecx, dword [SeasonUserTeam]
        movsx edx, word [byte ecx+02h]
        cmp edx, dword [byte ebp+07Ah]
        jle near .49
        test eax, eax
        je short .55
        jmp near .49
.59:
        cmp dword [byte ebp+062h], byte 0
        je short .60
        mov esi, dword [SeasonUserTeam]
        mov edi, SeasonStatsPath
        lea esi, [byte esi+04h]
        movsd
        movsd
        call SeasonSettingsPath
        call PlayoffSettingsPath
.60:
        cmp dword [byte ebp+076h], byte 0FFFFFFFFh
        je short .61
        call HideWorkingBox
.61:
        push dword [byte ebp+06Ah]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+066h]
        call FreeMemBlock
        add esp, byte 4
        lea esp, [dword ebp+082h]
SaveGameResults_B2F:
        pop ebp
SaveGameResults_B30:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AdvanceSeasonDate                               AC0A9  97 PC, low confidence
; Advances the season date
;-----------------------------------------------------------------------------
AdvanceSeasonDate:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 30h, 0
        mov dword [byte ebp-0Ch], 0
        cmp byte [PlayoffRound], 4
        jne short .1
        mov eax, 1
        jmp near SendGameResult_32D
.1:
        mov dword [byte ebp-04h], 0
        jmp short .4
.2:
        mov esi, dword [byte ebp-04h]
        mov eax, dword [byte eax+020h]
        shl esi, 4
        lea edi, [byte ebp-030h]
        add esi, eax
        movsd
        movsd
        movsd
        movsd
        movsx eax, byte [byte ebp-030h]
        cmp eax, byte 0FFFFFFFFh
        je short .3
        movsx eax, byte [byte ebp-02Eh]
        cmp eax, byte 0FFFFFFFFh
        jne short .3
        mov dword [byte ebp-0Ch], 1
.3:
        inc dword [byte ebp-04h]
.4:
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [byte eax+02h]
        cmp edx, dword [byte ebp-04h]
        jle short .5
        cmp dword [byte ebp-0Ch], byte 0
        je short .2
.5:
        cmp dword [byte ebp-0Ch], byte 0
        jne near .26
        xor esi, esi
        mov dword [byte ebp-04h], esi
.6:
        mov eax, dword [byte ebp-04h]
        movzx ecx, byte [PlayoffRound]
        mov eax, dword [nosplit eax*4+PlayoffRoundSlots]
        xor ebx, ebx
        mov ecx, dword [nosplit ecx*4+PlayoffRoundGames]
        mov edx, dword [nosplit eax*4+PlayoffTeams]
        jmp short .9
.7:
        mov eax, ecx
        shl eax, 2
        cmp edx, dword [dword eax+PlayoffTeams]
        jne short .8
        mov edi, dword [PlayoffRoundBits]
        and edi, byte 7
        shr edi, 1
        inc edi
        mov eax, dword [dword eax+PlayoffTeamNames]
        cmp eax, edi
        jne short .8
        mov ebx, dword [byte ebp-018h]
        mov eax, esi
        shl ebx, 5
        mov eax, dword [dword ebx+eax*4+PlayoffPairings]
        inc esi
        mov ebx, 1
        mov dword [nosplit eax*4+PlayoffTeams], edx
.8:
        inc ecx
.9:
        movzx eax, byte [PlayoffRound]
        mov dword [byte ebp-018h], eax
        cmp ecx, dword [nosplit eax*4+PlayoffWinsNeeded]
        jge short .10
        test ebx, ebx
        je short .7
.10:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 10h
        jl near .6
        mov al, byte [PlayoffRound]
        cmp al, 1
        jb short .11
        jbe short .12
        cmp al, 2
        je short .13
        jmp short .14
.11:
        test al, al
        jne short .14
        mov dword [byte ebp-020h], 8
        mov dword [byte ebp-01Ch], 4
        mov dword [byte ebp-08h], 10h
        jmp short .14
.12:
        mov dword [byte ebp-020h], 0Ch
        mov dword [byte ebp-01Ch], 2
        mov dword [byte ebp-08h], 18h
        jmp short .14
.13:
        mov dword [byte ebp-020h], 0Eh
        mov dword [byte ebp-01Ch], 1
        mov dword [byte ebp-08h], 1Ch
.14:
        cmp byte [PlayoffRound], 3
        je near .25
        mov eax, dword [byte ebp-08h]
        mov dword [byte ebp-04h], eax
        jmp near .24
.15:
        xor ecx, ecx
.16:
        mov eax, dword [byte ebp-04h]
        mov edx, dword [nosplit ecx*4+PlayoffTeams]
        cmp edx, dword [nosplit eax*4+PlayoffTeams]
        jne short .17
        mov dword [byte ebp-014h], ecx
.17:
        mov eax, dword [byte ebp-04h]
        mov edx, dword [nosplit ecx*4+PlayoffTeams]
        cmp edx, dword [nosplit eax*4+PlayoffOpponents]
        jne short .18
        mov dword [byte ebp-010h], ecx
.18:
        inc ecx
        cmp ecx, byte 10h
        jl short .16
        xor ecx, ecx
        jmp near .23
.19:
        test ecx, ecx
        je short .20
        cmp ecx, byte 1
        je short .20
        cmp ecx, byte 4
        je short .20
        cmp ecx, byte 6
        jne short .21
.20:
        mov eax, dword [byte ebp-04h]
        sub eax, dword [byte ebp-08h]
        cdq
        LD sub, eax, edx
        sar eax, 1
        mov esi, dword [byte ebp-01Ch]
        imul esi, ecx
        imul edx, dword [byte ebp-020h], byte 7
        add eax, edx
        add esi, eax
        mov eax, dword [SeasonUserTeam]
        mov eax, dword [byte eax+020h]
        shl esi, 4
        mov dl, byte [byte ebp-014h]
        mov byte [esi+eax], dl
        mov eax, dword [SeasonUserTeam]
        mov eax, dword [byte eax+020h]
        mov dl, byte [byte ebp-010h]
        mov byte [byte esi+eax+01h], dl
        jmp short .22
.21:
        mov eax, dword [byte ebp-04h]
        sub eax, dword [byte ebp-08h]
        cdq
        LD sub, eax, edx
        sar eax, 1
        mov esi, dword [byte ebp-01Ch]
        imul esi, ecx
        imul edx, dword [byte ebp-020h], byte 7
        add edx, eax
        mov eax, dword [SeasonUserTeam]
        add esi, edx
        mov eax, dword [byte eax+020h]
        shl esi, 4
        mov dl, byte [byte ebp-014h]
        mov byte [byte esi+eax+01h], dl
        mov eax, dword [SeasonUserTeam]
        mov eax, dword [byte eax+020h]
        mov dl, byte [byte ebp-010h]
        mov byte [esi+eax], dl
.22:
        movzx ax, byte [PlayoffRound]
        inc eax
        imul edi, eax, byte 0Eh
        mov ebx, 1
        mov edx, 5
        mov eax, 7CCh
        call DaysToYear
        mov edx, ecx
        add edi, eax
        add edx, ecx
        mov eax, dword [SeasonUserTeam]
        add edx, edi
        mov eax, dword [byte eax+020h]
        inc edx
        mov word [byte esi+eax+04h], dx
        mov eax, dword [SeasonUserTeam]
        mov eax, dword [byte eax+020h]
        mov word [byte esi+eax+06h], 730h
        inc ecx
.23:
        mov eax, dword [PlayoffRoundBits]
        and eax, byte 7
        cmp ecx, eax
        jb near .19
        add dword [byte ebp-04h], byte 2
.24:
        mov eax, dword [byte ebp-01Ch]
        add eax, eax
        add eax, dword [byte ebp-08h]
        cmp eax, dword [byte ebp-04h]
        jg near .15
.25:
        mov eax, dword [SeasonUserTeam]
        inc byte [PlayoffRound]
        call WriteLeagueHeader
.26:
        cmp dword [byte ebp-0Ch], byte 0
        sete al
        movzx eax, al
        jmp near SendGameResult_32D
;-----------------------------------------------------------------------------
; FinishLeagueGame                                AC369  97 PC, low confidence
; Finishes a league game
;-----------------------------------------------------------------------------
FinishLeagueGame:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        push eax
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .1
        cmp dword [SeasonActive], byte 0
        jne short .1
        imul eax, dword [SeasonDefaultUser], byte 1Ch
        mov edi, SeasonFileName
        mov esi, DbKeyBuffer
        xor ebx, ebx
        xor edx, edx
        mov ecx, dword [dword eax+SeasonUserReplay]
        mov eax, SeasonFileName
        movsd
        movsd
        call AddReplayIndexEntry
        mov esi, ecx
        mov eax, dword [SeasonUserTeam]
        shl esi, 4
        mov eax, dword [byte eax+020h]
        lea edi, [byte esi+eax+08h]
        mov esi, SeasonFileName
        mov edx, dword [byte ebp-04h]
        mov eax, ecx
        movsd
        movsd
        call CheckLeagueInjuries
        jmp short .2
.1:
        movzx eax, byte [PlayoffUserIndex]
        imul eax, byte 1Ch
        xor ebx, ebx
        xor edx, edx
        mov ecx, dword [dword eax+PlayoffUserReplay]
        mov eax, SeasonFileName
        call AddReplayIndexEntry
        mov eax, dword [SeasonUserTeam]
        shl ecx, 4
        mov esi, dword [byte eax+020h]
        lea edi, [byte ecx+esi+08h]
        mov esi, SeasonFileName
        movsd
        movsd
.2:
        call SaveGameResults
        mov eax, dword [SeasonUserTeam]
        call WriteLeagueHeader
        jmp near SendGameResult_32D
