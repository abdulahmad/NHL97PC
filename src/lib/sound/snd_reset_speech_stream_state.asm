; Sound: ResetSpeechStreamState, FillSpeechSamples, FillSpeechBuffer, ServiceSpeechBuffers and 5 more.
bits 32
%include "hockey.inc"
section s_12CEE1 progbits alloc exec nowrite align=1
extern AudioEnter, AudioLeaveCheck, ChannelTimeLeft, CheckBankIndex, IsChannelActive, MixerSamplePosition, PlaySoundEntry, SoundBankTable
extern SoundSystemOn, SpeechRingBusy, SpeechRingBytes, SpeechRingEntries, SpeechRingHead, SpeechRingTail, SpeechRingUsed, SpeechSampleBufA
extern SpeechSampleBufB, SpeechStreamActive, SpeechStreamBlock, SpeechStreamBuffer, SpeechStreamChannel, SpeechStreamData, SpeechStreamFlagCount, SpeechStreamHandle
extern SpeechStreamHeader, SpeechStreamOpen, SpeechStreamPos, SpeechStreamSize, XaDecodeBlock
global ResetSpeechStreamState, FillSpeechSamples, FillSpeechBuffer, ServiceSpeechBuffers, SpeechStreamFlag, ServiceSpeechIfOpen, PlayBankSample, ChannelPosition
global ChannelTimeLeftLocked
;-----------------------------------------------------------------------------
; ResetSpeechStreamState                         12CEE1  97 PC, low confidence
; Clears the speech stream buffers and positions
;-----------------------------------------------------------------------------
ResetSpeechStreamState:
        mov dword [SpeechStreamHeader], 0
        mov dword [SpeechStreamBuffer], 0
        mov dword [SpeechStreamSize], 0
        mov dword [SpeechStreamChannel], 0
        mov dword [SpeechStreamData], 0
        mov dword [SpeechStreamActive], 0FFFFFFFFh
        mov dword [SpeechStreamHandle], 0
        mov dword [SpeechStreamPos], 0
        mov dword [SpeechStreamBlock], 0
        mov dword [SpeechStreamFlagCount], 0
        mov dword [SpeechStreamOpen], 0
        ret
;-----------------------------------------------------------------------------
; FillSpeechSamples                              12CF50  97 PC, low confidence
; Copies a run of speech samples into the output buffer
;-----------------------------------------------------------------------------
FillSpeechSamples:
        push ecx
        push esi
        push edi
        enter 8, 0
        mov edi, eax
        mov esi, edx
        mov eax, ebx
        cdq
        shl edx, 4
        LD sbb, eax, edx
        sar eax, 4
        mov dword [byte ebp-04h], 0
        mov dword [byte ebp-08h], eax
        jmp short .2
.1:
        push byte 1
        mov edx, SpeechSampleBufA
        mov eax, SpeechSampleBufB
        mov ecx, esi
        push byte 1
        mov ebx, edi
        inc dword [byte ebp-04h]
        call XaDecodeBlock
        add edi, byte 10h
        add esi, byte 70h
.2:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [byte ebp-08h]
        jl short .1
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; FillSpeechBuffer                               12CF9F  97 PC, low confidence
; Fills one speech output buffer from the stream
;-----------------------------------------------------------------------------
FillSpeechBuffer:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 8, 0
        imul eax, dword [SpeechStreamBlock], dword 8C0h
        mov ecx, dword [SpeechStreamBuffer]
        mov edi, 140h
        add ecx, eax
        mov dword [byte ebp-08h], 0
        mov dword [byte ebp-04h], ecx
.1:
        mov eax, dword [SpeechRingHead]
        cmp eax, dword [SpeechRingTail]
        je near .4
        test edi, edi
        jle near .4
        mov ecx, dword [SpeechRingTail]
        imul esi, ecx, byte 0Ch
        mov esi, dword [dword esi+SpeechRingEntries]
        mov dword [byte ebp-08h], 1
        cmp esi, edi
        jle short .2
        mov esi, edi
.2:
        imul ecx, byte 0Ch
        mov edx, dword [byte ebp-04h]
        mov ebx, esi
        mov eax, dword [dword ecx+SpeechRingBytes]
        call FillSpeechSamples
        mov eax, esi
        cdq
        shl edx, 4
        LD sbb, eax, edx
        sar eax, 4
        imul eax, byte 70h
        add dword [dword ecx+SpeechRingBytes], esi
        sub edi, esi
        sub dword [dword ecx+SpeechRingEntries], esi
        add dword [byte ebp-04h], eax
        cmp dword [dword ecx+SpeechRingEntries], byte 0
        jg short .1
        mov dword [SpeechSampleBufB], 0
        mov dword [SpeechSampleBufA], 0
        mov dword [dword ecx+SpeechRingEntries], 0
        mov dword [dword ecx+SpeechRingUsed], 0
        mov dword [dword ecx+SpeechRingBytes], 0
        inc dword [SpeechRingTail]
        cmp dword [SpeechRingTail], byte 18h
        jne short .3
        mov dword [SpeechRingTail], 0
.3:
        dec dword [SpeechRingBusy]
        cmp dword [SpeechRingBusy], byte 0
        jge near .1
        mov dword [SpeechRingBusy], 0
        jmp near .1
.4:
        test edi, edi
        jle short .7
        mov eax, edi
        cdq
        shl edx, 4
        LD sbb, eax, edx
        sar eax, 4
        imul ecx, eax, byte 70h
        xor esi, esi
        mov eax, dword [byte ebp-04h]
        jmp short .6
.5:
        inc esi
        mov byte [eax], 0
        inc eax
.6:
        cmp esi, ecx
        jl short .5
.7:
        mov eax, dword [byte ebp-08h]
        leave
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ServiceSpeechBuffers                           12D0D2  97 PC, low confidence
; Refills the speech buffers the channel has finished playing
;-----------------------------------------------------------------------------
ServiceSpeechBuffers:
        push ebx
        push edx
        mov eax, dword [SpeechStreamActive]
        call ChannelPosition
        add eax, eax
        mov ebx, 8C0h
        cdq
        idiv ebx
        sub eax, dword [SpeechStreamBlock]
        test eax, eax
        jge short .1
        add eax, byte 6
.1:
        cmp eax, byte 3
        jl short .4
        inc dword [SpeechStreamBlock]
        cmp dword [SpeechStreamBlock], byte 6
        jl short .2
        sub dword [SpeechStreamBlock], byte 6
.2:
        dec dword [SpeechStreamFlagCount]
        cmp dword [SpeechStreamFlagCount], byte 0
        jge short .3
        mov dword [SpeechStreamFlagCount], 0
.3:
        call FillSpeechBuffer
        test eax, eax
        je short .4
        inc dword [SpeechStreamFlagCount]
.4:
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SpeechStreamFlag                               12D13B  97 PC, low confidence
; Returns the speech stream state flag
;-----------------------------------------------------------------------------
SpeechStreamFlag:
        mov eax, dword [SpeechStreamFlagCount]
        ret
;-----------------------------------------------------------------------------
; ServiceSpeechIfOpen                            12D141  97 PC, low confidence
; Refills the speech buffers when the stream is open
;-----------------------------------------------------------------------------
ServiceSpeechIfOpen:
        cmp dword [SpeechStreamOpen], byte 0
        jne short ServiceSpeechBuffers
        ret
        db 00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; PlayBankSample                                 12D150  97 PC, low confidence
; Checks a bank index and plays one of its samples
;-----------------------------------------------------------------------------
PlayBankSample:
        push esi
        push edi
        push ebp
        mov esi, eax
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        jmp short .5
.1:
        mov eax, esi
        call CheckBankIndex
        test eax, eax
        jge short .2
        mov eax, 0FFFFFFF8h
        pop ebp
        pop edi
        pop esi
        ret 0Ch
.2:
        test edx, edx
        jl short .3
        cmp edx, 80h
        jl short .4
.3:
        mov eax, 0FFFFFFF8h
        pop ebp
        pop edi
        pop esi
        ret 0Ch
.4:
        mov edi, dword [byte esp+018h]
        push edi
        mov ebp, dword [byte esp+018h]
        push ebp
        mov eax, dword [byte esp+018h]
        push eax
        mov eax, dword [nosplit esi*8+SoundBankTable]
        push byte 0FFFFFFFFh
        mov eax, dword [byte eax+edx*4+08h]
        mov edx, esi
        call PlaySoundEntry
.5:
        pop ebp
        pop edi
        pop esi
        ret 0Ch
        db 00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; ChannelPosition                                12D1C0  97 PC, low confidence
; Returns how far a channel is into its sample, inside the audio critical
; section
;-----------------------------------------------------------------------------
ChannelPosition:
        push ecx
        push edx
        mov edx, eax
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop edx
        pop ecx
        ret
.1:
        call AudioEnter
        mov eax, edx
        call IsChannelActive
        test eax, eax
        jge short .2
        call AudioLeaveCheck
        mov eax, 0FFFFFFF8h
        pop edx
        pop ecx
        ret
.2:
        push eax
        call MixerSamplePosition
        add esp, byte 4
        mov edx, eax
        call AudioLeaveCheck
        mov eax, edx
        pop edx
        pop ecx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; ChannelTimeLeftLocked                          12D210  97 PC, low confidence
; Returns how long a channel has left, inside the audio critical section
;-----------------------------------------------------------------------------
ChannelTimeLeftLocked:
        push edx
        mov edx, eax
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop edx
        ret
.1:
        call AudioEnter
        mov eax, edx
        call IsChannelActive
        test eax, eax
        jge short .2
        call AudioLeaveCheck
        mov eax, 0FFFFFFF8h
        pop edx
        ret
.2:
        call ChannelTimeLeft
        mov edx, eax
        call AudioLeaveCheck
        mov eax, edx
        pop edx
        ret
