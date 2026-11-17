; 3D library: CopyMappedSpan, CopyScaledSpan.
bits 32
%include "hockey.inc"
section s_12285A progbits alloc exec nowrite align=1
extern BlitColumnOffsets, BlitDestOffsets, BlitSourcePtr, DrawDestPitch, IdentityRemap, RemapTable, ScreenBitsPerPixel
global CopyMappedSpan, CopyScaledSpan
;-----------------------------------------------------------------------------
; CopyMappedSpan                                 12285A  97 PC, low confidence
; Copies a span of pixels from the source through the column offset table, by
; pixel depth
;-----------------------------------------------------------------------------
CopyMappedSpan:
        push ebx
        push esi
        push edi
        mov esi, dword [byte esp+014h]
        mov edi, dword [byte esp+010h]
        mov ecx, dword [byte esp+018h]
        add esi, dword [BlitSourcePtr]
        add edi, dword [DrawDestPitch]
        mov edx, dword [BlitColumnOffsets]
        LD xor, eax, eax
        cmp byte [ScreenBitsPerPixel], 8
        jg short .10
        sub ecx, byte 4
        js short .6
.1:
        mov ebx, dword [edx]
        mov al, byte [ebx+esi]
        mov ebx, dword [byte edx+04h]
        cmp al, 0FFh
        je short .2
        mov byte [edi], al
.2:
        mov al, byte [ebx+esi]
        mov ebx, dword [byte edx+08h]
        cmp al, 0FFh
        je short .3
        mov byte [byte edi+01h], al
.3:
        mov al, byte [ebx+esi]
        mov ebx, dword [byte edx+0Ch]
        cmp al, 0FFh
        je short .4
        mov byte [byte edi+02h], al
.4:
        mov al, byte [ebx+esi]
        cmp al, 0FFh
        je short .5
        mov byte [byte edi+03h], al
.5:
        sub ecx, byte 4
        lea edx, [byte edx+010h]
        lea edi, [byte edi+04h]
        jns short .1
.6:
        add ecx, byte 3
        js short .9
.7:
        mov ebx, dword [edx]
        mov al, byte [ebx+esi]
        cmp al, 0FFh
        je short .8
        mov byte [edi], al
.8:
        sub ecx, byte 1
        lea edx, [byte edx+04h]
        lea edi, [byte edi+01h]
        jns short .7
.9:
        pop edi
        pop esi
        pop ebx
        ret
.10:
        mov ebx, dword [edx]
        cmp byte [ScreenBitsPerPixel], 10h
        jg short .13
        sub ecx, byte 1
        js short .9
.11:
        mov ax, word [esi+ebx*2]
        LD or, ax, ax
        je short .12
        mov word [edi], ax
.12:
        mov ebx, dword [byte edx+04h]
        sub ecx, byte 1
        lea edx, [byte edx+04h]
        lea edi, [byte edi+02h]
        jns short .11
        jmp short .9
.13:
        sub ecx, byte 1
        js short .9
.14:
        mov eax, dword [esi+ebx*4]
        LD or, eax, eax
        je short .15
        mov dword [edi], eax
.15:
        mov ebx, dword [byte edx+04h]
        sub ecx, byte 1
        lea edx, [byte edx+04h]
        lea edi, [byte edi+04h]
        jns short .14
        jmp short .9
        push ebx
        push esi
        push edi
        mov esi, dword [byte esp+014h]
        mov edi, dword [byte esp+010h]
        mov ecx, dword [byte esp+018h]
        add esi, dword [BlitSourcePtr]
        add edi, dword [DrawDestPitch]
        mov edx, dword [BlitColumnOffsets]
        LD xor, eax, eax
        sub ecx, byte 4
        js short .21
.16:
        mov ebx, dword [edx]
        mov al, byte [ebx+esi]
        mov ebx, dword [byte edx+04h]
        mov al, byte [dword eax+IdentityRemap]
        cmp al, 0FFh
        je short .17
        mov byte [edi], al
.17:
        mov al, byte [ebx+esi]
        mov ebx, dword [byte edx+08h]
        mov al, byte [dword eax+IdentityRemap]
        cmp al, 0FFh
        je short .18
        mov byte [byte edi+01h], al
.18:
        mov al, byte [ebx+esi]
        mov ebx, dword [byte edx+0Ch]
        mov al, byte [dword eax+IdentityRemap]
        cmp al, 0FFh
        je short .19
        mov byte [byte edi+02h], al
.19:
        mov al, byte [ebx+esi]
        mov al, byte [dword eax+IdentityRemap]
        cmp al, 0FFh
        je short .20
        mov byte [byte edi+03h], al
.20:
        sub ecx, byte 4
        lea edx, [byte edx+010h]
        lea edi, [byte edi+04h]
        jns short .16
.21:
        add ecx, byte 3
        js short .24
.22:
        mov ebx, dword [edx]
        mov al, byte [ebx+esi]
        mov al, byte [dword eax+IdentityRemap]
        cmp al, 0FFh
        je short .23
        mov byte [edi], al
.23:
        sub ecx, byte 1
        lea edx, [byte edx+04h]
        lea edi, [byte edi+01h]
        jns short .22
.24:
        pop edi
        pop esi
        pop ebx
        ret
        push ebp
        LD mov, ebp, esp
        push ebx
        push esi
        push edi
        mov esi, dword [byte ebp+0Ch]
        mov edi, dword [byte ebp+08h]
        mov ecx, dword [byte ebp+010h]
        add esi, dword [BlitSourcePtr]
        add edi, dword [DrawDestPitch]
        mov edx, dword [BlitColumnOffsets]
        LD xor, eax, eax
.25:
        mov ebx, dword [edx]
        mov al, byte [ebx+esi]
        mov al, byte [dword eax+IdentityRemap]
        add edx, byte 4
        mov byte [edi], al
        sub ecx, byte 1
        lea edi, [byte edi+01h]
        jne short .25
        pop edi
        pop esi
        pop ebx
        leave
        ret
        push ebp
        LD mov, ebp, esp
        push ebx
        push esi
        push edi
        mov esi, dword [byte ebp+0Ch]
        mov edi, dword [byte ebp+08h]
        mov ecx, dword [byte ebp+010h]
        add esi, dword [BlitSourcePtr]
        add edi, dword [DrawDestPitch]
        mov edx, dword [BlitColumnOffsets]
        LD xor, eax, eax
.26:
        mov ebx, dword [edx]
        mov al, byte [ebx+esi]
        add edx, byte 4
        cmp al, 0FEh
        jb short .27
        jne short .28
        mov al, byte [edi]
        mov al, byte [dword eax+RemapTable]
.27:
        mov byte [edi], al
.28:
        sub ecx, byte 1
        lea edi, [byte edi+01h]
        jne short .26
        pop edi
        pop esi
        pop ebx
        leave
        ret
        push ebp
        LD mov, ebp, esp
        push ebx
        push esi
        push edi
        mov esi, dword [byte ebp+0Ch]
        mov edi, dword [byte ebp+08h]
        mov ecx, dword [byte ebp+010h]
        add esi, dword [BlitSourcePtr]
        add edi, dword [DrawDestPitch]
        mov edx, dword [BlitColumnOffsets]
        LD xor, eax, eax
.29:
        mov ebx, dword [edx]
        mov al, byte [ebx+esi]
        mov al, byte [dword eax+IdentityRemap]
        add edx, byte 4
        cmp al, 0FEh
        jb short .30
        jne short .31
        mov al, byte [edi]
        mov al, byte [dword eax+RemapTable]
.30:
        mov byte [edi], al
.31:
        sub ecx, byte 1
        lea edi, [byte edi+01h]
        jne short .29
        pop edi
        pop esi
        pop ebx
        leave
        ret
        push ebx
        push esi
        push edi
        push ebp
        mov esi, dword [byte esp+018h]
        mov ebp, dword [byte esp+014h]
        mov ecx, dword [byte esp+01Ch]
        add esi, dword [BlitSourcePtr]
        add ebp, dword [DrawDestPitch]
        mov edx, dword [BlitColumnOffsets]
        mov edi, dword [BlitDestOffsets]
        LD xor, eax, eax
        sub ecx, byte 2
        js short .33
.32:
        mov ebx, dword [edx]
        mov al, byte [ebx+esi]
        mov ebx, dword [edi+eax*4]
        mov al, byte [byte ebp+00h]
        mov al, byte [eax+ebx]
        mov byte [byte ebp+00h], al
        mov ebx, dword [byte edx+04h]
        mov al, byte [ebx+esi]
        mov ebx, dword [edi+eax*4]
        mov al, byte [byte ebp+01h]
        mov al, byte [ebx+eax]
        mov byte [byte ebp+01h], al
        sub ecx, byte 2
        lea edx, [byte edx+08h]
        lea ebp, [byte ebp+02h]
        jns short .32
.33:
        add ecx, byte 1
        js short .34
        mov ebx, dword [edx]
        mov al, byte [ebx+esi]
        mov ebx, dword [edi+eax*4]
        mov al, byte [byte ebp+00h]
        mov al, byte [ebx+eax]
        mov byte [byte ebp+00h], al
.34:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        push ebx
        push esi
        push edi
        push ebp
        mov esi, dword [byte esp+018h]
        mov edi, dword [byte esp+014h]
        mov ebp, dword [byte esp+01Ch]
        add esi, dword [BlitSourcePtr]
        add edi, dword [DrawDestPitch]
        sub ebp, byte 10h
        js short .36
.35:
        mov eax, dword [esi]
        mov edx, dword [byte esi+04h]
        LD mov, bl, ah
        LD mov, bh, ah
        bswap ebx
        LD mov, bl, al
        LD mov, bh, al
        bswap eax
        LD mov, cl, al
        LD mov, ch, al
        bswap ecx
        LD mov, cl, ah
        LD mov, ch, ah
        mov dword [edi], ebx
        mov dword [byte edi+04h], ecx
        LD mov, bl, dh
        LD mov, bh, dh
        bswap ebx
        LD mov, bl, dl
        LD mov, bh, dl
        bswap edx
        LD mov, cl, dl
        LD mov, ch, dl
        bswap ecx
        LD mov, cl, dh
        LD mov, ch, dh
        mov dword [byte edi+08h], ebx
        mov dword [byte edi+0Ch], ecx
        sub ebp, byte 10h
        lea esi, [byte esi+08h]
        lea edi, [byte edi+010h]
        jns short .35
.36:
        add ebp, byte 0Ch
        js short .38
.37:
        mov al, byte [esi]
        mov ah, byte [byte esi+01h]
        LD mov, bl, ah
        LD mov, bh, ah
        bswap ebx
        LD mov, bl, al
        LD mov, bh, al
        mov dword [edi], ebx
        sub ebp, byte 4
        lea esi, [byte esi+02h]
        lea edi, [byte edi+04h]
        jns short .37
.38:
        add ebp, byte 3
        js short .40
.39:
        mov al, byte [esi]
        mov byte [edi], al
        sub ebp, byte 1
        lea edi, [byte edi+01h]
        jns short .39
.40:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        push ebx
        LD mov, ebx, esi
        LD mov, edx, edi
        mov edi, dword [byte esp+08h]
        mov esi, dword [byte esp+0Ch]
        mov eax, dword [byte esp+010h]
        add edi, dword [DrawDestPitch]
        add esi, dword [BlitSourcePtr]
        cmp eax, byte 0Ch
        jl short .41
        LD mov, ecx, edi
        neg ecx
        and ecx, byte 3
        LD sub, eax, ecx
        rep movsb
        LD mov, ecx, eax
        shr ecx, 2
        rep movsd
        and eax, byte 3
        jne short .41
        LD mov, edi, edx
        LD mov, esi, ebx
        pop ebx
        ret
.41:
        LD mov, ecx, eax
        rep movsb
        LD mov, edi, edx
        LD mov, esi, ebx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CopyScaledSpan                                 122C09  97 PC, low confidence
; Copies a span of pixels picked through the column offset table, eight at a
; time
;-----------------------------------------------------------------------------
CopyScaledSpan:
        push ebx
        push esi
        push edi
        push ebp
        mov esi, dword [byte esp+018h]
        mov edi, dword [byte esp+014h]
        mov ecx, dword [byte esp+01Ch]
        mov edx, dword [BlitColumnOffsets]
        add esi, dword [BlitSourcePtr]
        add edi, dword [DrawDestPitch]
        mov ebx, dword [byte edx+0Ch]
        cmp byte [ScreenBitsPerPixel], 8
        jg near .9
        sub ecx, byte 10h
        jl near .2
        test edi, 3
        jne near .7
.1:
        mov ebp, dword [byte edx+08h]
        mov ah, byte [esi+ebx]
        mov ebx, dword [byte edx+04h]
        mov al, byte [esi+ebp]
        shl eax, 10h
        mov ebp, dword [edx]
        mov ah, byte [esi+ebx]
        mov ebx, dword [byte edx+01Ch]
        mov al, byte [esi+ebp]
        mov ebp, dword [byte edx+018h]
        mov dword [edi], eax
        mov ah, byte [esi+ebx]
        mov ebx, dword [byte edx+014h]
        mov al, byte [esi+ebp]
        shl eax, 10h
        mov ebp, dword [byte edx+010h]
        mov ah, byte [esi+ebx]
        mov ebx, dword [byte edx+02Ch]
        mov al, byte [esi+ebp]
        mov ebp, dword [byte edx+028h]
        mov dword [byte edi+04h], eax
        mov ah, byte [esi+ebx]
        mov ebx, dword [byte edx+024h]
        mov al, byte [esi+ebp]
        shl eax, 10h
        mov ebp, dword [byte edx+020h]
        mov ah, byte [esi+ebx]
        mov ebx, dword [byte edx+03Ch]
        mov al, byte [esi+ebp]
        mov ebp, dword [byte edx+038h]
        mov dword [byte edi+08h], eax
        mov ah, byte [esi+ebx]
        mov ebx, dword [byte edx+034h]
        mov al, byte [esi+ebp]
        shl eax, 10h
        mov ebp, dword [byte edx+030h]
        mov ah, byte [esi+ebx]
        mov ebx, dword [byte edx+04Ch]
        mov al, byte [esi+ebp]
        lea edx, [byte edx+040h]
        mov dword [byte edi+0Ch], eax
        sub ecx, byte 10h
        lea edi, [byte edi+010h]
        jns near .1
.2:
        add ecx, byte 0Ch
        js short .4
.3:
        mov ebp, dword [byte edx+08h]
        mov ah, byte [esi+ebx]
        mov ebx, dword [byte edx+04h]
        mov al, byte [esi+ebp]
        shl eax, 10h
        mov ebp, dword [edx]
        mov ah, byte [esi+ebx]
        mov ebx, dword [byte edx+01Ch]
        mov al, byte [esi+ebp]
        lea edx, [byte edx+010h]
        mov dword [edi], eax
        sub ecx, byte 4
        lea edi, [byte edi+04h]
        jns short .3
.4:
        add ecx, byte 3
        js short .6
        mov ebx, dword [edx]
.5:
        mov al, byte [esi+ebx]
        mov ebx, dword [byte edx+04h]
        mov byte [edi], al
        sub ecx, byte 1
        lea edx, [byte edx+04h]
        lea edi, [byte edi+01h]
        jns short .5
.6:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.7:
        add ecx, byte 10h
        mov ebx, dword [edx]
.8:
        mov al, byte [esi+ebx]
        mov ebx, dword [byte edx+04h]
        mov byte [edi], al
        lea edi, [byte edi+01h]
        lea edx, [byte edx+04h]
        test edi, 3
        lea ecx, [byte ecx-01h]
        jne short .8
        mov ebx, dword [byte edx+0Ch]
        sub ecx, byte 10h
        jns near .1
        jmp short .2
.9:
        mov ebx, dword [edx]
        cmp byte [ScreenBitsPerPixel], 10h
        jg short .11
        sub ecx, byte 1
        js short .6
.10:
        mov ax, word [esi+ebx*2]
        mov ebx, dword [byte edx+04h]
        mov word [edi], ax
        sub ecx, byte 1
        lea edx, [byte edx+04h]
        lea edi, [byte edi+02h]
        jns short .10
        jmp short .6
.11:
        sub ecx, byte 1
        js short .6
.12:
        mov eax, dword [esi+ebx*4]
        mov ebx, dword [byte edx+04h]
        mov dword [edi], eax
        sub ecx, byte 1
        lea edx, [byte edx+04h]
        lea edi, [byte edi+04h]
        jns short .12
        jmp short .6
