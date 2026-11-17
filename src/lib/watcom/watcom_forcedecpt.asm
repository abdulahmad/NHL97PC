; Watcom C runtime: forcedecpt_, __cnvs2d_, NoFloatSupport, EmuZeroTbyte, EmuRegRing and 1 more.
bits 32
%include "hockey.inc"
section s_1327F6 progbits alloc exec nowrite align=1
extern __fatal_runtime_error_, EaDisp32, EaEax, EaEaxDisp32, EaEaxDisp8, EaEbpDisp32, EaEbpDisp8, EaEbx
extern EaEbxDisp32, EaEbxDisp8, EaEcx, EaEcxDisp32, EaEcxDisp8, EaEdi, EaEdiDisp32, EaEdiDisp8
extern EaEdx, EaEdxDisp32, EaEdxDisp8, EaEsi, EaEsiDisp32, EaEsiDisp8, EaEsp, EaEspDisp32
extern EaEspDisp8, EaSib, EmuDispatchD9Reg, EmuDispatchDBReg, EmuDispatchDFReg, EmuFaddM32, EmuFaddM64, EmuFaddp
extern EmuFaddSt, EmuFaddToSt, EmuFbld, EmuFbstp, EmuFcomM32, EmuFcomM64, EmuFcompM32, EmuFcompM64
extern EmuFcompp, EmuFcompSt, EmuFcomSt, EmuFdivM32, EmuFdivM64, EmuFdivp, EmuFdivrM32, EmuFdivrM64
extern EmuFdivrp, EmuFdivrSt, EmuFdivrToSt, EmuFdivSt, EmuFdivToSt, EmuFfree, EmuFiaddM16, EmuFiaddM32
extern EmuFicomM16, EmuFicomM32, EmuFicompM16, EmuFicompM32, EmuFidivM16, EmuFidivM32, EmuFidivrM16, EmuFidivrM32
extern EmuFildM16, EmuFildM32, EmuFildM64, EmuFimulM16, EmuFimulM32, EmuFistM16, EmuFistM32, EmuFistpM16
extern EmuFistpM32, EmuFistpM64, EmuFisubM16, EmuFisubM32, EmuFisubrM16, EmuFisubrM32, EmuFldcw, EmuFldenv
extern EmuFldM32, EmuFldM64, EmuFldM80, EmuFldSt, EmuFmulM32, EmuFmulM64, EmuFmulp, EmuFmulSt
extern EmuFmulToSt, EmuFrstor, EmuFsave, EmuFstcw, EmuFstenv, EmuFstM32, EmuFstM64, EmuFstpM32
extern EmuFstpM64, EmuFstpM80, EmuFstpSt, EmuFstSt, EmuFstswM16, EmuFsubM32, EmuFsubM64, EmuFsubp
extern EmuFsubrM32, EmuFsubrM64, EmuFsubrp, EmuFsubrSt, EmuFsubrToSt, EmuFsubSt, EmuFsubToSt, EmuFtstFxam
extern EmuFucom, EmuFucomp, EmuFucompp, EmuFxch, EmuLogOps, EmuRemOps, EmuReservedOp, EmuSignOps
extern EmuTrapExit, EmuUnsupported, str_FloatingPointSupportNot, strtod_
global forcedecpt_, __cnvs2d_, NoFloatSupport, EmuZeroTbyte, EmuRegRing, EmuRegTagMasks, EmuCompareCcBits, EmuFpremCcBits
global EmuEaModRmTable, EmuEaSibTable, EmuOpcodeJumpTable, EmuModRmJumpTable, NoFloatSupport_38D, NoFloatSupport_3FD
;-----------------------------------------------------------------------------
; forcedecpt_                                                  1327F6  library
; Run-time library: makes sure a formatted float has a decimal point
;-----------------------------------------------------------------------------
forcedecpt_:
        push ebx
        mov ebx, edx
        mov dl, byte [byte edx+014h]
        and dl, 1
        and edx, 0FFh
        jne short .6
.1:
        cmp byte [eax], 0
        je short .2
        xor edx, edx
        mov dl, byte [eax]
        cmp edx, byte 65h
        je short .2
        cmp edx, byte 45h
        je short .2
        inc eax
        jmp short .1
.2:
        mov edx, eax
        mov bl, byte [byte ebx+015h]
        and ebx, 0FFh
        dec eax
        cmp ebx, byte 47h
        je short .3
        cmp ebx, byte 67h
        jne short .4
.3:
        xor ebx, ebx
        mov bl, byte [eax]
        cmp ebx, byte 30h
        jne short .4
        dec eax
        jmp short .3
.4:
        xor ebx, ebx
        mov bl, byte [eax]
        cmp ebx, byte 2Eh
        je short .5
        inc eax
.5:
        mov bl, byte [edx]
        inc edx
        mov byte [eax], bl
        inc eax
        test bl, bl
        jne short .5
.6:
        pop ebx
        ret
;-----------------------------------------------------------------------------
; __cnvs2d_                                                    132855  library
; Run-time library: a decimal string to a double
;-----------------------------------------------------------------------------
__cnvs2d_:
        push ebx
        mov ebx, edx
        xor edx, edx
        call strtod_
        fstp qword [ebx]
        pop ebx
        ret
;-----------------------------------------------------------------------------
; NoFloatSupport                                 132863  97 PC, low confidence
; Reports that floating-point support is not loaded and exits
;-----------------------------------------------------------------------------
NoFloatSupport:
        push edx
        mov edx, 1
        mov eax, str_FloatingPointSupportNot
        call __fatal_runtime_error_
        pop edx
        ret
        db 00h,00h,00h
;-----------------------------------------------------------------------------
; EmuZeroTbyte                                   132878  97 PC, low confidence
; X87 emulator: an 80-bit zero loaded into a stack register
;-----------------------------------------------------------------------------
EmuZeroTbyte:                                   ; x87 emulator: an 80-bit zero loaded into a stack register;
                                                ; used by EmuFtstFxamJumpTable
        db 00h,00h,00h,00h
        db 00h,00h,00h,00h
        db 00h,00h
;-----------------------------------------------------------------------------
; EmuRegRing                                     132882  97 PC, low confidence
; X87 emulator: 8 ten-byte stack register records (next and previous register
; offsets, top-of-stack status bits)
;-----------------------------------------------------------------------------
EmuRegRing:                                     ; x87 emulator: 8 ten-byte stack register records (next and
                                                ; previous register offsets, top-of-stack status bits); used
                                                ; by EmuDispatchDFRegJumpTable, EmuFaddp, EmuFcomppJumpTable
                                                ; ...
        db 0Ah,00h
        db 046h,00h
        db 00h,00h,00h,00h,00h,00h,014h,00h,00h,00h,00h,08h,01h,00h,00h,00h
        db 01Eh,00h,0Ah,00h,00h,010h,02h,00h,00h,00h,028h,00h,014h,00h,00h,018h
        db 03h,00h,00h,00h,032h,00h,01Eh,00h,00h,020h,04h,00h,00h,00h,03Ch,00h
        db 028h,00h,00h,028h,05h,00h,00h,00h,046h,00h,032h,00h,00h,030h,06h,00h
        db 00h,00h,00h,00h,03Ch,00h,00h,038h,07h,00h,00h,00h
;-----------------------------------------------------------------------------
; EmuRegTagMasks                                 1328D2  97 PC, low confidence
; X87 emulator: 8 ten-byte tag word records per register (clear mask, then
; the valid, zero and empty tag bits)
;-----------------------------------------------------------------------------
EmuRegTagMasks:                                 ; x87 emulator: 8 ten-byte tag word records per register
                                                ; (clear mask, then the valid, zero and empty tag bits); used
                                                ; by EmuDispatchDFRegJumpTable, EmuExamine, EmuFaddp ...
        db 0FCh,0FFh
        db 01h,00h,00h,00h
        db 02h,00h
        db 03h,00h,0F3h,0FFh,04h,00h,00h,00h,08h,00h,0Ch,00h,0CFh,0FFh,010h,00h
        db 00h,00h,020h,00h,030h,00h,03Fh,0FFh,040h,00h,00h,00h,080h,00h,0C0h,00h
        db 0FFh,0FCh,00h,01h,00h,00h,00h,02h,00h,03h,0FFh,0F3h,00h,04h,00h,00h
        db 00h,08h,00h,0Ch,0FFh,0CFh,00h,010h,00h,00h,00h,020h,00h,030h,0FFh,03Fh
        db 00h,040h,00h,00h,00h,080h,00h,0C0h
EmuCompareCcBits:                               ; used by RoundToDouble
        db 01h,040h,00h,045h
EmuFpremCcBits:                                 ; used by EmuDispatchDFRegJumpTable, EmuRemOpsJumpTable
        db 00h,02h,040h,042h,01h,03h,041h,043h,087h,0DBh
EmuEaModRmTable:                                ; used by EmuTrapExit
        dd EaEax
        dd EaEcx
        dd EaEdx
        dd EaEbx
        dd EaSib
        dd EaDisp32
        dd EaEsi
        dd EaEdi
        dd EaEaxDisp8
        dd EaEcxDisp8
        dd EaEdxDisp8
        dd EaEbxDisp8
        dd EaSib
        dd EaEbpDisp8
        dd EaEsiDisp8
        dd EaEdiDisp8
        dd EaEaxDisp32
        dd EaEcxDisp32
        dd EaEdxDisp32
        dd EaEbxDisp32
        dd EaSib
        dd EaEbpDisp32
        dd EaEsiDisp32
        dd EaEdiDisp32
EmuEaSibTable:                                  ; used by EaSib
        dd EaEax
        dd EaEcx
        dd EaEdx
        dd EaEbx
        dd EaEsp
        dd EaDisp32
        dd EaEsi
        dd EaEdi
        dd EaEaxDisp8
        dd EaEcxDisp8
        dd EaEdxDisp8
        dd EaEbxDisp8
        dd EaEspDisp8
        dd EaEbpDisp8
        dd EaEsiDisp8
        dd EaEdiDisp8
        dd EaEaxDisp32
        dd EaEcxDisp32
        dd EaEdxDisp32
        dd EaEbxDisp32
        dd EaEspDisp32
        dd EaEbpDisp32
        dd EaEsiDisp32
        dd EaEdiDisp32
EmuOpcodeJumpTable:                             ; jump table for the switch cases of EmuTrapExit
        dd EmuFaddM32
        dd EmuFldM32
        dd EmuFiaddM32
        dd EmuFildM32
        dd EmuFaddM64
        dd EmuFldM64
        dd EmuFiaddM16
        dd EmuFildM16
        dd EmuFmulM32
        dd EmuUnsupported
        dd EmuFimulM32
        dd EmuUnsupported
        dd EmuFmulM64
        dd EmuUnsupported
        dd EmuFimulM16
        dd EmuUnsupported
        dd EmuFcomM32
        dd EmuFstM32
        dd EmuFicomM32
        dd EmuFistM32
        dd EmuFcomM64
        dd EmuFstM64
        dd EmuFicomM16
        dd EmuFistM16
        dd EmuFcompM32
        dd EmuFstpM32
        dd EmuFicompM32
        dd EmuFistpM32
        dd EmuFcompM64
        dd EmuFstpM64
        dd EmuFicompM16
        dd EmuFistpM16
        dd EmuFsubM32
        dd EmuFldenv
        dd EmuFisubM32
        dd EmuUnsupported
        dd EmuFsubM64
        dd EmuFrstor
        dd EmuFisubM16
        dd EmuFbld
        dd EmuFsubrM32
        dd EmuFldcw
        dd EmuFisubrM32
        dd EmuFldM80
        dd EmuFsubrM64
        dd EmuUnsupported
        dd EmuFisubrM16
        dd EmuFildM64
        dd EmuFdivM32
        dd EmuFstenv
        dd EmuFidivM32
        dd EmuUnsupported
        dd EmuFdivM64
        dd EmuFsave
        dd EmuFidivM16
        dd EmuFbstp
        dd EmuFdivrM32
        dd EmuFstcw
        dd EmuFidivrM32
        dd EmuFstpM80
        dd EmuFdivrM64
        dd EmuFstswM16
        dd EmuFidivrM16
        dd EmuFistpM64
EmuModRmJumpTable:                              ; jump table for the switch cases of EmuTrapExit
        dd EmuFaddSt
        dd EmuFldSt
        dd EmuReservedOp
        dd EmuReservedOp
        dd EmuFaddToSt
        dd EmuFfree
        dd EmuFaddp
        dd EmuFfree
        dd EmuFmulSt
        dd EmuFxch
        dd EmuReservedOp
        dd EmuReservedOp
        dd EmuFmulToSt
        dd EmuFxch
        dd EmuFmulp
        dd EmuFxch
        dd EmuFcomSt
        dd EmuDispatchD9Reg
        dd EmuReservedOp
        dd EmuReservedOp
        dd EmuFcomSt
        dd EmuFstSt
        dd EmuReservedOp
        dd EmuFstSt
        dd EmuFcompSt
        dd EmuFstpSt
        dd EmuReservedOp
        dd EmuReservedOp
        dd EmuFcompSt
        dd EmuFstpSt
        dd EmuFcompp
        dd EmuFstpSt
        dd EmuFsubSt
        dd EmuFtstFxam
        dd EmuReservedOp
        dd EmuDispatchDBReg
        dd EmuFsubrToSt
        dd EmuFucom
        dd EmuFsubrp
        dd EmuDispatchDFReg
        dd EmuFsubrSt
        dd EmuSignOps
        dd EmuFucompp
        dd EmuReservedOp
        dd EmuFsubToSt
        dd EmuFucomp
        dd EmuFsubp
        dd EmuReservedOp
        dd EmuFdivSt
        dd EmuLogOps
        dd EmuReservedOp
        dd EmuReservedOp
        dd EmuFdivrToSt
        dd EmuReservedOp
        dd EmuFdivrp
        dd EmuReservedOp
        dd EmuFdivrSt
        dd EmuRemOps
        dd EmuReservedOp
        dd EmuReservedOp
        dd EmuFdivToSt
        dd EmuReservedOp
        dd EmuFdivp
        dd EmuReservedOp
NoFloatSupport_38D:
        sti
        pusha
        LD mov, ebp, esp
        push dword [byte ebp+040h]
        push dword [byte ebp+044h]
        mov cx, word [byte ebp+03Ch]
        mov word [byte ebp-06h], cx
        mov ecx, dword [byte ebp+038h]
        mov dword [byte ebp+0Ch], ecx
        call EmuTrapExit
        pop ds
        pop es
        popa
        iret
        db 087h,0DBh,090h
        sti
        mov eax, dword [byte esp+0Ch]
        push dword [byte ss:eax+014h]
        push dword [byte ss:eax+010h]
        push eax
        push eax
        push eax
        push dword [ss:eax]
        push ecx
        push edx
        push ebx
        push dword [byte ss:eax+01Ch]
        LD mov, eax, ebp
        push eax
        push esi
        push edi
        push es
        push ds
        mov word [byte esp+02h], ss
        call EmuTrapExit
        pop ds
        pop es
        pop edi
        pop esi
        pop eax
        LD mov, ebp, eax
        pop eax
        pop ebx
        pop edx
        pop ecx
        pop eax
        xchg eax, dword [esp]
        pop dword [ss:eax]
        add esp, byte 8
        pop dword [byte ss:eax+010h]
        add esp, byte 4
        mov eax, dword [ss:eax]
        iret
        db 087h,0DBh
NoFloatSupport_3FD:
        sti
        sub esp, byte 0Ch
        push eax
        LD mov, eax, esp
        add eax, byte 1Ch
        push ecx
        push edx
        push ebx
        push eax
        push ebp
        push esi
        push edi
        push es
        push ds
        mov word [byte esp+02h], ss
        call EmuTrapExit
        pop ds
        pop es
        popa
        add esp, byte 0Ch
        iret
        db 090h
