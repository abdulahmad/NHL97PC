; Watcom C runtime: __Phar_hook_init_, __Phar_hook_fini_, __DOS4G_hook_init_, __DOS4G_hook_fini_ and 4 more.
bits 32
%include "hockey.inc"
section s_13BF7A progbits alloc exec nowrite align=1
extern _Extender, DosExtenderType, ErgoVersion, FpuExceptionHandler, FpuIrqEoi, IntelExtenderVersion, PharLapVersion, SavedFpuEs
extern SavedFpuVecOffset, SavedFpuVecSelector
global __Phar_hook_init_, __Phar_hook_fini_, __DOS4G_hook_init_, __DOS4G_hook_fini_, __Ergo_hook_init_, __Ergo_hook_fini_, __Intel_hook_init_, __Intel_hook_fini_
;-----------------------------------------------------------------------------
; __Phar_hook_init_                                            13BF7A  library
; Run-time library: FPU hook setup under the Phar Lap extender
;-----------------------------------------------------------------------------
__Phar_hook_init_:
        push ds
        cmp byte [IntelExtenderVersion], 20h
        jne short .1
        lea edx, [FpuIrqEoi]
        jmp short .2
.1:
        lea edx, [FpuExceptionHandler]
.2:
        cmp byte [_Extender], 3
        jae short .3
        mov cl, 50h
        mov ax, 2503h
        int 21h
        push ebx
        mov ax, 2502h
        int 21h
        push ebx
        push es
        push ds
        mov ax, cs
        mov ds, eax
        mov ax, 2506h
        int 21h
        pop ds
.3:
        mov ax, 250Ch
        int 21h
        mov cl, ah
        add cl, byte [PharLapVersion]
        sub cl, 8
        mov ax, 2502h
        int 21h
        mov dword [SavedFpuVecOffset], ebx
        o16 mov word [SavedFpuEs], es
        mov ax, 2503h
        int 21h
        mov dword [SavedFpuVecSelector], ebx
        cmp byte [_Extender], 3
        jae short .4
        sub esp, byte 8
        sidt [esp]
        mov ax, 60h
        mov es, eax
        mov ebx, dword [byte esp+02h]
        add esp, byte 8
        mov eax, dword [dword es:ebx+0280h]
        mov edx, dword [dword es:ebx+0284h]
        movzx ecx, cl
        shl ecx, 3
        mov dword [es:ebx+ecx], eax
        mov dword [byte es:ebx+ecx+04h], edx
        mov cl, 50h
        pop ds
        pop edx
        pop ebx
        mov ax, 2507h
        int 21h
        jmp short .5
.4:
        mov ax, cs
        mov ds, eax
        mov ax, 2506h
        int 21h
.5:
        pop ds
        ret
;-----------------------------------------------------------------------------
; __Phar_hook_fini_                                            13C03D  library
; Run-time library: FPU hook removal under the Phar Lap extender
;-----------------------------------------------------------------------------
__Phar_hook_fini_:
        push ds
        mov ax, 250Ch
        int 21h
        mov cl, ah
        add cl, byte [PharLapVersion]
        sub cl, 8
        mov ebx, dword [SavedFpuVecSelector]
        mov edx, dword [SavedFpuVecOffset]
        o16 mov ds, word [SavedFpuEs]
        mov ax, 2507h
        int 21h
        pop ds
        ret
;-----------------------------------------------------------------------------
; __DOS4G_hook_init_                                           13C06A  library
; Run-time library: FPU hook setup under DOS/4GW
;-----------------------------------------------------------------------------
__DOS4G_hook_init_:
        push ds
        mov ah, 35h
        mov al, byte [DosExtenderType]
        int 21h
        mov dword [SavedFpuVecOffset], ebx
        o16 mov word [SavedFpuEs], es
        mov ah, 25h
        mov al, byte [DosExtenderType]
        mov dx, cs
        mov ds, edx
        lea edx, [FpuExceptionHandler]
        int 21h
        pop ds
        ret
;-----------------------------------------------------------------------------
; __DOS4G_hook_fini_                                           13C097  library
; Run-time library: FPU hook removal under DOS/4GW
;-----------------------------------------------------------------------------
__DOS4G_hook_fini_:
        push ds
        mov ah, 25h
        mov al, byte [DosExtenderType]
        mov edx, dword [SavedFpuVecOffset]
        o16 mov ds, word [SavedFpuEs]
        int 21h
        pop ds
        ret
;-----------------------------------------------------------------------------
; __Ergo_hook_init_                                            13C0B0  library
; Run-time library: FPU hook setup under the Ergo extender
;-----------------------------------------------------------------------------
__Ergo_hook_init_:
        push ds
        mov ah, 35h
        mov al, byte [ErgoVersion]
        int 21h
        mov dword [SavedFpuVecOffset], ebx
        o16 mov word [SavedFpuEs], es
        mov ah, 25h
        mov al, byte [ErgoVersion]
        cmp byte [IntelExtenderVersion], 20h
        jne short .1
        lea edx, [FpuIrqEoi]
        jmp short .2
.1:
        lea edx, [FpuExceptionHandler]
.2:
        mov bx, cs
        mov ds, ebx
        int 21h
        pop ds
        ret
;-----------------------------------------------------------------------------
; __Ergo_hook_fini_                                            13C0EE  library
; Run-time library: FPU hook removal under the Ergo extender
;-----------------------------------------------------------------------------
__Ergo_hook_fini_:
        push ds
        mov ah, 25h
        mov al, byte [ErgoVersion]
        mov edx, dword [SavedFpuVecOffset]
        o16 mov ds, word [SavedFpuEs]
        int 21h
        pop ds
        ret
        db 00h
;-----------------------------------------------------------------------------
; __Intel_hook_init_                                           13C108  library
; Run-time library: FPU hook setup under the Intel extender
;-----------------------------------------------------------------------------
__Intel_hook_init_:
        mov ax, 204h
        mov bl, byte [DosExtenderType]
        int 31h
        mov dword [SavedFpuVecOffset], edx
        mov word [SavedFpuEs], cx
        mov ax, 200h
        mov bl, byte [DosExtenderType]
        int 31h
        shl ecx, 10h
        mov cx, dx
        mov dword [SavedFpuVecSelector], ecx
        mov cx, cs
        cmp byte [IntelExtenderVersion], 20h
        jne short .1
        lea edx, [FpuIrqEoi]
        jmp short .2
.1:
        lea edx, [FpuExceptionHandler]
.2:
        mov ax, 205h
        mov bl, byte [DosExtenderType]
        int 31h
        ret
;-----------------------------------------------------------------------------
; __Intel_hook_fini_                                           13C160  library
; Run-time library: FPU hook removal under the Intel extender
;-----------------------------------------------------------------------------
__Intel_hook_fini_:
        ret
