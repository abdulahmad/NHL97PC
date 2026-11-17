; Instant replay: recording, playing, saving and loading frames.
bits 32
%include "hockey.inc"
section s_5B961 progbits alloc exec nowrite align=1
extern AllocMemBlock, AllocMemData, AnimStatesReady, AutoLineData, AwScore, AwTeamData, awtmstruct, BenchPlayerTable
extern CameraScenesEnabled, ChangeViewSize, ClearOverlayWindows, ClockDataTicks, DrawGameFrame, DrawGameOverlays, FaceTextureCount, FreeMemBlock
extern GameObjects, gameopts, GameSettings, GlobalSetVersion, gmode, HmScore, HmTeamData, hmtmstruct
extern homelines, HomeTeamRecord, InstantReplayEnd, InstantReplayOn, InstantReplayStart, IsCameraOnPuck, IsReplayRecordingOn, kaufmfont
extern memcpy_, MemFreeSizeAny, ObjectPositions, OpenFreeOverlay, PadStates, PaletteDirtyFlag, PlayerStartRecords, PtrPuckFlags
extern puckc, RedrawGameView, RefreshPlayerModel, RefreshRinkPalette, RefreshViewDistance, ReplayBuffer, ReplayBufferEnd, ReplayCameraStateCount
extern ReplayDrawn, ReplayFinalFrame, ReplayFrame, ReplayFrameCount, ReplayFrameMarker, ReplayFrames, ReplayFrameSize, ReplayFull
extern ReplayHeader, ReplayMode, ReplayObjectCount, ReplayObjects, ReplayObjectSizes, ReplayObjectsSet, ReplayPackBuf, ReplayPackPos
extern ReplayPlayerStateCount, ReplayPlaying, ReplayPuckStateCount, ReplayReadPos, ReplayRecordBuf, ReplayRecording, ReplayRestoreFuncs, ReplaySoundOn
extern ReplayStatesCamera, ReplayStateSize, ReplayStatesPlayers, ReplayStatesPuck, ReplayStatesSet, ReplayStateTotal, ReplayTick, ReplayUnpackPos
extern ReplayWritePos, ResetRenderTimers, ResetStreamAudio, RestartGameMusic, RunSimFrames, SavedCameraView, SelectCameraView, ServiceIdle
extern SetAnimClock, SetCameraMode, SetCrowdNoise, SetTeamColours, SetViewWindow, SortCords, SpriteBuffersOn, StartCameraPath
extern StatsPanelPlayer, StopAllSfx, str_REPLAY, str_RPGAME, tickcount, UpdateAllPoses, UpdateGameDisplay
global ReplayPackFrame, ReplayUnpackFrame, ReplayWriteFrame, ReplaySaveState, ReplayRestoreState, ReplayRecordFrame, ReplayRegisterStates, ReplayRegisterObjects
global FreeReplayBuffer, ResetReplayBuffer, InitReplayBuffer, IsReplayRecording, ReplayHasFrames, ReplayFreeFrames, SetReplayRecording, ReplayReadFrame
global ReplaySeekStart, ReplayStepFrame, ReplayRecordTick, ReplayRecordTick_29, ReplayPauseRecording, ReplayRecordFinal, ReplayRecordFinal_C, ReplaySoundAllowed
global ReplayDrawFrame, ReplayCmdPlay, ReplayCmdStop, ReplayCmdRewind, ReplayCmdForward, ReplayPlayFrames, ReplayCamFollow, ReplayCamFree
global StartInstantReplay, EndInstantReplay, PlaySavedReplay, ReplayFramesLeft, ReplayCurrentFrame, ReplayRestoreObjects, ReplaySetupObjects, SaveReplayHeader
global LoadReplayHeader, LoadReplayData, FreeReplayMem
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; ReplayPackFrame                                 5B970  97 PC, low confidence
; Packs one frame of object state into the replay buffer
;-----------------------------------------------------------------------------
ReplayPackFrame:
        push ecx
        push esi
        push edi
        mov ecx, eax
        mov edi, dword [ReplayPackPos]
        mov esi, dword [ReplayPackBuf]
        sub esi, edi
        cmp esi, eax
        jg short .1
        mov byte [edi], 1
        mov eax, dword [ReplayReadPos]
        mov esi, 1
        mov dword [ReplayPackPos], eax
        jmp short .3
.1:
        mov esi, dword [ReplayBufferEnd]
        cmp edi, dword [nosplit esi*4+ReplayObjects]
        jae short .2
        mov esi, 1
        jmp short .3
.2:
        xor esi, esi
.3:
        test ebx, ebx
        je short .4
        mov ebx, 4
        mov eax, dword [ReplayPackPos]
        jmp short .5
.4:
        mov eax, dword [ReplayPackPos]
        mov ebx, ecx
.5:
        call memcpy_
        mov eax, dword [ReplayPackPos]
        add eax, ecx
        mov dword [ReplayPackPos], eax
        test esi, esi
        je short .6
        mov edx, dword [ReplayBufferEnd]
        cmp eax, dword [nosplit edx*4+ReplayObjects]
        jb short .6
        inc edx
        mov ebx, 0Ah
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        dec dword [ReplayFull]
        mov dword [ReplayBufferEnd], edx
.6:
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplayUnpackFrame                               5BA0C  97 PC, low confidence
; Unpacks one replay frame into object state
;-----------------------------------------------------------------------------
ReplayUnpackFrame:
        push ebx
        push ecx
        mov ecx, eax
        mov eax, edx
        mov edx, dword [ReplayUnpackPos]
        cmp byte [edx], 1
        jne short .1
        mov edx, dword [ReplayReadPos]
        mov dword [ReplayUnpackPos], edx
.1:
        test eax, eax
        je short .2
        mov edx, dword [ReplayUnpackPos]
        mov ebx, ecx
        call memcpy_
.2:
        add dword [ReplayUnpackPos], ecx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplayWriteFrame                                5BA44  97 PC, low confidence
; Writes a packed frame at the replay write position
;-----------------------------------------------------------------------------
ReplayWriteFrame:
        push ebx
        push ecx
        push edx
        mov ecx, eax
.1:
        mov edx, dword [ReplayWritePos]
        mov eax, dword [ReplayRecordBuf]
        sub eax, edx
        cmp eax, 0FFFh
        jle short .2
        mov edx, ReplayFrameMarker
        mov eax, 4
        xor ebx, ebx
        call ReplayPackFrame
        add dword [ReplayWritePos], 0FFFh
        jmp short .1
.2:
        mov dx, word [ecx]
        xor dh, dh
        and dl, 0Fh
        and eax, 0FFFh
        mov word [ecx], dx
        shl eax, 4
        or dword [ecx], eax
        mov eax, dword [ReplayRecordBuf]
        mov dword [ReplayWritePos], eax
        mov ah, byte [ecx]
        xor ebx, ebx
        test ah, 0Fh
        sete bl
        mov eax, dword [ecx]
        mov edx, ecx
        shr eax, 10h
        call ReplayPackFrame
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplaySaveState                                 5BAB4  97 PC, low confidence
; Saves the registered state blocks for the replay
;-----------------------------------------------------------------------------
ReplaySaveState:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov esi, edx
        test eax, eax
        je short .1
        mov ecx, ReplayStatesPuck
        jmp short .2
.1:
        mov ecx, ReplayStatesCamera
.2:
        mov edx, dword [ReplayStateSize]
        xor edi, edi
        test edx, edx
        jle short .5
.3:
        mov eax, dword [ecx]
        lea edx, [nosplit edi*4+00h]
        test eax, eax
        je short .4
        mov ebx, eax
        mov edx, dword [dword edx+ReplayStatesPlayers]
        mov eax, esi
        call memcpy_
.4:
        mov ebp, dword [ReplayStateSize]
        mov ebx, dword [ecx]
        add ecx, byte 4
        inc edi
        add esi, ebx
        cmp edi, ebp
        jl short .3
.5:
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplayRestoreState                              5BB0C  97 PC, low confidence
; Restores the registered state blocks from the replay
;-----------------------------------------------------------------------------
ReplayRestoreState:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov esi, edx
        test eax, eax
        je short .1
        mov ecx, ReplayStatesPuck
        jmp short .2
.1:
        mov ecx, ReplayStatesCamera
.2:
        mov edx, dword [ReplayStateSize]
        xor edi, edi
        test edx, edx
        jle short .5
.3:
        mov edx, dword [ecx]
        lea eax, [nosplit edi*4+00h]
        test edx, edx
        je short .4
        mov ebx, edx
        mov eax, dword [dword eax+ReplayStatesPlayers]
        mov edx, esi
        call memcpy_
.4:
        mov ebp, dword [ReplayStateSize]
        mov ebx, dword [ecx]
        add ecx, byte 4
        inc edi
        add esi, ebx
        cmp edi, ebp
        jl short .3
.5:
        mov eax, dword [ReplayObjectsSet]
        xor edx, edx
        test eax, eax
        jle short .7
        xor ecx, ecx
.6:
        mov eax, ecx
        inc edx
        call dword [dword eax+ReplayRestoreFuncs]
        mov ebx, dword [ReplayObjectsSet]
        add ecx, byte 4
        cmp edx, ebx
        jl short .6
.7:
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ReplayRecordFrame                               5BB88  97 PC, low confidence
; Records the current frame into the replay buffer
;-----------------------------------------------------------------------------
ReplayRecordFrame:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 4
        mov edx, dword [ReplayBufferEnd]
        add edx, dword [ReplayFull]
        mov ebx, 0Ah
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov ecx, dword [esp]
        mov eax, dword [ReplayFrameSize]
        and ecx, 0FFF0h
        add eax, byte 4
        mov dword [esp], ecx
        and eax, 0FFFFh
        mov esi, ecx
        shl eax, 10h
        mov ebx, edx
        or esi, eax
        mov eax, esp
        mov dword [esp], esi
        call ReplayWriteFrame
        mov eax, dword [esp]
        mov edx, dword [ReplayPackPos]
        shr eax, 10h
        mov edi, dword [ReplayFrameSize]
        sub edx, eax
        mov eax, dword [ReplayRecordBuf]
        mov dword [nosplit ebx*4+ReplayObjects], edx
        mov edx, dword [ReplayPackPos]
        mov dword [nosplit ebx*4+ReplayObjectSizes], eax
        mov eax, 1
        sub edx, edi
        call ReplaySaveState
        cmp dword [ReplayFull], byte 0
        je short .1
        mov eax, dword [ReplayBufferEnd]
        cmp ebx, eax
        jne short .1
        lea edx, [byte eax+01h]
        mov ebx, 0Ah
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov dword [ReplayBufferEnd], edx
        jmp short .2
.1:
        inc dword [ReplayFull]
.2:
        mov eax, dword [ReplayRecordBuf]
        add eax, 249F0h
        mov dword [ReplayFrameCount], eax
        add esp, byte 4
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        push esi
        mov ecx, eax
        mov eax, dword [nosplit eax*4+ReplayObjects]
        mov dword [ReplayUnpackPos], eax
        mov esi, dword [ReplayFrameSize]
        mov edx, dword [ReplayUnpackPos]
        add esi, byte 4
        mov bl, byte [edx]
        xor eax, eax
        cmp bl, 1
        jne short .3
        mov edx, dword [ReplayReadPos]
        mov dword [ReplayUnpackPos], edx
.3:
        test eax, eax
        je short .4
        mov edx, dword [ReplayUnpackPos]
        mov ebx, esi
        call memcpy_
.4:
        mov edx, dword [ReplayUnpackPos]
        mov eax, 1
        add edx, esi
        mov ebx, dword [ReplayFrameSize]
        mov dword [ReplayUnpackPos], edx
        sub edx, ebx
        call ReplayRestoreState
        mov eax, dword [nosplit ecx*4+ReplayObjectSizes]
        mov dword [ReplayRecording], eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ReplayRegisterStates                            5BCCC  97 PC, low confidence
; Registers the state blocks the replay saves
;-----------------------------------------------------------------------------
ReplayRegisterStates:
        push ecx
        push edi
        push ebp
        mov ecx, eax
        cmp dword [ReplayStatesSet], byte 0
        je short .1
        mov eax, dword [ReplayStateSize]
        mov edi, dword [ReplayFrameSize]
        mov ebp, dword [ReplayStateTotal]
        inc eax
        add edi, edx
        add ebp, ebx
        mov dword [nosplit eax*4+ReplayPlayerStateCount], ecx
        mov dword [nosplit eax*4+ReplayPuckStateCount], edx
        mov dword [nosplit eax*4+ReplayCameraStateCount], ebx
        mov dword [ReplayFrameSize], edi
        mov dword [ReplayStateTotal], ebp
        mov dword [ReplayStateSize], eax
.1:
        pop ebp
        pop edi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ReplayRegisterObjects                           5BD1C  97 PC, low confidence
; Registers the objects the replay records
;-----------------------------------------------------------------------------
ReplayRegisterObjects:
        push edx
        mov edx, eax
        cmp dword [ReplayStatesSet], byte 0
        je short .1
        mov eax, dword [ReplayObjectsSet]
        inc eax
        mov dword [nosplit eax*4+ReplayObjectCount], edx
        mov dword [ReplayObjectsSet], eax
.1:
        pop edx
        ret
;-----------------------------------------------------------------------------
; FreeReplayBuffer                                5BD3C  97 PC, low confidence
; Frees the replay buffer
;-----------------------------------------------------------------------------
FreeReplayBuffer:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, 1
        xor edx, edx
        mov eax, dword [ReplayReadPos]
        mov dword [ReplayBufferEnd], edx
        mov dword [ReplayFrameCount], edx
        mov dword [ReplayFinalFrame], esi
        mov dword [ReplayPackPos], eax
        mov dword [ReplayPlaying], edx
        mov dword [ReplayTick], edx
        mov eax, dword [ReplayBuffer]
        mov dword [ReplayFull], edx
        test eax, eax
        je short .1
        push eax
        call FreeMemBlock
        add esp, byte 4
.1:
        xor ebx, ebx
        mov dword [ReplayBuffer], ebx
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ResetReplayBuffer                               5BD94  97 PC, low confidence
; Empties the replay buffer
;-----------------------------------------------------------------------------
ResetReplayBuffer:
        push ebx
        push edx
        xor edx, edx
        mov ebx, 1
        mov dword [ReplayStateTotal], edx
        mov dword [ReplayStateSize], edx
        mov dword [ReplayObjectsSet], edx
        mov dword [ReplayReadPos], edx
        mov dword [ReplayFull], edx
        mov dword [ReplayBufferEnd], edx
        mov dword [ReplayFrameCount], edx
        mov dword [ReplayFinalFrame], ebx
        mov dword [ReplayPackPos], edx
        mov dword [ReplayPlaying], edx
        mov dword [ReplayTick], edx
        mov dword [ReplayBuffer], edx
        mov dword [ReplayStatesSet], ebx
        mov dword [ReplayFrameSize], edx
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; InitReplayBuffer                             5BDF4  97 PC, medium confidence
; Allocates the "REPLAY" buffer when free memory exceeds the request by
; 200000 bytes, at most 0EA60h bytes
;-----------------------------------------------------------------------------
InitReplayBuffer:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        add ebx, 30D40h
        call MemFreeSizeAny
        cmp eax, ebx
        jl short .2
        sub eax, 30D40h
        mov dword [ReplayHeader], eax
        cmp eax, 0EA60h
        jle short .1
        mov dword [ReplayHeader], 0EA60h
.1:
        push byte 20h
        mov ecx, dword [ReplayHeader]
        push ecx
        push str_REPLAY
        xor edi, edi
        call AllocMemData
        mov esi, dword [ReplayHeader]
        mov dword [ReplayReadPos], eax
        mov dword [ReplayPackPos], eax
        add eax, esi
        add esp, byte 0Ch
        sub eax, byte 8
        mov dword [ReplayStatesSet], edi
        mov dword [ReplayPackBuf], eax
.2:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; IsReplayRecording                               5BE64  97 PC, low confidence
; Returns 1 when the replay is recording
;-----------------------------------------------------------------------------
IsReplayRecording:
        cmp dword [ReplayReadPos], byte 0
        setne al
        and eax, 0FFh
        ret
;-----------------------------------------------------------------------------
; ReplayHasFrames                                 5BE74  97 PC, low confidence
; Returns 1 when the replay is recording and holds frames; next entries give
; the counters
;-----------------------------------------------------------------------------
ReplayHasFrames:
        cmp dword [ReplayReadPos], byte 0
        setne al
        and eax, 0FFh
        je short .1
        cmp dword [ReplayFull], byte 0
        jle short .1
        mov eax, 1
        ret
.1:
        xor eax, eax
        ret
        db 090h
        mov eax, dword [ReplayReadPos]
        ret
        db 08Bh,0C0h
        push edx
        mov edx, dword [ReplayHeader]
        mov eax, dword [ReplayReadPos]
        add eax, edx
        pop edx
        ret
;-----------------------------------------------------------------------------
; ReplayFreeFrames                                5BEB0  97 PC, low confidence
; Drops the oldest frames from the replay buffer
;-----------------------------------------------------------------------------
ReplayFreeFrames:
        push ecx
        push edx
        mov edx, dword [ReplayReadPos]
        test edx, edx
        je short .1
        push edx
        call FreeMemBlock
        add esp, byte 4
.1:
        mov ecx, dword [ReplayBuffer]
        test ecx, ecx
        je short .2
        push ecx
        call FreeMemBlock
        add esp, byte 4
.2:
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetReplayRecording                              5BEDC  97 PC, low confidence
; (on/off): starts or stops replay recording (ReplayPlaying), allocating the
; "RP_GAME" block on start
;-----------------------------------------------------------------------------
SetReplayRecording:
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp dword [ReplayReadPos], byte 0
        setne dl
        and edx, 0FFh
        je near .4
        mov dword [ReplayPlaying], eax
        test eax, eax
        je short .3
        mov ebp, dword [ReplayFull]
        test ebp, ebp
        jne short .1
        mov dword [ReplayPlaying], ebp
        jmp short .4
.1:
        call IsReplayRecordingOn
        test eax, eax
        jne short .2
        push byte 20h
        mov eax, dword [ReplayStateTotal]
        push eax
        push str_RPGAME
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [ReplayBuffer], eax
        mov edx, eax
        xor eax, eax
        call ReplaySaveState
.2:
        mov eax, dword [ReplayWritePos]
        xor edx, edx
        mov dword [ReplayRecording], eax
        mov dword [ReplayTick], edx
        jmp short .4
.3:
        mov ecx, dword [ReplayBuffer]
        test ecx, ecx
        je short .4
        mov eax, 1
        mov edx, ecx
        call ReplayRestoreState
        mov esi, dword [ReplayBuffer]
        push esi
        xor edi, edi
        call FreeMemBlock
        add esp, byte 4
        mov dword [ReplayBuffer], edi
.4:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ReplayReadFrame                                 5BF88  97 PC, low confidence
; Reads the frame at the replay read position
;-----------------------------------------------------------------------------
ReplayReadFrame:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov ecx, dword [ReplayBufferEnd]
        mov edi, 0Ah
        lea edx, [byte ecx+01h]
        mov ebx, dword [ReplayFull]
        mov eax, edx
        sar edx, 1Fh
        dec ebx
.1:
        idiv edi
        mov eax, ebx
        dec ebx
        test eax, eax
        jle short .2
        cmp esi, dword [nosplit edx*4+ReplayObjectSizes]
        jl short .2
        mov ecx, edx
        inc edx
        mov edi, 0Ah
        mov eax, edx
        sar edx, 1Fh
        jmp short .1
.2:
        mov eax, dword [nosplit ecx*4+ReplayObjects]
        mov dword [ReplayUnpackPos], eax
        mov eax, dword [ReplayFrameSize]
        xor edx, edx
        add eax, byte 4
        call ReplayUnpackFrame
        mov edx, dword [ReplayUnpackPos]
        mov ebp, dword [ReplayFrameSize]
        mov eax, 1
        sub edx, ebp
        call ReplayRestoreState
        mov eax, dword [nosplit ecx*4+ReplayObjectSizes]
        mov dword [ReplayRecording], eax
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ReplaySeekStart                                 5C014  97 PC, low confidence
; Moves the replay read position to the first frame
;-----------------------------------------------------------------------------
ReplaySeekStart:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov edx, dword [ReplayWritePos]
        cmp edx, dword [ReplayRecording]
        jg short .1
        mov eax, 0FFFFFFFFh
        jmp near .5
.1:
        mov ebx, 0Fh
.2:
        mov ecx, dword [ReplayUnpackPos]
        mov eax, dword [ecx]
        shl eax, 10h
        mov edi, dword [ReplayRecording]
        shr eax, 14h
        add edi, eax
        mov dword [ReplayRecording], edi
        mov eax, dword [ecx]
        and eax, ebx
        cmp eax, byte 1
        jne short .3
        mov eax, dword [ReplayReadPos]
        mov dword [ReplayUnpackPos], eax
        jmp short .2
.3:
        mov ebp, dword [ecx]
        test ebx, ebp
        jne short .4
        mov eax, ebp
        shr eax, 10h
        add ecx, eax
        mov dword [ReplayUnpackPos], ecx
        jmp short .2
.4:
        mov ebx, ebp
        mov edx, ecx
        mov eax, esi
        shr ebx, 10h
        call memcpy_
        mov eax, dword [ecx]
        mov edx, dword [ReplayUnpackPos]
        shr eax, 10h
        add edx, eax
        mov eax, dword [ReplayRecording]
        mov dword [ReplayUnpackPos], edx
.5:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ReplayStepFrame                                 5C0AC  97 PC, low confidence
; Steps the replay one frame forward or back
;-----------------------------------------------------------------------------
ReplayStepFrame:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edx, dword [ReplayRecording]
        mov ebx, dword [ReplayWritePos]
        mov eax, dword [ReplayUnpackPos]
        cmp edx, ebx
        jl short .1
        mov eax, 0FFFFFFFFh
        jmp short .5
.1:
        test byte [eax], 0Fh
        je short .4
        mov edx, dword [eax]
        and edx, byte 0Fh
        cmp edx, byte 1
        jne short .2
        mov eax, dword [ReplayReadPos]
        mov dword [ReplayUnpackPos], eax
        jmp short .3
.2:
        mov edx, dword [eax]
        shl edx, 10h
        mov esi, dword [ReplayRecording]
        shr edx, 14h
        add esi, edx
        mov dword [ReplayRecording], esi
        mov eax, dword [eax]
        mov edi, dword [ReplayUnpackPos]
        shr eax, 10h
        add edi, eax
        mov dword [ReplayUnpackPos], edi
.3:
        mov eax, dword [ReplayUnpackPos]
        jmp short .1
.4:
        mov eax, dword [eax]
        shl eax, 10h
        mov ecx, dword [ReplayRecording]
        shr eax, 14h
        add eax, ecx
        call ReplayReadFrame
.5:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplayRecordTick                                5C134  97 PC, low confidence
; Records a frame when the recording is on
;-----------------------------------------------------------------------------
ReplayRecordTick:
        push ecx
        push edx
        mov edx, eax
        cmp dword [ReplayTick], byte 0
        je short .2
        mov ecx, dword [ReplayFrameCount]
        cmp ecx, dword [ReplayRecordBuf]
        jg short .1
        call ReplayRecordFrame
.1:
        mov eax, edx
        call ReplayWriteFrame
.2:
        pop edx
        pop ecx
ReplayRecordTick_29:
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ReplayPauseRecording                            5C160  97 PC, low confidence
; Stops recording for a while
;-----------------------------------------------------------------------------
ReplayPauseRecording:
        cmp dword [ReplayPlaying], byte 0
        jne short ReplayRecordTick_29
        call IsReplayRecording
        test eax, eax
        je short ReplayRecordTick_29
        xor eax, eax
        call SetReplayRecording
        mov eax, 1
        jmp short ReplayRecordFinal_C
;-----------------------------------------------------------------------------
; ReplayRecordFinal                               5C180  97 PC, low confidence
; Records the last frame before playback
;-----------------------------------------------------------------------------
ReplayRecordFinal:
        cmp dword [ReplayTick], byte 0
        je short ReplayRecordTick_29
        xor eax, eax
        nop
ReplayRecordFinal_C:
        push edx
        push esi
        cmp dword [ReplayReadPos], byte 0
        setne dl
        and edx, 0FFh
        je short .2
        mov dword [ReplayTick], eax
        test eax, eax
        je short .2
        cmp dword [ReplayFinalFrame], byte 0
        je short .1
        mov eax, dword [ReplayRecordBuf]
        mov dword [ReplayWritePos], eax
.1:
        xor esi, esi
        mov dword [ReplayFinalFrame], esi
        call ReplayRecordFrame
.2:
        pop esi
        pop edx
        ret
;-----------------------------------------------------------------------------
; ReplaySoundAllowed                              5C1CC  97 PC, low confidence
; Returns whether sounds may play during replay playback
;-----------------------------------------------------------------------------
ReplaySoundAllowed:
        cmp dword [ReplayPlaying], byte 0
        je short .1
        cmp dword [ReplaySoundOn], 258h
        jne short .2
.1:
        mov eax, 1
        ret
.2:
        cmp eax, 400h
        jge short .3
        mov eax, 1
        ret
.3:
        xor eax, eax
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplayDrawFrame                                 5C1F8  97 PC, low confidence
; Draws the current replay frame
;-----------------------------------------------------------------------------
ReplayDrawFrame:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        xor eax, eax
        mov ecx, SortCords
        call DrawGameOverlays
        xor eax, eax
        xor esi, esi
        call UpdateGameDisplay
.1:
        mov eax, dword [puckc]
        xor edx, edx
        inc esi
        mov dl, byte [dword ecx+0A4h]
        movsx eax, byte [eax]
        xor ebx, ebx
        cmp eax, edx
        sete al
        mov edx, dword [dword ecx+0B8h]
        mov bl, al
        sar edx, 10h
        mov eax, dword [dword ecx+0F2h]
        add ecx, 108h
        call SetTeamColours
        cmp esi, byte 0Ch
        jl short .1
        test edi, edi
        je short .2
        mov eax, 1
        call RefreshRinkPalette
        mov eax, dword [ReplayDrawn]
        jmp short .3
.2:
        mov eax, dword [tickcount]
.3:
        call DrawGameFrame
        call ServiceIdle
        call RedrawGameView
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        push edx
        sub esp, byte 0Ch
        mov eax, dword [ReplayFrame]
        call SetAnimClock
        mov edx, dword [PtrPuckFlags]
        mov eax, dword [byte edx+020h]
        mov dword [esp], eax
        mov eax, dword [byte edx+024h]
        mov dword [byte esp+04h], eax
        mov eax, dword [byte edx+028h]
        mov edx, ClockDataTicks
        mov dword [byte esp+08h], eax
        mov eax, esp
        call RefreshViewDistance
        call SetCameraMode
        call IsCameraOnPuck
        mov eax, 1
        call ReplayDrawFrame
        add esp, byte 0Ch
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ReplayCmdPlay                                   5C2CC  97 PC, low confidence
; Replay control: play
;-----------------------------------------------------------------------------
ReplayCmdPlay:
        xor eax, eax
        call SetCrowdNoise
        call StopAllSfx
        call RestartGameMusic
        cmp dword [ReplaySoundOn], byte 0
        sete al
        and eax, 0FFh
        mov dword [ReplaySoundOn], eax
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ReplayCmdStop                                   5C2F4  97 PC, low confidence
; Replay control: stop
;-----------------------------------------------------------------------------
ReplayCmdStop:
        push edx
        mov eax, 64h
        mov edx, 258h
        call SetCrowdNoise
        mov dword [ReplaySoundOn], edx
        pop edx
        ret
;-----------------------------------------------------------------------------
; ReplayCmdRewind                                 5C30C  97 PC, low confidence
; Replay control: rewind
;-----------------------------------------------------------------------------
ReplayCmdRewind:
        push edx
        xor eax, eax
        mov edx, 12Ch
        call SetCrowdNoise
        call StopAllSfx
        call RestartGameMusic
        mov dword [ReplaySoundOn], edx
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplayCmdForward                                5C32C  97 PC, low confidence
; Replay control: fast forward
;-----------------------------------------------------------------------------
ReplayCmdForward:
        push edx
        xor eax, eax
        mov edx, 4B0h
        call SetCrowdNoise
        call StopAllSfx
        call RestartGameMusic
        mov dword [ReplaySoundOn], edx
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplayPlayFrames                                5C34C  97 PC, low confidence
; Plays replay frames in the chosen direction and speed
;-----------------------------------------------------------------------------
ReplayPlayFrames:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov esi, eax
        xor eax, eax
        mov edx, 12Ch
        call SetCrowdNoise
        call ResetStreamAudio
        call StopAllSfx
        call RestartGameMusic
        mov eax, esi
        mov dword [ReplaySoundOn], edx
        call ReplayReadFrame
        mov dword [ReplayFrame], eax
        call SetAnimClock
        cmp esi, dword [ReplayFrame]
        jle near .8
        xor edi, edi
.1:
        mov eax, dword [ReplaySoundOn]
        cmp eax, 12Ch
        jne near .8
        mov ecx, dword [ReplayFrame]
        mov ebx, dword [ReplayRecordBuf]
        add ecx, eax
        cmp ecx, ebx
        jle near .7
.2:
        mov eax, dword [ReplayMode]
        call ReplaySeekStart
        test eax, eax
        jge short .3
        mov dword [ReplaySoundOn], edi
        jmp short .7
.3:
        mov edx, dword [ReplayMode]
        mov eax, dword [edx]
        and eax, byte 0Fh
        cmp eax, byte 3
        jne short .4
        mov ebx, 14h
        mov eax, PadStates
        add edx, byte 4
        call memcpy_
        mov eax, 1
        call RunSimFrames
        mov eax, dword [ReplayRecordBuf]
        mov dword [ReplayFrame], eax
        jmp short .6
.4:
        cmp eax, byte 4
        jne short .6
        call ReplayStepFrame
        test eax, eax
        jge short .5
        mov dword [ReplaySoundOn], edi
        jmp short .7
.5:
        mov dword [ReplayFrame], eax
        call SetAnimClock
.6:
        cmp ecx, dword [ReplayRecordBuf]
        jg short .2
.7:
        cmp esi, dword [ReplayFrame]
        jg near .1
.8:
        mov esi, ObjectPositions
        xor edi, edi
        xor ecx, ecx
        add esi, byte 58h
.9:
        imul edx, ecx, dword 760h
        mov ebx, esi
        mov eax, dword [dword edi+GameObjects]
        add edi, byte 4
        add esi, 760h
        mov edx, dword [dword edx+ReplayFrames]
        inc ecx
        call UpdateAllPoses
        cmp ecx, byte 0Dh
        jl short .9
        mov eax, dword [ReplayFrame]
        call SetAnimClock
        mov edx, dword [PtrPuckFlags]
        mov eax, dword [byte edx+020h]
        mov dword [esp], eax
        mov eax, dword [byte edx+024h]
        mov dword [byte esp+04h], eax
        mov eax, dword [byte edx+028h]
        mov edx, ClockDataTicks
        mov dword [byte esp+08h], eax
        mov eax, esp
        call RefreshViewDistance
        call SetCameraMode
        call IsCameraOnPuck
        mov eax, 1
        call ReplayDrawFrame
        xor edx, edx
        mov eax, dword [ReplayFrame]
        mov dword [ReplaySoundOn], edx
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ReplayCamFollow                                 5C4CC  97 PC, low confidence
; Replay camera: follows the puck
;-----------------------------------------------------------------------------
ReplayCamFollow:
        push edx
        cmp eax, byte 0Dh
        jge short .1
        add eax, byte 4
        jmp short .2
.1:
        sub eax, byte 0Ch
.2:
        xor edx, edx
        call StartCameraPath
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplayCamFree                                   5C4E4  97 PC, low confidence
; Replay camera: free camera
;-----------------------------------------------------------------------------
ReplayCamFree:
        push edx
        mov eax, 1
        xor edx, edx
        call SelectCameraView
        mov eax, 1
        xor edx, edx
        call StartCameraPath
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; StartInstantReplay                              5C500  97 PC, low confidence
; Starts an instant replay of the last play
;-----------------------------------------------------------------------------
StartInstantReplay:
        push edx
        mov eax, dword [tickcount]
        mov dword [ReplayDrawn], eax
        mov eax, dword [CameraScenesEnabled]
        xor edx, edx
        mov dword [InstantReplayStart], eax
        mov eax, dword [ReplayTick]
        mov dword [CameraScenesEnabled], edx
        mov dword [InstantReplayOn], eax
        mov eax, 1
        mov dword [ReplayTick], edx
        call SetReplayRecording
        call ClearOverlayWindows
        call OpenFreeOverlay
        mov eax, 2
        call ResetRenderTimers
        mov eax, 3
        call ResetRenderTimers
        mov eax, dword [ReplayRecordBuf]
        mov dword [InstantReplayEnd], eax
        xor eax, eax
        call ReplayPlayFrames
        call SetViewWindow
        mov eax, 1
        call StartCameraPath
        mov eax, 1
        xor edx, edx
        call SelectCameraView
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; EndInstantReplay                                5C584  97 PC, low confidence
; Ends the instant replay and resumes the game
;-----------------------------------------------------------------------------
EndInstantReplay:
        push edx
        mov eax, dword [InstantReplayEnd]
        call SetAnimClock
        xor eax, eax
        call SetReplayRecording
        mov eax, dword [InstantReplayOn]
        mov dword [ReplayTick], eax
        mov eax, dword [InstantReplayStart]
        mov dword [CameraScenesEnabled], eax
        call ClearOverlayWindows
        test byte [gmode], 1
        je short .1
        mov eax, 1
        jmp short .2
.1:
        xor eax, eax
.2:
        call ResetRenderTimers
        xor eax, eax
        call ChangeViewSize
        xor edx, edx
        mov eax, 1
        call StartCameraPath
        mov eax, dword [SavedCameraView]
        xor edx, edx
        sar eax, 10h
        call SelectCameraView
        pop edx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PlaySavedReplay                                 5C5EC  97 PC, low confidence
; Plays a replay loaded from disk
;-----------------------------------------------------------------------------
PlaySavedReplay:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov edx, dword [ReplaySoundOn]
        test edx, edx
        je near .12
        cmp edx, byte 1
        jne short .1
        mov esi, dword [ReplayFrame]
        add esi, 12Ch
        jmp short .2
.1:
        mov esi, dword [ReplayFrame]
        add esi, edx
.2:
        cmp esi, dword [ReplayRecordBuf]
        jle near .8
        mov edi, 1
.3:
        cmp esi, dword [ReplayRecordBuf]
        jle near .9
        mov eax, dword [ReplayMode]
        call ReplaySeekStart
        test eax, eax
        jge short .4
        xor edx, edx
        mov dword [ReplaySoundOn], edx
        jmp near .9
.4:
        mov eax, dword [ReplayMode]
        mov edx, dword [eax]
        and edx, byte 0Fh
        cmp edx, byte 3
        jne short .5
        lea edx, [byte eax+04h]
        mov ebx, 14h
        mov eax, PadStates
        call memcpy_
        mov eax, edi
        call RunSimFrames
        mov eax, dword [ReplayRecordBuf]
        mov dword [ReplayFrame], eax
        jmp short .7
.5:
        cmp edx, byte 4
        jne short .7
        call ReplayStepFrame
        test eax, eax
        jge short .6
        xor eax, eax
        mov dword [ReplaySoundOn], eax
        jmp short .9
.6:
        mov dword [ReplayFrame], eax
        call SetAnimClock
        mov ecx, dword [PtrPuckFlags]
        mov eax, dword [byte ecx+020h]
        mov dword [esp], eax
        mov eax, dword [byte ecx+024h]
        mov dword [byte esp+04h], eax
        mov eax, dword [byte ecx+028h]
        mov edx, ClockDataTicks
        mov dword [byte esp+08h], eax
        mov eax, esp
        call RefreshViewDistance
        call SetCameraMode
        call IsCameraOnPuck
        mov eax, edi
        call ReplayDrawFrame
.7:
        call ServiceIdle
        jmp near .3
.8:
        mov dword [ReplayFrame], esi
.9:
        cmp dword [ReplaySoundOn], byte 1
        jne short .10
        xor ecx, ecx
        mov dword [ReplaySoundOn], ecx
.10:
        mov ecx, ObjectPositions
        xor edi, edi
        xor esi, esi
        add ecx, byte 58h
.11:
        imul edx, esi, dword 760h
        mov ebx, ecx
        mov eax, dword [dword edi+GameObjects]
        add edi, byte 4
        add ecx, 760h
        mov edx, dword [dword edx+ReplayFrames]
        inc esi
        call UpdateAllPoses
        cmp esi, byte 0Dh
        jl short .11
.12:
        xor eax, eax
        call ReplayDrawFrame
        mov eax, dword [ReplayFrame]
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplayFramesLeft                                5C74C  97 PC, low confidence
; Returns how many replay frames are left to play
;-----------------------------------------------------------------------------
ReplayFramesLeft:
        push edx
        mov edx, dword [ReplayFrame]
        mov eax, dword [ReplayWritePos]
        sub eax, edx
        pop edx
        ret
;-----------------------------------------------------------------------------
; ReplayCurrentFrame                              5C75C  97 PC, low confidence
; Returns the current replay frame
;-----------------------------------------------------------------------------
ReplayCurrentFrame:
        mov eax, dword [ReplayFrame]
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ReplayRestoreObjects                            5C764  97 PC, low confidence
; Restores the objects from a replay frame
;-----------------------------------------------------------------------------
ReplayRestoreObjects:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        cmp dword [AnimStatesReady], byte 0
        je short .4
        mov esi, SortCords
        xor ecx, ecx
.1:
        mov edi, dword [AnimStatesReady]
        mov eax, dword [dword ecx+GameObjects]
        add eax, edi
        mov dword [dword ecx+GameObjects], eax
        je short .3
        mov edx, esi
.2:
        mov dword [byte eax+02Ch], edx
        mov eax, dword [byte eax+020h]
        test eax, eax
        jne short .2
.3:
        add ecx, byte 4
        add esi, 108h
        cmp ecx, byte 34h
        jne short .1
.4:
        mov esi, ObjectPositions
        xor edi, edi
        xor ecx, ecx
        add esi, byte 58h
.5:
        imul edx, ecx, dword 760h
        mov ebx, esi
        mov eax, dword [dword edi+GameObjects]
        add edi, byte 4
        add esi, 760h
        mov edx, dword [dword edx+ReplayFrames]
        inc ecx
        call UpdateAllPoses
        cmp ecx, byte 0Dh
        jl short .5
        mov ecx, SortCords
        xor esi, esi
        xor edi, edi
.6:
        cmp di, word [dword ecx+0A9h]
        jne short .7
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul edx, eax, dword 125h
        mov ebx, dword [dword ecx+0FEh]
        mov ebx, dword [dword ebx+0108h]
        lea eax, [dword ebx+01D42h]
        mov ebx, edi
        add edx, eax
        jmp short .8
.7:
        mov edx, dword [dword ecx+0A3h]
        sar edx, 18h
        imul edx, dword 125h
        mov eax, dword [dword ecx+0FEh]
        mov eax, dword [dword eax+0108h]
        add eax, 0A3h
        add edx, eax
        mov ebx, dword [dword edx+0F5h]
        sar ebx, 10h
.8:
        movsx ebx, bx
        mov eax, ecx
        call RefreshPlayerModel
        mov eax, dword [puckc]
        xor edx, edx
        inc esi
        mov dl, byte [dword ecx+0A4h]
        movsx eax, byte [eax]
        xor ebx, ebx
        cmp eax, edx
        sete al
        mov edx, dword [dword ecx+0B8h]
        mov bl, al
        sar edx, 10h
        mov eax, dword [dword ecx+0F2h]
        add ecx, 108h
        call SetTeamColours
        cmp esi, byte 0Ch
        jl near .6
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ReplaySetupObjects                              5C894  97 PC, low confidence
; Sets up the objects for replay playback
;-----------------------------------------------------------------------------
ReplaySetupObjects:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov esi, SortCords
        xor ecx, ecx
        add esi, 0D2h
.1:
        imul eax, ecx, dword 108h
        mov edx, esi
        add eax, SortCords
        sub edx, eax
        add esi, 108h
        mov ebx, edx
        inc ecx
        call ReplayRegisterStates
        cmp ecx, byte 10h
        jl short .1
        mov ebx, 390h
        mov eax, BenchPlayerTable
        mov esi, hmtmstruct
        mov edx, ebx
        xor ecx, ecx
        call ReplayRegisterStates
        add esi, 0FCh
.2:
        imul eax, ecx, dword 10Ch
        mov edx, esi
        add eax, hmtmstruct
        sub edx, eax
        add esi, 10Ch
        mov ebx, edx
        inc ecx
        call ReplayRegisterStates
        cmp ecx, byte 2
        jl short .2
        mov ebx, 34h
        mov eax, GameObjects
        mov ecx, PlayerStartRecords
        mov edx, ebx
        mov edi, 3Ch
        call ReplayRegisterStates
        lea esi, [dword ecx+03C0h]
.3:
        mov ebx, edi
        mov edx, edi
        mov eax, ecx
        add ecx, byte 3Ch
        call ReplayRegisterStates
        cmp ecx, esi
        jne short .3
        mov ebx, 284h
        mov eax, kaufmfont
        mov edx, ebx
        call ReplayRegisterStates
        cmp dword [ReplayStatesSet], byte 0
        je short .4
        mov eax, dword [ReplayObjectsSet]
        inc eax
        mov dword [nosplit eax*4+ReplayObjectCount], ReplayRestoreObjects
        mov dword [ReplayObjectsSet], eax
.4:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SaveReplayHeader                                5C974  97 PC, low confidence
; Writes the replay header to the file
;-----------------------------------------------------------------------------
SaveReplayHeader:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov esi, eax
        mov ebp, edx
        xor edi, edi
        test edx, edx
        je short .1
        mov ebx, 1E7h
        mov edx, dword [gameopts]
        call memcpy_
.1:
        mov eax, dword [GameSettings]
        shl eax, 17h
        shr eax, 1Eh
        add edi, 1E7h
        mov dword [esp], eax
        test ebp, ebp
        je short .2
        mov ebx, 4
        mov edx, esp
        lea eax, [esi+edi]
        call memcpy_
.2:
        add edi, byte 4
        test ebp, ebp
        je short .3
        mov ebx, 2
        mov edx, StatsPanelPlayer
        lea eax, [esi+edi]
        call memcpy_
.3:
        mov eax, dword [ReplayHeader]
        mov edx, dword [ReplayReadPos]
        add edi, byte 2
        add eax, edx
        mov dword [byte esp+08h], edx
        mov ecx, eax
        test ebp, ebp
        je short .4
        mov ebx, eax
        sub ebx, edx
        lea eax, [esi+edi]
        call memcpy_
.4:
        mov edx, dword [byte esp+08h]
        mov eax, ecx
        sub eax, edx
        add edi, eax
        test ebp, ebp
        je short .5
        mov ebx, 4
        mov edx, ReplayBufferEnd
        lea eax, [esi+edi]
        call memcpy_
.5:
        add edi, byte 4
        test ebp, ebp
        je short .6
        mov ebx, 4
        mov edx, ReplayFull
        lea eax, [esi+edi]
        call memcpy_
.6:
        add edi, byte 4
        test ebp, ebp
        je short .7
        mov ebx, 28h
        mov edx, ReplayObjectSizes
        lea eax, [esi+edi]
        call memcpy_
.7:
        add edi, byte 28h
        test ebp, ebp
        je short .8
        mov ebx, 4
        mov edx, ReplayWritePos
        lea eax, [esi+edi]
        call memcpy_
.8:
        add edi, byte 4
        xor ecx, ecx
        add esi, edi
.9:
        mov ebx, dword [ReplayReadPos]
        mov eax, dword [dword ecx+ReplayObjects]
        sub eax, ebx
        mov dword [byte esp+04h], eax
        test ebp, ebp
        je short .10
        mov ebx, 4
        lea edx, [byte esp+04h]
        mov eax, esi
        call memcpy_
.10:
        add edi, byte 4
        add ecx, byte 4
        add esi, byte 4
        cmp ecx, byte 28h
        jne short .9
        mov eax, edi
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LoadReplayHeader                                5CAB0  97 PC, low confidence
; Reads the replay header from the file
;-----------------------------------------------------------------------------
LoadReplayHeader:
        push ebx
        push edx
        mov ebx, 1E7h
        mov edx, eax
        mov eax, GlobalSetVersion
        call memcpy_
        mov eax, 1
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LoadReplayData                                  5CACC  97 PC, low confidence
; Reads the replay frames from the file
;-----------------------------------------------------------------------------
LoadReplayData:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov esi, eax
        lea edx, [dword eax+01E7h]
        mov ebx, 4
        mov eax, esp
        call memcpy_
        mov dx, word [GameSettings]
        mov eax, dword [esp]
        and edx, 0FE7Fh
        and eax, byte 3
        mov word [GameSettings], dx
        shl eax, 7
        mov edx, dword [GameSettings]
        mov ebx, 2
        or edx, eax
        mov eax, StatsPanelPlayer
        mov dword [GameSettings], edx
        lea edx, [dword esi+01EBh]
        call memcpy_
        mov eax, dword [ReplayReadPos]
        mov edi, dword [ReplayHeader]
        add edi, eax
        sub edi, eax
        lea edx, [dword esi+01EDh]
        mov ebx, edi
        call memcpy_
        mov ebx, 4
        add edi, 1EDh
        mov eax, ReplayBufferEnd
        lea edx, [esi+edi]
        call memcpy_
        mov ebx, 4
        add edi, byte 4
        mov eax, ReplayFull
        lea edx, [esi+edi]
        call memcpy_
        mov ebx, 28h
        add edi, byte 4
        mov eax, ReplayObjectSizes
        lea edx, [esi+edi]
        xor ecx, ecx
        call memcpy_
        mov ebx, 4
        add edi, byte 28h
        mov eax, ReplayWritePos
        lea edx, [esi+edi]
        add edi, byte 4
        call memcpy_
        add esi, edi
        mov ebp, 4
.1:
        lea eax, [byte esp+04h]
        mov ebx, ebp
        mov edx, esi
        call memcpy_
        add edi, byte 4
        mov ebx, dword [byte esp+04h]
        mov eax, dword [ReplayReadPos]
        add ecx, byte 4
        add eax, ebx
        add esi, byte 4
        mov dword [dword ecx+FaceTextureCount], eax
        cmp ecx, byte 28h
        jne short .1
        mov eax, SortCords
        xor ecx, ecx
        xor ebx, ebx
        xor edi, edi
        xor esi, esi
        xor edx, edx
.2:
        mov ebp, ecx
        add ebp, BenchPlayerTable
        mov dword [dword eax+0EEh], ebp
        cmp edx, byte 6
        jl short .3
        mov ebp, awtmstruct
        jmp short .4
.3:
        mov ebp, hmtmstruct
.4:
        mov dword [dword eax+0FEh], ebp
        jl short .5
        mov ebp, hmtmstruct
        jmp short .6
.5:
        mov ebp, awtmstruct
.6:
        mov dword [dword eax+0102h], ebp
        cmp edx, byte 0Dh
        jge short .7
        mov ebp, esi
        add ebp, ObjectPositions
        mov dword [dword eax+0F2h], ebp
        mov ebp, edi
        add ebp, GameObjects
        mov dword [dword eax+0F6h], ebp
        mov ebp, ebx
        jmp short .8
.7:
        mov dword [dword eax+0F6h], 0
        mov ebp, ebx
        mov dword [dword eax+0F2h], 0
.8:
        add ebp, PlayerStartRecords
        mov dword [dword eax+0FAh], ebp
        add ebx, byte 3Ch
        add edi, byte 4
        add esi, 760h
        inc edx
        add eax, 108h
        add ecx, byte 39h
        cmp edx, byte 10h
        jl near .2
        mov esi, AutoLineData
        mov edi, HomeTeamRecord+420h
        mov ebp, homelines
        mov ecx, SortCords
        mov eax, 1
        mov dword [HmScore], esi
        mov dword [AwTeamData], edi
        mov dword [AwScore], ebp
        mov dword [HmTeamData], ecx
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h
;-----------------------------------------------------------------------------
; FreeReplayMem                                   5CCC0  97 PC, low confidence
; Frees the memory used by a loaded replay
;-----------------------------------------------------------------------------
FreeReplayMem:
        push ebx
        push ecx
        push edx
        mov edx, dword [PaletteDirtyFlag]
        push edx
        xor ebx, ebx
        call FreeMemBlock
        add esp, byte 4
        mov dword [SpriteBuffersOn], ebx
        pop edx
        pop ecx
        pop ebx
        ret
