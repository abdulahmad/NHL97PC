; Season files: settings path, year and title, replays, link transfer set-up, agents, trades, playoff format.
bits 32
%include "hockey.inc"
section s_925BE progbits alloc exec nowrite align=1
extern AddPlayerStatAt, AddTradeRecord, AllocClearBlock, AllocCrusherBuffers, AllocImportBuffer, AllocMemBlock, AppendToTransfer, BlitArt
extern ClearLinkAbort, CopyToTransfer, CreateBitmap, CreateSeason_561, CreateSeason_562, DaysToYear, DbKeyBuffer, DrawTextAligned
extern ExhibitionData, FindPlayerRecord, FindPlayerStat, FindReplayIndexEntry, FreeBitmap, FreeMemBlock, FreeTransferBuffers, GetLangText
extern ImportNewPlayers, ImportTradedPlayers, KeysEqual, LinkGameActive, LinkReceiveBlock, LinkReceiveData, LinkSendBlock, LinkSendData
extern LoadExhibitionFile, MakeColor, MakeDirPath, memcpy_, PlayoffFormat, PlayoffFormatTeams, PlayoffTeamCount, PresentScreen
extern SaveDataFileNew, SaveExhibitionFile, SeasonDefaultUser, SeasonFileName, SeasonName, SeasonSlot, SeasonUserActive, SeasonUserHuman
extern SeasonUserLocked, SeasonUserTeam, SetDrawTarget, SetScreenTarget, SetTextColor, ShowLinkMessage, sprintf_, str_Agents
extern str_FakeAGENTS, str_FakeEXHIBIT, str_Importagents, str_SSEASDSET
global SeasonSettingsPath, SeasonYearText, DrawSeasonTitle, FindSeasonReplay, LinkTransferSetup, LoadFakeExhibition, SaveAgents, SaveAgentsOnly
global SaveTradesLink, SetPlayoffFormat
;-----------------------------------------------------------------------------
; SeasonSettingsPath                              925BE  97 PC, low confidence
; (n, buf): the season settings file name "%sSEAS%d.SET"
;-----------------------------------------------------------------------------
SeasonSettingsPath:
        push ebx
        push ecx
        push edx
        enter 78h, 0
        mov edx, 1
        lea eax, [byte ebp-028h]
        xor ebx, ebx
        call MakeDirPath
        push dword [SeasonSlot]
        lea eax, [byte ebp-028h]
        push eax
        push str_SSEASDSET
        lea eax, [byte ebp-078h]
        push eax
        call sprintf_
        add esp, byte 10h
        push dword 525h
        push SeasonName
        lea eax, [byte ebp-078h]
        push eax
        call SaveDataFileNew
        add esp, byte 0Ch
        leave
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SeasonYearText                                  9260A  97 PC, low confidence
; Formats the season year
;-----------------------------------------------------------------------------
SeasonYearText:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        xor ecx, ecx
        xor edx, edx
.1:
        imul eax, ecx, byte 1Ch
        cmp byte [dword eax+SeasonUserActive], 1
        jne short .2
        cmp byte [dword eax+SeasonUserHuman], 1
        jne short .2
        mov edx, 1
.2:
        inc ecx
        cmp ecx, byte 1Ah
        jl short .1
        xor ecx, ecx
.3:
        imul eax, ecx, byte 1Ch
        test edx, edx
        sete bl
        inc ecx
        mov byte [dword eax+SeasonUserLocked], bl
        cmp ecx, byte 1Ah
        jl short .3
        xor ecx, ecx
        jmp short .6
.4:
        mov ebx, 14h
        mov edx, 3
        mov edi, ecx
        mov esi, dword [byte eax+020h]
        mov eax, 7CCh
        shl edi, 4
        call DaysToYear
        cmp ax, word [byte edi+esi+04h]
        jae short .5
        mov eax, dword [SeasonUserTeam]
        mov edx, dword [byte eax+020h]
        add edx, edi
        movsx esi, byte [byte edx+02h]
        cmp esi, byte 0FFFFFFFFh
        je short .5
        movsx edx, byte [edx]
        imul edx, byte 1Ch
        mov byte [dword edx+SeasonUserLocked], 0
        mov eax, dword [byte eax+020h]
        movsx eax, byte [byte edi+eax+01h]
        imul eax, byte 1Ch
        mov byte [dword eax+SeasonUserLocked], 0
.5:
        inc ecx
.6:
        mov eax, dword [SeasonUserTeam]
        movsx edx, word [byte eax+02h]
        cmp ecx, edx
        jl short .4
        xor ecx, ecx
.7:
        inc ecx
        cmp ecx, byte 1Ah
        jl short .7
        jmp near CreateSeason_562
;-----------------------------------------------------------------------------
; DrawSeasonTitle                                 926BD  97 PC, low confidence
; Draws the season title
;-----------------------------------------------------------------------------
DrawSeasonTitle:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        push byte 20h
        push byte 14h
        push dword 12Ch
        call CreateBitmap
        add esp, byte 0Ch
        push eax
        mov esi, eax
        call SetDrawTarget
        movsx eax, word [byte ebx+0Eh]
        add esp, byte 4
        sub eax, 17Ch
        push eax
        push dword 0FFFFFEFCh
        push ebx
        call BlitArt
        imul eax, dword [SeasonDefaultUser], byte 1Ch
        add esp, byte 0Ch
        cmp byte [dword eax+SeasonUserHuman], 0
        jne short .1
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 246h
        jmp short .3
.1:
        cmp byte [dword eax+SeasonUserHuman], 1
        jne short .2
        push dword 0FFAAAAAAh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 245h
        jmp short .3
.2:
        push dword 0FF00AAAAh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 247h
.3:
        call GetLangText
        push eax
        push byte 0
        push dword 96h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        call SetScreenTarget
        push dword 17Ch
        push dword 104h
        push dword [byte esi+02Ch]
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        push esi
        call FreeBitmap
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FindSeasonReplay                                9279A  97 PC, low confidence
; Finds a saved replay of the season
;-----------------------------------------------------------------------------
FindSeasonReplay:
        push ebx
        push ecx
        push edx
        push esi
        mov ecx, eax
        xor ebx, ebx
        jmp short .4
.1:
        mov esi, ebx
        mov eax, dword [byte eax+020h]
        shl esi, 4
        add eax, esi
        movsx esi, byte [byte eax+02h]
        cmp esi, byte 0FFFFFFFFh
        jne short .3
        movsx esi, byte [eax]
        cmp esi, ecx
        je short .2
        movsx eax, byte [byte eax+01h]
        cmp eax, ecx
        jne short .3
.2:
        mov esi, ebx
        mov eax, dword [SeasonUserTeam]
        shl esi, 4
        mov eax, dword [byte eax+020h]
        add eax, esi
        mov edx, DbKeyBuffer
        add eax, byte 8
        call KeysEqual
        test eax, eax
        jne short .3
        mov eax, dword [SeasonUserTeam]
        mov eax, dword [byte eax+020h]
        add eax, esi
        mov edx, SeasonFileName
        add eax, byte 8
        call FindReplayIndexEntry
        mov eax, 1
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        inc ebx
.4:
        mov eax, dword [SeasonUserTeam]
        movsx esi, word [byte eax+02h]
        cmp ebx, esi
        jl short .1
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LinkTransferSetup                               9281C  97 PC, low confidence
; Link games: from RunNewSeason, RunNewPlayoffs and TeamSelectScreen, swaps
; the set-up data with the other computer ("Transferring data...")
;-----------------------------------------------------------------------------
LinkTransferSetup:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 110h, 0
        sub ebp, 92h
        mov esi, eax
        cmp dword [LinkGameActive], byte 0
        je near .34
        mov eax, 227h
        call GetLangText
        call ShowLinkMessage
        call ClearLinkAbort
        test eax, eax
        je near .4
        call AllocCrusherBuffers
        mov dword [byte ebp+07Ah], 0
.1:
        imul eax, dword [byte ebp+07Ah], dword 194Fh
        lea edx, [dword esi+0DF4h]
        add eax, edx
        mov edx, 194Fh
        call CopyToTransfer
        inc dword [byte ebp+07Ah]
        cmp dword [byte ebp+07Ah], byte 1Ah
        jl short .1
        mov edx, 4
        mov eax, esi
        call CopyToTransfer
        cmp word [esi], byte 0
        je short .2
        movsx edx, word [esi]
        imul edx, byte 38h
        mov eax, dword [dword esi+0383C1h]
        call CopyToTransfer
.2:
        mov eax, 1
        mov edx, 4
        call LinkSendData
        call FreeTransferBuffers
        xor ebx, ebx
        lea eax, [byte ebp+07Ah]
        call LinkReceiveBlock
        cmp dword [byte ebp+07Ah], byte 0
        je near .34
.3:
        cmp dword [byte ebp+07Ah], byte 0
        jle near .34
        mov edx, 8
        lea eax, [byte ebp+06Eh]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 8
        lea eax, [byte ebp+066h]
        xor ebx, ebx
        call LinkReceiveBlock
        lea edx, [byte ebp-07Eh]
        lea eax, [byte ebp+06Eh]
        call FindPlayerRecord
        lea edx, [byte ebp+03Eh]
        lea eax, [byte ebp+066h]
        xor ebx, ebx
        call FindPlayerStat
        mov edx, 0BCh
        lea eax, [byte ebp-07Eh]
        call LinkSendBlock
        mov edx, 27h
        lea eax, [byte ebp+03Eh]
        xor ebx, ebx
        call LinkSendBlock
        dec dword [byte ebp+07Ah]
        jmp short .3
.4:
        call AllocCrusherBuffers
        mov eax, 1
        call LinkReceiveData
        mov dword [byte ebp+07Ah], 0
.5:
        imul edx, dword [byte ebp+07Ah], dword 194Fh
        lea eax, [dword esi+0DF4h]
        add eax, edx
        mov edx, 194Fh
        call AppendToTransfer
        inc dword [byte ebp+07Ah]
        cmp dword [byte ebp+07Ah], byte 1Ah
        jl short .5
        cmp word [esi], byte 0
        je short .6
        push dword [dword esi+0383C1h]
        call FreeMemBlock
        add esp, byte 4
.6:
        mov edx, 4
        mov eax, esi
        call AppendToTransfer
        cmp word [esi], byte 0
        je short .7
        movsx eax, word [esi]
        imul eax, byte 38h
        push byte 0
        push eax
        push str_Importagents
        call AllocMemBlock
        movsx edx, word [esi]
        imul edx, byte 38h
        add esp, byte 0Ch
        mov dword [dword esi+0383C1h], eax
        call AppendToTransfer
.7:
        call FreeTransferBuffers
        mov dword [byte ebp+076h], 0
        mov dword [byte ebp+07Ah], 0
.8:
        imul eax, dword [byte ebp+07Ah], dword 194Fh
        lea edx, [dword esi+0DF4h]
        add eax, edx
        xor edi, edi
        lea ecx, [dword eax+0D09h]
        jmp short .11
.9:
        cmp dword [byte ecx+018h], byte 0
        je short .10
        lea edx, [byte ebp-07Eh]
        lea eax, [byte ecx+018h]
        call FindPlayerRecord
        test eax, eax
        jne short .10
        inc dword [byte ebp+076h]
.10:
        add ecx, byte 38h
        inc edi
.11:
        imul edx, dword [byte ebp+07Ah], dword 194Fh
        movsx eax, word [dword edx+esi+01AF9h]
        cmp edi, eax
        jl short .9
        lea eax, [dword esi+0DF4h]
        add edx, eax
        xor edi, edi
        lea ecx, [dword edx+0132Dh]
        jmp short .14
.12:
        cmp dword [byte ecx+018h], byte 0
        je short .13
        lea edx, [byte ebp-07Eh]
        lea eax, [byte ecx+018h]
        call FindPlayerRecord
        test eax, eax
        jne short .13
        inc dword [byte ebp+076h]
.13:
        add ecx, byte 38h
        inc edi
.14:
        imul edx, dword [byte ebp+07Ah], dword 194Fh
        movsx eax, word [dword edx+esi+0211Fh]
        cmp edi, eax
        jl short .12
        lea eax, [dword esi+0DF4h]
        add eax, edx
        xor edi, edi
        lea ecx, [dword eax+01283h]
        jmp short .17
.15:
        cmp dword [byte ecx+018h], byte 0
        je short .16
        lea edx, [byte ebp-07Eh]
        lea eax, [byte ecx+018h]
        call FindPlayerRecord
        test eax, eax
        jne short .16
        inc dword [byte ebp+076h]
.16:
        add ecx, byte 38h
        inc edi
.17:
        imul edx, dword [byte ebp+07Ah], dword 194Fh
        movsx eax, word [dword edx+esi+02075h]
        cmp edi, eax
        jl short .15
        lea eax, [dword esi+0DF4h]
        add eax, edx
        xor edi, edi
        lea ecx, [dword eax+018A7h]
        jmp short .20
.18:
        cmp dword [byte ecx+018h], byte 0
        je short .19
        lea edx, [byte ebp-07Eh]
        lea eax, [byte ecx+018h]
        call FindPlayerRecord
        test eax, eax
        jne short .19
        inc dword [byte ebp+076h]
.19:
        add ecx, byte 38h
        inc edi
.20:
        imul eax, dword [byte ebp+07Ah], dword 194Fh
        movsx eax, word [dword esi+eax+02699h]
        cmp edi, eax
        jl short .18
        inc dword [byte ebp+07Ah]
        cmp dword [byte ebp+07Ah], byte 1Ah
        jl near .8
        mov edx, 4
        lea eax, [byte ebp+076h]
        xor ebx, ebx
        call LinkSendBlock
        cmp dword [byte ebp+076h], byte 0
        je near .34
        mov dword [byte ebp+07Ah], 0
.21:
        imul eax, dword [byte ebp+07Ah], dword 194Fh
        lea edx, [dword esi+0DF4h]
        add eax, edx
        xor edi, edi
        lea ecx, [dword eax+0D09h]
        jmp near .24
.22:
        cmp dword [byte ecx+018h], byte 0
        je short .23
        lea eax, [byte ecx+018h]
        lea edx, [byte ebp-07Eh]
        mov dword [dword ebp+086h], eax
        call FindPlayerRecord
        test eax, eax
        jne short .23
        mov edx, 8
        mov eax, dword [dword ebp+086h]
        xor ebx, ebx
        call LinkSendBlock
        mov edx, 8
        lea eax, [byte ecx+028h]
        xor ebx, ebx
        mov dword [byte ebp+07Eh], eax
        call LinkSendBlock
        mov edx, 0BCh
        lea eax, [byte ebp-07Eh]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 27h
        lea eax, [byte ebp+03Eh]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, dword [dword ebp+086h]
        lea eax, [byte ebp-07Eh]
        call AddTradeRecord
        mov edx, dword [byte ebp+07Eh]
        lea eax, [byte ebp+03Eh]
        call AddPlayerStatAt
.23:
        add ecx, byte 38h
        inc edi
.24:
        imul edx, dword [byte ebp+07Ah], dword 194Fh
        movsx eax, word [dword edx+esi+01AF9h]
        cmp edi, eax
        jl near .22
        lea eax, [dword esi+0DF4h]
        add edx, eax
        xor edi, edi
        lea ecx, [dword edx+0132Dh]
        jmp near .27
.25:
        cmp dword [byte ecx+018h], byte 0
        je short .26
        lea eax, [byte ecx+018h]
        lea edx, [byte ebp-07Eh]
        mov dword [dword ebp+082h], eax
        call FindPlayerRecord
        test eax, eax
        jne short .26
        mov edx, 8
        mov eax, dword [dword ebp+082h]
        xor ebx, ebx
        call LinkSendBlock
        mov edx, 8
        lea eax, [byte ecx+028h]
        xor ebx, ebx
        mov dword [byte ebp+07Eh], eax
        call LinkSendBlock
        mov edx, 0BCh
        lea eax, [byte ebp-07Eh]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 27h
        lea eax, [byte ebp+03Eh]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, dword [dword ebp+082h]
        lea eax, [byte ebp-07Eh]
        call AddTradeRecord
        mov edx, dword [byte ebp+07Eh]
        lea eax, [byte ebp+03Eh]
        call AddPlayerStatAt
.26:
        add ecx, byte 38h
        inc edi
.27:
        imul edx, dword [byte ebp+07Ah], dword 194Fh
        movsx eax, word [dword edx+esi+0211Fh]
        cmp edi, eax
        jl near .25
        lea eax, [dword esi+0DF4h]
        add edx, eax
        xor edi, edi
        lea ecx, [dword edx+01283h]
        jmp near .30
.28:
        cmp dword [byte ecx+018h], byte 0
        je short .29
        lea eax, [byte ecx+018h]
        lea edx, [byte ebp-07Eh]
        mov dword [dword ebp+08Ah], eax
        call FindPlayerRecord
        test eax, eax
        jne short .29
        mov edx, 8
        mov eax, dword [dword ebp+08Ah]
        xor ebx, ebx
        call LinkSendBlock
        mov edx, 8
        lea eax, [byte ecx+028h]
        xor ebx, ebx
        mov dword [byte ebp+07Eh], eax
        call LinkSendBlock
        mov edx, 0BCh
        lea eax, [byte ebp-07Eh]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 27h
        lea eax, [byte ebp+03Eh]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, dword [dword ebp+08Ah]
        lea eax, [byte ebp-07Eh]
        call AddTradeRecord
        mov edx, dword [byte ebp+07Eh]
        lea eax, [byte ebp+03Eh]
        call AddPlayerStatAt
.29:
        add ecx, byte 38h
        inc edi
.30:
        imul edx, dword [byte ebp+07Ah], dword 194Fh
        movsx eax, word [dword edx+esi+02075h]
        cmp edi, eax
        jl near .28
        lea eax, [dword esi+0DF4h]
        add edx, eax
        xor edi, edi
        lea ecx, [dword edx+018A7h]
        jmp near .33
.31:
        cmp dword [byte ecx+018h], byte 0
        je short .32
        lea eax, [byte ecx+018h]
        lea edx, [byte ebp-07Eh]
        mov dword [dword ebp+08Eh], eax
        call FindPlayerRecord
        test eax, eax
        jne short .32
        mov edx, 8
        mov eax, dword [dword ebp+08Eh]
        xor ebx, ebx
        call LinkSendBlock
        mov edx, 8
        lea eax, [byte ecx+028h]
        xor ebx, ebx
        mov dword [byte ebp+07Eh], eax
        call LinkSendBlock
        mov edx, 0BCh
        lea eax, [byte ebp-07Eh]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 27h
        lea eax, [byte ebp+03Eh]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, dword [dword ebp+08Eh]
        lea eax, [byte ebp-07Eh]
        call AddTradeRecord
        mov edx, dword [byte ebp+07Eh]
        lea eax, [byte ebp+03Eh]
        call AddPlayerStatAt
.32:
        add ecx, byte 38h
        inc edi
.33:
        imul eax, dword [byte ebp+07Ah], dword 194Fh
        movsx eax, word [dword esi+eax+02699h]
        cmp edi, eax
        jl near .31
        inc dword [byte ebp+07Ah]
        cmp dword [byte ebp+07Ah], byte 1Ah
        jl near .21
.34:
        lea esp, [dword ebp+092h]
        jmp near CreateSeason_561
;-----------------------------------------------------------------------------
; LoadFakeExhibition                              92DB7  97 PC, low confidence
; For the roster screen: loads the exhibition file into "fakeEXHIBIT" /
; "fakeAGENTS" copies
;-----------------------------------------------------------------------------
LoadFakeExhibition:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        cmp dword [LinkGameActive], byte 0
        jne short .1
        call LoadExhibitionFile
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov edx, 383C5h
        mov ebx, eax
        mov eax, str_FakeEXHIBIT
        call AllocClearBlock
        mov ebx, 383C5h
        mov edx, dword [ExhibitionData]
        mov eax, dword [ecx]
        call memcpy_
        mov eax, dword [ecx]
        cmp word [eax], byte 0
        jle short .2
        movsx edx, word [eax]
        imul edx, byte 38h
        lea ebx, [dword eax+0383C1h]
        mov eax, str_FakeAGENTS
        call AllocClearBlock
        mov eax, dword [ecx]
        movsx ebx, word [eax]
        imul ebx, byte 38h
        mov ecx, dword [ExhibitionData]
        mov edx, dword [dword ecx+0383C1h]
        mov eax, dword [dword eax+0383C1h]
        call memcpy_
.2:
        mov eax, 1
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SaveAgents                                      92E37  97 PC, low confidence
; Writes the "agents" (free agents) table back (SaveExhibitionFile)
;-----------------------------------------------------------------------------
SaveAgents:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        cmp dword [LinkGameActive], byte 0
        jne short .2
.1:
        call SaveExhibitionFile
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        mov eax, dword [ExhibitionData]
        cmp dword [dword eax+0383C1h], byte 0
        je short .3
        cmp word [esi], byte 0
        jle short .3
        push dword [dword eax+0383C1h]
        call FreeMemBlock
        add esp, byte 4
.3:
        mov ebx, 383C5h
        mov eax, dword [ExhibitionData]
        mov edx, esi
        call memcpy_
        cmp word [esi], byte 0
        jle short .4
        movsx eax, word [esi]
        imul eax, byte 38h
        push byte 0
        push eax
        push str_Agents
        call AllocMemBlock
        mov edx, eax
        mov eax, dword [ExhibitionData]
        mov dword [dword eax+0383C1h], edx
        movsx ebx, word [esi]
        imul ebx, byte 38h
        mov eax, dword [ExhibitionData]
        add esp, byte 0Ch
        mov edx, dword [dword esi+0383C1h]
        mov eax, dword [dword eax+0383C1h]
        call memcpy_
.4:
        call ClearLinkAbort
        test eax, eax
        je short .5
        mov eax, esi
        jmp near .1
.5:
        mov eax, 1
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SaveAgentsOnly                                  92EE2  97 PC, low confidence
; Saves the free agents
;-----------------------------------------------------------------------------
SaveAgentsOnly:
        push ebx
        mov ebx, eax
        mov eax, edx
        cmp dword [LinkGameActive], byte 0
        jne short .2
        movsx edx, dx
        mov eax, ebx
        call AllocImportBuffer
        test eax, eax
        je short .3
.1:
        mov eax, ebx
        call SaveAgents
        pop ebx
        ret
.2:
        movsx edx, dx
        mov eax, ebx
        call AllocImportBuffer
        test eax, eax
        je short .3
        call ClearLinkAbort
        test eax, eax
        jne short .1
        mov eax, 1
.3:
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SaveTradesLink                                  92F25  97 PC, low confidence
; Saves the trades and exchanges them over the link
;-----------------------------------------------------------------------------
SaveTradesLink:
        push esi
        push edi
        enter 14h, 0
        mov esi, eax
        mov edi, edx
        mov dword [byte ebp-04h], ebx
        cmp dword [LinkGameActive], byte 0
        jne short .2
        push dword [byte ebp+014h]
        movzx eax, byte [byte ebp+010h]
        push eax
        movzx ecx, cl
        mov eax, esi
        call ImportNewPlayers
        test eax, eax
        je near .4
.1:
        mov eax, esi
        call SaveAgents
        jmp near .4
.2:
        call ClearLinkAbort
        test eax, eax
        je short .3
        push dword [byte ebp+014h]
        movzx eax, byte [byte ebp+010h]
        push eax
        movzx ecx, cl
        mov eax, esi
        call ImportNewPlayers
        test eax, eax
        je short .4
        mov edx, 8
        mov eax, edi
        xor ebx, ebx
        call LinkSendBlock
        mov edx, 8
        mov eax, dword [byte ebp-04h]
        xor ebx, ebx
        call LinkSendBlock
        jmp short .1
.3:
        mov edx, 8
        lea eax, [byte ebp-014h]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 8
        lea eax, [byte ebp-0Ch]
        xor ebx, ebx
        call LinkReceiveBlock
        push dword [byte ebp+014h]
        movzx eax, byte [byte ebp+010h]
        push eax
        movzx eax, cl
        lea edx, [byte ebp-014h]
        push eax
        mov ebx, edi
        lea ecx, [byte ebp-0Ch]
        push dword [byte ebp-04h]
        mov eax, esi
        call ImportTradedPlayers
        test eax, eax
        jne near .1
.4:
        leave
        pop edi
        pop esi
        ret 8
;-----------------------------------------------------------------------------
; SetPlayoffFormat                                92FE9  97 PC, low confidence
; Sets the playoff format
;-----------------------------------------------------------------------------
SetPlayoffFormat:
        push edx
        mov edx, dword [eax]
        mov edx, dword [nosplit edx*4+PlayoffFormatTeams]
        mov dword [PlayoffTeamCount], edx
        mov eax, dword [eax]
        sub eax, byte 3
        mov dword [PlayoffFormat], eax
        pop edx
        ret
