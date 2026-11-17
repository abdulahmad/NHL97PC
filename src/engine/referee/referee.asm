; Referee animations: at the dot, faceoff, goal, whistle, signals and the goal line.
bits 32
%include "hockey.inc"
section s_72E57 progbits alloc exec nowrite align=1
extern F32_0p1_RefWhistleAnim, F64_1p5708_RefWhistleAnim, F64_3p14159_RefWhistleAnim, F64_6p28319_RefWhistleAnim, F64_neg3p14159_RefWhistleAnim, F64_neg6p28319_RefWhistleAnim, IF@DFMOD, PeriodOver
extern RefGoalLineAnims, ResetAnimTimer, SetModelHeading, SetSPA, SetSPAInPlace
global RefAtDotAnim, RefFaceoffAnim, RefGoalPaAnim, RefWhistleAnim, RefSignalAnim, RefGoalLineAnim
        db 090h
;-----------------------------------------------------------------------------
; RefAtDotAnim                                    72E58  97 PC, low confidence
; Assrefatdot's referee move: SPA 107h (SetSPAInPlace)
;-----------------------------------------------------------------------------
RefAtDotAnim:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov eax, dword [dword eax+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        mov ebx, 20h
        and ah, 0DFh
        mov edx, 107h
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F800000h
        call SetSPAInPlace
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RefFaceoffAnim                                  72E94  97 PC, low confidence
; Puckfaceoff2's referee move: SPA 143h, with the referee's two sprite flags
; (SetModelHeading)
;-----------------------------------------------------------------------------
RefFaceoffAnim:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov eax, dword [dword eax+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        mov edx, 143h
        or ah, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0F2h]
        xor ebx, ebx
        xor edx, edx
        call SetModelHeading
        mov ebx, 1
        mov eax, dword [dword ecx+0F2h]
        mov edx, ebx
        call SetModelHeading
        or byte [dword ecx+0BFh], 20h
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; RefGoalPaAnim                                   72EF4  97 PC, low confidence
; Assrefgoalpa's referee move: SPA 144h
;-----------------------------------------------------------------------------
RefGoalPaAnim:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov eax, dword [dword eax+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        mov edx, 144h
        or ah, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        or byte [dword ecx+0BFh], 20h
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RefWhistleAnim                                  72F34  97 PC, low confidence
; Assrefwhistle's referee move, PeriodOver aware
;-----------------------------------------------------------------------------
RefWhistleAnim:
        push ebx
        push ecx
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        fld dword [byte eax+01Ch]
        fsubr qword [F64_1p5708_RefWhistleAnim]
        mov edx, dword [dword eax+0FAh]
        fld qword [F64_6p28319_RefWhistleAnim]
        fxch
        call IF@DFMOD
        fst dword [byte esp+010h]
        fst qword [esp]
        fcomp qword [F64_3p14159_RefWhistleAnim]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [esp]
        fadd qword [F64_neg6p28319_RefWhistleAnim]
        fstp dword [byte esp+010h]
.1:
        fld dword [byte esp+010h]
        fst qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_RefWhistleAnim]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+08h]
        fadd qword [F64_6p28319_RefWhistleAnim]
        fstp dword [byte esp+010h]
.2:
        mov eax, edx
        call ResetAnimTimer
        fld dword [byte esp+010h]
        fmul dword [F32_0p1_RefWhistleAnim]
        fstp dword [byte edx+0Ch]
        mov ah, byte [dword ecx+0BFh]
        xor ebx, ebx
        or ah, 20h
        mov edx, 145h
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        or byte [dword ecx+0BFh], 24h
        call PeriodOver
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; RefSignalAnim                                   72FE8  97 PC, low confidence
; Assrefsignal's referee move: SPA 146h
;-----------------------------------------------------------------------------
RefSignalAnim:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov eax, dword [dword eax+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        mov edx, 146h
        or ah, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        or byte [dword ecx+0BFh], 20h
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RefGoalLineAnim                                 73028  97 PC, low confidence
; (ref, n) assrefgoalline's referee move: SPA from table RefGoalLineAnims
;-----------------------------------------------------------------------------
RefGoalLineAnim:
        push ebx
        push ecx
        mov ecx, eax
        mov edx, dword [nosplit edx*4+RefGoalLineAnims]
        mov eax, dword [dword eax+0FAh]
        test edx, edx
        jl short .1
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        or ah, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        or byte [dword ecx+0BFh], 20h
.1:
        pop ecx
        pop ebx
        ret
