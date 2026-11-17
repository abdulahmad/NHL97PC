; 3D library: DrawEllipseSpans.
bits 32
%include "hockey.inc"
section s_10C432 progbits alloc exec nowrite align=1
extern ClipBottomEdge, ClipLeft, ClipLineX, ClipLineY, ClipRightEdge, ClipTop, DrawLineX, DrawLineXPlot
extern DrawLineY, DrawLineYPlot, EllipseRadiusX, EllipseRadiusY, LineClipMaxX, LineClipMaxY, LineColor, LineDeltaX
extern LineDeltaY, LineEndX, LineEndY, LineErrStepX, LineErrStepY, LineErrX, LineErrY, LinePattern
extern LineSteep, LineStepX, LineStepY, LineX, LineY, SetClipWindow, ViewOriginY, ViewWidth
global DrawEllipseSpans
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawEllipseSpans                               10C434  97 PC, low confidence
; Draws the spans of a filled ellipse on the rink
;-----------------------------------------------------------------------------
DrawEllipseSpans:
        push ebx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        mov esi, dword [byte ebp+018h]
        mov ecx, dword [byte ebp+01Ch]
        mov ebx, dword [byte ebp+020h]
        mov edx, dword [byte ebp+024h]
        xor edi, edi
        mov eax, ecx
        mov dword [byte ebp-08h], edi
        mov edi, dword [byte ebp+014h]
        sub eax, edi
        mov dword [LineDeltaX], eax
        mov eax, ebx
        sub eax, esi
        mov dword [LineDeltaY], eax
        mov eax, dword [LineDeltaX]
        test eax, eax
        jg short .1
        neg eax
.1:
        cmp eax, 10000h
        jge short .4
        mov edi, dword [LineDeltaY]
        test edi, edi
        jle short .2
        mov eax, edi
        jmp short .3
.2:
        mov eax, edi
        neg eax
.3:
        cmp eax, 10000h
        jl near .28
.4:
        mov al, byte [edx]
        add edx, byte 4
        mov byte [LinePattern], al
        mov eax, dword [LineDeltaY]
        mov dword [LineColor], edx
        test eax, eax
        jg short .5
        neg eax
.5:
        mov edx, dword [LineDeltaX]
        test edx, edx
        jle short .6
        mov edi, edx
        jmp short .7
.6:
        mov edi, edx
        neg edi
.7:
        mov edx, dword [byte ebp+02Ch]
        sub edx, dword [byte ebp+028h]
        cmp eax, edi
        jle near .20
        mov edi, dword [LineDeltaY]
        mov eax, edx
        sar edx, 1Fh
        sar edi, 10h
        idiv edi
        mov edi, eax
        cmp dword [LineDeltaY], byte 0
        jge short .9
        mov dword [LineStepY], ebx
        mov ebx, dword [byte ebp+030h]
        mov dword [LineClipMaxY], esi
        test ebx, ebx
        je short .8
        mov edx, dword [byte ebp+02Ch]
        mov ebx, edi
        mov dword [LineY], ecx
        mov eax, ecx
        mov dword [LineErrY], edi
        neg ebx
        xor ecx, ecx
        sub eax, edx
        mov dword [LineErrY], ebx
        mov dword [LineErrStepY], ecx
        mov dword [LineEndY], eax
        jmp near .18
.8:
        mov eax, dword [byte ebp+02Ch]
        mov dword [LineErrY], ebx
        mov dword [LineErrStepY], edi
        add eax, ecx
        mov dword [LineEndY], ecx
        jmp near .17
.9:
        cmp dword [EllipseRadiusY], byte 0
        jne short .10
        cmp dword [EllipseRadiusX], byte 0
        je near .15
.10:
        mov eax, dword [ClipBottomEdge]
        sar eax, 10h
        mov dword [byte ebp-04h], eax
        mov eax, dword [ClipTop]
        sar eax, 10h
        mov dword [byte ebp-0Ch], eax
        mov dword [byte ebp-08h], 1
        cmp esi, ebx
        jle short .12
        mov eax, esi
        mov ecx, dword [byte ebp-04h]
        sar eax, 10h
        cmp eax, ecx
        jle short .11
        mov eax, ecx
.11:
        mov edx, dword [ClipTop]
        push eax
        mov eax, ebx
        sar edx, 10h
        sar eax, 10h
        cmp edx, eax
        jle short .14
        mov eax, edx
        jmp short .14
.12:
        mov eax, ebx
        mov edx, dword [byte ebp-04h]
        sar eax, 10h
        cmp eax, edx
        jle short .13
        mov eax, edx
.13:
        push eax
        mov edx, esi
        mov eax, dword [ClipTop]
        sar edx, 10h
        sar eax, 10h
        cmp eax, edx
        jg short .14
        mov eax, edx
.14:
        push eax
        mov eax, dword [ClipRightEdge]
        sar eax, 10h
        push eax
        mov eax, dword [ClipLeft]
        sar eax, 10h
        push eax
        call SetClipWindow
        add esp, byte 10h
        mov eax, dword [ClipTop]
        sar eax, 10h
        shl eax, 10h
        mov dword [ViewWidth], eax
        mov eax, dword [ClipBottomEdge]
        sar eax, 10h
        shl eax, 10h
        mov dword [ViewOriginY], eax
.15:
        mov dword [LineStepY], esi
        mov esi, dword [byte ebp+030h]
        mov dword [LineClipMaxY], ebx
        test esi, esi
        je short .16
        mov eax, dword [byte ebp+014h]
        mov edx, dword [byte ebp+028h]
        mov dword [LineErrStepY], edi
        xor esi, esi
        mov dword [LineEndY], eax
        add eax, edx
        mov dword [LineErrY], esi
        jmp short .17
.16:
        mov eax, dword [byte ebp+014h]
        mov edx, dword [byte ebp+028h]
        mov dword [LineErrY], edi
        mov ebx, edi
        mov dword [LineErrStepY], esi
        sub eax, edx
        neg ebx
        mov dword [LineEndY], eax
        mov eax, dword [byte ebp+014h]
        mov dword [LineErrY], ebx
.17:
        mov dword [LineY], eax
.18:
        mov eax, dword [LineDeltaX]
        mov ebx, dword [LineDeltaY]
        mov edx, eax
        sar ebx, 10h
        sar edx, 1Fh
        idiv ebx
        mov esi, 10000h
        mov edi, dword [LineErrY]
        mov dword [LineDeltaY], esi
        mov edx, dword [LineErrStepY]
        mov dword [LineDeltaX], eax
        add edi, eax
        add edx, eax
        mov dword [LineErrY], edi
        mov dword [LineErrStepY], edx
        call ClipLineY
        test eax, eax
        jle near .27
        cmp dword [LineSteep], byte 0
        je short .19
        call DrawLineYPlot
.19:
        mov ecx, dword [LineClipMaxY]
        cmp ecx, dword [LineStepY]
        jle near .27
        call DrawLineY
        mov eax, dword [LineStepY]
        cmp eax, dword [LineClipMaxY]
        jge near .27
        call DrawLineYPlot
        jmp near .27
.20:
        mov edi, dword [LineDeltaX]
        mov eax, edx
        sar edx, 1Fh
        sar edi, 10h
        idiv edi
        cmp dword [LineDeltaX], byte 0
        jge short .22
        mov edx, dword [byte ebp+014h]
        mov dword [LineClipMaxX], edx
        mov edx, dword [byte ebp+030h]
        mov dword [LineX], ecx
        test edx, edx
        je short .21
        xor edx, edx
        mov dword [LineErrStepX], edx
        mov edx, dword [byte ebp+02Ch]
        mov dword [LineErrX], eax
        add edx, ebx
        mov dword [LineStepX], ebx
        jmp near .24
.21:
        mov ecx, dword [byte ebp+02Ch]
        mov esi, eax
        mov edx, ebx
        mov dword [LineErrStepX], eax
        mov dword [LineEndX], ebx
        xor edi, edi
        neg esi
        mov dword [LineErrX], edi
        sub edx, ecx
        mov dword [LineErrStepX], esi
        mov dword [LineStepX], edx
        jmp short .25
.22:
        mov edx, dword [byte ebp+014h]
        mov dword [LineX], edx
        mov edx, dword [byte ebp+030h]
        mov dword [LineClipMaxX], ecx
        test edx, edx
        je short .23
        mov ecx, dword [byte ebp+028h]
        mov dword [LineErrStepX], eax
        mov edi, eax
        mov edx, esi
        mov dword [LineEndX], esi
        neg edi
        xor eax, eax
        sub edx, ecx
        mov dword [LineErrStepX], edi
        mov dword [LineErrX], eax
        mov dword [LineStepX], edx
        jmp short .25
.23:
        mov dword [LineErrStepX], edx
        mov edx, dword [byte ebp+028h]
        mov dword [LineErrX], eax
        add edx, esi
        mov dword [LineStepX], esi
.24:
        mov dword [LineEndX], edx
.25:
        mov eax, dword [LineDeltaY]
        mov ebx, dword [LineDeltaX]
        mov edx, eax
        sar ebx, 10h
        sar edx, 1Fh
        idiv ebx
        mov esi, 10000h
        mov ecx, dword [LineErrX]
        mov dword [LineDeltaX], esi
        mov ebx, dword [LineErrStepX]
        mov dword [LineDeltaY], eax
        add ecx, eax
        add ebx, eax
        mov dword [LineErrX], ecx
        mov dword [LineErrStepX], ebx
        call ClipLineX
        test eax, eax
        jle short .27
        cmp dword [LineSteep], byte 0
        je short .26
        call DrawLineXPlot
.26:
        mov edx, dword [LineClipMaxX]
        cmp edx, dword [LineX]
        jle short .27
        call DrawLineX
        mov eax, dword [LineX]
        cmp eax, dword [LineClipMaxX]
        jge short .27
        call DrawLineXPlot
.27:
        cmp dword [byte ebp-08h], byte 0
        je short .28
        mov eax, dword [byte ebp-04h]
        push eax
        mov edx, dword [byte ebp-0Ch]
        mov eax, dword [ClipRightEdge]
        push edx
        sar eax, 10h
        push eax
        mov eax, dword [ClipLeft]
        sar eax, 10h
        push eax
        call SetClipWindow
        mov eax, dword [ClipTop]
        sar eax, 10h
        shl eax, 10h
        xor ebx, ebx
        mov dword [ViewWidth], eax
        mov eax, dword [ClipBottomEdge]
        add esp, byte 10h
        sar eax, 10h
        mov dword [EllipseRadiusX], ebx
        shl eax, 10h
        mov dword [EllipseRadiusY], ebx
        mov dword [ViewOriginY], eax
.28:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
        mov eax, dword [byte esp+04h]
        mov dword [EllipseRadiusY], eax
        mov eax, dword [byte esp+08h]
        mov dword [EllipseRadiusX], eax
        ret
        db 00h,00h,00h,00h,00h
