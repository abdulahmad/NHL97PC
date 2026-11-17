; EA library: FpuLoadInfinity, FpuRestoreStackTop, FpuStoreResult.
bits 32
%include "hockey.inc"
section s_13BF21 progbits alloc exec nowrite align=1
extern F32_3p40282e38, F64_1p79769e308
global FpuLoadInfinity, FpuRestoreStackTop, FpuStoreResult
;-----------------------------------------------------------------------------
; FpuLoadInfinity                                13BF21  97 PC, low confidence
; Loads a signed infinity of the operand's size
;-----------------------------------------------------------------------------
FpuLoadInfinity:
        ftst
        wait
        fnstsw word [byte ebp+014h]
        fstp st0
        test bh, 4
        je short .1
        fld qword [F64_1p79769e308]
        jmp short .2
.1:
        fld dword [F32_3p40282e38]
.2:
        test word [byte ebp+014h], 100h
        je short .3
        fchs
.3:
        ret
;-----------------------------------------------------------------------------
; FpuRestoreStackTop                             13BF47  97 PC, low confidence
; Reloads the faulting operand into its coprocessor stack slot
;-----------------------------------------------------------------------------
FpuRestoreStackTop:
        test bh, 4
        jne short .1
        mov dl, 0
        jmp short .2
.1:
        mov dl, bl
        and dl, 7
.2:
        push edx
.3:
        dec dl
        jl short .4
        fincstp
        jmp short .3
.4:
        fstp st0
        fld tword [esi]
        pop edx
.5:
        dec dl
        jl short .6
        fdecstp
        jmp short .5
.6:
        ret
;-----------------------------------------------------------------------------
; FpuStoreResult                                 13BF6C  97 PC, low confidence
; Stores the fixed result to memory as a double or a float
;-----------------------------------------------------------------------------
FpuStoreResult:
        test bl, 4
        je short .1
        fst qword [es:edi]
        jmp short .2
.1:
        fst dword [es:edi]
.2:
        ret
