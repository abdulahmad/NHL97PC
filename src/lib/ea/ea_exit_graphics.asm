; EA library: ExitGraphics, FindDos4gw, InitPlatform, InstallErrorHandlers.
bits 32
%include "hockey.inc"
section s_119F1F progbits alloc exec nowrite align=1
extern _searchenv_, AddExitHandler, AskExitGame, ClearNumLock, ClearScreen, DebugTagStr, FileExistsPath, FreeRowTable
extern GraphicsModeSet, InitMemoryPoolDefault, InitTextOutput, InstallBreakHandler, InstallKeyboardHandler, InstallTimer, MakeColor, MemPoolBase
extern MenuScreenBitmap, MouseInit, MousePresent, NoOpPlatformHook, PlatformFirstInit, PlatformState, PollHotkeys, PresentScreen
extern RegisterHotkey, RestoreTextMode, RestoreTextScreen, SaveTextScreen, SelectFont, SetCameraAngles, SetGraphicsMode, SetKbdIdleHook
extern SetScreenTarget, SetTextColors, SetViewScreenOrigin, ShowPauseMessage, sprintf_, str_CS3, str_D_UpdateFrameRate, str_DOS4GWEXE
extern str_PATH, VideoOptionsText, ViewScreenHeight, ViewScreenWidth, WritePaletteRegs
global ExitGraphics, FindDos4gw, InitPlatform, InstallErrorHandlers
        db 00h
;-----------------------------------------------------------------------------
; ExitGraphics                                   119F20  97 PC, low confidence
; Restores text mode and frees the screen
;-----------------------------------------------------------------------------
ExitGraphics:
        push ebx
        push ecx
        push edx
        call RestoreTextMode
        mov edx, dword [PlatformState]
        test edx, edx
        je short .1
        mov eax, edx
        xor ebx, ebx
        call RestoreTextScreen
        mov dword [PlatformState], ebx
.1:
        xor ecx, ecx
        call FreeRowTable
        mov dword [GraphicsModeSet], ecx
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FindDos4gw                                     119F54  97 PC, low confidence
; Looks for DOS4GW.EXE on the PATH
;-----------------------------------------------------------------------------
FindDos4gw:
        push ebx
        push esi
        sub esp, 100h
        mov ebx, esp
        xor ah, ah
        mov edx, str_PATH
        mov byte [esp], ah
        mov eax, str_DOS4GWEXE
        call _searchenv_
        mov dl, byte [esp]
        xor esi, esi
        test dl, dl
        jne short .1
        push str_DOS4GWEXE
        push str_CS3
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
.1:
        mov eax, esp
        push eax
        call FileExistsPath
        add esp, byte 4
        cmp eax, 40CB4h
        je short .2
        cmp eax, 40CCCh
        je short .2
        cmp eax, 3E25Ch
        jne short .3
.2:
        mov esi, 1
.3:
        mov eax, esi
        add esp, 100h
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        push byte 0
        call FindDos4gw
        add esp, byte 4
        ret
        db 090h
        push byte 1
        call FindDos4gw
        add esp, byte 4
        ret
        db 090h
;-----------------------------------------------------------------------------
; InitPlatform                                   119FDC  97 PC, low confidence
; Start-up: DOS extender check, memory pool, timer, screen
;-----------------------------------------------------------------------------
InitPlatform:
        push ebx
        push esi
        push edi
        push ebp
        cmp dword [PlatformFirstInit], byte 0
        je short .1
        push byte 1
        call FindDos4gw
        add esp, byte 4
.1:
        cmp dword [MemPoolBase], byte 0
        jne short .2
        push dword 0C8h
        call InitMemoryPoolDefault
        add esp, byte 4
.2:
        mov ecx, dword [str_D_UpdateFrameRate]
        push ecx
        call InstallTimer
        mov esi, dword [GraphicsModeSet]
        add esp, byte 4
        test esi, esi
        jne short .3
        call SaveTextScreen
        db 068h                                 ; insn: push ExitGraphics
        dd ExitGraphics
        mov dword [PlatformState], eax
        call AddExitHandler
        add esp, byte 4
        mov edi, dword [MenuScreenBitmap]
        push edi
        mov ebp, dword [ViewScreenHeight]
        push ebp
        mov eax, dword [ViewScreenWidth]
        push eax
        call SetGraphicsMode
        add esp, byte 0Ch
.3:
        call InitTextOutput
        push VideoOptionsText
        push dword 100h
        push byte 0
        call WritePaletteRegs
        add esp, byte 0Ch
        push DebugTagStr
        call SelectFont
        add esp, byte 4
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push eax
        call SetTextColors
        add esp, byte 8
        call SetScreenTarget
        push byte 0
        call ClearScreen
        mov edx, dword [MousePresent]
        add esp, byte 4
        test edx, edx
        jne short .4
        call MouseInit
.4:
        call ClearNumLock
        call InstallKeyboardHandler
        push PresentScreen
        call InstallBreakHandler
        add esp, byte 4
        push PollHotkeys
        call SetKbdIdleHook
        add esp, byte 4
        call InstallErrorHandlers
        mov ebx, dword [ViewScreenHeight]
        push ebx
        mov ecx, dword [ViewScreenWidth]
        push ecx
        push byte 14h
        push byte 1Eh
        call SetCameraAngles
        add esp, byte 10h
        push byte 0
        push byte 0
        call SetViewScreenOrigin
        add esp, byte 8
        call NoOpPlatformHook
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; InstallErrorHandlers                           11A120  97 PC, low confidence
; Installs the handlers of the error interrupts
;-----------------------------------------------------------------------------
InstallErrorHandlers:
        push ShowPauseMessage
        push byte 10h
        call RegisterHotkey
        add esp, byte 8
        push AskExitGame
        push byte 18h
        call RegisterHotkey
        add esp, byte 8
        ret
