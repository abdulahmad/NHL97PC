; Watcom C runtime: __fpatan_wrap, sqrt_, IF@SQRT, __@DSQRT, __pow87_err_ and 10 more.
bits 32
%include "hockey.inc"
section s_124FC6 progbits alloc exec nowrite align=1
extern __fpatan_chk, __math2err_, __math87_err_, CreateBitmapCore, F32_0p9375, F32_1p0625, F32_9p22337e18, F64_709p783
extern F64_neg709p783, FdivJumpTable, FdivShiftTable, findmemblock
global __fpatan_wrap, sqrt_, IF@SQRT, __@DSQRT, __pow87_err_, __@DEXP1, IF@EXP, __@DEXP
global __@DEXP_2F, fdiv_main_routine, __fdiv_fpr, __fdiv_fpr_A, __fdiv_fpr_10, __fdiv_fpr_15, __fdiv_fpr_1B, __fdiv_fpr_20
global __fdiv_fpr_26, __fdiv_fpr_2C, __fdiv_fpr_32, __fdiv_fpr_38, __fdiv_fpr_54, __fdiv_fpr_59, __fdiv_fpr_6F, __fdiv_fpr_74
global __fdiv_fpr_90, __fdiv_fpr_A0, __fdiv_fpr_B4, __fdiv_fpr_C4, __fdiv_fpr_E4, __fdiv_fpr_E9, __fdiv_fpr_103, __fdiv_fpr_108
global __fdiv_fpr_128, __fdiv_fpr_13C, __fdiv_fpr_154, __fdiv_fpr_168, __fdiv_fpr_188, __fdiv_fpr_18D, __fdiv_fpr_1A7, __fdiv_fpr_1AC
global __fdiv_fpr_1CC, __fdiv_fpr_1E0, __fdiv_fpr_1F8, __fdiv_fpr_20C, __fdiv_fpr_22C, __fdiv_fpr_231, __fdiv_fpr_24B, __fdiv_fpr_250
global __fdiv_fpr_270, __fdiv_fpr_284, __fdiv_fpr_29C, __fdiv_fpr_2B0, __fdiv_fpr_2D0, __fdiv_fpr_2D5, __fdiv_fpr_2EF, __fdiv_fpr_2F4
global __fdiv_fpr_314, __fdiv_fpr_328, __fdiv_fpr_340, __fdiv_fpr_354, __fdiv_fpr_374, __fdiv_fpr_379, __fdiv_fpr_393, __fdiv_fpr_398
global __fdiv_fpr_3B8, __fdiv_fpr_3CC, __fdiv_fpr_3E4, __fdiv_fpr_3F8, __fdiv_fpr_418, __fdiv_fpr_41D, __fdiv_fpr_437, __fdiv_fpr_43C
global __fdiv_fpr_45C, __fdiv_fpr_470, __fdiv_fpr_488, __fdivp_sti_st, __fdivrp_sti_st, __fdiv_chk, __fdiv_m64
        db 00h,00h
;-----------------------------------------------------------------------------
; __fpatan_wrap                                                124FC8  library
; Run-time library: wraps fpatan with the FDIV bug check
;-----------------------------------------------------------------------------
__fpatan_wrap:
        push eax
        sub esp, byte 76h
        fstp tword [byte esp+06Ch]
        fnsave [esp]
        fld tword [byte esp+01Ch]
        fld tword [byte esp+06Ch]
        call __fpatan_chk
        fnstsw ax
        fstp tword [byte esp+01Ch]
        and ax, 0FFh
        or ax, word [byte esp+04h]
        mov word [byte esp+04h], ax
        frstor [esp]
        add esp, byte 76h
        pop eax
        ret
;-----------------------------------------------------------------------------
; sqrt_                                                        124FFC  library
; Run-time library sqrt: square root
;-----------------------------------------------------------------------------
sqrt_:
        test byte [byte esp+0Bh], 80h
        je short .1
        mov eax, dword [byte esp+08h]
        and eax, 7FFFFFFFh
        or eax, dword [byte esp+04h]
        je short .1
        push byte 3
        push dword [byte esp+0Ch]
        push dword [byte esp+0Ch]
        call __math87_err_
        jmp short .2
.1:
        fld qword [byte esp+04h]
        fsqrt
.2:
        ret 8
;-----------------------------------------------------------------------------
; IF@SQRT                                                      12502C  library
; Run-time library sqrt core
;-----------------------------------------------------------------------------
IF@SQRT:
        mov al, 3
;-----------------------------------------------------------------------------
; __@DSQRT                                                     12502E  library
;-----------------------------------------------------------------------------
__@DSQRT:
        push ebp
        mov ebp, esp
        ftst
        sub esp, byte 10h
        wait
        fnstsw word [byte ebp-08h]
        wait
        xchg ax, word [byte ebp-08h]
        sahf
        jae short .2
        fstp qword [byte ebp-010h]
        mov eax, dword [byte ebp-08h]
        cmp al, 3
        je short .1
        fstp qword [byte ebp-010h]
.1:
        mov dword [byte ebp-04h], edx
        call __math87_err_
        mov al, 1
        jmp short .3
.2:
        fsqrt
        mov al, 0
.3:
        mov esp, ebp
        pop ebp
        ret
;-----------------------------------------------------------------------------
; __pow87_err_                                                 125063  library
; Run-time library: reports a pow error
;-----------------------------------------------------------------------------
__pow87_err_:
        push ebp
        mov ebp, esp
        push eax
        push ebx
        push ecx
        push edx
        sub esp, byte 8
        xor eax, eax
        mov al, byte [byte ebp+018h]
        cmp eax, byte 1
        jg short .4
        test al, al
        jne short .3
        fldz
        fcomp qword [byte ebp+010h]
        fnstsw ax
        sahf
        jae short .1
        xor ecx, ecx
        mov dword [byte ebp-018h], ecx
        mov dword [byte ebp-014h], ecx
        jmp short .8
.1:
        jbe short .2
        mov eax, 8047h
        jmp short .7
.2:
        mov eax, 4047h
        jmp short .7
.3:
        mov eax, 2047h
        jmp short .7
.4:
        fldz
        fcomp qword [byte ebp+010h]
        fnstsw ax
        sahf
        jb short .5
        xor edx, edx
        mov dword [byte ebp-018h], edx
        mov dword [byte ebp-014h], edx
        jmp short .8
.5:
        fldz
        fcomp qword [byte ebp+08h]
        fnstsw ax
        sahf
        jae short .6
        mov eax, 8107h
        jmp short .7
.6:
        mov eax, 1107h
.7:
        lea ebx, [byte ebp+010h]
        lea edx, [byte ebp+08h]
        call __math2err_
        fstp qword [byte ebp-018h]
.8:
        fld qword [byte ebp-018h]
        lea esp, [byte ebp-010h]
        pop edx
        pop ecx
        pop ebx
        pop eax
        pop ebp
        ret 14h
;-----------------------------------------------------------------------------
; __@DEXP1                                                     1250EC  library
; Run-time library: exp helper
;-----------------------------------------------------------------------------
__@DEXP1:
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        jmp short __@DEXP_2F
;-----------------------------------------------------------------------------
; IF@EXP                                                       1250F4  library
; Run-time library exp core
;-----------------------------------------------------------------------------
IF@EXP:
        mov al, 4
;-----------------------------------------------------------------------------
; __@DEXP                                                      1250F6  library
;-----------------------------------------------------------------------------
__@DEXP:
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        fcom qword [F64_709p783]
        wait
        fnstsw word [byte ebp-010h]
        wait
        mov ah, byte [byte ebp-0Fh]
        sahf
        jbe short __@DEXP_2F
        cmp al, 7
        je short .1
        fstp qword [byte ebp-010h]
        mov dword [byte ebp-08h], eax
        mov dword [byte ebp-04h], edx
        call __math87_err_
.1:
        mov al, 1
        mov esp, ebp
        pop ebp
        ret
;-----------------------------------------------------------------------------
; __@DEXP_2F                                              125125  97 PC, low confidence
; Run-time library: second entry of the exp helper
;-----------------------------------------------------------------------------
__@DEXP_2F:
        fcom qword [F64_neg709p783]
        wait
        fnstsw word [byte ebp-010h]
        wait
        mov ah, byte [byte ebp-0Fh]
        sahf
        ja short .2
        fldz
        jmp short .3
.2:
        fldl2e
        fmulp
        fld st0
        frndint
        fxch
        fsub st1
        f2xm1
        fld1
        faddp
        fscale
.3:
        fstp st1
        mov al, 0
        mov esp, ebp
        pop ebp
        ret
        fld qword [byte esp+04h]
        call IF@EXP
        ret 8
        db 00h,00h
;-----------------------------------------------------------------------------
; fdiv_main_routine                                            125164  library
; Run-time library: division that avoids the Pentium FDIV bug
;-----------------------------------------------------------------------------
fdiv_main_routine:
        fld tword [byte esp+010h]
        fld tword [byte esp+04h]
.1:
        mov eax, dword [byte esp+08h]
        add eax, eax
        jae near .5
        xor eax, 0E000000h
        test eax, 0E000000h
        je short .2
        fdivp
        ret
.2:
        shr eax, 1Ch
        cmp byte [dword eax+FdivShiftTable], 0
        jne short .3
        fdivp
        ret
.3:
        mov eax, dword [byte esp+0Ch]
        and eax, 7FFFh
        je short .6
        cmp eax, 7FFFh
        je short .6
        fnstcw word [byte esp+01Ch]
        mov eax, dword [byte esp+01Ch]
        or eax, 33Fh
        and eax, 0F3FFh
        mov dword [byte esp+020h], eax
        fldcw word [byte esp+020h]
        mov eax, dword [byte esp+018h]
        and eax, 7FFFh
        cmp eax, byte 1
        je short .4
        fmul dword [F32_0p9375]
        fxch
        fmul dword [F32_0p9375]
        fxch
        fldcw word [byte esp+01Ch]
        fdivp
        ret
.4:
        fmul dword [F32_1p0625]
        fxch
        fmul dword [F32_1p0625]
        fxch
        fldcw word [byte esp+01Ch]
        fdivp
        ret
.5:
        mov eax, dword [byte esp+04h]
        or eax, dword [byte esp+08h]
        jne short .7
.6:
        fdivp
        ret
.7:
        mov eax, dword [byte esp+0Ch]
        and eax, 7FFFh
        jne short .6
        fnstcw word [byte esp+01Ch]
        mov eax, dword [byte esp+01Ch]
        or eax, 33Fh
        and eax, 0F3FFh
        mov dword [byte esp+020h], eax
        fldcw word [byte esp+020h]
        mov eax, dword [byte esp+018h]
        and eax, 7FFFh
        je short .8
        cmp eax, 7FFFh
        je short .10
        mov eax, dword [byte esp+014h]
        add eax, eax
        jae short .10
        jmp short .9
.8:
        mov eax, dword [byte esp+014h]
        add eax, eax
        jb short .10
.9:
        fxch
        fstp st0
        fld st0
        fmul dword [F32_9p22337e18]
        fstp tword [byte esp+04h]
        fld tword [byte esp+010h]
        fxch
        wait
        fldcw word [byte esp+01Ch]
        jmp near .1
.10:
        fldcw word [byte esp+01Ch]
        fdivp
        ret
;-----------------------------------------------------------------------------
; __fdiv_fpr                                                   12527B  library
; Run-time library: checked fdiv on FPU registers
;-----------------------------------------------------------------------------
__fdiv_fpr:
        sub esp, byte 2Ch
        jmp dword [nosplit eax*4+FdivJumpTable]
__fdiv_fpr_A:
        fdiv st0
        add esp, byte 2Ch
        ret
__fdiv_fpr_10:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_15:
        fdivr st0
        add esp, byte 2Ch
        ret
__fdiv_fpr_1B:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_20:
        fdiv st0
        add esp, byte 2Ch
        ret
__fdiv_fpr_26:
        fdivp st0
        add esp, byte 2Ch
        ret
__fdiv_fpr_2C:
        fdivr st0
        add esp, byte 2Ch
        ret
__fdiv_fpr_32:
        fdivrp st0
        add esp, byte 2Ch
        ret
__fdiv_fpr_38:
        fstp tword [byte esp+0Ch]
        fld st0
        fstp tword [esp]
        fstp tword [byte esp+020h]
        call fdiv_main_routine
        fld tword [byte esp+020h]
        fxch
        add esp, byte 2Ch
        ret
__fdiv_fpr_54:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_59:
        fstp tword [esp]
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        fld tword [byte esp+0Ch]
        fxch
        add esp, byte 2Ch
        ret
__fdiv_fpr_6F:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_74:
        fxch
        fstp tword [byte esp+0Ch]
        fld st0
        fstp tword [esp]
        fstp tword [byte esp+020h]
        call fdiv_main_routine
        fld tword [byte esp+020h]
        add esp, byte 2Ch
        ret
__fdiv_fpr_90:
        fstp tword [esp]
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        add esp, byte 2Ch
        ret
__fdiv_fpr_A0:
        fstp tword [byte esp+0Ch]
        fstp tword [esp]
        call fdiv_main_routine
        fld tword [byte esp+0Ch]
        add esp, byte 2Ch
        ret
__fdiv_fpr_B4:
        fstp tword [byte esp+0Ch]
        fstp tword [esp]
        call fdiv_main_routine
        add esp, byte 2Ch
        ret
__fdiv_fpr_C4:
        fstp tword [byte esp+0Ch]
        fxch
        fld st0
        fstp tword [esp]
        fstp tword [byte esp+020h]
        call fdiv_main_routine
        fxch
        fld tword [byte esp+020h]
        fxch st2
        add esp, byte 2Ch
        ret
__fdiv_fpr_E4:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_E9:
        fstp tword [esp]
        fxch
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        fxch
        fld tword [byte esp+0Ch]
        fxch st2
        add esp, byte 2Ch
        ret
__fdiv_fpr_103:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_108:
        fxch st2
        fstp tword [byte esp+0Ch]
        fxch
        fld st0
        fstp tword [esp]
        fstp tword [byte esp+020h]
        call fdiv_main_routine
        fxch
        fld tword [byte esp+020h]
        add esp, byte 2Ch
        ret
__fdiv_fpr_128:
        fstp tword [esp]
        fxch
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        fxch
        add esp, byte 2Ch
        ret
__fdiv_fpr_13C:
        fstp tword [byte esp+0Ch]
        fxch
        fstp tword [esp]
        call fdiv_main_routine
        fxch
        fld tword [byte esp+0Ch]
        add esp, byte 2Ch
        ret
__fdiv_fpr_154:
        fstp tword [byte esp+0Ch]
        fxch
        fstp tword [esp]
        call fdiv_main_routine
        fxch
        add esp, byte 2Ch
        ret
__fdiv_fpr_168:
        fstp tword [byte esp+0Ch]
        fxch st2
        fld st0
        fstp tword [esp]
        fstp tword [byte esp+020h]
        call fdiv_main_routine
        fxch st2
        fld tword [byte esp+020h]
        fxch st3
        add esp, byte 2Ch
        ret
__fdiv_fpr_188:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_18D:
        fstp tword [esp]
        fxch st2
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        fxch st2
        fld tword [byte esp+0Ch]
        fxch st3
        add esp, byte 2Ch
        ret
__fdiv_fpr_1A7:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_1AC:
        fxch st3
        fstp tword [byte esp+0Ch]
        fxch st2
        fld st0
        fstp tword [esp]
        fstp tword [byte esp+020h]
        call fdiv_main_routine
        fxch st2
        fld tword [byte esp+020h]
        add esp, byte 2Ch
        ret
__fdiv_fpr_1CC:
        fstp tword [esp]
        fxch st2
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        fxch st2
        add esp, byte 2Ch
        ret
__fdiv_fpr_1E0:
        fstp tword [byte esp+0Ch]
        fxch st2
        fstp tword [esp]
        call fdiv_main_routine
        fxch st2
        fld tword [byte esp+0Ch]
        add esp, byte 2Ch
        ret
__fdiv_fpr_1F8:
        fstp tword [byte esp+0Ch]
        fxch st2
        fstp tword [esp]
        call fdiv_main_routine
        fxch st2
        add esp, byte 2Ch
        ret
__fdiv_fpr_20C:
        fstp tword [byte esp+0Ch]
        fxch st3
        fld st0
        fstp tword [esp]
        fstp tword [byte esp+020h]
        call fdiv_main_routine
        fxch st3
        fld tword [byte esp+020h]
        fxch st4
        add esp, byte 2Ch
        ret
__fdiv_fpr_22C:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_231:
        fstp tword [esp]
        fxch st3
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        fxch st3
        fld tword [byte esp+0Ch]
        fxch st4
        add esp, byte 2Ch
        ret
__fdiv_fpr_24B:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_250:
        fxch st4
        fstp tword [byte esp+0Ch]
        fxch st3
        fld st0
        fstp tword [esp]
        fstp tword [byte esp+020h]
        call fdiv_main_routine
        fxch st3
        fld tword [byte esp+020h]
        add esp, byte 2Ch
        ret
__fdiv_fpr_270:
        fstp tword [esp]
        fxch st3
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        fxch st3
        add esp, byte 2Ch
        ret
__fdiv_fpr_284:
        fstp tword [byte esp+0Ch]
        fxch st3
        fstp tword [esp]
        call fdiv_main_routine
        fxch st3
        fld tword [byte esp+0Ch]
        add esp, byte 2Ch
        ret
__fdiv_fpr_29C:
        fstp tword [byte esp+0Ch]
        fxch st3
        fstp tword [esp]
        call fdiv_main_routine
        fxch st3
        add esp, byte 2Ch
        ret
__fdiv_fpr_2B0:
        fstp tword [byte esp+0Ch]
        fxch st4
        fld st0
        fstp tword [esp]
        fstp tword [byte esp+020h]
        call fdiv_main_routine
        fxch st4
        fld tword [byte esp+020h]
        fxch st5
        add esp, byte 2Ch
        ret
__fdiv_fpr_2D0:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_2D5:
        fstp tword [esp]
        fxch st4
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        fxch st4
        fld tword [byte esp+0Ch]
        fxch st5
        add esp, byte 2Ch
        ret
__fdiv_fpr_2EF:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_2F4:
        fxch st5
        fstp tword [byte esp+0Ch]
        fxch st4
        fld st0
        fstp tword [esp]
        fstp tword [byte esp+020h]
        call fdiv_main_routine
        fxch st4
        fld tword [byte esp+020h]
        add esp, byte 2Ch
        ret
__fdiv_fpr_314:
        fstp tword [esp]
        fxch st4
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        fxch st4
        add esp, byte 2Ch
        ret
__fdiv_fpr_328:
        fstp tword [byte esp+0Ch]
        fxch st4
        fstp tword [esp]
        call fdiv_main_routine
        fxch st4
        fld tword [byte esp+0Ch]
        add esp, byte 2Ch
        ret
__fdiv_fpr_340:
        fstp tword [byte esp+0Ch]
        fxch st4
        fstp tword [esp]
        call fdiv_main_routine
        fxch st4
        add esp, byte 2Ch
        ret
__fdiv_fpr_354:
        fstp tword [byte esp+0Ch]
        fxch st5
        fld st0
        fstp tword [esp]
        fstp tword [byte esp+020h]
        call fdiv_main_routine
        fxch st5
        fld tword [byte esp+020h]
        fxch st6
        add esp, byte 2Ch
        ret
__fdiv_fpr_374:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_379:
        fstp tword [esp]
        fxch st5
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        fxch st5
        fld tword [byte esp+0Ch]
        fxch st6
        add esp, byte 2Ch
        ret
__fdiv_fpr_393:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_398:
        fxch st6
        fstp tword [byte esp+0Ch]
        fxch st5
        fld st0
        fstp tword [esp]
        fstp tword [byte esp+020h]
        call fdiv_main_routine
        fxch st5
        fld tword [byte esp+020h]
        add esp, byte 2Ch
        ret
__fdiv_fpr_3B8:
        fstp tword [esp]
        fxch st5
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        fxch st5
        add esp, byte 2Ch
        ret
__fdiv_fpr_3CC:
        fstp tword [byte esp+0Ch]
        fxch st5
        fstp tword [esp]
        call fdiv_main_routine
        fxch st5
        fld tword [byte esp+0Ch]
        add esp, byte 2Ch
        ret
__fdiv_fpr_3E4:
        fstp tword [byte esp+0Ch]
        fxch st5
        fstp tword [esp]
        call fdiv_main_routine
        fxch st5
        add esp, byte 2Ch
        ret
__fdiv_fpr_3F8:
        fstp tword [byte esp+0Ch]
        fxch st6
        fld st0
        fstp tword [esp]
        fstp tword [byte esp+020h]
        call fdiv_main_routine
        fxch st6
        fld tword [byte esp+020h]
        fxch st7
        add esp, byte 2Ch
        ret
__fdiv_fpr_418:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_41D:
        fstp tword [esp]
        fxch st6
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        fxch st6
        fld tword [byte esp+0Ch]
        fxch st7
        add esp, byte 2Ch
        ret
__fdiv_fpr_437:
        add esp, byte 2Ch
        int 6
__fdiv_fpr_43C:
        fxch st7
        fstp tword [byte esp+0Ch]
        fxch st6
        fld st0
        fstp tword [esp]
        fstp tword [byte esp+020h]
        call fdiv_main_routine
        fxch st6
        fld tword [byte esp+020h]
        add esp, byte 2Ch
        ret
__fdiv_fpr_45C:
        fstp tword [esp]
        fxch st6
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        fxch st6
        add esp, byte 2Ch
        ret
__fdiv_fpr_470:
        fstp tword [byte esp+0Ch]
        fxch st6
        fstp tword [esp]
        call fdiv_main_routine
        fxch st6
        fld tword [byte esp+0Ch]
        add esp, byte 2Ch
        ret
__fdiv_fpr_488:
        fstp tword [byte esp+0Ch]
        fxch st6
        fstp tword [esp]
        call fdiv_main_routine
        fxch st6
        add esp, byte 2Ch
        ret
;-----------------------------------------------------------------------------
; __fdivp_sti_st                                               125717  library
; Run-time library: checked fdivp st(i), st
;-----------------------------------------------------------------------------
__fdivp_sti_st:
        sub esp, byte 2Ch
        fstp tword [esp]
        fstp tword [byte esp+0Ch]
        call fdiv_main_routine
        add esp, byte 2Ch
        ret
;-----------------------------------------------------------------------------
; __fdivrp_sti_st                                              12572A  library
; Run-time library: checked fdivrp st(i), st
;-----------------------------------------------------------------------------
__fdivrp_sti_st:
        sub esp, byte 2Ch
        fstp tword [byte esp+0Ch]
        fstp tword [esp]
        call fdiv_main_routine
        add esp, byte 2Ch
        ret
;-----------------------------------------------------------------------------
; __fdiv_chk                                                   12573D  library
; Run-time library: checked fdiv entry
;-----------------------------------------------------------------------------
__fdiv_chk:
        sub esp, byte 2Ch
        fstp tword [byte esp+0Ch]
        fstp tword [esp]
        call fdiv_main_routine
        add esp, byte 2Ch
        ret
        push eax
        mov eax, dword [byte esp+08h]
        and eax, 7F800000h
        cmp eax, 7F800000h
        je short .2
        fnstsw ax
        and eax, 3800h
        je short .1
        fld dword [byte esp+08h]
        call __fdivp_sti_st
        pop eax
        ret 4
.1:
        fxch
        sub esp, byte 0Ch
        fstp tword [esp]
        fld dword [byte esp+014h]
        call __fdivp_sti_st
        fld tword [esp]
        fxch
        add esp, byte 0Ch
        pop eax
        ret 4
.2:
        fdiv dword [byte esp+08h]
        pop eax
        ret 4
;-----------------------------------------------------------------------------
; __fdiv_m64                                                   12579C  library
; Run-time library: checked fdiv by a 64-bit memory operand
;-----------------------------------------------------------------------------
__fdiv_m64:
        push eax
        mov eax, dword [byte esp+0Ch]
        and eax, 7FF00000h
        cmp eax, 7FF00000h
        je short .2
        fnstsw ax
        and eax, 3800h
        je short .1
        fld qword [byte esp+08h]
        call __fdivp_sti_st
        pop eax
        ret 8
.1:
        fxch
        sub esp, byte 0Ch
        fstp tword [esp]
        fld qword [byte esp+014h]
        call __fdivp_sti_st
        fld tword [esp]
        fxch
        add esp, byte 0Ch
        pop eax
        ret 8
.2:
        fdiv qword [byte esp+08h]
        pop eax
        ret 8
        push eax
        mov eax, dword [byte esp+08h]
        and eax, 7F800000h
        cmp eax, 7F800000h
        je short .4
        fnstsw ax
        and eax, 3800h
        je short .3
        fld dword [byte esp+08h]
        call __fdivrp_sti_st
        pop eax
        ret 4
.3:
        fxch
        sub esp, byte 0Ch
        fstp tword [esp]
        fld dword [byte esp+014h]
        call __fdivrp_sti_st
        fld tword [esp]
        fxch
        add esp, byte 0Ch
        pop eax
        ret 4
.4:
        fdivr dword [byte esp+08h]
        pop eax
        ret 4
        push eax
        mov eax, dword [byte esp+0Ch]
        and eax, 7FF00000h
        cmp eax, 7FF00000h
        je short .6
        fnstsw ax
        and eax, 3800h
        je short .5
        fld qword [byte esp+08h]
        call __fdivrp_sti_st
        pop eax
        ret 8
.5:
        fxch
        sub esp, byte 0Ch
        fstp tword [esp]
        fld qword [byte esp+014h]
        call __fdivrp_sti_st
        fld tword [esp]
        fxch
        add esp, byte 0Ch
        pop eax
        ret 8
.6:
        fdivr qword [byte esp+08h]
        pop eax
        ret 8
        push ebx
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        mov ecx, dword [byte esp+010h]
        push ecx
        call findmemblock
        add esp, byte 4
        push eax
        call CreateBitmapCore
        add esp, byte 0Ch
        pop ebx
        ret
