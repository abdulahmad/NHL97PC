; 3D library: SetRinkView, TransformRinkPoints, TransformRinkObject, ProjectRinkObject and 17 more.
bits 32
%include "hockey.inc"
section s_10E690 progbits alloc exec nowrite align=1
extern __STOSD, ClipLeftCol, ClipPolyToNear, DrawClippedPoly, DrawPolyList, FillPolygon, FillRectColor, FillSpanRows
extern IceShadeBase, IceShadeScale, IceShadeTable, IceSpansEnabled, PolyCrossProduct, ScreenHeight, ScreenWidth, str_Punct_DrawRinkSurface
extern str_Punct_SetScreenScale, TexSpanCopy, TextureDetail, TexturePageBase, TextureTileSize, TileDestRow, TileEdgeTable, TileLeftBottom
extern TileLeftCount, TileLeftDu, TileLeftDv, TileLeftFlags, TileLeftHeight, TileLeftStep, TileLeftTop, TileLeftU
extern TileLeftUf, TileLeftVf, TileLeftX, TileRightBottom, TileRightCount, TileRightDu, TileRightDv, TileRightFlags
extern TileRightHeight, TileRightRow, TileRightStep, TileRightTop, TileRightU, TileRightUf, TileRightVf, TileRightX
extern TileRowCount, TileRowShade, TileRowY, TileTexSize, TileTexture
global SetRinkView, TransformRinkPoints, TransformRinkObject, ProjectRinkObject, DrawRinkPolyStrip, DrawRinkFan, DrawRinkPolys, DrawRinkRing
global RinkPrimSetupNone, DrawRinkPrimFlat, DrawRinkPrimShaded, DrawRinkPrimTextured, RinkPrimEndNone, DrawRinkLineFlat, DrawRinkLineShaded, DrawRinkLineTextured
global DrawIceSpans, SetupTileSpans, DrawTileSpan, DrawTileEdgeLeft, DrawTileEdgeLeft_24E, DrawTileEdgeRight
;-----------------------------------------------------------------------------
; SetRinkView                                    10E690  97 PC, low confidence
; Sets the rink view parameters
;-----------------------------------------------------------------------------
SetRinkView:
        mov eax, dword [byte esp+04h]
        mov dword [TextureDetail], eax
        mov eax, dword [byte esp+0Ch]
        mov dword [TextureTileSize], eax
        mov eax, dword [byte esp+08h]
        mov dword [TexturePageBase], eax
        ret
;-----------------------------------------------------------------------------
; TransformRinkPoints                            10E6AC  97 PC, low confidence
; Transforms rink points
;-----------------------------------------------------------------------------
TransformRinkPoints:
        push ebx
        push esi
        mov eax, dword [byte esp+0Ch]
        mov edx, dword [byte esp+010h]
        mov esi, dword [str_Punct_SetScreenScale]
.1:
        dec eax
        cmp eax, byte 0FFFFFFFFh
        je short .2
        imul ebx, dword [edx], byte 0Ch
        mov ecx, dword [TextureDetail]
        mov ebx, dword [byte ecx+ebx+08h]
        add edx, byte 4
        cmp ebx, esi
        jg short .1
        mov eax, 1
        pop esi
        pop ebx
        ret
.2:
        xor eax, eax
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; TransformRinkObject                            10E6E4  97 PC, low confidence
; Transforms a rink object
;-----------------------------------------------------------------------------
TransformRinkObject:
        push ebx
        push esi
        push edi
        push ebp
        mov edx, dword [byte esp+014h]
        mov ebx, dword [edx]
        lea eax, [nosplit ebx*4+00h]
        mov esi, dword [byte edx+04h]
        sub eax, ebx
        lea ebx, [nosplit esi*4+00h]
        sub ebx, esi
        mov edi, dword [TextureDetail]
        shl ebx, 2
        add edx, byte 4
        add ebx, edi
        add edx, byte 4
        mov eax, dword [byte edi+eax*4+08h]
        mov esi, dword [byte ebx+08h]
        mov ecx, eax
        cmp eax, esi
        jle short .1
        mov eax, esi
        jmp short .2
.1:
        jge short .2
        mov ecx, esi
.2:
        mov esi, dword [edx]
        lea ebx, [nosplit esi*4+00h]
        sub ebx, esi
        mov esi, dword [TextureDetail]
        shl ebx, 2
        add ebx, esi
        mov ebp, dword [byte ebx+08h]
        add edx, byte 4
        cmp eax, ebp
        jle short .3
        mov eax, ebp
        jmp short .4
.3:
        cmp ecx, ebp
        jge short .4
        mov ecx, ebp
.4:
        mov ebx, dword [edx]
        lea edx, [nosplit ebx*4+00h]
        sub edx, ebx
        lea ebx, [nosplit edx*4+00h]
        mov edx, dword [TextureDetail]
        add edx, ebx
        mov edi, dword [byte edx+08h]
        cmp eax, edi
        jle short .5
        mov eax, edi
        jmp short .6
.5:
        cmp ecx, edi
        jge short .6
        mov ecx, edi
.6:
        sub ecx, eax
        sar eax, 1
        cmp ecx, eax
        setl al
        and eax, 0FFh
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ProjectRinkObject                              10E794  97 PC, low confidence
; Projects a rink object
;-----------------------------------------------------------------------------
ProjectRinkObject:
        push ebx
        mov edx, dword [byte esp+08h]
        push edx
        mov ebx, dword [TexturePageBase]
        push ebx
        call PolyCrossProduct
        add esp, byte 8
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawRinkPolyStrip                              10E7AC  97 PC, low confidence
; Draws a strip of rink polygons
;-----------------------------------------------------------------------------
DrawRinkPolyStrip:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 100h
        mov ebp, dword [dword esp+0118h]
        mov esi, dword [dword esp+011Ch]
        cmp ebp, byte 2
        jne short .1
        mov edx, dword [dword esp+0114h]
        mov eax, dword [byte esi+04h]
        push edx
        mov edx, dword [TexturePageBase]
        mov ebx, dword [byte edx+eax*8+04h]
        push ebx
        mov ecx, dword [edx+eax*8]
        mov eax, dword [esi]
        push ecx
        mov esi, dword [byte edx+eax*8+04h]
        push esi
        mov edi, dword [edx+eax*8]
        push edi
        call FillRectColor
        jmp short .4
.1:
        test ebp, ebp
        jle short .3
        mov edx, esi
        lea ecx, [nosplit ebp*8+00h]
        xor eax, eax
.2:
        mov esi, dword [edx]
        mov ebx, dword [TexturePageBase]
        shl esi, 3
        lea edi, [esp+eax]
        add esi, ebx
        add eax, byte 8
        add edx, byte 4
        movsd
        movsd
        cmp eax, ecx
        jl short .2
.3:
        push byte 0
        push byte 0
        lea eax, [byte esp+08h]
        push eax
        push ebp
        mov ebp, dword [dword esp+0124h]
        push ebp
        call FillPolygon
.4:
        add esp, byte 14h
        add esp, 100h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawRinkFan                                    10E848  97 PC, low confidence
; Draws a fan of rink polygons
;-----------------------------------------------------------------------------
DrawRinkFan:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 280h
        cmp dword [dword esp+0298h], byte 0
        jle short .2
        mov eax, dword [dword esp+029Ch]
        mov ebp, dword [dword esp+0298h]
        xor edx, edx
        xor ebx, ebx
        shl ebp, 3
.1:
        mov ecx, dword [eax]
        mov esi, dword [TexturePageBase]
        shl ecx, 3
        lea edi, [dword esp+edx+0180h]
        add esi, ecx
        movsd
        movsd
        imul esi, dword [eax], byte 0Ch
        add ebx, byte 0Ch
        mov ecx, dword [TextureDetail]
        lea edi, [byte esp+ebx-0Ch]
        add esi, ecx
        add edx, byte 8
        add eax, byte 4
        movsd
        movsd
        movsd
        cmp edx, ebp
        jl short .1
.2:
        mov esi, dword [str_Punct_DrawRinkSurface]
        push esi
        lea eax, [dword esp+0184h]
        push eax
        lea eax, [byte esp+08h]
        push eax
        mov edi, dword [dword esp+02A4h]
        push edi
        call ClipPolyToNear
        add esp, byte 10h
        cmp eax, byte 2
        jle short .3
        push byte 0
        push byte 0
        lea edx, [dword esp+0188h]
        push edx
        push eax
        mov ebp, dword [dword esp+02A4h]
        push ebp
        call FillPolygon
        add esp, byte 14h
.3:
        add esp, 280h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawRinkPolys                                  10E8F8  97 PC, low confidence
; Draws rink polygons
;-----------------------------------------------------------------------------
DrawRinkPolys:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 100h
        mov ebp, dword [dword esp+0114h]
        cmp ebp, byte 3
        jl short .3
        test ebp, ebp
        jle short .2
        mov edx, dword [dword esp+0118h]
        lea ecx, [nosplit ebp*8+00h]
        xor eax, eax
.1:
        mov ebx, dword [edx]
        mov esi, dword [TexturePageBase]
        shl ebx, 3
        lea edi, [esp+eax]
        add esi, ebx
        add eax, byte 8
        add edx, byte 4
        movsd
        movsd
        cmp eax, ecx
        jl short .1
.2:
        push byte 1
        push byte 0
        lea eax, [byte esp+08h]
        push eax
        push ebp
        push byte 0Ch
        call FillPolygon
        add esp, byte 14h
.3:
        add esp, 100h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawRinkRing                                   10E960  97 PC, low confidence
; Draws a ring of rink polygons
;-----------------------------------------------------------------------------
DrawRinkRing:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 280h
        cmp dword [dword esp+0294h], byte 0
        jle short .2
        mov edx, dword [dword esp+0298h]
        mov ebp, dword [dword esp+0294h]
        xor eax, eax
        xor ebx, ebx
        shl ebp, 3
.1:
        mov ecx, dword [edx]
        mov esi, dword [TexturePageBase]
        shl ecx, 3
        lea edi, [dword esp+eax+0180h]
        add esi, ecx
        movsd
        movsd
        imul ecx, dword [edx], byte 0Ch
        add ebx, byte 0Ch
        mov esi, dword [TextureDetail]
        lea edi, [byte esp+ebx-0Ch]
        add esi, ecx
        add eax, byte 8
        add edx, byte 4
        movsd
        movsd
        movsd
        cmp eax, ebp
        jl short .1
.2:
        mov edi, dword [str_Punct_DrawRinkSurface]
        push edi
        lea eax, [dword esp+0184h]
        push eax
        lea eax, [byte esp+08h]
        push eax
        mov ebp, dword [dword esp+02A0h]
        push ebp
        call ClipPolyToNear
        add esp, byte 10h
        cmp eax, byte 2
        jle short .3
        push byte 1
        push byte 0
        lea edx, [dword esp+0188h]
        push edx
        push eax
        push byte 0Ch
        call FillPolygon
        add esp, byte 14h
.3:
        add esp, 280h
        pop ebp
        pop edi
        pop esi
        pop ebx
;-----------------------------------------------------------------------------
; RinkPrimSetupNone                                      10EA08  97 PC, low confidence
; Rink primitive set-up that does nothing (RinkPrimSetupFns, RinkPrimNoOpFns)
;-----------------------------------------------------------------------------
RinkPrimSetupNone:
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawRinkPrimFlat                               10EA0C  97 PC, low confidence
; Rink primitive: flat polygon
;-----------------------------------------------------------------------------
DrawRinkPrimFlat:
        push ebx
        push esi
        push edi
        sub esp, 0A0h
        mov eax, dword [dword esp+0B4h]
        mov edx, dword [dword esp+0B8h]
        mov esi, dword [edx]
        mov ebx, dword [TexturePageBase]
        shl esi, 3
        lea edi, [byte esp+050h]
        add esi, ebx
        movsd
        movsd
        mov esi, dword [byte edx+04h]
        shl esi, 3
        lea edi, [byte esp+058h]
        add esi, ebx
        movsd
        movsd
        mov esi, dword [byte edx+08h]
        shl esi, 3
        lea edi, [byte esp+060h]
        add esi, ebx
        add edx, byte 4
        movsd
        movsd
        mov esi, dword [byte edx+08h]
        add edx, byte 4
        shl esi, 3
        lea edi, [byte esp+068h]
        add esi, ebx
        add edx, byte 4
        movsd
        movsd
        mov edx, dword [TextureTileSize]
        mov ebx, dword [eax]
        mov ebx, dword [edx+ebx*8]
        shl ebx, 10h
        mov dword [esp], ebx
        mov ebx, dword [eax]
        mov ebx, dword [byte edx+ebx*8+04h]
        shl ebx, 10h
        mov dword [byte esp+04h], ebx
        mov ebx, dword [byte eax+04h]
        mov ebx, dword [edx+ebx*8]
        shl ebx, 10h
        mov dword [byte esp+08h], ebx
        mov ebx, dword [byte eax+04h]
        mov ebx, dword [byte edx+ebx*8+04h]
        shl ebx, 10h
        mov dword [byte esp+0Ch], ebx
        mov ebx, dword [byte eax+08h]
        mov ebx, dword [edx+ebx*8]
        shl ebx, 10h
        mov dword [byte esp+010h], ebx
        mov ebx, dword [byte eax+08h]
        mov ebx, dword [byte edx+ebx*8+04h]
        shl ebx, 10h
        mov dword [byte esp+014h], ebx
        mov ebx, dword [byte eax+0Ch]
        add eax, byte 4
        mov ebx, dword [edx+ebx*8]
        add eax, byte 4
        shl ebx, 10h
        add eax, byte 4
        mov dword [byte esp+018h], ebx
        mov eax, dword [eax]
        mov eax, dword [byte edx+eax*8+04h]
        push byte 0
        shl eax, 10h
        push byte 0
        mov dword [byte esp+024h], eax
        lea eax, [byte esp+058h]
        push eax
        lea eax, [byte esp+0Ch]
        push eax
        push byte 4
        mov edx, dword [dword esp+0C4h]
        push edx
        call DrawClippedPoly
        add esp, byte 18h
        add esp, 0A0h
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawRinkPrimShaded                             10EB0C  97 PC, low confidence
; Rink primitive: shaded polygon
;-----------------------------------------------------------------------------
DrawRinkPrimShaded:
        push ebx
        push esi
        push edi
        sub esp, 0A0h
        mov eax, dword [dword esp+0B4h]
        mov edx, dword [dword esp+0B8h]
        mov esi, dword [edx]
        mov ebx, dword [TexturePageBase]
        shl esi, 3
        lea edi, [byte esp+050h]
        add esi, ebx
        movsd
        movsd
        mov esi, dword [byte edx+04h]
        shl esi, 3
        lea edi, [byte esp+058h]
        add esi, ebx
        movsd
        movsd
        mov esi, dword [byte edx+08h]
        shl esi, 3
        lea edi, [byte esp+060h]
        add esi, ebx
        add edx, byte 4
        movsd
        movsd
        mov esi, dword [byte edx+08h]
        add edx, byte 4
        shl esi, 3
        lea edi, [byte esp+068h]
        add esi, ebx
        add edx, byte 4
        movsd
        movsd
        mov edx, dword [TextureTileSize]
        mov ebx, dword [eax]
        mov ebx, dword [edx+ebx*8]
        shl ebx, 10h
        mov dword [esp], ebx
        mov ebx, dword [eax]
        mov ebx, dword [byte edx+ebx*8+04h]
        shl ebx, 10h
        mov dword [byte esp+04h], ebx
        mov ebx, dword [byte eax+04h]
        mov ebx, dword [edx+ebx*8]
        shl ebx, 10h
        mov dword [byte esp+08h], ebx
        mov ebx, dword [byte eax+04h]
        mov ebx, dword [byte edx+ebx*8+04h]
        shl ebx, 10h
        mov dword [byte esp+0Ch], ebx
        mov ebx, dword [byte eax+08h]
        mov ebx, dword [edx+ebx*8]
        shl ebx, 10h
        mov dword [byte esp+010h], ebx
        mov ebx, dword [byte eax+08h]
        mov ebx, dword [byte edx+ebx*8+04h]
        shl ebx, 10h
        mov dword [byte esp+014h], ebx
        mov ebx, dword [byte eax+0Ch]
        add eax, byte 4
        mov ebx, dword [edx+ebx*8]
        add eax, byte 4
        shl ebx, 10h
        add eax, byte 4
        mov dword [byte esp+018h], ebx
        mov eax, dword [eax]
        mov eax, dword [byte edx+eax*8+04h]
        push byte 1
        shl eax, 10h
        push byte 0
        mov dword [byte esp+024h], eax
        lea eax, [byte esp+058h]
        push eax
        lea eax, [byte esp+0Ch]
        push eax
        push byte 4
        mov edx, dword [dword esp+0C4h]
        push edx
        call DrawClippedPoly
        add esp, byte 18h
        add esp, 0A0h
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawRinkPrimTextured                           10EC0C  97 PC, low confidence
; Rink primitive: textured polygon
;-----------------------------------------------------------------------------
DrawRinkPrimTextured:
        push ebx
        push esi
        push edi
        sub esp, 0A0h
        mov eax, dword [dword esp+0B4h]
        mov edx, dword [dword esp+0B8h]
        mov esi, dword [edx]
        mov ebx, dword [TexturePageBase]
        shl esi, 3
        lea edi, [byte esp+050h]
        add esi, ebx
        movsd
        movsd
        mov esi, dword [byte edx+04h]
        shl esi, 3
        lea edi, [byte esp+058h]
        add esi, ebx
        movsd
        movsd
        mov esi, dword [byte edx+08h]
        shl esi, 3
        lea edi, [byte esp+060h]
        add esi, ebx
        add edx, byte 4
        movsd
        movsd
        mov esi, dword [byte edx+08h]
        add edx, byte 4
        shl esi, 3
        lea edi, [byte esp+068h]
        add esi, ebx
        add edx, byte 4
        movsd
        movsd
        mov edx, dword [TextureTileSize]
        mov ebx, dword [eax]
        mov ebx, dword [edx+ebx*8]
        shl ebx, 10h
        mov dword [esp], ebx
        mov ebx, dword [eax]
        mov ebx, dword [byte edx+ebx*8+04h]
        shl ebx, 10h
        mov dword [byte esp+04h], ebx
        mov ebx, dword [byte eax+04h]
        mov ebx, dword [edx+ebx*8]
        shl ebx, 10h
        mov dword [byte esp+08h], ebx
        mov ebx, dword [byte eax+04h]
        mov ebx, dword [byte edx+ebx*8+04h]
        shl ebx, 10h
        mov dword [byte esp+0Ch], ebx
        mov ebx, dword [byte eax+08h]
        mov ebx, dword [edx+ebx*8]
        shl ebx, 10h
        mov dword [byte esp+010h], ebx
        mov ebx, dword [byte eax+08h]
        mov ebx, dword [byte edx+ebx*8+04h]
        shl ebx, 10h
        mov dword [byte esp+014h], ebx
        mov ebx, dword [byte eax+0Ch]
        add eax, byte 4
        mov ebx, dword [edx+ebx*8]
        add eax, byte 4
        shl ebx, 10h
        add eax, byte 4
        mov dword [byte esp+018h], ebx
        mov eax, dword [eax]
        mov eax, dword [byte edx+eax*8+04h]
        push byte 2
        shl eax, 10h
        push byte 0
        mov dword [byte esp+024h], eax
        lea eax, [byte esp+058h]
        push eax
        lea eax, [byte esp+0Ch]
        push eax
        push byte 4
        mov edx, dword [dword esp+0C4h]
        push edx
        call DrawClippedPoly
        add esp, byte 18h
        add esp, 0A0h
        pop edi
        pop esi
        pop ebx
        lea eax, [byte eax+00h]
;-----------------------------------------------------------------------------
; RinkPrimEndNone                                      10ED0C  97 PC, low confidence
; Rink primitive end that does nothing (RinkPrimEndFns)
;-----------------------------------------------------------------------------
RinkPrimEndNone:
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawRinkLineFlat                               10ED10  97 PC, low confidence
; Rink line primitive: flat
;-----------------------------------------------------------------------------
DrawRinkLineFlat:
        push esi
        push edi
        sub esp, byte 50h
        mov eax, dword [byte esp+060h]
        mov esi, dword [eax]
        mov edx, dword [TexturePageBase]
        shl esi, 3
        mov edi, esp
        add esi, edx
        movsd
        movsd
        mov esi, dword [byte eax+04h]
        shl esi, 3
        lea edi, [byte esp+08h]
        add esi, edx
        add eax, byte 4
        movsd
        movsd
        mov esi, dword [byte eax+04h]
        add eax, byte 4
        shl esi, 3
        lea edi, [byte esp+010h]
        add esi, edx
        push byte 0
        add eax, byte 4
        movsd
        movsd
        push byte 0
        mov esi, dword [eax]
        lea eax, [byte esp+08h]
        shl esi, 3
        push eax
        add esi, edx
        mov edx, dword [byte esp+068h]
        lea edi, [byte esp+024h]
        push edx
        movsd
        movsd
        call DrawPolyList
        add esp, byte 10h
        add esp, byte 50h
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; DrawRinkLineShaded                             10ED78  97 PC, low confidence
; Rink line primitive: shaded
;-----------------------------------------------------------------------------
DrawRinkLineShaded:
        push esi
        push edi
        sub esp, byte 50h
        mov eax, dword [byte esp+060h]
        mov esi, dword [eax]
        mov edx, dword [TexturePageBase]
        shl esi, 3
        mov edi, esp
        add esi, edx
        movsd
        movsd
        mov esi, dword [byte eax+04h]
        shl esi, 3
        lea edi, [byte esp+08h]
        add esi, edx
        add eax, byte 4
        movsd
        movsd
        mov esi, dword [byte eax+04h]
        add eax, byte 4
        shl esi, 3
        lea edi, [byte esp+010h]
        add esi, edx
        push byte 2
        add eax, byte 4
        movsd
        movsd
        push byte 0
        mov esi, dword [eax]
        lea eax, [byte esp+08h]
        shl esi, 3
        push eax
        add esi, edx
        mov edx, dword [byte esp+068h]
        lea edi, [byte esp+024h]
        push edx
        movsd
        movsd
        call DrawPolyList
        add esp, byte 10h
        add esp, byte 50h
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; DrawRinkLineTextured                           10EDE0  97 PC, low confidence
; Rink line primitive: textured
;-----------------------------------------------------------------------------
DrawRinkLineTextured:
        push esi
        push edi
        sub esp, byte 50h
        mov eax, dword [byte esp+060h]
        mov esi, dword [eax]
        mov edx, dword [TexturePageBase]
        shl esi, 3
        mov edi, esp
        add esi, edx
        movsd
        movsd
        mov esi, dword [byte eax+04h]
        shl esi, 3
        lea edi, [byte esp+08h]
        add esi, edx
        add eax, byte 4
        movsd
        movsd
        mov esi, dword [byte eax+04h]
        add eax, byte 4
        shl esi, 3
        lea edi, [byte esp+010h]
        add esi, edx
        push byte 1
        add eax, byte 4
        movsd
        movsd
        push byte 0
        mov esi, dword [eax]
        lea eax, [byte esp+08h]
        shl esi, 3
        push eax
        add esi, edx
        mov edx, dword [byte esp+068h]
        lea edi, [byte esp+024h]
        push edx
        movsd
        movsd
        call DrawPolyList
        add esp, byte 10h
        add esp, byte 50h
        pop edi
        pop esi
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; DrawIceSpans                                   10EE50  97 PC, low confidence
; Draws the ice spans
;-----------------------------------------------------------------------------
DrawIceSpans:
        push ebx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 40h
        and esp, byte 0FFFFFFF8h
        cmp dword [IceSpansEnabled], byte 0
        je short .2
        mov ecx, 1E0h
        mov edx, 3E8h
        mov eax, IceShadeScale
        mov ebx, 1
        call __STOSD
        mov eax, 4
        mov dword [byte esp+03Ch], ebx
.1:
        fild dword [byte esp+03Ch]
        fld1
        fdivrp
        mov ecx, dword [byte esp+03Ch]
        inc ecx
        add eax, byte 4
        mov dword [byte esp+03Ch], ecx
        fstp dword [dword eax+IceShadeBase]
        cmp ecx, 281h
        jl short .1
        xor edi, edi
        mov dword [IceSpansEnabled], edi
.2:
        mov edi, dword [byte ebp+018h]
        mov esi, 1
        mov ecx, dword [byte ebp+014h]
        xor eax, eax
        xor ebx, ebx
        mov edi, dword [byte edi+08h]
        mov dword [byte esp+034h], eax
        mov edx, edi
        cmp ecx, esi
        jle short .6
        mov eax, dword [byte ebp+018h]
        add eax, byte 0Ch
.3:
        mov ecx, dword [byte eax+08h]
        cmp edx, ecx
        jle short .4
        mov ebx, esi
        mov edx, ecx
        jmp short .5
.4:
        cmp edi, ecx
        jge short .5
        mov dword [byte esp+034h], esi
        mov edi, ecx
.5:
        mov ecx, dword [byte ebp+014h]
        inc esi
        add eax, byte 0Ch
        cmp esi, ecx
        jl short .3
.6:
        cmp edi, dword [str_Punct_DrawRinkSurface]
        jle near .12
        mov esi, dword [byte esp+034h]
        mov edi, dword [byte ebp+01Ch]
        mov ecx, dword [byte esp+034h]
        shl esi, 3
        lea eax, [nosplit ecx*4+00h]
        add esi, edi
        sub eax, ecx
        lea edi, [byte esp+020h]
        mov ecx, dword [byte ebp+018h]
        shl eax, 2
        movsd
        movsd
        add ecx, eax
        lea edi, [byte esp+0Ch]
        mov esi, ecx
        lea eax, [nosplit ebx*4+00h]
        movsd
        movsd
        movsd
        sub eax, ebx
        mov esi, dword [byte ebp+018h]
        shl eax, 2
        mov edi, dword [str_Punct_DrawRinkSurface]
        add eax, esi
        cmp edx, edi
        jg short .7
        lea edx, [byte edi+01h]
        push edx
        lea edx, [byte esp+01Ch]
        push edx
        lea edx, [byte esp+08h]
        push edx
        push ecx
        push eax
        call FillSpanRows
        add esp, byte 14h
        jmp short .8
.7:
        mov esi, dword [byte ebp+01Ch]
        shl ebx, 3
        lea edi, [byte esp+018h]
        add esi, ebx
        movsd
        movsd
        mov edi, esp
        mov esi, eax
        movsd
        movsd
        movsd
.8:
        fild dword [byte esp+08h]
        fld1
        fdivrp
        fild dword [byte esp+014h]
        fld1
        fdivrp
        mov eax, dword [byte esp+01Ch]
        mov edx, dword [byte esp+024h]
        sub eax, edx
        inc eax
        mov dword [byte esp+02Ch], eax
        fild dword [byte esp+02Ch]
        fxch st2
        fstp dword [byte esp+038h]
        fsub dword [byte esp+038h]
        fdivrp
        mov ebx, dword [byte esp+01Ch]
        fstp dword [byte esp+030h]
        cmp edx, ebx
        jge near .12
        mov ecx, dword [ScreenHeight]
        cmp ebx, ecx
        jl short .9
        mov eax, ebx
        sub eax, ecx
        inc eax
        mov dword [byte esp+02Ch], eax
        fild dword [byte esp+02Ch]
        fmul dword [byte esp+030h]
        lea eax, [byte ecx-01h]
        fadd dword [byte esp+038h]
        mov dword [byte esp+01Ch], eax
        fstp dword [byte esp+038h]
.9:
        mov eax, dword [byte esp+024h]
        mov edi, dword [ClipLeftCol]
        cmp eax, edi
        jge short .10
        mov dword [byte esp+024h], edi
.10:
        mov eax, dword [byte esp+01Ch]
        mov edx, dword [byte esp+024h]
        cmp eax, edx
        jl short .12
        fld dword [byte esp+038h]
        fld dword [byte esp+030h]
        shl eax, 2
        shl edx, 2
.11:
        fld st1
        fld1
        fdivrp
        fld st2
        sub eax, byte 4
        fadd st2
        fxch
        fstp dword [dword eax+IceShadeTable]
        fstp st2
        cmp eax, edx
        jge short .11
        fstp st0
        fstp dword [byte esp+038h]
.12:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SetupTileSpans                                 10F038  97 PC, low confidence
; Sets up the spans of a texture tile
;-----------------------------------------------------------------------------
SetupTileSpans:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov esi, dword [byte esp+020h]
        mov edi, dword [byte esp+02Ch]
        mov ebp, dword [byte esp+030h]
        lea eax, [nosplit edi*4+00h]
        sub eax, edi
        mov ecx, dword [byte esp+024h]
        shl eax, 2
        add ecx, eax
        lea eax, [nosplit ebp*4+00h]
        sub eax, ebp
        mov ebx, dword [byte esp+024h]
        shl eax, 2
        add ebx, eax
        mov eax, dword [byte ecx+04h]
        cmp eax, dword [byte ebx+04h]
        jle short .1
        xor edi, ebp
        xor ebp, edi
        xor edi, ebp
.1:
        lea eax, [nosplit edi*4+00h]
        sub eax, edi
        mov ecx, dword [byte esp+024h]
        shl eax, 2
        add ecx, eax
        mov eax, dword [byte ecx+04h]
        mov dword [byte esi+014h], eax
        lea eax, [nosplit ebp*4+00h]
        sub eax, ebp
        mov ebx, dword [byte esp+024h]
        shl eax, 2
        add ebx, eax
        mov edx, dword [byte esi+014h]
        mov eax, dword [byte ebx+04h]
        sub eax, edx
        mov dword [byte esi+018h], eax
        je near .19
        mov edx, dword [ecx]
        mov eax, dword [ebx]
        sub eax, edx
        mov ebx, dword [byte ecx+04h]
        mov dword [byte esp+08h], eax
        mov eax, dword [byte esi+014h]
        mov ecx, dword [byte esp+08h]
        sub eax, ebx
        imul eax, ecx
        dec eax
        lea ecx, [byte esi+010h]
        test eax, eax
        jl short .5
        mov ebx, dword [byte esi+018h]
        mov edx, ebx
        cmp edx, byte 0
        jge short .2
        neg edx
.2:
        cmp eax, edx
        jae short .3
        mov dword [ecx], eax
        mov eax, 0
        jmp short .4
.3:
        mov edx, eax
        sar edx, 1Fh
        idiv ebx
        mov dword [ecx], edx
.4:
        mov dword [esi], eax
        jmp short .9
.5:
        neg eax
        mov ebx, dword [byte esi+018h]
        mov edx, ebx
        cmp edx, byte 0
        jge short .6
        neg edx
.6:
        cmp eax, edx
        jae short .7
        mov dword [ecx], eax
        mov eax, 0
        jmp short .8
.7:
        mov edx, eax
        sar edx, 1Fh
        idiv ebx
        mov dword [ecx], edx
.8:
        mov dword [esi], eax
        neg eax
        mov edx, dword [byte esi+010h]
        mov dword [esi], eax
        test edx, edx
        je short .9
        lea ebx, [byte eax-01h]
        mov ecx, dword [byte esi+010h]
        mov eax, dword [byte esi+018h]
        mov dword [esi], ebx
        sub eax, ecx
        mov dword [byte esi+010h], eax
.9:
        lea eax, [nosplit edi*4+00h]
        sub eax, edi
        mov edx, dword [byte esp+024h]
        shl eax, 2
        add eax, edx
        mov eax, dword [eax]
        mov ebx, dword [esi]
        inc eax
        lea ecx, [byte esi+08h]
        add ebx, eax
        mov eax, dword [byte esp+08h]
        mov dword [esi], ebx
        test eax, eax
        jl short .13
        mov ebx, dword [byte esi+018h]
        mov edx, ebx
        cmp edx, byte 0
        jge short .10
        neg edx
.10:
        cmp eax, edx
        jae short .11
        mov dword [ecx], eax
        mov eax, 0
        jmp short .12
.11:
        mov edx, eax
        sar edx, 1Fh
        idiv ebx
        mov dword [ecx], edx
.12:
        mov dword [byte esi+04h], eax
        jmp short .17
.13:
        neg eax
        mov ebx, dword [byte esi+018h]
        mov edx, ebx
        cmp edx, byte 0
        jge short .14
        neg edx
.14:
        cmp eax, edx
        jae short .15
        mov dword [ecx], eax
        mov eax, 0
        jmp short .16
.15:
        mov edx, eax
        sar edx, 1Fh
        idiv ebx
        mov dword [ecx], edx
.16:
        mov edx, eax
        mov dword [byte esi+04h], eax
        neg edx
        mov ebx, dword [byte esi+08h]
        mov dword [byte esi+04h], edx
        test ebx, ebx
        je short .17
        lea ecx, [byte edx-01h]
        mov eax, dword [byte esi+018h]
        mov edx, dword [byte esi+08h]
        mov dword [byte esi+04h], ecx
        sub eax, edx
        mov dword [byte esi+08h], eax
.17:
        mov ebx, dword [byte esp+028h]
        lea ecx, [nosplit edi*8+00h]
        mov eax, dword [byte esi+018h]
        add ecx, ebx
        mov dword [byte esi+0Ch], eax
        mov eax, dword [ecx]
        mov dword [byte esi+020h], eax
        mov eax, dword [byte ecx+04h]
        mov dword [byte esi+024h], eax
        lea eax, [nosplit edi*4+00h]
        sub eax, edi
        mov edx, dword [byte esp+024h]
        shl eax, 2
        add eax, edx
        mov dword [byte esi+01Ch], 0
        fild dword [byte eax+08h]
        lea eax, [nosplit ebp*4+00h]
        sub eax, ebp
        shl eax, 2
        add eax, edx
        fild dword [byte eax+08h]
        lea eax, [nosplit ebp*8+00h]
        add eax, ebx
        fxch
        fstp dword [esp]
        mov edx, dword [ecx]
        mov ebx, dword [eax]
        fstp dword [byte esp+04h]
        cmp ebx, edx
        je short .18
        fild dword [ecx]
        fdiv dword [esp]
        fstp dword [byte esi+028h]
        fild dword [eax]
        fdiv dword [byte esp+04h]
        fsub dword [byte esi+028h]
        fild dword [byte esi+018h]
        fdivp
        or byte [byte esi+01Ch], 1
        fstp dword [byte esi+030h]
.18:
        mov ebx, dword [byte esp+028h]
        lea eax, [nosplit ebp*8+00h]
        mov ecx, dword [byte esp+028h]
        add eax, ebx
        lea ebx, [nosplit edi*8+00h]
        add ebx, ecx
        mov ecx, dword [byte eax+04h]
        cmp ecx, dword [byte ebx+04h]
        je short .19
        fild dword [byte ebx+04h]
        fdiv dword [esp]
        fstp dword [byte esi+02Ch]
        fild dword [byte eax+04h]
        fdiv dword [byte esp+04h]
        fsub dword [byte esi+02Ch]
        fild dword [byte esi+018h]
        fdivp
        or byte [byte esi+01Ch], 2
        fstp dword [byte esi+034h]
.19:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawTileSpan                                   10F2A0  97 PC, low confidence
; Draws one span of a texture tile
;-----------------------------------------------------------------------------
DrawTileSpan:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov edx, dword [TileDestRow]
        mov ebx, dword [TileRightRow]
        sub ebx, edx
        test ebx, ebx
        jle near .1
        mov eax, dword [nosplit ebx*4+TileRowShade]
        mov ecx, dword [TileLeftX]
        mov dword [esp], eax
        mov eax, dword [TileRightX]
        sub eax, ecx
        mov dword [byte esp+04h], eax
        fild dword [byte esp+04h]
        fmul dword [esp]
        push eax
        fistp dword [esp]
        pop eax
        mov esi, dword [TileLeftU]
        mov edx, eax
        mov eax, dword [TileRightU]
        sub eax, esi
        mov dword [byte esp+04h], eax
        fild dword [byte esp+04h]
        fmul dword [esp]
        push eax
        fistp dword [esp]
        pop eax
        mov ecx, eax
        mov edi, dword [TileTexture]
        sar ecx, 10h
        imul ecx, edi
        mov esi, edx
        sar esi, 10h
        add ecx, esi
        mov esi, dword [TileLeftU]
        sar esi, 10h
        imul edi, esi
        push ebx
        mov ebp, dword [TileTexture]
        push ecx
        add ecx, ebp
        push ecx
        push eax
        mov eax, dword [TileLeftU]
        push eax
        mov ebx, dword [TileDestRow]
        mov eax, dword [TileRowY]
        push edx
        mov esi, dword [TileTexSize]
        mov edx, dword [TileLeftX]
        add esi, byte 10h
        add eax, ebx
        add edi, esi
        mov esi, dword [TileLeftX]
        push edx
        sar esi, 10h
        push eax
        add esi, edi
        push esi
        call TexSpanCopy
        add esp, byte 24h
.1:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawTileEdgeLeft                               10F374  97 PC, low confidence
; Draws the left edge of a texture tile
;-----------------------------------------------------------------------------
DrawTileEdgeLeft:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebx, dword [byte esp+018h]
        mov ebp, dword [byte esp+01Ch]
        lea eax, [nosplit ebp*8+00h]
        sub eax, ebp
        mov ecx, 0Eh
        mov edi, TileDestRow
        lea esi, [nosplit eax*8+TileEdgeTable]
        lea eax, [nosplit ebx*8+00h]
        rep movsd
        sub eax, ebx
        mov ecx, 0Eh
        lea esi, [nosplit eax*8+TileEdgeTable]
        mov eax, dword [byte esp+020h]
        mov edi, TileRightRow
        dec eax
        rep movsd
        mov dword [esp], eax
.1:
        cmp dword [TileRightCount], byte 0
        jg short .3
        dec ebx
        test ebx, ebx
        jge short .2
        mov ebx, dword [esp]
.2:
        cmp ebx, ebp
        je near DrawTileEdgeLeft_24E
        imul esi, ebx, byte 38h
        mov ecx, 0Eh
        mov edi, TileRightRow
        lea esi, [dword esi+TileEdgeTable]
        rep movsd
        jmp short .1
.3:
        mov ecx, dword [TileLeftCount]
        test ecx, ecx
        jg short .5
        mov edi, dword [byte esp+020h]
        inc ebp
        cmp ebp, edi
        jl short .4
        xor ebp, ebp
.4:
        imul esi, ebp, byte 38h
        mov ecx, 0Eh
        mov edi, TileDestRow
        lea esi, [dword esi+TileEdgeTable]
        rep movsd
        jmp short .3
.5:
        mov eax, dword [TileRightCount]
        cmp eax, ecx
        jge short .6
        mov esi, eax
        jmp short .7
.6:
        mov esi, ecx
.7:
        dec esi
        cmp esi, byte 0FFFFFFFFh
        je short .1
        call DrawTileSpan
        mov eax, dword [ScreenWidth]
        mov edx, dword [TileRowY]
        mov ecx, dword [TileRowCount]
        mov edi, dword [TileDestRow]
        inc ecx
        add edx, eax
        mov eax, dword [TileLeftTop]
        mov dword [TileRowY], edx
        add edi, eax
        mov eax, dword [TileLeftCount]
        mov dword [TileRowCount], ecx
        dec eax
        mov edx, dword [TileLeftStep]
        mov dword [TileLeftCount], eax
        mov eax, dword [TileLeftBottom]
        mov ecx, dword [TileLeftHeight]
        add edx, eax
        mov dword [TileDestRow], edi
        mov dword [TileLeftStep], edx
        cmp edx, ecx
        jl short .8
        sub edx, ecx
        inc edi
        mov dword [TileLeftStep], edx
        mov dword [TileDestRow], edi
.8:
        test byte [TileLeftFlags], 1
        je short .9
        fld dword [TileLeftDu]
        fadd dword [TileLeftUf]
        mov eax, dword [TileRowCount]
        fst dword [TileLeftUf]
        fmul dword [nosplit eax*4+IceShadeScale]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [TileLeftX], eax
.9:
        test byte [TileLeftFlags], 2
        je short .10
        fld dword [TileLeftDv]
        fadd dword [TileLeftVf]
        mov eax, dword [TileRowCount]
        fst dword [TileLeftVf]
        fmul dword [nosplit eax*4+IceShadeScale]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [TileLeftU], eax
.10:
        mov ecx, dword [TileRightRow]
        mov edi, dword [TileRightCount]
        mov eax, dword [TileRightTop]
        mov edx, dword [TileRightStep]
        dec edi
        add ecx, eax
        mov eax, dword [TileRightBottom]
        mov dword [TileRightRow], ecx
        mov dword [TileRightCount], edi
        add edx, eax
        mov ecx, dword [TileRightHeight]
        mov dword [TileRightStep], edx
        cmp edx, ecx
        jl short .11
        mov edi, dword [TileRightRow]
        sub edx, ecx
        inc edi
        mov dword [TileRightStep], edx
        mov dword [TileRightRow], edi
.11:
        test byte [TileRightFlags], 1
        je short .12
        fld dword [TileRightDu]
        fadd dword [TileRightUf]
        mov eax, dword [TileRowCount]
        fst dword [TileRightUf]
        fmul dword [nosplit eax*4+IceShadeScale]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [TileRightX], eax
.12:
        test byte [TileRightFlags], 2
        je near .7
        fld dword [TileRightDv]
        fadd dword [TileRightVf]
        mov eax, dword [TileRowCount]
        fst dword [TileRightVf]
        fmul dword [nosplit eax*4+IceShadeScale]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [TileRightU], eax
        jmp near .7
DrawTileEdgeLeft_24E:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawTileEdgeRight                              10F5CC  97 PC, low confidence
; Draws the right edge of a texture tile
;-----------------------------------------------------------------------------
DrawTileEdgeRight:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebx, dword [byte esp+018h]
        mov ebp, dword [byte esp+01Ch]
        lea eax, [nosplit ebx*8+00h]
        sub eax, ebx
        mov ecx, 0Eh
        mov edi, TileDestRow
        lea esi, [nosplit eax*8+TileEdgeTable]
        lea eax, [nosplit ebp*8+00h]
        rep movsd
        sub eax, ebp
        mov ecx, 0Eh
        lea esi, [nosplit eax*8+TileEdgeTable]
        mov eax, dword [byte esp+020h]
        mov edi, TileRightRow
        dec eax
        rep movsd
        mov dword [esp], eax
.1:
        cmp dword [TileLeftCount], byte 0
        jg short .3
        dec ebx
        test ebx, ebx
        jge short .2
        mov ebx, dword [esp]
.2:
        cmp ebx, ebp
        je short DrawTileEdgeLeft_24E
        imul esi, ebx, byte 38h
        mov ecx, 0Eh
        mov edi, TileDestRow
        lea esi, [dword esi+TileEdgeTable]
        rep movsd
        jmp short .1
.3:
        mov ecx, dword [TileRightCount]
        test ecx, ecx
        jg short .5
        mov edi, dword [byte esp+020h]
        inc ebp
        cmp ebp, edi
        jl short .4
        xor ebp, ebp
.4:
        imul esi, ebp, byte 38h
        mov ecx, 0Eh
        mov edi, TileRightRow
        lea esi, [dword esi+TileEdgeTable]
        rep movsd
        jmp short .3
.5:
        mov esi, dword [TileLeftCount]
        cmp ecx, esi
        jge short .6
        mov esi, ecx
.6:
        dec esi
        cmp esi, byte 0FFFFFFFFh
        je short .1
        call DrawTileSpan
        mov eax, dword [ScreenWidth]
        mov edx, dword [TileRowY]
        mov ecx, dword [TileRowCount]
        mov edi, dword [TileDestRow]
        inc ecx
        add edx, eax
        mov eax, dword [TileLeftTop]
        mov dword [TileRowY], edx
        add edi, eax
        mov eax, dword [TileLeftCount]
        mov dword [TileRowCount], ecx
        dec eax
        mov edx, dword [TileLeftStep]
        mov dword [TileLeftCount], eax
        mov eax, dword [TileLeftBottom]
        mov ecx, dword [TileLeftHeight]
        add edx, eax
        mov dword [TileDestRow], edi
        mov dword [TileLeftStep], edx
        cmp edx, ecx
        jl short .7
        sub edx, ecx
        inc edi
        mov dword [TileLeftStep], edx
        mov dword [TileDestRow], edi
.7:
        test byte [TileLeftFlags], 1
        je short .8
        fld dword [TileLeftDu]
        fadd dword [TileLeftUf]
        mov eax, dword [TileRowCount]
        fst dword [TileLeftUf]
        fmul dword [nosplit eax*4+IceShadeScale]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [TileLeftX], eax
.8:
        test byte [TileLeftFlags], 2
        je short .9
        fld dword [TileLeftDv]
        fadd dword [TileLeftVf]
        mov eax, dword [TileRowCount]
        fst dword [TileLeftVf]
        fmul dword [nosplit eax*4+IceShadeScale]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [TileLeftU], eax
.9:
        mov ecx, dword [TileRightRow]
        mov edi, dword [TileRightCount]
        mov eax, dword [TileRightTop]
        mov edx, dword [TileRightStep]
        dec edi
        add ecx, eax
        mov eax, dword [TileRightBottom]
        mov dword [TileRightRow], ecx
        mov dword [TileRightCount], edi
        add edx, eax
        mov ecx, dword [TileRightHeight]
        mov dword [TileRightStep], edx
        cmp edx, ecx
        jl short .10
        mov edi, dword [TileRightRow]
        sub edx, ecx
        inc edi
        mov dword [TileRightStep], edx
        mov dword [TileRightRow], edi
.10:
        test byte [TileRightFlags], 1
        je short .11
        fld dword [TileRightDu]
        fadd dword [TileRightUf]
        mov eax, dword [TileRowCount]
        fst dword [TileRightUf]
        fmul dword [nosplit eax*4+IceShadeScale]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [TileRightX], eax
.11:
        test byte [TileRightFlags], 2
        je near .6
        fld dword [TileRightDv]
        fadd dword [TileRightVf]
        mov eax, dword [TileRowCount]
        fst dword [TileRightVf]
        fmul dword [nosplit eax*4+IceShadeScale]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [TileRightU], eax
        jmp near .6
