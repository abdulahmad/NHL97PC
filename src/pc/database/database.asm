; Game database: buffers, record keys, rosters and records, repair.
bits 32
%include "hockey.inc"
section s_DA66D progbits alloc exec nowrite align=1
extern AddGameRecord_C5, AddGameRecord_CC, AddIndexKey, AllocClearBlock, AllocClearBlock20, AllocMemBlock, AllocPageStack, bcopy
extern BuildKeyFromLong, BuildKeyFromString, CloseDbFile, CopyBytesOk, DbDirName, DbFileExtensions, DbFileNames, DbFileSuffix
extern DbFileTable, DbGameIndex, DbGameRecordCount, DbGameRecords, DbIndexRoot, DbKeyBuffer, DbOpen, DbPlayerIndex
extern DbPlayerRecordCount, DbPlayerRecords, DbRecordCounts, DbRecordSizes, DbRecordsLoaded, DbStaticBuffer, DbStatRecordCount, DbStatRecords
extern DbTeamRecordCount, DbTeamRecords, DeleteIndexKey, DosCallRegs, FileClose, FileOpen, FileReadRecord, FileSeek
extern FileSeekEnd, FileTell, FileWriteRecord, FindFirstKey, FindGameRecord_A0, FindIndexKey, FindLastKey, FindPlayerRecord
extern FindPlayerStat, FindTeamRecord, FindTeamStat, FreeDbPages, FreeMemBlock, FreePtr, int386x_, KeyToLong
extern LeagueFilePrefix, MatchupTeamCodes, memcmp_, MonthStartDays, NextIndexKey, OpenDbFile, PrevIndexKey, segread_
extern ServiceIdle, StaticBuffer, StaticBufferReady, str_MEDIABUFFER, str_Punct_DaysToYear, str_Punct_SetMatchupTeams, str_STATICBUF, str_TEMP2
extern strcat_, StrCopyEnd, strcpy_, strlen_, tickcount, UpdatePlayerRecord_1A6, UpdatePlayerRecord_1AD, UpdatePlayerRecord_229
extern ZeroBytesOk
global AllocMediaBuffer, AllocStaticBuffer, MakeRecordKey, MakeRecordKey_16, MakeRecordKey_24, MakeKeyPair, KeysEqual, OpenGameDatabase
global OpenGameDatabase_13, OpenGameDatabase_18, LoadHomeRosterRecords, LoadAwayRosterRecords, SetMatchupTeams, LoadMatchupRosters, LoadGameRosters, WriteDbRecordJumpTable
global WriteDbRecord, WriteDbRecord_5C, WriteDbRecord_102, WriteDbRecord_152, WriteDbRecord_1AA, DbGameRecordJumpTable, DbPlayerRecordJumpTable, ReadDbRecord
global ReadDbRecord_62, ReadDbRecord_16E, ReadDbRecord_200, ReadDbRecord_296, ReadDbRecord_33C, ReadDbRecord_3BF, ReadDbRecord_42C, ReadDbRecord_495
global AppendDbRecord, AllocRecordSlot, CloseGameDatabase, InitDbState, FreeDbBlock, DaysToYear, AgeFromBirthDate, NewRecordKey
global LookupRecordJumpTable, LookupRecord, LookupRecord_2D, LookupRecord_49, LookupRecord_AC, LookupRecord_FD, LookupRecord_236, LookupRecord_244
global LookupRecord_249, LookupRecord_307, LookupRecord_30C, FindRecordByKey, FindRecordByKey_1BC, CountDbRecords, RebuildDbIndex, RepairDatabase
global RepairDatabase_21E, RepairDatabase_52F
;-----------------------------------------------------------------------------
; AllocMediaBuffer                             DA66D  97 PC, medium confidence
; Allocates the "MEDIA BUFFER" (200h paragraphs of DOS memory)
;-----------------------------------------------------------------------------
AllocMediaBuffer:
        push ebx
        push ecx
        push edx
        push esi
        enter 28h, 0
        push dword 200h
        push byte 19h
        push str_MEDIABUFFER
        lea ebx, [byte ebp-028h]
        call AllocMemBlock
        lea ecx, [byte ebp-0Ch]
        mov esi, eax
        add esp, byte 0Ch
        mov word [eax], 0
        sar eax, 4
        mov edx, ds
        mov word [DosCallRegs+24h], ax
        mov eax, esi
        mov dword [DosCallRegs+1Ch], 440Dh
        and eax, byte 0Fh
        mov dword [DosCallRegs+10h], 3
        mov dword [DosCallRegs+14h], eax
        lea eax, [byte ebp-0Ch]
        mov dword [DosCallRegs+18h], 866h
        call segread_
        mov word [byte ebp-028h], 300h
        mov word [byte ebp-024h], 21h
        mov eax, DosCallRegs
        mov word [byte ebp-020h], 0
        mov eax, 31h
        mov word [byte ebp-0Ch], dx
        lea edx, [byte ebp-028h]
        mov dword [byte ebp-014h], DosCallRegs
        call int386x_
        push esi
        mov ebx, dword [byte esi+02h]
        call FreeMemBlock
        add esp, byte 4
        mov eax, ebx
        jmp near UpdatePlayerRecord_229
;-----------------------------------------------------------------------------
; AllocStaticBuffer                            DA713  97 PC, medium confidence
; Allocates the "STATIC BUF" once (flag StaticBufferReady)
;-----------------------------------------------------------------------------
AllocStaticBuffer:
        push ebx
        push edx
        cmp word [StaticBufferReady], byte 0
        je short .1
        xor eax, eax
        pop edx
        pop ebx
        ret
.1:
        mov ebx, DbStaticBuffer
        mov edx, 67h
        mov eax, str_STATICBUF
        call AllocClearBlock20
        test eax, eax
        je short .2
        mov word [StaticBufferReady], 1
        call AllocMediaBuffer
        mov dword [StaticBuffer], eax
        mov eax, 1
.2:
        pop edx
        pop ebx
        ret
        push ebx
        mov ebx, dword [StaticBuffer]
        mov dword [edx], ebx
        mov dword [byte edx+04h], eax
        mov eax, 1
        pop ebx
        ret
;-----------------------------------------------------------------------------
; MakeRecordKey                                   DA76A  97 PC, low confidence
; Builds the key of a record from its type and number
;-----------------------------------------------------------------------------
MakeRecordKey:
        push ebx
        push ecx
        push esi
        mov esi, eax
        mov ecx, edx
        lea edx, [byte eax+04h]
        mov ebx, ecx
        mov eax, 4
        call BuildKeyFromLong
MakeRecordKey_16:
        mov eax, 4
        mov ebx, ecx
        mov edx, esi
        call BuildKeyFromString
MakeRecordKey_24:
        mov eax, 1
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; MakeKeyPair                                     DA797  97 PC, low confidence
; Builds a two-part record key
;-----------------------------------------------------------------------------
MakeKeyPair:
        push ebx
        push ecx
        push esi
        mov esi, eax
        mov ecx, edx
        lea edx, [byte eax+04h]
        mov ebx, ecx
        mov eax, 4
        call BuildKeyFromString
        jmp short MakeRecordKey_16
        push ebx
        push ecx
        push esi
        mov ecx, eax
        mov esi, edx
        lea ebx, [byte edx+04h]
        mov edx, eax
        mov eax, 4
        call KeyToLong
        mov eax, 4
        lea edx, [byte ecx+05h]
        mov ebx, esi
        call KeyToLong
        jmp short MakeRecordKey_24
;-----------------------------------------------------------------------------
; KeysEqual                                       DA7D6  97 PC, low confidence
; Returns 1 when two eight-byte keys are equal
;-----------------------------------------------------------------------------
KeysEqual:
        push ebx
        mov ebx, 8
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        pop ebx
        ret
;-----------------------------------------------------------------------------
; OpenGameDatabase                                DA7EB  97 PC, low confidence
; Opens the game database files
;-----------------------------------------------------------------------------
OpenGameDatabase:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 54h, 0
        cmp word [DbOpen], byte 0
        je short OpenGameDatabase_18.1
OpenGameDatabase_13:
        mov eax, 1
OpenGameDatabase_18:
        leave
        jmp near UpdatePlayerRecord_1AD
.1:
        mov eax, 14h
        call AllocPageStack
        test eax, eax
        je short OpenGameDatabase_18
        mov esi, DbFileTable
        xor ecx, ecx
.2:
        lea eax, [byte ebp-054h]
        mov edx, dword [LeagueFilePrefix]
        mov ebx, ecx
        call strcpy_
        shl ebx, 2
        lea eax, [byte ebp-054h]
        mov edx, dword [dword ebx+DbFileNames]
        call strcat_
        lea eax, [byte ebp-054h]
        mov edx, dword [DbFileSuffix]
        call strcat_
        lea edx, [byte ebp-054h]
        mov eax, esi
        call OpenDbFile
        mov edx, ebx
        mov edi, ebx
        add edx, DbFileTable
        add edi, DbRecordCounts
        mov dword [byte ebp-04h], edx
        test eax, eax
        jne short .5
.3:
        sub edx, byte 4
        dec ecx
        sub edi, byte 4
        test ecx, ecx
        jl short .4
        mov eax, edx
        call CloseDbFile
        mov eax, edi
        call FileClose
        jmp short .3
.4:
        call FreeDbPages
        mov eax, DbStaticBuffer
        call FreePtr
        xor eax, eax
        jmp near OpenGameDatabase_18
.5:
        lea eax, [byte ebp-054h]
        mov edx, dword [LeagueFilePrefix]
        call strcpy_
        lea eax, [byte ebp-054h]
        mov edx, dword [dword ebx+DbFileExtensions]
        call strcat_
        lea eax, [byte ebp-054h]
        mov edx, dword [DbDirName]
        call strcat_
        lea eax, [byte ebp-054h]
        mov edx, edi
        call FileOpen
        test eax, eax
        jne short .7
        mov eax, esi
        mov edx, dword [byte ebp-04h]
        call CloseDbFile
        mov ebx, edi
.6:
        sub edx, byte 4
        dec ecx
        sub ebx, byte 4
        test ecx, ecx
        jl short .4
        mov eax, edx
        call CloseDbFile
        mov eax, ebx
        call FileClose
        jmp short .6
.7:
        mov edx, DbRecordSizes
        mov eax, dword [dword ebx+DbRecordCounts]
        add edx, ebx
        mov ebx, 4
        call FileReadRecord
        test eax, eax
        jne short .9
        mov edx, dword [byte ebp-04h]
.8:
        mov eax, ecx
        sub edi, byte 4
        sub edx, byte 4
        dec ecx
        test eax, eax
        jl near .4
        mov eax, edx
        call CloseDbFile
        mov eax, edi
        call FileClose
        jmp short .8
.9:
        call ServiceIdle
        inc ecx
        add esi, byte 4
        cmp ecx, byte 2
        jl near .2
        mov esi, ecx
        shl esi, 2
        add esi, DbRecordCounts
.10:
        cmp ecx, byte 7
        jge near .19
        lea eax, [byte ebp-054h]
        mov edx, dword [LeagueFilePrefix]
        mov ebx, ecx
        call strcpy_
        shl ebx, 2
        lea eax, [byte ebp-054h]
        mov edx, dword [dword ebx+DbFileExtensions]
        call strcat_
        lea eax, [byte ebp-054h]
        mov edx, dword [DbDirName]
        mov edi, ebx
        call strcat_
        lea eax, [byte ebp-054h]
        mov edx, esi
        add edi, DbRecordCounts
        call FileOpen
        test eax, eax
        jne short .14
        mov edx, edi
.11:
        dec ecx
        sub edx, byte 4
        cmp ecx, byte 2
        jl short .12
        mov eax, edx
        call FileClose
        jmp short .11
.12:
        mov eax, ecx
        shl eax, 2
        mov edx, eax
        mov ebx, eax
        add edx, DbRecordCounts
        add ebx, DbFileTable
.13:
        mov eax, ecx
        sub edx, byte 4
        sub ebx, byte 4
        dec ecx
        test eax, eax
        jl near .4
        mov eax, ebx
        call CloseDbFile
        mov eax, edx
        call FileClose
        jmp short .13
.14:
        mov edx, DbRecordSizes
        mov eax, dword [dword ebx+DbRecordCounts]
        add edx, ebx
        mov ebx, 4
        call FileReadRecord
        test eax, eax
        jne short .18
        mov edx, edi
.15:
        mov eax, ecx
        sub edx, byte 4
        dec ecx
        cmp eax, byte 2
        jl short .16
        mov eax, edx
        call FileClose
        jmp short .15
.16:
        mov eax, ecx
        shl eax, 2
        mov edx, eax
        mov ebx, eax
        add edx, DbRecordCounts
        add ebx, DbFileTable
.17:
        sub ebx, byte 4
        dec ecx
        sub edx, byte 4
        test ecx, ecx
        jl near .4
        mov eax, ebx
        call CloseDbFile
        mov eax, edx
        call FileClose
        jmp short .17
.18:
        call ServiceIdle
        add esi, byte 4
        inc ecx
        jmp near .10
.19:
        mov word [DbOpen], 1
        mov eax, 1
        mov dword [DbRecordsLoaded], 0
        jmp near OpenGameDatabase_18
;-----------------------------------------------------------------------------
; LoadHomeRosterRecords                           DAA82  97 PC, low confidence
; Loads the home team's roster records
;-----------------------------------------------------------------------------
LoadHomeRosterRecords:
        push ebx
        push ecx
        push esi
        enter 68h, 0
        mov ecx, eax
        mov esi, edx
        add eax, byte 18h
        call FindPlayerRecord
        test eax, eax
        je near .3
        mov al, byte [byte ecx+01h]
        mov byte [dword esi+0BCh], al
        mov al, byte [byte ecx+02h]
        mov byte [dword esi+0BDh], al
        mov al, byte [ecx]
        lea edx, [byte ebp-028h]
        mov byte [dword esi+0BEh], al
        lea eax, [byte ecx+028h]
        call FindPlayerStat
        test eax, eax
        je near .3
        mov ebx, 17h
        lea eax, [byte ebp-018h]
        lea edx, [dword esi+0E6h]
        call CopyBytesOk
        mov ebx, 8
        mov edx, DbKeyBuffer
        lea eax, [byte ecx+020h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne short .1
        lea edx, [byte ebp-068h]
        lea eax, [byte ecx+020h]
        call FindTeamStat
        test eax, eax
        jne short .2
        leave
        pop esi
        pop ecx
        pop ebx
        ret
.1:
        mov edx, 3Dh
        lea eax, [byte ebp-068h]
        call ZeroBytesOk
.2:
        mov ebx, 21h
        lea eax, [byte ebp-050h]
        lea edx, [dword esi+0C1h]
        call CopyBytesOk
        mov ebx, 15h
        lea edx, [dword esi+010Fh]
        lea eax, [byte ecx+03h]
        call CopyBytesOk
        call ServiceIdle
        mov eax, 1
.3:
        leave
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadAwayRosterRecords                           DAB51  97 PC, low confidence
; Loads the away team's roster records
;-----------------------------------------------------------------------------
LoadAwayRosterRecords:
        push ebx
        push ecx
        push esi
        enter 68h, 0
        mov esi, eax
        mov ecx, edx
        add eax, byte 18h
        call FindPlayerRecord
        test eax, eax
        je near .3
        mov al, byte [byte esi+01h]
        mov byte [dword ecx+0BDh], 47h
        mov byte [dword ecx+0BCh], al
        mov al, byte [esi]
        lea edx, [byte ebp-028h]
        mov byte [dword ecx+0BEh], al
        lea eax, [byte esi+028h]
        call FindPlayerStat
        test eax, eax
        je near .3
        mov ebx, 13h
        lea eax, [byte ebp-018h]
        lea edx, [dword ecx+0E6h]
        call CopyBytesOk
        mov ebx, 8
        mov edx, DbKeyBuffer
        lea eax, [byte esi+020h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne short .1
        lea edx, [byte ebp-068h]
        lea eax, [byte esi+020h]
        call FindTeamStat
        test eax, eax
        jne short .2
        leave
        pop esi
        pop ecx
        pop ebx
        ret
.1:
        mov edx, 3Dh
        lea eax, [byte ebp-068h]
        call ZeroBytesOk
.2:
        mov ebx, 25h
        lea eax, [byte ebp-050h]
        lea edx, [dword ecx+0C1h]
        call CopyBytesOk
        mov ebx, 15h
        lea edx, [dword ecx+010Fh]
        lea eax, [byte esi+03h]
        call CopyBytesOk
        call ServiceIdle
        mov eax, 1
.3:
        leave
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SetMatchupTeams                                 DAC1E  97 PC, low confidence
; Sets the two teams of a matchup
;-----------------------------------------------------------------------------
SetMatchupTeams:
        push ebx
        push ecx
        push esi
        push edi
        enter 4, 0
        cwde
        add eax, byte 64h
        mov dword [byte ebp-04h], eax
        cmp dword [edx], byte 0
        jne short .4
        mov ecx, 15h
        xor esi, esi
.1:
        cmp esi, ecx
        je short .4
        lea ebx, [esi+ecx]
        sar ebx, 1
        mov eax, ebx
        shl eax, 2
        movzx edi, word [dword eax+str_Punct_SetMatchupTeams]
        cmp edi, dword [byte edx+04h]
        jne short .2
        mov ax, word [dword eax+MatchupTeamCodes]
        jmp near FindGameRecord_A0
.2:
        jae short .3
        lea esi, [byte ebx+01h]
        jmp short .1
.3:
        mov ecx, ebx
        jmp short .1
.4:
        mov eax, dword [byte ebp-04h]
        jmp near FindGameRecord_A0
;-----------------------------------------------------------------------------
; LoadMatchupRosters                              DAC72  97 PC, low confidence
; Loads the rosters of both teams of a matchup
;-----------------------------------------------------------------------------
LoadMatchupRosters:
        push ebx
        push ecx
        push esi
        push edi
        enter 0Ch, 0
        mov ecx, eax
        mov esi, edx
        add eax, byte 10h
        call FindTeamRecord
        test eax, eax
        je near FindGameRecord_A0
        mov ebx, 39h
        mov ax, word [dword ecx+0D07h]
        lea edx, [byte esi+068h]
        mov word [byte esi+066h], ax
        lea eax, [byte ecx+04Eh]
        call CopyBytesOk
        mov ebx, 36h
        lea edx, [dword esi+020EDh]
        lea eax, [byte ecx+018h]
        mov dword [byte ebp-04h], 0
        call CopyBytesOk
        lea edi, [dword esi+0A3h]
        lea ebx, [dword ecx+0D09h]
.1:
        movsx eax, word [dword ecx+0D05h]
        cmp eax, dword [byte ebp-04h]
        jle short .2
        mov edx, edi
        mov eax, ebx
        call LoadHomeRosterRecords
        test eax, eax
        je near FindGameRecord_A0
        call ServiceIdle
        inc dword [byte ebp-04h]
        add ebx, byte 38h
        add edi, 125h
        jmp short .1
.2:
        mov dword [byte ebp-0Ch], 0
        lea eax, [dword ecx+01283h]
        lea ebx, [dword esi+01D42h]
        mov dword [byte ebp-08h], eax
        mov edi, esi
.3:
        movsx eax, word [dword ecx+01281h]
        cmp eax, dword [byte ebp-0Ch]
        jle short .4
        mov eax, dword [byte ebp-08h]
        mov edx, ebx
        call LoadAwayRosterRecords
        test eax, eax
        je near FindGameRecord_A0
        add dword [byte ebp-08h], byte 38h
        mov edx, ebx
        inc edi
        inc edi
        movsx eax, word [byte esi+066h]
        inc dword [byte ebp-0Ch]
        call SetMatchupTeams
        mov word [dword edi+020AFh], ax
        call ServiceIdle
        add ebx, 125h
        jmp short .3
.4:
        mov ax, word [dword ecx+0D05h]
        mov word [dword esi+0A1h], ax
        mov ax, word [dword ecx+01281h]
        mov word [dword esi+01D40h], ax
        jmp near LookupRecord_244
;-----------------------------------------------------------------------------
; LoadGameRosters                                 DAD7E  97 PC, low confidence
; Loads the rosters for a game
;-----------------------------------------------------------------------------
LoadGameRosters:
        push ecx
        push esi
        push edi
        mov ecx, edx
        mov esi, eax
        lea edi, [byte ebx+016h]
        movsd
        movsd
        mov esi, edx
        lea edi, [byte ebx+01Eh]
        lea edx, [byte ebx+028h]
        movsd
        movsd
        call LoadMatchupRosters
        mov esi, eax
        mov edx, eax
        call ServiceIdle
        test esi, esi
        je short .1
        lea edx, [dword ebx+0214Bh]
        mov eax, ecx
        call LoadMatchupRosters
        mov edx, eax
.1:
        call ServiceIdle
        mov eax, edx
        pop edi
        pop esi
        pop ecx
        ret
WriteDbRecordJumpTable:                         ; jump table for the switch cases of WriteDbRecord
        dd WriteDbRecord_5C
        dd WriteDbRecord_1AA
        dd WriteDbRecord_152
        dd WriteDbRecord_102
;-----------------------------------------------------------------------------
; WriteDbRecord                                   DADD0  97 PC, low confidence
; Writes a record to the database
;-----------------------------------------------------------------------------
WriteDbRecord:
        push esi
        push edi
        enter 14h, 0
        push eax
        mov esi, edx
        mov dword [byte ebp-0Ch], ebx
        mov edi, ecx
        mov ebx, 1
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        leave
        pop edi
        pop esi
        ret
.1:
        cmp dword [DbRecordsLoaded], byte 0
        je near WriteDbRecord_5C.6
        cmp ebx, eax
        je short .2
        cmp eax, byte 4
        je short .2
        cmp eax, byte 3
        je short .2
        cmp eax, byte 2
        jne near WriteDbRecord_5C.6
.2:
        mov eax, dword [byte ebp-018h]
        dec eax
        cmp eax, byte 3
        ja near WriteDbRecord_5C.6
        jmp dword [nosplit cs:eax*4+WriteDbRecordJumpTable]
WriteDbRecord_5C:
        cmp esi, dword [DbGameRecordCount]
        jge near .6
        xor eax, eax
.3:
        cmp eax, dword [DbGameRecordCount]
        jge short .5
        imul edx, eax, dword 0C4h
        mov dword [byte ebp-010h], edx
        mov edx, dword [DbGameRecords]
        add edx, dword [byte ebp-010h]
        cmp esi, dword [edx]
        jne short .4
        push dword 0BCh
        add edx, byte 8
        push edx
        push edi
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [tickcount]
        mov edx, eax
        mov eax, dword [DbGameRecords]
        add eax, dword [byte ebp-010h]
        mov dword [byte eax+04h], edx
        xor ebx, ebx
        mov eax, dword [DbGameRecordCount]
.4:
        inc eax
        jmp short .3
.5:
        jle near .6
        xor ebx, ebx
.6:
        test ebx, ebx
        je short .7
        mov edx, dword [byte ebp-0Ch]
        imul edx, esi
        mov ebx, dword [byte ebp-018h]
        shl ebx, 2
        mov eax, dword [dword ebx+DbRecordCounts]
        add edx, byte 4
        call FileSeek
        test eax, eax
        je short .8
        mov edx, edi
        mov eax, dword [dword ebx+DbRecordCounts]
        mov ebx, dword [byte ebp-0Ch]
        call FileWriteRecord
        test eax, eax
        je short .8
.7:
        call ServiceIdle
        mov eax, 1
.8:
        leave
        pop edi
        pop esi
        ret
WriteDbRecord_102:
        cmp esi, dword [DbPlayerRecordCount]
        jge short WriteDbRecord_5C.6
        xor eax, eax
.9:
        cmp eax, dword [DbPlayerRecordCount]
        jge short WriteDbRecord_5C.5
        imul edx, eax, byte 2Fh
        mov dword [byte ebp-08h], edx
        mov edx, dword [DbPlayerRecords]
        add edx, dword [byte ebp-08h]
        cmp esi, dword [edx]
        jne short .10
        push byte 27h
        add edx, byte 8
        push edx
        push edi
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [tickcount]
        mov edx, eax
        mov eax, dword [DbPlayerRecords]
        add eax, dword [byte ebp-08h]
        mov dword [byte eax+04h], edx
        xor ebx, ebx
        mov eax, dword [DbPlayerRecordCount]
.10:
        inc eax
        jmp short .9
WriteDbRecord_152:
        cmp esi, dword [DbStatRecordCount]
        jge near WriteDbRecord_5C.6
        xor eax, eax
.11:
        cmp eax, dword [DbStatRecordCount]
        jge near WriteDbRecord_5C.5
        imul edx, eax, byte 45h
        mov dword [byte ebp-04h], edx
        mov edx, dword [DbStatRecords]
        add edx, dword [byte ebp-04h]
        cmp esi, dword [edx]
        jne short .12
        push byte 3Dh
        add edx, byte 8
        push edx
        push edi
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [tickcount]
        mov edx, eax
        mov eax, dword [DbStatRecords]
        add eax, dword [byte ebp-04h]
        mov dword [byte eax+04h], edx
        xor ebx, ebx
        mov eax, dword [DbStatRecordCount]
.12:
        inc eax
        jmp short .11
WriteDbRecord_1AA:
        cmp esi, dword [DbTeamRecordCount]
        jge near WriteDbRecord_5C.6
        xor eax, eax
.13:
        cmp eax, dword [DbTeamRecordCount]
        jge near WriteDbRecord_5C.5
        imul edx, eax, dword 1957h
        mov dword [byte ebp-014h], edx
        mov edx, dword [DbTeamRecords]
        add edx, dword [byte ebp-014h]
        cmp esi, dword [edx]
        jne short .14
        push dword 194Fh
        add edx, byte 8
        push edx
        push edi
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [tickcount]
        mov edx, eax
        mov eax, dword [DbTeamRecords]
        add eax, dword [byte ebp-014h]
        mov dword [byte eax+04h], edx
        xor ebx, ebx
        mov eax, dword [DbTeamRecordCount]
.14:
        inc eax
        jmp short .13
DbGameRecordJumpTable:                          ; jump table for the switch cases of ReadDbRecord
        dd ReadDbRecord_62
        dd ReadDbRecord_296
        dd ReadDbRecord_200
        dd ReadDbRecord_16E
DbPlayerRecordJumpTable:                        ; jump table for the switch cases of ReadDbRecord
        dd ReadDbRecord_33C
        dd ReadDbRecord_495
        dd ReadDbRecord_42C
        dd ReadDbRecord_3BF
;-----------------------------------------------------------------------------
; ReadDbRecord                                    DAFF8  97 PC, low confidence
; Reads a record from the database
;-----------------------------------------------------------------------------
ReadDbRecord:
        push esi
        push edi
        enter 24h, 0
        push eax
        mov edi, edx
        mov dword [byte ebp-01Ch], ebx
        mov dword [byte ebp-04h], ecx
        xor esi, esi
        mov ebx, 1
        mov dword [byte ebp-08h], esi
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        leave
        pop edi
        pop esi
        ret
.1:
        cmp dword [DbRecordsLoaded], byte 0
        je near ReadDbRecord_62.8
        cmp ebx, eax
        je short .2
        cmp eax, byte 4
        je short .2
        cmp eax, byte 3
        je short .2
        cmp eax, byte 2
        jne near ReadDbRecord_62.8
.2:
        mov eax, dword [byte ebp-028h]
        dec eax
        cmp eax, byte 3
        ja near ReadDbRecord_62.8
        jmp dword [nosplit cs:eax*4+DbGameRecordJumpTable]
ReadDbRecord_62:
        cmp edi, dword [DbGameRecordCount]
        jge near .8
        xor eax, eax
.3:
        cmp eax, dword [DbGameRecordCount]
        jge near .6
        test eax, eax
        je short .4
        imul edx, eax, dword 0C4h
        mov ecx, dword [DbGameRecords]
        mov dword [byte ebp-020h], ecx
        add edx, ecx
        imul ecx, esi, dword 0C4h
        mov dword [byte ebp-024h], ecx
        mov ecx, dword [byte ebp-020h]
        mov edx, dword [byte edx+04h]
        add ecx, dword [byte ebp-024h]
        cmp edx, dword [byte ecx+04h]
        jge short .4
        mov esi, eax
.4:
        imul edx, eax, dword 0C4h
        mov dword [byte ebp-018h], edx
        mov edx, dword [DbGameRecords]
        add edx, dword [byte ebp-018h]
        cmp edi, dword [edx]
        jne short .5
        push dword 0BCh
        push dword [byte ebp-04h]
        add edx, byte 8
        push edx
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [tickcount]
        mov edx, eax
        mov eax, dword [DbGameRecords]
        add eax, dword [byte ebp-018h]
        mov dword [byte eax+04h], edx
        xor ebx, ebx
        mov eax, dword [DbGameRecordCount]
.5:
        inc eax
        jmp short .3
.6:
        cmp dword [DbGameRecordCount], byte 0
        jle near .8
        cmp eax, dword [DbGameRecordCount]
.7:
        jne near .8
        mov dword [byte ebp-08h], 1
.8:
        test ebx, ebx
        je short .9
        mov edx, dword [byte ebp-01Ch]
        imul edx, edi
        mov ebx, dword [byte ebp-028h]
        shl ebx, 2
        mov eax, dword [dword ebx+DbRecordCounts]
        add edx, byte 4
        call FileSeek
        test eax, eax
        je near ReadDbRecord_33C.24
        mov edx, dword [byte ebp-04h]
        mov eax, dword [dword ebx+DbRecordCounts]
        mov ebx, dword [byte ebp-01Ch]
        call FileReadRecord
        test eax, eax
        je near ReadDbRecord_33C.24
.9:
        cmp dword [byte ebp-08h], byte 0
        je near ReadDbRecord_33C.23
        mov eax, dword [byte ebp-028h]
        dec eax
        cmp eax, byte 3
        ja near ReadDbRecord_33C.23
        jmp dword [nosplit cs:eax*4+DbPlayerRecordJumpTable]
ReadDbRecord_16E:
        cmp edi, dword [DbPlayerRecordCount]
        jge short ReadDbRecord_62.8
        xor eax, eax
.10:
        cmp eax, dword [DbPlayerRecordCount]
        jge short .13
        test eax, eax
        je short .11
        imul edx, eax, byte 2Fh
        mov ecx, dword [DbPlayerRecords]
        mov dword [byte ebp-020h], ecx
        add edx, ecx
        imul ecx, esi, byte 2Fh
        mov dword [byte ebp-024h], ecx
        mov ecx, dword [byte ebp-020h]
        mov edx, dword [byte edx+04h]
        add ecx, dword [byte ebp-024h]
        cmp edx, dword [byte ecx+04h]
        jge short .11
        mov esi, eax
.11:
        imul edx, eax, byte 2Fh
        mov dword [byte ebp-014h], edx
        mov edx, dword [DbPlayerRecords]
        add edx, dword [byte ebp-014h]
        cmp edi, dword [edx]
        jne short .12
        push byte 27h
        push dword [byte ebp-04h]
        add edx, byte 8
        push edx
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [tickcount]
        mov edx, eax
        mov eax, dword [DbPlayerRecords]
        add eax, dword [byte ebp-014h]
        mov dword [byte eax+04h], edx
        xor ebx, ebx
        mov eax, dword [DbPlayerRecordCount]
.12:
        inc eax
        jmp short .10
.13:
        cmp dword [DbPlayerRecordCount], byte 0
        jle near ReadDbRecord_62.8
        cmp eax, dword [DbPlayerRecordCount]
        jmp near ReadDbRecord_62.7
ReadDbRecord_200:
        cmp edi, dword [DbStatRecordCount]
        jge near ReadDbRecord_62.8
        xor eax, eax
.14:
        cmp eax, dword [DbStatRecordCount]
        jge short .17
        test eax, eax
        je short .15
        imul edx, eax, byte 45h
        mov ecx, dword [DbStatRecords]
        mov dword [byte ebp-020h], ecx
        add edx, ecx
        imul ecx, esi, byte 45h
        mov dword [byte ebp-024h], ecx
        mov ecx, dword [byte ebp-020h]
        mov edx, dword [byte edx+04h]
        add ecx, dword [byte ebp-024h]
        cmp edx, dword [byte ecx+04h]
        jge short .15
        mov esi, eax
.15:
        imul edx, eax, byte 45h
        mov dword [byte ebp-0Ch], edx
        mov edx, dword [DbStatRecords]
        add edx, dword [byte ebp-0Ch]
        cmp edi, dword [edx]
        jne short .16
        push byte 3Dh
        push dword [byte ebp-04h]
        add edx, byte 8
        push edx
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [tickcount]
        mov edx, eax
        mov eax, dword [DbStatRecords]
        add eax, dword [byte ebp-0Ch]
        mov dword [byte eax+04h], edx
        xor ebx, ebx
        mov eax, dword [DbStatRecordCount]
.16:
        inc eax
        jmp short .14
.17:
        cmp dword [DbStatRecordCount], byte 0
        jle near ReadDbRecord_62.8
        cmp eax, dword [DbStatRecordCount]
        jmp near ReadDbRecord_62.7
ReadDbRecord_296:
        cmp edi, dword [DbTeamRecordCount]
        jge near ReadDbRecord_62.8
        xor eax, eax
.18:
        cmp eax, dword [DbTeamRecordCount]
        jge near .21
        test eax, eax
        je short .19
        imul edx, eax, dword 1957h
        mov ecx, dword [DbTeamRecords]
        mov dword [byte ebp-024h], ecx
        add edx, ecx
        imul ecx, esi, dword 1957h
        mov dword [byte ebp-020h], ecx
        mov ecx, dword [byte ebp-024h]
        mov edx, dword [byte edx+04h]
        add ecx, dword [byte ebp-020h]
        cmp edx, dword [byte ecx+04h]
        jge short .19
        mov esi, eax
.19:
        imul edx, eax, dword 1957h
        mov dword [byte ebp-010h], edx
        mov edx, dword [DbTeamRecords]
        add edx, dword [byte ebp-010h]
        cmp edi, dword [edx]
        jne short .20
        push dword 194Fh
        push dword [byte ebp-04h]
        add edx, byte 8
        push edx
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [tickcount]
        mov edx, eax
        mov eax, dword [DbTeamRecords]
        add eax, dword [byte ebp-010h]
        mov dword [byte eax+04h], edx
        xor ebx, ebx
        mov eax, dword [DbTeamRecordCount]
.20:
        inc eax
        jmp short .18
.21:
        cmp dword [DbTeamRecordCount], byte 0
        jle near ReadDbRecord_62.8
        cmp eax, dword [DbTeamRecordCount]
        jmp near ReadDbRecord_62.7
ReadDbRecord_33C:
        imul eax, esi, dword 0C4h
        mov edx, dword [DbGameRecords]
        add eax, edx
        cmp dword [byte eax+04h], byte 0
        je short .22
        mov dword [DbRecordsLoaded], 0
        mov ebx, 0BCh
        lea ecx, [byte eax+08h]
        mov edx, dword [eax]
        mov eax, 1
        call WriteDbRecord
        mov dword [DbRecordsLoaded], 1
.22:
        imul esi, dword 0C4h
        mov eax, dword [DbGameRecords]
        add eax, esi
        push dword 0BCh
        add eax, byte 8
        push eax
        push dword [byte ebp-04h]
        call bcopy
        mov eax, dword [DbGameRecords]
        add esp, byte 0Ch
        mov dword [esi+eax], edi
        mov eax, dword [tickcount]
        mov edx, eax
        mov eax, dword [DbGameRecords]
        mov dword [byte esi+eax+04h], edx
.23:
        call ServiceIdle
        mov eax, 1
.24:
        leave
        pop edi
        pop esi
        ret
ReadDbRecord_3BF:
        imul eax, esi, byte 2Fh
        mov edx, dword [DbPlayerRecords]
        add eax, edx
        cmp dword [byte eax+04h], byte 0
        je short .25
        mov dword [DbRecordsLoaded], 0
        mov ebx, 27h
        lea ecx, [byte eax+08h]
        mov edx, dword [eax]
        mov eax, 4
        call WriteDbRecord
        mov dword [DbRecordsLoaded], 1
.25:
        imul esi, byte 2Fh
        mov eax, dword [DbPlayerRecords]
        add eax, esi
        push byte 27h
        add eax, byte 8
        push eax
        push dword [byte ebp-04h]
        call bcopy
        mov eax, dword [DbPlayerRecords]
        add esp, byte 0Ch
        mov dword [esi+eax], edi
        mov eax, dword [tickcount]
        mov edx, dword [DbPlayerRecords]
.26:
        mov dword [byte edx+esi+04h], eax
        jmp short ReadDbRecord_33C.23
ReadDbRecord_42C:
        imul eax, esi, byte 45h
        mov edx, dword [DbStatRecords]
        add eax, edx
        cmp dword [byte eax+04h], byte 0
        je short .27
        mov dword [DbRecordsLoaded], 0
        mov ebx, 3Dh
        lea ecx, [byte eax+08h]
        mov edx, dword [eax]
        mov eax, 3
        call WriteDbRecord
        mov dword [DbRecordsLoaded], 1
.27:
        imul esi, byte 45h
        mov eax, dword [DbStatRecords]
        add eax, esi
        push byte 3Dh
        add eax, byte 8
        push eax
        push dword [byte ebp-04h]
        call bcopy
        mov eax, dword [DbStatRecords]
        add esp, byte 0Ch
        mov dword [esi+eax], edi
        mov eax, dword [tickcount]
        mov edx, dword [DbStatRecords]
        jmp short ReadDbRecord_3BF.26
ReadDbRecord_495:
        imul eax, esi, dword 1957h
        mov edx, dword [DbTeamRecords]
        add eax, edx
        cmp dword [byte eax+04h], byte 0
        je short .28
        mov dword [DbRecordsLoaded], 0
        mov ebx, 194Fh
        lea ecx, [byte eax+08h]
        mov edx, dword [eax]
        mov eax, 2
        call WriteDbRecord
        mov dword [DbRecordsLoaded], 1
.28:
        imul esi, dword 1957h
        mov eax, dword [DbTeamRecords]
        add eax, esi
        push dword 194Fh
        add eax, byte 8
        push eax
        push dword [byte ebp-04h]
        call bcopy
        mov eax, dword [DbTeamRecords]
        add esp, byte 0Ch
        mov dword [esi+eax], edi
        mov eax, dword [tickcount]
        mov edx, dword [DbTeamRecords]
        jmp near ReadDbRecord_3BF.26
        mov eax, 1
        ret
;-----------------------------------------------------------------------------
; AppendDbRecord                                  DB508  97 PC, low confidence
; Appends a record to the database
;-----------------------------------------------------------------------------
AppendDbRecord:
        push ecx
        push esi
        push edi
        enter 0Ch, 0
        push eax
        push edx
        mov edi, ebx
        mov dword [byte ebp-04h], 0
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        leave
        pop edi
        pop esi
        pop ecx
        ret
.1:
        lea ebx, [byte ebp-0Ch]
        mov eax, str_TEMP2
        mov edx, edi
        call AllocClearBlock20
        test eax, eax
        je short .3
        mov esi, dword [byte ebp-010h]
        mov eax, DbRecordSizes
        shl esi, 2
        mov ebx, 4
        add eax, esi
        mov edx, dword [byte ebp-0Ch]
        mov dword [byte ebp-08h], eax
        call CopyBytesOk
        mov ecx, dword [byte ebp-0Ch]
        mov edx, dword [byte ebp-014h]
        mov eax, dword [byte ebp-010h]
        mov ebx, edi
        call WriteDbRecord
        test eax, eax
        je short .2
        mov eax, dword [byte ebp-014h]
        xor edx, edx
        mov dword [dword esi+DbRecordSizes], eax
        mov eax, dword [dword esi+DbRecordCounts]
        call FileSeek
        mov dword [byte ebp-04h], eax
        test eax, eax
        je short .2
        mov ebx, 4
        mov edx, dword [byte ebp-08h]
        mov eax, dword [dword esi+DbRecordCounts]
        call FileWriteRecord
        mov dword [byte ebp-04h], eax
.2:
        lea eax, [byte ebp-0Ch]
        call FreePtr
        call ServiceIdle
        mov eax, dword [byte ebp-04h]
.3:
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; AllocRecordSlot                                 DB5B7  97 PC, low confidence
; Finds the file position for a new record
;-----------------------------------------------------------------------------
AllocRecordSlot:
        push ecx
        push esi
        push edi
        enter 4, 0
        push eax
        mov esi, edx
        mov edi, ebx
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        leave
        pop edi
        pop esi
        pop ecx
        ret
.1:
        mov ecx, eax
        shl ecx, 2
        cmp dword [dword ecx+DbRecordSizes], byte 0FFFFFFFFh
        jne short .2
        mov eax, dword [dword ecx+DbRecordCounts]
        call FileSeekEnd
        test eax, eax
        jne near .3
        leave
        pop edi
        pop esi
        pop ecx
        ret
.2:
        mov eax, dword [dword ecx+DbRecordSizes]
        mov dword [edx], eax
        mov edx, eax
        imul edx, ebx
        mov eax, dword [dword ecx+DbRecordCounts]
        add edx, byte 4
        call FileSeek
        test eax, eax
        je near .4
        mov eax, DbRecordSizes
        add eax, ecx
        mov dword [byte ebp-04h], eax
        mov ebx, 4
        mov edx, dword [byte ebp-04h]
        mov eax, dword [dword ecx+DbRecordCounts]
        call FileReadRecord
        test eax, eax
        je short .4
        mov eax, dword [dword ecx+DbRecordCounts]
        xor edx, edx
        call FileSeek
        test eax, eax
        je short .4
        mov ebx, 4
        mov edx, dword [byte ebp-04h]
        mov eax, dword [dword ecx+DbRecordCounts]
        call FileWriteRecord
        test eax, eax
        je short .4
        mov edx, dword [esi]
        imul edx, edi
        mov eax, dword [dword ecx+DbRecordCounts]
        add edx, byte 4
        call FileSeek
        test eax, eax
        je short .4
.3:
        mov eax, dword [byte ebp-08h]
        mov edx, esi
        mov eax, dword [nosplit eax*4+DbRecordCounts]
        call FileTell
        test eax, eax
        je short .4
        mov eax, dword [esi]
        xor edx, edx
        sub eax, byte 4
        div edi
        mov dword [esi], eax
        call ServiceIdle
        mov eax, 1
.4:
        leave
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; CloseGameDatabase                               DB6AC  97 PC, low confidence
; Closes the game database files
;-----------------------------------------------------------------------------
CloseGameDatabase:
        push ebx
        push ecx
        push edx
        cmp word [DbOpen], byte 0
        jne short .1
        xor eax, eax
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov ebx, DbRecordCounts
        mov edx, DbRecordCounts
        add ebx, byte 4
        add edx, byte 18h
.2:
        mov eax, edx
        sub edx, byte 4
        call FileClose
        cmp edx, ebx
        jne short .2
        mov edx, DbFileTable
        mov ecx, DbFileTable
        mov ebx, DbRecordCounts
        add edx, byte 4
        sub ecx, byte 4
        add ebx, byte 4
.3:
        mov eax, edx
        call CloseDbFile
        mov eax, ebx
        call FileClose
        sub edx, byte 4
        sub ebx, byte 4
        cmp edx, ecx
        jne short .3
        call FreeDbPages
        mov word [DbOpen], 0
        mov dword [DbIndexRoot], 0
        mov dword [DbPlayerIndex], 0
        mov dword [DbGameIndex], 0
        call ServiceIdle
        mov eax, 1
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; InitDbState                                     DB747  97 PC, low confidence
; Clears the database state at start-up
;-----------------------------------------------------------------------------
InitDbState:
        cmp word [StaticBufferReady], byte 0
        jne short .1
        xor eax, eax
        ret
.1:
        call ServiceIdle
        mov eax, DbStaticBuffer
;-----------------------------------------------------------------------------
; FreeDbBlock                                     DB75E  97 PC, low confidence
; Frees a database block
;-----------------------------------------------------------------------------
FreeDbBlock:
        jmp near FreePtr
;-----------------------------------------------------------------------------
; DaysToYear                                      DB763  97 PC, low confidence
; Converts a day count to a year
;-----------------------------------------------------------------------------
DaysToYear:
        push ecx
        push esi
        push edi
        mov ecx, eax
        mov esi, edx
        cwde
        mov edi, 4
        cdq
        idiv edi
        test edx, edx
        sete al
        movzx eax, al
        mov edx, eax
        cmp cx, 76Ch
        jl short .1
        sub ecx, 76Ch
.1:
        movzx eax, cx
        imul eax, dword 16Dh
        movsx ecx, cx
        sar ecx, 2
        add eax, ecx
        sub eax, edx
        imul edx, byte 1Ah
        movsx ecx, si
        add ax, word [dword edx+ecx*2+str_Punct_DaysToYear]
        add eax, ebx
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; AgeFromBirthDate                                DB7B1  97 PC, low confidence
; Works out a player's age from the birth date
;-----------------------------------------------------------------------------
AgeFromBirthDate:
        push esi
        push edi
        enter 8, 0
        mov esi, edx
        mov edi, ecx
        movzx ecx, ax
        mov eax, ecx
        shl eax, 2
        mov dword [byte ebp-04h], 5B5h
        cdq
        idiv dword [byte ebp-04h]
        mov word [esi], ax
        movzx eax, ax
        imul eax, dword 16Dh
        mov dword [byte ebp-04h], eax
        movsx eax, word [esi]
        sar eax, 2
        add eax, dword [byte ebp-04h]
        add word [esi], 76Ch
        sub ecx, eax
        movsx eax, word [esi]
        mov esi, 4
        cdq
        idiv esi
        test edx, edx
        sete al
        movzx eax, al
        add ecx, eax
        imul eax, byte 1Ah
        mov word [ebx], 0
        movzx esi, cx
        mov dword [byte ebp-08h], eax
.1:
        movsx eax, word [ebx]
        add eax, eax
        add eax, dword [byte ebp-08h]
        movsx edx, word [dword eax+MonthStartDays]
        cmp edx, esi
        jge short .2
        inc word [ebx]
        jmp short .1
.2:
        mov ax, word [dword eax+str_Punct_DaysToYear]
        sub ecx, eax
        mov word [edi], cx
        leave
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; NewRecordKey                                    DB838  97 PC, low confidence
; Builds the key for a new record
;-----------------------------------------------------------------------------
NewRecordKey:
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
        cmp eax, byte 2
        je short .3
        cmp eax, byte 4
        jne short .1
.3:
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        movsx edx, ax
        mov eax, dword [DbFileTable]
        call FindFirstKey
        test eax, eax
        je short .6
        cmp byte [byte ebp-030h], 0
        jne short .4
        cmp dword [byte ebp-04h], byte 0FFFFFFFFh
        jne short .4
        mov eax, dword [StaticBuffer]
        mov dword [byte esi+04h], 0
        mov dword [esi], eax
        jmp short .5
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
        inc dword [byte esi+04h]
        call ServiceIdle
.5:
        mov eax, 1
.6:
        leave
        pop esi
        pop ecx
        pop ebx
        ret
LookupRecordJumpTable:                          ; jump table for the switch cases of LookupRecord
        dd LookupRecord_2D
        dd LookupRecord_49
        dd LookupRecord_2D
        dd LookupRecord_AC
        dd LookupRecord_2D
        dd LookupRecord_FD
;-----------------------------------------------------------------------------
; LookupRecord                                    DB8E6  97 PC, low confidence
; Looks up a record by key
;-----------------------------------------------------------------------------
LookupRecord:
        push ecx
        push esi
        push edi
        enter 0Ch, 0
        mov esi, eax
        mov ecx, ebx
        mov dword [byte ebp-0Ch], eax
        mov dword [byte ebp-04h], eax
        mov edi, eax
        cmp edx, byte 5
        ja near LookupRecord_FD.13
        lea ebx, [byte esi+08h]
        add eax, byte 4
        mov dword [byte ebp-08h], ebx
        jmp dword [nosplit cs:edx*4+LookupRecordJumpTable]
LookupRecord_2D:
        mov ebx, ecx
        mov edx, eax
        mov eax, 4
        call BuildKeyFromLong
        mov eax, 4
        mov ebx, ecx
        mov edx, esi
        jmp near LookupRecord_AC.7
LookupRecord_49:
        mov eax, 4
        lea edx, [byte esi+0Ch]
        mov ebx, ecx
        call BuildKeyFromLong
        mov edx, dword [byte ebp-08h]
        mov eax, 4
        mov ebx, ecx
        call BuildKeyFromString
.1:
        lea esi, [byte ecx+01h]
        cmp byte [ecx], 0
        je short .2
        mov ecx, esi
        jmp short .1
.2:
        mov al, byte [byte edi+010h]
        mov byte [ecx], al
        mov byte [esi], 0
        lea ecx, [byte edi+011h]
        cmp byte [byte edi+010h], 4Ch
        jne short .3
        mov edx, ecx
        mov eax, esi
        call strcpy_
        jmp near LookupRecord_AC.8
.3:
        mov eax, 4
        lea edx, [byte edi+015h]
        mov ebx, esi
        call BuildKeyFromLong
        mov eax, 4
        mov ebx, esi
        mov edx, ecx
        jmp short LookupRecord_AC.7
LookupRecord_AC:
        mov edx, ebx
        mov eax, ecx
        call strcpy_
        mov eax, ecx
        call strlen_
        mov edx, eax
        add eax, ecx
.4:
        cmp edx, byte 1Dh
        jge short .5
        mov esi, edx
        inc eax
        mov byte [ecx+esi], 20h
        inc edx
        mov byte [eax], 0
        jmp short .4
.5:
        mov edx, dword [byte ebp-0Ch]
        mov eax, 4
        mov ebx, ecx
        add edx, byte 4
        call BuildKeyFromString
        mov edx, dword [byte ebp-0Ch]
.6:
        mov eax, 4
        mov ebx, ecx
.7:
        call BuildKeyFromString
.8:
        mov eax, 1
        leave
        pop edi
        pop esi
        pop ecx
        ret
LookupRecord_FD:
        mov edx, ebx
        mov eax, ecx
        call strcpy_
        mov eax, ecx
        call strlen_
        mov edx, eax
        add eax, ecx
.9:
        cmp edx, byte 0Fh
        jge short .10
        mov esi, edx
        inc eax
        mov byte [ecx+esi], 20h
        inc edx
        mov byte [eax], 0
        jmp short .9
.10:
        mov edx, dword [byte ebp-04h]
        mov ebx, 19h
        mov eax, ecx
        add edx, byte 18h
        call StrCopyEnd
        mov eax, ecx
        call strlen_
        mov edx, eax
        add eax, ecx
.11:
        cmp edx, byte 1Eh
        jge short .12
        mov esi, edx
        inc eax
        mov byte [ecx+esi], 20h
        inc edx
        mov byte [eax], 0
        jmp short .11
.12:
        mov edx, dword [byte ebp-04h]
        mov eax, 4
        mov ebx, ecx
        add edx, byte 4
        call BuildKeyFromString
        mov edx, dword [byte ebp-04h]
        jmp near LookupRecord_AC.6
.13:
        xor eax, eax
        leave
        pop edi
        pop esi
        pop ecx
        ret
        push ebx
        push ecx
        push esi
        push edi
        enter 38h, 0
        push eax
        push edx
        cmp word [DbOpen], byte 0
        jne short .14
        xor eax, eax
        jmp near FindGameRecord_A0
.14:
        mov edx, 2Fh
        mov eax, dword [byte ebp-040h]
        mov edi, dword [byte ebp-040h]
        mov esi, dword [byte ebp-03Ch]
        lea ebx, [byte ebp-038h]
        lea ecx, [byte ebp-04h]
        call ZeroBytesOk
        mov eax, dword [byte ebp-040h]
        movsd
        movsd
        xor edx, edx
        mov byte [byte eax+010h], 0
        call LookupRecord
        lea ebx, [byte ebp-038h]
        mov eax, dword [DbFileTable]
        xor edx, edx
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
        mov ebx, 67h
        mov edx, dword [byte ebp-04h]
        mov ecx, dword [DbStaticBuffer]
        xor eax, eax
        call ReadDbRecord
        test eax, eax
        je near FindGameRecord_A0
        mov ebx, 2Fh
LookupRecord_236:
        mov eax, dword [DbStaticBuffer]
        mov edx, dword [byte ebp-040h]
        inc eax
        call CopyBytesOk
LookupRecord_244:
        call ServiceIdle
LookupRecord_249:
        mov eax, 1
        jmp near FindGameRecord_A0
        push ebx
        push ecx
        push edx
        push esi
        enter 38h, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .15
        xor eax, eax
        jmp near UpdatePlayerRecord_229
.15:
        lea ebx, [byte ebp-038h]
        xor edx, edx
        lea ecx, [byte ebp-04h]
        call LookupRecord
        lea ebx, [byte ebp-038h]
        mov eax, dword [DbFileTable]
        xor edx, edx
        call FindIndexKey
        test eax, eax
        je near UpdatePlayerRecord_229
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
        mov eax, esi
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je near UpdatePlayerRecord_229
        mov ebx, 2Fh
        mov edx, dword [DbStaticBuffer]
        mov eax, esi
        inc edx
        call CopyBytesOk
        mov ebx, 67h
        mov edx, dword [byte ebp-04h]
        mov ecx, dword [DbStaticBuffer]
        xor eax, eax
        call WriteDbRecord
        test eax, eax
        je near UpdatePlayerRecord_229
LookupRecord_307:
        call ServiceIdle
LookupRecord_30C:
        mov eax, 1
        jmp near UpdatePlayerRecord_229
;-----------------------------------------------------------------------------
; FindRecordByKey                                 DBBFC  97 PC, low confidence
; Finds a record by key and reads it
;-----------------------------------------------------------------------------
FindRecordByKey:
        push esi
        push edi
        enter 7Ch, 0
        push eax
        push edx
        sub ebp, byte 76h
        mov byte [byte ebp+072h], bl
        mov dword [byte ebp+062h], ecx
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near FindRecordByKey_1BC
.2:
        lea edi, [byte ebp+02h]
        mov esi, eax
        movsd
        movsd
        mov byte [byte ebp+0Ah], bl
        cmp bl, 4Ch
        jne short .3
        mov byte [byte ebp+0Bh], 0
        jmp short .4
.3:
        mov dword [byte ebp+0Fh], 0
        mov dword [byte ebp+0Bh], 0
.4:
        lea ebx, [byte ebp+02Ah]
        mov edx, 1
        lea eax, [byte ebp-06h]
        lea ecx, [byte ebp+05Eh]
        call LookupRecord
        lea ebx, [byte ebp+02Ah]
        mov edx, 1
        mov eax, dword [DbFileTable]
        call FindIndexKey
        test eax, eax
        je near FindRecordByKey_1BC
        call ServiceIdle
        cmp dword [byte ebp+05Eh], byte 0FFFFFFFFh
        jne short .5
        cmp byte [byte ebp+02Ah], 0
        je short .1
.5:
        mov dword [byte ebp+06Eh], 0
        lea edi, [byte ebp+056h]
        lea edx, [byte ebp+02Ah]
        mov eax, 4
        add edi, byte 4
        lea esi, [byte ebp+02Ah]
        mov ebx, edi
        add esi, byte 5
        call KeyToLong
        mov dword [byte ebp+066h], edi
        lea ebx, [byte ebp+056h]
        mov eax, 4
        mov edx, esi
        mov dword [byte ebp+06Ah], esi
.6:
        call KeyToLong
        mov al, byte [byte ebp+034h]
        cmp al, byte [byte ebp+072h]
        jne near .13
        mov edx, dword [byte ebp-0Ah]
        lea eax, [byte ebp+056h]
        call KeysEqual
        test eax, eax
        je near .13
        mov edx, dword [byte ebp-0Eh]
        mov eax, dword [byte ebp+06Eh]
        cmp eax, dword [edx]
        jge near .13
        cmp dword [dword ebp+08Ah], byte 0
        jne short .7
        cmp dword [byte ebp+062h], byte 0
        je near .11
.7:
        mov ebx, 67h
        mov edx, dword [byte ebp+05Eh]
        mov ecx, dword [DbStaticBuffer]
        xor eax, eax
        call ReadDbRecord
        test eax, eax
        je near FindRecordByKey_1BC
        cmp dword [dword ebp+08Ah], byte 0
        je short .10
        mov edi, dword [byte ebp+06Eh]
        mov eax, dword [byte ebp+06Eh]
        mov esi, dword [DbStaticBuffer]
        shl edi, 3
        inc eax
        add edi, dword [dword ebp+08Eh]
        cmp byte [byte esi+011h], 54h
        jne short .8
        lea esi, [byte esi+012h]
        jmp short .9
.8:
        lea esi, [byte esi+01h]
.9:
        mov dword [byte ebp+06Eh], eax
        movsd
        movsd
.10:
        cmp dword [byte ebp+062h], byte 0
        je short .12
        imul edx, dword [byte ebp+06Eh], byte 2Fh
        mov eax, dword [DbStaticBuffer]
        mov ebx, 2Fh
        inc eax
        add edx, dword [dword ebp+086h]
        inc dword [byte ebp+06Eh]
        call CopyBytesOk
        jmp short .12
.11:
        inc dword [byte ebp+06Eh]
.12:
        lea ecx, [byte ebp+05Eh]
        lea ebx, [byte ebp+02Ah]
        mov edx, 1
        mov eax, dword [DbFileTable]
        call NextIndexKey
        test eax, eax
        je short FindRecordByKey_1BC
        mov ebx, dword [byte ebp+066h]
        lea edx, [byte ebp+02Ah]
        mov eax, 4
        call KeyToLong
        lea ebx, [byte ebp+056h]
        mov edx, dword [byte ebp+06Ah]
        mov eax, 4
        jmp near .6
.13:
        mov edx, dword [byte ebp-0Eh]
        mov eax, dword [byte ebp+06Eh]
        mov dword [edx], eax
        call ServiceIdle
        mov eax, 1
FindRecordByKey_1BC:
        lea esp, [byte ebp+076h]
        pop ebp
        pop edi
        pop esi
        ret 0Ch
;-----------------------------------------------------------------------------
; CountDbRecords                                  DBDC1  97 PC, low confidence
; Counts the records of the database
;-----------------------------------------------------------------------------
CountDbRecords:
        push ebx
        push ecx
        push esi
        push edi
        enter 10h, 0
        mov esi, eax
        mov edi, edx
        mov dword [byte ebp-04h], 0
        mov dword [byte ebp-08h], 7FFFFFFFh
        cmp word [DbOpen], byte 0
        je short .2
        push byte 0
        push byte 0
        mov ebx, 4Ch
        push byte 0
        lea edx, [byte ebp-08h]
        xor ecx, ecx
        call FindRecordByKey
        test eax, eax
        je near FindGameRecord_A0
        cmp dword [byte ebp-08h], byte 0
        jle near .6
        mov edx, dword [byte ebp-08h]
        lea ebx, [byte ebp-010h]
        mov eax, str_TEMP2
        shl edx, 3
        call AllocClearBlock
        test eax, eax
        je near FindGameRecord_A0
        push dword [byte ebp-010h]
        push byte 1
        mov ebx, 4Ch
        lea edx, [byte ebp-08h]
        push byte 0
        mov eax, esi
        xor ecx, ecx
        call FindRecordByKey
        test eax, eax
        jne short .3
.1:
        lea eax, [byte ebp-010h]
        call FreePtr
.2:
        xor eax, eax
        jmp near FindGameRecord_A0
.3:
        xor ecx, ecx
        xor ebx, ebx
        jmp short .5
.4:
        mov eax, dword [byte ebp-010h]
        lea edx, [byte ebp-0Ch]
        add eax, ecx
        call CountDbRecords
        test eax, eax
        je short .1
        mov eax, dword [byte ebp-0Ch]
        add ecx, byte 8
        inc ebx
        add dword [byte ebp-04h], eax
.5:
        cmp ebx, dword [byte ebp-08h]
        jl short .4
        lea eax, [byte ebp-010h]
        call FreePtr
.6:
        push byte 0
        mov ebx, 54h
        push byte 0
        lea edx, [byte ebp-08h]
        mov eax, esi
        push byte 0
        xor ecx, ecx
        mov dword [byte ebp-08h], 7FFFFFFFh
        call FindRecordByKey
        test eax, eax
        je near FindGameRecord_A0
        mov eax, dword [byte ebp-04h]
        add eax, dword [byte ebp-08h]
        mov dword [edi], eax
        jmp near LookupRecord_244
;-----------------------------------------------------------------------------
; RebuildDbIndex                                  DBEB3  97 PC, low confidence
; Rebuilds the database index
;-----------------------------------------------------------------------------
RebuildDbIndex:
        push ecx
        push esi
        push edi
        enter 8, 0
        push eax
        push edx
        push ebx
        mov dword [byte ebp-04h], 7FFFFFFFh
        cmp word [DbOpen], byte 0
        je short .2
        push byte 0
        push byte 0
        mov ebx, 4Ch
        push byte 0
        lea edx, [byte ebp-04h]
        xor ecx, ecx
        call FindRecordByKey
        test eax, eax
        je near .9
        cmp dword [byte ebp-04h], byte 0
        jle near .6
        mov edx, dword [byte ebp-04h]
        lea ebx, [byte ebp-08h]
        mov eax, str_TEMP2
        shl edx, 3
        call AllocClearBlock
        test eax, eax
        je near .9
        push dword [byte ebp-08h]
        push byte 1
        mov ebx, 4Ch
        lea edx, [byte ebp-04h]
        push byte 0
        mov eax, dword [byte ebp-0Ch]
        xor ecx, ecx
        call FindRecordByKey
        test eax, eax
        jne short .3
.1:
        lea eax, [byte ebp-08h]
        call FreePtr
.2:
        xor eax, eax
        leave
        pop edi
        pop esi
        pop ecx
        ret
.3:
        xor esi, esi
        xor ecx, ecx
        jmp short .5
.4:
        mov eax, dword [byte ebp-08h]
        mov ebx, dword [byte ebp-014h]
        mov edx, dword [byte ebp-010h]
        add eax, esi
        call RebuildDbIndex
        test eax, eax
        je short .1
        inc ecx
        add esi, byte 8
.5:
        cmp ecx, dword [byte ebp-04h]
        jl short .4
        lea eax, [byte ebp-08h]
        call FreePtr
.6:
        mov eax, dword [byte ebp-010h]
        mov dword [byte ebp-04h], 7FFFFFFFh
        push dword [eax]
        push byte 1
        mov ebx, 54h
        lea edx, [byte ebp-04h]
        push byte 0
        xor ecx, ecx
        mov eax, dword [byte ebp-0Ch]
        call FindRecordByKey
        test eax, eax
        je short .9
        mov edx, dword [byte ebp-014h]
        xor eax, eax
        jmp short .8
.7:
        mov edi, dword [byte ebp-014h]
        mov esi, dword [byte ebp-0Ch]
        mov edi, dword [edi]
        movsd
        movsd
        inc eax
        add dword [edx], byte 8
.8:
        cmp eax, dword [byte ebp-04h]
        jl short .7
        mov eax, dword [byte ebp-04h]
        mov edx, dword [byte ebp-010h]
        shl eax, 3
        add dword [edx], eax
        call ServiceIdle
        mov eax, 1
.9:
        leave
        pop edi
        pop esi
        pop ecx
        ret
        enter 8, 0
        mov dword [byte ebp-04h], edx
        mov dword [byte ebp-08h], ebx
        lea ebx, [byte ebp-08h]
        lea edx, [byte ebp-04h]
        call RebuildDbIndex
        leave
        ret
        push ebx
        push ecx
        push byte 0
        push byte 0
        mov ebx, 4Ch
        push byte 0
        xor ecx, ecx
        mov dword [edx], 7FFFFFFFh
        call FindRecordByKey
        pop ecx
        pop ebx
        ret
        push ecx
        push byte 0
        push byte 0
        push ebx
        mov ecx, 1
.10:
        mov ebx, 4Ch
        jmp short .12
        push ecx
        push byte 0
        push byte 0
        mov ecx, 1
        push ebx
.11:
        mov ebx, 4Ch
        mov dword [edx], 7FFFFFFFh
.12:
        call FindRecordByKey
        pop ecx
        ret
        push ecx
        push ebx
        push byte 1
        push byte 0
        xor ecx, ecx
        jmp short .10
        push ecx
        push ebx
        push byte 1
        xor ecx, ecx
        push byte 0
        jmp short .11
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 5Ch, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .13
        xor eax, eax
        jmp near OpenGameDatabase_18
.13:
        mov edx, eax
        xor eax, eax
        call NewRecordKey
        test eax, eax
        je near OpenGameDatabase_18
        mov ebx, 67h
        lea edx, [byte ebp-04h]
        xor eax, eax
        call AllocRecordSlot
        test eax, eax
        je near OpenGameDatabase_18
        mov eax, dword [DbStaticBuffer]
        mov byte [eax], 47h
        mov ebx, 2Fh
        mov edx, dword [DbStaticBuffer]
        mov eax, esi
        inc edx
        call CopyBytesOk
        mov ebx, 67h
        mov edx, dword [DbStaticBuffer]
        mov eax, dword [DbRecordCounts]
        call FileWriteRecord
        test eax, eax
        je near OpenGameDatabase_18
        lea ebx, [byte ebp-05Ch]
        mov eax, esi
        xor edx, edx
        call LookupRecord
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov eax, dword [DbFileTable]
        xor edx, edx
        call AddIndexKey
        mov edi, eax
        test eax, eax
        je near AddGameRecord_CC
        lea ebx, [byte ebp-030h]
        mov edx, 1
        mov eax, esi
        call LookupRecord
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 1
        mov eax, dword [DbFileTable]
        call AddIndexKey
        test eax, eax
        jne near AddGameRecord_CC
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov eax, dword [DbFileTable]
        xor edx, edx
        jmp near AddGameRecord_C5
;-----------------------------------------------------------------------------
; RepairDatabase                                  DC11A  97 PC, low confidence
; Checks and repairs the database
;-----------------------------------------------------------------------------
RepairDatabase:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 9Ch, 0
        push eax
        sub ebp, 82h
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near UpdatePlayerRecord_1A6
.2:
        push byte 0
        push byte 0
        mov ebx, 4Ch
        lea edx, [byte ebp+07Eh]
        push byte 0
        xor ecx, ecx
        mov dword [byte ebp+07Eh], 7FFFFFFFh
        call FindRecordByKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
        cmp dword [byte ebp+07Eh], byte 0
        jle short .5
        mov edx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp+076h]
        mov eax, str_TEMP2
        shl edx, 3
        call AllocClearBlock
        test eax, eax
        je near UpdatePlayerRecord_1A6
        push dword [byte ebp+076h]
        push byte 1
        mov ebx, 4Ch
        lea edx, [byte ebp+07Eh]
        push byte 0
        mov eax, dword [byte ebp-01Eh]
        xor ecx, ecx
        call FindRecordByKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
        xor ebx, ebx
        xor edx, edx
        jmp short .4
.3:
        mov eax, dword [byte ebp+076h]
        add eax, ebx
        call RepairDatabase
        test eax, eax
        je near UpdatePlayerRecord_1A6
        inc edx
        add ebx, byte 8
.4:
        cmp edx, dword [byte ebp+07Eh]
        jl short .3
        lea eax, [byte ebp+076h]
        call FreePtr
.5:
        lea edi, [byte ebp-01Ah]
        mov esi, dword [byte ebp-01Eh]
        lea ebx, [byte ebp+042h]
        lea eax, [byte ebp-01Ah]
        lea ecx, [byte ebp+07Ah]
        xor edx, edx
        movsd
        movsd
        call LookupRecord
        lea ebx, [byte ebp+042h]
        mov eax, dword [DbFileTable]
        xor edx, edx
        call FindIndexKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
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
        lea edx, [byte ebp+06Eh]
        mov eax, dword [byte ebp-01Eh]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je near UpdatePlayerRecord_1A6
        mov ebx, 67h
        mov edx, dword [byte ebp+07Ah]
        mov ecx, dword [DbStaticBuffer]
        xor eax, eax
        call ReadDbRecord
        test eax, eax
        je near UpdatePlayerRecord_1A6
        mov ebx, 2Fh
        mov eax, dword [DbStaticBuffer]
        lea edx, [byte ebp-01Ah]
        inc eax
        call CopyBytesOk
        lea ebx, [byte ebp+016h]
        mov edx, 1
        lea eax, [byte ebp-01Ah]
        call LookupRecord
        mov ecx, dword [byte ebp+07Ah]
        lea ebx, [byte ebp+016h]
        mov edx, 1
        mov eax, dword [DbFileTable]
        call DeleteIndexKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
        lea ebx, [byte ebp+042h]
        lea eax, [byte ebp-01Ah]
        xor edx, edx
        call LookupRecord
        mov ecx, dword [byte ebp+07Ah]
        lea ebx, [byte ebp+042h]
        mov eax, dword [DbFileTable]
        xor edx, edx
        call DeleteIndexKey
        test eax, eax
        jne short .6
        mov ecx, dword [byte ebp+07Ah]
        lea ebx, [byte ebp+016h]
        mov edx, 1
        mov eax, dword [DbFileTable]
        call AddIndexKey
        jmp near .1
.6:
        mov ebx, 4
        mov eax, DbRecordSizes
        mov edx, dword [DbStaticBuffer]
        call CopyBytesOk
        mov ebx, 67h
        mov edx, dword [byte ebp+07Ah]
        mov ecx, dword [DbStaticBuffer]
        xor eax, eax
        call WriteDbRecord
        test eax, eax
        je short .7
        mov eax, dword [byte ebp+07Ah]
        xor edx, edx
        mov dword [DbRecordSizes], eax
        mov eax, dword [DbRecordCounts]
        call FileSeek
        test eax, eax
        je short .7
        mov ebx, 4
        mov edx, DbRecordSizes
        mov eax, dword [DbRecordCounts]
        call FileWriteRecord
.7:
        call ServiceIdle
RepairDatabase_21E:
        mov eax, 1
        jmp near UpdatePlayerRecord_1A6
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
        mov dword [eax], 0
        mov edx, 2
        mov eax, dword [DbFileTable]
        call FindLastKey
.9:
        test eax, eax
        je near UpdatePlayerRecord_229
        cmp byte [byte ebp-030h], 0
        je near LookupRecord_307
        cmp dword [byte ebp-04h], byte 0FFFFFFFFh
        je near LookupRecord_307
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        inc dword [esi]
        mov edx, 2
        mov eax, dword [DbFileTable]
        call NextIndexKey
        jmp short .9
        push ebx
        push ecx
        push edx
        push esi
        enter 30h, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .11
.10:
        xor eax, eax
        jmp near UpdatePlayerRecord_229
.11:
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 3
        mov eax, dword [DbFileTable]
        mov dword [DbIndexRoot], 0
        call FindLastKey
        test eax, eax
        je near UpdatePlayerRecord_229
        cmp dword [byte ebp-04h], byte 0FFFFFFFFh
        jne short .12
        cmp byte [byte ebp-030h], 0
        je short .10
.12:
        mov ebx, 67h
        mov edx, dword [byte ebp-04h]
        mov ecx, dword [DbStaticBuffer]
        xor eax, eax
        call ReadDbRecord
        test eax, eax
        je near UpdatePlayerRecord_229
        call ServiceIdle
        mov ebx, 66h
        mov eax, dword [DbStaticBuffer]
        mov edx, esi
        inc eax
        call CopyBytesOk
        mov dword [DbIndexRoot], 1
        jmp near LookupRecord_30C
        push ebx
        push ecx
        push edx
        push esi
        enter 30h, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .13
        xor eax, eax
        jmp near UpdatePlayerRecord_229
.13:
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 3
        mov eax, dword [DbFileTable]
        mov dword [DbIndexRoot], 0
        call FindFirstKey
        test eax, eax
        je near UpdatePlayerRecord_229
        mov ebx, 67h
        mov edx, dword [byte ebp-04h]
        mov ecx, dword [DbStaticBuffer]
        xor eax, eax
        call ReadDbRecord
        test eax, eax
        je near UpdatePlayerRecord_229
        mov ebx, 66h
        mov eax, dword [DbStaticBuffer]
        mov edx, esi
        inc eax
        call CopyBytesOk
        mov dword [DbIndexRoot], 1
        jmp near LookupRecord_307
        push ebx
        push ecx
        push esi
        enter 30h, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .15
.14:
        xor eax, eax
        leave
        pop esi
        pop ecx
        pop ebx
        ret
.15:
        cmp dword [DbIndexRoot], byte 0
        je short .14
        test edx, edx
        je short .17
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 3
        mov eax, dword [DbFileTable]
        call NextIndexKey
.16:
        test eax, eax
        jne short .18
        mov dword [DbIndexRoot], eax
        leave
        pop esi
        pop ecx
        pop ebx
        ret
.17:
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 3
        mov eax, dword [DbFileTable]
        call PrevIndexKey
        jmp short .16
.18:
        cmp dword [byte ebp-04h], byte 0FFFFFFFFh
        jne short .19
        cmp byte [byte ebp-030h], 0
        je short .14
.19:
        mov ebx, 67h
        mov edx, dword [byte ebp-04h]
        mov ecx, dword [DbStaticBuffer]
        xor eax, eax
        call ReadDbRecord
        test eax, eax
        je short .20
        mov ebx, 66h
        mov eax, dword [DbStaticBuffer]
        mov edx, esi
        inc eax
        call CopyBytesOk
        call ServiceIdle
        mov eax, 1
.20:
        leave
        pop esi
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 5Ch, 0
        mov esi, eax
        cmp word [DbOpen], byte 0
        jne short .21
        xor eax, eax
        jmp near OpenGameDatabase_18
.21:
        mov edx, eax
        mov eax, 2
        call NewRecordKey
        test eax, eax
        je near OpenGameDatabase_18
        mov ebx, 67h
        lea edx, [byte ebp-04h]
        xor eax, eax
        call AllocRecordSlot
        test eax, eax
        je near OpenGameDatabase_18
        mov eax, dword [DbStaticBuffer]
        mov byte [eax], 52h
        mov ebx, 66h
        mov edx, dword [DbStaticBuffer]
        mov eax, esi
        inc edx
        call CopyBytesOk
        mov ebx, 67h
        mov edx, dword [DbStaticBuffer]
        mov eax, dword [DbRecordCounts]
        call FileWriteRecord
        test eax, eax
        je near OpenGameDatabase_18
        lea ebx, [byte ebp-05Ch]
        mov edx, 2
        mov eax, esi
        call LookupRecord
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov edx, 2
        mov eax, dword [DbFileTable]
        call AddIndexKey
        mov edi, eax
        test eax, eax
        je near AddGameRecord_CC
        lea ebx, [byte ebp-030h]
        mov edx, 3
        mov eax, esi
        call LookupRecord
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-030h]
        mov edx, 3
        mov eax, dword [DbFileTable]
        call AddIndexKey
        test eax, eax
        jne near AddGameRecord_CC
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-05Ch]
        mov edx, 2
RepairDatabase_52F:
        mov eax, dword [DbFileTable]
        jmp near AddGameRecord_C5
