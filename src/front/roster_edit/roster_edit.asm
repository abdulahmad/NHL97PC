; Roster edit: trade messages, lines after trades, creating and releasing players.
bits 32
%include "hockey.inc"
section s_CD7B7 progbits alloc exec nowrite align=1
extern ApplyTrade, BuildAutoLines, BuildTradePlayerLists, CheckRegularRosterLimits, CreatePlayerScreen, CreatePlayerSlot, DeletionCount, DrawPlayerCard_2B8
extern DrawRatingBars_157, DrawRosterDetails, DrawRosterList, DrawRosterList_86F, DrawScrollBar, EditLinesScreen, FreeExhibitionFile, FreeRosterScreen
extern GetLangText, InitRosterScreen, KeysEqual, qsort_, RateTrade, RemoveListEntry, ResetExhibitionStats, RosterData
extern RosterEditOpen, RosterFreeAgents, RosterListBox, RosterMode, RosterOtherListBox, RosterPanelBitmap, RosterPlayerInfo, RosterScreenOpen
extern RosterScrollList, RosterTeam, RosterTeams, SaveAgents, SaveAgentsOnly, SaveTradesLink, SetListSelection, SetScrollBarPos
extern ShowMessageBox, ShowTradeRejected_108, sprintf_, str_SS11, SwapRosterPlayers, UpdateGameRecord, WipeScreen
global ClampRosterScroll, RosterEditScreenJumpTable, RosterEditScreen, RosterEditScreen_24, RosterEditScreen_AD, RosterEditScreen_1BD, RosterEditScreen_25B, FormatTradeMessage
global FindTradedPlayer, RebuildLinesAfterTrade, FindLineSlot, FixLinesAfterTrade, RemoveFromLines, RemoveFromLines_61, UpdateRosterCounts, RosterCreatePlayer
global ReleasePlayer, CompareShorts, SaveTrades, ResetExhibitionRosters
;-----------------------------------------------------------------------------
; ClampRosterScroll                               CD7B7  97 PC, low confidence
; Keeps the roster scroll position in range
;-----------------------------------------------------------------------------
ClampRosterScroll:
        push ebx
        imul eax, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        add eax, ebx
        movsx ebx, word [byte eax+074h]
        sub ebx, byte 9
        cmp edx, ebx
        jle short .1
        mov dx, word [byte eax+074h]
        sub edx, byte 9
.1:
        mov word [byte eax+072h], dx
        pop ebx
        ret
RosterEditScreenJumpTable:                      ; jump table for the switch cases of RosterEditScreen
        dd RosterEditScreen_24
        dd RosterEditScreen_AD
        dd RosterEditScreen_1BD
        dd RosterEditScreen_25B
;-----------------------------------------------------------------------------
; RosterEditScreen                                CD7F3  97 PC, low confidence
; Runs the roster editing screen
;-----------------------------------------------------------------------------
RosterEditScreen:
        push ebx
        push ecx
        push esi
        push edi
        enter 0DCh, 0
        sub ebp, 82h
        mov esi, edx
        cmp eax, byte 3
        ja near DrawRosterList_86F
        shl edx, 2
        jmp dword [nosplit cs:eax*4+RosterEditScreenJumpTable]
RosterEditScreen_24:
        imul eax, dword [dword edx+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        test byte [byte edx+eax+06Ah], 8
        je near DrawRosterList_86F
        cmp dword [RosterScreenOpen], byte 0
        je short .1
        call FreeRosterScreen
.1:
        mov eax, 0FFFFFFFFh
        mov edx, dword [nosplit esi*4+RosterTeam]
        call EditLinesScreen
        mov edi, eax
        cmp dword [RosterScreenOpen], byte 0
        je short .2
        call InitRosterScreen
.2:
        mov eax, dword [RosterPanelBitmap]
        mov edx, 0FFFFFFFFh
        mov eax, dword [byte eax+02Ch]
        call WipeScreen
        test edi, edi
        je near DrawRosterList_86F
        imul eax, dword [nosplit esi*4+RosterTeam], dword 32C6h
.3:
        mov edx, dword [RosterTeams]
        or byte [byte edx+eax+06Ah], 2
        mov dword [RosterEditOpen], 1
        jmp near DrawRosterList_86F
RosterEditScreen_AD:
        cmp dword [RosterMode], byte 0
        jne near DrawRosterList_86F
        mov eax, esi
        call RosterCreatePlayer
        mov ebx, eax
        mov edi, eax
        mov eax, esi
        call RateTrade
        imul eax, dword [dword edx+RosterTeam], dword 32C6h
        mov dword [byte ebp+07Ah], eax
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp+07Ah]
        mov eax, dword [eax]
        call BuildAutoLines
        imul eax, dword [dword edx+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add eax, ecx
        mov eax, dword [eax]
        call RemoveListEntry
        test ebx, ebx
        je short .4
        imul eax, dword [dword edx+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        movzx edx, byte [byte eax+071h]
        movzx edx, byte [byte edx+eax+06Dh]
        mov eax, esi
        call ClampRosterScroll
.4:
        shl esi, 2
        imul eax, dword [dword esi+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        movsx edx, word [byte edx+eax+074h]
        inc edx
        mov eax, dword [dword esi+RosterListBox]
        call SetListSelection
        imul edx, dword [dword esi+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        xor ebx, ebx
        movsx edx, word [byte edx+eax+072h]
        mov eax, dword [dword esi+RosterListBox]
        call SetScrollBarPos
        mov edx, 1
        xor eax, eax
        call DrawRosterList
        mov edx, 1
        mov eax, edx
        call DrawRosterList
        mov eax, dword [RosterListBox]
        xor edx, edx
        call DrawScrollBar
        mov eax, dword [RosterOtherListBox]
        xor edx, edx
        call DrawScrollBar
        mov eax, 1
        call DrawRosterDetails
        test edi, edi
        je near DrawRosterList_86F
        imul eax, dword [dword esi+RosterTeam], dword 32C6h
        jmp near RosterEditScreen_24.3
RosterEditScreen_1BD:
        imul eax, dword [dword edx+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        test byte [byte ebx+eax+06Ah], 8
        je near DrawRosterList_86F
        mov eax, esi
        call CheckRegularRosterLimits
        test eax, eax
        jne near DrawRosterList_86F
        mov eax, esi
        call ReleasePlayer
        imul ebx, dword [dword edx+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [ebx+eax]
        call BuildAutoLines
        imul ebx, dword [dword edx+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [ebx+eax]
        call RemoveListEntry
        imul eax, dword [dword edx+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        movsx edi, word [byte ebx+eax+072h]
        mov eax, dword [dword edx+RosterListBox]
        xor ebx, ebx
        mov edx, edi
        call SetScrollBarPos
        mov edx, 1
        mov eax, esi
        call DrawRosterList
        mov eax, 1
        call DrawRosterDetails
        jmp near DrawRosterList_86F
RosterEditScreen_25B:
        cmp dword [RosterMode], byte 0
        jne near DrawRosterList_86F
        xor edi, edi
        jmp near .8
.5:
        movzx eax, byte [byte edi+eax+06Eh]
        lea ebx, [byte ebp+076h]
        mov dword [byte ebp+07Eh], eax
        mov edx, eax
        mov eax, esi
        call FindTradedPlayer
        test eax, eax
        je short .6
        lea ebx, [byte ebp+026h]
        mov edx, dword [byte ebp+07Eh]
        mov eax, esi
        call FormatTradeMessage
        lea eax, [byte ebp+026h]
        push eax
        mov eax, 0E8h
        call GetLangText
        push eax
        lea eax, [byte ebp-05Ah]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov ecx, 1
        mov edx, 2
        push byte 1
        xor ebx, ebx
        lea eax, [byte ebp-05Ah]
        call ShowMessageBox
        cmp eax, byte 1
        jne short .7
        mov ebx, dword [byte ebp+076h]
        mov edx, dword [byte ebp+07Eh]
        mov eax, esi
        call FixLinesAfterTrade
        dec edi
        jmp short .7
.6:
        push byte 1
        mov eax, 0E9h
        mov edx, 1
        xor ecx, ecx
        xor ebx, ebx
        call GetLangText
        call ShowMessageBox
.7:
        inc edi
.8:
        mov edx, esi
        shl edx, 2
        imul eax, dword [dword edx+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        add eax, ebx
        movzx ebx, byte [byte eax+071h]
        cmp edi, ebx
        jl near .5
        test byte [byte eax+06Ah], 2
        je near DrawRosterList_86F
        mov eax, esi
        mov dword [RosterEditOpen], 1
        call SwapRosterPlayers
        mov eax, esi
        call RateTrade
        imul eax, dword [dword edx+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        add ebx, eax
        cmp word [byte ebx+072h], byte 0
        jle short .9
        dec word [byte ebx+072h]
        imul ebx, dword [dword edx+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        movsx ebx, word [byte ebx+eax+072h]
        mov eax, dword [dword edx+RosterListBox]
        mov dword [byte eax+024h], ebx
.9:
        imul eax, dword [nosplit esi*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        movsx edx, word [byte edx+eax+074h]
        inc edx
        mov eax, dword [nosplit esi*4+RosterListBox]
        call SetListSelection
        mov edx, 1
        mov eax, esi
        call DrawRosterList
        mov eax, dword [nosplit esi*4+RosterListBox]
        xor edx, edx
        call DrawScrollBar
        mov eax, 1
        call DrawRosterDetails
        imul eax, dword [nosplit esi*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        call BuildAutoLines
        imul eax, dword [nosplit esi*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        mov eax, dword [edx+eax]
        call RemoveListEntry
        jmp near DrawRosterList_86F
;-----------------------------------------------------------------------------
; FormatTradeMessage                              CDBE5  97 PC, low confidence
; Formats the trade message
;-----------------------------------------------------------------------------
FormatTradeMessage:
        push ecx
        push esi
        mov esi, eax
        mov ecx, ebx
        mov eax, edx
        mov edx, esi
        imul ebx, dword [nosplit edx*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add ebx, edx
        mov edx, dword [ebx]
        movsx esi, word [dword edx+0D05h]
        cmp eax, esi
        jge short .1
        imul edx, eax, dword 0BCh
        lea eax, [dword ebx+08FEh]
        add eax, edx
        jmp short .5
.1:
        sub eax, esi
        movsx esi, word [dword edx+01281h]
        cmp eax, esi
        jge short .3
        imul eax, dword 0BCh
        add ebx, 1B5Ah
.2:
        add eax, ebx
        jmp short .5
.3:
        sub eax, esi
        movsx esi, word [dword edx+0132Bh]
        cmp eax, esi
        jge short .4
        imul eax, dword 0BCh
        add ebx, 1D8Eh
        jmp short .2
.4:
        movsx edx, word [dword edx+018A5h]
        sub eax, esi
        cmp eax, edx
        jge short .6
        imul edx, eax, dword 0BCh
        lea eax, [dword ebx+02FEAh]
        add eax, edx
.5:
        lea edx, [byte eax+08h]
        push edx
        add eax, byte 18h
        push eax
        push str_SS11
        push ecx
        call sprintf_
        add esp, byte 10h
.6:
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; FindTradedPlayer                                CDC8B  97 PC, low confidence
; Finds a traded player
;-----------------------------------------------------------------------------
FindTradedPlayer:
        push ecx
        push esi
        push edi
        enter 0Ch, 0
        imul ecx, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        add ecx, eax
        mov eax, dword [ecx]
        mov dword [byte ebp-0Ch], 0
        movsx edi, word [dword eax+0D05h]
        xor esi, esi
        cmp edx, edi
        jge short .1
        imul esi, edx, byte 38h
        add eax, 0D09h
        add eax, esi
        mov dword [byte ebp-08h], eax
        mov al, byte [dword ecx+edx+0321Eh]
        jmp short .4
.1:
        sub edx, edi
        movsx edi, word [dword eax+01281h]
        cmp edx, edi
        jge short .2
        imul esi, edx, byte 38h
        add eax, 1283h
        add eax, esi
        mov dword [byte ebp-08h], eax
        mov al, byte [dword ecx+edx+03237h]
        jmp short .4
.2:
        sub edx, edi
        movsx edi, word [dword eax+0132Bh]
        cmp edx, edi
        jge short .3
        imul esi, edx, byte 38h
        add eax, 132Dh
        add eax, esi
        mov dword [byte ebp-08h], eax
        mov al, byte [dword ecx+edx+0323Ah]
        jmp short .4
.3:
        sub edx, edi
        movsx edi, word [dword eax+018A5h]
        cmp edx, edi
        jge short .5
        imul esi, edx, byte 38h
        add eax, 18A7h
        add eax, esi
        mov dword [byte ebp-08h], eax
        mov al, byte [dword ecx+edx+03253h]
.4:
        mov esi, 1
        mov byte [byte ebp-04h], al
.5:
        test esi, esi
        je short .10
        test byte [byte ebp-04h], 40h
        je short .6
        mov dword [byte ebp-0Ch], 2
        mov dword [ebx], 0FFFFFFFFh
        jmp short .10
.6:
        xor ecx, ecx
        jmp short .9
.7:
        imul esi, ecx, byte 38h
        mov eax, dword [dword eax+0383C1h]
        mov edx, dword [byte ebp-08h]
        add eax, esi
        add edx, byte 18h
        add eax, byte 18h
        call KeysEqual
        test eax, eax
        je short .8
        mov dword [byte ebp-0Ch], 1
        mov dword [ebx], ecx
        jmp short .10
.8:
        inc ecx
.9:
        mov eax, dword [RosterData]
        movsx edx, word [eax]
        cmp ecx, edx
        jl short .7
.10:
        mov eax, dword [byte ebp-0Ch]
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; RebuildLinesAfterTrade                          CDD99  97 PC, low confidence
; Rebuilds the lines after a roster change
;-----------------------------------------------------------------------------
RebuildLinesAfterTrade:
        push ebx
        push ecx
        push esi
        push edi
        mov esi, eax
        mov ebx, edx
        xor eax, eax
.1:
        xor edx, edx
.2:
        lea ecx, [eax+eax*2]
        add ecx, esi
        add ecx, edx
        cmp byte [ecx], 19h
        jae short .4
        movzx edi, byte [ecx]
        cmp ebx, edi
        jne short .3
        mov byte [ecx], 0FFh
        jmp short .4
.3:
        jge short .4
        dec byte [ecx]
.4:
        inc edx
        cmp edx, byte 3
        jl short .2
        inc eax
        cmp eax, byte 4
        jl short .1
        xor eax, eax
.5:
        xor edx, edx
.6:
        lea ecx, [eax+eax]
        add ecx, esi
        add ecx, edx
        cmp byte [byte ecx+0Ch], 19h
        jae short .8
        movzx edi, byte [byte ecx+0Ch]
        cmp ebx, edi
        jne short .7
        mov byte [byte ecx+0Ch], 0FFh
        jmp short .8
.7:
        jge short .8
        dec byte [byte ecx+0Ch]
.8:
        inc edx
        cmp edx, byte 2
        jl short .6
        inc eax
        cmp eax, byte 3
        jl short .5
        xor eax, eax
.9:
        xor edx, edx
.10:
        lea ecx, [eax+eax*4]
        add ecx, esi
        add ecx, edx
        cmp byte [byte ecx+012h], 19h
        jae short .12
        movzx edi, byte [byte ecx+012h]
        cmp ebx, edi
        jne short .11
        mov byte [byte ecx+012h], 0FFh
        jmp short .12
.11:
        jge short .12
        dec byte [byte ecx+012h]
.12:
        inc edx
        cmp edx, byte 5
        jl short .10
        inc eax
        cmp eax, byte 2
        jl short .9
        xor eax, eax
.13:
        xor edx, edx
.14:
        mov ecx, eax
        shl ecx, 2
        add ecx, esi
        add ecx, edx
        cmp byte [byte ecx+01Ch], 19h
        jae short .16
        movzx edi, byte [byte ecx+01Ch]
        cmp ebx, edi
        jne short .15
        mov byte [byte ecx+01Ch], 0FFh
        jmp short .16
.15:
        jge short .16
        dec byte [byte ecx+01Ch]
.16:
        inc edx
        cmp edx, byte 4
        jl short .14
        inc eax
        cmp eax, byte 2
        jl short .13
        xor eax, eax
.17:
        lea edx, [esi+eax]
        cmp byte [byte edx+024h], 19h
        jae short .19
        movzx ecx, byte [byte edx+024h]
        cmp ecx, ebx
        jne short .18
        mov byte [byte edx+024h], 0FFh
        jmp short .19
.18:
        jle short .19
        dec byte [byte edx+024h]
.19:
        inc eax
        cmp eax, byte 2
        jl short .17
        xor eax, eax
.20:
        xor edx, edx
.21:
        mov ecx, eax
        shl ecx, 2
        add ecx, esi
        add ecx, edx
        cmp byte [byte ecx+026h], 19h
        jae short .23
        movzx edi, byte [byte ecx+026h]
        cmp ebx, edi
        jne short .22
        mov byte [byte ecx+026h], 0FFh
        jmp short .23
.22:
        jge short .23
        dec byte [byte ecx+026h]
.23:
        inc edx
        cmp edx, byte 4
        jl short .21
        inc eax
        cmp eax, byte 2
        jl short .20
        xor eax, eax
.24:
        xor edx, edx
.25:
        lea ecx, [eax+eax*2]
        add ecx, esi
        add ecx, edx
        cmp byte [byte ecx+02Eh], 19h
        jae short .27
        movzx edi, byte [byte ecx+02Eh]
        cmp ebx, edi
        jne short .26
        mov byte [byte ecx+02Eh], 0FFh
        jmp short .27
.26:
        jge short .27
        dec byte [byte ecx+02Eh]
.27:
        inc edx
        cmp edx, byte 3
        jl short .25
        inc eax
        cmp eax, byte 2
        jl short .24
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FindLineSlot                                    CDEEA  97 PC, low confidence
; Finds a slot in the lines
;-----------------------------------------------------------------------------
FindLineSlot:
        push ebx
        push ecx
        push esi
        push edi
        enter 4, 0
        mov esi, eax
        mov ebx, edx
        mov dword [byte ebp-04h], 1Ch
        xor edx, edx
.1:
        lea eax, [esi+edx]
        movzx ecx, byte [byte eax+034h]
        cmp ecx, dword [byte ebp-04h]
        jge short .5
        cmp byte [byte eax+034h], 19h
        jbe short .2
        lea ecx, [byte ebx+019h]
        jmp short .3
.2:
        mov ecx, ebx
.3:
        lea eax, [esi+edx]
        movzx edi, byte [byte eax+034h]
        cmp ecx, edi
        jne short .4
        mov byte [byte eax+034h], 0FFh
        jmp short .5
.4:
        jge short .5
        dec byte [byte eax+034h]
.5:
        inc edx
        cmp edx, byte 2
        jl short .1
        jmp near DrawPlayerCard_2B8
;-----------------------------------------------------------------------------
; FixLinesAfterTrade                              CDF39  97 PC, low confidence
; Fixes the lines after a trade
;-----------------------------------------------------------------------------
FixLinesAfterTrade:
        push ecx
        push esi
        push edi
        enter 4, 0
        mov ecx, eax
        mov esi, edx
        imul eax, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        or byte [byte edx+eax+06Ah], 2
        test ebx, ebx
        jl short .1
        mov eax, dword [DeletionCount]
        mov edx, eax
        inc eax
        mov edi, dword [RosterPlayerInfo]
        mov dword [DeletionCount], eax
        mov eax, edi
        mov word [eax+edx*2], bx
.1:
        xor eax, eax
        jmp short .4
.2:
        movzx ebx, byte [byte edx+eax+06Eh]
        cmp ebx, esi
        jne short .3
        dec byte [byte edx+071h]
        jmp short .6
.3:
        inc eax
.4:
        imul edx, dword [nosplit ecx*4+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        add edx, ebx
        movzx ebx, byte [byte edx+071h]
        cmp eax, ebx
        jl short .2
        jmp short .6
.5:
        inc eax
        mov bl, byte [byte edx+eax+06Eh]
        mov byte [byte edx+eax+06Dh], bl
.6:
        imul edx, dword [nosplit ecx*4+RosterTeam], dword 32C6h
        mov ebx, dword [RosterTeams]
        add edx, ebx
        movzx ebx, byte [byte edx+071h]
        cmp eax, ebx
        jl short .5
        xor eax, eax
        jmp short .9
.7:
        add edx, eax
        movzx ebx, byte [byte edx+06Eh]
        cmp ebx, esi
        jle short .8
        dec byte [byte edx+06Eh]
.8:
        inc eax
.9:
        mov ebx, ecx
        shl ebx, 2
        imul edx, dword [dword ebx+RosterTeam], dword 32C6h
        mov edi, dword [RosterTeams]
        add edx, edi
        movzx edi, byte [byte edx+071h]
        cmp eax, edi
        jl short .7
        mov eax, dword [edx]
        movsx ecx, word [dword eax+0D05h]
        mov dword [byte ebp-04h], ecx
        lea ecx, [byte eax+018h]
        cmp esi, dword [byte ebp-04h]
        jge short .11
        mov edx, esi
        mov eax, ecx
        call RebuildLinesAfterTrade
        imul edx, dword [dword ebx+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        add eax, edx
        lea edx, [dword eax+0321Eh]
        push edx
        lea edx, [dword eax+08FEh]
        push edx
        lea edx, [byte eax+076h]
        push edx
        mov edx, dword [eax]
        lea ecx, [dword edx+0D09h]
        lea ebx, [dword edx+0D05h]
.10:
        lea edx, [byte eax+074h]
        jmp near .14
.11:
        movsx edi, word [dword eax+01281h]
        sub esi, dword [byte ebp-04h]
        cmp esi, edi
        jge short .12
        mov edx, esi
        mov eax, ecx
        call FindLineSlot
        imul eax, dword [dword ebx+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        lea edx, [dword eax+03237h]
        push edx
        lea edx, [dword eax+01B5Ah]
        push edx
        lea edx, [dword eax+0445h]
        push edx
        mov edx, dword [eax]
        lea ecx, [dword edx+01283h]
        lea ebx, [dword edx+01281h]
        jmp short .10
.12:
        movsx ebx, word [dword eax+0132Bh]
        sub esi, edi
        lea edi, [byte edx+074h]
        cmp esi, ebx
        jge short .13
        lea ebx, [dword edx+0323Ah]
        push ebx
        lea ebx, [dword edx+01D8Eh]
        push ebx
        add edx, 4BAh
        lea ecx, [dword eax+0132Dh]
        push edx
        lea ebx, [dword eax+0132Bh]
        mov edx, edi
        jmp short .14
.13:
        sub esi, ebx
        movsx ebx, word [dword eax+018A5h]
        cmp esi, ebx
        jge short .15
        lea ebx, [dword edx+03253h]
        push ebx
        lea ebx, [dword edx+02FEAh]
        push ebx
        add edx, 889h
        lea ecx, [dword eax+018A7h]
        push edx
        lea ebx, [dword eax+018A5h]
        mov edx, edi
.14:
        mov eax, esi
        call RemoveFromLines
.15:
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; RemoveFromLines                                 CE111  97 PC, low confidence
; Removes a player from the lines
;-----------------------------------------------------------------------------
RemoveFromLines:
        push esi
        push edi
        push ebp
        mov ebp, esp
        push ecx
        dec word [edx]
        dec word [ebx]
        jmp short .2
.1:
        lea edx, [byte eax+01h]
        imul esi, edx, byte 38h
        imul edi, eax, byte 38h
        mov ecx, 0Eh
        add esi, dword [byte ebp-04h]
        add edi, dword [byte ebp-04h]
        rep movsd
        imul esi, edx, byte 27h
        imul edi, eax, byte 27h
        mov ecx, 27h
        add esi, dword [byte ebp+010h]
        add edi, dword [byte ebp+010h]
        rep movsb
        imul esi, edx, dword 0BCh
        imul edi, eax, dword 0BCh
        mov ecx, 2Fh
        add esi, dword [byte ebp+014h]
        add edi, dword [byte ebp+014h]
        add eax, dword [byte ebp+018h]
        rep movsd
        mov cl, byte [byte eax+01h]
        mov byte [eax], cl
        mov eax, edx
.2:
        movsx edx, word [ebx]
        cmp eax, edx
        jl short .1
RemoveFromLines_61:
        leave
        pop edi
        pop esi
        ret 0Ch
;-----------------------------------------------------------------------------
; UpdateRosterCounts                              CE178  97 PC, low confidence
; Updates the roster counts
;-----------------------------------------------------------------------------
UpdateRosterCounts:
        push esi
        push edi
        enter 20h, 0
        push eax
        mov esi, edx
        mov dword [byte ebp-04h], ebx
        mov edx, ecx
        imul eax, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add eax, ecx
        lea ecx, [byte eax+074h]
        mov dword [byte ebp-01Ch], ecx
        test esi, esi
        jne short .1
        mov ecx, dword [eax]
        lea edi, [dword ecx+0D05h]
        add ecx, 0D09h
        mov dword [byte ebp-0Ch], ecx
        lea ecx, [byte eax+076h]
        mov dword [byte ebp-010h], ecx
        lea ecx, [dword eax+08FEh]
        mov dword [byte ebp-014h], edi
        add eax, 321Eh
        mov dword [byte ebp-08h], ecx
        mov dword [byte ebp-018h], eax
        jmp short .2
.1:
        mov eax, dword [eax]
        movsx ebx, word [dword eax+0D05h]
        add ebx, dword [byte ebp-04h]
.2:
        mov eax, dword [byte ebp-024h]
        shl eax, 2
        cmp esi, byte 1
        jne short .3
        imul eax, dword [dword eax+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add eax, ecx
        mov ecx, dword [eax]
        lea edi, [dword ecx+01281h]
        add ecx, 1283h
        mov dword [byte ebp-0Ch], ecx
        lea ecx, [dword eax+0445h]
        mov dword [byte ebp-010h], ecx
        lea ecx, [dword eax+01B5Ah]
        mov dword [byte ebp-014h], edi
        add eax, 3237h
        mov dword [byte ebp-08h], ecx
        mov dword [byte ebp-018h], eax
        jmp short .4
.3:
        jle short .4
        imul eax, dword [dword eax+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        mov eax, dword [ecx+eax]
        movsx eax, word [dword eax+01281h]
        add ebx, eax
.4:
        mov eax, dword [byte ebp-024h]
        shl eax, 2
        cmp esi, byte 2
        jne short .5
        imul eax, dword [dword eax+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add eax, ecx
        mov ecx, dword [eax]
        lea edi, [dword ecx+0132Bh]
        add ecx, 132Dh
        mov dword [byte ebp-0Ch], ecx
        lea ecx, [dword eax+04BAh]
        mov dword [byte ebp-010h], ecx
        lea ecx, [dword eax+01D8Eh]
        mov dword [byte ebp-014h], edi
        add eax, 323Ah
        mov dword [byte ebp-08h], ecx
        mov dword [byte ebp-018h], eax
        jmp short .6
.5:
        jle short .6
        imul eax, dword [dword eax+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        mov eax, dword [ecx+eax]
        movsx eax, word [dword eax+0132Bh]
        add ebx, eax
.6:
        cmp esi, byte 3
        jne short .7
        mov eax, dword [byte ebp-024h]
        imul ecx, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        add eax, ecx
        mov ecx, dword [eax]
        lea esi, [dword ecx+018A5h]
        add ecx, 18A7h
        mov dword [byte ebp-0Ch], ecx
        lea ecx, [dword eax+0889h]
        mov dword [byte ebp-010h], ecx
        lea ecx, [dword eax+02FEAh]
        mov dword [byte ebp-014h], esi
        add eax, 3253h
        mov dword [byte ebp-08h], ecx
        mov dword [byte ebp-018h], eax
.7:
        mov eax, dword [byte ebp-014h]
        movsx eax, word [eax]
        jmp short .9
.8:
        lea ecx, [byte eax-01h]
        imul edi, eax, byte 38h
        mov dword [byte ebp-020h], ecx
        imul esi, ecx, byte 38h
        add edi, dword [byte ebp-0Ch]
        mov ecx, 0Eh
        add esi, dword [byte ebp-0Ch]
        rep movsd
        imul esi, dword [byte ebp-020h], byte 27h
        imul edi, eax, byte 27h
        mov ecx, 27h
        add esi, dword [byte ebp-010h]
        add edi, dword [byte ebp-010h]
        rep movsb
        imul esi, dword [byte ebp-020h], dword 0BCh
        imul edi, eax, dword 0BCh
        mov ecx, 2Fh
        add esi, dword [byte ebp-08h]
        add edi, dword [byte ebp-08h]
        rep movsd
        mov esi, dword [byte ebp-018h]
        mov cl, byte [byte esi+eax-01h]
        mov byte [esi+eax], cl
        dec eax
.9:
        cmp eax, dword [byte ebp-04h]
        jg short .8
        imul edi, dword [byte ebp-04h], byte 38h
        mov ecx, 0Eh
        mov esi, edx
        add edi, dword [byte ebp-0Ch]
        rep movsd
        imul edi, dword [byte ebp-04h], byte 27h
        mov ecx, 27h
        lea esi, [byte edx+038h]
        add edi, dword [byte ebp-010h]
        rep movsb
        imul edi, dword [byte ebp-04h], dword 0BCh
        mov ecx, 2Fh
        lea esi, [byte edx+05Fh]
        add edi, dword [byte ebp-08h]
        mov eax, dword [byte ebp-018h]
        rep movsd
        add eax, dword [byte ebp-04h]
        mov dl, byte [dword edx+011Bh]
        mov byte [eax], dl
        mov edx, dword [byte ebp-01Ch]
        inc word [edx]
        mov edx, dword [byte ebp-014h]
        mov eax, dword [byte ebp-024h]
        inc word [edx]
        imul edx, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        movzx esi, byte [byte edx+eax+071h]
        xor eax, eax
        jmp short .12
.10:
        mov edx, dword [byte ebp-024h]
        imul edx, dword [nosplit edx*4+RosterTeam], dword 32C6h
        mov ecx, dword [RosterTeams]
        add edx, ecx
        add edx, eax
        movzx ecx, byte [byte edx+06Eh]
        cmp ecx, ebx
        jl short .11
        inc byte [byte edx+06Eh]
.11:
        inc eax
.12:
        cmp eax, esi
        jl short .10
        mov eax, ebx
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; RosterCreatePlayer                              CE3F2  97 PC, low confidence
; Opens the create player screen from the roster screen
;-----------------------------------------------------------------------------
RosterCreatePlayer:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 124h, 0
        mov esi, eax
        imul ebx, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [ebx+eax]
        xor edi, edi
        movsx ebx, word [dword eax+0132Bh]
        xor edx, edx
        mov dword [byte ebp-04h], ebx
        movsx ebx, word [dword eax+018A5h]
        mov dword [CreatePlayerSlot], esi
        cmp dword [byte ebp-04h], byte 19h
        jl short .1
        cmp ebx, byte 3
        jge near .12
.1:
        cmp ebx, byte 3
        jge short .2
        or dl, 2
.2:
        cmp dword [byte ebp-04h], byte 19h
        jge short .3
        or dl, 1
.3:
        cmp dword [RosterScreenOpen], byte 0
        je short .4
        call FreeRosterScreen
.4:
        lea eax, [dword ebp-0124h]
        call CreatePlayerScreen
        mov edi, eax
        cmp dword [RosterScreenOpen], byte 0
        je short .5
        call InitRosterScreen
.5:
        test edi, edi
        je short .6
        mov eax, dword [RosterPanelBitmap]
        mov edx, 2
        jmp short .7
.6:
        mov eax, dword [RosterPanelBitmap]
        xor edx, edx
.7:
        mov eax, dword [byte eax+02Ch]
        call WipeScreen
        test edi, edi
        je near .13
        cmp byte [dword ebp-0122h], 47h
        jne short .8
        lea ecx, [dword ebp-0124h]
        mov edx, 3
        jmp short .9
.8:
        lea ecx, [dword ebp-0124h]
        mov ebx, dword [byte ebp-04h]
        mov edx, 2
.9:
        mov eax, esi
        call UpdateRosterCounts
        mov dword [byte ebp-08h], eax
        shl esi, 2
        imul eax, dword [dword esi+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        cmp byte [byte eax+071h], 3
        jae short .10
        mov dl, byte [byte eax+071h]
        movzx ebx, dl
        inc dl
        mov byte [byte eax+071h], dl
        imul edx, dword [dword esi+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        add eax, edx
        mov dl, byte [byte ebp-08h]
        mov byte [byte ebx+eax+06Eh], dl
        jmp short .11
.10:
        mov dl, byte [byte ebp-08h]
        mov byte [byte eax+070h], dl
.11:
        mov dword [RosterEditOpen], 1
        jmp short .13
.12:
        push byte 1
        mov eax, 0EAh
        mov edx, 1
        xor ecx, ecx
        xor ebx, ebx
        call GetLangText
        call ShowMessageBox
.13:
        mov eax, edi
        jmp near DrawRatingBars_157
;-----------------------------------------------------------------------------
; ReleasePlayer                                   CE53C  97 PC, low confidence
; Releases a player from the roster
;-----------------------------------------------------------------------------
ReleasePlayer:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 368h, 0
        push eax
        sub ebp, 3E6h
        imul edx, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        mov dword [dword ebp+03E2h], 64h
        movzx eax, byte [byte edx+eax+071h]
        xor esi, esi
        mov dword [dword ebp+03DEh], eax
        jmp near .6
.1:
        mov eax, dword [byte ebp+07Ah]
        imul eax, dword [nosplit eax*4+RosterTeam], dword 32C6h
        mov edi, dword [RosterTeams]
        movzx edx, byte [byte edi+eax+06Eh]
        mov edi, dword [edi+eax]
        mov eax, esi
        movsx ebx, word [dword edi+0D05h]
        shl eax, 2
        cmp edx, ebx
        jge short .2
        mov dword [dword eax+ebp+03D2h], 2
        jmp short .5
.2:
        sub edx, ebx
        movsx ebx, word [dword edi+01281h]
        cmp edx, ebx
        jge short .3
        mov dword [dword eax+ebp+03D2h], 3
        jmp short .5
.3:
        sub edx, ebx
        movsx ebx, word [dword edi+0132Bh]
        cmp edx, ebx
        jge short .4
        mov dword [dword eax+ebp+03D2h], 0
        jmp short .5
.4:
        sub edx, ebx
        movsx ebx, word [dword edi+018A5h]
        cmp edx, ebx
        jge short .5
        mov dword [dword eax+ebp+03D2h], 1
.5:
        imul ebx, esi, dword 11Ch
        lea eax, [byte ebp+07Eh]
        mov ecx, 0FFFFFFFFh
        xor edx, edx
        add ebx, eax
        mov eax, dword [byte ebp+07Ah]
        inc esi
        call ApplyTrade
.6:
        cmp esi, dword [dword ebp+03DEh]
        jl near .1
        xor esi, esi
        jmp short .8
.7:
        imul ecx, esi, dword 11Ch
        lea eax, [byte ebp+07Eh]
        mov edx, dword [dword ebp+esi*4+03D2h]
        xor ebx, ebx
        add ecx, eax
        mov eax, dword [byte ebp+07Ah]
        call UpdateRosterCounts
        mov ebx, eax
        imul eax, dword [dword edi+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        add eax, edx
        mov byte [byte esi+eax+06Eh], bl
        imul eax, dword [dword edi+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        inc esi
        inc byte [byte edx+eax+071h]
.8:
        mov edi, dword [byte ebp+07Ah]
        shl edi, 2
        cmp esi, dword [dword ebp+03DEh]
        jl short .7
        cmp dword [dword ebp+03DEh], byte 0
        jle near .12
        imul eax, dword [dword edi+RosterTeam], dword 32C6h
        mov edx, dword [RosterTeams]
        or byte [byte edx+eax+06Ah], 2
        mov eax, dword [byte ebp+07Ah]
        mov dword [RosterEditOpen], 1
        call RateTrade
        imul edx, dword [dword edi+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [edx+eax]
        call BuildAutoLines
        imul edx, dword [dword edi+RosterTeam], dword 32C6h
        mov eax, dword [RosterTeams]
        mov eax, dword [edx+eax]
        xor esi, esi
        call RemoveListEntry
        mov edx, dword [RosterTeams]
        jmp short .11
.9:
        mov eax, dword [byte ebp+07Ah]
        imul eax, dword [nosplit eax*4+RosterTeam], dword 32C6h
        add eax, edx
        movzx eax, byte [byte esi+eax+06Eh]
        cmp eax, dword [dword ebp+03E2h]
        jge short .10
        mov dword [dword ebp+03E2h], eax
.10:
        inc esi
.11:
        cmp esi, dword [dword ebp+03DEh]
        jl short .9
        mov edx, dword [dword ebp+03E2h]
        mov eax, dword [byte ebp+07Ah]
        call ClampRosterScroll
.12:
        lea esp, [dword ebp+03E6h]
        jmp near ShowTradeRejected_108
;-----------------------------------------------------------------------------
; CompareShorts                                   CE730  97 PC, low confidence
; Compares two 16-bit values (sort helper)
;-----------------------------------------------------------------------------
CompareShorts:
        push ebx
        movsx ebx, word [eax]
        movsx eax, word [edx]
        sub eax, ebx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SaveTrades                                      CE73B  97 PC, low confidence
; Saves the trades to the league
;-----------------------------------------------------------------------------
SaveTrades:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 20h, 0
        xor esi, esi
        mov dword [byte ebp-0Ch], esi
        jmp near .15
.1:
        imul eax, dword 32C6h
        mov edx, dword [RosterTeams]
        test byte [byte edx+eax+06Ah], 2
        je near .14
        mov dword [byte ebp-08h], 0
        jmp near .4
.2:
        mov esi, dword [byte ebp-08h]
        test byte [dword edx+esi+0321Eh], 40h
        je near .3
        lea ebx, [byte ebp-04h]
        push ebx
        imul ebx, esi, byte 38h
        add eax, ebx
        mov dword [byte ebp-020h], ebx
        movzx ebx, byte [dword eax+0D0Bh]
        push ebx
        imul ebx, esi, byte 27h
        movzx ecx, byte [dword eax+0D0Ah]
        lea eax, [byte edx+076h]
        add ebx, eax
        imul eax, esi, dword 0BCh
        add edx, 8FEh
        add edx, eax
        mov eax, dword [RosterData]
        call SaveTradesLink
        movsx edx, word [byte ebp-04h]
        imul edx, byte 38h
        mov eax, dword [RosterData]
        mov eax, dword [dword eax+0383C1h]
        add edx, eax
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp-014h]
        mov esi, dword [eax]
        add esi, dword [byte ebp-020h]
        mov ecx, 0Eh
        lea edi, [dword esi+0D09h]
        mov esi, edx
        rep movsd
        movsx edx, word [byte ebp-04h]
        imul edx, byte 38h
        mov eax, dword [RosterData]
        mov eax, dword [dword eax+0383C1h]
        add edx, eax
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp-014h]
        mov esi, dword [eax]
        add esi, dword [byte ebp-020h]
        mov ecx, 0Eh
        lea edi, [dword esi+0BFh]
        mov esi, edx
        rep movsd
.3:
        inc dword [byte ebp-08h]
.4:
        imul eax, dword [byte ebp-0Ch], dword 32C6h
        mov edx, dword [RosterTeams]
        add edx, eax
        mov dword [byte ebp-014h], eax
        mov eax, dword [edx]
        movsx ebx, word [dword eax+0D05h]
        cmp ebx, dword [byte ebp-08h]
        jg near .2
        mov dword [byte ebp-08h], 0
        jmp near .7
.5:
        mov esi, dword [byte ebp-08h]
        test byte [dword edx+esi+03237h], 40h
        je near .6
        lea ebx, [byte ebp-04h]
        push ebx
        imul ebx, esi, byte 38h
        add eax, ebx
        mov dword [byte ebp-020h], ebx
        movzx ebx, byte [dword eax+01285h]
        movzx ecx, byte [dword eax+01284h]
        imul eax, esi, byte 27h
        push ebx
        lea ebx, [dword edx+0445h]
        add ebx, eax
        imul eax, esi, dword 0BCh
        add edx, 1B5Ah
        add edx, eax
        mov eax, dword [RosterData]
        call SaveTradesLink
        movsx edx, word [byte ebp-04h]
        imul edx, byte 38h
        mov eax, dword [RosterData]
        mov eax, dword [dword eax+0383C1h]
        add edx, eax
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp-01Ch]
        mov esi, dword [eax]
        add esi, dword [byte ebp-020h]
        mov ecx, 0Eh
        lea edi, [dword esi+01283h]
        mov esi, edx
        rep movsd
        movsx edx, word [byte ebp-04h]
        imul edx, byte 38h
        mov eax, dword [RosterData]
        mov eax, dword [dword eax+0383C1h]
        add edx, eax
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp-01Ch]
        mov esi, dword [eax]
        add esi, dword [byte ebp-020h]
        mov ecx, 0Eh
        lea edi, [dword esi+0639h]
        mov esi, edx
        rep movsd
.6:
        inc dword [byte ebp-08h]
.7:
        imul eax, dword [byte ebp-0Ch], dword 32C6h
        mov edx, dword [RosterTeams]
        add edx, eax
        mov dword [byte ebp-01Ch], eax
        mov eax, dword [edx]
        movsx ebx, word [dword eax+01281h]
        cmp ebx, dword [byte ebp-08h]
        jg near .5
        mov dword [byte ebp-08h], 0
        jmp near .10
.8:
        mov esi, dword [byte ebp-08h]
        test byte [dword esi+eax+0323Ah], 40h
        je near .9
        lea ebx, [byte ebp-04h]
        push ebx
        imul ebx, esi, byte 38h
        add edx, ebx
        mov dword [byte ebp-020h], ebx
        movzx ebx, byte [dword edx+0132Fh]
        movzx ecx, byte [dword edx+0132Eh]
        imul edx, esi, byte 27h
        push ebx
        lea ebx, [dword eax+04BAh]
        add ebx, edx
        imul edx, esi, dword 0BCh
        add eax, 1D8Eh
        add edx, eax
        mov eax, dword [RosterData]
        call SaveTradesLink
        movsx ebx, word [byte ebp-04h]
        imul ebx, byte 38h
        mov eax, dword [RosterData]
        mov edx, dword [dword eax+0383C1h]
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp-018h]
        mov esi, dword [eax]
        add esi, dword [byte ebp-020h]
        mov ecx, 0Eh
        add edx, ebx
        lea edi, [dword esi+0132Dh]
        mov esi, edx
        rep movsd
        movsx edx, word [byte ebp-04h]
        imul edx, byte 38h
        mov eax, dword [RosterData]
        mov eax, dword [dword eax+0383C1h]
        add edx, eax
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp-018h]
        mov esi, dword [eax]
        add esi, dword [byte ebp-020h]
        mov ecx, 0Eh
        lea edi, [dword esi+06E3h]
        mov esi, edx
        rep movsd
.9:
        inc dword [byte ebp-08h]
.10:
        imul eax, dword [byte ebp-0Ch], dword 32C6h
        mov dword [byte ebp-018h], eax
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp-018h]
        mov edx, dword [eax]
        movsx ebx, word [dword edx+0132Bh]
        cmp ebx, dword [byte ebp-08h]
        jg near .8
        mov dword [byte ebp-08h], 0
        jmp near .13
.11:
        mov esi, dword [byte ebp-08h]
        test byte [dword edx+esi+03253h], 40h
        je near .12
        lea ebx, [byte ebp-04h]
        push ebx
        imul ebx, esi, byte 38h
        add eax, ebx
        mov dword [byte ebp-020h], ebx
        movzx ebx, byte [dword eax+018A9h]
        push ebx
        imul ebx, esi, byte 27h
        movzx ecx, byte [dword eax+018A8h]
        lea eax, [dword edx+0889h]
        add ebx, eax
        imul eax, esi, dword 0BCh
        add edx, 2FEAh
        add edx, eax
        mov eax, dword [RosterData]
        call SaveTradesLink
        movsx edx, word [byte ebp-04h]
        imul edx, byte 38h
        mov eax, dword [RosterData]
        mov eax, dword [dword eax+0383C1h]
        add edx, eax
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp-010h]
        mov esi, dword [eax]
        add esi, dword [byte ebp-020h]
        mov ecx, 0Eh
        lea edi, [dword esi+018A7h]
        mov esi, edx
        rep movsd
        movsx edx, word [byte ebp-04h]
        imul edx, byte 38h
        mov eax, dword [RosterData]
        mov eax, dword [dword eax+0383C1h]
        add edx, eax
        mov eax, dword [RosterTeams]
        add eax, dword [byte ebp-010h]
        mov esi, dword [eax]
        add esi, dword [byte ebp-020h]
        mov ecx, 0Eh
        lea edi, [dword esi+0C5Dh]
        mov esi, edx
        rep movsd
.12:
        inc dword [byte ebp-08h]
.13:
        imul eax, dword [byte ebp-0Ch], dword 32C6h
        mov edx, dword [RosterTeams]
        add edx, eax
        mov dword [byte ebp-010h], eax
        mov eax, dword [edx]
        movsx ebx, word [dword eax+018A5h]
        cmp ebx, dword [byte ebp-08h]
        jg near .11
        mov esi, 1
.14:
        imul eax, dword [byte ebp-0Ch], dword 32C6h
        mov edx, dword [RosterTeams]
        inc dword [byte ebp-0Ch]
        and byte [byte edx+eax+06Ah], 0FDh
.15:
        mov eax, dword [byte ebp-0Ch]
        cmp eax, dword [RosterScrollList]
        jl near .1
        test esi, esi
        je short .16
        call BuildTradePlayerLists
.16:
        cmp dword [RosterMode], byte 0
        jne short .20
        test esi, esi
        je short .17
        mov eax, dword [RosterData]
        call SaveAgents
.17:
        cmp dword [DeletionCount], byte 0
        jle short .20
        mov ecx, CompareShorts
        mov ebx, 2
        mov edx, dword [DeletionCount]
        mov eax, dword [RosterPlayerInfo]
        mov dword [byte ebp-0Ch], 0
        call qsort_
        jmp short .19
.18:
        mov edx, dword [RosterPlayerInfo]
        movsx edx, word [edx+eax*2]
        mov eax, dword [RosterData]
        inc dword [byte ebp-0Ch]
        call SaveAgentsOnly
.19:
        mov eax, dword [byte ebp-0Ch]
        cmp eax, dword [DeletionCount]
        jl short .18
.20:
        test esi, esi
        je near DrawRatingBars_157
        mov dword [byte ebp-0Ch], 0
        jmp short .23
.21:
        cmp dword [RosterMode], byte 0
        je short .22
        imul eax, dword 194Fh
        mov edx, dword [RosterFreeAgents]
        add eax, edx
        call UpdateGameRecord
.22:
        inc dword [byte ebp-0Ch]
.23:
        mov eax, dword [byte ebp-0Ch]
        cmp eax, dword [RosterScrollList]
        jl short .21
        jmp near DrawRatingBars_157
;-----------------------------------------------------------------------------
; ResetExhibitionRosters                          CEBC0  97 PC, low confidence
; Resets the exhibition rosters
;-----------------------------------------------------------------------------
ResetExhibitionRosters:
        push ebx
        push edx
        xor edx, edx
        jmp short .2
.1:
        imul ebx, edx, dword 32C6h
        mov eax, dword [RosterTeams]
        and byte [byte ebx+eax+06Ah], 0FEh
        mov eax, dword [RosterTeams]
        inc edx
        mov word [byte ebx+eax+072h], 0
.2:
        cmp edx, dword [RosterScrollList]
        jl short .1
        cmp dword [RosterMode], byte 0
        jne short .3
        mov eax, RosterData
        call FreeExhibitionFile
        mov eax, RosterData
        call ResetExhibitionStats
        mov dword [DeletionCount], 0
.3:
        pop edx
        pop ebx
        ret
