; EA library: AsyncInit, AsyncClose, AsyncRequestOpen, AsyncRequestSection, AsyncResetRequest and 4 more.
bits 32
%include "hockey.inc"
section s_109A74 progbits alloc exec nowrite align=1
extern addtimer, AllocMemBlock, AllocMemBlockFixed, AsyncBytesLeft, AsyncCallback, AsyncChunkDest, AsyncChunkSize, AsyncCurBuffer
extern AsyncCurFile, AsyncCurOffset, AsyncDest, AsyncDosRegs, AsyncDosResult, AsyncError, AsyncFileHandle, AsyncFreeList
extern AsyncLastSector, AsyncQueueHead, AsyncQueueTail, AsyncReadLength, AsyncRequests, AsyncSector, AsyncSectorCount, AsyncSeekRegs
extern AsyncState, AsyncStreamBase, AsyncStreamEnd, AsyncStreamFile, AsyncStreamPos, AsyncStreamSize, AsyncTickCount, AsyncWaitTimer
extern CdCloseFile, CdFindFile, CdHandleEntry, CdOpenStream, CdRead, CdSeek, DriveLetterIndex, FreeMemBlock
extern IsCdDrive, RemoveTimerCallback, str_ASYNCFILE, strcmp_, strncpy_, UnlinkMemBlockLocked
global AsyncInit, AsyncClose, AsyncRequestOpen, AsyncRequestSection, AsyncResetRequest, AsyncStreamStepJumpTable, AsyncStreamStep, AsyncStreamStep_2E
global AsyncStreamStep_57B, AsyncStreamStep_613, AsyncStreamStep_78F, AsyncTick, AsyncFreeRequest, AsyncPopRequest
;-----------------------------------------------------------------------------
; AsyncInit                                   109A74  96 PC, medium confidence
; EA async reader: allocates the ASYNC FILE request blocks (0ABh bytes each,
; free list), sets the read rate, starts AsyncTimerTick
;-----------------------------------------------------------------------------
AsyncInit:
        push ebx
        push esi
        push ebp
        mov ebx, dword [byte esp+010h]
        mov esi, dword [byte esp+014h]
        lea eax, [nosplit ebx*4+00h]
        add eax, ebx
        shl eax, 2
        mov edx, dword [byte esp+018h]
        sub eax, ebx
        push edx
        mov edx, eax
        shl eax, 3
        add eax, edx
        push eax
        push str_ASYNCFILE
        dec ebx
        call AllocMemBlock
        mov edx, eax
        add esp, byte 0Ch
        mov dword [AsyncRequests], eax
        mov dword [AsyncFreeList], eax
        xor edx, eax
        test ebx, ebx
        jle short .2
.1:
        lea ecx, [dword eax+0ABh]
        inc edx
        mov dword [dword eax+0A7h], ecx
        mov eax, ecx
        cmp edx, ebx
        jl short .1
.2:
        mov ebx, 1
        mov ecx, 0FFFFFFFFh
        mov ebp, dword [AsyncStreamFile]
        mov dword [dword eax+0A7h], 0
        mov dword [AsyncState], ebx
        mov eax, esi
        mov dword [AsyncQueueHead], ecx
        and eax, 0FFFF800h
        mov dword [AsyncQueueTail], ecx
        mov dword [AsyncFileHandle], eax
        test ebp, ebp
        jne short .3
        mov eax, 0DAh
        mov edx, 12Ch
        mov dword [AsyncStreamFile], eax
        mov dword [AsyncStreamSize], edx
.3:
        mov edx, dword [AsyncStreamFile]
        mov eax, esi
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        xor ebx, ebx
        push AsyncTick
        mov dword [AsyncStreamBase], eax
        mov dword [AsyncWaitTimer], ebx
        call addtimer
        add esp, byte 4
        pop ebp
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; AsyncClose                                  109B50  96 PC, medium confidence
; EA async reader: stops AsyncTimerTick, closes its files and frees the
; request blocks
;-----------------------------------------------------------------------------
AsyncClose:
        push edi
        push AsyncTick
        call RemoveTimerCallback
        mov edx, dword [AsyncQueueTail]
        add esp, byte 4
        test edx, edx
        jl short .1
        push edx
        call CdCloseFile
        add esp, byte 4
.1:
        mov ecx, dword [AsyncQueueHead]
        test ecx, ecx
        jl short .2
        push ecx
        call CdCloseFile
        add esp, byte 4
.2:
        mov edi, dword [AsyncRequests]
        push edi
        call FreeMemBlock
        add esp, byte 4
        pop edi
        ret
        db 08Dh,040h,00h
        push ebx
        push esi
        call AsyncPopRequest
        mov ebx, 8Fh
        mov edx, dword [byte esp+0Ch]
        mov ecx, eax
        mov esi, eax
        call strncpy_
        mov dword [dword ecx+08Fh], 0
        mov dword [dword ecx+0A3h], 0
        mov dword [dword ecx+0A7h], 0
        mov eax, dword [byte esp+010h]
        mov dword [dword ecx+093h], 2
        mov edx, dword [AsyncCurOffset]
        mov dword [dword ecx+097h], eax
        test edx, edx
        je short .3
        mov dword [AsyncCurOffset], ecx
        mov dword [dword edx+0A7h], ecx
        mov eax, esi
        pop esi
        pop ebx
        ret
.3:
        mov dword [AsyncCurOffset], ecx
        mov dword [AsyncCurFile], ecx
        mov eax, esi
        pop esi
        pop ebx
        ret
        db 090h
        push ebx
        push esi
        call AsyncPopRequest
        mov ebx, 8Fh
        mov edx, dword [byte esp+0Ch]
        mov ecx, eax
        mov esi, eax
        call strncpy_
        mov dword [dword ecx+097h], 0
        mov dword [dword ecx+08Fh], 0
        mov dword [dword ecx+0A3h], 0
        mov dword [dword ecx+0A7h], 0
        mov eax, dword [byte esp+010h]
        mov dword [dword ecx+093h], 4
        mov edx, dword [AsyncCurOffset]
        mov dword [dword ecx+09Fh], eax
        test edx, edx
        je short .4
        mov dword [AsyncCurOffset], ecx
        mov dword [dword edx+0A7h], ecx
        mov eax, esi
        pop esi
        pop ebx
        ret
.4:
        mov dword [AsyncCurOffset], ecx
        mov dword [AsyncCurFile], ecx
        mov eax, esi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; AsyncRequestOpen                            109C94  96 PC, medium confidence
; EA async reader: queues a type 3 request (open a file by name)
;-----------------------------------------------------------------------------
AsyncRequestOpen:
        push ebx
        call AsyncPopRequest
        mov ebx, 8Fh
        mov edx, dword [byte esp+08h]
        mov ecx, eax
        call strncpy_
        mov dword [dword ecx+08Fh], 0FFFFFFFFh
        mov dword [dword ecx+093h], 3
        mov dword [dword ecx+0A3h], 0
        mov edx, dword [AsyncCurOffset]
        mov dword [dword ecx+0A7h], 0
        test edx, edx
        je short .1
        mov dword [AsyncCurOffset], ecx
        mov dword [dword edx+0A7h], ecx
        pop ebx
        ret
.1:
        mov dword [AsyncCurOffset], ecx
        mov dword [AsyncCurFile], ecx
        pop ebx
        ret
        push ebx
        push esi
        call AsyncPopRequest
        mov ebx, 8Fh
        mov edx, dword [byte esp+0Ch]
        mov ecx, eax
        mov esi, eax
        call strncpy_
        mov dword [dword ecx+0A3h], 0
        mov dword [dword ecx+093h], 1
        mov eax, dword [byte esp+014h]
        mov dword [dword ecx+0A7h], 0
        mov dword [dword ecx+097h], eax
        mov eax, dword [byte esp+010h]
        mov edx, dword [AsyncCurOffset]
        mov dword [dword ecx+08Fh], eax
        test edx, edx
        je short .2
        mov dword [AsyncCurOffset], ecx
        mov dword [dword edx+0A7h], ecx
        mov eax, esi
        pop esi
        pop ebx
        ret
.2:
        mov dword [AsyncCurOffset], ecx
        mov dword [AsyncCurFile], ecx
        mov eax, esi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; AsyncRequestSection                         109D70  96 PC, medium confidence
; EA async reader: queues a type 5 request (a section read, "NO FILE
; SPECIFIED FOR SECTION READ" when no file is open)
;-----------------------------------------------------------------------------
AsyncRequestSection:
        push ebx
        call AsyncPopRequest
        mov dword [dword eax+097h], 0
        mov dword [dword eax+0A3h], 0
        mov ebx, dword [byte esp+0Ch]
        mov dword [dword eax+093h], 5
        mov dword [dword eax+09Fh], ebx
        mov ebx, dword [byte esp+08h]
        mov dword [dword eax+08Fh], ebx
        mov ebx, dword [byte esp+010h]
        mov edx, eax
        mov dword [dword eax+09Bh], ebx
        mov ebx, dword [AsyncCurOffset]
        mov dword [dword eax+0A7h], 0
        test ebx, ebx
        je short .1
        mov dword [AsyncCurOffset], eax
        mov dword [dword ebx+0A7h], eax
        mov eax, edx
        pop ebx
        ret
.1:
        mov dword [AsyncCurOffset], eax
        mov dword [AsyncCurFile], eax
        mov eax, edx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        call AsyncPopRequest
        mov dword [dword eax+097h], 0
        mov dword [dword eax+0A3h], 0
        mov ebx, dword [byte esp+08h]
        mov dword [dword eax+093h], 6
        mov dword [dword eax+09Fh], ebx
        mov ebx, dword [byte esp+0Ch]
        mov edx, eax
        mov dword [dword eax+09Bh], ebx
        mov ebx, dword [AsyncCurOffset]
        mov dword [dword eax+0A7h], 0
        test ebx, ebx
        je short .2
        mov dword [AsyncCurOffset], eax
        mov dword [dword ebx+0A7h], eax
        mov eax, edx
        pop ebx
        ret
.2:
        mov dword [AsyncCurOffset], eax
        mov dword [AsyncCurFile], eax
        mov eax, edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; AsyncResetRequest                              109E54  97 PC, low confidence
; Marks an async file request as having no open handle
;-----------------------------------------------------------------------------
AsyncResetRequest:
        mov eax, dword [byte esp+04h]
        mov dword [dword eax+097h], 0FFFFFFFFh
        ret
        db 090h
AsyncStreamStepJumpTable:                       ; jump table for the switch cases of AsyncStreamStep
        dd AsyncStreamStep_2E
        dd AsyncStreamStep_57B
        dd AsyncStreamStep_613
        dd AsyncStreamStep_78F
;-----------------------------------------------------------------------------
; AsyncStreamStep                                109E74  97 PC, low confidence
; Steps the async CD file state machine: opens, seeks and reads the queued
; request a little at a time
;-----------------------------------------------------------------------------
AsyncStreamStep:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 94h
        cmp dword [AsyncWaitTimer], byte 0
        jg near AsyncStreamStep_78F.42
.1:
        mov eax, dword [AsyncState]
        dec eax
        cmp eax, byte 3
        ja near AsyncStreamStep_78F.41
        jmp dword [nosplit cs:eax*4+AsyncStreamStepJumpTable]
AsyncStreamStep_2E:
        xor eax, eax
        mov edx, dword [AsyncCurFile]
        mov dword [AsyncWaitTimer], eax
        test edx, edx
        je near AsyncStreamStep_78F.42
        mov ebx, edx
        mov eax, dword [dword edx+0A7h]
        mov dword [AsyncCurBuffer], edx
        mov dword [AsyncCurFile], eax
        test eax, eax
        jne short .2
        mov dword [AsyncCurOffset], eax
.2:
        mov edi, dword [dword ebx+097h]
        cmp edi, byte 0FFFFFFFFh
        jne short .3
        mov eax, dword [AsyncFreeList]
        mov dword [dword ebx+0A7h], eax
        mov dword [AsyncFreeList], ebx
        jmp near AsyncStreamStep_78F.41
.3:
        mov ebp, dword [dword ebx+093h]
        cmp ebp, byte 3
        jne near .8
        mov eax, dword [AsyncQueueTail]
        mov dword [AsyncQueueHead], eax
        test eax, eax
        jl short .4
        push eax
        call CdHandleEntry
        add esp, byte 4
        mov edx, eax
        mov eax, ebx
        call strcmp_
        test eax, eax
        je short .4
        mov ecx, dword [AsyncQueueTail]
        push ecx
        mov esi, 0FFFFFFFFh
        call CdCloseFile
        add esp, byte 4
        mov dword [AsyncQueueTail], esi
.4:
        cmp dword [AsyncQueueTail], byte 0
        jge near .7
        lea eax, [dword esp+090h]
        push eax
        push AsyncDosResult
        push AsyncDosRegs
        push AsyncQueueHead
        push ebx
        call CdOpenStream
        add esp, byte 14h
        push dword 8Fh
        push ebx
        lea eax, [byte esp+08h]
        push eax
        call CdFindFile
        add esp, byte 0Ch
        mov eax, esp
        push eax
        call DriveLetterIndex
        add esp, byte 4
        push eax
        call IsCdDrive
        add esp, byte 4
        test eax, eax
        je short .6
        mov edx, dword [AsyncStreamPos]
        test edx, edx
        je short .5
        mov esi, dword [AsyncStreamEnd]
        mov eax, dword [AsyncFileHandle]
        mov dword [AsyncStreamFile], edx
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov dword [AsyncStreamBase], eax
        mov dword [AsyncStreamSize], esi
        jmp short .7
.5:
        mov ecx, 0DAh
        mov esi, 12Ch
        mov eax, dword [AsyncFileHandle]
        mov edx, ecx
        mov dword [AsyncStreamFile], ecx
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov dword [AsyncStreamBase], eax
        mov dword [AsyncStreamSize], esi
        jmp short .7
.6:
        mov ebp, 1
        mov eax, dword [AsyncFileHandle]
        mov edx, ebp
        mov dword [AsyncStreamFile], ebp
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov dword [AsyncStreamBase], eax
        xor eax, eax
        mov dword [AsyncStreamSize], eax
.7:
        mov eax, dword [AsyncQueueHead]
        mov dword [AsyncQueueTail], eax
        mov eax, dword [AsyncFreeList]
        mov dword [dword ebx+0A7h], eax
        mov dword [AsyncFreeList], ebx
        jmp near AsyncStreamStep_78F.41
.8:
        cmp ebp, byte 2
        jne near .14
        lea eax, [dword esp+090h]
        push eax
        push AsyncDosResult
        push AsyncDosRegs
        push AsyncQueueHead
        push ebx
        call CdOpenStream
        add esp, byte 14h
        push dword 8Fh
        push ebx
        lea eax, [byte esp+08h]
        push eax
        call CdFindFile
        add esp, byte 0Ch
        mov eax, esp
        push eax
        call DriveLetterIndex
        add esp, byte 4
        push eax
        call IsCdDrive
        add esp, byte 4
        test eax, eax
        je short .10
        mov edx, dword [AsyncStreamPos]
        test edx, edx
        je short .9
        mov esi, dword [AsyncStreamEnd]
        mov eax, dword [AsyncFileHandle]
        mov dword [AsyncStreamFile], edx
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov dword [AsyncStreamBase], eax
        mov dword [AsyncStreamSize], esi
        jmp short .11
.9:
        mov ecx, 0DAh
        mov esi, 12Ch
        mov eax, dword [AsyncFileHandle]
        mov edx, ecx
        mov dword [AsyncStreamFile], ecx
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov dword [AsyncStreamBase], eax
        mov dword [AsyncStreamSize], esi
        jmp short .11
.10:
        mov ebp, 1
        mov eax, dword [AsyncFileHandle]
        mov edx, ebp
        mov dword [AsyncStreamFile], ebp
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov dword [AsyncStreamBase], eax
        xor eax, eax
        mov dword [AsyncStreamSize], eax
.11:
        mov edi, dword [AsyncDosRegs]
        test edi, edi
        je short .12
        push edi
        mov edx, dword [AsyncQueueHead]
        push edx
        call CdSeek
        add esp, byte 8
        mov dword [AsyncBytesLeft], eax
        jmp short .13
.12:
        mov dword [AsyncBytesLeft], edi
.13:
        mov ecx, dword [dword ebx+097h]
        push ecx
        mov esi, dword [AsyncDosResult]
        push esi
        push ebx
        mov edi, 3
        call AllocMemBlockFixed
        mov dword [AsyncSector], eax
        mov eax, dword [AsyncDosResult]
        add esp, byte 0Ch
        mov dword [AsyncError], eax
        mov eax, dword [AsyncStreamSize]
        mov dword [AsyncState], edi
        mov dword [AsyncWaitTimer], eax
        xor ebp, ebp
        mov dword [AsyncDest], ebp
        add esp, 94h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.14:
        cmp ebp, byte 1
        jne short .15
        mov ecx, dword [AsyncDosRegs]
        mov eax, dword [dword ebx+08Fh]
        add eax, ecx
        push eax
        mov esi, dword [AsyncQueueTail]
        push esi
        call CdSeek
        mov dword [AsyncBytesLeft], eax
        mov eax, dword [AsyncQueueTail]
        mov edi, 2
        mov dword [AsyncQueueHead], eax
        mov eax, dword [AsyncStreamSize]
        add esp, byte 8
        mov dword [AsyncWaitTimer], eax
        mov eax, dword [dword ebx+097h]
        mov dword [AsyncState], edi
        mov dword [AsyncReadLength], eax
        xor ebp, ebp
        mov dword [AsyncDest], ebp
        add esp, 94h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.15:
        cmp ebp, byte 4
        jne near .21
        lea eax, [dword esp+090h]
        push eax
        push AsyncDosResult
        push AsyncDosRegs
        push AsyncQueueHead
        push ebx
        call CdOpenStream
        add esp, byte 14h
        push dword 8Fh
        push ebx
        lea eax, [byte esp+08h]
        push eax
        call CdFindFile
        add esp, byte 0Ch
        mov eax, esp
        push eax
        call DriveLetterIndex
        add esp, byte 4
        push eax
        call IsCdDrive
        add esp, byte 4
        test eax, eax
        je short .17
        mov eax, dword [AsyncStreamPos]
        test eax, eax
        je short .16
        mov edx, eax
        mov dword [AsyncStreamFile], eax
        mov eax, dword [AsyncFileHandle]
        mov esi, dword [AsyncStreamEnd]
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov dword [AsyncStreamBase], eax
        mov dword [AsyncStreamSize], esi
        jmp short .18
.16:
        mov edx, 0DAh
        mov ecx, 12Ch
        mov eax, dword [AsyncFileHandle]
        mov dword [AsyncStreamFile], edx
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov dword [AsyncStreamBase], eax
        mov dword [AsyncStreamSize], ecx
        jmp short .18
.17:
        mov edi, 1
        mov eax, dword [AsyncFileHandle]
        xor ebp, ebp
        mov edx, edi
        mov dword [AsyncStreamFile], edi
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov dword [AsyncStreamBase], eax
        mov dword [AsyncStreamSize], ebp
.18:
        mov esi, dword [AsyncDosRegs]
        test esi, esi
        je short .19
        push esi
        mov eax, dword [AsyncQueueHead]
        push eax
        call CdSeek
        add esp, byte 8
        mov dword [AsyncBytesLeft], eax
        jmp short .20
.19:
        mov dword [AsyncBytesLeft], esi
.20:
        mov eax, dword [dword ebx+09Fh]
        mov dword [AsyncSectorCount], eax
        mov eax, dword [AsyncDosResult]
        mov dword [AsyncError], eax
        mov eax, dword [AsyncStreamSize]
        mov edx, 4
        mov dword [AsyncWaitTimer], eax
        mov eax, dword [dword ebx+097h]
        mov dword [AsyncState], edx
        mov dword [AsyncReadLength], eax
        xor ebp, ebp
        mov dword [AsyncDest], ebp
        add esp, 94h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.21:
        cmp ebp, byte 5
        jne short .22
        mov edx, dword [AsyncDosRegs]
        mov eax, dword [dword ebx+08Fh]
        add eax, edx
        push eax
        mov ecx, dword [AsyncQueueTail]
        push ecx
        call CdSeek
        mov dword [AsyncBytesLeft], eax
        mov eax, dword [dword ebx+09Fh]
        mov dword [AsyncSectorCount], eax
        mov eax, dword [AsyncQueueTail]
        mov dword [AsyncQueueHead], eax
        mov eax, dword [AsyncStreamSize]
        mov esi, 4
        mov dword [AsyncWaitTimer], eax
        mov eax, dword [dword ebx+097h]
        add esp, byte 8
        mov dword [AsyncReadLength], eax
        mov eax, dword [dword ebx+09Bh]
        mov dword [AsyncState], esi
        jmp short .23
.22:
        cmp ebp, byte 6
        jne short .24
        mov eax, dword [dword ebx+09Fh]
        mov dword [AsyncSectorCount], eax
        mov eax, dword [AsyncQueueTail]
        mov ebp, 4
        mov dword [AsyncQueueHead], eax
        mov eax, dword [AsyncStreamSize]
        mov dword [AsyncReadLength], edi
        mov dword [AsyncWaitTimer], eax
        mov eax, dword [dword ebx+09Bh]
        mov dword [AsyncState], ebp
.23:
        mov dword [AsyncError], eax
.24:
        xor ebp, ebp
        mov dword [AsyncDest], ebp
        add esp, 94h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
AsyncStreamStep_57B:
        mov eax, dword [AsyncCurBuffer]
        mov esi, dword [dword eax+097h]
        cmp esi, byte 0FFFFFFFFh
        jne short .25
        mov edx, dword [AsyncFreeList]
        mov dword [AsyncQueueHead], esi
        mov dword [dword eax+0A7h], edx
        mov ebp, 1
        mov dword [AsyncFreeList], eax
        jmp near AsyncStreamStep_78F.40
.25:
        push byte 8
        push AsyncSeekRegs
        mov ebp, dword [AsyncQueueTail]
        xor edi, edi
        push ebp
        mov dword [AsyncTickCount], edi
        call CdRead
        mov eax, dword [AsyncTickCount]
        mov dword [AsyncLastSector], eax
        mov eax, dword [AsyncCallback]
        sub eax, byte 8
        add esp, byte 0Ch
        mov dword [AsyncError], eax
        mov eax, dword [AsyncReadLength]
        push eax
        mov edx, dword [AsyncError]
        push edx
        mov ebx, dword [AsyncCurBuffer]
        push ebx
        mov esi, 3
        call AllocMemBlockFixed
        add esp, byte 0Ch
        mov dword [AsyncSector], eax
        mov dword [AsyncDest], edi
        mov dword [AsyncState], esi
AsyncStreamStep_613:
        cmp dword [AsyncError], byte 0
        jle near .30
        mov ebx, dword [AsyncCurBuffer]
        cmp dword [dword ebx+097h], byte 0FFFFFFFFh
        jne short .27
        cmp dword [dword ebx+093h], byte 2
        jne short .26
        mov esi, dword [AsyncQueueHead]
        push esi
        call CdCloseFile
        add esp, byte 4
.26:
        mov ebp, dword [AsyncSector]
        mov edi, 0FFFFFFFFh
        push ebp
        mov dword [AsyncQueueHead], edi
        call UnlinkMemBlockLocked
        mov eax, dword [AsyncCurBuffer]
        mov edx, dword [AsyncFreeList]
        mov dword [dword eax+0A7h], edx
        mov dword [AsyncFreeList], eax
        mov eax, 1
        add esp, byte 4
        mov dword [AsyncState], eax
        jmp near .30
.27:
        mov eax, dword [AsyncSector]
        mov edx, dword [AsyncDest]
        mov eax, dword [eax]
        mov ebx, dword [AsyncBytesLeft]
        add edx, eax
        mov eax, dword [AsyncError]
        mov ecx, dword [AsyncFileHandle]
        add eax, ebx
        mov esi, dword [AsyncWaitTimer]
        cmp eax, ecx
        jle short .28
        mov edi, dword [AsyncBytesLeft]
        mov ebx, ecx
        sub ebx, edi
        jmp short .29
.28:
        mov ebx, dword [AsyncError]
.29:
        push ebx
        push edx
        mov edx, dword [AsyncQueueHead]
        xor ebp, ebp
        push edx
        mov dword [AsyncBytesLeft], ebp
        mov dword [AsyncTickCount], ebp
        call CdRead
        mov eax, dword [AsyncTickCount]
        mov ecx, dword [AsyncChunkSize]
        mov edi, dword [AsyncChunkDest]
        mov ebp, dword [AsyncDest]
        add esp, byte 0Ch
        mov dword [AsyncWaitTimer], esi
        add ecx, eax
        add edi, ebx
        add ebp, ebx
        mov eax, dword [AsyncStreamBase]
        mov dword [AsyncChunkSize], ecx
        mov dword [AsyncChunkDest], edi
        add esi, eax
        mov eax, dword [AsyncError]
        mov dword [AsyncDest], ebp
        sub eax, ebx
        mov dword [AsyncWaitTimer], esi
        mov dword [AsyncError], eax
        test esi, esi
        jle near AsyncStreamStep_613
        test eax, eax
        jg near AsyncStreamStep_78F.42
        jmp near AsyncStreamStep_613
.30:
        mov eax, dword [AsyncCurBuffer]
        cmp dword [dword eax+093h], byte 2
        jne short .31
        mov ebx, dword [AsyncQueueHead]
        push ebx
        call CdCloseFile
        add esp, byte 4
.31:
        mov ecx, 0FFFFFFFFh
        mov esi, 1
        mov edx, dword [AsyncCurBuffer]
        mov eax, dword [AsyncSector]
        mov dword [AsyncQueueHead], ecx
        mov dword [dword edx+0A3h], eax
        mov dword [AsyncState], esi
        jmp near AsyncStreamStep_78F.41
AsyncStreamStep_78F:
        cmp dword [AsyncError], byte 0
        jle near .38
.32:
        mov ebx, dword [AsyncCurBuffer]
        cmp dword [dword ebx+097h], byte 0FFFFFFFFh
        jne short .34
        cmp dword [dword ebx+093h], byte 4
        jne short .33
        mov eax, dword [AsyncQueueHead]
        push eax
        call CdCloseFile
        add esp, byte 4
.33:
        mov edx, 0FFFFFFFFh
        mov eax, dword [AsyncCurBuffer]
        mov dword [AsyncQueueHead], edx
        mov edx, dword [AsyncFreeList]
        mov dword [dword eax+0A7h], edx
        mov ebx, 1
        mov dword [AsyncFreeList], eax
        mov dword [AsyncState], ebx
        jmp near .38
.34:
        mov eax, dword [AsyncSectorCount]
        mov edx, dword [AsyncDest]
        mov ebx, dword [AsyncBytesLeft]
        add edx, eax
        mov eax, dword [AsyncError]
        mov ecx, dword [AsyncFileHandle]
        add eax, ebx
        mov esi, dword [AsyncWaitTimer]
        cmp eax, ecx
        jl short .35
        mov ebp, dword [AsyncBytesLeft]
        xor eax, eax
        mov ebx, ecx
        mov dword [AsyncBytesLeft], eax
        sub ebx, ebp
        jmp short .36
.35:
        mov ebx, dword [AsyncError]
        add dword [AsyncBytesLeft], ebx
.36:
        push ebx
        push edx
        mov edi, dword [AsyncQueueHead]
        xor ecx, ecx
        push edi
        mov dword [AsyncTickCount], ecx
        call CdRead
        mov eax, dword [AsyncTickCount]
        mov ebp, dword [AsyncChunkSize]
        mov edx, dword [AsyncDest]
        mov ecx, dword [AsyncError]
        add esp, byte 0Ch
        mov dword [AsyncWaitTimer], esi
        add ebp, eax
        add edx, ebx
        mov eax, dword [AsyncChunkDest]
        sub ecx, ebx
        add eax, ebx
        mov dword [AsyncChunkSize], ebp
        mov dword [AsyncChunkDest], eax
        mov eax, dword [AsyncStreamBase]
        mov dword [AsyncDest], edx
        add esi, eax
        mov dword [AsyncError], ecx
        mov dword [AsyncWaitTimer], esi
        test esi, esi
        jle short .37
        test ecx, ecx
        jg short .42
.37:
        cmp dword [AsyncError], byte 0
        jg near .32
.38:
        mov eax, dword [AsyncCurBuffer]
        cmp dword [dword eax+093h], byte 4
        jne short .39
        mov esi, dword [AsyncQueueHead]
        push esi
        call CdCloseFile
        add esp, byte 4
.39:
        mov edi, 0FFFFFFFFh
        mov ebp, 1
        mov edx, dword [AsyncCurBuffer]
        mov eax, dword [AsyncSectorCount]
        mov dword [AsyncQueueHead], edi
        mov dword [dword edx+0A3h], eax
.40:
        mov dword [AsyncState], ebp
.41:
        cmp dword [AsyncWaitTimer], byte 0
        jle near AsyncStreamStep.1
.42:
        add esp, 94h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AsyncTick                                      10A788  97 PC, low confidence
; Counts down the async wait timer and counts the tick; followed by the
; request free-list helpers
;-----------------------------------------------------------------------------
AsyncTick:
        push ebx
        push edx
        mov edx, dword [AsyncWaitTimer]
        mov ebx, dword [AsyncTickCount]
        sub edx, byte 0Ah
        inc ebx
        mov dword [AsyncWaitTimer], edx
        mov dword [AsyncTickCount], ebx
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        mov ebx, dword [byte esp+08h]
        mov eax, dword [dword ebx+0A3h]
        test eax, eax
        je short .1
        mov edx, dword [AsyncFreeList]
        mov dword [AsyncFreeList], ebx
        mov dword [dword ebx+0A7h], edx
.1:
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; AsyncFreeRequest                               10A7D0  97 PC, low confidence
; Returns a finished async request to the free list; followed by the
; free-list initialiser
;-----------------------------------------------------------------------------
AsyncFreeRequest:
        mov edx, dword [byte esp+04h]
        mov eax, dword [dword edx+0A3h]
        test eax, eax
        je short .1
        mov eax, dword [AsyncFreeList]
        mov dword [AsyncFreeList], edx
        mov dword [dword edx+0A7h], eax
        mov eax, 1
.1:
        ret
        db 08Dh,040h,00h
        push ebx
        mov eax, dword [byte esp+08h]
        mov ebx, dword [byte esp+0Ch]
        mov dword [AsyncFreeList], eax
        dec ebx
        xor edx, edx
        test ebx, ebx
        jle short .3
.2:
        lea ecx, [dword eax+0ABh]
        inc edx
        mov dword [dword eax+0A7h], ecx
        mov eax, ecx
        cmp edx, ebx
        jl short .2
.3:
        mov dword [dword eax+0A7h], 0
        pop ebx
        ret
        mov edx, dword [byte esp+04h]
        mov eax, dword [AsyncFreeList]
        mov dword [AsyncFreeList], edx
        mov dword [dword edx+0A7h], eax
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AsyncPopRequest                                10A844  97 PC, low confidence
; Takes the next request off the async free list
;-----------------------------------------------------------------------------
AsyncPopRequest:
        mov eax, dword [AsyncFreeList]
        mov edx, dword [dword eax+0A7h]
        mov dword [AsyncFreeList], edx
        ret
