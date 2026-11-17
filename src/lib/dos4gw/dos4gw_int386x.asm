; DOS/4GW: __int386x_, IntrLoadSegRegs, _DoINTR_, IntrLoadRegs.
bits 32
%include "hockey.inc"
section s_13201F progbits alloc exec nowrite align=1
global __int386x_, IntrLoadSegRegs, _DoINTR_, IntrLoadRegs, IntrStubs
        db 00h
;-----------------------------------------------------------------------------
; __int386x_                                                   132020  library
; Run-time library: inner part of int386x
;-----------------------------------------------------------------------------
__int386x_:
        push ebp
        push es
        push ebx
        push ds
        push edx
        call IntrLoadSegRegs
        push ds
        push edi
        mov ebp, esp
        mov edi, dword [byte ebp+08h]
        mov ds, word [byte ebp+0Ch]
        mov dword [edi], eax
        mov dword [byte edi+04h], ebx
        mov dword [byte edi+08h], ecx
        mov dword [byte edi+0Ch], edx
        mov dword [byte edi+010h], esi
        pop dword [byte edi+014h]
        sbb eax, eax
        mov dword [byte edi+018h], eax
        pop eax
        pop ebx
        pop ebx
        pop ebx
        mov word [byte ebx+06h], ax
        o16 mov word [ebx], es
        pop es
        pop ebp
        ret
;-----------------------------------------------------------------------------
; IntrLoadSegRegs                                132058  97 PC, low confidence
; Loads the register set and segment registers for a protected-mode interrupt
; call
;-----------------------------------------------------------------------------
IntrLoadSegRegs:
        lea esi, [esi+esi*2]
        lea eax, [dword cs:esi+IntrStubs]
        push eax
        mov es, word [ebx]
        mov bp, word [byte ebx+06h]
        mov eax, dword [edi]
        mov ebx, dword [byte edi+04h]
        mov ecx, dword [byte edi+08h]
        mov edx, dword [byte edi+0Ch]
        mov esi, dword [byte edi+010h]
        mov edi, dword [byte edi+014h]
        mov ds, ebp
        ret
;-----------------------------------------------------------------------------
; _DoINTR_                                                     13207D  library
; Run-time library: the intr call helper
;-----------------------------------------------------------------------------
_DoINTR_:
        pusha
        push gs
        push fs
        push es
        push ds
        push edx
        call IntrLoadRegs
        push ebx
        push ds
        push ebp
        mov ebp, esp
        mov ebx, dword [byte ebp+0Ch]
        mov ds, word [byte ebp+010h]
        mov dword [ebx], eax
        pushf
        pop eax
        mov word [byte ebx+024h], ax
        mov dword [byte ebx+08h], ecx
        mov dword [byte ebx+0Ch], edx
        mov dword [byte ebx+014h], esi
        mov dword [byte ebx+018h], edi
        pop dword [byte ebx+010h]
        pop eax
        mov word [byte ebx+01Ch], ax
        pop dword [byte ebx+04h]
        o16 mov word [byte ebx+01Eh], es
        o16 mov word [byte ebx+020h], fs
        o16 mov word [byte ebx+022h], gs
        add esp, byte 8
        pop es
        pop fs
        pop gs
        popa
        ret
;-----------------------------------------------------------------------------
; IntrLoadRegs                                   1320CA  97 PC, low confidence
; Loads the full register set from a REGPACK and selects the interrupt stub
; to call
;-----------------------------------------------------------------------------
IntrLoadRegs:
        and eax, 0FFh
        lea eax, [eax+eax*2]
        lea eax, [dword cs:eax+IntrStubs]
        push eax
        mov ebx, edx
        push dword [byte ebx+01Ch]
        mov eax, dword [ebx]
        mov ecx, dword [byte ebx+08h]
        mov edx, dword [byte ebx+0Ch]
        mov esi, dword [byte ebx+014h]
        mov edi, dword [byte ebx+018h]
        mov ebp, dword [byte ebx+010h]
        mov es, word [byte ebx+01Eh]
        mov fs, word [byte ebx+020h]
        mov gs, word [byte ebx+022h]
        mov ebx, dword [byte ebx+04h]
        pop ds
        ret
IntrStubs:                                      ; used by IntrLoadRegs, IntrLoadSegRegs
        db 0CDh,00h
        ret
