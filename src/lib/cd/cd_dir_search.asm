; CD-ROM: CdDirSearch.
bits 32
%include "hockey.inc"
section s_1266FC progbits alloc exec nowrite align=1
extern __CHK, __set_errno_, _IsTable, _nfree_, _nmalloc_, getcwd_, tolower_
global CdDirSearch
;-----------------------------------------------------------------------------
; CdDirSearch                                    1266FC  97 PC, low confidence
; Searches the CD directory for a file name and fills a find record
;-----------------------------------------------------------------------------
CdDirSearch:
        push dword 0B0h
        call __CHK
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 94h
        push eax
        push ebx
        test eax, eax
        jne short .2
        mov ecx, 90h
        mov eax, ecx
        mov dword [esp], ecx
        call _nmalloc_
        mov dword [dword esp+098h], eax
        test eax, eax
        jne short .1
        mov eax, 5
        jmp short .6
.1:
        mov dword [byte esp+04h], eax
.2:
        test edx, edx
        je short .3
        mov ah, byte [edx]
        test ah, ah
        jne short .4
.3:
        mov edx, dword [esp]
        mov eax, dword [byte esp+04h]
        call getcwd_
        jmp near .38
.4:
        mov ebx, dword [byte esp+04h]
        mov esi, dword [esp]
        mov ebp, edx
        cmp esi, byte 3
        jae short .8
.5:
        mov eax, dword [dword esp+098h]
        call _nfree_
        mov eax, 0Eh
.6:
        call __set_errno_
.7:
        xor eax, eax
        jmp near .38
.8:
        lea edi, [byte esi-02h]
        mov al, ah
        mov dword [esp], edi
        inc al
        and eax, 0FFh
        mov al, byte [dword eax+_IsTable]
        and al, 0C0h
        and eax, 0FFh
        je short .9
        xor eax, eax
        mov al, byte [byte edx+01h]
        cmp eax, byte 3Ah
        jne short .9
        xor eax, eax
        mov al, byte [edx]
        call tolower_
        lea ecx, [byte eax-060h]
        mov al, byte [edx]
        mov byte [ebx], al
        mov al, byte [byte edx+01h]
        lea ebp, [byte edx+02h]
        mov byte [byte ebx+01h], al
        jmp short .10
.9:
        xor ecx, ecx
        mov ah, 19h
        int 21h
        mov cl, al
        inc ecx
        mov al, cl
        mov byte [byte ebx+01h], 3Ah
        add al, 40h
        mov byte [ebx], al
.10:
        xor eax, eax
        mov al, byte [byte ebp+00h]
        add ebx, byte 2
        cmp eax, byte 2Fh
        je near .31
        cmp eax, byte 5Ch
        je near .31
        lea esi, [byte esp+08h]
        mov dl, cl
        mov ah, 47h
        int 21h
        rcl eax, 1
        ror eax, 1
        test eax, eax
        jge short .11
        mov eax, dword [dword esp+098h]
        call _nfree_
        mov eax, 1
        jmp near .6
.11:
        lea edi, [byte esp+08h]
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
        xor eax, eax
        mov al, byte [byte esp+08h]
        mov edx, ecx
        cmp eax, byte 5Ch
        je short .12
        mov eax, dword [esp]
        cmp eax, byte 2
        jb near .5
        lea ecx, [byte eax-01h]
        mov byte [ebx], 5Ch
        mov dword [esp], ecx
        inc ebx
.12:
        mov esi, dword [esp]
        lea eax, [byte edx+01h]
        cmp eax, esi
        ja near .5
        mov edi, esi
        sub edi, edx
        lea esi, [byte esp+08h]
        mov dword [esp], edi
        mov edi, ebx
        add ebx, edx
        push edi
.13:
        mov al, byte [esi]
        mov byte [edi], al
        cmp al, 0
        je short .14
        mov al, byte [byte esi+01h]
        add esi, byte 2
        mov byte [byte edi+01h], al
        add edi, byte 2
        cmp al, 0
        jne short .13
.14:
        pop edi
        xor eax, eax
        mov al, byte [byte ebx-01h]
        cmp eax, byte 5Ch
        je short .15
        mov eax, dword [esp]
        cmp eax, byte 2
        jb near .5
        lea edx, [byte eax-01h]
        mov byte [ebx], 5Ch
        mov dword [esp], edx
        inc ebx
.15:
        mov ecx, dword [byte esp+04h]
.16:
        cmp byte [byte ebp+00h], 0
        je near .30
        mov edi, dword [esp]
        lea esi, [byte ebx+01h]
        xor edx, edx
        lea eax, [byte ebp+01h]
        mov dl, byte [byte ebp+00h]
        dec edi
        cmp edx, byte 2Eh
        je short .18
        cmp dword [esp], byte 2
        jb near .5
        mov dword [esp], edi
        mov dl, byte [byte ebp+00h]
        mov ebp, eax
        mov byte [ebx], dl
.17:
        mov ebx, esi
        jmp short .16
.18:
        xor edx, edx
        mov dl, byte [eax]
        mov ebp, eax
        cmp edx, byte 2Fh
        je short .19
        cmp edx, byte 5Ch
        jne short .21
.19:
        xor eax, eax
        mov al, byte [byte ebx-01h]
        cmp eax, byte 2Fh
        je short .20
        cmp eax, byte 5Ch
        je short .20
        mov byte [ebx], 5Ch
        inc ebx
.20:
        inc ebp
        jmp short .16
.21:
        test dl, dl
        je near .30
        cmp edx, byte 2Eh
        jne near .29
        lea ebp, [byte eax+01h]
        xor eax, eax
        mov al, byte [byte ebp+00h]
        cmp eax, byte 2Fh
        je short .22
        cmp eax, byte 5Ch
        jne short .23
.22:
        inc ebp
.23:
        xor eax, eax
        mov al, byte [byte ebx-01h]
        cmp eax, byte 2Fh
        je short .25
        cmp eax, byte 5Ch
        je short .25
.24:
        mov eax, dword [dword esp+098h]
        call _nfree_
        jmp near .7
.25:
        sub ebx, byte 2
.26:
        cmp ebx, ecx
        jb short .24
        xor eax, eax
        mov al, byte [ebx]
        cmp eax, byte 2Fh
        je short .28
        cmp eax, byte 5Ch
        je short .28
        cmp eax, byte 3Ah
        jne short .27
        inc ebx
        mov byte [ebx], 5Ch
        jmp short .28
.27:
        dec ebx
        jmp short .26
.28:
        inc ebx
        mov byte [ebx], 0
        jmp near .16
.29:
        cmp dword [esp], byte 2
        jb near .5
        mov dword [esp], edi
        mov byte [ebx], 2Eh
        jmp near .17
.30:
        mov byte [ebx], 0
        jmp short .34
.31:
        mov edi, ebp
        mov esi, dword [esp]
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
        inc ecx
        cmp ecx, esi
        ja near .5
        mov esi, ebp
        mov edi, ebx
        push edi
.32:
        mov al, byte [esi]
        mov byte [edi], al
        cmp al, 0
        je short .33
        mov al, byte [byte esi+01h]
        add esi, byte 2
        mov byte [byte edi+01h], al
        add edi, byte 2
        cmp al, 0
        jne short .32
.33:
        pop edi
.34:
        mov eax, dword [byte esp+04h]
        jmp short .37
.35:
        xor edx, edx
        mov dl, ch
        cmp edx, byte 2Fh
        jne short .36
        mov byte [eax], 5Ch
.36:
        inc eax
.37:
        mov ch, byte [eax]
        test ch, ch
        jne short .35
        mov eax, dword [byte esp+04h]
.38:
        add esp, 9Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
