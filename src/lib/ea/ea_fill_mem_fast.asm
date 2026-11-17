; EA library: FillMemFast, RemapPixels.
bits 32
%include "hockey.inc"
section s_122ECB progbits alloc exec nowrite align=1
extern RemapTable
global FillMemFast, RemapPixels
        db 00h
;-----------------------------------------------------------------------------
; FillMemFast                                    122ECC  97 PC, low confidence
; Fills memory with an 8-byte pattern using 64-bit FPU stores
;-----------------------------------------------------------------------------
FillMemFast:
        push ecx
        push eax
        push edx
        mov ecx, dword [ebx]
        test eax, 7
        jne short .11
.1:
        cmp edx, byte 0
        jl short .6
        fld qword [ebx]
        sub edx, byte 20h
        js short .3
.2:
        fst qword [eax]
        fst qword [byte eax+08h]
        fst qword [byte eax+010h]
        fst qword [byte eax+018h]
        lea eax, [byte eax+020h]
        sub edx, byte 20h
        jns short .2
.3:
        add edx, byte 18h
        js short .5
.4:
        fst qword [eax]
        lea eax, [byte eax+08h]
        sub edx, byte 8
        jns short .4
.5:
        fstp st0
        add edx, byte 8
        jne short .7
.6:
        pop edx
        pop eax
        pop ecx
        ret
.7:
        test edx, 4
        je short .8
        mov dword [eax], ecx
        lea eax, [byte eax+04h]
.8:
        test edx, 2
        je short .9
        mov word [eax], cx
        lea eax, [byte eax+02h]
.9:
        test edx, 1
        je short .10
        mov byte [eax], cl
.10:
        pop edx
        pop eax
        pop ecx
        ret
.11:
        test eax, 1
        je short .12
        cmp edx, byte 1
        jl short .12
        mov byte [eax], cl
        lea eax, [byte eax+01h]
        sub edx, byte 1
.12:
        test eax, 2
        je short .13
        cmp edx, byte 2
        jl short .13
        mov word [eax], cx
        lea eax, [byte eax+02h]
        sub edx, byte 2
.13:
        test eax, 4
        je short .14
        cmp edx, byte 4
        jl short .14
        mov dword [eax], ecx
        lea eax, [byte eax+04h]
        sub edx, byte 4
.14:
        jmp near .1
;-----------------------------------------------------------------------------
; RemapPixels                                    122F7C  97 PC, low confidence
; Translates a run of pixels through the colour remap table
;-----------------------------------------------------------------------------
RemapPixels:
        push ebp
        LD mov, ebp, esp
        push ebx
        push esi
        push edi
        cld
        mov edi, dword [byte ebp+08h]
        LD xor, edx, edx
        mov ecx, dword [byte ebp+0Ch]
        cmp ecx, byte 4
        jl short .4
        cmp ecx, byte 0Ah
        jl short .2
        test edi, 3
        je short .2
.1:
        mov dl, byte [edi]
        dec ecx
        mov al, byte [dword edx+RemapTable]
        inc edi
        mov byte [byte edi-01h], al
        test edi, 3
        jne short .1
.2:
        sub ecx, byte 4
.3:
        mov ebx, dword [edi]
        LD mov, dl, bl
        mov al, byte [dword edx+RemapTable]
        LD mov, dl, bh
        mov ah, byte [dword edx+RemapTable]
        ror eax, 10h
        ror ebx, 10h
        LD mov, dl, bl
        mov al, byte [dword edx+RemapTable]
        LD mov, dl, bh
        mov ah, byte [dword edx+RemapTable]
        ror eax, 10h
        add edi, byte 4
        mov dword [byte edi-04h], eax
        sub ecx, byte 4
        jge short .3
        add ecx, byte 4
.4:
        cmp ecx, byte 0
        jg short .5
        pop edi
        pop esi
        pop ebx
        leave
        ret
.5:
        mov dl, byte [edi]
        inc edi
        mov al, byte [dword edx+RemapTable]
        dec ecx
        mov byte [byte edi-01h], al
        jg short .4
        pop edi
        pop esi
        pop ebx
        leave
        ret
