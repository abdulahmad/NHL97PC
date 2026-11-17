; League data transfer over the link: sending and receiving files and transfer buffers.
bits 32
%include "hockey.inc"
section s_A12CD progbits alloc exec nowrite align=1
extern AddPlayerStatAt, AddReplayIndexEntry, AllocMemBlock, atoi_, ClearLinkAbort, DbKeyBuffer, DrawTextAt, FillRectColor
extern FindGameRecord, FindPlayerRecord, FindPlayerStat, FindReplayIndexEntry, FindTeamStat, FreeMemBlock, GetLangText, HideLinkBox
extern HideWorkingBox, KeysEqual, LinkGameActive, LinkMessageText, LinkReceiveBlock, LinkReceiveChunk, LinkSendBlock, LinkSendFile
extern LinkSetupBuffer, LinkSetupItemCount, LinkSetupValues, MakeColor, memcpy_, OpenReplayFile, PickIndexEntryScreen_1080, PlayoffSettings
extern PlayoffUserActive, PlayoffUserHuman, PresentScreen, SeasonActive, SeasonLastAway, SeasonLastHome, SeasonName, SeasonScheduleData
extern SeasonScheduleOffset, SeasonScheduleSize, SeasonUserActive, SeasonUserHuman, SeasonUserTeam, SendGameResult, SetHighlightText, SetTextColors
extern ShowLinkMessage, ShowMessageBox, ShowWorkingBox, sprintf_, str_CRUSHER, str_CRUSHERPack, str_D_LinkSendData, str_Games
extern str_Lros, str_Replaybuf, str_Ros, str_Rosids, str_Roster3, str_Rtids, TransferBuffer, TransferOffset
extern TransferPackBuffer, UpdateGameRecord, UpdatePlayerRecord, UpdatePlayerStat, UpdateTeamStat, UpdateWorkingBox, WriteLeagueHeader
global SendLeagueData, ReceiveLeagueData, SendLeagueFile, SendLeagueFile_6F3, SendLeagueFile_6FD, SendLeagueFile_6FE, ReceiveLeagueFile, AllocCrusherBuffers
global FreeTransferBuffers, CopyToTransfer, LinkSendData, LinkSendData_BB, LinkReceiveData, AppendToTransfer, DrawLinkStatusText, ResetLinkSetupJumpTable
global ResetLinkSetup, ResetLinkSetup_20, ResetLinkSetup_45, ResetLinkSetup_50, ResetLinkSetup_57, ResetLinkSetup_5E
;-----------------------------------------------------------------------------
; SendLeagueData                                  A12CD  97 PC, low confidence
; Sends the league data over the link
;-----------------------------------------------------------------------------
SendLeagueData:
        push ebx
        push ecx
        push esi
        push edi
        enter 4BB0h, 0
        mov esi, eax
        mov dword [byte ebp-0Ch], edx
        call AllocCrusherBuffers
        push byte 0
        push dword 194Fh
        push str_Roster3
        call AllocMemBlock
        add esp, byte 0Ch
        mov edx, 24h
        mov edi, eax
        call SetHighlightText
        mov eax, esi
        call CopyToTransfer
        movsx edx, word [esi]
        mov eax, dword [byte esi+014h]
        shl edx, 3
        call CopyToTransfer
        movsx edx, word [esi]
        mov eax, dword [byte esi+01Ch]
        shl edx, 3
        call CopyToTransfer
        movsx edx, word [esi]
        mov eax, dword [byte esi+018h]
        shl edx, 3
        call CopyToTransfer
        call PresentScreen
        push dword 0FFAA0000h
        call MakeColor
        add esp, byte 4
        push eax
        push dword 1B8h
        push dword 222h
        push dword 190h
        push dword 222h
        call FillRectColor
        add esp, byte 14h
        xor eax, eax
        call LinkSendData
        movsx edx, word [byte esi+02h]
        mov eax, dword [byte esi+020h]
        shl edx, 4
        call CopyToTransfer
        xor eax, eax
        call LinkSendData
        cmp dword [byte ebp-0Ch], byte 0
        je short .3
        mov edx, 4
        mov eax, SeasonScheduleSize
        xor ebx, ebx
        mov dword [byte ebp-04h], 0
        call LinkSendBlock
        jmp short .2
.1:
        mov eax, dword [SeasonScheduleData]
        mov dword [byte ebp-014h], eax
        mov eax, dword [SeasonScheduleOffset]
        add eax, dword [byte ebp-04h]
        lea edx, [byte ebp-03Ch]
        mov dword [byte ebp-010h], eax
        lea eax, [byte ebp-014h]
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-03Ch]
        inc dword [byte ebp-04h]
        call CopyToTransfer
.2:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [SeasonScheduleSize]
        jl short .1
        xor eax, eax
        call LinkSendData
.3:
        mov dword [byte ebp-04h], 0
        jmp near .29
.4:
        mov eax, dword [byte ebp-04h]
        mov edx, dword [byte esi+01Ch]
        shl eax, 3
        add eax, edx
        mov edx, edi
        call FindGameRecord
        mov edx, 194Fh
        mov eax, edi
        xor ebx, ebx
        call CopyToTransfer
        jmp near .10
.5:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+0D21h], byte 0
        je short .6
        lea eax, [dword edi+0D09h]
        add eax, edx
        lea edx, [dword ebp-0138h]
        add eax, byte 18h
        call FindPlayerRecord
        mov edx, 0BCh
        lea eax, [dword ebp-0138h]
        call CopyToTransfer
.6:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+0D39h], byte 0
        je short .7
        lea eax, [dword edi+0D09h]
        add eax, edx
        lea edx, [byte ebp-03Ch]
        add eax, byte 30h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-03Ch]
        call CopyToTransfer
.7:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+0D31h], byte 0
        je short .8
        lea eax, [dword edi+0D09h]
        add eax, edx
        lea edx, [byte ebp-03Ch]
        add eax, byte 28h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-03Ch]
        call CopyToTransfer
.8:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+0D29h], byte 0
        je short .9
        lea eax, [dword edi+0D09h]
        add eax, edx
        lea edx, [byte ebp-07Ch]
        add eax, byte 20h
        call FindTeamStat
        mov edx, 3Dh
        lea eax, [byte ebp-07Ch]
        call CopyToTransfer
.9:
        inc ebx
.10:
        movsx eax, word [dword edi+0D05h]
        cmp ebx, eax
        jl near .5
        xor ebx, ebx
        jmp near .16
.11:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+0129Bh], byte 0
        je short .12
        lea eax, [dword edi+01283h]
        add eax, edx
        lea edx, [dword ebp-0138h]
        add eax, byte 18h
        call FindPlayerRecord
        mov edx, 0BCh
        lea eax, [dword ebp-0138h]
        call CopyToTransfer
.12:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+012B3h], byte 0
        je short .13
        lea eax, [dword edi+01283h]
        add eax, edx
        lea edx, [byte ebp-03Ch]
        add eax, byte 30h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-03Ch]
        call CopyToTransfer
.13:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+012ABh], byte 0
        je short .14
        lea eax, [dword edi+01283h]
        add eax, edx
        lea edx, [byte ebp-03Ch]
        add eax, byte 28h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-03Ch]
        call CopyToTransfer
.14:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+012A3h], byte 0
        je short .15
        lea eax, [dword edi+01283h]
        add eax, edx
        lea edx, [byte ebp-07Ch]
        add eax, byte 20h
        call FindTeamStat
        mov edx, 3Dh
        lea eax, [byte ebp-07Ch]
        call CopyToTransfer
.15:
        inc ebx
.16:
        movsx eax, word [dword edi+01281h]
        cmp ebx, eax
        jl near .11
        xor ebx, ebx
        jmp near .22
.17:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+01345h], byte 0
        je short .18
        lea eax, [dword edi+0132Dh]
        add eax, edx
        lea edx, [dword ebp-0138h]
        add eax, byte 18h
        call FindPlayerRecord
        mov edx, 0BCh
        lea eax, [dword ebp-0138h]
        call CopyToTransfer
.18:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+0135Dh], byte 0
        je short .19
        lea eax, [dword edi+0132Dh]
        add eax, edx
        lea edx, [byte ebp-03Ch]
        add eax, byte 30h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-03Ch]
        call CopyToTransfer
.19:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+01355h], byte 0
        je short .20
        lea eax, [dword edi+0132Dh]
        add eax, edx
        lea edx, [byte ebp-03Ch]
        add eax, byte 28h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-03Ch]
        call CopyToTransfer
.20:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+0134Dh], byte 0
        je short .21
        lea eax, [dword edi+0132Dh]
        add eax, edx
        lea edx, [byte ebp-07Ch]
        add eax, byte 20h
        call FindTeamStat
        mov edx, 3Dh
        lea eax, [byte ebp-07Ch]
        call CopyToTransfer
.21:
        inc ebx
.22:
        movsx eax, word [dword edi+0132Bh]
        cmp ebx, eax
        jl near .17
        xor ebx, ebx
        jmp near .28
.23:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+018BFh], byte 0
        je short .24
        lea eax, [dword edi+018A7h]
        add eax, edx
        lea edx, [dword ebp-0138h]
        add eax, byte 18h
        call FindPlayerRecord
        mov edx, 0BCh
        lea eax, [dword ebp-0138h]
        call CopyToTransfer
.24:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+018D7h], byte 0
        je short .25
        lea eax, [dword edi+018A7h]
        add eax, edx
        lea edx, [byte ebp-03Ch]
        add eax, byte 30h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-03Ch]
        call CopyToTransfer
.25:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+018CFh], byte 0
        je short .26
        lea eax, [dword edi+018A7h]
        add eax, edx
        lea edx, [byte ebp-03Ch]
        add eax, byte 28h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-03Ch]
        call CopyToTransfer
.26:
        imul edx, ebx, byte 38h
        cmp dword [dword edx+edi+018C7h], byte 0
        je short .27
        lea eax, [dword edi+018A7h]
        add eax, edx
        lea edx, [byte ebp-07Ch]
        add eax, byte 20h
        call FindTeamStat
        mov edx, 3Dh
        lea eax, [byte ebp-07Ch]
        call CopyToTransfer
.27:
        inc ebx
.28:
        movsx eax, word [dword edi+018A5h]
        cmp ebx, eax
        jl near .23
        inc dword [byte ebp-04h]
.29:
        movsx eax, word [esi]
        cmp eax, dword [byte ebp-04h]
        jg near .4
        xor eax, eax
        call LinkSendData
        mov eax, 227h
        movsx edx, word [byte esi+02h]
        call GetLangText
        call ShowWorkingBox
        cmp dword [byte ebp-0Ch], byte 0
        je short .30
        cmp dword [SeasonActive], byte 0
        jne near .41
.30:
        mov dword [byte ebp-04h], 0
        jmp near .40
.31:
        mov eax, dword [byte ebp-04h]
        mov ebx, dword [byte ebp-04h]
        call UpdateWorkingBox
        shl ebx, 4
        mov eax, dword [byte esi+020h]
        add eax, ebx
        mov edx, DbKeyBuffer
        add eax, byte 8
        call KeysEqual
        test eax, eax
        jne near .39
        cmp dword [byte ebp-0Ch], byte 0
        je near .35
        mov eax, dword [byte esi+020h]
        add eax, ebx
        movsx ebx, byte [eax]
        imul ebx, byte 1Ch
        cmp byte [dword ebx+SeasonUserActive], 1
        je short .32
        movsx eax, byte [byte eax+01h]
        imul eax, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        jne near .35
.32:
        mov eax, dword [byte ebp-04h]
        mov edx, dword [byte esi+020h]
        shl eax, 4
        add eax, edx
        lea edx, [dword ebp-04BB0h]
        add eax, byte 8
        call FindReplayIndexEntry
        cmp dword [dword ebp-0140h], byte 0
        je short .33
        push byte 0
        push dword [dword ebp-0140h]
        push str_Replaybuf
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp-08h], eax
        mov edx, eax
        lea eax, [dword ebp-04BB0h]
        call OpenReplayFile
.33:
        mov edx, 4A78h
        lea eax, [dword ebp-04BB0h]
        call CopyToTransfer
        cmp dword [dword ebp-0140h], byte 0
        je short .34
        mov edx, dword [dword ebp-0140h]
        mov eax, dword [byte ebp-08h]
        call CopyToTransfer
        push dword [byte ebp-08h]
        call FreeMemBlock
        add esp, byte 4
.34:
        mov eax, 1
        call LinkSendData
.35:
        cmp dword [byte ebp-0Ch], byte 0
        jne near .39
        mov eax, dword [byte ebp-04h]
        mov edx, dword [byte esi+020h]
        shl eax, 4
        add eax, edx
        movsx ebx, byte [eax]
        imul ebx, byte 1Ch
        cmp byte [dword ebx+PlayoffUserActive], 1
        je short .36
        movsx eax, byte [byte eax+01h]
        imul eax, byte 1Ch
        cmp byte [dword eax+PlayoffUserActive], 1
        jne near .39
.36:
        mov eax, dword [byte ebp-04h]
        mov edx, dword [byte esi+020h]
        shl eax, 4
        add eax, edx
        lea edx, [dword ebp-04BB0h]
        add eax, byte 8
        call FindReplayIndexEntry
        cmp dword [dword ebp-0140h], byte 0
        je short .37
        push byte 0
        push dword [dword ebp-0140h]
        push str_Replaybuf
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp-08h], eax
        mov edx, eax
        lea eax, [dword ebp-04BB0h]
        call OpenReplayFile
.37:
        mov edx, 4A78h
        lea eax, [dword ebp-04BB0h]
        call CopyToTransfer
        cmp dword [dword ebp-0140h], byte 0
        je short .38
        mov edx, dword [dword ebp-0140h]
        mov eax, dword [byte ebp-08h]
        call CopyToTransfer
        push dword [byte ebp-08h]
        call FreeMemBlock
        add esp, byte 4
.38:
        mov eax, 1
        call LinkSendData
.39:
        inc dword [byte ebp-04h]
.40:
        movsx eax, word [byte esi+02h]
        cmp eax, dword [byte ebp-04h]
        jg near .31
.41:
        call HideWorkingBox
        push dword [TransferBuffer]
        call FreeMemBlock
        add esp, byte 4
        push dword [TransferPackBuffer]
        call FreeMemBlock
        add esp, byte 4
        leave
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ReceiveLeagueData                               A1961  97 PC, low confidence
; Receives the league data over the link
;-----------------------------------------------------------------------------
ReceiveLeagueData:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 4BCCh, 0
        push eax
        sub ebp, 82h
        call AllocCrusherBuffers
        push byte 0
        push dword 194Fh
        push str_Roster3
        call AllocMemBlock
        add esp, byte 0Ch
        mov esi, eax
        call SetHighlightText
        xor eax, eax
        mov ebx, 24h
        call LinkReceiveData
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp+052h]
        add edx, dword [TransferOffset]
        call memcpy_
        movsx eax, word [byte ebp+052h]
        push byte 0
        shl eax, 3
        push eax
        push str_Rosids
        add dword [TransferOffset], byte 24h
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp+06Eh], eax
        movsx eax, word [byte ebp+052h]
        push byte 0
        shl eax, 3
        push eax
        push str_Rtids
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp+066h], eax
        movsx eax, word [byte ebp+054h]
        push byte 0
        shl eax, 4
        push eax
        push str_Games
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp+072h], eax
        movsx eax, word [byte ebp+054h]
        push byte 0
        shl eax, 3
        push eax
        push str_Games
        call AllocMemBlock
        movsx ecx, word [byte ebp+052h]
        add esp, byte 0Ch
        mov dword [byte ebp+06Ah], eax
        shl ecx, 3
        mov eax, dword [byte ebp+066h]
        mov edx, dword [TransferBuffer]
        mov ebx, ecx
        add edx, dword [TransferOffset]
        call memcpy_
        mov eax, dword [byte ebp+06Eh]
        add dword [TransferOffset], ecx
        movsx ecx, word [byte ebp+052h]
        mov edx, dword [TransferBuffer]
        shl ecx, 3
        add edx, dword [TransferOffset]
        mov ebx, ecx
        call memcpy_
        mov eax, dword [byte ebp+06Ah]
        add dword [TransferOffset], ecx
        movsx ecx, word [byte ebp+052h]
        mov edx, dword [TransferBuffer]
        shl ecx, 3
        add edx, dword [TransferOffset]
        mov ebx, ecx
        call memcpy_
        xor eax, eax
        add dword [TransferOffset], ecx
        call LinkReceiveData
        movsx ecx, word [byte ebp+054h]
        mov eax, dword [byte ebp+072h]
        mov edx, dword [TransferBuffer]
        shl ecx, 4
        add edx, dword [TransferOffset]
        mov ebx, ecx
        call memcpy_
        lea eax, [byte ebp+052h]
        add dword [TransferOffset], ecx
        call WriteLeagueHeader
        cmp dword [dword ebp-04B4Eh], byte 0
        je short .3
        mov edx, 4
        mov eax, SeasonScheduleSize
        xor ebx, ebx
        call LinkReceiveBlock
        xor eax, eax
        xor edi, edi
        call LinkReceiveData
        jmp short .2
.1:
        mov eax, dword [SeasonScheduleData]
        mov ebx, 27h
        mov dword [byte ebp+076h], eax
        mov eax, dword [SeasonScheduleOffset]
        mov edx, dword [TransferBuffer]
        add eax, edi
        add edx, dword [TransferOffset]
        mov dword [byte ebp+07Ah], eax
        lea eax, [byte ebp+02Ah]
        inc edi
        call memcpy_
        lea edx, [byte ebp+076h]
        lea eax, [byte ebp+02Ah]
        add dword [TransferOffset], byte 27h
        call AddPlayerStatAt
.2:
        cmp edi, dword [SeasonScheduleSize]
        jl short .1
.3:
        xor eax, eax
        call LinkReceiveData
        xor edi, edi
        jmp near .29
.4:
        mov ebx, 194Fh
        mov edx, dword [TransferBuffer]
        mov eax, esi
        add edx, dword [TransferOffset]
        xor ecx, ecx
        call memcpy_
        mov eax, esi
        add dword [TransferOffset], 194Fh
        call UpdateGameRecord
        jmp near .10
.5:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+0D21h], byte 0
        je short .6
        mov ebx, 0BCh
        mov edx, dword [TransferBuffer]
        lea eax, [dword ebp-0D2h]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [dword ebp-0D2h]
        add dword [TransferOffset], 0BCh
        call UpdatePlayerRecord
.6:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+0D39h], byte 0
        je short .7
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp+02Ah]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp+02Ah]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.7:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+0D31h], byte 0
        je short .8
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp+02Ah]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp+02Ah]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.8:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+0D29h], byte 0
        je short .9
        mov ebx, 3Dh
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp-016h]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp-016h]
        add dword [TransferOffset], byte 3Dh
        call UpdateTeamStat
.9:
        inc ecx
.10:
        movsx eax, word [dword esi+0D05h]
        cmp ecx, eax
        jl near .5
        xor ecx, ecx
        jmp near .16
.11:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+0129Bh], byte 0
        je short .12
        mov ebx, 0BCh
        mov edx, dword [TransferBuffer]
        lea eax, [dword ebp-0D2h]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [dword ebp-0D2h]
        add dword [TransferOffset], 0BCh
        call UpdatePlayerRecord
.12:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+012B3h], byte 0
        je short .13
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp+02Ah]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp+02Ah]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.13:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+012ABh], byte 0
        je short .14
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp+02Ah]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp+02Ah]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.14:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+012A3h], byte 0
        je short .15
        mov ebx, 3Dh
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp-016h]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp-016h]
        add dword [TransferOffset], byte 3Dh
        call UpdateTeamStat
.15:
        inc ecx
.16:
        movsx eax, word [dword esi+01281h]
        cmp ecx, eax
        jl near .11
        xor ecx, ecx
        jmp near .22
.17:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+01345h], byte 0
        je short .18
        mov ebx, 0BCh
        mov edx, dword [TransferBuffer]
        lea eax, [dword ebp-0D2h]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [dword ebp-0D2h]
        add dword [TransferOffset], 0BCh
        call UpdatePlayerRecord
.18:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+0135Dh], byte 0
        je short .19
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp+02Ah]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp+02Ah]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.19:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+01355h], byte 0
        je short .20
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp+02Ah]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp+02Ah]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.20:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+0134Dh], byte 0
        je short .21
        mov ebx, 3Dh
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp-016h]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp-016h]
        add dword [TransferOffset], byte 3Dh
        call UpdateTeamStat
.21:
        inc ecx
.22:
        movsx eax, word [dword esi+0132Bh]
        cmp ecx, eax
        jl near .17
        xor ecx, ecx
        jmp near .28
.23:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+018BFh], byte 0
        je short .24
        mov ebx, 0BCh
        mov edx, dword [TransferBuffer]
        lea eax, [dword ebp-0D2h]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [dword ebp-0D2h]
        add dword [TransferOffset], 0BCh
        call UpdatePlayerRecord
.24:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+018D7h], byte 0
        je short .25
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp+02Ah]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp+02Ah]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.25:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+018CFh], byte 0
        je short .26
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp+02Ah]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp+02Ah]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.26:
        imul eax, ecx, byte 38h
        cmp dword [dword esi+eax+018C7h], byte 0
        je short .27
        mov ebx, 3Dh
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp-016h]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp-016h]
        add dword [TransferOffset], byte 3Dh
        call UpdateTeamStat
.27:
        inc ecx
.28:
        movsx eax, word [dword esi+018A5h]
        cmp ecx, eax
        jl near .23
        inc edi
.29:
        movsx eax, word [byte ebp+052h]
        cmp edi, eax
        jl near .4
        mov eax, 227h
        movsx edx, word [byte ebp+054h]
        call GetLangText
        call ShowWorkingBox
        cmp dword [dword ebp-04B4Eh], byte 0
        je short .30
        cmp dword [SeasonActive], byte 0
        jne near .39
.30:
        xor edi, edi
        jmp near .38
.31:
        mov eax, edi
        call UpdateWorkingBox
        mov ecx, edi
        mov eax, dword [byte ebp+072h]
        shl ecx, 4
        add eax, ecx
        mov edx, DbKeyBuffer
        add eax, byte 8
        call KeysEqual
        test eax, eax
        jne near .37
        cmp dword [dword ebp-04B4Eh], byte 0
        je near .34
        mov eax, dword [byte ebp+072h]
        add eax, ecx
        movsx ecx, byte [eax]
        imul ecx, byte 1Ch
        cmp byte [dword ecx+SeasonUserActive], 1
        je short .32
        movsx eax, byte [byte eax+01h]
        imul eax, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        jne near .34
.32:
        mov eax, 1
        mov ebx, 4A78h
        call LinkReceiveData
        mov edx, dword [TransferBuffer]
        lea eax, [dword ebp-04B4Ah]
        add edx, dword [TransferOffset]
        call memcpy_
        add dword [TransferOffset], 4A78h
        cmp dword [dword ebp-0DAh], byte 0
        je short .33
        push byte 0
        push dword [dword ebp-0DAh]
        push str_Replaybuf
        call AllocMemBlock
        mov ecx, dword [dword ebp-0DAh]
        mov edx, dword [TransferBuffer]
        add esp, byte 0Ch
        mov ebx, ecx
        add edx, dword [TransferOffset]
        mov dword [byte ebp+07Eh], eax
        call memcpy_
        add dword [TransferOffset], ecx
.33:
        mov ebx, dword [dword ebp-0DAh]
        mov edx, dword [byte ebp+07Eh]
        lea eax, [dword ebp-04B4Ah]
        call AddReplayIndexEntry
        cmp dword [dword ebp-0DAh], byte 0
        je short .34
        push dword [byte ebp+07Eh]
        call FreeMemBlock
        add esp, byte 4
.34:
        cmp dword [dword ebp-04B4Eh], byte 0
        jne near .37
        mov eax, edi
        shl eax, 4
        add eax, dword [byte ebp+072h]
        movsx ecx, byte [eax]
        imul ecx, byte 1Ch
        cmp byte [dword ecx+PlayoffUserActive], 1
        je short .35
        movsx eax, byte [byte eax+01h]
        imul eax, byte 1Ch
        cmp byte [dword eax+PlayoffUserActive], 1
        jne near .37
.35:
        mov eax, 1
        mov ebx, 4A78h
        call LinkReceiveData
        mov edx, dword [TransferBuffer]
        lea eax, [dword ebp-04B4Ah]
        add edx, dword [TransferOffset]
        call memcpy_
        add dword [TransferOffset], 4A78h
        cmp dword [dword ebp-0DAh], byte 0
        je short .36
        push byte 0
        push dword [dword ebp-0DAh]
        push str_Replaybuf
        call AllocMemBlock
        mov ecx, dword [dword ebp-0DAh]
        mov edx, dword [TransferBuffer]
        add esp, byte 0Ch
        mov ebx, ecx
        add edx, dword [TransferOffset]
        mov dword [byte ebp+07Eh], eax
        call memcpy_
        add dword [TransferOffset], ecx
.36:
        mov ebx, dword [dword ebp-0DAh]
        mov edx, dword [byte ebp+07Eh]
        lea eax, [dword ebp-04B4Ah]
        call AddReplayIndexEntry
        cmp dword [dword ebp-0DAh], byte 0
        je short .37
        push dword [byte ebp+07Eh]
        call FreeMemBlock
        add esp, byte 4
.37:
        inc edi
.38:
        movsx eax, word [byte ebp+054h]
        cmp edi, eax
        jl near .31
        jmp short .40
.39:
        mov eax, edi
        shl eax, 4
        add eax, dword [byte ebp+072h]
        mov dword [byte eax+08h], 0FFCh
.40:
        call HideWorkingBox
        push dword [TransferBuffer]
        call FreeMemBlock
        add esp, byte 4
        push dword [TransferPackBuffer]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+06Eh]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+066h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+072h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp+06Ah]
        call FreeMemBlock
        jmp near PickIndexEntryScreen_1080
;-----------------------------------------------------------------------------
; SendLeagueFile                                  A219A  97 PC, low confidence
; Sends a league file over the link
;-----------------------------------------------------------------------------
SendLeagueFile:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 564h, 0
        xor esi, esi
        push esi
        push dword 194Fh
        push str_Ros
        call AllocMemBlock
        add esp, byte 0Ch
        push esi
        push dword 194Fh
        push str_Lros
        mov dword [byte ebp-0Ch], esi
        mov dword [byte ebp-08h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp-014h], eax
        cmp dword [LinkGameActive], byte 0
        je near .69
        call ClearLinkAbort
        test eax, eax
        je short .1
        mov edx, 525h
        mov eax, SeasonName
        xor ebx, ebx
        call LinkSendBlock
        mov edx, 525h
        lea eax, [dword ebp-0564h]
        xor ebx, ebx
        call LinkReceiveBlock
        jmp short .2
.1:
        mov edx, 525h
        lea eax, [dword ebp-0564h]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 525h
        mov eax, SeasonName
        xor ebx, ebx
        call LinkSendBlock
.2:
        mov dword [byte ebp-04h], 0
.3:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 1Ah
        jl short .3
        mov dword [byte ebp-04h], 0
.4:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 1Ah
        jl short .4
        mov dword [byte ebp-04h], 0
.5:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 1Ah
        jl short .5
        mov dword [byte ebp-04h], 0
.6:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 1Ah
        jl short .6
        mov dword [byte ebp-04h], 0
        jmp near .12
.7:
        imul eax, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 0
        jne short .9
        cmp byte [dword eax+ebp-032Ch], 1
        jne short .9
        cmp byte [dword eax+ebp-032Dh], 0
        jne short .8
        mov esi, 2
        jmp short .9
.8:
        mov byte [dword eax+ebp-032Ch], 0
.9:
        imul eax, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword eax+ebp-032Ch], 0
        jne short .11
        cmp byte [dword eax+SeasonUserActive], 1
        jne short .11
        cmp byte [dword eax+SeasonUserHuman], 0
        jne short .10
        mov esi, 3
        jmp short .11
.10:
        mov byte [dword eax+SeasonUserActive], 0
.11:
        inc dword [byte ebp-04h]
.12:
        cmp dword [byte ebp-04h], byte 1Ah
        jge short .13
        test esi, esi
        je short .7
.13:
        cmp esi, byte 2
        jne short .15
        push byte 1
        mov eax, 1EDh
.14:
        mov edx, 1
        xor ecx, ecx
        xor ebx, ebx
        call GetLangText
        call ShowMessageBox
        mov eax, 1
        jmp near SendLeagueFile_6FD
.15:
        cmp esi, byte 3
        jne short .16
        push byte 1
        mov eax, 1ECh
        jmp short .14
.16:
        movsx eax, word [byte ebp-04Fh]
        cmp eax, byte 0FFFFFFFFh
        je short .17
        movsx eax, word [SeasonLastHome]
        cmp eax, byte 0FFFFFFFFh
        jne short .17
        mov eax, dword [byte ebp-04Fh]
        mov word [SeasonLastHome], ax
        mov eax, dword [byte ebp-04Dh]
        mov word [SeasonLastAway], ax
.17:
        call ClearLinkAbort
        test eax, eax
        je near .23
        xor eax, eax
        mov dword [byte ebp-04h], eax
.18:
        imul ecx, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword ecx+ebp-032Ch], 1
        jne short .19
        cmp byte [dword ecx+ebp-032Dh], 0
        jne short .19
        inc eax
.19:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 1Ah
        jl short .18
        test eax, eax
        jne short .20
        mov edx, 1
        mov eax, dword [SeasonUserTeam]
        mov dword [byte ebp-0Ch], 1
        call SendLeagueData
.20:
        xor eax, eax
        mov dword [byte ebp-04h], eax
.21:
        imul ecx, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword ecx+SeasonUserActive], 1
        jne short .22
        cmp byte [dword ecx+SeasonUserHuman], 0
        jne short .22
        inc eax
.22:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 1Ah
        jl short .21
        test eax, eax
        jne near .29
        mov eax, 1
        mov dword [byte ebp-0Ch], 1
        call ReceiveLeagueData
        jmp near .29
.23:
        mov dword [byte ebp-04h], eax
.24:
        imul ecx, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword ecx+SeasonUserActive], 1
        jne short .25
        cmp byte [dword ecx+SeasonUserHuman], 0
        jne short .25
        inc eax
.25:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 1Ah
        jl short .24
        test eax, eax
        jne short .26
        mov eax, 1
        mov dword [byte ebp-0Ch], 1
        call ReceiveLeagueData
.26:
        xor eax, eax
        mov dword [byte ebp-04h], eax
.27:
        imul ecx, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword ecx+ebp-032Ch], 1
        jne short .28
        cmp byte [dword ecx+ebp-032Dh], 0
        jne short .28
        inc eax
.28:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 1Ah
        jl short .27
        test eax, eax
        jne short .29
        mov edx, 1
        mov eax, dword [SeasonUserTeam]
        mov dword [byte ebp-0Ch], 1
        call SendLeagueData
.29:
        cmp dword [byte ebp-0Ch], byte 0
        jne near .65
        mov dword [byte ebp-010h], 0
.30:
        call AllocCrusherBuffers
        call ClearLinkAbort
        test eax, eax
        je short .31
        cmp dword [byte ebp-010h], byte 0
        je short .32
.31:
        call ClearLinkAbort
        test eax, eax
        jne near .48
        cmp dword [byte ebp-010h], byte 0
        je near .48
.32:
        mov dword [byte ebp-04h], 0
        jmp near .47
.33:
        imul eax, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        jne near .46
        cmp byte [dword eax+SeasonUserHuman], 0
        jne near .46
        mov eax, dword [byte ebp-04h]
        mov edx, dword [byte ecx+01Ch]
        shl eax, 3
        add eax, edx
        mov edx, dword [byte ebp-08h]
        call FindGameRecord
        mov edx, 194Fh
        mov eax, dword [byte ebp-08h]
        xor ecx, ecx
        call CopyToTransfer
        jmp short .36
.34:
        imul edx, ecx, byte 38h
        mov eax, dword [byte ebp-08h]
        cmp dword [dword edx+eax+0D31h], byte 0
        je short .35
        add eax, 0D09h
        add eax, edx
        lea edx, [byte ebp-03Ch]
        add eax, byte 28h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-03Ch]
        call CopyToTransfer
.35:
        inc ecx
.36:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+0D05h]
        cmp ecx, eax
        jl short .34
        xor ecx, ecx
        jmp short .39
.37:
        imul edx, ecx, byte 38h
        mov eax, dword [byte ebp-08h]
        cmp dword [dword edx+eax+012ABh], byte 0
        je short .38
        add eax, 1283h
        add eax, edx
        lea edx, [byte ebp-03Ch]
        add eax, byte 28h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-03Ch]
        call CopyToTransfer
.38:
        inc ecx
.39:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+01281h]
        cmp ecx, eax
        jl short .37
        xor ecx, ecx
        jmp short .42
.40:
        imul edx, ecx, byte 38h
        mov eax, dword [byte ebp-08h]
        cmp dword [dword edx+eax+01355h], byte 0
        je short .41
        add eax, 132Dh
        add eax, edx
        lea edx, [byte ebp-03Ch]
        add eax, byte 28h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-03Ch]
        call CopyToTransfer
.41:
        inc ecx
.42:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+0132Bh]
        cmp ecx, eax
        jl short .40
        xor ecx, ecx
        jmp short .45
.43:
        imul edx, ecx, byte 38h
        mov eax, dword [byte ebp-08h]
        cmp dword [dword edx+eax+018CFh], byte 0
        je short .44
        add eax, 18A7h
        add eax, edx
        lea edx, [byte ebp-03Ch]
        add eax, byte 28h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-03Ch]
        call CopyToTransfer
.44:
        inc ecx
.45:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+018A5h]
        cmp ecx, eax
        jl short .43
.46:
        inc dword [byte ebp-04h]
.47:
        mov ecx, dword [SeasonUserTeam]
        movsx eax, word [ecx]
        cmp eax, dword [byte ebp-04h]
        jg near .33
        xor eax, eax
        call LinkSendData
        jmp near .64
.48:
        xor eax, eax
        mov dword [byte ebp-04h], 0
        call LinkReceiveData
        jmp near .63
.49:
        imul eax, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword eax+ebp-032Ch], 1
        jne near .62
        cmp byte [dword eax+ebp-032Dh], 0
        jne near .62
        mov ebx, 194Fh
        mov edx, dword [TransferBuffer]
        mov eax, dword [byte ebp-08h]
        add edx, dword [TransferOffset]
        call memcpy_
        mov edx, dword [byte ebp-04h]
        add dword [TransferOffset], 194Fh
        mov eax, dword [SeasonUserTeam]
        shl edx, 3
        mov esi, dword [byte eax+01Ch]
        mov edi, dword [byte ebp-08h]
        add esi, edx
        movsd
        movsd
        mov eax, dword [SeasonUserTeam]
        mov ecx, 39h
        mov eax, dword [byte eax+01Ch]
        mov edi, dword [byte ebp-08h]
        add eax, edx
        mov edx, dword [byte ebp-014h]
        mov esi, dword [byte ebp-014h]
        call FindGameRecord
        lea edi, [byte edi+04Eh]
        lea esi, [byte esi+04Eh]
        mov eax, dword [byte ebp-08h]
        rep movsb
        call UpdateGameRecord
        xor ecx, ecx
        jmp short .52
.50:
        imul eax, ecx, byte 38h
        add eax, dword [byte ebp-08h]
        cmp dword [dword eax+0D31h], byte 0
        je short .51
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp-03Ch]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp-03Ch]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.51:
        inc ecx
.52:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+0D05h]
        cmp ecx, eax
        jl short .50
        xor ecx, ecx
        jmp short .55
.53:
        imul eax, ecx, byte 38h
        add eax, dword [byte ebp-08h]
        cmp dword [dword eax+012ABh], byte 0
        je short .54
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp-03Ch]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp-03Ch]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.54:
        inc ecx
.55:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+01281h]
        cmp ecx, eax
        jl short .53
        xor ecx, ecx
        jmp short .58
.56:
        imul eax, ecx, byte 38h
        add eax, dword [byte ebp-08h]
        cmp dword [dword eax+01355h], byte 0
        je short .57
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp-03Ch]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp-03Ch]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.57:
        inc ecx
.58:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+0132Bh]
        cmp ecx, eax
        jl short .56
        xor ecx, ecx
        jmp short .61
.59:
        imul eax, ecx, byte 38h
        add eax, dword [byte ebp-08h]
        cmp dword [dword eax+018CFh], byte 0
        je short .60
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp-03Ch]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp-03Ch]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.60:
        inc ecx
.61:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+018A5h]
        cmp ecx, eax
        jl short .59
.62:
        inc dword [byte ebp-04h]
.63:
        mov eax, dword [SeasonUserTeam]
        movsx eax, word [eax]
        cmp eax, dword [byte ebp-04h]
        jg near .49
.64:
        push dword [TransferBuffer]
        call FreeMemBlock
        add esp, byte 4
        push dword [TransferPackBuffer]
        inc dword [byte ebp-010h]
        call FreeMemBlock
        add esp, byte 4
        cmp dword [byte ebp-010h], byte 2
        jl near .30
.65:
        mov dword [byte ebp-04h], 0
.66:
        imul eax, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword eax+SeasonUserHuman], 0
        je short .67
        cmp byte [dword eax+SeasonUserActive], 1
        jne short .67
        mov byte [dword eax+SeasonUserHuman], 1
.67:
        imul eax, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword eax+ebp-032Dh], 0
        jne short .68
        cmp byte [dword eax+ebp-032Ch], 1
        jne short .68
        mov byte [dword eax+SeasonUserHuman], 2
.68:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 1Ah
        jl short .66
        cmp dword [byte ebp-0Ch], byte 0
        jne short .72
        call SendGameResult
        jmp short .72
.69:
        mov dword [byte ebp-04h], esi
.70:
        imul eax, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword eax+SeasonUserHuman], 2
        jne short .71
        cmp byte [dword eax+SeasonUserActive], 1
        jne short .71
        mov byte [dword eax+SeasonUserHuman], 1
.71:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 1Ah
        jl short .70
.72:
        push dword [byte ebp-08h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp-014h]
SendLeagueFile_6F3:
        call FreeMemBlock
        add esp, byte 4
        xor eax, eax
SendLeagueFile_6FD:
        leave
SendLeagueFile_6FE:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ReceiveLeagueFile                               A289E  97 PC, low confidence
; Receives a league file over the link
;-----------------------------------------------------------------------------
ReceiveLeagueFile:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 530h, 0
        xor esi, esi
        push esi
        push dword 194Fh
        push str_Ros
        call AllocMemBlock
        add esp, byte 0Ch
        push esi
        push dword 194Fh
        push str_Lros
        mov dword [byte ebp-08h], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp-010h], eax
        cmp dword [LinkGameActive], byte 0
        je near .63
        call ClearLinkAbort
        test eax, eax
        je short .1
        mov edx, 4F7h
        mov eax, PlayoffSettings
        xor ebx, ebx
        call LinkSendBlock
        mov edx, 4F7h
        lea eax, [dword ebp-0530h]
        xor ebx, ebx
        call LinkReceiveBlock
        jmp short .2
.1:
        mov edx, 4F7h
        lea eax, [dword ebp-0530h]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 4F7h
        mov eax, PlayoffSettings
        xor ebx, ebx
        call LinkSendBlock
.2:
        mov dword [byte ebp-04h], 0
        jmp near .8
.3:
        imul eax, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword eax+PlayoffUserActive], 0
        jne short .5
        cmp byte [dword eax+ebp-0328h], 1
        jne short .5
        cmp byte [dword eax+ebp-0329h], 0
        jne short .4
        mov esi, 2
        jmp short .5
.4:
        mov byte [dword eax+ebp-0328h], 0
.5:
        imul eax, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword eax+ebp-0328h], 0
        jne short .7
        cmp byte [dword eax+PlayoffUserActive], 1
        jne short .7
        cmp byte [dword eax+PlayoffUserHuman], 0
        jne short .6
        mov esi, 3
        jmp short .7
.6:
        mov byte [dword eax+PlayoffUserActive], 0
.7:
        inc dword [byte ebp-04h]
.8:
        cmp dword [byte ebp-04h], byte 10h
        jge short .9
        test esi, esi
        je short .3
.9:
        cmp esi, byte 2
        jne short .11
        push byte 1
        mov eax, 1EDh
.10:
        mov edx, 1
        xor ecx, ecx
        xor ebx, ebx
        call GetLangText
        call ShowMessageBox
        mov eax, 1
        jmp near SendLeagueFile_6FD
.11:
        cmp esi, byte 3
        jne short .12
        push byte 1
        mov eax, 1ECh
        jmp short .10
.12:
        call ClearLinkAbort
        test eax, eax
        je near .18
        xor eax, eax
        mov dword [byte ebp-04h], eax
.13:
        imul ecx, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword ecx+ebp-0328h], 1
        jne short .14
        cmp byte [dword ecx+ebp-0329h], 0
        jne short .14
        inc eax
.14:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 10h
        jl short .13
        test eax, eax
        jne short .15
        mov eax, dword [SeasonUserTeam]
        xor edx, edx
        call SendLeagueData
.15:
        xor eax, eax
        mov dword [byte ebp-04h], eax
.16:
        imul ecx, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword ecx+PlayoffUserActive], 1
        jne short .17
        cmp byte [dword ecx+PlayoffUserHuman], 0
        jne short .17
        inc eax
.17:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 10h
        jl short .16
        test eax, eax
        jne near .24
        call ReceiveLeagueData
        jmp near .24
.18:
        mov dword [byte ebp-04h], eax
.19:
        imul ecx, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword ecx+PlayoffUserActive], 1
        jne short .20
        cmp byte [dword ecx+PlayoffUserHuman], 0
        jne short .20
        inc eax
.20:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 10h
        jl short .19
        test eax, eax
        jne short .21
        call ReceiveLeagueData
.21:
        xor eax, eax
        mov dword [byte ebp-04h], eax
.22:
        imul ecx, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword ecx+ebp-0328h], 1
        jne short .23
        cmp byte [dword ecx+ebp-0329h], 0
        jne short .23
        inc eax
.23:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 10h
        jl short .22
        test eax, eax
        jne short .24
        mov eax, dword [SeasonUserTeam]
        xor edx, edx
        call SendLeagueData
.24:
        mov dword [byte ebp-0Ch], 0
.25:
        call AllocCrusherBuffers
        call ClearLinkAbort
        test eax, eax
        je short .26
        cmp dword [byte ebp-0Ch], byte 0
        je short .27
.26:
        call ClearLinkAbort
        test eax, eax
        jne near .43
        cmp dword [byte ebp-0Ch], byte 0
        je near .43
.27:
        mov dword [byte ebp-04h], 0
        jmp near .42
.28:
        imul eax, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword eax+PlayoffUserActive], 1
        jne near .41
        cmp byte [dword eax+PlayoffUserHuman], 0
        jne near .41
        mov edx, dword [byte ebp-04h]
        mov eax, dword [byte ecx+01Ch]
        shl edx, 3
        add eax, edx
        mov edx, dword [byte ebp-08h]
        call FindGameRecord
        mov edx, 194Fh
        mov eax, dword [byte ebp-08h]
        xor ecx, ecx
        call CopyToTransfer
        jmp short .31
.29:
        imul edx, ecx, byte 38h
        mov eax, dword [byte ebp-08h]
        cmp dword [dword edx+eax+0D31h], byte 0
        je short .30
        add eax, 0D09h
        add eax, edx
        lea edx, [byte ebp-038h]
        add eax, byte 28h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-038h]
        call CopyToTransfer
.30:
        inc ecx
.31:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+0D05h]
        cmp ecx, eax
        jl short .29
        xor ecx, ecx
        jmp short .34
.32:
        imul edx, ecx, byte 38h
        mov eax, dword [byte ebp-08h]
        cmp dword [dword edx+eax+012ABh], byte 0
        je short .33
        add eax, 1283h
        add eax, edx
        lea edx, [byte ebp-038h]
        add eax, byte 28h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-038h]
        call CopyToTransfer
.33:
        inc ecx
.34:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+01281h]
        cmp ecx, eax
        jl short .32
        xor ecx, ecx
        jmp short .37
.35:
        imul edx, ecx, byte 38h
        mov eax, dword [byte ebp-08h]
        cmp dword [dword edx+eax+01355h], byte 0
        je short .36
        add eax, 132Dh
        add eax, edx
        lea edx, [byte ebp-038h]
        add eax, byte 28h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-038h]
        call CopyToTransfer
.36:
        inc ecx
.37:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+0132Bh]
        cmp ecx, eax
        jl short .35
        xor ecx, ecx
        jmp short .40
.38:
        imul edx, ecx, byte 38h
        mov eax, dword [byte ebp-08h]
        cmp dword [dword edx+eax+018CFh], byte 0
        je short .39
        add eax, 18A7h
        add eax, edx
        lea edx, [byte ebp-038h]
        add eax, byte 28h
        call FindPlayerStat
        mov edx, 27h
        lea eax, [byte ebp-038h]
        call CopyToTransfer
.39:
        inc ecx
.40:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+018A5h]
        cmp ecx, eax
        jl short .38
.41:
        inc dword [byte ebp-04h]
.42:
        mov ecx, dword [SeasonUserTeam]
        movsx eax, word [ecx]
        cmp eax, dword [byte ebp-04h]
        jg near .28
        xor eax, eax
        call LinkSendData
        jmp near .59
.43:
        xor eax, eax
        mov dword [byte ebp-04h], 0
        call LinkReceiveData
        jmp near .58
.44:
        imul eax, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword eax+ebp-0328h], 1
        jne near .57
        cmp byte [dword eax+ebp-0329h], 0
        jne near .57
        mov ebx, 194Fh
        mov edx, dword [TransferBuffer]
        mov eax, dword [byte ebp-08h]
        add edx, dword [TransferOffset]
        call memcpy_
        mov edx, dword [byte ebp-04h]
        add dword [TransferOffset], 194Fh
        mov eax, dword [SeasonUserTeam]
        shl edx, 3
        mov esi, dword [byte eax+01Ch]
        mov edi, dword [byte ebp-08h]
        add esi, edx
        movsd
        movsd
        mov eax, dword [SeasonUserTeam]
        mov ecx, 39h
        mov eax, dword [byte eax+01Ch]
        mov edi, dword [byte ebp-08h]
        add eax, edx
        mov edx, dword [byte ebp-010h]
        mov esi, dword [byte ebp-010h]
        call FindGameRecord
        lea edi, [byte edi+04Eh]
        lea esi, [byte esi+04Eh]
        mov eax, dword [byte ebp-08h]
        rep movsb
        call UpdateGameRecord
        xor ecx, ecx
        jmp short .47
.45:
        imul eax, ecx, byte 38h
        add eax, dword [byte ebp-08h]
        cmp dword [dword eax+0D31h], byte 0
        je short .46
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp-038h]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp-038h]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.46:
        inc ecx
.47:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+0D05h]
        cmp ecx, eax
        jl short .45
        xor ecx, ecx
        jmp short .50
.48:
        imul eax, ecx, byte 38h
        add eax, dword [byte ebp-08h]
        cmp dword [dword eax+012ABh], byte 0
        je short .49
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp-038h]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp-038h]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.49:
        inc ecx
.50:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+01281h]
        cmp ecx, eax
        jl short .48
        xor ecx, ecx
        jmp short .53
.51:
        imul eax, ecx, byte 38h
        add eax, dword [byte ebp-08h]
        cmp dword [dword eax+01355h], byte 0
        je short .52
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp-038h]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp-038h]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.52:
        inc ecx
.53:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+0132Bh]
        cmp ecx, eax
        jl short .51
        xor ecx, ecx
        jmp short .56
.54:
        imul eax, ecx, byte 38h
        add eax, dword [byte ebp-08h]
        cmp dword [dword eax+018CFh], byte 0
        je short .55
        mov ebx, 27h
        mov edx, dword [TransferBuffer]
        lea eax, [byte ebp-038h]
        add edx, dword [TransferOffset]
        call memcpy_
        lea eax, [byte ebp-038h]
        add dword [TransferOffset], byte 27h
        call UpdatePlayerStat
.55:
        inc ecx
.56:
        mov eax, dword [byte ebp-08h]
        movsx eax, word [dword eax+018A5h]
        cmp ecx, eax
        jl short .54
.57:
        inc dword [byte ebp-04h]
.58:
        mov eax, dword [SeasonUserTeam]
        movsx eax, word [eax]
        cmp eax, dword [byte ebp-04h]
        jg near .44
.59:
        push dword [TransferBuffer]
        call FreeMemBlock
        add esp, byte 4
        push dword [TransferPackBuffer]
        inc dword [byte ebp-0Ch]
        call FreeMemBlock
        add esp, byte 4
        cmp dword [byte ebp-0Ch], byte 2
        jl near .25
        mov dword [byte ebp-04h], 0
.60:
        imul eax, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword eax+PlayoffUserHuman], 0
        je short .61
        cmp byte [dword eax+PlayoffUserActive], 1
        jne short .61
        mov byte [dword eax+PlayoffUserHuman], 1
.61:
        imul eax, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword eax+ebp-0329h], 0
        jne short .62
        cmp byte [dword eax+ebp-0328h], 1
        jne short .62
        mov byte [dword eax+PlayoffUserHuman], 2
.62:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 10h
        jl short .60
        call SendGameResult
        jmp short .66
.63:
        mov dword [byte ebp-04h], esi
.64:
        imul eax, dword [byte ebp-04h], byte 1Ch
        cmp byte [dword eax+PlayoffUserHuman], 2
        jne short .65
        cmp byte [dword eax+PlayoffUserActive], 1
        jne short .65
        mov byte [dword eax+PlayoffUserHuman], 1
.65:
        inc dword [byte ebp-04h]
        cmp dword [byte ebp-04h], byte 10h
        jl short .64
.66:
        push dword [byte ebp-08h]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebp-010h]
        jmp near SendLeagueFile_6F3
;-----------------------------------------------------------------------------
; AllocCrusherBuffers                             A2EF0  97 PC, low confidence
; Allocates the "CRUSHER" (493E0h) and "CRUSHER pack" (186A0h) buffers used
; to pack data sent to the other computer
;-----------------------------------------------------------------------------
AllocCrusherBuffers:
        push ecx
        push edx
        push byte 0
        push dword 493E0h
        push str_CRUSHER
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push dword 186A0h
        push str_CRUSHERPack
        mov dword [TransferBuffer], eax
        call AllocMemBlock
        mov dword [TransferOffset], 0
        add esp, byte 0Ch
        mov dword [TransferPackBuffer], eax
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; FreeTransferBuffers                             A2F31  97 PC, low confidence
; Frees the link transfer buffers
;-----------------------------------------------------------------------------
FreeTransferBuffers:
        push ecx
        push edx
        push dword [TransferBuffer]
        call FreeMemBlock
        add esp, byte 4
        push dword [TransferPackBuffer]
        call FreeMemBlock
        add esp, byte 4
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; CopyToTransfer                                  A2F52  97 PC, low confidence
; Copies data into the link transfer buffer
;-----------------------------------------------------------------------------
CopyToTransfer:
        push ebx
        push ecx
        push esi
        mov ecx, edx
        mov esi, dword [TransferBuffer]
        mov ebx, edx
        add esi, dword [TransferOffset]
        mov edx, eax
        mov eax, esi
        call memcpy_
        add dword [TransferOffset], ecx
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LinkSendData                                    A2F78  97 PC, low confidence
; Link games: "Please wait... / Transferring data...", sends a block to the
; other computer (LinkSendBlock)
;-----------------------------------------------------------------------------
LinkSendData:
        push ebx
        push ecx
        push edx
        push esi
        enter 14h, 0
        mov esi, eax
        mov eax, 236h
        call GetLangText
        call ShowLinkMessage
        xor ecx, ecx
        mov ebx, dword [TransferPackBuffer]
        mov edx, dword [TransferOffset]
        mov eax, dword [TransferBuffer]
        call LinkSendFile
        mov ecx, eax
        call HideLinkBox
        push ecx
        push str_D_LinkSendData
        lea eax, [byte ebp-014h]
        push eax
        mov edx, 0Ah
        call sprintf_
        add esp, byte 0Ch
        xor ebx, ebx
        lea eax, [byte ebp-014h]
        call LinkSendBlock
        test esi, esi
        je short .1
        mov eax, dword [TransferPackBuffer]
        mov edx, ecx
        xor ebx, ebx
        call LinkSendBlock
        jmp short LinkSendData_BB.3
.1:
        cmp ecx, 1F4h
        jle short .2
        mov eax, 227h
        mov ebx, UpdateWorkingBox
        mov edx, ecx
        call GetLangText
        call ShowWorkingBox
        mov eax, dword [TransferPackBuffer]
        mov edx, ecx
        call LinkSendBlock
        call HideWorkingBox
        jmp short LinkSendData_BB.3
.2:
        mov eax, 227h
        call GetLangText
        call ShowLinkMessage
        mov edx, ecx
        xor ebx, ebx
        mov eax, dword [TransferPackBuffer]
        call LinkSendBlock
LinkSendData_BB:
        call HideLinkBox
.3:
        mov dword [TransferOffset], 0
        leave
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LinkReceiveData                                 A3048  97 PC, low confidence
; Link games: "Please wait... / Transferring data...", receives a block from
; the other computer (LinkReceiveBlock, atoi of its size)
;-----------------------------------------------------------------------------
LinkReceiveData:
        push ebx
        push ecx
        push edx
        push esi
        enter 20h, 0
        mov esi, eax
        test eax, eax
        jne short .1
        mov eax, 236h
        call GetLangText
        call ShowLinkMessage
.1:
        mov edx, 0Ah
        lea eax, [byte ebp-020h]
        xor ebx, ebx
        call LinkReceiveBlock
        test esi, esi
        jne short .2
        call HideLinkBox
.2:
        lea eax, [byte ebp-020h]
        call atoi_
        mov ecx, eax
        test esi, esi
        je short .3
        mov eax, dword [TransferPackBuffer]
        mov edx, ecx
        xor ebx, ebx
        call LinkReceiveBlock
        jmp short .5
.3:
        cmp eax, 1F4h
        jge short .4
        mov eax, 227h
        call GetLangText
        call ShowLinkMessage
        mov edx, ecx
        xor ebx, ebx
        mov eax, dword [TransferPackBuffer]
        call LinkReceiveBlock
        call HideLinkBox
        jmp short .5
.4:
        mov eax, 227h
        mov ebx, UpdateWorkingBox
        mov edx, ecx
        call GetLangText
        call ShowWorkingBox
        mov eax, dword [TransferPackBuffer]
        mov edx, ecx
        call LinkReceiveBlock
        call HideWorkingBox
.5:
        mov eax, 236h
        mov edx, LinkMessageText
        call GetLangText
        call ShowLinkMessage
        mov ebx, dword [TransferBuffer]
        mov eax, dword [TransferPackBuffer]
        call LinkReceiveChunk
        jmp near LinkSendData_BB
;-----------------------------------------------------------------------------
; AppendToTransfer                                A3116  97 PC, low confidence
; Appends data to the link transfer buffer
;-----------------------------------------------------------------------------
AppendToTransfer:
        push ebx
        push ecx
        mov ecx, edx
        mov edx, dword [TransferBuffer]
        mov ebx, ecx
        add edx, dword [TransferOffset]
        call memcpy_
        add dword [TransferOffset], ecx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawLinkStatusText                              A3136  97 PC, low confidence
; Draws the link status text
;-----------------------------------------------------------------------------
DrawLinkStatusText:
        push esi
        push edi
        enter 4, 0
        mov edi, eax
        mov esi, edx
        mov dword [byte ebp-04h], ecx
        push byte 0
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        call SetTextColors
        add esp, byte 8
        push ebx
        lea eax, [byte esi-01h]
        push eax
        push edi
        call DrawTextAt
        add esp, byte 0Ch
        push ebx
        lea eax, [byte esi+01h]
        push eax
        push edi
        call DrawTextAt
        add esp, byte 0Ch
        lea eax, [byte ebx-01h]
        push eax
        push esi
        push edi
        call DrawTextAt
        add esp, byte 0Ch
        lea eax, [byte ebx+01h]
        push eax
        push esi
        push edi
        call DrawTextAt
        add esp, byte 0Ch
        cmp dword [byte ebp-04h], byte 0
        je short .1
        push byte 0
        push dword 0FFFFFF50h
        jmp short .2
.1:
        push byte 0
        push byte 0FFFFFFFFh
.2:
        call MakeColor
        add esp, byte 4
        push eax
        call SetTextColors
        add esp, byte 8
        push ebx
        push esi
        push edi
        call DrawTextAt
        add esp, byte 0Ch
        leave
        pop edi
        pop esi
        ret
ResetLinkSetupJumpTable:                        ; jump table for the switch cases of ResetLinkSetup
        dd ResetLinkSetup_20
        dd ResetLinkSetup_45
        dd ResetLinkSetup_50
        dd ResetLinkSetup_57
        dd ResetLinkSetup_57
        dd ResetLinkSetup_5E
;-----------------------------------------------------------------------------
; ResetLinkSetup                                  A31DE  97 PC, low confidence
; Resets the link setup
;-----------------------------------------------------------------------------
ResetLinkSetup:
        push ebx
        push ecx
        push esi
        enter 4, 0
        mov ecx, eax
        mov al, dl
        and al, 7
        cmp al, 5
        ja near ResetLinkSetup_5E.5
        movzx eax, al
        jmp dword [nosplit cs:eax*4+ResetLinkSetupJumpTable]
ResetLinkSetup_20:
        cmp dword [LinkGameActive], byte 0
        je short ResetLinkSetup_45.2
        call ClearLinkAbort
        test eax, eax
        je short .1
        cmp ecx, byte 3
        jg short ResetLinkSetup_45
.1:
        call ClearLinkAbort
        test eax, eax
        jne short ResetLinkSetup_45.2
        cmp ecx, byte 4
        jge short ResetLinkSetup_45.2
ResetLinkSetup_45:
        mov ebx, 1
        jmp short ResetLinkSetup_5E.5
.2:
        xor ebx, ebx
        jmp short ResetLinkSetup_5E.5
ResetLinkSetup_50:
        mov ebx, 2
        jmp short ResetLinkSetup_5E.5
ResetLinkSetup_57:
        mov ebx, 3
        jmp short ResetLinkSetup_5E.5
ResetLinkSetup_5E:
        mov ebx, 4
        xor eax, eax
.3:
        mov dh, dl
        movsx esi, word [nosplit eax*2+LinkSetupValues]
        and dh, 78h
        mov dword [byte ebp-04h], esi
        movzx esi, dh
        sar esi, 3
        cmp esi, dword [byte ebp-04h]
        je short .4
        inc eax
        jmp short .3
.4:
        add ebx, eax
.5:
        movsx eax, word [LinkSetupItemCount]
        imul eax, ecx
        add eax, ebx
        mov ebx, dword [LinkSetupBuffer]
        mov eax, dword [ebx+eax*4]
        mov eax, dword [byte eax+02Ch]
        leave
        pop esi
        pop ecx
        pop ebx
        ret
