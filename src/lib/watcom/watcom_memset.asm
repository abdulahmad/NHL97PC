; Watcom C runtime: memset_.
bits 32
%include "hockey.inc"
section s_116A48 progbits alloc exec nowrite align=1
extern __STOSB
global memset_
        db 00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; memset_                                                      116A50  library
; Run-time library memset: fills a block of memory
;-----------------------------------------------------------------------------
memset_:
        push eax
        push ecx
        mov dh, dl
        shl edx, 8
        mov dl, dh
        shl edx, 8
        mov dl, dh
        mov ecx, ebx
        call __STOSB
        pop ecx
        pop eax
        ret
