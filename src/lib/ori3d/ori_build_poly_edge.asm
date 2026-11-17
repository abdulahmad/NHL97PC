; 3D library: BuildPolyEdge, FillPolySpans, FillPolygon, FillPolygonPoints.
bits 32
%include "hockey.inc"
section s_FD6C1 progbits alloc exec nowrite align=1
extern ClipLeftCol, ClipPolyBottom, ClipPolyLeft, ClipPolyRight, ClipPolyTop, ClipRight, ClipTopRow, DrawDestBuffer
extern DrawDestPitch, FillMemFast, PolyRowCount, PolySpanEdges, PolyTopRow, ReciprocalTable, RemapPixels, ScreenHeight
extern ScreenWidth
global BuildPolyEdge, FillPolySpans, FillPolygon, FillPolygonPoints
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; BuildPolyEdge                                   FD6D0  97 PC, low confidence
; Steps one polygon edge and records its x at each row
;-----------------------------------------------------------------------------
BuildPolyEdge:
        push ebx
        push esi
        push edi
        push ebp
        mov ebx, dword [byte esp+014h]
        mov esi, dword [byte esp+018h]
        mov eax, dword [byte esp+01Ch]
        mov ecx, dword [byte esp+020h]
        lea edx, [nosplit eax*8+00h]
        lea edi, [esi+edx]
        mov edx, dword [byte esi+ecx*8+04h]
        sub edx, dword [byte edi+04h]
        je short .2
        test edx, edx
        jge short .1
        xor eax, ecx
        mov dword [byte ebx+010h], edx
        xor ecx, eax
        neg edx
        xor eax, ecx
.1:
        mov dword [byte ebx+010h], edx
        shl ecx, 3
        shl eax, 3
        lea edi, [esi+ecx]
        lea ecx, [esi+eax]
        mov eax, dword [edi]
        mov esi, dword [ecx]
        sub eax, esi
        mov esi, eax
        mov eax, dword [byte ecx+04h]
        mov edi, dword [DrawDestBuffer]
        shl eax, 2
        add eax, edi
        mov edi, dword [DrawDestPitch]
        mov ebp, dword [eax]
        mov eax, dword [ecx]
        add edi, ebp
        add edi, eax
        mov eax, esi
        mov dword [byte ebx+08h], 0
        shl eax, 10h
        mov dword [ebx], edi
        shl eax, 2
        imul dword [nosplit edx*4+ReciprocalTable]
        mov dword [byte ebx+0Ch], edx
        mov eax, dword [ScreenWidth]
        sar edx, 10h
        add edx, eax
        mov dword [byte ebx+04h], edx
.2:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FillPolySpans                                   FD768  97 PC, low confidence
; Fills or shades the row spans between a polygon's left and right edges
;-----------------------------------------------------------------------------
FillPolySpans:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov edi, dword [byte esp+028h]
        mov ebp, dword [byte esp+02Ch]
        cmp dword [byte esp+034h], byte 0
        je short .1
        mov eax, esp
        mov dword [byte esp+0Ch], eax
        lea eax, [byte esp+04h]
        jmp short .2
.1:
        lea eax, [byte esp+04h]
        mov dword [byte esp+0Ch], eax
        mov eax, esp
.2:
        mov dword [byte esp+010h], eax
        lea eax, [nosplit edi*4+00h]
        add eax, edi
        mov edx, PolySpanEdges
        shl eax, 2
        add edx, eax
        mov eax, dword [byte esp+0Ch]
        mov dword [eax], edx
        lea eax, [nosplit ebp*4+00h]
        add eax, ebp
        mov edx, PolySpanEdges
        shl eax, 2
        add edx, eax
        mov eax, dword [byte esp+010h]
        mov dword [eax], edx
        mov eax, dword [byte esp+030h]
        dec eax
        mov dword [byte esp+08h], eax
.3:
        mov eax, dword [byte esp+0Ch]
        mov eax, dword [eax]
        cmp dword [byte eax+010h], byte 0
        jg short .6
        dec edi
        test edi, edi
        jge short .4
        mov edi, dword [byte esp+08h]
        imul eax, edi, byte 14h
        mov ebx, PolySpanEdges
        mov edx, dword [byte esp+0Ch]
        add ebx, eax
        mov dword [edx], ebx
        jmp short .5
.4:
        mov edx, dword [byte esp+0Ch]
        sub eax, byte 14h
        mov dword [edx], eax
.5:
        cmp edi, ebp
        je near .15
        jmp short .3
.6:
        mov edx, dword [byte esp+030h]
.7:
        mov esi, dword [byte esp+010h]
        mov esi, dword [esi]
        cmp dword [byte esi+010h], byte 0
        jg short .9
        inc ebp
        cmp ebp, edx
        jl short .8
        mov eax, dword [byte esp+010h]
        xor ebp, ebp
        mov dword [eax], PolySpanEdges
        jmp short .7
.8:
        mov eax, dword [byte esp+010h]
        add esi, byte 14h
        mov dword [eax], esi
        jmp short .7
.9:
        mov eax, dword [esp]
        mov edx, dword [byte eax+010h]
        mov eax, dword [byte esp+04h]
        mov ebx, dword [byte eax+010h]
        cmp edx, ebx
        jge short .10
        mov eax, dword [esp]
        mov eax, dword [byte eax+010h]
        jmp short .11
.10:
        mov eax, ebx
.11:
        mov edx, dword [esp]
        sub dword [byte edx+010h], eax
        mov edx, dword [byte esp+04h]
        mov ebx, dword [byte edx+010h]
        mov esi, eax
        sub ebx, eax
        mov ecx, dword [byte esp+038h]
        mov dword [byte edx+010h], ebx
        test ecx, ecx
        jne short .13
.12:
        test esi, esi
        je near .3
        mov eax, dword [byte esp+04h]
        mov edx, dword [esp]
        mov eax, dword [eax]
        mov edx, dword [edx]
        sub edx, eax
        mov ebx, PolyTopRow
        inc edx
        call FillMemFast
        mov edx, dword [byte esp+04h]
        mov ebx, dword [byte esp+04h]
        mov eax, dword [byte esp+04h]
        mov ecx, dword [byte esp+04h]
        mov edx, dword [byte edx+04h]
        mov ebx, dword [byte ebx+0Ch]
        mov eax, dword [byte eax+08h]
        add ax, bx
        adc dword [ecx], edx
        mov edx, dword [byte esp+04h]
        mov dword [byte edx+08h], eax
        mov edx, dword [esp]
        mov ebx, dword [esp]
        mov eax, dword [esp]
        mov ecx, dword [esp]
        mov edx, dword [byte edx+04h]
        mov ebx, dword [byte ebx+0Ch]
        mov eax, dword [byte eax+08h]
        add ax, bx
        adc dword [ecx], edx
        mov edx, dword [esp]
        dec esi
        mov dword [byte edx+08h], eax
        jmp short .12
.13:
        cmp ecx, byte 1
        jne near .3
.14:
        test esi, esi
        je near .3
        mov eax, dword [esp]
        mov edx, dword [byte esp+04h]
        mov eax, dword [eax]
        mov ebx, dword [edx]
        sub eax, ebx
        push eax
        push ebx
        call RemapPixels
        add esp, byte 8
        mov edx, dword [byte esp+04h]
        mov ebx, dword [byte esp+04h]
        mov eax, dword [byte esp+04h]
        mov ecx, dword [byte esp+04h]
        mov edx, dword [byte edx+04h]
        mov ebx, dword [byte ebx+0Ch]
        mov eax, dword [byte eax+08h]
        add ax, bx
        adc dword [ecx], edx
        mov edx, dword [byte esp+04h]
        mov dword [byte edx+08h], eax
        mov edx, dword [esp]
        mov ebx, dword [esp]
        mov eax, dword [esp]
        mov ecx, dword [esp]
        mov edx, dword [byte edx+04h]
        mov ebx, dword [byte ebx+0Ch]
        mov eax, dword [byte eax+08h]
        add ax, bx
        adc dword [ecx], edx
        mov edx, dword [esp]
        dec esi
        mov dword [byte edx+08h], eax
        jmp short .14
.15:
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FillPolygon                                     FD954  97 PC, low confidence
; Fills a flat-coloured polygon given its points
;-----------------------------------------------------------------------------
FillPolygon:
        push ebx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 18h
        mov edi, dword [byte ebp+018h]
        mov eax, dword [byte ebp+01Ch]
        mov eax, dword [eax]
        xor edx, edx
        mov dword [byte ebp-0Ch], eax
        mov dword [byte ebp-014h], eax
        mov eax, dword [byte ebp+01Ch]
        mov ebx, 1
        mov dword [byte ebp-04h], edx
        mov eax, dword [byte eax+04h]
        mov dword [byte ebp-018h], edx
        mov dword [byte ebp-08h], eax
        mov dword [byte ebp-010h], eax
        cmp edi, ebx
        jle short .6
        mov eax, dword [byte ebp+01Ch]
        add eax, byte 8
.1:
        mov ecx, dword [byte ebp-010h]
        mov edx, dword [byte eax+04h]
        cmp edx, ecx
        jge short .2
        mov dword [byte ebp-04h], ebx
        mov dword [byte ebp-010h], edx
        jmp short .3
.2:
        cmp edx, dword [byte ebp-08h]
        jle short .3
        mov dword [byte ebp-08h], edx
.3:
        mov ecx, dword [byte ebp-014h]
        mov edx, dword [eax]
        cmp edx, ecx
        jge short .4
        mov dword [byte ebp-014h], edx
        jmp short .5
.4:
        cmp edx, dword [byte ebp-0Ch]
        jle short .5
        mov dword [byte ebp-0Ch], edx
.5:
        inc ebx
        add eax, byte 8
        cmp ebx, edi
        jl short .1
.6:
        cmp dword [byte ebp+020h], byte 0
        jne short .7
        mov esi, dword [byte ebp+01Ch]
        mov eax, dword [byte esi+010h]
        mov ebx, dword [byte esi+014h]
        mov ecx, dword [esi]
        mov edx, dword [byte esi+04h]
        sub eax, dword [byte esi+08h]
        sub ebx, dword [byte esi+0Ch]
        sub ecx, dword [byte esi+08h]
        sub edx, dword [byte esi+0Ch]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [byte ebp+020h], ebx
.7:
        mov eax, dword [byte ebp-014h]
        mov esi, dword [ClipTopRow]
        cmp eax, esi
        jge short .10
        cmp esi, dword [byte ebp-0Ch]
        jle short .8
        xor eax, eax
        jmp near .28
.8:
        lea eax, [byte ebp+01Ch]
        push eax
        push edi
        call ClipPolyLeft
        add esp, byte 8
        mov edi, eax
        cmp eax, byte 3
        jge short .9
        xor eax, eax
        jmp near .28
.9:
        mov dword [byte ebp-018h], 1
.10:
        mov eax, dword [ClipRight]
        mov ecx, dword [byte ebp-0Ch]
        dec eax
        cmp eax, ecx
        jg short .13
        mov eax, dword [byte ebp-014h]
        cmp eax, dword [ClipRight]
        jl short .11
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.11:
        lea eax, [byte ebp+01Ch]
        push eax
        push edi
        call ClipPolyRight
        add esp, byte 8
        mov edi, eax
        cmp eax, byte 3
        jge short .12
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.12:
        mov dword [byte ebp-018h], 1
.13:
        mov eax, dword [byte ebp-010h]
        mov edx, dword [ClipLeftCol]
        cmp eax, edx
        jge short .16
        cmp edx, dword [byte ebp-08h]
        jle short .14
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.14:
        lea eax, [byte ebp+01Ch]
        push eax
        push edi
        call ClipPolyTop
        add esp, byte 8
        mov edi, eax
        cmp eax, byte 3
        jge short .15
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.15:
        mov dword [byte ebp-018h], 1
.16:
        mov eax, dword [byte ebp-08h]
        mov esi, dword [ScreenHeight]
        cmp eax, esi
        jl short .19
        cmp esi, dword [byte ebp-010h]
        jg short .17
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.17:
        lea eax, [byte ebp+01Ch]
        push eax
        push edi
        call ClipPolyBottom
        add esp, byte 8
        mov edi, eax
        cmp eax, byte 3
        jge short .18
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.18:
        mov dword [byte ebp-018h], 1
.19:
        cmp dword [byte ebp-018h], byte 0
        je short .23
        xor esi, esi
        mov dword [byte ebp-04h], esi
        mov esi, dword [byte ebp+01Ch]
        mov esi, dword [byte esi+04h]
        mov ebx, 1
        mov edx, esi
        cmp edi, ebx
        jle short .23
        mov eax, dword [byte ebp+01Ch]
        add eax, byte 8
.20:
        mov ecx, dword [byte eax+04h]
        cmp esi, ecx
        jle short .21
        mov dword [byte ebp-04h], ebx
        mov esi, ecx
        jmp short .22
.21:
        cmp edx, ecx
        jge short .22
        mov edx, ecx
.22:
        inc ebx
        add eax, byte 8
        cmp ebx, edi
        jl short .20
.23:
        cmp dword [byte ebp+024h], byte 0
        jne short .24
        mov eax, dword [byte ebp+014h]
        and eax, 0FFh
        mov dword [byte ebp+014h], eax
        mov edx, dword [byte ebp+014h]
        shl eax, 8
        or edx, eax
        mov eax, edx
        shl eax, 10h
        mov dword [PolyTopRow], edx
        or edx, eax
        mov dword [PolyTopRow], edx
        mov dword [PolyRowCount], edx
.24:
        lea eax, [byte edi-01h]
        xor ebx, ebx
        test edi, edi
        jle short .26
        mov esi, PolySpanEdges
.25:
        push eax
        push ebx
        mov ecx, dword [byte ebp+01Ch]
        push ecx
        push esi
        call BuildPolyEdge
        add esp, byte 10h
        mov eax, ebx
        inc ebx
        add esi, byte 14h
        cmp ebx, edi
        jl short .25
.26:
        mov ebx, dword [byte ebp-04h]
        lea eax, [byte ebx+01h]
        cmp eax, edi
        jl short .27
        xor eax, eax
.27:
        mov esi, dword [byte ebp+024h]
        mov ecx, dword [byte ebp+020h]
        push esi
        test ecx, ecx
        setg dl
        and edx, 0FFh
        push edx
        push edi
        push eax
        push ebx
        call FillPolySpans
        mov eax, 1
        add esp, byte 14h
.28:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        push ebx
        push esi
        push edi
        sub esp, byte 50h
        mov ecx, dword [byte esp+064h]
        test ecx, ecx
        jle short .30
        mov edx, dword [byte esp+068h]
        lea ebx, [nosplit ecx*8+00h]
        xor eax, eax
.29:
        mov esi, dword [edx]
        lea edi, [esp+eax]
        add eax, byte 8
        add edx, byte 4
        movsd
        movsd
        cmp eax, ebx
        jl short .29
.30:
        mov edx, dword [byte esp+070h]
        push edx
        mov ebx, dword [byte esp+070h]
        push ebx
        lea eax, [byte esp+08h]
        push eax
        push ecx
        mov ecx, dword [byte esp+070h]
        push ecx
        call FillPolygon
        add esp, byte 14h
        add esp, byte 50h
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FillPolygonPoints                               FDC0C  97 PC, low confidence
; Copies a list of points and fills them as one polygon
;-----------------------------------------------------------------------------
FillPolygonPoints:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 50h
        mov ebp, dword [byte esp+068h]
        mov ecx, dword [byte esp+06Ch]
        test ebp, ebp
        jle short .2
        mov edx, dword [byte esp+070h]
        lea ebx, [nosplit ebp*8+00h]
        xor eax, eax
.1:
        mov esi, dword [edx]
        shl esi, 3
        lea edi, [esp+eax]
        add esi, ecx
        add eax, byte 8
        add edx, byte 4
        movsd
        movsd
        cmp eax, ebx
        jl short .1
.2:
        mov edx, dword [byte esp+078h]
        push edx
        mov ebx, dword [byte esp+078h]
        push ebx
        lea eax, [byte esp+08h]
        push eax
        push ebp
        mov ecx, dword [byte esp+074h]
        push ecx
        call FillPolygon
        add esp, byte 14h
        add esp, byte 50h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
