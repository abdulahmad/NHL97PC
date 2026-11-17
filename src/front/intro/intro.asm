; The intro movie.
bits 32
%include "hockey.inc"
section s_D68DD progbits alloc exec nowrite align=1
extern AllocGfxFixBuffer, AllocMemBlock, ArenaFileName, BlitShape, ChkMenuMusic, ClearScreen, CountFrameTick, FadePalette
extern FillRect, FindShape, FreeMemBlock, FreeVideoBuffer, GetPaletteRange, IntroPalette, KbdIdleCall, LoadDataFile
extern MakeColor, memcpy_, memset_, MusicPlaying, PlayScreenMovie, PresentScreen, RequestMusicStop, RunDemoGame
extern SecondsToSamples, ServiceIdle, SetGraphicsMode, SetScreenTarget, SetTickDeadline, str_Bkgd, str_Nhll, str_Nhlp
extern str_Pal3, str_Pl0, str_Pl1, str_Scr1, str_Scr2, tickcount, WaitMusicEnd, WaitSoundTime
extern WaitTickDeadline
global RunIntroMovie, RunIntro
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RunIntroMovie                                   D68E0  97 PC, low confidence
; Plays the intro movie and then the demo game
;-----------------------------------------------------------------------------
RunIntroMovie:
        push ebx
        push ecx
        push edx
        mov ebx, 1
        xor ecx, ecx
.1:
        test ebx, ebx
        sete al
        xor edx, edx
        mov dl, al
        mov eax, 0E6h
        mov ebx, ecx
        call PlayScreenMovie
        mov edx, eax
        test eax, eax
        jne short .2
        mov edx, 1
        mov eax, 0E7h
        call PlayScreenMovie
        mov edx, eax
.2:
        test edx, edx
        jne short .3
        call RunDemoGame
        mov edx, eax
        call WaitMusicEnd
.3:
        test edx, edx
        je short .1
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; RunIntro                                     D6930  96 PC, medium confidence
; From StartUp: the intro screens (scr1, scr2, !pl0, !pl1, backgrounds) with
; music, then the movies
;-----------------------------------------------------------------------------
RunIntro:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 68h
        call SetScreenTarget
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        call ClearScreen
        add esp, byte 4
        call PresentScreen
        call FreeVideoBuffer
        push byte 8
        push dword 1E0h
        push dword 280h
        call SetGraphicsMode
        add esp, byte 0Ch
        call AllocGfxFixBuffer
        call SetScreenTarget
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        call ClearScreen
        add esp, byte 4
        call PresentScreen
        mov eax, 62h
        xor edx, edx
        call LoadDataFile
        push byte 20h
        push dword 300h
        push str_Scr1
        mov edi, eax
        mov dword [byte esp+060h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 20h
        push dword 300h
        push str_Scr2
        mov ebp, eax
        call AllocMemBlock
        mov dword [byte esp+064h], eax
        add esp, byte 0Ch
        push byte 20h
        push dword 300h
        push str_Pal3
        mov dword [byte esp+068h], eax
        call AllocMemBlock
        mov dword [byte esp+070h], eax
        add esp, byte 0Ch
        mov edx, esp
        mov dword [byte esp+050h], eax
        mov eax, 8
        call ArenaFileName
        mov eax, esp
        mov ebx, 300h
        call ChkMenuMusic
        mov eax, 2
        xor edx, edx
        call SecondsToSamples
        call WaitSoundTime
        mov eax, dword [byte esp+064h]
        xor esi, esi
        call memset_
        mov edx, dword [byte esp+064h]
        push edx
        push dword 100h
        push esi
        call CountFrameTick
        add esp, byte 0Ch
        push str_Pl0
        push edi
        call FindShape
        add esp, byte 8
        lea edx, [byte eax+010h]
        mov ebx, 300h
        mov eax, ebp
        call memcpy_
        push str_Pl1
        push edi
        call FindShape
        add esp, byte 8
        lea edx, [byte eax+010h]
        mov ebx, 300h
        mov eax, dword [byte esp+058h]
        call memcpy_
        mov ebx, 300h
        mov edx, 3Fh
        mov eax, dword [byte esp+064h]
        call memset_
        push str_Nhll
        push edi
        call FindShape
        add esp, byte 8
        mov ebx, eax
        mov dword [byte esp+060h], eax
        call SetScreenTarget
        push str_Bkgd
        push edi
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push ebx
        call BlitShape
        add esp, byte 4
        call PresentScreen
        push byte 14h
        call SetTickDeadline
        add esp, byte 4
        call WaitTickDeadline
        mov ebx, dword [byte esp+064h]
        mov eax, dword [tickcount]
        push ebx
        push dword 100h
        push esi
        mov edi, eax
        call CountFrameTick
        add esp, byte 0Ch
        call RequestMusicStop
        call ServiceIdle
        push byte 14h
        call SetTickDeadline
        add esp, byte 4
        mov ebx, 2
        call WaitTickDeadline
        mov edx, ebp
        xor eax, eax
        call FadePalette
.1:
        mov eax, dword [tickcount]
        sub eax, edi
        cmp eax, 15Eh
        jge short .3
        test esi, esi
        jne short .2
        call KbdIdleCall
        mov esi, eax
.2:
        call ServiceIdle
        jmp short .1
.3:
        mov ebx, 25Eh
        lea eax, [byte ebp+04Bh]
        xor edx, edx
        call memset_
        mov ebx, 3
        mov edx, ebp
        xor eax, eax
        call FadePalette
        call SetScreenTarget
        mov eax, dword [byte esp+060h]
        mov eax, dword [byte eax+04h]
        push byte 0
        sar eax, 10h
        push eax
        mov eax, dword [byte esp+068h]
        mov eax, dword [byte eax+02h]
        sar eax, 10h
        push eax
        mov eax, dword [byte esp+06Ch]
        mov eax, dword [byte eax+0Ch]
        sar eax, 10h
        push eax
        mov eax, dword [byte esp+070h]
        mov eax, dword [byte eax+0Ah]
        sar eax, 10h
        push eax
        call FillRect
        add esp, byte 14h
        push str_Nhlp
        mov ecx, dword [byte esp+058h]
        push ecx
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        mov ebx, 4Bh
        call PresentScreen
        mov edx, dword [byte esp+05Ch]
        mov eax, ebp
        call memcpy_
        mov ebx, 2
        mov edx, ebp
        xor eax, eax
        call FadePalette
        mov ebx, 2
        mov edx, dword [byte esp+05Ch]
        xor eax, eax
        call FadePalette
.4:
        mov eax, dword [tickcount]
        sub eax, edi
        cmp eax, 2BCh
        jge short .6
        test esi, esi
        jne short .5
        call KbdIdleCall
        mov esi, eax
.5:
        call ServiceIdle
        jmp short .4
.6:
        push IntroPalette
        push dword 100h
        push byte 0
        mov ebx, 1
        call GetPaletteRange
        mov edx, IntroPalette
        add esp, byte 0Ch
        mov eax, ebx
        mov edi, dword [byte esp+050h]
        call FadePalette
        push edi
        call FreeMemBlock
        add esp, byte 4
        mov eax, dword [byte esp+05Ch]
        push eax
        call FreeMemBlock
        add esp, byte 4
        push ebp
        call FreeMemBlock
        add esp, byte 4
        mov edx, dword [byte esp+054h]
        push edx
        call FreeMemBlock
        add esp, byte 4
.7:
        call MusicPlaying
        test eax, eax
        je short .9
        test esi, esi
        jne short .8
        call KbdIdleCall
        mov esi, eax
.8:
        call ServiceIdle
        jmp short .7
.9:
        call WaitMusicEnd
        call SetScreenTarget
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        call ClearScreen
        add esp, byte 4
        call PresentScreen
        call FreeVideoBuffer
        push byte 10h
        push dword 1E0h
        push dword 280h
        call SetGraphicsMode
        add esp, byte 0Ch
        call AllocGfxFixBuffer
        call SetScreenTarget
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        call ClearScreen
        add esp, byte 4
        call PresentScreen
        test esi, esi
        jne short .10
        call RunIntroMovie
.10:
        call SetScreenTarget
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        call ClearScreen
        add esp, byte 4
        call PresentScreen
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
        mov dword [eax], edx
        mov word [byte eax+04h], bx
        mov word [byte eax+06h], cx
        mov word [byte eax+0Ah], cx
        mov edx, dword [byte esp+04h]
        mov word [byte eax+08h], dx
        ret 4
        db 08Dh,040h,00h
        push ebx
        push edx
        mov bx, word [byte eax+06h]
        mov dx, word [byte eax+08h]
        add ebx, edx
        mov word [byte eax+06h], bx
        pop edx
        pop ebx
        ret
