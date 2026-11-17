; 3D library: RasterShapeTriangle, DrawShapeTriangleMapped, ScanGetChar, ScanUngetChar and 12 more.
bits 32
%include "hockey.inc"
section s_130925 progbits alloc exec nowrite align=1
extern __EFG_scanf, __FDFS, _IsTable, BuildSpanOffsets, ClipLeftCol, ClipRight, ClipTopRow, CopyMappedSpan
extern DrawDestBuffer, DrawDestOffset, memset_, ScaledRowBuffer, ScanBitMasks, ScreenHeight, SetBlitSource, ShadeTable
extern tolower_
global RasterShapeTriangle, DrawShapeTriangleMapped, ScanGetChar, ScanUngetChar, ScanFormat, ScanParseSpec, ScanSkipSpace, ScanStoreCount
global ScanStoreCount_8F, ScanChars, ScanStoreInt, ScanBuildCharSet, ScanCharSet, ScanFloatField, ScanIntegerField, HexDigitValue
global ScanGetCharWidth
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RasterShapeTriangle                            130928  97 PC, low confidence
; Draws one triangle of a shape mapped onto screen coordinates, stepping
; source and destination edges in fixed point
;-----------------------------------------------------------------------------
RasterShapeTriangle:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 74h
        mov ebx, dword [dword esp+088h]
        mov eax, dword [byte ebx+02h]
        sar eax, 10h
        push ScaledRowBuffer
        mov dword [byte esp+060h], eax
        lea eax, [byte ebx+010h]
        push eax
        call SetBlitSource
        add esp, byte 8
        mov eax, ebx
        xor edx, edx
        mov eax, dword [eax]
        and eax, byte 7Fh
        mov al, byte [dword eax+ShadeTable]
        mov dword [byte esp+068h], edx
        cmp eax, byte 20h
        jne short .1
        mov dword [byte esp+068h], 2
.1:
        mov eax, ebx
        mov eax, dword [eax]
        and eax, byte 7Fh
        mov al, byte [dword eax+ShadeTable]
        inc eax
        and al, 0FEh
        cmp eax, byte 10h
        jne short .2
        mov dword [byte esp+068h], 1
.2:
        mov eax, dword [dword esp+090h]
        xor edi, edi
        mov edx, dword [dword esp+090h]
        mov dword [byte esp+030h], edi
        mov eax, dword [byte eax+0Ch]
        mov ebx, dword [byte edx+04h]
        mov dword [byte esp+028h], edi
        cmp eax, ebx
        jle short .3
        mov dword [byte esp+030h], 1
.3:
        mov eax, dword [byte esp+028h]
        mov esi, dword [dword esp+090h]
        shl eax, 3
        add eax, esi
        mov edx, dword [byte esi+0Ch]
        cmp edx, dword [byte eax+04h]
        jge short .4
        mov dword [byte esp+028h], 1
.4:
        mov eax, dword [byte esp+030h]
        mov edx, dword [dword esp+090h]
        shl eax, 3
        add edx, eax
        mov eax, dword [dword esp+090h]
        mov ebx, dword [byte edx+04h]
        cmp ebx, dword [byte eax+014h]
        jge short .5
        mov dword [byte esp+030h], 2
.5:
        mov eax, dword [byte esp+028h]
        mov edx, dword [dword esp+090h]
        shl eax, 3
        add edx, eax
        mov eax, dword [dword esp+090h]
        mov esi, dword [byte edx+04h]
        cmp esi, dword [byte eax+014h]
        jle short .6
        mov dword [byte esp+028h], 2
.6:
        mov eax, dword [byte esp+028h]
        mov ebp, dword [byte esp+030h]
        mov edx, 3
        or eax, ebp
        sub edx, eax
        mov ebx, dword [dword esp+090h]
        mov dword [byte esp+018h], edx
        lea eax, [nosplit edx*8+00h]
        mov ecx, dword [byte esp+028h]
        mov edx, dword [dword esp+090h]
        shl ecx, 3
        add eax, edx
        add ecx, ebx
        mov edx, dword [byte eax+04h]
        mov eax, dword [eax]
        mov dword [byte esp+024h], edx
        mov dword [byte esp+020h], eax
        mov eax, edx
        lea edx, [nosplit ebp*8+00h]
        sar eax, 10h
        add edx, ebx
        mov edi, dword [ecx]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [edx]
        sub eax, edi
        mov ebp, dword [byte ecx+04h]
        mov dword [byte esp+01Ch], eax
        mov eax, dword [byte edx+04h]
        sub eax, ebp
        mov dword [byte esp+02Ch], eax
        cmp eax, 10000h
        jl near .58
        mov edx, dword [byte esp+024h]
        mov ebx, eax
        mov eax, dword [byte esp+01Ch]
        sub edx, ebp
        imul edx
        idiv ebx
        mov edx, dword [ecx]
        mov esi, dword [byte esp+020h]
        add edx, eax
        xor ecx, ecx
        mov dword [byte esp+014h], edx
        sub esi, edx
        mov dword [byte esp+010h], ecx
        mov edi, esi
        test esi, esi
        jge short .7
        mov ebp, 1
        neg esi
        mov dword [byte esp+010h], ebp
.7:
        cmp esi, 10000h
        jl near .58
        cmp esi, 6000000h
        jge near .58
        mov eax, dword [byte esp+030h]
        mov ebp, dword [dword esp+090h]
        shl eax, 3
        mov ecx, dword [dword esp+08Ch]
        add ebp, eax
        add ecx, eax
        mov eax, dword [byte esp+024h]
        mov edx, dword [byte ebp+04h]
        sub edx, eax
        mov eax, dword [byte esp+028h]
        mov ebx, dword [dword esp+08Ch]
        shl eax, 3
        add ebx, eax
        mov dword [byte esp+04h], ebx
        mov eax, dword [ebx]
        sub eax, dword [ecx]
        mov ebx, dword [byte esp+02Ch]
        imul edx
        idiv ebx
        mov edx, dword [ecx]
        mov ebx, dword [byte ecx+04h]
        add edx, eax
        mov eax, dword [byte esp+04h]
        mov dword [esp], edx
        mov edx, dword [byte ebp+04h]
        mov eax, dword [byte eax+04h]
        mov ebp, dword [byte esp+024h]
        sub eax, ebx
        mov ebx, dword [byte esp+02Ch]
        sub edx, ebp
        imul edx
        idiv ebx
        mov ebp, dword [byte ecx+04h]
        add ebp, eax
        mov eax, dword [byte esp+018h]
        mov ecx, dword [dword esp+08Ch]
        shl eax, 3
        add eax, ecx
        mov edx, dword [esp]
        mov eax, dword [eax]
        sub eax, edx
        test edi, edi
        je short .8
        mov ebx, edi
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
.8:
        mov dword [byte esp+08h], eax
        mov eax, dword [byte esp+018h]
        mov ebx, dword [dword esp+08Ch]
        shl eax, 3
        add eax, ebx
        mov eax, dword [byte eax+04h]
        sub eax, ebp
        test edi, edi
        je short .9
        mov ebx, edi
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
.9:
        sar esi, 10h
        inc esi
        push esi
        mov ecx, dword [byte esp+060h]
        push ecx
        push eax
        mov esi, dword [byte esp+014h]
        push esi
        push dword 8000h
        push dword 8000h
        push ScaledRowBuffer
        call BuildSpanOffsets
        add esp, byte 1Ch
        mov edx, dword [byte esp+028h]
        mov eax, dword [dword esp+090h]
        shl edx, 3
        mov edi, dword [dword esp+08Ch]
        add eax, edx
        add edx, edi
        mov esi, dword [byte eax+04h]
        mov ebp, dword [eax]
        mov edi, dword [edx]
        mov edx, dword [byte edx+04h]
        sar esi, 10h
        mov dword [byte esp+070h], edx
        mov edx, dword [byte esp+010h]
        mov dword [byte esp+06Ch], ebp
        test edx, edx
        je near .12
        mov edx, dword [byte esp+018h]
        mov ebx, dword [dword esp+08Ch]
        shl edx, 3
        add edx, ebx
        mov ecx, dword [edx]
        mov ebx, dword [byte eax+04h]
        mov edx, edi
        mov eax, dword [byte esp+024h]
        sub edx, ecx
        sub ebx, eax
        je short .10
        mov eax, edx
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
        jmp short .11
.10:
        mov eax, edx
.11:
        mov edx, dword [byte esp+028h]
        mov dword [byte esp+064h], eax
        mov eax, dword [byte esp+018h]
        mov ecx, dword [dword esp+08Ch]
        shl eax, 3
        shl edx, 3
        lea ebx, [ecx+eax]
        mov eax, dword [byte ecx+edx+04h]
        mov ecx, dword [byte ebx+04h]
        add edx, dword [dword esp+090h]
        sub eax, ecx
        mov ecx, dword [byte esp+024h]
        mov ebx, dword [byte edx+04h]
        sub ebx, ecx
        je near .16
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
        jmp near .16
.12:
        mov ebx, dword [byte esp+030h]
        mov edx, dword [dword esp+08Ch]
        shl ebx, 3
        mov ecx, edi
        sub ecx, dword [edx+ebx]
        mov edx, ecx
        add ebx, dword [dword esp+090h]
        mov eax, dword [byte eax+04h]
        sub eax, dword [byte ebx+04h]
        je short .13
        mov ebx, eax
        mov eax, edx
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
        jmp short .14
.13:
        mov eax, edx
.14:
        mov ecx, dword [byte esp+028h]
        mov ebx, dword [byte esp+030h]
        mov dword [byte esp+064h], eax
        mov eax, dword [dword esp+08Ch]
        shl ecx, 3
        mov edx, eax
        shl ebx, 3
        mov eax, dword [byte ecx+eax+04h]
        sub eax, dword [byte edx+ebx+04h]
        mov edx, eax
        mov eax, dword [dword esp+090h]
        add ecx, eax
        add ebx, eax
        mov eax, dword [byte ecx+04h]
        sub eax, dword [byte ebx+04h]
        je short .15
        mov ebx, eax
        mov eax, edx
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
        jmp short .16
.15:
        mov eax, edx
.16:
        mov dword [byte esp+060h], eax
        cmp esi, dword [byte esp+0Ch]
        jge near .36
        mov eax, dword [byte esp+028h]
        mov edx, dword [dword esp+090h]
        shl eax, 3
        mov ebx, dword [byte esp+010h]
        add eax, edx
        test ebx, ebx
        je short .21
        mov ebx, dword [byte esp+020h]
        mov edx, dword [eax]
        mov ecx, dword [byte esp+024h]
        sub edx, ebx
        mov ebx, dword [byte eax+04h]
        sub ebx, ecx
        je short .17
        mov eax, edx
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
        jmp short .18
.17:
        mov eax, edx
.18:
        mov dword [byte esp+04Ch], eax
        mov eax, dword [byte esp+02Ch]
        test eax, eax
        je short .19
        mov ebx, eax
        mov eax, dword [byte esp+01Ch]
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
        jmp short .20
.19:
        mov eax, dword [byte esp+01Ch]
.20:
        mov dword [byte esp+044h], eax
        jmp short .26
.21:
        mov ecx, dword [byte esp+020h]
        mov edx, dword [eax]
        mov ebx, dword [byte eax+04h]
        mov eax, dword [byte esp+024h]
        sub edx, ecx
        sub ebx, eax
        je short .22
        mov eax, edx
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
        jmp short .23
.22:
        mov eax, edx
.23:
        mov edx, dword [byte esp+02Ch]
        mov dword [byte esp+044h], eax
        test edx, edx
        je short .24
        mov eax, dword [byte esp+01Ch]
        mov ebx, edx
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
        jmp short .25
.24:
        mov eax, dword [byte esp+01Ch]
.25:
        mov dword [byte esp+04Ch], eax
.26:
        mov edx, dword [byte esp+0Ch]
        mov eax, dword [ScreenHeight]
        cmp eax, edx
        jl short .27
        mov eax, edx
.27:
        mov ebx, dword [ClipLeftCol]
        mov dword [byte esp+038h], eax
        cmp esi, ebx
        jl near .30
        mov edx, dword [byte esp+028h]
        mov ecx, dword [dword esp+08Ch]
        shl edx, 3
        add edx, ecx
        mov ecx, dword [ClipTopRow]
        mov ebx, dword [edx]
        cmp ebx, ecx
        jl near .30
        mov edx, ebx
        mov ebx, dword [ClipRight]
        cmp edx, ebx
        jge near .30
        mov edx, dword [byte esp+020h]
        cmp edx, ecx
        jl near .30
        cmp edx, ebx
        jge near .30
        mov edx, dword [byte esp+014h]
        cmp edx, ecx
        jl near .30
        cmp edx, ebx
        jge near .30
        shl eax, 2
        lea ebx, [nosplit esi*4+00h]
        mov dword [byte esp+040h], eax
.28:
        cmp ebx, dword [byte esp+040h]
        jge near .36
        mov eax, dword [byte esp+06Ch]
        mov edx, ebp
        sar eax, 10h
        sar edx, 10h
        sub edx, eax
        test edx, edx
        jle short .29
        push edx
        mov edx, dword [byte esp+074h]
        mov ecx, dword [byte esp+060h]
        sar edx, 10h
        imul ecx, edx
        mov edx, edi
        sar edx, 10h
        add ecx, edx
        mov dword [byte esp+08h], ecx
        mov cl, byte [byte esp+06Ch]
        mov edx, dword [byte esp+08h]
        shl eax, 2
        shl edx, cl
        mov ecx, dword [DrawDestOffset]
        push edx
        add ecx, eax
        mov edx, dword [DrawDestBuffer]
        mov eax, dword [edx+ebx]
        add eax, dword [ecx]
        push eax
        call CopyMappedSpan
        add esp, byte 0Ch
.29:
        mov eax, dword [byte esp+064h]
        mov edx, dword [byte esp+070h]
        mov ecx, dword [byte esp+06Ch]
        add ebx, byte 4
        add edi, eax
        mov eax, dword [byte esp+060h]
        inc esi
        add edx, eax
        mov eax, dword [byte esp+04Ch]
        mov dword [byte esp+070h], edx
        add ecx, eax
        mov eax, dword [byte esp+044h]
        mov dword [byte esp+06Ch], ecx
        add ebp, eax
        jmp near .28
.30:
        lea eax, [nosplit esi*4+00h]
.31:
        mov dword [byte esp+054h], eax
        cmp esi, dword [byte esp+038h]
        jge near .36
        mov edx, dword [byte esp+06Ch]
        mov eax, ebp
        sar edx, 10h
        sar eax, 10h
        sub eax, edx
        mov ecx, dword [ClipRight]
        lea ebx, [edx+eax]
        sub ebx, ecx
        test ebx, ebx
        jle short .32
        sub eax, ebx
.32:
        mov ebx, dword [ClipTopRow]
        sub ebx, edx
        test ebx, ebx
        jle short .33
        sub eax, ebx
        add edx, ebx
        jmp short .34
.33:
        xor ebx, ebx
.34:
        test eax, eax
        jle short .35
        cmp esi, dword [ClipLeftCol]
        jl short .35
        push eax
        mov eax, dword [byte esp+074h]
        mov ecx, dword [byte esp+060h]
        sar eax, 10h
        imul ecx, eax
        mov eax, edi
        sar eax, 10h
        add eax, ecx
        add eax, dword [nosplit ebx*4+ScaledRowBuffer]
        mov cl, byte [byte esp+06Ch]
        shl eax, cl
        mov ebx, dword [byte esp+058h]
        push eax
        mov eax, dword [DrawDestBuffer]
        shl edx, 2
        add ebx, eax
        mov eax, dword [DrawDestOffset]
        add edx, eax
        mov eax, dword [ebx]
        add eax, dword [edx]
        push eax
        call CopyMappedSpan
        add esp, byte 0Ch
.35:
        mov ecx, dword [byte esp+064h]
        mov eax, dword [byte esp+060h]
        mov edx, dword [byte esp+070h]
        mov ebx, dword [byte esp+06Ch]
        inc esi
        add edi, ecx
        add edx, eax
        mov eax, dword [byte esp+04Ch]
        mov ecx, dword [byte esp+044h]
        mov dword [byte esp+070h], edx
        add ebx, eax
        mov eax, dword [byte esp+054h]
        add ebp, ecx
        add eax, byte 4
        mov dword [byte esp+06Ch], ebx
        jmp near .31
.36:
        mov eax, dword [byte esp+030h]
        mov edx, dword [dword esp+090h]
        shl eax, 3
        add eax, edx
        mov edx, dword [byte eax+04h]
        sar edx, 10h
        cmp esi, edx
        jge near .58
        cmp dword [byte esp+010h], byte 0
        je near .43
        mov edx, dword [byte esp+020h]
        mov ebx, dword [eax]
        mov ecx, dword [byte eax+04h]
        sub edx, ebx
        mov ebx, dword [byte esp+024h]
        sub ebx, ecx
        je short .37
        mov eax, edx
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
        jmp short .38
.37:
        mov eax, edx
.38:
        mov edi, dword [byte esp+02Ch]
        mov dword [byte esp+048h], eax
        test edi, edi
        je short .39
        mov eax, dword [byte esp+01Ch]
        mov ebx, edi
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
        jmp short .40
.39:
        mov eax, dword [byte esp+01Ch]
.40:
        mov dword [byte esp+050h], eax
        mov eax, dword [byte esp+020h]
        mov dword [byte esp+06Ch], eax
        mov eax, dword [byte esp+018h]
        mov edx, dword [dword esp+08Ch]
        shl eax, 3
        add eax, edx
        mov edi, dword [eax]
        mov eax, dword [byte eax+04h]
        mov edx, dword [byte esp+030h]
        mov dword [byte esp+070h], eax
        mov eax, dword [dword esp+08Ch]
        shl edx, 3
        mov ebx, dword [dword esp+090h]
        mov ecx, dword [edx+eax]
        mov eax, edi
        add edx, ebx
        mov ebx, dword [byte esp+024h]
        sub eax, ecx
        sub ebx, dword [byte edx+04h]
        je short .41
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
.41:
        mov dword [byte esp+064h], eax
        mov eax, dword [byte esp+018h]
        mov edx, dword [dword esp+08Ch]
        shl eax, 3
        add eax, edx
        mov edx, dword [byte esp+030h]
        mov ebx, dword [dword esp+08Ch]
        shl edx, 3
        mov ecx, dword [byte edx+ebx+04h]
        mov ebx, dword [dword esp+090h]
        mov eax, dword [byte eax+04h]
        add edx, ebx
        sub eax, ecx
        mov ebx, dword [byte esp+024h]
        sub ebx, dword [byte edx+04h]
        je short .42
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
.42:
        mov dword [byte esp+060h], eax
        jmp short .48
.43:
        mov edx, dword [byte esp+020h]
        mov ebx, dword [byte esp+024h]
        mov ecx, dword [eax]
        mov ebp, dword [byte eax+04h]
        sub edx, ecx
        sub ebx, ebp
        je short .44
        mov eax, edx
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
        jmp short .45
.44:
        mov eax, edx
.45:
        mov dword [byte esp+050h], eax
        mov eax, dword [byte esp+02Ch]
        test eax, eax
        je short .46
        mov ebx, eax
        mov eax, dword [byte esp+01Ch]
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
        jmp short .47
.46:
        mov eax, dword [byte esp+01Ch]
.47:
        mov ebp, dword [byte esp+020h]
        mov dword [byte esp+048h], eax
.48:
        mov eax, dword [byte esp+030h]
        mov edx, dword [dword esp+090h]
        shl eax, 3
        add eax, edx
        mov eax, dword [byte eax+04h]
        mov ebx, dword [ScreenHeight]
        sar eax, 10h
        cmp eax, ebx
        jle short .49
        mov eax, ebx
.49:
        mov ecx, dword [ClipLeftCol]
        mov dword [byte esp+034h], eax
        cmp esi, ecx
        jl near .52
        mov edx, dword [byte esp+030h]
        mov ebx, dword [dword esp+08Ch]
        shl edx, 3
        add edx, ebx
        mov ecx, dword [ClipTopRow]
        mov ebx, dword [edx]
        cmp ebx, ecx
        jl near .52
        mov edx, ebx
        mov ebx, dword [ClipRight]
        cmp edx, ebx
        jge near .52
        mov edx, dword [byte esp+020h]
        cmp edx, ecx
        jl near .52
        cmp edx, ebx
        jge near .52
        mov edx, dword [byte esp+014h]
        cmp edx, ecx
        jl near .52
        cmp edx, ebx
        jge near .52
        shl eax, 2
        lea ebx, [nosplit esi*4+00h]
        mov dword [byte esp+03Ch], eax
.50:
        cmp ebx, dword [byte esp+03Ch]
        jge near .58
        mov eax, dword [byte esp+06Ch]
        mov edx, ebp
        sar eax, 10h
        sar edx, 10h
        sub edx, eax
        test edx, edx
        jle short .51
        push edx
        mov edx, dword [byte esp+074h]
        mov ecx, dword [byte esp+060h]
        sar edx, 10h
        imul ecx, edx
        mov edx, edi
        sar edx, 10h
        add ecx, edx
        mov dword [byte esp+08h], ecx
        mov cl, byte [byte esp+06Ch]
        mov edx, dword [byte esp+08h]
        shl edx, cl
        push edx
        mov edx, dword [DrawDestBuffer]
        add edx, ebx
        shl eax, 2
        mov dword [byte esp+0Ch], edx
        mov edx, dword [DrawDestOffset]
        add edx, eax
        mov eax, dword [byte esp+0Ch]
        mov ecx, dword [edx]
        mov eax, dword [eax]
        add eax, ecx
        push eax
        call CopyMappedSpan
        add esp, byte 0Ch
.51:
        mov eax, dword [byte esp+064h]
        mov edx, dword [byte esp+070h]
        mov ecx, dword [byte esp+06Ch]
        add ebx, byte 4
        add edi, eax
        mov eax, dword [byte esp+060h]
        inc esi
        add edx, eax
        mov eax, dword [byte esp+048h]
        mov dword [byte esp+070h], edx
        add ecx, eax
        mov eax, dword [byte esp+050h]
        mov dword [byte esp+06Ch], ecx
        add ebp, eax
        jmp near .50
.52:
        lea eax, [nosplit esi*4+00h]
.53:
        mov dword [byte esp+058h], eax
        cmp esi, dword [byte esp+034h]
        jge near .58
        mov edx, dword [byte esp+06Ch]
        mov eax, ebp
        sar edx, 10h
        sar eax, 10h
        sub eax, edx
        mov ecx, dword [ClipRight]
        lea ebx, [edx+eax]
        sub ebx, ecx
        test ebx, ebx
        jle short .54
        sub eax, ebx
.54:
        mov ebx, dword [ClipTopRow]
        sub ebx, edx
        test ebx, ebx
        jle short .55
        sub eax, ebx
        add edx, ebx
        jmp short .56
.55:
        xor ebx, ebx
.56:
        test eax, eax
        jle short .57
        cmp esi, dword [ClipLeftCol]
        jl short .57
        push eax
        mov eax, dword [byte esp+074h]
        mov ecx, dword [byte esp+060h]
        sar eax, 10h
        imul eax, ecx
        mov ecx, edi
        sar ecx, 10h
        add eax, ecx
        add eax, dword [nosplit ebx*4+ScaledRowBuffer]
        mov cl, byte [byte esp+06Ch]
        shl eax, cl
        mov ebx, dword [byte esp+05Ch]
        push eax
        mov eax, dword [DrawDestBuffer]
        shl edx, 2
        add ebx, eax
        mov eax, dword [DrawDestOffset]
        add edx, eax
        mov eax, dword [ebx]
        add eax, dword [edx]
        push eax
        call CopyMappedSpan
        add esp, byte 0Ch
.57:
        mov ecx, dword [byte esp+064h]
        mov eax, dword [byte esp+060h]
        mov edx, dword [byte esp+070h]
        mov ebx, dword [byte esp+06Ch]
        inc esi
        add edi, ecx
        add edx, eax
        mov eax, dword [byte esp+048h]
        mov ecx, dword [byte esp+050h]
        mov dword [byte esp+070h], edx
        add ebx, eax
        mov eax, dword [byte esp+058h]
        add ebp, ecx
        add eax, byte 4
        mov dword [byte esp+06Ch], ebx
        jmp near .53
.58:
        add esp, byte 74h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawShapeTriangleMapped                        13130C  97 PC, low confidence
; Converts a source and a destination triangle to 16.16 fixed point and draws
; the mapped shape triangle
;-----------------------------------------------------------------------------
DrawShapeTriangleMapped:
        push ebx
        sub esp, byte 30h
        mov edx, dword [byte esp+03Ch]
        mov eax, dword [byte esp+040h]
        mov ebx, dword [edx]
        shl ebx, 10h
        add ebx, 8000h
        mov dword [byte esp+018h], ebx
        mov ebx, dword [byte edx+04h]
        shl ebx, 10h
        add ebx, 8000h
        mov dword [byte esp+01Ch], ebx
        mov ebx, dword [byte edx+08h]
        shl ebx, 10h
        add ebx, 8000h
        mov dword [byte esp+020h], ebx
        mov ebx, dword [byte edx+0Ch]
        shl ebx, 10h
        add ebx, 8000h
        mov dword [byte esp+024h], ebx
        mov ebx, dword [byte edx+010h]
        shl ebx, 10h
        add ebx, 8000h
        mov dword [byte esp+028h], ebx
        mov edx, dword [byte edx+014h]
        shl edx, 10h
        add edx, 8000h
        mov dword [byte esp+02Ch], edx
        mov edx, dword [eax]
        shl edx, 10h
        add edx, 8000h
        mov dword [esp], edx
        mov edx, dword [byte eax+04h]
        shl edx, 10h
        add edx, 8000h
        mov dword [byte esp+04h], edx
        mov edx, dword [byte eax+08h]
        shl edx, 10h
        add edx, 8000h
        mov dword [byte esp+08h], edx
        mov edx, dword [byte eax+0Ch]
        shl edx, 10h
        add edx, 8000h
        mov dword [byte esp+0Ch], edx
        mov edx, dword [byte eax+010h]
        shl edx, 10h
        add edx, 8000h
        mov dword [byte esp+010h], edx
        mov eax, dword [byte eax+014h]
        shl eax, 10h
        add eax, 8000h
        mov dword [byte esp+014h], eax
        mov eax, esp
        push eax
        lea eax, [byte esp+01Ch]
        push eax
        mov edx, dword [byte esp+040h]
        push edx
        call RasterShapeTriangle
        add esp, byte 0Ch
        add esp, byte 30h
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ScanGetChar                                    1313EE  97 PC, low confidence
; Calls the scanf input's get-character function
;-----------------------------------------------------------------------------
ScanGetChar:
        push edx
        mov edx, eax
        call dword [edx]
        pop edx
        ret
;-----------------------------------------------------------------------------
; ScanUngetChar                                  1313F5  97 PC, low confidence
; Calls the scanf input's push-back function
;-----------------------------------------------------------------------------
ScanUngetChar:
        push ebx
        mov ebx, edx
        call dword [byte ebx+04h]
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ScanFormat                                     1313FD  97 PC, low confidence
; Scanf engine: walks the format string, matches literal text and calls the
; converter of each field
;-----------------------------------------------------------------------------
ScanFormat:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov esi, eax
        mov dword [esp], edx
        mov edi, ebx
        mov ah, byte [byte eax+010h]
        xor edx, edx
        xor ebp, ebp
        and ah, 0FDh
        mov dword [byte esp+04h], edx
        mov byte [byte esi+010h], ah
.1:
        mov ebx, dword [esp]
        lea ecx, [byte ebx+01h]
        mov dword [esp], ecx
        mov bl, byte [ebx]
        and ebx, 0FFh
        je near .29
        mov al, bl
        inc al
        and eax, 0FFh
        mov al, byte [dword eax+_IsTable]
        and al, 2
        and eax, 0FFh
        je short .2
        mov eax, esi
        call ScanSkipSpace
        add ebp, eax
        jmp near .28
.2:
        cmp ebx, byte 25h
        je short .4
        mov eax, esi
        call ScanGetChar
        cmp eax, ebx
        je near .27
.3:
        test byte [byte esi+010h], 2
        jne near .29
        mov edx, esi
        call ScanUngetChar
        jmp near .29
.4:
        mov edx, esi
        mov eax, ecx
        call ScanParseSpec
        xor ebx, ebx
        mov dword [esp], eax
        mov bl, byte [eax]
        test ebx, ebx
        je short .5
        inc eax
        mov dword [esp], eax
.5:
        cmp ebx, byte 65h
        jb short .9
        cmp ebx, byte 67h
        jbe near .20
        cmp ebx, byte 70h
        jb short .7
        jbe near .19
        cmp ebx, byte 75h
        jb short .6
        jbe near .18
        cmp ebx, byte 78h
        je near .19
        jmp near .28
.6:
        cmp ebx, byte 73h
        je near .21
        jmp near .28
.7:
        cmp ebx, byte 6Eh
        jb short .8
        jbe near .25
        jmp near .17
.8:
        cmp ebx, byte 69h
        je short .16
        jmp near .28
.9:
        cmp ebx, byte 58h
        jb short .11
        jbe near .19
        cmp ebx, byte 63h
        jb short .10
        jbe near .23
        jmp short .13
.10:
        cmp ebx, byte 5Bh
        je near .22
        jmp near .28
.11:
        cmp ebx, byte 45h
        jb short .12
        jbe short .20
        cmp ebx, byte 47h
        je short .20
        jmp near .28
.12:
        cmp ebx, byte 25h
        je near .26
        jmp near .28
.13:
        mov ecx, 1
        mov ebx, 0Ah
.14:
        mov edx, edi
        mov eax, esi
.15:
        call ScanIntegerField
        jmp short .24
.16:
        mov ecx, 1
        mov edx, edi
        mov eax, esi
        xor ebx, ebx
        jmp short .15
.17:
        mov ecx, 1
        mov ebx, 8
        jmp short .14
.18:
        mov ebx, 0Ah
        mov edx, edi
        mov eax, esi
        xor ecx, ecx
        jmp short .15
.19:
        mov ecx, 1
        mov ebx, 10h
        jmp short .14
.20:
        mov edx, edi
        mov eax, esi
        call ScanFloatField
        jmp short .24
.21:
        mov edx, edi
        mov eax, esi
        call ScanChars
        jmp short .24
.22:
        mov ebx, esp
        mov edx, edi
        mov eax, esi
        call ScanCharSet
        jmp short .24
.23:
        mov edx, edi
        mov eax, esi
        call ScanStoreCount
.24:
        mov ebx, eax
        test ebx, ebx
        jle near .29
        mov dl, byte [byte esi+010h]
        add ebp, ebx
        test dl, 1
        je short .28
        inc dword [byte esp+04h]
        jmp short .28
.25:
        mov ebx, ebp
        mov edx, edi
        mov eax, esi
        call ScanStoreInt
        jmp short .28
.26:
        mov eax, esi
        call ScanGetChar
        cmp eax, ebx
        jne near .3
.27:
        inc ebp
.28:
        test byte [byte esi+010h], 2
        je near .1
        mov eax, dword [esp]
        mov al, byte [eax]
        and eax, 0FFh
        cmp eax, byte 25h
        jne short .29
        inc dword [esp]
        mov eax, dword [esp]
        mov edx, esi
        call ScanParseSpec
        mov dword [esp], eax
        mov al, byte [eax]
        and eax, 0FFh
        cmp eax, byte 6Eh
        jne short .29
        mov ebx, ebp
        mov edx, edi
        mov eax, esi
        call ScanStoreInt
.29:
        cmp dword [byte esp+04h], byte 0
        jne short .30
        test byte [byte esi+010h], 2
        je short .30
        mov eax, 0FFFFFFFFh
        jmp short .31
.30:
        mov eax, dword [byte esp+04h]
.31:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; ScanParseSpec                                  131644  97 PC, low confidence
; Parses one scanf field spec: assignment suppression, width and size
; modifiers
;-----------------------------------------------------------------------------
ScanParseSpec:
        push ebx
        push ecx
        push esi
        sub esp, byte 4
        mov ebx, edx
        mov dl, byte [byte edx+010h]
        or dl, 1
        mov byte [byte ebx+010h], dl
        mov dh, dl
        mov dword [byte ebx+0Ch], 0FFFFFFFFh
        and dh, 3
        mov byte [byte ebx+010h], dh
        xor edx, edx
        mov dl, byte [eax]
        cmp edx, byte 2Ah
        jne short .1
        mov cl, byte [byte ebx+010h]
        and cl, 0FEh
        inc eax
        mov byte [byte ebx+010h], cl
.1:
        xor edx, edx
        mov dl, byte [eax]
        mov dword [esp], edx
        mov dl, byte [esp]
        inc dl
        and edx, 0FFh
        mov dl, byte [dword edx+_IsTable]
        and dl, 20h
        and edx, 0FFh
        je short .3
        xor edx, edx
.2:
        imul edx, byte 0Ah
        mov esi, dword [esp]
        sub esi, byte 30h
        inc eax
        add edx, esi
        movzx esi, byte [eax]
        mov dword [esp], esi
        mov cl, byte [esp]
        inc cl
        movzx esi, cl
        mov cl, byte [dword esi+_IsTable]
        and cl, 20h
        movzx esi, cl
        test esi, esi
        jne short .2
        mov dword [byte ebx+0Ch], edx
.3:
        xor edx, edx
        mov dl, byte [eax]
        lea esi, [byte eax+01h]
        cmp edx, byte 4Eh
        jne short .4
        or byte [byte ebx+010h], 8
        mov eax, esi
        jmp short .5
.4:
        cmp edx, byte 46h
        jne short .5
        mov ch, byte [byte ebx+010h]
        or ch, 4
        mov eax, esi
        mov byte [byte ebx+010h], ch
.5:
        mov dl, byte [eax]
        lea esi, [byte eax+01h]
        cmp dl, 68h
        jb short .6
        jbe short .7
        cmp dl, 6Ch
        jb short .10
        jbe short .8
        cmp dl, 77h
        je short .8
        jmp short .10
.6:
        cmp dl, 4Ch
        je short .9
        jmp short .10
.7:
        mov dh, byte [byte ebx+010h]
        or dh, 10h
        mov eax, esi
        mov byte [byte ebx+010h], dh
        jmp short .10
.8:
        mov dl, byte [byte ebx+010h]
        or dl, 20h
        inc eax
        mov byte [byte ebx+010h], dl
        jmp short .10
.9:
        mov cl, byte [byte ebx+010h]
        or cl, 40h
        mov eax, esi
        mov byte [byte ebx+010h], cl
.10:
        add esp, byte 4
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ScanSkipSpace                                  131739  97 PC, low confidence
; Skips white space in the scanf input; returns how many characters were
; skipped
;-----------------------------------------------------------------------------
ScanSkipSpace:
        push ebx
        push edx
        push esi
        mov ebx, eax
        xor esi, esi
.1:
        mov eax, ebx
        call ScanGetChar
        mov edx, eax
        inc dl
        and edx, 0FFh
        mov dl, byte [dword edx+_IsTable]
        and dl, 2
        and edx, 0FFh
        je short .2
        inc esi
        jmp short .1
.2:
        test byte [byte ebx+010h], 2
        jne short .3
        mov edx, ebx
        call ScanUngetChar
.3:
        mov eax, esi
        pop esi
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ScanStoreCount                                 131778  97 PC, low confidence
; Stores the number of characters read so far for a %n field
;-----------------------------------------------------------------------------
ScanStoreCount:
        push ebx
        push ecx
        push esi
        push edi
        push es
        sub esp, byte 4
        mov ebx, eax
        test byte [byte eax+010h], 1
        je short .3
        mov cl, byte [byte ebx+010h]
        test cl, 4
        je short .1
        mov edi, dword [edx]
        add edi, byte 8
        mov dword [edx], edi
        les ecx, [byte edi-08h]
        jmp short .3
.1:
        test cl, 8
        je short .2
        mov esi, dword [edx]
        add esi, byte 4
        mov eax, ds
        mov dword [edx], esi
        mov es, eax
        mov ecx, dword [byte esi-04h]
        jmp short .3
.2:
        mov ecx, dword [edx]
        add ecx, byte 4
        mov eax, ds
        mov dword [edx], ecx
        mov es, eax
        mov ecx, dword [byte ecx-04h]
.3:
        mov edx, dword [byte ebx+0Ch]
        xor esi, esi
        cmp edx, byte 0FFFFFFFFh
        jne short .4
        mov edx, 1
.4:
        test edx, edx
        jle short .6
        mov eax, ebx
        call ScanGetChar
        mov dword [esp], eax
        mov al, byte [byte ebx+010h]
        test al, 2
        jne short .6
        inc esi
        dec edx
        test al, 1
        je short .4
        test al, 20h
        je short .5
        mov eax, dword [esp]
        db 066h,026h,089h,01h                   ; insn: mov [es:ecx],ax
        add ecx, byte 2
        jmp short .4
.5:
        mov al, byte [esp]
        mov byte [es:ecx], al
        inc ecx
        jmp short .4
.6:
        mov eax, esi
        add esp, byte 4
ScanStoreCount_8F:
        pop es
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ScanChars                                      13180D  97 PC, low confidence
; Reads a %c or %s field into the caller's buffer
;-----------------------------------------------------------------------------
ScanChars:
        push ebx
        push ecx
        push esi
        push edi
        push es
        sub esp, byte 8
        mov ebx, eax
        test byte [byte eax+010h], 20h
        je short .1
        mov byte [byte esp+04h], 2
        jmp short .2
.1:
        test byte [byte ebx+010h], 10h
        mov byte [byte esp+04h], 1
.2:
        mov al, byte [byte ebx+010h]
        test al, 1
        je short .5
        test al, 4
        je short .3
        mov edi, dword [edx]
        add edi, byte 8
        mov dword [edx], edi
        les ecx, [byte edi-08h]
        jmp short .5
.3:
        test al, 8
        je short .4
        mov esi, dword [edx]
        add esi, byte 4
        mov eax, ds
        mov dword [edx], esi
        mov es, eax
        mov ecx, dword [byte esi-04h]
        jmp short .5
.4:
        mov ecx, dword [edx]
        add ecx, byte 4
        mov eax, ds
        mov dword [edx], ecx
        mov es, eax
        mov ecx, dword [byte ecx-04h]
.5:
        xor esi, esi
.6:
        mov eax, ebx
        call ScanGetChar
        mov dword [esp], eax
        mov al, byte [esp]
        inc al
        and eax, 0FFh
        mov al, byte [dword eax+_IsTable]
        and al, 2
        and eax, 0FFh
        je short .7
        inc esi
        jmp short .6
.7:
        test byte [byte ebx+010h], 2
        je short .8
        xor esi, esi
        jmp near .14
.8:
        mov eax, dword [byte ebx+0Ch]
        lea edx, [byte eax-01h]
        mov dword [byte ebx+0Ch], edx
        test eax, eax
        je short .13
.9:
        mov ah, byte [byte ebx+010h]
        inc esi
        test ah, 1
        je short .12
        xor eax, eax
        mov al, byte [byte esp+04h]
        cmp eax, byte 1
        jne short .10
        mov al, byte [esp]
        mov byte [es:ecx], al
        jmp short .11
.10:
        mov eax, dword [esp]
        db 066h,026h,089h,01h                   ; insn: mov [es:ecx],ax
.11:
        xor eax, eax
        mov al, byte [byte esp+04h]
        add ecx, eax
.12:
        mov eax, ebx
        call ScanGetCharWidth
        mov dword [esp], eax
        cmp eax, byte 0FFFFFFFFh
        je short .14
        mov al, byte [esp]
        inc al
        and eax, 0FFh
        mov al, byte [dword eax+_IsTable]
        and al, 2
        and eax, 0FFh
        je short .9
.13:
        mov eax, dword [esp]
        mov edx, ebx
        call ScanUngetChar
.14:
        test byte [byte ebx+010h], 1
        je short .16
        test esi, esi
        jle short .16
        xor eax, eax
        mov al, byte [byte esp+04h]
        cmp eax, byte 1
        jne short .15
        mov byte [es:ecx], 0
        jmp short .16
.15:
        db 066h,026h,0C7h,01h,00h,00h           ; insn: mov word [es:ecx],0
.16:
        mov eax, esi
        add esp, byte 8
        jmp near ScanStoreCount_8F
;-----------------------------------------------------------------------------
; ScanStoreInt                                   131930  97 PC, low confidence
; Stores a converted integer into the caller's argument with the field's size
;-----------------------------------------------------------------------------
ScanStoreInt:
        push ecx
        push esi
        push edi
        push es
        mov cl, byte [byte eax+010h]
        test cl, 1
        je short .5
        test cl, 4
        je short .1
        mov edi, dword [edx]
        add edi, byte 8
        mov dword [edx], edi
        les edx, [byte edi-08h]
        jmp short .3
.1:
        test cl, 8
        je short .2
        mov esi, dword [edx]
        add esi, byte 4
        mov ecx, ds
        mov dword [edx], esi
        mov es, ecx
        mov edx, dword [byte esi-04h]
        jmp short .3
.2:
        mov ecx, dword [edx]
        add ecx, byte 4
        mov dword [edx], ecx
        mov edx, ecx
        mov ecx, ds
        mov es, ecx
        mov edx, dword [byte edx-04h]
.3:
        mov ch, byte [byte eax+010h]
        test ch, 10h
        je short .4
        db 066h,026h,089h,01Ah                  ; insn: mov [es:edx],bx
        pop es
        pop edi
        pop esi
        pop ecx
        ret
.4:
        test ch, 20h
        mov dword [es:edx], ebx
.5:
        pop es
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; ScanBuildCharSet                               13198E  97 PC, low confidence
; Builds the 256-bit set of characters from a %[...] scanset
;-----------------------------------------------------------------------------
ScanBuildCharSet:
        push ebx
        push ecx
        push esi
        mov ecx, eax
        mov esi, edx
        mov ebx, 20h
        mov eax, esi
        xor edx, edx
        call memset_
        xor eax, eax
        mov al, byte [ecx]
        inc ecx
        test eax, eax
        je short .2
.1:
        mov edx, eax
        and eax, byte 7
        sar edx, 3
        mov al, byte [dword eax+ScanBitMasks]
        or byte [edx+esi], al
        xor eax, eax
        mov al, byte [ecx]
        test eax, eax
        je short .2
        inc ecx
        cmp eax, byte 5Dh
        jne short .1
.2:
        mov eax, ecx
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ScanCharSet                                    1319D1  97 PC, low confidence
; Reads a %[...] field: the longest run of characters in (or not in) the set
;-----------------------------------------------------------------------------
ScanCharSet:
        push ecx
        push esi
        push edi
        push es
        push ebp
        sub esp, byte 2Ch
        mov ecx, eax
        mov edi, edx
        mov eax, dword [ebx]
        xor edx, edx
        mov dl, byte [eax]
        cmp edx, byte 5Eh
        sete dl
        and edx, 0FFh
        mov dword [byte esp+024h], edx
        je short .1
        inc eax
        mov dword [ebx], eax
.1:
        mov edx, esp
        mov eax, dword [ebx]
        call ScanBuildCharSet
        mov dword [ebx], eax
        mov ah, byte [byte ecx+010h]
        test ah, 1
        je short .4
        test ah, 4
        je short .2
        mov esi, dword [edi]
        add esi, byte 8
        mov dword [edi], esi
        les esi, [byte esi-08h]
        jmp short .4
.2:
        test ah, 8
        je short .3
        mov ebx, dword [edi]
        add ebx, byte 4
        mov eax, ds
        mov dword [edi], ebx
        mov es, eax
        mov esi, dword [byte ebx-04h]
        jmp short .4
.3:
        mov edx, dword [edi]
        add edx, byte 4
        mov eax, ds
        mov dword [edi], edx
        mov es, eax
        mov esi, dword [byte edx-04h]
.4:
        mov edx, dword [byte ecx+0Ch]
        xor edi, edi
.5:
        test edx, edx
        jbe short .7
        mov eax, ecx
        call ScanGetChar
        mov bl, byte [byte ecx+010h]
        mov dword [byte esp+028h], eax
        test bl, 2
        jne short .7
        mov ebx, eax
        sar ebx, 3
        mov bl, byte [esp+ebx]
        and ebx, 0FFh
        mov dword [byte esp+020h], ebx
        mov ebx, eax
        and ebx, byte 7
        mov bl, byte [dword ebx+ScanBitMasks]
        mov ebp, dword [byte esp+020h]
        and ebx, 0FFh
        test ebx, ebp
        sete bl
        mov ebp, dword [byte esp+024h]
        and ebx, 0FFh
        cmp ebx, ebp
        je short .6
        mov edx, ecx
        call ScanUngetChar
        jmp short .7
.6:
        inc edi
        mov bh, byte [byte ecx+010h]
        dec edx
        test bh, 1
        je short .5
        mov al, byte [byte esp+028h]
        mov byte [es:esi], al
        inc esi
        jmp short .5
.7:
        test byte [byte ecx+010h], 1
        je short .8
        test edi, edi
        jle short .8
        mov byte [es:esi], 0
.8:
        mov eax, edi
        add esp, byte 2Ch
        pop ebp
        pop es
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; ScanFloatField                                 131ACB  97 PC, low confidence
; Reads a floating-point field and converts it
;-----------------------------------------------------------------------------
ScanFloatField:
        push ebx
        push ecx
        push esi
        push edi
        push es
        push ebp
        sub esp, byte 6Ch
        mov esi, eax
        mov dword [byte esp+05Ch], edx
        xor edi, edi
        mov ebx, esp
        mov dword [byte esp+060h], edi
.1:
        mov eax, esi
        call ScanGetChar
        mov dl, al
        inc dl
        movzx ebp, dl
        mov dl, byte [dword ebp+_IsTable]
        mov ecx, eax
        and dl, 2
        and edx, 0FFh
        je short .2
        inc dword [byte esp+060h]
        jmp short .1
.2:
        test byte [byte esi+010h], 2
        jne near .21
        mov edx, dword [byte esi+0Ch]
        lea ebp, [byte edx-01h]
        mov dword [byte esi+0Ch], ebp
        test edx, edx
        je near .20
        cmp eax, byte 2Bh
        je short .3
        cmp eax, byte 2Dh
        jne short .4
.3:
        mov ebp, dword [byte esp+060h]
        mov eax, esi
        mov byte [ebx], cl
        call ScanGetCharWidth
        inc ebx
        inc ebp
        mov ecx, eax
        mov dword [byte esp+060h], ebp
        cmp eax, byte 0FFFFFFFFh
        je near .21
.4:
        mov al, cl
        inc al
        and eax, 0FFh
        mov al, byte [dword eax+_IsTable]
        and al, 20h
        and eax, 0FFh
        jne short .5
        cmp ecx, byte 2Eh
        jne near .20
.5:
        xor eax, eax
        mov dword [byte esp+068h], eax
        mov al, cl
        xor ebp, ebp
        inc al
        and eax, 0FFh
        mov al, byte [dword eax+_IsTable]
        and al, 20h
        and eax, 0FFh
        je short .8
        mov ebp, 1
.6:
        mov byte [ebx], cl
        mov dh, byte [byte esi+010h]
        inc ebx
        test dh, 10h
        je short .7
        imul eax, dword [byte esp+06Ah], byte 0Ah
        add ecx, eax
        sub ecx, byte 30h
        mov word [byte esp+06Ah], cx
.7:
        mov eax, esi
        inc edi
        call ScanGetCharWidth
        mov ecx, eax
        cmp eax, byte 0FFFFFFFFh
        je near .21
        inc al
        and eax, 0FFh
        mov al, byte [dword eax+_IsTable]
        and al, 20h
        and eax, 0FFh
        jne short .6
.8:
        cmp ecx, byte 2Eh
        jne near .15
        mov eax, esi
        mov byte [ebx], cl
        call ScanGetCharWidth
        inc ebx
        mov ecx, eax
        cmp eax, byte 0FFFFFFFFh
        je near .21
        test ebp, ebp
        jne short .9
        inc al
        and eax, 0FFh
        mov al, byte [dword eax+_IsTable]
        and al, 20h
        and eax, 0FFh
        je near .20
.9:
        inc edi
.10:
        mov al, cl
        inc al
        and eax, 0FFh
        mov al, byte [dword eax+_IsTable]
        and al, 20h
        and eax, 0FFh
        je short .11
        inc edi
        mov eax, esi
        mov byte [ebx], cl
        call ScanGetCharWidth
        inc ebx
        mov ecx, eax
        cmp eax, byte 0FFFFFFFFh
        jne short .10
.11:
        test byte [byte esi+010h], 10h
        je short .14
        xor edx, edx
        mov ebp, ebx
        mov dword [byte esp+058h], edx
.12:
        dec ebp
        xor eax, eax
        mov al, byte [byte ebp+00h]
        cmp eax, byte 2Eh
        je short .13
        sub al, 30h
        mov dword [byte esp+064h], 0Ah
        mov byte [byte esp+05Ah], al
        xor edx, edx
        mov eax, dword [byte esp+058h]
        div dword [byte esp+064h]
        mov dword [byte esp+058h], eax
        jmp short .12
.13:
        mov eax, dword [byte esp+058h]
        mov word [byte esp+068h], ax
.14:
        cmp ecx, byte 0FFFFFFFFh
        je near .21
.15:
        test byte [byte esi+010h], 10h
        jne near .20
        cmp ecx, byte 65h
        je short .16
        cmp ecx, byte 45h
        jne near .20
.16:
        inc edi
        mov eax, esi
        mov byte [ebx], cl
        call ScanGetCharWidth
        inc ebx
        mov ecx, eax
        cmp eax, byte 0FFFFFFFFh
        je near .21
        cmp eax, byte 2Bh
        je short .17
        cmp eax, byte 2Dh
        jne short .18
.17:
        inc edi
        mov eax, esi
        mov byte [ebx], cl
        call ScanGetCharWidth
        inc ebx
        mov ecx, eax
        cmp eax, byte 0FFFFFFFFh
        je short .21
.18:
        mov al, cl
        inc al
        and eax, 0FFh
        mov al, byte [dword eax+_IsTable]
        and al, 20h
        and eax, 0FFh
        jne short .19
        xor edi, edi
        jmp short .20
.19:
        inc edi
        mov eax, esi
        mov byte [ebx], cl
        call ScanGetCharWidth
        inc ebx
        mov ecx, eax
        cmp eax, byte 0FFFFFFFFh
        je short .21
        inc al
        and eax, 0FFh
        mov al, byte [dword eax+_IsTable]
        and al, 20h
        and eax, 0FFh
        jne short .19
.20:
        mov edx, esi
        mov eax, ecx
        call ScanUngetChar
.21:
        test edi, edi
        jle near .31
        mov ecx, dword [byte esp+060h]
        mov dl, byte [byte esi+010h]
        add edi, ecx
        test dl, 1
        je near .31
        mov byte [ebx], 0
        test byte [byte esi+010h], 10h
        je short .22
        xor eax, eax
        mov al, byte [esp]
        cmp eax, byte 2Dh
        jne short .23
        neg dword [byte esp+068h]
        jmp short .23
.22:
        lea edx, [byte esp+050h]
        mov eax, esp
        call dword [__EFG_scanf]
.23:
        mov bl, byte [byte esi+010h]
        test bl, 4
        je short .24
        mov eax, dword [byte esp+05Ch]
        mov ecx, dword [eax]
        add ecx, byte 8
        mov dword [eax], ecx
        les ebx, [byte ecx-08h]
        jmp short .26
.24:
        test bl, 8
        je short .25
        mov eax, dword [byte esp+05Ch]
        mov ebx, dword [eax]
        add ebx, byte 4
        mov dword [eax], ebx
        mov eax, ds
        mov es, eax
        mov ebx, dword [byte ebx-04h]
        jmp short .26
.25:
        mov eax, dword [byte esp+05Ch]
        mov edx, dword [eax]
        add edx, byte 4
        mov dword [eax], edx
        mov eax, ds
        mov es, eax
        mov ebx, dword [byte edx-04h]
.26:
        mov cl, byte [byte esi+010h]
        test cl, 10h
        je short .27
        mov eax, dword [byte esp+068h]
        jmp short .30
.27:
        test cl, 20h
        jne short .28
        test cl, 40h
        je short .29
.28:
        mov eax, dword [byte esp+050h]
        mov dword [es:ebx], eax
        mov eax, dword [byte esp+054h]
        mov dword [byte es:ebx+04h], eax
        jmp short .31
.29:
        mov eax, dword [byte esp+050h]
        mov edx, dword [byte esp+054h]
        call __FDFS
.30:
        mov dword [es:ebx], eax
.31:
        mov eax, edi
        add esp, byte 6Ch
        pop ebp
        jmp near ScanStoreCount_8F
;-----------------------------------------------------------------------------
; ScanIntegerField                               131DE2  97 PC, low confidence
; Reads a signed or unsigned integer field in base 8, 10 or 16
;-----------------------------------------------------------------------------
ScanIntegerField:
        push esi
        push edi
        push es
        push ebp
        sub esp, byte 10h
        mov esi, eax
        mov dword [byte esp+0Ch], edx
        mov dword [byte esp+04h], ecx
        mov edx, ebx
        xor edi, edi
        xor ecx, ecx
        mov dword [esp], edi
.1:
        mov eax, esi
        call ScanGetChar
        mov ebx, eax
        inc al
        movzx ebp, al
        mov al, byte [dword ebp+_IsTable]
        and al, 2
        and eax, 0FFh
        je short .2
        inc dword [esp]
        jmp short .1
.2:
        test byte [byte esi+010h], 2
        jne near .15
        mov eax, dword [byte esi+0Ch]
        lea ebp, [byte eax-01h]
        mov dword [byte esi+0Ch], ebp
        test eax, eax
        je near .14
        mov eax, 2Bh
        mov ebp, dword [byte esp+04h]
        mov dword [byte esp+08h], eax
        test ebp, ebp
        je short .4
        cmp ebx, byte 2Bh
        je short .3
        cmp ebx, byte 2Dh
        jne short .4
.3:
        inc dword [esp]
        mov eax, esi
        mov dword [byte esp+08h], ebx
        call ScanGetCharWidth
        mov ebx, eax
        cmp eax, byte 0FFFFFFFFh
        je near .15
.4:
        test edx, edx
        jne short .8
        cmp ebx, byte 30h
        jne short .7
        mov eax, esi
        mov ecx, 1
        call ScanGetCharWidth
        mov ebx, eax
        cmp eax, byte 0FFFFFFFFh
        je near .15
        cmp eax, byte 78h
        je short .5
        cmp eax, byte 58h
        jne short .6
.5:
        mov eax, esi
        mov ebp, dword [esp]
        call ScanGetCharWidth
        xor ecx, ecx
        add ebp, byte 2
        mov ebx, eax
        mov dword [esp], ebp
        cmp eax, byte 0FFFFFFFFh
        je near .15
        mov edx, 10h
        jmp short .11
.6:
        mov edx, 8
        jmp short .11
.7:
        mov edx, 0Ah
        jmp short .11
.8:
        cmp edx, byte 10h
        jne short .11
        cmp ebx, byte 30h
        jne short .11
        mov eax, esi
        mov ecx, 1
        call ScanGetCharWidth
        mov ebx, eax
        cmp eax, byte 0FFFFFFFFh
        je near .15
        cmp eax, byte 78h
        je short .9
        cmp eax, byte 58h
        jne short .11
.9:
        mov eax, esi
        mov ebx, dword [esp]
        call ScanGetCharWidth
        add ebx, byte 2
        xor ecx, ecx
        mov dword [esp], ebx
.10:
        mov ebx, eax
        cmp eax, byte 0FFFFFFFFh
        je short .15
.11:
        mov eax, ebx
        call HexDigitValue
        cmp eax, edx
        jge short .12
        imul edi, edx
        add edi, eax
        mov eax, esi
        inc ecx
        call ScanGetCharWidth
        jmp short .10
.12:
        cmp ebx, byte 3Ah
        jne short .14
        test byte [byte esi+010h], 80h
        je short .14
.13:
        mov eax, esi
        inc ecx
        call ScanGetCharWidth
        mov ebx, eax
        cmp eax, byte 0FFFFFFFFh
        je short .15
        call HexDigitValue
        cmp eax, edx
        jge short .14
        imul edi, edx
        add edi, eax
        jmp short .13
.14:
        mov edx, esi
        mov eax, ebx
        call ScanUngetChar
.15:
        cmp dword [byte esp+08h], byte 2Dh
        jne short .16
        neg edi
.16:
        test ecx, ecx
        jle short .21
        mov edx, dword [esp]
        mov ah, byte [byte esi+010h]
        add ecx, edx
        test ah, 1
        je short .21
        test ah, 4
        je short .17
        mov eax, dword [byte esp+0Ch]
        mov edx, dword [eax]
        add edx, byte 8
        mov dword [eax], edx
        les eax, [byte edx-08h]
        jmp short .19
.17:
        test ah, 8
        je short .18
        mov eax, dword [byte esp+0Ch]
        mov ebp, dword [eax]
        add ebp, byte 4
        mov edx, ds
        mov dword [eax], ebp
        mov es, edx
        mov eax, dword [byte ebp-04h]
        jmp short .19
.18:
        mov eax, dword [byte esp+0Ch]
        mov ebx, dword [eax]
        add ebx, byte 4
        mov edx, ds
        mov dword [eax], ebx
        mov es, edx
        mov eax, dword [byte ebx-04h]
.19:
        mov bl, byte [byte esi+010h]
        test bl, 10h
        je short .20
        db 066h,026h,089h,038h                  ; insn: mov [es:eax],di
        jmp short .21
.20:
        test bl, 20h
        mov dword [es:eax], edi
.21:
        mov eax, ecx
        add esp, byte 10h
        pop ebp
        pop es
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; HexDigitValue                                  131FD2  97 PC, low confidence
; Returns the value of a hex digit, or 16 for a non-digit
;-----------------------------------------------------------------------------
HexDigitValue:
        cmp eax, byte 30h
        jl short .1
        cmp eax, byte 39h
        jg short .1
        sub eax, byte 30h
        ret
.1:
        call tolower_
        cmp eax, byte 61h
        jl short .2
        cmp eax, byte 66h
        jg short .2
        sub eax, byte 57h
        ret
.2:
        mov eax, 10h
        ret
;-----------------------------------------------------------------------------
; ScanGetCharWidth                               131FF9  97 PC, low confidence
; Reads one character while the field width allows; returns -1 at the width
; limit
;-----------------------------------------------------------------------------
ScanGetCharWidth:
        push ebx
        push edx
        mov edx, eax
        mov eax, dword [byte eax+0Ch]
        lea ebx, [byte eax-01h]
        mov dword [byte edx+0Ch], ebx
        test eax, eax
        je short .1
        mov eax, edx
        call ScanGetChar
        test byte [byte edx+010h], 2
        je short .2
.1:
        mov eax, 0FFFFFFFFh
.2:
        pop edx
        pop ebx
        ret
