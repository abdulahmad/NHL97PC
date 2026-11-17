; Watcom C runtime: hypot_, IF@DPOW, PowIntLoop.
bits 32
%include "hockey.inc"
section s_100282 progbits alloc exec nowrite align=1
extern __@DEXP, __fdiv_fpr, __pow87_err_, IF@SQRT, MathErrorFlags
global hypot_, IF@DPOW, PowIntLoop
;-----------------------------------------------------------------------------
; hypot_                                                       100282  library
; Run-time library hypot: the length of a 2D vector
;-----------------------------------------------------------------------------
hypot_:
        push eax
        fld qword [byte esp+08h]
        fmul to st0
        fld qword [byte esp+010h]
        fmul to st0
        faddp
        call IF@SQRT
        pop eax
        ret 10h
;-----------------------------------------------------------------------------
; IF@DPOW                                                      10029A  library
; Run-time library pow core
;-----------------------------------------------------------------------------
IF@DPOW:
        push ebp
        mov ebp, esp
        ftst
        sub esp, byte 18h
        wait
        fnstsw word [byte ebp-08h]
        fst qword [byte ebp-018h]
        mov ah, byte [byte ebp-07h]
        sahf
        jne short .2
        mov al, 0
.1:
        fstp st0
        fstp qword [byte ebp-010h]
        mov dword [byte ebp-08h], eax
        mov dword [byte ebp-04h], edx
        call __pow87_err_
        sub esp, byte 8
        jmp near .13
.2:
        fld st1
        frndint
        fcomp st2
        wait
        fnstsw word [byte ebp-06h]
        wait
        mov ah, byte [byte ebp-05h]
        jae short .4
        mov al, 1
        sahf
        jne short .1
        mov ax, 2
        mov word [byte ebp-04h], ax
        fild word [byte ebp-04h]
        fld st2
        fprem
        wait
        fnstsw word [byte ebp-04h]
        wait
        mov ah, byte [byte ebp-03h]
        sahf
        mov ah, 0
        jp short .3
        ftst
        wait
        fnstsw word [byte ebp-04h]
        wait
        mov ah, byte [byte ebp-03h]
        sahf
        mov ah, 0
        je short .3
        mov ah, 1
.3:
        mov byte [byte ebp-07h], ah
        fstp st0
        fstp st0
        jmp short .5
.4:
        sahf
        je short .5
        jmp near .11
.5:
        fld st1
        fstp qword [byte ebp-010h]
        wait
        mov ax, word [byte ebp-0Ah]
        and ax, 7FF0h
        sub ax, 3FF0h
        cmp ax, 100h
        jae short .11
        fld st1
        fistp dword [byte ebp-04h]
        wait
        mov ax, word [byte ebp-02h]
        or ax, ax
        jne short .6
        mov ax, word [byte ebp-04h]
        call PowIntLoop
        jmp short .8
.6:
        inc ax
        jne short .11
        or ax, word [byte ebp-04h]
        je short .11
        neg ax
        call PowIntLoop
        fld1
        test byte [MathErrorFlags], 1
        jne short .7
        fdivrp
        jmp short .8
.7:
        mov eax, 0Fh
        call __fdiv_fpr
.8:
        fst qword [byte ebp-08h]
        wait
        mov ax, word [byte ebp-08h]
        or ax, word [byte ebp-06h]
        or ax, word [byte ebp-04h]
        jne short .10
        mov ax, word [byte ebp-02h]
        shl ax, 1
        cmp ax, 0FFE0h
        jne short .10
.9:
        mov al, 2
        jmp near .1
.10:
        fstp st1
        jmp short .13
.11:
        fldln2
        fmul st2
        fxch
        fabs
        fyl2x
        mov al, 7
        call __@DEXP
        cmp al, 0
        jne short .9
        mov ah, byte [byte ebp-07h]
        sahf
        jae short .12
        fchs
.12:
        fstp st1
.13:
        fstp qword [byte ebp-08h]
        fld qword [byte ebp-08h]
        wait
        mov esp, ebp
        pop ebp
        ret
;-----------------------------------------------------------------------------
; PowIntLoop                                     1003CD  97 PC, low confidence
; Math library: raises st(0) to an integer power by repeated squaring (used
; by pow)
;-----------------------------------------------------------------------------
PowIntLoop:
        shr ax, 1
        jbe short .1
        fmul st0
        jmp short PowIntLoop
.1:
        jae short .5
        fld st0
.2:
        je short .4
        fmul st0
        shr ax, 1
        jae short .3
        fmul to st1
.3:
        jmp short .2
.4:
        fstp st0
        jmp short .6
.5:
        fstp st0
        fld1
.6:
        ret
        fld qword [byte esp+0Ch]
        fld qword [byte esp+04h]
        call IF@DPOW
        ret 10h
