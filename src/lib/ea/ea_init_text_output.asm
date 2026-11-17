; EA library: InitTextOutput, ClearNumLock.
bits 32
%include "hockey.inc"
section s_130694 progbits alloc exec nowrite align=1
extern BreakCallFunc, DebugTagStr, FreeTextBuffers, KbdPeekKey, MakeColor, RestoreDS, SelectFont, SetTextColors
extern TextOriginX, ZeroMem
global InitTextOutput, ClearNumLock, ClearNumLock_F
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; InitTextOutput                                 1306A0  97 PC, low confidence
; Clears the text output state, sets its default colours and frees old text
; buffers
;-----------------------------------------------------------------------------
InitTextOutput:
        push dword 0ACh
        push TextOriginX
        call ZeroMem
        add esp, byte 8
        push DebugTagStr
        call SelectFont
        add esp, byte 4
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push eax
        call SetTextColors
        add esp, byte 8
        ret
        db 08Dh,040h,00h
        call FreeTextBuffers
        push dword 0ACh
        push TextOriginX
        call ZeroMem
        add esp, byte 8
        ret
        or byte [0417h], 20h
        call KbdPeekKey
        ret
;-----------------------------------------------------------------------------
; ClearNumLock                                   130709  97 PC, low confidence
; Clears the BIOS Num Lock flag; followed by the real-mode Ctrl-Break stub
; that calls the installed handler
;-----------------------------------------------------------------------------
ClearNumLock:
        and byte [0417h], 0DFh
        call KbdPeekKey
        ret
        db 00h,00h
ClearNumLock_F:
        sti
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        push ds
        push es
        push fs
        push gs
        call RestoreDS
        call dword [cs:BreakCallFunc]
        pop gs
        pop fs
        pop es
        pop ds
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        iret
