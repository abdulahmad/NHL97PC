; Sound: InitSoundMixer, SetMixerVolumes, SetMasterVolume, SetChannelVolume, SetSpeechVolume and 18 more.
bits 32
%include "hockey.inc"
section s_107D6D progbits alloc exec nowrite align=1
extern AddStreamSample, AllocMemBlock, ApplyChannelVolume, AudioEnter, AudioLeaveCheck, AudioSpeechHook, AudioWorkHook, CdStreamFreePacket
extern CdStreamNextPacket, CdStreamService, ChannelSampleTable, ClearSpeechBankTable, ClearSpeechQueue, ClearSpeechRing, DigitalAudioRate, FreeMemBlock
extern InitStreamHeader, IsChannelActive, LoadSampleHeader, MixerBlockSize, MixerChannelCount, MixerChannelVolumes, MixerMasterLeft, MixerMasterRight
extern MixerMasterVolume, MixerMode, MixerRampCount, MixerRampLevel, MixerRampStep, MixerRampTarget, MixerSfxVolume, MixerSpeechVolume
extern MixerVolLeft, MixerVolRight, MixerVolScale, MixerVolumeTable, MixNoise, PlayBankSample, PlaySample, PlaySoundEntry
extern RampChannelVolume, RegisterStreamBank, RequestStreamRead, ResetGameVars, ResetSpeechStreamState, ServiceSpeechIfOpen, SetChannelVolumeChecked, SoundSystemOn
extern SpeechBufferSize, SpeechBufferTag, SpeechChannelA, SpeechChannelB, SpeechChannelFunc, SpeechEnabled, SpeechStreamActive, SpeechStreamBuffer
extern SpeechStreamChannel, SpeechStreamData, SpeechStreamHandle, SpeechStreamHeader, SpeechStreamOpen, SpeechStreamPos, SpeechStreamSize, StartChannel
extern StopChannel, str_VoxPlaybuf, StreamBuffer, StreamBufSize, StreamCallbackPos, StreamChannel, StreamClosing, StreamFeeding
extern StreamFill, StreamFlags, StreamLengthFn, StreamOpen, StreamPacketCount, StreamPacketQueue, StreamPackets, StreamPacketSlots
extern StreamPaused, StreamPosition, StreamReadPos, StreamStarted, StreamStereo, StreamWritePos, UnregisterSoundBank
global InitSoundMixer, SetMixerVolumes, SetMasterVolume, SetChannelVolume, SetSpeechVolume, StopAllChannels, ResetSoundChannels, MixAudioBlock
global MixChannelFormatJumpTable, MixChannelFormat, MixChannelFormat_20, MixChannelFormat_FC, MixChannelFormat_1C0, MixChannelFormat_27B, MixVolumeRamp, SetMusicStreamVolume
global CloseSpeechChannels, AllocSpeechBuffers, InitSpeechChannels, OpenAudioStreamChannel, CloseAudioStreamChannel, FeedAudioStream, AudioStreamPosition, AudioStreamDone
global StartAudioStream, FlushAudioStream, QueueStreamPacket, AudioStreamCallback
        db 00h,00h,00h
;-----------------------------------------------------------------------------
; InitSoundMixer                                 107D70  97 PC, low confidence
; Sets up the sound mixer
;-----------------------------------------------------------------------------
InitSoundMixer:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov esi, dword [MixerVolumeTable]
        mov ebx, edx
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        jmp near .7
.1:
        cmp dword [AudioWorkHook], byte 0
        je short .2
        mov eax, 0FFFFFFFFh
        mov dword [MixerVolumeTable], esi
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        mov ecx, dword [ebx]
        mov esi, ebx
        cmp ecx, 6C445243h
        je short .3
        mov eax, 0FFFFFFF9h
        mov dword [MixerVolumeTable], esi
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.3:
        cmp byte [byte ebx+04h], 2
        je short .4
        mov eax, 0FFFFFFF5h
        mov dword [MixerVolumeTable], esi
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.4:
        xor edx, edx
        mov dl, byte [byte ebx+07h]
        mov ecx, 64h
        shl edx, 9
        mov byte [MixerChannelCount], al
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov edx, 200h
        mov word [MixerRampStep], ax
        sub edx, eax
        mov cl, byte [byte ebx+05h]
        mov word [MixerRampTarget], dx
        test cl, cl
        jne short .6
        mov ebx, esi
        xor eax, eax
.5:
        lea ecx, [dword esi+0128h]
        mov edi, dword [dword ebx+eax+0128h]
        add ecx, eax
        add ecx, edi
        mov dword [dword ebx+eax+0128h], ecx
        lea ecx, [dword esi+0148h]
        mov ebp, dword [dword ebx+eax+0148h]
        add ecx, eax
        add eax, byte 4
        add ecx, ebp
        mov dword [dword ebx+eax+0144h], ecx
        cmp eax, byte 20h
        jne short .5
        mov byte [byte esi+05h], 1
.6:
        mov ch, 1
        mov eax, MixAudioBlock
        mov byte [MixerMode], ch
        mov dword [AudioWorkHook], eax
        xor eax, eax
.7:
        mov dword [MixerVolumeTable], esi
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetMixerVolumes                                107E74  97 PC, low confidence
; Sets the mixer volumes
;-----------------------------------------------------------------------------
SetMixerVolumes:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edx, eax
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        jmp near .7
.1:
        mov bl, byte [MixerMode]
        cmp bl, 1
        je short .2
        mov eax, 0FFFFFFFFh
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        call AudioEnter
        mov byte [MixerSfxVolume], bl
        xor ebx, ebx
        mov dword [MixerVolLeft], ebx
        mov dword [MixerVolScale], ebx
        mov dword [MixerVolRight], ebx
        xor ebx, ebx
        mov eax, edx
        mov word [MixerBlockSize], bx
        test edx, edx
        jl short .3
        cmp edx, byte 7Fh
        jg short .3
        mov byte [MixerSpeechVolume], al
.3:
        mov edi, 0FFFFFFFFh
        xor ecx, ecx
        xor esi, esi
.4:
        mov eax, dword [MixerVolumeTable]
        add eax, ecx
        cmp byte [byte eax+020h], 0
        jl short .5
        mov edx, dword [byte eax+01Dh]
        xor ebx, ebx
        mov eax, dword [MixerMasterRight]
        sar edx, 18h
        sar eax, 18h
        call PlaySample
        mov dword [dword esi+MixerChannelVolumes], eax
        jmp short .6
.5:
        mov dword [dword esi+MixerChannelVolumes], edi
.6:
        inc ecx
        add esi, byte 4
        cmp ecx, byte 8
        jl short .4
        mov dh, 2
        mov eax, dword [MixerVolumeTable]
        mov byte [MixerMode], dh
        mov al, byte [byte eax+06h]
        and eax, 0FFh
        call SetMasterVolume
        call AudioLeaveCheck
        xor eax, eax
.7:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetMasterVolume                                107F48  97 PC, low confidence
; Sets the master volume
;-----------------------------------------------------------------------------
SetMasterVolume:
        push ebx
        push ecx
        push edx
        mov edx, eax
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        cmp byte [MixerMode], 2
        je short .2
        mov eax, 0FFFFFFFFh
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        test edx, edx
        jl short .3
        cmp edx, byte 10h
        jl short .4
.3:
        mov eax, 0FFFFFFF8h
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov ebx, edx
        mov eax, dword [MixerVolumeTable]
        shl ebx, 4
        cmp byte [byte ebx+eax+028h], 0
        jne short .5
        mov eax, 0FFFFFFF8h
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        call AudioEnter
        mov eax, dword [MixerVolumeTable]
        add ebx, eax
        mov eax, dword [byte ebx+02Ch]
        sar eax, 10h
        mov ecx, dword [MixerVolLeft]
        shl eax, 10h
        cmp eax, ecx
        jle short .7
        mov ecx, dword [byte ebx+02Ah]
        sar ecx, 10h
        mov ebx, dword [MixerVolLeft]
        shl ecx, 10h
        add ebx, ecx
        mov dword [MixerVolRight], ebx
        cmp eax, ebx
        jge short .6
        mov dword [MixerVolRight], eax
.6:
        mov ebx, edx
        mov eax, dword [MixerVolumeTable]
        shl ebx, 4
        mov ebx, dword [byte ebx+eax+030h]
        mov byte [MixerMasterVolume], dl
        lea eax, [nosplit ebx*4+00h]
        xor ch, ch
        sub eax, ebx
        mov byte [MixerSfxVolume], ch
        mov dword [MixerVolScale], eax
.7:
        mov eax, dword [MixerVolumeTable]
        shl edx, 4
        add eax, edx
        cmp byte [byte eax+029h], 0
        jl short .8
        mov ebx, dword [MixerMasterLeft]
        mov edx, dword [byte eax+026h]
        mov eax, dword [MixerMasterRight]
        sar ebx, 18h
        sar edx, 18h
        sar eax, 18h
        call PlaySample
.8:
        call AudioLeaveCheck
        xor eax, eax
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetChannelVolume                               108040  97 PC, low confidence
; Sets the volume of a sound channel
;-----------------------------------------------------------------------------
SetChannelVolume:
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        ret
.1:
        test eax, eax
        jl short .2
        cmp eax, 1FFh
        jle short .3
.2:
        mov eax, 0FFFFFFF8h
        ret
.3:
        mov word [MixerRampLevel], ax
        xor eax, eax
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        cmp byte [SoundSystemOn], 0
        jne short .4
        mov eax, 0FFFFFFF6h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        cmp byte [MixerMode], 2
        je short .5
        mov eax, 0FFFFFFFFh
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        call AudioEnter
        xor ecx, ecx
.6:
        mov ebx, 0FFFFFFFFh
        mov edx, esi
        mov eax, dword [dword ecx+MixerChannelVolumes]
        add ecx, byte 4
        call SetChannelVolumeChecked
        cmp ecx, byte 20h
        jne short .6
        mov byte [MixerMode], 3
        call AudioLeaveCheck
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        push esi
        cmp byte [SoundSystemOn], 0
        jne short .7
        mov eax, 0FFFFFFF6h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        cmp byte [MixerMode], 3
        je short .8
        mov eax, 0FFFFFFFFh
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        call AudioEnter
        xor ecx, ecx
        xor esi, esi
.9:
        mov eax, dword [MixerVolumeTable]
        add eax, ecx
        cmp byte [byte eax+020h], 0
        jl short .10
        mov edx, dword [byte eax+01Dh]
        xor ebx, ebx
        mov eax, dword [MixerMasterRight]
        sar edx, 18h
        sar eax, 18h
        call PlaySample
        mov dword [dword esi+MixerChannelVolumes], eax
.10:
        inc ecx
        add esi, byte 4
        cmp ecx, byte 8
        jl short .9
        mov byte [MixerMode], 2
        call AudioLeaveCheck
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetSpeechVolume                                108144  97 PC, low confidence
; Sets the speech volume
;-----------------------------------------------------------------------------
SetSpeechVolume:
        test eax, eax
        jl short .1
        cmp eax, byte 7Fh
        jle short .2
.1:
        mov eax, 0FFFFFFF8h
        ret
.2:
        mov byte [MixerSpeechVolume], al
        xor eax, eax
        ret
        db 090h
;-----------------------------------------------------------------------------
; StopAllChannels                                10815C  97 PC, low confidence
; Stops all the sound channels
;-----------------------------------------------------------------------------
StopAllChannels:
        push edx
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop edx
        ret
.1:
        mov dl, byte [MixerMode]
        cmp dl, 2
        je short .2
        cmp dl, 3
        je short .2
        mov eax, 0FFFFFFFFh
        pop edx
        ret
.2:
        call AudioEnter
        xor edx, edx
.3:
        mov eax, dword [dword edx+MixerChannelVolumes]
        add edx, byte 4
        call StopChannel
        cmp edx, byte 20h
        jne short .3
        mov byte [MixerMode], 1
        call AudioLeaveCheck
        xor eax, eax
        pop edx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ResetSoundChannels                             1081B0  97 PC, low confidence
; Resets the sound channels
;-----------------------------------------------------------------------------
ResetSoundChannels:
        push edx
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop edx
        ret
.1:
        call AudioEnter
        xor edx, edx
        call StopAllChannels
        mov dword [AudioWorkHook], edx
        call AudioLeaveCheck
        xor dl, dl
        xor eax, eax
        mov byte [MixerMode], dl
        pop edx
        ret
;-----------------------------------------------------------------------------
; MixAudioBlock                                  1081E4  97 PC, low confidence
; Mixes one audio block
;-----------------------------------------------------------------------------
MixAudioBlock:
        push ecx
        push edx
        push edi
        cmp byte [MixerMode], 2
        jne short .4
        mov ax, word [MixerBlockSize]
        mov dx, word [MixerRampLevel]
        cmp ax, dx
        jle short .1
        mov edi, eax
        sub edi, byte 0Ch
        mov word [MixerBlockSize], di
        cmp di, dx
        jge short .3
        jmp short .2
.1:
        jge short .3
        mov ecx, eax
        add ecx, byte 0Ch
        mov word [MixerBlockSize], cx
        cmp cx, dx
        jle short .3
.2:
        mov word [MixerBlockSize], dx
.3:
        call MixChannelFormat
        call MixVolumeRamp
.4:
        pop edi
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
MixChannelFormatJumpTable:                      ; jump table for the switch cases of MixChannelFormat
        dd MixChannelFormat_20
        dd MixChannelFormat_FC
        dd MixChannelFormat_1C0
        dd MixChannelFormat_27B
;-----------------------------------------------------------------------------
; MixChannelFormat                               108250  97 PC, low confidence
; Mixes a channel by its sample format
;-----------------------------------------------------------------------------
MixChannelFormat:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov al, byte [MixerSfxVolume]
        cmp al, 3
        ja near MixChannelFormat_27B.15
        and eax, 0FFh
        jmp dword [nosplit cs:eax*4+MixChannelFormatJumpTable]
MixChannelFormat_20:
        mov eax, dword [MixerVolScale]
        mov edi, dword [MixerVolLeft]
        add edi, eax
        mov ebp, dword [MixerVolRight]
        mov dword [MixerVolLeft], edi
        cmp edi, ebp
        jl near MixChannelFormat_27B.15
        mov eax, dword [MixerVolumeTable]
        mov edx, dword [byte eax+06h]
        mov eax, dword [byte eax+08h]
        mov dword [MixerVolLeft], ebp
        sar eax, 10h
        sar edx, 10h
        call MixNoise
        add edx, eax
        mov dword [MixerVolRight], edx
        cmp edx, 1FFh
        jle short .1
        mov dword [MixerVolRight], 1FFh
.1:
        cmp dword [MixerVolRight], byte 0
        jge short .2
        xor ecx, ecx
        mov dword [MixerVolRight], ecx
.2:
        mov esi, dword [MixerVolRight]
        shl esi, 10h
        mov edi, dword [MixerVolLeft]
        mov dword [MixerVolRight], esi
        cmp esi, edi
        jge short .3
        mov edx, edi
        sub edx, esi
        jmp short .4
.3:
        mov edx, 10000h
.4:
        mov eax, dword [MixerMode]
        sar eax, 18h
        mov ebx, dword [MixerVolumeTable]
        shl eax, 4
        mov ebx, dword [byte ebx+eax+034h]
        mov eax, ebx
        shl eax, 5
        add ebx, eax
        sar ebx, 10h
        test ebx, ebx
        jg short .5
        mov ebx, 1
.5:
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov dword [MixerVolScale], eax
        test eax, eax
        jg short .6
        mov dword [MixerVolScale], 1
.6:
        mov byte [MixerSfxVolume], 1
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
MixChannelFormat_FC:
        mov eax, dword [MixerVolScale]
        mov esi, dword [MixerVolLeft]
        sub esi, eax
        mov edi, dword [MixerVolRight]
        mov dword [MixerVolLeft], esi
        cmp esi, edi
        jg near MixChannelFormat_27B.15
        mov eax, dword [MixerVolumeTable]
        mov edx, dword [byte eax+012h]
        mov eax, dword [byte eax+014h]
        mov dword [MixerVolLeft], edi
        sar eax, 10h
        sar edx, 10h
        call MixNoise
        add edx, eax
        mov dword [MixerVolRight], edx
        cmp edx, 1FFh
        jle short .7
        mov dword [MixerVolRight], 1FFh
.7:
        cmp dword [MixerVolRight], byte 0
        jge short .8
        xor ebx, ebx
        mov dword [MixerVolRight], ebx
.8:
        mov ecx, dword [MixerVolRight]
        mov edx, dword [MixerVolumeTable]
        shl ecx, 10h
        mov eax, dword [byte edx+01Ch]
        mov dword [MixerVolRight], ecx
        call MixNoise
        mov ebx, dword [byte edx+018h]
        add ebx, eax
        cmp ebx, byte 1
        jge short .9
        mov ebx, 1
.9:
        mov edx, dword [MixerVolRight]
        sub edx, dword [MixerVolLeft]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        idiv ebx
        mov dh, 2
        mov dword [MixerVolScale], eax
        mov byte [MixerSfxVolume], dh
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
MixChannelFormat_1C0:
        mov eax, dword [MixerVolScale]
        mov ebx, dword [MixerVolLeft]
        add ebx, eax
        mov ecx, dword [MixerVolRight]
        mov dword [MixerVolLeft], ebx
        cmp ebx, ecx
        jl near MixChannelFormat_27B.15
        mov eax, dword [MixerVolumeTable]
        mov edx, dword [byte eax+06h]
        mov eax, dword [byte eax+08h]
        mov dword [MixerVolLeft], ecx
        sar eax, 10h
        sar edx, 10h
        call MixNoise
        add edx, eax
        mov dword [MixerVolRight], edx
        cmp edx, 1FFh
        jle short .10
        mov dword [MixerVolRight], 1FFh
.10:
        cmp dword [MixerVolRight], byte 0
        jge short .11
        xor eax, eax
        mov dword [MixerVolRight], eax
.11:
        shl dword [MixerVolRight], 10h
        mov edx, dword [MixerVolumeTable]
        mov eax, dword [byte edx+010h]
        call MixNoise
        mov ebx, dword [byte edx+0Ch]
        add ebx, eax
        cmp ebx, byte 1
        jge short .12
        mov ebx, 1
.12:
        mov edx, dword [MixerVolLeft]
        sub edx, dword [MixerVolRight]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        idiv ebx
        mov dl, 3
        mov dword [MixerVolScale], eax
        mov byte [MixerSfxVolume], dl
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
MixChannelFormat_27B:
        mov eax, dword [MixerVolScale]
        mov edx, dword [MixerVolLeft]
        sub edx, eax
        mov ebx, dword [MixerVolRight]
        mov dword [MixerVolLeft], edx
        cmp edx, ebx
        jg near .15
        mov eax, dword [MixerVolumeTable]
        mov edx, dword [byte eax+012h]
        mov eax, dword [byte eax+014h]
        mov dword [MixerVolLeft], ebx
        sar eax, 10h
        sar edx, 10h
        call MixNoise
        add edx, eax
        mov dword [MixerVolRight], edx
        cmp edx, 1FFh
        jle short .13
        mov dword [MixerVolRight], 1FFh
.13:
        cmp dword [MixerVolRight], byte 0
        jge short .14
        xor ebp, ebp
        mov dword [MixerVolRight], ebp
.14:
        mov eax, dword [MixerVolRight]
        shl eax, 10h
        mov edx, dword [MixerVolumeTable]
        mov dword [MixerVolRight], eax
        mov eax, dword [byte edx+01Ch]
        call MixNoise
        mov ebx, dword [byte edx+018h]
        mov edx, dword [MixerVolLeft]
        add ebx, eax
        mov eax, dword [MixerVolRight]
        sub eax, edx
        mov edx, eax
        shl eax, 2
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        idiv ebx
        mov dword [MixerVolScale], eax
        mov byte [MixerSfxVolume], 2
.15:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; MixVolumeRamp                                  108584  97 PC, low confidence
; Ramps a channel's volume while mixing
;-----------------------------------------------------------------------------
MixVolumeRamp:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, dword [MixerVolLeft]
        mov edx, dword [MixerRampStep]
        sar ebx, 10h
        sar edx, 10h
        imul ebx, edx
        mov eax, dword [MixerSfxVolume]
        mov edx, dword [MixerRampTarget]
        sar eax, 10h
        sar edx, 10h
        imul eax, edx
        sar ebx, 9
        sar eax, 9
        add eax, ebx
        mov edi, 7Fh
        mov word [MixerRampCount], ax
        xor ebx, ebx
.1:
        cmp dword [dword ebx+MixerChannelVolumes], byte 0
        jl short .2
        mov ecx, dword [MixerVolumeTable]
        mov esi, dword [MixerRampLevel]
        mov edx, dword [MixerMasterLeft]
        sar esi, 10h
        mov eax, dword [dword ecx+ebx+0128h]
        sar edx, 18h
        movsx eax, byte [esi+eax]
        imul edx, eax
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        mov edx, eax
        mov eax, dword [dword ecx+ebx+0148h]
        movsx ecx, byte [esi+eax]
        mov eax, dword [dword ebx+MixerChannelVolumes]
        call SetMusicStreamVolume
        mov edx, ecx
        mov eax, dword [dword ebx+MixerChannelVolumes]
        call RampChannelVolume
.2:
        add ebx, byte 4
        cmp ebx, byte 20h
        jne short .1
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        mov eax, dword [MixerRampLevel]
        sar eax, 10h
        ret
        db 00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; SetMusicStreamVolume                           108640  97 PC, low confidence
; Sets the music stream volume
;-----------------------------------------------------------------------------
SetMusicStreamVolume:
        push ebx
        push ecx
        mov ebx, eax
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop ecx
        pop ebx
        ret
.1:
        cmp edx, byte 7Fh
        jg short .2
        test edx, edx
        jge short .3
.2:
        mov eax, 0FFFFFFF8h
        pop ecx
        pop ebx
        ret
.3:
        call AudioEnter
        mov eax, ebx
        call IsChannelActive
        mov ebx, eax
        test eax, eax
        jge short .4
        call AudioLeaveCheck
        mov eax, 0FFFFFFF8h
        pop ecx
        pop ebx
        ret
.4:
        shl eax, 4
        add eax, ebx
        mov ecx, ChannelSampleTable
        shl eax, 2
        add ecx, eax
        shl edx, 10h
        mov dword [byte ecx+014h], 0
        mov eax, ebx
        mov dword [byte ecx+01Ch], edx
        call StartChannel
        mov edx, dword [byte ecx+02Ah]
        mov eax, ebx
        sar edx, 18h
        call ApplyChannelVolume
        call AudioLeaveCheck
        xor eax, eax
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CloseSpeechChannels                            1086BF  97 PC, low confidence
; Closes the speech channels
;-----------------------------------------------------------------------------
CloseSpeechChannels:
        push ecx
        push edx
        cmp dword [SpeechStreamActive], byte 0
        jl short .1
        mov eax, dword [SpeechStreamActive]
        call StopChannel
.1:
        cmp dword [SpeechStreamChannel], byte 0
        jl short .2
        mov eax, dword [SpeechStreamChannel]
        call UnregisterSoundBank
.2:
        cmp dword [SpeechStreamBuffer], byte 0
        je short .3
        push dword [SpeechStreamBuffer]
        call FreeMemBlock
        add esp, byte 4
.3:
        call ResetSpeechStreamState
        mov dword [SpeechChannelFunc], 0
        pop edx
        pop ecx
        ret
        mov dword [SpeechChannelB], 0
        mov dword [SpeechChannelA], 0FFFFFFFFh
        ret
;-----------------------------------------------------------------------------
; AllocSpeechBuffers                             108725  97 PC, low confidence
; Allocates the speech playback buffers
;-----------------------------------------------------------------------------
AllocSpeechBuffers:
        push ebx
        push ecx
        push edx
        call ResetGameVars
        mov dword [SpeechStreamHeader], SpeechBufferTag
        call SpeechBufferSize
        push byte 0
        add eax, 3480h
        push eax
        push str_VoxPlaybuf
        mov dword [SpeechStreamHandle], 3480h
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [SpeechStreamBuffer], eax
        test eax, eax
        je near .3
        xor eax, eax
        jmp short .2
.1:
        mov edx, dword [SpeechStreamBuffer]
        mov byte [edx+eax], 0
        inc eax
.2:
        cmp eax, dword [SpeechStreamHandle]
        jl short .1
        mov edx, dword [SpeechStreamBuffer]
        mov eax, dword [SpeechStreamHandle]
        add edx, eax
        mov eax, edx
        mov dword [SpeechStreamSize], edx
        call RegisterStreamBank
        mov dword [SpeechStreamChannel], eax
        test eax, eax
        jl near .3
        mov edx, SpeechStreamData
        mov ecx, dword [SpeechStreamBuffer]
        mov ebx, dword [SpeechStreamHeader]
        call AddStreamSample
        mov eax, dword [SpeechStreamHeader]
        mov eax, dword [byte eax+0Ch]
        mov byte [byte eax+08h], 64h
        mov eax, dword [SpeechStreamHandle]
        cdq
        LD sub, eax, edx
        sar eax, 1
        mov edx, eax
        mov eax, dword [SpeechStreamHeader]
        mov eax, dword [byte eax+0Ch]
        mov dword [byte eax+034h], edx
        mov eax, dword [SpeechStreamHeader]
        mov eax, dword [byte eax+0Ch]
        mov dword [byte eax+038h], 0
        mov eax, dword [SpeechStreamHandle]
        cdq
        LD sub, eax, edx
        sar eax, 1
        mov edx, eax
        mov eax, dword [SpeechStreamHeader]
        push byte 40h
        mov ecx, 7Fh
        mov eax, dword [byte eax+0Ch]
        push byte 7Fh
        mov ebx, 3Ch
        mov dword [byte eax+03Ch], edx
        push byte 40h
        mov edx, dword [SpeechStreamData]
        mov eax, dword [SpeechStreamChannel]
        call PlayBankSample
        mov dword [SpeechStreamActive], eax
        test eax, eax
        je short .3
        mov dword [SpeechStreamPos], 0
        call ClearSpeechRing
        mov eax, 1
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        xor eax, eax
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; InitSpeechChannels                             10884C  97 PC, low confidence
; Sets up the speech channels
;-----------------------------------------------------------------------------
InitSpeechChannels:
        push ecx
        push edx
        mov dword [SpeechEnabled], 0
        mov dword [SpeechChannelFunc], eax
        call ResetSpeechStreamState
        mov dword [SpeechStreamOpen], 1
        mov dword [SpeechChannelA], 0FFFFFFFFh
        mov dword [SpeechChannelB], 0
        call ClearSpeechBankTable
        call AllocSpeechBuffers
        test eax, eax
        je short .1
        call ClearSpeechQueue
        mov dword [AudioSpeechHook], ServiceSpeechIfOpen
        mov eax, 1
        pop edx
        pop ecx
        ret
.1:
        cmp dword [SpeechStreamActive], byte 0
        jl short .2
        mov eax, dword [SpeechStreamActive]
        call StopChannel
.2:
        cmp dword [SpeechStreamChannel], byte 0
        jl short .3
        mov eax, dword [SpeechStreamChannel]
        call UnregisterSoundBank
.3:
        cmp dword [SpeechStreamBuffer], byte 0
        je short .4
        push dword [SpeechStreamBuffer]
        call FreeMemBlock
        add esp, byte 4
.4:
        call ResetSpeechStreamState
        mov dword [SpeechChannelFunc], 0
        xor eax, eax
        pop edx
        pop ecx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; OpenAudioStreamChannel                         108900  97 PC, low confidence
; Opens an audio stream channel
;-----------------------------------------------------------------------------
OpenAudioStreamChannel:
        push esi
        push edi
        push ebp
        mov esi, edx
        mov edi, ebx
        test byte [StreamFlags], 2
        je short .1
        mov eax, 0FFFFFFFFh
        jmp near .11
.1:
        mov edx, AudioStreamCallback
        mov dword [StreamPosition], ecx
        mov dword [StreamChannel], eax
        xor ebx, ebx
        mov dword [StreamLengthFn], edx
        mov dword [StreamReadPos], ebx
        mov dword [StreamBufSize], ebx
        mov dword [StreamWritePos], ebx
        mov dword [StreamFill], ebx
        mov dword [StreamPackets], ebx
        mov dword [StreamPacketCount], ebx
        mov dword [StreamPacketSlots], ebx
        xor cl, cl
        xor al, al
        mov dl, byte [byte esp+010h]
        mov byte [StreamFlags], cl
        mov byte [StreamOpen], al
        mov byte [StreamFeeding], dl
        xor dh, dh
        xor ch, ch
        mov byte [StreamStarted], dh
        mov edx, 0FFFFFFFFh
        mov byte [StreamStereo], ch
        mov dword [StreamBuffer], edx
        mov dword [StreamPacketQueue], edx
        test esi, esi
        jg short .2
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        ret 4
.2:
        mov edx, dword [DigitalAudioRate]
        mov ah, byte [SoundSystemOn]
        add edi, edx
        test ah, ah
        je short .7
.3:
        call CdStreamService
        mov edx, dword [StreamChannel]
        push edx
        call CdStreamNextPacket
        add esp, byte 4
        mov edx, eax
        test eax, eax
        jge short .4
        cmp eax, byte 0FFFFFFF6h
        jg near .10
.4:
        test edx, edx
        je short .6
        mov eax, edx
        call FeedAudioStream
        test eax, eax
        jl near .11
        cmp eax, byte 3
        jne short .5
        mov ch, 4
        inc ebx
        mov byte [StreamFlags], ch
.5:
        cmp ebx, esi
        jge short .10
        call AudioStreamPosition
        cmp eax, byte 5Fh
        jge short .10
.6:
        cmp edi, dword [DigitalAudioRate]
        ja short .3
        jmp short .10
.7:
        call CdStreamService
        mov ecx, dword [StreamChannel]
        push ecx
        call CdStreamNextPacket
        add esp, byte 4
        mov edx, eax
        test eax, eax
        jge short .8
        cmp eax, byte 0FFFFFFF6h
        jg short .10
.8:
        test edx, edx
        je short .9
        push edx
        mov ebp, dword [StreamChannel]
        mov cl, 4
        push ebp
        inc ebx
        mov byte [StreamFlags], cl
        call CdStreamFreePacket
        add esp, byte 8
        cmp ebx, esi
        jge short .10
.9:
        cmp edi, dword [DigitalAudioRate]
        ja short .7
.10:
        mov eax, ebx
.11:
        pop ebp
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; CloseAudioStreamChannel                        108A60  97 PC, low confidence
; Closes an audio stream channel
;-----------------------------------------------------------------------------
CloseAudioStreamChannel:
        push ebx
        push ecx
        push edx
        test byte [StreamFlags], 2
        je short .1
        mov eax, 0FFFFFFFFh
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov dword [StreamBuffer], 0FFFFFFFFh
        test eax, eax
        jg short .2
        mov eax, 0FFFFFFF8h
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        mov dh, byte [StreamFlags]
        mov bl, byte [SoundSystemOn]
        or dh, 2
        mov byte [StreamPaused], al
        mov byte [StreamFlags], dh
        test bl, bl
        je short .3
        mov bh, dh
        or bh, 1
        mov byte [StreamFlags], bh
.3:
        test byte [StreamFlags], 1
        je short .4
        push byte 0FFFFFFFFh
        push byte 0FFFFFFFFh
        push byte 0FFFFFFFFh
        mov ecx, 0FFFFFFFFh
        mov eax, dword [StreamPackets]
        push byte 0FFFFFFFFh
        mov ebx, ecx
        mov edx, ecx
        call PlaySoundEntry
        mov dword [StreamBuffer], eax
.4:
        cmp dword [StreamBuffer], byte 0
        jl short .5
        or byte [StreamFlags], 4
.5:
        mov eax, dword [StreamBuffer]
        call IsChannelActive
        mov byte [StreamClosing], al
        mov eax, dword [StreamBuffer]
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        push esi
        mov al, byte [StreamFlags]
        and al, 5
        xor ebx, ebx
        cmp al, 4
        jb near .9
        jbe short .8
        cmp al, 5
        jne near .9
        call CdStreamService
        mov edx, dword [StreamChannel]
        push edx
        call CdStreamNextPacket
        add esp, byte 4
        mov edx, eax
        test eax, eax
        jg short .6
        cmp eax, byte 0FFFFFFF6h
        jg short .7
.6:
        mov eax, edx
        call FeedAudioStream
        mov ebx, eax
        jmp short .9
.7:
        test eax, eax
        jne short .9
        mov ebx, eax
        mov byte [StreamOpen], 1
        jmp short .9
.8:
        test byte [StreamFlags], 2
        je short .9
        call CdStreamService
        mov ecx, dword [StreamChannel]
        push ecx
        call CdStreamNextPacket
        add esp, byte 4
        test eax, eax
        jle short .9
        cmp eax, byte 0FFFFFFF6h
        jg short .9
        push eax
        mov esi, dword [StreamChannel]
        push esi
        call CdStreamFreePacket
        add esp, byte 8
.9:
        mov eax, ebx
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FeedAudioStream                                108BA0  97 PC, low confidence
; Feeds a packet to an audio stream
;-----------------------------------------------------------------------------
FeedAudioStream:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebx, eax
        call AudioEnter
        mov eax, dword [ebx]
        lea edx, [byte ebx+08h]
        cmp eax, 6C454353h
        jb short .1
        jbe near .10
        cmp eax, 6C484353h
        jb near .12
        jbe short .2
        cmp eax, 6C4C4353h
        je near .9
        jmp near .12
.1:
        cmp eax, 6C434353h
        jb near .12
        jbe short .3
        cmp eax, 6C444353h
        je short .5
        jmp near .12
.2:
        mov eax, ebx
        call QueueStreamPacket
        mov ebx, eax
        jmp near .14
.3:
        mov eax, dword [StreamPacketSlots]
        mov ecx, ebx
        lea ebx, [nosplit eax*4+00h]
        inc eax
        mov dword [StreamPacketSlots], eax
        mov eax, dword [edx]
        mov dword [dword ebx+StreamPacketQueue], eax
        cmp dword [StreamPacketSlots], byte 14h
        jl short .4
        xor ebx, ebx
        mov dword [StreamPacketSlots], ebx
.4:
        push ecx
        mov ecx, dword [StreamChannel]
        push ecx
        mov ebx, 2
        jmp near .13
.5:
        mov edx, ebx
        cmp eax, byte 0FFFFFFFFh
        je short .6
        mov dword [ebx], 0
.6:
        cmp dword [StreamWritePos], byte 0
        jne short .7
        mov dword [StreamWritePos], edx
        jmp short .8
.7:
        mov eax, dword [StreamFill]
        mov dword [eax], edx
.8:
        mov ebx, 3
        mov dword [StreamFill], edx
        call AudioLeaveCheck
        mov eax, ebx
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov ecx, dword [edx]
        push ecx
        mov esi, dword [StreamChannel]
        push esi
        call RequestStreamRead
        add esp, byte 8
        push ebx
        mov edi, dword [StreamChannel]
        push edi
        mov ebx, 4
        jmp short .13
.10:
        cmp byte [StreamFeeding], 0
        jne short .11
        mov eax, dword [StreamFill]
        mov dword [eax], 0FFFFFFFFh
.11:
        push ebx
        mov ebp, dword [StreamChannel]
        push ebp
        mov ebx, 5
        jmp short .13
.12:
        push ebx
        mov esi, dword [StreamChannel]
        push esi
        mov ebx, 0FFFFFFFFh
.13:
        call CdStreamFreePacket
        add esp, byte 8
.14:
        call AudioLeaveCheck
        mov eax, ebx
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; AudioStreamPosition                            108CE8  97 PC, low confidence
; Returns the play position of an audio stream
;-----------------------------------------------------------------------------
AudioStreamPosition:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ah, byte [StreamFlags]
        xor ebx, ebx
        test ah, 4
        jne short .1
        mov edx, 0FFFFFFFFh
        jmp near .6
.1:
        mov edx, dword [StreamWritePos]
        test edx, edx
        jne short .2
        mov edx, 0FFFFFFFFh
        mov eax, edx
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        call AudioEnter
        xor eax, eax
.3:
        mov ecx, dword [byte edx+04h]
        mov esi, dword [edx]
        add ebx, ecx
        cmp eax, esi
        je short .4
        mov edx, esi
.4:
        cmp edx, byte 0FFFFFFFEh
        je short .5
        cmp edx, byte 0FFFFFFFFh
        je short .5
        cmp eax, dword [edx]
        jne short .3
.5:
        lea edx, [nosplit ebx*4+00h]
        sub edx, ebx
        shl edx, 3
        add edx, ebx
        call AudioLeaveCheck
        shl edx, 2
        mov ebp, dword [StreamPosition]
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        mov edx, eax
        test ebx, ebx
        je short .6
        test eax, eax
        jne short .6
        mov edx, 1
.6:
        mov eax, edx
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; AudioStreamDone                                108D78  97 PC, low confidence
; Returns whether an audio stream has finished
;-----------------------------------------------------------------------------
AudioStreamDone:
        push ebx
        push ecx
        push edx
        mov ebx, dword [StreamWritePos]
        xor edx, edx
        test ebx, ebx
        jne short .1
        mov eax, 0FFFFFFFFh
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov eax, ebx
        cmp ebx, byte 0FFFFFFFEh
        je short .4
.2:
        cmp eax, byte 0FFFFFFFFh
        je short .4
        mov ecx, dword [eax]
        test ecx, ecx
        je short .4
        inc edx
        test ecx, ecx
        je short .3
        mov eax, ecx
.3:
        cmp eax, byte 0FFFFFFFEh
        jne short .2
.4:
        mov eax, edx
        pop edx
        pop ecx
        pop ebx
        ret
        mov eax, dword [StreamPacketCount]
        mov eax, dword [nosplit eax*4+StreamPacketQueue]
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StartAudioStream                               108DC4  97 PC, low confidence
; Starts an audio stream
;-----------------------------------------------------------------------------
StartAudioStream:
        push ebx
        push edx
        mov ah, byte [StreamFlags]
        test ah, 2
        jne short .1
        mov eax, 0FFFFFFF2h
        pop edx
        pop ebx
        ret
.1:
        cmp byte [StreamStarted], 0
        jne short .3
        test ah, 4
        je short .2
        test ah, 1
        jne short .3
.2:
        mov bh, 1
        mov eax, dword [DigitalAudioRate]
        mov byte [StreamStarted], bh
        mov dword [StreamReadPos], eax
.3:
        cmp byte [StreamStarted], 0
        je short .4
        mov ebx, dword [DigitalAudioRate]
        xor eax, eax
        mov edx, dword [StreamReadPos]
        mov al, byte [StreamPaused]
        sub ebx, edx
        imul eax, ebx
        xor edx, edx
        mov ebx, 64h
        div ebx
        add eax, dword [StreamBufSize]
        pop edx
        pop ebx
        ret
.4:
        mov eax, dword [StreamBufSize]
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
        mov ah, byte [StreamFlags]
        test ah, 2
        jne short .5
        mov eax, 0FFFFFFF2h
        ret
.5:
        cmp byte [StreamStereo], 0
        je short .6
        mov eax, 4
        ret
.6:
        test ah, 1
        je short .7
        test ah, 4
        je short .7
        mov eax, 3
        ret
.7:
        mov eax, 1
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FlushAudioStream                               108E74  97 PC, low confidence
; Frees the played packets of an audio stream
;-----------------------------------------------------------------------------
FlushAudioStream:
        push ebx
        push ecx
        push edx
        mov eax, dword [StreamWritePos]
        cmp eax, dword [StreamFill]
        je short .2
.1:
        mov eax, dword [StreamWritePos]
        push eax
        mov ebx, dword [StreamChannel]
        mov edx, dword [eax]
        push ebx
        mov dword [StreamWritePos], edx
        call CdStreamFreePacket
        mov eax, dword [StreamWritePos]
        mov ecx, dword [StreamFill]
        add esp, byte 8
        cmp eax, ecx
        jne short .1
.2:
        xor ah, ah
        mov byte [StreamFlags], ah
        xor eax, eax
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push edx
        cmp dword [eax], byte 0FFFFFFFFh
        je short .3
        mov dword [eax], 0
.3:
        cmp dword [StreamWritePos], byte 0
        jne short .4
        mov dword [StreamWritePos], eax
        jmp short .5
.4:
        mov edx, dword [StreamFill]
        mov dword [edx], eax
.5:
        mov dword [StreamFill], eax
        mov eax, 3
        pop edx
        ret
;-----------------------------------------------------------------------------
; QueueStreamPacket                              108EF0  97 PC, low confidence
; Queues a packet on an audio stream
;-----------------------------------------------------------------------------
QueueStreamPacket:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov ecx, eax
        mov edx, dword [StreamPackets]
        test edx, edx
        jne short .4
        mov esi, 0FFFFFFFFh
        add eax, byte 8
        mov ebx, esp
        mov dword [StreamPackets], eax
        mov dword [esp], esi
        call LoadSampleHeader
        mov edi, dword [ecx]
        mov eax, ecx
        cmp edi, esi
        je short .1
        mov dword [ecx], 0
.1:
        cmp dword [StreamWritePos], byte 0
        jne short .2
        mov dword [StreamWritePos], eax
        jmp short .3
.2:
        mov ebx, dword [StreamFill]
        mov dword [ebx], eax
.3:
        mov dword [StreamFill], eax
        jmp short .5
.4:
        push eax
        mov ebx, dword [StreamChannel]
        push ebx
        call CdStreamFreePacket
        add esp, byte 8
.5:
        mov eax, 1
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        mov edx, dword [StreamPacketSlots]
        lea ebx, [nosplit edx*4+00h]
        inc edx
        lea ecx, [byte eax+08h]
        mov dword [StreamPacketSlots], edx
        mov edx, dword [ecx]
        mov dword [dword ebx+StreamPacketQueue], edx
        cmp dword [StreamPacketSlots], byte 14h
        jl short .6
        xor ebx, ebx
        mov dword [StreamPacketSlots], ebx
.6:
        push eax
        mov ecx, dword [StreamChannel]
        push ecx
        call CdStreamFreePacket
        mov eax, 2
        add esp, byte 8
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        mov edx, dword [byte eax+08h]
        push edx
        mov ecx, dword [StreamChannel]
        push ecx
        add eax, byte 8
        call RequestStreamRead
        add esp, byte 8
        push ebx
        mov esi, dword [StreamChannel]
        push esi
        call CdStreamFreePacket
        mov eax, 4
        add esp, byte 8
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ecx
        push edx
        cmp byte [StreamFeeding], 0
        jne short .7
        mov edx, dword [StreamFill]
        mov dword [edx], 0FFFFFFFFh
.7:
        push eax
        mov edx, dword [StreamChannel]
        push edx
        call CdStreamFreePacket
        mov eax, 5
        add esp, byte 8
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; AudioStreamCallback                            10901C  97 PC, low confidence
; Refills an audio stream from its packets
;-----------------------------------------------------------------------------
AudioStreamCallback:
        push ebx
        push esi
        push edi
        push ebp
        mov esi, dword [byte esp+014h]
        mov ebx, dword [byte esp+018h]
        mov eax, dword [StreamWritePos]
        cmp eax, dword [StreamFill]
        jne short .2
        mov eax, dword [StreamWritePos]
        cmp dword [eax], byte 0FFFFFFFFh
        jne short .1
        push eax
        mov ebp, dword [StreamChannel]
        push ebp
        call CdStreamFreePacket
        mov dword [esi], 0
        add esp, byte 8
        mov dword [ebx], 0
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.1:
        add eax, byte 0Ch
        mov dword [esi], eax
        mov eax, dword [StreamWritePos]
        add eax, byte 8
        mov eax, dword [eax]
        mov dword [ebx], eax
        mov eax, dword [StreamCallbackPos]
        mov edi, dword [esi]
        cmp eax, edi
        je near .4
        xor eax, eax
        mov al, byte [StreamClosing]
        mov edx, dword [ebx]
        mov ebx, eax
        mov eax, edi
        call InitStreamHeader
        mov eax, dword [esi]
        mov dword [StreamCallbackPos], eax
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.2:
        mov eax, dword [eax]
        add eax, byte 0Ch
        mov dword [esi], eax
        mov esi, dword [StreamWritePos]
        mov esi, dword [esi]
        lea eax, [byte esi+08h]
        mov eax, dword [eax]
        mov dword [ebx], eax
        mov esi, dword [StreamWritePos]
        push esi
        mov ebx, dword [StreamChannel]
        mov eax, dword [esi]
        push ebx
        mov dword [StreamWritePos], eax
        call CdStreamFreePacket
        mov ecx, dword [StreamBufSize]
        inc ecx
        mov eax, dword [StreamPacketCount]
        mov dword [StreamBufSize], ecx
        dec dword [nosplit eax*4+StreamPacketQueue]
        mov eax, dword [StreamPacketCount]
        mov edi, dword [nosplit eax*4+StreamPacketQueue]
        add esp, byte 8
        test edi, edi
        jg short .3
        lea ebp, [byte eax+01h]
        mov dword [StreamPacketCount], ebp
        cmp ebp, byte 14h
        jl short .3
        xor edx, edx
        mov dword [StreamPacketCount], edx
.3:
        xor ebx, ebx
        mov dword [StreamCallbackPos], ebx
.4:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
