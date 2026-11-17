; User records.
bits 32
%include "hockey.inc"
section s_E2041 progbits alloc exec nowrite align=1
extern AddIndexKey, AllocRecordSlot, AppendDbRecord, DbFileTable, DbUserFile, DeleteIndexKey, FileWriteRecord, FindGameRecord_9B
extern FindGameRecord_A0, FindIndexKey, KeyToLong, LookupRecord_249, MakeRecordKey, RecordHomeStats_15A, StaticBuffer, UpdatePlayerRecord_221
extern UpdatePlayerRecord_229, WriteDbRecord
global SaveUserRecord, LoadUserRecord, DeleteUserRecord
;-----------------------------------------------------------------------------
; SaveUserRecord                                  E2041  97 PC, low confidence
; Saves a user record
;-----------------------------------------------------------------------------
SaveUserRecord:
        push ebx
        push ecx
        push esi
        push edi
        enter 4Ch, 0
        mov esi, eax
        mov edi, edx
        lea ecx, [byte ebp-08h]
        mov eax, dword [StaticBuffer]
        mov dword [byte ebp-0Ch], edx
        lea edx, [byte ebp-04Ch]
        mov dword [byte ebp-010h], eax
        lea eax, [byte ebp-010h]
        lea ebx, [byte ebp-04Ch]
        call MakeRecordKey
        mov edx, 6
        mov eax, dword [DbFileTable]
        call FindIndexKey
        mov dword [byte ebp-04h], eax
        test eax, eax
        je short .1
        lea ebx, [byte ebp-018h]
        lea edx, [byte ebp-04Ch]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp-04Ch]
        lea ebx, [byte ebp-018h]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        cmp edi, dword [byte ebp-014h]
        je short .1
        mov dword [byte ebp-04h], 0
.1:
        cmp dword [byte ebp-04h], byte 0
        jne short .2
        mov ebx, 176h
        lea edx, [byte ebp-08h]
        mov eax, 6
        call AllocRecordSlot
        test eax, eax
        je near FindGameRecord_A0
        mov ebx, 176h
        mov eax, dword [DbUserFile]
        mov edx, esi
        call FileWriteRecord
        test eax, eax
        jne short .3
        jmp near FindGameRecord_A0
.2:
        mov ebx, 176h
        mov edx, dword [byte ebp-08h]
        mov eax, 6
        mov ecx, esi
        call WriteDbRecord
        test eax, eax
        je near FindGameRecord_A0
.3:
        cmp dword [byte ebp-04h], byte 0
        jne near LookupRecord_249
        lea edx, [byte ebp-04Ch]
        mov eax, dword [StaticBuffer]
        lea ebx, [byte ebp-04Ch]
        mov dword [byte ebp-020h], eax
        lea eax, [byte ebp-020h]
        mov dword [byte ebp-01Ch], edi
        call MakeRecordKey
        mov ecx, dword [byte ebp-08h]
        mov edx, 6
        mov eax, dword [DbFileTable]
        call AddIndexKey
        jmp near RecordHomeStats_15A
;-----------------------------------------------------------------------------
; LoadUserRecord                                  E2141  97 PC, low confidence
; Loads a user record
;-----------------------------------------------------------------------------
LoadUserRecord:
        push ebx
        push ecx
        push esi
        push edi
        enter 40h, 0
        mov esi, eax
        mov edi, edx
        lea edx, [byte ebp-040h]
        lea ecx, [byte ebp-04h]
        mov eax, dword [StaticBuffer]
        lea ebx, [byte ebp-040h]
        mov dword [byte ebp-0Ch], eax
        lea eax, [byte ebp-0Ch]
        mov dword [byte ebp-08h], esi
        call MakeRecordKey
        mov edx, 6
        mov eax, dword [DbFileTable]
        call FindIndexKey
        test eax, eax
        je near FindGameRecord_A0
        lea ebx, [byte ebp-014h]
        lea edx, [byte ebp-040h]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp-040h]
        lea ebx, [byte ebp-014h]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        cmp esi, dword [byte ebp-010h]
        je short .1
        xor eax, eax
        jmp near FindGameRecord_A0
.1:
        mov ebx, 176h
        mov edx, dword [byte ebp-04h]
        mov eax, 6
        mov ecx, edi
        jmp near FindGameRecord_9B
;-----------------------------------------------------------------------------
; DeleteUserRecord                                E21C6  97 PC, low confidence
; Deletes a user record
;-----------------------------------------------------------------------------
DeleteUserRecord:
        push ebx
        push ecx
        push edx
        push esi
        enter 40h, 0
        mov esi, eax
        lea edx, [byte ebp-040h]
        lea ecx, [byte ebp-04h]
        mov eax, dword [StaticBuffer]
        lea ebx, [byte ebp-040h]
        mov dword [byte ebp-0Ch], eax
        lea eax, [byte ebp-0Ch]
        mov dword [byte ebp-08h], esi
        call MakeRecordKey
        mov edx, 6
        mov eax, dword [DbFileTable]
        call FindIndexKey
        test eax, eax
        je near UpdatePlayerRecord_229
        lea ebx, [byte ebp-014h]
        lea edx, [byte ebp-040h]
        mov eax, 4
        add ebx, byte 4
        call KeyToLong
        lea edx, [byte ebp-040h]
        lea ebx, [byte ebp-014h]
        mov eax, 4
        add edx, byte 5
        call KeyToLong
        cmp esi, dword [byte ebp-010h]
        je short .1
        xor eax, eax
        jmp near UpdatePlayerRecord_229
.1:
        mov ecx, dword [byte ebp-04h]
        lea ebx, [byte ebp-040h]
        mov edx, 6
        mov eax, dword [DbFileTable]
        call DeleteIndexKey
        test eax, eax
        je near UpdatePlayerRecord_229
        mov ebx, 176h
        mov edx, dword [byte ebp-04h]
        mov eax, 6
        call AppendDbRecord
        jmp near UpdatePlayerRecord_221
