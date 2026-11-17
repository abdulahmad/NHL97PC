; Sound: FindSpeechEvent, ParseSpeechEvents, InitSpeechBank.
bits 32
%include "hockey.inc"
section s_105F6C progbits alloc exec nowrite align=1
extern SpeechBankBase
global FindSpeechEvent, ParseSpeechEvents, ParseSpeechEvents_86, InitSpeechBank
;-----------------------------------------------------------------------------
; FindSpeechEvent                                105F6C  97 PC, low confidence
; Finds an event in the speech bank
;-----------------------------------------------------------------------------
FindSpeechEvent:
        push ebx
        push ecx
        push esi
        push edi
        mov ecx, eax
        xor eax, eax
        cmp dword [edx], 7673656Eh
        jne short .3
        mov eax, dword [byte edx+0Ch]
        mov esi, dword [byte edx+08h]
        xor ebx, ebx
        add eax, ecx
        shl esi, 2
        mov dword [byte edx+0Ch], eax
        jmp short .2
.1:
        mov eax, dword [byte edx+0Ch]
        mov edi, dword [ebx+eax]
        add edi, ecx
        mov dword [ebx+eax], edi
        add ebx, byte 4
.2:
        cmp ebx, esi
        jl short .1
        mov eax, 1
.3:
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ParseSpeechEvents                              105FAA  97 PC, low confidence
; Parses the events of the speech bank
;-----------------------------------------------------------------------------
ParseSpeechEvents:
        push ebx
        push ecx
        push esi
        push edi
        enter 0Ch, 0
        mov ecx, eax
        mov ebx, edx
        mov edx, 1
        cmp dword [ebx], 76657674h
        je short .1
        xor edx, edx
        jmp short .6
.1:
        mov eax, dword [byte ebx+014h]
        add eax, ecx
        mov dword [byte ebx+014h], eax
        mov eax, dword [byte ebx+010h]
        shl eax, 2
        xor esi, esi
        mov dword [byte ebp-08h], eax
        jmp short .3
.2:
        mov eax, dword [byte ebx+014h]
        mov edi, dword [esi+eax]
        add edi, ecx
        mov dword [esi+eax], edi
        add esi, byte 4
.3:
        cmp esi, dword [byte ebp-08h]
        jl short .2
        mov eax, dword [byte ebx+01Ch]
        add eax, ecx
        mov dword [byte ebx+01Ch], eax
        mov eax, dword [byte ebx+018h]
        shl eax, 2
        xor esi, esi
        mov dword [byte ebp-04h], eax
        jmp short .5
.4:
        mov eax, dword [byte ebx+01Ch]
        mov eax, dword [esi+eax]
        lea edx, [ecx+eax]
        mov eax, ecx
        mov dword [byte ebp-0Ch], edx
        call FindSpeechEvent
        mov edx, eax
        test eax, eax
        je short .6
        mov eax, dword [byte ebx+01Ch]
        mov edi, dword [byte ebp-0Ch]
        mov dword [esi+eax], edi
        add esi, byte 4
.5:
        cmp esi, dword [byte ebp-04h]
        jl short .4
.6:
        mov eax, edx
ParseSpeechEvents_86:
        leave
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; InitSpeechBank                                 106036  97 PC, low confidence
; Sets up a speech bank
;-----------------------------------------------------------------------------
InitSpeechBank:
        push ebx
        push ecx
        push edx
        push esi
        enter 4, 0
        mov ebx, eax
        mov dword [SpeechBankBase], eax
        xor edx, edx
        cmp dword [eax], 76646174h
        jne short .3
        mov eax, dword [byte eax+010h]
        add eax, ebx
        mov dword [byte ebx+010h], eax
        mov eax, dword [SpeechBankBase]
        mov esi, dword [byte eax+014h]
        mov ecx, dword [byte eax+018h]
        shl esi, 2
        add ecx, ebx
        mov dword [byte ebp-04h], esi
        mov dword [byte eax+018h], ecx
        xor ecx, ecx
        jmp short .2
.1:
        mov eax, dword [SpeechBankBase]
        mov eax, dword [byte eax+018h]
        mov esi, dword [ecx+eax]
        add esi, ebx
        mov eax, ebx
        mov edx, esi
        call ParseSpeechEvents
        mov edx, eax
        test eax, eax
        je short .3
        mov eax, dword [SpeechBankBase]
        mov eax, dword [byte eax+018h]
        mov dword [ecx+eax], esi
        add ecx, byte 4
.2:
        cmp ecx, dword [byte ebp-04h]
        jl short .1
.3:
        mov eax, edx
        leave
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
