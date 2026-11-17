; Pre-game screens: matchup, stats panel, rosters and notes.
bits 32
%include "hockey.inc"
section s_D15FB progbits alloc exec nowrite align=1
extern AgeFromBirthDate, AllocMemBlock, AllStarDay, AutoLineData, AwayBackupGoalie, AwayCenterIndex, AwayDefenceIndex, AwayDefencePartner
extern AwayGoalieIndex, AwayPlayerRecords, AwayRosterData, AwaySlotRatings, AwayWingIndex, BlankMenuItem, BlitArt, BlitConverted
extern BlitShape, BlitShape2, ClearScreen, ConvertArtNew, ConvertArtXY, CreateBitmap, DrawArt, DrawPortrait
extern DrawRosterPanelBox, DrawScreenBackground, DrawShape, DrawShapeBlended, DrawSpriteScaledBy, DrawTextAligned, ExitScreen, FadeInScreen
extern FindGameRecord, FindPlayerRecord, FindShape, FindShapeList, FindShapeQuiet, FindTeamRecord, FreeBitmap, FreeDbBlock
extern FreeExhibitionFile, FreeMemBlock, FreeTempArt, FrontMusicOn, GameOptionFlags, GameSettings, GetLangText, HomeBackupGoalie
extern HomeCenterIndex, HomeCityName, HomeDefenceIndex, HomeDefencePartner, HomeGoalieIndex, homelines, HomePlayerRecords, HomeRosterData
extern HomeSlotRatings, HomeWingIndex, InitMenuItems, IsAllStarDay, KeysEqual, LoadDataFile, LoadExhibitionFile, LoadFrontEndSfx
extern LoadLogoNames, MakeColor, MatchupAnimDone, MatchupArt, MatchupArtBuffer, MatchupAwayBar, MatchupAwayStats, MatchupBitmap
extern MatchupHomeBar, MatchupHomeGoalie, MatchupHomeLine, MatchupHomeStats, MatchupLastSpeech, MatchupLayer, MatchupLayout, MatchupLeftRegion
extern MatchupLeftSide, MatchupLeftSlots, MatchupMusicOn, MatchupNote, MatchupNoteBuffer, MatchupNoteCount, MatchupNoteFormats, MatchupNoteLength
extern MatchupNoteLine, MatchupNotes, MatchupNoteText, MatchupPanelBottom, MatchupPanelRects, MatchupPlayerCount, MatchupPlayerLayers, MatchupPlayers
extern MatchupPortraitDrawn, MatchupPortraitLayers, MatchupPortraitShown, MatchupRightRegions, MatchupRightSlotArt, MatchupRightSlots, MatchupRightSlotShape, MatchupRightSlotText
extern MatchupShapeFile, MatchupSparkleFrame, MatchupSparkleOn, MatchupSparkleShapes, MatchupSparkleTick, MatchupSpeechDone, MatchupStatRows, MatchupStatsArt
extern MatchupStatsFile, MatchupStatsLayer, MatchupStatsWidth, MatchupStatsX, MatchupStatsY, memset_, MenuScreenBitmap, MusicEnabled
extern OpenArtArchive, OpenArtArchiveErr, OpenDataLibrary, OpenLeagueFile, OpenResourceArchive, PaEvent, PlayerInjuryDays, PlayMenuSfx
extern PlayoffColumns, PlayoffDbKey, PlayoffRoundBits, PlayoffStatsPath, PlayoffTeamNames, PlayoffTeams, PlayoffUserIndex, PlaySfx
extern PresentScreen, rand_, Random32, ReadTeamStats, ResetStreamAudio, RosterInfoLines, RostersShapeLists, RostersSparkleCount
extern RostersSparkleFrame, RostersSparkleShapes, RostersSparkleTick, RunMenu, ScreenFrameItem, ScreenTitleItem, SeasonActive, SeasonDbKey
extern SeasonDefaultUser, SeasonFilePath, SeasonStatsPath, SeasonUserReplay, SeasonUserTeam, SecondsToSamples, ServiceIdle, SetDrawTarget
extern SetScreenTarget, SetTextColor, ShowScreen, sprintf_, StopAllSfx, str_000010, str_00009, str_002dFSH
extern str_03dLFSH, str_03dRFSH, str_199293, str_199495, str_199596, str_ANA, str_Awaystats, str_Barasso
extern str_Beaupre, str_Blurb, str_BOS, str_Brodeur, str_BUF, str_Burke, str_CAL, str_Carey
extern str_CHI, str_COL, str_D_DrawMatchupStats, str_DAL, str_DD5, str_DET, str_DOOR, str_DSS3
extern str_EA, str_EASports, str_EDM, str_FART4, str_FDPD, str_Fichaud, str_FIR1, str_FIRD
extern str_FLA, str_Flaherty, str_FRNT, str_Fuhr, str_G0LWC0RWLDRD, str_GSTS, str_Hackett, str_Hebert
extern str_Hextall, str_Heyward, str_HFD, str_Hirsch, str_Homestats, str_Hros, str_Hrudey, str_Jablonski
extern str_Joseph, str_Kidd, str_Kolzig, str_LA_GoalieMaskList, str_Lacher, str_LOGO02dFSH2, str_LOGO28FSH, str_LOGO7
extern str_Moog, str_MTL, str_NJ_GoalieMaskList, str_NOFACEFSH4, str_NYI_GoalieMaskList, str_NYR_GoalieMaskList, str_OTT, str_PANL2
extern str_PHI, str_PIT, str_PortraitNotFound, str_PSTS, str_QUE, str_Richter, str_Roster4, str_Roy
extern str_S_DrawMatchupNotes, str_SDD, str_SDDD, str_SDSD2, str_SJ_GoalieMaskList, str_SS12, str_SS13, str_SSS2
extern str_SSS3, str_ST02d, str_STAR, str_STL, str_SVsSDDD, str_TB_GoalieMaskList, str_Thibault, str_TITL12
extern str_TITL13, str_TRM1, str_TXT1, str_TXTD, str_VAN, str_Vanbiesbrouck, str_Vernon, str_Vros
extern str_WAS, str_Xx00xx01xx02xx03xx10xx11xx12, strcpy_, tickcount, TintPortrait, WaitShortDelay, WaitSoundTime, WipeScreen
global LayoutMatchupLeft, LayoutMatchupLeft_1E9, LayoutMatchupRight, PreGameMatchupScreenJumpTable, PreGameMatchupScreen, PreGameMatchupScreen_4E0, PreGameMatchupScreen_4EC, PreGameMatchupScreen_516
global PreGameMatchupScreen_522, PreGameMatchupScreen_658, DrawMatchupStats, DrawPlayerPortrait, DrawMatchupPlayer, PreGameStatsPanel, PreGameStatsPanel_4DF, PreGameStatsPanel_4E0
global FreeMatchupScreen, ReadMatchupStats, MatchupBarLength, LoadMatchupArt, MatchupSparkle, AnimateMatchup, MatchupNotesBlankRect, MatchupNotesBlankPos
global MatchupNotesBlankSize, RostersSparkle, PreGameRostersScreenJumpTable, PreGameRostersScreen, PreGameRostersScreen_B6A, PreGameRostersScreen_BA7, PreGameRostersScreen_BB5, PreGameRostersScreen_BC3
global PreGameRostersScreen_C3F, FormatMatchupNote, DrawRosterPlayerInfo, DrawMatchupHistory, DrawMatchupHistory_FB, DrawMatchupHistory_FC, DrawRosterLabel, DrawMatchupNotesJumpTable
global DrawMatchupNotes, DrawMatchupNotes_86, DrawMatchupNotes_C5, DrawMatchupNotes_10F, DrawMatchupNotes_14B, FindMatchupNotes, CountTeamResults, MatchupAnnouncement
global GoalieMaskList
;-----------------------------------------------------------------------------
; LayoutMatchupLeft                               D15FB  97 PC, low confidence
; Lays out the left side of the matchup screen
;-----------------------------------------------------------------------------
LayoutMatchupLeft:
        push ebx
        push ecx
        push esi
        push edi
        enter 104h, 0
        mov edi, eax
        mov ebx, edx
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .3
        cmp dword [SeasonActive], byte 0
        je short .2
.1:
        mov dword [MatchupLeftSide], 0
        mov dword [MatchupLayout], 3
        jmp short .4
.2:
        mov dword [MatchupLeftSide], 0
        mov dword [MatchupLayout], 2
        jmp short .4
.3:
        cmp eax, byte 20h
        je short .1
        mov dword [MatchupLeftSide], 1
        mov dword [MatchupLayout], 0
.4:
        xor eax, eax
        mov dword [byte ebp-04h], eax
.5:
        xor esi, esi
.6:
        mov edx, esi
        shl edx, 6
        mov cl, byte [byte ebp-04h]
        add edx, eax
        add cl, 31h
        mov byte [dword edx+ebp-0104h], 39h
        inc esi
        mov byte [dword edx+ebp-0101h], cl
        cmp esi, byte 4
        jl short .6
        add eax, byte 4
        mov byte [dword eax+ebp-0C7h], 36h
        mov byte [dword eax+ebp-087h], 37h
        mov byte [byte eax+ebp-047h], 37h
        mov byte [dword eax+ebp-0106h], 53h
        mov byte [dword eax+ebp-0C6h], 50h
        mov byte [dword eax+ebp-086h], 53h
        mov byte [byte eax+ebp-046h], 50h
        inc dword [byte ebp-04h]
        mov byte [dword eax+ebp-0107h], 36h
        cmp dword [byte ebp-04h], byte 4
        jl short .5
        xor esi, esi
.7:
        mov edx, esi
        shl edx, 6
        add edx, eax
        inc esi
        mov byte [dword edx+ebp-0104h], 0
        cmp esi, byte 4
        jl short .7
        xor esi, esi
.8:
        mov eax, esi
        shl eax, 4
        add eax, MatchupLeftSlots
        push eax
        mov eax, esi
        lea edx, [dword ebp-0104h]
        shl eax, 6
        add eax, edx
        push eax
        push edi
        inc esi
        call FindShapeList
        add esp, byte 0Ch
        cmp esi, byte 4
        jl short .8
        mov eax, dword [MatchupLayout]
        shl eax, 4
        mov eax, dword [dword eax+MatchupLeftSlots]
        movsx eax, word [byte eax+0Ch]
        mov dword [byte ebx+026h], eax
        mov eax, dword [MatchupLayout]
        shl eax, 4
        mov eax, dword [dword eax+MatchupLeftSlots]
        movsx eax, word [byte eax+0Eh]
        mov dword [byte ebx+02Ah], eax
        mov eax, dword [MatchupLayout]
        shl eax, 4
        mov eax, dword [dword eax+MatchupLeftSlots]
        mov dword [byte ebx+01Ah], eax
        mov eax, dword [MatchupLayout]
        shl eax, 4
        mov eax, dword [dword eax+MatchupLeftSlots+4]
        mov dword [byte ebx+01Eh], eax
        mov eax, dword [MatchupLayout]
        shl eax, 4
        mov eax, dword [dword eax+MatchupLeftSlots]
        mov dword [byte ebx+010h], 4
        mov dword [byte ebx+022h], eax
        mov eax, dword [MatchupLayout]
        shl eax, 4
        mov eax, dword [dword eax+MatchupLeftSlots]
        movsx edx, word [byte eax+0Ch]
        mov dword [MatchupLeftRegion], edx
        movsx edx, word [byte eax+0Eh]
        mov dword [MatchupLeftRegion+4], edx
        mov esi, dword [MatchupLeftRegion]
        movsx edx, word [byte eax+04h]
        add edx, esi
        mov dword [MatchupLeftRegion+8], edx
        mov edx, dword [MatchupLeftRegion+4]
        mov dword [MatchupLeftRegion+0Ch], edx
        mov edx, dword [MatchupLeftRegion+8]
        mov dword [MatchupLeftRegion+10h], edx
        movsx edx, word [byte eax+06h]
        mov eax, dword [MatchupLeftRegion+4]
        add eax, edx
        mov dword [MatchupLeftRegion+18h], esi
        mov dword [MatchupLeftRegion+14h], eax
        mov dword [MatchupLeftRegion+1Ch], eax
        mov dword [byte ebx+014h], MatchupLeftRegion
LayoutMatchupLeft_1E9:
        leave
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LayoutMatchupRight                              D17EA  97 PC, low confidence
; Lays out the right side of the matchup screen
;-----------------------------------------------------------------------------
LayoutMatchupRight:
        push ebx
        push ecx
        push esi
        push edi
        enter 30h, 0
        push eax
        push edx
        mov ecx, 1Dh
        lea edi, [byte ebp-030h]
        mov esi, str_Xx00xx01xx02xx03xx10xx11xx12
        rep movsb
        lea edi, [byte ebp-010h]
        mov esi, str_G0LWC0RWLDRD
        movsd
        movsd
        movsd
        movsb
        xor esi, esi
.1:
        xor eax, eax
.2:
        add eax, byte 4
        mov bl, byte [byte ebp+esi*2-010h]
        mov dl, byte [byte ebp+esi*2-0Fh]
        mov byte [byte eax+ebp-034h], bl
        mov byte [byte eax+ebp-033h], dl
        cmp eax, byte 1Ch
        jl short .2
        imul ebx, esi, byte 1Ch
        mov eax, MatchupRightSlots
        add eax, ebx
        push eax
        lea eax, [byte ebp-030h]
        push eax
        push dword [byte ebp-034h]
        call FindShapeList
        imul edx, esi, byte 52h
        add edx, dword [byte ebp-038h]
        mov eax, dword [dword ebx+MatchupRightSlots]
        mov dword [byte edx+01Ah], eax
        mov eax, dword [dword ebx+MatchupRightSlotShape]
        mov dword [byte edx+01Eh], eax
        mov eax, dword [dword ebx+MatchupRightSlotText]
        mov dword [byte edx+022h], eax
        mov eax, dword [dword ebx+MatchupRightSlots]
        movsx eax, word [byte eax+0Ch]
        mov dword [byte edx+026h], eax
        mov eax, dword [dword ebx+MatchupRightSlots]
        movsx eax, word [byte eax+0Eh]
        mov dword [byte edx+010h], 4
        mov dword [byte edx+02Ah], eax
        mov eax, esi
        mov ebx, dword [dword ebx+MatchupRightSlots]
        shl eax, 6
        movsx ecx, word [byte ebx+0Ch]
        mov dword [dword eax+MatchupRightRegions], ecx
        movsx ecx, word [byte ebx+0Eh]
        mov dword [dword eax+MatchupRightRegions+4], ecx
        movsx ecx, word [byte ebx+04h]
        add ecx, dword [dword eax+MatchupRightRegions]
        mov dword [dword eax+MatchupRightRegions+8], ecx
        mov ecx, dword [dword eax+MatchupRightRegions+4]
        mov dword [dword eax+MatchupRightRegions+0Ch], ecx
        mov ecx, dword [dword eax+MatchupRightRegions+8]
        mov dword [dword eax+MatchupRightRegions+10h], ecx
        movsx ebx, word [byte ebx+06h]
        add ebx, dword [dword eax+MatchupRightRegions+4]
        mov dword [dword eax+MatchupRightRegions+14h], ebx
        mov ebx, dword [dword eax+MatchupRightRegions]
        mov dword [dword eax+MatchupRightRegions+18h], ebx
        mov ebx, dword [dword eax+MatchupRightRegions+14h]
        add esp, byte 0Ch
        mov dword [dword eax+MatchupRightRegions+1Ch], ebx
        add eax, MatchupRightRegions
        inc esi
        mov dword [byte edx+014h], eax
        cmp esi, byte 6
        jl near .1
        mov dword [MatchupAnimDone], 0
        jmp near LayoutMatchupLeft_1E9
PreGameMatchupScreenJumpTable:                  ; jump table for the switch cases of PreGameMatchupScreen
        dd PreGameMatchupScreen_4E0
        dd PreGameMatchupScreen_4EC
        dd PreGameMatchupScreen_522
        dd PreGameMatchupScreen_516
;-----------------------------------------------------------------------------
; PreGameMatchupScreen                            D1927  96 PC, low confidence
; Pre-game screen 1: the matchup with the home and away pictures (H%07d /
; A%07d .FSH, pal.fsh); the announcer's team pair call (PaEvent 8)
;-----------------------------------------------------------------------------
PreGameMatchupScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 354h, 0
        sub ebp, 82h
        mov dword [byte ebp+07Eh], 0
        mov dword [byte ebp+076h], 0
        mov dword [byte ebp+072h], 0
        cmp byte [FrontMusicOn], 0
        je short .1
        call FreeTempArt
        call MusicEnabled
.1:
        mov dword [MatchupMusicOn], 0
        mov eax, 3
        mov dword [MatchupSpeechDone], 0
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 22h
        call LoadDataFile
        mov dword [MatchupShapeFile], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 23h
        call LoadDataFile
        mov dword [MatchupStatsFile], eax
        mov eax, dword [MatchupShapeFile]
        lea edx, [dword ebp-02D2h]
        call LoadMatchupArt
        mov eax, 0Ah
        call InitMenuItems
        lea edx, [dword ebp-02D2h]
        mov eax, dword [MatchupStatsFile]
        call LayoutMatchupRight
        lea edx, [dword ebp-0E6h]
        mov eax, dword [MatchupStatsFile]
        call LayoutMatchupLeft
        push str_TITL12
        push dword [MatchupStatsFile]
        call FindShape
        add esp, byte 8
        push str_PANL2
        push dword [MatchupShapeFile]
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push str_PANL2
        push dword [MatchupShapeFile]
        mov esi, eax
        call FindShape
        add esp, byte 8
        mov edx, esi
        call DrawScreenBackground
        mov ecx, 52h
        lea edi, [dword ebp-094h]
        mov esi, ScreenTitleItem
        rep movsb
        mov ecx, 52h
        lea edi, [byte ebp-042h]
        mov esi, BlankMenuItem
        mov dword [dword ebp-094h], 7
        lea eax, [dword ebp-02D2h]
        rep movsb
        push byte 0
        mov ecx, 52h
        lea edi, [byte ebp+010h]
        mov esi, ScreenFrameItem
        mov dword [byte ebp-042h], 8
        push dword 1E0h
        rep movsb
        push dword 280h
        mov dword [byte ebp+010h], 9
        mov dword [MatchupBitmap], eax
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [MatchupLayer], eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        call ClearScreen
        add esp, byte 4
        push str_00009
        push dword [MatchupShapeFile]
        call FindShape
        add esp, byte 8
        movsx edx, word [byte eax+0Eh]
        push edx
        movsx edx, word [byte eax+0Ch]
        push edx
        push eax
        call DrawArt
        add esp, byte 0Ch
        push str_PANL2
        push dword [MatchupShapeFile]
        call FindShape
        add esp, byte 8
        movsx edx, word [byte eax+0Eh]
        push edx
        movsx edx, word [byte eax+0Ch]
        push edx
        push eax
        call DrawArt
        add esp, byte 0Ch
        push str_TITL12
        push dword [MatchupStatsFile]
        call FindShape
        add esp, byte 8
        movsx edx, word [byte eax+0Eh]
        push edx
        movsx edx, word [byte eax+0Ch]
        push edx
        push eax
        call BlitArt
        add esp, byte 0Ch
        mov eax, 38h
        call OpenDataLibrary
        mov eax, dword [GameOptionFlags]
        mov ebx, dword [byte eax+01h]
        shl ebx, 0Ch
        shr ebx, 1Ah
        push ebx
        push str_03dLFSH
        lea eax, [byte ebp+062h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push byte 0
        lea eax, [byte ebp+062h]
        push eax
        call OpenArtArchiveErr
        add esp, byte 8
        mov ebx, eax
        lea eax, [byte ebp+062h]
        push eax
        push ebx
        mov byte [byte ebp+066h], 0
        call FindShape
        add esp, byte 8
        push byte 3Eh
        push byte 0
        push eax
        call DrawArt
        add esp, byte 0Ch
        push ebx
        call FreeMemBlock
        mov eax, dword [GameOptionFlags]
        mov ebx, dword [byte eax+01h]
        shl ebx, 6
        add esp, byte 4
        shr ebx, 1Ah
        push ebx
        push str_03dRFSH
        lea eax, [byte ebp+062h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push byte 0
        lea eax, [byte ebp+062h]
        push eax
        call OpenArtArchiveErr
        add esp, byte 8
        mov ebx, eax
        lea eax, [byte ebp+062h]
        push eax
        push ebx
        mov byte [byte ebp+066h], 0
        call FindShape
        add esp, byte 8
        push byte 1Eh
        push dword 16Dh
        push eax
        call DrawArt
        add esp, byte 0Ch
        push ebx
        call FreeMemBlock
        mov dword [MatchupNoteBuffer], 0
        mov eax, dword [MatchupArtBuffer]
        add esp, byte 4
        xor ebx, ebx
        mov dword [dword ebp-02B0h], eax
        mov dword [dword ebp-02B4h], eax
        mov dword [dword ebp-02B8h], eax
.2:
        imul eax, ebx, byte 52h
        cmp dword [dword eax+ebp-02B8h], byte 0
        je short .3
        push dword [dword eax+ebp-02A8h]
        push dword [dword eax+ebp-02ACh]
        push dword [dword eax+ebp-02B8h]
        call DrawArt
        add esp, byte 0Ch
.3:
        inc ebx
        cmp ebx, byte 0Ah
        jl short .2
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, dword [MatchupLayer]
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte eax+02Ch]
        call WipeScreen
        push dword [MatchupLayer]
        call FreeBitmap
        add esp, byte 4
        call PreGameStatsPanel
        push dword 0B0000002h
        mov ebx, 7
        call PaEvent
        add esp, byte 4
        xor edx, edx
        mov eax, dword [MatchupNoteBuffer]
.4:
        call DrawMatchupPlayer
        jmp near PreGameMatchupScreen_522.16
.5:
        cmp dword [byte ebp+072h], byte 5
        ja near .9
        mov eax, dword [MatchupNoteBuffer]
        cmp eax, dword [byte ebp+072h]
        je near PreGameMatchupScreen_522.16
        imul ebx, eax, byte 1Ch
        imul eax, byte 52h
        mov edx, dword [dword ebx+MatchupRightSlots]
        mov dword [dword eax+ebp-02B8h], edx
        imul ebx, dword [MatchupNoteBuffer], byte 1Ch
        imul eax, dword [MatchupNoteBuffer], byte 52h
        mov edx, dword [dword ebx+MatchupRightSlotShape]
        mov dword [dword eax+ebp-02B4h], edx
        imul ebx, dword [MatchupNoteBuffer], byte 1Ch
        imul eax, dword [MatchupNoteBuffer], byte 52h
        mov edx, dword [dword ebx+MatchupRightSlotText]
        mov dword [dword eax+ebp-02B0h], edx
        call SetScreenTarget
        imul eax, dword [MatchupNoteBuffer], byte 52h
        push dword [dword eax+ebp-02B8h]
        call BlitShape
        add esp, byte 4
        call PresentScreen
        imul ebx, dword [byte ebp+072h], byte 1Ch
        imul eax, dword [byte ebp+072h], byte 52h
        mov edx, dword [dword ebx+MatchupArtBuffer]
        mov dword [dword eax+ebp-02B0h], edx
        mov dword [dword eax+ebp-02B4h], edx
        xor ebx, ebx
        mov dword [dword eax+ebp-02B8h], edx
.6:
        mov eax, dword [tickcount]
        add eax, byte 9
        mov dword [MatchupAnimDone], eax
        call SetScreenTarget
        imul edx, dword [byte ebp+072h], byte 1Ch
        mov eax, ebx
        push dword [dword edx+eax*4+MatchupRightSlotArt]
        call BlitShape
        imul edx, dword [MatchupNoteBuffer], byte 1Ch
        mov eax, 5
        add esp, byte 4
        sub eax, ebx
        push dword [dword edx+eax*4+MatchupRightSlots]
        call BlitShape
        add esp, byte 4
        call PresentScreen
.7:
        mov eax, dword [tickcount]
        cmp eax, dword [MatchupAnimDone]
        jge short .8
        call SetScreenTarget
        call MatchupSparkle
        call PresentScreen
        call ServiceIdle
        jmp short .7
.8:
        inc ebx
        cmp ebx, byte 2
        jl short .6
        call SetScreenTarget
        imul eax, dword [MatchupNoteBuffer], byte 52h
        push dword [dword eax+ebp-02B8h]
        call BlitShape
        add esp, byte 4
        mov ebx, 7
        call PresentScreen
        mov eax, dword [byte ebp+072h]
        xor edx, edx
        mov dword [MatchupNoteBuffer], eax
        jmp near .4
.9:
        mov eax, dword [MatchupLeftSide]
        mov dword [MatchupLayout], eax
        cmp eax, byte 3
        ja short PreGameMatchupScreen_522.12
        jmp dword [nosplit cs:eax*4+PreGameMatchupScreenJumpTable]
PreGameMatchupScreen_4E0:
        mov dword [MatchupLeftSide], 1
        jmp short PreGameMatchupScreen_522.13
PreGameMatchupScreen_4EC:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .10
        mov dword [MatchupLeftSide], 2
        jmp short PreGameMatchupScreen_522.13
.10:
        cmp eax, byte 20h
        jne short PreGameMatchupScreen_516
.11:
        mov dword [MatchupLeftSide], 3
        jmp short PreGameMatchupScreen_522.13
PreGameMatchupScreen_516:
        mov dword [MatchupLeftSide], 0
        jmp short PreGameMatchupScreen_522.13
PreGameMatchupScreen_522:
        cmp dword [SeasonActive], byte 0
        jne short PreGameMatchupScreen_4EC.11
        jmp short PreGameMatchupScreen_516
.12:
        mov dword [MatchupLeftSide], 1
        mov dword [MatchupLayout], 0
.13:
        mov ebx, dword [MatchupLayout]
        shl ebx, 4
        mov eax, dword [dword ebx+MatchupLeftSlots]
        mov dword [dword ebp-0CCh], eax
        mov eax, dword [dword ebx+MatchupLeftSlots+4]
        mov dword [dword ebp-0C8h], eax
        mov eax, dword [dword ebp-0CCh]
        mov dword [dword ebp-0C4h], eax
        call SetScreenTarget
        push dword [dword ebp-0CCh]
        call BlitShape
        add esp, byte 4
        mov ebx, 4
        call PresentScreen
        mov eax, dword [MatchupNoteBuffer]
        xor edx, edx
        jmp near PreGameMatchupScreen.4
.14:
        call ShowScreen
        mov dword [byte ebp+07Ah], 13h
        mov dword [byte ebp+076h], 1
.15:
        mov dword [byte ebp+07Eh], edx
.16:
        cmp dword [byte ebp+07Eh], byte 0
        jne short .19
        push byte 3
        lea eax, [byte ebp+072h]
        mov ecx, AnimateMatchup
        mov ebx, 0FFFFFFFFh
        lea edx, [dword ebp-02D2h]
        push eax
        mov eax, 0Ah
        mov dword [byte ebp+07Ah], 4
        call RunMenu
        cmp dword [byte ebp+072h], byte 7
        jb near PreGameMatchupScreen.5
        mov edx, dword [byte ebp+07Eh]
        inc edx
        cmp dword [byte ebp+072h], byte 7
        jbe short .14
        cmp dword [byte ebp+072h], byte 8
        jbe short .17
        cmp dword [byte ebp+072h], byte 9
        je short .18
        jmp short .16
.17:
        call FadeInScreen
        mov dword [byte ebp+07Ah], 15h
        jmp short .15
.18:
        call ExitScreen
        jmp short .16
.19:
        push byte 0
        call OpenResourceArchive
        add esp, byte 4
        call FreeMatchupScreen
        push dword [MatchupStatsFile]
        call FreeMemBlock
        add esp, byte 4
        push dword [MatchupShapeFile]
        call FreeMemBlock
        add esp, byte 4
        cmp dword [byte ebp+076h], byte 0
        je short .20
        cmp byte [FrontMusicOn], 0
        je short .20
        call LoadLogoNames
        call LoadFrontEndSfx
.20:
        mov eax, dword [byte ebp+07Ah]
PreGameMatchupScreen_658:
        lea esp, [dword ebp+082h]
        pop ebp
        jmp near PreGameStatsPanel_4E0
;-----------------------------------------------------------------------------
; DrawMatchupStats                                D1F8B  97 PC, low confidence
; Draws the matchup stats
;-----------------------------------------------------------------------------
DrawMatchupStats:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 8Ch, 0
        sub ebp, 82h
        imul edx, dword [MatchupLayout], byte 6
        add edx, eax
        imul edx, byte 3Dh
        mov ecx, 3Dh
        mov esi, dword [MatchupAwayStats]
        lea edi, [byte ebp+036h]
        add esi, edx
        rep movsb
        mov ecx, 3Dh
        mov esi, dword [MatchupHomeStats]
        lea edi, [byte ebp-0Ah]
        add esi, edx
        rep movsb
        test eax, eax
        jne near .5
        push dword [MatchupStatsLayer]
        call SetDrawTarget
        add esp, byte 4
        push str_GSTS
        push dword [MatchupStatsFile]
        call FindShape
        add esp, byte 8
        push byte 0
        mov ebx, eax
        mov eax, dword [MatchupStatsArt]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        movsx eax, word [byte ebx+0Eh]
        add esp, byte 0Ch
        sub eax, dword [MatchupStatsY]
        push eax
        movsx eax, word [byte ebx+0Ch]
        sub eax, dword [MatchupStatsX]
        push eax
        push ebx
        call BlitArt
        mov eax, dword [MatchupStatsLayer]
        mov eax, dword [byte eax+02Ch]
        movsx eax, word [byte eax+06h]
        add eax, byte 0Ah
        mov ebx, 5
        cdq
        idiv ebx
        add esp, byte 0Ch
        mov edi, eax
        movsx eax, word [byte ebp+04Eh]
        push eax
        push str_D_DrawMatchupStats
        push byte 0
        mov esi, 1Ah
        push esi
        push byte 1
        movsx ebx, word [byte ebp+066h]
        call DrawTextAligned
        mov eax, ebx
        mov ecx, 64h
        cdq
        idiv ecx
        imul edx, eax, byte 64h
        sub ebx, edx
        add esp, byte 14h
        mov edx, ebx
        push edx
        push eax
        push str_DD5
        mov ebx, edi
        push ebx
        push esi
        push byte 1
        call DrawTextAligned
        add esp, byte 18h
        cmp word [byte ebp+068h], byte 0
        jne short .1
        xor eax, eax
        xor edx, edx
        jmp short .2
.1:
        movsx eax, word [byte ebp+06Ah]
        imul eax, dword 3E8h
        movsx ecx, word [byte ebp+068h]
        cdq
        idiv ecx
        mov dword [byte ebp+07Eh], 0Ah
        mov ecx, eax
        cdq
        idiv dword [byte ebp+07Eh]
        imul edx, eax, byte 0Ah
        mov dword [byte ebp+07Eh], edx
        mov edx, ecx
        sub edx, dword [byte ebp+07Eh]
.2:
        push edx
        push eax
        push str_DD5
        add ebx, edi
        push ebx
        push esi
        push byte 1
        call DrawTextAligned
        add esp, byte 18h
        movsx eax, word [byte ebp+056h]
        push eax
        push str_D_DrawMatchupStats
        add ebx, edi
        push ebx
        push esi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        movsx eax, word [byte ebp+0Eh]
        push eax
        push str_D_DrawMatchupStats
        mov esi, dword [MatchupStatsWidth]
        push byte 0
        sub esi, byte 1Ah
        push esi
        push byte 1
        movsx ebx, word [byte ebp+026h]
        call DrawTextAligned
        mov eax, ebx
        mov ecx, 64h
        cdq
        idiv ecx
        imul edx, eax, byte 64h
        sub ebx, edx
        add esp, byte 14h
        mov edx, ebx
        push edx
        push eax
        push str_DD5
        push edi
        push esi
        push byte 1
        mov ebx, edi
        call DrawTextAligned
        add esp, byte 18h
        cmp word [byte ebp+028h], byte 0
        jne short .3
        xor eax, eax
        xor edx, edx
        jmp short .4
.3:
        movsx eax, word [byte ebp+02Ah]
        imul eax, dword 3E8h
        movsx ecx, word [byte ebp+028h]
        cdq
        idiv ecx
        mov dword [byte ebp+07Eh], 0Ah
        mov ecx, eax
        cdq
        idiv dword [byte ebp+07Eh]
        imul edx, eax, byte 0Ah
        mov dword [byte ebp+07Eh], edx
        mov edx, ecx
        sub edx, dword [byte ebp+07Eh]
.4:
        push edx
        push eax
        push str_DD5
        add ebx, edi
        push ebx
        push esi
        push byte 1
        call DrawTextAligned
        add esp, byte 18h
        movsx eax, word [byte ebp+016h]
        push eax
        push str_D_DrawMatchupStats
        add ebx, edi
        push ebx
        jmp near .6
.5:
        push dword [MatchupStatsLayer]
        call SetDrawTarget
        add esp, byte 4
        push str_PSTS
        push dword [MatchupStatsFile]
        call FindShape
        add esp, byte 8
        push byte 0
        mov ebx, eax
        mov eax, dword [MatchupStatsArt]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        movsx eax, word [byte ebx+0Eh]
        add esp, byte 0Ch
        sub eax, dword [MatchupStatsY]
        push eax
        movsx eax, word [byte ebx+0Ch]
        sub eax, dword [MatchupStatsX]
        push eax
        push ebx
        call BlitArt
        mov eax, dword [MatchupStatsLayer]
        mov eax, dword [byte eax+02Ch]
        movsx eax, word [byte eax+06h]
        add eax, byte 0Ah
        mov ebx, 5
        cdq
        idiv ebx
        add esp, byte 0Ch
        mov edi, eax
        movsx eax, word [byte ebp+04Eh]
        push eax
        push str_D_DrawMatchupStats
        push byte 0
        push byte 1Ah
        push byte 1
        call DrawTextAligned
        mov eax, edi
        add esp, byte 14h
        mov dword [byte ebp+076h], eax
        movsx eax, word [byte ebp+050h]
        push eax
        push str_D_DrawMatchupStats
        push edi
        push byte 1Ah
        push byte 1
        call DrawTextAligned
        mov eax, edi
        add eax, edi
        add esp, byte 14h
        mov dword [byte ebp+07Ah], eax
        movsx eax, word [byte ebp+052h]
        push eax
        push str_D_DrawMatchupStats
        push dword [byte ebp+07Ah]
        push byte 1Ah
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        movsx eax, word [byte ebp+05Eh]
        push eax
        mov ebx, dword [byte ebp+07Ah]
        push str_D_DrawMatchupStats
        add ebx, edi
        push ebx
        push byte 1Ah
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        movsx eax, word [byte ebp+05Ah]
        push eax
        push str_D_DrawMatchupStats
        add edi, ebx
        push edi
        push byte 1Ah
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        movsx eax, word [byte ebp+0Eh]
        push eax
        push str_D_DrawMatchupStats
        mov esi, dword [MatchupStatsWidth]
        push byte 0
        sub esi, byte 1Ah
        push esi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        movsx eax, word [byte ebp+010h]
        push eax
        push str_D_DrawMatchupStats
        push dword [byte ebp+076h]
        push esi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        movsx eax, word [byte ebp+012h]
        push eax
        push str_D_DrawMatchupStats
        push dword [byte ebp+07Ah]
        push esi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        movsx eax, word [byte ebp+01Eh]
        push eax
        push str_D_DrawMatchupStats
        push ebx
        push esi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        movsx eax, word [byte ebp+01Ah]
        push eax
        push str_D_DrawMatchupStats
        push edi
.6:
        push esi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        jmp near PreGameMatchupScreen_658
;-----------------------------------------------------------------------------
; DrawPlayerPortrait                              D230A  97 PC, low confidence
; Pre-game: the player's portrait (0%02d.FSH, NOFACE.FSH, "Portrait not
; found") and "#%d  %s %s"
;-----------------------------------------------------------------------------
DrawPlayerPortrait:
        push ebx
        push ecx
        push esi
        push edi
        enter 24h, 0
        mov esi, eax
        mov edi, edx
        mov ebx, eax
        mov eax, edx
        shl ebx, 5
        shl eax, 2
        add ebx, eax
        mov dword [byte ebp-04h], 1
        cmp dword [dword ebx+MatchupPortraitDrawn], byte 0
        jne near .10
        push dword [dword ebx+MatchupPortraitLayers]
        call SetDrawTarget
        add esp, byte 4
        test edi, edi
        jne short .1
        mov edx, esi
        shl edx, 2
        cmp dword [dword edx+MatchupPortraitShown], byte 0
        je short .1
        mov eax, 0F8h
        call OpenDataLibrary
        push dword [dword edx+MatchupPortraitShown]
        push str_002dFSH
        lea ebx, [byte ebp-024h]
        push ebx
        call sprintf_
        add esp, byte 0Ch
        mov edx, str_FRNT
        lea eax, [byte ebp-014h]
        jmp short .2
.1:
        imul edx, esi, byte 18h
        mov eax, 37h
        call OpenDataLibrary
        mov eax, edi
        mov ebx, dword [dword edx+eax*4+MatchupPlayers]
        mov edx, str_FART4
        lea eax, [byte ebp-014h]
        add ebx, byte 27h
.2:
        call strcpy_
        cmp byte [ebx], 0
        jne short .3
        mov eax, 37h
        mov edx, str_NOFACEFSH4
        call OpenDataLibrary
        lea eax, [byte ebp-024h]
        call strcpy_
        mov edx, str_FART4
        lea eax, [byte ebp-014h]
        lea ebx, [byte ebp-024h]
        call strcpy_
.3:
        cmp byte [ebx], 0
        je near .8
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push byte 0
        push ebx
        call OpenArtArchive
        add esp, byte 8
        mov dword [byte ebp-0Ch], eax
        test eax, eax
        je short .6
        lea edx, [byte ebp-014h]
        push edx
        push eax
        call FindShapeQuiet
        mov dword [byte ebp-08h], eax
        add esp, byte 8
        test eax, eax
        je short .4
        push byte 0
        push byte 0
        push eax
        mov ebx, edi
        call DrawArt
        mov eax, esi
        shl ebx, 2
        shl eax, 5
        add ebx, eax
        mov edx, dword [dword ebx+MatchupPortraitLayers]
        mov eax, dword [dword eax+MatchupPortraitLayers+18h]
        add esp, byte 0Ch
        mov edx, dword [byte edx+02Ch]
        mov eax, dword [byte eax+02Ch]
        call TintPortrait
        mov eax, dword [dword ebx+MatchupPortraitLayers]
        xor ecx, ecx
        mov edx, dword [byte eax+02Ch]
        xor ebx, ebx
        mov eax, dword [byte ebp-08h]
        call DrawPortrait
        jmp short .5
.4:
        mov dword [byte ebp-04h], eax
.5:
        push dword [byte ebp-0Ch]
        call FreeMemBlock
        add esp, byte 4
        jmp short .7
.6:
        mov dword [byte ebp-04h], eax
.7:
        cmp dword [byte ebp-04h], byte 0
        jne short .9
        push str_PortraitNotFound
        push byte 28h
        push byte 0
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        jmp short .9
.8:
        mov dword [byte ebp-04h], 1
.9:
        mov edx, esi
        mov eax, edi
        shl edx, 5
        mov dword [dword edx+eax*4+MatchupPortraitDrawn], 1
.10:
        cmp dword [byte ebp-04h], byte 0
        je short .11
        mov eax, esi
        shl eax, 5
        push dword [dword eax+edi*4+MatchupPlayerLayers]
        call SetDrawTarget
        imul edx, esi, byte 18h
        mov edx, dword [dword edx+edi*4+MatchupPlayers]
        add esp, byte 4
        lea eax, [byte edx+08h]
        push eax
        lea eax, [byte edx+018h]
        push eax
        movzx eax, byte [dword edx+0BCh]
        push eax
        shl esi, 4
        push str_DSS3
        mov eax, dword [dword esi+MatchupPanelRects+28h]
        push byte 0
        sar eax, 1
        push eax
        push byte 1
        call DrawTextAligned
        add esp, byte 1Ch
.11:
        mov eax, dword [byte ebp-04h]
        jmp near LayoutMatchupLeft_1E9
;-----------------------------------------------------------------------------
; DrawMatchupPlayer                               D24F8  97 PC, low confidence
; Draws a matchup player
;-----------------------------------------------------------------------------
DrawMatchupPlayer:
        push ecx
        push esi
        push edi
        enter 10h, 0
        mov edi, eax
        mov dword [byte ebp-010h], edx
        mov dword [byte ebp-08h], ebx
        test byte [byte ebp-08h], 3
        je short .1
        mov edx, eax
        xor eax, eax
        call DrawPlayerPortrait
        mov eax, 1
        mov edx, edi
        call DrawPlayerPortrait
.1:
        test byte [byte ebp-08h], 4
        je short .2
        mov eax, edi
        call DrawMatchupStats
.2:
        mov edx, dword [byte ebp-010h]
        mov eax, dword [tickcount]
        add edx, eax
        mov dword [byte ebp-0Ch], edx
        test byte [byte ebp-08h], 3
        je near .6
        mov dword [byte ebp-04h], 2
.3:
        mov esi, edi
        mov eax, dword [MatchupPortraitLayers+1Ch]
        shl esi, 2
        mov ebx, dword [byte eax+02Ch]
        mov eax, dword [dword esi+MatchupPortraitLayers]
        mov edx, dword [byte eax+02Ch]
        mov eax, dword [MatchupHomeBar]
        mov eax, dword [nosplit eax*4+MatchupPortraitLayers]
        mov ecx, dword [byte ebp-04h]
        mov eax, dword [byte eax+02Ch]
        call MatchupBarLength
        mov eax, dword [MatchupPortraitLayers+3Ch]
        mov ebx, dword [byte eax+02Ch]
        mov eax, dword [dword esi+MatchupPortraitLayers+20h]
        mov edx, dword [byte eax+02Ch]
        mov eax, dword [MatchupAwayBar]
        mov eax, dword [nosplit eax*4+MatchupPortraitLayers+20h]
        mov ecx, dword [byte ebp-04h]
        mov eax, dword [byte eax+02Ch]
        call MatchupBarLength
        test byte [byte ebp-04h], 2
        je short .4
        call ServiceIdle
        mov eax, dword [MatchupPlayerLayers+1Ch]
        mov ebx, dword [byte eax+02Ch]
        mov eax, dword [dword esi+MatchupPlayerLayers]
        mov edx, dword [byte eax+02Ch]
        mov eax, dword [MatchupHomeBar]
        mov eax, dword [nosplit eax*4+MatchupPlayerLayers]
        mov ecx, dword [byte ebp-04h]
        mov eax, dword [byte eax+02Ch]
        call MatchupBarLength
        mov eax, dword [MatchupPlayerLayers+3Ch]
        mov ebx, dword [byte eax+02Ch]
        mov eax, dword [dword esi+MatchupPlayerLayers+20h]
        mov edx, dword [byte eax+02Ch]
        mov eax, dword [MatchupAwayBar]
        mov eax, dword [nosplit eax*4+MatchupPlayerLayers+20h]
        mov ecx, dword [byte ebp-04h]
        mov eax, dword [byte eax+02Ch]
        call MatchupBarLength
.4:
        call ServiceIdle
        mov eax, dword [tickcount]
        cmp eax, dword [byte ebp-0Ch]
        jl short .4
        mov eax, dword [byte ebp-010h]
        add dword [byte ebp-0Ch], eax
        call SetScreenTarget
        mov eax, dword [MatchupPortraitLayers+1Ch]
        push dword [byte eax+02Ch]
        call BlitShape
        mov eax, dword [MatchupPortraitLayers+3Ch]
        add esp, byte 4
        push dword [byte eax+02Ch]
        call BlitShape
        add esp, byte 4
        test byte [byte ebp-04h], 2
        je short .5
        call ServiceIdle
        mov eax, dword [MatchupPlayerLayers+1Ch]
        push dword [byte eax+02Ch]
        call BlitShape
        mov eax, dword [MatchupPlayerLayers+3Ch]
        add esp, byte 4
        push dword [byte eax+02Ch]
        call BlitShape
        add esp, byte 4
.5:
        call MatchupSparkle
        add dword [byte ebp-04h], byte 2
        call PresentScreen
        cmp dword [byte ebp-04h], byte 20h
        jl near .3
.6:
        call SetScreenTarget
        test byte [byte ebp-08h], 3
        je short .8
        mov dword [byte ebp-04h], 0
.7:
        mov esi, dword [byte ebp-04h]
        mov eax, edi
        shl esi, 5
        shl eax, 2
        add esi, eax
        mov eax, dword [dword esi+MatchupPortraitLayers]
        push dword [byte eax+02Ch]
        call BlitShape
        add esp, byte 4
        mov eax, dword [dword esi+MatchupPlayerLayers]
        push dword [byte eax+02Ch]
        call BlitShape
        mov eax, dword [byte ebp-04h]
        add esp, byte 4
        inc dword [byte ebp-04h]
        mov dword [nosplit eax*4+MatchupHomeBar], edi
        cmp dword [byte ebp-04h], byte 2
        jl short .7
.8:
        test byte [byte ebp-08h], 4
        je short .9
        mov eax, dword [MatchupStatsLayer]
        push dword [byte eax+02Ch]
        call BlitShape
        add esp, byte 4
.9:
        call PresentScreen
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; PreGameStatsPanel                               D26EE  97 PC, low confidence
; From PreGameMatchupScreen: the "homestats" / "awaystats" comparison panel
;-----------------------------------------------------------------------------
PreGameStatsPanel:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 8, 0
        push dword 0FF00FFh
        call MakeColor
        add esp, byte 4
        push dword 0FF00h
        mov ebx, eax
        call MakeColor
        mov edx, eax
        shl edx, 10h
        sar eax, 5
        or edx, ebx
        shl ebx, 0Bh
        or ebx, eax
        movzx eax, byte [HomeGoalieIndex]
        imul eax, dword 125h
        mov dword [MatchupHomeGoalie], edx
        mov edx, HomePlayerRecords
        add edx, eax
        movzx eax, byte [HomeCenterIndex]
        imul eax, dword 125h
        mov dword [MatchupPlayers+4], edx
        mov edx, HomePlayerRecords
        add edx, eax
        movzx eax, byte [HomeWingIndex]
        imul eax, dword 125h
        mov dword [MatchupPlayers+8], edx
        mov edx, HomePlayerRecords
        add edx, eax
        movzx eax, byte [HomeDefenceIndex]
        imul eax, dword 125h
        mov dword [MatchupPlayers+0Ch], edx
        mov edx, HomePlayerRecords
        add edx, eax
        movzx eax, byte [HomeDefencePartner]
        imul eax, dword 125h
        add esp, byte 4
        mov dword [MatchupPlayers+10h], edx
        mov edx, HomePlayerRecords
        mov dword [MatchupHomeLine], ebx
        add edx, eax
        movzx eax, byte [HomeBackupGoalie]
        mov dword [MatchupPlayers+14h], edx
        cmp eax, byte 19h
        jl short .1
        sub eax, byte 19h
.1:
        imul edx, eax, dword 125h
        mov ebx, HomeRosterData+1B94h
        add ebx, edx
        movsx eax, word [nosplit eax*2+HomeSlotRatings]
        mov dword [MatchupPlayers], ebx
        cmp eax, byte 64h
        jge short .2
        cmp eax, byte 31h
        je short .2
        mov dword [MatchupPortraitShown], eax
        jmp short .3
.2:
        mov dword [MatchupPortraitShown], 0
.3:
        movzx eax, byte [AwayGoalieIndex]
        imul eax, dword 125h
        mov edx, AwayPlayerRecords
        add edx, eax
        movzx eax, byte [AwayCenterIndex]
        imul eax, dword 125h
        mov dword [MatchupPlayers+1Ch], edx
        mov edx, AwayPlayerRecords
        add edx, eax
        movzx eax, byte [AwayWingIndex]
        imul eax, dword 125h
        mov dword [MatchupPlayers+20h], edx
        mov edx, AwayPlayerRecords
        add edx, eax
        movzx eax, byte [AwayDefenceIndex]
        imul eax, dword 125h
        mov dword [MatchupPlayers+24h], edx
        mov edx, AwayPlayerRecords
        add edx, eax
        movzx eax, byte [AwayDefencePartner]
        imul eax, dword 125h
        mov dword [MatchupPlayers+28h], edx
        mov edx, AwayPlayerRecords
        add edx, eax
        movzx eax, byte [AwayBackupGoalie]
        mov dword [MatchupPlayers+2Ch], edx
        cmp eax, byte 19h
        jl short .4
        sub eax, byte 19h
.4:
        imul edx, eax, dword 125h
        mov ebx, AwayRosterData+1B94h
        add ebx, edx
        movsx eax, word [nosplit eax*2+AwaySlotRatings]
        mov dword [MatchupPlayers+18h], ebx
        cmp eax, byte 64h
        jge short .5
        cmp eax, byte 31h
        je short .5
        mov dword [MatchupPlayerCount], eax
        jmp short .6
.5:
        mov dword [MatchupPlayerCount], 0
.6:
        push byte 0
        push dword 5B8h
        push str_Homestats
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 5B8h
        push str_Awaystats
        mov ebx, 5B8h
        mov dword [MatchupAwayStats], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [MatchupHomeStats], eax
        xor edx, edx
        mov eax, dword [MatchupAwayStats]
        call memset_
        mov ebx, 5B8h
        mov eax, dword [MatchupHomeStats]
        xor edx, edx
        call memset_
        mov ebx, PlayoffDbKey
        mov edx, dword [MatchupHomeStats]
        mov eax, dword [MatchupAwayStats]
        call ReadMatchupStats
        mov ebx, SeasonDbKey
        mov edx, dword [MatchupHomeStats]
        mov eax, dword [MatchupAwayStats]
        add edx, 16Eh
        add eax, 16Eh
        call ReadMatchupStats
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .7
        mov ebx, SeasonFilePath
        mov edx, dword [MatchupHomeStats]
        mov eax, dword [MatchupAwayStats]
        add edx, 2DCh
        add eax, 2DCh
        call ReadMatchupStats
        cmp dword [SeasonActive], byte 0
        je short .9
        mov ebx, SeasonStatsPath
        jmp short .8
.7:
        cmp eax, byte 20h
        jne short .9
        mov ebx, PlayoffStatsPath
.8:
        mov edx, dword [MatchupHomeStats]
        mov eax, dword [MatchupAwayStats]
        add edx, 44Ah
        add eax, 44Ah
        call ReadMatchupStats
.9:
        xor edi, edi
.10:
        mov dword [byte ebp-04h], 0
.11:
        mov esi, dword [byte ebp-04h]
        push byte 0
        mov eax, edi
        mov ebx, edi
        shl eax, 5
        shl esi, 2
        shl ebx, 4
        mov dword [byte ebp-08h], eax
        push dword [dword ebx+MatchupPanelRects+0Ch]
        add esi, eax
        push dword [dword ebx+MatchupPanelRects+8]
        mov dword [dword esi+MatchupPortraitDrawn], 0
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push dword [dword ebx+MatchupPanelRects+2Ch]
        push dword [dword ebx+MatchupPanelRects+28h]
        mov dword [dword esi+MatchupPortraitLayers], eax
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [dword esi+MatchupPlayerLayers], eax
        cmp dword [byte ebp-04h], byte 0
        jne short .12
        call SetScreenTarget
        push dword [dword ebx+MatchupPanelRects+4]
        mov eax, dword [dword esi+MatchupPortraitLayers]
        push dword [dword ebx+MatchupPanelRects]
        push dword [byte eax+02Ch]
        call ConvertArtXY
        add esp, byte 0Ch
        push dword [dword ebx+MatchupPanelRects+24h]
        mov eax, dword [dword esi+MatchupPlayerLayers]
        push dword [dword ebx+MatchupPanelRects+20h]
        push dword [byte eax+02Ch]
        call ConvertArtXY
        add esp, byte 0Ch
        call PresentScreen
        jmp near .13
.12:
        push dword [dword esi+MatchupPortraitLayers]
        call SetDrawTarget
        add esp, byte 4
        mov eax, dword [byte ebp-08h]
        push byte 0
        mov eax, dword [dword eax+MatchupPortraitLayers]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        mov eax, dword [dword esi+MatchupPortraitLayers]
        mov eax, dword [byte eax+02Ch]
        mov dx, word [dword ebx+MatchupPanelRects]
        mov word [byte eax+0Ch], dx
        mov eax, dword [dword esi+MatchupPortraitLayers]
        mov eax, dword [byte eax+02Ch]
        mov dx, word [dword ebx+MatchupPanelRects+4]
        add esp, byte 0Ch
        mov word [byte eax+0Eh], dx
        push dword [dword esi+MatchupPlayerLayers]
        call SetDrawTarget
        add esp, byte 4
        mov eax, dword [byte ebp-08h]
        push byte 0
        mov eax, dword [dword eax+MatchupPlayerLayers]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        mov eax, dword [dword esi+MatchupPlayerLayers]
        mov eax, dword [byte eax+02Ch]
        mov dx, word [dword ebx+MatchupPanelRects+20h]
        mov word [byte eax+0Ch], dx
        mov eax, dword [dword esi+MatchupPlayerLayers]
        mov eax, dword [byte eax+02Ch]
        mov dx, word [dword ebx+MatchupPanelRects+24h]
        add esp, byte 0Ch
        mov word [byte eax+0Eh], dx
.13:
        inc dword [byte ebp-04h]
        call ServiceIdle
        cmp dword [byte ebp-04h], byte 8
        jl near .11
        inc edi
        mov dword [nosplit edi*4+MatchupStatRows], 6
        cmp edi, byte 2
        jl near .10
        push str_PSTS
        push dword [MatchupStatsFile]
        call FindShape
        movsx edx, word [byte eax+0Ch]
        sub edx, byte 24h
        mov dword [MatchupStatsX], edx
        movsx edx, word [byte eax+0Eh]
        sub edx, byte 4
        mov dword [MatchupStatsY], edx
        movsx edx, word [byte eax+04h]
        add edx, byte 48h
        mov dword [MatchupStatsWidth], edx
        movsx eax, word [byte eax+06h]
        xor edi, edi
        add eax, byte 8
        add esp, byte 8
        mov dword [MatchupPanelBottom], eax
.14:
        push byte 0
        push dword [MatchupPanelBottom]
        push dword [MatchupStatsWidth]
        call CreateBitmap
        mov dword [nosplit edi*4+MatchupStatsLayer], eax
        mov ebx, dword [byte eax+02Ch]
        mov dx, word [MatchupStatsX]
        mov word [byte ebx+0Ch], dx
        mov eax, dword [nosplit edi*4+MatchupStatsLayer]
        inc edi
        mov eax, dword [byte eax+02Ch]
        mov dx, word [MatchupStatsY]
        add esp, byte 0Ch
        mov word [byte eax+0Eh], dx
        cmp edi, byte 2
        jl short .14
        call SetScreenTarget
        push dword [MatchupStatsY]
        mov eax, dword [MatchupStatsArt]
        push dword [MatchupStatsX]
        push dword [byte eax+02Ch]
        call ConvertArtXY
        add esp, byte 0Ch
        call PresentScreen
PreGameStatsPanel_4DF:
        leave
PreGameStatsPanel_4E0:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FreeMatchupScreen                               D2BD4  97 PC, low confidence
; Frees the matchup screen
;-----------------------------------------------------------------------------
FreeMatchupScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        xor ebx, ebx
.1:
        xor edi, edi
.2:
        mov esi, ebx
        mov eax, edi
        shl esi, 5
        shl eax, 2
        add esi, eax
        push dword [dword esi+MatchupPortraitLayers]
        mov dword [dword esi+MatchupPortraitDrawn], 0
        call FreeBitmap
        add esp, byte 4
        push dword [dword esi+MatchupPlayerLayers]
        inc edi
        call FreeBitmap
        add esp, byte 4
        cmp edi, byte 8
        jl short .2
        inc ebx
        cmp ebx, byte 2
        jl short .1
        xor ebx, ebx
.3:
        xor edi, edi
        imul esi, ebx, byte 18h
.4:
        mov eax, edi
        inc edi
        mov dword [dword esi+eax*4+MatchupPlayers], 0
        cmp edi, byte 6
        jl short .4
        inc ebx
        cmp ebx, byte 2
        jl short .3
        push dword [MatchupStatsLayer]
        call FreeBitmap
        add esp, byte 4
        push dword [MatchupStatsArt]
        call FreeBitmap
        add esp, byte 4
        push dword [MatchupAwayStats]
        call FreeMemBlock
        add esp, byte 4
        push dword [MatchupHomeStats]
        call FreeMemBlock
        add esp, byte 4
        jmp near PreGameStatsPanel_4E0
;-----------------------------------------------------------------------------
; ReadMatchupStats                                D2C78  97 PC, low confidence
; Reads the matchup team stats
;-----------------------------------------------------------------------------
ReadMatchupStats:
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        push eax
        push edx
        mov esi, ebx
        mov edi, 1
        xor ecx, ecx
.1:
        imul ebx, ecx, byte 3Dh
        mov eax, esi
        mov edx, dword [nosplit ecx*4+MatchupPlayers]
        add ebx, dword [byte ebp-04h]
        call ReadTeamStats
        test eax, eax
        jne short .2
        xor edi, edi
.2:
        imul ebx, ecx, byte 3Dh
        mov eax, esi
        mov edx, dword [nosplit ecx*4+MatchupPlayers+18h]
        add ebx, dword [byte ebp-08h]
        call ReadTeamStats
        test eax, eax
        jne short .3
        xor edi, edi
.3:
        inc ecx
        cmp ecx, byte 6
        jl short .1
        mov eax, edi
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; MatchupBarLength                                D2CCA  97 PC, low confidence
; Works out the length of a matchup bar
;-----------------------------------------------------------------------------
MatchupBarLength:
        push esi
        push edi
        enter 28h, 0
        mov esi, edx
        mov edi, ebx
        mov edx, 20h
        sub edx, ecx
        mov dword [byte ebp-010h], edx
        movsx edx, word [byte eax+04h]
        mov dword [byte ebp-024h], edx
        movsx edx, word [byte eax+06h]
        imul edx, dword [byte ebp-024h]
        shr edx, 1
        lea ebx, [byte esi+010h]
        mov dword [byte ebp-028h], edx
        lea edx, [byte eax+010h]
        mov esi, dword [byte ebp-028h]
        lea eax, [byte edi+010h]
        shl esi, 2
        lea edi, [edx+esi]
        mov esi, dword [MatchupHomeGoalie]
        mov dword [byte ebp-08h], esi
        mov esi, dword [MatchupHomeLine]
        mov dword [byte ebp-04h], esi
        shl esi, 5
        mov dword [byte ebp-01Ch], edi
        mov dword [byte ebp-018h], esi
.1:
        cmp edx, dword [byte ebp-01Ch]
        jae short .3
        mov edi, dword [ebx]
        mov esi, dword [edx]
        mov dword [byte ebp-0Ch], edi
        add edx, byte 4
        lea edi, [byte eax+04h]
        add ebx, byte 4
        mov dword [byte ebp-014h], edi
        cmp esi, dword [byte ebp-0Ch]
        jne short .2
        mov dword [eax], esi
        mov eax, edi
        jmp short .1
.2:
        mov edi, esi
        sar edi, 5
        and edi, dword [byte ebp-04h]
        imul edi, dword [byte ebp-010h]
        mov dword [byte ebp-024h], edi
        mov edi, dword [byte ebp-0Ch]
        sar edi, 5
        and edi, dword [byte ebp-04h]
        imul edi, ecx
        mov dword [byte ebp-020h], edi
        mov edi, dword [byte ebp-024h]
        add edi, dword [byte ebp-020h]
        and edi, dword [byte ebp-018h]
        and esi, dword [byte ebp-08h]
        mov dword [byte ebp-020h], edi
        mov edi, dword [byte ebp-010h]
        imul edi, esi
        mov esi, dword [byte ebp-0Ch]
        and esi, dword [byte ebp-08h]
        imul esi, ecx
        add esi, edi
        sar esi, 5
        and esi, dword [byte ebp-08h]
        or esi, dword [byte ebp-020h]
        mov dword [eax], esi
        mov eax, dword [byte ebp-014h]
        jmp short .1
.3:
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; LoadMatchupArt                                  D2D94  97 PC, low confidence
; Loads the matchup art
;-----------------------------------------------------------------------------
LoadMatchupArt:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 10h, 0
        mov edi, eax
        mov dword [MatchupSparkleOn], 1
        mov dword [MatchupSparkleFrame], 0
        xor esi, esi
.1:
        lea ebx, [byte esi+01h]
        push ebx
        push str_ST02d
        lea eax, [byte ebp-010h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-010h]
        push eax
        push edi
        call FindShape
        add esp, byte 8
        mov dword [nosplit esi*4+MatchupSparkleShapes], eax
        mov esi, ebx
        cmp ebx, byte 17h
        jl short .1
        mov eax, dword [tickcount]
        mov dword [MatchupSparkleTick], eax
        jmp near PreGameStatsPanel_4DF
        push ecx
        push edx
        cmp dword [MatchupArt], byte 0
        je short .2
        push dword [MatchupArt]
        call FreeMemBlock
        add esp, byte 4
.2:
        mov dword [MatchupArt], 0
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; MatchupSparkle                                  D2E1A  97 PC, low confidence
; Draws a random matchup sparkle with a sound
;-----------------------------------------------------------------------------
MatchupSparkle:
        push ecx
        push edx
        mov eax, dword [tickcount]
        cmp eax, dword [MatchupSparkleTick]
        jbe near .5
        mov eax, dword [tickcount]
        add eax, byte 0Ah
        mov dword [MatchupSparkleTick], eax
        mov eax, dword [MatchupSparkleOn]
        add dword [MatchupSparkleFrame], eax
        add eax, byte 16h
        cmp eax, dword [MatchupSparkleFrame]
        jne short .1
        cmp byte [FrontMusicOn], 0
        jne short .1
        mov eax, 207h
        call PlaySfx
.1:
        cmp dword [MatchupSparkleFrame], byte 17h
        jb short .2
        call Random32
        and eax, byte 1
        mov dword [MatchupSparkleFrame], eax
        call Random32
        and eax, byte 1
        inc eax
        mov dword [MatchupSparkleOn], eax
        jmp short .4
.2:
        cmp dword [MatchupSparkleFrame], byte 16h
        je short .3
        cmp dword [MatchupSparkleFrame], byte 15h
        jne short .4
        cmp dword [MatchupSparkleOn], byte 2
        jne short .4
.3:
        call Random32
        and eax, byte 0Fh
        imul eax, byte 0Ah
        mov dword [MatchupSparkleFrame], 16h
        add dword [MatchupSparkleTick], eax
.4:
        mov eax, dword [MatchupSparkleFrame]
        push dword [nosplit eax*4+MatchupSparkleShapes]
        call DrawShape
        add esp, byte 4
.5:
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; AnimateMatchup                                  D2ED6  97 PC, low confidence
; Animates the matchup screen
;-----------------------------------------------------------------------------
AnimateMatchup:
        push ebx
        push ecx
        push edx
        call MatchupSparkle
        mov eax, dword [tickcount]
        cmp eax, dword [MatchupAnimDone]
        jle near .6
        mov dword [MatchupSpeechDone], 0
        xor ebx, ebx
.1:
        imul edx, ebx, byte 52h
        mov eax, dword [MatchupBitmap]
        cmp dword [byte edx+eax+04h], byte 1
        jne short .3
        cmp ebx, dword [MatchupNoteBuffer]
        je short .3
        call Random32
        mov ecx, 3
        xor edx, edx
        div ecx
        cmp edx, dword [MatchupLastSpeech]
        jl short .2
        inc edx
.2:
        imul eax, ebx, byte 1Ch
        imul ecx, ebx, byte 52h
        mov dword [MatchupLastSpeech], edx
        shl edx, 2
        add edx, eax
        mov eax, dword [MatchupBitmap]
        mov edx, dword [dword edx+MatchupRightSlots]
        mov dword [byte ecx+eax+01Eh], edx
        mov edx, dword [MatchupBitmap]
        push dword [byte ecx+edx+02Ah]
        push dword [byte ecx+edx+026h]
        push dword [byte ecx+edx+01Eh]
        call BlitArt
        mov dword [MatchupSpeechDone], 1
        add esp, byte 0Ch
.3:
        inc ebx
        cmp ebx, byte 6
        jl short .1
        mov edx, dword [MatchupBitmap]
        cmp dword [dword edx+01F0h], byte 1
        jne short .5
        call Random32
        mov ebx, 3
        xor edx, edx
        div ebx
        cmp edx, dword [MatchupLastSpeech]
        jl short .4
        inc edx
.4:
        mov ebx, dword [MatchupLayout]
        mov dword [MatchupLastSpeech], edx
        mov eax, edx
        shl ebx, 4
        mov edx, dword [MatchupBitmap]
        mov eax, dword [dword ebx+eax*4+MatchupLeftSlots]
        mov dword [dword edx+020Ah], eax
        mov eax, dword [MatchupBitmap]
        push dword [dword eax+020Ah]
        call BlitShape
        mov dword [MatchupSpeechDone], 1
        add esp, byte 4
.5:
        mov eax, dword [tickcount]
        add eax, byte 4
        mov dword [MatchupAnimDone], eax
.6:
        cmp dword [MatchupMusicOn], byte 0
        je short .7
        cmp dword [MatchupSpeechDone], byte 0
        jne short .7
        mov eax, 309h
        call PlayMenuSfx
        mov dword [MatchupMusicOn], 0
.7:
        cmp dword [MatchupMusicOn], byte 0
        jne short .8
        cmp dword [MatchupSpeechDone], byte 0
        je short .8
        mov eax, 309h
        call PlaySfx
        mov dword [MatchupMusicOn], 1
.8:
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
MatchupNotesBlankRect:                          ; used by DrawMatchupNotes
        db 00h,00h,00h,00h,00h,00h,00h,00h
MatchupNotesBlankPos:                           ; used by DrawMatchupNotes
        db 00h,00h,00h,00h,00h,00h,00h,00h
MatchupNotesBlankSize:                          ; used by DrawMatchupNotes
        db 00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; RostersSparkle                                  D306F  97 PC, low confidence
; Draws a random sparkle on the rosters screen
;-----------------------------------------------------------------------------
RostersSparkle:
        push ebx
        push ecx
        push edx
        mov eax, dword [tickcount]
        cmp eax, dword [RostersSparkleTick]
        jle near .4
        xor ebx, ebx
.1:
        call rand_
        movzx ecx, byte [RostersSparkleCount]
        cdq
        idiv ecx
        mov eax, edx
        imul edx, ebx, byte 14h
        push dword [dword edx+eax*4+RostersShapeLists]
        call BlitShape2
        inc ebx
        add esp, byte 4
        cmp ebx, byte 4
        jl short .1
        mov eax, dword [tickcount]
        add eax, byte 0Ah
        mov ecx, dword [RostersSparkleFrame]
        mov dword [RostersSparkleTick], eax
.2:
        cmp ecx, dword [RostersSparkleFrame]
        jne short .3
        call rand_
        movzx ebx, byte [RostersSparkleCount]
        cdq
        idiv ebx
        mov dword [RostersSparkleFrame], edx
        jmp short .2
.3:
        push dword 104h
        mov eax, dword [RostersSparkleFrame]
        push byte 4Bh
        mov eax, dword [nosplit eax*4+RostersSparkleShapes]
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
.4:
        pop edx
        pop ecx
        pop ebx
        ret
PreGameRostersScreenJumpTable:                  ; jump table for the switch cases of PreGameRostersScreen
        dd PreGameRostersScreen_B6A
        dd PreGameRostersScreen_BA7
        dd PreGameRostersScreen_BB5
        dd PreGameRostersScreen_BC3
;-----------------------------------------------------------------------------
; PreGameRostersScreen                            D3112  97 PC, low confidence
; Game screen 13h before play: the home and visitor rosters ("hros" /
; "vros"), the "blurb" and the star players (STAR, FIR1, F%dP%d)
;-----------------------------------------------------------------------------
PreGameRostersScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 1A0h, 0
        sub ebp, 82h
        mov dword [byte ebp+046h], 0
        cmp byte [FrontMusicOn], 0
        je short .1
        mov byte [RostersSparkleCount], 2
        jmp short .2
.1:
        mov byte [RostersSparkleCount], 5
.2:
        push byte 0
        push dword 194Fh
        push str_Hros
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 194Fh
        push str_Vros
        mov dword [byte ebp+072h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 4B0h
        xor esi, esi
        mov dword [MatchupNoteCount], 0
        push str_Blurb
        mov dword [MatchupNoteLength], 0
        mov dword [byte ebp+06Eh], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp+05Eh], eax
.3:
        imul eax, esi, byte 50h
        mov edx, dword [byte ebp+05Eh]
        inc esi
        add edx, eax
        mov dword [nosplit esi*4+RosterInfoLines], edx
        cmp esi, byte 0Fh
        jl short .3
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 3Ch
        call LoadDataFile
        mov ebx, eax
        mov dword [byte ebp+07Eh], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 3Dh
        call LoadDataFile
        mov dword [byte ebp+07Ah], eax
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push str_STAR
        push ebx
        call FindShape
        add esp, byte 8
        push byte 0
        movsx edx, word [byte eax+06h]
        mov dword [byte ebp+062h], eax
        push edx
        movsx eax, word [byte eax+04h]
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push str_FIR1
        mov dword [byte ebp+06Ah], eax
        lea eax, [byte ebp+03Ah]
        push eax
        call sprintf_
        add esp, byte 8
        lea eax, [byte ebp+03Ah]
        push eax
        push ebx
        call FindShape
        add esp, byte 8
        push byte 0
        movsx edx, word [byte eax+06h]
        push edx
        movsx eax, word [byte eax+04h]
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [byte ebp+066h], eax
        test byte [GameSettings], 70h
        jne short .4
        lea eax, [byte ebp+042h]
        call LoadExhibitionFile
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        imul eax, dword 194Fh
        mov esi, dword [byte ebp+042h]
        mov ecx, 194Fh
        mov edi, dword [byte ebp+072h]
        lea esi, [dword esi+eax+0DF4h]
        rep movsb
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        shr eax, 1Ah
        imul esi, eax, dword 194Fh
        add esi, dword [byte ebp+042h]
        mov ecx, 194Fh
        mov edi, dword [byte ebp+06Eh]
        lea esi, [dword esi+0DF4h]
        rep movsb
        jmp near .10
.4:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne near .6
        call IsAllStarDay
        test eax, eax
        je short .5
        mov eax, dword [byte ebp+072h]
        mov ebx, 6
        mov edx, 19h
        add eax, byte 5Bh
        call memset_
        mov eax, dword [byte ebp+06Eh]
        mov ebx, 6
        mov edx, 19h
        add eax, byte 5Bh
        call memset_
        jmp near .10
.5:
        mov edx, dword [GameOptionFlags]
        mov edx, dword [byte edx+01h]
        shl edx, 0Ch
        mov eax, dword [SeasonUserTeam]
        shr edx, 1Ah
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        mov edx, dword [byte ebp+072h]
        call FindGameRecord
        mov edx, dword [GameOptionFlags]
        mov edx, dword [byte edx+01h]
        shl edx, 6
        mov eax, dword [SeasonUserTeam]
        shr edx, 1Ah
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        mov edx, dword [byte ebp+06Eh]
        call FindGameRecord
        jmp short .10
.6:
        xor esi, esi
.7:
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        cmp eax, dword [nosplit esi*4+PlayoffTeams]
        jne short .8
        mov edx, esi
        mov eax, dword [SeasonUserTeam]
        shl edx, 3
        mov eax, dword [byte eax+01Ch]
        add eax, edx
        mov edx, dword [byte ebp+072h]
        call FindGameRecord
.8:
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        shr eax, 1Ah
        cmp eax, dword [nosplit esi*4+PlayoffTeams]
        jne short .9
        mov edx, esi
        mov eax, dword [SeasonUserTeam]
        shl edx, 3
        mov eax, dword [byte eax+01Ch]
        add eax, edx
        mov edx, dword [byte ebp+06Eh]
        call FindGameRecord
.9:
        inc esi
        cmp esi, byte 10h
        jl short .7
.10:
        xor esi, esi
        jmp near .17
.11:
        xor edi, edi
.12:
        lea eax, [byte edi+05h]
        push eax
        lea eax, [byte esi+01h]
        push eax
        push str_FDPD
        mov dword [byte ebp+052h], eax
        lea eax, [byte ebp+03Ah]
        push eax
        call sprintf_
        add esp, byte 10h
        lea eax, [byte ebp+03Ah]
        push eax
        push dword [byte ebp+07Eh]
        call FindShape
        mov edx, eax
        imul eax, edi, byte 14h
        mov ebx, esi
        shl ebx, 2
        add esp, byte 8
        inc edi
        mov dword [dword ebx+eax+RostersShapeLists], edx
        cmp edi, byte 4
        jl short .12
        push dword [byte ebp+052h]
        push str_FIRD
        lea eax, [byte ebp+03Ah]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+03Ah]
        push eax
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push dword [byte ebp+066h]
        mov edi, eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        push byte 0
        push edi
        call BlitArt
        add esp, byte 0Ch
        push byte 0
        push dword 0C8h
        push dword 1EFh
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [dword ebx+RostersSparkleShapes], eax
        call SetDrawTarget
        add esp, byte 4
        push dword 0FFFFFF47h
        push byte 0FFFFFFB5h
        push str_000010
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push eax
        xor edi, edi
        call BlitArt
        add esp, byte 0Ch
.13:
        mov dword [byte ebp+076h], 0
.14:
        mov eax, dword [byte ebp+072h]
        add eax, byte 5Bh
        add eax, dword [byte ebp+076h]
        movzx edx, byte [eax]
        lea eax, [edi+edi*4]
        dec eax
        cmp edx, eax
        jle short .15
        imul eax, dword [byte ebp+076h], byte 1Eh
        mov dword [byte ebp+04Eh], eax
        push eax
        imul eax, edi, byte 1Bh
        mov edx, 6Eh
        sub edx, eax
        push edx
        mov ecx, dword [byte ebp+062h]
        mov ebx, dword [byte ebp+06Ah]
        push dword [byte ebp+04Eh]
        mov dword [byte ebp+04Ah], edx
        push edx
        mov eax, dword [nosplit esi*4+RostersSparkleShapes]
        mov edx, dword [byte ebp+066h]
        call DrawRosterPanelBox
        push dword [byte ebp+04Eh]
        mov eax, dword [byte ebp+06Ah]
        push dword [byte ebp+04Ah]
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
.15:
        mov eax, dword [byte ebp+06Eh]
        add eax, byte 5Bh
        add eax, dword [byte ebp+076h]
        movzx edx, byte [eax]
        lea eax, [edi+edi*4]
        dec eax
        cmp edx, eax
        jle short .16
        imul eax, dword [byte ebp+076h], byte 1Eh
        mov dword [byte ebp+04Eh], eax
        push eax
        imul eax, edi, byte 1Bh
        push eax
        mov ecx, dword [byte ebp+062h]
        mov ebx, dword [byte ebp+06Ah]
        push dword [byte ebp+04Eh]
        add eax, 168h
        mov edx, dword [byte ebp+066h]
        push eax
        mov dword [byte ebp+04Ah], eax
        mov eax, dword [nosplit esi*4+RostersSparkleShapes]
        call DrawRosterPanelBox
        push dword [byte ebp+04Eh]
        mov eax, dword [byte ebp+06Ah]
        push dword [byte ebp+04Ah]
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
.16:
        inc dword [byte ebp+076h]
        cmp dword [byte ebp+076h], byte 6
        jl near .14
        inc edi
        cmp edi, byte 5
        jl near .13
        inc esi
        push esi
        push str_TXTD
        lea eax, [byte ebp+03Ah]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+03Ah]
        push eax
        push dword [byte ebp+07Ah]
        call FindShape
        add esp, byte 8
        push str_DOOR
        push dword [byte ebp+07Eh]
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push str_TXT1
        push dword [byte ebp+07Ah]
        movsx edi, word [byte eax+04h]
        call FindShape
        movsx eax, word [byte eax+04h]
        sub edi, eax
        add esp, byte 8
        sar edi, 1
        push byte 1
        add edi, byte 7Dh
        push edi
        push ebx
        call BlitArt
        add esp, byte 0Ch
        push byte 1
        push str_TRM1
        push dword [byte ebp+07Eh]
        call FindShape
        mov edx, edi
        movsx eax, word [byte eax+04h]
        add esp, byte 8
        sub edx, eax
        push edx
        push str_TRM1
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        push byte 1
        push str_TXT1
        push dword [byte ebp+07Ah]
        call FindShape
        movsx eax, word [byte eax+04h]
        add esp, byte 8
        add edi, eax
        push edi
        push str_TRM1
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
.17:
        movzx eax, byte [RostersSparkleCount]
        cmp esi, eax
        jl near .11
        push dword [byte ebp+072h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+06Eh]
        call FreeMemBlock
        add esp, byte 4
        lea edx, [dword ebp-011Eh]
        mov eax, 4
        call InitMenuItems
        push str_000010
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push str_000010
        push dword [byte ebp+07Eh]
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push str_000010
        lea edi, [dword ebp-0CCh]
        push dword [byte ebp+07Eh]
        mov esi, eax
        call FindShape
        mov ecx, 52h
        add esp, byte 8
        mov edx, esi
        mov esi, BlankMenuItem
        call DrawScreenBackground
        rep movsb
        mov ecx, 52h
        lea edi, [byte ebp-07Ah]
        mov esi, ScreenTitleItem
        mov dword [dword ebp-0CCh], 1
        rep movsb
        push byte 0
        mov ecx, 52h
        lea edi, [byte ebp-028h]
        mov esi, ScreenFrameItem
        mov dword [byte ebp-07Ah], 2
        push dword 1E0h
        rep movsb
        push dword 280h
        mov dword [byte ebp-028h], 3
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov edi, eax
        call SetDrawTarget
        add esp, byte 4
        push byte 4Bh
        push byte 0
        push str_000010
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        push str_TITL13
        push dword [byte ebp+07Ah]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_DOOR
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+0Eh]
        push eax
        push str_TRM1
        push dword [byte ebp+07Eh]
        call FindShape
        mov edx, 140h
        movsx eax, word [byte eax+04h]
        add esp, byte 8
        sub edx, eax
        push edx
        push str_TRM1
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        push str_DOOR
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+0Eh]
        push eax
        push dword 140h
        push str_TRM1
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        mov eax, 39h
        call OpenDataLibrary
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        push eax
        push str_LOGO02dFSH2
        lea eax, [byte ebp+02Ah]
        push eax
        call sprintf_
        add esp, byte 0Ch
        push byte 0
        lea eax, [byte ebp+02Ah]
        push eax
        call OpenArtArchiveErr
        add esp, byte 8
        push dword [MenuScreenBitmap]
        push str_LOGO7
        push eax
        mov esi, eax
        call FindShape
        add esp, byte 8
        push eax
        call ConvertArtNew
        add esp, byte 8
        mov ebx, eax
        cmp byte [FrontMusicOn], 0
        jne short .18
        push byte 32h
        push byte 32h
        push eax
        push dword 0C000h
        call DrawShapeBlended
        jmp short .19
.18:
        push byte 32h
        push byte 32h
        push eax
        push dword 0C000h
        call DrawSpriteScaledBy
.19:
        add esp, byte 10h
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push esi
        call FreeMemBlock
        add esp, byte 4
        push ebx
        call FreeMemBlock
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        add esp, byte 4
        shr eax, 1Ah
        push eax
        push str_LOGO02dFSH2
        lea eax, [byte ebp+02Ah]
        push eax
        call sprintf_
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        and eax, 3F00000h
        add esp, byte 0Ch
        cmp eax, 1C00000h
        jne short .20
        push str_LOGO28FSH
        lea eax, [byte ebp+02Ah]
        push eax
        call sprintf_
        add esp, byte 8
.20:
        push byte 0
        lea eax, [byte ebp+02Ah]
        push eax
        call OpenArtArchiveErr
        add esp, byte 8
        push dword [MenuScreenBitmap]
        push str_LOGO7
        push eax
        mov esi, eax
        call FindShape
        add esp, byte 8
        push eax
        call ConvertArtNew
        add esp, byte 8
        mov ebx, eax
        cmp byte [FrontMusicOn], 0
        jne short .21
        push byte 32h
        push dword 190h
        push eax
        push dword 0C000h
        call DrawShapeBlended
        jmp short .22
.21:
        push byte 32h
        push dword 190h
        push eax
        push dword 0C000h
        call DrawSpriteScaledBy
.22:
        add esp, byte 10h
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push esi
        call FreeMemBlock
        add esp, byte 4
        push ebx
        mov esi, 1
        call FreeMemBlock
        add esp, byte 4
.23:
        imul eax, esi, byte 52h
        push dword [dword eax+ebp-0F4h]
        push dword [dword eax+ebp-0F8h]
        push dword [dword eax+ebp-0104h]
        inc esi
        call DrawArt
        add esp, byte 0Ch
        cmp esi, byte 3
        jl short .23
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        call IsAllStarDay
        test eax, eax
        jne short .24
        call DrawRosterPlayerInfo
.24:
        mov eax, dword [GameSettings]
        shl eax, 19h
        shr eax, 1Dh
        cmp eax, byte 1
        jb short .25
        jbe short .26
        jmp short .27
.25:
        test eax, eax
        jne short .27
        call DrawMatchupHistory
        jmp short .27
.26:
        call DrawMatchupNotes
.27:
        call DrawRosterLabel
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 202h
        call PlaySfx
        push dword 105h
        push dword 0C8h
        push str_DOOR
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push eax
        call BlitConverted
        add esp, byte 0Ch
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte edi+02Ch]
        call WipeScreen
        push edi
        call FreeBitmap
        add esp, byte 4
        push str_DOOR
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push byte 0
        movsx edx, word [byte eax+06h]
        mov ebx, eax
        push edx
        movsx eax, word [byte eax+04h]
        push eax
        mov esi, 1
        call CreateBitmap
        add esp, byte 0Ch
        mov edi, eax
        jmp near .30
.28:
        push byte 0
        push str_TXT1
        push dword [byte ebp+07Ah]
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+06h]
        push eax
        push esi
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [byte ebp+05Ah], eax
        call SetDrawTarget
        add esp, byte 4
        mov eax, dword [tickcount]
        cmp eax, dword [RostersSparkleTick]
        jle short .29
        mov eax, dword [tickcount]
        add eax, byte 0Ah
        inc dword [RostersSparkleFrame]
        mov dword [RostersSparkleTick], eax
        mov eax, dword [RostersSparkleFrame]
        movzx ecx, byte [RostersSparkleCount]
        cdq
        idiv ecx
        mov dword [RostersSparkleFrame], edx
.29:
        mov eax, dword [RostersSparkleFrame]
        inc eax
        push eax
        push str_TXTD
        lea eax, [byte ebp+03Ah]
        push eax
        call sprintf_
        add esp, byte 0Ch
        push byte 0
        push str_TXT1
        push dword [byte ebp+07Ah]
        call FindShape
        movsx eax, word [byte eax+04h]
        sub eax, esi
        sar eax, 1
        add esp, byte 8
        neg eax
        push eax
        lea eax, [byte ebp+03Ah]
        push eax
        push dword [byte ebp+07Ah]
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        push edi
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        push byte 0
        push ebx
        call BlitArt
        movsx eax, word [byte ebx+04h]
        add esp, byte 0Ch
        sub eax, esi
        push byte 0
        sar eax, 1
        push eax
        mov eax, dword [byte ebp+05Ah]
        push dword [byte eax+02Ch]
        call BlitArt
        movsx eax, word [byte ebx+04h]
        sub eax, esi
        add esp, byte 0Ch
        sar eax, 1
        push byte 0
        add eax, esi
        push eax
        push str_TRM1
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        movsx eax, word [byte ebx+04h]
        push byte 0
        sub eax, esi
        push str_TRM1
        sar eax, 1
        push dword [byte ebp+07Eh]
        mov dword [byte ebp+04Eh], eax
        call FindShape
        mov edx, dword [byte ebp+04Eh]
        movsx eax, word [byte eax+04h]
        add esp, byte 8
        sub edx, eax
        push edx
        push str_TRM1
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        push dword [byte ebp+05Ah]
        call FreeBitmap
        add esp, byte 4
        call SetScreenTarget
        push dword 105h
        push dword 0C8h
        push dword [byte edi+02Ch]
        call BlitArt
        add esp, byte 0Ch
        add esi, byte 6
        call PresentScreen
.30:
        push str_TXT1
        push dword [byte ebp+07Ah]
        call FindShape
        movsx eax, word [byte eax+04h]
        add esp, byte 8
        cmp esi, eax
        jl near .28
        call StopAllSfx
        mov eax, 203h
        call PlaySfx
        call MatchupAnnouncement
        cmp byte [RostersSparkleCount], 5
        jne near PreGameRostersScreen_B6A
        xor esi, esi
.31:
        mov eax, dword [RostersSparkleShapes]
        mov eax, dword [byte eax+02Ch]
        push byte 0
        movsx edx, word [byte eax+06h]
        push edx
        mov edx, dword [byte ebp+062h]
        mov ebx, 5
        movsx edx, word [byte edx+04h]
        sub ebx, esi
        add edx, edx
        imul edx, ebx
        movsx eax, word [byte eax+04h]
        sub eax, edx
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov ebx, eax
        call SetDrawTarget
        mov eax, dword [RostersSparkleShapes]
        mov eax, dword [byte eax+02Ch]
        movsx edx, word [byte eax+04h]
        mov eax, dword [byte ebx+02Ch]
        movsx eax, word [byte eax+04h]
        sub edx, eax
        mov eax, edx
        add esp, byte 4
        neg eax
        push byte 0
        sar eax, 1
        push eax
        call rand_
        movzx ecx, byte [RostersSparkleCount]
        cdq
        idiv ecx
        mov eax, dword [nosplit edx*4+RostersSparkleShapes]
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call SetScreenTarget
        mov eax, dword [RostersSparkleShapes]
        mov eax, dword [byte eax+02Ch]
        movsx eax, word [byte eax+04h]
        mov dword [byte ebp+04Eh], eax
        mov eax, dword [byte ebx+02Ch]
        mov ecx, dword [byte ebp+04Eh]
        movsx edx, word [byte eax+04h]
        sub ecx, edx
        mov edx, ecx
        sar edx, 1
        push dword 104h
        add edx, byte 4Bh
        push edx
        push eax
        call BlitArt
        add esp, byte 0Ch
        mov eax, 2
        call WaitShortDelay
        push ebx
        inc esi
        call FreeBitmap
        add esp, byte 4
        cmp esi, byte 5
        jl near .31
PreGameRostersScreen_B6A:
        cmp dword [byte ebp+046h], byte 1
        je short PreGameRostersScreen_BC3.32
        cmp dword [byte ebp+046h], byte 2
        je short PreGameRostersScreen_BC3.32
        push byte 3
        lea eax, [byte ebp+046h]
        mov ecx, RostersSparkle
        mov ebx, 0FFFFFFFFh
        push eax
        lea edx, [dword ebp-011Eh]
        mov eax, 4
        call RunMenu
        cmp dword [byte ebp+046h], byte 3
        ja short PreGameRostersScreen_B6A
        mov eax, dword [byte ebp+046h]
        jmp dword [nosplit cs:eax*4+PreGameRostersScreenJumpTable]
PreGameRostersScreen_BA7:
        call FadeInScreen
        mov dword [byte ebp+056h], 14h
        jmp short PreGameRostersScreen_B6A
PreGameRostersScreen_BB5:
        call ShowScreen
        mov dword [byte ebp+056h], 0Eh
        jmp short PreGameRostersScreen_B6A
PreGameRostersScreen_BC3:
        call ExitScreen
        jmp short PreGameRostersScreen_B6A
.32:
        push dword [byte ebp+07Ah]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+07Eh]
        xor esi, esi
        call FreeMemBlock
        jmp short .34
.33:
        push dword [nosplit esi*4+RostersSparkleShapes]
        call FreeBitmap
        inc esi
.34:
        add esp, byte 4
        movzx eax, byte [RostersSparkleCount]
        cmp esi, eax
        jl short .33
        push dword [byte ebp+06Ah]
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp+066h]
        call FreeBitmap
        add esp, byte 4
        push edi
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp+05Eh]
        call FreeMemBlock
        add esp, byte 4
        call ResetStreamAudio
        test byte [GameSettings], 70h
        jne short .35
        lea eax, [byte ebp+042h]
        call FreeExhibitionFile
.35:
        mov eax, dword [byte ebp+056h]
PreGameRostersScreen_C3F:
        lea esp, [dword ebp+082h]
        pop ebp
        jmp near DrawMatchupHistory_FC
;-----------------------------------------------------------------------------
; FormatMatchupNote                               D3D5D  97 PC, low confidence
; Formats a matchup note
;-----------------------------------------------------------------------------
FormatMatchupNote:
        push ecx
        push edx
        mov edx, eax
        cmp eax, dword [MatchupNoteLength]
        je near .6
        cmp eax, byte 2
        jb short .1
        jbe short .3
        cmp eax, byte 3
        je short .4
        jmp short .5
.1:
        cmp eax, byte 1
        jne short .5
        mov eax, 11h
.2:
        call GetLangText
        push eax
        mov eax, dword [MatchupNoteCount]
        push dword [nosplit eax*4+MatchupNoteFormats]
        call sprintf_
        add esp, byte 8
        jmp short .5
.3:
        mov eax, 12h
        jmp short .2
.4:
        mov eax, 13h
        call GetLangText
        push eax
        push MatchupNote
        mov eax, dword [MatchupNoteCount]
        push str_SS12
        push dword [nosplit eax*4+MatchupNoteFormats]
        call sprintf_
        add esp, byte 10h
.5:
        push dword 0FFFFFF50h
        mov dword [MatchupNoteLength], edx
        call MakeColor
        mov edx, dword [MatchupNoteCount]
        add esp, byte 4
        inc dword [MatchupNoteCount]
        mov dword [nosplit edx*4+MatchupNotes], eax
.6:
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; DrawRosterPlayerInfo                            D3DFA  97 PC, low confidence
; Draws a roster player's information
;-----------------------------------------------------------------------------
DrawRosterPlayerInfo:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 1AA0h, 0
        sub ebp, 82h
        lea ecx, [byte ebp+076h]
        lea ebx, [byte ebp+07Eh]
        lea edx, [byte ebp+07Ah]
        movzx eax, word [AllStarDay]
        call AgeFromBirthDate
        push byte 0FFFFFFFFh
        call MakeColor
        mov edx, eax
        mov eax, dword [MatchupNoteCount]
        add esp, byte 4
        mov dword [nosplit eax*4+MatchupNotes], edx
        movsx eax, word [byte ebp+07Ah]
        push eax
        movsx eax, word [byte ebp+076h]
        push eax
        movsx eax, word [byte ebp+07Eh]
        add eax, byte 22h
        call GetLangText
        push eax
        mov edx, dword [MatchupNoteCount]
        push str_SDD
        inc edx
        push dword [nosplit edx*4+RosterInfoLines]
        mov dword [MatchupNoteCount], edx
        call sprintf_
        add esp, byte 14h
        test byte [GameSettings], 70h
        je near PreGameRostersScreen_C3F
        xor edi, edi
.1:
        test edi, edi
        jne near .6
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .2
        cmp dword [SeasonActive], byte 0
        jne short .2
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        mov dword [byte ebp+06Ah], eax
        jmp short .5
.2:
        mov esi, dword [GameOptionFlags]
        xor ebx, ebx
.3:
        mov edx, dword [byte esi+01h]
        shl edx, 0Ch
        shr edx, 1Ah
        cmp edx, dword [nosplit ebx*4+PlayoffTeams]
        jne short .4
        mov dword [byte ebp+06Ah], ebx
.4:
        inc ebx
        cmp ebx, byte 10h
        jl short .3
.5:
        mov edx, dword [byte ebp+06Ah]
        mov eax, dword [SeasonUserTeam]
        shl edx, 3
        mov eax, dword [byte eax+01Ch]
        add eax, edx
        lea edx, [dword ebp-01A1Eh]
        call FindGameRecord
        lea edx, [byte ebp-012h]
        lea eax, [dword ebp-01A0Eh]
        call FindTeamRecord
        push byte 0FFFFFFFFh
        call MakeColor
        mov edx, eax
        mov eax, dword [MatchupNoteCount]
        add esp, byte 4
        mov dword [nosplit eax*4+MatchupNotes], edx
        lea eax, [byte ebp+040h]
        mov edx, dword [MatchupNoteCount]
        push eax
        inc edx
        push str_S_DrawMatchupNotes
        push dword [nosplit edx*4+RosterInfoLines]
        mov dword [MatchupNoteCount], edx
        call sprintf_
        add esp, byte 0Ch
        jmp short .7
.6:
        mov edx, dword [GameOptionFlags]
        mov edx, dword [byte edx+01h]
        shl edx, 6
        mov eax, dword [SeasonUserTeam]
        shr edx, 1Ah
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        lea edx, [dword ebp-01A1Eh]
        call FindGameRecord
.7:
        xor ebx, ebx
        jmp near .17
.8:
        imul esi, ebx, byte 38h
        lea edx, [dword ebp-0D15h]
        add edx, esi
        lea eax, [byte edx+03h]
        call PlayerInjuryDays
        mov dword [byte ebp+06Eh], eax
        mov dword [byte ebp+072h], eax
        cmp eax, byte 0FFFFFFFFh
        je near .16
        cmp dword [MatchupNoteCount], byte 5
        jge near .16
        lea eax, [byte edx+018h]
        test byte [dword esi+ebp-0D15h], 1
        je short .9
        lea edx, [dword ebp-0CEh]
        call FindPlayerRecord
        jmp near .16
.9:
        lea edx, [dword ebp-0CEh]
        call FindPlayerRecord
        push dword 0FF0000h
        call MakeColor
        mov edx, eax
        mov eax, dword [MatchupNoteCount]
        mov dword [nosplit eax*4+MatchupNotes], edx
        imul eax, dword [byte ebp+06Eh], byte 7
        add eax, esi
        movzx edx, byte [dword eax+ebp-0D0Dh]
        add edx, dword [dword eax+ebp-0D12h]
        mov eax, dword [SeasonUserTeam]
        movsx ecx, word [byte eax+02h]
        shl ecx, 4
        mov eax, dword [byte eax+020h]
        movzx eax, word [byte ecx+eax-0Ch]
        add esp, byte 4
        cmp edx, eax
        jle short .10
        mov eax, 7Dh
        jmp short .14
.10:
        movzx eax, word [AllStarDay]
        sub edx, eax
        mov eax, edx
        cmp edx, byte 3Ch
        jle short .12
        mov ecx, 1Eh
        cdq
        idiv ecx
        push eax
        mov eax, 7Ch
.11:
        call GetLangText
        push eax
        lea eax, [byte ebp+056h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        jmp short .15
.12:
        cmp edx, byte 1
        jle short .13
        push edx
        mov eax, 7Bh
        jmp short .11
.13:
        mov eax, 7Ah
.14:
        call GetLangText
        mov edx, eax
        lea eax, [byte ebp+056h]
        call strcpy_
.15:
        imul edx, ebx, byte 38h
        lea eax, [byte ebp+056h]
        push eax
        imul eax, dword [byte ebp+072h], byte 7
        add eax, edx
        movzx eax, byte [dword eax+ebp-0D0Eh]
        call GetLangText
        push eax
        lea eax, [dword ebp-0C6h]
        push eax
        lea eax, [dword ebp-0B6h]
        push eax
        mov eax, 5Dh
        call GetLangText
        mov edx, dword [MatchupNoteCount]
        push eax
        inc edx
        push dword [nosplit edx*4+RosterInfoLines]
        mov dword [MatchupNoteCount], edx
        call sprintf_
        add esp, byte 18h
.16:
        inc ebx
.17:
        movsx eax, word [dword ebp-0D19h]
        cmp ebx, eax
        jl near .8
        inc edi
        cmp edi, byte 2
        jl near .1
        jmp near PreGameRostersScreen_C3F
;-----------------------------------------------------------------------------
; DrawMatchupHistory                              D40CF  97 PC, low confidence
; Draws the matchup history notes
;-----------------------------------------------------------------------------
DrawMatchupHistory:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 195Ch, 0
        call IsAllStarDay
        test eax, eax
        jne near DrawMatchupHistory_FB
        xor ebx, ebx
.1:
        test ebx, ebx
        je short .2
        mov eax, AutoLineData
        jmp short .3
.2:
        mov eax, homelines
.3:
        lea edx, [byte eax+03Eh]
        mov dword [byte ebp-0Ch], edx
        je short .4
        mov edx, dword [GameOptionFlags]
        mov esi, dword [byte edx+01h]
        shl esi, 0Ch
        jmp short .5
.4:
        mov edx, dword [GameOptionFlags]
        mov esi, dword [byte edx+01h]
        shl esi, 6
.5:
        shr esi, 1Ah
        test byte [GameSettings], 70h
        jne short .6
        movzx esi, byte [byte eax+06Bh]
        movzx edi, byte [byte eax+06Ah]
        movzx eax, byte [byte eax+06Ch]
        mov dword [byte ebp-04h], eax
        jmp short .7
.6:
        lea edx, [byte ebp-08h]
        mov eax, PlayoffDbKey
        call OpenLeagueFile
        mov eax, dword [byte ebp-08h]
        shl esi, 3
        mov eax, dword [byte eax+01Ch]
        lea edx, [dword ebp-0195Ch]
        add eax, esi
        call FindGameRecord
        movzx eax, byte [dword ebp-0190Ah]
        movzx edi, byte [dword ebp-0190Ch]
        mov dword [byte ebp-04h], eax
        lea eax, [byte ebp-08h]
        movzx esi, byte [dword ebp-0190Bh]
        call FreeDbBlock
.7:
        mov eax, 1
        call FormatMatchupNote
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push dword [byte ebp-04h]
        push esi
        push edi
        mov edx, eax
        mov eax, dword [MatchupNoteCount]
        push dword [byte ebp-0Ch]
        inc ebx
        push str_SDDD
        mov dword [nosplit eax*4+MatchupNotes], edx
        lea edx, [byte eax+01h]
        push dword [nosplit eax*4+MatchupNoteFormats]
        mov dword [MatchupNoteCount], edx
        call sprintf_
        add esp, byte 18h
        cmp ebx, byte 2
        jl near .1
DrawMatchupHistory_FB:
        leave
DrawMatchupHistory_FC:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawRosterLabel                                 D41D1  97 PC, low confidence
; Draws a roster label
;-----------------------------------------------------------------------------
DrawRosterLabel:
        push ebx
        push ecx
        push edx
        xor ebx, ebx
        jmp short .2
.1:
        mov eax, dword [nosplit ebx*4+MatchupNotes]
        call SetTextColor
        mov eax, ebx
        push dword [nosplit ebx*4+MatchupNoteFormats]
        shl eax, 4
        push str_S_DrawMatchupNotes
        add eax, byte 4Bh
        push eax
        push dword 140h
        push byte 1
        inc ebx
        call DrawTextAligned
        add esp, byte 14h
.2:
        cmp ebx, dword [MatchupNoteCount]
        jl short .1
        pop edx
        pop ecx
        pop ebx
        ret
DrawMatchupNotesJumpTable:                      ; jump table for the switch cases of DrawMatchupNotes
        dd DrawMatchupNotes_86
        dd DrawMatchupNotes_C5
        dd DrawMatchupNotes_10F
        dd DrawMatchupNotes_14B
;-----------------------------------------------------------------------------
; DrawMatchupNotes                                D4225  97 PC, low confidence
; Pre-game: the playoff race notes, season series and "last time they met"
; lines
;-----------------------------------------------------------------------------
DrawMatchupNotes:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 48h, 0
        lea edi, [byte ebp-030h]
        mov esi, MatchupNotesBlankRect
        movsd
        movsd
        lea edi, [byte ebp-038h]
        mov esi, MatchupNotesBlankPos
        movsd
        movsd
        mov dword [byte ebp-08h], 0
        lea edi, [byte ebp-028h]
        mov esi, MatchupNotesBlankSize
        mov dword [byte ebp-0Ch], 0
        mov dword [byte ebp-010h], 0
        movsd
        movsd
        call FindMatchupNotes
        movzx edi, al
        mov dword [byte ebp-04h], 0
        test edi, edi
        je near DrawMatchupNotes_14B.6
        xor esi, esi
.1:
        test esi, esi
        je short .2
        mov eax, edi
        and eax, 0F0h
        mov ebx, MatchupNoteLine
        sar eax, 4
        jmp short .3
.2:
        mov eax, edi
        mov ebx, MatchupNoteLine
        and eax, byte 0Fh
.3:
        dec eax
        cmp eax, byte 3
        ja near DrawMatchupNotes_14B.5
        jmp dword [nosplit cs:eax*4+DrawMatchupNotesJumpTable]
DrawMatchupNotes_86:
        push byte 0FFFFFFFFh
        call MakeColor
        mov ecx, eax
        mov eax, dword [MatchupNoteCount]
        add esp, byte 4
        mov dword [nosplit eax*4+MatchupNotes], ecx
        mov eax, 1Bh
        call GetLangText
        push eax
        push ebx
        mov eax, 1Ah
        call GetLangText
        push eax
        mov ebx, dword [MatchupNoteCount]
        push str_SSS2
        jmp near DrawMatchupNotes_14B.4
DrawMatchupNotes_C5:
        push byte 0FFFFFFFFh
        call MakeColor
        mov ecx, eax
        mov eax, dword [MatchupNoteCount]
        add esp, byte 4
        mov dword [nosplit eax*4+MatchupNotes], ecx
        mov eax, 1Ch
        call GetLangText
        push eax
        push ebx
        mov ebx, dword [MatchupNoteCount]
        push str_SS13
        inc ebx
        push dword [nosplit ebx*4+RosterInfoLines]
        mov dword [MatchupNoteCount], ebx
        call sprintf_
        add esp, byte 10h
        jmp near DrawMatchupNotes_14B.5
DrawMatchupNotes_10F:
        push byte 0FFFFFFFFh
        call MakeColor
        mov ecx, eax
        mov eax, dword [MatchupNoteCount]
        add esp, byte 4
        mov dword [nosplit eax*4+MatchupNotes], ecx
        mov eax, 1Eh
        call GetLangText
        push eax
        push ebx
        mov eax, 1Dh
        call GetLangText
        push eax
        mov ebx, dword [MatchupNoteCount]
        push str_SSS3
        jmp short DrawMatchupNotes_14B.4
DrawMatchupNotes_14B:
        push byte 0FFFFFFFFh
        call MakeColor
        mov ecx, eax
        mov eax, dword [MatchupNoteCount]
        add esp, byte 4
        mov dword [nosplit eax*4+MatchupNotes], ecx
        mov eax, 20h
        call GetLangText
        push eax
        push ebx
        mov eax, 1Fh
        call GetLangText
        push eax
        mov ebx, dword [MatchupNoteCount]
        push str_SSS2
.4:
        inc ebx
        push dword [nosplit ebx*4+RosterInfoLines]
        mov dword [MatchupNoteCount], ebx
        call sprintf_
        add esp, byte 14h
.5:
        inc esi
        cmp esi, byte 2
        jl near DrawMatchupNotes.1
        jmp near DrawMatchupHistory_FB
.6:
        push edi
        push dword 329Eh
        push str_Roster4
        xor esi, esi
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp-01Ch], eax
.7:
        test esi, esi
        je short .8
        mov edi, AutoLineData
        jmp short .9
.8:
        mov edi, homelines
.9:
        xor ebx, ebx
        jmp short .12
.10:
        mov edx, ebx
        shl edx, 3
        mov eax, dword [byte eax+014h]
        mov dword [byte ebp-014h], edx
        add eax, edx
        mov edx, edi
        call KeysEqual
        test eax, eax
        je short .11
        imul eax, esi, dword 194Fh
        mov edx, dword [byte ebp-01Ch]
        add edx, eax
        mov eax, dword [SeasonUserTeam]
        mov eax, dword [byte eax+01Ch]
        add eax, dword [byte ebp-014h]
        call FindGameRecord
        mov dword [byte ecx+ebp-030h], 1
        mov dword [byte ecx+ebp-038h], ebx
.11:
        inc ebx
.12:
        mov eax, dword [SeasonUserTeam]
        movsx ecx, word [eax]
        cmp ebx, ecx
        jge short .13
        mov ecx, esi
        shl ecx, 2
        cmp dword [byte ecx+ebp-030h], byte 0
        je short .10
.13:
        inc esi
        cmp esi, byte 2
        jl short .7
        xor ebx, ebx
        jmp near .30
.14:
        mov esi, ebx
        mov eax, dword [byte eax+020h]
        shl esi, 4
        lea edi, [byte ebp-048h]
        add esi, eax
        movsd
        movsd
        movsd
        movsd
        movsx eax, byte [byte ebp-048h]
        cmp eax, dword [byte ebp-034h]
        je short .15
        movsx eax, byte [byte ebp-047h]
        cmp eax, dword [byte ebp-034h]
        jne short .16
.15:
        movsx eax, byte [byte ebp-046h]
        cmp eax, byte 0FFFFFFFFh
        je short .16
        mov dword [byte ebp-024h], 1
.16:
        movsx eax, byte [byte ebp-048h]
        cmp eax, dword [byte ebp-038h]
        je short .17
        movsx eax, byte [byte ebp-047h]
        cmp eax, dword [byte ebp-038h]
        jne short .18
.17:
        movsx eax, byte [byte ebp-046h]
        cmp eax, byte 0FFFFFFFFh
        je short .18
        mov dword [byte ebp-028h], 1
.18:
        movsx eax, byte [byte ebp-048h]
        cmp eax, dword [byte ebp-038h]
        jne short .19
        movsx eax, byte [byte ebp-047h]
        cmp eax, dword [byte ebp-034h]
        je short .20
.19:
        movsx eax, byte [byte ebp-048h]
        cmp eax, dword [byte ebp-034h]
        jne near .29
        movsx eax, byte [byte ebp-047h]
        cmp eax, dword [byte ebp-038h]
        jne near .29
.20:
        movsx eax, byte [byte ebp-046h]
        cmp eax, byte 0FFFFFFFFh
        je near .29
        movsx ecx, byte [byte ebp-048h]
        cmp ecx, dword [byte ebp-038h]
        jne short .21
        mov dword [byte ebp-020h], eax
        movsx eax, byte [byte ebp-045h]
        mov dword [byte ebp-018h], eax
        jmp short .22
.21:
        movsx edx, byte [byte ebp-045h]
        mov dword [byte ebp-018h], eax
        mov dword [byte ebp-020h], edx
.22:
        movsx eax, byte [byte ebp-048h]
        cmp eax, dword [byte ebp-038h]
        jne short .23
        mov al, byte [byte ebp-046h]
        cmp al, byte [byte ebp-045h]
        jg short .24
.23:
        movsx eax, byte [byte ebp-047h]
        cmp eax, dword [byte ebp-038h]
        jne short .25
        mov al, byte [byte ebp-045h]
        cmp al, byte [byte ebp-046h]
        jle short .25
.24:
        inc dword [byte ebp-0Ch]
        inc dword [byte ebp-010h]
        jmp short .29
.25:
        movsx eax, byte [byte ebp-048h]
        cmp eax, dword [byte ebp-034h]
        jne short .26
        mov al, byte [byte ebp-046h]
        cmp al, byte [byte ebp-045h]
        jg short .27
.26:
        movsx eax, byte [byte ebp-047h]
        cmp eax, dword [byte ebp-034h]
        jne short .28
        mov al, byte [byte ebp-045h]
        cmp al, byte [byte ebp-046h]
        jle short .28
.27:
        inc dword [byte ebp-08h]
        jmp short .29
.28:
        inc dword [byte ebp-04h]
.29:
        inc ebx
.30:
        mov eax, dword [SeasonUserTeam]
        movsx ecx, word [byte eax+02h]
        cmp ebx, ecx
        jl near .14
        cmp dword [byte ebp-028h], byte 0
        je short .31
        cmp dword [byte ebp-024h], byte 0
        jne short .32
.31:
        call DrawMatchupHistory
        jmp near .38
.32:
        mov eax, 3
        call FormatMatchupNote
        xor esi, esi
.33:
        test esi, esi
        je short .34
        mov edi, AutoLineData
        jmp short .35
.34:
        mov edi, homelines
.35:
        mov eax, dword [byte ebp-08h]
        add eax, dword [byte ebp-010h]
        add eax, dword [byte ebp-04h]
        jne short .36
        push byte 0FFFFFFFFh
        call MakeColor
        mov ebx, eax
        mov eax, dword [MatchupNoteCount]
        mov dword [nosplit eax*4+MatchupNotes], ebx
        add esp, byte 4
        movzx eax, byte [byte edi+06Ch]
        push eax
        movzx eax, byte [byte edi+06Bh]
        push eax
        movzx eax, byte [byte edi+06Ah]
        push eax
        add edi, byte 3Eh
        mov ebx, dword [MatchupNoteCount]
        push edi
        inc ebx
        push str_SDDD
        push dword [nosplit ebx*4+RosterInfoLines]
        jmp near .37
.36:
        push byte 0FFFFFFFFh
        call MakeColor
        mov ebx, eax
        mov eax, dword [MatchupNoteCount]
        add esp, byte 4
        mov dword [nosplit eax*4+MatchupNotes], ebx
        mov eax, 21h
        call GetLangText
        push eax
        mov ebx, dword [MatchupNoteCount]
        push str_S_DrawMatchupNotes
        inc ebx
        push dword [nosplit ebx*4+RosterInfoLines]
        mov dword [MatchupNoteCount], ebx
        call sprintf_
        add esp, byte 0Ch
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push dword [byte ebp-04h]
        push dword [byte ebp-0Ch]
        push dword [byte ebp-08h]
        push HomeCityName
        push MatchupNoteText
        mov ebx, eax
        mov eax, dword [MatchupNoteCount]
        push str_SVsSDDD
        mov dword [nosplit eax*4+MatchupNotes], ebx
        lea ebx, [byte eax+01h]
        push dword [nosplit eax*4+MatchupNoteFormats]
        mov dword [MatchupNoteCount], ebx
        call sprintf_
        add esp, byte 1Ch
        push byte 0FFFFFFFFh
        call MakeColor
        mov ebx, eax
        mov eax, dword [MatchupNoteCount]
        add esp, byte 4
        mov dword [nosplit eax*4+MatchupNotes], ebx
        mov eax, 22h
        call GetLangText
        push eax
        mov ebx, dword [MatchupNoteCount]
        push str_S_DrawMatchupNotes
        inc ebx
        push dword [nosplit ebx*4+RosterInfoLines]
        mov dword [MatchupNoteCount], ebx
        call sprintf_
        add esp, byte 0Ch
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push dword [byte ebp-020h]
        push HomeCityName
        push dword [byte ebp-018h]
        mov ebx, eax
        push MatchupNoteText
        mov eax, dword [MatchupNoteCount]
        mov esi, 1
        push str_SDSD2
        mov dword [nosplit eax*4+MatchupNotes], ebx
        lea ebx, [byte eax+01h]
        push dword [nosplit eax*4+MatchupNoteFormats]
.37:
        mov dword [MatchupNoteCount], ebx
        call sprintf_
        add esp, byte 18h
        inc esi
        cmp esi, byte 2
        jl near .33
.38:
        push dword [byte ebp-01Ch]
        call FreeMemBlock
        add esp, byte 4
        jmp near DrawMatchupHistory_FB
;-----------------------------------------------------------------------------
; FindMatchupNotes                                D4727  97 PC, low confidence
; Finds the notes for a matchup
;-----------------------------------------------------------------------------
FindMatchupNotes:
        push ebx
        push ecx
        push edx
        enter 1A94h, 0
        sub ebp, 82h
        mov byte [byte ebp+07Eh], 0
        xor ebx, ebx
.1:
        mov edx, ebx
        mov eax, dword [SeasonUserTeam]
        shl edx, 3
        mov eax, dword [byte eax+01Ch]
        add eax, edx
        lea edx, [dword ebp-01A12h]
        call FindGameRecord
        movzx edx, byte [dword ebp-019C2h]
        movzx eax, byte [dword ebp-019C0h]
        add edx, edx
        inc ebx
        add edx, eax
        mov dword [dword ebp+ebx*4-0C6h], edx
        movsx edx, word [dword ebp-019C4h]
        mov dword [byte ebp+ebx*4-05Eh], edx
        cmp ebx, byte 1Ah
        jl short .1
        lea ebx, [byte ebp+02Ah]
        lea edx, [byte ebp-05Ah]
        lea eax, [dword ebp-0C2h]
        mov ecx, dword [SeasonUserTeam]
        call CountTeamResults
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        inc dword [byte ebp+eax*4-05Ah]
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        shr eax, 1Ah
        inc dword [byte ebp+eax*4-05Ah]
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        lea ebx, [byte ebp+046h]
        shr eax, 1Ah
        lea edx, [byte ebp-05Ah]
        add dword [dword ebp+eax*4-0C2h], byte 2
        lea eax, [dword ebp-0C2h]
        mov ecx, dword [SeasonUserTeam]
        call CountTeamResults
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        inc dword [byte ebp+eax*4-05Ah]
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        shr eax, 1Ah
        inc dword [byte ebp+eax*4-05Ah]
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        inc dword [dword ebp+eax*4-0C2h]
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        lea ebx, [byte ebp+0Eh]
        shr eax, 1Ah
        lea edx, [byte ebp-05Ah]
        dec dword [dword ebp+eax*4-0C2h]
        lea eax, [dword ebp-0C2h]
        mov ecx, dword [SeasonUserTeam]
        call CountTeamResults
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        inc dword [byte ebp+eax*4-05Ah]
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        shr eax, 1Ah
        inc dword [byte ebp+eax*4-05Ah]
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        shr eax, 1Ah
        dec dword [dword ebp+eax*4-0C2h]
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        lea ebx, [byte ebp+062h]
        shr eax, 1Ah
        lea edx, [byte ebp-05Ah]
        inc dword [dword ebp+eax*4-0C2h]
        lea eax, [dword ebp-0C2h]
        mov ecx, dword [SeasonUserTeam]
        call CountTeamResults
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        cmp byte [byte eax+ebp+02Ah], 2
        jne short .2
        cmp byte [byte eax+ebp+062h], 1
        jne short .2
        or byte [byte ebp+07Eh], 80h
.2:
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        cmp byte [byte eax+ebp+02Ah], 2
        jne short .3
        cmp byte [byte eax+ebp+0Eh], 1
        jne short .3
        or byte [byte ebp+07Eh], 40h
.3:
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        cmp byte [byte eax+ebp+02Ah], 2
        jne short .4
        cmp byte [byte eax+ebp+0Eh], 3
        jne short .4
        or byte [byte ebp+07Eh], 20h
.4:
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        cmp byte [byte eax+ebp+02Ah], 2
        jne short .5
        cmp byte [byte eax+ebp+046h], 3
        jne short .5
        or byte [byte ebp+07Eh], 10h
.5:
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        shr eax, 1Ah
        cmp byte [byte eax+ebp+02Ah], 2
        jne short .6
        cmp byte [byte eax+ebp+062h], 1
        jne short .6
        or byte [byte ebp+07Eh], 8
.6:
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        shr eax, 1Ah
        cmp byte [byte eax+ebp+02Ah], 2
        jne short .7
        cmp byte [byte eax+ebp+0Eh], 1
        jne short .7
        or byte [byte ebp+07Eh], 4
.7:
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        shr eax, 1Ah
        cmp byte [byte eax+ebp+02Ah], 2
        jne short .8
        cmp byte [byte eax+ebp+0Eh], 3
        jne short .8
        or byte [byte ebp+07Eh], 2
.8:
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        shr eax, 1Ah
        cmp byte [byte eax+ebp+02Ah], 2
        jne short .9
        cmp byte [byte eax+ebp+046h], 3
        jne short .9
        or byte [byte ebp+07Eh], 1
.9:
        mov al, byte [byte ebp+07Eh]
        lea esp, [dword ebp+082h]
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CountTeamResults                                D49BE  97 PC, low confidence
; Counts a team's results
;-----------------------------------------------------------------------------
CountTeamResults:
        push esi
        push edi
        enter 1A8h, 0
        push eax
        mov esi, edx
        mov dword [byte ebp-04h], ebx
        xor ebx, ebx
.1:
        movsx eax, word [byte ecx+02h]
        add eax, eax
        mov edi, 1Ah
        cdq
        idiv edi
        mov dword [byte ebp-08h], eax
        mov eax, ebx
        mov edx, dword [byte ebp-08h]
        sub edx, dword [esi+eax*4]
        add edx, edx
        mov dword [byte ebp-08h], edx
        mov edx, dword [dword ebp-01ACh]
        mov edi, dword [edx+eax*4]
        add edi, dword [byte ebp-08h]
        mov dword [byte ebp+ebx*4-070h], edi
        inc ebx
        mov edx, dword [edx+eax*4]
        mov dword [dword ebp+ebx*4-0DCh], edx
        cmp ebx, byte 1Ah
        jl short .1
        xor ebx, ebx
.2:
        mov dword [dword ebp+ebx*4-0140h], 0
        mov dword [dword ebp+ebx*4-01A8h], 0
        xor edx, edx
.3:
        cmp edx, ebx
        je short .5
        mov ecx, edx
        mov eax, ebx
        shl ecx, 2
        shl eax, 2
        mov esi, dword [dword ecx+PlayoffColumns]
        cmp esi, dword [dword eax+PlayoffColumns]
        jne short .5
        mov esi, dword [byte eax+ebp-070h]
        cmp esi, dword [dword ecx+ebp-0D8h]
        jge short .4
        inc dword [dword eax+ebp-0140h]
.4:
        mov eax, ebx
        shl eax, 2
        mov esi, dword [dword eax+ebp-0D8h]
        cmp esi, dword [byte ebp+edx*4-070h]
        jle short .5
        inc dword [dword eax+ebp-01A8h]
.5:
        inc edx
        cmp edx, byte 1Ah
        jl short .3
        mov edx, ebx
        mov eax, dword [byte ebp-04h]
        shl edx, 2
        add eax, ebx
        cmp dword [dword edx+ebp-01A8h], byte 4
        jle short .6
        mov byte [eax], 1
        jmp short .8
.6:
        cmp dword [dword edx+ebp-0140h], byte 7
        jle short .7
        mov byte [eax], 3
        jmp short .8
.7:
        mov byte [eax], 2
.8:
        inc ebx
        cmp ebx, byte 1Ah
        jl near .2
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; MatchupAnnouncement                             D4AAC  97 PC, low confidence
; Plays the matchup announcement
;-----------------------------------------------------------------------------
MatchupAnnouncement:
        push ebx
        push ecx
        push edx
        push esi
        enter 0Ch, 0
        mov eax, dword [GameSettings]
        and eax, byte 70h
        xor edx, edx
        cmp eax, byte 10h
        jne near .12
        cmp dword [SeasonActive], byte 0
        jne near .12
        imul esi, dword [SeasonDefaultUser], byte 1Ch
        mov esi, dword [dword esi+SeasonUserReplay]
        jmp short .4
.1:
        jne short .6
.2:
        mov byte [byte edx+ebp-0Ch], 1
.3:
        mov edx, ebx
.4:
        test esi, esi
        jle short .8
        cmp edx, byte 0Bh
        jge short .8
        dec esi
        mov eax, dword [SeasonUserTeam]
        mov ebx, esi
        mov eax, dword [byte eax+020h]
        shl ebx, 4
        add eax, ebx
        movsx ecx, byte [eax]
        lea ebx, [byte edx+01h]
        cmp ecx, dword [SeasonDefaultUser]
        jne short .7
        mov cl, byte [byte eax+02h]
        cmp cl, byte [byte eax+03h]
        jle short .1
.5:
        mov byte [byte edx+ebp-0Ch], 3
        jmp short .3
.6:
        mov byte [byte edx+ebp-0Ch], 2
        jmp short .3
.7:
        movsx ecx, byte [byte eax+01h]
        cmp ecx, dword [SeasonDefaultUser]
        jne short .4
        mov cl, byte [byte eax+02h]
        cmp cl, byte [byte eax+03h]
        jg short .6
        je short .2
        jmp short .5
.8:
        cmp edx, byte 0Bh
        jge short .11
        mov eax, edx
        jmp short .10
.9:
        inc eax
        mov byte [byte eax+ebp-0Dh], 0
.10:
        cmp eax, byte 0Ch
        jl short .9
.11:
        call IsAllStarDay
        test eax, eax
        jne near .32
        lea eax, [byte ebp-0Ch]
        push eax
        push dword [SeasonDefaultUser]
        push dword 0B0000005h
        call PaEvent
        add esp, byte 0Ch
        jmp near .32
.12:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 20h
        je short .13
        cmp eax, byte 10h
        jne near .32
        cmp dword [SeasonActive], byte 0
        je near .32
.13:
        movzx esi, byte [PlayoffUserIndex]
        xor eax, eax
.14:
        mov edx, dword [nosplit eax*4+PlayoffTeams]
        cmp edx, dword [nosplit esi*4+PlayoffTeams]
        jne short .15
        mov ebx, eax
.15:
        inc eax
        cmp eax, byte 1Fh
        jl short .14
        mov eax, ebx
        mov esi, 2
        cdq
        idiv esi
        test edx, edx
        je short .16
        lea edx, [byte ebx-01h]
        jmp short .17
.16:
        lea edx, [byte ebx+01h]
.17:
        mov ecx, dword [PlayoffRoundBits]
        and ecx, byte 7
        mov eax, dword [nosplit ebx*4+PlayoffTeamNames]
        shr ecx, 1
        mov edx, dword [nosplit edx*4+PlayoffTeamNames]
        cmp eax, ecx
        jne short .20
        cmp ebx, byte 18h
        je short .18
        cmp ebx, byte 19h
        jne short .20
.18:
        push edx
        push eax
        push byte 5
.19:
        push dword [nosplit ebx*4+PlayoffTeams]
        jmp near .31
.20:
        mov esi, dword [PlayoffRoundBits]
        and esi, byte 7
        shr esi, 1
        cmp eax, esi
        jne short .22
        cmp ebx, byte 1Ah
        je short .21
        cmp ebx, byte 1Bh
        jne short .22
.21:
        push edx
        push eax
        push byte 6
        jmp short .19
.22:
        mov esi, dword [PlayoffRoundBits]
        and esi, byte 7
        shr esi, 1
        cmp eax, esi
        jne short .23
        push edx
        push esi
        push byte 4
        jmp short .19
.23:
        cmp edx, esi
        jne short .24
        cmp ebx, byte 1Ch
        je short .25
.24:
        cmp ebx, byte 1Dh
        jne short .26
.25:
        push edx
        push eax
        push byte 8
        jmp short .19
.26:
        mov ecx, dword [PlayoffRoundBits]
        and ecx, byte 7
        shr ecx, 1
        shl ebx, 2
        cmp edx, ecx
        jne short .28
        push ecx
        push eax
        push byte 7
.27:
        push dword [dword ebx+PlayoffTeams]
        jmp short .31
.28:
        cmp eax, edx
        jle short .29
        push edx
        push eax
        push byte 1
        jmp short .27
.29:
        jne short .30
        push edx
        push edx
        push byte 3
        jmp short .27
.30:
        push edx
        push eax
        push byte 2
        push dword [dword ebx+PlayoffTeams]
.31:
        push dword 0B0000006h
        call PaEvent
        add esp, byte 14h
.32:
        leave
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
GoalieMaskList:                                 ; used by GoalieMaskScreen
        dd str_Barasso
        dd str_PIT
        dd str_199596
        dd str_Beaupre
        dd str_OTT
        dd str_199596
        dd str_Brodeur
        dd str_NJ_GoalieMaskList
        dd str_199596
        dd str_Burke
        dd str_HFD
        dd str_199596
        dd str_Carey
        dd str_WAS
        dd str_199596
        dd str_Fichaud
        dd str_NYI_GoalieMaskList
        dd str_199596
        dd str_Flaherty
        dd str_SJ_GoalieMaskList
        dd str_199596
        dd str_Fuhr
        dd str_BUF
        dd str_199495
        dd str_Fuhr
        dd str_STL
        dd str_199596
        dd str_Hackett
        dd str_CHI
        dd str_199596
        dd str_Hebert
        dd str_ANA
        dd str_199596
        dd str_Hextall
        dd str_PHI
        dd str_199596
        dd str_Hextall
        dd str_QUE
        dd str_199293
        dd str_Heyward
        dd str_SJ_GoalieMaskList
        dd str_199293
        dd str_Hirsch
        dd str_VAN
        dd str_199596
        dd str_Hrudey
        dd str_LA_GoalieMaskList
        dd str_199596
        dd str_Jablonski
        dd str_TB_GoalieMaskList
        dd str_199495
        dd str_Joseph
        dd str_EDM
        dd str_199596
        dd str_Kidd
        dd str_CAL
        dd str_199596
        dd str_Kolzig
        dd str_WAS
        dd str_199596
        dd str_Lacher
        dd str_BOS
        dd str_199596
        dd str_Moog
        dd str_BOS
        dd str_199293
        dd str_Moog
        dd str_DAL
        dd str_199596
        dd str_Richter
        dd str_NYR_GoalieMaskList
        dd str_199596
        dd str_Roy
        dd str_COL
        dd str_199596
        dd str_Roy
        dd str_MTL
        dd str_199495
        dd str_Thibault
        dd str_MTL
        dd str_199596
        dd str_Vanbiesbrouck
        dd str_FLA
        dd str_199596
        dd str_Vanbiesbrouck
        dd str_NYR_GoalieMaskList
        dd str_199293
        dd str_Vernon
        dd str_DET
        dd str_199596
        dd str_EASports
        dd str_EA
        dd str_199596
