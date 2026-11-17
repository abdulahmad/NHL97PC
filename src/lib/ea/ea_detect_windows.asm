; EA library: DetectWindows.
bits 32
%include "hockey.inc"
section s_107D25 progbits alloc exec nowrite align=1
extern int386_
global DetectWindows
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; DetectWindows                                  107D30  97 PC, low confidence
; Asks DOS whether Windows is running (int 2Fh 1600h)
;-----------------------------------------------------------------------------
DetectWindows:
        push ebx
        sub esp, byte 38h
        mov edx, 1600h
        lea ebx, [byte esp+01Ch]
        mov eax, 2Fh
        mov word [esp], dx
        mov edx, esp
        call int386_
        mov ah, byte [byte esp+01Ch]
        test ah, ah
        je short .1
        cmp ah, 80h
        jne short .2
.1:
        xor eax, eax
        add esp, byte 38h
        pop ebx
        ret
.2:
        xor eax, eax
        mov ax, word [byte esp+01Ch]
        add esp, byte 38h
        pop ebx
        ret
