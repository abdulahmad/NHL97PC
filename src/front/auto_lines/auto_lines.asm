; Automatic lines: sorting the roster by rating and filling the line slots.
bits 32
%include "hockey.inc"
section s_9CF95 progbits alloc exec nowrite align=1
extern AutoLineData, CopyTeamRoster_203, DrawPlayerLines_234, DrawPlayerLines_23B, EditLinesTeam, FindPlayerInLines, FindPlayerStat, GoalieOverall
extern homelines, LinesChangedInGame, memset_, qsort_, SkaterOverall
global CompareByRating, CompareGoalieFirst, SortRosterByRating, ClearAndBuildLines, BuildAutoLines, SortLinesCandidates, ClearLineSlots, IsInLines
global FindBestForSlot, FindBestForSlot_66, FindBestForSlot_68, FindBestCenter, FindBestWinger, FindBestDefence, FillLineSlots, FillAllLines
;-----------------------------------------------------------------------------
; CompareByRating                                 9CF95  97 PC, low confidence
; Sort helper: compares two entries by rating
;-----------------------------------------------------------------------------
CompareByRating:
        movsx eax, word [byte eax+02h]
        movsx edx, word [byte edx+02h]
        sub edx, eax
        mov eax, edx
        ret
;-----------------------------------------------------------------------------
; CompareGoalieFirst                              9CFA2  97 PC, low confidence
; Sort helper: puts goalies first
;-----------------------------------------------------------------------------
CompareGoalieFirst:
        push ebx
        mov bl, byte [byte eax+05h]
        cmp bl, byte [byte edx+05h]
        jne short .1
        xor eax, eax
        pop ebx
        ret
.1:
        cmp byte [byte edx+05h], 44h
        jne short .3
.2:
        mov eax, 0FFFFFFFFh
        pop ebx
        ret
.3:
        cmp bl, 43h
        je short .2
        cmp bl, 4Ch
        jne short .4
        cmp byte [byte edx+05h], 43h
        jne short .2
.4:
        mov eax, 1
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SortRosterByRating                              9CFD3  97 PC, low confidence
; Sorts a roster by rating
;-----------------------------------------------------------------------------
SortRosterByRating:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 0C8h, 0
        push eax
        sub ebp, 82h
        cmp word [dword eax+0D05h], byte 19h
        jge near .12
        cmp word [dword eax+0132Bh], byte 0
        jle near .12
        mov dword [byte ebp+07Eh], 0
        mov dword [byte ebp+07Ah], 0
        jmp short .3
.1:
        imul edx, dword [byte ebp+07Eh], byte 38h
        mov eax, dword [byte ebp-04Ah]
        test byte [dword edx+eax+0132Dh], 4
        jne short .2
        imul esi, dword [byte ebp+07Ah], byte 6
        mov eax, dword [byte ebp+07Eh]
        mov word [byte esi+ebp-046h], ax
        mov eax, dword [byte ebp-04Ah]
        add eax, 132Dh
        add eax, edx
        lea edx, [byte ebp+052h]
        add eax, byte 28h
        call FindPlayerStat
        lea eax, [byte ebp+062h]
        inc dword [byte ebp+07Ah]
        call SkaterOverall
        mov word [byte esi+ebp-044h], ax
.2:
        inc dword [byte ebp+07Eh]
.3:
        mov eax, dword [byte ebp-04Ah]
        movsx eax, word [dword eax+0132Bh]
        cmp eax, dword [byte ebp+07Eh]
        jg short .1
        mov ecx, CompareByRating
        mov ebx, 6
        mov edx, dword [byte ebp+07Ah]
        lea eax, [byte ebp-046h]
        call qsort_
        mov eax, dword [byte ebp-04Ah]
        mov edx, 19h
        movsx eax, word [dword eax+0D05h]
        sub edx, eax
        mov dword [byte ebp+07Eh], 0
        mov eax, edx
        jmp short .5
.4:
        imul edx, byte 6
        mov esi, dword [byte ebp-04Ah]
        movsx esi, word [dword esi+0D05h]
        imul esi, byte 38h
        movsx ebx, word [byte edx+ebp-046h]
        imul ebx, byte 38h
        add esi, dword [byte ebp-04Ah]
        add ebx, dword [byte ebp-04Ah]
        mov ecx, 0Eh
        lea edi, [dword esi+0D09h]
        lea esi, [dword ebx+0132Dh]
        rep movsd
        movsx edx, word [byte edx+ebp-046h]
        imul edx, byte 38h
        add edx, dword [byte ebp-04Ah]
        mov byte [dword edx+0132Fh], 0
        mov edx, dword [byte ebp-04Ah]
        inc dword [byte ebp+07Eh]
        inc word [dword edx+0D05h]
.5:
        cmp eax, dword [byte ebp+07Eh]
        jle short .6
        mov edx, dword [byte ebp+07Eh]
        cmp edx, dword [byte ebp+07Ah]
        jl short .4
.6:
        mov eax, dword [byte ebp-04Ah]
        mov dword [byte ebp+07Eh], 0
        mov dword [byte ebp+07Ah], 0
        movsx eax, word [dword eax+0132Bh]
        jmp short .11
.7:
        imul esi, dword [byte ebp+07Eh], byte 38h
        add esi, dword [byte ebp-04Ah]
        cmp byte [dword esi+0132Fh], 0
        je short .9
        mov edx, dword [byte ebp+07Eh]
        cmp edx, dword [byte ebp+07Ah]
        je short .8
        imul edi, dword [byte ebp+07Ah], byte 38h
        add edi, dword [byte ebp-04Ah]
        mov ecx, 0Eh
        lea esi, [dword esi+0132Dh]
        lea edi, [dword edi+0132Dh]
        rep movsd
.8:
        inc dword [byte ebp+07Ah]
        jmp short .10
.9:
        mov edx, dword [byte ebp-04Ah]
        dec word [dword edx+0132Bh]
.10:
        inc dword [byte ebp+07Eh]
.11:
        cmp eax, dword [byte ebp+07Eh]
        jg short .7
.12:
        mov eax, dword [byte ebp-04Ah]
        cmp word [dword eax+01281h], byte 3
        jge near DrawPlayerLines_234
        cmp word [dword eax+018A5h], byte 0
        jle near DrawPlayerLines_234
        mov dword [byte ebp+07Eh], 0
        mov dword [byte ebp+07Ah], 0
        jmp short .15
.13:
        imul edx, dword [byte ebp+07Eh], byte 38h
        mov eax, dword [byte ebp-04Ah]
        test byte [dword edx+eax+018A7h], 4
        jne short .14
        imul esi, dword [byte ebp+07Ah], byte 6
        mov eax, dword [byte ebp+07Eh]
        mov word [byte esi+ebp-046h], ax
        mov eax, dword [byte ebp-04Ah]
        add eax, 18A7h
        add eax, edx
        lea edx, [byte ebp+052h]
        add eax, byte 28h
        call FindPlayerStat
        lea eax, [byte ebp+062h]
        inc dword [byte ebp+07Ah]
        call GoalieOverall
        mov word [byte esi+ebp-044h], ax
.14:
        inc dword [byte ebp+07Eh]
.15:
        mov eax, dword [byte ebp-04Ah]
        movsx eax, word [dword eax+018A5h]
        cmp eax, dword [byte ebp+07Eh]
        jg short .13
        mov ecx, CompareByRating
        mov ebx, 6
        mov edx, dword [byte ebp+07Ah]
        lea eax, [byte ebp-046h]
        call qsort_
        mov eax, dword [byte ebp-04Ah]
        mov edx, 3
        movsx eax, word [dword eax+01281h]
        sub edx, eax
        mov dword [byte ebp+07Eh], 0
        mov eax, edx
        jmp short .17
.16:
        imul edx, byte 6
        movsx ebx, word [byte edx+ebp-046h]
        imul ebx, byte 38h
        mov esi, dword [byte ebp-04Ah]
        add esi, ebx
        mov ebx, dword [byte ebp-04Ah]
        movsx ebx, word [dword ebx+01281h]
        imul ebx, byte 38h
        mov edi, dword [byte ebp-04Ah]
        mov ecx, 0Eh
        lea esi, [dword esi+018A7h]
        lea edi, [dword edi+ebx+01283h]
        rep movsd
        movsx edx, word [byte edx+ebp-046h]
        imul edx, byte 38h
        add edx, dword [byte ebp-04Ah]
        mov byte [dword edx+018A9h], 0
        mov edx, dword [byte ebp-04Ah]
        inc dword [byte ebp+07Eh]
        inc word [dword edx+01281h]
.17:
        cmp eax, dword [byte ebp+07Eh]
        jle short .18
        mov edx, dword [byte ebp+07Eh]
        cmp edx, dword [byte ebp+07Ah]
        jl short .16
.18:
        mov eax, dword [byte ebp-04Ah]
        mov dword [byte ebp+07Eh], 0
        mov dword [byte ebp+07Ah], 0
        movsx eax, word [dword eax+018A5h]
        jmp short .23
.19:
        imul esi, dword [byte ebp+07Eh], byte 38h
        add esi, dword [byte ebp-04Ah]
        cmp byte [dword esi+018A9h], 0
        je short .21
        mov edx, dword [byte ebp+07Eh]
        cmp edx, dword [byte ebp+07Ah]
        je short .20
        imul edi, dword [byte ebp+07Ah], byte 38h
        add edi, dword [byte ebp-04Ah]
        mov ecx, 0Eh
        lea esi, [dword esi+018A7h]
        lea edi, [dword edi+018A7h]
        rep movsd
.20:
        inc dword [byte ebp+07Ah]
        jmp short .22
.21:
        mov edx, dword [byte ebp-04Ah]
        dec word [dword edx+018A5h]
.22:
        inc dword [byte ebp+07Eh]
.23:
        cmp eax, dword [byte ebp+07Eh]
        jg short .19
        jmp near DrawPlayerLines_234
;-----------------------------------------------------------------------------
; ClearAndBuildLines                              9D2D0  97 PC, low confidence
; Clears and builds the lines
;-----------------------------------------------------------------------------
ClearAndBuildLines:
        push ebx
        push edx
        mov eax, AutoLineData
        mov ebx, 36h
        mov edx, 0FFh
        add eax, 20EDh
        mov dword [EditLinesTeam], AutoLineData
        call memset_
        xor eax, eax
        mov ebx, 36h
        call BuildAutoLines
        mov eax, homelines
        mov edx, 0FFh
        add eax, 20EDh
        mov dword [EditLinesTeam], homelines
        call memset_
        xor eax, eax
        call BuildAutoLines
        mov dword [EditLinesTeam], 0
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; BuildAutoLines                                  9D333  97 PC, low confidence
; Builds the lines automatically from the ratings
;-----------------------------------------------------------------------------
BuildAutoLines:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 0E0h, 0
        push eax
        sub ebp, 82h
        test eax, eax
        je near .10
        mov ebx, 36h
        mov edx, 0FFh
        add eax, byte 18h
        xor esi, esi
        xor edi, edi
        mov dword [byte ebp+07Ah], eax
        call memset_
        jmp short .3
.1:
        imul eax, esi, byte 38h
        mov ecx, dword [byte ebp-062h]
        add ecx, eax
        test byte [dword ecx+0D09h], 4
        jne short .2
        imul ebx, edi, byte 6
        mov edx, dword [byte ebp-062h]
        add edx, 0D09h
        add eax, edx
        lea edx, [byte ebp+03Ah]
        add eax, byte 28h
        mov word [byte ebx+ebp-05Eh], si
        call FindPlayerStat
        lea eax, [byte ebp+04Ah]
        call SkaterOverall
        mov word [byte ebx+ebp-05Ch], ax
        mov al, byte [dword ecx+0D0Bh]
        inc edi
        mov byte [byte ebx+ebp-059h], al
.2:
        imul edx, esi, byte 38h
        add edx, dword [byte ebp-062h]
        inc esi
        or byte [dword edx+0D09h], 2
.3:
        mov eax, dword [byte ebp-062h]
        movsx eax, word [dword eax+0D05h]
        cmp esi, eax
        jl short .1
        mov ecx, CompareByRating
        mov ebx, 6
        lea eax, [byte ebp-05Eh]
        mov edx, edi
        call qsort_
        xor esi, esi
.4:
        imul edx, esi, byte 6
        movsx edx, word [byte edx+ebp-05Eh]
        imul edx, byte 38h
        add edx, dword [byte ebp-062h]
        inc esi
        and byte [dword edx+0D09h], 0FDh
        cmp esi, byte 12h
        jl short .4
        lea eax, [byte ebp-05Eh]
        call SortLinesCandidates
        xor esi, esi
        xor edi, edi
        jmp short .7
.5:
        imul eax, esi, byte 38h
        mov edx, dword [byte ebp-062h]
        test byte [dword edx+eax+01283h], 4
        jne short .6
        imul ebx, edi, byte 6
        add edx, 1283h
        add eax, edx
        lea edx, [byte ebp+03Ah]
        add eax, byte 28h
        mov word [byte ebx+ebp+062h], si
        call FindPlayerStat
        lea eax, [byte ebp+04Ah]
        call GoalieOverall
        mov byte [byte ebx+ebp+067h], 47h
        inc edi
        mov word [byte ebx+ebp+064h], ax
.6:
        imul edx, esi, byte 38h
        add edx, dword [byte ebp-062h]
        inc esi
        or byte [dword edx+01283h], 2
.7:
        mov eax, dword [byte ebp-062h]
        movsx eax, word [dword eax+01281h]
        cmp esi, eax
        jl short .5
        cmp edi, byte 1
        jle short .8
        mov ecx, CompareByRating
        mov ebx, 6
        lea eax, [byte ebp+062h]
        mov edx, edi
        call qsort_
.8:
        xor esi, esi
.9:
        imul edx, esi, byte 6
        movsx eax, word [byte edx+ebp+062h]
        imul eax, byte 38h
        mov edx, dword [byte ebp-062h]
        inc esi
        and byte [dword edx+eax+01283h], 0FDh
        cmp esi, byte 2
        jl short .9
        jmp near .55
.10:
        mov eax, dword [EditLinesTeam]
        xor esi, esi
        mov dword [byte ebp+07Eh], eax
        add eax, 20EDh
        xor edi, edi
        mov dword [byte ebp+07Ah], eax
        jmp short .15
.11:
        imul eax, esi, dword 125h
        mov ebx, dword [byte ebp+07Eh]
        add ebx, eax
        test byte [dword ebx+0161h], 2
        jne short .14
        imul edx, edi, byte 6
        mov word [byte edx+ebp-05Eh], si
        test byte [dword ebx+0161h], 4
        je short .12
        mov word [byte edx+ebp-05Ch], 0
        jmp short .13
.12:
        mov ebx, dword [byte ebp+07Eh]
        add ebx, 0A3h
        add eax, ebx
        add eax, 0E6h
        call SkaterOverall
        mov word [byte edx+ebp-05Ch], ax
.13:
        imul ebx, esi, dword 125h
        imul edx, edi, byte 6
        add ebx, dword [byte ebp+07Eh]
        mov al, byte [dword ebx+0160h]
        inc edi
        mov byte [byte edx+ebp-059h], al
.14:
        inc esi
.15:
        mov eax, dword [byte ebp+07Eh]
        movsx eax, word [dword eax+0A1h]
        cmp esi, eax
        jl short .11
        mov ecx, CompareByRating
        mov ebx, 6
        lea eax, [byte ebp-05Eh]
        mov edx, edi
        call qsort_
        cmp dword [LinesChangedInGame], byte 0
        jne near .31
        xor edx, edx
        jmp short .17
.16:
        imul ebx, edx, byte 6
        cmp word [byte ebx+ebp-05Ch], byte 0
        je short .18
        inc edx
.17:
        cmp edx, byte 12h
        jge short .18
        cmp edx, edi
        jl short .16
.18:
        mov esi, edx
        jmp short .20
.19:
        imul ebx, esi, byte 6
        movsx ebx, word [byte ebx+ebp-05Eh]
        imul ebx, dword 125h
        add ebx, dword [byte ebp+07Eh]
        inc esi
        or byte [dword ebx+0161h], 2
.20:
        cmp esi, edi
        jl short .19
        mov edi, edx
        cmp edx, byte 12h
        jge near .27
        xor esi, esi
        jmp short .23
.21:
        imul eax, esi, dword 125h
        mov ecx, dword [byte ebp+07Eh]
        add ecx, eax
        mov dword [byte ebp+076h], eax
        test byte [dword ecx+0161h], 4
        jne short .22
        test byte [dword ecx+0161h], 2
        je short .22
        imul ebx, edx, byte 6
        mov eax, dword [byte ebp+07Eh]
        add eax, 0A3h
        add eax, dword [byte ebp+076h]
        add eax, 0E6h
        mov word [byte ebx+ebp-05Eh], si
        call SkaterOverall
        mov word [byte ebx+ebp-05Ch], ax
        mov al, byte [dword ecx+0160h]
        inc edx
        mov byte [byte ebx+ebp-059h], al
.22:
        inc esi
.23:
        mov eax, dword [byte ebp+07Eh]
        movsx eax, word [dword eax+0A1h]
        cmp esi, eax
        jl short .21
        sub edx, edi
        cmp edx, byte 1
        jle short .24
        imul ebx, edi, byte 6
        lea eax, [byte ebp-05Eh]
        mov ecx, CompareByRating
        add eax, ebx
        mov ebx, 6
        call qsort_
.24:
        mov esi, edi
        jmp short .26
.25:
        imul edx, esi, byte 6
        movsx edx, word [byte edx+ebp-05Eh]
        imul edx, dword 125h
        add edx, dword [byte ebp+07Eh]
        inc esi
        and byte [dword edx+0161h], 0FDh
.26:
        cmp esi, byte 12h
        jl short .25
.27:
        xor esi, esi
        jmp short .30
.28:
        imul edx, esi, dword 125h
        add edx, dword [byte ebp+07Eh]
        test byte [dword edx+0161h], 2
        je short .29
        mov eax, esi
        call FindPlayerInLines
.29:
        inc esi
.30:
        mov eax, dword [byte ebp+07Eh]
        movsx eax, word [dword eax+0A1h]
        cmp esi, eax
        jl short .28
.31:
        lea eax, [byte ebp-05Eh]
        call SortLinesCandidates
        xor esi, esi
        xor edi, edi
        jmp short .36
.32:
        imul eax, esi, dword 125h
        mov ebx, dword [byte ebp+07Eh]
        add ebx, eax
        test byte [dword ebx+01E00h], 2
        jne short .35
        imul edx, edi, byte 6
        mov word [byte edx+ebp+062h], si
        test byte [dword ebx+01E00h], 4
        je short .33
        mov word [byte edx+ebp+064h], 0
        jmp short .34
.33:
        mov ebx, dword [byte ebp+07Eh]
        add ebx, 1D42h
        add eax, ebx
        add eax, 0E6h
        call GoalieOverall
        mov word [byte edx+ebp+064h], ax
.34:
        imul edx, edi, byte 6
        inc edi
        mov byte [byte edx+ebp+067h], 47h
.35:
        inc esi
.36:
        mov eax, dword [byte ebp+07Eh]
        movsx eax, word [dword eax+01D40h]
        cmp esi, eax
        jl short .32
        cmp edi, byte 1
        jle short .37
        mov ecx, CompareByRating
        mov ebx, 6
        lea eax, [byte ebp+062h]
        mov edx, edi
        call qsort_
.37:
        cmp dword [LinesChangedInGame], byte 0
        jne near .55
        xor edx, edx
        jmp short .39
.38:
        imul ebx, edx, byte 6
        cmp word [byte ebx+ebp+064h], byte 0
        je short .40
        inc edx
.39:
        cmp edx, byte 2
        jge short .40
        cmp edx, edi
        jl short .38
.40:
        mov esi, edx
        jmp short .42
.41:
        imul ebx, esi, byte 6
        movsx ebx, word [byte ebx+ebp+062h]
        imul ebx, dword 125h
        add ebx, dword [byte ebp+07Eh]
        inc esi
        or byte [dword ebx+01E00h], 2
.42:
        cmp esi, edi
        jl short .41
        mov edi, edx
        cmp edx, byte 2
        jge near .49
        xor esi, esi
        jmp short .45
.43:
        imul eax, esi, dword 125h
        mov ebx, dword [byte ebp+07Eh]
        add ebx, eax
        test byte [dword ebx+01E00h], 4
        jne short .44
        test byte [dword ebx+01E00h], 2
        je short .44
        imul ebx, edx, byte 6
        mov ecx, dword [byte ebp+07Eh]
        add ecx, 1D42h
        add eax, ecx
        add eax, 0E6h
        mov word [byte ebx+ebp+062h], si
        call GoalieOverall
        mov byte [byte ebx+ebp+067h], 47h
        inc edx
        mov word [byte ebx+ebp+064h], ax
.44:
        inc esi
.45:
        mov eax, dword [byte ebp+07Eh]
        movsx eax, word [dword eax+01D40h]
        cmp esi, eax
        jl short .43
        sub edx, edi
        cmp edx, byte 1
        jle short .46
        imul eax, edi, byte 6
        lea ebx, [byte ebp+062h]
        mov ecx, CompareByRating
        add eax, ebx
        mov ebx, 6
        call qsort_
.46:
        mov esi, edi
        jmp short .48
.47:
        imul edx, esi, byte 6
        movsx eax, word [byte edx+ebp+062h]
        imul eax, dword 125h
        mov edx, dword [byte ebp+07Eh]
        inc esi
        and byte [dword edx+eax+01E00h], 0FDh
.48:
        cmp esi, byte 2
        jl short .47
.49:
        xor esi, esi
        jmp short .54
.50:
        imul edx, esi, dword 125h
        add edx, dword [byte ebp+07Eh]
        test byte [dword edx+01E00h], 2
        je short .53
        mov ecx, esi
        xor ebx, ebx
.51:
        mov edx, dword [EditLinesTeam]
        add edx, ebx
        movzx eax, byte [dword edx+02121h]
        cmp eax, ecx
        jne short .52
        mov byte [dword edx+02121h], 0FFh
.52:
        inc ebx
        cmp ebx, byte 2
        jl short .51
.53:
        inc esi
.54:
        mov eax, dword [byte ebp+07Eh]
        movsx eax, word [dword eax+01D40h]
        cmp esi, eax
        jl short .50
.55:
        lea ebx, [byte ebp+062h]
        lea edx, [byte ebp-05Eh]
        mov eax, dword [byte ebp+07Ah]
        call FillAllLines
        jmp near DrawPlayerLines_234
;-----------------------------------------------------------------------------
; SortLinesCandidates                             9D822  97 PC, low confidence
; Sorts the candidates for the lines
;-----------------------------------------------------------------------------
SortLinesCandidates:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ecx, CompareGoalieFirst
        mov ebx, 6
        mov edx, 12h
        call qsort_
        xor esi, esi
.1:
        imul eax, esi, byte 6
        cmp byte [byte edi+eax+05h], 43h
        jne short .2
        inc esi
        cmp esi, byte 12h
        jl short .1
.2:
        cmp esi, byte 1
        jle short .3
        mov ecx, CompareByRating
        mov ebx, 6
        mov edx, esi
        mov eax, edi
        call qsort_
.3:
        mov eax, esi
        jmp short .5
.4:
        imul edx, esi, byte 6
        cmp byte [byte edx+edi+05h], 4Ch
        jne short .6
        inc esi
.5:
        cmp esi, byte 12h
        jl short .4
.6:
        mov edx, esi
        sub edx, eax
        cmp edx, byte 1
        jle short .7
        imul eax, byte 6
        mov ecx, CompareByRating
        mov ebx, 6
        add eax, edi
        call qsort_
.7:
        mov eax, esi
        jmp short .9
.8:
        imul edx, esi, byte 6
        cmp byte [byte edx+edi+05h], 52h
        jne short .10
        inc esi
.9:
        cmp esi, byte 12h
        jl short .8
.10:
        mov edx, esi
        sub edx, eax
        cmp edx, byte 1
        jle short .11
        imul eax, byte 6
        mov ecx, CompareByRating
        mov ebx, 6
        add eax, edi
        call qsort_
.11:
        mov eax, esi
        jmp short .13
.12:
        imul edx, esi, byte 6
        cmp byte [byte edx+edi+05h], 44h
        jne short .14
        inc esi
.13:
        cmp esi, byte 12h
        jl short .12
.14:
        mov edx, esi
        sub edx, eax
        cmp edx, byte 1
        jle near DrawPlayerLines_23B
        imul eax, byte 6
        mov ecx, CompareByRating
        mov ebx, 6
        add eax, edi
        call qsort_
        jmp near DrawPlayerLines_23B
;-----------------------------------------------------------------------------
; ClearLineSlots                                  9D903  97 PC, low confidence
; Clears the line slots
;-----------------------------------------------------------------------------
ClearLineSlots:
        push ebx
        push ecx
        push esi
        push edi
        enter 4, 0
        push eax
        mov esi, edx
        xor eax, eax
.1:
        imul edx, eax, byte 6
        inc eax
        mov byte [byte edx+esi+04h], 0
        cmp eax, byte 12h
        jl short .1
        xor eax, eax
.2:
        xor ebx, ebx
.3:
        xor edx, edx
.4:
        lea ecx, [eax+eax*2]
        add ecx, dword [byte ebp-08h]
        movzx cx, byte [ecx+ebx]
        mov dword [byte ebp-04h], ecx
        imul ecx, edx, byte 6
        add ecx, esi
        mov edi, dword [byte ebp-04h]
        cmp di, word [ecx]
        jne short .5
        or byte [byte ecx+04h], 1
.5:
        inc edx
        cmp edx, byte 12h
        jl short .4
        inc ebx
        cmp ebx, byte 3
        jl short .3
        inc eax
        cmp eax, byte 4
        jl short .2
        xor eax, eax
.6:
        xor ebx, ebx
.7:
        xor edx, edx
.8:
        lea ecx, [eax+eax]
        add ecx, dword [byte ebp-08h]
        movzx cx, byte [byte ecx+ebx+0Ch]
        mov dword [byte ebp-04h], ecx
        imul ecx, edx, byte 6
        add ecx, esi
        mov edi, dword [byte ebp-04h]
        cmp di, word [ecx]
        jne short .9
        or byte [byte ecx+04h], 2
.9:
        inc edx
        cmp edx, byte 12h
        jl short .8
        inc ebx
        cmp ebx, byte 2
        jl short .7
        inc eax
        cmp eax, byte 3
        jl short .6
        xor eax, eax
.10:
        xor ebx, ebx
.11:
        xor edx, edx
.12:
        lea ecx, [eax+eax*4]
        add ecx, dword [byte ebp-08h]
        movzx cx, byte [byte ecx+ebx+012h]
        mov dword [byte ebp-04h], ecx
        imul ecx, edx, byte 6
        add ecx, esi
        mov edi, dword [byte ebp-04h]
        cmp di, word [ecx]
        jne short .13
        or byte [byte ecx+04h], 4
.13:
        inc edx
        cmp edx, byte 12h
        jl short .12
        inc ebx
        cmp ebx, byte 5
        jl short .11
        inc eax
        cmp eax, byte 2
        jl short .10
        xor eax, eax
.14:
        xor ebx, ebx
.15:
        xor edx, edx
.16:
        mov ecx, eax
        shl ecx, 2
        add ecx, dword [byte ebp-08h]
        movzx cx, byte [byte ecx+ebx+01Ch]
        mov dword [byte ebp-04h], ecx
        imul ecx, edx, byte 6
        add ecx, esi
        mov edi, dword [byte ebp-04h]
        cmp di, word [ecx]
        jne short .17
        or byte [byte ecx+04h], 8
.17:
        inc edx
        cmp edx, byte 12h
        jl short .16
        inc ebx
        cmp ebx, byte 4
        jl short .15
        inc eax
        cmp eax, byte 2
        jl short .14
        xor eax, eax
.18:
        xor edx, edx
.19:
        mov ebx, dword [byte ebp-08h]
        movzx cx, byte [byte ebx+eax+024h]
        imul ebx, edx, byte 6
        add ebx, esi
        cmp cx, word [ebx]
        jne short .20
        or byte [byte ebx+04h], 10h
.20:
        inc edx
        cmp edx, byte 12h
        jl short .19
        inc eax
        cmp eax, byte 2
        jl short .18
        xor eax, eax
.21:
        xor ebx, ebx
.22:
        xor edx, edx
.23:
        mov ecx, eax
        shl ecx, 2
        add ecx, dword [byte ebp-08h]
        movzx cx, byte [byte ecx+ebx+026h]
        mov dword [byte ebp-04h], ecx
        imul ecx, edx, byte 6
        add ecx, esi
        mov edi, dword [byte ebp-04h]
        cmp di, word [ecx]
        jne short .24
        or byte [byte ecx+04h], 40h
.24:
        inc edx
        cmp edx, byte 12h
        jl short .23
        inc ebx
        cmp ebx, byte 4
        jl short .22
        inc eax
        cmp eax, byte 2
        jl short .21
        xor eax, eax
.25:
        xor ebx, ebx
.26:
        xor edx, edx
.27:
        lea ecx, [eax+eax*2]
        add ecx, dword [byte ebp-08h]
        movzx cx, byte [byte ecx+ebx+02Eh]
        mov dword [byte ebp-04h], ecx
        imul ecx, edx, byte 6
        add ecx, esi
        mov edi, dword [byte ebp-04h]
        cmp di, word [ecx]
        jne short .28
        or byte [byte ecx+04h], 80h
.28:
        inc edx
        cmp edx, byte 12h
        jl short .27
        inc ebx
        cmp ebx, byte 3
        jl short .26
        inc eax
        cmp eax, byte 2
        jl short .25
        jmp near CopyTeamRoster_203
;-----------------------------------------------------------------------------
; IsInLines                                       9DA9D  97 PC, low confidence
; Returns whether a player is already in the lines
;-----------------------------------------------------------------------------
IsInLines:
        push ebx
        push ecx
        push esi
        push edi
        mov ecx, eax
        mov bl, dl
        movzx edi, bl
        xor edx, edx
.1:
        imul eax, edx, byte 6
        add eax, ecx
        movzx esi, byte [byte eax+04h]
        test esi, edi
        jne short .2
        or byte [byte eax+04h], bl
        mov al, byte [eax]
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        inc edx
        cmp edx, byte 12h
        jl short .1
        mov al, 0FFh
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FindBestForSlot                                 9DACE  97 PC, low confidence
; Finds the best player for a line slot
;-----------------------------------------------------------------------------
FindBestForSlot:
        push esi
        push edi
        enter 4, 0
        mov esi, eax
        mov byte [byte ebp-04h], dl
        movzx edi, byte [byte ebp-04h]
        mov eax, ebx
        jmp short .4
.1:
        imul edx, eax, byte 6
        add edx, esi
        movzx ecx, byte [byte edx+04h]
        test ecx, edi
        jne short .3
.2:
        mov al, byte [byte ebp-04h]
        or byte [byte edx+04h], al
        mov al, byte [edx]
        jmp short FindBestForSlot_68
.3:
        inc eax
.4:
        cmp eax, dword [byte ebp+010h]
        jl short .1
        movzx edi, byte [byte ebp-04h]
        xor eax, eax
        jmp short .6
.5:
        imul edx, eax, byte 6
        add edx, esi
        movzx ecx, byte [byte edx+04h]
        test ecx, edi
        je short .2
        inc eax
.6:
        cmp eax, ebx
        jl short .5
        mov eax, dword [byte ebp+010h]
        movzx ebx, byte [byte ebp-04h]
        jmp short .8
.7:
        imul edx, eax, byte 6
        add edx, esi
        movzx ecx, byte [byte edx+04h]
        test ecx, ebx
        je short .2
        inc eax
.8:
        cmp eax, byte 12h
        jl short .7
FindBestForSlot_66:
        mov al, 0FFh
FindBestForSlot_68:
        leave
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; FindBestCenter                                  9DB3C  97 PC, low confidence
; Finds the best centre for a line
;-----------------------------------------------------------------------------
FindBestCenter:
        push esi
        push edi
        enter 0Ch, 0
        mov esi, eax
        mov byte [byte ebp-04h], dl
        mov eax, ecx
        jmp short .4
.1:
        imul edx, eax, byte 6
        add edx, esi
        movzx edi, byte [byte edx+04h]
        mov dword [byte ebp-08h], edi
        movzx edi, byte [byte ebp-04h]
        mov dword [byte ebp-0Ch], edi
        mov edi, dword [byte ebp-08h]
        test dword [byte ebp-0Ch], edi
        jne short .3
.2:
        mov al, byte [byte ebp-04h]
        or byte [byte edx+04h], al
        mov al, byte [edx]
        jmp short FindBestForSlot_68
.3:
        inc eax
.4:
        cmp eax, dword [byte ebp+010h]
        jl short .1
        mov eax, ebx
        jmp short .6
.5:
        imul edx, eax, byte 6
        add edx, esi
        movzx edi, byte [byte edx+04h]
        mov dword [byte ebp-0Ch], edi
        movzx edi, byte [byte ebp-04h]
        mov dword [byte ebp-08h], edi
        mov edi, dword [byte ebp-0Ch]
        test dword [byte ebp-08h], edi
        je short .2
        inc eax
.6:
        cmp eax, ecx
        jl short .5
        movzx ecx, byte [byte ebp-04h]
        xor eax, eax
        jmp short .8
.7:
        imul edx, eax, byte 6
        add edx, esi
        movzx edi, byte [byte edx+04h]
        test edi, ecx
        je short .2
        inc eax
.8:
        cmp eax, ebx
        jl short .7
        mov eax, dword [byte ebp+010h]
        movzx ecx, byte [byte ebp-04h]
        jmp short .10
.9:
        imul edx, eax, byte 6
        add edx, esi
        movzx ebx, byte [byte edx+04h]
        test ebx, ecx
        je short .2
        inc eax
.10:
        cmp eax, byte 12h
        jl short .9
        jmp near FindBestForSlot_66
;-----------------------------------------------------------------------------
; FindBestWinger                                  9DBD5  97 PC, low confidence
; Finds the best winger for a line
;-----------------------------------------------------------------------------
FindBestWinger:
        push esi
        push edi
        enter 0Ch, 0
        mov esi, eax
        mov byte [byte ebp-04h], dl
        mov eax, dword [byte ebp+010h]
        jmp short .4
.1:
        imul edx, eax, byte 6
        add edx, esi
        movzx edi, byte [byte edx+04h]
        mov dword [byte ebp-08h], edi
        movzx edi, byte [byte ebp-04h]
        mov dword [byte ebp-0Ch], edi
        mov edi, dword [byte ebp-08h]
        test dword [byte ebp-0Ch], edi
        jne short .3
.2:
        mov al, byte [byte ebp-04h]
        or byte [byte edx+04h], al
        mov al, byte [edx]
        jmp near FindBestForSlot_68
.3:
        inc eax
.4:
        cmp eax, byte 12h
        jl short .1
        mov eax, ecx
        jmp short .6
.5:
        imul edx, eax, byte 6
        add edx, esi
        movzx edi, byte [byte edx+04h]
        mov dword [byte ebp-08h], edi
        movzx edi, byte [byte ebp-04h]
        mov dword [byte ebp-0Ch], edi
        mov edi, dword [byte ebp-08h]
        test dword [byte ebp-0Ch], edi
        je short .2
        inc eax
.6:
        cmp eax, dword [byte ebp+010h]
        jl short .5
        mov eax, ebx
        jmp short .8
.7:
        imul edx, eax, byte 6
        add edx, esi
        movzx edi, byte [byte edx+04h]
        mov dword [byte ebp-0Ch], edi
        movzx edi, byte [byte ebp-04h]
        mov dword [byte ebp-08h], edi
        mov edi, dword [byte ebp-0Ch]
        test dword [byte ebp-08h], edi
        je short .2
        inc eax
.8:
        cmp eax, ecx
        jl short .7
        movzx edi, byte [byte ebp-04h]
        xor eax, eax
        jmp short .10
.9:
        imul edx, eax, byte 6
        add edx, esi
        movzx ecx, byte [byte edx+04h]
        test ecx, edi
        je short .2
        inc eax
.10:
        cmp eax, ebx
        jl short .9
        jmp near FindBestForSlot_66
;-----------------------------------------------------------------------------
; FindBestDefence                                 9DC7B  97 PC, low confidence
; Finds the best defenceman for a pair
;-----------------------------------------------------------------------------
FindBestDefence:
        push esi
        push edi
        enter 10h, 0
        mov esi, eax
        mov byte [byte ebp-04h], dl
        mov dword [byte ebp-08h], ebx
        movzx edi, byte [byte ebp-04h]
        mov edx, 0FFFFFFFFh
        xor eax, eax
        jmp short .3
.1:
        imul ebx, eax, byte 6
        movzx ebx, byte [byte esi+ebx+04h]
        test ebx, edi
        jne short .2
        mov edx, eax
        jmp short .4
.2:
        inc eax
.3:
        cmp eax, dword [byte ebp-08h]
        jl short .1
.4:
        mov eax, dword [byte ebp-08h]
        jmp short .8
.5:
        imul ebx, eax, byte 6
        add ebx, esi
        movzx edi, byte [byte ebx+04h]
        mov dword [byte ebp-010h], edi
        movzx edi, byte [byte ebp-04h]
        mov dword [byte ebp-0Ch], edi
        mov edi, dword [byte ebp-010h]
        test dword [byte ebp-0Ch], edi
        jne short .7
        test edx, edx
        jl short .6
        imul edi, edx, byte 6
        mov bx, word [byte ebx+02h]
        add edi, esi
        cmp bx, word [byte edi+02h]
        jle short .9
.6:
        mov edx, eax
        jmp short .9
.7:
        inc eax
.8:
        cmp eax, ecx
        jl short .5
.9:
        movzx edi, byte [byte ebp-04h]
        mov eax, ecx
        jmp short .13
.10:
        imul ebx, eax, byte 6
        add ebx, esi
        movzx ecx, byte [byte ebx+04h]
        test ecx, edi
        jne short .12
        test edx, edx
        jl short .11
        imul ecx, edx, byte 6
        mov bx, word [byte ebx+02h]
        cmp bx, word [byte ecx+esi+02h]
        jle short .14
.11:
        mov edx, eax
        jmp short .14
.12:
        inc eax
.13:
        cmp eax, dword [byte ebp+010h]
        jl short .10
.14:
        mov eax, dword [byte ebp+010h]
        movzx edi, byte [byte ebp-04h]
        jmp short .18
.15:
        imul ebx, eax, byte 6
        add ebx, esi
        movzx ecx, byte [byte ebx+04h]
        test ecx, edi
        jne short .17
        test edx, edx
        jl short .16
        imul ecx, edx, byte 6
        mov bx, word [byte ebx+02h]
        cmp bx, word [byte ecx+esi+02h]
        jle short .19
.16:
        mov edx, eax
        jmp short .19
.17:
        inc eax
.18:
        cmp eax, byte 12h
        jl short .15
.19:
        test edx, edx
        jl near FindBestForSlot_66
        imul eax, edx, byte 6
        mov dl, byte [byte ebp-04h]
        or byte [byte esi+eax+04h], dl
        mov al, byte [esi+eax]
        jmp near FindBestForSlot_68
;-----------------------------------------------------------------------------
; FillLineSlots                                   9DD65  97 PC, low confidence
; Fills the line slots
;-----------------------------------------------------------------------------
FillLineSlots:
        push ecx
        push esi
        push edi
        enter 4, 0
        mov esi, eax
        mov byte [byte ebp-04h], dl
        mov cl, bl
        xor eax, eax
.1:
        xor edx, edx
.2:
        lea ebx, [eax+eax*2]
        add ebx, esi
        mov bl, byte [edx+ebx]
        cmp bl, byte [byte ebp-04h]
        jne short .6
        xor ebx, ebx
.3:
        lea edi, [eax+eax*2]
        add edi, esi
        add edi, ebx
        cmp cl, byte [edi]
        jne short .5
.4:
        xor eax, eax
        leave
        pop edi
        pop esi
        pop ecx
        ret
.5:
        inc ebx
        cmp ebx, byte 3
        jl short .3
.6:
        inc edx
        cmp edx, byte 3
        jl short .2
        inc eax
        cmp eax, byte 4
        jl short .1
        xor eax, eax
.7:
        xor edx, edx
.8:
        lea ebx, [eax+eax]
        add ebx, esi
        mov bl, byte [byte edx+ebx+0Ch]
        cmp bl, byte [byte ebp-04h]
        jne short .10
        xor ebx, ebx
.9:
        lea edi, [eax+eax]
        add edi, esi
        add edi, ebx
        cmp cl, byte [byte edi+0Ch]
        je short .4
        inc ebx
        cmp ebx, byte 2
        jl short .9
.10:
        inc edx
        cmp edx, byte 2
        jl short .8
        inc eax
        cmp eax, byte 3
        jl short .7
        xor eax, eax
.11:
        xor edx, edx
.12:
        lea ebx, [eax+eax*4]
        add ebx, esi
        mov bl, byte [byte edx+ebx+012h]
        cmp bl, byte [byte ebp-04h]
        jne short .14
        xor ebx, ebx
.13:
        lea edi, [eax+eax*4]
        add edi, esi
        add edi, ebx
        cmp cl, byte [byte edi+012h]
        je short .4
        inc ebx
        cmp ebx, byte 5
        jl short .13
.14:
        inc edx
        cmp edx, byte 5
        jl short .12
        inc eax
        cmp eax, byte 2
        jl short .11
        xor eax, eax
.15:
        xor edx, edx
.16:
        mov ebx, eax
        shl ebx, 2
        add ebx, esi
        mov bl, byte [byte edx+ebx+01Ch]
        cmp bl, byte [byte ebp-04h]
        jne short .18
        xor ebx, ebx
.17:
        mov edi, eax
        shl edi, 2
        add edi, esi
        add edi, ebx
        cmp cl, byte [byte edi+01Ch]
        je near .4
        inc ebx
        cmp ebx, byte 4
        jl short .17
.18:
        inc edx
        cmp edx, byte 4
        jl short .16
        inc eax
        cmp eax, byte 2
        jl short .15
        xor eax, eax
.19:
        xor edx, edx
.20:
        mov ebx, eax
        shl ebx, 2
        add ebx, esi
        mov bl, byte [byte edx+ebx+026h]
        cmp bl, byte [byte ebp-04h]
        jne short .22
        xor ebx, ebx
.21:
        mov edi, eax
        shl edi, 2
        add edi, esi
        add edi, ebx
        cmp cl, byte [byte edi+026h]
        je near .4
        inc ebx
        cmp ebx, byte 4
        jl short .21
.22:
        inc edx
        cmp edx, byte 4
        jl short .20
        inc eax
        cmp eax, byte 2
        jl short .19
        xor eax, eax
.23:
        xor edx, edx
.24:
        lea ebx, [eax+eax*2]
        add ebx, esi
        mov bl, byte [byte edx+ebx+02Eh]
        cmp bl, byte [byte ebp-04h]
        jne short .26
        xor ebx, ebx
.25:
        lea edi, [eax+eax*2]
        add edi, esi
        add edi, ebx
        cmp cl, byte [byte edi+02Eh]
        je near .4
        inc ebx
        cmp ebx, byte 3
        jl short .25
.26:
        inc edx
        cmp edx, byte 3
        jl short .24
        inc eax
        cmp eax, byte 2
        jl short .23
        mov eax, 1
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; FillAllLines                                    9DEC2  97 PC, low confidence
; Fills all the lines
;-----------------------------------------------------------------------------
FillAllLines:
        push ecx
        push esi
        push edi
        enter 54h, 0
        mov esi, eax
        mov dword [byte ebp-054h], edx
        mov dword [byte ebp-014h], ebx
        xor edi, edi
.1:
        imul ebx, edi, byte 6
        add ebx, dword [byte ebp-054h]
        cmp byte [byte ebx+05h], 43h
        jne short .2
        inc edi
        cmp edi, byte 12h
        jl short .1
.2:
        mov dword [byte ebp-0Ch], edi
        jmp short .4
.3:
        imul ebx, edi, byte 6
        add ebx, dword [byte ebp-054h]
        cmp byte [byte ebx+05h], 4Ch
        jne short .5
        inc edi
.4:
        cmp edi, byte 12h
        jl short .3
.5:
        mov dword [byte ebp-010h], edi
        jmp short .7
.6:
        imul ebx, edi, byte 6
        add ebx, dword [byte ebp-054h]
        cmp byte [byte ebx+05h], 52h
        jne short .8
        inc edi
.7:
        cmp edi, byte 12h
        jl short .6
.8:
        mov edx, dword [byte ebp-054h]
        mov eax, esi
        mov dword [byte ebp-08h], edi
        call ClearLineSlots
        xor edi, edi
.9:
        lea ebx, [edi+edi*2]
        add ebx, esi
        cmp byte [byte ebx+01h], 19h
        jbe short .10
        mov edx, 3
        mov eax, dword [byte ebp-054h]
        call IsInLines
        mov byte [byte ebx+01h], al
.10:
        lea eax, [edi+edi*2]
        lea edx, [esi+eax]
        mov dword [byte ebp-018h], edx
        cmp byte [edx], 19h
        jbe short .11
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 3
        mov eax, dword [byte ebp-054h]
        call FindBestForSlot
        mov edx, dword [byte ebp-018h]
        mov byte [edx], al
.11:
        lea eax, [edi+edi*2]
        lea edx, [esi+eax]
        mov dword [byte ebp-03Ch], edx
        cmp byte [byte edx+02h], 19h
        jbe short .12
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 3
        mov eax, dword [byte ebp-054h]
        call FindBestCenter
        mov edx, dword [byte ebp-03Ch]
        mov byte [byte edx+02h], al
.12:
        cmp edi, byte 3
        jge short .15
        mov dword [byte ebp-04h], 0
.13:
        lea eax, [edi+edi]
        mov edx, dword [byte ebp-04h]
        add eax, esi
        add edx, eax
        mov dword [byte ebp-048h], edx
        cmp byte [byte edx+0Ch], 19h
        jbe short .14
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 3
        mov eax, dword [byte ebp-054h]
        call FindBestWinger
        mov edx, dword [byte ebp-048h]
        mov byte [byte edx+0Ch], al
.14:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 2
        jl short .13
.15:
        inc edi
        cmp edi, byte 4
        jl near .9
        xor edi, edi
.16:
        mov dword [byte ebp-04h], 0
.17:
        lea ebx, [edi+edi*4]
        add ebx, esi
        cmp byte [byte ebx+013h], 19h
        jbe short .18
        mov edx, 4
        mov eax, dword [byte ebp-054h]
        call IsInLines
        mov byte [byte ebx+013h], al
.18:
        lea eax, [edi+edi*4]
        lea edx, [esi+eax]
        mov dword [byte ebp-038h], edx
        cmp byte [byte edx+012h], 19h
        jbe short .19
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 4
        mov eax, dword [byte ebp-054h]
        call FindBestForSlot
        mov edx, dword [byte ebp-038h]
        mov byte [byte edx+012h], al
.19:
        lea eax, [edi+edi*4]
        lea edx, [esi+eax]
        mov dword [byte ebp-030h], edx
        cmp byte [byte edx+014h], 19h
        jbe short .20
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 4
        mov eax, dword [byte ebp-054h]
        call FindBestCenter
        mov edx, dword [byte ebp-030h]
        mov byte [byte edx+014h], al
.20:
        lea eax, [edi+edi*4]
        lea edx, [esi+eax]
        mov dword [byte ebp-02Ch], edx
        cmp byte [byte edx+015h], 19h
        jbe short .21
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 4
        mov eax, dword [byte ebp-054h]
        call FindBestWinger
        mov edx, dword [byte ebp-02Ch]
        mov byte [byte edx+015h], al
.21:
        lea eax, [edi+edi*4]
        lea edx, [esi+eax]
        mov dword [byte ebp-01Ch], edx
        cmp byte [byte edx+016h], 19h
        jbe short .22
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 4
        mov eax, dword [byte ebp-054h]
        call FindBestDefence
        mov edx, dword [byte ebp-01Ch]
        mov byte [byte edx+016h], al
.22:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 5
        jl near .17
        inc edi
        cmp edi, byte 2
        jl near .16
        xor edi, edi
.23:
        mov dword [byte ebp-04h], 0
.24:
        mov ebx, edi
        shl ebx, 2
        add ebx, esi
        cmp byte [byte ebx+01Dh], 19h
        jbe short .25
        mov edx, 8
        mov eax, dword [byte ebp-054h]
        call IsInLines
        mov byte [byte ebx+01Dh], al
.25:
        mov eax, edi
        shl eax, 2
        lea edx, [esi+eax]
        mov dword [byte ebp-040h], edx
        cmp byte [byte edx+01Ch], 19h
        jbe short .26
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 8
        mov eax, dword [byte ebp-054h]
        call FindBestForSlot
        mov edx, dword [byte ebp-040h]
        mov byte [byte edx+01Ch], al
.26:
        mov eax, edi
        shl eax, 2
        lea edx, [esi+eax]
        mov dword [byte ebp-044h], edx
        cmp byte [byte edx+01Eh], 19h
        jbe short .27
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 8
        mov eax, dword [byte ebp-054h]
        call FindBestWinger
        mov edx, dword [byte ebp-044h]
        mov byte [byte edx+01Eh], al
.27:
        mov eax, edi
        shl eax, 2
        lea edx, [esi+eax]
        mov dword [byte ebp-050h], edx
        cmp byte [byte edx+01Fh], 19h
        jbe short .28
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 8
        mov eax, dword [byte ebp-054h]
        call FindBestDefence
        mov edx, dword [byte ebp-050h]
        mov byte [byte edx+01Fh], al
.28:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 4
        jl near .24
        inc edi
        cmp edi, byte 2
        jl near .23
        xor edi, edi
.29:
        mov dword [byte ebp-04h], 0
.30:
        mov ebx, edi
        shl ebx, 2
        add ebx, esi
        cmp byte [byte ebx+027h], 19h
        jbe short .31
        mov edx, 40h
        mov eax, dword [byte ebp-054h]
        call IsInLines
        mov byte [byte ebx+027h], al
.31:
        mov eax, edi
        shl eax, 2
        lea edx, [esi+eax]
        mov dword [byte ebp-028h], edx
        cmp byte [byte edx+026h], 19h
        jbe short .32
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 40h
        mov eax, dword [byte ebp-054h]
        call FindBestForSlot
        mov edx, dword [byte ebp-028h]
        mov byte [byte edx+026h], al
.32:
        mov eax, edi
        shl eax, 2
        lea edx, [esi+eax]
        mov dword [byte ebp-020h], edx
        cmp byte [byte edx+028h], 19h
        jbe short .33
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 40h
        mov eax, dword [byte ebp-054h]
        call FindBestWinger
        mov edx, dword [byte ebp-020h]
        mov byte [byte edx+028h], al
.33:
        mov eax, edi
        shl eax, 2
        lea edx, [esi+eax]
        mov dword [byte ebp-04Ch], edx
        cmp byte [byte edx+029h], 19h
        jbe short .34
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 40h
        mov eax, dword [byte ebp-054h]
        call FindBestWinger
        mov edx, dword [byte ebp-04Ch]
        mov byte [byte edx+029h], al
.34:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 4
        jl near .30
        inc edi
        cmp edi, byte 2
        jl near .29
        xor edi, edi
.35:
        mov dword [byte ebp-04h], 0
.36:
        lea ebx, [edi+edi*2]
        add ebx, esi
        cmp byte [byte ebx+02Eh], 19h
        jbe short .37
        mov edx, 80h
        mov eax, dword [byte ebp-054h]
        call IsInLines
        mov byte [byte ebx+02Eh], al
.37:
        lea eax, [edi+edi*2]
        lea edx, [esi+eax]
        mov dword [byte ebp-024h], edx
        cmp byte [byte edx+02Fh], 19h
        jbe short .38
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 80h
        mov eax, dword [byte ebp-054h]
        call FindBestWinger
        mov edx, dword [byte ebp-024h]
        mov byte [byte edx+02Fh], al
.38:
        lea eax, [edi+edi*2]
        lea edx, [esi+eax]
        mov dword [byte ebp-034h], edx
        cmp byte [byte edx+030h], 19h
        jbe short .39
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 80h
        mov eax, dword [byte ebp-054h]
        call FindBestWinger
        mov edx, dword [byte ebp-034h]
        mov byte [byte edx+030h], al
.39:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 3
        jl short .36
        inc edi
        cmp edi, byte 2
        jl near .35
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 10h
        mov eax, dword [byte ebp-054h]
        call FindBestDefence
        mov byte [byte esi+024h], al
.40:
        push dword [byte ebp-08h]
        mov ecx, dword [byte ebp-010h]
        mov ebx, dword [byte ebp-0Ch]
        mov edx, 10h
        mov eax, dword [byte ebp-054h]
        call FindBestDefence
        movzx ebx, al
        movzx edx, byte [byte esi+024h]
        mov byte [byte esi+025h], al
        mov eax, esi
        call FillLineSlots
        test eax, eax
        je short .40
        cmp byte [byte esi+034h], 3
        jbe short .43
        mov edx, dword [byte ebp-014h]
        movzx ax, byte [byte esi+035h]
        cmp ax, word [edx]
        je short .41
        mov al, byte [edx]
        jmp short .42
.41:
        mov al, byte [byte edx+06h]
.42:
        mov byte [byte esi+034h], al
.43:
        cmp byte [byte esi+035h], 3
        jbe short .46
        mov edx, dword [byte ebp-014h]
        movzx ax, byte [byte esi+034h]
        cmp ax, word [edx]
        je short .44
        mov al, byte [edx]
        jmp short .45
.44:
        mov al, byte [byte edx+06h]
.45:
        mov byte [byte esi+035h], al
.46:
        leave
        pop edi
        pop esi
        pop ecx
        ret
