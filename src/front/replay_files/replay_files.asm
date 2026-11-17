; Replay files: writing and naming saved replays.
bits 32
%include "hockey.inc"
section s_AC41B progbits alloc exec nowrite align=1
extern AddReplayIndexEntry, AllocMemBlock, ClearLinkAbort, CloseGameDatabase, DbKeyBuffer, DosFileInfo, EditFileName, FreeMemBlock
extern GameSettings, GetLangText, LinkGameActive, LoadNameIndex, MakeDirPath, MenuFontLarge, MenuFontSmall, NameIndexFree
extern NameIndexLoad, NameIndexNew, OpenGameDatabase, PlayoffRoundBits, PlayoffTeamNames, PlayoffTeams, PlayoffUserIndex, PlayoffUserReplay
extern ReplayFileOpen, ReplayIndexHandle, SaveGameResults_B2F, SaveGameResults_B30, SaveReplayHeader, SeasonActive, SeasonDefaultUser, SeasonFileName
extern SeasonUserReplay, SeasonUserTeam, SelectFont, sprintf_, str_EXHIBITNDX2, str_Saverepl, str_SEXHIBITNDX, ViewScreenWidth
extern WriteLeagueHeader, ZeroMem
global SaveReplayFile, WriteReplayFile, ReplayNameToKey, ClearReplayEntry
;-----------------------------------------------------------------------------
; SaveReplayFile                                  AC41B  97 PC, low confidence
; Saves a replay to a file
;-----------------------------------------------------------------------------
SaveReplayFile:
        push ebx
        push ecx
        push edx
        push esi
        mov edx, eax
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov eax, dword [byte eax+020h]
        add eax, edx
        mov dl, byte [byte eax+02h]
        cmp dl, byte [byte eax+03h]
        jle short .1
        movsx ebx, byte [eax]
        jmp short .2
.1:
        movsx ebx, byte [byte eax+01h]
.2:
        xor eax, eax
.3:
        inc eax
        cmp eax, byte 8
        jl short .3
        xor eax, eax
.4:
        mov ecx, dword [nosplit eax*4+PlayoffTeams]
        cmp ecx, dword [nosplit ebx*4+PlayoffTeams]
        jne short .5
        mov esi, eax
.5:
        inc eax
        cmp eax, byte 1Eh
        jl short .4
        inc dword [nosplit esi*4+PlayoffTeamNames]
        mov edx, dword [PlayoffRoundBits]
        and edx, byte 7
        shr edx, 1
        inc edx
        cmp edx, dword [nosplit esi*4+PlayoffTeamNames]
        jne short .10
        xor eax, eax
        jmp short .9
.6:
        mov ecx, eax
        mov edx, dword [byte edx+020h]
        shl ecx, 4
        add edx, ecx
        movsx ecx, byte [byte edx+02h]
        cmp ecx, byte 0FFFFFFFFh
        jne short .8
        movsx ecx, byte [edx]
        cmp ecx, ebx
        je short .7
        movsx edx, byte [byte edx+01h]
        cmp edx, ebx
        jne short .8
.7:
        mov ecx, eax
        mov edx, dword [SeasonUserTeam]
        shl ecx, 4
        mov edx, dword [byte edx+020h]
        mov byte [ecx+edx], 0FFh
        mov edx, dword [SeasonUserTeam]
        mov edx, dword [byte edx+020h]
        mov byte [byte ecx+edx+01h], 0FFh
        mov edx, dword [SeasonUserTeam]
        mov edx, dword [byte edx+020h]
        mov word [byte ecx+edx+04h], 0
.8:
        inc eax
.9:
        mov edx, dword [SeasonUserTeam]
        movsx ecx, word [byte edx+02h]
        cmp eax, ecx
        jl short .6
.10:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 0A8h, 0
        sub ebp, 8Eh
        call OpenGameDatabase
        xor esi, esi
        test byte [GameSettings], 70h
        jne near .18
        cmp dword [ViewScreenWidth], 140h
        je short .11
        push dword [MenuFontSmall]
        jmp short .12
.11:
        push dword [MenuFontLarge]
.12:
        call SelectFont
        add esp, byte 4
        cmp dword [LinkGameActive], byte 0
        je short .13
        call ClearLinkAbort
        test eax, eax
        jne short .13
        push byte 1
        mov eax, 78h
        mov ecx, 1
        mov edx, 1Eh
        call GetLangText
        mov ebx, eax
        lea eax, [byte ebp+05Eh]
        call EditFileName
        test eax, eax
        jne short .15
        jmp short .14
.13:
        push byte 1
        mov eax, 78h
        mov ecx, 2
        mov edx, 1Eh
        call GetLangText
        mov ebx, eax
        lea eax, [byte ebp+05Eh]
        call EditFileName
        test eax, eax
        jne short .15
.14:
        mov esi, 1
.15:
        test esi, esi
        jne near .21
        mov edx, 1
        lea eax, [byte ebp+036h]
        xor ebx, ebx
        call MakeDirPath
        lea eax, [byte ebp+036h]
        push eax
        push str_SEXHIBITNDX
        lea eax, [byte ebp-01Ah]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-01Ah]
        push eax
        call DosFileInfo
        add esp, byte 4
        test eax, eax
        jne short .16
        mov edx, str_EXHIBITNDX2
        lea eax, [byte ebp+036h]
        call NameIndexNew
        jmp short .17
.16:
        mov edx, str_EXHIBITNDX2
        lea eax, [byte ebp+036h]
        call NameIndexLoad
.17:
        mov ecx, eax
        mov edi, SeasonFileName
        mov esi, DbKeyBuffer
        movsd
        movsd
        mov dword [ReplayFileOpen], 0
        call WriteReplayFile
        lea eax, [byte ebp+07Eh]
        push eax
        push dword [ReplayIndexHandle]
        lea ebx, [byte ebp+05Eh]
        push dword [SeasonFileName]
        lea edx, [byte ebp+07Eh]
        call ClearReplayEntry
        mov eax, ecx
        call LoadNameIndex
        mov edx, eax
        mov eax, 1
        call NameIndexFree
        jmp short .21
.18:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 10h
        jne short .19
        cmp dword [SeasonActive], byte 0
        jne short .19
        imul eax, dword [SeasonDefaultUser], byte 1Ch
        mov edx, dword [dword eax+SeasonUserReplay]
        jmp short .20
.19:
        movzx eax, byte [PlayoffUserIndex]
        imul eax, byte 1Ch
        mov edx, dword [dword eax+PlayoffUserReplay]
.20:
        call WriteReplayFile
        mov eax, dword [SeasonUserTeam]
        shl edx, 4
        mov esi, dword [byte eax+020h]
        lea edi, [byte edx+esi+08h]
        mov esi, SeasonFileName
        movsd
        movsd
        mov eax, dword [SeasonUserTeam]
        call WriteLeagueHeader
.21:
        call CloseGameDatabase
        lea esp, [dword ebp+08Eh]
        jmp near SaveGameResults_B2F
;-----------------------------------------------------------------------------
; WriteReplayFile                                 AC69C  97 PC, low confidence
; Writes the replay data and index entry
;-----------------------------------------------------------------------------
WriteReplayFile:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        xor edx, edx
        xor eax, eax
        call SaveReplayHeader
        push byte 0
        push eax
        mov edi, SeasonFileName
        push str_Saverepl
        mov esi, DbKeyBuffer
        mov ebx, eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov edx, ebx
        mov ecx, eax
        call SaveReplayHeader
        mov eax, SeasonFileName
        mov edx, ecx
        movsd
        movsd
        call AddReplayIndexEntry
        push ecx
        call FreeMemBlock
        add esp, byte 4
        jmp near SaveGameResults_B30
;-----------------------------------------------------------------------------
; ReplayNameToKey                                 AC6EB  97 PC, low confidence
; Builds the index key of a replay name
;-----------------------------------------------------------------------------
ReplayNameToKey:
        push ebx
        push edx
        push edi
        enter 8, 0
        push esi
        mov esi, eax
        lea edi, [byte ebp-08h]
        xor eax, eax
.1:
        lea edx, [eax+eax]
        add edx, esi
        lea ebx, [edi+eax]
        cmp byte [edx], 0FFh
        jne short .2
        mov dl, byte [byte edx+01h]
        mov byte [ebx], dl
        jmp short .3
.2:
        cmp byte [edx], 1
        jne short .3
        mov byte [ebx], 0
.3:
        inc eax
        cmp eax, byte 4
        jl short .1
        xor eax, eax
.4:
        inc eax
        mov bl, 0FFh
        sub bl, byte [byte esi+eax+07h]
        mov byte [byte edi+eax+03h], bl
        cmp eax, byte 4
        jl short .4
        mov edi, dword [byte ebp-0Ch]
        lea esi, [byte ebp-08h]
        movsd
        movsd
        mov eax, dword [byte ebp-0Ch]
        leave
        pop edi
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ClearReplayEntry                                AC73E  97 PC, low confidence
; Clears a replay index entry
;-----------------------------------------------------------------------------
ClearReplayEntry:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        push byte 0Dh
        push dword [byte ebp+020h]
        lea esi, [byte ebp+018h]
        call ZeroMem
        add esp, byte 8
        xor edx, edx
.1:
        lea ebx, [esi+edx]
        lea eax, [edx+edx]
        add eax, dword [byte ebp+020h]
        cmp byte [ebx], 0
        jne short .2
        mov byte [byte eax+01h], 1
        mov byte [eax], 1
        jmp short .3
.2:
        mov byte [eax], 0FFh
        mov bl, byte [ebx]
        mov byte [byte eax+01h], bl
.3:
        inc edx
        cmp edx, byte 4
        jl short .1
        mov eax, dword [byte ebp+020h]
        xor edx, edx
.4:
        inc edx
        mov bl, 0FFh
        sub bl, byte [byte edx+esi+03h]
        mov byte [byte edx+eax+07h], bl
        cmp edx, byte 4
        jl short .4
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 0Ch
