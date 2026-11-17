; EA library: ResetGameVars.
bits 32
%include "hockey.inc"
section s_12CD6C progbits alloc exec nowrite align=1
extern SpeechBufferTag, SpeechPatchAttack, SpeechPatchBits, SpeechPatchBytesPerSample, SpeechPatchChannel, SpeechPatchChannels, SpeechPatchCompression, SpeechPatchDataOffset
extern SpeechPatchDataSize, SpeechPatchDecay, SpeechPatchDetune, SpeechPatchFlags, SpeechPatchFormat, SpeechPatchHandle, SpeechPatchHeaderSize, SpeechPatchLength
extern SpeechPatchLooped, SpeechPatchLoopEnd, SpeechPatchLoopFrom, SpeechPatchLoopStart, SpeechPatchLoopTo, SpeechPatchMaxVolume, SpeechPatchMono, SpeechPatchNext
extern SpeechPatchOn, SpeechPatchPan, SpeechPatchPanEnd, SpeechPatchPanMax, SpeechPatchPanMin, SpeechPatchPanStart, SpeechPatchPercent, SpeechPatchPosition
extern SpeechPatchPriority, SpeechPatchRate, SpeechPatchRelease, SpeechPatchRepeat, SpeechPatchReserved, SpeechPatchSampleRate, SpeechPatchSigned, SpeechPatchSustain
extern SpeechPatchTemplateTag, SpeechPatchVoices, SpeechPatchVolMax, SpeechPatchVolMin, SpeechPatchVolStart, SpeechPatchVolume
global ResetGameVars
;-----------------------------------------------------------------------------
; ResetGameVars                               12CD6C  95 PC, medium confidence
;
; Clears the per-game state (penalty / referee / line-change / penalty-shot vars, pass state, crowd
; excitement, input counters, exitgame / gameover, frameaccum), calls StartGame, centres the mouse when a
; pad uses it, joyq_flush
;-----------------------------------------------------------------------------
ResetGameVars:
        mov byte [SpeechPatchOn], 1
        mov byte [SpeechPatchLooped], 0
        mov byte [SpeechPatchMono], 1
        mov byte [SpeechPatchSigned], 1
        mov word [SpeechPatchFlags], 0
        mov byte [SpeechPatchPan], 40h
        mov byte [SpeechPatchVolume], 7Fh
        mov dword [SpeechPatchVoices], 4
        mov byte [SpeechPatchVolMin], 0
        mov byte [SpeechPatchVolMax], 7Fh
        mov byte [SpeechPatchPanMin], 0
        mov byte [SpeechPatchPanMax], 7Fh
        mov dword [SpeechPatchChannel], 0FFFFFFFFh
        mov byte [SpeechPatchPercent], 64h
        mov byte [SpeechPatchRate], 3Ch
        mov byte [SpeechPatchRepeat], 1
        mov byte [SpeechPatchPriority], 0FFh
        mov byte [SpeechPatchPanStart], 40h
        mov byte [SpeechPatchAttack], 0
        mov byte [SpeechPatchDecay], 0
        mov byte [SpeechPatchSustain], 1
        mov byte [SpeechPatchPanEnd], 40h
        mov byte [SpeechPatchRelease], 0
        mov byte [SpeechPatchVolStart], 7Fh
        mov byte [SpeechPatchDetune], 0
        mov word [SpeechPatchLoopStart], 0
        mov word [SpeechPatchLoopEnd], 0
        mov dword [SpeechPatchDataOffset], 0
        mov dword [SpeechPatchDataSize], 0
        mov dword [SpeechPatchPosition], 0
        mov dword [SpeechPatchHeaderSize], 20h
        mov dword [SpeechPatchTemplateTag], 6C704D54h
        mov byte [SpeechPatchFormat], 0
        mov byte [SpeechPatchBits], 10h
        mov byte [SpeechPatchChannels], 1
        mov byte [SpeechPatchCompression], 0
        mov byte [SpeechPatchBytesPerSample], 2
        mov byte [SpeechPatchReserved], 0
        mov word [SpeechPatchSampleRate], 5622h
        mov dword [SpeechPatchLength], 0
        mov dword [SpeechPatchLoopFrom], 0FFFFFFFFh
        mov dword [SpeechPatchLoopTo], 0FFFFFFFFh
        mov dword [SpeechPatchNext], 0
        mov dword [SpeechPatchHandle], 0FFFFFFFFh
        mov dword [SpeechPatchMaxVolume], 7Fh
        mov dword [SpeechBufferTag], 6C544150h
        ret
