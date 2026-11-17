; Link game set-up screen.
bits 32
%include "hockey.inc"
section s_A3280 progbits alloc exec nowrite align=1
extern AllocMemBlock, bcopy, BlankMenuItem, BlitArt, BlitShape, ClearLinkAbort, ClearLinkCounters, ClearScreen
extern ControlSetupFlags, ConvertArtKeepPos, ConvertArtXY, CreateBitmap, DrawArt, DrawLinkStatusText, DrawMatchBanner, DrawScreenBackground
extern DrawTeamLogoBanner, ExitScreen, FadeInScreen, FindShape, FreeBitmap, FreeMemBlock, FrontMusicOn, gameopts
extern GameRunning, GameSettings, GetLangText, GripDriverPtr, GripPortWord, InitLinkSettings, InitMenuItems, InitSlotTable
extern LinkAwayChoice, LinkButtonLetters, LinkButtonX, LinkButtonY, LinkGameActive, LinkHomeChoice, LinkLogoFile, LinkPlayerCount
extern LinkReceiveBlock, LinkScreensDone, LinkSendBlock, LinkSetupArt, LinkSetupBuffer, LinkSetupCount, LinkSetupCursorCol, LinkSetupCursorFlags
extern LinkSetupCursorRow, LinkSetupItemCount, LinkSetupItemFlags, LinkSetupItems, LinkSetupItemShape, LinkSetupItemType, LinkSetupItemX, LinkSetupLogos
extern LinkSetupMaxPlayers, LinkSetupNames, LinkSetupOrder, LinkSetupRow, LinkSetupScrollDown, LinkSetupScrollUp, LinkSetupSettings, LinkSetupShapeFile
extern LinkSetupShapeName, LinkSetupShapes, LinkSetupSlots, LinkSetupSlotY, LinkSetupSoundIndex, LinkSetupSoundOn, LinkSetupSounds, LinkSetupSoundTick
extern LinkSetupStatusX, LinkSetupTitleY, LinkSetupTop, LinkSetupValues, LinkShapeFile, LinkSideFlags, LinkSyncMenu, LinkSyncScreen
extern LinkTextFont, LoadDataFile, LoadFrontEndSfx, MeasureText, MenuOptionFlags, MusicEnabled, PlayArenaAnnouncement, PlaySfx
extern PresentScreen, ResetLinkSetup, ResetStreamAudio, RunMenu, ScreenFrameItem, ScreenTitleItem, SecondsToSamples, ServiceIdle
extern SetDrawTarget, SetNormalText, SetScreenTarget, ShowPopupScreen, ShowScreen, sprintf_, StopAllSfx, str_00005
extern str_00012, str_00022, str_BANL, str_BANR, str_BN02d, str_BUTD, str_CPU, str_D_RunLinkGameScreens
extern str_EL01, str_EL02, str_EL02d, str_ELGR, str_ICN1, str_ICN2, str_ICN3, str_ICN4
extern str_ICN5, str_LOG6, str_LOGD, str_LOGO4, str_PICKS, str_REGS, str_S_RunLinkGameScreens, str_SL01
extern str_SL02, str_TITL6, str_WINS, strcpy_, tickcount, UserLogScreen, ViewScreenHeight, ViewScreenWidth
extern WaitSoundTime, WipeScreen, ZeroMem
global LinkGameSetup, LinkGameSetup_8CA, LinkGameSetup_8CB, LinkSetupCursorJumpTable, LinkSetupCursor, LinkSetupCursor_29, LinkSetupCursor_CC, LinkSetupCursor_166
global LinkSetupCursor_1EE, LinkSetupCursor_2BB, DrawLinkSetupItem, DrawLinkSetupStatus, LinkSetupScreen, LinkSetupSound, LinkControlSetupJumpTable, LinkControlLocalJumpTable
global LinkControlRestoreJumpTable, RunLinkGameScreens, RunLinkGameScreens_30, RunLinkGameScreens_112, RunLinkGameScreens_1971
;-----------------------------------------------------------------------------
; LinkGameSetup                                   A3280  97 PC, low confidence
; Runs the setup screens of a link game
;-----------------------------------------------------------------------------
LinkGameSetup:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 4Ch, 0
        mov esi, eax
        push byte 0
        push dword [ViewScreenHeight]
        push dword [ViewScreenWidth]
        call CreateBitmap
        add esp, byte 0Ch
        mov edi, eax
        mov dword [byte ebp-030h], eax
        call SetScreenTarget
        push byte 0
        push byte 0
        mov ebx, esi
        push dword [byte edi+02Ch]
        shl ebx, 2
        call ConvertArtXY
        add esp, byte 0Ch
        mov eax, dword [dword ebx+LinkSetupArt]
        push dword [byte eax+02Ch]
        call BlitShape
        add esp, byte 4
        push edi
        call SetDrawTarget
        add esp, byte 4
        mov eax, dword [dword ebx+LinkSetupArt]
        push dword [byte eax+02Ch]
        call BlitShape
        add esp, byte 4
        call PresentScreen
        push str_LOG6
        push dword [LinkLogoFile]
        call FindShape
        movsx eax, word [byte eax+06h]
        movsx edi, word [LinkSetupTitleY]
        sar eax, 1
        add esp, byte 8
        add edi, eax
        movzx eax, byte [dword esi+LinkButtonLetters]
        push eax
        push str_BUTD
        lea eax, [byte ebp-04Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-04Ch]
        push eax
        push dword [LinkShapeFile]
        call FindShape
        mov edx, esi
        mov ecx, dword [LinkSetupShapeFile]
        add edx, edx
        movsx eax, word [byte eax+06h]
        add edx, ecx
        sar eax, 1
        movsx edx, word [edx]
        lea ecx, [edx+eax]
        mov eax, edi
        sub eax, ecx
        mov edi, 5
        cdq
        idiv edi
        mov dword [byte ebp-038h], eax
        add eax, ecx
        mov edx, dword [dword ebx+LinkSetupArt]
        mov dword [byte ebp-02Ch], eax
        mov eax, dword [byte edx+02Ch]
        movsx ecx, word [byte eax+0Ch]
        mov dword [byte ebp-018h], ecx
        mov edi, dword [byte ebp-018h]
        movsx ecx, word [byte eax+04h]
        add edi, ecx
        add esp, byte 8
        mov dword [byte ebp-024h], edi
        movsx ecx, word [byte eax+0Eh]
        movsx eax, word [byte eax+06h]
        mov dword [byte ebp-01Ch], ecx
        add ecx, eax
        push edx
        mov dword [byte ebp-020h], ecx
        call FreeBitmap
        add esp, byte 4
        push dword [dword ebx+LinkSetupNames]
        call FreeBitmap
        add esp, byte 4
        push dword [dword ebx+LinkSetupLogos]
        call FreeBitmap
        add esp, byte 4
        mov eax, dword [tickcount]
        add eax, byte 3
        mov dword [byte ebp-08h], 2
        mov dword [byte ebp-03Ch], eax
.1:
        push dword [byte ebp-08h]
        push str_LOGD
        lea eax, [byte ebp-04Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-04Ch]
        push eax
        mov ebx, dword [byte ebp-08h]
        push dword [LinkLogoFile]
        add ebx, ebx
        call FindShape
        movsx edi, word [dword ebx+LinkButtonX]
        movsx edx, word [byte eax+04h]
        add esp, byte 8
        lea ecx, [edi+edx]
        mov dword [byte ebp-014h], eax
        mov dword [byte ebp-010h], ecx
        cmp dword [byte ebp-08h], byte 6
        jge short .2
        mov edx, dword [byte ebp-038h]
        movsx eax, word [byte eax+06h]
        add dword [byte ebp-02Ch], edx
        sar eax, 1
        mov ebx, dword [byte ebp-02Ch]
        sub ebx, eax
        jmp short .3
.2:
        movsx ebx, word [dword ebx+LinkButtonY]
.3:
        mov dword [byte ebp-028h], ebx
        mov eax, dword [byte ebp-014h]
        movsx eax, word [byte eax+06h]
        lea edx, [ebx+eax]
        mov dword [byte ebp-0Ch], edx
        cmp edi, dword [byte ebp-018h]
        jle short .4
        mov edi, dword [byte ebp-018h]
.4:
        mov eax, dword [byte ebp-024h]
        cmp eax, dword [byte ebp-010h]
        jle short .5
        mov dword [byte ebp-010h], eax
.5:
        cmp ebx, dword [byte ebp-01Ch]
        jle short .6
        mov ebx, dword [byte ebp-01Ch]
.6:
        mov eax, dword [byte ebp-020h]
        cmp eax, dword [byte ebp-0Ch]
        jle short .7
        mov dword [byte ebp-0Ch], eax
.7:
        mov eax, dword [byte ebp-0Ch]
        sub eax, ebx
        push byte 0
        inc eax
        push eax
        mov eax, dword [byte ebp-010h]
        sub eax, edi
        inc eax
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [byte ebp-044h], eax
        call SetDrawTarget
        mov eax, ebx
        add esp, byte 4
        neg eax
        push eax
        mov eax, edi
        neg eax
        push eax
        mov eax, dword [byte ebp-030h]
        push dword [byte eax+02Ch]
        call BlitArt
        mov eax, dword [byte ebp-028h]
        add esp, byte 0Ch
        sub eax, ebx
        push eax
        mov eax, dword [byte ebp-08h]
        movsx eax, word [nosplit eax*2+LinkButtonX]
        sub eax, edi
        push eax
        push dword [byte ebp-014h]
        call DrawArt
        add esp, byte 0Ch
        call SetScreenTarget
        push ebx
        mov eax, dword [byte ebp-044h]
        push edi
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        push dword [byte ebp-044h]
        mov dword [byte ebp-018h], edi
        call FreeBitmap
        mov eax, dword [byte ebp-010h]
        mov dword [byte ebp-01Ch], ebx
        mov dword [byte ebp-024h], eax
        mov eax, dword [byte ebp-0Ch]
        add esp, byte 4
        mov dword [byte ebp-020h], eax
.8:
        mov eax, dword [tickcount]
        cmp eax, dword [byte ebp-03Ch]
        jge short .9
        call ServiceIdle
        jmp short .8
.9:
        inc dword [byte ebp-08h]
        cmp dword [byte ebp-08h], byte 9
        jl near .1
        mov ebx, dword [byte ebp-01Ch]
        mov edx, dword [byte ebp-018h]
        mov eax, dword [byte ebp-014h]
        mov ecx, esi
        call UserLogScreen
        mov eax, 302h
        mov dword [byte ebp-08h], 7
        call PlaySfx
.10:
        push dword [byte ebp-08h]
        push str_LOGD
        lea eax, [byte ebp-04Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-04Ch]
        push eax
        mov ebx, dword [byte ebp-08h]
        push dword [LinkLogoFile]
        add ebx, ebx
        call FindShape
        movsx edi, word [dword ebx+LinkButtonX]
        movsx edx, word [byte eax+04h]
        add esp, byte 8
        lea ecx, [edi+edx]
        mov dword [byte ebp-014h], eax
        mov dword [byte ebp-010h], ecx
        cmp dword [byte ebp-08h], byte 6
        jge short .11
        mov edx, dword [byte ebp-038h]
        movsx eax, word [byte eax+06h]
        sub dword [byte ebp-02Ch], edx
        sar eax, 1
        mov ebx, dword [byte ebp-02Ch]
        sub ebx, eax
        jmp short .12
.11:
        movsx ebx, word [dword ebx+LinkButtonY]
.12:
        mov dword [byte ebp-028h], ebx
        mov eax, dword [byte ebp-014h]
        movsx eax, word [byte eax+06h]
        lea edx, [ebx+eax]
        mov dword [byte ebp-0Ch], edx
        cmp edi, dword [byte ebp-018h]
        jle short .13
        mov edi, dword [byte ebp-018h]
.13:
        mov eax, dword [byte ebp-024h]
        cmp eax, dword [byte ebp-010h]
        jle short .14
        mov dword [byte ebp-010h], eax
.14:
        cmp ebx, dword [byte ebp-01Ch]
        jle short .15
        mov ebx, dword [byte ebp-01Ch]
.15:
        mov eax, dword [byte ebp-020h]
        cmp eax, dword [byte ebp-0Ch]
        jle short .16
        mov dword [byte ebp-0Ch], eax
.16:
        mov eax, dword [byte ebp-0Ch]
        sub eax, ebx
        push byte 0
        inc eax
        push eax
        mov eax, dword [byte ebp-010h]
        sub eax, edi
        inc eax
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [byte ebp-044h], eax
        call SetDrawTarget
        mov eax, ebx
        add esp, byte 4
        neg eax
        push eax
        mov eax, edi
        neg eax
        push eax
        mov eax, dword [byte ebp-030h]
        push dword [byte eax+02Ch]
        call BlitArt
        mov eax, dword [byte ebp-028h]
        add esp, byte 0Ch
        sub eax, ebx
        push eax
        mov eax, dword [byte ebp-08h]
        movsx eax, word [nosplit eax*2+LinkButtonX]
        sub eax, edi
        push eax
        push dword [byte ebp-014h]
        call DrawArt
        add esp, byte 0Ch
        call SetScreenTarget
        push ebx
        mov eax, dword [byte ebp-044h]
        push edi
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        push dword [byte ebp-044h]
        mov dword [byte ebp-018h], edi
        call FreeBitmap
        mov eax, dword [byte ebp-010h]
        mov dword [byte ebp-01Ch], ebx
        mov dword [byte ebp-024h], eax
        mov eax, dword [byte ebp-0Ch]
        add esp, byte 4
        mov dword [byte ebp-020h], eax
.17:
        mov eax, dword [tickcount]
        cmp eax, dword [byte ebp-03Ch]
        jge short .18
        call ServiceIdle
        jmp short .17
.18:
        dec dword [byte ebp-08h]
        cmp dword [byte ebp-08h], byte 1
        jg near .10
        push dword [byte ebp-030h]
        call SetDrawTarget
        add esp, byte 4
        movzx eax, byte [dword esi+LinkButtonLetters]
        push eax
        push str_BUTD
        lea eax, [byte ebp-04Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-04Ch]
        push eax
        push dword [LinkShapeFile]
        call FindShape
        add esp, byte 8
        mov dword [byte ebp-034h], eax
        cmp dword [LinkGameActive], byte 0
        je short .20
        call ClearLinkAbort
        test eax, eax
        je short .19
        mov eax, dword [LinkPlayerCount]
        sar eax, 1
        cmp esi, eax
        jl short .20
.19:
        call ClearLinkAbort
        test eax, eax
        jne short .21
        mov eax, dword [LinkPlayerCount]
        sar eax, 1
        cmp esi, eax
        jl short .21
.20:
        imul edx, esi, byte 21h
        mov eax, dword [gameopts]
        add eax, byte 5
        add eax, edx
        inc eax
        inc eax
        jmp short .22
.21:
        mov eax, 0F7h
        call GetLangText
.22:
        push eax
        call MeasureText
        add esp, byte 4
        mov edi, eax
        mov eax, dword [LinkTextFont]
        push byte 20h
        inc eax
        inc eax
        push eax
        mov ebx, esi
        push edi
        shl ebx, 2
        call CreateBitmap
        mov dword [dword ebx+LinkSetupArt], eax
        mov eax, edi
        mov edx, 13Ch
        sar eax, 1
        sub edx, eax
        mov eax, dword [dword ebx+LinkSetupArt]
        mov eax, dword [byte eax+02Ch]
        mov word [byte eax+0Ch], dx
        lea eax, [esi+esi]
        mov dword [byte ebp-040h], eax
        mov eax, dword [LinkSetupShapeFile]
        add eax, dword [byte ebp-040h]
        mov dword [byte ebp-04h], edx
        movsx edx, word [eax]
        mov eax, dword [byte ebp-034h]
        movsx eax, word [byte eax+06h]
        sar eax, 1
        add eax, edx
        mov edx, dword [LinkTextFont]
        sar edx, 1
        sub eax, edx
        mov edx, eax
        mov eax, dword [dword ebx+LinkSetupArt]
        mov eax, dword [byte eax+02Ch]
        mov word [byte eax+0Eh], dx
        add esp, byte 0Ch
        mov eax, dword [dword ebx+LinkSetupArt]
        push dword [byte eax+02Ch]
        call ConvertArtKeepPos
        add esp, byte 4
        mov eax, dword [LinkTextFont]
        push byte 20h
        inc eax
        inc eax
        push eax
        push edi
        call CreateBitmap
        mov dword [dword ebx+LinkSetupNames], eax
        mov eax, dword [byte eax+02Ch]
        mov edx, dword [byte ebp-04h]
        mov word [byte eax+0Ch], dx
        mov eax, dword [LinkSetupShapeFile]
        add eax, dword [byte ebp-040h]
        movsx edx, word [eax]
        mov eax, dword [byte ebp-034h]
        movsx eax, word [byte eax+06h]
        sar eax, 1
        add edx, eax
        mov eax, dword [LinkTextFont]
        sar eax, 1
        sub edx, eax
        mov eax, dword [dword ebx+LinkSetupNames]
        mov eax, dword [byte eax+02Ch]
        mov word [byte eax+0Eh], dx
        add esp, byte 0Ch
        mov eax, dword [dword ebx+LinkSetupNames]
        push dword [byte eax+02Ch]
        call ConvertArtKeepPos
        add esp, byte 4
        mov eax, dword [LinkTextFont]
        push byte 20h
        inc eax
        inc eax
        push eax
        push edi
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [dword ebx+LinkSetupLogos], eax
        mov eax, dword [byte eax+02Ch]
        mov edx, dword [byte ebp-04h]
        mov word [byte eax+0Ch], dx
        mov eax, dword [LinkSetupShapeFile]
        add eax, dword [byte ebp-040h]
        movsx edx, word [eax]
        mov eax, dword [byte ebp-034h]
        movsx eax, word [byte eax+06h]
        sar eax, 1
        add edx, eax
        mov eax, dword [LinkTextFont]
        sar eax, 1
        sub edx, eax
        mov eax, dword [dword ebx+LinkSetupLogos]
        mov eax, dword [byte eax+02Ch]
        mov word [byte eax+0Eh], dx
        mov eax, dword [dword ebx+LinkSetupLogos]
        push dword [byte eax+02Ch]
        call ConvertArtKeepPos
        add esp, byte 4
        push dword [dword ebx+LinkSetupNames]
        call SetDrawTarget
        add esp, byte 4
        cmp dword [LinkGameActive], byte 0
        je short .24
        call ClearLinkAbort
        test eax, eax
        je short .23
        mov eax, dword [LinkPlayerCount]
        sar eax, 1
        cmp esi, eax
        jl short .24
.23:
        call ClearLinkAbort
        test eax, eax
        jne short .25
        mov eax, dword [LinkPlayerCount]
        sar eax, 1
        cmp esi, eax
        jl short .25
.24:
        imul edx, esi, byte 21h
        mov eax, dword [gameopts]
        add eax, byte 5
        mov ebx, 1
        add eax, edx
        xor ecx, ecx
        inc eax
        inc eax
        xor edx, edx
        jmp short .26
.25:
        mov eax, 0F7h
        mov ebx, 1
        xor ecx, ecx
        xor edx, edx
        call GetLangText
.26:
        call DrawLinkStatusText
        push dword [nosplit esi*4+LinkSetupLogos]
        call SetDrawTarget
        add esp, byte 4
        cmp dword [LinkGameActive], byte 0
        je short .28
        call ClearLinkAbort
        test eax, eax
        je short .27
        mov eax, dword [LinkPlayerCount]
        sar eax, 1
        cmp esi, eax
        jl short .28
.27:
        call ClearLinkAbort
        test eax, eax
        jne short .29
        mov eax, dword [LinkPlayerCount]
        sar eax, 1
        cmp esi, eax
        jl short .29
.28:
        imul edx, esi, byte 21h
        mov eax, dword [gameopts]
        add eax, byte 5
        mov ecx, 1
        add eax, edx
        mov ebx, ecx
        inc eax
        inc eax
        xor edx, edx
        jmp short .30
.29:
        mov eax, 0F7h
        mov ecx, 1
        xor edx, edx
        mov ebx, ecx
        call GetLangText
.30:
        call DrawLinkStatusText
        lea edi, [esi+esi*2]
        inc edi
        imul ebx, edi, byte 52h
        mov ecx, dword [LinkSetupItems]
        mov eax, esi
        shl eax, 2
        add ecx, ebx
        mov edx, dword [dword eax+LinkSetupNames]
        mov dword [byte ebp-044h], ecx
        mov ecx, dword [byte edx+02Ch]
        mov edx, dword [byte ebp-044h]
        mov dword [byte edx+01Ah], ecx
        mov ecx, dword [LinkSetupItems]
        add ecx, ebx
        mov edx, dword [dword eax+LinkSetupLogos]
        mov dword [byte ebp-044h], ecx
        mov ecx, dword [byte edx+02Ch]
        mov edx, dword [byte ebp-044h]
        mov dword [byte edx+01Eh], ecx
        mov edx, dword [LinkSetupItems]
        add edx, ebx
        mov dword [byte ebp-044h], edx
        mov edx, dword [byte edx+01Ah]
        mov ecx, dword [byte ebp-044h]
        movsx edx, word [byte edx+0Ch]
        mov dword [byte ecx+026h], edx
        mov edx, dword [LinkSetupItems]
        add edx, ebx
        mov dword [byte ebp-044h], edx
        mov edx, dword [byte edx+01Ah]
        mov ecx, dword [byte ebp-044h]
        movsx edx, word [byte edx+0Eh]
        mov dword [byte ecx+02Ah], edx
        mov ecx, dword [LinkSetupSlots]
        shl edi, 6
        add ecx, edi
        mov edx, dword [LinkSetupItems]
        mov dword [byte ebp-044h], ecx
        mov ecx, dword [byte edx+ebx+026h]
        mov edx, dword [byte ebp-044h]
        mov dword [edx], ecx
        mov ecx, dword [LinkSetupSlots]
        add ecx, edi
        mov edx, dword [LinkSetupItems]
        mov dword [byte ebp-044h], ecx
        mov ecx, dword [byte edx+ebx+02Ah]
        mov edx, dword [byte ebp-044h]
        mov dword [byte edx+04h], ecx
        mov edx, dword [LinkSetupItems]
        mov edx, dword [byte edx+ebx+01Ah]
        movsx edx, word [byte edx+04h]
        mov dword [byte ebp-044h], edx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [edx+edi]
        add ecx, dword [byte ebp-044h]
        mov dword [byte edx+edi+08h], ecx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [byte edx+edi+04h]
        mov dword [byte edx+edi+0Ch], ecx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [byte edx+edi+08h]
        mov dword [byte edx+edi+010h], ecx
        mov edx, dword [LinkSetupItems]
        mov edx, dword [byte edx+ebx+01Ah]
        movsx ebx, word [byte edx+06h]
        mov edx, dword [LinkSetupSlots]
        add ebx, dword [byte edx+edi+0Ch]
        mov dword [byte edx+edi+014h], ebx
        mov edx, dword [LinkSetupSlots]
        mov ebx, dword [edx+edi]
        mov dword [byte edx+edi+018h], ebx
        mov edx, dword [LinkSetupSlots]
        add edi, edx
        mov edx, dword [byte edi+014h]
        mov dword [byte edi+01Ch], edx
        mov eax, dword [dword eax+LinkSetupNames]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte ebp-014h], eax
        movsx edi, word [byte eax+0Ch]
        movsx eax, word [byte eax+04h]
        lea edx, [edi+eax]
        mov eax, esi
        mov dword [byte ebp-010h], edx
        mov edx, dword [LinkSetupShapeFile]
        movsx eax, word [edx+eax*2]
        mov edx, dword [byte ebp-034h]
        movsx edx, word [byte edx+06h]
        mov ebx, dword [LinkTextFont]
        sar edx, 1
        sar ebx, 1
        add eax, edx
        sub eax, ebx
        mov ebx, eax
        mov dword [byte ebp-028h], eax
        mov eax, dword [byte ebp-014h]
        mov edx, ebx
        movsx eax, word [byte eax+06h]
        add edx, eax
        mov dword [byte ebp-0Ch], edx
        cmp edi, dword [byte ebp-018h]
        jle short .31
        mov edi, dword [byte ebp-018h]
.31:
        mov eax, dword [byte ebp-024h]
        cmp eax, dword [byte ebp-010h]
        jle short .32
        mov dword [byte ebp-010h], eax
.32:
        cmp ebx, dword [byte ebp-01Ch]
        jle short .33
        mov ebx, dword [byte ebp-01Ch]
.33:
        mov eax, dword [byte ebp-020h]
        cmp eax, dword [byte ebp-0Ch]
        jle short .34
        mov dword [byte ebp-0Ch], eax
.34:
        mov eax, dword [byte ebp-0Ch]
        sub eax, ebx
        push byte 0
        inc eax
        push eax
        mov eax, dword [byte ebp-010h]
        sub eax, edi
        inc eax
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov esi, eax
        call SetDrawTarget
        mov eax, ebx
        add esp, byte 4
        neg eax
        push eax
        mov eax, edi
        neg eax
        push eax
        mov eax, dword [byte ebp-030h]
        push dword [byte eax+02Ch]
        call BlitArt
        mov eax, dword [byte ebp-028h]
        add esp, byte 0Ch
        sub eax, ebx
        push eax
        mov eax, dword [byte ebp-014h]
        movsx eax, word [byte eax+0Ch]
        sub eax, edi
        push eax
        push dword [byte ebp-014h]
        call DrawArt
        add esp, byte 0Ch
        call SetScreenTarget
        push ebx
        push edi
        push dword [byte esi+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        push esi
        call FreeBitmap
        add esp, byte 4
.35:
        mov eax, dword [tickcount]
        cmp eax, dword [byte ebp-03Ch]
        jge short .36
        call ServiceIdle
        jmp short .35
.36:
        push dword [byte ebp-030h]
        call FreeBitmap
        add esp, byte 4
LinkGameSetup_8CA:
        leave
LinkGameSetup_8CB:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
LinkSetupCursorJumpTable:                       ; jump table for the switch cases of LinkSetupCursor
        dd LinkSetupCursor_29
        dd LinkSetupCursor_2BB
        dd LinkSetupCursor_CC
        dd LinkSetupCursor_166
        dd LinkSetupCursor_166
        dd LinkSetupCursor_1EE
;-----------------------------------------------------------------------------
; LinkSetupCursor                                 A3B69  97 PC, low confidence
; Moves the cursor of the link setup screen
;-----------------------------------------------------------------------------
LinkSetupCursor:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        movsx edx, ax
        imul edx, byte 7
        mov dl, byte [dword edx+LinkSetupItemFlags]
        mov al, dl
        and al, 7
        cmp al, 5
        ja near LinkSetupCursor_2BB
        movzx eax, al
        jmp dword [nosplit cs:eax*4+LinkSetupCursorJumpTable]
LinkSetupCursor_29:
        test byte [LinkSetupCursorFlags], 1
        jne short .2
        and dl, 0F8h
.1:
        or byte [LinkSetupCursorFlags], 1
        or dl, 2
        jmp near LinkSetupCursor_2BB
.2:
        test byte [LinkSetupCursorFlags], 2
        jne short .4
.3:
        test byte [ControlSetupFlags], 1
        setne al
        movzx eax, al
        lea ebx, [byte eax+03h]
        mov al, dl
        and al, 0F8h
        movzx eax, al
        or eax, ebx
        or byte [LinkSetupCursorFlags], 2
        mov dl, al
        jmp near LinkSetupCursor_2BB
.4:
        mov eax, 3
.5:
        cmp eax, dword [LinkSetupMaxPlayers]
        jg short .6
        mov ebx, 1
        lea ecx, [byte eax-01h]
        shl ebx, cl
        test dword [LinkSetupCursorFlags], ebx
        je short .6
        inc eax
        jmp short .5
.6:
        cmp eax, dword [LinkSetupMaxPlayers]
        jg near LinkSetupCursor_2BB
        and dl, 0F8h
.7:
        dec eax
        or dl, 5
        mov cl, al
        mov dh, byte [nosplit eax*2+LinkSetupCursorCol]
        mov eax, 1
        shl dh, 3
        shl eax, cl
        and dl, 87h
        or dword [LinkSetupCursorFlags], eax
        or dl, dh
        jmp near LinkSetupCursor_2BB
LinkSetupCursor_CC:
        test byte [LinkSetupCursorFlags], 2
        jne short .8
        test byte [ControlSetupFlags], 1
        setne al
        movzx eax, al
        lea ecx, [byte eax+03h]
        mov al, dl
        and al, 0F8h
        movzx eax, al
        or eax, ecx
        or byte [LinkSetupCursorFlags], 2
        mov dl, al
        jmp short .11
.8:
        mov eax, 3
.9:
        cmp eax, dword [LinkSetupMaxPlayers]
        jg short .10
        mov esi, 1
        lea ecx, [byte eax-01h]
        shl esi, cl
        test dword [LinkSetupCursorFlags], esi
        je short .10
        inc eax
        jmp short .9
.10:
        cmp eax, dword [LinkSetupMaxPlayers]
        jg short .11
        and dl, 0F8h
        mov cl, byte [nosplit eax*2+LinkSetupCursorRow]
        or dl, 5
        shl cl, 3
        and dl, 87h
        dec eax
        or dl, cl
        mov cl, al
        mov eax, 1
        shl eax, cl
        or dword [LinkSetupCursorFlags], eax
.11:
        movsx eax, bx
        imul eax, byte 7
        cmp dl, byte [dword eax+LinkSetupItemFlags]
        je near LinkSetupCursor_2BB
        and byte [LinkSetupCursorFlags], 0FEh
        jmp near LinkSetupCursor_2BB
LinkSetupCursor_166:
        mov eax, 3
.12:
        cmp eax, dword [LinkSetupMaxPlayers]
        jg short .13
        mov esi, 1
        lea ecx, [byte eax-01h]
        shl esi, cl
        test dword [LinkSetupCursorFlags], esi
        je short .13
        inc eax
        jmp short .12
.13:
        mov dh, dl
        and dh, 0F8h
        cmp eax, dword [LinkSetupMaxPlayers]
        jg short .14
        mov dl, dh
        mov cl, byte [nosplit eax*2+LinkSetupCursorRow]
        or dl, 5
        shl cl, 3
        and dl, 87h
        dec eax
        or dl, cl
        mov cl, al
        mov eax, 1
        shl eax, cl
        or dword [LinkSetupCursorFlags], eax
        jmp short .15
.14:
        test byte [LinkSetupCursorFlags], 1
        jne short .15
        mov dl, dh
        or byte [LinkSetupCursorFlags], 1
        or dl, 2
.15:
        movsx eax, bx
        imul eax, byte 7
        cmp dl, byte [dword eax+LinkSetupItemFlags]
        je near LinkSetupCursor_2BB
        and byte [LinkSetupCursorFlags], 0FDh
        jmp near LinkSetupCursor_2BB
LinkSetupCursor_1EE:
        xor ebx, ebx
.16:
        mov al, dl
        and al, 78h
        movzx eax, al
        movsx ecx, word [nosplit ebx*2+LinkSetupValues]
        sar eax, 3
        cmp ecx, eax
        je short .17
        inc ebx
        jmp short .16
.17:
        lea eax, [byte ebx+04h]
        mov esi, 1
        lea ecx, [byte ebx+02h]
        shl esi, cl
        mov ecx, esi
        not ecx
        and dword [LinkSetupCursorFlags], ecx
.18:
        cmp eax, dword [LinkSetupMaxPlayers]
        jg short .19
        mov esi, 1
        lea ecx, [byte eax-01h]
        shl esi, cl
        test dword [LinkSetupCursorFlags], esi
        je short .19
        inc eax
        jmp short .18
.19:
        mov dh, dl
        and dh, 0F8h
        cmp eax, dword [LinkSetupMaxPlayers]
        jg short .20
        mov dl, dh
        jmp near LinkSetupCursor_29.7
.20:
        test byte [LinkSetupCursorFlags], 1
        jne short .21
        mov dl, dh
        jmp near LinkSetupCursor_29.1
.21:
        test byte [LinkSetupCursorFlags], 2
        je near LinkSetupCursor_29.3
        mov eax, 3
.22:
        lea ecx, [byte ebx+03h]
        cmp eax, ecx
        jg short .23
        mov esi, 1
        lea ecx, [byte eax-01h]
        shl esi, cl
        test dword [LinkSetupCursorFlags], esi
        je short .23
        inc eax
        jmp short .22
.23:
        add ebx, byte 3
        cmp eax, ebx
        jg short LinkSetupCursor_2BB
        and dl, 0F8h
        dec eax
        or dl, 5
        mov cl, al
        mov dh, byte [nosplit eax*2+LinkSetupCursorCol]
        mov eax, 1
        shl dh, 3
        shl eax, cl
        and dl, 87h
        or dword [LinkSetupCursorFlags], eax
        or dl, dh
LinkSetupCursor_2BB:
        mov al, dl
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawLinkSetupItem                               A3E2B  97 PC, low confidence
; Draws a link setup item
;-----------------------------------------------------------------------------
DrawLinkSetupItem:
        push ebx
        push ecx
        push edx
        xor eax, eax
.1:
        cmp eax, dword [LinkPlayerCount]
        jge short .3
        imul edx, eax, byte 7
        test byte [dword edx+LinkSetupItemFlags], 7
        setne dl
        movzx edx, dl
        test edx, edx
        je short .2
        imul edx, eax, byte 7
        test byte [dword edx+LinkSetupItemFlags], 80h
        jne short .2
        mov eax, dword [LinkPlayerCount]
.2:
        inc eax
        jmp short .1
.3:
        jne short .4
        push str_ELGR
        push dword [LinkLogoFile]
        call FindShape
        mov edx, eax
        imul eax, dword [LinkPlayerCount], dword 0F6h
        mov ebx, dword [LinkSetupItems]
        mov dword [byte ebx+eax+01Ah], edx
        imul eax, dword [LinkPlayerCount], dword 0F6h
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+01Eh], 0
        imul eax, dword [LinkPlayerCount], dword 0F6h
        mov edx, dword [LinkSetupItems]
        add esp, byte 8
        mov word [byte edx+eax+018h], 3
        jmp short .5
.4:
        push str_EL01
        push dword [LinkLogoFile]
        call FindShape
        mov edx, eax
        imul eax, dword [LinkPlayerCount], dword 0F6h
        add esp, byte 8
        mov ebx, dword [LinkSetupItems]
        push str_EL02
        mov dword [byte ebx+eax+01Ah], edx
        push dword [LinkLogoFile]
        call FindShape
        mov edx, eax
        imul eax, dword [LinkPlayerCount], dword 0F6h
        mov ebx, dword [LinkSetupItems]
        mov dword [byte ebx+eax+01Eh], edx
        imul eax, dword [LinkPlayerCount], dword 0F6h
        mov edx, dword [LinkSetupItems]
        add esp, byte 8
        mov word [byte edx+eax+018h], 0
.5:
        imul eax, dword [LinkPlayerCount], dword 0F6h
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+0Ch], 1
        xor eax, eax
.6:
        cmp eax, dword [LinkPlayerCount]
        jge short .8
        imul edx, eax, byte 7
        test byte [dword edx+LinkSetupItemFlags], 7
        setne dl
        movzx edx, dl
        test edx, edx
        je short .7
        imul edx, eax, byte 7
        test byte [dword edx+LinkSetupItemFlags], 80h
        setne dl
        movzx edx, dl
        test edx, edx
        je short .7
        mov eax, dword [LinkPlayerCount]
.7:
        inc eax
        jmp short .6
.8:
        jne short .9
        push str_ELGR
        push dword [LinkLogoFile]
        call FindShape
        mov edx, eax
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        imul eax, byte 52h
        mov ebx, dword [LinkSetupItems]
        mov dword [byte ebx+eax+01Ah], edx
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        imul edx, eax, byte 52h
        mov eax, dword [LinkSetupItems]
        mov dword [byte edx+eax+01Eh], 0
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        imul eax, byte 52h
        mov edx, dword [LinkSetupItems]
        add esp, byte 8
        mov word [byte edx+eax+018h], 3
        jmp short .10
.9:
        push str_EL01
        push dword [LinkLogoFile]
        call FindShape
        mov edx, eax
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        imul eax, byte 52h
        add esp, byte 8
        mov ebx, dword [LinkSetupItems]
        push str_EL02
        mov dword [byte ebx+eax+01Ah], edx
        push dword [LinkLogoFile]
        call FindShape
        mov edx, eax
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        imul eax, byte 52h
        mov ebx, dword [LinkSetupItems]
        mov dword [byte ebx+eax+01Eh], edx
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        imul eax, byte 52h
        mov edx, dword [LinkSetupItems]
        add esp, byte 8
        mov word [byte edx+eax+018h], 0
.10:
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        imul eax, byte 52h
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+0Ch], 1
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawLinkSetupStatus                             A405E  97 PC, low confidence
; Draws the link setup status
;-----------------------------------------------------------------------------
DrawLinkSetupStatus:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 8, 0
        mov ebx, eax
        mov eax, dword [eax]
        mov ecx, 3
        cdq
        idiv ecx
        mov dword [byte ebp-08h], eax
        imul esi, eax, byte 7
        mov eax, dword [dword esi+LinkSetupItemShape]
        push dword [byte eax+02Ch]
        call BlitShape
        imul eax, dword [byte ebp-08h], byte 3
        inc eax
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        movsx ecx, word [LinkSetupSlotY]
        mov dword [edx+eax], ecx
        mov edx, dword [byte ebp-08h]
        mov ecx, dword [LinkSetupShapeFile]
        movsx ecx, word [ecx+edx*2]
        mov edx, dword [LinkSetupSlots]
        mov dword [byte edx+eax+04h], ecx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [dword esi+LinkSetupItemShape]
        mov edi, dword [edx+eax]
        mov ecx, dword [ecx]
        mov dword [byte ebp-04h], edi
        add dword [byte ebp-04h], ecx
        mov ecx, dword [byte ebp-04h]
        mov dword [byte edx+eax+08h], ecx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [byte edx+eax+04h]
        mov dword [byte edx+eax+0Ch], ecx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [byte edx+eax+08h]
        mov dword [byte edx+eax+010h], ecx
        mov edx, dword [LinkSetupSlots]
        mov esi, dword [dword esi+LinkSetupItemShape]
        mov ecx, dword [byte edx+eax+0Ch]
        add ecx, dword [byte esi+04h]
        mov dword [byte edx+eax+014h], ecx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [edx+eax]
        mov dword [byte edx+eax+018h], ecx
        mov edx, dword [LinkSetupSlots]
        add eax, edx
        mov edx, dword [byte eax+014h]
        mov dword [byte eax+01Ch], edx
        add esp, byte 4
        cmp dword [LinkGameActive], byte 0
        jne short .2
.1:
        mov ax, word [ebx]
        mov word [LinkHomeChoice], ax
        jmp near LinkGameSetup_8CA
.2:
        cmp dword [byte ebp-08h], byte 4
        jge short .3
        call ClearLinkAbort
        test eax, eax
        jne short .1
        jmp short .4
.3:
        call ClearLinkAbort
        test eax, eax
        je short .1
.4:
        mov ax, word [ebx]
        mov word [LinkAwayChoice], ax
        jmp near LinkGameSetup_8CA
;-----------------------------------------------------------------------------
; LinkSetupScreen                                 A4164  97 PC, low confidence
; Runs the link setup screen
;-----------------------------------------------------------------------------
LinkSetupScreen:
        push ebx
        push ecx
        push esi
        push edi
        enter 20h, 0
        mov ebx, eax
        mov edi, edx
        mov eax, edx
        mov ecx, 3
        cdq
        idiv ecx
        mov eax, edi
        mov dword [byte ebp-04h], edx
        cdq
        idiv ecx
        mov esi, eax
        cmp word [byte ebp-04h], byte 1
        jb short .1
        jbe near .17
        cmp word [byte ebp-04h], byte 2
        je near .32
        jmp near .48
.1:
        cmp word [byte ebp-04h], byte 0
        jne near .48
        mov eax, 100h
        call PlaySfx
        movsx eax, si
        imul eax, byte 7
        cmp word [dword eax+LinkSetupItemType], byte 2
        je near .5
        cmp dword [LinkGameActive], byte 0
        je short .3
        cmp si, byte 4
        jge short .2
        call ClearLinkAbort
        test eax, eax
        jne short .3
.2:
        cmp si, byte 3
        jle short .4
        call ClearLinkAbort
        test eax, eax
        jne short .4
.3:
        movsx edx, si
        mov eax, edx
        call LinkSetupCursor
        mov cl, al
        imul eax, edx, byte 7
        mov byte [dword eax+LinkSetupItemFlags], cl
        jmp short .5
.4:
        mov eax, dword [LinkSetupRow]
        add eax, dword [LinkSetupTop]
        cmp eax, dword [LinkSetupCount]
        jge short .5
        movsx eax, si
        imul eax, byte 7
        mov dl, byte [dword eax+LinkSetupItemFlags]
        and dl, 0F8h
        or dl, 1
        mov byte [dword eax+LinkSetupItemFlags], dl
.5:
        movsx eax, si
        mov dword [byte ebp-018h], eax
        imul eax, byte 7
        test byte [dword eax+LinkSetupItemFlags], 7
        je near .48
        cmp word [dword eax+LinkSetupItemType], byte 0
        je near .12
        mov dword [byte ebx+046h], 0
        mov dword [byte ebx+04Eh], 0
        mov dword [byte ebx+01Ah], 0
        and byte [byte ebx+032h], 0FDh
        cmp word [dword eax+LinkSetupItemType], byte 1
        jne near .8
        mov eax, dword [byte ebp-018h]
        mov dword [byte ebx+02Eh], 301h
        mov edx, dword [nosplit eax*4+LinkSetupNames]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ebx+01Ah], edx
        mov edx, dword [nosplit eax*4+LinkSetupLogos]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ebx+01Eh], edx
        mov edx, dword [nosplit eax*4+LinkSetupNames]
        mov edx, dword [byte edx+02Ch]
        movsx edx, word [byte edx+0Ch]
        mov dword [byte ebx+026h], edx
        mov eax, dword [nosplit eax*4+LinkSetupNames]
        mov eax, dword [byte eax+02Ch]
        movsx eax, word [byte eax+0Eh]
        mov dword [byte ebx+02Ah], eax
        imul eax, dword [byte ebp-018h], byte 21h
        mov edx, dword [gameopts]
        mov dword [byte ebp-010h], eax
        movsx eax, word [byte edx+eax+05h]
        cmp eax, byte 0FFFFFFFFh
        jne short .6
        mov eax, 0F8h
        call GetLangText
        push eax
        jmp short .7
.6:
        add edx, byte 5
        add edx, dword [byte ebp-010h]
        inc edx
        inc edx
        push edx
.7:
        call MeasureText
        add esp, byte 4
        imul eax, esi, byte 3
        mov edx, dword [byte ebx+01Ah]
        movsx edx, word [byte edx+0Ch]
        inc eax
        mov dword [byte ebp-01Ch], edx
        cwde
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        mov ecx, dword [byte ebp-01Ch]
        mov dword [edx+eax], ecx
        mov edx, dword [byte ebx+01Ah]
        movsx edx, word [byte edx+0Eh]
        mov dword [byte ebp-01Ch], edx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [byte ebp-01Ch]
        mov dword [byte edx+eax+04h], ecx
        mov edx, dword [LinkSetupSlots]
        add edx, eax
        mov dword [byte ebp-014h], edx
        mov edx, dword [byte ebx+01Ah]
        movsx edx, word [byte edx+04h]
        mov dword [byte ebp-01Ch], edx
        mov edx, dword [byte ebp-014h]
        mov edx, dword [edx]
        mov ecx, dword [byte ebp-014h]
        add edx, dword [byte ebp-01Ch]
        mov dword [byte ecx+08h], edx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [byte edx+eax+04h]
        mov dword [byte edx+eax+0Ch], ecx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [byte edx+eax+08h]
        mov dword [byte edx+eax+010h], ecx
        mov edx, dword [LinkSetupSlots]
        add edx, eax
        mov dword [byte ebp-014h], edx
        mov edx, dword [byte ebx+01Ah]
        movsx edx, word [byte edx+06h]
        mov dword [byte ebp-01Ch], edx
        mov edx, dword [byte ebp-014h]
        mov edx, dword [byte edx+0Ch]
        mov ecx, dword [byte ebp-014h]
        add edx, dword [byte ebp-01Ch]
        mov dword [byte ecx+014h], edx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [edx+eax]
        mov dword [byte edx+eax+018h], ecx
        mov edx, dword [LinkSetupSlots]
        add eax, edx
        mov edx, dword [byte eax+014h]
        mov dword [byte eax+01Ch], edx
        push dword [byte ebx+01Ah]
        call BlitShape
        add esp, byte 4
        jmp short .12
.8:
        cmp dword [LinkGameActive], byte 0
        je short .12
        cmp si, byte 4
        jge short .9
        call ClearLinkAbort
        test eax, eax
        jne short .10
.9:
        cmp si, byte 3
        jle short .11
        call ClearLinkAbort
        test eax, eax
        jne short .11
.10:
        dec dword [LinkSetupScrollUp]
        jmp short .12
.11:
        dec dword [LinkSetupTop]
.12:
        movsx eax, si
        imul ebx, eax, byte 7
        movzx edx, byte [dword ebx+LinkSetupItemFlags]
        call ResetLinkSetup
        mov edx, eax
        imul eax, edi, byte 52h
        mov dword [byte ebp-01Ch], eax
        mov eax, dword [LinkSetupItems]
        add eax, dword [byte ebp-01Ch]
        mov dword [byte eax+01Ah], edx
        cmp word [dword ebx+LinkSetupItemType], byte 0
        je near .48
        cmp dword [LinkGameActive], byte 0
        je short .16
        cmp si, byte 4
        jge short .13
        call ClearLinkAbort
        test eax, eax
        jne short .14
.13:
        cmp si, byte 3
        jle short .15
        call ClearLinkAbort
        test eax, eax
        jne short .15
.14:
        inc dword [LinkSetupScrollDown]
        jmp short .16
.15:
        inc dword [LinkSetupRow]
.16:
        imul edi, byte 52h
        movsx ebx, si
        imul ebx, byte 7
        mov eax, dword [LinkSetupItems]
        mov dword [byte edi+eax+046h], DrawLinkSetupStatus
        mov eax, dword [LinkSetupItems]
        mov dword [byte edi+eax+04Eh], LinkSetupScreen
        mov eax, dword [LinkSetupItems]
        or byte [byte edi+eax+032h], 2
        mov eax, dword [dword ebx+LinkSetupItemShape]
        mov edx, dword [LinkSetupItems]
        mov eax, dword [byte eax+02Ch]
        mov dx, word [byte edx+edi+026h]
        mov word [byte eax+0Ch], dx
        mov eax, dword [LinkSetupItems]
        add edi, eax
        mov eax, dword [dword ebx+LinkSetupItemShape]
        mov eax, dword [byte eax+02Ch]
        mov dx, word [byte edi+02Ah]
        mov word [byte eax+0Eh], dx
        mov eax, dword [dword ebx+LinkSetupItemShape]
        push dword [byte eax+02Ch]
        call ConvertArtKeepPos
        mov word [dword ebx+LinkSetupItemType], 0
        add esp, byte 4
        and byte [dword ebx+LinkSetupItemFlags], 7Fh
        jmp near .48
.17:
        movsx edx, ax
        imul edx, byte 7
        cmp word [dword edx+LinkSetupItemType], byte 1
        je near .48
        mov eax, 100h
        call PlaySfx
        mov dword [byte ebx+01Ah], 0
        mov dword [byte ebx+046h], 0
        mov dword [byte ebx+04Eh], 0
        and byte [byte ebx+032h], 0FDh
        mov al, byte [dword edx+LinkSetupItemFlags]
        and al, 7
        cmp al, 3
        jb short .18
        cmp al, 4
        jbe short .19
        cmp al, 5
        je short .20
        jmp short .23
.18:
        cmp al, 2
        jne short .23
        and byte [LinkSetupCursorFlags], 0FEh
        jmp short .23
.19:
        and byte [LinkSetupCursorFlags], 0FDh
        jmp short .23
.20:
        xor eax, eax
.21:
        movsx edx, si
        imul edx, byte 7
        mov dl, byte [dword edx+LinkSetupItemFlags]
        and dl, 78h
        movzx edx, dl
        sar edx, 3
        movsx ebx, ax
        mov dword [byte ebp-01Ch], edx
        movsx edx, word [nosplit ebx*2+LinkSetupValues]
        cmp edx, dword [byte ebp-01Ch]
        je short .22
        inc eax
        jmp short .21
.22:
        inc ebx
        inc ebx
        mov eax, 1
        mov cl, bl
        shl eax, cl
        not eax
        and dword [LinkSetupCursorFlags], eax
.23:
        movsx eax, si
        imul eax, byte 7
        mov dl, byte [dword eax+LinkSetupItemFlags]
        and dl, 0F8h
        mov byte [dword eax+LinkSetupItemFlags], dl
        cmp dword [LinkGameActive], byte 0
        je near .31
        cmp word [dword eax+LinkSetupItemType], byte 0
        jne short .27
        cmp si, byte 4
        jge short .24
        call ClearLinkAbort
        test eax, eax
        jne short .25
.24:
        cmp si, byte 3
        jle short .26
        call ClearLinkAbort
        test eax, eax
        jne short .26
.25:
        dec dword [LinkSetupScrollDown]
        jmp short .31
.26:
        dec dword [LinkSetupRow]
        jmp short .31
.27:
        cmp si, byte 4
        jge short .28
        call ClearLinkAbort
        test eax, eax
        jne short .29
.28:
        cmp si, byte 3
        jle short .30
        call ClearLinkAbort
        test eax, eax
        jne short .30
.29:
        dec dword [LinkSetupScrollUp]
        jmp short .31
.30:
        dec dword [LinkSetupTop]
.31:
        movsx eax, si
        mov dword [byte ebp-020h], eax
        imul ebx, dword [byte ebp-020h], byte 7
        mov eax, dword [nosplit eax*4+LinkSetupArt]
        push dword [byte eax+02Ch]
        call BlitShape
        mov eax, dword [byte ebp-020h]
        add esp, byte 4
        movzx edx, byte [dword ebx+LinkSetupItemFlags]
        call ResetLinkSetup
        mov ecx, eax
        imul eax, edi, byte 52h
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+01Ah], ecx
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+01Eh], 0
        mov edx, dword [LinkSetupItems]
        movsx ecx, word [LinkSetupSlotY]
        mov dword [byte edx+eax+026h], ecx
        mov edx, dword [byte ebp-020h]
        mov ecx, dword [LinkSetupShapeFile]
        movsx ecx, word [ecx+edx*2]
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+02Ah], ecx
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+046h], DrawLinkSetupStatus
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+04Eh], LinkSetupScreen
        mov edx, dword [LinkSetupItems]
        or byte [byte edx+eax+032h], 2
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+02Eh], 0
        mov edx, dword [dword ebx+LinkSetupItemShape]
        mov edi, dword [LinkSetupItems]
        mov edx, dword [byte edx+02Ch]
        mov cx, word [byte edi+eax+026h]
        mov word [byte edx+0Ch], cx
        mov edx, dword [LinkSetupItems]
        add edx, eax
        mov eax, dword [dword ebx+LinkSetupItemShape]
        mov eax, dword [byte eax+02Ch]
        mov dx, word [byte edx+02Ah]
        mov word [byte eax+0Eh], dx
        mov eax, dword [dword ebx+LinkSetupItemShape]
        push dword [byte eax+02Ch]
        call ConvertArtKeepPos
        add esp, byte 4
        mov word [dword ebx+LinkSetupItemType], 1
        jmp near .48
.32:
        mov eax, 100h
        call PlaySfx
        movsx eax, si
        imul eax, byte 7
        cmp word [dword eax+LinkSetupItemType], byte 0
        je near .36
        cmp dword [LinkGameActive], byte 0
        je short .34
        cmp si, byte 4
        jge short .33
        call ClearLinkAbort
        test eax, eax
        jne short .34
.33:
        cmp si, byte 3
        jle short .35
        call ClearLinkAbort
        test eax, eax
        jne short .35
.34:
        movsx edx, si
        mov eax, edx
        call LinkSetupCursor
        mov cl, al
        imul eax, edx, byte 7
        mov byte [dword eax+LinkSetupItemFlags], cl
        jmp short .36
.35:
        mov eax, dword [LinkSetupRow]
        add eax, dword [LinkSetupTop]
        cmp eax, dword [LinkSetupCount]
        jge short .36
        movsx eax, si
        imul eax, byte 7
        mov dl, byte [dword eax+LinkSetupItemFlags]
        and dl, 0F8h
        or dl, 1
        mov byte [dword eax+LinkSetupItemFlags], dl
.36:
        movsx eax, si
        mov dword [byte ebp-08h], eax
        imul eax, byte 7
        test byte [dword eax+LinkSetupItemFlags], 7
        je near .48
        cmp word [dword eax+LinkSetupItemType], byte 2
        je near .43
        mov dword [byte ebx+046h], 0
        mov dword [byte ebx+04Eh], 0
        mov dword [byte ebx+01Ah], 0
        and byte [byte ebx+032h], 0FDh
        cmp word [dword eax+LinkSetupItemType], byte 1
        jne near .39
        mov eax, dword [byte ebp-08h]
        mov dword [byte ebx+02Eh], 301h
        mov edx, dword [nosplit eax*4+LinkSetupNames]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ebx+01Ah], edx
        mov edx, dword [nosplit eax*4+LinkSetupLogos]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ebx+01Eh], edx
        mov edx, dword [nosplit eax*4+LinkSetupNames]
        mov edx, dword [byte edx+02Ch]
        movsx edx, word [byte edx+0Ch]
        mov dword [byte ebx+026h], edx
        imul edx, dword [byte ebp-08h], byte 21h
        mov eax, dword [nosplit eax*4+LinkSetupNames]
        mov eax, dword [byte eax+02Ch]
        movsx eax, word [byte eax+0Eh]
        mov dword [byte ebx+02Ah], eax
        mov eax, dword [gameopts]
        mov dword [byte ebp-0Ch], eax
        movsx eax, word [byte edx+eax+05h]
        cmp eax, byte 0FFFFFFFFh
        jne short .37
        mov eax, 0F8h
        call GetLangText
        jmp short .38
.37:
        mov eax, dword [byte ebp-0Ch]
        add eax, byte 5
        add eax, edx
        inc eax
        inc eax
.38:
        push eax
        call MeasureText
        add esp, byte 4
        imul eax, esi, byte 3
        mov edx, dword [byte ebx+01Ah]
        movsx edx, word [byte edx+0Ch]
        inc eax
        mov dword [byte ebp-01Ch], edx
        cwde
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        mov ecx, dword [byte ebp-01Ch]
        mov dword [edx+eax], ecx
        mov edx, dword [byte ebx+01Ah]
        movsx edx, word [byte edx+0Eh]
        mov dword [byte ebp-01Ch], edx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [byte ebp-01Ch]
        mov dword [byte edx+eax+04h], ecx
        mov edx, dword [LinkSetupSlots]
        add edx, eax
        mov dword [byte ebp-014h], edx
        mov edx, dword [byte ebx+01Ah]
        movsx edx, word [byte edx+04h]
        mov dword [byte ebp-01Ch], edx
        mov edx, dword [byte ebp-014h]
        mov edx, dword [edx]
        mov ecx, dword [byte ebp-014h]
        add edx, dword [byte ebp-01Ch]
        mov dword [byte ecx+08h], edx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [byte edx+eax+04h]
        mov dword [byte edx+eax+0Ch], ecx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [byte edx+eax+08h]
        mov dword [byte edx+eax+010h], ecx
        mov edx, dword [LinkSetupSlots]
        add edx, eax
        mov dword [byte ebp-01Ch], edx
        mov edx, dword [byte ebx+01Ah]
        movsx edx, word [byte edx+06h]
        mov dword [byte ebp-014h], edx
        mov edx, dword [byte ebp-01Ch]
        mov edx, dword [byte edx+0Ch]
        mov ecx, dword [byte ebp-01Ch]
        add edx, dword [byte ebp-014h]
        mov dword [byte ecx+014h], edx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [edx+eax]
        mov dword [byte edx+eax+018h], ecx
        mov edx, dword [LinkSetupSlots]
        add eax, edx
        mov edx, dword [byte eax+014h]
        mov dword [byte eax+01Ch], edx
        push dword [byte ebx+01Ah]
        call BlitShape
        add esp, byte 4
        jmp short .43
.39:
        cmp dword [LinkGameActive], byte 0
        je short .43
        cmp si, byte 4
        jge short .40
        call ClearLinkAbort
        test eax, eax
        jne short .41
.40:
        cmp si, byte 3
        jle short .42
        call ClearLinkAbort
        test eax, eax
        jne short .42
.41:
        dec dword [LinkSetupScrollDown]
        jmp short .43
.42:
        dec dword [LinkSetupRow]
.43:
        movsx eax, si
        imul ebx, eax, byte 7
        movzx edx, byte [dword ebx+LinkSetupItemFlags]
        call ResetLinkSetup
        mov edx, eax
        imul eax, edi, byte 52h
        mov dword [byte ebp-014h], eax
        mov eax, dword [LinkSetupItems]
        add eax, dword [byte ebp-014h]
        mov dword [byte eax+01Ah], edx
        cmp word [dword ebx+LinkSetupItemType], byte 2
        je near .48
        cmp dword [LinkGameActive], byte 0
        je short .47
        cmp si, byte 4
        jge short .44
        call ClearLinkAbort
        test eax, eax
        jne short .45
.44:
        cmp si, byte 3
        jle short .46
        call ClearLinkAbort
        test eax, eax
        jne short .46
.45:
        inc dword [LinkSetupScrollUp]
        jmp short .47
.46:
        inc dword [LinkSetupTop]
.47:
        imul edi, byte 52h
        movsx ebx, si
        imul ebx, byte 7
        mov eax, dword [LinkSetupItems]
        mov dword [byte edi+eax+046h], DrawLinkSetupStatus
        mov eax, dword [LinkSetupItems]
        mov dword [byte edi+eax+04Eh], LinkSetupScreen
        mov eax, dword [LinkSetupItems]
        or byte [byte edi+eax+032h], 2
        mov eax, dword [dword ebx+LinkSetupItemShape]
        mov edx, dword [LinkSetupItems]
        mov eax, dword [byte eax+02Ch]
        mov dx, word [byte edx+edi+026h]
        mov word [byte eax+0Ch], dx
        mov eax, dword [LinkSetupItems]
        add edi, eax
        mov eax, dword [dword ebx+LinkSetupItemShape]
        mov eax, dword [byte eax+02Ch]
        mov dx, word [byte edi+02Ah]
        mov word [byte eax+0Eh], dx
        mov eax, dword [dword ebx+LinkSetupItemShape]
        push dword [byte eax+02Ch]
        call ConvertArtKeepPos
        mov word [dword ebx+LinkSetupItemType], 2
        add esp, byte 4
        or byte [dword ebx+LinkSetupItemFlags], 80h
.48:
        cmp dword [LinkGameActive], byte 0
        je short .51
        call ClearLinkAbort
        test eax, eax
        je short .50
        cmp si, byte 4
        jl short .51
.49:
        mov word [LinkAwayChoice], 0FFFFh
        jmp short .52
.50:
        cmp si, byte 4
        jl short .49
.51:
        mov word [LinkHomeChoice], 0FFFFh
.52:
        call DrawLinkSetupItem
        leave
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LinkSetupSound                                  A4A5C  97 PC, low confidence
; Plays a link setup sound
;-----------------------------------------------------------------------------
LinkSetupSound:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov eax, dword [tickcount]
        xor edx, edx
        cmp eax, dword [LinkSetupSoundTick]
        jle near LinkGameSetup_8CB
        mov edi, 3
        imul esi, dword [LinkPlayerCount], byte 3
        jmp short .3
.1:
        imul ecx, esi, byte 52h
        mov ebx, dword [LinkSetupItems]
        add ebx, ecx
        cmp dword [byte ebx+04h], byte 1
        jne short .2
        movsx eax, word [LinkSetupSoundIndex]
        inc eax
        cdq
        idiv edi
        movsx eax, dx
        mov word [LinkSetupSoundIndex], dx
        mov eax, dword [nosplit eax*4+LinkSetupSounds]
        mov dword [byte ebx+01Eh], eax
        mov eax, dword [LinkSetupItems]
        push dword [byte ecx+eax+02Ah]
        push dword [byte ecx+eax+026h]
        push dword [byte ecx+eax+01Eh]
        call BlitArt
        mov edx, 1
        add esp, byte 0Ch
.2:
        inc esi
.3:
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        inc eax
        cmp esi, eax
        jl short .1
        mov eax, dword [tickcount]
        add eax, byte 5
        mov dword [LinkSetupSoundTick], eax
        test dx, dx
        je short .4
        cmp word [LinkSetupSoundOn], byte 0
        jne short .4
        mov eax, 309h
        call PlaySfx
        mov word [LinkSetupSoundOn], 1
.4:
        test dx, dx
        jne near LinkGameSetup_8CB
        cmp word [LinkSetupSoundOn], byte 0
        je near LinkGameSetup_8CB
        call StopAllSfx
        mov word [LinkSetupSoundOn], dx
        jmp near LinkGameSetup_8CB
LinkControlSetupJumpTable:                      ; jump table for the switch cases of RunLinkGameScreens
        dd RunLinkGameScreens_30
        dd RunLinkGameScreens_30
        dd RunLinkGameScreens_30
        dd RunLinkGameScreens_30
        dd RunLinkGameScreens_30
        dd RunLinkGameScreens_30
LinkControlLocalJumpTable:                      ; jump table for the switch cases of RunLinkGameScreens
        dd RunLinkGameScreens_112
        dd RunLinkGameScreens_112
        dd RunLinkGameScreens_112
        dd RunLinkGameScreens_112
        dd RunLinkGameScreens_112
        dd RunLinkGameScreens_112
LinkControlRestoreJumpTable:                    ; jump table for the switch cases of RunLinkGameScreens
        dd RunLinkGameScreens_1971
        dd RunLinkGameScreens_1971
        dd RunLinkGameScreens_1971
        dd RunLinkGameScreens_1971
        dd RunLinkGameScreens_1971
        dd RunLinkGameScreens_1971
;-----------------------------------------------------------------------------
; RunLinkGameScreens                              A4B7D  97 PC, low confidence
; Runs the screens of a link game
;-----------------------------------------------------------------------------
RunLinkGameScreens:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 40h, 0
        mov dword [byte ebp-010h], 0FFFFFFFFh
        xor esi, esi
.1:
        mov eax, dword [gameopts]
        mov al, byte [dword esi+eax+010Dh]
        and al, 7
        movzx edi, al
        cmp edi, byte 5
        ja short RunLinkGameScreens_30
        jmp dword [nosplit cs:edi*4+LinkControlSetupJumpTable]
RunLinkGameScreens_30:
        inc esi
        cmp esi, byte 8
        jl short RunLinkGameScreens.1
        cmp byte [FrontMusicOn], 0
        je short .2
        call MusicEnabled
.2:
        test byte [GameSettings], 70h
        jne short .3
        cmp dword [GameRunning], byte 0
        je short .3
        call ClearLinkCounters
.3:
        cmp dword [LinkGameActive], byte 0
        je short .4
        mov dword [LinkSetupShapeFile], str_S_RunLinkGameScreens
        mov dword [LinkPlayerCount], 8
        jmp short .5
.4:
        mov dword [LinkSetupShapeFile], LinkSetupShapeName
        mov dword [LinkPlayerCount], 4
.5:
        imul eax, dword [LinkPlayerCount], byte 3
        add eax, byte 7
        imul eax, byte 52h
        push byte 20h
        push eax
        push str_PICKS
        call AllocMemBlock
        mov dword [LinkSetupItems], eax
        imul eax, dword [LinkPlayerCount], byte 3
        add esp, byte 0Ch
        shl eax, 6
        push byte 20h
        add eax, 1C0h
        push eax
        push str_REGS
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 8
        mov dword [LinkSetupSlots], eax
        lea eax, [byte ebp-02Ch]
        push eax
        mov eax, dword [gameopts]
        add eax, 10Dh
        push eax
        call bcopy
        add esp, byte 0Ch
        lea eax, [byte ebp-02Ch]
        xor esi, esi
        call InitLinkSettings
        mov dword [LinkSetupSettings], eax
.6:
        mov al, byte [byte esi+ebp-02Ch]
        and al, 7
        movzx edi, al
        cmp edi, byte 5
        ja short RunLinkGameScreens_112
        jmp dword [nosplit cs:edi*4+LinkControlLocalJumpTable]
RunLinkGameScreens_112:
        inc esi
        cmp esi, byte 8
        jl short RunLinkGameScreens_30.6
        cmp dword [LinkGameActive], byte 0
        je short .8
        call ClearLinkAbort
        test eax, eax
        je short .7
        mov edx, 4
        mov eax, LinkSetupSettings
        xor ebx, ebx
        call LinkSendBlock
        mov edx, 4
        mov eax, LinkSetupCount
        xor ebx, ebx
        call LinkReceiveBlock
        jmp short .8
.7:
        mov edx, 4
        mov eax, LinkSetupCount
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 4
        mov eax, LinkSetupSettings
        xor ebx, ebx
        call LinkSendBlock
.8:
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 0Ah
        call LoadDataFile
        mov dword [LinkShapeFile], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 0Bh
        xor esi, esi
        call LoadDataFile
        mov dword [LinkLogoFile], eax
.9:
        lea eax, [byte esi+02h]
        push eax
        push str_EL02d
        lea eax, [byte ebp-040h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-040h]
        push eax
        push dword [LinkLogoFile]
        inc esi
        call FindShape
        add esp, byte 8
        mov dword [nosplit esi*4+LinkSetupShapes], eax
        cmp esi, byte 3
        jl short .9
        call SetNormalText
        mov word [LinkSetupItemCount], 4
        xor esi, esi
        jmp short .12
.10:
        imul edx, esi, byte 38h
        mov eax, dword [GripDriverPtr]
        test byte [edx+eax], 1
        je short .11
        movsx eax, word [LinkSetupItemCount]
        inc word [LinkSetupItemCount]
        mov word [nosplit eax*2+LinkSetupOrder], si
.11:
        inc esi
.12:
        movzx eax, word [GripPortWord]
        cmp esi, eax
        jl short .10
        movsx eax, word [LinkSetupItemCount]
        mov dword [LinkSetupCursorFlags], 0
        dec eax
        dec eax
        xor esi, esi
        mov dword [LinkSetupMaxPlayers], eax
        jmp short .20
.13:
        mov al, byte [byte esi+ebp-02Ch]
        and al, 7
        cmp al, 2
        jne short .14
        or byte [LinkSetupCursorFlags], 1
        jmp short .19
.14:
        cmp al, 4
        je short .15
        cmp al, 3
        jne short .16
.15:
        or byte [LinkSetupCursorFlags], 2
        jmp short .19
.16:
        cmp al, 5
        jne short .19
        xor edi, edi
.17:
        mov al, byte [byte esi+ebp-02Ch]
        and al, 78h
        movzx eax, al
        mov edx, eax
        sar edx, 3
        movsx eax, word [nosplit edi*2+LinkSetupValues]
        cmp eax, edx
        je short .18
        inc edi
        jmp short .17
.18:
        mov eax, 1
        lea ecx, [byte edi+02h]
        shl eax, cl
        or dword [LinkSetupCursorFlags], eax
.19:
        inc esi
.20:
        cmp esi, dword [LinkPlayerCount]
        jl short .13
        movsx eax, word [LinkSetupItemCount]
        shl eax, 2
        imul eax, dword [LinkPlayerCount]
        push byte 20h
        push eax
        push str_WINS
        call AllocMemBlock
        movsx edx, word [LinkSetupItemCount]
        shl edx, 2
        imul edx, dword [LinkPlayerCount]
        add esp, byte 0Ch
        push edx
        push eax
        xor esi, esi
        mov dword [LinkSetupBuffer], eax
        call ZeroMem
        mov dword [LinkSetupTop], 0
        mov dword [LinkSetupScrollUp], 0
        mov dword [LinkSetupRow], 0
        mov dword [LinkSetupScrollDown], 0
        add esp, byte 8
        jmp near .44
.21:
        imul eax, esi, byte 7
        mov dl, byte [byte esi+ebp-02Ch]
        mov byte [dword eax+LinkSetupItemFlags], dl
        test dl, 7
        jne short .22
        mov word [dword eax+LinkSetupItemType], 1
        jmp near .32
.22:
        test dl, 80h
        jne short .27
        cmp dword [LinkGameActive], byte 0
        je short .26
        call ClearLinkAbort
        mov edx, dword [LinkSetupScrollDown]
        mov ebx, dword [LinkSetupRow]
        inc edx
        inc ebx
        test eax, eax
        je short .24
        cmp esi, byte 4
        jl short .25
.23:
        mov dword [LinkSetupRow], ebx
        jmp short .26
.24:
        cmp esi, byte 4
        jl short .23
.25:
        mov dword [LinkSetupScrollDown], edx
.26:
        imul eax, esi, byte 7
        mov word [dword eax+LinkSetupItemType], 0
        jmp short .32
.27:
        cmp dword [LinkGameActive], byte 0
        je short .31
        call ClearLinkAbort
        mov edx, dword [LinkSetupScrollUp]
        mov ebx, eax
        mov eax, dword [LinkSetupTop]
        inc edx
        inc eax
        test ebx, ebx
        je short .29
        cmp esi, byte 4
        jl short .30
.28:
        mov dword [LinkSetupTop], eax
        jmp short .31
.29:
        cmp esi, byte 4
        jl short .28
.30:
        mov dword [LinkSetupScrollUp], edx
.31:
        imul eax, esi, byte 7
        mov word [dword eax+LinkSetupItemType], 2
.32:
        imul eax, esi, byte 7
        xor edi, edi
        mov dword [dword eax+LinkSetupItemShape], 0
        jmp near .43
.33:
        movzx eax, byte [dword esi+LinkButtonLetters]
        push eax
        push str_BUTD
        lea eax, [byte ebp-040h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-040h]
        push eax
        push dword [LinkShapeFile]
        call FindShape
        add esp, byte 8
        mov ebx, eax
        push byte 20h
        movsx eax, word [byte eax+06h]
        push eax
        movsx eax, word [byte ebx+04h]
        push eax
        call CreateBitmap
        mov edx, eax
        movsx eax, word [LinkSetupItemCount]
        imul eax, esi
        add eax, edi
        mov ecx, dword [LinkSetupBuffer]
        shl eax, 2
        add eax, ecx
        add esp, byte 0Ch
        mov dword [eax], edx
        mov eax, edx
        push eax
        mov dword [byte ebp-08h], eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        call ClearScreen
        add esp, byte 4
        push byte 0
        push byte 0
        push ebx
        call DrawArt
        add esp, byte 0Ch
        test edi, edi
        jle near .40
        cmp edi, byte 2
        jb short .34
        jbe short .36
        cmp edi, byte 3
        je short .37
        jmp short .38
.34:
        cmp edi, byte 1
        jne short .38
        test byte [MenuOptionFlags], 1
        je short .35
        mov edx, str_ICN1
        jmp short .39
.35:
        mov edx, str_ICN5
        jmp short .39
.36:
        mov edx, str_ICN4
        jmp short .39
.37:
        mov edx, str_ICN2
        jmp short .39
.38:
        mov edx, str_ICN3
.39:
        lea eax, [byte ebp-040h]
        call strcpy_
        lea eax, [byte ebp-040h]
        push eax
        push dword [LinkShapeFile]
        call FindShape
        add esp, byte 8
        push byte 0
        push byte 0
        push eax
        call DrawArt
        add esp, byte 0Ch
        cmp edi, byte 4
        jl near .42
        movsx eax, word [nosplit edi*2+LinkSetupOrder]
        inc eax
        push eax
        push str_D_RunLinkGameScreens
        lea eax, [byte ebp-040h]
        push eax
        call sprintf_
        mov eax, dword [byte ebp-08h]
        mov eax, dword [byte eax+02Ch]
        mov ebx, dword [LinkTextFont]
        movsx edx, word [byte eax+06h]
        sar ebx, 1
        sar edx, 1
        sub edx, ebx
        movsx eax, word [byte eax+04h]
        mov ebx, edx
        mov edx, eax
        sar edx, 1
        sar eax, 4
        add esp, byte 0Ch
        add edx, eax
        lea eax, [byte ebp-040h]
        push eax
        mov dword [byte ebp-020h], edx
        call MeasureText
        mov edx, dword [byte ebp-020h]
        mov ecx, 1
        sar eax, 1
        add esp, byte 4
        jmp short .41
.40:
        mov edx, str_CPU
        lea eax, [byte ebp-040h]
        call strcpy_
        movsx edx, word [byte ebx+06h]
        mov eax, dword [LinkTextFont]
        sar edx, 1
        sar eax, 1
        sub edx, eax
        lea eax, [byte edx-01h]
        mov dword [byte ebp-020h], eax
        movsx eax, word [byte ebx+04h]
        mov ebx, eax
        lea eax, [byte ebp-040h]
        push eax
        sar ebx, 1
        call MeasureText
        mov ecx, 1
        add esp, byte 4
        sar eax, 1
        mov edx, ebx
        mov ebx, dword [byte ebp-020h]
.41:
        sub edx, eax
        lea eax, [byte ebp-040h]
        call DrawLinkStatusText
.42:
        inc edi
.43:
        movsx eax, word [LinkSetupItemCount]
        cmp edi, eax
        jl near .33
        inc esi
.44:
        cmp esi, dword [LinkPlayerCount]
        jl near .21
        push byte 0
        push dword 1E0h
        push dword 280h
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [byte ebp-08h], eax
        call SetDrawTarget
        add esp, byte 4
        push str_00005
        push dword [LinkShapeFile]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_00012
        push dword [LinkShapeFile]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_00022
        push dword [LinkShapeFile]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        cmp dword [LinkPlayerCount], byte 4
        jne short .45
        push str_SL02
        jmp short .46
.45:
        push str_SL01
.46:
        push dword [LinkShapeFile]
        call FindShape
        add esp, byte 8
        mov dword [byte ebp-0Ch], eax
        push dword [byte ebp-0Ch]
        call BlitShape
        add esp, byte 4
        push str_BANL
        push dword [LinkShapeFile]
        call FindShape
        mov ebx, eax
        mov eax, dword [gameopts]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        add esp, byte 8
        shr eax, 1Ah
        push eax
        push str_BN02d
        lea eax, [byte ebp-040h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-040h]
        push eax
        push dword [LinkShapeFile]
        call FindShape
        sub eax, ebx
        add esp, byte 8
        and eax, 0FFFFFFh
        and dword [ebx], 0FFh
        shl eax, 8
        push ebx
        or dword [ebx], eax
        call BlitShape
        add esp, byte 4
        push str_BANR
        push dword [LinkShapeFile]
        call FindShape
        mov ebx, eax
        mov eax, dword [gameopts]
        mov eax, dword [byte eax+01h]
        shl eax, 6
        add esp, byte 8
        shr eax, 1Ah
        push eax
        push str_BN02d
        lea eax, [byte ebp-040h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-040h]
        push eax
        push dword [LinkShapeFile]
        call FindShape
        sub eax, ebx
        add esp, byte 8
        and eax, 0FFFFFFh
        and dword [ebx], 0FFh
        shl eax, 8
        push ebx
        or dword [ebx], eax
        call BlitShape
        add esp, byte 4
        push str_LOGO4
        push dword [LinkShapeFile]
        call FindShape
        add esp, byte 8
        movsx edx, word [byte eax+04h]
        sar edx, 1
        mov word [byte eax+08h], dx
        movsx edx, word [byte eax+06h]
        sar edx, 1
        push str_TITL6
        mov word [byte eax+0Ah], dx
        push dword [LinkLogoFile]
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        mov eax, dword [gameopts]
        mov edx, dword [byte eax+01h]
        and edx, 0FC000h
        add esp, byte 4
        cmp edx, 5C000h
        jne short .47
        push dword 8CCCh
        push byte 0
        push byte 0
        push dword 10Eh
        push byte 68h
        push str_LOGO4
        mov ebx, dword [byte ebp-08h]
        push dword [LinkShapeFile]
        mov ebx, dword [byte ebx+02Ch]
        call FindShape
        mov edx, 10h
        add esp, byte 8
        mov ecx, ebx
        mov ebx, dword [byte ebp-08h]
        call DrawMatchBanner
        jmp short .48
.47:
        push dword 8CCCh
        push byte 0
        mov ecx, dword [byte ebp-08h]
        mov ebx, dword [byte ebp-08h]
        push byte 0
        mov edx, 10h
        mov eax, dword [byte eax+01h]
        push dword 10Eh
        shl eax, 0Ch
        mov ecx, dword [byte ecx+02Ch]
        push byte 68h
        shr eax, 1Ah
        call DrawTeamLogoBanner
.48:
        mov eax, dword [gameopts]
        mov edx, dword [byte eax+01h]
        and edx, 3F00000h
        cmp edx, 1700000h
        jne short .49
        push dword 8CCCh
        push byte 0
        push byte 0
        push dword 10Eh
        push dword 216h
        push str_LOGO4
        mov ebx, dword [byte ebp-08h]
        push dword [LinkShapeFile]
        mov ebx, dword [byte ebx+02Ch]
        call FindShape
        mov edx, 10h
        add esp, byte 8
        mov ecx, ebx
        mov ebx, dword [byte ebp-08h]
        call DrawMatchBanner
        jmp short .50
.49:
        push dword 8CCCh
        push byte 0
        mov ecx, dword [byte ebp-08h]
        mov ebx, dword [byte ebp-08h]
        push byte 0
        mov edx, 10h
        mov eax, dword [byte eax+01h]
        push dword 10Eh
        shl eax, 6
        mov ecx, dword [byte ecx+02Ch]
        push dword 216h
        shr eax, 1Ah
        call DrawTeamLogoBanner
.50:
        push dword [byte ebp-08h]
        call SetDrawTarget
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupItems]
        add esp, byte 4
        add eax, byte 7
        xor esi, esi
        call InitMenuItems
        jmp near .74
.51:
        movzx eax, byte [dword esi+LinkButtonLetters]
        push eax
        push str_BUTD
        lea eax, [byte ebp-040h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-040h]
        push eax
        push dword [LinkShapeFile]
        call FindShape
        add esp, byte 8
        mov dword [byte ebp-0Ch], eax
        cmp dword [LinkGameActive], byte 0
        je short .53
        call ClearLinkAbort
        test eax, eax
        je short .52
        mov eax, dword [LinkPlayerCount]
        sar eax, 1
        cmp esi, eax
        jl short .53
.52:
        call ClearLinkAbort
        test eax, eax
        jne short .54
        mov eax, dword [LinkPlayerCount]
        sar eax, 1
        cmp esi, eax
        jl short .54
.53:
        imul edx, esi, byte 21h
        mov eax, dword [gameopts]
        add eax, byte 5
        add eax, edx
        inc eax
        inc eax
        jmp short .55
.54:
        mov eax, 0F7h
        call GetLangText
.55:
        push eax
        call MeasureText
        add esp, byte 4
        mov edi, eax
        mov eax, dword [LinkTextFont]
        push byte 20h
        inc eax
        inc eax
        push eax
        mov ebx, esi
        push edi
        shl ebx, 2
        call CreateBitmap
        mov dword [dword ebx+LinkSetupArt], eax
        mov eax, edi
        mov edx, 13Ch
        sar eax, 1
        sub edx, eax
        mov eax, dword [dword ebx+LinkSetupArt]
        mov eax, dword [byte eax+02Ch]
        mov word [byte eax+0Ch], dx
        lea eax, [esi+esi]
        mov dword [byte ebp-018h], eax
        mov eax, dword [LinkSetupShapeFile]
        add eax, dword [byte ebp-018h]
        mov dword [byte ebp-04h], edx
        movsx edx, word [eax]
        mov eax, dword [byte ebp-0Ch]
        movsx eax, word [byte eax+06h]
        sar eax, 1
        add eax, edx
        mov edx, dword [LinkTextFont]
        sar edx, 1
        sub eax, edx
        mov edx, eax
        mov eax, dword [dword ebx+LinkSetupArt]
        mov eax, dword [byte eax+02Ch]
        mov word [byte eax+0Eh], dx
        add esp, byte 0Ch
        mov eax, dword [dword ebx+LinkSetupArt]
        push dword [byte eax+02Ch]
        call ConvertArtKeepPos
        add esp, byte 4
        mov eax, dword [LinkTextFont]
        push byte 20h
        inc eax
        inc eax
        push eax
        push edi
        call CreateBitmap
        mov dword [dword ebx+LinkSetupNames], eax
        mov eax, dword [byte eax+02Ch]
        mov edx, dword [byte ebp-04h]
        mov word [byte eax+0Ch], dx
        mov edx, dword [byte ebp-0Ch]
        mov eax, dword [LinkSetupShapeFile]
        movsx edx, word [byte edx+06h]
        add eax, dword [byte ebp-018h]
        movsx eax, word [eax]
        sar edx, 1
        add edx, eax
        mov eax, dword [LinkTextFont]
        sar eax, 1
        sub edx, eax
        mov eax, dword [dword ebx+LinkSetupNames]
        mov eax, dword [byte eax+02Ch]
        mov word [byte eax+0Eh], dx
        add esp, byte 0Ch
        mov eax, dword [dword ebx+LinkSetupNames]
        push dword [byte eax+02Ch]
        call ConvertArtKeepPos
        add esp, byte 4
        mov eax, dword [LinkTextFont]
        push byte 20h
        inc eax
        inc eax
        push eax
        push edi
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [dword ebx+LinkSetupLogos], eax
        mov eax, dword [byte eax+02Ch]
        mov edx, dword [byte ebp-04h]
        mov word [byte eax+0Ch], dx
        mov eax, dword [LinkSetupShapeFile]
        add eax, dword [byte ebp-018h]
        movsx edx, word [eax]
        mov eax, dword [byte ebp-0Ch]
        movsx eax, word [byte eax+06h]
        sar eax, 1
        add eax, edx
        mov edx, dword [LinkTextFont]
        sar edx, 1
        sub eax, edx
        mov edx, eax
        mov eax, dword [dword ebx+LinkSetupLogos]
        mov eax, dword [byte eax+02Ch]
        mov word [byte eax+0Eh], dx
        mov eax, dword [dword ebx+LinkSetupLogos]
        push dword [byte eax+02Ch]
        call ConvertArtKeepPos
        add esp, byte 4
        push dword [dword ebx+LinkSetupNames]
        call SetDrawTarget
        add esp, byte 4
        cmp dword [LinkGameActive], byte 0
        je short .57
        call ClearLinkAbort
        test eax, eax
        je short .56
        mov eax, dword [LinkPlayerCount]
        sar eax, 1
        cmp esi, eax
        jl short .57
.56:
        call ClearLinkAbort
        test eax, eax
        jne short .58
        mov eax, dword [LinkPlayerCount]
        sar eax, 1
        cmp esi, eax
        jl short .58
.57:
        imul edx, esi, byte 21h
        mov eax, dword [gameopts]
        add eax, byte 5
        mov ebx, 1
        add eax, edx
        xor ecx, ecx
        inc eax
        inc eax
        xor edx, edx
        jmp short .59
.58:
        mov eax, 0F7h
        mov ebx, 1
        xor ecx, ecx
        xor edx, edx
        call GetLangText
.59:
        call DrawLinkStatusText
        push dword [nosplit esi*4+LinkSetupLogos]
        call SetDrawTarget
        add esp, byte 4
        cmp dword [LinkGameActive], byte 0
        je short .61
        call ClearLinkAbort
        test eax, eax
        je short .60
        mov eax, dword [LinkPlayerCount]
        sar eax, 1
        cmp esi, eax
        jl short .61
.60:
        call ClearLinkAbort
        test eax, eax
        jne short .62
        mov eax, dword [LinkPlayerCount]
        sar eax, 1
        cmp esi, eax
        jl short .62
.61:
        imul edx, esi, byte 21h
        mov eax, dword [gameopts]
        add eax, byte 5
        mov ecx, 1
        add eax, edx
        mov ebx, ecx
        inc eax
        inc eax
        xor edx, edx
        jmp short .63
.62:
        mov eax, 0F7h
        mov ecx, 1
        xor edx, edx
        mov ebx, ecx
        call GetLangText
.63:
        call DrawLinkStatusText
        push dword [byte ebp-08h]
        call SetDrawTarget
        add esp, byte 4
        mov eax, dword [byte ebp-0Ch]
        push byte 20h
        movsx eax, word [byte eax+06h]
        push eax
        mov eax, dword [byte ebp-0Ch]
        movsx eax, word [byte eax+04h]
        push eax
        call CreateBitmap
        mov edx, eax
        imul eax, esi, byte 7
        mov dword [dword eax+LinkSetupItemShape], edx
        mov ebx, dword [dword eax+LinkSetupItemShape]
        movsx edx, word [dword eax+LinkSetupItemType]
        mov ebx, dword [byte ebx+02Ch]
        mov dx, word [nosplit edx*2+LinkSetupItemX]
        mov word [byte ebx+0Ch], dx
        mov ebx, dword [LinkSetupShapeFile]
        lea edx, [esi+esi]
        add ebx, edx
        mov edx, dword [dword eax+LinkSetupItemShape]
        mov edx, dword [byte edx+02Ch]
        mov bx, word [ebx]
        mov word [byte edx+0Eh], bx
        add esp, byte 0Ch
        mov eax, dword [dword eax+LinkSetupItemShape]
        mov dword [byte ebp-014h], 0
        push dword [byte eax+02Ch]
        lea edi, [esi+esi*2]
        call ConvertArtKeepPos
        add esp, byte 4
.64:
        imul eax, edi, byte 52h
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+02Eh], 0
        cmp dword [byte ebp-014h], byte 1
        jne near .65
        imul edx, esi, byte 7
        cmp word [dword edx+LinkSetupItemType], byte 1
        je near .65
        mov ecx, dword [LinkSetupItems]
        mov ebx, dword [nosplit esi*4+LinkSetupNames]
        add ecx, eax
        mov ebx, dword [byte ebx+02Ch]
        mov dword [byte ecx+01Ah], ebx
        mov edx, dword [nosplit esi*4+LinkSetupLogos]
        mov ebx, dword [LinkSetupItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte ebx+eax+01Eh], edx
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+02Eh], 301h
        mov edx, dword [LinkSetupItems]
        mov ebx, dword [byte edx+eax+01Ah]
        movsx ebx, word [byte ebx+0Ch]
        mov dword [byte edx+eax+026h], ebx
        mov edx, dword [LinkSetupItems]
        mov ebx, dword [byte edx+eax+01Ah]
        movsx ebx, word [byte ebx+0Eh]
        mov dword [byte edx+eax+02Ah], ebx
        mov ebx, edi
        mov ecx, dword [LinkSetupSlots]
        shl ebx, 6
        add ecx, ebx
        mov edx, dword [LinkSetupItems]
        mov dword [byte ebp-020h], ecx
        mov ecx, dword [byte edx+eax+026h]
        mov edx, dword [byte ebp-020h]
        mov dword [edx], ecx
        mov ecx, dword [LinkSetupSlots]
        add ecx, ebx
        mov edx, dword [LinkSetupItems]
        mov dword [byte ebp-020h], ecx
        mov ecx, dword [byte edx+eax+02Ah]
        mov edx, dword [byte ebp-020h]
        mov dword [byte edx+04h], ecx
        mov edx, dword [LinkSetupItems]
        mov edx, dword [byte edx+eax+01Ah]
        movsx edx, word [byte edx+04h]
        mov dword [byte ebp-020h], edx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [edx+ebx]
        add ecx, dword [byte ebp-020h]
        mov dword [byte edx+ebx+08h], ecx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [byte edx+ebx+04h]
        mov dword [byte edx+ebx+0Ch], ecx
        mov edx, dword [LinkSetupSlots]
        mov ecx, dword [byte edx+ebx+08h]
        mov dword [byte edx+ebx+010h], ecx
        mov edx, dword [LinkSetupItems]
        mov eax, dword [byte edx+eax+01Ah]
        movsx edx, word [byte eax+06h]
        mov eax, dword [LinkSetupSlots]
        add edx, dword [byte ebx+eax+0Ch]
        mov dword [byte ebx+eax+014h], edx
        mov eax, dword [LinkSetupSlots]
        mov edx, dword [ebx+eax]
        mov dword [byte ebx+eax+018h], edx
        mov eax, dword [LinkSetupSlots]
        add ebx, eax
        mov eax, dword [byte ebx+014h]
        mov dword [byte ebx+01Ch], eax
        jmp near .68
.65:
        imul eax, esi, byte 7
        imul ebx, edi, byte 52h
        movsx edx, word [dword eax+LinkSetupItemType]
        cmp edx, dword [byte ebp-014h]
        jne short .66
        movzx edx, byte [dword eax+LinkSetupItemFlags]
        mov eax, esi
        call ResetLinkSetup
        mov edx, eax
        mov eax, dword [LinkSetupItems]
        mov dword [byte ebx+eax+01Ah], edx
        mov eax, dword [LinkSetupItems]
        or byte [byte ebx+eax+032h], 2
        mov eax, dword [LinkSetupItems]
        mov dword [byte ebx+eax+046h], DrawLinkSetupStatus
        mov eax, dword [LinkSetupItems]
        mov dword [byte ebx+eax+04Eh], LinkSetupScreen
        jmp short .67
.66:
        mov eax, dword [LinkSetupItems]
        mov dword [byte ebx+eax+01Ah], 0
.67:
        imul edx, edi, byte 52h
        mov dword [byte ebp-020h], edx
        mov edx, dword [LinkSetupItems]
        mov eax, dword [byte ebp-014h]
        add edx, dword [byte ebp-020h]
        movsx ebx, word [nosplit eax*2+LinkSetupItemX]
        mov dword [byte edx+026h], ebx
        mov edx, dword [LinkSetupShapeFile]
        mov ebx, esi
        movsx edx, word [edx+ebx*2]
        mov dword [byte ebp-01Ch], edx
        mov edx, dword [LinkSetupItems]
        add edx, dword [byte ebp-020h]
        mov ecx, dword [byte ebp-01Ch]
        mov dword [byte edx+02Ah], ecx
        movsx ecx, word [nosplit eax*2+LinkSetupItemX]
        mov eax, edi
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        mov dword [edx+eax], ecx
        mov edx, dword [LinkSetupShapeFile]
        movsx ebx, word [edx+ebx*2]
        mov edx, dword [LinkSetupSlots]
        mov dword [byte edx+eax+04h], ebx
        imul edx, esi, byte 7
        mov ebx, dword [dword edx+LinkSetupItemShape]
        mov ebx, dword [byte ebx+02Ch]
        movsx ebx, word [byte ebx+04h]
        mov dword [byte ebp-01Ch], ebx
        mov ebx, dword [LinkSetupSlots]
        mov ecx, dword [ebx+eax]
        add ecx, dword [byte ebp-01Ch]
        mov dword [byte ebx+eax+08h], ecx
        mov ebx, dword [LinkSetupSlots]
        mov ecx, dword [byte ebx+eax+04h]
        mov dword [byte ebx+eax+0Ch], ecx
        mov ebx, dword [LinkSetupSlots]
        mov ecx, dword [byte ebx+eax+08h]
        mov dword [byte ebx+eax+010h], ecx
        mov edx, dword [dword edx+LinkSetupItemShape]
        mov edx, dword [byte edx+02Ch]
        mov ebx, dword [LinkSetupSlots]
        movsx edx, word [byte edx+06h]
        add edx, dword [byte ebx+eax+0Ch]
        mov dword [byte ebx+eax+014h], edx
        mov ebx, dword [LinkSetupSlots]
        mov edx, dword [ebx+eax]
        mov dword [byte ebx+eax+018h], edx
        mov edx, dword [LinkSetupSlots]
        add eax, edx
        mov edx, dword [byte eax+014h]
        mov dword [byte eax+01Ch], edx
.68:
        imul edx, edi, byte 52h
        mov eax, dword [LinkSetupItems]
        mov dword [byte edx+eax+010h], 4
        mov eax, edi
        mov ebx, dword [LinkSetupSlots]
        shl eax, 6
        add ebx, eax
        mov eax, dword [LinkSetupItems]
        mov dword [byte edx+eax+014h], ebx
        mov eax, dword [LinkSetupItems]
        add eax, edx
        cmp dword [byte eax+01Ah], byte 0
        je short .69
        push dword [byte eax+02Ah]
        push dword [byte eax+026h]
        push dword [byte eax+01Ah]
        call DrawArt
        add esp, byte 0Ch
.69:
        imul ebx, edi, byte 52h
        mov eax, dword [LinkSetupItems]
        movsx edx, word [LinkSetupItemX]
        mov dword [byte ebx+eax+036h], edx
        mov eax, dword [LinkSetupShapeFile]
        mov edx, esi
        movsx edx, word [eax+edx*2]
        mov eax, dword [LinkSetupItems]
        mov dword [byte ebx+eax+03Ah], edx
        imul eax, esi, byte 7
        mov edx, dword [dword eax+LinkSetupItemShape]
        mov edx, dword [byte edx+02Ch]
        movsx ecx, word [LinkSetupStatusX]
        movsx edx, word [byte edx+04h]
        add ecx, edx
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+ebx+03Eh], ecx
        mov eax, dword [dword eax+LinkSetupItemShape]
        mov eax, dword [byte eax+02Ch]
        movsx edx, word [byte eax+06h]
        mov eax, dword [LinkSetupItems]
        add edx, dword [byte ebx+eax+03Ah]
        mov dword [byte ebx+eax+042h], edx
        cmp dword [LinkGameActive], byte 0
        je short .73
        call ClearLinkAbort
        test eax, eax
        je short .71
        cmp esi, byte 4
        jl short .72
.70:
        mov eax, dword [LinkSetupItems]
        mov word [byte ebx+eax+018h], 2
        jmp short .73
.71:
        cmp esi, byte 4
        jl short .70
.72:
        mov eax, dword [LinkSetupItems]
        mov word [byte ebx+eax+018h], 1
.73:
        inc dword [byte ebp-014h]
        inc edi
        cmp dword [byte ebp-014h], byte 3
        jl near .64
        inc esi
.74:
        cmp esi, dword [LinkPlayerCount]
        jl near .51
        push str_EL01
        push dword [LinkLogoFile]
        call FindShape
        imul ebx, dword [LinkPlayerCount], dword 0F6h
        add esp, byte 8
        mov edx, eax
        mov eax, dword [LinkSetupItems]
        push str_EL02
        mov dword [byte ebx+eax+01Ah], edx
        push dword [LinkLogoFile]
        call FindShape
        mov edx, eax
        imul eax, dword [LinkPlayerCount], dword 0F6h
        mov ebx, dword [LinkSetupItems]
        mov dword [byte ebx+eax+01Eh], edx
        imul edx, dword [LinkPlayerCount], dword 0F6h
        mov eax, dword [LinkSetupItems]
        mov dword [byte edx+eax+026h], 29h
        imul eax, dword [LinkPlayerCount], dword 0F6h
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+02Ah], 8Bh
        imul edx, dword [LinkPlayerCount], dword 0C0h
        imul ebx, dword [LinkPlayerCount], dword 0F6h
        mov eax, dword [LinkSetupSlots]
        add edx, eax
        mov eax, dword [LinkSetupItems]
        mov dword [byte ebx+eax+014h], edx
        imul edx, dword [LinkPlayerCount], dword 0F6h
        mov eax, dword [LinkSetupItems]
        mov dword [byte edx+eax+010h], 4
        imul edx, dword [LinkPlayerCount], dword 0F6h
        mov eax, dword [LinkSetupItems]
        add edx, eax
        imul eax, dword [LinkPlayerCount], dword 0C0h
        mov ebx, dword [LinkSetupSlots]
        mov edx, dword [byte edx+026h]
        mov dword [ebx+eax], edx
        imul eax, dword [LinkPlayerCount], dword 0F6h
        imul ebx, dword [LinkPlayerCount], dword 0C0h
        mov edx, dword [LinkSetupItems]
        add eax, edx
        mov edx, dword [LinkSetupSlots]
        mov eax, dword [byte eax+02Ah]
        mov dword [byte edx+ebx+04h], eax
        imul eax, dword [LinkPlayerCount], dword 0F6h
        mov edx, dword [LinkSetupItems]
        mov eax, dword [byte edx+eax+01Ah]
        movsx ebx, word [byte eax+04h]
        imul eax, dword [LinkPlayerCount], dword 0C0h
        mov edx, dword [LinkSetupSlots]
        add eax, edx
        mov edx, dword [eax]
        add edx, ebx
        mov dword [byte eax+08h], edx
        imul eax, dword [LinkPlayerCount], dword 0C0h
        mov edx, dword [LinkSetupSlots]
        add eax, edx
        mov edx, dword [byte eax+04h]
        add esp, byte 8
        mov dword [byte eax+0Ch], edx
        imul eax, dword [LinkPlayerCount], dword 0C0h
        mov edx, dword [LinkSetupSlots]
        add eax, edx
        mov edx, dword [byte eax+08h]
        mov dword [byte eax+010h], edx
        imul edx, dword [LinkPlayerCount], dword 0F6h
        imul ebx, dword [LinkPlayerCount], dword 0C0h
        mov eax, dword [LinkSetupItems]
        mov edx, dword [byte edx+eax+01Ah]
        mov eax, dword [LinkSetupSlots]
        movsx edx, word [byte edx+06h]
        add edx, dword [byte ebx+eax+0Ch]
        mov dword [byte ebx+eax+014h], edx
        imul eax, dword [LinkPlayerCount], dword 0C0h
        mov edx, dword [LinkSetupSlots]
        add eax, edx
        mov edx, dword [eax]
        mov dword [byte eax+018h], edx
        imul eax, dword [LinkPlayerCount], dword 0C0h
        mov edx, dword [LinkSetupSlots]
        add eax, edx
        mov edx, dword [byte eax+014h]
        push str_EL01
        mov dword [byte eax+01Ch], edx
        push dword [LinkLogoFile]
        call FindShape
        mov edx, eax
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        imul eax, byte 52h
        add esp, byte 8
        mov ebx, dword [LinkSetupItems]
        push str_EL02
        mov dword [byte ebx+eax+01Ah], edx
        push dword [LinkLogoFile]
        call FindShape
        mov edx, eax
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        imul eax, byte 52h
        mov ebx, dword [LinkSetupItems]
        mov dword [byte ebx+eax+01Eh], edx
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        imul eax, byte 52h
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+026h], 1DDh
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        imul eax, byte 52h
        mov edx, dword [LinkSetupItems]
        add esp, byte 8
        mov dword [byte edx+eax+02Ah], 8Bh
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, eax
        inc eax
        imul eax, byte 52h
        shl edx, 6
        mov ebx, dword [LinkSetupSlots]
        add edx, byte 40h
        add ebx, edx
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+014h], ebx
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        imul eax, byte 52h
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+010h], 4
        imul eax, dword [LinkPlayerCount], byte 3
        lea edx, [byte eax+01h]
        imul ebx, edx, byte 52h
        mov edx, dword [LinkSetupItems]
        add edx, ebx
        mov ebx, eax
        mov eax, dword [LinkSetupSlots]
        shl ebx, 6
        mov edx, dword [byte edx+026h]
        mov dword [byte ebx+eax+040h], edx
        imul edx, dword [LinkPlayerCount], byte 3
        lea eax, [byte edx+01h]
        imul eax, byte 52h
        mov ebx, dword [LinkSetupItems]
        add eax, ebx
        mov ebx, dword [LinkSetupSlots]
        shl edx, 6
        mov eax, dword [byte eax+02Ah]
        mov dword [byte edx+ebx+044h], eax
        imul edx, dword [LinkPlayerCount], byte 3
        lea eax, [byte edx+01h]
        imul eax, byte 52h
        mov ebx, dword [LinkSetupItems]
        mov eax, dword [byte ebx+eax+01Ah]
        shl edx, 6
        movsx ebx, word [byte eax+04h]
        mov eax, dword [LinkSetupSlots]
        add ebx, dword [byte edx+eax+040h]
        mov dword [byte edx+eax+048h], ebx
        imul edx, dword [LinkPlayerCount], byte 3
        mov eax, dword [LinkSetupSlots]
        shl edx, 6
        add eax, edx
        mov edx, dword [byte eax+044h]
        mov dword [byte eax+04Ch], edx
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        add eax, edx
        mov edx, dword [byte eax+048h]
        mov dword [byte eax+050h], edx
        imul edx, dword [LinkPlayerCount], byte 3
        lea eax, [byte edx+01h]
        imul eax, byte 52h
        mov ebx, dword [LinkSetupItems]
        mov eax, dword [byte ebx+eax+01Ah]
        movsx ebx, word [byte eax+06h]
        mov eax, edx
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        add eax, edx
        mov edx, dword [byte eax+04Ch]
        add edx, ebx
        mov dword [byte eax+054h], edx
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        add eax, edx
        mov edx, dword [byte eax+040h]
        mov dword [byte eax+058h], edx
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        add eax, edx
        mov edx, dword [byte eax+054h]
        mov dword [byte eax+05Ch], edx
        call DrawLinkSetupItem
        imul eax, dword [LinkPlayerCount], dword 0F6h
        mov edx, dword [LinkSetupItems]
        push dword [byte edx+eax+02Ah]
        push dword [byte edx+eax+026h]
        push dword [byte edx+eax+01Ah]
        call DrawArt
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        imul edx, eax, byte 52h
        add esp, byte 0Ch
        mov eax, dword [LinkSetupItems]
        push dword [byte edx+eax+02Ah]
        push dword [byte edx+eax+026h]
        push dword [byte edx+eax+01Ah]
        call DrawArt
        mov eax, dword [byte ebp-08h]
        mov eax, dword [byte eax+02Ch]
        add esp, byte 0Ch
        mov ebx, eax
        mov edx, eax
        call DrawScreenBackground
        push dword [byte ebp-08h]
        call SetDrawTarget
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        inc eax
        imul eax, byte 52h
        mov esi, ScreenTitleItem
        mov edi, dword [LinkSetupItems]
        mov ecx, 52h
        add edi, eax
        rep movsb
        imul edx, dword [LinkPlayerCount], byte 3
        inc edx
        inc edx
        imul ebx, edx, byte 52h
        mov eax, dword [LinkSetupItems]
        mov dword [ebx+eax], edx
        imul eax, dword [LinkPlayerCount], byte 3
        inc eax
        inc eax
        imul eax, byte 52h
        add esp, byte 4
        mov edx, dword [LinkSetupItems]
        push dword [byte edx+eax+02Ah]
        push dword [byte edx+eax+026h]
        push dword [byte edx+eax+01Ah]
        call DrawArt
        imul eax, dword [LinkPlayerCount], byte 3
        add eax, byte 3
        imul eax, byte 52h
        mov esi, BlankMenuItem
        mov edi, dword [LinkSetupItems]
        mov ecx, 52h
        add edi, eax
        rep movsb
        imul edx, dword [LinkPlayerCount], byte 3
        add edx, byte 3
        imul ebx, edx, byte 52h
        mov eax, dword [LinkSetupItems]
        mov dword [ebx+eax], edx
        imul eax, dword [LinkPlayerCount], byte 3
        add eax, byte 3
        imul eax, byte 52h
        add esp, byte 0Ch
        mov edx, dword [LinkSetupItems]
        push dword [byte edx+eax+02Ah]
        push dword [byte edx+eax+026h]
        push dword [byte edx+eax+01Ah]
        call DrawArt
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, eax
        add eax, byte 4
        imul eax, byte 52h
        shl edx, 6
        mov ebx, dword [LinkSetupSlots]
        add edx, 100h
        add ebx, edx
        mov edx, dword [LinkSetupItems]
        add esp, byte 0Ch
        mov dword [byte edx+eax+014h], ebx
        imul eax, dword [LinkPlayerCount], byte 3
        add eax, byte 4
        imul eax, byte 52h
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+010h], 4
        imul eax, dword [LinkPlayerCount], byte 3
        add eax, byte 4
        imul eax, byte 52h
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+02Eh], 0
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        mov dword [dword edx+eax+0100h], 5Ch
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        mov dword [dword edx+eax+0104h], 102h
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        mov dword [dword edx+eax+0108h], 74h
        imul edx, dword [LinkPlayerCount], byte 3
        mov eax, dword [LinkSetupSlots]
        shl edx, 6
        mov dword [dword edx+eax+010Ch], 102h
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        mov dword [dword edx+eax+0110h], 74h
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        mov dword [dword edx+eax+0114h], 11Ah
        imul edx, dword [LinkPlayerCount], byte 3
        mov eax, dword [LinkSetupSlots]
        shl edx, 6
        mov dword [dword edx+eax+0118h], 5Ch
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        mov dword [dword edx+eax+011Ch], 11Ah
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, eax
        add eax, byte 5
        imul eax, byte 52h
        shl edx, 6
        mov ebx, dword [LinkSetupSlots]
        add edx, 140h
        add ebx, edx
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+014h], ebx
        imul eax, dword [LinkPlayerCount], byte 3
        add eax, byte 5
        imul edx, eax, byte 52h
        mov eax, dword [LinkSetupItems]
        mov dword [byte edx+eax+010h], 4
        imul eax, dword [LinkPlayerCount], byte 3
        add eax, byte 5
        imul eax, byte 52h
        mov edx, dword [LinkSetupItems]
        mov dword [byte edx+eax+02Eh], 0
        imul edx, dword [LinkPlayerCount], byte 3
        mov eax, dword [LinkSetupSlots]
        shl edx, 6
        mov dword [dword edx+eax+0140h], 20Ah
        imul edx, dword [LinkPlayerCount], byte 3
        mov eax, dword [LinkSetupSlots]
        shl edx, 6
        mov dword [dword edx+eax+0144h], 102h
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        mov dword [dword edx+eax+0148h], 222h
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        mov dword [dword edx+eax+014Ch], 102h
        imul edx, dword [LinkPlayerCount], byte 3
        mov eax, dword [LinkSetupSlots]
        shl edx, 6
        mov dword [dword edx+eax+0150h], 222h
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        mov dword [dword edx+eax+0154h], 11Ah
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        mov dword [dword edx+eax+0158h], 20Ah
        imul eax, dword [LinkPlayerCount], byte 3
        mov edx, dword [LinkSetupSlots]
        shl eax, 6
        mov dword [dword edx+eax+015Ch], 11Ah
        cmp dword [LinkGameActive], byte 0
        je short .75
        imul eax, dword [LinkPlayerCount], byte 3
        add eax, byte 6
        imul eax, byte 52h
        mov ecx, 52h
        mov edi, dword [LinkSetupItems]
        mov esi, ScreenFrameItem
        add edi, eax
        rep movsb
        imul edx, dword [LinkPlayerCount], byte 3
        add edx, byte 6
        imul ebx, edx, byte 52h
        mov eax, dword [LinkSetupItems]
        mov dword [ebx+eax], edx
        imul eax, dword [LinkPlayerCount], byte 3
        add eax, byte 6
        imul eax, byte 52h
        mov edx, dword [LinkSetupItems]
        push dword [byte edx+eax+02Ah]
        push dword [byte edx+eax+026h]
        push dword [byte edx+eax+01Ah]
        call DrawArt
        add esp, byte 0Ch
.75:
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        mov eax, dword [byte ebp-08h]
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte eax+02Ch]
        call WipeScreen
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        cmp dword [LinkScreensDone], byte 0
        je short .76
        mov dword [LinkScreensDone], 0
        call PlayArenaAnnouncement
.76:
        push byte 3
        lea eax, [byte ebp-024h]
        push eax
        imul eax, dword [LinkPlayerCount], byte 3
        mov ecx, LinkSetupSound
        mov ebx, 0FFFFFFFFh
        add eax, byte 6
        mov edx, dword [LinkSetupItems]
        add eax, dword [LinkGameActive]
        call RunMenu
        mov ebx, eax
        imul eax, dword [LinkPlayerCount], byte 3
        cmp eax, dword [byte ebp-024h]
        jle short .79
        mov eax, dword [byte ebp-024h]
        mov ecx, 3
        cdq
        idiv ecx
        cmp edx, byte 1
        jne near .88
        mov eax, dword [byte ebp-024h]
        cdq
        idiv ecx
        imul eax, byte 7
        cmp word [dword eax+LinkSetupItemType], byte 1
        je near .88
        cmp dword [LinkGameActive], byte 0
        je short .77
        cmp ebx, byte 2
        jne short .78
.77:
        mov eax, dword [byte ebp-024h]
        mov ebx, 3
        cdq
        idiv ebx
        call LinkGameSetup
        call LinkSyncMenu
        jmp near .88
.78:
        mov eax, 228h
        call GetLangText
        call LinkSyncScreen
        jmp near .88
.79:
        imul edx, dword [byte ebp-024h], byte 52h
        cmp eax, dword [byte ebp-024h]
        jne short .81
        mov eax, dword [LinkSetupItems]
        add eax, edx
        mov dword [byte ebp-010h], 0Fh
.80:
        call ShowPopupScreen
        jmp near .88
.81:
        lea ebx, [byte eax+01h]
        cmp ebx, dword [byte ebp-024h]
        jne short .82
        mov eax, dword [LinkSetupItems]
        add eax, edx
        mov dword [byte ebp-010h], 10h
        jmp short .80
.82:
        lea edx, [byte eax+02h]
        cmp edx, dword [byte ebp-024h]
        jne short .83
        call ShowScreen
        mov dword [byte ebp-010h], 1Ah
        jmp short .88
.83:
        lea edx, [byte eax+03h]
        cmp edx, dword [byte ebp-024h]
        jne short .84
        call FadeInScreen
        mov dword [byte ebp-010h], 13h
        jmp short .88
.84:
        lea edx, [byte eax+04h]
        cmp edx, dword [byte ebp-024h]
        jne short .86
        xor eax, eax
.85:
        call LinkSideFlags
        test eax, eax
        sete al
        movzx eax, al
        add eax, 208h
        call PlaySfx
        jmp short .88
.86:
        lea edx, [byte eax+05h]
        cmp edx, dword [byte ebp-024h]
        jne short .87
        mov eax, 1
        jmp short .85
.87:
        cmp dword [LinkGameActive], byte 0
        je short .88
        add eax, byte 6
        cmp eax, dword [byte ebp-024h]
        jne short .88
        call ExitScreen
.88:
        cmp dword [byte ebp-010h], byte 0FFFFFFFFh
        je near .76
        cmp word [LinkSetupSoundOn], byte 0
        je short .89
        call StopAllSfx
        mov word [LinkSetupSoundOn], 0
.89:
        cmp dword [byte ebp-010h], byte 1Ah
        je short .92
        xor esi, esi
        jmp short .91
.90:
        imul eax, esi, byte 7
        inc esi
        mov al, byte [dword eax+LinkSetupItemFlags]
        mov byte [byte esi+ebp-02Dh], al
.91:
        cmp esi, dword [LinkPlayerCount]
        jl short .90
        mov eax, dword [gameopts]
        push byte 8
        add eax, 10Dh
        push eax
        lea eax, [byte ebp-02Ch]
        push eax
        call bcopy
        add esp, byte 0Ch
        lea eax, [byte ebp-02Ch]
        call InitSlotTable
.92:
        call PresentScreen
        push dword [byte ebp-08h]
        call FreeBitmap
        xor esi, esi
        jmp short .97
.93:
        imul eax, esi, byte 7
        cmp dword [dword eax+LinkSetupItemShape], byte 0
        je short .94
        push dword [dword eax+LinkSetupItemShape]
        call FreeBitmap
        add esp, byte 4
.94:
        xor edi, edi
        jmp short .96
.95:
        imul eax, esi
        mov edx, dword [LinkSetupBuffer]
        add eax, edi
        push dword [edx+eax*4]
        call FreeBitmap
        inc edi
        add esp, byte 4
.96:
        movsx eax, word [LinkSetupItemCount]
        cmp edi, eax
        jl short .95
        push dword [nosplit esi*4+LinkSetupArt]
        call FreeBitmap
        add esp, byte 4
        push dword [nosplit esi*4+LinkSetupNames]
        call FreeBitmap
        add esp, byte 4
        push dword [nosplit esi*4+LinkSetupLogos]
        inc esi
        call FreeBitmap
.97:
        add esp, byte 4
        cmp esi, dword [LinkPlayerCount]
        jl short .93
        push dword [LinkSetupBuffer]
        call FreeMemBlock
        add esp, byte 4
        push dword [LinkSetupItems]
        call FreeMemBlock
        add esp, byte 4
        push dword [LinkSetupSlots]
        call FreeMemBlock
        add esp, byte 4
        call SetNormalText
        push dword [LinkLogoFile]
        call FreeMemBlock
        add esp, byte 4
        push dword [LinkShapeFile]
        call FreeMemBlock
        add esp, byte 4
        call ResetStreamAudio
        cmp byte [FrontMusicOn], 0
        je short .98
        call LoadFrontEndSfx
.98:
        xor esi, esi
.99:
        mov eax, dword [gameopts]
        mov al, byte [dword esi+eax+010Dh]
        and al, 7
        movzx edi, al
        cmp edi, byte 5
        ja short RunLinkGameScreens_1971
        jmp dword [nosplit cs:edi*4+LinkControlRestoreJumpTable]
RunLinkGameScreens_1971:
        inc esi
        cmp esi, byte 8
        jl short RunLinkGameScreens_112.99
        mov eax, dword [byte ebp-010h]
        jmp near LinkGameSetup_8CA
