; Front end start-up: logo names, front end init and the title screen.
bits 32
%include "hockey.inc"
section s_7CADA progbits alloc exec nowrite align=1
extern AllocMemBlock, ArenaFileName, BlitShape, ChkMenuMusic, CloseGameDatabase, CreateBitmap, CreateMenuBitmap, CreditsScreen
extern FindShape, FreeBitmap, FreeLangText, FreeMemBlock, FreeMenuBitmap, FrontEndExit, FrontFonts, FrontFontsLoaded
extern FrontShapeFile, FrontTextFile, GameSettings, GoalieMaskScreen, InitVideoModeList, LoadDataFile, LoadDataFileLib, LoadLangText
extern LoadNameFile, LogoNames, LogoNamesLoaded, MainMenuScreen, MakeDataPath, OpenGameDatabase, OpenResourceArchive, PaEvent
extern PauseMusic, rand_, ReplayFileOpen, RequestMusicStop, RunGameScreens, RunModemConnect, RunNetworkConnect, RunOptionsScreens
extern RunStatsMenu, ScreenBackgrounds, ScreenTitleArt, SecondsToSamples, ServiceIdle, SetDrawTarget, SetMenuSelection, SetNormalText
extern sprintf_, str_BACK2, str_CB00, str_CB01, str_CHK1, str_Logo02dQfs, str_LOGO2, str_LogoNames
extern str_Mous2, str_Remo2, str_X1, tickcount, WaitMusicEnd, WaitSoundTime, WipeScreen, WriteGlobalSet
global LoadLogoNames, FreeTempArt, FreeTempArt_45, InitFrontEnd, FreeFrontEnd, RunFrontEnd, TitleScreen
;-----------------------------------------------------------------------------
; LoadLogoNames                                   7CADA  97 PC, low confidence
; Loads the "logo names" block from the logo%02d.qfs files
;-----------------------------------------------------------------------------
LoadLogoNames:
        push ebx
        push ecx
        push edx
        enter 0C8h, 0
        cmp dword [LogoNamesLoaded], byte 0
        jne near .2
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push byte 0
        push dword 230h
        push str_LogoNames
        call AllocMemBlock
        add esp, byte 0Ch
        mov ebx, eax
        xor edx, edx
.1:
        mov eax, edx
        push edx
        shl eax, 4
        push str_Logo02dQfs
        lea ecx, [ebx+eax]
        inc edx
        push ecx
        mov dword [dword ebp+edx*4-0CCh], ecx
        call sprintf_
        add esp, byte 0Ch
        cmp edx, byte 23h
        jl short .1
        mov edx, 32h
        lea eax, [byte ebp-03Ch]
        call MakeDataPath
        lea eax, [byte ebp-03Ch]
        push eax
        call OpenResourceArchive
        add esp, byte 4
        push byte 20h
        push LogoNames
        lea eax, [dword ebp-0C8h]
        push eax
        push byte 23h
        call LoadNameFile
        add esp, byte 10h
        push byte 0
        call OpenResourceArchive
        add esp, byte 4
        push ebx
        call FreeMemBlock
        mov dword [LogoNamesLoaded], 1
        add esp, byte 4
.2:
        leave
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FreeTempArt                                     7CB8C  97 PC, low confidence
; Frees the temporary art
;-----------------------------------------------------------------------------
FreeTempArt:
        push ebx
        push ecx
        push edx
        push esi
        cmp dword [LogoNamesLoaded], byte 0
        je short FreeTempArt_45
        xor esi, esi
.1:
        mov ebx, esi
        shl ebx, 2
        cmp dword [dword ebx+LogoNames], byte 0
        je short .2
        push dword [dword ebx+LogoNames]
        call FreeMemBlock
        add esp, byte 4
        mov dword [dword ebx+LogoNames], 0
.2:
        inc esi
        cmp esi, byte 23h
        jl short .1
        mov dword [LogoNamesLoaded], 0
FreeTempArt_45:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; InitFrontEnd                                    7CBD6  97 PC, low confidence
; Front-end start-up (also after a game): input devices (mous / remo), the
; front-end art and the team logo names
;-----------------------------------------------------------------------------
InitFrontEnd:
        push ebx
        push ecx
        push edx
        call InitVideoModeList
        call OpenGameDatabase
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        cmp dword [FrontShapeFile], byte 0
        jne short .1
        mov eax, 2Eh
        xor edx, edx
        call LoadDataFile
        mov dword [FrontShapeFile], eax
.1:
        cmp dword [FrontTextFile], byte 0
        jne short .2
        mov eax, 2Fh
        xor edx, edx
        call LoadDataFileLib
        mov dword [FrontTextFile], eax
.2:
        cmp dword [FrontFonts], byte 0
        jne short .3
        mov eax, 0F6h
        xor edx, edx
        call LoadDataFileLib
        mov dword [FrontFonts], eax
.3:
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        call SetNormalText
        push str_Remo2
        push dword [FrontShapeFile]
        call FindShape
        add esp, byte 8
        push str_Mous2
        push dword [FrontShapeFile]
        mov ebx, eax
        call FindShape
        add esp, byte 8
        mov edx, ebx
        call CreateMenuBitmap
        mov eax, 100h
        call SetMenuSelection
        mov eax, dword [GameSettings]
        shl eax, 1Ch
        shr eax, 1Eh
        call LoadLangText
        mov eax, 3
        xor ebx, ebx
        call SecondsToSamples
        call WaitSoundTime
.4:
        push byte 0
        push str_CHK1
        push dword [FrontShapeFile]
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+06h]
        push eax
        push str_CHK1
        push dword [FrontShapeFile]
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+04h]
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        push str_X1
        push dword [FrontShapeFile]
        mov dword [nosplit ebx*4+ScreenTitleArt], eax
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+06h]
        push eax
        push str_X1
        push dword [FrontShapeFile]
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+04h]
        push eax
        inc ebx
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [nosplit ebx*4+FrontFonts], eax
        cmp ebx, byte 9
        jl near .4
        xor ebx, ebx
.5:
        push byte 0
        push str_CB00
        push dword [FrontShapeFile]
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+06h]
        push eax
        push str_CB00
        push dword [FrontShapeFile]
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+04h]
        push eax
        inc ebx
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [nosplit ebx*4+ReplayFileOpen], eax
        cmp ebx, byte 2
        jl short .5
        mov ebx, 2
.6:
        push byte 0
        push str_CB01
        push dword [FrontShapeFile]
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+06h]
        push eax
        push str_CB01
        push dword [FrontShapeFile]
        call FindShape
        add esp, byte 8
        movsx eax, word [byte eax+04h]
        push eax
        inc ebx
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [nosplit ebx*4+ReplayFileOpen], eax
        cmp ebx, byte 0Ch
        jl short .6
        call LoadLogoNames
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FreeFrontEnd                                    7CDD8  97 PC, low confidence
; Undoes InitFrontEnd and saves GLOBAL.SET (WriteGlobalSet)
;-----------------------------------------------------------------------------
FreeFrontEnd:
        push ecx
        push edx
        push esi
        push dword [FrontShapeFile]
        call FreeMemBlock
        add esp, byte 4
        push dword [FrontTextFile]
        mov dword [FrontShapeFile], 0
        call FreeMemBlock
        add esp, byte 4
        push dword [FrontFonts]
        mov dword [FrontTextFile], 0
        call FreeMemBlock
        add esp, byte 4
        xor esi, esi
        mov dword [FrontFonts], 0
        call FreeLangText
        call FreeMenuBitmap
.1:
        push dword [nosplit esi*4+ScreenTitleArt]
        inc esi
        call FreeBitmap
        add esp, byte 4
        push dword [nosplit esi*4+FrontFonts]
        mov dword [nosplit esi*4+FrontFontsLoaded], 0
        call FreeBitmap
        add esp, byte 4
        mov dword [nosplit esi*4+FrontFonts], 0
        cmp esi, byte 9
        jl short .1
        xor esi, esi
.2:
        push dword [nosplit esi*4+ScreenBackgrounds]
        inc esi
        call FreeBitmap
        add esp, byte 4
        mov dword [nosplit esi*4+ReplayFileOpen], 0
        cmp esi, byte 0Ch
        jl short .2
        call FreeTempArt
        call WriteGlobalSet
        call CloseGameDatabase
        pop esi
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; RunFrontEnd                                  7CE9E  96 PC, medium confidence
; The front end: runs the screen with the current number (each screen returns the next: main menu,
; exhibition, season, playoffs, options, modem, ...) until quit; main_ calls it
;-----------------------------------------------------------------------------
RunFrontEnd:
        push ebx
        push ecx
        push edx
        enter 50h, 0
        call InitFrontEnd
        call PauseMusic
        call rand_
        mov ecx, 2
        cdq
        idiv ecx
        mov ecx, edx
        lea edx, [byte ebp-050h]
        mov eax, ecx
        call ArenaFileName
        lea eax, [byte ebp-050h]
        mov ebx, 1
        call ChkMenuMusic
        lea eax, [ecx+ebx]
        mov ecx, 2
        cdq
        idiv ecx
        mov eax, edx
        lea edx, [byte ebp-050h]
        call ArenaFileName
        lea eax, [byte ebp-050h]
        call ChkMenuMusic
        call RequestMusicStop
        call TitleScreen
        jmp short .7
.1:
        cmp ebx, byte 0Ah
        je near .10
        jmp short .7
.2:
        cmp ebx, byte 2
        jb short .3
        jbe short .4
        jmp short .5
.3:
        cmp ebx, byte 1
        jne short .7
        call MainMenuScreen
        mov ebx, eax
        jmp short .7
.4:
        mov byte [FrontEndExit], 1
        mov ebx, 1
        call RunStatsMenu
        jmp short .7
.5:
        call RunModemConnect
.6:
        mov ebx, 1
.7:
        test ebx, ebx
        je short .13
        cmp ebx, byte 4
        jb short .2
        cmp ebx, byte 9
        jbe short .9
        cmp ebx, byte 18h
        jb short .1
        jbe short .8
        cmp ebx, byte 20h
        jb short .7
        jbe short .12
        cmp ebx, byte 21h
        je short .11
        jmp short .7
.8:
        call RunNetworkConnect
        jmp short .6
.9:
        mov eax, ebx
        call RunGameScreens
        jmp short .6
.10:
        call RunOptionsScreens
        jmp short .6
.11:
        call CreditsScreen
        jmp short .6
.12:
        call GoalieMaskScreen
        jmp short .6
.13:
        call WaitMusicEnd
        call FreeFrontEnd
        leave
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; TitleScreen                                     7CF94  97 PC, low confidence
; The title screen at front-end start (BACK, LOGO) with its PA announcement
;-----------------------------------------------------------------------------
TitleScreen:
        push ebx
        push ecx
        push edx
        push esi
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        xor edx, edx
        mov eax, 0E1h
        call LoadDataFile
        push byte 0
        push dword 1E0h
        push dword 280h
        mov esi, eax
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov ebx, eax
        call SetDrawTarget
        add esp, byte 4
        push str_BACK2
        push esi
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push str_LOGO2
        push esi
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape
        add esp, byte 4
        push esi
        call FreeMemBlock
        add esp, byte 4
        mov eax, dword [byte ebx+02Ch]
        xor edx, edx
        call WipeScreen
        push ebx
        call FreeBitmap
        add esp, byte 4
        mov eax, 3
        call SecondsToSamples
        call WaitSoundTime
        push dword 0B0000001h
        call PaEvent
        add esp, byte 4
        mov eax, dword [tickcount]
        lea ebx, [dword eax+01F4h]
.1:
        mov eax, dword [tickcount]
        cmp eax, ebx
        jge near FreeTempArt_45
        call ServiceIdle
        jmp short .1
