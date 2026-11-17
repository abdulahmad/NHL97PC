; Game loop: updating players, game over, intermission, periodic events and crowd ambience.
bits 32
%include "hockey.inc"
section s_77A88 progbits alloc exec nowrite align=1
extern __CHP, AddAnimClock, AddPenalty2, AngleOfVector, asstab, assinsert, assreplace, AwActiveCount
extern AwayGoalieOff, AwLineCount, AwSkaterCount, awtmstruct, bholdtimer, ChkGoalies, chkprogress, ChkPuckContacts
extern ChkTiredPlayer, ClearOverlayWindows, CommentaryEvent, CupCelebrationActive, doinput, F64_0p001, gameclock, gameopts
extern gameover, gmode, GoalieTick, GoalLineFlag, gsp, HmActiveCount, HmLineCount, HmScore
extern HmSkaterCount, hmtmstruct, holdreset, HomeControlSlot, HomeGoalieOff, HomeTeamRecord, InCrease, InGameMenuRequest
extern Intermission, IsPlayoffGame, LastTouchPlayer, LoadCupAnims, LogPeriodEnd, MovePlayer, OpenResourceArchive, PassPending
extern PenBuf, PenCntDwn, Period, PlayerControlFlags, PlayerUpdateFlags, PlayerUpdateTable, gmode2, PlayoffColumns
extern PlayoffCurrentRound, PlayoffFinalRound, PlayoffRound, PlayoffRoundBits, PlaySfxAt, PlaySfxOr, PtrPuckFlags, PtrPuckObject
extern PtrPuckOwner, PtrPuckTarget, puckc, PuckOwnerTeam, rand_, randomd0, ReadJoy1, RefPlayer
extern regd1, ReplayPlaying, RestartGameMusic, RestoreBenchEnergy, SelectCameraView, SetArtArchive, SetCrowdMood, setplayer
extern SetPlayerTarget, SetTeamColours, SetZoneFlags, ShotChanceCommentary, SimFrames, SlotAssign, SlotPlayers, SortCords
extern SortPlayersByDepth, StartCameraPath, StartCrowdMusic, StartFaceoffLineChange, StartMusicTrack, StatsPanelOn, str_ANIMSVIV2, TeamLineSlots
extern TriggerCameraFlashes, UpdateCreaseFlag, UpdatePlayerMotion, UpdatePuck, UpdatePuckCarrier, vecdist, ZoneTargetX, ZoneTargetY
global updateplayers, GameOver, RequestPauseMenu, CheckIntermission, CupCelebration, clockcont_0, periodicevents, PlayCrowdAmbience
global DoGameFrame, SimGameBlankPair, RandomCrowdDelay
;-----------------------------------------------------------------------------
; updateplayers                                  77A88  94G, medium confidence
; The per-frame player update: reads the joypads (ReadJoy1), runs each object's assignment from
; asstab, collisions and animation
;-----------------------------------------------------------------------------
updateplayers:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov eax, 12Ch
        call AddAnimClock
        call SortPlayersByDepth
        call ShotChanceCommentary
        mov eax, dword [PtrPuckObject]
        mov edx, dword [dword eax+0AEh]
        sar edx, 18h
        mov esi, dword [dword edx+eax+0AFh]
        mov ah, byte [gmode]
        sar esi, 18h
        test ah, 1
        je short .1
        test byte [gmode2], 1
        jne short .1
        cmp word [PenCntDwn], byte 0
        jge short .1
        cmp byte [PenBuf], 0
        jne short .1
        cmp esi, byte 36h
        je short .1
        cmp esi, byte 37h
        je short .1
        mov eax, 1
        jmp short .2
.1:
        xor eax, eax
.2:
        mov ebx, 0FFFFFFFFh
        mov edx, 0FFFFh
        mov dword [bholdtimer], eax
        xor esi, esi
        mov word [HmActiveCount], bx
        mov dword [HmSkaterCount], edx
        mov word [HmLineCount], bx
        mov word [AwActiveCount], bx
        mov dword [AwSkaterCount], edx
        mov word [AwLineCount], bx
        mov ebx, SortCords
.3:
        mov edx, dword [byte ebx+04h]
        mov eax, dword [PtrPuckTarget]
        sar edx, 10h
        movsx eax, word [eax]
        sub eax, edx
        mov ebp, dword [byte ebx+0Ch]
        mov dword [esp], eax
        mov eax, dword [PtrPuckOwner]
        sar ebp, 10h
        movsx eax, word [eax]
        sub eax, ebp
        push eax
        mov ecx, dword [byte esp+04h]
        push ecx
        mov edi, dword [dword ebx+0FEh]
        mov ebp, eax
        call vecdist
        add esp, byte 8
        push ebp
        sar ebp, 2
        imul ebp, ebp
        mov dword [dword ebx+0E2h], eax
        mov eax, dword [byte esp+04h]
        push eax
        call AngleOfVector
        add esp, byte 8
        mov edx, dword [esp]
        sar edx, 2
        mov dword [dword ebx+0EAh], eax
        mov eax, edx
        imul eax, edx
        add eax, ebp
        mov dword [dword ebx+0E6h], eax
        mov ax, word [dword ebx+0A9h]
        mov dword [esp], edx
        test ax, ax
        jne near .7
        mov word [dword edi+0FCh], si
        mov ah, byte [dword ebx+0BFh]
        xor edx, edx
        test ah, 80h
        setne dl
        mov eax, ebx
        call InCrease
        mov byte [dword ebx+0A5h], al
        test byte [holdreset], 40h
        je near .15
        cmp word [gameclock], byte 0
        jne short .4
        cmp word [StatsPanelOn], byte 0
        je short .5
.4:
        mov eax, 1
        jmp short .6
.5:
        xor eax, eax
.6:
        test eax, eax
        je near .15
        cmp dword [ReplayPlaying], byte 0
        jne near .15
        cmp word [byte edi+010h], byte 0
        jl near .15
        mov eax, dword [dword ebx+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        mov edx, dword [dword edi+0108h]
        inc word [dword edx+eax+01E3Fh]
        jmp near .15
.7:
        test byte [dword ebx+0C0h], 4
        jne short .10
        test byte [dword ebx+0BFh], 20h
        jne short .10
        mov ebp, dword [dword edi+0FEh]
        mov eax, dword [dword ebx+0E6h]
        cmp eax, ebp
        jge short .8
        mov dword [dword edi+0FEh], eax
        mov word [dword edi+0102h], si
.8:
        cmp dword [dword ebx+0E2h], 1E0h
        jge short .9
        mov eax, dword [dword ebx+0EEh]
        or byte [byte eax+029h], 2
        jmp short .10
.9:
        mov eax, dword [dword ebx+0EEh]
        and byte [byte eax+029h], 0FDh
.10:
        cmp word [dword ebx+0A9h], byte 0
        jle short .11
        test byte [dword ebx+0C0h], 1
        jne short .11
        mov eax, ebx
        call UpdateCreaseFlag
.11:
        test byte [holdreset], 40h
        je short .15
        cmp word [gameclock], byte 0
        jne short .12
        cmp word [StatsPanelOn], byte 0
        je short .13
.12:
        mov eax, 1
        jmp short .14
.13:
        xor eax, eax
.14:
        test eax, eax
        je short .15
        cmp dword [ReplayPlaying], byte 0
        jne short .15
        cmp word [dword ebx+0A9h], byte 0
        jle short .15
        mov eax, dword [dword ebx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        mov edx, dword [dword edi+0108h]
        inc word [dword edx+eax+01A8h]
.15:
        inc esi
        add ebx, 108h
        cmp esi, byte 0Ch
        jl near .3
        mov eax, SortCords
        xor esi, esi
.16:
        mov edx, dword [dword eax+0FAh]
        mov bl, byte [byte edx+030h]
        inc esi
        and bl, 0DFh
        add eax, 108h
        mov byte [byte edx+030h], bl
        cmp esi, byte 0Dh
        jl short .16
        mov ebx, SortCords
        xor esi, esi
.17:
        fld dword [byte ebx+020h]
        fld dword [byte ebx+024h]
        fld dword [byte ebx+028h]
        fld dword [byte ebx+01Ch]
        mov ax, word [dword ebx+0A9h]
        fxch st2
        fstp dword [dword ebx+0D6h]
        fstp dword [dword ebx+0DAh]
        fstp dword [dword ebx+0DEh]
        fstp dword [dword ebx+0D2h]
        test ax, ax
        jge short .18
        cmp byte [dword ebx+0A4h], 0Ch
        jne near .31
.18:
        mov edi, dword [byte ebx+064h]
        dec edi
        mov dword [byte ebx+064h], edi
        test edi, edi
        jge short .19
        mov dword [byte ebx+064h], 0
.19:
        mov cx, word [byte ebx+05Eh]
        dec ecx
        mov word [byte ebx+05Eh], cx
        test cx, cx
        jge short .20
        mov word [byte ebx+05Eh], 0
.20:
        cmp word [dword ebx+0A9h], byte 0
        jle short .21
        mov eax, ebx
        call SetZoneFlags
.21:
        mov eax, dword [dword ebx+0EEh]
        and byte [byte eax+029h], 0FEh
        cmp word [dword ebx+0BAh], byte 0
        jl short .22
        mov eax, dword [dword ebx+0B8h]
        sar eax, 10h
        call ReadJoy1
        mov edx, dword [dword ebx+0B8h]
        mov eax, ebx
        sar edx, 10h
        call doinput
.22:
        cmp esi, byte 0Dh
        jne near .27
        mov eax, dword [puckc]
        mov cl, byte [eax]
        cmp cl, 0Ch
        jne short .23
        mov eax, dword [PtrPuckObject]
        fld dword [byte eax+020h]
        call __CHP
        fistp dword [byte esp+04h]
        mov eax, dword [byte esp+04h]
        mov edi, dword [PtrPuckFlags]
        mov word [byte edi+06h], ax
        mov dword [byte esp+08h], eax
        mov eax, dword [PtrPuckFlags]
        fild word [byte esp+08h]
        fstp dword [byte eax+020h]
        mov eax, dword [PtrPuckObject]
        fld dword [byte eax+028h]
        call __CHP
        fistp dword [byte esp+04h]
        mov eax, dword [byte esp+04h]
        mov edx, dword [PtrPuckFlags]
        mov word [byte edx+0Eh], ax
        mov dword [byte esp+08h], eax
        mov eax, dword [PtrPuckFlags]
        fild word [byte esp+08h]
        fstp dword [byte eax+028h]
        mov eax, dword [PtrPuckObject]
        mov edx, dword [PtrPuckFlags]
        mov ax, word [byte eax+0Eh]
        mov word [byte edx+054h], ax
        jmp short .25
.23:
        test cl, cl
        jge short .24
        mov eax, dword [PtrPuckFlags]
        call MovePlayer
        jmp short .25
.24:
        call UpdatePuckCarrier
        mov eax, dword [puckc]
        movsx eax, byte [eax]
        imul eax, dword 108h
        mov edx, dword [PtrPuckFlags]
        mov ecx, dword [dword eax+PlayerUpdateFlags]
        mov dword [byte edx+038h], ecx
        mov eax, dword [puckc]
        movsx eax, byte [eax]
        imul edx, eax, dword 108h
        mov eax, dword [PtrPuckFlags]
        mov ecx, dword [dword edx+PlayerUpdateTable]
        mov dword [byte eax+040h], ecx
.25:
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [dword eax+0AEh]
        sar edx, 18h
        cmp byte [dword edx+eax+0B2h], 41h
        jne short .26
        call ChkPuckContacts
.26:
        call UpdatePuck
        jmp short .30
.27:
        jge short .28
        mov eax, ebx
        call GoalieTick
        jmp short .30
.28:
        test byte [gmode], 1
        je short .30
        cmp esi, byte 0Fh
        je short .29
        cmp esi, byte 0Eh
        jne short .30
.29:
        mov eax, ebx
        call UpdatePlayerMotion
.30:
        mov eax, ebx
        call ChkTiredPlayer
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov al, byte [dword ebx+eax+0B2h]
        test al, al
        je short .34
        and eax, 0FFh
        lea edx, [nosplit eax*4+00h]
        mov eax, ebx
        call dword [dword edx+asstab]
        jmp short .34
.31:
        test byte [gmode], 1
        je short .33
        cmp esi, byte 0Fh
        je short .32
        cmp esi, byte 0Eh
        jne short .33
.32:
        mov eax, ebx
        call UpdatePlayerMotion
        jmp short .34
.33:
        cmp esi, byte 0Ch
        jge short .34
        cmp word [dword ebx+0A9h], byte 0
        jge short .34
        mov eax, ebx
        call GoalieTick
.34:
        inc esi
        add ebx, 108h
        cmp esi, byte 10h
        jl near .17
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; GameOver                       77F88  93G hockey93_06.asm, medium confidence
; Sets gameover (gameover); no check for a game that is already over
;-----------------------------------------------------------------------------
GameOver:
        mov word [gameover], 1
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; RequestPauseMenu                                77F94  97 PC, low confidence
; Asks for the in-game pause menu
;-----------------------------------------------------------------------------
RequestPauseMenu:
        mov word [SimFrames], 1
        mov dword [InGameMenuRequest], 3
        ret
;-----------------------------------------------------------------------------
; CheckIntermission                               77FA8  97 PC, low confidence
; Runs the intermission when it is due
;-----------------------------------------------------------------------------
CheckIntermission:
        push ebx
        push edx
        mov eax, dword [Period]
        sar eax, 10h
        cmp eax, byte 0FFFFFFFFh
        je near .3
        mov dx, word [gsp]
        mov bx, word [Period]
        mov ah, byte [gmode]
        inc edx
        inc ebx
        xor ah, 2
        mov word [gsp], dx
        mov word [Period], bx
        mov byte [gmode], ah
        cmp dx, byte 2
        jle short .3
        cmp dx, byte 3
        jle short .1
        mov word [gsp], 3
        call IsPlayoffGame
        test eax, eax
        jne short .2
        mov word [gsp], 4
        jmp short .2
.1:
        call IsPlayoffGame
        test eax, eax
        jne short .2
        xor byte [gmode], 2
.2:
        mov dx, word [awtmstruct]
        cmp dx, word [hmtmstruct]
        je short .3
        mov word [gsp], 4
.3:
        call Intermission
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CupCelebration                                  78044  97 PC, low confidence
; Runs the championship celebration
;-----------------------------------------------------------------------------
CupCelebration:
        push ebx
        push ecx
        push edx
        mov edx, eax
        cmp dword [CupCelebrationActive], byte 0
        je short .1
        cwde
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        call IsPlayoffGame
        test eax, eax
        je near .3
        cmp byte [PlayoffRound], 3
        jne near .3
        mov eax, dword [PlayoffRoundBits]
        and eax, byte 7
        mov ecx, dword [PlayoffCurrentRound]
        shr eax, 1
        cmp eax, ecx
        jne short .2
        movsx ebx, dx
        mov eax, ebx
        shl eax, 4
        add eax, ebx
        shl eax, 2
        sub eax, ebx
        mov eax, dword [nosplit eax*4+HmScore]
        mov eax, dword [byte eax+064h]
        sar eax, 10h
        cmp dword [nosplit eax*4+PlayoffColumns], byte 3
        jne short .3
        mov eax, ebx
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        cmp eax, dword [PlayoffFinalRound]
        jne short .3
        movsx ebx, dx
        mov eax, ebx
        shl eax, 4
        add eax, ebx
        shl eax, 2
        sub eax, ebx
        mov eax, dword [nosplit eax*4+HmScore]
        mov eax, dword [byte eax+064h]
        sar eax, 10h
        cmp dword [nosplit eax*4+PlayoffColumns], byte 0Ch
        jne short .3
        mov eax, ebx
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov eax, 0FFFFFFFFh
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; clockcont_0                                    780F0  94G, medium confidence
; (end of period; also entered from puckfaceoff): puck assinsert 41h, periods 1-2
; AddPenalty2 end of period (PA event), later periods score / overtime / cup checks
;-----------------------------------------------------------------------------
clockcont_0:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edx, 41h
        mov eax, dword [PtrPuckFlags]
        call assinsert
        mov dx, word [gsp]
        cmp dx, byte 2
        jge short .2
        cmp dword [ReplayPlaying], byte 0
        jne short .1
        mov eax, dword [PuckOwnerTeam]
        mov edx, 1
        sar eax, 10h
        call LogPeriodEnd
.1:
        mov edx, 1
        mov eax, dword [PtrPuckFlags]
        xor ebx, ebx
        call AddPenalty2
        mov eax, dword [PuckOwnerTeam]
        sar eax, 10h
        inc eax
        push eax
        push dword 0A000002Ah
        call CommentaryEvent
        add esp, byte 8
        jmp near .36
.2:
        mov bx, word [awtmstruct]
        mov di, word [hmtmstruct]
        sub di, bx
        jne near .7
        cmp dx, byte 3
        jne near .5
        call IsPlayoffGame
        test eax, eax
        jne near .5
        mov eax, dword [puckc]
        mov ebx, 0FFFFFFFFh
        mov byte [eax], 0FFh
        xor eax, eax
.3:
        movsx edx, ax
        inc eax
        mov word [nosplit edx*2+SlotAssign], bx
        cmp ax, 8
        jl short .3
        xor ebx, ebx
        mov ecx, 0FFFFFFFFh
.4:
        movsx eax, bx
        imul eax, dword 108h
        mov edx, ecx
        add eax, SortCords
        inc ebx
        call SetPlayerTarget
        cmp bx, byte 0Ch
        jl short .4
        mov ah, byte [gmode]
        mov edx, 2
        or ah, 40h
        xor ebx, ebx
        mov byte [gmode], ah
        mov eax, dword [PtrPuckFlags]
        mov ecx, 1000h
        call AddPenalty2
        push ecx
        push dword 0C001h
        push dword 0A000001Fh
        mov dword [LastTouchPlayer], ecx
        call CommentaryEvent
        add esp, byte 0Ch
        jmp short .6
.5:
        mov edx, 1
        mov eax, dword [PtrPuckFlags]
        xor ebx, ebx
        call AddPenalty2
        mov eax, dword [PuckOwnerTeam]
        sar eax, 10h
        inc eax
        push eax
        push dword 0A000002Ah
        call CommentaryEvent
        add esp, byte 8
.6:
        cmp dword [ReplayPlaying], byte 0
        jne near .36
        mov eax, dword [PuckOwnerTeam]
        mov edx, 1
        sar eax, 10h
        call LogPeriodEnd
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        mov edx, 40h
        mov eax, dword [PtrPuckFlags]
        call assreplace
        mov edx, 3E8h
        mov eax, dword [puckc]
        mov dword [RefPlayer], edx
        mov esi, 0FFFFFFFFh
        mov byte [eax], 0FFh
        xor eax, eax
.8:
        movsx edx, ax
        inc eax
        mov word [nosplit edx*2+SlotAssign], si
        cmp ax, 8
        jl short .8
        xor ebx, ebx
        mov ecx, 0FFFFFFFFh
.9:
        movsx eax, bx
        imul eax, dword 108h
        mov edx, ecx
        add eax, SortCords
        inc ebx
        call SetPlayerTarget
        cmp bx, byte 0Ch
        jl short .9
        test di, di
        jge short .10
        mov ecx, HomeTeamRecord+420h
        jmp short .11
.10:
        mov ecx, SortCords
.11:
        mov eax, 0FFFFFFFFh
        xor edx, edx
        xor esi, esi
        mov word [PassPending], ax
        mov word [regd1], dx
        mov ebp, 18h
.12:
        cmp word [dword ecx+0A9h], byte 0
        jl short .13
        mov edx, ebp
        mov eax, ecx
        call assinsert
        jmp near .17
.13:
        mov eax, dword [dword ecx+0A7h]
        sar eax, 10h
        cmp eax, byte 0FFFFFFFFh
        jne near .17
        mov ebx, dword [dword ecx+0FEh]
        movsx ax, byte [dword ebx+088h]
        mov word [ZoneTargetY], ax
        test ax, ax
        jl near .17
        cmp word [regd1], byte 0
        je short .14
        mov eax, 3
        jmp short .15
.14:
        mov eax, 5
.15:
        mov word [dword ecx+0A9h], ax
        mov dx, word [regd1]
        inc edx
        mov eax, ecx
        mov word [regd1], dx
        mov edx, ebp
        call assinsert
        mov edx, dword [ZoneTargetX]
        mov eax, ecx
        sar edx, 10h
        call setplayer
        mov word [ZoneTargetY], 1
.16:
        mov eax, dword [ZoneTargetX]
        sar eax, 10h
        mov dl, byte [dword ebx+eax+088h]
        mov byte [dword ebx+eax+087h], dl
        test dl, dl
        jl short .17
        inc word [ZoneTargetY]
        jmp short .16
.17:
        inc esi
        add ecx, 108h
        cmp si, byte 6
        jl near .12
        test di, di
        jge short .18
        mov ecx, SortCords
        jmp short .19
.18:
        mov ecx, HomeTeamRecord+420h
.19:
        xor esi, esi
        mov ebp, 15h
        mov word [regd1], si
.20:
        cmp word [dword ecx+0A9h], byte 0
        jl short .21
        mov edx, ebp
        mov eax, ecx
        call assinsert
        jmp near .25
.21:
        mov eax, dword [dword ecx+0A7h]
        sar eax, 10h
        cmp eax, byte 0FFFFFFFFh
        jne near .25
        mov ebx, dword [dword ecx+0FEh]
        movsx ax, byte [dword ebx+088h]
        mov word [ZoneTargetY], ax
        test ax, ax
        jl short .25
        cmp word [regd1], byte 0
        je short .22
        mov eax, 3
        jmp short .23
.22:
        mov eax, 5
.23:
        mov word [dword ecx+0A9h], ax
        mov ax, word [regd1]
        inc eax
        mov edx, ebp
        mov word [regd1], ax
        mov eax, ecx
        call assinsert
        mov edx, dword [ZoneTargetX]
        mov eax, ecx
        sar edx, 10h
        call setplayer
        mov word [ZoneTargetY], 1
.24:
        mov eax, dword [ZoneTargetX]
        sar eax, 10h
        mov dl, byte [dword ebx+eax+088h]
        mov byte [dword ebx+eax+087h], dl
        test dl, dl
        jl short .25
        inc word [ZoneTargetY]
        jmp short .24
.25:
        inc esi
        add ecx, 108h
        cmp si, byte 6
        jl near .20
        test di, di
        setl al
        xor ah, ah
        cwde
        call CupCelebration
        test eax, eax
        jl short .26
        mov eax, str_ANIMSVIV2
        call SetArtArchive
        call LoadCupAnims
        push byte 0
        call OpenResourceArchive
        add esp, byte 4
        mov eax, 0CCCCh
        mov edx, 44h
        call TriggerCameraFlashes
        mov eax, dword [PtrPuckFlags]
        call assreplace
        mov eax, 5Ch
        call StartMusicTrack
        mov eax, 0Bh
        mov ecx, 0FFFFFFFEh
        call SetCrowdMood
        mov word [PassPending], cx
        jmp short .29
.26:
        mov bx, word [awtmstruct]
        cmp bx, word [hmtmstruct]
        jge short .27
        mov eax, 0Ah
        jmp short .28
.27:
        mov eax, 2
        call randomd0
        test ax, ax
        sete al
        and eax, 0FFh
.28:
        call SetCrowdMood
.29:
        mov edx, 64h
        mov eax, 4
        call SelectCameraView
        mov edx, 64h
        test di, di
        jge short .30
        mov eax, 6
        jmp short .31
.30:
        xor eax, eax
.31:
        add eax, byte 4
        call StartCameraPath
        mov dl, byte [gmode]
        xor ebx, ebx
        or dl, 40h
        mov eax, dword [PtrPuckFlags]
        mov byte [gmode], dl
        mov edx, 2
        call AddPenalty2
        cmp dword [ReplayPlaying], byte 0
        jne short .32
        mov eax, dword [PuckOwnerTeam]
        mov edx, 1
        sar eax, 10h
        call LogPeriodEnd
.32:
        cmp word [gsp], byte 3
        jne short .34
        cmp word [gameclock], byte 0
        jne short .33
        cmp word [StatsPanelOn], byte 0
        je short .34
.33:
        mov eax, 1001h
        push eax
        push dword 0C002h
        push dword 0A000001Fh
        mov dword [LastTouchPlayer], eax
        jmp short .35
.34:
        mov ebp, 1001h
        push ebp
        push dword 0C001h
        push dword 0A000001Fh
        mov dword [LastTouchPlayer], ebp
.35:
        call CommentaryEvent
        add esp, byte 0Ch
.36:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; periodicevents                                    785E8  94G, low confidence
; From DoGameFrame before updateplayers: chkprogress, line changes
; (StartFaceoffLineChange), the Stanley Cup start (clockcont_0)
;-----------------------------------------------------------------------------
periodicevents:
        push edx
        call chkprogress
        test byte [gmode], 1
        jne short .1
        cmp word [gameclock], byte 0
        jne short .1
        cmp word [StatsPanelOn], byte 0
        jne short .1
        call RestartGameMusic
        mov eax, 103h
        call StartCrowdMusic
        call ClearOverlayWindows
        call clockcont_0
.1:
        cmp word [GoalLineFlag], byte 0
        jne near .4
        test byte [holdreset], 40h
        je near .4
        call ChkGoalies
        mov eax, dword [gameopts]
        test byte [byte eax+01h], 0C0h
        je near .4
        call RestoreBenchEnergy
        mov eax, dword [gameopts]
        mov eax, dword [byte eax+01h]
        and eax, 0C0h
        cmp eax, byte 40h
        jne near .4
        cmp word [gameclock], byte 0
        jne short .2
        cmp word [StatsPanelOn], byte 0
        je near .4
.2:
        mov edx, dword [hmtmstruct]
        xor eax, eax
        sar edx, 10h
        call TeamLineSlots
        cmp ax, 900h
        jge short .3
        cmp word [HomeGoalieOff], byte 0
        jle short .3
        mov eax, dword [AwayGoalieOff]
        sar eax, 10h
        add eax, eax
        cmp word [dword eax+SlotAssign], byte 0
        jl short .3
        mov edx, dword [dword eax+SlotPlayers]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        call StartFaceoffLineChange
.3:
        mov edx, dword [awtmstruct]
        mov eax, 1
        sar edx, 10h
        call TeamLineSlots
        cmp ax, 900h
        jge short .4
        cmp word [AwayGoalieOff], byte 0
        jle short .4
        mov eax, dword [HomeControlSlot]
        sar eax, 10h
        add eax, eax
        cmp word [dword eax+SlotAssign], byte 0
        jl short .4
        mov edx, dword [dword eax+SlotPlayers]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        call StartFaceoffLineChange
.4:
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PlayCrowdAmbience                               78730  97 PC, low confidence
; Plays the crowd ambience sounds
;-----------------------------------------------------------------------------
PlayCrowdAmbience:
        push ebx
        push edx
        mov eax, 0FA0h
        call randomd0
        cmp ax, 58h
        jne short .3
        mov eax, 4
        call randomd0
        xor edx, edx
        test ax, ax
        je short .1
        mov eax, 506h
        jmp short .2
.1:
        mov eax, 503h
.2:
        call PlaySfxOr
.3:
        test byte [gmode], 1
        jne near .6
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl near .6
        mov eax, 3E8h
        call randomd0
        cmp ax, 2
        jg near .6
        mov eax, dword [puckc]
        movsx edx, byte [eax]
        mov eax, edx
        shl eax, 5
        add eax, edx
        test byte [nosplit eax*8+PlayerControlFlags], 40h
        sete al
        mov edx, eax
        mov eax, 6
        and edx, 0FFh
        call randomd0
        cwde
        add eax, edx
        je short .4
        xor eax, eax
        jmp short .5
.4:
        mov eax, 6
.5:
        mov edx, dword [puckc]
        movsx edx, byte [edx]
        cmp eax, edx
        je short .6
        mov edx, eax
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        push dword [byte eax+028h]
        push dword [byte eax+020h]
        mov eax, 0Fh
        mov ebx, 64h
        call randomd0
        cwde
        xor edx, edx
        add eax, 510h
        call PlaySfxAt
.6:
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DoGameFrame                       78810  94G hockey94.asm, medium confidence
; One frame of game logic, from RunSimFrames, RunOpeningFrames and PlaceOpeningPlayers: periodicevents,
; updateplayers, then the crowd sounds and commentary
;-----------------------------------------------------------------------------
DoGameFrame:
        push ebx
        push ecx
        push edx
        push esi
        call periodicevents
        call updateplayers
        call PlayCrowdAmbience
        mov eax, dword [puckc]
        mov dl, byte [eax]
        test dl, dl
        jl near .3
        test byte [gmode], 1
        jne near .3
        movsx edx, dl
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        cmp word [dword eax+0A9h], byte 0
        jne short .1
        mov ebx, dword [dword eax+0A3h]
        sar ebx, 18h
        sub ebx, byte 19h
        imul ebx, dword 125h
        mov edx, dword [dword eax+0FEh]
        mov edx, dword [dword edx+0108h]
        add edx, 1D42h
        jmp short .2
.1:
        mov edx, dword [dword eax+0FEh]
        mov ebx, dword [dword edx+0108h]
        mov edx, dword [dword eax+0A3h]
        sar edx, 18h
        imul edx, dword 125h
        add ebx, 0A3h
.2:
        add edx, ebx
        mov ebx, dword [LastTouchPlayer]
        push ebx
        lea ebx, [byte eax+028h]
        push ebx
        lea ebx, [byte eax+020h]
        push ebx
        mov bl, byte [dword eax+0BFh]
        push edx
        test bl, 80h
        setne al
        and eax, 0FFh
        push eax
        push dword 0A0000005h
        call CommentaryEvent
        add esp, byte 18h
.3:
        cmp dword [ReplayPlaying], byte 0
        jne short .5
        mov ecx, SortCords
        xor esi, esi
.4:
        xor eax, eax
        mov edx, dword [puckc]
        mov al, byte [dword ecx+0A4h]
        movsx edx, byte [edx]
        inc esi
        cmp edx, eax
        sete al
        xor ebx, ebx
        mov edx, dword [dword ecx+0B8h]
        mov bl, al
        sar edx, 10h
        mov eax, dword [dword ecx+0F2h]
        add ecx, 108h
        call SetTeamColours
        cmp esi, byte 0Ch
        jl short .4
.5:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
SimGameBlankPair:                               ; used by SimulateGame
        db 00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; RandomCrowdDelay                                78938  97 PC, low confidence
; Picks a random crowd sound delay
;-----------------------------------------------------------------------------
RandomCrowdDelay:
        push ebx
        push ecx
        push esi
        push edi
        mov esi, eax
        mov edi, edx
        xor ebx, ebx
        xor ecx, ecx
        test eax, eax
        jle short .2
.1:
        call rand_
        mov edx, eax
        sar edx, 1Fh
        idiv edi
        inc edx
        inc ebx
        add ecx, edx
        cmp ebx, esi
        jl short .1
.2:
        mov eax, ecx
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
        push ebx
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        and esp, byte 0FFFFFFF8h
        mov ebx, 3E8h
        mov dword [byte esp+08h], eax
.3:
        call rand_
        mov edx, eax
        sar edx, 1Fh
        idiv ebx
        mov dword [byte esp+04h], edx
        test edx, edx
        je short .3
        fild dword [byte esp+04h]
        fmul qword [F64_0p001]
        fldln2
        fxch
        fyl2x
        fchs
        fild dword [byte esp+08h]
        fmulp
        call __CHP
        fistp dword [esp]
        mov eax, dword [esp]
        mov esp, ebp
        pop ebp
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        push esi
        push edi
        mov esi, edx
        xor ebx, ebx
        xor ecx, ecx
        test edx, edx
        jle short .5
        lea edi, [nosplit eax*2+00h]
.4:
        call rand_
        mov edx, eax
        sar edx, 1Fh
        idiv edi
        inc ebx
        add ecx, edx
        cmp ebx, esi
        jl short .4
.5:
        mov edx, ecx
        mov eax, ecx
        sar edx, 1Fh
        idiv esi
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
