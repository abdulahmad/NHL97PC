; Options animation screen.
bits 32
%include "hockey.inc"
section s_E759F progbits alloc exec nowrite align=1
extern BlankMenuItem, BlitShape, BlitShape2, ConvertArtXY, CreateBitmap, DrawArt, DrawScreenBackground, DrawShapeAtOwnPos
extern DrawStatTable, FadeInScreen, FindShape, FreeBitmap, FreeMemBlock, GetLangText, GripDriverPtr, GripPortWord
extern InitMenuItems, LoadDataFile, OptionsAnimArt, OptionsAnimBack, OptionsAnimFrames, OptionsAnimIndex, OptionsAnimItem, OptionsAnimItemFrames
extern OptionsAnimItems, OptionsAnimItemState, OptionsAnimOn, OptionsAnimShapeLists, OptionsAnimShapes, OptionsAnimSoundOn, OptionsAnimTitle, PlaySfx
extern PresentScreen, rand_, RunMenu, SecondsToSamples, SetScreenTarget, SetupOptionsAnim, ShowMessageBoxNoWait, ShowPopupScreen
extern sprintf_, StopAllSfx, str_AR02d2, str_BACK13, str_LT02d2, str_MB004, str_MB014, str_MB023
extern str_MB03, tickcount, UpdateOptionsAnim, WaitSoundTime
global OptionsAnimFrame, OptionsAnimFrame_20C, OptionsAnimScreen
;-----------------------------------------------------------------------------
; OptionsAnimFrame                                E759F  97 PC, low confidence
; Draws one frame of the options animation
;-----------------------------------------------------------------------------
OptionsAnimFrame:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 38h, 0
        call UpdateOptionsAnim
        imul eax, dword [OptionsAnimIndex], byte 38h
        mov ecx, 0Eh
        mov esi, dword [GripDriverPtr]
        lea edi, [byte ebp-038h]
        add esi, eax
        rep movsd
        mov eax, dword [byte ebp-02h]
        xor ah, ah
        and al, 0Fh
        movzx ebx, ax
        test ebx, ebx
        jl near .11
        cmp ebx, byte 0Ah
        jg near .11
        movsx ebx, word [nosplit ebx*2+OptionsAnimItemFrames]
        cmp dword [OptionsAnimItems+4], byte 1
        jne short .2
        cmp byte [OptionsAnimSoundOn], 0
        jne short .1
        mov eax, 309h
        call PlaySfx
        mov byte [OptionsAnimSoundOn], 1
.1:
        call rand_
        mov esi, 3
        cdq
        idiv esi
        mov eax, dword [nosplit edx*4+OptionsAnimFrames]
        mov dword [OptionsAnimItems+1Eh], eax
        call SetScreenTarget
        mov eax, dword [OptionsAnimItems+1Ah]
        movsx edx, word [byte eax+0Eh]
        push edx
        movsx eax, word [byte eax+0Ch]
        push eax
        push dword [OptionsAnimItems+1Eh]
        call DrawArt
        add esp, byte 0Ch
        call PresentScreen
.2:
        call SetScreenTarget
        cmp ebx, byte 0FFFFFFFFh
        jne short .4
        cmp byte [OptionsAnimSoundOn], 0
        je short .3
        call StopAllSfx
        mov byte [OptionsAnimSoundOn], 0
.3:
        cmp word [OptionsAnimOn], byte 0
        je near .10
        movsx eax, word [OptionsAnimItem]
        imul eax, byte 0Ch
        push dword [dword eax+OptionsAnimShapeLists]
        call DrawShapeAtOwnPos
        mov word [OptionsAnimOn], 0
        movsx eax, word [OptionsAnimItem]
        add esp, byte 4
        mov word [nosplit eax*2+OptionsAnimItemState], 0
        jmp near .10
.4:
        cmp word [nosplit ebx*2+OptionsAnimItemState], byte 0
        jne short .6
        cmp byte [OptionsAnimSoundOn], 0
        jne short .5
        mov eax, 309h
        call PlaySfx
        mov byte [OptionsAnimSoundOn], 1
.5:
        movsx eax, word [OptionsAnimItem]
        imul eax, byte 0Ch
        push dword [dword eax+OptionsAnimShapeLists]
        call BlitShape
        movsx eax, word [OptionsAnimItem]
        mov word [nosplit eax*2+OptionsAnimItemState], 0
        movsx eax, bx
        mov word [OptionsAnimItem], bx
        mov word [nosplit eax*2+OptionsAnimItemState], 1
        movsx eax, word [nosplit ebx*2+OptionsAnimItemState]
        mov esi, 3
        cdq
        idiv esi
        mov edx, eax
        imul eax, ebx, byte 0Ch
        add esp, byte 4
        jmp short .9
.6:
        cmp byte [OptionsAnimSoundOn], 0
        jne short .7
        mov eax, 309h
        call PlaySfx
        mov byte [OptionsAnimSoundOn], 1
.7:
        movsx eax, word [OptionsAnimItem]
        inc word [nosplit eax*2+OptionsAnimItemState]
        movsx eax, word [OptionsAnimItem]
        add eax, eax
        cmp word [dword eax+OptionsAnimItemState], byte 6
        jl short .8
        mov word [dword eax+OptionsAnimItemState], 1
.8:
        movsx eax, word [nosplit ebx*2+OptionsAnimItemState]
        mov ebx, 3
        cdq
        idiv ebx
        mov edx, eax
        movsx eax, word [OptionsAnimItem]
        imul eax, byte 0Ch
.9:
        shl edx, 2
        push dword [dword edx+eax+OptionsAnimShapes]
        call DrawShapeAtOwnPos
        mov word [OptionsAnimOn], 1
        add esp, byte 4
.10:
        call PresentScreen
.11:
        leave
OptionsAnimFrame_20C:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; OptionsAnimScreen                               E77B1  97 PC, low confidence
; Shows the options animation screen
;-----------------------------------------------------------------------------
OptionsAnimScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 0B0h, 0
        sub ebp, 82h
        movzx edx, word [GripPortWord]
        cmp edx, eax
        jge short .2
.1:
        mov eax, 64h
        jmp near .14
.2:
        imul esi, eax, byte 38h
        mov ecx, 0Eh
        mov edx, dword [GripDriverPtr]
        lea edi, [byte ebp+012h]
        add esi, edx
        rep movsd
        test byte [byte ebp+012h], 1
        je short .1
        test byte [byte ebp+012h], 2
        jne short .3
        push byte 1
        mov eax, 1EEh
        mov edx, 1
        xor ecx, ecx
        xor ebx, ebx
        call GetLangText
        call ShowMessageBoxNoWait
        jmp short .1
.3:
        mov dword [OptionsAnimIndex], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 8
        call LoadDataFile
        mov esi, eax
        mov dword [byte ebp+07Eh], eax
        mov eax, 3
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, 9
        call LoadDataFile
        push str_BACK13
        push esi
        mov ebx, eax
        mov dword [byte ebp+076h], eax
        call FindShape
        add esp, byte 8
        push str_MB014
        push ebx
        mov esi, eax
        mov dword [byte ebp+07Ah], eax
        call FindShape
        add esp, byte 8
        push str_MB023
        push ebx
        mov dword [OptionsAnimFrames], eax
        call FindShape
        add esp, byte 8
        push str_MB03
        push ebx
        mov dword [OptionsAnimTitle], eax
        call FindShape
        add esp, byte 8
        mov dword [OptionsAnimBack], eax
        call SetScreenTarget
        push esi
        call BlitShape
        add esp, byte 4
        mov eax, dword [tickcount]
        mov ebx, eax
        lea edx, [byte ebx+0Fh]
.4:
        mov eax, dword [tickcount]
        cmp eax, edx
        jl short .4
        xor ebx, ebx
.5:
        push ebx
        push str_AR02d2
        lea eax, [byte ebp+06Ah]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+06Ah]
        push eax
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push eax
        inc ebx
        inc ebx
        call BlitShape2
        add esp, byte 4
        cmp ebx, byte 0Eh
        jle short .5
        mov eax, dword [tickcount]
        mov ebx, eax
        lea edx, [byte ebx+0Fh]
.6:
        mov eax, dword [tickcount]
        cmp eax, edx
        jl short .6
        mov ebx, 1
.7:
        push ebx
        push str_AR02d2
        lea eax, [byte ebp+06Ah]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+06Ah]
        push eax
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        push eax
        inc ebx
        inc ebx
        call BlitShape2
        add esp, byte 4
        cmp ebx, byte 0Fh
        jle short .7
        call PresentScreen
        call SetScreenTarget
        xor ebx, ebx
.8:
        lea edi, [ebx+ebx]
        imul esi, ebx, byte 0Ch
        push edi
        push str_LT02d2
        lea eax, [byte ebp+06Ah]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+06Ah]
        push eax
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        inc edi
        push edi
        push str_LT02d2
        mov dword [dword esi+OptionsAnimShapes], eax
        lea eax, [byte ebp+06Ah]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp+06Ah]
        push eax
        push dword [byte ebp+07Eh]
        call FindShape
        add esp, byte 8
        mov edi, dword [dword esi+OptionsAnimShapes]
        mov dword [dword esi+OptionsAnimArt], eax
        push byte 0
        movsx eax, word [byte edi+06h]
        push eax
        movsx eax, word [byte edi+04h]
        push eax
        call CreateBitmap
        mov edi, eax
        mov dword [byte ebp+ebx*4+04Ah], eax
        mov eax, dword [dword esi+OptionsAnimShapes]
        add esp, byte 0Ch
        movsx edx, word [byte eax+0Eh]
        push edx
        movsx eax, word [byte eax+0Ch]
        push eax
        push dword [byte edi+02Ch]
        call ConvertArtXY
        mov eax, dword [dword esi+OptionsAnimShapes]
        mov edx, dword [byte edi+02Ch]
        mov ax, word [byte eax+0Ch]
        mov word [byte edx+0Ch], ax
        mov eax, dword [dword esi+OptionsAnimShapes]
        mov edx, dword [byte edi+02Ch]
        mov ax, word [byte eax+0Eh]
        mov word [byte edx+0Eh], ax
        inc ebx
        mov eax, dword [byte edi+02Ch]
        add esp, byte 0Ch
        mov dword [dword esi+OptionsAnimShapeLists], eax
        cmp ebx, byte 8
        jl near .8
        mov ebx, dword [byte ebp+07Ah]
        call PresentScreen
        mov edx, ebx
        mov eax, ebx
        call DrawScreenBackground
        mov edx, OptionsAnimItems
        mov eax, 2
        mov ecx, str_MB014
        call InitMenuItems
        lea eax, [byte ebp-02Eh]
        mov edi, OptionsAnimItems+52h
        push eax
        mov ebx, str_MB004
        mov edx, dword [byte ebp+076h]
        push str_MB023
        mov eax, OptionsAnimItems
        mov esi, BlankMenuItem
        call DrawStatTable
        mov ecx, 52h
        rep movsb
        mov dword [byte ebp+072h], 0
        mov dword [OptionsAnimItems+52h], 2
        xor esi, esi
.9:
        test esi, esi
        jne short .12
        push byte 2
        lea eax, [byte ebp+072h]
        mov ecx, OptionsAnimFrame
        mov ebx, 0FFFFFFFFh
        push eax
        mov edx, OptionsAnimItems
        mov eax, 2
        call RunMenu
        cmp dword [byte ebp+072h], byte 0
        jbe short .10
        cmp dword [byte ebp+072h], byte 1
        je short .11
        jmp short .9
.10:
        mov eax, OptionsAnimItems
        mov edx, 1
        call ShowPopupScreen
        xor ecx, ecx
        push byte 1
        mov eax, 1AFh
        xor ebx, ebx
        call GetLangText
        call ShowMessageBoxNoWait
        movzx eax, word [OptionsAnimIndex]
        call SetupOptionsAnim
        jmp short .9
.11:
        call FadeInScreen
        mov esi, 1
        jmp short .9
.12:
        xor ebx, ebx
.13:
        push dword [byte ebp+ebx*4+04Ah]
        call FreeBitmap
        inc ebx
        add esp, byte 4
        cmp ebx, byte 8
        jl short .13
        push dword [byte ebp+07Eh]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+076h]
        call FreeMemBlock
        mov eax, 64h
        add esp, byte 4
.14:
        lea esp, [dword ebp+082h]
        pop ebp
        jmp near OptionsAnimFrame_20C
