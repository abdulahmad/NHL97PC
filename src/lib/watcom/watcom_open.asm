; Watcom C runtime: open_, sopen_, __set_binary_, close_.
bits 32
%include "hockey.inc"
section s_119C8D progbits alloc exec nowrite align=1
extern __close_, __IOMode_, __NHandles, __set_errno_, __set_errno_dos_, __SetIOMode_, _fmode, _umaskval
extern isatty_
global open_, sopen_, __set_binary_, close_
;-----------------------------------------------------------------------------
; open_                                                        119C8D  library
; Run-time library open: opens a file
;-----------------------------------------------------------------------------
open_:
        push ebx
        push edx
        lea eax, [byte esp+014h]
        add eax, byte 4
        mov eax, dword [byte eax-04h]
        push eax
        push byte 0
        mov edx, dword [byte esp+018h]
        push edx
        mov ebx, dword [byte esp+018h]
        push ebx
        call sopen_
        add esp, byte 10h
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; sopen_                                                       119CB1  library
; Run-time library sopen: opens a file with a share mode
;-----------------------------------------------------------------------------
sopen_:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov esi, dword [byte esp+024h]
.1:
        movzx edi, byte [esi]
        cmp edi, byte 20h
        jne short .2
        inc esi
        jmp short .1
.2:
        mov eax, dword [byte esp+028h]
        and eax, 83h
        mov dword [byte esp+04h], eax
        mov al, byte [byte esp+04h]
        mov ah, byte [byte esp+02Ch]
        mov edx, esi
        or al, ah
        mov edi, 0FFFFFFFFh
        mov ah, 3Dh
        int 21h
        rcl eax, 1
        ror eax, 1
        mov dword [esp], eax
        test eax, eax
        jl short .3
        xor edi, edi
        mov di, word [esp]
.3:
        mov dl, byte [byte esp+028h]
        test dl, 3
        je near .6
        cmp edi, byte 0FFFFFFFFh
        je near .6
        mov eax, edi
        call isatty_
        test eax, eax
        jne short .6
        test byte [byte esp+029h], 4
        je short .4
        test dl, 20h
        je short .4
        mov ebx, edi
        mov ah, 3Eh
        int 21h
        rcl eax, 1
        ror eax, 1
        mov eax, 7
        call __set_errno_
        mov eax, 0FFFFFFFFh
        jmp near .18
.4:
        test byte [byte esp+028h], 40h
        je short .6
        lea edx, [byte esp+08h]
        mov ebx, edi
        xor ecx, ecx
        mov ah, 40h
        int 21h
        rcl eax, 1
        ror eax, 1
        mov dword [esp], eax
        test eax, eax
        jge short .6
        mov ebx, edi
        mov ah, 3Eh
        int 21h
        rcl eax, 1
        ror eax, 1
.5:
        xor eax, eax
        mov ax, word [esp]
        call __set_errno_dos_
        jmp near .18
.6:
        cmp edi, byte 0FFFFFFFFh
        jne near .9
        test byte [byte esp+028h], 20h
        je short .5
        xor eax, eax
        mov ax, word [esp]
        cmp eax, byte 2
        jne short .5
        lea eax, [byte esp+030h]
        add eax, byte 4
        mov eax, dword [byte eax-04h]
        test eax, eax
        jne short .7
        mov eax, 180h
.7:
        mov edx, dword [_umaskval]
        not edx
        and eax, edx
        xor ecx, ecx
        test al, 80h
        jne short .8
        mov ecx, 1
.8:
        and ecx, 0FFh
        mov edx, esi
        mov ah, 3Ch
        int 21h
        rcl eax, 1
        ror eax, 1
        mov dword [esp], eax
        test eax, eax
        jl short .5
        xor edi, edi
        mov edx, dword [byte esp+02Ch]
        mov di, word [esp]
        test edx, edx
        je short .9
        mov ebx, edi
        mov ah, 3Eh
        int 21h
        rcl eax, 1
        ror eax, 1
        mov dword [esp], eax
        test eax, eax
        jl near .5
        mov al, byte [byte esp+04h]
        mov ch, byte [byte esp+02Ch]
        mov edx, esi
        or al, ch
        mov ah, 3Dh
        int 21h
        rcl eax, 1
        ror eax, 1
        mov dword [esp], eax
        test eax, eax
        jl near .5
        xor edi, edi
        mov di, word [esp]
.9:
        mov eax, edi
        call __IOMode_
        and al, 3Ch
        mov edx, eax
        mov eax, edi
        call isatty_
        test eax, eax
        je short .10
        or dh, 20h
.10:
        and byte [byte esp+04h], 7Fh
        cmp dword [byte esp+04h], byte 2
        jne short .11
        or dl, 3
.11:
        cmp dword [byte esp+04h], byte 0
        jne short .12
        or dl, 1
.12:
        cmp dword [byte esp+04h], byte 1
        jne short .13
        or dl, 2
.13:
        test byte [byte esp+028h], 10h
        je short .14
        or dl, 80h
.14:
        mov eax, edx
        mov bl, byte [byte esp+029h]
        or al, 40h
        test bl, 3
        je short .15
        test bl, 2
        je short .17
        jmp short .16
.15:
        cmp dword [_fmode], 200h
        jne short .17
.16:
        mov edx, eax
.17:
        mov eax, edi
        call __SetIOMode_
        mov eax, edi
.18:
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; __set_binary_                                                119E9A  library
; Run-time library: puts a file handle in binary mode
;-----------------------------------------------------------------------------
__set_binary_:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 4
        mov esi, eax
        call __IOMode_
        or al, 40h
        mov ebx, eax
        mov edx, eax
        mov eax, esi
        call __SetIOMode_
        test bh, 20h
        je short .3
        mov ebx, esi
        mov al, 0
        mov ah, 44h
        int 21h
        rcl edx, 1
        ror edx, 1
        mov dword [esp], edx
        test edx, edx
        jge short .2
.1:
        xor eax, eax
        mov ax, word [esp]
        call __set_errno_dos_
        jmp short .4
.2:
        mov dl, byte [esp]
        mov ebx, esi
        or dl, 20h
        mov dh, 0
        mov al, 1
        mov ah, 44h
        int 21h
        rcl edx, 1
        ror edx, 1
        mov dword [esp], edx
        test edx, edx
        jl short .1
.3:
        xor eax, eax
.4:
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; close_                                                       119EFF  library
; Run-time library close: closes a file handle
;-----------------------------------------------------------------------------
close_:
        test eax, eax
        jl short .1
        cmp eax, dword [__NHandles]
        jbe near __close_
.1:
        mov eax, 4
        call __set_errno_
        mov eax, 0FFFFFFFFh
        ret
