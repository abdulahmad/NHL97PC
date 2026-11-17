; EA library: ResetMemLock, MemLock, MemUnlock.
bits 32
%include "hockey.inc"
section s_12145E progbits alloc exec nowrite align=1
extern MemLockState
global ResetMemLock, MemLock, MemUnlock
        db 00h,00h
;-----------------------------------------------------------------------------
; ResetMemLock                                   121460  97 PC, low confidence
; Clears the memory lock and returns its address
;-----------------------------------------------------------------------------
ResetMemLock:
        xor edx, edx
        mov eax, MemLockState
        mov dword [MemLockState], edx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; MemLock                                        121470  97 PC, low confidence
; Sets the memory lock; followed by the try-lock
;-----------------------------------------------------------------------------
MemLock:
        mov eax, dword [byte esp+04h]
        mov dword [eax], 1
        ret
        db 090h
        mov eax, dword [byte esp+04h]
        cmp dword [eax], byte 0
        je short .1
        xor eax, eax
        ret
.1:
        mov dword [eax], 1
        mov eax, 1
        ret
;-----------------------------------------------------------------------------
; MemUnlock                                      121494  97 PC, low confidence
; Clears the memory lock
;-----------------------------------------------------------------------------
MemUnlock:
        mov eax, dword [byte esp+04h]
        mov dword [eax], 0
        ret
