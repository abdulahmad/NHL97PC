; EA library: SetScreenTarget.
bits 32
%include "hockey.inc"
section s_13C161 progbits alloc exec nowrite align=1
extern BackBufferWidth, ScreenWidth
global SetScreenTarget
        db 00h,00h,00h
;-----------------------------------------------------------------------------
; SetScreenTarget                                13C164  97 PC, low confidence
; Makes the screen the draw target again: copies the screen header
; (BackBufferWidth) to ScreenWidth
;-----------------------------------------------------------------------------
SetScreenTarget:
        LD mov, edx, edi
        LD mov, eax, esi
        mov esi, BackBufferWidth
        mov edi, ScreenWidth
        mov ecx, 0Dh
        rep movsd
        LD mov, edi, edx
        LD mov, esi, eax
        ret
        db 00h,00h
