; Sound: AudioLeave, AudioDeferredWork, AudioEnter, AudioLeaveCheck, SampleFormatSize.
bits 32
%include "hockey.inc"
section s_12A8D8 progbits alloc exec nowrite align=1
extern ApplyChannelVolume, AudioBusyCount, AudioDeferredArg, AudioDeferredFunc, AudioDeferredPending, AudioDriverUpdate, AudioLockCount, AudioSpeechHook
extern AudioStreamHook, AudioWorkHook, ChannelSampleTable, DigitalAudioHandle, DigitalAudioRate, SpeechQueueVolume, StartChannel, StopChannel
extern str_D_UpdateFrameRate
global AudioLeave, AudioDeferredWork, AudioEnter, AudioEnter_6, AudioLeaveCheck, SampleFormatSize
        db 00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; AudioLeave                                     12A8E0  97 PC, low confidence
; Leaves the audio critical section and runs deferred work
;-----------------------------------------------------------------------------
AudioLeave:
        push ebx
        push ecx
        push edx
        push ebp
        mov edx, dword [AudioDeferredPending]
        test edx, edx
        jne near .5
        cmp dword [AudioLockCount], byte 0
        je short .1
        inc dword [AudioBusyCount]
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov dword [AudioDeferredPending], 1
        mov eax, dword [str_D_UpdateFrameRate]
        cmp eax, dword [AudioDeferredArg]
        je short .2
        mov dword [AudioDeferredArg], eax
        mov dword [DigitalAudioRate], edx
        mov dword [DigitalAudioHandle], edx
.2:
        mov eax, dword [DigitalAudioHandle]
        inc eax
        mov dword [DigitalAudioHandle], eax
        lea edx, [nosplit eax*4+00h]
        sub edx, eax
        shl edx, 3
        add eax, edx
        mov ebx, dword [str_D_UpdateFrameRate]
        shl eax, 2
        xor edx, edx
        div ebx
        mov ecx, dword [DigitalAudioRate]
        mov edx, eax
        cmp eax, ecx
        jb short .4
.3:
        call AudioDeferredWork
        cmp edx, dword [DigitalAudioRate]
        jae short .3
.4:
        xor ebp, ebp
        mov dword [AudioDeferredPending], ebp
.5:
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AudioDeferredWork                              12A97C  97 PC, low confidence
; Runs the audio work deferred during the critical section
;-----------------------------------------------------------------------------
AudioDeferredWork:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edx, dword [DigitalAudioRate]
        mov ebx, dword [AudioDeferredFunc]
        inc edx
        inc ebx
        mov dword [DigitalAudioRate], edx
        mov dword [AudioDeferredFunc], ebx
        call AudioDriverUpdate
        cmp dword [AudioSpeechHook], byte 0
        je short .1
        call dword [AudioSpeechHook]
.1:
        mov eax, dword [AudioDeferredFunc]
        mov edx, eax
        mov ebx, 3
        sar edx, 1Fh
        idiv ebx
        test edx, edx
        jne near .13
        cmp dword [SpeechQueueVolume], byte 0
        je short .2
        call dword [SpeechQueueVolume]
.2:
        cmp dword [AudioWorkHook], byte 0
        je short .3
        call dword [AudioWorkHook]
.3:
        cmp dword [AudioStreamHook], byte 0
        je short .4
        call dword [AudioStreamHook]
.4:
        mov ecx, ChannelSampleTable
        xor esi, esi
.5:
        mov ah, byte [byte ecx+0Dh]
        mov ebx, ecx
        cmp ah, 1
        jne near .12
        cmp dword [ecx], byte 0
        jl near .12
        mov edx, dword [byte ecx+014h]
        xor edi, edi
        test edx, edx
        je short .8
        mov ebp, dword [byte ecx+01Ch]
        mov edi, 1
        add ebp, edx
        mov eax, dword [byte ecx+014h]
        mov dword [byte ecx+01Ch], ebp
        test eax, eax
        jge short .6
        mov eax, ebp
        mov ebp, dword [byte ecx+018h]
        cmp eax, ebp
        jg short .7
        mov dword [byte ecx+014h], 0
        mov dword [byte ecx+01Ch], ebp
        jmp short .7
.6:
        mov edx, dword [byte ecx+018h]
        cmp ebp, edx
        jl short .7
        mov dword [byte ecx+014h], 0
        mov dword [byte ecx+01Ch], edx
.7:
        cmp dword [byte ebx+01Ch], byte 0
        jge short .8
        mov eax, dword [ebx]
        call StopChannel
.8:
        mov edx, dword [byte ebx+020h]
        test edx, edx
        je short .9
        add dword [byte ebx+024h], edx
        mov edi, 1
.9:
        cmp dword [byte ebx+028h], byte 0
        jne short .11
        mov dl, byte [byte ebx+032h]
        inc dl
        xor eax, eax
        mov byte [byte ebx+032h], dl
        mov al, dl
        mov edx, dword [byte ebx+02Eh]
        sar edx, 18h
        cmp eax, edx
        jl short .10
        mov eax, dword [ebx]
        call StopChannel
        jmp short .11
.10:
        mov edx, dword [byte ebx+034h]
        mov ebp, 3
        mov eax, dword [edx+eax*8]
        xor edx, edx
        div ebp
        mov dword [byte ebx+028h], eax
        xor eax, eax
        mov al, byte [byte ebx+032h]
        lea edx, [nosplit eax*8+00h]
        mov eax, dword [byte ebx+034h]
        mov eax, dword [byte edx+eax+04h]
        shl eax, 10h
        mov edx, dword [byte ebx+024h]
        mov ebp, dword [byte ebx+028h]
        sub eax, edx
        xor edx, edx
        div ebp
        mov dword [byte ebx+020h], eax
.11:
        dec dword [byte ebx+028h]
        test edi, edi
        je short .12
        mov eax, esi
        call StartChannel
        cmp dword [ebx], byte 0
        jl short .12
        mov edx, dword [byte ebx+02Ah]
        mov eax, esi
        sar edx, 18h
        call ApplyChannelVolume
.12:
        inc esi
        add ecx, byte 44h
        cmp esi, byte 10h
        jl near .5
.13:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; AudioEnter                                     12AB04  97 PC, low confidence
; Enters the audio critical section
;-----------------------------------------------------------------------------
AudioEnter:
        inc dword [AudioLockCount]
AudioEnter_6:
        ret
        db 090h
;-----------------------------------------------------------------------------
; AudioLeaveCheck                                12AB0C  97 PC, low confidence
; Leaves the audio critical section
;-----------------------------------------------------------------------------
AudioLeaveCheck:
        dec dword [AudioLockCount]
        cmp dword [AudioLockCount], byte 0
        jne short AudioEnter_6
.1:
        cmp dword [AudioBusyCount], byte 0
        je short AudioEnter_6
        dec dword [AudioBusyCount]
        call AudioLeave
        jmp short .1
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; SampleFormatSize                               12AB40  97 PC, low confidence
; Returns the size of a sample format
;-----------------------------------------------------------------------------
SampleFormatSize:
        push ecx
        mov ecx, eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        shl eax, 2
        lea edx, [byte ecx-040h]
        imul edx, eax
        mov eax, edx
        sar edx, 1Fh
        shl edx, 6
        LD sbb, eax, edx
        sar eax, 6
        add eax, ebx
        pop ecx
        ret
        db 00h
