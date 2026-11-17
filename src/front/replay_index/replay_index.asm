; Replay index entries.
bits 32
%include "hockey.inc"
section s_E19D5 progbits alloc exec nowrite align=1
extern AddIndexKey, AllocRecordSlot, AppendDbRecord, BuildKeyFromLong, BuildKeyFromString, BuildSeasonRecords_797, CreateSeasonSchedule_2F0, DbKeyBuffer
extern DbKeyIndex, DbOpen, DbReplayFile, DeleteIndexKey, FileDelete, FileExists, FileSizePath, FileWriteRecord
extern FindGameRecord_9B, FindGameRecord_A0, FindIndexKey, KeyToLong, LeagueFilePrefix, LoadFileToBlockPlain, MakeLeagueKey, MakeLeagueKeyBase_5
extern MakeRecordKey, memcmp_, RepairDatabase_21E, SaveDataFile, ServiceIdle, sprintf_, StaticBuffer, str_S08x03x
extern UpdatePlayerRecord_1A6, WriteDbRecord, ZeroBytesOk
global AddReplayIndexEntry, FindReplayIndexEntry, OpenReplayFile, RenameReplayIndexEntry, DeleteReplayIndexEntry
;-----------------------------------------------------------------------------
; AddReplayIndexEntry                             E19D5  97 PC, low confidence
; Adds an entry to the saved replay index
;-----------------------------------------------------------------------------
AddReplayIndexEntry:
        push ecx
        push esi
        push edi
        enter 8Ch, 0
        sub ebp, 82h
        mov esi, eax
        mov dword [byte ebp+07Eh], edx
        mov edi, ebx
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near CreateSeasonSchedule_2F0
.2:
        mov ebx, 8
        mov edx, DbKeyBuffer
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je near .4
        test edi, edi
        jl short .1
        cmp dword [byte ebp+07Eh], byte 0
        setne al
        movzx eax, al
        dec eax
        mov edx, esi
        mov dword [dword esi+04A74h], eax
        mov eax, 9
        mov dword [dword esi+04A70h], 0
        call MakeLeagueKey
        test eax, eax
        je near CreateSeasonSchedule_2F0
        test edi, edi
        jle short .3
        mov eax, dword [esi]
        push dword [byte esi+04h]
        xor eax, 0ABCDCBAFh
        push eax
        push dword [LeagueFilePrefix]
        push str_S08x03x
        lea eax, [byte ebp-0Ah]
        push eax
        call sprintf_
        add esp, byte 14h
        push edi
        push dword [byte ebp+07Eh]
        lea eax, [byte ebp-0Ah]
        push eax
        call SaveDataFile
        add esp, byte 0Ch
        test eax, eax
        je near CreateSeasonSchedule_2F0
        mov dword [dword esi+04A70h], edi
.3:
        mov ebx, 4A78h
        lea edx, [byte ebp+07Ah]
        mov eax, 5
        call AllocRecordSlot
        test eax, eax
        je near CreateSeasonSchedule_2F0
        mov ebx, 4A78h
        mov eax, dword [DbReplayFile]
        mov edx, esi
        call FileWriteRecord
        test eax, eax
        je near CreateSeasonSchedule_2F0
        lea edx, [byte ebp+046h]
        mov eax, esi
        lea ebx, [byte ebp+046h]
        call MakeRecordKey
        call ServiceIdle
        mov ecx, dword [byte ebp+07Ah]
        mov edx, 9
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        jmp near CreateSeasonSchedule_2F0
.4:
        lea edx, [byte ebp+046h]
        lea ecx, [byte ebp+07Ah]
        mov eax, esi
        lea ebx, [byte ebp+046h]
        call MakeRecordKey
        mov edx, 9
        mov eax, dword [DbKeyIndex]
        call FindIndexKey
        test eax, eax
        jne short .6
        mov eax, dword [esi]
        cmp eax, dword [StaticBuffer]
        je near .1
.5:
        mov ebx, dword [byte ebp+07Eh]
        mov ecx, edi
        mov edx, esi
        mov eax, esi
        call RenameReplayIndexEntry
        jmp near CreateSeasonSchedule_2F0
.6:
        lea ebx, [byte ebp+072h]
        lea edx, [byte ebp+046h]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp+046h]
        lea ebx, [byte ebp+072h]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        mov ebx, 8
        lea eax, [byte ebp+072h]
        mov edx, esi
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je short .5
        call ServiceIdle
        mov eax, dword [esi]
        push dword [byte esi+04h]
        xor eax, 0ABCDCBAFh
        push eax
        push dword [LeagueFilePrefix]
        push str_S08x03x
        lea eax, [byte ebp-0Ah]
        push eax
        call sprintf_
        add esp, byte 14h
        cmp dword [dword esi+04A70h], byte 0
        jle short .8
        cmp dword [byte ebp+07Eh], byte 0
        je short .7
        test edi, edi
        jne short .8
.7:
        lea eax, [byte ebp-0Ah]
        call FileDelete
        mov dword [dword esi+04A70h], 0
.8:
        test edi, edi
        jle short .9
        push edi
        push dword [byte ebp+07Eh]
        lea eax, [byte ebp-0Ah]
        push eax
        call SaveDataFile
        add esp, byte 0Ch
        test eax, eax
        je near CreateSeasonSchedule_2F0
        mov dword [dword esi+04A70h], edi
.9:
        cmp dword [byte ebp+07Eh], byte 0
        jne short .10
        mov dword [dword esi+04A74h], 0FFFFFFFFh
        jmp short .11
.10:
        cmp dword [dword esi+04A74h], byte 0FFFFFFFFh
        je short .11
        inc dword [dword esi+04A74h]
.11:
        mov ebx, 4A78h
        mov edx, dword [byte ebp+07Ah]
        mov eax, 5
        mov ecx, esi
        call WriteDbRecord
        jmp near CreateSeasonSchedule_2F0
;-----------------------------------------------------------------------------
; FindReplayIndexEntry                            E1C19  97 PC, low confidence
; Finds an entry of the saved replay index
;-----------------------------------------------------------------------------
FindReplayIndexEntry:
        push ebx
        push ecx
        push esi
        push edi
        enter 38h, 0
        push eax
        push edx
        mov edx, 4A78h
        mov eax, dword [byte ebp-040h]
        mov edi, dword [byte ebp-040h]
        mov esi, dword [byte ebp-03Ch]
        lea ecx, [byte ebp-04h]
        lea ebx, [byte ebp-038h]
        call ZeroBytesOk
        lea edx, [byte ebp-038h]
        mov eax, dword [byte ebp-040h]
        movsd
        movsd
        call MakeRecordKey
        mov edx, 9
        mov eax, dword [DbKeyIndex]
        call FindIndexKey
        test eax, eax
        je near FindGameRecord_A0
        call ServiceIdle
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
        mov ecx, dword [byte ebp-040h]
        mov ebx, 4A78h
        mov edx, dword [byte ebp-04h]
        mov eax, 5
        jmp near FindGameRecord_9B
;-----------------------------------------------------------------------------
; OpenReplayFile                                  E1CC0  97 PC, low confidence
; Builds a replay's file name ("%s%08x.%03x", id xor 0ABCDCBAFh) and opens it
; when it exists with the expected size
;-----------------------------------------------------------------------------
OpenReplayFile:
        push ebx
        push ecx
        push esi
        enter 50h, 0
        mov ebx, eax
        mov esi, edx
        push dword [byte eax+04h]
        mov eax, dword [eax]
        xor eax, 0ABCDCBAFh
        push eax
        push dword [LeagueFilePrefix]
        push str_S08x03x
        lea eax, [byte ebp-050h]
        push eax
        call sprintf_
        add esp, byte 14h
        cmp dword [dword ebx+04A70h], byte 0
        je short .2
        lea eax, [byte ebp-050h]
        call FileExists
        test eax, eax
        je short .3
        lea eax, [byte ebp-050h]
        push eax
        call FileSizePath
        add esp, byte 4
        cmp eax, dword [dword ebx+04A70h]
        je short .1
        xor eax, eax
        leave
        pop esi
        pop ecx
        pop ebx
        ret
.1:
        push esi
        lea eax, [byte ebp-050h]
        push eax
        call LoadFileToBlockPlain
        add esp, byte 8
        test eax, eax
        je short .3
.2:
        mov eax, 1
.3:
        leave
        pop esi
        pop ecx
        pop ebx
        ret
        push edx
        mov edx, eax
        mov eax, 9
        jmp near MakeLeagueKeyBase_5
;-----------------------------------------------------------------------------
; RenameReplayIndexEntry                          E1D45  97 PC, low confidence
; Renames an entry of the saved replay index
;-----------------------------------------------------------------------------
RenameReplayIndexEntry:
        push esi
        push edi
        enter 88h, 0
        push eax
        push edx
        push ebx
        push ecx
        sub ebp, 82h
        cmp word [DbOpen], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near BuildSeasonRecords_797
.2:
        mov ebx, 8
        mov edx, DbKeyBuffer
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne short .1
        mov eax, dword [byte ebp-0Ah]
        mov eax, dword [eax]
        cmp eax, dword [StaticBuffer]
        je short .1
        mov edi, dword [byte ebp-0Eh]
        mov esi, dword [byte ebp-0Ah]
        lea edx, [byte ebp+04Ah]
        mov eax, dword [byte ebp-0Eh]
        lea ecx, [byte ebp+07Eh]
        lea ebx, [byte ebp+04Ah]
        movsd
        movsd
        call MakeRecordKey
        mov edx, 9
        mov eax, dword [DbKeyIndex]
        call FindIndexKey
        test eax, eax
        je short .3
        call ServiceIdle
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
        mov edx, dword [byte ebp-0Ah]
        lea eax, [byte ebp+076h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        jne near .1
.3:
        call ServiceIdle
        cmp dword [byte ebp-016h], byte 0
        jl near .1
        mov eax, dword [byte ebp-0Eh]
        mov dword [dword eax+04A70h], 0
        jle short .4
        push dword [byte eax+04h]
        mov eax, dword [eax]
        xor eax, 0ABCDCBAFh
        push eax
        push dword [LeagueFilePrefix]
        push str_S08x03x
        lea eax, [byte ebp-06h]
        push eax
        call sprintf_
        add esp, byte 14h
        push dword [byte ebp-016h]
        push dword [byte ebp-012h]
        lea eax, [byte ebp-06h]
        push eax
        call SaveDataFile
        add esp, byte 0Ch
        test eax, eax
        je near BuildSeasonRecords_797
        mov edx, dword [byte ebp-0Eh]
        mov eax, dword [byte ebp-016h]
        mov dword [dword edx+04A70h], eax
.4:
        mov ebx, 4A78h
        lea edx, [byte ebp+07Eh]
        mov eax, 5
        call AllocRecordSlot
        test eax, eax
        je near BuildSeasonRecords_797
        mov ebx, 4A78h
        mov edx, dword [byte ebp-0Eh]
        mov eax, dword [DbReplayFile]
        call FileWriteRecord
        test eax, eax
        je near BuildSeasonRecords_797
        lea edx, [byte ebp+04Ah]
        mov eax, dword [byte ebp-0Eh]
        lea ebx, [byte ebp+04Ah]
        call MakeRecordKey
        call ServiceIdle
        mov ecx, dword [byte ebp+07Eh]
        mov edx, 9
        mov eax, dword [DbKeyIndex]
        call AddIndexKey
        jmp near BuildSeasonRecords_797
;-----------------------------------------------------------------------------
; DeleteReplayIndexEntry                          E1EC9  97 PC, low confidence
; Deletes an entry of the saved replay index
;-----------------------------------------------------------------------------
DeleteReplayIndexEntry:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 4B00h, 0
        push eax
        sub ebp, 82h
        mov edx, 4A78h
        lea eax, [dword ebp-04A7Eh]
        lea edi, [dword ebp-04A7Eh]
        mov esi, dword [dword ebp-04A82h]
        lea ecx, [byte ebp+07Eh]
        lea ebx, [byte ebp+04Ah]
        call ZeroBytesOk
        lea edx, [byte ebp+04Ah]
        lea eax, [dword ebp-04A7Eh]
        movsd
        movsd
        call MakeRecordKey
        mov edx, 9
        mov eax, dword [DbKeyIndex]
        call FindIndexKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
        call ServiceIdle
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
        mov edx, dword [dword ebp-04A82h]
        lea eax, [byte ebp+076h]
        call memcmp_
        test eax, eax
        sete al
        movzx eax, al
        test eax, eax
        je near UpdatePlayerRecord_1A6
        lea edx, [dword ebp-04A7Eh]
        mov eax, dword [dword ebp-04A82h]
        call FindReplayIndexEntry
        test eax, eax
        je near UpdatePlayerRecord_1A6
        mov eax, dword [dword ebp-04A7Eh]
        push dword [dword ebp-04A7Ah]
        xor eax, 0ABCDCBAFh
        push eax
        push dword [LeagueFilePrefix]
        push str_S08x03x
        lea eax, [byte ebp-06h]
        push eax
        call sprintf_
        add esp, byte 14h
        lea eax, [byte ebp-06h]
        call FileExists
        test eax, eax
        je short .1
        lea eax, [byte ebp-06h]
        call FileDelete
.1:
        mov ecx, dword [byte ebp+07Eh]
        lea ebx, [byte ebp+04Ah]
        mov edx, 9
        mov eax, dword [DbKeyIndex]
        call DeleteIndexKey
        test eax, eax
        je near UpdatePlayerRecord_1A6
        mov ebx, 4A78h
        mov edx, dword [byte ebp+07Eh]
        mov eax, 5
        call AppendDbRecord
        test eax, eax
        jne near RepairDatabase_21E
        jmp near UpdatePlayerRecord_1A6
        push ebx
        push ecx
        enter 8, 0
        mov ebx, eax
        mov ecx, edx
        lea edx, [byte ebp-08h]
        mov eax, dword [StaticBuffer]
        mov dword [byte ebp-04h], ebx
        mov dword [byte ebp-08h], eax
        add edx, byte 4
        mov ebx, ecx
        mov eax, 4
        call BuildKeyFromLong
        lea edx, [byte ebp-08h]
        mov eax, 4
        mov ebx, ecx
        call BuildKeyFromString
        mov eax, 1
        leave
        pop ecx
        pop ebx
        ret
