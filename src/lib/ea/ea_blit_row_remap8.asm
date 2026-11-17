; EA library: BlitRowRemap8, BlitRowKey16, BlitRowKey24, BlitRowKey32, BlitShapeKeyed and 3 more.
bits 32
%include "hockey.inc"
section s_11599A progbits alloc exec nowrite align=1
extern BackBufferWidth, BlitCore, Convert32To565Keyed, ConvertArtPalette, IdentityRemap, KeyedBlitState, KeyedRowFuncs, KeyRowTable
extern LoadDrawContext, PaletteWords, ScreenBitsPerPixel, ScreenWidth, ShadeTable
global BlitRowRemap8, BlitRowKey16, BlitRowKey24, BlitRowKey32, BlitRowKey32_1C, BlitShapeKeyed, BlitShapeAt, SaveDrawContext
global RestoreDrawContext
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; BlitRowRemap8                                  11599C  97 PC, low confidence
; Graphics library: copies a row of 8-bit pixels through the remap table,
; skipping transparent ones
;-----------------------------------------------------------------------------
BlitRowRemap8:
        push ecx
.1:
        xor ecx, ecx
        mov cl, byte [eax]
        mov cl, byte [dword ecx+IdentityRemap]
        inc eax
        cmp cl, 0FFh
        je short .2
        mov byte [edx], cl
.2:
        inc edx
        dec ebx
        jne short .1
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; BlitRowKey16                                   1159B8  97 PC, low confidence
; Graphics library: copies a row of 16-bit pixels, skipping transparent ones
;-----------------------------------------------------------------------------
BlitRowKey16:
        push ecx
.1:
        mov cx, word [eax]
        test cx, cx
        je short .2
        mov word [edx], cx
.2:
        add eax, byte 2
        add edx, byte 2
        dec ebx
        jne short .1
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; BlitRowKey24                                   1159D0  97 PC, low confidence
; Graphics library: copies a row of 24-bit pixels, skipping transparent ones
;-----------------------------------------------------------------------------
BlitRowKey24:
        push ecx
        push esi
        push edi
        mov esi, eax
        mov edi, 3
.1:
        mov ecx, edi
        mov eax, esi
        mov eax, dword [byte ecx+eax-04h]
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        test eax, eax
        je short .2
        mov al, byte [esi]
        mov byte [edx], al
        mov al, byte [byte esi+01h]
        mov byte [byte edx+01h], al
        mov al, byte [byte esi+02h]
        mov byte [byte edx+02h], al
.2:
        add esi, byte 3
        add edx, byte 3
        dec ebx
        jne short .1
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; BlitRowKey32                                   115A10  97 PC, low confidence
; Graphics library: copies a row of 32-bit pixels, skipping transparent ones
;-----------------------------------------------------------------------------
BlitRowKey32:
        push ecx
        push esi
.1:
        mov ecx, dword [eax]
        mov esi, ecx
        shr esi, 18h
        test esi, esi
        je short .2
        mov dword [edx], ecx
.2:
        add eax, byte 4
        add edx, byte 4
        dec ebx
        jne short .1
        pop esi
        pop ecx
        ret
        db 090h
BlitRowKey32_1C:
        push ecx
.3:
        xor ecx, ecx
        mov cl, byte [eax]
        mov cl, byte [dword ecx+IdentityRemap]
        inc eax
        cmp cl, 0FFh
        je short .4
        and ecx, 0FFh
        mov cx, word [nosplit ecx*2+KeyRowTable]
        mov word [edx], cx
.4:
        add edx, byte 2
        dec ebx
        jne short .3
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; BlitShapeKeyed                                 115A58  97 PC, low confidence
; Graphics library: draws a shape with transparency, row by row, for its
; pixel depth
;-----------------------------------------------------------------------------
BlitShapeKeyed:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 400h
        mov esi, dword [dword esp+0414h]
        mov eax, esi
        mov eax, dword [eax]
        and eax, byte 7Fh
        mov al, byte [dword eax+ShadeTable]
        mov edx, eax
        cmp eax, byte 4
        jne short .1
        xor edi, edi
        jmp short .2
.1:
        mov edi, 0FFh
.2:
        xor ebx, ebx
        mov ebp, dword [nosplit edi*4+PaletteWords]
        mov dword [KeyedBlitState], ebx
        mov dword [nosplit edi*4+PaletteWords], ebx
        cmp edx, byte 8
        jne short .3
        cmp byte [ScreenBitsPerPixel], 10h
        jne short .3
        mov edx, esp
        mov eax, esi
        mov ebx, 100h
        call ConvertArtPalette
        mov edx, KeyRowTable
        call Convert32To565Keyed
        mov dword [KeyedBlitState], BlitRowKey32_1C
.3:
        mov ecx, KeyedRowFuncs
        mov ebx, dword [dword esp+041Ch]
        mov edx, dword [dword esp+0418h]
        mov eax, esi
        call BlitCore
        mov dword [nosplit edi*4+PaletteWords], ebp
        add esp, 400h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        mov edx, dword [byte esp+04h]
        mov eax, dword [byte edx+0Ch]
        sar eax, 10h
        push eax
        mov eax, dword [byte edx+0Ah]
        sar eax, 10h
        push eax
        push edx
        call BlitShapeKeyed
        add esp, byte 0Ch
        ret
        push ebx
        mov edx, dword [byte esp+08h]
        mov eax, dword [byte edx+08h]
        mov ebx, dword [byte esp+010h]
        sar eax, 10h
        sub ebx, eax
        push ebx
        mov eax, dword [byte edx+06h]
        mov ebx, dword [byte esp+010h]
        sar eax, 10h
        sub ebx, eax
        push ebx
        push edx
        call BlitShapeKeyed
        add esp, byte 0Ch
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        mov ecx, dword [byte esp+010h]
        push ecx
        call BlitShapeKeyed
        add esp, byte 0Ch
        pop ebx
        ret
        db 08Bh,0C0h
        mov edx, dword [byte esp+04h]
        mov eax, dword [byte edx+0Ch]
        sar eax, 10h
        push eax
        mov eax, dword [byte edx+0Ah]
        sar eax, 10h
        push eax
        push edx
        call BlitShapeKeyed
        add esp, byte 0Ch
        ret
;-----------------------------------------------------------------------------
; BlitShapeAt                                    115B78  97 PC, low confidence
; Graphics library: draws a shape with transparency at x, y less its hot spot
;-----------------------------------------------------------------------------
BlitShapeAt:
        push ebx
        mov edx, dword [byte esp+08h]
        mov eax, dword [byte edx+08h]
        mov ebx, dword [byte esp+010h]
        sar eax, 10h
        sub ebx, eax
        push ebx
        mov eax, dword [byte edx+06h]
        mov ebx, dword [byte esp+010h]
        sar eax, 10h
        sub ebx, eax
        push ebx
        push edx
        call BlitShapeKeyed
        add esp, byte 0Ch
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; SaveDrawContext                                115BB0  97 PC, low confidence
; Graphics library: saves the draw target and clip window
;-----------------------------------------------------------------------------
SaveDrawContext:
        push esi
        push edi
        mov eax, dword [byte esp+0Ch]
        mov ecx, 0Eh
        mov esi, ScreenWidth
        mov edi, eax
        rep movsd
        mov ecx, 0Eh
        mov esi, BackBufferWidth
        lea edi, [byte eax+038h]
        rep movsd
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; RestoreDrawContext                             115BD8  97 PC, low confidence
; Graphics library: restores the saved draw target and clip window
;-----------------------------------------------------------------------------
RestoreDrawContext:
        push esi
        push edi
        mov esi, dword [byte esp+0Ch]
        push esi
        mov edi, BackBufferWidth
        call LoadDrawContext
        mov ecx, 0Eh
        lea esi, [byte esi+038h]
        add esp, byte 4
        rep movsd
        pop edi
        pop esi
        ret
