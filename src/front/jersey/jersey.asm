; The jersey screen.
bits 32
%include "hockey.inc"
section s_CD13A progbits alloc exec nowrite align=1
extern AllocMemBlock, BlitArt, ConvertArtXY, CreateBitmap, DrawFrameBox, DrawRatingBars_158, DrawShadowBox, DrawTextAligned
extern FillRect, FreeBitmap, FreeMemBlock, GetLangText, InitListBox, InitMenuItems, JerseyAwayArt, JerseyChoice
extern JerseyHomeArt, JerseyMenuItems, MakeColor, NewPlayerRecord, PresentScreen, ResetClipWindow, RosterTeam, RosterTeams
extern RunMenu, SetClipWindow, SetDrawTarget, SetHighlightText, SetNormalText, SetScreenTarget, SetTextColor, sprintf_
extern str_D_JerseyScreen, str_JerseyMenu, str_JerseyMenuRegions
global DrawJerseyPreview, JerseyScreen
;-----------------------------------------------------------------------------
; DrawJerseyPreview                               CD13A  97 PC, low confidence
; Draws the jersey preview
;-----------------------------------------------------------------------------
DrawJerseyPreview:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, 1
        xor esi, esi
.1:
        imul eax, ebx, byte 52h
        mov edx, dword [JerseyMenuItems]
        add eax, edx
        cmp dword [byte eax+04h], byte 0
        je near .4
        mov esi, 1
        cmp ebx, dword [JerseyChoice]
        je near .4
        mov edi, dword [JerseyChoice]
        cmp byte [dword ebx+NewPlayerRecord], 0
        jne short .2
        mov edx, dword [byte eax+02Ah]
        add edx, byte 12h
        push edx
        mov edx, dword [byte eax+026h]
        push dword [byte eax+02Ah]
        add edx, byte 26h
        push edx
        push dword [byte eax+026h]
        call SetClipWindow
        add esp, byte 10h
        push byte 64h
        mov eax, dword [JerseyAwayArt]
        push byte 78h
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        mov dword [JerseyChoice], ebx
        jmp short .3
.2:
        mov dword [JerseyChoice], 0
.3:
        imul eax, edi, byte 52h
        mov edx, dword [JerseyMenuItems]
        add eax, edx
        mov edx, dword [byte eax+02Ah]
        add edx, byte 12h
        push edx
        mov edx, dword [byte eax+026h]
        push dword [byte eax+02Ah]
        add edx, byte 26h
        push edx
        push dword [byte eax+026h]
        call SetClipWindow
        add esp, byte 10h
        push byte 64h
        mov eax, dword [JerseyHomeArt]
        push byte 78h
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        mov dword [JerseyChoice], ebx
        call ResetClipWindow
.4:
        inc ebx
        cmp ebx, byte 64h
        jl near .1
        test esi, esi
        jne near DrawRatingBars_158
        cmp dword [JerseyChoice], byte 0
        je near DrawRatingBars_158
        imul edx, dword [JerseyChoice], byte 52h
        mov eax, dword [JerseyMenuItems]
        mov ebx, dword [byte edx+eax+02Ah]
        add ebx, byte 12h
        push ebx
        mov ebx, dword [byte edx+eax+026h]
        push dword [byte edx+eax+02Ah]
        add ebx, byte 26h
        push ebx
        push dword [byte edx+eax+026h]
        call SetClipWindow
        add esp, byte 10h
        push byte 64h
        mov eax, dword [JerseyHomeArt]
        push byte 78h
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call ResetClipWindow
        mov dword [JerseyChoice], esi
        jmp near DrawRatingBars_158
;-----------------------------------------------------------------------------
; JerseyScreen                                    CD272  97 PC, low confidence
; The jersey screen ("jersey menu" / "jersey menu regions")
;-----------------------------------------------------------------------------
JerseyScreen:
        push ecx
        push esi
        push edi
        enter 0B4h, 0
        push eax
        sub ebp, 82h
        mov byte [byte ebp+07Eh], dl
        mov dword [byte ebp+05Ah], ebx
        push byte 0
        push dword 12Ch
        push dword 19Ah
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push dword 0CEh
        push dword 19Ah
        mov esi, eax
        mov dword [byte ebp+06Eh], eax
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push dword 12Ch
        push dword 19Ah
        mov ebx, eax
        mov dword [byte ebp+05Eh], eax
        call CreateBitmap
        add esp, byte 0Ch
        mov edi, eax
        mov dword [byte ebp+052h], eax
        call SetScreenTarget
        push byte 64h
        push byte 78h
        push dword [byte esi+02Ch]
        call ConvertArtXY
        add esp, byte 0Ch
        call PresentScreen
        push edi
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        push byte 0
        push dword [byte esi+02Ch]
        call BlitArt
        add esp, byte 0Ch
        push ebx
        call SetDrawTarget
        add esp, byte 4
        push dword 0FF00AA00h
        call MakeColor
        add esp, byte 4
        push eax
        push dword 0CEh
        push dword 19Ah
        push byte 0
        push byte 0
        call FillRect
        add esp, byte 14h
        push dword 12Ch
        xor ebx, ebx
        mov edx, 8
        push dword 19Ah
        mov eax, dword [byte esi+02Ch]
        xor ecx, ecx
        call DrawShadowBox
        call SetHighlightText
        push byte 0FFFFFFFFh
        mov dword [byte ebp+06Ah], 78h
        call MakeColor
        add esp, byte 4
        mov dword [byte ebp+062h], 64h
        mov dword [byte ebp+066h], 19Ah
        call SetTextColor
        push esi
        mov dword [byte ebp+076h], 6
        mov ebx, 1
        call SetDrawTarget
        add esp, byte 4
        xor esi, esi
.1:
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push eax
        push byte 2
        mov eax, dword [byte ebp+076h]
        push dword 190h
        add eax, byte 12h
        push eax
        push byte 6
        mov dword [byte ebp+072h], 6
        xor edi, edi
        call FillRect
        add esp, byte 14h
.2:
        test esi, esi
        jg short .3
        test edi, edi
        jle short .5
.3:
        cmp byte [dword ebx+NewPlayerRecord], 0
        je short .4
        push dword 0FFAA0000h
        call MakeColor
        add esp, byte 4
        push eax
        push byte 12h
        push byte 26h
        push dword [byte ebp+076h]
        push dword [byte ebp+072h]
        call FillRect
        add esp, byte 14h
.4:
        push ebx
        mov eax, dword [byte ebp+076h]
        push str_D_JerseyScreen
        add eax, byte 3
        push eax
        mov eax, dword [byte ebp+072h]
        add eax, byte 13h
        push eax
        push byte 1
        inc ebx
        call DrawTextAligned
        add esp, byte 14h
.5:
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push eax
        push dword 0C6h
        push byte 2
        mov eax, dword [byte ebp+072h]
        push byte 6
        add eax, byte 26h
        push eax
        inc edi
        add dword [byte ebp+072h], byte 28h
        call FillRect
        add esp, byte 14h
        cmp edi, byte 0Ah
        jl short .2
        inc esi
        add dword [byte ebp+076h], byte 14h
        cmp esi, byte 0Ah
        jl near .1
        mov eax, dword [byte ebp+06Eh]
        mov eax, dword [byte eax+02Ch]
        xor edx, edx
        movsx ecx, word [byte eax+06h]
        movsx ebx, word [byte eax+04h]
        xor eax, eax
        mov dword [byte ebp+07Ah], 0
        call DrawFrameBox
        call SetNormalText
        cmp byte [byte ebp+07Eh], 64h
        jae near .17
        mov eax, dword [byte ebp-036h]
        imul eax, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        add eax, byte 42h
        push eax
        movzx eax, byte [byte ebp+07Eh]
        push eax
        mov eax, 0E5h
        call GetLangText
        push eax
        lea eax, [byte ebp-032h]
        push eax
        mov edi, 0D4h
        lea ebx, [byte ebp-032h]
        call sprintf_
.6:
        add esp, byte 10h
        cmp dword [byte ebp+07Ah], byte 0
        jne short .11
        xor esi, esi
        jmp short .8
.7:
        inc esi
.8:
        lea eax, [ebx+esi]
        cmp byte [eax], 0Ah
        je short .9
        cmp byte [eax], 5Eh
        je short .9
        cmp byte [eax], 0
        jne short .7
.9:
        cmp byte [esi+ebx], 0
        jne short .10
        inc dword [byte ebp+07Ah]
.10:
        push ebx
        mov eax, dword [byte ebp+066h]
        push edi
        sar eax, 1
        push eax
        mov byte [esi+ebx], 0
        inc esi
        push byte 1
        add edi, byte 14h
        add ebx, esi
        call DrawTextAligned
        jmp short .6
.11:
        push dword [byte ebp+05Ah]
        mov eax, 0E6h
        call GetLangText
        push eax
        lea eax, [byte ebp-032h]
        push eax
        lea ebx, [byte ebp-032h]
        mov dword [byte ebp+07Ah], 0
        call sprintf_
        add esp, byte 0Ch
.12:
        cmp dword [byte ebp+07Ah], byte 0
        jne near .23
        xor esi, esi
        jmp short .14
.13:
        inc esi
.14:
        lea eax, [ebx+esi]
        cmp byte [eax], 0Ah
        je short .15
        cmp byte [eax], 5Eh
        je short .15
        cmp byte [eax], 0
        jne short .13
.15:
        cmp byte [esi+ebx], 0
        jne short .16
        inc dword [byte ebp+07Ah]
.16:
        push ebx
        mov eax, dword [byte ebp+066h]
        push edi
        sar eax, 1
        push eax
        mov byte [esi+ebx], 0
        inc esi
        push byte 1
        add edi, byte 14h
        add ebx, esi
        call DrawTextAligned
        add esp, byte 10h
        jmp short .12
.17:
        push dword [byte ebp+05Ah]
        mov eax, 0E7h
        call GetLangText
        push eax
        lea eax, [byte ebp-032h]
        push eax
        mov edi, 0DCh
        lea ebx, [byte ebp-032h]
        call sprintf_
        add esp, byte 0Ch
.18:
        cmp dword [byte ebp+07Ah], byte 0
        jne short .23
        xor esi, esi
        jmp short .20
.19:
        inc esi
.20:
        lea eax, [ebx+esi]
        cmp byte [eax], 0Ah
        je short .21
        cmp byte [eax], 5Eh
        je short .21
        cmp byte [eax], 0
        jne short .19
.21:
        cmp byte [esi+ebx], 0
        jne short .22
        inc dword [byte ebp+07Ah]
.22:
        push ebx
        mov eax, dword [byte ebp+066h]
        push edi
        sar eax, 1
        push eax
        mov byte [esi+ebx], 0
        inc esi
        push byte 1
        add edi, byte 14h
        add ebx, esi
        call DrawTextAligned
        add esp, byte 10h
        jmp short .18
.23:
        call SetHighlightText
        push dword 0FFFFFF50h
        mov dword [byte ebp+07Ah], 0
        call MakeColor
        add esp, byte 4
        mov dword [byte ebp+076h], 9
        mov ebx, 1
        call SetTextColor
        push dword [byte ebp+05Eh]
        xor esi, esi
        call SetDrawTarget
        add esp, byte 4
.24:
        mov dword [byte ebp+072h], 19h
        xor edi, edi
.25:
        test esi, esi
        jg short .26
        test edi, edi
        jle short .28
.26:
        cmp byte [dword ebx+NewPlayerRecord], 0
        jne short .27
        push ebx
        push str_D_JerseyScreen
        push dword [byte ebp+076h]
        push dword [byte ebp+072h]
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
.27:
        inc ebx
.28:
        inc edi
        add dword [byte ebp+072h], byte 28h
        cmp edi, byte 0Ah
        jl short .25
        inc esi
        add dword [byte ebp+076h], byte 14h
        cmp esi, byte 0Ah
        jl short .24
        call SetNormalText
        push byte 0
        mov eax, dword [byte ebp+06Eh]
        push dword 2008h
        mov dword [JerseyHomeArt], eax
        mov eax, dword [byte ebp+05Eh]
        push str_JerseyMenu
        mov dword [JerseyAwayArt], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 1900h
        mov esi, 1
        push str_JerseyMenuRegions
        mov ebx, eax
        mov edi, eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp+056h], eax
        mov edx, ebx
        mov eax, 64h
        mov dword [JerseyMenuItems], ebx
        call InitMenuItems
.29:
        mov eax, esi
        mov ebx, 0Ah
        cdq
        idiv ebx
        imul edx, byte 28h
        mov eax, esi
        mov dword [byte ebp+072h], edx
        cdq
        idiv ebx
        imul eax, byte 14h
        mov edx, esi
        mov dword [byte ebp+076h], eax
        imul eax, esi, byte 52h
        shl edx, 6
        add eax, edi
        add edx, dword [byte ebp+056h]
        mov dword [byte eax+022h], 0
        mov dword [byte eax+014h], edx
        push byte 14h
        mov edx, dword [byte eax+022h]
        mov ecx, 28h
        mov dword [byte eax+01Eh], edx
        mov ebx, dword [byte ebp+062h]
        mov dword [byte eax+01Ah], edx
        mov edx, dword [byte ebp+06Ah]
        add ebx, byte 6
        add edx, byte 6
        add ebx, dword [byte ebp+076h]
        add edx, dword [byte ebp+072h]
        inc esi
        call InitListBox
        cmp esi, byte 64h
        jl short .29
        call SetScreenTarget
        push dword [byte ebp+062h]
        mov eax, dword [byte ebp+06Eh]
        push dword [byte ebp+06Ah]
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
.30:
        cmp dword [byte ebp+07Ah], byte 0
        jne short .31
        push byte 3
        lea eax, [byte ebp+04Eh]
        mov ecx, DrawJerseyPreview
        mov ebx, 0FFFFFFFFh
        push eax
        mov edx, edi
        mov eax, 64h
        call RunMenu
        mov eax, dword [byte ebp+04Eh]
        cmp byte [dword eax+NewPlayerRecord], 0
        jne short .30
        mov dword [byte ebp+07Ah], eax
        jmp short .30
.31:
        mov al, byte [byte ebp+04Eh]
        mov dword [JerseyChoice], 0
        push dword [byte ebp+056h]
        mov byte [byte ebp+07Eh], al
        call FreeMemBlock
        add esp, byte 4
        push edi
        call FreeMemBlock
        add esp, byte 4
        call SetScreenTarget
        push dword [byte ebp+062h]
        mov eax, dword [byte ebp+052h]
        push dword [byte ebp+06Ah]
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        push dword [byte ebp+052h]
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp+05Eh]
        call FreeBitmap
        add esp, byte 4
        push dword [byte ebp+06Eh]
        call FreeBitmap
        mov al, byte [byte ebp+07Eh]
        add esp, byte 4
        lea esp, [dword ebp+082h]
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
