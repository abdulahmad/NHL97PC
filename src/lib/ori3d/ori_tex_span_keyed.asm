; 3D library: TexSpanKeyed, TexSpanShadow, ClipDrawEdgeAtX, ClipDrawEdgeAtY, ClipDrawPolyLeft and 3 more.
bits 32
%include "hockey.inc"
section s_12E864 progbits alloc exec nowrite align=1
extern ClipLeftCol, ClipRight, ClipTopRow, FixedLerp, PolyClipBottomIn, PolyClipBottomOut, PolyClipLeftIn, PolyClipLeftOut
extern PolyClipRightIn, PolyClipRightOut, PolyClipTopIn, PolyClipTopOut, RemapTable, ScreenBitsPerPixel, ScreenHeight
global TexSpanKeyed, TexSpanShadow, ClipDrawEdgeAtX, ClipDrawEdgeAtY, ClipDrawPolyLeft, ClipDrawPolyLeft_137, ClipDrawPolyRight, ClipDrawPolyTop
global ClipDrawPolyBottom
;-----------------------------------------------------------------------------
; TexSpanKeyed                                   12E864  97 PC, low confidence
; Draws one span of a texture, skipping transparent (FFh) pixels
;-----------------------------------------------------------------------------
TexSpanKeyed:
        push ebx
        push esi
        push edi
        push ebp
        mov esi, dword [byte esp+014h]
        mov edi, dword [byte esp+018h]
        mov ebx, dword [byte esp+01Ch]
        shl ebx, 10h
        mov ebp, dword [byte esp+020h]
        shl ebp, 10h
        mov bx, word [byte esp+024h]
        mov dx, word [byte esp+028h]
        LD xor, eax, eax
        cmp byte [ScreenBitsPerPixel], 10h
        je near .10
        sub dword [byte esp+034h], byte 4
        js short .6
.1:
        LD add, bx, dx
        mov al, byte [esi]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp al, 0FFh
        je short .2
        mov byte [edi], al
.2:
        LD add, bx, dx
        mov al, byte [esi]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp al, 0FFh
        je short .3
        mov byte [byte edi+01h], al
.3:
        LD add, bx, dx
        mov al, byte [esi]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp al, 0FFh
        je short .4
        mov byte [byte edi+02h], al
.4:
        LD add, bx, dx
        mov al, byte [esi]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp al, 0FFh
        je short .5
        mov byte [byte edi+03h], al
.5:
        sub dword [byte esp+034h], byte 4
        lea edi, [byte edi+04h]
        jns short .1
.6:
        add dword [byte esp+034h], byte 3
        js short .9
.7:
        LD add, bx, dx
        mov al, byte [esi]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp al, 0FFh
        je short .8
        mov byte [edi], al
.8:
        sub dword [byte esp+034h], byte 1
        lea edi, [byte edi+01h]
        jns short .7
.9:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.10:
        shr esi, 1
        sub dword [byte esp+034h], byte 4
        js short .16
.11:
        LD add, bx, dx
        mov ax, word [nosplit esi*2+00h]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp ax, byte 0
        je short .12
        mov word [edi], ax
.12:
        LD add, bx, dx
        mov ax, word [nosplit esi*2+00h]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp ax, byte 0
        je short .13
        mov word [byte edi+02h], ax
.13:
        LD add, bx, dx
        mov ax, word [nosplit esi*2+00h]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp ax, byte 0
        je short .14
        mov word [byte edi+04h], ax
.14:
        LD add, bx, dx
        mov ax, word [nosplit esi*2+00h]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp ax, byte 0
        je short .15
        mov word [byte edi+06h], ax
.15:
        sub dword [byte esp+034h], byte 4
        lea edi, [byte edi+08h]
        jns short .11
.16:
        add dword [byte esp+034h], byte 3
        js short .19
.17:
        LD add, bx, dx
        mov ax, word [nosplit esi*2+00h]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp ax, byte 0
        je short .18
        mov word [edi], ax
.18:
        sub dword [byte esp+034h], byte 1
        lea edi, [byte edi+02h]
        jns short .17
.19:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; TexSpanShadow                                  12E9D8  97 PC, low confidence
; Draws one span of a texture, skipping transparent pixels and darkening
; under shadow (FEh) pixels
;-----------------------------------------------------------------------------
TexSpanShadow:
        push ebx
        push esi
        push edi
        push ebp
        mov esi, dword [byte esp+014h]
        mov edi, dword [byte esp+018h]
        mov ebx, dword [byte esp+01Ch]
        shl ebx, 10h
        mov ebp, dword [byte esp+020h]
        shl ebp, 10h
        mov bx, word [byte esp+024h]
        mov dx, word [byte esp+028h]
        LD xor, eax, eax
        cmp byte [ScreenBitsPerPixel], 10h
        je near .15
        sub dword [byte esp+034h], byte 4
        js near .10
.1:
        LD add, bx, dx
        mov al, byte [esi]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp al, 0FEh
        jb short .2
        jne short .3
        mov al, byte [edi]
        mov al, byte [dword eax+RemapTable]
.2:
        mov byte [edi], al
.3:
        LD add, bx, dx
        mov al, byte [esi]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp al, 0FEh
        jb short .4
        jne short .5
        mov al, byte [byte edi+01h]
        mov al, byte [dword eax+RemapTable]
.4:
        mov byte [byte edi+01h], al
.5:
        LD add, bx, dx
        mov al, byte [esi]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp al, 0FEh
        jb short .6
        jne short .7
        mov al, byte [byte edi+02h]
        mov al, byte [dword eax+RemapTable]
.6:
        mov byte [byte edi+02h], al
.7:
        LD add, bx, dx
        mov al, byte [esi]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp al, 0FEh
        jb short .8
        jne short .9
        mov al, byte [byte edi+03h]
        mov al, byte [dword eax+RemapTable]
.8:
        mov byte [byte edi+03h], al
.9:
        sub dword [byte esp+034h], byte 4
        lea edi, [byte edi+04h]
        jns near .1
.10:
        add dword [byte esp+034h], byte 3
        js short .14
.11:
        LD add, bx, dx
        mov al, byte [esi]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp al, 0FEh
        jb short .12
        jne short .13
        mov al, byte [edi]
        mov al, byte [dword eax+RemapTable]
.12:
        mov byte [edi], al
.13:
        sub dword [byte esp+034h], byte 1
        lea edi, [byte edi+01h]
        jns short .11
.14:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.15:
        shr esi, 1
        sub dword [byte esp+034h], byte 4
        js near .21
.16:
        LD add, bx, dx
        mov ax, word [nosplit esi*2+00h]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp ax, byte 0
        je short .17
        mov ax, word [edi]
        shr ax, 1
        and ax, 7BEFh
        mov word [edi], ax
.17:
        LD add, bx, dx
        mov ax, word [nosplit esi*2+00h]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp ax, byte 0
        je short .18
        mov ax, word [byte edi+02h]
        shr ax, 1
        and ax, 7BEFh
        mov word [byte edi+02h], ax
.18:
        LD add, bx, dx
        mov ax, word [nosplit esi*2+00h]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp ax, byte 0
        je short .19
        mov ax, word [byte edi+04h]
        shr ax, 1
        and ax, 7BEFh
        mov word [byte edi+04h], ax
.19:
        LD add, bx, dx
        mov ax, word [nosplit esi*2+00h]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp ax, byte 0
        je short .20
        mov ax, word [byte edi+06h]
        shr ax, 1
        and ax, 7BEFh
        mov word [byte edi+06h], ax
.20:
        sub dword [byte esp+034h], byte 4
        lea edi, [byte edi+08h]
        jns near .16
.21:
        add dword [byte esp+034h], byte 3
        js short .24
.22:
        LD add, bx, dx
        mov ax, word [nosplit esi*2+00h]
        LD sbb, ecx, ecx
        LD add, ebx, ebp
        adc esi, dword [byte esp+ecx*4+030h]
        cmp ax, byte 0
        je short .23
        mov ax, word [edi]
        shr ax, 1
        and ax, 7BEFh
        mov word [edi], ax
.23:
        sub dword [byte esp+034h], byte 1
        lea edi, [byte edi+02h]
        jns short .22
.24:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; ClipDrawEdgeAtX                                12EBD0  97 PC, low confidence
; Clips an edge of a drawn polygon at a vertical line, interpolating its
; vertex values
;-----------------------------------------------------------------------------
ClipDrawEdgeAtX:
        push ebx
        push esi
        push edi
        push ebp
        mov edi, dword [byte esp+014h]
        mov esi, dword [byte esp+01Ch]
        mov ebp, dword [byte esp+028h]
        mov eax, dword [byte esp+018h]
        mov edx, dword [edi]
        mov eax, dword [eax]
        mov ebx, dword [edi]
        sub eax, edx
        mov edx, dword [byte esp+02Ch]
        sub edx, ebx
        mov ebx, eax
        mov eax, edx
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        mov ebx, eax
        push eax
        mov eax, dword [byte esp+01Ch]
        mov ecx, dword [byte eax+04h]
        push ecx
        mov eax, dword [byte edi+04h]
        push eax
        call FixedLerp
        add esp, byte 0Ch
        mov edx, dword [byte esp+024h]
        mov dword [byte edx+04h], eax
        mov eax, dword [byte esp+02Ch]
        cmp eax, dword [edi]
        jne short .1
        mov eax, dword [byte esp+024h]
        mov ecx, dword [byte edi+04h]
        mov eax, dword [byte eax+04h]
        cmp eax, ecx
        jne short .1
        xor eax, ecx
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.1:
        mov edx, dword [byte esp+024h]
        mov eax, dword [byte esp+02Ch]
        mov dword [edx], eax
        mov edx, dword [byte esp+020h]
        mov eax, dword [esi]
        mov edi, dword [edx]
        cmp eax, edi
        je short .2
        push ebx
        push edi
        push eax
        call FixedLerp
        add esp, byte 0Ch
        jmp short .3
.2:
        mov eax, dword [esi]
.3:
        mov dword [byte ebp+00h], eax
        mov edx, dword [byte esp+020h]
        mov eax, dword [byte esi+04h]
        mov edi, dword [byte edx+04h]
        cmp eax, edi
        je short .4
        push ebx
        push edi
        push eax
        call FixedLerp
        add esp, byte 0Ch
        jmp short .5
.4:
        mov eax, dword [byte esi+04h]
.5:
        mov dword [byte ebp+04h], eax
        mov eax, 1
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ClipDrawEdgeAtY                                12EC9C  97 PC, low confidence
; Clips an edge of a drawn polygon at a horizontal line, interpolating its
; vertex values
;-----------------------------------------------------------------------------
ClipDrawEdgeAtY:
        push ebx
        push esi
        push edi
        push ebp
        mov edi, dword [byte esp+014h]
        mov esi, dword [byte esp+01Ch]
        mov ebp, dword [byte esp+028h]
        mov eax, dword [byte esp+018h]
        mov edx, dword [byte edi+04h]
        mov eax, dword [byte eax+04h]
        mov ebx, dword [byte edi+04h]
        sub eax, edx
        mov edx, dword [byte esp+02Ch]
        sub edx, ebx
        mov ebx, eax
        mov eax, edx
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        mov ebx, eax
        push eax
        mov eax, dword [byte esp+01Ch]
        mov ecx, dword [eax]
        push ecx
        mov eax, dword [edi]
        push eax
        call FixedLerp
        add esp, byte 0Ch
        mov edx, dword [byte esp+024h]
        mov dword [edx], eax
        mov eax, dword [byte esp+02Ch]
        cmp eax, dword [byte edi+04h]
        jne short .1
        mov eax, dword [byte esp+024h]
        mov ecx, dword [edi]
        mov eax, dword [eax]
        cmp eax, ecx
        jne short .1
        xor eax, ecx
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.1:
        mov edx, dword [byte esp+024h]
        mov eax, dword [byte esp+02Ch]
        mov dword [byte edx+04h], eax
        mov edx, dword [byte esp+020h]
        mov eax, dword [esi]
        mov edi, dword [edx]
        cmp eax, edi
        je short .2
        push ebx
        push edi
        push eax
        call FixedLerp
        add esp, byte 0Ch
        jmp short .3
.2:
        mov eax, dword [esi]
.3:
        mov dword [byte ebp+00h], eax
        mov edx, dword [byte esp+020h]
        mov eax, dword [byte esi+04h]
        mov edi, dword [byte edx+04h]
        cmp eax, edi
        je short .4
        push ebx
        push edi
        push eax
        call FixedLerp
        add esp, byte 0Ch
        jmp short .5
.4:
        mov eax, dword [byte esi+04h]
.5:
        mov dword [byte ebp+04h], eax
        mov eax, 1
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ClipDrawPolyLeft                               12ED68  97 PC, low confidence
; Clips a drawn polygon against the left edge of the clip window
;-----------------------------------------------------------------------------
ClipDrawPolyLeft:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov ebp, dword [byte esp+02Ch]
        mov ebx, dword [byte esp+030h]
        mov eax, dword [byte ebp+00h]
        xor edx, edx
        mov dword [esp], eax
        mov dword [byte esp+010h], edx
        lea edx, [byte eax+08h]
        mov dword [byte esp+0Ch], edx
        mov edx, dword [ebx]
        mov dword [byte esp+04h], edx
        mov dword [byte ebp+00h], PolyClipLeftIn
        lea ecx, [byte edx+08h]
        mov ebp, dword [byte ebp+00h]
        mov dword [ebx], PolyClipLeftOut
        mov dword [byte esp+08h], ecx
        mov ebx, dword [ebx]
.1:
        mov esi, dword [ClipTopRow]
        cmp esi, dword [eax]
        jle short .2
        mov ecx, dword [byte esp+0Ch]
        cmp esi, dword [ecx]
        jg near .5
        push esi
        push ebx
        push ebp
        push edx
        mov edx, dword [byte esp+018h]
        push edx
        push eax
        mov ecx, dword [byte esp+024h]
        push ecx
        call ClipDrawEdgeAtX
        add esp, byte 1Ch
        test eax, eax
        je near .5
        mov esi, dword [byte esp+010h]
        add ebp, byte 8
        inc esi
        add ebx, byte 8
        mov dword [byte esp+010h], esi
        jmp short .5
.2:
        mov ecx, dword [byte esp+0Ch]
        cmp esi, dword [ecx]
        jle short .4
        mov edi, ebp
        mov esi, eax
        movsd
        movsd
        mov edi, ebx
        mov esi, edx
        movsd
        movsd
        mov ecx, dword [ClipTopRow]
        push ecx
        add ebx, byte 8
        push ebx
        add ebp, byte 8
        push ebp
        mov esi, dword [byte esp+014h]
        push esi
        push edx
        mov edi, dword [byte esp+020h]
        push edi
        push eax
        call ClipDrawEdgeAtX
        add esp, byte 1Ch
        test eax, eax
        je short .3
        mov edx, dword [byte esp+010h]
        add ebp, byte 8
        add edx, byte 2
        add ebx, byte 8
        mov dword [byte esp+010h], edx
        jmp short .5
.3:
        inc dword [byte esp+010h]
        jmp short .5
.4:
        mov edi, ebp
        mov esi, eax
        mov eax, dword [byte esp+010h]
        movsd
        movsd
        add ebp, byte 8
        mov edi, ebx
        mov esi, edx
        inc eax
        add ebx, byte 8
        mov dword [byte esp+010h], eax
        movsd
        movsd
.5:
        mov edi, dword [byte esp+028h]
        dec edi
        mov dword [byte esp+028h], edi
        test edi, edi
        jle short ClipDrawPolyLeft_137
        mov edx, dword [byte esp+08h]
        mov eax, dword [byte esp+0Ch]
        cmp edi, byte 1
        jne short .6
        mov ecx, dword [esp]
        mov dword [byte esp+0Ch], ecx
        mov ecx, dword [byte esp+04h]
        mov dword [byte esp+08h], ecx
        jmp near .1
.6:
        lea edi, [byte edx+08h]
        lea esi, [byte eax+08h]
        mov dword [byte esp+08h], edi
        mov dword [byte esp+0Ch], esi
        jmp near .1
ClipDrawPolyLeft_137:
        mov eax, dword [byte esp+010h]
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ClipDrawPolyRight                              12EEAC  97 PC, low confidence
; Clips a drawn polygon against the right edge of the clip window
;-----------------------------------------------------------------------------
ClipDrawPolyRight:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov ebx, dword [byte esp+02Ch]
        mov ebp, dword [byte esp+030h]
        mov eax, dword [ebx]
        xor edx, edx
        mov dword [byte esp+04h], eax
        mov dword [byte esp+010h], edx
        lea edx, [byte eax+08h]
        mov dword [byte esp+0Ch], edx
        mov edx, dword [byte ebp+00h]
        mov dword [esp], edx
        mov dword [ebx], PolyClipRightOut
        lea ecx, [byte edx+08h]
        mov ebx, dword [ebx]
        mov dword [byte ebp+00h], PolyClipRightIn
        mov dword [byte esp+08h], ecx
        mov ebp, dword [byte ebp+00h]
.1:
        mov esi, dword [ClipRight]
        cmp esi, dword [eax]
        jg short .2
        mov ecx, dword [byte esp+0Ch]
        cmp esi, dword [ecx]
        jle near .5
        push esi
        push ebp
        push ebx
        push edx
        mov edx, dword [byte esp+018h]
        push edx
        push eax
        mov ecx, dword [byte esp+024h]
        push ecx
        call ClipDrawEdgeAtX
        add esp, byte 1Ch
        test eax, eax
        je near .5
        mov esi, dword [byte esp+010h]
        add ebx, byte 8
        inc esi
        add ebp, byte 8
        mov dword [byte esp+010h], esi
        jmp short .5
.2:
        mov ecx, dword [byte esp+0Ch]
        cmp esi, dword [ecx]
        jg short .4
        mov edi, ebx
        mov esi, eax
        movsd
        movsd
        mov edi, ebp
        mov esi, edx
        movsd
        movsd
        mov ecx, dword [ClipRight]
        push ecx
        add ebp, byte 8
        push ebp
        add ebx, byte 8
        push ebx
        mov esi, dword [byte esp+014h]
        push esi
        push edx
        mov edi, dword [byte esp+020h]
        push edi
        push eax
        call ClipDrawEdgeAtX
        add esp, byte 1Ch
        test eax, eax
        je short .3
        mov edx, dword [byte esp+010h]
        add ebp, byte 8
        add edx, byte 2
        add ebx, byte 8
        mov dword [byte esp+010h], edx
        jmp short .5
.3:
        inc dword [byte esp+010h]
        jmp short .5
.4:
        mov edi, ebx
        mov esi, eax
        mov eax, dword [byte esp+010h]
        movsd
        movsd
        add ebx, byte 8
        mov edi, ebp
        mov esi, edx
        inc eax
        add ebp, byte 8
        mov dword [byte esp+010h], eax
        movsd
        movsd
.5:
        mov edi, dword [byte esp+028h]
        dec edi
        mov dword [byte esp+028h], edi
        test edi, edi
        jle near ClipDrawPolyLeft_137
        mov edx, dword [byte esp+08h]
        mov eax, dword [byte esp+0Ch]
        cmp edi, byte 1
        jne short .6
        mov ecx, dword [byte esp+04h]
        mov dword [byte esp+0Ch], ecx
        mov ecx, dword [esp]
        mov dword [byte esp+08h], ecx
        jmp near .1
.6:
        lea edi, [byte edx+08h]
        lea esi, [byte eax+08h]
        mov dword [byte esp+08h], edi
        mov dword [byte esp+0Ch], esi
        jmp near .1
        db 090h
;-----------------------------------------------------------------------------
; ClipDrawPolyTop                                12EFE8  97 PC, low confidence
; Clips a drawn polygon against the top edge of the clip window
;-----------------------------------------------------------------------------
ClipDrawPolyTop:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov ebx, dword [byte esp+02Ch]
        mov ebp, dword [byte esp+030h]
        mov eax, dword [ebx]
        xor edx, edx
        mov dword [byte esp+04h], eax
        mov dword [byte esp+010h], edx
        lea edx, [byte eax+08h]
        mov dword [byte esp+0Ch], edx
        mov edx, dword [byte ebp+00h]
        mov dword [esp], edx
        mov dword [ebx], PolyClipTopOut
        lea ecx, [byte edx+08h]
        mov ebx, dword [ebx]
        mov dword [byte ebp+00h], PolyClipTopIn
        mov dword [byte esp+08h], ecx
        mov ebp, dword [byte ebp+00h]
.1:
        mov esi, dword [ClipLeftCol]
        cmp esi, dword [byte eax+04h]
        jle short .2
        mov ecx, dword [byte esp+0Ch]
        cmp esi, dword [byte ecx+04h]
        jg near .5
        push esi
        push ebp
        push ebx
        push edx
        mov edx, dword [byte esp+018h]
        push edx
        push eax
        mov ecx, dword [byte esp+024h]
        push ecx
        call ClipDrawEdgeAtY
        add esp, byte 1Ch
        test eax, eax
        je near .5
        mov esi, dword [byte esp+010h]
        add ebp, byte 8
        inc esi
        add ebx, byte 8
        mov dword [byte esp+010h], esi
        jmp near .5
.2:
        mov ecx, dword [byte esp+0Ch]
        cmp esi, dword [byte ecx+04h]
        jle short .4
        mov edi, ebx
        mov esi, eax
        movsd
        movsd
        mov edi, ebp
        mov esi, edx
        movsd
        movsd
        mov ecx, dword [ClipLeftCol]
        push ecx
        add ebp, byte 8
        push ebp
        add ebx, byte 8
        push ebx
        mov esi, dword [byte esp+014h]
        push esi
        push edx
        mov edi, dword [byte esp+020h]
        push edi
        push eax
        call ClipDrawEdgeAtY
        add esp, byte 1Ch
        test eax, eax
        je short .3
        mov edx, dword [byte esp+010h]
        add ebp, byte 8
        add edx, byte 2
        add ebx, byte 8
        mov dword [byte esp+010h], edx
        jmp short .5
.3:
        inc dword [byte esp+010h]
        jmp short .5
.4:
        mov edi, ebx
        mov esi, eax
        mov eax, dword [byte esp+010h]
        movsd
        movsd
        add ebx, byte 8
        mov edi, ebp
        mov esi, edx
        inc eax
        add ebp, byte 8
        mov dword [byte esp+010h], eax
        movsd
        movsd
.5:
        mov edi, dword [byte esp+028h]
        dec edi
        mov dword [byte esp+028h], edi
        test edi, edi
        jle near ClipDrawPolyLeft_137
        mov edx, dword [byte esp+08h]
        mov eax, dword [byte esp+0Ch]
        cmp edi, byte 1
        jne short .6
        mov ecx, dword [byte esp+04h]
        mov dword [byte esp+0Ch], ecx
        mov ecx, dword [esp]
        mov dword [byte esp+08h], ecx
        jmp near .1
.6:
        lea edi, [byte edx+08h]
        lea esi, [byte eax+08h]
        mov dword [byte esp+08h], edi
        mov dword [byte esp+0Ch], esi
        jmp near .1
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ClipDrawPolyBottom                             12F12C  97 PC, low confidence
; Clips a drawn polygon against the bottom edge of the clip window
;-----------------------------------------------------------------------------
ClipDrawPolyBottom:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov ebx, dword [byte esp+02Ch]
        mov ebp, dword [byte esp+030h]
        mov eax, dword [ebx]
        xor edx, edx
        mov dword [byte esp+04h], eax
        mov dword [byte esp+010h], edx
        lea edx, [byte eax+08h]
        mov dword [byte esp+0Ch], edx
        mov edx, dword [byte ebp+00h]
        mov dword [esp], edx
        mov dword [ebx], PolyClipBottomOut
        lea ecx, [byte edx+08h]
        mov ebx, dword [ebx]
        mov dword [byte ebp+00h], PolyClipBottomIn
        mov dword [byte esp+08h], ecx
        mov ebp, dword [byte ebp+00h]
.1:
        mov esi, dword [ScreenHeight]
        cmp esi, dword [byte eax+04h]
        jg short .2
        mov ecx, dword [byte esp+0Ch]
        cmp esi, dword [byte ecx+04h]
        jle near .5
        push esi
        push ebp
        push ebx
        push edx
        mov edx, dword [byte esp+018h]
        push edx
        push eax
        mov ecx, dword [byte esp+024h]
        push ecx
        call ClipDrawEdgeAtY
        add esp, byte 1Ch
        test eax, eax
        je near .5
        mov esi, dword [byte esp+010h]
        add ebp, byte 8
        inc esi
        add ebx, byte 8
        mov dword [byte esp+010h], esi
        jmp near .5
.2:
        mov ecx, dword [byte esp+0Ch]
        cmp esi, dword [byte ecx+04h]
        jg short .4
        mov edi, ebx
        mov esi, eax
        movsd
        movsd
        mov edi, ebp
        mov esi, edx
        movsd
        movsd
        mov ecx, dword [ScreenHeight]
        push ecx
        add ebp, byte 8
        push ebp
        add ebx, byte 8
        push ebx
        mov esi, dword [byte esp+014h]
        push esi
        push edx
        mov edi, dword [byte esp+020h]
        push edi
        push eax
        call ClipDrawEdgeAtY
        add esp, byte 1Ch
        test eax, eax
        je short .3
        mov edx, dword [byte esp+010h]
        add ebp, byte 8
        add edx, byte 2
        add ebx, byte 8
        mov dword [byte esp+010h], edx
        jmp short .5
.3:
        inc dword [byte esp+010h]
        jmp short .5
.4:
        mov edi, ebx
        mov esi, eax
        mov eax, dword [byte esp+010h]
        movsd
        movsd
        add ebx, byte 8
        mov edi, ebp
        mov esi, edx
        inc eax
        add ebp, byte 8
        mov dword [byte esp+010h], eax
        movsd
        movsd
.5:
        mov edi, dword [byte esp+028h]
        dec edi
        mov dword [byte esp+028h], edi
        test edi, edi
        jle near ClipDrawPolyLeft_137
        mov edx, dword [byte esp+08h]
        mov eax, dword [byte esp+0Ch]
        cmp edi, byte 1
        jne short .6
        mov ecx, dword [byte esp+04h]
        mov dword [byte esp+0Ch], ecx
        mov ecx, dword [esp]
        mov dword [byte esp+08h], ecx
        jmp near .1
.6:
        lea edi, [byte edx+08h]
        lea esi, [byte eax+08h]
        mov dword [byte esp+08h], edi
        mov dword [byte esp+0Ch], esi
        jmp near .1
        db 00h,00h,00h
