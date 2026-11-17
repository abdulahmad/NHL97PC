; Speech queue: requests, clips and banks.
bits 32
%include "hockey.inc"
section s_4254E progbits alloc exec nowrite align=1
extern __CHK, AllocMemBlock, DosCloseFile, DosOpenReadOnly, DosReadFile, FileClose, FileCreate, FileReadRecord
extern FileSeek, FileSizePath, FileWriteRecord, FreeMemBlock, GameSoundsOn, MakeDataPath, OpenResourceArchive, PushSpeechRing
extern RingBufferSpace, ServiceIdle, ShowLoadingBar, SpeechBankBuffer, SpeechBankHandle, SpeechBanksLoaded, SpeechClipIndex, SpeechClipTable
extern SpeechQueueClipId, SpeechQueueDelay, SpeechQueuePrio, SpeechQueuePriority, SpeechQueueRead, SpeechQueueSize, SpeechQueueStage, SpeechQueueTime
extern SpeechQueueWrite, SpeechReqHead, SpeechReqTail, SpeechRequestA, SpeechRequestB, SpeechRequestId, SpeechRequests, SpeechRingCount
extern sprintf_, str_CBANK03dDAT, str_KTSF, str_SAUDPBP2VIV, str_SAUDPBP3TSF, str_TEAM04dDAT, str_TEMP, tickcount
extern ZeroMem
global QueueSpeechRequest, ResetSpeechQueue, ServiceSpeechQueue, FindSpeechClip, LoadSpeechBlock, IsClipLoaded, LoadSpeechClips, LoadClipIfMissing
global SpeechFileHeader, OpenSpeechBanks, ResolveSpeechClips, LoadTeamSpeech
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueueSpeechRequest                              42550  97 PC, low confidence
; Adds a speech clip request to the 16-entry speech queue
;-----------------------------------------------------------------------------
QueueSpeechRequest:
        push ebx
        push ecx
        push esi
        push edi
        mov esi, eax
        mov ebx, edx
        mov ecx, dword [SpeechRequestId]
        sar ecx, 10h
        lea edx, [byte ecx+01h]
        mov edi, 10h
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        mov eax, dword [SpeechRequestB]
        sar eax, 10h
        cmp edx, eax
        je short .1
        cmp ebx, 8000h
        jge short .1
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        mov dword [nosplit eax*4+SpeechReqHead], esi
        mov dword [nosplit eax*4+SpeechReqTail], ebx
        xor ebx, ebx
        mov ecx, dword [SpeechQueueSize]
        mov dword [nosplit eax*4+SpeechRequests], ebx
        mov eax, 1
        add ecx, eax
        mov word [SpeechRequestA], dx
        mov dword [SpeechQueueSize], ecx
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.1:
        xor eax, eax
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ResetSpeechQueue                                425CC  97 PC, low confidence
; Clears the speech queue and the speech buffers
;-----------------------------------------------------------------------------
ResetSpeechQueue:
        push dword 18h
        call __CHK
        push ebx
        push ecx
        push edx
        push dword 0C0h
        xor edx, edx
        mov ebx, 8000h
        mov dword [SpeechQueueSize], edx
        xor edx, edx
        push SpeechReqHead
        mov word [SpeechRequestA], dx
        mov word [SpeechQueuePrio], dx
        mov word [SpeechRequestB], dx
        call ZeroMem
        mov eax, dword [SpeechBanksLoaded]
        add esp, byte 8
        mov dword [SpeechQueueTime], ebx
        xor ecx, ecx
        xor edx, edx
        mov dword [SpeechQueueClipId], eax
        mov dword [SpeechQueueStage], eax
        mov dword [SpeechQueueDelay], eax
        mov eax, dword [GameSoundsOn]
        mov dword [SpeechQueuePriority], ecx
        call FileSeek
        mov dword [SpeechQueueWrite], ecx
        mov dword [SpeechQueueRead], ecx
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ServiceSpeechQueue                              42650  97 PC, low confidence
; Reads the next queued speech clip from the speech file and plays it
;-----------------------------------------------------------------------------
ServiceSpeechQueue:
        push dword 1Ch
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp dword [SpeechQueueSize], byte 0
        je near .10
        cmp dword [SpeechQueueRead], byte 0
        jne near .3
        mov dx, word [SpeechRequestA]
        cmp dx, word [SpeechRequestB]
        je near .3
        mov ecx, dword [SpeechQueueDelay]
        mov eax, dword [SpeechQueueStage]
        cmp eax, ecx
        jge short .1
        mov edx, ecx
        sub edx, eax
        jmp short .2
.1:
        mov edx, dword [SpeechQueueTime]
        mov eax, dword [SpeechQueueClipId]
        mov esi, dword [SpeechQueueStage]
        add edx, eax
        sub ecx, eax
        sub edx, esi
        mov eax, ecx
        cmp edx, ecx
        jge short .2
        mov edx, ecx
.2:
        mov ecx, dword [SpeechRequestA]
        sar ecx, 10h
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        shl eax, 2
        mov ebp, dword [dword eax+SpeechReqTail]
        cmp edx, ebp
        jl short .3
        mov eax, SpeechQueueClipId
        mov edx, ebp
        call RingBufferSpace
        mov ecx, dword [SpeechRequestA]
        sar ecx, 10h
        mov edx, eax
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        shl eax, 2
        mov dword [dword eax+SpeechRequests], edx
        test edx, edx
        je short .3
        mov eax, dword [dword eax+SpeechReqTail]
        mov dword [SpeechQueueRead], eax
.3:
        mov ebx, dword [SpeechQueueRead]
        test ebx, ebx
        jle near .7
        mov edx, dword [SpeechRequestA]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        lea edx, [nosplit eax*4+00h]
        mov eax, dword [dword edx+SpeechReqHead]
        add eax, dword [dword edx+SpeechReqTail]
        mov edi, dword [SpeechQueueWrite]
        sub eax, ebx
        cmp eax, edi
        je short .4
        mov ecx, dword [GameSoundsOn]
        mov edx, eax
        mov eax, ecx
        call FileSeek
        mov edx, dword [SpeechRequestA]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        lea edx, [nosplit eax*4+00h]
        mov eax, dword [dword edx+SpeechReqHead]
        mov ebx, dword [dword edx+SpeechReqTail]
        lea edx, [eax+ebx]
        mov eax, dword [SpeechQueueRead]
        sub edx, eax
        mov dword [SpeechQueueWrite], edx
        jmp near .7
.4:
        cmp ebx, 800h
        jle short .5
        mov ecx, 800h
        jmp short .6
.5:
        mov ecx, ebx
.6:
        mov edx, dword [SpeechRequestA]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        lea edx, [nosplit eax*4+00h]
        mov ebx, dword [SpeechQueueRead]
        mov eax, dword [dword edx+SpeechReqTail]
        mov edx, dword [dword edx+SpeechRequests]
        sub eax, ebx
        mov ebx, ecx
        add edx, eax
        mov eax, dword [GameSoundsOn]
        call FileReadRecord
        mov esi, dword [SpeechQueueWrite]
        add esi, ecx
        mov edi, dword [SpeechQueueRead]
        mov dword [SpeechQueueWrite], esi
        sub edi, ecx
        mov dword [SpeechQueueRead], edi
        jne short .7
        mov edx, dword [SpeechRequestA]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, dword [nosplit eax*4+SpeechReqTail]
        mov eax, dword [nosplit eax*4+SpeechRequests]
        call PushSpeechRing
        mov edx, dword [SpeechRequestA]
        sar edx, 10h
        inc edx
        mov ecx, 10h
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov word [SpeechRequestB], dx
.7:
        mov bx, word [SpeechRequestB]
        cmp bx, word [SpeechQueuePrio]
        je near .10
        mov edx, dword [SpeechRequestB]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov eax, dword [nosplit eax*4+SpeechRequests]
        call SpeechRingCount
        test eax, eax
        jne near .10
        mov edx, dword [SpeechRequestB]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, dword [nosplit eax*4+SpeechRequests]
        mov eax, dword [nosplit eax*4+SpeechReqTail]
        add edx, eax
        mov ecx, dword [SpeechQueueStage]
        mov dword [SpeechQueueDelay], edx
        cmp edx, ecx
        jne short .8
        mov eax, dword [SpeechQueueClipId]
        mov dword [SpeechQueueStage], eax
        mov dword [SpeechQueueDelay], eax
        jmp short .9
.8:
        cmp edx, dword [SpeechQueuePriority]
        jne short .9
        mov eax, dword [SpeechQueueClipId]
        xor edi, edi
        mov dword [SpeechQueueDelay], eax
        mov dword [SpeechQueuePriority], edi
.9:
        mov edx, dword [SpeechRequestB]
        sar edx, 10h
        inc edx
        mov ecx, 10h
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        dec dword [SpeechQueueSize]
        mov word [SpeechQueuePrio], dx
.10:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FindSpeechClip                                  42910  97 PC, low confidence
; Binary search of a clip number in the speech directory; returns its index,
; -1 if missing
;-----------------------------------------------------------------------------
FindSpeechClip:
        push dword 18h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov esi, eax
        test eax, eax
        jl short .4
        mov edx, dword [SpeechClipIndex]
        xor ebx, ebx
        test edx, edx
        je short .4
.1:
        lea eax, [ebx+edx]
        sar eax, 1
        imul edi, eax, byte 0Eh
        mov ecx, dword [SpeechBankBuffer]
        add ecx, edi
        mov edi, dword [ecx]
        cmp esi, edi
        je short .5
        jbe short .2
        lea ebx, [byte eax+01h]
        jmp short .3
.2:
        mov edx, eax
.3:
        cmp ebx, edx
        jne short .1
.4:
        mov eax, 0FFFFFFFFh
.5:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LoadSpeechBlock                                 42960  97 PC, low confidence
; Reads a block of speech clips into a work buffer ("TEMP")
;-----------------------------------------------------------------------------
LoadSpeechBlock:
        push dword 38h
        call __CHK
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov dword [byte esp+0Ch], edx
        mov esi, esp
        push esi
        lea esi, [byte esp+08h]
        push esi
        lea esi, [byte esp+010h]
        push esi
        push eax
        call DosOpenReadOnly
        add esp, byte 10h
        cmp dword [byte esp+08h], byte 0
        jne short .1
        cmp dword [byte esp+04h], byte 0
        jne short .1
        cmp dword [esp], byte 0
        jne short .1
        xor eax, eax
        jmp near .8
.1:
        push byte 20h
        push dword 2000h
        push str_TEMP
        xor esi, esi
        call AllocMemBlock
        add esp, byte 0Ch
        mov ebp, eax
        mov edi, dword [esp]
        mov dword [byte esp+04h], esi
        test edi, edi
        jle near .7
.2:
        mov esi, dword [esp]
        cmp esi, 2000h
        jle short .3
        mov edi, 2000h
        jmp short .4
.3:
        mov edi, esi
.4:
        mov eax, dword [tickcount]
        push edi
        lea esi, [byte eax+02h]
        push ebp
        mov eax, dword [byte esp+010h]
        push eax
        call DosReadFile
        add esp, byte 0Ch
        test eax, eax
        jne short .5
        mov ebx, dword [byte esp+08h]
        push ebx
        call DosCloseFile
        add esp, byte 4
        push ebp
        call FreeMemBlock
        add esp, byte 4
        xor eax, eax
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.5:
        mov eax, dword [byte esp+0Ch]
        mov ebx, edi
        mov edx, ebp
        call FileWriteRecord
        test eax, eax
        jne short .6
        mov edx, dword [byte esp+08h]
        push edx
        call DosCloseFile
        add esp, byte 4
        push ebp
        call FreeMemBlock
        add esp, byte 4
        xor eax, eax
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.6:
        mov eax, dword [tickcount]
        cmp eax, esi
        jl short .6
        mov eax, dword [esp]
        mov edx, dword [byte esp+04h]
        sub eax, edi
        add edx, edi
        mov dword [esp], eax
        mov dword [byte esp+04h], edx
        test eax, eax
        jg near .2
.7:
        mov ecx, dword [byte esp+08h]
        push ecx
        call DosCloseFile
        add esp, byte 4
        push ebp
        call FreeMemBlock
        add esp, byte 4
        mov eax, dword [byte esp+04h]
.8:
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; IsClipLoaded                                    42A98  97 PC, low confidence
; Whether a speech clip is in memory; returns 1 if so
;-----------------------------------------------------------------------------
IsClipLoaded:
        push dword 0Ch
        call __CHK
        push ebx
        push edx
        mov ebx, eax
        mov edx, dword [SpeechClipTable]
        xor eax, eax
.1:
        cmp ebx, dword [dword edx+eax+057Eh]
        jg short .2
        mov eax, 1
        pop edx
        pop ebx
        ret
.2:
        add eax, byte 8
        cmp eax, 2A0h
        jl short .1
        xor eax, eax
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LoadSpeechClips                                 42AD0  97 PC, low confidence
; Loads the speech clips of a bank into memory
;-----------------------------------------------------------------------------
LoadSpeechClips:
        push dword 24h
        call __CHK
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov dword [byte esp+08h], eax
        mov dword [byte esp+04h], edx
        mov ebx, dword [byte esp+04h]
        mov ebp, 54h
        add eax, ebx
        xor edx, edx
        mov dword [esp], eax
.1:
        mov eax, dword [SpeechClipTable]
        lea edi, [nosplit edx*8+00h]
        add eax, edi
        mov ecx, dword [dword eax+057Eh]
        test ecx, ecx
        jle near .5
        mov esi, dword [esp]
        mov ebx, dword [dword eax+057Ah]
        cmp ebx, esi
        jne short .2
        mov edx, dword [byte esp+08h]
        mov dword [dword eax+057Ah], edx
        mov eax, dword [SpeechClipTable]
        add edi, eax
        mov eax, dword [byte esp+04h]
        mov ecx, dword [dword edi+057Eh]
        add ecx, eax
        mov edx, ebp
        mov dword [dword edi+057Eh], ecx
        jmp near .5
.2:
        mov esi, dword [byte esp+08h]
        add ebx, ecx
        cmp ebx, esi
        jne near .5
        mov edx, dword [byte esp+04h]
        lea ebx, [ecx+edx]
        mov dword [dword eax+057Eh], ebx
        xor eax, eax
.3:
        mov edx, dword [SpeechClipTable]
        lea esi, [nosplit eax*8+00h]
        lea ebx, [edx+esi]
        cmp dword [dword ebx+057Eh], byte 0
        jle short .4
        add edx, edi
        mov ecx, dword [dword edx+057Ah]
        add ecx, dword [dword edx+057Eh]
        cmp ecx, dword [dword ebx+057Ah]
        jne short .4
        mov ebx, ecx
        add dword [dword edx+057Eh], ebx
        mov edx, dword [SpeechClipTable]
        mov dword [dword edx+esi+057Eh], 0
        mov edx, dword [SpeechClipTable]
        mov ebx, dword [dword edx+0576h]
        sar ebx, 10h
        mov dword [dword edx+esi+057Ah], ebx
        mov edx, dword [SpeechClipTable]
        mov word [dword edx+0578h], ax
        mov eax, ebp
.4:
        inc eax
        cmp eax, byte 54h
        jl short .3
        mov edx, ebp
.5:
        inc edx
        cmp edx, byte 54h
        jl near .1
        jne short .6
        mov edx, dword [SpeechClipTable]
        mov eax, dword [dword edx+0576h]
        sar eax, 10h
        shl eax, 3
        mov bx, word [dword edx+eax+057Ah]
        mov word [dword edx+0578h], bx
        mov edx, dword [SpeechClipTable]
        mov ebx, dword [byte esp+08h]
        mov dword [dword edx+eax+057Ah], ebx
        mov edx, dword [SpeechClipTable]
        add eax, edx
        mov edx, dword [byte esp+04h]
        mov dword [dword eax+057Eh], edx
.6:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadClipIfMissing                               42C38  97 PC, low confidence
; Loads a speech clip unless it is already in memory
;-----------------------------------------------------------------------------
LoadClipIfMissing:
        push dword 20h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov dword [esp], eax
        mov edx, dword [SpeechClipTable]
        mov ebx, eax
        xor eax, eax
.1:
        cmp ebx, dword [dword edx+eax+057Eh]
        jg short .2
        mov eax, 1
        jmp short .3
.2:
        add eax, byte 8
        cmp eax, 2A0h
        jl short .1
        xor eax, eax
.3:
        test eax, eax
        jne short .4
        mov eax, 0FFFFFFFFh
        jmp near .10
.4:
        mov ebx, 0FFFFFFFFh
        mov esi, dword [SpeechClipTable]
        xor ecx, ecx
        xor eax, eax
.5:
        lea edi, [nosplit ebx*8+00h]
        cmp eax, byte 54h
        jge short .8
        lea edx, [ecx+esi]
        mov ebp, dword [dword edx+057Eh]
        test ebp, ebp
        jle short .7
        cmp ebp, dword [esp]
        jl short .7
        cmp ebx, byte 0FFFFFFFFh
        je short .6
        mov edx, ebp
        cmp edx, dword [dword edi+esi+057Eh]
        jge short .7
.6:
        mov ebx, eax
.7:
        inc eax
        add ecx, byte 8
        jmp short .5
.8:
        cmp ebx, byte 0FFFFFFFFh
        jne short .9
        mov eax, ebx
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov edx, dword [SpeechClipTable]
        mov ecx, dword [esp]
        mov eax, dword [dword edx+edi+057Ah]
        add ecx, eax
        mov dword [dword edx+edi+057Ah], ecx
        mov edx, dword [SpeechClipTable]
        mov ecx, dword [esp]
        sub dword [dword edx+edi+057Eh], ecx
        mov edx, dword [SpeechClipTable]
        add edi, edx
        cmp dword [dword edi+057Eh], byte 0
        jne short .10
        mov edx, dword [dword edx+0576h]
        sar edx, 10h
        mov dword [dword edi+057Ah], edx
        mov edx, dword [SpeechClipTable]
        mov word [dword edx+0578h], bx
.10:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SpeechFileHeader                                42D38  97 PC, low confidence
; Returns the speech file's header size and id
;-----------------------------------------------------------------------------
SpeechFileHeader:
        push dword 4
        call __CHK
        mov dword [eax], 0CCh
        mov eax, 0F23056h
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; OpenSpeechBanks                                 42D50  96 PC, low confidence
; Opens the play-by-play speech files (%sAUDPBP3.TSF, KTSF, %sAUDPBP2.VIV,
; CBANK%03d.DAT)
;-----------------------------------------------------------------------------
OpenSpeechBanks:
        push dword 128h
        call __CHK
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 108h
        mov edi, eax
        mov dword [dword esp+0104h], ebx
        push edx
        push str_SAUDPBP3TSF
        lea eax, [dword esp+080h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov edx, SpeechBankHandle
        call ServiceIdle
        lea eax, [byte esp+078h]
        xor esi, esi
        call FileCreate
        test eax, eax
        je near .22
        mov ebx, 4
        mov edx, str_KTSF
        mov eax, dword [SpeechBankHandle]
        call FileWriteRecord
        test eax, eax
        jne short .1
        mov eax, SpeechBankHandle
        call FileClose
        xor eax, eax
        jmp near .22
.1:
        mov edx, 81Ah
        mov ebx, 4
        mov eax, dword [SpeechBankHandle]
        mov dword [dword esp+0100h], edx
        lea edx, [dword esp+0100h]
        call FileWriteRecord
        test eax, eax
        jne short .2
        mov eax, SpeechBankHandle
        call FileClose
        xor eax, eax
        add esp, 108h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.2:
        mov ebx, 0AFh
        lea edx, [dword esp+0100h]
        mov eax, dword [SpeechBankHandle]
        mov dword [dword esp+0100h], ebx
        mov ebx, 4
        call FileWriteRecord
        test eax, eax
        jne short .3
        mov eax, SpeechBankHandle
        call FileClose
        xor eax, eax
        add esp, 108h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.3:
        call ServiceIdle
        push dword 81Ah
        mov ecx, dword [SpeechClipTable]
        push ecx
        call ZeroMem
        mov eax, dword [SpeechClipTable]
        mov word [dword eax+02D4h], 0
        mov eax, dword [SpeechClipTable]
        add esp, byte 8
        mov word [dword eax+02D6h], 0
        mov dword [dword esp+0100h], esi
        mov ebx, 0FFFFFFFFh
.4:
        imul edx, dword [dword esp+0100h], byte 0Ch
        mov eax, dword [SpeechClipTable]
        mov dword [dword edx+eax+02D8h], ebx
        mov ebp, dword [dword esp+0100h]
        imul eax, ebp, byte 0Ch
        cmp ebp, byte 37h
        jge short .5
        mov edx, dword [dword esp+0100h]
        mov ecx, dword [SpeechClipTable]
        inc edx
        mov word [dword ecx+eax+02DCh], dx
        jmp short .6
.5:
        mov edx, dword [SpeechClipTable]
        mov word [dword edx+eax+02DCh], bx
.6:
        imul eax, dword [dword esp+0100h], byte 0Ch
        mov edx, dword [SpeechClipTable]
        mov dword [dword edx+eax+02E0h], 0
        mov ebp, dword [dword esp+0100h]
        inc ebp
        mov dword [dword esp+0100h], ebp
        cmp ebp, byte 38h
        jl short .4
        mov eax, dword [SpeechClipTable]
        xor edx, edx
        mov word [dword eax+0578h], 0
        mov dword [dword esp+0100h], edx
.7:
        mov eax, dword [dword esp+0100h]
        mov ebx, dword [dword esp+0100h]
        shl eax, 3
        cmp ebx, byte 53h
        jge short .8
        mov edx, dword [SpeechClipTable]
        add edx, eax
        lea eax, [byte ebx+01h]
        mov dword [dword edx+057Ah], eax
        jmp short .9
.8:
        mov edx, dword [SpeechClipTable]
        mov dword [dword edx+eax+057Ah], 0FFFFFFFFh
.9:
        mov edx, dword [dword esp+0100h]
        mov eax, dword [SpeechClipTable]
        mov dword [dword eax+edx*8+057Eh], 0
        mov ecx, dword [dword esp+0100h]
        inc ecx
        mov dword [dword esp+0100h], ecx
        cmp ecx, byte 54h
        jl short .7
        call ServiceIdle
        mov ebx, 81Ah
        mov edx, dword [SpeechClipTable]
        mov eax, dword [SpeechBankHandle]
        call FileWriteRecord
        test eax, eax
        jne short .10
        mov eax, SpeechBankHandle
        call FileClose
        xor eax, eax
        add esp, 108h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.10:
        call ServiceIdle
        cmp dword [dword esp+0104h], byte 0
        je short .11
        inc esi
        mov eax, esi
        call dword [dword esp+0104h]
.11:
        push edi
        push str_SAUDPBP2VIV
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        call OpenResourceArchive
        add esp, byte 4
        xor edx, edx
        mov edi, 826h
        mov dword [dword esp+0100h], edx
        mov ebp, dword [dword esp+0104h]
        xor ecx, ecx
.12:
        mov edx, dword [dword esp+0100h]
        mov eax, dword [SpeechClipTable]
        mov dword [eax+edx*4], edi
        mov ebx, dword [dword esp+0100h]
        push ebx
        push str_CBANK03dDAT
        lea eax, [dword esp+0F8h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        call ServiceIdle
        lea eax, [dword esp+0F0h]
        mov edx, dword [SpeechBankHandle]
        call LoadSpeechBlock
        mov edx, eax
        cmp ecx, ebp
        je short .13
        inc esi
        mov eax, esi
        call dword [dword esp+0104h]
.13:
        call ServiceIdle
        test edx, edx
        jne short .14
        mov eax, SpeechBankHandle
        call FileClose
        xor eax, eax
        add esp, 108h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.14:
        mov eax, dword [dword esp+0100h]
        inc eax
        add edi, edx
        mov dword [dword esp+0100h], eax
        cmp eax, 0AFh
        jl near .12
        push byte 20h
        push dword 20000h
        push str_TEMP
        call AllocMemBlock
        add esp, byte 0Ch
        push dword 20000h
        push eax
        mov ebx, 3405C0h
        mov ebp, eax
        call ZeroMem
        add esp, byte 8
        mov dword [dword esp+0100h], ebx
.15:
        mov ecx, dword [dword esp+0100h]
        cmp ecx, 20000h
        jle short .16
        mov ecx, 20000h
.16:
        call ServiceIdle
        cmp dword [dword esp+0104h], byte 0
        je short .17
        inc esi
        mov eax, esi
        call dword [dword esp+0104h]
.17:
        mov eax, dword [SpeechBankHandle]
        mov ebx, ecx
        mov edx, ebp
        call FileWriteRecord
        test eax, eax
        jne short .18
        mov eax, SpeechBankHandle
        call FileClose
        xor eax, eax
        add esp, 108h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.18:
        mov edx, dword [dword esp+0100h]
        sub edx, ecx
        mov dword [dword esp+0100h], edx
        test edx, edx
        jg short .15
        push ebp
        call FreeMemBlock
        add esp, byte 4
        mov edx, 3405C0h
        mov eax, edi
        call LoadSpeechClips
        mov eax, dword [SpeechClipTable]
        mov dword [dword eax+02C8h], 0FFFFFFFFh
        mov edx, dword [SpeechClipTable]
        mov eax, dword [dword eax+02C8h]
        mov dword [dword edx+02BCh], eax
        call ServiceIdle
        mov edx, 0Ch
        mov eax, dword [SpeechBankHandle]
        call FileSeek
        test eax, eax
        jne short .19
        mov eax, SpeechBankHandle
        call FileClose
        xor eax, eax
        add esp, 108h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.19:
        mov ebx, 81Ah
        mov edx, dword [SpeechClipTable]
        mov eax, dword [SpeechBankHandle]
        call FileWriteRecord
        test eax, eax
        jne short .20
        mov eax, SpeechBankHandle
        call FileClose
        xor eax, eax
        add esp, 108h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.20:
        cmp dword [dword esp+0104h], byte 0
        je short .21
        lea eax, [byte esi+01h]
        call dword [dword esp+0104h]
.21:
        mov eax, SpeechBankHandle
        call FileClose
        mov eax, 1
.22:
        add esp, 108h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ResolveSpeechClips                              431E8  97 PC, low confidence
; Looks up the directory entry of each clip a bank uses
;-----------------------------------------------------------------------------
ResolveSpeechClips:
        push dword 10h
        call __CHK
        push ebx
        push ecx
        push edx
        xor ebx, ebx
        xor ecx, ecx
        jmp near .3
.1:
        add eax, ebx
        mov edx, dword [dword eax+02D8h]
        test edx, edx
        jl short .2
        mov eax, edx
        call FindSpeechClip
        test eax, eax
        jge short .2
        mov eax, dword [SpeechClipTable]
        mov edx, dword [dword ebx+eax+02E0h]
        mov eax, dword [dword ebx+eax+02DCh]
        call LoadSpeechClips
        mov eax, dword [SpeechClipTable]
        mov dword [dword ebx+eax+02D8h], 0FFFFFFFFh
        mov eax, dword [SpeechClipTable]
        add ebx, eax
        mov ax, word [dword eax+02D6h]
        mov word [dword ebx+02DCh], ax
        mov eax, dword [SpeechClipTable]
        mov word [dword eax+02D6h], cx
        mov edx, dword [SpeechClipTable]
        mov bx, word [dword edx+02D4h]
        dec ebx
        mov eax, ecx
        mov word [dword edx+02D4h], bx
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        inc ecx
        add ebx, byte 0Ch
.3:
        mov eax, dword [SpeechClipTable]
        mov edx, dword [dword eax+02D2h]
        sar edx, 10h
        cmp ecx, edx
        jl near .1
        mov eax, 0FFFFFFFFh
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadTeamSpeech                                  4329C  97 PC, low confidence
; (team, other): loads the team name speech file TEAM%04d.DAT when it is not
; loaded
;-----------------------------------------------------------------------------
LoadTeamSpeech:
        push dword 9Ch
        call __CHK
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 78h
        mov ebx, eax
        mov esi, edx
        mov eax, dword [SpeechClipTable]
        mov edx, dword [dword eax+02BCh]
        test edx, edx
        jl short .1
        cmp ebx, edx
        je short .1
        cmp esi, edx
        je short .1
        mov edx, dword [dword eax+02C4h]
        mov eax, dword [dword eax+02C0h]
        call LoadSpeechClips
        mov eax, dword [SpeechClipTable]
        mov dword [dword eax+02BCh], 0FFFFFFFFh
        mov eax, dword [SpeechClipTable]
        mov edx, dword [dword eax+02C8h]
        cmp edx, dword [dword eax+02BCh]
        jne short .1
        mov dword [dword eax+02C8h], 0FFFFFFFFh
.1:
        mov eax, dword [SpeechClipTable]
        mov edx, dword [dword eax+02C8h]
        test edx, edx
        jl short .2
        cmp ebx, edx
        je short .2
        cmp esi, edx
        je short .2
        mov edx, dword [dword eax+02D0h]
        mov eax, dword [dword eax+02CCh]
        call LoadSpeechClips
        mov eax, dword [SpeechClipTable]
        mov dword [dword eax+02C8h], 0FFFFFFFFh
.2:
        mov edx, 57h
        mov eax, esp
        call MakeDataPath
        mov eax, esp
        push eax
        call OpenResourceArchive
        add esp, byte 4
        push ebx
        push str_TEAM04dDAT
        lea eax, [byte esp+070h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+068h]
        push eax
        call FileSizePath
        add esp, byte 4
        mov ecx, eax
        test eax, eax
        jg short .3
        push byte 0
        jmp near .23
.3:
        mov edx, dword [SpeechClipTable]
        mov ebp, dword [dword edx+02BCh]
        mov dword [byte esp+050h], ebx
        cmp ebx, ebp
        jne short .4
        mov eax, dword [dword edx+02C0h]
        mov dword [byte esp+054h], eax
        mov eax, dword [dword edx+02C4h]
        jmp near .12
.4:
        cmp ebx, dword [dword edx+02C8h]
        jne short .5
        mov eax, dword [dword edx+02CCh]
        mov dword [byte esp+054h], eax
        mov eax, dword [dword edx+02D0h]
        jmp near .12
.5:
        mov ebx, ecx
.6:
        mov edx, dword [SpeechClipTable]
        xor eax, eax
.7:
        cmp ebx, dword [dword edx+eax+057Eh]
        jg short .8
        mov eax, 1
        jmp short .9
.8:
        add eax, byte 8
        cmp eax, 2A0h
        jl short .7
        xor eax, eax
.9:
        test eax, eax
        jne short .10
        call ResolveSpeechClips
        jmp short .6
.10:
        mov eax, ecx
        call LoadClipIfMissing
        mov ebx, dword [SpeechBankHandle]
        mov dword [byte esp+054h], eax
        mov edx, eax
        mov eax, ebx
        call FileSeek
        test eax, eax
        jne short .11
        push eax
        call OpenResourceArchive
        add esp, byte 4
        add esp, byte 78h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.11:
        lea eax, [byte esp+068h]
        mov edx, dword [SpeechBankHandle]
        call LoadSpeechBlock
.12:
        mov dword [byte esp+058h], eax
        mov eax, 19h
        call ShowLoadingBar
        push esi
        push str_TEAM04dDAT
        lea eax, [byte esp+070h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+068h]
        push eax
        call FileSizePath
        add esp, byte 4
        mov ecx, eax
        test eax, eax
        jg short .13
        push byte 0
        call OpenResourceArchive
        add esp, byte 4
        add esp, byte 78h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.13:
        mov edx, dword [SpeechClipTable]
        mov ebx, dword [dword edx+02BCh]
        mov dword [byte esp+05Ch], esi
        cmp esi, ebx
        jne short .14
        mov eax, dword [dword edx+02C0h]
        mov dword [byte esp+060h], eax
        mov eax, dword [dword edx+02C4h]
        jmp near .22
.14:
        mov edi, dword [dword edx+02C8h]
        cmp esi, edi
        jne short .15
        mov eax, dword [dword edx+02CCh]
        mov dword [byte esp+060h], eax
        mov eax, dword [dword edx+02D0h]
        jmp near .22
.15:
        mov ebx, ecx
        xor ebp, ebp
.16:
        mov edx, dword [SpeechClipTable]
        mov eax, ebp
.17:
        cmp ebx, dword [dword edx+eax+057Eh]
        jg short .18
        mov eax, 1
        jmp short .19
.18:
        add eax, byte 8
        cmp eax, 2A0h
        jl short .17
        mov eax, ebp
.19:
        test eax, eax
        jne short .20
        call ResolveSpeechClips
        jmp short .16
.20:
        mov eax, ecx
        call LoadClipIfMissing
        mov ebx, dword [SpeechBankHandle]
        mov dword [byte esp+060h], eax
        mov edx, eax
        mov eax, ebx
        call FileSeek
        test eax, eax
        jne short .21
        push eax
        call OpenResourceArchive
        add esp, byte 4
        add esp, byte 78h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.21:
        lea eax, [byte esp+068h]
        mov edx, dword [SpeechBankHandle]
        call LoadSpeechBlock
.22:
        mov dword [byte esp+064h], eax
        mov esi, dword [SpeechClipTable]
        lea edi, [dword esi+02BCh]
        lea esi, [byte esp+050h]
        movsd
        movsd
        movsd
        mov esi, dword [SpeechClipTable]
        lea edi, [dword esi+02C8h]
        lea esi, [byte esp+05Ch]
        push byte 0
        movsd
        movsd
        movsd
.23:
        call OpenResourceArchive
        add esp, byte 4
        add esp, byte 78h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
