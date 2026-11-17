; EA library: PickRandomClip, PickClipVariant, ClipValue, PickEventClip.
bits 32
%include "hockey.inc"
section s_1060A8 progbits alloc exec nowrite align=1
extern FindSpeechBank, Random32, SpeechBankTable
global PickRandomClip, PickClipVariant, ClipValue, PickEventClip
;-----------------------------------------------------------------------------
; PickRandomClip                                 1060A8  97 PC, low confidence
; Picks a random clip from a list
;-----------------------------------------------------------------------------
PickRandomClip:
        push ecx
        push esi
        push edi
        enter 8, 0
        push ebx
        mov dword [byte ebp-04h], 0
        test eax, eax
        je short .4
        movzx esi, byte [eax]
        test esi, esi
        jl short .4
        cmp esi, byte 3
        jg short .4
        mov ebx, eax
        xor edi, edi
        jmp short .3
.1:
        movzx eax, byte [byte ebx+01h]
        mov dword [byte ebp-08h], eax
        call Random32
        mov ecx, 64h
        xor edx, edx
        div ecx
        cmp edx, dword [byte ebp-08h]
        jge short .2
        movzx eax, byte [byte ebx+02h]
        cmp eax, dword [byte ebp-0Ch]
        jne short .2
        mov dword [byte ebp-04h], 1
        jmp short .4
.2:
        inc edi
        inc ebx
        inc ebx
.3:
        cmp edi, esi
        jl short .1
.4:
        mov eax, dword [byte ebp-04h]
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; PickClipVariant                                106108  97 PC, low confidence
; Picks a variant of a clip
;-----------------------------------------------------------------------------
PickClipVariant:
        push esi
        push edi
        enter 20h, 0
        mov esi, ebx
        mov dword [byte ebp-014h], ecx
        mov dword [byte ebp-04h], 0
        mov ecx, 1
        movsx edi, word [byte ebx+08h]
        shl eax, 2
        mov dword [byte ebp-01Ch], edi
        mov dword [byte ebp-020h], eax
        mov edi, edx
        jmp near .10
.1:
        mov dword [byte ebp-08h], 0
        mov edx, eax
        mov eax, dword [byte edi+010h]
        xor ecx, ecx
        mov dword [byte ebp-0Ch], eax
        movsx eax, byte [byte esi+0Ch]
        shl edx, 2
        mov dword [byte ebp-010h], eax
        test eax, eax
        jl near .4
        mov eax, dword [byte ebp-020h]
        mov eax, dword [dword eax+SpeechBankTable]
        mov eax, dword [byte eax+018h]
        mov eax, dword [edx+eax]
        mov dword [byte ebp-08h], 1
        test eax, eax
        je near .11
        cmp dword [eax], 766D6170h
        jne near .11
        mov edx, dword [byte ebp-010h]
        shl edx, 2
        add edx, dword [byte ebp-014h]
        mov ebx, dword [byte eax+04h]
        mov edx, dword [edx]
        test edx, edx
        jl short .2
        test ebx, ebx
        jle short .2
        cmp edx, ebx
        jge short .2
        mov ebx, edx
        shl ebx, 2
        add eax, ebx
        mov ebx, dword [byte ebp-0Ch]
        mov eax, dword [byte eax+08h]
        call PickRandomClip
        test eax, eax
        je short .4
        jmp short .3
.2:
        mov eax, dword [byte ebp-010h]
        shl eax, 2
        add eax, dword [byte ebp-014h]
        mov edx, dword [byte ebp-0Ch]
        cmp edx, dword [eax]
        jne short .4
.3:
        mov ecx, 1
.4:
        test ecx, ecx
        jne short .8
        mov eax, esi
        xor edx, edx
        jmp short .7
.5:
        movsx ebx, byte [byte eax+0Dh]
        mov dword [byte ebp-018h], ebx
        test ebx, ebx
        jl short .6
        mov ebx, dword [byte ebp-0Ch]
        mov dword [byte ebp-08h], 1
        cmp ebx, dword [byte ebp-018h]
        jne short .6
        mov ecx, 1
        jmp short .8
.6:
        inc edx
        inc eax
.7:
        cmp edx, byte 3
        jl short .5
.8:
        cmp dword [byte ebp-08h], byte 0
        jne short .9
        mov ecx, 1
.9:
        test ecx, ecx
        je short .11
        inc dword [byte ebp-04h]
        add esi, byte 4
        add edi, byte 4
.10:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [byte ebp-01Ch]
        jl near .1
.11:
        mov eax, ecx
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; ClipValue                                      106223  97 PC, low confidence
; Returns a clip value or variable
;-----------------------------------------------------------------------------
ClipValue:
        cmp word [byte eax+06h], byte 0
        jl short .1
        movsx eax, word [byte eax+06h]
        mov eax, dword [edx+eax*4]
        ret
.1:
        movsx eax, word [byte eax+04h]
        jmp near FindSpeechBank
;-----------------------------------------------------------------------------
; PickEventClip                                  10623B  97 PC, low confidence
; Picks the clip for an event
;-----------------------------------------------------------------------------
PickEventClip:
        push esi
        push edi
        enter 1Ch, 0
        push eax
        push edx
        push ebx
        push ecx
        mov edi, ebx
        shl edi, 2
        mov eax, dword [dword edi+SpeechBankTable]
        xor esi, esi
        mov eax, dword [byte eax+0Ch]
        mov dword [byte ebp-04h], esi
        shl eax, 2
        mov dword [byte ebp-01Ch], edi
        mov dword [byte ebp-010h], eax
        jmp short .5
.1:
        mov edi, dword [byte ebp-01Ch]
        mov edi, dword [dword edi+SpeechBankTable]
        mov edi, dword [byte edi+010h]
        add edi, eax
        mov edi, dword [edi]
        mov dword [byte ebp-0Ch], edi
        mov eax, dword [byte edi+04h]
        mov edi, esi
        mov dword [byte ebp-08h], 0
        shl edi, 2
        mov dword [byte ebp-018h], eax
        add edi, dword [byte ebp-020h]
        jmp short .4
.2:
        mov eax, dword [byte ebp-0Ch]
        mov ecx, dword [byte ebp+010h]
        mov eax, dword [byte eax+08h]
        mov ebx, dword [byte ebp-02Ch]
        mov dword [byte ebp-014h], eax
        mov edx, eax
        mov eax, dword [byte ebp-028h]
        call PickClipVariant
        test eax, eax
        je short .3
        mov eax, dword [byte ebp-014h]
        inc esi
        mov dword [edi], eax
        add edi, byte 4
        cmp esi, dword [byte ebp-024h]
        jge short .6
.3:
        inc dword [byte ebp-08h]
        add dword [byte ebp-0Ch], byte 4
.4:
        mov eax, dword [byte ebp-08h]
        cmp eax, dword [byte ebp-018h]
        jl short .2
        add dword [byte ebp-04h], byte 4
.5:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [byte ebp-010h]
        jl short .1
.6:
        mov eax, esi
        leave
        pop edi
        pop esi
        ret 4
