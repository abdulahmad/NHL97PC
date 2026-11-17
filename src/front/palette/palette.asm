; Palette: fades, range palettes, art remapping and colour quantizing.
bits 32
%include "hockey.inc"
section s_3D02A progbits alloc exec nowrite align=1
extern __STOSB, __STOSD, addtimer, AllocMemBlock, ArtBankCount, ArtBankEntry, ArtRemapTable, bcopy
extern BuildInverseTable, BytesPerPixelForDepth, FadeAccumB, FadeAccumG, FadeAccumLast, FadeAccumNext, FadeAccumR, FadeAccums
extern FadeActive, FadeDone, FadeEntryCount, FadeFirstEntry, FadeFramesLeft, FadePalBytes, FadePalCount, FadePalCurrent
extern FadePalStepG, FadePalStepR, FadePalSteps, FadePalTarget, FadePalTargetBytes, FadePalTargetG, FadeStepCount, FreeMemBlock
extern IdentityRemap, memcpy_, PaletteRangeCount, PaletteRanges, QuantizeByte, QuantizePalette, QuantizeTable, RangeBlendLevel
extern ReadPaletteRange, RemapPixelRange, RemoveTimerCallback, ServiceIdle, str_HIST, str_MEGAHIST, StreamBlockCount, strncpy_
extern TranslatePixels, ViewPixelHeight, WritePaletteRange
global FadePaletteStep, FadePaletteStep_FC, PaletteFadeTick, StartPaletteFade, BuildRangePalette, BlendRangePalette, CountArtPixels, RemapArtColors
global RemapArtToRange, RemapArtRange, NewColorHistogram, ArtBankHistogram, InitPaletteManager, ShutdownPaletteManager, AddPaletteRange, LinkRangeHistogram
global AddArtToRange, AddBankToRange, RemapArtBank, SetRangeColors, AddColorTable, RemapBankToRange, RemapRangeColors, RemapArtPixels
global RemapArtPixels_70, FillQuantBoxes, ColorMomentTables, SplitColorBox, MergeColorBoxes, FindSmallestBox, CopyRangePalette, BuildRangePaletteBuf
global QuantizeRange, QuantizeAllRanges, SetRangePalette, MergeRangePalettes, BuildGamePalette, FadeGamePalette
        db 00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; FadePaletteStep                                 3D030  97 PC, low confidence
; One step of a palette fade: moves each colour toward its target
;-----------------------------------------------------------------------------
FadePaletteStep:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp dword [FadeActive], byte 0
        je near .3
        xor esi, esi
        mov edi, dword [FadeFirstEntry]
        mov dword [FadeStepCount], esi
        test edi, edi
        jle near .2
        lea ecx, [nosplit edi*4+00h]
        xor eax, eax
        xor edx, edx
.1:
        mov bx, word [dword eax+FadePalStepG]
        mov si, word [dword eax+FadeAccumNext]
        add esi, ebx
        xor ebx, ebx
        mov bx, si
        mov ebp, dword [FadeStepCount]
        sar ebx, 8
        mov di, word [dword eax+FadeAccumLast]
        mov byte [dword edx+FadePalBytes], bl
        mov bx, word [dword eax+FadePalSteps]
        add eax, byte 6
        add edi, ebx
        xor ebx, ebx
        add edx, byte 4
        mov bx, di
        mov word [dword eax+FadeAccumR], si
        sar ebx, 8
        mov si, word [dword eax+FadeAccumB]
        mov byte [dword edx+FadePalCurrent], bl
        mov bx, word [dword eax+FadePalStepR]
        inc ebp
        add esi, ebx
        xor ebx, ebx
        mov dword [FadeStepCount], ebp
        mov bx, si
        mov word [dword eax+FadeAccumG], di
        sar ebx, 8
        mov word [dword eax+FadeAccumB], si
        mov byte [dword edx+ViewPixelHeight], bl
        cmp edx, ecx
        jl near .1
.2:
        push FadePalCount
        mov eax, dword [FadeFirstEntry]
        push eax
        mov edx, dword [FadeEntryCount]
        push edx
        call WritePaletteRange
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        push FadePalTarget
        mov ebx, dword [FadeFirstEntry]
        push ebx
        mov ecx, dword [FadeEntryCount]
        push ecx
        call WritePaletteRange
        add esp, byte 0Ch
        pop ebp
        pop edi
FadePaletteStep_FC:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PaletteFadeTick                                 3D134  97 PC, low confidence
; Timer routine: runs a palette fade step every few ticks
;-----------------------------------------------------------------------------
PaletteFadeTick:
        push ebx
        push ecx
        push edx
        push edi
        push ebp
        mov edx, dword [FadeActive]
        test edx, edx
        jle short .1
        mov ecx, dword [FadeFramesLeft]
        dec ecx
        mov dword [FadeFramesLeft], ecx
        test ecx, ecx
        jg short .2
        lea edi, [byte edx-01h]
        mov ebp, 5
        mov dword [FadeActive], edi
        call FadePaletteStep
        mov dword [FadeFramesLeft], ebp
        jmp short .2
.1:
        xor ebx, ebx
        mov dword [FadeDone], ebx
.2:
        pop ebp
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StartPaletteFade                                3D180  97 PC, low confidence
; Starts a fade from the current palette to the given one over a number of
; steps
;-----------------------------------------------------------------------------
StartPaletteFade:
        push esi
        push edi
        push ebp
        sub esp, 404h
        mov ebp, eax
        mov edi, edx
        mov esi, ecx
        mov dword [FadeEntryCount], eax
        mov dword [FadeFirstEntry], edx
        cmp ecx, byte 1
        jge short .1
        mov esi, 1
.1:
        lea eax, [nosplit edi*4+00h]
        push eax
        push FadePalTarget
        xor edx, edx
        push ebx
        mov dword [FadeFramesLeft], edx
        mov dword [dword esp+040Ch], eax
        call bcopy
        add esp, byte 0Ch
        mov eax, esp
        push eax
        push edi
        push ebp
        call ReadPaletteRange
        add esp, byte 0Ch
        test edi, edi
        jle short .3
        mov edx, dword [dword esp+0400h]
        xor ebx, ebx
        xor ecx, ecx
.2:
        xor ah, ah
        mov al, byte [byte esp+ebx+02h]
        shl eax, 8
        mov word [dword ecx+FadeAccumNext], ax
        xor ah, ah
        mov al, byte [byte esp+ebx+01h]
        shl eax, 8
        mov word [dword ecx+FadeAccumLast], ax
        xor ah, ah
        mov al, byte [esp+ebx]
        add ecx, byte 6
        shl eax, 8
        add ebx, byte 4
        mov word [dword ecx+FadeAccumB], ax
        cmp ebx, edx
        jl short .2
.3:
        test edi, edi
        jle near .5
        shl edi, 2
        xor ecx, ecx
        xor ebx, ebx
.4:
        xor eax, eax
        xor edx, edx
        mov al, byte [dword ecx+FadePalTargetBytes]
        mov dx, word [dword ebx+FadeAccumNext]
        shl eax, 8
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        idiv esi
        mov word [dword ebx+FadePalStepG], ax
        xor eax, eax
        xor edx, edx
        mov al, byte [dword ecx+FadePalTargetG]
        mov dx, word [dword ebx+FadeAccumLast]
        shl eax, 8
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        idiv esi
        mov word [dword ebx+FadePalSteps], ax
        xor eax, eax
        xor edx, edx
        mov al, byte [dword ecx+FadePalTarget]
        mov dx, word [dword ebx+FadeAccums]
        shl eax, 8
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        idiv esi
        add ebx, byte 6
        add ecx, byte 4
        mov word [dword ebx+FadePalStepR], ax
        cmp ecx, edi
        jl short .4
.5:
        mov dword [FadeActive], esi
        mov dword [FadeDone], 1
        add esp, 404h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; BuildRangePalette                               3D2C0  97 PC, low confidence
; Fills a palette range from its colour table
;-----------------------------------------------------------------------------
BuildRangePalette:
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov dword [byte esp+04h], edx
        mov ebp, ebx
        mov edi, ecx
        mov ebx, eax
        shl eax, 5
        add eax, ebx
        shl eax, 2
        sub eax, ebx
        mov ebx, PaletteRanges
        shl eax, 3
        add ebx, eax
        mov edx, dword [byte ebx+0Ch]
        xor esi, esi
        test edx, edx
        jle near .2
        mov ecx, dword [byte esp+04h]
.1:
        xor edx, edx
        xor eax, eax
        mov dl, byte [ecx]
        mov al, byte [byte ebp+00h]
        sub eax, edx
        mov edx, edi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov ah, byte [ecx]
        add ah, al
        mov byte [byte esp+08h], ah
        mov eax, dword [byte ebx+08h]
        add eax, esi
        mov dl, byte [byte esp+08h]
        mov byte [byte ebx+eax*4+016h], dl
        xor eax, eax
        mov al, byte [byte ebp+01h]
        mov dword [esp], eax
        xor eax, eax
        mov edx, dword [esp]
        mov al, byte [byte ecx+01h]
        sub edx, eax
        mov eax, edx
        mov edx, edi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov ah, byte [byte ecx+01h]
        add ah, al
        mov byte [byte esp+08h], ah
        mov eax, dword [byte ebx+08h]
        add eax, esi
        mov dl, byte [byte esp+08h]
        mov byte [byte ebx+eax*4+015h], dl
        xor edx, edx
        xor eax, eax
        mov dl, byte [byte ecx+02h]
        mov al, byte [byte ebp+02h]
        sub eax, edx
        mov edx, edi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov ah, byte [byte ecx+02h]
        add ah, al
        mov byte [byte esp+08h], ah
        mov eax, dword [byte ebx+08h]
        add eax, esi
        mov dl, byte [byte esp+08h]
        mov byte [byte ebx+eax*4+014h], dl
        mov eax, dword [byte ebx+08h]
        add eax, esi
        add ebp, byte 3
        mov byte [byte ebx+eax*4+017h], 0
        inc esi
        mov eax, dword [byte ebx+0Ch]
        add ecx, byte 3
        cmp esi, eax
        jl near .1
.2:
        cmp dword [RangeBlendLevel], 10000h
        jne short .3
        mov ecx, dword [byte ebx+08h]
        lea eax, [byte ebx+014h]
        shl ecx, 2
        add eax, ecx
        push eax
        mov ecx, dword [byte ebx+0Ch]
        push ecx
        mov esi, dword [byte ebx+08h]
        push esi
        call WritePaletteRange
        add esp, byte 0Ch
.3:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; BlendRangePalette                               3D3D0  97 PC, low confidence
; Fills a palette range blended toward a colour
;-----------------------------------------------------------------------------
BlendRangePalette:
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov esi, dword [byte esp+018h]
        mov edi, eax
        mov ebp, ebx
        mov dword [esp], ecx
        mov eax, edx
        mov ebx, edi
        mov edx, ebx
        shl edx, 5
        add edx, ebx
        shl edx, 2
        sub edx, ebx
        mov ebx, PaletteRanges
        shl edx, 3
        add ebx, edx
        mov edx, eax
        shl eax, 2
        sub eax, edx
        mov edi, dword [esp]
        lea ecx, [eax+ebp]
        add edi, eax
        xor edx, edx
        xor eax, eax
        mov dl, byte [edi]
        mov al, byte [ecx]
        sub edx, eax
        mov eax, edx
        mov edx, esi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov ah, byte [ecx]
        add ah, al
        xor edx, edx
        mov byte [byte esp+06h], ah
        xor eax, eax
        mov dl, byte [byte ecx+01h]
        mov al, byte [byte edi+01h]
        sub eax, edx
        mov edx, esi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov ah, byte [byte ecx+01h]
        add ah, al
        xor edx, edx
        mov byte [byte esp+05h], ah
        xor eax, eax
        mov dl, byte [byte edi+02h]
        mov al, byte [byte ecx+02h]
        sub edx, eax
        mov eax, edx
        mov edx, esi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov ah, byte [byte ecx+02h]
        add ah, al
        mov byte [byte esp+04h], ah
        xor ah, ah
        mov edx, dword [byte ebx+0Ch]
        mov byte [byte esp+07h], ah
        xor eax, eax
        test edx, edx
        jle short .2
.1:
        mov edx, dword [byte ebx+08h]
        add edx, eax
        mov ecx, dword [byte esp+04h]
        mov dword [byte ebx+edx*4+014h], ecx
        inc eax
        cmp eax, dword [byte ebx+0Ch]
        jl short .1
.2:
        cmp dword [RangeBlendLevel], 10000h
        jne short .3
        mov edx, dword [byte ebx+08h]
        lea eax, [byte ebx+014h]
        shl edx, 2
        add eax, edx
        push eax
        mov edi, dword [byte ebx+0Ch]
        push edi
        mov ebp, dword [byte ebx+08h]
        push ebp
        call WritePaletteRange
        add esp, byte 0Ch
.3:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CountArtPixels                                  3D4C4  97 PC, low confidence
; Adds the pixels of an art to the colour use table
;-----------------------------------------------------------------------------
CountArtPixels:
        push ebx
        push ecx
        push edx
        mov edx, dword [byte eax+02h]
        mov ebx, dword [byte eax+04h]
        sar edx, 10h
        sar ebx, 10h
        imul edx, ebx
        push edx
        push IdentityRemap
        add eax, byte 10h
        push eax
        call TranslatePixels
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        push eax
        call ArtBankCount
        add esp, byte 4
        mov ebx, eax
.1:
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je near FadePaletteStep_FC
        push ebx
        push esi
        call ArtBankEntry
        mov edx, dword [eax]
        mov ecx, dword [ArtRemapTable]
        and edx, 0FFh
        add esp, byte 8
        cmp edx, ecx
        jne short .1
        mov edx, dword [byte eax+02h]
        mov ecx, dword [byte eax+04h]
        sar edx, 10h
        sar ecx, 10h
        imul edx, ecx
        push edx
        push IdentityRemap
        add eax, byte 10h
        push eax
        call TranslatePixels
        add esp, byte 0Ch
        jmp short .1
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; RemapArtColors                                  3D548  97 PC, low confidence
; Remaps the pixels of a bank's art through a colour table
;-----------------------------------------------------------------------------
RemapArtColors:
        push esi
        push edi
        push ebp
        sub esp, 104h
        mov ebp, eax
        mov edi, edx
        mov dword [dword esp+0100h], ebx
        mov esi, ecx
        mov edx, IdentityRemap
        mov eax, esp
        mov ebx, ecx
        call memcpy_
        xor eax, eax
.1:
        mov byte [dword eax+IdentityRemap], al
        inc eax
        cmp eax, 100h
        jl short .1
        xor eax, eax
        test esi, esi
        jle short .3
        mov dl, byte [dword esp+0100h]
        mov ebx, edi
        add dl, al
.2:
        inc eax
        mov byte [dword ebx+IdentityRemap], dl
        inc ebx
        inc dl
        cmp eax, esi
        jl short .2
.3:
        push ebp
        call ArtBankCount
        mov edi, ebp
        add esp, byte 4
        mov ebx, eax
.4:
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je short .5
        push ebx
        push edi
        call ArtBankEntry
        mov edx, dword [eax]
        mov ecx, dword [ArtRemapTable]
        and edx, 0FFh
        add esp, byte 8
        cmp edx, ecx
        jne short .4
        call CountArtPixels
        jmp short .4
.5:
        mov edx, esp
        mov eax, IdentityRemap
        mov ebx, esi
        call memcpy_
        add esp, 104h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RemapArtToRange                                 3D5EC  97 PC, low confidence
; Remaps an art bank into a palette range
;-----------------------------------------------------------------------------
RemapArtToRange:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 100h
        mov ecx, eax
        mov edi, edx
        test bl, 1
        sete al
        movzx esi, al
        mov edx, IdentityRemap
        add esi, 0FEh
        mov eax, esp
        mov ebx, esi
        call memcpy_
        push ecx
        push esi
        push byte 0
        call RemapPixelRange
        add esp, byte 0Ch
        push edi
        mov ebp, esi
        mov esi, edi
        call ArtBankCount
        add esp, byte 4
        mov ebx, eax
.1:
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je near RemapArtPixels_70
        push ebx
        push esi
        call ArtBankEntry
        mov edx, dword [eax]
        mov ecx, dword [ArtRemapTable]
        and edx, 0FFh
        add esp, byte 8
        cmp edx, ecx
        jne short .1
        call CountArtPixels
        jmp short .1
        db 090h
;-----------------------------------------------------------------------------
; RemapArtRange                                   3D660  97 PC, low confidence
; Remaps an art bank to the colours of a palette range, keeping the reserved
; colours
;-----------------------------------------------------------------------------
RemapArtRange:
        push esi
        push edi
        push ebp
        sub esp, 404h
        mov esi, eax
        mov dword [dword esp+0400h], edx
        mov ebp, ebx
        mov edi, ecx
        lea eax, [ebx+ecx]
        cmp eax, 0FFh
        jle short .1
        lea edi, [byte ecx-01h]
.1:
        lea eax, [edi+ebp]
        cmp eax, 0FEh
        jle short .2
        test byte [dword esp+0414h], 1
        je short .2
        dec edi
.2:
        xor ecx, ecx
        test edi, edi
        jle short .4
        lea edx, [nosplit ebp*4+00h]
        add edx, esi
        lea esi, [nosplit edi*4+00h]
        xor eax, eax
        sub esi, edi
.3:
        mov bl, byte [byte edx+02h]
        mov byte [esp+eax], bl
        mov bl, byte [byte edx+01h]
        add edx, byte 4
        mov byte [byte esp+eax+01h], bl
        add eax, byte 3
        mov bl, byte [byte edx-04h]
        inc ecx
        mov byte [byte esp+eax-01h], bl
        cmp eax, esi
        jl short .3
.4:
        mov ebx, 100h
        mov edx, IdentityRemap
        lea eax, [dword esp+0300h]
        call memcpy_
        xor ecx, ecx
.5:
        mov byte [dword ecx+IdentityRemap], cl
        inc ecx
        cmp ecx, 100h
        jl short .5
        mov eax, esp
        push eax
        push edi
        push ebp
        call RemapPixelRange
        add esp, byte 0Ch
        mov esi, dword [dword esp+0400h]
        push esi
        call ArtBankCount
        add esp, byte 4
        mov ebx, eax
.6:
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je short .7
        push ebx
        push esi
        call ArtBankEntry
        mov edx, dword [eax]
        mov edi, dword [ArtRemapTable]
        and edx, 0FFh
        add esp, byte 8
        cmp edx, edi
        jne short .6
        call CountArtPixels
        jmp short .6
.7:
        mov ebx, 100h
        lea edx, [dword esp+0300h]
        mov eax, IdentityRemap
        call memcpy_
        add esp, 404h
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; NewColorHistogram                               3D764  97 PC, low confidence
; Allocates and clears a colour histogram ("HIST")
;-----------------------------------------------------------------------------
NewColorHistogram:
        push ecx
        push esi
        push edi
        sub esp, byte 4
        mov esi, eax
        mov edi, edx
        mov dword [esp], ebx
        push byte 20h
        push dword 0C1Ch
        push str_HIST
        call AllocMemBlock
        mov ebx, eax
        add esp, byte 0Ch
        mov ecx, eax
        lea edx, [byte eax+08h]
        mov dword [dword eax+0C14h], edi
        mov eax, dword [esp]
        mov dword [dword ebx+0C18h], eax
        xor eax, eax
        test edi, edi
        jle short .2
.1:
        add ebx, byte 4
        inc eax
        mov dword [dword ebx+0804h], 0
        cmp eax, edi
        jge short .2
        jmp short .1
.2:
        add edi, dword [esp]
        lea ebx, [nosplit eax*4+00h]
        add ebx, ecx
.3:
        cmp eax, edi
        jge short .5
        add ebx, byte 4
        inc eax
        mov dword [dword ebx+0804h], 1
        jmp short .3
.4:
        add ebx, byte 4
        inc eax
        mov dword [dword ebx+0804h], 0
        jmp short .6
.5:
        lea ebx, [nosplit eax*4+00h]
        add ebx, ecx
.6:
        cmp eax, 100h
        jl short .4
        mov eax, ecx
        lea edi, [dword ecx+03FCh]
.7:
        mov dword [dword eax+0408h], 0
        mov bl, byte [esi]
        mov byte [byte edx+02h], bl
        mov bl, byte [byte esi+01h]
        add esi, byte 3
        mov byte [byte edx+01h], bl
        add edx, byte 4
        mov bl, byte [byte esi-01h]
        mov byte [byte edx-01h], 0
        add eax, byte 4
        mov byte [byte edx-04h], bl
        cmp eax, edi
        jne short .7
        lea eax, [dword ecx+03FCh]
        mov dword [dword eax+0408h], 0
        mov byte [byte edx+02h], 0
        mov byte [byte edx+01h], 0
        mov byte [edx], 0
        mov byte [byte edx+03h], 0FFh
        mov eax, ecx
        mov dword [dword ecx+0C0Ch], 0
        add esp, byte 4
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
        push ebx
        push ecx
        push esi
        mov ecx, eax
        mov eax, edx
        mov ebx, dword [byte eax+02h]
        mov eax, dword [byte eax+04h]
        sar ebx, 10h
        sar eax, 10h
        add edx, byte 10h
        imul eax, ebx
.8:
        dec eax
        cmp eax, byte 0FFFFFFFFh
        je short .9
        xor ebx, ebx
        mov bl, byte [edx]
        mov esi, dword [dword ecx+ebx*4+0408h]
        inc esi
        inc edx
        mov dword [dword ecx+ebx*4+0408h], esi
        jmp short .8
.9:
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ArtBankHistogram                                3D898  97 PC, low confidence
; Builds the colour histogram of an art bank
;-----------------------------------------------------------------------------
ArtBankHistogram:
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov edi, eax
        mov esi, edx
        mov ebp, ebx
        mov ebx, ecx
        push eax
        call ArtBankCount
        mov ecx, eax
        add esp, byte 4
        mov edx, ebp
        mov dword [esp], eax
        mov eax, esi
        call NewColorHistogram
        mov dword [byte esp+04h], eax
        xor esi, esi
        mov dword [dword eax+0C08h], edi
        test ecx, ecx
        jle short .4
.1:
        push esi
        push edi
        call ArtBankEntry
        mov edx, eax
        mov eax, dword [eax]
        mov ebx, dword [ArtRemapTable]
        and eax, 0FFh
        add esp, byte 8
        cmp eax, ebx
        jne short .3
        lea eax, [byte edx+010h]
        mov ebx, dword [byte edx+02h]
        mov edx, dword [byte edx+04h]
        sar ebx, 10h
        sar edx, 10h
        mov ecx, dword [byte esp+04h]
        imul edx, ebx
.2:
        dec edx
        cmp edx, byte 0FFFFFFFFh
        je short .3
        xor ebx, ebx
        mov bl, byte [eax]
        mov ebp, dword [dword ecx+ebx*4+0408h]
        inc ebp
        inc eax
        mov dword [dword ecx+ebx*4+0408h], ebp
        jmp short .2
.3:
        mov edx, dword [esp]
        inc esi
        cmp esi, edx
        jl short .1
.4:
        mov eax, dword [byte esp+04h]
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret
        db 090h
;-----------------------------------------------------------------------------
; InitPaletteManager                              3D930  97 PC, low confidence
; Sets up the palette ranges and installs the palette fade timer
;-----------------------------------------------------------------------------
InitPaletteManager:
        push ecx
        push edx
        xor edx, edx
        push byte 8
        mov dword [PaletteRangeCount], edx
        call BytesPerPixelForDepth
        add esp, byte 4
        push PaletteFadeTick
        mov dword [ArtRemapTable], eax
        call addtimer
        add esp, byte 4
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ShutdownPaletteManager                          3D95C  97 PC, low confidence
; Removes the palette fade timer
;-----------------------------------------------------------------------------
ShutdownPaletteManager:
        push ecx
        push edx
        push PaletteFadeTick
        call RemoveTimerCallback
        add esp, byte 4
        pop edx
        pop ecx
        ret
        db 08Bh,0C0h
        add edx, eax
        cmp edx, ebx
        jg short .1
        xor eax, eax
        ret
.1:
        add ebx, ecx
        cmp ebx, eax
        jg short .2
        xor eax, eax
        ret
.2:
        mov eax, 1
        ret
;-----------------------------------------------------------------------------
; AddPaletteRange                                 3D988  97 PC, low confidence
; Adds a named palette range of the given first and last colour
;-----------------------------------------------------------------------------
AddPaletteRange:
        push ecx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov edi, edx
        mov ecx, dword [PaletteRangeCount]
        mov eax, ecx
        shl eax, 5
        add eax, ecx
        sub ebx, edx
        shl eax, 2
        lea ebp, [byte ebx+01h]
        sub eax, ecx
        mov ecx, PaletteRanges
        shl eax, 3
        mov edx, esi
        add ecx, eax
        mov ebx, 8
        mov eax, ecx
        call strncpy_
        mov dword [dword ecx+0414h], 0
        mov dword [byte ecx+08h], edi
        mov dword [byte ecx+0Ch], ebp
        mov eax, dword [PaletteRangeCount]
        lea ebx, [byte eax+01h]
        mov dword [PaletteRangeCount], ebx
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LinkRangeHistogram                              3D9E4  97 PC, low confidence
; Attaches a colour histogram to a palette range
;-----------------------------------------------------------------------------
LinkRangeHistogram:
        push ebx
        mov ebx, edx
        mov edx, eax
        shl eax, 5
        add eax, edx
        shl eax, 2
        sub eax, edx
        shl eax, 3
        add eax, PaletteRanges
        mov dword [byte eax+010h], 1
        mov edx, dword [dword eax+0414h]
        mov dword [dword ebx+0C0Ch], edx
        mov dword [dword eax+0414h], ebx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AddArtToRange                                   3DA18  97 PC, low confidence
; Adds an art bank's colours to a palette range
;-----------------------------------------------------------------------------
AddArtToRange:
        push esi
        push edi
        mov esi, eax
        mov edi, edx
        mov eax, ebx
        mov edx, ecx
        mov ebx, dword [byte esp+0Ch]
        mov ecx, dword [byte esp+010h]
        call ArtBankHistogram
        mov ebx, 8
        mov edx, esi
        mov ecx, eax
        call strncpy_
        mov eax, dword [byte esp+014h]
        mov edx, edi
        mov dword [dword ecx+0C10h], eax
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 2
        sub eax, edx
        shl eax, 3
        add eax, PaletteRanges
        mov dword [byte eax+010h], 1
        mov edx, dword [dword eax+0414h]
        mov dword [dword ecx+0C0Ch], edx
        mov dword [dword eax+0414h], ecx
        call ServiceIdle
        pop edi
        pop esi
        ret 0Ch
;-----------------------------------------------------------------------------
; AddBankToRange                                  3DA80  97 PC, low confidence
; Adds a whole art bank's colours to a palette range
;-----------------------------------------------------------------------------
AddBankToRange:
        push esi
        push edi
        mov edi, eax
        mov esi, edx
        mov eax, ebx
        mov edx, ecx
        mov ecx, 100h
        xor ebx, ebx
        call ArtBankHistogram
        mov ebx, 8
        mov edx, edi
        mov ecx, eax
        call strncpy_
        mov eax, dword [byte esp+0Ch]
        mov edx, ecx
        mov dword [dword ecx+0C10h], eax
        mov eax, esi
        call LinkRangeHistogram
        call ServiceIdle
        pop edi
        pop esi
        ret 4
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RemapArtBank                                    3DAC4  97 PC, low confidence
; After the palette is built: remaps each art of a bank to its palette range
;-----------------------------------------------------------------------------
RemapArtBank:
        push esi
        push edi
        push ebp
        sub esp, 30Ch
        mov dword [dword esp+0304h], eax
        mov dword [dword esp+0308h], edx
        mov ebp, ebx
        mov dword [dword esp+0300h], ecx
        push ebx
        call ArtBankCount
        add esp, byte 4
        mov ebx, eax
.1:
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je near .9
        push ebx
        push ebp
        call ArtBankEntry
        mov edi, eax
        mov eax, dword [eax]
        and eax, 0FFh
        add esp, byte 8
        cmp eax, byte 24h
        je short .2
        cmp eax, byte 22h
        jne short .1
.2:
        lea eax, [byte edi+010h]
        xor edx, edx
        xor ebx, ebx
        xor cl, cl
        jmp short .4
.3:
        add ebx, byte 3
        mov byte [byte esp+ebx-02h], cl
        mov byte [byte esp+ebx-01h], cl
        inc edx
        mov byte [byte esp+ebx-03h], cl
.4:
        mov esi, dword [byte edi+08h]
        sar esi, 10h
        cmp edx, esi
        jl short .3
        lea ebx, [nosplit edx*4+00h]
        xor esi, esi
        sub ebx, edx
        mov ecx, dword [byte edi+06h]
        sar ecx, 10h
        cmp esi, ecx
        jge short .7
.5:
        mov cl, byte [eax]
        inc eax
        inc esi
        mov byte [esp+ebx], cl
        add ebx, byte 3
        mov cl, byte [eax]
        inc eax
        mov byte [byte esp+ebx-02h], cl
        inc edx
        mov cl, byte [eax]
        inc eax
        mov byte [byte esp+ebx-01h], cl
        mov ecx, dword [byte edi+06h]
        sar ecx, 10h
        cmp esi, ecx
        jge short .7
        jmp short .5
.6:
        add eax, byte 3
        mov byte [byte esp+eax-02h], bl
        mov byte [byte esp+eax-01h], bl
        inc edx
        mov byte [byte esp+eax-03h], bl
        jmp short .8
.7:
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        xor bl, bl
.8:
        cmp eax, 300h
        jl short .6
        mov esi, dword [dword esp+0300h]
        push esi
        push dword 100h
        lea ecx, [byte esp+08h]
        mov edx, dword [dword esp+0310h]
        push byte 0
        mov eax, dword [dword esp+0310h]
        mov ebx, ebp
        call AddArtToRange
.9:
        add esp, 30Ch
        pop ebp
        pop edi
        pop esi
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetRangeColors                                  3DBCC  97 PC, low confidence
; Copies a colour list into a palette range
;-----------------------------------------------------------------------------
SetRangeColors:
        push ebx
        push ecx
        push esi
        push edi
        mov ebx, eax
        shl eax, 5
        add eax, ebx
        shl eax, 2
        sub eax, ebx
        mov esi, PaletteRanges
        shl eax, 3
        add esi, eax
        mov ecx, dword [byte esi+08h]
        lea eax, [nosplit ecx*4+00h]
        add eax, esi
        jmp short .2
.1:
        mov edi, edx
        inc edx
        mov bl, byte [edi]
        mov edi, edx
        mov byte [byte eax+016h], bl
        mov bl, byte [edi]
        inc edx
        mov byte [byte eax+015h], bl
        mov ebx, edx
        add eax, byte 4
        inc ecx
        mov bl, byte [ebx]
        mov byte [byte eax+013h], 0
        inc edx
        mov byte [byte eax+010h], bl
.2:
        mov edi, dword [byte esi+0Ch]
        mov ebx, dword [byte esi+08h]
        add ebx, edi
        cmp ecx, ebx
        jl short .1
        mov dword [byte esi+010h], 0
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AddColorTable                                   3DC2C  97 PC, low confidence
; Adds a colour table (no art) to a palette range
;-----------------------------------------------------------------------------
AddColorTable:
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov edi, eax
        mov dword [esp], edx
        mov esi, ebx
        mov eax, ecx
        xor edx, edx
        call NewColorHistogram
        mov ebx, 8
        mov ecx, eax
        mov ebp, eax
        mov dword [dword eax+0C08h], 0
        mov eax, dword [byte esp+014h]
        mov edx, edi
        mov dword [dword ecx+0C10h], eax
        mov eax, ecx
        call strncpy_
        xor edx, edx
        test esi, esi
        jle short .2
        mov eax, ecx
.1:
        add eax, byte 4
        inc edx
        mov dword [dword eax+0404h], 1
        cmp edx, esi
        jl short .1
.2:
        mov edx, dword [esp]
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 2
        sub eax, edx
        shl eax, 3
        add eax, PaletteRanges
        mov dword [byte eax+010h], 1
        mov edx, dword [dword eax+0414h]
        mov dword [dword ebp+0C0Ch], edx
        mov dword [dword eax+0414h], ebp
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        ret 4
        db 090h
;-----------------------------------------------------------------------------
; RemapBankToRange                                3DCBC  97 PC, low confidence
; Remaps the arts of a bank into a palette range
;-----------------------------------------------------------------------------
RemapBankToRange:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 304h
        mov esi, edx
        mov dword [dword esp+0300h], ebx
        push edx
        mov ebp, 0FFh
        call ArtBankCount
        add esp, byte 4
        mov ebx, eax
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je near .11
        xor ebx, ebx
        jmp near .10
.1:
        push ebx
        push esi
        call ArtBankEntry
        mov edx, eax
        mov eax, dword [eax]
        and eax, ebp
        add esp, byte 8
        cmp eax, byte 24h
        je short .2
        cmp eax, byte 22h
        jne near .9
.2:
        lea eax, [byte edx+010h]
        xor ebx, ebx
        xor edi, edi
        xor cl, cl
        jmp short .4
.3:
        add edi, byte 3
        mov byte [byte esp+edi-02h], cl
        mov byte [byte esp+edi-01h], cl
        inc ebx
        mov byte [byte esp+edi-03h], cl
.4:
        mov ebp, dword [byte edx+08h]
        sar ebp, 10h
        cmp ebx, ebp
        jl short .3
        lea edi, [nosplit ebx*4+00h]
        xor ebp, ebp
        sub edi, ebx
        mov ecx, dword [byte edx+06h]
        sar ecx, 10h
        cmp ebp, ecx
        jge short .7
.5:
        mov cl, byte [eax]
        inc eax
        inc ebp
        mov byte [esp+edi], cl
        add edi, byte 3
        mov cl, byte [eax]
        inc eax
        mov byte [byte esp+edi-02h], cl
        inc ebx
        mov cl, byte [eax]
        inc eax
        mov byte [byte esp+edi-01h], cl
        mov ecx, dword [byte edx+06h]
        sar ecx, 10h
        cmp ebp, ecx
        jge short .7
        jmp short .5
.6:
        add eax, byte 3
        mov byte [byte esp+eax-02h], dl
        mov byte [byte esp+eax-01h], dl
        inc ebx
        mov byte [byte esp+eax-03h], dl
        jmp short .8
.7:
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        xor dl, dl
.8:
        cmp eax, 300h
        jl short .6
        mov ebx, dword [dword esp+0300h]
        mov eax, esp
        mov edx, esi
        call RemapArtToRange
        add esp, 304h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.9:
        inc ebx
.10:
        push esi
        call ArtBankCount
        add esp, byte 4
        cmp ebx, eax
        jl near .1
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je short .11
        xor ebx, ebx
        jmp short .10
.11:
        call ServiceIdle
        add esp, 304h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; RemapRangeColors                                3DDD8  97 PC, low confidence
; Remaps an art through the colour table of a palette range
;-----------------------------------------------------------------------------
RemapRangeColors:
        push ecx
        push esi
        push edi
        mov esi, edx
        mov edi, ebx
        mov edx, eax
        shl eax, 5
        add eax, edx
        shl eax, 2
        mov ebx, PaletteRanges
        sub eax, edx
        mov edx, edi
        mov ecx, dword [byte ebx+eax*8+0Ch]
        mov ebx, dword [byte ebx+eax*8+08h]
        mov eax, esi
        call RemapArtColors
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RemapArtPixels                                  3DE08  97 PC, low confidence
; Remaps the pixels of an art into a palette range
;-----------------------------------------------------------------------------
RemapArtPixels:
        mov eax, ebx
        mov ebx, ecx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 100h
        mov edi, eax
        mov esi, edx
        test bl, 1
        sete al
        xor ecx, ecx
        mov cl, al
        mov edx, IdentityRemap
        add ecx, 0FEh
        mov eax, esp
        mov ebx, ecx
        call memcpy_
        push edi
        push ecx
        push byte 0
        mov ebp, ecx
        call RemapPixelRange
        mov eax, dword [esi]
        mov edx, dword [ArtRemapTable]
        and eax, 0FFh
        add esp, byte 0Ch
        cmp eax, edx
        jne short RemapArtPixels_70
        mov edx, dword [byte esi+02h]
        mov eax, dword [byte esi+04h]
        sar edx, 10h
        sar eax, 10h
        imul eax, edx
        push eax
        push IdentityRemap
        add esi, byte 10h
        push esi
        call TranslatePixels
        add esp, byte 0Ch
RemapArtPixels_70:
        mov edx, esp
        mov eax, IdentityRemap
        mov ebx, ebp
        call memcpy_
        add esp, 100h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FillQuantBoxes                                  3DE94  97 PC, low confidence
; Colour quantizer: sorts the histogram colours into boxes
;-----------------------------------------------------------------------------
FillQuantBoxes:
        push ebx
        push ecx
        push esi
        push edi
        sub esp, byte 4
        mov ebx, edx
        mov esi, eax
        add eax, 400h
        mov dword [esp], eax
.1:
        mov edx, dword [dword esi+0408h]
        mov ecx, dword [byte esi+08h]
        test edx, edx
        je short .5
        cmp dword [dword esi+0808h], byte 0
        je short .5
        mov eax, dword [ebx]
        xor edx, edx
        test eax, eax
        jle short .4
        mov eax, ebx
.2:
        cmp ecx, dword [byte eax+04h]
        jne short .3
        mov edi, dword [dword esi+0408h]
        add dword [dword eax+02714h], edi
        jmp short .4
.3:
        inc edx
        mov edi, dword [ebx]
        add eax, byte 4
        cmp edx, edi
        jl short .2
.4:
        mov eax, dword [ebx]
        cmp edx, eax
        jne short .5
        shl eax, 2
        mov dword [byte ebx+eax+04h], ecx
        mov edx, dword [dword esi+0408h]
        mov dword [dword ebx+eax+02714h], edx
        inc dword [ebx]
.5:
        mov ecx, dword [esp]
        add esi, byte 4
        cmp esi, ecx
        jne short .1
        add esp, byte 4
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ColorMomentTables                               3DF14  97 PC, low confidence
; Colour quantizer: builds the running sum tables of a box
;-----------------------------------------------------------------------------
ColorMomentTables:
        push ecx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov ecx, edx
        xor edi, edi
        xor eax, eax
        xor edx, edx
.1:
        mov ebp, edi
        imul ebp, eax
        mov dword [esi], ebp
        mov ebp, edx
        imul ebp, eax
        mov dword [ecx], ebp
        mov ebp, eax
        imul ebp, eax
        add ebx, byte 4
        add ecx, byte 4
        add esi, byte 4
        add edi, byte 3
        add edx, byte 2
        inc eax
        mov dword [byte ebx-04h], ebp
        cmp eax, 100h
        jl short .1
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; SplitColorBox                                   3DF54  97 PC, low confidence
; Colour quantizer: splits a colour box where the variance drops most
;-----------------------------------------------------------------------------
SplitColorBox:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 0C0Ch
        mov ebp, eax
        mov dword [dword esp+0C04h], edx
        mov eax, edx
        lea ebx, [dword esp+0800h]
        mov eax, dword [byte ebp+eax*4+04h]
        mov edx, esp
        mov dword [dword esp+0C08h], eax
        lea eax, [dword esp+0400h]
        call ColorMomentTables
        mov eax, ebp
        mov ecx, 0F423Fh
        mov edx, dword [eax]
        xor ebx, ebx
        test edx, edx
        jle near .6
        mov edx, ebp
.1:
        cmp ebx, dword [dword esp+0C04h]
        je short .5
        xor eax, eax
        movzx esi, byte [byte edx+06h]
        mov al, byte [dword esp+0C0Ah]
        sub eax, esi
        test eax, eax
        jge short .2
        neg eax
.2:
        mov eax, dword [dword esp+eax*4+0400h]
        cmp eax, ecx
        jge short .5
        movzx edi, byte [dword esp+0C09h]
        movzx esi, byte [byte edx+05h]
        sub edi, esi
        mov esi, edi
        test edi, edi
        jge short .3
        neg esi
.3:
        add eax, dword [esp+esi*4]
        cmp eax, ecx
        jge short .5
        movzx esi, byte [dword esp+0C09h]
        movzx edi, byte [byte edx+05h]
        sub esi, edi
        test esi, esi
        jge short .4
        neg esi
.4:
        add eax, dword [dword esp+esi*4+0800h]
        cmp eax, ecx
        jge short .5
        mov dword [dword esp+0C00h], ebx
        mov ecx, eax
.5:
        inc ebx
        mov esi, dword [byte ebp+00h]
        add edx, byte 4
        cmp ebx, esi
        jl short .1
.6:
        mov eax, dword [dword esp+0C04h]
        mov edx, dword [dword esp+0C00h]
        mov dword [dword ebp+eax*4+07534h], edx
        mov dword [dword ebp+eax*4+04E24h], ecx
        add esp, 0C0Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov edx, dword [eax]
        xor ebx, ebx
        test edx, edx
        jle short .8
.7:
        call ServiceIdle
        mov edx, ebx
        mov eax, ecx
        call SplitColorBox
        inc ebx
        cmp ebx, dword [ecx]
        jl short .7
.8:
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; MergeColorBoxes                                 3E064  97 PC, low confidence
; Colour quantizer: joins two colour boxes
;-----------------------------------------------------------------------------
MergeColorBoxes:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov edi, edx
        lea ebx, [nosplit edx*4+00h]
        mov ecx, dword [dword esi+ebx+07534h]
        mov eax, dword [dword esi+ebx+02714h]
        add dword [dword esi+ecx*4+02714h], eax
        mov eax, dword [esi]
        sub eax, edi
        shl eax, 2
        lea ecx, [byte esi+04h]
        push eax
        add ecx, ebx
        push ecx
        add ecx, byte 4
        push ecx
        call bcopy
        mov eax, dword [esi]
        sub eax, edi
        add esp, byte 0Ch
        shl eax, 2
        lea ecx, [dword esi+04E24h]
        push eax
        add ecx, ebx
        push ecx
        add ecx, byte 4
        push ecx
        call bcopy
        mov eax, dword [esi]
        sub eax, edi
        add esp, byte 0Ch
        shl eax, 2
        lea ecx, [dword esi+07534h]
        push eax
        add ecx, ebx
        push ecx
        add ecx, byte 4
        push ecx
        call bcopy
        mov eax, dword [esi]
        sub eax, edi
        add esp, byte 0Ch
        shl eax, 2
        push eax
        lea eax, [dword esi+02714h]
        add ebx, eax
        push ebx
        add ebx, byte 4
        push ebx
        call bcopy
        mov ebx, dword [esi]
        dec ebx
        add esp, byte 0Ch
        mov dword [esi], ebx
        call ServiceIdle
        mov ebp, dword [esi]
        xor ecx, ecx
        test ebp, ebp
        jle short .4
        mov ebx, esi
.1:
        mov edx, dword [dword ebx+07534h]
        cmp edi, edx
        jne short .2
        mov edx, ecx
        mov eax, esi
        call SplitColorBox
        jmp short .3
.2:
        jge short .3
        lea eax, [byte edx-01h]
        mov dword [dword ebx+07534h], eax
.3:
        inc ecx
        mov eax, dword [esi]
        add ebx, byte 4
        cmp ecx, eax
        jl short .1
.4:
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FindSmallestBox                                 3E140  97 PC, low confidence
; Colour quantizer: returns the box with the smallest error
;-----------------------------------------------------------------------------
FindSmallestBox:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ecx, eax
        mov ebx, 0F423Fh
        mov edx, dword [ecx]
        xor eax, eax
        test edx, edx
        jle short .3
        mov edx, ecx
.1:
        mov ebp, dword [dword edx+04E24h]
        cmp ebx, ebp
        jle short .2
        mov esi, eax
        mov ebx, ebp
.2:
        inc eax
        mov edi, dword [ecx]
        add edx, byte 4
        cmp eax, edi
        jl short .1
.3:
        mov edx, esi
        mov eax, ecx
        call MergeColorBoxes
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
        push ebx
        push ecx
        mov ecx, dword [eax]
        mov ebx, eax
        cmp edx, ecx
        jge short .5
.4:
        mov eax, ebx
        call FindSmallestBox
        cmp edx, dword [ebx]
        jl short .4
.5:
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CopyRangePalette                                3E198  97 PC, low confidence
; Copies a palette range's colours into a palette buffer
;-----------------------------------------------------------------------------
CopyRangePalette:
        push ebx
        push ecx
        push esi
        push edi
        mov ebx, edx
        mov edx, eax
        shl eax, 5
        add eax, edx
        shl eax, 2
        sub eax, edx
        mov esi, PaletteRanges
        shl eax, 3
        add esi, eax
        mov ecx, dword [byte esi+08h]
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        lea edx, [eax+ebx]
        lea eax, [nosplit ecx*4+00h]
        add eax, esi
        jmp short .2
.1:
        mov bl, byte [byte eax+016h]
        mov byte [edx], bl
        mov bl, byte [byte eax+015h]
        add eax, byte 4
        mov byte [byte edx+01h], bl
        add edx, byte 3
        mov bl, byte [byte eax+010h]
        inc ecx
        mov byte [byte edx-01h], bl
.2:
        mov edi, dword [byte esi+0Ch]
        mov ebx, dword [byte esi+08h]
        add ebx, edi
        cmp ecx, ebx
        jl short .1
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; BuildRangePaletteBuf                            3E1F8  97 PC, low confidence
; Clears a palette buffer and copies a range's colours into it
;-----------------------------------------------------------------------------
BuildRangePaletteBuf:
        push ebx
        push esi
        mov esi, eax
        mov ebx, edx
        mov eax, edx
        add edx, 300h
.1:
        mov byte [eax], 0
        inc eax
        cmp eax, edx
        jne short .1
        mov edx, ebx
        mov eax, esi
        call CopyRangePalette
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; QuantizeRange                                   3E21C  97 PC, low confidence
; Builds the colours of a palette range from its histograms ("MEGAHIST")
;-----------------------------------------------------------------------------
QuantizeRange:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov edx, eax
        shl eax, 5
        add eax, edx
        shl eax, 2
        sub eax, edx
        mov esi, PaletteRanges
        shl eax, 3
        add esi, eax
        mov ebx, dword [dword esi+0414h]
        call ServiceIdle
        cmp dword [byte esi+010h], byte 0
        je near .24
        push byte 20h
        push dword 9C44h
        push str_MEGAHIST
        call AllocMemBlock
        add esp, byte 0Ch
        mov edi, eax
        mov dword [eax], 0
        test ebx, ebx
        je short .2
.1:
        mov edx, edi
        mov eax, ebx
        call FillQuantBoxes
        mov ebx, dword [dword ebx+0C0Ch]
        test ebx, ebx
        jne short .1
.2:
        mov ebx, dword [byte esi+08h]
        cmp ebx, byte 7Fh
        jg short .3
        mov ecx, dword [byte esi+0Ch]
        lea eax, [ebx+ecx]
        cmp eax, byte 7Fh
        jl short .3
        lea eax, [byte ecx-01h]
        jmp short .4
.3:
        mov eax, dword [byte esi+0Ch]
.4:
        mov ebp, dword [edi]
        cmp eax, ebp
        jge near .23
        mov ecx, edi
        xor ebx, ebx
        test ebp, ebp
        jle short .6
.5:
        call ServiceIdle
        mov edx, ebx
        mov eax, ecx
        call SplitColorBox
        inc ebx
        cmp ebx, dword [ecx]
        jl short .5
.6:
        mov ebx, edi
        mov eax, dword [byte esi+0Ch]
        mov ecx, dword [edi]
        mov edx, eax
        cmp eax, ecx
        jge short .8
.7:
        mov eax, ebx
        call FindSmallestBox
        cmp edx, dword [ebx]
        jl short .7
.8:
        mov edx, dword [byte esi+08h]
        xor eax, eax
        test edx, edx
        jle short .10
.9:
        xor dl, dl
        mov byte [dword eax+QuantizeTable], dl
        inc eax
        cmp eax, dword [byte esi+08h]
        jl short .9
.10:
        mov ecx, dword [byte esi+0Ch]
        xor eax, eax
        test ecx, ecx
        jle short .13
        mov ebx, edi
.11:
        mov ecx, dword [byte esi+08h]
        add ecx, eax
        cmp ecx, byte 7Fh
        jne short .12
        xor dl, dl
        inc eax
        mov byte [dword ecx+QuantizeTable], dl
.12:
        mov edx, dword [byte esi+08h]
        mov byte [dword edx+eax+QuantizeTable], 1
        mov edx, dword [byte esi+08h]
        add edx, eax
        shl edx, 2
        lea ecx, [esi+edx]
        mov edx, dword [byte ebx+04h]
        mov dword [byte ecx+014h], edx
        inc eax
        mov ebp, dword [byte esi+0Ch]
        add ebx, byte 4
        cmp eax, ebp
        jl short .11
.13:
        mov edx, dword [byte esi+0Ch]
        mov eax, dword [byte esi+08h]
        add eax, edx
        cmp eax, 100h
        jge short .15
.14:
        inc eax
        xor dh, dh
        mov byte [dword eax+QuantizeByte], dh
        cmp eax, 100h
        jl short .14
.15:
        mov ebx, dword [byte esi+08h]
        test ebx, ebx
        jne short .19
        mov ecx, dword [byte esi+0Ch]
        mov edx, 270Fh
        test ecx, ecx
        jle short .18
        mov eax, esi
.16:
        xor ecx, ecx
        mov cl, byte [byte eax+016h]
        mov dword [esp], ecx
        xor ecx, ecx
        mov ebp, dword [esp]
        mov cl, byte [byte eax+015h]
        add ebp, ecx
        xor ecx, ecx
        mov cl, byte [byte eax+014h]
        add ecx, ebp
        cmp ebx, byte 7Fh
        je short .17
        cmp ecx, edx
        jge short .17
        mov dword [byte esp+04h], ebx
        mov edx, ecx
.17:
        inc ebx
        mov ebp, dword [byte esi+0Ch]
        add eax, byte 4
        cmp ebx, ebp
        jl short .16
.18:
        mov eax, dword [byte esp+04h]
        shl eax, 2
        lea edx, [esi+eax]
        mov eax, dword [byte esi+014h]
        mov dword [byte edx+014h], eax
        mov byte [byte esi+016h], 0
        mov byte [byte esi+015h], 0
        mov byte [byte esi+014h], 0
.19:
        mov eax, dword [QuantizePalette]
        test eax, eax
        je short .20
        push eax
        call FreeMemBlock
        add esp, byte 4
.20:
        lea eax, [byte esi+014h]
        push eax
        call BuildInverseTable
        add esp, byte 4
        mov dword [QuantizePalette], eax
        call ServiceIdle
        mov esi, dword [dword esi+0414h]
        test esi, esi
        je short .23
.21:
        cmp dword [dword esi+0C08h], byte 0
        je short .22
        lea eax, [byte esi+08h]
        mov ecx, dword [dword esi+0C10h]
        mov ebx, dword [dword esi+0C14h]
        push ecx
        mov edx, dword [dword esi+0C08h]
        mov ecx, dword [dword esi+0C18h]
        call RemapArtRange
.22:
        call ServiceIdle
        push esi
        mov ebx, dword [dword esi+0C0Ch]
        call FreeMemBlock
        add esp, byte 4
        mov esi, ebx
        test ebx, ebx
        jne short .21
.23:
        push edi
        call FreeMemBlock
        mov ecx, 100h
        add esp, byte 4
        mov edx, 1010101h
        mov eax, QuantizeTable
        call __STOSB
.24:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; QuantizeAllRanges                               3E458  97 PC, low confidence
; Builds the colours of every palette range
;-----------------------------------------------------------------------------
QuantizeAllRanges:
        push ebx
        push ecx
        push edx
        mov ebx, dword [PaletteRangeCount]
        xor edx, edx
        test ebx, ebx
        jle short .2
.1:
        mov eax, edx
        call QuantizeRange
        mov ecx, dword [PaletteRangeCount]
        inc edx
        cmp edx, ecx
        jl short .1
.2:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetRangePalette                                 3E480  97 PC, low confidence
; Loads a palette range's colours into the VGA palette
;-----------------------------------------------------------------------------
SetRangePalette:
        push ebx
        push ecx
        push edx
        mov edx, eax
        shl eax, 5
        add eax, edx
        shl eax, 2
        sub eax, edx
        shl eax, 3
        add eax, PaletteRanges
        mov ebx, dword [byte eax+08h]
        lea edx, [byte eax+014h]
        shl ebx, 2
        add edx, ebx
        push edx
        mov edx, dword [byte eax+0Ch]
        push edx
        mov ebx, dword [byte eax+08h]
        push ebx
        call WritePaletteRange
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; MergeRangePalettes                              3E4B8  97 PC, low confidence
; Joins the palette ranges into one 256-colour palette
;-----------------------------------------------------------------------------
MergeRangePalettes:
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov dword [esp], eax
        mov esi, edx
        mov edi, ebx
        mov dword [byte esp+04h], ecx
        mov ebx, PaletteRanges
        mov ebp, 1
        xor edx, edx
        mov eax, dword [PaletteRangeCount]
        mov dword [byte esp+08h], edx
        mov dword [byte esp+010h], edx
        test eax, eax
        jle near .5
        lea eax, [byte ebx+014h]
        mov dword [byte esp+0Ch], eax
.1:
        test dword [esp], ebp
        je short .4
        mov eax, dword [byte ebx+0Ch]
        shl eax, 2
        push eax
        mov eax, dword [byte ebx+08h]
        mov edx, dword [byte esp+08h]
        shl eax, 2
        add edx, eax
        push edx
        add eax, dword [byte esp+014h]
        push eax
        call bcopy
        add esp, byte 0Ch
        cmp dword [byte esp+08h], byte 0
        jne short .2
        mov dword [byte esp+08h], 1
        mov eax, dword [byte ebx+08h]
        mov dword [esi], eax
        mov eax, dword [byte ebx+0Ch]
        mov dword [edi], eax
        jmp short .4
.2:
        mov edx, dword [esi]
        mov eax, dword [byte ebx+08h]
        cmp eax, edx
        jge short .3
        mov dword [esi], eax
.3:
        mov ecx, dword [byte ebx+0Ch]
        mov edx, dword [byte ebx+08h]
        mov eax, dword [esi]
        add edx, ecx
        add eax, dword [edi]
        cmp eax, edx
        jge short .4
        mov eax, dword [esi]
        sub edx, eax
        mov dword [edi], edx
.4:
        mov edx, dword [byte esp+010h]
        mov ecx, dword [byte esp+0Ch]
        add ebx, 418h
        add ebp, ebp
        inc edx
        add ecx, 418h
        mov dword [byte esp+010h], edx
        mov eax, edx
        mov edx, dword [PaletteRangeCount]
        mov dword [byte esp+0Ch], ecx
        cmp eax, edx
        jl near .1
.5:
        mov eax, dword [byte esp+08h]
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; BuildGamePalette                                3E590  97 PC, low confidence
; Builds the game palette from all ranges and loads it
;-----------------------------------------------------------------------------
BuildGamePalette:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, 408h
        mov esi, eax
        mov ecx, 100h
        mov eax, esp
        xor edx, edx
        lea ebx, [dword esp+0400h]
        call __STOSD
        mov ecx, esp
        lea edx, [dword esp+0404h]
        mov eax, esi
        call MergeRangePalettes
        mov edx, dword [QuantizePalette]
        test edx, edx
        je short .1
        push edx
        call FreeMemBlock
        add esp, byte 4
.1:
        mov eax, esp
        push eax
        call BuildInverseTable
        add esp, byte 4
        mov dword [QuantizePalette], eax
        add esp, 408h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FadeGamePalette                                 3E5F0  97 PC, low confidence
; Fades the screen to the game palette (camera scenes, replays, pause menu)
;-----------------------------------------------------------------------------
FadeGamePalette:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 408h
        mov esi, edx
        mov edi, ebx
        mov ecx, esp
        xor edx, edx
        lea ebx, [dword esp+0400h]
        mov dword [FadeActive], edx
        lea edx, [dword esp+0404h]
        call MergeRangePalettes
        test eax, eax
        je near .3
        mov ebx, dword [dword esp+0400h]
        xor ecx, ecx
        test ebx, ebx
        jle short .2
        xor ebx, ebx
.1:
        xor eax, eax
        mov edx, esi
        mov al, byte [byte esp+ebx+02h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov byte [byte esp+ebx+02h], al
        xor eax, eax
        mov edx, esi
        mov al, byte [byte esp+ebx+01h]
        add ebx, byte 4
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov byte [byte esp+ebx-03h], al
        xor eax, eax
        mov edx, esi
        mov al, byte [byte esp+ebx-04h]
        inc ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov ebp, dword [dword esp+0400h]
        mov byte [byte esp+ebx-04h], al
        cmp ecx, ebp
        jl short .1
.2:
        mov ebx, 5
        mov edx, edi
        mov eax, edi
        sar edx, 1Fh
        idiv ebx
        mov ebx, esp
        mov edx, dword [dword esp+0400h]
        mov ecx, eax
        mov eax, dword [dword esp+0404h]
        call StartPaletteFade
.3:
        mov dword [RangeBlendLevel], esi
        add esp, 408h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 00h,00h,00h,00h,00h,00h,00h
        xor eax, eax
        ret
        db 090h
        mov eax, dword [byte esp+04h]
        mov dword [StreamBlockCount], eax
        ret
