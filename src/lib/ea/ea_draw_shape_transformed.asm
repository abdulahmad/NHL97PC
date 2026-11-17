; EA library: DrawShapeTransformed.
bits 32
%include "hockey.inc"
section s_12E387 progbits alloc exec nowrite align=1
extern BlendShapeRows, ClipLeftCol, ClipRight, ClipTopRow, ConvertArtNew, DrawCharBold, DrawCharMono, DrawCharOutline
extern DrawCharShadow, FreeMemBlock, ScreenHeight, ShadeTable
global DrawShapeTransformed
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; DrawShapeTransformed                           12E390  97 PC, low confidence
; Converts a shape to 32-bit if needed and draws it rotated and scaled
; through the polygon filler
;-----------------------------------------------------------------------------
DrawShapeTransformed:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 4844h
        mov esi, dword [dword esp+04860h]
        mov eax, dword [dword esp+04858h]
        xor edx, edx
        mov eax, dword [eax]
        and eax, byte 7Fh
        mov al, byte [dword eax+ShadeTable]
        mov dword [dword esp+0480Ch], edx
        cmp eax, byte 20h
        je short .1
        push byte 20h
        mov ebx, dword [dword esp+0485Ch]
        push ebx
        call ConvertArtNew
        add esp, byte 8
        mov dword [dword esp+0480Ch], eax
        mov dword [dword esp+04858h], eax
.1:
        mov edi, 2
        mov ebx, esi
        xor ecx, ecx
        mov eax, dword [byte esi+04h]
        mov dword [dword esp+04810h], ecx
        mov dword [dword esp+0481Ch], eax
        mov eax, dword [byte esi+014h]
        mov dword [dword esp+04838h], edi
        mov dword [dword esp+04818h], eax
.2:
        mov ebp, dword [dword esp+0481Ch]
        mov eax, dword [byte ebx+04h]
        cmp eax, ebp
        jge short .3
        mov dword [dword esp+0481Ch], eax
        mov dword [dword esp+04810h], ecx
        jmp short .4
.3:
        cmp eax, dword [dword esp+04818h]
        jle short .4
        mov dword [dword esp+04818h], eax
        mov dword [dword esp+04838h], ecx
.4:
        inc ecx
        add ebx, byte 8
        cmp ecx, byte 4
        jl short .2
        mov eax, dword [dword esp+0481Ch]
        cmp eax, dword [ScreenHeight]
        jge near .19
        mov eax, dword [dword esp+04818h]
        cmp eax, dword [ClipLeftCol]
        jl near .19
        mov eax, dword [dword esp+04810h]
        inc eax
        and eax, byte 3
        shl eax, 3
        mov ebx, dword [dword esp+04810h]
        lea edx, [esi+eax]
        mov edi, dword [byte esi+ebx*8+04h]
        mov eax, dword [byte edx+04h]
        sub eax, edi
        lea ecx, [byte eax+01h]
        mov eax, dword [edx]
        sub eax, dword [esi+ebx*8]
        shl eax, 10h
        mov edx, eax
        sar edx, 1Fh
        idiv ecx
        mov ebp, dword [dword esp+04810h]
        dec ebp
        and ebp, byte 3
        mov edi, eax
        mov ecx, dword [byte esi+ebx*8+04h]
        mov edx, dword [esi+ebp*8]
        mov eax, dword [byte esi+ebp*8+04h]
        mov ebp, dword [esi+ebx*8]
        sub eax, ecx
        sub edx, ebp
        lea ecx, [byte eax+01h]
        shl edx, 10h
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        cmp edi, eax
        jl short .5
        mov dword [dword esp+04814h], 1
        jmp short .6
.5:
        mov dword [dword esp+04814h], 0FFFFFFFFh
.6:
        mov eax, dword [dword esp+04810h]
        cmp eax, dword [dword esp+04838h]
        je near .9
.7:
        mov edx, dword [dword esp+04814h]
        mov ebp, eax
        sub ebp, edx
        shl eax, 3
        and ebp, byte 3
        mov dword [dword esp+04820h], eax
        lea edx, [nosplit ebp*8+00h]
        add eax, esi
        mov dword [dword esp+04824h], edx
        lea ecx, [edx+esi]
        mov ebx, dword [byte eax+04h]
        mov edx, dword [byte ecx+04h]
        sub edx, ebx
        lea ebx, [byte edx+01h]
        test ebx, ebx
        jle near .8
        mov edx, dword [ecx]
        push edx
        mov ecx, dword [eax]
        push ecx
        push ebx
        mov edi, dword [byte eax+04h]
        push edi
        lea eax, [dword esp+0C10h]
        push eax
        call DrawCharMono
        mov dword [dword esp+04814h], eax
        add esp, byte 14h
        mov edx, dword [dword esp+04824h]
        push eax
        mov eax, dword [dword esp+04860h]
        add eax, edx
        mov edx, dword [dword esp+04824h]
        mov dword [dword esp+0480Ch], eax
        mov ecx, dword [eax]
        mov eax, dword [dword esp+04860h]
        add eax, edx
        push ecx
        mov ecx, dword [eax]
        push ecx
        push ebx
        push edi
        mov dword [dword esp+04818h], eax
        lea eax, [dword esp+03014h]
        push eax
        call DrawCharOutline
        add esp, byte 18h
        mov eax, dword [dword esp+04800h]
        push eax
        mov eax, dword [dword esp+0480Ch]
        mov edx, dword [byte eax+04h]
        mov eax, dword [dword esp+04808h]
        push edx
        mov ecx, dword [byte eax+04h]
        push ecx
        push ebx
        push edi
        lea eax, [dword esp+02414h]
        push eax
        call DrawCharOutline
        add esp, byte 18h
.8:
        mov ecx, dword [dword esp+04838h]
        mov eax, ebp
        cmp ebp, ecx
        jne near .7
.9:
        mov ebx, dword [dword esp+04810h]
        cmp ebx, dword [dword esp+04838h]
        je near .12
.10:
        mov eax, dword [dword esp+04814h]
        add eax, ebx
        and eax, byte 3
        mov dword [dword esp+04840h], eax
        shl eax, 3
        shl ebx, 3
        mov dword [dword esp+0482Ch], eax
        lea ecx, [eax+esi]
        mov dword [dword esp+04828h], ebx
        lea eax, [ebx+esi]
        mov edx, dword [byte ecx+04h]
        mov edi, dword [byte eax+04h]
        sub edx, edi
        lea ebx, [byte edx+01h]
        test ebx, ebx
        jle near .11
        mov ebp, dword [ecx]
        push ebp
        mov edx, dword [eax]
        push edx
        push ebx
        push edi
        lea eax, [byte esp+010h]
        push eax
        call DrawCharShadow
        add esp, byte 14h
        mov ebp, eax
        mov ecx, dword [dword esp+0482Ch]
        push eax
        mov eax, dword [dword esp+04860h]
        add eax, ecx
        mov ecx, dword [dword esp+0482Ch]
        mov dword [dword esp+04808h], eax
        mov edx, dword [eax]
        mov eax, dword [dword esp+04860h]
        add eax, ecx
        push edx
        mov edx, dword [eax]
        push edx
        push ebx
        push edi
        mov dword [dword esp+0481Ch], eax
        lea eax, [dword esp+01814h]
        push eax
        call DrawCharBold
        add esp, byte 18h
        mov eax, dword [dword esp+04804h]
        push ebp
        mov ecx, dword [byte eax+04h]
        mov eax, dword [dword esp+0480Ch]
        push ecx
        mov ebp, dword [byte eax+04h]
        push ebp
        push ebx
        push edi
        lea eax, [dword esp+03C14h]
        push eax
        call DrawCharBold
        add esp, byte 18h
.11:
        mov ebx, dword [dword esp+04840h]
        cmp ebx, dword [dword esp+04838h]
        jne near .10
.12:
        mov eax, dword [dword esp+0481Ch]
        mov ebp, dword [ClipLeftCol]
        cmp eax, ebp
        jge short .13
        mov dword [dword esp+0481Ch], ebp
.13:
        mov eax, dword [dword esp+04818h]
        mov edx, dword [ScreenHeight]
        cmp eax, edx
        jl short .14
        lea eax, [byte edx-01h]
        mov dword [dword esp+04818h], eax
.14:
        mov eax, dword [dword esp+04818h]
        mov ebx, dword [dword esp+0481Ch]
        sub eax, ebx
        mov dword [dword esp+04834h], ebx
        inc eax
        shl ebx, 2
        mov dword [dword esp+04830h], eax
.15:
        mov eax, dword [dword esp+04830h]
        dec eax
        mov dword [dword esp+04830h], eax
        cmp eax, byte 0FFFFFFFFh
        je near .19
        mov eax, dword [esp+ebx]
        sub eax, dword [dword esp+ebx+0C00h]
        lea ecx, [byte eax+01h]
        test ecx, ecx
        jle short .15
        mov esi, dword [ClipRight]
        cmp esi, dword [dword esp+ebx+0C00h]
        jle near .18
        mov edi, dword [ClipTopRow]
        cmp edi, dword [esp+ebx]
        jg near .18
        mov edx, dword [dword esp+ebx+01800h]
        mov ebp, dword [dword esp+ebx+03000h]
        sub edx, ebp
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov edi, eax
        mov edx, dword [dword esp+ebx+03C00h]
        mov eax, dword [dword esp+ebx+02400h]
        sub edx, eax
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov dword [dword esp+0483Ch], ebp
        mov ebp, dword [ClipTopRow]
        mov edx, dword [dword esp+ebx+0C00h]
        mov esi, dword [dword esp+ebx+02400h]
        cmp edx, ebp
        jge short .16
        mov edx, ebp
        sub edx, dword [dword esp+ebx+0C00h]
        mov ebp, edi
        imul ebp, edx
        add dword [dword esp+0483Ch], ebp
        mov ebp, eax
        imul ebp, edx
        sub ecx, edx
        mov edx, dword [ClipTopRow]
        add esi, ebp
        mov dword [dword esp+ebx+0C00h], edx
.16:
        mov ebp, dword [ClipRight]
        mov edx, dword [esp+ebx]
        cmp edx, ebp
        jl short .17
        sub edx, ebp
        inc edx
        sub ecx, edx
.17:
        push ecx
        mov edx, dword [dword esp+04838h]
        push edx
        mov ecx, dword [dword esp+ebx+0C08h]
        push ecx
        push eax
        push edi
        push esi
        mov esi, dword [dword esp+04854h]
        push esi
        mov edi, dword [dword esp+04874h]
        push edi
        call BlendShapeRows
        add esp, byte 20h
.18:
        mov ebp, dword [dword esp+04834h]
        inc ebp
        add ebx, byte 4
        mov dword [dword esp+04834h], ebp
        jmp near .15
.19:
        mov eax, dword [dword esp+0480Ch]
        test eax, eax
        je short .20
        push eax
        call FreeMemBlock
        add esp, byte 4
.20:
        add esp, 4844h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
