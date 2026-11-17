; Scoring log: goals, penalties and period ends.
bits 32
%include "hockey.inc"
section s_AA495 progbits alloc exec nowrite align=1
extern AutoLineData, GameLogCount, GetLangText, homelines, PassState, PenaltyLogCount, ScoringLogAssist, ScoringLogCount
extern ScoringLogMinute, ScoringLogPad, ScoringLogPeriod, ScoringLogPlayer, ScoringLogPrevMinute, ScoringLogPrevPeriod, ScoringLogPrevTime, ScoringLogPrevType
extern ScoringLogSecondAssist, ScoringLogTeam, ScoringLogTime, ScoringLogType, sprintf_, str_DSSDSSSSD02d, str_Punct_GoalTypeSuffix, str_S6
extern str_S7, str_SSSSSSSD02d
global ResetScoringLog, LogGoal, LogPenalty, LogPeriodEnd, FirstScoringEntry, NextScoringEntry, FirstPenaltyEntry, NextPenaltyEntry
global PeriodEntryCount, ScoringEntryText, NoScoringEntry, GoalTypeSuffix, FormatGoalLine
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ResetScoringLog                                 AA498  97 PC, low confidence
; Clears the scoring log
;-----------------------------------------------------------------------------
ResetScoringLog:
        push ebx
        push edx
        mov ebx, 0FFFFFFFFh
        xor edx, edx
        mov word [PenaltyLogCount], bx
        mov word [ScoringLogCount], bx
        mov word [GameLogCount], dx
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LogGoal                                         AA4BC  97 PC, low confidence
; Adds a goal to the scoring log
;-----------------------------------------------------------------------------
LogGoal:
        push esi
        push edi
        sub esp, byte 0Ch
        mov word [byte esp+04h], dx
        mov word [byte esp+08h], bx
        mov word [esp], cx
        mov cx, word [GameLogCount]
        mov esi, 1
        cmp cx, 100h
        jge near .1
        mov edx, dword [PassState]
        movsx ebx, ax
        sar edx, 10h
        sub edx, ebx
        mov edi, 3Ch
        mov ebx, edx
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        movsx edx, cx
        mov byte [nosplit edx*8+ScoringLogPeriod], al
        mov ah, 3Ch
        mul ah
        sub bl, al
        mov al, byte [byte esp+04h]
        mov byte [nosplit edx*8+ScoringLogMinute], al
        mov al, byte [byte esp+020h]
        mov byte [nosplit edx*8+ScoringLogTime], bl
        or al, 20h
        mov byte [nosplit edx*8+ScoringLogType], al
        mov al, byte [byte esp+08h]
        mov byte [nosplit edx*8+ScoringLogTeam], al
        mov al, byte [esp]
        mov byte [nosplit edx*8+ScoringLogPlayer], al
        mov al, byte [byte esp+018h]
        mov byte [nosplit edx*8+ScoringLogAssist], al
        mov al, byte [byte esp+01Ch]
        mov byte [nosplit edx*8+ScoringLogSecondAssist], al
        mov dx, word [GameLogCount]
        inc edx
        mov word [ScoringLogCount], cx
        mov word [GameLogCount], dx
        mov eax, esi
        add esp, byte 0Ch
        pop edi
        pop esi
        ret 0Ch
.1:
        xor esi, esi
        mov eax, esi
        add esp, byte 0Ch
        pop edi
        pop esi
        ret 0Ch
;-----------------------------------------------------------------------------
; LogPenalty                                      AA588  97 PC, low confidence
; Adds a penalty to the scoring log
;-----------------------------------------------------------------------------
LogPenalty:
        push esi
        push edi
        sub esp, byte 0Ch
        mov word [byte esp+04h], dx
        mov word [byte esp+08h], bx
        mov word [esp], cx
        mov si, word [GameLogCount]
        mov ecx, 1
        cmp si, 100h
        jge near .1
        mov edx, dword [PassState]
        movsx ebx, ax
        sar edx, 10h
        sub edx, ebx
        mov edi, 3Ch
        mov ebx, edx
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        movsx edx, si
        mov byte [nosplit edx*8+ScoringLogPeriod], al
        mov ah, 3Ch
        mul ah
        sub bl, al
        mov al, byte [byte esp+04h]
        mov byte [nosplit edx*8+ScoringLogTime], bl
        mov byte [nosplit edx*8+ScoringLogMinute], al
        mov byte [nosplit edx*8+ScoringLogType], 80h
        mov al, byte [byte esp+08h]
        mov byte [nosplit edx*8+ScoringLogTeam], al
        mov al, byte [esp]
        mov byte [nosplit edx*8+ScoringLogPlayer], al
        mov al, byte [byte esp+018h]
        mov byte [nosplit edx*8+ScoringLogAssist], al
        mov al, byte [byte esp+01Ch]
        mov byte [nosplit edx*8+ScoringLogSecondAssist], al
        mov dx, word [GameLogCount]
        inc edx
        mov word [PenaltyLogCount], si
        mov word [GameLogCount], dx
        mov eax, ecx
        add esp, byte 0Ch
        pop edi
        pop esi
        ret 8
.1:
        xor ecx, ecx
        mov eax, ecx
        add esp, byte 0Ch
        pop edi
        pop esi
        ret 8
        db 090h
;-----------------------------------------------------------------------------
; LogPeriodEnd                                    AA650  97 PC, low confidence
; Adds the end of a period to the scoring log
;-----------------------------------------------------------------------------
LogPeriodEnd:
        push ebx
        push ecx
        push esi
        push edi
        sub esp, byte 4
        mov word [esp], ax
        mov esi, edx
        mov cx, word [GameLogCount]
        mov ebx, 1
        cmp cx, 100h
        jge near .3
        mov edx, dword [PassState]
        sar edx, 10h
        mov edi, 3Ch
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        mov dl, al
        movsx eax, cx
        shl eax, 3
        mov byte [dword eax+ScoringLogPeriod], dl
        xor dl, dl
        mov byte [dword eax+ScoringLogTime], dl
        test si, si
        jne short .1
        mov byte [dword eax+ScoringLogPeriod], dl
        jmp short .2
.1:
        cmp word [esp], byte 2
        jle short .2
        test byte [dword eax+ScoringLogPrevType], 20h
        je short .2
        mov dl, byte [dword eax+ScoringLogPrevPeriod]
        mov byte [dword eax+ScoringLogPeriod], dl
        mov dl, byte [dword eax+ScoringLogPrevTime]
        mov byte [dword eax+ScoringLogTime], dl
.2:
        movsx eax, cx
        mov dl, byte [esp]
        mov byte [nosplit eax*8+ScoringLogMinute], dl
        mov word [nosplit eax*8+ScoringLogTeam], si
        mov byte [nosplit eax*8+ScoringLogType], 40h
        inc word [GameLogCount]
        mov eax, ebx
        add esp, byte 4
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.3:
        xor ebx, ebx
        mov eax, ebx
        add esp, byte 4
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FirstScoringEntry                               AA710  97 PC, low confidence
; Returns the first entry of the scoring log
;-----------------------------------------------------------------------------
FirstScoringEntry:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        mov dx, word [PenaltyLogCount]
        mov si, word [GameLogCount]
        test dx, dx
        jl short .5
        xor eax, eax
        xor edx, edx
        jmp short .4
.1:
        test byte [dword eax+ScoringLogType], 80h
        je short .3
        test bx, bx
        jl short .2
        xor ecx, ecx
        mov cl, byte [dword eax+ScoringLogMinute]
        cmp cx, bx
        jne short .3
.2:
        movsx eax, dx
        shl eax, 3
        mov word [PenaltyLogCount], dx
        add eax, ScoringLogPeriod
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        inc edx
        add eax, byte 8
.4:
        movsx ecx, si
        cmp edx, ecx
        jl short .1
.5:
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; NextScoringEntry                                AA774  97 PC, low confidence
; Returns the next entry of the scoring log
;-----------------------------------------------------------------------------
NextScoringEntry:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        mov dx, word [PenaltyLogCount]
        mov si, word [GameLogCount]
        test dx, dx
        jl short .5
        mov edx, dword [ScoringLogCount]
        movsx eax, si
        sar edx, 10h
        dec eax
        cmp edx, eax
        jge short .5
        inc edx
        lea eax, [nosplit edx*8+00h]
        jmp short .4
.1:
        test byte [dword eax+ScoringLogType], 80h
        je short .3
        test bx, bx
        jl short .2
        xor ecx, ecx
        mov cl, byte [dword eax+ScoringLogMinute]
        cmp cx, bx
        jne short .3
.2:
        movsx eax, dx
        shl eax, 3
        mov word [PenaltyLogCount], dx
        add eax, ScoringLogPeriod
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        inc edx
        add eax, byte 8
.4:
        movsx ecx, si
        cmp edx, ecx
        jl short .1
.5:
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FirstPenaltyEntry                               AA7EC  97 PC, low confidence
; Returns the first penalty in the scoring log
;-----------------------------------------------------------------------------
FirstPenaltyEntry:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov esi, eax
        mov di, word [GameLogCount]
        xor eax, eax
        test si, si
        jge short .4
        xor edx, edx
        xor ebx, ebx
        jmp short .3
.1:
        test byte [dword edx+ScoringLogType], 80h
        je short .2
        inc eax
.2:
        inc ebx
        add edx, byte 8
.3:
        movsx ecx, di
        cmp ebx, ecx
        jge short .9
        jmp short .1
.4:
        xor edx, edx
        xor ebx, ebx
        jmp short .8
.5:
        test byte [dword edx+ScoringLogType], 80h
        je short .7
        xor ecx, ecx
        mov cl, byte [dword edx+ScoringLogMinute]
        cmp cx, si
        jne short .6
        inc eax
        jmp short .7
.6:
        jg short .9
.7:
        inc ebx
        add edx, byte 8
.8:
        movsx ecx, di
        cmp ebx, ecx
        jl short .5
.9:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; NextPenaltyEntry                                AA850  97 PC, low confidence
; Returns the next penalty in the scoring log
;-----------------------------------------------------------------------------
NextPenaltyEntry:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        mov dx, word [ScoringLogCount]
        mov si, word [GameLogCount]
        test dx, dx
        jl short .5
        xor eax, eax
        xor edx, edx
        jmp short .4
.1:
        test byte [dword eax+ScoringLogType], 20h
        je short .3
        test bx, bx
        jl short .2
        xor ecx, ecx
        mov cl, byte [dword eax+ScoringLogMinute]
        cmp cx, bx
        jne short .3
.2:
        movsx eax, dx
        shl eax, 3
        mov word [ScoringLogCount], dx
        add eax, ScoringLogPeriod
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        inc edx
        add eax, byte 8
.4:
        movsx ecx, si
        cmp edx, ecx
        jl short .1
.5:
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PeriodEntryCount                                AA8B4  97 PC, low confidence
; Returns the number of entries in a period
;-----------------------------------------------------------------------------
PeriodEntryCount:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        mov dx, word [ScoringLogCount]
        mov si, word [GameLogCount]
        test dx, dx
        jl short .5
        mov edx, dword [ScoringLogPad]
        movsx eax, si
        sar edx, 10h
        dec eax
        cmp edx, eax
        jge short .5
        inc edx
        lea eax, [nosplit edx*8+00h]
        jmp short .4
.1:
        test byte [dword eax+ScoringLogType], 20h
        je short .3
        test bx, bx
        jl short .2
        xor ecx, ecx
        mov cl, byte [dword eax+ScoringLogMinute]
        cmp cx, bx
        jne short .3
.2:
        movsx eax, dx
        shl eax, 3
        mov word [ScoringLogCount], dx
        add eax, ScoringLogPeriod
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        inc edx
        add eax, byte 8
.4:
        movsx ecx, si
        cmp edx, ecx
        jl short .1
.5:
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ScoringEntryText                                AA92C  97 PC, low confidence
; Formats a scoring log entry
;-----------------------------------------------------------------------------
ScoringEntryText:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov esi, eax
        mov di, word [GameLogCount]
        xor eax, eax
        test si, si
        jge short .4
        xor edx, edx
        xor ebx, ebx
        jmp short .3
.1:
        test byte [dword edx+ScoringLogType], 20h
        je short .2
        inc eax
.2:
        inc ebx
        add edx, byte 8
.3:
        movsx ecx, di
        cmp ebx, ecx
        jge short .9
        jmp short .1
.4:
        xor edx, edx
        xor ebx, ebx
        jmp short .8
.5:
        test byte [dword edx+ScoringLogType], 20h
        je short .7
        xor ecx, ecx
        mov cl, byte [dword edx+ScoringLogMinute]
        cmp cx, si
        jne short .6
        inc eax
        jmp short .7
.6:
        jg short .9
.7:
        inc ebx
        add edx, byte 8
.8:
        movsx ecx, di
        cmp ebx, ecx
        jl short .5
.9:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        mov si, word [GameLogCount]
        test si, si
        jl short .14
        xor eax, eax
        xor edx, edx
        jmp short .13
.10:
        test byte [dword eax+ScoringLogType], 40h
        je short .12
        test bx, bx
        jl short .11
        xor ecx, ecx
        mov cl, byte [dword eax+ScoringLogMinute]
        cmp cx, bx
        jne short .12
.11:
        mov eax, 1
        mov word [PenaltyLogCount], dx
        mov word [ScoringLogCount], dx
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.12:
        inc edx
        add eax, byte 8
.13:
        movsx ecx, si
        cmp edx, ecx
        jl short .10
.14:
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov esi, eax
        mov di, word [GameLogCount]
        xor ecx, ecx
        test ax, ax
        jge short .15
        movsx ecx, di
        jmp short .20
.15:
        xor edx, edx
        xor eax, eax
        jmp short .19
.16:
        xor ebx, ebx
        mov bl, byte [dword edx+ScoringLogMinute]
        cmp bx, si
        jne short .17
        inc ecx
        jmp short .18
.17:
        jg short .20
.18:
        inc eax
        add edx, byte 8
.19:
        movsx ebx, di
        cmp eax, ebx
        jl short .16
.20:
        mov eax, ecx
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        mov ax, word [GameLogCount]
        test ax, ax
        jle short NoScoringEntry
        cwde
        mov al, byte [nosplit eax*8+ScoringLogPrevMinute]
        and eax, 0FFh
        ret
;-----------------------------------------------------------------------------
; NoScoringEntry                                  AAA51  97 PC, low confidence
; Returns -1 (no entry)
;-----------------------------------------------------------------------------
NoScoringEntry:
        mov eax, 0FFFFFFFFh
        ret
        db 090h
;-----------------------------------------------------------------------------
; GoalTypeSuffix                                  AAA58  97 PC, low confidence
; The scoring summary goal suffix: " (en/pp)", " (pp)", " (en/sh)", " (sh)",
; " (en)"
;-----------------------------------------------------------------------------
GoalTypeSuffix:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 40h
        mov ecx, eax
        mov esi, edx
        mov edi, ebx
        test eax, eax
        je near .18
        test byte [byte eax+03h], 20h
        je near .18
        xor dl, dl
        mov byte [byte esp+03Ch], dl
        cmp byte [byte ecx+04h], 0
        jne short .1
        mov edx, AutoLineData
        jmp short .2
.1:
        mov edx, homelines
.2:
        mov bl, byte [byte ecx+03h]
        test bl, 1
        je short .4
        test bl, 4
        je short .3
        mov eax, 109h
        call GetLangText
        mov ebx, eax
        jmp short .8
.3:
        mov eax, 106h
        call GetLangText
        mov ebx, eax
        jmp short .8
.4:
        test bl, 2
        je short .6
        test bl, 4
        je short .5
        mov eax, 10Ah
        call GetLangText
        mov ebx, eax
        jmp short .8
.5:
        mov eax, 107h
        call GetLangText
        mov ebx, eax
        jmp short .8
.6:
        test bl, 4
        je short .7
        mov eax, 108h
        call GetLangText
        mov ebx, eax
        jmp short .8
.7:
        lea ebx, [byte esp+03Ch]
.8:
        lea eax, [byte edx+026h]
        mov dword [byte esp+034h], eax
        cmp byte [byte ecx+05h], 19h
        jae short .9
        xor eax, eax
        mov al, byte [byte ecx+05h]
        imul eax, dword 125h
        lea ebp, [dword edx+0A3h]
        add ebp, eax
        add ebp, byte 8
        mov al, byte [dword edx+eax+015Fh]
        jmp short .10
.9:
        xor eax, eax
        mov al, byte [byte ecx+05h]
        lea ebp, [byte eax-019h]
        imul eax, dword 125h
        imul ebp, dword 125h
        mov dword [byte esp+02Ch], ebp
        lea ebp, [dword edx+01D42h]
        add ebp, dword [byte esp+02Ch]
        add ebp, byte 8
        mov al, byte [dword edx+eax+01DFEh]
.10:
        mov dword [byte esp+030h], ebp
        and eax, 0FFh
        mov dword [byte esp+038h], eax
        mov ah, byte [byte ecx+06h]
        test ah, ah
        jl short .13
        cmp ah, 19h
        jge short .11
        mov eax, dword [byte ecx+03h]
        sar eax, 18h
        imul eax, dword 125h
        mov dword [byte esp+02Ch], eax
        mov ebp, dword [byte esp+02Ch]
        lea eax, [dword edx+0A3h]
        jmp short .12
.11:
        mov eax, dword [byte ecx+03h]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        lea ebp, [dword edx+01D42h]
.12:
        add eax, ebp
        add eax, byte 8
        push eax
        push str_S6
        lea eax, [byte esp+01Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        push str_Punct_GoalTypeSuffix
        lea eax, [byte esp+02Ch]
        push eax
        call sprintf_
        add esp, byte 8
        jmp short .14
.13:
        xor al, al
        mov byte [byte esp+028h], al
        mov byte [byte esp+014h], al
.14:
        mov ah, byte [byte ecx+07h]
        test ah, ah
        jl short .16
        cmp ah, 19h
        jge short .15
        mov eax, dword [byte ecx+04h]
        sar eax, 18h
        imul eax, dword 125h
        add edx, 0A3h
        add edx, eax
        add edx, byte 8
        push edx
        push str_S7
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        jmp short .17
.15:
        mov eax, dword [byte ecx+04h]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        add edx, 1D42h
        add eax, edx
        add eax, byte 8
        push eax
        push str_S7
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        jmp short .17
.16:
        xor dl, dl
        mov byte [esp], dl
.17:
        xor eax, eax
        mov al, byte [byte ecx+01h]
        push eax
        xor eax, eax
        mov al, byte [ecx]
        push eax
        push ebx
        lea eax, [byte esp+034h]
        push eax
        lea eax, [byte esp+010h]
        push eax
        lea eax, [byte esp+028h]
        push eax
        mov eax, dword [byte esp+050h]
        push eax
        mov edx, dword [byte esp+04Ch]
        push edx
        mov ebx, dword [byte esp+054h]
        push ebx
        push edi
        push str_DSSDSSSSD02d
        push esi
        call sprintf_
        add esp, byte 30h
.18:
        mov eax, esi
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; FormatGoalLine                                  AAC7C  97 PC, low confidence
; Scoring summary: one goal line "%s %s (%s%s%s%s%s) %d:%02d"
;-----------------------------------------------------------------------------
FormatGoalLine:
        push ebx
        push ecx
        push esi
        push edi
        sub esp, byte 18h
        mov ebx, eax
        test eax, eax
        je near .10
        test byte [byte eax+03h], 80h
        je near .10
        mov al, 2Ch
        lea esi, [byte esp+014h]
        mov byte [esp], al
        mov ah, 20h
        xor cl, cl
        mov byte [byte esp+01h], ah
        xor al, al
        mov byte [byte esp+014h], cl
        mov byte [byte esp+02h], al
        mov dword [byte esp+010h], esi
        mov ah, byte [byte ebx+04h]
        lea ecx, [byte esp+014h]
        test ah, ah
        jne short .1
        mov eax, AutoLineData
        jmp short .2
.1:
        mov eax, homelines
.2:
        lea edi, [byte eax+026h]
        mov dword [byte esp+08h], edi
        cmp byte [byte ebx+05h], 19h
        jae short .3
        movzx edi, byte [byte ebx+05h]
        imul edi, dword 125h
        add eax, 0A3h
        jmp short .4
.3:
        movzx edi, byte [byte ebx+05h]
        sub edi, byte 19h
        imul edi, dword 125h
        add eax, 1D42h
.4:
        add edi, eax
        add edi, byte 8
        mov al, byte [byte ebx+06h]
        and al, 1Fh
        cmp al, 1
        jne short .5
        xor eax, eax
        mov al, byte [byte ebx+06h]
        sar eax, 5
        mov dword [byte esp+04h], eax
        mov al, byte [byte esp+04h]
        and eax, 0FFh
        add eax, 125h
        call GetLangText
        mov dword [byte esp+0Ch], eax
        jmp short .6
.5:
        and eax, 0FFh
        add eax, 109h
        call GetLangText
        mov dword [byte esp+0Ch], eax
        xor eax, eax
        mov al, byte [byte ebx+06h]
        sar eax, 5
        and eax, 0FFh
        add eax, 120h
        call GetLangText
        mov dword [byte esp+010h], eax
.6:
        mov al, byte [byte ebx+07h]
        and al, 1Fh
        cmp al, 1
        jne short .7
        xor eax, eax
        mov al, byte [byte ebx+07h]
        sar eax, 5
        and eax, 0FFh
        add eax, 125h
        call GetLangText
        mov ecx, eax
        jmp short .9
.7:
        test al, al
        je short .8
        and eax, 0FFh
        add eax, 109h
        call GetLangText
        mov ecx, eax
        xor eax, eax
        mov al, byte [byte ebx+07h]
        sar eax, 5
        and eax, 0FFh
        add eax, 120h
        call GetLangText
        mov esi, eax
        jmp short .9
.8:
        mov byte [esp], al
.9:
        xor eax, eax
        mov al, byte [byte ebx+01h]
        push eax
        xor eax, eax
        mov al, byte [ebx]
        push eax
        push esi
        push ecx
        lea eax, [byte esp+010h]
        push eax
        mov ebx, dword [byte esp+024h]
        push ebx
        mov ecx, dword [byte esp+024h]
        push ecx
        mov esi, dword [byte esp+024h]
        push esi
        push edi
        push str_SSSSSSSD02d
        push edx
        call sprintf_
        add esp, byte 2Ch
.10:
        mov eax, edx
        add esp, byte 18h
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
