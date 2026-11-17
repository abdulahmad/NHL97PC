; Whistle stops and the score clock display.
bits 32
%include "hockey.inc"
section s_650E5 progbits alloc exec nowrite align=1
extern AudioDriverVersion, ClockDataBase, ClockDataRate, ClockDataTicks, CopyVec3, F32_4_UpdateScoreClockData, F32_8_UpdateScoreClockData, F64_0p0001_UpdateScoreClockData
extern F64_0p2_UpdateScoreClockData, F64_0p5_UpdateScoreClockData, F64_10000, F64_3p14159_UpdateGameDisplay, RefreshViewDistance, ReplayRecordBuf, ScoreClockShown, SetObjectHeight
extern SortCords, StartNextMove, UpdateScoreboardPos, UpdateScoreboardSpin
global StartWhistleStop, UpdateScoreClockData, ResetClockData, UpdateGameDisplay
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StartWhistleStop                                650E8  97 PC, low confidence
; Starts the stop animation when the whistle blows
;-----------------------------------------------------------------------------
StartWhistleStop:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 4
        mov ebx, dword [dword eax+0F6h]
        mov ebx, dword [ebx]
        mov edx, dword [byte ebx+028h]
        and edx, 0FFFFh
        cmp edx, 107h
        jl short .3
        cmp edx, 143h
        jge short .3
        lea ecx, [dword edx-0107h]
        test byte [dword eax+0C1h], 2
        je short .1
        test cl, 1
        jne short .3
        inc edx
        jmp short .2
.1:
        test cl, 1
        je short .3
        dec edx
.2:
        mov ecx, dword [dword eax+0FAh]
        mov ecx, dword [byte ecx+038h]
        mov esi, dword [byte ebx+04h]
        mov dword [esp], ecx
        mov ch, byte [dword eax+0BFh]
        mov ebx, dword [byte ebx+01Ch]
        test ch, 20h
        setne cl
        and ecx, 0FFh
        push ecx
        push esi
        push dword [byte esp+08h]
        call StartNextMove
.3:
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; UpdateScoreClockData                            65164  97 PC, low confidence
; Updates the clock and score data shown in game
;-----------------------------------------------------------------------------
UpdateScoreClockData:
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        fld dword [byte esi+020h]
        mov eax, 43960000h
        xor edi, edi
        fstp dword [edx]
        fld dword [byte esi+024h]
        mov dword [byte esp+0Ch], eax
        fstp dword [byte edx+04h]
        mov eax, dword [byte esi+028h]
        mov dword [byte edx+08h], eax
        mov eax, dword [byte esi+01Ch]
        mov dword [ebx], eax
        mov ah, byte [dword esi+0A4h]
        mov dword [byte esp+010h], edi
        cmp ah, 0Dh
        jne short .1
        mov eax, dword [dword esi+0FAh]
        mov ebx, dword [byte eax+08h]
        mov dword [byte eax+028h], ebx
.1:
        cmp dword [ScoreClockShown], byte 0
        je near .7
        cmp byte [dword esi+0A4h], 0Dh
        jae short .3
        cmp word [dword esi+0A9h], byte 0
        jl short .3
        mov eax, dword [dword esi+0F6h]
        mov eax, dword [eax]
        fild dword [byte eax+08h]
        mov ebx, dword [byte eax+0Ch]
        mov edi, dword [byte eax+08h]
        mov eax, dword [ReplayRecordBuf]
        sub ebx, edi
        sub eax, ebx
        mov dword [byte esp+08h], eax
        fstp dword [byte esp+0Ch]
        fild dword [byte esp+08h]
        fdiv dword [byte esp+0Ch]
        fldz
        fxch
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        jbe short .2
        xor eax, eax
        mov dword [byte esp+010h], eax
.2:
        fld dword [byte esp+010h]
        fcomp dword [F32_4_UpdateScoreClockData]
        fnstsw ax
        sahf
        jbe short .3
        mov dword [byte esp+010h], 40800000h
.3:
        fld dword [byte esp+0Ch]
        fcomp qword [F64_0p0001_UpdateScoreClockData]
        fnstsw ax
        sahf
        jb near .7
        mov edi, dword [AudioDriverVersion]
        test edi, edi
        je near .7
        test ecx, ecx
        je near .7
        mov eax, edi
        xor eax, edi
        mov dword [esp], edi
        mov dword [byte esp+04h], eax
        fild qword [esp]
        fmul dword [byte esp+0Ch]
        xor ebx, ebx
        mov dword [esp], ecx
        mov dword [byte esp+04h], ebx
        fild qword [esp]
        fmul qword [F64_10000]
        fdivrp
        fld dword [byte esp+010h]
        fxch
        fadd st1
        fldz
        fxch
        fstp st2
        fxch
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        jbe short .4
        mov dword [byte esp+010h], ebx
.4:
        fld dword [byte esp+010h]
        fcomp dword [F32_8_UpdateScoreClockData]
        fnstsw ax
        sahf
        jbe short .5
        mov dword [byte esp+010h], 41000000h
.5:
        cmp byte [dword esi+0A4h], 0Dh
        jne short .6
        fld dword [byte esp+010h]
        fld st0
        fld st0
        fmul qword [F64_0p2_UpdateScoreClockData]
        fxch st2
        fmul dword [byte esi+030h]
        fxch st2
        fmul qword [F64_0p5_UpdateScoreClockData]
        fxch st2
        fadd dword [byte edx+04h]
        mov eax, dword [dword esi+0FAh]
        fstp dword [byte edx+04h]
        fld dword [byte esi+02Ch]
        fsub st2
        fmul st1
        fadd dword [edx]
        fstp dword [edx]
        fld dword [byte esi+034h]
        fsubrp st2
        fmulp
        fadd dword [byte edx+08h]
        fstp dword [byte edx+08h]
        test dword [byte eax+0Ch], 7FFFFFFFh
        je short .7
        fld dword [byte esp+010h]
        fmul dword [byte eax+0Ch]
        fadd dword [byte eax+028h]
        fstp dword [byte eax+028h]
        jmp short .7
.6:
        fld dword [byte esp+010h]
        fld st0
        fmul dword [byte esi+02Ch]
        fadd dword [edx]
        fld st1
        fxch
        fstp dword [edx]
        fmul dword [byte esi+030h]
        fadd dword [byte edx+04h]
        fstp dword [byte edx+04h]
        fmul dword [byte esi+034h]
        fadd dword [byte edx+08h]
        fstp dword [byte edx+08h]
.7:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        ret
        db 090h
;-----------------------------------------------------------------------------
; ResetClockData                                  65338  97 PC, low confidence
; Clears the in-game clock data
;-----------------------------------------------------------------------------
ResetClockData:
        push ebx
        push edx
        push esi
        push edi
        sub esp, byte 8
        mov edx, eax
        mov ebx, dword [ClockDataTicks]
        mov dword [eax], ebx
        test dword [byte esp+01Ch], 7FFFFFFFh
        jne short .1
        mov edx, dword [ClockDataRate]
        mov dword [byte eax+04h], edx
        mov edx, dword [ClockDataBase]
        mov dword [byte eax+08h], edx
        jmp short .2
.1:
        lea edi, [byte esp+04h]
        mov esi, esp
        lea eax, [byte esp+01Ch]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [ClockDataRate]
        fmul dword [byte esp+04h]
        fstp dword [byte edx+04h]
        fld dword [ClockDataRate]
        fmul dword [esp]
        fstp dword [byte edx+08h]
.2:
        add esp, byte 8
        pop edi
        pop esi
        pop edx
        pop ebx
        ret 4
;-----------------------------------------------------------------------------
; UpdateGameDisplay                               6539C  97 PC, low confidence
; Updates the in-game display data each frame
;-----------------------------------------------------------------------------
UpdateGameDisplay:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 2Ch
        mov dword [byte ebp-04h], eax
        mov edi, SortCords
        xor esi, esi
.1:
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-08h]
        lea edx, [byte ebp-014h]
        mov eax, edi
        call UpdateScoreClockData
        cmp esi, byte 0Dh
        jne short .2
        mov eax, dword [dword edi+0FAh]
        push dword [byte eax+028h]
        lea eax, [byte ebp-020h]
        lea edx, [byte ebp-020h]
        call ResetClockData
        lea eax, [byte ebp-014h]
        call RefreshViewDistance
        jmp near .5
.2:
        cmp esi, byte 0Eh
        je short .3
        cmp esi, byte 0Fh
        jne short .4
.3:
        fld dword [byte ebp-014h]
        push eax
        fistp dword [esp]
        pop eax
        fld dword [byte ebp-0Ch]
        xor edx, edx
        mov dword [byte ebp-02Ch], eax
        mov dword [byte ebp-028h], edx
        push eax
        fistp dword [esp]
        pop eax
        mov dword [byte ebp-024h], eax
        cmp esi, byte 0Eh
        sete al
        lea edx, [byte ebp-02Ch]
        and eax, 0FFh
        call UpdateScoreboardPos
        fld dword [byte ebp-08h]
        fadd qword [F64_3p14159_UpdateGameDisplay]
        sub esp, byte 4
        fstp dword [esp]
        cmp esi, byte 0Eh
        sete al
        and eax, 0FFh
        call UpdateScoreboardSpin
        jmp short .5
.4:
        lea edx, [byte ebp-014h]
        mov eax, dword [dword edi+0F2h]
        call CopyVec3
        mov eax, dword [dword edi+0F2h]
        push dword [byte ebp-08h]
        call SetObjectHeight
.5:
        inc esi
        add edi, 108h
        cmp esi, byte 10h
        jl near .1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
