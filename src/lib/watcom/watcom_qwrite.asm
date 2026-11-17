; Watcom C runtime: __qwrite_, unlink_.
bits 32
%include "hockey.inc"
section s_13086E progbits alloc exec nowrite align=1
extern __IOMode_, __set_errno_, __set_errno_dos_
global __qwrite_, unlink_
;-----------------------------------------------------------------------------
; __qwrite_                                                    13086E  library
; Run-time library: writes to a file handle
;-----------------------------------------------------------------------------
__qwrite_:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, eax
        mov ebp, edx
        mov edi, ebx
        call __IOMode_
        test al, 80h
        je short .2
        mov al, 2
        mov ebx, esi
        xor edx, edx
        mov ah, 42h
        mov ecx, edx
        shr ecx, 10h
        int 21h
        rcl dx, 1
        ror dx, 1
        shl edx, 10h
        mov dx, ax
        mov dword [esp], edx
        test edx, edx
        jge short .2
.1:
        xor eax, eax
        mov ax, word [esp]
        call __set_errno_dos_
        jmp short .4
.2:
        mov ecx, edi
        mov edx, ebp
        mov ebx, esi
        mov ah, 40h
        int 21h
        rcl eax, 1
        ror eax, 1
        mov dword [esp], eax
        mov edx, eax
        test eax, eax
        jl short .1
        cmp eax, edi
        je short .3
        mov eax, 0Ch
        call __set_errno_
.3:
        mov eax, edx
.4:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; unlink_                                                      1308E2  library
; Run-time library unlink: deletes a file
;-----------------------------------------------------------------------------
unlink_:
        push edx
        mov edx, eax
        mov ah, 41h
        int 21h
        rcl eax, 1
        ror eax, 1
        mov edx, eax
        test eax, eax
        jge short .1
        xor eax, eax
        mov ax, dx
        call __set_errno_dos_
        pop edx
        ret
.1:
        xor eax, eax
        pop edx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        push ebx
        push ecx
        test edx, edx
        je short .2
        mov ebx, edx
        cdq
        shld edx, eax, 10h
        shl eax, 10h
        idiv ebx
.2:
        pop ecx
        pop ebx
        ret
