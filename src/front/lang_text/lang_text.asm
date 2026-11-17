; Language text and position abbreviations.
bits 32
%include "hockey.inc"
section s_8E737 progbits alloc exec nowrite align=1
extern ErrorTextPtr, FreeMemBlock, GameSettings, LangTextFiles, LangTextHandle, LangTextLoaded, LoadDataFileHandle, RunNewSeason_16F
extern RunNewSeason_17B, RunNewSeason_187, RunNewSeason_193, RunNewSeason_DD, RunNewSeason_E6, RunNewSeason_EF, RunNewSeason_F8, str_3_LoadLangText
global LoadLangText, LoadLangTextB, GetLangText, FreeLangText, PositionAbbrev, SeasonLengthJumpTable, PlayoffRoundsJumpTable
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; LoadLangText                                 8E740  96 PC, medium confidence
; At start-up: the language text index (data file) and the Localize buffer
; (800h) for the language
;-----------------------------------------------------------------------------
LoadLangText:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebx, eax
        mov edx, dword [LangTextHandle]
        test edx, edx
        je short .1
        push edx
        call FreeMemBlock
        add esp, byte 4
.1:
        mov edx, 20h
        mov ebp, 1
        xor esi, esi
        mov eax, dword [nosplit ebx*4+str_3_LoadLangText]
        mov dword [LangTextHandle], esi
        mov dword [LangTextLoaded], esi
        call LoadDataFileHandle
        mov dword [LangTextHandle], eax
        mov dword [LangTextLoaded], ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LoadLangTextB                                   8E790  97 PC, low confidence
; LoadLangText for the second text set (file ids 0D6h-0D8h), used by the
; network screens and after a game
;-----------------------------------------------------------------------------
LoadLangTextB:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebx, eax
        mov edx, dword [LangTextHandle]
        test edx, edx
        je short .1
        push edx
        call FreeMemBlock
        add esp, byte 4
.1:
        mov edx, 20h
        mov ebp, 2
        xor esi, esi
        mov eax, dword [nosplit ebx*4+LangTextFiles]
        mov dword [LangTextHandle], esi
        mov dword [LangTextLoaded], esi
        call LoadDataFileHandle
        mov dword [LangTextHandle], eax
        mov dword [LangTextLoaded], ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; GetLangText                                  8E7E0  96 PC, medium confidence
; (text id): the text for an id from the language file (cached blocks);
; "LFERROR!!!" if missing
;-----------------------------------------------------------------------------
GetLangText:
        push edx
        cmp dword [LangTextHandle], byte 0
        je short .1
        lea edx, [nosplit eax*8+00h]
        mov eax, dword [LangTextHandle]
        add edx, eax
        add edx, byte 4
        movsx edx, word [edx]
        add eax, edx
        pop edx
        ret
.1:
        mov eax, dword [ErrorTextPtr]
        pop edx
        ret
        db 08Dh,040h,00h
        push edx
        mov edx, dword [LangTextHandle]
        test edx, edx
        je short .2
        movsx eax, word [edx+eax*8]
        pop edx
        ret
.2:
        xor eax, eax
        pop edx
        ret
        db 08Dh,040h,00h
        push edx
        mov edx, dword [LangTextHandle]
        test edx, edx
        je short .3
        shl eax, 3
        add eax, edx
        add eax, byte 2
        movsx eax, word [eax]
        pop edx
        ret
.3:
        xor eax, eax
        pop edx
        ret
;-----------------------------------------------------------------------------
; FreeLangText                                 8E840  96 PC, medium confidence
; At shut-down: frees the language text index and buffer
;-----------------------------------------------------------------------------
FreeLangText:
        push ecx
        push edx
        mov edx, dword [LangTextHandle]
        test edx, edx
        je short .1
        push edx
        call FreeMemBlock
        add esp, byte 4
.1:
        xor ecx, ecx
        mov dword [LangTextLoaded], ecx
        mov dword [LangTextHandle], ecx
        pop edx
        pop ecx
        ret
        db 08Bh,0C0h
        mov eax, dword [LangTextLoaded]
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PositionAbbrev                                  8E870  97 PC, low confidence
; Returns the abbreviation of a position
;-----------------------------------------------------------------------------
PositionAbbrev:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 4
        test byte [GameSettings], 0Ch
        je near .15
        mov byte [esp], al
        cmp al, 47h
        jb short .1
        jbe near .10
        cmp al, 4Ch
        jb near .12
        jbe short .2
        cmp al, 52h
        je short .6
        jmp near .12
.1:
        cmp al, 43h
        jb near .12
        jbe short .4
        cmp al, 44h
        je near .8
        jmp near .12
.2:
        mov ebx, dword [LangTextHandle]
        test ebx, ebx
        je short .3
        lea edx, [dword ebx+012ECh]
        movsx edx, word [edx]
        lea eax, [ebx+edx]
        jmp near .13
.3:
        mov eax, dword [ErrorTextPtr]
        jmp near .13
.4:
        mov edi, dword [LangTextHandle]
        test edi, edi
        je short .5
        lea edx, [dword edi+012FCh]
        movsx edx, word [edx]
        lea eax, [edi+edx]
        jmp near .13
.5:
        mov eax, dword [ErrorTextPtr]
        jmp near .13
.6:
        mov edx, dword [LangTextHandle]
        test edx, edx
        je short .7
        mov eax, edx
        add edx, 12F4h
        movsx edx, word [edx]
        add eax, edx
        jmp short .13
.7:
        mov eax, dword [ErrorTextPtr]
        jmp short .13
.8:
        mov esi, dword [LangTextHandle]
        test esi, esi
        je short .9
        lea edx, [dword esi+01304h]
        movsx edx, word [edx]
        lea eax, [esi+edx]
        jmp short .13
.9:
        mov eax, dword [ErrorTextPtr]
        jmp short .13
.10:
        mov ecx, dword [LangTextHandle]
        test ecx, ecx
        je short .11
        lea edx, [dword ecx+012E4h]
        movsx edx, word [edx]
        lea eax, [ecx+edx]
        jmp short .13
.11:
        mov eax, dword [ErrorTextPtr]
        jmp short .13
.12:
        mov eax, esp
.13:
        test eax, eax
        jne short .14
        mov eax, esp
.14:
        mov al, byte [eax]
.15:
        add esp, byte 4
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
SeasonLengthJumpTable:                          ; jump table for the switch cases of RunNewSeason
        dd RunNewSeason_F8
        dd RunNewSeason_DD
        dd RunNewSeason_E6
        dd RunNewSeason_EF
PlayoffRoundsJumpTable:                         ; jump table for the switch cases of RunNewSeason
        dd RunNewSeason_16F
        dd RunNewSeason_17B
        dd RunNewSeason_187
        dd RunNewSeason_193
