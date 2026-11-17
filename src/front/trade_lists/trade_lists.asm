; Trade lists: team and player comparisons.
bits 32
%include "hockey.inc"
section s_D0D56 progbits alloc exec nowrite align=1
extern __CHP, AllocMemBlock, DrawRatingBars_157, F64_2_BuildTradePlayerLists, FindPlayerStat, FindTeamStat, FreeMemBlock, qsort_
extern RosterData, RosterFreeAgents, RosterMode, RosterScrollList, str_Aiplayers, str_Statgoalies, str_Statplayers
global CompareFirstDword, CompareTeamGoalsFor, CompareTeamGoalsAgainst, CompareTeamPowerPlay, CompareTeamPenaltyKill, CompareTeamShots, ComparePlayerGoals, ComparePlayerAssists
global CompareGoalieAverage, ComparePlayerOffence, ComparePlayerDefence, BuildTradePlayerLists, str_Xx00xx01xx02xx03xx10xx11xx12, str_G0LWC0RWLDRD
;-----------------------------------------------------------------------------
; CompareFirstDword                            D0D56  97 PC, medium confidence
; Qsort compare: the first dword of the two entries, ascending
;-----------------------------------------------------------------------------
CompareFirstDword:
        push ebx
        mov ebx, dword [eax]
        cmp ebx, dword [edx]
        jge short .1
        mov eax, 0FFFFFFFFh
        pop ebx
        ret
.1:
        jle short .2
        mov eax, 1
        pop ebx
        ret
.2:
        xor eax, eax
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CompareTeamGoalsFor                             D0D71  97 PC, low confidence
; Sort helper: compares the first team stat (goals for, probably)
;-----------------------------------------------------------------------------
CompareTeamGoalsFor:
        push ebx
        mov ebx, dword [byte eax+04h]
        cmp ebx, dword [byte edx+04h]
        jge short .1
        mov eax, 0FFFFFFFFh
        pop ebx
        ret
.1:
        jle short .2
        mov eax, 1
        pop ebx
        ret
.2:
        xor eax, eax
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CompareTeamGoalsAgainst                         D0D8E  97 PC, low confidence
; Sort helper: compares the second team stat (goals against, probably)
;-----------------------------------------------------------------------------
CompareTeamGoalsAgainst:
        push ebx
        mov ebx, dword [byte eax+08h]
        cmp ebx, dword [byte edx+08h]
        jge short .1
        mov eax, 0FFFFFFFFh
        pop ebx
        ret
.1:
        jle short .2
        mov eax, 1
        pop ebx
        ret
.2:
        xor eax, eax
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CompareTeamPowerPlay                            D0DAB  97 PC, low confidence
; Sort helper: compares the third team stat (power play, probably)
;-----------------------------------------------------------------------------
CompareTeamPowerPlay:
        push ebx
        mov ebx, dword [byte eax+0Ch]
        cmp ebx, dword [byte edx+0Ch]
        jge short .1
        mov eax, 0FFFFFFFFh
        pop ebx
        ret
.1:
        jle short .2
        mov eax, 1
        pop ebx
        ret
.2:
        xor eax, eax
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CompareTeamPenaltyKill                          D0DC8  97 PC, low confidence
; Sort helper: compares the fourth team stat (penalty kill, probably)
;-----------------------------------------------------------------------------
CompareTeamPenaltyKill:
        push ebx
        mov ebx, dword [byte eax+010h]
        cmp ebx, dword [byte edx+010h]
        jge short .1
        mov eax, 0FFFFFFFFh
        pop ebx
        ret
.1:
        jle short .2
        mov eax, 1
        pop ebx
        ret
.2:
        xor eax, eax
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CompareTeamShots                                D0DE5  97 PC, low confidence
; Sort helper: compares the fifth team stat (shots, probably)
;-----------------------------------------------------------------------------
CompareTeamShots:
        push ebx
        mov ebx, dword [byte eax+014h]
        cmp ebx, dword [byte edx+014h]
        jge short .1
        mov eax, 0FFFFFFFFh
        pop ebx
        ret
.1:
        jle short .2
        mov eax, 1
        pop ebx
        ret
.2:
        xor eax, eax
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ComparePlayerGoals                              D0E02  97 PC, low confidence
; Sort helper: compares players by goals (probably)
;-----------------------------------------------------------------------------
ComparePlayerGoals:
        push ebx
        mov bx, word [byte eax+01Eh]
        cmp bx, word [byte edx+01Eh]
        jge short .1
        mov eax, 0FFFFFFFFh
        pop ebx
        ret
.1:
        jle short .2
        mov eax, 1
        pop ebx
        ret
.2:
        xor eax, eax
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ComparePlayerAssists                            D0E21  97 PC, low confidence
; Sort helper: compares players by assists (probably)
;-----------------------------------------------------------------------------
ComparePlayerAssists:
        push ebx
        mov bx, word [byte eax+020h]
        cmp bx, word [byte edx+020h]
        jge short .1
        mov eax, 0FFFFFFFFh
        pop ebx
        ret
.1:
        jle short .2
        mov eax, 1
        pop ebx
        ret
.2:
        xor eax, eax
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CompareGoalieAverage                            D0E40  97 PC, low confidence
; Sort helper: compares goalies by games and save rate
;-----------------------------------------------------------------------------
CompareGoalieAverage:
        push ebx
        push ecx
        mov ecx, 3E8h
        movsx ebx, word [byte eax+030h]
        movsx eax, word [byte eax+018h]
        sub ecx, ebx
        imul eax, ecx
        movsx ebx, word [byte edx+030h]
        mov ecx, 3E8h
        movsx edx, word [byte edx+018h]
        sub ecx, ebx
        imul edx, ecx
        cmp eax, edx
        jge short .1
        mov eax, 1
        pop ecx
        pop ebx
        ret
.1:
        jle short .2
        mov eax, 0FFFFFFFFh
        pop ecx
        pop ebx
        ret
.2:
        xor eax, eax
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ComparePlayerOffence                            D0E81  97 PC, low confidence
; Sort helper: compares players by their offence ratings
;-----------------------------------------------------------------------------
ComparePlayerOffence:
        push ebx
        push ecx
        movzx ecx, byte [byte eax+01Ah]
        movzx ebx, byte [byte eax+013h]
        add ecx, ebx
        movzx ebx, byte [byte eax+015h]
        movzx eax, byte [byte edx+01Ah]
        add ebx, ecx
        movzx ecx, byte [byte edx+013h]
        movzx edx, byte [byte edx+015h]
        add eax, ecx
        add eax, edx
        cmp ebx, eax
        jge short .1
        mov eax, 0FFFFFFFFh
        pop ecx
        pop ebx
        ret
.1:
        jle short .2
        mov eax, 1
        pop ecx
        pop ebx
        ret
.2:
        xor eax, eax
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ComparePlayerDefence                            D0EBE  97 PC, low confidence
; Sort helper: compares players by their defence ratings
;-----------------------------------------------------------------------------
ComparePlayerDefence:
        push ebx
        push ecx
        push esi
        movzx ecx, byte [byte eax+011h]
        movzx ebx, byte [byte eax+012h]
        movzx esi, byte [byte eax+01Ah]
        add ebx, ecx
        add esi, ebx
        movzx ebx, byte [byte eax+015h]
        movzx eax, byte [byte edx+012h]
        add ecx, eax
        movzx eax, byte [byte edx+01Ah]
        add ecx, eax
        movzx eax, byte [byte edx+015h]
        add ebx, esi
        add eax, ecx
        cmp ebx, eax
        jge short .1
        mov eax, 0FFFFFFFFh
        pop esi
        pop ecx
        pop ebx
        ret
.1:
        jle short .2
        mov eax, 1
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        xor eax, eax
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; BuildTradePlayerLists                           D0F07  97 PC, low confidence
; From the roster screen (SaveTrades): allocates and sorts "aiplayers",
; "statplayers" and "statgoalies" (qsort with CompareFirstDword-ComparePlayerDefence)
;-----------------------------------------------------------------------------
BuildTradePlayerLists:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 360h, 0
        push byte 0
        push dword 3CFh
        push str_Aiplayers
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 5F5h
        push str_Statplayers
        mov dword [byte ebp-08h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 0B7h
        push str_Statgoalies
        mov dword [byte ebp-04h], 0
        mov dword [byte ebp-0Ch], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp-010h], eax
        jmp short .5
.1:
        imul edx, eax, dword 194Fh
        shl eax, 2
        cmp dword [RosterMode], byte 0
        jne short .2
        mov ebx, dword [RosterData]
        add ebx, 0DF4h
        jmp short .3
.2:
        cmp dword [RosterFreeAgents], byte 0
        je short .4
        mov ebx, dword [RosterFreeAgents]
.3:
        add edx, ebx
        mov dword [dword eax+ebp-088h], edx
.4:
        inc dword [byte ebp-04h]
.5:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [RosterScrollList]
        jl short .1
        mov dword [byte ebp-04h], 0
        jmp near .29
.6:
        imul eax, byte 1Ch
        mov edx, dword [byte ebp-04h]
        xor ebx, ebx
        mov esi, dword [dword ebp+edx*4-088h]
        mov dword [dword eax+ebp-0348h], edx
        jmp short .8
.7:
        imul edx, ebx, byte 27h
        imul edi, ebx, byte 38h
        lea eax, [dword esi+0D09h]
        add edi, eax
        add edx, dword [byte ebp-08h]
        lea eax, [byte edi+028h]
        call FindPlayerStat
        imul edx, ebx, byte 3Dh
        lea eax, [byte edi+020h]
        add edx, dword [byte ebp-0Ch]
        call FindTeamStat
        inc ebx
.8:
        movsx eax, word [dword esi+0D05h]
        cmp ebx, eax
        jl short .7
        lea edi, [dword esi+01283h]
        xor ebx, ebx
        jmp short .10
.9:
        imul edx, ebx, byte 3Dh
        imul eax, ebx, byte 38h
        add eax, edi
        add edx, dword [byte ebp-010h]
        add eax, byte 20h
        inc ebx
        call FindTeamStat
.10:
        movsx eax, word [dword esi+01281h]
        cmp ebx, eax
        jl short .9
        imul eax, dword [byte ebp-04h], byte 1Ch
        mov ecx, ComparePlayerGoals
        mov ebx, 3Dh
        mov dword [dword eax+ebp-0360h], 0
        mov eax, dword [byte ebp-0Ch]
        movsx edx, word [dword esi+0D05h]
        call qsort_
        xor eax, eax
        imul ebx, dword [byte ebp-04h], byte 1Ch
.11:
        imul edi, eax, byte 3Dh
        add edi, dword [byte ebp-0Ch]
        movsx edx, word [byte edi+01Eh]
        lea edx, [edx+edx*2]
        inc eax
        add dword [dword ebx+ebp-0360h], edx
        cmp eax, byte 5
        jl short .11
        mov eax, 5
        imul ebx, dword [byte ebp-04h], byte 1Ch
.12:
        imul edi, eax, byte 3Dh
        add edi, dword [byte ebp-0Ch]
        movsx edx, word [byte edi+01Eh]
        add edx, edx
        inc eax
        add dword [dword ebx+ebp-0360h], edx
        cmp eax, byte 0Ah
        jl short .12
        mov eax, 0Ah
        imul ebx, dword [byte ebp-04h], byte 1Ch
        jmp short .14
.13:
        imul edi, eax, byte 3Dh
        add edi, dword [byte ebp-0Ch]
        movsx edx, word [byte edi+01Eh]
        inc eax
        add dword [dword ebx+ebp-0360h], edx
.14:
        movsx edx, word [dword esi+0D05h]
        cmp eax, edx
        jl short .13
        mov ecx, ComparePlayerDefence
        mov eax, dword [byte ebp-08h]
        mov dword [dword ebx+ebp-035Ch], 0
        mov ebx, 27h
        movsx edx, word [dword esi+0D05h]
        call qsort_
        xor eax, eax
        imul edi, dword [byte ebp-04h], byte 1Ch
.15:
        imul ebx, eax, byte 27h
        add ebx, dword [byte ebp-08h]
        movzx edx, byte [byte ebx+012h]
        mov dword [byte ebp-018h], edx
        mov ecx, dword [byte ebp-018h]
        movzx edx, byte [byte ebx+011h]
        add ecx, edx
        movzx edx, byte [byte ebx+01Ah]
        add ecx, edx
        movzx edx, byte [byte ebx+015h]
        add edx, ecx
        inc eax
        lea edx, [edx+edx*2]
        add dword [dword edi+ebp-035Ch], edx
        cmp eax, byte 5
        jl short .15
        mov eax, 5
        imul edi, dword [byte ebp-04h], byte 1Ch
.16:
        imul ebx, eax, byte 27h
        add ebx, dword [byte ebp-08h]
        movzx edx, byte [byte ebx+012h]
        mov dword [byte ebp-018h], edx
        mov ecx, dword [byte ebp-018h]
        movzx edx, byte [byte ebx+011h]
        add ecx, edx
        movzx edx, byte [byte ebx+01Ah]
        movzx ebx, byte [byte ebx+015h]
        add edx, ecx
        add edx, ebx
        inc eax
        add edx, edx
        add dword [dword edi+ebp-035Ch], edx
        cmp eax, byte 0Ah
        jl short .16
        mov eax, 0Ah
        imul ebx, dword [byte ebp-04h], byte 1Ch
        jmp short .18
.17:
        imul edi, eax, byte 27h
        add edi, dword [byte ebp-08h]
        movzx edx, byte [byte edi+012h]
        mov dword [byte ebp-018h], edx
        movzx edx, byte [byte edi+011h]
        movzx ecx, byte [byte edi+01Ah]
        add edx, dword [byte ebp-018h]
        add ecx, edx
        movzx edx, byte [byte edi+015h]
        inc eax
        add edx, ecx
        add dword [dword ebx+ebp-035Ch], edx
.18:
        movsx edx, word [dword esi+0D05h]
        cmp eax, edx
        jl short .17
        mov ecx, ComparePlayerOffence
        mov eax, dword [byte ebp-08h]
        mov dword [dword ebx+ebp-0358h], 0
        mov ebx, 27h
        movsx edx, word [dword esi+0D05h]
        call qsort_
        xor eax, eax
        imul edi, dword [byte ebp-04h], byte 1Ch
.19:
        imul ebx, eax, byte 27h
        add ebx, dword [byte ebp-08h]
        movzx edx, byte [byte ebx+013h]
        mov dword [byte ebp-018h], edx
        mov ecx, dword [byte ebp-018h]
        movzx edx, byte [byte ebx+01Ah]
        add ecx, edx
        movzx edx, byte [byte ebx+015h]
        add edx, ecx
        inc eax
        lea edx, [edx+edx*2]
        add dword [dword edi+ebp-0358h], edx
        cmp eax, byte 5
        jl short .19
        mov eax, 5
        imul edi, dword [byte ebp-04h], byte 1Ch
.20:
        imul ebx, eax, byte 27h
        add ebx, dword [byte ebp-08h]
        movzx edx, byte [byte ebx+013h]
        mov dword [byte ebp-018h], edx
        movzx edx, byte [byte ebx+01Ah]
        add edx, dword [byte ebp-018h]
        movzx ebx, byte [byte ebx+015h]
        add edx, ebx
        add edx, edx
        inc eax
        add dword [dword edi+ebp-0358h], edx
        cmp eax, byte 0Ah
        jl short .20
        mov eax, 0Ah
        imul edi, dword [byte ebp-04h], byte 1Ch
        jmp short .22
.21:
        imul ebx, eax, byte 27h
        add ebx, dword [byte ebp-08h]
        movzx edx, byte [byte ebx+013h]
        mov dword [byte ebp-018h], edx
        mov ecx, dword [byte ebp-018h]
        movzx edx, byte [byte ebx+01Ah]
        add ecx, edx
        movzx edx, byte [byte ebx+015h]
        add edx, ecx
        inc eax
        lea edx, [edx+edx*2]
        add dword [dword edi+ebp-0358h], edx
.22:
        movsx edx, word [dword esi+0D05h]
        cmp eax, edx
        jl short .21
        mov ecx, CompareGoalieAverage
        mov ebx, 3Dh
        mov dword [dword edi+ebp-0354h], 0
        mov eax, dword [byte ebp-010h]
        movsx edx, word [dword esi+01281h]
        call qsort_
        mov eax, dword [byte ebp-010h]
        mov edx, 3E8h
        movsx eax, word [byte eax+030h]
        sub edx, eax
        mov dword [byte ebp-018h], edx
        mov eax, dword [byte ebp-010h]
        fild dword [byte ebp-018h]
        fild word [byte eax+018h]
        fmul qword [F64_2_BuildTradePlayerLists]
        fmulp
        fild dword [dword edi+ebp-0354h]
        faddp
        call __CHP
        fistp dword [dword edi+ebp-0354h]
        movsx edx, word [byte eax+06Dh]
        mov eax, 3E8h
        sub eax, edx
        mov edx, eax
        mov eax, dword [byte ebp-010h]
        movsx eax, word [byte eax+055h]
        imul eax, edx
        add dword [dword edi+ebp-0354h], eax
        mov eax, dword [byte ebp-010h]
        fild word [byte eax+018h]
        fmul qword [F64_2_BuildTradePlayerLists]
        fild word [byte eax+055h]
        faddp
        call __CHP
        fistp dword [byte ebp-014h]
        cmp dword [byte ebp-014h], byte 0
        jle short .23
        mov eax, dword [dword edi+ebp-0354h]
        cdq
        idiv dword [byte ebp-014h]
        mov dword [dword edi+ebp-0354h], eax
        jmp short .24
.23:
        mov dword [dword edi+ebp-0354h], 0
.24:
        imul eax, dword [byte ebp-04h], byte 1Ch
        mov ecx, ComparePlayerAssists
        mov ebx, 3Dh
        mov dword [dword eax+ebp-0350h], 0
        mov eax, dword [byte ebp-0Ch]
        movsx edx, word [dword esi+0D05h]
        call qsort_
        xor eax, eax
        imul ebx, dword [byte ebp-04h], byte 1Ch
.25:
        imul edi, eax, byte 3Dh
        add edi, dword [byte ebp-0Ch]
        movsx edx, word [byte edi+020h]
        lea edx, [edx+edx*2]
        inc eax
        add dword [dword ebx+ebp-0350h], edx
        cmp eax, byte 5
        jl short .25
        mov eax, 5
        imul ebx, dword [byte ebp-04h], byte 1Ch
.26:
        imul edi, eax, byte 3Dh
        add edi, dword [byte ebp-0Ch]
        movsx edx, word [byte edi+020h]
        add edx, edx
        inc eax
        add dword [dword ebx+ebp-0350h], edx
        cmp eax, byte 0Ah
        jl short .26
        mov eax, 0Ah
        imul edi, dword [byte ebp-04h], byte 1Ch
        jmp short .28
.27:
        imul ebx, eax, byte 3Dh
        add ebx, dword [byte ebp-0Ch]
        movsx edx, word [byte ebx+020h]
        inc eax
        add dword [dword edi+ebp-0350h], edx
.28:
        movsx edx, word [dword esi+0D05h]
        cmp eax, edx
        jl short .27
        mov eax, dword [dword edi+ebp-0360h]
        add eax, dword [dword edi+ebp-035Ch]
        add eax, dword [dword edi+ebp-0358h]
        add eax, dword [dword edi+ebp-0354h]
        add eax, dword [dword edi+ebp-0350h]
        inc dword [byte ebp-04h]
        mov dword [dword edi+ebp-034Ch], eax
.29:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [RosterScrollList]
        jl near .6
        mov ecx, CompareFirstDword
        mov ebx, 1Ch
        lea eax, [dword ebp-0360h]
        mov edx, dword [RosterScrollList]
        mov dword [byte ebp-04h], 0
        call qsort_
        jmp short .31
.30:
        imul eax, byte 1Ch
        mov eax, dword [dword eax+ebp-0348h]
        mov dl, byte [byte ebp-04h]
        mov eax, dword [dword ebp+eax*4-088h]
        inc dl
        inc dword [byte ebp-04h]
        mov byte [byte eax+05Bh], dl
.31:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [RosterScrollList]
        jl short .30
        mov ecx, CompareTeamGoalsFor
        mov ebx, 1Ch
        lea eax, [dword ebp-0360h]
        mov edx, dword [RosterScrollList]
        mov dword [byte ebp-04h], 0
        call qsort_
        jmp short .33
.32:
        imul eax, byte 1Ch
        mov eax, dword [dword eax+ebp-0348h]
        mov dl, byte [byte ebp-04h]
        mov eax, dword [dword ebp+eax*4-088h]
        inc dl
        inc dword [byte ebp-04h]
        mov byte [byte eax+05Ch], dl
.33:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [RosterScrollList]
        jl short .32
        mov ecx, CompareTeamGoalsAgainst
        mov ebx, 1Ch
        lea eax, [dword ebp-0360h]
        mov edx, dword [RosterScrollList]
        mov dword [byte ebp-04h], 0
        call qsort_
        jmp short .35
.34:
        imul eax, byte 1Ch
        mov eax, dword [dword eax+ebp-0348h]
        mov dl, byte [byte ebp-04h]
        mov eax, dword [dword ebp+eax*4-088h]
        inc dl
        inc dword [byte ebp-04h]
        mov byte [byte eax+05Dh], dl
.35:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [RosterScrollList]
        jl short .34
        mov ecx, CompareTeamPowerPlay
        mov ebx, 1Ch
        lea eax, [dword ebp-0360h]
        mov edx, dword [RosterScrollList]
        mov dword [byte ebp-04h], 0
        call qsort_
        jmp short .37
.36:
        imul eax, byte 1Ch
        mov eax, dword [dword eax+ebp-0348h]
        mov dl, byte [byte ebp-04h]
        mov eax, dword [dword ebp+eax*4-088h]
        inc dl
        inc dword [byte ebp-04h]
        mov byte [byte eax+05Eh], dl
.37:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [RosterScrollList]
        jl short .36
        mov ecx, CompareTeamPenaltyKill
        mov ebx, 1Ch
        lea eax, [dword ebp-0360h]
        mov edx, dword [RosterScrollList]
        mov dword [byte ebp-04h], 0
        call qsort_
        jmp short .39
.38:
        imul eax, byte 1Ch
        mov eax, dword [dword eax+ebp-0348h]
        mov dl, byte [byte ebp-04h]
        mov eax, dword [dword ebp+eax*4-088h]
        inc dl
        inc dword [byte ebp-04h]
        mov byte [byte eax+05Fh], dl
.39:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [RosterScrollList]
        jl short .38
        mov ecx, CompareTeamShots
        mov ebx, 1Ch
        lea eax, [dword ebp-0360h]
        mov edx, dword [RosterScrollList]
        mov dword [byte ebp-04h], 0
        call qsort_
        mov ebx, 5
        jmp short .41
.40:
        mov esi, dword [dword ebp+eax*4-088h]
        movzx edx, byte [byte esi+05Bh]
        movzx eax, byte [byte esi+05Ch]
        add edx, eax
        movzx eax, byte [byte esi+05Dh]
        add edx, eax
        movzx eax, byte [byte esi+05Eh]
        add edx, eax
        movzx eax, byte [byte esi+05Fh]
        add eax, edx
        cdq
        idiv ebx
        inc dword [byte ebp-04h]
        mov byte [byte esi+060h], al
.41:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [RosterScrollList]
        jl short .40
        push dword [byte ebp-08h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp-0Ch]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp-010h]
        call FreeMemBlock
        add esp, byte 4
        jmp near DrawRatingBars_157
str_Xx00xx01xx02xx03xx10xx11xx12:               ; string "xx00xx01xx02xx03xx10xx11xx12"; used by
                                                ; LayoutMatchupRight
        db 078h,078h,030h,030h,078h,078h,030h,031h,078h,078h,030h,032h,078h,078h,030h,033h
        db 078h,078h,031h,030h,078h,078h,031h,031h,078h,078h,031h,032h,00h
str_G0LWC0RWLDRD:                               ; string "G0LWC0RWLDRD"; used by LayoutMatchupRight
        db 047h,030h,04Ch,057h,043h,030h,052h,057h,04Ch,044h,052h,044h,00h
