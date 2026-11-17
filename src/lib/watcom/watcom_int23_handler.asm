; Watcom C runtime: __int23_handler_, __int_ctrl_break_handler_.
bits 32
%include "hockey.inc"
section s_13AB04 progbits alloc exec nowrite align=1
extern __null_int23_exit_, __restore_int23_, __restore_int_ctrl_break_, _chain_intr_, _STACKLOW, BreakHandlerRegs, BreakHandlerStack, BreakSaveStack
extern Int23Hook, OldCtrlBreakOffset, OldCtrlBreakSelector, OldInt23Offset, OldInt23Selector, raise_, RestoreDS
global __int23_handler_, __int23_handler__70, __int23_handler__75, __int_ctrl_break_handler_
;-----------------------------------------------------------------------------
; __int23_handler_                                             13AB04  library
; Run-time library: the Ctrl+C (int 23h) handler
;-----------------------------------------------------------------------------
__int23_handler_:
        pusha
        push ds
        push es
        push fs
        push gs
        mov ebp, esp
        cld
        call RestoreDS
        mov eax, BreakHandlerStack
        mov edx, ds
        mov bx, ss
        mov ecx, esp
        mov ss, edx
        mov esp, eax
        mov dx, bx
        mov eax, ecx
        mov esi, dword [_STACKLOW]
        mov edi, dword [BreakSaveStack]
        mov ecx, edx
        mov edx, BreakHandlerRegs
        mov ebx, eax
        mov dword [_STACKLOW], edx
        test edi, edi
        jne short .1
        mov eax, dword [Int23Hook]
        cmp eax, __null_int23_exit_
        je short .1
        cmp eax, __restore_int_ctrl_break_
        je short .1
        mov eax, 4
        sti
        cld
        call raise_
        jmp short __int23_handler__75
.1:
        mov dx, word [OldInt23Selector]
        mov eax, dword [OldInt23Offset]
__int23_handler__70:
        call _chain_intr_
__int23_handler__75:
        mov edx, ecx
        mov eax, ebx
        mov bx, ss
        mov ecx, esp
        mov ss, edx
        mov esp, eax
        mov dx, bx
        mov eax, ecx
        mov dword [_STACKLOW], esi
        pop gs
        pop fs
        pop es
        pop ds
        popa
        iret
;-----------------------------------------------------------------------------
; __int_ctrl_break_handler_                                    13AB99  library
; Run-time library: the Ctrl+Break handler
;-----------------------------------------------------------------------------
__int_ctrl_break_handler_:
        pusha
        push ds
        push es
        push fs
        push gs
        mov ebp, esp
        cld
        call RestoreDS
        mov eax, BreakHandlerStack
        mov edx, ds
        mov bx, ss
        mov ecx, esp
        mov ss, edx
        mov esp, eax
        mov dx, bx
        mov eax, ecx
        mov esi, dword [_STACKLOW]
        mov edi, dword [BreakSaveStack]
        mov ecx, edx
        mov edx, BreakHandlerRegs
        mov ebx, eax
        mov dword [_STACKLOW], edx
        test edi, edi
        jne short .1
        mov eax, dword [Int23Hook]
        cmp eax, __null_int23_exit_
        je short .1
        cmp eax, __restore_int23_
        je short .1
        mov eax, 7
        sti
        cld
        call raise_
        jmp near __int23_handler__75
.1:
        mov dx, word [OldCtrlBreakSelector]
        mov eax, dword [OldCtrlBreakOffset]
        jmp near __int23_handler__70
