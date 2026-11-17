; DOS/4GW: int386_.
bits 32
%include "hockey.inc"
section s_126463 progbits alloc exec nowrite align=1
extern int386x_, segread_
global int386_
;-----------------------------------------------------------------------------
; int386_                                                      126463  library
; Run-time library int386: calls an interrupt
;-----------------------------------------------------------------------------
int386_:
        push ecx
        push esi
        sub esp, byte 0Ch
        mov esi, eax
        mov eax, esp
        mov ecx, esp
        call segread_
        mov eax, esi
        call int386x_
        add esp, byte 0Ch
        pop esi
        pop ecx
        ret
