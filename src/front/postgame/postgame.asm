; Arena announcement and the post-game screen.
bits 32
%include "hockey.inc"
section s_A64FC progbits alloc exec nowrite align=1
extern AllStarArena, AutoLineData, BlankMenuItem, BlitArt, ClearScreen, ClearThreeStars, ConvertArtXY, CreateBitmap
extern CreateBitmapDefault, DrawArt, DrawFrameBox, DrawPortrait, DrawScreenBackground, DrawShadedLogo, DrawShadowBox, DrawShapeAtOwnPos
extern DrawShapeCore, DrawThreeStarStats, DrawThreeStarStats_4A8, ExitScreen, FadeInScreen, FindShape, FindShapeQuiet, FreeBitmap
extern FreeLogoArt, FreeMemBlock, GameOptionFlags, GameSettings, GoldStarShapes, homelines, InitListBox, InitMenuItems
extern InitShapeListBox, IsAllStarDay, LinkGameSetup_8CB, LoadDataFile, LoadTeamLogo, LoadThreeStarsArt, MakeColor, memmove_
extern OpenArtArchive, OpenDataLibrary, OpenResourceArchive, PaEvent, PickThreeStars, PlayoffTeamNames, PlayoffTeams, PlayoffUserIndex
extern PostGameArtFile, PostGameLayer, PostGameShapeFile, PresentScreen, ProjectModelBounds, Random32, RunMenu, ScreenFrameItem
extern SeasonActive, SecondsToSamples, ServiceIdle, SetDrawTarget, SetNormalText, SetPlayedTeams, SetScreenTarget, SetTextColor
extern ShadeShape, ShadowShape, ShowPopupScreen, StarFrameShapes, str_BTM1, str_BTM2, str_FART2, str_FLR1
extern str_FLR2, str_GS00, str_GS01, str_MNTR, str_NHL02, str_NHLP, str_NOFACEFSH2, str_RM00
extern str_RM01, str_T3S2, strcpy_, ThreeStarsChoice, ThreeStarsData, ThreeStarsLayers, ThreeStarsPos, ThreeStarsTeam
extern ThreeStarsTimer, WaitSoundTime, WipeScreen
global PlayArenaAnnouncement, PostGameScreenJumpTable, PostGameScreen, PostGameScreen_B39, PostGameScreen_B4E, PostGameScreen_B55, PostGameScreen_B71
;-----------------------------------------------------------------------------
; PlayArenaAnnouncement                           A64FC  97 PC, low confidence
; Plays an arena announcement
;-----------------------------------------------------------------------------
PlayArenaAnnouncement:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        and eax, 0FC000h
        movsx esi, word [AllStarArena]
        cmp eax, 68000h
        je short .1
        cmp eax, 6C000h
        jne short .4
.1:
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        and eax, 3F00000h
        cmp eax, 1A00000h
        je short .2
        cmp eax, 1B00000h
        jne short .4
.2:
        mov eax, dword [GameOptionFlags]
        mov edx, dword [byte eax+01h]
        shl edx, 0Ch
        mov eax, dword [byte eax+01h]
        shr edx, 1Ah
        shl eax, 6
        push edx
        shr eax, 1Ah
        push eax
        push dword 200h
.3:
        push byte 0
        jmp near .18
.4:
        test byte [GameSettings], 70h
        jne short .5
        mov eax, dword [GameOptionFlags]
        mov edx, dword [byte eax+01h]
        shl edx, 0Ch
        mov eax, dword [byte eax+01h]
        shr edx, 1Ah
        shl eax, 6
        push edx
        shr eax, 1Ah
        push eax
        push byte 1
        jmp short .3
.5:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .6
        cmp dword [SeasonActive], byte 0
        jne short .6
        mov eax, dword [GameOptionFlags]
        mov edx, dword [byte eax+01h]
        shl edx, 0Ch
        mov eax, dword [byte eax+01h]
        shr edx, 1Ah
        shl eax, 6
        push edx
        shr eax, 1Ah
        push eax
        push byte 2
        jmp short .3
.6:
        movzx ecx, byte [PlayoffUserIndex]
        xor eax, eax
.7:
        mov edx, dword [nosplit eax*4+PlayoffTeams]
        cmp edx, dword [nosplit ecx*4+PlayoffTeams]
        jne short .8
        mov ebx, eax
.8:
        inc eax
        cmp eax, byte 1Fh
        jl short .7
        cmp ebx, byte 8
        jge short .9
        mov ecx, 4
        jmp short .15
.9:
        cmp ebx, byte 10h
        jge short .10
        mov ecx, 20h
        jmp short .15
.10:
        cmp ebx, byte 14h
        jge short .11
        mov ecx, 8
        jmp short .15
.11:
        cmp ebx, byte 18h
        jge short .12
        mov ecx, 40h
        jmp short .15
.12:
        cmp ebx, byte 1Ah
        jge short .13
        mov ecx, 10h
        jmp short .15
.13:
        cmp ebx, byte 1Ch
        jge short .14
        mov ecx, 80h
        jmp short .15
.14:
        mov ecx, 100h
.15:
        mov eax, ebx
        mov edi, 2
        cdq
        idiv edi
        test edx, edx
        je short .16
        lea eax, [byte ebx-01h]
        jmp short .17
.16:
        lea eax, [byte ebx+01h]
.17:
        mov edi, dword [nosplit eax*4+PlayoffTeamNames]
        mov eax, dword [GameOptionFlags]
        mov edx, dword [byte eax+01h]
        shl edx, 0Ch
        mov eax, dword [byte eax+01h]
        shr edx, 1Ah
        shl eax, 6
        push edx
        shr eax, 1Ah
        mov ebx, dword [nosplit ebx*4+PlayoffTeamNames]
        push eax
        lea eax, [ebx+edi]
        push ecx
        inc eax
        push eax
.18:
        push esi
        push dword 0B0000003h
        call PaEvent
        add esp, byte 18h
        jmp near LinkGameSetup_8CB
PostGameScreenJumpTable:                        ; jump table for the switch cases of PostGameScreen
        dd PostGameScreen_B39
        dd PostGameScreen_B4E
        dd PostGameScreen_B55
        dd PostGameScreen_B71
;-----------------------------------------------------------------------------
; PostGameScreen                                  A6690  97 PC, low confidence
; The post-game screen (NHL0 / NHLP, FLR1/2, T3S2, GS00/GS01, RM00/RM01),
; alternating with GameStatsScreen
;-----------------------------------------------------------------------------
PostGameScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 584h
        mov eax, esp
        mov edx, 0FFFFFFFFh
        mov ebx, 4
        mov dword [ThreeStarsTimer], eax
        mov dword [ThreeStarsChoice], edx
        mov edx, esp
        mov eax, 8
        xor ecx, ecx
        call InitMenuItems
        lea eax, [dword esp+0450h]
        mov edx, 1
        mov dword [dword esp+01AAh], ebx
        mov dword [dword esp+01C8h], ecx
        mov dword [dword esp+01FCh], ebx
        mov dword [dword esp+021Ah], ecx
        mov dword [dword esp+024Eh], ebx
        mov dword [dword esp+010Ah], eax
        lea eax, [dword esp+0490h]
        mov dword [dword esp+026Ch], ecx
        mov dword [dword esp+015Ch], eax
        lea eax, [dword esp+04D0h]
        mov word [dword esp+01B2h], dx
        mov dword [dword esp+01AEh], eax
        lea eax, [dword esp+04F0h]
        mov word [dword esp+0204h], dx
        mov dword [dword esp+0200h], eax
        lea eax, [dword esp+0510h]
        mov word [dword esp+0256h], dx
        mov dword [dword esp+0252h], eax
        call IsAllStarDay
        test eax, eax
        je short .1
        call SetPlayedTeams
.1:
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 3
        call LoadDataFile
        mov dword [PostGameShapeFile], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 2
        call LoadDataFile
        mov dword [PostGameArtFile], eax
        call Random32
        test al, 1
        je short .2
        push str_NHL02
        mov ecx, dword [PostGameShapeFile]
        push ecx
        call FindShape
        add esp, byte 8
        push str_FLR2
        mov esi, dword [PostGameShapeFile]
        push esi
        jmp short .3
.2:
        push str_NHLP
        mov edx, dword [PostGameShapeFile]
        push edx
        call FindShape
        add esp, byte 8
        push str_FLR1
        mov ebx, dword [PostGameShapeFile]
        push ebx
.3:
        mov edi, eax
        call FindShape
        add esp, byte 8
        mov dword [dword esp+0568h], eax
        push str_T3S2
        mov ebp, dword [PostGameArtFile]
        push ebp
        mov ebx, str_GS00
        call FindShape
        add esp, byte 8
        mov ecx, str_GS01
        lea edx, [dword esp+0F6h]
        push str_GS00
        mov esi, eax
        mov eax, dword [PostGameArtFile]
        call InitShapeListBox
        test byte [GameSettings], 70h
        jne near .4
        mov edx, 1
        mov eax, dword [dword esp+0110h]
        mov ecx, dword [dword esp+0110h]
        mov dword [ThreeStarsPos], edx
        mov ebx, 1BDh
        mov eax, dword [byte eax+04h]
        mov edx, 179h
        sar eax, 10h
        mov ecx, dword [byte ecx+02h]
        push eax
        sar ecx, 10h
        lea eax, [dword esp+0FAh]
        call InitListBox
        push str_RM00
        mov ecx, str_RM01
        mov ebx, str_RM00
        lea edx, [dword esp+014Ch]
        mov eax, dword [PostGameArtFile]
        call InitShapeListBox
        mov eax, dword [dword esp+0162h]
        mov ecx, dword [dword esp+0162h]
        mov ebx, 1BDh
        mov eax, dword [byte eax+04h]
        mov edx, 90h
        sar eax, 10h
        mov ecx, dword [byte ecx+02h]
        push eax
        sar ecx, 10h
        lea eax, [dword esp+014Ch]
        call InitListBox
        mov ecx, 4
        mov ebx, str_RM00
        mov edx, StarFrameShapes
        mov eax, dword [PostGameArtFile]
        call LoadThreeStarsArt
        jmp short .5
.4:
        mov eax, dword [dword esp+0110h]
        mov ecx, dword [dword esp+0110h]
        mov ebx, 1BDh
        mov eax, dword [byte eax+04h]
        mov edx, 101h
        sar eax, 10h
        mov ecx, dword [byte ecx+02h]
        push eax
        sar ecx, 10h
        lea eax, [dword esp+0FAh]
        call InitListBox
        xor eax, eax
        mov dword [ThreeStarsPos], eax
.5:
        mov ecx, 4
        mov ebx, str_GS00
        mov edx, GoldStarShapes
        mov eax, dword [PostGameArtFile]
        call LoadThreeStarsArt
        push byte 0
        push dword 1E0h
        push dword 280h
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [PostGameLayer], eax
        call SetDrawTarget
        mov eax, dword [byte esi+04h]
        add esp, byte 4
        sar eax, 10h
        push eax
        push byte 0
        push edi
        call BlitArt
        add esp, byte 0Ch
        push byte 0
        push byte 0
        push esi
        call BlitArt
        add esp, byte 0Ch
        mov eax, 37h
        mov ebx, 18h
        call OpenDataLibrary
        lea eax, [dword esp+0290h]
        lea edx, [dword esp+0290h]
        call PickThreeStars
        mov eax, ThreeStarsData
        mov ebp, 0C4h
        call memmove_
        mov eax, dword [byte esi+04h]
        mov edi, 0FFFFFFFAh
        sar eax, 10h
        mov ecx, 9Ch
        mov dword [dword esp+0580h], eax
        add eax, byte 16h
        mov ebx, 0FFFFFFD4h
        mov dword [dword esp+04F4h], eax
        mov eax, dword [dword esp+0580h]
        mov edx, 1ABh
        add eax, byte 2
        push byte 0
        mov dword [dword esp+0500h], eax
        mov eax, dword [dword esp+0584h]
        mov esi, 0B5h
        add eax, 105h
        push dword 154h
        mov dword [dword esp+050Ch], eax
        mov eax, dword [dword esp+0588h]
        mov dword [dword esp+04F8h], ebx
        add eax, 14Ah
        mov dword [dword esp+0500h], ecx
        mov dword [dword esp+0514h], eax
        mov eax, dword [dword esp+0588h]
        mov dword [dword esp+0510h], edi
        sub eax, byte 0Ah
        mov dword [dword esp+04D8h], ebp
        mov dword [dword esp+04DCh], eax
        mov eax, 1BAh
        mov dword [dword esp+04E8h], edx
        mov dword [dword esp+04E0h], eax
        mov eax, dword [dword esp+04DCh]
        mov ebx, 0D0h
        mov dword [dword esp+04E4h], eax
        mov eax, dword [dword esp+0588h]
        mov ecx, 1E0h
        add eax, 12Ch
        mov edi, 284h
        mov dword [dword esp+04ECh], eax
        mov dword [dword esp+04F4h], eax
        mov eax, dword [dword esp+0504h]
        mov ebp, 1C7h
        mov dword [dword esp+051Ch], eax
        mov eax, dword [dword esp+0588h]
        push dword 118h
        add eax, byte 1Bh
        mov dword [dword esp+050Ch], esi
        mov dword [dword esp+0528h], eax
        mov eax, dword [dword esp+058Ch]
        mov esi, 2BAh
        add eax, 14Bh
        mov dword [dword esp+04F4h], ebx
        mov dword [dword esp+0530h], eax
        mov eax, dword [dword esp+058Ch]
        mov dword [dword esp+051Ch], ecx
        add eax, 106h
        mov dword [dword esp+052Ch], edi
        mov dword [dword esp+0538h], eax
        mov eax, dword [dword esp+058Ch]
        mov dword [dword esp+0534h], ebp
        sub eax, byte 0Fh
        mov dword [dword esp+0524h], esi
        mov dword [dword esp+058Ch], eax
        call CreateBitmap
        add esp, byte 0Ch
        mov ebp, eax
        call SetNormalText
        push byte 0FFFFFFFFh
        call MakeColor
        xor edi, edi
        add esp, byte 4
        xor esi, esi
        xor edx, edx
        call SetTextColor
        mov dword [dword esp+0564h], edx
.6:
        cmp word [dword esp+edi+0294h], byte 0
        jne short .7
        mov eax, AutoLineData
        jmp short .8
.7:
        mov eax, homelines
.8:
        cmp word [dword esp+edi+0296h], byte 0
        jne short .9
        xor edx, edx
        mov dx, word [dword esp+edi+0292h]
        imul edx, dword 125h
        add eax, 0A3h
        jmp short .10
.9:
        xor edx, edx
        mov dx, word [dword esp+edi+0292h]
        imul edx, dword 125h
        add eax, 1D42h
.10:
        add eax, edx
        lea ebx, [byte eax+027h]
        mov dword [dword esp+0574h], eax
        cmp byte [ebx], 0
        jne short .11
        mov edx, str_NOFACEFSH2
        lea eax, [dword esp+0550h]
        lea ebx, [dword esp+0550h]
        call strcpy_
.11:
        cmp byte [ebx], 0
        je near .20
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push byte 0
        push ebx
        call OpenArtArchive
        add esp, byte 8
        mov dword [dword esp+056Ch], eax
        test eax, eax
        je near .20
        push str_FART2
        push eax
        call FindShapeQuiet
        mov ebx, eax
        add esp, byte 8
        test eax, eax
        je near .19
        push byte 0
        mov eax, dword [byte eax+04h]
        push byte 20h
        sar eax, 10h
        push eax
        mov eax, dword [byte ebx+02h]
        sar eax, 10h
        push eax
        call CreateBitmapDefault
        add esp, byte 10h
        push eax
        mov dword [dword esp+0574h], eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        call ClearScreen
        add esp, byte 4
        mov ecx, dword [dword esp+0564h]
        test ecx, ecx
        jne short .12
        push byte 0FFFFFFF6h
        push ecx
        jmp short .13
.12:
        push byte 0
        push byte 0
.13:
        push ebx
        call DrawArt
        add esp, byte 0Ch
        mov eax, dword [PostGameLayer]
        push eax
        call SetDrawTarget
        add esp, byte 4
        mov eax, dword [dword esp+esi+04D0h]
        mov edx, dword [dword esp+esi+04E8h]
        cmp eax, edx
        jge short .14
        mov ebx, eax
        jmp short .15
.14:
        mov ebx, edx
.15:
        push ebp
        mov dword [dword esp+0580h], ebx
        call SetDrawTarget
        add esp, byte 4
        mov eax, dword [dword esp+0580h]
        neg eax
        push eax
        neg ebx
        mov eax, dword [PostGameLayer]
        push ebx
        mov ebx, dword [byte eax+02Ch]
        push ebx
        call BlitArt
        add esp, byte 0Ch
        mov edx, esi
        xor eax, eax
.16:
        mov ebx, dword [dword esp+057Ch]
        mov ecx, dword [dword esp+edx+04D0h]
        sub ecx, ebx
        mov ebx, dword [dword esp+0580h]
        mov dword [dword esp+eax*8+0530h], ecx
        mov ecx, dword [dword esp+edx+04D4h]
        inc eax
        sub ecx, ebx
        add edx, byte 8
        mov dword [dword esp+eax*8+052Ch], ecx
        cmp eax, byte 4
        jl short .16
        lea eax, [dword esp+0530h]
        push eax
        mov eax, dword [dword esp+0574h]
        mov ecx, dword [byte eax+02Ch]
        push ecx
        call ProjectModelBounds
        add esp, byte 8
        mov eax, dword [dword esp+0570h]
        push eax
        call FreeBitmap
        add esp, byte 4
        mov edx, dword [PostGameLayer]
        push edx
        call SetDrawTarget
        add esp, byte 4
        cmp dword [dword esp+0564h], byte 0
        jne short .17
        mov eax, dword [byte ebp+02Ch]
        mov edx, dword [byte eax+04h]
        sar edx, 10h
        push edx
        mov edx, dword [byte eax+02h]
        sar edx, 10h
        push edx
        mov ebx, dword [dword esp+0588h]
        push ebx
        mov ecx, dword [dword esp+0588h]
        push ecx
        mov edx, dword [PostGameLayer]
        mov ebx, 18h
        push byte 0
        mov edx, dword [byte edx+02Ch]
        xor ecx, ecx
        jmp short .18
.17:
        mov eax, dword [byte ebp+02Ch]
        mov edx, dword [byte eax+04h]
        sar edx, 10h
        push edx
        mov edx, dword [byte eax+02h]
        sar edx, 10h
        push edx
        mov ecx, dword [dword esp+0588h]
        push ecx
        mov edx, dword [dword esp+0588h]
        push edx
        mov ebx, 14h
        mov edx, dword [PostGameLayer]
        push byte 0
        xor ecx, ecx
        mov edx, dword [byte edx+02Ch]
.18:
        call ShadeShape
.19:
        mov eax, dword [dword esp+056Ch]
        push eax
        call FreeMemBlock
        add esp, byte 4
.20:
        mov edx, dword [PostGameLayer]
        push edx
        add edi, byte 8
        call SetDrawTarget
        add esp, byte 4
        add esi, byte 20h
        mov al, byte [dword esp+0564h]
        mov ebx, dword [dword esp+0564h]
        mov edx, dword [dword esp+0574h]
        inc ebx
        inc al
        mov dword [dword esp+0564h], ebx
        mov byte [dword edx+0124h], al
        cmp ebx, byte 3
        jl near .6
        push ebp
        call FreeBitmap
        add esp, byte 4
        mov esi, dword [PostGameLayer]
        push esi
        call SetDrawTarget
        add esp, byte 4
        mov edi, dword [dword esp+04E4h]
        mov ebp, dword [dword esp+04ECh]
        sub edi, byte 2Dh
        sub ebp, byte 2Dh
        mov dword [dword esp+04E4h], edi
        mov dword [dword esp+04ECh], ebp
        call ServiceIdle
        push str_BTM1
        mov eax, dword [PostGameShapeFile]
        push eax
        call FindShape
        add esp, byte 8
        push eax
        mov esi, eax
        call DrawShapeAtOwnPos
        mov edx, dword [PostGameLayer]
        add esp, byte 4
        mov eax, esi
        mov ecx, dword [byte esi+0Ch]
        mov ebx, dword [byte esi+0Ah]
        sar ecx, 10h
        sar ebx, 10h
        mov edx, dword [byte edx+02Ch]
        call DrawPortrait
        call ServiceIdle
        push str_BTM2
        mov edx, dword [PostGameShapeFile]
        push edx
        call FindShape
        add esp, byte 8
        push eax
        mov esi, eax
        call DrawShapeAtOwnPos
        mov edx, dword [PostGameLayer]
        add esp, byte 4
        mov eax, esi
        mov ecx, dword [byte esi+0Ch]
        mov ebx, dword [byte esi+0Ah]
        sar ecx, 10h
        sar ebx, 10h
        mov edx, dword [byte edx+02Ch]
        call DrawPortrait
        mov ebx, dword [dword esp+0568h]
        call ServiceIdle
        push ebx
        call DrawShapeAtOwnPos
        mov edx, dword [PostGameLayer]
        add esp, byte 4
        mov ecx, dword [byte ebx+0Ch]
        mov eax, dword [dword esp+0568h]
        sar ecx, 10h
        mov ebx, dword [byte ebx+0Ah]
        mov edx, dword [byte edx+02Ch]
        sar ebx, 10h
        call DrawPortrait
        call ServiceIdle
        mov eax, dword [dword esp+0120h]
        sub eax, byte 11h
        push eax
        mov eax, dword [dword esp+0120h]
        sub eax, byte 0Ah
        push eax
        push str_MNTR
        mov ecx, dword [PostGameShapeFile]
        push ecx
        call FindShape
        add esp, byte 8
        push eax
        call DrawShapeCore
        add esp, byte 0Ch
        mov esi, dword [dword esp+0110h]
        test esi, esi
        je short .21
        mov edi, dword [dword esp+0120h]
        push edi
        mov ebp, dword [dword esp+0120h]
        push ebp
        push esi
        call DrawShapeCore
        add esp, byte 0Ch
.21:
        cmp dword [ThreeStarsPos], byte 0
        je short .22
        mov eax, dword [dword esp+0172h]
        sub eax, byte 11h
        push eax
        mov eax, dword [dword esp+0172h]
        sub eax, byte 0Ah
        push eax
        push str_MNTR
        mov ebx, dword [PostGameShapeFile]
        push ebx
        call FindShape
        add esp, byte 8
        push eax
        call DrawShapeCore
        add esp, byte 0Ch
        mov ecx, dword [dword esp+0162h]
        test ecx, ecx
        je short .22
        mov esi, dword [dword esp+0172h]
        push esi
        mov edi, dword [dword esp+0172h]
        push edi
        push ecx
        call DrawShapeCore
        add esp, byte 0Ch
.22:
        mov eax, 0DCh
        mov edx, 136h
        mov dword [dword esp+057Ch], eax
        mov eax, dword [PostGameLayer]
        mov ecx, 14h
        lea edi, [byte esp+052h]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword esp+0580h], edx
        mov ebx, eax
        mov edx, eax
        mov esi, BlankMenuItem
        call DrawScreenBackground
        rep movsd
        movsw
        mov ebx, 1
        mov ecx, 14h
        lea edi, [dword esp+0A4h]
        mov esi, ScreenFrameItem
        mov dword [byte esp+052h], ebx
        rep movsd
        movsw
        mov ecx, 2
        mov eax, dword [PostGameLayer]
        mov dword [dword esp+0A4h], ecx
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte eax+02Ch]
        call WipeScreen
        mov esi, dword [PostGameLayer]
        push esi
        call FreeBitmap
        add esp, byte 4
        call ServiceIdle
        push byte 0
        push byte 76h
        push dword 0C8h
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [PostGameLayer], eax
        call SetScreenTarget
        push dword 136h
        mov eax, dword [PostGameLayer]
        push dword 0DCh
        mov edi, dword [byte eax+02Ch]
        push edi
        call ConvertArtXY
        add esp, byte 0Ch
        xor ebp, ebp
        xor esi, esi
        call PresentScreen
        xor edi, edi
        mov dword [dword esp+0564h], ebp
        mov ebp, 0C8h
.23:
        call ServiceIdle
        push byte 0
        push byte 76h
        push ebp
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov dword [dword esi+ThreeStarsLayers], eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        mov eax, dword [PostGameLayer]
        push byte 0
        mov edx, dword [byte eax+02Ch]
        push edx
        call BlitArt
        mov eax, dword [dword esi+ThreeStarsLayers]
        add esp, byte 0Ch
        mov eax, dword [byte eax+02Ch]
        mov edx, dword [dword esp+057Ch]
        mov word [byte eax+0Ch], dx
        mov eax, dword [dword esi+ThreeStarsLayers]
        xor ebx, ebx
        mov eax, dword [byte eax+02Ch]
        mov edx, dword [dword esp+0580h]
        push byte 76h
        mov word [byte eax+0Eh], dx
        xor ecx, ecx
        mov eax, dword [dword esi+ThreeStarsLayers]
        push ebp
        mov edx, 0Ch
        mov eax, dword [byte eax+02Ch]
        call DrawShadowBox
        cmp word [dword edi+ThreeStarsTeam], byte 0
        jne short .24
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        jmp short .25
.24:
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 6
.25:
        shr eax, 1Ah
        call LoadTeamLogo
        push byte 76h
        mov eax, dword [ShadowShape]
        mov ebx, 0Ch
        push ebp
        mov edx, dword [byte eax+04h]
        mov ecx, dword [byte eax+02h]
        push byte 0
        sar edx, 10h
        sar ecx, 10h
        sub edx, byte 76h
        push byte 0
        sar edx, 1
        sub ecx, 0C8h
        push edx
        mov edx, dword [dword esi+ThreeStarsLayers]
        sar ecx, 1
        mov edx, dword [byte edx+02Ch]
        add edi, byte 8
        call DrawShadedLogo
        call FreeLogoArt
        mov ecx, 76h
        mov ebx, ebp
        xor edx, edx
        xor eax, eax
        add esi, byte 4
        call DrawFrameBox
        mov ebx, dword [dword esp+0564h]
        mov eax, dword [dword esp+0564h]
        inc ebx
        call DrawThreeStarStats
        mov dword [dword esp+0564h], ebx
        cmp ebx, byte 3
        jl near .23
        xor esi, esi
        mov ebp, 3
        mov edi, 1
.26:
        lea eax, [dword esp+0560h]
        push ebp
        mov ecx, DrawThreeStarStats_4A8
        mov ebx, 0FFFFFFFFh
        push eax
        lea edx, [byte esp+08h]
        mov eax, 8
        call RunMenu
        mov eax, dword [dword esp+0560h]
        dec eax
        cmp eax, byte 3
        ja short PostGameScreen_B71.27
        jmp dword [nosplit cs:eax*4+PostGameScreenJumpTable]
PostGameScreen_B39:
        call FadeInScreen
        mov ebx, 1Ah
        mov esi, edi
        mov dword [dword esp+0578h], ebx
        jmp short PostGameScreen_B71.27
PostGameScreen_B4E:
        call ExitScreen
        jmp short PostGameScreen_B71.27
PostGameScreen_B55:
        lea eax, [dword esp+0F6h]
        mov edx, 17h
        call ShowPopupScreen
        mov esi, edi
        mov dword [dword esp+0578h], edx
        jmp short PostGameScreen_B71.27
PostGameScreen_B71:
        lea eax, [dword esp+0148h]
        call ShowPopupScreen
        call ClearThreeStars
        mov eax, 15h
        mov esi, edi
        mov dword [dword esp+0578h], eax
.27:
        test esi, esi
        je near PostGameScreen.26
        xor ebx, ebx
.28:
        mov ecx, dword [dword ebx+ThreeStarsLayers]
        push ecx
        add ebx, byte 4
        call FreeBitmap
        add esp, byte 4
        cmp ebx, byte 0Ch
        jne short .28
        mov esi, dword [PostGameLayer]
        push esi
        call FreeBitmap
        add esp, byte 4
        mov edi, dword [PostGameShapeFile]
        push edi
        call FreeMemBlock
        add esp, byte 4
        mov ebp, dword [PostGameArtFile]
        push ebp
        call FreeMemBlock
        add esp, byte 4
        push byte 0
        call OpenResourceArchive
        add esp, byte 4
        mov eax, dword [dword esp+0578h]
        add esp, 584h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
