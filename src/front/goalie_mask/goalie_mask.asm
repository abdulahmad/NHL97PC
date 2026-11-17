; Goalie mask intro screen.
bits 32
%include "hockey.inc"
section s_D4E24 progbits alloc exec nowrite align=1
extern BlankMenuItem, BlitArt, BlitShape2, CountFrameTick, CreateBitmap, DrawArt, DrawPortrait, DrawScreenBackground
extern DrawShapeAtOwnPos, DrawShapeCore, DrawStatTable, DrawTextAligned, FadeInScreen, FadePaletteBuffer, FindShape, FreeBitmap
extern FreeMemBlock, GoalieMaskAnimFrames, GoalieMaskAnimKinds, GoalieMaskItems, GoalieMaskList, GoalieMaskSoundOn, InitMenuItems, LoadDataFile
extern MakeColor, MakeDataPath, memset_, OpenArtArchiveErr, OpenResourceArchive, PlaySfx, PresentScreen, rand_
extern RunMenu, RunScrollList, SecondsToSamples, SetDrawTarget, SetRegionRect, SetScreenTarget, SetTextColor, ShowPopupScreen
extern sprintf_, StopAllSfx, str_AB004, str_AB014, str_AB024, str_AB034, str_AB044, str_AB054
extern str_BACK12, str_BarassoPIT, str_BarassoPIT199596, str_BB00, str_BB01, str_BB02d, str_BB04, str_BB05
extern str_BB08, str_BB09, str_BOTM4, str_DOR0, str_DOR1, str_FRNT2, str_LADR, str_LEFT
extern str_MASK0000FSH, str_MASK0002dFSH, str_PANL3, str_RIGH, str_SS14, str_SSS4, WaitRetraceEdges, WaitSoundTime
extern WipeScreen
global GoalieMaskIntro, GoalieMaskAnim, GoalieMaskScreenJumpTable, GoalieMaskScreen, GoalieMaskScreen_715, GoalieMaskScreen_72B, GoalieMaskScreen_89F, GoalieMaskScreen_A13
global GoalieMaskScreen_B89, GoalieMaskScreen_DBB, GoalieMaskScreen_FF0
;-----------------------------------------------------------------------------
; GoalieMaskIntro                                 D4E24  97 PC, low confidence
; From GoalieMaskScreen: the opening of the mask gallery (DOR0 / DOR1 doors,
; PANL, LADR, BB / AB buttons)
;-----------------------------------------------------------------------------
GoalieMaskIntro:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 2Ch
        mov edi, eax
        mov dword [byte esp+0Ch], edx
        push byte 0
        push dword 1E0h
        push dword 280h
        call CreateBitmap
        mov dword [byte esp+01Ch], eax
        add esp, byte 0Ch
        push str_DOR0
        push edi
        call FindShape
        mov dword [byte esp+010h], eax
        add esp, byte 8
        push str_DOR1
        push edi
        mov dword [byte esp+020h], eax
        call FindShape
        mov dword [byte esp+0Ch], eax
        add esp, byte 8
        push str_BACK12
        push edi
        mov dword [byte esp+024h], eax
        call FindShape
        add esp, byte 8
        push str_PANL3
        push edi
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push str_LADR
        push edi
        mov ebp, eax
        call FindShape
        add esp, byte 8
        mov edx, dword [byte esp+010h]
        push edx
        mov esi, eax
        call SetDrawTarget
        add esp, byte 4
        push str_LEFT
        push edi
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        push str_RIGH
        push edi
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        push str_BOTM4
        push edi
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        push str_BB00
        mov ecx, dword [byte esp+010h]
        push ecx
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        push str_BB04
        mov eax, dword [byte esp+010h]
        push eax
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        push str_BB08
        mov edx, dword [byte esp+010h]
        push edx
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        mov ecx, dword [byte esp+04h]
        push ecx
        call BlitShape2
        add esp, byte 4
        mov eax, dword [byte esp+08h]
        push eax
        call BlitShape2
        add esp, byte 4
        call PresentScreen
        mov eax, dword [byte esp+010h]
        xor edx, edx
        mov eax, dword [byte eax+02Ch]
        call WipeScreen
        mov edx, dword [byte esp+010h]
        push edx
        call FreeBitmap
        mov eax, ebx
        add esp, byte 4
        mov eax, dword [byte eax+04h]
        push byte 0
        sar eax, 10h
        push eax
        mov eax, ebx
        mov eax, dword [byte eax+02h]
        sar eax, 10h
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        xor edx, edx
        mov dword [byte esp+020h], eax
        mov eax, 202h
        mov word [byte esp+028h], dx
        call PlaySfx
.1:
        mov ecx, dword [byte esp+020h]
        push ecx
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        push byte 0
        push ebx
        call BlitArt
        add esp, byte 0Ch
        push str_AB004
        push edi
        call FindShape
        mov eax, dword [byte eax+0Ch]
        sar eax, 10h
        add esp, byte 8
        dec eax
        push eax
        push str_AB004
        push edi
        call FindShape
        mov edx, dword [byte eax+0Ah]
        mov eax, dword [byte ebx+0Ah]
        sar edx, 10h
        sar eax, 10h
        add esp, byte 8
        sub edx, eax
        push edx
        push str_AB004
        push edi
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        push str_AB034
        push edi
        call FindShape
        mov eax, dword [byte eax+0Ch]
        sar eax, 10h
        add esp, byte 8
        dec eax
        push eax
        push str_AB034
        push edi
        call FindShape
        mov edx, dword [byte eax+0Ah]
        mov eax, dword [byte ebx+0Ah]
        sar edx, 10h
        sar eax, 10h
        add esp, byte 8
        sub edx, eax
        push edx
        push str_AB034
        push edi
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        mov eax, dword [byte esi+0Ch]
        sar eax, 10h
        add esp, byte 0Ch
        inc eax
        mov edx, dword [byte ebx+0Ah]
        push eax
        mov eax, dword [byte esi+0Ah]
        sar edx, 10h
        sar eax, 10h
        sub eax, edx
        push eax
        push esi
        call BlitArt
        add esp, byte 0Ch
        push dword 1051h
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, dword [byte esi+0Ch]
        push str_BarassoPIT
        sar eax, 10h
        mov edx, dword [byte esi+02h]
        inc eax
        sar edx, 10h
        push eax
        mov eax, edx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov edx, dword [byte esi+0Ah]
        sar edx, 10h
        add edx, eax
        mov eax, dword [byte ebx+0Ah]
        sar eax, 10h
        sub edx, eax
        push edx
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov edx, dword [byte esp+018h]
        mov eax, dword [byte esp+026h]
        mov edx, dword [byte edx+04h]
        sar eax, 10h
        sar edx, 10h
        imul edx, eax
        mov ecx, 14h
        mov dword [esp], eax
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov edx, dword [byte esp+018h]
        mov edx, dword [byte edx+0Ch]
        sar edx, 10h
        sub edx, eax
        push edx
        push byte 0
        mov eax, dword [byte esp+020h]
        push eax
        call BlitArt
        add esp, byte 0Ch
        mov edx, dword [byte esp+01Ch]
        mov edx, dword [byte edx+04h]
        mov ecx, dword [esp]
        sar edx, 10h
        imul edx, ecx
        mov ecx, 14h
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov edx, dword [byte esp+01Ch]
        mov edx, dword [byte edx+0Ch]
        sar edx, 10h
        add eax, edx
        push eax
        push byte 0
        mov ecx, dword [byte esp+024h]
        push ecx
        call BlitArt
        add esp, byte 0Ch
        call SetScreenTarget
        mov eax, dword [byte ebx+0Ch]
        sar eax, 10h
        push eax
        mov eax, dword [byte ebx+0Ah]
        sar eax, 10h
        push eax
        mov eax, dword [byte esp+028h]
        mov edx, dword [byte eax+02Ch]
        push edx
        call BlitArt
        add esp, byte 0Ch
        mov ecx, dword [byte esp+028h]
        inc ecx
        mov word [byte esp+028h], cx
        cmp cx, byte 14h
        jl near .1
        xor edx, edx
        mov word [byte esp+024h], dx
.2:
        mov ecx, dword [byte esp+020h]
        push ecx
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        push byte 0
        push ebx
        call BlitArt
        add esp, byte 0Ch
        mov ecx, 5
        mov eax, dword [byte esp+022h]
        mov edx, dword [byte ebp+04h]
        sar eax, 10h
        sar edx, 10h
        sub ecx, eax
        imul edx, ecx
        mov dword [byte esp+014h], ecx
        mov ecx, 5
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov edx, dword [byte ebp+0Ch]
        sar edx, 10h
        add eax, edx
        dec eax
        mov edx, dword [byte ebx+0Ah]
        push eax
        mov eax, dword [byte ebp+0Ah]
        sar edx, 10h
        sar eax, 10h
        sub eax, edx
        push eax
        push ebp
        call DrawArt
        add esp, byte 0Ch
        push str_AB004
        push edi
        call FindShape
        mov eax, dword [byte eax+0Ch]
        sar eax, 10h
        add esp, byte 8
        dec eax
        push eax
        push str_AB004
        push edi
        call FindShape
        mov eax, dword [byte eax+0Ah]
        mov edx, dword [byte ebx+0Ah]
        sar eax, 10h
        sar edx, 10h
        add esp, byte 8
        sub eax, edx
        push eax
        push str_AB004
        push edi
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        push str_AB034
        push edi
        call FindShape
        mov eax, dword [byte eax+0Ch]
        sar eax, 10h
        add esp, byte 8
        dec eax
        push eax
        push str_AB034
        push edi
        call FindShape
        mov eax, dword [byte eax+0Ah]
        mov edx, dword [byte ebx+0Ah]
        sar eax, 10h
        sar edx, 10h
        add esp, byte 8
        sub eax, edx
        push eax
        push str_AB034
        push edi
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        mov eax, dword [byte esi+0Ch]
        sar eax, 10h
        dec eax
        mov edx, dword [byte ebx+0Ah]
        push eax
        mov eax, dword [byte esi+0Ah]
        sar edx, 10h
        sar eax, 10h
        sub eax, edx
        push eax
        push esi
        call BlitArt
        add esp, byte 0Ch
        push dword 1051h
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, dword [byte esi+0Ch]
        push str_BarassoPIT
        sar eax, 10h
        mov edx, dword [byte esi+02h]
        inc eax
        sar edx, 10h
        push eax
        mov eax, edx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov edx, dword [byte esi+0Ah]
        sar edx, 10h
        add eax, edx
        mov edx, dword [byte ebx+0Ah]
        sar edx, 10h
        sub eax, edx
        push eax
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov edx, dword [byte ebp+04h]
        mov eax, dword [byte esp+014h]
        sar edx, 10h
        imul edx, eax
        mov ecx, 5
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov edx, dword [byte ebp+0Ch]
        sar edx, 10h
        push str_BarassoPIT199596
        add eax, edx
        mov edx, dword [byte esi+02h]
        add eax, byte 10h
        sar edx, 10h
        push eax
        mov eax, edx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov edx, dword [byte esi+0Ah]
        sar edx, 10h
        add edx, eax
        mov eax, dword [byte ebx+0Ah]
        sar eax, 10h
        sub edx, eax
        push edx
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        call SetScreenTarget
        mov eax, dword [byte ebx+0Ch]
        sar eax, 10h
        push eax
        mov eax, dword [byte ebx+0Ah]
        sar eax, 10h
        push eax
        mov eax, dword [byte esp+028h]
        mov edx, dword [byte eax+02Ch]
        push edx
        call BlitArt
        add esp, byte 0Ch
        mov ecx, dword [byte esp+024h]
        inc ecx
        mov word [byte esp+024h], cx
        cmp cx, byte 5
        jle near .2
        call PresentScreen
        mov edx, dword [byte esp+020h]
        push edx
        call FreeBitmap
        add esp, byte 4
        call StopAllSfx
        mov eax, 203h
        call PlaySfx
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; GoalieMaskAnim                                  D53A4  97 PC, low confidence
; Animates the goalie mask screen with a random sound
;-----------------------------------------------------------------------------
GoalieMaskAnim:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edi, 52h
        xor ebp, ebp
.1:
        mov edx, dword [dword edi+GoalieMaskItems+4]
        cmp edx, byte 1
        jne short .4
        mov ebx, edi
        mov ebp, edx
        xor esi, esi
.2:
        mov ecx, dword [dword esi+GoalieMaskAnimKinds]
        cmp ecx, dword [dword ebx+GoalieMaskItems+1Ah]
        jne short .3
        call rand_
        mov edx, eax
        mov ecx, 3
        sar edx, 1Fh
        idiv ecx
        mov edx, dword [dword esi+edx*4+GoalieMaskAnimFrames]
        mov eax, dword [dword ebx+GoalieMaskItems+2Ah]
        mov dword [dword ebx+GoalieMaskItems+1Eh], edx
        push eax
        mov edx, dword [dword ebx+GoalieMaskItems+26h]
        push edx
        mov ecx, dword [dword ebx+GoalieMaskItems+1Eh]
        push ecx
        call BlitArt
        add esp, byte 0Ch
.3:
        add esi, byte 10h
        cmp esi, byte 30h
        jne short .2
.4:
        add edi, byte 52h
        cmp edi, 148h
        jne short .1
        test ebp, ebp
        je short .5
        cmp dword [GoalieMaskSoundOn], byte 0
        jne short .5
        mov edi, 1
        mov eax, 309h
        mov dword [GoalieMaskSoundOn], edi
        call PlaySfx
.5:
        test ebp, ebp
        jne short .6
        cmp dword [GoalieMaskSoundOn], byte 0
        je short .6
        xor eax, eax
        mov dword [GoalieMaskSoundOn], eax
        call StopAllSfx
.6:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
GoalieMaskScreenJumpTable:                      ; jump table for the switch cases of GoalieMaskScreen
        dd GoalieMaskScreen_715
        dd GoalieMaskScreen_72B
        dd GoalieMaskScreen_89F
        dd GoalieMaskScreen_A13
        dd GoalieMaskScreen_B89
        dd GoalieMaskScreen_DBB
        dd GoalieMaskScreen_FF0
;-----------------------------------------------------------------------------
; GoalieMaskScreen                             D547C  97 PC, medium confidence
; From RunFrontEnd: the goalie mask gallery (MASK00%02d.FSH, "%s - %s - %s"
; goalie - team - season captions, LEFT / RIGH / FRNT buttons)
;-----------------------------------------------------------------------------
GoalieMaskScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 580h
        mov ecx, 5Dh
        lea edi, [dword esp+0180h]
        mov eax, 3
        xor edx, edx
        mov esi, GoalieMaskList
        mov dword [dword esp+0578h], edx
        mov word [dword esp+057Ch], dx
        rep movsd
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 0DEh
        xor edx, edx
        call LoadDataFile
        mov ebx, eax
        mov dword [dword esp+0560h], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 0DFh
        call LoadDataFile
        mov ebp, eax
        mov dword [dword esp+056Ch], eax
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push byte 0
        push str_BACK12
        push ebx
        call FindShape
        mov eax, dword [byte eax+04h]
        sar eax, 10h
        add esp, byte 8
        sub eax, byte 55h
        push eax
        push str_BACK12
        push ebx
        call FindShape
        mov eax, dword [byte eax+02h]
        add esp, byte 8
        sar eax, 10h
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push str_BACK12
        push ebx
        mov esi, eax
        mov dword [dword esp+057Ch], eax
        call FindShape
        add esp, byte 8
        mov edx, dword [byte esi+02Ch]
        mov ax, word [byte eax+0Ch]
        push byte 0
        mov word [byte edx+0Ch], ax
        push str_BACK12
        mov eax, dword [byte esi+02Ch]
        push ebx
        mov word [byte eax+0Eh], 1Eh
        call FindShape
        mov eax, dword [byte eax+04h]
        sar eax, 10h
        add esp, byte 8
        sub eax, byte 64h
        push eax
        push str_BACK12
        push ebx
        call FindShape
        mov eax, dword [byte eax+02h]
        add esp, byte 8
        sar eax, 10h
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        mov edi, eax
        mov dword [dword esp+0568h], eax
        push str_BACK12
        push ebx
        call FindShape
        mov edx, dword [byte edi+02Ch]
        mov ax, word [byte eax+0Ch]
        mov word [byte edx+0Ch], ax
        add esp, byte 8
        mov eax, dword [byte edi+02Ch]
        push esi
        mov word [byte eax+0Eh], 1Eh
        call SetDrawTarget
        mov eax, dword [byte esi+02Ch]
        add esp, byte 4
        mov eax, dword [byte eax+0Ch]
        push str_BACK12
        sar eax, 10h
        push ebx
        mov dword [dword esp+056Ch], eax
        call FindShape
        add esp, byte 8
        mov eax, dword [byte eax+0Ch]
        mov edx, dword [dword esp+0564h]
        sar eax, 10h
        sub eax, edx
        push eax
        mov eax, dword [byte esi+02Ch]
        mov eax, dword [byte eax+0Ah]
        push str_BACK12
        sar eax, 10h
        push ebx
        mov dword [dword esp+0570h], eax
        call FindShape
        add esp, byte 8
        mov eax, dword [byte eax+0Ah]
        mov ecx, dword [dword esp+0568h]
        sar eax, 10h
        sub eax, ecx
        push eax
        push str_BACK12
        push ebx
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        push edi
        call SetDrawTarget
        mov eax, dword [byte esi+02Ch]
        add esp, byte 4
        mov eax, dword [byte eax+0Ch]
        push str_BACK12
        sar eax, 10h
        push ebx
        mov dword [dword esp+056Ch], eax
        call FindShape
        add esp, byte 8
        mov eax, dword [byte eax+0Ch]
        mov edx, dword [dword esp+0564h]
        sar eax, 10h
        sub eax, edx
        push eax
        mov eax, dword [byte esi+02Ch]
        mov eax, dword [byte eax+0Ah]
        push str_BACK12
        sar eax, 10h
        push ebx
        mov dword [dword esp+0570h], eax
        call FindShape
        add esp, byte 8
        mov eax, dword [byte eax+0Ah]
        mov ecx, dword [dword esp+0568h]
        sar eax, 10h
        sub eax, ecx
        push eax
        push str_BACK12
        push ebx
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        mov edx, ebp
        mov eax, ebx
        call GoalieMaskIntro
        mov edx, 0E0h
        lea eax, [dword esp+0534h]
        call MakeDataPath
        lea eax, [dword esp+0534h]
        push eax
        call OpenResourceArchive
        add esp, byte 4
        push str_MASK0000FSH
        lea eax, [dword esp+0538h]
        push eax
        call sprintf_
        add esp, byte 8
        push byte 0
        lea eax, [dword esp+0538h]
        push eax
        call OpenArtArchiveErr
        add esp, byte 8
        push edi
        mov ebx, eax
        mov dword [dword esp+0574h], eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        push byte 0
        mov ebp, dword [byte esi+02Ch]
        push ebp
        call BlitArt
        add esp, byte 0Ch
        push str_FRNT2
        push ebx
        call FindShape
        mov edx, dword [byte eax+04h]
        mov eax, 17Ch
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov edx, dword [byte esi+02Ch]
        mov edx, dword [byte edx+0Ch]
        sar edx, 10h
        add esp, byte 8
        sub eax, edx
        push eax
        push str_FRNT2
        push ebx
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, 280h
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov edx, dword [byte esi+02Ch]
        mov edx, dword [byte edx+0Ah]
        sar edx, 10h
        add esp, byte 8
        sub eax, edx
        push eax
        push str_FRNT2
        push ebx
        call FindShape
        add esp, byte 8
        push eax
        call DrawShapeCore
        add esp, byte 0Ch
        push str_FRNT2
        push ebx
        call FindShape
        mov edx, dword [byte eax+04h]
        mov eax, 17Ch
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov ebp, dword [byte esi+02Ch]
        mov ebp, dword [byte ebp+0Ch]
        add esp, byte 8
        sar ebp, 10h
        push str_FRNT2
        sub eax, ebp
        push ebx
        mov ebp, eax
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, 280h
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov edx, dword [byte esi+02Ch]
        add esp, byte 8
        mov edx, dword [byte edx+0Ah]
        push str_FRNT2
        sar edx, 10h
        push ebx
        sub eax, edx
        mov esi, dword [byte edi+02Ch]
        mov dword [dword esp+056Ch], eax
        call FindShape
        add esp, byte 8
        mov ecx, ebp
        mov edx, esi
        mov ebx, dword [dword esp+0564h]
        call DrawPortrait
        call SetScreenTarget
        mov eax, dword [byte edi+02Ch]
        push eax
        call BlitShape2
        add esp, byte 4
        xor edi, edi
        call PresentScreen
.1:
        xor ebx, ebx
.2:
        movsx ebp, di
        movsx esi, bx
        lea eax, [nosplit ebp*4+00h]
        add eax, esi
        push eax
        push str_BB02d
        lea eax, [dword esp+04ECh]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [dword esp+04E4h]
        push eax
        mov ecx, dword [dword esp+0570h]
        inc ebx
        push ecx
        shl ebp, 4
        call FindShape
        add esp, byte 8
        mov dword [dword ebp+esi*4+GoalieMaskAnimKinds], eax
        cmp bx, byte 4
        jl short .2
        inc edi
        cmp di, byte 3
        jl short .1
        push str_LADR
        mov edx, dword [dword esp+0564h]
        push edx
        xor esi, esi
        call FindShape
        add esp, byte 8
        mov ebp, eax
.3:
        xor ebx, ebx
.4:
        mov eax, dword [byte ebp+04h]
        push byte 20h
        sar eax, 10h
        push eax
        mov eax, dword [byte ebp+02h]
        sar eax, 10h
        push eax
        call CreateBitmap
        movsx edx, si
        lea edi, [nosplit edx*8+00h]
        movsx edx, bx
        shl edx, 2
        add esp, byte 0Ch
        add edx, edi
        push eax
        mov dword [dword esp+edx+02F8h], eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        push byte 0
        push ebp
        call BlitArt
        add esp, byte 0Ch
        test bx, bx
        jne short .5
        push dword 1051h
        jmp short .6
.5:
        push dword 0F7DF00h
.6:
        call MakeColor
        add esp, byte 4
        call SetTextColor
        movsx edi, si
        imul eax, edi, byte 0Ch
        mov edx, dword [dword esp+eax+0184h]
        push edx
        mov ecx, dword [dword esp+eax+0184h]
        push ecx
        push str_SS14
        lea eax, [dword esp+04F0h]
        push eax
        call sprintf_
        lea eax, [dword esp+04F4h]
        mov edx, dword [byte ebp+02h]
        add esp, byte 10h
        sar edx, 10h
        push eax
        mov eax, edx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        push byte 2
        push eax
        push byte 1
        inc ebx
        call DrawTextAligned
        add esp, byte 10h
        cmp bx, byte 2
        jl near .4
        mov edx, dword [dword esp+edi*8+02F4h]
        mov edx, dword [byte edx+02Ch]
        mov eax, dword [dword esp+edi*8+02F8h]
        mov dword [dword esp+edi*4+0468h], edx
        mov eax, dword [byte eax+02Ch]
        inc esi
        mov dword [dword esp+edi*4+03ECh], eax
        cmp si, byte 1Fh
        jl near .3
        mov edx, GoalieMaskItems
        mov eax, 7
        call InitMenuItems
        push str_RIGH
        mov esi, dword [dword esp+0564h]
        push esi
        call FindShape
        add esp, byte 8
        push str_RIGH
        push esi
        mov ebx, eax
        call FindShape
        add esp, byte 8
        mov edi, esi
        push str_RIGH
        mov esi, eax
        mov eax, edi
        push eax
        mov edi, GoalieMaskItems
        call FindShape
        add esp, byte 8
        mov edx, esi
        mov ecx, 14h
        call DrawScreenBackground
        mov eax, esp
        mov ebx, str_BB00
        mov esi, BlankMenuItem
        xor edx, edx
        push eax
        rep movsd
        movsw
        push str_BB00
        mov ecx, str_BB01
        mov eax, GoalieMaskItems+52h
        mov dword [GoalieMaskItems], edx
        mov edx, dword [dword esp+0574h]
        call DrawStatTable
        lea eax, [byte esp+040h]
        push eax
        mov ecx, str_BB05
        mov ebx, str_BB04
        push str_BB04
        mov edx, dword [dword esp+0574h]
        mov eax, GoalieMaskItems+0A4h
        call DrawStatTable
        lea eax, [dword esp+080h]
        push eax
        mov ecx, str_BB09
        mov ebx, str_BB08
        push str_BB08
        mov edx, dword [dword esp+0574h]
        mov eax, GoalieMaskItems+0F6h
        call DrawStatTable
        lea eax, [dword esp+0C0h]
        push eax
        mov ecx, str_AB014
        mov ebx, str_AB004
        push str_AB024
        mov edx, dword [dword esp+0568h]
        mov eax, GoalieMaskItems+148h
        call DrawStatTable
        lea eax, [dword esp+0100h]
        push eax
        mov ecx, str_AB044
        mov ebx, str_AB034
        push str_AB054
        mov edx, dword [dword esp+0568h]
        mov eax, GoalieMaskItems+19Ah
        call DrawStatTable
        mov eax, dword [dword esp+0468h]
        mov dword [GoalieMaskItems+206h], eax
        mov eax, dword [dword esp+03ECh]
        mov dword [GoalieMaskItems+20Ah], eax
        mov dword [GoalieMaskItems+20Eh], eax
        mov eax, dword [byte ebp+0Ah]
        sar eax, 10h
        mov dword [GoalieMaskItems+212h], eax
        mov eax, dword [byte ebp+0Ch]
        sar eax, 10h
        mov ebx, 4
        mov dword [GoalieMaskItems+216h], eax
        lea eax, [dword esp+0140h]
        mov dword [GoalieMaskItems+1FCh], ebx
        mov dword [GoalieMaskItems+200h], eax
        mov eax, dword [byte ebp+04h]
        mov ecx, dword [byte ebp+02h]
        mov ebx, dword [byte ebp+0Ch]
        mov edx, dword [byte ebp+0Ah]
        sar eax, 10h
        sar ecx, 10h
        sar ebx, 10h
        push eax
        sar edx, 10h
        lea eax, [dword esp+0144h]
        call SetRegionRect
        cmp word [dword esp+0578h], byte 0
        jne near GoalieMaskScreen_FF0.14
.7:
        push byte 2
        lea eax, [dword esp+0560h]
        mov ecx, GoalieMaskAnim
        mov ebx, 0FFFFFFFFh
        push eax
        mov edx, GoalieMaskItems
        mov eax, 7
        call RunMenu
        mov edx, dword [dword esp+055Ch]
        cmp edx, byte 6
        ja near GoalieMaskScreen_FF0.13
        mov eax, edx
        jmp dword [nosplit cs:eax*4+GoalieMaskScreenJumpTable]
GoalieMaskScreen_715:
        mov ecx, 1
        call FadeInScreen
        mov dword [dword esp+0578h], ecx
        jmp near GoalieMaskScreen_FF0.13
GoalieMaskScreen_72B:
        mov eax, GoalieMaskItems+52h
        mov ebx, dword [dword esp+0568h]
        call ShowPopupScreen
        push ebx
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        mov eax, dword [dword esp+0578h]
        push byte 0
        mov ecx, dword [byte eax+02Ch]
        push ecx
        call BlitArt
        add esp, byte 0Ch
        push str_LEFT
        mov esi, dword [dword esp+0574h]
        push esi
        call FindShape
        mov edx, dword [byte eax+04h]
        mov eax, 17Ch
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov edx, dword [byte edx+0Ch]
        sar edx, 10h
        sub eax, edx
        push eax
        push str_LEFT
        push esi
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, 280h
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0578h]
        mov edx, dword [byte edx+02Ch]
        mov edx, dword [byte edx+0Ah]
        sar edx, 10h
        sub eax, edx
        push eax
        push str_LEFT
        push esi
        call FindShape
        add esp, byte 8
        push eax
        call DrawShapeCore
        add esp, byte 0Ch
        push str_LEFT
        push esi
        call FindShape
        mov edx, dword [byte eax+04h]
        mov eax, 17Ch
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov ebx, dword [byte edx+0Ch]
        sar ebx, 10h
        push str_LEFT
        sub eax, ebx
        push esi
        mov ebx, eax
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, 280h
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov esi, dword [byte edx+0Ah]
        sar esi, 10h
        sub eax, esi
        push str_LEFT
        mov esi, eax
        mov eax, dword [dword esp+0574h]
        mov edi, dword [dword esp+056Ch]
        push eax
        mov edi, dword [byte edi+02Ch]
        call FindShape
        add esp, byte 8
        mov ecx, ebx
        mov edx, edi
        mov ebx, esi
        call DrawPortrait
        call SetScreenTarget
        mov eax, dword [dword esp+0568h]
        mov edx, dword [byte eax+02Ch]
        push edx
        call BlitShape2
        add esp, byte 4
        jmp near GoalieMaskScreen_FF0.12
GoalieMaskScreen_89F:
        mov eax, GoalieMaskItems+0A4h
        mov ecx, dword [dword esp+0568h]
        call ShowPopupScreen
        push ecx
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        mov eax, dword [dword esp+0578h]
        push byte 0
        mov esi, dword [byte eax+02Ch]
        push esi
        call BlitArt
        add esp, byte 0Ch
        push str_FRNT2
        mov edi, dword [dword esp+0574h]
        push edi
        call FindShape
        mov edx, dword [byte eax+04h]
        mov eax, 17Ch
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov edx, dword [byte edx+0Ch]
        sar edx, 10h
        sub eax, edx
        push eax
        push str_FRNT2
        push edi
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, 280h
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0578h]
        mov edx, dword [byte edx+02Ch]
        mov edx, dword [byte edx+0Ah]
        sar edx, 10h
        sub eax, edx
        push eax
        push str_FRNT2
        push edi
        call FindShape
        add esp, byte 8
        push eax
        call DrawShapeCore
        add esp, byte 0Ch
        push str_FRNT2
        push edi
        call FindShape
        mov edx, dword [byte eax+04h]
        mov eax, 17Ch
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov ebx, dword [byte edx+0Ch]
        sar ebx, 10h
        push str_FRNT2
        sub eax, ebx
        push edi
        mov ebx, eax
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, 280h
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov edi, dword [byte edx+0Ah]
        sar edi, 10h
        sub eax, edi
        push str_FRNT2
        mov edi, eax
        mov eax, dword [dword esp+0574h]
        mov esi, dword [dword esp+056Ch]
        push eax
        mov esi, dword [byte esi+02Ch]
        call FindShape
        add esp, byte 8
        mov ecx, ebx
        mov edx, esi
        mov ebx, edi
        call DrawPortrait
        call SetScreenTarget
        mov eax, dword [dword esp+0568h]
        mov edx, dword [byte eax+02Ch]
        push edx
        call BlitShape2
        add esp, byte 4
        jmp near GoalieMaskScreen_FF0.12
GoalieMaskScreen_A13:
        mov eax, GoalieMaskItems+0F6h
        call ShowPopupScreen
        mov eax, dword [dword esp+0568h]
        push eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        mov eax, dword [dword esp+0578h]
        push byte 0
        mov edx, dword [byte eax+02Ch]
        push edx
        call BlitArt
        add esp, byte 0Ch
        push str_RIGH
        mov ebx, dword [dword esp+0574h]
        push ebx
        call FindShape
        mov edx, dword [byte eax+04h]
        mov eax, 17Ch
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov edx, dword [byte edx+0Ch]
        sar edx, 10h
        sub eax, edx
        push eax
        push str_RIGH
        push ebx
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, 280h
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0578h]
        mov edx, dword [byte edx+02Ch]
        mov edx, dword [byte edx+0Ah]
        sar edx, 10h
        sub eax, edx
        push eax
        push str_RIGH
        push ebx
        call FindShape
        add esp, byte 8
        push eax
        call DrawShapeCore
        add esp, byte 0Ch
        push str_RIGH
        push ebx
        call FindShape
        mov edx, dword [byte eax+04h]
        mov eax, 17Ch
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov esi, ebx
        mov ebx, dword [byte edx+0Ch]
        sar ebx, 10h
        push str_RIGH
        sub eax, ebx
        push esi
        mov ebx, eax
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, 280h
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov esi, dword [dword esp+0568h]
        push str_RIGH
        mov edi, dword [byte edx+0Ah]
        mov edx, dword [dword esp+0574h]
        sar edi, 10h
        push edx
        sub eax, edi
        mov esi, dword [byte esi+02Ch]
        mov edi, eax
        call FindShape
        add esp, byte 8
        mov ecx, ebx
        mov edx, esi
        mov ebx, edi
        call DrawPortrait
        call SetScreenTarget
        mov eax, dword [dword esp+0568h]
        mov ebx, dword [byte eax+02Ch]
        push ebx
        call BlitShape2
        add esp, byte 4
        jmp near GoalieMaskScreen_FF0.12
GoalieMaskScreen_B89:
        mov edx, dword [dword esp+057Ch]
        test dx, dx
        jle short .8
        mov ebx, edx
        dec ebx
        mov word [dword esp+057Ch], bx
.8:
        mov ebx, dword [dword esp+057Ah]
        sar ebx, 10h
        mov edx, dword [dword esp+ebx*4+0468h]
        mov dword [GoalieMaskItems+206h], edx
        mov ecx, dword [dword esp+0570h]
        mov edx, dword [dword esp+ebx*4+03ECh]
        push ecx
        mov dword [GoalieMaskItems+20Ah], edx
        mov dword [GoalieMaskItems+20Eh], edx
        call FreeMemBlock
        add esp, byte 4
        push ebx
        imul ebx, byte 0Ch
        push str_MASK0002dFSH
        lea eax, [dword esp+053Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        push byte 0
        lea eax, [dword esp+0538h]
        push eax
        call OpenArtArchiveErr
        add esp, byte 8
        push byte 0FFFFFFFFh
        mov esi, eax
        mov dword [dword esp+0574h], eax
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov edi, dword [dword esp+ebx+0188h]
        push edi
        mov eax, dword [dword esp+ebx+0188h]
        push eax
        mov edx, dword [dword esp+ebx+0188h]
        push edx
        push str_SSS4
        lea eax, [dword esp+04F4h]
        push eax
        call sprintf_
        add esp, byte 14h
        mov ebx, dword [dword esp+0568h]
        push ebx
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        mov eax, dword [dword esp+0578h]
        push byte 0
        mov ecx, dword [byte eax+02Ch]
        push ecx
        call BlitArt
        add esp, byte 0Ch
        push str_FRNT2
        push esi
        call FindShape
        mov edx, dword [byte eax+04h]
        mov eax, 17Ch
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov edx, dword [byte edx+0Ch]
        sar edx, 10h
        sub eax, edx
        push eax
        push str_FRNT2
        push esi
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, 280h
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0578h]
        mov edx, dword [byte edx+02Ch]
        mov edx, dword [byte edx+0Ah]
        sar edx, 10h
        sub eax, edx
        push eax
        push str_FRNT2
        push esi
        call FindShape
        add esp, byte 8
        push eax
        call DrawShapeCore
        add esp, byte 0Ch
        push str_FRNT2
        push esi
        call FindShape
        mov edx, dword [byte eax+04h]
        mov eax, 17Ch
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov edx, dword [byte edx+0Ch]
        sar edx, 10h
        push str_FRNT2
        sub eax, edx
        push esi
        mov dword [dword esp+056Ch], eax
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, 280h
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov ebx, dword [dword esp+0574h]
        mov ebx, dword [byte ebx+02Ch]
        mov edi, dword [dword esp+0568h]
        mov ebx, dword [byte ebx+0Ah]
        push str_FRNT2
        sar ebx, 10h
        push esi
        sub eax, ebx
        mov edi, dword [byte edi+02Ch]
        mov ebx, eax
        call FindShape
        add esp, byte 8
        mov edx, edi
        mov ecx, dword [dword esp+0564h]
        call DrawPortrait
        call SetScreenTarget
        mov eax, dword [dword esp+0568h]
        mov esi, dword [byte eax+02Ch]
        push esi
        call BlitShape2
        add esp, byte 4
        push str_PANL3
        mov edi, dword [dword esp+0564h]
        push edi
        jmp near GoalieMaskScreen_FF0.11
GoalieMaskScreen_DBB:
        mov edi, dword [dword esp+057Ch]
        cmp di, byte 1Eh
        jge short .9
        mov eax, edi
        inc eax
        mov word [dword esp+057Ch], ax
.9:
        mov ebx, dword [dword esp+057Ah]
        sar ebx, 10h
        mov edx, dword [dword esp+ebx*4+0468h]
        mov dword [GoalieMaskItems+206h], edx
        mov esi, dword [dword esp+0570h]
        mov edx, dword [dword esp+ebx*4+03ECh]
        push esi
        mov dword [GoalieMaskItems+20Ah], edx
        mov dword [GoalieMaskItems+20Eh], edx
        call FreeMemBlock
        add esp, byte 4
        push ebx
        push str_MASK0002dFSH
        lea eax, [dword esp+053Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        push byte 0
        lea eax, [dword esp+0538h]
        push eax
        call OpenArtArchiveErr
        add esp, byte 8
        push byte 0FFFFFFFFh
        mov esi, eax
        mov dword [dword esp+0574h], eax
        call MakeColor
        add esp, byte 4
        call SetTextColor
        imul eax, ebx, byte 0Ch
        mov edi, dword [dword esp+eax+0188h]
        push edi
        mov edx, dword [dword esp+eax+0188h]
        push edx
        mov ebx, dword [dword esp+eax+0188h]
        push ebx
        push str_SSS4
        lea eax, [dword esp+04F4h]
        push eax
        call sprintf_
        add esp, byte 14h
        mov ecx, dword [dword esp+0568h]
        push ecx
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        mov eax, dword [dword esp+0578h]
        push byte 0
        mov edi, dword [byte eax+02Ch]
        push edi
        call BlitArt
        add esp, byte 0Ch
        push str_FRNT2
        push esi
        call FindShape
        mov edx, dword [byte eax+04h]
        mov eax, 17Ch
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov edx, dword [byte edx+0Ch]
        sar edx, 10h
        sub eax, edx
        push eax
        push str_FRNT2
        push esi
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, 280h
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0578h]
        mov edx, dword [byte edx+02Ch]
        mov edx, dword [byte edx+0Ah]
        sar edx, 10h
        sub eax, edx
        push eax
        push str_FRNT2
        push esi
        call FindShape
        add esp, byte 8
        push eax
        call DrawShapeCore
        add esp, byte 0Ch
        push str_FRNT2
        push esi
        call FindShape
        mov edx, dword [byte eax+04h]
        mov eax, 17Ch
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov ebx, dword [byte edx+0Ch]
        sar ebx, 10h
        push str_FRNT2
        sub eax, ebx
        push esi
        mov ebx, eax
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, 280h
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov edi, dword [dword esp+0568h]
        mov edx, dword [byte edx+0Ah]
        push str_FRNT2
        sar edx, 10h
        push esi
        sub eax, edx
        mov edi, dword [byte edi+02Ch]
        mov dword [dword esp+056Ch], eax
        call FindShape
        add esp, byte 8
        mov ecx, ebx
        mov edx, edi
        mov ebx, dword [dword esp+0564h]
        call DrawPortrait
        call SetScreenTarget
        mov eax, dword [dword esp+0568h]
        mov edx, dword [byte eax+02Ch]
        push edx
        call BlitShape2
        add esp, byte 4
        push str_PANL3
        mov ebx, dword [dword esp+0564h]
        push ebx
        jmp near GoalieMaskScreen_FF0.11
GoalieMaskScreen_FF0:
        mov ecx, dword [byte ebp+0Ch]
        sar ecx, 10h
        mov ebx, dword [byte ebp+0Ah]
        add ecx, byte 1Eh
        sar ebx, 10h
        push ecx
        lea eax, [byte ebx-014h]
        push eax
        mov eax, dword [dword esp+0570h]
        mov esi, dword [byte eax+02Ch]
        push esi
        lea eax, [dword esp+03F8h]
        push eax
        lea eax, [dword esp+0478h]
        push eax
        mov edx, 0Ah
        mov eax, 1Fh
        call RunScrollList
        movsx edx, ax
        cmp edx, byte 0FFFFFFFFh
        je short .10
        mov word [dword esp+057Ch], ax
.10:
        mov edi, dword [dword esp+057Ah]
        sar edi, 10h
        mov edx, dword [dword esp+edi*4+0468h]
        mov dword [GoalieMaskItems+206h], edx
        mov eax, dword [dword esp+0570h]
        mov edx, dword [dword esp+edi*4+03ECh]
        push eax
        mov dword [GoalieMaskItems+20Ah], edx
        mov dword [GoalieMaskItems+20Eh], edx
        call FreeMemBlock
        add esp, byte 4
        push edi
        imul edi, byte 0Ch
        push str_MASK0002dFSH
        lea eax, [dword esp+053Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        push byte 0
        lea eax, [dword esp+0538h]
        push eax
        call OpenArtArchiveErr
        add esp, byte 8
        push byte 0FFFFFFFFh
        mov esi, eax
        mov dword [dword esp+0574h], eax
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov edx, dword [dword esp+edi+0188h]
        push edx
        mov ebx, dword [dword esp+edi+0188h]
        push ebx
        mov ecx, dword [dword esp+edi+0188h]
        push ecx
        push str_SSS4
        lea eax, [dword esp+04F4h]
        push eax
        call sprintf_
        add esp, byte 14h
        mov edi, dword [dword esp+0568h]
        push edi
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        mov eax, dword [dword esp+0578h]
        push byte 0
        mov edx, dword [byte eax+02Ch]
        push edx
        call BlitArt
        add esp, byte 0Ch
        push str_FRNT2
        push esi
        call FindShape
        mov edx, dword [byte eax+04h]
        mov eax, 17Ch
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov edx, dword [byte edx+0Ch]
        sar edx, 10h
        sub eax, edx
        push eax
        push str_FRNT2
        push esi
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, 280h
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0578h]
        mov edx, dword [byte edx+02Ch]
        mov edx, dword [byte edx+0Ah]
        sar edx, 10h
        sub eax, edx
        push eax
        push str_FRNT2
        push esi
        call FindShape
        add esp, byte 8
        push eax
        call DrawShapeCore
        add esp, byte 0Ch
        push str_FRNT2
        push esi
        call FindShape
        mov edx, dword [byte eax+04h]
        mov eax, 17Ch
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov ebx, dword [byte edx+0Ch]
        sar ebx, 10h
        push str_FRNT2
        sub eax, ebx
        push esi
        mov ebx, eax
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, 280h
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov edx, dword [dword esp+0574h]
        mov edx, dword [byte edx+02Ch]
        mov edx, dword [byte edx+0Ah]
        push str_FRNT2
        sar edx, 10h
        push esi
        sub eax, edx
        mov edi, dword [byte edi+02Ch]
        mov dword [dword esp+056Ch], eax
        call FindShape
        add esp, byte 8
        mov ecx, ebx
        mov edx, edi
        mov ebx, dword [dword esp+0564h]
        call DrawPortrait
        call SetScreenTarget
        mov eax, dword [dword esp+0568h]
        mov ebx, dword [byte eax+02Ch]
        push ebx
        call BlitShape2
        add esp, byte 4
        push str_PANL3
        mov ecx, dword [dword esp+0564h]
        push ecx
.11:
        call FindShape
        add esp, byte 8
        push eax
        call DrawShapeAtOwnPos
        add esp, byte 4
        lea eax, [dword esp+04E4h]
        push eax
        push dword 186h
        push dword 140h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
.12:
        call PresentScreen
.13:
        cmp word [dword esp+0578h], byte 0
        je near GoalieMaskScreen.7
.14:
        mov ecx, dword [dword esp+0560h]
        push ecx
        call FreeMemBlock
        add esp, byte 4
        mov esi, dword [dword esp+056Ch]
        push esi
        call FreeMemBlock
        add esp, byte 4
        mov edi, dword [dword esp+0570h]
        push edi
        call FreeMemBlock
        add esp, byte 4
        mov ebp, dword [dword esp+0574h]
        push ebp
        call FreeBitmap
        add esp, byte 4
        mov eax, dword [dword esp+0568h]
        push eax
        xor ebx, ebx
        call FreeBitmap
        add esp, byte 4
.15:
        movsx esi, bx
        mov ecx, dword [dword esp+esi*8+02F4h]
        push ecx
        call FreeBitmap
        add esp, byte 4
        mov edi, dword [dword esp+esi*8+02F8h]
        push edi
        inc ebx
        call FreeBitmap
        add esp, byte 4
        cmp bx, byte 1Fh
        jl short .15
        push byte 0
        call OpenResourceArchive
        add esp, byte 4
        add esp, 580h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
        push ebx
        push ecx
        push edx
        mov ebx, 300h
        mov eax, FadePaletteBuffer
        xor edx, edx
        call memset_
        call WaitRetraceEdges
        push FadePaletteBuffer
        push dword 100h
        push byte 0
        call CountFrameTick
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
