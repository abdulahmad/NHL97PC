; Rink palette: ice palette and colour range blends.
bits 32
%include "hockey.inc"
section s_52A42 progbits alloc exec nowrite align=1
extern ArenaArchive, ArenaArt, ArenaPalette, ArenaPaletteRange, BenchPalette, BenchRemap, BlendRangePalette, BuildRangePalette
extern BuildRangePaletteBuf, CopyRangePalette, FadeDone, GlassRemap, MatchColor, RinkColorUsed, RinkDetail, RinkLineArt
extern RinkPalette, RinkPaletteBase, RinkPaletteData, RinkPaletteRemap, SetRemapTable, ShowStands, StandsPalette
global BuildIcePalette, BlendRangeColours, DimRangeColours, BrightenRangeColours, BuildRinkPalette, SetRinkPalette, UpdateRinkPalette
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; BuildIcePalette                                 52A44  97 PC, low confidence
; Builds the ice colour palette
;-----------------------------------------------------------------------------
BuildIcePalette:
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov dword [byte esp+08h], edx
        mov ebp, ecx
        mov dword [byte esp+0Ch], eax
        add eax, 2D0h
        mov dword [byte esp+04h], eax
.1:
        mov edi, dword [byte esp+0Ch]
        mov esi, dword [byte esp+0Ch]
        mov eax, dword [byte esp+0Ch]
        xor ecx, ecx
        movzx edi, byte [edi]
        movzx esi, byte [byte esi+01h]
        mov cl, byte [byte eax+02h]
        lea edx, [edi+esi]
        add edx, ecx
        mov dword [byte esp+010h], 3
        mov eax, edx
        sar edx, 1Fh
        idiv dword [byte esp+010h]
        mov edx, dword [byte esp+024h]
        mov dword [esp], eax
        sub eax, edi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        add edi, eax
        mov eax, dword [esp]
        mov edx, dword [byte esp+024h]
        sub eax, esi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        add esi, eax
        mov eax, dword [esp]
        mov edx, dword [byte esp+024h]
        sub eax, ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        add ecx, eax
        mov eax, 80h
        mov edx, ebp
        sub eax, edi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        add edi, eax
        mov eax, 80h
        mov edx, ebp
        sub eax, esi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        add esi, eax
        mov eax, 80h
        mov edx, ebp
        sub eax, ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, ebx
        add ecx, eax
        mov eax, edi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        cmp eax, 0FFh
        jle short .2
        mov eax, 0FFh
        jmp short .3
.2:
        mov edx, ebx
        mov eax, edi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
.3:
        mov edi, eax
        mov edx, ebx
        mov eax, esi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        cmp eax, 0FFh
        jle short .4
        mov eax, 0FFh
        jmp short .5
.4:
        mov edx, ebx
        mov eax, esi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
.5:
        mov esi, eax
        mov edx, ebx
        mov eax, ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        cmp eax, 0FFh
        jle short .6
        mov eax, 0FFh
        jmp short .7
.6:
        mov edx, ebx
        mov eax, ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
.7:
        mov ecx, edi
        mov edx, esi
        shl ecx, 10h
        shl edx, 8
        or edx, ecx
        or eax, edx
        push eax
        call MatchColor
        add esp, byte 4
        mov edx, dword [byte esp+08h]
        mov ecx, dword [byte esp+0Ch]
        inc edx
        mov esi, dword [byte esp+04h]
        add ecx, byte 3
        mov byte [byte edx-01h], al
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ecx
        cmp ecx, esi
        jne near .1
        mov edx, 0F0h
.8:
        mov eax, dword [byte esp+08h]
        lea edi, [byte eax+01h]
        mov byte [eax], dl
        inc edx
        mov dword [byte esp+08h], edi
        cmp edx, 100h
        jl short .8
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; BlendRangeColours                               52BEC  97 PC, low confidence
; Blends the colours of a palette range
;-----------------------------------------------------------------------------
BlendRangeColours:
        push ebx
        push ecx
        push esi
        push edi
        mov ebx, eax
        mov ecx, edx
        xor eax, eax
        mov al, byte [edx]
        mov edx, ebx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        cmp eax, 0FFh
        jle short .1
        mov eax, 0FFh
        jmp short .2
.1:
        xor eax, eax
        mov edx, ebx
        mov al, byte [ecx]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
.2:
        mov edi, eax
        xor eax, eax
        mov edx, ebx
        mov al, byte [byte ecx+01h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        cmp eax, 0FFh
        jle short .3
        mov eax, 0FFh
        jmp short .4
.3:
        xor eax, eax
        mov edx, ebx
        mov al, byte [byte ecx+01h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
.4:
        mov esi, eax
        xor eax, eax
        mov edx, ebx
        mov al, byte [byte ecx+02h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        cmp eax, 0FFh
        jle short .5
        mov eax, 0FFh
        jmp short .6
.5:
        xor eax, eax
        mov edx, ebx
        mov al, byte [byte ecx+02h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
.6:
        shl edi, 10h
        shl esi, 8
        add esi, edi
        add eax, esi
        push eax
        call MatchColor
        add esp, byte 4
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DimRangeColours                                 52CA0  97 PC, low confidence
; Dims a palette range
;-----------------------------------------------------------------------------
DimRangeColours:
        push ecx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov ecx, edx
        mov ebp, ebx
        lea edi, [dword ebx+0F0h]
.1:
        mov edx, ecx
        mov eax, esi
        inc ebx
        call BlendRangeColours
        add ecx, byte 3
        mov byte [byte ebx-01h], al
        cmp ebx, edi
        jne short .1
        mov ecx, 0F0h
        lea ebx, [ecx+ebp]
.2:
        mov byte [ebx], cl
        inc ecx
        inc ebx
        cmp ecx, 100h
        jl short .2
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; BrightenRangeColours                            52CE0  97 PC, low confidence
; Brightens a palette range
;-----------------------------------------------------------------------------
BrightenRangeColours:
        push ecx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov ecx, edx
        mov ebp, ebx
        mov edi, ebp
        xor ebx, ebx
.1:
        cmp byte [dword ebx+RinkColorUsed], 0
        je short .2
        mov edx, ecx
        mov eax, esi
        call BlendRangeColours
        mov byte [edi], al
        jmp short .3
.2:
        mov byte [edi], bl
.3:
        inc ebx
        add ecx, byte 3
        inc edi
        cmp ebx, 0E8h
        jge short .4
        jmp short .1
.4:
        lea edi, [ebx+ebp]
.5:
        cmp ebx, 0F0h
        jge short .7
        mov edx, ecx
        mov eax, esi
        call BlendRangeColours
        inc edi
        inc ebx
        add ecx, byte 3
        mov byte [byte edi-01h], al
        jmp short .5
.6:
        mov byte [ecx], bl
        inc ecx
        inc ebx
        jmp short .8
.7:
        lea ecx, [ebx+ebp]
.8:
        cmp ebx, 100h
        jl short .6
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; BuildRinkPalette                                52D4C  97 PC, low confidence
; Builds the rink palette
;-----------------------------------------------------------------------------
BuildRinkPalette:
        push ebx
        push ecx
        push edx
        sub esp, 300h
        mov edx, esp
        mov eax, dword [ArenaArchive]
        call BuildRangePaletteBuf
        mov edx, esp
        mov eax, dword [ArenaArt]
        mov ecx, 8000h
        call CopyRangePalette
        mov edx, esp
        mov eax, dword [RinkLineArt]
        mov ebx, 13333h
        call CopyRangePalette
        push dword 9999h
        mov edx, GlassRemap
        lea eax, [byte esp+04h]
        call BuildIcePalette
        push dword 9999h
        mov ecx, 1999h
        mov ebx, 19999h
        mov edx, RinkPaletteRemap
        lea eax, [byte esp+04h]
        call BuildIcePalette
        mov ebx, StandsPalette
        mov edx, esp
        mov eax, 11999h
        call DimRangeColours
        mov ebx, BenchPalette
        mov edx, esp
        mov eax, 9999h
        call DimRangeColours
        mov ebx, BenchRemap
        mov edx, esp
        mov eax, 0E666h
        call DimRangeColours
        mov ebx, RinkPaletteBase
        mov edx, esp
        mov eax, 0E666h
        call BrightenRangeColours
        mov ebx, RinkPalette
        mov edx, esp
        mov eax, dword [RinkDetail]
        call DimRangeColours
        add esp, 300h
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetRinkPalette                                  52E14  97 PC, low confidence
; Sets the rink palette
;-----------------------------------------------------------------------------
SetRinkPalette:
        push ecx
        push edx
        push RinkPaletteBase
        call SetRemapTable
        add esp, byte 4
        pop edx
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; UpdateRinkPalette                               52E28  97 PC, low confidence
; Updates the rink palette (lighting)
;-----------------------------------------------------------------------------
UpdateRinkPalette:
        push ebx
        push ecx
        push esi
        push edi
        mov edi, edx
        mov edx, dword [FadeDone]
        mov dword [RinkPaletteData], eax
        test edx, edx
        jne short .3
        cmp dword [ShowStands], byte 0
        je short .1
        mov ebx, ArenaPalette
        mov edx, ArenaPaletteRange
        mov esi, dword [ArenaArt]
        mov ecx, eax
        mov eax, esi
        call BuildRangePalette
        jmp short .2
.1:
        mov ecx, ArenaPalette
        mov ebx, ArenaPaletteRange
        push eax
        mov edx, 3
        mov eax, dword [ArenaArt]
        call BlendRangePalette
.2:
        test edi, edi
        je short .3
        call BuildRinkPalette
.3:
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
