; Sound: AddStreamSample, ReleaseBankSample, StartSpeechQueue, QueueSpeechClip, SpeechQueueGo and 6 more.
bits 32
%include "hockey.inc"
section s_10A8C2 progbits alloc exec nowrite align=1
extern AudioEnter, AudioLeaveCheck, ChannelPlaying, ChannelPosition, ChannelSampleTable, ChannelTimeLeftLocked, CheckBankIndex, IsChannelActive
extern LoadSampleHeader, PlaySample, SetMusicStreamVolume, SoundBankTable, SoundSystemOn, SpeechQueueActive, SpeechQueueBank, SpeechQueueChannel
extern SpeechQueueClip, SpeechQueueCount, SpeechQueueData, SpeechQueueFlags, SpeechQueueHandle, SpeechQueueHead, SpeechQueueLevel, SpeechQueueTail
extern SpeechQueueVolume, StopChannel
global AddStreamSample, ReleaseBankSample, StartSpeechQueue, QueueSpeechClip, SpeechQueueGo, StopSpeechQueue, SpeechQueueState, ShutdownSpeechQueue
global AdvanceSpeechQueue, ResetSpeechQueueState, SetChannelVolumeChecked
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AddStreamSample                                10A8C4  97 PC, low confidence
; Adds a streamed sample to a free entry of a bank and loads it into the
; sound driver
;-----------------------------------------------------------------------------
AddStreamSample:
        push esi
        push edi
        sub esp, byte 10h
        mov edi, edx
        mov esi, ebx
        mov dword [byte esp+0Ch], ecx
        lea ebx, [nosplit eax*8+00h]
        xor ecx, ecx
        xor eax, eax
.1:
        mov edx, dword [dword ebx+SoundBankTable]
        add edx, eax
        cmp dword [byte edx+08h], byte 0
        jne short .3
        mov eax, 0FFFFFFFFh
        mov ebx, esp
        mov dword [byte edx+08h], esi
        mov edx, dword [byte esp+0Ch]
        mov dword [esp], eax
        mov eax, esi
        call LoadSampleHeader
        test eax, eax
        jge short .2
        mov dword [edi], 0FFFFFFFFh
        jmp short .4
.2:
        mov eax, 8
        mov dword [edi], ecx
        jmp short .4
.3:
        add eax, byte 4
        inc ecx
        cmp eax, 200h
        jl short .1
        mov eax, 0FFFFFFF7h
.4:
        add esp, byte 10h
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ReleaseBankSample                              10A930  97 PC, low confidence
; Checks a bank and sample index and clears that sample entry
;-----------------------------------------------------------------------------
ReleaseBankSample:
        push ebx
        mov ebx, eax
        call CheckBankIndex
        test eax, eax
        je short .1
        mov eax, 0FFFFFFF8h
        pop ebx
        ret
.1:
        test edx, edx
        jl short .2
        cmp edx, 80h
        jle short .3
.2:
        mov eax, 0FFFFFFF8h
        pop ebx
        ret
.3:
        shl edx, 2
        mov eax, dword [nosplit ebx*8+SoundBankTable]
        add eax, edx
        cmp dword [byte eax+08h], byte 0
        jne short .4
        mov eax, 0FFFFFFF8h
        pop ebx
        ret
.4:
        mov dword [byte eax+08h], 0
        xor eax, eax
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; StartSpeechQueue                               10A980  97 PC, low confidence
; Resets the speech queue and sets its volume
;-----------------------------------------------------------------------------
StartSpeechQueue:
        push ebx
        push edx
        push edi
        push ebp
        mov edx, eax
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop ebp
        pop edi
        pop edx
        pop ebx
        ret
.1:
        xor ebx, ebx
        call AudioEnter
        mov dword [SpeechQueueCount], ebx
        mov dword [SpeechQueueHead], ebx
        mov dword [SpeechQueueTail], ebx
        call AudioLeaveCheck
        cmp edx, byte 7Fh
        jg short .2
        test edx, edx
        jge short .3
.2:
        mov eax, 0FFFFFFF8h
        pop ebp
        pop edi
        pop edx
        pop ebx
        ret
.3:
        mov edi, AdvanceSpeechQueue
        mov ebp, 1
        mov dword [SpeechQueueLevel], edx
        xor eax, eax
        mov dword [SpeechQueueVolume], edi
        mov dword [SpeechQueueActive], ebp
        pop ebp
        pop edi
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push edx
        cmp byte [SoundSystemOn], 0
        jne short .4
        mov eax, 0FFFFFFF6h
        pop edx
        pop ebx
        ret
.4:
        cmp eax, byte 7Fh
        jg short .5
        test eax, eax
        jge short .6
.5:
        mov eax, 0FFFFFFF8h
        pop edx
        pop ebx
        ret
.6:
        mov edx, dword [SpeechQueueActive]
        mov dword [SpeechQueueLevel], eax
        test edx, edx
        je short .7
        mov ebx, dword [SpeechQueueHandle]
        mov edx, eax
        mov eax, ebx
        call SetMusicStreamVolume
.7:
        xor eax, eax
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; QueueSpeechClip                                10AA38  97 PC, low confidence
; Adds a sample to the speech queue, or plays it at once when the queue is
; idle
;-----------------------------------------------------------------------------
QueueSpeechClip:
        push ecx
        push esi
        push edi
        sub esp, byte 8
        mov dword [esp], eax
        mov dword [byte esp+04h], edx
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        jmp near .5
.1:
        cmp dword [SpeechQueueActive], byte 0
        jne short .2
        mov eax, 0FFFFFFFFh
        add esp, byte 8
        pop edi
        pop esi
        pop ecx
        ret
.2:
        test ebx, ebx
        jge short .3
        mov eax, 0FFFFFFF8h
        add esp, byte 8
        pop edi
        pop esi
        pop ecx
        ret
.3:
        call AudioEnter
        mov edx, dword [SpeechQueueHead]
        lea eax, [byte edx+01h]
        mov dword [SpeechQueueHead], eax
        cmp eax, byte 14h
        jne short .4
        xor esi, esi
        mov dword [SpeechQueueHead], esi
.4:
        mov cl, byte [esp]
        mov word [nosplit edx*8+SpeechQueueClip], bx
        mov edi, 0FFFFFF9Ch
        mov byte [nosplit edx*8+SpeechQueueBank], cl
        mov dword [nosplit edx*8+SpeechQueueData], edi
        mov cl, byte [byte esp+04h]
        mov byte [nosplit edx*8+SpeechQueueFlags], cl
        call AudioLeaveCheck
        mov eax, edx
.5:
        add esp, byte 8
        pop edi
        pop esi
        pop ecx
        ret
        push edx
        shl eax, 3
        mov edx, dword [dword eax+SpeechQueueData]
        cmp edx, byte 0FFFFFF9Ch
        jne short .6
        mov eax, 8
        pop edx
        ret
.6:
        mov eax, edx
        call ChannelPlaying
        cmp eax, byte 1
        jne short .7
        mov eax, 7
        pop edx
        ret
.7:
        test eax, eax
        jne short .8
        mov eax, 3
        pop edx
        ret
.8:
        mov eax, 0FFFFFFFFh
        pop edx
        ret
        db 090h
        mov eax, dword [nosplit eax*8+SpeechQueueData]
        jmp near ChannelPosition
;-----------------------------------------------------------------------------
; SpeechQueueGo                                  10AB1C  97 PC, low confidence
; Marks the speech queue as running
;-----------------------------------------------------------------------------
SpeechQueueGo:
        push edx
        mov edx, 1
        xor eax, eax
        mov dword [SpeechQueueCount], edx
        pop edx
        ret
;-----------------------------------------------------------------------------
; StopSpeechQueue                                10AB2C  97 PC, low confidence
; Stops both speech channels and halts the queue
;-----------------------------------------------------------------------------
StopSpeechQueue:
        push ebx
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop ebx
        ret
.1:
        cmp dword [SpeechQueueActive], byte 0
        jne short .2
        mov eax, 0FFFFFFFFh
        pop ebx
        ret
.2:
        call AudioEnter
        xor ebx, ebx
        mov eax, dword [SpeechQueueChannel]
        mov dword [SpeechQueueCount], ebx
        call StopChannel
        mov eax, dword [SpeechQueueHandle]
        call StopChannel
        call AudioEnter
        mov dword [SpeechQueueCount], ebx
        mov dword [SpeechQueueHead], ebx
        mov dword [SpeechQueueTail], ebx
        call AudioLeaveCheck
        call AudioLeaveCheck
        xor eax, eax
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SpeechQueueState                               10AB94  97 PC, low confidence
; Returns 3 while the speech queue runs, 2 when idle, or an error
;-----------------------------------------------------------------------------
SpeechQueueState:
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        ret
.1:
        cmp dword [SpeechQueueActive], byte 0
        jne short .2
        mov eax, 0FFFFFFFFh
        ret
.2:
        cmp dword [SpeechQueueCount], byte 0
        je short .3
        mov eax, 3
        ret
.3:
        mov eax, 2
        ret
        db 090h
;-----------------------------------------------------------------------------
; ShutdownSpeechQueue                            10ABC8  97 PC, low confidence
; Stops the speech channels and clears the queue
;-----------------------------------------------------------------------------
ShutdownSpeechQueue:
        push ecx
        push esi
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop esi
        pop ecx
        ret
.1:
        cmp dword [SpeechQueueActive], byte 0
        jne short .2
        mov eax, 0FFFFFFFFh
        pop esi
        pop ecx
        ret
.2:
        call AudioEnter
        cmp byte [SoundSystemOn], 0
        je short .3
        cmp dword [SpeechQueueActive], byte 0
        je short .3
        call AudioEnter
        xor ecx, ecx
        mov eax, dword [SpeechQueueChannel]
        mov dword [SpeechQueueCount], ecx
        call StopChannel
        mov eax, dword [SpeechQueueHandle]
        call StopChannel
        call ResetSpeechQueueState
        call AudioLeaveCheck
.3:
        xor esi, esi
        mov dword [SpeechQueueVolume], esi
        call AudioLeaveCheck
        mov dword [SpeechQueueActive], esi
        xor eax, eax
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AdvanceSpeechQueue                             10AC48  97 PC, low confidence
; Starts the next queued speech clip when the current one is close to its end
;-----------------------------------------------------------------------------
AdvanceSpeechQueue:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        cmp dword [SpeechQueueCount], byte 0
        je near .3
        mov ecx, dword [SpeechQueueTail]
        lea edx, [nosplit ecx*8+00h]
        add edx, SpeechQueueBank
        mov ebx, dword [edx]
        mov eax, dword [SpeechQueueHandle]
        sar ebx, 10h
        call ChannelTimeLeftLocked
        cmp eax, ebx
        jg short .3
        mov ebx, dword [SpeechQueueHead]
        cmp ecx, ebx
        je short .2
        mov esi, dword [SpeechQueueTail]
        inc esi
        mov dword [SpeechQueueTail], esi
        cmp esi, byte 14h
        jne short .1
        xor ebp, ebp
        mov dword [SpeechQueueTail], ebp
.1:
        mov eax, dword [SpeechQueueHandle]
        mov ebx, dword [SpeechQueueLevel]
        mov dword [SpeechQueueChannel], eax
        xor eax, eax
        movzx esi, byte [byte edx+01h]
        mov al, byte [edx]
        mov edx, esi
        call PlaySample
        mov dword [SpeechQueueHandle], eax
        mov dword [nosplit ecx*8+SpeechQueueData], eax
        jmp short .3
.2:
        mov eax, dword [SpeechQueueHandle]
        call ChannelPlaying
        test eax, eax
        je short .3
        xor ecx, ebx
        mov dword [SpeechQueueCount], ecx
.3:
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ResetSpeechQueueState                          10ACF0  97 PC, low confidence
; Clears the speech queue state inside the audio critical section
;-----------------------------------------------------------------------------
ResetSpeechQueueState:
        push edx
        xor edx, edx
        call AudioEnter
        mov dword [SpeechQueueCount], edx
        mov dword [SpeechQueueHead], edx
        mov dword [SpeechQueueTail], edx
        call AudioLeaveCheck
        pop edx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; SetChannelVolumeChecked                        10AD20  97 PC, low confidence
; Checks a volume (-1..127) and sets it on an active channel inside the audio
; critical section
;-----------------------------------------------------------------------------
SetChannelVolumeChecked:
        push ecx
        push esi
        mov esi, eax
        mov ecx, edx
        mov edx, ebx
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop esi
        pop ecx
        ret
.1:
        cmp ebx, byte 7Fh
        jg short .2
        cmp ebx, byte 0FFFFFFFFh
        jge short .3
.2:
        mov eax, 0FFFFFFF8h
        pop esi
        pop ecx
        ret
.3:
        call AudioEnter
        mov eax, esi
        call IsChannelActive
        test eax, eax
        jge short .4
        call AudioLeaveCheck
        mov eax, 0FFFFFFF8h
        pop esi
        pop ecx
        ret
.4:
        mov ebx, eax
        shl eax, 4
        add eax, ebx
        mov ebx, ChannelSampleTable
        shl eax, 2
        add ebx, eax
        test ecx, ecx
        jg short .5
        mov ecx, 1
.5:
        shl edx, 10h
        mov dword [byte ebx+018h], edx
        mov eax, edx
        mov edx, dword [byte ebx+01Ch]
        sub eax, edx
        mov edx, eax
        shl eax, 2
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        idiv ecx
        mov dword [byte ebx+014h], eax
        call AudioLeaveCheck
        xor eax, eax
        pop esi
        pop ecx
        ret
