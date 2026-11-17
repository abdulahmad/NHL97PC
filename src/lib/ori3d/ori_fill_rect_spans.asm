; 3D library: FillRectSpans.
bits 32
%include "hockey.inc"
section s_123D04 progbits alloc exec nowrite align=1
extern FillRect, PlotPixel
global FillRectSpansJumpTable, FillRectSpans, FillRectSpans_7C, FillRectSpans_A2, FillRectSpans_C7, FillRectSpans_E7, FillRectSpans_107, FillRectSpans_14C
global FillRectSpans_193, FillRectSpans_1DE, FillRectSpans_225
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
FillRectSpansJumpTable:                         ; jump table for the switch cases of FillRectSpans
        dd FillRectSpans_7C
        dd FillRectSpans_7C
        dd FillRectSpans_A2
        dd FillRectSpans_C7
        dd FillRectSpans_E7
        dd FillRectSpans_107
        dd FillRectSpans_14C
        dd FillRectSpans_193
        dd FillRectSpans_1DE
        dd FillRectSpans_225
;-----------------------------------------------------------------------------
; FillRectSpans                                  123D38  97 PC, low confidence
; Fills the rows of a set-up rectangle
;-----------------------------------------------------------------------------
FillRectSpans:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov eax, dword [byte esp+024h]
        mov edx, dword [eax]
        mov ebp, dword [byte eax+04h]
        sar edx, 10h
        shl ebp, 10h
        and edx, 0FFFFh
        add ebp, edx
        mov edx, dword [byte eax+08h]
        mov edi, dword [byte eax+0Ch]
        sar edx, 10h
        shl edi, 10h
        and edx, 0FFFFh
        add edi, edx
        add edi, 8000h
        mov edx, edi
        mov ebx, dword [byte eax+018h]
        sar edx, 10h
        add ebp, 8000h
        and edx, 0FFFFh
        mov esi, ebp
        mov dword [byte esp+0Ch], edx
        mov edx, dword [byte eax+01Ch]
        sar esi, 10h
        mov dword [byte esp+08h], edx
        mov dl, byte [byte eax+034h]
        and esi, 0FFFFh
        cmp dl, 9
        ja near FillRectSpans_225.7
        and edx, 0FFh
        jmp dword [nosplit cs:edx*4+FillRectSpansJumpTable]
FillRectSpans_7C:
        test ebx, ebx
        je near FillRectSpans_225.7
        mov edi, dword [byte esp+08h]
        push edi
        push byte 1
        push ebx
        mov ebp, dword [byte esp+018h]
        push ebp
        push esi
        call FillRect
        add esp, byte 14h
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
FillRectSpans_A2:
        mov eax, dword [byte eax+0Ch]
        test ebx, ebx
        je near FillRectSpans_225.7
        mov ecx, dword [byte esp+08h]
        push ecx
        push ebx
        push byte 1
        push eax
        push esi
        call FillRect
        add esp, byte 14h
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
FillRectSpans_C7:
        mov edi, dword [byte eax+0Ch]
.1:
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je near FillRectSpans_225.7
        mov ecx, dword [byte esp+08h]
        push ecx
        push edi
        push esi
        inc edi
        call PlotPixel
        dec esi
        add esp, byte 0Ch
        jmp short .1
FillRectSpans_E7:
        mov edi, dword [byte eax+0Ch]
.2:
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je near FillRectSpans_225.7
        mov edx, dword [byte esp+08h]
        push edx
        push edi
        push esi
        inc edi
        call PlotPixel
        inc esi
        add esp, byte 0Ch
        jmp short .2
FillRectSpans_107:
        mov edi, dword [byte eax+0Ch]
        mov eax, dword [byte eax+030h]
        shr eax, 10h
        and eax, 0FFFFh
        and ebp, 0FFFFh
        mov dword [esp], eax
.3:
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je near FillRectSpans_225.7
        mov ecx, dword [byte esp+08h]
        push ecx
        push edi
        push esi
        call PlotPixel
        add esp, byte 0Ch
        add ebp, dword [esp]
        inc edi
        test ebp, 0FFFF0000h
        je short .3
        and ebp, 0FFFFh
        dec esi
        jmp short .3
FillRectSpans_14C:
        mov edi, dword [byte eax+0Ch]
        mov eax, dword [byte eax+030h]
        shr eax, 10h
        and eax, 0FFFFh
        and ebp, 0FFFFh
        mov dword [byte esp+04h], eax
.4:
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je near FillRectSpans_225.7
        mov eax, dword [byte esp+08h]
        push eax
        push edi
        push esi
        call PlotPixel
        add esp, byte 0Ch
        add ebp, dword [byte esp+04h]
        inc edi
        test ebp, 0FFFF0000h
        je short .4
        and ebp, 0FFFFh
        inc esi
        jmp short .4
FillRectSpans_193:
        mov ebp, dword [byte eax+030h]
        shr ebp, 10h
        and edi, 0FFFFh
        and ebp, 0FFFFh
.5:
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je near FillRectSpans_225.7
        mov eax, dword [byte esp+08h]
        push eax
        mov edx, dword [byte esp+010h]
        push edx
        push esi
        add edi, ebp
        call PlotPixel
        add esp, byte 0Ch
        dec esi
        test edi, 0FFFF0000h
        je short .5
        mov ecx, dword [byte esp+0Ch]
        inc ecx
        and edi, 0FFFFh
        mov dword [byte esp+0Ch], ecx
        jmp short .5
FillRectSpans_1DE:
        mov ebp, dword [byte eax+030h]
        shr ebp, 10h
        and edi, 0FFFFh
        and ebp, 0FFFFh
.6:
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je short FillRectSpans_225.7
        mov eax, dword [byte esp+08h]
        push eax
        mov edx, dword [byte esp+010h]
        push edx
        push esi
        add edi, ebp
        call PlotPixel
        add esp, byte 0Ch
        inc esi
        test edi, 0FFFF0000h
        je short .6
        mov ecx, dword [byte esp+0Ch]
        inc ecx
        and edi, 0FFFFh
        mov dword [byte esp+0Ch], ecx
        jmp short .6
FillRectSpans_225:
        mov edx, dword [byte esp+08h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        push esi
        call PlotPixel
        add esp, byte 0Ch
.7:
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        mov eax, dword [byte esp+04h]
        mov ecx, dword [byte esp+08h]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        ret
        mov edx, dword [byte esp+04h]
        mov ecx, dword [byte esp+08h]
        mov eax, dword [byte ecx+edx-04h]
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        ret
