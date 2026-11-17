; Team select: home and away panels.
bits 32
%include "hockey.inc"
section s_9E35E progbits alloc exec nowrite align=1
extern AllocMemBlock, AwayPanelLayer, AwayPanelPos, AwayPanelShapes, AwayPanelTeam, AwayPanelTick, BlankMenuItem, BlitArt
extern BlitShape2, ClearLinkAbort, CreateBitmap, CreditsKeyFlag, DrawArt, DrawProgressBar, DrawScreenBackground, DrawTeamLogoBanner
extern ExhibitionData, ExitScreen, FadeInScreen, FindShape, FindShapeList, FreeBitmap, FreeExhibitionFile, FreeMemBlock
extern gameopts, GetLangText, GlobalSetVersion, HideLinkBox, HomePanelLayer, HomePanelPos, HomePanelShapes, HomePanelTeam
extern HomePanelTick, IndexDialogShapeMid, IndexSoundMode, IndexSoundPlayed, InitMenuItems, LinkGameActive, LinkReceiveBlock, LinkSendBlock
extern LinkTransferSetup, LoadDataFile, LoadExhibitionFile, PanelTeamBase, PanelTeamNameShift, PickDemoTeams, PickIndexEntryScreen_393, PickIndexEntryScreen_3A4
extern PickIndexEntryScreen_3B5, PickIndexEntryScreen_470, PickIndexEntryScreen_4D9, PickIndexEntryScreen_4EE, PlayMenuSfx, PlaySfx, PresentScreen, rand_
extern ResetExhibitionFile, RunMenu, RunScrollList, ScreenFrameItem, ScreenTitleItem, SeasonFileName, SeasonSetupScreen, SecondsToSamples
extern ServiceIdle, SetDrawTarget, SetRegionRect, SetScreenTarget, ShowLinkMessage, ShowPopupScreen, ShowScreen, sprintf_
extern StopAllSfx, str_00004, str_0001, str_0002, str_011R3, str_012R013R014R12SR13SR14SRS, str_012R2, str_013R2
extern str_01LL, str_01LR, str_01RL, str_01RR, str_02LL, str_02LR, str_02RL, str_02RR
extern str_03dB, str_03dY, str_03LL, str_03LR, str_03RL, str_03RR, str_1, str_11SR3
extern str_12SR2, str_13SR2, str_AWY1, str_AWY2, str_HOM1, str_HOM2, str_Menu3, str_SW002
extern str_SW00SW01SW02SW03SW04SW05S, str_SWL2, str_SWL3, TeamSelectArtBase, TeamSelectDrawn, TeamSelectFlags, TeamSelectItems, TeamSelectMode
extern TeamSelectSoundOn, TeamSelectSparkleCount, TeamSelectTargets, TeamSelectValues, tickcount, WaitSoundTime, WipeScreen
global DrawHomeTeamPanel, DrawHomeTeamPanel_1C9, DrawHomeTeamPanel_1EC, DrawAwayTeamPanel, TeamSelectSparkle, TeamSelectScreenJumpTable, TeamSelectScreen, TeamSelectScreen_7BE
global TeamSelectScreen_7CF, TeamSelectScreen_7E0, TeamSelectScreen_7FC, TeamSelectScreen_815, TeamSelectScreen_8C4, TeamSelectScreen_918, TeamSelectScreen_94F, TeamSelectScreen_A05
global TeamSelectScreen_A43, TeamSelectScreen_ACB, TeamSelectScreen_B55, TeamSelectScreen_B61, str_Punct_PickIndexEntry, PickIndexTopBar, PickIndexLeftBar, PickIndexRightBar
global IndexScreenSound, PickIndexEntryScreenJumpTable
;-----------------------------------------------------------------------------
; DrawHomeTeamPanel                               9E35E  96 PC, low confidence
; The home team's panel on the team select screen: logo, name art, rank
; (rk%02d)
;-----------------------------------------------------------------------------
DrawHomeTeamPanel:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 4, 0
        mov esi, eax
        push dword [HomePanelLayer]
        call SetDrawTarget
        add esp, byte 4
        push byte 0FFFFFFB3h
        push byte 0FFFFFFC0h
        push str_00004
        push dword [AwayPanelShapes]
        call FindShape
        add esp, byte 8
        push eax
        call DrawArt
        add esp, byte 0Ch
        push str_HOM1
        push dword [HomePanelShapes]
        call FindShape
        movsx eax, word [byte eax+0Eh]
        add esp, byte 8
        sub eax, byte 4Dh
        push eax
        push str_HOM1
        push dword [HomePanelShapes]
        call FindShape
        movsx eax, word [byte eax+0Ch]
        add esp, byte 8
        sub eax, byte 40h
        push eax
        push str_HOM1
        push dword [HomePanelShapes]
        call FindShape
        add esp, byte 8
        push eax
        call DrawArt
        add esp, byte 0Ch
        cmp dword [TeamSelectDrawn], byte 0
        jne short .1
        call SetScreenTarget
        jmp short .2
.1:
        push dword [TeamSelectDrawn]
        call SetDrawTarget
        add esp, byte 4
.2:
        push byte 4Dh
        mov eax, dword [HomePanelLayer]
        push byte 40h
        push dword [byte eax+02Ch]
        call DrawArt
        add esp, byte 0Ch
        cmp dword [TeamSelectDrawn], byte 0
        jne short .3
        call PresentScreen
.3:
        mov eax, dword [tickcount]
        push dword [HomePanelLayer]
        mov dword [HomePanelTick], eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        push byte 0
        push str_HOM2
        push dword [HomePanelShapes]
        call FindShape
        add esp, byte 8
        push eax
        call DrawArt
        mov word [HomePanelTeam], si
        imul esi, dword 194Fh
        mov eax, dword [PanelTeamBase]
        add esp, byte 0Ch
        add eax, byte 7
        push byte 0
        sub eax, dword [PanelTeamNameShift]
        push eax
        push dword 8Fh
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov edi, eax
        call SetDrawTarget
        mov eax, dword [PanelTeamNameShift]
        add esp, byte 4
        neg eax
        push eax
        push byte 0FFFFFFB0h
        push str_00004
        push dword [AwayPanelShapes]
        call FindShape
        add esp, byte 8
        push eax
        call DrawArt
        mov eax, dword [ExhibitionData]
        add eax, 0DF4h
        add eax, esi
        add esp, byte 0Ch
        add eax, byte 5Bh
        xor esi, esi
        mov dword [byte ebp-04h], eax
.4:
        push byte 0FFFFFFFFh
        mov eax, dword [byte ebp-04h]
        mov ecx, 6
        mov ebx, 8Fh
        mov edx, dword [nosplit esi*4+PanelTeamNameShift]
        push byte 1Ah
        movzx eax, byte [esi+eax]
        sub edx, dword [PanelTeamNameShift]
        push eax
        mov eax, ebx
        inc esi
        call DrawProgressBar
        cmp esi, byte 6
        jl short .4
        cmp dword [TeamSelectDrawn], byte 0
        jne short .5
        call SetScreenTarget
        jmp short .6
.5:
        push dword [TeamSelectDrawn]
        call SetDrawTarget
        add esp, byte 4
.6:
        push dword [PanelTeamNameShift]
        push byte 50h
DrawHomeTeamPanel_1C9:
        push dword [byte edi+02Ch]
        call DrawArt
        add esp, byte 0Ch
        cmp dword [TeamSelectDrawn], byte 0
        jne short .7
        call PresentScreen
.7:
        push edi
        call FreeBitmap
        add esp, byte 4
        leave
DrawHomeTeamPanel_1EC:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawAwayTeamPanel                               9E550  97 PC, low confidence
; The away team's panel on the team select screen (AWY1 / AWY2), as
; DrawHomeTeamPanel
;-----------------------------------------------------------------------------
DrawAwayTeamPanel:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        push eax
        push dword [AwayPanelLayer]
        call SetDrawTarget
        add esp, byte 4
        push byte 0FFFFFFB3h
        push dword 0FFFFFE77h
        push str_00004
        push dword [AwayPanelShapes]
        call FindShape
        add esp, byte 8
        push eax
        call DrawArt
        add esp, byte 0Ch
        push str_AWY1
        push dword [HomePanelShapes]
        call FindShape
        movsx eax, word [byte eax+0Eh]
        add esp, byte 8
        sub eax, byte 4Dh
        push eax
        push str_AWY1
        push dword [HomePanelShapes]
        call FindShape
        movsx eax, word [byte eax+0Ch]
        add esp, byte 8
        sub eax, 189h
        push eax
        push str_AWY1
        push dword [HomePanelShapes]
        call FindShape
        add esp, byte 8
        push eax
        call DrawArt
        add esp, byte 0Ch
        cmp dword [TeamSelectDrawn], byte 0
        jne short .1
        call SetScreenTarget
        jmp short .2
.1:
        push dword [TeamSelectDrawn]
        call SetDrawTarget
        add esp, byte 4
.2:
        push byte 4Dh
        mov eax, dword [AwayPanelLayer]
        push dword 189h
        push dword [byte eax+02Ch]
        call DrawArt
        add esp, byte 0Ch
        cmp dword [TeamSelectDrawn], byte 0
        jne short .3
        call PresentScreen
.3:
        mov eax, dword [tickcount]
        push dword [AwayPanelLayer]
        mov dword [AwayPanelTick], eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        push byte 0
        push str_AWY2
        push dword [HomePanelShapes]
        call FindShape
        add esp, byte 8
        push eax
        call DrawArt
        mov eax, dword [byte ebp-04h]
        mov word [AwayPanelTeam], ax
        mov eax, dword [PanelTeamBase]
        add esp, byte 0Ch
        add eax, byte 7
        push byte 0
        sub eax, dword [PanelTeamNameShift]
        push eax
        push dword 8Fh
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov edi, eax
        call SetDrawTarget
        mov eax, dword [PanelTeamNameShift]
        add esp, byte 4
        neg eax
        push eax
        push dword 0FFFFFE5Eh
        push str_00004
        push dword [AwayPanelShapes]
        call FindShape
        add esp, byte 8
        push eax
        xor esi, esi
        call DrawArt
        add esp, byte 0Ch
.4:
        imul edx, dword [byte ebp-04h], dword 194Fh
        push byte 1
        mov eax, dword [ExhibitionData]
        mov ecx, 6
        add eax, edx
        mov ebx, 8Fh
        push byte 1Ah
        movzx eax, byte [dword esi+eax+0E4Fh]
        mov edx, dword [nosplit esi*4+PanelTeamNameShift]
        push eax
        sub edx, dword [PanelTeamNameShift]
        xor eax, eax
        inc esi
        call DrawProgressBar
        cmp esi, byte 6
        jl short .4
        cmp dword [TeamSelectDrawn], byte 0
        jne short .5
        call SetScreenTarget
        jmp short .6
.5:
        push dword [TeamSelectDrawn]
        call SetDrawTarget
        add esp, byte 4
.6:
        push dword [PanelTeamNameShift]
        push dword 1A2h
        jmp near DrawHomeTeamPanel_1C9
;-----------------------------------------------------------------------------
; TeamSelectSparkle                               9E723  97 PC, low confidence
; Plays a team select sound and sparkle
;-----------------------------------------------------------------------------
TeamSelectSparkle:
        push ebx
        push ecx
        push edx
        push esi
        xor ebx, ebx
        xor esi, esi
.1:
        call rand_
        mov ecx, 3
        cdq
        idiv ecx
        lea eax, [ebx+ebx*2]
        lea ecx, [edx+eax]
        mov eax, ebx
        shl eax, 2
        shl ecx, 2
        mov edx, dword [dword eax+TeamSelectTargets]
        mov ecx, dword [dword ecx+TeamSelectValues]
        mov dword [edx], ecx
        lea edx, [byte ebx+02h]
        imul edx, byte 52h
        mov ecx, dword [TeamSelectItems]
        cmp dword [byte ecx+edx+04h], byte 1
        jne short .2
        mov eax, dword [dword eax+TeamSelectTargets]
        push dword [eax]
        mov esi, 1
        call BlitShape2
        add esp, byte 4
.2:
        inc ebx
        cmp ebx, byte 3
        jl short .1
        test esi, esi
        je short .3
        cmp dword [TeamSelectSoundOn], byte 0
        jne short .3
        mov eax, 309h
        call PlaySfx
        mov dword [TeamSelectSoundOn], 1
.3:
        test esi, esi
        jne short .4
        cmp dword [TeamSelectSoundOn], byte 0
        je short .4
        mov eax, 309h
        call PlayMenuSfx
        mov dword [TeamSelectSoundOn], esi
.4:
        movsx eax, word [HomePanelTeam]
        inc dword [TeamSelectSparkleCount]
        cmp eax, byte 0FFFFFFFFh
        je near .5
        mov eax, dword [tickcount]
        mov edx, dword [HomePanelTick]
        add edx, byte 32h
        cmp eax, edx
        jl short .5
        push dword [HomePanelLayer]
        call SetDrawTarget
        add esp, byte 4
        push dword 0B333h
        push byte 0
        push byte 0
        push byte 6Ah
        push byte 57h
        push str_HOM2
        push dword [HomePanelShapes]
        call FindShape
        mov edx, 0Ch
        mov ebx, dword [HomePanelLayer]
        movsx esi, word [HomePanelTeam]
        add esp, byte 8
        mov ecx, eax
        mov eax, esi
        call DrawTeamLogoBanner
        call SetScreenTarget
        push byte 4Dh
        mov eax, dword [HomePanelLayer]
        push byte 40h
        push dword [byte eax+02Ch]
        call DrawArt
        mov word [HomePanelTeam], 0FFFFh
        add esp, byte 0Ch
.5:
        movsx eax, word [AwayPanelTeam]
        cmp eax, byte 0FFFFFFFFh
        je near .6
        mov eax, dword [tickcount]
        mov edx, dword [AwayPanelTick]
        add edx, byte 32h
        cmp eax, edx
        jl short .6
        push dword [AwayPanelLayer]
        call SetDrawTarget
        add esp, byte 4
        push dword 0B333h
        push byte 0
        push byte 0
        push byte 6Ah
        push byte 5Fh
        push str_AWY2
        push dword [HomePanelShapes]
        call FindShape
        mov edx, 0Ch
        mov ebx, dword [AwayPanelLayer]
        movsx esi, word [AwayPanelTeam]
        add esp, byte 8
        mov ecx, eax
        mov eax, esi
        call DrawTeamLogoBanner
        call SetScreenTarget
        push byte 4Dh
        mov eax, dword [AwayPanelLayer]
        push dword 189h
        push dword [byte eax+02Ch]
        call DrawArt
        mov word [AwayPanelTeam], 0FFFFh
        add esp, byte 0Ch
.6:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
TeamSelectScreenJumpTable:                      ; jump table for the switch cases of TeamSelectScreen
        dd TeamSelectScreen_7BE
        dd TeamSelectScreen_7CF
        dd TeamSelectScreen_7E0
        dd TeamSelectScreen_7FC
        dd TeamSelectScreen_815
        dd TeamSelectScreen_8C4
        dd TeamSelectScreen_918
        dd TeamSelectScreen_94F
        dd TeamSelectScreen_A05
        dd TeamSelectScreen_A43
        dd TeamSelectScreen_ACB
        dd TeamSelectScreen_B55
        dd TeamSelectScreen_B61
;-----------------------------------------------------------------------------
; TeamSelectScreen                             9E91C  96 PC, medium confidence
; The exhibition team select screen (arrows ahl / ahr / aal / aar, logos,
; names, ranks); returns the next screen
;-----------------------------------------------------------------------------
TeamSelectScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 1D0h, 0
        sub ebp, 82h
        push byte 0
        push dword 42Ah
        push str_Menu3
        mov dword [byte ebp+072h], 0FFFFFFFFh
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp+07Eh], eax
        cmp dword [ExhibitionData], byte 0
        je short .1
        cmp dword [LinkGameActive], byte 0
        jne short .3
.1:
        cmp dword [ExhibitionData], byte 0
        je short .2
        mov eax, ExhibitionData
        call FreeExhibitionFile
.2:
        mov eax, ExhibitionData
        call LoadExhibitionFile
        test eax, eax
        jne short .3
        call ResetExhibitionFile
        mov eax, ExhibitionData
        call LoadExhibitionFile
.3:
        cmp dword [CreditsKeyFlag], byte 0
        jne short .4
        mov eax, dword [TeamSelectFlags]
        and eax, 0FC000h
        cmp eax, 84000h
        jb short .4
        and dword [TeamSelectFlags], 0FFF03FFFh
        or byte [TeamSelectMode], 7
.4:
        cmp dword [CreditsKeyFlag], byte 0
        jne short .5
        mov eax, dword [TeamSelectFlags]
        and eax, 3F00000h
        cmp eax, 2100000h
        jb short .5
        and word [TeamSelectMode], 0FC0Fh
        or word [TeamSelectMode], 1C0h
.5:
        mov eax, dword [TeamSelectFlags]
        shl eax, 0Ch
        shr eax, 1Ah
        mov dword [byte ebp+07Ah], eax
        mov eax, dword [TeamSelectFlags]
        shl eax, 6
        shr eax, 1Ah
        mov dword [byte ebp+076h], eax
        mov eax, dword [byte ebp+07Eh]
        mov ecx, 0FFFFFFFFh
        mov dword [TeamSelectItems], eax
        mov edx, eax
        mov eax, 0Dh
        mov ebx, 0FFFFFFFBh
        call InitMenuItems
        push byte 0FFFFFFFFh
        lea eax, [byte ebp+01Eh]
        mov edx, ebx
        call SetRegionRect
        mov eax, dword [byte ebp+07Eh]
        mov edx, dword [byte ebp+07Eh]
        mov dword [dword eax+0396h], 4
        lea eax, [byte ebp+01Eh]
        mov dword [dword edx+039Ah], eax
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 2Ch
        call LoadDataFile
        mov dword [AwayPanelShapes], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 2Dh
        xor ebx, ebx
        call LoadDataFile
        mov dword [HomePanelShapes], eax
.6:
        push ebx
        push str_03dB
        lea eax, [byte ebp+05Eh]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+05Eh]
        push eax
        push dword [AwayPanelShapes]
        call FindShape
        add esp, byte 8
        push ebx
        push str_03dY
        mov dword [dword ebp+ebx*4-014Eh], eax
        lea eax, [byte ebp+05Eh]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+05Eh]
        push eax
        push dword [AwayPanelShapes]
        inc ebx
        call FindShape
        add esp, byte 8
        mov dword [dword ebp+ebx*4-0C6h], eax
        cmp ebx, byte 1Ch
        jl short .6
        mov ebx, 1Ch
.7:
        push ebx
        push str_03dB
        lea eax, [byte ebp+05Eh]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+05Eh]
        push eax
        push dword [HomePanelShapes]
        call FindShape
        add esp, byte 8
        push ebx
        push str_03dY
        mov dword [dword ebp+ebx*4-014Eh], eax
        lea eax, [byte ebp+05Eh]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+05Eh]
        push eax
        push dword [HomePanelShapes]
        inc ebx
        call FindShape
        add esp, byte 8
        mov dword [dword ebp+ebx*4-0C6h], eax
        cmp ebx, byte 23h
        jl short .7
        push byte 0
        push dword 0D8h
        push dword 0BAh
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push dword 0D8h
        push dword 0BAh
        mov dword [HomePanelLayer], eax
        call CreateBitmap
        add esp, byte 0Ch
        push str_00004
        push dword [AwayPanelShapes]
        mov dword [AwayPanelLayer], eax
        call FindShape
        add esp, byte 8
        mov edi, dword [byte ebp+07Eh]
        push str_00004
        mov esi, eax
        mov dword [byte ebp+06Eh], eax
        push dword [HomePanelShapes]
        mov ebx, esi
        call FindShape
        mov ecx, 52h
        add esp, byte 8
        mov dword [byte ebp+06Ah], eax
        mov edx, esi
        mov eax, esi
        mov esi, ScreenTitleItem
        call DrawScreenBackground
        rep movsb
        mov eax, dword [byte ebp+07Eh]
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
        lea edi, [dword edi+03D8h]
        rep movsb
        push str_011R3
        mov dword [dword eax+03D8h], 0Ch
        push dword [HomePanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_012R2
        mov dword [dword edx+0BEh], eax
        push dword [HomePanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_013R2
        mov dword [dword edx+0C2h], eax
        push dword [HomePanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_11SR3
        mov dword [dword edx+0C6h], eax
        lea eax, [dword edx+0C2h]
        push dword [HomePanelShapes]
        mov dword [TeamSelectTargets], eax
        call FindShape
        mov edx, dword [byte ebp+07Eh]
        add esp, byte 8
        mov dword [dword edx+0110h], eax
        push str_12SR2
        push dword [HomePanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_13SR2
        mov dword [dword edx+0114h], eax
        push dword [HomePanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_SW002
        mov dword [dword edx+0118h], eax
        lea eax, [dword edx+0114h]
        push dword [HomePanelShapes]
        mov dword [HomePanelPos], eax
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_SWL2
        mov dword [dword edx+0162h], eax
        push dword [HomePanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_SWL3
        mov dword [dword edx+0166h], eax
        push dword [HomePanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_01LL
        mov dword [dword edx+016Ah], eax
        lea eax, [dword edx+0166h]
        push dword [AwayPanelShapes]
        mov dword [AwayPanelPos], eax
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_02LL
        mov dword [dword edx+01B4h], eax
        push dword [AwayPanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_03LL
        mov dword [dword edx+01B8h], eax
        push dword [AwayPanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_01LR
        mov dword [dword edx+01BCh], eax
        push dword [AwayPanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_02LR
        mov dword [dword edx+0206h], eax
        push dword [AwayPanelShapes]
        call FindShape
        mov edx, dword [byte ebp+07Eh]
        add esp, byte 8
        mov dword [dword edx+020Ah], eax
        push str_03LR
        push dword [AwayPanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_01RL
        mov dword [dword edx+020Eh], eax
        push dword [AwayPanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_02RL
        mov dword [dword edx+0258h], eax
        push dword [AwayPanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_03RL
        mov dword [dword edx+025Ch], eax
        push dword [AwayPanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_01RR
        mov dword [dword edx+0260h], eax
        push dword [AwayPanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_02RR
        mov dword [dword edx+02AAh], eax
        push dword [AwayPanelShapes]
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp+07Eh]
        push str_03RR
        mov dword [dword edx+02AEh], eax
        push dword [AwayPanelShapes]
        call FindShape
        mov edx, dword [byte ebp+07Eh]
        mov dword [dword edx+02B2h], eax
        mov eax, dword [byte ebp+07Ah]
        mov ebx, dword [byte ebp+07Eh]
        mov edx, dword [dword ebp+eax*4-014Eh]
        mov dword [dword ebx+02FCh], edx
        mov eax, dword [dword ebp+eax*4-0C2h]
        mov dword [dword ebx+0304h], eax
        mov dword [dword ebx+0300h], eax
        mov eax, dword [byte ebp+076h]
        mov edx, dword [dword ebp+eax*4-014Eh]
        mov dword [dword ebx+034Eh], edx
        add esp, byte 8
        mov eax, dword [dword ebp+eax*4-0C2h]
        push TeamSelectValues
        mov dword [dword ebx+0356h], eax
        push str_012R013R014R12SR13SR14SRS
        mov dword [dword ebx+0352h], eax
        push dword [HomePanelShapes]
        call FindShapeList
        add esp, byte 0Ch
        lea eax, [byte ebp-0Eh]
        push eax
        push str_SW00SW01SW02SW03SW04SW05S
        push dword [HomePanelShapes]
        mov ebx, 2
        call FindShapeList
        add esp, byte 0Ch
.8:
        imul eax, ebx, byte 52h
        add eax, dword [byte ebp+07Eh]
        mov esi, dword [byte eax+01Ah]
        movsx edx, word [byte esi+0Ch]
        mov esi, dword [byte eax+01Ah]
        mov dword [byte eax+026h], edx
        movsx edx, word [byte esi+0Eh]
        mov dword [byte eax+02Ah], edx
        mov edx, ebx
        shl edx, 6
        sub edx, 80h
        mov dword [byte eax+010h], 4
        add edx, TeamSelectArtBase
        inc ebx
        mov dword [byte eax+014h], edx
        cmp ebx, byte 0Bh
        jl short .8
        push byte 0
        mov eax, dword [byte ebp+07Eh]
        push dword 1E0h
        mov dword [dword eax+035Ah], 19Dh
        push dword 280h
        mov dword [dword eax+035Eh], 136h
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov esi, eax
        mov dword [TeamSelectDrawn], eax
        call SetDrawTarget
        add esp, byte 4
        push dword [byte ebp+06Eh]
        call BlitShape2
        add esp, byte 4
        push dword [byte ebp+06Ah]
        call BlitShape2
        add esp, byte 4
        push str_1
        push dword [HomePanelShapes]
        call FindShape
        add esp, byte 8
        push eax
        xor ebx, ebx
        call BlitShape2
        add esp, byte 4
.9:
        imul eax, ebx, byte 52h
        add eax, dword [byte ebp+07Eh]
        push dword [byte eax+02Ah]
        push dword [byte eax+026h]
        push dword [byte eax+01Ah]
        inc ebx
        call BlitArt
        add esp, byte 0Ch
        cmp ebx, byte 0Bh
        jl short .9
        mov eax, dword [byte ebp+07Ah]
        call DrawHomeTeamPanel
        mov eax, dword [byte ebp+076h]
        call DrawAwayTeamPanel
        mov eax, dword [tickcount]
        sub eax, byte 32h
        mov dword [HomePanelTick], eax
        mov eax, dword [tickcount]
        sub eax, byte 32h
        push dword [HomePanelLayer]
        mov dword [AwayPanelTick], eax
        call SetDrawTarget
        add esp, byte 4
        push dword 0B333h
        push byte 0
        push byte 0
        push byte 6Ah
        push byte 57h
        push str_0001
        push dword [AwayPanelShapes]
        call FindShape
        mov edx, 0Ch
        mov ebx, dword [HomePanelLayer]
        movsx edi, word [HomePanelTeam]
        add esp, byte 8
        mov ecx, eax
        mov eax, edi
        call DrawTeamLogoBanner
        push esi
        call SetDrawTarget
        add esp, byte 4
        push byte 4Dh
        mov eax, dword [HomePanelLayer]
        push byte 40h
        push dword [byte eax+02Ch]
        call DrawArt
        add esp, byte 0Ch
        push dword [AwayPanelLayer]
        mov word [HomePanelTeam], 0FFFFh
        call SetDrawTarget
        add esp, byte 4
        push dword 0B333h
        push byte 0
        push byte 0
        push byte 6Ah
        push byte 5Fh
        push str_0002
        push dword [AwayPanelShapes]
        call FindShape
        mov edx, 0Ch
        mov ebx, dword [AwayPanelLayer]
        movsx edi, word [AwayPanelTeam]
        add esp, byte 8
        mov ecx, eax
        mov eax, edi
        call DrawTeamLogoBanner
        push esi
        call SetDrawTarget
        add esp, byte 4
        push byte 4Dh
        mov eax, dword [AwayPanelLayer]
        push dword 189h
        push dword [byte eax+02Ch]
        call DrawArt
        add esp, byte 0Ch
        mov word [AwayPanelTeam], 0FFFFh
        mov dword [TeamSelectDrawn], 0
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte esi+02Ch]
        call WipeScreen
        push esi
        call FreeBitmap
        add esp, byte 4
        jmp near TeamSelectScreen_94F.23
TeamSelectScreen_7BE:
        call ShowScreen
        mov dword [byte ebp+072h], 1
        jmp near TeamSelectScreen_94F.23
TeamSelectScreen_7CF:
        call FadeInScreen
        mov dword [byte ebp+072h], 0Eh
        jmp near TeamSelectScreen_94F.23
TeamSelectScreen_7E0:
        mov eax, dword [byte ebp+07Eh]
        add eax, 0A4h
        call ShowPopupScreen
        mov eax, 1
        call SeasonSetupScreen
        jmp near TeamSelectScreen_94F.23
TeamSelectScreen_7FC:
        mov eax, dword [byte ebp+07Eh]
        add eax, 0F6h
        mov dword [byte ebp+072h], 19h
        call ShowPopupScreen
        jmp near TeamSelectScreen_94F.23
TeamSelectScreen_815:
        mov eax, 30Bh
        call PlaySfx
        xor ebx, ebx
.10:
        call SetScreenTarget
        push dword [byte ebp+ebx*4-0Eh]
        call BlitShape2
        add esp, byte 4
        call PresentScreen
        mov eax, dword [tickcount]
        mov edx, eax
        lea ecx, [byte edx+0Ah]
.11:
        mov eax, dword [tickcount]
        cmp eax, ecx
        jge short .12
        call ServiceIdle
        jmp short .11
.12:
        inc ebx
        cmp ebx, byte 0Ah
        jl short .10
        mov eax, dword [byte ebp+076h]
        mov ebx, dword [byte ebp+07Ah]
        mov dword [byte ebp+07Ah], eax
        call DrawHomeTeamPanel
        mov eax, dword [byte ebp+07Ah]
        mov ecx, dword [byte ebp+07Eh]
        mov edx, dword [dword ebp+eax*4-014Eh]
        mov dword [dword ecx+02FCh], edx
        mov eax, dword [dword ebp+eax*4-0C2h]
        mov dword [dword ecx+0304h], eax
        mov dword [dword ecx+0300h], eax
        mov eax, ebx
        call DrawAwayTeamPanel
        mov edx, dword [dword ebp+ebx*4-014Eh]
        mov dword [dword ecx+034Eh], edx
        mov eax, dword [dword ebp+ebx*4-0C2h]
        mov dword [dword ecx+0356h], eax
        mov dword [dword ecx+0352h], eax
        mov eax, dword [AwayPanelTick]
        mov dword [byte ebp+076h], ebx
        mov dword [HomePanelTick], eax
        jmp near TeamSelectScreen_94F.23
TeamSelectScreen_8C4:
        dec dword [byte ebp+07Ah]
        cmp dword [byte ebp+07Ah], byte 0
        jge short .15
        cmp dword [CreditsKeyFlag], byte 0
        je short .13
        mov eax, 23h
        jmp short .14
.13:
        mov eax, 21h
.14:
        add dword [byte ebp+07Ah], eax
.15:
        mov eax, dword [byte ebp+07Ah]
        call DrawHomeTeamPanel
        mov eax, dword [byte ebp+07Ah]
        mov ebx, dword [byte ebp+07Eh]
        mov edx, dword [dword ebp+eax*4-014Eh]
        mov dword [dword ebx+02FCh], edx
        mov eax, dword [dword ebp+eax*4-0C2h]
        mov dword [dword ebx+0304h], eax
        mov dword [dword ebx+0300h], eax
        jmp near TeamSelectScreen_94F.23
TeamSelectScreen_918:
        inc dword [byte ebp+07Ah]
        cmp dword [CreditsKeyFlag], byte 0
        je short .16
        mov eax, 23h
        jmp short .17
.16:
        mov eax, 21h
.17:
        cmp eax, dword [byte ebp+07Ah]
        jne short TeamSelectScreen_8C4.15
        cmp dword [CreditsKeyFlag], byte 0
        je short .18
        mov eax, 23h
        jmp short .19
.18:
        mov eax, 21h
.19:
        sub dword [byte ebp+07Ah], eax
        jmp short TeamSelectScreen_8C4.15
TeamSelectScreen_94F:
        dec dword [byte ebp+076h]
        cmp dword [byte ebp+076h], byte 0
        jge short .22
        cmp dword [CreditsKeyFlag], byte 0
        je short .20
        mov eax, 23h
        jmp short .21
.20:
        mov eax, 21h
.21:
        add dword [byte ebp+076h], eax
.22:
        mov eax, dword [byte ebp+076h]
        call DrawAwayTeamPanel
        mov eax, dword [byte ebp+076h]
        mov ebx, dword [byte ebp+07Eh]
        mov edx, dword [dword ebp+eax*4-014Eh]
        mov dword [dword ebx+034Eh], edx
        mov eax, dword [dword ebp+eax*4-0C2h]
        mov dword [dword ebx+0356h], eax
        mov dword [dword ebx+0352h], eax
.23:
        cmp dword [byte ebp+072h], byte 0FFFFFFFFh
        jne near TeamSelectScreen_B61.32
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [gameopts]
        and edx, byte 3Fh
        and dword [byte eax+01h], 0FFF03FFFh
        shl edx, 0Eh
        or dword [byte eax+01h], edx
        mov edx, dword [byte ebp+076h]
        mov eax, dword [gameopts]
        push byte 3
        and edx, byte 3Fh
        and word [byte eax+03h], 0FC0Fh
        shl edx, 14h
        mov ecx, TeamSelectSparkle
        or dword [byte eax+01h], edx
        lea eax, [byte ebp+066h]
        mov ebx, 0FFFFFFFFh
        push eax
        mov edx, dword [byte ebp+07Eh]
        mov eax, 0Dh
        call RunMenu
        cmp dword [byte ebp+066h], byte 0Ch
        ja short .23
        mov eax, dword [byte ebp+066h]
        jmp dword [nosplit cs:eax*4+TeamSelectScreenJumpTable]
TeamSelectScreen_A05:
        inc dword [byte ebp+076h]
        cmp dword [CreditsKeyFlag], byte 0
        je short .24
        mov eax, 23h
        jmp short .25
.24:
        mov eax, 21h
.25:
        cmp eax, dword [byte ebp+076h]
        jne near TeamSelectScreen_94F.22
        cmp dword [CreditsKeyFlag], byte 0
        je short .26
        mov eax, 23h
        jmp short .27
.26:
        mov eax, 21h
.27:
        sub dword [byte ebp+076h], eax
        jmp near TeamSelectScreen_94F.22
TeamSelectScreen_A43:
        mov eax, dword [byte ebp+07Eh]
        mov eax, dword [dword eax+0308h]
        push byte 64h
        sub eax, byte 1Eh
        push eax
        mov ecx, 64h
        mov ebx, dword [byte ebp+07Eh]
        push dword [byte ebp+06Eh]
        lea eax, [dword ebp-0C2h]
        mov edx, 0Ah
        push eax
        lea eax, [dword ebp-014Eh]
        mov ebx, dword [dword ebx+0308h]
        push eax
        cmp dword [CreditsKeyFlag], byte 0
        je short .28
        mov eax, 23h
        jmp short .29
.28:
        mov eax, 21h
.29:
        call RunScrollList
        mov ebx, eax
        cmp eax, byte 0FFFFFFFFh
        je near TeamSelectScreen_94F.23
        mov edx, dword [byte ebp+07Eh]
        mov dword [byte ebp+07Ah], eax
        call DrawHomeTeamPanel
        mov eax, dword [dword ebp+ebx*4-014Eh]
        mov dword [dword edx+02FCh], eax
        mov eax, dword [dword ebp+ebx*4-0C2h]
        mov dword [dword edx+0304h], eax
        mov dword [dword edx+0300h], eax
        jmp near TeamSelectScreen_94F.23
TeamSelectScreen_ACB:
        mov eax, dword [byte ebp+07Eh]
        mov eax, dword [dword eax+035Ah]
        push byte 64h
        add eax, 0AFh
        push eax
        mov ecx, 64h
        mov ebx, dword [byte ebp+07Eh]
        push dword [byte ebp+06Eh]
        lea eax, [dword ebp-0C2h]
        mov edx, 0Ah
        push eax
        lea eax, [dword ebp-014Eh]
        mov ebx, dword [dword ebx+035Ah]
        push eax
        cmp dword [CreditsKeyFlag], byte 0
        je short .30
        mov eax, 23h
        jmp short .31
.30:
        mov eax, 21h
.31:
        call RunScrollList
        mov ebx, eax
        cmp eax, byte 0FFFFFFFFh
        je near TeamSelectScreen_94F.23
        mov edx, dword [byte ebp+07Eh]
        mov dword [byte ebp+076h], eax
        call DrawAwayTeamPanel
        mov eax, dword [dword ebp+ebx*4-014Eh]
        mov dword [dword edx+034Eh], eax
        mov eax, dword [dword ebp+ebx*4-0C2h]
        mov dword [dword edx+0356h], eax
        mov dword [dword edx+0352h], eax
        jmp near TeamSelectScreen_94F.23
TeamSelectScreen_B55:
        mov dword [byte ebp+072h], 15h
        jmp near TeamSelectScreen_94F.23
TeamSelectScreen_B61:
        call ExitScreen
        jmp near TeamSelectScreen_94F.23
.32:
        push dword [AwayPanelShapes]
        call FreeMemBlock
        add esp, byte 4
        push dword [HomePanelShapes]
        call FreeMemBlock
        add esp, byte 4
        push dword [HomePanelLayer]
        call FreeBitmap
        add esp, byte 4
        push dword [AwayPanelLayer]
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp+07Eh]
        call FreeMemBlock
        add esp, byte 4
        cmp dword [byte ebp+072h], byte 19h
        jne short .33
        mov eax, dword [ExhibitionData]
        call LinkTransferSetup
.33:
        cmp dword [byte ebp+066h], byte 1
        je short .34
        cmp dword [byte ebp+066h], byte 0Bh
        jne near .39
.34:
        cmp dword [LinkGameActive], byte 0
        je short .35
        call ClearLinkAbort
        test eax, eax
        je short .36
.35:
        movsx ebx, word [byte ebp+076h]
        movsx edx, word [byte ebp+07Ah]
        mov ecx, SeasonFileName
        mov eax, dword [ExhibitionData]
        call PickDemoTeams
.36:
        cmp dword [LinkGameActive], byte 0
        je short .37
        call ClearLinkAbort
        test eax, eax
        je short .37
        mov eax, 227h
        mov edx, 4A78h
        call GetLangText
        call ShowLinkMessage
        xor ebx, ebx
        mov eax, SeasonFileName
        call LinkSendBlock
        call HideLinkBox
.37:
        cmp dword [LinkGameActive], byte 0
        je short .38
        call ClearLinkAbort
        test eax, eax
        jne short .38
        mov eax, 227h
        mov edx, 4A78h
        call GetLangText
        call ShowLinkMessage
        xor ebx, ebx
        mov eax, SeasonFileName
        call LinkReceiveBlock
        call HideLinkBox
.38:
        mov eax, dword [byte ebp+07Ah]
        and eax, byte 3Fh
        and dword [TeamSelectFlags], 0FFF03FFFh
        shl eax, 0Eh
        or dword [TeamSelectFlags], eax
        mov eax, dword [byte ebp+076h]
        and eax, byte 3Fh
        and word [TeamSelectMode], 0FC0Fh
        shl eax, 14h
        mov dword [gameopts], GlobalSetVersion
        or dword [TeamSelectFlags], eax
.39:
        cmp dword [byte ebp+066h], byte 0
        je short .40
        cmp dword [byte ebp+066h], byte 1
        jne short .41
.40:
        mov eax, ExhibitionData
        call FreeExhibitionFile
.41:
        mov eax, dword [byte ebp+072h]
        lea esp, [dword ebp+082h]
        pop ebp
        jmp near DrawHomeTeamPanel_1EC
        db 00h,00h,01h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,01h,00h
str_Punct_PickIndexEntry:                       ; string " "; used by PickIndexEntry
        db 0Ah,00h,00h,00h,0F6h,0FFh,0FFh,0FFh,0Ah,00h,00h,00h,0Ah,00h,00h,00h
        db 042h,0FFh,0FFh,0FFh,0Ah,00h,00h,00h,042h,0FFh,0FFh,0FFh,0F6h,0FFh,0FFh,0FFh
PickIndexTopBar:                                ; used by PickIndexEntry
        db 0F6h,0FFh,0FFh,0FFh,0Ah,00h,00h,00h,0F6h,0FFh,0FFh,0FFh,0F6h,0FFh,0FFh,0FFh
        db 0BEh,00h,00h,00h,0F6h,0FFh,0FFh,0FFh,0BEh,00h,00h,00h,0Ah,00h,00h,00h
PickIndexLeftBar:                               ; used by PickIndexEntry
        db 042h,0FFh,0FFh,0FFh,0FBh,0FFh,0FFh,0FFh,0Ah,00h,00h,00h,0FBh,0FFh,0FFh,0FFh
        db 0Ah,00h,00h,00h,0Fh,00h,00h,00h,042h,0FFh,0FFh,0FFh,0Fh,00h,00h,00h
PickIndexRightBar:                              ; used by PickIndexEntry
        db 0F6h,0FFh,0FFh,0FFh,0FBh,0FFh,0FFh,0FFh,0BEh,00h,00h,00h,0FBh,0FFh,0FFh,0FFh
        db 0BEh,00h,00h,00h,0Fh,00h,00h,00h,0F6h,0FFh,0FFh,0FFh,0Fh,00h,00h,00h
;-----------------------------------------------------------------------------
; IndexScreenSound                                9F671  97 PC, low confidence
; Plays an index screen sound
;-----------------------------------------------------------------------------
IndexScreenSound:
        push ebx
        push ecx
        push edx
        xor edx, edx
        cmp dword [IndexSoundMode], byte 1
        jne short .1
        call rand_
        mov ebx, 3
        cdq
        idiv ebx
        push dword [nosplit edx*4+IndexDialogShapeMid]
        call BlitShape2
        mov edx, 1
        add esp, byte 4
.1:
        test edx, edx
        je short .2
        cmp dword [IndexSoundPlayed], byte 0
        jne short .2
        mov eax, 309h
        call PlaySfx
        mov dword [IndexSoundPlayed], 1
.2:
        test edx, edx
        jne short .3
        cmp dword [IndexSoundPlayed], byte 0
        je short .3
        call StopAllSfx
        mov dword [IndexSoundPlayed], edx
.3:
        pop edx
        pop ecx
        pop ebx
        ret
PickIndexEntryScreenJumpTable:                  ; jump table for the switch cases of PickIndexEntryScreen
        dd PickIndexEntryScreen_393
        dd PickIndexEntryScreen_3A4
        dd PickIndexEntryScreen_3B5
        dd PickIndexEntryScreen_470
        dd PickIndexEntryScreen_4D9
        dd PickIndexEntryScreen_4EE
