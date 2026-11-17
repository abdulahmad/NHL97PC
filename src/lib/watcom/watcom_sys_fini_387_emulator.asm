; Watcom C runtime: __sys_fini_387_emulator, EmuRestoreFpuVector, EmuRestoreRealVector and 5 more.
bits 32
%include "hockey.inc"
section s_121C55 progbits alloc exec nowrite align=1
extern __8087, __init_80x87, __no87, __real87, __unhook387, _Extender, DefaultControlWord, EmuFiniHook
extern EmuInitHook, FpuCr0Bits, FpuFlags, FpuSystemFlags, FpuType, Is8087, OldFpuVectorOffset, OldFpuVectorSelector
extern str_Punct_InitFpuFlags
global __sys_fini_387_emulator, EmuRestoreFpuVector, EmuRestoreRealVector, __save_8087_, __rest_8087_, __init_8087_, _fpreset_, __chk8087_
;-----------------------------------------------------------------------------
; __sys_fini_387_emulator                                      121C55  library
; Run-time library: removes the x87 emulator
;-----------------------------------------------------------------------------
__sys_fini_387_emulator:
        cmp byte [__real87], 1
        je short .1
        ret
.1:
        push ecx
        push ebx
        push edx
        mov al, byte [_Extender]
        cmp byte [Is8087], 0
        je short .2
        call EmuRestoreRealVector
        jmp short .6
.2:
        cmp al, 9
        jne short .3
        mov eax, 0E02h
        mov ebx, 0
        mov ecx, dword [FpuFlags]
        call dword [byte ecx+030h]
        jmp short .6
.3:
        cmp al, 0
        jne short .4
        mov ax, word [FpuCr0Bits]
        mov ah, 0F3h
        int 21h
        jmp short .6
.4:
        cmp al, 1
        jne short .5
        mov dx, word [str_Punct_InitFpuFlags]
        sub eax, eax
        call __unhook387
        jmp short .6
.5:
        sub edx, edx
        call __unhook387
        cmp al, 1
        je short .6
        call EmuRestoreFpuVector
.6:
        mov byte [__real87], 0
        pop edx
        pop ebx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; EmuRestoreFpuVector                            121CCF  97 PC, low confidence
; Puts back the original coprocessor-missing vector and CR0 coprocessor bits
; when the emulator shuts down
;-----------------------------------------------------------------------------
EmuRestoreFpuVector:
        mov cl, 7
        mov ax, 2504h
        mov edx, dword [OldFpuVectorOffset]
        push ds
        o16 mov ds, word [OldFpuVectorSelector]
        int 21h
        pop ds
        cmp byte [_Extender], 3
        jl short .1
        call EmuRestoreRealVector
        jmp short .2
.1:
        mov ecx, cr0
        and ecx, byte 0FFFFFFF9h
        mov dx, word [FpuCr0Bits]
        or cx, dx
        mov cr0, ecx
.2:
        ret
;-----------------------------------------------------------------------------
; EmuRestoreRealVector                           121D0A  97 PC, low confidence
; Restores the saved real-mode vector through the DOS extender
;-----------------------------------------------------------------------------
EmuRestoreRealVector:
        xor ebx, ebx
        lea edx, [FpuSystemFlags]
        mov ax, 2535h
        int 21h
        xor ecx, ecx
        mov cx, word [FpuCr0Bits]
        mov dword [FpuSystemFlags], ecx
        inc ebx
        int 21h
        ret
;-----------------------------------------------------------------------------
; __save_8087_                                                 121D2B  library
; Run-time library: saves the FPU state
;-----------------------------------------------------------------------------
__save_8087_:
        wait
        fnsave [eax]
        wait
        ret
;-----------------------------------------------------------------------------
; __rest_8087_                                                 121D30  library
; Run-time library: restores the FPU state
;-----------------------------------------------------------------------------
__rest_8087_:
        frstor [eax]
        wait
        ret
;-----------------------------------------------------------------------------
; __init_8087_                                                 121D34  library
; Run-time library: initialises the FPU
;-----------------------------------------------------------------------------
__init_8087_:
        push ebx
        push edx
        cmp byte [FpuType], 0
        je short .1
        mov edx, __save_8087_
        mov ebx, __rest_8087_
        mov dword [EmuInitHook], edx
        mov dword [EmuFiniHook], ebx
.1:
        xor eax, eax
        mov ax, word [DefaultControlWord]
        call __init_80x87
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; _fpreset_                                                    121D65  library
; Run-time library _fpreset: resets the floating point package
;-----------------------------------------------------------------------------
_fpreset_:
        cmp byte [FpuType], 0
        jne short __init_8087_
        ret
;-----------------------------------------------------------------------------
; __chk8087_                                                   121D6F  library
; Run-time library: detects the FPU at start-up
;-----------------------------------------------------------------------------
__chk8087_:
        push edx
        mov ah, byte [__8087]
        test ah, ah
        jne short .2
        mov byte [FpuType], ah
        xor dl, dl
        LD sub, eax, eax
        push eax
        fninit
        fnstcw word [esp]
        pop eax
        LD mov, al, ah
        xor dh, dh
        and eax, 0FFh
        cmp eax, byte 3
        jne short .1
        call __init_8087_
        mov dl, al
        mov dh, al
.1:
        cmp byte [__no87], 0
        jne short .2
        mov byte [__8087], dl
        mov byte [FpuType], dh
.2:
        pop edx
        ret
