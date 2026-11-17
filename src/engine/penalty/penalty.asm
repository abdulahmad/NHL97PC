; Penalties: adding penalties, power plays, penalty time and penalty shots.
bits 32
%include "hockey.inc"
section s_32181 progbits alloc exec nowrite align=1
extern assinsert, assreplace, AwayEbenPlayer, AwayGoalsPeriod, AwayPlayerRecords, AwCoachGoalie, AwLineState, AwPenaltyPlayer
extern AwPlayerFlags, AwPlayersInBox, AwScore, awtmstruct, BenchRequest, BreakawayFlag, ClearOverlayWindows, CommentaryEvent
extern DefenseByDefense, DelayedPen, EndPenShotScene, ExtraAttacker, F32_neg1392_updatepentime_ut_chk, FaceoffRequest, FaceoffSpot, FaceoffZone
extern ForwardsByOffense, GameOptionFlags, gmode, goalieflags, GoalieTarget, GoalLineFlag, GoalScorerFlags, gsp
extern HmCoachGoalie, HmLineState, HmPenaltyPlayer, HmPlayerFlags, HmPlayersInBox, HmScore, hmtmstruct, holdreset
extern HomeEbenPlayer, HomeGoalsPeriod, HomePlayerRecords, LastPlayerTouch, LastTouchPlayer, LastTouchTeam, LinePickOrderFrom1, LogPenalty
extern MessagePanel, PaEvent, PassDistY, PenaltyBoxCount, PenaltyFlags, PenaltyMinutes, PenaltyPaCodes, PenaltyPending
extern PenaltyQueue, PenaltyRecord, PenaltySlots, PenaltyTeam, PenaltyTypes, PenCntDwn, penshotlive, penshotmode
extern penshottimer, PeriodLength, PlayerControlFlags, PlayerStateFlags, PlayFlags, PlaySfxOr, PlaySfxVolume, ProgressCount
extern ProgressLimit, ProgressRecord, ProgressTimer, ProgressTimes, PtrPuckFlags, PtrPuckObject, PtrPuckOwner, PtrPuckTarget
extern PtrPuckZone, PuckHitFlag, PuckOwner, PuckOwnerTeam, puckx, pucky, QueueOverlayPanel, randomd0
extern RefPlayer, RefSignal, RefState, RefTarget, regd1, RemoveOverlayPanel, ReplayPlaying, ResetRenderTimers
extern SetCrowdMood, Setplass, setplayer, SortCords, SortIndices, StartWhistleStop, StatsPanelOn, StoppageFlag
extern str_Punct_InProgress, ZoneFlags
global ChkTwoInBox, AddPenalty, AddPenalty2JumpTable, AddPenalty2, AddPenalty2_2BD, AddPenalty2_2CB, AddPenalty2_2D2, AddPenalty2_308
global AddPenalty2_32E, AddPenalty2_354, Stop4Pen, updatepwrplay, chkatop, releasepl, PenGoalStuff, updatepentime_ut_chk
global updatepentime_ut, updatepentime, checkfornewpen, SumOnIceRatings, SetupPenaltyShot, EndPenaltyShot, PenaltyPaCode, InProgress
global InProgress_8B2, InProgress_96E, chkprogress
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ChkTwoInBox                                     32184  97 PC, low confidence
; Whether the player's team already has players serving in the box (counts
; 8001h / 8002h entries of the box list)
;-----------------------------------------------------------------------------
ChkTwoInBox:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebp, eax
        mov esi, dword [dword eax+0FEh]
        xor edx, edx
        mov ah, byte [dword eax+0BFh]
        mov dword [esp], edx
        test ah, 40h
        setne cl
        xor ebx, ebx
        xor ch, ch
        xor eax, eax
.1:
        movsx edx, cx
        imul edi, edx, byte 19h
        movsx edx, ax
        movsx dx, byte [dword edx+edi+DefenseByDefense]
        test dx, dx
        jl short .5
        movsx di, byte [dword ebp+0A6h]
        cmp dx, di
        jne short .2
        mov dword [esp], 1
.2:
        movsx edx, dx
        add edx, edx
        add edx, esi
        mov di, word [byte edx+050h]
        cmp di, 8001h
        je short .3
        cmp di, 8002h
        jne short .4
.3:
        inc ebx
.4:
        inc eax
        cmp ax, 19h
        jl short .1
.5:
        mov eax, dword [esp]
        test ax, ax
        je short .6
        cmp bx, byte 2
        jmp short .11
.6:
        xor ebx, ebx
.7:
        movsx edx, cx
        imul edi, edx, byte 19h
        movsx edx, ax
        movsx dx, byte [dword edx+edi+ForwardsByOffense]
        test dx, dx
        jl short .10
        movsx edx, dx
        add edx, edx
        add edx, esi
        mov di, word [byte edx+050h]
        cmp di, 8001h
        je short .8
        cmp di, 8002h
        jne short .9
.8:
        inc ebx
.9:
        inc eax
        cmp ax, 19h
        jl short .7
.10:
        cmp bx, byte 4
.11:
        setg al
        xor edx, edx
        mov dl, al
        mov eax, edx
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; AddPenalty                                     32260  94G, medium confidence
; (player, penalty, ...) adds a penalty unless the clock is stopped, a penalty shot is live
; or the rule is off in the options (offsides 5, two-line pass 6 ...); falls through to AddPenalty2
;-----------------------------------------------------------------------------
AddPenalty:
        push ecx
        push esi
        mov ecx, eax
        test byte [gmode], 1
        je short .1
        cmp dword [RefState], byte 0
        je near .5
.1:
        cmp word [penshotlive], byte 0
        jne near .5
        cmp dx, byte 4
        je near .4
        cmp dx, byte 5
        jne short .2
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 8
        je near .5
        jmp near .4
.2:
        cmp dx, byte 6
        jne short .3
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 10h
        je short .5
        movsx ebx, bx
        movsx edx, dx
        mov eax, ecx
        call AddPenalty2
        pop esi
        pop ecx
        ret
.3:
        test byte [dword ecx+0BFh], 40h
        setne al
        and eax, 0FFh
        cmp byte [dword eax+PenaltyBoxCount], 8
        jge short .5
        mov eax, ecx
        call ChkTwoInBox
        test eax, eax
        je short .5
        mov eax, dword [GameOptionFlags]
        mov esi, dword [byte eax+01h]
        and esi, byte 7
        lea eax, [nosplit esi*4+00h]
        add esi, eax
        mov eax, 64h
        shl esi, 2
        call randomd0
        cwde
        cmp eax, esi
        jae short .5
.4:
        movsx ebx, bx
        movsx edx, dx
        mov eax, ecx
        call AddPenalty2
.5:
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
AddPenalty2JumpTable:                           ; jump table for the switch cases of AddPenalty2
        dd AddPenalty2_2D2
        dd AddPenalty2_2BD
        dd AddPenalty2_2CB
        dd AddPenalty2_354
        dd AddPenalty2_32E
        dd AddPenalty2_308
;-----------------------------------------------------------------------------
; AddPenalty2                                       32340  94G, low confidence
; (player, penalty, ...) a forced penalty: penalty table
; PenaltyMinutes, the penalty panel (QueueOverlayPanel)
;-----------------------------------------------------------------------------
AddPenalty2:
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 8
        mov ecx, eax
        mov word [byte ebp-04h], dx
        mov word [byte ebp-08h], bx
        cmp word [GoalLineFlag], byte 0
        jne near AddPenalty2_2CB
        cmp word [BenchRequest], byte 0
        jne short .3
        mov eax, dword [byte ebp-06h]
        mov edx, dword [DelayedPen]
        sar eax, 10h
        sar edx, 10h
        mov eax, dword [nosplit eax*4+PenaltyMinutes]
        cmp eax, edx
        jl short .3
        push eax
        cmp eax, byte 7
        jne short .1
        xor eax, eax
        jmp short .2
.1:
        mov eax, 0C8h
.2:
        push eax
        push byte 0
        call QueueOverlayPanel
        add esp, byte 0Ch
.3:
        mov esi, dword [byte ebp-04h]
        cmp si, byte 0Eh
        jge short .4
        mov word [BreakawayFlag], si
.4:
        mov edi, dword [byte ebp-04h]
        cmp di, byte 0Eh
        jl near .13
        test byte [dword ecx+0BFh], 40h
        je short .6
        cmp byte [PenaltyPending], 0
        je short .5
        cmp byte [PenaltyTeam], 6
        jge short .5
        cmp byte [PenaltySlots], 0
        je short .5
        mov eax, 504h
        xor edx, edx
        call PlaySfxOr
.5:
        mov eax, 9
        call SetCrowdMood
        jmp near .13
.6:
        cmp word [byte ebp-08h], byte 0
        je short .10
        cmp di, byte 1Ch
        je short .10
        cmp di, byte 1Dh
        je short .10
        cmp byte [PenaltyPending], 0
        jne short .9
        cmp word [HmPlayersInBox], byte 6
        jge short .7
        mov eax, 500h
        jmp short .8
.7:
        mov eax, 4
        call randomd0
        cwde
        mov eax, dword [nosplit eax*4+PenaltyTypes]
.8:
        xor edx, edx
        call PlaySfxOr
.9:
        mov eax, 2
        call randomd0
        test ax, ax
        sete al
        and eax, 0FFh
        call SetCrowdMood
        jmp near .13
.10:
        cmp word [byte ebp-04h], byte 22h
        jne near .13
        test byte [dword ecx+0BFh], 40h
        jne short .11
        mov eax, 2
        call randomd0
        test ax, ax
        sete al
        and eax, 0FFh
        call SetCrowdMood
        mov edx, dword [penshottimer]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov eax, dword [nosplit eax*8+PenaltyRecord]
        sar eax, 18h
        imul eax, dword 125h
        add eax, AwayPlayerRecords
        jmp short .12
.11:
        mov edx, dword [penshottimer]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov eax, dword [nosplit eax*8+PenaltyRecord]
        sar eax, 18h
        imul eax, dword 125h
        add eax, HomePlayerRecords
.12:
        push eax
        push dword 0A0000027h
        call CommentaryEvent
        add esp, byte 8
.13:
        mov bl, byte [PenaltyPending]
        xor eax, eax
        xor edx, edx
        test bl, bl
        jne near AddPenalty2_354.28
.14:
        mov bl, byte [byte ebp-04h]
        mov byte [dword eax+PenaltyPending], bl
        mov bl, byte [dword ecx+0A4h]
        mov byte [dword eax+PenaltyTeam], bl
        mov bl, byte [byte ebp-08h]
        mov byte [dword eax+PenaltySlots], bl
        cmp byte [dword ecx+0A6h], 19h
        jge short .16
        test bl, 4
        jne short .15
        cmp word [byte ebp-04h], byte 1Dh
        jne short .16
.15:
        test byte [byte ebp-08h], 10h
        jne short .16
        mov ebx, dword [dword ecx+0A3h]
        mov eax, dword [dword ecx+0FEh]
        sar ebx, 18h
        inc byte [dword ebx+eax+0B4h]
        mov ebx, dword [byte ebp-04h]
        cmp bx, byte 1Dh
        je short .16
        cmp bx, byte 10h
        je short .16
        mov eax, dword [dword ecx+0A3h]
        mov ebx, dword [dword ecx+0FEh]
        sar eax, 18h
        cmp byte [dword ebx+eax+0B4h], 3
        jb short .16
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        or byte [dword eax+PenaltySlots], 10h
.16:
        cmp word [byte ebp-08h], byte 0
        jne near AddPenalty2_354.22
        cmp word [dword ecx+0A9h], byte 0
        jne short .17
        mov eax, dword [dword ecx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        add edx, 1D42h
        jmp short .18
.17:
        mov eax, dword [dword ecx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        add edx, 0A3h
.18:
        add eax, edx
        mov edx, dword [byte ebp-04h]
        sub edx, byte 5
        cmp dx, byte 5
        ja near AddPenalty2_2CB
        and edx, 0FFFFh
        jmp dword [nosplit cs:edx*4+AddPenalty2JumpTable]
AddPenalty2_2BD:
        push eax
        push dword 0A0000028h
        call CommentaryEvent
        add esp, byte 8
AddPenalty2_2CB:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
AddPenalty2_2D2:
        mov esi, 1000h
        mov dword [LastTouchPlayer], esi
        push esi
        mov bh, byte [dword ecx+0BFh]
        push byte 0
        test bh, 40h
        setne dl
        and edx, 0FFh
        push edx
        push eax
        push dword 0A0000022h
        call CommentaryEvent
        add esp, byte 14h
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
AddPenalty2_308:
        mov ecx, 1000h
        push ecx
        push dword 0D004h
        push eax
        push dword 0A0000020h
        mov dword [LastTouchPlayer], ecx
        call CommentaryEvent
        add esp, byte 10h
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
AddPenalty2_32E:
        mov esi, 1000h
        push esi
        push dword 0D001h
        push eax
        push dword 0A0000020h
        mov dword [LastTouchPlayer], esi
        call CommentaryEvent
        add esp, byte 10h
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
AddPenalty2_354:
        cmp dword [PuckHitFlag], byte 0
        je short .19
        mov ecx, 1001h
        push ecx
        push dword 0D003h
        push eax
        push dword 0A0000020h
        mov dword [LastTouchPlayer], ecx
        call CommentaryEvent
        add esp, byte 10h
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.19:
        mov edx, dword [PtrPuckFlags]
        mov bx, word [byte edx+06Dh]
        cmp bx, byte 3
        je short .20
        test bx, bx
        jne short .21
.20:
        mov ebx, 1001h
        push ebx
        push dword 4003h
        push eax
        push dword 0A0000006h
        mov dword [LastTouchPlayer], ebx
        call CommentaryEvent
        add esp, byte 10h
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.21:
        mov edx, 1000h
        push edx
        push dword 0D002h
        push eax
        push dword 0A0000020h
        mov dword [LastTouchPlayer], edx
        call CommentaryEvent
        add esp, byte 10h
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.22:
        mov al, byte [dword ecx+0C0h]
        test al, 10h
        jne near .27
        mov dh, al
        or dh, 10h
        mov eax, dword [byte ebp-04h]
        mov byte [dword ecx+0C0h], dh
        cmp ax, 0Eh
        jl near AddPenalty2_2CB
        cmp dword [ReplayPlaying], byte 0
        jne near AddPenalty2_2CB
        cmp ax, 1Ch
        je near AddPenalty2_2CB
        cmp ax, 1Dh
        je near AddPenalty2_2CB
        cmp word [dword ecx+0A9h], byte 0
        jne short .23
        mov eax, dword [dword ecx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul ebx, eax, dword 125h
        lea eax, [dword edx+01D42h]
        add eax, ebx
        jmp short .24
.23:
        mov eax, dword [dword ecx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        add edx, 0A3h
        add eax, edx
.24:
        cmp word [byte ebp-04h], byte 20h
        jne short .25
        mov edx, 7009h
        jmp short .26
.25:
        mov edx, dword [byte ebp-06h]
        sar edx, 10h
        mov edx, dword [nosplit edx*2+PenaltyFlags]
        sar edx, 10h
.26:
        mov ebx, dword [LastTouchPlayer]
        push ebx
        mov bl, byte [dword ecx+0BFh]
        push edx
        test bl, 40h
        setne dl
        and edx, 0FFh
        push edx
        push eax
        push dword 0A000000Ah
        call CommentaryEvent
        add esp, byte 14h
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.27:
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        xor dl, dl
        mov byte [dword eax+PenaltySlots], dl
        mov byte [dword eax+PenaltyTeam], dl
        mov byte [dword eax+PenaltyPending], dl
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.28:
        add eax, byte 3
        inc edx
        cmp eax, byte 60h
        jge near AddPenalty2_2CB
        cmp byte [dword eax+PenaltyPending], 0
        je near AddPenalty2.14
        jmp short .28
        db 08Bh,0C0h
        push edx
        cmp ax, 3
        je short .29
        mov edx, 1
        mov word [BreakawayFlag], ax
        mov dword [RefTarget], edx
        cmp ax, 7
        sete al
        and eax, 0FFh
        add eax, byte 36h
        movsx edx, ax
        mov eax, dword [PtrPuckObject]
        call assreplace
.29:
        pop edx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; Stop4Pen                                       32888  94G, medium confidence
; (from checkfornewpen and puckfaceoff): stops the clock (gmode bit 0), sets the faceoff spot
; from the penalty type, clears the overlays, whistle sound and PA event
;-----------------------------------------------------------------------------
Stop4Pen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edx, eax
        cmp dword [ReplayPlaying], byte 0
        jne short .1
        mov eax, 1
        call ResetRenderTimers
.1:
        movsx edx, dx
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov bl, byte [dword eax+PenaltyPending]
        mov dl, byte [dword eax+PenaltyTeam]
        mov ah, byte [gmode]
        and dl, 7Fh
        test ah, 1
        jne near .24
        mov dh, ah
        xor ecx, ecx
        or dh, 1
        mov word [FaceoffZone], cx
        mov word [FaceoffSpot], cx
        mov byte [gmode], dh
        cmp bl, 7
        je near .8
        mov ax, word [LastPlayerTouch]
        mov word [FaceoffSpot], ax
        mov ax, word [StoppageFlag]
        mov word [FaceoffZone], ax
        cmp bl, 8
        je near .8
        cmp bl, 6
        je near .8
        mov eax, dword [PtrPuckTarget]
        mov ax, word [eax]
        mov word [FaceoffSpot], ax
        mov eax, dword [PtrPuckOwner]
        mov ax, word [eax]
        mov word [FaceoffZone], ax
        cmp bl, 5
        jne short .5
        test ax, ax
        jge short .2
        mov eax, dword [FaceoffSpot]
        sar eax, 10h
        neg eax
        jmp short .3
.2:
        mov eax, dword [FaceoffSpot]
        sar eax, 10h
.3:
        cmp eax, 570h
        jge short .8
        cmp word [FaceoffZone], byte 0
        jge short .4
        mov eax, 0FFFFFA90h
        jmp short .7
.4:
        mov eax, 570h
        jmp short .7
.5:
        cmp bl, 4
        jne short .8
        and edx, 0FFh
        mov eax, edx
        shl eax, 5
        add eax, edx
        test byte [nosplit eax*8+PlayerControlFlags], 80h
        je short .6
        mov eax, 0FFFFED40h
        jmp short .7
.6:
        mov eax, 12C0h
.7:
        mov word [FaceoffZone], ax
.8:
        cmp word [BenchRequest], byte 0
        je short .9
        mov ax, word [AwayGoalsPeriod]
        mov word [FaceoffSpot], ax
        mov ax, word [HomeGoalsPeriod]
        mov word [FaceoffZone], ax
.9:
        cmp word [FaceoffSpot], 420h
        jl short .10
        mov word [FaceoffSpot], 420h
        jmp short .11
.10:
        mov eax, dword [StatsPanelOn]
        sar eax, 10h
        cmp eax, 0FFFFFBE0h
        jg short .11
        mov word [FaceoffSpot], 0FBE0h
.11:
        cmp word [FaceoffZone], 930h
        jl short .14
        cmp word [FaceoffSpot], byte 0
        jge short .12
        mov eax, 0FFFFFBE0h
        jmp short .13
.12:
        mov eax, 420h
.13:
        mov edi, 0CF0h
        mov word [FaceoffSpot], ax
        mov word [FaceoffZone], di
        jmp short .17
.14:
        mov eax, dword [FaceoffSpot]
        sar eax, 10h
        cmp eax, 0FFFFF6D0h
        jg short .17
        cmp word [FaceoffSpot], byte 0
        jge short .15
        mov eax, 0FFFFFBE0h
        jmp short .16
.15:
        mov eax, 420h
.16:
        mov ecx, 0FFFFF310h
        mov word [FaceoffSpot], ax
        mov word [FaceoffZone], cx
.17:
        mov edi, 0FFFFFB80h
        xor eax, eax
.18:
        mov dl, byte [dword eax+PenaltyTeam]
        and dl, 7Fh
        movsx edx, dl
        imul edx, dword 108h
        add edx, SortCords
        test byte [dword edx+0BFh], 80h
        jne short .20
        mov edx, dword [FaceoffSpot]
        sar edx, 10h
        cmp edx, 0FFFFFA90h
        jg short .23
        mov dx, word [FaceoffSpot]
        mov word [FaceoffZone], di
        test dx, dx
        jge short .19
        mov edx, 0FFFFFBE0h
        jmp short .22
.19:
        mov edx, 420h
        jmp short .22
.20:
        cmp word [FaceoffZone], 570h
        jl short .23
        mov ecx, 480h
        mov si, word [FaceoffSpot]
        mov word [FaceoffZone], cx
        test si, si
        jge short .21
        mov edx, 0FFFFFBE0h
        jmp short .22
.21:
        mov edx, 420h
.22:
        mov word [FaceoffSpot], dx
.23:
        mov ch, byte [dword eax+PenaltyQueue]
        add eax, byte 3
        test ch, ch
        jne near .18
.24:
        push dword 0A000002Dh
        mov al, byte [gmode]
        xor ecx, ecx
        or al, 4
        mov word [PenCntDwn], cx
        mov byte [gmode], al
        call CommentaryEvent
        add esp, byte 4
        cmp bl, 1
        je short .25
        cmp bl, 2
        je short .25
        mov eax, dword [PtrPuckObject]
        push dword [byte eax+028h]
        mov edx, 64h
        push dword [byte eax+020h]
        mov eax, 461h
        call PlaySfxVolume
        jmp short .26
.25:
        call ClearOverlayWindows
.26:
        test byte [gmode], 8
        je short .27
        push dword 0A0000026h
        call CommentaryEvent
        add esp, byte 4
.27:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; updatepwrplay                                  32B68  94G, medium confidence
;
; The power play state part (called from updatepentime here): players on ice home minus away; sets /
; clears the power play flag (PlayFlags 20h, 40h visitors) and counts a power play (+20CBh) and a
; shorthanded situation (+20BDh) when it starts; no display
;-----------------------------------------------------------------------------
updatepwrplay:
        push ebx
        push ecx
        push edx
        mov ebx, awtmstruct
        mov ax, word [HmPlayersInBox]
        mov cx, word [AwPlayersInBox]
        mov edx, hmtmstruct
        sub ax, cx
        jne short .1
        and byte [PlayFlags], 0DFh
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov cx, word [PlayFlags]
        and cl, 9Fh
        test ax, ax
        jle short .2
        mov al, byte [PlayFlags]
        mov edx, ebx
        mov ebx, hmtmstruct
        test al, 40h
        je short .4
        jmp short .3
.2:
        test byte [PlayFlags], 40h
        jne short .4
        or cl, 40h
.3:
        mov word [PlayFlags], cx
.4:
        mov ah, byte [PlayFlags]
        test ah, 20h
        jne short .5
        mov cl, ah
        or cl, 20h
        mov byte [PlayFlags], cl
        cmp dword [ReplayPlaying], byte 0
        jne short .5
        mov eax, dword [dword ebx+0108h]
        inc word [dword eax+020CBh]
        mov eax, dword [dword edx+0108h]
        inc word [dword eax+020BDh]
.5:
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; chkatop                                        32C04  94G, medium confidence
; (attack time stat, once a second from updatepentime): puck y
; beyond +/-570h credits the attacking team's attack time (+20D7h)
;-----------------------------------------------------------------------------
chkatop:
        push edx
        cmp dword [ReplayPlaying], byte 0
        jne near .6
        mov eax, dword [PtrPuckOwner]
        mov dx, word [eax]
        cmp dx, 570h
        jg short .1
        movsx eax, dx
        cmp eax, 0FFFFFA90h
        jge near .6
.1:
        mov eax, dword [PtrPuckZone]
        mov dl, byte [eax]
        test dl, dl
        jl short .2
        movsx edx, dl
        jmp short .3
.2:
        cmp word [PuckOwnerTeam], byte 0
        jl near .6
        test byte [holdreset], 10h
        sete al
        and eax, 0FFh
        je short .6
        mov edx, dword [PuckOwner]
        sar edx, 10h
.3:
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        test byte [dword eax+0BFh], 80h
        jne short .4
        mov edx, dword [PtrPuckOwner]
        movsx edx, word [edx]
        cmp edx, 0FFFFFA90h
        jl short .5
.4:
        test byte [dword eax+0BFh], 80h
        je short .6
        mov edx, dword [PtrPuckOwner]
        cmp word [edx], 570h
        jle short .6
.5:
        mov eax, dword [dword eax+0FEh]
        mov eax, dword [dword eax+0108h]
        inc word [dword eax+020D7h]
.6:
        pop edx
        ret
        db 090h
        mov ah, byte [PlayFlags]
        test ah, 20h
        je short .9
        cmp dword [ReplayPlaying], byte 0
        jne short .9
        test ah, 40h
        jne short .7
        mov eax, dword [HmScore]
        jmp short .8
.7:
        mov eax, dword [AwScore]
.8:
        inc word [dword eax+020D1h]
.9:
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; releasepl                                                         32CEC  94G
; (player's penalty time is up, let him out): first sort object off the ice, one more on the
; ice (+0Eh), line-change flags, position from the priority list (LinePickOrderFrom1), Setplass, setplayer
;-----------------------------------------------------------------------------
releasepl:
        push ebx
        push ecx
        push esi
        mov ebx, dword [dword eax+0104h]
        cmp word [dword ebx+0A9h], byte 0
        jl short .2
.1:
        mov si, word [dword ebx+01B1h]
        add ebx, 108h
        test si, si
        jge short .1
.2:
        inc word [byte eax+0Eh]
        or byte [HmPlayerFlags], 1
        or byte [AwPlayerFlags], 1
        or byte [HmCoachGoalie], 40h
        or byte [AwCoachGoalie], 40h
        cmp word [byte eax+010h], byte 0
        setl cl
        mov eax, dword [byte eax+0Ch]
        and ecx, 0FFh
        sar eax, 10h
        movsx ax, byte [dword ecx+eax+LinePickOrderFrom1]
        mov word [dword ebx+0A9h], ax
        mov eax, ebx
        movsx edx, dx
        call Setplass
        mov eax, ebx
        call setplayer
        or byte [dword ebx+0C0h], 4
        mov eax, 500h
        call RemoveOverlayPanel
        mov eax, 600h
        call RemoveOverlayPanel
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PenGoalStuff                                   32D88  94G, medium confidence
; (after a goal): when the scoring team had more players on the ice, releases the first
; scored-on player in the box without a coincidental penalty (releasepl)
;-----------------------------------------------------------------------------
PenGoalStuff:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov word [esp], ax
        mov ebx, 0FFFFFFFFh
        mov edx, 1
        mov word [byte esp+04h], bx
        mov dword [byte esp+010h], ebx
        mov dword [byte esp+0Ch], edx
        test ax, ax
        jle short .1
        mov eax, awtmstruct
        jmp short .2
.1:
        mov eax, hmtmstruct
.2:
        mov edi, dword [esp]
        mov ebp, eax
        test di, di
        sete al
        and eax, 0FFh
        je short .3
        mov eax, awtmstruct
        jmp short .4
.3:
        mov eax, hmtmstruct
.4:
        mov dx, word [byte ebp+0Eh]
        mov bx, word [byte eax+0Eh]
        mov edi, eax
        cmp dx, bx
        jle short .8
        xor eax, eax
.5:
        movsx edx, ax
        movsx dx, byte [dword edx+edi+088h]
        test dx, dx
        jl short .7
        movsx esi, dx
        add esi, esi
        add esi, edi
        mov bl, byte [byte esi+051h]
        test bl, 10h
        jne short .6
        test bl, 40h
        je short .7
.6:
        inc eax
        cmp ax, 1Ch
        jl short .5
.7:
        mov dword [byte esp+010h], eax
        mov word [byte esp+04h], dx
        test dx, dx
        jl short .8
        xor ecx, ecx
        mov dword [byte esp+0Ch], ecx
.8:
        xor eax, eax
        xor ebx, ebx
        jmp near .17
.9:
        cmp word [gsp], byte 3
        jne short .10
        mov si, word [awtmstruct]
        cmp si, word [hmtmstruct]
        jne short .11
.10:
        mov edx, 1
        jmp short .12
.11:
        xor edx, edx
.12:
        test edx, edx
        je near .14
        movsx edx, ax
        lea edx, [edx+edx*2]
        mov cl, byte [dword edx+PenaltySlots]
        test cl, 14h
        jne short .13
        test cl, 3
        je short .14
        cmp byte [dword edx+PenaltyTeam], 6
        setl dl
        movzx esi, dl
        mov edx, dword [byte esp-02h]
        sar edx, 10h
        xor edx, esi
        jne short .13
        cmp word [byte esp+0Ch], byte 0
        jne short .14
.13:
        cmp bx, ax
        je near .16
        movsx edx, ax
        movsx esi, bx
        lea edx, [edx+edx*2]
        lea esi, [esi+esi*2]
        mov cl, byte [dword edx+PenaltyPending]
        mov byte [dword esi+PenaltyPending], cl
        mov cl, byte [dword edx+PenaltyTeam]
        mov byte [dword esi+PenaltyTeam], cl
        mov dl, byte [dword edx+PenaltySlots]
        inc ebx
        mov byte [dword esi+PenaltySlots], dl
        jmp short .16
.14:
        movsx edx, ax
        lea edx, [edx+edx*2]
        mov ch, byte [dword edx+PenaltyTeam]
        test ch, ch
        jl short .15
        cmp ch, 0Ch
        jge short .15
        mov dl, ch
        and dl, 7Fh
        movsx edx, dl
        imul edx, dword 108h
        and byte [dword edx+PlayerStateFlags], 0EFh
        dec dword [byte esp+0Ch]
.15:
        movsx edx, ax
        lea edx, [edx+edx*2]
        xor cl, cl
        mov byte [dword edx+PenaltySlots], cl
        mov byte [dword edx+PenaltyTeam], cl
        mov byte [dword edx+PenaltyPending], cl
.16:
        inc eax
.17:
        movsx edx, ax
        lea edx, [edx+edx*2]
        cmp byte [dword edx+PenaltyPending], 0
        jne near .9
        cmp byte [PenaltyPending], 0
        jne short .18
        cmp word [MessagePanel], byte 7
        jne short .18
        mov eax, 7
        call RemoveOverlayPanel
.18:
        mov dx, word [byte edi+0Eh]
        cmp dx, word [byte ebp+0Eh]
        jge near .22
        mov eax, dword [byte esp+010h]
        mov ebx, dword [byte esp+04h]
        mov word [byte esp+08h], ax
        test bx, bx
        jl short .21
        mov edx, dword [byte esp+02h]
        sar edx, 10h
        lea eax, [nosplit edx*2+00h]
        add eax, edi
        mov bx, word [byte eax+050h]
        and bh, 7
        cmp bx, byte 78h
        jbe short .19
        mov dx, word [byte eax+050h]
        and edx, 0FFFFF800h
        or dl, 78h
        mov word [byte eax+050h], dx
        jmp short .21
.19:
        mov word [byte eax+050h], 0
        or byte [byte eax+051h], 8
        mov eax, edi
        mov ebx, 1
        call releasepl
.20:
        mov edx, dword [byte esp+06h]
        movsx esi, bx
        sar edx, 10h
        add edx, esi
        mov al, byte [dword edx+edi+088h]
        mov byte [dword edx+edi+087h], al
        test al, al
        jl short .21
        inc ebx
        jmp short .20
.21:
        mov al, byte [AwPlayerFlags]
        mov ch, byte [HmPlayerFlags]
        or al, 1
        or ch, 1
        mov byte [AwPlayerFlags], al
        mov byte [HmPlayerFlags], ch
.22:
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; updatepentime_ut_chk                32FF8  94G penalty94.asm, low confidence
; The updatepentime_ut check for one box entry (team, player): when the time is up, the PA event 1Bh and
; releasepl when the team is short (the short-handed check of updatepentime_ut)
;-----------------------------------------------------------------------------
updatepentime_ut_chk:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 4
        mov ebx, eax
        mov ecx, edx
        test dl, 80h
        jne near .8
        cmp word [byte eax+0Eh], byte 6
        jge near .8
        movsx eax, cx
        mov dx, word [byte ebx+eax*2+050h]
        and dh, 7
        and edx, 0FFFFh
        cmp edx, byte 5Ah
        jge short .1
        imul eax, dword 125h
        mov edi, dword [LastTouchPlayer]
        mov esi, dword [dword ebx+0108h]
        mov dword [byte ebp-04h], eax
        lea eax, [dword esi+0A3h]
        push edi
        mov esi, dword [byte ebp-04h]
        push edx
        add esi, eax
        cmp ebx, awtmstruct
        sete al
        and eax, 0FFh
        push eax
        push esi
        push dword 0A000001Bh
        call CommentaryEvent
        add esp, byte 14h
.1:
        cmp edx, byte 5
        jg near .8
        cmp ebx, hmtmstruct
        jne short .2
        mov eax, awtmstruct
        jmp short .3
.2:
        mov eax, hmtmstruct
.3:
        cmp word [byte eax+010h], byte 0
        jl near .7
        cmp word [dword eax+0FCh], byte 0
        jl near .7
        mov edx, dword [dword eax+0FAh]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edx, SortCords
        shl eax, 3
        add edx, eax
        mov eax, dword [PtrPuckZone]
        movzx edi, byte [dword edx+0A4h]
        movsx esi, byte [eax]
        cmp edi, esi
        je near .7
        cmp byte [eax], 0
        jl short .4
        cmp byte [dword edx+0A4h], 6
        setb al
        mov esi, eax
        mov eax, dword [PtrPuckZone]
        and esi, 0FFh
        cmp byte [eax], 6
        setl al
        and eax, 0FFh
        cmp eax, esi
        je short .6
.4:
        test byte [dword edx+0BFh], 80h
        je short .5
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+028h]
        fcomp dword [F32_neg1392_updatepentime_ut_chk]
        fnstsw ax
        sahf
        ja short .6
.5:
        test byte [dword edx+0BFh], 80h
        jne short .7
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+028h], 44AE0000h
        jge short .7
.6:
        push dword [byte edx+028h]
        mov eax, 409h
        push dword [byte edx+020h]
        mov edx, 64h
        call PlaySfxVolume
.7:
        movsx edx, cx
        test word [byte ebx+edx*2+050h], 7FFh
        jne short .8
        mov eax, ebx
        call releasepl
        mov edi, dword [LastTouchPlayer]
        push edi
        mov dx, word [byte ebx+0Eh]
        push byte 0
        cmp dx, byte 6
        sete al
        and eax, 0FFh
        push eax
        cmp ebx, awtmstruct
        sete al
        and eax, 0FFh
        push eax
        push dword 0A000002Bh
        call CommentaryEvent
        add esp, byte 14h
.8:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; updatepentime_ut                               3319C  94G, medium confidence
; (team): walks the team's penalty box list, the first
; two entries serving, and counts their time down (updatepentime_ut_chk)
;-----------------------------------------------------------------------------
updatepentime_ut:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ecx, eax
        mov edx, 2
        xor edi, edi
        xor ebx, ebx
        mov word [regd1], dx
.1:
        mov si, word [regd1]
        test si, si
        jge short .3
.2:
        mov bx, word [regd1]
        cmp bx, byte 1
        jne near .9
        xor edx, edx
        mov eax, ecx
        mov dl, byte [esp]
        jmp near .12
.3:
        movsx eax, bx
        movsx ax, byte [dword ecx+eax+088h]
        test ax, ax
        jl short .2
        mov edx, esi
        dec edx
        mov word [regd1], dx
        test dx, dx
        jl near .8
        movsx ebp, ax
        add ebp, ebp
        movsx esi, di
        add ebp, ecx
        mov byte [esp+esi], al
        test byte [byte ebp+051h], 10h
        je short .4
        mov dh, al
        or dh, 80h
        mov byte [esp+esi], dh
.4:
        cwde
        add eax, eax
        add eax, ecx
        mov dx, word [byte eax+050h]
        dec edx
        mov word [byte eax+050h], dx
        test dx, 7FFh
        jne short .7
        mov dl, byte [byte eax+051h]
        or dl, 8
        mov byte [byte eax+051h], dl
        mov dh, dl
        and dh, 8Fh
        mov byte [byte eax+051h], dh
        mov word [GoalieTarget], 1
.5:
        mov edx, dword [ExtraAttacker]
        movsx eax, bx
        sar edx, 10h
        add eax, edx
        mov dl, byte [dword ecx+eax+088h]
        mov byte [dword ecx+eax+087h], dl
        test dl, dl
        jl short .6
        inc word [GoalieTarget]
        jmp short .5
.6:
        dec ebx
.7:
        inc edi
.8:
        inc ebx
        cmp bx, byte 1Ch
        jl near .1
        jmp near .2
.9:
        test bx, bx
        jne short .10
        xor edx, edx
        mov eax, ecx
        mov dl, byte [esp]
        call updatepentime_ut_chk
        jmp short .11
.10:
        mov eax, dword [ZoneFlags]
        sar eax, 10h
        cmp eax, byte 0FFFFFFFFh
        jne short .13
.11:
        xor edx, edx
        mov eax, ecx
        mov dl, byte [byte esp+01h]
.12:
        call updatepentime_ut_chk
.13:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; updatepentime                                  332C0  94G, medium confidence
; counts the penalty times down, from
; chkprogress
;-----------------------------------------------------------------------------
updatepentime:
        push ebx
        push edx
        push esi
        mov ah, byte [holdreset]
        and ah, 0BFh
        mov dl, byte [gmode]
        mov byte [holdreset], ah
        test dl, 1
        jne near .4
        cmp word [penshotlive], byte 0
        jne near .4
        mov bx, word [PeriodLength]
        dec ebx
        mov word [PeriodLength], bx
        test bx, bx
        jge short .4
        mov dh, ah
        mov esi, ebx
        or dh, 40h
        add esi, byte 10h
        mov byte [holdreset], dh
        mov word [PeriodLength], si
        call updatepwrplay
        call chkatop
        mov bl, byte [PlayFlags]
        test bl, 20h
        je short .3
        cmp dword [ReplayPlaying], byte 0
        jne short .3
        test bl, 40h
        jne short .1
        mov eax, dword [HmScore]
        jmp short .2
.1:
        mov eax, dword [AwScore]
.2:
        inc word [dword eax+020D1h]
.3:
        mov eax, hmtmstruct
        call updatepentime_ut
        mov eax, awtmstruct
        call updatepentime_ut
.4:
        pop esi
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; checkfornewpen                                 33368  94G, medium confidence
;, from chkprogress
;-----------------------------------------------------------------------------
checkfornewpen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov dx, word [GoalLineFlag]
        test dx, dx
        jne near .17
        jmp near .16
.1:
        mov cl, byte [gmode]
        mov bh, byte [dword eax+PenaltyTeam]
        test cl, 4
        jne near .11
        cmp byte [dword eax+PenaltySlots], 0
        je near .10
        cmp bl, 1Ch
        je near .10
        cmp bl, 1Dh
        je near .10
        mov eax, dword [PtrPuckZone]
        mov cl, byte [eax]
        test cl, cl
        jl short .2
        cmp cl, 6
        setl al
        and eax, 0FFh
        cmp bh, 6
        setb cl
        and ecx, 0FFh
        xor eax, ecx
        je near .9
.2:
        mov al, byte [gmode]
        test al, 8
        jne near .8
        mov ah, al
        or ah, 8
        mov byte [gmode], ah
        xor eax, eax
        mov al, bh
        imul eax, dword 108h
        add eax, SortCords
        cmp word [dword eax+0A9h], byte 0
        jne short .3
        mov ebx, dword [dword eax+0A3h]
        sar ebx, 18h
        sub ebx, byte 19h
        imul ebx, dword 125h
        mov ecx, dword [dword eax+0FEh]
        mov ecx, dword [dword ecx+0108h]
        add ecx, 1D42h
        jmp short .4
.3:
        mov ebx, dword [dword eax+0FEh]
        mov ecx, dword [dword ebx+0108h]
        mov ebx, dword [dword eax+0A3h]
        sar ebx, 18h
        imul ebx, dword 125h
        add ecx, 0A3h
.4:
        lea esi, [ecx+ebx]
        test byte [dword eax+0BFh], 40h
        je short .5
        cmp word [HmLineState], byte 0
        jl short .6
        mov ebx, dword [HmPenaltyPlayer]
        sar ebx, 10h
        imul ebx, dword 108h
        mov ebx, dword [dword ebx+PenaltyRecord]
        sar ebx, 18h
        sub ebx, byte 19h
        imul ecx, ebx, dword 125h
        mov ebx, dword [HmScore]
        add ebx, 1D42h
        add ebx, ecx
        jmp short .7
.5:
        cmp word [AwLineState], byte 0
        jl short .6
        mov ebx, dword [AwPenaltyPlayer]
        sar ebx, 10h
        imul ebx, dword 108h
        mov ebx, dword [dword ebx+PenaltyRecord]
        sar ebx, 18h
        sub ebx, byte 19h
        imul ecx, ebx, dword 125h
        mov ebx, dword [AwScore]
        add ebx, 1D42h
        add ebx, ecx
        jmp short .7
.6:
        xor ebx, ebx
.7:
        mov edi, dword [LastTouchPlayer]
        mov cl, byte [dword eax+0BFh]
        push edi
        test cl, 40h
        setne al
        and eax, 0FFh
        push eax
        push ebx
        push esi
        push dword 0A0000023h
        call CommentaryEvent
        add esp, byte 14h
.8:
        mov eax, dword [PtrPuckObject]
        or byte [dword eax+0C1h], 2
        mov eax, dword [PtrPuckObject]
        call StartWhistleStop
        jmp near .15
.9:
        push byte 7
        push dword 0C8h
        push eax
        mov ecx, 28h
        call QueueOverlayPanel
        mov eax, dword [PtrPuckObject]
        mov dword [ProgressCount], ecx
        or byte [dword eax+0C1h], 2
        add esp, byte 0Ch
        mov eax, dword [PtrPuckObject]
        call StartWhistleStop
.10:
        movsx eax, dx
        call Stop4Pen
.11:
        movsx eax, dx
        lea eax, [eax+eax*2]
        mov cl, byte [dword eax+PenaltyTeam]
        test cl, 80h
        jne short .15
        mov ch, cl
        or ch, 80h
        mov byte [dword eax+PenaltyTeam], ch
        cmp word [PenCntDwn], byte 50h
        jge short .12
        mov word [PenCntDwn], 50h
.12:
        cmp dword [RefState], byte 0
        je short .13
        mov word [PenCntDwn], 0A0h
.13:
        cmp bl, 1
        jne short .14
        mov word [PenCntDwn], 0C0h
.14:
        mov word [ProgressTimer], 40h
.15:
        inc edx
.16:
        movsx eax, dx
        lea eax, [eax+eax*2]
        mov bl, byte [dword eax+PenaltyPending]
        test bl, bl
        jne near .1
.17:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SumOnIceRatings                                 335CC  97 PC, low confidence
; From InProgress: adds up the ratings of the team's skaters on the ice
;-----------------------------------------------------------------------------
SumOnIceRatings:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 34h
        mov eax, dword [dword eax+0FEh]
        xor esi, esi
        xor edx, edx
        xor ebx, ebx
        mov dword [byte esp+030h], eax
        mov eax, dword [dword eax+0104h]
.1:
        cmp word [dword eax+0A9h], byte 0
        jle near .2
        test byte [dword eax+0C0h], 10h
        jne near .2
        mov ecx, dword [dword eax+0A3h]
        sar ecx, 18h
        mov edi, dword [byte esp+030h]
        add ecx, ecx
        add ecx, edi
        cmp word [byte ecx+050h], 8001h
        jne short .2
        xor ecx, ecx
        movzx edi, byte [dword eax+0C2h]
        mov cl, byte [dword eax+0C3h]
        add ecx, edi
        movzx edi, byte [dword eax+0C4h]
        add edi, ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0C9h]
        add edi, ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0CCh]
        add ecx, edi
        movzx edi, byte [dword eax+0CBh]
        add edi, ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0CFh]
        add edi, ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0CDh]
        add edi, ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0C7h]
        add edi, ecx
        xor ecx, ecx
        mov ebp, 0Fh
        mov cl, byte [dword eax+0C6h]
        sub ebp, ecx
        lea ecx, [byte ebp+ebp+00h]
        add ecx, edi
        mov dword [esp+ebx], ecx
        xor ecx, ecx
        add ebx, byte 4
        mov cl, byte [dword eax+0A4h]
        inc esi
        mov dword [byte esp+ebx+014h], ecx
.2:
        inc edx
        add eax, 108h
        cmp edx, byte 6
        jl near .1
        test esi, esi
        jne short .3
        xor eax, eax
        jmp short .4
.3:
        lea eax, [byte esp+018h]
        push eax
        lea eax, [byte esp+04h]
        push eax
        push esi
        call SortIndices
        add esp, byte 0Ch
        mov edx, dword [byte esp+ebx+014h]
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
.4:
        add esp, byte 34h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetupPenaltyShot                             336E4  95 PC, medium confidence
; From InProgress: penalty shot setup (penshotmode on, stat +20E3h, one
; skater a side, shooter and goalie)
;-----------------------------------------------------------------------------
SetupPenaltyShot:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        cmp word [penshotmode], byte 0
        jne near .14
        mov ebx, 1
        mov cx, word [FaceoffRequest]
        mov word [penshotmode], bx
        cmp cx, byte 5
        setg al
        xor ah, ah
        mov edx, dword [ReplayPlaying]
        mov word [pucky], ax
        test edx, edx
        jne short .3
        test ax, ax
        jle short .1
        mov eax, awtmstruct
        jmp short .2
.1:
        mov eax, hmtmstruct
.2:
        mov eax, dword [dword eax+0108h]
        inc word [dword eax+020E3h]
.3:
        mov edx, dword [penshottimer]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        mov edi, 1
        add eax, edx
        mov cx, word [pucky]
        mov word [HmPlayersInBox], di
        movsx ax, byte [nosplit eax*8+goalieflags]
        mov word [AwPlayersInBox], di
        mov word [puckx], ax
        mov ax, word [FaceoffSpot]
        xor edx, edx
        mov word [AwayGoalsPeriod], ax
        mov ax, word [FaceoffZone]
        mov word [FaceoffSpot], dx
        mov word [HomeGoalsPeriod], ax
        mov word [FaceoffZone], dx
        test cx, cx
        jle short .4
        mov eax, awtmstruct
        jmp short .5
.4:
        mov eax, hmtmstruct
.5:
        mov edx, dword [dword eax+0108h]
        mov eax, dword [FaceoffRequest]
        sar eax, 10h
        imul ebx, eax, dword 125h
        lea eax, [dword edx+0A3h]
        add ebx, eax
        mov ax, word [pucky]
        xor al, 1
        test ax, ax
        jle short .6
        mov edx, awtmstruct
        jmp short .7
.6:
        mov edx, hmtmstruct
.7:
        mov ax, word [pucky]
        mov si, word [byte edx+010h]
        xor al, 1
        test si, si
        jge short .8
        cwde
        mov eax, dword [dword eax+GoalScorerFlags]
        jmp short .11
.8:
        test ax, ax
        jle short .9
        mov eax, awtmstruct
        jmp short .10
.9:
        mov eax, hmtmstruct
.10:
        mov edx, dword [dword eax+0FAh]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov eax, dword [nosplit eax*8+PenaltyRecord]
.11:
        sar eax, 18h
        mov dx, word [pucky]
        xor dl, 1
        test dx, dx
        jle short .12
        mov edx, awtmstruct
        jmp short .13
.12:
        mov edx, hmtmstruct
.13:
        sub eax, byte 19h
        imul eax, dword 125h
        mov edx, dword [dword edx+0108h]
        add edx, 1D42h
        add eax, edx
        push eax
        push ebx
        mov eax, dword [puckx]
        push byte 1
        sar eax, 10h
        push eax
        push dword 0C0000002h
        call PaEvent
        add esp, byte 14h
.14:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; EndPenaltyShot                               33880  95 PC, medium confidence
; Clears penshotmode / penshotlive / penshotplayer, AddPenalty2, restores
; state
;-----------------------------------------------------------------------------
EndPenaltyShot:
        push ebx
        push ecx
        push edx
        push edi
        cmp word [penshotlive], byte 0
        je short .1
        cmp word [penshotmode], byte 0
        je short .1
        mov edi, 0FFFFFFFFh
        mov edx, 3
        mov eax, dword [PtrPuckFlags]
        xor ecx, ecx
        xor ebx, ebx
        mov word [penshotmode], cx
        mov word [penshotlive], cx
        mov word [FaceoffRequest], di
        call AddPenalty2
        mov ax, word [AwayGoalsPeriod]
        mov word [LastPlayerTouch], ax
        mov word [LastTouchTeam], ax
        mov ax, word [HomeGoalsPeriod]
        mov edx, 34h
        mov word [StoppageFlag], ax
        mov word [PassDistY], ax
        mov eax, dword [PtrPuckObject]
        call assreplace
        call EndPenShotScene
.1:
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PenaltyPaCode                                   33904  97 PC, low confidence
; Arena PA event code for a penalty (table PenaltyPaCodes) with its minor /
; major / misconduct bits
;-----------------------------------------------------------------------------
PenaltyPaCode:
        and eax, 0FFh
        mov eax, dword [nosplit eax*4+PenaltyPaCodes]
        cmp dx, byte 2
        jne short .1
        or eax, 10000h
        ret
.1:
        cmp dx, byte 4
        jne short .2
        or eax, 20000h
        ret
.2:
        test bl, bl
        je short .4
        cmp dx, byte 5
        jne short .3
        or eax, 0C0000h
        ret
.3:
        or eax, 80000h
        ret
.4:
        cmp dx, byte 5
        jne short .5
        or eax, 40000h
        ret
.5:
        mov eax, 0FFFFFFFFh
        ret
;-----------------------------------------------------------------------------
; InProgress                                     33950  94G, medium confidence
; the penalty in progress (whistle, box, power play), from
; chkprogress after checkfornewpen
;-----------------------------------------------------------------------------
InProgress:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        xor edx, edx
        mov eax, dword [PtrPuckFlags]
        mov dword [byte ebp-010h], edx
        test byte [dword eax+0C0h], 1
        jne near .56
        mov edx, dword [dword eax+0AEh]
        sar edx, 18h
        cmp byte [dword edx+eax+0B2h], 44h
        je near .56
.1:
        cmp byte [PenaltyPending], 0
        jne near .9
        cmp dword [RefPlayer], byte 0
        jge near .56
        mov edx, hmtmstruct
        xor esi, esi
        mov edi, 200h
.2:
        mov ebx, 1Bh
        mov word [byte edx+0Eh], 6
.3:
        movsx eax, bx
        add eax, eax
        add eax, edx
        mov cl, byte [byte eax+051h]
        test cl, 80h
        jne short .4
        mov ch, cl
        and ch, 0FBh
        mov byte [byte eax+051h], ch
        test ch, 10h
        jne short .4
        test ch, 8
        jne short .4
        test word [byte eax+050h], di
        jne short .4
        mov ax, word [byte edx+0Eh]
        cmp ax, 4
        jle short .4
        mov ecx, eax
        dec ecx
        mov word [byte edx+0Eh], cx
.4:
        dec ebx
        test bx, bx
        jge short .3
        inc esi
        mov edx, awtmstruct
        cmp si, byte 2
        jl short .2
        cmp word [GoalLineFlag], byte 0
        je short .7
        mov di, word [AwPlayersInBox]
        mov ax, word [HmPlayersInBox]
        sub ax, di
        je short .7
        push dword 1000h
        test ax, ax
        jle short .5
        movsx edx, ax
        jmp short .6
.5:
        movsx edx, ax
        neg edx
.6:
        push edx
        test ax, ax
        setl al
        and eax, 0FFh
        push eax
        push dword 0A000001Ch
        call CommentaryEvent
        add esp, byte 10h
        push dword 1F4h
        push byte 0Ch
        call QueueOverlayPanel
        add esp, byte 8
.7:
        and byte [gmode], 0FBh
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [dword eax+0AEh]
        sar edx, 18h
        movsx dx, byte [dword edx+eax+0B2h]
        cmp dx, byte 42h
        je short .8
        cmp dx, byte 43h
        je short .8
        mov edx, 42h
        call assreplace
.8:
        xor ah, ah
        mov byte [RefSignal], ah
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        xor cl, cl
        mov esi, 1
        mov byte [RefSignal], cl
        mov bl, 1
        xor dl, dl
        jmp short .12
.10:
        cmp dl, byte [dword eax+PenaltySlots]
        je short .11
        mov byte [RefSignal], bl
.11:
        inc esi
.12:
        movsx eax, si
        lea eax, [eax+eax*2]
        cmp dl, byte [dword eax+PenaltyPending]
        jne short .10
        dec esi
        movsx edx, si
        lea edx, [edx+edx*2]
        mov al, byte [dword edx+PenaltyTeam]
        test al, 80h
        jne short .13
        and al, 7Fh
        movsx eax, al
        imul eax, dword 108h
        add eax, SortCords
        cmp word [dword eax+0A9h], byte 0
        jge near .56
        xor ah, ah
        mov byte [dword edx+PenaltyTeam], ah
        mov byte [dword edx+PenaltyPending], ah
        mov byte [dword edx+PenaltySlots], ah
        jmp near .1
.13:
        and al, 7Fh
        movsx eax, al
        imul eax, dword 108h
        mov edi, SortCords
        add edi, eax
        test byte [dword edi+0C0h], 1
        jne near .56
        mov bl, byte [dword edx+PenaltyTeam]
        and bl, 7Fh
        mov al, byte [dword edx+PenaltyPending]
        mov byte [dword edx+PenaltyTeam], bl
        mov byte [byte ebp-04h], al
        mov eax, dword [dword edi+0FEh]
        mov bh, byte [byte ebp-04h]
        mov dword [byte ebp-08h], eax
        cmp bh, 22h
        jne near .15
        call SetupPenaltyShot
        xor al, al
        mov byte [dword edx+PenaltySlots], al
        mov byte [dword edx+PenaltyTeam], al
        mov byte [dword edx+PenaltyPending], al
        xor ah, ah
        mov al, bh
        cmp ax, 3
        je short .14
        mov ecx, 1
        mov word [BreakawayFlag], ax
        mov dword [RefTarget], ecx
        cmp ax, 7
        sete al
        and eax, 0FFh
        add eax, byte 36h
        movsx edx, ax
        mov eax, dword [PtrPuckObject]
        call assreplace
.14:
        mov eax, dword [penshottimer]
        sar eax, 10h
        push eax
        push dword 1F4h
        push byte 0Bh
        mov esi, 320h
        call QueueOverlayPanel
        add esp, byte 0Ch
        mov dword [RefPlayer], esi
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.15:
        cmp byte [dword edx+PenaltySlots], 0
        je near .20
        cmp bh, 0Eh
        jb near .19
        cmp dword [ReplayPlaying], byte 0
        jne near .19
        cmp bh, 1Dh
        jne short .16
        mov dx, word [ProgressLimit]
        mov ax, word [str_Punct_InProgress]
        or dl, 11h
        or al, 10h
        jmp short .18
.16:
        xor eax, eax
        mov al, bh
        mov ebx, dword [dword edx+ProgressRecord]
        sar ebx, 18h
        and bl, 0EFh
        sub eax, byte 0Ch
        mov cx, word [nosplit ebx*2+ProgressTimes]
        mov bl, byte [dword edx+PenaltySlots]
        or eax, ecx
        test bl, 10h
        je short .17
        mov edx, 81h
        jmp short .18
.17:
        xor edx, edx
.18:
        movsx edx, dx
        cwde
        mov ecx, dword [dword edi+0A3h]
        mov bh, byte [dword edi+0BFh]
        push edx
        sar ecx, 18h
        push eax
        test bh, 40h
        setne al
        xor ebx, ebx
        mov edx, dword [PuckOwnerTeam]
        mov bl, al
        mov eax, dword [gsp]
        sar edx, 10h
        sar eax, 10h
        call LogPenalty
.19:
        movsx eax, si
        lea eax, [eax+eax*2]
        mov eax, dword [dword eax+ProgressRecord]
        sar eax, 18h
        push eax
        xor eax, eax
        mov al, byte [byte ebp-04h]
        push eax
        xor eax, eax
        mov al, byte [dword edi+0A4h]
        push eax
        push dword 1F4h
        push byte 4
        call QueueOverlayPanel
        mov eax, 320h
        add esp, byte 14h
        mov dword [RefPlayer], eax
.20:
        movsx eax, si
        lea eax, [eax+eax*2]
        mov cl, byte [dword eax+PenaltySlots]
        test cl, cl
        je short .21
        test cl, 10h
        je near .30
.21:
        movsx eax, si
        lea eax, [eax+eax*2]
        test byte [dword eax+PenaltySlots], 10h
        je near .28
        mov eax, dword [dword edi+0A3h]
        sar eax, 18h
        mov ebx, dword [byte ebp-08h]
        add eax, eax
        add eax, ebx
        mov dx, word [byte eax+050h]
        cmp dx, 8001h
        je short .22
        cmp dx, 8002h
        jne short .24
.22:
        mov cx, word [dword edi+0BAh]
        test cx, cx
        jl short .24
        test byte [dword edi+0BFh], 40h
        je short .23
        mov word [AwayEbenPlayer], cx
        jmp short .24
.23:
        mov word [HomeEbenPlayer], cx
.24:
        mov eax, dword [dword edi+0A3h]
        sar eax, 18h
        mov ecx, dword [byte ebp-08h]
        add eax, eax
        add eax, ecx
        mov edx, 1Ah
        mov word [byte eax+050h], 8005h
        mov eax, edi
        call assreplace
        movsx edx, si
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        test byte [dword eax+PenaltySlots], 7
        jne near .30
        xor cl, cl
        mov byte [dword eax+PenaltyTeam], cl
        mov byte [dword eax+PenaltyPending], cl
        mov byte [dword eax+PenaltySlots], cl
        xor eax, eax
        mov al, byte [byte ebp-04h]
        cmp ax, 3
        je short .25
        mov ebx, 1
        mov word [BreakawayFlag], ax
        mov dword [RefTarget], ebx
        cmp ax, 7
        sete al
        and eax, 0FFh
        add eax, byte 36h
        movsx edx, ax
        mov eax, dword [PtrPuckObject]
        call assreplace
.25:
        movsx edx, si
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov al, byte [dword eax+PenaltySlots]
        xor ebx, ebx
        and al, 10h
        mov bl, al
        xor eax, eax
        sar edx, 10h
        mov al, byte [byte ebp-04h]
        call PenaltyPaCode
        mov ebx, eax
        test eax, eax
        jl near .56
        cmp word [dword edi+0A9h], byte 0
        jne short .26
        mov eax, dword [dword edi+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul edx, eax, dword 125h
        mov eax, dword [byte ebp-08h]
        mov eax, dword [dword eax+0108h]
        add eax, 1D42h
        jmp short .27
.26:
        mov edx, dword [dword edi+0A3h]
        sar edx, 18h
        imul edx, dword 125h
        mov eax, dword [byte ebp-08h]
        mov eax, dword [dword eax+0108h]
        add eax, 0A3h
.27:
        add eax, edx
        push ebx
        push eax
        mov ch, byte [dword edi+0BFh]
        push byte 1
        test ch, 40h
        setne al
        and eax, 0FFh
        push eax
        push dword 0C0000003h
        call PaEvent
        add esp, byte 14h
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.28:
        xor dh, dh
        mov byte [dword eax+PenaltyTeam], dh
        mov byte [dword eax+PenaltyPending], dh
        mov si, word [GoalLineFlag]
        mov byte [dword eax+PenaltySlots], dh
        test si, si
        je short .29
        cmp byte [byte ebp-04h], 7
        jne near .1
.29:
        xor eax, eax
        mov al, byte [byte ebp-04h]
        cmp ax, 3
        je near .56
        mov edx, 1
        mov word [BreakawayFlag], ax
        mov dword [RefTarget], edx
        jmp near .55
.30:
        movsx edx, si
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov al, byte [dword eax+PenaltySlots]
        and al, 7
        cmp al, 2
        jb short .31
        jbe short .32
        cmp al, 4
        je short .33
        jmp short .34
.31:
        cmp al, 1
        jne short .34
        mov al, byte [byte ebp-04h]
        mov ecx, 2
        cmp al, 1Dh
        jne short .35
        mov ecx, 7
        jmp short .35
.32:
        mov ecx, 4
        jmp short .35
.33:
        mov ecx, 5
        jmp short .35
.34:
        mov ecx, 0FFFFFFFFh
.35:
        cmp dword [ReplayPlaying], byte 0
        jne near .39
        mov eax, dword [byte ebp-08h]
        mov eax, dword [dword eax+0108h]
        inc word [dword eax+020D3h]
        mov eax, dword [byte ebp-08h]
        mov eax, dword [dword eax+0108h]
        add word [dword eax+020D5h], cx
        cmp byte [dword edi+0A6h], 19h
        jge short .36
        mov eax, dword [dword edi+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        mov edx, dword [byte ebp-08h]
        mov edx, dword [dword edx+0108h]
        add word [dword edx+eax+01A4h], cx
.36:
        mov dl, byte [byte ebp-04h]
        cmp dl, 1Dh
        je near .39
        cmp dl, 0Eh
        jb near .39
        cmp dl, 22h
        jae near .39
        movsx edx, si
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov al, byte [dword eax+PenaltySlots]
        xor ebx, ebx
        and al, 10h
        mov bl, al
        xor eax, eax
        mov al, byte [byte ebp-04h]
        movsx edx, cx
        call PenaltyPaCode
        mov ebx, eax
        test eax, eax
        jl short .39
        cmp word [dword edi+0A9h], byte 0
        jne short .37
        mov eax, dword [dword edi+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul edx, eax, dword 125h
        mov eax, dword [byte ebp-08h]
        mov eax, dword [dword eax+0108h]
        add eax, 1D42h
        jmp short .38
.37:
        mov eax, dword [dword edi+0A3h]
        sar eax, 18h
        imul edx, eax, dword 125h
        mov eax, dword [byte ebp-08h]
        mov eax, dword [dword eax+0108h]
        add eax, 0A3h
.38:
        add eax, edx
        push ebx
        push eax
        mov bh, byte [dword edi+0BFh]
        push byte 1
        test bh, 40h
        setne al
        and eax, 0FFh
        push eax
        push dword 0C0000003h
        call PaEvent
        add esp, byte 14h
.39:
        imul ecx, byte 3Ch
        cmp cx, 12Ch
        jl short .40
        or ch, 40h
        jmp short .41
.40:
        cmp cx, 0F0h
        jne short .41
        or ch, 20h
.41:
        mov dx, word [dword edi+0BAh]
        or ch, 4
        test dx, dx
        jl short .43
        test byte [dword edi+0BFh], 40h
        je short .42
        mov word [AwayEbenPlayer], dx
        jmp short .43
.42:
        mov word [HomeEbenPlayer], dx
.43:
        cmp word [dword edi+0A9h], byte 0
        je short .44
        mov eax, dword [dword edi+0A3h]
        sar eax, 18h
        mov edx, dword [byte ebp-08h]
        add eax, eax
        add eax, edx
        mov dx, word [byte eax+050h]
        cmp dx, 8001h
        je short .45
        cmp dx, 8002h
        je short .45
.44:
        mov eax, edi
        call SumOnIceRatings
        mov edx, eax
        mov dword [byte ebp-010h], eax
        test eax, eax
        je near .56
        movsx eax, si
        mov dword [byte ebp-014h], eax
        mov ebx, dword [byte ebp-014h]
        shl eax, 2
        sub eax, ebx
        mov bl, byte [dword eax+PenaltyTeam]
        mov dl, byte [dword edx+0A4h]
        and bl, 80h
        or dl, bl
        mov byte [dword eax+PenaltyTeam], dl
.45:
        mov eax, dword [byte ebp-010h]
        test eax, eax
        je short .46
        mov edi, eax
.46:
        mov eax, dword [dword edi+0A3h]
        sar eax, 18h
        mov edx, dword [byte ebp-08h]
        add eax, eax
        add eax, edx
        mov word [byte eax+050h], cx
        mov eax, dword [dword edi+0102h]
        movsx edx, si
        mov dword [byte ebp-0Ch], eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov dl, byte [dword eax+PenaltySlots]
        and ch, 0FDh
        cmp dl, 1
        jne short .47
        mov eax, dword [byte ebp-08h]
        cmp byte [dword eax+088h], 0
        jge short .47
        mov eax, dword [byte ebp-0Ch]
        cmp byte [dword eax+088h], 0
        jl short .47
        cmp byte [dword eax+089h], 0
        jge short .47
        test si, si
        jle near .52
.47:
        mov eax, esi
        dec eax
        test si, si
        jle short .49
        xor eax, eax
        test si, si
        jle short .49
.48:
        movsx edx, ax
        lea edx, [edx+edx*2]
        mov bh, byte [dword edx+PenaltySlots]
        cmp bh, 1
        je short .49
        cmp bh, 2
        je short .49
        cmp bh, 4
        je short .49
        inc eax
        cmp ax, si
        jl short .48
.49:
        cmp ax, si
        jge short .52
        mov eax, 1Bh
.50:
        movsx ebx, ax
        mov edx, dword [byte ebp-0Ch]
        add ebx, ebx
        add ebx, edx
        mov dx, word [byte ebx+050h]
        and dh, 0FDh
        cmp dx, cx
        jne short .51
        or byte [byte ebx+051h], 10h
        mov eax, dword [dword edi+0A3h]
        sar eax, 18h
        mov ebx, dword [byte ebp-08h]
        add eax, eax
        add eax, ebx
        or byte [byte eax+051h], 10h
        jmp short .52
.51:
        dec eax
        test ax, ax
        jg short .50
.52:
        mov ecx, dword [byte ebp-08h]
        xor eax, eax
.53:
        movsx edx, ax
        add edx, ecx
        cmp byte [dword edx+088h], 0
        jl short .54
        inc eax
        cmp ax, 1Ch
        jl short .53
.54:
        mov esi, dword [byte ebp-08h]
        cwde
        add eax, esi
        mov dl, byte [dword edi+0A6h]
        mov byte [dword eax+089h], 0FFh
        mov byte [dword eax+088h], dl
        mov edx, 12h
        mov eax, edi
        call assreplace
        xor eax, eax
        mov al, byte [byte ebp-04h]
        cmp ax, 3
        je short .56
        mov edi, 1
        mov word [BreakawayFlag], ax
        mov dword [RefTarget], edi
.55:
        cmp ax, 7
        sete al
        and eax, 0FFh
        add eax, byte 36h
        movsx edx, ax
        mov eax, dword [PtrPuckObject]
        call assreplace
.56:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
InProgress_8B2:
        mov edx, dword [ProgressCount]
        dec edx
        mov dword [ProgressCount], edx
        test edx, edx
        jge near InProgress_96E
        mov edi, esi
        xor ecx, ecx
        dec edi
        mov dword [ProgressCount], ecx
        mov word [PenCntDwn], di
        test di, di
        jge near InProgress_96E
        mov bl, byte [gmode]
        mov eax, 0FFFFFFFDh
        and bl, 0F7h
        xor edx, edx
        mov byte [gmode], bl
.57:
        mov ebx, edx
        add eax, byte 3
        mov cl, byte [dword ebx+PenaltyPending]
        add edx, byte 3
        test cl, cl
        je short InProgress_96E
        cmp byte [dword eax+PenaltySlots], 0
        je short .57
        mov al, byte [PlayFlags]
        mov edx, 0FFFFFFFFh
        or al, 4
        mov ebx, 1
        mov byte [PlayFlags], al
        mov eax, dword [PtrPuckZone]
        mov word [ProgressTimer], dx
        mov word [GoalLineFlag], bx
        mov byte [eax], 0FFh
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [dword eax+0AEh]
        sar edx, 18h
        cmp byte [dword edx+eax+0B2h], 41h
        jne short .58
        mov edx, 40h
        call assinsert
.58:
        mov eax, dword [DelayedPen]
        sar eax, 10h
        call RemoveOverlayPanel
InProgress_96E:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; chkprogress                    342C4  93G penalty93_1.asm, medium confidence
;
; (fall-through from PenaltyManager): with gmpen (gmode bit 2): Pencntdwn >= 0 ->
; chkprogress_go, else InProgress; PC first (clock stopped) calls UpdateTextOverlay and counts Pencntdwn2
; down to set gmode2 bit 2
;-----------------------------------------------------------------------------
chkprogress:
        call updatepentime
        call checkfornewpen
        LD mov, eax, eax
        push ebx
        push ecx
        push edx
        push esi
        push edi
        test byte [gmode], 1
        je short InProgress_96E
        mov dx, word [ProgressTimer]
        test dx, dx
        jl short .1
        mov ebx, edx
        dec ebx
        mov word [ProgressTimer], bx
        test bx, bx
        jge short .1
        or byte [PlayFlags], 4
.1:
        test byte [gmode], 4
        je short InProgress_96E
        mov si, word [PenCntDwn]
        test si, si
        jge near InProgress_8B2
        call InProgress
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
