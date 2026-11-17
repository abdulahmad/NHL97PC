; Watcom C runtime: fputc_, fwrite_, fgets_, byteswap_, med3_ and 2 more.
bits 32
%include "hockey.inc"
section s_11B20A progbits alloc exec nowrite align=1
extern __flush_, __ioalloc_, __qwrite_, __set_errno_, ErrnoPtr, fgetc_, unlink_
global fputc_, fwrite_, fgets_, byteswap_, med3_, med3__4F, qsort_, UnlinkJump
;-----------------------------------------------------------------------------
; fputc_                                                       11B20A  library
; Run-time library fputc: writes a character to a stream
;-----------------------------------------------------------------------------
fputc_:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebx, eax
        test byte [byte edx+0Ch], 2
        jne short .2
        mov eax, 4
        call __set_errno_
        or byte [byte edx+0Ch], 20h
.1:
        mov eax, 0FFFFFFFFh
        jmp near .7
.2:
        cmp dword [byte edx+08h], byte 0
        jne short .3
        mov eax, edx
        call __ioalloc_
.3:
        mov ecx, 400h
        cmp ebx, byte 0Ah
        jne short .4
        mov al, byte [byte edx+0Ch]
        mov ecx, 600h
        test al, 40h
        jne short .4
        or byte [byte edx+0Dh], 10h
        mov eax, dword [edx]
        mov byte [eax], 0Dh
        mov esi, dword [edx]
        inc esi
        mov edi, dword [byte edx+04h]
        mov dword [edx], esi
        inc edi
        mov ebp, dword [byte edx+014h]
        mov dword [byte edx+04h], edi
        cmp edi, ebp
        jne short .4
        mov eax, edx
        call __flush_
        test eax, eax
        jne short .1
.4:
        or byte [byte edx+0Dh], 10h
        mov eax, dword [edx]
        mov byte [eax], bl
        mov eax, dword [edx]
        inc eax
        mov esi, dword [byte edx+04h]
        mov dword [edx], eax
        inc esi
        mov edi, dword [byte edx+0Ch]
        mov dword [byte edx+04h], esi
        test ecx, edi
        jne short .5
        cmp esi, dword [byte edx+014h]
        jne short .6
.5:
        mov eax, edx
        call __flush_
        test eax, eax
        jne short .1
.6:
        xor eax, eax
        mov al, bl
.7:
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; fwrite_                                                      11B2AE  library
; Run-time library fwrite: writes to a stream
;-----------------------------------------------------------------------------
fwrite_:
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        push eax
        push edx
        mov ebp, ecx
        test byte [byte ecx+0Ch], 2
        jne short .1
        mov eax, 4
        call __set_errno_
        or byte [byte ecx+0Ch], 20h
        xor eax, eax
        jmp near .16
.1:
        imul ebx, edx
        test ebx, ebx
        jne short .2
        mov eax, ebx
        jmp near .16
.2:
        cmp dword [byte ecx+08h], byte 0
        jne short .3
        mov eax, ebp
        call __ioalloc_
.3:
        mov eax, dword [byte ebp+0Ch]
        mov dl, byte [byte ebp+0Ch]
        xor esi, esi
        and eax, byte 30h
        and dl, 0CFh
        mov dword [byte esp+0Ch], esi
        mov dword [byte esp+08h], eax
        mov byte [byte ebp+0Ch], dl
        test dl, 40h
        je near .11
        mov dword [byte esp+010h], ebx
.4:
        cmp dword [byte ebp+04h], byte 0
        jne short .7
        mov eax, dword [byte esp+010h]
        cmp eax, dword [byte ebp+014h]
        jb short .7
        mov ebx, eax
        xor bl, al
        and bh, 0FEh
        test ebx, ebx
        jne short .5
        mov ebx, eax
.5:
        mov edx, dword [byte esp+04h]
        mov eax, dword [byte ebp+010h]
        call __qwrite_
        mov edx, eax
        cmp eax, byte 0FFFFFFFFh
        je short .6
        test eax, eax
        jne near .10
        call ErrnoPtr
        mov dword [eax], 0Ch
.6:
        or byte [byte ebp+0Ch], 20h
        jmp short .10
.7:
        mov edx, dword [byte ebp+014h]
        mov ebx, dword [byte ebp+04h]
        mov ecx, dword [byte esp+010h]
        sub edx, ebx
        cmp edx, ecx
        jbe short .8
        mov edx, ecx
.8:
        mov esi, dword [byte esp+04h]
        mov ecx, edx
        mov edi, dword [byte ebp+00h]
        push es
        mov eax, ds
        mov es, eax
        push edi
        mov eax, ecx
        shr ecx, 2
        repne movsd
        LD mov, cl, al
        and cl, 3
        repne movsb
        pop edi
        pop es
        mov edi, dword [byte ebp+04h]
        add edi, edx
        mov bh, byte [byte ebp+0Dh]
        mov dword [byte ebp+04h], edi
        or bh, 10h
        mov esi, dword [byte ebp+00h]
        mov byte [byte ebp+0Dh], bh
        add esi, edx
        mov eax, dword [byte ebp+04h]
        mov ebx, dword [byte ebp+014h]
        mov dword [byte ebp+00h], esi
        cmp eax, ebx
        je short .9
        test byte [byte ebp+0Dh], 4
        je short .10
.9:
        mov eax, ebp
        call __flush_
.10:
        mov ecx, dword [byte esp+04h]
        mov esi, dword [byte esp+0Ch]
        mov edi, dword [byte esp+010h]
        add ecx, edx
        add esi, edx
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+0Ch], esi
        sub edi, edx
        mov dword [byte esp+010h], edi
        je short .14
        test byte [byte ebp+0Ch], 20h
        je near .4
        jmp short .14
.11:
        mov cl, byte [byte ebp+0Dh]
        xor edi, edi
        test cl, 4
        je short .12
        mov ch, cl
        and ch, 0FAh
        mov al, ch
        or al, 1
        mov edi, 1
        mov byte [byte ebp+0Dh], al
.12:
        mov edx, dword [byte esp+04h]
        xor eax, eax
        mov al, byte [edx]
        inc edx
        mov dword [byte esp+04h], edx
        mov edx, ebp
        call fputc_
        test byte [byte ebp+0Ch], 30h
        jne short .13
        mov ecx, dword [byte esp+0Ch]
        inc ecx
        mov dword [byte esp+0Ch], ecx
        cmp ebx, ecx
        jne short .12
.13:
        test edi, edi
        je short .14
        mov dh, byte [byte ebp+0Dh]
        and dh, 0FAh
        mov bl, dh
        or bl, 4
        mov eax, ebp
        mov byte [byte ebp+0Dh], bl
        call __flush_
.14:
        test byte [byte ebp+0Ch], 20h
        je short .15
        xor edx, edx
        mov dword [byte esp+0Ch], edx
.15:
        mov eax, dword [byte esp+08h]
        mov ecx, dword [esp]
        mov ebx, dword [byte ebp+0Ch]
        xor edx, edx
        or ebx, eax
        mov eax, dword [byte esp+0Ch]
        mov dword [byte ebp+0Ch], ebx
        div ecx
.16:
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; fgets_                                                       11B46E  library
; Run-time library fgets: reads a line from a stream
;-----------------------------------------------------------------------------
fgets_:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, eax
        mov ecx, edx
        mov edx, esi
        mov ah, byte [byte ebx+0Ch]
        mov edi, dword [byte ebx+0Ch]
        and ah, 0CFh
        and edi, byte 30h
        mov byte [byte ebx+0Ch], ah
.1:
        dec ecx
        test ecx, ecx
        jle short .2
        mov eax, ebx
        call fgetc_
        mov dword [esp], eax
        cmp eax, byte 0FFFFFFFFh
        je short .2
        mov al, byte [esp]
        mov byte [edx], al
        and eax, 0FFh
        inc edx
        cmp eax, byte 0Ah
        jne short .1
.2:
        cmp dword [esp], byte 0FFFFFFFFh
        jne short .4
        cmp edx, esi
        je short .3
        test byte [byte ebx+0Ch], 20h
        je short .4
.3:
        xor esi, esi
        jmp short .5
.4:
        mov byte [edx], 0
.5:
        mov ebp, dword [byte ebx+0Ch]
        or ebp, edi
        mov eax, esi
        mov dword [byte ebx+0Ch], ebp
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; byteswap_                                                    11B4D7  library
; Run-time library: swaps two memory blocks (qsort helper)
;-----------------------------------------------------------------------------
byteswap_:
        push es
        push ds
        pop es
        movzx edx, cl
        shr ecx, 2
        je short .2
.1:
        mov eax, dword [edi]
        xchg eax, dword [esi]
        stosd
        add esi, byte 4
        dec ecx
        jne short .1
.2:
        and dl, 3
        je short .4
.3:
        mov al, byte [edi]
        xchg al, byte [esi]
        stosb
        inc esi
        dec edx
        jne short .3
.4:
        pop es
        ret
;-----------------------------------------------------------------------------
; med3_                                                        11B4FD  library
; Run-time library: the median of three elements (qsort helper)
;-----------------------------------------------------------------------------
med3_:
        push esi
        push edi
        push es
        push fs
        push gs
        enter 4, 0
        mov edi, eax
        mov esi, edx
        mov dword [byte ebp-04h], ecx
        call dword [byte ebp-04h]
        test eax, eax
        jle short .3
        mov edx, ebx
        mov eax, edi
        call dword [byte ebp-04h]
        test eax, eax
        jle short .2
        mov edx, ebx
        mov eax, esi
        call dword [byte ebp-04h]
        test eax, eax
        jg short .4
.1:
        mov eax, ebx
        jmp short med3__4F
.2:
        mov eax, edi
        jmp short med3__4F
.3:
        mov edx, ebx
        mov eax, edi
        call dword [byte ebp-04h]
        test eax, eax
        jge short .2
        mov edx, ebx
        mov eax, esi
        call dword [byte ebp-04h]
        test eax, eax
        jg short .1
.4:
        mov eax, esi
med3__4F:
        leave
        pop gs
        pop fs
        pop es
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; qsort_                                                       11B555  library
; Run-time library qsort: sorts an array
;-----------------------------------------------------------------------------
qsort_:
        push esi
        push edi
        push es
        push fs
        push gs
        enter 144h, 0
        push eax
        push edx
        push ebx
        or eax, ebx
        mov dword [byte ebp-010h], ecx
        test al, 3
        je short .1
        mov eax, 2
        jmp short .2
.1:
        cmp ebx, byte 4
        seta al
        movzx eax, al
.2:
        mov dword [byte ebp-01Ch], eax
        imul eax, dword [dword ebp-0150h], byte 3
        mov dword [byte ebp-03Ch], eax
        mov eax, dword [dword ebp-0150h]
        add eax, eax
        mov dword [byte ebp-014h], 0
        mov dword [byte ebp-038h], eax
.3:
        cmp dword [dword ebp-014Ch], byte 1
        jbe near .13
        cmp dword [dword ebp-014Ch], byte 10h
        jae near .14
        mov eax, dword [byte ebp-03Ch]
        mov dword [byte ebp-018h], eax
        mov eax, dword [dword ebp-014Ch]
        imul eax, dword [dword ebp-0150h]
        mov edx, dword [dword ebp-0148h]
        add edx, eax
        mov dword [byte ebp-034h], edx
        jmp short .12
.4:
        mov eax, dword [dword ebp-0148h]
        add eax, dword [byte ebp-018h]
        mov dword [byte ebp-024h], eax
        jmp short .11
.5:
        mov ebx, eax
        jmp short .9
.6:
        cmp dword [byte ebp-01Ch], byte 0
        je short .7
        mov ecx, dword [dword ebp-0150h]
        mov esi, ebx
        call byteswap_
        jmp short .8
.7:
        mov edx, dword [edi]
        mov eax, dword [ebx]
        mov dword [ebx], edx
        mov dword [edi], eax
.8:
        sub ebx, dword [byte ebp-018h]
.9:
        cmp ebx, dword [dword ebp-0148h]
        jbe short .10
        mov edi, ebx
        sub edi, dword [byte ebp-018h]
        mov edx, ebx
        mov eax, edi
        call dword [byte ebp-010h]
        test eax, eax
        jg short .6
.10:
        mov eax, dword [byte ebp-018h]
        add dword [byte ebp-024h], eax
.11:
        mov eax, dword [byte ebp-024h]
        cmp eax, dword [byte ebp-034h]
        jb short .5
        mov eax, dword [byte ebp-038h]
        sub dword [byte ebp-018h], eax
.12:
        cmp dword [byte ebp-018h], byte 0
        jg short .4
.13:
        cmp dword [byte ebp-014h], byte 0
        je near med3__4F
        dec dword [byte ebp-014h]
        mov eax, dword [byte ebp-014h]
        mov edx, dword [dword ebp+eax*4-0144h]
        mov eax, dword [dword ebp+eax*4-0C4h]
        mov dword [dword ebp-0148h], edx
        mov dword [dword ebp-014Ch], eax
        jmp near .3
.14:
        mov eax, dword [dword ebp-014Ch]
        shr eax, 1
        imul eax, dword [dword ebp-0150h]
        mov edi, dword [dword ebp-0148h]
        add edi, eax
        cmp dword [dword ebp-014Ch], byte 1Dh
        jbe near .16
        mov esi, dword [dword ebp-014Ch]
        dec esi
        imul esi, dword [dword ebp-0150h]
        mov eax, dword [dword ebp-0148h]
        mov dword [byte ebp-030h], eax
        add esi, eax
        cmp dword [dword ebp-014Ch], byte 2Ah
        jbe short .15
        mov eax, dword [dword ebp-014Ch]
        mov edx, dword [dword ebp-0150h]
        shr eax, 3
        imul edx, eax
        mov ebx, dword [dword ebp-0148h]
        mov dword [byte ebp-020h], edx
        lea eax, [edx+edx]
        mov ecx, dword [byte ebp-010h]
        mov edx, dword [dword ebp-0148h]
        mov dword [byte ebp-040h], eax
        add ebx, eax
        mov eax, dword [dword ebp-0148h]
        add edx, dword [byte ebp-020h]
        call med3_
        mov ebx, dword [byte ebp-020h]
        mov ecx, dword [byte ebp-010h]
        mov dword [byte ebp-030h], eax
        mov edx, edi
        mov eax, edi
        add ebx, edi
        sub eax, dword [byte ebp-020h]
        call med3_
        mov ecx, dword [byte ebp-010h]
        mov edi, eax
        mov edx, esi
        mov ebx, esi
        mov eax, esi
        sub edx, dword [byte ebp-020h]
        sub eax, dword [byte ebp-040h]
        call med3_
        mov esi, eax
.15:
        mov ecx, dword [byte ebp-010h]
        mov eax, dword [byte ebp-030h]
        mov ebx, esi
        mov edx, edi
        call med3_
        mov edi, eax
.16:
        cmp dword [byte ebp-01Ch], byte 0
        je short .18
        mov eax, dword [dword ebp-0148h]
        mov dword [byte ebp-028h], eax
        je short .17
        mov ecx, dword [dword ebp-0150h]
        mov esi, eax
        call byteswap_
        jmp short .19
.17:
        mov ebx, dword [dword ebp-0148h]
        mov edx, dword [eax]
        mov eax, dword [edi]
        mov dword [ebx], eax
        mov dword [edi], edx
        jmp short .19
.18:
        lea eax, [byte ebp-044h]
        mov dword [byte ebp-028h], eax
        mov eax, dword [edi]
        mov dword [byte ebp-044h], eax
.19:
        mov eax, dword [dword ebp-014Ch]
        dec eax
        imul eax, dword [dword ebp-0150h]
        mov ebx, dword [dword ebp-0148h]
        mov dword [byte ebp-0Ch], ebx
        lea edx, [ebx+eax]
        mov dword [byte ebp-08h], edx
        mov dword [byte ebp-04h], edx
.20:
        cmp ebx, dword [byte ebp-04h]
        ja short .24
        mov edx, dword [byte ebp-028h]
        mov eax, ebx
        call dword [byte ebp-010h]
        test eax, eax
        jg short .24
        jne short .23
        cmp dword [byte ebp-01Ch], byte 0
        je short .21
        mov ecx, dword [dword ebp-0150h]
        mov esi, dword [byte ebp-0Ch]
        mov edi, ebx
        call byteswap_
        jmp short .22
.21:
        mov edx, dword [byte ebp-0Ch]
        mov ecx, dword [byte ebp-0Ch]
        mov eax, dword [ebx]
        mov edx, dword [edx]
        mov dword [ecx], eax
        mov dword [ebx], edx
.22:
        mov eax, dword [dword ebp-0150h]
        add dword [byte ebp-0Ch], eax
.23:
        add ebx, dword [dword ebp-0150h]
        jmp short .20
.24:
        cmp ebx, dword [byte ebp-04h]
        ja short .28
        mov edx, dword [byte ebp-028h]
        mov eax, dword [byte ebp-04h]
        call dword [byte ebp-010h]
        test eax, eax
        jl short .28
        jne short .27
        cmp dword [byte ebp-01Ch], byte 0
        je short .25
        mov ecx, dword [dword ebp-0150h]
        mov edi, dword [byte ebp-08h]
        mov esi, dword [byte ebp-04h]
        call byteswap_
        jmp short .26
.25:
        mov eax, dword [byte ebp-08h]
        mov edx, dword [byte ebp-04h]
        mov ecx, dword [byte ebp-04h]
        mov eax, dword [eax]
        mov edx, dword [edx]
        mov dword [ecx], eax
        mov eax, dword [byte ebp-08h]
        mov dword [eax], edx
.26:
        mov eax, dword [dword ebp-0150h]
        sub dword [byte ebp-08h], eax
.27:
        mov eax, dword [dword ebp-0150h]
        sub dword [byte ebp-04h], eax
        jmp short .24
.28:
        cmp ebx, dword [byte ebp-04h]
        ja short .31
        cmp dword [byte ebp-01Ch], byte 0
        je short .29
        mov ecx, dword [dword ebp-0150h]
        mov edi, dword [byte ebp-04h]
        mov esi, ebx
        call byteswap_
        jmp short .30
.29:
        mov edx, dword [byte ebp-04h]
        mov edx, dword [edx]
        mov eax, dword [ebx]
        mov dword [ebx], edx
        mov edx, dword [byte ebp-04h]
        mov dword [edx], eax
.30:
        mov eax, dword [dword ebp-0150h]
        add ebx, dword [dword ebp-0150h]
        sub dword [byte ebp-04h], eax
        jmp near .20
.31:
        mov eax, dword [dword ebp-014Ch]
        imul eax, dword [dword ebp-0150h]
        mov edx, dword [dword ebp-0148h]
        mov ecx, ebx
        add edx, eax
        mov eax, dword [byte ebp-0Ch]
        sub ecx, dword [byte ebp-0Ch]
        sub eax, dword [dword ebp-0148h]
        mov dword [byte ebp-02Ch], edx
        cmp eax, ecx
        jge short .32
        mov ecx, eax
.32:
        test ecx, ecx
        jbe short .37
        mov edi, ebx
        mov esi, dword [dword ebp-0148h]
        sub edi, ecx
        push es
        push ds
        pop es
        movzx edx, cl
        shr ecx, 2
        je short .34
.33:
        mov eax, dword [edi]
        xchg eax, dword [esi]
        stosd
        add esi, byte 4
        dec ecx
        jne short .33
.34:
        and dl, 3
        je short .36
.35:
        mov al, byte [edi]
        xchg al, byte [esi]
        stosb
        inc esi
        dec edx
        jne short .35
.36:
        pop es
.37:
        mov eax, dword [byte ebp-02Ch]
        mov ecx, dword [byte ebp-08h]
        sub eax, dword [byte ebp-08h]
        sub ecx, dword [byte ebp-04h]
        sub eax, dword [dword ebp-0150h]
        cmp ecx, eax
        jb short .38
        mov ecx, eax
.38:
        test ecx, ecx
        jbe short .43
        mov edi, dword [byte ebp-02Ch]
        mov esi, ebx
        sub edi, ecx
        push es
        push ds
        pop es
        movzx edx, cl
        shr ecx, 2
        je short .40
.39:
        mov eax, dword [edi]
        xchg eax, dword [esi]
        stosd
        add esi, byte 4
        dec ecx
        jne short .39
.40:
        and dl, 3
        je short .42
.41:
        mov al, byte [edi]
        xchg al, byte [esi]
        stosb
        inc esi
        dec edx
        jne short .41
.42:
        pop es
.43:
        mov esi, dword [byte ebp-08h]
        mov ecx, dword [byte ebp-02Ch]
        mov edi, ebx
        mov ebx, dword [byte ebp-014h]
        sub edi, dword [byte ebp-0Ch]
        sub esi, dword [byte ebp-04h]
        shl ebx, 2
        sub ecx, esi
        cmp esi, edi
        jb short .44
        mov eax, esi
        xor edx, edx
        div dword [dword ebp-0150h]
        xor edx, edx
        mov dword [dword ebx+ebp-0C4h], eax
        mov eax, edi
        div dword [dword ebp-0150h]
        mov dword [dword ebx+ebp-0144h], ecx
        jmp short .45
.44:
        cmp edi, dword [dword ebp-0150h]
        jbe near .13
        mov eax, dword [dword ebp-0148h]
        xor edx, edx
        mov dword [dword ebx+ebp-0144h], eax
        mov eax, edi
        div dword [dword ebp-0150h]
        xor edx, edx
        mov dword [dword ebx+ebp-0C4h], eax
        mov eax, esi
        div dword [dword ebp-0150h]
        mov dword [dword ebp-0148h], ecx
.45:
        mov dword [dword ebp-014Ch], eax
        inc dword [byte ebp-014h]
        jmp near .3
;-----------------------------------------------------------------------------
; UnlinkJump                                     11B98E  97 PC, low confidence
; Jumps to unlink (file delete)
;-----------------------------------------------------------------------------
UnlinkJump:
        jmp near unlink_
