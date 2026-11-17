; EA library: DrawShapeAtOwnPos, DrawArt, DrawShape, CreateBitmap, LoadDrawContext and 7 more.
bits 32
%include "hockey.inc"
section s_FCF84 progbits alloc exec nowrite align=1
extern BuildSpanOffsets, ClipLeftCol, ClipRight, ClipTopRow, ConvertArtSame, CopyScaledSpan, CreateBitmapEx, DrawDestBuffer
extern DrawDestOffset, DrawShapeCore, FillRect, FreeMemBlock, MenuScreenBitmap, ScaledRowBuffer, ScreenBitsPerPixel, ScreenBuffer
extern ScreenHeight, ScreenPitch, ScreenWidth, SetBlitSource, ShapeRowBytes, str_Punct_FreeArtArchive, VesaSetBank
global DrawShapeAtOwnPos, DrawArt, DrawShape, CreateBitmap, LoadDrawContext, SetDrawTarget, ClearScreen, DrawScaledRow
global DrawShapeScaledCore, DrawShapeScaledFit, DrawShapeScaledBy, DrawShapeScaledFlip
;-----------------------------------------------------------------------------
; DrawShapeAtOwnPos                               FCF84  97 PC, low confidence
; Draws a shape at the position stored in its header; followed by the draw at
; a given position
;-----------------------------------------------------------------------------
DrawShapeAtOwnPos:
        mov edx, dword [byte esp+04h]
        mov eax, dword [byte edx+0Ch]
        sar eax, 10h
        push eax
        mov eax, dword [byte edx+0Ah]
        sar eax, 10h
        push eax
        push edx
        call DrawShapeCore
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
        call DrawShapeCore
        add esp, byte 0Ch
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawArt                                         FCFCC  95 PC, low confidence
; Graphics library: draw art at x, y (art, x, y) through DrawShapeCore, which converts 8-bit art to the
; 16-bit screen
;-----------------------------------------------------------------------------
DrawArt:
        push ebx
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        mov ecx, dword [byte esp+010h]
        push ecx
        call DrawShapeCore
        add esp, byte 0Ch
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawShape                                       FCFE8  95 PC, low confidence
; Graphics library: DrawArt at the art's own position (+0Ah / +0Ch); right
; after DrawArt
;-----------------------------------------------------------------------------
DrawShape:
        mov edx, dword [byte esp+04h]
        mov eax, dword [byte edx+0Ch]
        sar eax, 10h
        push eax
        mov eax, dword [byte edx+0Ah]
        sar eax, 10h
        push eax
        push edx
        call DrawShapeCore
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
        call DrawShapeCore
        add esp, byte 0Ch
        pop ebx
        ret
        db 00h,00h
        push ebx
        push esi
        push edi
        mov edx, dword [byte esp+01Ch]
        push edx
        mov ebx, dword [byte esp+01Ch]
        push ebx
        mov ecx, dword [MenuScreenBitmap]
        push ecx
        mov esi, dword [byte esp+020h]
        push esi
        mov edi, dword [byte esp+020h]
        push edi
        call CreateBitmapEx
        add esp, byte 14h
        test eax, eax
        je short .1
        mov eax, dword [eax]
.1:
        pop edi
        pop esi
        pop ebx
        ret
        push ebx
        push esi
        push byte 0
        mov edx, dword [byte esp+018h]
        push edx
        mov ebx, dword [MenuScreenBitmap]
        push ebx
        mov ecx, dword [byte esp+01Ch]
        push ecx
        mov esi, dword [byte esp+01Ch]
        push esi
        call CreateBitmapEx
        add esp, byte 14h
        test eax, eax
        je short .2
        mov eax, dword [eax]
.2:
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CreateBitmap                                 FD08C  95 PC, medium confidence
; Graphics library: create a bitmap (w, h, flags) at the current pixel depth
; (MenuScreenBitmap); returns the bitmap
;-----------------------------------------------------------------------------
CreateBitmap:
        push ebx
        push esi
        push byte 1
        mov edx, dword [byte esp+018h]
        push edx
        mov ebx, dword [MenuScreenBitmap]
        push ebx
        mov ecx, dword [byte esp+01Ch]
        push ecx
        mov esi, dword [byte esp+01Ch]
        push esi
        call CreateBitmapEx
        add esp, byte 14h
        mov eax, dword [eax]
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        push esi
        push edi
        mov ecx, 0Eh
        mov esi, dword [byte esp+0Ch]
        mov edi, ScreenWidth
        mov eax, 1
        rep movsd
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LoadDrawContext                                 FD0DC  97 PC, low confidence
; Copies a saved drawing context (clip window, screen pointers) back into the
; current one
;-----------------------------------------------------------------------------
LoadDrawContext:
        push esi
        push edi
        mov ecx, 0Eh
        mov esi, dword [byte esp+0Ch]
        mov edi, ScreenWidth
        mov eax, 1
        rep movsd
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetDrawTarget                                   FD0F8  97 PC, low confidence
; Makes a bitmap the current draw target: copies its 0Eh-dword header to
; ScreenWidth
;-----------------------------------------------------------------------------
SetDrawTarget:
        push esi
        push edi
        mov ecx, 0Eh
        mov esi, dword [byte esp+0Ch]
        mov edi, ScreenWidth
        rep movsd
        pop edi
        pop esi
        ret
        db 00h,00h,00h
;-----------------------------------------------------------------------------
; ClearScreen                                  FD110  95 PC, medium confidence
; Graphics library: fills the whole current draw target (ClipTopRow..684)
; with a colour (FillRect)
;-----------------------------------------------------------------------------
ClearScreen:
        push ebx
        mov edx, dword [byte esp+08h]
        mov eax, dword [ScreenHeight]
        mov ebx, dword [ClipLeftCol]
        push edx
        sub eax, ebx
        mov ecx, dword [ClipTopRow]
        push eax
        mov eax, dword [ClipRight]
        sub eax, ecx
        push eax
        push ebx
        push ecx
        call FillRect
        add esp, byte 14h
        pop ebx
        ret
        db 00h,00h
;-----------------------------------------------------------------------------
; DrawScaledRow                                   FD140  97 PC, low confidence
; Draws one row of a scaled shape through the span offsets
;-----------------------------------------------------------------------------
DrawScaledRow:
        push ebx
        push esi
        push edi
        push ebp
        mov ecx, dword [byte esp+014h]
        mov ebp, dword [byte esp+018h]
        mov edi, ecx
        shr edi, 10h
        mov eax, edi
        xor edx, edx
        call VesaSetBank
        mov dl, byte [ScreenBitsPerPixel]
        inc edx
        and dl, 0FEh
        mov eax, edx
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        mov esi, eax
        mov eax, dword [byte esp+01Ch]
        imul eax, esi
        mov ebx, 10000h
        and ecx, 0FFFFh
        sub ebx, ecx
        cmp eax, ebx
        jg short .1
        mov edx, dword [byte esp+01Ch]
        push edx
        push ebp
        push ecx
        jmp short .2
.1:
        mov edx, ebx
        mov eax, ebx
        sar edx, 1Fh
        idiv esi
        push eax
        push ebp
        push ecx
        mov ebx, eax
        call CopyScaledSpan
        add esp, byte 0Ch
        lea eax, [byte edi+01h]
        call VesaSetBank
        mov eax, dword [byte esp+01Ch]
        sub eax, ebx
        push eax
        mov eax, dword [nosplit ebx*4+ScaledRowBuffer]
        imul eax, esi
        add eax, ebp
        push eax
        push byte 0
.2:
        call CopyScaledSpan
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawShapeScaledCore                             FD1D8  97 PC, low confidence
; Scales a shape to a width and height: builds the span offsets and draws
; each visible row
;-----------------------------------------------------------------------------
DrawShapeScaledCore:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        mov ebp, dword [byte esp+02Ch]
        mov ebx, dword [byte esp+030h]
        mov edi, dword [byte esp+038h]
        mov eax, dword [byte esp+034h]
        mov esi, dword [byte esp+034h]
        mov eax, dword [byte eax+02h]
        mov esi, dword [byte esi+04h]
        sar eax, 10h
        sar esi, 10h
        mov dword [byte esp+04h], eax
        test ebp, ebp
        je near .16
        test ebx, ebx
        je near .16
        xor edx, edx
        mov eax, dword [byte esp+034h]
        mov dword [esp], edx
        mov eax, dword [eax]
        mov dl, byte [str_Punct_FreeArtArchive]
        and eax, 0FFh
        cmp eax, edx
        je short .1
        xor eax, eax
        mov al, dl
        push eax
        mov ecx, dword [byte esp+038h]
        push ecx
        call ConvertArtSame
        add esp, byte 8
        mov dword [esp], eax
        mov dword [byte esp+034h], eax
.1:
        cmp edi, dword [ClipRight]
        jge near .15
        mov eax, dword [byte esp+03Ch]
        cmp eax, dword [ScreenHeight]
        jge near .15
        test ebp, ebp
        jle short .2
        mov eax, ebp
        jmp short .3
.2:
        mov eax, ebp
        neg eax
.3:
        mov ecx, dword [ClipTopRow]
        add eax, edi
        cmp eax, ecx
        jle near .15
        test ebx, ebx
        jle short .4
        mov eax, ebx
        jmp short .5
.4:
        mov eax, ebx
        neg eax
.5:
        mov edx, dword [byte esp+03Ch]
        mov ecx, dword [ClipLeftCol]
        add eax, edx
        cmp eax, ecx
        jle near .15
        mov eax, dword [byte esp+034h]
        push eax
        call ShapeRowBytes
        add esp, byte 4
        mov edx, dword [byte esp+04h]
        shl edx, 10h
        mov dword [byte esp+08h], eax
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        shl esi, 10h
        mov ecx, eax
        mov edx, esi
        mov eax, esi
        sar edx, 1Fh
        idiv ebx
        mov edx, eax
        sar edx, 1Fh
        mov dword [byte esp+010h], eax
        LD sub, eax, edx
        sar eax, 1
        test ebx, ebx
        jge short .6
        neg ebx
        add esi, eax
        jmp short .7
.6:
        mov esi, eax
.7:
        mov edx, ecx
        mov eax, ecx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        test ebp, ebp
        jge short .8
        mov edx, dword [byte esp+04h]
        shl edx, 10h
        neg ebp
        add eax, edx
.8:
        mov edx, dword [byte esp+03Ch]
        cmp edx, dword [ClipLeftCol]
        jge short .9
        mov edx, dword [ClipLeftCol]
        sub edx, dword [byte esp+03Ch]
        mov dword [byte esp+014h], edx
        mov edx, dword [byte esp+010h]
        imul edx, dword [byte esp+014h]
        add esi, edx
        sub ebx, dword [byte esp+014h]
        mov edx, dword [ClipLeftCol]
        mov dword [byte esp+03Ch], edx
.9:
        mov edx, dword [byte esp+03Ch]
        add edx, ebx
        cmp edx, dword [ScreenHeight]
        jle short .10
        mov edx, dword [byte esp+03Ch]
        mov ebx, dword [ScreenHeight]
        sub ebx, edx
.10:
        mov edx, dword [ClipTopRow]
        cmp edi, edx
        jge short .11
        sub edx, edi
        mov edi, edx
        mov edx, ecx
        imul edx, edi
        sub ebp, edi
        mov edi, dword [ClipTopRow]
        add eax, edx
.11:
        lea edx, [edi+ebp]
        cmp edx, dword [ClipRight]
        jle short .12
        mov ebp, dword [ClipRight]
        sub ebp, edi
.12:
        mov edx, dword [byte esp+03Ch]
        shl edx, 2
        mov dword [byte esp+014h], edx
        mov edx, dword [DrawDestBuffer]
        add edx, dword [byte esp+014h]
        shl edi, 2
        mov dword [byte esp+014h], edx
        mov edx, dword [DrawDestOffset]
        add edi, edx
        mov edx, dword [byte esp+014h]
        mov edx, dword [edx]
        mov dword [byte esp+014h], edx
        mov edx, dword [edi]
        mov edi, dword [byte esp+014h]
        add edi, edx
        mov dword [byte esp+0Ch], CopyScaledSpan
        mov edx, dword [ScreenBuffer]
        test edx, edx
        je short .13
        mov dword [byte esp+0Ch], DrawScaledRow
.13:
        test ecx, ecx
        push ebp
        mov edx, dword [byte esp+08h]
        push edx
        push byte 0
        push ecx
        push byte 0
        push eax
        push ScaledRowBuffer
        call BuildSpanOffsets
        add esp, byte 1Ch
        mov eax, dword [byte esp+034h]
        push ScaledRowBuffer
        add eax, byte 10h
        push eax
        call SetBlitSource
        add esp, byte 8
.14:
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je short .15
        mov eax, esi
        mov ecx, dword [byte esp+08h]
        sar eax, 10h
        imul eax, ecx
        push ebp
        push eax
        push edi
        call dword [byte esp+018h]
        add esp, byte 0Ch
        mov eax, dword [ScreenPitch]
        mov edx, dword [byte esp+010h]
        add edi, eax
        add esi, edx
        jmp short .14
.15:
        mov ebx, dword [esp]
        test ebx, ebx
        je short .16
        push ebx
        call FreeMemBlock
        add esp, byte 4
.16:
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawShapeScaledFit                              FD440  97 PC, low confidence
; Scales a shape to fit a box, keeping its aspect
;-----------------------------------------------------------------------------
DrawShapeScaledFit:
        push ebx
        push esi
        push edi
        mov ecx, dword [byte esp+018h]
        mov edx, dword [byte esp+010h]
        mov edi, dword [byte ecx+02h]
        shl edx, 10h
        sar edi, 10h
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        mov ebx, dword [byte ecx+04h]
        mov edx, dword [byte esp+014h]
        sar ebx, 10h
        shl edx, 10h
        mov esi, eax
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov ebx, eax
        test esi, esi
        jl short .1
        mov edx, dword [byte ecx+06h]
        mov eax, esi
        sar edx, 10h
        mov esi, dword [byte esp+01Ch]
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        sub esi, eax
        jmp short .2
.1:
        mov edx, dword [byte ecx+06h]
        sar edx, 10h
        sub edi, edx
        mov eax, esi
        mov edx, edi
        mov esi, dword [byte esp+01Ch]
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        add esi, eax
.2:
        test ebx, ebx
        jl short .3
        mov edx, dword [byte ecx+08h]
        mov eax, ebx
        sar edx, 10h
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov edx, dword [byte esp+020h]
        sub edx, eax
        mov eax, edx
        jmp short .4
.3:
        mov edx, dword [byte ecx+04h]
        mov eax, dword [byte ecx+08h]
        sar edx, 10h
        sar eax, 10h
        sub edx, eax
        mov eax, ebx
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        add eax, dword [byte esp+020h]
.4:
        push eax
        push esi
        push ecx
        mov ebx, dword [byte esp+020h]
        push ebx
        mov ecx, dword [byte esp+020h]
        push ecx
        call DrawShapeScaledCore
        add esp, byte 14h
        pop edi
        pop esi
        pop ebx
        ret
        push ebx
        mov edx, dword [byte esp+010h]
        mov eax, dword [byte edx+0Ch]
        sar eax, 10h
        push eax
        mov eax, dword [byte edx+0Ah]
        sar eax, 10h
        push eax
        push edx
        mov edx, dword [byte esp+018h]
        push edx
        mov ebx, dword [byte esp+018h]
        push ebx
        call DrawShapeScaledCore
        add esp, byte 14h
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawShapeScaledBy                               FD528  97 PC, low confidence
; Scales a shape by a factor and draws it
;-----------------------------------------------------------------------------
DrawShapeScaledBy:
        push ebx
        push esi
        mov eax, dword [byte esp+0Ch]
        mov ecx, dword [byte esp+010h]
        test eax, eax
        jle short .1
        mov edx, eax
        jmp short .2
.1:
        mov edx, eax
        neg edx
.2:
        mov ebx, dword [byte ecx+02h]
        sar ebx, 10h
        imul ebx, eax
        mov eax, dword [byte ecx+04h]
        sar eax, 10h
        imul eax, edx
        mov edx, dword [byte esp+018h]
        push edx
        mov esi, dword [byte esp+018h]
        push esi
        push ecx
        sar eax, 10h
        push eax
        sar ebx, 10h
        push ebx
        call DrawShapeScaledCore
        add esp, byte 14h
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawShapeScaledFlip                             FD570  97 PC, low confidence
; Scales a shape by a factor, mirroring it for negative factors
;-----------------------------------------------------------------------------
DrawShapeScaledFlip:
        push ebx
        push esi
        push edi
        push ebp
        mov eax, dword [byte esp+014h]
        mov ebx, dword [byte esp+018h]
        test eax, eax
        jle short .1
        mov edx, eax
        jmp short .2
.1:
        mov edx, eax
        neg edx
.2:
        mov ecx, dword [byte ebx+02h]
        mov edi, eax
        sar ecx, 10h
        imul edi, ecx
        mov ebp, dword [byte ebx+04h]
        sar ebp, 10h
        imul ebp, edx
        mov esi, edx
        sar edi, 10h
        sar ebp, 10h
        test eax, eax
        jl short .3
        mov edx, dword [byte ebx+06h]
        sar edx, 10h
        mov ecx, dword [byte esp+01Ch]
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        sub ecx, eax
        jmp short .4
.3:
        mov edx, dword [byte ebx+06h]
        sar edx, 10h
        sub ecx, edx
        mov edx, ecx
        mov ecx, dword [byte esp+01Ch]
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        add ecx, eax
.4:
        mov edx, dword [byte ebx+08h]
        mov eax, esi
        sar edx, 10h
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov edx, dword [byte esp+020h]
        sub edx, eax
        push edx
        push ecx
        push ebx
        push ebp
        push edi
        call DrawShapeScaledCore
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push esi
        push edi
        mov edx, dword [byte esp+020h]
        push edx
        mov ebx, dword [byte esp+020h]
        push ebx
        mov ecx, dword [byte esp+020h]
        push ecx
        mov esi, dword [byte esp+020h]
        push esi
        mov edi, dword [byte esp+020h]
        push edi
        call DrawShapeScaledCore
        add esp, byte 14h
        pop edi
        pop esi
        pop ebx
        ret
        push ebx
        push esi
        push edi
        mov edx, dword [byte esp+020h]
        push edx
        mov ebx, dword [byte esp+020h]
        push ebx
        mov ecx, dword [byte esp+020h]
        push ecx
        mov esi, dword [byte esp+020h]
        push esi
        mov edi, dword [byte esp+020h]
        push edi
        call DrawShapeScaledFit
        add esp, byte 14h
        pop edi
        pop esi
        pop ebx
        ret
        push ebx
        mov edx, dword [byte esp+010h]
        mov eax, dword [byte edx+0Ch]
        sar eax, 10h
        push eax
        mov eax, dword [byte edx+0Ah]
        sar eax, 10h
        push eax
        push edx
        mov edx, dword [byte esp+018h]
        push edx
        mov ebx, dword [byte esp+018h]
        push ebx
        call DrawShapeScaledCore
        add esp, byte 14h
        pop ebx
        ret
        push ebx
        push esi
        mov edx, dword [byte esp+018h]
        push edx
        mov ebx, dword [byte esp+018h]
        push ebx
        mov ecx, dword [byte esp+018h]
        push ecx
        mov esi, dword [byte esp+018h]
        push esi
        call DrawShapeScaledBy
        add esp, byte 10h
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push esi
        mov edx, dword [byte esp+018h]
        push edx
        mov ebx, dword [byte esp+018h]
        push ebx
        mov ecx, dword [byte esp+018h]
        push ecx
        mov esi, dword [byte esp+018h]
        push esi
        call DrawShapeScaledFlip
        add esp, byte 10h
        pop esi
        pop ebx
        ret
