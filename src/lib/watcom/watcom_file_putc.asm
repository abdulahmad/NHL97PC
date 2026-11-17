; Watcom C runtime: file_putc_, __fprtf_, __doserror_.
bits 32
%include "hockey.inc"
section s_12D24F progbits alloc exec nowrite align=1
extern __flush_, __ioalloc_, __prtf_, __set_errno_dos_, fputc_
global file_putc_, __fprtf_, __doserror_
;-----------------------------------------------------------------------------
; file_putc_                                                   12D24F  library
; Run-time library: writes one character to a stream (fprintf output)
;-----------------------------------------------------------------------------
file_putc_:
        push ebx
        mov ebx, eax
        mov eax, edx
        mov edx, dword [ebx]
        call fputc_
        inc dword [byte ebx+010h]
        pop ebx
        ret
;-----------------------------------------------------------------------------
; __fprtf_                                                     12D260  library
; Run-time library: the fprintf engine
;-----------------------------------------------------------------------------
__fprtf_:
        push ecx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov ebp, dword [byte eax+0Ch]
        mov ah, byte [byte eax+0Ch]
        mov ecx, dword [byte esi+08h]
        and ah, 0CFh
        and ebp, byte 30h
        mov byte [byte esi+0Ch], ah
        test ecx, ecx
        jne short .1
        mov eax, esi
        call __ioalloc_
.1:
        mov cl, byte [byte esi+0Dh]
        xor edi, edi
        test cl, 4
        je short .2
        mov ch, cl
        and ch, 0FAh
        mov al, ch
        or al, 1
        mov edi, 1
        mov byte [byte esi+0Dh], al
.2:
        mov ecx, file_putc_
        mov eax, esi
        call __prtf_
        mov edx, eax
        test edi, edi
        je short .3
        mov ah, byte [byte esi+0Dh]
        and ah, 0FAh
        mov bl, ah
        or bl, 4
        mov eax, esi
        mov byte [byte esi+0Dh], bl
        call __flush_
.3:
        test byte [byte esi+0Ch], 20h
        je short .4
        mov edx, 0FFFFFFFFh
.4:
        mov edi, dword [byte esi+0Ch]
        or edi, ebp
        mov eax, edx
        mov dword [byte esi+0Ch], edi
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 00h
;-----------------------------------------------------------------------------
; __doserror_                                                  12D2E0  library
; Run-time library: sets errno from a DOS error
;-----------------------------------------------------------------------------
__doserror_:
        jae short .1
        and eax, 0FFFFh
        push eax
        call __set_errno_dos_
        pop eax
        jmp short .2
.1:
        sub eax, eax
.2:
        ret
