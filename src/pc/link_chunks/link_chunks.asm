; Link chunk and file transfers.
bits 32
%include "hockey.inc"
section s_ED6C7 progbits alloc exec nowrite align=1
extern AllocNetBuffer, FreeNetBuffer, memcpy_, ServiceIdle, WriteBigEndian
global LinkReceiveChunk, LinkSendChunk, LinkSendFile
        db 090h
;-----------------------------------------------------------------------------
; LinkReceiveChunk                                ED6C8  97 PC, low confidence
; Receives a data chunk over the link
;-----------------------------------------------------------------------------
LinkReceiveChunk:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov ebp, eax
        mov dword [esp], edx
        mov edx, ebx
        mov ebx, eax
        xor edi, edi
        test eax, eax
        je near .18
        lea ebx, [byte ebp+01h]
        xor eax, eax
        xor ecx, ecx
        mov al, byte [byte ebp+00h]
        mov cl, byte [ebx]
        shl eax, 8
        add eax, ecx
        inc ebx
        test ah, 1
        je short .1
        add ebx, byte 3
.1:
        movzx edi, byte [ebx]
        inc ebx
        xor eax, eax
        shl edi, 8
        mov al, byte [ebx]
        inc ebx
        add edi, eax
        xor eax, eax
        shl edi, 8
        mov al, byte [ebx]
        inc ebx
        add edi, eax
.2:
        call ServiceIdle
        mov ch, byte [ebx]
        mov cl, ch
        and cl, 3
        inc ebx
        test ch, 80h
        jne short .6
        mov al, byte [ebx]
        mov byte [byte esp+014h], al
        xor eax, eax
        inc ebx
        mov al, cl
.3:
        dec eax
        cmp eax, byte 0FFFFFFFFh
        je short .4
        inc edx
        mov cl, byte [ebx]
        inc ebx
        mov byte [byte edx-01h], cl
        jmp short .3
.4:
        mov al, ch
        and al, 60h
        and eax, 0FFh
        lea esi, [nosplit eax*8+00h]
        xor eax, eax
        mov al, byte [byte esp+014h]
        add esi, eax
        lea eax, [byte edx-01h]
        sub eax, esi
        mov esi, eax
        mov al, ch
        and al, 1Ch
        and eax, 0FFh
        sar eax, 2
        add eax, byte 2
.5:
        inc edx
        mov cl, byte [esi]
        inc esi
        dec eax
        mov byte [byte edx-01h], cl
        cmp eax, byte 0FFFFFFFFh
        je short .2
        jmp short .5
.6:
        test ch, 40h
        jne short .10
        mov al, byte [ebx]
        mov byte [byte esp+0Ch], al
        mov al, byte [byte ebx+01h]
        mov byte [byte esp+018h], al
        xor eax, eax
        inc ebx
        mov al, byte [byte esp+0Ch]
        inc ebx
        sar eax, 6
.7:
        dec eax
        cmp eax, byte 0FFFFFFFFh
        je short .8
        inc edx
        mov cl, byte [ebx]
        inc ebx
        mov byte [byte edx-01h], cl
        jmp short .7
.8:
        mov al, byte [byte esp+0Ch]
        and al, 3Fh
        and eax, 0FFh
        movzx esi, byte [byte esp+018h]
        shl eax, 8
        add esi, eax
        lea eax, [byte edx-01h]
        sub eax, esi
        mov esi, eax
        mov al, ch
        and al, 3Fh
        and eax, 0FFh
        add eax, byte 3
.9:
        inc edx
        mov cl, byte [esi]
        inc esi
        dec eax
        mov byte [byte edx-01h], cl
        cmp eax, byte 0FFFFFFFFh
        je near .2
        jmp short .9
.10:
        test ch, 20h
        jne near .14
        mov al, byte [ebx]
        mov byte [byte esp+08h], al
        mov al, byte [byte ebx+01h]
        inc ebx
        mov byte [byte esp+04h], al
        mov al, byte [byte ebx+01h]
        inc ebx
        mov byte [byte esp+010h], al
        xor eax, eax
        inc ebx
        mov al, cl
.11:
        dec eax
        cmp eax, byte 0FFFFFFFFh
        je short .12
        inc edx
        mov cl, byte [ebx]
        inc ebx
        mov byte [byte edx-01h], cl
        jmp short .11
.12:
        mov al, ch
        and al, 10h
        mov esi, eax
        and esi, 0FFh
        xor eax, eax
        sar esi, 4
        mov al, byte [byte esp+08h]
        shl esi, 10h
        shl eax, 8
        add esi, eax
        xor eax, eax
        mov al, byte [byte esp+04h]
        add esi, eax
        lea eax, [byte edx-01h]
        sub eax, esi
        mov esi, eax
        mov al, ch
        and al, 0Ch
        and eax, 0FFh
        xor ecx, ecx
        sar eax, 2
        mov cl, byte [byte esp+010h]
        shl eax, 8
        add eax, ecx
        add eax, byte 4
.13:
        inc edx
        mov cl, byte [esi]
        inc esi
        dec eax
        mov byte [byte edx-01h], cl
        cmp eax, byte 0FFFFFFFFh
        je near .2
        jmp short .13
.14:
        mov al, ch
        and al, 1Fh
        and eax, 0FFh
        shl eax, 2
        add eax, byte 4
        cmp eax, byte 70h
        ja short .16
.15:
        dec eax
        cmp eax, byte 0FFFFFFFFh
        je near .2
        inc edx
        mov cl, byte [ebx]
        inc ebx
        mov byte [byte edx-01h], cl
        jmp short .15
.16:
        xor eax, eax
        mov al, cl
.17:
        dec eax
        cmp eax, byte 0FFFFFFFFh
        je short .18
        inc edx
        mov cl, byte [ebx]
        inc ebx
        mov byte [byte edx-01h], cl
        jmp short .17
.18:
        mov edx, dword [esp]
        test edx, edx
        je short .19
        sub ebx, ebp
        mov dword [edx], ebx
.19:
        mov eax, edi
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 00h
        push ecx
        push esi
        push edi
        mov ecx, eax
        mov edi, ebx
        xor eax, eax
        test ebx, ebx
        ja short .21
        pop edi
        pop esi
        pop ecx
        ret
.20:
        inc eax
        cmp eax, edi
        jae short .22
.21:
        mov ebx, ecx
        mov esi, edx
        mov bl, byte [ebx]
        inc ecx
        mov bh, byte [esi]
        inc edx
        cmp bl, bh
        je short .20
.22:
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; LinkSendChunk                                   ED8E8  97 PC, low confidence
; Sends a data chunk over the link
;-----------------------------------------------------------------------------
LinkSendChunk:
        push esi
        push edi
        push ebp
        sub esp, byte 48h
        mov dword [byte esp+024h], eax
        mov dword [byte esp+014h], edx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+034h], eax
        mov dword [byte esp+02Ch], eax
        xor edx, edx
        mov ebp, ebx
        mov dword [byte esp+040h], edx
        cmp ecx, 1FFFFh
        mov eax, 40000h
        call AllocNetBuffer
        mov edx, eax
        mov dword [byte esp+020h], eax
        test eax, eax
        je near .31
        mov eax, 80000h
        call AllocNetBuffer
        mov dword [esp], eax
        test eax, eax
        je near .31
        mov eax, edx
        xor edx, edx
.1:
        add eax, byte 40h
        mov dword [byte eax-04h], 0FFFFFFFFh
        mov ebx, dword [byte eax-04h]
        mov dword [byte eax-08h], ebx
        mov dword [byte eax-0Ch], ebx
        mov dword [byte eax-010h], ebx
        mov dword [byte eax-014h], ebx
        mov dword [byte eax-018h], ebx
        mov dword [byte eax-01Ch], ebx
        mov dword [byte eax-020h], ebx
        mov dword [byte eax-024h], ebx
        mov dword [byte eax-028h], ebx
        mov dword [byte eax-02Ch], ebx
        mov dword [byte eax-030h], ebx
        mov dword [byte eax-034h], ebx
        mov dword [byte eax-038h], ebx
        mov dword [byte eax-03Ch], ebx
        inc edx
        mov dword [byte eax-040h], ebx
        cmp edx, 1000h
        jl short .1
        mov eax, dword [byte esp+024h]
        mov dword [byte esp+010h], eax
.2:
        mov ebx, dword [byte esp+014h]
        test ebx, ebx
        jle near .26
        call ServiceIdle
        xor ecx, ecx
        mov esi, 2
        mov dword [byte esp+028h], ecx
        mov dword [byte esp+030h], esi
        mov dword [byte esp+044h], esi
        cmp ebx, 404h
        jge short .3
        mov eax, ebx
        jmp short .4
.3:
        mov eax, 404h
.4:
        mov edx, dword [byte esp+02Ch]
        mov dword [byte esp+04h], eax
        xor eax, eax
        mov ebx, dword [byte esp+02Ch]
        mov al, byte [edx]
        xor edx, edx
        shl eax, 8
        mov dl, byte [byte ebx+02h]
        or edx, eax
        xor eax, eax
        mov al, byte [byte ebx+01h]
        shl eax, 4
        xor edx, eax
        mov dword [byte esp+08h], edx
        lea eax, [nosplit edx*4+00h]
        add eax, dword [byte esp+020h]
        mov eax, dword [eax]
        mov dword [byte esp+03Ch], eax
        mov eax, ebx
        sub eax, dword [byte esp+024h]
        sub eax, 1FFFFh
        test eax, eax
        jg short .5
        xor eax, eax
.5:
        mov ecx, dword [byte esp+03Ch]
        mov dword [byte esp+01Ch], eax
        cmp eax, ecx
        jg near .14
        mov eax, dword [byte esp+02Ch]
        dec eax
        mov dword [byte esp+018h], eax
.6:
        mov eax, dword [byte esp+024h]
        add eax, dword [byte esp+03Ch]
        mov ebx, dword [byte esp+044h]
        mov dword [byte esp+038h], eax
        mov eax, dword [byte esp+02Ch]
        mov edx, dword [byte esp+038h]
        add eax, ebx
        add edx, ebx
        mov al, byte [eax]
        cmp al, byte [edx]
        jne near .13
        mov edx, dword [byte esp+038h]
        mov edi, dword [byte esp+04h]
        mov ebx, dword [byte esp+02Ch]
        xor eax, eax
        test edi, edi
        ja short .8
        jmp short .9
.7:
        inc eax
        cmp eax, edi
        jae short .9
.8:
        mov ecx, ebx
        mov esi, edx
        mov cl, byte [ecx]
        inc ebx
        mov ch, byte [esi]
        inc edx
        cmp cl, ch
        je short .7
.9:
        mov edi, dword [byte esp+044h]
        mov edx, eax
        cmp eax, edi
        jbe near .13
        mov ebx, dword [byte esp+018h]
        sub ebx, dword [byte esp+038h]
        cmp ebx, 400h
        jae short .10
        cmp eax, byte 0Ah
        ja short .10
        mov eax, 2
        jmp short .12
.10:
        cmp ebx, 4000h
        jae short .11
        cmp edx, byte 43h
        ja short .11
        mov eax, 3
        jmp short .12
.11:
        mov eax, 4
.12:
        mov esi, dword [byte esp+044h]
        mov ecx, edx
        mov edi, dword [byte esp+030h]
        sub ecx, eax
        sub esi, edi
        add ecx, byte 4
        add esi, byte 4
        cmp ecx, esi
        jbe short .13
        mov dword [byte esp+030h], eax
        mov dword [byte esp+028h], ebx
        mov dword [byte esp+044h], edx
        cmp edx, 404h
        jae short .14
.13:
        mov eax, dword [byte esp+03Ch]
        and eax, 1FFFFh
        mov edx, dword [esp]
        shl eax, 2
        add eax, edx
        mov eax, dword [eax]
        mov ebx, dword [byte esp+01Ch]
        mov dword [byte esp+03Ch], eax
        cmp eax, ebx
        jge near .6
.14:
        mov eax, dword [byte esp+030h]
        cmp eax, dword [byte esp+044h]
        jb short .15
        mov edx, dword [byte esp+02Ch]
        mov esi, dword [byte esp+024h]
        mov eax, dword [byte esp+08h]
        sub edx, esi
        mov edi, dword [byte esp+020h]
        mov ebx, edx
        mov ecx, dword [esp]
        and ebx, 1FFFFh
        shl eax, 2
        shl ebx, 2
        add eax, edi
        add ecx, ebx
        mov ebx, dword [eax]
        mov dword [ecx], ebx
        mov ebx, dword [byte esp+014h]
        mov dword [eax], edx
        mov eax, dword [byte esp+040h]
        mov edx, dword [byte esp+02Ch]
        dec ebx
        inc eax
        inc edx
        mov dword [byte esp+014h], ebx
        mov dword [byte esp+040h], eax
        mov dword [byte esp+02Ch], edx
        jmp near .2
.15:
        mov esi, 70h
.16:
        mov ecx, dword [byte esp+040h]
        cmp ecx, byte 3
        jbe short .18
        and cl, 0FCh
        cmp ecx, byte 70h
        jbe short .17
        mov ecx, esi
.17:
        sub dword [byte esp+040h], ecx
        mov eax, ecx
        mov edx, dword [byte esp+034h]
        shr eax, 2
        inc ebp
        add eax, 0DFh
        mov ebx, ecx
        mov byte [byte ebp-01h], al
        mov eax, ebp
        call memcpy_
        mov edx, dword [byte esp+034h]
        add edx, ecx
        add ebp, ecx
        mov dword [byte esp+034h], edx
        jmp short .16
.18:
        mov edx, dword [byte esp+028h]
        lea ebx, [byte ebp+01h]
        mov esi, dword [byte esp+030h]
        lea eax, [byte ebp+02h]
        shr edx, 8
        cmp esi, byte 2
        jne short .19
        mov ecx, edx
        mov edx, dword [byte esp+044h]
        shl edx, 2
        shl ecx, 5
        sub edx, byte 0Ch
        add edx, ecx
        add edx, dword [byte esp+040h]
        mov byte [byte ebp+00h], dl
        mov dl, byte [byte esp+028h]
        mov ebp, eax
        mov byte [ebx], dl
        jmp short .21
.19:
        mov edi, dword [byte esp+030h]
        lea esi, [byte eax+01h]
        cmp edi, byte 3
        jne short .20
        mov cl, byte [byte esp+044h]
        add cl, 7Ch
        mov byte [byte ebp+00h], cl
        mov ecx, dword [byte esp+040h]
        shl ecx, 6
        add edx, ecx
        mov byte [ebx], dl
        mov dl, byte [byte esp+028h]
        mov ebp, esi
        mov byte [eax], dl
        jmp short .21
.20:
        mov edi, dword [byte esp+044h]
        mov ecx, dword [byte esp+028h]
        sub edi, byte 5
        shr ecx, 10h
        shr edi, 8
        shl ecx, 4
        shl edi, 2
        add ecx, 0C0h
        add ecx, edi
        add ecx, dword [byte esp+040h]
        mov byte [byte ebp+00h], cl
        mov byte [ebx], dl
        mov dl, byte [byte esp+028h]
        mov byte [eax], dl
        mov al, byte [byte esp+044h]
        sub al, 5
        lea ebp, [byte esi+01h]
        mov byte [esi], al
.21:
        mov esi, dword [byte esp+040h]
        test esi, esi
        je short .22
        mov edx, dword [byte esp+034h]
        mov ebx, esi
        mov eax, ebp
        call memcpy_
        xor eax, eax
        add ebp, esi
        mov dword [byte esp+040h], eax
.22:
        cmp dword [byte esp+058h], byte 0
        je short .23
        mov eax, dword [byte esp+02Ch]
        mov ecx, dword [byte esp+024h]
        mov edx, dword [byte esp+08h]
        sub eax, ecx
        mov esi, dword [byte esp+020h]
        mov ebx, eax
        shl edx, 2
        and ebx, 1FFFFh
        mov ecx, dword [esp]
        shl ebx, 2
        add edx, esi
        add ecx, ebx
        mov ebx, dword [edx]
        mov dword [ecx], ebx
        mov edi, dword [byte esp+02Ch]
        mov dword [edx], eax
        mov eax, dword [byte esp+044h]
        add edi, eax
        mov dword [byte esp+02Ch], edi
        jmp short .25
.23:
        mov ebx, dword [byte esp+044h]
        xor ecx, ecx
        test ebx, ebx
        jle short .25
        mov eax, dword [byte esp+010h]
        mov edx, dword [byte esp+02Ch]
        neg eax
        mov edi, dword [byte esp+044h]
        add eax, edx
.24:
        mov ebx, dword [byte esp+02Ch]
        xor edx, edx
        mov esi, dword [byte esp+02Ch]
        mov dl, byte [ebx]
        xor ebx, ebx
        shl edx, 8
        mov bl, byte [byte esi+02h]
        or ebx, edx
        xor edx, edx
        mov dl, byte [byte esi+01h]
        shl edx, 4
        xor edx, ebx
        mov ebx, dword [byte esp+020h]
        shl edx, 2
        add edx, ebx
        mov ebx, eax
        and ebx, 1FFFFh
        mov esi, dword [esp]
        shl ebx, 2
        add esi, ebx
        mov ebx, dword [edx]
        inc ecx
        mov dword [esi], ebx
        mov esi, dword [byte esp+02Ch]
        mov dword [edx], eax
        inc esi
        inc eax
        mov dword [byte esp+02Ch], esi
        cmp ecx, edi
        jl short .24
.25:
        mov eax, dword [byte esp+02Ch]
        mov ebx, dword [byte esp+014h]
        mov dword [byte esp+034h], eax
        mov eax, dword [byte esp+044h]
        sub ebx, eax
        mov dword [byte esp+014h], ebx
        jmp near .2
.26:
        mov esi, 70h
.27:
        mov edi, dword [byte esp+040h]
        cmp edi, byte 3
        jbe short .29
        mov ecx, edi
        and cl, 0FCh
        cmp ecx, byte 70h
        jbe short .28
        mov ecx, esi
.28:
        mov edi, dword [byte esp+040h]
        mov eax, ecx
        mov edx, dword [byte esp+034h]
        shr eax, 2
        inc ebp
        add eax, 0DFh
        mov ebx, ecx
        mov byte [byte ebp-01h], al
        mov eax, ebp
        sub edi, ecx
        call memcpy_
        mov eax, dword [byte esp+034h]
        mov dword [byte esp+040h], edi
        add eax, ecx
        add ebp, ecx
        mov dword [byte esp+034h], eax
        jmp short .27
.29:
        mov al, byte [byte esp+040h]
        inc ebp
        add al, 0FCh
        mov byte [byte ebp-01h], al
        test edi, edi
        je short .30
        mov edx, dword [byte esp+034h]
        mov ebx, edi
        mov eax, ebp
        call memcpy_
        add ebp, edi
.30:
        mov eax, dword [esp]
        call FreeNetBuffer
        mov eax, dword [byte esp+020h]
        mov ebx, dword [byte esp+0Ch]
        call FreeNetBuffer
        mov eax, ebp
        sub eax, ebx
.31:
        add esp, byte 48h
        pop ebp
        pop edi
        pop esi
        ret 4
        db 090h
;-----------------------------------------------------------------------------
; LinkSendFile                                    EDDAC  97 PC, low confidence
; Sends a file over the link
;-----------------------------------------------------------------------------
LinkSendFile:
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov edi, edx
        mov esi, ebx
        mov ebx, 2
        mov edx, 10FBh
        mov eax, esi
        call WriteBigEndian
        mov ebx, 3
        lea eax, [byte esi+02h]
        mov edx, edi
        mov ecx, 20000h
        call WriteBigEndian
        push byte 0
        lea ebx, [byte esi+05h]
        mov edx, edi
        mov eax, ebp
        call LinkSendChunk
        add eax, byte 5
        pop ebp
        pop edi
        pop esi
        ret
