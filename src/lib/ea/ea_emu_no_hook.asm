; EA library: EmuNoHook.
bits 32
%include "hockey.inc"
section s_121DB9 progbits alloc exec nowrite align=1
global EmuNoHook
;-----------------------------------------------------------------------------
; EmuNoHook                                      121DB9  97 PC, low confidence
; Empty emulator hook
;-----------------------------------------------------------------------------
EmuNoHook:
        ret
