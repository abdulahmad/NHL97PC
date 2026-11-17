; Speech events: queued pass, shot, hit, penalty and other calls.
bits 32
%include "hockey.inc"
section s_3FEE7 progbits alloc exec nowrite align=1
extern LastSfxPlayed, RequestSpeechEvent, SfxChannelIds, SfxChannelRecords, SfxChannelTimes, SpeechPlaying
global QueuePassSpeech, QueueShotSpeech, QueuePositionSpeech, QueueHitSpeech, QueuePenaltySpeech, QueueReceiveSpeech, QueueLoosePuckSpeech, QueueCarrySpeech
global QueueTeamSpeech, QueueDeflectSpeech, QueuePickupSpeech, QueueFaceoffSpeech, QueuePenaltyEndSpeech, QueueFinalSpeech, QueueTouchPuckSpeech, QueuePenaltyCallSpeech
global QueueStoppageSpeech, QueuePowerPlaySpeech
        db 090h
;-----------------------------------------------------------------------------
; QueuePassSpeech                                 3FEE8  97 PC, low confidence
; Play-by-play: queues the phrase for a pass made or completed
;-----------------------------------------------------------------------------
QueuePassSpeech:
        push esi
        push edi
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov eax, dword [byte esp+03Ch]
        mov dword [byte esp+014h], eax
        mov eax, dword [byte esp+040h]
        mov dword [esp], edi
        mov dword [byte esp+018h], eax
        mov eax, dword [byte esp+044h]
        mov dword [byte esp+04h], esi
        mov dword [byte esp+01Ch], eax
        mov eax, dword [byte esp+048h]
        mov dword [byte esp+08h], edx
        mov dword [byte esp+020h], eax
        mov eax, dword [byte esp+04Ch]
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+024h], eax
        mov eax, esp
        mov dword [byte esp+010h], ecx
        call RequestSpeechEvent
        add esp, byte 30h
        pop edi
        pop esi
        ret 14h
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; QueueShotSpeech                                 3FF4C  97 PC, low confidence
; Play-by-play: queues the phrase for a shot
;-----------------------------------------------------------------------------
QueueShotSpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 1
        mov eax, dword [byte esp+040h]
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+014h], eax
        mov eax, dword [byte esp+044h]
        mov dword [byte esp+010h], ecx
        mov dword [byte esp+018h], eax
        mov eax, esp
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret 8
;-----------------------------------------------------------------------------
; QueuePositionSpeech                             3FF9C  97 PC, low confidence
; Play-by-play: queues a phrase about where the play is on the rink
;-----------------------------------------------------------------------------
QueuePositionSpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 2
        mov eax, dword [byte esp+040h]
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+014h], eax
        mov eax, dword [byte esp+044h]
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+018h], eax
        mov eax, dword [byte esp+048h]
        mov dword [byte esp+010h], ecx
        mov dword [byte esp+01Ch], eax
        mov eax, esp
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret 0Ch
        push ecx
        push esi
        push edi
        sub esp, byte 30h
        mov ecx, eax
        xor eax, eax
.2:
        add eax, byte 4
        xor esi, esi
        mov dword [byte esp+eax-04h], esi
        cmp eax, byte 30h
        jne short .2
        mov edi, 3
        mov eax, esp
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [esp], edi
        call RequestSpeechEvent
        add esp, byte 30h
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
        push ecx
        push esi
        push edi
        sub esp, byte 30h
        mov ecx, eax
        xor eax, eax
.3:
        add eax, byte 4
        xor esi, esi
        mov dword [byte esp+eax-04h], esi
        cmp eax, byte 30h
        jne short .3
        mov edi, 4
        mov eax, esp
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [esp], edi
        call RequestSpeechEvent
        add esp, byte 30h
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueueHitSpeech                                  4006C  97 PC, low confidence
; Play-by-play: queues the phrase for a collision
;-----------------------------------------------------------------------------
QueueHitSpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 5
        mov eax, esp
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], ecx
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
        push ecx
        push esi
        push edi
        sub esp, byte 30h
        mov ecx, eax
        xor eax, eax
.2:
        add eax, byte 4
        xor esi, esi
        mov dword [byte esp+eax-04h], esi
        cmp eax, byte 30h
        jne short .2
        mov edi, 6
        mov eax, esp
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [esp], edi
        call RequestSpeechEvent
        add esp, byte 30h
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueuePenaltySpeech                              400E8  97 PC, low confidence
; Play-by-play: queues the phrase for a penalty
;-----------------------------------------------------------------------------
QueuePenaltySpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 7
        mov eax, esp
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], ecx
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
        push ecx
        push esi
        push edi
        sub esp, byte 30h
        mov ecx, eax
        xor eax, eax
.2:
        add eax, byte 4
        xor esi, esi
        mov dword [byte esp+eax-04h], esi
        cmp eax, byte 30h
        jne short .2
        mov edi, 8
        mov eax, esp
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [esp], edi
        call RequestSpeechEvent
        add esp, byte 30h
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
        push ecx
        push esi
        push edi
        sub esp, byte 30h
        mov ecx, eax
        xor eax, eax
.3:
        add eax, byte 4
        xor esi, esi
        mov dword [byte esp+eax-04h], esi
        cmp eax, byte 30h
        jne short .3
        mov edi, 9
        mov eax, esp
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [esp], edi
        call RequestSpeechEvent
        add esp, byte 30h
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueueReceiveSpeech                              401A0  97 PC, low confidence
; Play-by-play: queues the phrase for a pass taken
;-----------------------------------------------------------------------------
QueueReceiveSpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 0Ah
        mov eax, esp
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], ecx
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
        push ecx
        push esi
        push edi
        sub esp, byte 30h
        mov ecx, eax
        xor eax, eax
.2:
        add eax, byte 4
        xor esi, esi
        mov dword [byte esp+eax-04h], esi
        cmp eax, byte 30h
        jne short .2
        mov edi, 0Bh
        mov eax, esp
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [esp], edi
        call RequestSpeechEvent
        add esp, byte 30h
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
        push ecx
        push esi
        push edi
        sub esp, byte 30h
        mov ecx, eax
        xor eax, eax
.3:
        add eax, byte 4
        xor esi, esi
        mov dword [byte esp+eax-04h], esi
        cmp eax, byte 30h
        jne short .3
        mov edi, 0Ch
        mov eax, esp
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [esp], edi
        call RequestSpeechEvent
        add esp, byte 30h
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueueLoosePuckSpeech                            40258  97 PC, low confidence
; Play-by-play: queues the phrase for a loose puck
;-----------------------------------------------------------------------------
QueueLoosePuckSpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 0Dh
        mov eax, esp
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], ecx
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueueCarrySpeech                                40298  97 PC, low confidence
; Play-by-play: queues the phrase for a player carrying the puck
;-----------------------------------------------------------------------------
QueueCarrySpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 0Eh
        mov eax, esp
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], ecx
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        sub esp, byte 30h
        mov edx, eax
        xor eax, eax
.2:
        add eax, byte 4
        xor ebx, ebx
        mov dword [byte esp+eax-04h], ebx
        cmp eax, byte 30h
        jne short .2
        mov ecx, 0Fh
        mov eax, esp
        mov dword [byte esp+04h], edx
        mov dword [esp], ecx
        call RequestSpeechEvent
        add esp, byte 30h
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push esi
        sub esp, byte 30h
        mov ebx, eax
        xor eax, eax
.3:
        add eax, byte 4
        xor ecx, ecx
        mov dword [byte esp+eax-04h], ecx
        cmp eax, byte 30h
        jne short .3
        mov esi, 10h
        mov eax, esp
        mov dword [byte esp+04h], ebx
        mov dword [byte esp+08h], edx
        mov dword [esp], esi
        call RequestSpeechEvent
        add esp, byte 30h
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ecx
        push esi
        push edi
        sub esp, byte 30h
        mov ecx, eax
        xor eax, eax
.4:
        add eax, byte 4
        xor esi, esi
        mov dword [byte esp+eax-04h], esi
        cmp eax, byte 30h
        jne short .4
        mov edi, 11h
        mov eax, esp
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [esp], edi
        call RequestSpeechEvent
        add esp, byte 30h
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueueTeamSpeech                                 40380  97 PC, low confidence
; Play-by-play: queues a phrase naming a team
;-----------------------------------------------------------------------------
QueueTeamSpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 12h
        mov eax, esp
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], ecx
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueueDeflectSpeech                              403C0  97 PC, low confidence
; Play-by-play: queues the phrase for a deflection or a save
;-----------------------------------------------------------------------------
QueueDeflectSpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 13h
        mov eax, esp
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], ecx
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueuePickupSpeech                               40400  97 PC, low confidence
; Play-by-play: queues the phrase for a player picking up the puck
;-----------------------------------------------------------------------------
QueuePickupSpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 14h
        mov eax, esp
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], ecx
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueueFaceoffSpeech                              40440  97 PC, low confidence
; Play-by-play: queues the phrase for a faceoff
;-----------------------------------------------------------------------------
QueueFaceoffSpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 15h
        mov eax, dword [byte esp+040h]
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], ecx
        mov dword [byte esp+014h], eax
        mov eax, esp
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret 4
        push ecx
        push esi
        push edi
        sub esp, byte 30h
        mov ecx, eax
        xor eax, eax
.2:
        add eax, byte 4
        xor esi, esi
        mov dword [byte esp+eax-04h], esi
        cmp eax, byte 30h
        jne short .2
        mov edi, 16h
        mov eax, esp
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [esp], edi
        call RequestSpeechEvent
        add esp, byte 30h
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueuePenaltyEndSpeech                           404C4  97 PC, low confidence
; Play-by-play: queues the phrase for a penalty that ends
;-----------------------------------------------------------------------------
QueuePenaltyEndSpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 17h
        mov eax, esp
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], ecx
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
        push ecx
        push esi
        push edi
        sub esp, byte 30h
        mov ecx, eax
        xor eax, eax
.2:
        add eax, byte 4
        xor esi, esi
        mov dword [byte esp+eax-04h], esi
        cmp eax, byte 30h
        jne short .2
        mov edi, 18h
        mov eax, esp
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [esp], edi
        call RequestSpeechEvent
        add esp, byte 30h
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        sub esp, byte 30h
        mov edx, eax
        xor eax, eax
.3:
        add eax, byte 4
        xor ebx, ebx
        mov dword [byte esp+eax-04h], ebx
        cmp eax, byte 30h
        jne short .3
        mov ecx, 19h
        mov eax, esp
        mov dword [byte esp+04h], edx
        mov dword [esp], ecx
        call RequestSpeechEvent
        add esp, byte 30h
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueueFinalSpeech                                40574  97 PC, low confidence
; Play-by-play: queues the phrase at the end of the game
;-----------------------------------------------------------------------------
QueueFinalSpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 1Ah
        mov eax, dword [byte esp+040h]
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], ecx
        mov dword [byte esp+014h], eax
        mov eax, esp
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret 4
        push ecx
        push esi
        push edi
        sub esp, byte 30h
        mov ecx, eax
        xor eax, eax
.2:
        add eax, byte 4
        xor esi, esi
        mov dword [byte esp+eax-04h], esi
        cmp eax, byte 30h
        jne short .2
        mov edi, 1Bh
        mov eax, esp
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [esp], edi
        call RequestSpeechEvent
        add esp, byte 30h
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueueTouchPuckSpeech                            405F8  97 PC, low confidence
; Play-by-play: queues the phrase for a touch that stops play (icing,
; offside)
;-----------------------------------------------------------------------------
QueueTouchPuckSpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 1Ch
        mov eax, dword [byte esp+040h]
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], ecx
        mov dword [byte esp+014h], eax
        mov eax, esp
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; QueuePenaltyCallSpeech                          40640  97 PC, low confidence
; Play-by-play: queues the phrase for a called penalty
;-----------------------------------------------------------------------------
QueuePenaltyCallSpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 1Dh
        mov eax, esp
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], ecx
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueueStoppageSpeech                             40680  97 PC, low confidence
; Play-by-play: queues the phrases at a stoppage (new penalty, goalies, line
; change)
;-----------------------------------------------------------------------------
QueueStoppageSpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 1Eh
        mov eax, dword [byte esp+040h]
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+014h], eax
        mov eax, dword [byte esp+044h]
        mov dword [byte esp+010h], ecx
        mov dword [byte esp+018h], eax
        mov eax, esp
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret 8
        push ebx
        push ecx
        push esi
        sub esp, byte 30h
        mov ebx, eax
        xor eax, eax
.2:
        add eax, byte 4
        xor ecx, ecx
        mov dword [byte esp+eax-04h], ecx
        cmp eax, byte 30h
        jne short .2
        mov esi, 1Fh
        mov eax, esp
        mov dword [byte esp+04h], ebx
        mov dword [byte esp+08h], edx
        mov dword [esp], esi
        call RequestSpeechEvent
        add esp, byte 30h
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        sub esp, byte 30h
        mov edx, eax
        xor eax, eax
.3:
        add eax, byte 4
        xor ebx, ebx
        mov dword [byte esp+eax-04h], ebx
        cmp eax, byte 30h
        jne short .3
        mov ecx, 20h
        mov eax, esp
        mov dword [byte esp+04h], edx
        mov dword [esp], ecx
        call RequestSpeechEvent
        add esp, byte 30h
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push esi
        sub esp, byte 30h
        mov ebx, eax
        xor eax, eax
.4:
        add eax, byte 4
        xor ecx, ecx
        mov dword [byte esp+eax-04h], ecx
        cmp eax, byte 30h
        jne short .4
        mov esi, 21h
        mov eax, esp
        mov dword [byte esp+04h], ebx
        mov dword [byte esp+08h], edx
        mov dword [esp], esi
        call RequestSpeechEvent
        add esp, byte 30h
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push esi
        sub esp, byte 30h
        mov ebx, eax
        xor eax, eax
.5:
        add eax, byte 4
        xor ecx, ecx
        mov dword [byte esp+eax-04h], ecx
        cmp eax, byte 30h
        jne short .5
        mov esi, 22h
        mov eax, esp
        mov dword [byte esp+04h], ebx
        mov dword [byte esp+08h], edx
        mov dword [esp], esi
        call RequestSpeechEvent
        add esp, byte 30h
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ecx
        push esi
        push edi
        sub esp, byte 30h
        mov ecx, eax
        xor eax, eax
.6:
        add eax, byte 4
        xor esi, esi
        mov dword [byte esp+eax-04h], esi
        cmp eax, byte 30h
        jne short .6
        mov edi, 23h
        mov eax, esp
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [esp], edi
        call RequestSpeechEvent
        add esp, byte 30h
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        sub esp, byte 30h
        mov edx, eax
        xor eax, eax
.7:
        add eax, byte 4
        xor ebx, ebx
        mov dword [byte esp+eax-04h], ebx
        cmp eax, byte 30h
        jne short .7
        mov ecx, 24h
        mov eax, esp
        mov dword [byte esp+04h], edx
        mov dword [esp], ecx
        call RequestSpeechEvent
        add esp, byte 30h
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        sub esp, byte 30h
        mov edx, eax
        xor eax, eax
.8:
        add eax, byte 4
        xor ebx, ebx
        mov dword [byte esp+eax-04h], ebx
        cmp eax, byte 30h
        jne short .8
        mov ecx, 25h
        mov eax, esp
        mov dword [byte esp+04h], edx
        mov dword [esp], ecx
        call RequestSpeechEvent
        add esp, byte 30h
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QueuePowerPlaySpeech                            40850  97 PC, low confidence
; Play-by-play: queues the phrase for a power play
;-----------------------------------------------------------------------------
QueuePowerPlaySpeech:
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        xor eax, eax
.1:
        add eax, byte 4
        xor edi, edi
        mov dword [byte esp+eax-04h], edi
        cmp eax, byte 30h
        jne short .1
        mov ebp, 26h
        mov eax, esp
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], ecx
        mov dword [esp], ebp
        call RequestSpeechEvent
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
        push ebx
        push edx
        sub esp, byte 30h
        xor eax, eax
.2:
        add eax, byte 4
        xor edx, edx
        mov dword [byte esp+eax-04h], edx
        cmp eax, byte 30h
        jne short .2
        mov ebx, 27h
        mov eax, esp
        mov dword [esp], ebx
        call RequestSpeechEvent
        add esp, byte 30h
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
        push ecx
        push esi
        push edi
        sub esp, byte 30h
        mov ecx, eax
        xor eax, eax
.3:
        add eax, byte 4
        xor esi, esi
        mov dword [byte esp+eax-04h], esi
        cmp eax, byte 30h
        jne short .3
        mov edi, 28h
        mov eax, esp
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [esp], edi
        call RequestSpeechEvent
        add esp, byte 30h
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
        push ebx
        push edx
        mov edx, 0FFFFFFFFh
        xor eax, eax
.4:
        add eax, byte 0Ch
        mov dword [dword eax+SpeechPlaying], edx
        cmp eax, 0C0h
        jne short .4
        xor ebx, ebx
        mov dword [LastSfxPlayed], ebx
        pop edx
        pop ebx
        ret
        push ecx
        push esi
        mov ecx, eax
        mov esi, edx
        mov edx, dword [LastSfxPlayed]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov dword [nosplit eax*4+SfxChannelIds], ecx
        mov dword [nosplit eax*4+SfxChannelTimes], esi
        inc edx
        mov dword [nosplit eax*4+SfxChannelRecords], ebx
        mov ebx, 10h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov dword [LastSfxPlayed], edx
        pop esi
        pop ecx
        ret
