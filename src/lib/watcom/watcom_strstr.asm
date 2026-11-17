; Watcom C runtime: strstr_.
bits 32
%include "hockey.inc"
section s_10911D progbits alloc exec nowrite align=1
global strstr_
;-----------------------------------------------------------------------------
; strstr_                                     10911D  96 PC, medium confidence
; Run-time library strstr: finds a substring
;-----------------------------------------------------------------------------
strstr_:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, eax
        mov ebx, edx
        cmp byte [edx], 0
        jne short .2
.1:
        mov eax, esi
        jmp near .13
.2:
        cmp byte [byte edx+01h], 0
        jne short .6
        mov dl, byte [ebx]
.3:
        mov al, byte [esi]
        LD cmp, al, dl
        je short .5
        cmp al, 0
        je short .4
        inc esi
        mov al, byte [esi]
        LD cmp, al, dl
        je short .5
        inc esi
        cmp al, 0
        jne short .3
.4:
        LD sub, esi, esi
.5:
        jmp short .1
.6:
        mov ecx, 0FFFFFFFFh
        mov edi, esi
        xor al, al
        push es
        jecxz .7
        mov edx, ds
        mov es, edx
        repne scasb
        jne short .7
        dec edi
        db 066h
        db 0A9h
.7:
        mov edi, ecx
        pop es
        mov dword [esp], edi
        mov edi, ebx
        push es
        mov eax, ds
        mov es, eax
        sub ecx, ecx
        dec ecx
        xor eax, eax
        repne scasb
        not ecx
        dec ecx
        pop es
        mov ebp, ecx
.8:
        mov ecx, dword [esp]
        sub ecx, esi
        cmp ecx, ebp
        jb short .12
        mov edi, esi
        mov al, byte [ebx]
        push es
        jecxz .9
        mov edx, ds
        mov es, edx
        repne scasb
        jne short .9
        dec edi
        db 066h
        db 0A9h
.9:
        mov edi, ecx
        pop es
        mov edx, edi
        test edi, edi
        je short .12
        mov ecx, ebp
        mov edi, ebx
        mov esi, edx
        push es
        mov eax, ds
        mov es, eax
        xor eax, eax
        repe cmpsb
        je short .10
        sbb eax, eax
        sbb eax, byte 0FFFFFFFFh
.10:
        pop es
        test eax, eax
        jne short .11
        mov eax, edx
        jmp short .13
.11:
        lea esi, [byte edx+01h]
        jmp short .8
.12:
        xor eax, eax
.13:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
