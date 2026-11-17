; Options screens: detail level and sliders.
bits 32
%include "hockey.inc"
section s_C3594 progbits alloc exec nowrite align=1
extern ArenaFileName, AudioOptions, BlankMenuItem, BlitArt, BlitShape2, ChkMenuMusic, ClearScreen, ControlSetupScreen
extern ConvertArtKeepPos, ConvertArtXY, CreateBitmap, DetailLevel, DrawArt, DrawFrameBox, DrawScreenBackground, DrawShadowRect
extern DrawShapeCore, DrawTextAligned, FadeInScreen, FillRectCorners, FindShape, FreeBitmap, FreeMemBlock, FrontMusicOn
extern GetLangText, GripDriverPtr, GripPortWord, InitMenuItems, LinkGameActive, LinkSyncMenu, LinkSyncScreen, LoadDataFile
extern MakeColor, MemFreeSize, MusicOptions, OptionsAnimChoice, OptionsAnimScreen, OptionsButtonDownLit, OptionsButtonDownShapes, OptionsButtonLit
extern OptionsButtonOff, OptionsButtonOnShapes, OptionsButtonShapes, OptionsLabelShapes, OptionsMenuChoice, OptionsMenuItems, OptionsMusicShapes, OptionsSoundPlayed
extern OptionsSoundShapes, PauseMusic, PlayMenuSfx, PlaySfx, PresentScreen, rand_, RequestMusicStop, RunMenu
extern SecondsToSamples, ServiceIdle, SetDrawTarget, SetMusicVolume, SetNormalText, SetRegionRect, SetScreenTarget, SetSfxVolume
extern SetTextColor, SfxOptions, ShowPopupScreen, sprintf_, StopAllSfx, str_BACK10, str_BAK0, str_BAK1
extern str_BAL1, str_BOT1, str_BOTM3, str_CENT, str_D_OptionsScreen, str_LFT02, str_LFT2, str_MB003
extern str_MB013, str_MB043, str_MB052, str_MB0D, str_OF0D, str_ON0D, str_RIT02, str_RIT2
extern str_TTL02, str_TTL12, UpdateOptionsAnim, WaitMusicEnd, WaitSoundTime, WipeScreen
global RunOptionsScreens, DetailLevelScreenJumpTable, DetailLevelScreen, DetailLevelScreen_A25, DetailLevelScreen_A36, DetailLevelScreen_A93, DetailLevelScreen_B18, DetailLevelScreen_B7E
global DetailLevelScreen_C26, DetailLevelScreen_C86, DetailLevelScreen_CE6, DetailLevelScreen_D46, DrawOptionsSlider, OptionsSound, OptionsScreenJumpTable, OptionsScreen
global OptionsScreen_F0A, OptionsScreen_F22, OptionsScreen_10AA, OptionsScreen_10D0, OptionsScreen_1125, OptionsScreen_117A, OptionsScreen_11CF, OptionsScreen_1285
global OptionsScreen_12DA, OptionsScreen_1359, OptionsScreen_136C, OptionsScreen_137F, OptionsScreen_13A6, OptionsScreen_140D, OptionsScreen_1431, OptionsScreen_1435
global OptionsScreen_1439, OptionsScreen_143D, OptionsScreen_1441, OptionsScreen_1447, OptionsScreen_144D, OptionsScreen_1451, OptionsScreen_147B, OptionsScreen_14BA
global OptionsScreen_14FE, OptionsScreen_1519, OptionsScreen_1534, OptionsScreen_154F, OptionsScreen_156A, OptionsScreen_1588, OptionsScreen_15A6, SeasonSetupRowY
;-----------------------------------------------------------------------------
; RunOptionsScreens                               C3594  97 PC, low confidence
; From RunFrontEnd (0Ah): runs the options screen and its control set-up screens (screen numbers 22h-24h)
; until it returns 1Ah; in a network session only one side may change them
;-----------------------------------------------------------------------------
RunOptionsScreens:
        push edx
        mov edx, 64h
        jmp short .8
.1:
        cmp edx, byte 22h
        je short .5
        jmp short .8
.2:
        cmp dword [LinkGameActive], byte 0
        jne short .3
        call OptionsScreen
        jmp short .7
.3:
        je short .4
        cmp byte [OptionsMenuChoice], 2
        jne short .4
        call OptionsScreen
        mov edx, eax
        cmp eax, byte 1Ah
        jne short .8
        call LinkSyncMenu
        jmp short .8
.4:
        mov eax, 252h
        mov edx, 1Ah
        call GetLangText
        call LinkSyncScreen
        jmp short .8
.5:
        xor eax, eax
.6:
        call ControlSetupScreen
.7:
        mov edx, eax
.8:
        cmp edx, byte 1Ah
        je short .11
        cmp edx, byte 23h
        jb short .1
        jbe short .9
        cmp edx, byte 24h
        jbe short .10
        cmp edx, byte 64h
        je short .2
        jmp short .8
.9:
        mov eax, 1
        jmp short .6
.10:
        mov eax, dword [OptionsAnimChoice]
        call OptionsAnimScreen
        jmp short .7
.11:
        pop edx
        ret
        push ebx
        mov ebx, dword [byte edx+09h]
        and ebx, 200h
        and byte [byte eax+0Ah], 0FDh
        or dword [byte eax+09h], ebx
        mov ebx, dword [byte edx+09h]
        and ebx, 1FC00h
        and dword [byte eax+09h], 0FFFE03FFh
        or dword [byte eax+09h], ebx
        mov ebx, dword [byte edx+09h]
        and ebx, 40000h
        and byte [byte eax+0Bh], 0FBh
        or dword [byte eax+09h], ebx
        mov ebx, dword [byte edx+09h]
        and ebx, 100000h
        and byte [byte eax+0Bh], 0EFh
        or dword [byte eax+09h], ebx
        mov ebx, dword [byte edx+09h]
        and ebx, byte 2
        and byte [byte eax+09h], 0FDh
        or dword [byte eax+09h], ebx
        mov ebx, dword [byte edx+09h]
        and ebx, 1FCh
        and word [byte eax+09h], 0FE03h
        or dword [byte eax+09h], ebx
        mov ebx, dword [byte edx+09h]
        and ebx, 20000h
        and byte [byte eax+0Bh], 0FDh
        or dword [byte eax+09h], ebx
        mov edx, dword [byte edx+09h]
        and edx, 80000h
        and byte [byte eax+0Bh], 0F7h
        or dword [byte eax+09h], edx
        pop ebx
        ret
DetailLevelScreenJumpTable:                     ; jump table for the switch cases of DetailLevelScreen
        dd DetailLevelScreen_A25
        dd DetailLevelScreen_A36
        dd DetailLevelScreen_A93
        dd DetailLevelScreen_B7E
        dd DetailLevelScreen_C26
        dd DetailLevelScreen_C86
        dd DetailLevelScreen_CE6
        dd DetailLevelScreen_D46
        dd DetailLevelScreen_B18
        dd DetailLevelScreen_B18
;-----------------------------------------------------------------------------
; DetailLevelScreen                               C36CA  97 PC, low confidence
; The front end detail level panel (On / Off for crowd, ice logos, ice
; texture, boards, glass, names, benches), from OptionsScreen
;-----------------------------------------------------------------------------
DetailLevelScreen:
        push ebx
        push ecx
        push esi
        push edi
        enter 5B4h, 0
        mov edi, eax
        mov dword [byte ebp-0Ch], edx
        call SetNormalText
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push byte 0
        push str_BAK0
        push edx
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+06h]
        push eax
        push str_BAK0
        push dword [byte ebp-0Ch]
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+04h]
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push str_BAK1
        mov ebx, eax
        push dword [byte ebp-0Ch]
        mov dword [byte ebp-020h], eax
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+06h]
        push eax
        push str_BAK1
        push dword [byte ebp-0Ch]
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+04h]
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push str_BOTM3
        push edi
        mov esi, eax
        mov dword [byte ebp-01Ch], eax
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+06h]
        push eax
        push str_BOTM3
        push edi
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+04h]
        push eax
        mov dword [byte ebp-08h], 0
        call CreateBitmap
        mov dword [byte ebp-018h], eax
        add esp, byte 0Ch
        mov dword [byte ebp-024h], eax
        push str_BAK0
        push dword [byte ebp-0Ch]
        call FindShape
        add esp, byte 8
        push str_BAK0
        mov edx, dword [byte ebx+02Ch]
        mov ax, word [byte eax+0Ch]
        push dword [byte ebp-0Ch]
        mov word [byte edx+0Ch], ax
        call FindShape
        add esp, byte 8
        push str_BAK1
        mov edx, dword [byte ebx+02Ch]
        mov ax, word [byte eax+0Eh]
        push dword [byte ebp-0Ch]
        mov word [byte edx+0Eh], ax
        call FindShape
        add esp, byte 8
        push str_BAK1
        mov edx, dword [byte esi+02Ch]
        mov ax, word [byte eax+0Ch]
        push dword [byte ebp-0Ch]
        mov word [byte edx+0Ch], ax
        call FindShape
        add esp, byte 8
        push str_BOTM3
        mov edx, dword [byte esi+02Ch]
        mov ax, word [byte eax+0Eh]
        push edi
        mov word [byte edx+0Eh], ax
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebp-018h]
        push str_BOTM3
        mov edx, dword [byte edx+02Ch]
        mov ax, word [byte eax+0Ch]
        push edi
        mov word [byte edx+0Ch], ax
        call FindShape
        mov edx, dword [byte ebp-018h]
        mov edx, dword [byte edx+02Ch]
        mov ax, word [byte eax+0Eh]
        add esp, byte 8
        mov word [byte edx+0Eh], ax
        call SetScreenTarget
        push dword [byte ebx+02Ch]
        call ConvertArtKeepPos
        add esp, byte 4
        push dword [byte esi+02Ch]
        call ConvertArtKeepPos
        mov eax, dword [byte ebp-018h]
        add esp, byte 4
        push dword [byte eax+02Ch]
        call ConvertArtKeepPos
        add esp, byte 4
        xor esi, esi
        call PresentScreen
        jmp near .4
.1:
        push byte 0
        push byte 19h
        push byte 32h
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push byte 19h
        movsx ebx, si
        push byte 32h
        mov dword [byte ebp+ebx*4-040h], eax
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [byte ebp+ebx*4-038h], eax
        test si, si
        jne short .2
        push byte 0FFFFFFFFh
        jmp short .3
.2:
        push dword 0F7DF00h
.3:
        call MakeColor
        add esp, byte 4
        call SetTextColor
        movsx eax, si
        shl eax, 2
        push dword [byte eax+ebp-040h]
        mov dword [byte ebp-02Ch], eax
        call SetDrawTarget
        add esp, byte 4
        push dword 201828h
        call MakeColor
        add esp, byte 4
        push eax
        mov ebx, 32h
        call ClearScreen
        mov ecx, 19h
        add esp, byte 4
        xor edx, edx
        xor eax, eax
        call DrawFrameBox
        mov eax, 1F9h
        call GetLangText
        push eax
        push byte 5
        push byte 19h
        push byte 1
        call DrawTextAligned
        mov eax, dword [byte ebp-02Ch]
        add esp, byte 10h
        push dword [byte eax+ebp-038h]
        call SetDrawTarget
        add esp, byte 4
        push dword 201828h
        call MakeColor
        add esp, byte 4
        push eax
        mov ebx, 32h
        call ClearScreen
        mov ecx, 19h
        add esp, byte 4
        xor edx, edx
        xor eax, eax
        call DrawFrameBox
        mov eax, 1FAh
        call GetLangText
        push eax
        push byte 5
        push byte 19h
        push byte 1
        inc esi
        call DrawTextAligned
        add esp, byte 10h
.4:
        cmp si, byte 2
        jl near .1
        lea edx, [dword ebp-05B4h]
        mov eax, 0Ah
        mov dword [byte ebp-04h], 1
        mov esi, 0Fh
        call InitMenuItems
        jmp short .6
.5:
        movsx edx, word [byte ebp-04h]
        imul eax, edx, byte 52h
        lea ecx, [dword ebp-0280h]
        push byte 13h
        movsx ebx, si
        inc dword [byte ebp-04h]
        add ebx, byte 5Ah
        mov dword [dword eax+ebp-058Eh], 0DCh
        shl edx, 6
        mov dword [dword eax+ebp-05A4h], 4
        sub edx, byte 40h
        mov dword [dword eax+ebp-058Ah], ebx
        add ecx, edx
        mov edx, 32h
        mov dword [byte ebp-02Ch], ecx
        mov dword [dword eax+ebp-05A0h], ecx
        mov ecx, 21Ch
        mov eax, dword [byte ebp-02Ch]
        add esi, byte 19h
        call SetRegionRect
.6:
        cmp si, 0D7h
        jle short .5
        test byte [MusicOptions], 20h
        je short .7
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0548h], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0544h], eax
        mov eax, dword [byte ebp-040h]
        jmp short .8
.7:
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0548h], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0544h], eax
        mov eax, dword [byte ebp-038h]
.8:
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0540h], eax
        test byte [MusicOptions], 40h
        je short .9
        cmp byte [FrontMusicOn], 0
        jne short .9
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04F6h], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04F2h], eax
        mov eax, dword [byte ebp-040h]
        jmp short .10
.9:
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04F6h], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04F2h], eax
        mov eax, dword [byte ebp-038h]
.10:
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04EEh], eax
        test byte [DetailLevel], 1
        je short .11
        cmp byte [FrontMusicOn], 0
        jne short .11
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04A4h], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04A0h], eax
        mov eax, dword [byte ebp-040h]
        jmp short .12
.11:
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04A4h], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04A0h], eax
        mov eax, dword [byte ebp-038h]
.12:
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-049Ch], eax
        test byte [DetailLevel], 2
        je short .13
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0452h], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-044Eh], eax
        mov eax, dword [byte ebp-040h]
        jmp short .14
.13:
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0452h], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-044Eh], eax
        mov eax, dword [byte ebp-038h]
.14:
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-044Ah], eax
        test byte [DetailLevel], 4
        je short .15
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0400h], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-03FCh], eax
        mov eax, dword [byte ebp-040h]
        jmp short .16
.15:
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0400h], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-03FCh], eax
        mov eax, dword [byte ebp-038h]
.16:
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-03F8h], eax
        test byte [DetailLevel], 8
        je short .17
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-03AEh], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-03AAh], eax
        mov eax, dword [byte ebp-040h]
        jmp short .18
.17:
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-03AEh], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-03AAh], eax
        mov eax, dword [byte ebp-038h]
.18:
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-03A6h], eax
        test byte [DetailLevel], 20h
        je short .19
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-035Ch], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0358h], eax
        mov eax, dword [byte ebp-040h]
        jmp short .20
.19:
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-035Ch], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0358h], eax
        mov eax, dword [byte ebp-038h]
.20:
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0354h], eax
        push byte 0
        push str_BACK10
        push edi
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+06h]
        push eax
        push str_BACK10
        push edi
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+04h]
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push str_BACK10
        push edi
        mov ebx, eax
        mov dword [byte ebp-014h], eax
        call FindShape
        add esp, byte 8
        push str_BACK10
        mov edx, dword [byte ebx+02Ch]
        mov ax, word [byte eax+0Ch]
        push edi
        mov word [byte edx+0Ch], ax
        call FindShape
        add esp, byte 8
        mov edx, dword [byte ebx+02Ch]
        mov ax, word [byte eax+0Eh]
        push ebx
        mov word [byte edx+0Eh], ax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        push byte 0
        push str_BACK10
        push edi
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        push byte 3
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push eax
        push byte 5Ah
        push dword 0C8h
        push byte 5Ah
        push dword 0D7h
        call DrawShadowRect
        add esp, byte 18h
        push byte 3
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push eax
        push byte 73h
        push dword 0CAh
        push byte 5Ah
        push dword 0CAh
        call DrawShadowRect
        add esp, byte 18h
        push byte 3
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push eax
        push byte 73h
        push dword 0C8h
        push byte 73h
        push dword 0D7h
        call DrawShadowRect
        add esp, byte 18h
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 1F0h
        call GetLangText
        push eax
        mov eax, dword [byte ebx+02Ch]
        mov ecx, 6Eh
        movsx edx, word [byte eax+0Eh]
        movsx eax, word [byte eax+0Ch]
        sub ecx, edx
        mov edx, 140h
        push ecx
        sub edx, eax
        push edx
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 1F1h
        call GetLangText
        push eax
        mov eax, dword [byte ebx+02Ch]
        mov ecx, 87h
        movsx edx, word [byte eax+0Eh]
        movsx eax, word [byte eax+0Ch]
        sub ecx, edx
        mov edx, 140h
        push ecx
        sub edx, eax
        push edx
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 1F2h
        call GetLangText
        push eax
        mov eax, dword [byte ebx+02Ch]
        mov ecx, 0A0h
        movsx edx, word [byte eax+0Eh]
        movsx eax, word [byte eax+0Ch]
        sub ecx, edx
        mov edx, 140h
        push ecx
        sub edx, eax
        push edx
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 1F3h
        call GetLangText
        push eax
        mov eax, dword [byte ebx+02Ch]
        mov ecx, 0B9h
        movsx edx, word [byte eax+0Eh]
        movsx eax, word [byte eax+0Ch]
        sub ecx, edx
        mov edx, 140h
        push ecx
        sub edx, eax
        push edx
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 1F4h
        call GetLangText
        push eax
        mov eax, dword [byte ebx+02Ch]
        mov ecx, 0D2h
        movsx edx, word [byte eax+0Eh]
        movsx eax, word [byte eax+0Ch]
        sub ecx, edx
        mov edx, 140h
        push ecx
        sub edx, eax
        push edx
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 1F5h
        call GetLangText
        push eax
        mov eax, dword [byte ebx+02Ch]
        mov ecx, 0EBh
        movsx edx, word [byte eax+0Eh]
        movsx eax, word [byte eax+0Ch]
        sub ecx, edx
        mov edx, 140h
        push ecx
        sub edx, eax
        push edx
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        mov eax, 1F6h
        call GetLangText
        push eax
        mov eax, dword [byte ebx+02Ch]
        mov ebx, 104h
        movsx edx, word [byte eax+0Eh]
        movsx eax, word [byte eax+0Ch]
        sub ebx, edx
        mov edx, 140h
        push ebx
        sub edx, eax
        push edx
        push byte 0
        mov esi, 1
        call DrawTextAligned
        add esp, byte 10h
        jmp short .23
.21:
        movsx eax, si
        imul eax, byte 52h
        cmp dword [dword eax+ebp-059Ah], byte 0
        je short .22
        mov ebx, dword [byte ebp-014h]
        mov ebx, dword [byte ebx+02Ch]
        mov ecx, dword [dword eax+ebp-058Ah]
        movsx edx, word [byte ebx+0Eh]
        sub ecx, edx
        movsx edx, word [byte ebx+0Ch]
        mov ebx, dword [dword eax+ebp-058Eh]
        push ecx
        sub ebx, edx
        push ebx
        push dword [dword eax+ebp-059Ah]
        call DrawShapeCore
        add esp, byte 0Ch
.22:
        inc esi
.23:
        cmp si, byte 9
        jle short .21
        push byte 0
        push str_BACK10
        push edi
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+06h]
        push eax
        push str_BACK10
        push edi
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+04h]
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push str_BACK10
        push edi
        mov ebx, eax
        mov dword [byte ebp-010h], eax
        call FindShape
        add esp, byte 8
        push str_BACK10
        mov edx, dword [byte ebx+02Ch]
        mov ax, word [byte eax+0Ch]
        push edi
        mov word [byte edx+0Ch], ax
        call FindShape
        mov edx, dword [byte ebx+02Ch]
        mov ax, word [byte eax+0Eh]
        add esp, byte 8
        mov word [byte edx+0Eh], ax
        call StopAllSfx
        mov eax, 200h
        xor esi, esi
        call PlaySfx
        jmp near .25
.24:
        call ServiceIdle
        push dword [byte ebp-010h]
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        mov eax, dword [byte ebp-014h]
        push byte 0
        push dword [byte eax+02Ch]
        mov ebx, dword [byte ebp-020h]
        call BlitArt
        mov ebx, dword [byte ebx+02Ch]
        movsx eax, word [byte ebx+06h]
        movsx edx, si
        neg eax
        imul eax, edx
        mov ecx, 14h
        mov dword [byte ebp-02Ch], edx
        cdq
        idiv ecx
        add esp, byte 0Ch
        push eax
        push byte 0
        push ebx
        mov ebx, dword [byte ebp-01Ch]
        call BlitArt
        mov edx, 14h
        mov ebx, dword [byte ebx+02Ch]
        sub edx, dword [byte ebp-02Ch]
        movsx eax, word [byte ebx+06h]
        imul eax, edx
        mov ecx, 14h
        mov dword [byte ebp-028h], edx
        cdq
        idiv ecx
        mov edx, eax
        mov eax, dword [byte ebp-010h]
        mov eax, dword [byte eax+02Ch]
        movsx eax, word [byte eax+06h]
        add esp, byte 0Ch
        sub eax, edx
        push eax
        push byte 0
        push ebx
        call BlitArt
        add esp, byte 0Ch
        call SetScreenTarget
        push str_TTL12
        push dword [byte ebp-0Ch]
        call FindShape
        movsx eax, word [byte eax+06h]
        neg eax
        imul eax, dword [byte ebp-028h]
        mov ebx, 14h
        cdq
        idiv ebx
        add esp, byte 8
        push eax
        push byte 0
        push str_TTL12
        push dword [byte ebp-0Ch]
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        push str_BOT1
        push edi
        call FindShape
        movsx eax, word [byte eax+06h]
        imul eax, dword [byte ebp-02Ch]
        cdq
        idiv ebx
        mov edx, 1E0h
        add esp, byte 8
        sub edx, eax
        push edx
        push byte 0
        push str_BOT1
        push edi
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        mov eax, dword [byte ebp-010h]
        push dword [byte eax+02Ch]
        inc esi
        call BlitShape2
        add esp, byte 4
.25:
        cmp si, byte 14h
        jle near .24
        call PresentScreen
        call StopAllSfx
        mov eax, 201h
        call PlaySfx
        push str_TTL12
        push dword [byte ebp-0Ch]
        call FindShape
        add esp, byte 8
        push str_BOT1
        push edi
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push str_BOT1
        push edi
        mov esi, eax
        call FindShape
        add esp, byte 8
        mov edx, esi
        mov ecx, 52h
        call DrawScreenBackground
        push byte 0
        lea edi, [dword ebp-05B4h]
        mov esi, BlankMenuItem
        push dword 10Eh
        rep movsb
        push byte 1Eh
        mov dword [dword ebp-05B4h], 0
        call CreateBitmap
        add esp, byte 0Ch
        mov ebx, eax
        mov edi, eax
        call SetScreenTarget
        push byte 78h
        push dword 12Ch
        push dword [byte ebx+02Ch]
        call ConvertArtXY
        add esp, byte 0Ch
        jmp near DetailLevelScreen_A93.31
DetailLevelScreen_A25:
        call FadeInScreen
        mov dword [byte ebp-08h], 1
        jmp near DetailLevelScreen_B18
DetailLevelScreen_A36:
        test byte [MusicOptions], 20h
        je short .26
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0548h], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0544h], eax
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        and byte [MusicOptions], 0DFh
        jmp short .27
.26:
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0548h], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0544h], eax
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        or byte [MusicOptions], 20h
.27:
        mov dword [dword ebp-0540h], eax
        jmp short DetailLevelScreen_A93.30
DetailLevelScreen_A93:
        cmp byte [FrontMusicOn], 0
        je short .28
        and byte [MusicOptions], 0BFh
        jmp short DetailLevelScreen_B18
.28:
        test byte [MusicOptions], 40h
        je near DetailLevelScreen_B18.32
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04F6h], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04F2h], eax
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04EEh], eax
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04A4h], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04A0h], eax
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        and word [MusicOptions], 0FEBFh
.29:
        mov dword [dword ebp-049Ch], eax
.30:
        call SetScreenTarget
        push dword [byte edi+02Ch]
        call BlitShape2
        add esp, byte 4
.31:
        call PresentScreen
DetailLevelScreen_B18:
        cmp word [byte ebp-08h], byte 0
        jne near DetailLevelScreen_D46.43
        push byte 2
        lea eax, [byte ebp-030h]
        mov ebx, 0FFFFFFFFh
        lea edx, [dword ebp-05B4h]
        push eax
        xor ecx, ecx
        mov eax, 0Ah
        call RunMenu
        cmp dword [byte ebp-030h], byte 9
        ja short DetailLevelScreen_B18
        mov eax, dword [byte ebp-030h]
        jmp dword [nosplit cs:eax*4+DetailLevelScreenJumpTable]
.32:
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04F6h], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04F2h], eax
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        or byte [MusicOptions], 40h
        mov dword [dword ebp-04EEh], eax
        jmp short DetailLevelScreen_A93.30
DetailLevelScreen_B7E:
        mov edx, dword [AudioOptions]
        and edx, 0FEFFFFFFh
        cmp byte [FrontMusicOn], 0
        je short .33
        mov dword [AudioOptions], edx
        jmp near DetailLevelScreen_B18
.33:
        test byte [DetailLevel], 1
        je short .34
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04A4h], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04A0h], eax
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-049Ch], eax
        mov dword [AudioOptions], edx
        jmp near DetailLevelScreen_A93.30
.34:
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04F6h], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04F2h], eax
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04EEh], eax
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04A4h], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-04A0h], eax
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        or word [MusicOptions], 140h
        jmp near DetailLevelScreen_A93.29
DetailLevelScreen_C26:
        test byte [DetailLevel], 2
        je short .35
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0452h], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-044Eh], eax
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        and byte [DetailLevel], 0FDh
        jmp short .36
.35:
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0452h], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-044Eh], eax
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        or byte [DetailLevel], 2
.36:
        mov dword [dword ebp-044Ah], eax
        jmp near DetailLevelScreen_A93.30
DetailLevelScreen_C86:
        test byte [DetailLevel], 4
        je short .37
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0400h], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-03FCh], eax
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        and byte [DetailLevel], 0FBh
        jmp short .38
.37:
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0400h], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-03FCh], eax
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        or byte [DetailLevel], 4
.38:
        mov dword [dword ebp-03F8h], eax
        jmp near DetailLevelScreen_A93.30
DetailLevelScreen_CE6:
        test byte [DetailLevel], 8
        je short .39
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-03AEh], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-03AAh], eax
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        and byte [DetailLevel], 0F7h
        jmp short .40
.39:
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-03AEh], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-03AAh], eax
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        or byte [DetailLevel], 8
.40:
        mov dword [dword ebp-03A6h], eax
        jmp near DetailLevelScreen_A93.30
DetailLevelScreen_D46:
        test byte [DetailLevel], 20h
        je short .41
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-035Ch], eax
        mov eax, dword [byte ebp-034h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0358h], eax
        mov eax, dword [byte ebp-038h]
        mov eax, dword [byte eax+02Ch]
        and byte [DetailLevel], 0DFh
        jmp short .42
.41:
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-035Ch], eax
        mov eax, dword [byte ebp-03Ch]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword ebp-0358h], eax
        mov eax, dword [byte ebp-040h]
        mov eax, dword [byte eax+02Ch]
        or byte [DetailLevel], 20h
.42:
        mov dword [dword ebp-0354h], eax
        jmp near DetailLevelScreen_A93.30
.43:
        push dword [byte ebp-014h]
        mov esi, 1
        call SetDrawTarget
        add esp, byte 4
        jmp short .46
.44:
        movsx eax, si
        imul eax, byte 52h
        cmp dword [dword eax+ebp-059Ah], byte 0
        je short .45
        mov ebx, dword [byte ebp-014h]
        mov ebx, dword [byte ebx+02Ch]
        mov ecx, dword [dword eax+ebp-058Ah]
        movsx edx, word [byte ebx+0Eh]
        sub ecx, edx
        movsx edx, word [byte ebx+0Ch]
        mov ebx, dword [dword eax+ebp-058Eh]
        push ecx
        sub ebx, edx
        push ebx
        push dword [dword eax+ebp-059Ah]
        call DrawShapeCore
        add esp, byte 0Ch
.45:
        inc esi
.46:
        cmp si, byte 9
        jle short .44
        call StopAllSfx
        mov eax, 200h
        mov esi, 14h
        call PlaySfx
        jmp near .48
.47:
        call ServiceIdle
        push dword [byte ebp-010h]
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        mov eax, dword [byte ebp-014h]
        push byte 0
        push dword [byte eax+02Ch]
        mov ebx, dword [byte ebp-020h]
        call BlitArt
        mov ebx, dword [byte ebx+02Ch]
        movsx eax, word [byte ebx+06h]
        movsx edx, si
        neg eax
        imul eax, edx
        mov ecx, 14h
        mov dword [byte ebp-028h], edx
        cdq
        idiv ecx
        add esp, byte 0Ch
        push eax
        push byte 0
        push ebx
        mov ebx, dword [byte ebp-01Ch]
        call BlitArt
        mov eax, 14h
        mov ebx, dword [byte ebx+02Ch]
        sub eax, dword [byte ebp-028h]
        movsx edx, word [byte ebx+06h]
        imul eax, edx
        mov ecx, 14h
        cdq
        idiv ecx
        mov edx, eax
        mov eax, dword [byte ebp-010h]
        mov eax, dword [byte eax+02Ch]
        movsx eax, word [byte eax+06h]
        add esp, byte 0Ch
        sub eax, edx
        push eax
        push byte 0
        push ebx
        call BlitArt
        add esp, byte 0Ch
        call SetScreenTarget
        mov eax, dword [byte ebp-010h]
        push dword [byte eax+02Ch]
        call BlitShape2
        add esp, byte 4
        push str_TTL02
        push dword [byte ebp-0Ch]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        mov eax, dword [byte ebp-024h]
        add esp, byte 4
        push dword [byte eax+02Ch]
        dec esi
        call BlitShape2
        add esp, byte 4
.48:
        test si, si
        jge near .47
        call PresentScreen
        call StopAllSfx
        mov eax, 201h
        call PlaySfx
        push dword [byte ebp-020h]
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp-01Ch]
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp-040h]
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp-03Ch]
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp-038h]
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp-034h]
        call FreeBitmap
        add esp, byte 4
        push edi
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp-010h]
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp-014h]
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp-024h]
        call FreeBitmap
        add esp, byte 4
        leave
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawOptionsSlider                               C462F  97 PC, low confidence
; Draws an options slider
;-----------------------------------------------------------------------------
DrawOptionsSlider:
        push esi
        push edi
        push ebp
        mov ebp, esp
        push edx
        mov edi, ecx
        cmp eax, byte 64h
        jne short .1
        mov esi, 11Ah
        jmp near .8
.1:
        test eax, eax
        jl short .2
        cmp eax, byte 0Fh
        jge short .2
        mov esi, 0C4h
        jmp near .8
.2:
        cmp eax, byte 0Fh
        jl short .3
        cmp eax, byte 1Eh
        jge short .3
        mov esi, 0D1h
        jmp near .8
.3:
        cmp eax, byte 1Eh
        jl short .4
        cmp eax, byte 2Dh
        jge short .4
        mov esi, 0DCh
        jmp short .8
.4:
        cmp eax, byte 2Dh
        jl short .5
        cmp eax, byte 3Ch
        jge short .5
        mov esi, 0E8h
        jmp short .8
.5:
        cmp eax, byte 3Ch
        jl short .6
        cmp eax, byte 4Bh
        jge short .6
        mov esi, 0F6h
        jmp short .8
.6:
        cmp eax, byte 4Bh
        jl short .7
        cmp eax, byte 5Ah
        jge short .7
        mov esi, 102h
        jmp short .8
.7:
        cmp eax, byte 5Ah
        jl short .8
        cmp eax, byte 64h
        jge short .8
        mov esi, 10Eh
.8:
        push dword [byte ebx+02Ch]
        call BlitShape2
        add esp, byte 4
        push edi
        push esi
        push str_BAL1
        push dword [byte ebp-04h]
        call FindShape
        add esp, byte 8
        push eax
        call DrawShapeCore
        add esp, byte 0Ch
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; OptionsSound                                    C46EA  97 PC, low confidence
; Plays an options sound
;-----------------------------------------------------------------------------
OptionsSound:
        push ebx
        push ecx
        push edx
        push esi
        xor edx, edx
        cmp dword [OptionsMenuItems+0A8h], byte 1
        jne short .1
        call rand_
        mov ebx, 3
        cdq
        idiv ebx
        push dword [OptionsMenuItems+0CEh]
        push dword [OptionsMenuItems+0CAh]
        mov eax, dword [nosplit edx*4+OptionsMusicShapes]
        push eax
        mov dword [OptionsMenuItems+0C2h], eax
        call DrawArt
        mov edx, 1
        add esp, byte 0Ch
.1:
        cmp dword [OptionsMenuItems+0FAh], byte 1
        jne short .2
        call rand_
        mov ebx, 3
        cdq
        idiv ebx
        push dword [OptionsMenuItems+120h]
        push dword [OptionsMenuItems+11Ch]
        mov eax, dword [nosplit edx*4+OptionsSoundShapes]
        push eax
        mov dword [OptionsMenuItems+114h], eax
        call DrawArt
        mov edx, 1
        add esp, byte 0Ch
.2:
        mov esi, 4
.3:
        imul ebx, esi, byte 52h
        cmp dword [dword ebx+OptionsMenuItems+4], byte 1
        jne short .6
        mov eax, dword [dword ebx+OptionsMenuItems+1Ah]
        cmp eax, dword [OptionsButtonOff]
        jne short .4
        call rand_
        mov ecx, 3
        cdq
        idiv ecx
        mov eax, dword [nosplit edx*4+OptionsButtonOnShapes]
        jmp short .5
.4:
        call rand_
        mov ecx, 3
        cdq
        idiv ecx
        mov eax, dword [nosplit edx*4+OptionsButtonDownShapes]
.5:
        mov dword [dword ebx+OptionsMenuItems+1Eh], eax
        imul eax, esi, byte 52h
        push dword [dword eax+OptionsMenuItems+2Ah]
        push dword [dword eax+OptionsMenuItems+26h]
        push dword [dword eax+OptionsMenuItems+1Eh]
        call DrawArt
        mov edx, 1
        add esp, byte 0Ch
.6:
        inc esi
        cmp esi, byte 9
        jle short .3
        test edx, edx
        je short .7
        cmp dword [OptionsSoundPlayed], byte 0
        jne short .7
        mov eax, 309h
        call PlaySfx
        mov dword [OptionsSoundPlayed], 1
.7:
        test edx, edx
        jne short .8
        cmp dword [OptionsSoundPlayed], byte 0
        je short .8
        mov eax, 309h
        call PlayMenuSfx
        mov dword [OptionsSoundPlayed], edx
.8:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
OptionsScreenJumpTable:                         ; jump table for the switch cases of OptionsScreen
        dd OptionsScreen_14BA
        dd OptionsScreen_F0A
        dd OptionsScreen_F22
        dd OptionsScreen_10AA
        dd OptionsScreen_10D0
        dd OptionsScreen_1125
        dd OptionsScreen_117A
        dd OptionsScreen_11CF
        dd OptionsScreen_1285
        dd OptionsScreen_12DA
        dd OptionsScreen_1359
        dd OptionsScreen_136C
        dd OptionsScreen_137F
        dd OptionsScreen_14BA
        dd OptionsScreen_13A6
        dd OptionsScreen_140D
        dd OptionsScreen_1451
        dd OptionsScreen_1431
        dd OptionsScreen_1435
        dd OptionsScreen_1439
        dd OptionsScreen_143D
        dd OptionsScreen_1441
        dd OptionsScreen_1447
        dd OptionsScreen_144D
        dd OptionsScreen_147B
        dd OptionsScreen_14FE
        dd OptionsScreen_1519
        dd OptionsScreen_1534
        dd OptionsScreen_154F
        dd OptionsScreen_156A
        dd OptionsScreen_1588
        dd OptionsScreen_15A6
;-----------------------------------------------------------------------------
; OptionsScreen                                   C48A2  97 PC, low confidence
; The options screen (ON0%d / OF0%d toggles, MB0%d buttons, BOTM)
;-----------------------------------------------------------------------------
OptionsScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 80Ch, 0
        sub ebp, 82h
        call UpdateOptionsAnim
        mov dword [byte ebp+076h], 0FFFFFFFFh
        mov dword [byte ebp+07Ah], 0
        xor ebx, ebx
        jmp short .2
.1:
        movsx eax, bx
        inc ebx
        mov word [byte ebp+eax*2+01Eh], 0
.2:
        cmp bx, byte 10h
        jl short .1
        mov dword [byte ebp+07Eh], 0
        xor ebx, ebx
        jmp short .6
.3:
        imul eax, byte 38h
        mov edx, dword [GripDriverPtr]
        test byte [edx+eax], 1
        je short .5
        movsx eax, word [byte ebp+07Eh]
        mov word [byte ebp+eax*2+01Eh], bx
        movsx eax, word [byte ebp+076h]
        cmp eax, byte 0FFFFFFFFh
        jne short .4
        mov eax, dword [byte ebp+07Eh]
        mov dword [byte ebp+076h], eax
.4:
        inc dword [byte ebp+07Eh]
.5:
        inc ebx
.6:
        movzx edx, word [GripPortWord]
        movsx eax, bx
        cmp eax, edx
        jge short .7
        cmp bx, byte 10h
        jl short .3
.7:
        mov edx, OptionsMenuItems
        mov eax, 20h
        call InitMenuItems
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 17h
        call LoadDataFile
        mov dword [byte ebp+06Eh], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 16h
        call LoadDataFile
        mov ebx, eax
        mov dword [byte ebp+072h], eax
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push str_BOTM3
        push ebx
        call FindShape
        add esp, byte 8
        mov dword [byte ebp+06Ah], eax
        xor ebx, ebx
        jmp near .9
.8:
        movsx edi, bx
        push edi
        push str_ON0D
        lea eax, [byte ebp+03Eh]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+03Eh]
        push eax
        push dword [byte ebp+06Eh]
        call FindShape
        add esp, byte 8
        push edi
        push str_OF0D
        mov dword [nosplit edi*4+OptionsButtonOff], eax
        lea eax, [byte ebp+03Eh]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+03Eh]
        push eax
        push dword [byte ebp+06Eh]
        call FindShape
        add esp, byte 8
        push edi
        push str_MB0D
        mov dword [nosplit edi*4+OptionsLabelShapes], eax
        lea eax, [byte ebp+03Eh]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+03Eh]
        push eax
        push dword [byte ebp+06Eh]
        call FindShape
        add esp, byte 8
        mov esi, edi
        add edi, byte 4
        push edi
        push str_MB0D
        mov dword [nosplit edi*4+OptionsButtonShapes], eax
        lea eax, [byte ebp+03Eh]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+03Eh]
        push eax
        push dword [byte ebp+06Eh]
        inc ebx
        call FindShape
        add esp, byte 8
        mov dword [nosplit esi*4+OptionsButtonShapes], eax
.9:
        cmp bx, byte 4
        jl near .8
        push byte 0
        push byte 3Bh
        push byte 47h
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push byte 3Bh
        push byte 47h
        mov dword [byte ebp+04Eh], eax
        call CreateBitmap
        add esp, byte 0Ch
        push dword [byte ebp+04Eh]
        mov dword [byte ebp+052h], eax
        call SetDrawTarget
        add esp, byte 4
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        call ClearScreen
        add esp, byte 4
        push dword 0A0A0Ah
        call MakeColor
        add esp, byte 4
        push eax
        push byte 3Ah
        push byte 46h
        push byte 0
        push byte 0
        call FillRectCorners
        add esp, byte 14h
        push dword [byte ebp+052h]
        call SetDrawTarget
        add esp, byte 4
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        call ClearScreen
        add esp, byte 4
        push dword 0F7DF00h
        call MakeColor
        add esp, byte 4
        push eax
        push byte 3Ah
        push byte 46h
        push byte 0
        push byte 0
        mov ebx, dword [byte ebp+06Ah]
        call FillRectCorners
        add esp, byte 14h
        mov edi, OptionsMenuItems+52h
        mov esi, BlankMenuItem
        call PresentScreen
        mov edx, ebx
        mov eax, ebx
        mov ecx, 52h
        call DrawScreenBackground
        push str_MB003
        rep movsb
        push dword [byte ebp+06Eh]
        mov dword [OptionsMenuItems+52h], 1
        call FindShape
        add esp, byte 8
        push str_MB013
        push dword [byte ebp+06Eh]
        mov dword [OptionsMenuItems+0BEh], eax
        call FindShape
        add esp, byte 8
        mov dword [OptionsMenuItems+0C2h], eax
        push str_MB013
        push dword [byte ebp+06Eh]
        call FindShape
        add esp, byte 8
        push str_MB003
        push dword [byte ebp+06Eh]
        mov dword [OptionsMenuItems+0C6h], eax
        call FindShape
        add esp, byte 8
        push str_MB003
        movsx eax, word [byte eax+0Ch]
        push dword [byte ebp+06Eh]
        mov dword [OptionsMenuItems+0CAh], eax
        call FindShape
        movsx eax, word [byte eax+0Eh]
        mov dword [OptionsMenuItems+0CEh], eax
        lea eax, [dword ebp-078Ah]
        add esp, byte 8
        mov dword [OptionsMenuItems+0B8h], eax
        mov eax, dword [OptionsMenuItems+0BEh]
        mov dword [OptionsMenuItems+0B4h], 4
        mov ebx, dword [OptionsMenuItems+0CEh]
        movsx edx, word [byte eax+06h]
        movsx ecx, word [byte eax+04h]
        push edx
        lea eax, [dword ebp-078Ah]
        mov edx, dword [OptionsMenuItems+0CAh]
        call SetRegionRect
        push str_MB043
        push dword [byte ebp+06Eh]
        call FindShape
        add esp, byte 8
        push str_MB052
        push dword [byte ebp+06Eh]
        mov dword [OptionsMenuItems+110h], eax
        call FindShape
        add esp, byte 8
        push str_MB052
        push dword [byte ebp+06Eh]
        mov dword [OptionsMenuItems+114h], eax
        call FindShape
        add esp, byte 8
        push str_MB043
        push dword [byte ebp+06Eh]
        mov dword [OptionsMenuItems+118h], eax
        call FindShape
        add esp, byte 8
        push str_MB043
        movsx eax, word [byte eax+0Ch]
        push dword [byte ebp+06Eh]
        mov dword [OptionsMenuItems+11Ch], eax
        call FindShape
        movsx eax, word [byte eax+0Eh]
        mov dword [OptionsMenuItems+120h], eax
        lea eax, [dword ebp-074Ah]
        add esp, byte 8
        mov dword [OptionsMenuItems+10Ah], eax
        mov eax, dword [OptionsMenuItems+110h]
        mov dword [OptionsMenuItems+106h], 4
        mov ebx, dword [OptionsMenuItems+120h]
        movsx edx, word [byte eax+06h]
        movsx ecx, word [byte eax+04h]
        push edx
        lea eax, [dword ebp-074Ah]
        mov edx, dword [OptionsMenuItems+11Ch]
        call SetRegionRect
        test byte [SfxOptions], 2
        je short .10
        mov eax, dword [OptionsButtonOff]
        mov dword [OptionsMenuItems+162h], eax
        mov eax, dword [OptionsButtonOnShapes]
        mov dword [OptionsMenuItems+166h], eax
        mov eax, dword [OptionsButtonLit]
        jmp short .11
.10:
        mov eax, dword [OptionsLabelShapes]
        mov dword [OptionsMenuItems+162h], eax
        mov eax, dword [OptionsButtonDownShapes]
        mov dword [OptionsMenuItems+166h], eax
        mov eax, dword [OptionsButtonDownLit]
.11:
        mov dword [OptionsMenuItems+16Ah], eax
        mov dword [OptionsMenuItems+16Eh], 140h
        lea eax, [dword ebp-070Ah]
        mov dword [OptionsMenuItems+172h], 5Eh
        mov dword [OptionsMenuItems+15Ch], eax
        mov eax, dword [OptionsMenuItems+162h]
        mov dword [OptionsMenuItems+158h], 4
        mov ebx, 5Eh
        movsx edx, word [byte eax+06h]
        movsx ecx, word [byte eax+04h]
        push edx
        lea eax, [dword ebp-070Ah]
        mov edx, 140h
        call SetRegionRect
        test byte [MusicOptions], 4
        je short .12
        mov eax, dword [OptionsButtonOff]
        mov dword [OptionsMenuItems+1B4h], eax
        mov eax, dword [OptionsButtonOnShapes]
        mov dword [OptionsMenuItems+1B8h], eax
        mov eax, dword [OptionsButtonLit]
        jmp short .13
.12:
        mov eax, dword [OptionsLabelShapes]
        mov dword [OptionsMenuItems+1B4h], eax
        mov eax, dword [OptionsButtonDownShapes]
        mov dword [OptionsMenuItems+1B8h], eax
        mov eax, dword [OptionsButtonDownLit]
.13:
        mov dword [OptionsMenuItems+1BCh], eax
        mov dword [OptionsMenuItems+1C0h], 140h
        lea eax, [dword ebp-06CAh]
        mov dword [OptionsMenuItems+1C4h], 8Fh
        mov dword [OptionsMenuItems+1AEh], eax
        mov eax, dword [OptionsMenuItems+1B4h]
        mov dword [OptionsMenuItems+1AAh], 4
        mov ebx, 8Fh
        movsx edx, word [byte eax+06h]
        movsx ecx, word [byte eax+04h]
        push edx
        lea eax, [dword ebp-06CAh]
        mov edx, 140h
        call SetRegionRect
        test byte [MusicOptions], 10h
        je short .14
        mov eax, dword [OptionsButtonOff]
        mov dword [OptionsMenuItems+206h], eax
        mov eax, dword [OptionsButtonOnShapes]
        mov dword [OptionsMenuItems+20Ah], eax
        mov eax, dword [OptionsButtonLit]
        jmp short .15
.14:
        mov eax, dword [OptionsLabelShapes]
        mov dword [OptionsMenuItems+206h], eax
        mov eax, dword [OptionsButtonDownShapes]
        mov dword [OptionsMenuItems+20Ah], eax
        mov eax, dword [OptionsButtonDownLit]
.15:
        mov dword [OptionsMenuItems+20Eh], eax
        mov dword [OptionsMenuItems+212h], 140h
        lea eax, [dword ebp-068Ah]
        mov dword [OptionsMenuItems+216h], 13Eh
        mov dword [OptionsMenuItems+200h], eax
        mov eax, dword [OptionsMenuItems+206h]
        mov dword [OptionsMenuItems+1FCh], 4
        mov ebx, 13Eh
        movsx edx, word [byte eax+06h]
        movsx ecx, word [byte eax+04h]
        push edx
        lea eax, [dword ebp-068Ah]
        mov edx, 140h
        call SetRegionRect
        test byte [AudioOptions], 2
        je short .16
        mov eax, dword [OptionsButtonOff]
        mov dword [OptionsMenuItems+258h], eax
        mov eax, dword [OptionsButtonOnShapes]
        mov dword [OptionsMenuItems+25Ch], eax
        mov eax, dword [OptionsButtonLit]
        jmp short .17
.16:
        mov eax, dword [OptionsLabelShapes]
        mov dword [OptionsMenuItems+258h], eax
        mov eax, dword [OptionsButtonDownShapes]
        mov dword [OptionsMenuItems+25Ch], eax
        mov eax, dword [OptionsButtonDownLit]
.17:
        mov dword [OptionsMenuItems+260h], eax
        mov dword [OptionsMenuItems+264h], 140h
        lea eax, [dword ebp-064Ah]
        mov dword [OptionsMenuItems+268h], 111h
        mov dword [OptionsMenuItems+252h], eax
        mov eax, dword [OptionsMenuItems+258h]
        mov dword [OptionsMenuItems+24Eh], 4
        mov ebx, 111h
        movsx edx, word [byte eax+06h]
        movsx ecx, word [byte eax+04h]
        push edx
        lea eax, [dword ebp-064Ah]
        mov edx, 140h
        call SetRegionRect
        test byte [MusicOptions], 2
        je short .18
        mov eax, dword [OptionsButtonOff]
        mov dword [OptionsMenuItems+2AAh], eax
        mov eax, dword [OptionsButtonOnShapes]
        mov dword [OptionsMenuItems+2AEh], eax
        mov eax, dword [OptionsButtonLit]
        jmp short .19
.18:
        mov eax, dword [OptionsLabelShapes]
        mov dword [OptionsMenuItems+2AAh], eax
        mov eax, dword [OptionsButtonDownShapes]
        mov dword [OptionsMenuItems+2AEh], eax
        mov eax, dword [OptionsButtonDownLit]
.19:
        mov dword [OptionsMenuItems+2B2h], eax
        mov dword [OptionsMenuItems+2B6h], 140h
        lea eax, [dword ebp-060Ah]
        mov dword [OptionsMenuItems+2BAh], 0C1h
        mov dword [OptionsMenuItems+2A4h], eax
        mov eax, dword [OptionsMenuItems+2AAh]
        mov dword [OptionsMenuItems+2A0h], 4
        mov ebx, 0C1h
        movsx edx, word [byte eax+06h]
        movsx ecx, word [byte eax+04h]
        push edx
        lea eax, [dword ebp-060Ah]
        mov edx, 140h
        call SetRegionRect
        test byte [MusicOptions], 8
        je short .20
        cmp byte [FrontMusicOn], 0
        jne short .20
        mov eax, dword [OptionsButtonOff]
        mov dword [OptionsMenuItems+2FCh], eax
        mov eax, dword [OptionsButtonOnShapes]
        mov dword [OptionsMenuItems+300h], eax
        mov eax, dword [OptionsButtonLit]
        jmp short .21
.20:
        mov eax, dword [OptionsLabelShapes]
        mov dword [OptionsMenuItems+2FCh], eax
        mov eax, dword [OptionsButtonDownShapes]
        mov dword [OptionsMenuItems+300h], eax
        mov eax, dword [OptionsButtonDownLit]
.21:
        mov dword [OptionsMenuItems+304h], eax
        mov dword [OptionsMenuItems+308h], 140h
        lea eax, [dword ebp-05CAh]
        mov dword [OptionsMenuItems+30Ch], 16Ah
        mov dword [OptionsMenuItems+2F6h], eax
        mov eax, dword [OptionsMenuItems+2FCh]
        mov dword [OptionsMenuItems+2F2h], 4
        mov ebx, 16Ah
        movsx edx, word [byte eax+06h]
        movsx ecx, word [byte eax+04h]
        push edx
        lea eax, [dword ebp-05CAh]
        mov edx, 140h
        call SetRegionRect
        mov eax, dword [byte ebp+04Eh]
        mov eax, dword [byte eax+02Ch]
        mov dword [OptionsMenuItems+34Eh], eax
        mov eax, dword [byte ebp+052h]
        mov eax, dword [byte eax+02Ch]
        mov dword [OptionsMenuItems+352h], eax
        mov eax, dword [byte ebp+052h]
        mov eax, dword [byte eax+02Ch]
        mov dword [OptionsMenuItems+35Ah], 203h
        mov dword [OptionsMenuItems+356h], eax
        lea eax, [dword ebp-058Ah]
        mov dword [OptionsMenuItems+35Eh], 4Ch
        mov dword [OptionsMenuItems+348h], eax
        mov eax, dword [OptionsMenuItems+34Eh]
        mov dword [OptionsMenuItems+344h], 4
        mov ebx, 4Ch
        movsx edx, word [byte eax+06h]
        movsx ecx, word [byte eax+04h]
        push edx
        lea eax, [dword ebp-058Ah]
        mov edx, 203h
        call SetRegionRect
        mov eax, dword [byte ebp+04Eh]
        mov eax, dword [byte eax+02Ch]
        mov dword [OptionsMenuItems+3A0h], eax
        mov eax, dword [byte ebp+052h]
        mov eax, dword [byte eax+02Ch]
        mov dword [OptionsMenuItems+3A4h], eax
        mov eax, dword [byte ebp+052h]
        mov eax, dword [byte eax+02Ch]
        mov dword [OptionsMenuItems+3ACh], 203h
        mov dword [OptionsMenuItems+3A8h], eax
        lea eax, [dword ebp-054Ah]
        mov dword [OptionsMenuItems+3B0h], 0A2h
        mov dword [OptionsMenuItems+39Ah], eax
        mov eax, dword [OptionsMenuItems+3A0h]
        mov dword [OptionsMenuItems+396h], 4
        mov ebx, 0A2h
        movsx edx, word [byte eax+06h]
        movsx ecx, word [byte eax+04h]
        push edx
        lea eax, [dword ebp-054Ah]
        mov edx, 203h
        call SetRegionRect
        mov eax, dword [byte ebp+04Eh]
        mov eax, dword [byte eax+02Ch]
        mov dword [OptionsMenuItems+3F2h], eax
        cmp word [byte ebp+07Eh], byte 0
        je short .22
        mov eax, dword [byte ebp+052h]
        mov eax, dword [byte eax+02Ch]
        mov dword [OptionsMenuItems+3F6h], eax
        mov eax, dword [byte ebp+052h]
        jmp short .23
.22:
        mov eax, dword [byte ebp+04Eh]
        mov eax, dword [byte eax+02Ch]
        mov dword [OptionsMenuItems+3F6h], eax
        mov eax, dword [byte ebp+04Eh]
.23:
        mov eax, dword [byte eax+02Ch]
        mov dword [OptionsMenuItems+3FAh], eax
        mov dword [OptionsMenuItems+3FEh], 203h
        lea eax, [dword ebp-050Ah]
        mov dword [OptionsMenuItems+402h], 113h
        mov dword [OptionsMenuItems+3ECh], eax
        mov eax, dword [OptionsMenuItems+3F2h]
        mov dword [OptionsMenuItems+3E8h], 4
        mov ebx, 113h
        movsx edx, word [byte eax+06h]
        movsx ecx, word [byte eax+04h]
        push edx
        lea eax, [dword ebp-050Ah]
        mov edx, 203h
        call SetRegionRect
        push str_CENT
        push dword [byte ebp+072h]
        call FindShape
        add esp, byte 8
        push str_LFT02
        push dword [byte ebp+072h]
        mov dword [OptionsMenuItems+496h], eax
        call FindShape
        add esp, byte 8
        push str_LFT2
        push dword [byte ebp+072h]
        mov dword [OptionsMenuItems+49Ah], eax
        call FindShape
        add esp, byte 8
        push str_LFT02
        push dword [byte ebp+072h]
        mov dword [OptionsMenuItems+49Eh], eax
        call FindShape
        add esp, byte 8
        push str_LFT02
        movsx eax, word [byte eax+0Ch]
        push dword [byte ebp+072h]
        mov dword [OptionsMenuItems+4A2h], eax
        call FindShape
        movsx eax, word [byte eax+0Eh]
        mov dword [OptionsMenuItems+4A6h], eax
        lea eax, [dword ebp-04CAh]
        mov dword [OptionsMenuItems+490h], eax
        mov eax, dword [OptionsMenuItems+49Ah]
        mov dword [OptionsMenuItems+48Ch], 4
        add esp, byte 8
        movsx edx, word [byte eax+06h]
        movsx eax, word [byte eax+04h]
        push edx
        cdq
        LD sub, eax, edx
        sar eax, 1
        mov ebx, dword [OptionsMenuItems+4A6h]
        mov edx, dword [OptionsMenuItems+4A2h]
        mov ecx, eax
        lea eax, [dword ebp-04CAh]
        call SetRegionRect
        push str_CENT
        push dword [byte ebp+072h]
        call FindShape
        add esp, byte 8
        push str_RIT02
        push dword [byte ebp+072h]
        mov dword [OptionsMenuItems+4E8h], eax
        call FindShape
        add esp, byte 8
        mov dword [OptionsMenuItems+4ECh], eax
        push str_RIT2
        push dword [byte ebp+072h]
        call FindShape
        add esp, byte 8
        push str_RIT02
        push dword [byte ebp+072h]
        mov dword [OptionsMenuItems+4F0h], eax
        call FindShape
        add esp, byte 8
        push str_RIT02
        movsx eax, word [byte eax+0Ch]
        push dword [byte ebp+072h]
        mov dword [OptionsMenuItems+4F4h], eax
        call FindShape
        movsx eax, word [byte eax+0Eh]
        mov dword [OptionsMenuItems+4F8h], eax
        lea eax, [dword ebp-048Ah]
        mov dword [OptionsMenuItems+4E2h], eax
        mov eax, dword [OptionsMenuItems+4ECh]
        mov dword [OptionsMenuItems+4DEh], 4
        add esp, byte 8
        movsx edx, word [byte eax+06h]
        movsx eax, word [byte eax+04h]
        push edx
        cdq
        LD sub, eax, edx
        sar eax, 1
        mov ebx, dword [OptionsMenuItems+4F8h]
        mov edx, dword [OptionsMenuItems+4F4h]
        mov ecx, eax
        add edx, eax
        lea eax, [dword ebp-048Ah]
        call SetRegionRect
        mov dword [OptionsMenuItems+530h], 4
        lea eax, [dword ebp-044Ah]
        push byte 15h
        mov ecx, 0Bh
        mov ebx, 110h
        mov edx, 0C4h
        mov dword [OptionsMenuItems+534h], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+582h], 4
        lea eax, [dword ebp-040Ah]
        push byte 18h
        mov ecx, 0Bh
        mov ebx, 10Fh
        mov edx, 0D1h
        mov dword [OptionsMenuItems+586h], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+5D4h], 4
        lea eax, [dword ebp-03CAh]
        push byte 1Ch
        mov ecx, 0Ch
        mov ebx, 10Ch
        mov edx, 0DCh
        mov dword [OptionsMenuItems+5D8h], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+626h], 4
        lea eax, [dword ebp-038Ah]
        push byte 1Fh
        mov ecx, 0Ch
        mov ebx, 10Bh
        mov edx, 0E8h
        mov dword [OptionsMenuItems+62Ah], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+678h], 4
        lea eax, [dword ebp-034Ah]
        push byte 25h
        mov ecx, 0Ah
        mov ebx, 108h
        mov edx, 0F6h
        mov dword [OptionsMenuItems+67Ch], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+6CAh], 4
        lea eax, [dword ebp-030Ah]
        push byte 2Dh
        mov ecx, 0Ah
        mov ebx, 104h
        mov edx, 102h
        mov dword [OptionsMenuItems+6CEh], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+71Ch], 4
        lea eax, [dword ebp-02CAh]
        push byte 30h
        mov ecx, 0Ah
        mov ebx, 102h
        mov edx, 10Eh
        mov dword [OptionsMenuItems+720h], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+76Eh], 4
        lea eax, [dword ebp-028Ah]
        push byte 39h
        mov ecx, 0Ah
        mov ebx, 0FEh
        mov edx, 11Ah
        mov dword [OptionsMenuItems+772h], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+7C0h], 4
        lea eax, [dword ebp-024Ah]
        push byte 15h
        mov ecx, 0Bh
        mov ebx, 5Eh
        mov edx, 0C4h
        mov dword [OptionsMenuItems+7C4h], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+812h], 4
        lea eax, [dword ebp-020Ah]
        push byte 18h
        mov ecx, 0Bh
        mov ebx, 5Bh
        mov edx, 0D1h
        mov dword [OptionsMenuItems+816h], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+864h], 4
        lea eax, [dword ebp-01CAh]
        push byte 1Ch
        mov ecx, 0Ch
        mov ebx, 57h
        mov edx, 0DCh
        mov dword [OptionsMenuItems+868h], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+8B6h], 4
        lea eax, [dword ebp-018Ah]
        push byte 1Fh
        mov ecx, 0Ch
        mov ebx, 55h
        mov edx, 0E8h
        mov dword [OptionsMenuItems+8BAh], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+0908h], 4
        lea eax, [dword ebp-014Ah]
        push byte 25h
        mov ecx, 0Ah
        mov ebx, 52h
        mov edx, 0F6h
        mov dword [OptionsMenuItems+090Ch], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+095Ah], 4
        lea eax, [dword ebp-010Ah]
        push byte 2Dh
        mov ecx, 0Ah
        mov ebx, 4Fh
        mov edx, 102h
        mov dword [OptionsMenuItems+095Eh], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+09ACh], 4
        lea eax, [dword ebp-0CAh]
        push byte 30h
        mov ecx, 0Ah
        mov ebx, 4Dh
        mov edx, 10Eh
        mov dword [OptionsMenuItems+09B0h], eax
        call SetRegionRect
        mov dword [OptionsMenuItems+09FEh], 4
        lea eax, [dword ebp-08Ah]
        push byte 39h
        mov ecx, 0Ah
        mov ebx, 49h
        mov edx, 11Ah
        mov dword [OptionsMenuItems+0A02h], eax
        call SetRegionRect
        push byte 0
        push byte 0Fh
        push byte 2Dh
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [byte ebp+05Ah], eax
        call SetDrawTarget
        add esp, byte 4
        push dword 0A0A0Ah
        call MakeColor
        add esp, byte 4
        push eax
        call ClearScreen
        add esp, byte 4
        call PresentScreen
        push byte 0
        push dword 1E0h
        push dword 280h
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [byte ebp+05Eh], eax
        call SetDrawTarget
        add esp, byte 4
        push str_TTL02
        push dword [byte ebp+06Eh]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        push str_BOTM3
        push dword [byte ebp+072h]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        push str_BAK0
        push dword [byte ebp+06Eh]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        push str_BAK1
        push dword [byte ebp+06Eh]
        call FindShape
        add esp, byte 8
        push eax
        xor ebx, ebx
        call BlitShape2
        add esp, byte 4
        jmp short .26
.24:
        movsx eax, bx
        imul eax, byte 52h
        cmp dword [dword eax+OptionsMenuItems+1Ah], byte 0
        je short .25
        push dword [dword eax+OptionsMenuItems+2Ah]
        push dword [dword eax+OptionsMenuItems+26h]
        push dword [dword eax+OptionsMenuItems+1Ah]
        call DrawArt
        add esp, byte 0Ch
.25:
        inc ebx
.26:
        cmp bx, byte 10h
        jl short .24
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        cmp word [byte ebp+07Eh], byte 0
        je short .27
        movsx eax, word [byte ebp+076h]
        movsx eax, word [byte ebp+eax*2+01Eh]
        inc eax
        push eax
        push str_D_OptionsScreen
        push dword 13Ah
        push dword 237h
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
.27:
        push byte 0
        push byte 32h
        push byte 6Eh
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push byte 32h
        push byte 6Eh
        mov ebx, eax
        mov edi, eax
        call CreateBitmap
        add esp, byte 0Ch
        push dword [byte ebp+05Eh]
        mov esi, eax
        call SetDrawTarget
        add esp, byte 4
        push dword 0FAh
        push dword 0BEh
        push dword [byte ebx+02Ch]
        call ConvertArtXY
        add esp, byte 0Ch
        push byte 46h
        mov eax, esi
        push dword 0BEh
        push dword [byte eax+02Ch]
        call ConvertArtXY
        mov ecx, 10Dh
        mov eax, dword [AudioOptions]
        mov edx, dword [byte ebp+072h]
        shl eax, 17h
        add esp, byte 0Ch
        shr eax, 19h
        call DrawOptionsSlider
        mov ecx, 55h
        mov eax, dword [AudioOptions]
        mov edx, dword [byte ebp+072h]
        shl eax, 0Fh
        mov ebx, esi
        shr eax, 19h
        call DrawOptionsSlider
        call PresentScreen
        mov eax, dword [byte ebp+05Eh]
        mov edx, 1
        mov eax, dword [byte eax+02Ch]
        call WipeScreen
        push dword [byte ebp+05Eh]
        call FreeBitmap
        add esp, byte 4
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        cmp word [byte ebp+07Eh], byte 0
        je near OptionsScreen_14BA
        push byte 0
        push byte 0Fh
        push byte 23h
        call CreateBitmap
        add esp, byte 0Ch
        mov ebx, eax
        mov dword [byte ebp+062h], eax
        call SetScreenTarget
        push dword 136h
        push dword 226h
        push dword [byte ebx+02Ch]
        call ConvertArtXY
        mov eax, dword [byte ebx+02Ch]
        mov word [byte eax+0Ch], 226h
        add esp, byte 0Ch
        mov eax, dword [byte ebx+02Ch]
        push byte 0FFFFFFFFh
        mov word [byte eax+0Eh], 136h
        call MakeColor
        add esp, byte 4
        movsx ebx, word [byte ebp+076h]
        call SetTextColor
        movsx eax, word [byte ebp+ebx*2+01Eh]
        inc eax
        push eax
        push str_D_OptionsScreen
        push dword 13Ah
        push dword 237h
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        call PresentScreen
        movsx eax, word [byte ebp+ebx*2+01Eh]
.28:
        mov dword [OptionsAnimChoice], eax
        jmp near OptionsScreen_14BA
OptionsScreen_F0A:
        call FadeInScreen
        mov dword [byte ebp+07Ah], 1
        mov dword [byte ebp+066h], 1Ah
        jmp near OptionsScreen_14BA
OptionsScreen_F22:
        mov eax, OptionsMenuItems+0A4h
        call ShowPopupScreen
        or byte [SfxOptions], 2
        and dword [AudioOptions], 0FFFE03FFh
        or dword [AudioOptions], 19000h
        and word [AudioOptions], 0FE03h
        or byte [MusicOptions], 4
        or word [AudioOptions], 190h
        or byte [MusicOptions], 10h
        or byte [AudioOptions], 2
        or byte [MusicOptions], 2
        cmp byte [FrontMusicOn], 0
        jne short .29
        or byte [MusicOptions], 8
        jmp short .30
.29:
        and byte [MusicOptions], 0F7h
.30:
        mov eax, dword [AudioOptions]
        shl eax, 17h
        shr eax, 19h
        cwde
        call SetMusicVolume
        mov eax, dword [AudioOptions]
        shl eax, 0Fh
        shr eax, 19h
        cwde
        call SetSfxVolume
        cmp byte [FrontMusicOn], 0
        je short .31
        and byte [MusicOptions], 0F7h
.31:
        call PauseMusic
        call rand_
        mov ebx, 2
        cdq
        idiv ebx
        mov ebx, edx
        lea edx, [byte ebp-0Ah]
        mov eax, ebx
        call ArenaFileName
        lea eax, [byte ebp-0Ah]
        call ChkMenuMusic
        lea eax, [byte ebx+01h]
        mov ebx, 2
        cdq
        idiv ebx
        mov eax, edx
        lea edx, [byte ebp-0Ah]
        call ArenaFileName
        lea eax, [byte ebp-0Ah]
        call ChkMenuMusic
        mov eax, ebx
        call SecondsToSamples
        call WaitSoundTime
        call RequestMusicStop
        mov ebx, 4
        jmp short .35
.32:
        cmp bx, byte 9
        jne short .33
        cmp byte [FrontMusicOn], 0
        je short .33
        movsx eax, bx
        imul eax, byte 52h
        mov edx, dword [OptionsLabelShapes]
        mov dword [dword eax+OptionsMenuItems+1Ah], edx
        mov edx, dword [OptionsButtonDownShapes]
        mov dword [dword eax+OptionsMenuItems+1Eh], edx
        mov edx, dword [OptionsButtonDownLit]
        jmp short .34
.33:
        movsx eax, bx
        imul eax, byte 52h
        mov edx, dword [OptionsButtonOff]
        mov dword [dword eax+OptionsMenuItems+1Ah], edx
        mov edx, dword [OptionsButtonOnShapes]
        mov dword [dword eax+OptionsMenuItems+1Eh], edx
        mov edx, dword [OptionsButtonLit]
.34:
        mov dword [dword eax+OptionsMenuItems+22h], edx
        inc ebx
.35:
        cmp bx, byte 0Ah
        jl short .32
        call SetScreenTarget
        mov ecx, 10Dh
        mov eax, dword [AudioOptions]
        mov edx, dword [byte ebp+072h]
        shl eax, 17h
        mov ebx, edi
        shr eax, 19h
        call DrawOptionsSlider
        mov ecx, 55h
        jmp near OptionsScreen_147B.50
OptionsScreen_10AA:
        mov eax, OptionsMenuItems+0F6h
        mov edx, dword [byte ebp+06Eh]
        call ShowPopupScreen
        mov eax, dword [byte ebp+072h]
        mov ebx, dword [byte ebp+06Ah]
        call DetailLevelScreen
        mov edx, ebx
        mov eax, ebx
        call DrawScreenBackground
        jmp near OptionsScreen_14BA
OptionsScreen_10D0:
        test byte [SfxOptions], 2
        je short .37
        mov eax, dword [OptionsLabelShapes]
        mov dword [OptionsMenuItems+162h], eax
        mov eax, dword [OptionsButtonDownShapes]
        mov dword [OptionsMenuItems+166h], eax
        mov eax, dword [OptionsButtonDownLit]
        and byte [SfxOptions], 0FDh
.36:
        mov dword [OptionsMenuItems+16Ah], eax
        jmp near OptionsScreen_14BA
.37:
        mov eax, dword [OptionsButtonOff]
        mov dword [OptionsMenuItems+162h], eax
        mov eax, dword [OptionsButtonOnShapes]
        mov dword [OptionsMenuItems+166h], eax
        mov eax, dword [OptionsButtonLit]
        or byte [SfxOptions], 2
        jmp short .36
OptionsScreen_1125:
        test byte [MusicOptions], 4
        je short .39
        mov eax, dword [OptionsLabelShapes]
        mov dword [OptionsMenuItems+1B4h], eax
        mov eax, dword [OptionsButtonDownShapes]
        mov dword [OptionsMenuItems+1B8h], eax
        mov eax, dword [OptionsButtonDownLit]
        and byte [MusicOptions], 0FBh
.38:
        mov dword [OptionsMenuItems+1BCh], eax
        jmp near OptionsScreen_14BA
.39:
        mov eax, dword [OptionsButtonOff]
        mov dword [OptionsMenuItems+1B4h], eax
        mov eax, dword [OptionsButtonOnShapes]
        mov dword [OptionsMenuItems+1B8h], eax
        mov eax, dword [OptionsButtonLit]
        or byte [MusicOptions], 4
        jmp short .38
OptionsScreen_117A:
        test byte [MusicOptions], 10h
        je short .41
        mov eax, dword [OptionsLabelShapes]
        mov dword [OptionsMenuItems+206h], eax
        mov eax, dword [OptionsButtonDownShapes]
        mov dword [OptionsMenuItems+20Ah], eax
        mov eax, dword [OptionsButtonDownLit]
        and byte [MusicOptions], 0EFh
.40:
        mov dword [OptionsMenuItems+20Eh], eax
        jmp near OptionsScreen_14BA
.41:
        mov eax, dword [OptionsButtonOff]
        mov dword [OptionsMenuItems+206h], eax
        mov eax, dword [OptionsButtonOnShapes]
        mov dword [OptionsMenuItems+20Ah], eax
        mov eax, dword [OptionsButtonLit]
        or byte [MusicOptions], 10h
        jmp short .40
OptionsScreen_11CF:
        test byte [AudioOptions], 2
        je short .42
        mov eax, dword [OptionsLabelShapes]
        mov dword [OptionsMenuItems+258h], eax
        mov eax, dword [OptionsButtonDownShapes]
        mov dword [OptionsMenuItems+25Ch], eax
        mov eax, dword [OptionsButtonDownLit]
        and byte [AudioOptions], 0FDh
        mov dword [OptionsMenuItems+260h], eax
        call WaitMusicEnd
        jmp near OptionsScreen_14BA
.42:
        mov eax, dword [OptionsButtonOff]
        mov dword [OptionsMenuItems+258h], eax
        mov eax, dword [OptionsButtonOnShapes]
        mov ebx, 2
        mov dword [OptionsMenuItems+25Ch], eax
        mov eax, dword [OptionsButtonLit]
        or byte [AudioOptions], 2
        mov dword [OptionsMenuItems+260h], eax
        call PauseMusic
        call rand_
        cdq
        idiv ebx
        mov ebx, edx
        lea edx, [byte ebp-0Ah]
        mov eax, ebx
        call ArenaFileName
        lea eax, [byte ebp-0Ah]
        call ChkMenuMusic
        lea eax, [byte ebx+01h]
        mov ebx, 2
        cdq
        idiv ebx
        mov eax, edx
        lea edx, [byte ebp-0Ah]
        call ArenaFileName
        lea eax, [byte ebp-0Ah]
        call ChkMenuMusic
        mov eax, ebx
        call SecondsToSamples
        call WaitSoundTime
        call RequestMusicStop
        jmp near OptionsScreen_14BA
OptionsScreen_1285:
        test byte [MusicOptions], 2
        je short .44
        mov eax, dword [OptionsLabelShapes]
        mov dword [OptionsMenuItems+2AAh], eax
        mov eax, dword [OptionsButtonDownShapes]
        mov dword [OptionsMenuItems+2AEh], eax
        mov eax, dword [OptionsButtonDownLit]
        and byte [MusicOptions], 0FDh
.43:
        mov dword [OptionsMenuItems+2B2h], eax
        jmp near OptionsScreen_14BA
.44:
        mov eax, dword [OptionsButtonOff]
        mov dword [OptionsMenuItems+2AAh], eax
        mov eax, dword [OptionsButtonOnShapes]
        mov dword [OptionsMenuItems+2AEh], eax
        mov eax, dword [OptionsButtonLit]
        or byte [MusicOptions], 2
        jmp short .43
OptionsScreen_12DA:
        cmp byte [FrontMusicOn], 0
        je short .45
        and byte [MusicOptions], 0F7h
        jmp near OptionsScreen_14BA
.45:
        test byte [MusicOptions], 8
        je short .47
        mov eax, dword [OptionsLabelShapes]
        mov dword [OptionsMenuItems+2FCh], eax
        mov eax, dword [OptionsButtonDownShapes]
        mov dword [OptionsMenuItems+300h], eax
        mov eax, dword [OptionsButtonDownLit]
        and byte [MusicOptions], 0F7h
.46:
        mov dword [OptionsMenuItems+304h], eax
        jmp near OptionsScreen_14BA
.47:
        push byte 0
        call MemFreeSize
        add esp, byte 4
        cmp eax, 600000h
        jle near OptionsScreen_14BA
        mov eax, dword [OptionsButtonOff]
        mov dword [OptionsMenuItems+2FCh], eax
        mov eax, dword [OptionsButtonOnShapes]
        mov dword [OptionsMenuItems+300h], eax
        mov eax, dword [OptionsButtonLit]
        or byte [MusicOptions], 8
        jmp short .46
OptionsScreen_1359:
        mov dword [byte ebp+07Ah], 1
        mov dword [byte ebp+066h], 22h
        jmp near OptionsScreen_14BA
OptionsScreen_136C:
        mov dword [byte ebp+07Ah], 1
        mov dword [byte ebp+066h], 23h
        jmp near OptionsScreen_14BA
OptionsScreen_137F:
        cmp word [byte ebp+07Eh], byte 0
        je near OptionsScreen_14BA
        movsx eax, word [byte ebp+076h]
        mov dword [byte ebp+07Ah], 1
        movsx eax, word [byte ebp+eax*2+01Eh]
        mov dword [byte ebp+066h], 24h
        jmp near OptionsScreen.28
OptionsScreen_13A6:
        cmp word [byte ebp+07Eh], byte 0
        je near OptionsScreen_14BA
        dec dword [byte ebp+076h]
        cmp word [byte ebp+076h], byte 0
        jge short .48
        mov eax, dword [byte ebp+07Eh]
        dec eax
        mov dword [byte ebp+076h], eax
.48:
        call SetScreenTarget
        mov eax, dword [byte ebp+062h]
        push dword [byte eax+02Ch]
        call BlitShape2
        add esp, byte 4
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        movsx eax, word [byte ebp+076h]
        movsx eax, word [byte ebp+eax*2+01Eh]
        inc eax
        push eax
        push str_D_OptionsScreen
        push dword 13Ah
        push dword 237h
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        jmp near OptionsScreen_147B.52
OptionsScreen_140D:
        cmp word [byte ebp+07Eh], byte 0
        je near OptionsScreen_14BA
        inc dword [byte ebp+076h]
        movsx eax, word [byte ebp+07Eh]
        movsx edx, word [byte ebp+076h]
        dec eax
        cmp edx, eax
        jle short OptionsScreen_13A6.48
        mov dword [byte ebp+076h], 0
        jmp short OptionsScreen_13A6.48
OptionsScreen_1431:
        or al, 3Ch
        jmp short OptionsScreen_1451
OptionsScreen_1435:
        or al, 78h
        jmp short OptionsScreen_1451
OptionsScreen_1439:
        or al, 0B4h
        jmp short OptionsScreen_1451
OptionsScreen_143D:
        or al, 0F0h
        jmp short OptionsScreen_1451
OptionsScreen_1441:
        or ax, 12Ch
        jmp short OptionsScreen_1451
OptionsScreen_1447:
        or ax, 168h
        jmp short OptionsScreen_1451
OptionsScreen_144D:
        or ax, 190h
OptionsScreen_1451:
        mov dword [AudioOptions], eax
        shl eax, 17h
        shr eax, 19h
        cwde
        mov ebx, edi
        call SetMusicVolume
        call SetScreenTarget
        mov eax, dword [AudioOptions]
        mov ecx, 10Dh
        shl eax, 17h
        mov edx, dword [byte ebp+072h]
        jmp short OptionsScreen_147B.51
OptionsScreen_147B:
        call SetScreenTarget
        and dword [AudioOptions], 0FFFE03FFh
.49:
        mov eax, dword [AudioOptions]
        shl eax, 0Fh
        shr eax, 19h
        cwde
        mov ecx, 55h
        call SetSfxVolume
.50:
        mov eax, dword [AudioOptions]
        mov edx, dword [byte ebp+072h]
        shl eax, 0Fh
        mov ebx, esi
.51:
        shr eax, 19h
        call DrawOptionsSlider
.52:
        call PresentScreen
OptionsScreen_14BA:
        cmp word [byte ebp+07Ah], byte 0
        jne near OptionsScreen_15A6.53
        push byte 2
        lea eax, [byte ebp+056h]
        mov ecx, OptionsSound
        mov ebx, 0FFFFFFFFh
        push eax
        mov edx, OptionsMenuItems
        mov eax, 20h
        call RunMenu
        cmp dword [byte ebp+056h], byte 1Fh
        ja short OptionsScreen_14BA
        mov eax, dword [AudioOptions]
        mov ebx, dword [byte ebp+056h]
        and ax, 0FE03h
        jmp dword [nosplit cs:ebx*4+OptionsScreenJumpTable]
OptionsScreen_14FE:
        call SetScreenTarget
        and dword [AudioOptions], 0FFFE03FFh
        or byte [SfxOptions], 3Ch
        jmp near OptionsScreen_147B.49
OptionsScreen_1519:
        call SetScreenTarget
        and dword [AudioOptions], 0FFFE03FFh
        or byte [SfxOptions], 78h
        jmp near OptionsScreen_147B.49
OptionsScreen_1534:
        call SetScreenTarget
        and dword [AudioOptions], 0FFFE03FFh
        or byte [SfxOptions], 0B4h
        jmp near OptionsScreen_147B.49
OptionsScreen_154F:
        call SetScreenTarget
        and dword [AudioOptions], 0FFFE03FFh
        or byte [SfxOptions], 0F0h
        jmp near OptionsScreen_147B.49
OptionsScreen_156A:
        call SetScreenTarget
        and dword [AudioOptions], 0FFFE03FFh
        or dword [AudioOptions], 12C00h
        jmp near OptionsScreen_147B.49
OptionsScreen_1588:
        call SetScreenTarget
        and dword [AudioOptions], 0FFFE03FFh
        or dword [AudioOptions], 16800h
        jmp near OptionsScreen_147B.49
OptionsScreen_15A6:
        call SetScreenTarget
        and dword [AudioOptions], 0FFFE03FFh
        or dword [AudioOptions], 19000h
        jmp near OptionsScreen_147B.49
.53:
        push dword [byte ebp+06Eh]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+072h]
        call FreeMemBlock
        add esp, byte 4
        cmp word [byte ebp+07Eh], byte 0
        je short .54
        push dword [byte ebp+062h]
        call FreeBitmap
        add esp, byte 4
.54:
        push edi
        call FreeBitmap
        add esp, byte 4
        push esi
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp+05Ah]
        xor ebx, ebx
        call FreeBitmap
        jmp short .56
.55:
        movsx eax, bx
        push dword [byte ebp+eax*4+04Eh]
        call FreeBitmap
        inc ebx
.56:
        add esp, byte 4
        cmp bx, byte 2
        jl short .55
        mov eax, dword [byte ebp+066h]
        lea esp, [dword ebp+082h]
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
SeasonSetupRowY:                                ; used by SeasonSetupScreen
        db 0D4h,00h,00h,00h,0E5h,00h,00h,00h,0F8h,00h,00h,00h,0Ah,01h,00h,00h
        db 01Dh,01h,00h,00h,02Fh,01h,00h,00h,053h,08Bh,05Ah,01h,083h,0E3h,07h,080h
        db 060h,01h,0F8h,09h,058h,01h,08Bh,05Ah,01h,083h,0E3h,08h,080h,060h,01h,0F7h
        db 09h,058h,01h,08Bh,05Ah,01h,083h,0E3h,010h,080h,060h,01h,0EFh,09h,058h,01h
        db 08Bh,05Ah,01h,083h,0E3h,020h,080h,060h,01h,0DFh,09h,058h,01h,08Bh,05Ah,01h
        db 081h,0E3h,0C0h,00h,00h,00h,080h,060h,01h,03Fh,09h,058h,01h,08Bh,05Ah,01h
        db 081h,0E3h,00h,01h,00h,00h,080h,060h,02h,0FEh,09h,058h,01h,08Bh,05Ah,01h
        db 081h,0E3h,00h,02h,00h,00h,080h,060h,02h,0FDh,09h,058h,01h,08Bh,05Ah,01h
        db 081h,0E3h,00h,04h,00h,00h,080h,060h,02h,0FBh,09h,058h,01h,08Bh,05Ah,01h
        db 081h,0E3h,00h,018h,00h,00h,080h,060h,02h,0E7h,09h,058h,01h,08Bh,052h,01h
        db 081h,0E2h,00h,020h,00h,00h,080h,060h,02h,0DFh,09h,050h,01h,05Bh
        ret
