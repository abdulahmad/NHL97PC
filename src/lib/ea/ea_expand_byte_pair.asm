; EA library: ExpandBytePair, UnpackBytePairs.
bits 32
%include "hockey.inc"
section s_127D70 progbits alloc exec nowrite align=1
extern UnpackCount, UnpackDestPtr, UnpackPairTable, UnpackSrcPtr, UnpackStackPtr
global ExpandBytePair, UnpackBytePairs
;-----------------------------------------------------------------------------
; ExpandBytePair                                 127D70  97 PC, low confidence
; Expands one byte of byte-pair coded data through the pair tables
; (recursive)
;-----------------------------------------------------------------------------
ExpandBytePair:
        push ebx
        push edx
.1:
        xor edx, edx
        mov ebx, dword [UnpackPairTable]
        mov dl, al
        cmp byte [edx+ebx], 0
        je short .2
        mov eax, dword [UnpackDestPtr]
        mov al, byte [edx+eax]
        and eax, 0FFh
        call ExpandBytePair
        mov eax, dword [UnpackStackPtr]
        mov al, byte [edx+eax]
        jmp short .1
.2:
        mov edx, dword [UnpackSrcPtr]
        inc edx
        mov byte [byte edx-01h], al
        mov dword [UnpackSrcPtr], edx
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; UnpackBytePairs                                127DB4  97 PC, low confidence
; Decompresses byte-pair coded data: reads the pair tables and expands each
; byte
;-----------------------------------------------------------------------------
UnpackBytePairs:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 30Ch
        mov edx, dword [dword esp+0320h]
        mov ecx, dword [dword esp+0324h]
        mov eax, esp
        mov ebx, edx
        mov dword [UnpackPairTable], eax
        lea eax, [dword esp+0200h]
        xor esi, esi
        mov dword [UnpackDestPtr], eax
        lea eax, [dword esp+0100h]
        mov dword [dword esp+0308h], esi
        mov dword [UnpackStackPtr], eax
        test edx, edx
        je near .11
        xor eax, eax
        lea ebx, [byte edx+01h]
        mov al, byte [edx]
        xor edx, edx
        shl eax, 8
        mov dl, byte [ebx]
        add eax, edx
        inc ebx
        cmp eax, 47FBh
        jne short .1
        add ebx, byte 3
.1:
        xor eax, eax
        mov al, byte [ebx]
        mov dword [dword esp+0308h], eax
        mov edx, dword [dword esp+0308h]
        xor eax, eax
        shl edx, 8
        mov al, byte [byte ebx+01h]
        add edx, eax
        inc ebx
        mov dword [dword esp+0308h], edx
        xor eax, eax
        shl edx, 8
        mov al, byte [byte ebx+01h]
        inc ebx
        add edx, eax
        inc ebx
        mov dword [dword esp+0308h], edx
        xor eax, eax
.2:
        mov esi, dword [UnpackPairTable]
        mov byte [esi+eax], 0
        inc eax
        cmp eax, 100h
        jl short .2
        inc ebx
        xor eax, eax
        mov al, byte [byte ebx-01h]
        inc ebx
        mov byte [esi+eax], 1
        xor eax, eax
        mov al, byte [byte ebx-01h]
        xor esi, esi
        mov dword [dword esp+0300h], eax
        test eax, eax
        jle short .4
        mov ebp, dword [dword esp+0300h]
.3:
        xor edx, edx
        mov eax, dword [UnpackDestPtr]
        mov dl, byte [ebx]
        lea edi, [byte ebx+01h]
        add eax, edx
        lea ebx, [byte edi+01h]
        mov dword [dword esp+0304h], eax
        mov al, byte [edi]
        mov edi, dword [dword esp+0304h]
        mov byte [edi], al
        mov eax, dword [UnpackStackPtr]
        add eax, edx
        mov edi, ebx
        mov dword [dword esp+0304h], eax
        mov al, byte [edi]
        mov edi, dword [dword esp+0304h]
        mov byte [edi], al
        mov eax, dword [UnpackPairTable]
        inc esi
        inc ebx
        mov byte [edx+eax], 0FFh
        cmp esi, ebp
        jl short .3
.4:
        xor edx, edx
        mov eax, dword [UnpackPairTable]
        mov dl, byte [ebx]
        mov al, byte [edx+eax]
        inc ebx
        test al, al
        jne short .5
        inc ecx
        mov byte [byte ecx-01h], dl
        jmp short .4
.5:
        jge near .10
        mov eax, dword [UnpackDestPtr]
        mov dword [UnpackCount], ebx
        mov dword [UnpackSrcPtr], ecx
        mov al, byte [edx+eax]
.6:
        mov edi, dword [UnpackPairTable]
        movzx esi, al
        cmp byte [edi+esi], 0
        je short .7
        mov eax, dword [UnpackDestPtr]
        mov al, byte [esi+eax]
        and eax, 0FFh
        call ExpandBytePair
        mov eax, dword [UnpackStackPtr]
        mov al, byte [esi+eax]
        jmp short .6
.7:
        mov ecx, dword [UnpackSrcPtr]
        mov byte [ecx], al
        inc ecx
        mov eax, dword [UnpackStackPtr]
        mov dword [UnpackSrcPtr], ecx
.8:
        mov al, byte [edx+eax]
        xor edx, edx
        mov esi, dword [UnpackPairTable]
        mov dl, al
        cmp byte [edx+esi], 0
        je short .9
        mov eax, dword [UnpackDestPtr]
        mov al, byte [edx+eax]
        and eax, 0FFh
        call ExpandBytePair
        mov eax, dword [UnpackStackPtr]
        jmp short .8
.9:
        mov ecx, dword [UnpackSrcPtr]
        inc ecx
        mov ebx, dword [UnpackCount]
        mov byte [byte ecx-01h], al
        jmp near .4
.10:
        xor edx, edx
        mov dl, byte [ebx]
        inc ebx
        test edx, edx
        je short .11
        inc ecx
        mov byte [byte ecx-01h], dl
        jmp near .4
.11:
        mov eax, dword [dword esp+0308h]
        mov dword [UnpackSrcPtr], ecx
        mov dword [UnpackCount], ebx
        add esp, 30Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
