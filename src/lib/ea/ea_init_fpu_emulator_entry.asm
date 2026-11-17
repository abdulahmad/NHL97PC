; EA library: InitFpuEmulatorEntry, FiniFpuEmulatorEntry.
bits 32
%include "hockey.inc"
section s_FC210 progbits alloc exec nowrite align=1
extern __sys_fini_387_emulator, __sys_init_387_emulator
global InitFpuEmulatorEntry, FiniFpuEmulatorEntry
;-----------------------------------------------------------------------------
; InitFpuEmulatorEntry                            FC210  97 PC, low confidence
; Start-up table entry that starts the coprocessor emulator
;-----------------------------------------------------------------------------
InitFpuEmulatorEntry:
        jmp near __sys_init_387_emulator
;-----------------------------------------------------------------------------
; FiniFpuEmulatorEntry                            FC215  97 PC, low confidence
; Exit table entry that stops the coprocessor emulator
;-----------------------------------------------------------------------------
FiniFpuEmulatorEntry:
        jmp near __sys_fini_387_emulator
