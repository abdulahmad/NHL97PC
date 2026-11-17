; EA library: DrawTextLimited, DrawTextString, ConvertColor555, DrawGlyphScaled, IF@DACOS and 1 more.
bits 32
%include "hockey.inc"
section s_124C2F progbits alloc exec nowrite align=1
extern __@DSQRT, AtexitCount, DrawGlyphFn, DrawTextRun, F80_1p5708, IF@ATAN2, LinkTextFont, PaletteWords
extern ScreenBitsPerPixel, SetTextOrigin, str_Punct_DrawRinkSurface, strncpy_, TextCharFn, TextEndFn, TextLimitCount, TextLimitPtr
extern TextLimitWidth, TextOriginX, TextOriginY, zupstr__20
global DrawTextLimited, DrawTextString, ConvertColor555, DrawGlyphScaled, IF@DACOS, SetTextScale
        db 090h
;-----------------------------------------------------------------------------
; DrawTextLimited                                124C30  97 PC, low confidence
; Copies up to the given number of characters of a string and draws them at
; the current text origin
;-----------------------------------------------------------------------------
DrawTextLimited:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 10Ch
        mov edx, dword [dword esp+0120h]
        mov ebx, dword [dword esp+0124h]
        mov edi, dword [TextOriginX]
        mov esi, dword [TextOriginY]
        mov dword [AtexitCount], edi
        mov dword [TextLimitWidth], esi
        mov dword [TextLimitPtr], edi
        mov dword [TextLimitCount], esi
        cmp ebx, 100h
        jle short .1
        mov ebx, 100h
.1:
        xor ah, ah
        mov byte [esp+ebx], ah
        mov eax, esp
        call strncpy_
        mov edx, zupstr__20
        mov eax, dword [DrawGlyphFn]
        mov ebp, dword [TextEndFn]
        xor ebx, ebx
        mov dword [dword esp+0108h], eax
        mov dword [DrawGlyphFn], edx
        mov dword [TextEndFn], ebx
        mov eax, dword [TextCharFn]
        mov dl, byte [esp]
        mov dword [dword esp+0104h], eax
        mov dword [TextCharFn], ebx
        test dl, dl
        je short .2
        mov eax, esp
        push eax
        call DrawTextRun
        add esp, byte 4
.2:
        mov eax, dword [AtexitCount]
        cmp edi, eax
        jg short .3
        mov eax, edi
.3:
        mov edx, dword [dword esp+0128h]
        mov dword [edx], eax
        mov edx, dword [TextLimitWidth]
        cmp esi, edx
        jle short .4
        mov eax, edx
        jmp short .5
.4:
        mov eax, esi
.5:
        mov edx, dword [dword esp+012Ch]
        mov ebx, dword [TextOriginX]
        mov dword [edx], eax
        mov eax, dword [TextLimitPtr]
        cmp eax, ebx
        jg short .6
        mov eax, ebx
.6:
        mov ebx, dword [dword esp+0128h]
        mov ebx, dword [ebx]
        mov edx, dword [dword esp+0130h]
        sub eax, ebx
        mov ecx, dword [LinkTextFont]
        mov dword [edx], eax
        mov eax, dword [TextLimitCount]
        cmp eax, ecx
        jg short .7
        mov eax, ecx
.7:
        mov ebx, dword [dword esp+012Ch]
        push esi
        mov ebx, dword [ebx]
        mov edx, dword [dword esp+0138h]
        sub eax, ebx
        push edi
        mov dword [edx], eax
        call SetTextOrigin
        add esp, byte 8
        mov eax, dword [dword esp+0108h]
        mov dword [DrawGlyphFn], eax
        mov eax, dword [dword esp+0104h]
        mov dword [TextEndFn], ebp
        mov dword [TextCharFn], eax
        add esp, 10Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawTextString                                 124D78  97 PC, low confidence
; Draws a string of up to 256 characters at the current text origin
;-----------------------------------------------------------------------------
DrawTextString:
        push ebx
        push esi
        push edi
        mov edx, dword [byte esp+020h]
        push edx
        mov ebx, dword [byte esp+020h]
        push ebx
        mov ecx, dword [byte esp+020h]
        push ecx
        mov esi, dword [byte esp+020h]
        push esi
        push dword 100h
        mov edi, dword [byte esp+024h]
        push edi
        call DrawTextLimited
        add esp, byte 18h
        pop edi
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; ConvertColor555                                124DB0  97 PC, low confidence
; Converts a 15-bit RGB colour to the pixel format of the current screen
;-----------------------------------------------------------------------------
ConvertColor555:
        push ebx
        mov edx, dword [byte esp+08h]
        mov al, byte [ScreenBitsPerPixel]
        cmp al, 0Fh
        jb short .5
        mov ecx, edx
        mov ebx, edx
        and ecx, byte 1Fh
        sar ebx, 5
        shl ecx, 3
        cmp al, 0Fh
        jbe short .2
        cmp al, 18h
        jb short .1
        jbe short .4
        cmp al, 20h
        je short .4
        jmp short .5
.1:
        cmp al, 10h
        je short .3
        jmp short .5
.2:
        sar edx, 0Ah
        mov eax, ebx
        and edx, byte 1Fh
        and eax, byte 1Fh
        shl edx, 13h
        shl eax, 0Bh
        or eax, edx
        or eax, ecx
        pop ebx
        ret
.3:
        sar edx, 0Bh
        mov eax, ebx
        and edx, byte 1Fh
        and eax, byte 3Fh
        shl edx, 13h
        shl eax, 0Ah
        or eax, edx
        or eax, ecx
        pop ebx
        ret
.4:
        mov eax, edx
        pop ebx
        ret
.5:
        mov eax, dword [nosplit edx*4+PaletteWords]
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawGlyphScaled                                124E1C  97 PC, low confidence
; Draws one font glyph scaled by the current text scale
;-----------------------------------------------------------------------------
DrawGlyphScaled:
        push ebx
        push esi
        push edi
        push ebp
        cmp dword [byte esp+024h], byte 0
        jle near .7
        LD xor, ebx, ebx
        LD xor, edx, edx
        mov ebp, dword [byte esp+014h]
        mov esi, dword [byte esp+018h]
        mov edi, dword [byte esp+01Ch]
        mov ecx, dword [byte esp+020h]
        cmp ecx, byte 1
        jl near .7
        shr ecx, 1
        mov dword [byte esp+020h], ecx
        jb short .3
.1:
        mov ecx, dword [byte esp+020h]
.2:
        mov bh, byte [byte esi+01h]
        mov dh, byte [byte esi+01h]
        mov bl, byte [byte edi+02h]
        mov dl, byte [byte edi+03h]
        shr bh, 4
        and dh, 0Fh
        mov al, byte [ebx+ebp]
        mov ah, byte [edx+ebp]
        shl eax, 10h
        mov bh, byte [esi]
        mov dh, byte [esi]
        mov bl, byte [edi]
        mov dl, byte [byte edi+01h]
        shr bh, 4
        and dh, 0Fh
        mov al, byte [ebx+ebp]
        mov ah, byte [edx+ebp]
        sub ecx, byte 1
        mov dword [edi], eax
        lea esi, [byte esi+02h]
        lea edi, [byte edi+04h]
        jg short .2
        add esi, dword [byte esp+028h]
        add edi, dword [byte esp+02Ch]
        sub dword [byte esp+024h], byte 1
        jne short .1
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.3:
        add dword [byte esp+028h], byte 1
        add dword [byte esp+02Ch], byte 2
.4:
        mov ecx, dword [byte esp+020h]
        cmp ecx, byte 0
        je short .6
.5:
        mov bh, byte [byte esi+01h]
        mov dh, byte [byte esi+01h]
        mov bl, byte [byte edi+02h]
        mov dl, byte [byte edi+03h]
        shr bh, 4
        and dh, 0Fh
        mov al, byte [ebx+ebp]
        mov ah, byte [edx+ebp]
        shl eax, 10h
        mov bh, byte [esi]
        mov dh, byte [esi]
        mov bl, byte [edi]
        mov dl, byte [byte edi+01h]
        shr bh, 4
        and dh, 0Fh
        mov al, byte [ebx+ebp]
        mov ah, byte [edx+ebp]
        sub ecx, byte 1
        mov dword [edi], eax
        lea esi, [byte esi+02h]
        lea edi, [byte edi+04h]
        jg short .5
.6:
        mov bh, byte [esi]
        mov bl, byte [edi]
        mov dl, byte [byte edi+01h]
        LD mov, dh, bh
        shr bh, 4
        and dh, 0Fh
        mov al, byte [ebx+ebp]
        mov ah, byte [edx+ebp]
        mov word [edi], ax
        add esi, dword [byte esp+028h]
        add edi, dword [byte esp+02Ch]
        sub dword [byte esp+024h], byte 1
        jne short .4
.7:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 00h
;-----------------------------------------------------------------------------
; IF@DACOS                                                     124F22  library
; Run-time library acos core
;-----------------------------------------------------------------------------
IF@DACOS:
        fld st0
        fmul st0
        fld1
        fsubrp
        mov al, 1
        call __@DSQRT
        cmp al, 0
        jne short .1
        fxch
        call IF@ATAN2
        fld tword [F80_1p5708]
        fsubrp
.1:
        ret
        fld qword [byte esp+04h]
        call IF@DACOS
        ret 8
        db 00h,00h,00h
        push ebp
        LD mov, ebp, esp
        add esp, byte 0FFFFFFF8h
        push ebx
        push esi
        push edi
        mov eax, dword [str_Punct_DrawRinkSurface]
        jmp short .2
        push ebp
        LD mov, ebp, esp
        add esp, byte 0FFFFFFF8h
        push ebx
        push esi
        push edi
        mov eax, dword [byte ebp+014h]
.2:
        mov esi, dword [byte ebp+08h]
        mov ebx, dword [byte ebp+0Ch]
        mov edi, dword [byte ebp+010h]
        mov dword [byte edi+08h], eax
        sub eax, dword [byte ebx+08h]
        mov dword [byte ebp-08h], eax
        mov eax, dword [byte esi+08h]
        sub eax, dword [byte ebx+08h]
        LD or, eax, eax
        jge short .3
        shr dword [byte ebp-08h], 1
        shr eax, 1
.3:
        mov dword [byte ebp-04h], eax
        mov eax, dword [esi]
        sub eax, dword [ebx]
        imul dword [byte ebp-08h]
        idiv dword [byte ebp-04h]
        add eax, dword [ebx]
        mov dword [edi], eax
        mov eax, dword [byte esi+04h]
        sub eax, dword [byte ebx+04h]
        imul dword [byte ebp-08h]
        idiv dword [byte ebp-04h]
        add eax, dword [byte ebx+04h]
        mov dword [byte edi+04h], eax
        pop edi
        pop esi
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SetTextScale                                   124FB9  97 PC, low confidence
; Sets the scale used to draw text glyphs
;-----------------------------------------------------------------------------
SetTextScale:
        push ebp
        LD mov, ebp, esp
        mov eax, dword [byte ebp+08h]
        mov dword [str_Punct_DrawRinkSurface], eax
        leave
        ret
