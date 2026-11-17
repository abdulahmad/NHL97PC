; Sound: BuildSpeechPhrase, MatchPhraseRule, CheckRangeCondition, CheckValueCondition and 10 more.
bits 32
%include "hockey.inc"
section s_1062DB progbits alloc exec nowrite align=1
extern ClipValue, ParseSpeechEvents_86, PickEventClip, Random32, SpeechBankBase, SpeechBusy, SpeechChannelA, SpeechChannelB
extern SpeechChannelFunc, SpeechEnabled, SpeechEventBuf, SpeechEventCount, SpeechEventId, SpeechEventQueue, SpeechEventTime, SpeechRingBusy
extern tickcount
global BuildSpeechPhrase, MatchPhraseRule, CheckRangeCondition, CheckValueCondition, CheckFlagCondition, CheckPhraseConditions, BuildSpeechEvent, ClearSpeechQueue
global QueueSpeechEvent, QueueSpeechEvent_AD, QueueSpeechEvent_AE, RequestSpeechEvent, PickNextSpeech, SpeechAge, PlayQueuedSpeech, SetSpeechEnabled
;-----------------------------------------------------------------------------
; BuildSpeechPhrase                              1062DB  97 PC, low confidence
; Builds a spoken phrase
;-----------------------------------------------------------------------------
BuildSpeechPhrase:
        push ebx
        push ecx
        push esi
        push edi
        enter 118h, 0
        mov esi, eax
        mov dword [byte ebp-014h], edx
        mov edi, dword [byte eax+018h]
        xor eax, eax
        jmp short .2
.1:
        mov byte [dword eax+ebp-0118h], al
        inc eax
.2:
        cmp eax, edi
        jl short .1
        mov dword [byte ebp-08h], 0
.3:
        test edi, edi
        jle near ParseSpeechEvents_86
        mov eax, dword [byte ebp-08h]
        mov dword [byte ebp-010h], 0
        add eax, dword [byte ebp-014h]
        mov dword [byte ebp-04h], 64h
        mov dword [byte ebp-0Ch], eax
.4:
        cmp dword [byte ebp-010h], byte 0
        jne short .3
        call Random32
        xor edx, edx
        div edi
        mov ecx, dword [byte esi+01Ch]
        movzx eax, byte [dword edx+ebp-0118h]
        mov eax, dword [ecx+eax*4]
        mov eax, dword [byte eax+04h]
        mov ebx, edx
        mov dword [byte ebp-018h], eax
        call Random32
        xor edx, edx
        div dword [byte ebp-04h]
        mov eax, dword [byte ebp-04h]
        mov ecx, edx
        cdq
        LD sub, eax, edx
        sar eax, 1
        mov dword [byte ebp-04h], eax
        cmp ecx, dword [byte ebp-018h]
        jl short .5
        test eax, eax
        jne short .4
.5:
        mov ecx, dword [byte ebp-0Ch]
        inc dword [byte ebp-08h]
        mov al, byte [dword ebx+ebp-0118h]
        dec edi
        mov byte [ecx], al
        mov dword [byte ebp-010h], 1
        mov al, byte [dword edi+ebp-0118h]
        inc dword [byte ebp-0Ch]
        mov byte [dword ebx+ebp-0118h], al
        jmp short .4
;-----------------------------------------------------------------------------
; MatchPhraseRule                                106390  97 PC, low confidence
; Matches a phrase rule
;-----------------------------------------------------------------------------
MatchPhraseRule:
        push ecx
        push esi
        push edi
        enter 10h, 0
        mov ecx, eax
        mov dword [byte ebp-0Ch], ebx
        mov eax, dword [byte eax+010h]
        test eax, eax
        jle near .4
        mov ebx, edx
        shl eax, 2
        xor esi, esi
        mov dword [byte ebp-04h], eax
        jmp short .3
.1:
        mov eax, dword [byte ecx+014h]
        mov eax, dword [esi+eax]
        mov dl, byte [eax]
        cmp dl, 2
        jne short .2
        movzx edx, byte [byte ebx+011h]
        cmp edx, byte 2
        jne short .2
        mov edx, dword [SpeechBankBase]
        mov edi, dword [byte edx+0Ch]
        mov dword [byte ebp-08h], edi
        mov edi, dword [byte eax+04h]
        mov eax, dword [byte eax+08h]
        inc eax
        test edi, edi
        jl short .4
        cmp edi, dword [byte ebp-08h]
        jge short .4
        test eax, eax
        jl short .4
        cmp eax, byte 0Ch
        jg short .4
        shl eax, 2
        add eax, dword [byte ebp-0Ch]
        mov eax, dword [eax]
        mov dword [byte ebp-010h], eax
        mov eax, edi
        mov edx, dword [byte edx+010h]
        shl eax, 2
        add eax, edx
        mov edx, dword [byte ebp-010h]
        mov dword [eax], edx
.2:
        inc ebx
        add esi, byte 4
.3:
        cmp esi, dword [byte ebp-04h]
        jl short .1
.4:
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; CheckRangeCondition                            106416  97 PC, low confidence
; Checks a range condition of a phrase rule
;-----------------------------------------------------------------------------
CheckRangeCondition:
        push ecx
        push esi
        push edi
        mov esi, edx
        mov ecx, dword [byte eax+04h]
        mov edi, dword [byte eax+08h]
        inc ecx
        xor edx, edx
        test ecx, ecx
        jl short .6
        cmp ecx, byte 0Ch
        jg short .6
        mov eax, ecx
        mov edx, dword [esi+eax*4]
        cmp ebx, byte 2
        jb short .1
        jbe short .2
        cmp ebx, byte 3
        je short .4
        jmp short .5
.1:
        cmp ebx, byte 1
        jne short .5
        mov edx, ebx
        jmp short .6
.2:
        cmp edi, edx
        sete al
.3:
        movzx eax, al
        mov edx, eax
        jmp short .6
.4:
        cmp edi, edx
        setne al
        jmp short .3
.5:
        mov edx, 1
.6:
        mov eax, edx
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; CheckValueCondition                            106467  97 PC, low confidence
; Checks a value condition of a phrase rule
;-----------------------------------------------------------------------------
CheckValueCondition:
        push ecx
        push esi
        enter 8, 0
        push edx
        mov ecx, ebx
        mov edx, dword [SpeechBankBase]
        mov esi, dword [byte edx+0Ch]
        mov dword [byte ebp-08h], esi
        mov esi, dword [byte eax+04h]
        mov eax, dword [byte eax+08h]
        inc eax
        xor ebx, ebx
        mov dword [byte ebp-04h], eax
        test esi, esi
        jl short .5
        cmp esi, dword [byte ebp-08h]
        jge short .5
        test eax, eax
        jl short .5
        cmp eax, byte 0Ch
        jg short .5
        mov eax, dword [byte edx+010h]
        mov edx, dword [eax+esi*4]
        mov eax, dword [byte ebp-04h]
        shl eax, 2
        add eax, dword [byte ebp-0Ch]
        mov eax, dword [eax]
        cmp ecx, byte 2
        jb short .1
        jbe short .2
        cmp ecx, byte 3
        je short .3
        jmp short .4
.1:
        cmp ecx, byte 1
        jne short .4
        mov ebx, ecx
        jmp short .5
.2:
        cmp edx, eax
        jne short .5
        jmp short .4
.3:
        cmp edx, eax
        je short .5
.4:
        mov ebx, 1
.5:
        mov eax, ebx
        leave
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; CheckFlagCondition                             1064D7  97 PC, low confidence
; Checks a flag condition of a phrase rule
;-----------------------------------------------------------------------------
CheckFlagCondition:
        push ecx
        push esi
        push edi
        enter 4, 0
        mov ecx, ebx
        mov edx, dword [SpeechBankBase]
        mov esi, dword [byte edx+0Ch]
        mov edi, dword [byte eax+08h]
        mov dword [byte ebp-04h], esi
        mov esi, dword [byte eax+04h]
        xor ebx, ebx
        test esi, esi
        jl short .5
        cmp esi, dword [byte ebp-04h]
        jge short .5
        mov eax, dword [byte edx+010h]
        mov eax, dword [eax+esi*4]
        cmp ecx, byte 2
        jb short .1
        jbe short .2
        cmp ecx, byte 3
        je short .3
        jmp short .4
.1:
        cmp ecx, byte 1
        jne short .4
        mov ebx, ecx
        jmp short .5
.2:
        cmp eax, edi
        jne short .5
        jmp short .4
.3:
        cmp eax, edi
        je short .5
.4:
        mov ebx, 1
.5:
        mov eax, ebx
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; CheckPhraseConditions                          106530  97 PC, low confidence
; Checks the conditions of a phrase rule
;-----------------------------------------------------------------------------
CheckPhraseConditions:
        push ecx
        push esi
        push edi
        enter 0Ch, 0
        mov ecx, eax
        mov esi, ebx
        mov eax, edx
        mov edi, dword [byte ecx+010h]
        mov edx, 1
        test edi, edi
        jle near .8
        mov dword [byte ebp-08h], 0
        shl edi, 2
        mov dword [byte ebp-0Ch], eax
        mov dword [byte ebp-04h], edi
        jmp short .7
.1:
        mov eax, dword [byte ecx+014h]
        add eax, dword [byte ebp-08h]
        mov eax, dword [eax]
        mov edi, dword [byte ebp-0Ch]
        mov bl, byte [eax]
        movzx edi, byte [byte edi+011h]
        cmp bl, 1
        jb short .2
        jbe short .4
        cmp bl, 3
        je short .3
        jmp short .6
.2:
        test bl, bl
        jne short .6
        mov ebx, edi
        mov edx, esi
        call CheckRangeCondition
        jmp short .5
.3:
        mov ebx, edi
        mov edx, esi
        call CheckFlagCondition
        jmp short .5
.4:
        mov ebx, edi
        mov edx, esi
        call CheckValueCondition
.5:
        mov edx, eax
.6:
        test edx, edx
        je short .8
        inc dword [byte ebp-0Ch]
        add dword [byte ebp-08h], byte 4
.7:
        mov eax, dword [byte ebp-08h]
        cmp eax, dword [byte ebp-04h]
        jl short .1
.8:
        mov eax, edx
        leave
        pop edi
        pop esi
        pop ecx
        ret
        push ebx
        push ecx
        push esi
        mov esi, edx
        xor ebx, ebx
        xor edx, edx
        jmp short .10
.9:
        mov ecx, dword [byte eax+010h]
        add eax, byte 14h
        inc ebx
        add edx, dword [byte ecx+04h]
.10:
        cmp ebx, esi
        jl short .9
        mov eax, edx
        cdq
        shl edx, 4
        LD sbb, eax, edx
        sar eax, 4
        imul eax, byte 1Ch
        mov ebx, 6Eh
        cdq
        idiv ebx
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; BuildSpeechEvent                               1065F0  97 PC, low confidence
; Builds the speech for an event
;-----------------------------------------------------------------------------
BuildSpeechEvent:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 1E4h, 0
        push eax
        sub ebp, 82h
        mov eax, dword [eax]
        mov dword [byte ebp+072h], eax
        mov eax, dword [SpeechBankBase]
        mov edx, dword [byte ebp+072h]
        mov esi, dword [byte eax+018h]
        mov dword [byte ebp+07Eh], 0
        mov esi, dword [esi+edx*4]
        mov dword [byte ebp+042h], 0
        mov dword [byte ebp+066h], 0
        cmp dword [esi], 76657674h
        jne near .33
        movsx eax, word [byte esi+04h]
        cmp eax, edx
        jne near .33
        cmp edx, dword [SpeechChannelA]
        jne short .1
        cmp byte [byte esi+06h], 0
        jle short .1
        movsx eax, byte [byte esi+06h]
        cmp eax, dword [SpeechChannelB]
        jle near .33
.1:
        cmp dword [SpeechEventCount], byte 1
        jle short .2
        mov dword [byte ebp+042h], 1
.2:
        lea edx, [dword ebp-0162h]
        mov eax, esi
        call BuildSpeechPhrase
        mov eax, dword [byte esi+018h]
        mov dword [byte ebp+04Ah], eax
.3:
        cmp dword [byte ebp+07Eh], byte 0
        jne near .27
        mov eax, dword [byte ebp+066h]
        cmp eax, dword [byte ebp+04Ah]
        jge near .27
        movzx eax, byte [dword eax+ebp-0162h]
        mov dword [byte ebp+07Eh], 1
        test eax, eax
        jl near .33
        cmp eax, dword [byte ebp+04Ah]
        jge near .33
        mov edx, dword [byte esi+01Ch]
        mov eax, dword [edx+eax*4]
        mov dword [byte ebp+06Ah], eax
        mov eax, dword [byte eax+08h]
        mov dword [byte ebp+07Ah], eax
        cmp eax, byte 8
        jg near .33
        mov ebx, dword [dword ebp-0166h]
        mov edx, dword [byte ebp+06Ah]
        mov eax, esi
        call CheckPhraseConditions
        test eax, eax
        jne short .4
        mov dword [byte ebp+07Eh], eax
        jmp near .26
.4:
        mov dword [byte ebp+062h], 0
        mov eax, dword [byte ebp+07Ah]
        mov dword [byte ebp+06Eh], 0
        shl eax, 2
        xor edi, edi
        mov dword [byte ebp+05Ah], eax
        jmp short .8
.5:
        mov eax, dword [byte ebp+06Eh]
        shl eax, 2
        add eax, SpeechEventBuf
        mov ecx, dword [byte ebp+06Ah]
        mov dword [byte edi+ebp-056h], eax
        mov ecx, dword [byte ecx+0Ch]
        add ecx, dword [byte ebp+062h]
        mov ecx, dword [ecx]
        mov edx, dword [dword ebp-0166h]
        mov eax, ecx
        call ClipValue
        mov dword [byte edi+ebp-062h], eax
        test eax, eax
        jge short .6
        mov dword [byte ebp+07Eh], 0
        jmp short .9
.6:
        push dword [dword ebp-0166h]
        mov edx, 40h
        mov ebx, eax
        sub edx, dword [byte ebp+06Eh]
        mov eax, dword [byte edi+ebp-056h]
        call PickEventClip
        test eax, eax
        jne short .7
        mov dword [byte ebp+07Eh], eax
        jmp short .9
.7:
        add edi, byte 14h
        add dword [byte ebp+062h], byte 4
        add dword [byte ebp+06Eh], eax
        mov dword [byte edi+ebp-072h], eax
.8:
        mov eax, dword [byte ebp+062h]
        cmp eax, dword [byte ebp+05Ah]
        jl short .5
.9:
        cmp dword [byte ebp+07Eh], byte 0
        je near .26
        cmp dword [byte ebp+042h], byte 0
        jne short .10
        cmp dword [SpeechEnabled], byte 0
        je near .23
.10:
        cmp byte [byte esi+08h], 0
        je near .23
        imul eax, dword [byte ebp+07Ah], byte 14h
        xor ebx, ebx
        mov dword [byte ebp+056h], eax
        jmp short .14
.11:
        mov eax, dword [byte ebx+ebp-05Eh]
        mov dword [byte ebp+046h], eax
        cdq
        LD sub, eax, edx
        sar eax, 1
        mov dword [byte ebp+076h], 0
        shl eax, 2
        mov edi, ebx
        mov dword [byte ebp+052h], eax
        jmp short .13
.12:
        call Random32
        xor edx, edx
        div dword [byte ebp+046h]
        mov eax, dword [byte edi+ebp-056h]
        mov ecx, dword [byte edi+ebp-056h]
        add eax, dword [byte ebp+076h]
        shl edx, 2
        mov eax, dword [eax]
        mov dword [byte edi+ebp-052h], eax
        lea eax, [edx+ecx]
        add ecx, dword [byte ebp+076h]
        mov eax, dword [eax]
        mov dword [ecx], eax
        mov eax, dword [byte edi+ebp-056h]
        add eax, edx
        mov edx, dword [byte edi+ebp-052h]
        add dword [byte ebp+076h], byte 4
        mov dword [eax], edx
.13:
        mov eax, dword [byte ebp+076h]
        cmp eax, dword [byte ebp+052h]
        jl short .12
        add ebx, byte 14h
.14:
        cmp ebx, dword [byte ebp+056h]
        jl short .11
        xor eax, eax
        imul edi, dword [byte ebp+07Ah], byte 14h
        jmp short .16
.15:
        mov ebx, dword [byte eax+ebp-056h]
        mov dword [byte eax+ebp-05Ah], 0
        add eax, byte 14h
        mov edx, dword [ebx]
        mov dword [byte eax+ebp-066h], edx
.16:
        cmp eax, edi
        jl short .15
        mov eax, dword [byte ebp+07Ah]
        dec eax
        mov dword [byte ebp+04Eh], eax
        imul eax, byte 14h
        mov dword [byte ebp+07Eh], 0
        mov dword [byte ebp+05Eh], 0
        mov dword [byte ebp+03Eh], eax
.17:
        cmp dword [byte ebp+05Eh], byte 0
        jne near .26
        cmp dword [byte ebp+07Eh], byte 0
        jne near .26
        lea eax, [byte ebp-062h]
        mov edx, dword [byte ebp+07Ah]
        xor ebx, ebx
        xor ecx, ecx
        jmp short .19
.18:
        mov edi, dword [byte eax+010h]
        add eax, byte 14h
        inc ecx
        add ebx, dword [byte edi+04h]
.19:
        cmp ecx, edx
        jl short .18
        mov eax, ebx
        cdq
        shl edx, 4
        LD sbb, eax, edx
        sar eax, 4
        imul eax, byte 1Ch
        mov ebx, 6Eh
        cdq
        idiv ebx
        mov edx, eax
        mov eax, dword [SpeechBankBase]
        cmp edx, dword [byte eax+04h]
        jge short .20
        mov dword [byte ebp+05Eh], 1
        mov dword [byte ebp+07Eh], 1
        jmp short .17
.20:
        mov ebx, dword [byte ebp+04Eh]
        mov eax, dword [byte ebp+03Eh]
        xor ecx, ecx
.21:
        test ecx, ecx
        jne short .17
        mov edx, dword [byte eax+ebp-05Eh]
        inc dword [byte eax+ebp-05Ah]
        cmp edx, dword [byte eax+ebp-05Ah]
        jle short .22
        mov ecx, dword [byte eax+ebp-056h]
        mov edx, dword [byte eax+ebp-05Ah]
        mov edx, dword [ecx+edx*4]
        mov ecx, 1
        mov dword [byte eax+ebp-052h], edx
        jmp short .21
.22:
        mov edi, dword [byte eax+ebp-056h]
        mov dword [byte eax+ebp-05Ah], ecx
        sub eax, byte 14h
        mov edx, dword [edi]
        dec ebx
        mov dword [byte eax+ebp-03Eh], edx
        test ebx, ebx
        jge short .21
        mov ecx, 1
        mov dword [byte ebp+05Eh], ecx
        jmp short .21
.23:
        xor edi, edi
        imul ebx, dword [byte ebp+07Ah], byte 14h
        jmp short .25
.24:
        call Random32
        xor edx, edx
        div dword [byte edi+ebp-05Eh]
        mov eax, edx
        mov edx, dword [byte edi+ebp-056h]
        add edi, byte 14h
        mov eax, dword [edx+eax*4]
        mov dword [byte edi+ebp-066h], eax
.25:
        cmp edi, ebx
        jl short .24
.26:
        inc dword [byte ebp+066h]
        jmp near .3
.27:
        cmp dword [byte ebp+07Eh], byte 0
        je short .33
        xor edi, edi
        imul ecx, dword [byte ebp+07Ah], byte 14h
        jmp short .30
.28:
        mov eax, dword [byte edi+ebp-052h]
        mov ebx, dword [byte eax+04h]
        mov edx, dword [byte eax+08h]
        test ebx, ebx
        je short .29
        mov eax, dword [byte edi+ebp-062h]
        call dword [SpeechChannelFunc]
        test eax, eax
        je short .29
        inc dword [SpeechRingBusy]
.29:
        add edi, byte 14h
.30:
        cmp edi, ecx
        jl short .28
        mov eax, dword [byte ebp+072h]
        cmp eax, dword [SpeechChannelA]
        jne short .31
        inc dword [SpeechChannelB]
        jmp short .32
.31:
        mov dword [SpeechChannelB], 1
        mov dword [SpeechChannelA], eax
.32:
        mov ebx, dword [dword ebp-0166h]
        mov edx, dword [byte ebp+06Ah]
        mov eax, esi
        call MatchPhraseRule
.33:
        lea esp, [dword ebp+082h]
        pop ebp
        jmp near QueueSpeechEvent_AE
;-----------------------------------------------------------------------------
; ClearSpeechQueue                               10699D  97 PC, low confidence
; Clears the speech queue
;-----------------------------------------------------------------------------
ClearSpeechQueue:
        push ebx
        push ecx
        push edx
        mov ebx, 30h
        mov dword [SpeechEventCount], 0
        xor edx, edx
.1:
        imul eax, edx, byte 3Ch
        mov dword [dword eax+SpeechEventId], 0
        mov dword [dword eax+SpeechEventTime], 0
        mov ecx, ebx
        mov dword [dword eax+SpeechEventQueue], 0
.2:
        add eax, byte 4
        mov dword [dword eax+SpeechEventQueue], 0
        cmp eax, ecx
        jne short .2
        inc edx
        add ebx, byte 3Ch
        cmp edx, byte 10h
        jl short .1
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; QueueSpeechEvent                               1069F2  97 PC, low confidence
; Adds an event to the speech queue
;-----------------------------------------------------------------------------
QueueSpeechEvent:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 4, 0
        mov esi, eax
        mov edx, 0FFFFFFFFh
        cmp dword [SpeechEventCount], byte 10h
        jge short .4
        xor eax, eax
        xor ebx, ebx
        jmp short .3
.1:
        cmp dword [dword eax+SpeechEventId], byte 0
        jne short .2
        mov edx, ebx
        jmp near .12
.2:
        inc ebx
        add eax, byte 3Ch
.3:
        cmp eax, 3C0h
        jl short .1
.4:
        mov eax, dword [tickcount]
        mov dword [byte ebp-04h], eax
        xor ecx, ecx
        xor eax, eax
        jmp short .8
.5:
        mov ebx, dword [dword eax+SpeechEventQueue]
        mov edi, dword [byte ebp-04h]
        movzx ebx, word [byte ebx+0Ch]
        sub edi, dword [dword eax+SpeechEventTime]
        cmp edi, ebx
        jbe short .7
        mov dword [dword eax+SpeechEventId], 0
        mov edx, ecx
.6:
        dec dword [SpeechEventCount]
        jmp short .12
.7:
        inc ecx
        add eax, byte 3Ch
.8:
        cmp eax, 3C0h
        jl short .5
        xor eax, eax
        xor ebx, ebx
        jmp short .11
.9:
        mov ecx, dword [dword eax+SpeechEventQueue]
        movzx ecx, word [byte ecx+0Eh]
        cmp ecx, esi
        ja short .10
        mov dword [dword eax+SpeechEventId], 0
        mov edx, ebx
        jmp short .6
.10:
        inc ebx
        add eax, byte 3Ch
.11:
        cmp eax, 3C0h
        jl short .9
.12:
        mov eax, edx
QueueSpeechEvent_AD:
        leave
QueueSpeechEvent_AE:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; RequestSpeechEvent                             106AA6  97 PC, low confidence
; Requests the speech for an event
;-----------------------------------------------------------------------------
RequestSpeechEvent:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov esi, eax
        mov edx, dword [eax]
        mov eax, dword [SpeechBankBase]
        mov ebx, dword [byte eax+018h]
        mov ebx, dword [ebx+edx*4]
        cmp dword [ebx], 76657674h
        jne short QueueSpeechEvent_AE
        movsx edi, byte [byte ebx+07h]
        call Random32
        mov ecx, 64h
        xor edx, edx
        div ecx
        cmp edx, edi
        jg short QueueSpeechEvent_AE
        movzx eax, word [byte ebx+0Eh]
        cmp dword [SpeechEnabled], byte 0
        je short .1
        cmp byte [byte ebx+09h], 0
        je short .1
        mov edx, dword [SpeechBankBase]
        cmp eax, dword [byte edx+08h]
        jb short QueueSpeechEvent_AE
.1:
        call QueueSpeechEvent
        test eax, eax
        jl short QueueSpeechEvent_AE
        imul edx, eax, byte 3Ch
        mov dword [dword edx+SpeechEventQueue], ebx
        mov eax, dword [tickcount]
        mov ebx, edx
        mov dword [dword edx+SpeechEventTime], eax
        mov eax, edx
        mov edx, esi
        add esi, byte 30h
        jmp short .3
.2:
        add ebx, byte 4
        mov ecx, dword [edx]
        add edx, byte 4
        mov dword [dword ebx+SpeechEventQueue], ecx
.3:
        cmp edx, esi
        jne short .2
        inc dword [SpeechEventCount]
        mov dword [dword eax+SpeechEventId], 1
        jmp near QueueSpeechEvent_AE
;-----------------------------------------------------------------------------
; PickNextSpeech                                 106B45  97 PC, low confidence
; Picks the next speech to play
;-----------------------------------------------------------------------------
PickNextSpeech:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 1Ch, 0
        mov eax, dword [tickcount]
        mov dword [byte ebp-0Ch], 0
        mov esi, 0FFFFFFFFh
        mov dword [byte ebp-018h], eax
        xor ebx, ebx
        mov dword [byte ebp-08h], esi
        xor eax, eax
.1:
        cmp dword [dword eax+SpeechEventId], byte 0
        je near .7
        mov ecx, dword [byte ebp-018h]
        mov edx, dword [dword eax+SpeechEventQueue]
        sub ecx, dword [dword eax+SpeechEventTime]
        mov dword [byte ebp-010h], 0
        mov dword [byte ebp-04h], ecx
        movzx ecx, word [byte edx+0Ch]
        mov dword [byte ebp-014h], 0
        cmp ecx, dword [byte ebp-04h]
        jae short .2
        mov dword [byte ebp-014h], 1
.2:
        cmp dword [SpeechEnabled], byte 0
        je short .3
        cmp byte [byte edx+09h], 0
        je short .3
        movzx ecx, word [byte edx+0Eh]
        mov dword [byte ebp-01Ch], ecx
        mov ecx, dword [SpeechBankBase]
        mov edi, dword [byte ebp-01Ch]
        cmp edi, dword [byte ecx+08h]
        jge short .3
        mov dword [byte ebp-010h], 1
.3:
        cmp dword [byte ebp-014h], byte 0
        jne short .4
        cmp dword [byte ebp-010h], byte 0
        je short .5
.4:
        mov dword [dword eax+SpeechEventId], 0
        dec dword [SpeechEventCount]
        jmp short .7
.5:
        movzx edx, word [byte edx+0Eh]
        cmp edx, dword [byte ebp-0Ch]
        jle short .6
        mov ecx, dword [byte ebp-04h]
        mov dword [byte ebp-0Ch], edx
        mov esi, ebx
        mov dword [byte ebp-08h], ecx
        jmp short .7
.6:
        jne short .7
        mov edx, dword [byte ebp-04h]
        cmp edx, dword [byte ebp-08h]
        jae short .7
        mov dword [byte ebp-08h], edx
        mov esi, ebx
.7:
        inc ebx
        add eax, byte 3Ch
        cmp ebx, byte 10h
        jl near .1
        mov eax, esi
        jmp near QueueSpeechEvent_AD
;-----------------------------------------------------------------------------
; SpeechAge                                      106C28  97 PC, low confidence
; Returns how long a speech has waited
;-----------------------------------------------------------------------------
SpeechAge:
        push ebx
        push ecx
        push edx
        mov edx, eax
        imul edx, byte 3Ch
        mov eax, dword [tickcount]
        mov ebx, eax
        mov ecx, eax
        xor eax, eax
        sub ecx, dword [dword edx+SpeechEventTime]
.1:
        cmp dword [dword eax+SpeechEventId], byte 0
        je short .2
        mov edx, ebx
        sub edx, dword [dword eax+SpeechEventTime]
        cmp edx, ecx
        jbe short .2
        mov dword [dword eax+SpeechEventId], 0
        dec dword [SpeechEventCount]
.2:
        add eax, byte 3Ch
        cmp eax, 3C0h
        jne short .1
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PlayQueuedSpeech                               106C74  97 PC, low confidence
; Plays the next queued speech
;-----------------------------------------------------------------------------
PlayQueuedSpeech:
        push edx
        cmp dword [SpeechEventCount], byte 0
        je short .1
        call SpeechBusy
        test eax, eax
        jne short .1
        call PickNextSpeech
        mov edx, eax
        test eax, eax
        jl short .1
        imul edx, byte 3Ch
        call SpeechAge
        mov eax, SpeechEventId
        add eax, edx
        add eax, byte 0Ch
        call BuildSpeechEvent
        dec dword [SpeechEventCount]
        mov dword [dword edx+SpeechEventId], 0
.1:
        pop edx
        ret
;-----------------------------------------------------------------------------
; SetSpeechEnabled                               106CBB  97 PC, low confidence
; Turns speech on or off
;-----------------------------------------------------------------------------
SetSpeechEnabled:
        mov dword [SpeechEnabled], eax
        ret
