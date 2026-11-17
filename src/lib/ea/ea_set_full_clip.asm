; EA library: SetFullClip, DrawShadowRect, CountFrameTick.
bits 32
%include "hockey.inc"
section s_11BD81 progbits alloc exec nowrite align=1
extern AngleFromDelta, FillShadowRect, FrameCounter, FrameTickCount, MenuScreenBitmap, PaletteDirty, PaletteWords, SetClipWindow
extern SinTable, str_Punct_CountFrameTick
global SetFullClip, DrawShadowRect, CountFrameTick
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; SetFullClip                                    11BD90  97 PC, low confidence
; Sets the clip window to the whole bitmap
;-----------------------------------------------------------------------------
SetFullClip:
        push ebx
        push esi
        mov edx, dword [byte esp+018h]
        push edx
        mov ebx, dword [byte esp+014h]
        push ebx
        mov ecx, dword [byte esp+01Ch]
        push ecx
        mov esi, dword [byte esp+018h]
        push esi
        call SetClipWindow
        add esp, byte 10h
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; DrawShadowRect                                 11BDC0  97 PC, low confidence
; Draws a shadow rectangle
;-----------------------------------------------------------------------------
DrawShadowRect:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 20h
        mov ebp, dword [byte esp+040h]
        mov edi, dword [byte esp+048h]
        mov eax, dword [byte esp+03Ch]
        mov ecx, dword [byte esp+038h]
        mov ebx, ebp
        mov edx, dword [byte esp+034h]
        sub ebx, ecx
        sub eax, edx
        mov edx, ebx
        sar edx, 2
        add ebx, edx
        push ebx
        push eax
        call AngleFromDelta
        add esp, byte 8
        mov ebx, eax
        lea ecx, [dword eax+0100h]
        shl ch, 7
        sbb edx, edx
        add ch, ch
        sbb ecx, ecx
        xor eax, ecx
        and eax, 0FFh
        sub eax, ecx
        mov eax, dword [nosplit eax*4+SinTable]
        xor eax, edx
        sub eax, edx
        mov edx, eax
        neg edx
        mov eax, edi
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov esi, eax
        mov eax, ebx
        shl ah, 7
        sbb edx, edx
        add ah, ah
        sbb ecx, ecx
        xor eax, ecx
        and eax, 0FFh
        sub eax, ecx
        mov eax, dword [nosplit eax*4+SinTable]
        xor eax, edx
        sub eax, edx
        mov edx, eax
        mov eax, edi
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov edx, eax
        mov ebx, eax
        sar edx, 2
        sar eax, 4
        sub ebx, edx
        lea edx, [ebx+eax]
        mov eax, esi
        mov edi, dword [byte esp+034h]
        sar eax, 1
        mov ebx, edx
        add edi, eax
        sar ebx, 1
        mov dword [esp], edi
        mov edi, dword [byte esp+038h]
        add edi, ebx
        mov dword [byte esp+04h], edi
        mov edi, dword [byte esp+03Ch]
        sub esi, eax
        add edi, eax
        lea eax, [ebx+ebp]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte esp+03Ch]
        sub eax, esi
        mov dword [byte esp+010h], eax
        mov eax, dword [byte esp+034h]
        sub eax, esi
        sub edx, ebx
        mov dword [byte esp+018h], eax
        mov eax, dword [byte esp+038h]
        sub eax, edx
        mov dword [byte esp+01Ch], eax
        mov eax, esp
        push eax
        push byte 4
        mov esi, dword [byte esp+04Ch]
        sub ebp, edx
        push esi
        mov dword [byte esp+014h], edi
        mov dword [byte esp+020h], ebp
        call FillShadowRect
        add esp, byte 0Ch
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 00h,00h,00h
;-----------------------------------------------------------------------------
; CountFrameTick                                 11BED4  97 PC, low confidence
; Counts a frame and checks the frame rate
;-----------------------------------------------------------------------------
CountFrameTick:
        push ebx
        push esi
        push edi
        push ebp
        inc dword [FrameCounter]
        cmp dword [MenuScreenBitmap], byte 8
        jg short .2
        mov ebp, dword [byte esp+01Ch]
        mov edx, 3C8h
        mov eax, dword [byte esp+014h]
        out dx, al
        lea edi, [nosplit eax*4+PaletteWords]
        mov ebx, dword [byte esp+018h]
        inc edx
        push eax
.1:
        mov eax, dword [byte ebp-01h]
        bswap eax
        and eax, 3F3F3Fh
        lea eax, [nosplit eax*4-01000000h]
        mov dword [edi], eax
        mov eax, dword [byte ebp+00h]
        and eax, dword [str_Punct_CountFrameTick]
        mov ecx, dword [FrameTickCount]
        shl eax, cl
        mov dword [esp], eax
        lea esi, [esp]
        mov ecx, 3
        rep outsb
        dec ebx
        lea ebp, [byte ebp+03h]
        lea edi, [byte edi+04h]
        jne short .1
        pop eax
        mov byte [PaletteDirty], 0
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.2:
        mov ebp, dword [byte esp+01Ch]
        mov eax, dword [byte esp+014h]
        lea edi, [nosplit eax*4+PaletteWords]
        mov ebx, dword [byte esp+018h]
.3:
        mov eax, dword [byte ebp-01h]
        bswap eax
        and eax, 3F3F3Fh
        lea eax, [nosplit eax*4-01000000h]
        mov dword [edi], eax
        dec ebx
        lea ebp, [byte ebp+03h]
        lea edi, [byte edi+04h]
        jne short .3
        mov byte [PaletteDirty], 0
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
