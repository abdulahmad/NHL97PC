; Watcom C runtime: Random32, SeedRandom.
bits 32
%include "hockey.inc"
section s_102C2D progbits alloc exec nowrite align=1
extern RandIndex, RandState
global Random32, SeedRandom
        db 00h,00h,00h
;-----------------------------------------------------------------------------
; Random32                                    102C30  97 PC, medium confidence
; Returns a pseudo-random dword (multi-word add-with-carry generator,
; RandState-790)
;-----------------------------------------------------------------------------
Random32:
        mov eax, dword [RandIndex]
        add eax, dword [RandState+10h]
        mov dword [RandState+10h], eax
        adc eax, dword [RandState+0Ch]
        mov dword [RandState+0Ch], eax
        adc eax, dword [RandState+8]
        mov dword [RandState+8], eax
        adc eax, dword [RandState+4]
        mov dword [RandState+4], eax
        adc eax, dword [RandState]
        inc dword [RandIndex]
        jne short .1
        inc dword [RandState+10h]
        jne short .1
        inc dword [RandState+0Ch]
        jne short .1
        inc dword [RandState+8]
        jne short .1
        inc dword [RandState+4]
        db 075h, .1-($+2)
        db 040h                                 ; insn: inc eax
.1:
        mov dword [RandState], eax
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
        mov dword [RandState], eax
        add eax, 96041893h
        mov dword [RandState+4], eax
        add eax, 3DF3B646h
        mov dword [RandState+8], eax
        add eax, 40DDE76Dh
        mov dword [RandState+0Ch], eax
        add eax, 97327AE1h
        mov dword [RandState+10h], eax
        add eax, 0D1A9FBE7h
        mov dword [RandIndex], eax
        leave
        ret
