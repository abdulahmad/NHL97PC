; League records: teams, players, trades, schedules, results, stats, exhibitions and imports.
bits 32
%include "hockey.inc"
section s_DC653 progbits alloc exec nowrite align=1
extern _dos_getdate_, AddIndexKey, AllocClearBlock, AllocClearBlock20, AllocRecordSlot, BuildKeyFromLong, BuildKeyFromString, CopyBytesOk
extern DaysToYear, DbFileTable, DbGameFile, DbIndexRoot, DbKeyBuffer, DbKeyIndex, DbOpen, DbPlayerFile
extern DbPlayerIndex, DbPlayerStatFile, DbStaticBuffer, DbTeamStatFile, DeleteIndexKey, DeleteReplayIndexEntry, FileClose, FileCreate
extern FileExists, FileOpen, FileReadRecord, FileSeek, FileWriteRecord, FindFirstKey, FindIndexKey, FindLastKey
extern FindRecordByKey_1BC, FindReplayIndexEntry, FreePtr, GetLangText, HideWorkingBox, KeysEqual, KeyToLong, LeagueFileDir
extern LeagueFilePrefix, LoadGameRosters, LookupRecord, LookupRecord_236, LookupRecord_244, LookupRecord_249, LookupRecord_307, LookupRecord_30C
extern MakeKeyPair, MakeRecordKey, memcmp_, NewRecordKey, NextIndexKey, OpenGameDatabase_13, OpenGameDatabase_18, PlayoffDbKey
extern PrevIndexKey, rand_, ReadDbRecord, RepairDatabase_52F, ServiceIdle, ShowWorkingBox, sprintf_, StaticBuffer
extern str_AGENTS, str_EXHIBIT, str_ORIGEXH, str_S08x03x, str_SCHED, str_SSEXH, str_SSPLY, str_SSSEA
extern str_TEMP2, strcmp_, UpdateWorkingBox, WriteDbRecord, ZeroBytesOk
global FindTeamRecord, BuildAllStarRecords, AddPlayerRecord, AddTradeRecord, FindPlayerRecord, UpdatePlayerRecord, UpdatePlayerRecord_19F, UpdatePlayerRecord_1A6
global UpdatePlayerRecord_1AD, UpdatePlayerRecord_221, UpdatePlayerRecord_229, MakeLeagueKey, MakeLeagueKeyBase, MakeLeagueKeyBase_5, CreateExhibitionFile, CreateExhibitionFile_2F7
global CreateExhibitionFile_30F, CreateExhibitionFile_319, CreateExhibitionFile_31E, CreateExhibitionFile_325, CreatePlayoffFile, CreatePlayoffSchedule, CreateSeasonFile, CreateSeasonSchedule
global CreateSeasonSchedule_2F0, ScheduleEntryMatches, FindNextSeasonGame, OpenLeagueFile, WriteLeagueHeader, StartSeasonGame, RecordHomeStats, RecordHomeStats_15A
global RecordAwayStats, RecordGameResult, SaveGameResult, SaveGameResult_55, SaveExhibitionResult, SaveSeasonResult, MakeGameKey, BuildPlayoffRecords
global BuildSeasonRecords, BuildSeasonRecords_797, AddGameRecord, AddGameRecord_C0, AddGameRecord_C5, AddGameRecord_CC, FindGameRecord, FindGameRecord_9B
global FindGameRecord_A0, UpdateGameRecord, MakePlayerStatKey, MakeGoalieStatKey, AddPlayerStat, AddPlayerStatAt, AddPlayerStatAt_BE, AddPlayerStatAt_C3
global AddPlayerStatAt_CA, FindPlayerStat, UpdatePlayerStat, MakeTeamStatKey, MakeStandingsKey, AddTeamStat, AddTeamStatAt, FindTeamStat
global ReadTeamStats, UpdateTeamStat, LoadExhibitionFile, SaveExhibitionFile, FreeExhibitionFile, ResetExhibitionStats, ResetExhibitionFile, ImportTradedPlayers
global ImportNewPlayers, AllocImportBuffer, PickDemoTeams
;-----------------------------------------------------------------------------
; FindTeamRecord                                  DC653  97 PC, low confidence
; Finds a team record
;-----------------------------------------------------------------------------
FindTeamRecord:
        push ebx
        push ecx
        push esi
        push edi
        enter 38h, 0
        push eax
        push edx
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        jmp near FindGameRecord_A0
.1:
        mov edx, 66h
        mov eax, dword [byte ebp-040h]
        mov edi, dword [byte ebp-040h]
        mov esi, dword [byte ebp-03Ch]
        lea ebx, [byte ebp-038h]
        lea ecx, [byte ebp-04h]
        call ZeroBytesOk
        mov edx, 2
        mov eax, dword [byte ebp-040h]
        movsd
        movsd
        call LookupRecord
        lea ebx, [byte ebp-038h]
        mov edx, 2
        mov eax, dword [DbFileTable]
        call FindIndexKey
        test eax, eax
        je near FindGameRecord_A0
        lea ebx, [byte ebp-0Ch]
        lea edx, [byte ebp-038h]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp-038h]
        lea ebx, [byte ebp-0Ch]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        mov ebx, 8
        lea edx, [byte ebp-0Ch]
        mov eax, dword [byte ebp-03Ch]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je near FindGameRecord_A0
        mov ebx, 67h
        mov edx, dword [byte ebp-04h]
        mov ecx, dword [DbStaticBuffer]
        xor eax, eax
        call ReadDbRecord
        test eax, eax
        je near FindGameRecord_A0
        mov ebx, 66h
        jmp near LookupRecord_236
;-----------------------------------------------------------------------------
; BuildAllStarRecords                             DC71D  97 PC, low confidence
; Builds the all-star teams
;-----------------------------------------------------------------------------
BuildAllStarRecords:
        push ebx
        push ecx
        push edx
        push esi
        enter 30h, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        jmp near UpdatePlayerRecord_229
.1:
        lea ebx, [byte ebp-030h]
        mov edx, 3
        mov dword [eax], 0
        lea ecx, [byte ebp-04h]
        mov dword [byte eax+04h], 0
        call LookupRecord
        lea ebx, [byte ebp-030h]
        mov edx, 3
        mov eax, dword [DbFileTable]
        call FindIndexKey
        test eax, eax
        je near UpdatePlayerRecord_229
        mov ebx, 67h
        mov edx, dword [byte ebp-04h]
        mov ecx, dword [DbStaticBuffer]
        xor eax, eax
        mov dword [DbIndexRoot], 1
        call ReadDbRecord
        test eax, eax
        je near UpdatePlayerRecord_229
        mov ebx, 66h
        mov eax, dword [DbStaticBuffer]
        mov edx, esi
        inc eax
        call CopyBytesOk
        jmp near LookupRecord_307
        push ebx
        push ecx
        push edx
        push esi
        enter 30h, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .2
        xor eax, eax
        jmp near UpdatePlayerRecord_229
.2:
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov dword [eax], 0
        mov edx, 4
        mov eax, dword [DbFileTable]
        call FindLastKey
        test eax, eax
        je near UpdatePlayerRecord_229
        call ServiceIdle
.3:
        cmp byte [byte ebp-030h], 0
        je near LookupRecord_307
        cmp dword [byte ebp-04h], byte 0FFFFFFFFh
        je near LookupRecord_307
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        inc dword [esi]
        mov edx, 4
        mov eax, dword [DbFileTable]
        call NextIndexKey
        test eax, eax
        jne short .3
        jmp near UpdatePlayerRecord_229
        push ebx
        push ecx
        push edx
        push esi
        enter 30h, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .5
.4:
        xor eax, eax
        jmp near UpdatePlayerRecord_229
.5:
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 5
        mov eax, dword [DbFileTable]
        mov dword [DbPlayerIndex], 0
        call FindLastKey
        test eax, eax
        je near UpdatePlayerRecord_229
        call ServiceIdle
        cmp dword [byte ebp-04h], byte 0FFFFFFFFh
        jne short .6
        cmp byte [byte ebp-030h], 0
        je short .4
.6:
        mov ebx, 0BCh
        mov edx, dword [byte ebp-04h]
        mov eax, 1
        mov ecx, esi
        call ReadDbRecord
        test eax, eax
        je near UpdatePlayerRecord_229
.7:
        mov eax, 1
        mov dword [DbPlayerIndex], 1
        jmp near UpdatePlayerRecord_229
        push ebx
        push ecx
        push edx
        push esi
        enter 30h, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .8
        xor eax, eax
        jmp near UpdatePlayerRecord_229
.8:
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 5
        mov eax, dword [DbFileTable]
        mov dword [DbPlayerIndex], 0
        call FindFirstKey
        test eax, eax
        je near UpdatePlayerRecord_229
        call ServiceIdle
        mov ebx, 0BCh
        mov edx, dword [byte ebp-04h]
        mov eax, 1
        mov ecx, esi
        call ReadDbRecord
        test eax, eax
        jne short .7
        jmp near UpdatePlayerRecord_229
        push ebx
        push ecx
        push esi
        enter 30h, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .10
.9:
        xor eax, eax
        leave
        pop esi
        pop ecx
        pop ebx
        ret
.10:
        cmp dword [DbPlayerIndex], byte 0
        je short .9
        test edx, edx
        je short .12
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 5
        mov eax, dword [DbFileTable]
        call NextIndexKey
.11:
        test eax, eax
        jne short .13
        mov dword [DbPlayerIndex], eax
        leave
        pop esi
        pop ecx
        pop ebx
        ret
.12:
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 5
        mov eax, dword [DbFileTable]
        call PrevIndexKey
        jmp short .11
.13:
        cmp dword [byte ebp-04h], byte 0FFFFFFFFh
        jne short .14
        cmp byte [byte ebp-030h], 0
        je short .9
.14:
        mov ebx, 0BCh
        mov edx, dword [byte ebp-04h]
        mov eax, 1
        mov ecx, esi
        call ReadDbRecord
        test eax, eax
        je short .15
        call ServiceIdle
        mov eax, 1
.15:
        leave
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AddPlayerRecord                                 DC99F  97 PC, low confidence
; Adds a player record
;-----------------------------------------------------------------------------
AddPlayerRecord:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 5Ch, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        jmp near OpenGameDatabase_18
.1:
        mov edx, eax
        mov eax, 4
        call NewRecordKey
        test eax, eax
        je near OpenGameDatabase_18
        mov ebx, 0BCh
        lea edx, [byte ebp-04h]
        mov eax, 1
        call AllocRecordSlot
        test eax, eax
        je near OpenGameDatabase_18
        mov ebx, 0BCh
        mov eax, dword [DbPlayerFile]
        mov edx, esi
        call FileWriteRecord
        test eax, eax
        je near OpenGameDatabase_18
        lea ebx, [byte ebp-05Ch]
        mov edx, 4
        mov eax, esi
        call LookupRecord
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov edx, 4
        mov eax, dword [DbFileTable]
        call AddIndexKey
        mov edi, eax
        test eax, eax
        je near AddGameRecord_CC
        lea ebx, [byte ebp-030h]
        mov edx, 5
        mov eax, esi
        call LookupRecord
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 5
        mov eax, dword [DbFileTable]
        call AddIndexKey
        test eax, eax
        jne near AddGameRecord_CC
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov edx, 4
        jmp near RepairDatabase_52F
;-----------------------------------------------------------------------------
; AddTradeRecord                                  DCA6C  97 PC, low confidence
; Adds a trade record
;-----------------------------------------------------------------------------
AddTradeRecord:
        push ebx
        push ecx
        push esi
        push edi
        enter 64h, 0
        push eax
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near FindGameRecord_A0
.2:
        cmp dword [edx], byte 0
        je short .1
        mov eax, dword [edx]
        cmp eax, dword [StaticBuffer]
        je short .1
        mov edi, dword [byte ebp-068h]
        lea ebx, [byte ebp-064h]
        mov eax, dword [byte ebp-068h]
        mov esi, edx
        lea ecx, [byte ebp-04h]
        mov edx, 4
        movsd
        movsd
        call LookupRecord
        lea ebx, [byte ebp-064h]
        mov edx, 4
        mov eax, dword [DbFileTable]
        call FindIndexKey
        test eax, eax
        je short .3
        lea ebx, [byte ebp-0Ch]
        lea edx, [byte ebp-064h]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp-064h]
        lea ebx, [byte ebp-0Ch]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        mov ebx, 8
        lea edx, [byte ebp-0Ch]
        mov eax, dword [byte ebp-068h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne near .1
.3:
        lea ebx, [byte ebp-064h]
        mov edx, 4
        mov eax, dword [byte ebp-068h]
        call LookupRecord
        mov ebx, 0BCh
        lea edx, [byte ebp-04h]
        mov eax, 1
        call AllocRecordSlot
        test eax, eax
        je near FindGameRecord_A0
        mov ebx, 0BCh
        mov edx, dword [byte ebp-068h]
        mov eax, dword [DbPlayerFile]
        call FileWriteRecord
        test eax, eax
        je near FindGameRecord_A0
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-064h]
        mov edx, 4
        mov eax, dword [DbFileTable]
        call AddIndexKey
        mov esi, eax
        test eax, eax
        je near AddPlayerStatAt_CA
        lea ebx, [byte ebp-038h]
        mov edx, 5
        mov eax, dword [byte ebp-068h]
        call LookupRecord
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-038h]
        mov edx, 5
        mov eax, dword [DbFileTable]
        call AddIndexKey
        test eax, eax
        jne near AddPlayerStatAt_CA
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-064h]
        mov edx, 4
        mov eax, dword [DbFileTable]
        jmp near AddPlayerStatAt_C3
;-----------------------------------------------------------------------------
; FindPlayerRecord                                DCBB0  97 PC, low confidence
; Finds a player record
;-----------------------------------------------------------------------------
FindPlayerRecord:
        push ebx
        push ecx
        push esi
        push edi
        enter 38h, 0
        push eax
        push edx
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        jmp near FindGameRecord_A0
.1:
        mov edx, 0BCh
        mov eax, dword [byte ebp-040h]
        mov edi, dword [byte ebp-040h]
        mov esi, dword [byte ebp-03Ch]
        lea ebx, [byte ebp-038h]
        lea ecx, [byte ebp-04h]
        call ZeroBytesOk
        mov edx, 4
        mov eax, dword [byte ebp-040h]
        movsd
        movsd
        call LookupRecord
        lea ebx, [byte ebp-038h]
        mov edx, 4
        mov eax, dword [DbFileTable]
        call FindIndexKey
        test eax, eax
        je near FindGameRecord_A0
        lea ebx, [byte ebp-0Ch]
        lea edx, [byte ebp-038h]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp-038h]
        lea ebx, [byte ebp-0Ch]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        mov ebx, 8
        lea edx, [byte ebp-0Ch]
        mov eax, dword [byte ebp-03Ch]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je near FindGameRecord_A0
        mov ecx, dword [byte ebp-040h]
        mov ebx, 0BCh
        mov edx, dword [byte ebp-04h]
        mov eax, 1
        call ReadDbRecord
        test eax, eax
        jne near LookupRecord_244
        jmp near FindGameRecord_A0
;-----------------------------------------------------------------------------
; UpdatePlayerRecord                              DCC75  97 PC, low confidence
; Updates a player record
;-----------------------------------------------------------------------------
UpdatePlayerRecord:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 14Ch, 0
        sub ebp, 82h
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near UpdatePlayerRecord_1A6
.2:
        lea ebx, [byte ebp+01Eh]
        mov edx, 4
        lea ecx, [byte ebp+07Eh]
        call LookupRecord
        lea ebx, [byte ebp+01Eh]
        mov edx, 4
        mov eax, dword [DbFileTable]
        call FindIndexKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
        lea ebx, [byte ebp+076h]
        lea edx, [byte ebp+01Eh]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp+01Eh]
        lea ebx, [byte ebp+076h]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        mov ebx, 8
        lea edx, [byte ebp+076h]
        mov eax, esi
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne near .4
        mov eax, dword [esi]
        cmp eax, dword [StaticBuffer]
        je near .4
        mov ebx, 0BCh
        lea edx, [byte ebp+07Eh]
        mov eax, 1
        call AllocRecordSlot
        test eax, eax
        je near UpdatePlayerRecord_1A6
        mov ebx, 0BCh
        mov eax, dword [DbPlayerFile]
        mov edx, esi
        call FileWriteRecord
        test eax, eax
        je near UpdatePlayerRecord_1A6
        lea ebx, [byte ebp+04Ah]
        mov edx, 4
        mov eax, esi
        call LookupRecord
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp+04Ah]
        mov edx, 4
        mov eax, dword [DbFileTable]
        call AddIndexKey
        mov edi, eax
        test eax, eax
        je short .3
        lea ebx, [byte ebp-0Eh]
        mov edx, 5
        mov eax, esi
        call LookupRecord
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp-0Eh]
        mov edx, 5
        mov eax, dword [DbFileTable]
        call AddIndexKey
        test eax, eax
        jne short .3
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp+04Ah]
        mov edx, 4
        mov eax, dword [DbFileTable]
        call DeleteIndexKey
        xor edi, edi
.3:
        mov eax, edi
        jmp short UpdatePlayerRecord_1A6
.4:
        lea edx, [dword ebp-0CAh]
        mov eax, esi
        call FindPlayerRecord
        lea edx, [dword ebp-0C2h]
        lea eax, [byte esi+08h]
        call strcmp_
        test eax, eax
        jne near .1
        lea edx, [dword ebp-0B2h]
        lea eax, [byte esi+018h]
        call strcmp_
        test eax, eax
        jne near .1
        lea edx, [dword ebp-0CAh]
        mov eax, esi
        call KeysEqual
        test eax, eax
        je near .1
        call ServiceIdle
        mov ebx, 0BCh
        mov edx, dword [byte ebp+07Eh]
        mov eax, 1
UpdatePlayerRecord_19F:
        mov ecx, esi
        call WriteDbRecord
UpdatePlayerRecord_1A6:
        lea esp, [dword ebp+082h]
        pop ebp
UpdatePlayerRecord_1AD:
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
        enter 30h, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .5
        xor eax, eax
        jmp short UpdatePlayerRecord_229
.5:
        lea ebx, [byte ebp-030h]
        mov edx, 5
        mov dword [eax], 0
        lea ecx, [byte ebp-04h]
        mov dword [byte eax+04h], 0
        call LookupRecord
        lea ebx, [byte ebp-030h]
        mov edx, 5
        mov eax, dword [DbFileTable]
        call FindIndexKey
        test eax, eax
        je short UpdatePlayerRecord_229
        call ServiceIdle
        mov ebx, 0BCh
        mov edx, dword [byte ebp-04h]
        mov eax, 1
        mov ecx, esi
        mov dword [DbPlayerIndex], 1
        call ReadDbRecord
UpdatePlayerRecord_221:
        test eax, eax
        jne near LookupRecord_30C
UpdatePlayerRecord_229:
        leave
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; MakeLeagueKey                                   DCEA4  97 PC, low confidence
; Builds a league record key from its type and number
;-----------------------------------------------------------------------------
MakeLeagueKey:
        push ebx
        push ecx
        push esi
        enter 30h, 0
        mov esi, edx
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        leave
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        test eax, eax
        je short .3
        cmp eax, byte 1
        je short .3
        cmp eax, byte 3
        je short .3
        cmp eax, byte 5
        je short .3
        cmp eax, byte 7
        je short .3
        cmp eax, byte 9
        jne short .1
.3:
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        movsx edx, ax
        mov eax, dword [DbKeyIndex]
        call FindFirstKey
        test eax, eax
        je short .5
        cmp byte [byte ebp-030h], 0
        jne short .4
        cmp dword [byte ebp-04h], byte 0FFFFFFFFh
        jne short .4
        mov eax, dword [StaticBuffer]
        mov dword [byte esi+04h], 0
        mov dword [esi], eax
        mov eax, 1
        leave
        pop esi
        pop ecx
        pop ebx
        ret
.4:
        lea edx, [byte ebp-030h]
        mov eax, 4
        lea ebx, [byte esi+04h]
        call KeyToLong
        lea edx, [byte ebp-030h]
        mov eax, 4
        mov ebx, esi
        add edx, byte 5
        call KeyToLong
        mov eax, dword [StaticBuffer]
        mov dword [esi], eax
        mov eax, 1
        add dword [byte esi+04h], eax
.5:
        leave
        pop esi
        pop ecx
        pop ebx
        ret
        push ecx
        push esi
        push edi
        mov esi, eax
        mov ecx, ebx
        test edx, edx
        je short .6
        xor eax, eax
        pop edi
        pop esi
        pop ecx
        ret
.6:
        lea edi, [byte eax+04h]
        lea edx, [byte eax+08h]
        mov eax, 4
        call BuildKeyFromLong
        mov eax, 4
        mov ebx, ecx
        mov edx, edi
        call BuildKeyFromString
        mov eax, 4
        lea edi, [byte esi+0Ch]
        mov ebx, ecx
        lea edx, [byte esi+010h]
        call BuildKeyFromString
        mov eax, 4
        mov ebx, ecx
        mov edx, edi
        call BuildKeyFromString
        mov eax, 1
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; MakeLeagueKeyBase                               DCFA4  97 PC, low confidence
; Builds a league record key of the base type
;-----------------------------------------------------------------------------
MakeLeagueKeyBase:
        push edx
        mov edx, eax
        xor eax, eax
MakeLeagueKeyBase_5:
        call MakeLeagueKey
        pop edx
        ret
;-----------------------------------------------------------------------------
; CreateExhibitionFile                            DCFB0  97 PC, low confidence
; Creates the exhibition league file
;-----------------------------------------------------------------------------
CreateExhibitionFile:
        push esi
        push edi
        enter 90h, 0
        push eax
        push edx
        push ebx
        push ecx
        sub ebp, byte 7Eh
        cmp word [DbOpen], byte 0
        je near .7
        movsx eax, dx
        imul eax, byte 18h
        movsx edx, word [byte ebp-016h]
        shl edx, 4
        add eax, byte 24h
        mov ebx, dword [dword ebp+08Eh]
        add edx, eax
        mov eax, str_SCHED
        call AllocClearBlock20
        test eax, eax
        je near CreateExhibitionFile_325
        mov eax, dword [dword ebp+08Eh]
        mov eax, dword [eax]
        mov dword [byte ebp+07Ah], eax
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp-01Ah]
        mov word [edx], ax
        mov eax, dword [byte ebp-016h]
        mov edi, edx
        mov word [byte edx+02h], ax
        mov esi, ecx
        lea edi, [byte edi+0Ch]
        lea esi, [byte esi+0Ch]
        mov eax, edx
        add edx, byte 24h
        movsd
        movsd
        mov dword [byte eax+014h], edx
        mov edx, eax
        movsx edx, word [edx]
        mov eax, dword [byte eax+014h]
        shl edx, 3
        add eax, edx
        mov edx, dword [byte ebp+07Ah]
        mov dword [byte edx+018h], eax
        movsx edx, word [edx]
        mov eax, dword [byte ebp+07Ah]
        shl edx, 3
        mov eax, dword [byte eax+018h]
        add eax, edx
        mov edx, dword [byte ebp+07Ah]
        mov dword [byte edx+01Ch], eax
        movsx eax, word [edx]
        shl eax, 3
        mov edx, dword [byte edx+01Ch]
        add edx, eax
        mov eax, dword [byte ebp+07Ah]
        mov dword [byte eax+020h], edx
        lea edx, [byte eax+04h]
        xor eax, eax
        call MakeLeagueKey
        test eax, eax
        jne short .1
        mov eax, dword [dword ebp+08Eh]
        call FreePtr
        jmp near .7
.1:
        movsx edx, word [byte ebp-01Ah]
        mov eax, 243h
        mov dword [byte ebp+076h], 0
        mov dword [byte ebp+072h], 0
        inc edx
        inc edx
        call GetLangText
        call ShowWorkingBox
.2:
        movsx eax, word [byte ebp-01Ah]
        cmp eax, dword [byte ebp+076h]
        jle near .9
        call ServiceIdle
        mov eax, dword [byte ebp+076h]
        mov ecx, dword [byte ebp+072h]
        inc eax
        xor esi, esi
        call UpdateWorkingBox
.3:
        mov eax, dword [byte ebp-022h]
        movsx eax, word [eax]
        cmp esi, eax
        jge short .5
        mov eax, esi
        mov edx, dword [byte ebp-022h]
        shl eax, 3
        mov edx, dword [byte edx+014h]
        add eax, edx
        mov edx, dword [byte ebp-01Eh]
        mov ebx, 8
        add edx, ecx
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .4
        mov dword [byte ebp+06Eh], esi
        mov esi, dword [byte ebp-022h]
        movsx esi, word [esi]
.4:
        inc esi
        jmp short .3
.5:
        jne short .8
.6:
        mov eax, dword [dword ebp+08Eh]
        call FreePtr
        call HideWorkingBox
.7:
        xor eax, eax
        jmp near CreateExhibitionFile_325
.8:
        mov eax, dword [byte ebp+06Eh]
        mov esi, dword [byte ebp-022h]
        mov edi, dword [byte ebp+07Ah]
        shl eax, 3
        mov esi, dword [byte esi+014h]
        mov edi, dword [byte edi+014h]
        add esi, eax
        add edi, ecx
        movsd
        movsd
        mov ebx, dword [byte ebp+076h]
        mov esi, dword [byte ebp-022h]
        mov edi, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp-022h]
        mov esi, dword [byte esi+018h]
        mov edi, dword [byte edi+018h]
        add esi, eax
        add edi, ecx
        mov ecx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp+06Eh]
        movsd
        movsd
        call BuildSeasonRecords
        test eax, eax
        je short .6
        inc dword [byte ebp+076h]
        add dword [byte ebp+072h], byte 8
        jmp near .2
.9:
        mov eax, dword [byte ebp+07Ah]
        movsx ebx, word [byte ebp-016h]
        xor edx, edx
        mov eax, dword [byte eax+020h]
        jmp short .11
.10:
        mov byte [eax], 0FFh
        mov byte [byte eax+01h], 0FFh
        mov byte [byte eax+02h], 0FFh
        mov byte [byte eax+03h], 0FFh
        mov esi, DbKeyBuffer
        mov word [byte eax+04h], 0
        inc edx
        lea edi, [byte eax+08h]
        mov word [byte eax+06h], 0
        add eax, byte 10h
        movsd
        movsd
.11:
        cmp edx, ebx
        jl short .10
        call ServiceIdle
        mov eax, dword [byte ebp+07Ah]
        push dword [byte eax+08h]
        mov eax, dword [byte eax+04h]
        xor eax, 0AAAAAAAAh
        push eax
        push dword [LeagueFilePrefix]
        push str_S08x03x
        lea eax, [byte ebp-012h]
        push eax
        mov ecx, dword [byte ebp+07Ah]
        lea edx, [byte ebp+06Ah]
        call sprintf_
        add esp, byte 14h
        lea eax, [byte ebp-012h]
        mov ecx, dword [byte ecx+08h]
        call FileCreate
        mov edx, eax
        test eax, eax
        je near .16
        movsx eax, word [byte ebp-01Ah]
        mov ebx, 14h
        inc eax
        mov edx, dword [byte ebp+07Ah]
        call UpdateWorkingBox
        mov eax, dword [byte ebp+06Ah]
        call FileWriteRecord
        mov edx, eax
        test eax, eax
        je short .12
        mov ebx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp+06Ah]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+014h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.12:
        test edx, edx
        je short .13
        mov ebx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp+06Ah]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+018h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.13:
        test edx, edx
        je short .14
        mov ebx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp+06Ah]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+01Ch]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.14:
        test edx, edx
        je short .15
        mov ebx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp+06Ah]
        movsx ebx, word [byte ebx+02h]
        mov edx, dword [byte edx+020h]
        shl ebx, 4
        call FileWriteRecord
        mov edx, eax
.15:
        lea eax, [byte ebp+06Ah]
        call FileClose
        call ServiceIdle
.16:
        test edx, edx
        je short CreateExhibitionFile_30F
        movsx eax, word [byte ebp-01Ah]
        inc eax
        inc eax
        call UpdateWorkingBox
        mov eax, dword [byte ebp+07Ah]
        lea edx, [byte ebp+03Eh]
        add eax, byte 4
        call MakeRecordKey
        mov eax, dword [byte ebp+07Ah]
        lea edx, [byte ebp+03Eh]
        add eax, byte 0Ch
        lea ebx, [byte ebp+03Eh]
CreateExhibitionFile_2F7:
        call MakeKeyPair
        mov eax, dword [DbKeyIndex]
        xor edx, edx
        call AddIndexKey
        mov edx, eax
        call ServiceIdle
CreateExhibitionFile_30F:
        test edx, edx
        jne short CreateExhibitionFile_31E
        mov eax, dword [dword ebp+08Eh]
CreateExhibitionFile_319:
        call FreePtr
CreateExhibitionFile_31E:
        call HideWorkingBox
        mov eax, edx
CreateExhibitionFile_325:
        lea esp, [byte ebp+07Eh]
        pop ebp
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; CreatePlayoffFile                               DD2DE  97 PC, low confidence
; Creates the playoff league file
;-----------------------------------------------------------------------------
CreatePlayoffFile:
        push esi
        push edi
        enter 94h, 0
        push eax
        push edx
        push ebx
        push ecx
        sub ebp, byte 7Eh
        cmp word [DbOpen], byte 0
        je short .3
        lea edx, [byte ebp+06Ah]
        mov eax, PlayoffDbKey
        call OpenLeagueFile
        test eax, eax
        je short CreateExhibitionFile_325
        mov eax, dword [byte ebp+06Ah]
        movsx eax, word [eax]
        imul eax, byte 18h
        movsx edx, word [byte ebp-01Ah]
        shl edx, 4
        add eax, byte 24h
        mov ebx, dword [dword ebp+08Eh]
        add edx, eax
        mov eax, str_SCHED
        call AllocClearBlock20
        test eax, eax
        jne short .4
.1:
        lea eax, [byte ebp+06Ah]
.2:
        call FreePtr
.3:
        xor eax, eax
        jmp short CreateExhibitionFile_325
.4:
        mov eax, dword [dword ebp+08Eh]
        mov eax, dword [eax]
        mov dword [byte ebp+07Ah], eax
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp-01Eh]
        mov word [edx], ax
        mov eax, dword [byte ebp-01Ah]
        mov word [byte edx+02h], ax
        mov edi, edx
        mov esi, dword [byte ebp+06Ah]
        lea edi, [byte edi+0Ch]
        lea esi, [byte esi+0Ch]
        mov eax, edx
        add edx, byte 24h
        movsd
        movsd
        mov dword [byte eax+014h], edx
        movsx eax, word [eax]
        mov edx, dword [byte ebp+07Ah]
        shl eax, 3
        mov edx, dword [byte edx+014h]
        add edx, eax
        mov eax, dword [byte ebp+07Ah]
        mov dword [byte eax+018h], edx
        movsx edx, word [eax]
        shl edx, 3
        mov eax, dword [byte eax+018h]
        add eax, edx
        mov edx, dword [byte ebp+07Ah]
        mov dword [byte edx+01Ch], eax
        movsx eax, word [edx]
        shl eax, 3
        mov edx, dword [byte edx+01Ch]
        add edx, eax
        mov eax, dword [byte ebp+07Ah]
        mov dword [byte eax+020h], edx
        lea edx, [byte eax+04h]
        xor eax, eax
        call MakeLeagueKey
        test eax, eax
        jne short .5
        lea eax, [byte ebp+06Ah]
        call FreePtr
        mov eax, dword [dword ebp+08Eh]
        jmp near .2
.5:
        movsx edx, word [byte ebp-01Eh]
        mov eax, 243h
        mov dword [byte ebp+076h], 0
        mov dword [byte ebp+072h], 0
        inc edx
        inc edx
        call GetLangText
        call ShowWorkingBox
.6:
        movsx eax, word [byte ebp-01Eh]
        cmp eax, dword [byte ebp+076h]
        jle near .12
        call ServiceIdle
        mov eax, dword [byte ebp+076h]
        mov ecx, dword [byte ebp+072h]
        inc eax
        xor esi, esi
        call UpdateWorkingBox
.7:
        mov eax, dword [byte ebp+06Ah]
        movsx eax, word [eax]
        cmp esi, eax
        jge short .9
        mov edx, esi
        mov eax, dword [byte ebp+06Ah]
        shl edx, 3
        mov eax, dword [byte eax+014h]
        add eax, edx
        mov edx, dword [byte ebp-022h]
        mov ebx, 8
        add edx, ecx
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .8
        mov dword [byte ebp+06Eh], esi
        mov esi, dword [byte ebp+06Ah]
        movsx esi, word [esi]
.8:
        inc esi
        jmp short .7
.9:
        jne short .10
        mov eax, dword [dword ebp+08Eh]
        call FreePtr
        call HideWorkingBox
        jmp near .1
.10:
        mov edx, dword [byte ebp+06Eh]
        mov eax, dword [byte ebp+06Ah]
        mov edi, dword [byte ebp+07Ah]
        shl edx, 3
        mov esi, dword [byte eax+014h]
        mov edi, dword [byte edi+014h]
        add esi, edx
        add edi, ecx
        movsd
        movsd
        push DbKeyBuffer
        mov eax, dword [byte ebp+06Ah]
        mov edi, dword [byte ebp+07Ah]
        mov ebx, dword [byte ebp+076h]
        mov esi, dword [byte eax+018h]
        mov edi, dword [byte edi+018h]
        mov eax, dword [byte ebp+06Eh]
        add esi, edx
        add edi, ecx
        mov ecx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp-026h]
        movsd
        movsd
        call BuildPlayoffRecords
        test eax, eax
        jne short .11
        lea eax, [byte ebp+06Ah]
        call FreePtr
        mov eax, dword [dword ebp+08Eh]
        call FreePtr
        call HideWorkingBox
        jmp near .3
.11:
        inc dword [byte ebp+076h]
        add dword [byte ebp+072h], byte 8
        jmp near .6
.12:
        lea eax, [byte ebp+06Ah]
        call FreePtr
        mov eax, dword [byte ebp+07Ah]
        movsx ebx, word [byte ebp-01Ah]
        xor edx, edx
        mov eax, dword [byte eax+020h]
        jmp short .14
.13:
        mov byte [eax], 0FFh
        mov byte [byte eax+01h], 0FFh
        mov byte [byte eax+02h], 0FFh
        mov byte [byte eax+03h], 0FFh
        mov esi, DbKeyBuffer
        mov word [byte eax+04h], 0
        inc edx
        lea edi, [byte eax+08h]
        mov word [byte eax+06h], 0
        add eax, byte 10h
        movsd
        movsd
.14:
        cmp edx, ebx
        jl short .13
        call ServiceIdle
        mov eax, dword [byte ebp+07Ah]
        push dword [byte eax+08h]
        mov eax, dword [byte eax+04h]
        xor eax, 0AAAAAAAAh
        push eax
        push dword [LeagueFilePrefix]
        push str_S08x03x
        lea eax, [byte ebp-016h]
        push eax
        mov ecx, dword [byte ebp+07Ah]
        lea edx, [byte ebp+066h]
        call sprintf_
        add esp, byte 14h
        lea eax, [byte ebp-016h]
        mov ecx, dword [byte ecx+08h]
        call FileCreate
        mov edx, eax
        test eax, eax
        je near .19
        movsx eax, word [byte ebp-01Eh]
        mov ebx, 14h
        inc eax
        mov edx, dword [byte ebp+07Ah]
        call UpdateWorkingBox
        mov eax, dword [byte ebp+066h]
        call FileWriteRecord
        mov edx, eax
        test eax, eax
        je short .15
        mov ebx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp+066h]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+014h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.15:
        test edx, edx
        je short .16
        mov ebx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp+066h]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+018h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.16:
        test edx, edx
        je short .17
        mov ebx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp+066h]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+01Ch]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.17:
        test edx, edx
        je short .18
        mov ebx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp+066h]
        movsx ebx, word [byte ebx+02h]
        mov edx, dword [byte edx+020h]
        shl ebx, 4
        call FileWriteRecord
        mov edx, eax
.18:
        lea eax, [byte ebp+066h]
        call FileClose
        call ServiceIdle
.19:
        test edx, edx
        je near CreateExhibitionFile_30F
        movsx eax, word [byte ebp-01Eh]
        inc eax
        call UpdateWorkingBox
        mov eax, dword [byte ebp+07Ah]
        lea edx, [byte ebp+03Ah]
        add eax, byte 4
        call MakeRecordKey
        mov eax, dword [byte ebp+07Ah]
        lea edx, [byte ebp+03Ah]
        add eax, byte 0Ch
        lea ebx, [byte ebp+03Ah]
        jmp near CreateExhibitionFile_2F7
;-----------------------------------------------------------------------------
; CreatePlayoffSchedule                           DD61F  97 PC, low confidence
; Creates the playoff schedule
;-----------------------------------------------------------------------------
CreatePlayoffSchedule:
        push esi
        push edi
        enter 94h, 0
        push eax
        push edx
        push ebx
        push ecx
        sub ebp, byte 76h
        cmp word [DbOpen], byte 0
        je near .7
        lea edx, [byte ebp+062h]
        mov eax, PlayoffDbKey
        call OpenLeagueFile
        test eax, eax
        je near FindRecordByKey_1BC
        mov eax, dword [byte ebp+062h]
        movsx eax, word [eax]
        imul eax, byte 18h
        movsx edx, word [byte ebp-022h]
        shl edx, 4
        add eax, byte 24h
        mov ebx, dword [dword ebp+086h]
        add edx, eax
        mov eax, str_SCHED
        call AllocClearBlock20
        test eax, eax
        jne short .1
        lea eax, [byte ebp+062h]
        call FreePtr
        jmp near .7
.1:
        mov eax, dword [dword ebp+086h]
        mov eax, dword [eax]
        mov edi, eax
        mov esi, dword [dword ebp+08Ah]
        mov dword [byte ebp+072h], eax
        lea edi, [byte edi+04h]
        mov eax, dword [byte ebp-026h]
        mov edx, dword [byte ebp+072h]
        movsd
        movsd
        mov word [edx], ax
        mov eax, dword [byte ebp-022h]
        mov word [byte edx+02h], ax
        mov edi, edx
        mov esi, dword [byte ebp+062h]
        lea edi, [byte edi+0Ch]
        lea esi, [byte esi+0Ch]
        mov eax, edx
        add edx, byte 24h
        movsd
        movsd
        mov dword [byte eax+014h], edx
        mov edx, eax
        movsx edx, word [edx]
        mov eax, dword [byte eax+014h]
        shl edx, 3
        add eax, edx
        mov edx, dword [byte ebp+072h]
        mov dword [byte edx+018h], eax
        movsx eax, word [edx]
        shl eax, 3
        mov edx, dword [byte edx+018h]
        add edx, eax
        mov eax, dword [byte ebp+072h]
        mov dword [byte eax+01Ch], edx
        movsx eax, word [eax]
        mov edx, dword [byte ebp+072h]
        shl eax, 3
        mov edx, dword [byte edx+01Ch]
        add edx, eax
        mov eax, dword [byte ebp+072h]
        mov dword [byte ebp+06Eh], 0
        mov dword [byte ebp+06Ah], 0
        mov dword [byte eax+020h], edx
        movsx edx, word [byte ebp-026h]
        mov eax, 243h
        inc edx
        inc edx
        call GetLangText
        call ShowWorkingBox
.2:
        movsx eax, word [byte ebp-026h]
        cmp eax, dword [byte ebp+06Eh]
        jle near .9
        call ServiceIdle
        mov eax, dword [byte ebp+06Eh]
        mov ecx, dword [byte ebp+06Ah]
        inc eax
        xor esi, esi
        call UpdateWorkingBox
.3:
        mov eax, dword [byte ebp+062h]
        movsx eax, word [eax]
        cmp esi, eax
        jge short .5
        mov edx, esi
        mov eax, dword [byte ebp+062h]
        shl edx, 3
        mov eax, dword [byte eax+014h]
        add eax, edx
        mov edx, dword [byte ebp-02Ah]
        mov ebx, 8
        add edx, ecx
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .4
        mov dword [byte ebp+066h], esi
        mov esi, dword [byte ebp+062h]
        movsx esi, word [esi]
.4:
        inc esi
        jmp short .3
.5:
        jne short .8
.6:
        lea eax, [byte ebp+062h]
        call FreePtr
        mov eax, dword [dword ebp+086h]
        call FreePtr
        call HideWorkingBox
.7:
        xor eax, eax
        jmp near FindRecordByKey_1BC
.8:
        mov edx, dword [byte ebp+066h]
        mov eax, dword [byte ebp+062h]
        mov edi, dword [byte ebp+072h]
        shl edx, 3
        mov esi, dword [byte eax+014h]
        mov edi, dword [byte edi+014h]
        add esi, edx
        add edi, ecx
        movsd
        movsd
        push dword [dword ebp+08Eh]
        mov eax, dword [byte ebp+062h]
        mov edi, dword [byte ebp+072h]
        mov ebx, dword [byte ebp+06Eh]
        mov esi, dword [byte eax+018h]
        mov edi, dword [byte edi+018h]
        mov eax, dword [byte ebp+066h]
        add esi, edx
        add edi, ecx
        mov ecx, dword [byte ebp+072h]
        mov edx, dword [byte ebp-02Eh]
        movsd
        movsd
        call BuildPlayoffRecords
        test eax, eax
        je short .6
        inc dword [byte ebp+06Eh]
        add dword [byte ebp+06Ah], byte 8
        jmp near .2
.9:
        lea eax, [byte ebp+062h]
        call FreePtr
        mov eax, dword [byte ebp+072h]
        movsx ebx, word [byte ebp-022h]
        xor edx, edx
        mov eax, dword [byte eax+020h]
        jmp short .11
.10:
        mov byte [eax], 0FFh
        mov byte [byte eax+01h], 0FFh
        mov byte [byte eax+02h], 0FFh
        mov byte [byte eax+03h], 0FFh
        mov esi, DbKeyBuffer
        mov word [byte eax+04h], 0
        inc edx
        lea edi, [byte eax+08h]
        mov word [byte eax+06h], 0
        add eax, byte 10h
        movsd
        movsd
.11:
        cmp edx, ebx
        jl short .10
        call ServiceIdle
        mov eax, dword [byte ebp+072h]
        push dword [byte eax+08h]
        mov eax, dword [byte eax+04h]
        xor eax, 0AAAAAAAAh
        push eax
        push dword [LeagueFilePrefix]
        push str_S08x03x
        lea eax, [byte ebp-01Eh]
        push eax
        mov ecx, dword [byte ebp+072h]
        lea edx, [byte ebp+05Eh]
        call sprintf_
        add esp, byte 14h
        lea eax, [byte ebp-01Eh]
        mov ecx, dword [byte ecx+08h]
        call FileCreate
        mov edx, eax
        test eax, eax
        je near .16
        movsx eax, word [byte ebp-026h]
        mov ebx, 14h
        inc eax
        mov edx, dword [byte ebp+072h]
        call UpdateWorkingBox
        mov eax, dword [byte ebp+05Eh]
        call FileWriteRecord
        mov edx, eax
        test eax, eax
        je short .12
        mov ebx, dword [byte ebp+072h]
        mov edx, dword [byte ebp+072h]
        mov eax, dword [byte ebp+05Eh]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+014h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.12:
        test edx, edx
        je short .13
        mov ebx, dword [byte ebp+072h]
        mov edx, dword [byte ebp+072h]
        mov eax, dword [byte ebp+05Eh]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+018h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.13:
        test edx, edx
        je short .14
        mov ebx, dword [byte ebp+072h]
        mov edx, dword [byte ebp+072h]
        mov eax, dword [byte ebp+05Eh]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+01Ch]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.14:
        test edx, edx
        je short .15
        mov ebx, dword [byte ebp+072h]
        mov edx, dword [byte ebp+072h]
        mov eax, dword [byte ebp+05Eh]
        movsx ebx, word [byte ebx+02h]
        mov edx, dword [byte edx+020h]
        shl ebx, 4
        call FileWriteRecord
        mov edx, eax
.15:
        lea eax, [byte ebp+05Eh]
        call FileClose
        call ServiceIdle
.16:
        test edx, edx
        je short .17
        movsx eax, word [byte ebp-026h]
        inc eax
        inc eax
        call UpdateWorkingBox
        mov eax, dword [byte ebp+072h]
        lea edx, [byte ebp+032h]
        add eax, byte 4
        call MakeRecordKey
        mov eax, dword [byte ebp+072h]
        lea edx, [byte ebp+032h]
        add eax, byte 0Ch
        lea ebx, [byte ebp+032h]
        call MakeKeyPair
        mov eax, dword [DbKeyIndex]
        xor edx, edx
        call AddIndexKey
        mov edx, eax
        call ServiceIdle
.17:
        test edx, edx
        jne short .18
        mov eax, dword [dword ebp+086h]
        call FreePtr
.18:
        call HideWorkingBox
        mov eax, edx
        jmp near FindRecordByKey_1BC
;-----------------------------------------------------------------------------
; CreateSeasonFile                                DD970  97 PC, low confidence
; Creates the season league file
;-----------------------------------------------------------------------------
CreateSeasonFile:
        push esi
        push edi
        enter 88h, 0
        push eax
        push edx
        push ebx
        sub ebp, byte 7Eh
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near CreateExhibitionFile_325
.2:
        lea edx, [byte ebp+076h]
        mov eax, PlayoffDbKey
        call OpenLeagueFile
        test eax, eax
        je near CreateExhibitionFile_325
        mov eax, dword [byte ebp+076h]
        movsx edx, word [eax]
        imul edx, byte 18h
        movsx eax, word [byte ebp-0Eh]
        shl eax, 4
        add edx, byte 24h
        add edx, eax
        mov eax, str_SCHED
        call AllocClearBlock20
        test eax, eax
        jne short .3
        lea eax, [byte ebp+076h]
        call FreePtr
        jmp short .1
.3:
        mov eax, dword [byte ebp-016h]
        mov eax, dword [eax]
        mov dword [byte ebp+07Ah], eax
        mov eax, dword [byte ebp+076h]
        mov edx, dword [byte ebp+07Ah]
        mov ax, word [eax]
        mov word [edx], ax
        mov eax, dword [byte ebp-0Eh]
        mov word [byte edx+02h], ax
        mov edi, edx
        mov esi, dword [byte ebp+076h]
        lea edi, [byte edi+0Ch]
        lea esi, [byte esi+0Ch]
        mov eax, edx
        add edx, byte 24h
        movsd
        movsd
        mov dword [byte eax+014h], edx
        movsx eax, word [eax]
        mov edx, dword [byte ebp+07Ah]
        shl eax, 3
        mov edx, dword [byte edx+014h]
        add edx, eax
        mov eax, dword [byte ebp+07Ah]
        mov dword [byte eax+018h], edx
        movsx edx, word [eax]
        shl edx, 3
        mov eax, dword [byte eax+018h]
        add eax, edx
        mov edx, dword [byte ebp+07Ah]
        mov dword [byte edx+01Ch], eax
        movsx eax, word [edx]
        shl eax, 3
        mov edx, dword [byte edx+01Ch]
        add edx, eax
        mov eax, dword [byte ebp+07Ah]
        mov dword [byte eax+020h], edx
        movsx ebx, word [eax]
        mov edx, dword [byte eax+014h]
        mov eax, dword [byte ebp+076h]
        shl ebx, 3
        mov eax, dword [byte eax+014h]
        mov edi, dword [byte ebp+07Ah]
        call CopyBytesOk
        mov ebx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp+076h]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+018h]
        mov eax, dword [byte eax+018h]
        shl ebx, 3
        mov esi, ecx
        call CopyBytesOk
        mov eax, dword [byte ebp+07Ah]
        lea edi, [byte edi+04h]
        movsx ebx, word [byte ebp-0Eh]
        movsd
        movsd
        xor edx, edx
        mov eax, dword [byte eax+020h]
        jmp short .5
.4:
        mov byte [eax], 0FFh
        mov byte [byte eax+01h], 0FFh
        mov byte [byte eax+02h], 0FFh
        mov byte [byte eax+03h], 0FFh
        mov esi, DbKeyBuffer
        mov word [byte eax+04h], 0
        inc edx
        lea edi, [byte eax+08h]
        mov word [byte eax+06h], 0
        add eax, byte 10h
        movsd
        movsd
.5:
        cmp edx, ebx
        jl short .4
        call ServiceIdle
        mov eax, dword [byte ebp+076h]
        xor esi, esi
        movsx edx, word [eax]
        mov eax, 243h
        inc edx
        inc edx
        call GetLangText
        call ShowWorkingBox
.6:
        mov eax, dword [byte ebp+076h]
        movsx eax, word [eax]
        cmp esi, eax
        jge short .8
        call ServiceIdle
        lea edi, [byte esi+01h]
        mov ecx, dword [byte ebp+07Ah]
        mov eax, edi
        mov edx, dword [byte ebp-012h]
        call UpdateWorkingBox
        mov ebx, esi
        push dword [dword ebp+08Eh]
        mov eax, esi
        call BuildPlayoffRecords
        test eax, eax
        jne short .7
        mov eax, dword [byte ebp-016h]
        call FreePtr
        call HideWorkingBox
        jmp near .1
.7:
        mov esi, edi
        jmp short .6
.8:
        mov eax, dword [byte ebp+07Ah]
        push dword [byte eax+08h]
        mov eax, dword [byte eax+04h]
        xor eax, 0AAAAAAAAh
        push eax
        push dword [LeagueFilePrefix]
        push str_S08x03x
        lea eax, [byte ebp-0Ah]
        push eax
        mov ecx, dword [byte ebp+07Ah]
        lea edx, [byte ebp+072h]
        call sprintf_
        add esp, byte 14h
        lea eax, [byte ebp-0Ah]
        mov ecx, dword [byte ecx+08h]
        call FileCreate
        mov edx, eax
        test eax, eax
        je near .13
        mov eax, dword [byte ebp+076h]
        movsx eax, word [eax]
        mov ebx, 14h
        inc eax
        mov edx, dword [byte ebp+07Ah]
        call UpdateWorkingBox
        mov eax, dword [byte ebp+072h]
        call FileWriteRecord
        mov edx, eax
        test eax, eax
        je short .9
        mov ebx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp+072h]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+014h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.9:
        test edx, edx
        je short .10
        mov ebx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp+072h]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+018h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.10:
        test edx, edx
        je short .11
        mov ebx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp+072h]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+01Ch]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.11:
        test edx, edx
        je short .12
        mov ebx, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+07Ah]
        mov eax, dword [byte ebp+072h]
        movsx ebx, word [byte ebx+02h]
        mov edx, dword [byte edx+020h]
        shl ebx, 4
        call FileWriteRecord
        mov edx, eax
.12:
        lea eax, [byte ebp+072h]
        call FileClose
        call ServiceIdle
.13:
        test edx, edx
        je short .14
        mov eax, dword [byte ebp+076h]
        movsx eax, word [eax]
        inc eax
        inc eax
        call UpdateWorkingBox
        mov eax, dword [byte ebp+07Ah]
        lea edx, [byte ebp+046h]
        add eax, byte 4
        call MakeRecordKey
        mov eax, dword [byte ebp+07Ah]
        lea edx, [byte ebp+046h]
        add eax, byte 0Ch
        lea ebx, [byte ebp+046h]
        call MakeKeyPair
        mov eax, dword [DbKeyIndex]
        xor edx, edx
        call AddIndexKey
        mov edx, eax
        call ServiceIdle
.14:
        lea eax, [byte ebp+076h]
        call FreePtr
        test edx, edx
        jne near CreateExhibitionFile_31E
        mov eax, dword [byte ebp-016h]
        jmp near CreateExhibitionFile_319
;-----------------------------------------------------------------------------
; CreateSeasonSchedule                            DDC4A  97 PC, low confidence
; Creates the season schedule
;-----------------------------------------------------------------------------
CreateSeasonSchedule:
        push ecx
        push esi
        push edi
        enter 90h, 0
        sub ebp, 82h
        mov ecx, eax
        mov dword [byte ebp+076h], edx
        mov dword [byte ebp+07Ah], ebx
        cmp word [DbOpen], byte 0
        je short .2
        lea edx, [byte ebp+072h]
        mov eax, PlayoffDbKey
        call OpenLeagueFile
        test eax, eax
        je near CreateSeasonSchedule_2F0
        mov eax, dword [byte ebp+072h]
        movsx edx, word [eax]
        imul edx, byte 18h
        movsx eax, cx
        shl eax, 4
        add edx, byte 24h
        add edx, eax
        mov eax, str_SCHED
        call AllocClearBlock20
        test eax, eax
        jne short .3
        lea eax, [byte ebp+072h]
.1:
        call FreePtr
.2:
        xor eax, eax
        jmp near CreateSeasonSchedule_2F0
.3:
        mov eax, dword [byte ebp+07Ah]
        mov eax, dword [eax]
        mov dword [byte ebp+07Eh], eax
        mov eax, dword [byte ebp+072h]
        mov edx, dword [byte ebp+07Eh]
        mov ax, word [eax]
        mov word [edx], ax
        mov word [byte edx+02h], cx
        mov edi, edx
        mov esi, dword [byte ebp+072h]
        lea edi, [byte edi+0Ch]
        lea esi, [byte esi+0Ch]
        mov eax, edx
        add edx, byte 24h
        movsd
        movsd
        mov dword [byte eax+014h], edx
        movsx eax, word [eax]
        mov edx, dword [byte ebp+07Eh]
        shl eax, 3
        mov edx, dword [byte edx+014h]
        add edx, eax
        mov eax, dword [byte ebp+07Eh]
        mov dword [byte eax+018h], edx
        movsx eax, word [eax]
        mov edx, dword [byte ebp+07Eh]
        shl eax, 3
        mov edx, dword [byte edx+018h]
        add edx, eax
        mov eax, dword [byte ebp+07Eh]
        mov dword [byte eax+01Ch], edx
        movsx edx, word [eax]
        shl edx, 3
        mov eax, dword [byte eax+01Ch]
        add eax, edx
        mov edx, dword [byte ebp+07Eh]
        mov dword [byte edx+020h], eax
        movsx ebx, word [edx]
        mov eax, dword [byte ebp+072h]
        shl ebx, 3
        mov edx, dword [byte edx+014h]
        mov eax, dword [byte eax+014h]
        call CopyBytesOk
        mov ebx, dword [byte ebp+07Eh]
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [byte ebp+072h]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+018h]
        mov eax, dword [byte eax+018h]
        shl ebx, 3
        call CopyBytesOk
        mov edx, dword [byte ebp+07Eh]
        xor eax, eax
        add edx, byte 4
        call MakeLeagueKey
        test eax, eax
        jne short .4
        mov eax, dword [byte ebp+07Ah]
        jmp near .1
.4:
        mov eax, dword [byte ebp+07Eh]
        movsx ebx, cx
        xor edx, edx
        mov eax, dword [byte eax+020h]
        jmp short .6
.5:
        mov byte [eax], 0FFh
        mov byte [byte eax+01h], 0FFh
        mov byte [byte eax+02h], 0FFh
        mov byte [byte eax+03h], 0FFh
        mov esi, DbKeyBuffer
        mov word [byte eax+04h], 0
        inc edx
        lea edi, [byte eax+08h]
        mov word [byte eax+06h], 0
        add eax, byte 10h
        movsd
        movsd
.6:
        cmp edx, ebx
        jl short .5
        call ServiceIdle
        mov eax, dword [byte ebp+072h]
        xor esi, esi
        movsx edx, word [eax]
        mov eax, 243h
        inc edx
        inc edx
        call GetLangText
        call ShowWorkingBox
.7:
        mov eax, dword [byte ebp+072h]
        movsx eax, word [eax]
        cmp esi, eax
        jge short .9
        call ServiceIdle
        lea edi, [byte esi+01h]
        mov ecx, dword [byte ebp+07Eh]
        mov eax, edi
        mov edx, dword [byte ebp+076h]
        call UpdateWorkingBox
        push DbKeyBuffer
        mov ebx, esi
        mov eax, esi
        call BuildPlayoffRecords
        test eax, eax
        jne short .8
        mov eax, dword [byte ebp+07Ah]
        call FreePtr
        call HideWorkingBox
        jmp near .2
.8:
        mov esi, edi
        jmp short .7
.9:
        mov eax, dword [byte ebp+07Eh]
        push dword [byte eax+08h]
        mov eax, dword [byte eax+04h]
        xor eax, 0AAAAAAAAh
        push eax
        push dword [LeagueFilePrefix]
        push str_S08x03x
        lea eax, [byte ebp-0Eh]
        push eax
        mov ecx, dword [byte ebp+07Eh]
        lea edx, [byte ebp+06Eh]
        call sprintf_
        add esp, byte 14h
        lea eax, [byte ebp-0Eh]
        mov ecx, dword [byte ecx+08h]
        call FileCreate
        mov edx, eax
        test eax, eax
        je near .14
        mov eax, dword [byte ebp+072h]
        movsx eax, word [eax]
        mov ebx, 14h
        inc eax
        mov edx, dword [byte ebp+07Eh]
        call UpdateWorkingBox
        mov eax, dword [byte ebp+06Eh]
        call FileWriteRecord
        mov edx, eax
        test eax, eax
        je short .10
        mov ebx, dword [byte ebp+07Eh]
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [byte ebp+06Eh]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+014h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.10:
        test edx, edx
        je short .11
        mov ebx, dword [byte ebp+07Eh]
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [byte ebp+06Eh]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+018h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.11:
        test edx, edx
        je short .12
        mov ebx, dword [byte ebp+07Eh]
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [byte ebp+06Eh]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+01Ch]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.12:
        test edx, edx
        je short .13
        mov ebx, dword [byte ebp+07Eh]
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [byte ebp+06Eh]
        movsx ebx, word [byte ebx+02h]
        mov edx, dword [byte edx+020h]
        shl ebx, 4
        call FileWriteRecord
        mov edx, eax
.13:
        lea eax, [byte ebp+06Eh]
        call FileClose
        call ServiceIdle
.14:
        test edx, edx
        je short .15
        mov eax, dword [byte ebp+072h]
        movsx eax, word [eax]
        inc eax
        inc eax
        call UpdateWorkingBox
        mov eax, dword [byte ebp+07Eh]
        lea edx, [byte ebp+042h]
        add eax, byte 4
        call MakeRecordKey
        mov eax, dword [byte ebp+07Eh]
        lea edx, [byte ebp+042h]
        add eax, byte 0Ch
        lea ebx, [byte ebp+042h]
        call MakeKeyPair
        mov eax, dword [DbKeyIndex]
        xor edx, edx
        call AddIndexKey
        mov edx, eax
        call ServiceIdle
.15:
        lea eax, [byte ebp+072h]
        call FreePtr
        test edx, edx
        jne short .17
        mov eax, dword [byte ebp+07Ah]
.16:
        call FreePtr
.17:
        call HideWorkingBox
        mov eax, edx
CreateSeasonSchedule_2F0:
        lea esp, [dword ebp+082h]
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        push ecx
        push esi
        push edi
        enter 8Ch, 0
        sub ebp, 82h
        mov ecx, eax
        mov dword [byte ebp+07Ah], edx
        mov dword [byte ebp+076h], ebx
        cmp word [DbOpen], byte 0
        jne short .19
.18:
        xor eax, eax
        jmp short CreateSeasonSchedule_2F0
.19:
        movsx eax, word [edx]
        imul edx, eax, byte 18h
        movsx eax, cx
        add edx, byte 24h
        shl eax, 4
        add edx, eax
        mov eax, str_SCHED
        call AllocClearBlock20
        test eax, eax
        je short CreateSeasonSchedule_2F0
        mov eax, dword [byte ebp+076h]
        mov eax, dword [eax]
        mov dword [byte ebp+07Eh], eax
        mov eax, dword [byte ebp+07Ah]
        mov edx, dword [byte ebp+07Eh]
        mov ax, word [eax]
        mov word [edx], ax
        mov edi, edx
        mov word [byte edx+02h], cx
        mov esi, dword [byte ebp+07Ah]
        lea edi, [byte edi+0Ch]
        lea esi, [byte esi+0Ch]
        mov eax, edx
        add edx, byte 24h
        movsd
        movsd
        mov dword [byte eax+014h], edx
        mov edx, eax
        movsx edx, word [edx]
        mov eax, dword [byte eax+014h]
        shl edx, 3
        add eax, edx
        mov edx, dword [byte ebp+07Eh]
        mov dword [byte edx+018h], eax
        movsx eax, word [edx]
        shl eax, 3
        mov edx, dword [byte edx+018h]
        add edx, eax
        mov eax, dword [byte ebp+07Eh]
        mov dword [byte eax+01Ch], edx
        movsx eax, word [eax]
        mov edx, dword [byte ebp+07Eh]
        shl eax, 3
        mov edx, dword [byte edx+01Ch]
        add edx, eax
        mov eax, dword [byte ebp+07Eh]
        mov dword [byte eax+020h], edx
        movsx ebx, word [eax]
        mov edx, dword [byte eax+014h]
        mov eax, dword [byte ebp+07Ah]
        shl ebx, 3
        mov eax, dword [byte eax+014h]
        call CopyBytesOk
        mov ebx, dword [byte ebp+07Eh]
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [byte ebp+07Ah]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+018h]
        mov eax, dword [byte eax+018h]
        shl ebx, 3
        call CopyBytesOk
        mov edx, dword [byte ebp+07Eh]
        xor eax, eax
        add edx, byte 4
        call MakeLeagueKey
        test eax, eax
        jne short .20
        mov eax, dword [byte ebp+076h]
        call FreePtr
        jmp near .18
.20:
        mov eax, dword [byte ebp+07Eh]
        movsx ebx, cx
        xor edx, edx
        mov eax, dword [byte eax+020h]
        jmp short .22
.21:
        mov byte [eax], 0FFh
        mov byte [byte eax+01h], 0FFh
        mov byte [byte eax+02h], 0FFh
        mov byte [byte eax+03h], 0FFh
        mov esi, DbKeyBuffer
        mov word [byte eax+04h], 0
        inc edx
        lea edi, [byte eax+08h]
        mov word [byte eax+06h], 0
        add eax, byte 10h
        movsd
        movsd
.22:
        cmp edx, ebx
        jl short .21
        mov edx, dword [byte ebp+07Ah]
        call ServiceIdle
        mov eax, 243h
        movsx edx, word [edx]
        xor esi, esi
        inc edx
        inc edx
        call GetLangText
        call ShowWorkingBox
.23:
        mov eax, dword [byte ebp+07Ah]
        movsx eax, word [eax]
        cmp esi, eax
        jge short .25
        call ServiceIdle
        mov ecx, dword [byte ebp+07Eh]
        lea eax, [byte esi+01h]
        mov edx, dword [byte ebp+07Ah]
        call UpdateWorkingBox
        mov ebx, esi
        mov eax, esi
        call BuildSeasonRecords
        test eax, eax
        jne short .24
        mov esi, dword [byte ebp+07Ah]
        movsx esi, word [esi]
.24:
        inc esi
        jmp short .23
.25:
        je short .26
        mov eax, dword [byte ebp+076h]
        call FreePtr
        call HideWorkingBox
        jmp near .18
.26:
        mov eax, dword [byte ebp+07Eh]
        push dword [byte eax+08h]
        mov eax, dword [byte eax+04h]
        xor eax, 0AAAAAAAAh
        push eax
        push dword [LeagueFilePrefix]
        push str_S08x03x
        lea eax, [byte ebp-0Ah]
        push eax
        mov ecx, dword [byte ebp+07Eh]
        lea edx, [byte ebp+072h]
        call sprintf_
        add esp, byte 14h
        lea eax, [byte ebp-0Ah]
        mov ecx, dword [byte ecx+08h]
        call FileCreate
        mov edx, eax
        test eax, eax
        je near .31
        mov eax, dword [byte ebp+07Ah]
        movsx eax, word [eax]
        mov ebx, 14h
        inc eax
        mov edx, dword [byte ebp+07Eh]
        call UpdateWorkingBox
        mov eax, dword [byte ebp+072h]
        call FileWriteRecord
        mov edx, eax
        test eax, eax
        je short .27
        mov ebx, dword [byte ebp+07Eh]
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [byte ebp+072h]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+014h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.27:
        test edx, edx
        je short .28
        mov ebx, dword [byte ebp+07Eh]
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [byte ebp+072h]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+018h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.28:
        test edx, edx
        je short .29
        mov ebx, dword [byte ebp+07Eh]
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [byte ebp+072h]
        movsx ebx, word [ebx]
        mov edx, dword [byte edx+01Ch]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.29:
        test edx, edx
        je short .30
        mov ebx, dword [byte ebp+07Eh]
        mov edx, dword [byte ebp+07Eh]
        mov eax, dword [byte ebp+072h]
        movsx ebx, word [byte ebx+02h]
        mov edx, dword [byte edx+020h]
        shl ebx, 4
        call FileWriteRecord
        mov edx, eax
.30:
        lea eax, [byte ebp+072h]
        call FileClose
        call ServiceIdle
.31:
        test edx, edx
        je short .32
        mov eax, dword [byte ebp+07Ah]
        movsx eax, word [eax]
        inc eax
        inc eax
        call UpdateWorkingBox
        mov eax, dword [byte ebp+07Eh]
        lea edx, [byte ebp+046h]
        add eax, byte 4
        call MakeRecordKey
        mov eax, dword [byte ebp+07Eh]
        lea edx, [byte ebp+046h]
        add eax, byte 0Ch
        lea ebx, [byte ebp+046h]
        call MakeKeyPair
        mov eax, dword [DbKeyIndex]
        xor edx, edx
        call AddIndexKey
        mov edx, eax
        call ServiceIdle
.32:
        test edx, edx
        jne near CreateSeasonSchedule.17
        mov eax, dword [byte ebp+076h]
        jmp near CreateSeasonSchedule.16
;-----------------------------------------------------------------------------
; ScheduleEntryMatches                            DE20B  97 PC, low confidence
; Returns whether a schedule entry matches
;-----------------------------------------------------------------------------
ScheduleEntryMatches:
        push ecx
        push esi
        push edi
        enter 8, 0
        mov ecx, eax
        mov dword [byte ebp-08h], edx
        mov esi, ebx
        xor edi, edi
        mov dword [byte ebp-04h], edi
.1:
        movsx eax, word [ecx]
        cmp edi, eax
        jge short .3
        mov ebx, 8
        mov eax, dword [byte ecx+014h]
        mov edx, dword [byte ebp-08h]
        add eax, dword [byte ebp-04h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .2
        mov eax, 1
        mov word [esi], di
        leave
        pop edi
        pop esi
        pop ecx
        ret
.2:
        add dword [byte ebp-04h], byte 8
        inc edi
        jmp short .1
.3:
        xor eax, eax
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; FindNextSeasonGame                              DE25F  97 PC, low confidence
; Finds the next game of the season
;-----------------------------------------------------------------------------
FindNextSeasonGame:
        push ecx
        push esi
        push edi
        enter 4, 0
        mov ecx, eax
        mov esi, ebx
        lea ebx, [byte ebp-04h]
        call ScheduleEntryMatches
        test eax, eax
        je short .5
        xor edx, edx
        xor ebx, ebx
.1:
        movsx eax, word [byte ecx+02h]
        cmp ebx, eax
        jge short .4
        mov eax, dword [byte ecx+020h]
        add eax, edx
        movsx di, byte [eax]
        cmp di, word [byte ebp-04h]
        je short .2
        movsx ax, byte [byte eax+01h]
        cmp ax, word [byte ebp-04h]
        jne short .3
.2:
        mov eax, dword [byte ecx+020h]
        movsx eax, byte [byte edx+eax+02h]
        cmp eax, byte 0FFFFFFFFh
        jne short .3
        mov eax, 1
        mov word [esi], bx
        leave
        pop edi
        pop esi
        pop ecx
        ret
.3:
        inc ebx
        add edx, byte 10h
        jmp short .1
.4:
        xor eax, eax
.5:
        leave
        pop edi
        pop esi
        pop ecx
        ret
        push ecx
        push esi
        push edi
        enter 4, 0
        mov esi, eax
        mov ecx, ebx
        mov word [ebx], 0
        lea ebx, [byte ebp-04h]
        call ScheduleEntryMatches
        test eax, eax
        je short .10
        xor edx, edx
        xor ebx, ebx
.6:
        movsx eax, word [byte esi+02h]
        cmp ebx, eax
        jge short .9
        mov eax, dword [byte esi+020h]
        add eax, edx
        movsx di, byte [eax]
        cmp di, word [byte ebp-04h]
        je short .7
        movsx ax, byte [byte eax+01h]
        cmp ax, word [byte ebp-04h]
        jne short .8
.7:
        inc word [ecx]
.8:
        inc ebx
        add edx, byte 10h
        jmp short .6
.9:
        mov eax, 1
.10:
        leave
        pop edi
        pop esi
        pop ecx
        ret
        push ecx
        push esi
        push edi
        enter 4, 0
        mov ecx, eax
        mov esi, ebx
        lea ebx, [byte ebp-04h]
        call ScheduleEntryMatches
        test eax, eax
        je short .15
        xor ebx, ebx
        xor edx, edx
.11:
        movsx eax, word [byte ecx+02h]
        cmp edx, eax
        jge short .14
        mov eax, dword [byte ecx+020h]
        add eax, ebx
        movsx di, byte [eax]
        cmp di, word [byte ebp-04h]
        je short .12
        movsx ax, byte [byte eax+01h]
        cmp ax, word [byte ebp-04h]
        jne short .13
.12:
        mov word [esi], dx
        inc esi
        inc esi
.13:
        inc edx
        add ebx, byte 10h
        jmp short .11
.14:
        mov eax, 1
.15:
        leave
        pop edi
        pop esi
        pop ecx
        ret
        push ebx
        push ecx
        push edx
        push esi
        enter 30h, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .16
        xor eax, eax
        jmp near UpdatePlayerRecord_229
.16:
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov dword [eax], 0
        xor edx, edx
        mov eax, dword [DbKeyIndex]
        call FindLastKey
.17:
        test eax, eax
        je near UpdatePlayerRecord_229
        cmp byte [byte ebp-030h], 0
        je near LookupRecord_30C
        cmp dword [byte ebp-04h], byte 0FFFFFFFFh
        je near LookupRecord_30C
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        inc dword [esi]
        xor edx, edx
        mov eax, dword [DbKeyIndex]
        call NextIndexKey
        jmp short .17
;-----------------------------------------------------------------------------
; OpenLeagueFile                                  DE3CF  97 PC, low confidence
; (league id, ...): opens a season / playoff file ("%s%s.SEA", "%s%s.PLY" or "%s%08x.%03x") and reads its
; header; from the season, playoff and stats screens
;-----------------------------------------------------------------------------
OpenLeagueFile:
        push ebx
        push ecx
        push esi
        enter 5Ch, 0
        mov esi, edx
        cmp word [DbOpen], byte 0
        je near .6
        cmp dword [eax], byte 0
        jne short .2
        cmp dword [byte eax+04h], byte 0
        jne short .2
        push dword [LeagueFileDir]
        push dword [LeagueFilePrefix]
        push str_SSSEA
.1:
        lea eax, [byte ebp-05Ch]
        push eax
        call sprintf_
        add esp, byte 10h
        jmp short .4
.2:
        cmp dword [eax], byte 0
        jne short .3
        cmp dword [byte eax+04h], byte 1
        jne short .3
        push dword [LeagueFileDir]
        push dword [LeagueFilePrefix]
        push str_SSPLY
        jmp short .1
.3:
        push dword [byte eax+04h]
        mov eax, dword [eax]
        xor eax, 0AAAAAAAAh
        push eax
        push dword [LeagueFilePrefix]
        push str_S08x03x
        lea eax, [byte ebp-05Ch]
        push eax
        call sprintf_
        add esp, byte 14h
.4:
        lea eax, [byte ebp-05Ch]
        call FileExists
        test eax, eax
        je near .13
        lea edx, [byte ebp-0Ch]
        lea eax, [byte ebp-05Ch]
        call FileOpen
        test eax, eax
        je near .13
        mov ebx, 2
        lea edx, [byte ebp-08h]
        mov eax, dword [byte ebp-0Ch]
        call FileReadRecord
        test eax, eax
        jne short .7
.5:
        lea eax, [byte ebp-0Ch]
        call FileClose
.6:
        xor eax, eax
        leave
        pop esi
        pop ecx
        pop ebx
        ret
.7:
        mov ebx, 2
        lea edx, [byte ebp-04h]
        mov eax, dword [byte ebp-0Ch]
        call FileReadRecord
        test eax, eax
        je short .5
        mov eax, dword [byte ebp-0Ch]
        xor edx, edx
        call FileSeek
        test eax, eax
        je short .5
        call ServiceIdle
        movsx eax, word [byte ebp-08h]
        imul eax, byte 18h
        movsx edx, word [byte ebp-04h]
        shl edx, 4
        add eax, byte 24h
        mov ebx, esi
        add edx, eax
        mov eax, str_SCHED
        call AllocClearBlock20
        test eax, eax
        je near .13
        mov ecx, dword [esi]
        lea eax, [byte ecx+024h]
        mov dword [byte ecx+014h], eax
        movsx eax, word [byte ebp-08h]
        mov edx, dword [byte ecx+014h]
        shl eax, 3
        add edx, eax
        mov dword [byte ecx+018h], edx
        movsx eax, word [byte ebp-08h]
        shl eax, 3
        add edx, eax
        mov dword [byte ecx+01Ch], edx
        movsx edx, word [byte ebp-08h]
        mov eax, dword [byte ecx+01Ch]
        shl edx, 3
        add eax, edx
        mov ebx, 14h
        mov dword [byte ecx+020h], eax
        mov edx, ecx
        mov eax, dword [byte ebp-0Ch]
        call FileReadRecord
        mov edx, eax
        test eax, eax
        je short .8
        mov eax, dword [byte ebp-0Ch]
        movsx ebx, word [ecx]
        mov edx, dword [byte ecx+014h]
        shl ebx, 3
        call FileReadRecord
        mov edx, eax
.8:
        test edx, edx
        je short .9
        mov eax, dword [byte ebp-0Ch]
        movsx ebx, word [ecx]
        mov edx, dword [byte ecx+018h]
        shl ebx, 3
        call FileReadRecord
        mov edx, eax
.9:
        test edx, edx
        je short .10
        mov eax, dword [byte ebp-0Ch]
        movsx ebx, word [ecx]
        mov edx, dword [byte ecx+01Ch]
        shl ebx, 3
        call FileReadRecord
        mov edx, eax
.10:
        test edx, edx
        je short .11
        mov eax, dword [byte ebp-0Ch]
        movsx ebx, word [byte ecx+02h]
        mov edx, dword [byte ecx+020h]
        shl ebx, 4
        call FileReadRecord
        mov edx, eax
.11:
        lea eax, [byte ebp-0Ch]
        call FileClose
        test edx, edx
        jne short .12
        mov eax, esi
        call FreePtr
.12:
        call ServiceIdle
        mov eax, edx
.13:
        leave
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; WriteLeagueHeader                               DE5A3  97 PC, low confidence
; Writes the league file header
;-----------------------------------------------------------------------------
WriteLeagueHeader:
        push ebx
        push ecx
        push edx
        enter 54h, 0
        mov ecx, eax
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor edx, edx
        jmp near .13
.2:
        push dword [byte eax+08h]
        mov eax, dword [byte eax+04h]
        xor eax, 0AAAAAAAAh
        push eax
        push dword [LeagueFilePrefix]
        push str_S08x03x
        lea eax, [byte ebp-054h]
        push eax
        call sprintf_
        add esp, byte 14h
        call ServiceIdle
        lea eax, [byte ebp-054h]
        call FileExists
        test eax, eax
        jne near .7
        mov eax, dword [byte ecx+04h]
        cmp eax, dword [StaticBuffer]
        je short .1
        lea edx, [byte ebp-04h]
        lea eax, [byte ebp-054h]
        call FileCreate
        mov edx, eax
        test eax, eax
        je near .13
        mov ebx, 14h
        mov eax, dword [byte ebp-04h]
        mov edx, ecx
        call FileWriteRecord
        mov edx, eax
        test eax, eax
        je short .3
        mov eax, dword [byte ebp-04h]
        movsx ebx, word [ecx]
        mov edx, dword [byte ecx+014h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.3:
        test edx, edx
        je short .4
        mov eax, dword [byte ebp-04h]
        movsx ebx, word [ecx]
        mov edx, dword [byte ecx+018h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.4:
        test edx, edx
        je short .5
        mov eax, dword [byte ebp-04h]
        movsx ebx, word [ecx]
        mov edx, dword [byte ecx+01Ch]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.5:
        test edx, edx
        je short .6
        mov eax, dword [byte ebp-04h]
        movsx ebx, word [byte ecx+02h]
        mov edx, dword [byte ecx+020h]
        shl ebx, 4
        call FileWriteRecord
        mov edx, eax
.6:
        lea eax, [byte ebp-04h]
        call FileClose
        jmp near .13
.7:
        lea edx, [byte ebp-04h]
        lea eax, [byte ebp-054h]
        call FileOpen
        test eax, eax
        je near .1
        mov eax, dword [byte ebp-04h]
        xor edx, edx
        call FileSeek
        test eax, eax
        jne short .8
        lea eax, [byte ebp-04h]
        call FileClose
        jmp near .1
.8:
        mov ebx, 14h
        mov eax, dword [byte ebp-04h]
        mov edx, ecx
        call FileWriteRecord
        mov edx, eax
        test eax, eax
        je short .9
        mov eax, dword [byte ebp-04h]
        movsx ebx, word [ecx]
        mov edx, dword [byte ecx+014h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.9:
        test edx, edx
        je short .10
        mov eax, dword [byte ebp-04h]
        movsx ebx, word [ecx]
        mov edx, dword [byte ecx+018h]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.10:
        test edx, edx
        je short .11
        mov eax, dword [byte ebp-04h]
        movsx ebx, word [ecx]
        mov edx, dword [byte ecx+01Ch]
        shl ebx, 3
        call FileWriteRecord
        mov edx, eax
.11:
        test edx, edx
        je short .12
        mov eax, dword [byte ebp-04h]
        movsx ebx, word [byte ecx+02h]
        mov edx, dword [byte ecx+020h]
        shl ebx, 4
        call FileWriteRecord
        mov edx, eax
.12:
        lea eax, [byte ebp-04h]
        call FileClose
        call ServiceIdle
.13:
        mov eax, edx
        leave
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; StartSeasonGame                                 DE740  97 PC, low confidence
; Starts the next season game
;-----------------------------------------------------------------------------
StartSeasonGame:
        push ecx
        push esi
        push edi
        enter 4, 0
        push eax
        push ebx
        cmp dx, word [byte eax+02h]
        jle short .2
.1:
        xor eax, eax
        leave
        pop edi
        pop esi
        pop ecx
        ret
.2:
        movsx eax, dx
        mov ecx, dword [byte ebp-08h]
        shl eax, 4
        mov ecx, dword [byte ecx+020h]
        add ecx, eax
        movsx eax, byte [byte ecx+02h]
        cmp eax, byte 0FFFFFFFFh
        jne short .1
        mov ebx, 8
        mov edx, DbKeyBuffer
        lea eax, [byte ecx+08h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je near .5
        cmp byte [ecx], 0
        jl short .1
        mov edx, dword [byte ebp-08h]
        movsx ax, byte [ecx]
        cmp ax, word [edx]
        jge short .1
        cmp byte [byte ecx+01h], 0
        jl short .1
        movsx ax, byte [byte ecx+01h]
        cmp ax, word [edx]
        jge short .1
        mov edx, 4A78h
        mov eax, dword [byte ebp-0Ch]
        mov edi, dword [byte ebp-0Ch]
        mov esi, DbKeyBuffer
        call ZeroBytesOk
        movsd
        movsd
        mov edi, dword [byte ebp-0Ch]
        mov esi, dword [byte ebp-08h]
        lea edi, [byte edi+08h]
        lea esi, [byte esi+04h]
        movsd
        movsd
        mov edx, dword [byte ebp-0Ch]
        mov ax, word [byte ecx+04h]
        mov word [byte edx+010h], ax
        mov ax, word [byte ecx+06h]
        mov word [byte edx+012h], ax
        call ServiceIdle
        lea eax, [dword edx+04270h]
        mov word [dword edx+0426Eh], 0
        mov edx, 800h
        lea ebx, [byte ebp-04h]
        call ZeroBytesOk
        mov edx, 329Eh
        mov eax, str_TEMP2
        call AllocClearBlock20
        test eax, eax
        je short .5
        movsx eax, byte [ecx]
        mov edx, dword [byte ebp-08h]
        shl eax, 3
        mov edx, dword [byte edx+01Ch]
        add eax, edx
        mov edx, dword [byte ebp-04h]
        mov esi, dword [byte ebp-04h]
        call FindGameRecord
        mov ebx, eax
        mov edx, eax
        mov eax, dword [byte ebp-04h]
        mov edi, dword [byte ebp-0Ch]
        mov ax, word [dword eax+0D07h]
        add esi, 194Fh
        mov word [byte edi+014h], ax
        test ebx, ebx
        je short .3
        movsx eax, byte [byte ecx+01h]
        mov edx, dword [byte ebp-08h]
        shl eax, 3
        mov edx, dword [byte edx+01Ch]
        add eax, edx
        mov edx, esi
        call FindGameRecord
        mov edx, eax
.3:
        test edx, edx
        je short .4
        mov ebx, dword [byte ebp-0Ch]
        mov eax, dword [byte ebp-04h]
        mov edx, esi
        call LoadGameRosters
        mov edx, eax
.4:
        lea eax, [byte ebp-04h]
        call FreePtr
        mov eax, edx
.5:
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; RecordHomeStats                                 DE88E  97 PC, low confidence
; Records the home team's game stats
;-----------------------------------------------------------------------------
RecordHomeStats:
        push ebx
        push ecx
        push esi
        push edi
        enter 68h, 0
        mov ecx, eax
        mov esi, edx
        mov ebx, 8
        add edx, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je near FindGameRecord_A0
        lea edx, [byte ebp-028h]
        lea eax, [byte esi+028h]
        call FindPlayerStat
        test eax, eax
        je near FindGameRecord_A0
        mov ebx, 17h
        lea edi, [dword ecx+0E6h]
        lea edx, [byte ebp-018h]
        mov eax, edi
        call memcmp_
        test eax, eax
        je short .1
        mov ebx, 17h
        lea edx, [byte ebp-018h]
        mov eax, edi
        call CopyBytesOk
        lea eax, [byte ebp-028h]
        call UpdatePlayerStat
        test eax, eax
        je near FindGameRecord_A0
.1:
        call ServiceIdle
        lea edx, [byte ebp-068h]
        lea eax, [byte esi+020h]
        call FindTeamStat
        test eax, eax
        je near FindGameRecord_A0
        cmp byte [dword ecx+0BEh], 2
        jae short .2
        inc word [byte ebp-050h]
.2:
        mov ax, word [dword ecx+0FDh]
        add word [byte ebp-04Eh], ax
        mov ax, word [dword ecx+0FFh]
        add word [byte ebp-04Ch], ax
        mov ax, word [dword ecx+0FDh]
        add ax, word [dword ecx+0FFh]
        add word [byte ebp-04Ah], ax
        mov ax, word [dword ecx+0107h]
        add word [byte ebp-048h], ax
        mov ax, word [dword ecx+0109h]
        add word [byte ebp-046h], ax
        cmp byte [dword ecx+0124h], 0
        je short .3
        movzx eax, byte [dword ecx+0124h]
        inc word [byte ebp+eax*2-040h]
.3:
        mov ax, word [dword ecx+0101h]
        add word [byte ebp-044h], ax
        mov ax, word [dword ecx+0103h]
        add word [byte ebp-040h], ax
        mov ax, word [dword ecx+010Bh]
        add word [byte ebp-042h], ax
        cmp word [byte ebp-04Eh], byte 0
        jne short .4
        cmp word [byte ebp-04Ch], byte 0
        je short .6
.4:
        inc word [byte ebp-032h]
        mov eax, dword [byte ebp-032h]
        cmp ax, word [byte ebp-036h]
        jle short .5
        mov word [byte ebp-036h], ax
.5:
        cmp word [byte ebp-04Eh], byte 0
        je short .7
        inc word [byte ebp-034h]
        mov eax, dword [byte ebp-034h]
        cmp ax, word [byte ebp-038h]
        jle short .7
        mov word [byte ebp-038h], ax
        jmp short .7
.6:
        mov word [byte ebp-032h], 0
        mov word [byte ebp-034h], 0
.7:
        lea eax, [byte ebp-068h]
        call UpdateTeamStat
RecordHomeStats_15A:
        test eax, eax
        jne near LookupRecord_249
        jmp near FindGameRecord_A0
;-----------------------------------------------------------------------------
; RecordAwayStats                                 DE9F5  97 PC, low confidence
; Records the away team's game stats
;-----------------------------------------------------------------------------
RecordAwayStats:
        push esi
        push edi
        enter 70h, 0
        mov esi, eax
        mov edi, edx
        mov dword [byte ebp-08h], ebx
        mov dword [byte ebp-04h], ecx
        mov ebx, 8
        add edx, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je near .11
        lea edx, [byte ebp-030h]
        lea eax, [byte edi+028h]
        call FindPlayerStat
        test eax, eax
        je near .11
        mov ebx, 13h
        lea ecx, [dword esi+0E6h]
        lea edx, [byte ebp-020h]
        mov eax, ecx
        call memcmp_
        test eax, eax
        je short .1
        mov ebx, 13h
        lea edx, [byte ebp-020h]
        mov eax, ecx
        call CopyBytesOk
        lea eax, [byte ebp-030h]
        call UpdatePlayerStat
        test eax, eax
        je near .11
.1:
        lea edx, [byte ebp-070h]
        lea eax, [byte edi+020h]
        call FindTeamStat
        test eax, eax
        je near .11
        call ServiceIdle
        cmp word [dword esi+0FDh], byte 0
        je short .2
        inc word [byte ebp-058h]
.2:
        movsx eax, word [dword esi+0FDh]
        add dword [byte ebp-046h], eax
        cmp byte [dword esi+0124h], 0
        je short .3
        movzx eax, byte [dword esi+0124h]
        inc word [byte ebp+eax*2-03Ch]
.3:
        cmp byte [dword esi+0109h], 0
        je short .6
        cmp dword [byte ebp-08h], byte 0
        je short .4
        inc word [byte ebp-056h]
        jmp short .6
.4:
        cmp dword [byte ebp-04h], byte 0
        je short .5
        inc word [byte ebp-052h]
        jmp short .6
.5:
        inc word [byte ebp-054h]
.6:
        cmp word [dword esi+0105h], byte 0
        je short .7
        mov ax, word [dword esi+0105h]
        add word [byte ebp-042h], ax
        mov ax, word [dword esi+0107h]
        add word [byte ebp-048h], ax
        cmp dword [byte ebp-046h], byte 0
        je short .9
        movsx eax, word [byte ebp-042h]
        imul eax, dword 36EE80h
        cdq
        idiv dword [byte ebp-046h]
        add eax, byte 5
        cwde
        mov ecx, 0Ah
        cdq
        idiv ecx
        jmp short .8
.7:
        cmp word [dword esi+0FDh], byte 0
        je short .9
        mov ax, word [dword esi+0107h]
        add word [byte ebp-048h], ax
        movsx eax, word [byte ebp-042h]
        imul eax, dword 36EE80h
        cdq
        idiv dword [byte ebp-046h]
        add eax, byte 5
        cwde
        mov ecx, 0Ah
        cdq
        idiv ecx
        inc word [byte ebp-050h]
.8:
        mov word [byte ebp-040h], ax
.9:
        mov ax, word [dword esi+0101h]
        add word [byte ebp-04Eh], ax
        mov ax, word [dword esi+0103h]
        add word [byte ebp-04Ch], ax
        mov ax, word [dword esi+0FFh]
        add word [byte ebp-03Eh], ax
        cmp word [dword esi+0FFh], byte 0
        je short .10
        mov ax, word [dword esi+0FFh]
        sub ax, word [dword esi+0105h]
        add word [byte ebp-03Ch], ax
.10:
        lea eax, [byte ebp-070h]
        call UpdateTeamStat
        test eax, eax
        je short .11
        mov eax, 1
.11:
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; RecordGameResult                                DEBA2  97 PC, low confidence
; Records the result of a game
;-----------------------------------------------------------------------------
RecordGameResult:
        push ecx
        push esi
        push edi
        enter 38h, 0
        mov ecx, eax
        mov esi, edx
        mov edi, ebx
        lea eax, [byte edx+04Eh]
        inc word [eax]
        mov dword [byte ebp-014h], 0
        mov dl, byte [byte ecx+026h]
        mov dword [byte ebp-01Ch], 0
        cmp dl, byte [byte ecx+027h]
        jbe near .5
        mov dword [byte ebp-014h], 1
        test ebx, ebx
        je short .3
        mov word [byte eax+031h], 0
        mov word [byte eax+035h], 0
        inc byte [byte eax+0Ah]
        inc word [byte eax+029h]
        inc byte [byte eax+02h]
.1:
        mov dx, word [byte eax+029h]
        cmp dx, word [byte eax+02Bh]
        jle short .2
        mov word [byte eax+02Bh], dx
.2:
        inc word [byte eax+02Dh]
        mov dx, word [byte eax+02Dh]
        cmp dx, word [byte eax+02Fh]
        jle near .11
        jmp near .10
.3:
        mov word [byte eax+029h], 0
        mov word [byte eax+02Dh], 0
        inc byte [byte eax+03h]
        inc word [byte eax+031h]
        inc byte [byte eax+0Bh]
        mov dx, word [byte eax+031h]
        cmp dx, word [byte eax+033h]
        jle short .4
        mov word [byte eax+033h], dx
.4:
        inc word [byte eax+035h]
        mov dx, word [byte eax+035h]
        cmp dx, word [byte eax+037h]
        jle near .11
        mov word [byte eax+037h], dx
        jmp near .11
.5:
        mov dl, byte [byte ecx+027h]
        cmp dl, byte [byte ecx+026h]
        jbe short .6
        mov dword [byte ebp-01Ch], 1
        test ebx, ebx
        jne short .3
        mov word [byte eax+031h], 0
        mov word [byte eax+035h], 0
        inc byte [byte eax+02h]
        inc word [byte eax+029h]
        inc byte [byte eax+06h]
        jmp near .1
.6:
        inc byte [byte eax+04h]
        test ebx, ebx
        je short .7
        inc byte [byte eax+0Ch]
        jmp short .8
.7:
        inc byte [byte eax+08h]
.8:
        mov word [byte eax+029h], 0
        mov word [byte eax+031h], 0
        inc word [byte eax+035h]
        mov dx, word [byte eax+035h]
        cmp dx, word [byte eax+037h]
        jle short .9
        mov word [byte eax+037h], dx
.9:
        inc word [byte eax+02Dh]
        mov dx, word [byte eax+02Dh]
        cmp dx, word [byte eax+02Fh]
        jle short .11
.10:
        mov word [byte eax+02Fh], dx
.11:
        test edi, edi
        je short .12
        lea edx, [dword ecx+020DFh]
        jmp short .13
.12:
        lea edx, [dword ecx+04202h]
.13:
        mov bx, word [edx]
        add word [byte eax+013h], bx
        mov bx, word [byte edx+02h]
        add word [byte eax+015h], bx
        mov bx, word [byte edx+04h]
        add word [byte eax+017h], bx
        mov bx, word [byte edx+06h]
        add word [byte eax+019h], bx
        mov bx, word [byte edx+08h]
        add word [byte eax+01Bh], bx
        mov bx, word [byte edx+0Ah]
        add word [byte eax+01Dh], bx
        mov bx, word [byte edx+014h]
        add word [byte eax+01Fh], bx
        mov bx, word [byte edx+016h]
        add word [byte eax+021h], bx
        mov bx, word [byte edx+018h]
        mov dword [byte ebp-010h], 0
        add word [byte eax+023h], bx
        mov bx, word [byte edx+01Ch]
        mov dword [byte ebp-08h], 0
        add word [byte eax+025h], bx
        mov dx, word [byte edx+01Eh]
        lea ebx, [dword esi+0D09h]
        add word [byte eax+027h], dx
        lea edx, [dword ecx+0CBh]
        call ServiceIdle
        mov dword [byte ebp-030h], edx
        lea edx, [dword ecx+021EEh]
        mov eax, 1
        mov dword [byte ebp-034h], edx
.14:
        movsx edx, word [dword esi+0D05h]
        mov dword [byte ebp-038h], edx
        mov edx, dword [byte ebp-010h]
        cmp edx, dword [byte ebp-038h]
        jge short .17
        test eax, eax
        je short .17
        test edi, edi
        je short .15
        mov eax, dword [byte ebp-030h]
        jmp short .16
.15:
        mov eax, dword [byte ebp-034h]
.16:
        mov edx, ebx
        add eax, dword [byte ebp-08h]
        call RecordHomeStats
        add dword [byte ebp-08h], 125h
        inc dword [byte ebp-010h]
        add ebx, byte 38h
        jmp short .14
.17:
        test eax, eax
        je near .21
        mov dword [byte ebp-020h], 0
        lea edx, [dword esi+01283h]
        mov dword [byte ebp-04h], 0
        mov dword [byte ebp-018h], edx
        lea edx, [dword ecx+01D6Ah]
        mov dword [byte ebp-0Ch], 0
        mov dword [byte ebp-02Ch], edx
        mov edx, dword [byte ebp-014h]
        add ecx, 3E8Dh
        or edx, dword [byte ebp-01Ch]
        mov dword [byte ebp-028h], ecx
        mov dword [byte ebp-024h], edx
.18:
        movsx edx, word [dword esi+01281h]
        cmp edx, dword [byte ebp-0Ch]
        jle short .21
        test eax, eax
        je short .21
        mov edx, dword [byte ebp-018h]
        add edx, dword [byte ebp-020h]
        test edi, edi
        je short .19
        cmp dword [byte ebp-024h], byte 0
        sete al
        movzx ecx, al
        mov eax, dword [byte ebp-02Ch]
        mov ebx, dword [byte ebp-014h]
        jmp short .20
.19:
        cmp dword [byte ebp-024h], byte 0
        sete al
        movzx ecx, al
        mov eax, dword [byte ebp-028h]
        mov ebx, dword [byte ebp-01Ch]
.20:
        add eax, dword [byte ebp-04h]
        call RecordAwayStats
        add dword [byte ebp-04h], 125h
        inc dword [byte ebp-0Ch]
        add dword [byte ebp-020h], byte 38h
        jmp short .18
.21:
        test eax, eax
        je short .22
        mov eax, esi
        call UpdateGameRecord
.22:
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; SaveGameResult                                  DEE3A  97 PC, low confidence
; Saves the result of a game
;-----------------------------------------------------------------------------
SaveGameResult:
        push esi
        push edi
        enter 4, 0
        mov esi, eax
        mov edi, edx
        mov dword [byte ebp-04h], ebx
        mov edx, ecx
        mov ebx, 1
        call RecordGameResult
        mov edx, eax
        test eax, eax
        je short .1
        mov edx, dword [byte ebp+010h]
        mov eax, esi
        xor ebx, ebx
        call RecordGameResult
        mov edx, eax
.1:
        call ServiceIdle
        test edx, edx
        je short .2
        movsx edx, word [byte ebp-04h]
        mov eax, dword [byte edi+020h]
        shl edx, 4
        add eax, edx
        mov dl, byte [byte esi+026h]
        mov byte [byte eax+02h], dl
        mov dl, byte [byte esi+027h]
        mov byte [byte eax+03h], dl
.2:
        mov eax, edi
        call WriteLeagueHeader
SaveGameResult_55:
        leave
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; SaveExhibitionResult                            DEE95  97 PC, low confidence
; Saves the result of an exhibition game
;-----------------------------------------------------------------------------
SaveExhibitionResult:
        push ebx
        push ecx
        push esi
        push edi
        enter 8, 0
        mov esi, eax
        mov edi, edx
        cmp dx, word [byte eax+02h]
        jle short .2
.1:
        xor eax, eax
        jmp near FindGameRecord_A0
.2:
        movsx eax, dx
        mov ecx, dword [byte esi+020h]
        shl eax, 4
        add ecx, eax
        movsx eax, byte [byte ecx+02h]
        cmp eax, byte 0FFFFFFFFh
        jne short .1
        mov ebx, 8
        mov edx, DbKeyBuffer
        lea eax, [byte ecx+08h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne short .1
        cmp byte [ecx], 0
        jl short .1
        movsx ax, byte [ecx]
        cmp ax, word [esi]
        jge short .1
        cmp byte [byte ecx+01h], 0
        jl short .1
        movsx ax, byte [byte ecx+01h]
        cmp ax, word [esi]
        jge short .1
        lea ebx, [byte ebp-08h]
        mov edx, 7D16h
        mov eax, str_TEMP2
        call AllocClearBlock20
        test eax, eax
        je near FindGameRecord_A0
        mov eax, dword [byte ebp-08h]
        add eax, 329Eh
        mov ebx, dword [byte ebp-08h]
        mov dword [byte ebp-04h], eax
        call ServiceIdle
        mov edx, dword [byte ebp-04h]
        lea eax, [byte ecx+08h]
        add ebx, 194Fh
        call FindReplayIndexEntry
        mov edx, eax
        test eax, eax
        je short .3
        movsx eax, byte [ecx]
        mov edx, dword [byte esi+01Ch]
        shl eax, 3
        add eax, edx
        mov edx, dword [byte ebp-08h]
        call FindGameRecord
        mov edx, eax
.3:
        test edx, edx
        je short .4
        movsx eax, byte [byte ecx+01h]
        mov edx, dword [byte esi+01Ch]
        shl eax, 3
        add eax, edx
        mov edx, ebx
        call FindGameRecord
        mov edx, eax
.4:
        test edx, edx
        je short .5
        mov ecx, dword [byte ebp-08h]
        mov eax, dword [byte ebp-04h]
        push ebx
        mov edx, esi
        movsx ebx, di
        call SaveGameResult
        mov edx, eax
.5:
        lea eax, [byte ebp-08h]
        call FreePtr
        mov eax, edx
        jmp near FindGameRecord_A0
;-----------------------------------------------------------------------------
; SaveSeasonResult                                DEF96  97 PC, low confidence
; Saves the result of a season game
;-----------------------------------------------------------------------------
SaveSeasonResult:
        push ecx
        push esi
        push edi
        enter 0Ch, 0
        mov esi, eax
        mov edi, edx
        mov dword [byte ebp-08h], ebx
        movsx eax, word [byte eax+02h]
        cmp edx, eax
        jle short .2
.1:
        xor eax, eax
        leave
        pop edi
        pop esi
        pop ecx
        ret
.2:
        mov eax, edx
        mov ecx, dword [byte esi+020h]
        shl eax, 4
        add ecx, eax
        movsx eax, byte [byte ecx+02h]
        cmp eax, byte 0FFFFFFFFh
        jne short .1
        mov ebx, 8
        mov edx, DbKeyBuffer
        lea eax, [byte ecx+08h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je near .5
        cmp byte [ecx], 0
        jl short .1
        movsx ax, byte [ecx]
        cmp ax, word [esi]
        jge short .1
        cmp byte [byte ecx+01h], 0
        jl short .1
        movsx ax, byte [byte ecx+01h]
        cmp ax, word [esi]
        jge short .1
        call ServiceIdle
        lea ebx, [byte ebp-0Ch]
        mov edx, 329Eh
        mov eax, str_TEMP2
        call AllocClearBlock20
        test eax, eax
        je short .5
        movsx eax, byte [ecx]
        shl eax, 3
        mov ebx, dword [byte ebp-0Ch]
        mov dword [byte ebp-04h], eax
        mov eax, dword [byte esi+01Ch]
        mov edx, dword [byte ebp-0Ch]
        add eax, dword [byte ebp-04h]
        add ebx, 194Fh
        call FindGameRecord
        mov edx, eax
        test eax, eax
        je short .3
        movsx edx, byte [byte ecx+01h]
        mov eax, dword [byte esi+01Ch]
        shl edx, 3
        add eax, edx
        mov edx, ebx
        call FindGameRecord
        mov edx, eax
.3:
        test edx, edx
        je short .4
        mov ecx, dword [byte ebp-0Ch]
        mov eax, dword [byte ebp-08h]
        push ebx
        mov edx, esi
        movsx ebx, di
        call SaveGameResult
        mov edx, eax
.4:
        lea eax, [byte ebp-0Ch]
        call FreePtr
        mov eax, edx
.5:
        leave
        pop edi
        pop esi
        pop ecx
        ret
        push ebx
        push ecx
        cmp dx, word [byte eax+02h]
        jle short .6
        xor eax, eax
        pop ecx
        pop ebx
        ret
.6:
        movsx ecx, dx
        mov eax, dword [byte eax+020h]
        shl ecx, 4
        mov ebx, 8
        add ecx, eax
        mov edx, DbKeyBuffer
        lea eax, [byte ecx+08h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .7
        mov eax, 1
        pop ecx
        pop ebx
        ret
.7:
        call ServiceIdle
        lea eax, [byte ecx+08h]
        call DeleteReplayIndexEntry
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push esi
        push edi
        enter 80h, 0
        push eax
        push edx
        sub ebp, 82h
        cmp word [DbOpen], byte 0
        jne short .8
        xor eax, eax
        jmp near .9
.8:
        lea edi, [byte ebp+012h]
        mov esi, edx
        movsd
        movsd
        lea ebx, [byte ebp+042h]
        lea edi, [byte ebp+0Ah]
        mov esi, eax
        lea ecx, [byte ebp+07Eh]
        mov edx, 6
        movsd
        movsd
        lea eax, [byte ebp+02h]
        mov dword [byte ebp+02h], 0
        mov dword [byte ebp+06h], 0
        call MakeTeamStatKey
        lea ebx, [byte ebp+042h]
        mov edx, 6
        mov eax, dword [DbKeyIndex]
        call FindIndexKey
        test eax, eax
        je near .9
        lea ebx, [byte ebp+06Eh]
        lea edx, [byte ebp+042h]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp+042h]
        lea ebx, [byte ebp+06Eh]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        mov ebx, 8
        mov edx, dword [byte ebp-06h]
        lea eax, [byte ebp+06Eh]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .9
        lea ebx, [byte ebp+076h]
        lea edx, [byte ebp+04Ch]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp+04Ch]
        lea ebx, [byte ebp+076h]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        mov ebx, 8
        mov edx, dword [byte ebp-02h]
        lea eax, [byte ebp+076h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .9
        mov eax, 1
.9:
        lea esp, [dword ebp+082h]
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; MakeGameKey                                     DF1CF  97 PC, low confidence
; Builds the key of a game record
;-----------------------------------------------------------------------------
MakeGameKey:
        push ecx
        push esi
        push edi
        enter 4, 0
        mov esi, eax
        mov ecx, ebx
        cmp edx, byte 3
        jb near .4
        lea edi, [byte eax+04h]
        jbe short .1
        cmp edx, byte 4
        je short .3
        jmp short .4
.1:
        mov eax, 4
        mov edx, edi
        call BuildKeyFromLong
.2:
        mov eax, 4
        mov ebx, ecx
        mov edx, esi
        call BuildKeyFromString
        jmp short .5
.3:
        add eax, byte 10h
        lea edx, [byte esi+014h]
        mov dword [byte ebp-04h], eax
        mov eax, 4
        call BuildKeyFromLong
        mov edx, dword [byte ebp-04h]
        mov eax, 4
        mov ebx, ecx
        call BuildKeyFromString
        mov eax, esi
        mov ebx, ecx
        add eax, byte 8
        lea edx, [byte esi+0Ch]
        mov dword [byte ebp-04h], eax
        mov eax, 4
        call BuildKeyFromString
        mov edx, dword [byte ebp-04h]
        mov eax, 4
        mov ebx, ecx
        call BuildKeyFromString
        mov eax, 4
        mov ebx, ecx
        mov edx, edi
        call BuildKeyFromString
        jmp short .2
.4:
        xor eax, eax
        leave
        pop edi
        pop esi
        pop ecx
        ret
.5:
        mov eax, 1
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; BuildPlayoffRecords                             DF274  97 PC, low confidence
; Builds the playoff records
;-----------------------------------------------------------------------------
BuildPlayoffRecords:
        push esi
        push edi
        enter 1A30h, 0
        push ebx
        push ecx
        sub ebp, byte 7Eh
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near CreateExhibitionFile_325
.2:
        imul eax, dword 194Fh
        add edx, 0DF4h
        lea ecx, [edx+eax]
        mov esi, dword [dword ebp-019BAh]
        mov edx, 194Fh
        lea eax, [dword ebp-019B2h]
        lea edi, [dword ebp-019AAh]
        call ZeroBytesOk
        lea esi, [byte esi+04h]
        movsd
        movsd
        lea edi, [dword ebp-019A2h]
        lea esi, [byte ecx+010h]
        lea eax, [dword ebp-019B2h]
        movsd
        movsd
        call AddGameRecord
        test eax, eax
        je near CreateExhibitionFile_325
        call ServiceIdle
        mov ebx, 36h
        lea edx, [dword ebp-0199Ah]
        lea eax, [byte ecx+018h]
        call CopyBytesOk
        mov ebx, 0C7Eh
        lea edx, [dword ebp-0192Bh]
        lea eax, [dword ecx+087h]
        call CopyBytesOk
        mov ax, word [dword ecx+0D07h]
        mov word [dword ebp-0CABh], ax
        mov al, byte [byte ecx+05Bh]
        mov byte [dword ebp-01957h], al
        mov al, byte [byte ecx+05Ch]
        mov byte [dword ebp-01956h], al
        mov al, byte [byte ecx+05Dh]
        mov byte [dword ebp-01955h], al
        mov al, byte [byte ecx+05Eh]
        mov byte [dword ebp-01954h], al
        mov al, byte [byte ecx+05Fh]
        mov byte [dword ebp-01953h], al
        mov al, byte [byte ecx+060h]
        mov byte [dword ebp-01952h], al
        lea eax, [dword ecx+0D09h]
        mov dword [byte ebp+072h], eax
        add eax, byte 20h
        mov dword [byte ebp+03Eh], eax
        lea eax, [dword ebp-0CA9h]
        add eax, byte 18h
        mov dword [byte ebp+04Eh], 0
        mov dword [byte ebp+05Eh], eax
.3:
        movsx eax, word [dword ecx+0D05h]
        cmp eax, dword [byte ebp+04Eh]
        jle near .16
        imul esi, dword [byte ebp+04Eh], byte 38h
        lea edx, [dword ebp-0CA9h]
        add edx, esi
        add esi, dword [byte ebp+072h]
        mov ebx, 38h
        mov eax, esi
        call CopyBytesOk
        call ServiceIdle
        mov edx, 3Dh
        lea eax, [byte ebp-022h]
        mov ebx, 8
        call ZeroBytesOk
        mov edx, DbKeyBuffer
        mov eax, dword [byte ebp+03Eh]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne short .4
        lea edx, [byte ebp-062h]
        lea eax, [byte esi+020h]
        call FindTeamStat
        test eax, eax
        jne short .5
.4:
        mov byte [byte ebp+016h], 1
        jmp short .6
.5:
        mov al, byte [byte ebp-02Ah]
        mov byte [byte ebp+016h], al
.6:
        imul esi, dword [byte ebp+04Eh], byte 38h
        lea edi, [byte ebp-012h]
        lea esi, [dword esi+ebp-0C91h]
        movsd
        movsd
        mov ebx, 8
        lea edi, [byte ebp-01Ah]
        lea esi, [dword ebp-019AAh]
        mov edx, DbKeyBuffer
        mov eax, dword [dword ebp+08Eh]
        movsd
        movsd
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .7
        lea eax, [byte ebp-022h]
        call AddTeamStat
        test eax, eax
        jne short .8
        jmp near CreateExhibitionFile_325
.7:
        mov edx, dword [dword ebp+08Eh]
        lea eax, [byte ebp-022h]
        call AddTeamStatAt
        test eax, eax
        je near CreateExhibitionFile_325
        mov eax, dword [dword ebp+08Eh]
        inc dword [byte eax+04h]
.8:
        imul esi, dword [byte ebp+04Eh], byte 38h
        call ServiceIdle
        lea edi, [dword esi+ebp-0C89h]
        lea esi, [byte ebp-022h]
        mov eax, dword [byte ebp+05Eh]
        movsd
        movsd
        mov dword [byte ebp+02Ah], eax
        xor esi, esi
.9:
        movsx eax, word [dword ebp-018F5h]
        cmp esi, eax
        jge short .11
        imul edi, esi, byte 38h
        lea eax, [dword ebp-018F3h]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+02Ah]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .10
        lea esi, [byte ebp-022h]
        lea edi, [dword edi+ebp-018D3h]
        movsd
        movsd
        movsx esi, word [dword ebp-018F5h]
.10:
        inc esi
        jmp short .9
.11:
        jne short .15
        xor esi, eax
        mov eax, dword [byte ebp+05Eh]
        mov dword [byte ebp+026h], eax
.12:
        movsx eax, word [dword ebp-012D1h]
        cmp esi, eax
        jge short .14
        imul edi, esi, byte 38h
        lea eax, [dword ebp-012CFh]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+026h]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .13
        lea esi, [byte ebp-022h]
        lea edi, [dword edi+ebp-012AFh]
        movsd
        movsd
        movsx esi, word [dword ebp-012D1h]
.13:
        inc esi
        jmp short .12
.14:
        je near .1
.15:
        add dword [byte ebp+05Eh], byte 38h
        inc dword [byte ebp+04Eh]
        add dword [byte ebp+03Eh], byte 38h
        jmp near .3
.16:
        mov ax, word [dword ecx+0D05h]
        mov word [dword ebp-0CADh], ax
        lea eax, [dword ecx+01283h]
        mov dword [byte ebp+06Eh], eax
        add eax, byte 20h
        mov dword [byte ebp+07Ah], eax
        lea eax, [dword ebp-072Fh]
        add eax, byte 18h
        mov dword [byte ebp+05Ah], 0
        mov dword [byte ebp+046h], eax
.17:
        movsx eax, word [dword ecx+01281h]
        cmp eax, dword [byte ebp+05Ah]
        jle near .30
        imul esi, dword [byte ebp+05Ah], byte 38h
        lea edx, [dword ebp-072Fh]
        add edx, esi
        add esi, dword [byte ebp+06Eh]
        mov ebx, 38h
        mov eax, esi
        call CopyBytesOk
        mov edx, 3Dh
        lea eax, [byte ebp-022h]
        mov ebx, 8
        call ZeroBytesOk
        mov edx, DbKeyBuffer
        mov eax, dword [byte ebp+07Ah]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne short .18
        lea edx, [byte ebp-062h]
        lea eax, [byte esi+020h]
        call FindTeamStat
        test eax, eax
        jne short .19
.18:
        mov byte [byte ebp+01Ah], 1
        jmp short .20
.19:
        mov al, byte [byte ebp-026h]
        mov byte [byte ebp+01Ah], al
.20:
        imul esi, dword [byte ebp+05Ah], byte 38h
        lea edi, [byte ebp-012h]
        lea esi, [dword esi+ebp-0717h]
        movsd
        movsd
        lea edi, [byte ebp-01Ah]
        lea esi, [dword ebp-019AAh]
        mov ebx, 8
        mov edx, DbKeyBuffer
        movsd
        movsd
        call ServiceIdle
        mov eax, dword [dword ebp+08Eh]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .21
        lea eax, [byte ebp-022h]
        call AddTeamStat
        test eax, eax
        jne short .22
        jmp near CreateExhibitionFile_325
.21:
        mov edx, dword [dword ebp+08Eh]
        lea eax, [byte ebp-022h]
        call AddTeamStatAt
        test eax, eax
        je near CreateExhibitionFile_325
        mov eax, dword [dword ebp+08Eh]
        inc dword [byte eax+04h]
.22:
        imul esi, dword [byte ebp+05Ah], byte 38h
        lea edi, [dword esi+ebp-070Fh]
        lea esi, [byte ebp-022h]
        mov eax, dword [byte ebp+046h]
        movsd
        movsd
        mov dword [byte ebp+022h], eax
        xor esi, esi
.23:
        movsx eax, word [dword ebp-0137Bh]
        cmp esi, eax
        jge short .25
        imul edi, esi, byte 38h
        lea eax, [dword ebp-01379h]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+022h]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .24
        lea esi, [byte ebp-022h]
        lea edi, [dword edi+ebp-01359h]
        movsd
        movsd
        movsx esi, word [dword ebp-0137Bh]
.24:
        inc esi
        jmp short .23
.25:
        jne short .29
        xor esi, eax
        mov eax, dword [byte ebp+046h]
        mov dword [byte ebp+02Eh], eax
.26:
        movsx eax, word [dword ebp-0D57h]
        cmp esi, eax
        jge short .28
        imul edi, esi, byte 38h
        lea eax, [dword ebp-0D55h]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+02Eh]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .27
        lea esi, [byte ebp-022h]
        lea edi, [dword edi+ebp-0D35h]
        movsd
        movsd
        movsx esi, word [dword ebp-0D57h]
.27:
        inc esi
        jmp short .26
.28:
        je near .1
.29:
        add dword [byte ebp+046h], byte 38h
        inc dword [byte ebp+05Ah]
        add dword [byte ebp+07Ah], byte 38h
        jmp near .17
.30:
        mov ax, word [dword ecx+01281h]
        mov word [dword ebp-0731h], ax
        lea eax, [dword ecx+0132Dh]
        mov dword [byte ebp+062h], eax
        add eax, byte 20h
        mov dword [byte ebp+042h], eax
        lea eax, [dword ebp-0685h]
        add eax, byte 18h
        mov dword [byte ebp+056h], 0
        mov dword [byte ebp+066h], eax
.31:
        movsx eax, word [dword ecx+0132Bh]
        cmp eax, dword [byte ebp+056h]
        jle near .44
        imul esi, dword [byte ebp+056h], byte 38h
        lea edx, [dword ebp-0685h]
        add edx, esi
        add esi, dword [byte ebp+062h]
        mov ebx, 38h
        mov eax, esi
        call CopyBytesOk
        mov edx, 3Dh
        lea eax, [byte ebp-022h]
        mov ebx, 8
        call ZeroBytesOk
        mov edx, DbKeyBuffer
        mov eax, dword [byte ebp+042h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne short .32
        lea edx, [byte ebp-062h]
        lea eax, [byte esi+020h]
        call FindTeamStat
        test eax, eax
        jne short .33
.32:
        mov byte [byte ebp+016h], 1
        jmp short .34
.33:
        mov al, byte [byte ebp-02Ah]
        mov byte [byte ebp+016h], al
.34:
        imul esi, dword [byte ebp+056h], byte 38h
        lea edi, [byte ebp-012h]
        lea esi, [dword esi+ebp-066Dh]
        movsd
        movsd
        lea edi, [byte ebp-01Ah]
        lea esi, [dword ebp-019AAh]
        mov ebx, 8
        mov edx, DbKeyBuffer
        movsd
        movsd
        call ServiceIdle
        mov eax, dword [dword ebp+08Eh]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .35
        lea eax, [byte ebp-022h]
        call AddTeamStat
        test eax, eax
        jne short .36
        jmp near CreateExhibitionFile_325
.35:
        mov edx, dword [dword ebp+08Eh]
        lea eax, [byte ebp-022h]
        call AddTeamStatAt
        test eax, eax
        je near CreateExhibitionFile_325
        mov eax, dword [dword ebp+08Eh]
        inc dword [byte eax+04h]
.36:
        imul esi, dword [byte ebp+056h], byte 38h
        lea edi, [dword esi+ebp-0665h]
        lea esi, [byte ebp-022h]
        mov eax, dword [byte ebp+066h]
        movsd
        movsd
        mov dword [byte ebp+032h], eax
        xor esi, esi
.37:
        movsx eax, word [dword ebp-012D1h]
        cmp esi, eax
        jge short .39
        imul edi, esi, byte 38h
        lea eax, [dword ebp-012CFh]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+032h]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .38
        lea esi, [byte ebp-022h]
        lea edi, [dword edi+ebp-012AFh]
        movsd
        movsd
        movsx esi, word [dword ebp-012D1h]
.38:
        inc esi
        jmp short .37
.39:
        jne short .43
        xor esi, eax
        mov eax, dword [byte ebp+066h]
        mov dword [byte ebp+052h], eax
.40:
        movsx eax, word [dword ebp-018F5h]
        cmp esi, eax
        jge short .42
        imul edi, esi, byte 38h
        lea eax, [dword ebp-018F3h]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+052h]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .41
        lea esi, [byte ebp-022h]
        lea edi, [dword edi+ebp-018D3h]
        movsd
        movsd
        movsx esi, word [dword ebp-018F5h]
.41:
        inc esi
        jmp short .40
.42:
        je near .1
.43:
        add dword [byte ebp+066h], byte 38h
        inc dword [byte ebp+056h]
        add dword [byte ebp+042h], byte 38h
        jmp near .31
.44:
        mov ax, word [dword ecx+0132Bh]
        mov word [dword ebp-0687h], ax
        lea eax, [dword ecx+018A7h]
        mov dword [byte ebp+04Ah], eax
        add eax, byte 20h
        mov dword [byte ebp+03Ah], eax
        lea eax, [dword ebp-010Bh]
        add eax, byte 18h
        mov dword [byte ebp+076h], 0
        mov dword [byte ebp+06Ah], eax
.45:
        movsx eax, word [dword ecx+018A5h]
        cmp eax, dword [byte ebp+076h]
        jle near .58
        imul esi, dword [byte ebp+076h], byte 38h
        lea edx, [dword ebp-010Bh]
        add edx, esi
        add esi, dword [byte ebp+04Ah]
        mov ebx, 38h
        mov eax, esi
        call CopyBytesOk
        mov edx, 3Dh
        lea eax, [byte ebp-022h]
        mov ebx, 8
        call ZeroBytesOk
        mov edx, DbKeyBuffer
        mov eax, dword [byte ebp+03Ah]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne short .46
        lea edx, [byte ebp-062h]
        lea eax, [byte esi+020h]
        call FindTeamStat
        test eax, eax
        jne short .47
.46:
        mov byte [byte ebp+01Ah], 1
        jmp short .48
.47:
        mov al, byte [byte ebp-026h]
        mov byte [byte ebp+01Ah], al
.48:
        imul esi, dword [byte ebp+076h], byte 38h
        lea edi, [byte ebp-012h]
        lea esi, [dword esi+ebp-0F3h]
        movsd
        movsd
        mov ebx, 8
        lea edi, [byte ebp-01Ah]
        lea esi, [dword ebp-019AAh]
        mov edx, DbKeyBuffer
        mov eax, dword [dword ebp+08Eh]
        movsd
        movsd
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .49
        lea eax, [byte ebp-022h]
        call AddTeamStat
        test eax, eax
        jne short .50
        jmp near CreateExhibitionFile_325
.49:
        mov edx, dword [dword ebp+08Eh]
        lea eax, [byte ebp-022h]
        call AddTeamStatAt
        test eax, eax
        je near CreateExhibitionFile_325
        mov eax, dword [dword ebp+08Eh]
        inc dword [byte eax+04h]
.50:
        imul esi, dword [byte ebp+076h], byte 38h
        call ServiceIdle
        lea edi, [dword esi+ebp-0EBh]
        lea esi, [byte ebp-022h]
        mov eax, dword [byte ebp+06Ah]
        movsd
        movsd
        mov dword [byte ebp+036h], eax
        xor esi, esi
.51:
        movsx eax, word [dword ebp-0D57h]
        cmp esi, eax
        jge short .53
        imul edi, esi, byte 38h
        lea eax, [dword ebp-0D55h]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+036h]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .52
        lea esi, [byte ebp-022h]
        lea edi, [dword edi+ebp-0D35h]
        movsd
        movsd
        movsx esi, word [dword ebp-0D57h]
.52:
        inc esi
        jmp short .51
.53:
        jne short .57
        xor esi, eax
        mov eax, dword [byte ebp+06Ah]
        mov dword [byte ebp+01Eh], eax
.54:
        movsx eax, word [dword ebp-0137Bh]
        cmp esi, eax
        jge short .56
        imul edi, esi, byte 38h
        lea eax, [dword ebp-01379h]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+01Eh]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .55
        lea esi, [byte ebp-022h]
        lea edi, [dword edi+ebp-01359h]
        movsd
        movsd
        movsx esi, word [dword ebp-0137Bh]
.55:
        inc esi
        jmp short .54
.56:
        je near .1
.57:
        add dword [byte ebp+06Ah], byte 38h
        inc dword [byte ebp+076h]
        add dword [byte ebp+03Ah], byte 38h
        jmp near .45
.58:
        mov ax, word [dword ecx+018A5h]
        mov word [dword ebp-010Dh], ax
        lea eax, [dword ebp-019B2h]
        call UpdateGameRecord
        test eax, eax
        je near CreateExhibitionFile_325
        mov eax, dword [dword ebp-019B6h]
        mov edi, dword [dword ebp-019BAh]
        shl eax, 3
        mov edi, dword [byte edi+01Ch]
        lea esi, [dword ebp-019B2h]
        add edi, eax
        mov eax, 1
        movsd
        movsd
        jmp near CreateExhibitionFile_325
;-----------------------------------------------------------------------------
; BuildSeasonRecords                              DFAF6  97 PC, low confidence
; Builds the season records
;-----------------------------------------------------------------------------
BuildSeasonRecords:
        push esi
        push edi
        enter 3370h, 0
        push ebx
        sub ebp, 82h
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near BuildSeasonRecords_797
.2:
        mov esi, eax
        shl esi, 3
        mov eax, dword [byte edx+01Ch]
        lea edx, [dword ebp-032EEh]
        add eax, esi
        call FindGameRecord
        test eax, eax
        je near BuildSeasonRecords_797
        mov edx, 194Fh
        lea eax, [dword ebp-0199Eh]
        lea edi, [dword ebp-01996h]
        call ZeroBytesOk
        lea esi, [byte ecx+04h]
        movsd
        movsd
        lea edi, [dword ebp-0198Eh]
        lea esi, [dword ebp-032DEh]
        lea eax, [dword ebp-0199Eh]
        movsd
        movsd
        call AddGameRecord
        test eax, eax
        je near BuildSeasonRecords_797
        mov ebx, 36h
        lea edx, [dword ebp-01986h]
        lea eax, [dword ebp-032D6h]
        call CopyBytesOk
        mov ebx, 0C7Eh
        lea edx, [dword ebp-01917h]
        lea eax, [dword ebp-03267h]
        call CopyBytesOk
        mov eax, dword [dword ebp-025E7h]
        mov word [dword ebp-0C97h], ax
        mov al, byte [dword ebp-03293h]
        mov byte [dword ebp-01943h], al
        mov al, byte [dword ebp-03292h]
        mov byte [dword ebp-01942h], al
        mov al, byte [dword ebp-03291h]
        mov byte [dword ebp-01941h], al
        mov al, byte [dword ebp-03290h]
        mov byte [dword ebp-01940h], al
        mov al, byte [dword ebp-0328Fh]
        mov byte [dword ebp-0193Fh], al
        mov al, byte [dword ebp-0328Eh]
        mov byte [dword ebp-0193Eh], al
        lea eax, [dword ebp-025E5h]
        add eax, byte 20h
        mov dword [byte ebp+05Ah], eax
        lea eax, [dword ebp-0C95h]
        add eax, byte 18h
        mov dword [byte ebp+062h], 0
        mov dword [byte ebp+052h], eax
.3:
        movsx eax, word [dword ebp-025E9h]
        cmp eax, dword [byte ebp+062h]
        jle near .14
        call ServiceIdle
        imul eax, dword [byte ebp+062h], byte 38h
        lea edx, [dword ebp-0C95h]
        lea esi, [dword ebp-025E5h]
        mov ebx, 38h
        add edx, eax
        add eax, esi
        call CopyBytesOk
        mov edx, 3Dh
        lea eax, [byte ebp-04Eh]
        mov ebx, 8
        call ZeroBytesOk
        mov edx, DbKeyBuffer
        mov eax, dword [byte ebp+05Ah]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne short .4
        lea edx, [byte ebp-0Eh]
        mov eax, dword [byte ebp+05Ah]
        call FindTeamStat
        test eax, eax
        jne short .5
.4:
        mov byte [byte ebp-016h], 1
        jmp short .6
.5:
        mov al, byte [byte ebp+02Ah]
        mov byte [byte ebp-016h], al
.6:
        imul edx, dword [byte ebp+062h], byte 38h
        lea edi, [byte ebp-03Eh]
        lea esi, [dword edx+ebp-0C7Dh]
        movsd
        movsd
        lea edi, [byte ebp-046h]
        lea esi, [dword ebp-01996h]
        lea eax, [byte ebp-04Eh]
        movsd
        movsd
        call AddTeamStat
        test eax, eax
        je near BuildSeasonRecords_797
        lea eax, [dword ebp-0C95h]
        lea esi, [byte ebp-04Eh]
        lea edi, [dword edx+ebp-0C75h]
        add eax, edx
        movsd
        movsd
        add eax, byte 18h
        xor esi, esi
        mov dword [byte ebp+042h], eax
.7:
        movsx eax, word [dword ebp-018E1h]
        cmp esi, eax
        jge short .9
        imul edi, esi, byte 38h
        lea eax, [dword ebp-018DFh]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+042h]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .8
        lea esi, [byte ebp-04Eh]
        lea edi, [dword edi+ebp-018BFh]
        movsd
        movsd
        movsx esi, word [dword ebp-018E1h]
.8:
        inc esi
        jmp short .7
.9:
        jne short .13
        xor esi, eax
        mov eax, dword [byte ebp+052h]
        mov dword [byte ebp+04Ah], eax
.10:
        movsx eax, word [dword ebp-012BDh]
        cmp esi, eax
        jge short .12
        imul edi, esi, byte 38h
        lea eax, [dword ebp-012BBh]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+04Ah]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .11
        lea esi, [byte ebp-04Eh]
        lea edi, [dword edi+ebp-0129Bh]
        movsd
        movsd
        movsx esi, word [dword ebp-012BDh]
.11:
        inc esi
        jmp short .10
.12:
        je near .1
.13:
        add dword [byte ebp+052h], byte 38h
        inc dword [byte ebp+062h]
        add dword [byte ebp+05Ah], byte 38h
        jmp near .3
.14:
        mov eax, dword [dword ebp-025E9h]
        mov word [dword ebp-0C99h], ax
        lea eax, [dword ebp-0206Bh]
        add eax, byte 20h
        mov dword [byte ebp+072h], eax
        lea eax, [dword ebp-071Bh]
        add eax, byte 18h
        mov dword [byte ebp+07Ah], 0
        mov dword [byte ebp+06Eh], eax
.15:
        movsx eax, word [dword ebp-0206Dh]
        cmp eax, dword [byte ebp+07Ah]
        jle near .26
        call ServiceIdle
        imul eax, dword [byte ebp+07Ah], byte 38h
        lea edx, [dword ebp-071Bh]
        lea esi, [dword ebp-0206Bh]
        mov ebx, 38h
        add edx, eax
        add eax, esi
        call CopyBytesOk
        mov edx, 3Dh
        lea eax, [byte ebp-04Eh]
        mov ebx, 8
        call ZeroBytesOk
        mov edx, DbKeyBuffer
        mov eax, dword [byte ebp+072h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne short .16
        lea edx, [byte ebp-0Eh]
        mov eax, dword [byte ebp+072h]
        call FindTeamStat
        test eax, eax
        jne short .17
.16:
        mov byte [byte ebp-012h], 1
        jmp short .18
.17:
        mov al, byte [byte ebp+02Eh]
        mov byte [byte ebp-012h], al
.18:
        imul edx, dword [byte ebp+07Ah], byte 38h
        lea edi, [byte ebp-03Eh]
        lea esi, [dword edx+ebp-0703h]
        movsd
        movsd
        lea edi, [byte ebp-046h]
        lea esi, [dword ebp-01996h]
        lea eax, [byte ebp-04Eh]
        movsd
        movsd
        call AddTeamStat
        test eax, eax
        je near BuildSeasonRecords_797
        lea eax, [dword ebp-071Bh]
        lea esi, [byte ebp-04Eh]
        lea edi, [dword edx+ebp-06FBh]
        add eax, edx
        movsd
        movsd
        add eax, byte 18h
        xor esi, esi
        mov dword [byte ebp+03Ah], eax
.19:
        movsx eax, word [dword ebp-01367h]
        cmp esi, eax
        jge short .21
        imul edi, esi, byte 38h
        lea eax, [dword ebp-01365h]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+03Ah]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .20
        lea esi, [byte ebp-04Eh]
        lea edi, [dword edi+ebp-01345h]
        movsd
        movsd
        movsx esi, word [dword ebp-01367h]
.20:
        inc esi
        jmp short .19
.21:
        jne short .25
        xor esi, eax
        mov eax, dword [byte ebp+06Eh]
        mov dword [byte ebp+03Eh], eax
.22:
        movsx eax, word [dword ebp-0D43h]
        cmp esi, eax
        jge short .24
        imul edi, esi, byte 38h
        lea eax, [dword ebp-0D41h]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+03Eh]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .23
        lea esi, [byte ebp-04Eh]
        lea edi, [dword edi+ebp-0D21h]
        movsd
        movsd
        movsx esi, word [dword ebp-0D43h]
.23:
        inc esi
        jmp short .22
.24:
        je near .1
.25:
        add dword [byte ebp+06Eh], byte 38h
        inc dword [byte ebp+07Ah]
        add dword [byte ebp+072h], byte 38h
        jmp near .15
.26:
        mov eax, dword [dword ebp-0206Dh]
        mov word [dword ebp-071Dh], ax
        lea eax, [dword ebp-01FC1h]
        add eax, byte 20h
        mov dword [byte ebp+076h], eax
        lea eax, [dword ebp-0671h]
        add eax, byte 18h
        mov dword [byte ebp+066h], 0
        mov dword [byte ebp+07Eh], eax
.27:
        movsx eax, word [dword ebp-01FC3h]
        cmp eax, dword [byte ebp+066h]
        jle near .38
        call ServiceIdle
        imul eax, dword [byte ebp+066h], byte 38h
        lea edx, [dword ebp-0671h]
        lea esi, [dword ebp-01FC1h]
        mov ebx, 38h
        add edx, eax
        add eax, esi
        call CopyBytesOk
        mov edx, 3Dh
        lea eax, [byte ebp-04Eh]
        mov ebx, 8
        call ZeroBytesOk
        mov edx, DbKeyBuffer
        mov eax, dword [byte ebp+076h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne short .28
        lea edx, [byte ebp-0Eh]
        mov eax, dword [byte ebp+076h]
        call FindTeamStat
        test eax, eax
        jne short .29
.28:
        mov byte [byte ebp-016h], 1
        jmp short .30
.29:
        mov al, byte [byte ebp+02Ah]
        mov byte [byte ebp-016h], al
.30:
        imul edx, dword [byte ebp+066h], byte 38h
        lea edi, [byte ebp-03Eh]
        lea esi, [dword edx+ebp-0659h]
        movsd
        movsd
        lea edi, [byte ebp-046h]
        lea esi, [dword ebp-01996h]
        lea eax, [byte ebp-04Eh]
        movsd
        movsd
        call AddTeamStat
        test eax, eax
        je near BuildSeasonRecords_797
        lea eax, [dword ebp-0671h]
        lea esi, [byte ebp-04Eh]
        lea edi, [dword edx+ebp-0651h]
        add eax, edx
        movsd
        movsd
        add eax, byte 18h
        xor esi, esi
        mov dword [byte ebp+046h], eax
.31:
        movsx eax, word [dword ebp-012BDh]
        cmp esi, eax
        jge short .33
        imul edi, esi, byte 38h
        lea eax, [dword ebp-012BBh]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+046h]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .32
        lea esi, [byte ebp-04Eh]
        lea edi, [dword edi+ebp-0129Bh]
        movsd
        movsd
        movsx esi, word [dword ebp-012BDh]
.32:
        inc esi
        jmp short .31
.33:
        jne short .37
        xor esi, eax
        mov eax, dword [byte ebp+07Eh]
        mov dword [byte ebp+032h], eax
.34:
        movsx eax, word [dword ebp-018E1h]
        cmp esi, eax
        jge short .36
        imul edi, esi, byte 38h
        lea eax, [dword ebp-018DFh]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+032h]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .35
        lea esi, [byte ebp-04Eh]
        lea edi, [dword edi+ebp-018BFh]
        movsd
        movsd
        movsx esi, word [dword ebp-018E1h]
.35:
        inc esi
        jmp short .34
.36:
        je near .1
.37:
        add dword [byte ebp+07Eh], byte 38h
        inc dword [byte ebp+066h]
        add dword [byte ebp+076h], byte 38h
        jmp near .27
.38:
        mov eax, dword [dword ebp-01FC3h]
        mov word [dword ebp-0673h], ax
        lea eax, [dword ebp-01A47h]
        add eax, byte 20h
        mov dword [byte ebp+056h], eax
        lea eax, [dword ebp-0F7h]
        add eax, byte 18h
        mov dword [byte ebp+05Eh], 0
        mov dword [byte ebp+06Ah], eax
.39:
        movsx eax, word [dword ebp-01A49h]
        cmp eax, dword [byte ebp+05Eh]
        jle near .50
        call ServiceIdle
        imul eax, dword [byte ebp+05Eh], byte 38h
        lea edx, [dword ebp-0F7h]
        lea esi, [dword ebp-01A47h]
        mov ebx, 38h
        add edx, eax
        add eax, esi
        call CopyBytesOk
        mov edx, 3Dh
        lea eax, [byte ebp-04Eh]
        mov ebx, 8
        call ZeroBytesOk
        mov edx, DbKeyBuffer
        mov eax, dword [byte ebp+056h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne short .40
        lea edx, [byte ebp-0Eh]
        mov eax, dword [byte ebp+056h]
        call FindTeamStat
        test eax, eax
        jne short .41
.40:
        mov byte [byte ebp-012h], 1
        jmp short .42
.41:
        mov al, byte [byte ebp+02Eh]
        mov byte [byte ebp-012h], al
.42:
        imul edx, dword [byte ebp+05Eh], byte 38h
        lea edi, [byte ebp-03Eh]
        lea esi, [dword edx+ebp-0DFh]
        movsd
        movsd
        lea edi, [byte ebp-046h]
        lea esi, [dword ebp-01996h]
        lea eax, [byte ebp-04Eh]
        movsd
        movsd
        call AddTeamStat
        test eax, eax
        je near BuildSeasonRecords_797
        lea eax, [dword ebp-0F7h]
        lea esi, [byte ebp-04Eh]
        lea edi, [dword edx+ebp-0D7h]
        add eax, edx
        movsd
        movsd
        add eax, byte 18h
        xor esi, esi
        mov dword [byte ebp+04Eh], eax
.43:
        movsx eax, word [dword ebp-0D43h]
        cmp esi, eax
        jge short .45
        imul edi, esi, byte 38h
        lea eax, [dword ebp-0D41h]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+04Eh]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .44
        lea esi, [byte ebp-04Eh]
        lea edi, [dword edi+ebp-0D21h]
        movsd
        movsd
        movsx esi, word [dword ebp-0D43h]
.44:
        inc esi
        jmp short .43
.45:
        jne short .49
        xor esi, eax
        mov eax, dword [byte ebp+06Ah]
        mov dword [byte ebp+036h], eax
.46:
        movsx eax, word [dword ebp-01367h]
        cmp esi, eax
        jge short .48
        imul edi, esi, byte 38h
        lea eax, [dword ebp-01365h]
        mov ebx, 8
        add eax, edi
        mov edx, dword [byte ebp+036h]
        add eax, byte 18h
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .47
        lea esi, [byte ebp-04Eh]
        lea edi, [dword edi+ebp-01345h]
        movsd
        movsd
        movsx esi, word [dword ebp-01367h]
.47:
        inc esi
        jmp short .46
.48:
        je near .1
.49:
        add dword [byte ebp+06Ah], byte 38h
        inc dword [byte ebp+05Eh]
        add dword [byte ebp+056h], byte 38h
        jmp near .39
.50:
        mov eax, dword [dword ebp-01A49h]
        mov word [dword ebp-0F9h], ax
        lea eax, [dword ebp-0199Eh]
        call UpdateGameRecord
        test eax, eax
        je short BuildSeasonRecords_797
        mov edi, dword [dword ebp-032F2h]
        mov eax, dword [byte ecx+01Ch]
        shl edi, 3
        lea esi, [dword ebp-0199Eh]
        add edi, eax
        movsd
        movsd
        call ServiceIdle
        mov eax, 1
BuildSeasonRecords_797:
        lea esp, [dword ebp+082h]
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; AddGameRecord                                   E0297  97 PC, low confidence
; Adds a game record
;-----------------------------------------------------------------------------
AddGameRecord:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 5Ch, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        jmp near OpenGameDatabase_18
.1:
        mov edx, eax
        mov eax, 3
        call MakeLeagueKey
        test eax, eax
        je near OpenGameDatabase_18
        mov ebx, 194Fh
        lea edx, [byte ebp-04h]
        mov eax, 2
        call AllocRecordSlot
        test eax, eax
        je near OpenGameDatabase_18
        mov ebx, 194Fh
        mov eax, dword [DbGameFile]
        mov edx, esi
        call FileWriteRecord
        test eax, eax
        je near OpenGameDatabase_18
        lea ebx, [byte ebp-05Ch]
        mov edx, 3
        mov eax, esi
        call MakeGameKey
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov edx, 3
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        mov edi, eax
        test eax, eax
        je short AddGameRecord_CC
        lea ebx, [byte ebp-030h]
        mov edx, 4
        mov eax, esi
        call MakeGameKey
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 4
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        test eax, eax
        jne short AddGameRecord_CC
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov edx, 3
AddGameRecord_C0:
        mov eax, dword [DbKeyIndex]
AddGameRecord_C5:
        call DeleteIndexKey
        xor edi, edi
AddGameRecord_CC:
        call ServiceIdle
        mov eax, edi
        jmp near OpenGameDatabase_18
;-----------------------------------------------------------------------------
; FindGameRecord                                  E036F  97 PC, low confidence
; Finds a game record
;-----------------------------------------------------------------------------
FindGameRecord:
        push ebx
        push ecx
        push esi
        push edi
        enter 38h, 0
        push edx
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        jmp near FindGameRecord_A0
.1:
        lea ebx, [byte ebp-038h]
        lea ecx, [byte ebp-04h]
        mov edi, edx
        mov esi, eax
        mov edx, 3
        mov eax, dword [byte ebp-03Ch]
        movsd
        movsd
        call MakeGameKey
        lea ebx, [byte ebp-038h]
        mov edx, 3
        mov eax, dword [DbKeyIndex]
        call FindIndexKey
        test eax, eax
        je short FindGameRecord_A0
        lea ebx, [byte ebp-0Ch]
        lea edx, [byte ebp-038h]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp-038h]
        lea ebx, [byte ebp-0Ch]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        mov ebx, 8
        mov edx, dword [byte ebp-03Ch]
        lea eax, [byte ebp-0Ch]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short FindGameRecord_A0
        mov ecx, dword [byte ebp-03Ch]
        mov ebx, 194Fh
        mov edx, dword [byte ebp-04h]
        mov eax, 2
FindGameRecord_9B:
        call ReadDbRecord
FindGameRecord_A0:
        leave
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; UpdateGameRecord                                E0415  97 PC, low confidence
; Updates a game record
;-----------------------------------------------------------------------------
UpdateGameRecord:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 19E0h, 0
        sub ebp, 82h
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near UpdatePlayerRecord_1A6
.2:
        lea ebx, [byte ebp+04Ah]
        mov edx, 3
        lea ecx, [byte ebp+07Eh]
        call MakeGameKey
        lea ebx, [byte ebp+04Ah]
        mov edx, 3
        mov eax, dword [DbKeyIndex]
        call FindIndexKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
        lea ebx, [byte ebp+076h]
        lea edx, [byte ebp+04Ah]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp+04Ah]
        lea ebx, [byte ebp+076h]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        mov ebx, 8
        lea eax, [byte ebp+076h]
        mov edx, esi
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne near .4
        mov eax, dword [esi]
        cmp eax, dword [StaticBuffer]
        je short .1
        mov ebx, 194Fh
        lea edx, [byte ebp+07Eh]
        mov eax, 2
        call AllocRecordSlot
        test eax, eax
        je near UpdatePlayerRecord_1A6
        mov ebx, 194Fh
        mov eax, dword [DbGameFile]
        mov edx, esi
        call FileWriteRecord
        test eax, eax
        je near UpdatePlayerRecord_1A6
        lea ebx, [byte ebp+04Ah]
        mov edx, 3
        mov eax, esi
        call MakeGameKey
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp+04Ah]
        mov edx, 3
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        mov edi, eax
        test eax, eax
        je short .3
        lea ebx, [byte ebp+01Eh]
        mov edx, 4
        mov eax, esi
        call MakeGameKey
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp+01Eh]
        mov edx, 4
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        test eax, eax
        jne short .3
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp+04Ah]
        mov edx, 3
        mov eax, dword [DbKeyIndex]
        call DeleteIndexKey
        xor edi, edi
.3:
        mov eax, edi
        jmp near UpdatePlayerRecord_1A6
.4:
        call ServiceIdle
        lea ecx, [dword ebp-0195Eh]
        mov ebx, 194Fh
        mov edx, dword [byte ebp+07Eh]
        mov eax, 2
        call ReadDbRecord
        test eax, eax
        je near UpdatePlayerRecord_1A6
        mov ebx, 8
        lea edx, [dword ebp-0194Eh]
        lea eax, [byte esi+010h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .5
        lea edx, [dword ebp-01956h]
        lea eax, [byte esi+08h]
        call KeysEqual
        test eax, eax
        jne short .6
.5:
        lea ebx, [byte ebp-0Eh]
        mov edx, 4
        lea eax, [dword ebp-0195Eh]
        call MakeGameKey
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp-0Eh]
        mov edx, 4
        mov eax, dword [DbKeyIndex]
        call DeleteIndexKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
        lea ebx, [byte ebp-0Eh]
        mov edx, 4
        mov eax, esi
        call MakeGameKey
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp-0Eh]
        mov edx, 4
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
.6:
        mov ebx, 194Fh
        mov edx, dword [byte ebp+07Eh]
        mov eax, 2
        jmp near UpdatePlayerRecord_19F
;-----------------------------------------------------------------------------
; MakePlayerStatKey                               E0617  97 PC, low confidence
; Builds the key of a player stats record
;-----------------------------------------------------------------------------
MakePlayerStatKey:
        push ecx
        push esi
        push edi
        enter 4, 0
        mov esi, eax
        mov ecx, ebx
        cmp edx, byte 7
        jb short .4
        lea edi, [byte eax+04h]
        jbe short .1
        cmp edx, byte 8
        je short .3
        jmp short .4
.1:
        mov eax, 4
        mov edx, edi
        call BuildKeyFromLong
.2:
        mov eax, 4
        mov ebx, ecx
        mov edx, esi
        call BuildKeyFromString
        jmp short .5
.3:
        add eax, edx
        mov dword [byte ebp-04h], eax
        lea edx, [byte esi+0Ch]
        mov eax, 4
        call BuildKeyFromLong
        mov edx, dword [byte ebp-04h]
        mov eax, 4
        mov ebx, ecx
        call BuildKeyFromString
        mov eax, 4
        mov ebx, ecx
        mov edx, edi
        call BuildKeyFromString
        jmp short .2
.4:
        xor eax, eax
        leave
        pop edi
        pop esi
        pop ecx
        ret
.5:
        mov eax, 1
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; MakeGoalieStatKey                               E0691  97 PC, low confidence
; Builds the key of a goalie stats record (probably)
;-----------------------------------------------------------------------------
MakeGoalieStatKey:
        push edx
        mov edx, eax
        mov eax, 7
        jmp near MakeLeagueKeyBase_5
;-----------------------------------------------------------------------------
; AddPlayerStat                                   E069E  97 PC, low confidence
; Adds a player stats record
;-----------------------------------------------------------------------------
AddPlayerStat:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 5Ch, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        jmp near OpenGameDatabase_18
.1:
        mov edx, eax
        mov eax, 7
        call MakeLeagueKey
        test eax, eax
        je near OpenGameDatabase_18
        mov ebx, 27h
        lea edx, [byte ebp-04h]
        mov eax, 4
        call AllocRecordSlot
        test eax, eax
        je near OpenGameDatabase_18
        mov ebx, 27h
        mov eax, dword [DbPlayerStatFile]
        mov edx, esi
        call FileWriteRecord
        test eax, eax
        je near OpenGameDatabase_18
        lea ebx, [byte ebp-05Ch]
        mov edx, 7
        mov eax, esi
        call MakePlayerStatKey
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov edx, 7
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        mov edi, eax
        test eax, eax
        je near AddGameRecord_CC
        lea ebx, [byte ebp-030h]
        mov edx, 8
        mov eax, esi
        call MakePlayerStatKey
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 8
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        test eax, eax
        jne near AddGameRecord_CC
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov edx, 7
        jmp near AddGameRecord_C0
;-----------------------------------------------------------------------------
; AddPlayerStatAt                                 E076B  97 PC, low confidence
; Adds a player stats record at a key
;-----------------------------------------------------------------------------
AddPlayerStatAt:
        push ebx
        push ecx
        push esi
        push edi
        enter 5Ch, 0
        push eax
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near FindGameRecord_A0
.2:
        mov eax, dword [edx]
        cmp eax, dword [StaticBuffer]
        je short .1
        mov edi, dword [byte ebp-060h]
        mov ebx, 27h
        mov esi, edx
        mov eax, 4
        lea edx, [byte ebp-04h]
        movsd
        movsd
        call AllocRecordSlot
        test eax, eax
        je near FindGameRecord_A0
        mov ebx, 27h
        mov edx, dword [byte ebp-060h]
        mov eax, dword [DbPlayerStatFile]
        call FileWriteRecord
        test eax, eax
        je near FindGameRecord_A0
        lea ebx, [byte ebp-05Ch]
        mov edx, 7
        mov eax, dword [byte ebp-060h]
        call MakePlayerStatKey
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov edx, 7
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        mov esi, eax
        test eax, eax
        je short AddPlayerStatAt_CA
        lea ebx, [byte ebp-030h]
        mov edx, 8
        mov eax, dword [byte ebp-060h]
        call MakePlayerStatKey
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 8
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        test eax, eax
        jne short AddPlayerStatAt_CA
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov edx, 7
AddPlayerStatAt_BE:
        mov eax, dword [DbKeyIndex]
AddPlayerStatAt_C3:
        call DeleteIndexKey
        xor esi, esi
AddPlayerStatAt_CA:
        call ServiceIdle
        mov eax, esi
        jmp near FindGameRecord_A0
;-----------------------------------------------------------------------------
; FindPlayerStat                                  E0841  97 PC, low confidence
; Finds a player stats record
;-----------------------------------------------------------------------------
FindPlayerStat:
        push ebx
        push ecx
        push esi
        push edi
        enter 38h, 0
        push edx
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        jmp near FindGameRecord_A0
.1:
        lea ebx, [byte ebp-038h]
        lea ecx, [byte ebp-04h]
        mov edi, edx
        mov esi, eax
        mov edx, 7
        mov eax, dword [byte ebp-03Ch]
        movsd
        movsd
        call MakePlayerStatKey
        lea ebx, [byte ebp-038h]
        mov edx, 7
        mov eax, dword [DbKeyIndex]
        call FindIndexKey
        test eax, eax
        je near FindGameRecord_A0
        lea ebx, [byte ebp-0Ch]
        lea edx, [byte ebp-038h]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp-038h]
        lea ebx, [byte ebp-0Ch]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        mov ebx, 8
        mov edx, dword [byte ebp-03Ch]
        lea eax, [byte ebp-0Ch]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je near FindGameRecord_A0
        mov ecx, dword [byte ebp-03Ch]
        mov ebx, 27h
        mov edx, dword [byte ebp-04h]
        mov eax, 4
        jmp near FindGameRecord_9B
;-----------------------------------------------------------------------------
; UpdatePlayerStat                                E08E9  97 PC, low confidence
; Updates a player stats record
;-----------------------------------------------------------------------------
UpdatePlayerStat:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 0B8h, 0
        sub ebp, 82h
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near UpdatePlayerRecord_1A6
.2:
        lea ebx, [byte ebp+022h]
        mov edx, 7
        lea ecx, [byte ebp+07Eh]
        call MakePlayerStatKey
        lea ebx, [byte ebp+022h]
        mov edx, 7
        mov eax, dword [DbKeyIndex]
        call FindIndexKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
        lea ebx, [byte ebp+076h]
        lea edx, [byte ebp+022h]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp+022h]
        lea ebx, [byte ebp+076h]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        mov ebx, 8
        lea eax, [byte ebp+076h]
        mov edx, esi
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne near .4
        mov eax, dword [esi]
        cmp eax, dword [StaticBuffer]
        je short .1
        mov ebx, 27h
        lea edx, [byte ebp+07Eh]
        mov eax, 4
        call AllocRecordSlot
        test eax, eax
        je near UpdatePlayerRecord_1A6
        mov ebx, 27h
        mov eax, dword [DbPlayerStatFile]
        mov edx, esi
        call FileWriteRecord
        test eax, eax
        je near UpdatePlayerRecord_1A6
        lea ebx, [byte ebp+022h]
        mov edx, 7
        mov eax, esi
        call MakePlayerStatKey
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp+022h]
        mov edx, 7
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        mov edi, eax
        test eax, eax
        je short .3
        lea ebx, [byte ebp-036h]
        mov edx, 8
        mov eax, esi
        call MakePlayerStatKey
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp-036h]
        mov edx, 8
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        test eax, eax
        jne short .3
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp+022h]
        mov edx, 7
        mov eax, dword [DbKeyIndex]
        call DeleteIndexKey
        xor edi, edi
.3:
        mov eax, edi
        jmp near UpdatePlayerRecord_1A6
.4:
        call ServiceIdle
        lea ecx, [byte ebp+04Eh]
        mov ebx, 27h
        mov edx, dword [byte ebp+07Eh]
        mov eax, 4
        call ReadDbRecord
        test eax, eax
        je near UpdatePlayerRecord_1A6
        mov ebx, 8
        lea edx, [byte ebp+056h]
        lea eax, [byte esi+08h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne short .5
        lea ebx, [byte ebp-0Ah]
        mov edx, 8
        lea eax, [byte ebp+04Eh]
        call MakePlayerStatKey
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp-0Ah]
        mov edx, 8
        mov eax, dword [DbKeyIndex]
        call DeleteIndexKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
        lea ebx, [byte ebp-0Ah]
        mov edx, 8
        mov eax, esi
        call MakePlayerStatKey
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp-0Ah]
        mov edx, 8
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
.5:
        mov ebx, 27h
        mov edx, dword [byte ebp+07Eh]
        mov eax, 4
        jmp near UpdatePlayerRecord_19F
;-----------------------------------------------------------------------------
; MakeTeamStatKey                                 E0AD0  97 PC, low confidence
; Builds the key of a team stats record
;-----------------------------------------------------------------------------
MakeTeamStatKey:
        push ecx
        push esi
        push edi
        enter 4, 0
        mov esi, eax
        mov ecx, ebx
        cmp edx, byte 5
        jb near .4
        lea edi, [byte eax+04h]
        jbe short .1
        cmp edx, byte 6
        je short .3
        jmp short .4
.1:
        mov eax, 4
        mov edx, edi
        call BuildKeyFromLong
.2:
        mov eax, 4
        mov ebx, ecx
        mov edx, esi
        call BuildKeyFromString
        jmp short .5
.3:
        add eax, byte 10h
        lea edx, [byte esi+014h]
        mov dword [byte ebp-04h], eax
        mov eax, 4
        call BuildKeyFromLong
        mov edx, dword [byte ebp-04h]
        mov eax, 4
        mov ebx, ecx
        call BuildKeyFromString
        mov eax, esi
        mov ebx, ecx
        add eax, byte 8
        lea edx, [byte esi+0Ch]
        mov dword [byte ebp-04h], eax
        mov eax, 4
        call BuildKeyFromString
        mov edx, dword [byte ebp-04h]
        mov eax, 4
        mov ebx, ecx
        call BuildKeyFromString
        mov eax, 4
        mov ebx, ecx
        mov edx, edi
        call BuildKeyFromString
        jmp short .2
.4:
        xor eax, eax
        leave
        pop edi
        pop esi
        pop ecx
        ret
.5:
        mov eax, 1
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; MakeStandingsKey                                E0B75  97 PC, low confidence
; Builds the key of a standings record (probably)
;-----------------------------------------------------------------------------
MakeStandingsKey:
        push edx
        mov edx, eax
        mov eax, 5
        jmp near MakeLeagueKeyBase_5
;-----------------------------------------------------------------------------
; AddTeamStat                                     E0B82  97 PC, low confidence
; Adds a team stats record
;-----------------------------------------------------------------------------
AddTeamStat:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 5Ch, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        jmp near OpenGameDatabase_18
.1:
        mov edx, eax
        mov eax, 5
        call MakeLeagueKey
        test eax, eax
        je near OpenGameDatabase_18
        mov ebx, 3Dh
        lea edx, [byte ebp-04h]
        mov eax, 3
        call AllocRecordSlot
        test eax, eax
        je near OpenGameDatabase_18
        mov ebx, 3Dh
        mov eax, dword [DbTeamStatFile]
        mov edx, esi
        call FileWriteRecord
        test eax, eax
        je near OpenGameDatabase_18
        lea ebx, [byte ebp-05Ch]
        mov edx, 5
        mov eax, esi
        call MakeTeamStatKey
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov edx, 5
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        mov edi, eax
        test eax, eax
        je near AddGameRecord_CC
        lea ebx, [byte ebp-030h]
        mov edx, 6
        mov eax, esi
        call MakeTeamStatKey
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 6
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        test eax, eax
        jne near AddGameRecord_CC
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov edx, 5
        jmp near AddGameRecord_C0
;-----------------------------------------------------------------------------
; AddTeamStatAt                                   E0C4F  97 PC, low confidence
; Adds a team stats record at a key
;-----------------------------------------------------------------------------
AddTeamStatAt:
        push ebx
        push ecx
        push esi
        push edi
        enter 5Ch, 0
        push eax
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        jmp near FindGameRecord_A0
.1:
        mov ebx, 3Dh
        mov edi, eax
        mov esi, edx
        lea edx, [byte ebp-04h]
        mov eax, 3
        movsd
        movsd
        call AllocRecordSlot
        test eax, eax
        je near FindGameRecord_A0
        mov ebx, 3Dh
        mov edx, dword [byte ebp-060h]
        mov eax, dword [DbTeamStatFile]
        call FileWriteRecord
        test eax, eax
        je near FindGameRecord_A0
        lea ebx, [byte ebp-05Ch]
        mov edx, 5
        mov eax, dword [byte ebp-060h]
        call MakeTeamStatKey
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov edx, 5
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        mov esi, eax
        test eax, eax
        je near AddPlayerStatAt_CA
        lea ebx, [byte ebp-030h]
        mov edx, 6
        mov eax, dword [byte ebp-060h]
        call MakeTeamStatKey
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 6
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        test eax, eax
        jne near AddPlayerStatAt_CA
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov edx, 5
        jmp near AddPlayerStatAt_BE
;-----------------------------------------------------------------------------
; FindTeamStat                                    E0D0F  97 PC, low confidence
; Finds a team stats record
;-----------------------------------------------------------------------------
FindTeamStat:
        push ebx
        push ecx
        push esi
        push edi
        enter 38h, 0
        push edx
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        jmp near FindGameRecord_A0
.1:
        lea ebx, [byte ebp-038h]
        lea ecx, [byte ebp-04h]
        mov edi, edx
        mov esi, eax
        mov edx, 5
        mov eax, dword [byte ebp-03Ch]
        movsd
        movsd
        call MakeTeamStatKey
        lea ebx, [byte ebp-038h]
        mov edx, 5
        mov eax, dword [DbKeyIndex]
        call FindIndexKey
        test eax, eax
        je near FindGameRecord_A0
        lea ebx, [byte ebp-0Ch]
        lea edx, [byte ebp-038h]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp-038h]
        lea ebx, [byte ebp-0Ch]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        mov ebx, 8
        mov edx, dword [byte ebp-03Ch]
        lea eax, [byte ebp-0Ch]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je near FindGameRecord_A0
        mov ecx, dword [byte ebp-03Ch]
        mov ebx, 3Dh
        mov edx, dword [byte ebp-04h]
        mov eax, 3
        jmp near FindGameRecord_9B
;-----------------------------------------------------------------------------
; ReadTeamStats                                   E0DB7  97 PC, low confidence
; Reads a team's stats records
;-----------------------------------------------------------------------------
ReadTeamStats:
        push ecx
        push esi
        push edi
        enter 54h, 0
        push eax
        push edx
        push ebx
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        leave
        pop edi
        pop esi
        pop ecx
        ret
.1:
        mov edi, ebx
        mov esi, edx
        lea edi, [byte edi+010h]
        movsd
        movsd
        mov edi, ebx
        mov esi, eax
        lea edi, [byte edi+08h]
        movsd
        movsd
        mov edx, 6
        mov dword [ebx], 0
        mov eax, ebx
        mov dword [byte ebx+04h], 0
        lea ebx, [byte ebp-054h]
        lea ecx, [byte ebp-018h]
        call MakeTeamStatKey
        lea ebx, [byte ebp-054h]
        mov edx, 6
        mov eax, dword [DbKeyIndex]
        call FindIndexKey
        test eax, eax
        je near .6
        lea edi, [byte ebp-020h]
        lea edx, [byte ebp-054h]
        add edi, byte 4
        mov eax, 4
        mov ebx, edi
        call KeyToLong
        lea edx, [byte ebp-054h]
        lea ebx, [byte ebp-020h]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        mov ebx, 8
        mov edx, dword [byte ebp-05Ch]
        lea eax, [byte ebp-020h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je near .6
        lea ecx, [byte ebp-028h]
        lea edx, [byte ebp-04Ah]
        mov eax, 4
        add ecx, byte 4
        lea esi, [byte ebp-04Ah]
        mov ebx, ecx
        add esi, byte 5
        call KeyToLong
        lea ebx, [byte ebp-028h]
        mov eax, 4
        mov edx, esi
        call KeyToLong
        mov ebx, 8
        mov edx, dword [byte ebp-058h]
        lea eax, [byte ebp-028h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je near .6
        lea eax, [byte ebp-054h]
        mov dword [byte ebp-04h], ecx
        mov dword [byte ebp-08h], esi
        add eax, byte 5
        mov dword [byte ebp-014h], edi
        mov dword [byte ebp-010h], eax
.2:
        mov eax, dword [byte ebp-018h]
        lea ecx, [byte ebp-018h]
        lea ebx, [byte ebp-054h]
        mov edx, 6
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [DbKeyIndex]
        call NextIndexKey
        test eax, eax
        je near .6
        cmp byte [byte ebp-054h], 0
        jne short .3
        cmp dword [byte ebp-018h], byte 0FFFFFFFFh
        jne short .3
        lea edi, [byte ebp-020h]
        mov esi, DbKeyBuffer
        movsd
        movsd
        jmp short .4
.3:
        mov ebx, dword [byte ebp-014h]
        lea edx, [byte ebp-054h]
        mov eax, 4
        call KeyToLong
        lea ebx, [byte ebp-020h]
        mov edx, dword [byte ebp-010h]
        mov eax, 4
        call KeyToLong
        mov ebx, dword [byte ebp-04h]
        lea edx, [byte ebp-04Ah]
        mov eax, 4
        call KeyToLong
        lea ebx, [byte ebp-028h]
        mov edx, dword [byte ebp-08h]
        mov eax, 4
        call KeyToLong
.4:
        mov ebx, 8
        mov edx, dword [byte ebp-05Ch]
        lea eax, [byte ebp-020h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .5
        mov edx, dword [byte ebp-058h]
        lea eax, [byte ebp-028h]
        call KeysEqual
        test eax, eax
        jne near .2
.5:
        mov ecx, dword [byte ebp-060h]
        mov ebx, 3Dh
        mov edx, dword [byte ebp-0Ch]
        mov eax, 3
        call ReadDbRecord
.6:
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; UpdateTeamStat                                  E0F85  97 PC, low confidence
; Updates a team stats record
;-----------------------------------------------------------------------------
UpdateTeamStat:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 0D0h, 0
        sub ebp, 82h
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near UpdatePlayerRecord_1A6
.2:
        lea ebx, [byte ebp+04Ah]
        mov edx, 5
        lea ecx, [byte ebp+07Eh]
        call MakeTeamStatKey
        lea ebx, [byte ebp+04Ah]
        mov edx, 5
        mov eax, dword [DbKeyIndex]
        call FindIndexKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
        lea ebx, [byte ebp+076h]
        lea edx, [byte ebp+04Ah]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp+04Ah]
        lea ebx, [byte ebp+076h]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        mov ebx, 8
        lea eax, [byte ebp+076h]
        mov edx, esi
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne near .4
        mov eax, dword [esi]
        cmp eax, dword [StaticBuffer]
        je short .1
        mov ebx, 3Dh
        lea edx, [byte ebp+07Eh]
        mov eax, 3
        call AllocRecordSlot
        test eax, eax
        je near UpdatePlayerRecord_1A6
        mov ebx, 3Dh
        mov eax, dword [DbTeamStatFile]
        mov edx, esi
        call FileWriteRecord
        test eax, eax
        je near UpdatePlayerRecord_1A6
        lea ebx, [byte ebp+04Ah]
        mov edx, 5
        mov eax, esi
        call MakeTeamStatKey
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp+04Ah]
        mov edx, 5
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        mov edi, eax
        test eax, eax
        je short .3
        lea ebx, [byte ebp+01Eh]
        mov edx, 6
        mov eax, esi
        call MakeTeamStatKey
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp+01Eh]
        mov edx, 6
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        test eax, eax
        jne short .3
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp+04Ah]
        mov edx, 5
        mov eax, dword [DbKeyIndex]
        call DeleteIndexKey
        xor edi, edi
.3:
        mov eax, edi
        jmp near UpdatePlayerRecord_1A6
.4:
        call ServiceIdle
        lea ecx, [byte ebp-04Eh]
        mov ebx, 3Dh
        mov edx, dword [byte ebp+07Eh]
        mov eax, 3
        call ReadDbRecord
        test eax, eax
        je near UpdatePlayerRecord_1A6
        mov ebx, 8
        lea edx, [byte ebp-03Eh]
        lea eax, [byte esi+010h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .5
        lea edx, [byte ebp-046h]
        lea eax, [byte esi+08h]
        call KeysEqual
        test eax, eax
        jne short .6
.5:
        lea ebx, [byte ebp-0Eh]
        mov edx, 6
        lea eax, [byte ebp-04Eh]
        call MakeTeamStatKey
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp-0Eh]
        mov edx, 6
        mov eax, dword [DbKeyIndex]
        call DeleteIndexKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
        lea ebx, [byte ebp-0Eh]
        mov edx, 6
        mov eax, esi
        call MakeTeamStatKey
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp-0Eh]
        mov edx, 6
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
.6:
        mov ebx, 3Dh
        mov edx, dword [byte ebp+07Eh]
        mov eax, 3
        jmp near UpdatePlayerRecord_19F
;-----------------------------------------------------------------------------
; LoadExhibitionFile                           E117B  97 PC, medium confidence
; (&block): reads the exhibition file %s%s.EXH into a new "EXHIBIT" block
; (383C1h bytes) with its "AGENTS" part
;-----------------------------------------------------------------------------
LoadExhibitionFile:
        push ebx
        push ecx
        push edx
        enter 54h, 0
        mov ecx, eax
        push dword [LeagueFileDir]
        push dword [LeagueFilePrefix]
        push str_SSEXH
        lea eax, [byte ebp-054h]
        push eax
        call sprintf_
        add esp, byte 10h
        lea edx, [byte ebp-04h]
        lea eax, [byte ebp-054h]
        call FileOpen
        test eax, eax
        je near .5
        mov edx, 383C5h
        mov eax, str_EXHIBIT
        mov ebx, ecx
        call AllocClearBlock
        test eax, eax
        je short .2
        mov ebx, 383C1h
        mov eax, dword [byte ebp-04h]
        mov edx, dword [ecx]
        call FileReadRecord
        test eax, eax
        jne short .3
.1:
        mov eax, ecx
        call FreePtr
.2:
        lea eax, [byte ebp-04h]
        call FileClose
        xor eax, eax
        leave
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov eax, dword [ecx]
        cmp word [eax], byte 0
        jle short .4
        movsx edx, word [eax]
        imul edx, byte 38h
        lea ebx, [dword eax+0383C1h]
        mov eax, str_AGENTS
        call AllocClearBlock
        test eax, eax
        je short .1
        call ServiceIdle
        mov eax, dword [ecx]
        movsx ebx, word [eax]
        imul ebx, byte 38h
        mov edx, dword [dword eax+0383C1h]
        mov eax, dword [byte ebp-04h]
        call FileReadRecord
        test eax, eax
        je short .1
.4:
        lea eax, [byte ebp-04h]
        call FileClose
        mov eax, 1
.5:
        leave
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SaveExhibitionFile                           E1245  97 PC, medium confidence
; (block): writes the exhibition file %s%s.EXH
;-----------------------------------------------------------------------------
SaveExhibitionFile:
        push ebx
        push ecx
        push edx
        enter 54h, 0
        mov ecx, eax
        push dword [LeagueFileDir]
        push dword [LeagueFilePrefix]
        push str_SSEXH
        lea eax, [byte ebp-054h]
        push eax
        call sprintf_
        add esp, byte 10h
        lea edx, [byte ebp-04h]
        lea eax, [byte ebp-054h]
        call FileCreate
        test eax, eax
        je short .4
        mov ebx, 383C1h
        mov eax, dword [byte ebp-04h]
        mov edx, ecx
        call FileWriteRecord
        test eax, eax
        jne short .2
.1:
        lea eax, [byte ebp-04h]
        call FileClose
        xor eax, eax
        leave
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        call ServiceIdle
        cmp word [ecx], byte 0
        jle short .3
        movsx ebx, word [ecx]
        imul ebx, byte 38h
        mov eax, dword [byte ebp-04h]
        mov edx, dword [dword ecx+0383C1h]
        call FileWriteRecord
        test eax, eax
        je short .1
.3:
        lea eax, [byte ebp-04h]
        call FileClose
        mov eax, 1
.4:
        leave
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FreeExhibitionFile                           E12D1  97 PC, medium confidence
; (&block): frees the exhibition block and its agents part (+383C1h)
;-----------------------------------------------------------------------------
FreeExhibitionFile:
        push edx
        mov edx, eax
        mov eax, dword [eax]
        cmp word [eax], byte 0
        jle short .1
        add eax, 383C1h
        call FreePtr
.1:
        mov eax, edx
        call FreePtr
        pop edx
        ret
;-----------------------------------------------------------------------------
; ResetExhibitionStats                            E12EF  97 PC, low confidence
; Resets the exhibition stats
;-----------------------------------------------------------------------------
ResetExhibitionStats:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 10h, 0
        mov ecx, eax
        mov edx, 383C5h
        mov ebx, eax
        mov eax, str_ORIGEXH
        call AllocClearBlock
        test eax, eax
        je near OpenGameDatabase_18
        mov eax, dword [ecx]
        mov word [eax], 0
        xor ebx, ebx
        mov eax, dword [ecx]
        mov dword [byte ebp-04h], 0
        mov dword [byte ebp-08h], ebx
        mov dword [dword eax+0383C1h], 0
.1:
        mov eax, dword [byte ebp-04h]
        mov dword [byte ebp-010h], 0
        mov dword [byte ebp-0Ch], eax
        mov edx, dword [ecx]
        add edx, 0DF4h
        lea eax, [byte ebp-010h]
        add edx, ebx
        call FindGameRecord
        test eax, eax
        jne short .3
.2:
        mov eax, ecx
        call FreePtr
        xor eax, eax
        jmp near OpenGameDatabase_18
.3:
        call ServiceIdle
        mov eax, dword [ecx]
        lea edx, [byte eax+02h]
        add eax, 0DF4h
        add eax, ebx
        add edx, dword [byte ebp-08h]
        add eax, byte 10h
        call FindTeamRecord
        test eax, eax
        je short .2
        mov esi, dword [ecx]
        lea edi, [dword esi+ebx+0DF4h]
        mov esi, DbKeyBuffer
        movsd
        movsd
        mov esi, dword [ecx]
        add dword [byte ebp-08h], byte 66h
        lea edi, [dword esi+ebx+0DFCh]
        mov esi, DbKeyBuffer
        inc dword [byte ebp-04h]
        add ebx, 194Fh
        movsd
        movsd
        cmp dword [byte ebp-04h], byte 23h
        jl near .1
        jmp near OpenGameDatabase_13
;-----------------------------------------------------------------------------
; ResetExhibitionFile                             E13BF  97 PC, low confidence
; Builds the original exhibition data (ResetExhibitionStats, "ORIGEXH") and saves it as
; the exhibition file
;-----------------------------------------------------------------------------
ResetExhibitionFile:
        push ebx
        push edx
        enter 4, 0
        lea eax, [byte ebp-04h]
        call ResetExhibitionStats
        test eax, eax
        je short .2
        mov eax, dword [byte ebp-04h]
        call SaveExhibitionFile
        mov ebx, eax
        mov eax, dword [byte ebp-04h]
        lea edx, [byte ebp-04h]
        cmp word [eax], byte 0
        jle short .1
        add eax, 383C1h
        call FreePtr
.1:
        mov eax, edx
        call FreePtr
        mov eax, ebx
.2:
        leave
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ImportTradedPlayers                             E13FE  97 PC, low confidence
; Imports the traded players
;-----------------------------------------------------------------------------
ImportTradedPlayers:
        push esi
        push edi
        enter 40h, 0
        push eax
        push edx
        mov esi, ebx
        mov dword [byte ebp-04h], ecx
        mov ecx, dword [byte ebp+010h]
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near .4
.2:
        cmp dword [edx], byte 0
        je short .1
        mov eax, dword [byte ebp-04h]
        cmp dword [eax], byte 0
        je short .1
        mov eax, dword [edx]
        cmp eax, dword [StaticBuffer]
        je short .1
        mov eax, dword [byte ebp-04h]
        mov eax, dword [eax]
        cmp eax, dword [StaticBuffer]
        je short .1
        mov eax, dword [byte ebp-044h]
        movsx eax, word [eax]
        inc eax
        imul edx, eax, byte 38h
        lea ebx, [byte ebp-08h]
        mov eax, str_AGENTS
        call AllocClearBlock
        test eax, eax
        je near .4
        mov eax, dword [byte ebp-044h]
        cmp word [eax], byte 0
        jle short .3
        movsx ebx, word [eax]
        imul ebx, byte 38h
        mov edx, dword [byte ebp-08h]
        mov eax, dword [dword eax+0383C1h]
        call CopyBytesOk
.3:
        mov eax, dword [byte ebp-044h]
        add eax, 383C1h
        mov edx, dword [byte ebp-044h]
        call FreePtr
        mov eax, dword [byte ebp-08h]
        mov dword [dword edx+0383C1h], eax
        mov edx, 38h
        lea eax, [byte ebp-040h]
        call ZeroBytesOk
        mov al, byte [byte ebp+014h]
        mov ebx, 8
        mov byte [byte ebp-03Fh], al
        mov al, byte [byte ebp+018h]
        mov edx, esi
        mov byte [byte ebp-03Eh], al
        lea eax, [byte ebp-048h]
        call CopyBytesOk
        mov edx, dword [byte ebp-048h]
        mov eax, esi
        call AddTradeRecord
        test eax, eax
        je near .4
        mov ebx, 8
        lea eax, [byte ebp-048h]
        lea edx, [byte ecx+08h]
        call CopyBytesOk
        mov ebx, 8
        lea eax, [byte ebp-04h]
        mov edx, ecx
        call CopyBytesOk
        mov edx, dword [byte ebp-04h]
        mov eax, ecx
        call AddPlayerStatAt
        test eax, eax
        je short .4
        lea edi, [byte ebp-028h]
        movsd
        movsd
        lea edi, [byte ebp-010h]
        mov esi, ecx
        movsd
        movsd
        lea edi, [byte ebp-018h]
        lea esi, [byte ebp-010h]
        movsd
        movsd
        lea edi, [byte ebp-020h]
        mov esi, DbKeyBuffer
        mov edx, dword [byte ebp-044h]
        movsd
        movsd
        movsx edx, word [edx]
        imul edx, byte 38h
        mov eax, dword [byte ebp-044h]
        mov eax, dword [dword eax+0383C1h]
        mov ebx, 38h
        add edx, eax
        lea eax, [byte ebp-040h]
        call CopyBytesOk
        mov eax, dword [byte ebp-044h]
        mov ax, word [eax]
        mov edx, eax
        mov ebx, dword [byte ebp-044h]
        inc edx
        mov word [ebx], dx
        mov edx, dword [byte ebp+01Ch]
        mov word [edx], ax
        call ServiceIdle
        mov eax, 1
.4:
        leave
        pop edi
        pop esi
        ret 10h
;-----------------------------------------------------------------------------
; ImportNewPlayers                                E1563  97 PC, low confidence
; Imports new players
;-----------------------------------------------------------------------------
ImportNewPlayers:
        push esi
        push edi
        enter 40h, 0
        push eax
        mov esi, edx
        mov dword [byte ebp-08h], ebx
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        jmp near .3
.1:
        movsx eax, word [eax]
        inc eax
        imul edx, eax, byte 38h
        lea ebx, [byte ebp-04h]
        mov eax, str_AGENTS
        call AllocClearBlock
        test eax, eax
        je near .3
        mov eax, dword [byte ebp-044h]
        cmp word [eax], byte 0
        jle short .2
        movsx ebx, word [eax]
        imul ebx, byte 38h
        mov edx, dword [byte ebp-04h]
        mov eax, dword [dword eax+0383C1h]
        call CopyBytesOk
.2:
        mov eax, dword [byte ebp-044h]
        add eax, 383C1h
        mov edx, dword [byte ebp-044h]
        call FreePtr
        mov eax, dword [byte ebp-04h]
        mov dword [dword edx+0383C1h], eax
        mov edx, 38h
        lea eax, [byte ebp-040h]
        call ZeroBytesOk
        mov al, byte [byte ebp+010h]
        mov byte [byte ebp-03Eh], al
        mov eax, esi
        mov byte [byte ebp-03Fh], cl
        call AddPlayerRecord
        test eax, eax
        je near .3
        mov edx, dword [byte ebp-08h]
        mov ebx, 8
        mov eax, esi
        add edx, byte 8
        call CopyBytesOk
        mov eax, dword [byte ebp-08h]
        call AddPlayerStat
        test eax, eax
        je short .3
        lea edi, [byte ebp-028h]
        movsd
        movsd
        lea edi, [byte ebp-010h]
        mov esi, dword [byte ebp-08h]
        movsd
        movsd
        lea edi, [byte ebp-018h]
        lea esi, [byte ebp-010h]
        movsd
        movsd
        lea edi, [byte ebp-020h]
        mov esi, DbKeyBuffer
        mov edx, dword [byte ebp-044h]
        movsd
        movsd
        movsx edx, word [edx]
        imul edx, byte 38h
        mov eax, dword [byte ebp-044h]
        mov eax, dword [dword eax+0383C1h]
        mov ebx, 38h
        add edx, eax
        lea eax, [byte ebp-040h]
        call CopyBytesOk
        mov eax, dword [byte ebp-044h]
        mov ax, word [eax]
        mov edx, eax
        mov ebx, dword [byte ebp-044h]
        inc edx
        mov word [ebx], dx
        mov edx, dword [byte ebp+014h]
        mov word [edx], ax
        call ServiceIdle
        mov eax, 1
.3:
        leave
        pop edi
        pop esi
        ret 8
;-----------------------------------------------------------------------------
; AllocImportBuffer                               E167A  97 PC, low confidence
; Allocates the import buffer
;-----------------------------------------------------------------------------
AllocImportBuffer:
        push ebx
        push ecx
        push esi
        push edi
        enter 10h, 0
        mov ecx, eax
        mov esi, edx
        cmp dx, word [eax]
        jl short .2
.1:
        xor eax, eax
        jmp near FindGameRecord_A0
.2:
        movsx eax, dx
        imul eax, byte 38h
        mov edx, dword [dword ecx+0383C1h]
        cmp dword [byte edx+eax+018h], byte 0
        je short .1
        cmp word [ecx], byte 1
        jne short .3
        lea eax, [dword ecx+0383C1h]
        call FreePtr
        mov eax, 1
        mov word [ecx], 0
        jmp near FindGameRecord_A0
.3:
        movsx eax, word [ecx]
        dec eax
        imul edx, eax, byte 38h
        lea ebx, [byte ebp-010h]
        mov eax, str_AGENTS
        call AllocClearBlock
        test eax, eax
        je near FindGameRecord_A0
        xor edi, edi
        mov dword [byte ebp-08h], 0
        mov dword [byte ebp-04h], edi
        mov dword [byte ebp-0Ch], edi
        jmp short .6
.4:
        movsx eax, si
        cmp edi, eax
        je short .5
        mov edx, dword [byte ebp-0Ch]
        inc dword [byte ebp-08h]
        mov ebx, 38h
        mov eax, dword [dword ecx+0383C1h]
        add edx, dword [byte ebp-010h]
        add eax, dword [byte ebp-04h]
        add dword [byte ebp-0Ch], byte 38h
        call CopyBytesOk
.5:
        add dword [byte ebp-04h], byte 38h
        inc edi
.6:
        movsx eax, word [ecx]
        cmp edi, eax
        jl short .4
        mov eax, dword [byte ebp-08h]
        mov word [ecx], ax
        lea eax, [dword ecx+0383C1h]
        call FreePtr
        mov eax, dword [byte ebp-010h]
        mov dword [dword ecx+0383C1h], eax
        jmp near LookupRecord_244
;-----------------------------------------------------------------------------
; PickDemoTeams                                   E1744  97 PC, low confidence
; Picks the teams for a demo game
;-----------------------------------------------------------------------------
PickDemoTeams:
        push esi
        push edi
        enter 8, 0
        push eax
        push edx
        push ebx
        lea eax, [byte ebp-08h]
        call _dos_getdate_
        test dx, dx
        jl short .1
        cmp dx, byte 23h
        jge short .1
        test bx, bx
        jl short .1
        cmp bx, byte 23h
        jl short .2
.1:
        xor eax, eax
        leave
        pop edi
        pop esi
        ret
.2:
        mov edx, 4A78h
        mov esi, DbKeyBuffer
        mov eax, ecx
        mov edi, ecx
        call ZeroBytesOk
        movsd
        movsd
        mov esi, DbKeyBuffer
        lea edi, [byte ecx+08h]
        movsd
        movsd
        movzx ebx, byte [byte ebp-08h]
        movzx edx, byte [byte ebp-07h]
        movsx eax, word [byte ebp-06h]
        call DaysToYear
        mov word [byte ecx+012h], 131Eh
        mov word [byte ecx+010h], ax
        cmp word [byte ebp-010h], byte 1Ah
        jge short .3
        mov eax, dword [byte ebp-010h]
        mov word [byte ecx+014h], ax
        jmp near .14
.3:
        je short .4
        cmp word [byte ebp-010h], byte 1Bh
        je short .4
        cmp word [byte ebp-014h], byte 1Ah
        je short .4
        cmp word [byte ebp-014h], byte 1Bh
        jne near .10
.4:
        cmp word [byte ebp-010h], byte 1Ah
        jne short .5
        cmp word [byte ebp-014h], byte 1Ah
        je short .8
.5:
        cmp word [byte ebp-010h], byte 1Ah
        jne short .6
        cmp word [byte ebp-014h], byte 1Bh
        je short .8
.6:
        cmp word [byte ebp-010h], byte 1Bh
        jne short .7
        cmp word [byte ebp-014h], byte 1Ah
        je short .8
.7:
        cmp word [byte ebp-010h], byte 1Bh
        jne short .9
        cmp word [byte ebp-014h], byte 1Bh
        jne short .9
.8:
        mov word [byte ecx+014h], 15h
        jmp short .14
.9:
        call rand_
        mov ebx, 1Ah
        cdq
        idiv ebx
        mov word [byte ecx+014h], dx
        cmp dx, word [byte ebp-014h]
        jne short .14
        jmp short .13
.10:
        cmp word [byte ebp-010h], byte 21h
        je short .11
        cmp word [byte ebp-010h], byte 22h
        jne short .12
.11:
        mov word [byte ecx+014h], 18h
        jmp short .14
.12:
        call rand_
        mov ebx, 1Ah
        cdq
        idiv ebx
        mov word [byte ecx+014h], dx
        cmp dx, word [byte ebp-014h]
        jne short .14
.13:
        movsx eax, dx
        inc eax
        cdq
        idiv ebx
        mov word [byte ecx+014h], dx
.14:
        movsx eax, word [byte ebp-014h]
        imul edx, eax, dword 194Fh
        movsx ebx, word [byte ebp-010h]
        imul ebx, dword 194Fh
        mov eax, dword [byte ebp-0Ch]
        add eax, 0DF4h
        add edx, eax
        add eax, ebx
        mov ebx, ecx
        call LoadGameRosters
        leave
        pop edi
        pop esi
        ret
        push esi
        push edi
        enter 8, 0
        push eax
        push edx
        push ebx
        push ecx
        mov ecx, dword [byte ebp+010h]
        lea eax, [byte ebp-08h]
        call _dos_getdate_
        cmp word [byte ebp-0Ch], byte 0
        jl short .15
        cmp word [byte ebp-0Ch], byte 23h
        jge short .15
        test dx, dx
        jl short .15
        cmp dx, byte 23h
        jl short .16
.15:
        xor eax, eax
        jmp near SaveGameResult_55
.16:
        mov edx, 4A78h
        mov esi, DbKeyBuffer
        mov eax, ecx
        mov edi, ecx
        call ZeroBytesOk
        movsd
        movsd
        mov esi, DbKeyBuffer
        lea edi, [byte ecx+08h]
        movsd
        movsd
        movzx ebx, byte [byte ebp-08h]
        movzx edx, byte [byte ebp-07h]
        movsx eax, word [byte ebp-06h]
        call DaysToYear
        mov word [byte ecx+012h], 131Eh
        mov word [byte ecx+010h], ax
        cmp word [byte ebp-0Ch], byte 1Ah
        jge short .17
        mov eax, dword [byte ebp-0Ch]
        mov word [byte ecx+014h], ax
        jmp near .28
.17:
        je short .18
        cmp word [byte ebp-0Ch], byte 1Bh
        je short .18
        cmp word [byte ebp-010h], byte 1Ah
        je short .18
        cmp word [byte ebp-010h], byte 1Bh
        jne near .24
.18:
        cmp word [byte ebp-0Ch], byte 1Ah
        jne short .19
        cmp word [byte ebp-010h], byte 1Ah
        je short .22
.19:
        cmp word [byte ebp-0Ch], byte 1Ah
        jne short .20
        cmp word [byte ebp-010h], byte 1Bh
        je short .22
.20:
        cmp word [byte ebp-0Ch], byte 1Bh
        jne short .21
        cmp word [byte ebp-010h], byte 1Ah
        je short .22
.21:
        cmp word [byte ebp-0Ch], byte 1Bh
        jne short .23
        cmp word [byte ebp-010h], byte 1Bh
        jne short .23
.22:
        mov word [byte ecx+014h], 15h
        jmp short .28
.23:
        call rand_
        mov ebx, 1Ah
        cdq
        idiv ebx
        mov word [byte ecx+014h], dx
        cmp dx, word [byte ebp-010h]
        jne short .28
        jmp short .27
.24:
        cmp word [byte ebp-0Ch], byte 21h
        je short .25
        cmp word [byte ebp-0Ch], byte 22h
        jne short .26
.25:
        mov word [byte ecx+014h], 18h
        jmp short .28
.26:
        call rand_
        mov ebx, 1Ah
        cdq
        idiv ebx
        mov word [byte ecx+014h], dx
        cmp dx, word [byte ebp-010h]
        jne short .28
.27:
        movsx eax, dx
        inc eax
        cdq
        idiv ebx
        mov word [byte ecx+014h], dx
.28:
        mov edx, dword [byte ebp-018h]
        mov eax, dword [byte ebp-014h]
        mov ebx, ecx
        call LoadGameRosters
        jmp near SaveGameResult_55
