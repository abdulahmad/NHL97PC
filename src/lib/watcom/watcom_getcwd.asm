; Watcom C runtime: getcwd_, _dos_getdiskfree_.
bits 32
%include "hockey.inc"
section s_11A13F progbits alloc exec nowrite align=1
extern __set_EINVAL_, __set_errno_, _nmalloc_, bcopy, strncpy_
global getcwd_, _dos_getdiskfree_, _dos_getdiskfree__38
;-----------------------------------------------------------------------------
; getcwd_                                                      11A13F  library
; Run-time library getcwd: the current directory
;-----------------------------------------------------------------------------
getcwd_:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 90h
        mov ebp, eax
        mov ebx, edx
        lea esi, [byte esp+03h]
        xor dl, dl
        mov ah, 47h
        int 21h
        rcl eax, 1
        ror eax, 1
        test eax, eax
        jge short .2
        mov eax, 1
.1:
        call __set_errno_
        xor eax, eax
        jmp short .5
.2:
        mov ah, 19h
        int 21h
        mov dl, 5Ch
        add al, 41h
        mov edi, esp
        mov byte [esp], al
        mov ah, 3Ah
        mov byte [byte esp+02h], dl
        mov byte [byte esp+01h], ah
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
        lea edx, [byte ecx+01h]
        test ebp, ebp
        jne short .4
        mov eax, edx
        call _nmalloc_
        mov ebp, eax
        test eax, eax
        jne short .3
        mov eax, 5
        jmp short .1
.3:
        mov ebx, edx
.4:
        mov edx, esp
        mov eax, ebp
        call strncpy_
.5:
        add esp, 90h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 00h
;-----------------------------------------------------------------------------
; _dos_getdiskfree_                                            11A1C8  library
; Run-time library _dos_getdiskfree: free space of a drive
;-----------------------------------------------------------------------------
_dos_getdiskfree_:
        push edi
        push ecx
        push ebx
        mov edi, edx
        mov edx, eax
        mov ah, 36h
        int 21h
        cmp ax, 0FFFFh
        je short .1
        mov word [edi], dx
        mov word [byte edi+02h], bx
        mov word [byte edi+04h], ax
        mov word [byte edi+06h], cx
        sub eax, eax
        jmp short .2
.1:
        call __set_EINVAL_
.2:
        pop ebx
        pop ecx
        pop edi
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
_dos_getdiskfree__38:
        push ecx
        sar ebx, 1
        push ebx
        push eax
        push edx
        call bcopy
        add esp, byte 0Ch
        pop ecx
        ret
