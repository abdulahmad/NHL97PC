; Create player screen: name, position, hand, size, age and ratings.
bits 32
%include "hockey.inc"
section s_CEC15 progbits alloc exec nowrite align=1
extern _dos_getdate_, AgeFromBirthDate, AllocMemBlock, BlankMenuItem, BlitArt, BlitShape, ChangeMenuMusic, ClearPlayerRecord
extern ConvertArtXY, CreateBitmap, CreateGoalieMode, CreateGoalieRatings, CreateGoalieRows, CreatePlayerItems, CreatePlayerSlot, CreateSkaterRatings
extern CreateSkaterRows, DaysToYear, DrawArt, DrawRosterList_86F, DrawScreenBackground, DrawStatsBackground, DrawTextAligned, EditTextField
extern ExitScreen, FadeInScreen, FillRect, FindShape, FreeBitmap, FreeMemBlock, FreeStatsBitmap, GameSettings
extern GetLangText, InchesToCm, InitListBox, InitMenuItems, JerseyScreen, LinkGameActive, LoadDataFile, MakeColor
extern MeasureText, memmove_, memset_, NewPlayerRecord, PlayerBioScreen, PlayScreenMovie, PoundsToKg, PresentScreen
extern RatingBarArt, RatingBarBackArt, RatingBarLitArt, RatingBarLitBackArt, RatingPanelFrame, RatingPanelShapeFile, RatingPanelTick, RatingPointsLeft
extern RemoveFromLines_61, ResetClipWindow, RunMenu, ScreenFrameItem, ScreenTitleItem, SecondsToSamples, SetClipWindow, SetDrawTarget
extern SetScreenTarget, SetTextColor, ShowMessageBox, ShowScreen, ShowStatsScreen, sprintf_, StatsBackItem, str_00008
extern str_AGOF, str_AGON, str_AN02d, str_CEOF, str_CEON, str_CreatePlrMenu, str_CreatePlrRegion, str_CS2
extern str_D_JerseyScreen, str_DEOF, str_DEON, str_GLOF, str_GLON, str_GOOF, str_GOON, str_GROF
extern str_GRON, str_HEOF, str_HEON, str_JNOF, str_JNON, str_LWOF, str_LWON, str_NAM1
extern str_NAOF, str_NAON, str_PBOF, str_PBON, str_POB1, str_RWOF, str_RWON, str_S_DrawCreatePlayerLabel
extern str_SLOF, str_SLON, str_SROF, str_SRON, str_SS11, str_STSG, str_STSP, str_TITL11
extern str_WEOF, str_WEON, strcpy_, tickcount, WaitSoundTime, WipeScreen
global ShowCreatePlayerHelp, DrawCreatePlayerName, DrawCreatePlayerName_D4, DrawCreatePlayerName_110, DrawCreatePlayerName_12B, DrawCreatePlayerPanel, DrawCreatePlayerPanel_83, DrawCreatePlayerPanel_8D
global DrawCreatePlayerPosition, DrawCreatePlayerPosition_B1, DrawCreatePlayerHand, DrawCreatePlayerLabel, DrawCreatePlayerHeight, DrawCreatePlayerWeight, DrawCreatePlayerAge, DrawRatingBarSlot
global DrawRatingBars, DrawRatingBars_152, DrawRatingBars_157, DrawRatingBars_158, DrawRatingValues, DrawRatingPanel, DrawCreatePlayerField, DrawCreatePlayerText
global DrawCreatePlayerText_20, DrawCreatePlayerNameLine, CreatePlayerScreen, DrawRatingBar, InitShapeListBox, SetupCreatePlayerLists, InitCreatePlayerScreen, NewSkaterRecord
global NewSkaterRecord_146, NewGoalieRecord, PlayerOverall, RemoveListEntry
;-----------------------------------------------------------------------------
; ShowCreatePlayerHelp                            CEC15  97 PC, low confidence
; Shows the create player help line
;-----------------------------------------------------------------------------
ShowCreatePlayerHelp:
        push ebx
        push ecx
        push edx
        push esi
        xor esi, esi
        cmp byte [byte eax+077h], 0
        je short .1
        cmp byte [byte eax+067h], 0
        je short .1
        cmp byte [dword eax+091h], 0
        je short .1
        mov esi, 1
        jmp short .2
.1:
        push byte 1
        mov eax, 0EBh
        mov edx, 1
        xor ecx, ecx
        xor ebx, ebx
        call GetLangText
        call ShowMessageBox
.2:
        mov eax, esi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawCreatePlayerName                            CEC58  97 PC, low confidence
; Create player screen: the name panel (NAM1, "%c. %s")
;-----------------------------------------------------------------------------
DrawCreatePlayerName:
        push esi
        push edi
        enter 8, 0
        mov esi, eax
        mov edi, edx
        mov dword [byte ebp-04h], ecx
        mov eax, ebx
        mov ebx, dword [byte ebp+010h]
        cmp byte [byte edx+077h], 0
        je near .3
        cmp byte [byte edx+067h], 0
        je near .3
        push str_NAM1
        push eax
        call FindShape
        add esp, byte 8
        push dword [byte ebp-04h]
        mov dword [byte ebp-08h], eax
        call SetDrawTarget
        movsx eax, word [byte ebx+0Eh]
        add esp, byte 4
        sub eax, dword [byte esi+02Ah]
        push eax
        movsx eax, word [byte ebx+0Ch]
        sub eax, dword [byte esi+026h]
        push eax
        push ebx
        call BlitArt
        add esp, byte 0Ch
        push byte 0
        push byte 0
        push dword [byte ebp-08h]
        call BlitArt
        add esp, byte 0Ch
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        lea ebx, [byte edi+077h]
        call SetTextColor
        push ebx
        call MeasureText
        add esp, byte 4
        push ebx
        mov dword [byte ebp-08h], eax
        call MeasureText
        add eax, dword [byte ebp-08h]
        lea ecx, [byte eax+0Ah]
        mov eax, dword [byte esi+026h]
        mov edx, 280h
        add eax, byte 20h
        add esp, byte 4
        sub edx, eax
        lea eax, [byte edi+067h]
        cmp ecx, edx
        jle short .2
        push eax
        movzx eax, byte [byte edi+077h]
        push eax
        push str_CS2
.1:
        push byte 4
        push byte 20h
        push byte 0
        call DrawTextAligned
        add esp, byte 18h
        jmp short DrawCreatePlayerName_110
.2:
        push eax
        push ebx
        push str_SS11
        jmp short .1
.3:
        push str_NAOF
DrawCreatePlayerName_D4:
        push eax
        call FindShape
        add esp, byte 8
        push dword [byte ebp-04h]
        mov edi, eax
        call SetDrawTarget
        movsx eax, word [byte ebx+0Eh]
        add esp, byte 4
        sub eax, dword [byte esi+02Ah]
        push eax
        movsx eax, word [byte ebx+0Ch]
        sub eax, dword [byte esi+026h]
        push eax
        push ebx
        call BlitArt
        add esp, byte 0Ch
        push byte 0
        push byte 0
        push edi
        call BlitArt
        add esp, byte 0Ch
DrawCreatePlayerName_110:
        call SetScreenTarget
        push dword [byte esi+02Ah]
        push dword [byte esi+026h]
        push dword [byte esi+01Ah]
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
DrawCreatePlayerName_12B:
        leave
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; DrawCreatePlayerPanel                           CED89  97 PC, low confidence
; Draws the create player panel
;-----------------------------------------------------------------------------
DrawCreatePlayerPanel:
        push ecx
        push esi
        push edi
        enter 0Ch, 0
        mov esi, eax
        mov edi, edx
        mov dword [byte ebp-04h], ebx
        mov eax, dword [byte eax+01Ah]
        mov ebx, dword [byte esi+026h]
        movsx eax, word [byte eax+04h]
        add ebx, eax
        mov dword [byte ebp-08h], ebx
        lea eax, [byte ebx+014h]
        mov ebx, dword [byte esi+02Ah]
        mov dword [byte ebp-0Ch], eax
        add ebx, byte 4
        call SetScreenTarget
        lea eax, [byte ebx+010h]
        push eax
        mov eax, dword [byte ebp-08h]
        push ebx
        add eax, byte 78h
        push eax
        push dword [byte ebp-0Ch]
        call SetClipWindow
        add esp, byte 10h
        push dword [byte ebp-04h]
        call BlitShape
        add esp, byte 4
        call ResetClipWindow
        push dword [byte esi+02Ah]
        push dword [byte esi+026h]
        push dword [byte esi+01Ah]
        call BlitArt
        add esp, byte 0Ch
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        movzx eax, byte [byte edi+01h]
        push eax
        push str_D_JerseyScreen
        push ebx
        push dword [byte ebp-0Ch]
DrawCreatePlayerPanel_83:
        push byte 0
        call DrawTextAligned
        add esp, byte 14h
DrawCreatePlayerPanel_8D:
        call PresentScreen
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; DrawCreatePlayerPosition                        CEE20  97 PC, low confidence
; From CreatePlayerScreen: the position buttons (GO / LW / RW / CE, ON / OF
; art)
;-----------------------------------------------------------------------------
DrawCreatePlayerPosition:
        push ecx
        push esi
        push edi
        mov esi, eax
        mov al, byte [byte edx+02h]
        cmp al, 47h
        jb short .1
        jbe short .2
        cmp al, 4Ch
        jb near .8
        jbe short .3
        cmp al, 52h
        je short .4
        jmp near .8
.1:
        cmp al, 43h
        jb near .8
        jbe short .5
        cmp al, 44h
        je short .6
        jmp near .8
.2:
        push str_GOOF
        push ebx
        call FindShape
        add esp, byte 8
        push str_GOON
        jmp short .7
.3:
        push str_LWOF
        push ebx
        call FindShape
        add esp, byte 8
        push str_LWON
        jmp short .7
.4:
        push str_RWOF
        push ebx
        call FindShape
        add esp, byte 8
        push str_RWON
        jmp short .7
.5:
        push str_CEOF
        push ebx
        call FindShape
        add esp, byte 8
        push str_CEON
        jmp short .7
.6:
        push str_DEOF
        push ebx
        call FindShape
        add esp, byte 8
        push str_DEON
.7:
        push ebx
        mov edi, eax
        call FindShape
        mov ecx, eax
        add esp, byte 8
.8:
        mov dword [byte esi+01Ah], edi
        mov dword [byte esi+022h], ecx
        mov dword [byte esi+01Eh], ecx
DrawCreatePlayerPosition_B1:
        call SetScreenTarget
        push dword [byte esi+01Ah]
        call BlitShape
        add esp, byte 4
        call PresentScreen
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; DrawCreatePlayerHand                            CEEEA  97 PC, low confidence
; From CreatePlayerScreen: the shoots / catches buttons (SR / SL skater, GR /
; GL goalie, ON / OF art)
;-----------------------------------------------------------------------------
DrawCreatePlayerHand:
        push ecx
        push esi
        push edi
        mov esi, eax
        mov eax, edx
        cmp byte [byte edx+048h], 1
        jne short .2
        cmp byte [byte edx+02h], 47h
        je short .1
        push str_SROF
        push ebx
        call FindShape
        add esp, byte 8
        push str_SRON
        jmp short .4
.1:
        push str_GROF
        push ebx
        call FindShape
        add esp, byte 8
        push str_GRON
        jmp short .4
.2:
        cmp byte [byte edx+02h], 47h
        je short .3
        push str_SLOF
        push ebx
        call FindShape
        add esp, byte 8
        push str_SLON
        jmp short .4
.3:
        push str_GLOF
        push ebx
        call FindShape
        add esp, byte 8
        push str_GLON
.4:
        push ebx
        mov edi, eax
        call FindShape
        add esp, byte 8
        mov dword [byte esi+01Ah], edi
        mov dword [byte esi+022h], eax
        mov dword [byte esi+01Eh], eax
        jmp near DrawCreatePlayerPosition_B1
;-----------------------------------------------------------------------------
; DrawCreatePlayerLabel                           CEF6E  97 PC, low confidence
; Draws a create player label
;-----------------------------------------------------------------------------
DrawCreatePlayerLabel:
        push esi
        push edi
        enter 8, 0
        mov esi, eax
        mov edi, edx
        mov dword [byte ebp-04h], ecx
        mov eax, ebx
        mov ebx, dword [byte ebp+010h]
        cmp byte [dword edx+091h], 0
        je short .1
        push str_POB1
        push eax
        call FindShape
        add esp, byte 8
        push dword [byte ebp-04h]
        mov dword [byte ebp-08h], eax
        call SetDrawTarget
        movsx eax, word [byte ebx+0Eh]
        add esp, byte 4
        sub eax, dword [byte esi+02Ah]
        push eax
        movsx eax, word [byte ebx+0Ch]
        sub eax, dword [byte esi+026h]
        push eax
        push ebx
        call BlitArt
        add esp, byte 0Ch
        push byte 0
        push byte 0
        push dword [byte ebp-08h]
        call BlitArt
        add esp, byte 0Ch
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        add edi, 91h
        call SetTextColor
        push edi
        push str_S_DrawCreatePlayerLabel
        push byte 4
        push byte 20h
        push byte 0
        call DrawTextAligned
        add esp, byte 14h
        jmp near DrawCreatePlayerName_110
.1:
        push str_PBOF
        jmp near DrawCreatePlayerName_D4
;-----------------------------------------------------------------------------
; DrawCreatePlayerHeight                          CF005  97 PC, low confidence
; Create player screen: the height field ("%d feet %d inches")
;-----------------------------------------------------------------------------
DrawCreatePlayerHeight:
        push ecx
        push esi
        push edi
        enter 8, 0
        mov esi, eax
        mov edi, edx
        mov dword [byte ebp-08h], ebx
        mov eax, dword [byte eax+01Ah]
        movsx eax, word [byte eax+04h]
        add eax, dword [byte esi+026h]
        mov ebx, dword [byte esi+02Ah]
        add eax, byte 14h
        add ebx, byte 4
        mov dword [byte ebp-04h], eax
        call SetScreenTarget
        lea eax, [byte ebx+010h]
        push eax
        push ebx
        push dword 280h
        push dword [byte ebp-04h]
        call SetClipWindow
        add esp, byte 10h
        push dword [byte ebp-08h]
        call BlitShape
        add esp, byte 4
        call ResetClipWindow
        push dword [byte esi+02Ah]
        push dword [byte esi+026h]
        push dword [byte esi+01Ah]
        call BlitArt
        add esp, byte 0Ch
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        movsx esi, word [byte edi+059h]
        test byte [GameSettings], 0Ch
        jne short .1
        mov eax, esi
        mov ecx, 0Ch
        cdq
        idiv ecx
        mov edi, eax
        mov eax, esi
        jmp short .2
.1:
        mov eax, esi
        mov edi, 64h
        call InchesToCm
        mov esi, eax
        cdq
        idiv edi
        mov edi, eax
        mov eax, esi
        mov ecx, 64h
.2:
        cdq
        idiv ecx
        push edx
        push edi
        mov eax, 0ECh
        call GetLangText
        push eax
        push ebx
        push dword [byte ebp-04h]
        push byte 0
        call DrawTextAligned
        add esp, byte 18h
        jmp near DrawCreatePlayerPanel_8D
;-----------------------------------------------------------------------------
; DrawCreatePlayerWeight                          CF0CD  97 PC, low confidence
; Create player screen: the weight field ("%d pounds")
;-----------------------------------------------------------------------------
DrawCreatePlayerWeight:
        push ecx
        push esi
        push edi
        enter 8, 0
        mov esi, eax
        mov edi, edx
        mov dword [byte ebp-08h], ebx
        mov eax, dword [byte eax+01Ah]
        movsx eax, word [byte eax+04h]
        add eax, dword [byte esi+026h]
        mov ebx, dword [byte esi+02Ah]
        add eax, byte 14h
        add ebx, byte 4
        mov dword [byte ebp-04h], eax
        call SetScreenTarget
        lea eax, [byte ebx+010h]
        push eax
        push ebx
        push dword 280h
        push dword [byte ebp-04h]
        call SetClipWindow
        add esp, byte 10h
        push dword [byte ebp-08h]
        call BlitShape
        add esp, byte 4
        call ResetClipWindow
        push dword [byte esi+02Ah]
        push dword [byte esi+026h]
        push dword [byte esi+01Ah]
        call BlitArt
        add esp, byte 0Ch
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        movsx eax, word [byte edi+05Bh]
        test byte [GameSettings], 0Ch
        je short .1
        call PoundsToKg
.1:
        push eax
        mov eax, 0EDh
        call GetLangText
        push eax
        push ebx
        push dword [byte ebp-04h]
        jmp near DrawCreatePlayerPanel_83
;-----------------------------------------------------------------------------
; DrawCreatePlayerAge                             CF162  97 PC, low confidence
; Draws the created player's age
;-----------------------------------------------------------------------------
DrawCreatePlayerAge:
        push ecx
        push esi
        push edi
        enter 14h, 0
        mov esi, eax
        mov edi, ebx
        lea ecx, [byte ebp-0Ch]
        lea ebx, [byte ebp-08h]
        movzx eax, word [dword edx+0B9h]
        lea edx, [byte ebp-04h]
        call AgeFromBirthDate
        movsx eax, word [byte ebp-04h]
        mov edx, 7CDh
        sub edx, eax
        mov eax, dword [byte esi+01Ah]
        movsx eax, word [byte eax+04h]
        mov ebx, dword [byte esi+02Ah]
        add eax, dword [byte esi+026h]
        add ebx, byte 4
        add eax, byte 14h
        mov dword [byte ebp-010h], edx
        mov dword [byte ebp-014h], eax
        call SetScreenTarget
        lea eax, [byte ebx+010h]
        push eax
        push ebx
        push dword 280h
        push dword [byte ebp-014h]
        call SetClipWindow
        add esp, byte 10h
        push edi
        call BlitShape
        add esp, byte 4
        call ResetClipWindow
        push dword [byte esi+02Ah]
        push dword [byte esi+026h]
        push dword [byte esi+01Ah]
        call BlitArt
        add esp, byte 0Ch
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        push dword [byte ebp-010h]
        push str_D_JerseyScreen
        push ebx
        push dword [byte ebp-014h]
        jmp near DrawCreatePlayerPanel_83
;-----------------------------------------------------------------------------
; DrawRatingBarSlot                               CF1FF  97 PC, low confidence
; Draws one rating bar slot
;-----------------------------------------------------------------------------
DrawRatingBarSlot:
        push ebx
        push ecx
        push edx
        cmp dword [CreateGoalieMode], byte 1
        jne short .1
        push byte 1
        mov ecx, 5
        mov ebx, 19Eh
        push dword [RatingBarLitArt]
        mov edx, 1D0h
        push dword [RatingBarLitBackArt]
        jmp short .2
.1:
        push byte 1
        mov ecx, 5
        mov ebx, 19Eh
        push dword [RatingBarBackArt]
        mov edx, 1D0h
        push dword [RatingBarArt]
.2:
        mov eax, 70h
        call DrawRatingBar
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawRatingBars                                  CF255  97 PC, low confidence
; Draws the rating bars
;-----------------------------------------------------------------------------
DrawRatingBars:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 20h, 0
        mov dword [byte ebp-014h], 3
        cmp dword [CreateGoalieMode], byte 1
        jne short .1
        push str_STSP
        push eax
        call FindShape
        add esp, byte 8
        push eax
        mov dword [byte ebp-018h], 0Eh
        jmp short .2
.1:
        push str_STSG
        push eax
        call FindShape
        add esp, byte 8
        push eax
        mov dword [byte ebp-018h], 9
.2:
        call BlitShape
        add esp, byte 4
        mov dword [byte ebp-04h], 0
        jmp near .8
.3:
        shl eax, 2
        cmp dword [CreateGoalieMode], byte 1
        jne short .4
        mov edx, dword [CreateGoalieRatings]
        jmp short .5
.4:
        mov edx, dword [CreateSkaterRatings]
.5:
        mov eax, dword [edx+eax]
        movzx eax, byte [eax]
        add eax, byte 0Ah
        imul eax, byte 5Fh
        mov ecx, 19h
        cdq
        idiv ecx
        mov edi, eax
        mov eax, dword [byte ebp-04h]
        add eax, byte 0Bh
        imul eax, byte 52h
        mov edx, dword [CreatePlayerItems]
        add eax, edx
        mov edx, dword [byte ebp-04h]
        add edx, byte 19h
        imul edx, byte 52h
        mov ecx, 5Fh
        sub ecx, edi
        mov dword [byte ebp-01Ch], ecx
        mov ecx, edi
        mov dword [byte ebp-020h], 6
        sub ecx, dword [byte ebp-014h]
        mov esi, dword [byte eax+02Ah]
        mov dword [byte ebp-0Ch], edx
        test byte [byte ebp-04h], 1
        jne short .6
        push byte 6
        mov edx, dword [byte eax+026h]
        mov ebx, esi
        mov dword [byte ebp-08h], edx
        call InitListBox
        push byte 6
        mov edx, dword [byte ebp-08h]
        mov ecx, dword [byte ebp-01Ch]
        mov eax, dword [CreatePlayerItems]
        mov ebx, esi
        add eax, dword [byte ebp-0Ch]
        add edx, edi
        mov dword [byte ebp-010h], 1
        jmp short .7
.6:
        mov edx, 1B1h
        push byte 6
        sub edx, edi
        mov ebx, esi
        add edx, dword [byte ebp-014h]
        mov dword [byte ebp-010h], 0FFFFFFFFh
        call InitListBox
        mov eax, dword [CreatePlayerItems]
        push byte 6
        add eax, dword [byte ebp-0Ch]
        mov ecx, dword [byte ebp-01Ch]
        mov ebx, esi
        mov edx, dword [byte eax+026h]
        mov dword [byte ebp-08h], 1B1h
.7:
        call InitListBox
        push dword [byte ebp-010h]
        mov ecx, dword [byte ebp-020h]
        push byte 5Fh
        mov ebx, 5Fh
        mov eax, dword [byte ebp-08h]
        push edi
        mov edx, esi
        inc dword [byte ebp-04h]
        call DrawRatingBar
.8:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [byte ebp-018h]
        jl near .3
DrawRatingBars_152:
        call DrawRatingBarSlot
DrawRatingBars_157:
        leave
DrawRatingBars_158:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawRatingValues                                CF3B3  97 PC, low confidence
; Draws the rating values
;-----------------------------------------------------------------------------
DrawRatingValues:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 34h, 0
        mov eax, dword [tickcount]
        mov dword [byte ebp-010h], 0
        mov dword [byte ebp-030h], eax
        xor esi, esi
        cmp eax, dword [RatingPointsLeft]
        jle short DrawRatingBars_157
        mov eax, 1
        mov ebx, 0Bh
        mov dword [byte ebp-024h], 4
        mov ecx, dword [CreatePlayerItems]
.1:
        imul edx, ebx, byte 52h
        add edx, ecx
        cmp dword [byte edx+04h], byte 2
        jne near .4
        lea ecx, [byte esi+01h]
        lea edx, [byte ebx-0Bh]
        mov dword [byte ebp-01Ch], ecx
        mov ecx, edx
        shl ecx, 2
        inc dword [byte ebp-010h]
        mov dword [byte ebp-04h], ecx
        cmp dword [CreateGoalieMode], byte 1
        jne short .3
        mov edx, dword [RatingBarLitBackArt]
        cmp edx, dword [RatingBarLitArt]
        jge near .5
        mov edx, dword [CreateGoalieRatings]
        add edx, ecx
        mov ecx, dword [edx]
        cmp byte [ecx], 0
        jbe short .5
        add dword [RatingBarLitBackArt], eax
        mov edx, dword [edx]
        sub byte [edx], al
        mov edi, dword [CreateGoalieRatings]
        add edi, dword [byte ebp-04h]
        mov edi, dword [edi]
.2:
        mov esi, dword [byte ebp-01Ch]
        movzx edi, byte [edi]
        jmp short .5
.3:
        cmp edx, byte 9
        jge short .5
        mov edx, dword [RatingBarArt]
        cmp edx, dword [RatingBarBackArt]
        jge short .5
        mov edx, dword [CreateSkaterRatings]
        add edx, ecx
        mov ecx, dword [edx]
        cmp byte [ecx], 0
        jbe short .5
        add dword [RatingBarArt], eax
        mov edx, dword [edx]
        sub byte [edx], al
        mov edx, dword [CreateSkaterRatings]
        add edx, dword [byte ebp-04h]
        mov edi, dword [edx]
        jmp short .2
.4:
        inc ebx
        cmp ebx, byte 19h
        jl near .1
.5:
        cmp dword [byte ebp-010h], byte 0
        jne near .11
        mov ebx, 19h
        mov ecx, dword [CreatePlayerItems]
.6:
        imul edx, ebx, byte 52h
        add edx, ecx
        cmp dword [byte edx+04h], byte 2
        jne near .10
        lea ecx, [byte esi+01h]
        lea edx, [byte ebx-019h]
        mov dword [byte ebp-018h], ecx
        mov ecx, edx
        shl ecx, 2
        mov dword [byte ebp-0Ch], ecx
        cmp dword [CreateGoalieMode], byte 1
        jne short .7
        cmp dword [RatingBarLitBackArt], byte 0
        jle short .9
        mov edx, dword [CreateGoalieRatings]
        add edx, ecx
        mov ecx, dword [edx]
        cmp byte [ecx], 0Dh
        jae short .9
        sub dword [RatingBarLitBackArt], eax
        mov edx, dword [edx]
        add byte [edx], al
        mov edi, dword [CreateGoalieRatings]
        add edi, dword [byte ebp-0Ch]
        mov edi, dword [edi]
        jmp short .8
.7:
        cmp edx, byte 9
        jge short .9
        cmp dword [RatingBarArt], byte 0
        jle short .9
        mov edx, dword [CreateSkaterRatings]
        add edx, ecx
        mov ecx, dword [edx]
        cmp byte [ecx], 0Dh
        jae short .9
        sub dword [RatingBarArt], eax
        mov edx, dword [edx]
        add byte [edx], al
        mov eax, dword [CreateSkaterRatings]
        add eax, dword [byte ebp-0Ch]
        mov edi, dword [eax]
.8:
        mov esi, dword [byte ebp-018h]
        movzx edi, byte [edi]
.9:
        sub ebx, byte 0Eh
        jmp short .11
.10:
        inc ebx
        cmp ebx, byte 27h
        jl near .6
.11:
        mov eax, dword [byte ebp-030h]
        inc eax
        mov dword [RatingPointsLeft], eax
        test esi, esi
        je near DrawRatingBars_157
        add edi, byte 0Ah
        imul eax, edi, byte 5Fh
        mov ecx, 19h
        cdq
        idiv ecx
        mov edi, eax
        imul eax, ebx, byte 52h
        mov edx, dword [CreatePlayerItems]
        add eax, edx
        lea edx, [byte ebx+0Eh]
        mov dword [byte ebp-02Ch], edx
        mov edx, 5Fh
        sub edx, edi
        mov dword [byte ebp-014h], edx
        imul edx, dword [byte ebp-02Ch], byte 52h
        mov ecx, edi
        sub ecx, dword [byte ebp-024h]
        mov dword [byte ebp-034h], 6
        dec ecx
        mov esi, dword [byte eax+02Ah]
        mov dword [byte ebp-028h], edx
        test bl, 1
        je short .12
        push byte 6
        mov edx, dword [byte eax+026h]
        mov ebx, esi
        mov dword [byte ebp-08h], edx
        call InitListBox
        push byte 6
        mov edx, dword [byte ebp-08h]
        mov ecx, dword [byte ebp-014h]
        mov eax, dword [CreatePlayerItems]
        mov ebx, esi
        add eax, dword [byte ebp-028h]
        add edx, edi
        mov dword [byte ebp-020h], 1
        jmp short .13
.12:
        mov edx, 1B1h
        sub edx, edi
        push byte 6
        add edx, dword [byte ebp-024h]
        mov ebx, esi
        inc edx
        mov dword [byte ebp-020h], 0FFFFFFFFh
        call InitListBox
        mov eax, dword [CreatePlayerItems]
        push byte 6
        add eax, dword [byte ebp-028h]
        mov ecx, dword [byte ebp-014h]
        mov ebx, esi
        mov edx, dword [byte eax+026h]
        mov dword [byte ebp-08h], 1B1h
.13:
        call InitListBox
        push dword [byte ebp-020h]
        push byte 5Fh
        mov ecx, dword [byte ebp-034h]
        mov ebx, 5Fh
        push edi
        mov eax, dword [byte ebp-08h]
        mov edx, esi
        call DrawRatingBar
        jmp near DrawRatingBars_152
;-----------------------------------------------------------------------------
; DrawRatingPanel                                 CF626  97 PC, low confidence
; Draws the rating panel
;-----------------------------------------------------------------------------
DrawRatingPanel:
        push ebx
        push ecx
        push edx
        enter 8, 0
        call DrawRatingValues
        mov eax, dword [tickcount]
        mov ebx, eax
        cmp eax, dword [RatingPanelTick]
        jle short .3
        cmp dword [RatingPanelFrame], byte 7
        jg short .1
        cmp dword [RatingPanelFrame], byte 0
        jge short .2
.1:
        mov dword [RatingPanelFrame], 0
.2:
        mov eax, dword [RatingPanelFrame]
        push eax
        push str_AN02d
        lea edx, [byte ebp-08h]
        inc eax
        push edx
        mov dword [RatingPanelFrame], eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-08h]
        push eax
        push dword [RatingPanelShapeFile]
        call FindShape
        add esp, byte 8
        push eax
        add ebx, byte 0Ah
        call BlitShape
        add esp, byte 4
        mov dword [RatingPanelTick], ebx
.3:
        leave
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawCreatePlayerField                           CF6A3  97 PC, low confidence
; Draws a create player field
;-----------------------------------------------------------------------------
DrawCreatePlayerField:
        push ecx
        push esi
        push edi
        enter 4, 0
        mov edi, edx
        mov esi, ebx
        lea ebx, [byte eax+042h]
        test byte [GameSettings], 0Ch
        jne short .1
        mov eax, ebx
        mov ecx, 0Ch
        cdq
        idiv ecx
        mov ecx, eax
        mov eax, ebx
        mov dword [byte ebp-04h], 0Ch
        jmp short .2
.1:
        mov eax, ebx
        mov ecx, 64h
        call InchesToCm
        mov ebx, eax
        cdq
        idiv ecx
        mov ecx, eax
        mov eax, ebx
        mov dword [byte ebp-04h], 64h
.2:
        cdq
        idiv dword [byte ebp-04h]
        push edx
        push ecx
        mov eax, 0ECh
        call GetLangText
        push eax
        push esi
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 18h
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; DrawCreatePlayerText                            CF70F  97 PC, low confidence
; Draws a create player text line
;-----------------------------------------------------------------------------
DrawCreatePlayerText:
        push ecx
        add eax, 96h
        test byte [GameSettings], 0Ch
        je short .1
        call PoundsToKg
.1:
        push eax
        mov eax, 0EDh
        call GetLangText
        push eax
DrawCreatePlayerText_20:
        push ebx
        push edx
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        pop ecx
        ret
;-----------------------------------------------------------------------------
; DrawCreatePlayerNameLine                        CF73D  97 PC, low confidence
; Draws the created player's name
;-----------------------------------------------------------------------------
DrawCreatePlayerNameLine:
        push ecx
        add eax, byte 12h
        push eax
        push str_D_JerseyScreen
        jmp short DrawCreatePlayerText_20
;-----------------------------------------------------------------------------
; CreatePlayerScreen                           CF749  96 PC, medium confidence
; The create player screen (GOL0, NME0-2 name, NUM0-2 number buttons, random
; ratings by CreatePlayerRatings), from the roster screen
;-----------------------------------------------------------------------------
CreatePlayerScreen:
        push ebx
        push ecx
        push esi
        push edi
        enter 2D4h, 0
        push eax
        push edx
        sub ebp, 82h
        xor edi, edi
        push edi
        push dword 0CD0h
        push str_CreatePlrMenu
        call AllocMemBlock
        add esp, byte 0Ch
        push edi
        push dword 0A00h
        push str_CreatePlrRegion
        mov dword [byte ebp+072h], eax
        mov dword [CreatePlayerItems], eax
        call AllocMemBlock
        mov dword [byte ebp+06Ah], eax
        lea eax, [byte ebp-01Ah]
        mov dword [CreateGoalieRatings], eax
        lea eax, [byte ebp+01Eh]
        add esp, byte 0Ch
        mov dword [CreateSkaterRatings], eax
        lea eax, [byte ebp+052h]
        mov dword [RatingPanelFrame], edi
        call _dos_getdate_
        mov eax, dword [CreatePlayerSlot]
        mov dword [byte ebp+06Eh], 1
        call ClearPlayerRecord
        mov dword [RatingBarLitBackArt], 0A8h
        mov dword [RatingBarLitArt], 0A8h
        mov dword [RatingBarArt], 6Ch
        mov dword [RatingBarBackArt], 6Ch
        test byte [dword ebp-025Ah], 1
        sete al
        movzx eax, al
        inc eax
        lea edx, [byte ebp-01Ah]
        mov dword [CreateGoalieMode], eax
        lea eax, [dword ebp-0136h]
        call NewSkaterRecord
        lea edx, [byte ebp+01Eh]
        lea eax, [dword ebp-0252h]
        call NewGoalieRecord
        test byte [dword ebp-025Ah], 1
        je short .1
        mov byte [dword ebp-0134h], 4Ch
        mov byte [dword ebp-0250h], 4Ch
        jmp short .2
.1:
        mov byte [dword ebp-0134h], 47h
        mov byte [dword ebp-0250h], 47h
.2:
        lea eax, [byte ebp+042h]
        push eax
        lea ecx, [byte ebp+062h]
        push dword [dword ebp-025Ah]
        lea eax, [byte ebp+05Eh]
        lea ebx, [byte ebp+066h]
        push eax
        mov edx, dword [byte ebp+06Ah]
        mov eax, dword [byte ebp+072h]
        call InitCreatePlayerScreen
        mov eax, dword [byte ebp+062h]
        mov ebx, dword [byte ebp+066h]
        mov dword [RatingPanelShapeFile], eax
        mov eax, dword [byte ebp+072h]
        lea edx, [dword ebp-0136h]
        add eax, 148h
        call DrawCreatePlayerPanel
        mov eax, dword [byte ebp+072h]
        mov ebx, dword [byte ebp+066h]
        lea edx, [dword ebp-0136h]
        add eax, 290h
        call DrawCreatePlayerHeight
        mov eax, dword [byte ebp+072h]
        mov ebx, dword [byte ebp+066h]
        lea edx, [dword ebp-0136h]
        add eax, 2E2h
        call DrawCreatePlayerWeight
        mov eax, dword [byte ebp+072h]
        mov ebx, dword [byte ebp+066h]
        lea edx, [dword ebp-0136h]
        add eax, 334h
        call DrawCreatePlayerAge
        mov eax, dword [tickcount]
        mov dword [RatingPointsLeft], eax
        jmp near .33
.3:
        cmp dword [byte ebp+05Ah], byte 6
        jbe near .26
        push byte 1
        mov eax, 0F1h
        call GetLangText
        mov ecx, edx
        mov edx, 14h
        mov ebx, eax
        lea eax, [dword ebp-0A5h]
        call EditTextField
        lea edx, [dword ebp-0A5h]
        lea eax, [dword ebp-01C1h]
        call strcpy_
        imul eax, dword [byte ebp+05Ah], byte 52h
        push dword [byte ebp+066h]
        mov ecx, dword [byte ebp+04Ah]
        mov ebx, dword [byte ebp+05Eh]
        lea edx, [dword ebp-0136h]
        add eax, dword [byte ebp+072h]
        call DrawCreatePlayerLabel
        jmp near .33
.4:
        cmp dword [byte ebp+05Ah], byte 2
        jb short .5
        jbe near .9
        cmp dword [byte ebp+05Ah], byte 3
        jbe near .10
        jmp near .14
.5:
        cmp dword [byte ebp+05Ah], byte 0
        ja short .6
        call ShowScreen
        push byte 1
        mov ecx, 1
        mov edx, 2
        mov eax, 0EEh
        xor ebx, ebx
        call GetLangText
        call ShowMessageBox
        mov edi, eax
        test eax, eax
        je near .33
        mov dword [byte ebp+06Eh], 0
        jmp near .33
.6:
        call FadeInScreen
        movsx eax, word [dword ebp-0DBh]
        sar eax, 4
        mov byte [dword ebp-0EBh], al
        movsx eax, word [dword ebp-01FBh]
        sar eax, 4
        mov byte [dword ebp-0203h], al
        cmp dword [CreateGoalieMode], byte 1
        jne short .7
        mov ecx, 47h
        mov edi, dword [dword ebp-0256h]
        lea esi, [dword ebp-0136h]
        jmp short .8
.7:
        mov ecx, 47h
        mov edi, dword [dword ebp-0256h]
        lea esi, [dword ebp-0252h]
.8:
        rep movsd
        mov eax, dword [dword ebp-0256h]
        call ShowCreatePlayerHelp
        mov edi, eax
        jmp near .33
.9:
        call ExitScreen
        jmp near .33
.10:
        push byte 1
        mov ecx, eax
        mov eax, 0EFh
        mov edx, 0Fh
        call GetLangText
        mov ebx, eax
        lea eax, [dword ebp-0BFh]
        call EditTextField
        cmp byte [dword ebp-0BFh], 0
        je short .12
        push byte 1
        mov eax, 0F0h
        mov edx, 10h
        mov ecx, esi
        call GetLangText
        lea esi, [dword ebp-0CFh]
        mov ebx, eax
        mov eax, esi
        call EditTextField
        cmp byte [dword ebp-0CFh], 0
        je short .11
        lea edx, [dword ebp-0BFh]
        lea eax, [dword ebp-01DBh]
        call strcpy_
        lea edx, [dword ebp-0CFh]
        lea eax, [dword ebp-01EBh]
        jmp short .13
.11:
        lea edx, [dword ebp-01EBh]
        lea eax, [dword ebp-0CFh]
        call strcpy_
        lea edx, [dword ebp-01DBh]
        lea eax, [dword ebp-0BFh]
        jmp short .13
.12:
        lea edx, [dword ebp-01DBh]
        lea eax, [dword ebp-0BFh]
.13:
        call strcpy_
        imul eax, dword [byte ebp+05Ah], byte 52h
        push dword [byte ebp+066h]
        mov ecx, dword [byte ebp+042h]
        mov ebx, dword [byte ebp+05Eh]
        lea edx, [dword ebp-0136h]
        add eax, dword [byte ebp+072h]
        call DrawCreatePlayerName
        jmp near .33
.14:
        cmp byte [dword ebp-0BFh], 0
        je short .15
        lea ebx, [dword ebp-0BFh]
        jmp short .16
.15:
        mov eax, 0C2h
        call GetLangText
        mov ebx, eax
.16:
        mov edx, 64h
        xor eax, eax
        call JerseyScreen
        mov byte [dword ebp-0251h], al
        mov byte [dword ebp-0135h], al
        imul eax, dword [byte ebp+05Ah], byte 52h
        mov ebx, dword [byte ebp+066h]
        lea edx, [dword ebp-0136h]
        add eax, dword [byte ebp+072h]
        call DrawCreatePlayerPanel
        jmp near .33
.17:
        xor esi, eax
        cmp byte [dword ebp-0134h], 47h
        jb short .18
        jbe short .19
        cmp byte [dword ebp-0134h], 4Ch
        jb near .25
        jbe short .20
        cmp byte [dword ebp-0134h], 52h
        je short .21
        jmp near .25
.18:
        cmp byte [dword ebp-0134h], 43h
        jb near .25
        jbe short .22
        cmp byte [dword ebp-0134h], 44h
        je short .23
        jmp short .25
.19:
        test byte [dword ebp-025Ah], 1
        je short .25
        mov dword [CreateGoalieMode], 1
        mov esi, 1
        jmp short .24
.20:
        mov byte [dword ebp-0134h], 52h
        jmp short .25
.21:
        mov byte [dword ebp-0134h], 43h
        jmp short .25
.22:
        mov byte [dword ebp-0134h], 44h
        jmp short .25
.23:
        test byte [dword ebp-025Ah], 2
        je short .24
        mov dword [CreateGoalieMode], 2
        mov byte [dword ebp-0134h], 47h
        inc esi
        jmp short .25
.24:
        mov byte [dword ebp-0134h], 4Ch
.25:
        mov al, byte [dword ebp-0134h]
        mov byte [dword ebp-0250h], al
        imul eax, dword [byte ebp+05Ah], byte 52h
        mov ebx, dword [byte ebp+05Eh]
        lea edx, [dword ebp-0136h]
        add eax, dword [byte ebp+072h]
        call DrawCreatePlayerPosition
        test esi, esi
        je near .33
        mov eax, dword [byte ebp+072h]
        mov ebx, dword [byte ebp+05Eh]
        lea edx, [dword ebp-0136h]
        add eax, 1ECh
        call DrawCreatePlayerHand
        mov eax, dword [byte ebp+072h]
        add eax, 386h
        call SetupCreatePlayerLists
        call SetScreenTarget
        mov eax, dword [byte ebp+05Eh]
        call DrawRatingBars
        call PresentScreen
        jmp near .33
.26:
        cmp byte [dword ebp-0EEh], 0
        jne short .27
        mov byte [dword ebp-0EEh], 1
        mov byte [dword ebp-020Ah], 1
        jmp short .28
.27:
        mov byte [dword ebp-0EEh], 0
        mov byte [dword ebp-020Ah], 0
.28:
        imul eax, dword [byte ebp+05Ah], byte 52h
        mov ebx, dword [byte ebp+05Eh]
        lea edx, [dword ebp-0136h]
        add eax, dword [byte ebp+072h]
        call DrawCreatePlayerHand
        jmp near .33
.29:
        movsx esi, word [dword ebp-0DDh]
        mov eax, 0F2h
        mov ecx, 0Dh
        mov edx, DrawCreatePlayerField
        lea ebx, [byte esi-042h]
        call GetLangText
        call PlayerBioScreen
        lea esi, [byte eax+042h]
        imul eax, dword [byte ebp+05Ah], byte 52h
        mov ebx, dword [byte ebp+066h]
        lea edx, [dword ebp-0136h]
        mov word [dword ebp-01FDh], si
        add eax, dword [byte ebp+072h]
        mov word [dword ebp-0DDh], si
        call DrawCreatePlayerHeight
        jmp near .33
.30:
        movsx esi, word [dword ebp-0DBh]
        mov eax, 15Bh
        mov ecx, 6Ah
        mov edx, DrawCreatePlayerText
        lea ebx, [dword esi-096h]
        call GetLangText
        call PlayerBioScreen
        lea esi, [dword eax+096h]
        imul eax, dword [byte ebp+05Ah], byte 52h
        mov ebx, dword [byte ebp+066h]
        lea edx, [dword ebp-0136h]
        mov word [dword ebp-01FBh], si
        add eax, dword [byte ebp+072h]
        mov word [dword ebp-0DBh], si
        call DrawCreatePlayerWeight
        jmp short .33
.31:
        movzx eax, word [byte ebp-07Dh]
        lea ecx, [byte ebp+076h]
        lea ebx, [byte ebp+07Ah]
        lea edx, [byte ebp+07Eh]
        call AgeFromBirthDate
        movsx esi, word [byte ebp+07Eh]
        mov eax, 7CDh
        sub eax, esi
        lea ebx, [byte eax-012h]
        mov ecx, 17h
        mov eax, 0F4h
        mov edx, DrawCreatePlayerNameLine
        call GetLangText
        call PlayerBioScreen
        lea esi, [byte eax+012h]
        mov eax, 7CDh
        movsx ebx, word [byte ebp+076h]
        sub eax, esi
        movsx edx, word [byte ebp+07Ah]
        mov dword [byte ebp+07Eh], eax
        cwde
        call DaysToYear
        mov word [byte ebp-07Dh], ax
        mov word [dword ebp-0199h], ax
        imul eax, dword [byte ebp+05Ah], byte 52h
        mov ebx, dword [byte ebp+066h]
        lea edx, [dword ebp-0136h]
        add eax, dword [byte ebp+072h]
.32:
        call DrawCreatePlayerAge
.33:
        test edi, edi
        jne near .37
        push byte 3
        lea eax, [byte ebp+05Ah]
        mov ecx, DrawRatingPanel
        mov ebx, 0FFFFFFFFh
        push eax
        mov edx, dword [byte ebp+072h]
        mov eax, 28h
        call RunMenu
        mov edx, eax
        mov esi, eax
        cmp dword [byte ebp+05Ah], byte 5
        jb near .4
        jbe near .17
        cmp dword [byte ebp+05Ah], byte 8
        jb near .3
        jbe near .29
        cmp dword [byte ebp+05Ah], byte 0Ah
        jb near .30
        jbe near .31
        cmp dword [byte ebp+05Ah], byte 27h
        je short .34
        jmp short .33
.34:
        push dword [RatingPanelShapeFile]
        call FreeMemBlock
        add esp, byte 4
        call ShowStatsScreen
        cmp dword [LinkGameActive], byte 0
        sete al
        movzx edx, al
        mov eax, 0EAh
        call PlayScreenMovie
        call ChangeMenuMusic
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 4Ch
        call LoadDataFile
        push str_00008
        push eax
        mov dword [byte ebp+062h], eax
        mov dword [RatingPanelShapeFile], eax
        call FindShape
        add esp, byte 8
        push edi
        push dword 1E0h
        push dword 280h
        mov dword [byte ebp+066h], eax
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov ebx, eax
        call SetDrawTarget
        add esp, byte 4
        push dword [byte ebp+066h]
        call BlitShape
        add esp, byte 4
        push str_TITL11
        push dword [byte ebp+05Eh]
        call FindShape
        add esp, byte 8
        push eax
        xor esi, esi
        call BlitShape
        add esp, byte 4
.35:
        imul eax, esi, byte 52h
        add eax, dword [byte ebp+072h]
        cmp dword [byte eax+01Ah], byte 0
        je short .36
        push dword [byte eax+02Ah]
        push dword [byte eax+026h]
        push dword [byte eax+01Ah]
        call DrawArt
        add esp, byte 0Ch
.36:
        inc esi
        cmp esi, byte 0Bh
        jl short .35
        mov eax, dword [byte ebp+05Eh]
        call DrawRatingBars
        xor edx, edx
        mov eax, dword [byte ebx+02Ch]
        call WipeScreen
        push ebx
        call FreeBitmap
        mov eax, dword [byte ebp+072h]
        mov ecx, dword [byte ebp+042h]
        add esp, byte 4
        mov ebx, dword [byte ebp+05Eh]
        lea edx, [dword ebp-0136h]
        push dword [byte ebp+066h]
        add eax, 0F6h
        call DrawCreatePlayerName
        mov eax, dword [byte ebp+072h]
        mov ebx, dword [byte ebp+066h]
        lea edx, [dword ebp-0136h]
        add eax, 148h
        call DrawCreatePlayerPanel
        mov eax, dword [byte ebp+072h]
        mov ebx, dword [byte ebp+05Eh]
        lea edx, [dword ebp-0136h]
        add eax, 19Ah
        call DrawCreatePlayerPosition
        mov eax, dword [byte ebp+072h]
        mov ebx, dword [byte ebp+05Eh]
        lea edx, [dword ebp-0136h]
        add eax, 1ECh
        call DrawCreatePlayerHand
        push dword [byte ebp+066h]
        mov eax, dword [byte ebp+072h]
        mov ecx, dword [byte ebp+04Ah]
        mov ebx, dword [byte ebp+05Eh]
        lea edx, [dword ebp-0136h]
        add eax, 23Eh
        call DrawCreatePlayerLabel
        mov eax, dword [byte ebp+072h]
        mov ebx, dword [byte ebp+066h]
        lea edx, [dword ebp-0136h]
        add eax, 290h
        call DrawCreatePlayerHeight
        mov eax, dword [byte ebp+072h]
        mov ebx, dword [byte ebp+066h]
        lea edx, [dword ebp-0136h]
        add eax, 2E2h
        call DrawCreatePlayerWeight
        mov eax, dword [byte ebp+072h]
        mov ebx, dword [byte ebp+066h]
        lea edx, [dword ebp-0136h]
        add eax, 334h
        jmp near .32
.37:
        xor esi, esi
.38:
        push dword [byte ebp+esi*4+042h]
        call FreeBitmap
        inc esi
        add esp, byte 4
        cmp esi, byte 4
        jl short .38
        mov ebx, dword [byte ebp+05Eh]
        cmp dword [byte ebp+062h], byte 0
        je short .39
        push dword [byte ebp+062h]
        call FreeMemBlock
        add esp, byte 4
.39:
        test ebx, ebx
        je short .40
        push ebx
        call FreeMemBlock
        add esp, byte 4
.40:
        call FreeStatsBitmap
        push dword [byte ebp+06Ah]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+072h]
        call FreeMemBlock
        mov eax, dword [byte ebp+06Eh]
        add esp, byte 4
        jmp near DrawRosterList_86F
;-----------------------------------------------------------------------------
; DrawRatingBar                                   CFFAB  97 PC, low confidence
; Draws one rating bar
;-----------------------------------------------------------------------------
DrawRatingBar:
        push esi
        push edi
        enter 14h, 0
        push eax
        mov edi, edx
        mov esi, ebx
        mov dword [byte ebp-04h], ecx
        push dword 0FFFF00h
        call MakeColor
        add esp, byte 4
        push dword 0FF00h
        mov dword [byte ebp-010h], eax
        call MakeColor
        mov dword [byte ebp-08h], eax
        mov eax, dword [byte ebp+010h]
        imul eax, ebx
        cdq
        idiv dword [byte ebp+014h]
        add esp, byte 4
        mov dword [byte ebp-014h], eax
        cmp dword [byte ebp+018h], byte 0
        jle short .3
        xor ebx, ebx
        jmp short .2
.1:
        mov eax, dword [byte ebp-08h]
        imul eax, ebx
        cdq
        idiv esi
        mov edx, dword [byte ebp-010h]
        and eax, dword [byte ebp-08h]
        sub edx, eax
        push edx
        push dword [byte ebp-04h]
        push byte 1
        push edi
        push dword [byte ebp-0Ch]
        inc ebx
        call FillRect
        add esp, byte 14h
.2:
        mov eax, dword [byte ebp-018h]
        add eax, ebx
        mov dword [byte ebp-0Ch], eax
        cmp ebx, dword [byte ebp-014h]
        jl short .1
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        push dword [byte ebp-04h]
        sub esi, ebx
        push esi
        push edi
        push dword [byte ebp-0Ch]
        jmp short .6
.3:
        mov ebx, 1
        jmp short .5
.4:
        mov eax, dword [byte ebp-08h]
        imul eax, ebx
        cdq
        idiv esi
        mov edx, dword [byte ebp-010h]
        and eax, dword [byte ebp-08h]
        sub edx, eax
        push edx
        push dword [byte ebp-04h]
        push byte 1
        mov eax, dword [byte ebp-018h]
        push edi
        sub eax, ebx
        push eax
        inc ebx
        call FillRect
        add esp, byte 14h
.5:
        cmp ebx, dword [byte ebp-014h]
        jle short .4
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, esi
        push dword [byte ebp-04h]
        sub eax, ebx
        push eax
        mov eax, dword [byte ebp-018h]
        push edi
        sub eax, esi
        push eax
.6:
        call FillRect
        add esp, byte 14h
        jmp near RemoveFromLines_61
;-----------------------------------------------------------------------------
; InitShapeListBox                                D0098  97 PC, low confidence
; Sets up a list box with its shapes
;-----------------------------------------------------------------------------
InitShapeListBox:
        push esi
        push edi
        enter 4, 0
        mov edi, eax
        mov esi, edx
        mov dword [byte ebp-04h], ecx
        push ebx
        push eax
        call FindShape
        add esp, byte 8
        push dword [byte ebp-04h]
        push edi
        mov ebx, eax
        mov dword [byte esi+01Ah], eax
        call FindShape
        add esp, byte 8
        push dword [byte ebp+010h]
        push edi
        mov dword [byte esi+01Eh], eax
        call FindShape
        mov dword [byte esi+022h], eax
        add esp, byte 8
        movsx eax, word [byte ebx+06h]
        movsx ecx, word [byte ebx+04h]
        push eax
        movsx eax, word [byte ebx+0Eh]
        movsx edx, word [byte ebx+0Ch]
        mov ebx, eax
        mov eax, esi
        call InitListBox
        jmp near DrawCreatePlayerName_12B
;-----------------------------------------------------------------------------
; SetupCreatePlayerLists                          D00F1  97 PC, low confidence
; Sets up the create player list boxes
;-----------------------------------------------------------------------------
SetupCreatePlayerLists:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 1Ch, 0
        push eax
        mov dword [byte ebp-08h], 6
        mov dword [byte ebp-010h], 0D0h
        mov dword [byte ebp-014h], 1B1h
        mov dword [byte ebp-0Ch], 5Fh
        xor esi, esi
        cmp dword [CreateGoalieMode], byte 1
        jne near .3
        mov dword [byte ebp-04h], esi
.1:
        imul edi, esi, byte 52h
        mov edx, dword [byte ebp-0Ch]
        sar edx, 1
        mov dword [byte ebp-01Ch], edx
        mov edx, dword [byte ebp-04h]
        push dword [byte ebp-08h]
        add edx, edx
        mov ecx, dword [byte ebp-01Ch]
        mov dword [byte ebp-018h], edx
        movsx ebx, word [dword edx+CreateSkaterRows]
        add edi, dword [byte ebp-020h]
        mov edx, dword [byte ebp-010h]
        mov eax, edi
        call InitListBox
        mov dword [byte edi+022h], 0
        mov edx, dword [byte edi+022h]
        mov dword [byte edi+01Eh], edx
        inc esi
        mov dword [byte edi+01Ah], edx
        imul edi, esi, byte 52h
        push dword [byte ebp-08h]
        mov ebx, dword [byte ebp-018h]
        mov ecx, dword [byte ebp-01Ch]
        mov edx, dword [byte ebp-014h]
        movsx ebx, word [dword ebx+CreateSkaterRows]
        add edi, dword [byte ebp-020h]
        sub edx, dword [byte ebp-01Ch]
        mov eax, edi
        call InitListBox
        mov dword [byte edi+022h], 0
        mov edx, dword [byte edi+022h]
        inc dword [byte ebp-04h]
        mov dword [byte edi+01Eh], edx
        inc esi
        mov dword [byte edi+01Ah], edx
        cmp dword [byte ebp-04h], byte 7
        jl short .1
        mov dword [byte ebp-04h], 0
.2:
        imul edi, esi, byte 52h
        mov edx, dword [byte ebp-0Ch]
        sar edx, 1
        mov dword [byte ebp-01Ch], edx
        mov edx, dword [byte ebp-04h]
        push dword [byte ebp-08h]
        add edx, edx
        mov ecx, dword [byte ebp-01Ch]
        mov dword [byte ebp-018h], edx
        movsx ebx, word [dword edx+CreateSkaterRows]
        add edi, dword [byte ebp-020h]
        mov edx, dword [byte ebp-010h]
        mov eax, edi
        add edx, dword [byte ebp-01Ch]
        call InitListBox
        mov dword [byte edi+022h], 0
        mov edx, dword [byte edi+022h]
        mov dword [byte edi+01Eh], edx
        inc esi
        mov dword [byte edi+01Ah], edx
        imul edi, esi, byte 52h
        push dword [byte ebp-08h]
        mov ebx, dword [byte ebp-018h]
        mov ecx, dword [byte ebp-01Ch]
        mov edx, dword [byte ebp-014h]
        movsx ebx, word [dword ebx+CreateSkaterRows]
        add edi, dword [byte ebp-020h]
        sub edx, dword [byte ebp-0Ch]
        mov eax, edi
        call InitListBox
        mov dword [byte edi+022h], 0
        mov edx, dword [byte edi+022h]
        inc dword [byte ebp-04h]
        mov dword [byte edi+01Eh], edx
        inc esi
        mov dword [byte edi+01Ah], edx
        cmp dword [byte ebp-04h], byte 7
        jl short .2
        jmp near DrawRatingBars_157
.3:
        mov edx, dword [byte ebp-0Ch]
        sar edx, 1
        mov dword [byte ebp-01Ch], edx
        lea edx, [esi+esi]
        imul edi, esi, byte 52h
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-01Ch]
        mov dword [byte ebp-018h], edx
        movsx ebx, word [dword edx+CreateGoalieRows]
        add edi, dword [byte ebp-020h]
        mov edx, dword [byte ebp-010h]
        mov eax, edi
        call InitListBox
        mov dword [byte edi+022h], 0
        mov edx, dword [byte edi+022h]
        mov dword [byte edi+01Eh], edx
        mov dword [byte edi+01Ah], edx
        lea edi, [byte esi+0Eh]
        imul edi, byte 52h
        push dword [byte ebp-08h]
        mov ebx, dword [byte ebp-018h]
        mov ecx, dword [byte ebp-01Ch]
        mov edx, dword [byte ebp-010h]
        movsx ebx, word [dword ebx+CreateGoalieRows]
        add edi, dword [byte ebp-020h]
        add edx, dword [byte ebp-01Ch]
        mov eax, edi
        call InitListBox
        mov dword [byte edi+022h], 0
        mov edx, dword [byte edi+022h]
        mov dword [byte edi+01Eh], edx
        inc esi
        inc esi
        mov dword [byte edi+01Ah], edx
        cmp esi, byte 9
        jl short .3
        mov esi, 1
.4:
        mov edx, dword [byte ebp-0Ch]
        sar edx, 1
        mov dword [byte ebp-018h], edx
        lea edx, [esi+esi]
        imul edi, esi, byte 52h
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-018h]
        mov dword [byte ebp-01Ch], edx
        movsx ebx, word [dword edx+CreateGoalieRows]
        mov edx, dword [byte ebp-014h]
        add edi, dword [byte ebp-020h]
        sub edx, dword [byte ebp-018h]
        mov eax, edi
        call InitListBox
        mov dword [byte edi+022h], 0
        mov edx, dword [byte edi+022h]
        mov dword [byte edi+01Eh], edx
        mov dword [byte edi+01Ah], edx
        lea edi, [byte esi+0Eh]
        imul edi, byte 52h
        push dword [byte ebp-08h]
        mov ebx, dword [byte ebp-01Ch]
        mov ecx, dword [byte ebp-018h]
        mov edx, dword [byte ebp-014h]
        movsx ebx, word [dword ebx+CreateGoalieRows]
        add edi, dword [byte ebp-020h]
        sub edx, dword [byte ebp-0Ch]
        mov eax, edi
        call InitListBox
        mov dword [byte edi+022h], 0
        mov edx, dword [byte edi+022h]
        mov dword [byte edi+01Eh], edx
        inc esi
        inc esi
        mov dword [byte edi+01Ah], edx
        cmp esi, byte 9
        jl short .4
        mov esi, 9
.5:
        imul edi, esi, byte 52h
        push byte 1
        mov ecx, 1
        mov ebx, 1E0h
        add edi, dword [byte ebp-020h]
        mov edx, 280h
        mov eax, edi
        call InitListBox
        mov dword [byte edi+022h], 0
        mov edx, dword [byte edi+022h]
        mov dword [byte edi+01Eh], edx
        mov dword [byte edi+01Ah], edx
        lea edx, [byte esi+0Eh]
        imul edx, byte 52h
        push byte 1
        mov ecx, 1
        mov edi, dword [byte ebp-020h]
        mov ebx, 1E0h
        add edi, edx
        mov edx, 280h
        mov eax, edi
        call InitListBox
        mov dword [byte edi+022h], 0
        mov edx, dword [byte edi+022h]
        mov dword [byte edi+01Eh], edx
        inc esi
        mov dword [byte edi+01Ah], edx
        cmp esi, byte 0Eh
        jl short .5
        jmp near DrawRatingBars_157
;-----------------------------------------------------------------------------
; InitCreatePlayerScreen                          D0397  97 PC, low confidence
; From CreatePlayerScreen: menu items and art (TITL, NA / JN name and jersey
; buttons, LoadDataFile)
;-----------------------------------------------------------------------------
InitCreatePlayerScreen:
        push esi
        push edi
        enter 38h, 0
        mov esi, dword [byte ebp+018h]
        mov dword [byte ebp-08h], eax
        mov edi, edx
        mov dword [byte ebp-034h], ebx
        mov dword [byte ebp-02Ch], ecx
        mov edx, eax
        mov eax, 28h
        mov dword [byte ebp-04h], 0
        call InitMenuItems
.1:
        mov eax, dword [byte ebp-04h]
        shl eax, 6
        lea edx, [edi+eax]
        imul eax, dword [byte ebp-04h], byte 52h
        add eax, dword [byte ebp-08h]
        inc dword [byte ebp-04h]
        mov dword [byte eax+014h], edx
        cmp dword [byte ebp-04h], byte 28h
        jl short .1
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 4Ch
        call LoadDataFile
        mov edi, eax
        mov dword [byte ebp-030h], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 4Dh
        call LoadDataFile
        push str_00008
        push edi
        mov dword [byte ebp-018h], eax
        mov dword [byte ebp-0Ch], eax
        call FindShape
        add esp, byte 8
        push str_TITL11
        mov dword [byte ebp-020h], eax
        push dword [byte ebp-018h]
        mov dword [byte ebp-01Ch], eax
        call FindShape
        add esp, byte 8
        push byte 0
        push dword 1E0h
        push dword 280h
        mov dword [byte ebp-028h], eax
        call CreateBitmap
        add esp, byte 0Ch
        push str_NAOF
        push dword [byte ebp-018h]
        mov dword [byte ebp-024h], eax
        call FindShape
        add esp, byte 8
        mov edi, eax
        push byte 0
        movsx eax, word [byte eax+06h]
        mov edx, 280h
        push eax
        movsx eax, word [byte edi+0Ch]
        sub edx, eax
        push edx
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [esi], eax
        push byte 0
        movsx eax, word [byte edi+06h]
        mov edx, 280h
        push eax
        movsx eax, word [byte edi+0Ch]
        sub edx, eax
        push edx
        call CreateBitmap
        mov dword [byte esi+04h], eax
        add esp, byte 0Ch
        movsx eax, word [byte edi+06h]
        movsx ecx, word [byte edi+04h]
        push eax
        mov eax, dword [byte ebp-08h]
        movsx ebx, word [byte edi+0Eh]
        add eax, 0F6h
        movsx edx, word [byte edi+0Ch]
        mov dword [byte ebp-010h], eax
        call InitListBox
        mov eax, dword [byte ebp-010h]
        mov eax, dword [byte eax+014h]
        mov dword [byte eax+08h], 280h
        mov eax, dword [byte ebp-010h]
        mov eax, dword [byte eax+014h]
        mov dword [byte eax+010h], 280h
        push dword [esi]
        call SetDrawTarget
        mov eax, dword [byte ebp-020h]
        movsx edx, word [byte edi+0Eh]
        movsx eax, word [byte eax+0Eh]
        add esp, byte 4
        sub eax, edx
        push eax
        mov eax, dword [byte ebp-020h]
        movsx edx, word [byte edi+0Ch]
        movsx eax, word [byte eax+0Ch]
        sub eax, edx
        push eax
        push dword [byte ebp-020h]
        call BlitArt
        add esp, byte 0Ch
        push byte 0
        mov eax, dword [byte esi+04h]
        push byte 0
        push dword [byte eax+02Ch]
        call ConvertArtXY
        add esp, byte 0Ch
        push byte 0
        push byte 0
        push edi
        call BlitArt
        mov eax, dword [esi]
        mov edx, dword [byte ebp-010h]
        mov eax, dword [byte eax+02Ch]
        add esp, byte 0Ch
        mov dword [byte edx+01Ah], eax
        push dword [byte esi+04h]
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        push byte 0
        push str_NAON
        push dword [byte ebp-018h]
        call FindShape
        add esp, byte 8
        mov edi, dword [byte ebp-08h]
        push eax
        mov ebx, str_JNOF
        add edi, 148h
        call BlitArt
        mov eax, dword [byte esi+04h]
        mov edx, dword [byte ebp-010h]
        add esp, byte 0Ch
        mov eax, dword [byte eax+02Ch]
        mov ecx, str_JNON
        mov dword [byte edx+022h], eax
        push str_JNON
        mov dword [byte edx+01Eh], eax
        mov eax, dword [byte ebp-018h]
        mov edx, edi
        call InitShapeListBox
        mov eax, dword [byte edi+014h]
        mov dword [byte eax+08h], 280h
        mov edx, dword [byte ebp-08h]
        mov eax, dword [byte edi+014h]
        mov dword [byte ebp-04h], 5
        add edx, 19Ah
        mov dword [byte eax+010h], 280h
        test byte [byte ebp+014h], 1
        je short .2
        push str_LWON
        mov ecx, str_LWON
        mov ebx, str_LWOF
        jmp short .3
.2:
        push str_GOON
        mov ecx, str_GOON
        mov ebx, str_GOOF
.3:
        mov eax, dword [byte ebp-018h]
        call InitShapeListBox
        imul eax, dword [byte ebp-04h], byte 52h
        add eax, dword [byte ebp-08h]
        mov edx, dword [byte eax+014h]
        inc dword [byte ebp-04h]
        mov dword [byte edx+08h], 280h
        imul edx, dword [byte ebp-04h], byte 52h
        mov eax, dword [byte eax+014h]
        mov dword [byte eax+010h], 280h
        add edx, dword [byte ebp-08h]
        test byte [byte ebp+014h], 1
        je short .4
        push str_SLON
        mov ecx, str_SLON
        mov ebx, str_SLOF
        jmp short .5
.4:
        push str_GLON
        mov ecx, str_GLON
        mov ebx, str_GLOF
.5:
        mov eax, dword [byte ebp-0Ch]
        call InitShapeListBox
        imul eax, dword [byte ebp-04h], byte 52h
        add eax, dword [byte ebp-08h]
        mov edx, dword [byte eax+014h]
        mov dword [byte edx+08h], 280h
        push str_PBOF
        mov eax, dword [byte eax+014h]
        push dword [byte ebp-0Ch]
        mov dword [byte eax+010h], 280h
        call FindShape
        add esp, byte 8
        mov edi, eax
        push byte 0
        movsx eax, word [byte eax+06h]
        mov edx, 280h
        push eax
        movsx eax, word [byte edi+0Ch]
        sub edx, eax
        push edx
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [byte esi+08h], eax
        push byte 0
        movsx eax, word [byte edi+06h]
        mov edx, 280h
        push eax
        movsx eax, word [byte edi+0Ch]
        sub edx, eax
        push edx
        call CreateBitmap
        mov dword [byte esi+0Ch], eax
        add esp, byte 0Ch
        movsx eax, word [byte edi+06h]
        inc dword [byte ebp-04h]
        push eax
        imul eax, dword [byte ebp-04h], byte 52h
        movsx ecx, word [byte edi+04h]
        mov dword [byte ebp-038h], eax
        mov eax, dword [byte ebp-08h]
        movsx ebx, word [byte edi+0Eh]
        add eax, dword [byte ebp-038h]
        movsx edx, word [byte edi+0Ch]
        mov dword [byte ebp-014h], eax
        call InitListBox
        mov eax, dword [byte ebp-014h]
        mov eax, dword [byte eax+014h]
        mov dword [byte eax+08h], 280h
        mov eax, dword [byte ebp-014h]
        mov eax, dword [byte eax+014h]
        mov dword [byte eax+010h], 280h
        push dword [byte esi+08h]
        call SetDrawTarget
        mov edx, dword [byte ebp-01Ch]
        movsx eax, word [byte edi+0Eh]
        movsx edx, word [byte edx+0Eh]
        add esp, byte 4
        sub edx, eax
        push edx
        mov edx, dword [byte ebp-01Ch]
        movsx eax, word [byte edi+0Ch]
        movsx edx, word [byte edx+0Ch]
        sub edx, eax
        push edx
        push dword [byte ebp-01Ch]
        call BlitArt
        add esp, byte 0Ch
        push byte 0
        mov eax, dword [byte esi+0Ch]
        push byte 0
        push dword [byte eax+02Ch]
        call ConvertArtXY
        add esp, byte 0Ch
        push byte 0
        push byte 0
        push edi
        call BlitArt
        mov eax, dword [byte esi+08h]
        mov edx, dword [byte ebp-014h]
        mov eax, dword [byte eax+02Ch]
        add esp, byte 0Ch
        mov dword [byte edx+01Ah], eax
        push dword [byte esi+0Ch]
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        push byte 0
        push str_PBON
        push dword [byte ebp-0Ch]
        call FindShape
        add esp, byte 8
        push eax
        inc dword [byte ebp-04h]
        call BlitArt
        mov eax, dword [byte esi+0Ch]
        imul esi, dword [byte ebp-04h], byte 52h
        mov ebx, str_HEOF
        mov edx, dword [byte ebp-014h]
        add esp, byte 0Ch
        mov eax, dword [byte eax+02Ch]
        mov ecx, str_HEON
        mov dword [byte edx+022h], eax
        push str_HEON
        mov dword [byte edx+01Eh], eax
        add esi, dword [byte ebp-08h]
        mov eax, dword [byte ebp-0Ch]
        mov edx, esi
        call InitShapeListBox
        mov eax, dword [byte esi+014h]
        mov dword [byte eax+08h], 280h
        inc dword [byte ebp-04h]
        mov eax, dword [byte esi+014h]
        imul esi, dword [byte ebp-04h], byte 52h
        push str_WEON
        mov ecx, str_WEON
        mov ebx, str_WEOF
        mov dword [byte eax+010h], 280h
        add esi, dword [byte ebp-08h]
        mov eax, dword [byte ebp-0Ch]
        mov edx, esi
        call InitShapeListBox
        mov eax, dword [byte esi+014h]
        mov dword [byte eax+08h], 280h
        inc dword [byte ebp-04h]
        mov eax, dword [byte esi+014h]
        imul esi, dword [byte ebp-04h], byte 52h
        push str_AGON
        mov ecx, str_AGON
        mov ebx, str_AGOF
        mov dword [byte eax+010h], 280h
        add esi, dword [byte ebp-08h]
        mov eax, dword [byte ebp-0Ch]
        mov edx, esi
        call InitShapeListBox
        mov eax, dword [byte esi+014h]
        mov dword [byte eax+08h], 280h
        mov eax, dword [byte esi+014h]
        push dword [byte ebp-024h]
        mov dword [byte eax+010h], 280h
        call SetDrawTarget
        add esp, byte 4
        push dword [byte ebp-01Ch]
        call BlitShape
        add esp, byte 4
        push dword [byte ebp-028h]
        call BlitShape
        mov eax, dword [byte ebp-024h]
        mov edi, dword [byte ebp-08h]
        mov eax, dword [byte eax+02Ch]
        add esp, byte 4
        mov ebx, eax
        mov edx, eax
        mov esi, ScreenTitleItem
        call DrawScreenBackground
        mov ebx, 64h
        mov edx, 0Ah
        mov eax, dword [byte ebp-01Ch]
        mov ecx, 52h
        call DrawStatsBackground
        rep movsb
        mov eax, dword [byte ebp-08h]
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
        rep movsb
        mov ecx, 52h
        mov edi, eax
        mov dword [dword eax+0A4h], 2
        mov esi, StatsBackItem
        lea edi, [dword edi+0C7Eh]
        rep movsb
        inc dword [byte ebp-04h]
        mov dword [dword eax+0C7Eh], 27h
        imul eax, dword [byte ebp-04h], byte 52h
        add eax, dword [byte ebp-08h]
        mov dword [byte ebp-04h], 0
        call SetupCreatePlayerLists
.6:
        imul esi, dword [byte ebp-04h], byte 52h
        add esi, dword [byte ebp-08h]
        cmp dword [byte esi+01Ah], byte 0
        je short .7
        push dword [byte esi+02Ah]
        push dword [byte esi+026h]
        push dword [byte esi+01Ah]
        call DrawArt
        add esp, byte 0Ch
.7:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 0Bh
        jl short .6
        mov eax, dword [byte ebp-0Ch]
        call DrawRatingBars
        mov eax, dword [byte ebp-024h]
        xor edx, edx
        mov eax, dword [byte eax+02Ch]
        call WipeScreen
        push dword [byte ebp-024h]
        call FreeBitmap
        mov edx, dword [byte ebp-02Ch]
        mov eax, dword [byte ebp-030h]
        mov dword [edx], eax
        mov edx, dword [byte ebp+010h]
        mov eax, dword [byte ebp-0Ch]
        mov dword [edx], eax
        mov eax, dword [byte ebp-034h]
        mov edx, dword [byte ebp-01Ch]
        add esp, byte 4
        mov dword [eax], edx
        jmp near RemoveFromLines_61
        push ebx
        push ecx
        mov ebx, edx
        test eax, eax
        je short .8
        push eax
        call FreeMemBlock
        add esp, byte 4
.8:
        test ebx, ebx
        je short .9
        push ebx
        call FreeMemBlock
        add esp, byte 4
.9:
        call FreeStatsBitmap
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; NewSkaterRecord                                 D096D  97 PC, low confidence
; Fills a new skater record
;-----------------------------------------------------------------------------
NewSkaterRecord:
        push ebx
        push ecx
        push esi
        mov ecx, eax
        mov esi, edx
        mov byte [eax], 0
        mov eax, 1
.1:
        cmp byte [dword eax+NewPlayerRecord], 0
        jne short .2
        mov byte [byte ecx+01h], al
        jmp short .3
.2:
        inc eax
        cmp eax, byte 64h
        jl short .1
.3:
        mov ebx, 15h
        lea eax, [byte ecx+03h]
        xor edx, edx
        mov byte [byte ecx+02h], 4Ch
        call memset_
        mov byte [byte ecx+048h], 0
        mov byte [byte ecx+049h], 0
        mov byte [byte ecx+04Ah], 0
        mov byte [byte ecx+04Bh], 0
        mov byte [byte ecx+04Ch], 0
        mov byte [byte ecx+04Dh], 0
        mov byte [byte ecx+04Eh], 0
        mov byte [byte ecx+04Fh], 0
        mov byte [byte ecx+050h], 0
        mov byte [byte ecx+051h], 0
        mov byte [byte ecx+052h], 0
        mov byte [byte ecx+053h], 0
        mov byte [byte ecx+054h], 0
        mov byte [byte ecx+055h], 0
        mov byte [byte ecx+056h], 1
        mov byte [byte ecx+057h], 0
        mov byte [byte ecx+058h], 0
        mov edx, 1
        mov word [byte ecx+059h], 4Ah
        lea eax, [byte ecx+038h]
        mov word [byte ecx+05Bh], 0C8h
        call PlayerOverall
        mov byte [byte ecx+05Eh], 0
        mov byte [byte ecx+067h], 0
        mov byte [byte ecx+077h], 0
        mov byte [dword ecx+086h], 0
        mov ebx, 1
        mov byte [dword ecx+090h], 0
        mov edx, ebx
        mov byte [byte ecx+05Dh], al
        mov eax, 7B2h
        mov byte [dword ecx+091h], 0
        call DaysToYear
        mov ebx, 2Eh
        mov word [dword ecx+0BBh], 7C6h
        xor edx, edx
        mov word [dword ecx+0B9h], ax
        lea eax, [dword ecx+0BFh]
        mov word [dword ecx+0BDh], 0
        call memset_
        lea eax, [byte ecx+04Eh]
        mov dword [esi], eax
        lea eax, [byte ecx+053h]
        mov dword [byte esi+04h], eax
        lea eax, [byte ecx+052h]
        mov dword [byte esi+08h], eax
        lea eax, [byte ecx+051h]
        mov dword [byte esi+0Ch], eax
        lea eax, [byte ecx+054h]
        mov dword [byte esi+010h], eax
        lea eax, [byte ecx+055h]
        mov dword [byte esi+014h], eax
        lea eax, [byte ecx+04Ch]
        mov dword [byte esi+018h], eax
        lea eax, [byte ecx+04Fh]
        mov dword [byte esi+01Ch], eax
        lea eax, [byte ecx+050h]
        mov dword [byte esi+020h], eax
        lea eax, [byte ecx+04Ah]
        mov dword [byte esi+024h], eax
        lea eax, [byte ecx+057h]
        mov dword [byte esi+028h], eax
        lea eax, [byte ecx+058h]
        mov dword [byte esi+02Ch], eax
        lea eax, [byte ecx+049h]
        mov dword [byte esi+030h], eax
        lea eax, [byte ecx+04Dh]
        mov dword [byte esi+034h], eax
NewSkaterRecord_146:
        mov byte [dword ecx+011Bh], 60h
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; NewGoalieRecord                                 D0ABE  97 PC, low confidence
; Fills a new goalie record
;-----------------------------------------------------------------------------
NewGoalieRecord:
        push ebx
        push ecx
        push esi
        mov ecx, eax
        mov esi, edx
        mov byte [eax], 0
        mov eax, 1
.1:
        cmp byte [dword eax+NewPlayerRecord], 0
        jne short .2
        mov byte [byte ecx+01h], al
        jmp short .3
.2:
        inc eax
        cmp eax, byte 64h
        jl short .1
.3:
        mov ebx, 15h
        lea eax, [byte ecx+03h]
        xor edx, edx
        mov byte [byte ecx+02h], 47h
        call memset_
        mov byte [byte ecx+048h], 0
        mov byte [byte ecx+049h], 0
        mov byte [byte ecx+04Ah], 0
        mov byte [byte ecx+04Bh], 0
        mov byte [byte ecx+04Ch], 0
        mov byte [byte ecx+04Dh], 0
        mov byte [byte ecx+04Eh], 0
        mov byte [byte ecx+04Fh], 0
        mov byte [byte ecx+050h], 0
        mov byte [byte ecx+051h], 0
        mov byte [byte ecx+052h], 0
        mov byte [byte ecx+053h], 0
        mov byte [byte ecx+054h], 0
        lea eax, [byte ecx+038h]
        mov word [byte ecx+055h], 4Ah
        xor edx, edx
        mov word [byte ecx+057h], 0C8h
        call PlayerOverall
        mov byte [byte ecx+05Ah], 0
        mov byte [byte ecx+067h], 0
        mov byte [byte ecx+077h], 0
        mov byte [dword ecx+086h], 0
        mov ebx, 1
        mov byte [dword ecx+090h], 1
        mov edx, ebx
        mov byte [byte ecx+059h], al
        mov eax, 7B2h
        mov byte [dword ecx+091h], 0
        call DaysToYear
        mov ebx, 2Eh
        mov word [dword ecx+0BBh], 7C6h
        xor edx, edx
        mov word [dword ecx+0B9h], ax
        lea eax, [dword ecx+0BFh]
        mov word [dword ecx+0BDh], 0
        call memset_
        lea eax, [byte ecx+051h]
        mov dword [esi], eax
        lea eax, [byte ecx+054h]
        mov dword [byte esi+04h], eax
        lea eax, [byte ecx+050h]
        mov dword [byte esi+08h], eax
        lea eax, [byte ecx+04Ch]
        mov dword [byte esi+0Ch], eax
        lea eax, [byte ecx+04Ah]
        mov dword [byte esi+010h], eax
        lea eax, [byte ecx+04Bh]
        mov dword [byte esi+014h], eax
        lea eax, [byte ecx+049h]
        mov dword [byte esi+018h], eax
        lea eax, [byte ecx+04Eh]
        mov dword [byte esi+01Ch], eax
        lea eax, [byte ecx+04Dh]
        mov dword [byte esi+020h], eax
        jmp near NewSkaterRecord_146
;-----------------------------------------------------------------------------
; PlayerOverall                                   D0BD8  97 PC, low confidence
; Works out a player's overall rating
;-----------------------------------------------------------------------------
PlayerOverall:
        push ebx
        push ecx
        test edx, edx
        je short .8
        movzx edx, byte [byte eax+012h]
        movzx ebx, byte [byte eax+011h]
        add ebx, edx
        movzx edx, byte [byte eax+016h]
        add edx, ebx
        movzx ebx, byte [byte eax+01Bh]
        movzx ecx, byte [byte eax+017h]
        add ebx, edx
        movzx edx, byte [byte eax+014h]
        add edx, ecx
        movzx eax, byte [byte eax+018h]
        add edx, ebx
        add eax, edx
        cmp eax, byte 23h
        jge short .2
.1:
        mov eax, 5
        pop ecx
        pop ebx
        ret
.2:
        cmp eax, byte 2Dh
        jge short .4
.3:
        mov eax, 0Ah
        pop ecx
        pop ebx
        ret
.4:
        cmp eax, byte 3Ch
        jge short .6
.5:
        mov eax, 0Fh
        pop ecx
        pop ebx
        ret
.6:
        cmp eax, byte 46h
        jge short .11
.7:
        mov eax, 1Eh
        pop ecx
        pop ebx
        ret
.8:
        movzx edx, byte [byte eax+016h]
        movzx ebx, byte [byte eax+015h]
        add ebx, edx
        movzx edx, byte [byte eax+01Ah]
        add ebx, edx
        movzx edx, byte [byte eax+010h]
        add edx, ebx
        je short .9
        movzx edx, byte [byte eax+011h]
        movzx eax, byte [byte eax+014h]
        jmp short .10
.9:
        movzx ebx, byte [byte eax+013h]
        movzx edx, byte [byte eax+012h]
        movzx eax, byte [byte eax+01Ch]
        add edx, ebx
.10:
        add eax, edx
        cmp eax, byte 0Ah
        jl short .1
        cmp eax, byte 13h
        jl short .3
        cmp eax, byte 14h
        jl short .5
        cmp eax, byte 18h
        jl short .7
.11:
        mov eax, 2Dh
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; RemoveListEntry                                 D0C88  97 PC, low confidence
; Removes an entry from a list
;-----------------------------------------------------------------------------
RemoveListEntry:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        push eax
        test eax, eax
        je near DrawRatingBars_157
        mov edi, eax
        mov esi, eax
        mov ecx, 36h
        lea edi, [dword edi+087h]
        lea esi, [byte esi+018h]
        rep movsb
        mov edx, dword [byte ebp-04h]
        mov ax, word [dword eax+0D05h]
        mov word [dword edx+0BDh], ax
        mov ax, word [dword edx+01281h]
        mov word [dword edx+0637h], ax
        mov ax, word [dword edx+0132Bh]
        mov word [dword edx+06E1h], ax
        mov ax, word [dword edx+018A5h]
        mov ebx, 578h
        mov word [dword edx+0C5Bh], ax
        mov eax, dword [byte ebp-04h]
        add edx, 0D09h
        add eax, 0BFh
        call memmove_
        mov edx, dword [byte ebp-04h]
        mov eax, dword [byte ebp-04h]
        mov ebx, 0A8h
        add edx, 1283h
        add eax, 639h
        call memmove_
        mov edx, dword [byte ebp-04h]
        mov eax, dword [byte ebp-04h]
        mov ebx, 578h
        add edx, 132Dh
        add eax, 6E3h
        call memmove_
        mov edx, dword [byte ebp-04h]
        mov eax, dword [byte ebp-04h]
        mov ebx, 0A8h
        add edx, 18A7h
        add eax, 0C5Dh
        call memmove_
        jmp near DrawRatingBars_157
