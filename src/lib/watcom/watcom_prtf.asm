; Watcom C runtime: __prtf_, getprintspecs_, evalflags_, far_strlen_, far_other_strlen_ and 5 more.
bits 32
%include "hockey.inc"
section s_123FEA progbits alloc exec nowrite align=1
extern __EFG_printf, AtexitCount, itoa_, ltoa_, TextLimitCount, TextLimitPtr, TextLimitWidth, toupper_
extern ultoa_
global __prtf_, getprintspecs_, evalflags_, far_strlen_, far_strlen__1F, far_other_strlen_, fmt4hex_, FixedPoint_Format_
global float_format_, formstring_, zupstr_, zupstr__20
;-----------------------------------------------------------------------------
; __prtf_                                                      123FEA  library
; Run-time library: the printf formatting engine
;-----------------------------------------------------------------------------
__prtf_:
        push esi
        push edi
        push es
        push ebp
        sub esp, 124h
        mov esi, ebx
        mov dword [dword esp+011Ch], ecx
        xor bl, bl
        mov dword [dword esp+0100h], eax
        mov byte [dword esp+0120h], bl
        mov byte [dword esp+0114h], bl
        xor ebx, ebx
        mov edi, edx
        mov dword [dword esp+0110h], ebx
        mov ebp, 4
        jmp near .5
.1:
        lea ebx, [dword esp+0100h]
        mov edx, esi
        call getprintspecs_
        mov edi, eax
        mov al, byte [eax]
        inc edi
        mov byte [dword esp+0115h], al
        test al, al
        je near .28
        xor eax, eax
        mov al, byte [dword esp+0115h]
        cmp eax, byte 6Eh
        jne near .14
        mov al, byte [dword esp+0114h]
        xor edx, edx
        and al, 20h
        mov dl, al
        mov al, byte [dword esp+0114h]
        and al, 40h
        mov ah, byte [dword esp+0114h]
        and ah, 80h
        test edx, edx
        je near .7
        xor edx, edx
        mov dl, ah
        test edx, edx
        je short .3
        mov ecx, dword [esi]
        add ecx, byte 8
        mov dword [esi], ecx
        les edx, [byte ecx-08h]
.2:
        mov eax, dword [dword esp+0110h]
        mov dword [es:edx], eax
        jmp short .5
.3:
        and eax, 0FFh
        je short .6
        mov ebx, dword [esi]
        add ebx, ebp
        mov dword [esi], ebx
        mov edx, dword [byte ebx-04h]
.4:
        mov eax, dword [dword esp+0110h]
        mov dword [edx], eax
.5:
        mov cl, byte [edi]
        test cl, cl
        je near .28
        xor edx, edx
        mov dl, cl
        lea eax, [byte edi+01h]
        cmp edx, byte 25h
        je near .1
        mov edi, eax
        lea eax, [dword esp+0100h]
        call dword [dword esp+011Ch]
        jmp short .5
.6:
        mov edx, dword [esi]
        add edx, ebp
        mov dword [esi], edx
        mov edx, dword [byte edx-04h]
        jmp short .4
.7:
        mov dl, byte [dword esp+0114h]
        and dl, 10h
        and edx, 0FFh
        je short .11
        xor edx, edx
        mov dl, ah
        test edx, edx
        je short .8
        mov eax, dword [esi]
        add eax, byte 8
        mov dword [esi], eax
        les edx, [byte eax-08h]
        mov eax, dword [dword esp+0110h]
        db 066h,026h,089h,02h                   ; insn: mov [es:edx],ax
        jmp short .5
.8:
        and eax, 0FFh
        je short .10
        mov ecx, dword [esi]
        add ecx, ebp
        mov dword [esi], ecx
        mov edx, dword [byte ecx-04h]
.9:
        mov eax, dword [dword esp+0110h]
        mov word [edx], ax
        jmp near .5
.10:
        mov ebx, dword [esi]
        add ebx, ebp
        mov dword [esi], ebx
        mov edx, dword [byte ebx-04h]
        jmp short .9
.11:
        mov dl, ah
        test edx, edx
        je short .12
        mov edx, dword [esi]
        add edx, byte 8
        mov dword [esi], edx
        les edx, [byte edx-08h]
        jmp near .2
.12:
        and eax, 0FFh
        je short .13
        mov eax, dword [esi]
        add eax, ebp
        mov dword [esi], eax
        mov edx, dword [byte eax-04h]
        jmp near .4
.13:
        mov ecx, dword [esi]
        add ecx, ebp
        mov dword [esi], ecx
        mov edx, dword [byte ecx-04h]
        jmp near .4
.14:
        lea ecx, [dword esp+0120h]
        lea ebx, [dword esp+0100h]
        mov eax, esp
        mov edx, esi
        call formstring_
        mov ebx, eax
        mov al, byte [dword esp+0114h]
        mov es, edx
        and al, 8
        and eax, 0FFh
        jne short .16
        mov al, byte [dword esp+0116h]
        cmp eax, byte 20h
        jne short .16
.15:
        mov eax, dword [dword esp+0104h]
        dec eax
        mov dword [dword esp+0104h], eax
        test eax, eax
        jl short .16
        xor edx, edx
        lea eax, [dword esp+0100h]
        mov dl, byte [dword esp+0116h]
        call dword [dword esp+011Ch]
        jmp short .15
.16:
        lea ecx, [dword esp+0117h]
.17:
        mov al, byte [ecx]
        test al, al
        je short .18
        xor edx, edx
        mov dl, al
        lea eax, [dword esp+0100h]
        inc ecx
        call dword [dword esp+011Ch]
        jmp short .17
.18:
        mov eax, dword [dword esp+010Ch]
        lea ecx, [byte eax-01h]
        mov dword [dword esp+010Ch], ecx
        test eax, eax
        je short .19
        mov edx, 30h
        lea eax, [dword esp+0100h]
        call dword [dword esp+011Ch]
        jmp short .18
.19:
        mov al, byte [dword esp+0114h]
        and al, 8
        and eax, 0FFh
        jne short .21
        mov al, byte [dword esp+0116h]
        cmp eax, byte 20h
        je short .21
.20:
        mov eax, dword [dword esp+0104h]
        dec eax
        mov dword [dword esp+0104h], eax
        test eax, eax
        jl short .21
        xor edx, edx
        lea eax, [dword esp+0100h]
        mov dl, byte [dword esp+0116h]
        call dword [dword esp+011Ch]
        jmp short .20
.21:
        xor eax, eax
        mov al, byte [dword esp+0115h]
        cmp eax, byte 73h
        je short .22
        cmp eax, byte 53h
        jne short .25
.22:
        mov al, byte [dword esp+0114h]
        and al, 20h
        and eax, 0FFh
        je short .24
.23:
        mov eax, dword [dword esp+0108h]
        lea ecx, [byte eax-01h]
        mov dword [dword esp+0108h], ecx
        test eax, eax
        je near .26
        xor edx, edx
        lea eax, [dword esp+0100h]
        mov dl, byte [es:ebx]
        call dword [dword esp+011Ch]
        add ebx, byte 2
        jmp short .23
.24:
        mov eax, dword [dword esp+0108h]
        lea edx, [byte eax-01h]
        mov dword [dword esp+0108h], edx
        test eax, eax
        je short .26
        xor edx, edx
        lea eax, [dword esp+0100h]
        mov dl, byte [es:ebx]
        call dword [dword esp+011Ch]
        inc ebx
        jmp short .24
.25:
        mov eax, dword [dword esp+0108h]
        lea ecx, [byte eax-01h]
        mov dword [dword esp+0108h], ecx
        test eax, eax
        je short .26
        xor edx, edx
        lea eax, [dword esp+0100h]
        mov dl, byte [es:ebx]
        call dword [dword esp+011Ch]
        inc ebx
        jmp short .25
.26:
        mov al, byte [dword esp+0114h]
        and al, 8
        and eax, 0FFh
        je near .5
        cmp dword [dword esp+0104h], byte 0
        jle near .5
.27:
        mov eax, dword [dword esp+0104h]
        lea edx, [byte eax-01h]
        mov dword [dword esp+0104h], edx
        test eax, eax
        je near .5
        mov edx, 20h
        lea eax, [dword esp+0100h]
        call dword [dword esp+011Ch]
        jmp short .27
.28:
        mov eax, dword [dword esp+0110h]
        add esp, 124h
        pop ebp
        pop es
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; getprintspecs_                                               124389  library
; Run-time library: reads one printf format specification
;-----------------------------------------------------------------------------
getprintspecs_:
        push ecx
        push esi
        push edi
        mov esi, edx
        mov byte [byte ebx+017h], 0
        mov edx, ebx
        mov byte [byte ebx+016h], 20h
        call evalflags_
        mov dword [byte ebx+04h], 0
        mov dl, byte [eax]
        and edx, 0FFh
        cmp edx, byte 30h
        jl short .2
        cmp edx, byte 39h
        jg short .2
.1:
        imul ecx, dword [byte ebx+04h], byte 0Ah
        xor edx, edx
        mov dl, byte [eax]
        sub edx, byte 30h
        inc eax
        add ecx, edx
        xor edx, edx
        mov dword [byte ebx+04h], ecx
        mov dl, byte [eax]
        cmp edx, byte 30h
        jl short .4
        cmp edx, byte 39h
        jle short .1
        jmp short .4
.2:
        xor edx, edx
        mov dl, byte [eax]
        cmp edx, byte 2Ah
        jne short .4
        mov edx, dword [esi]
        add edx, byte 4
        mov dword [esi], edx
        mov edx, dword [byte edx-04h]
        mov dword [byte ebx+04h], edx
        test edx, edx
        jge short .3
        mov edi, edx
        mov dl, byte [byte ebx+014h]
        neg edi
        or dl, 8
        mov dword [byte ebx+04h], edi
        mov byte [byte ebx+014h], dl
.3:
        inc eax
.4:
        mov dword [byte ebx+08h], 0FFFFFFFFh
        xor edx, edx
        mov dl, byte [eax]
        cmp edx, byte 2Eh
        jne short .7
        inc eax
        mov dword [byte ebx+08h], 0
        xor edx, edx
        mov dl, byte [eax]
        cmp edx, byte 2Ah
        jne short .6
        mov edx, dword [esi]
        add edx, byte 4
        mov dword [esi], edx
        mov edx, dword [byte edx-04h]
        mov dword [byte ebx+08h], edx
        test edx, edx
        jge short .5
        mov dword [byte ebx+08h], 0FFFFFFFFh
.5:
        inc eax
        jmp short .7
.6:
        xor edx, edx
        mov dl, byte [eax]
        cmp edx, byte 30h
        jl short .7
        cmp edx, byte 39h
        jg short .7
        imul ecx, dword [byte ebx+08h], byte 0Ah
        sub edx, byte 30h
        add ecx, edx
        inc eax
        mov dword [byte ebx+08h], ecx
        jmp short .6
.7:
        mov dl, byte [eax]
        lea ecx, [byte eax+01h]
        cmp dl, 4Eh
        jb short .9
        jbe short .15
        cmp dl, 6Ch
        jb short .8
        jbe short .10
        cmp dl, 77h
        je short .10
        pop edi
        pop esi
        pop ecx
        ret
.8:
        cmp dl, 68h
        je short .12
        pop edi
        pop esi
        pop ecx
        ret
.9:
        cmp dl, 46h
        jb short .17
        jbe short .14
        cmp dl, 4Ch
        je short .13
        pop edi
        pop esi
        pop ecx
        ret
.10:
        mov dh, byte [byte ebx+014h]
        or dh, 20h
        inc eax
.11:
        mov byte [byte ebx+014h], dh
        pop edi
        pop esi
        pop ecx
        ret
.12:
        or byte [byte ebx+014h], 10h
        jmp short .16
.13:
        mov dl, byte [byte ebx+014h]
        or dl, 40h
        mov eax, ecx
        mov byte [byte ebx+014h], dl
        pop edi
        pop esi
        pop ecx
        ret
.14:
        mov dh, byte [byte ebx+014h]
        or dh, 80h
        mov eax, ecx
        jmp short .11
.15:
        or byte [byte ebx+014h], 40h
.16:
        mov eax, ecx
.17:
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; evalflags_                                                   1244C7  library
; Run-time library: reads the flags of a printf specification
;-----------------------------------------------------------------------------
evalflags_:
        push ebx
        push ecx
        mov ebx, eax
        mov byte [byte edx+014h], 0
.1:
        xor eax, eax
        mov al, byte [ebx]
        cmp eax, byte 2Dh
        jne short .2
        or byte [byte edx+014h], 8
        jmp short .6
.2:
        cmp eax, byte 23h
        jne short .3
        or byte [byte edx+014h], 1
        jmp short .6
.3:
        cmp eax, byte 2Bh
        jne short .4
        mov cl, byte [byte edx+014h]
        or cl, 4
        mov ch, cl
        and ch, 0FDh
        mov byte [byte edx+014h], ch
        jmp short .6
.4:
        cmp eax, byte 20h
        jne short .5
        mov al, byte [byte edx+014h]
        and al, 4
        and eax, 0FFh
        jne short .6
        or byte [byte edx+014h], 2
        jmp short .6
.5:
        cmp eax, byte 30h
        jne short .7
        mov byte [byte edx+016h], 30h
.6:
        inc ebx
        jmp short .1
.7:
        mov eax, ebx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; far_strlen_                                                  124526  library
; Run-time library: length of a far string (printf)
;-----------------------------------------------------------------------------
far_strlen_:
        push ecx
        push esi
        push edi
        push es
        mov ecx, edx
        mov edi, ebx
        mov edx, eax
        mov es, ecx
        xor eax, eax
.1:
        mov esi, edx
        mov bl, byte [es:esi]
        inc edx
        test bl, bl
        je short far_strlen__1F
        cmp eax, edi
        je short far_strlen__1F
        inc eax
        jmp short .1
far_strlen__1F:
        pop es
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; far_other_strlen_                                            12454A  library
; Run-time library: length of a far wide string (printf)
;-----------------------------------------------------------------------------
far_other_strlen_:
        push ecx
        push esi
        push edi
        push es
        mov ecx, eax
        mov esi, ebx
        mov ebx, ecx
        mov es, edx
        xor eax, eax
.1:
        mov ecx, ebx
        db 066h,026h,08Bh,039h                  ; insn: mov di,[es:ecx]
        add ebx, byte 2
        test di, di
        je short far_strlen__1F
        cmp eax, esi
        je short far_strlen__1F
        inc eax
        jmp short .1
;-----------------------------------------------------------------------------
; fmt4hex_                                                     12456D  library
; Run-time library: formats a value as four hex digits
;-----------------------------------------------------------------------------
fmt4hex_:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebp, edx
        mov dword [esp], ebx
        mov ebx, 10h
        mov edi, ebp
        call itoa_
        push es
        mov eax, ds
        mov es, eax
        sub ecx, ecx
        dec ecx
        xor eax, eax
        repne scasb
        not ecx
        dec ecx
        pop es
        mov eax, dword [esp]
        mov esi, ebp
        dec eax
        lea edx, [ecx+ebp]
        lea ebx, [eax+ebp]
        jmp short .2
.1:
        dec edx
        mov cl, byte [edx]
        dec eax
        mov byte [ebx], cl
        dec ebx
.2:
        cmp edx, esi
        jne short .1
        lea edx, [eax+ebp]
.3:
        test eax, eax
        jl short .4
        dec eax
        mov byte [edx], 30h
        dec edx
        jmp short .3
.4:
        add ebp, dword [esp]
        mov byte [byte ebp+00h], 0
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; FixedPoint_Format_                                           1245CB  library
; Run-time library: formats a fixed point value
;-----------------------------------------------------------------------------
FixedPoint_Format_:
        push ecx
        push esi
        push edi
        sub esp, byte 4
        mov ecx, eax
        mov esi, ebx
        mov dword [esp], edx
        test edx, edx
        jge short .1
        neg edx
        lea ecx, [byte eax+01h]
        mov byte [eax], 2Dh
        mov dword [esp], edx
.1:
        cmp dword [byte esi+08h], byte 0FFFFFFFFh
        jne short .2
        mov dword [byte esi+08h], 4
.2:
        mov ebx, 0Ah
        xor eax, eax
        mov edx, ecx
        mov ax, word [byte esp+02h]
        call itoa_
        mov ebx, ecx
.3:
        mov ah, byte [ecx]
        lea edx, [byte ecx+01h]
        test ah, ah
        je short .4
        mov ecx, edx
        jmp short .3
.4:
        cmp dword [byte esi+08h], byte 0
        je short .7
        mov byte [ecx], 2Eh
        xor eax, eax
        mov ecx, edx
        jmp short .6
.5:
        xor edx, edx
        mov word [byte esp+02h], dx
        mov edi, dword [esp]
        imul edx, edi, byte 0Ah
        mov dword [esp], edx
        mov dl, byte [byte esp+02h]
        add dl, 30h
        inc eax
        mov byte [ecx], dl
        inc ecx
.6:
        cmp eax, dword [byte esi+08h]
        jl short .5
        mov byte [ecx], 0
.7:
        mov eax, dword [esp]
        xor al, al
        and ah, 80h
        and eax, 0FFFFh
        je near .16
.8:
        cmp ecx, ebx
        jne short .13
        lea ecx, [byte ebx+01h]
        mov byte [ebx], 31h
.9:
        xor edx, edx
        mov dl, byte [ecx]
        lea eax, [byte ecx+01h]
        cmp edx, byte 30h
        jne short .10
        mov ecx, eax
        jmp short .9
.10:
        cmp edx, byte 2Eh
        jne short .12
        mov byte [ecx], 30h
        lea ecx, [byte eax+01h]
        mov byte [eax], 2Eh
.11:
        xor eax, eax
        mov al, byte [ecx]
        cmp eax, byte 30h
        jne short .12
        inc ecx
        jmp short .11
.12:
        mov byte [ecx], 30h
        inc ecx
        mov byte [ecx], 0
        jmp short .16
.13:
        dec ecx
        xor eax, eax
        mov al, byte [ecx]
        cmp eax, byte 2Eh
        jne short .14
        dec ecx
.14:
        xor eax, eax
        mov al, byte [ecx]
        cmp eax, byte 39h
        je short .15
        mov dl, al
        inc dl
        mov byte [ecx], dl
        jmp short .16
.15:
        mov byte [ecx], 30h
        jmp short .8
.16:
        add esp, byte 4
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; float_format_                                                1246C0  library
; Run-time library: formats a float for printf
;-----------------------------------------------------------------------------
float_format_:
        call dword [__EFG_printf]
        ret
;-----------------------------------------------------------------------------
; formstring_                                                  1246C7  library
; Run-time library: formats an integer into its digits for printf
;-----------------------------------------------------------------------------
formstring_:
        push esi
        push edi
        push es
        push ebp
        sub esp, byte 0Ch
        mov edi, eax
        mov esi, ebx
        mov dword [byte esp+04h], ecx
        mov eax, edx
        mov dword [esp], 1
        mov edx, ds
        mov ecx, edi
        mov es, edx
        mov dl, byte [byte ebx+015h]
        mov dword [byte ebx+0Ch], 0
        cmp dl, 69h
        jb short .3
        jbe near .8
        cmp dl, 75h
        jb short .2
        jbe short .4
        cmp dl, 78h
.1:
        je short .4
        jmp near .9
.2:
        cmp dl, 6Fh
        jmp short .1
.3:
        cmp dl, 58h
        jb short .9
        jbe short .4
        cmp dl, 64h
        je short .8
        jmp short .9
.4:
        mov dl, byte [byte esi+014h]
        and dl, 20h
        and edx, 0FFh
        je short .5
        mov edx, dword [eax]
        add edx, byte 4
        mov dword [eax], edx
        mov ebp, dword [byte edx-04h]
        jmp short .7
.5:
        mov dl, byte [byte esi+014h]
        and dl, 10h
        and edx, 0FFh
        je short .6
        mov ebp, dword [eax]
        add ebp, byte 4
        mov dword [eax], ebp
        movzx ebp, word [byte ebp-04h]
        jmp short .7
.6:
        mov ebx, dword [eax]
        add ebx, byte 4
        mov dword [eax], ebx
        mov ebp, dword [byte ebx-04h]
.7:
        and byte [byte esi+014h], 0F9h
.8:
        cmp dword [byte esi+08h], byte 0FFFFFFFFh
        je short .9
        mov byte [byte esi+016h], 20h
.9:
        mov dl, byte [byte esi+015h]
        mov ebx, 0Ah
        cmp dl, 65h
        jb short .12
        jbe near .18
        cmp dl, 6Fh
        jb short .11
        jbe near .19
        cmp dl, 73h
        jb short .10
        jbe near .28
        cmp dl, 75h
        jb near .48
        jbe near .41
        cmp dl, 78h
        je near .39
        jmp near .48
.10:
        cmp dl, 70h
        je near .42
        jmp near .48
.11:
        cmp dl, 67h
        jb short .17
        jbe near .18
        cmp dl, 69h
        je near .24
        jmp near .48
.12:
        cmp dl, 50h
        jb short .14
        jbe near .42
        cmp dl, 58h
        jb short .13
        jbe near .39
        cmp dl, 63h
        jb near .48
        jbe near .47
        jmp near .24
.13:
        cmp dl, 53h
        je near .28
        jmp near .48
.14:
        cmp dl, 46h
        jb short .16
        jbe short .17
        cmp dl, 47h
.15:
        je short .18
        jmp near .48
.16:
        cmp dl, 45h
        jmp short .15
.17:
        mov dl, byte [byte esi+014h]
        and dl, 10h
        and edx, 0FFh
        je short .18
        mov ebx, dword [eax]
        add ebx, byte 4
        mov dword [eax], ebx
        mov eax, edi
        mov edx, dword [byte ebx-04h]
        mov ebx, esi
        call FixedPoint_Format_
        mov ebx, 0FFFFFFFFh
        mov eax, ds
        mov edx, ds
        mov es, eax
        mov eax, edi
        mov ecx, edi
        jmp short .23
.18:
        mov ebx, esi
        mov edx, eax
        mov eax, edi
        call float_format_
        mov ebx, 0FFFFFFFFh
        mov es, edx
        mov ecx, eax
        jmp short .23
.19:
        mov al, byte [byte esi+014h]
        mov ebx, 8
        and al, 1
        and eax, 0FFh
        je short .20
        mov byte [edi], 30h
        inc edi
.20:
        mov edx, edi
        mov eax, ebp
        call ltoa_
.21:
        cmp dword [byte esi+08h], byte 0
        jne short .22
        xor eax, eax
        mov al, byte [edi]
        cmp eax, byte 30h
        jne short .22
        mov byte [es:ecx], 0
.22:
        mov ebx, 0FFFFFFFFh
        mov edx, es
        mov eax, ecx
.23:
        call far_strlen_
        jmp near .49
.24:
        mov dl, byte [byte esi+014h]
        and dl, 20h
        and edx, 0FFh
        je short .26
        mov edx, dword [eax]
        add edx, byte 4
        mov dword [eax], edx
        mov eax, dword [byte edx-04h]
        mov edx, edi
.25:
        call ltoa_
        jmp short .21
.26:
        mov dl, byte [byte esi+014h]
        and dl, 10h
        and edx, 0FFh
        je short .27
        mov ebp, dword [eax]
        add ebp, byte 4
        mov dword [eax], ebp
        mov edx, edi
        movsx eax, word [byte ebp-04h]
        jmp short .25
.27:
        mov edx, dword [eax]
        add edx, byte 4
        mov dword [eax], edx
        mov eax, dword [byte edx-04h]
        mov edx, edi
        call itoa_
        jmp short .21
.28:
        mov dl, byte [byte esi+014h]
        and dl, 80h
        and edx, 0FFh
        je short .31
        mov edi, dword [eax]
        add edi, byte 8
        mov dword [eax], edi
        mov ecx, dword [byte edi-08h]
        mov dx, word [byte edi-04h]
        test ecx, ecx
        jne short .29
        test dx, dx
        je short .30
.29:
        mov es, edx
        jmp short .35
.30:
        mov eax, ds
        mov ecx, dword [byte esp+04h]
        jmp short .34
.31:
        mov dl, byte [byte esi+014h]
        and dl, 40h
        and edx, 0FFh
        je short .33
        mov ecx, dword [eax]
        add ecx, byte 4
        mov dword [eax], ecx
        mov ecx, dword [byte ecx-04h]
        test ecx, ecx
        je short .30
.32:
        mov eax, ds
        jmp short .34
.33:
        mov ebx, dword [eax]
        add ebx, byte 4
        mov dword [eax], ebx
        mov ecx, dword [byte ebx-04h]
        test ecx, ecx
        jne short .32
        mov eax, ds
        mov ecx, dword [byte esp+04h]
.34:
        mov es, eax
.35:
        mov bl, byte [byte esi+014h]
        xor ebp, ebp
        xor eax, eax
        and bl, 0F9h
        mov dword [esp], ebp
        mov al, byte [byte esi+015h]
        mov byte [byte esi+014h], bl
        cmp eax, byte 53h
        jne short .37
        mov al, bl
        and al, 20h
        and eax, 0FFh
        je short .36
        xor eax, eax
        db 066h,026h,08Bh,01h                   ; insn: mov ax,[es:ecx]
        add ecx, byte 2
        jmp near .49
.36:
        mov al, byte [es:ecx]
        inc ecx
        jmp near .49
.37:
        mov al, bl
        and al, 20h
        and eax, 0FFh
        je short .38
        mov edx, es
        mov eax, ecx
        mov ebx, dword [byte esi+08h]
        call far_other_strlen_
        jmp near .49
.38:
        mov edx, es
        mov eax, ecx
        mov ebx, dword [byte esi+08h]
        jmp near .23
.39:
        mov al, byte [byte esi+014h]
        and al, 1
        and eax, 0FFh
        je short .40
        test ebp, ebp
        je short .40
        mov byte [byte esi+017h], 30h
        mov al, byte [byte esi+015h]
        mov byte [byte esi+019h], 0
        mov byte [byte esi+018h], al
.40:
        mov ebx, 10h
.41:
        mov edx, edi
        mov eax, ebp
        call ultoa_
        xor eax, eax
        mov al, byte [byte esi+015h]
        cmp eax, byte 58h
        jne near .21
        mov eax, edi
        call zupstr_
        jmp near .21
.42:
        cmp dword [byte esi+04h], byte 0
        jne short .44
        mov dl, byte [byte esi+014h]
        and dl, 80h
        and edx, 0FFh
        je short .43
        mov dword [byte esi+04h], 0Dh
        jmp short .44
.43:
        mov dword [byte esi+04h], 8
.44:
        and byte [byte esi+014h], 0F9h
        mov ebx, dword [eax]
        add ebx, byte 4
        mov dword [eax], ebx
        mov dl, byte [byte esi+014h]
        and dl, 80h
        mov byte [byte esp+08h], dl
        xor edx, edx
        mov dl, byte [byte esp+08h]
        mov ebp, dword [byte ebx-04h]
        test edx, edx
        je short .45
        add ebx, byte 4
        mov dword [eax], ebx
        mov edx, edi
        mov eax, dword [byte ebx-04h]
        mov ebx, 4
        and eax, 0FFFFh
        call fmt4hex_
        mov ebx, 8
        lea edx, [byte edi+05h]
        mov eax, ebp
        mov byte [byte edi+04h], 3Ah
        jmp short .46
.45:
        mov ebx, 8
        mov edx, edi
        mov eax, ebp
.46:
        call fmt4hex_
        xor eax, eax
        mov al, byte [byte esi+015h]
        cmp eax, byte 50h
        jne near .22
        mov eax, edi
        call zupstr_
        jmp near .22
.47:
        mov ebp, dword [eax]
        add ebp, byte 4
        mov dword [eax], ebp
        mov al, byte [byte ebp-04h]
        mov byte [byte edi+01h], 0
        mov byte [edi], al
        mov dword [byte esi+08h], 1
        mov dh, byte [byte esi+014h]
        xor eax, eax
        and dh, 0F9h
        mov dword [esp], eax
        mov eax, 1
        mov byte [byte esi+014h], dh
        jmp short .49
.48:
        mov dword [byte esi+04h], 0
        mov al, byte [byte esi+015h]
        mov byte [byte edi+01h], 0
        mov byte [edi], al
        mov dword [byte esi+08h], 1
        mov al, byte [byte esi+014h]
        xor edi, edi
        and al, 0F9h
        mov dword [esp], edi
        mov byte [byte esi+014h], al
        mov eax, 1
.49:
        cmp dword [esp], byte 0
        je short .55
        xor edx, edx
        mov dl, byte [es:ecx]
        cmp edx, byte 2Dh
        jne short .50
        inc ecx
        mov byte [byte esi+017h], 2Dh
        dec eax
        jmp short .52
.50:
        mov dl, byte [byte esi+014h]
        and dl, 2
        and edx, 0FFh
        je short .51
        mov byte [byte esi+017h], 20h
        jmp short .52
.51:
        mov dl, byte [byte esi+014h]
        and dl, 4
        and edx, 0FFh
        je short .53
        mov byte [byte esi+017h], 2Bh
.52:
        mov byte [byte esi+018h], 0
.53:
        mov edx, dword [byte esi+08h]
        cmp eax, edx
        jle short .54
        mov dword [byte esi+08h], eax
        jmp short .55
.54:
        mov ebx, edx
        sub ebx, eax
        mov dword [byte esi+0Ch], ebx
.55:
        xor edx, edx
        mov dl, byte [byte esi+016h]
        cmp edx, byte 2Ah
        jne short .56
        mov dl, byte [byte esi+014h]
        mov byte [byte esi+017h], 0
        and dl, 0F9h
        mov byte [byte esi+014h], dl
.56:
        mov ebx, dword [byte esi+08h]
        cmp ebx, byte 0FFFFFFFFh
        je short .57
        cmp eax, ebx
        jge short .58
.57:
        xor edx, edx
        mov dl, byte [byte esi+015h]
        cmp edx, byte 63h
        je short .58
        mov dword [byte esi+08h], eax
.58:
        mov ebx, 0FFFFFFFFh
        lea eax, [byte esi+017h]
        mov edx, ds
        call far_strlen_
        mov ebp, dword [byte esi+08h]
        mov edx, dword [byte esi+0Ch]
        add eax, ebp
        mov ebx, dword [byte esi+04h]
        add eax, edx
        mov edx, es
        sub ebx, eax
        mov eax, ecx
        mov dword [byte esi+04h], ebx
        add esp, byte 0Ch
        pop ebp
        pop es
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; zupstr_                                                      124BB0  library
; Run-time library: makes a string upper case (printf %X)
;-----------------------------------------------------------------------------
zupstr_:
        push edx
        mov edx, eax
.1:
        cmp byte [edx], 0
        je short .2
        xor eax, eax
        mov al, byte [edx]
        call toupper_
        mov byte [edx], al
        inc edx
        jmp short .1
.2:
        pop edx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h
zupstr__20:
        push esi
        push edi
        push ebp
        mov ebx, dword [AtexitCount]
        cmp eax, ebx
        jg short .3
        mov ebx, eax
.3:
        mov ecx, dword [TextLimitWidth]
        mov dword [AtexitCount], ebx
        cmp edx, ecx
        jle short .4
        mov ebx, ecx
        jmp short .5
.4:
        mov ebx, edx
.5:
        mov esi, dword [byte esp+014h]
        mov edi, dword [TextLimitPtr]
        add eax, esi
        mov dword [TextLimitWidth], ebx
        cmp eax, edi
        jge short .6
        mov eax, edi
.6:
        mov ebp, dword [byte esp+018h]
        mov dword [TextLimitPtr], eax
        mov eax, dword [TextLimitCount]
        add edx, ebp
        cmp edx, eax
        jge short .7
        mov edx, eax
.7:
        mov dword [TextLimitCount], edx
        pop ebp
        pop edi
        pop esi
        ret 10h
