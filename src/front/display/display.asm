; Display: dirty spans, overlay rows, video modes, display views and overlay windows.
bits 32
%include "hockey.inc"
section s_3B75B progbits alloc exec nowrite align=1
extern AllocGfxFixBuffer, AllocMemBlock, BlitFrameToScreen, BuildRinkPalette, ClearScreen, CopyMemFpu, CreateBitmap, DirtySpanCount
extern DirtySpans, DisplayViewCount, DisplayViewRecords, DisplayViews, DrawDestBuffer, DrawDestPitch, F32_ViewAngle, F64_0p5_SetViewDrawTarget
extern FillMem, FillRectColor, FreeBitmap, FreeMemBlock, FreeVideoBuffer, GameViewBuffer, GameViewPitch, GameViewRows
extern GameViewShown, GameViewTop, GetPaletteEntries, MakeColor, MarkPaletteDirty, OverlayMask, OverlayMaskBase, OverlayMaskDirty
extern OverlayRowCount, OverlayRowMask, OverlayWindowCount, OverlayWindowFlags, OverlayWindows, OverlayWindowsOpen, PresentScreen, RemapTable
extern removewindow, ReplayPlaying, RinkDetail, RinkPalette, ScreenRegion, SetDrawTarget, SetFocalLength, SetGraphicsMode
extern SetProjectionCenter, SetRemapTable, SetScreenTarget, SetTextColors, SpanSlotNext, SpanSlotStart, SpanSlotTable, str_DMAN
extern VesaSetBank, VideoModeIndex, VideoModeNumber, ViewAspect, ViewBorderColor, ViewBorderRows, ViewInterlaced, ViewPixelHeight
extern ViewPixelWidth, ViewScreenHeight, ViewScreenWidth, ViewSizeChanged, ViewSizeIndex, WritePaletteRegs
global DrawFrameNoop, AddDirtySpans, InsertSpanSlot, RemoveSpanSlot, MergeDirtySpans, RebuildOverlayMask, BlendOverlayRow, ShadeOverlayRow
global DrawOverlayRows, SetVideoMode, InitDisplayViews, FreeDisplayViews, AddDisplayView, SetViewDrawTarget, SetViewSize, SetViewInterlaced
global ClearViewInterlaced, HideView, ShowView, SetViewOrigin, ClearViewBorders, PresentGameView, AddOverlayWindow, RemoveOverlayWindow
global UpdateScreenRegion, RefreshOverlayWindow, SetRinkDetail
;-----------------------------------------------------------------------------
; DrawFrameNoop                                   3B75B  97 PC, low confidence
; Empty step of the game frame drawing
;-----------------------------------------------------------------------------
DrawFrameNoop:
        ret
        db 00h,00h,00h,00h
;-----------------------------------------------------------------------------
; AddDirtySpans                                   3B760  97 PC, low confidence
; Adds the row spans of an overlay window to the list of screen spans to
; redraw
;-----------------------------------------------------------------------------
AddDirtySpans:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov edi, eax
        mov ebx, edx
        lea ebp, [byte eax+010h]
        mov edx, dword [DirtySpanCount]
        mov eax, dword [byte eax+04h]
        mov ecx, dword [DirtySpanCount]
        sar eax, 10h
        shl edx, 2
        add eax, ecx
        add edx, DirtySpans
        cmp eax, 1F4h
        jle short .1
        mov eax, 1
        jmp near .16
.1:
        mov dword [DirtySpanCount], eax
        test ebx, ebx
        je near .12
        xor esi, esi
        mov dword [esp], esi
        jmp near .11
.2:
        cmp byte [ebx], 0FFh
        jne short .4
        inc eax
        inc ebx
.3:
        mov esi, dword [byte edi+02h]
        sar esi, 10h
        cmp eax, esi
        jl short .2
.4:
        mov ebx, dword [byte edi+02h]
        sar ebx, 10h
        cmp ebx, eax
        jle short .6
        lea esi, [ebx+ebp]
.5:
        cmp byte [byte esi-01h], 0FFh
        jne short .6
        dec ebx
        dec esi
        cmp ebx, eax
        jg short .5
.6:
        mov cx, word [edx]
        xor cl, cl
        and ch, 0FCh
        mov esi, eax
        mov word [edx], cx
        and esi, 3FFh
        mov ecx, dword [edx]
        or ecx, esi
        mov esi, ebx
        sub esi, eax
        mov dword [edx], ecx
        and esi, 3FFh
        and ecx, 0FFF003FFh
        shl esi, 0Ah
        mov dword [edx], ecx
        or ecx, esi
        mov dword [edx], ecx
        and byte [byte edx+02h], 0CFh
        cmp eax, ebx
        jge short .10
        lea esi, [eax+ebp]
.7:
        cmp byte [esi], 0FEh
        jne short .8
        or byte [byte edx+02h], 20h
.8:
        cmp byte [esi], 0FFh
        jne short .9
        or byte [byte edx+02h], 10h
.9:
        inc eax
        inc esi
        cmp eax, ebx
        jl short .7
.10:
        mov esi, dword [esp]
        add edx, byte 4
        mov eax, dword [byte edi+02h]
        inc esi
        sar eax, 10h
        mov dword [esp], esi
        add ebp, eax
.11:
        mov eax, dword [byte edi+04h]
        mov esi, dword [esp]
        sar eax, 10h
        cmp eax, esi
        jle short .15
        mov ebx, ebp
        xor eax, eax
        jmp near .3
.12:
        xor eax, eax
        jmp short .14
.13:
        mov bx, word [edx]
        xor bl, bl
        and bh, 0FCh
        mov word [edx], bx
        mov ebx, dword [byte edi+02h]
        mov ebp, dword [edx]
        sar ebx, 10h
        and ebp, 0FFF003FFh
        and ebx, 3FFh
        mov ecx, ebp
        shl ebx, 0Ah
        mov dword [edx], ebp
        or ecx, ebx
        mov dword [edx], ecx
        mov bl, byte [byte edx+02h]
        add edx, byte 4
        and bl, 0CFh
        inc eax
        mov byte [byte edx-02h], bl
.14:
        mov ebx, dword [byte edi+04h]
        sar ebx, 10h
        cmp eax, ebx
        jl short .13
.15:
        xor eax, eax
.16:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; InsertSpanSlot                                  3B8AC  97 PC, low confidence
; Opens a slot in the span list by moving the later entries up
;-----------------------------------------------------------------------------
InsertSpanSlot:
        push ecx
        push esi
        push edi
        mov edi, eax
        mov ecx, edx
        mov edx, ebx
        cmp ebx, ecx
        jle short .2
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        shl eax, 2
        sub eax, byte 0Ch
        add eax, edi
.1:
        mov esi, eax
        lea edi, [byte eax+0Ch]
        dec edx
        sub eax, byte 0Ch
        movsd
        movsd
        movsd
        cmp edx, ecx
        jg short .1
.2:
        cmp ebx, ecx
        jle short .4
        shl ecx, 2
        lea eax, [nosplit ebx*4+00h]
.3:
        sub eax, byte 4
        mov edx, dword [dword eax+SpanSlotStart]
        mov dword [dword eax+SpanSlotTable], edx
        cmp eax, ecx
        jg short .3
.4:
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; RemoveSpanSlot                                  3B900  97 PC, low confidence
; Closes a slot in the span list by moving the later entries down
;-----------------------------------------------------------------------------
RemoveSpanSlot:
        push ecx
        push esi
        push edi
        mov edi, eax
        mov ecx, edx
        cmp edx, ebx
        jge short .2
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 2
        add eax, byte 0Ch
        add eax, edi
.1:
        mov esi, eax
        lea edi, [byte eax-0Ch]
        inc edx
        add eax, byte 0Ch
        movsd
        movsd
        movsd
        cmp edx, ebx
        jl short .1
.2:
        cmp ecx, ebx
        jge short .4
        shl ebx, 2
        lea eax, [nosplit ecx*4+00h]
.3:
        add eax, byte 4
        mov edx, dword [dword eax+SpanSlotStart]
        mov dword [dword eax+SpanSlotNext], edx
        cmp eax, ebx
        jl short .3
.4:
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; MergeDirtySpans                                 3B954  97 PC, low confidence
; Merges a row's spans into the dirty span list, splitting and joining runs
;-----------------------------------------------------------------------------
MergeDirtySpans:
        push esi
        push edi
        push ebp
        sub esp, byte 20h
        mov esi, eax
        mov edi, edx
        mov eax, dword [byte esp+030h]
        mov edx, dword [byte esp+03Ch]
        mov ebp, dword [edx]
        test ebp, 0FFC00h
        jne short .1
        mov edx, edi
        jmp near .23
.1:
        mov edx, ebp
        and edx, 3FFh
        mov dword [byte esp+0Ch], edx
        add eax, edx
        mov edx, dword [byte esp+03Ch]
        mov edx, dword [edx]
        shl edx, 0Ch
        shr edx, 16h
        lea ebp, [eax+edx]
        mov dword [byte esp+04h], ebp
        cmp ebx, ebp
        jbe short .2
        mov edx, edi
        mov eax, edx
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        ret 10h
.2:
        cmp ecx, eax
        jg short .3
        mov edx, edi
        mov eax, edx
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        ret 10h
.3:
        mov ebp, dword [byte esp+0Ch]
        mov dword [byte esp+014h], edx
        add dword [byte esp+038h], ebp
        mov ebp, dword [byte esp+04h]
        mov dword [byte esp+01Ch], eax
        mov dword [byte esp+018h], ebp
        cmp eax, ebx
        jge short .4
        mov ebp, ebx
        sub ebp, eax
        mov dword [byte esp+01Ch], ebx
        mov eax, ebp
        mov ebp, dword [byte esp+038h]
        sub edx, eax
        add ebp, eax
        mov dword [byte esp+014h], edx
        mov dword [byte esp+038h], ebp
.4:
        mov eax, dword [byte esp+018h]
        cmp ecx, eax
        jge short .5
        mov edx, dword [byte esp+014h]
        sub eax, ecx
        sub edx, eax
        mov dword [byte esp+018h], ecx
        mov dword [byte esp+014h], edx
.5:
        mov ebx, dword [byte esp+034h]
        test ebx, ebx
        je near .10
        lea eax, [byte edi+01h]
        mov ecx, dword [byte esp+014h]
        mov dword [byte esp+010h], eax
        mov eax, ebx
        and ecx, 3FFh
        and eax, 0FFh
        shl ecx, 8
        mov dword [byte esp+08h], eax
        test edi, edi
        jne short .6
        mov byte [byte esi+08h], 0
        or dword [byte esi+08h], eax
        mov ebx, dword [byte esi+08h]
        and ebx, 0FFFC00FFh
        mov edi, ebx
        mov dword [byte esi+08h], ebx
        or edi, ecx
        mov dword [byte esi+08h], edi
        mov eax, dword [byte esp+01Ch]
        mov dl, byte [byte esi+0Ah]
        mov dword [byte esi+04h], eax
        and dl, 83h
        mov eax, dword [byte esp+038h]
        mov byte [byte esi+0Ah], dl
        mov dh, dl
        mov dword [esi], eax
        or dh, 18h
        mov byte [byte esi+0Ah], dh
        mov edx, 1
        mov eax, edx
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        ret 10h
.6:
        mov eax, dword [byte esp+01Ch]
        cmp eax, dword [byte esi+04h]
        jae near .8
        mov ebx, edi
        mov eax, esi
        xor edx, edx
        call InsertSpanSlot
        mov byte [byte esi+08h], 0
        mov eax, dword [byte esp+08h]
        mov edx, dword [byte esi+08h]
        or edx, eax
        mov eax, dword [byte esp+01Ch]
        mov dword [byte esi+08h], edx
        mov dword [byte esi+04h], eax
        mov eax, dword [byte esp+038h]
        mov dword [esi], eax
        mov ah, byte [byte esi+0Ah]
        mov edi, dword [byte esp+010h]
        and ah, 83h
        mov ebx, dword [byte esi+010h]
        mov dl, ah
        mov byte [byte esi+0Ah], ah
        or dl, 18h
        mov eax, dword [byte esp+018h]
        mov byte [byte esi+0Ah], dl
        cmp eax, ebx
        ja short .7
        mov edi, dword [byte esi+08h]
        and edi, 0FFFC00FFh
        mov ebp, edi
        mov dword [byte esi+08h], edi
        or ebp, ecx
        mov edx, dword [byte esp+010h]
        mov dword [byte esi+08h], ebp
        mov eax, edx
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        ret 10h
.7:
        mov ecx, dword [byte esp+01Ch]
        mov eax, ebx
        mov ebp, dword [byte esi+08h]
        sub eax, ecx
        and ebp, 0FFFC00FFh
        and eax, 3FFh
        mov edx, ebp
        shl eax, 8
        or edx, eax
        mov eax, edx
        shl eax, 0Eh
        mov ebx, dword [byte esp+038h]
        shr eax, 16h
        add ebx, eax
        mov eax, dword [byte esi+010h]
        mov dword [byte esi+08h], ebp
        mov dword [byte esp+01Ch], eax
        mov eax, dword [byte esp+018h]
        mov ecx, dword [byte esp+01Ch]
        mov dword [byte esi+08h], edx
        sub eax, ecx
        mov dword [byte esp+038h], ebx
        mov dword [byte esp+014h], eax
.8:
        lea eax, [nosplit edi*4+00h]
        sub eax, edi
        shl eax, 2
        lea ecx, [esi+eax]
        lea eax, [byte ecx-0Ch]
        mov ebx, dword [byte esp+034h]
        mov edx, dword [byte eax+08h]
        mov ebp, dword [byte esp+01Ch]
        shl edx, 0Eh
        mov eax, dword [byte eax+04h]
        shr edx, 16h
        and ebx, 0FFh
        add eax, edx
        lea edx, [byte edi+01h]
        cmp eax, ebp
        ja short .9
        mov byte [byte ecx+08h], 0
        or dword [byte ecx+08h], ebx
        mov eax, dword [byte esp+038h]
        mov ebx, dword [byte ecx+08h]
        mov dword [ecx], eax
        mov eax, dword [byte esp+014h]
        and ebx, 0FFFC00FFh
        and eax, 3FFh
        mov esi, ebx
        shl eax, 8
        mov dword [byte ecx+08h], ebx
        or esi, eax
        mov dword [byte ecx+08h], esi
        mov bl, byte [byte ecx+0Ah]
        and bl, 0DBh
        mov byte [byte ecx+0Ah], bl
        mov bh, bl
        and bh, 0BFh
        mov al, bh
        mov byte [byte ecx+0Ah], bh
        and al, 0E7h
        mov byte [byte ecx+0Ah], al
        mov ah, al
        mov dword [byte ecx+04h], ebp
        or ah, 18h
        mov byte [byte ecx+0Ah], ah
        mov eax, edx
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        ret 10h
.9:
        cmp eax, dword [byte esp+018h]
        jae short .10
        mov byte [byte ecx+08h], 0
        mov edi, dword [byte esp+01Ch]
        mov ebp, dword [byte ecx+08h]
        sub eax, edi
        or ebp, ebx
        lea ebx, [edi+eax]
        mov edi, dword [byte esp+038h]
        mov dword [byte ecx+08h], ebp
        add edi, eax
        mov dword [ecx], edi
        mov edi, dword [byte esp+014h]
        mov ebp, dword [byte ecx+08h]
        sub edi, eax
        mov dword [byte ecx+04h], ebx
        and edi, 3FFh
        and ebp, 0FFFC00FFh
        shl edi, 8
        mov dword [byte ecx+08h], ebp
        or ebp, edi
        mov dword [byte ecx+08h], ebp
        and byte [byte ecx+0Ah], 0DBh
        mov dword [byte esp+018h], ebx
        and byte [byte ecx+0Ah], 0BFh
        mov dword [byte esp+014h], eax
        and byte [byte ecx+0Ah], 0E7h
        mov edi, edx
        or byte [byte ecx+0Ah], 18h
.10:
        xor ecx, ecx
        test edi, edi
        jle near .14
.11:
        imul ebp, ecx, byte 0Ch
        add ebp, esi
        mov edx, dword [byte ebp+08h]
        shl edx, 0Eh
        mov eax, dword [byte ebp+04h]
        shr edx, 16h
        mov ebx, dword [byte esp+01Ch]
        add edx, eax
        cmp edx, ebx
        ja short .12
        inc ecx
        jmp near .13
.12:
        cmp eax, ebx
        jae near .17
        mov eax, dword [byte esp+03Ch]
        mov dh, byte [byte eax+02h]
        test dh, 20h
        jne near .16
        test dh, 10h
        jne near .16
        mov ebx, edi
        mov edx, ecx
        mov eax, esi
        call InsertSpanSlot
        mov eax, dword [byte esp+01Ch]
        mov edx, dword [byte ebp+04h]
        mov ebx, dword [byte ebp+08h]
        sub eax, edx
        and ebx, 0FFFC00FFh
        and eax, 3FFh
        mov edx, ebx
        shl eax, 8
        or edx, eax
        lea eax, [byte ecx+01h]
        imul eax, byte 0Ch
        mov dword [byte ebp+08h], ebx
        mov dword [byte ebp+08h], edx
        mov edx, dword [byte esi+eax+08h]
        shl edx, 0Eh
        shr edx, 16h
        mov dword [esp], edx
        mov edx, dword [byte ebp+08h]
        shl edx, 0Eh
        mov ebx, dword [esp]
        shr edx, 16h
        sub ebx, edx
        mov edx, ebx
        mov ebx, dword [byte esi+eax+08h]
        and edx, 3FFh
        and ebx, 0FFFC00FFh
        shl edx, 8
        mov dword [byte esi+eax+08h], ebx
        or ebx, edx
        mov dword [byte esi+eax+08h], ebx
        mov edx, dword [byte ebp+08h]
        shl edx, 0Eh
        mov ebx, dword [byte esi+eax+04h]
        shr edx, 16h
        add ebx, edx
        mov dword [byte esi+eax+04h], ebx
        mov edx, dword [byte ebp+08h]
        shl edx, 0Eh
        mov ebp, dword [esi+eax]
        shr edx, 16h
        inc edi
        add ebp, edx
        inc ecx
        mov dword [esi+eax], ebp
.13:
        cmp ecx, edi
        jl near .11
.14:
        mov eax, dword [byte esp+03Ch]
        mov dl, byte [byte eax+02h]
        test dl, 20h
        jne short .15
        test dl, 10h
        jne short .15
        cmp dword [byte esp+014h], byte 0
        jne near .22
.15:
        mov edx, edi
        mov eax, edx
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        ret 10h
.16:
        mov edx, ecx
        imul ebp, ecx, byte 0Ch
        mov ebx, edi
        mov eax, esi
        call InsertSpanSlot
        mov eax, dword [byte esp+01Ch]
        mov edx, dword [byte esi+ebp+04h]
        mov ebx, dword [byte esi+ebp+08h]
        sub eax, edx
        and ebx, 0FFFC00FFh
        and eax, 3FFh
        mov edx, ebx
        shl eax, 8
        or edx, eax
        lea eax, [byte ecx+01h]
        imul eax, byte 0Ch
        mov dword [byte esi+ebp+08h], ebx
        mov dword [byte esi+ebp+08h], edx
        mov ebx, dword [byte esi+ebp+08h]
        shl ebx, 0Eh
        mov edx, dword [byte esi+eax+08h]
        shl edx, 0Eh
        shr ebx, 16h
        shr edx, 16h
        sub edx, ebx
        mov ebx, dword [byte esi+eax+08h]
        and edx, 3FFh
        and ebx, 0FFFC00FFh
        shl edx, 8
        mov dword [byte esi+eax+08h], ebx
        or ebx, edx
        mov dword [byte esi+eax+08h], ebx
        mov edx, dword [byte esi+ebp+08h]
        shl edx, 0Eh
        mov ebx, dword [byte esi+eax+04h]
        shr edx, 16h
        add ebx, edx
        mov dword [byte esi+eax+04h], ebx
        mov edx, dword [byte esi+ebp+08h]
        shl edx, 0Eh
        mov ebp, dword [esi+eax]
        shr edx, 16h
        inc edi
        add ebp, edx
        inc ecx
        mov dword [esi+eax], ebp
        jmp near .13
.17:
        mov ebx, dword [byte esp+018h]
        cmp edx, ebx
        ja near .19
        mov eax, dword [byte esp+03Ch]
        mov bl, byte [byte eax+02h]
        test bl, 20h
        jne short .18
        test bl, 10h
        jne short .18
        dec edi
        mov edx, ecx
        mov eax, esi
        mov ebx, edi
        call RemoveSpanSlot
        jmp near .13
.18:
        imul eax, ecx, byte 0Ch
        mov edx, dword [byte esp+03Ch]
        mov edx, dword [edx]
        shl edx, 0Ah
        mov bl, byte [byte esi+eax+0Ah]
        shr edx, 1Fh
        and bl, 0BFh
        and edx, byte 1
        mov byte [byte esi+eax+0Ah], bl
        shl edx, 16h
        mov ebx, dword [byte esi+eax+08h]
        or ebx, edx
        mov edx, dword [byte esp+03Ch]
        mov dword [byte esi+eax+08h], ebx
        mov edx, dword [edx]
        mov bh, byte [byte esi+eax+0Ah]
        shl edx, 0Bh
        and bh, 0DFh
        shr edx, 1Fh
        mov byte [byte esi+eax+0Ah], bh
        and edx, byte 1
        mov ebp, dword [byte esi+eax+08h]
        shl edx, 15h
        or ebp, edx
        mov dword [byte esi+eax+08h], ebp
        mov dl, byte [byte esi+eax+0Ah]
        or dl, 4
        mov ebx, dword [byte esi+eax+04h]
        mov byte [byte esi+eax+0Ah], dl
        mov edx, dword [byte esp+038h]
        mov ebp, dword [byte esp+01Ch]
        lea eax, [edx+ebx]
        inc ecx
        sub eax, ebp
        mov dword [nosplit ecx*4+SpanSlotNext], eax
        jmp near .13
.19:
        cmp eax, ebx
        jae near .14
        mov edx, dword [byte esp+03Ch]
        mov bl, byte [byte edx+02h]
        test bl, 20h
        jne short .20
        test bl, 10h
        jne short .20
        mov edx, dword [byte esp+018h]
        sub edx, eax
        add eax, edx
        mov dword [byte ebp+04h], eax
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [byte ebp+00h]
        shl eax, 0Eh
        add ebx, edx
        shr eax, 16h
        mov dword [byte ebp+00h], ebx
        sub eax, edx
        mov ebx, dword [byte ebp+08h]
        and eax, 3FFh
        and ebx, 0FFFC00FFh
        shl eax, 8
        mov dword [byte ebp+08h], ebx
        or ebx, eax
        mov dword [byte ebp+08h], ebx
        test byte [byte ebp+0Ah], 4
        je near .14
        add dword [nosplit ecx*4+SpanSlotStart], edx
        jmp near .14
.20:
        mov ebx, edi
        mov edx, ecx
        mov eax, esi
        call InsertSpanSlot
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        shl eax, 2
        lea edx, [esi+eax]
        mov eax, dword [byte esp+018h]
        mov ebp, dword [byte edx+04h]
        mov ebx, dword [byte edx+08h]
        sub eax, ebp
        and ebx, 0FFFC00FFh
        and eax, 3FFh
        mov ebp, ebx
        mov dword [byte edx+08h], ebx
        shl eax, 8
        lea ebx, [byte ecx+01h]
        or ebp, eax
        lea eax, [nosplit ebx*4+00h]
        mov dword [byte edx+08h], ebp
        sub eax, ebx
        shl ebp, 0Eh
        mov ebx, dword [byte esi+eax*4+08h]
        shl ebx, 0Eh
        shr ebp, 16h
        shr ebx, 16h
        sub ebx, ebp
        mov ebp, dword [byte esi+eax*4+08h]
        and ebx, 3FFh
        and ebp, 0FFFC00FFh
        shl ebx, 8
        mov dword [byte esi+eax*4+08h], ebp
        or ebp, ebx
        mov dword [byte esi+eax*4+08h], ebp
        mov ebx, dword [byte edx+08h]
        shl ebx, 0Eh
        mov ebp, dword [byte esi+eax*4+04h]
        shr ebx, 16h
        add ebp, ebx
        mov dword [byte esi+eax*4+04h], ebp
        mov ebx, dword [byte edx+08h]
        shl ebx, 0Eh
        mov ebp, dword [esi+eax*4]
        shr ebx, 16h
        inc edi
        add ebp, ebx
        mov bl, byte [byte esi+eax*4+0Ah]
        mov dword [esi+eax*4], ebp
        test bl, 4
        je short .21
        mov edx, dword [byte edx+08h]
        shl edx, 0Eh
        mov eax, dword [nosplit ecx*4+SpanSlotTable]
        shr edx, 16h
        add eax, edx
        mov dword [nosplit ecx*4+SpanSlotTable], eax
.21:
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        shl eax, 2
        add esi, eax
        mov eax, dword [byte esp+03Ch]
        mov eax, dword [eax]
        mov bh, byte [byte esi+0Ah]
        shl eax, 0Bh
        and bh, 0DFh
        shr eax, 1Fh
        mov byte [byte esi+0Ah], bh
        and eax, byte 1
        mov edx, dword [byte esi+08h]
        shl eax, 15h
        or edx, eax
        mov eax, dword [byte esp+03Ch]
        mov dword [byte esi+08h], edx
        mov eax, dword [eax]
        mov dl, byte [byte esi+0Ah]
        shl eax, 0Ah
        and dl, 0BFh
        shr eax, 1Fh
        mov byte [byte esi+0Ah], dl
        and eax, byte 1
        mov ebx, dword [byte esi+08h]
        shl eax, 16h
        or ebx, eax
        mov dword [byte esi+08h], ebx
        mov ebp, dword [byte esi+04h]
        mov dh, byte [byte esi+0Ah]
        mov eax, dword [byte esp+038h]
        or dh, 4
        add eax, ebp
        mov byte [byte esi+0Ah], dh
        sub eax, dword [byte esp+01Ch]
        mov edx, edi
        mov dword [nosplit ecx*4+SpanSlotStart], eax
        mov eax, edx
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        ret 10h
.22:
        mov ebx, edi
        mov edx, ecx
        mov eax, esi
        call InsertSpanSlot
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        shl eax, 2
        add esi, eax
        mov eax, dword [byte esp+014h]
        mov edx, dword [byte esi+08h]
        and eax, 3FFh
        and edx, 0FFFC00FFh
        shl eax, 8
        mov ebx, edx
        mov dword [byte esi+08h], edx
        or ebx, eax
        mov dword [byte esi+08h], ebx
        mov eax, dword [byte esp+038h]
        mov byte [byte esi+08h], 0
        mov dword [esi], eax
        mov eax, dword [byte esp+01Ch]
        mov dword [byte esi+04h], eax
        mov eax, dword [byte esp+034h]
        mov ecx, dword [byte esi+08h]
        and eax, 0FFh
        or ecx, eax
        mov dword [byte esi+08h], ecx
        mov bl, byte [byte esi+0Ah]
        or bl, 10h
        mov byte [byte esi+0Ah], bl
        mov bh, bl
        and bh, 0BBh
        mov cl, bh
        mov byte [byte esi+0Ah], bh
        and cl, 0DFh
        mov byte [byte esi+0Ah], cl
        mov ch, cl
        inc edi
        and ch, 0F7h
        mov edx, edi
        mov byte [byte esi+0Ah], ch
.23:
        mov eax, edx
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        ret 10h
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; RebuildOverlayMask                              3C0B4  97 PC, low confidence
; Rebuilds the list of screen areas covered by overlay windows after one
; closes
;-----------------------------------------------------------------------------
RebuildOverlayMask:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 58h
        mov dword [byte esp+014h], eax
        mov ebp, OverlayMaskBase
        xor edx, edx
        mov eax, dword [ViewScreenWidth]
        mov dword [GameViewRows], edx
        mov dword [OverlayMaskDirty], edx
        mov dword [byte esp+08h], edx
        mov dword [byte esp+044h], edx
        mov dword [byte esp+04h], eax
        mov dword [esp], eax
        mov eax, dword [byte esp+014h]
        mov dword [byte esp+020h], edx
        test eax, eax
        jne short .1
        mov ebx, 1
        mov edx, dword [OverlayWindowCount]
        add ebp, byte 0Ch
        and edx, 0FFFC00FFh
        mov dword [GameViewRows], ebx
        mov dword [OverlayWindowCount], edx
.1:
        call SetScreenTarget
        mov eax, dword [DrawDestPitch]
        mov esi, dword [DrawDestBuffer]
        mov dword [byte esp+038h], eax
        call PresentScreen
        mov eax, dword [ViewSizeIndex]
        mov ecx, dword [DisplayViews]
        xor edx, edx
        test ecx, ecx
        jle short .4
.2:
        test byte [byte eax+04h], 1
        je short .3
        mov ebx, dword [byte eax+018h]
        mov ecx, dword [byte eax+024h]
        and ebx, 3FFh
        and ecx, 0FFF00000h
        shl ebx, 0Ah
        mov edi, ecx
        mov dword [byte eax+024h], ecx
        or edi, ebx
        mov dword [byte eax+024h], edi
        and byte [byte eax+026h], 0CFh
        mov ebx, dword [eax]
        mov ebx, dword [byte ebx+02Ch]
        mov dword [byte eax+020h], ebx
        add ebx, byte 10h
        mov dword [byte eax+020h], ebx
.3:
        mov edi, dword [DisplayViews]
        inc edx
        add eax, byte 28h
        cmp edx, edi
        jl short .2
.4:
        mov eax, ScreenRegion
        mov ebx, dword [OverlayWindowsOpen]
        xor edx, edx
        test ebx, ebx
        jle short .6
.5:
        mov ebx, dword [byte eax+018h]
        mov ecx, DirtySpans
        shl ebx, 2
        add ecx, ebx
        mov ebx, dword [eax]
        mov dword [byte eax+01Ch], ecx
        mov dword [byte eax+04h], ebx
        lea ecx, [byte ebx+010h]
        mov dword [byte eax+04h], ecx
        inc edx
        mov edi, dword [OverlayWindowsOpen]
        add eax, byte 20h
        cmp edx, edi
        jl short .5
.6:
        mov eax, dword [ViewScreenHeight]
        xor edi, edi
        test eax, eax
        jle near .29
        mov dword [byte esp+010h], esi
.7:
        xor edx, edx
        mov esi, dword [byte esp+014h]
        mov dword [byte esp+018h], edx
        test esi, esi
        jne short .9
        mov eax, dword [byte esp+020h]
        mov ebx, dword [ViewScreenWidth]
        add eax, ebx
        cmp eax, 10000h
        jg short .8
        mov eax, ebx
        xor eax, ebx
        mov dword [esp], ebx
        mov dword [byte esp+044h], eax
        jmp short .9
.8:
        mov eax, 10000h
        mov ecx, dword [byte esp+020h]
        mov esi, 1
        sub eax, ecx
        mov dword [byte esp+044h], esi
        mov dword [byte esp+0Ch], eax
        mov dword [esp], eax
.9:
        xor ebx, ebx
        mov ecx, dword [byte esp+044h]
        mov dword [byte esp+048h], ebx
        test ecx, ecx
        jl near .28
        mov eax, dword [byte esp+010h]
        mov dword [byte esp+024h], ebx
        mov dword [byte esp+028h], eax
.10:
        xor esi, esi
        mov eax, dword [DisplayViews]
        mov dword [byte esp+050h], esi
        mov esi, dword [ViewSizeIndex]
        test eax, eax
        jle near .17
        mov eax, dword [byte esp+024h]
        mov dword [byte esp+040h], eax
        lea eax, [byte esi+024h]
        mov dword [byte esp+04Ch], eax
.11:
        mov cl, byte [byte esi+04h]
        test cl, 1
        je near .16
        mov ebx, dword [byte esi+014h]
        cmp edi, ebx
        jl near .16
        test cl, 2
        je short .12
        mov eax, dword [byte esi+01Ch]
        add eax, eax
        add eax, ebx
        cmp edi, eax
        jge near .16
        test cl, 4
        jne short .13
        test di, 1
        jne short .14
        jmp short .13
.12:
        mov ecx, dword [byte esi+01Ch]
        lea eax, [ebx+ecx]
        cmp edi, eax
        jge short .16
.13:
        mov ecx, dword [byte esp+04Ch]
        push ecx
        mov eax, dword [byte esi+020h]
        push eax
        push byte 0
        mov ebx, dword [byte esi+010h]
        mov ecx, dword [byte esp+04Ch]
        push ebx
        mov ebx, dword [byte esp+050h]
        mov eax, ebp
        mov ecx, dword [byte esp+ecx+010h]
        mov ebx, dword [byte esp+ebx+018h]
        call MergeDirtySpans
        mov edx, eax
.14:
        mov eax, dword [byte esp+048h]
        cmp eax, dword [byte esp+044h]
        jne short .16
        test byte [byte esi+04h], 2
        je short .15
        test di, 1
        je short .16
.15:
        mov eax, dword [esi]
        mov ebx, dword [byte esi+020h]
        mov eax, dword [byte eax+020h]
        add ebx, eax
        mov dword [byte esi+020h], ebx
.16:
        mov ebx, dword [byte esp+050h]
        mov ecx, dword [byte esp+04Ch]
        add esi, byte 28h
        inc ebx
        add ecx, byte 28h
        mov dword [byte esp+050h], ebx
        mov eax, ebx
        mov ebx, dword [DisplayViews]
        mov dword [byte esp+04Ch], ecx
        cmp eax, ebx
        jl near .11
.17:
        mov esi, ScreenRegion
        xor ecx, ecx
        mov eax, dword [OverlayWindowsOpen]
        mov dword [byte esp+054h], ecx
        test eax, eax
        jle near .20
        mov eax, dword [byte esp+024h]
        mov dword [byte esp+03Ch], eax
.18:
        cmp edi, dword [byte esi+0Ch]
        jl short .19
        mov eax, dword [esi]
        mov eax, dword [byte eax+04h]
        mov ebx, dword [byte esi+0Ch]
        sar eax, 10h
        add eax, ebx
        cmp edi, eax
        jge short .19
        mov ecx, dword [byte esi+01Ch]
        push ecx
        mov eax, dword [byte esi+04h]
        push eax
        mov eax, dword [byte esp+05Ch]
        inc eax
        push eax
        mov ebx, dword [byte esi+08h]
        mov ecx, dword [byte esp+048h]
        push ebx
        mov ebx, dword [byte esp+04Ch]
        mov ecx, dword [byte esp+ecx+010h]
        mov eax, ebp
        mov ebx, dword [byte esp+ebx+018h]
        call MergeDirtySpans
        mov ecx, dword [byte esp+044h]
        mov edx, eax
        cmp ecx, dword [byte esp+048h]
        jne short .19
        mov eax, dword [esi]
        mov ebx, dword [byte esi+04h]
        mov ecx, dword [byte esi+01Ch]
        mov eax, dword [byte eax+02h]
        add ecx, byte 4
        sar eax, 10h
        mov dword [byte esi+01Ch], ecx
        add ebx, eax
        mov dword [byte esi+04h], ebx
.19:
        mov ecx, dword [byte esp+054h]
        mov ebx, dword [OverlayWindowsOpen]
        inc ecx
        add esi, byte 20h
        mov dword [byte esp+054h], ecx
        cmp ecx, ebx
        jl short .18
.20:
        lea eax, [nosplit edx*4+00h]
        mov ecx, dword [byte esp+014h]
        mov dword [byte esp+01Ch], eax
        test ecx, ecx
        jne short .23
        test edx, edx
        jle near .26
        mov eax, dword [byte esp+020h]
        mov ecx, dword [byte esp+018h]
        mov ebx, dword [byte esp+038h]
        sub eax, ecx
        add ebx, eax
        xor esi, esi
        mov dword [byte esp+02Ch], ebx
        mov ebx, dword [byte esp+01Ch]
        mov eax, ebp
        mov dword [byte esp+034h], ebx
.21:
        mov ebx, dword [byte esp+02Ch]
        mov ecx, dword [byte eax+04h]
        add ecx, ebx
        mov bh, byte [byte eax+0Ah]
        mov dword [byte eax+04h], ecx
        test bh, 4
        je short .22
        mov ebx, dword [OverlayMaskDirty]
        mov ecx, ebx
        mov ebx, dword [dword esi+SpanSlotStart]
        mov dword [nosplit ecx*4+OverlayRowMask], ebx
        mov ebx, ecx
        inc ebx
        mov dword [OverlayMaskDirty], ebx
.22:
        mov ebx, dword [byte esp+034h]
        add esi, byte 4
        add eax, byte 0Ch
        cmp esi, ebx
        jge short .26
        jmp short .21
.23:
        test edx, edx
        jle short .26
        mov ebx, dword [byte esp+01Ch]
        mov eax, ebp
        xor esi, esi
        mov dword [byte esp+030h], ebx
.24:
        mov ecx, dword [byte esp+028h]
        mov ebx, dword [byte esp+038h]
        add ebx, dword [ecx]
        mov ecx, dword [byte eax+04h]
        add ecx, ebx
        mov bl, byte [byte eax+0Ah]
        mov dword [byte eax+04h], ecx
        test bl, 4
        je short .25
        mov ebx, dword [OverlayMaskDirty]
        mov ecx, ebx
        mov ebx, dword [dword esi+SpanSlotStart]
        mov dword [nosplit ecx*4+OverlayRowMask], ebx
        mov ebx, ecx
        inc ebx
        mov dword [OverlayMaskDirty], ebx
.25:
        mov ebx, dword [byte esp+030h]
        add esi, byte 4
        add eax, byte 0Ch
        cmp esi, ebx
        jl short .24
.26:
        imul eax, edx, byte 0Ch
        mov esi, dword [GameViewRows]
        add ebp, eax
        add esi, edx
        mov eax, dword [byte esp+024h]
        mov dword [GameViewRows], esi
        mov ebx, dword [byte esp+024h]
        mov eax, dword [esp+eax]
        mov ecx, dword [byte esp+ebx+08h]
        mov esi, dword [byte esp+020h]
        sub eax, ecx
        mov ebx, dword [byte esp+044h]
        add esi, eax
        mov eax, dword [byte esp+048h]
        mov dword [byte esp+020h], esi
        cmp eax, ebx
        jge short .27
        and dword [byte ebp+08h], 0FFFC00FFh
        mov esi, dword [GameViewRows]
        inc esi
        add ebp, byte 0Ch
        mov dword [GameViewRows], esi
        mov byte [byte ebp+08h], 0
        mov dword [byte ebp+00h], 0
        xor eax, eax
        mov dword [byte ebp+04h], 0
        mov dword [byte esp+020h], eax
        mov eax, dword [byte esp+0Ch]
        xor edx, edx
        mov dword [byte esp+018h], eax
.27:
        mov esi, dword [byte esp+024h]
        mov eax, dword [byte esp+048h]
        mov ebx, dword [byte esp+044h]
        add esi, byte 4
        inc eax
        mov dword [byte esp+024h], esi
        mov dword [byte esp+048h], eax
        cmp eax, ebx
        jle near .10
.28:
        mov edx, dword [byte esp+010h]
        mov ebx, dword [ViewScreenHeight]
        add edx, byte 4
        inc edi
        mov dword [byte esp+010h], edx
        cmp edi, ebx
        jl near .7
.29:
        xor edx, edx
        mov dword [DisplayViewCount], edx
        add esp, byte 58h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; BlendOverlayRow                                 3C544  97 PC, low confidence
; Copies a row of an overlay window: transparent pixels show the screen,
; shade pixels darken it
;-----------------------------------------------------------------------------
BlendOverlayRow:
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov edi, ecx
        mov eax, ebx
        xor esi, esi
        test ecx, ecx
        jle short .4
        mov ebx, ebp
.1:
        mov cl, byte [edx]
        cmp cl, 0FFh
        jne short .2
        mov cl, byte [ebx]
        jmp short .3
.2:
        cmp cl, 0FEh
        jne short .3
        xor ecx, ecx
        mov cl, byte [ebx]
        mov cl, byte [dword ecx+RemapTable]
.3:
        mov byte [eax], cl
        inc ebx
        inc eax
        inc esi
        inc edx
        cmp esi, edi
        jl short .1
.4:
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ShadeOverlayRow                                 3C580  97 PC, low confidence
; Copies a row of an overlay window, darkening the shade pixels through the
; shade table
;-----------------------------------------------------------------------------
ShadeOverlayRow:
        push esi
        push edi
        mov esi, eax
        mov edi, ecx
        mov eax, edx
        mov edx, ebx
        xor ebx, ebx
        test ecx, ecx
        jle short .3
.1:
        mov cl, byte [eax]
        cmp cl, 0FEh
        jne short .2
        xor ecx, ecx
        mov cl, byte [esi]
        mov cl, byte [dword ecx+RemapTable]
.2:
        mov byte [edx], cl
        inc edx
        inc eax
        inc ebx
        inc esi
        cmp ebx, edi
        jl short .1
.3:
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
        push esi
        push edi
        mov esi, eax
        mov edi, ecx
        mov eax, ebx
        xor ebx, ebx
        test ecx, ecx
        jle short .6
.4:
        mov cl, byte [edx]
        cmp cl, 0FFh
        jne short .5
        mov cl, byte [esi]
.5:
        mov byte [eax], cl
        inc eax
        inc edx
        inc ebx
        inc esi
        cmp ebx, edi
        jl short .4
.6:
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; DrawOverlayRows                                 3C5D4  97 PC, low confidence
; Draws the rows of an overlay window onto the screen
;-----------------------------------------------------------------------------
DrawOverlayRows:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        test dword [byte eax+08h], 3FF00h
        jne short .1
        mov eax, dword [GameViewPitch]
        lea edx, [byte eax+01h]
        mov dword [GameViewPitch], edx
        call VesaSetBank
        jmp near .8
.1:
        test byte [byte eax+0Ah], 4
        je near .6
        mov edx, dword [byte ebx+08h]
        mov eax, dword [byte ebx+08h]
        shl edx, 9
        shl eax, 0Ah
        shr edx, 1Fh
        shr eax, 1Fh
        test edx, eax
        je short .2
        mov eax, dword [GameViewBuffer]
        mov ecx, dword [byte ebx+08h]
        mov esi, dword [byte ebx+04h]
        inc eax
        shl ecx, 0Eh
        mov edx, dword [nosplit eax*4+OverlayRowCount]
        mov dword [GameViewBuffer], eax
        shr ecx, 16h
        mov eax, dword [ebx]
        mov ebx, esi
        call BlendOverlayRow
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        mov ch, byte [byte ebx+0Ah]
        test ch, 40h
        je short .3
        mov esi, dword [GameViewBuffer]
        mov ecx, dword [byte ebx+08h]
        mov eax, dword [byte ebx+04h]
        inc esi
        shl ecx, 0Eh
        mov edx, dword [nosplit esi*4+OverlayRowCount]
        mov dword [GameViewBuffer], esi
        shr ecx, 16h
        mov esi, dword [ebx]
        mov ebx, eax
        mov eax, esi
        call ShadeOverlayRow
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        test ch, 20h
        je near .8
        mov eax, dword [GameViewBuffer]
        inc eax
        mov ecx, dword [ebx]
        mov dword [GameViewBuffer], eax
        mov esi, dword [nosplit eax*4+OverlayRowCount]
        mov eax, dword [byte ebx+08h]
        shl eax, 0Eh
        mov edx, dword [byte ebx+04h]
        shr eax, 16h
        xor ebx, ebx
        mov edi, eax
        test eax, eax
        jle short .8
        mov eax, edx
        mov edx, esi
        mov esi, ecx
.4:
        mov cl, byte [edx]
        cmp cl, 0FFh
        jne short .5
        mov cl, byte [esi]
.5:
        mov byte [eax], cl
        inc eax
        inc edx
        inc ebx
        inc esi
        cmp ebx, edi
        jge short .8
        jmp short .4
.6:
        test byte [byte ebx+08h], 0FFh
        jne short .7
        cmp dword [GameViewShown], byte 0
        je short .7
        mov edx, dword [byte ebx+08h]
        mov edi, dword [byte ebx+04h]
        shl edx, 0Eh
        mov esi, dword [ebx]
        shr edx, 16h
        call CopyMemFpu
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        test byte [byte ebx+0Ah], 10h
        je short .8
        mov edx, dword [byte ebx+08h]
        mov edi, dword [byte ebx+04h]
        shl edx, 0Eh
        mov esi, dword [ebx]
        shr edx, 16h
        call CopyMemFpu
        and byte [byte ebx+0Ah], 0EFh
.8:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        push edx
        push esi
        mov ecx, dword [GameViewRows]
        xor edx, edx
        xor ebx, ebx
        mov dword [GameViewBuffer], edx
        mov dword [GameViewPitch], edx
        test ecx, ecx
        jle short .10
        mov edx, OverlayMaskBase
.9:
        mov eax, edx
        call DrawOverlayRows
        inc ebx
        mov esi, dword [GameViewRows]
        add edx, byte 0Ch
        cmp ebx, esi
        jl short .9
.10:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetVideoMode                                 3C75C  97 PC, medium confidence
; (width, height): switches the screen mode when it differs from the current
; one (ViewPixelWidth x ViewPixelHeight)
;-----------------------------------------------------------------------------
SetVideoMode:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 308h
        mov ebx, eax
        mov esi, edx
        cmp eax, dword [ViewPixelWidth]
        jne short .1
        cmp esi, dword [ViewPixelHeight]
        je near .2
.1:
        mov eax, esp
        push eax
        push dword 100h
        push byte 0
        mov edi, 1
        call GetPaletteEntries
        add esp, byte 0Ch
        mov dword [VideoModeIndex], edi
        call SetScreenTarget
        mov ebp, dword [ViewBorderRows]
        push ebp
        call ClearScreen
        add esp, byte 4
        call PresentScreen
        call FreeVideoBuffer
        push byte 8
        push esi
        push ebx
        call SetGraphicsMode
        add esp, byte 0Ch
        call AllocGfxFixBuffer
        cmp dword [VideoModeNumber], byte 0
        sete al
        and eax, 0FFh
        mov dword [ViewBorderColor], eax
        mov eax, esp
        push eax
        push dword 100h
        push byte 0
        call WritePaletteRegs
        add esp, byte 0Ch
        push dword 0FF111111h
        call MakeColor
        add esp, byte 4
        push eax
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push eax
        call SetTextColors
        add esp, byte 8
        push dword 0FF111111h
        call MakeColor
        mov dword [ViewBorderRows], eax
        mov eax, dword [ViewScreenHeight]
        add esp, byte 4
        shl eax, 2
        mov ebx, dword [ViewScreenWidth]
        mov dword [dword esp+0300h], eax
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        mov dword [dword esp+0304h], eax
        fild dword [dword esp+0300h]
        fild dword [dword esp+0304h]
        fdivp
        mov dword [ViewSizeChanged], edi
        mov dword [GameViewTop], edi
        mov dword [DisplayViewCount], edi
        fstp dword [ViewAspect]
.2:
        add esp, 308h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; InitDisplayViews                                3C880  97 PC, low confidence
; Allocates the display view table ("DMAN") for the given number of views
;-----------------------------------------------------------------------------
InitDisplayViews:
        push ebx
        push ecx
        mov ebx, eax
        mov dword [DisplayViews], eax
        shl eax, 2
        add eax, ebx
        push edx
        shl eax, 3
        push eax
        push str_DMAN
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [ViewSizeIndex], eax
        xor edx, edx
        test ebx, ebx
        jle short .2
.1:
        add eax, byte 28h
        inc edx
        mov dword [byte eax-024h], 0
        cmp edx, ebx
        jl short .1
.2:
        mov edx, 0FFFFFFFFh
        mov ecx, 1
        mov dword [ViewPixelWidth], edx
        mov dword [DisplayViewCount], ecx
        mov dword [ViewPixelHeight], edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FreeDisplayViews                                3C8DC  97 PC, low confidence
; Frees the bitmaps of the display views and the view table
;-----------------------------------------------------------------------------
FreeDisplayViews:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edx, dword [DisplayViews]
        mov edi, dword [ViewSizeIndex]
        xor esi, esi
        test edx, edx
        jle short .3
        xor ebx, ebx
.1:
        test byte [byte edi+04h], 1
        je short .2
        mov eax, dword [ViewSizeIndex]
        mov eax, dword [ebx+eax]
        mov dword [byte eax+028h], 0
        mov eax, dword [ViewSizeIndex]
        mov ebp, dword [ebx+eax]
        push ebp
        call FreeBitmap
        add esp, byte 4
.2:
        mov ecx, dword [DisplayViews]
        add ebx, byte 28h
        inc esi
        add edi, byte 28h
        cmp esi, ecx
        jl short .1
.3:
        mov eax, dword [ViewSizeIndex]
        push eax
        call FreeMemBlock
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AddDisplayView                                  3C944  97 PC, low confidence
; Takes a free display view and creates its bitmap of the given size
;-----------------------------------------------------------------------------
AddDisplayView:
        push ecx
        push esi
        push edi
        push ebp
        mov edi, eax
        mov ebp, edx
        mov edx, dword [DisplayViews]
        mov esi, dword [ViewSizeIndex]
        xor eax, eax
        test edx, edx
        jle short .2
        mov ecx, dword [DisplayViews]
.1:
        test byte [byte esi+04h], 1
        je short .2
        inc eax
        add esi, byte 28h
        cmp eax, ecx
        jl short .1
.2:
        push ebx
        push ebp
        push edi
        mov dword [byte esi+04h], 1
        call CreateBitmap
        mov dword [esi], eax
        add esp, byte 0Ch
        mov eax, dword [byte eax+028h]
        call removewindow
        mov eax, dword [esi]
        mov dword [byte eax+028h], DisplayViewRecords
        mov dword [byte esi+014h], 0
        mov dword [byte esi+08h], edi
        mov dword [byte esi+0Ch], ebp
        mov ebx, ebp
        mov eax, dword [byte esi+014h]
        mov edx, edi
        mov dword [byte esi+010h], eax
        mov eax, esi
        mov edi, 1
        call SetViewSize
        mov dword [DisplayViewCount], edi
        mov eax, esi
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetViewDrawTarget                               3C9C8  97 PC, low confidence
; Makes a display view the drawing target and sets its projection
;-----------------------------------------------------------------------------
SetViewDrawTarget:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        mov edx, dword [eax]
        push edx
        call SetDrawTarget
        mov eax, dword [byte ebx+018h]
        mov dword [ViewPixelWidth], eax
        mov eax, dword [byte ebx+01Ch]
        mov dword [ViewPixelHeight], eax
        mov ah, byte [byte ebx+04h]
        add esp, byte 4
        test ah, 2
        je short .1
        fld dword [ViewAspect]
        fmul qword [F64_0p5_SetViewDrawTarget]
        sub esp, byte 4
        fstp dword [esp]
        jmp short .2
.1:
        push dword [ViewAspect]
.2:
        call SetFocalLength
        mov ecx, dword [byte ebx+01Ch]
        push ecx
        mov esi, dword [byte ebx+018h]
        push esi
        push dword [F32_ViewAngle]
        call SetProjectionCenter
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SetViewSize                                     3CA28  97 PC, low confidence
; Sets the width and height of a display view's bitmap
;-----------------------------------------------------------------------------
SetViewSize:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov edi, eax
        mov esi, edx
        mov ecx, dword [eax]
        and esi, 0FFFCh
        mov dword [byte ecx+020h], esi
        mov dword [esp], esi
        mov ebp, dword [byte ecx+02Ch]
        mov dword [ecx], esi
        mov eax, dword [esp]
        mov word [byte ebp+04h], ax
        cwde
        mov dword [byte edi+018h], eax
        mov dword [esp], ebx
        mov ebp, dword [byte ecx+02Ch]
        mov eax, dword [esp]
        mov dword [byte ecx+04h], ebx
        mov word [byte ebp+06h], ax
        cwde
        mov dword [byte edi+01Ch], eax
        mov dword [byte ecx+0Ch], 0
        mov eax, dword [byte ecx+0Ch]
        mov dword [byte ecx+08h], eax
        mov eax, dword [ecx]
        mov dword [byte ecx+010h], eax
        mov eax, dword [byte ecx+04h]
        mov edx, 10h
        mov dword [byte ecx+014h], eax
        test ebx, ebx
        jle short .2
        lea edi, [nosplit ebx*4+00h]
        xor eax, eax
.1:
        add eax, byte 4
        mov ebx, dword [byte ecx+028h]
        mov dword [byte ebx+eax-04h], edx
        add edx, esi
        cmp eax, edi
        jl short .1
.2:
        mov edx, 1
        mov dword [ViewSizeChanged], edx
        mov dword [DisplayViewCount], edx
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; SetViewInterlaced                               3CAB8  97 PC, low confidence
; Switches a display view to half height (interlaced display)
;-----------------------------------------------------------------------------
SetViewInterlaced:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov ebx, dword [eax]
        test byte [byte eax+04h], 2
        jne short .1
        or byte [byte ecx+04h], 2
        mov eax, dword [byte ebx+04h]
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov edx, dword [ebx]
        mov ebx, eax
        mov eax, ecx
        call SetViewSize
        mov edx, 1
        mov dword [ViewInterlaced], edx
        mov dword [DisplayViewCount], edx
        mov dword [ViewSizeChanged], edx
        call MarkPaletteDirty
.1:
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ClearViewInterlaced                             3CB00  97 PC, low confidence
; Switches a display view back to full height
;-----------------------------------------------------------------------------
ClearViewInterlaced:
        push ebx
        push edx
        mov bl, byte [byte eax+04h]
        mov edx, dword [eax]
        test bl, 2
        je short .1
        mov bh, bl
        and bh, 0FDh
        mov byte [byte eax+04h], bh
        mov ebx, dword [byte edx+04h]
        mov edx, dword [edx]
        add ebx, ebx
        call SetViewSize
        xor edx, edx
        mov ebx, 1
        mov dword [ViewInterlaced], edx
        mov dword [DisplayViewCount], ebx
.1:
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; HideView                                        3CB38  97 PC, low confidence
; Marks a display view hidden and asks for a redraw
;-----------------------------------------------------------------------------
HideView:
        or byte [byte eax+04h], 4
        mov dword [DisplayViewCount], 1
        ret
        db 090h
;-----------------------------------------------------------------------------
; ShowView                                        3CB48  97 PC, low confidence
; Marks a display view shown and asks for a redraw
;-----------------------------------------------------------------------------
ShowView:
        push edx
        mov dl, byte [byte eax+04h]
        and dl, 0FBh
        mov byte [byte eax+04h], dl
        test dl, 2
        je short .1
        mov dword [ViewSizeChanged], 1
.1:
        mov dword [DisplayViewCount], 1
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetViewOrigin                                   3CB70  97 PC, low confidence
; Sets where a display view sits on the screen
;-----------------------------------------------------------------------------
SetViewOrigin:
        push ecx
        mov ecx, dword [eax]
        mov dword [byte eax+010h], edx
        mov ecx, dword [byte ecx+02Ch]
        mov word [byte ecx+0Ch], dx
        mov dword [byte eax+014h], ebx
        mov eax, dword [eax]
        mov eax, dword [byte eax+02Ch]
        mov edx, 1
        mov word [byte eax+0Eh], bx
        mov dword [DisplayViewCount], edx
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ClearViewBorders                                3CB98  97 PC, low confidence
; Clears the screen rows around the game view
;-----------------------------------------------------------------------------
ClearViewBorders:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov eax, dword [ViewSizeIndex]
        mov dl, byte [byte eax+04h]
        mov edi, dword [byte eax+01Ch]
        test dl, 2
        je short .1
        add edi, edi
.1:
        call SetScreenTarget
        xor esi, esi
        jmp short .3
.2:
        mov ebx, dword [ViewBorderRows]
        push ebx
        push esi
        mov ecx, dword [ViewScreenWidth]
        push ecx
        push esi
        push byte 0
        call FillRectColor
        inc esi
        add esp, byte 14h
.3:
        mov eax, dword [ViewSizeIndex]
        cmp esi, dword [byte eax+014h]
        jl short .2
        xor esi, esi
        test edi, edi
        jle near .7
.4:
        mov eax, dword [ViewSizeIndex]
        mov ebx, dword [byte eax+014h]
        add ebx, esi
        test si, 1
        je short .5
        mov dh, byte [byte eax+04h]
        test dh, 2
        je short .5
        test dh, 4
        jne short .5
        mov ecx, dword [ViewBorderRows]
        push ecx
        push ebx
        mov ebp, dword [ViewScreenWidth]
        push ebp
        push ebx
        push byte 0
        jmp short .6
.5:
        mov ebp, dword [ViewBorderRows]
        push ebp
        mov eax, dword [ViewSizeIndex]
        push ebx
        mov edx, dword [byte eax+010h]
        push edx
        push ebx
        push byte 0
        call FillRectColor
        add esp, byte 14h
        mov ecx, dword [ViewBorderRows]
        push ecx
        push ebx
        mov ebp, dword [ViewScreenWidth]
        mov eax, dword [ViewSizeIndex]
        push ebp
        mov edx, dword [byte eax+018h]
        push ebx
        mov ebx, dword [byte eax+010h]
        add ebx, edx
        push ebx
.6:
        call FillRectColor
        add esp, byte 14h
        inc esi
        cmp esi, edi
        jl short .4
.7:
        mov eax, dword [ViewSizeIndex]
        mov ebx, dword [byte eax+014h]
        mov esi, dword [ViewScreenHeight]
        add ebx, edi
        cmp ebx, esi
        jge short .9
.8:
        mov eax, dword [ViewBorderRows]
        push eax
        push ebx
        mov edx, dword [ViewScreenWidth]
        push edx
        push ebx
        push byte 0
        call FillRectColor
        inc ebx
        mov ecx, dword [ViewScreenHeight]
        add esp, byte 14h
        cmp ebx, ecx
        jl short .8
.9:
        call PresentScreen
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PresentGameView                                 3CCA8  97 PC, low confidence
; Copies the game view and the overlay windows to the screen
;-----------------------------------------------------------------------------
PresentGameView:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp dword [ViewSizeChanged], byte 0
        je short .1
        xor ebx, ebx
        call ClearViewBorders
        mov dword [ViewSizeChanged], ebx
.1:
        cmp dword [OverlayWindowsOpen], byte 0
        jne short .2
        mov eax, dword [ViewSizeIndex]
        test byte [byte eax+04h], 2
        jne short .2
        call SetScreenTarget
        mov edx, dword [ViewSizeIndex]
        mov ebx, dword [byte edx+014h]
        push ebx
        mov ecx, dword [byte edx+010h]
        mov eax, dword [edx]
        push ecx
        mov esi, dword [byte eax+02Ch]
        push esi
        call BlitFrameToScreen
        add esp, byte 0Ch
        call PresentScreen
        jmp short .5
.2:
        cmp dword [DisplayViewCount], byte 0
        je short .3
        mov eax, dword [ViewBorderColor]
        call RebuildOverlayMask
.3:
        mov edi, 1
        push RinkPalette
        xor ebp, ebp
        xor ebx, ebx
        mov dword [GameViewShown], edi
        call SetRemapTable
        mov edx, dword [GameViewRows]
        add esp, byte 4
        mov dword [GameViewPitch], ebp
        mov dword [GameViewBuffer], ebp
        test edx, edx
        jle short .5
        mov edx, OverlayMaskBase
.4:
        mov eax, edx
        call DrawOverlayRows
        inc ebx
        mov edi, dword [GameViewRows]
        add edx, byte 0Ch
        cmp ebx, edi
        jl short .4
.5:
        xor ebp, ebp
        mov dword [GameViewTop], ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AddOverlayWindow                                3CD70  97 PC, low confidence
; (id, ...): adds an entry to the 32-byte overlay window list (ScreenRegion, count OverlayWindowsOpen) and
; draws it; from every overlay panel and the pause menu
;-----------------------------------------------------------------------------
AddOverlayWindow:
        push esi
        push edi
        mov esi, eax
        mov eax, dword [OverlayWindowsOpen]
        mov edi, eax
        inc eax
        shl edi, 5
        mov dword [OverlayWindowsOpen], eax
        mov eax, ScreenRegion
        mov dword [byte edi+eax+08h], esi
        mov dword [byte edi+eax+0Ch], edx
        mov dword [edi+eax], ebx
        mov edx, dword [DirtySpanCount]
        mov dword [byte edi+eax+018h], edx
.1:
        mov edx, ecx
        mov eax, ebx
        call AddDirtySpans
        test eax, eax
        je short .2
        mov eax, dword [ScreenRegion]
        call RemoveOverlayWindow
        jmp short .1
.2:
        mov dword [DisplayViewCount], 1
        pop edi
        pop esi
        ret
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov edx, dword [GameViewTop]
        xor edi, edi
        test edx, edx
        jne near .7
        call SetScreenTarget
        mov ebx, dword [GameViewRows]
        xor esi, esi
        test ebx, ebx
        jle short .6
        xor ebx, ebx
.3:
        mov eax, dword [dword ebx+OverlayWindowCount]
        test eax, 3FF00h
        jne short .4
        mov eax, edi
        call VesaSetBank
        inc edi
        jmp short .5
.4:
        and eax, 0FFh
        cmp eax, ebp
        jne short .5
        test byte [dword ebx+OverlayMask], 8
        je short .5
        mov eax, dword [dword ebx+OverlayWindowCount]
        mov edx, dword [ViewBorderRows]
        shl eax, 0Eh
        push edx
        shr eax, 16h
        push eax
        mov ecx, dword [dword ebx+OverlayWindowFlags]
        push ecx
        call FillMem
        add esp, byte 0Ch
.5:
        mov ecx, dword [GameViewRows]
        inc esi
        add ebx, byte 0Ch
        cmp esi, ecx
        jl short .3
.6:
        call PresentScreen
.7:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RemoveOverlayWindow                             3CE58  97 PC, low confidence
; (id): takes the overlay window out of the list and restores what was under
; it; from RemoveOverlayPanel, DrawGameOverlays, the pause menu
;-----------------------------------------------------------------------------
RemoveOverlayWindow:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebx, ScreenRegion
        mov edx, dword [OverlayWindowsOpen]
        xor ebp, ebp
        test edx, edx
        jle near .8
        mov ecx, dword [OverlayWindowsOpen]
.1:
        cmp eax, dword [ebx]
        jne near .7
        cmp dword [ReplayPlaying], byte 0
        jne short .2
        mov dword [ViewSizeChanged], 1
.2:
        mov eax, dword [DirtySpanCount]
        mov edx, dword [ebx]
        mov edi, dword [byte ebx+018h]
        mov ecx, dword [byte ebx+018h]
        mov edx, dword [byte edx+04h]
        shl edi, 2
        sar edx, 10h
        sub eax, ecx
        lea esi, [nosplit edx*4+00h]
        add edi, DirtySpans
        sub eax, edx
        add esi, edi
        lea edx, [nosplit eax*4+00h]
        call CopyMemFpu
        mov eax, dword [ebx]
        mov eax, dword [byte eax+04h]
        mov esi, dword [DirtySpanCount]
        sar eax, 10h
        sub esi, eax
        mov edi, dword [OverlayWindowsOpen]
        mov dword [DirtySpanCount], esi
        test edi, edi
        jle short .6
        mov ecx, edi
        xor eax, eax
        shl ecx, 5
.3:
        mov esi, dword [byte ebx+018h]
        cmp esi, dword [dword eax+OverlayWindows]
        jge short .4
        mov edx, dword [ebx]
        mov edx, dword [byte edx+04h]
        mov edi, dword [dword eax+OverlayWindows]
        sar edx, 10h
        sub edi, edx
        mov dword [dword eax+OverlayWindows], edi
.4:
        add eax, byte 20h
        cmp eax, ecx
        jge short .6
        jmp short .3
.5:
        mov ecx, 8
        mov edi, ebx
        lea esi, [byte ebx+020h]
        inc ebp
        add ebx, byte 20h
        rep movsd
.6:
        mov eax, dword [OverlayWindowsOpen]
        dec eax
        cmp ebp, eax
        jl short .5
        mov ebp, dword [OverlayWindowsOpen]
        dec ebp
        mov eax, dword [ViewBorderColor]
        mov dword [OverlayWindowsOpen], ebp
        call RebuildOverlayMask
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        inc ebp
        add ebx, byte 20h
        cmp ebp, ecx
        jl near .1
.8:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; UpdateScreenRegion                              3CF68  97 PC, low confidence
; Sets the size of a screen region by its id and asks for a redraw
;-----------------------------------------------------------------------------
UpdateScreenRegion:
        push ecx
        push esi
        push edi
        push ebp
        mov ecx, eax
        mov esi, edx
        mov edx, 1
        mov eax, ScreenRegion
        mov edi, dword [OverlayWindowsOpen]
        mov dword [DisplayViewCount], edx
        xor edx, edx
        test edi, edi
        jle short .3
        mov ebp, dword [OverlayWindowsOpen]
.1:
        cmp ecx, dword [eax]
        jne short .2
        mov dword [byte eax+0Ch], ebx
        mov dword [byte eax+08h], esi
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.2:
        inc edx
        add eax, byte 20h
        cmp edx, ebp
        jl short .1
.3:
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; RefreshOverlayWindow                            3CFB0  97 PC, low confidence
; (id): marks the overlay window's cells for redraw (OverlayMask bit 4); from
; DrawGameClock, DrawPowerPlayClock, the pause menu
;-----------------------------------------------------------------------------
RefreshOverlayWindow:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebx, eax
        mov edx, ScreenRegion
        mov ecx, dword [OverlayWindowsOpen]
        xor eax, eax
        test ecx, ecx
        jle short .5
        mov esi, dword [OverlayWindowsOpen]
.1:
        mov edi, dword [edx]
        inc eax
        cmp ebx, edi
        jne short .4
        mov ebp, dword [GameViewRows]
        test ebp, ebp
        jle short .5
        lea ebx, [nosplit ebp*4+00h]
        mov ecx, eax
        sub ebx, ebp
        xor eax, eax
        shl ebx, 2
.2:
        mov edx, dword [dword eax+OverlayWindowCount]
        and edx, 0FFh
        cmp edx, ecx
        jne short .3
        or byte [dword eax+OverlayMask], 10h
.3:
        add eax, byte 0Ch
        cmp eax, ebx
        jge short .5
        jmp short .2
.4:
        add edx, byte 20h
        cmp eax, esi
        jl short .1
.5:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetRinkDetail                                   3D020  97 PC, low confidence
; Stores the rink detail level and reloads the rink palette
;-----------------------------------------------------------------------------
SetRinkDetail:
        mov dword [RinkDetail], eax
        jmp near BuildRinkPalette
