; Watcom C runtime: sprintf_.
bits 32
%include "hockey.inc"
section s_FDDD4 progbits alloc exec nowrite align=1
extern __prtf_, DrawTextLimited, mem_putc_
global sprintf_
;-----------------------------------------------------------------------------
; sprintf_                                                      FDDD4  library
; Run-time library sprintf: formats into a string
;-----------------------------------------------------------------------------
sprintf_:
        push ebx
        push ecx
        push edx
        sub esp, byte 4
        lea eax, [byte esp+01Ch]
        mov ecx, mem_putc_
        mov ebx, esp
        mov edx, dword [byte esp+018h]
        mov dword [esp], eax
        mov eax, dword [byte esp+014h]
        call __prtf_
        mov edx, dword [byte esp+014h]
        mov byte [edx+eax], 0
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        push ebx
        sub esp, byte 10h
        mov eax, esp
        push eax
        lea eax, [byte esp+08h]
        push eax
        lea eax, [byte esp+010h]
        push eax
        lea eax, [byte esp+018h]
        push eax
        mov edx, dword [byte esp+02Ch]
        push edx
        mov ebx, dword [byte esp+02Ch]
        push ebx
        call DrawTextLimited
        add esp, byte 18h
        mov eax, dword [byte esp+04h]
        add esp, byte 10h
        pop ebx
        ret
