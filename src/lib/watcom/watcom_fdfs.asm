; Watcom C runtime: __FDFS.
bits 32
%include "hockey.inc"
section s_138F81 progbits alloc exec nowrite align=1
global __FDFS
        db 00h
;-----------------------------------------------------------------------------
; __FDFS                                                       138F82  library
; Run-time library: converts a double to a float
;-----------------------------------------------------------------------------
__FDFS:
        push ebx
        test edx, 7FF00000h
        je short .2
        sub ebx, ebx
        add eax, eax
        adc edx, edx
        rcr ebx, 1
        add eax, 20000000h
        adc edx, byte 0
        je short .1
        cmp edx, 8FE00000h
        jae short .1
        cmp edx, 70200000h
        jb short .2
        sub edx, 70000000h
        add eax, eax
        adc edx, edx
        add eax, eax
        adc edx, edx
        db 09h,0DAh                             ; insn: or edx,ebx
        db 089h,0D0h                            ; insn: mov eax,edx
        pop ebx
        ret
.1:
        mov eax, 7F800000h
        or eax, ebx
        pop ebx
        ret
.2:
        sub eax, eax
        pop ebx
        ret
