; EA library: DrawTileTexture, DrawTilePage.
bits 32
%include "hockey.inc"
section s_10F813 progbits alloc exec nowrite align=1
extern ClipLeftCol, ClipRight, ClipTexPolyBottom, ClipTexPolyLeft, ClipTexPolyRight, ClipTexPolyToNear, ClipTexPolyTop, ClipTopRow
extern DrawDestBuffer, DrawDestPitch, DrawTileEdgeLeft, DrawTileEdgeRight, ScreenHeight, SetupTileSpans, str_Punct_DrawRinkSurface, TileEdgeTable
extern TileRowCount, TileRowY, TileTexSize, TileTexture
global DrawTileTexture, DrawTilePage
        db 090h
;-----------------------------------------------------------------------------
; DrawTileTexture                                10F814  97 PC, low confidence
; Draws a texture tile
;-----------------------------------------------------------------------------
DrawTileTexture:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov edi, dword [byte esp+028h]
        mov eax, dword [str_Punct_DrawRinkSurface]
        inc eax
        push eax
        mov ecx, dword [byte esp+030h]
        push ecx
        mov esi, dword [byte esp+038h]
        push esi
        mov ebp, dword [byte esp+040h]
        push ebp
        xor edx, edx
        push edi
        mov dword [byte esp+01Ch], edx
        mov dword [byte esp+014h], edx
        call ClipTexPolyToNear
        add esp, byte 14h
        mov edi, eax
        cmp eax, byte 3
        jl near .21
        mov ebp, dword [esi]
        mov edx, dword [byte esi+04h]
        xor ebx, ebx
        mov dword [byte esp+04h], ebp
        mov dword [byte esp+0Ch], edx
        mov dword [TileRowCount], edx
        test eax, eax
        jle short .6
        mov eax, dword [byte esp+030h]
        xor esi, esi
.1:
        mov ecx, dword [TileRowCount]
        mov edx, dword [byte eax+04h]
        cmp edx, ecx
        jge short .2
        mov dword [TileRowCount], edx
        mov dword [byte esp+08h], ebx
        jmp short .3
.2:
        cmp edx, dword [byte esp+0Ch]
        jle short .3
        mov dword [byte esp+0Ch], edx
.3:
        mov ecx, dword [byte esp+04h]
        mov edx, dword [eax]
        cmp edx, ecx
        jge short .4
        mov dword [byte esp+04h], edx
        jmp short .5
.4:
        cmp ebp, edx
        jge short .5
        mov ebp, edx
.5:
        mov ecx, dword [byte esp+034h]
        mov edx, dword [eax]
        add eax, byte 8
        mov dword [ecx+esi], edx
        add esi, byte 0Ch
        mov ecx, dword [byte esp+034h]
        mov edx, dword [byte eax-04h]
        inc ebx
        mov dword [byte ecx+esi-08h], edx
        cmp ebx, edi
        jl short .1
.6:
        mov edx, dword [ScreenHeight]
        cmp edx, dword [TileRowCount]
        jle near .21
        mov eax, dword [byte esp+0Ch]
        cmp eax, dword [ClipLeftCol]
        jl near .21
        mov eax, dword [byte esp+04h]
        cmp eax, dword [ClipRight]
        jge near .21
        cmp ebp, dword [ClipTopRow]
        jl near .21
        cmp dword [byte esp+038h], byte 0
        jne short .7
        mov esi, dword [byte esp+034h]
        mov eax, dword [byte esi+018h]
        mov ebx, dword [byte esi+01Ch]
        mov ecx, dword [esi]
        mov edx, dword [byte esi+04h]
        sub eax, dword [byte esi+0Ch]
        sub ebx, dword [byte esi+010h]
        sub ecx, dword [byte esi+0Ch]
        sub edx, dword [byte esi+010h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [byte esp+038h], ebx
.7:
        mov eax, dword [byte esp+04h]
        cmp eax, dword [ClipTopRow]
        jge short .8
        lea eax, [byte esp+02Ch]
        push eax
        lea eax, [byte esp+038h]
        push eax
        push edi
        call ClipTexPolyLeft
        add esp, byte 0Ch
        mov edi, eax
        cmp eax, byte 3
        jl near .21
        mov dword [esp], 1
.8:
        cmp ebp, dword [ClipRight]
        jl short .9
        lea eax, [byte esp+02Ch]
        push eax
        lea eax, [byte esp+038h]
        push eax
        push edi
        call ClipTexPolyRight
        add esp, byte 0Ch
        mov edi, eax
        cmp eax, byte 3
        jl near .21
        mov dword [esp], 1
.9:
        mov ebp, dword [ClipLeftCol]
        cmp ebp, dword [TileRowCount]
        jle short .10
        lea eax, [byte esp+02Ch]
        push eax
        lea eax, [byte esp+038h]
        push eax
        push edi
        call ClipTexPolyTop
        add esp, byte 0Ch
        mov edi, eax
        cmp eax, byte 3
        jl near .21
        mov dword [esp], 1
.10:
        mov eax, dword [byte esp+0Ch]
        cmp eax, dword [ScreenHeight]
        jl short .11
        lea eax, [byte esp+02Ch]
        push eax
        lea eax, [byte esp+038h]
        push eax
        push edi
        call ClipTexPolyBottom
        add esp, byte 0Ch
        mov edi, eax
        cmp eax, byte 3
        jl near .21
        mov dword [esp], 1
.11:
        cmp dword [esp], byte 0
        je short .15
        mov eax, dword [byte esp+034h]
        mov ebp, dword [byte esp+034h]
        xor esi, esi
        mov eax, dword [byte eax+04h]
        add ebp, byte 0Ch
        mov dword [TileRowCount], eax
        mov dword [byte esp+08h], esi
        mov ebp, dword [byte ebp+04h]
        test edi, edi
        jle short .15
        mov eax, dword [byte esp+034h]
.12:
        mov ebx, dword [TileRowCount]
        mov edx, dword [byte eax+04h]
        cmp edx, ebx
        jge short .13
        mov dword [TileRowCount], edx
        mov dword [byte esp+08h], esi
        jmp short .14
.13:
        cmp ebp, edx
        jge short .14
        mov ebp, edx
.14:
        inc esi
        add eax, byte 0Ch
        cmp esi, edi
        jl short .12
.15:
        lea eax, [byte edi-01h]
        xor ebx, ebx
        test edi, edi
        jle short .17
        mov esi, TileEdgeTable
.16:
        push eax
        push ebx
        mov ebp, dword [byte esp+034h]
        push ebp
        mov eax, dword [byte esp+040h]
        push eax
        push esi
        call SetupTileSpans
        add esp, byte 14h
        mov eax, ebx
        inc ebx
        add esi, byte 38h
        cmp ebx, edi
        jl short .16
.17:
        mov edx, dword [byte esp+08h]
        lea eax, [byte edx+01h]
        cmp eax, edi
        jl short .18
        xor eax, eax
.18:
        mov ebx, dword [byte esp+024h]
        mov dword [TileTexSize], ebx
        mov ebx, dword [TileRowCount]
        mov ecx, dword [DrawDestBuffer]
        shl ebx, 2
        add ebx, ecx
        mov ecx, dword [DrawDestPitch]
        mov ebx, dword [ebx]
        add ecx, ebx
        mov ebx, dword [byte esp+024h]
        mov dword [TileRowY], ecx
        mov ebx, dword [byte ebx+02h]
        sar ebx, 10h
        mov dword [TileTexture], ebx
        cmp dword [byte esp+038h], byte 0
        jge short .19
        push edi
        push eax
        push edx
        call DrawTileEdgeRight
        jmp short .20
.19:
        push edi
        push eax
        push edx
        call DrawTileEdgeLeft
.20:
        add esp, byte 0Ch
.21:
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawTilePage                                   10FAE4  97 PC, low confidence
; Draws a texture page of tiles
;-----------------------------------------------------------------------------
DrawTilePage:
        push ebx
        push ebp
        sub esp, byte 48h
        mov edx, dword [byte esp+054h]
        xor ebx, ebx
        mov dword [byte esp+018h], ebx
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+04h], ebx
        mov dword [esp], ebx
        mov eax, dword [byte edx+02h]
        sar eax, 10h
        dec eax
        shl eax, 10h
        dec eax
        mov dword [byte esp+010h], eax
        mov dword [byte esp+08h], eax
        mov eax, dword [byte edx+04h]
        sar eax, 10h
        dec eax
        shl eax, 10h
        mov ebp, dword [byte esp+060h]
        dec eax
        push ebp
        mov dword [byte esp+020h], eax
        mov dword [byte esp+018h], eax
        mov eax, dword [byte esp+060h]
        push eax
        mov ebx, dword [byte esp+060h]
        push ebx
        lea eax, [byte esp+0Ch]
        push eax
        push byte 4
        push edx
        call DrawTileTexture
        add esp, byte 18h
        add esp, byte 48h
        pop ebp
        pop ebx
        ret
