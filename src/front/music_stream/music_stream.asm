; Music and movie streams: the stream timer, stream audio and background audio.
bits 32
%include "hockey.inc"
section s_4A247 progbits alloc exec nowrite align=1
extern __CHK, AmbientVolume, AsyncFreeRequest, AsyncResetRequest, AsyncStreamStep, AudioOptions, BackgroundAudioOn, BackgroundAudioTick
extern CdStreamNextPacket, CdStreamQueue, CdStreamService, ChannelPlaying, CloseAudioStreamChannel, CrowdNoiseLevel, delstream, FeedAudioStream
extern FlushAudioStream, MakeDataPath, MusicBlock, MusicBlockCount, MusicBuffer, MusicFeedCount, MusicHandle, MusicLength
extern MusicNextTrack, MusicPaused, MusicReady, MusicRestart, MusicStartTime, MusicState, MusicStopRequest, MusicStreamPos
extern MusicTime, MusicTrack, MusicTrackTable, MusicVolumeLevel, MusicVolumeWord, OpenAudioStreamChannel, OpenStreamBuffer, PaQueueClip
extern PaQueueCount, PaQueueHead, PaQueuePrev, PaQueueTail, PaQueueTime, PlayMovie, PlayQueuedSpeech, ReleaseBankSample
extern ServiceSpeechQueue, ServiceSpeechStream, SetChannelVolumeChecked, SetMusicStreamVolume, SetSpeechVolume, SfxBankLoaded, SfxOptions, SoundCardType
extern SoundDriverId, SpeechQueueState, SpeechStreamBuf, SpeechStreamEnd, SpeechStreamFile, SpeechStreamLen, SpeechStreamRead, SpeechStreamTimer
extern StopChannel, StopSpeechQueue, StreamBufferFree, StreamTimerOn, tickcount, WaitMusicEnd, WaitTicks, ZeroMem
global StopStreamTimer, ResetStreamAudio, PlayScreenMovie, CloseMusicStream, PumpMusicStream, FeedMusicStreamJumpTable, FeedMusicStream, FeedMusicStream_34
global FeedMusicStream_4B, FeedMusicStream_105, FeedMusicStream_277, ServiceBackgroundAudio
        db 090h
;-----------------------------------------------------------------------------
; StopStreamTimer                                 4A248  97 PC, low confidence
; Stops the stream audio timer
;-----------------------------------------------------------------------------
StopStreamTimer:
        push dword 4
        call __CHK
        cmp dword [SoundDriverId], byte 1
        jl short .2
        call SpeechQueueState
        cmp eax, byte 3
        jne short .1
        mov eax, 1
        ret
.1:
        cmp word [StreamTimerOn], byte 0
        je short .2
        mov eax, 1
        ret
.2:
        xor eax, eax
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ResetStreamAudio                                4A280  97 PC, low confidence
; Stops the music stream and clears its state (before replays and
; intermissions)
;-----------------------------------------------------------------------------
ResetStreamAudio:
        push dword 20h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        cmp dword [SoundDriverId], byte 1
        jl near .15
        call SpeechQueueState
        cmp eax, byte 3
        jne short .1
        call StopSpeechQueue
.1:
        xor esi, esi
.2:
        mov dx, word [PaQueueClip]
        cmp dx, word [PaQueueCount]
        je near .7
        mov eax, dword [PaQueueTail]
        sar eax, 10h
        imul eax, byte 22h
        mov edx, dword [PaQueueHead]
        mov edx, dword [byte edx+eax+01Eh]
        mov eax, dword [SpeechStreamTimer]
        call ReleaseBankSample
        mov eax, dword [PaQueueTail]
        sar eax, 10h
        imul eax, byte 22h
        mov edx, dword [PaQueueHead]
        mov dword [byte edx+eax+01Eh], 0FFFFFFFFh
        mov eax, dword [PaQueueTail]
        sar eax, 10h
        imul eax, byte 22h
        mov edx, dword [PaQueueHead]
        mov ebx, dword [byte edx+eax+012h]
        mov eax, dword [byte edx+eax+016h]
        add ebx, eax
        mov dword [SpeechStreamLen], ebx
        mov eax, ebx
        cmp eax, dword [SpeechStreamRead]
        jne short .3
        mov eax, dword [SpeechStreamBuf]
        mov dword [SpeechStreamRead], eax
        jmp short .4
.3:
        cmp eax, dword [SpeechStreamEnd]
        jne short .5
        mov eax, dword [SpeechStreamBuf]
        mov dword [SpeechStreamEnd], esi
.4:
        mov dword [SpeechStreamLen], eax
.5:
        mov eax, dword [PaQueueTail]
        sar eax, 10h
        imul eax, byte 22h
        mov edx, dword [PaQueueHead]
        add edx, eax
        cmp esi, dword [byte edx+0Eh]
        jg short .6
        mov ebp, dword [byte edx+06h]
        cmp esi, ebp
        je short .6
        push ebp
        call AsyncFreeRequest
        mov eax, dword [PaQueueTail]
        sar eax, 10h
        imul eax, byte 22h
        mov edx, dword [PaQueueHead]
        add esp, byte 4
        mov dword [byte edx+eax+06h], esi
.6:
        mov edx, dword [PaQueueTail]
        sar edx, 10h
        inc edx
        mov ebx, 18h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov bx, word [StreamTimerOn]
        dec ebx
        mov word [PaQueueCount], dx
        mov word [StreamTimerOn], bx
        jmp near .2
.7:
        xor esi, esi
.8:
        mov cx, word [PaQueuePrev]
        cmp cx, word [PaQueueClip]
        je near .14
        mov eax, dword [PaQueueCount]
        sar eax, 10h
        imul edx, eax, byte 22h
        mov eax, dword [PaQueueHead]
        add eax, edx
        mov ebx, dword [byte eax+02h]
        cmp esi, ebx
        je short .9
        push ebx
        call AsyncResetRequest
        add esp, byte 4
        call AsyncStreamStep
.9:
        mov eax, dword [PaQueueCount]
        sar eax, 10h
        imul eax, byte 22h
        mov edx, dword [PaQueueHead]
        add edx, eax
        cmp esi, dword [byte edx+0Eh]
        jg short .10
        mov ebp, dword [byte edx+06h]
        cmp esi, ebp
        je short .10
        push ebp
        call AsyncResetRequest
        add esp, byte 4
        call AsyncStreamStep
.10:
        mov eax, dword [PaQueueCount]
        sar eax, 10h
        imul eax, byte 22h
        mov edx, dword [PaQueueHead]
        add edx, eax
        mov ebx, dword [byte edx+012h]
        cmp esi, ebx
        je short .13
        mov eax, dword [byte edx+016h]
        add ebx, eax
        mov ecx, dword [SpeechStreamRead]
        mov dword [SpeechStreamLen], ebx
        cmp ebx, ecx
        jne short .11
        mov eax, dword [SpeechStreamBuf]
        mov dword [SpeechStreamRead], eax
        jmp short .12
.11:
        cmp ebx, dword [SpeechStreamEnd]
        jne short .13
        mov eax, dword [SpeechStreamBuf]
        mov dword [SpeechStreamEnd], esi
.12:
        mov dword [SpeechStreamLen], eax
.13:
        mov edx, dword [PaQueueCount]
        sar edx, 10h
        inc edx
        mov ebx, 18h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov word [PaQueueClip], dx
        mov edx, dword [PaQueueTail]
        sar edx, 10h
        inc edx
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov bx, word [StreamTimerOn]
        dec ebx
        mov word [PaQueueCount], dx
        mov word [StreamTimerOn], bx
        jmp near .8
.14:
        push dword 330h
        mov edx, dword [PaQueueHead]
        push edx
        xor esi, esi
        call ZeroMem
        add esp, byte 8
        mov word [PaQueuePrev], si
        mov word [PaQueueClip], si
        mov word [PaQueueTime], si
        mov word [PaQueueCount], si
.15:
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PlayScreenMovie                                 4A4F4  97 PC, low confidence
; (id): waits for the music (WaitMusicEnd), makes the movie path and plays it
; (PlayMovie); from the stats, all-star and create player screens
;-----------------------------------------------------------------------------
PlayScreenMovie:
        push dword 64h
        call __CHK
        push ebx
        push ecx
        push esi
        sub esp, byte 50h
        mov ebx, eax
        mov ecx, edx
        call WaitMusicEnd
        mov dx, word [SfxBankLoaded]
        xor esi, esi
        test dx, dx
        je short .2
        test byte [SfxOptions], 2
        jne short .1
        test byte [AudioOptions], 2
        je short .2
.1:
        mov esi, 1
.2:
        mov eax, esp
        mov edx, ebx
        call MakeDataPath
        mov ebx, 25AEEh
        push esi
        lea eax, [byte esp+04h]
        mov edx, dword [MusicTime]
        call PlayMovie
        add esp, byte 50h
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CloseMusicStream                                4A558  97 PC, low confidence
; Closes the music stream and frees its buffers
;-----------------------------------------------------------------------------
CloseMusicStream:
        push dword 20h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edx, dword [MusicStreamPos]
        push edx
        xor ebx, ebx
        call delstream
        mov ecx, 0FFFFFFFFh
        mov edi, dword [MusicPaused]
        add esp, byte 4
        mov dword [MusicStreamPos], ebx
        mov dword [MusicBuffer], ebx
        mov dword [MusicVolumeLevel], ecx
        test edi, edi
        jne short .1
        mov eax, dword [MusicBlock]
        sar eax, 10h
        lea edx, [nosplit eax*4+00h]
        add edx, eax
        shl edx, 4
        xor ah, ah
        mov bx, word [MusicStopRequest]
        mov byte [dword edx+MusicTrackTable], ah
        mov edx, dword [MusicNextTrack]
        dec ebx
        sar edx, 10h
        mov word [MusicStopRequest], bx
        inc edx
        mov ebx, 4
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov word [MusicRestart], dx
.1:
        mov edx, dword [MusicBlock]
        sar edx, 10h
        inc edx
        mov ebx, 4
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov cx, word [MusicBlock]
        mov word [MusicBlockCount], dx
        cmp dx, cx
        jne short .2
        cmp dword [MusicPaused], byte 0
        je short .2
        mov ax, word [MusicRestart]
        mov word [MusicBlockCount], ax
.2:
        cmp dword [MusicStartTime], byte 0
        je near .8
        mov eax, dword [MusicRestart]
        mov edx, dword [MusicHandle]
        sar eax, 10h
        cmp eax, edx
        jne short .4
        cmp dword [MusicPaused], byte 0
        je short .3
        mov ax, word [MusicRestart]
        mov word [MusicBlockCount], ax
        jmp near .7
.3:
        mov ax, word [MusicBlock]
        xor esi, esi
        mov word [MusicBlockCount], ax
        mov word [MusicRestart], ax
        mov word [MusicStopRequest], si
        jmp short .7
.4:
        cmp edx, byte 0FFFFFFFFh
        je short .7
        mov ecx, 4
        mov ax, word [MusicRestart]
        mov ebx, dword [MusicBlock]
        mov di, word [MusicBlock]
        mov esi, dword [MusicHandle]
        mov word [MusicBlockCount], ax
        sar ebx, 10h
.5:
        mov edx, dword [MusicBlock]
        sar edx, 10h
        cmp edx, esi
        je short .6
        cmp di, word [MusicBlockCount]
        je short .6
        inc edx
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov word [MusicBlockCount], dx
        jmp short .5
.6:
        mov dx, word [MusicBlock]
        cmp dx, word [MusicBlockCount]
        jne short .7
        mov word [MusicBlockCount], bx
.7:
        xor edi, edi
        mov dword [MusicStartTime], edi
.8:
        xor ebp, ebp
        mov dword [MusicLength], ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PumpMusicStream                                 4A6F8  97 PC, low confidence
; Feeds the next packets of the music stream
;-----------------------------------------------------------------------------
PumpMusicStream:
        push dword 10h
        call __CHK
        push ecx
        push edx
        cmp dword [MusicStreamPos], byte 0
        je short .1
        call CdStreamService
        cmp dword [MusicBuffer], byte 0
        je short .1
        mov ecx, dword [MusicStreamPos]
        push ecx
        call CdStreamNextPacket
        add esp, byte 4
        test eax, eax
        je short .1
        cmp eax, byte 0FFFFFFFFh
        je short .1
        call FeedAudioStream
.1:
        pop edx
        pop ecx
        ret
        db 090h
FeedMusicStreamJumpTable:                       ; jump table for the switch cases of FeedMusicStream
        dd FeedMusicStream_34
        dd FeedMusicStream_4B
        dd FeedMusicStream_105
        dd FeedMusicStream_277
;-----------------------------------------------------------------------------
; FeedMusicStream                                 4A74C  97 PC, low confidence
; Opens, queues and feeds the music stream
;-----------------------------------------------------------------------------
FeedMusicStream:
        push dword 28h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp dword [MusicTime], byte 0
        je near FeedMusicStream_277.14
        mov eax, dword [MusicState]
        dec eax
        cmp eax, byte 3
        ja near FeedMusicStream_277.14
        jmp dword [nosplit cs:eax*4+FeedMusicStreamJumpTable]
FeedMusicStream_34:
        cmp word [MusicStopRequest], byte 0
        jne short FeedMusicStream_4B
        xor edx, edx
        mov dword [MusicFeedCount], edx
        jmp near FeedMusicStream_277.14
FeedMusicStream_4B:
        push dword 800h
        push dword 25B7Eh
        mov ecx, dword [MusicTime]
        push ecx
        call OpenStreamBuffer
        mov ebx, dword [MusicBlock]
        mov edx, eax
        sar ebx, 10h
        mov dword [MusicStreamPos], eax
        lea eax, [nosplit ebx*4+00h]
        add eax, ebx
        shl eax, 4
        add esp, byte 0Ch
        add eax, MusicTrackTable
        push eax
        push edx
        call CdStreamQueue
        add esp, byte 8
        test eax, eax
        jne short .3
        cmp word [SfxBankLoaded], byte 0
        je short .1
        xor edi, edi
        mov dword [MusicPaused], edi
.1:
        cmp word [SfxBankLoaded], byte 0
        je short .2
        mov eax, dword [MusicRestart]
        mov ebp, 1
        sar eax, 10h
        mov dword [MusicStartTime], ebp
        mov dword [MusicHandle], eax
.2:
        call CloseMusicStream
        mov dword [MusicState], 1
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        cmp dword [MusicFeedCount], byte 0
        je short .4
        mov dword [MusicTrack], 1
.4:
        mov eax, 1
        mov ebp, 3
        mov dword [MusicFeedCount], eax
        mov dword [MusicState], ebp
FeedMusicStream_105:
        cmp dword [MusicStreamPos], byte 0
        je short .5
        call CdStreamService
        cmp dword [MusicBuffer], byte 0
        je short .5
        mov ecx, dword [MusicStreamPos]
        push ecx
        call CdStreamNextPacket
        add esp, byte 4
        test eax, eax
        je short .5
        cmp eax, byte 0FFFFFFFFh
        je short .5
        call FeedAudioStream
.5:
        cmp dword [MusicTrack], byte 0
        je near FeedMusicStream_277.14
        mov edi, dword [MusicStreamPos]
        push edi
        call StreamBufferFree
        add esp, byte 4
        cmp eax, 1588h
        jl near FeedMusicStream_277.14
        push byte 0
        mov ecx, 25AEEh
        mov ebx, 0C8h
        mov edx, 3
        mov eax, dword [MusicStreamPos]
        call OpenAudioStreamChannel
        test eax, eax
        jg short .8
        cmp word [SfxBankLoaded], byte 0
        je short .6
        xor ebx, ebx
        mov dword [MusicPaused], ebx
.6:
        cmp word [SfxBankLoaded], byte 0
        je short .7
        mov eax, dword [MusicRestart]
        mov ecx, 1
        sar eax, 10h
        mov dword [MusicStartTime], ecx
        mov dword [MusicHandle], eax
.7:
        mov esi, 1
        call CloseMusicStream
        mov dword [MusicState], esi
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        mov ebp, 1
        mov eax, 0Fh
        mov dword [MusicBuffer], ebp
        call CloseAudioStreamChannel
        mov dword [MusicVolumeLevel], eax
        test eax, eax
        jge short .11
        cmp word [SfxBankLoaded], byte 0
        je short .9
        xor edi, edi
        mov dword [MusicPaused], edi
.9:
        cmp word [SfxBankLoaded], byte 0
        je short .10
        mov eax, dword [MusicRestart]
        mov ebp, 1
        sar eax, 10h
        mov dword [MusicStartTime], ebp
        mov dword [MusicHandle], eax
.10:
        call FlushAudioStream
        call CloseMusicStream
        xor eax, eax
        mov edx, 1
        mov dword [MusicFeedCount], eax
        mov dword [MusicState], edx
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        mov dword [MusicState], 4
        mov edx, dword [MusicVolumeWord]
        mov ecx, 0FFFFFFFFh
        sar edx, 10h
        xor ebx, ebx
        call SetMusicStreamVolume
        mov dword [MusicStartTime], ebx
        mov dword [MusicHandle], ecx
        mov dword [MusicLength], ebx
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
FeedMusicStream_277:
        xor ebx, ebx
        mov ecx, dword [MusicStreamPos]
        mov dword [MusicTrack], ebx
        test ecx, ecx
        je short .12
        call CdStreamService
        cmp dword [MusicBuffer], byte 0
        je short .12
        mov edi, dword [MusicStreamPos]
        push edi
        call CdStreamNextPacket
        add esp, byte 4
        test eax, eax
        je short .12
        cmp eax, byte 0FFFFFFFFh
        je short .12
        call FeedAudioStream
.12:
        mov eax, dword [MusicVolumeLevel]
        call ChannelPlaying
        test eax, eax
        je short .13
        mov eax, dword [MusicVolumeLevel]
        call StopChannel
        push byte 1
        call WaitTicks
        add esp, byte 4
        mov ebx, 1
        call FlushAudioStream
        call CloseMusicStream
        mov dword [MusicState], ebx
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.13:
        cmp dword [MusicLength], byte 0
        jne short .14
        cmp dword [MusicStartTime], byte 0
        je short .14
        mov ebx, 0FFFFFFFFh
        mov edx, 32h
        mov eax, dword [MusicVolumeLevel]
        call SetChannelVolumeChecked
        mov dword [MusicLength], 1
.14:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ServiceBackgroundAudio                          4AA78  97 PC, low confidence
; Services speech and music streaming while the game waits
;-----------------------------------------------------------------------------
ServiceBackgroundAudio:
        push dword 10h
        call __CHK
        push ebx
        push esi
        push edi
        cmp word [SfxBankLoaded], byte 0
        jne short .1
        xor eax, eax
        pop edi
        pop esi
        pop ebx
        ret
.1:
        cmp dword [BackgroundAudioOn], byte 0
        je short .2
        xor eax, eax
        pop edi
        pop esi
        pop ebx
        ret
.2:
        mov ebx, 1
        mov ecx, dword [SoundCardType]
        mov dword [BackgroundAudioOn], ebx
        test ecx, ecx
        je short .3
        call ServiceSpeechQueue
.3:
        cmp dword [SpeechStreamFile], byte 0
        je short .5
        cmp dword [SoundDriverId], byte 2
        jne short .4
        cmp dword [MusicFeedCount], byte 0
        jne short .5
.4:
        call ServiceSpeechStream
.5:
        mov eax, dword [tickcount]
        mov edx, dword [BackgroundAudioTick]
        inc edx
        cmp eax, edx
        jge short .6
        xor edx, edx
        xor eax, eax
        mov dword [BackgroundAudioOn], edx
        pop edi
        pop esi
        pop ebx
        ret
.6:
        mov dword [BackgroundAudioTick], eax
        cmp dword [SoundCardType], byte 0
        je short .7
        call PlayQueuedSpeech
.7:
        cmp dword [MusicReady], byte 0
        je short .10
        mov ebx, dword [AmbientVolume]
        mov eax, dword [CrowdNoiseLevel]
        cmp eax, ebx
        je short .10
        jge short .8
        lea edi, [byte eax+03h]
        mov dword [CrowdNoiseLevel], edi
        jmp short .9
.8:
        lea esi, [byte eax-03h]
        mov dword [CrowdNoiseLevel], esi
.9:
        mov eax, dword [CrowdNoiseLevel]
        call SetSpeechVolume
.10:
        cmp dword [SoundDriverId], byte 2
        je short .11
        mov bx, word [PaQueuePrev]
        cmp bx, word [PaQueueTime]
        jne short .12
.11:
        call FeedMusicStream
.12:
        xor eax, eax
        mov dword [BackgroundAudioOn], eax
        pop edi
        pop esi
        pop ebx
        ret
