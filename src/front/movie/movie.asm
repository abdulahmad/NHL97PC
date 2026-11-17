; Movies: opening the stream, decoding and playing frames.
bits 32
%include "hockey.inc"
section s_7BBAC progbits alloc exec nowrite align=1
extern AllocMemBlock, AllocMemData, AudioStreamDone, BackBufferHeight, BackBufferWidth, bcopy, BlitFrameToScreen, BuildVideoGammaTable
extern CdStreamFreePacket, CdStreamNextPacket, CdStreamOpenSecondary, CdStreamService, CdStreamStart, ChannelPlaying, ClearScreen, CloseAudioStreamChannel
extern CloseVideoWindow, CreateBitmapDefault, DecodeTgvChunk, DecodeVideoChunk, DecodeVideoFrame, delstream, DrawDestBuffer, DrawDestOffset
extern DrawDestPitch, FeedAudioStream, FlushAudioStream, FreeBitmap, FreeMemBlock, InitVideoDecoder, KbdGetKey, LinkGameActive
extern MakeColor, MovieAudioDone, MovieAudioStream, MovieCdStream, MovieChunkData, MovieChunkSize, MovieChunkTag, MovieDropCount
extern MovieEndReached, MovieFileHandle, MovieFileOffset, MovieFlags, MovieFrameCount, MovieFrameIndex, MovieFramesAhead, MovieFrameShown
extern MovieHasAudio, MovieLastFrame, MovieNextFrame, MoviePageFlip, MoviePalette, MovieSkippable, MovieSkipped, MovieSoundChannel
extern MovieStartTick, MovieState, MovieStreamBuffer, MovieVideoBuffer, MovieVideoDone, MovieWidth, OpenAudioStreamChannel, OpenStreamBuffer
extern PresentScreen, ResetFrameRate, ServiceIdle, SetDrawTarget, SetScreenTarget, StartAudioStream, StopChannel, str_AUDSTRMHACK
extern str_VIDEO, StreamReady, tickcount, WaitTicks
global FadeMovieOut, MovieKeyPressed, OpenMovieStream, OpenVideoStream, CloseMovie, DecodeMovieFrame, PlayMovieFrames, PlayMovie
        db 00h,00h,00h,00h
;-----------------------------------------------------------------------------
; FadeMovieOut                                    7BBB0  97 PC, low confidence
; Fades out the movie
;-----------------------------------------------------------------------------
FadeMovieOut:
        mov eax, dword [MovieSoundChannel]
        call ChannelPlaying
        test eax, eax
        je near AudioStreamDone
        xor eax, eax
        ret
        db 08Dh,040h,00h
        push ecx
        push edx
        call StopChannel
        push byte 1
        call WaitTicks
        add esp, byte 4
        pop edx
        pop ecx
        ret
        push ecx
        push edx
        call SetScreenTarget
        push dword 60606h
        call MakeColor
        add esp, byte 4
        push eax
        call ClearScreen
        add esp, byte 4
        call PresentScreen
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
        push ecx
        push edx
        mov eax, dword [MovieWidth]
        add eax, eax
        push eax
        push BackBufferWidth
        call CloseVideoWindow
        mov eax, dword [BackBufferHeight]
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 8
        mov dword [BackBufferHeight], eax
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; MovieKeyPressed                                 7BC34  97 PC, low confidence
; Returns whether a key was pressed during a movie
;-----------------------------------------------------------------------------
MovieKeyPressed:
        push ecx
        push edx
        cmp dword [MovieSkipped], byte 0
        jne short .1
        cmp dword [MovieSkippable], byte 0
        je short .1
        call KbdGetKey
        cmp eax, byte 1Bh
        sete al
        and eax, 0FFh
        mov dword [MovieSkipped], eax
.1:
        mov eax, dword [MovieSkipped]
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; OpenMovieStream                                 7BC68  97 PC, low confidence
; Opens the movie stream
;-----------------------------------------------------------------------------
OpenMovieStream:
        push ebx
        push edx
        push esi
        cmp dword [MovieHasAudio], byte 0
        je short .2
        cmp dword [MovieState], byte 0
        je short .1
        cmp dword [MovieAudioDone], byte 0
        jne short .1
        call FadeMovieOut
        test eax, eax
        je short .1
        mov eax, dword [tickcount]
        mov dword [MovieFileOffset], eax
        call StartAudioStream
        mov dword [MovieFileHandle], eax
        pop esi
        pop edx
        pop ebx
        ret
.1:
        mov eax, dword [tickcount]
        mov esi, dword [MovieFileOffset]
        sub eax, esi
        mov edx, eax
        shl eax, 4
        sub eax, edx
        mov edx, eax
        mov ebx, 64h
        sar edx, 1Fh
        idiv ebx
        add eax, dword [MovieFileHandle]
        pop esi
        pop edx
        pop ebx
        ret
.2:
        mov eax, dword [tickcount]
        mov edx, eax
        shl eax, 4
        sub eax, edx
        mov edx, eax
        mov ebx, 64h
        sar edx, 1Fh
        idiv ebx
        pop esi
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; OpenVideoStream                                 7BCF0  97 PC, low confidence
; Opens the movie's "VIDEO" stream (CdStreamOpenSecondary, CdStreamStart)
;-----------------------------------------------------------------------------
OpenVideoStream:
        push ecx
        push esi
        push edi
        mov edi, eax
        mov esi, edx
        push dword 0FFh
        push byte 10h
        call InitVideoDecoder
        add esp, byte 8
        push byte 0
        push byte 10h
        push dword 0D0h
        push dword 260h
        call CreateBitmapDefault
        add esp, byte 10h
        push byte 0
        push dword 4E290h
        push str_VIDEO
        mov dword [MovieVideoBuffer], eax
        call AllocMemData
        add esp, byte 0Ch
        mov dword [MovieAudioStream], eax
        test eax, eax
        je near .2
        push dword 2000h
        push dword 4E290h
        push eax
        call OpenStreamBuffer
        add esp, byte 0Ch
        mov dword [MovieStreamBuffer], eax
        test eax, eax
        je near .2
        lea eax, [dword ebx+090h]
        push eax
        push dword 0FFFFh
        push dword 4353h
        push esi
        call CdStreamOpenSecondary
        add esp, byte 10h
        push edi
        mov edx, dword [MovieStreamBuffer]
        push edx
        mov dword [MovieCdStream], eax
        call CdStreamStart
        mov ecx, dword [MovieHasAudio]
        add esp, byte 8
        test ecx, ecx
        je short .1
        push byte 0
        mov edx, 0Fh
        mov eax, dword [MovieCdStream]
        mov ecx, ebx
        mov ebx, 64h
        call OpenAudioStreamChannel
.1:
        xor esi, esi
        mov dword [MovieDropCount], esi
        mov dword [MovieVideoDone], esi
        mov dword [MovieAudioDone], esi
        mov dword [MovieEndReached], esi
        mov dword [MovieFrameIndex], esi
        mov dword [MovieState], esi
        mov dword [MovieLastFrame], esi
        mov dword [MovieFrameCount], esi
        mov dword [MovieFlags], esi
        call OpenMovieStream
        mov dword [MovieStartTick], eax
        call ResetFrameRate
        mov eax, 1
.2:
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CloseMovie                                      7BE04  97 PC, low confidence
; Closes the movie
;-----------------------------------------------------------------------------
CloseMovie:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov edx, dword [MovieFrameCount]
        mov ecx, dword [MovieHasAudio]
        add edx, edx
        xor ebx, ebx
        mov dword [MovieFrameCount], edx
        test ecx, ecx
        je near .8
        cmp dword [MovieState], byte 0
        je near .8
        cmp dword [MovieAudioDone], byte 0
        je short .1
        call MovieKeyPressed
        test eax, eax
        je short .2
.1:
        mov eax, dword [MovieSoundChannel]
        call StopChannel
        push byte 1
        call WaitTicks
        add esp, byte 4
        push byte 2
        call WaitTicks
        add esp, byte 4
.2:
        mov eax, dword [tickcount]
        mov edx, eax
        cmp dword [MovieState], byte 1
        jne short .6
        xor ecx, ecx
.3:
        mov eax, dword [tickcount]
        sub eax, edx
        cmp eax, 640h
        setge al
        mov ebx, eax
        mov eax, dword [MovieSoundChannel]
        and ebx, 0FFh
        call ChannelPlaying
        test eax, eax
        je short .4
        mov eax, ecx
        jmp short .5
.4:
        call AudioStreamDone
.5:
        test eax, eax
        je short .6
        test ebx, ebx
        jne short .6
        call MovieKeyPressed
        test al, 1
        je short .3
.6:
        test ebx, ebx
        je short .7
        or byte [MovieFlags], 4
.7:
        mov eax, dword [MovieSoundChannel]
        call StopChannel
        push byte 1
        call WaitTicks
        add esp, byte 4
        push byte 2
        call WaitTicks
        add esp, byte 4
.8:
        cmp dword [MovieHasAudio], byte 0
        je short .9
        call FlushAudioStream
.9:
        push byte 5
        call WaitTicks
        add esp, byte 4
        push esi
        call delstream
        add esp, byte 4
        mov ebx, dword [MovieAudioStream]
        push ebx
        call delstream
        add esp, byte 4
        mov ecx, dword [MovieAudioStream]
        push ecx
        call FreeMemBlock
        add esp, byte 4
        mov edi, dword [MovieVideoBuffer]
        xor esi, esi
        push edi
        mov dword [MovieAudioStream], esi
        call FreeBitmap
        mov eax, dword [MovieWidth]
        add esp, byte 4
        shr eax, 1
        push eax
        push BackBufferWidth
        call CloseVideoWindow
        mov ebp, dword [BackBufferHeight]
        add ebp, ebp
        add esp, byte 8
        mov dword [BackBufferHeight], ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DecodeMovieFrame                                7BF64  97 PC, low confidence
; Decodes a movie frame
;-----------------------------------------------------------------------------
DecodeMovieFrame:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov edi, eax
        xor eax, eax
        mov al, byte [byte edi+0Ch]
        push eax
        call BuildVideoGammaTable
        add esp, byte 4
        mov edx, dword [MovieVideoBuffer]
        push edx
        xor ebx, ebx
        call SetDrawTarget
        add esp, byte 4
        add edi, byte 10h
        mov dword [esp], ebx
.1:
        mov ebp, dword [esp]
        xor esi, esi
.2:
        xor eax, eax
        mov al, byte [edi]
        inc edi
        mov dword [byte esp+04h], eax
        cmp eax, byte 0Ch
        jle short .3
        push dword 4C0h
        mov ebx, ebp
        mov eax, esi
        mov edx, dword [DrawDestOffset]
        mov eax, dword [edx+eax*4]
        mov edx, dword [DrawDestBuffer]
        add eax, dword [edx+ebx*4]
        add eax, dword [DrawDestPitch]
        push eax
        push edi
        call DecodeVideoFrame
        jmp short .4
.3:
        jne short .5
        push dword 4C0h
        mov ebx, ebp
        mov eax, esi
        mov edx, dword [DrawDestOffset]
        mov eax, dword [edx+eax*4]
        mov edx, dword [DrawDestBuffer]
        add eax, dword [edx+ebx*4]
        add eax, dword [DrawDestPitch]
        push eax
        push edi
        call DecodeVideoChunk
.4:
        add esp, byte 0Ch
.5:
        mov edx, dword [byte esp+04h]
        add esi, byte 20h
        add edi, edx
        cmp esi, 260h
        jne short .2
        mov ebx, dword [esp]
        add ebx, byte 10h
        mov dword [esp], ebx
        cmp ebx, 0D0h
        jne near .1
        mov eax, dword [MovieVideoBuffer]
        mov eax, dword [byte eax+02Ch]
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PlayMovieFrames                                 7C038  97 PC, low confidence
; Plays the movie frames
;-----------------------------------------------------------------------------
PlayMovieFrames:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        xor esi, esi
        mov ebp, 1
        xor edi, edi
.1:
        mov dword [MovieDropCount], edi
        mov eax, dword [tickcount]
        mov ebx, eax
.2:
        call CdStreamService
        mov edx, dword [MovieStreamBuffer]
        push edx
        call CdStreamNextPacket
        add esp, byte 4
        push eax
        mov ecx, dword [MovieStreamBuffer]
        push ecx
        mov dword [MovieChunkSize], eax
        call StreamReady
        add esp, byte 8
        test eax, eax
        je short .3
        mov dword [MovieEndReached], ebp
        jmp near .8
.3:
        cmp edi, dword [MovieChunkSize]
        je near .8
        mov eax, dword [tickcount]
        mov ecx, 4
        mov ebx, eax
        mov eax, dword [MovieChunkSize]
        mov eax, dword [byte ecx+eax-04h]
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov dword [MovieChunkTag], eax
        cmp eax, 54475666h
        jb short .4
        jbe short .6
        cmp eax, 5447566Bh
        je short .5
        jmp short .7
.4:
        cmp eax, 54475170h
        jne short .7
        mov eax, dword [MovieChunkSize]
        call DecodeMovieFrame
        mov dword [MovieDropCount], eax
        jmp short .7
.5:
        mov dword [MovieVideoDone], ebp
.6:
        mov edx, dword [MovieChunkSize]
        push edx
        mov ecx, dword [MovieChunkData]
        push ecx
        call DecodeTgvChunk
        mov dword [MovieDropCount], eax
        mov eax, dword [MovieVideoDone]
        add esp, byte 8
        cmp edi, eax
        je short .7
        push dword 300h
        mov eax, dword [MovieChunkData]
        push MoviePalette
        add eax, byte 44h
        push eax
        call bcopy
        add esp, byte 0Ch
.7:
        mov edx, dword [MovieChunkSize]
        push edx
        mov ecx, dword [MovieStreamBuffer]
        push ecx
        call CdStreamFreePacket
        add esp, byte 8
.8:
        mov eax, dword [tickcount]
        sub eax, ebx
        xor edx, edx
        cmp eax, 190h
        setge al
        mov dl, al
        cmp edi, dword [MovieHasAudio]
        je short .9
        cmp edi, dword [MovieState]
        je short .9
        cmp edi, dword [MovieAudioDone]
        jne short .9
        call AudioStreamDone
        cmp eax, byte 8
        jge short .9
        mov edx, ebp
.9:
        mov ecx, dword [MovieDropCount]
        cmp edi, ecx
        jne short .10
        test edx, edx
        jne short .10
        cmp ecx, dword [MovieEndReached]
        jne short .10
        call MovieKeyPressed
        test eax, eax
        je near .2
.10:
        test edx, edx
        je short .11
        mov ebx, dword [MovieFlags]
        mov edx, 0FFFFFFFFh
        or ebx, ebp
        mov dword [MovieEndReached], edx
        mov dword [MovieFlags], ebx
.11:
        mov eax, dword [MovieFrameIndex]
        mov dword [MovieFrameShown], eax
        add eax, byte 2
        mov dword [MovieNextFrame], eax
        mov eax, dword [tickcount]
        mov ebx, eax
.12:
        call CdStreamService
        call CdStreamService
        mov ecx, dword [MovieCdStream]
        push ecx
        call CdStreamNextPacket
        add esp, byte 4
        push eax
        mov dword [MovieChunkSize], eax
        mov eax, dword [MovieCdStream]
        push eax
        call StreamReady
        add esp, byte 8
        test eax, eax
        je short .13
        mov dword [MovieAudioDone], ebp
        jmp near .17
.13:
        cmp edi, dword [MovieChunkSize]
        jne short .14
        mov ecx, dword [MovieEndReached]
        cmp ebp, ecx
        jne near .17
        mov dword [MovieAudioDone], ecx
        jmp near .17
.14:
        mov eax, dword [tickcount]
        mov ecx, dword [MovieHasAudio]
        mov ebx, eax
        mov dword [MovieLastFrame], ebp
        cmp edi, ecx
        je short .15
        mov eax, dword [MovieChunkSize]
        call FeedAudioStream
        cmp edi, dword [MovieState]
        jne short .17
        call AudioStreamDone
        cmp eax, byte 0Fh
        jle short .17
        mov eax, 0Fh
        call CloseAudioStreamChannel
        mov dword [MovieSoundChannel], eax
        mov dword [MovieState], ebp
        jmp short .16
.15:
        mov eax, dword [MovieChunkSize]
        push eax
        mov edx, dword [MovieCdStream]
        push edx
        call CdStreamFreePacket
        mov ecx, dword [MovieState]
        add esp, byte 8
        cmp edi, ecx
        jne short .17
        mov dword [MovieState], 2
.16:
        call OpenMovieStream
        mov dword [MovieStartTick], eax
.17:
        call OpenMovieStream
        mov edx, dword [MovieStartTick]
        sub eax, edx
        mov dword [MovieFramesAhead], eax
        mov eax, dword [MovieState]
        cmp edi, eax
        jne short .18
        cmp eax, dword [MovieLastFrame]
        jne short .18
        cmp dword [MovieFramesAhead], byte 0Fh
        jle short .18
        mov dword [MovieState], 2
        call OpenMovieStream
        mov dword [MovieStartTick], eax
.18:
        mov eax, dword [tickcount]
        sub eax, ebx
        cmp eax, 190h
        setge al
        mov ecx, dword [MovieFrameShown]
        mov edx, eax
        mov eax, dword [MovieFramesAhead]
        and edx, 0FFh
        cmp eax, ecx
        jl short .19
        cmp edi, dword [MovieState]
        je short .19
        cmp ebp, dword [MovieEndReached]
        jne short .23
.19:
        mov ecx, dword [MovieFrameShown]
        cmp ecx, dword [MovieFramesAhead]
        jge short .20
        cmp edi, dword [MovieAudioDone]
        jne short .21
.20:
        mov eax, ebp
        jmp short .22
.21:
        mov eax, edi
.22:
        test eax, eax
        je short .23
        test edx, edx
        jne short .23
        call MovieKeyPressed
        test eax, eax
        je near .12
.23:
        test edx, edx
        je short .24
        mov ah, byte [MovieFlags]
        or ah, 2
        mov dword [MovieAudioDone], ebp
        mov byte [MovieFlags], ah
.24:
        cmp edi, dword [MovieDropCount]
        je short .25
        inc dword [MovieFrameIndex]
.25:
        cmp edi, dword [MovieEndReached]
        jne short .26
        inc esi
.26:
        mov edx, dword [MovieNextFrame]
        cmp edx, dword [MovieFramesAhead]
        jg short .30
        cmp esi, byte 0Ah
        jge short .30
        cmp edi, dword [MovieEndReached]
        je short .27
        cmp edi, dword [MovieAudioDone]
        jne short .28
.27:
        mov eax, ebp
        jmp short .29
.28:
        mov eax, edi
.29:
        test eax, eax
        je short .30
        call MovieKeyPressed
        test eax, eax
        je near .1
.30:
        mov eax, dword [MovieDropCount]
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        push edx
        mov ebx, eax
        call SetScreenTarget
        push byte 10h
        push byte 10h
        push ebx
        call BlitFrameToScreen
        add esp, byte 0Ch
        call PresentScreen
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PlayMovie                                       7C3EC  97 PC, low confidence
; Plays a movie file ("AUDSTRMHACK" audio, OpenVideoStream), from PlayScreenMovie
;-----------------------------------------------------------------------------
PlayMovie:
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebp, eax
        mov edi, edx
        mov esi, 1
        xor edx, edx
        mov dword [MovieSkippable], ecx
        mov dword [esp], edx
        mov dword [MoviePageFlip], edx
        mov dword [MovieSkipped], edx
        test edi, edi
        je short .1
        cmp dword [byte esp+014h], byte 0
        je short .1
        mov dword [MovieHasAudio], esi
        jmp short .2
.1:
        xor eax, eax
        mov dword [MovieHasAudio], eax
        test edi, edi
        jne short .2
        push eax
        lea eax, [dword ebx+090h]
        push eax
        mov edx, 1
        push str_AUDSTRMHACK
        mov dword [byte esp+0Ch], edx
        call AllocMemBlock
        add esp, byte 0Ch
        mov edi, eax
.2:
        call SetScreenTarget
        push dword 60606h
        call MakeColor
        add esp, byte 4
        push eax
        call ClearScreen
        add esp, byte 4
        call PresentScreen
        mov eax, dword [MovieWidth]
        add eax, eax
        push eax
        push BackBufferWidth
        call CloseVideoWindow
        mov eax, dword [BackBufferHeight]
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov dword [BackBufferHeight], eax
        mov eax, dword [LinkGameActive]
        add esp, byte 8
        test eax, eax
        je short .3
        call ServiceIdle
.3:
        cmp dword [MovieSkipped], byte 0
        jne short .4
        cmp dword [MovieSkippable], byte 0
        je short .4
        call KbdGetKey
        cmp eax, byte 1Bh
        sete al
        and eax, 0FFh
        mov dword [MovieSkipped], eax
.4:
        mov eax, dword [MovieSkipped]
        test eax, eax
        je short .5
        mov esi, 0FFFFFFFFh
.5:
        call KbdGetKey
        test eax, eax
        je short .6
        call ServiceIdle
        jmp short .5
.6:
        mov edx, edi
        mov eax, ebp
        call OpenVideoStream
        test eax, eax
        je near .12
        xor ebp, ebp
.7:
        call PlayMovieFrames
        mov ebx, eax
        test eax, eax
        je short .9
        call SetScreenTarget
        push byte 10h
        push byte 10h
        push ebx
        call BlitFrameToScreen
        add esp, byte 0Ch
        call PresentScreen
        xor byte [MoviePageFlip], 1
        mov eax, dword [MovieSkipped]
        cmp ebp, eax
        jne short .8
        cmp eax, dword [MovieSkippable]
        je short .8
        call KbdGetKey
        cmp eax, byte 1Bh
        sete al
        and eax, 0FFh
        mov dword [MovieSkipped], eax
.8:
        mov eax, dword [MovieSkipped]
        test eax, eax
        je short .10
        mov esi, 0FFFFFFFFh
        jmp short .10
.9:
        mov esi, ebp
.10:
        cmp ebp, dword [LinkGameActive]
        je short .11
        call ServiceIdle
.11:
        test esi, esi
        jg short .7
        mov eax, edi
        call CloseMovie
.12:
        cmp dword [MovieSkipped], byte 0
        jne short .13
        cmp dword [MovieSkippable], byte 0
        je short .13
        call KbdGetKey
        cmp eax, byte 1Bh
        sete al
        and eax, 0FFh
        mov dword [MovieSkipped], eax
.13:
        mov eax, dword [MovieSkipped]
        test al, 4
        je short .14
        xor esi, esi
.14:
        call SetScreenTarget
        push dword 60606h
        call MakeColor
        add esp, byte 4
        push eax
        call ClearScreen
        add esp, byte 4
        call PresentScreen
        cmp dword [esp], byte 0
        je short .15
        push edi
        call FreeMemBlock
        add esp, byte 4
.15:
        cmp dword [LinkGameActive], byte 0
        je short .16
        call ServiceIdle
.16:
        mov eax, esi
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        ret 4
