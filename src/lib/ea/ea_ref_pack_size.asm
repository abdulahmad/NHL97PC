; EA library: RefPackSize, RefPackUnpack.
bits 32
%include "hockey.inc"
section s_126A03 progbits alloc exec nowrite align=1
global RefPackSize, RefPackUnpack
        db 00h
;-----------------------------------------------------------------------------
; RefPackSize                                    126A04  97 PC, low confidence
; Returns the unpacked size from a RefPack header
;-----------------------------------------------------------------------------
RefPackSize:
        push ebp
        LD mov, ebp, esp
        add esp, byte 0FFFFFFFCh
        push ebx
        push esi
        push edi
        mov ecx, dword [byte ebp+010h]
        mov ebx, dword [byte ebp+08h]
        mov edi, dword [byte ebp+0Ch]
        mov dword [byte ebp-04h], 0
        LD or, ebx, ebx
        je near .8
        mov ax, word [ebx]
        lea ebx, [byte ebx+02h]
        and al, 1
        je short .1
        lea ebx, [byte ebx+03h]
.1:
        LD xor, eax, eax
        mov al, byte [ebx]
        shl eax, 10h
        mov ah, byte [byte ebx+01h]
        mov al, byte [byte ebx+02h]
        lea ebx, [byte ebx+03h]
        mov dword [byte ebp-04h], eax
        cmp ecx, byte 0
        je near .8
        LD xor, ecx, ecx
        jmp short .4
        db 08Bh,0C0h
.2:
        lea esi, [byte ebx+02h]
        rep movsb
        LD mov, ebx, esi
        LD mov, ch, dl
        LD mov, cl, dh
        and edx, byte 1Ch
        shr ch, 5
        shr edx, 2
        neg ecx
        lea esi, [byte ecx+edi-01h]
        lea ecx, [byte edx+03h]
        rep movsb
        or cl, byte [ebx]
        mov edx, dword [ebx]
        js short .5
.3:
        and ecx, byte 3
        jne short .2
        lea ebx, [byte ebx+02h]
        LD mov, ch, dl
        LD mov, cl, dh
        and edx, byte 1Ch
        shr ch, 5
        shr edx, 2
        neg ecx
        lea esi, [byte ecx+edi-01h]
        lea ecx, [byte edx+03h]
        rep movsb
.4:
        or cl, byte [ebx]
        mov edx, dword [ebx]
        jns short .3
.5:
        LD add, cl, cl
        js short .6
        LD mov, cl, dh
        lea esi, [byte ebx+03h]
        shr ecx, 6
        and ecx, byte 3
        rep movsb
        LD mov, ebx, esi
        LD mov, ecx, edx
        shr ecx, 10h
        LD mov, ch, dh
        and ch, 3Fh
        neg ecx
        lea esi, [byte ecx+edi-01h]
        and edx, byte 3Fh
        lea ecx, [byte edx+04h]
        rep movsb
        or cl, byte [ebx]
        mov edx, dword [ebx]
        jns short .3
        jmp short .5
        db 08Bh,0C0h
.6:
        LD add, cl, cl
        jns short .9
        cmp dl, 0FCh
        jae short .7
        and edx, byte 1Fh
        lea esi, [byte ebx+01h]
        lea ecx, [byte edx+01h]
        rep movsd
        LD mov, ebx, esi
        or cl, byte [esi]
        mov edx, dword [esi]
        jns short .3
        jmp short .5
        db 08Bh,0C0h
.7:
        LD mov, ecx, edx
        lea esi, [byte ebx+01h]
        and ecx, byte 3
        rep movsb
.8:
        mov eax, dword [byte ebp-04h]
        pop edi
        pop esi
        pop ebx
        leave
        ret
        db 08Bh,0C0h
.9:
        LD mov, ecx, edx
        lea esi, [byte ebx+04h]
        and ecx, byte 3
        rep movsb
        LD mov, ebx, esi
        LD mov, ecx, edx
        LD mov, eax, edx
        and ecx, byte 10h
        shr eax, 8
        shl ecx, 0Ch
        LD mov, cl, ah
        LD mov, ch, al
        neg ecx
        lea esi, [byte ecx+edi-01h]
        rol edx, 8
        shr dh, 2
        and edx, 3FFh
        cmp ecx, byte 0FFFFFFFCh
        jge short .10
        lea ecx, [byte edx+05h]
        lea edx, [byte edx+05h]
        shr ecx, 2
        and edx, byte 3
        rep movsd
        LD mov, ecx, edx
        rep movsb
        or cl, byte [ebx]
        mov edx, dword [ebx]
        jns near .3
        jmp near .5
        db 02Eh,08Bh,0C0h
.10:
        lea ecx, [byte edx+05h]
        rep movsb
        or cl, byte [ebx]
        mov edx, dword [ebx]
        jns near .3
        jmp near .5
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; RefPackUnpack                                  126B80  97 PC, low confidence
; Decompresses RefPack data
;-----------------------------------------------------------------------------
RefPackUnpack:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 52Ch
        mov eax, dword [dword esp+0540h]
        mov edx, dword [dword esp+0544h]
        mov dword [dword esp+04C4h], edx
        xor edx, edx
        mov dword [dword esp+04CCh], edx
        test eax, eax
        je near .70
        mov dl, byte [eax]
        add eax, byte 2
        xor ebx, ebx
        xor edi, edi
        shl edx, 8
        mov bl, byte [byte eax-01h]
        mov dword [dword esp+0524h], eax
        or ebx, edx
        xor edx, edx
        mov dword [dword esp+0520h], ebx
        mov dl, byte [eax]
        mov eax, ebx
        mov esi, ebx
        shl eax, 8
        shl esi, 10h
        or edx, eax
        shr esi, 10h
        mov dword [dword esp+0520h], edx
        mov edx, dword [dword esp+0524h]
        xor eax, eax
        mov ebx, dword [dword esp+0524h]
        mov al, byte [byte edx+01h]
        mov edx, dword [dword esp+0520h]
        mov dword [dword esp+04D0h], esi
        shl edx, 8
        add ebx, byte 2
        or eax, edx
        mov dword [dword esp+0524h], ebx
        mov dword [dword esp+0520h], eax
        mov esi, eax
        mov ah, byte [dword esp+04D1h]
        shl esi, 10h
        test ah, 1
        je short .1
        mov eax, dword [dword esp+0520h]
        xor edx, edx
        shl eax, 8
        mov dl, byte [ebx]
        or edx, eax
        mov dword [dword esp+0520h], edx
        mov eax, dword [dword esp+0520h]
        xor edx, edx
        shl eax, 8
        mov dl, byte [byte ebx+01h]
        or edx, eax
        lea ecx, [byte ebx+02h]
        mov dword [dword esp+0520h], edx
        xor eax, eax
        shl edx, 8
        mov al, byte [ecx]
        mov dword [dword esp+0524h], ecx
        or eax, edx
        lea edi, [byte ecx+02h]
        mov dword [dword esp+0520h], eax
        xor edx, edx
        shl eax, 8
        mov dl, byte [byte ecx+01h]
        mov dword [dword esp+0524h], edi
        or edx, eax
        mov edi, 8
        mov esi, edx
        mov dword [dword esp+0520h], edx
        shl esi, 8
.1:
        mov dl, byte [dword esp+04D1h]
        mov ebx, esi
        sub edi, byte 8
        and dl, 0FEh
        shr ebx, 18h
        shl esi, 8
        mov byte [dword esp+04D1h], dl
        test edi, edi
        jge short .2
        mov eax, dword [dword esp+0524h]
        xor edx, edx
        mov dl, byte [eax]
        mov eax, dword [dword esp+0520h]
        mov ebp, dword [dword esp+0524h]
        shl eax, 8
        mov ecx, edi
        or edx, eax
        mov eax, dword [dword esp+0524h]
        mov dword [dword esp+0520h], edx
        xor edx, edx
        neg ecx
        mov dl, byte [byte eax+01h]
        mov eax, dword [dword esp+0520h]
        add ebp, byte 2
        shl eax, 8
        add edi, byte 10h
        or edx, eax
        mov dword [dword esp+0524h], ebp
        mov esi, edx
        mov dword [dword esp+0520h], edx
        shl esi, cl
.2:
        mov eax, esi
        sub edi, byte 10h
        shr eax, 10h
        shl esi, 10h
        mov dword [dword esp+04CCh], eax
        test edi, edi
        jge short .3
        mov eax, dword [dword esp+0524h]
        xor edx, edx
        mov dl, byte [eax]
        mov eax, dword [dword esp+0520h]
        shl eax, 8
        or edx, eax
        mov dword [dword esp+0520h], edx
        mov edx, dword [dword esp+0524h]
        xor eax, eax
        mov al, byte [byte edx+01h]
        mov edx, dword [dword esp+0520h]
        shl edx, 8
        mov ecx, edi
        or eax, edx
        neg ecx
        mov dword [dword esp+0520h], eax
        mov esi, eax
        mov eax, dword [dword esp+0524h]
        add edi, byte 10h
        add eax, byte 2
        shl esi, cl
        mov dword [dword esp+0524h], eax
.3:
        mov edx, dword [dword esp+04CCh]
        shl ebx, 10h
        or edx, ebx
        mov ebx, dword [dword esp+0548h]
        mov dword [dword esp+04CCh], edx
        test ebx, ebx
        je near .42
        mov eax, esi
        sub edi, byte 8
        shr eax, 18h
        shl esi, 8
        mov byte [dword esp+0528h], al
        test edi, edi
        jge short .4
        mov eax, dword [dword esp+0524h]
        xor edx, edx
        mov dl, byte [eax]
        mov eax, dword [dword esp+0520h]
        shl eax, 8
        or edx, eax
        mov eax, dword [dword esp+0524h]
        mov dword [dword esp+0520h], edx
        xor edx, edx
        mov dl, byte [byte eax+01h]
        mov eax, dword [dword esp+0520h]
        shl eax, 8
        mov ecx, edi
        or edx, eax
        neg ecx
        mov esi, edx
        shl esi, cl
        mov ecx, dword [dword esp+0524h]
        add edi, byte 10h
        add ecx, byte 2
        mov dword [dword esp+0520h], edx
        mov dword [dword esp+0524h], ecx
.4:
        mov edx, 1
        mov ebx, 0Fh
        xor ebp, ebp
        mov ecx, 4
        mov dword [dword esp+04DCh], ebp
        mov dword [dword esp+04E0h], ebp
        mov dword [dword esp+050Ch], ebx
        mov dword [dword esp+04C0h], ecx
.5:
        mov ebp, dword [dword esp+04E0h]
        add ebp, ebp
        mov ebx, dword [dword esp+04DCh]
        mov eax, ebp
        sub eax, ebx
        mov ebx, dword [dword esp+04C0h]
        mov dword [dword esp+04E0h], ebp
        mov dword [dword esp+ebx+0400h], eax
        test esi, esi
        jge short .6
        mov ebx, esi
        sub edi, byte 3
        shr ebx, 1Dh
        shl esi, 3
        test edi, edi
        jge near .16
        mov eax, dword [dword esp+0524h]
        xor ecx, ecx
        mov cl, byte [eax]
        mov eax, dword [dword esp+0520h]
        shl eax, 8
        or ecx, eax
        mov eax, dword [dword esp+0524h]
        mov dword [dword esp+0520h], ecx
        xor ecx, ecx
        mov cl, byte [byte eax+01h]
        mov eax, dword [dword esp+0520h]
        shl eax, 8
        or ecx, eax
        mov dword [dword esp+0520h], ecx
        mov ecx, edi
        mov esi, dword [dword esp+0520h]
        neg ecx
        shl esi, cl
        mov ecx, dword [dword esp+0524h]
        add ecx, byte 2
        add edi, byte 10h
        mov dword [dword esp+0524h], ecx
        jmp near .16
.6:
        mov eax, esi
        shr eax, 10h
        test eax, eax
        je near .8
        mov eax, 2
.7:
        add esi, esi
        inc eax
        test esi, esi
        jge short .7
        lea ebx, [byte eax-01h]
        sub edi, ebx
        add esi, esi
        test edi, edi
        jge near .11
        mov ebx, dword [dword esp+0524h]
        xor ecx, ecx
        mov cl, byte [ebx]
        mov ebx, dword [dword esp+0520h]
        shl ebx, 8
        or ecx, ebx
        mov ebx, dword [dword esp+0524h]
        mov dword [dword esp+0520h], ecx
        xor ecx, ecx
        mov cl, byte [byte ebx+01h]
        mov ebx, dword [dword esp+0520h]
        shl ebx, 8
        or ecx, ebx
        mov dword [dword esp+0520h], ecx
        mov ecx, edi
        mov esi, dword [dword esp+0520h]
        neg ecx
        shl esi, cl
        mov ecx, dword [dword esp+0524h]
        add ecx, byte 2
        add edi, byte 10h
        mov dword [dword esp+0524h], ecx
        jmp short .11
.8:
        mov eax, 2
.9:
        mov ebp, esi
        inc eax
        dec edi
        shr ebp, 1Fh
        add esi, esi
        test edi, edi
        jge short .10
        mov ecx, dword [dword esp+0524h]
        xor ebx, ebx
        mov bl, byte [ecx]
        mov ecx, dword [dword esp+0520h]
        shl ecx, 8
        or ebx, ecx
        mov dword [dword esp+0520h], ebx
        mov ebx, dword [dword esp+0524h]
        xor ecx, ecx
        mov cl, byte [byte ebx+01h]
        mov ebx, dword [dword esp+0520h]
        shl ebx, 8
        or ecx, ebx
        mov dword [dword esp+0520h], ecx
        mov ebx, dword [dword esp+0524h]
        mov esi, dword [dword esp+0520h]
        mov ecx, edi
        add ebx, byte 2
        neg ecx
        mov dword [dword esp+0524h], ebx
        add edi, byte 10h
        shl esi, cl
.10:
        test ebp, ebp
        je short .9
.11:
        mov ebx, dword [dword esp+0520h]
        mov ebp, dword [dword esp+0524h]
        shl ebx, 8
        add ebp, byte 2
        mov dword [dword esp+0508h], ebx
        cmp eax, byte 10h
        jle near .14
        lea ebx, [byte eax-010h]
        mov ecx, 20h
        mov dword [dword esp+0504h], ebx
        sub ecx, ebx
        mov ebx, esi
        shr ebx, cl
        mov cl, byte [dword esp+0504h]
        shl esi, cl
        sub edi, dword [dword esp+0504h]
        test edi, edi
        jge short .12
        mov esi, dword [dword esp+0524h]
        xor ecx, ecx
        mov cl, byte [esi]
        mov esi, dword [dword esp+0508h]
        or ecx, esi
        mov esi, dword [dword esp+0524h]
        mov dword [dword esp+0520h], ecx
        xor ecx, ecx
        mov cl, byte [byte esi+01h]
        mov dword [dword esp+0504h], ecx
        mov ecx, dword [dword esp+0520h]
        mov esi, dword [dword esp+0504h]
        shl ecx, 8
        mov dword [dword esp+0524h], ebp
        or esi, ecx
        mov ecx, edi
        mov dword [dword esp+0520h], esi
        neg ecx
        add edi, byte 10h
        shl esi, cl
.12:
        mov ecx, esi
        sub edi, byte 10h
        shr ecx, 10h
        shl esi, 10h
        mov dword [dword esp+04E4h], ecx
        test edi, edi
        jge short .13
        mov ecx, dword [dword esp+0520h]
        mov esi, dword [dword esp+0524h]
        shl ecx, 8
        movzx esi, byte [esi]
        or esi, ecx
        mov ebp, dword [dword esp+0524h]
        mov dword [dword esp+0520h], esi
        add ebp, byte 2
        mov ecx, dword [dword esp+0520h]
        mov esi, dword [dword esp+0524h]
        shl ecx, 8
        movzx esi, byte [byte esi+01h]
        mov dword [dword esp+0524h], ebp
        or esi, ecx
        mov ecx, edi
        mov dword [dword esp+0520h], esi
        neg ecx
        add edi, byte 10h
        shl esi, cl
.13:
        mov ecx, dword [dword esp+04E4h]
        shl ebx, 10h
        or ebx, ecx
        jmp short .15
.14:
        mov ecx, 20h
        mov ebx, esi
        sub ecx, eax
        shr ebx, cl
        mov cl, al
        sub edi, eax
        shl esi, cl
        test edi, edi
        jge short .15
        mov esi, dword [dword esp+0524h]
        xor ecx, ecx
        mov cl, byte [esi]
        mov esi, dword [dword esp+0508h]
        or ecx, esi
        mov esi, dword [dword esp+0524h]
        mov dword [dword esp+0520h], ecx
        xor ecx, ecx
        mov cl, byte [byte esi+01h]
        mov dword [dword esp+0504h], ecx
        mov ecx, dword [dword esp+0520h]
        mov esi, dword [dword esp+0504h]
        shl ecx, 8
        mov dword [dword esp+0524h], ebp
        or esi, ecx
        mov ecx, edi
        mov dword [dword esp+0520h], esi
        neg ecx
        add edi, byte 10h
        shl esi, cl
.15:
        mov cl, al
        mov eax, 1
        shl eax, cl
        add ebx, eax
.16:
        sub ebx, byte 4
        mov eax, dword [dword esp+04C0h]
        mov ebp, dword [dword esp+04DCh]
        xor ecx, ecx
        mov dword [dword esp+eax+0440h], ebx
        mov eax, dword [dword esp+04E0h]
        add ebp, ebx
        add eax, ebx
        mov dword [dword esp+04DCh], ebp
        mov dword [dword esp+04E0h], eax
        test ebx, ebx
        je short .17
        mov cl, byte [dword esp+050Ch]
        shl eax, cl
        mov ecx, eax
        and ecx, 0FFFFh
.17:
        mov eax, dword [dword esp+04C0h]
        mov ebp, dword [dword esp+050Ch]
        add eax, byte 4
        inc edx
        dec ebp
        mov dword [dword esp+eax+047Ch], ecx
        mov dword [dword esp+050Ch], ebp
        mov dword [dword esp+04C0h], eax
        test ebx, ebx
        je near .5
        test ecx, ecx
        jne near .5
        mov ebx, 0FFFFFFFFh
        dec edx
        lea eax, [dword esp+0100h]
        mov dword [dword esp+04D8h], edx
        mov dword [dword esp+edx*4+0480h], ebx
        mov edx, 10h
        xor ebx, ebx
.18:
        add eax, byte 10h
        mov dword [byte eax-010h], ebx
        mov dword [byte eax-0Ch], ebx
        mov dword [byte eax-08h], ebx
        mov dword [byte eax-04h], ebx
        dec edx
        jne short .18
        mov al, 0FFh
        mov ebp, dword [dword esp+04DCh]
        mov dword [dword esp+04D4h], edx
        test ebp, ebp
        jle near .33
.19:
        test esi, esi
        jge short .20
        mov ebx, esi
        sub edi, byte 3
        shr ebx, 1Dh
        shl esi, 3
        test edi, edi
        jge near .30
        mov edx, dword [dword esp+0524h]
        xor ecx, ecx
        mov cl, byte [edx]
        mov edx, dword [dword esp+0520h]
        shl edx, 8
        or ecx, edx
        mov edx, dword [dword esp+0524h]
        mov dword [dword esp+0520h], ecx
        xor ecx, ecx
        mov cl, byte [byte edx+01h]
        mov edx, dword [dword esp+0520h]
        shl edx, 8
        or ecx, edx
        mov dword [dword esp+0520h], ecx
        mov ecx, edi
        mov esi, dword [dword esp+0520h]
        neg ecx
        shl esi, cl
        mov ecx, dword [dword esp+0524h]
        add ecx, byte 2
        add edi, byte 10h
        mov dword [dword esp+0524h], ecx
        jmp near .30
.20:
        mov edx, esi
        shr edx, 10h
        test edx, edx
        je short .22
        mov edx, 2
.21:
        add esi, esi
        inc edx
        test esi, esi
        jge short .21
        lea ebx, [byte edx-01h]
        sub edi, ebx
        add esi, esi
        test edi, edi
        jge near .25
        mov ebx, dword [dword esp+0524h]
        xor ecx, ecx
        mov cl, byte [ebx]
        mov ebx, dword [dword esp+0520h]
        shl ebx, 8
        or ecx, ebx
        mov dword [dword esp+0520h], ecx
        mov ecx, dword [dword esp+0524h]
        xor ebx, ebx
        mov bl, byte [byte ecx+01h]
        mov ecx, dword [dword esp+0520h]
        mov ebp, dword [dword esp+0524h]
        shl ecx, 8
        add ebp, byte 2
        or ebx, ecx
        mov dword [dword esp+0524h], ebp
        mov dword [dword esp+0520h], ebx
        mov ecx, edi
        mov esi, ebx
        neg ecx
        add edi, byte 10h
        shl esi, cl
        jmp short .25
.22:
        mov edx, 2
.23:
        mov ebx, esi
        inc edx
        dec edi
        shr ebx, 1Fh
        add esi, esi
        test edi, edi
        jge short .24
        mov ecx, dword [dword esp+0520h]
        mov esi, dword [dword esp+0524h]
        shl ecx, 8
        movzx esi, byte [esi]
        or esi, ecx
        mov dword [dword esp+0520h], esi
        mov ecx, dword [dword esp+0520h]
        mov esi, dword [dword esp+0524h]
        shl ecx, 8
        movzx esi, byte [byte esi+01h]
        or esi, ecx
        mov ecx, edi
        neg ecx
        mov dword [dword esp+0520h], esi
        shl esi, cl
        mov ecx, dword [dword esp+0524h]
        add ecx, byte 2
        add edi, byte 10h
        mov dword [dword esp+0524h], ecx
.24:
        test ebx, ebx
        je short .23
.25:
        mov ebx, dword [dword esp+0524h]
        mov ebp, dword [dword esp+0520h]
        add ebx, byte 2
        shl ebp, 8
        mov dword [dword esp+0518h], ebx
        cmp edx, byte 10h
        jle near .28
        lea ebx, [byte edx-010h]
        mov ecx, 20h
        mov dword [dword esp+0504h], ebx
        sub ecx, ebx
        mov ebx, esi
        shr ebx, cl
        mov cl, byte [dword esp+0504h]
        shl esi, cl
        sub edi, dword [dword esp+0504h]
        test edi, edi
        jge short .26
        mov esi, dword [dword esp+0524h]
        xor ecx, ecx
        mov cl, byte [esi]
        or ecx, ebp
        movzx esi, byte [byte esi+01h]
        mov dword [dword esp+0520h], ecx
        shl ecx, 8
        or esi, ecx
        mov ecx, edi
        neg ecx
        mov dword [dword esp+0520h], esi
        shl esi, cl
        mov ecx, dword [dword esp+0518h]
        add edi, byte 10h
        mov dword [dword esp+0524h], ecx
.26:
        mov ecx, esi
        sub edi, byte 10h
        shr ecx, 10h
        shl esi, 10h
        mov dword [dword esp+04E8h], ecx
        test edi, edi
        jge short .27
        mov ecx, dword [dword esp+0520h]
        mov esi, dword [dword esp+0524h]
        shl ecx, 8
        movzx esi, byte [esi]
        or esi, ecx
        mov ebp, dword [dword esp+0524h]
        mov dword [dword esp+0520h], esi
        add ebp, byte 2
        mov ecx, dword [dword esp+0520h]
        mov esi, dword [dword esp+0524h]
        shl ecx, 8
        movzx esi, byte [byte esi+01h]
        mov dword [dword esp+0524h], ebp
        or esi, ecx
        mov ecx, edi
        mov dword [dword esp+0520h], esi
        neg ecx
        add edi, byte 10h
        shl esi, cl
.27:
        mov ecx, dword [dword esp+04E8h]
        shl ebx, 10h
        or ebx, ecx
        jmp short .29
.28:
        mov ecx, 20h
        mov ebx, esi
        sub ecx, edx
        shr ebx, cl
        mov cl, dl
        sub edi, edx
        shl esi, cl
        test edi, edi
        jge short .29
        mov esi, dword [dword esp+0524h]
        xor ecx, ecx
        mov cl, byte [esi]
        or ecx, ebp
        movzx esi, byte [byte esi+01h]
        mov dword [dword esp+0520h], ecx
        shl ecx, 8
        or esi, ecx
        mov ecx, edi
        neg ecx
        mov dword [dword esp+0520h], esi
        shl esi, cl
        mov ecx, dword [dword esp+0518h]
        add edi, byte 10h
        mov dword [dword esp+0524h], ecx
.29:
        mov cl, dl
        mov edx, 1
        shl edx, cl
        add ebx, edx
.30:
        sub ebx, byte 4
        inc ebx
        xor ecx, ecx
.31:
        inc al
        xor edx, edx
        mov dl, al
        cmp cl, byte [dword esp+edx+0100h]
        jne short .32
        dec ebx
.32:
        test ebx, ebx
        jne short .31
        xor edx, edx
        mov dl, al
        mov byte [dword esp+edx+0100h], 1
        mov edx, dword [dword esp+04D4h]
        inc edx
        mov ebx, dword [dword esp+04DCh]
        mov byte [byte esp+edx-01h], al
        mov dword [dword esp+04D4h], edx
        cmp edx, ebx
        jl near .19
.33:
        mov ebx, 10h
        lea edx, [dword esp+0200h]
        mov ecx, 40404040h
.34:
        add edx, byte 10h
        mov dword [byte edx-010h], ecx
        mov dword [byte edx-0Ch], ecx
        mov dword [byte edx-08h], ecx
        mov dword [byte edx-04h], ecx
        dec ebx
        jne short .34
        mov eax, esp
        lea edx, [dword esp+0300h]
        lea ebx, [dword esp+0200h]
        mov ebp, 1
        mov dword [dword esp+04ECh], eax
        mov eax, dword [dword esp+04D8h]
        mov dword [dword esp+04FCh], ebp
        cmp eax, ebp
        jl near .42
        mov eax, 4
        mov ecx, 7
        mov dword [dword esp+0510h], eax
        mov dword [dword esp+0514h], ecx
.35:
        mov eax, dword [dword esp+0510h]
        mov eax, dword [dword esp+eax+0440h]
        mov ebp, dword [dword esp+04FCh]
        mov dword [dword esp+04F8h], eax
        cmp ebp, byte 9
        jge near .42
        mov cl, byte [dword esp+0514h]
        mov ebp, 1
        shl ebp, cl
.36:
        mov eax, dword [dword esp+04F8h]
        dec eax
        mov dword [dword esp+04F8h], eax
        cmp eax, byte 0FFFFFFFFh
        je near .39
        mov ecx, dword [dword esp+04ECh]
        xor eax, eax
        mov al, byte [ecx]
        inc ecx
        mov dword [dword esp+04F4h], eax
        mov eax, dword [dword esp+04FCh]
        mov dword [dword esp+04ECh], ecx
        mov dword [dword esp+04F0h], eax
        xor eax, eax
        mov ecx, dword [dword esp+04F4h]
        mov al, byte [dword esp+0528h]
        cmp eax, ecx
        jne short .37
        mov eax, dword [dword esp+04FCh]
        mov dword [dword esp+04C8h], eax
        mov dword [dword esp+04F0h], 60h
.37:
        xor eax, eax
        test ebp, ebp
        jle short .36
.38:
        inc edx
        mov cl, byte [dword esp+04F4h]
        inc ebx
        mov byte [byte edx-01h], cl
        mov cl, byte [dword esp+04F0h]
        inc eax
        mov byte [byte ebx-01h], cl
        cmp eax, ebp
        jge near .36
        jmp short .38
.39:
        mov ebp, dword [dword esp+0510h]
        mov eax, dword [dword esp+0514h]
        mov ecx, dword [dword esp+04FCh]
        add ebp, byte 4
        dec eax
        inc ecx
        mov dword [dword esp+0510h], ebp
        mov dword [dword esp+0514h], eax
        mov ebp, dword [dword esp+04D8h]
        mov dword [dword esp+04FCh], ecx
        cmp ecx, ebp
        jle near .35
        jmp short .42
.40:
        mov eax, esi
        shr eax, 18h
        mov edx, dword [dword esp+04C4h]
        mov al, byte [dword esp+eax+0300h]
        mov byte [edx], al
        mov eax, dword [dword esp+0524h]
        xor edx, edx
        mov dl, byte [eax]
        mov eax, dword [dword esp+0520h]
        shl eax, 8
        mov ebx, dword [dword esp+0524h]
        or edx, eax
        mov ecx, 10h
        mov dword [dword esp+0520h], edx
        mov edx, dword [dword esp+0524h]
        xor eax, eax
        add ebx, byte 2
        mov al, byte [byte edx+01h]
        mov edx, dword [dword esp+0520h]
        sub ecx, edi
        shl edx, 8
        mov dword [dword esp+0524h], ebx
        or eax, edx
        mov edx, dword [dword esp+04C4h]
        mov dword [dword esp+0520h], eax
        mov esi, eax
        inc edx
        shl esi, cl
.41:
        mov dword [dword esp+04C4h], edx
.42:
        mov edx, esi
        shr edx, 18h
        mov dl, byte [dword esp+edx+0200h]
        and edx, 0FFh
        sub edi, edx
        test edi, edi
        jl near .44
.43:
        mov eax, esi
        mov ebx, dword [dword esp+04C4h]
        shr eax, 18h
        mov cl, dl
        mov al, byte [dword esp+eax+0300h]
        shl esi, cl
        mov byte [ebx], al
        mov eax, esi
        shr eax, 18h
        xor edx, edx
        mov dl, byte [dword esp+eax+0200h]
        inc ebx
        sub edi, edx
        mov dword [dword esp+04C4h], ebx
        test edi, edi
        jl near .44
        mov cl, dl
        mov al, byte [dword esp+eax+0300h]
        shl esi, cl
        mov byte [ebx], al
        mov eax, esi
        shr eax, 18h
        xor edx, edx
        mov dl, byte [dword esp+eax+0200h]
        lea ecx, [byte ebx+01h]
        sub edi, edx
        mov dword [dword esp+04C4h], ecx
        test edi, edi
        jl short .44
        mov al, byte [dword esp+eax+0300h]
        mov ebp, ecx
        mov byte [ecx], al
        mov cl, dl
        shl esi, cl
        mov eax, esi
        shr eax, 18h
        xor edx, edx
        mov dl, byte [dword esp+eax+0200h]
        inc ebp
        sub edi, edx
        mov dword [dword esp+04C4h], ebp
        test edi, edi
        jl short .44
        mov cl, dl
        shl esi, cl
        mov edx, esi
        mov al, byte [dword esp+eax+0300h]
        shr edx, 18h
        mov byte [byte ebp+00h], al
        mov dl, byte [dword esp+edx+0200h]
        and edx, 0FFh
        lea eax, [byte ebp+01h]
        sub edi, edx
        mov dword [dword esp+04C4h], eax
        test edi, edi
        jge near .43
.44:
        add edi, byte 10h
        test edi, edi
        jge near .40
        sub edi, byte 10h
        add edi, edx
        cmp edx, byte 60h
        je short .46
        mov edx, 8
        mov eax, esi
        mov ecx, 20h
        shr eax, 10h
.45:
        mov ebp, dword [dword esp+ecx+0484h]
        add ecx, byte 4
        inc edx
        cmp eax, ebp
        jb short .47
        jmp short .45
.46:
        mov edx, dword [dword esp+04C8h]
.47:
        mov ecx, 20h
        mov eax, esi
        sub ecx, edx
        mov ebx, dword [dword esp+edx*4+0400h]
        shr eax, cl
        sub edi, edx
        sub eax, ebx
        mov cl, dl
        mov dl, byte [dword esp+0528h]
        mov al, byte [esp+eax]
        shl esi, cl
        cmp al, dl
        je short .48
        test edi, edi
        jl short .48
        mov edx, dword [dword esp+04C4h]
        inc edx
        mov byte [byte edx-01h], al
        jmp near .41
.48:
        test edi, edi
        jge short .49
        mov edx, dword [dword esp+0524h]
        xor ebx, ebx
        mov bl, byte [edx]
        mov edx, dword [dword esp+0520h]
        shl edx, 8
        or ebx, edx
        mov edx, dword [dword esp+0524h]
        mov dword [dword esp+0520h], ebx
        xor ebx, ebx
        mov bl, byte [byte edx+01h]
        mov edx, dword [dword esp+0520h]
        shl edx, 8
        mov ecx, edi
        or ebx, edx
        neg ecx
        mov esi, ebx
        shl esi, cl
        mov ecx, dword [dword esp+0524h]
        add edi, byte 10h
        add ecx, byte 2
        mov dword [dword esp+0520h], ebx
        mov dword [dword esp+0524h], ecx
.49:
        cmp al, byte [dword esp+0528h]
        je short .50
        mov edx, dword [dword esp+04C4h]
        mov byte [edx], al
        lea eax, [byte edx+01h]
        mov dword [dword esp+04C4h], eax
        jmp near .42
.50:
        mov edx, dword [dword esp+04C4h]
        test esi, esi
        jge short .51
        mov ebx, esi
        sub edi, byte 3
        shr ebx, 1Dh
        shl esi, 3
        test edi, edi
        jge near .61
        mov eax, dword [dword esp+0524h]
        xor ecx, ecx
        mov cl, byte [eax]
        mov eax, dword [dword esp+0520h]
        shl eax, 8
        or ecx, eax
        mov eax, dword [dword esp+0524h]
        mov dword [dword esp+0520h], ecx
        xor ecx, ecx
        mov cl, byte [byte eax+01h]
        mov eax, dword [dword esp+0520h]
        mov ebp, dword [dword esp+0524h]
        shl eax, 8
        add ebp, byte 2
        or ecx, eax
        mov dword [dword esp+0524h], ebp
        mov dword [dword esp+0520h], ecx
        mov ecx, edi
        mov esi, dword [dword esp+0520h]
        neg ecx
        add edi, byte 10h
        shl esi, cl
        jmp near .61
.51:
        mov eax, esi
        shr eax, 10h
        test eax, eax
        je near .53
        mov eax, 2
.52:
        add esi, esi
        inc eax
        test esi, esi
        jge short .52
        lea ebx, [byte eax-01h]
        sub edi, ebx
        add esi, esi
        test edi, edi
        jge near .56
        mov ecx, dword [dword esp+0524h]
        xor ebx, ebx
        mov bl, byte [ecx]
        mov ecx, dword [dword esp+0520h]
        shl ecx, 8
        or ebx, ecx
        mov dword [dword esp+0520h], ebx
        mov ebx, dword [dword esp+0524h]
        xor ecx, ecx
        mov cl, byte [byte ebx+01h]
        mov ebx, dword [dword esp+0520h]
        shl ebx, 8
        or ecx, ebx
        mov dword [dword esp+0520h], ecx
        mov ecx, edi
        mov esi, dword [dword esp+0520h]
        neg ecx
        shl esi, cl
        mov ecx, dword [dword esp+0524h]
        add ecx, byte 2
        add edi, byte 10h
        mov dword [dword esp+0524h], ecx
        jmp short .56
.53:
        mov eax, 2
.54:
        mov ebp, esi
        inc eax
        dec edi
        shr ebp, 1Fh
        add esi, esi
        test edi, edi
        jge short .55
        mov ebx, dword [dword esp+0524h]
        xor ecx, ecx
        mov cl, byte [ebx]
        mov ebx, dword [dword esp+0520h]
        shl ebx, 8
        or ecx, ebx
        mov dword [dword esp+0520h], ecx
        mov ecx, dword [dword esp+0524h]
        xor ebx, ebx
        mov bl, byte [byte ecx+01h]
        mov ecx, dword [dword esp+0520h]
        shl ecx, 8
        or ebx, ecx
        mov dword [dword esp+0520h], ebx
        mov ecx, edi
        mov esi, ebx
        mov ebx, dword [dword esp+0524h]
        neg ecx
        add edi, byte 10h
        add ebx, byte 2
        shl esi, cl
        mov dword [dword esp+0524h], ebx
.55:
        test ebp, ebp
        je short .54
.56:
        mov ebx, dword [dword esp+0524h]
        mov ebp, dword [dword esp+0520h]
        add ebx, byte 2
        shl ebp, 8
        mov dword [dword esp+051Ch], ebx
        cmp eax, byte 10h
        jle near .59
        lea ebx, [byte eax-010h]
        mov ecx, 20h
        mov dword [dword esp+0504h], ebx
        sub ecx, ebx
        mov ebx, esi
        shr ebx, cl
        mov cl, byte [dword esp+0504h]
        shl esi, cl
        sub edi, dword [dword esp+0504h]
        test edi, edi
        jge short .57
        mov esi, dword [dword esp+0524h]
        xor ecx, ecx
        mov cl, byte [esi]
        or ecx, ebp
        mov dword [dword esp+0520h], ecx
        xor ecx, ecx
        mov cl, byte [byte esi+01h]
        mov esi, dword [dword esp+0520h]
        shl esi, 8
        or ecx, esi
        mov dword [dword esp+0520h], ecx
        mov ecx, edi
        mov esi, dword [dword esp+0520h]
        neg ecx
        shl esi, cl
        mov ecx, dword [dword esp+051Ch]
        add edi, byte 10h
        mov dword [dword esp+0524h], ecx
.57:
        mov ecx, esi
        sub edi, byte 10h
        shr ecx, 10h
        shl esi, 10h
        mov dword [dword esp+0500h], ecx
        test edi, edi
        jge short .58
        mov ecx, dword [dword esp+0520h]
        mov esi, dword [dword esp+0524h]
        shl ecx, 8
        movzx esi, byte [esi]
        or esi, ecx
        mov ebp, dword [dword esp+0524h]
        mov dword [dword esp+0520h], esi
        add ebp, byte 2
        mov ecx, dword [dword esp+0520h]
        mov esi, dword [dword esp+0524h]
        shl ecx, 8
        movzx esi, byte [byte esi+01h]
        mov dword [dword esp+0524h], ebp
        or esi, ecx
        mov ecx, edi
        mov dword [dword esp+0520h], esi
        neg ecx
        add edi, byte 10h
        shl esi, cl
.58:
        mov ecx, dword [dword esp+0500h]
        shl ebx, 10h
        or ebx, ecx
        jmp short .60
.59:
        mov ecx, 20h
        mov ebx, esi
        sub ecx, eax
        shr ebx, cl
        mov cl, al
        sub edi, eax
        shl esi, cl
        test edi, edi
        jge short .60
        mov esi, dword [dword esp+0524h]
        xor ecx, ecx
        mov cl, byte [esi]
        or ecx, ebp
        movzx esi, byte [byte esi+01h]
        mov dword [dword esp+0520h], ecx
        shl ecx, 8
        or esi, ecx
        mov ecx, edi
        neg ecx
        mov dword [dword esp+0520h], esi
        shl esi, cl
        mov ecx, dword [dword esp+051Ch]
        add edi, byte 10h
        mov dword [dword esp+0524h], ecx
.60:
        mov cl, al
        mov eax, 1
        shl eax, cl
        add ebx, eax
.61:
        sub ebx, byte 4
        je short .63
        lea eax, [edx+ebx]
        mov bl, byte [byte edx-01h]
.62:
        inc edx
        mov byte [byte edx-01h], bl
        cmp edx, eax
        jb short .62
        jmp near .41
.63:
        mov ebx, esi
        dec edi
        shr ebx, 1Fh
        add esi, esi
        test edi, edi
        jge short .64
        mov edx, dword [dword esp+0524h]
        xor eax, eax
        mov al, byte [edx]
        mov edx, dword [dword esp+0520h]
        shl edx, 8
        mov ebp, dword [dword esp+0524h]
        or eax, edx
        mov ecx, edi
        mov dword [dword esp+0520h], eax
        mov eax, dword [dword esp+0524h]
        xor edx, edx
        neg ecx
        mov dl, byte [byte eax+01h]
        mov eax, dword [dword esp+0520h]
        add ebp, byte 2
        shl eax, 8
        add edi, byte 10h
        or edx, eax
        mov dword [dword esp+0524h], ebp
        mov esi, edx
        mov dword [dword esp+0520h], edx
        shl esi, cl
.64:
        test ebx, ebx
        jne near .66
        mov eax, esi
        sub edi, byte 8
        shr eax, 18h
        shl esi, 8
        mov bl, al
        test edi, edi
        jge short .65
        mov eax, dword [dword esp+0524h]
        xor edx, edx
        mov dl, byte [eax]
        mov eax, dword [dword esp+0520h]
        shl eax, 8
        or edx, eax
        mov dword [dword esp+0520h], edx
        mov edx, dword [dword esp+0524h]
        xor eax, eax
        mov al, byte [byte edx+01h]
        mov edx, dword [dword esp+0520h]
        shl edx, 8
        mov ecx, edi
        or eax, edx
        neg ecx
        mov dword [dword esp+0520h], eax
        mov esi, eax
        mov eax, dword [dword esp+0524h]
        add edi, byte 10h
        add eax, byte 2
        shl esi, cl
        mov dword [dword esp+0524h], eax
.65:
        mov eax, dword [dword esp+04C4h]
        lea edx, [byte eax+01h]
        mov byte [eax], bl
        jmp near .41
.66:
        mov edi, dword [dword esp+0544h]
        mov ebx, dword [dword esp+04CCh]
        mov ecx, dword [dword esp+04D0h]
        add edi, ebx
        cmp ecx, 32FBh
        jne short .68
        mov eax, dword [dword esp+0544h]
        mov ecx, edi
        xor ebx, ebx
        cmp edi, eax
        jbe short .70
.67:
        xor edx, edx
        mov dl, byte [eax]
        inc eax
        add ebx, edx
        mov byte [byte eax-01h], bl
        cmp eax, ecx
        jae short .70
        jmp short .67
.68:
        cmp ecx, 34FBh
        jne short .70
        mov eax, dword [dword esp+0544h]
        mov esi, edi
        xor ebx, ebx
        xor edx, edx
        cmp edi, eax
        jbe short .70
.69:
        xor ecx, ecx
        mov cl, byte [eax]
        add ebx, ecx
        inc eax
        add edx, ebx
        mov byte [byte eax-01h], dl
        cmp eax, esi
        jb short .69
.70:
        mov eax, dword [dword esp+04CCh]
        add esp, 52Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
