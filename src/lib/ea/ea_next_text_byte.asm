; EA library: NextTextByte, NextTextChar, BlitCore, SetBlitSource.
bits 32
%include "hockey.inc"
section s_122281 progbits alloc exec nowrite align=1
extern _curbrk, bcopy, BlitColumnOffsets, BlitDestOffsets, BlitSourcePtr, ClipLeftCol, ClipRight, ClipTopRow
extern ConvertArtRows, ConvertArtShape, DrawDestBuffer, DrawDestOffset, DrawDestPitch, FreeMemBlock, ScreenBitsPerPixel, ScreenBuffer
extern ScreenHeight, ScreenPitch, ShadeTable, ShapeRowBytes, str_F_BlitCore, str_Punct_FreeArtArchive, TextCharFunc, TextCharFuncNext
extern VesaSetBank
global NextTextByte, NextTextChar, NextTextChar_54, BlitCore, SetBlitSource
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; NextTextByte                                   122290  97 PC, low confidence
; Returns the next byte of a text string and advances the pointer
;-----------------------------------------------------------------------------
NextTextByte:
        push ebx
        push edx
        mov edx, dword [eax]
        inc edx
        xor ebx, ebx
        mov bl, byte [byte edx-01h]
        mov dword [eax], edx
        mov eax, ebx
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
        cmp eax, byte 20h
        jl short .1
        cmp eax, byte 7Fh
        jg short .1
        mov ax, word [nosplit eax*2+_curbrk]
        and eax, 0FFFFh
.1:
        ret
;-----------------------------------------------------------------------------
; NextTextChar                                   1222BC  97 PC, low confidence
; Returns the next character of a text string (two bytes when the high bit is
; set, mapped through the character table)
;-----------------------------------------------------------------------------
NextTextChar:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        mov eax, dword [eax]
        xor dh, dh
        mov dl, byte [eax]
        inc eax
        test dl, 80h
        je short .1
        xor ch, ch
        shl edx, 8
        mov cl, byte [eax]
        inc eax
        or edx, ecx
        jmp short .3
.1:
        and edx, 0FFFFh
        mov ecx, edx
        cmp edx, byte 20h
        jl short .2
        cmp edx, byte 7Fh
        jg short .2
        xor ecx, edx
        mov cx, word [nosplit edx*2+_curbrk]
.2:
        mov edx, ecx
.3:
        mov dword [ebx], eax
        xor eax, eax
        mov ax, dx
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
NextTextChar_54:
        push ecx
        push esi
        sub esp, 1400h
        mov esi, edx
        mov ecx, ebx
        mov edx, esp
        call dword [TextCharFuncNext]
        mov eax, esp
        mov ebx, ecx
        mov edx, esi
        call dword [TextCharFunc]
        add esp, 1400h
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; BlitCore                                       12233C  97 PC, low confidence
; Common blit engine: clips the shape, converts its pixel format and copies
; or scales it row by row
;-----------------------------------------------------------------------------
BlitCore:
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 1460h
        mov dword [byte ebp-04Ch], eax
        mov dword [byte ebp-050h], edx
        mov dword [byte ebp-024h], ebx
        mov edi, ecx
        mov eax, dword [byte ecx+018h]
        xor edx, edx
        mov esi, dword [byte edi+01Dh]
        mov dword [byte ebp-058h], edx
        mov dword [byte ebp-054h], eax
        xor ecx, ecx
        mov dword [TextCharFuncNext], edx
        mov cl, byte [str_Punct_FreeArtArchive]
        test esi, esi
        je short .1
        mov ecx, esi
.1:
        cmp dword [byte ebp-054h], byte 0
        jne short .3
        mov eax, dword [byte ebp-04Ch]
        mov eax, dword [eax]
        and eax, 0FFh
        cmp eax, ecx
        je short .3
        mov ah, byte [byte edi+01Ch]
        xor ebx, ebx
        cmp ah, 2
        setne al
        mov edx, ecx
        mov bl, al
        mov eax, dword [byte ebp-04Ch]
        call ConvertArtRows
        mov dword [byte ebp-054h], eax
        test eax, eax
        je short .2
        cmp byte [byte edi+01Ch], 2
        je short .3
        xor ebx, ebx
        mov dword [TextCharFuncNext], eax
        mov dword [byte ebp-054h], ebx
        jmp short .3
.2:
        mov dl, byte [byte edi+01Ch]
        cmp dl, 2
        setne al
        and eax, 0FFh
        push eax
        cmp dl, 1
        sete al
        and eax, 0FFh
        push eax
        push ecx
        mov edx, dword [byte ebp-04Ch]
        push edx
        call ConvertArtShape
        add esp, byte 10h
        mov dword [byte ebp-058h], eax
        mov dword [byte ebp-04Ch], eax
.3:
        mov eax, dword [byte ebp-04Ch]
        mov eax, dword [byte eax+02h]
        sar eax, 10h
        mov ebx, dword [byte ebp-04Ch]
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [byte ebp-04Ch]
        mov ebx, dword [byte ebx+04h]
        mov eax, dword [eax]
        and eax, byte 7Fh
        mov al, byte [dword eax+ShadeTable]
        inc eax
        and al, 0FEh
        mov dword [byte ebp-034h], eax
        mov eax, dword [byte ebp-0Ch]
        imul eax, dword [byte ebp-034h]
        sar eax, 3
        mov dword [byte ebp-05Ch], eax
        mov eax, dword [byte ebp-04Ch]
        push eax
        mov esi, dword [byte ebp-04Ch]
        call ShapeRowBytes
        mov edx, dword [byte ebp-05Ch]
        add esi, byte 10h
        sub eax, edx
        mov ecx, dword [byte ebp-024h]
        mov dword [byte ebp-03Ch], eax
        mov eax, dword [ClipLeftCol]
        sar ebx, 10h
        sub eax, ecx
        add esp, byte 4
        test eax, eax
        jle short .4
        imul edx, eax
        add esi, edx
        lea edx, [ecx+eax]
        sub ebx, eax
        mov dword [byte ebp-024h], edx
.4:
        mov eax, dword [byte ebp-024h]
        mov ecx, dword [ScreenHeight]
        add eax, ebx
        sub eax, ecx
        test eax, eax
        jle short .5
        sub ebx, eax
.5:
        mov edx, dword [byte ebp-050h]
        mov eax, dword [ClipTopRow]
        sub eax, edx
        test eax, eax
        jle short .6
        mov edx, dword [byte ebp-034h]
        imul edx, eax
        sub dword [byte ebp-0Ch], eax
        mov ecx, dword [byte ebp-050h]
        add ecx, eax
        mov eax, dword [byte ebp-03Ch]
        sar edx, 3
        mov dword [byte ebp-050h], ecx
        add eax, edx
        add esi, edx
        mov dword [byte ebp-03Ch], eax
.6:
        mov eax, dword [byte ebp-050h]
        mov edx, dword [byte ebp-0Ch]
        mov ecx, dword [ClipRight]
        add eax, edx
        sub eax, ecx
        test eax, eax
        jle short .7
        mov edx, dword [byte ebp-034h]
        imul edx, eax
        mov ecx, dword [byte ebp-03Ch]
        sar edx, 3
        add ecx, edx
        mov edx, dword [byte ebp-0Ch]
        sub edx, eax
        mov dword [byte ebp-03Ch], ecx
        mov dword [byte ebp-0Ch], edx
.7:
        mov ecx, dword [byte ebp-0Ch]
        test ecx, ecx
        jle near .33
        test ebx, ebx
        jle near .33
        xor eax, eax
        mov dword [byte ebp-018h], eax
        mov eax, dword [DrawDestPitch]
        mov dword [byte ebp-08h], eax
        xor eax, eax
        mov al, byte [ScreenBitsPerPixel]
        inc eax
        and al, 0FEh
        mov edx, dword [byte ebp-034h]
        mov dword [byte ebp-02Ch], eax
        mov eax, ecx
        imul eax, edx
        sar eax, 3
        mov dword [byte ebp-048h], eax
        mov eax, ecx
        imul eax, dword [byte ebp-02Ch]
        sar eax, 3
        mov dword [byte ebp-040h], eax
        mov eax, dword [byte ebp-024h]
        mov edx, dword [DrawDestBuffer]
        shl eax, 2
        add eax, edx
        mov edx, dword [byte ebp-050h]
        shl edx, 2
        mov dword [byte ebp-060h], edx
        mov ecx, dword [byte ebp-060h]
        mov edx, dword [DrawDestOffset]
        add edx, ecx
        mov ecx, dword [eax]
        mov eax, dword [edx]
        mov edx, dword [byte ebp-040h]
        add ecx, eax
        mov eax, dword [ScreenPitch]
        mov dword [byte ebp-01Ch], ebx
        sub eax, edx
        mov ebx, dword [byte ebp-054h]
        mov dword [byte ebp-044h], eax
        test ebx, ebx
        je short .8
        mov dword [byte ebp-04h], ebx
        jmp near .19
.8:
        mov al, byte [ScreenBitsPerPixel]
        cmp al, 0Fh
        jb short .10
        jbe short .13
        cmp al, 18h
        jb short .9
        jbe short .15
        cmp al, 20h
        je short .16
        jmp short .18
.9:
        cmp al, 10h
        je short .14
        jmp short .18
.10:
        cmp al, 4
        jb short .18
        jbe short .11
        cmp al, 8
        je short .12
        jmp short .18
.11:
        mov eax, dword [edi]
        jmp short .17
.12:
        mov eax, dword [byte edi+04h]
        jmp short .17
.13:
        mov eax, dword [byte edi+08h]
        jmp short .17
.14:
        mov eax, dword [byte edi+0Ch]
        jmp short .17
.15:
        mov eax, dword [byte edi+010h]
        jmp short .17
.16:
        mov eax, dword [byte edi+014h]
.17:
        mov dword [byte ebp-04h], eax
.18:
        cmp dword [TextCharFuncNext], byte 0
        je short .19
        mov eax, dword [byte ebp-04h]
        mov dword [TextCharFunc], eax
        mov dword [byte ebp-04h], NextTextChar_54
.19:
        cmp dword [ScreenBuffer], byte 0
        je short .20
        mov eax, ecx
        shr eax, 10h
        and ecx, 0FFFFh
        mov dword [byte ebp-018h], eax
        call VesaSetBank
.20:
        mov eax, dword [byte ebp-040h]
        add eax, dword [byte ebp-044h]
        mov edi, dword [byte ebp-03Ch]
        mov dword [byte ebp-010h], eax
        mov eax, dword [byte ebp-048h]
        add eax, edi
        mov dword [byte ebp-014h], eax
.21:
        cmp dword [ScreenBuffer], byte 0
        je short .22
        mov edi, dword [byte ebp-018h]
        mov edx, dword [byte ebp-024h]
        mov edi, dword [nosplit edi*4+str_F_BlitCore]
        sub edi, edx
        jmp short .23
.22:
        mov edi, dword [byte ebp-01Ch]
.23:
        mov ebx, dword [byte ebp-01Ch]
        cmp edi, ebx
        jle short .24
        mov edi, ebx
.24:
        test edi, edi
        je short .26
        mov eax, dword [byte ebp-024h]
        mov edx, dword [byte ebp-01Ch]
        mov ebx, dword [byte ebp-044h]
        add eax, edi
        sub edx, edi
        mov dword [byte ebp-024h], eax
        mov dword [byte ebp-01Ch], edx
        test ebx, ebx
        jne short .25
        cmp dword [byte ebp-03Ch], byte 0
        jne short .25
        cmp dword [byte ebp-04h], NextTextChar_54
        je short .25
        mov ebx, dword [byte ebp-0Ch]
        imul ebx, edi
        mov edx, dword [byte ebp-08h]
        mov eax, esi
        add edx, ecx
        call dword [byte ebp-04h]
        mov eax, dword [byte ebp-040h]
        imul eax, edi
        imul edi, dword [byte ebp-048h]
        add ecx, eax
        add esi, edi
        jmp short .26
.25:
        mov edx, dword [byte ebp-08h]
        mov ebx, dword [byte ebp-0Ch]
        mov eax, esi
        add edx, ecx
        call dword [byte ebp-04h]
        mov eax, dword [byte ebp-010h]
        mov edx, dword [byte ebp-014h]
        add ecx, eax
        add esi, edx
        dec edi
        jne short .25
.26:
        mov ebx, dword [byte ebp-01Ch]
        test ebx, ebx
        je near .32
        lea edi, [byte ebx-01h]
        mov dword [byte ebp-01Ch], edi
        test ecx, 10000h
        je short .27
        mov eax, dword [byte ebp-018h]
        inc eax
        and ecx, 0FFFFh
        mov dword [byte ebp-018h], eax
        call VesaSetBank
.27:
        mov edx, dword [byte ebp-08h]
        mov eax, dword [byte ebp-040h]
        add edx, ecx
        add eax, ecx
        mov dword [byte ebp-028h], edx
        mov edx, dword [byte ebp-048h]
        mov dword [byte ebp-030h], eax
        add edx, esi
        dec eax
        mov dword [byte ebp-038h], edx
        test eax, 10000h
        je near .29
        mov edi, 10000h
        mov eax, dword [byte ebp-030h]
        mov ebx, dword [byte ebp-02Ch]
        sub edi, ecx
        and eax, 0FFFFh
        lea edx, [nosplit edi*8+00h]
        mov dword [byte ebp-020h], eax
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov edx, dword [byte ebp-034h]
        imul edx, eax
        mov ebx, eax
        mov eax, edx
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        cmp eax, edi
        jne short .28
        mov edx, dword [byte ebp-028h]
        mov eax, esi
        call dword [byte ebp-04h]
        mov edx, dword [byte ebp-034h]
        imul edx, edi
        mov ebx, dword [byte ebp-02Ch]
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov ecx, dword [byte ebp-018h]
        inc ecx
        mov edx, dword [byte ebp-020h]
        add esi, eax
        mov eax, ecx
        shl edx, 3
        call VesaSetBank
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov dword [byte ebp-018h], ecx
        mov edi, ebx
        mov edx, dword [byte ebp-08h]
        mov ebx, eax
        mov eax, esi
        mov ecx, dword [byte ebp-020h]
        call dword [byte ebp-04h]
        mov eax, dword [byte ebp-034h]
        mov edx, ecx
        imul edx, eax
        mov ebx, edi
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        add esi, eax
        jmp near .30
.28:
        push edi
        lea eax, [dword ebp-01460h]
        push eax
        mov ecx, dword [byte ebp-028h]
        push ecx
        call bcopy
        mov eax, dword [byte ebp-018h]
        add esp, byte 0Ch
        inc eax
        call VesaSetBank
        mov eax, dword [byte ebp-020h]
        push eax
        lea eax, [dword ebp-01460h]
        add eax, edi
        push eax
        mov ebx, dword [byte ebp-08h]
        push ebx
        mov dword [byte ebp-060h], eax
        call bcopy
        mov ebx, dword [byte ebp-0Ch]
        add esp, byte 0Ch
        lea edx, [dword ebp-01460h]
        mov eax, esi
        call dword [byte ebp-04h]
        mov eax, dword [byte ebp-018h]
        call VesaSetBank
        push edi
        mov ecx, dword [byte ebp-028h]
        push ecx
        lea eax, [dword ebp-01460h]
        mov esi, dword [byte ebp-018h]
        push eax
        inc esi
        call bcopy
        add esp, byte 0Ch
        mov eax, esi
        mov edi, dword [byte ebp-020h]
        call VesaSetBank
        push edi
        mov eax, dword [byte ebp-08h]
        push eax
        mov edx, dword [byte ebp-060h]
        push edx
        mov dword [byte ebp-018h], esi
        mov esi, dword [byte ebp-038h]
        call bcopy
        add esp, byte 0Ch
        mov ecx, edi
        jmp short .30
.29:
        mov ebx, dword [byte ebp-0Ch]
        mov edx, dword [byte ebp-028h]
        mov eax, esi
        mov ecx, dword [byte ebp-030h]
        call dword [byte ebp-04h]
        mov esi, dword [byte ebp-038h]
.30:
        mov edi, dword [byte ebp-044h]
        mov eax, dword [byte ebp-03Ch]
        add ecx, edi
        add esi, eax
        test ecx, 10000h
        je short .31
        cmp dword [byte ebp-01Ch], byte 0
        je short .31
        mov ebx, dword [byte ebp-018h]
        inc ebx
        and ecx, 0FFFFh
        mov eax, ebx
        mov dword [byte ebp-018h], ebx
        call VesaSetBank
.31:
        inc dword [byte ebp-024h]
.32:
        cmp dword [byte ebp-01Ch], byte 0
        jg near .21
.33:
        mov edx, dword [byte ebp-058h]
        test edx, edx
        je short .34
        push edx
        call FreeMemBlock
        add esp, byte 4
.34:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        ret
        db 00h
;-----------------------------------------------------------------------------
; SetBlitSource                                  122838  97 PC, low confidence
; Sets the source pointer and the column offset table used by the span
; copiers
;-----------------------------------------------------------------------------
SetBlitSource:
        push ebp
        LD mov, ebp, esp
        mov eax, dword [byte ebp+08h]
        mov dword [BlitSourcePtr], eax
        mov eax, dword [byte ebp+0Ch]
        mov dword [BlitColumnOffsets], eax
        leave
        ret
        push ebp
        LD mov, ebp, esp
        mov eax, dword [byte ebp+08h]
        mov dword [BlitDestOffsets], eax
        leave
        ret
