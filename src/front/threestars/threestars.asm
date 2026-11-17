; Three stars: scoring, picks, stats and art.
bits 32
%include "hockey.inc"
section s_A728C progbits alloc exec nowrite align=1
extern AutoLineData, AwayPlayerRecords, AwayRosterData, BlitArt, BlitShape, DrawTextAligned, FindShape, GameLogCount
extern GameOptionFlags, GameSettings, GameStatsSpeechCount, GetLangText, GoldStarShapes, HomeInjuredCount, homelines, HomePlayerRecords
extern HomeRosterData, MeasureText, memset_, PenaltyLogCount, PeriodAwayTeam, PeriodHomeTeam, PlaySfx, PostGameLastSpeech
extern PostGameLayer, qsort_, Random32, ScoringLogCount, sprintf_, StarFrameShapes, StopAllSfx, str_DCS
extern str_DSS2, ThreeStarsChoice, ThreeStarsCount, ThreeStarsLayers, ThreeStarsPlayer, ThreeStarsPoints, ThreeStarsPos, ThreeStarsSoundOn
extern ThreeStarsSpeechCount, ThreeStarsTeam, ThreeStarsTimer, tickcount
global StarScore, StarBonus, StarBonus_AC, PickThreeStars, DrawThreeStarStats, DrawThreeStarStats_4A8, ThreeStarsSound, ThreeStarsFlash
global ThreeStarsFlash_E4, ThreeStarsFlash_14E, LoadThreeStarsArt, ClearThreeStars
;-----------------------------------------------------------------------------
; StarScore                                       A728C  97 PC, low confidence
; Works out the score for picking the three stars
;-----------------------------------------------------------------------------
StarScore:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        imul bx, word [byte eax+02h], byte 3
        imul dx, word [eax], byte 0Ah
        mov cx, word [byte eax+06h]
        add edx, ebx
        imul ebx, ecx, byte 3
        mov si, word [byte eax+0Eh]
        mov di, word [byte eax+010h]
        add edx, esi
        add edx, edi
        mov si, word [byte eax+0Ch]
        add ebx, edx
        imul edx, esi, byte 5
        mov ax, word [byte eax+04h]
        add edx, ebx
        add eax, edx
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; StarBonus                                       A72C8  97 PC, low confidence
; Adds the bonus for picking the three stars
;-----------------------------------------------------------------------------
StarBonus:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        mov ecx, dword [GameOptionFlags]
        mov ecx, dword [byte ecx+01h]
        shl ecx, 13h
        mov edx, 5
        shr ecx, 1Eh
        shl edx, cl
        mov ecx, edx
        shl ecx, 4
        sub ecx, edx
        movsx edx, word [eax]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add edx, eax
        shl edx, 2
        shl ecx, 2
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        cmp word [byte ebx+02h], byte 0Fh
        jl short .1
        cmp eax, byte 28h
        jge short .2
.1:
        xor ecx, ecx
        jmp short .4
.2:
        mov edi, dword [byte ebx+06h]
        mov esi, dword [ebx]
        sar edi, 10h
        sar esi, 10h
        lea edx, [nosplit edi*4+00h]
        mov eax, esi
        sub edx, edi
        sar eax, 1
        neg edx
        add eax, edx
        mov ecx, eax
        cmp word [byte ebx+02h], byte 0
        jle short .3
        mov edx, esi
        sub edx, edi
        mov eax, edx
        shl eax, 4
        sub eax, edx
        add eax, eax
        mov edx, eax
        sar edx, 1Fh
        idiv esi
        movsx ecx, cx
        add ecx, eax
.3:
        cmp word [byte ebx+08h], byte 0
        jne short .4
        mov eax, dword [ebx]
        sar eax, 10h
        movsx ecx, cx
        sar eax, 1
        add ecx, eax
.4:
        mov eax, ecx
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
StarBonus_AC:
        movsx eax, word [eax]
        movsx edx, word [edx]
        sub edx, eax
        mov eax, edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PickThreeStars                                  A7380  97 PC, low confidence
; Picks the three stars of the game
;-----------------------------------------------------------------------------
PickThreeStars:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov esi, HomePlayerRecords
        mov ecx, eax
        xor edx, edx
        xor ebx, ebx
        add esi, 0FDh
        jmp short .2
.1:
        mov eax, esi
        add ecx, byte 8
        call StarScore
        mov word [byte ecx-04h], 0
        mov word [byte ecx-02h], 0
        inc ebx
        mov word [byte ecx-08h], ax
        add esi, 125h
        mov word [byte ecx-06h], dx
        inc edx
.2:
        mov eax, dword [ThreeStarsCount]
        sar eax, 10h
        cmp edx, eax
        jl short .1
        mov esi, AwayPlayerRecords
        lea ecx, [nosplit ebx*8+00h]
        xor edx, edx
        add esi, 0FDh
        add ecx, edi
        jmp short .4
.3:
        mov eax, esi
        add ecx, byte 8
        call StarScore
        mov word [byte ecx-04h], 1
        mov word [byte ecx-02h], 0
        inc ebx
        mov word [byte ecx-08h], ax
        add esi, 125h
        mov word [byte ecx-06h], dx
        inc edx
.4:
        mov eax, dword [HomeInjuredCount]
        sar eax, 10h
        cmp edx, eax
        jl short .3
        mov esi, HomeRosterData+1B94h
        lea ecx, [nosplit ebx*8+00h]
        xor edx, edx
        add esi, 0FDh
        add ecx, edi
        jmp short .6
.5:
        mov eax, esi
        add ecx, byte 8
        call StarBonus
        mov word [byte ecx-04h], 0
        mov word [byte ecx-02h], 1
        inc ebx
        mov word [byte ecx-08h], ax
        add esi, 125h
        mov word [byte ecx-06h], dx
        inc edx
.6:
        mov eax, dword [HomeRosterData+1B90h]
        sar eax, 10h
        cmp edx, eax
        jl short .5
        mov esi, AwayRosterData+1B94h
        lea ecx, [nosplit ebx*8+00h]
        xor edx, edx
        add esi, 0FDh
        add ecx, edi
        jmp short .8
.7:
        mov eax, esi
        add ecx, byte 8
        call StarBonus
        mov word [byte ecx-04h], 1
        mov word [byte ecx-02h], 1
        inc ebx
        mov word [byte ecx-08h], ax
        add esi, 125h
        mov word [byte ecx-06h], dx
        inc edx
.8:
        mov eax, dword [AwayRosterData+1B90h]
        sar eax, 10h
        cmp edx, eax
        jl short .7
        mov esi, ebx
        cmp ebx, byte 38h
        jge short .10
        lea edx, [nosplit ebx*8+00h]
        add edx, edi
.9:
        mov word [edx], 0
        mov word [byte edx+02h], 0
        mov word [byte edx+04h], 0
        inc ebx
        mov word [byte edx+06h], 0
        add edx, byte 8
        cmp ebx, byte 38h
        jl short .9
.10:
        mov ecx, StarBonus_AC
        mov ebx, 8
        mov edx, esi
        mov eax, edi
        call qsort_
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawThreeStarStats                              A74F4  97 PC, low confidence
; Post-game: one star's stat lines (goals, assists, shots, +/-, hits, penalty
; minutes; goalie saves and save percentage; three star points)
;-----------------------------------------------------------------------------
DrawThreeStarStats:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 60h
        mov dword [byte esp+058h], eax
        mov eax, dword [nosplit eax*4+ThreeStarsLayers]
        mov ebx, 0Ah
        mov eax, dword [byte eax+02Ch]
        mov edx, 10h
        mov ecx, dword [byte esp+058h]
        mov edi, dword [byte eax+02h]
        xor ebp, ebp
        sar edi, 10h
        mov dword [byte esp+05Ch], edx
        sar edi, 1
        test ecx, ecx
        jne short .1
        mov eax, 95h
        jmp short .3
.1:
        cmp ecx, byte 1
        jne short .2
        mov eax, 96h
        call GetLangText
        push eax
        push ebx
        push edi
        push ecx
        jmp short .4
.2:
        cmp ecx, byte 2
        jne short .5
        mov eax, 97h
.3:
        call GetLangText
        push eax
        push ebx
        push edi
        push byte 1
.4:
        call DrawTextAligned
        add esp, byte 10h
.5:
        mov eax, dword [byte esp+058h]
        shl eax, 3
        mov dx, word [dword eax+ThreeStarsPoints]
        add ebx, byte 14h
        test dx, dx
        jne near .15
        cmp word [dword eax+ThreeStarsTeam], byte 0
        jne short .6
        xor esi, esi
        mov si, word [dword eax+ThreeStarsPlayer]
        imul esi, dword 125h
        add esi, HomePlayerRecords
        jmp short .7
.6:
        mov ax, word [dword eax+ThreeStarsPlayer]
        and eax, 0FFFFh
        imul eax, dword 125h
        mov esi, AwayPlayerRecords
        add esi, eax
.7:
        lea eax, [byte esi+08h]
        push eax
        mov dword [byte esp+058h], eax
        lea eax, [byte esi+018h]
        push eax
        xor eax, eax
        mov al, byte [dword esi+0BCh]
        push eax
        push str_DSS2
        lea eax, [byte esp+010h]
        push eax
        call sprintf_
        add esp, byte 14h
        mov eax, dword [byte esp+058h]
        mov eax, dword [nosplit eax*4+ThreeStarsLayers]
        mov eax, dword [byte eax+02Ch]
        mov eax, dword [byte eax+02h]
        sar eax, 10h
        mov dword [byte esp+050h], eax
        mov eax, esp
        push eax
        call MeasureText
        add esp, byte 4
        mov edx, dword [byte esp+050h]
        sub edx, byte 14h
        cmp eax, edx
        jle short .8
        mov ecx, dword [byte esp+054h]
        xor eax, eax
        push ecx
        mov al, byte [byte esi+018h]
        push eax
        xor eax, eax
        mov al, byte [dword esi+0BCh]
        push eax
        push str_DCS
        lea eax, [byte esp+010h]
        push eax
        call sprintf_
        add esp, byte 14h
.8:
        mov eax, esp
        push eax
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        add ebx, dword [byte esp+05Ch]
        cmp word [dword esi+0FDh], byte 0
        je short .9
        mov eax, dword [dword esi+0FBh]
        sar eax, 10h
        push eax
        mov eax, 98h
        call GetLangText
        push eax
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        mov edx, dword [byte esp+05Ch]
        inc ebp
        add ebx, edx
.9:
        cmp word [dword esi+0FFh], byte 0
        je short .10
        mov eax, dword [dword esi+0FDh]
        sar eax, 10h
        push eax
        mov eax, 99h
        call GetLangText
        push eax
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        mov ecx, dword [byte esp+05Ch]
        inc ebp
        add ebx, ecx
.10:
        cmp word [dword esi+010Bh], byte 5
        jle short .11
        mov eax, dword [dword esi+0109h]
        sar eax, 10h
        push eax
        mov eax, 9Ah
        call GetLangText
        push eax
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        mov eax, dword [byte esp+05Ch]
        inc ebp
        add ebx, eax
.11:
        cmp ebp, byte 3
        jge short .12
        cmp word [dword esi+0103h], byte 0
        jle short .12
        mov eax, dword [dword esi+0101h]
        sar eax, 10h
        push eax
        mov eax, 9Bh
        call GetLangText
        push eax
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        mov edx, dword [byte esp+05Ch]
        inc ebp
        add ebx, edx
.12:
        cmp ebp, byte 3
        jge short .13
        cmp word [dword esi+010Dh], byte 0
        je short .13
        mov eax, dword [dword esi+010Bh]
        sar eax, 10h
        push eax
        mov eax, 9Ch
        call GetLangText
        push eax
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        mov ecx, dword [byte esp+05Ch]
        inc ebp
        add ebx, ecx
.13:
        cmp ebp, byte 3
        jge short .14
        cmp word [dword esi+0101h], byte 3
        jle short .14
        mov eax, dword [dword esi+0FFh]
        sar eax, 10h
        push eax
        mov eax, 9Dh
        call GetLangText
        push eax
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        add ebx, dword [byte esp+05Ch]
.14:
        test byte [GameSettings], 70h
        je near .24
        mov eax, dword [dword esi+0D1h]
        mov edx, dword [dword esi+0D3h]
        sar eax, 10h
        sar edx, 10h
        inc eax
        add edx, eax
        mov eax, dword [dword esi+0D5h]
        jmp near .23
.15:
        cmp word [dword eax+ThreeStarsTeam], byte 0
        jne short .16
        mov ax, word [dword eax+ThreeStarsPlayer]
        and eax, 0FFFFh
        imul eax, dword 125h
        mov esi, HomeRosterData+1B94h
        jmp short .17
.16:
        mov ax, word [dword eax+ThreeStarsPlayer]
        and eax, 0FFFFh
        imul eax, dword 125h
        mov esi, AwayRosterData+1B94h
.17:
        add esi, eax
        lea ebp, [byte esi+08h]
        push ebp
        lea eax, [byte esi+018h]
        push eax
        xor eax, eax
        mov al, byte [dword esi+0BCh]
        push eax
        push str_DSS2
        lea eax, [byte esp+010h]
        push eax
        call sprintf_
        add esp, byte 14h
        mov eax, dword [byte esp+058h]
        mov eax, dword [nosplit eax*4+ThreeStarsLayers]
        mov eax, dword [byte eax+02Ch]
        mov eax, dword [byte eax+02h]
        sar eax, 10h
        mov dword [byte esp+050h], eax
        mov eax, esp
        push eax
        call MeasureText
        add esp, byte 4
        mov edx, dword [byte esp+050h]
        sub edx, byte 14h
        cmp eax, edx
        jle short .18
        xor eax, eax
        push ebp
        mov al, byte [byte esi+018h]
        push eax
        xor eax, eax
        mov al, byte [dword esi+0BCh]
        push eax
        push str_DCS
        lea eax, [byte esp+010h]
        push eax
        call sprintf_
        add esp, byte 14h
.18:
        mov eax, esp
        push eax
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        mov edx, dword [byte esp+05Ch]
        mov ax, word [dword esi+0105h]
        add ebx, edx
        test ax, ax
        jne short .19
        mov eax, 9Fh
        call GetLangText
        push eax
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
        add ebx, dword [byte esp+05Ch]
.19:
        mov edx, dword [dword esi+0FDh]
        mov eax, dword [dword esi+0103h]
        sar edx, 10h
        sar eax, 10h
        sub edx, eax
        push edx
        mov eax, 0A0h
        call GetLangText
        push eax
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
        mov ebp, dword [byte esp+05Ch]
        mov dx, word [dword esi+0FFh]
        add ebx, ebp
        test dx, dx
        je short .20
        mov ecx, dword [dword esi+0FDh]
        mov eax, dword [dword esi+0103h]
        sar ecx, 10h
        sar eax, 10h
        mov edx, ecx
        sub edx, eax
        lea ebp, [nosplit edx*4+00h]
        sub ebp, edx
        shl ebp, 3
        add ebp, edx
        shl ebp, 2
        mov edx, ebp
        mov eax, ebp
        sar edx, 1Fh
        idiv ecx
        mov ebp, eax
        jmp short .21
.20:
        mov ebp, 64h
.21:
        cmp ebp, byte 64h
        jge short .22
        mov ecx, 0Ah
        mov edx, ebp
        mov eax, ebp
        sar edx, 1Fh
        idiv ecx
        push edx
        mov edx, ebp
        mov eax, ebp
        sar edx, 1Fh
        idiv ecx
        push eax
        mov eax, 0A2h
        call GetLangText
        push eax
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 18h
.22:
        add ebx, dword [byte esp+05Ch]
        test byte [GameSettings], 70h
        je short .24
        mov eax, dword [dword esi+0DDh]
        mov edx, dword [dword esi+0DFh]
        sar eax, 10h
        sar edx, 10h
        inc eax
        add edx, eax
        mov eax, dword [dword esi+0E1h]
.23:
        sar eax, 10h
        add edx, eax
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        push eax
        mov eax, 9Eh
        call GetLangText
        push eax
        push ebx
        push edi
        push byte 1
        call DrawTextAligned
        add esp, byte 14h
.24:
        add esp, byte 60h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
DrawThreeStarStats_4A8:
        call ThreeStarsSound
        cmp dword [ThreeStarsPos], byte 0
        je near .25
        call ThreeStarsFlash
        nop
.25:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov eax, dword [ThreeStarsTimer]
        mov edx, dword [dword eax+019Eh]
        xor ebx, ebx
        test edx, edx
        je near ThreeStarsFlash_E4
        cmp dword [ThreeStarsChoice], byte 0
        je near ThreeStarsFlash_14E
        mov dword [ThreeStarsChoice], ebx
        mov ebx, 1
        jmp near ThreeStarsFlash_14E
        db 090h
;-----------------------------------------------------------------------------
; ThreeStarsSound                                 A79EC  97 PC, low confidence
; Plays a three stars sound
;-----------------------------------------------------------------------------
ThreeStarsSound:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov eax, dword [tickcount]
        mov ebx, eax
        mov eax, dword [ThreeStarsTimer]
        cmp dword [dword eax+0FAh], byte 1
        jne near .4
        cmp word [ThreeStarsSoundOn], byte 0
        jne short .1
        mov eax, 309h
        mov esi, 3
        call PlaySfx
        mov word [ThreeStarsSoundOn], si
.1:
        mov ecx, dword [GameStatsSpeechCount]
        lea eax, [byte ebx+04h]
        cmp eax, ecx
        jge short .2
        lea eax, [byte ebx-01h]
        mov dword [GameStatsSpeechCount], eax
.2:
        cmp ebx, dword [GameStatsSpeechCount]
        jle near .5
        call Random32
        mov ecx, 3
        xor edx, edx
        div ecx
        cmp edx, dword [PostGameLastSpeech]
        jl short .3
        inc edx
.3:
        mov dword [PostGameLastSpeech], edx
        lea eax, [nosplit edx*4+00h]
        mov edx, dword [ThreeStarsTimer]
        mov eax, dword [dword eax+GoldStarShapes]
        mov dword [dword edx+0114h], eax
        mov eax, dword [ThreeStarsTimer]
        mov ebp, dword [dword eax+0120h]
        push ebp
        mov edx, dword [dword eax+011Ch]
        push edx
        mov ecx, dword [dword eax+0114h]
        push ecx
        add ebx, byte 4
        call BlitArt
        add esp, byte 0Ch
        mov dword [GameStatsSpeechCount], ebx
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        cmp word [ThreeStarsSoundOn], byte 3
        jne short .5
        xor ebx, ebx
        call StopAllSfx
        mov word [ThreeStarsSoundOn], bx
.5:
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ThreeStarsFlash                                 A7AD0  97 PC, low confidence
; Flashes the three stars
;-----------------------------------------------------------------------------
ThreeStarsFlash:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov eax, dword [tickcount]
        mov ebx, eax
        mov eax, dword [ThreeStarsTimer]
        cmp dword [dword eax+014Ch], byte 1
        jne near .4
        cmp word [ThreeStarsSoundOn], byte 0
        jne short .1
        mov eax, 309h
        mov esi, 4
        call PlaySfx
        mov word [ThreeStarsSoundOn], si
.1:
        mov ecx, dword [ThreeStarsSpeechCount]
        lea eax, [byte ebx+04h]
        cmp eax, ecx
        jge short .2
        lea eax, [byte ebx-01h]
        mov dword [ThreeStarsSpeechCount], eax
.2:
        cmp ebx, dword [ThreeStarsSpeechCount]
        jle near .5
        call Random32
        mov ecx, 3
        xor edx, edx
        div ecx
        cmp edx, dword [PostGameLastSpeech]
        jl short .3
        inc edx
.3:
        mov dword [PostGameLastSpeech], edx
        lea eax, [nosplit edx*4+00h]
        mov edx, dword [ThreeStarsTimer]
        mov eax, dword [dword eax+StarFrameShapes]
        mov dword [dword edx+0166h], eax
        mov eax, dword [ThreeStarsTimer]
        mov ebp, dword [dword eax+0172h]
        push ebp
        mov edx, dword [dword eax+016Eh]
        push edx
        mov ecx, dword [dword eax+0166h]
        push ecx
        add ebx, byte 4
        call BlitArt
        add esp, byte 0Ch
        mov dword [ThreeStarsSpeechCount], ebx
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        cmp word [ThreeStarsSoundOn], byte 4
        jne short .5
        xor ebx, ebx
        call StopAllSfx
        mov word [ThreeStarsSoundOn], bx
.5:
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
ThreeStarsFlash_E4:
        cmp dword [dword eax+01F0h], byte 0
        je short .6
        cmp dword [ThreeStarsChoice], byte 1
        je short ThreeStarsFlash_14E
        mov ebp, 1
        mov ebx, ebp
        mov dword [ThreeStarsChoice], ebp
        jmp short ThreeStarsFlash_14E
.6:
        cmp dword [dword eax+0242h], byte 0
        je short .7
        cmp dword [ThreeStarsChoice], byte 2
        je short ThreeStarsFlash_14E
        mov esi, 2
        mov ebx, 1
        mov dword [ThreeStarsChoice], esi
        jmp short ThreeStarsFlash_14E
.7:
        cmp dword [ThreeStarsChoice], byte 0
        jl short ThreeStarsFlash_14E
        mov ebp, 0FFFFFFFFh
        mov eax, dword [PostGameLayer]
        mov dword [ThreeStarsChoice], ebp
        mov edx, dword [byte eax+02Ch]
        push edx
        call BlitShape
        add esp, byte 4
ThreeStarsFlash_14E:
        test ebx, ebx
        je short .8
        mov eax, dword [ThreeStarsChoice]
        mov eax, dword [nosplit eax*4+ThreeStarsLayers]
        mov ebx, dword [byte eax+02Ch]
        push ebx
        call BlitShape
        add esp, byte 4
.8:
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadThreeStarsArt                               A7C40  97 PC, low confidence
; Loads the three stars art
;-----------------------------------------------------------------------------
LoadThreeStarsArt:
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ebp, eax
        mov esi, edx
        mov edi, ecx
        mov eax, ebx
        xor ebx, ebx
.1:
        inc ebx
        mov dl, byte [eax]
        inc eax
        mov byte [byte esp+ebx-01h], dl
        cmp ebx, byte 4
        jl short .1
        xor ah, ah
        mov byte [esp+ebx], ah
        xor ebx, ebx
        test edi, edi
        jle short .3
.2:
        mov eax, esp
        push eax
        push ebp
        call FindShape
        add esp, byte 8
        mov dword [esi], eax
        mov dl, byte [byte esp+03h]
        add esi, byte 4
        inc dl
        inc ebx
        mov byte [byte esp+03h], dl
        cmp ebx, edi
        jl short .2
.3:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret
        db 090h
;-----------------------------------------------------------------------------
; ClearThreeStars                                 A7C90  97 PC, low confidence
; Clears the three stars
;-----------------------------------------------------------------------------
ClearThreeStars:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebx, 0FFFFFFFFh
        xor edx, edx
        xor ah, ah
        mov word [GameLogCount], dx
        mov word [PenaltyLogCount], bx
        mov word [ScoringLogCount], bx
        mov byte [PeriodHomeTeam], ah
        xor edx, edx
        mov byte [PeriodAwayTeam], ah
        mov dword [esp], edx
.1:
        cmp dword [esp], byte 0
        jne short .2
        mov ebp, AutoLineData
        jmp short .3
.2:
        mov ebp, homelines
.3:
        mov ebx, 36h
        lea eax, [dword ebp+020B7h]
        xor edx, edx
        call memset_
        lea ecx, [dword ebp+01A0h]
        xor edi, edi
        mov esi, ebp
        jmp short .5
.4:
        mov ebx, 12h
        mov eax, ecx
        xor edx, edx
        mov byte [dword esi+01C7h], 0
        call memset_
        add esi, 125h
        inc edi
        add ecx, 125h
.5:
        mov eax, dword [dword ebp+09Fh]
        sar eax, 10h
        cmp edi, eax
        jl short .4
        lea ecx, [dword ebp+01E3Fh]
        xor edi, edi
        mov esi, ebp
        jmp short .7
.6:
        mov ebx, 0Dh
        mov eax, ecx
        xor edx, edx
        mov byte [dword esi+01E66h], 0
        call memset_
        add esi, 125h
        inc edi
        add ecx, 125h
.7:
        mov eax, dword [dword ebp+01D3Eh]
        sar eax, 10h
        cmp edi, eax
        jl short .6
        mov ecx, dword [esp]
        inc ecx
        mov dword [esp], ecx
        cmp ecx, byte 2
        jl near .1
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
