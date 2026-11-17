; Standings: sorting and factoids.
bits 32
%include "hockey.inc"
section s_91289 progbits alloc exec nowrite align=1
extern AllocMemBlock, BlankMenuItem, BlitArt, BlitShape2, CountTeamResults, CreateBitmap, CreateSeason_55B, DrawScreenBackground
extern DrawScrollBar, DrawShapeAtOwnPos, DrawTextAligned, ExitScreen, FadeInScreen, FindGameRecord, FindPlayerRecord, FindShape
extern FindShapeList, FindTeamRecord, FindTeamStat, FreeBitmap, FreeDbBlock, FreeMemBlock, FreeScrollList, GetLangText
extern InitMenuItems, InitScrollTable, KeysEqual, LoadDataFile, MakeColor, OpenLeagueFile, PlayoffColumns, PresentScreen
extern qsort_, Random32, RunMenu, ScreenFrameItem, ScrollDown, ScrollToMouse, ScrollUp, SeasonFilePath
extern SeasonSparkleShapes, SeasonUserTeam, SecondsToSamples, SetDrawTarget, SetHighlightText, SetNormalText, SetRegionRect, SetScreenTarget
extern SetTextColor, sprintf_, StandingsBuffer, StandingsColumns, StandingsGoalsAgainst, StandingsGoalsFor, StandingsSortKey, StandingsTies
extern StandingsWins, str_BGES, str_BGWS, str_D_StandingsScreen, str_DDD3, str_EC00, str_EC01, str_FACT
extern str_Factoid, str_Idlist, str_LBL1LBL2LBL3LBR1LBR2LTL1L3, str_List, str_Ptlist, str_Punct_StandingsScreen, str_Ross, str_Rts
extern str_S3, str_S4, str_SSD02dSS, str_SSDSS, str_SSDSS2, str_SSSDSS, str_Standmenu, str_TTLE
extern str_TTLW, str_WC00, str_WC01, strcat_, strcpy_, strlen_, WaitSoundTime, WipeScreen
global StandingsSparkle, StandingsScreenJumpTable, StandingsScreen, StandingsScreen_65C, StandingsScreen_685, StandingsScreen_699, StandingsScreen_6AD, StandingsScreen_6C1
global StandingsScreen_6DD, StandingsScreen_6F4, StandingsScreen_70B, StandingsScreen_718, CompareStandingsValue, CompareStandings, SortStandings, SortStandings_1EA
global BuildStandingsFactoids
;-----------------------------------------------------------------------------
; StandingsSparkle                                91289  97 PC, low confidence
; Draws a random standings sparkle
;-----------------------------------------------------------------------------
StandingsSparkle:
        push ebx
        push ecx
        push edx
        call Random32
        mov ebx, 32h
        xor edx, edx
        div ebx
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
        pop edx
        pop ecx
        pop ebx
        ret
StandingsScreenJumpTable:                       ; jump table for the switch cases of StandingsScreen
        dd StandingsScreen_65C
        dd StandingsScreen_685
        dd StandingsScreen_699
        dd StandingsScreen_6AD
        dd StandingsScreen_6C1
        dd StandingsScreen_6DD
        dd StandingsScreen_6F4
        dd StandingsScreen_70B
        dd StandingsScreen_718
;-----------------------------------------------------------------------------
; StandingsScreen                              912E3  96 PC, medium confidence
; The standings screen by conference (1WST, 1EST)
;-----------------------------------------------------------------------------
StandingsScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 7CCh, 0
        sub ebp, 82h
        push byte 0
        push dword 0A28h
        push str_Factoid
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 0A5Ch
        push str_Rts
        mov dword [byte ebp+032h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 29206h
        push str_Ross
        mov dword [byte ebp+04Ah], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp+026h], 0FFFFFFFFh
        push byte 0
        mov dword [byte ebp+07Eh], 0
        mov dword [byte ebp+05Eh], 3
        push dword 616h
        mov dword [byte ebp+036h], 1
        mov dword [byte ebp+06Eh], 0FFFFFFFFh
        push str_Standmenu
        xor esi, esi
        mov dword [byte ebp+07Ah], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [StandingsBuffer], eax
.1:
        imul eax, esi, byte 64h
        mov edx, dword [byte ebp+032h]
        add edx, eax
        mov dword [dword ebp+esi*4-08Eh], edx
        inc esi
        mov byte [edx], 0
        cmp esi, byte 1Ah
        jl short .1
        lea edx, [byte ebp+022h]
        mov eax, SeasonFilePath
        call OpenLeagueFile
        call SetHighlightText
        mov ebx, dword [byte ebp+022h]
        lea edx, [byte ebp-0Ah]
        lea eax, [byte ebp-026h]
        call SortStandings
        mov ebx, dword [byte ebp+022h]
        lea edx, [byte ebp-0Ah]
        lea eax, [dword ebp-08Eh]
        call BuildStandingsFactoids
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 48h
        call LoadDataFile
        mov ebx, eax
        mov dword [byte ebp+04Eh], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 49h
        call LoadDataFile
        mov dword [byte ebp+06Ah], eax
        mov dword [byte ebp+076h], eax
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push str_BGWS
        push ebx
        call FindShape
        add esp, byte 8
        push str_TTLW
        mov dword [byte ebp+062h], eax
        push dword [byte ebp+06Ah]
        mov dword [byte ebp+072h], eax
        call FindShape
        add esp, byte 8
        push str_FACT
        push ebx
        mov dword [byte ebp+03Eh], eax
        call FindShape
        add esp, byte 8
        push SeasonSparkleShapes
        push str_LBL1LBL2LBL3LBR1LBR2LTL1L3
        push ebx
        mov dword [byte ebp+02Ah], eax
        call FindShapeList
        add esp, byte 0Ch
        push byte 0
        push dword 1E0h
        push dword 280h
        mov ebx, dword [byte ebp+062h]
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [byte ebp+066h], eax
        mov edx, ebx
        mov eax, ebx
        mov esi, BlankMenuItem
        call DrawScreenBackground
        mov eax, 13h
        mov edx, dword [StandingsBuffer]
        mov ecx, 52h
        call InitMenuItems
        mov edi, dword [StandingsBuffer]
        rep movsb
        mov eax, dword [StandingsBuffer]
        mov dword [eax], 0
        mov esi, dword [StandingsBuffer]
        mov ecx, 52h
        lea edi, [dword esi+05C4h]
        mov esi, ScreenFrameItem
        rep movsb
        mov eax, dword [StandingsBuffer]
        mov dword [dword eax+05C4h], 12h
        mov eax, dword [StandingsBuffer]
        push str_WC00
        mov dword [byte eax+062h], 4
        lea edx, [dword ebp-074Ah]
        mov eax, dword [StandingsBuffer]
        push dword [byte ebp+06Ah]
        mov dword [byte eax+066h], edx
        call FindShape
        add esp, byte 8
        push str_WC01
        mov edx, eax
        mov eax, dword [StandingsBuffer]
        push dword [byte ebp+06Ah]
        mov dword [byte eax+06Ch], edx
        call FindShape
        add esp, byte 8
        push str_WC01
        mov edx, eax
        mov eax, dword [StandingsBuffer]
        push dword [byte ebp+06Ah]
        mov dword [byte eax+070h], edx
        call FindShape
        mov edx, eax
        mov eax, dword [StandingsBuffer]
        mov dword [byte eax+074h], edx
        mov eax, dword [StandingsBuffer]
        mov edx, dword [byte eax+06Ch]
        movsx edx, word [byte edx+0Ch]
        mov dword [byte eax+078h], edx
        mov eax, dword [StandingsBuffer]
        mov edx, dword [byte eax+06Ch]
        movsx edx, word [byte edx+0Eh]
        mov dword [byte eax+07Ch], edx
        mov eax, dword [StandingsBuffer]
        mov eax, dword [byte eax+06Ch]
        add esp, byte 8
        movsx edx, word [byte eax+06h]
        movsx ecx, word [byte eax+04h]
        movsx ebx, word [byte eax+0Eh]
        push edx
        movsx edx, word [byte eax+0Ch]
        lea eax, [dword ebp-074Ah]
        call SetRegionRect
        push byte 0
        push byte 0
        push dword 15Eh
        push dword 172h
        mov ecx, 5
        push dword 0DCh
        mov ebx, 9
        lea eax, [dword ebp-01F6h]
        push dword [byte ebp+062h]
        mov edx, dword [StandingsBuffer]
        push byte 0
        add edx, 0A4h
        xor esi, esi
        call InitScrollTable
.2:
        lea edx, [byte esi+05h]
        imul edx, byte 52h
        mov eax, dword [StandingsBuffer]
        mov dword [byte edx+eax+010h], 4
        mov eax, esi
        shl eax, 6
        lea ebx, [dword ebp-074Ah]
        add eax, byte 40h
        add eax, ebx
        mov ebx, dword [StandingsBuffer]
        mov dword [byte edx+ebx+014h], eax
        cmp esi, byte 8
        jge short .3
        lea edx, [byte esi+01h]
        jmp short .4
.3:
        lea edx, [byte esi+02h]
.4:
        imul edx, byte 12h
        push byte 12h
        lea ebx, [byte edx+069h]
        mov ecx, 1FEh
        mov edx, 50h
        call SetRegionRect
        inc esi
        cmp esi, byte 0Dh
        jl short .2
        xor esi, esi
.5:
        imul edx, esi, byte 66h
        mov eax, dword [byte ebp+022h]
        mov ebx, esi
        mov eax, dword [byte eax+014h]
        shl ebx, 3
        add edx, dword [byte ebp+04Ah]
        add eax, ebx
        call FindTeamRecord
        imul edx, esi, dword 194Fh
        mov eax, dword [byte ebp+022h]
        mov eax, dword [byte eax+01Ch]
        add eax, ebx
        add edx, dword [byte ebp+07Ah]
        inc esi
        call FindGameRecord
        cmp esi, byte 1Ah
        jl short .5
        xor esi, esi
.6:
        mov dword [byte ebp+056h], 0
        mov dword [byte ebp+05Ah], 0
        mov dword [byte ebp+042h], 0
        mov eax, dword [byte ebp+022h]
        mov dword [byte ebp+03Ah], 0
        mov dword [byte ebp+046h], 0
        movsx ebx, word [byte eax+02h]
        mov dword [byte ebp+052h], 0
        dec ebx
        jmp near .17
.7:
        mov edx, ebx
        mov eax, dword [byte ebp+022h]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        add eax, edx
        movsx edx, byte [byte eax+02h]
        cmp edx, byte 0FFFFFFFFh
        je near .16
        movsx edx, byte [eax]
        cmp edx, esi
        je short .8
        movsx eax, byte [byte eax+01h]
        cmp eax, esi
        jne near .16
.8:
        mov edx, ebx
        mov eax, dword [byte ebp+022h]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        add eax, edx
        movsx edi, byte [eax]
        cmp edi, esi
        jne short .9
        movsx ecx, byte [byte eax+03h]
        movsx edx, byte [byte eax+02h]
        movsx eax, byte [byte eax+01h]
        mov dword [byte ebp+02Eh], eax
        jmp short .10
.9:
        mov dword [byte ebp+02Eh], edi
        movsx edx, byte [byte eax+03h]
        movsx ecx, byte [byte eax+02h]
.10:
        mov edi, dword [byte ebp+02Eh]
        mov eax, dword [nosplit esi*4+PlayoffColumns]
        shl edi, 2
        cmp eax, dword [dword edi+PlayoffColumns]
        jne short .13
        cmp edx, ecx
        jne short .11
        inc dword [byte ebp+042h]
        jmp short .13
.11:
        jge short .12
        inc dword [byte ebp+03Ah]
        jmp short .13
.12:
        inc dword [byte ebp+046h]
.13:
        mov eax, dword [byte ebp+05Ah]
        add eax, dword [byte ebp+056h]
        add eax, dword [byte ebp+052h]
        cmp eax, byte 0Ah
        je short .16
        cmp edx, ecx
        jne short .14
        inc dword [byte ebp+052h]
        jmp short .16
.14:
        jge short .15
        inc dword [byte ebp+056h]
        jmp short .16
.15:
        inc dword [byte ebp+05Ah]
.16:
        push dword [byte ebp+052h]
        push dword [byte ebp+056h]
        lea eax, [dword ebp-03CAh]
        push dword [byte ebp+05Ah]
        lea edx, [esi+esi*8]
        push str_DDD3
        add eax, edx
        push eax
        call sprintf_
        add esp, byte 14h
        push dword [byte ebp+042h]
        push dword [byte ebp+03Ah]
        push dword [byte ebp+046h]
        lea eax, [dword ebp-02E0h]
        push str_DDD3
        add edx, eax
        push edx
        dec ebx
        call sprintf_
        add esp, byte 14h
.17:
        test ebx, ebx
        jge near .7
        inc esi
        cmp esi, byte 1Ah
        jl near .6
.18:
        cmp dword [byte ebp+026h], byte 0FFFFFFFFh
        jne near StandingsScreen_718.46
        push dword [byte ebp+066h]
        call SetDrawTarget
        add esp, byte 4
        push dword [byte ebp+072h]
        call BlitShape2
        add esp, byte 4
        push dword [byte ebp+03Eh]
        call BlitShape2
        add esp, byte 4
        push dword [byte ebp+02Ah]
        mov esi, 1
        call DrawShapeAtOwnPos
        add esp, byte 4
.19:
        push dword [nosplit esi*4+SeasonSparkleShapes]
        call DrawShapeAtOwnPos
        inc esi
        inc esi
        add esp, byte 4
        cmp esi, byte 8
        jl short .19
        mov eax, dword [StandingsBuffer]
        push dword [byte eax+02Ah]
        push dword [byte eax+026h]
        push dword [byte eax+01Ah]
        call BlitArt
        mov eax, dword [StandingsBuffer]
        add esp, byte 0Ch
        push dword [byte eax+07Ch]
        push dword [byte eax+078h]
        push dword [byte eax+06Ch]
        call BlitArt
        add esp, byte 0Ch
        mov edx, dword [byte ebp+066h]
        lea eax, [dword ebp-01F6h]
        call DrawScrollBar
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        cmp dword [byte ebp+06Eh], byte 0FFFFFFFFh
        je short .20
        mov eax, dword [byte ebp+06Eh]
        push dword [dword ebp+eax*4-08Eh]
        push dword 1A4h
        push dword 10Eh
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
.20:
        xor esi, esi
.21:
        mov eax, dword [dword ebp-01D2h]
        add eax, byte 6Fh
        add eax, esi
        call GetLangText
        push eax
        imul eax, dword [byte ebp+07Eh], byte 12h
        add eax, byte 69h
        push eax
        imul eax, esi, byte 3Ch
        add eax, 122h
        push eax
        push byte 1
        inc esi
        call DrawTextAligned
        add esp, byte 10h
        cmp esi, byte 5
        jl short .21
        inc dword [byte ebp+07Eh]
        xor esi, esi
.22:
        movzx edx, byte [byte esi+ebp-026h]
        mov eax, dword [nosplit edx*4+PlayoffColumns]
        cmp eax, dword [byte ebp+05Eh]
        jne near StandingsScreen_718.34
        mov eax, dword [byte ebp+07Eh]
        shl eax, 2
        cmp dword [byte ebp+07Eh], byte 8
        jle short .23
        mov dword [dword eax+ebp-0FEh], edx
        jmp short .24
.23:
        mov dword [dword eax+ebp-0FAh], edx
.24:
        movzx eax, byte [byte esi+ebp-026h]
        cmp byte [byte eax+ebp-0Ah], 1
        jne short .25
        push dword 0FF00AA00h
        jmp short .27
.25:
        cmp byte [byte eax+ebp-0Ah], 3
        jne short .26
        push dword 0FFAA0000h
        jmp short .27
.26:
        push byte 0FFFFFFFFh
.27:
        call MakeColor
        add esp, byte 4
        call SetTextColor
        movzx eax, byte [byte esi+ebp-026h]
        cmp eax, dword [byte ebp+06Eh]
        jne short .28
        push dword 0FFFFFF50h
        call MakeColor
        add esp, byte 4
        call SetTextColor
.28:
        imul ebx, dword [byte ebp+07Eh], byte 12h
        movzx eax, byte [byte esi+ebp-026h]
        imul eax, byte 66h
        add eax, dword [byte ebp+04Ah]
        add eax, byte 3Eh
        push eax
        add ebx, byte 69h
        push ebx
        push byte 50h
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        cmp dword [byte ebp+07Eh], byte 3
        jge short .29
        push str_Punct_StandingsScreen
        push ebx
        push byte 41h
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
.29:
        xor ebx, ebx
.30:
        mov eax, dword [dword ebp-01D2h]
        add eax, ebx
        cmp eax, byte 8
        ja near StandingsScreen_718.33
        jmp dword [nosplit cs:eax*4+StandingsScreenJumpTable]
StandingsScreen_65C:
        movzx eax, byte [byte esi+ebp-026h]
        imul eax, dword 194Fh
        add eax, dword [byte ebp+07Ah]
        movsx eax, word [byte eax+04Eh]
.31:
        push eax
        push str_D_StandingsScreen
        lea eax, [byte ebp+012h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        jmp near StandingsScreen_718.33
StandingsScreen_685:
        movzx eax, byte [byte esi+ebp-026h]
        imul eax, dword 194Fh
        add eax, dword [byte ebp+07Ah]
        movzx eax, byte [byte eax+050h]
        jmp short StandingsScreen_65C.31
StandingsScreen_699:
        movzx eax, byte [byte esi+ebp-026h]
        imul eax, dword 194Fh
        add eax, dword [byte ebp+07Ah]
        movzx eax, byte [byte eax+051h]
        jmp short StandingsScreen_65C.31
StandingsScreen_6AD:
        movzx eax, byte [byte esi+ebp-026h]
        imul eax, dword 194Fh
        add eax, dword [byte ebp+07Ah]
        movzx eax, byte [byte eax+052h]
        jmp short StandingsScreen_65C.31
StandingsScreen_6C1:
        movzx eax, byte [byte esi+ebp-026h]
        imul eax, dword 194Fh
        add eax, dword [byte ebp+07Ah]
        movzx edx, byte [byte eax+050h]
        movzx eax, byte [byte eax+052h]
        add edx, edx
        add eax, edx
        jmp short StandingsScreen_65C.31
StandingsScreen_6DD:
        movzx eax, byte [byte esi+ebp-026h]
        imul eax, dword 194Fh
        add eax, dword [byte ebp+07Ah]
        movsx eax, word [byte eax+063h]
        jmp near StandingsScreen_65C.31
StandingsScreen_6F4:
        movzx eax, byte [byte esi+ebp-026h]
        imul eax, dword 194Fh
        add eax, dword [byte ebp+07Ah]
        movsx eax, word [byte eax+065h]
        jmp near StandingsScreen_65C.31
StandingsScreen_70B:
        movzx eax, byte [byte esi+ebp-026h]
        lea edx, [dword ebp-03CAh]
        jmp short StandingsScreen_718.32
StandingsScreen_718:
        movzx eax, byte [byte esi+ebp-026h]
        lea edx, [dword ebp-02E0h]
.32:
        lea eax, [eax+eax*8]
        add edx, eax
        lea eax, [byte ebp+012h]
        call strcpy_
.33:
        lea eax, [byte ebp+012h]
        push eax
        imul eax, dword [byte ebp+07Eh], byte 12h
        add eax, byte 69h
        push eax
        imul eax, ebx, byte 3Ch
        add eax, 122h
        push eax
        push byte 1
        inc ebx
        call DrawTextAligned
        add esp, byte 10h
        cmp ebx, byte 5
        jl near StandingsScreen.30
        inc dword [byte ebp+07Eh]
        cmp dword [byte ebp+07Eh], byte 9
        jne short .34
        inc dword [byte ebp+07Eh]
.34:
        inc esi
        cmp esi, byte 1Ah
        jl near StandingsScreen.22
        mov dword [byte ebp+07Eh], 0
        cmp dword [byte ebp+036h], byte 0
        je short .35
        mov eax, dword [byte ebp+066h]
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte eax+02Ch]
        call WipeScreen
        jmp short .36
.35:
        call SetScreenTarget
        push byte 0
        mov eax, dword [byte ebp+066h]
        push byte 0
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
.36:
        push byte 3
        lea eax, [byte ebp+01Eh]
        mov ecx, StandingsSparkle
        mov ebx, 0FFFFFFFFh
        mov edx, dword [StandingsBuffer]
        push eax
        mov eax, 12h
        mov dword [byte ebp+036h], 0
        call RunMenu
        cmp dword [byte ebp+01Eh], byte 2
        jb short .37
        jbe near .42
        cmp dword [byte ebp+01Eh], byte 4
        jb near .43
        jbe near .44
        cmp dword [byte ebp+01Eh], byte 12h
        je short .38
        jmp near .45
.37:
        cmp dword [byte ebp+01Eh], byte 0
        ja short .39
        call FadeInScreen
        mov dword [byte ebp+026h], 1Ah
        jmp near StandingsScreen.18
.38:
        call ExitScreen
        jmp near StandingsScreen.18
.39:
        cmp dword [byte ebp+05Eh], byte 3
        jne short .40
        push str_BGES
        push dword [byte ebp+04Eh]
        call FindShape
        add esp, byte 8
        push str_TTLE
        push dword [byte ebp+076h]
        mov dword [byte ebp+072h], eax
        call FindShape
        add esp, byte 8
        push str_EC00
        push dword [byte ebp+076h]
        mov dword [byte ebp+03Eh], eax
        call FindShape
        add esp, byte 8
        push str_EC01
        mov edx, eax
        mov eax, dword [StandingsBuffer]
        push dword [byte ebp+076h]
        mov dword [byte eax+06Ch], edx
        call FindShape
        add esp, byte 8
        push str_EC01
        mov edx, eax
        mov eax, dword [StandingsBuffer]
        push dword [byte ebp+076h]
        mov dword [byte eax+070h], edx
        call FindShape
        mov edx, eax
        mov eax, dword [StandingsBuffer]
        mov dword [byte ebp+05Eh], 0Ch
        jmp short .41
.40:
        push str_BGWS
        push dword [byte ebp+04Eh]
        call FindShape
        add esp, byte 8
        push str_TTLW
        push dword [byte ebp+076h]
        mov dword [byte ebp+072h], eax
        call FindShape
        add esp, byte 8
        push str_WC00
        push dword [byte ebp+076h]
        mov dword [byte ebp+03Eh], eax
        call FindShape
        add esp, byte 8
        push str_WC01
        mov edx, eax
        mov eax, dword [StandingsBuffer]
        push dword [byte ebp+076h]
        mov dword [byte eax+06Ch], edx
        call FindShape
        add esp, byte 8
        push str_WC01
        mov edx, eax
        mov eax, dword [StandingsBuffer]
        push dword [byte ebp+076h]
        mov dword [byte eax+070h], edx
        call FindShape
        mov edx, eax
        mov eax, dword [StandingsBuffer]
        mov dword [byte ebp+05Eh], 3
.41:
        add esp, byte 8
        mov dword [byte eax+074h], edx
        mov ebx, dword [byte ebp+072h]
        mov edx, ebx
        mov eax, ebx
        call DrawScreenBackground
        lea eax, [dword ebp-01F6h]
        call FreeScrollList
        push byte 0
        push byte 0
        push dword 15Eh
        push dword 172h
        mov ecx, 5
        push dword 0DCh
        mov ebx, 9
        lea eax, [dword ebp-01F6h]
        push dword [byte ebp+072h]
        mov edx, dword [StandingsBuffer]
        push byte 0
        add edx, 0A4h
        mov dword [byte ebp+06Eh], 0FFFFFFFFh
        call InitScrollTable
        jmp near StandingsScreen.18
.42:
        lea eax, [dword ebp-01F6h]
        xor edx, edx
        call ScrollUp
        jmp near StandingsScreen.18
.43:
        mov ebx, eax
        xor edx, edx
        lea eax, [dword ebp-01F6h]
        call ScrollToMouse
        jmp near StandingsScreen.18
.44:
        lea eax, [dword ebp-01F6h]
        xor edx, edx
        call ScrollDown
        jmp near StandingsScreen.18
.45:
        mov eax, dword [byte ebp+01Eh]
        mov eax, dword [dword ebp+eax*4-010Ah]
        mov dword [byte ebp+06Eh], eax
        jmp near StandingsScreen.18
.46:
        call SetNormalText
        lea eax, [dword ebp-01F6h]
        call FreeScrollList
        push dword [byte ebp+04Eh]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+076h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+07Ah]
        call FreeMemBlock
        add esp, byte 4
        push dword [StandingsBuffer]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+04Ah]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+032h]
        call FreeMemBlock
        add esp, byte 4
        lea eax, [byte ebp+022h]
        call FreeDbBlock
        push dword [byte ebp+066h]
        call FreeBitmap
        add esp, byte 4
        jmp near CreateSeason_55B
;-----------------------------------------------------------------------------
; CompareStandingsValue                           91D07  97 PC, low confidence
; Sort helper: compares two standings values
;-----------------------------------------------------------------------------
CompareStandingsValue:
        push ebx
        mov ebx, dword [StandingsSortKey]
        mov edx, dword [edx]
        mov eax, dword [eax]
        mov edx, dword [ebx+edx*4]
        sub edx, dword [ebx+eax*4]
        mov eax, edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CompareStandings                                91D1C  97 PC, low confidence
; Sort helper: compares two teams in the standings
;-----------------------------------------------------------------------------
CompareStandings:
        push ebx
        push ecx
        mov ebx, edx
        movzx edx, byte [eax]
        movzx eax, byte [ebx]
        shl edx, 2
        shl eax, 2
        mov ecx, dword [dword edx+StandingsWins]
        mov ebx, dword [dword eax+StandingsWins]
        add ecx, ecx
        add ebx, ebx
        add ecx, dword [dword edx+StandingsTies]
        add ebx, dword [dword eax+StandingsTies]
        cmp ecx, ebx
        je short .1
        mov eax, ebx
        sub eax, ecx
        pop ecx
        pop ebx
        ret
.1:
        mov ebx, dword [dword edx+StandingsWins]
        cmp ebx, dword [dword eax+StandingsWins]
        je short .2
        mov eax, dword [dword eax+StandingsWins]
        sub eax, ebx
        pop ecx
        pop ebx
        ret
.2:
        mov ebx, dword [dword edx+StandingsGoalsFor]
        sub eax, eax
        sub ebx, dword [dword edx+StandingsGoalsAgainst]
        sub eax, ebx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SortStandings                                   91D7F  97 PC, low confidence
; Sorts the standings
;-----------------------------------------------------------------------------
SortStandings:
        push ecx
        push esi
        push edi
        enter 1A50h, 0
        sub ebp, 82h
        mov esi, eax
        mov dword [byte ebp+072h], edx
        mov edi, 0FFFFFFFFh
        mov dword [byte ebp+06Eh], 0
        mov dword [byte ebp+07Ah], edi
        mov dword [byte ebp+07Eh], edi
        mov dword [byte ebp+076h], edi
.1:
        mov eax, dword [byte ebp+06Eh]
        mov dl, byte [byte ebp+06Eh]
        mov byte [byte eax+ebp+052h], dl
        mov edx, eax
        shl edx, 3
        mov eax, dword [byte ebx+01Ch]
        add eax, edx
        lea edx, [dword ebp-019CEh]
        call FindGameRecord
        mov eax, dword [byte ebp+06Eh]
        movzx edx, byte [dword ebp-0197Eh]
        mov dword [nosplit eax*4+StandingsWins], edx
        movzx edx, byte [dword ebp-0197Ch]
        mov dword [nosplit eax*4+StandingsTies], edx
        movsx edx, word [dword ebp-01969h]
        mov dword [nosplit eax*4+StandingsGoalsAgainst], edx
        movsx edx, word [dword ebp-0196Bh]
        mov dword [nosplit eax*4+StandingsGoalsFor], edx
        movsx edx, word [dword ebp-01980h]
        mov dword [byte ebp+eax*4-07Eh], edx
        mov edx, dword [nosplit eax*4+StandingsWins]
        add edx, edx
        add edx, dword [nosplit eax*4+StandingsTies]
        inc dword [byte ebp+06Eh]
        mov dword [byte ebp+eax*4-016h], edx
        cmp dword [byte ebp+06Eh], byte 1Ah
        jl near .1
        lea edx, [byte ebp-07Eh]
        lea eax, [byte ebp-016h]
        mov ecx, ebx
        mov ebx, dword [byte ebp+072h]
        call CountTeamResults
        mov ecx, CompareStandings
        mov ebx, 1
        mov edx, 1Ah
        lea eax, [byte ebp+052h]
        mov dword [byte ebp+06Eh], 0
        call qsort_
.2:
        mov eax, dword [byte ebp+06Eh]
        movzx eax, byte [byte eax+ebp+052h]
        cmp dword [nosplit eax*4+StandingsColumns], byte 1
        jne short .3
        cmp edi, byte 0FFFFFFFFh
        jne short .3
        mov edi, dword [byte ebp+06Eh]
.3:
        mov eax, dword [byte ebp+06Eh]
        movzx eax, byte [byte eax+ebp+052h]
        cmp dword [nosplit eax*4+StandingsColumns], byte 2
        jne short .4
        cmp dword [byte ebp+07Ah], byte 0FFFFFFFFh
        jne short .4
        mov eax, dword [byte ebp+06Eh]
        mov dword [byte ebp+07Ah], eax
.4:
        mov eax, dword [byte ebp+06Eh]
        movzx eax, byte [byte eax+ebp+052h]
        cmp dword [nosplit eax*4+StandingsColumns], byte 8
        jne short .5
        cmp dword [byte ebp+07Eh], byte 0FFFFFFFFh
        jne short .5
        mov eax, dword [byte ebp+06Eh]
        mov dword [byte ebp+07Eh], eax
.5:
        mov eax, dword [byte ebp+06Eh]
        movzx eax, byte [byte eax+ebp+052h]
        cmp dword [nosplit eax*4+StandingsColumns], byte 4
        jne short .6
        cmp dword [byte ebp+076h], byte 0FFFFFFFFh
        jne short .6
        mov eax, dword [byte ebp+06Eh]
        mov dword [byte ebp+076h], eax
.6:
        inc dword [byte ebp+06Eh]
        cmp dword [byte ebp+06Eh], byte 1Ah
        jl short .2
        cmp edi, dword [byte ebp+07Ah]
        jge short .7
        mov al, byte [byte edi+ebp+052h]
        mov byte [esi], al
        mov eax, dword [byte ebp+07Ah]
        mov al, byte [byte eax+ebp+052h]
        jmp short .8
.7:
        mov eax, dword [byte ebp+07Ah]
        mov al, byte [byte eax+ebp+052h]
        mov byte [esi], al
        mov al, byte [byte edi+ebp+052h]
.8:
        mov byte [byte esi+01h], al
        mov eax, dword [byte ebp+07Eh]
        cmp eax, dword [byte ebp+076h]
        jge short .9
        mov al, byte [byte eax+ebp+052h]
        mov byte [byte esi+02h], al
        mov eax, dword [byte ebp+076h]
        jmp short .10
.9:
        mov eax, dword [byte ebp+076h]
        mov al, byte [byte eax+ebp+052h]
        mov byte [byte esi+02h], al
        mov eax, dword [byte ebp+07Eh]
.10:
        mov al, byte [byte eax+ebp+052h]
        mov byte [byte esi+03h], al
        mov dword [byte ebp+06Eh], 0
        mov eax, 4
.11:
        cmp edi, dword [byte ebp+06Eh]
        je short .12
        mov edx, dword [byte ebp+06Eh]
        cmp edx, dword [byte ebp+07Ah]
        je short .12
        cmp edx, dword [byte ebp+07Eh]
        je short .12
        cmp edx, dword [byte ebp+076h]
        je short .12
        mov ebx, eax
        mov dl, byte [byte edx+ebp+052h]
        inc eax
        mov byte [esi+ebx], dl
.12:
        inc dword [byte ebp+06Eh]
        cmp dword [byte ebp+06Eh], byte 1Ah
        jl short .11
        mov dword [byte ebp+06Eh], 0
.13:
        inc dword [byte ebp+06Eh]
        cmp dword [byte ebp+06Eh], byte 0Ah
        jl short .13
SortStandings_1EA:
        lea esp, [dword ebp+082h]
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; BuildStandingsFactoids                          91F74  97 PC, low confidence
; Standings screen: builds the "ptlist" / "idlist" factoid lines ("%s, %s %s
; %d %s (%s).")
;-----------------------------------------------------------------------------
BuildStandingsFactoids:
        push ecx
        push esi
        push edi
        enter 1B24h, 0
        push eax
        push edx
        push ebx
        sub ebp, 82h
        push byte 0
        push dword 0A28h
        push str_Ptlist
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 1450h
        push str_Idlist
        mov dword [byte ebp+056h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 0A28h
        push str_List
        mov dword [byte ebp+072h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 138h
        push str_Ptlist
        mov dword [byte ebp+06Eh], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 270h
        push str_Idlist
        mov dword [byte ebp+06Ah], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        mov dword [byte ebp+05Eh], 0
        push dword 138h
        mov dword [byte ebp+076h], 0
        mov dword [byte ebp+05Ah], 0
        push str_List
        xor ebx, ebx
        mov dword [byte ebp+062h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp+066h], eax
.1:
        mov eax, ebx
        mov edx, dword [dword ebp-01AAEh]
        shl eax, 3
        mov edx, dword [byte edx+01Ch]
        add eax, edx
        lea edx, [dword ebp-01AA2h]
        xor ecx, ecx
        call FindGameRecord
        jmp short .3
.2:
        imul eax, ecx, byte 38h
        mov edi, dword [byte ebp+076h]
        shl edi, 3
        add edi, dword [byte ebp+072h]
        lea esi, [dword eax+ebp-0D81h]
        movsd
        movsd
        lea edi, [byte ebp+04Eh]
        lea esi, [dword eax+ebp-0D79h]
        lea edx, [byte ebp-02Eh]
        lea eax, [byte ebp+04Eh]
        movsd
        movsd
        call FindTeamStat
        movsx esi, word [byte ebp-014h]
        mov edx, dword [byte ebp+076h]
        movsx eax, word [byte ebp-012h]
        shl edx, 2
        add esi, eax
        mov eax, dword [byte ebp+056h]
        mov dword [edx+eax], esi
        movsx eax, word [byte ebp-016h]
        add dword [byte ebp+05Eh], eax
        mov eax, dword [byte ebp+06Eh]
        inc ecx
        add eax, edx
        mov edx, dword [byte ebp+076h]
        inc dword [byte ebp+076h]
        mov dword [eax], edx
.3:
        movsx eax, word [dword ebp-0D9Dh]
        cmp ecx, eax
        jl short .2
        xor ecx, ecx
        jmp short .7
.4:
        imul eax, ecx, byte 38h
        mov edi, dword [byte ebp+05Ah]
        shl edi, 3
        add edi, dword [byte ebp+062h]
        lea esi, [dword eax+ebp-0807h]
        movsd
        movsd
        lea edi, [byte ebp+04Eh]
        lea esi, [dword eax+ebp-07FFh]
        lea edx, [byte ebp-02Eh]
        lea eax, [byte ebp+04Eh]
        movsd
        movsd
        call FindTeamStat
        mov eax, dword [byte ebp+05Ah]
        shl eax, 2
        add eax, dword [byte ebp+06Ah]
        cmp word [byte ebp+02h], byte 0
        je short .5
        movsx edx, word [byte ebp+02h]
        neg edx
        mov dword [eax], edx
        jmp short .6
.5:
        mov dword [eax], 0FFFFD8F1h
.6:
        mov eax, dword [byte ebp+05Ah]
        shl eax, 2
        mov edx, dword [byte ebp+05Ah]
        add eax, dword [byte ebp+066h]
        inc ecx
        inc dword [byte ebp+05Ah]
        mov dword [eax], edx
.7:
        movsx eax, word [dword ebp-0821h]
        cmp ecx, eax
        jl short .4
        inc ebx
        cmp ebx, byte 1Ah
        jl near .1
        cmp dword [byte ebp+05Eh], byte 0
        je near SortStandings_1EA
        mov eax, dword [byte ebp+056h]
        mov ecx, CompareStandingsValue
        mov ebx, 4
        mov edx, dword [byte ebp+076h]
        mov dword [StandingsSortKey], eax
        mov eax, dword [byte ebp+06Eh]
        call qsort_
        mov eax, dword [byte ebp+06Ah]
        mov ecx, CompareStandingsValue
        mov ebx, 4
        mov edx, dword [byte ebp+05Ah]
        mov dword [StandingsSortKey], eax
        mov eax, dword [byte ebp+066h]
        mov dword [byte ebp+07Eh], 0
        call qsort_
.8:
        mov eax, dword [byte ebp+07Eh]
        shl eax, 2
        add eax, dword [dword ebp-01AA6h]
        mov eax, dword [eax]
        mov dword [byte ebp+07Ah], 0
        xor ebx, ebx
        mov byte [eax], 0
.9:
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [dword ebp-01AAEh]
        shl edx, 3
        mov eax, dword [byte eax+01Ch]
        add eax, edx
        lea edx, [dword ebp-01AA2h]
        xor ecx, ecx
        call FindGameRecord
        jmp near .13
.10:
        imul esi, ecx, byte 38h
        lea edi, [byte ebp+046h]
        lea esi, [dword esi+ebp-0D81h]
        movsd
        movsd
        mov esi, ebx
        shl esi, 2
        add esi, dword [byte ebp+06Eh]
        mov edx, dword [esi]
        shl edx, 3
        lea eax, [byte ebp+046h]
        add edx, dword [byte ebp+072h]
        call KeysEqual
        test eax, eax
        je near .12
        mov eax, dword [esi]
        shl eax, 3
        lea edx, [dword ebp-0152h]
        add eax, dword [byte ebp+072h]
        inc dword [byte ebp+07Ah]
        call FindPlayerRecord
        lea eax, [byte ebx+063h]
        cmp dword [byte ebp+07Ah], byte 2
        jne short .11
        call GetLangText
        push eax
        mov eax, 6Dh
        call GetLangText
        push eax
        mov eax, dword [esi]
        shl eax, 2
        add eax, dword [byte ebp+056h]
        push dword [eax]
        lea eax, [dword ebp-014Ah]
        push eax
        lea eax, [dword ebp-013Ah]
        push eax
        lea eax, [byte ebp+012h]
        push eax
        mov eax, dword [byte ebp+07Eh]
        shl eax, 2
        push str_SSSDSS
        add eax, dword [dword ebp-01AA6h]
        push dword [eax]
        call sprintf_
        add esp, byte 20h
        jmp short .12
.11:
        cmp dword [byte ebp+07Ah], byte 1
        jne short .12
        call GetLangText
        push eax
        mov eax, 6Dh
        call GetLangText
        push eax
        mov eax, dword [esi]
        shl eax, 2
        add eax, dword [byte ebp+056h]
        push dword [eax]
        lea eax, [dword ebp-014Ah]
        push eax
        lea eax, [dword ebp-013Ah]
        push eax
        push str_SSDSS
        lea eax, [byte ebp+012h]
        push eax
        call sprintf_
        add esp, byte 1Ch
.12:
        inc ecx
.13:
        movsx eax, word [dword ebp-0D9Dh]
        cmp ecx, eax
        jl near .10
        inc ebx
        cmp ebx, byte 0Ah
        jl near .9
        cmp dword [byte ebp+07Ah], byte 2
        jge near .18
        mov dword [byte ebp+07Ah], 0
        xor ebx, ebx
.14:
        mov eax, dword [byte ebp+07Eh]
        mov edx, dword [dword ebp-01AAEh]
        shl eax, 3
        mov edx, dword [byte edx+01Ch]
        add eax, edx
        lea edx, [dword ebp-01AA2h]
        xor ecx, ecx
        call FindGameRecord
        jmp near .17
.15:
        imul esi, ecx, byte 38h
        lea edi, [byte ebp+046h]
        lea esi, [dword esi+ebp-0D81h]
        movsd
        movsd
        mov esi, ebx
        shl esi, 2
        add esi, dword [byte ebp+06Eh]
        mov edx, dword [esi]
        shl edx, 3
        lea eax, [byte ebp+046h]
        add edx, dword [byte ebp+072h]
        call KeysEqual
        test eax, eax
        je short .16
        mov eax, dword [esi]
        shl eax, 3
        lea edx, [dword ebp-0152h]
        add eax, dword [byte ebp+072h]
        inc dword [byte ebp+07Ah]
        call FindPlayerRecord
        cmp dword [byte ebp+07Ah], byte 1
        jne short .16
        lea eax, [byte ebx+063h]
        call GetLangText
        push eax
        mov eax, 6Dh
        call GetLangText
        push eax
        mov eax, dword [esi]
        shl eax, 2
        add eax, dword [byte ebp+056h]
        push dword [eax]
        lea eax, [dword ebp-014Ah]
        push eax
        lea eax, [dword ebp-013Ah]
        push eax
        mov eax, dword [byte ebp+07Eh]
        shl eax, 2
        push str_SSDSS2
        add eax, dword [dword ebp-01AA6h]
        push dword [eax]
        call sprintf_
        add esp, byte 1Ch
.16:
        inc ecx
.17:
        movsx eax, word [dword ebp-0D9Dh]
        cmp ecx, eax
        jl near .15
        inc ebx
        cmp ebx, byte 5
        jl near .14
.18:
        cmp dword [byte ebp+07Ah], byte 0
        jne near .23
        xor ebx, ebx
.19:
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [dword ebp-01AAEh]
        shl edx, 3
        mov eax, dword [byte eax+01Ch]
        add eax, edx
        lea edx, [dword ebp-01AA2h]
        xor ecx, ecx
        call FindGameRecord
        jmp near .22
.20:
        imul esi, ecx, byte 38h
        lea edi, [byte ebp+046h]
        lea esi, [dword esi+ebp-0807h]
        movsd
        movsd
        mov esi, ebx
        shl esi, 2
        add esi, dword [byte ebp+066h]
        mov edx, dword [esi]
        shl edx, 3
        lea eax, [byte ebp+046h]
        add edx, dword [byte ebp+062h]
        call KeysEqual
        test eax, eax
        je short .21
        mov eax, dword [esi]
        shl eax, 3
        lea edx, [dword ebp-0152h]
        add eax, dword [byte ebp+062h]
        inc dword [byte ebp+07Ah]
        call FindPlayerRecord
        cmp dword [byte ebp+07Ah], byte 1
        jne short .21
        lea eax, [byte ebx+063h]
        call GetLangText
        push eax
        mov eax, 6Eh
        call GetLangText
        mov esi, dword [esi]
        shl esi, 2
        add esi, dword [byte ebp+06Ah]
        mov esi, dword [esi]
        neg esi
        push eax
        mov eax, esi
        mov edi, 64h
        cdq
        idiv edi
        mov eax, esi
        push edx
        cdq
        idiv edi
        push eax
        lea eax, [dword ebp-014Ah]
        push eax
        lea eax, [dword ebp-013Ah]
        push eax
        mov eax, dword [byte ebp+07Eh]
        shl eax, 2
        push str_SSD02dSS
        add eax, dword [dword ebp-01AA6h]
        push dword [eax]
        call sprintf_
        add esp, byte 20h
.21:
        inc ecx
.22:
        movsx eax, word [dword ebp-0821h]
        cmp ecx, eax
        jl near .20
        inc ebx
        cmp ebx, byte 5
        jl near .19
.23:
        mov edx, dword [dword ebp-01AAEh]
        movsx edx, word [byte edx+02h]
        mov eax, dword [SeasonUserTeam]
        add edx, edx
        movsx ebx, word [eax]
        mov eax, edx
        cdq
        idiv ebx
        movsx edx, word [dword ebp-01A54h]
        sub eax, byte 7
        cmp edx, eax
        jle near .29
        mov eax, dword [dword ebp-01AAAh]
        add eax, dword [byte ebp+07Eh]
        cmp byte [eax], 2
        jne near .29
        mov eax, 78h
        call GetLangText
        push eax
        mov eax, dword [byte ebp+07Eh]
        shl eax, 2
        push str_S3
        add eax, dword [dword ebp-01AA6h]
        push dword [eax]
        xor ebx, ebx
        call sprintf_
        add esp, byte 0Ch
        jmp near .28
.24:
        mov eax, ebx
        mov edx, dword [dword ebp-01AAEh]
        shl eax, 4
        mov edx, dword [byte edx+020h]
        add eax, edx
        movsx edx, byte [byte eax+02h]
        cmp edx, byte 0FFFFFFFFh
        jne short .27
        movsx edx, byte [eax]
        cmp edx, dword [byte ebp+07Eh]
        jne short .25
        movsx eax, byte [byte eax+01h]
        mov edx, dword [dword ebp-01AAEh]
        shl eax, 3
        mov edx, dword [byte edx+014h]
        jmp short .26
.25:
        movsx eax, byte [byte eax+01h]
        cmp eax, dword [byte ebp+07Eh]
        jne short .27
        mov eax, dword [dword ebp-01AAEh]
        shl edx, 3
        mov eax, dword [byte eax+014h]
.26:
        add eax, edx
        lea edx, [dword ebp-096h]
        call FindTeamRecord
        lea eax, [byte ebp-070h]
        push eax
        push str_S4
        lea eax, [byte ebp+012h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea edx, [byte ebp+012h]
        mov eax, dword [ecx]
        call strcat_
.27:
        inc ebx
.28:
        mov ecx, dword [byte ebp+07Eh]
        mov eax, dword [dword ebp-01AAEh]
        shl ecx, 2
        movsx eax, word [byte eax+02h]
        add ecx, dword [dword ebp-01AA6h]
        cmp ebx, eax
        jl near .24
        mov eax, dword [ecx]
        call strlen_
        mov edx, dword [ecx]
        mov byte [byte edx+eax-02h], 0
.29:
        inc dword [byte ebp+07Eh]
        cmp dword [byte ebp+07Eh], byte 1Ah
        jl near .8
        push dword [byte ebp+072h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+06Eh]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+056h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+062h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+066h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+06Ah]
        call FreeMemBlock
        add esp, byte 4
        jmp near SortStandings_1EA
