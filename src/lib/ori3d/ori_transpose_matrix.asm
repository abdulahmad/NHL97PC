; 3D library: TransposeMatrix, PolyCrossProduct, TexSpanCopy, ClipTexEdgeAtX, ClipTexEdgeAtY and 5 more.
bits 32
%include "hockey.inc"
section s_12D6C4 progbits alloc exec nowrite align=1
extern ClipLeftCol, ClipRight, ClipTexVertsTop, ClipTopRow, ScreenHeight, SinCosLookup, TexClipBottomIn, TexClipBottomOut
extern TexClipLeftIn, TexClipLeftOut, TexClipRightIn, TexClipRightOut, TexClipTopOut
global TransposeMatrix, PolyCrossProduct, TexSpanCopy, ClipTexEdgeAtX, ClipTexEdgeAtY, ClipTexPolyLeft, ClipTexPolyLeft_13C, ClipTexPolyRight
global ClipTexPolyTop, ClipTexPolyBottom, MakeRotationZ
;-----------------------------------------------------------------------------
; TransposeMatrix                                12D6C4  97 PC, low confidence
; Transposes a 3x3 matrix, in place or into another matrix
;-----------------------------------------------------------------------------
TransposeMatrix:
        push ebp
        LD mov, ebp, esp
        push ebx
        push esi
        push edi
        mov esi, dword [byte ebp+08h]
        mov edi, dword [byte ebp+0Ch]
        mov ecx, 9
        LD cmp, esi, edi
        jne short .1
        mov eax, dword [byte esi+04h]
        xchg eax, dword [byte esi+0Ch]
        mov dword [byte esi+04h], eax
        mov eax, dword [byte esi+08h]
        xchg eax, dword [byte esi+018h]
        mov dword [byte esi+08h], eax
        mov eax, dword [byte esi+014h]
        xchg eax, dword [byte esi+01Ch]
        mov dword [byte esi+014h], eax
        pop edi
        pop esi
        pop ebx
        leave
        ret
.1:
        mov eax, dword [esi]
        mov dword [edi], eax
        mov eax, dword [byte esi+04h]
        mov dword [byte edi+0Ch], eax
        mov eax, dword [byte esi+08h]
        mov dword [byte edi+018h], eax
        mov eax, dword [byte esi+0Ch]
        mov dword [byte edi+04h], eax
        mov eax, dword [byte esi+010h]
        mov dword [byte edi+010h], eax
        mov eax, dword [byte esi+014h]
        mov dword [byte edi+01Ch], eax
        mov eax, dword [byte esi+018h]
        mov dword [byte edi+08h], eax
        db 08Bh,046h,01Ch                       ; insn: mov eax,[esi+1Ch]
        db 089h,047h,014h                       ; insn: mov [edi+14h],eax
        mov eax, dword [byte esi+020h]
        mov dword [byte edi+020h], eax
        pop edi
        pop esi
        pop ebx
        leave
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; PolyCrossProduct                               12D740  97 PC, low confidence
; Returns the 2D cross product of three indexed polygon points (its winding)
;-----------------------------------------------------------------------------
PolyCrossProduct:
        push ebx
        push esi
        mov eax, dword [byte esp+0Ch]
        mov edx, dword [byte esp+010h]
        mov ebx, dword [byte edx+08h]
        mov esi, dword [byte edx+04h]
        shl ebx, 3
        mov edx, dword [edx]
        shl esi, 3
        shl edx, 3
        add ebx, eax
        add esi, eax
        add edx, eax
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov eax, ebx
        pop esi
        pop ebx
        ret
        db 00h,00h
;-----------------------------------------------------------------------------
; TexSpanCopy                                    12D784  97 PC, low confidence
; Draws one span of a texture by stepping 16.16 source coordinates
;-----------------------------------------------------------------------------
TexSpanCopy:
        push ebx
        push esi
        push edi
        push ebp
        mov dx, word [byte esp+020h]
        mov ebx, dword [byte esp+024h]
        shl ebx, 10h
        mov ebp, dword [byte esp+028h]
        shl ebp, 10h
        mov esi, dword [byte esp+014h]
        mov bx, word [byte esp+01Ch]
        mov edi, dword [byte esp+018h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        test ebp, 0FFC00000h
        je near .9
        cmp dword [byte esp+034h], byte 8
        jb near .5
        sub dword [byte esp+034h], byte 10h
        js near .2
        test edi, 3
        jne near .8
.1:
        LD add, bx, dx
        mov al, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        LD add, bx, dx
        mov ah, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        shl eax, 10h
        LD add, bx, dx
        mov al, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        LD add, bx, dx
        mov ah, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        rol eax, 10h
        mov dword [edi], eax
        LD add, bx, dx
        mov al, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        LD add, bx, dx
        mov ah, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        shl eax, 10h
        LD add, bx, dx
        mov al, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        LD add, bx, dx
        mov ah, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        rol eax, 10h
        mov dword [byte edi+04h], eax
        LD add, bx, dx
        mov al, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        LD add, bx, dx
        mov ah, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        shl eax, 10h
        LD add, bx, dx
        mov al, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        LD add, bx, dx
        mov ah, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        rol eax, 10h
        mov dword [byte edi+08h], eax
        LD add, bx, dx
        mov al, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        LD add, bx, dx
        mov ah, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        shl eax, 10h
        LD add, bx, dx
        mov al, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        LD add, bx, dx
        mov ah, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        rol eax, 10h
        mov dword [byte edi+0Ch], eax
        sub dword [byte esp+034h], byte 10h
        lea edi, [byte edi+010h]
        jns near .1
.2:
        add dword [byte esp+034h], byte 0Ch
        js short .4
.3:
        LD add, bx, dx
        mov al, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        LD add, bx, dx
        mov ah, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        shl eax, 10h
        LD add, bx, dx
        mov al, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        LD add, bx, dx
        mov ah, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        rol eax, 10h
        mov dword [edi], eax
        sub dword [byte esp+034h], byte 4
        lea edi, [byte edi+04h]
        jns short .3
.4:
        add dword [byte esp+034h], byte 4
        jne short .5
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.5:
        sub dword [byte esp+034h], byte 1
        js short .7
.6:
        LD add, bx, dx
        mov al, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        mov byte [edi], al
        sub dword [byte esp+034h], byte 1
        lea edi, [byte edi+01h]
        jns short .6
.7:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.8:
        LD add, bx, dx
        mov al, byte [esi]
        adc esi, dword [byte esp+ecx*4+030h]
        LD add, ebx, ebp
        LD sbb, ecx, ecx
        mov byte [edi], al
        sub dword [byte esp+034h], byte 1
        lea edi, [byte edi+01h]
        test edi, 3
        jne short .8
        cmp dword [byte esp+034h], byte 0
        jns near .1
        jmp near .2
.9:
        mov ebp, dword [byte esp+030h]
        mov ecx, dword [byte esp+034h]
        shl edx, 10h
        shl ebx, 10h
        sub ecx, byte 10h
        js near .11
        test edi, 3
        jne near .16
.10:
        LD add, ebx, edx
        mov al, byte [esi]
        LD adc, esi, ebp
        LD add, ebx, edx
        mov ah, byte [esi]
        LD adc, esi, ebp
        shl eax, 10h
        LD add, ebx, edx
        mov al, byte [esi]
        LD adc, esi, ebp
        LD add, ebx, edx
        mov ah, byte [esi]
        LD adc, esi, ebp
        rol eax, 10h
        mov dword [edi], eax
        LD add, ebx, edx
        mov al, byte [esi]
        LD adc, esi, ebp
        LD add, ebx, edx
        mov ah, byte [esi]
        LD adc, esi, ebp
        shl eax, 10h
        LD add, ebx, edx
        mov al, byte [esi]
        LD adc, esi, ebp
        LD add, ebx, edx
        mov ah, byte [esi]
        LD adc, esi, ebp
        rol eax, 10h
        mov dword [byte edi+04h], eax
        LD add, ebx, edx
        mov al, byte [esi]
        LD adc, esi, ebp
        LD add, ebx, edx
        mov ah, byte [esi]
        LD adc, esi, ebp
        shl eax, 10h
        LD add, ebx, edx
        mov al, byte [esi]
        LD adc, esi, ebp
        LD add, ebx, edx
        mov ah, byte [esi]
        LD adc, esi, ebp
        rol eax, 10h
        mov dword [byte edi+08h], eax
        LD add, ebx, edx
        mov al, byte [esi]
        LD adc, esi, ebp
        LD add, ebx, edx
        mov ah, byte [esi]
        LD adc, esi, ebp
        shl eax, 10h
        LD add, ebx, edx
        mov al, byte [esi]
        LD adc, esi, ebp
        LD add, ebx, edx
        mov ah, byte [esi]
        LD adc, esi, ebp
        rol eax, 10h
        mov dword [byte edi+0Ch], eax
        sub ecx, byte 10h
        lea edi, [byte edi+010h]
        jns near .10
.11:
        add ecx, byte 0Ch
        js short .13
.12:
        LD add, ebx, edx
        mov al, byte [esi]
        LD adc, esi, ebp
        LD add, ebx, edx
        mov ah, byte [esi]
        LD adc, esi, ebp
        shl eax, 10h
        LD add, ebx, edx
        mov al, byte [esi]
        LD adc, esi, ebp
        LD add, ebx, edx
        mov ah, byte [esi]
        LD adc, esi, ebp
        rol eax, 10h
        mov dword [edi], eax
        sub ecx, byte 4
        lea edi, [byte edi+04h]
        jns short .12
.13:
        add ecx, byte 3
        js short .15
.14:
        LD add, ebx, edx
        mov al, byte [esi]
        LD adc, esi, ebp
        mov byte [edi], al
        sub ecx, byte 1
        lea edi, [byte edi+01h]
        jns short .14
.15:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.16:
        LD add, ebx, edx
        mov al, byte [esi]
        LD adc, esi, ebp
        mov byte [edi], al
        sub ecx, byte 1
        lea edi, [byte edi+01h]
        test edi, 3
        jne short .16
        cmp ecx, byte 0
        jns near .10
        jmp short .11
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        fld dword [byte esp+04h]
        fld dword [byte esp+08h]
        fsub st1
        fmul dword [byte esp+0Ch]
        faddp
        ret 0Ch
        db 090h
;-----------------------------------------------------------------------------
; ClipTexEdgeAtX                                 12DAC4  97 PC, low confidence
; Clips a textured polygon edge at a vertical line, interpolating its texture
; coordinates
;-----------------------------------------------------------------------------
ClipTexEdgeAtX:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 20h
        mov edx, dword [byte esp+034h]
        mov ebx, dword [byte esp+038h]
        mov ecx, dword [byte esp+03Ch]
        mov ebp, dword [byte esp+040h]
        mov edi, dword [byte esp+048h]
        mov eax, dword [ebx]
        mov esi, dword [edx]
        sub eax, esi
        mov dword [esp], eax
        mov eax, dword [byte esp+04Ch]
        sub eax, esi
        mov dword [byte esp+0Ch], eax
        fild dword [byte esp+0Ch]
        fild dword [esp]
        fdivp
        mov esi, dword [byte edx+04h]
        mov eax, dword [byte ebx+04h]
        sub eax, esi
        mov dword [byte esp+0Ch], eax
        fild dword [byte esp+0Ch]
        fxch
        fstp dword [byte esp+01Ch]
        fmul dword [byte esp+01Ch]
        push eax
        fistp dword [esp]
        pop eax
        mov esi, eax
        mov eax, dword [byte edx+04h]
        add eax, esi
        mov esi, dword [byte esp+044h]
        mov dword [byte esi+04h], eax
        mov eax, dword [byte esp+04Ch]
        cmp eax, dword [edx]
        jne short .1
        mov eax, dword [byte esp+044h]
        mov esi, dword [byte edx+04h]
        mov eax, dword [byte eax+04h]
        cmp eax, esi
        jne short .1
        xor eax, esi
        jmp near .8
.1:
        mov esi, dword [byte esp+044h]
        mov eax, dword [byte esp+04Ch]
        mov dword [esi], eax
        mov eax, dword [byte edx+08h]
        cmp eax, dword [byte ebx+08h]
        jge short .2
        fild dword [byte edx+08h]
        fild dword [byte ebx+08h]
        fdivr st1
        fld1
        fsubp
        fmul dword [byte esp+01Ch]
        fld1
        jmp short .3
.2:
        fild dword [byte ebx+08h]
        fild dword [byte edx+08h]
        fdivr st1
        fld1
        fsub st1
        fmul dword [byte esp+01Ch]
.3:
        faddp
        fdivp
        fstp dword [byte esp+018h]
        mov esi, dword [byte esp+044h]
        fld dword [byte esp+018h]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [byte esi+08h], eax
        mov eax, dword [ecx]
        cmp eax, dword [byte ebp+00h]
        je short .4
        fild dword [byte ebx+08h]
        fild dword [byte ebp+00h]
        fdivrp
        fild dword [byte edx+08h]
        fild dword [ecx]
        fdivrp
        fxch
        fsub st1
        fmul dword [byte esp+01Ch]
        faddp
        fmul dword [byte esp+018h]
        push eax
        fistp dword [esp]
        pop eax
        jmp short .5
.4:
        mov eax, dword [ecx]
.5:
        mov dword [edi], eax
        mov esi, dword [byte ebp+04h]
        cmp esi, dword [byte ecx+04h]
        je short .6
        fild dword [byte ebp+04h]
        fild dword [byte ebx+08h]
        fdivp
        fild dword [byte ecx+04h]
        fild dword [byte edx+08h]
        fdivp
        fxch
        fsub st1
        fmul dword [byte esp+01Ch]
        faddp
        fmul dword [byte esp+018h]
        push eax
        fistp dword [esp]
        pop eax
        jmp short .7
.6:
        mov eax, dword [byte ecx+04h]
.7:
        mov dword [byte edi+04h], eax
        mov eax, 1
.8:
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ClipTexEdgeAtY                                 12DC04  97 PC, low confidence
; Clips a textured polygon edge at a horizontal line, interpolating its
; texture coordinates
;-----------------------------------------------------------------------------
ClipTexEdgeAtY:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 20h
        mov edx, dword [byte esp+034h]
        mov ebx, dword [byte esp+038h]
        mov ecx, dword [byte esp+03Ch]
        mov ebp, dword [byte esp+040h]
        mov edi, dword [byte esp+048h]
        mov eax, dword [byte ebx+04h]
        mov esi, dword [byte edx+04h]
        sub eax, esi
        mov dword [esp], eax
        mov eax, dword [byte esp+04Ch]
        sub eax, esi
        mov dword [byte esp+0Ch], eax
        fild dword [byte esp+0Ch]
        fild dword [esp]
        fdivp
        mov esi, dword [edx]
        mov eax, dword [ebx]
        sub eax, esi
        mov dword [byte esp+0Ch], eax
        fild dword [byte esp+0Ch]
        fxch
        fstp dword [byte esp+01Ch]
        fmul dword [byte esp+01Ch]
        push eax
        fistp dword [esp]
        pop eax
        mov esi, eax
        mov eax, dword [edx]
        add eax, esi
        mov esi, dword [byte esp+044h]
        mov dword [esi], eax
        cmp eax, dword [edx]
        jne short .1
        mov eax, dword [byte esp+04Ch]
        mov esi, dword [byte edx+04h]
        cmp eax, esi
        jne short .1
        xor eax, esi
        jmp near .8
.1:
        mov esi, dword [byte esp+044h]
        mov eax, dword [byte esp+04Ch]
        mov dword [byte esi+04h], eax
        mov eax, dword [byte edx+08h]
        cmp eax, dword [byte ebx+08h]
        jge short .2
        fild dword [byte edx+08h]
        fild dword [byte ebx+08h]
        fdivr st1
        fld1
        fsubp
        fmul dword [byte esp+01Ch]
        fld1
        jmp short .3
.2:
        fild dword [byte ebx+08h]
        fild dword [byte edx+08h]
        fdivr st1
        fld1
        fsub st1
        fmul dword [byte esp+01Ch]
.3:
        faddp
        fdivp
        fstp dword [byte esp+018h]
        mov esi, dword [byte esp+044h]
        fld dword [byte esp+018h]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [byte esi+08h], eax
        mov eax, dword [ecx]
        cmp eax, dword [byte ebp+00h]
        je short .4
        fild dword [byte ebx+08h]
        fild dword [byte ebp+00h]
        fdivrp
        fild dword [byte edx+08h]
        fild dword [ecx]
        fdivrp
        fxch
        fsub st1
        fmul dword [byte esp+01Ch]
        faddp
        fmul dword [byte esp+018h]
        push eax
        fistp dword [esp]
        pop eax
        jmp short .5
.4:
        mov eax, dword [ecx]
.5:
        mov dword [edi], eax
        mov esi, dword [byte ebp+04h]
        cmp esi, dword [byte ecx+04h]
        je short .6
        fild dword [byte ebp+04h]
        fild dword [byte ebx+08h]
        fdivp
        fild dword [byte ecx+04h]
        fild dword [byte edx+08h]
        fdivp
        fxch
        fsub st1
        fmul dword [byte esp+01Ch]
        faddp
        fmul dword [byte esp+018h]
        push eax
        fistp dword [esp]
        pop eax
        jmp short .7
.6:
        mov eax, dword [byte ecx+04h]
.7:
        mov dword [byte edi+04h], eax
        mov eax, 1
.8:
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ClipTexPolyLeft                                12DD3C  97 PC, low confidence
; Clips a textured polygon against the left edge of the clip window
;-----------------------------------------------------------------------------
ClipTexPolyLeft:
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
        lea edx, [byte eax+0Ch]
        mov dword [byte esp+0Ch], edx
        mov edx, dword [byte ebp+00h]
        mov dword [esp], edx
        mov dword [ebx], TexClipLeftOut
        lea ecx, [byte edx+08h]
        mov ebx, dword [ebx]
        mov dword [byte ebp+00h], TexClipLeftIn
        mov dword [byte esp+08h], ecx
        mov ebp, dword [byte ebp+00h]
.1:
        mov esi, dword [ClipTopRow]
        cmp esi, dword [eax]
        jle short .2
        mov ecx, dword [byte esp+0Ch]
        cmp esi, dword [ecx]
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
        call ClipTexEdgeAtX
        add esp, byte 1Ch
        test eax, eax
        je near .5
        mov esi, dword [byte esp+010h]
        add ebx, byte 0Ch
        inc esi
        add ebp, byte 8
        mov dword [byte esp+010h], esi
        jmp near .5
.2:
        mov ecx, dword [byte esp+0Ch]
        cmp esi, dword [ecx]
        jle short .4
        mov edi, ebx
        mov esi, eax
        movsd
        movsd
        movsd
        mov edi, ebp
        mov esi, edx
        movsd
        movsd
        mov ecx, dword [ClipTopRow]
        push ecx
        add ebp, byte 8
        push ebp
        add ebx, byte 0Ch
        push ebx
        mov esi, dword [byte esp+014h]
        push esi
        push edx
        mov edi, dword [byte esp+020h]
        push edi
        push eax
        call ClipTexEdgeAtX
        add esp, byte 1Ch
        test eax, eax
        je short .3
        mov edx, dword [byte esp+010h]
        add ebx, byte 0Ch
        add edx, byte 2
        add ebp, byte 8
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
        movsd
        add ebx, byte 0Ch
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
        jle short ClipTexPolyLeft_13C
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
        lea esi, [byte eax+0Ch]
        mov dword [byte esp+08h], edi
        mov dword [byte esp+0Ch], esi
        jmp near .1
ClipTexPolyLeft_13C:
        mov eax, dword [byte esp+010h]
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ClipTexPolyRight                               12DE84  97 PC, low confidence
; Clips a textured polygon against the right edge of the clip window
;-----------------------------------------------------------------------------
ClipTexPolyRight:
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
        lea edx, [byte eax+0Ch]
        mov dword [byte esp+0Ch], edx
        mov edx, dword [byte ebp+00h]
        mov dword [esp], edx
        mov dword [ebx], TexClipRightOut
        lea ecx, [byte edx+08h]
        mov ebx, dword [ebx]
        mov dword [byte ebp+00h], TexClipRightIn
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
        call ClipTexEdgeAtX
        add esp, byte 1Ch
        test eax, eax
        je near .5
        mov esi, dword [byte esp+010h]
        add ebx, byte 0Ch
        inc esi
        add ebp, byte 8
        mov dword [byte esp+010h], esi
        jmp near .5
.2:
        mov ecx, dword [byte esp+0Ch]
        cmp esi, dword [ecx]
        jg short .4
        mov edi, ebx
        mov esi, eax
        movsd
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
        add ebx, byte 0Ch
        push ebx
        mov esi, dword [byte esp+014h]
        push esi
        push edx
        mov edi, dword [byte esp+020h]
        push edi
        push eax
        call ClipTexEdgeAtX
        add esp, byte 1Ch
        test eax, eax
        je short .3
        mov edx, dword [byte esp+010h]
        add ebp, byte 8
        add edx, byte 2
        add ebx, byte 0Ch
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
        movsd
        add ebx, byte 0Ch
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
        jle near ClipTexPolyLeft_13C
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
        lea esi, [byte eax+0Ch]
        mov dword [byte esp+08h], edi
        mov dword [byte esp+0Ch], esi
        jmp near .1
;-----------------------------------------------------------------------------
; ClipTexPolyTop                                 12DFC4  97 PC, low confidence
; Clips a textured polygon against the top edge of the clip window
;-----------------------------------------------------------------------------
ClipTexPolyTop:
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
        lea edx, [byte eax+0Ch]
        mov dword [byte esp+0Ch], edx
        mov edx, dword [byte ebp+00h]
        mov dword [esp], edx
        mov dword [ebx], TexClipTopOut
        lea ecx, [byte edx+08h]
        mov ebx, dword [ebx]
        mov dword [byte ebp+00h], ClipTexVertsTop
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
        call ClipTexEdgeAtY
        add esp, byte 1Ch
        test eax, eax
        je near .5
        mov esi, dword [byte esp+010h]
        add ebp, byte 8
        inc esi
        add ebx, byte 0Ch
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
        movsd
        mov edi, ebp
        mov esi, edx
        movsd
        movsd
        mov ecx, dword [ClipLeftCol]
        push ecx
        add ebp, byte 8
        push ebp
        add ebx, byte 0Ch
        push ebx
        mov esi, dword [byte esp+014h]
        push esi
        push edx
        mov edi, dword [byte esp+020h]
        push edi
        push eax
        call ClipTexEdgeAtY
        add esp, byte 1Ch
        test eax, eax
        je short .3
        mov edx, dword [byte esp+010h]
        add ebp, byte 8
        add edx, byte 2
        add ebx, byte 0Ch
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
        movsd
        add ebx, byte 0Ch
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
        jle near ClipTexPolyLeft_13C
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
        lea esi, [byte eax+0Ch]
        mov dword [byte esp+08h], edi
        mov dword [byte esp+0Ch], esi
        jmp near .1
        db 090h
;-----------------------------------------------------------------------------
; ClipTexPolyBottom                              12E108  97 PC, low confidence
; Clips a textured polygon against the bottom edge of the clip window
;-----------------------------------------------------------------------------
ClipTexPolyBottom:
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
        lea edx, [byte eax+0Ch]
        mov dword [byte esp+0Ch], edx
        mov edx, dword [byte ebp+00h]
        mov dword [esp], edx
        mov dword [ebx], TexClipBottomOut
        lea ecx, [byte edx+08h]
        mov ebx, dword [ebx]
        mov dword [byte ebp+00h], TexClipBottomIn
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
        call ClipTexEdgeAtY
        add esp, byte 1Ch
        test eax, eax
        je near .5
        mov esi, dword [byte esp+010h]
        add ebp, byte 8
        inc esi
        add ebx, byte 0Ch
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
        movsd
        mov edi, ebp
        mov esi, edx
        movsd
        movsd
        mov ecx, dword [ScreenHeight]
        push ecx
        add ebp, byte 8
        push ebp
        add ebx, byte 0Ch
        push ebx
        mov esi, dword [byte esp+014h]
        push esi
        push edx
        mov edi, dword [byte esp+020h]
        push edi
        push eax
        call ClipTexEdgeAtY
        add esp, byte 1Ch
        test eax, eax
        je short .3
        mov edx, dword [byte esp+010h]
        add ebp, byte 8
        add edx, byte 2
        add ebx, byte 0Ch
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
        movsd
        add ebx, byte 0Ch
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
        jle near ClipTexPolyLeft_13C
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
        lea esi, [byte eax+0Ch]
        mov dword [byte esp+08h], edi
        mov dword [byte esp+0Ch], esi
        jmp near .1
        db 00h,00h,00h,00h,00h
        push ebx
        sub esp, byte 8
        mov ebx, dword [byte esp+010h]
        lea eax, [byte esp+04h]
        push eax
        lea eax, [byte esp+04h]
        push eax
        mov edx, dword [byte esp+01Ch]
        push edx
        call SinCosLookup
        mov dword [ebx], 10000h
        mov dword [byte ebx+04h], 0
        mov dword [byte ebx+08h], 0
        add esp, byte 0Ch
        mov dword [byte ebx+0Ch], 0
        mov eax, dword [byte esp+04h]
        mov dword [byte ebx+010h], eax
        mov eax, dword [esp]
        mov dword [byte ebx+018h], 0
        mov dword [byte ebx+014h], eax
        mov eax, dword [esp]
        mov ecx, eax
        mov dword [byte ebx+01Ch], eax
        neg ecx
        mov dword [byte ebx+01Ch], ecx
        mov eax, dword [byte esp+04h]
        mov dword [byte ebx+020h], eax
        add esp, byte 8
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; MakeRotationZ                                  12E2B8  97 PC, low confidence
; Builds a 3x3 matrix that rotates about Z by an angle
;-----------------------------------------------------------------------------
MakeRotationZ:
        push ebx
        sub esp, byte 8
        mov ebx, dword [byte esp+010h]
        lea eax, [byte esp+04h]
        push eax
        lea eax, [byte esp+04h]
        push eax
        mov edx, dword [byte esp+01Ch]
        push edx
        call SinCosLookup
        add esp, byte 0Ch
        mov eax, dword [byte esp+04h]
        mov dword [byte ebx+04h], 0
        mov dword [ebx], eax
        mov eax, dword [esp]
        mov dword [byte ebx+0Ch], 0
        mov dword [byte ebx+010h], 10000h
        mov dword [byte ebx+014h], 0
        mov ecx, eax
        mov dword [byte ebx+08h], eax
        neg ecx
        mov dword [byte ebx+08h], ecx
        mov eax, dword [esp]
        mov dword [byte ebx+01Ch], 0
        mov dword [byte ebx+018h], eax
        mov eax, dword [byte esp+04h]
        mov dword [byte ebx+020h], eax
        add esp, byte 8
        pop ebx
        ret
        db 090h
        push ebx
        sub esp, byte 8
        mov ebx, dword [byte esp+010h]
        lea eax, [byte esp+04h]
        push eax
        lea eax, [byte esp+04h]
        push eax
        mov edx, dword [byte esp+01Ch]
        push edx
        call SinCosLookup
        add esp, byte 0Ch
        mov eax, dword [byte esp+04h]
        mov dword [ebx], eax
        mov eax, dword [esp]
        mov dword [byte ebx+08h], 0
        mov dword [byte ebx+04h], eax
        mov eax, dword [esp]
        mov ecx, eax
        mov dword [byte ebx+0Ch], eax
        neg ecx
        mov dword [byte ebx+0Ch], ecx
        mov eax, dword [byte esp+04h]
        mov dword [byte ebx+014h], 0
        mov dword [byte ebx+018h], 0
        mov dword [byte ebx+01Ch], 0
        mov dword [byte ebx+020h], 10000h
        mov dword [byte ebx+010h], eax
        add esp, byte 8
        pop ebx
        ret
