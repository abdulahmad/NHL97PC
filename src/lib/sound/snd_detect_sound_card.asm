; Sound: DetectSoundCard, ProbeSoundPorts, OpenDigitalAudio, CloseDigitalAudio, SetAudioDmaChannel and 1 more.
bits 32
%include "hockey.inc"
section s_107A2C progbits alloc exec nowrite align=1
extern ApplyChannelVolume, AudioEnter, AudioLeaveCheck, AudioSpeechHook, AudioStreamHook, AudioWorkHook, ChannelActiveFlags, ChannelHandleTable
extern ChannelSampleTable, CloseAudioDriver, DetectAudioDriver, DigitalAudioHandle, DigitalAudioRate, DigitalAudioVolume, OpenAudioDriver, ParseBlasterEnv
extern ProbeDspReset, SbDetectDsp, SoundSystemOn, SpeechPatchBits, SpeechQueueVolume, StartChannel, StopAllSoundChannels, UnregisterSoundBank
extern WssBasePorts
global DetectSoundCard, ProbeSoundPorts, OpenDigitalAudio, CloseDigitalAudio, SetAudioDmaChannel, StartDigitalAudio
;-----------------------------------------------------------------------------
; DetectSoundCard                                107A2C  97 PC, low confidence
; Detects the sound card from the BLASTER setting
;-----------------------------------------------------------------------------
DetectSoundCard:
        push ebx
        push ecx
        push edx
        sub esp, byte 10h
        mov ecx, esp
        lea ebx, [byte esp+04h]
        lea edx, [byte esp+08h]
        lea eax, [byte esp+0Ch]
        call ParseBlasterEnv
        test eax, eax
        jge short .1
        mov eax, 0FFFFFFFDh
        jmp short .5
.1:
        call SbDetectDsp
        cmp eax, 100h
        jl short .4
        cmp eax, 300h
        jge short .2
        mov eax, 3
        add esp, byte 10h
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        cmp eax, 400h
        jge short .3
        mov eax, 4
        add esp, byte 10h
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov eax, 5
        add esp, byte 10h
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov eax, 0FFFFFFFEh
.5:
        add esp, byte 10h
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ProbeSoundPorts                                107A9C  97 PC, low confidence
; Probes the sound card ports
;-----------------------------------------------------------------------------
ProbeSoundPorts:
        push edx
        push esi
        push edi
        sub esp, byte 10h
        mov edi, esp
        mov esi, WssBasePorts
        xor edx, edx
        movsd
        movsd
        movsd
        movsd
.1:
        mov eax, dword [esp+edx]
        call ProbeDspReset
        test eax, eax
        jl short .2
        xor eax, eax
        jmp short .3
.2:
        add edx, byte 4
        cmp edx, byte 10h
        jl short .1
        mov eax, 0FFFFFFFEh
.3:
        add esp, byte 10h
        pop edi
        pop esi
        pop edx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; OpenDigitalAudio                               107AE0  97 PC, low confidence
; Opens the digital audio driver
;-----------------------------------------------------------------------------
OpenDigitalAudio:
        push ebx
        push ecx
        push esi
        push edi
        mov ecx, eax
        mov ebx, edx
        cmp byte [SoundSystemOn], 0
        je short .1
        xor eax, eax
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.1:
        xor eax, eax
.2:
        add eax, byte 44h
        xor dl, dl
        mov byte [dword eax+SpeechPatchBits], dl
        cmp eax, 440h
        jne short .2
        mov eax, ecx
        xor edx, edx
        xor esi, esi
        xor edi, edi
        mov dword [DigitalAudioHandle], edx
        mov dword [DigitalAudioRate], edx
        mov dword [SpeechQueueVolume], edi
        mov dword [AudioWorkHook], esi
        mov dh, 7Fh
        mov dword [AudioSpeechHook], esi
        mov byte [DigitalAudioVolume], dh
        mov edx, ebx
        mov dword [AudioStreamHook], esi
        call SetAudioDmaChannel
        mov edx, ebx
        call OpenAudioDriver
        mov ebx, eax
        test eax, eax
        jge short .3
        call CloseAudioDriver
        mov eax, ebx
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.3:
        mov bl, 1
        xor eax, eax
        mov byte [SoundSystemOn], bl
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CloseDigitalAudio                              107B70  97 PC, low confidence
; Closes the digital audio driver
;-----------------------------------------------------------------------------
CloseDigitalAudio:
        push ebx
        push edx
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop edx
        pop ebx
        ret
.1:
        call StopAllSoundChannels
        mov eax, 0FFFFFFFFh
        call UnregisterSoundBank
        call CloseAudioDriver
        mov edx, eax
        test eax, eax
        jl short .2
        xor bl, bl
        mov byte [SoundSystemOn], bl
.2:
        mov eax, edx
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
        push edx
        xor eax, eax
.3:
        add eax, byte 44h
        xor dl, dl
        mov byte [dword eax+SpeechPatchBits], dl
        cmp eax, 440h
        jne short .3
        xor edx, edx
        mov dword [DigitalAudioHandle], edx
        mov dword [DigitalAudioRate], edx
        mov byte [DigitalAudioVolume], 7Fh
        pop edx
        ret
;-----------------------------------------------------------------------------
; SetAudioDmaChannel                             107BD8  97 PC, low confidence
; Sets the audio DMA channel
;-----------------------------------------------------------------------------
SetAudioDmaChannel:
        push ebx
        push ecx
        mov ecx, edx
        xor edx, edx
        xor ebx, ebx
        cmp eax, byte 0FFFFFFFFh
        je short .1
        mov ebx, eax
        mov edx, eax
        and ebx, 0FFh
        sub edx, ebx
.1:
        mov eax, ecx
        call DetectAudioDriver
        mov ecx, eax
        and ebx, eax
        and edx, eax
        test ebx, ebx
        je short .2
        test bl, 8
        je short .3
.2:
        test cl, 8
        je short .3
        mov eax, 8
        jmp short .8
.3:
        test ebx, ebx
        je short .4
        test bl, 2
        je short .5
.4:
        test cl, 2
        je short .5
        mov eax, 2
        jmp short .8
.5:
        test ebx, ebx
        je short .6
        test bl, 4
        je short .7
.6:
        test cl, 4
        je short .7
        mov eax, 4
        jmp short .8
.7:
        mov eax, 1
.8:
        test edx, edx
        je short .9
        test dh, 8
        je short .10
.9:
        test ch, 8
        je short .10
        or ah, 8
        pop ecx
        pop ebx
        ret
.10:
        test edx, edx
        je short .11
        test dh, 10h
        je short .12
.11:
        test ch, 10h
        je short .12
        or ah, 10h
        pop ecx
        pop ebx
        ret
.12:
        test edx, edx
        je short .13
        test dh, 4
        je short .14
.13:
        test ch, 4
        je short .14
        or ah, 4
        pop ecx
        pop ebx
        ret
.14:
        test edx, edx
        je short .15
        test dh, 20h
        je short .16
.15:
        test ch, 20h
        je short .16
        or ah, 20h
        pop ecx
        pop ebx
        ret
.16:
        test edx, edx
        je short .17
        test dh, 2
        je short .18
.17:
        test ch, 2
        je short .18
        or ah, 2
        pop ecx
        pop ebx
        ret
.18:
        or ah, 1
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h
;-----------------------------------------------------------------------------
; StartDigitalAudio                              107CB0  97 PC, low confidence
; Starts the digital audio output
;-----------------------------------------------------------------------------
StartDigitalAudio:
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
        test edx, edx
        jl short .2
        cmp edx, byte 7Fh
        jle short .3
.2:
        mov eax, 0FFFFFFF8h
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        call AudioEnter
        mov byte [DigitalAudioVolume], dl
        xor ebx, ebx
        xor ecx, ecx
.4:
        cmp byte [dword ecx+ChannelActiveFlags], 1
        jne short .5
        cmp dword [dword ecx+ChannelSampleTable], byte 0
        jl short .5
        mov eax, ebx
        call StartChannel
        mov edx, dword [dword ecx+ChannelHandleTable]
        mov eax, ebx
        sar edx, 18h
        call ApplyChannelVolume
.5:
        inc ebx
        add ecx, byte 44h
        cmp ebx, byte 10h
        jl short .4
        call AudioLeaveCheck
        xor eax, eax
        pop edx
        pop ecx
        pop ebx
        ret
