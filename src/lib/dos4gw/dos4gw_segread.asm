; DOS/4GW: segread_, int386x_.
bits 32
%include "hockey.inc"
section s_11BF84 progbits alloc exec nowrite align=1
extern __int386x_
global segread_, int386x_
;-----------------------------------------------------------------------------
; segread_                                                     11BF84  library
; Run-time library segread: reads the segment registers
;-----------------------------------------------------------------------------
segread_:
        push edx
        mov edx, eax
        mov eax, cs
        mov word [byte edx+02h], ax
        mov eax, ds
        mov word [byte edx+06h], ax
        mov eax, es
        mov word [edx], ax
        mov eax, ss
        mov word [byte edx+04h], ax
        mov eax, fs
        mov word [byte edx+08h], ax
        mov eax, gs
        mov word [byte edx+0Ah], ax
        pop edx
        ret
;-----------------------------------------------------------------------------
; int386x_                                                     11BFAC  library
; Run-time library int386x: calls an interrupt with segment registers
;-----------------------------------------------------------------------------
int386x_:
        push esi
        push edi
        push ebp
        mov edi, edx
        mov ebp, ebx
        mov ebx, ecx
        mov edx, ebp
        mov esi, eax
        call __int386x_
        mov eax, dword [byte ebp+00h]
        pop ebp
        pop edi
        pop esi
        ret
