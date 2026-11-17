; Sound: PrepareBankSamples.
bits 32
%include "hockey.inc"
section s_1071F4 progbits alloc exec nowrite align=1
extern LoadSampleHeader, ReleaseBankSample, SoundBankSamples, SoundBankTable
global PrepareBankSamples
;-----------------------------------------------------------------------------
; PrepareBankSamples                             1071F4  97 PC, low confidence
; Relocates each sample offset of a bank and loads the samples into the sound
; driver
;-----------------------------------------------------------------------------
PrepareBankSamples:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 0C08h
        mov edi, eax
        mov edx, 0FFFFFFFFh
        lea esi, [nosplit eax*8+00h]
        xor ebx, ebx
        xor ebp, ebp
        xor ecx, ecx
        mov dword [dword esp+0C04h], edx
        mov dword [dword esp+0C00h], ebx
.1:
        mov edx, dword [dword esi+SoundBankTable]
        lea eax, [edx+ecx]
        mov ebx, dword [byte eax+08h]
        test ebx, ebx
        je short .2
        add edx, byte 8
        add edx, ecx
        add edx, ebx
        mov dword [byte eax+08h], edx
        mov eax, dword [dword esi+SoundBankTable]
        mov ebx, esp
        mov edx, dword [dword esi+SoundBankSamples]
        mov eax, dword [byte ecx+eax+08h]
        call LoadSampleHeader
        mov dword [dword esp+0C00h], eax
        test eax, eax
        jge short .2
        dec ebp
        mov dword [dword esp+0C04h], ebp
        jmp short .3
.2:
        add ecx, byte 4
        inc ebp
        cmp ecx, 200h
        jl short .1
.3:
        cmp dword [dword esp+0C04h], byte 0FFFFFFFFh
        jle short .5
        mov esi, dword [dword esp+0C04h]
        xor ecx, ecx
        test esi, esi
        jl short .5
        mov ebp, dword [dword esp+0C04h]
.4:
        mov edx, ecx
        mov eax, edi
        inc ecx
        call ReleaseBankSample
        cmp ecx, ebp
        jle short .4
.5:
        mov eax, dword [dword esp+0C00h]
        add esp, 0C08h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
