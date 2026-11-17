; Trades: roster limits, slots, rating and applying a trade.
bits 32
%include "hockey.inc"
section s_CB216 progbits alloc exec nowrite align=1
extern __STOSB, BlitShape, BuildAutoLines, ClampRosterScroll, CreateRosterPanel, DrawPlayerCard_2B8, DrawRatingBars_157, DrawRatingBars_158
extern DrawRosterTitle, FixLinesAfterTrade, FreeRosterPanel, GetLangText, GetPlayerStatLine, JerseyChoice, JerseyScreen, NewPlayerRecord
extern RemoveListEntry, RosterEditOpen, RosterMode, RosterOtherTeam, RosterPanelBitmap, RosterPanelShape, RosterTeam, RosterTeams
extern SetDrawTarget, ShowMessageBox, ShowRosterLogo, sprintf_, str_SS11, stricmp_, UpdateRosterCounts
global ShowTradeRejected, ShowTradeRejected_F7, ShowTradeRejected_100, ShowTradeRejected_102, ShowTradeRejected_108, CheckRosterLimits, CheckRegularRosterLimits, RosterTradeScreen
global RosterTradeScreen_306, FindFreeRosterSlot, FindFreeRosterSlot_EE, FindRosterSlot, SwapRosterPlayers, ComparePlayersForTradeJumpTable, ComparePlayersForTrade, ComparePlayersForTrade_59
global ComparePlayersForTrade_D9, ComparePlayersForTrade_133, ComparePlayersForTrade_17B, RateTrade, TradeValue, TradeNeedBonus, ApplyTrade, CountRosterPositions
global ClearPlayerRecord
;-----------------------------------------------------------------------------
; ShowTradeRejected                               CB216  97 PC, low confidence
; Roster screen: "Rejected by %s."
;-----------------------------------------------------------------------------
ShowTradeRejected:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 8Ch, 0
        sub ebp, 82h
        xor esi, esi
        cmp dword [RosterMode], byte 0
        jne short .2
        imul eax, dword [RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        cmp byte [byte ebx+eax+071h], 0
        jbe short .1
        imul eax, dword [RosterOtherTeam], dword 32C6h
        cmp byte [byte ebx+eax+071h], 0
        jbe short .1
        xor eax, eax
        jmp near ShowTradeRejected_102
.1:
        mov eax, 1
        jmp near ShowTradeRejected_102
.2:
        mov dword [byte ebp+076h], esi
        mov dword [byte ebp+07Ah], esi
        xor ecx, ecx
.3:
        xor edi, edi
        jmp short .5
.4:
        movzx eax, byte [byte edi+eax+06Eh]
        mov edx, eax
        mov eax, ecx
        inc edi
        call GetPlayerStatLine
        add dword [byte ebx+ebp+076h], eax
.5:
        mov ebx, ecx
        shl ebx, 2
        imul eax, dword [dword ebx+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        mov dword [byte ebp+07Eh], edx
        movzx edx, byte [byte eax+071h]
        cmp edi, edx
        jl short .4
        inc ecx
        cmp ecx, byte 2
        jl short .3
        mov eax, dword [byte ebp+07Ah]
        add eax, byte 0Fh
        cmp eax, dword [byte ebp+076h]
        jge short .6
        imul eax, dword [RosterTeam], dword 32C6h
        jmp short .7
.6:
        mov eax, dword [byte ebp+076h]
        add eax, byte 0Fh
        cmp eax, dword [byte ebp+07Ah]
        jge short .8
        imul eax, dword [RosterOtherTeam], dword 32C6h
.7:
        add eax, dword [byte ebp+07Eh]
        add eax, byte 42h
        push eax
        mov eax, 0D9h
        call GetLangText
        push eax
        lea eax, [byte ebp-0Ah]
        push eax
        mov esi, 1
        call sprintf_
        add esp, byte 0Ch
.8:
        test esi, esi
        je short ShowTradeRejected_100
        push byte 1
        mov edx, 1
        lea eax, [byte ebp-0Ah]
ShowTradeRejected_F7:
        xor ecx, ecx
        xor ebx, ebx
        call ShowMessageBox
ShowTradeRejected_100:
        mov eax, esi
ShowTradeRejected_102:
        lea esp, [dword ebp+082h]
ShowTradeRejected_108:
        pop ebp
        jmp near DrawRatingBars_158
;-----------------------------------------------------------------------------
; CheckRosterLimits                               CB324  97 PC, low confidence
; Roster: the minimum / maximum roster and goalie count checks ("Roster
; Violation: %s must have...")
;-----------------------------------------------------------------------------
CheckRosterLimits:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 0C4h, 0
        sub ebp, 82h
        mov dword [byte ebp+07Eh], 0
        xor eax, eax
.1:
        inc eax
        mov dword [byte ebp+eax*4+062h], 0
        mov dword [byte ebp+eax*4+05Ah], 0
        mov dword [byte ebp+eax*4+052h], 0
        mov dword [byte ebp+eax*4+04Ah], 0
        cmp eax, byte 2
        jl short .1
        xor edx, edx
.2:
        imul ecx, dword [nosplit edx*4+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        mov ebx, dword [ecx+ebx]
        movsx esi, word [dword ebx+0D05h]
        movsx ebx, word [dword ebx+0132Bh]
        add esi, ebx
        mov dword [byte ebp+edx*4+076h], esi
        mov ebx, dword [RosterTeams]
        mov ebx, dword [ecx+ebx]
        movsx ecx, word [dword ebx+01281h]
        movsx ebx, word [dword ebx+018A5h]
        mov eax, edx
        add ecx, ebx
        xor eax, edx
        mov dword [byte ebp+edx*4+06Eh], ecx
        jmp short .5
.3:
        imul esi, eax, byte 38h
        test byte [dword ecx+esi+0D09h], 4
        jne short .4
        inc dword [byte ebx+ebp+066h]
.4:
        inc eax
.5:
        mov ebx, edx
        shl ebx, 2
        imul ecx, dword [dword ebx+RosterTeam], dword 32C6h
        mov esi, dword [RosterTeams]
        mov ecx, dword [ecx+esi]
        movsx esi, word [dword ecx+0D05h]
        cmp eax, esi
        jl short .3
        xor eax, eax
        jmp short .8
.6:
        imul esi, eax, byte 38h
        test byte [dword ecx+esi+01283h], 4
        jne short .7
        inc dword [byte ebx+ebp+05Eh]
.7:
        inc eax
.8:
        mov ebx, edx
        shl ebx, 2
        imul ecx, dword [dword ebx+RosterTeam], dword 32C6h
        mov esi, dword [RosterTeams]
        mov ecx, dword [ecx+esi]
        movsx esi, word [dword ecx+01281h]
        cmp eax, esi
        jl short .6
        xor eax, eax
        jmp short .11
.9:
        imul esi, eax, byte 38h
        test byte [dword ecx+esi+0132Dh], 4
        jne short .10
        inc dword [byte ebx+ebp+066h]
.10:
        inc eax
.11:
        mov ebx, edx
        shl ebx, 2
        imul ecx, dword [dword ebx+RosterTeam], dword 32C6h
        mov esi, dword [RosterTeams]
        mov ecx, dword [ecx+esi]
        movsx esi, word [dword ecx+0132Bh]
        cmp eax, esi
        jl short .9
        xor eax, eax
        jmp short .14
.12:
        imul esi, eax, byte 38h
        test byte [dword ecx+esi+018A7h], 4
        jne short .13
        inc dword [byte ebx+ebp+05Eh]
.13:
        inc eax
.14:
        mov ebx, edx
        shl ebx, 2
        imul ecx, dword [dword ebx+RosterTeam], dword 32C6h
        mov esi, dword [RosterTeams]
        mov ecx, dword [ecx+esi]
        movsx esi, word [dword ecx+018A5h]
        cmp eax, esi
        jl short .12
        inc edx
        cmp edx, byte 2
        jl near .2
        xor edx, edx
.15:
        xor eax, eax
        jmp short .21
.16:
        movzx esi, byte [byte ecx+eax+06Eh]
        mov ecx, dword [ecx]
        movsx edi, word [dword ecx+0D05h]
        cmp esi, edi
        jge short .18
.17:
        inc dword [byte ebx+ebp+056h]
        jmp short .20
.18:
        sub esi, edi
        movsx edi, word [dword ecx+01281h]
        cmp esi, edi
        jl short .19
        sub esi, edi
        movsx edi, word [dword ecx+0132Bh]
        cmp esi, edi
        jl short .17
        movsx ecx, word [dword ecx+018A5h]
        sub esi, edi
        cmp esi, ecx
        jge short .20
.19:
        inc dword [byte ebx+ebp+04Eh]
.20:
        inc eax
.21:
        mov ebx, edx
        shl ebx, 2
        imul ecx, dword [dword ebx+RosterTeam], dword 32C6h
        mov esi, dword [RosterTeams]
        add ecx, esi
        movzx esi, byte [byte ecx+071h]
        cmp eax, esi
        jl short .16
        inc edx
        cmp edx, byte 2
        jl short .15
        xor edx, edx
.22:
        mov eax, edx
        shl eax, 2
        mov ebx, 1
        mov ecx, dword [byte eax+ebp+066h]
        sub ebx, edx
        sub ecx, dword [byte eax+ebp+056h]
        add ecx, dword [byte ebp+ebx*4+056h]
        cmp ecx, byte 12h
        jge short .23
        imul eax, dword [dword eax+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        add eax, ebx
        add eax, byte 42h
        push eax
        mov eax, 0DAh
        call GetLangText
        push eax
        lea eax, [byte ebp-042h]
        push eax
        mov dword [byte ebp+07Eh], 1
        call sprintf_
        add esp, byte 0Ch
.23:
        mov eax, edx
        shl eax, 2
        mov ebx, 1
        mov ecx, dword [byte eax+ebp+05Eh]
        sub ebx, edx
        sub ecx, dword [byte eax+ebp+04Eh]
        add ecx, dword [byte ebp+ebx*4+04Eh]
        cmp ecx, byte 2
        jge short .24
        imul eax, dword [dword eax+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        add eax, ebx
        add eax, byte 42h
        push eax
        mov eax, 0DBh
        call GetLangText
        push eax
        lea eax, [byte ebp-042h]
        push eax
        mov dword [byte ebp+07Eh], 1
        call sprintf_
        add esp, byte 0Ch
.24:
        mov eax, edx
        shl eax, 2
        mov ebx, 1
        mov ecx, dword [byte eax+ebp+076h]
        sub ebx, edx
        sub ecx, dword [byte eax+ebp+056h]
        add ecx, dword [byte ebp+ebx*4+056h]
        add ecx, dword [byte eax+ebp+06Eh]
        sub ecx, dword [byte eax+ebp+04Eh]
        add ecx, dword [byte ebp+ebx*4+04Eh]
        cmp ecx, byte 17h
        jge short .25
        imul eax, dword [dword eax+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        add eax, ebx
        add eax, byte 42h
        push eax
        mov eax, 0DCh
        call GetLangText
        push eax
        lea eax, [byte ebp-042h]
        push eax
        mov dword [byte ebp+07Eh], 1
        call sprintf_
        add esp, byte 0Ch
.25:
        mov eax, edx
        shl eax, 2
        mov ebx, 1
        mov ecx, dword [byte eax+ebp+076h]
        sub ebx, edx
        sub ecx, dword [byte eax+ebp+056h]
        add ecx, dword [byte ebp+ebx*4+056h]
        cmp ecx, byte 32h
        jle short .26
        imul eax, dword [dword eax+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        add eax, ebx
        add eax, byte 42h
        push eax
        mov eax, 0DDh
        call GetLangText
        push eax
        lea eax, [byte ebp-042h]
        push eax
        mov dword [byte ebp+07Eh], 1
        call sprintf_
        add esp, byte 0Ch
.26:
        mov eax, edx
        shl eax, 2
        mov ebx, 1
        mov ecx, dword [byte eax+ebp+06Eh]
        sub ebx, edx
        sub ecx, dword [byte eax+ebp+04Eh]
        add ecx, dword [byte ebp+ebx*4+04Eh]
        cmp ecx, byte 6
        jle short .27
        imul ebx, dword [dword eax+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        add eax, ebx
        add eax, byte 42h
        push eax
        mov eax, 0DEh
        call GetLangText
        push eax
        lea eax, [byte ebp-042h]
        push eax
        mov dword [byte ebp+07Eh], 1
        call sprintf_
        add esp, byte 0Ch
.27:
        inc edx
        cmp edx, byte 2
        jl near .22
        cmp dword [byte ebp+07Eh], byte 0
        je short .28
        push byte 1
        mov edx, 1
        lea eax, [byte ebp-042h]
        xor ecx, ecx
        xor ebx, ebx
        call ShowMessageBox
.28:
        mov eax, dword [byte ebp+07Eh]
        jmp near ShowTradeRejected_102
;-----------------------------------------------------------------------------
; CheckRegularRosterLimits                        CB6D5  97 PC, low confidence
; Roster: the non-injured minimum and regular / additional roster maximum
; checks
;-----------------------------------------------------------------------------
CheckRegularRosterLimits:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 0A8h, 0
        sub ebp, 82h
        mov ecx, eax
        xor esi, esi
        xor ebx, ebx
        mov dword [byte ebp+06Eh], esi
        mov dword [byte ebp+05Eh], esi
        mov dword [byte ebp+06Ah], esi
        mov dword [byte ebp+066h], esi
        mov dword [byte ebp+062h], esi
        mov dword [byte ebp+05Ah], esi
        mov dword [byte ebp+07Eh], esi
        mov dword [byte ebp+072h], esi
        mov dword [byte ebp+076h], esi
        mov dword [byte ebp+07Ah], esi
        jmp short .3
.1:
        imul edx, ebx, byte 38h
        test byte [dword edx+eax+0D09h], 4
        jne short .2
        inc dword [byte ebp+06Eh]
.2:
        inc ebx
.3:
        imul eax, dword [nosplit ecx*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx edx, word [dword eax+0D05h]
        cmp ebx, edx
        jl short .1
        xor ebx, ebx
        jmp short .6
.4:
        imul edx, ebx, byte 38h
        test byte [dword edx+eax+01283h], 4
        jne short .5
        inc dword [byte ebp+05Eh]
.5:
        inc ebx
.6:
        imul eax, dword [nosplit ecx*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx edx, word [dword eax+01281h]
        cmp ebx, edx
        jl short .4
        xor ebx, ebx
        jmp near .12
.7:
        movzx edx, byte [byte ebx+eax+06Eh]
        mov eax, dword [eax]
        movsx edi, word [dword eax+0D05h]
        cmp edx, edi
        jge short .8
        imul edx, byte 38h
        inc dword [byte ebp+07Eh]
        test byte [dword edx+eax+0D09h], 4
        jne near .11
        inc dword [byte ebp+06Ah]
        jmp near .11
.8:
        sub edx, edi
        movsx edi, word [dword eax+01281h]
        cmp edx, edi
        jge short .9
        imul edx, byte 38h
        inc dword [byte ebp+072h]
        test byte [dword edx+eax+01283h], 4
        jne short .11
        inc dword [byte ebp+066h]
        jmp short .11
.9:
        sub edx, edi
        movsx edi, word [dword eax+0132Bh]
        cmp edx, edi
        jge short .10
        imul edx, byte 38h
        inc dword [byte ebp+076h]
        test byte [dword edx+eax+0132Dh], 4
        jne short .11
        inc dword [byte ebp+062h]
        jmp short .11
.10:
        sub edx, edi
        movsx edi, word [dword eax+018A5h]
        cmp edx, edi
        jge short .11
        imul edx, byte 38h
        inc dword [byte ebp+07Ah]
        test byte [dword edx+eax+018A7h], 4
        jne short .11
        inc dword [byte ebp+05Ah]
.11:
        inc ebx
.12:
        imul eax, dword [nosplit ecx*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        movzx edx, byte [byte eax+071h]
        cmp ebx, edx
        jl near .7
        mov edx, dword [byte ebp+06Eh]
        sub edx, dword [byte ebp+06Ah]
        add edx, dword [byte ebp+062h]
        cmp edx, byte 12h
        jge short .13
        add eax, byte 42h
        push eax
        mov eax, 0DFh
        call GetLangText
        push eax
        lea eax, [byte ebp-026h]
        push eax
        mov esi, 1
        call sprintf_
        add esp, byte 0Ch
.13:
        mov eax, dword [byte ebp+05Eh]
        sub eax, dword [byte ebp+066h]
        add eax, dword [byte ebp+05Ah]
        cmp eax, byte 2
        jge short .14
        imul eax, dword [nosplit ecx*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        add eax, byte 42h
        push eax
        mov eax, 0E0h
        call GetLangText
        push eax
        lea eax, [byte ebp-026h]
        push eax
        mov esi, 1
        call sprintf_
        add esp, byte 0Ch
.14:
        imul eax, dword [nosplit ecx*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        mov edx, dword [eax]
        movsx edx, word [dword edx+0D05h]
        sub edx, dword [byte ebp+07Eh]
        add edx, dword [byte ebp+076h]
        cmp edx, byte 19h
        jle short .15
        add eax, byte 42h
        push eax
        mov eax, 0E1h
        call GetLangText
        push eax
        lea eax, [byte ebp-026h]
        push eax
        mov esi, 1
        call sprintf_
        add esp, byte 0Ch
.15:
        imul eax, dword [nosplit ecx*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        mov edx, dword [eax]
        movsx edx, word [dword edx+01281h]
        sub edx, dword [byte ebp+072h]
        add edx, dword [byte ebp+07Ah]
        cmp edx, byte 3
        jle short .16
        add eax, byte 42h
        push eax
        mov eax, 0E2h
        call GetLangText
        push eax
        lea eax, [byte ebp-026h]
        push eax
        mov esi, 1
        call sprintf_
        add esp, byte 0Ch
.16:
        imul eax, dword [nosplit ecx*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        mov edx, dword [eax]
        movsx edx, word [dword edx+0132Bh]
        sub edx, dword [byte ebp+076h]
        add edx, dword [byte ebp+07Eh]
        cmp edx, byte 19h
        jle short .17
        add eax, byte 42h
        push eax
        mov eax, 0E3h
        call GetLangText
        push eax
        lea eax, [byte ebp-026h]
        push eax
        mov esi, 1
        call sprintf_
        add esp, byte 0Ch
.17:
        imul eax, dword [nosplit ecx*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        mov edx, dword [eax]
        movsx edx, word [dword edx+018A5h]
        sub edx, dword [byte ebp+07Ah]
        add edx, dword [byte ebp+072h]
        cmp edx, byte 3
        jle short .18
        add eax, byte 42h
        push eax
        mov eax, 0E4h
        call GetLangText
        push eax
        lea eax, [byte ebp-026h]
        push eax
        mov esi, 1
        call sprintf_
        add esp, byte 0Ch
.18:
        test esi, esi
        je near ShowTradeRejected_100
        push byte 1
        mov edx, 1
        lea eax, [byte ebp-026h]
        jmp near ShowTradeRejected_F7
;-----------------------------------------------------------------------------
; RosterTradeScreen                               CB9C9  97 PC, low confidence
; Runs the trade part of the roster screen
;-----------------------------------------------------------------------------
RosterTradeScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 71Ch, 0
        xor esi, esi
.1:
        imul edx, dword [nosplit esi*4+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        or byte [byte edx+ebx+06Ah], 2
        imul ebx, dword [nosplit esi*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        movzx edx, byte [byte edx+ebx+071h]
        xor edi, edi
        mov dword [byte ebp+esi*4-01Ch], edx
        jmp short .3
.2:
        imul ebx, esi, dword 354h
        lea eax, [dword ebp-071Ch]
        add ebx, eax
        imul eax, edi, dword 11Ch
        mov ecx, 0FFFFFFFFh
        xor edx, edx
        add ebx, eax
        mov eax, esi
        call ApplyTrade
        mov edx, eax
        imul eax, esi, byte 0Ch
        mov ebx, edi
        shl ebx, 2
        add eax, ebx
        inc edi
        mov dword [byte eax+ebp-034h], edx
.3:
        cmp edi, dword [byte ebp+esi*4-01Ch]
        jl short .2
        inc esi
        cmp esi, byte 2
        jl short .1
        call FreeRosterPanel
        xor esi, esi
.4:
        xor edi, edi
        jmp near .12
.5:
        imul eax, esi, dword 354h
        imul ebx, edi, dword 11Ch
        mov dword [byte ebp-0Ch], eax
        add eax, ebx
        mov dword [byte ebp-08h], eax
        mov al, byte [dword eax+ebp-071Bh]
        mov ecx, 1
        movzx eax, al
        sub ecx, esi
        mov dword [byte ebp-010h], eax
        mov edx, eax
        mov eax, ecx
        call CountRosterPositions
        test eax, eax
        je short .6
        mov eax, ecx
        call ClearPlayerRecord
        lea eax, [dword ebp-071Ch]
        add eax, dword [byte ebp-0Ch]
        add ebx, eax
        lea eax, [byte ebx+067h]
        push eax
        add ebx, byte 77h
        push ebx
        push str_SS11
        lea eax, [byte ebp-074h]
        push eax
        mov edx, dword [byte ebp-010h]
        call sprintf_
        add esp, byte 10h
        lea ebx, [byte ebp-074h]
        mov eax, ecx
        call JerseyScreen
        mov edx, dword [byte ebp-08h]
        mov byte [dword edx+ebp-071Bh], al
.6:
        imul eax, edi, dword 11Ch
        imul edx, esi, dword 354h
        lea ecx, [dword ebp-071Ch]
        mov dword [byte ebp-014h], eax
        lea ebx, [eax+edx]
        mov eax, 1
        add ecx, edx
        sub eax, esi
        mov edx, eax
        add ecx, dword [byte ebp-014h]
        shl edx, 2
        cmp byte [dword ebx+ebp-071Ah], 47h
        jne short .8
        imul edx, dword [dword edx+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        add edx, ebx
        mov edx, dword [edx]
        cmp word [dword edx+01281h], byte 3
        jge short .7
        movsx ebx, word [dword edx+01281h]
        mov edx, 1
        jmp short .10
.7:
        movsx ebx, word [dword edx+018A5h]
        mov edx, 3
        jmp short .10
.8:
        imul edx, dword [dword edx+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        add edx, ebx
        mov edx, dword [edx]
        cmp word [dword edx+0D05h], byte 19h
        jge short .9
        movsx ebx, word [dword edx+0D05h]
        xor edx, edx
        jmp short .10
.9:
        movsx ebx, word [dword edx+0132Bh]
        mov edx, 2
.10:
        call UpdateRosterCounts
        mov dword [byte ebp-04h], eax
        imul edx, esi, byte 0Ch
        mov eax, edi
        shl eax, 2
        add eax, edx
        cmp dword [byte eax+ebp-034h], byte 0
        jl short .11
        mov eax, 1
        sub eax, esi
        imul ebx, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add edx, ebx
        mov bl, byte [byte edx+071h]
        movzx ecx, bl
        inc bl
        mov byte [byte edx+071h], bl
        imul eax, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        add eax, ecx
        mov dl, byte [byte ebp-04h]
        mov byte [byte eax+06Eh], dl
.11:
        inc edi
.12:
        cmp edi, dword [byte ebp+esi*4-01Ch]
        jl near .5
        inc esi
        cmp esi, byte 2
        jl near .4
        push dword [RosterPanelBitmap]
        call SetDrawTarget
        add esp, byte 4
        push dword [RosterPanelShape]
        call BlitShape
        add esp, byte 4
        call DrawRosterTitle
        call ShowRosterLogo
        call CreateRosterPanel
        xor eax, eax
        mov dword [RosterEditOpen], 1
        call SwapRosterPlayers
        mov eax, 1
        call SwapRosterPlayers
        xor eax, eax
        call RateTrade
        mov eax, 1
        xor esi, esi
        call RateTrade
.13:
        mov eax, 64h
        xor edi, edi
        jmp short .16
.14:
        movzx edx, byte [byte edx+edi+06Eh]
        cmp edx, eax
        jge short .15
        mov eax, edx
.15:
        inc edi
.16:
        imul edx, dword [nosplit esi*4+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        add edx, ebx
        movzx ebx, byte [byte edx+071h]
        cmp edi, ebx
        jl short .14
        mov edx, eax
        mov eax, esi
        inc esi
        call ClampRosterScroll
        cmp esi, byte 2
        jl short .13
        imul eax, dword [RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        call BuildAutoLines
        imul edx, dword [RosterOtherTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [edx+eax]
        call BuildAutoLines
        imul edx, dword [RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [edx+eax]
        call RemoveListEntry
        imul eax, dword [RosterOtherTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
RosterTradeScreen_306:
        call RemoveListEntry
        jmp near DrawRatingBars_157
;-----------------------------------------------------------------------------
; FindFreeRosterSlot                              CBCD9  97 PC, low confidence
; Finds a free slot in the roster
;-----------------------------------------------------------------------------
FindFreeRosterSlot:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        mov eax, 1
        mov edx, 0FFFFFFFFh
        jmp short .3
.1:
        imul esi, eax, byte 38h
        test byte [dword ecx+esi+0132Dh], 4
        jne short .2
        mov edx, eax
        jmp short .4
.2:
        inc eax
.3:
        imul ecx, ebx, dword 32C6h
        mov esi, dword [RosterTeams]
        mov ecx, dword [ecx+esi]
        movsx esi, word [dword ecx+0132Bh]
        cmp eax, esi
        jl short .1
.4:
        test edx, edx
        jge short .8
        mov eax, 1
        xor edx, edx
        jmp short .7
.5:
        lea esi, [edx+edx]
        lea edi, [eax+eax]
        add esi, ecx
        add ecx, edi
        mov si, word [dword esi+0328Eh]
        cmp si, word [dword ecx+0328Eh]
        jge short .6
        mov edx, eax
.6:
        inc eax
.7:
        imul ecx, ebx, dword 32C6h
        mov esi, dword [RosterTeams]
        add ecx, esi
        mov esi, dword [ecx]
        movsx esi, word [dword esi+0132Bh]
        cmp eax, esi
        jl short .5
        jmp short .12
.8:
        lea eax, [byte edx+01h]
        jmp short .11
.9:
        imul edi, eax, byte 38h
        add esi, edi
        test byte [dword esi+0132Dh], 4
        jne short .10
        lea esi, [edx+edx]
        lea edi, [eax+eax]
        add esi, ecx
        add ecx, edi
        mov si, word [dword esi+0328Eh]
        cmp si, word [dword ecx+0328Eh]
        jge short .10
        mov edx, eax
.10:
        inc eax
.11:
        imul ecx, ebx, dword 32C6h
        mov esi, dword [RosterTeams]
        add ecx, esi
        mov esi, dword [ecx]
        movsx edi, word [dword esi+0132Bh]
        cmp eax, edi
        jl short .9
.12:
        imul eax, ebx, dword 32C6h
        mov ebx, dword [RosterTeams]
        mov eax, dword [ebx+eax]
        movsx ebx, word [dword eax+0D05h]
        movsx eax, word [dword eax+01281h]
FindFreeRosterSlot_EE:
        add eax, ebx
        add eax, edx
        jmp near DrawRatingBars_158
;-----------------------------------------------------------------------------
; FindRosterSlot                                  CBDD0  97 PC, low confidence
; Finds a player's slot in the roster
;-----------------------------------------------------------------------------
FindRosterSlot:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ecx, eax
        mov eax, 1
        mov edx, 0FFFFFFFFh
        jmp short .3
.1:
        imul esi, eax, byte 38h
        test byte [dword esi+ebx+018A7h], 4
        jne short .2
        mov edx, eax
        jmp short .4
.2:
        inc eax
.3:
        imul ebx, ecx, dword 32C6h
        mov esi, dword [RosterTeams]
        mov ebx, dword [esi+ebx]
        movsx esi, word [dword ebx+018A5h]
        cmp eax, esi
        jl short .1
.4:
        test edx, edx
        jge short .8
        mov eax, 1
        xor edx, edx
        jmp short .7
.5:
        lea esi, [edx+edx]
        lea edi, [eax+eax]
        add esi, ebx
        add ebx, edi
        mov si, word [dword esi+032C0h]
        cmp si, word [dword ebx+032C0h]
        jge short .6
        mov edx, eax
.6:
        inc eax
.7:
        imul ebx, ecx, dword 32C6h
        mov esi, dword [RosterTeams]
        add ebx, esi
        mov esi, dword [ebx]
        movsx esi, word [dword esi+0132Bh]
        cmp eax, esi
        jl short .5
        jmp short .12
.8:
        lea eax, [byte edx+01h]
        jmp short .11
.9:
        imul edi, eax, byte 38h
        add esi, edi
        test byte [dword esi+018A7h], 4
        jne short .10
        lea esi, [edx+edx]
        lea edi, [eax+eax]
        add esi, ebx
        add ebx, edi
        mov si, word [dword esi+032C0h]
        cmp si, word [dword ebx+032C0h]
        jge short .10
        mov edx, eax
.10:
        inc eax
.11:
        imul ebx, ecx, dword 32C6h
        mov esi, dword [RosterTeams]
        add ebx, esi
        mov esi, dword [ebx]
        movsx edi, word [dword esi+018A5h]
        cmp eax, edi
        jl short .9
.12:
        imul ecx, dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [ecx+eax]
        movsx ebx, word [dword eax+0D05h]
        movsx ecx, word [dword eax+01281h]
        movsx eax, word [dword eax+0132Bh]
        add ebx, ecx
        jmp near FindFreeRosterSlot_EE
;-----------------------------------------------------------------------------
; SwapRosterPlayers                               CBECB  97 PC, low confidence
; Swaps two players between rosters
;-----------------------------------------------------------------------------
SwapRosterPlayers:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 124h, 0
        mov esi, eax
        mov edi, dword [nosplit eax*4+RosterTeam]
.1:
        imul eax, edi, dword 32C6h
        mov dword [byte ebp-04h], eax
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp-04h]
        mov eax, dword [eax]
        cmp word [dword eax+0D05h], byte 19h
        jge short .2
        cmp word [dword eax+0132Bh], byte 0
        jle short .2
        mov eax, edi
        lea ebx, [dword ebp-0124h]
        call FindFreeRosterSlot
        xor edx, edx
        mov ecx, eax
        mov eax, esi
        call ApplyTrade
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp-04h]
        mov eax, dword [eax]
        lea ecx, [dword ebp-0124h]
        xor edx, edx
        movsx ebx, word [dword eax+0D05h]
        mov eax, esi
        call UpdateRosterCounts
        jmp short .1
.2:
        imul eax, edi, dword 32C6h
        mov dword [byte ebp-08h], eax
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp-08h]
        mov eax, dword [eax]
        cmp word [dword eax+01281h], byte 3
        jge near DrawRatingBars_157
        cmp word [dword eax+018A5h], byte 0
        jle near DrawRatingBars_157
        mov eax, edi
        lea ebx, [dword ebp-0124h]
        call FindRosterSlot
        xor edx, edx
        mov ecx, eax
        mov eax, esi
        call ApplyTrade
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp-08h]
        mov eax, dword [eax]
        lea ecx, [dword ebp-0124h]
        mov edx, 1
        movsx ebx, word [dword eax+01281h]
        mov eax, esi
        call UpdateRosterCounts
        jmp short .2
ComparePlayersForTradeJumpTable:                ; jump table for the switch cases of ComparePlayersForTrade
        dd ComparePlayersForTrade_59
        dd ComparePlayersForTrade_D9
        dd ComparePlayersForTrade_133
        dd ComparePlayersForTrade_17B
;-----------------------------------------------------------------------------
; ComparePlayersForTrade                          CBFBA  97 PC, low confidence
; Compares two players for a trade
;-----------------------------------------------------------------------------
ComparePlayersForTrade:
        push esi
        push edi
        enter 34h, 0
        mov edi, eax
        mov esi, edx
        mov dword [byte ebp-034h], ebx
        xor dh, dh
        xor eax, eax
        xor dl, dl
        test edi, edi
        jl near ComparePlayersForTrade_59.2
        test esi, esi
        jl near ComparePlayersForTrade_59.2
        cmp ecx, byte 3
        ja near ComparePlayersForTrade_59.2
        imul ebx, esi, dword 0BCh
        mov dword [byte ebp-01Ch], ebx
        imul ebx, edi, dword 0BCh
        mov dword [byte ebp-018h], ebx
        imul ebx, esi, byte 38h
        mov dword [byte ebp-08h], ebx
        imul ebx, edi, byte 38h
        mov dword [byte ebp-04h], ebx
        imul ebx, dword [byte ebp-034h], dword 32C6h
        jmp dword [nosplit cs:ecx*4+ComparePlayersForTradeJumpTable]
ComparePlayersForTrade_59:
        mov ecx, dword [RosterTeams]
        add ecx, ebx
        mov ebx, dword [ecx]
        mov dword [byte ebp-030h], ecx
        movsx ecx, word [dword ebx+0D05h]
        cmp edi, ecx
        jge near .2
        cmp esi, ecx
        jge near .2
        mov edx, dword [byte ebp-04h]
        mov dh, byte [dword edx+ebx+0D0Bh]
        add ebx, dword [byte ebp-08h]
        mov dl, byte [dword ebx+0D0Bh]
        mov ebx, dword [byte ebp-030h]
        mov ecx, dword [byte ebp-018h]
        add ebx, 8FEh
.1:
        add ecx, ebx
        lea esi, [byte ecx+018h]
        add ebx, dword [byte ebp-01Ch]
        mov dword [byte ebp-010h], esi
        add ecx, byte 8
        lea esi, [byte ebx+018h]
        mov dword [byte ebp-020h], ecx
        add ebx, byte 8
        mov dword [byte ebp-0Ch], esi
        mov dword [byte ebp-014h], ebx
.2:
        cmp dh, dl
        je near ComparePlayersForTrade_17B.7
        cmp dh, 43h
        je short .3
        cmp dl, 44h
        jne near ComparePlayersForTrade_17B.4
.3:
        mov eax, 1
        jmp near ComparePlayersForTrade_17B.7
ComparePlayersForTrade_D9:
        mov ecx, dword [RosterTeams]
        add ecx, ebx
        mov ebx, dword [ecx]
        mov dword [byte ebp-02Ch], ecx
        movsx ecx, word [dword ebx+01281h]
        cmp edi, ecx
        jge short ComparePlayersForTrade_59.2
        cmp esi, ecx
        jge short ComparePlayersForTrade_59.2
        mov edx, dword [byte ebp-04h]
        mov ecx, dword [byte ebp-02Ch]
        mov dh, byte [dword edx+ebx+01285h]
        add ebx, dword [byte ebp-08h]
        add ecx, 1B5Ah
        mov dl, byte [dword ebx+01285h]
        mov ebx, dword [byte ebp-018h]
        add ebx, ecx
        lea esi, [byte ebx+018h]
        add ecx, dword [byte ebp-01Ch]
        mov dword [byte ebp-010h], esi
        add ebx, byte 8
        lea esi, [byte ecx+018h]
        mov dword [byte ebp-020h], ebx
        add ecx, byte 8
        mov dword [byte ebp-0Ch], esi
        mov dword [byte ebp-014h], ecx
        jmp short ComparePlayersForTrade_59.2
ComparePlayersForTrade_133:
        mov ecx, dword [RosterTeams]
        add ecx, ebx
        mov ebx, dword [ecx]
        mov dword [byte ebp-024h], ecx
        movsx ecx, word [dword ebx+0132Bh]
        cmp edi, ecx
        jge near ComparePlayersForTrade_59.2
        cmp esi, ecx
        jge near ComparePlayersForTrade_59.2
        mov edx, dword [byte ebp-04h]
        mov dh, byte [dword edx+ebx+0132Fh]
        add ebx, dword [byte ebp-08h]
        mov dl, byte [dword ebx+0132Fh]
        mov ebx, dword [byte ebp-024h]
        mov ecx, dword [byte ebp-018h]
        add ebx, 1D8Eh
        jmp near ComparePlayersForTrade_59.1
ComparePlayersForTrade_17B:
        mov ecx, dword [RosterTeams]
        add ecx, ebx
        mov ebx, dword [ecx]
        mov dword [byte ebp-028h], ecx
        movsx ecx, word [dword ebx+018A5h]
        cmp edi, ecx
        jge near ComparePlayersForTrade_59.2
        cmp esi, ecx
        jge near ComparePlayersForTrade_59.2
        mov edx, dword [byte ebp-04h]
        mov dh, byte [dword edx+ebx+018A9h]
        add ebx, dword [byte ebp-08h]
        mov dl, byte [dword ebx+018A9h]
        mov ebx, dword [byte ebp-028h]
        mov ecx, dword [byte ebp-018h]
        add ebx, 2FEAh
        jmp near ComparePlayersForTrade_59.1
.4:
        cmp dh, 4Ch
        jne short .5
        cmp dl, 43h
        jne near ComparePlayersForTrade_59.3
        jmp short .6
.5:
        cmp dh, 52h
        jne short .6
        cmp dl, dh
        je near ComparePlayersForTrade_59.3
        cmp dl, 44h
        je near ComparePlayersForTrade_59.3
.6:
        mov eax, 0FFFFFFFFh
.7:
        test eax, eax
        jne short .8
        mov edx, dword [byte ebp-020h]
        mov eax, dword [byte ebp-014h]
        call stricmp_
        test eax, eax
        jne short .8
        mov edx, dword [byte ebp-010h]
        mov eax, dword [byte ebp-0Ch]
        call stricmp_
.8:
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; RateTrade                                       CC1CA  97 PC, low confidence
; Rates a proposed trade
;-----------------------------------------------------------------------------
RateTrade:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 8, 0
        push eax
        mov eax, dword [nosplit eax*4+RosterTeam]
        xor esi, esi
        mov dword [byte ebp-08h], eax
        jmp short .6
.1:
        mov dword [byte ebp-04h], esi
        lea edi, [byte esi+01h]
        jmp short .4
.2:
        mov ebx, dword [byte ebp-08h]
        mov eax, dword [byte ebp-04h]
        mov edx, edi
        xor ecx, ecx
        call ComparePlayersForTrade
        test eax, eax
        jge short .3
        mov dword [byte ebp-04h], edi
.3:
        inc edi
.4:
        imul edx, dword [byte ebp-08h], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+0D05h]
        cmp edi, eax
        jl short .2
        cmp esi, dword [byte ebp-04h]
        je short .5
        mov ebx, dword [byte ebp-04h]
        mov eax, dword [byte ebp-0Ch]
        mov ecx, esi
        xor edx, edx
        call TradeValue
.5:
        inc esi
.6:
        imul eax, dword [byte ebp-08h], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+0D05h]
        dec eax
        cmp esi, eax
        jl short .1
        xor esi, esi
        jmp short .12
.7:
        mov dword [byte ebp-04h], esi
        lea edi, [byte esi+01h]
        jmp short .10
.8:
        mov ecx, 1
        mov ebx, dword [byte ebp-08h]
        mov eax, dword [byte ebp-04h]
        mov edx, edi
        call ComparePlayersForTrade
        test eax, eax
        jge short .9
        mov dword [byte ebp-04h], edi
.9:
        inc edi
.10:
        imul eax, dword [byte ebp-08h], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+01281h]
        cmp edi, eax
        jl short .8
        cmp esi, dword [byte ebp-04h]
        je short .11
        mov ebx, dword [byte ebp-04h]
        mov edx, 1
        mov eax, dword [byte ebp-0Ch]
        mov ecx, esi
        call TradeValue
.11:
        inc esi
.12:
        imul edx, dword [byte ebp-08h], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+01281h]
        dec eax
        cmp esi, eax
        jl short .7
        xor esi, esi
        jmp short .18
.13:
        mov dword [byte ebp-04h], esi
        lea edi, [byte esi+01h]
        jmp short .16
.14:
        mov ecx, 2
        mov ebx, dword [byte ebp-08h]
        mov eax, dword [byte ebp-04h]
        mov edx, edi
        call ComparePlayersForTrade
        test eax, eax
        jge short .15
        mov dword [byte ebp-04h], edi
.15:
        inc edi
.16:
        imul edx, dword [byte ebp-08h], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+0132Bh]
        cmp edi, eax
        jl short .14
        cmp esi, dword [byte ebp-04h]
        je short .17
        mov ebx, dword [byte ebp-04h]
        mov edx, 2
        mov eax, dword [byte ebp-0Ch]
        mov ecx, esi
        call TradeValue
.17:
        inc esi
.18:
        imul edx, dword [byte ebp-08h], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+0132Bh]
        dec eax
        cmp esi, eax
        jl short .13
        xor esi, esi
        jmp short .24
.19:
        mov dword [byte ebp-04h], esi
        lea edi, [byte esi+01h]
        jmp short .22
.20:
        mov ecx, 3
        mov ebx, dword [byte ebp-08h]
        mov eax, dword [byte ebp-04h]
        mov edx, edi
        call ComparePlayersForTrade
        test eax, eax
        jge short .21
        mov dword [byte ebp-04h], edi
.21:
        inc edi
.22:
        imul eax, dword [byte ebp-08h], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx eax, word [dword eax+018A5h]
        cmp edi, eax
        jl short .20
        cmp esi, dword [byte ebp-04h]
        je short .23
        mov ebx, dword [byte ebp-04h]
        mov edx, 3
        mov eax, dword [byte ebp-0Ch]
        mov ecx, esi
        call TradeValue
.23:
        inc esi
.24:
        imul eax, dword [byte ebp-08h], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        movsx edi, word [dword eax+018A5h]
        dec edi
        cmp esi, edi
        jl short .19
        jmp near RosterTradeScreen_306
;-----------------------------------------------------------------------------
; TradeValue                                      CC3AD  97 PC, low confidence
; Works out a player's trade value
;-----------------------------------------------------------------------------
TradeValue:
        push esi
        push edi
        enter 13Ch, 0
        push ebx
        push ecx
        sub ebp, 82h
        imul ebx, ecx, dword 0BCh
        mov eax, dword [nosplit eax*4+RosterTeam]
        mov dword [byte ebp+066h], eax
        imul eax, ecx, byte 27h
        mov dword [byte ebp+076h], eax
        imul eax, ecx, byte 38h
        imul ecx, dword [dword ebp-0BEh], byte 38h
        mov dword [byte ebp+07Ah], eax
        imul eax, dword [dword ebp-0BEh], dword 0BCh
        mov dword [byte ebp+06Eh], eax
        imul eax, dword [dword ebp-0BEh], byte 27h
        mov dword [byte ebp+072h], eax
        imul eax, dword [byte ebp+066h], dword 32C6h
        mov dword [byte ebp+07Eh], eax
        test edx, edx
        jne near .1
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov dword [byte ebp+06Ah], edx
        mov edx, dword [eax]
        mov dword [byte ebp+062h], edx
        add edx, ecx
        lea edi, [dword ebp-0BAh]
        mov ecx, 0Eh
        lea esi, [dword edx+0D09h]
        rep movsd
        mov esi, dword [byte ebp+072h]
        mov ecx, 27h
        lea edi, [dword ebp-082h]
        lea esi, [byte esi+eax+076h]
        rep movsb
        mov esi, dword [byte ebp+06Eh]
        mov ecx, 2Fh
        lea edi, [byte ebp-05Bh]
        lea esi, [dword esi+eax+08FEh]
        rep movsd
        mov esi, dword [byte ebp+062h]
        add eax, dword [dword ebp-0BEh]
        add esi, dword [byte ebp+07Ah]
        mov ecx, 0Eh
        lea edi, [dword edx+0D09h]
        lea esi, [dword esi+0D09h]
        mov al, byte [dword eax+0321Eh]
        rep movsd
        mov byte [byte ebp+061h], al
        mov esi, dword [RosterTeams]
        mov eax, dword [byte ebp+076h]
        add esi, dword [byte ebp+07Eh]
        add eax, esi
        add esi, dword [byte ebp+072h]
        mov ecx, 27h
        lea edi, [byte esi+076h]
        lea esi, [byte eax+076h]
        rep movsb
        mov esi, dword [RosterTeams]
        add esi, dword [byte ebp+07Eh]
        lea eax, [esi+ebx]
        add esi, dword [byte ebp+06Eh]
        mov ecx, 2Fh
        lea edi, [dword esi+08FEh]
        lea esi, [dword eax+08FEh]
        rep movsd
        mov eax, dword [RosterTeams]
        mov edx, dword [dword ebp-0C2h]
        add eax, dword [byte ebp+07Eh]
        add edx, eax
        add eax, dword [dword ebp-0BEh]
        mov dl, byte [dword edx+0321Eh]
        mov byte [dword eax+0321Eh], dl
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov esi, dword [eax]
        add esi, dword [byte ebp+07Ah]
        mov ecx, 0Eh
        lea edi, [dword esi+0D09h]
        lea esi, [dword ebp-0BAh]
        rep movsd
        mov esi, dword [RosterTeams]
        add esi, dword [byte ebp+07Eh]
        add esi, dword [byte ebp+076h]
        mov ecx, 27h
        lea edi, [byte esi+076h]
        lea esi, [dword ebp-082h]
        rep movsb
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov ecx, 2Fh
        lea esi, [byte ebp-05Bh]
        lea edi, [dword ebx+eax+08FEh]
        rep movsd
        mov edx, dword [RosterTeams]
        add edx, dword [byte ebp+07Eh]
        add edx, dword [dword ebp-0C2h]
        mov al, byte [byte ebp+061h]
        mov byte [dword edx+0321Eh], al
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov ebx, 63h
        mov eax, dword [eax]
        mov edx, dword [dword ebp-0BEh]
        add eax, byte 18h
        call TradeNeedBonus
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov ebx, dword [dword ebp-0BEh]
        mov eax, dword [eax]
        mov edx, dword [dword ebp-0C2h]
        add eax, byte 18h
        call TradeNeedBonus
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov ebx, dword [dword ebp-0C2h]
        mov eax, dword [eax]
        mov edx, 63h
        add eax, byte 18h
        call TradeNeedBonus
        jmp near .5
.1:
        cmp edx, byte 1
        jne near .3
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov edx, dword [eax]
        mov dword [byte ebp+062h], edx
        movsx edx, word [dword edx+0D05h]
        mov dword [byte ebp+06Ah], edx
        mov edx, dword [byte ebp+062h]
        add edx, ecx
        lea edi, [dword ebp-0BAh]
        mov ecx, 0Eh
        lea esi, [dword edx+01283h]
        rep movsd
        mov esi, dword [byte ebp+072h]
        mov ecx, 27h
        lea edi, [dword ebp-082h]
        lea esi, [dword esi+eax+0445h]
        rep movsb
        mov esi, dword [byte ebp+06Eh]
        mov ecx, 2Fh
        lea edi, [byte ebp-05Bh]
        lea esi, [dword esi+eax+01B5Ah]
        rep movsd
        mov esi, dword [byte ebp+062h]
        add eax, dword [dword ebp-0BEh]
        add esi, dword [byte ebp+07Ah]
        mov ecx, 0Eh
        lea edi, [dword edx+01283h]
        lea esi, [dword esi+01283h]
        mov al, byte [dword eax+03237h]
        rep movsd
        mov byte [byte ebp+061h], al
        mov esi, dword [RosterTeams]
        mov eax, dword [byte ebp+076h]
        add esi, dword [byte ebp+07Eh]
        add eax, esi
        add esi, dword [byte ebp+072h]
        mov ecx, 27h
        lea edi, [dword esi+0445h]
        lea esi, [dword eax+0445h]
        rep movsb
        mov edi, dword [RosterTeams]
        add edi, dword [byte ebp+07Eh]
        lea esi, [edi+ebx]
        add edi, dword [byte ebp+06Eh]
        mov ecx, 2Fh
        lea esi, [dword esi+01B5Ah]
        lea edi, [dword edi+01B5Ah]
        rep movsd
        mov eax, dword [RosterTeams]
        mov edx, dword [dword ebp-0C2h]
        add eax, dword [byte ebp+07Eh]
        add edx, eax
        add eax, dword [dword ebp-0BEh]
        mov dl, byte [dword edx+03237h]
        mov byte [dword eax+03237h], dl
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov esi, dword [eax]
        add esi, dword [byte ebp+07Ah]
        mov ecx, 0Eh
        lea edi, [dword esi+01283h]
        lea esi, [dword ebp-0BAh]
        rep movsd
        mov eax, dword [RosterTeams]
        mov esi, dword [byte ebp+076h]
        add eax, dword [byte ebp+07Eh]
        mov ecx, 27h
        lea edi, [dword esi+eax+0445h]
        lea esi, [dword ebp-082h]
        rep movsb
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov ecx, 2Fh
        lea esi, [byte ebp-05Bh]
        lea edi, [dword ebx+eax+01B5Ah]
        rep movsd
        mov edx, dword [RosterTeams]
        add edx, dword [byte ebp+07Eh]
        add edx, dword [dword ebp-0C2h]
        mov al, byte [byte ebp+061h]
        mov byte [dword edx+03237h], al
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov eax, dword [eax]
        movzx edx, byte [byte eax+04Ch]
        cmp edx, dword [dword ebp-0BEh]
        jne short .2
        mov dl, byte [dword ebp-0C2h]
        mov byte [byte eax+04Ch], dl
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov eax, dword [eax]
        movzx edx, byte [byte eax+04Dh]
        cmp edx, dword [dword ebp-0C2h]
        jne near .5
        mov dl, byte [dword ebp-0BEh]
        mov byte [byte eax+04Dh], dl
        jmp near .5
.2:
        movzx edx, byte [byte eax+04Dh]
        cmp edx, dword [dword ebp-0BEh]
        jne near .5
        mov dl, byte [dword ebp-0C2h]
        mov byte [byte eax+04Dh], dl
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov eax, dword [eax]
        movzx edx, byte [byte eax+04Ch]
        cmp edx, dword [dword ebp-0C2h]
        jne near .5
        mov dl, byte [dword ebp-0BEh]
        mov byte [byte eax+04Ch], dl
        jmp near .5
.3:
        cmp edx, byte 2
        jne near .4
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov edx, dword [eax]
        movsx esi, word [dword edx+0D05h]
        mov dword [byte ebp+062h], esi
        mov edi, dword [byte ebp+062h]
        movsx esi, word [dword edx+01281h]
        add edi, esi
        mov dword [byte ebp+06Ah], edi
        lea esi, [edx+ecx]
        mov ecx, 0Eh
        lea edi, [dword ebp-0BAh]
        mov dword [byte ebp+062h], esi
        lea esi, [dword esi+0132Dh]
        rep movsd
        mov esi, dword [byte ebp+072h]
        mov ecx, 27h
        lea edi, [dword ebp-082h]
        lea esi, [dword esi+eax+04BAh]
        rep movsb
        mov esi, dword [byte ebp+06Eh]
        mov ecx, 2Fh
        lea edi, [byte ebp-05Bh]
        lea esi, [dword esi+eax+01D8Eh]
        add edx, dword [byte ebp+07Ah]
        rep movsd
        add eax, dword [dword ebp-0BEh]
        mov edi, dword [byte ebp+062h]
        mov ecx, 0Eh
        lea esi, [dword edx+0132Dh]
        lea edi, [dword edi+0132Dh]
        mov al, byte [dword eax+0323Ah]
        rep movsd
        mov edi, dword [RosterTeams]
        mov esi, dword [byte ebp+076h]
        add edi, dword [byte ebp+07Eh]
        add esi, edi
        add edi, dword [byte ebp+072h]
        mov ecx, 27h
        lea esi, [dword esi+04BAh]
        lea edi, [dword edi+04BAh]
        rep movsb
        mov edi, dword [RosterTeams]
        add edi, dword [byte ebp+07Eh]
        lea esi, [edi+ebx]
        add edi, dword [byte ebp+06Eh]
        mov ecx, 2Fh
        lea esi, [dword esi+01D8Eh]
        lea edi, [dword edi+01D8Eh]
        rep movsd
        mov byte [byte ebp+061h], al
        mov eax, dword [RosterTeams]
        mov edx, dword [dword ebp-0C2h]
        add eax, dword [byte ebp+07Eh]
        add edx, eax
        add eax, dword [dword ebp-0BEh]
        mov dl, byte [dword edx+0323Ah]
        mov byte [dword eax+0323Ah], dl
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov esi, dword [eax]
        add esi, dword [byte ebp+07Ah]
        mov ecx, 0Eh
        lea edi, [dword esi+0132Dh]
        lea esi, [dword ebp-0BAh]
        rep movsd
        mov eax, dword [RosterTeams]
        mov esi, dword [byte ebp+076h]
        add eax, dword [byte ebp+07Eh]
        mov ecx, 27h
        lea edi, [dword esi+eax+04BAh]
        lea esi, [dword ebp-082h]
        rep movsb
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov ecx, 2Fh
        lea esi, [byte ebp-05Bh]
        lea edi, [dword ebx+eax+01D8Eh]
        rep movsd
        mov edx, dword [RosterTeams]
        add edx, dword [byte ebp+07Eh]
        add edx, dword [dword ebp-0C2h]
        mov al, byte [byte ebp+061h]
        mov byte [dword edx+0323Ah], al
        jmp near .5
.4:
        cmp edx, byte 3
        jne near .5
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov edx, dword [eax]
        movsx edi, word [dword edx+01281h]
        movsx esi, word [dword edx+0D05h]
        add edi, esi
        movsx esi, word [dword edx+0132Bh]
        add edi, esi
        mov dword [byte ebp+06Ah], edi
        lea esi, [edx+ecx]
        mov ecx, 0Eh
        lea edi, [dword ebp-0BAh]
        mov dword [byte ebp+062h], esi
        lea esi, [dword esi+018A7h]
        rep movsd
        mov esi, dword [byte ebp+072h]
        mov ecx, 27h
        lea edi, [dword ebp-082h]
        lea esi, [dword esi+eax+0889h]
        rep movsb
        mov esi, dword [byte ebp+06Eh]
        mov ecx, 2Fh
        lea edi, [byte ebp-05Bh]
        lea esi, [dword esi+eax+02FEAh]
        add edx, dword [byte ebp+07Ah]
        rep movsd
        add eax, dword [dword ebp-0BEh]
        mov edi, dword [byte ebp+062h]
        mov ecx, 0Eh
        lea esi, [dword edx+018A7h]
        lea edi, [dword edi+018A7h]
        mov al, byte [dword eax+03253h]
        rep movsd
        mov edi, dword [RosterTeams]
        mov esi, dword [byte ebp+076h]
        add edi, dword [byte ebp+07Eh]
        add esi, edi
        add edi, dword [byte ebp+072h]
        mov ecx, 27h
        lea esi, [dword esi+0889h]
        lea edi, [dword edi+0889h]
        rep movsb
        mov edi, dword [RosterTeams]
        add edi, dword [byte ebp+07Eh]
        lea esi, [edi+ebx]
        add edi, dword [byte ebp+06Eh]
        mov ecx, 2Fh
        lea esi, [dword esi+02FEAh]
        lea edi, [dword edi+02FEAh]
        rep movsd
        mov byte [byte ebp+061h], al
        mov eax, dword [RosterTeams]
        mov edx, dword [dword ebp-0C2h]
        add eax, dword [byte ebp+07Eh]
        add edx, eax
        add eax, dword [dword ebp-0BEh]
        mov dl, byte [dword edx+03253h]
        mov byte [dword eax+03253h], dl
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov esi, dword [eax]
        add esi, dword [byte ebp+07Ah]
        mov ecx, 0Eh
        lea edi, [dword esi+018A7h]
        lea esi, [dword ebp-0BAh]
        rep movsd
        mov eax, dword [RosterTeams]
        mov esi, dword [byte ebp+076h]
        add eax, dword [byte ebp+07Eh]
        mov ecx, 27h
        lea edi, [dword esi+eax+0889h]
        lea esi, [dword ebp-082h]
        rep movsb
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Eh]
        mov ecx, 2Fh
        lea esi, [byte ebp-05Bh]
        lea edi, [dword ebx+eax+02FEAh]
        rep movsd
        mov eax, dword [RosterTeams]
        mov edx, dword [dword ebp-0C2h]
        add eax, dword [byte ebp+07Eh]
        add edx, eax
        mov al, byte [byte ebp+061h]
        mov byte [dword edx+03253h], al
.5:
        xor eax, eax
        jmp short .8
.6:
        mov ebx, dword [dword ebp-0BEh]
        add edx, eax
        add ebx, dword [byte ebp+06Ah]
        movzx ecx, byte [byte edx+06Eh]
        cmp ecx, ebx
        jne short .7
        mov byte [byte edx+06Eh], 63h
.7:
        inc eax
.8:
        imul edx, dword [byte ebp+066h], dword 32C6h
        mov ebx, dword [RosterTeams]
        add edx, ebx
        movzx ebx, byte [byte edx+071h]
        cmp eax, ebx
        jl short .6
        xor eax, eax
        jmp short .11
.9:
        mov ecx, dword [dword ebp-0C2h]
        add edx, eax
        add ecx, dword [byte ebp+06Ah]
        movzx ebx, byte [byte edx+06Eh]
        cmp ebx, ecx
        jne short .10
        mov bl, byte [dword ebp-0BEh]
        add bl, byte [byte ebp+06Ah]
        mov byte [byte edx+06Eh], bl
.10:
        inc eax
.11:
        imul edx, dword [byte ebp+066h], dword 32C6h
        mov ebx, dword [RosterTeams]
        add edx, ebx
        movzx ebx, byte [byte edx+071h]
        cmp eax, ebx
        jl short .9
        xor eax, eax
        jmp short .14
.12:
        add edx, eax
        cmp byte [byte edx+06Eh], 63h
        jne short .13
        mov bl, byte [dword ebp-0C2h]
        add bl, byte [byte ebp+06Ah]
        mov byte [byte edx+06Eh], bl
.13:
        inc eax
.14:
        imul edx, dword [byte ebp+066h], dword 32C6h
        mov ebx, dword [RosterTeams]
        add edx, ebx
        movzx ebx, byte [byte edx+071h]
        cmp eax, ebx
        jl short .12
        lea esp, [dword ebp+082h]
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; TradeNeedBonus                                  CCB24  97 PC, low confidence
; Adds the bonus for a position the team needs
;-----------------------------------------------------------------------------
TradeNeedBonus:
        push ecx
        push esi
        push edi
        enter 4, 0
        mov esi, eax
        mov ecx, edx
        mov dword [byte ebp-04h], ebx
        xor eax, eax
.1:
        xor edx, edx
.2:
        lea edi, [eax+eax*2]
        add edi, esi
        add edi, edx
        movzx ebx, byte [edi]
        cmp ecx, ebx
        jne short .3
        mov bl, byte [byte ebp-04h]
        mov byte [edi], bl
.3:
        inc edx
        cmp edx, byte 3
        jl short .2
        inc eax
        cmp eax, byte 4
        jl short .1
        xor eax, eax
.4:
        xor edx, edx
.5:
        lea edi, [eax+eax]
        add edi, esi
        add edi, edx
        movzx ebx, byte [byte edi+0Ch]
        cmp ecx, ebx
        jne short .6
        mov bl, byte [byte ebp-04h]
        mov byte [byte edi+0Ch], bl
.6:
        inc edx
        cmp edx, byte 2
        jl short .5
        inc eax
        cmp eax, byte 3
        jl short .4
        xor eax, eax
.7:
        xor edx, edx
.8:
        lea edi, [eax+eax*4]
        add edi, esi
        add edi, edx
        movzx ebx, byte [byte edi+012h]
        cmp ecx, ebx
        jne short .9
        mov bl, byte [byte ebp-04h]
        mov byte [byte edi+012h], bl
.9:
        inc edx
        cmp edx, byte 5
        jl short .8
        inc eax
        cmp eax, byte 2
        jl short .7
        xor eax, eax
.10:
        xor edx, edx
.11:
        mov edi, eax
        shl edi, 2
        add edi, esi
        add edi, edx
        movzx ebx, byte [byte edi+01Ch]
        cmp ecx, ebx
        jne short .12
        mov bl, byte [byte ebp-04h]
        mov byte [byte edi+01Ch], bl
.12:
        inc edx
        cmp edx, byte 4
        jl short .11
        inc eax
        cmp eax, byte 2
        jl short .10
        mov bl, byte [byte ebp-04h]
        xor eax, eax
.13:
        lea edx, [esi+eax]
        movzx edi, byte [byte edx+024h]
        cmp edi, ecx
        jne short .14
        mov byte [byte edx+024h], bl
.14:
        inc eax
        cmp eax, byte 2
        jl short .13
        xor eax, eax
.15:
        xor edx, edx
.16:
        mov edi, eax
        shl edi, 2
        add edi, esi
        add edi, edx
        movzx ebx, byte [byte edi+026h]
        cmp ecx, ebx
        jne short .17
        mov bl, byte [byte ebp-04h]
        mov byte [byte edi+026h], bl
.17:
        inc edx
        cmp edx, byte 4
        jl short .16
        inc eax
        cmp eax, byte 2
        jl short .15
        xor eax, eax
.18:
        xor edx, edx
.19:
        lea edi, [eax+eax*2]
        add edi, esi
        add edi, edx
        movzx ebx, byte [byte edi+02Eh]
        cmp ecx, ebx
        jne short .20
        mov bl, byte [byte ebp-04h]
        mov byte [byte edi+02Eh], bl
.20:
        inc edx
        cmp edx, byte 3
        jl short .19
        inc eax
        cmp eax, byte 2
        jl short .18
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; ApplyTrade                                      CCC30  97 PC, low confidence
; Applies a trade to both rosters
;-----------------------------------------------------------------------------
ApplyTrade:
        push esi
        push edi
        push ebp
        mov ebp, esp
        push eax
        push edx
        push ecx
        test ecx, ecx
        jge short .1
        imul eax, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add edx, eax
        add edx, dword [byte ebp-08h]
        movzx edx, byte [byte edx+06Eh]
        jmp short .2
.1:
        mov edx, ecx
.2:
        mov eax, dword [byte ebp-04h]
        shl eax, 2
        imul ecx, dword [dword eax+RosterTeam], dword 32C6h
        mov esi, dword [RosterTeams]
        mov ecx, dword [ecx+esi]
        movsx esi, word [dword ecx+0D05h]
        cmp edx, esi
        jge near .3
        imul esi, edx, byte 38h
        add esi, ecx
        mov edi, ebx
        mov ecx, 0Eh
        lea esi, [dword esi+0D09h]
        rep movsd
        imul ecx, dword [dword eax+RosterTeam], dword 32C6h
        mov esi, dword [RosterTeams]
        add ecx, esi
        imul esi, edx, byte 27h
        add esi, ecx
        lea edi, [byte ebx+038h]
        mov ecx, 27h
        lea esi, [byte esi+076h]
        rep movsb
        imul ecx, dword [dword eax+RosterTeam], dword 32C6h
        mov esi, dword [RosterTeams]
        add esi, ecx
        imul ecx, edx, dword 0BCh
        add esi, ecx
        lea edi, [byte ebx+05Fh]
        mov ecx, 2Fh
        lea esi, [dword esi+08FEh]
        rep movsd
        imul eax, dword [dword eax+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add eax, ecx
        mov al, byte [dword edx+eax+0321Eh]
        jmp near .6
.3:
        sub edx, esi
        movsx esi, word [dword ecx+01281h]
        cmp edx, esi
        jge near .4
        imul esi, edx, byte 38h
        add esi, ecx
        mov edi, ebx
        mov ecx, 0Eh
        lea esi, [dword esi+01283h]
        rep movsd
        imul esi, dword [dword eax+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add ecx, esi
        imul esi, edx, byte 27h
        add esi, ecx
        lea edi, [byte ebx+038h]
        mov ecx, 27h
        lea esi, [dword esi+0445h]
        rep movsb
        imul ecx, dword [dword eax+RosterTeam], dword 32C6h
        mov esi, dword [RosterTeams]
        add ecx, esi
        imul esi, edx, dword 0BCh
        add esi, ecx
        lea edi, [byte ebx+05Fh]
        mov ecx, 2Fh
        lea esi, [dword esi+01B5Ah]
        rep movsd
        imul ecx, dword [dword eax+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        add eax, ecx
        mov al, byte [dword edx+eax+03237h]
        jmp near .6
.4:
        sub edx, esi
        movsx esi, word [dword ecx+0132Bh]
        cmp edx, esi
        jge near .5
        imul esi, edx, byte 38h
        add esi, ecx
        mov edi, ebx
        mov ecx, 0Eh
        lea esi, [dword esi+0132Dh]
        rep movsd
        imul esi, dword [dword eax+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add esi, ecx
        imul ecx, edx, byte 27h
        add esi, ecx
        lea edi, [byte ebx+038h]
        mov ecx, 27h
        lea esi, [dword esi+04BAh]
        rep movsb
        imul esi, dword [dword eax+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add ecx, esi
        imul esi, edx, dword 0BCh
        add esi, ecx
        lea edi, [byte ebx+05Fh]
        mov ecx, 2Fh
        lea esi, [dword esi+01D8Eh]
        rep movsd
        imul eax, dword [dword eax+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add eax, ecx
        mov al, byte [dword edx+eax+0323Ah]
        jmp near .6
.5:
        sub edx, esi
        movsx esi, word [dword ecx+018A5h]
        cmp edx, esi
        jge near .7
        imul esi, edx, byte 38h
        add esi, ecx
        mov edi, ebx
        mov ecx, 0Eh
        lea esi, [dword esi+018A7h]
        rep movsd
        imul ecx, dword [dword eax+RosterTeam], dword 32C6h
        mov esi, dword [RosterTeams]
        add ecx, esi
        imul esi, edx, byte 27h
        add esi, ecx
        lea edi, [byte ebx+038h]
        mov ecx, 27h
        lea esi, [dword esi+0889h]
        rep movsb
        imul esi, dword [dword eax+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add ecx, esi
        imul esi, edx, dword 0BCh
        add esi, ecx
        lea edi, [byte ebx+05Fh]
        mov ecx, 2Fh
        lea esi, [dword esi+02FEAh]
        rep movsd
        imul eax, dword [dword eax+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add eax, ecx
        mov al, byte [dword edx+eax+03253h]
.6:
        mov byte [dword ebx+011Bh], al
.7:
        cmp dword [byte ebp-0Ch], byte 0
        jge short .8
        mov eax, dword [byte ebp-04h]
        imul edx, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        add edx, eax
        add edx, dword [byte ebp-08h]
        mov ecx, dword [byte ebp-08h]
        movzx edx, byte [byte edx+06Eh]
        jmp short .12
.8:
        mov ecx, 0FFFFFFFFh
        mov edx, dword [byte ebp-0Ch]
        xor eax, eax
        jmp short .11
.9:
        movzx ebx, byte [byte ebx+eax+06Eh]
        cmp edx, ebx
        jne short .10
        mov ecx, eax
.10:
        inc eax
.11:
        mov ebx, dword [byte ebp-04h]
        imul ebx, dword [nosplit ebx*4+RosterTeam], dword 32C6h
        mov esi, dword [RosterTeams]
        add ebx, esi
        movzx esi, byte [byte ebx+071h]
        cmp eax, esi
        jl short .9
.12:
        mov ebx, 0FFFFFFFFh
        mov eax, dword [byte ebp-04h]
        call FixLinesAfterTrade
        mov eax, ecx
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; CountRosterPositions                            CCF2E  97 PC, low confidence
; Counts the players by position
;-----------------------------------------------------------------------------
CountRosterPositions:
        push ebx
        push ecx
        push esi
        push edi
        enter 4, 0
        mov ebx, eax
        mov cl, dl
        xor eax, eax
        xor edx, edx
        jmp short .3
.1:
        imul edi, eax, byte 38h
        add esi, edi
        cmp cl, byte [dword esi+0D0Ah]
        jne short .2
        mov edx, 1
        jmp short .4
.2:
        inc eax
.3:
        imul esi, dword [nosplit ebx*4+RosterTeam], dword 32C6h
        mov dword [byte ebp-04h], esi
        mov esi, dword [RosterTeams]
        add esi, dword [byte ebp-04h]
        mov esi, dword [esi]
        movsx edi, word [dword esi+0D05h]
        cmp eax, edi
        jl short .1
.4:
        test edx, edx
        jne short .8
        xor eax, eax
        jmp short .7
.5:
        imul edi, eax, byte 38h
        add esi, edi
        cmp cl, byte [dword esi+01284h]
        jne short .6
        mov edx, 1
        jmp short .8
.6:
        inc eax
.7:
        imul esi, dword [nosplit ebx*4+RosterTeam], dword 32C6h
        mov edi, dword [RosterTeams]
        add esi, edi
        mov esi, dword [esi]
        movsx edi, word [dword esi+01281h]
        cmp eax, edi
        jl short .5
.8:
        test edx, edx
        jne short .12
        xor eax, eax
        jmp short .11
.9:
        imul edi, eax, byte 38h
        add esi, edi
        cmp cl, byte [dword esi+0132Eh]
        jne short .10
        mov edx, 1
        jmp short .12
.10:
        inc eax
.11:
        imul esi, dword [nosplit ebx*4+RosterTeam], dword 32C6h
        mov edi, dword [RosterTeams]
        add esi, edi
        mov esi, dword [esi]
        movsx edi, word [dword esi+0132Bh]
        cmp eax, edi
        jl short .9
.12:
        test edx, edx
        jne short .16
        xor eax, eax
        jmp short .15
.13:
        imul edi, eax, byte 38h
        add esi, edi
        cmp cl, byte [dword esi+018A8h]
        jne short .14
        mov edx, 1
        jmp short .16
.14:
        inc eax
.15:
        imul esi, dword [nosplit ebx*4+RosterTeam], dword 32C6h
        mov edi, dword [RosterTeams]
        add esi, edi
        mov esi, dword [esi]
        movsx edi, word [dword esi+018A5h]
        cmp eax, edi
        jl short .13
.16:
        mov eax, edx
        jmp near DrawPlayerCard_2B8
;-----------------------------------------------------------------------------
; ClearPlayerRecord                               CD037  97 PC, low confidence
; Clears a player record
;-----------------------------------------------------------------------------
ClearPlayerRecord:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        mov ecx, 64h
        mov eax, NewPlayerRecord
        xor edx, edx
        call __STOSB
        mov byte [NewPlayerRecord], 1
        mov dword [JerseyChoice], 0
        xor eax, eax
        jmp short .2
.1:
        imul ecx, eax, byte 38h
        movzx edx, byte [dword ecx+edx+0D0Ah]
        inc eax
        mov byte [dword edx+NewPlayerRecord], 1
.2:
        imul edx, dword [nosplit ebx*4+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        mov edx, dword [ecx+edx]
        movsx ecx, word [dword edx+0D05h]
        cmp eax, ecx
        jl short .1
        xor eax, eax
        jmp short .4
.3:
        imul ecx, eax, byte 38h
        movzx edx, byte [dword ecx+edx+01284h]
        inc eax
        mov byte [dword edx+NewPlayerRecord], 1
.4:
        imul edx, dword [nosplit ebx*4+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        mov edx, dword [ecx+edx]
        movsx ecx, word [dword edx+01281h]
        cmp eax, ecx
        jl short .3
        xor eax, eax
        jmp short .6
.5:
        imul ecx, eax, byte 38h
        movzx edx, byte [dword ecx+edx+0132Eh]
        inc eax
        mov byte [dword edx+NewPlayerRecord], 1
.6:
        imul edx, dword [nosplit ebx*4+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        mov edx, dword [ecx+edx]
        movsx ecx, word [dword edx+0132Bh]
        cmp eax, ecx
        jl short .5
        xor eax, eax
        jmp short .8
.7:
        imul ecx, eax, byte 38h
        movzx edx, byte [dword ecx+edx+018A8h]
        inc eax
        mov byte [dword edx+NewPlayerRecord], 1
.8:
        imul edx, dword [nosplit ebx*4+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        mov edx, dword [ecx+edx]
        movsx ecx, word [dword edx+018A5h]
        cmp eax, ecx
        jl short .7
        pop edx
        pop ecx
        pop ebx
        ret
