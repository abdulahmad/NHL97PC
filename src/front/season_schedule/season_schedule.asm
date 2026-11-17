; Season schedule, team lines and injuries.
bits 32
%include "hockey.inc"
section s_7A9D8 progbits alloc exec nowrite align=1
extern AddPlayerStat, AddPlayerStatAt, AllocMemBlock, AllStarDay, AutoLineData, BuildAutoLines, ClearLinkAbort, FindGameRecord
extern FindPlayerRecord, FindPlayerStat, FreeMemBlock, GameSettings, GetLangText, homelines, KeysEqual, LinkGameActive
extern memcpy_, PlayoffUserActive, rand_, ScheduleDivisionFlags, ScheduleGameCounts, ScheduleHomeCounts, ScheduleMonthDays, ScheduleMonthLengths
extern ScheduleWeekDays, SeasonActive, SeasonRandomSeed, SeasonScheduleData, SeasonScheduleOffset, SeasonScheduleSize, SeasonUserActive, SeasonUserTeam
extern ShowMessageBox, SortRosterByRating, sprintf_, srand_, str_1_BuildSeasonSchedule, str_Roster, str_SS2, strcpy_
extern UpdateGameRecord, UpdatePlayerStat
global BuildSeasonSchedule, BuildSeasonSchedule_77E, UpdateTeamLines, BuildRosterLines, PlayerInjuryDays, FindInjuryEntry, CheckLeagueInjuries, ClearTeamInjuries
;-----------------------------------------------------------------------------
; BuildSeasonSchedule                             7A9D8  97 PC, low confidence
; Builds the season schedule and player stats
;-----------------------------------------------------------------------------
BuildSeasonSchedule:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 2ECh, 0
        mov eax, dword [SeasonRandomSeed]
        and eax, 0FFCFFCh
        mov dword [SeasonScheduleSize], 0
        call srand_
        mov eax, dword [SeasonUserTeam]
        movsx eax, word [eax]
        imul eax, dword 194Fh
        push byte 0
        push eax
        push str_Roster
        mov dword [byte ebp-020h], 0
        mov dword [byte ebp-08h], 0
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp-0Ch], eax
        jmp short .4
.1:
        imul edx, dword [byte ebp-08h], dword 194Fh
        mov ebx, dword [byte ebp-08h]
        mov eax, dword [byte eax+01Ch]
        shl ebx, 3
        add eax, ebx
        add edx, dword [byte ebp-0Ch]
        xor ecx, ecx
        call FindGameRecord
        jmp short .3
.2:
        imul ebx, dword [byte ebp-08h], byte 19h
        imul edx, ecx, byte 38h
        add eax, 0D09h
        add eax, edx
        lea edx, [byte ebp-060h]
        add eax, byte 28h
        add ebx, ecx
        call FindPlayerStat
        mov al, byte [byte ebp-042h]
        mov byte [dword ebx+ebp-02ECh], al
        movzx eax, al
        inc ecx
        add dword [byte ebp-020h], eax
.3:
        imul eax, dword [byte ebp-08h], dword 194Fh
        add eax, dword [byte ebp-0Ch]
        movsx edx, word [dword eax+0D05h]
        cmp ecx, edx
        jl short .2
        inc dword [byte ebp-08h]
.4:
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [eax]
        cmp edx, dword [byte ebp-08h]
        jg short .1
        mov dword [byte ebp-08h], 0
        jmp near .32
.5:
        call rand_
        mov ebx, 0Bh
        cdq
        idiv ebx
        mov ebx, edx
        imul esi, edx, byte 0Ah
        mov ecx, 0Ah
        call rand_
        cdq
        idiv ecx
        movzx eax, byte [dword edx+esi+ScheduleDivisionFlags]
        mov dword [byte ebp-01Ch], eax
        imul eax, ebx, byte 28h
        mov ebx, dword [byte ebp-01Ch]
        shl ebx, 3
        add ebx, eax
        mov ecx, dword [dword ebx+ScheduleMonthLengths]
        sub ecx, dword [dword ebx+str_1_BuildSeasonSchedule]
        je short .6
        call rand_
        cdq
        idiv ecx
        mov eax, dword [dword ebx+str_1_BuildSeasonSchedule]
        add eax, edx
        jmp short .7
.6:
        mov eax, dword [dword ebx+str_1_BuildSeasonSchedule]
.7:
        mov dword [byte ebp-018h], eax
.8:
        call rand_
        mov ebx, dword [byte ebp-020h]
        cdq
        inc ebx
        idiv ebx
        mov eax, edx
        test edx, edx
        jne short .9
        mov eax, 1
.9:
        xor ebx, ebx
        jmp short .14
.10:
        mov dword [byte ebp-04h], 0
        jmp short .12
.11:
        imul ecx, ebx, byte 19h
        add ecx, dword [byte ebp-04h]
        movzx edx, byte [dword ecx+ebp-02ECh]
        inc dword [byte ebp-04h]
        sub eax, edx
.12:
        imul ecx, ebx, dword 194Fh
        add ecx, dword [byte ebp-0Ch]
        movsx edx, word [dword ecx+0D05h]
        cmp edx, dword [byte ebp-04h]
        jle short .13
        test eax, eax
        jg short .11
.13:
        inc ebx
.14:
        mov ecx, dword [SeasonUserTeam]
        movsx edx, word [ecx]
        cmp ebx, edx
        jge short .15
        test eax, eax
        jg short .10
.15:
        dec dword [byte ebp-04h]
        imul eax, dword [byte ebp-04h], byte 38h
        dec ebx
        imul edx, ebx, dword 194Fh
        add edx, dword [byte ebp-0Ch]
        cmp dword [dword edx+eax+0D25h], byte 11h
        je short .8
        mov dword [byte ebp-010h], 0
        xor ecx, ecx
        jmp near .30
.16:
        imul eax, ebx, dword 194Fh
        mov edx, dword [byte ebp-0Ch]
        add edx, eax
        imul eax, dword [byte ebp-04h], byte 38h
        add edx, eax
        imul eax, ecx, byte 7
        cmp dword [dword edx+eax+0D0Ch], byte 0
        jne near .29
        mov eax, dword [SeasonUserTeam]
        movsx eax, word [byte eax+02h]
        mov esi, 0Dh
        cdq
        idiv esi
        mov esi, eax
        call rand_
        dec esi
        cdq
        idiv esi
        lea eax, [byte edx+01h]
        xor esi, esi
        jmp short .20
.17:
        mov edx, esi
        mov edi, dword [byte edi+020h]
        shl edx, 4
        add edi, edx
        movsx edx, byte [edi]
        cmp ebx, edx
        je short .18
        movsx edi, byte [byte edi+01h]
        cmp edi, ebx
        jne short .19
.18:
        dec eax
.19:
        inc esi
.20:
        test eax, eax
        jle short .21
        mov edi, dword [SeasonUserTeam]
        movsx edx, word [byte edi+02h]
        cmp esi, edx
        jl short .17
.21:
        imul edi, ecx, byte 7
        dec esi
        mov eax, dword [SeasonUserTeam]
        mov edx, esi
        mov eax, dword [byte eax+020h]
        shl edx, 4
        movzx eax, word [byte edx+eax+04h]
        imul edx, dword [byte ebp-04h], byte 38h
        mov dword [byte ebp-030h], eax
        imul eax, ebx, dword 194Fh
        add eax, dword [byte ebp-0Ch]
        add eax, edx
        add edi, eax
        mov eax, dword [byte ebp-030h]
        mov dword [dword edi+0D0Ch], eax
        mov eax, dword [byte ebp-01Ch]
        mov edx, dword [nosplit eax*4+ScheduleGameCounts]
        mov dword [byte ebp-028h], edx
        mov edx, dword [nosplit eax*4+ScheduleHomeCounts]
        sub dword [byte ebp-028h], edx
        mov eax, dword [nosplit eax*4+ScheduleHomeCounts]
        mov edx, dword [byte ebp-028h]
        add eax, eax
        mov dword [byte ebp-028h], edx
        mov dword [byte ebp-030h], eax
        call rand_
        cdq
        idiv dword [byte ebp-030h]
        add edx, dword [byte ebp-028h]
        mov byte [dword edi+0D11h], dl
        movzx eax, dl
        mov edi, dword [dword edi+0D0Ch]
        add edi, eax
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [byte eax+02h]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        movzx eax, word [byte edx+eax-0Ch]
        cmp edi, eax
        jg near .26
        mov dword [byte ebp-014h], 0
        jmp short .25
.22:
        mov edx, esi
        mov eax, dword [byte eax+020h]
        shl edx, 4
        add eax, edx
        movsx edx, byte [eax]
        cmp edx, ebx
        je short .23
        movsx eax, byte [byte eax+01h]
        cmp eax, ebx
        jne short .24
.23:
        imul edx, dword [byte ebp-04h], byte 38h
        imul eax, ebx, dword 194Fh
        add eax, dword [byte ebp-0Ch]
        add eax, edx
        imul edx, ecx, byte 7
        add eax, edx
        movzx edx, byte [dword eax+0D11h]
        mov edi, dword [dword eax+0D0Ch]
        add edi, edx
        mov dword [byte ebp-028h], edi
        mov edx, esi
        mov edi, dword [SeasonUserTeam]
        shl edx, 4
        mov edi, dword [byte edi+020h]
        add edi, edx
        movzx edx, word [byte edi+04h]
        cmp edx, dword [byte ebp-028h]
        jle short .24
        mov dl, byte [byte edi+04h]
        sub dl, byte [dword eax+0D0Ch]
        mov dword [byte ebp-014h], 1
        mov byte [dword eax+0D11h], dl
.24:
        inc esi
.25:
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [byte eax+02h]
        cmp esi, edx
        jge short .26
        cmp dword [byte ebp-014h], byte 0
        je near .22
.26:
        imul eax, dword [byte ebp-04h], byte 38h
        imul esi, ebx, dword 194Fh
        add esi, dword [byte ebp-0Ch]
        add esi, eax
        imul eax, ecx, byte 7
        add eax, esi
        movzx edx, byte [dword eax+0D11h]
        add edx, dword [dword eax+0D0Ch]
        cmp edx, dword [dword esi+0D0Ch]
        jl short .27
        movzx edx, byte [dword esi+0D11h]
        add edx, dword [dword esi+0D0Ch]
        cmp edx, dword [dword eax+0D0Ch]
        jl short .27
        test ecx, ecx
        jne short .28
.27:
        imul eax, ebx, dword 194Fh
        mov edx, dword [byte ebp-0Ch]
        add edx, eax
        imul eax, dword [byte ebp-04h], byte 38h
        add eax, edx
        imul edx, ecx, byte 7
        add eax, edx
        mov dl, byte [byte ebp-018h]
        mov byte [dword eax+0D12h], 0
        mov dword [byte ebp-010h], 1
        mov byte [dword eax+0D10h], dl
        jmp short .29
.28:
        mov dword [dword eax+0D0Ch], 0
        mov dword [byte ebp-010h], 1
        mov byte [dword eax+0D11h], 0
.29:
        inc ecx
.30:
        cmp ecx, byte 2
        jge short .31
        cmp dword [byte ebp-010h], byte 0
        je near .16
.31:
        inc dword [byte ebp-08h]
.32:
        mov eax, dword [SeasonUserTeam]
        movsx eax, word [byte eax+02h]
        imul eax, byte 78h
        mov ebx, 410h
        cdq
        idiv ebx
        cmp eax, dword [byte ebp-08h]
        jg near .5
        lea edi, [byte ebp-038h]
        mov esi, SeasonScheduleData
        mov dword [byte ebp-08h], 0
        movsd
        movsd
        jmp near .62
.33:
        call rand_
        mov ebx, 5
        cdq
        idiv ebx
        mov ecx, 7
        call rand_
        mov ebx, edx
        cdq
        idiv ecx
        shl ebx, 3
        inc edx
        mov ecx, dword [dword ebx+ScheduleMonthDays]
        mov dword [byte ebp-01Ch], edx
        sub ecx, dword [dword ebx+ScheduleWeekDays]
        je short .34
        call rand_
        cdq
        idiv ecx
        mov eax, dword [dword ebx+ScheduleWeekDays]
        add eax, edx
        jmp short .35
.34:
        mov eax, dword [dword ebx+ScheduleWeekDays]
.35:
        mov dword [byte ebp-018h], eax
        call rand_
        mov ebx, dword [byte ebp-020h]
        cdq
        inc ebx
        idiv ebx
        mov eax, edx
        test edx, edx
        jne short .36
        mov eax, 1
.36:
        xor ebx, ebx
        jmp short .41
.37:
        mov dword [byte ebp-04h], 0
        jmp short .39
.38:
        imul ecx, ebx, byte 19h
        add ecx, dword [byte ebp-04h]
        movzx edx, byte [dword ecx+ebp-02ECh]
        inc dword [byte ebp-04h]
        sub eax, edx
.39:
        imul ecx, ebx, dword 194Fh
        add ecx, dword [byte ebp-0Ch]
        movsx edx, word [dword ecx+0D05h]
        cmp edx, dword [byte ebp-04h]
        jle short .40
        test eax, eax
        jg short .38
.40:
        inc ebx
.41:
        mov ecx, dword [SeasonUserTeam]
        movsx edx, word [ecx]
        cmp ebx, edx
        jge short .42
        test eax, eax
        jg short .37
.42:
        mov dword [byte ebp-010h], 0
        xor ecx, ecx
        jmp near .60
.43:
        imul eax, dword [byte ebp-04h], byte 38h
        imul edx, ebx, dword 194Fh
        add edx, dword [byte ebp-0Ch]
        add edx, eax
        imul eax, ecx, byte 7
        cmp dword [dword edx+eax+0D0Ch], byte 0
        jne near .59
        mov eax, dword [SeasonUserTeam]
        movsx eax, word [byte eax+02h]
        mov esi, 0Dh
        cdq
        idiv esi
        mov edx, eax
        lea esi, [byte edx-01h]
        call rand_
        cdq
        idiv esi
        lea eax, [byte edx+01h]
        xor esi, esi
        jmp short .47
.44:
        mov edx, esi
        mov edi, dword [byte edi+020h]
        shl edx, 4
        add edi, edx
        movsx edx, byte [edi]
        cmp ebx, edx
        je short .45
        movsx edi, byte [byte edi+01h]
        cmp edi, ebx
        jne short .46
.45:
        dec eax
.46:
        inc esi
.47:
        test eax, eax
        jle short .48
        mov edi, dword [SeasonUserTeam]
        movsx edx, word [byte edi+02h]
        cmp esi, edx
        jl short .44
.48:
        dec esi
        mov eax, dword [SeasonUserTeam]
        mov edx, esi
        mov eax, dword [byte eax+020h]
        shl edx, 4
        movzx eax, word [byte edx+eax+04h]
        mov dword [byte ebp-028h], eax
        imul eax, ebx, dword 194Fh
        mov edx, dword [byte ebp-0Ch]
        add edx, eax
        imul eax, dword [byte ebp-04h], byte 38h
        add edx, eax
        imul eax, ecx, byte 7
        add eax, edx
        mov edx, dword [byte ebp-028h]
        mov dword [dword eax+0D0Ch], edx
        mov dl, byte [byte ebp-01Ch]
        mov byte [dword eax+0D11h], dl
        movzx edx, dl
        add edx, dword [dword eax+0D0Ch]
        mov eax, dword [SeasonUserTeam]
        movsx edi, word [byte eax+02h]
        mov eax, dword [byte eax+020h]
        shl edi, 4
        add eax, edi
        movzx eax, word [byte eax-0Ch]
        cmp edx, eax
        jg near .53
        mov dword [byte ebp-014h], 0
        jmp short .52
.49:
        mov edx, esi
        mov eax, dword [byte eax+020h]
        shl edx, 4
        add eax, edx
        movsx edx, byte [eax]
        cmp edx, ebx
        je short .50
        movsx eax, byte [byte eax+01h]
        cmp eax, ebx
        jne short .51
.50:
        imul eax, ebx, dword 194Fh
        mov edx, dword [byte ebp-0Ch]
        add edx, eax
        imul eax, dword [byte ebp-04h], byte 38h
        add edx, eax
        imul eax, ecx, byte 7
        add eax, edx
        movzx edx, byte [dword eax+0D11h]
        mov edi, dword [dword eax+0D0Ch]
        add edi, edx
        mov dword [byte ebp-028h], edi
        mov edx, esi
        mov edi, dword [SeasonUserTeam]
        shl edx, 4
        mov edi, dword [byte edi+020h]
        add edi, edx
        movzx edx, word [byte edi+04h]
        cmp edx, dword [byte ebp-028h]
        jle short .51
        mov dl, byte [byte edi+04h]
        sub dl, byte [dword eax+0D0Ch]
        mov dword [byte ebp-014h], 1
        mov byte [dword eax+0D11h], dl
.51:
        inc esi
.52:
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [byte eax+02h]
        cmp esi, edx
        jge short .53
        cmp dword [byte ebp-014h], byte 0
        je near .49
.53:
        xor esi, esi
        jmp short .56
.54:
        mov edi, dword [dword eax+0D0Ch]
        movzx edx, byte [dword eax+0D11h]
        add edi, edx
        mov dword [byte ebp-030h], edi
        imul edi, esi, byte 7
        add edi, dword [byte ebp-024h]
        mov edx, dword [dword edi+0D0Ch]
        cmp edx, dword [byte ebp-030h]
        jg short .55
        movzx edx, byte [dword edi+0D11h]
        mov edi, dword [dword edi+0D0Ch]
        add edi, edx
        cmp edi, dword [dword eax+0D0Ch]
        jl short .55
        mov dword [dword eax+0D0Ch], 0
        mov dword [byte ebp-010h], 1
        mov byte [dword eax+0D11h], 0
.55:
        inc esi
.56:
        imul eax, dword [byte ebp-04h], byte 38h
        imul edx, ecx, byte 7
        mov dword [byte ebp-02Ch], eax
        imul eax, ebx, dword 194Fh
        mov edi, dword [byte ebp-02Ch]
        add eax, dword [byte ebp-0Ch]
        add edi, eax
        mov dword [byte ebp-024h], edi
        lea eax, [edi+edx]
        cmp esi, ecx
        jl short .54
        cmp dword [byte ebp-010h], byte 0
        jne short .59
        mov dl, byte [byte ebp-018h]
        mov esi, dword [byte ebp-024h]
        mov byte [dword eax+0D10h], dl
        lea edi, [byte ebp-058h]
        lea esi, [dword esi+0D21h]
        movsd
        movsd
        inc dword [byte ebp-034h]
        mov dl, byte [byte ebp-034h]
        sub dl, byte [SeasonScheduleOffset]
        mov byte [dword eax+0D12h], dl
        cmp dword [LinkGameActive], byte 0
        je short .57
        call ClearLinkAbort
        test eax, eax
        jne short .57
        lea edx, [byte ebp-038h]
        lea eax, [byte ebp-060h]
        call AddPlayerStatAt
        jmp short .58
.57:
        lea eax, [byte ebp-060h]
        call AddPlayerStat
.58:
        mov dword [byte ebp-010h], 1
        inc dword [SeasonScheduleSize]
.59:
        inc ecx
.60:
        cmp ecx, byte 3
        jge short .61
        cmp dword [byte ebp-010h], byte 0
        je near .43
.61:
        inc dword [byte ebp-08h]
.62:
        mov eax, dword [SeasonUserTeam]
        movsx eax, word [byte eax+02h]
        imul eax, byte 78h
        mov ebx, 410h
        cdq
        idiv ebx
        cmp eax, dword [byte ebp-08h]
        jg near .33
        mov dword [byte ebp-08h], 0
        jmp short .64
.63:
        imul eax, dword [byte ebp-08h], dword 194Fh
        add eax, dword [byte ebp-0Ch]
        inc dword [byte ebp-08h]
        call UpdateGameRecord
.64:
        mov eax, dword [SeasonUserTeam]
        movsx eax, word [eax]
        cmp eax, dword [byte ebp-08h]
        jg short .63
        push dword [byte ebp-0Ch]
        call FreeMemBlock
        add esp, byte 4
BuildSeasonSchedule_77E:
        leave
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; UpdateTeamLines                                 7B15D  97 PC, low confidence
; Updates a team's lines after a game
;-----------------------------------------------------------------------------
UpdateTeamLines:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 70h, 0
        push eax
        mov dword [byte ebp-010h], 0
        mov dword [byte ebp-0Ch], 0
        movzx eax, word [AllStarDay]
        xor ecx, ecx
        mov dword [byte ebp-014h], eax
        jmp near .11
.1:
        imul esi, ecx, byte 38h
        mov ebx, dword [byte ebp-074h]
        add ebx, 0D09h
        add ebx, esi
        mov edx, dword [byte ebp-014h]
        lea eax, [byte ebx+03h]
        call FindInjuryEntry
        mov edx, eax
        mov eax, dword [byte ebp-074h]
        add eax, esi
        cmp edx, byte 0FFFFFFFFh
        jne short .3
        lea edi, [dword eax+0D31h]
        lea esi, [dword eax+0D39h]
        and byte [dword eax+0D09h], 0FAh
.2:
        movsd
        movsd
        jmp near .10
.3:
        imul edx, byte 7
        lea esi, [eax+edx]
        mov dword [byte ebp-018h], esi
        cmp byte [dword esi+0D12h], 0
        je near .9
        lea edx, [byte ebx+030h]
        and byte [dword eax+0D09h], 0FAh
        add ebx, byte 28h
        or byte [dword eax+0D09h], 1
        mov eax, ebx
        call KeysEqual
        test eax, eax
        je near .10
        lea edx, [byte ebp-048h]
        lea edi, [byte ebp-020h]
        mov eax, ebx
        mov esi, SeasonScheduleData
        call FindPlayerStat
        mov eax, dword [byte ebp-018h]
        movsd
        movsd
        movzx eax, byte [dword eax+0D12h]
        lea edx, [byte ebp-070h]
        add dword [byte ebp-01Ch], eax
        lea eax, [byte ebp-020h]
        mov ebx, 17h
        call FindPlayerStat
        lea edx, [byte ebp-038h]
        lea eax, [byte ebp-060h]
        call memcpy_
        mov eax, dword [byte ebp-018h]
        mov dl, byte [byte ebp-05Bh]
        mov bh, byte [byte ebp-058h]
        shr dl, 1
        shr bh, 1
        mov dh, byte [byte ebp-05Ch]
        mov al, byte [dword eax+0D10h]
        shr dh, 1
        mov bl, byte [byte ebp-059h]
        mov byte [byte ebp-08h], dh
        mov dh, byte [byte ebp-05Eh]
        mov ah, byte [byte ebp-05Ah]
        shr dh, 1
        shr bl, 1
        mov byte [byte ebp-04h], dh
        mov dh, byte [byte ebp-05Fh]
        shr ah, 1
        shr dh, 1
        cmp al, 83h
        jb short .4
        cmp al, 84h
        jbe short .5
        cmp al, 86h
        jbe short .6
        cmp al, 88h
        jbe short .7
        jmp short .8
.4:
        cmp al, 81h
        jb short .8
        mov al, byte [byte ebp-04h]
        shr byte [byte ebp-054h], 1
        mov byte [byte ebp-050h], 0
        mov byte [byte ebp-05Bh], dl
        mov byte [byte ebp-059h], bl
        mov byte [byte ebp-058h], bh
        mov byte [byte ebp-05Eh], al
        mov al, byte [byte ebp-08h]
        mov byte [byte ebp-05Fh], dh
        mov byte [byte ebp-05Ch], al
        mov byte [byte ebp-05Ah], ah
        jmp short .8
.5:
        mov al, byte [byte ebp-04h]
        shr byte [byte ebp-055h], 1
        mov byte [byte ebp-050h], 0
        mov byte [byte ebp-05Bh], dl
        mov byte [byte ebp-05Ah], ah
        mov byte [byte ebp-05Eh], al
        jmp short .8
.6:
        mov byte [byte ebp-05Fh], dh
        jmp short .8
.7:
        mov al, byte [byte ebp-08h]
        mov byte [byte ebp-050h], 0
        mov byte [byte ebp-05Bh], dl
        mov byte [byte ebp-059h], bl
        mov byte [byte ebp-058h], bh
        mov byte [byte ebp-05Ah], ah
        mov byte [byte ebp-05Ch], al
.8:
        imul esi, ecx, byte 38h
        lea eax, [byte ebp-070h]
        add esi, dword [byte ebp-074h]
        call UpdatePlayerStat
        lea edi, [dword esi+0D31h]
        lea esi, [byte ebp-070h]
        jmp near .2
.9:
        or byte [dword eax+0D09h], 4
        mov dword [byte ebp-010h], 1
        and byte [dword eax+0D09h], 0FEh
.10:
        inc ecx
.11:
        mov eax, dword [byte ebp-074h]
        movsx eax, word [dword eax+0D05h]
        cmp ecx, eax
        jl near .1
        xor ecx, ecx
        jmp short .16
.12:
        mov edx, ecx
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        mov edx, dword [byte ebp-074h]
        call KeysEqual
        test eax, eax
        je short .15
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .13
        cmp dword [SeasonActive], byte 0
        jne short .13
        imul eax, ecx, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 0
        jne short .15
        jmp short .14
.13:
        imul eax, ecx, byte 1Ch
        cmp byte [dword eax+PlayoffUserActive], 0
        jne short .15
.14:
        mov dword [byte ebp-0Ch], 1
.15:
        inc ecx
.16:
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [eax]
        cmp ecx, edx
        jl short .12
        cmp dword [byte ebp-010h], byte 0
        je short .17
        cmp dword [byte ebp-0Ch], byte 0
        je near BuildSeasonSchedule_77E
        mov eax, dword [byte ebp-074h]
        call SortRosterByRating
        mov eax, dword [byte ebp-074h]
        call BuildAutoLines
        jmp near BuildSeasonSchedule_77E
.17:
        cmp dword [byte ebp-0Ch], byte 0
        je near BuildSeasonSchedule_77E
        mov edi, dword [byte ebp-074h]
        mov esi, dword [byte ebp-074h]
        mov ecx, 36h
        lea edi, [byte edi+018h]
        lea esi, [dword esi+087h]
        mov eax, dword [byte ebp-074h]
        rep movsb
        mov edx, dword [byte ebp-074h]
        mov ax, word [dword eax+0BDh]
        mov word [dword edx+0D05h], ax
        mov ax, word [dword edx+0637h]
        mov word [dword edx+01281h], ax
        mov ax, word [dword edx+06E1h]
        mov word [dword edx+0132Bh], ax
        mov ax, word [dword edx+0C5Bh]
        mov ebx, 578h
        mov word [dword edx+018A5h], ax
        mov eax, dword [byte ebp-074h]
        add edx, 0BFh
        add eax, 0D09h
        call memcpy_
        mov edx, dword [byte ebp-074h]
        mov eax, dword [byte ebp-074h]
        mov ebx, 0A8h
        add edx, 639h
        add eax, 1283h
        call memcpy_
        mov edx, dword [byte ebp-074h]
        mov eax, dword [byte ebp-074h]
        mov ebx, 578h
        add edx, 6E3h
        add eax, 132Dh
        call memcpy_
        mov edx, dword [byte ebp-074h]
        mov eax, dword [byte ebp-074h]
        mov ebx, 0A8h
        add edx, 0C5Dh
        add eax, 18A7h
        xor ecx, ecx
        call memcpy_
        jmp short .21
.18:
        imul ebx, ecx, byte 38h
        mov eax, dword [byte ebp-074h]
        add eax, 0D09h
        add eax, ebx
        mov edx, dword [byte ebp-014h]
        add eax, byte 3
        call FindInjuryEntry
        mov edx, eax
        mov eax, dword [byte ebp-074h]
        add eax, ebx
        cmp edx, byte 0FFFFFFFFh
        jne short .19
        and byte [dword eax+0D09h], 0FAh
        jmp short .20
.19:
        imul edx, byte 7
        add edx, eax
        cmp byte [dword edx+0D12h], 0
        je short .20
        lea edi, [byte ebp-020h]
        and byte [dword eax+0D09h], 0FAh
        mov esi, SeasonScheduleData
        or byte [dword eax+0D09h], 1
        movsd
        movsd
        movzx edx, byte [dword edx+0D12h]
        add dword [byte ebp-01Ch], edx
        lea esi, [byte ebp-020h]
        lea edi, [dword eax+0D31h]
        movsd
        movsd
.20:
        inc ecx
.21:
        mov eax, dword [byte ebp-074h]
        movsx eax, word [dword eax+0D05h]
        cmp ecx, eax
        jl short .18
        jmp near BuildSeasonSchedule_77E
;-----------------------------------------------------------------------------
; BuildRosterLines                                7B4E4  97 PC, low confidence
; Builds a team's lines
;-----------------------------------------------------------------------------
BuildRosterLines:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 10h, 0
        push eax
        mov eax, dword [SeasonUserTeam]
        mov dword [byte ebp-04h], 0FFFFFFFFh
        xor esi, esi
        movsx ebx, word [byte eax+02h]
        xor ecx, ecx
        jmp short .3
.1:
        mov edx, ebx
        shl edx, 4
        mov eax, dword [SeasonUserTeam]
        mov dword [byte ebp-08h], edx
        mov edx, dword [byte eax+020h]
        add edx, dword [byte ebp-08h]
        movsx edx, byte [edx]
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add edx, eax
        mov eax, dword [byte ebp-014h]
        call KeysEqual
        test eax, eax
        jne short .2
        mov eax, dword [SeasonUserTeam]
        mov edx, dword [byte eax+020h]
        add edx, dword [byte ebp-08h]
        movsx edx, byte [byte edx+01h]
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add edx, eax
        mov eax, dword [byte ebp-014h]
        call KeysEqual
        test eax, eax
        je short .3
.2:
        mov edx, ebx
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        add eax, edx
        movsx edx, byte [byte eax+02h]
        cmp edx, byte 0FFFFFFFFh
        je short .3
        movzx eax, word [byte eax+04h]
        mov dword [byte ebp-04h], eax
.3:
        dec ebx
        test ebx, ebx
        jl short .4
        cmp dword [byte ebp-04h], byte 0FFFFFFFFh
        je short .1
.4:
        inc dword [byte ebp-04h]
        xor ebx, ebx
        jmp short .9
.5:
        imul edi, ebx, byte 38h
        mov eax, dword [byte ebp-014h]
        add eax, 0D09h
        add eax, edi
        mov edx, dword [byte ebp-04h]
        add eax, byte 3
        call FindInjuryEntry
        mov edx, eax
        mov eax, dword [byte ebp-014h]
        add eax, edi
        cmp edx, byte 0FFFFFFFFh
        jne short .6
        and byte [dword eax+0D09h], 0FAh
        jmp short .8
.6:
        imul edx, byte 7
        cmp byte [dword edx+eax+0D12h], 0
        je short .7
        and byte [dword eax+0D09h], 0FAh
        or byte [dword eax+0D09h], 1
        jmp short .8
.7:
        or byte [dword eax+0D09h], 4
        mov esi, 1
        and byte [dword eax+0D09h], 0FEh
.8:
        inc ebx
.9:
        mov eax, dword [byte ebp-014h]
        movsx eax, word [dword eax+0D05h]
        cmp ebx, eax
        jl short .5
        xor ebx, ebx
        jmp short .14
.10:
        mov edx, ebx
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        mov edx, dword [byte ebp-014h]
        call KeysEqual
        test eax, eax
        je short .13
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .11
        cmp dword [SeasonActive], byte 0
        jne short .11
        imul eax, ebx, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 0
        jne short .13
        jmp short .12
.11:
        imul eax, ebx, byte 1Ch
        cmp byte [dword eax+PlayoffUserActive], 0
        jne short .13
.12:
        mov ecx, 1
.13:
        inc ebx
.14:
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [eax]
        cmp ebx, edx
        jl short .10
        test esi, esi
        je short .15
        test ecx, ecx
        je near BuildSeasonSchedule_77E
        mov eax, dword [byte ebp-014h]
        call SortRosterByRating
        mov eax, dword [byte ebp-014h]
        call BuildAutoLines
        jmp near BuildSeasonSchedule_77E
.15:
        test ecx, ecx
        je near BuildSeasonSchedule_77E
        mov edi, dword [byte ebp-014h]
        mov esi, dword [byte ebp-014h]
        mov ecx, 36h
        lea edi, [byte edi+018h]
        lea esi, [dword esi+087h]
        mov eax, dword [byte ebp-014h]
        rep movsb
        mov edx, dword [byte ebp-014h]
        mov ax, word [dword eax+0BDh]
        mov word [dword edx+0D05h], ax
        mov ax, word [dword edx+0637h]
        mov word [dword edx+01281h], ax
        mov ax, word [dword edx+06E1h]
        mov word [dword edx+0132Bh], ax
        mov ax, word [dword edx+0C5Bh]
        mov ebx, 578h
        mov word [dword edx+018A5h], ax
        mov eax, dword [byte ebp-014h]
        add edx, 0BFh
        add eax, 0D09h
        call memcpy_
        mov edx, dword [byte ebp-014h]
        mov eax, dword [byte ebp-014h]
        mov ebx, 0A8h
        add edx, 639h
        add eax, 1283h
        call memcpy_
        mov edx, dword [byte ebp-014h]
        mov eax, dword [byte ebp-014h]
        mov ebx, 578h
        add edx, 6E3h
        add eax, 132Dh
        call memcpy_
        mov edx, dword [byte ebp-014h]
        mov eax, dword [byte ebp-014h]
        mov ebx, 0A8h
        add edx, 0C5Dh
        add eax, 18A7h
        call memcpy_
        xor ebx, ebx
        jmp short .19
.16:
        imul ecx, ebx, byte 38h
        mov eax, dword [byte ebp-014h]
        add eax, 0D09h
        add eax, ecx
        mov edx, dword [byte ebp-04h]
        add eax, byte 3
        call FindInjuryEntry
        mov edx, eax
        mov eax, dword [byte ebp-014h]
        add eax, ecx
        cmp edx, byte 0FFFFFFFFh
        jne short .17
        and byte [dword eax+0D09h], 0FAh
        jmp short .18
.17:
        imul edx, byte 7
        add edx, eax
        cmp byte [dword edx+0D12h], 0
        je short .18
        lea edi, [byte ebp-010h]
        and byte [dword eax+0D09h], 0FAh
        mov esi, SeasonScheduleData
        or byte [dword eax+0D09h], 1
        movsd
        movsd
        lea esi, [byte ebp-010h]
        movzx edx, byte [dword edx+0D12h]
        lea edi, [dword eax+0D31h]
        add dword [byte ebp-0Ch], edx
        movsd
        movsd
.18:
        inc ebx
.19:
        mov eax, dword [byte ebp-014h]
        movsx eax, word [dword eax+0D05h]
        cmp ebx, eax
        jl short .16
        jmp near BuildSeasonSchedule_77E
        push ebx
        push ecx
        push esi
        enter 8, 0
        mov ecx, eax
        mov dword [byte ebp-08h], edx
        mov eax, dword [SeasonUserTeam]
        movsx ebx, word [byte eax+02h]
        mov esi, 0FFFFFFFFh
        jmp short .22
.20:
        mov edx, ebx
        shl edx, 4
        mov eax, dword [SeasonUserTeam]
        mov dword [byte ebp-04h], edx
        mov edx, dword [byte eax+020h]
        add edx, dword [byte ebp-04h]
        movsx edx, byte [edx]
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add edx, eax
        mov eax, ecx
        call KeysEqual
        test eax, eax
        jne short .21
        mov eax, dword [SeasonUserTeam]
        mov edx, dword [byte eax+020h]
        add edx, dword [byte ebp-04h]
        movsx edx, byte [edx]
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add edx, eax
        mov eax, ecx
        call KeysEqual
        test eax, eax
        je short .22
.21:
        mov edx, ebx
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        add eax, edx
        movsx edx, byte [byte eax+02h]
        cmp edx, byte 0FFFFFFFFh
        je short .22
        movzx esi, word [byte eax+04h]
.22:
        dec ebx
        test ebx, ebx
        jl short .23
        cmp esi, byte 0FFFFFFFFh
        je short .20
.23:
        mov eax, dword [byte ebp-08h]
        mov edx, esi
        call FindInjuryEntry
        leave
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PlayerInjuryDays                                7B84B  97 PC, low confidence
; Returns the days a player is injured
;-----------------------------------------------------------------------------
PlayerInjuryDays:
        push edx
        movzx edx, word [AllStarDay]
        call FindInjuryEntry
        pop edx
        ret
;-----------------------------------------------------------------------------
; FindInjuryEntry                                 7B85A  97 PC, low confidence
; Finds an injury entry
;-----------------------------------------------------------------------------
FindInjuryEntry:
        push ebx
        push ecx
        push esi
        mov ecx, eax
        mov ebx, edx
        xor edx, edx
.1:
        imul eax, edx, byte 7
        add eax, ecx
        cmp ebx, dword [eax]
        jle short .2
        movzx esi, byte [byte eax+05h]
        mov eax, dword [eax]
        add eax, esi
        cmp ebx, eax
        jg short .2
        mov eax, edx
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        inc edx
        cmp edx, byte 3
        jl short .1
        mov eax, 0FFFFFFFFh
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CheckLeagueInjuries                             7B88D  97 PC, low confidence
; Checks the league injuries after a game
;-----------------------------------------------------------------------------
CheckLeagueInjuries:
        push ebx
        push ecx
        push esi
        push edi
        enter 1AD0h, 0
        push eax
        push edx
        sub ebp, 82h
        mov dword [byte ebp+07Eh], 0
.1:
        xor esi, esi
        mov ebx, dword [dword ebp-01A52h]
        mov dword [byte ebp+076h], esi
        shl ebx, 4
        cmp dword [byte ebp+07Eh], byte 0
        je short .2
        mov eax, dword [SeasonUserTeam]
        mov edx, dword [byte eax+020h]
        movsx ebx, byte [edx+ebx]
        mov edx, ebx
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        lea edx, [dword ebp-01A4Eh]
        mov dword [byte ebp+07Ah], AutoLineData
        jmp short .3
.2:
        mov eax, dword [SeasonUserTeam]
        mov edx, dword [byte eax+020h]
        movsx ebx, byte [byte edx+ebx+01h]
        mov edx, ebx
        mov eax, dword [byte eax+01Ch]
        shl edx, 3
        add eax, edx
        lea edx, [dword ebp-01A4Eh]
        mov dword [byte ebp+07Ah], homelines
.3:
        call FindGameRecord
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .4
        cmp dword [SeasonActive], byte 0
        jne short .4
        imul ebx, byte 1Ch
        cmp byte [dword ebx+SeasonUserActive], 0
        jne short .6
        jmp short .5
.4:
        imul ebx, byte 1Ch
        cmp byte [dword ebx+PlayoffUserActive], 0
        jne short .6
.5:
        mov esi, 1
.6:
        test esi, esi
        jne near .21
        jmp near .20
.7:
        xor edi, edi
.8:
        imul ebx, edi, byte 7
        imul eax, esi, byte 38h
        add ebx, eax
        movzx edx, word [AllStarDay]
        cmp edx, dword [dword ebx+ebp-0D42h]
        jne near .19
        cmp byte [dword ebx+ebp-0D3Ch], 0
        jne near .19
        lea edx, [dword ebp-0D45h]
        or byte [dword eax+ebp-0D45h], 4
        add eax, edx
        lea edx, [dword ebp-0FEh]
        add eax, byte 18h
        call FindPlayerRecord
        movzx edx, byte [dword ebx+ebp-0D3Dh]
        mov eax, dword [SeasonUserTeam]
        add edx, dword [dword ebx+ebp-0D42h]
        movsx ebx, word [byte eax+02h]
        shl ebx, 4
        mov eax, dword [byte eax+020h]
        movzx eax, word [byte ebx+eax-0Ch]
        mov dword [byte ebp+076h], 1
        cmp edx, eax
        jle short .9
        mov eax, 7Dh
        jmp short .13
.9:
        movzx eax, word [AllStarDay]
        sub edx, eax
        mov eax, edx
        cmp edx, byte 3Ch
        jle short .11
        mov ebx, 1Eh
        cdq
        idiv ebx
        push eax
        mov eax, 7Ch
.10:
        call GetLangText
        push eax
        lea eax, [byte ebp+056h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        jmp short .14
.11:
        cmp edx, byte 1
        jle short .12
        push edx
        mov eax, 7Bh
        jmp short .10
.12:
        mov eax, 7Ah
.13:
        call GetLangText
        mov edx, eax
        lea eax, [byte ebp+056h]
        call strcpy_
.14:
        imul edx, esi, byte 38h
        lea eax, [byte ebp+056h]
        push eax
        imul eax, edi, byte 7
        add eax, edx
        movzx eax, byte [dword eax+ebp-0D3Eh]
        call GetLangText
        push eax
        lea eax, [dword ebp-0F6h]
        push eax
        lea eax, [dword ebp-0E6h]
        push eax
        mov eax, 5Dh
        call GetLangText
        push eax
        lea eax, [byte ebp+022h]
        push eax
        call sprintf_
        imul eax, esi, dword 125h
        add eax, dword [byte ebp+07Ah]
        add esp, byte 18h
        test byte [dword eax+0161h], 4
        jne short .15
        cmp dword [dword ebp-01A56h], byte 0
        je short .16
        test byte [dword eax+0161h], 2
        jne short .16
.15:
        lea eax, [byte ebp+022h]
        push eax
        mov eax, 1E8h
        jmp short .18
.16:
        imul eax, esi, dword 125h
        add eax, dword [byte ebp+07Ah]
        test byte [dword eax+0161h], 2
        je short .17
        lea eax, [byte ebp+022h]
        push eax
        mov eax, 1E9h
        jmp short .18
.17:
        lea eax, [byte ebp+022h]
        push eax
        mov eax, 1EAh
.18:
        call GetLangText
        push eax
        push str_SS2
        lea eax, [byte ebp-042h]
        push eax
        call sprintf_
        add esp, byte 10h
        push byte 1
        mov edx, 1
        lea eax, [byte ebp-042h]
        xor ecx, ecx
        xor ebx, ebx
        call ShowMessageBox
.19:
        inc edi
        cmp edi, byte 3
        jl near .8
        inc esi
.20:
        movsx eax, word [dword ebp-0D49h]
        cmp esi, eax
        jl near .7
        cmp dword [byte ebp+076h], byte 0
        je short .21
        lea eax, [dword ebp-01A4Eh]
        call BuildAutoLines
        lea eax, [dword ebp-01A4Eh]
        call UpdateGameRecord
.21:
        inc dword [byte ebp+07Eh]
        cmp dword [byte ebp+07Eh], byte 2
        jl near .1
        lea esp, [dword ebp+082h]
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ClearTeamInjuries                               7BB27  97 PC, low confidence
; Clears the injuries of both teams
;-----------------------------------------------------------------------------
ClearTeamInjuries:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 8, 0
        xor ecx, ecx
.1:
        test ecx, ecx
        je short .2
        mov eax, AutoLineData
        jmp short .3
.2:
        mov eax, homelines
.3:
        xor ebx, ebx
        jmp short .7
.4:
        imul edx, ebx, dword 125h
        xor esi, esi
        mov byte [dword edx+eax+019Fh], 0
.5:
        imul edx, ebx, dword 125h
        lea edi, [eax+edx]
        imul edx, esi, byte 7
        mov dword [byte ebp-04h], edi
        add edx, edi
        movzx edi, word [AllStarDay]
        mov dword [byte ebp-08h], edi
        mov edi, dword [dword edx+01B2h]
        cmp edi, dword [byte ebp-08h]
        jne short .6
        cmp byte [dword edx+01B8h], 0
        jne short .6
        mov edx, dword [byte ebp-04h]
        mov byte [dword edx+019Fh], 1
.6:
        inc esi
        cmp esi, byte 3
        jl short .5
        inc ebx
.7:
        movsx edx, word [dword eax+0A1h]
        cmp ebx, edx
        jl short .4
        inc ecx
        cmp ecx, byte 2
        jl short .1
        jmp near BuildSeasonSchedule_77E
