; Sound: ChannelPlaying, StopChannel, PlaySample, PlaySampleVolume, ClearSpeechRing and 3 more.
bits 32
%include "hockey.inc"
section s_1091DB progbits alloc exec nowrite align=1
extern AudioEnter, AudioLeaveCheck, CheckBankIndex, FadeOutChannel, IsChannelActive, PlaySoundEntry, SoundBankTable, SoundSystemOn
extern SpeechRingBusy, SpeechRingBytes, SpeechRingEntries, SpeechRingHead, SpeechRingTail, SpeechRingUsed, SpeechSampleBufA, SpeechSampleBufB
extern SpeechStreamFlag
global ChannelPlaying, StopChannel, PlaySample, PlaySampleVolume, ClearSpeechRing, PushSpeechRing, SpeechRingCount, SpeechBusy
        db 00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; ChannelPlaying                                 1091E0  97 PC, low confidence
; Returns whether a sound channel is playing
;-----------------------------------------------------------------------------
ChannelPlaying:
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        ret
.1:
        call IsChannelActive
        test eax, eax
        jge short .2
        mov eax, 1
        ret
.2:
        xor eax, eax
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; StopChannel                                    109210  97 PC, low confidence
; Stops a sound channel
;-----------------------------------------------------------------------------
StopChannel:
        push ebx
        push edx
        mov edx, eax
        mov ah, byte [SoundSystemOn]
        xor ebx, ebx
        test ah, ah
        jne short .1
        mov eax, 0FFFFFFF6h
        pop edx
        pop ebx
        ret
.1:
        call AudioEnter
        mov eax, edx
        call IsChannelActive
        test eax, eax
        jl short .2
        call FadeOutChannel
        jmp short .3
.2:
        mov ebx, 0FFFFFFF8h
.3:
        call AudioLeaveCheck
        mov eax, ebx
        pop edx
        pop ebx
        ret
        db 00h,00h
;-----------------------------------------------------------------------------
; PlaySample                                     109250  97 PC, low confidence
; Plays a sample on a free channel
;-----------------------------------------------------------------------------
PlaySample:
        push ecx
        push esi
        mov esi, eax
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop esi
        pop ecx
        ret
.1:
        mov eax, esi
        call CheckBankIndex
        test eax, eax
        jge short .2
        mov eax, 0FFFFFFF8h
        pop esi
        pop ecx
        ret
.2:
        test edx, edx
        jl short .3
        cmp edx, 80h
        jl short .4
.3:
        mov eax, 0FFFFFFF8h
        pop esi
        pop ecx
        ret
.4:
        push byte 0FFFFFFFFh
        push ebx
        mov eax, dword [nosplit esi*8+SoundBankTable]
        push byte 0FFFFFFFFh
        mov ecx, 0FFFFFFFFh
        mov eax, dword [byte eax+edx*4+08h]
        push byte 0FFFFFFFFh
        mov ebx, ecx
        mov edx, esi
        call PlaySoundEntry
        pop esi
        pop ecx
        ret
        db 00h
;-----------------------------------------------------------------------------
; PlaySampleVolume                               1092B0  97 PC, low confidence
; Plays a sample at a volume
;-----------------------------------------------------------------------------
PlaySampleVolume:
        push esi
        mov esi, eax
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop esi
        ret
.1:
        mov eax, esi
        call CheckBankIndex
        test eax, eax
        jge short .2
        mov eax, 0FFFFFFF8h
        pop esi
        ret
.2:
        test edx, edx
        jl short .3
        cmp edx, 80h
        jl short .4
.3:
        mov eax, 0FFFFFFF8h
        pop esi
        ret
.4:
        push byte 0FFFFFFFFh
        push ecx
        mov eax, dword [nosplit esi*8+SoundBankTable]
        push ebx
        mov eax, dword [byte eax+edx*4+08h]
        mov ecx, 0FFFFFFFFh
        push byte 0FFFFFFFFh
        mov edx, esi
        mov ebx, ecx
        call PlaySoundEntry
        pop esi
        ret
;-----------------------------------------------------------------------------
; ClearSpeechRing                                109309  97 PC, low confidence
; Clears the speech ring
;-----------------------------------------------------------------------------
ClearSpeechRing:
        mov dword [SpeechRingHead], 0
        mov dword [SpeechRingTail], 0
        mov dword [SpeechRingBusy], 0
        xor eax, eax
.1:
        add eax, byte 0Ch
        mov dword [dword eax+SpeechSampleBufA], 0
        mov dword [dword eax+SpeechSampleBufB], 0
        mov dword [dword eax+SpeechRingTail], 0
        cmp eax, 120h
        jne short .1
        ret
;-----------------------------------------------------------------------------
; PushSpeechRing                                 109352  97 PC, low confidence
; Adds an entry to the speech ring
;-----------------------------------------------------------------------------
PushSpeechRing:
        push ebx
        push ecx
        mov ebx, eax
        mov ecx, edx
        mov edx, dword [SpeechRingHead]
        imul eax, edx, byte 0Ch
        mov dword [dword eax+SpeechRingUsed], ebx
        mov dword [dword eax+SpeechRingBytes], ebx
        inc edx
        mov dword [dword eax+SpeechRingEntries], ecx
        cmp edx, byte 18h
        jl short .1
        xor edx, edx
.1:
        mov dword [SpeechRingHead], edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SpeechRingCount                                109384  97 PC, low confidence
; Returns the entries in the speech ring
;-----------------------------------------------------------------------------
SpeechRingCount:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov edx, dword [SpeechRingHead]
        sub edx, dword [SpeechRingTail]
        test edx, edx
        jge short .1
        add edx, byte 18h
.1:
        xor eax, eax
        jmp short .5
.2:
        mov ebx, dword [SpeechRingTail]
        add ebx, eax
        cmp ebx, byte 18h
        jl short .3
        sub ebx, byte 18h
.3:
        imul ebx, byte 0Ch
        cmp ecx, dword [dword ebx+SpeechRingUsed]
        jne short .4
        mov eax, 1
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        inc eax
.5:
        cmp eax, edx
        jl short .2
        xor eax, eax
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SpeechBusy                                     1093CF  97 PC, low confidence
; Returns whether speech is playing
;-----------------------------------------------------------------------------
SpeechBusy:
        cmp dword [SpeechRingBusy], byte 0
        jle short .2
.1:
        mov eax, 1
        ret
.2:
        call SpeechStreamFlag
        test eax, eax
        jne short .1
        ret
