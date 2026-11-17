; Watcom C runtime: Random32, SeedRandom.
bits 32
%include "hockey.inc"
section s_102C2D progbits alloc exec nowrite align=1
extern RandIndex, RandomState
global Random32, SeedRandom
        db 00h,00h,00h
;-----------------------------------------------------------------------------
; Random32                                    102C30  97 PC, medium confidence
; Returns a pseudo-random dword (multi-word add-with-carry generator,
; RandomState-790)
;-----------------------------------------------------------------------------
Random32:
        mov eax, dword [RandIndex]
        add eax, dword [RandomState+10h]
        mov dword [RandomState+10h], eax
        adc eax, dword [RandomState+0Ch]
        mov dword [RandomState+0Ch], eax
        adc eax, dword [RandomState+8]
        mov dword [RandomState+8], eax
        adc eax, dword [RandomState+4]
        mov dword [RandomState+4], eax
        adc eax, dword [RandomState]
        inc dword [RandIndex]
        jne short .1
        inc dword [RandomState+10h]
        jne short .1
        inc dword [RandomState+0Ch]
        jne short .1
        inc dword [RandomState+8]
        jne short .1
        inc dword [RandomState+4]
        db 075h, .1-($+2)
        db 040h                                 ; insn: inc eax
.1:
        mov dword [RandomState], eax
        ret
;-----------------------------------------------------------------------------
; SeedRandom                                     102C96  97 PC, low confidence
; Seeds the random generator state from a value
;-----------------------------------------------------------------------------
SeedRandom:
        push ebp
        LD mov, ebp, esp
        mov eax, dword [byte ebp+08h]
        add eax, 0F22D0E56h
        mov dword [RandomState], eax
        add eax, 96041893h
        mov dword [RandomState+4], eax
        add eax, 3DF3B646h
        mov dword [RandomState+8], eax
        add eax, 40DDE76Dh
        mov dword [RandomState+0Ch], eax
        add eax, 97327AE1h
        mov dword [RandomState+10h], eax
        add eax, 0D1A9FBE7h
        mov dword [RandIndex], eax
        leave
        ret
