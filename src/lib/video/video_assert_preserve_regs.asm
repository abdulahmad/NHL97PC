; Video: AssertPreserveRegs.
bits 32
%include "hockey.inc"
section s_13005A progbits alloc exec nowrite align=1
extern printf_, SavedEbx, SavedEcx, SavedEdi, SavedEdx, SavedEsi, SavedRetAddr
global AssertPreserveRegs
;-----------------------------------------------------------------------------
; AssertPreserveRegs                             13005A  97 PC, low confidence
; Saves the registers around the assertion report and restores them
;-----------------------------------------------------------------------------
AssertPreserveRegs:
        mov dword [SavedEbx], ebx
        mov dword [SavedEcx], ecx
        mov dword [SavedEdx], edx
        mov dword [SavedEsi], esi
        mov dword [SavedEdi], edi
        pop dword [SavedRetAddr]
        call printf_
        push dword [SavedRetAddr]
        mov ebx, dword [SavedEbx]
        mov ecx, dword [SavedEcx]
        mov edx, dword [SavedEdx]
        mov esi, dword [SavedEsi]
        mov edi, dword [SavedEdi]
        ret
