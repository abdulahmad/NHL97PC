; Video: ReadPortStable, WaitRetrace, WaitRetraceEdges, WaitDisplayRetrace, fprem_common.
bits 32
%include "hockey.inc"
section s_13C180 progbits alloc exec nowrite align=1
extern F64_0p5_fprem_common, F64_5p42101eneg20, FpremShiftTable, FpremTwoPi, RetraceTimeout
global ReadPortStable, WaitRetrace, WaitRetrace_2D, WaitRetraceEdges, WaitDisplayRetrace, fprem_common
;-----------------------------------------------------------------------------
; ReadPortStable                                 13C180  97 PC, low confidence
; Reads a port twice and returns the bits set in both reads
;-----------------------------------------------------------------------------
ReadPortStable:
        in al, dx
        LD mov, ah, al
        in al, dx
        LD and, al, ah
        ret
;-----------------------------------------------------------------------------
; WaitRetrace                                 13C187  96 PC, medium confidence
; Waits for the start of the next vertical retrace (port 3DAh bit 3), with a timeout
;-----------------------------------------------------------------------------
WaitRetrace:
        mov dx, 3DAh
        mov ecx, dword [RetraceTimeout]
        jmp short .2
.1:
        call ReadPortStable
        test al, 8
        loopne .1
        jecxz WaitRetrace_2D
.2:
        call ReadPortStable
        test al, 8
        loope .2
        jecxz WaitRetrace_2D
        mov dword [RetraceTimeout], 186A0h
        ret
WaitRetrace_2D:
        mov dword [RetraceTimeout], 2710h
        ret
;-----------------------------------------------------------------------------
; WaitRetraceEdges                                               13C1BF  96 PC
; Waits for the end and then the start of a vertical retrace, with a timeout
;-----------------------------------------------------------------------------
WaitRetraceEdges:
        mov dx, 3DAh
        mov ecx, dword [RetraceTimeout]
.1:
        call ReadPortStable
        test al, 8
        loopne .1
        jecxz WaitRetrace_2D
.2:
        call ReadPortStable
        test al, 8
        loope .2
        jecxz WaitRetrace_2D
        mov dword [RetraceTimeout], 186A0h
        ret
;-----------------------------------------------------------------------------
; WaitDisplayRetrace                                             13C1EA  96 PC
; Waits for display time and then the next retrace, with a timeout
;-----------------------------------------------------------------------------
WaitDisplayRetrace:
        mov dx, 3DAh
        mov ecx, dword [RetraceTimeout]
.3:
        call ReadPortStable
        test al, 8
        loope .3
        jecxz WaitRetrace_2D
.4:
        call ReadPortStable
        test al, 8
        loopne .4
        jecxz WaitRetrace_2D
        mov dword [RetraceTimeout], 186A0h
        ret
        mov dx, 3DAh
        call ReadPortStable
        and eax, byte 8
        shr eax, 3
        db 0C3h                                 ; insn: ret
        db 00h,00h,00h
;-----------------------------------------------------------------------------
; fprem_common                                                 13C228  library
; Run-time library: shared part of the checked x87 partial remainder
;-----------------------------------------------------------------------------
fprem_common:
        push eax
        push ebx
        push ecx
        mov eax, dword [byte esp+016h]
        xor eax, 700h
        test eax, 700h
        jne near .6
        shr eax, 0Bh
        and eax, byte 0Fh
        cmp byte [dword eax+FpremShiftTable], 0
        je near .6
        mov eax, dword [byte esp+016h]
        and eax, 7FFF0000h
        cmp eax, 7FFF0000h
        je near .6
        mov eax, dword [byte esp+02Eh]
        and eax, 7FFF0000h
        je near .6
        cmp eax, 7FFF0000h
        je near .6
        mov eax, dword [byte esp+02Ch]
        add eax, eax
        jne near .6
        mov eax, dword [byte esp+014h]
        add eax, eax
        jne near .6
        mov eax, dword [byte esp+018h]
        and eax, 7FFFh
        add eax, byte 3Fh
        mov ebx, dword [byte esp+030h]
        and ebx, 7FFFh
        sub ebx, eax
        ja short .2
.1:
        mov eax, dword [byte esp+018h]
        and eax, 7FFFh
        add eax, byte 0Ah
        mov ebx, dword [byte esp+030h]
        and ebx, 7FFFh
        sub ebx, eax
        js near .6
        fld tword [byte esp+028h]
        mov eax, dword [byte esp+018h]
        mov ebx, dword [byte esp+030h]
        and ebx, 7FFFh
        mov ecx, ebx
        sub ebx, eax
        and ebx, byte 7
        or ebx, byte 4
        sub ecx, ebx
        mov ebx, eax
        and ebx, 8000h
        or ecx, ebx
        mov dword [byte esp+018h], ecx
        fld tword [byte esp+010h]
        mov dword [byte esp+018h], eax
        fxch
        fprem
        fstp tword [byte esp+028h]
        fstp st0
        jmp short .1
.2:
        test edx, 2
        jne short .3
        fld tword [byte esp+010h]
        fstp tword [byte esp+01Ch]
.3:
        fnstcw word [byte esp+034h]
        mov eax, dword [byte esp+034h]
        or eax, 33Fh
        mov dword [byte esp+038h], eax
        fldcw word [byte esp+038h]
        mov eax, dword [byte esp+018h]
        and eax, 7FFFh
        mov ebx, dword [byte esp+030h]
        and ebx, 7FFFh
        sub ebx, eax
        and ebx, byte 3Fh
        or ebx, byte 20h
        add ebx, byte 1
        mov ecx, ebx
        mov eax, dword [byte esp+018h]
        mov ebx, dword [byte esp+030h]
        and ebx, 7FFFh
        and eax, 8000h
        or ebx, eax
        mov dword [byte esp+018h], ebx
        fld tword [byte esp+010h]
        fabs
        fld tword [byte esp+028h]
        fabs
.4:
        fcom
        fnstsw ax
        and eax, 100h
        jne short .5
        fsub st1
.5:
        fxch
        fmul qword [F64_0p5_fprem_common]
        fxch
        sub ecx, byte 1
        jne short .4
        mov ebx, dword [byte esp+030h]
        fstp tword [byte esp+028h]
        fstp st0
        fld tword [byte esp+01Ch]
        fld tword [FpremTwoPi]
        fprem
        fstp st0
        fld tword [byte esp+028h]
        fldcw word [byte esp+034h]
        and ebx, 8000h
        je short .7
        fchs
        jmp short .7
.6:
        fld tword [byte esp+010h]
        fld tword [byte esp+028h]
        fprem
.7:
        test edx, 3
        je short .9
        fnstsw word [byte esp+03Ch]
        test edx, 1
        je short .8
        fnstcw word [byte esp+034h]
        mov eax, dword [byte esp+034h]
        or eax, 300h
        mov dword [byte esp+038h], eax
        fldcw word [byte esp+038h]
        fmul qword [F64_5p42101eneg20]
        fldcw word [byte esp+034h]
.8:
        mov eax, dword [byte esp+03Ch]
        fxch
        fstp st0
        fld tword [byte esp+01Ch]
        fxch
        and eax, 4300h
        sub esp, byte 1Ch
        fnstenv [esp]
        and dword [byte esp+04h], 0BCFFh
        or dword [byte esp+04h], eax
        fldenv [esp]
        add esp, byte 1Ch
.9:
        pop ecx
        pop ebx
        pop eax
        ret
