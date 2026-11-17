; Assignment logic: goalie position, faceoff spots, waits, the crease, goalie, defence and forward roles.
bits 32
%include "hockey.inc"
section s_1FBF3 progbits alloc exec nowrite align=1
extern __CHP, AddPenalty, AddPenalty2, AimAtPuckTarget, AIPassDecision, AngleOfVector, AssistOne, AssistTwo
extern assreplace, AwayGoalieOff, AwayGoalsPeriod, AwCoachDefense, AwCoachOffense, AwLineState, awtmstruct, BuildPassTargets
extern check4bench, ChkPokeOrCheck, ChkSwapWithPartner, CommentaryEvent, CosInterp, CreaseBounds, DefendFlags, DefendTarget
extern doplayeracc, EndPenaltyShot, ExtraAttacker, ExtraAttackerFlags, ExtraAttackerSpots, F32_1272, F32_192, F32_4032
extern F32_4272_InCrease, F32_48, F32_768, F32_neg3984, F32_neg4272_InCrease, F64_0p159155_GoaliePosTarget, F64_0p25, F64_0p392699_GoaliePosTarget
extern F64_288, F64_3p14159_Endfaceoff, F64_3p14159_GoaliePosTarget, F64_65536_GoaliePosTarget, F64_6p28319_GoaliePosTarget, F64_neg0p392699, F64_neg3p14159_GoaliePosTarget, F64_neg6p28319_GoaliePosTarget
extern FaceDirFromMotion, FaceoffDrawAnim, FaceoffMoveResult, FaceoffRequest, FaceoffSpot, apl, FaceoffSpotX, FaceoffSpotY
extern FaceoffSwipeAnim, FaceoffWinner, FaceoffZone, fofdata2, gameopts, gameover, GetDefensePartner, gmode
extern GoalCameraScene, GoalCrowdCheer, GoalFlags, goalieflags, GoalieMoves, GoalieOut, GoalieTarget, GoalLineY
extern GoalScorer, GoalScorerFlags, GoalState, gsp, HmCoachDefense, HmCoachOffense, HmLineState, hmtmstruct
extern holdreset, HomeGoalieOff, HomeGoalsPeriod, HomeTeamRecord, hypot_, IF@ATAN2, IF@DFMOD, LastPlayerTouch
extern LastTouchPlayer, LastTouchTeam, LogGoal, ObjectFramePos, onetimerplayer, OneTimerReady, OneTimerTarget, PassDistY
extern PassPending, PassPlayer, PassReceiver, PenBuf, PenaltyRecord, PenaltyTeam, PenGoalStuff, penshotlive
extern penshotmode, PeriodAwayTeam, PeriodHomeTeam, PickBenchSeat, PickSkateAnim, PlayerAssignWords, gmode2, PtrPuckFlags
extern PtrPuckObject, PtrPuckOwner, PtrPuckState, PtrPuckTarget, puckc, PuckOwner, PuckOwnerTeam, pucky
extern randomd0, regd1, RemoveOverlayPanel, ReplayPlaying, ResetAnimTimer, ResetRenderTimers, RestartGameMusic, SetCrowdMood
extern SetFaceBlink, SetFaceExpression, SetFaceMouth, SetFaceoffEndFlag, SetSkateSpeedFromRating, SetSPA, ShootSpotX, ShootSpotY
extern SimFrames, SinInterp, SortCords, StartCrowdMusic, StartGoalieSave, StartGoalieStance, StatsPanelOn, StatsPanelPlayer
extern StopObject, StoppageFlag, SwapPosition, tickcount, TriggerCameraFlashes, UpdateCoachModes, vtoa, ZoneFlags
extern ZoneTargetX, ZoneTargetY
global GoaliePosTarget, FaceoffSpotPosition, Endfaceoff, AssNoop, assnull, assbenchwait, DelayedPenaltyEnd, ChkTeamPlayerFlag
global Goal, InCrease, UpdateCreaseFlag, FindCreasePlayer, assgoalie, KeepInsideRink, DefendPuck, assextra4
global assdefo, asswingo, asscentero, FindManToCover, assextra3, assdefd, asswingd, asscenterd
global asstofaceoff, assfaceoff, assfaceoffpl
        db 090h
;-----------------------------------------------------------------------------
; GoaliePosTarget                                 1FBF4  97 PC, low confidence
; Works out where the goalie stands: on the line between the puck and the
; middle of the goal, kept inside the crease
;-----------------------------------------------------------------------------
GoaliePosTarget:
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 40h
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov dword [byte esp+010h], edx
        xor edx, edx
        mov word [ZoneTargetY], dx
        test byte [dword eax+0BFh], 80h
        jne short .1
        mov eax, 10B0h
        jmp short .2
.1:
        mov eax, 0FFFFEF50h
.2:
        mov word [regd1], ax
        test byte [dword esi+0BFh], 80h
        jne short .3
        cmp ebx, 10B0h
        jg short .4
.3:
        test byte [dword esi+0BFh], 80h
        je short .5
        cmp ebx, 0FFFFEF50h
        jge short .5
.4:
        mov eax, 90h
        mov edi, dword [byte esp+010h]
        mov word [ZoneTargetY], ax
        test edi, edi
        jge near .17
        mov word [ZoneTargetY], 0FF70h
        jmp near .17
.5:
        mov eax, dword [ZoneFlags]
        sar eax, 10h
        mov edi, eax
        xor edi, ebx
        test edi, edi
        jl near .15
        mov edi, ebx
        sub edi, eax
        mov eax, edi
        test edi, edi
        jge short .6
        neg eax
.6:
        sar eax, 3
        cmp eax, 1E0h
        jge short .8
        mov eax, dword [ZoneFlags]
        mov edi, ebx
        sar eax, 10h
        sub edi, eax
        mov eax, edi
        test edi, edi
        jge short .7
        neg eax
.7:
        sar eax, 3
        jmp short .9
.8:
        mov eax, 1E0h
.9:
        cmp eax, 90h
        jle short .13
        mov eax, dword [ZoneFlags]
        mov edi, ebx
        sar eax, 10h
        sub edi, eax
        mov eax, edi
        test edi, edi
        jge short .10
        neg eax
.10:
        sar eax, 3
        cmp eax, 1E0h
        jge short .12
        mov eax, dword [ZoneFlags]
        mov edi, ebx
        sar eax, 10h
        sub edi, eax
        mov eax, edi
        test edi, edi
        jge short .11
        neg eax
.11:
        sar eax, 3
        jmp short .14
.12:
        mov eax, 1E0h
        jmp short .14
.13:
        mov eax, 90h
.14:
        mov edi, eax
        jmp short .16
.15:
        mov edi, 180h
.16:
        mov eax, dword [ZoneFlags]
        mov edx, ebx
        sar eax, 10h
        sub edx, eax
        mov eax, dword [ZoneTargetX]
        push edx
        mov edx, dword [byte esp+014h]
        sar eax, 10h
        sub edx, eax
        push edx
        call AngleOfVector
        mov dword [byte esp+010h], eax
        add esp, byte 8
        push eax
        call SinInterp
        add esp, byte 4
        mov edx, eax
        mov eax, edi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        add word [ZoneTargetY], ax
        mov ecx, dword [byte esp+08h]
        push ecx
        call CosInterp
        add esp, byte 4
        mov edx, eax
        mov eax, edi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        add word [regd1], ax
.17:
        mov eax, dword [dword esi+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword esi+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword esi+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, esi
        call SetSkateSpeedFromRating
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+024h], 42C80000h
        mov eax, dword [ZoneTargetX]
        mov edx, dword [byte esp+010h]
        sar eax, 10h
        sub edx, eax
        mov eax, dword [ZoneFlags]
        sar eax, 10h
        sub ebx, eax
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        fild dword [byte esp+0Ch]
        fild dword [byte esp+08h]
        call IF@ATAN2
        mov eax, dword [dword esi+0EEh]
        fstp dword [byte esp+03Ch]
        mov edx, dword [byte esp+03Ch]
        mov dword [byte eax+014h], edx
        test byte [dword esi+0BFh], 80h
        jne short .18
        fld dword [byte esp+03Ch]
        fld st0
        fadd qword [F64_3p14159_GoaliePosTarget]
        fstp st1
        fstp dword [byte esp+03Ch]
.18:
        fld qword [F64_6p28319_GoaliePosTarget]
        fld dword [byte esp+03Ch]
        call IF@DFMOD
        fst dword [byte esp+03Ch]
        fst qword [byte esp+014h]
        fcomp qword [F64_3p14159_GoaliePosTarget]
        fnstsw ax
        sahf
        jbe short .19
        fld qword [byte esp+014h]
        fadd qword [F64_neg6p28319_GoaliePosTarget]
        fstp dword [byte esp+03Ch]
.19:
        fld dword [byte esp+03Ch]
        fst qword [byte esp+01Ch]
        fcomp qword [F64_neg3p14159_GoaliePosTarget]
        fnstsw ax
        sahf
        jae short .20
        fld qword [byte esp+01Ch]
        fadd qword [F64_6p28319_GoaliePosTarget]
        fstp dword [byte esp+03Ch]
.20:
        fld dword [byte esp+03Ch]
        fst qword [byte esp+024h]
        fcomp qword [F64_0p392699_GoaliePosTarget]
        fnstsw ax
        sahf
        jbe short .21
        mov dword [byte esp+03Ch], 3EC90FDBh
        jmp short .22
.21:
        fld qword [byte esp+024h]
        fcomp qword [F64_neg0p392699]
        fnstsw ax
        sahf
        jae short .22
        mov dword [byte esp+03Ch], 0BEC90FDBh
.22:
        test byte [dword esi+0BFh], 80h
        jne short .23
        fld dword [byte esp+03Ch]
        fld st0
        fadd qword [F64_3p14159_GoaliePosTarget]
        fstp st1
        fstp dword [byte esp+03Ch]
.23:
        fld qword [F64_6p28319_GoaliePosTarget]
        fld dword [byte esp+03Ch]
        call IF@DFMOD
        fst dword [byte esp+03Ch]
        fst qword [byte esp+02Ch]
        fcomp qword [F64_3p14159_GoaliePosTarget]
        fnstsw ax
        sahf
        jbe short .24
        fld qword [byte esp+02Ch]
        fadd qword [F64_neg6p28319_GoaliePosTarget]
        fstp dword [byte esp+03Ch]
.24:
        fld dword [byte esp+03Ch]
        fst qword [byte esp+034h]
        fcomp qword [F64_neg3p14159_GoaliePosTarget]
        fnstsw ax
        sahf
        jae short .25
        fld qword [byte esp+034h]
        fadd qword [F64_6p28319_GoaliePosTarget]
        fstp dword [byte esp+03Ch]
.25:
        fld dword [byte esp+03Ch]
        fmul qword [F64_0p159155_GoaliePosTarget]
        fmul qword [F64_65536_GoaliePosTarget]
        call __CHP
        fistp dword [byte esp+0Ch]
        mov eax, dword [byte esp+0Ch]
        and eax, 0FFFFh
        mov dword [byte esp+0Ch], eax
        mov eax, dword [dword esi+0EEh]
        fild dword [byte esp+0Ch]
        fstp dword [byte eax+010h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FaceoffSpotPosition                             1FF5C  97 PC, low confidence
; Sets the spot a player takes at a faceoff from his position and the faceoff
; dot (table of offsets per position)
;-----------------------------------------------------------------------------
FaceoffSpotPosition:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 4
        mov esi, eax
        mov dx, word [dword esi+0A9h]
        mov eax, dword [dword eax+0FEh]
        mov word [regd1], dx
        mov dx, word [byte eax+0Eh]
        mov word [ShootSpotY], dx
        neg edx
        mov word [ShootSpotY], dx
        mov edx, dword [ShootSpotX]
        sar edx, 10h
        cmp edx, byte 0FFFFFFFAh
        jle short .1
        cmp word [byte eax+010h], byte 0
        jge short .1
        dec word [ShootSpotY]
.1:
        mov dx, word [ShootSpotY]
        add edx, byte 6
        shl edx, 3
        mov word [ShootSpotY], dx
        mov ebx, dword [ShootSpotX]
        mov edx, dword [ZoneFlags]
        sar ebx, 10h
        sar edx, 10h
        mov dl, byte [dword edx+ebx+apl]
        xor dh, dh
        mov word [ShootSpotY], dx
        add edx, edx
        mov word [ShootSpotY], dx
        mov edx, dword [ShootSpotX]
        sar edx, 10h
        mov bx, word [nosplit edx*2+FaceoffSpotX]
        mov dx, word [nosplit edx*2+FaceoffSpotY]
        mov word [ZoneTargetY], bx
        mov word [regd1], dx
        test byte [dword esi+0BFh], 80h
        jne short .2
        mov dx, word [regd1]
        mov edi, ebx
        neg edx
        neg edi
        mov word [regd1], dx
        mov word [ZoneTargetY], di
.2:
        cmp word [dword esi+0A9h], byte 0
        je near .41
        cmp word [FaceoffSpot], byte 0
        jge short .3
        mov edx, dword [StatsPanelOn]
        sar edx, 10h
        neg edx
        jmp short .4
.3:
        mov edx, dword [StatsPanelOn]
        sar edx, 10h
.4:
        cmp edx, 420h
        jne near .37
        cmp word [FaceoffZone], byte 0
        jge short .5
        mov edx, dword [FaceoffSpot]
        sar edx, 10h
        neg edx
        jmp short .6
.5:
        mov edx, dword [FaceoffSpot]
        sar edx, 10h
.6:
        cmp edx, 0CF0h
        jne near .37
        mov dx, word [ShootSpotY]
        cmp dx, byte 6
        je short .7
        cmp dx, byte 0Ah
        jne near .12
.7:
        cmp word [regd1], byte 0
        jge short .8
        mov edx, 0FFFFFFA0h
        jmp short .9
.8:
        mov edx, 60h
.9:
        mov bx, word [ZoneTargetY]
        mov word [regd1], dx
        test bx, bx
        setg dl
        xor ebx, ebx
        mov cx, word [FaceoffSpot]
        mov bl, dl
        test cx, cx
        setg dl
        and edx, 0FFh
        xor edx, ebx
        je near .40
        test byte [dword esi+0BFh], 80h
        setne dl
        mov ebx, edx
        mov di, word [FaceoffZone]
        and ebx, 0FFh
        test di, di
        setg dl
        and edx, 0FFh
        xor edx, ebx
        je near .40
        cmp word [byte eax+010h], byte 0
        setge dl
        mov eax, dword [byte eax+0Ch]
        and edx, 0FFh
        sar eax, 10h
        sub eax, edx
        cmp eax, byte 3
        jle near .40
        cmp word [ZoneTargetY], byte 0
        jge short .10
        mov edx, 0FFFFFF70h
        jmp short .11
.10:
        mov edx, 90h
.11:
        mov eax, dword [ZoneTargetX]
        sar eax, 10h
        add eax, edx
        jmp near .39
.12:
        cmp dx, byte 4
        jg near .40
        cmp word [ZoneTargetY], byte 0
        setg dl
        mov ebx, edx
        mov cx, word [FaceoffSpot]
        and ebx, 0FFh
        test cx, cx
        setg dl
        and edx, 0FFh
        xor edx, ebx
        je near .22
        test byte [dword esi+0BFh], 80h
        setne al
        mov bx, word [FaceoffZone]
        and eax, 0FFh
        test bx, bx
        setg dl
        and edx, 0FFh
        xor eax, edx
        je short .17
        test cx, cx
        jle short .13
        mov eax, 0FFFFFD18h
        jmp short .14
.13:
        mov eax, 2E8h
.14:
        mov di, word [FaceoffZone]
        mov word [ZoneTargetY], ax
        test di, di
        jle short .15
        mov eax, 0A8h
        jmp short .16
.15:
        mov eax, 0FFFFFF58h
.16:
        mov word [regd1], ax
        jmp near .40
.17:
        test cx, cx
        jle short .18
        mov eax, 78h
        jmp short .19
.18:
        mov eax, 0FFFFFF88h
.19:
        mov di, word [FaceoffZone]
        mov word [ZoneTargetY], ax
        test di, di
        jle short .20
        mov eax, 750h
        jmp short .21
.20:
        mov eax, 0FFFFF8B0h
.21:
        mov dx, word [ZoneTargetY]
        mov word [regd1], ax
        mov ax, word [FaceoffSpot]
        mov bx, word [regd1]
        sub edx, eax
        sub bx, word [FaceoffZone]
        mov word [ZoneTargetY], dx
        mov word [regd1], bx
        jmp near .40
.22:
        mov dh, byte [dword esi+0BFh]
        xor ebx, ebx
        test dh, 80h
        setne dl
        mov di, word [FaceoffZone]
        mov bl, dl
        test di, di
        setg dl
        and edx, 0FFh
        xor edx, ebx
        je near .32
        cmp word [byte eax+010h], byte 0
        setge dl
        mov eax, dword [byte eax+0Ch]
        and edx, 0FFh
        sar eax, 10h
        sub eax, edx
        cmp eax, byte 6
        jne short .27
        test cx, cx
        jle short .23
        mov eax, 0F0h
        jmp short .24
.23:
        mov eax, 0FFFFFF10h
.24:
        mov cx, word [FaceoffZone]
        mov word [ZoneTargetY], ax
        test cx, cx
        jge short .25
        mov eax, 0FFFFF028h
        jmp short .26
.25:
        mov eax, 0FD8h
.26:
        mov di, word [ZoneTargetY]
        mov word [regd1], ax
        mov ax, word [FaceoffSpot]
        mov dx, word [regd1]
        sub edi, eax
        sub dx, word [FaceoffZone]
        mov word [ZoneTargetY], di
        mov word [regd1], dx
        jmp near .40
.27:
        test cx, cx
        jle short .28
        mov eax, 0FFFFFF88h
        jmp short .29
.28:
        mov eax, 78h
.29:
        mov dx, word [FaceoffZone]
        mov word [ZoneTargetY], ax
        test dx, dx
        jle short .30
        mov eax, 2E8h
        jmp short .31
.30:
        mov eax, 0FFFFFD18h
.31:
        mov word [regd1], ax
        jmp near .40
.32:
        test cx, cx
        jle short .33
        mov eax, 618h
        jmp short .34
.33:
        mov eax, 0FFFFF9E8h
.34:
        mov dx, word [FaceoffZone]
        mov word [ZoneTargetY], ax
        test dx, dx
        jle short .35
        mov eax, 750h
        jmp short .36
.35:
        mov eax, 0FFFFF8B0h
.36:
        mov bx, word [ZoneTargetY]
        mov word [regd1], ax
        mov ax, word [FaceoffSpot]
        mov cx, word [regd1]
        sub ebx, eax
        sub cx, word [FaceoffZone]
        mov word [ZoneTargetY], bx
        mov word [regd1], cx
        jmp short .40
.37:
        cmp word [ShootSpotY], byte 4
        jg short .40
        mov eax, dword [ZoneTargetX]
        mov edx, dword [StatsPanelOn]
        sar eax, 10h
        sar edx, 10h
        xor eax, edx
        test eax, eax
        jge short .38
        mov edx, dword [FaceoffSpot]
        mov eax, dword [ZoneFlags]
        sar edx, 10h
        sar eax, 10h
        sar edx, 3
        sub eax, edx
        mov word [regd1], ax
.38:
        mov edx, dword [StatsPanelOn]
        mov eax, dword [ZoneTargetX]
        sar edx, 10h
        sar eax, 10h
        sar edx, 2
        sub eax, edx
.39:
        mov word [ZoneTargetY], ax
.40:
        mov ax, word [FaceoffSpot]
        mov di, word [ZoneTargetY]
        mov dx, word [regd1]
        add edi, eax
        add dx, word [FaceoffZone]
        mov word [ZoneTargetY], di
        mov word [regd1], dx
        mov eax, dword [dword esi+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword esi+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword esi+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [FaceoffSpot]
        mov edx, dword [ZoneFlags]
        sar eax, 10h
        sar edx, 10h
        sub eax, edx
        mov edx, dword [StatsPanelOn]
        push eax
        mov eax, dword [ZoneTargetX]
        sar edx, 10h
        sar eax, 10h
        sub edx, eax
        push edx
        call AngleOfVector
        mov dword [byte esp+08h], eax
        add esp, byte 8
        mov eax, dword [dword esi+0EEh]
        fild dword [esp]
        fstp dword [byte eax+010h]
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+014h], 0
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, esi
        call SetSkateSpeedFromRating
        jmp short .42
.41:
        mov ebx, dword [FaceoffSpot]
        mov edx, dword [StatsPanelOn]
        mov eax, esi
        sar ebx, 10h
        sar edx, 10h
        call GoaliePosTarget
.42:
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+024h], 42480000h
        add esp, byte 4
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; Endfaceoff                         20508  94G logic94.asm, medium confidence
; From puckfaceoff2: decides the faceoff (randomd0 21h / 0Ah),
; gives the puck assignment 41h (pucknorm) and the referee 31h (assreffollow)
;-----------------------------------------------------------------------------
Endfaceoff:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov edi, eax
        cmp dword [ReplayPlaying], byte 0
        jne short .1
        xor eax, eax
        call ResetRenderTimers
.1:
        call RestartGameMusic
        mov eax, 501h
        call RemoveOverlayPanel
        mov eax, 601h
        call RemoveOverlayPanel
        mov dl, byte [gmode]
        mov ebx, SortCords
        and dl, 0FEh
        xor ecx, ecx
        mov byte [gmode], dl
        mov dh, byte [holdreset]
        mov ah, byte [gmode2]
        or dh, 10h
        and ah, 0FAh
        mov byte [holdreset], dh
        mov dx, word [PlayerAssignWords]
        mov byte [gmode2], ah
        cmp dx, byte 4
        je short .3
.2:
        inc ecx
        add ebx, 108h
        cmp ecx, byte 6
        jge short .3
        cmp word [dword ebx+0A9h], byte 4
        jne short .2
.3:
        mov ecx, HomeTeamRecord+420h
        mov ax, word [HomeTeamRecord+4C9h]
        xor esi, esi
        cmp ax, 4
        je short .5
.4:
        inc esi
        add ecx, 108h
        cmp esi, byte 6
        jge short .5
        cmp word [dword ecx+0A9h], byte 4
        jne short .4
.5:
        mov eax, dword [dword ebx+0F6h]
        mov ebp, dword [dword ecx+0F6h]
        mov eax, dword [eax]
        mov ebp, dword [byte ebp+00h]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte eax+028h]
        mov esi, dword [byte ebp+028h]
        and eax, 0FFFFh
        and esi, 0FFFFh
        cmp eax, byte 41h
        jl short .8
        cmp eax, byte 43h
        jg short .8
        mov edx, esp
        call FaceoffMoveResult
        mov edx, dword [byte esp+0Ch]
        mov eax, dword [esp]
        sub eax, dword [byte edx+04h]
        test eax, eax
        jge short .6
        neg eax
.6:
        mov edx, dword [esp]
        sub edx, eax
        mov dword [byte esp+010h], edx
        test edx, edx
        jge short .7
        xor edx, edx
        mov dword [byte esp+010h], edx
        jmp short .10
.7:
        cmp edx, byte 10h
        jle short .10
        mov dword [byte esp+010h], 10h
        jmp short .10
.8:
        xor eax, eax
        mov dword [esp], eax
        mov dword [byte esp+010h], eax
        test byte [dword ebx+0BFh], 80h
        je short .9
        xor edx, edx
        mov word [FaceoffWinner], dx
        jmp short .10
.9:
        xor eax, eax
        mov word [fofdata2], ax
.10:
        cmp esi, byte 41h
        jl short .13
        cmp esi, byte 43h
        jg short .13
        lea edx, [byte esp+08h]
        mov eax, esi
        call FaceoffMoveResult
        mov eax, dword [byte esp+08h]
        sub eax, dword [byte ebp+04h]
        test eax, eax
        jge short .11
        neg eax
.11:
        mov edx, dword [byte esp+08h]
        sub edx, eax
        test edx, edx
        jge short .12
        xor edx, edx
        jmp short .15
.12:
        cmp edx, byte 10h
        jle short .15
        mov edx, 10h
        jmp short .15
.13:
        xor edx, edx
        mov dword [byte esp+08h], edx
        test byte [dword ecx+0BFh], 80h
        je short .14
        xor eax, eax
        mov word [FaceoffWinner], ax
        jmp short .15
.14:
        xor esi, esi
        mov word [fofdata2], si
.15:
        mov eax, 10h
        sub eax, dword [byte esp+010h]
        add eax, edx
        mov word [GoalieTarget], ax
        xor eax, eax
        movzx si, byte [dword ebx+0D1h]
        mov al, byte [dword ecx+0D1h]
        sub eax, esi
        mov si, word [GoalieTarget]
        add esi, eax
        mov eax, 21h
        mov word [GoalieTarget], si
        call randomd0
        cmp ax, word [GoalieTarget]
        jge short .16
        sar edx, 2
        mov esi, ecx
        mov dword [byte esp+014h], edx
        jmp short .17
.16:
        mov eax, dword [byte esp+010h]
        sar eax, 2
        mov esi, ebx
        mov dword [byte esp+014h], eax
.17:
        mov eax, 0Ah
        call randomd0
        cwde
        add eax, byte 0Ch
        mov dword [byte ebx+064h], eax
        mov eax, 0Ah
        call randomd0
        cwde
        add eax, byte 0Ch
        mov dword [byte ecx+064h], eax
        mov al, byte [dword ebx+0B1h]
        mov dl, byte [dword ebx+0BFh]
        inc al
        or dl, 2
        and al, 7
        mov byte [dword ebx+0BFh], dl
        mov byte [dword ebx+0B1h], al
        mov al, byte [dword ecx+0B1h]
        mov dh, byte [dword ecx+0BFh]
        inc al
        or dh, 2
        and al, 7
        mov byte [dword ecx+0BFh], dh
        mov byte [dword ecx+0B1h], al
        test byte [dword esi+0BFh], 80h
        je short .18
        mov ax, word [FaceoffWinner]
        jmp short .19
.18:
        mov ax, word [fofdata2]
        xor al, 4
.19:
        mov word [ZoneTargetY], ax
        mov bh, byte [dword esi+0A4h]
        xor ebp, ebp
        cmp bh, 6
        jae short .20
        xor edx, edx
        jmp short .21
.20:
        mov edx, 6
.21:
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov ebx, SortCords
        shl eax, 3
        xor ecx, ecx
        add ebx, eax
.22:
        cmp esi, ebx
        je short .23
        mov ax, word [byte esi+0Eh]
        sub ax, word [byte ebx+0Eh]
        movsx edx, ax
        mov ax, word [byte esi+06h]
        sub ax, word [byte ebx+06h]
        cwde
        call vtoa
        cmp ax, word [ZoneTargetY]
        jne short .23
        mov ebp, ebx
        jmp short .24
.23:
        inc ecx
        add ebx, 108h
        cmp ecx, byte 6
        jl short .22
.24:
        test ebp, ebp
        je short .25
        fld dword [byte esi+020h]
        fsub dword [byte ebp+020h]
        fld dword [byte esi+028h]
        fsub dword [byte ebp+028h]
        fxch
        call IF@ATAN2
        jmp short .26
.25:
        fild word [ZoneTargetY]
        fmul qword [F64_0p25]
        fmul qword [F64_3p14159_Endfaceoff]
.26:
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+040h]
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [byte esp+014h]
        mov dword [byte eax+038h], 41A00000h
        test ebx, ebx
        je short .27
        mov eax, dword [PtrPuckFlags]
        fild dword [byte esp+014h]
        fmul dword [byte eax+038h]
        fstp dword [byte eax+038h]
.27:
        mov eax, dword [PtrPuckTarget]
        mov dx, word [FaceoffSpot]
        mov word [eax], dx
        mov dword [byte esp+018h], edx
        mov eax, dword [PtrPuckFlags]
        fild word [byte esp+018h]
        fstp dword [byte eax+020h]
        mov eax, dword [PtrPuckState]
        mov word [eax], 0
        mov ax, word [eax]
        mov dword [byte esp+018h], eax
        mov eax, dword [PtrPuckFlags]
        fild word [byte esp+018h]
        fstp dword [byte eax+024h]
        mov eax, dword [PtrPuckOwner]
        mov dx, word [FaceoffZone]
        mov word [eax], dx
        mov dword [byte esp+018h], edx
        mov eax, dword [PtrPuckFlags]
        fild word [byte esp+018h]
        fstp dword [byte eax+028h]
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+030h], 0
        xor eax, eax
        mov al, byte [dword esi+0A4h]
        mov word [PuckOwnerTeam], ax
        mov ax, word [byte esi+06h]
        mov word [LastPlayerTouch], ax
        mov ax, word [byte esi+0Eh]
        mov word [StoppageFlag], ax
        mov eax, dword [PtrPuckTarget]
        mov ax, word [eax]
        mov word [LastTouchTeam], ax
        mov eax, dword [PtrPuckOwner]
        mov ax, word [eax]
        mov word [PassDistY], ax
        mov edx, 41h
        mov cl, byte [dword edi+0BFh]
        mov eax, dword [dword edi+0AEh]
        and cl, 0FBh
        sar eax, 18h
        mov byte [dword edi+0BFh], cl
        mov byte [dword edi+eax+0B2h], dl
        or byte [dword edi+0BFh], 2
        mov eax, dword [PtrPuckObject]
        mov edx, dword [dword eax+0AEh]
        sar edx, 18h
        mov ebx, 31h
        mov byte [dword edx+eax+0B2h], bl
        or byte [dword eax+0BFh], 2
        mov eax, dword [PtrPuckObject]
        or byte [dword eax+0BFh], 10h
        mov eax, dword [PtrPuckObject]
        cmp word [byte eax+06h], byte 0
        jle short .28
        mov eax, dword [byte eax+04h]
        sar eax, 10h
        add eax, 0F0h
        jmp short .29
.28:
        mov eax, dword [byte eax+04h]
        sar eax, 10h
        sub eax, 0F0h
.29:
        mov dword [byte esp+04h], eax
        mov eax, dword [PtrPuckObject]
        mov eax, dword [dword eax+0EEh]
        fild dword [byte esp+04h]
        fstp dword [eax]
        mov eax, dword [PtrPuckObject]
        fild word [byte eax+0Eh]
        mov eax, dword [dword eax+0EEh]
        fstp dword [byte eax+04h]
        mov eax, dword [PtrPuckObject]
        mov eax, dword [dword eax+0EEh]
        or byte [byte eax+028h], 80h
        mov eax, dword [PtrPuckObject]
        mov dword [byte eax+038h], 41F00000h
        call SetFaceoffEndFlag
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push edx
        mov dl, byte [dword eax+0BFh]
        test dl, 20h
        jne short .30
        test dl, 8
        jne short .30
        mov edx, 8
        call doplayeracc
.30:
        pop edx
;-----------------------------------------------------------------------------
; AssNoop                                         209CC  97 PC, low confidence
; Empty assignment: does nothing
;-----------------------------------------------------------------------------
AssNoop:
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; assnull                                         209D0  97 PC, low confidence
; Assignment 0 (and the first referee and puck slots): stops the animation of
; object 13, otherwise nothing
;-----------------------------------------------------------------------------
assnull:
        cmp byte [dword eax+0A4h], 0Dh
        jne short AssNoop
        jmp near StopObject
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; assbenchwait                                    209E0  95 PC, low confidence
; Assignment 1 (set by setpersonel, AddPenalty2): an off-ice player waits at
; the bench (x -2232 / -4440), check4bench, flags +0C1h
;-----------------------------------------------------------------------------
assbenchwait:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .4
        or byte [dword ebx+0C1h], 1
        test byte [dword ebx+0BFh], 2
        je short .3
        mov edx, 0FFFFFFFFh
        mov eax, ebx
        call PickBenchSeat
        mov cl, byte [dword ebx+0BFh]
        and cl, 0FDh
        mov dx, word [dword ebx+0A9h]
        mov byte [dword ebx+0BFh], cl
        test dx, dx
        jl short .1
        cmp byte [dword ebx+0A6h], 0
        jge short .2
.1:
        mov dword [byte ebx+020h], 0C58AC000h
        mov eax, dword [dword ebx+0EEh]
        mov edx, dword [byte ebx+020h]
        mov dword [eax], edx
        mov eax, dword [dword ebx+0EEh]
        mov edx, dword [byte ebx+028h]
        mov dword [byte eax+04h], edx
        jmp short .3
.2:
        mov dword [byte ebx+020h], 0C50B8000h
.3:
        mov eax, ebx
        call check4bench
        test ax, ax
        je short .4
        mov al, byte [dword ebx+0C1h]
        mov dword [byte ebx+020h], 0C50B8000h
        or al, 10h
        mov byte [dword ebx+0C1h], al
.4:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DelayedPenaltyEnd                               20A80  97 PC, low confidence
; Ends a delayed penalty when the penalized team touches the puck or a goal
; is scored: stops play, crowd reaction; keeps the right players in the box
;-----------------------------------------------------------------------------
DelayedPenaltyEnd:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        test ax, ax
        jne short .1
        mov ax, word [PuckOwnerTeam]
        mov word [PassPending], ax
.1:
        mov ah, byte [gmode2]
        test ah, 10h
        je near .12
        mov dl, ah
        and dl, 0EFh
        mov byte [gmode2], dl
        test byte [gmode], 1
        jne near .12
        mov dx, word [PassPending]
        mov bl, byte [PenBuf]
        xor eax, eax
        cmp dx, byte 6
        setl cl
        test bl, bl
        je short .4
.2:
        cmp byte [dword eax+PenBuf], 5
        jne short .3
        mov dh, byte [dword eax+PenaltyTeam]
        xor ebx, ebx
        cmp dh, 6
        setl bl
        xor edx, edx
        mov dl, cl
        cmp ebx, edx
        je near .12
.3:
        add eax, byte 3
        cmp eax, byte 60h
        jge short .4
        cmp byte [dword eax+PenBuf], 0
        jne short .2
.4:
        mov edx, dword [PassPlayer]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edx, SortCords
        shl eax, 3
        add edx, eax
        test byte [dword edx+0BFh], 80h
        setne al
        xor ebx, ebx
        mov bl, al
        mov eax, dword [PtrPuckOwner]
        cmp word [eax], byte 0
        setg al
        and eax, 0FFh
        xor ebx, eax
        jne near .12
        test si, si
        jne near .10
        mov bh, byte [dword edx+0BFh]
        test bh, 40h
        je short .5
        cmp word [penshotlive], byte 0
        je short .7
        mov eax, 9
        jmp short .9
.5:
        test bh, 80h
        je short .6
        cmp word [StoppageFlag], 570h
        jl short .7
.6:
        test byte [dword edx+0BFh], 80h
        jne short .8
        mov eax, dword [SimFrames]
        sar eax, 10h
        cmp eax, 0FFFFFA90h
        jle short .8
.7:
        mov eax, 8
        jmp short .9
.8:
        mov eax, 2
        call randomd0
        test ax, ax
        sete al
        and eax, 0FFh
        add eax, byte 3
.9:
        call SetCrowdMood
.10:
        cmp dword [ReplayPlaying], byte 0
        jne near .12
        mov ecx, dword [dword edx+0FEh]
        mov eax, dword [dword ecx+0108h]
        mov si, word [dword eax+020B7h]
        inc esi
        mov ebx, dword [dword edx+0102h]
        mov word [dword eax+020B7h], si
        cmp byte [dword edx+0A6h], 19h
        jge short .11
        mov eax, dword [dword edx+0A3h]
        sar eax, 18h
        imul edx, eax, dword 125h
        mov eax, dword [dword ecx+0108h]
        inc word [dword edx+eax+01AEh]
.11:
        cmp word [byte ebx+010h], byte 0
        jl short .12
        mov edx, dword [dword ebx+0FAh]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov eax, dword [nosplit eax*8+PenaltyRecord]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        mov edx, dword [dword ebx+0108h]
        inc word [dword edx+eax+01E41h]
.12:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ChkTeamPlayerFlag                               20C50  97 PC, low confidence
; On a goal: whether the given team has a player on the ice with the
; goal-check flag set; returns 1 if so
;-----------------------------------------------------------------------------
ChkTeamPlayerFlag:
        push ebx
        push edx
        test byte [gmode], 8
        je short .5
        cmp word [PuckOwnerTeam], byte 6
        setl dl
        xor ebx, ebx
        mov bl, dl
        movsx edx, ax
        xor edx, ebx
        je short .5
        test ax, ax
        je short .1
        mov eax, HomeTeamRecord+420h
        jmp short .2
.1:
        mov eax, SortCords
.2:
        xor edx, edx
.3:
        cmp word [dword eax+0A9h], byte 0
        jl short .4
        test byte [dword eax+0C0h], 10h
        je short .4
        mov eax, 1
        pop edx
        pop ebx
        ret
.4:
        inc edx
        add eax, 108h
        cmp dx, byte 6
        jl short .3
.5:
        xor eax, eax
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; Goal                                         20CB0  95 PC, medium confidence
;
; The puck is in a goal: offside goals become AddPenalty / AddPenalty2, the goal and its bookkeeping, the
; goal commentary (CommentaryEvent), the scorer's team to assscore (18h), the puck to 40h and the referee to
; 31h; also from DebugKeys
;-----------------------------------------------------------------------------
Goal:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 2Ch
        mov edx, 5001h
        mov ah, 0FFh
        mov dword [byte esp+08h], edx
        mov byte [byte esp+020h], ah
        mov byte [byte esp+024h], ah
        mov dh, byte [gmode]
        mov eax, dword [PtrPuckFlags]
        test dh, 1
        jne near .86
        mov edx, 0FFFFFFFFh
        xor esi, esi
        mov word [AssistTwo], dx
        mov word [AssistOne], dx
        mov word [PuckOwner], si
        mov word [GoalState], si
        mov word [GoalScorer], dx
        cmp word [byte eax+0Eh], byte 0
        setl al
        xor dh, dh
        mov bl, byte [gmode]
        mov dl, al
        test bl, 2
        setne al
        xor dl, al
        mov word [PuckOwner], dx
        test dx, dx
        jle short .1
        mov ecx, awtmstruct
        jmp short .2
.1:
        mov ecx, hmtmstruct
.2:
        cmp word [PuckOwner], byte 0
        sete al
        and eax, 0FFh
        je short .3
        mov esi, awtmstruct
        jmp short .4
.3:
        mov esi, hmtmstruct
.4:
        cmp word [PuckOwner], byte 0
        je short .5
        mov eax, 6
        jmp short .6
.5:
        xor eax, eax
.6:
        mov word [PassPending], ax
        mov edx, dword [PassPlayer]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        xor edx, edx
        add eax, SortCords
.7:
        mov di, word [byte ecx+08h]
        movsx bx, byte [dword eax+0A6h]
        cmp bx, di
        jne short .8
        mov al, byte [dword eax+0A4h]
        xor ah, ah
        mov word [PassPending], ax
        jmp short .9
.8:
        inc edx
        add eax, 108h
        cmp dx, byte 6
        jl short .7
.9:
        test byte [byte ecx+016h], 10h
        jne short .10
        test byte [gmode2], 80h
        je short .11
        cmp word [PuckOwnerTeam], byte 5
        setg al
        xor ebx, ebx
        mov bl, al
        mov eax, dword [FaceoffWinner]
        sar eax, 10h
        xor eax, ebx
        je short .11
.10:
        mov eax, 1
        jmp short .12
.11:
        xor eax, eax
.12:
        mov edi, eax
        test ax, ax
        jne short .13
        mov eax, dword [FaceoffWinner]
        sar eax, 10h
        call ChkTeamPlayerFlag
        test eax, eax
        jne short .13
        mov eax, dword [FaceoffWinner]
        sar eax, 10h
        call FindCreasePlayer
        mov edx, eax
        test ax, ax
        jl near .17
.13:
        test di, di
        jne short .14
        mov eax, 1
        call DelayedPenaltyEnd
.14:
        test byte [gmode], 1
        jne near .86
        mov ebx, 40h
        mov eax, dword [PtrPuckFlags]
        mov word [byte esp+0Ch], bx
        mov ebx, dword [dword eax+0AEh]
        sar ebx, 18h
        lea ebp, [eax+ebx]
        mov bl, byte [byte esp+0Ch]
        mov byte [dword ebp+0B2h], bl
        mov bh, byte [dword eax+0BFh]
        or bh, 2
        mov byte [dword eax+0BFh], bh
        test dx, dx
        jl short .15
        cmp word [dword esi+0FCh], byte 0
        jl short .15
        mov ebx, dword [dword esi+0FAh]
        sar ebx, 10h
        mov eax, ebx
        shl eax, 5
        add eax, ebx
        cmp byte [nosplit eax*8+GoalFlags], 0
        je short .15
        movsx edx, dx
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov ebx, 1
        shl eax, 3
        mov edx, 14h
        add eax, SortCords
        call AddPenalty
.15:
        test di, di
        je short .16
        mov edx, 5
        mov eax, dword [dword ecx+0104h]
        xor ebx, ebx
        call AddPenalty
.16:
        mov edx, 0Bh
        mov eax, dword [dword esi+0104h]
        xor ebx, ebx
        call AddPenalty2
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.17:
        cmp word [penshotlive], byte 0
        je short .18
        mov dx, word [pucky]
        cmp dx, word [PuckOwner]
        je short .18
        call EndPenaltyShot
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.18:
        or byte [gmode2], 10h
        mov eax, 1
        call DelayedPenaltyEnd
        mov eax, dword [tickcount]
        mov ebx, dword [FaceoffWinner]
        sar ebx, 10h
        mov edx, eax
        mov eax, ebx
        call GoalCrowdCheer
        mov eax, 170Ah
        call TriggerCameraFlashes
        cmp word [byte ecx+010h], byte 0
        jl short .19
        mov edx, dword [dword ecx+0FAh]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov al, byte [nosplit eax*8+goalieflags]
        sub al, 19h
        mov byte [byte esp+020h], al
.19:
        cmp word [byte esi+010h], byte 0
        jl short .20
        mov edx, dword [dword esi+0FAh]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov al, byte [nosplit eax*8+goalieflags]
        sub al, 19h
        mov byte [byte esp+024h], al
.20:
        cmp ecx, hmtmstruct
        sete al
        xor edx, edx
        mov dl, al
        mov eax, dword [PassPlayer]
        sar eax, 10h
        call GoalCameraScene
        mov al, byte [PeriodHomeTeam]
        cmp al, byte [PeriodAwayTeam]
        jne near .30
        cmp dword [ReplayPlaying], byte 0
        jne near .30
        xor eax, eax
        jmp short .24
.21:
        mov edx, dword [byte esp+01Dh]
        sar edx, 18h
        cmp edx, byte 0FFFFFFFFh
        jne short .22
        mov edx, dword [FaceoffWinner]
        sar edx, 10h
        movsx dx, byte [dword edx+GoalieOut]
        jmp short .23
.22:
        movsx dx, byte [byte esp+020h]
.23:
        cmp ax, dx
        sete dl
        mov byte [byte esp+028h], dl
        movsx edx, ax
        imul edx, dword 125h
        add ebx, edx
        mov dl, byte [byte esp+028h]
        mov byte [dword ebx+01E4Bh], dl
        inc eax
.24:
        mov ebx, dword [dword ecx+0108h]
        cmp ax, word [dword ebx+01D40h]
        jl short .21
        xor eax, eax
        jmp short .28
.25:
        mov edx, dword [byte esp+021h]
        sar edx, 18h
        cmp edx, byte 0FFFFFFFFh
        jne short .26
        mov dx, word [PuckOwner]
        xor dl, 1
        movsx edx, dx
        movsx dx, byte [dword edx+GoalieOut]
        cmp ax, dx
        sete dl
        mov byte [byte esp+028h], dl
        movsx edx, ax
        imul edx, dword 125h
        add edx, ebx
        mov bl, byte [byte esp+028h]
        mov byte [dword edx+01E4Bh], bl
        jmp short .27
.26:
        movsx dx, byte [byte esp+024h]
        cmp ax, dx
        sete dl
        movsx edi, ax
        imul edi, dword 125h
        mov byte [dword edi+ebx+01E4Bh], dl
.27:
        inc eax
.28:
        mov ebx, dword [dword esi+0108h]
        cmp ax, word [dword ebx+01D40h]
        jl short .25
        cmp word [PuckOwner], byte 0
        jne short .29
        mov edx, 1001h
        mov eax, 5002h
        mov dword [LastTouchPlayer], edx
        mov dword [byte esp+08h], eax
        jmp short .30
.29:
        mov ebp, 1000h
        mov edi, 5000h
        mov dword [LastTouchPlayer], ebp
        mov dword [byte esp+08h], edi
.30:
        cmp word [PuckOwner], byte 0
        jne short .32
        cmp dword [ReplayPlaying], byte 0
        jne short .31
        inc byte [PeriodHomeTeam]
.31:
        mov eax, 102h
        call StartCrowdMusic
        mov eax, 0Ah
        jmp short .34
.32:
        cmp dword [ReplayPlaying], byte 0
        jne short .33
        inc byte [PeriodAwayTeam]
.33:
        mov eax, 2
        call randomd0
        test ax, ax
        sete al
        and eax, 0FFh
.34:
        call SetCrowdMood
        mov al, byte [PeriodHomeTeam]
        cmp al, byte [PeriodAwayTeam]
        jne near .39
        cmp dword [ReplayPlaying], byte 0
        jne near .39
        xor eax, eax
.35:
        mov ebx, dword [dword ecx+0108h]
        cmp ax, word [dword ebx+01D40h]
        jge short .36
        movsx edx, ax
        imul edx, dword 125h
        mov byte [dword edx+ebx+01E4Bh], 0
.36:
        mov edx, dword [dword esi+0108h]
        cmp ax, word [dword edx+01D40h]
        jge short .37
        movsx ebx, ax
        imul ebx, dword 125h
        mov byte [dword edx+ebx+01E4Bh], 0
.37:
        inc eax
        cmp ax, 3
        jl short .35
        cmp word [PuckOwner], byte 0
        jne short .38
        mov dword [LastTouchPlayer], 1001h
        jmp short .39
.38:
        mov edx, 1000h
        mov eax, 5000h
        mov dword [LastTouchPlayer], edx
        mov dword [byte esp+08h], eax
.39:
        cmp dword [ReplayPlaying], byte 0
        jne near .66
        mov dx, word [byte esi+0Eh]
        mov ax, word [byte ecx+0Eh]
        cmp ax, dx
        jge short .40
        mov word [GoalState], 2
        jmp short .42
.40:
        jle short .41
        mov word [GoalState], 1
        jmp short .42
.41:
        xor edi, edi
        mov word [GoalState], di
.42:
        cmp word [byte esi+010h], byte 0
        jge short .43
        or byte [GoalState], 4
.43:
        mov ax, word [byte ecx+08h]
        mov word [AssistOne], ax
        cmp ax, 19h
        jge short .44
        movsx edx, ax
        imul edx, dword 125h
        mov ebx, dword [dword ecx+0108h]
        inc word [dword edx+ebx+01A0h]
        mov ebx, dword [dword ecx+0108h]
        add ebx, 0A3h
        jmp short .45
.44:
        movsx edx, ax
        sub edx, byte 19h
        imul edx, dword 125h
        mov ebx, dword [dword ecx+0108h]
        inc word [dword edx+ebx+01E43h]
        mov ebx, dword [dword ecx+0108h]
        add ebx, 1D42h
.45:
        add ebx, edx
        mov dword [byte esp+04h], ebx
        inc word [ecx]
        mov edx, dword [dword ecx+0108h]
        inc word [dword edx+020B9h]
        mov edx, dword [dword esi+0108h]
        inc word [dword edx+020BBh]
        cmp byte [byte esp+024h], 0
        jl short .46
        mov edx, dword [byte esp+021h]
        sar edx, 18h
        imul edx, dword 125h
        mov ebx, dword [dword esi+0108h]
        inc word [dword edx+ebx+01E47h]
        jmp short .47
.46:
        mov dx, word [PuckOwner]
        xor dl, 1
        movsx edx, dx
        mov edx, dword [dword edx+GoalScorerFlags]
        sar edx, 18h
        sub edx, byte 19h
        imul edx, dword 125h
        mov ebx, dword [dword esi+0108h]
        inc word [dword edx+ebx+01E49h]
.47:
        mov bl, byte [GoalState]
        test bl, 2
        je short .49
        cmp ax, 19h
        jge short .48
        cwde
        imul eax, dword 125h
        mov edx, dword [dword ecx+0108h]
        inc word [dword edx+eax+01ACh]
.48:
        mov eax, dword [dword ecx+0108h]
        inc word [dword eax+020BFh]
        mov edx, 5003h
        mov eax, dword [dword esi+0108h]
        mov dword [byte esp+08h], edx
        inc word [dword eax+020CFh]
        jmp short .51
.49:
        test bl, 1
        je short .51
        cmp ax, 19h
        jge short .50
        cwde
        imul eax, dword 125h
        mov edx, dword [dword ecx+0108h]
        inc word [dword edx+eax+01AAh]
.50:
        mov eax, dword [dword ecx+0108h]
        inc word [dword eax+020CDh]
        mov eax, dword [dword esi+0108h]
        mov dx, word [dword eax+020C1h]
        mov ebp, 5004h
        inc edx
        mov dword [byte esp+08h], ebp
        mov word [dword eax+020C1h], dx
.51:
        test byte [GoalState], 4
        je short .52
        mov eax, dword [dword ecx+0108h]
        inc word [dword eax+020C3h]
        mov eax, dword [dword esi+0108h]
        mov di, word [dword eax+020C5h]
        mov ebx, 5000h
        inc edi
        mov dword [byte esp+08h], ebx
        mov word [dword eax+020C5h], di
.52:
        mov ax, word [byte ecx+0Ah]
        test ax, ax
        jl near .56
        mov word [AssistTwo], ax
        cmp ax, 19h
        jge short .53
        cwde
        imul eax, dword 125h
        mov edx, dword [dword ecx+0108h]
        inc word [dword edx+eax+01A2h]
        jmp short .54
.53:
        cwde
        sub eax, byte 19h
        imul eax, dword 125h
        mov edx, dword [dword ecx+0108h]
        inc word [dword edx+eax+01E45h]
.54:
        mov ax, word [byte ecx+0Ch]
        test ax, ax
        jl short .56
        mov word [GoalScorer], ax
        cmp ax, 19h
        jge short .55
        cwde
        imul eax, dword 125h
        mov edx, dword [dword ecx+0108h]
        inc word [dword edx+eax+01A2h]
        jmp short .56
.55:
        cwde
        sub eax, byte 19h
        imul eax, dword 125h
        mov edx, dword [dword ecx+0108h]
        inc word [dword edx+eax+01E45h]
.56:
        cmp word [penshotmode], byte 0
        je short .57
        mov eax, dword [dword ecx+0108h]
        inc word [dword eax+020E5h]
        jmp short .58
.57:
        cmp word [OneTimerTarget], byte 0
        je short .58
        mov eax, dword [dword ecx+0108h]
        inc word [dword eax+020E1h]
.58:
        cmp word [OneTimerReady], byte 0
        je short .59
        mov eax, dword [dword ecx+0108h]
        inc word [dword eax+020DDh]
.59:
        cmp word [penshotlive], byte 0
        jne near .64
        mov dx, word [byte ecx+0Eh]
        cmp dx, word [byte esi+0Eh]
        jg near .63
        mov eax, dword [dword esi+0104h]
        mov ebx, dword [dword ecx+0104h]
        xor edx, edx
.60:
        cmp word [dword ebx+0A9h], byte 0
        jle short .61
        mov edi, dword [dword ebx+0A3h]
        sar edi, 18h
        imul edi, dword 125h
        mov dword [esp], edi
        mov ebp, dword [esp]
        mov edi, dword [dword ecx+0108h]
        add edi, ebp
        inc word [dword edi+01A6h]
.61:
        cmp word [dword eax+0A9h], byte 0
        jle short .62
        mov edi, dword [dword eax+0A3h]
        sar edi, 18h
        imul edi, dword 125h
        mov dword [esp], edi
        mov ebp, dword [esp]
        mov edi, dword [dword esi+0108h]
        add edi, ebp
        dec word [dword edi+01A6h]
.62:
        add ebx, 108h
        inc edx
        add eax, 108h
        cmp dx, byte 6
        jl short .60
.63:
        mov eax, dword [FaceoffWinner]
        sar eax, 10h
        call PenGoalStuff
        jmp short .65
.64:
        xor edi, edi
        mov word [FaceoffSpot], di
        mov word [PassDistY], di
        mov word [LastTouchTeam], di
        mov word [StoppageFlag], di
        mov word [LastPlayerTouch], di
        mov word [FaceoffZone], di
.65:
        xor eax, eax
        mov word [OneTimerTarget], ax
        mov word [OneTimerReady], ax
        mov eax, dword [LastTouchPlayer]
        push eax
        mov edx, dword [byte esp+0Ch]
        push edx
        mov ebx, dword [byte esp+0Ch]
        push ebx
        push dword 0A0000007h
        call CommentaryEvent
        add esp, byte 10h
        jmp short .69
.66:
        cmp word [penshotlive], byte 0
        jne short .67
        mov eax, dword [FaceoffWinner]
        sar eax, 10h
        call PenGoalStuff
        jmp short .68
.67:
        xor edx, edx
        mov word [FaceoffSpot], dx
        mov word [PassDistY], dx
        mov word [LastTouchTeam], dx
        mov word [StoppageFlag], dx
        mov word [LastPlayerTouch], dx
        mov word [FaceoffZone], dx
.68:
        xor edi, edi
        mov word [OneTimerReady], di
        mov word [OneTimerTarget], di
.69:
        mov ebx, dword [dword esi+0104h]
        xor edi, edi
        mov ebp, 1
.70:
        mov edx, 2
        mov eax, dword [dword ebx+0F2h]
        call SetFaceExpression
        mov edx, ebp
        mov eax, dword [dword ebx+0F2h]
        inc edi
        call SetFaceMouth
        mov eax, dword [dword ebx+0F2h]
        xor edx, edx
        add ebx, 108h
        call SetFaceBlink
        cmp di, byte 6
        jl short .70
        mov ebx, dword [dword ecx+0104h]
        xor ecx, ecx
.71:
        cmp word [dword ebx+0A9h], byte 0
        jle near .78
        test byte [dword ebx+0C0h], 1
        jne near .78
        mov eax, dword [dword ebx+0AEh]
        mov dl, byte [dword ebx+0BFh]
        sar eax, 18h
        and dl, 0FBh
        add eax, ebx
        mov byte [dword ebx+0BFh], dl
        cmp byte [dword eax+0B2h], 19h
        jne near .75
        mov edx, 15h
        mov edi, ebx
        movsx ax, byte [dword eax+0B2h]
        mov word [byte esp+014h], dx
        cmp ax, dx
        je short .72
        mov al, byte [dword ebx+0B1h]
        dec al
        and al, 7
        mov byte [dword ebx+0B1h], al
.72:
        mov edx, dword [byte esp+012h]
        mov eax, edi
        sar edx, 10h
        call assreplace
        mov edx, dword [dword ebx+0AEh]
        mov edi, 18h
        sar edx, 18h
        mov eax, ebx
        movsx dx, byte [dword edx+ebx+0B2h]
        mov word [byte esp+018h], di
        cmp dx, di
        je short .73
        mov dl, byte [dword ebx+0B1h]
        dec dl
        and dl, 7
        mov byte [dword ebx+0B1h], dl
.73:
        mov edx, dword [byte esp+016h]
        sar edx, 10h
        call assreplace
        mov word [byte esp+010h], 16h
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        movsx dx, byte [dword edx+ebx+0B2h]
        mov eax, ebx
        cmp dx, byte 16h
        je short .74
        mov dl, byte [dword ebx+0B1h]
        dec dl
        and dl, 7
        mov byte [dword ebx+0B1h], dl
.74:
        mov edx, dword [byte esp+0Eh]
        jmp short .77
.75:
        mov edx, 18h
        mov edi, ebx
        movsx ax, byte [dword eax+0B2h]
        mov word [byte esp+01Ch], dx
        cmp ax, dx
        je short .76
        mov al, byte [dword ebx+0B1h]
        dec al
        and al, 7
        mov byte [dword ebx+0B1h], al
.76:
        mov edx, dword [byte esp+01Ah]
        mov eax, edi
.77:
        sar edx, 10h
        call assreplace
.78:
        inc ecx
        add ebx, 108h
        cmp cx, byte 6
        jl near .71
        cmp dword [ReplayPlaying], byte 0
        jne short .79
        mov eax, dword [gameover]
        sar eax, 10h
        mov ecx, dword [StatsPanelPlayer]
        push eax
        mov eax, dword [AssistTwo]
        mov ebx, dword [FaceoffWinner]
        sar eax, 10h
        mov edx, dword [PuckOwnerTeam]
        push eax
        mov eax, dword [AssistOne]
        sar ecx, 10h
        sar eax, 10h
        sar ebx, 10h
        push eax
        mov eax, dword [gsp]
        sar edx, 10h
        sar eax, 10h
        call LogGoal
.79:
        mov edx, 7
        mov eax, dword [dword esi+0104h]
        xor ebx, ebx
        call AddPenalty2
        call EndPenaltyShot
        mov eax, dword [PtrPuckObject]
        mov edx, dword [dword eax+0AEh]
        sar edx, 18h
        mov ebx, 31h
        mov byte [dword edx+eax+0B2h], bl
        or byte [dword eax+0BFh], 2
        mov ax, word [hmtmstruct]
        mov si, word [awtmstruct]
        xor ebx, ebx
        sub eax, esi
        mov word [HomeGoalsPeriod], bx
        movsx edx, ax
        mov word [AwayGoalsPeriod], bx
        cmp edx, byte 0FFFFFFFDh
        jge short .80
        cmp byte [HmCoachOffense], 1
        jbe short .80
        cmp word [HomeGoalieOff], byte 0
        jne short .80
        mov cl, byte [HmLineState]
        test cl, 1
        jne short .80
        mov ch, cl
        xor ch, 1
        mov byte [HmLineState], ch
.80:
        movsx edx, ax
        cmp edx, byte 0FFFFFFFFh
        jge short .81
        mov dl, byte [HmCoachOffense]
        cmp dl, 1
        jbe short .81
        mov dh, dl
        dec dh
        mov byte [HmCoachOffense], dh
.81:
        cmp ax, 1
        jge short .82
        mov bl, byte [HmCoachDefense]
        cmp bl, 1
        jbe short .82
        mov bh, bl
        dec bh
        mov byte [HmCoachDefense], bh
.82:
        cmp ax, 3
        jle short .83
        cmp byte [AwCoachOffense], 1
        jbe short .83
        cmp word [AwayGoalieOff], byte 0
        jne short .83
        mov ch, byte [AwLineState]
        test ch, 1
        jne short .83
        mov dl, ch
        xor dl, 1
        mov byte [AwLineState], dl
.83:
        cmp ax, 1
        jle short .84
        mov dh, byte [AwCoachOffense]
        cmp dh, 1
        jbe short .84
        mov bl, dh
        dec bl
        mov byte [AwCoachOffense], bl
.84:
        cwde
        cmp eax, byte 0FFFFFFFFh
        jle short .85
        mov bh, byte [AwCoachDefense]
        cmp bh, 1
        jbe short .85
        mov cl, bh
        dec cl
        mov byte [AwCoachDefense], cl
.85:
        call UpdateCoachModes
.86:
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; InCrease                                        218B8  97 PC, low confidence
; Whether a player stands in the goal crease at the given end (distance from
; the goal mouth); returns 1 if so
;-----------------------------------------------------------------------------
InCrease:
        push ebx
        push ecx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 18h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov esi, edx
        mov ebx, esp
        mov edx, dword [CreaseBounds]
        call ObjectFramePos
        lea ebx, [byte esp+0Ch]
        mov edx, dword [GoalLineY]
        mov eax, ecx
        call ObjectFramePos
        test esi, esi
        jne near .4
        mov edx, dword [byte esp+08h]
        cmp edx, 45790000h
        jle short .1
        cmp edx, 45858000h
        jle short .2
.1:
        mov ecx, dword [byte esp+014h]
        cmp ecx, 45790000h
        jle near .8
        cmp ecx, 45858000h
        jg near .8
.2:
        fld dword [F32_4272_InCrease]
        fsub dword [byte esp+08h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+08h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_288]
        fnstsw ax
        sahf
        ja short .3
        mov eax, 1
        jmp near .9
.3:
        fld dword [F32_4272_InCrease]
        fsub dword [byte esp+014h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+014h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_288]
        fnstsw ax
        sahf
        ja near .8
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        pop ebx
        ret
.4:
        cmp esi, byte 1
        jne near .8
        fld dword [byte esp+08h]
        fcomp dword [F32_neg3984]
        fnstsw ax
        sahf
        jae short .5
        fld dword [byte esp+08h]
        fcomp dword [F32_neg4272_InCrease]
        fnstsw ax
        sahf
        jae short .6
.5:
        fld dword [byte esp+014h]
        fcomp dword [F32_neg3984]
        fnstsw ax
        sahf
        jae near .8
        fld dword [byte esp+014h]
        fcomp dword [F32_neg4272_InCrease]
        fnstsw ax
        sahf
        jb short .8
.6:
        fld dword [byte esp+08h]
        fadd dword [F32_neg4272_InCrease]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+08h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_288]
        fnstsw ax
        sahf
        ja short .7
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        pop ebx
        ret
.7:
        fld dword [byte esp+014h]
        fadd dword [F32_neg4272_InCrease]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+014h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_288]
        fnstsw ax
        sahf
        ja short .8
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        pop ebx
        ret
.8:
        xor eax, eax
.9:
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; UpdateCreaseFlag                                21A4C  97 PC, low confidence
; Each frame: sets or clears a player's in-crease flag at the goal he attacks
;-----------------------------------------------------------------------------
UpdateCreaseFlag:
        push ebx
        push edx
        mov ebx, eax
        test byte [dword eax+0BFh], 80h
        je short .2
        mov eax, ebx
        xor edx, edx
        call InCrease
        test eax, eax
        jne short .1
        mov byte [dword ebx+0A5h], 0
        pop edx
        pop ebx
        ret
.1:
        mov eax, dword [PtrPuckFlags]
        cmp byte [dword eax+0A5h], 0
        je short .5
        jmp short .4
.2:
        mov edx, 1
        mov eax, ebx
        call InCrease
        test eax, eax
        jne short .3
        mov byte [dword ebx+0A5h], 0
        pop edx
        pop ebx
        ret
.3:
        mov eax, dword [PtrPuckFlags]
        cmp byte [dword eax+0A5h], 1
        je short .5
.4:
        mov byte [dword ebx+0A5h], 1
.5:
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FindCreasePlayer                                21AB4  97 PC, low confidence
; On a goal with the crease rule on: returns the number of the first attacker
; standing in the crease, -1 if none
;-----------------------------------------------------------------------------
FindCreasePlayer:
        push ebx
        push edx
        mov edx, dword [gameopts]
        test byte [byte edx+01h], 7
        je short .5
        cmp word [PuckOwnerTeam], byte 6
        setl dl
        xor ebx, ebx
        mov bl, dl
        movsx edx, ax
        xor edx, ebx
        je short .5
        test ax, ax
        je short .1
        mov eax, HomeTeamRecord+420h
        jmp short .2
.1:
        mov eax, SortCords
.2:
        xor edx, edx
        xor ebx, ebx
.3:
        cmp bx, word [dword eax+0A9h]
        jge short .4
        cmp bl, byte [dword eax+0A5h]
        je short .4
        mov al, byte [dword eax+0A4h]
        and eax, 0FFh
        pop edx
        pop ebx
        ret
.4:
        inc edx
        add eax, 108h
        cmp dx, byte 6
        jl short .3
.5:
        mov eax, 0FFFFFFFFh
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; assgoalie                                      21B20  94G, medium confidence
; assignment 2 (Setplass list for the goalie), the goalie AI
;-----------------------------------------------------------------------------
assgoalie:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ecx, eax
        call check4bench
        test ax, ax
        jne near .19
        mov ah, byte [dword ecx+0BFh]
        test ah, 2
        je short .1
        mov dword [byte ecx+05Ah], 0
        mov dl, ah
        mov dword [byte ecx+056h], 0FFFFFFFFh
        and dl, 0FDh
        mov byte [dword ecx+0BFh], dl
.1:
        cmp word [byte ecx+0Eh], byte 0
        jge short .2
        mov eax, dword [byte ecx+0Ch]
        sar eax, 10h
        neg eax
        jmp short .3
.2:
        mov eax, dword [byte ecx+0Ch]
        sar eax, 10h
.3:
        mov ebx, eax
        mov eax, dword [dword ecx+0F6h]
        mov eax, dword [eax]
        mov esi, dword [byte eax+028h]
        mov dh, byte [gmode]
        and esi, 0FFFFh
        test dh, 1
        je near .8
        mov eax, dword [PtrPuckObject]
        mov edx, dword [dword eax+0AEh]
        sar edx, 18h
        cmp byte [dword edx+eax+0B2h], 33h
        je near .8
        mov eax, dword [dword ecx+0EEh]
        mov dword [eax], 0
        test byte [dword ecx+0BFh], 80h
        jne short .4
        mov dword [byte esp+04h], 1050h
        jmp short .5
.4:
        mov dword [byte esp+04h], 0FFFFEFB0h
.5:
        mov eax, dword [dword ecx+0EEh]
        fild dword [byte esp+04h]
        fstp dword [byte eax+04h]
        mov eax, dword [dword ecx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword ecx+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [dword ecx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, ecx
        call SetSkateSpeedFromRating
        mov eax, dword [dword ecx+0EEh]
        mov dword [byte eax+024h], 42C80000h
        test byte [dword ecx+0BFh], 80h
        jne short .6
        mov dword [esp], 8000h
        jmp short .7
.6:
        xor ebp, ebp
        mov dword [esp], ebp
.7:
        mov eax, dword [dword ecx+0EEh]
        fild dword [esp]
        fstp dword [byte eax+010h]
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        jne short .13
        cmp esi, 104h
        je short .9
        cmp esi, 0E4h
        jne short .10
.9:
        test byte [dword ecx+0BFh], 8
        jne short .10
        mov edx, dword [byte ecx+056h]
        sub edx, byte 2
        mov dword [byte ecx+056h], edx
        cmp edx, byte 1
        jge short .12
        jmp short .11
.10:
        cmp ebx, 0CF0h
        jge short .12
.11:
        mov dword [byte ecx+056h], 1
.12:
        mov edi, dword [byte ecx+056h]
        dec edi
        mov dword [byte ecx+056h], edi
        jne short .14
        mov edx, 9
        mov eax, ecx
        xor ebx, ebx
        call AddPenalty2
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+038h], edi
        jmp short .14
.13:
        mov dword [byte ecx+056h], 0FFFFFFFFh
.14:
        test byte [dword ecx+0BFh], 8
        jne near .21
        xor edx, edx
        mov dl, byte [dword ecx+0C6h]
        mov ebx, 3
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov dword [byte ecx+05Ah], eax
        mov eax, dword [PtrPuckOwner]
        mov bx, word [byte ecx+0Eh]
        mov dx, word [eax]
        xor edx, ebx
        mov word [regd1], dx
        test dx, dx
        jge short .15
        movsx ebx, word [eax]
        xor edx, edx
        mov eax, ecx
        call GoaliePosTarget
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.15:
        mov edx, dword [puckc]
        xor eax, eax
        movsx edx, byte [edx]
        mov al, byte [dword ecx+0A4h]
        cmp eax, edx
        jne near .21
        cmp dword [byte ecx+056h], byte 0
        jge short .16
        mov dword [byte ecx+056h], 5Ah
.16:
        cmp dword [byte ecx+056h], byte 5Ah
        jge near .20
        mov eax, 4
        call randomd0
        test ax, ax
        jne near .20
        mov eax, ecx
        call BuildPassTargets
        mov word [GoalieTarget], ax
        cmp ax, 1E0h
        jge short .17
        cmp ax, 0F0h
        jge near .18
        mov eax, ecx
        call StartGoalieSave
        dec dword [byte ecx+056h]
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.17:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+05Ah], byte 20h
        jl near .18
        cmp esi, 0E4h
        je near .18
        cmp esi, 102h
        je near .18
        cmp esi, 103h
        je near .18
        cmp esi, 104h
        je near .18
        cmp esi, 105h
        je near .18
        cmp esi, 106h
        je near .18
        mov eax, ecx
        call AIPassDecision
        test ax, ax
        jne near .19
.18:
        mov eax, ecx
        call GoalieMoves
.19:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.20:
        cmp dword [byte ecx+056h], byte 5Ah
        jge short .18
        mov eax, ecx
        call BuildPassTargets
        mov word [GoalieTarget], ax
        cmp ax, 0F0h
        jl short .18
        mov eax, ecx
        call StartGoalieStance
        mov eax, ecx
        call GoalieMoves
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.21:
        test byte [dword ecx+0BFh], 8
        je short .18
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        jne short .18
        cmp dword [byte ecx+056h], byte 0
        jge short .22
        mov dword [byte ecx+056h], 5Ah
.22:
        cmp dword [byte ecx+056h], byte 5Ah
        jge short .18
        mov eax, ecx
        call StartGoalieStance
        mov eax, ecx
        call BuildPassTargets
        mov word [GoalieTarget], ax
        cmp ax, 1E0h
        jge near .18
        cmp ax, 0F0h
        jge near .18
        dec dword [byte ecx+056h]
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; KeepInsideRink                                  21E98  97 PC, low confidence
; Pulls a player's skating target back inside the boards when it lies past
; the rink edge
;-----------------------------------------------------------------------------
KeepInsideRink:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 38h
        mov ebx, eax
        fld dword [F32_1272]
        fsub dword [byte eax+050h]
        mov edx, dword [dword eax+0EEh]
        fld dword [edx]
        fabs
        mov ecx, 449F0000h
        mov esi, 457C0000h
        mov dword [byte ebp-04h], ecx
        mov dword [byte ebp-08h], esi
        fcompp
        fnstsw ax
        sahf
        jbe near .9
        fld dword [F32_4032]
        fsub dword [byte ebx+050h]
        fld dword [byte edx+04h]
        fabs
        fcompp
        fnstsw ax
        sahf
        jbe near .9
        fldz
        fcomp dword [byte edx+04h]
        fnstsw ax
        sahf
        jae short .1
        mov dword [byte ebp-020h], esi
        jmp short .2
.1:
        mov dword [byte ebp-020h], 0C57C0000h
.2:
        sub esp, byte 8
        fld dword [byte edx+04h]
        fsub dword [byte ebp-020h]
        fldz
        fxch
        fstp qword [esp]
        fcomp dword [edx]
        fnstsw ax
        sahf
        jae short .3
        mov eax, dword [byte ebp-04h]
        mov dword [byte ebp-024h], eax
        jmp short .4
.3:
        fld dword [byte ebp-04h]
        fchs
        fstp dword [byte ebp-024h]
.4:
        fld dword [edx]
        fsub dword [byte ebp-024h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fld dword [F32_768]
        fsub dword [byte ebx+050h]
        fcompp
        fnstsw ax
        sahf
        jae near .15
        fldz
        fcomp dword [edx]
        fnstsw ax
        sahf
        jae short .5
        mov eax, dword [byte ebp-04h]
        mov dword [byte ebp-018h], eax
        jmp short .6
.5:
        fld dword [byte ebp-04h]
        fchs
        fstp dword [byte ebp-018h]
.6:
        mov eax, dword [byte ebp-018h]
        fldz
        mov dword [byte ebp-010h], eax
        fcomp dword [byte edx+04h]
        fnstsw ax
        sahf
        jae short .7
        mov eax, dword [byte ebp-08h]
        mov dword [byte ebp-0Ch], eax
        jmp short .8
.7:
        fld dword [byte ebp-08h]
        fchs
        fstp dword [byte ebp-0Ch]
.8:
        fld dword [byte edx+04h]
        fsub dword [byte ebp-0Ch]
        fld dword [edx]
        fsub dword [byte ebp-010h]
        call IF@ATAN2
        lea edi, [byte ebp-034h]
        lea esi, [byte ebp-030h]
        lea eax, [byte ebp-038h]
        fstp dword [byte ebp-038h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [F32_768]
        fsub dword [byte ebx+050h]
        fld st0
        fmul dword [byte ebp-030h]
        fadd dword [byte ebp-010h]
        fstp dword [edx]
        fmul dword [byte ebp-034h]
        fadd dword [byte ebp-0Ch]
        fstp dword [byte edx+04h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        fld dword [edx]
        fabs
        fld dword [byte ebp-04h]
        fld dword [byte ebp-08h]
        fld dword [F32_768]
        fsub dword [byte ebx+050h]
        fxch st2
        fadd st2
        fxch
        faddp st2
        fstp dword [byte ebp-04h]
        fstp dword [byte ebp-08h]
        fld dword [byte ebp-04h]
        fcompp
        fnstsw ax
        sahf
        jae short .12
        fldz
        fcomp dword [edx]
        fnstsw ax
        sahf
        jae short .10
        mov eax, dword [byte ebp-04h]
        mov dword [byte ebp-01Ch], eax
        jmp short .11
.10:
        fld dword [byte ebp-04h]
        fchs
        fstp dword [byte ebp-01Ch]
.11:
        mov eax, dword [byte ebp-01Ch]
        mov dword [edx], eax
.12:
        fld dword [byte edx+04h]
        fabs
        fld dword [byte ebp-08h]
        fcompp
        fnstsw ax
        sahf
        jae short .15
        fldz
        fcomp dword [byte edx+04h]
        fnstsw ax
        sahf
        jae short .13
        mov eax, dword [byte ebp-08h]
        mov dword [byte ebp-014h], eax
        jmp short .14
.13:
        fld dword [byte ebp-08h]
        fchs
        fstp dword [byte ebp-014h]
.14:
        mov eax, dword [byte ebp-014h]
        mov dword [byte edx+04h], eax
.15:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DefendPuck                                      22050  97 PC, low confidence
; Defensive play of a computer player: picks the attacker or lane to cover
; and skates there
;-----------------------------------------------------------------------------
DefendPuck:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edx, eax
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .1
        cmp byte [dword edx+0A4h], 6
        setb al
        mov ebx, eax
        mov eax, dword [puckc]
        mov cl, byte [eax]
        and ebx, 0FFh
        cmp cl, 6
        setl al
        and eax, 0FFh
        cmp eax, ebx
        je short .2
.1:
        cmp word [onetimerplayer], byte 0
        jl near .34
        cmp byte [dword edx+0A4h], 6
        setb al
        mov ebx, eax
        mov cx, word [onetimerplayer]
        and ebx, 0FFh
        cmp cx, byte 6
        setl al
        and eax, 0FFh
        cmp eax, ebx
        jne near .34
.2:
        mov ebx, dword [puckc]
        mov cl, byte [ebx]
        test cl, cl
        jl short .3
        movsx eax, cl
        jmp short .4
.3:
        mov eax, dword [PassReceiver]
        sar eax, 10h
.4:
        mov ebx, eax
        shl ebx, 5
        add ebx, eax
        shl ebx, 3
        add ebx, SortCords
        mov ax, word [byte ebx+06h]
        mov word [GoalieTarget], ax
        mov ax, word [byte ebx+0Eh]
        mov word [DefendFlags], ax
        test byte [dword edx+0BFh], 80h
        jne short .5
        mov esi, eax
        mov cx, word [GoalieTarget]
        neg esi
        neg ecx
        mov word [DefendFlags], si
        mov word [GoalieTarget], cx
.5:
        cmp word [dword ebx+0ABh], byte 0
        jne near .13
        cmp word [GoalieTarget], byte 30h
        jle short .7
        cmp word [dword edx+0ABh], byte 1
        jne short .6
        mov eax, 0FFFFF310h
        mov edi, 0FFFFFE20h
        mov word [regd1], ax
        mov word [ZoneTargetY], di
        jmp near .12
.6:
        mov esi, 0FFFFF130h
        mov ecx, 1E0h
        mov word [regd1], si
        mov word [ZoneTargetY], cx
        jmp near .12
.7:
        mov eax, dword [ExtraAttacker]
        sar eax, 10h
        cmp eax, byte 0FFFFFFD0h
        jge short .9
        cmp word [dword edx+0ABh], byte 1
        jne short .8
        mov eax, 0FFFFF130h
        mov edi, 0FFFFFE20h
        mov word [regd1], ax
        mov word [ZoneTargetY], di
        jmp short .12
.8:
        mov esi, 0FFFFF310h
        mov ecx, 1E0h
        mov word [regd1], si
        mov word [ZoneTargetY], cx
        jmp short .12
.9:
        cmp word [dword edx+0ABh], byte 1
        jne short .10
        mov ebx, 0FFFFFE20h
        jmp short .11
.10:
        mov ebx, 1E0h
.11:
        mov eax, 0FFFFF310h
        mov word [ZoneTargetY], bx
        mov word [regd1], ax
.12:
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
        jmp near .54
.13:
        test byte [dword ebx+0106h], 1
        je short .15
        mov eax, dword [ExtraAttacker]
        sar eax, 10h
        add eax, 7F8h
        sar eax, 1
        mov word [ZoneTargetY], ax
        cmp word [dword edx+0ABh], byte 1
        jne short .14
        sub word [ZoneTargetY], 7F8h
.14:
        mov word [regd1], 5D0h
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
        jmp near .54
.15:
        mov eax, dword [DefendTarget]
        sar eax, 10h
        cmp eax, 0FFFFEF50h
        jge near .20
        mov eax, dword [PtrPuckTarget]
        mov ax, word [eax]
        mov word [ZoneTargetY], ax
        cmp word [dword edx+0ABh], byte 1
        jne short .16
        mov eax, 0FFFFF808h
        jmp short .17
.16:
        mov eax, 7F8h
.17:
        mov ebx, dword [ZoneTargetX]
        sar ebx, 10h
        add ebx, eax
        mov word [ZoneTargetY], bx
        mov eax, dword [PtrPuckTarget]
        mov ebx, dword [ZoneTargetX]
        movsx eax, word [eax]
        sar ebx, 10h
        xor eax, ebx
        test eax, eax
        jl short .18
        mov word [regd1], 0F190h
        jmp short .19
.18:
        mov word [regd1], 0EE00h
.19:
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
        jmp near .54
.20:
        mov eax, edx
        call GetDefensePartner
        cmp eax, ebx
        jne near .27
        mov eax, dword [ExtraAttacker]
        sar eax, 10h
        add eax, 7F8h
        sar eax, 1
        mov word [ZoneTargetY], ax
        cmp word [dword edx+0ABh], byte 1
        jne short .21
        mov esi, eax
        sub esi, 7F8h
        mov word [ZoneTargetY], si
.21:
        test byte [dword edx+0BFh], 80h
        setne al
        mov ecx, eax
        mov ebp, dword [byte ebx+018h]
        and ecx, 0FFh
        test ebp, ebp
        setle al
        and eax, 0FFh
        xor eax, ecx
        je short .22
        mov ax, word [DefendFlags]
        jmp short .23
.22:
        mov ax, word [DefendFlags]
        db 081h,0E8h,0A0h,05h,00h,00h           ; insn: sub eax,5A0h
.23:
        mov word [regd1], ax
        mov eax, dword [dword edx+0EEh]
        mov ecx, dword [byte ebx+038h]
        mov dword [byte eax+08h], ecx
        mov eax, dword [dword edx+0EEh]
        mov ecx, dword [byte ebx+040h]
        mov dword [byte eax+0Ch], ecx
        cmp word [ZoneTargetY], byte 0
        jge short .24
        mov eax, dword [ZoneTargetX]
        sar eax, 10h
        neg eax
        jmp short .25
.24:
        mov eax, dword [ZoneTargetX]
        sar eax, 10h
.25:
        cmp eax, 2D0h
        jge short .26
        mov eax, dword [ZoneFlags]
        sar eax, 10h
        cmp eax, 0FFFFF130h
        jge near .54
        mov word [regd1], 0F130h
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
        jmp near .54
.26:
        mov eax, dword [ZoneFlags]
        sar eax, 10h
        cmp eax, 0FFFFF040h
        jge near .54
        mov word [regd1], 0F040h
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
        jmp near .54
.27:
        mov eax, dword [ExtraAttacker]
        sar eax, 10h
        add eax, 7F8h
        sar eax, 1
        mov word [ZoneTargetY], ax
        cmp word [dword edx+0ABh], byte 1
        jne short .28
        sub word [ZoneTargetY], 7F8h
.28:
        mov ah, byte [dword edx+0BFh]
        xor ecx, ecx
        test ah, 80h
        setne al
        mov edi, dword [byte ebx+018h]
        mov cl, al
        test edi, edi
        setle al
        and eax, 0FFh
        xor eax, ecx
        je short .29
        mov ax, word [DefendFlags]
        db 081h,0E8h,0E0h,01h,00h,00h           ; insn: sub eax,1E0h
        jmp short .30
.29:
        mov ax, word [DefendFlags]
        db 081h,0E8h,0A0h,05h,00h,00h           ; insn: sub eax,5A0h
.30:
        mov word [regd1], ax
        mov eax, dword [dword edx+0EEh]
        mov ecx, dword [byte ebx+038h]
        mov dword [byte eax+08h], ecx
        mov eax, dword [dword edx+0EEh]
        mov ecx, dword [byte ebx+040h]
        mov dword [byte eax+0Ch], ecx
        cmp word [ZoneTargetY], byte 0
        jge short .31
        mov ebx, dword [ZoneTargetX]
        sar ebx, 10h
        neg ebx
        jmp short .32
.31:
        mov ebx, dword [ZoneTargetX]
        sar ebx, 10h
.32:
        cmp ebx, 2D0h
        jge short .33
        mov eax, dword [ZoneFlags]
        sar eax, 10h
        cmp eax, 0FFFFF130h
        jge near .54
        mov word [regd1], 0F130h
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
        jmp near .54
.33:
        mov eax, dword [ZoneFlags]
        sar eax, 10h
        cmp eax, 0FFFFF040h
        jge near .54
        mov word [regd1], 0F040h
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
        jmp near .54
.34:
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl near .42
        cmp byte [dword edx+0A4h], 6
        setb al
        mov ebx, eax
        mov eax, dword [puckc]
        mov cl, byte [eax]
        and ebx, 0FFh
        cmp cl, 6
        setl al
        and eax, 0FFh
        xor eax, ebx
        je near .42
        mov eax, dword [puckc]
        movsx eax, byte [eax]
        mov ebx, eax
        shl ebx, 5
        add ebx, eax
        shl ebx, 3
        add ebx, SortCords
        mov ax, word [dword ebx+0A9h]
        test ax, ax
        jne short .39
        mov bl, byte [dword edx+0106h]
        test bl, 1
        je short .35
        test bl, 10h
        je short .35
        mov ebx, 0F30h
        mov word [ZoneTargetY], ax
        mov word [regd1], bx
        jmp short .38
.35:
        cmp word [dword edx+0ABh], byte 1
        jne short .36
        mov eax, 0FFFFF868h
        jmp short .37
.36:
        mov eax, 798h
.37:
        mov edi, 5D0h
        mov word [ZoneTargetY], ax
        mov word [regd1], di
.38:
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
        jmp near .54
.39:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+05Ah], byte 32h
        jge near .56
        cmp word [dword edx+0ABh], byte 1
        jne short .40
        mov eax, 0FFFFF838h
        jmp short .41
.40:
        mov eax, 7C8h
.41:
        mov ecx, 5D0h
        mov word [ZoneTargetY], ax
        mov word [regd1], cx
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
        jmp near .54
.42:
        mov eax, dword [PtrPuckOwner]
        mov ax, word [eax]
        mov word [DefendFlags], ax
        test byte [dword edx+0BFh], 80h
        jne short .43
        mov esi, eax
        neg esi
        mov word [DefendFlags], si
.43:
        cmp word [DefendFlags], 570h
        jle short .47
        mov eax, dword [dword edx+0102h]
        mov ebx, dword [dword edx+0FEh]
        mov eax, dword [byte eax+012h]
        cmp eax, dword [byte ebx+012h]
        jge short .44
        mov eax, edx
        call FindManToCover
        jmp near .56
.44:
        cmp word [dword edx+0ABh], byte 1
        jne short .45
        mov eax, 0FFFFF868h
        jmp short .46
.45:
        mov eax, 798h
.46:
        mov edi, 5D0h
        mov word [ZoneTargetY], ax
        mov word [regd1], di
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
        jmp near .54
.47:
        cmp word [dword edx+0ABh], byte 1
        jne short .48
        mov ebx, 0FFFFFC04h
        jmp short .49
.48:
        mov ebx, 3FCh
.49:
        mov word [ZoneTargetY], bx
        test byte [dword edx+0BFh], 80h
        jne short .50
        neg ebx
        mov word [ZoneTargetY], bx
.50:
        mov ecx, dword [ZoneTargetX]
        mov eax, dword [PtrPuckTarget]
        sar ecx, 10h
        movsx ebx, word [eax]
        mov esi, ecx
        xor esi, ebx
        test esi, esi
        jl short .51
        mov ax, word [eax]
        mov word [ZoneTargetY], ax
        jmp short .52
.51:
        sar ebx, 1
        add ebx, ecx
        mov word [ZoneTargetY], bx
.52:
        test byte [dword edx+0BFh], 80h
        jne short .53
        neg word [ZoneTargetY]
.53:
        mov ax, word [DefendFlags]
        db 081h,0E8h,0E0h,01h,00h,00h           ; insn: sub eax,1E0h
        mov word [regd1], ax
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [dword edx+0EEh]
        mov ecx, dword [byte eax+038h]
        mov dword [byte ebx+08h], ecx
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [dword edx+0EEh]
        mov ecx, dword [byte eax+040h]
        mov dword [byte ebx+0Ch], ecx
.54:
        test byte [dword edx+0BFh], 80h
        jne short .55
        mov cx, word [regd1]
        mov bx, word [ZoneTargetY]
        neg ecx
        neg ebx
        mov word [regd1], cx
        mov word [ZoneTargetY], bx
.55:
        mov eax, dword [dword edx+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword edx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, edx
        call KeepInsideRink
        mov eax, dword [dword edx+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+018h], 41F00000h
        mov eax, edx
        call SetSkateSpeedFromRating
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+024h], 42C80000h
        mov eax, edx
        call AimAtPuckTarget
.56:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; assextra4                                       22828  96 PC, low confidence
; Placeholder (Abdul 2026-11-15): called from asscentero, asswingo, assdefo,
; assnearest; positioning on offence, not read yet
;-----------------------------------------------------------------------------
assextra4:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 18h
        mov edx, eax
        mov cx, word [byte eax+0Eh]
        mov ebx, dword [PtrPuckOwner]
        movsx esi, cx
        mov eax, dword [byte eax+018h]
        mov bx, word [ebx]
        sar eax, 0Bh
        mov word [GoalieTarget], bx
        add eax, esi
        mov esi, dword [PtrPuckFlags]
        mov edi, dword [ExtraAttacker]
        mov esi, dword [byte esi+018h]
        sar edi, 10h
        sar esi, 0Bh
        add esi, edi
        mov word [DefendFlags], si
        mov bx, word [dword edx+0ABh]
        cmp bx, byte 4
        je short .1
        cmp bx, byte 6
        jne short .2
.1:
        mov bx, word [GoalieTarget]
        mov edi, ExtraAttackerSpots
        mov word [regd1], bx
        jmp short .3
.2:
        mov edi, ExtraAttackerFlags
        mov word [regd1], si
.3:
        test byte [dword edx+0BFh], 80h
        jne short .4
        mov bx, word [regd1]
        mov si, word [GoalieTarget]
        neg ecx
        neg ebx
        neg eax
        mov word [regd1], bx
        mov bx, word [DefendFlags]
        neg esi
        neg ebx
        mov word [GoalieTarget], si
        mov word [DefendFlags], bx
.4:
        mov si, word [DefendFlags]
        cmp si, 570h
        jl short .5
        mov word [regd1], si
.5:
        mov esi, dword [ZoneFlags]
        sar esi, 10h
        xor ebx, ebx
        cmp esi, 0FFFFF310h
        jl near .8
        cmp esi, 0FFFFFA90h
        jl short .7
        mov si, word [regd1]
        mov ebx, 8
        cmp si, 570h
        jl short .8
        test byte [gmode2], 80h
        jne short .8
        mov esi, dword [gameopts]
        test byte [byte esi+01h], 8
        je short .6
        cmp cx, word [GoalieTarget]
        jge short .8
        cmp ax, word [DefendFlags]
        jge short .8
.6:
        mov si, word [DefendFlags]
        add ebx, byte 4
        cmp si, 10B0h
        jl short .8
        add ebx, byte 4
        jmp short .8
.7:
        mov eax, dword [ExtraAttacker]
        mov ecx, dword [DefendTarget]
        sar eax, 10h
        sar ecx, 10h
        sub eax, byte 30h
        cmp ecx, eax
        jl short .8
        mov ebx, 4
.8:
        cmp bx, word [byte edx+068h]
        jne near .13
        fild word [byte edx+06h]
        fstp dword [esp]
        mov eax, dword [dword edx+0EEh]
        fld dword [esp]
        fsub dword [eax]
        fldz
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jbe short .9
        fld dword [byte esp+0Ch]
        fchs
        fstp dword [byte esp+010h]
        jmp short .10
.9:
        mov eax, dword [byte esp+0Ch]
        mov dword [byte esp+010h], eax
.10:
        fld dword [byte esp+010h]
        fcomp dword [F32_192]
        fnstsw ax
        sahf
        jae near .21
        fild word [byte edx+0Eh]
        fstp dword [byte esp+04h]
        mov eax, dword [dword edx+0EEh]
        fld dword [byte esp+04h]
        fsub dword [byte eax+04h]
        fldz
        fxch
        fstp dword [byte esp+014h]
        fcomp dword [byte esp+014h]
        fnstsw ax
        sahf
        jbe short .11
        fld dword [byte esp+014h]
        fchs
        fstp dword [byte esp+08h]
        jmp short .12
.11:
        mov eax, dword [byte esp+014h]
        mov dword [byte esp+08h], eax
.12:
        fld dword [byte esp+08h]
        fcomp dword [F32_192]
        fnstsw ax
        sahf
        jae near .21
.13:
        movsx eax, bx
        add eax, eax
        lea ecx, [edi+eax]
        mov word [byte edx+068h], bx
        mov ax, word [byte ecx+02h]
        add eax, eax
        cwde
        call randomd0
        mov si, word [byte ecx+02h]
        sub eax, esi
        mov esi, eax
        mov ax, word [ecx]
        add eax, esi
        mov word [ZoneTargetY], ax
        mov ax, word [byte ecx+06h]
        add eax, eax
        cwde
        call randomd0
        mov di, word [byte ecx+06h]
        mov cx, word [byte ecx+04h]
        sub eax, edi
        add eax, ecx
        mov cx, word [DefendFlags]
        mov word [regd1], ax
        cmp ax, cx
        jge short .14
        mov eax, 1E0h
        call randomd0
        add word [regd1], ax
.14:
        cmp word [dword edx+0ABh], byte 3
        jne short .15
        neg word [ZoneTargetY]
.15:
        test byte [dword edx+0BFh], 80h
        jne short .17
        cmp word [dword edx+0ABh], byte 4
        je short .16
        neg word [ZoneTargetY]
.16:
        neg word [regd1]
.17:
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [dword edx+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword edx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, edx
        call KeepInsideRink
        mov eax, dword [dword edx+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+018h], 42200000h
        mov eax, edx
        call SetSkateSpeedFromRating
        mov eax, edx
        call AimAtPuckTarget
        cmp bx, byte 8
        jne short .20
        test byte [dword edx+0BFh], 80h
        je short .19
        mov ecx, dword [PtrPuckOwner]
        mov ax, word [byte edx+0Eh]
        cmp ax, word [ecx]
        jge short .18
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+024h], 43160000h
        jmp short .21
.18:
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+024h], 42A00000h
        jmp short .21
.19:
        mov eax, dword [PtrPuckOwner]
        mov bx, word [byte edx+0Eh]
        cmp bx, word [eax]
        jle short .18
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+024h], 43160000h
        jmp short .21
.20:
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+024h], 42C80000h
.21:
        add esp, byte 18h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; assdefo                                           22B8C  94G, low confidence
; assignment 0Bh, defenceman on offence (SwapPosition,
; assextra4)
;-----------------------------------------------------------------------------
assdefo:
        push ebx
        push ecx
        push edx
        push edi
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .6
        mov eax, ebx
        call check4bench
        test ax, ax
        jne near .6
        test byte [gmode], 1
        je short .1
        mov ah, byte [dword ebx+0BFh]
        test ah, 20h
        jne near .6
        test ah, 8
        jne near .6
        mov edx, 8
        mov eax, ebx
        call doplayeracc
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov dh, byte [dword ebx+0BFh]
        test dh, 8
        jne near .6
        test dh, 2
        je short .2
        mov dword [byte ebx+05Ah], 0
        mov eax, dword [byte ebx+05Ah]
        mov ch, dh
        mov dword [byte ebx+056h], eax
        and ch, 0FDh
        mov eax, dword [dword ebx+0EEh]
        mov byte [dword ebx+0BFh], ch
        and byte [byte eax+029h], 0DFh
.2:
        mov edx, dword [byte ebx+05Ah]
        sub edx, byte 2
        mov dword [byte ebx+05Ah], edx
        test edx, edx
        jge short .3
        xor eax, eax
        mov al, byte [dword ebx+0C6h]
        mov dword [byte ebx+05Ah], eax
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .3
        cmp byte [dword ebx+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [puckc]
        mov ch, byte [eax]
        and edx, 0FFh
        cmp ch, 6
        setl al
        and eax, 0FFh
        xor eax, edx
        je short .3
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 3
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword ebx+0BFh], 2
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        cmp word [dword ebx+0ABh], byte 2
        jle short .4
        cmp dword [dword ebx+0ADh], byte 0
        jge short .4
        mov edx, dword [dword ebx+0A7h]
        mov eax, ebx
        sar edx, 10h
        call SwapPosition
.4:
        mov eax, ebx
        call ChkSwapWithPartner
        mov edi, dword [byte ebx+056h]
        sub edi, byte 2
        mov dword [byte ebx+056h], edi
        test edi, edi
        jge short .6
        xor eax, eax
        mov al, byte [dword ebx+0C5h]
        mov cx, word [dword ebx+0ABh]
        mov dword [byte ebx+056h], eax
        cmp cx, byte 2
        jle short .5
        mov eax, ebx
        call assextra4
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov eax, ebx
        call DefendPuck
.6:
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; asswingo                                          22CEC  94G, low confidence
; assignment 0Ch, winger on offence
;-----------------------------------------------------------------------------
asswingo:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .5
        mov eax, ebx
        call check4bench
        test ax, ax
        jne near .5
        test byte [gmode], 1
        je short .1
        mov dl, byte [dword ebx+0BFh]
        test dl, 20h
        jne near .5
        test dl, 8
        jne near .5
        mov edx, 8
        mov eax, ebx
        call doplayeracc
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov dh, byte [dword ebx+0BFh]
        test dh, 8
        jne near .5
        test dh, 2
        je short .2
        mov word [byte ebx+068h], 0FFFFh
        mov dword [byte ebx+05Ah], 0
        mov eax, dword [byte ebx+05Ah]
        mov ch, dh
        mov dword [byte ebx+056h], eax
        and ch, 0FDh
        mov eax, dword [dword ebx+0EEh]
        mov byte [dword ebx+0BFh], ch
        and byte [byte eax+029h], 0DFh
.2:
        mov edx, dword [byte ebx+05Ah]
        sub edx, byte 2
        mov dword [byte ebx+05Ah], edx
        test edx, edx
        jge near .4
        xor eax, eax
        mov al, byte [dword ebx+0C6h]
        mov dword [byte ebx+05Ah], eax
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl near .4
        cmp byte [dword ebx+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [puckc]
        mov ch, byte [eax]
        and edx, 0FFh
        cmp ch, 6
        setl al
        and eax, 0FFh
        xor eax, edx
        je near .4
        mov edx, dword [puckc]
        movsx edx, byte [edx]
        mov eax, edx
        shl eax, 5
        add eax, edx
        cmp word [nosplit eax*8+PlayerAssignWords], byte 0
        jg short .3
        test byte [gmode2], 20h
        je short .4
        mov al, byte [dword ebx+0BFh]
        xor edx, edx
        and al, 40h
        mov dl, al
        mov ax, word [gmode2]
        xor ah, ah
        and al, 40h
        cwde
        xor eax, edx
        je short .4
.3:
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 4
        mov byte [dword ebx+eax+0B2h], dl
        mov ah, byte [dword ebx+0BFh]
        mov edx, dword [dword ebx+0A7h]
        or ah, 2
        sar edx, 10h
        mov byte [dword ebx+0BFh], ah
        mov eax, ebx
        call SwapPosition
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov esi, dword [byte ebx+056h]
        sub esi, byte 2
        mov dword [byte ebx+056h], esi
        test esi, esi
        jge short .5
        xor eax, eax
        mov al, byte [dword ebx+0C5h]
        mov dword [byte ebx+056h], eax
        mov eax, ebx
        call assextra4
.5:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; asscentero                                        22E70  94G, low confidence
; assignment 0Dh, centre on offence
;-----------------------------------------------------------------------------
asscentero:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .5
        mov eax, ebx
        call check4bench
        test ax, ax
        jne near .5
        test byte [gmode], 1
        je short .1
        mov dl, byte [dword ebx+0BFh]
        test dl, 20h
        jne near .5
        test dl, 8
        jne near .5
        mov edx, 8
        mov eax, ebx
        call doplayeracc
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov dh, byte [dword ebx+0BFh]
        test dh, 8
        jne near .5
        test dh, 2
        je short .2
        mov word [byte ebx+068h], 0FFFFh
        mov dword [byte ebx+05Ah], 0
        mov eax, dword [byte ebx+05Ah]
        mov ch, dh
        mov dword [byte ebx+056h], eax
        and ch, 0FDh
        mov eax, dword [dword ebx+0EEh]
        mov byte [dword ebx+0BFh], ch
        and byte [byte eax+029h], 0DFh
.2:
        mov edx, dword [byte ebx+05Ah]
        sub edx, byte 2
        mov dword [byte ebx+05Ah], edx
        test edx, edx
        jge near .4
        xor eax, eax
        mov al, byte [dword ebx+0C6h]
        mov dword [byte ebx+05Ah], eax
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl near .4
        cmp byte [dword ebx+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [puckc]
        mov ch, byte [eax]
        and edx, 0FFh
        cmp ch, 6
        setl al
        and eax, 0FFh
        xor eax, edx
        je near .4
        mov edx, dword [puckc]
        movsx edx, byte [edx]
        mov eax, edx
        shl eax, 5
        add eax, edx
        cmp word [nosplit eax*8+PlayerAssignWords], byte 0
        jg short .3
        test byte [gmode2], 20h
        je short .4
        mov al, byte [dword ebx+0BFh]
        xor edx, edx
        and al, 40h
        mov dl, al
        mov ax, word [gmode2]
        xor ah, ah
        and al, 40h
        cwde
        xor eax, edx
        je short .4
.3:
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 5
        mov byte [dword ebx+eax+0B2h], dl
        mov ah, byte [dword ebx+0BFh]
        or ah, 2
        mov edx, 4
        mov byte [dword ebx+0BFh], ah
        mov eax, ebx
        call SwapPosition
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov esi, dword [byte ebx+056h]
        sub esi, byte 2
        mov dword [byte ebx+056h], esi
        test esi, esi
        jge short .5
        xor eax, eax
        mov al, byte [dword ebx+0C5h]
        mov dword [byte ebx+056h], eax
        mov eax, ebx
        call assextra4
.5:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FindManToCover                                  22FF0  97 PC, low confidence
; Picks the opposing skater a defending player covers, by side and distance
;-----------------------------------------------------------------------------
FindManToCover:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov esi, eax
        cmp byte [dword eax+0A4h], 6
        jae short .1
        mov eax, 6
        jmp short .2
.1:
        xor eax, eax
.2:
        mov edx, eax
        shl eax, 5
        add eax, edx
        shl eax, 3
        mov dx, word [dword esi+0ABh]
        add eax, SortCords
        cmp dx, byte 2
        jne short .3
        mov edx, 3FCh
        jmp short .4
.3:
        mov edx, 0FFFFFC04h
.4:
        mov word [ZoneTargetY], dx
        test byte [dword esi+0BFh], 80h
        je short .5
        mov edx, 12C0h
        jmp short .6
.5:
        mov edx, 0FFFFED40h
.6:
        mov dword [regd1], edx
        xor edx, edx
.7:
        test byte [dword eax+0C0h], 4
        jne near .14
        cmp word [dword eax+0A9h], byte 0
        jl near .14
        test byte [dword esi+0BFh], 80h
        je short .10
        mov ebx, dword [byte eax+018h]
        mov dword [GoalieTarget], ebx
        test ebx, ebx
        jle short .8
        mov ebx, dword [byte eax+0Ch]
        sar ebx, 10h
        jmp short .9
.8:
        mov ecx, dword [byte eax+0Ch]
        sar ebx, 0Bh
        sar ecx, 10h
        add ebx, ecx
.9:
        mov dword [GoalieTarget], ebx
        mov ebp, dword [regd1]
        mov ebx, dword [GoalieTarget]
        cmp ebx, ebp
        jge short .14
        jmp short .13
.10:
        mov ebx, dword [byte eax+018h]
        mov dword [GoalieTarget], ebx
        test ebx, ebx
        jge short .11
        mov ebx, dword [byte eax+0Ch]
        sar ebx, 10h
        mov dword [GoalieTarget], ebx
        jmp short .12
.11:
        mov ecx, dword [GoalieTarget]
        mov ebx, dword [byte eax+0Ch]
        sar ecx, 0Bh
        sar ebx, 10h
        add ecx, ebx
        mov dword [GoalieTarget], ecx
.12:
        mov ecx, dword [regd1]
        mov ebx, dword [GoalieTarget]
        cmp ebx, ecx
        jle short .14
.13:
        mov dword [regd1], ebx
.14:
        inc edx
        add eax, 108h
        cmp edx, byte 6
        jl near .7
        test byte [dword esi+0BFh], 80h
        je short .17
        mov eax, dword [regd1]
        cmp eax, 0FFFFF4F0h
        jle short .15
        lea ecx, [dword eax-0168h]
        mov dword [regd1], ecx
        jmp short .16
.15:
        jle short .16
        lea ebx, [dword eax-0B4h]
        mov dword [regd1], ebx
.16:
        cmp dword [regd1], 0FFFFF220h
        jg short .21
        mov dword [regd1], 0FFFFF0B8h
        jmp short .21
.17:
        mov eax, dword [regd1]
        cmp eax, 0B10h
        jge short .18
        lea ecx, [dword eax+0168h]
        mov dword [regd1], ecx
        jmp short .19
.18:
        jge short .19
        lea ebx, [dword eax+0B4h]
        mov dword [regd1], ebx
.19:
        cmp dword [regd1], 0DE0h
        jl short .20
        mov dword [regd1], 0F48h
.20:
        neg word [ZoneTargetY]
.21:
        mov edx, dword [ZoneTargetX]
        mov eax, dword [PtrPuckTarget]
        sar edx, 10h
        movsx eax, word [eax]
        xor eax, edx
        test eax, eax
        jge short .25
        xor edi, edi
        mov eax, dword [regd1]
        mov word [ZoneTargetY], di
        test eax, eax
        jge short .22
        neg eax
.22:
        cmp eax, 0F48h
        jne short .25
        cmp dword [regd1], byte 0
        jge short .23
        mov eax, 0FFFFF130h
        jmp short .24
.23:
        mov eax, 0ED0h
.24:
        mov dword [regd1], eax
.25:
        cmp dword [regd1], 1230h
        jle short .26
        mov dword [regd1], 1230h
.26:
        cmp dword [regd1], 0FFFFEDD0h
        jge short .27
        mov dword [regd1], 0FFFFEDD0h
.27:
        mov eax, dword [dword esi+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword esi+0EEh]
        fild dword [regd1]
        fstp dword [byte eax+04h]
        mov eax, esi
        call KeepInsideRink
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+018h], 41C80000h
        mov eax, esi
        call SetSkateSpeedFromRating
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+024h], 42C80000h
        mov eax, esi
        call AimAtPuckTarget
        mov eax, esi
        call FaceDirFromMotion
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; assextra3                                       23284  96 PC, low confidence
; Placeholder (Abdul 2026-11-15): called from asscenterd, asswingd,
; assnearest; forwards' positioning on defence, not read yet
;-----------------------------------------------------------------------------
assextra3:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edx, eax
        mov eax, dword [dword eax+0FEh]
        cmp word [byte eax+010h], byte 0
        setge al
        mov ebx, eax
        mov eax, dword [dword edx+0FEh]
        mov eax, dword [byte eax+0Ch]
        and ebx, 0FFh
        sar eax, 10h
        sub eax, ebx
        mov ebx, dword [dword edx+0102h]
        cmp word [byte ebx+010h], byte 0
        setge bl
        mov ecx, ebx
        mov ebx, dword [dword edx+0102h]
        mov ebx, dword [byte ebx+0Ch]
        and ecx, 0FFh
        sar ebx, 10h
        sub ebx, ecx
        cmp ebx, eax
        jle near .21
        cmp eax, byte 3
        jne near .7
        mov eax, dword [PtrPuckTarget]
        movsx eax, word [eax]
        sar eax, 1
        mov word [ZoneTargetY], ax
        mov eax, dword [PtrPuckOwner]
        mov ax, word [eax]
        mov word [GoalieTarget], ax
        test byte [dword edx+0BFh], 80h
        jne short .1
        mov ebx, eax
        neg ebx
        mov word [GoalieTarget], bx
.1:
        mov eax, dword [ExtraAttacker]
        mov ecx, 0FFFFF9A0h
        sar eax, 10h
        mov word [regd1], cx
        cmp eax, 0FFFFFA90h
        jl short .3
        sub eax, 660h
        sar eax, 1
        mov word [regd1], ax
        cmp word [GoalieTarget], 570h
        jle short .2
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jge short .2
        cmp word [regd1], 480h
        jge short .2
        mov word [regd1], 420h
.2:
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [dword edx+0EEh]
        mov ecx, dword [byte eax+038h]
        mov dword [byte ebx+08h], ecx
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [dword edx+0EEh]
        mov ecx, dword [byte eax+040h]
        mov dword [byte ebx+0Ch], ecx
        jmp short .6
.3:
        cmp eax, 0FFFFF190h
        jge short .4
        mov word [regd1], 0F310h
        jmp short .5
.4:
        cmp eax, 0FFFFF8B0h
        jle short .5
        mov word [regd1], 0F8B0h
.5:
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
.6:
        test byte [dword edx+0BFh], 80h
        jne near .34
        neg word [regd1]
        jmp near .34
.7:
        cmp eax, byte 4
        jne near .21
        cmp word [dword edx+0ABh], byte 3
        sete al
        mov ebx, eax
        mov eax, dword [PtrPuckTarget]
        mov cx, word [eax]
        and ebx, 0FFh
        test cx, cx
        setl al
        and eax, 0FFh
        mov cl, byte [dword edx+0BFh]
        xor ebx, eax
        test cl, 80h
        sete al
        and eax, 0FFh
        xor eax, ebx
        je short .13
        mov eax, dword [PtrPuckTarget]
        mov di, word [eax]
        test di, di
        jge short .8
        movsx eax, di
        neg eax
        jmp short .9
.8:
        movsx eax, di
.9:
        cmp eax, 550h
        jle short .10
        xor ebx, ebx
        mov word [ZoneTargetY], bx
        jmp short .14
.10:
        cmp word [dword edx+0ABh], byte 3
        jne short .11
        mov eax, 0FFFFFD58h
        jmp short .12
.11:
        mov eax, 2A8h
.12:
        mov word [ZoneTargetY], ax
        jmp short .14
.13:
        mov eax, dword [PtrPuckTarget]
        movsx eax, word [eax]
        sar eax, 1
        mov word [ZoneTargetY], ax
        test byte [dword edx+0BFh], 80h
        jne short .14
        mov esi, eax
        neg esi
        mov word [ZoneTargetY], si
.14:
        mov eax, dword [PtrPuckOwner]
        mov ax, word [eax]
        mov word [GoalieTarget], ax
        test byte [dword edx+0BFh], 80h
        jne short .15
        mov si, word [GoalieTarget]
        mov cx, word [ZoneTargetY]
        neg esi
        neg ecx
        mov word [GoalieTarget], si
        mov word [ZoneTargetY], cx
.15:
        mov eax, dword [ExtraAttacker]
        mov edi, 0FFFFF9A0h
        sar eax, 10h
        mov word [regd1], di
        cmp eax, 0FFFFFA90h
        jl short .17
        sub eax, 660h
        sar eax, 1
        mov cx, word [GoalieTarget]
        mov word [regd1], ax
        cmp cx, 570h
        jle short .16
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jge short .16
        cmp word [regd1], 480h
        jge short .16
        mov word [regd1], 420h
.16:
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [dword edx+0EEh]
        mov ecx, dword [byte eax+038h]
        mov dword [byte ebx+08h], ecx
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [dword edx+0EEh]
        mov ecx, dword [byte eax+040h]
        mov dword [byte ebx+0Ch], ecx
        jmp short .20
.17:
        cmp eax, 0FFFFF190h
        jge short .18
        mov word [regd1], 0F6D0h
        jmp short .19
.18:
        cmp eax, 0FFFFF8B0h
        jle short .19
        mov word [regd1], 0F8B0h
.19:
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
.20:
        test byte [dword edx+0BFh], 80h
        jne near .34
        neg word [regd1]
        jmp near .34
.21:
        cmp word [dword edx+0ABh], byte 4
        jne near .24
        mov eax, dword [PtrPuckTarget]
        movsx eax, word [eax]
        sar eax, 1
        mov word [ZoneTargetY], ax
        mov word [regd1], 0F2B0h
        mov eax, dword [PtrPuckOwner]
        mov ax, word [eax]
        mov word [GoalieTarget], ax
        test byte [dword edx+0BFh], 80h
        jne short .22
        neg word [GoalieTarget]
.22:
        mov eax, dword [ExtraAttacker]
        sar eax, 10h
        cmp eax, 0FFFFFA90h
        jl short .23
        mov ebx, dword [ZoneFlags]
        sar ebx, 10h
        add eax, ebx
        sar eax, 1
        mov cx, word [GoalieTarget]
        mov word [regd1], ax
        cmp cx, 570h
        jle short .23
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jge short .23
        mov eax, dword [PtrPuckTarget]
        mov ax, word [eax]
        mov esi, 630h
        mov word [ZoneTargetY], ax
        mov word [regd1], si
.23:
        test byte [dword edx+0BFh], 80h
        jne near .33
        neg word [regd1]
        jmp near .33
.24:
        mov eax, dword [PtrPuckTarget]
        mov ax, word [eax]
        mov word [ZoneTargetY], ax
        mov eax, dword [ZoneTargetX]
        sar eax, 10h
        add eax, 7F8h
        sar eax, 1
        mov word [ZoneTargetY], ax
        test byte [dword edx+0BFh], 80h
        setne al
        mov ebx, eax
        mov di, word [dword edx+0ABh]
        and ebx, 0FFh
        cmp di, byte 5
        sete al
        and eax, 0FFh
        xor eax, ebx
        je short .25
        sub word [ZoneTargetY], 7F8h
.25:
        mov ecx, 540h
        mov ebx, 750h
        mov word [GoalieTarget], cx
        mov word [regd1], bx
        test byte [dword edx+0BFh], 80h
        je near .30
        mov eax, 0FFFFF8B0h
        mov ebx, 0FFFFFAC0h
        mov word [regd1], ax
        mov eax, dword [puckc]
        mov word [GoalieTarget], bx
        cmp byte [eax], 0
        jl short .26
        cmp byte [dword edx+0A4h], 6
        setb al
        mov ebx, eax
        mov eax, dword [puckc]
        mov cl, byte [eax]
        and ebx, 0FFh
        cmp cl, 6
        setl al
        and eax, 0FFh
        cmp eax, ebx
        jne short .26
        test byte [gmode2], 80h
        je short .26
        mov eax, dword [ExtraAttacker]
        mov ebx, dword [byte edx+0Ch]
        sar eax, 10h
        sar ebx, 10h
        neg eax
        cmp ebx, eax
        jle short .26
        mov ax, word [GoalieTarget]
        mov edi, eax
        mov word [regd1], ax
        neg edi
        mov word [regd1], di
        jmp near .33
.26:
        mov eax, dword [PtrPuckOwner]
        mov bx, word [GoalieTarget]
        mov cx, word [eax]
        cmp bx, cx
        jg short .27
        mov word [regd1], cx
        jmp near .33
.27:
        mov ecx, dword [ZoneTargetX]
        mov ebx, dword [PtrPuckTarget]
        sar ecx, 10h
        movsx ebx, word [ebx]
        xor ebx, ecx
        test ebx, ebx
        jge near .33
        mov si, word [eax]
        test si, si
        jge short .28
        movsx eax, si
        neg eax
        jmp short .29
.28:
        movsx eax, si
.29:
        sub eax, 0B40h
        mov ebx, dword [ZoneFlags]
        sar eax, 1
        sar ebx, 10h
        sub ebx, eax
        sub ebx, 0F0h
        mov word [regd1], bx
        jmp near .33
.30:
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .31
        cmp byte [dword edx+0A4h], 6
        setb al
        mov ebx, eax
        mov eax, dword [puckc]
        mov ch, byte [eax]
        and ebx, 0FFh
        cmp ch, 6
        setl al
        and eax, 0FFh
        cmp eax, ebx
        jne short .31
        test byte [gmode2], 80h
        je short .31
        mov eax, dword [ExtraAttacker]
        mov ebx, dword [byte edx+0Ch]
        sar eax, 10h
        sar ebx, 10h
        neg eax
        cmp ebx, eax
        jge short .31
        mov ax, word [GoalieTarget]
        mov edi, eax
        mov word [regd1], ax
        neg edi
        mov word [regd1], di
        jmp short .33
.31:
        mov eax, dword [PtrPuckOwner]
        mov bx, word [GoalieTarget]
        mov si, word [eax]
        cmp bx, si
        jl short .32
        mov word [regd1], si
        jmp short .33
.32:
        mov ecx, dword [ZoneTargetX]
        mov ebx, dword [PtrPuckTarget]
        sar ecx, 10h
        movsx ebx, word [ebx]
        xor ebx, ecx
        test ebx, ebx
        jge short .33
        movsx eax, si
        mov ebx, dword [ZoneFlags]
        sub eax, 0B40h
        sar ebx, 10h
        sar eax, 1
        add eax, ebx
        add eax, 0F0h
        mov word [regd1], ax
.33:
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
.34:
        mov eax, dword [dword edx+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword edx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, edx
        call KeepInsideRink
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+018h], 41F00000h
        mov eax, edx
        call SetSkateSpeedFromRating
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+024h], 42C80000h
        mov eax, edx
        call AimAtPuckTarget
        mov eax, edx
        call FaceDirFromMotion
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; assdefd                                        238E8  94G, medium confidence
; assignment 3 (Setplass list for defence), defenceman on
; defence
;-----------------------------------------------------------------------------
assdefd:
        push ebx
        push ecx
        push edx
        push edi
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .7
        mov eax, ebx
        call check4bench
        test ax, ax
        jne near .7
        test byte [gmode], 1
        je short .1
        mov al, byte [dword ebx+0BFh]
        test al, 20h
        jne near .7
        test al, 8
        jne near .7
        mov edx, 8
        mov eax, ebx
        call doplayeracc
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov dh, byte [dword ebx+0BFh]
        test dh, 8
        jne near .7
        test dh, 2
        je short .2
        mov dword [byte ebx+05Ah], 0
        mov ch, dh
        mov eax, dword [byte ebx+05Ah]
        and ch, 0FDh
        mov dword [byte ebx+056h], eax
        mov byte [dword ebx+0BFh], ch
.2:
        mov edx, dword [dword ebx+0ADh]
        test edx, edx
        jl short .4
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov ecx, SortCords
        shl eax, 3
        add ecx, eax
        mov ax, word [byte ebx+0Eh]
        cmp ax, word [byte ecx+0Eh]
        setg al
        mov edx, eax
        mov ah, byte [dword ebx+0BFh]
        and edx, 0FFh
        test ah, 80h
        setne al
        and eax, 0FFh
        xor eax, edx
        je short .4
        cmp word [dword ebx+0ABh], byte 2
        jle short .3
        mov edx, dword [dword ebx+0A7h]
        mov eax, ebx
        sar edx, 10h
        call SwapPosition
.3:
        mov dword [dword ecx+0ADh], 0FFFFFFFFh
        mov eax, dword [dword ecx+0ADh]
        mov dword [dword ebx+0ADh], eax
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov ecx, dword [byte ebx+056h]
        sub ecx, byte 2
        mov dword [byte ebx+056h], ecx
        test ecx, ecx
        jge short .5
        xor eax, eax
        mov al, byte [dword ebx+0C5h]
        mov dword [byte ebx+056h], eax
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .5
        cmp byte [dword ebx+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [puckc]
        mov cl, byte [eax]
        and edx, 0FFh
        cmp cl, 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        jne short .5
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 0Bh
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword ebx+0BFh], 2
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov edi, dword [byte ebx+05Ah]
        sub edi, byte 2
        mov dword [byte ebx+05Ah], edi
        test edi, edi
        jge short .6
        xor eax, eax
        mov al, byte [dword ebx+0C6h]
        mov dword [byte ebx+05Ah], eax
        mov eax, ebx
        call FindManToCover
.6:
        mov eax, ebx
        call ChkPokeOrCheck
.7:
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; asswingd                                       23A78  94G, medium confidence
; assignment 4 (Setplass list for wings), winger on defence
;-----------------------------------------------------------------------------
asswingd:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .4
        mov eax, ebx
        call check4bench
        test ax, ax
        jne near .4
        test byte [gmode], 1
        je short .1
        mov al, byte [dword ebx+0BFh]
        test al, 20h
        jne near .4
        test al, 8
        jne near .4
        mov edx, 8
        mov eax, ebx
        call doplayeracc
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov dh, byte [dword ebx+0BFh]
        test dh, 8
        jne near .4
        test dh, 2
        je short .2
        mov dword [byte ebx+05Ah], 0
        mov ch, dh
        mov eax, dword [byte ebx+05Ah]
        and ch, 0FDh
        mov dword [byte ebx+056h], eax
        mov byte [dword ebx+0BFh], ch
.2:
        mov edx, dword [byte ebx+056h]
        sub edx, byte 2
        mov dword [byte ebx+056h], edx
        test edx, edx
        jge short .3
        xor eax, eax
        mov al, byte [dword ebx+0C5h]
        mov dword [byte ebx+056h], eax
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .3
        cmp byte [dword ebx+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [puckc]
        mov cl, byte [eax]
        and edx, 0FFh
        cmp cl, 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        jne short .3
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        mov eax, 0Ch
        mov byte [dword edx+ebx+0B2h], al
        or byte [dword ebx+0BFh], 2
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov esi, dword [byte ebx+05Ah]
        sub esi, byte 2
        mov dword [byte ebx+05Ah], esi
        test esi, esi
        jge short .4
        xor eax, eax
        mov al, byte [dword ebx+0C6h]
        mov dword [byte ebx+05Ah], eax
        mov eax, ebx
        call assextra3
.4:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; asscenterd                                     23B88  94G, medium confidence
; assignment 5 (Setplass list for the centre), centre on
; defence
;-----------------------------------------------------------------------------
asscenterd:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .4
        mov eax, ebx
        call check4bench
        test ax, ax
        jne near .4
        test byte [gmode], 1
        je short .1
        mov al, byte [dword ebx+0BFh]
        test al, 20h
        jne near .4
        test al, 8
        jne near .4
        mov edx, 8
        mov eax, ebx
        call doplayeracc
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov dh, byte [dword ebx+0BFh]
        test dh, 8
        jne near .4
        test dh, 2
        je short .2
        mov dword [byte ebx+05Ah], 0
        mov ch, dh
        mov eax, dword [byte ebx+05Ah]
        and ch, 0FDh
        mov dword [byte ebx+056h], eax
        mov byte [dword ebx+0BFh], ch
.2:
        mov edx, dword [byte ebx+056h]
        sub edx, byte 2
        mov dword [byte ebx+056h], edx
        test edx, edx
        jge short .3
        xor eax, eax
        mov al, byte [dword ebx+0C5h]
        mov dword [byte ebx+056h], eax
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .3
        cmp byte [dword ebx+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [puckc]
        mov cl, byte [eax]
        and edx, 0FFh
        cmp cl, 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        jne short .3
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        mov eax, 0Dh
        mov byte [dword edx+ebx+0B2h], al
        or byte [dword ebx+0BFh], 2
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov esi, dword [byte ebx+05Ah]
        sub esi, byte 2
        mov dword [byte ebx+05Ah], esi
        test esi, esi
        jge short .4
        xor eax, eax
        mov al, byte [dword ebx+0C6h]
        mov dword [byte ebx+05Ah], eax
        mov eax, ebx
        call assextra3
.4:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; asstofaceoff                                    23C98  97 PC, low confidence
; Assignment 6: a player skates to his faceoff spot (or to the bench, or to
; the side for a penalty shot)
;-----------------------------------------------------------------------------
asstofaceoff:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 1Ch
        mov edx, eax
        test byte [dword eax+0BFh], 20h
        jne near .11
        mov eax, edx
        call check4bench
        test ax, ax
        jne near .11
        mov bl, byte [dword edx+0BFh]
        test bl, 2
        je near .6
        mov cl, byte [dword edx+0C0h]
        mov bh, bl
        or cl, 20h
        and bh, 0FDh
        mov byte [dword edx+0C0h], cl
        mov byte [dword edx+0BFh], bh
        cmp word [penshotmode], byte 0
        je near .5
        mov cx, word [FaceoffRequest]
        mov al, byte [dword edx+0A4h]
        cmp ax, cx
        jne near .5
        xor esi, esi
        mov word [ZoneTargetY], si
        test byte [dword edx+0BFh], 80h
        je short .1
        mov eax, 0FFFFFF70h
        jmp short .2
.1:
        mov eax, 90h
.2:
        mov word [regd1], ax
        mov eax, dword [dword edx+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword edx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword edx+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
        test byte [dword edx+0BFh], 80h
        je short .3
        xor ecx, ecx
        mov dword [byte esp+018h], ecx
        jmp short .4
.3:
        mov dword [byte esp+018h], 8000h
.4:
        mov eax, dword [dword edx+0EEh]
        fild dword [byte esp+018h]
        fstp dword [byte eax+010h]
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+014h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, edx
        call SetSkateSpeedFromRating
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+024h], 42C80000h
        or byte [dword edx+0C0h], 4
        jmp short .6
.5:
        mov eax, edx
        call FaceoffSpotPosition
.6:
        fild word [byte edx+06h]
        fstp dword [byte esp+04h]
        mov eax, dword [dword edx+0EEh]
        fld dword [byte esp+04h]
        fsub dword [eax]
        fldz
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jbe short .7
        fld dword [byte esp+0Ch]
        fchs
        fstp dword [byte esp+014h]
        jmp short .8
.7:
        mov eax, dword [byte esp+0Ch]
        mov dword [byte esp+014h], eax
.8:
        fld dword [byte esp+014h]
        fcomp dword [F32_48]
        fnstsw ax
        sahf
        ja short .11
        fild word [byte edx+0Eh]
        fstp dword [esp]
        mov eax, dword [dword edx+0EEh]
        fld dword [esp]
        fsub dword [byte eax+04h]
        fldz
        fxch
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        jbe short .9
        fld dword [byte esp+010h]
        fchs
        fstp dword [byte esp+08h]
        jmp short .10
.9:
        mov eax, dword [byte esp+010h]
        mov dword [byte esp+08h], eax
.10:
        fld dword [byte esp+08h]
        fcomp dword [F32_48]
        fnstsw ax
        sahf
        ja short .11
        mov al, byte [dword edx+0B1h]
        mov ch, byte [dword edx+0BFh]
        mov dword [byte edx+060h], 0FFFFFF9Ch
        inc al
        or ch, 2
        and al, 7
        mov byte [dword edx+0BFh], ch
        mov byte [dword edx+0B1h], al
.11:
        add esp, byte 1Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; assfaceoff                                     23E90  94G, medium confidence
; assignment 7, players idle until the faceoff is over
; (puckfaceoff2 gives it to everyone but the centre)
;-----------------------------------------------------------------------------
assfaceoff:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+028h]
        mov dl, byte [dword ecx+0BFh]
        and eax, 0FFFFh
        test dl, 20h
        jne near .3
        test byte [gmode2], 1
        jne short .2
        cmp eax, byte 0Ch
        je short .1
        mov eax, ecx
        call PickSkateAnim
.1:
        mov al, byte [dword ecx+0B1h]
        mov bh, byte [dword ecx+0BFh]
        inc al
        or bh, 2
        and al, 7
        mov byte [dword ecx+0BFh], bh
        mov byte [dword ecx+0B1h], al
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        cmp eax, byte 0Ch
        jne short .3
        mov eax, 28h
        call randomd0
        xor edx, edx
        cmp ax, 2
        setl al
        mov dl, al
        test edx, edx
        je short .3
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        push dword 3F800000h
        mov byte [dword ecx+0BFh], bl
        xor ebx, ebx
        test edx, edx
        sete al
        xor edx, edx
        mov dl, al
        add edx, byte 56h
        mov eax, ecx
        call SetSPA
.3:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; assfaceoffpl                                   23F44  94G, medium confidence
; assignment 8, the faceoff player (puckfaceoff2 gives it
; to the centre)
;-----------------------------------------------------------------------------
assfaceoffpl:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        test byte [gmode2], 1
        jne short .1
        mov al, byte [dword ebx+0B1h]
        mov ch, byte [dword ebx+0BFh]
        mov dword [byte ebx+064h], 14h
        inc al
        or ch, 2
        and al, 7
        mov byte [dword ebx+0BFh], ch
        mov byte [dword ebx+0B1h], al
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov dl, byte [dword ebx+0BFh]
        test dl, 20h
        jne near .18
        test dl, 2
        je short .3
        mov cl, dl
        and cl, 0FDh
        mov byte [dword ebx+0BFh], cl
        test cl, 40h
        je short .2
        mov eax, 0Ah
        call randomd0
        cwde
        add eax, byte 1Eh
        mov dword [byte ebx+060h], eax
        jmp short .3
.2:
        mov dword [byte ebx+060h], 28h
.3:
        test byte [dword ebx+0BFh], 8
        jne near .18
        mov edx, dword [byte ebx+060h]
        dec edx
        mov dword [byte ebx+060h], edx
        test edx, edx
        jl short .4
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+060h], byte 11h
        jg near .18
.4:
        test byte [dword ebx+0BFh], 40h
        je short .5
        mov eax, 0Ah
        call randomd0
        cwde
        add eax, byte 1Eh
        mov dword [byte ebx+060h], eax
        jmp short .6
.5:
        mov dword [byte ebx+060h], 28h
.6:
        mov eax, dword [dword ebx+0FEh]
        cmp word [byte eax+010h], byte 0
        setge dl
        mov ax, word [byte eax+0Eh]
        xor dh, dh
        sub eax, edx
        cmp ax, 4
        je short .9
        cmp ax, 3
        jne short .8
        mov eax, 2
        call randomd0
        test ax, ax
        je short .7
        mov eax, 2
        jmp short .10
.7:
        mov eax, 6
        jmp short .10
.8:
        mov eax, 2
        call randomd0
        test ax, ax
        je short .9
        mov eax, 3
        jmp short .10
.9:
        mov eax, 5
.10:
        test byte [dword ebx+0BFh], 80h
        je short .11
        mov word [FaceoffWinner], ax
        jmp short .12
.11:
        mov word [fofdata2], ax
.12:
        cmp ax, 4
        jne short .13
        xor eax, eax
        jmp short .16
.13:
        jge short .14
        cmp byte [dword ebx+0D0h], 0
        jne short .15
        mov eax, 1
        jmp short .16
.14:
        cmp byte [dword ebx+0D0h], 0
        je short .15
        mov eax, 1
        jmp short .16
.15:
        mov eax, 0FFFFFFFFh
.16:
        mov edx, dword [PtrPuckFlags]
        cmp dword [byte edx+060h], byte 11h
        jg short .17
        movsx edx, ax
        mov eax, ebx
        call FaceoffSwipeAnim
        pop edx
        pop ecx
        pop ebx
        ret
.17:
        movsx edx, ax
        mov eax, ebx
        call FaceoffDrawAnim
.18:
        pop edx
        pop ecx
        pop ebx
        ret
