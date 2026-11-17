; CD streams: stream buffers, requests, packets and the music stream.
bits 32
%include "hockey.inc"
section s_3E6CE progbits alloc exec nowrite align=1
extern addtimer, AllocMemBlock, bcopy, CdCloseFile, CdOpenStream, CdRead, CdSeek, CdStreamBuf
extern CdStreamFilled, CdStreamSpeed, CdStreamUsed, DetectMscdex, DriveLetterIndex, FreeMemBlock, IsCdDrive, RemoveTimerCallback
extern str_CDSTREAM, str_SECCDSTREAM, str_STREAM, strcmp_, StreamBlockCount, StreamBlockSize, StreamHandle, StreamRate
extern StreamReadBuf, StreamSpeed, streamstate, StreamTimeout, strncpy_, TicksSinceLast
global InitStreamBuffer, OpenStreamBuffer, CdStreamOpen, setstreamspeed, delstream, CdStreamRequest, CdStreamStart, CdStreamQueue
global RequestStreamRead, UpdateMusicStream, CdStreamOpenSecondary, CdStreamServiceJumpTable, CdStreamService, CdStreamService_20, CdStreamService_5B, CdStreamService_D6
global CdStreamService_14C, CdStreamService_1A3, CdStreamService_1E3, CdStreamService_47A, CdStreamService_595, CdStreamService_74E, CdStreamService_81D, CdStreamService_956
global CdStreamService_AC2, CdStreamService_BB8, CdStreamSkipMarks, CdStreamContigData, CdStreamSpaceLeft, CdStreamNextPacket, CdStreamFreePacket, StreamBufferFree
global StreamReady, StreamQueueBlock, RingBufferSpace
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; InitStreamBuffer                                3E6D0  97 PC, low confidence
; Sets up a CD stream buffer and its timer
;-----------------------------------------------------------------------------
InitStreamBuffer:
        push ebx
        push esi
        push edi
        push ebp
        mov esi, dword [byte esp+014h]
        mov edi, dword [byte esp+01Ch]
        mov edx, dword [StreamBlockCount]
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        mov edx, eax
        shl eax, 5
        sub eax, edx
        mov dword [CdStreamBuf], esi
        add eax, byte 0Fh
        mov edx, dword [byte esp+018h]
        and eax, 0FFF0h
        sub edx, 90h
        mov dword [StreamHandle], esi
        sub edx, eax
        mov dword [byte esi+038h], edx
        mov ebx, esi
        mov ecx, dword [StreamBlockCount]
        lea edx, [dword esi+090h]
        mov ebp, dword [StreamHandle]
        mov eax, edx
        dec ecx
        mov dword [byte ebp+070h], edx
        xor edx, edx
        test ecx, ecx
        jle short .2
.1:
        lea ebp, [dword eax+09Bh]
        inc edx
        mov dword [dword eax+097h], ebp
        mov eax, ebp
        cmp edx, ecx
        jl short .1
.2:
        mov dword [dword eax+097h], 0
        mov edx, dword [StreamBlockCount]
        mov dword [byte ebx+024h], 0
        mov dword [byte ebx+018h], 0
        lea eax, [nosplit edx*4+00h]
        mov dword [byte ebx+06Ch], 0
        add eax, edx
        mov dword [byte ebx+074h], 0
        mov edx, eax
        shl eax, 5
        mov dword [byte ebx+01Ch], 7
        sub eax, edx
        mov dword [byte ebx+020h], 0
        lea edx, [byte eax+0Fh]
        mov dword [byte ebx+034h], 0
        and edx, 0FFF0h
        lea eax, [dword esi+090h]
        mov dword [byte ebx+02Ch], 0
        add eax, edx
        mov dword [ebx], eax
        mov eax, dword [byte esp+018h]
        mov dword [byte ebx+03Ch], edi
        add eax, esi
        mov dword [byte ebx+04h], eax
        mov eax, dword [byte esp+020h]
        mov dword [byte ebx+028h], eax
        mov eax, dword [ebx]
        mov dword [byte ebx+014h], eax
        mov dword [byte ebx+010h], eax
        mov dword [byte ebx+08h], eax
        mov dword [byte ebx+0Ch], eax
        mov eax, dword [byte ebx+074h]
        mov dword [byte ebx+078h], eax
        mov eax, dword [byte ebx+034h]
        mov dword [byte ebx+030h], eax
        mov edx, dword [StreamBlockSize]
        mov eax, edi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov dword [dword ebx+080h], 0
        push CdStreamService_BB8
        mov dword [dword ebx+084h], eax
        call addtimer
        add esp, byte 4
        mov eax, ebx
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; OpenStreamBuffer                                3E818  97 PC, low confidence
; Opens a CD stream buffer for reading
;-----------------------------------------------------------------------------
OpenStreamBuffer:
        push ebx
        push byte 0
        mov edx, dword [byte esp+014h]
        push edx
        mov ebx, dword [byte esp+014h]
        push ebx
        mov ecx, dword [byte esp+014h]
        push ecx
        call InitStreamBuffer
        add esp, byte 10h
        pop ebx
        ret
        push ebx
        push byte 1
        mov edx, dword [byte esp+014h]
        push edx
        mov ebx, dword [byte esp+014h]
        push ebx
        mov ecx, dword [byte esp+014h]
        push ecx
        call InitStreamBuffer
        add esp, byte 10h
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CdStreamOpen                                 3E850  96 PC, medium confidence
; Allocates a CDSTREAM buffer and CdStreamInit
;-----------------------------------------------------------------------------
CdStreamOpen:
        push ebx
        push esi
        push edi
        mov edx, dword [byte esp+018h]
        push edx
        mov edx, dword [StreamBlockCount]
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        mov edx, eax
        shl eax, 5
        sub eax, edx
        mov ebx, dword [byte esp+014h]
        add eax, byte 0Fh
        add ebx, 90h
        and eax, 0FFF0h
        add eax, ebx
        push eax
        push str_CDSTREAM
        call AllocMemBlock
        mov edx, dword [StreamBlockCount]
        mov ecx, eax
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        add esp, byte 0Ch
        mov edx, eax
        shl eax, 5
        mov esi, dword [byte esp+01Ch]
        sub eax, edx
        push esi
        add eax, byte 0Fh
        mov edi, dword [byte esp+018h]
        and eax, 0FFF0h
        push edi
        add eax, ebx
        push eax
        push ecx
        call InitStreamBuffer
        add esp, byte 10h
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push byte 0
        mov edx, dword [byte esp+014h]
        push edx
        mov ebx, dword [byte esp+014h]
        push ebx
        mov ecx, dword [byte esp+014h]
        push ecx
        call CdStreamOpen
        add esp, byte 10h
        pop ebx
        ret
        push ebx
        push byte 1
        mov edx, dword [byte esp+014h]
        push edx
        mov ebx, dword [byte esp+014h]
        push ebx
        mov ecx, dword [byte esp+014h]
        push ecx
        call CdStreamOpen
        add esp, byte 10h
        pop ebx
        ret
;-----------------------------------------------------------------------------
; setstreamspeed                               3E904  96 PC, medium confidence
; EA CD stream: measures the read speed of the stream files for the data
; stream rate; name from its debug message
;-----------------------------------------------------------------------------
setstreamspeed:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 24h
        mov edi, dword [byte esp+038h]
        mov esi, dword [byte esp+03Ch]
        mov edx, esi
        mov eax, edi
        call strcmp_
        mov ebx, eax
        mov ebp, eax
        mov eax, esp
        push eax
        lea eax, [byte esp+014h]
        push eax
        lea eax, [byte esp+010h]
        push eax
        lea eax, [byte esp+024h]
        push eax
        push edi
        call CdOpenStream
        add esp, byte 14h
        test ebx, ebx
        je short .1
        mov eax, esp
        push eax
        lea eax, [byte esp+010h]
        push eax
        lea eax, [byte esp+0Ch]
        push eax
        lea eax, [byte esp+020h]
        push eax
        push esi
        call CdOpenStream
        add esp, byte 14h
        jmp short .2
.1:
        mov eax, dword [byte esp+018h]
        mov dword [byte esp+014h], eax
        mov eax, dword [byte esp+08h]
        mov dword [byte esp+04h], eax
        mov eax, dword [byte esp+010h]
        mov dword [byte esp+0Ch], eax
.2:
        mov eax, dword [byte esp+010h]
        sub eax, 2000h
        and ax, 0E000h
        mov dword [byte esp+010h], eax
        cmp eax, 40000h
        jle short .3
        mov dword [byte esp+010h], 40000h
.3:
        push byte 0
        push dword 2000h
        push str_STREAM
        call AllocMemBlock
        add esp, byte 0Ch
        mov ecx, 2000h
        push ecx
        push eax
        mov esi, eax
        mov eax, dword [byte esp+020h]
        push eax
        mov dword [byte esp+02Ch], ecx
        call CdRead
        add esp, byte 0Ch
        call TicksSinceLast
        mov ebx, dword [byte esp+010h]
        test ebx, ebx
        jle short .5
.4:
        push dword 2000h
        push esi
        mov ecx, dword [byte esp+020h]
        push ecx
        sub ebx, 2000h
        call CdRead
        add esp, byte 0Ch
        test ebx, ebx
        jg short .4
.5:
        call TicksSinceLast
        mov ebx, eax
        mov eax, dword [byte esp+020h]
        push eax
        push esi
        mov edx, dword [byte esp+01Ch]
        push edx
        call CdRead
        add esp, byte 0Ch
        call TicksSinceLast
        mov ecx, dword [byte esp+018h]
        push ecx
        mov dword [byte esp+020h], eax
        call CdCloseFile
        add esp, byte 4
        test ebp, ebp
        je short .6
        mov ebp, dword [byte esp+014h]
        push ebp
        call CdCloseFile
        add esp, byte 4
.6:
        push esi
        call FreeMemBlock
        lea eax, [nosplit ebx*4+00h]
        lea edx, [ebx+eax]
        add edx, edx
        add esp, byte 4
        shl edx, 10h
        mov ecx, dword [byte esp+010h]
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov dword [StreamSpeed], eax
        cmp eax, byte 1
        jge short .7
        mov dword [StreamSpeed], 1
.7:
        mov eax, 3E80000h
        mov edx, eax
        mov esi, dword [StreamSpeed]
        sar edx, 1Fh
        idiv esi
        mov esi, dword [byte esp+010h]
        lea edx, [nosplit ebx*4+00h]
        mov dword [StreamRate], eax
        add edx, ebx
        mov eax, dword [byte esp+010h]
        add edx, edx
        sar esi, 2
        shl edx, 10h
        add esi, eax
        mov eax, edx
        sar edx, 1Fh
        idiv esi
        mov dword [StreamBlockSize], eax
        cmp eax, 0DAh
        jle short .8
        mov dword [StreamBlockSize], 0DAh
.8:
        cmp dword [StreamBlockSize], 0A3h
        jge short .9
        mov esi, 1
        mov dword [StreamBlockSize], esi
        mov dword [CdStreamSpeed], esi
.9:
        cmp dword [CdStreamSpeed], byte 0
        jne short .10
        push edi
        call DriveLetterIndex
        add esp, byte 4
        push eax
        call IsCdDrive
        add esp, byte 4
        test eax, eax
        je short .10
        call DetectMscdex
        test eax, eax
        jne short .10
        mov dword [StreamBlockSize], 1
.10:
        mov edx, dword [byte esp+01Ch]
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        add eax, eax
        mov dword [StreamTimeout], eax
        mov eax, dword [StreamRate]
        add esp, byte 24h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
        push ebx
        mov ebx, 12Ch
        mov edx, 0DAh
        mov dword [StreamTimeout], ebx
        mov dword [StreamBlockSize], edx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; delstream                                       3EB40  96 PC, low confidence
; Closes a CD stream: removes its timer callback and frees its buffer
;-----------------------------------------------------------------------------
delstream:
        push ebx
        mov ebx, dword [byte esp+08h]
        cmp ebx, dword [StreamHandle]
        jne short .1
        push CdStreamService_BB8
        call RemoveTimerCallback
        mov ecx, dword [byte ebx+018h]
        add esp, byte 4
        test ecx, ecx
        je short .1
        push ecx
        call CdCloseFile
        add esp, byte 4
.1:
        pop ebx
        ret
        push ebx
        push esi
        push edi
        mov esi, dword [byte esp+010h]
        mov edx, dword [StreamHandle]
        cmp esi, edx
        jne short .4
        cmp edx, edx
        jne short .2
        push CdStreamService_BB8
        call RemoveTimerCallback
        mov edi, dword [byte esi+018h]
        add esp, byte 4
        test edi, edi
        je short .2
        push edi
        call CdCloseFile
        add esp, byte 4
.2:
        mov ebx, esi
.3:
        push esi
        mov ebx, dword [byte ebx+06Ch]
        call FreeMemBlock
        add esp, byte 4
        mov esi, ebx
        test ebx, ebx
        jne short .3
        pop edi
        pop esi
        pop ebx
        ret
.4:
        mov ebx, dword [byte edx+06Ch]
        mov eax, edx
        test ebx, ebx
        je short .6
.5:
        cmp esi, dword [byte eax+06Ch]
        je short .6
        mov eax, dword [byte eax+06Ch]
        cmp dword [byte eax+06Ch], byte 0
        jne short .5
.6:
        mov ebx, dword [byte esi+06Ch]
        push esi
        mov dword [byte eax+06Ch], ebx
        call FreeMemBlock
        add esp, byte 4
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CdStreamRequest                                 3EBE0  97 PC, low confidence
; The common body of the stream start / queue calls: copies the file name
; (8Fh) and sets the request flags
;-----------------------------------------------------------------------------
CdStreamRequest:
        push ebx
        push esi
        mov esi, dword [byte esp+0Ch]
        mov edx, dword [byte esp+020h]
        push edx
        call StreamQueueBlock
        mov ecx, eax
        add esp, byte 4
        test eax, eax
        je short .4
        mov ebx, 8Fh
        mov edx, dword [byte esp+010h]
        call strncpy_
        mov eax, dword [byte esp+014h]
        mov byte [dword ecx+08Eh], 0
        mov dword [dword ecx+093h], eax
        mov eax, dword [byte esp+018h]
        mov dword [dword ecx+08Fh], eax
        mov ebx, dword [byte esi+078h]
        test ebx, ebx
        je short .1
        mov dword [dword ebx+097h], ecx
        mov dword [byte esi+078h], ecx
        jmp short .2
.1:
        mov eax, ecx
        mov dword [byte esi+078h], ecx
        mov dword [byte esi+074h], eax
.2:
        cmp dword [byte esp+01Ch], byte 0
        je short .3
        cmp dword [byte esi+020h], byte 0
        jne short .3
        mov dword [byte esi+020h], 0Fh
.3:
        mov eax, 1
.4:
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CdStreamStart                                   3EC58  96 PC, low confidence
; CdStreamRequest with flags (1, 0, 1, 1)
;-----------------------------------------------------------------------------
CdStreamStart:
        push ebx
        push byte 1
        push byte 1
        push byte 0
        push byte 1
        mov edx, dword [byte esp+01Ch]
        push edx
        mov ebx, dword [byte esp+01Ch]
        push ebx
        call CdStreamRequest
        add esp, byte 18h
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CdStreamQueue                                   3EC78  96 PC, low confidence
; CdStreamRequest with flags (1, 0, 1, 0)
;-----------------------------------------------------------------------------
CdStreamQueue:
        push ebx
        push byte 0
        push byte 1
        push byte 0
        push byte 1
        mov edx, dword [byte esp+01Ch]
        push edx
        mov ebx, dword [byte esp+01Ch]
        push ebx
        call CdStreamRequest
        add esp, byte 18h
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push byte 1
        push byte 0
        push byte 0
        push byte 11h
        mov edx, dword [byte esp+01Ch]
        push edx
        mov ebx, dword [byte esp+01Ch]
        push ebx
        call CdStreamRequest
        add esp, byte 18h
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push byte 0
        push byte 0
        push byte 0
        push byte 11h
        mov edx, dword [byte esp+01Ch]
        push edx
        mov ebx, dword [byte esp+01Ch]
        push ebx
        call CdStreamRequest
        add esp, byte 18h
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push esi
        mov esi, dword [byte esp+0Ch]
        cmp dword [byte esi+074h], byte 0
        je short .2
.1:
        mov edx, dword [StreamHandle]
        mov eax, dword [byte esi+074h]
        mov edx, dword [byte edx+070h]
        mov dword [dword eax+097h], edx
        mov edx, dword [StreamHandle]
        mov dword [byte edx+070h], eax
        mov eax, dword [byte esi+074h]
        mov eax, dword [dword eax+097h]
        mov dword [byte esi+074h], eax
        test eax, eax
        jne short .1
.2:
        push byte 1
        call StreamQueueBlock
        add esp, byte 4
        mov ebx, 8Fh
        mov edx, dword [byte esp+010h]
        mov ecx, eax
        call strncpy_
        mov byte [dword ecx+08Eh], 0
        mov dword [dword ecx+093h], 0Dh
        mov dword [dword ecx+08Fh], 0
        mov dword [byte esi+078h], ecx
        mov eax, ecx
        mov ecx, dword [byte esi+020h]
        mov dword [byte esi+074h], eax
        test ecx, ecx
        jne short .3
        mov dword [byte esi+020h], 0Fh
.3:
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RequestStreamRead                               3ED60  97 PC, low confidence
; Asks the CD stream for the next block
;-----------------------------------------------------------------------------
RequestStreamRead:
        push ebx
        push byte 1
        push byte 1
        mov edx, dword [byte esp+014h]
        push edx
        push byte 2
        push StreamReadBuf
        mov ebx, dword [byte esp+01Ch]
        push ebx
        call CdStreamRequest
        add esp, byte 18h
        pop ebx
        ret
        push ebx
        push byte 0
        push byte 1
        mov edx, dword [byte esp+014h]
        push edx
        push byte 2
        push StreamReadBuf
        mov ebx, dword [byte esp+01Ch]
        push ebx
        call CdStreamRequest
        add esp, byte 18h
        pop ebx
        ret
        push ebx
        push byte 1
        push byte 0
        mov edx, dword [byte esp+014h]
        push edx
        push byte 10h
        push StreamReadBuf
        mov ebx, dword [byte esp+01Ch]
        push ebx
        call CdStreamRequest
        add esp, byte 18h
        pop ebx
        ret
        push ebx
        push byte 0
        push byte 0
        mov edx, dword [byte esp+014h]
        push edx
        push byte 10h
        push StreamReadBuf
        mov ebx, dword [byte esp+01Ch]
        push ebx
        call CdStreamRequest
        add esp, byte 18h
        pop ebx
        ret
        push ebx
        push esi
        mov ebx, dword [byte esp+0Ch]
        cmp dword [byte ebx+074h], byte 0
        je short .2
.1:
        mov edx, dword [StreamHandle]
        mov eax, dword [byte ebx+074h]
        mov edx, dword [byte edx+070h]
        mov dword [dword eax+097h], edx
        mov edx, dword [StreamHandle]
        mov dword [byte edx+070h], eax
        mov eax, dword [byte ebx+074h]
        mov eax, dword [dword eax+097h]
        mov dword [byte ebx+074h], eax
        test eax, eax
        jne short .1
.2:
        push byte 1
        call StreamQueueBlock
        add esp, byte 4
        mov dword [dword eax+093h], 0Bh
        mov edx, dword [byte esp+010h]
        mov dword [dword eax+08Fh], edx
        mov dword [byte ebx+078h], eax
        mov esi, dword [byte ebx+020h]
        mov dword [byte ebx+074h], eax
        test esi, esi
        jne short .3
        mov dword [byte ebx+020h], 0Fh
.3:
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; UpdateMusicStream                               3EE4C  97 PC, low confidence
; Feeds the music stream position to the sound driver
;-----------------------------------------------------------------------------
UpdateMusicStream:
        push ebx
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+058h]
        push edx
        mov ebx, dword [byte eax+018h]
        push ebx
        call CdSeek
        add esp, byte 8
        mov edx, dword [byte esp+08h]
        mov eax, dword [StreamTimeout]
        mov dword [dword edx+080h], eax
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CdStreamOpenSecondary                        3EE74  96 PC, medium confidence
; Allocates a SECCDSTREAM buffer and CdStreamInitSecondary
;-----------------------------------------------------------------------------
CdStreamOpenSecondary:
        push ebx
        mov eax, dword [byte esp+08h]
        mov ebx, dword [byte esp+014h]
        mov dword [byte eax+024h], 0
        mov dword [byte eax+03Ch], 0
        mov dword [byte eax+058h], 0
        lea ecx, [dword ebx-090h]
        mov dword [byte eax+050h], 1
        mov edx, eax
        mov dword [byte eax+038h], ecx
        lea ecx, [dword eax+090h]
        mov dword [eax], ecx
        lea ecx, [eax+ebx]
        mov ebx, dword [eax]
        mov dword [byte eax+04h], ecx
        mov dword [byte eax+014h], ebx
        mov dword [byte eax+010h], ebx
        mov dword [byte eax+08h], ebx
        mov dword [byte eax+0Ch], ebx
        mov ebx, dword [byte esp+010h]
        mov dword [byte eax+068h], ebx
        mov ebx, dword [byte esp+0Ch]
        mov dword [byte eax+064h], ebx
        mov eax, dword [StreamHandle]
        cmp dword [byte eax+06Ch], byte 0
        je short .2
.1:
        mov eax, dword [byte eax+06Ch]
        cmp dword [byte eax+06Ch], byte 0
        jne short .1
.2:
        mov dword [byte eax+06Ch], edx
        mov eax, edx
        mov dword [byte edx+06Ch], 0
        pop ebx
        ret
        push ebx
        mov edx, dword [byte esp+014h]
        mov ebx, dword [byte esp+010h]
        push edx
        add ebx, 90h
        push ebx
        push str_SECCDSTREAM
        call AllocMemBlock
        add esp, byte 0Ch
        push ebx
        mov ebx, dword [byte esp+010h]
        push ebx
        mov ecx, dword [byte esp+010h]
        push ecx
        push eax
        call CdStreamOpenSecondary
        add esp, byte 10h
        pop ebx
        ret
CdStreamServiceJumpTable:                       ; jump table for the switch cases of CdStreamService
        dd CdStreamService_D6
        dd CdStreamService_1E3
        dd CdStreamService_47A
        dd CdStreamService_595
        dd CdStreamService_74E
        dd CdStreamService_81D
        dd CdStreamService_5B
        dd CdStreamService_20
        dd CdStreamService_AC2
        dd CdStreamService_956
        dd CdStreamService_1A3
        dd CdStreamService_20
        dd CdStreamService_14C
        dd CdStreamService_20
        dd CdStreamService_20
        dd CdStreamService_1E3
        dd CdStreamService_D6
;-----------------------------------------------------------------------------
; CdStreamService                              3EF68  96 PC, medium confidence
; The current CD stream's state machine (open, read, refill, wrap, next
; file), driven by its read budget
;-----------------------------------------------------------------------------
CdStreamService:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov eax, dword [StreamHandle]
        cmp dword [dword eax+080h], byte 0
        jg near CdStreamService_AC2.58
        mov ebp, 8
        xor edi, edi
CdStreamService_20:
        mov eax, dword [StreamHandle]
        mov ebx, dword [byte eax+020h]
        cmp ebp, ebx
        jne short .1
        mov dword [byte eax+01Ch], ebx
        jmp short .2
.1:
        cmp ebx, byte 0Fh
        jne short .2
        mov dword [byte eax+01Ch], 7
.2:
        mov eax, dword [StreamHandle]
        mov dword [byte eax+020h], edi
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+01Ch]
        dec edx
        cmp edx, byte 10h
        ja short CdStreamService_20
        jmp dword [nosplit cs:edx*4+CdStreamServiceJumpTable]
CdStreamService_5B:
        mov ecx, dword [byte eax+074h]
        cmp edi, ecx
        je short .4
        mov ebx, dword [dword ecx+093h]
        mov dword [byte eax+01Ch], ebx
        mov eax, dword [StreamHandle]
        mov ebx, dword [byte eax+074h]
        mov ebx, dword [dword ebx+097h]
        mov dword [byte eax+074h], ebx
        mov eax, dword [StreamHandle]
        mov dword [byte eax+07Ch], ecx
        mov eax, dword [StreamHandle]
        mov esi, dword [byte eax+074h]
        mov edx, ecx
        cmp edi, esi
        jne short .3
        mov dword [byte eax+078h], esi
.3:
        mov ebx, dword [StreamHandle]
        mov ecx, dword [dword edx+08Fh]
        mov eax, dword [byte ebx+04Ch]
        add eax, ecx
        mov dword [byte ebx+05Ch], eax
        mov eax, dword [StreamHandle]
        mov eax, dword [byte eax+070h]
        mov dword [dword edx+097h], eax
        mov eax, dword [StreamHandle]
        mov dword [byte eax+070h], edx
        jmp near CdStreamService_20
.4:
        mov dword [dword eax+080h], 0
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
CdStreamService_D6:
        mov eax, dword [StreamHandle]
        mov esi, dword [byte eax+018h]
        cmp edi, esi
        je short .5
        push esi
        call CdCloseFile
        add esp, byte 4
.5:
        mov eax, esp
        push eax
        mov eax, dword [StreamHandle]
        lea edx, [byte eax+054h]
        push edx
        lea edx, [byte eax+04Ch]
        push edx
        lea edx, [byte eax+018h]
        push edx
        mov ebx, dword [byte eax+07Ch]
        push ebx
        call CdOpenStream
        mov edx, dword [StreamHandle]
        mov eax, dword [byte edx+04Ch]
        mov ecx, dword [byte edx+054h]
        add eax, ecx
        mov dword [byte edx+050h], eax
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+04Ch]
        mov dword [byte eax+05Ch], edx
        mov eax, dword [StreamHandle]
        mov esi, dword [byte eax+01Ch]
        add esp, byte 14h
        cmp esi, byte 1
        jne short .6
        mov dword [byte eax+01Ch], 2
        jmp near CdStreamService_20
.6:
        mov dword [byte eax+01Ch], 10h
        jmp near CdStreamService_20
CdStreamService_14C:
        mov esi, dword [byte eax+018h]
        test esi, esi
        je short .7
        push esi
        call CdCloseFile
        add esp, byte 4
.7:
        mov eax, esp
        push eax
        mov eax, dword [StreamHandle]
        lea edx, [byte eax+054h]
        push edx
        lea edx, [byte eax+04Ch]
        push edx
        lea edx, [byte eax+018h]
        push edx
        mov ebp, dword [byte eax+07Ch]
        push ebp
        call CdOpenStream
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+04Ch]
        mov ebx, dword [byte eax+054h]
        add edx, ebx
        mov dword [byte eax+050h], edx
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+04Ch]
        mov dword [byte eax+05Ch], edx
        mov eax, dword [StreamHandle]
        add esp, byte 14h
        mov dword [byte eax+01Ch], 2
CdStreamService_1A3:
        mov eax, dword [StreamHandle]
        mov dword [CdStreamBuf], eax
.8:
        mov eax, dword [CdStreamBuf]
        mov edx, dword [eax]
        mov dword [byte eax+014h], edx
        mov eax, dword [CdStreamBuf]
        mov dword [byte eax+010h], edx
        mov eax, dword [CdStreamBuf]
        mov dword [byte eax+08h], edx
        mov eax, edx
        mov edx, dword [CdStreamBuf]
        mov dword [byte edx+0Ch], eax
        mov eax, dword [CdStreamBuf]
        mov eax, dword [byte eax+06Ch]
        mov dword [CdStreamBuf], eax
        test eax, eax
        jne short .8
CdStreamService_1E3:
        mov eax, dword [StreamHandle]
        cmp dword [byte eax+01Ch], byte 2
        jne short .9
        mov edx, dword [byte eax+010h]
        mov dword [byte eax+0Ch], edx
        mov eax, edx
        mov edx, dword [StreamHandle]
        mov dword [byte edx+08h], eax
        jmp short .10
.9:
        mov edx, dword [byte eax+0Ch]
        mov dword [byte eax+08h], edx
.10:
        mov edx, dword [StreamHandle]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+04h]
        mov ebx, dword [byte edx+08h]
        mov edx, dword [StreamHandle]
        sub eax, ebx
        cmp eax, dword [byte edx+03Ch]
        jg short .13
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+04h]
        mov esi, dword [byte edx+08h]
        mov edx, eax
        mov eax, dword [StreamHandle]
        sub edx, esi
        call CdStreamContigData
        cmp edx, eax
        jne near CdStreamService_AC2.58
        mov edx, dword [StreamHandle]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+014h]
        cmp eax, dword [byte edx+08h]
        ja short .11
        mov ebp, dword [edx]
        mov edx, eax
        sub edx, ebp
        jmp short .12
.11:
        xor edx, edx
.12:
        mov eax, dword [StreamHandle]
        cmp edx, dword [byte eax+03Ch]
        jle near CdStreamService_AC2.58
        mov eax, dword [byte eax+0Ch]
        mov dword [eax], 0FFFFFFFFh
        mov eax, dword [StreamHandle]
        mov edx, dword [eax]
        mov dword [byte eax+0Ch], edx
        mov eax, edx
        mov edx, dword [StreamHandle]
        mov dword [byte edx+08h], eax
.13:
        mov edx, dword [StreamHandle]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+014h]
        mov ecx, dword [byte edx+08h]
        mov ebx, edx
        cmp eax, ecx
        jae short .14
        mov eax, dword [byte edx+04h]
        sub eax, ecx
        jmp short .16
.14:
        jne short .15
        mov edi, dword [byte edx+010h]
        cmp edi, dword [byte edx+014h]
        jne short .15
        mov eax, dword [byte edx+04h]
        sub eax, ecx
        jmp short .16
.15:
        mov ebp, dword [byte ebx+08h]
        mov eax, dword [byte ebx+014h]
        sub eax, ebp
.16:
        mov edx, dword [StreamHandle]
        cmp eax, dword [byte edx+03Ch]
        jle near CdStreamService_AC2.58
        mov dword [byte edx+01Ch], 3
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+0Ch]
        mov dword [byte eax+08h], edx
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+05Ch]
        mov dword [byte eax+058h], edx
        mov eax, dword [StreamHandle]
        mov edi, dword [byte eax+058h]
        push edi
        mov ebp, dword [byte eax+018h]
        push ebp
        call CdSeek
        mov edx, dword [StreamHandle]
        mov dword [byte edx+060h], eax
        mov eax, dword [StreamHandle]
        mov dword [byte eax+048h], 0
        mov eax, dword [StreamHandle]
        mov edx, dword [StreamTimeout]
        add esp, byte 8
        mov dword [dword eax+080h], edx
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.17:
        mov edx, edi
.18:
        mov eax, dword [StreamHandle]
        mov esi, dword [byte eax+048h]
        cmp edx, esi
        jle near CdStreamService_AC2.58
        push esi
        mov ebx, dword [eax]
        push ebx
        mov ecx, dword [byte eax+0Ch]
        push ecx
        call bcopy
        mov eax, dword [StreamHandle]
        mov eax, dword [byte eax+0Ch]
        mov dword [eax], 0FFFFFFFFh
        mov eax, dword [StreamHandle]
        mov edx, dword [eax]
        mov dword [byte eax+0Ch], edx
        mov eax, edx
        mov edx, dword [StreamHandle]
        mov dword [byte edx+08h], eax
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+048h]
        mov esi, dword [byte eax+08h]
        add esi, edx
        add esp, byte 0Ch
        mov dword [byte eax+08h], esi
.19:
        mov edx, dword [StreamHandle]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+014h]
        mov ecx, dword [byte edx+08h]
        mov ebx, edx
        cmp eax, ecx
        jae short .20
        mov eax, dword [byte edx+04h]
        sub eax, ecx
        jmp short .22
.20:
        jne short .21
        mov ecx, dword [byte edx+010h]
        cmp ecx, dword [byte edx+014h]
        jne short .21
        mov ebx, dword [byte edx+08h]
        mov eax, dword [byte edx+04h]
        sub eax, ebx
        jmp short .22
.21:
        mov esi, dword [byte ebx+08h]
        mov eax, dword [byte ebx+014h]
        sub eax, esi
.22:
        mov edx, dword [StreamHandle]
        mov esi, dword [byte edx+03Ch]
        cmp eax, esi
        jle near CdStreamService_AC2.58
        cmp edi, dword [dword edx+080h]
        jl near CdStreamService_AC2.58
        mov ecx, dword [byte edx+060h]
        mov dword [byte edx+060h], edi
        mov ebx, esi
        mov eax, dword [StreamHandle]
        sub ebx, ecx
        mov esi, dword [dword eax+080h]
        mov dword [streamstate], edi
        push ebx
        mov edx, dword [byte eax+08h]
        push edx
        mov ecx, dword [byte eax+018h]
        push ecx
        call CdRead
        mov eax, dword [streamstate]
        mov edx, dword [CdStreamFilled]
        mov ecx, dword [CdStreamUsed]
        add edx, eax
        add ecx, ebx
        mov eax, dword [StreamHandle]
        mov dword [CdStreamFilled], edx
        mov dword [CdStreamUsed], ecx
        mov dword [dword eax+080h], esi
        mov ecx, dword [StreamHandle]
        add esp, byte 0Ch
        mov edx, dword [StreamBlockSize]
        mov eax, dword [byte ecx+03Ch]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        add dword [dword ecx+080h], eax
        mov eax, dword [StreamHandle]
        add dword [byte eax+08h], ebx
        mov eax, dword [StreamHandle]
        add dword [byte eax+058h], ebx
        mov eax, dword [StreamHandle]
        add dword [byte eax+048h], ebx
CdStreamService_47A:
        mov edx, dword [StreamHandle]
        cmp ebp, dword [byte edx+048h]
        jbe short .23
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+04h]
        mov ebx, dword [byte edx+08h]
        mov edx, dword [StreamHandle]
        sub eax, ebx
        cmp eax, dword [byte edx+03Ch]
        jg near CdStreamService_1E3.19
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+04h]
        mov esi, dword [byte edx+08h]
        mov edx, eax
        mov eax, dword [StreamHandle]
        sub edx, esi
        call CdStreamContigData
        cmp edx, eax
        jne near CdStreamService_AC2.58
        mov edx, dword [StreamHandle]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+014h]
        cmp eax, dword [byte edx+08h]
        ja near CdStreamService_1E3.17
        mov ecx, dword [edx]
        mov edx, eax
        sub edx, ecx
        jmp near CdStreamService_1E3.18
.23:
        mov eax, dword [byte edx+0Ch]
        cmp dword [eax], 6C454353h
        jne short .24
        cmp edi, dword [byte edx+074h]
        je short .24
        mov dword [byte edx+01Ch], 7
        jmp near CdStreamService_20
.24:
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+0Ch]
        mov edx, dword [byte edx+04h]
        mov dword [byte eax+044h], edx
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+044h]
        mov esi, dword [byte eax+048h]
        sub edx, esi
        mov dword [byte eax+040h], edx
        mov eax, dword [StreamHandle]
        mov dword [CdStreamBuf], eax
.25:
        mov eax, dword [CdStreamBuf]
        mov eax, dword [byte eax+06Ch]
        mov dword [CdStreamBuf], eax
        cmp edi, eax
        jne short .26
        mov eax, dword [StreamHandle]
        mov dword [CdStreamBuf], eax
        jmp short .27
.26:
        mov ebx, dword [StreamHandle]
        mov ebx, dword [byte ebx+0Ch]
        mov edx, eax
        mov eax, dword [byte eax+068h]
        mov ecx, dword [ebx]
        mov esi, dword [byte edx+064h]
        and eax, ecx
        cmp eax, esi
        jne short .25
.27:
        mov eax, dword [StreamHandle]
        cmp ebp, dword [byte eax+044h]
        jg short .28
        mov edx, dword [CdStreamBuf]
        mov eax, dword [byte eax+044h]
        cmp eax, dword [byte edx+038h]
        jle short CdStreamService_595
.28:
        mov eax, dword [StreamHandle]
        cmp edi, dword [byte eax+028h]
        jne short CdStreamService_595
        mov dword [byte eax+01Ch], 0Eh
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
CdStreamService_595:
        mov esi, dword [StreamHandle]
        cmp esi, dword [CdStreamBuf]
        je near CdStreamService_74E
        mov dword [byte esi+01Ch], 4
        mov edx, dword [CdStreamBuf]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+04h]
        sub eax, dword [byte edx+08h]
        mov edx, dword [StreamHandle]
        mov ebx, eax
        mov ecx, dword [byte edx+03Ch]
        mov eax, dword [byte edx+044h]
        add eax, ecx
        add eax, byte 8
        cmp ebx, eax
        ja short .31
        mov edx, dword [CdStreamBuf]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+04h]
        mov esi, dword [byte edx+08h]
        mov edx, eax
        mov eax, dword [CdStreamBuf]
        sub edx, esi
        call CdStreamContigData
        cmp edx, eax
        jne near CdStreamService_AC2.58
        mov edx, dword [CdStreamBuf]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+014h]
        cmp eax, dword [byte edx+08h]
        ja short .29
        sub eax, dword [edx]
        jmp short .30
.29:
        mov eax, edi
.30:
        mov edx, dword [StreamHandle]
        cmp eax, dword [byte edx+048h]
        jle near CdStreamService_AC2.58
        mov eax, dword [CdStreamBuf]
        mov eax, dword [byte eax+0Ch]
        mov dword [eax], 0FFFFFFFFh
        mov eax, dword [CdStreamBuf]
        mov edx, dword [eax]
        mov dword [byte eax+0Ch], edx
        mov eax, dword [CdStreamBuf]
        mov dword [byte eax+08h], edx
.31:
        mov edx, dword [CdStreamBuf]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+014h]
        mov ecx, dword [byte edx+08h]
        mov ebx, edx
        cmp eax, ecx
        jae short .32
        mov edx, dword [byte edx+04h]
        sub edx, ecx
        jmp short .34
.32:
        jne short .33
        mov ecx, dword [byte edx+010h]
        cmp ecx, dword [byte edx+014h]
        jne short .33
        mov eax, dword [byte edx+04h]
        mov ebx, dword [byte edx+08h]
        mov edx, eax
        sub edx, ebx
        jmp short .34
.33:
        mov esi, dword [byte ebx+08h]
        mov edx, dword [byte ebx+014h]
        sub edx, esi
.34:
        mov eax, dword [StreamHandle]
        mov ebx, dword [byte eax+03Ch]
        add ebx, ebp
        cmp edx, ebx
        jbe near CdStreamService_AC2.58
        cmp edi, dword [byte eax+040h]
        jg short .35
        mov edx, dword [byte eax+048h]
        push edx
        mov edx, dword [CdStreamBuf]
        mov ebx, dword [byte edx+0Ch]
        push ebx
        mov ecx, dword [byte eax+0Ch]
        push ecx
        call bcopy
        mov eax, dword [CdStreamBuf]
        mov ebx, dword [StreamHandle]
        mov edx, dword [byte eax+0Ch]
        mov esi, dword [byte ebx+048h]
        add edx, esi
        mov dword [byte eax+08h], edx
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+0Ch]
        mov dword [byte eax+08h], edx
        mov eax, dword [StreamHandle]
        add esp, byte 0Ch
        mov dword [byte eax+048h], edi
        jmp short CdStreamService_74E
.35:
        mov edx, dword [byte eax+044h]
        push edx
        mov edx, dword [CdStreamBuf]
        mov ebx, dword [byte edx+0Ch]
        push ebx
        mov ecx, dword [byte eax+0Ch]
        push ecx
        call bcopy
        mov eax, dword [CdStreamBuf]
        mov ebx, dword [StreamHandle]
        mov edx, dword [byte eax+0Ch]
        mov esi, dword [byte ebx+044h]
        add edx, esi
        mov dword [byte eax+08h], edx
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+040h]
        neg edx
        mov dword [byte eax+048h], edx
        mov eax, dword [StreamHandle]
        add esp, byte 0Ch
        mov edx, dword [byte eax+048h]
        push edx
        mov ebx, dword [byte eax+0Ch]
        mov ecx, dword [byte eax+044h]
        push ebx
        lea edx, [ebx+ecx]
        push edx
        call bcopy
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+044h]
        mov esi, dword [byte eax+08h]
        sub esi, edx
        add esp, byte 0Ch
        mov dword [byte eax+08h], esi
CdStreamService_74E:
        mov edx, dword [StreamHandle]
        mov eax, dword [byte edx+040h]
        cmp edi, eax
        jge near CdStreamService_81D
        mov ebx, dword [byte edx+03Ch]
        lea edx, [eax+ebx]
        mov eax, dword [CdStreamBuf]
        add edx, byte 8
        call CdStreamSpaceLeft
        cmp eax, edx
        ja near CdStreamService_81D
        mov eax, dword [StreamHandle]
        mov dword [byte eax+01Ch], 5
        mov edx, dword [CdStreamBuf]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+04h]
        mov ecx, dword [byte edx+08h]
        mov edx, eax
        mov eax, dword [CdStreamBuf]
        sub edx, ecx
        call CdStreamContigData
        cmp edx, eax
        jne near CdStreamService_AC2.58
        mov edx, dword [CdStreamBuf]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+014h]
        cmp eax, dword [byte edx+08h]
        ja short .36
        sub eax, dword [edx]
        jmp short .37
.36:
        mov eax, edi
.37:
        mov edx, dword [StreamHandle]
        mov ecx, dword [byte edx+048h]
        cmp eax, ecx
        jle near CdStreamService_AC2.58
        mov eax, dword [CdStreamBuf]
        push ecx
        mov edx, dword [eax]
        push edx
        mov ebx, dword [byte eax+0Ch]
        push ebx
        call bcopy
        mov eax, dword [CdStreamBuf]
        mov eax, dword [byte eax+0Ch]
        mov dword [eax], 0FFFFFFFFh
        mov eax, dword [CdStreamBuf]
        mov edx, dword [StreamHandle]
        mov ebx, dword [eax]
        mov ecx, dword [byte edx+048h]
        add ebx, ecx
        mov dword [byte eax+08h], ebx
        mov eax, dword [CdStreamBuf]
        mov edx, dword [eax]
        add esp, byte 0Ch
        mov dword [byte eax+0Ch], edx
CdStreamService_81D:
        mov eax, dword [StreamHandle]
        mov dword [byte eax+01Ch], 6
.38:
        mov eax, dword [StreamHandle]
        cmp edi, dword [byte eax+040h]
        jge near .42
        mov edx, dword [CdStreamBuf]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+014h]
        mov ecx, dword [byte edx+08h]
        mov ebx, edx
        cmp eax, ecx
        jae short .39
        mov eax, dword [byte edx+04h]
        sub eax, ecx
        jmp short .41
.39:
        jne short .40
        mov ecx, dword [byte edx+010h]
        cmp ecx, dword [byte edx+014h]
        jne short .40
        mov ebx, dword [byte edx+08h]
        mov eax, dword [byte edx+04h]
        sub eax, ebx
        jmp short .41
.40:
        mov esi, dword [byte ebx+08h]
        mov eax, dword [byte ebx+014h]
        sub eax, esi
.41:
        mov edx, dword [StreamHandle]
        mov esi, dword [byte edx+03Ch]
        cmp eax, esi
        jle near CdStreamService_AC2.58
        cmp edi, dword [dword edx+080h]
        jl near CdStreamService_AC2.58
        mov ecx, dword [byte edx+060h]
        mov dword [byte edx+060h], edi
        mov ebx, esi
        mov eax, dword [StreamHandle]
        sub ebx, ecx
        mov edx, dword [CdStreamBuf]
        mov esi, dword [dword eax+080h]
        mov dword [streamstate], edi
        push ebx
        mov ecx, dword [byte edx+08h]
        push ecx
        mov edx, dword [byte eax+018h]
        push edx
        call CdRead
        mov eax, dword [streamstate]
        mov ecx, dword [CdStreamFilled]
        add ecx, eax
        add dword [CdStreamUsed], ebx
        mov eax, dword [StreamHandle]
        mov dword [CdStreamFilled], ecx
        mov dword [dword eax+080h], esi
        mov ecx, dword [StreamHandle]
        add esp, byte 0Ch
        mov edx, dword [StreamBlockSize]
        mov eax, dword [byte ecx+03Ch]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        add dword [dword ecx+080h], eax
        mov eax, dword [StreamHandle]
        add dword [byte eax+058h], ebx
        mov eax, dword [CdStreamBuf]
        add dword [byte eax+08h], ebx
        mov eax, dword [StreamHandle]
        sub dword [byte eax+040h], ebx
        jmp near .38
.42:
        mov edx, dword [byte eax+0Ch]
        cmp dword [edx], 6C454353h
        jne short .43
        mov edx, dword [CdStreamBuf]
        mov eax, dword [byte eax+044h]
        add dword [byte edx+0Ch], eax
        mov eax, dword [StreamHandle]
        mov dword [byte eax+01Ch], 7
        jmp near CdStreamService_20
.43:
        mov edx, dword [CdStreamBuf]
        mov eax, dword [byte eax+044h]
        add dword [byte edx+0Ch], eax
CdStreamService_956:
        mov ebx, dword [StreamHandle]
        cmp ebx, dword [CdStreamBuf]
        je near .50
        mov dword [byte ebx+01Ch], 0Ah
        mov edx, dword [StreamHandle]
        cmp dword [byte edx+048h], byte 0
        jne near CdStreamService_AC2
        mov eax, edx
        call CdStreamSkipMarks
        mov ebx, dword [byte edx+04h]
        mov edi, dword [byte edx+08h]
        mov edx, dword [CdStreamBuf]
        mov eax, dword [byte edx+08h]
        mov ebp, dword [byte edx+0Ch]
        sub ebx, edi
        sub eax, ebp
        cmp ebx, eax
        jg near .46
        mov edx, dword [StreamHandle]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+04h]
        mov ebx, dword [byte edx+08h]
        mov edx, eax
        mov eax, dword [StreamHandle]
        sub edx, ebx
        call CdStreamContigData
        cmp edx, eax
        jne near CdStreamService_AC2.58
        mov edx, dword [StreamHandle]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+014h]
        cmp eax, dword [byte edx+08h]
        ja short .44
        mov ebx, eax
        sub ebx, dword [edx]
        jmp short .45
.44:
        xor ebx, ebx
.45:
        mov edx, dword [CdStreamBuf]
        mov eax, dword [byte edx+08h]
        sub eax, dword [byte edx+0Ch]
        cmp ebx, eax
        jle near CdStreamService_AC2.58
        mov eax, dword [StreamHandle]
        mov eax, dword [byte eax+0Ch]
        mov dword [eax], 0FFFFFFFFh
        mov eax, dword [StreamHandle]
        mov edx, dword [eax]
        mov dword [byte eax+0Ch], edx
        mov eax, edx
        mov edx, dword [StreamHandle]
        mov dword [byte edx+08h], eax
.46:
        mov edx, dword [StreamHandle]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+014h]
        mov ebp, dword [byte edx+08h]
        mov ebx, edx
        cmp eax, ebp
        jae short .47
        mov eax, dword [byte edx+04h]
        sub eax, ebp
        jmp short .49
.47:
        jne short .48
        mov esi, dword [byte edx+010h]
        cmp esi, dword [byte edx+014h]
        jne short .48
        mov eax, dword [byte edx+04h]
        sub eax, ebp
        jmp short .49
.48:
        mov edi, dword [byte ebx+08h]
        mov eax, dword [byte ebx+014h]
        sub eax, edi
.49:
        mov ebx, dword [CdStreamBuf]
        mov edx, dword [byte ebx+08h]
        sub edx, dword [byte ebx+0Ch]
        cmp eax, edx
        jle near CdStreamService_AC2.58
        mov eax, dword [StreamHandle]
        mov dword [byte eax+048h], edx
        mov eax, dword [StreamHandle]
        mov esi, dword [byte eax+048h]
        push esi
        mov edi, dword [byte eax+0Ch]
        mov eax, dword [CdStreamBuf]
        push edi
        mov ebp, dword [byte eax+0Ch]
        push ebp
        call bcopy
        mov eax, dword [CdStreamBuf]
        mov edx, dword [byte eax+0Ch]
        mov dword [byte eax+08h], edx
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+0Ch]
        add edx, dword [byte eax+048h]
        add esp, byte 0Ch
        mov dword [byte eax+08h], edx
        jmp short CdStreamService_AC2
.50:
        mov edx, dword [CdStreamBuf]
        mov eax, dword [byte edx+08h]
        mov ecx, dword [byte edx+0Ch]
        mov edx, eax
        sub edx, ecx
        mov dword [byte ebx+048h], edx
CdStreamService_AC2:
        mov eax, dword [StreamHandle]
        mov edx, dword [byte eax+058h]
        mov ecx, dword [byte eax+048h]
        mov esi, dword [byte eax+050h]
        sub edx, ecx
        cmp edx, esi
        jl near .57
        cmp dword [byte eax+074h], byte 0
        jne near .56
        mov dword [byte eax+01Ch], 9
        mov eax, dword [StreamHandle]
        mov dword [CdStreamBuf], eax
.51:
        mov edx, dword [CdStreamBuf]
        mov eax, edx
        call CdStreamSkipMarks
        mov eax, dword [byte edx+014h]
        mov ebp, dword [byte edx+08h]
        mov ebx, edx
        cmp eax, ebp
        jae short .52
        mov eax, dword [byte edx+04h]
        sub eax, ebp
        jmp short .54
.52:
        jne short .53
        mov esi, dword [byte edx+010h]
        cmp esi, dword [byte edx+014h]
        jne short .53
        mov eax, dword [byte edx+04h]
        sub eax, ebp
        jmp short .54
.53:
        mov edi, dword [byte ebx+08h]
        mov eax, dword [byte ebx+014h]
        sub eax, edi
.54:
        mov edx, dword [CdStreamBuf]
        add eax, dword [byte edx+048h]
        cmp eax, byte 8
        jbe short .58
        mov eax, dword [byte edx+06Ch]
        mov dword [CdStreamBuf], eax
        test eax, eax
        jne short .51
        mov eax, dword [StreamHandle]
        mov dword [CdStreamBuf], eax
        mov ebx, 8
.55:
        mov eax, dword [CdStreamBuf]
        mov eax, dword [byte eax+0Ch]
        mov dword [eax], 0FFFFFFFDh
        mov eax, dword [CdStreamBuf]
        mov eax, dword [byte eax+0Ch]
        mov dword [byte eax+04h], ebx
        mov eax, dword [CdStreamBuf]
        add dword [byte eax+0Ch], ebx
        mov eax, dword [CdStreamBuf]
        mov edx, dword [byte eax+0Ch]
        mov dword [byte eax+08h], edx
        mov eax, dword [CdStreamBuf]
        mov eax, dword [byte eax+06Ch]
        mov dword [CdStreamBuf], eax
        test eax, eax
        jne short .55
.56:
        mov eax, dword [StreamHandle]
        mov dword [byte eax+01Ch], 7
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.57:
        mov dword [byte eax+01Ch], 3
.58:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
CdStreamService_BB8:
        mov eax, dword [StreamHandle]
        sub dword [dword eax+080h], byte 0Ah
        inc dword [streamstate]
        ret
        db 090h
;-----------------------------------------------------------------------------
; CdStreamSkipMarks                                               3FB34  96 PC
; Moves a stream's read pointer over skip (-2) and wrap (-1) marks in its
; ring buffer
;-----------------------------------------------------------------------------
CdStreamSkipMarks:
        push ebx
        push edx
        push esi
        push edi
        mov edx, dword [byte eax+014h]
        cmp edx, dword [byte eax+010h]
        je short .5
.1:
        mov esi, dword [byte eax+0Ch]
        mov edx, dword [byte eax+014h]
        cmp edx, esi
        je short .5
        mov edi, dword [edx]
        cmp edi, byte 0FFFFFFFEh
        jne short .2
        mov ebx, dword [byte edx+04h]
        add edx, ebx
        jmp short .4
.2:
        cmp edi, byte 0FFFFFFFFh
        jne short .5
        cmp edx, dword [byte eax+010h]
        jne short .3
        mov edx, dword [eax]
        mov dword [byte eax+010h], edx
.3:
        mov edx, dword [eax]
.4:
        mov dword [byte eax+014h], edx
        mov edx, dword [byte eax+014h]
        cmp edx, dword [byte eax+010h]
        jne short .1
.5:
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CdStreamContigData                                              3FB7C  96 PC
; Bytes readable in one piece from the stream's ring buffer
;-----------------------------------------------------------------------------
CdStreamContigData:
        push ebx
        push edx
        push esi
        push edi
        mov edx, eax
        call CdStreamSkipMarks
        mov eax, dword [byte edx+014h]
        mov ebx, dword [byte edx+08h]
        cmp eax, ebx
        jae short .1
        mov eax, dword [byte edx+04h]
        sub eax, ebx
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
.1:
        jne short .2
        mov esi, dword [byte edx+010h]
        cmp esi, dword [byte edx+014h]
        jne short .2
        mov eax, dword [byte edx+04h]
        sub eax, ebx
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
.2:
        mov edi, dword [byte edx+08h]
        mov eax, dword [byte edx+014h]
        sub eax, edi
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CdStreamSpaceLeft                                               3FBBC  96 PC
; Room left at the end of the stream's ring buffer
;-----------------------------------------------------------------------------
CdStreamSpaceLeft:
        push edx
        mov edx, eax
        call CdStreamSkipMarks
        mov eax, dword [byte edx+04h]
        sub eax, dword [byte edx+08h]
        pop edx
        ret
        push edx
        mov edx, eax
        call CdStreamSkipMarks
        mov eax, dword [byte edx+014h]
        cmp eax, dword [byte edx+08h]
        ja short .1
        sub eax, dword [edx]
        pop edx
        ret
.1:
        xor eax, eax
        pop edx
        ret
;-----------------------------------------------------------------------------
; CdStreamNextPacket                           3FBE4  96 PC, medium confidence
; Services the stream and returns its next packet (-2 at the end of the
; stream)
;-----------------------------------------------------------------------------
CdStreamNextPacket:
        push ebx
        push esi
        mov eax, dword [byte esp+0Ch]
        mov edx, dword [byte eax+01Ch]
        cmp edx, byte 2
        je short .1
        cmp edx, byte 1
        jne short .2
.1:
        xor eax, eax
        pop esi
        pop ebx
        ret
.2:
        cmp edx, byte 0Eh
        jne short .3
        mov eax, 0FFFFFFFEh
        pop esi
        pop ebx
        ret
.3:
        mov esi, dword [byte eax+010h]
        cmp esi, dword [byte eax+0Ch]
        jne short .4
        xor eax, eax
        pop esi
        pop ebx
        ret
.4:
        cmp dword [esi], byte 0FFFFFFFFh
        jne short .5
        mov edx, dword [eax]
        mov dword [byte eax+010h], edx
        mov edx, dword [byte eax+0Ch]
        cmp edx, dword [byte eax+010h]
        jne short .5
        xor eax, eax
        pop esi
        pop ebx
        ret
.5:
        mov edx, dword [byte eax+010h]
        mov ecx, dword [byte eax+0Ch]
        mov ebx, dword [byte edx+04h]
        cmp edx, ecx
        jbe short .6
        mov ecx, dword [byte eax+04h]
        sub ecx, edx
        cmp ecx, ebx
        jge short .7
        xor eax, eax
        pop esi
        pop ebx
        ret
.6:
        sub ecx, edx
        cmp ecx, ebx
        jge short .7
        xor eax, eax
        pop esi
        pop ebx
        ret
.7:
        mov edx, dword [byte eax+010h]
        lea ecx, [edx+ebx]
        mov dword [byte eax+010h], ecx
        cmp dword [edx], byte 0FFFFFFFDh
        jne short .10
        cmp edx, dword [byte eax+014h]
        jne short .8
        mov dword [byte eax+014h], ecx
        jmp short .9
.8:
        mov dword [edx], 0FFFFFFFEh
.9:
        mov edx, 0FFFFFFFFh
.10:
        mov eax, edx
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CdStreamFreePacket                                              3FC7C  96 PC
; Marks a packet as used (-2), so the ring buffer space comes back
;-----------------------------------------------------------------------------
CdStreamFreePacket:
        mov eax, dword [byte esp+08h]
        mov dword [eax], 0FFFFFFFEh
        ret
        db 090h
;-----------------------------------------------------------------------------
; StreamBufferFree                                3FC88  97 PC, low confidence
; Counts the free blocks of a stream buffer
;-----------------------------------------------------------------------------
StreamBufferFree:
        push ebx
        push ebp
        mov ebx, dword [byte esp+0Ch]
        mov eax, dword [byte ebx+010h]
        mov ecx, dword [byte ebx+0Ch]
        xor edx, edx
        cmp eax, ecx
        je short .4
.1:
        cmp dword [eax], byte 0FFFFFFFFh
        jne short .2
        mov eax, dword [ebx]
        jmp short .3
.2:
        mov ecx, dword [byte eax+04h]
        mov ebp, dword [byte eax+04h]
        sub ecx, byte 8
        add eax, ebp
        add edx, ecx
.3:
        cmp eax, dword [byte ebx+0Ch]
        jne short .1
.4:
        mov eax, edx
        pop ebp
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ebp
        mov ebx, dword [byte esp+0Ch]
        mov eax, dword [byte ebx+014h]
        mov ecx, dword [byte ebx+010h]
        xor edx, edx
        cmp eax, ecx
        je short .8
.5:
        cmp dword [eax], byte 0FFFFFFFFh
        jne short .6
        mov eax, dword [ebx]
        jmp short .7
.6:
        mov ecx, dword [byte eax+04h]
        mov ebp, dword [byte eax+04h]
        sub ecx, byte 8
        add eax, ebp
        add edx, ecx
.7:
        cmp eax, dword [byte ebx+010h]
        jne short .5
.8:
        mov eax, edx
        pop ebp
        pop ebx
        ret
        db 08Bh,0C0h
        mov eax, dword [StreamHandle]
        cmp dword [byte eax+01Ch], byte 7
        jne short .9
        cmp dword [byte eax+074h], byte 0
        jne short .9
        mov eax, 1
        ret
.9:
        xor eax, eax
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; StreamReady                                     3FD0C  97 PC, low confidence
; Whether the CD stream can take a request; returns 1 if so
;-----------------------------------------------------------------------------
StreamReady:
        push esi
        cmp dword [byte esp+0Ch], byte 0FFFFFFFFh
        jne short .1
        mov eax, 1
        pop esi
        ret
.1:
        mov eax, dword [StreamHandle]
        cmp dword [byte eax+01Ch], byte 7
        jne short .2
        cmp dword [byte eax+074h], byte 0
        jne short .2
        mov eax, 1
        jmp short .3
.2:
        xor eax, eax
.3:
        test eax, eax
        je short .4
        mov esi, dword [byte esp+08h]
        push esi
        call StreamBufferFree
        add esp, byte 4
        test eax, eax
        jne short .4
        mov eax, 1
        pop esi
        ret
.4:
        xor eax, eax
        pop esi
        ret
        db 08Dh,040h,00h
        mov eax, dword [StreamHandle]
        mov dword [byte eax+02Ch], 1
        ret
        db 08Dh,040h,00h
        mov eax, dword [StreamHandle]
        mov dword [byte eax+02Ch], 0
        ret
        db 08Dh,040h,00h
        push ebx
        mov eax, dword [byte esp+08h]
        mov ebx, dword [byte esp+0Ch]
        mov edx, dword [StreamHandle]
        dec ebx
        mov dword [byte edx+070h], eax
        xor edx, edx
        test ebx, ebx
        jle short .6
.5:
        lea ecx, [dword eax+09Bh]
        inc edx
        mov dword [dword eax+097h], ecx
        mov eax, ecx
        cmp edx, ebx
        jl short .5
.6:
        mov dword [dword eax+097h], 0
        pop ebx
        ret
        mov edx, dword [byte esp+04h]
        mov eax, dword [StreamHandle]
        mov eax, dword [byte eax+070h]
        mov dword [dword edx+097h], eax
        mov eax, dword [StreamHandle]
        mov dword [byte eax+070h], edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; StreamQueueBlock                                3FDCC  97 PC, low confidence
; Queues a block on the CD stream
;-----------------------------------------------------------------------------
StreamQueueBlock:
        push ebx
        mov eax, dword [StreamHandle]
        cmp dword [byte eax+070h], byte 0
        jne short .1
        cmp dword [byte esp+08h], byte 0
        jne short .1
        xor eax, eax
        pop ebx
        ret
.1:
        mov edx, dword [StreamHandle]
        mov eax, dword [byte edx+070h]
        mov ebx, dword [dword eax+097h]
        mov dword [byte edx+070h], ebx
        mov dword [dword eax+097h], 0
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        mov dword [byte eax+0Ch], 0
        mov dword [byte eax+010h], ebx
        mov dword [byte eax+08h], edx
        mov dword [byte eax+04h], edx
        mov dword [eax], edx
        ret
        db 090h
        push ebx
        push ecx
        push edx
        mov ebx, dword [byte eax+04h]
        mov edx, dword [byte eax+08h]
        cmp edx, ebx
        jge short .2
        mov eax, ebx
        sub eax, edx
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        mov edx, dword [byte eax+010h]
        mov ebx, dword [eax]
        mov ecx, dword [byte eax+08h]
        add edx, ebx
        mov eax, dword [byte eax+04h]
        sub edx, ecx
        sub eax, ebx
        cmp edx, eax
        jl short .3
        mov eax, edx
.3:
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; RingBufferSpace                                 3FE54  97 PC, low confidence
; Returns how much of a ring buffer is free from the write position
;-----------------------------------------------------------------------------
RingBufferSpace:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ecx, dword [byte eax+08h]
        mov esi, dword [byte eax+04h]
        xor ebx, ebx
        cmp ecx, esi
        jge short .2
        mov ecx, esi
        mov ebp, dword [byte eax+08h]
        sub ecx, ebp
        cmp ecx, edx
        jl short .1
        mov ebx, ebp
        lea ecx, [edx+ebp]
        mov dword [byte eax+08h], ecx
.1:
        mov eax, ebx
        jmp short .5
.2:
        mov ecx, dword [byte eax+010h]
        mov ebx, dword [eax]
        mov edi, dword [byte eax+08h]
        add ecx, ebx
        sub esi, ebx
        sub ecx, edi
        mov ebx, esi
        cmp ecx, edx
        jl short .3
        lea ecx, [edi+edx]
        mov dword [byte eax+08h], ecx
        mov eax, edi
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.3:
        cmp esi, edx
        jl short .4
        mov ebx, dword [eax]
        mov dword [byte eax+0Ch], edi
        lea ecx, [ebx+edx]
        mov dword [byte eax+08h], ecx
        mov eax, ebx
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.4:
        xor eax, eax
.5:
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        add edx, ebx
        mov ebx, dword [byte eax+08h]
        mov dword [byte eax+04h], edx
        cmp edx, ebx
        jne short .6
        mov edx, dword [eax]
        mov dword [byte eax+08h], edx
        mov dword [byte eax+04h], edx
        ret
.6:
        cmp edx, dword [byte eax+0Ch]
        jne short .7
        mov edx, dword [eax]
        mov dword [byte eax+0Ch], 0
        mov dword [byte eax+04h], edx
.7:
        ret
