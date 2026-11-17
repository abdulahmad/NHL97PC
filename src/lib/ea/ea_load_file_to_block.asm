; EA library: LoadFileToBlock, LoadFileToBlockShared, LoadFileToBlockPlain, RegisterSoundBank and 1 more.
bits 32
%include "hockey.inc"
section s_107000 progbits alloc exec nowrite align=1
extern bcopy, ChannelBankTable, ChannelSampleTable, DosCloseFile, DosOpenFile, DosReadFile, FindCachedFileData, FreeMemBlock
extern LastLoadedSize, MemPtrSize, PrepareBankSamples, SoundBankSamples, SoundBankTable, SoundSystemOn, StopChannel
global LoadFileToBlock, LoadFileToBlockShared, LoadFileToBlockPlain, RegisterSoundBank, UnregisterSoundBank
;-----------------------------------------------------------------------------
; LoadFileToBlock                                107000  97 PC, low confidence
; Returns a file already held in a named memory block, or loads it from disk
; into a new block
;-----------------------------------------------------------------------------
LoadFileToBlock:
        push ebx
        push esi
        push edi
        sub esp, byte 0Ch
        mov esi, dword [byte esp+020h]
        mov edx, dword [byte esp+01Ch]
        push edx
        call FindCachedFileData
        mov ebx, eax
        add esp, byte 4
        test eax, eax
        je short .1
        push eax
        call MemPtrSize
        add esp, byte 4
        push eax
        push esi
        push ebx
        call bcopy
        add esp, byte 0Ch
        push ebx
        call FreeMemBlock
        jmp short .3
.1:
        mov ebx, dword [byte esp+024h]
        push ebx
        lea eax, [byte esp+0Ch]
        push eax
        lea eax, [byte esp+0Ch]
        push eax
        lea eax, [byte esp+0Ch]
        push eax
        mov ecx, dword [byte esp+02Ch]
        push ecx
        call DosOpenFile
        add esp, byte 14h
        mov edi, dword [byte esp+08h]
        test edi, edi
        jne short .2
        xor ebx, ebx
        jmp short .4
.2:
        push edi
        push esi
        mov eax, dword [byte esp+08h]
        push eax
        call DosReadFile
        add esp, byte 0Ch
        mov edx, dword [esp]
        mov eax, dword [byte esp+08h]
        push edx
        mov ebx, esi
        mov dword [LastLoadedSize], eax
        call DosCloseFile
.3:
        add esp, byte 4
.4:
        mov eax, ebx
        add esp, byte 0Ch
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LoadFileToBlockShared                          107098  97 PC, low confidence
; Loads a file into a memory block in shared mode
;-----------------------------------------------------------------------------
LoadFileToBlockShared:
        push ebx
        push byte 1
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        call LoadFileToBlock
        add esp, byte 0Ch
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LoadFileToBlockPlain                           1070B0  97 PC, low confidence
; Loads a file into a memory block
;-----------------------------------------------------------------------------
LoadFileToBlockPlain:
        push ebx
        push byte 0
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        call LoadFileToBlock
        add esp, byte 0Ch
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; RegisterSoundBank                              1070D0  97 PC, low confidence
; Checks a BNKl sound bank header, stores it in a free bank slot and prepares
; its samples
;-----------------------------------------------------------------------------
RegisterSoundBank:
        push ecx
        push esi
        push edi
        mov esi, eax
        mov ecx, edx
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop edi
        pop esi
        pop ecx
        ret
.1:
        cmp dword [edx], 6C4B4E42h
        je short .2
        mov eax, 0FFFFFFF9h
        pop edi
        pop esi
        pop ecx
        ret
.2:
        mov edi, dword [SoundBankTable]
        xor edx, edx
        xor eax, eax
        test edi, edi
        jne short .5
.3:
        mov dword [dword eax+SoundBankTable], ecx
        mov dword [dword eax+SoundBankSamples], ebx
        mov eax, edx
        call PrepareBankSamples
        test eax, eax
        jge short .4
        mov eax, 0FFFFFFFFh
        pop edi
        pop esi
        pop ecx
        ret
.4:
        mov eax, 8
        mov dword [esi], edx
        pop edi
        pop esi
        pop ecx
        ret
.5:
        add eax, byte 8
        inc edx
        cmp eax, 100h
        jge short .6
        cmp dword [dword eax+SoundBankTable], byte 0
        je short .3
        jmp short .5
.6:
        mov eax, 0FFFFFFF7h
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; UnregisterSoundBank                            107154  97 PC, low confidence
; Stops every channel playing from a bank (or from all banks) and frees its
; slot
;-----------------------------------------------------------------------------
UnregisterSoundBank:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        cmp byte [SoundSystemOn], 0
        jne short .1
        mov eax, 0FFFFFFF6h
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        cmp ebx, byte 0FFFFFFFFh
        jne short .3
        xor edx, edx
.2:
        mov eax, edx
        inc edx
        call UnregisterSoundBank
        cmp edx, byte 20h
        jl short .2
        xor eax, eax
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        test ebx, ebx
        jl short .4
        cmp ebx, byte 20h
        jl short .5
.4:
        mov eax, 0FFFFFFF8h
        jmp short .7
.5:
        cmp dword [nosplit ebx*8+SoundBankTable], byte 0
        jne short .6
        mov eax, 0FFFFFFF8h
        test eax, eax
        je short .8
        mov eax, 0FFFFFFF8h
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        xor eax, eax
.7:
        test eax, eax
        je short .8
        mov eax, 0FFFFFFF8h
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        xor edx, edx
.9:
        mov eax, dword [dword edx+ChannelBankTable]
        sar eax, 18h
        cmp eax, ebx
        jne short .10
        mov eax, dword [dword edx+ChannelSampleTable]
        call StopChannel
.10:
        add edx, byte 44h
        cmp edx, 440h
        jne short .9
        xor ecx, ecx
        xor eax, eax
        mov dword [nosplit ebx*8+SoundBankTable], ecx
        pop edx
        pop ecx
        pop ebx
        ret
