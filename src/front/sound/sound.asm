; Sound: sfx banks, game audio, music tracks, sfx and crowd noise.
bits 32
%include "hockey.inc"
section s_4095C progbits alloc exec nowrite align=1
extern __CHP, AddIdleHandler, AllocCdBuffer, AllocMemBlock, AmbientHandle, AmbientVolume, AudioDriverVersion, AudioInitDone
extern AudioOptions, AudioStreamChannel, AudioStreamFlags, AudioStreamPosition, CameraStateRecords, ChannelPlaying, CloseDigitalAudio, CloseSpeechChannels
extern CrowdBankHandle, CrowdNoiseLevel, CurrentArchiveName, DetectAudioDriver, DetectAudioHardware, DetectWindows, DirPathTable, DriveLetterIndex
extern F32_42, F32_768_PositionSfx, F32_9600, F32_98, F64_3p14159_PositionSfx, F64_6p28319_PositionSfx, F64_neg3p14159_PositionSfx, F64_neg6p28319_PositionSfx
extern FileClose, FileExists, FileSizePath, FreeMemBlock, FreeSpeechBuffers, GameAudioState, GameSettings, GameSoundsOn
extern hypot_, IF@ATAN2, InitSoundMixer, InitSpeechBanks, InitSpeechStream, IsCdDrive, LastSfxPlayed, LoadFileAllocQuiet
extern LoadFileToBlockPlain, MakeDataPath, MemFreeSize, MusicBlock, MusicFeedCount, MusicHandle, MusicLength, MusicOptions
extern MusicPaused, MusicReady, MusicRestart, MusicStartTime, MusicState, MusicStopRequest, MusicStreamPos, MusicTime
extern MusicTrack, MusicTrackTable, MusicVolumeLevel, MusicVolumeScale, MusicVolumeWord, OpenDigitalAudio, OpenResourceArchive, OpenSpeechFile
extern PlaySample, PlaySampleVolume, RegisterSoundBank, RemoveIdleHandler, ReplaySoundAllowed, ResetSoundChannels, ServiceBackgroundAudio, ServiceIdle
extern SetChannelVolume, SetMasterVolume, SetMixerVolumes, SetMusicStreamVolume, SetSpeechVolume, setstreamspeed, SfxBankData, SfxBankHandle
extern SfxBankLoaded, SfxBankNames, SfxBankNameTable, SfxBankPtrs, SfxBankRecords, SfxBankSizes, SfxBankSlots, SfxChannelIds
extern SfxChannelRecords, SfxChannelTimes, SfxGroupTable, SfxOptions, SfxReady, SfxVolumeLevel, SfxVolumeScale, SfxVolumeWord
extern ShowLoadingBar, ShutdownSound, SoundCardType, SoundDriverId, SpeechBankBuffer, SpeechPlaying, sprintf_, StartDigitalAudio
extern StopAllChannels, StopChannel, str_16, str_8, str_AUDSTREAM, str_BKD, str_BKH, str_CROWDCRD
extern str_GAMEDATAAUDPBP3TSF, str_MENU, str_S02dASF, str_SFX4S, strcat_, strcpy_, strncpy_, strstr_
extern UnpackedSize, UnpackPlain, UnregisterSoundBank, UpdateMusicStream, WaitTicks
global LoadMainSfxBank, LoadSfxBank, AdvanceStreamStateJumpTable, AdvanceStreamState, AdvanceStreamState_11, AdvanceStreamState_19, AdvanceStreamState_21, AdvanceStreamState_29
global AdvanceStreamState_31, AdvanceStreamState_39, RewindStreamStateJumpTable, DetectedAudioJumpTable, OpenAudioStreamJumpTable, OpenAudioStream, OpenAudioStream_97, OpenAudioStream_A4
global OpenAudioStream_B1, OpenAudioStream_BE, OpenAudioStream_CB, OpenAudioStream_D8, InitGameAudio, SetMusicVolume, SetSfxVolume, MusicEnabled
global FreeSfxBank, LoadFrontEndSfx, InitGameSounds, ShutdownGameAudio, SecondsToSamples, WaitSoundTime, ChkMenuMusic, StartMusicTrack
global QueueMusicRestart, PauseMusic, ResumeMusic, MusicPlaying, MusicStreamTick, RequestMusicStop, WaitMusicEnd, MusicFileName
global ArenaFileName, StopBankSounds, PlayMenuSfx, StopAllSfx, PlaySfx, PlaySfxOr, PositionSfx, PlaySfxVolume
global PlaySfxAt, SetAmbientVolume, SetCrowdNoise, SetCrowdMood
;-----------------------------------------------------------------------------
; LoadMainSfxBank                                 4095C  97 PC, low confidence
; At start-up: builds the path of the main sound effect bank and loads it
;-----------------------------------------------------------------------------
LoadMainSfxBank:
        push ecx
        push edx
        sub esp, 0A0h
        cmp word [SfxBankLoaded], byte 0
        je near .5
        call CurrentArchiveName
        test eax, eax
        je short .1
        call CurrentArchiveName
        cmp byte [eax], 0
        je short .1
        call CurrentArchiveName
        mov edx, eax
        lea eax, [byte esp+050h]
        call strcpy_
        jmp short .2
.1:
        xor dh, dh
        mov byte [byte esp+050h], dh
.2:
        mov edx, 55h
        mov eax, esp
        call MakeDataPath
        mov eax, esp
        push eax
        call OpenResourceArchive
        add esp, byte 4
        mov eax, 1
        call LoadSfxBank
        mov eax, 2
        call LoadSfxBank
        cmp byte [byte esp+050h], 0
        je short .3
        lea eax, [byte esp+050h]
        push eax
        jmp short .4
.3:
        push byte 0
.4:
        call OpenResourceArchive
        add esp, byte 4
.5:
        add esp, 0A0h
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LoadSfxBank                                     409EC  97 PC, low confidence
; (bank): with sound on, loads a sound effect bank (SFX4%s .BKH / .BKD)
;-----------------------------------------------------------------------------
LoadSfxBank:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 3Ch
        mov edi, eax
        mov dx, word [SfxBankLoaded]
        xor ebp, ebp
        xor esi, esi
        mov dword [byte esp+038h], ebp
        test dx, dx
        jne short .1
        xor eax, eax
        jmp near .29
.1:
        lea edx, [nosplit eax*4+00h]
        cmp dword [dword edx+SfxBankRecords], byte 0
        je short .2
        xor eax, eax
        add esp, byte 3Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        lea eax, [byte esp+024h]
        mov edx, dword [dword edx+SfxBankNameTable]
        call strcpy_
        cmp edi, byte 3
        jne short .5
        cmp dword [SfxReady], byte 0
        je short .3
        cmp dword [SfxBankHandle], byte 0
        jne short .4
.3:
        push byte 0
        call MemFreeSize
        add esp, byte 4
        cmp eax, 800000h
        jle short .8
.4:
        mov eax, 1
        mov edx, str_16
        mov dword [byte esp+038h], eax
        jmp short .9
.5:
        cmp edi, byte 5
        jne short .11
        cmp dword [SfxReady], byte 0
        je short .6
        cmp dword [CrowdBankHandle], byte 0
        jne short .7
.6:
        push byte 0
        call MemFreeSize
        add esp, byte 4
        cmp eax, 800000h
        jle short .8
.7:
        mov edx, 1
        lea eax, [byte esp+024h]
        mov dword [byte esp+038h], edx
        mov edx, str_16
        jmp short .10
.8:
        mov edx, str_8
.9:
        lea eax, [byte esp+024h]
.10:
        call strcat_
.11:
        mov edx, str_BKH
        lea eax, [byte esp+024h]
        call strcat_
        lea eax, [byte esp+024h]
        push eax
        call FileSizePath
        add esp, byte 4
        mov dword [byte esp+034h], eax
        test eax, eax
        je near .28
        lea eax, [byte esp+014h]
        mov edx, dword [nosplit edi*4+SfxBankNameTable]
        call strcpy_
        cmp edi, byte 3
        jne short .14
        cmp dword [SfxReady], byte 0
        je short .12
        cmp dword [SfxBankHandle], byte 0
        jne short .13
.12:
        push byte 0
        call MemFreeSize
        add esp, byte 4
        cmp eax, 800000h
        jle short .17
.13:
        mov edx, str_16
        jmp short .18
.14:
        cmp edi, byte 5
        jne short .19
        cmp dword [SfxReady], byte 0
        je short .15
        cmp dword [CrowdBankHandle], byte 0
        jne short .16
.15:
        push byte 0
        call MemFreeSize
        add esp, byte 4
        cmp eax, 800000h
        jle short .17
.16:
        mov edx, str_16
        jmp short .18
.17:
        mov edx, str_8
.18:
        lea eax, [byte esp+014h]
        call strcat_
.19:
        mov edx, str_BKD
        lea eax, [byte esp+014h]
        call strcat_
        cmp dword [byte esp+038h], byte 0
        je short .20
        push byte 20h
        lea eax, [byte esp+018h]
        push eax
        call LoadFileAllocQuiet
        add esp, byte 8
        mov ebp, eax
        test eax, eax
        je near .28
        push eax
        call UnpackedSize
        jmp short .21
.20:
        lea eax, [byte esp+014h]
        push eax
        call FileSizePath
.21:
        add esp, byte 4
        mov edx, eax
        test edx, edx
        jne short .22
        test ebp, ebp
        je near .28
        push ebp
        call FreeMemBlock
        add esp, byte 4
        jmp near .28
.22:
        lea ebx, [nosplit edi*4+00h]
        mov ecx, dword [dword ebx+SfxBankNameTable]
        push ecx
        push str_SFX4S
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, dword [byte esp+034h]
        push byte 0
        add edx, eax
        push edx
        lea eax, [byte esp+08h]
        push eax
        mov dword [dword ebx+SfxBankData], edx
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [dword ebx+SfxBankRecords], eax
        mov edx, dword [byte esp+034h]
        mov dword [dword ebx+SfxBankSizes], eax
        add eax, edx
        mov dword [dword ebx+SfxBankSlots], eax
        mov eax, 10266h
        call WaitSoundTime
        mov ecx, dword [dword ebx+SfxBankSizes]
        push ecx
        lea eax, [byte esp+028h]
        push eax
        call LoadFileToBlockPlain
        add esp, byte 8
        test eax, eax
        jne short .23
        mov edi, dword [dword ebx+SfxBankRecords]
        push edi
        xor ebp, ebp
        call FreeMemBlock
        add esp, byte 4
        mov eax, esi
        mov dword [dword ebx+SfxBankRecords], ebp
        mov dword [dword ebx+SfxBankData], ebp
        add esp, byte 3Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.23:
        mov eax, 10266h
        call WaitSoundTime
        cmp dword [byte esp+038h], byte 0
        je short .24
        mov eax, dword [dword ebx+SfxBankSlots]
        push eax
        push ebp
        call UnpackPlain
        add esp, byte 8
        test eax, eax
        jne short .25
        push ebp
        call FreeMemBlock
        add esp, byte 4
        mov eax, dword [dword ebx+SfxBankRecords]
        push eax
        call FreeMemBlock
        add esp, byte 4
        xor edx, edx
        mov eax, esi
        mov dword [dword ebx+SfxBankRecords], edx
        mov dword [dword ebx+SfxBankData], edx
        add esp, byte 3Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.24:
        mov edx, dword [dword ebx+SfxBankSlots]
        push edx
        lea eax, [byte esp+018h]
        push eax
        call LoadFileToBlockPlain
        add esp, byte 8
        test eax, eax
        jne short .25
        mov ecx, dword [dword ebx+SfxBankRecords]
        push ecx
        xor edi, edi
        call FreeMemBlock
        add esp, byte 4
        mov eax, esi
        mov dword [dword ebx+SfxBankRecords], edi
        mov dword [dword ebx+SfxBankData], edi
        add esp, byte 3Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.25:
        test ebp, ebp
        je short .26
        push ebp
        call FreeMemBlock
        add esp, byte 4
.26:
        shl edi, 2
        mov eax, SfxBankNames
        mov ebx, dword [dword edi+SfxBankSlots]
        mov edx, dword [dword edi+SfxBankSizes]
        add eax, edi
        call RegisterSoundBank
        test eax, eax
        jge short .27
        mov ebx, dword [dword edi+SfxBankRecords]
        push ebx
        call FreeMemBlock
        add esp, byte 4
        xor ecx, ecx
        mov eax, esi
        mov dword [dword edi+SfxBankRecords], ecx
        mov dword [dword edi+SfxBankData], ecx
        add esp, byte 3Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.27:
        cmp dword [byte esp+038h], byte 0
        je short .28
        mov esi, 1
.28:
        mov eax, esi
.29:
        add esp, byte 3Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
AdvanceStreamStateJumpTable:                    ; jump table for the switch cases of AdvanceStreamState
        dd AdvanceStreamState_11
        dd AdvanceStreamState_19
        dd AdvanceStreamState_21
        dd AdvanceStreamState_29
        dd AdvanceStreamState_31
        dd AdvanceStreamState_39
;-----------------------------------------------------------------------------
; AdvanceStreamState                              40D80  97 PC, low confidence
; Moves an audio stream to its next state
;-----------------------------------------------------------------------------
AdvanceStreamState:
        push edx
        mov edx, dword [eax]
        dec edx
        cmp edx, byte 5
        ja short AdvanceStreamState_39.1
        jmp dword [nosplit cs:edx*4+AdvanceStreamStateJumpTable]
AdvanceStreamState_11:
        mov dword [eax], 4
        pop edx
        ret
AdvanceStreamState_19:
        mov dword [eax], 5
        pop edx
        ret
AdvanceStreamState_21:
        mov dword [eax], 1
        pop edx
        ret
AdvanceStreamState_29:
        mov dword [eax], 2
        pop edx
        ret
AdvanceStreamState_31:
        mov dword [eax], 3
        pop edx
        ret
AdvanceStreamState_39:
        mov dword [eax], 6
        pop edx
        ret
.1:
        mov dword [eax], 0
        pop edx
        ret
        db 08Dh,040h,00h
RewindStreamStateJumpTable:                     ; jump table for the switch cases
        dd .3
        dd .4
        dd .5
        dd .1
        dd .2
        dd .6
        push edx
        mov edx, dword [eax]
        dec edx
        cmp edx, byte 5
        ja short .7
        jmp dword [nosplit cs:edx*4+RewindStreamStateJumpTable]
.1:
        mov dword [eax], 1
        pop edx
        ret
.2:
        mov dword [eax], 2
        pop edx
        ret
.3:
        mov dword [eax], 3
        pop edx
        ret
.4:
        mov dword [eax], 4
        pop edx
        ret
.5:
        mov dword [eax], 5
        pop edx
        ret
.6:
        mov dword [eax], 6
        pop edx
        ret
.7:
        mov dword [eax], 0
        pop edx
        ret
        db 08Dh,040h,00h
DetectedAudioJumpTable:                         ; jump table for the switch cases
        dd .1
        dd .2
        dd .3
        dd .4
        dd .5
        dd .6
        push ebx
        push edx
        mov edx, eax
        call DetectAudioHardware
        mov dword [edx], eax
        dec eax
        mov ebx, edx
        cmp eax, byte 5
        ja short .7
        jmp dword [nosplit cs:eax*4+DetectedAudioJumpTable]
.1:
        mov dword [edx], 4
        pop edx
        pop ebx
        ret
.2:
        mov dword [edx], 5
        pop edx
        pop ebx
        ret
.3:
        mov dword [edx], 1
        pop edx
        pop ebx
        ret
.4:
        mov dword [edx], 2
        pop edx
        pop ebx
        ret
.5:
        mov dword [edx], 3
        pop edx
        pop ebx
        ret
.6:
        mov dword [edx], 6
        pop edx
        pop ebx
        ret
.7:
        mov dword [ebx], 0
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
OpenAudioStreamJumpTable:                       ; jump table for the switch cases of OpenAudioStream
        dd OpenAudioStream_B1
        dd OpenAudioStream_BE
        dd OpenAudioStream_CB
        dd OpenAudioStream_97
        dd OpenAudioStream_A4
        dd OpenAudioStream_D8
;-----------------------------------------------------------------------------
; OpenAudioStream                                 40EBC  97 PC, low confidence
; Opens the audio stream ("AUDSTREAM" block)
;-----------------------------------------------------------------------------
OpenAudioStream:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 0F4h
        mov dword [dword esp+0F0h], eax
        cmp word [SfxBankLoaded], byte 0
        je short .1
        xor eax, eax
        jmp near OpenAudioStream_D8.22
.1:
        mov edx, dword [DirPathTable]
        push edx
        call DriveLetterIndex
        add esp, byte 4
        push eax
        call IsCdDrive
        add esp, byte 4
        test eax, eax
        je short .2
        push byte 0
        mov ebx, dword [DirPathTable]
        push ebx
        call DriveLetterIndex
        add esp, byte 4
        push eax
        call AllocCdBuffer
        add esp, byte 8
.2:
        cmp dword [dword esp+0F0h], byte 0FFFFFFFFh
        jne short .3
        call DetectAudioHardware
        mov dword [dword esp+0F0h], eax
        lea eax, [dword esp+0F0h]
        call AdvanceStreamState
.3:
        mov eax, dword [dword esp+0F0h]
        dec eax
        lea edx, [dword esp+0F0h]
        cmp eax, byte 5
        ja short OpenAudioStream_D8.4
        jmp dword [nosplit cs:eax*4+OpenAudioStreamJumpTable]
OpenAudioStream_97:
        mov dword [dword esp+0F0h], 1
        jmp short OpenAudioStream_D8.5
OpenAudioStream_A4:
        mov dword [dword esp+0F0h], 2
        jmp short OpenAudioStream_D8.5
OpenAudioStream_B1:
        mov dword [dword esp+0F0h], 3
        jmp short OpenAudioStream_D8.5
OpenAudioStream_BE:
        mov dword [dword esp+0F0h], 4
        jmp short OpenAudioStream_D8.5
OpenAudioStream_CB:
        mov dword [dword esp+0F0h], 5
        jmp short OpenAudioStream_D8.5
OpenAudioStream_D8:
        mov dword [dword esp+0F0h], 6
        jmp short .5
.4:
        mov dword [edx], 0
.5:
        mov ecx, dword [dword esp+0F0h]
        test ecx, ecx
        jne short .6
        mov eax, 1
        add esp, 0F4h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.6:
        mov eax, ecx
        call DetectAudioDriver
        mov esi, dword [AudioDriverVersion]
        cmp esi, 510FF40h
        jae short .7
        test al, 8
        je short .8
        test ah, 2
        je short .8
        mov eax, 208h
        jmp short .9
.7:
        cmp esi, 6DAC2C0h
        jbe short .8
        test al, 8
        je short .8
        test ah, 20h
        je short .8
        mov eax, 2008h
        jmp short .9
.8:
        mov eax, 0FFFFFFFFh
.9:
        mov edx, dword [dword esp+0F0h]
        call OpenDigitalAudio
        test eax, eax
        setge al
        and eax, 0FFh
        je near .20
        mov eax, 7Fh
        call StartDigitalAudio
        push byte 0
        push dword 25B7Eh
        mov ecx, 1
        mov edi, 1
        push str_AUDSTREAM
        xor ebp, ebp
        mov word [SfxBankLoaded], cx
        call AllocMemBlock
        mov si, word [SfxBankLoaded]
        add esp, byte 0Ch
        mov dword [MusicTime], eax
        mov dword [MusicStreamPos], ebp
        mov eax, 0FFFFFFFFh
        mov dword [MusicStartTime], ebp
        mov dword [MusicVolumeLevel], eax
        mov dword [MusicHandle], eax
        mov eax, dword [AudioOptions]
        mov dword [MusicLength], ebp
        shl eax, 0Fh
        mov dword [MusicTrack], ebp
        shr eax, 19h
        mov dword [MusicState], edi
        mov edx, eax
        test si, si
        je short .12
        cmp ax, 64h
        jle short .10
        mov eax, 64h
.10:
        test ax, ax
        jge short .11
        xor eax, eax
.11:
        movsx edx, ax
        mov word [SfxVolumeWord], ax
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        mov edx, eax
        shl eax, 4
        sub eax, edx
        mov edx, eax
        mov ebx, 64h
        sar edx, 1Fh
        idiv ebx
        add eax, byte 16h
        mov word [MusicVolumeWord], ax
.12:
        mov eax, dword [AudioOptions]
        shl eax, 17h
        shr eax, 19h
        cwde
        call SetMusicVolume
        call InitSpeechStream
        cmp dword [SoundDriverId], byte 0FFFFFFFFh
        jne short .13
        call InitSpeechStream
.13:
        mov eax, 2
        call FreeSpeechBuffers
        mov eax, 1
        call FreeSpeechBuffers
        call ServiceIdle
        xor eax, eax
        xor edx, edx
        call OpenSpeechFile
        call ServiceIdle
        mov eax, 1
        mov dword [SoundCardType], edx
        mov dword [SoundDriverId], eax
        call CurrentArchiveName
        test eax, eax
        je short .14
        call CurrentArchiveName
        cmp byte [eax], 0
        je short .14
        call CurrentArchiveName
        mov edx, eax
        lea eax, [byte esp+050h]
        call strcpy_
        jmp short .15
.14:
        xor dh, dh
        mov byte [byte esp+050h], dh
.15:
        mov edx, 55h
        mov eax, esp
        call MakeDataPath
        mov eax, esp
        push eax
        call OpenResourceArchive
        add esp, byte 4
        xor eax, eax
        call LoadSfxBank
        cmp byte [byte esp+050h], 0
        je short .16
        lea eax, [byte esp+050h]
        push eax
        jmp short .17
.16:
        push byte 0
.17:
        call OpenResourceArchive
        add esp, byte 4
        mov ebx, 0FFFFFFFFh
        xor eax, eax
.18:
        add eax, byte 0Ch
        mov dword [dword eax+SpeechPlaying], ebx
        cmp eax, 0C0h
        jne short .18
        xor ecx, ecx
        mov bh, byte [AudioStreamChannel]
        mov dword [LastSfxPlayed], ecx
        test bh, bh
        jne short .19
        mov edx, 0E7h
        mov eax, esp
        call MakeDataPath
        mov edx, 0E5h
        lea eax, [dword esp+0A0h]
        call MakeDataPath
        lea eax, [dword esp+0A0h]
        push eax
        lea eax, [byte esp+04h]
        push eax
        call setstreamspeed
        mov cl, 1
        add esp, byte 8
        mov byte [AudioStreamChannel], cl
.19:
        xor esi, esi
        mov dword [MusicReady], esi
        call DetectWindows
        test eax, eax
        jne short .21
        push esi
        push byte 2
        push ServiceBackgroundAudio
        call AddIdleHandler
        add esp, byte 0Ch
        jmp short .21
.20:
        xor ebx, ebx
        mov word [SfxBankLoaded], bx
.21:
        mov eax, dword [AudioStreamFlags]
        sar eax, 10h
.22:
        add esp, 0F4h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; InitGameAudio                                   4123C  97 PC, low confidence
; With sound on: the crowd (CROWD.CRD) and the play-by-play table
; (GAMEDATA\AUDPBP3.TSF)
;-----------------------------------------------------------------------------
InitGameAudio:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 0A0h
        cmp word [SfxBankLoaded], byte 0
        je near .16
        call WaitMusicEnd
        call CurrentArchiveName
        test eax, eax
        je short .1
        call CurrentArchiveName
        cmp byte [eax], 0
        je short .1
        call CurrentArchiveName
        mov edx, eax
        lea eax, [byte esp+050h]
        call strcpy_
        jmp short .2
.1:
        xor dh, dh
        mov byte [byte esp+050h], dh
.2:
        mov edx, 55h
        mov eax, esp
        call MakeDataPath
        mov eax, esp
        push eax
        call OpenResourceArchive
        add esp, byte 4
        mov eax, 2
        call FreeSfxBank
        mov eax, 1
        call FreeSfxBank
        mov eax, 2
        call ShowLoadingBar
        cmp dword [SoundDriverId], byte 0FFFFFFFFh
        jne short .3
        call InitSpeechStream
.3:
        xor eax, eax
        call FreeSpeechBuffers
        call ServiceIdle
        mov eax, 1
        call OpenSpeechFile
        call ServiceIdle
        mov eax, 2
        mov ebx, 2
        call OpenSpeechFile
        call ServiceIdle
        mov eax, 5
        mov dword [SoundDriverId], ebx
        call ShowLoadingBar
        call ServiceIdle
        mov eax, 3
        call LoadSfxBank
        test eax, eax
        setne al
        and eax, 0FFh
        mov dword [SfxBankHandle], eax
        call ServiceIdle
        mov eax, 0Ch
        call ShowLoadingBar
        cmp dword [SfxReady], byte 0
        je short .4
        cmp dword [AmbientHandle], byte 0
        jne short .5
.4:
        push byte 0
        call MemFreeSize
        add esp, byte 4
        cmp eax, 800000h
        jle short .6
.5:
        mov eax, 4
        mov ebp, 1
        call LoadSfxBank
        mov dword [AmbientHandle], ebp
        jmp short .7
.6:
        xor edi, edi
        mov dword [AmbientHandle], edi
.7:
        call ServiceIdle
        mov eax, 0Fh
        call ShowLoadingBar
        mov eax, 5
        call LoadSfxBank
        test eax, eax
        setne al
        and eax, 0FFh
        mov dword [CrowdBankHandle], eax
        call ServiceIdle
        cmp dword [AudioInitDone], byte 0
        je near .11
        mov eax, 10266h
        call WaitSoundTime
        push byte 0
        push str_CROWDCRD
        call LoadFileAllocQuiet
        add esp, byte 8
        mov dword [MusicReady], eax
        test eax, eax
        je short .9
        mov ebx, dword [GameAudioState]
        mov edx, eax
        mov eax, ebx
        call InitSoundMixer
        test eax, eax
        jge short .8
        mov ecx, dword [MusicReady]
        push ecx
        xor esi, esi
        call FreeMemBlock
        add esp, byte 4
        mov eax, 5
        mov dword [MusicReady], esi
        jmp short .10
.8:
        test byte [MusicOptions], 4
        je short .11
        xor edx, edx
        xor eax, eax
        mov dword [AmbientVolume], edx
        mov dword [CrowdNoiseLevel], edx
        call SetMixerVolumes
        mov eax, 3Ch
        call SetChannelVolume
        jmp short .11
.9:
        mov eax, 5
.10:
        call FreeSfxBank
.11:
        call ServiceIdle
        mov eax, 12h
        call ShowLoadingBar
        cmp byte [byte esp+050h], 0
        je short .12
        lea eax, [byte esp+050h]
        push eax
        jmp short .13
.12:
        push byte 0
.13:
        call OpenResourceArchive
        add esp, byte 4
        test byte [MusicOptions], 8
        je short .15
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 40h
        jne short .14
        mov eax, str_GAMEDATAAUDPBP3TSF
        call FileExists
        test eax, eax
        je short .15
.14:
        call InitSpeechBanks
.15:
        mov eax, dword [AudioOptions]
        shl eax, 17h
        shr eax, 19h
        cwde
        call SetMusicVolume
        call ServiceIdle
        mov eax, 32h
        call ShowLoadingBar
.16:
        add esp, 0A0h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetMusicVolume                                  414B8  97 PC, low confidence
; Sets the music volume (0 to 100) and passes it to the driver
;-----------------------------------------------------------------------------
SetMusicVolume:
        push ebx
        push edx
        cmp word [SfxBankLoaded], byte 0
        je near .4
        cmp ax, 64h
        jle short .1
        mov eax, 64h
.1:
        test ax, ax
        jge short .2
        xor eax, eax
.2:
        movsx edx, ax
        mov word [MusicVolumeScale], ax
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        mov edx, eax
        shl eax, 4
        sub eax, edx
        mov edx, eax
        mov ebx, 64h
        sar edx, 1Fh
        idiv ebx
        add eax, byte 16h
        mov edx, dword [SoundCardType]
        mov word [SfxVolumeScale], ax
        test edx, edx
        je short .3
        mov edx, dword [MusicVolumeWord]
        sar edx, 10h
        mov eax, edx
        shl eax, 6
        add edx, eax
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov word [SfxVolumeScale], ax
.3:
        call MusicPlaying
        test eax, eax
        je short .4
        mov edx, dword [MusicVolumeWord]
        mov eax, dword [MusicVolumeLevel]
        sar edx, 10h
        call SetMusicStreamVolume
.4:
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetSfxVolume                                    41550  97 PC, low confidence
; Sets the sound effect volume (0 to 100)
;-----------------------------------------------------------------------------
SetSfxVolume:
        push ebx
        push edx
        cmp word [SfxBankLoaded], byte 0
        je short .3
        cmp ax, 64h
        jle short .1
        mov eax, 64h
.1:
        test ax, ax
        jge short .2
        xor eax, eax
.2:
        movsx edx, ax
        mov word [SfxVolumeWord], ax
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        mov edx, eax
        shl eax, 4
        sub eax, edx
        mov edx, eax
        mov ebx, 64h
        sar edx, 1Fh
        idiv ebx
        add eax, byte 16h
        mov word [MusicVolumeWord], ax
.3:
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; MusicEnabled                                    415A0  97 PC, low confidence
; Returns 1: music may play on this screen
;-----------------------------------------------------------------------------
MusicEnabled:
        mov eax, 1
        lea eax, [byte eax+00h]
;-----------------------------------------------------------------------------
; FreeSfxBank                                     415A8  97 PC, low confidence
; Stops the sounds of a sound effect bank and frees it
;-----------------------------------------------------------------------------
FreeSfxBank:
        push ebx
        push ecx
        push edx
        push esi
        cmp word [SfxBankLoaded], byte 0
        je short .1
        lea ebx, [nosplit eax*4+00h]
        cmp dword [dword ebx+SfxBankRecords], byte 0
        je short .1
        call StopBankSounds
        mov eax, dword [dword ebx+SfxBankNames]
        call UnregisterSoundBank
        mov ecx, dword [dword ebx+SfxBankRecords]
        push ecx
        xor esi, esi
        call FreeMemBlock
        add esp, byte 4
        mov dword [dword ebx+SfxBankRecords], esi
        mov dword [dword ebx+SfxBankData], esi
.1:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadFrontEndSfx                                 415F8  97 PC, low confidence
; Loads the sound effect bank of the front-end screens
;-----------------------------------------------------------------------------
LoadFrontEndSfx:
        push ecx
        push edx
        sub esp, 0A0h
        call CurrentArchiveName
        test eax, eax
        je short .1
        call CurrentArchiveName
        cmp byte [eax], 0
        je short .1
        call CurrentArchiveName
        mov edx, eax
        lea eax, [byte esp+050h]
        call strcpy_
        jmp short .2
.1:
        xor dh, dh
        mov byte [byte esp+050h], dh
.2:
        mov edx, 55h
        mov eax, esp
        call MakeDataPath
        mov eax, esp
        push eax
        call OpenResourceArchive
        add esp, byte 4
        mov eax, 1
        call LoadSfxBank
        cmp byte [byte esp+050h], 0
        je short .3
        lea eax, [byte esp+050h]
        push eax
        jmp short .4
.3:
        push byte 0
.4:
        call OpenResourceArchive
        add esp, byte 4
        add esp, 0A0h
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; InitGameSounds                                  41670  97 PC, low confidence
; Before a game: loads the game sound banks and the speech, starts the crowd
;-----------------------------------------------------------------------------
InitGameSounds:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        sub esp, 0A0h
        mov ebx, eax
        mov dx, word [SfxBankLoaded]
        test dx, dx
        je near .15
        je short .1
        cmp dword [MusicReady], byte 0
        je short .1
        test byte [MusicOptions], 4
        je short .1
        mov edx, dword [SfxVolumeLevel]
        sar edx, 10h
        imul edx, byte 0
        mov ecx, 64h
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov ecx, dword [SoundCardType]
        mov dword [AmbientVolume], eax
        test ecx, ecx
        je short .1
        mov edx, eax
        shl eax, 2
        add eax, edx
        shl eax, 2
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        shl edx, 5
        LD sbb, eax, edx
        sar eax, 5
        mov dword [AmbientVolume], eax
.1:
        cmp dword [MusicReady], byte 0
        je short .4
.2:
        cmp dword [CrowdNoiseLevel], byte 0
        jle short .3
        call ServiceIdle
        jmp short .2
.3:
        call StopAllChannels
        call ResetSoundChannels
        mov ebp, dword [MusicReady]
        push ebp
        call FreeMemBlock
        xor eax, eax
        add esp, byte 4
        mov dword [MusicReady], eax
.4:
        mov eax, 4
        call FreeSfxBank
        mov eax, 5
        call FreeSfxBank
        mov eax, 3
        call FreeSfxBank
        call ServiceIdle
        mov edx, dword [SoundCardType]
        test edx, edx
        je short .7
        je short .6
        mov eax, GameSoundsOn
        call FileClose
        mov esi, dword [SpeechBankBuffer]
        test esi, esi
        je short .5
        push esi
        call FreeMemBlock
        xor ebp, ebp
        add esp, byte 4
        mov dword [SpeechBankBuffer], ebp
.5:
        call CloseSpeechChannels
.6:
        xor eax, eax
        mov dword [SoundCardType], eax
        call ServiceIdle
.7:
        mov eax, dword [AudioOptions]
        shl eax, 17h
        shr eax, 19h
        cwde
        call SetMusicVolume
        call ServiceIdle
        cmp dword [SoundDriverId], byte 0FFFFFFFFh
        jne short .8
        call InitSpeechStream
.8:
        mov eax, 2
        call FreeSpeechBuffers
        mov eax, 1
        call FreeSpeechBuffers
        call ServiceIdle
        xor eax, eax
        mov ecx, 1
        call OpenSpeechFile
        call ServiceIdle
        mov dword [SoundDriverId], ecx
        call ServiceIdle
        call CurrentArchiveName
        test eax, eax
        je short .9
        call CurrentArchiveName
        cmp byte [eax], 0
        je short .9
        call CurrentArchiveName
        mov edx, eax
        mov eax, esp
        call strcpy_
        jmp short .10
.9:
        xor dh, dh
        mov byte [esp], dh
.10:
        mov edx, 55h
        lea eax, [byte esp+050h]
        call MakeDataPath
        lea eax, [byte esp+050h]
        push eax
        call OpenResourceArchive
        add esp, byte 4
        mov eax, 1
        call LoadSfxBank
        test ebx, ebx
        jne short .11
        mov eax, 2
        call LoadSfxBank
        mov dword [SfxReady], ebx
        jmp short .12
.11:
        mov dword [SfxReady], 1
.12:
        cmp byte [esp], 0
        je short .13
        mov eax, esp
        push eax
        jmp short .14
.13:
        push byte 0
.14:
        call OpenResourceArchive
        add esp, byte 4
        call ServiceIdle
.15:
        add esp, 0A0h
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ShutdownGameAudio                               41870  97 PC, low confidence
; At exit: stops the music, frees the sound banks and shuts the sound driver
; down
;-----------------------------------------------------------------------------
ShutdownGameAudio:
        push ebx
        push ecx
        push edx
        push edi
        push ebp
        cmp word [SfxBankLoaded], byte 0
        je near .10
        call DetectWindows
        test eax, eax
        jne short .1
        push ServiceBackgroundAudio
        call RemoveIdleHandler
        add esp, byte 4
.1:
        cmp word [SfxBankLoaded], byte 0
        je short .2
        cmp dword [MusicReady], byte 0
        je short .2
        test byte [MusicOptions], 4
        je short .2
        mov edx, dword [SfxVolumeLevel]
        sar edx, 10h
        imul edx, byte 0
        mov ebx, 64h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov ebx, dword [SoundCardType]
        mov dword [AmbientVolume], eax
        test ebx, ebx
        je short .2
        lea edx, [nosplit eax*4+00h]
        add edx, eax
        shl edx, 2
        sub edx, eax
        mov eax, edx
        sar edx, 1Fh
        shl edx, 5
        LD sbb, eax, edx
        sar eax, 5
        mov dword [AmbientVolume], eax
.2:
        call WaitMusicEnd
        cmp dword [MusicReady], byte 0
        je short .5
.3:
        cmp dword [CrowdNoiseLevel], byte 0
        jle short .4
        call ServiceIdle
        jmp short .3
.4:
        call StopAllChannels
        call ResetSoundChannels
        mov edi, dword [MusicReady]
        push edi
        xor ebp, ebp
        call FreeMemBlock
        add esp, byte 4
        mov dword [MusicReady], ebp
.5:
        xor eax, eax
        mov dword [SfxReady], eax
        call ShutdownSound
        mov edx, dword [SoundCardType]
        test edx, edx
        je short .8
        je short .7
        mov eax, GameSoundsOn
        call FileClose
        mov ecx, dword [SpeechBankBuffer]
        test ecx, ecx
        je short .6
        push ecx
        call FreeMemBlock
        xor edi, edi
        add esp, byte 4
        mov dword [SpeechBankBuffer], edi
.6:
        call CloseSpeechChannels
.7:
        xor ebp, ebp
        mov dword [SoundCardType], ebp
        call ServiceIdle
.8:
        xor edx, edx
.9:
        mov eax, edx
        inc edx
        call FreeSfxBank
        cmp edx, byte 6
        jl short .9
        xor ecx, ecx
        call CloseDigitalAudio
        mov word [SfxBankLoaded], cx
.10:
        pop ebp
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SecondsToSamples                                419B0  97 PC, low confidence
; Converts seconds to samples at 22050 Hz
;-----------------------------------------------------------------------------
SecondsToSamples:
        imul eax, dword 5622h
        ret
        db 090h
;-----------------------------------------------------------------------------
; WaitSoundTime                                   419B8  97 PC, low confidence
; Waits while the given amount of sound plays, keeping the sound serviced
;-----------------------------------------------------------------------------
WaitSoundTime:
        push ebx
        push edx
        cmp word [SfxBankLoaded], byte 0
        je short .3
        cmp dword [MusicTime], byte 0
        je short .3
        cmp word [MusicStopRequest], byte 0
        jle short .3
        mov edx, eax
        shl eax, 2
        sub eax, edx
        shl eax, 3
        add edx, eax
        shl edx, 2
        mov ebx, 25AEEh
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov edx, eax
        test eax, eax
        jl short .3
        cmp eax, byte 55h
        jle short .1
        mov edx, 55h
.1:
        xor ebx, ebx
.2:
        call ServiceIdle
        cmp bx, word [MusicStopRequest]
        jge short .3
        call AudioStreamPosition
        test eax, eax
        jl short .3
        call AudioStreamPosition
        cmp eax, edx
        jl short .2
.3:
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ChkMenuMusic                                    41A28  97 PC, low confidence
; Starts the menu music when the screen asks for it and music is on
;-----------------------------------------------------------------------------
ChkMenuMusic:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        cmp word [SfxBankLoaded], byte 0
        je near .3
        test byte [AudioOptions], 2
        je near .3
        mov edx, str_MENU
        mov eax, ecx
        call strstr_
        test eax, eax
        je short .1
        test byte [AudioOptions], 2
        jmp short .2
.1:
        test byte [MusicOptions], 10h
.2:
        je short .3
        cmp word [MusicStopRequest], byte 4
        jge short .3
        mov edx, dword [MusicRestart]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        mov ebx, 50h
        shl eax, 4
        mov edx, ecx
        add eax, MusicTrackTable
        call strncpy_
        mov edx, dword [MusicRestart]
        sar edx, 10h
        inc edx
        mov ecx, 4
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov cx, word [MusicStopRequest]
        inc ecx
        mov word [MusicBlock], dx
        mov word [MusicStopRequest], cx
.3:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; StartMusicTrack                                 41ACC  97 PC, low confidence
; Builds the path of a music track and starts it
;-----------------------------------------------------------------------------
StartMusicTrack:
        push ebx
        push edx
        mov edx, eax
        cmp word [SfxBankLoaded], byte 0
        je near .3
        cmp word [MusicStopRequest], byte 4
        jge near .3
        mov ebx, dword [MusicRestart]
        sar ebx, 10h
        lea eax, [nosplit ebx*4+00h]
        add eax, ebx
        shl eax, 4
        add eax, MusicTrackTable
        call MakeDataPath
        mov edx, dword [MusicRestart]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        shl eax, 4
        mov edx, str_MENU
        add eax, MusicTrackTable
        call strstr_
        test eax, eax
        je short .1
        test byte [AudioOptions], 2
        jmp short .2
.1:
        test byte [MusicOptions], 10h
.2:
        je short .3
        mov edx, dword [MusicRestart]
        sar edx, 10h
        inc edx
        mov ebx, 4
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        inc word [MusicStopRequest]
        mov word [MusicBlock], dx
.3:
        pop edx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        mov ecx, eax
        cmp word [SfxBankLoaded], byte 0
        je near .6
        mov edx, str_MENU
        call strstr_
        test eax, eax
        je short .4
        test byte [AudioOptions], 2
        jmp short .5
.4:
        test byte [MusicOptions], 10h
.5:
        je short .6
        cmp word [MusicStopRequest], byte 4
        jge short .6
        mov edx, dword [MusicRestart]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        mov ebx, 50h
        shl eax, 4
        mov edx, ecx
        add eax, MusicTrackTable
        mov ecx, 4
        call strncpy_
        mov eax, dword [MusicRestart]
        mov edx, 1
        sar eax, 10h
        mov dword [MusicStartTime], edx
        add edx, eax
        mov dword [MusicHandle], eax
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov ebx, 1
        mov cx, word [MusicStopRequest]
        mov dword [MusicTrack], ebx
        inc ecx
        mov word [MusicBlock], dx
        mov word [MusicStopRequest], cx
.6:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push edx
        mov edx, eax
        cmp word [SfxBankLoaded], byte 0
        je near .9
        cmp word [MusicStopRequest], byte 4
        jge near .9
        mov ebx, dword [MusicRestart]
        sar ebx, 10h
        lea eax, [nosplit ebx*4+00h]
        add eax, ebx
        shl eax, 4
        add eax, MusicTrackTable
        call MakeDataPath
        mov edx, dword [MusicRestart]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        shl eax, 4
        mov edx, str_MENU
        add eax, MusicTrackTable
        call strstr_
        test eax, eax
        je short .7
        test byte [AudioOptions], 2
        jmp short .8
.7:
        test byte [MusicOptions], 10h
.8:
        je short .9
        mov edx, 1
        mov eax, dword [MusicRestart]
        mov ebx, 4
        sar eax, 10h
        mov dword [MusicStartTime], edx
        add edx, eax
        mov dword [MusicHandle], eax
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        inc word [MusicStopRequest]
        mov ebx, 1
        mov word [MusicBlock], dx
        mov dword [MusicTrack], ebx
.9:
        pop edx
        pop ebx
        ret
        db 090h
        cmp word [SfxBankLoaded], byte 0
        je short .10
        mov dword [MusicStartTime], 1
.10:
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; QueueMusicRestart                               41CF0  97 PC, low confidence
; Asks for the current music track to start again
;-----------------------------------------------------------------------------
QueueMusicRestart:
        push edx
        cmp word [SfxBankLoaded], byte 0
        je short .1
        mov eax, dword [MusicRestart]
        mov edx, 1
        sar eax, 10h
        mov dword [MusicStartTime], edx
        mov dword [MusicHandle], eax
.1:
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PauseMusic                                      41D18  97 PC, low confidence
; Asks the music to pause
;-----------------------------------------------------------------------------
PauseMusic:
        cmp word [SfxBankLoaded], byte 0
        je short .1
        mov dword [MusicPaused], 1
.1:
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ResumeMusic                                     41D30  97 PC, low confidence
; Lets the paused music play on
;-----------------------------------------------------------------------------
ResumeMusic:
        push edx
        cmp word [SfxBankLoaded], byte 0
        je short .1
        xor edx, edx
        mov dword [MusicPaused], edx
.1:
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; MusicPlaying                                    41D48  97 PC, low confidence
; 1 while the music stream (MusicVolumeLevel) is still playing, with music on
;-----------------------------------------------------------------------------
MusicPlaying:
        cmp word [SfxBankLoaded], byte 0
        je short .2
        cmp dword [MusicTime], byte 0
        je short .2
        cmp dword [MusicFeedCount], byte 0
        je short .2
        cmp dword [MusicState], byte 4
        jne short .2
        mov eax, dword [MusicVolumeLevel]
        call ChannelPlaying
        test eax, eax
        jne short .1
        mov eax, 1
        ret
.1:
        cmp word [MusicStopRequest], byte 0
        jle short .2
        mov eax, 1
        ret
.2:
        xor eax, eax
        ret
;-----------------------------------------------------------------------------
; MusicStreamTick                                 41D94  97 PC, low confidence
; Keeps the music stream fed when one is open
;-----------------------------------------------------------------------------
MusicStreamTick:
        push ecx
        push edx
        cmp word [SfxBankLoaded], byte 0
        je short .1
        mov edx, dword [MusicStreamPos]
        test edx, edx
        je short .1
        push edx
        call UpdateMusicStream
        add esp, byte 4
.1:
        pop edx
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; RequestMusicStop                                41DB8  97 PC, low confidence
; Asks the music to stop
;-----------------------------------------------------------------------------
RequestMusicStop:
        cmp word [SfxBankLoaded], byte 0
        je short .1
        cmp dword [MusicState], byte 0
        je short .1
        mov dword [MusicTrack], 1
.1:
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; WaitMusicEnd                                    41DD8  97 PC, low confidence
; With music on, restarts the current track request and idles (ServiceIdle)
; until MusicPlaying is 0
;-----------------------------------------------------------------------------
WaitMusicEnd:
        push ebx
        push ecx
        push edx
        push esi
        cmp word [SfxBankLoaded], byte 0
        je near .4
        cmp dword [MusicTime], byte 0
        je short .4
        cmp word [SfxBankLoaded], byte 0
        je short .1
        xor ebx, ebx
        mov dword [MusicPaused], ebx
.1:
        cmp word [SfxBankLoaded], byte 0
        je short .2
        mov eax, dword [MusicRestart]
        mov ecx, 1
        sar eax, 10h
        mov dword [MusicStartTime], ecx
        mov dword [MusicHandle], eax
.2:
        call MusicPlaying
        test eax, eax
        je short .3
        call ServiceIdle
        jmp short .2
.3:
        push byte 2
        call WaitTicks
        xor esi, esi
        mov eax, 0FFFFFFFFh
        add esp, byte 4
        mov dword [MusicStartTime], esi
        mov dword [MusicLength], esi
        mov dword [MusicTrack], esi
        mov dword [MusicHandle], eax
.4:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; MusicFileName                                41E64  97 PC, medium confidence
; (track 0-43h, buf): the music file path "%s%02d.ASF" in data folder 58h
;-----------------------------------------------------------------------------
MusicFileName:
        push ebx
        push ecx
        sub esp, byte 50h
        mov ebx, eax
        mov ecx, edx
        test eax, eax
        jl short .1
        cmp eax, byte 44h
        jl short .2
.1:
        mov byte [ecx], 0
        jmp short .3
.2:
        mov edx, 58h
        mov eax, esp
        call MakeDataPath
        push ebx
        lea eax, [byte esp+04h]
        push eax
        push str_S02dASF
        push ecx
        call sprintf_
        add esp, byte 10h
.3:
        add esp, byte 50h
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ArenaFileName                                   41EA4  97 PC, low confidence
; (clip 0-8, buf): the "%s%02d.ASF" path of data folder 59h (clip + 1)
;-----------------------------------------------------------------------------
ArenaFileName:
        push ebx
        push ecx
        sub esp, byte 50h
        mov ebx, eax
        mov ecx, edx
        test eax, eax
        jl short .1
        cmp eax, byte 9
        jl short .2
.1:
        mov byte [ecx], 0
        jmp short .3
.2:
        mov edx, 59h
        mov eax, esp
        inc ebx
        call MakeDataPath
        push ebx
        lea eax, [byte esp+04h]
        push eax
        push str_S02dASF
        push ecx
        call sprintf_
        add esp, byte 10h
.3:
        add esp, byte 50h
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; StopBankSounds                                  41EE4  97 PC, low confidence
; Stops every sound playing from a sound bank
;-----------------------------------------------------------------------------
StopBankSounds:
        push ebx
        push edx
        push esi
        mov ebx, eax
        cmp word [SfxBankLoaded], byte 0
        je short .3
        test eax, eax
        jl short .3
        cmp eax, byte 6
        jge short .3
        mov esi, 0FFFFFFFFh
        xor edx, edx
.1:
        cmp ebx, dword [dword edx+SfxChannelIds]
        jne short .2
        mov eax, dword [dword edx+SfxChannelRecords]
        call StopChannel
        mov dword [dword edx+SfxChannelIds], esi
.2:
        add edx, byte 0Ch
        cmp edx, 0C0h
        jne short .1
.3:
        pop esi
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PlayMenuSfx                                     41F2C  97 PC, low confidence
; Plays a sound effect by number (bank in the high byte)
;-----------------------------------------------------------------------------
PlayMenuSfx:
        push ebx
        push ecx
        push edx
        push ebp
        mov ebx, eax
        cmp word [SfxBankLoaded], byte 0
        je short .3
        test eax, eax
        jl short .3
        cmp eax, 525h
        jge short .3
        sar eax, 8
        lea ecx, [byte eax-01h]
        test ecx, ecx
        jl short .3
        cmp ecx, byte 6
        jge short .3
        cmp dword [nosplit eax*4+SfxGroupTable], byte 0
        je short .3
        mov ebp, 0FFFFFFFFh
        and ebx, 0FFh
        xor edx, edx
.1:
        cmp ecx, dword [dword edx+SfxChannelIds]
        jne short .2
        cmp ebx, dword [dword edx+SfxChannelTimes]
        jne short .2
        mov eax, dword [dword edx+SfxChannelRecords]
        call StopChannel
        mov dword [dword edx+SfxChannelIds], ebp
.2:
        add edx, byte 0Ch
        cmp edx, 0C0h
        jne short .1
.3:
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; StopAllSfx                                      41FA0  97 PC, low confidence
; Stops every voice in PlaySfx's list (SfxChannelIds)
;-----------------------------------------------------------------------------
StopAllSfx:
        push ecx
        push edx
        cmp word [SfxBankLoaded], byte 0
        je short .3
        mov ecx, 0FFFFFFFFh
        xor edx, edx
.1:
        cmp dword [dword edx+SfxChannelIds], byte 0FFFFFFFFh
        je short .2
        mov eax, dword [dword edx+SfxChannelRecords]
        call StopChannel
        mov dword [dword edx+SfxChannelIds], ecx
.2:
        add edx, byte 0Ch
        cmp edx, 0C0h
        jne short .1
.3:
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PlaySfx                                      41FDC  96 PC, medium confidence
; (id 1-48h): plays a digital sound effect from the loaded banks on a free voice at the globalset volume;
; called from checkcheck, FallDown, CompPass, the faceoff and the menus
;-----------------------------------------------------------------------------
PlaySfx:
        push ebx
        push ecx
        push edx
        push esi
        mov edx, eax
        cmp word [SfxBankLoaded], byte 0
        je near .1
        call ReplaySoundAllowed
        test eax, eax
        je near .1
        test byte [SfxOptions], 2
        je near .1
        test edx, edx
        jl near .1
        cmp edx, 525h
        jge near .1
        mov eax, edx
        sar eax, 8
        lea esi, [byte eax-01h]
        test esi, esi
        jl short .1
        cmp esi, byte 6
        jge short .1
        shl eax, 2
        cmp dword [dword eax+SfxGroupTable], byte 0
        je short .1
        mov ebx, dword [SfxVolumeLevel]
        mov ecx, edx
        mov eax, dword [dword eax+SfxBankPtrs]
        and ecx, 0FFh
        sar ebx, 10h
        mov edx, ecx
        call PlaySample
        mov edx, dword [LastSfxPlayed]
        mov ebx, eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov dword [nosplit eax*4+SfxChannelIds], esi
        mov dword [nosplit eax*4+SfxChannelTimes], ecx
        inc edx
        mov dword [nosplit eax*4+SfxChannelRecords], ebx
        mov ebx, 10h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov dword [LastSfxPlayed], edx
.1:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PlaySfxOr                                    42098  96 PC, medium confidence
; (id, other): plays other instead of id when id is 40h+ and the extra bank
; (SfxBankLoaded) is not loaded
;-----------------------------------------------------------------------------
PlaySfxOr:
        push ebx
        push ecx
        push esi
        mov cx, word [SfxBankLoaded]
        mov ebx, 1
        test cx, cx
        je short .3
        test eax, eax
        jl short .1
        cmp eax, 525h
        jge short .1
        mov ecx, eax
        sar ecx, 8
        lea esi, [byte ecx-01h]
        test esi, esi
        jl short .1
        cmp esi, byte 6
        jge short .1
        cmp dword [nosplit ecx*4+SfxGroupTable], byte 0
        je short .1
        xor ebx, ebx
.1:
        test ebx, ebx
        je short .2
        mov eax, edx
.2:
        call PlaySfx
.3:
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PositionSfx                                     420E4  97 PC, low confidence
; Works out a sound's volume and pan from its rink position and the camera
;-----------------------------------------------------------------------------
PositionSfx:
        push ebx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 20h
        and esp, byte 0FFFFFFF8h
        mov esi, dword [byte ebp+020h]
        fld dword [byte ebp+01Ch]
        fld dword [byte ebp+018h]
        fsub dword [CameraStateRecords+7]
        fxch
        fsub dword [CameraStateRecords+0Fh]
        fxch
        fstp dword [byte esp+018h]
        fst dword [byte esp+01Ch]
        fld dword [byte esp+018h]
        call IF@ATAN2
        fadd dword [CameraStateRecords+17h]
        fst dword [byte esp+014h]
        fst qword [byte esp+0Ch]
        fcomp qword [F64_3p14159_PositionSfx]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+0Ch]
        fadd qword [F64_neg6p28319_PositionSfx]
        jmp short .2
.1:
        fld qword [byte esp+0Ch]
        fcomp qword [F64_neg3p14159_PositionSfx]
        fnstsw ax
        sahf
        jae short .3
        fld qword [byte esp+0Ch]
        fadd qword [F64_6p28319_PositionSfx]
.2:
        fstp dword [byte esp+014h]
.3:
        fld dword [byte esp+01Ch]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fstp dword [byte esp+04h]
        mov dword [esi], 2
        fld dword [byte esp+04h]
        fcomp dword [F32_9600]
        fnstsw ax
        sahf
        jae short .5
        fld dword [byte esp+04h]
        fsub dword [F32_768_PositionSfx]
        fldz
        fxch
        fstp dword [byte esp+04h]
        fcomp dword [byte esp+04h]
        fnstsw ax
        sahf
        jbe short .4
        mov dword [esi], 64h
        jmp short .5
.4:
        fld dword [F32_9600]
        fsub dword [F32_768_PositionSfx]
        fld dword [byte esp+04h]
        fmul dword [F32_98]
        fdivrp
        mov eax, 62h
        call __CHP
        fistp dword [byte esp+08h]
        mov edx, dword [byte esp+08h]
        mov ebx, dword [esi]
        sub eax, edx
        add ebx, eax
        mov dword [esi], ebx
.5:
        lea edi, [byte esp+04h]
        mov esi, esp
        lea eax, [byte esp+014h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [esp]
        fmul dword [F32_42]
        call __CHP
        fistp dword [byte esp+08h]
        mov eax, dword [byte esp+08h]
        mov esi, dword [byte ebp+024h]
        add eax, byte 3Fh
        mov dword [esi], eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ebx
        ret 10h
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PlaySfxVolume                                   42220  97 PC, low confidence
; (id, volume 0-64h, ...): PlaySfx with a volume (scaled by the globalset
; sound volume) and position
;-----------------------------------------------------------------------------
PlaySfxVolume:
        push ebx
        push ecx
        push esi
        push edi
        sub esp, byte 8
        mov ebx, eax
        test byte [SfxOptions], 2
        je near .3
        mov eax, ebx
        call ReplaySoundAllowed
        test eax, eax
        je near .3
        test ebx, ebx
        jl near .3
        cmp ebx, 525h
        jge near .3
        mov eax, ebx
        sar eax, 8
        lea esi, [byte eax-01h]
        test esi, esi
        jl near .3
        cmp esi, byte 6
        jge near .3
        cmp dword [nosplit eax*4+SfxGroupTable], byte 0
        je near .3
        cmp edx, byte 64h
        jle short .1
        mov edx, 64h
.1:
        test edx, edx
        jge short .2
        xor edx, edx
.2:
        mov eax, esp
        push eax
        lea eax, [byte esp+08h]
        push eax
        push dword [byte esp+028h]
        push dword [byte esp+028h]
        call PositionSfx
        imul edx, dword [byte esp+04h]
        mov esi, 64h
        mov eax, edx
        sar edx, 1Fh
        idiv esi
        mov edx, dword [SfxVolumeScale]
        sar edx, 10h
        imul edx, eax
        mov dword [byte esp+04h], eax
        mov eax, edx
        sar edx, 1Fh
        idiv esi
        mov dword [byte esp+04h], eax
        mov edx, eax
        shl eax, 3
        sub eax, edx
        mov edx, eax
        shl eax, 4
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        idiv esi
        mov edi, ebx
        sar edi, 8
        add eax, byte 16h
        mov esi, ebx
        mov ebx, dword [esp]
        mov dword [byte esp+04h], eax
        and esi, 0FFh
        mov ecx, dword [byte esp+04h]
        mov edx, esi
        mov eax, dword [nosplit edi*4+SfxBankPtrs]
        call PlaySampleVolume
        mov edx, dword [LastSfxPlayed]
        mov ebx, eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        dec edi
        mov dword [nosplit eax*4+SfxChannelIds], edi
        mov dword [nosplit eax*4+SfxChannelTimes], esi
        inc edx
        mov dword [nosplit eax*4+SfxChannelRecords], ebx
        mov ebx, 10h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov dword [LastSfxPlayed], edx
.3:
        add esp, byte 8
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 8
        db 090h
;-----------------------------------------------------------------------------
; PlaySfxAt                                       42354  97 PC, low confidence
; Plays a sound effect at an object's position
;-----------------------------------------------------------------------------
PlaySfxAt:
        push ecx
        push esi
        push edi
        mov ecx, edx
        mov edx, ebx
        mov bx, word [SfxBankLoaded]
        mov esi, 1
        test bx, bx
        je short .4
        test eax, eax
        jl short .1
        cmp eax, 525h
        jge short .1
        mov edi, eax
        sar edi, 8
        lea ebx, [byte edi-01h]
        test ebx, ebx
        jl short .1
        cmp ebx, byte 6
        jge short .1
        cmp dword [nosplit edi*4+SfxGroupTable], byte 0
        je short .1
        xor esi, esi
.1:
        test esi, esi
        je short .2
        push dword [byte esp+014h]
        mov eax, ecx
        jmp short .3
.2:
        push dword [byte esp+014h]
.3:
        push dword [byte esp+014h]
        call PlaySfxVolume
.4:
        pop edi
        pop esi
        pop ecx
        ret 8
        db 090h
;-----------------------------------------------------------------------------
; SetAmbientVolume                                423B4  97 PC, low confidence
; Sets the arena ambience volume in percent of the effect volume
;-----------------------------------------------------------------------------
SetAmbientVolume:
        push ebx
        push edx
        cmp word [SfxBankLoaded], byte 0
        je short .1
        cmp dword [MusicReady], byte 0
        je short .1
        test byte [MusicOptions], 4
        je short .1
        mov edx, dword [SfxVolumeLevel]
        sar edx, 10h
        imul edx, eax
        mov ebx, 64h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov ebx, dword [SoundCardType]
        mov dword [AmbientVolume], eax
        test ebx, ebx
        je short .1
        mov edx, eax
        shl eax, 2
        add eax, edx
        shl eax, 2
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        shl edx, 5
        LD sbb, eax, edx
        sar eax, 5
        mov dword [AmbientVolume], eax
.1:
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetCrowdNoise                                   4241C  97 PC, low confidence
; Sets the crowd noise level in percent
;-----------------------------------------------------------------------------
SetCrowdNoise:
        push ebx
        push edx
        cmp word [SfxBankLoaded], byte 0
        je short .2
        cmp dword [MusicReady], byte 0
        je short .2
        test byte [MusicOptions], 4
        je short .2
        mov edx, dword [SfxVolumeLevel]
        sar edx, 10h
        imul edx, eax
        mov ebx, 64h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov ebx, dword [SoundCardType]
        mov dword [CrowdNoiseLevel], eax
        mov dword [AmbientVolume], eax
        test ebx, ebx
        je short .1
        mov edx, eax
        shl eax, 2
        add eax, edx
        shl eax, 2
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        shl edx, 5
        LD sbb, eax, edx
        sar eax, 5
        mov dword [CrowdNoiseLevel], eax
        mov dword [AmbientVolume], eax
.1:
        mov eax, dword [CrowdNoiseLevel]
        call SetSpeechVolume
.2:
        pop edx
        pop ebx
.3:
        ret
        db 08Bh,0C0h
        cmp word [SfxBankLoaded], byte 0
        je short .3
        mov eax, 525h
        call ReplaySoundAllowed
        test eax, eax
        je short .3
        cmp dword [MusicReady], byte 0
        je short .3
        test byte [MusicOptions], 4
        je short .3
        mov eax, 32h
        jmp near SetChannelVolume
;-----------------------------------------------------------------------------
; SetCrowdMood                                    424CC  97 PC, low confidence
; Sets the crowd mood (0 to 13) when crowd sound is on
;-----------------------------------------------------------------------------
SetCrowdMood:
        push edx
        mov edx, eax
        cmp word [SfxBankLoaded], byte 0
        je short .1
        mov eax, 525h
        call ReplaySoundAllowed
        test eax, eax
        je short .1
        cmp dword [MusicReady], byte 0
        je short .1
        test byte [MusicOptions], 4
        je short .1
        test edx, edx
        jl short .1
        cmp edx, byte 0Dh
        jg short .1
        mov eax, edx
        call SetMasterVolume
.1:
        pop edx
        ret
        db 090h
        push edx
        mov edx, eax
        cmp word [SfxBankLoaded], byte 0
        je short .2
        mov eax, 525h
        call ReplaySoundAllowed
        test eax, eax
        je short .2
        cmp dword [MusicReady], byte 0
        je short .2
        test byte [MusicOptions], 4
        je short .2
        test edx, edx
        jl short .2
        cmp edx, 80h
        jge short .2
        mov eax, edx
        call SetChannelVolume
.2:
        pop edx
        ret
