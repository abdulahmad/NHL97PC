; Watcom C runtime: __restore_int23_, __restore_int_, __restore_int_ctrl_break_, __grab_int23_ and 1 more.
bits 32
%include "hockey.inc"
section s_13ACA5 progbits alloc exec nowrite align=1
extern __DPMI_hosted_, __int23_handler_, __int_ctrl_break_handler_, __null_int23_exit_, _dos_getvect_, _dos_setvect_, _Extender, Int23Hook
extern OldCtrlBreakOffset, OldCtrlBreakRealOffset, OldCtrlBreakRealSegment, OldCtrlBreakSelector, OldInt23Offset, OldInt23RealOffset, OldInt23RealSegment, OldInt23Selector
global __restore_int23_, __restore_int23__F3, __restore_int23__105, __restore_int23__1AC, __restore_int_, __restore_int_ctrl_break_, __grab_int23_, __grab_int_ctrl_break_
;-----------------------------------------------------------------------------
; __restore_int23_                                             13ACA5  library
; Run-time library: restores the original Ctrl+C handler
;-----------------------------------------------------------------------------
__restore_int23_:
        push ebx
        push ecx
        push edx
        push ebp
        cmp dword [OldInt23Offset], byte 0
        jne short .1
        cmp word [OldInt23Selector], byte 0
        je near .7
.1:
        mov ebx, dword [Int23Hook]
        cmp ebx, __restore_int_
        jne short .2
        mov dword [Int23Hook], __restore_int_ctrl_break_
        jmp short .3
.2:
        cmp ebx, __restore_int23_
        jne short .3
        mov dword [Int23Hook], __null_int23_exit_
.3:
        xor eax, eax
        mov al, byte [_Extender]
        cmp eax, byte 2
        jl short .4
        cmp eax, byte 8
        jg short .4
        mov cl, 23h
        mov dx, word [OldInt23Selector]
        mov eax, dword [OldInt23Offset]
        mov ebx, eax
        shl ebx, 10h
        mov bx, dx
        mov ax, 2505h
        int 21h
        mov cl, 23h
        mov dx, word [OldInt23RealSegment]
        mov eax, dword [OldInt23RealOffset]
        push ds
        mov ds, edx
        mov edx, eax
        mov ax, 2504h
        int 21h
        pop ds
        jmp short .6
.4:
        call __DPMI_hosted_
        cmp eax, byte 1
        jne short .5
        mov bl, 23h
        mov cx, word [OldInt23Selector]
        mov edx, dword [OldInt23Offset]
        mov ax, 201h
        int 31h
        mov bl, 23h
        mov cx, word [OldInt23RealSegment]
        mov edx, dword [OldInt23RealOffset]
        mov ax, 205h
        int 31h
        jmp short .6
.5:
        mov eax, 23h
        mov cx, word [OldInt23Selector]
        mov ebx, dword [OldInt23Offset]
        call _dos_setvect_
.6:
        xor ebx, ebx
        xor ebp, ebp
        mov word [OldInt23Selector], bx
        mov dword [OldInt23Offset], ebp
.7:
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
__restore_int23__F3:
        cmp ebx, __restore_int_ctrl_break_
        jne short __restore_int23__105
        mov dword [Int23Hook], __null_int23_exit_
__restore_int23__105:
        xor eax, eax
        mov al, byte [_Extender]
        cmp eax, byte 2
        jl short .8
        cmp eax, byte 8
        jg short .8
        mov cl, 1Bh
        mov dx, word [OldCtrlBreakSelector]
        mov eax, dword [OldCtrlBreakOffset]
        mov ebx, eax
        shl ebx, 10h
        mov bx, dx
        mov ax, 2505h
        int 21h
        mov cl, 1Bh
        mov dx, word [OldCtrlBreakRealSegment]
        mov eax, dword [OldCtrlBreakRealOffset]
        push ds
        mov ds, edx
        mov edx, eax
        mov ax, 2504h
        int 21h
        pop ds
        jmp short .10
.8:
        call __DPMI_hosted_
        cmp eax, byte 1
        jne short .9
        mov bl, 1Bh
        mov cx, word [OldCtrlBreakSelector]
        mov edx, dword [OldCtrlBreakOffset]
        mov ax, 201h
        int 31h
        mov bl, 1Bh
        mov cx, word [OldCtrlBreakRealSegment]
        mov edx, dword [OldCtrlBreakRealOffset]
        mov ax, 205h
        int 31h
        jmp short .10
.9:
        mov eax, 1Bh
        mov cx, word [OldCtrlBreakSelector]
        mov ebx, dword [OldCtrlBreakOffset]
        call _dos_setvect_
.10:
        xor ebx, ebx
        xor ebp, ebp
        mov word [OldCtrlBreakSelector], bx
        mov dword [OldCtrlBreakOffset], ebp
__restore_int23__1AC:
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; __restore_int_                                               13AE56  library
; Run-time library: restores the original Ctrl+Break handler
;-----------------------------------------------------------------------------
__restore_int_:
        call __restore_int23_
;-----------------------------------------------------------------------------
; __restore_int_ctrl_break_                                    13AE5B  library
;-----------------------------------------------------------------------------
__restore_int_ctrl_break_:
        push ebx
        push ecx
        push edx
        push ebp
        cmp dword [OldCtrlBreakOffset], byte 0
        jne short .1
        cmp word [OldCtrlBreakSelector], byte 0
        je short __restore_int23__1AC
.1:
        mov ebx, dword [Int23Hook]
        cmp ebx, __restore_int_
        jne near __restore_int23__F3
        mov dword [Int23Hook], __restore_int23_
        jmp near __restore_int23__105
;-----------------------------------------------------------------------------
; __grab_int23_                                                13AE93  library
; Run-time library: installs the Ctrl+C handler
;-----------------------------------------------------------------------------
__grab_int23_:
        push ebx
        push ecx
        push edx
        cmp dword [OldInt23Offset], byte 0
        jne near .5
        cmp word [OldInt23Selector], byte 0
        jne near .5
        xor eax, eax
        mov al, byte [_Extender]
        cmp eax, byte 2
        jl short .1
        cmp eax, byte 8
        jg short .1
        mov cl, 23h
        mov ax, 2503h
        int 21h
        mov cx, bx
        shr ebx, 10h
        mov edx, ebx
        mov word [OldInt23Selector], cx
        mov dword [OldInt23Offset], edx
        mov cl, 23h
        mov edx, __int23_handler_
        push es
        mov ax, 2502h
        int 21h
        mov cx, es
        pop es
        mov al, 23h
        mov word [OldInt23RealSegment], cx
        mov ecx, cs
        mov dword [OldInt23RealOffset], ebx
        push ds
        mov ds, ecx
        mov cl, al
        mov al, 6
        mov ah, 25h
        int 21h
        pop ds
        jmp short .3
.1:
        call __DPMI_hosted_
        cmp eax, byte 1
        jne short .2
        mov bl, 23h
        mov ax, 200h
        int 31h
        mov bl, 23h
        mov word [OldInt23Selector], cx
        mov dword [OldInt23Offset], edx
        mov ax, 204h
        int 31h
        mov bl, 23h
        mov word [OldInt23RealSegment], cx
        mov dword [OldInt23RealOffset], edx
        mov edx, __int23_handler_
        mov ecx, cs
        mov ax, 205h
        int 31h
        jmp short .3
.2:
        mov eax, 23h
        mov ebx, __int23_handler_
        call _dos_getvect_
        mov ecx, cs
        mov dword [OldInt23Offset], eax
        mov eax, 23h
        mov word [OldInt23Selector], dx
        call _dos_setvect_
.3:
        mov ebx, dword [Int23Hook]
        cmp ebx, __null_int23_exit_
        jne short .4
        mov dword [Int23Hook], __restore_int23_
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        cmp ebx, __restore_int_ctrl_break_
        jne short .5
        mov dword [Int23Hook], __restore_int_
.5:
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; __grab_int_ctrl_break_                                       13AFAE  library
; Run-time library: installs the Ctrl+Break handler
;-----------------------------------------------------------------------------
__grab_int_ctrl_break_:
        push ebx
        push ecx
        push edx
        cmp dword [OldCtrlBreakOffset], byte 0
        jne near .5
        cmp word [OldCtrlBreakSelector], byte 0
        jne near .5
        xor eax, eax
        mov al, byte [_Extender]
        cmp eax, byte 2
        jl short .1
        cmp eax, byte 8
        jg short .1
        mov cl, 1Bh
        mov ax, 2503h
        int 21h
        mov cx, bx
        shr ebx, 10h
        mov edx, ebx
        mov word [OldCtrlBreakSelector], cx
        mov dword [OldCtrlBreakOffset], edx
        mov cl, 1Bh
        mov edx, __int_ctrl_break_handler_
        push es
        mov ax, 2502h
        int 21h
        mov cx, es
        pop es
        mov al, 1Bh
        mov word [OldCtrlBreakRealSegment], cx
        mov ecx, cs
        mov dword [OldCtrlBreakRealOffset], ebx
        push ds
        mov ds, ecx
        mov cl, al
        mov al, 6
        mov ah, 25h
        int 21h
        pop ds
        jmp short .3
.1:
        call __DPMI_hosted_
        cmp eax, byte 1
        jne short .2
        mov bl, 1Bh
        mov ax, 200h
        int 31h
        mov bl, 1Bh
        mov word [OldCtrlBreakSelector], cx
        mov dword [OldCtrlBreakOffset], edx
        mov ax, 204h
        int 31h
        mov bl, 1Bh
        mov word [OldCtrlBreakRealSegment], cx
        mov dword [OldCtrlBreakRealOffset], edx
        mov edx, __int_ctrl_break_handler_
        mov ecx, cs
        mov ax, 205h
        int 31h
        jmp short .3
.2:
        mov eax, 1Bh
        mov ebx, __int_ctrl_break_handler_
        call _dos_getvect_
        mov ecx, cs
        mov dword [OldCtrlBreakOffset], eax
        mov eax, 1Bh
        mov word [OldCtrlBreakSelector], dx
        call _dos_setvect_
.3:
        mov ebx, dword [Int23Hook]
        cmp ebx, __null_int23_exit_
        jne short .4
        mov dword [Int23Hook], __restore_int_ctrl_break_
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        cmp ebx, __restore_int23_
        jne short .5
        mov dword [Int23Hook], __restore_int_
.5:
        pop edx
        pop ecx
        pop ebx
        ret
