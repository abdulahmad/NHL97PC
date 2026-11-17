; Credits screen.
bits 32
%include "hockey.inc"
section s_D6D37 progbits alloc exec nowrite align=1
extern ArenaFileName, BlitArt, BlitShape2, ChkMenuMusic, ConvertArtXY, CreateBitmap, CreditsBitmap, CreditsKeyFlag
extern CreditsKeyTimer, CreditsLastLine, CreditsLastY, CreditsLine, CreditsScrollY, DrawScreenBackground, DrawShapeCore, DrawTextAligned
extern fclose_, fgets_, FillRect, FindShape, fopen_, FreeBitmap, FreeMemBlock, IsKeyDown
extern KbdGetKey, LoadDataFile, MakeColor, MakeDataPath, MouseMoved, PauseMusic, PresentFuncInput, PresentScreen
extern rand_, RequestMusicStop, SecondsToSamples, ServiceIdle, SetDrawTarget, SetHighlightText, SetNormalText, SetScreenTarget
extern SetTextColor, sscanf_, str_CRD1, str_CRD2, str_D2, str_EAC1, str_EAC2, str_QCRD
extern str_Ring, str_Rt_CreditsScreen, strlen_, tickcount, WaitMusicEnd, WaitSoundTime, WipeScreen
global DrawCreditsPage, ScrollCredits, CreditsKeyPressed, PlayCreditsMusic, CreditsScreen
        db 090h
;-----------------------------------------------------------------------------
; DrawCreditsPage                                 D6D38  97 PC, low confidence
; Draws one page of the credits
;-----------------------------------------------------------------------------
DrawCreditsPage:
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov dword [esp], eax
        mov ebp, edx
        mov esi, ebx
        mov edi, ecx
        push edx
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        push byte 0
        mov edx, dword [byte esp+08h]
        push edx
        xor ebx, ebx
        call BlitArt
        add esp, byte 0Ch
        jmp short .3
.1:
        imul eax, byte 0Ch
        add eax, edi
        mov dx, word [byte eax+08h]
        mov cx, word [byte eax+06h]
        add ecx, edx
        mov word [byte eax+06h], cx
        test cx, cx
        jle short .2
        cmp cx, 1E0h
        jge short .2
        mov ecx, dword [eax]
        mov edx, dword [byte eax+04h]
        push ecx
        sar edx, 10h
        mov eax, dword [byte eax+02h]
        push edx
        sar eax, 10h
        push eax
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
.2:
        inc ebx
.3:
        movsx eax, bx
        cmp eax, esi
        jl short .1
        call SetScreenTarget
        mov esi, dword [byte ebp+02Ch]
        push esi
        call BlitShape2
        add esp, byte 4
        call PresentScreen
        call ServiceIdle
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
        push ecx
        push byte 0
        push byte 32h
        push byte 32h
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [CreditsBitmap], eax
        call SetScreenTarget
        push dword 0D7h
        mov eax, dword [CreditsBitmap]
        push dword 127h
        mov edx, dword [byte eax+02Ch]
        push edx
        call ConvertArtXY
        add esp, byte 0Ch
        mov ebx, 140h
        call PresentScreen
        mov ecx, 0F0h
        mov dword [CreditsLine], ebx
        mov dword [CreditsScrollY], ecx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ScrollCredits                                   D6E20  97 PC, low confidence
; Scrolls the credits
;-----------------------------------------------------------------------------
ScrollCredits:
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov dword [byte esp+010h], eax
        mov dword [byte esp+014h], edx
        mov dword [byte esp+0Ch], ecx
        mov edx, 1
        mov esi, edx
        mov dword [byte esp+08h], edx
        cmp ebx, edx
        jl near .7
        xor eax, eax
        mov dword [byte esp+018h], eax
.1:
        call CreditsKeyPressed
        test eax, eax
        je short .2
        xor esi, esi
        mov dword [byte esp+08h], esi
        jmp near .7
.2:
        mov edx, dword [byte esp+010h]
        mov ecx, dword [CreditsLine]
        sub edx, ecx
        imul edx, esi
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov edi, dword [CreditsScrollY]
        mov edx, dword [byte esp+014h]
        sub edx, edi
        imul edx, esi
        lea ebp, [ecx+eax]
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        add edi, eax
        cmp ebp, dword [CreditsLastLine]
        jne short .3
        cmp edi, dword [CreditsLastY]
        je near .6
.3:
        call SetScreenTarget
        mov edx, dword [byte esp+014h]
        mov ecx, dword [CreditsScrollY]
        mov eax, dword [byte esp+018h]
        sub edx, ecx
        imul edx, eax
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        add eax, ecx
        mov edx, dword [byte esp+010h]
        sub eax, byte 19h
        mov ecx, dword [CreditsLine]
        push eax
        sub edx, ecx
        mov eax, dword [byte esp+01Ch]
        imul edx, eax
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        add eax, ecx
        sub eax, byte 19h
        push eax
        mov eax, dword [CreditsBitmap]
        mov ecx, dword [byte eax+02Ch]
        push ecx
        call BlitArt
        add esp, byte 0Ch
        lea eax, [byte edi-019h]
        mov dword [esp], eax
        push eax
        lea eax, [byte ebp-019h]
        mov dword [byte esp+08h], eax
        push eax
        mov eax, dword [CreditsBitmap]
        mov ecx, dword [byte eax+02Ch]
        push ecx
        call ConvertArtXY
        add esp, byte 0Ch
        mov eax, dword [esp]
        push eax
        mov edx, dword [byte esp+08h]
        push edx
        mov ecx, dword [byte esp+014h]
        push ecx
        call DrawShapeCore
        add esp, byte 0Ch
        call PresentScreen
        mov eax, dword [tickcount]
        lea edx, [byte eax+05h]
.4:
        mov eax, dword [tickcount]
        cmp eax, edx
        jge short .5
        call ServiceIdle
        jmp short .4
.5:
        mov dword [CreditsLastY], edi
        mov dword [CreditsLastLine], ebp
.6:
        mov ecx, dword [byte esp+018h]
        inc ecx
        inc esi
        mov dword [byte esp+018h], ecx
        cmp esi, ebx
        jle near .1
.7:
        mov eax, dword [byte esp+08h]
        mov dword [CreditsScrollY], edi
        mov dword [CreditsLine], ebp
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        call SetScreenTarget
        mov eax, dword [CreditsScrollY]
        sub eax, byte 19h
        push eax
        mov eax, dword [CreditsLine]
        sub eax, byte 19h
        push eax
        mov eax, dword [CreditsBitmap]
        mov edx, dword [byte eax+02Ch]
        push edx
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        mov ebx, dword [CreditsBitmap]
        push ebx
        call FreeBitmap
        xor ecx, ecx
        add esp, byte 4
        mov dword [CreditsScrollY], ecx
        mov dword [CreditsLine], ecx
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CreditsKeyPressed                               D6FD8  97 PC, low confidence
; Returns whether a key or button was pressed during the credits
;-----------------------------------------------------------------------------
CreditsKeyPressed:
        push ebx
        push ecx
        push edx
        push esi
        push byte 1
        call IsKeyDown
        xor ebx, ebx
        add esp, byte 4
        test eax, eax
        jne short .1
        push byte 39h
        call IsKeyDown
        add esp, byte 4
        test eax, eax
        je short .2
.1:
        mov ebx, 1
.2:
        call dword [PresentFuncInput]
        cmp dword [MouseMoved], byte 0
        je short .3
        mov ebx, 1
.3:
        call KbdGetKey
        cmp al, 78h
        jne short .4
        xor esi, esi
        mov dword [CreditsKeyFlag], esi
        mov dword [CreditsKeyTimer], esi
        jmp short .5
.4:
        mov ecx, dword [CreditsKeyTimer]
        and eax, 0FFh
        add ecx, eax
        mov dword [CreditsKeyTimer], ecx
.5:
        cmp dword [CreditsKeyTimer], 2F2h
        jne short .6
        mov dword [CreditsKeyFlag], 1
.6:
        mov eax, ebx
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PlayCreditsMusic                                D705C  97 PC, low confidence
; Starts the credits music
;-----------------------------------------------------------------------------
PlayCreditsMusic:
        push ebx
        push edx
        sub esp, byte 50h
        call WaitMusicEnd
        call PauseMusic
        call rand_
        mov edx, eax
        mov ebx, 2
        sar edx, 1Fh
        idiv ebx
        mov ebx, edx
        mov edx, esp
        mov eax, ebx
        call ArenaFileName
        mov eax, esp
        lea edx, [byte ebx+01h]
        call ChkMenuMusic
        mov ebx, 2
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov eax, edx
        mov edx, esp
        call ArenaFileName
        mov eax, esp
        call ChkMenuMusic
        mov eax, ebx
        call SecondsToSamples
        call WaitSoundTime
        call RequestMusicStop
        add esp, byte 50h
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CreditsScreen                                   D70C4  97 PC, low confidence
; From RunFrontEnd: the credits (reads the credits text file, EAC1/EAC2,
; CRD1/CRD2, QCRD) with the arena music
;-----------------------------------------------------------------------------
CreditsScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 6B80h
        xor edx, edx
        xor ah, ah
        mov dword [dword esp+06B70h], edx
        mov byte [dword esp+06B74h], ah
        call WaitMusicEnd
        call PauseMusic
        lea edx, [dword esp+06AF8h]
        mov eax, 7
        call ArenaFileName
        lea eax, [dword esp+06AF8h]
        call ChkMenuMusic
        mov eax, 2
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        call RequestMusicStop
        mov eax, 0FAh
        call LoadDataFile
        push byte 0
        push dword 1E0h
        push dword 280h
        mov dword [dword esp+06B64h], eax
        call CreateBitmap
        add esp, byte 0Ch
        mov edx, 0FBh
        mov dword [dword esp+06B54h], eax
        lea eax, [dword esp+06AA8h]
        call MakeDataPath
        mov edx, str_Rt_CreditsScreen
        lea eax, [dword esp+06AA8h]
        call fopen_
        mov esi, eax
        test eax, eax
        je near .24
        lea eax, [dword esp+039D0h]
        add eax, 0A4h
        lea ecx, [dword esp+039D0h]
        mov dword [dword esp+06B50h], eax
        lea eax, [dword esp+039D0h]
        xor ebp, ebp
        add eax, 0A0h
        add ecx, byte 50h
        mov dword [dword esp+06B4Ch], eax
.1:
        imul eax, ebp, dword 0A8h
        lea edi, [dword esp+039D0h]
        mov edx, 50h
        mov ebx, esi
        mov dword [dword esp+06B48h], eax
        add edi, eax
        mov eax, ecx
        call fgets_
        mov eax, ecx
        mov ebx, dword [dword esp+06B48h]
        call strlen_
        add eax, ebx
        xor dl, dl
        mov ebx, esi
        mov byte [dword esp+eax+03A1Fh], dl
        mov edx, 50h
        mov eax, edi
        call fgets_
        mov eax, edi
        mov edi, dword [dword esp+06B48h]
        call strlen_
        add eax, edi
        xor dh, dh
        mov ebx, esi
        mov byte [dword esp+eax+039CFh], dh
        mov edx, 50h
        lea eax, [dword esp+06AA8h]
        call fgets_
        mov eax, dword [dword esp+06B4Ch]
        push eax
        push str_D2
        lea eax, [dword esp+06AB0h]
        push eax
        mov edx, 50h
        call sscanf_
        add esp, byte 0Ch
        mov ebx, esi
        lea eax, [dword esp+06AA8h]
        call fgets_
        mov edx, dword [dword esp+06B50h]
        push edx
        push str_D2
        lea eax, [dword esp+06AB0h]
        push eax
        inc ebp
        call sscanf_
        add esp, byte 0Ch
        add ecx, 0A8h
        mov edi, dword [dword esp+06B4Ch]
        lea ebx, [dword edx+0A8h]
        add edi, 0A8h
        mov dword [dword esp+06B50h], ebx
        mov dword [dword esp+06B4Ch], edi
        cmp ebp, byte 1Ch
        jl near .1
        mov eax, esi
        mov edx, 0FCh
        call fclose_
        lea eax, [dword esp+06AA8h]
        call MakeDataPath
        mov edx, str_Rt_CreditsScreen
        lea eax, [dword esp+06AA8h]
        call fopen_
        mov esi, eax
        test eax, eax
        je near .24
        lea eax, [dword esp+05D88h]
        add eax, 0A4h
        mov dword [dword esp+06B6Ch], eax
        lea eax, [dword esp+05D88h]
        add eax, 0A0h
        mov dword [dword esp+06B68h], eax
        lea eax, [dword esp+05D88h]
        xor ebp, ebp
        lea ecx, [byte eax+050h]
.2:
        imul eax, ebp, dword 0A8h
        lea edi, [dword esp+05D88h]
        mov edx, 50h
        mov ebx, esi
        mov dword [dword esp+06B48h], eax
        add edi, eax
        mov eax, ecx
        call fgets_
        mov eax, ecx
        mov edx, dword [dword esp+06B48h]
        call strlen_
        add eax, edx
        xor bl, bl
        mov edx, 50h
        mov byte [dword esp+eax+05DD7h], bl
        mov ebx, esi
        mov eax, edi
        call fgets_
        mov eax, edi
        mov ebx, dword [dword esp+06B48h]
        call strlen_
        add eax, ebx
        xor bh, bh
        mov edx, 50h
        mov byte [dword esp+eax+05D87h], bh
        lea eax, [dword esp+06AA8h]
        mov ebx, esi
        mov edi, dword [dword esp+06B68h]
        call fgets_
        push edi
        push str_D2
        lea eax, [dword esp+06AB0h]
        push eax
        mov edx, 50h
        call sscanf_
        add esp, byte 0Ch
        mov ebx, esi
        lea eax, [dword esp+06AA8h]
        call fgets_
        mov eax, dword [dword esp+06B6Ch]
        push eax
        push str_D2
        lea eax, [dword esp+06AB0h]
        push eax
        inc ebp
        call sscanf_
        add esp, byte 0Ch
        add ecx, 0A8h
        mov edx, dword [dword esp+06B6Ch]
        lea ebx, [dword edi+0A8h]
        add edx, 0A8h
        mov dword [dword esp+06B68h], ebx
        mov dword [dword esp+06B6Ch], edx
        cmp ebp, byte 14h
        jl near .2
        mov eax, esi
        call fclose_
        push str_Ring
        mov ecx, dword [dword esp+06B5Ch]
        push ecx
        call FindShape
        add esp, byte 8
        mov cl, byte [dword esp+06B74h]
        mov edi, eax
        test cl, cl
        jne short .3
        mov esi, dword [dword esp+06B54h]
        push esi
        call SetDrawTarget
        add esp, byte 4
        push str_EAC1
        mov ebp, dword [dword esp+06B5Ch]
        push ebp
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        push str_EAC2
        push ebp
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        call SetScreenTarget
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte esi+02Ch]
        call WipeScreen
        call PresentScreen
.3:
        call SetHighlightText
        push byte 0
        push byte 32h
        push byte 32h
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [CreditsBitmap], eax
        call SetScreenTarget
        push dword 0D7h
        mov eax, dword [CreditsBitmap]
        push dword 127h
        mov edx, dword [byte eax+02Ch]
        push edx
        call ConvertArtXY
        add esp, byte 0Ch
        mov ebx, 140h
        xor esi, esi
        call PresentScreen
        mov ecx, 0F0h
        mov dword [CreditsLine], ebx
        mov dword [CreditsScrollY], ecx
.4:
        imul ebp, esi, dword 0A8h
        call SetScreenTarget
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        push byte 24h
        push dword 104h
        push dword 19Bh
        push byte 2Eh
        call FillRect
        add esp, byte 14h
        push byte 0FFFFFFFFh
        lea ebx, [dword esp+039D4h]
        call MakeColor
        add esp, byte 4
        add ebx, ebp
        call SetTextColor
        push ebx
        push dword 19Fh
        push dword 0AFh
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        push dword 0FFFFFF50h
        call MakeColor
        add esp, byte 4
        add ebx, byte 50h
        call SetTextColor
        push ebx
        push dword 1AEh
        push dword 0AFh
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov ebx, 1Eh
        call PresentScreen
        mov ecx, edi
        mov edx, dword [dword esp+ebp+03A74h]
        mov eax, dword [dword esp+ebp+03A70h]
        call ScrollCredits
        test eax, eax
        jne short .5
        mov esi, 1Ch
.5:
        mov eax, dword [tickcount]
        lea edx, [dword eax+0C8h]
.6:
        mov eax, dword [tickcount]
        cmp eax, edx
        jge short .7
        call ServiceIdle
        call CreditsKeyPressed
        test eax, eax
        je short .6
        mov esi, 1Ch
        jmp short .6
.7:
        inc esi
        cmp esi, byte 1Ch
        jl near .4
        call SetScreenTarget
        mov eax, dword [CreditsScrollY]
        sub eax, byte 19h
        push eax
        mov eax, dword [CreditsLine]
        sub eax, byte 19h
        push eax
        mov eax, dword [CreditsBitmap]
        mov esi, dword [byte eax+02Ch]
        push esi
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        mov ebp, dword [CreditsBitmap]
        push ebp
        call FreeBitmap
        add esp, byte 4
        xor eax, eax
        xor ch, ch
        mov ebx, dword [dword esp+06B54h]
        mov dword [CreditsScrollY], eax
        push ebx
        mov dword [CreditsLine], eax
        mov byte [dword esp+06B7Ch], ch
        call SetDrawTarget
        add esp, byte 4
        push str_QCRD
        mov ecx, dword [dword esp+06B5Ch]
        push ecx
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        call SetScreenTarget
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte ebx+02Ch]
        call WipeScreen
        call PresentScreen
        push ebx
        call FreeBitmap
        add esp, byte 4
        push byte 0
        push byte 32h
        push byte 32h
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [CreditsBitmap], eax
        call SetScreenTarget
        push dword 0D7h
        mov eax, dword [CreditsBitmap]
        push dword 127h
        mov ebp, dword [byte eax+02Ch]
        push ebp
        mov esi, ebx
        call ConvertArtXY
        add esp, byte 0Ch
        xor esi, ebx
        call PresentScreen
        mov eax, 140h
        mov edx, 0F0h
        mov dword [CreditsLine], eax
        mov dword [CreditsScrollY], edx
.8:
        cmp byte [dword esp+06B78h], 0
        je near .11
.9:
        call SetScreenTarget
        mov eax, dword [CreditsScrollY]
        sub eax, byte 19h
        push eax
        mov eax, dword [CreditsLine]
        sub eax, byte 19h
        push eax
        mov eax, dword [CreditsBitmap]
        mov ebx, dword [byte eax+02Ch]
        push ebx
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        mov ecx, dword [CreditsBitmap]
        push ecx
        xor esi, esi
        call FreeBitmap
        add esp, byte 4
        mov dword [CreditsScrollY], esi
        mov dword [CreditsLine], esi
        call SetHighlightText
        push str_CRD2
        mov ebp, dword [dword esp+06B5Ch]
        xor bh, bh
        push ebp
        mov byte [dword esp+06B84h], bh
        call FindShape
        add esp, byte 8
        mov edx, 0D5h
        mov dword [dword esp+06B60h], eax
        lea eax, [dword esp+06AA8h]
        call MakeDataPath
        mov edx, str_Rt_CreditsScreen
        lea eax, [dword esp+06AA8h]
        call fopen_
        mov dword [dword esp+06B64h], eax
        test eax, eax
        je near .24
        mov edi, 1CCh
        mov esi, esp
        lea ecx, [dword esp+04C30h]
        xor ebp, ebp
.10:
        mov ebx, dword [dword esp+06B64h]
        mov edx, 28h
        mov eax, esi
        call fgets_
        test eax, eax
        je near .16
        mov eax, esi
        call strlen_
        cmp eax, byte 1
        jbe near .15
        add ecx, byte 0Ch
        mov word [byte ecx-08h], 0A0h
        mov word [byte ecx-06h], di
        mov word [byte ecx-02h], di
        mov dword [byte ecx-0Ch], esi
        inc ebp
        mov word [byte ecx-04h], 0FFFFh
        add edi, byte 0Fh
        add esi, byte 28h
        jmp short .10
.11:
        imul ebp, esi, dword 0A8h
        call SetScreenTarget
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        push byte 24h
        push dword 103h
        push dword 19Bh
        push byte 2Eh
        call FillRect
        add esp, byte 14h
        push byte 0FFFFFFFFh
        lea ebx, [dword esp+05D8Ch]
        call MakeColor
        add esp, byte 4
        add ebx, ebp
        call SetTextColor
        push ebx
        push dword 19Fh
        push dword 0AFh
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        push dword 0FFFFFF50h
        call MakeColor
        add esp, byte 4
        add ebx, byte 50h
        call SetTextColor
        push ebx
        push dword 1AEh
        push dword 0AFh
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov ebx, 1Eh
        call PresentScreen
        mov ecx, edi
        mov edx, dword [dword esp+ebp+05E2Ch]
        mov eax, dword [dword esp+ebp+05E28h]
        call ScrollCredits
        test eax, eax
        jne short .12
        mov ah, 1
        mov esi, 14h
        mov byte [dword esp+06B78h], ah
.12:
        mov eax, dword [tickcount]
        mov bl, 1
        lea edx, [dword eax+0C8h]
.13:
        mov eax, dword [tickcount]
        cmp eax, edx
        jge short .14
        call ServiceIdle
        call CreditsKeyPressed
        test eax, eax
        je short .13
        mov esi, 14h
        mov byte [dword esp+06B78h], bl
        jmp short .13
.14:
        inc esi
        cmp esi, byte 14h
        jl near .8
        jmp near .9
.15:
        add edi, byte 28h
        jmp near .10
.16:
        mov eax, dword [dword esp+06B64h]
        call fclose_
        push byte 0
        push dword 1E0h
        push dword 140h
        call CreateBitmap
        add esp, byte 0Ch
        mov edi, eax
        mov eax, dword [byte eax+02Ch]
        push byte 0FFFFFFFFh
        mov word [byte eax+0Ch], 140h
        call MakeColor
        add esp, byte 4
        mov cl, byte [dword esp+06B7Ch]
        call SetTextColor
        test cl, cl
        jne short .17
        call SetScreenTarget
        push byte 0
        push byte 0
        push str_CRD1
        mov eax, dword [dword esp+06B64h]
        push eax
        call FindShape
        add esp, byte 8
        push eax
        call BlitArt
        add esp, byte 0Ch
        push byte 0
        push dword 140h
        mov edx, dword [dword esp+06B68h]
        push edx
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
.17:
        push str_CRD1
        mov ebx, dword [dword esp+06B5Ch]
        push ebx
        call FindShape
        add esp, byte 8
        push str_CRD1
        mov ecx, dword [dword esp+06B5Ch]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push str_CRD1
        mov esi, eax
        mov eax, dword [dword esp+06B5Ch]
        push eax
        call FindShape
        add esp, byte 8
        mov edx, esi
        call DrawScreenBackground
        cmp word [dword esp+06B70h], byte 0
        jne near .23
        lea edx, [byte ebp-01h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 2
        mov dword [dword esp+06B5Ch], eax
.18:
        cmp byte [dword esp+06B7Ch], 0
        jne near .23
        call ServiceIdle
        lea ecx, [dword esp+04C30h]
        mov eax, dword [dword esp+06B60h]
        mov ebx, ebp
        mov edx, edi
        call DrawCreditsPage
        call ServiceIdle
        mov eax, dword [tickcount]
        lea esi, [byte eax+02h]
.19:
        mov eax, dword [tickcount]
        cmp eax, esi
        jge short .20
        call ServiceIdle
        jmp short .19
.20:
        mov eax, dword [dword esp+06B5Ch]
        mov eax, dword [dword esp+eax+04C34h]
        sar eax, 10h
        cmp eax, byte 0FFFFFFF6h
        jge short .21
        mov dword [dword esp+06B70h], 1
.21:
        call ServiceIdle
        call CreditsKeyPressed
        test eax, eax
        je short .22
        mov dword [dword esp+06B70h], 1
.22:
        cmp word [dword esp+06B70h], byte 0
        je near .18
.23:
        call PresentScreen
        call SetNormalText
        push edi
        call FreeBitmap
        add esp, byte 4
        mov edx, dword [dword esp+06B58h]
        push edx
        call FreeMemBlock
        add esp, byte 4
        call PlayCreditsMusic
.24:
        add esp, 6B80h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
