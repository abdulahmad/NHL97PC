; EA library: SetupRectFillShaded, SetupRectFill.
bits 32
%include "hockey.inc"
section s_123414 progbits alloc exec nowrite align=1
extern ClipLeftCol, ClipRight, ClipTopRow, ReciprocalRowTable, ScreenHeight, str_2_SetupRectFill
global SetupRectFillShaded, SetupRectFill, SetupRectFill_D, SetupRectFill_5B, SetupRectFill_165, SetupRectFillJumpTable, SetupRectFill_1B2, RectFillClipLeftJumpTable
global SetupRectFill_2A4, RectFillClipBottomJumpTable, SetupRectFill_39D, RectFillClipRightJumpTable, SetupRectFill_4F2, SetupRectFill_583, RectFillStepJumpTable, SetupRectFill_6D4
global SetupRectFill_6E2, SetupRectFill_73B, SetupRectFill_74E, SetupRectFill_80E
;-----------------------------------------------------------------------------
; SetupRectFillShaded                            123414  97 PC, low confidence
; Entry that sets up a rectangle fill with shading
;-----------------------------------------------------------------------------
SetupRectFillShaded:
        push ebp
        LD mov, ebp, esp
        add esp, byte 0FFFFFFF8h
        push ebx
        push esi
        push edi
        mov byte [byte ebp-05h], 1
        jmp short SetupRectFill_D
;-----------------------------------------------------------------------------
; SetupRectFill                                  123423  97 PC, low confidence
; Clips a rectangle and fills in its fill description
;-----------------------------------------------------------------------------
SetupRectFill:
        push ebp
        LD mov, ebp, esp
        add esp, byte 0FFFFFFF8h
        push ebx
        push esi
        push edi
        mov byte [byte ebp-05h], 0
SetupRectFill_D:
        mov esi, dword [byte ebp+018h]
        mov dword [byte esi+034h], 0FFh
        LD xor, eax, eax
        mov dword [esi], eax
        mov dword [byte esi+08h], eax
        mov dword [byte esi+020h], eax
        mov dword [byte esi+024h], eax
        mov dword [byte esi+028h], eax
        mov dword [byte esi+02Ch], eax
        mov eax, dword [byte ebp+0Ch]
        mov ebx, dword [byte ebp+014h]
        mov ecx, dword [byte ebp+08h]
        mov edx, dword [byte ebp+010h]
        LD cmp, eax, ebx
        jg short .1
        mov dword [byte esi+04h], ecx
        mov dword [byte esi+0Ch], eax
        mov dword [byte esi+010h], edx
        mov dword [byte esi+014h], ebx
        jmp short .2
.1:
        mov dword [byte esi+04h], edx
        mov dword [byte esi+0Ch], ebx
        mov dword [byte esi+010h], ecx
        mov dword [byte esi+014h], eax
.2:
        jne short SetupRectFill_5B
        jmp near SetupRectFill_74E
SetupRectFill_5B:
        LD xor, edx, edx
        db 080h,07Dh,0FBh,00h                   ; insn: cmp byte [ebp-5],0
        jne short .11
        mov eax, dword [byte esi+0Ch]
        mov ebx, dword [ClipLeftCol]
        mov ecx, dword [ScreenHeight]
        LD cmp, eax, ecx
        jl short .3
        mov dl, 8
        jmp near SetupRectFill_4F2
.3:
        LD cmp, eax, ebx
        jge short .4
        or dh, 4
.4:
        mov eax, dword [byte esi+014h]
        LD cmp, eax, ebx
        jge short .5
        mov dl, 4
        jmp near SetupRectFill_4F2
.5:
        LD cmp, eax, ecx
        jl short .6
        or dl, 8
.6:
        mov ebx, dword [ClipTopRow]
        mov ecx, dword [ClipRight]
        mov eax, dword [byte esi+04h]
        LD cmp, eax, ebx
        jge short .7
        or dh, 2
.7:
        LD cmp, eax, ecx
        jl short .8
        or dh, 1
.8:
        mov eax, dword [byte esi+010h]
        LD cmp, eax, ebx
        jge short .9
        or dl, 2
.9:
        LD cmp, eax, ecx
        jl short .10
        or dl, 1
.10:
        test dh, dl
        je short .11
        LD and, dl, dh
        jmp near SetupRectFill_4F2
.11:
        LD or, dl, dh
        movzx edx, dl
        mov dword [byte ebp-04h], edx
        mov ecx, dword [byte esi+014h]
        sub ecx, dword [byte esi+0Ch]
        jno short .13
.12:
        jmp near SetupRectFill_80E
.13:
        mov edx, dword [byte esi+010h]
        sub edx, dword [byte esi+04h]
        jo short .12
        jne short .14
        inc ecx
        mov dword [byte esi+018h], ecx
        mov byte [byte esi+034h], 2
        jmp short SetupRectFill_165
.14:
        jl short .21
        LD cmp, edx, ecx
        jb short .19
        je short .20
        mov byte [byte esi+034h], 8
.15:
        xchg ecx, edx
.16:
        cmp ecx, dword [str_2_SetupRectFill]
        jge short .17
        LD mov, ebx, ecx
        mov ebx, dword [nosplit ebx*4+ReciprocalRowTable]
        mov ax, word [ebx+edx*2]
        shl eax, 10h
        jmp short .18
.17:
        LD xor, eax, eax
        div ecx
        LD mov, ebx, ecx
        shr ebx, 1
        LD sub, ebx, edx
        adc eax, byte 0
.18:
        mov dword [byte esi+030h], eax
        inc ecx
        jo short .12
        mov dword [byte esi+018h], ecx
        jmp short SetupRectFill_165
.19:
        mov byte [byte esi+034h], 6
        jmp short .16
.20:
        mov byte [byte esi+034h], 4
        jmp short .24
.21:
        neg edx
        jo short .12
        LD cmp, edx, ecx
        jb short .22
        je short .23
        mov byte [byte esi+034h], 7
        jmp short .15
.22:
        mov byte [byte esi+034h], 5
        jmp short .16
.23:
        mov byte [byte esi+034h], 3
.24:
        inc ecx
        mov dword [byte esi+018h], ecx
SetupRectFill_165:
        mov ebx, dword [byte ebp-04h]
        je short SetupRectFill_1B2
        jmp dword [nosplit cs:ebx*4+SetupRectFillJumpTable]
SetupRectFillJumpTable:                         ; jump table for the switch cases of SetupRectFill
        dd SetupRectFill_1B2
        dd SetupRectFill_583
        dd SetupRectFill_39D
        dd SetupRectFill_39D
        dd SetupRectFill_1B2.1
        dd SetupRectFill_1B2.1
        dd SetupRectFill_1B2.1
        dd SetupRectFill_1B2.1
        dd SetupRectFill_2A4
        dd SetupRectFill_2A4
        dd SetupRectFill_2A4
        dd SetupRectFill_2A4
        dd SetupRectFill_1B2.1
        dd SetupRectFill_1B2.1
        dd SetupRectFill_1B2.1
        dd SetupRectFill_1B2.1
SetupRectFill_1B2:
        LD xor, eax, eax
        pop edi
        pop esi
        pop ebx
        leave
        ret
.1:
        mov eax, dword [byte esi+0Ch]
        mov ecx, dword [ClipLeftCol]
        mov dword [byte esi+0Ch], ecx
        LD sub, ecx, eax
        mov bl, byte [byte esi+034h]
        jmp dword [nosplit cs:ebx*4+RectFillClipLeftJumpTable]
RectFillClipLeftJumpTable:                      ; jump table for the switch cases of SetupRectFillJumpTable
        db 00h,00h,00h,00h,00h,00h,00h,00h
        dd .1
        dd .2
        dd .3
        dd .4
        dd .5
        dd .6
        dd .8
.1:
        sub dword [byte esi+018h], ecx
        jmp near SetupRectFill_6D4
.2:
        sub dword [byte esi+04h], ecx
        sub dword [byte esi+018h], ecx
        jmp near SetupRectFill_6D4
.3:
        add dword [byte esi+04h], ecx
        sub dword [byte esi+018h], ecx
        jmp near SetupRectFill_6D4
.4:
        mov eax, dword [byte esi+030h]
        mul ecx
        sub dword [esi], eax
        sbb dword [byte esi+04h], edx
        sub dword [byte esi+018h], ecx
        jmp near SetupRectFill_6D4
.5:
        mov eax, dword [byte esi+030h]
        mul ecx
        add dword [esi], eax
        adc dword [byte esi+04h], edx
        sub dword [byte esi+018h], ecx
        jmp near SetupRectFill_6D4
.6:
        mov dword [byte esi+0Ch], eax
        LD mov, edx, ecx
        LD xor, eax, eax
        mov ecx, dword [byte esi+030h]
        div ecx
        shr ecx, 1
        LD sub, ecx, edx
        adc eax, byte 0
        sub dword [byte esi+04h], eax
        sub dword [byte esi+018h], eax
        jle short .7
        mul dword [byte esi+030h]
        add dword [byte esi+08h], eax
        adc dword [byte esi+0Ch], edx
        jmp near SetupRectFill_6D4
.7:
        mov dword [byte esi+018h], 1
        mov eax, dword [ClipLeftCol]
        mov dword [byte esi+0Ch], eax
        mov eax, dword [byte esi+010h]
        mov dword [byte esi+04h], eax
        jmp near SetupRectFill_6D4
.8:
        mov dword [byte esi+0Ch], eax
        LD mov, edx, ecx
        LD xor, eax, eax
        mov ecx, dword [byte esi+030h]
        div ecx
        shr ecx, 1
        LD sub, ecx, edx
        adc eax, byte 0
        add dword [byte esi+04h], eax
        sub dword [byte esi+018h], eax
        jle short .7
        mul dword [byte esi+030h]
        add dword [byte esi+08h], eax
        adc dword [byte esi+0Ch], edx
        jmp near SetupRectFill_6D4
SetupRectFill_2A4:
        mov ecx, dword [byte esi+014h]
        mov edx, dword [ScreenHeight]
        dec edx
        mov dword [byte esi+014h], edx
        LD sub, ecx, edx
        mov bl, byte [byte esi+034h]
        jmp dword [nosplit cs:ebx*4+RectFillClipBottomJumpTable]
RectFillClipBottomJumpTable:                    ; jump table for the switch cases of RectFillClipLeftJumpTable
        db 00h,00h,00h,00h,00h,00h,00h,00h
        dd .1
        dd .2
        dd .3
        dd .4
        dd .5
        dd .6
        dd .9
.1:
        sub dword [byte esi+018h], ecx
        jmp near SetupRectFill_6E2
.2:
        add dword [byte esi+010h], ecx
        sub dword [byte esi+018h], ecx
        jmp near SetupRectFill_6E2
.3:
        sub dword [byte esi+010h], ecx
        sub dword [byte esi+018h], ecx
        jmp near SetupRectFill_6E2
.4:
        mov edx, dword [byte esi+018h]
        LD sub, edx, ecx
        mov dword [byte esi+018h], edx
        dec edx
        mov eax, dword [byte esi+030h]
        mul edx
        mov ebx, dword [esi]
        mov ecx, dword [byte esi+04h]
        LD sub, ebx, eax
        LD sbb, ecx, edx
        add ebx, 80000000h
        adc ecx, byte 0
        mov dword [byte esi+010h], ecx
        jmp near SetupRectFill_6E2
.5:
        mov edx, dword [byte esi+018h]
        LD sub, edx, ecx
        mov dword [byte esi+018h], edx
        dec edx
        mov eax, dword [byte esi+030h]
        mul edx
        add eax, dword [esi]
        adc edx, dword [byte esi+04h]
        add eax, 80000000h
        adc edx, byte 0
        mov dword [byte esi+010h], edx
        jmp near SetupRectFill_6E2
.6:
        LD xor, eax, eax
        sub eax, dword [byte esi+08h]
        sbb edx, dword [byte esi+0Ch]
        jl short .8
        mov ecx, dword [byte esi+030h]
        div ecx
        shr ecx, 1
        LD sub, ecx, edx
        adc eax, byte 0
.7:
        mov edx, dword [byte esi+04h]
        LD sub, edx, eax
        mov dword [byte esi+010h], edx
        inc eax
        mov dword [byte esi+018h], eax
        jmp near SetupRectFill_6E2
.8:
        LD xor, eax, eax
        jmp short .7
.9:
        LD xor, eax, eax
        sub eax, dword [byte esi+08h]
        sbb edx, dword [byte esi+0Ch]
        jl short .8
        mov ecx, dword [byte esi+030h]
        div ecx
        shr ecx, 1
        LD sub, ecx, edx
        adc eax, byte 0
        mov edx, dword [byte esi+04h]
        LD add, edx, eax
        mov dword [byte esi+010h], edx
        inc eax
        mov dword [byte esi+018h], eax
        jmp near SetupRectFill_6E2
SetupRectFill_39D:
        mov bl, byte [byte esi+034h]
        jmp dword [nosplit cs:ebx*4+RectFillClipRightJumpTable]
RectFillClipRightJumpTable:                     ; jump table for the switch cases of
                                                ; RectFillClipBottomJumpTable
        db 00h,00h,00h,00h,00h,00h,00h,00h
        dd .10
        dd .1
        dd .2
        dd .3
        dd .6
        dd .8
        dd .9
.1:
        mov ecx, dword [ClipTopRow]
        mov eax, dword [byte esi+010h]
        mov dword [byte esi+010h], ecx
        LD sub, ecx, eax
        add dword [byte esi+024h], ecx
        sub dword [byte esi+018h], ecx
        sub dword [byte esi+014h], ecx
        jmp near SetupRectFill_73B
.2:
        mov eax, dword [byte esi+04h]
        mov ecx, dword [ClipTopRow]
        mov dword [byte esi+04h], ecx
        LD sub, ecx, eax
        add dword [byte esi+020h], ecx
        add dword [byte esi+0Ch], ecx
        sub dword [byte esi+018h], ecx
        jmp near SetupRectFill_73B
.3:
        mov eax, dword [esi]
        mov edx, dword [byte esi+04h]
        mov ecx, dword [ClipTopRow]
        mov dword [byte esi+010h], ecx
        LD sub, edx, ecx
        jl short .5
        mov ecx, dword [byte esi+030h]
        div ecx
        shr ecx, 1
        LD sub, ecx, edx
        adc eax, byte 0
        inc eax
.4:
        mov ecx, dword [byte esi+018h]
        mov dword [byte esi+018h], eax
        LD sub, ecx, eax
        add dword [byte esi+024h], ecx
        dec eax
        add eax, dword [byte esi+0Ch]
        mov dword [byte esi+014h], eax
        jmp near SetupRectFill_73B
.5:
        mov eax, 1
        jmp short .4
.6:
        mov edx, dword [ClipTopRow]
        LD xor, eax, eax
        sub eax, dword [esi]
        sbb edx, dword [byte esi+04h]
        jl short .7
        mov ecx, dword [byte esi+030h]
        div ecx
        shr ecx, 1
        LD sub, ecx, edx
        adc eax, byte 0
        add dword [byte esi+0Ch], eax
        add dword [byte esi+020h], eax
        sub dword [byte esi+018h], eax
        jle near .10
        mul dword [byte esi+030h]
        add dword [esi], eax
        adc dword [byte esi+04h], edx
        jmp near SetupRectFill_73B
.7:
        jmp short .10
.8:
        mov eax, dword [byte esi+04h]
        mov edx, dword [ClipTopRow]
        mov dword [byte esi+010h], edx
        LD sub, eax, edx
        LD mov, ecx, eax
        inc ecx
        mov dword [byte esi+018h], ecx
        mul dword [byte esi+030h]
        add eax, dword [byte esi+08h]
        adc edx, dword [byte esi+0Ch]
        add eax, 80000000h
        adc edx, byte 0
        mov eax, dword [byte esi+014h]
        LD sub, eax, edx
        mov dword [byte esi+014h], edx
        add dword [byte esi+024h], eax
        jmp near SetupRectFill_73B
.9:
        mov ecx, dword [byte esi+04h]
        mov eax, dword [ClipTopRow]
        mov dword [byte esi+04h], eax
        LD sub, eax, ecx
        sub dword [byte esi+018h], eax
        mul dword [byte esi+030h]
        mov ebx, dword [byte esi+08h]
        mov ecx, dword [byte esi+0Ch]
        LD add, eax, ebx
        LD adc, edx, ecx
        mov dword [byte esi+08h], eax
        mov dword [byte esi+0Ch], edx
        add ebx, 80000000h
        adc ecx, byte 0
        add eax, 80000000h
        adc edx, byte 0
        LD sub, edx, ecx
        add dword [byte esi+020h], edx
        jmp near SetupRectFill_73B
.10:
        mov edx, 2
SetupRectFill_4F2:
        mov byte [byte esi+035h], dl
        mov dword [byte esi+018h], 0
        mov al, byte [byte esi+035h]
        test al, 4
        je short .11
        mov ebx, dword [ClipLeftCol]
        mov dword [byte esi+0Ch], ebx
        mov dword [byte esi+08h], 0
        dec ebx
        mov dword [byte esi+014h], ebx
        jmp short .16
.11:
        test al, 8
        je short .12
        mov ebx, dword [ScreenHeight]
        mov dword [byte esi+0Ch], ebx
        mov dword [byte esi+08h], 0
        jmp short .16
.12:
        mov ecx, dword [byte esi+014h]
        cmp ecx, dword [ScreenHeight]
        jl short .13
        mov ecx, dword [ScreenHeight]
        dec ecx
.13:
        mov edx, dword [byte esi+0Ch]
        mov ebx, dword [byte esi+08h]
        add ebx, 80000000h
        adc edx, byte 0
        cmp edx, dword [ClipLeftCol]
        jge short .14
        mov edx, dword [ClipLeftCol]
.14:
        mov dword [byte esi+0Ch], edx
        mov dword [byte esi+08h], 0
        LD sub, ecx, edx
        dec edx
        inc ecx
        mov dword [byte esi+014h], edx
        test al, 2
        je short .15
        add dword [byte esi+024h], ecx
        jmp short .16
.15:
        add dword [byte esi+02Ch], ecx
.16:
        movzx eax, al
        pop edi
        pop esi
        pop ebx
        leave
        ret
SetupRectFill_583:
        movzx ebx, byte [byte esi+034h]
        jmp dword [nosplit cs:ebx*4+RectFillStepJumpTable]
RectFillStepJumpTable:                          ; jump table for the switch cases of
                                                ; RectFillClipRightJumpTable
        db 00h,00h,00h,00h,00h,00h,00h,00h
        dd .1
        dd .2
        dd .3
        dd .4
        dd .5
        dd .6
        dd .7
.1:
        mov edx, 1
        jmp near SetupRectFill_4F2
.2:
        mov ecx, dword [byte esi+04h]
        mov eax, dword [ClipRight]
        dec eax
        mov dword [byte esi+04h], eax
        LD sub, ecx, eax
        add dword [byte esi+0Ch], ecx
        sub dword [byte esi+018h], ecx
        add dword [byte esi+028h], ecx
        jmp near SetupRectFill_1B2
.3:
        mov ecx, dword [ClipRight]
        dec ecx
        mov eax, dword [byte esi+010h]
        mov dword [byte esi+010h], ecx
        LD sub, eax, ecx
        add dword [byte esi+02Ch], eax
        sub dword [byte esi+018h], eax
        sub dword [byte esi+014h], eax
        jmp near SetupRectFill_1B2
.4:
        mov eax, dword [esi]
        mov edx, dword [byte esi+04h]
        sub edx, dword [ClipRight]
        inc edx
        mov ecx, dword [byte esi+030h]
        div ecx
        shr ecx, 1
        LD sub, ecx, edx
        adc eax, byte 0
        sub dword [byte esi+018h], eax
        jle short .1
        add dword [byte esi+0Ch], eax
        add dword [byte esi+028h], eax
        mul dword [byte esi+030h]
        sub dword [esi], eax
        sbb dword [byte esi+04h], edx
        jmp near SetupRectFill_1B2
.5:
        mov edx, dword [ClipRight]
        dec edx
        mov dword [byte esi+010h], edx
        LD xor, eax, eax
        sub eax, dword [esi]
        sbb edx, dword [byte esi+04h]
        jl near .1
        mov ecx, dword [byte esi+030h]
        div ecx
        shr ecx, 1
        LD sub, ecx, edx
        adc eax, byte 0
        inc eax
        mov ecx, dword [byte esi+018h]
        mov dword [byte esi+018h], eax
        LD sub, ecx, eax
        add dword [byte esi+02Ch], ecx
        dec eax
        add eax, dword [byte esi+0Ch]
        mov dword [byte esi+014h], eax
        jmp near SetupRectFill_1B2
.6:
        mov eax, dword [byte esi+04h]
        mov ecx, dword [ClipRight]
        dec ecx
        LD sub, eax, ecx
        mov dword [byte esi+04h], ecx
        sub dword [byte esi+018h], eax
        mul dword [byte esi+030h]
        mov ebx, dword [byte esi+08h]
        mov ecx, dword [byte esi+0Ch]
        LD add, eax, ebx
        LD adc, edx, ecx
        mov dword [byte esi+08h], eax
        mov dword [byte esi+0Ch], edx
        add ebx, 80000000h
        adc ecx, byte 0
        add eax, 80000000h
        adc edx, byte 0
        LD sub, edx, ecx
        add dword [byte esi+028h], edx
        jmp near SetupRectFill_1B2
.7:
        mov eax, dword [ClipRight]
        LD mov, ecx, eax
        dec ecx
        mov dword [byte esi+010h], ecx
        sub eax, dword [byte esi+04h]
        mov dword [byte esi+018h], eax
        dec eax
        mul dword [byte esi+030h]
        add eax, dword [byte esi+08h]
        adc edx, dword [byte esi+0Ch]
        add eax, 80000000h
        adc edx, byte 0
        mov eax, dword [byte esi+014h]
        LD sub, eax, edx
        mov dword [byte esi+014h], edx
        add dword [byte esi+02Ch], eax
        jmp near SetupRectFill_1B2
SetupRectFill_6D4:
        test dword [byte ebp-04h], 8
        je short SetupRectFill_6E2
        jmp near SetupRectFill_2A4
SetupRectFill_6E2:
        LD xor, edx, edx
        mov eax, dword [byte esi+04h]
        cmp eax, dword [ClipTopRow]
        jge short .8
        or dh, 2
.8:
        mov ebx, dword [esi]
        add ebx, 80000000h
        adc eax, byte 0
        cmp eax, dword [ClipRight]
        jl short .9
        or dh, 1
.9:
        mov eax, dword [byte esi+010h]
        cmp eax, dword [ClipTopRow]
        jge short .10
        or dl, 2
.10:
        cmp eax, dword [ClipRight]
        jl short .11
        or dl, 1
.11:
        test dh, dl
        je short .12
        LD and, dl, dh
        jmp near SetupRectFill_4F2
.12:
        LD or, dl, dh
        je short SetupRectFill_73B.13
        movzx edx, dl
        mov dword [byte ebp-04h], edx
        jmp near SetupRectFill_165
SetupRectFill_73B:
        test dword [byte ebp-04h], 1
        je short .13
        jmp near SetupRectFill_583
.13:
        jmp near SetupRectFill_1B2
SetupRectFill_74E:
        mov byte [byte esi+034h], 1
        LD cmp, ecx, edx
        jne short .14
        mov byte [byte esi+034h], 9
.14:
        jle short .15
        mov byte [byte esi+034h], 0
        mov dword [byte esi+04h], edx
        mov dword [byte esi+010h], ecx
        xchg ecx, edx
.15:
        cmp byte [byte ebp-05h], 0
        jne short .17
        mov ebx, dword [ClipLeftCol]
        LD cmp, eax, ebx
        jge short .18
        mov al, 4
        mov dword [byte esi+0Ch], ebx
        mov dword [byte esi+014h], ebx
.16:
        mov byte [byte esi+035h], al
        mov dword [byte esi+018h], 0
        movzx eax, al
        pop edi
        pop esi
        pop ebx
        leave
        ret
.17:
        LD sub, edx, ecx
        inc edx
        mov dword [byte esi+018h], edx
        jmp near SetupRectFill_1B2
.18:
        mov ebx, dword [ScreenHeight]
        LD cmp, eax, ebx
        jl short .19
        mov al, 8
        mov dword [byte esi+0Ch], ebx
        mov dword [byte esi+014h], ebx
        jmp short .16
.19:
        LD mov, eax, edx
        LD sub, eax, ecx
        inc eax
        mov dword [byte esi+018h], eax
        cmp edx, dword [ClipTopRow]
        jge short .20
        dec dword [byte esi+014h]
        mov dword [byte esi+024h], 1
        mov al, 2
        jmp short .16
.20:
        cmp ecx, dword [ClipRight]
        jl short .21
        dec dword [byte esi+014h]
        mov dword [byte esi+02Ch], 1
        mov al, 1
        jmp short .16
.21:
        mov eax, dword [ClipTopRow]
        LD mov, ebx, eax
        LD sub, eax, ecx
        jle short .22
        mov dword [byte esi+04h], ebx
        sub dword [byte esi+018h], eax
.22:
        LD mov, eax, edx
        mov ebx, dword [ClipRight]
        dec ebx
        LD sub, eax, ebx
        jle short .23
        sub dword [byte esi+018h], eax
        mov dword [byte esi+010h], ebx
.23:
        jmp near SetupRectFill_1B2
SetupRectFill_80E:
        mov ecx, dword [byte esi+014h]
        sar ecx, 1
        mov eax, dword [byte esi+0Ch]
        sar eax, 1
        LD sub, ecx, eax
        sar ecx, 1
        mov edx, dword [byte esi+010h]
        sar edx, 1
        mov eax, dword [byte esi+04h]
        sar eax, 1
        LD sub, edx, eax
        sar edx, 1
.24:
        cmp dword [byte esi+0Ch], 0FFFFC180h
        jg short .30
.25:
        mov eax, dword [byte esi+0Ch]
        LD add, eax, ecx
        mov dword [byte esi+0Ch], eax
        LD mov, ebx, eax
        sub eax, dword [ClipLeftCol]
        jle short .29
        LD cmp, eax, ecx
        jle short .26
        LD mov, eax, ecx
.26:
        sub ebx, dword [ScreenHeight]
        jle short .27
        LD sub, eax, ebx
        jle short .29
.27:
        mov ebx, dword [byte esi+04h]
        cmp ebx, dword [ClipTopRow]
        jge short .28
        add dword [byte esi+020h], eax
        jmp short .29
.28:
        add dword [byte esi+028h], eax
.29:
        add dword [byte esi+04h], edx
        jmp short .24
.30:
        cmp dword [byte esi+014h], 3E80h
        jge short .31
        cmp dword [byte esi+04h], 0FFFFC180h
        jle short .25
        cmp dword [byte esi+04h], 3E80h
        jge short .25
        cmp dword [byte esi+010h], 0FFFFC180h
        jle short .31
        cmp dword [byte esi+010h], 3E80h
        jge short .31
        jmp near SetupRectFill_5B
.31:
        mov eax, dword [byte esi+014h]
        LD sub, eax, ecx
        mov dword [byte esi+014h], eax
        LD mov, ebx, eax
        sub eax, dword [ScreenHeight]
        inc eax
        jge short .35
        neg eax
        LD cmp, eax, ecx
        jle short .32
        LD mov, eax, ecx
.32:
        sub ebx, dword [ClipLeftCol]
        inc ebx
        jge short .33
        LD add, eax, ebx
        jle short .35
.33:
        mov ebx, dword [byte esi+010h]
        cmp ebx, dword [ClipTopRow]
        jge short .34
        add dword [byte esi+024h], eax
        jmp short .35
.34:
        add dword [byte esi+02Ch], eax
.35:
        sub dword [byte esi+010h], edx
        jmp short .30
