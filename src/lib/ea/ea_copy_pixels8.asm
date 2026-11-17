; EA library: CopyPixels8, CopyPixels16, CopyPixels24, CopyPixels32, ConvertArtAt and 6 more.
bits 32
%include "hockey.inc"
section s_11A210 progbits alloc exec nowrite align=1
extern _IsTable, ArtConvertFuncs, bcopy, BlitCore, RefreshTextColors, str_0123456789ABCDEF, str_0123456789abcdef, str_Null
extern TextOriginX
global CopyPixels8, CopyPixels16, CopyPixels24, CopyPixels32, ConvertArtAt, ConvertArtInPlace, ConvertArtXY, ConvertArtKeepPos
global FormatString, SaveTextState, RestoreTextState
;-----------------------------------------------------------------------------
; CopyPixels8                                    11A210  97 PC, low confidence
; Copies a row of 8-bit pixels
;-----------------------------------------------------------------------------
CopyPixels8:
        push ecx
        push ebx
        push eax
        push edx
        call bcopy
        add esp, byte 0Ch
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CopyPixels16                                   11A220  97 PC, low confidence
; Copies a row of 16-bit pixels
;-----------------------------------------------------------------------------
CopyPixels16:
        push ecx
        add ebx, ebx
        push ebx
        push eax
        push edx
        call bcopy
        add esp, byte 0Ch
        pop ecx
        ret
;-----------------------------------------------------------------------------
; CopyPixels24                                   11A230  97 PC, low confidence
; Copies a row of 24-bit pixels
;-----------------------------------------------------------------------------
CopyPixels24:
        push ecx
        push esi
        mov ecx, eax
        mov esi, edx
        mov edx, ebx
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        push eax
        push ecx
        push esi
        call bcopy
        add esp, byte 0Ch
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CopyPixels32                                   11A250  97 PC, low confidence
; Copies a row of 32-bit pixels
;-----------------------------------------------------------------------------
CopyPixels32:
        push ecx
        shl ebx, 2
        push ebx
        push eax
        push edx
        call bcopy
        add esp, byte 0Ch
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ConvertArtAt                                   11A264  97 PC, low confidence
; Converts an art to the screen's pixel format and sets its position
;-----------------------------------------------------------------------------
ConvertArtAt:
        push ebx
        push esi
        push edi
        mov esi, dword [byte esp+010h]
        mov edi, dword [byte esp+018h]
        mov ecx, ArtConvertFuncs
        mov edx, dword [byte esp+014h]
        mov ebx, edi
        mov eax, esi
        call BlitCore
        mov eax, dword [byte esp+014h]
        mov word [byte esi+0Eh], di
        mov word [byte esi+0Ch], ax
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ConvertArtInPlace                              11A294  97 PC, low confidence
; Converts an art to the screen's pixel format at its own position
;-----------------------------------------------------------------------------
ConvertArtInPlace:
        push ebx
        push esi
        push edi
        sub esp, byte 4
        mov esi, dword [byte esp+014h]
        mov ecx, ArtConvertFuncs
        mov eax, esi
        mov edx, dword [byte esi+0Ah]
        mov ebx, dword [byte esi+0Ch]
        sar edx, 10h
        sar ebx, 10h
        mov dword [esp], edx
        mov edi, ebx
        call BlitCore
        mov edx, dword [esp]
        mov word [byte esi+0Eh], di
        mov word [byte esi+0Ch], dx
        add esp, byte 4
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push esi
        push edi
        sub esp, byte 4
        mov esi, dword [byte esp+014h]
        mov edx, dword [byte esi+06h]
        mov ebx, dword [byte esp+018h]
        sar edx, 10h
        sub ebx, edx
        mov edx, ebx
        mov ebx, dword [byte esi+08h]
        mov edi, dword [byte esp+01Ch]
        sar ebx, 10h
        mov ecx, ArtConvertFuncs
        sub edi, ebx
        mov eax, esi
        mov ebx, edi
        mov dword [esp], edx
        call BlitCore
        mov edx, dword [esp]
        mov word [byte esi+0Eh], di
        mov word [byte esi+0Ch], dx
        add esp, byte 4
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ConvertArtXY                                   11A318  97 PC, low confidence
; (art, x, y) converts an art to the screen's pixel format and sets its
; position
;-----------------------------------------------------------------------------
ConvertArtXY:
        push ebx
        push esi
        push edi
        sub esp, byte 4
        mov esi, dword [byte esp+014h]
        mov edx, dword [byte esp+018h]
        mov ebx, dword [byte esp+01Ch]
        mov ecx, ArtConvertFuncs
        mov dword [esp], edx
        mov eax, esi
        mov edi, ebx
        call BlitCore
        mov edx, dword [esp]
        mov word [byte esi+0Eh], di
        mov word [byte esi+0Ch], dx
        add esp, byte 4
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ConvertArtKeepPos                              11A350  97 PC, low confidence
; Converts an art to the screen's pixel format, keeping its position
;-----------------------------------------------------------------------------
ConvertArtKeepPos:
        push ebx
        push esi
        push edi
        sub esp, byte 4
        mov esi, dword [byte esp+014h]
        mov ecx, ArtConvertFuncs
        mov eax, esi
        mov edx, dword [byte esi+0Ah]
        mov ebx, dword [byte esi+0Ch]
        sar edx, 10h
        sar ebx, 10h
        mov dword [esp], edx
        mov edi, ebx
        call BlitCore
        mov edx, dword [esp]
        mov word [byte esi+0Eh], di
        mov word [byte esi+0Ch], dx
        add esp, byte 4
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push esi
        push edi
        sub esp, byte 4
        mov esi, dword [byte esp+014h]
        mov edx, dword [byte esi+06h]
        mov ebx, dword [byte esp+018h]
        sar edx, 10h
        sub ebx, edx
        mov edx, ebx
        mov ebx, dword [byte esi+08h]
        mov edi, dword [byte esp+01Ch]
        sar ebx, 10h
        mov ecx, ArtConvertFuncs
        sub edi, ebx
        mov eax, esi
        mov ebx, edi
        mov dword [esp], edx
        call BlitCore
        mov edx, dword [esp]
        mov word [byte esi+0Eh], di
        mov word [byte esi+0Ch], dx
        add esp, byte 4
        pop edi
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; FormatString                                   11A3E0  97 PC, low confidence
; Formats a string like printf (numbers, strings, padding) for the text
; drawing routines
;-----------------------------------------------------------------------------
FormatString:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 12Ch
        mov ebx, dword [dword esp+0144h]
        mov dword [dword esp+0118h], str_0123456789abcdef
.1:
        xor eax, eax
        mov al, byte [ebx]
        test eax, eax
        je short .3
.2:
        cmp eax, byte 25h
        je short .3
        mov edx, dword [dword esp+0140h]
        inc ebx
        mov byte [edx], al
        xor eax, eax
        lea ecx, [byte edx+01h]
        mov al, byte [ebx]
        mov dword [dword esp+0140h], ecx
        test eax, eax
        jne short .2
.3:
        test eax, eax
        je near .100
        mov eax, 0FFFFFFFFh
        xor esi, esi
        xor ebp, ebp
        xor cl, cl
        mov dword [dword esp+011Ch], esi
        mov dword [dword esp+0120h], eax
        mov edi, 4
.4:
        mov al, byte [byte ebx+01h]
        inc ebx
        cmp al, 58h
        jb near .12
        jbe near .74
        cmp al, 69h
        jb short .7
        jbe near .48
        cmp al, 70h
        jb short .6
        jbe near .61
        cmp al, 75h
        jb short .5
        jbe near .70
        cmp al, 78h
        je near .75
        jmp near .98
.5:
        cmp al, 73h
        je near .62
        jmp near .98
.6:
        cmp al, 6Ch
        jb near .98
        jbe near .32
        cmp al, 6Fh
        je near .53
        jmp near .98
.7:
        cmp al, 64h
        jb short .8
        jbe near .48
        cmp al, 66h
        jb near .98
        jbe near .34
        cmp al, 68h
        je near .31
        jmp near .98
.8:
        cmp al, 62h
        jb near .98
        jbe near .57
        mov eax, dword [dword esp+0148h]
        mov edx, dword [eax]
        add edx, byte 4
        mov dword [eax], edx
        mov eax, dword [byte edx-04h]
        xor ecx, ecx
        mov dword [dword esp+0124h], eax
        lea eax, [dword esp+0102h]
        mov dword [dword esp+011Ch], ecx
        mov dword [dword esp+0114h], eax
        xor edi, edi
.9:
        cmp edi, dword [dword esp+0120h]
        jle short .10
        cmp edi, dword [dword esp+0124h]
        jne short .11
.10:
        cmp edi, dword [dword esp+0120h]
        jg near .33
        mov eax, dword [dword esp+011Ch]
        cmp eax, dword [dword esp+0120h]
        jge near .33
.11:
        dec dword [dword esp+0114h]
        mov edx, dword [dword esp+0114h]
        mov al, byte [dword esp+0124h]
        mov ecx, dword [dword esp+011Ch]
        mov byte [edx], al
        mov edx, dword [dword esp+0124h]
        inc ecx
        shr edx, 8
        mov dword [dword esp+011Ch], ecx
        mov dword [dword esp+0124h], edx
        jmp short .9
.12:
        cmp al, 2Dh
        jb short .15
        jbe near .20
        cmp al, 31h
        jb short .14
        cmp al, 39h
        jbe near .28
        cmp al, 4Fh
        jb short .13
        jbe near .52
        cmp al, 55h
        je near .69
        jmp near .98
.13:
        cmp al, 44h
        je near .47
        jmp near .98
.14:
        cmp al, 2Eh
        jbe near .21
        cmp al, 30h
        je near .27
        jmp near .98
.15:
        cmp al, 23h
        jb short .16
        jbe short .18
        cmp al, 2Ah
        jb near .98
        jbe short .19
        cmp al, 2Bh
        je short .17
        jmp near .98
.16:
        test al, al
        jbe near .100
        cmp al, 20h
        jne near .98
        test cl, cl
        jne near .4
.17:
        mov cl, al
        jmp near .4
.18:
        or si, byte 10h
        jmp near .4
.19:
        mov eax, dword [dword esp+0148h]
        mov ebp, dword [eax]
        add ebp, edi
        mov dword [eax], ebp
        mov ebp, dword [byte ebp-04h]
        test ebp, ebp
        jge near .4
        neg ebp
.20:
        or esi, edi
        jmp near .4
.21:
        mov ah, byte [byte ebx+01h]
        inc ebx
        cmp ah, 2Ah
        jne short .22
        mov eax, dword [dword esp+0148h]
        mov edx, dword [eax]
        add edx, edi
        mov dword [eax], edx
        mov eax, dword [byte edx-04h]
        jmp short .25
.22:
        xor eax, eax
.23:
        mov dl, byte [ebx]
        inc dl
        and edx, 0FFh
        test byte [dword edx+_IsTable], 20h
        je short .24
        imul eax, byte 0Ah
        xor edx, edx
        mov dl, byte [ebx]
        mov dword [dword esp+0128h], eax
        lea eax, [byte edx-030h]
        mov edx, dword [dword esp+0128h]
        inc ebx
        add eax, edx
        jmp short .23
.24:
        dec ebx
.25:
        test eax, eax
        jge short .26
        mov eax, 0FFFFFFFFh
.26:
        mov dword [dword esp+0120h], eax
        jmp near .4
.27:
        or si, byte 8
        jmp near .4
.28:
        xor eax, eax
.29:
        mov dl, byte [ebx]
        inc dl
        and edx, 0FFh
        test byte [dword edx+_IsTable], 20h
        je short .30
        imul edx, eax, byte 0Ah
        movzx ebp, byte [ebx]
        lea eax, [byte ebp-030h]
        inc ebx
        add eax, edx
        jmp short .29
.30:
        mov ebp, eax
        dec ebx
        jmp near .4
.31:
        or si, byte 2
        jmp near .4
.32:
        or si, byte 1
        jmp near .4
.33:
        lea edi, [dword esp+0102h]
        sub edi, dword [dword esp+0114h]
        xor cl, cl
        jmp near .84
.34:
        test si, 1
        jne short .35
        test si, 2
        je short .35
        mov eax, dword [dword esp+0148h]
        mov edx, dword [eax]
        add edx, byte 4
        mov dword [eax], edx
        movsx eax, word [byte edx-04h]
        jmp short .36
.35:
        mov eax, dword [dword esp+0148h]
        mov edi, dword [eax]
        add edi, byte 4
        mov dword [eax], edi
        mov eax, dword [byte edi-04h]
.36:
        mov dword [dword esp+0124h], eax
        test eax, eax
        jge short .37
        neg eax
        mov cl, 2Dh
        mov dword [dword esp+0124h], eax
.37:
        mov eax, dword [dword esp+0124h]
        mov edx, dword [dword esp+0124h]
        xor edi, edi
        mov dword [dword esp+0104h], eax
        mov eax, esp
        shr edx, 10h
        mov dword [dword esp+0114h], eax
        mov eax, 2710h
        mov dword [dword esp+0124h], edx
        mov dword [dword esp+0110h], eax
.38:
        mov eax, dword [dword esp+0124h]
        xor edx, edx
        div dword [dword esp+0110h]
        test eax, eax
        jne short .39
        test edi, edi
        jne short .39
        cmp dword [dword esp+0110h], byte 1
        jne short .40
.39:
        mov dl, al
        inc edi
        add dl, 30h
        mov byte [byte esp+edi-01h], dl
.40:
        imul eax, dword [dword esp+0110h]
        mov edx, dword [dword esp+0124h]
        sub edx, eax
        mov eax, dword [dword esp+0110h]
        mov dword [dword esp+0124h], edx
        mov edx, eax
        mov dword [dword esp+0128h], 0Ah
        sar edx, 1Fh
        idiv dword [dword esp+0128h]
        mov dword [dword esp+0110h], eax
        cmp eax, byte 1
        jge short .38
        mov eax, dword [dword esp+0104h]
        and eax, 0FFFFh
        mov dword [dword esp+0124h], eax
        jne short .41
        cmp dword [dword esp+0120h], byte 0
        jle near .84
.41:
        xor edx, edx
        mov dword [dword esp+011Ch], edx
        mov byte [esp+edi], 2Eh
        imul eax, dword [dword esp+0124h], byte 0Ah
        inc edi
        mov dword [dword esp+0124h], eax
.42:
        cmp dword [dword esp+0120h], byte 0
        jge short .43
        cmp dword [dword esp+0124h], byte 0
        jne short .44
.43:
        cmp dword [dword esp+0120h], byte 0
        jl near .84
        mov eax, dword [dword esp+011Ch]
        cmp eax, dword [dword esp+0120h]
        jge near .84
.44:
        xor edx, edx
        mov eax, dword [dword esp+0124h]
        mov word [dword esp+0126h], dx
        imul edx, dword [dword esp+0124h], byte 0Ah
        mov dword [dword esp+0124h], edx
        mov edx, dword [dword esp+011Ch]
        inc edx
        shr eax, 10h
        mov dword [dword esp+011Ch], edx
        test eax, eax
        jne short .45
        cmp dword [dword esp+0124h], byte 0
        je short .46
.45:
        inc edi
        add al, 30h
        mov byte [byte esp+edi-01h], al
.46:
        cmp dword [dword esp+011Ch], byte 5
        jl near .42
        jmp near .84
.47:
        or si, byte 1
.48:
        test si, 1
        jne short .49
        test si, 2
        je short .49
        mov eax, dword [dword esp+0148h]
        mov edi, dword [eax]
        add edi, byte 4
        mov dword [eax], edi
        movsx eax, word [byte edi-04h]
        jmp short .50
.49:
        mov eax, dword [dword esp+0148h]
        mov edx, dword [eax]
        add edx, byte 4
        mov dword [eax], edx
        mov eax, dword [byte edx-04h]
.50:
        mov dword [dword esp+0124h], eax
        test eax, eax
        jge short .51
        mov ecx, eax
        neg ecx
        mov dword [dword esp+0124h], ecx
        mov cl, 2Dh
.51:
        mov edi, 0Ah
        jmp near .80
.52:
        or si, byte 1
.53:
        test si, 1
        je short .54
        mov eax, dword [dword esp+0148h]
        mov edi, dword [eax]
        add edi, byte 4
        mov dword [eax], edi
        mov eax, dword [byte edi-04h]
        jmp short .56
.54:
        test si, 2
        je short .55
        mov eax, dword [dword esp+0148h]
        mov ecx, dword [eax]
        add ecx, byte 4
        mov dword [eax], ecx
        mov ax, word [byte ecx-04h]
        and eax, 0FFFFh
        mov edi, 8
        mov dword [dword esp+0124h], eax
        jmp near .79
.55:
        mov eax, dword [dword esp+0148h]
        mov edx, dword [eax]
        add edx, byte 4
        mov dword [eax], edx
        mov eax, dword [byte edx-04h]
.56:
        mov edi, 8
        mov dword [dword esp+0124h], eax
        jmp near .79
.57:
        test si, 1
        je short .58
        mov eax, dword [dword esp+0148h]
        mov ecx, dword [eax]
        add ecx, byte 4
        mov dword [eax], ecx
        mov eax, dword [byte ecx-04h]
        jmp short .60
.58:
        test si, 2
        je short .59
        mov eax, dword [dword esp+0148h]
        mov edx, dword [eax]
        add edx, byte 4
        mov dword [eax], edx
        mov ax, word [byte edx-04h]
        and eax, 0FFFFh
        mov edi, 2
        mov dword [dword esp+0124h], eax
        jmp near .79
.59:
        mov eax, dword [dword esp+0148h]
        mov edi, dword [eax]
        add edi, byte 4
        mov dword [eax], edi
        mov eax, dword [byte edi-04h]
.60:
        mov edi, 2
        mov dword [dword esp+0124h], eax
        jmp near .79
.61:
        mov eax, dword [dword esp+0148h]
        mov ecx, dword [eax]
        add ecx, byte 4
        mov dword [eax], ecx
        mov eax, dword [byte ecx-04h]
        mov edi, 10h
        mov dword [dword esp+0124h], eax
        jmp near .79
.62:
        mov eax, dword [dword esp+0148h]
        mov edx, dword [eax]
        add edx, byte 4
        mov dword [eax], edx
        mov eax, dword [byte edx-04h]
        mov dword [dword esp+0114h], eax
        test eax, eax
        jne short .63
        mov dword [dword esp+0114h], str_Null
.63:
        mov eax, dword [dword esp+0120h]
        test eax, eax
        jl short .67
        xor edi, edi
        test eax, eax
        jg short .65
        jmp short .68
.64:
        mov edx, dword [dword esp+0120h]
        inc edi
        inc eax
        cmp edi, edx
        jl short .66
        jmp short .68
.65:
        mov eax, dword [dword esp+0114h]
.66:
        cmp byte [eax], 0
        jne short .64
        jmp short .68
.67:
        mov edi, dword [dword esp+0114h]
        sub ecx, ecx
        dec ecx
        xor eax, eax
        repne scasb
        not ecx
        dec ecx
        mov edi, ecx
.68:
        xor cl, cl
        jmp near .84
.69:
        or si, byte 1
.70:
        test si, 1
        je short .71
        mov eax, dword [dword esp+0148h]
        mov edi, dword [eax]
        add edi, byte 4
        mov dword [eax], edi
        mov eax, dword [byte edi-04h]
        jmp short .73
.71:
        test si, 2
        je short .72
        mov eax, dword [dword esp+0148h]
        mov ecx, dword [eax]
        add ecx, byte 4
        mov dword [eax], ecx
        mov ax, word [byte ecx-04h]
        and eax, 0FFFFh
        mov edi, 0Ah
        mov dword [dword esp+0124h], eax
        jmp near .79
.72:
        mov eax, dword [dword esp+0148h]
        mov edx, dword [eax]
        add edx, byte 4
        mov dword [eax], edx
        mov eax, dword [byte edx-04h]
.73:
        mov edi, 0Ah
        mov dword [dword esp+0124h], eax
        jmp near .79
.74:
        mov dword [dword esp+0118h], str_0123456789ABCDEF
.75:
        test si, 1
        je short .76
        mov eax, dword [dword esp+0148h]
        mov edi, dword [eax]
        add edi, byte 4
        mov dword [eax], edi
        mov eax, dword [byte edi-04h]
        jmp short .78
.76:
        test si, 2
        je short .77
        mov eax, dword [dword esp+0148h]
        mov ecx, dword [eax]
        add ecx, byte 4
        mov dword [eax], ecx
        mov ax, word [byte ecx-04h]
        and eax, 0FFFFh
        jmp short .78
.77:
        mov eax, dword [dword esp+0148h]
        mov edx, dword [eax]
        add edx, byte 4
        mov dword [eax], edx
        mov eax, dword [byte edx-04h]
.78:
        mov edi, 10h
        mov dword [dword esp+0124h], eax
        test si, 10h
        je short .79
        test eax, eax
        je short .79
        or si, byte 20h
.79:
        xor cl, cl
.80:
        mov eax, dword [dword esp+0120h]
        mov dword [dword esp+011Ch], eax
        test eax, eax
        jl short .81
        and si, byte 0FFF7h
.81:
        lea eax, [dword esp+0102h]
        mov edx, dword [dword esp+0124h]
        mov dword [dword esp+0114h], eax
        test edx, edx
        jne short .82
        cmp dword [dword esp+0120h], byte 0
        je short .83
.82:
        mov eax, dword [dword esp+0124h]
        xor edx, edx
        div edi
        add edx, dword [dword esp+0118h]
        dec dword [dword esp+0114h]
        mov al, byte [edx]
        mov edx, dword [dword esp+0114h]
        mov byte [edx], al
        mov eax, dword [dword esp+0124h]
        xor edx, edx
        div edi
        mov dword [dword esp+0124h], eax
        test eax, eax
        jne short .82
        mov dword [dword esp+0118h], str_0123456789abcdef
        test si, 10h
        je short .83
        cmp edi, byte 8
        jne short .83
        mov eax, dword [dword esp+0114h]
        cmp byte [eax], 30h
        je short .83
        lea edx, [byte eax-01h]
        mov dword [dword esp+0114h], edx
        mov byte [edx], 30h
.83:
        lea edi, [dword esp+0102h]
        sub edi, dword [dword esp+0114h]
.84:
        mov dword [dword esp+010Ch], edi
        test cl, cl
        je short .85
        lea eax, [byte edi+01h]
        mov dword [dword esp+010Ch], eax
.85:
        test si, 20h
        je short .86
        add dword [dword esp+010Ch], byte 2
.86:
        mov eax, dword [dword esp+011Ch]
        mov edx, dword [dword esp+010Ch]
        cmp eax, edx
        jle short .87
        mov edx, eax
.87:
        mov dword [dword esp+0108h], edx
        test si, 0Ch
        jne short .89
        test ebp, ebp
        je short .89
        mov eax, edx
        cmp edx, ebp
        jge short .89
.88:
        mov edx, dword [dword esp+0140h]
        mov byte [edx], 20h
        inc edx
        inc eax
        mov dword [dword esp+0140h], edx
        cmp eax, ebp
        jl short .88
.89:
        test cl, cl
        je short .90
        mov eax, dword [dword esp+0140h]
        mov byte [eax], cl
        lea ecx, [byte eax+01h]
        mov dword [dword esp+0140h], ecx
.90:
        test si, 20h
        je short .91
        mov eax, dword [dword esp+0140h]
        mov byte [eax], 30h
        inc eax
        mov dword [dword esp+0140h], eax
        mov edx, dword [dword esp+0140h]
        inc edx
        mov al, byte [ebx]
        mov byte [byte edx-01h], al
        mov dword [dword esp+0140h], edx
.91:
        mov eax, esi
        and eax, byte 0Ch
        cmp eax, byte 8
        jne short .93
        mov eax, dword [dword esp+0108h]
        cmp ebp, eax
        jle short .93
.92:
        mov edx, dword [dword esp+0140h]
        mov byte [edx], 30h
        inc edx
        inc eax
        mov dword [dword esp+0140h], edx
        cmp eax, ebp
        jl short .92
.93:
        mov eax, dword [dword esp+010Ch]
        cmp eax, dword [dword esp+011Ch]
        jge short .95
        mov ecx, dword [dword esp+011Ch]
.94:
        mov edx, dword [dword esp+0140h]
        mov byte [edx], 30h
        inc edx
        inc eax
        mov dword [dword esp+0140h], edx
        cmp eax, ecx
        jl short .94
.95:
        dec edi
        test edi, edi
        jl short .96
        mov eax, dword [dword esp+0114h]
        mov edx, dword [dword esp+0140h]
        mov al, byte [eax]
        mov byte [edx], al
        mov eax, dword [dword esp+0114h]
        inc edx
        inc eax
        mov dword [dword esp+0140h], edx
        mov dword [dword esp+0114h], eax
        jmp short .95
.96:
        test si, 4
        je short .99
        mov eax, dword [dword esp+0108h]
        cmp ebp, eax
        jle short .99
.97:
        mov edx, dword [dword esp+0140h]
        inc eax
        lea ecx, [byte edx+01h]
        mov byte [edx], 20h
        mov dword [dword esp+0140h], ecx
        cmp eax, ebp
        jge short .99
        jmp short .97
.98:
        mov edx, dword [dword esp+0140h]
        mov al, byte [ebx]
        mov byte [edx], al
        lea eax, [byte edx+01h]
        mov dword [dword esp+0140h], eax
.99:
        inc ebx
        jmp near .1
.100:
        mov eax, dword [dword esp+0140h]
        mov byte [eax], 0
        add esp, 12Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
        push ebx
        sub esp, byte 4
        lea eax, [byte esp+014h]
        mov dword [esp], eax
        mov eax, esp
        push eax
        mov edx, dword [byte esp+014h]
        push edx
        mov ebx, dword [byte esp+014h]
        push ebx
        call FormatString
        add esp, byte 0Ch
        xor ecx, ecx
        mov dword [esp], ecx
        add esp, byte 4
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; SaveTextState                                  11ADD0  97 PC, low confidence
; Saves the text drawing state (font, colours, position)
;-----------------------------------------------------------------------------
SaveTextState:
        push esi
        push edi
        mov ecx, 2Bh
        mov edi, dword [byte esp+0Ch]
        mov esi, TextOriginX
        rep movsd
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RestoreTextState                               11ADE8  97 PC, low confidence
; Restores the text drawing state and its colour tables
;-----------------------------------------------------------------------------
RestoreTextState:
        push esi
        push edi
        mov ecx, 2Bh
        mov esi, dword [byte esp+0Ch]
        mov edi, TextOriginX
        rep movsd
        call RefreshTextColors
        pop edi
        pop esi
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
