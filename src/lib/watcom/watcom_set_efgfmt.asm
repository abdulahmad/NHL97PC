; Watcom C runtime: __setEFGfmt_, __sys_init_387_emulator.
bits 32
%include "hockey.inc"
section s_121AB5 progbits alloc exec nowrite align=1
extern __cnvs2d_, __EFG_printf, __EFG_scanf, _EFG_Format_, DefaultControlWord, InitFpuFlags
global __setEFGfmt_, __sys_init_387_emulator
;-----------------------------------------------------------------------------
; __setEFGfmt_                                                 121AB5  library
; Run-time library: installs the float format hook for printf
;-----------------------------------------------------------------------------
__setEFGfmt_:
        push ebx
        push edx
        mov edx, _EFG_Format_
        mov ebx, __cnvs2d_
        mov dword [__EFG_printf], edx
        mov dword [__EFG_scanf], ebx
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; __sys_init_387_emulator                                      121AD0  library
; Run-time library: installs the x87 emulator when there is no FPU
;-----------------------------------------------------------------------------
__sys_init_387_emulator:
        push es
        push ecx
        push ebx
        push edx
        fninit
        push eax
        fnstcw word [esp]
        pop eax
        cmp ah, 3
        je short .1
        inc ebp
.1:
        or ebp, ebp
        je short .2
        call InitFpuFlags
.2:
        wait
        fninit
        fldcw word [DefaultControlWord]
        fldz
        fldz
        fldz
        fldz
        pop edx
        pop ebx
        pop ecx
        pop es
        ret
