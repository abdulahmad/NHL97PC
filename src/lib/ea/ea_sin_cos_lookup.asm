; EA library: SinCosLookup.
bits 32
%include "hockey.inc"
section s_12F270 progbits alloc exec nowrite align=1
extern CosTable, SerialPorts, SinCosTable, SinTable, str_BK
global SinCosLookup
;-----------------------------------------------------------------------------
; SinCosLookup                                   12F270  97 PC, low confidence
; Returns the sine and cosine of an angle from the quarter-wave tables
;-----------------------------------------------------------------------------
SinCosLookup:
        push ebx
        mov eax, dword [byte esp+08h]
        mov ebx, dword [byte esp+0Ch]
        mov ecx, dword [byte esp+010h]
        movzx eax, ax
        and ah, 3
        jnp short .1
        jne short .3
        mov edx, dword [nosplit eax*4+SinTable]
        mov dword [ebx], edx
        neg eax
        mov edx, dword [nosplit eax*4+CosTable]
        mov dword [ecx], edx
        pop ebx
        ret
.1:
        dec ah
        jne short .2
        neg eax
        mov edx, dword [nosplit eax*4+CosTable]
        mov dword [ebx], edx
        neg eax
        mov edx, dword [nosplit eax*4+SinTable]
        neg edx
        mov dword [ecx], edx
        pop ebx
        ret
.2:
        mov edx, dword [nosplit eax*4+SinCosTable]
        neg edx
        mov dword [ebx], edx
        neg eax
        mov edx, dword [nosplit eax*4+str_BK]
        neg edx
        mov dword [ecx], edx
        pop ebx
        ret
.3:
        neg eax
        mov edx, dword [nosplit eax*4+SerialPorts+7A6h]
        neg edx
        mov dword [ebx], edx
        neg eax
        LD xor, ah, ah
        mov edx, dword [nosplit eax*4+SinTable]
        mov dword [ecx], edx
        pop ebx
        db 0C3h                                 ; insn: ret
