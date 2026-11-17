; Puck contacts: pick-ups, deflections, knocks, goalie and stick contact, offsides and zones, puck states.
bits 32
%include "hockey.inc"
section s_2A6B7 progbits alloc exec nowrite align=1
extern __CHP, AddPenalty, AddPenalty2, AllInPlace, assreplace, AwGoalieOnIce, AwPlayerFlags, AwPlayersInBox
extern awtmstruct, BenchRequest, BreakawayFlag, CarrierInShotArea, changeplayer, CommentaryEvent, CreditPass, CrowdForPuckZone
extern DelayedPen, DelayedPenaltyEnd, EndCrowdReaction, Endfaceoff, EndPenaltyShot, F32_0p125, F32_0p125_KnockPuckAway, F32_0p125_PuckPlayerContact
extern F32_0p142857, F32_0p166667_PuckHitsGoalie, F32_0p25, F32_0p25_PuckHitsGoalie, F32_0p333333, F32_0p5_pucknorm_body, F32_3, F32_3_PuckHitsGoalie
extern F32_48_PuckHitsGoalie, F32_7, F32_7_PuckPlayerContact, F32_neg1152, F32_neg1392_pucknorm_body, F32_neg1872, F64_0p00277778, F64_0p00277778_PuckHitsGoalie
extern F64_0p00277778_PuckPlayerContact, F64_0p00555556, F64_0p0174533, F64_0p01_DeflectPuck, F64_0p159155_pucknorm_body, F64_0p392699_pucknorm_body, F64_0p5_PuckToStick, F64_0p698132
extern F64_1080_pucknorm_body, F64_12, F64_12_ChkOffsides, F64_12_MarkTwoLinePlayers, F64_12_PuckIChk, F64_1392, F64_1435_ChkOffsides, F64_1440
extern F64_2, F64_20, F64_24, F64_24_MarkTwoLinePlayers, F64_288_PuckIChk, F64_3p14159_DeflectPuck, F64_3p14159_puckfaceoff2, F64_3p14159_PuckToStick
extern F64_4272_a2touchpuck, F64_4272_ChkDelayedOffside, F64_4272_pucknorm_body, F64_4276, F64_4284, F64_5p49779, F64_65536_pucknorm_body, F64_6p28319_DeflectPuck
extern F64_6p28319_PuckHitsGoalie, F64_6p28319_PuckPlayerContact, F64_6p28319_PuckToStick, F64_DeflectScale, F64_neg0p698132, F64_neg12_a2offsides, F64_neg12_ChkOffsides, F64_neg12_MarkTwoLinePlayers
extern F64_neg12_PuckIChk, F64_neg1435, F64_neg24, F64_neg3p14159_DeflectPuck, F64_neg3p14159_PuckToStick, F64_neg4276, F64_neg6p28319_DeflectPuck, F64_neg6p28319_PuckToStick
extern FaceoffCenter, FaceoffDropCameraScene, FaceoffPuckDrop, FaceoffPuckX, FaceoffPuckY, FaceoffRequest, FaceoffSpot, FaceoffSpotPosition
extern FaceoffZone, forcepldata, gameopts, GameSettings, GiveControl, gmode, GoalLineFlag, HmGoalieOnIce
extern HmPlayerFlags, HmPlayersInBox, hmtmstruct, holdreset, HomeTeamRecord, hypot_, IcingTeam, IF@ATAN2
extern IF@DFMOD, iflags, InputActive, LastPlayerTouch, LastTouchPlayer, LastTouchTeam, ObjectFramePos, OneTimerPasser
extern onetimerplayer, OneTimerReady, OneTimerTarget, PassDistX, PassDistY, PassPending, PassReceiver, penshotlive
extern penshotmode, PenShotStart, penshottimer, PeriodOver, PlayerAssignWords, PlayerControlFlags, PlayerPastLine, gmode2
extern PlaySfxOr, PlaySfxVolume, PtrAwayIce, PtrHomeIce, PtrPuckFlags, PtrPuckObject, PtrPuckOwner, PtrPuckState
extern PtrPuckTarget, puckc, PuckBounceOffPlayer, PuckChasers, PuckDeflect, PuckFlags, PuckHitFlag, PuckOwner
extern PuckOwnerTeam, PuckPathTable, PuckStickTimers, puckx, pucky, PuckZone, PunchPointId, QueueOverlayPanel
extern randomd0, RandomPuckSpin, ReachScale, RefFaceoffAnim, RefState, RefStep, ReleaseBoxToBench, RemoveOverlayPanel
extern ReplaceFaceoffPlayers, ReplayPlaying, ResetBench, RestartGameMusic, SetCameraMode, SetCrowdMood, SetFaceBlink, SetFaceExpression
extern SetFaceMouth, SetPenaltyBoxDoor, setpersonel, SetPlayerTarget, SetSlotPlayer, SetTeamColours, SlotAssign, SlotPlayers
extern SlotPuckPlayer, slotteam, SortCords, SpeedScale, StartOneTimerAnim, StartPuckReceiveAnim, StartWhistleStop, StatsPanelOn
extern StickPointId, StopObject, StoppageFlag, UpdatePuckCarrier, UpdateScoreboardPos, UpdateScoreboardSpin, ZoneTargetX, ZoneTargetY
global PlayerGetsPuck, DeflectPuck, KnockPuckAway, PuckHitsPlayer, PuckHitsGoalie, PuckToStickJumpTable, PuckToStick, PuckToStick_424
global PuckToStick_43B, PuckToStick_452, PuckToStick_469, ChkDelayedOffside, PuckPlayerContact, ChkPuckContacts, ChkTwoLinePass, a2offsides
global a2touchpuck, PuckIChk, PuckEntersZone, ChkOffsides, MarkTwoLinePlayers, pucknorm_body, pucknorm, puckfaceoff2
        db 090h
;-----------------------------------------------------------------------------
; PlayerGetsPuck                                  2A6B8  97 PC, low confidence
; The player takes the puck: puck carrier set, period / penalty shot end
; checks, shot and pass stats, play-by-play
;-----------------------------------------------------------------------------
PlayerGetsPuck:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edx, eax
        mov eax, dword [puckc]
        mov bl, byte [dword edx+0A4h]
        mov byte [eax], bl
        call SetCameraMode
        mov eax, dword [PtrPuckFlags]
        call StopObject
        cmp word [dword edx+0A9h], byte 0
        jne short .1
        mov eax, dword [dword edx+0FAh]
        mov bl, byte [byte eax+031h]
        test bl, 4
        je short .1
        mov bh, bl
        or bh, 2
        mov byte [byte eax+031h], bh
        call PeriodOver
        mov eax, dword [dword edx+0FAh]
        and byte [byte eax+031h], 0FBh
.1:
        cmp word [penshotlive], byte 0
        je short .2
        mov eax, dword [dword edx+0FEh]
        movsx bx, byte [dword edx+0A6h]
        mov si, word [byte eax+08h]
        cmp bx, si
        jne short .2
        call EndPenaltyShot
        xor edi, edi
        xor ebx, esi
        mov word [OneTimerPasser], di
        mov word [OneTimerReady], di
        mov word [OneTimerTarget], bx
.2:
        mov eax, dword [dword edx+0102h]
        mov word [byte eax+0Ah], 0FFFFh
        mov eax, dword [dword edx+0102h]
        mov word [byte eax+0Ch], 0FFFFh
        mov eax, dword [dword edx+0102h]
        or byte [byte eax+016h], 8
        cmp word [OneTimerTarget], byte 0
        je short .3
        xor esi, esi
        mov word [OneTimerTarget], si
        mov word [PuckZone], si
.3:
        mov al, byte [holdreset]
        test al, 10h
        je near .9
        mov ah, al
        and ah, 0EFh
        mov ebx, dword [ReplayPlaying]
        mov byte [holdreset], ah
        test ebx, ebx
        jne short .6
        mov eax, dword [dword edx+0FEh]
        mov eax, dword [dword eax+0108h]
        inc word [dword eax+020C7h]
        test byte [dword edx+0BFh], 80h
        je short .4
        cmp word [FaceoffZone], 570h
        jg short .5
.4:
        test byte [dword edx+0BFh], 80h
        jne short .6
        mov eax, dword [FaceoffSpot]
        sar eax, 10h
        cmp eax, 0FFFFFA90h
        jge short .6
.5:
        mov eax, dword [dword edx+0FEh]
        mov eax, dword [dword eax+0108h]
        inc word [dword eax+020C9h]
.6:
        test byte [dword edx+0BFh], 40h
        jne short .7
        mov eax, 8
        call SetCrowdMood
        mov ebx, dword [FaceoffPuckX]
        mov eax, dword [FaceoffPuckY]
        jmp short .8
.7:
        mov eax, 6
        call SetCrowdMood
        mov ebx, dword [FaceoffPuckY]
        mov eax, dword [FaceoffPuckX]
.8:
        mov ecx, dword [PtrPuckFlags]
        mov esi, dword [byte ecx+05Ah]
        cmp esi, byte 0FFFFFFF0h
        jl short .9
        mov edi, dword [LastTouchPlayer]
        push edi
        setg cl
        and ecx, 0FFh
        push ecx
        push eax
        mov ch, byte [dword edx+0BFh]
        push ebx
        test ch, 40h
        setne al
        and eax, 0FFh
        push eax
        push dword 0A0000019h
        call CommentaryEvent
        add esp, byte 18h
.9:
        call UpdatePuckCarrier
        mov eax, edx
        call StartPuckReceiveAnim
        test byte [gmode], 1
        jne near .13
        cmp word [BreakawayFlag], byte 0
        jne near .13
        cmp word [onetimerplayer], byte 0
        jl short .10
        mov eax, dword [PtrPuckFlags]
        cmp word [byte eax+06Dh], byte 1
        jne short .10
        mov eax, edx
        call CreditPass
        jmp near .13
.10:
        mov eax, dword [PtrPuckFlags]
        cmp word [byte eax+06Dh], byte 3
        jne near .11
        mov ebx, dword [PuckOwner]
        sar ebx, 10h
        mov eax, ebx
        shl eax, 5
        add eax, ebx
        cmp word [nosplit eax*8+PlayerAssignWords], byte 0
        jne near .11
        cmp word [dword edx+0A9h], byte 0
        jle short .11
        cmp byte [dword edx+0A4h], 6
        setb al
        mov cx, word [PuckOwnerTeam]
        and eax, 0FFh
        cmp cx, byte 6
        setl bl
        and ebx, 0FFh
        xor eax, ebx
        je short .11
        mov eax, dword [dword edx+0FEh]
        mov ebx, dword [dword eax+0108h]
        mov eax, dword [dword edx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        mov ecx, dword [LastTouchPlayer]
        push ecx
        add ebx, 0A3h
        mov ch, byte [dword edx+0BFh]
        add ebx, eax
        test ch, 40h
        setne al
        and eax, 0FFh
        push eax
        push ebx
        push dword 0A000000Bh
        jmp near .12
.11:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+05Ah], byte 0FFFFFFC0h
        jge near .13
        cmp byte [dword edx+0A4h], 6
        setb al
        mov ebx, eax
        mov si, word [PuckOwnerTeam]
        and ebx, 0FFh
        cmp si, byte 6
        setl al
        and eax, 0FFh
        xor eax, ebx
        je short .13
        mov eax, dword [dword edx+0A3h]
        sar eax, 18h
        imul ecx, eax, dword 125h
        mov ebx, dword [dword edx+0FEh]
        mov ebx, dword [dword ebx+0108h]
        lea eax, [dword ebx+0A3h]
        lea ebx, [eax+ecx]
        mov eax, dword [LastTouchPlayer]
        mov cl, byte [dword edx+0BFh]
        push eax
        test cl, 40h
        setne al
        and eax, 0FFh
        push eax
        push ebx
        push dword 0A000000Ch
.12:
        call CommentaryEvent
        add esp, byte 10h
        mov eax, edx
        call CrowdForPuckZone
.13:
        and byte [PuckFlags], 0F3h
        cmp word [dword edx+0A9h], byte 0
        jne short .14
        xor eax, eax
        call DelayedPenaltyEnd
        call EndPenaltyShot
.14:
        mov ah, byte [dword edx+0BFh]
        test ah, 8
        je short .15
        test ah, 40h
        setne al
        and eax, 0FFh
        xor esi, esi
        mov dword [nosplit eax*4+PuckChasers], esi
.15:
        test byte [dword edx+0BFh], 40h
        setne al
        and eax, 0FFh
        cmp dword [nosplit eax*4+PuckChasers], byte 0
        jne short .16
        xor eax, eax
        mov al, byte [dword edx+0A4h]
        call GiveControl
.16:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DeflectPuck                                     2AA50  97 PC, low confidence
; Puck off a player: random new speed and angle (+-7), wrapped
;-----------------------------------------------------------------------------
DeflectPuck:
        push ebx
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 1Ch
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl near .2
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+038h]
        call __CHP
        fistp dword [byte esp+04h]
        mov eax, dword [byte esp+04h]
        cwde
        call randomd0
        mov dword [byte esp+08h], eax
        mov eax, dword [PtrPuckFlags]
        fild word [byte esp+08h]
        fstp dword [byte eax+038h]
        mov eax, 0Eh
        call randomd0
        cwde
        sub eax, byte 7
        mov dword [byte esp+04h], eax
        mov eax, dword [PtrPuckFlags]
        fild dword [byte esp+04h]
        fstp dword [byte eax+040h]
        mov ebx, dword [PtrPuckFlags]
        fld qword [F64_6p28319_DeflectPuck]
        fld dword [byte ebx+040h]
        call IF@DFMOD
        fstp dword [byte ebx+040h]
        mov ebx, dword [PtrPuckFlags]
        fld dword [byte ebx+040h]
        fst qword [byte esp+0Ch]
        fcomp qword [F64_3p14159_DeflectPuck]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+0Ch]
        fadd qword [F64_neg6p28319_DeflectPuck]
        fstp dword [byte ebx+040h]
.1:
        mov ebx, dword [PtrPuckFlags]
        fld dword [byte ebx+040h]
        fst qword [byte esp+014h]
        fcomp qword [F64_neg3p14159_DeflectPuck]
        fnstsw ax
        sahf
        jae short .3
        fld qword [byte esp+014h]
        fadd qword [F64_6p28319_DeflectPuck]
        fstp dword [byte ebx+040h]
        jmp short .3
.2:
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+038h]
        fmul dword [F32_3]
        fmul dword [F32_0p25]
        fstp dword [byte eax+038h]
        mov eax, 0C8h
        call randomd0
        cwde
        sub eax, byte 64h
        mov dword [byte esp+04h], eax
        fild dword [byte esp+04h]
        mov eax, dword [PtrPuckFlags]
        fmul qword [F64_0p01_DeflectPuck]
        fadd dword [byte eax+040h]
        fstp dword [byte eax+040h]
.3:
        mov eax, 14h
        call randomd0
        cwde
        sub eax, byte 0Ah
        mov dword [byte esp+04h], eax
        fild dword [byte esp+04h]
        fstp dword [byte edx+030h]
        mov eax, dword [puckc]
        mov byte [eax], 0FFh
        mov eax, edx
        call RandomPuckSpin
        mov esp, ebp
        pop ebp
        pop edx
        pop ebx
        ret
        db 090h
        push edx
        sub esp, byte 10h
        mov edx, eax
        fld dword [byte eax+038h]
        fmul dword [F32_7]
        fmul dword [F32_0p125]
        fstp dword [byte eax+038h]
        mov eax, 1Eh
        call randomd0
        cwde
        sub eax, byte 0Fh
        mov dword [byte esp+0Ch], eax
        fild dword [byte esp+0Ch]
        fmul qword [F64_DeflectScale]
        fmul qword [F64_0p00277778]
        fld dword [byte edx+040h]
        fxch
        fadd st1
        mov eax, 28h
        fstp st1
        fstp dword [byte edx+040h]
        call randomd0
        cwde
        sub eax, byte 14h
        mov dword [byte esp+08h], eax
        fild dword [byte esp+08h]
        fstp dword [byte edx+030h]
        mov eax, dword [puckc]
        mov byte [eax], 0FFh
        add esp, byte 10h
        pop edx
        ret
        push ebx
        push ecx
        mov ecx, dword [dword eax+0A3h]
        sar ecx, 18h
        imul ecx, dword 125h
        mov ebx, dword [dword eax+0FEh]
        push dword 1001h
        mov ebx, dword [dword ebx+0108h]
        push edx
        add ebx, 0A3h
        mov dl, byte [dword eax+0BFh]
        add ecx, ebx
        test dl, 40h
        setne al
        and eax, 0FFh
        push eax
        push ecx
        push dword 0A0000016h
        call CommentaryEvent
        add esp, byte 14h
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; KnockPuckAway                                   2AC40  97 PC, low confidence
; Stick knocks the puck loose: slower puck heading away from the player,
; sound 417h, no carrier, play-by-play 16h
;-----------------------------------------------------------------------------
KnockPuckAway:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        call PuckDeflect
        test eax, eax
        jl near .2
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+038h]
        fmul dword [F32_0p125_KnockPuckAway]
        fstp dword [byte eax+038h]
        mov edx, dword [PtrPuckFlags]
        fld dword [byte edx+020h]
        fsub dword [byte ebx+020h]
        fld dword [byte edx+028h]
        fsub dword [byte ebx+028h]
        fxch
        call IF@ATAN2
        fstp dword [byte edx+040h]
        mov dword [byte ebx+064h], 10h
        mov eax, dword [PtrPuckFlags]
        push dword [byte eax+028h]
        mov edx, 64h
        push dword [byte eax+020h]
        mov eax, 417h
        call PlaySfxVolume
        mov eax, dword [puckc]
        mov byte [eax], 0FFh
        test byte [gmode], 1
        jne short .1
        cmp word [BreakawayFlag], byte 0
        jne short .1
        mov edx, dword [dword ebx+0A3h]
        sar edx, 18h
        imul edx, dword 125h
        mov eax, dword [dword ebx+0FEh]
        push dword 1001h
        mov eax, dword [dword eax+0108h]
        mov cl, byte [dword ebx+0BFh]
        add eax, 0A3h
        push dword 0B002h
        add edx, eax
        test cl, 40h
        setne al
        and eax, 0FFh
        push eax
        push edx
        push dword 0A0000016h
        call CommentaryEvent
        add esp, byte 14h
.1:
        mov eax, 1
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        xor eax, eax
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PuckHitsPlayer                                  2AD18  97 PC, low confidence
; From PuckPlayerContact: the puck reaches a player's body / stick: deflect,
; take it or knock it on
;-----------------------------------------------------------------------------
PuckHitsPlayer:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov edi, eax
        mov ebx, edx
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl near .13
        cmp word [dword ebx+0A9h], byte 0
        jle short .1
        mov eax, dword [dword ebx+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+028h]
        and eax, 0FFFFh
        cmp eax, 9Ah
        jne near .12
.1:
        mov eax, dword [puckc]
        movsx eax, byte [eax]
        mov ecx, eax
        shl ecx, 5
        add ecx, eax
        shl ecx, 3
        mov dh, byte [dword ebx+0A4h]
        add ecx, SortCords
        cmp dh, 6
        setb al
        mov esi, eax
        mov ah, byte [dword ecx+0A4h]
        and esi, 0FFh
        cmp ah, 6
        setb al
        and eax, 0FFh
        cmp esi, eax
        je near .12
        cmp word [dword ecx+0A9h], byte 0
        je near .12
        cmp word [dword ebx+0A9h], byte 0
        je near .8
        mov eax, dword [dword ecx+0A3h]
        mov esi, dword [dword ecx+0FEh]
        sar eax, 18h
        mov eax, dword [byte esi+eax*2+016h]
        sar eax, 10h
        movzx esi, byte [dword ecx+0CBh]
        imul eax, esi
        sar eax, 0Ch
        movsx ebp, ax
        mov eax, dword [dword ebx+0A3h]
        mov esi, dword [dword ebx+0FEh]
        sar eax, 18h
        mov esi, dword [byte esi+eax*2+016h]
        xor eax, eax
        sar esi, 10h
        mov al, byte [dword ebx+0CBh]
        imul eax, esi
        sar eax, 0Ch
        add ebp, byte 20h
        cwde
        sub ebp, eax
        mov eax, ebp
        mov word [ZoneTargetY], ax
        test byte [dword ecx+0BFh], 8
        je short .4
        test byte [dword ebx+0BFh], 8
        jne short .4
        test word [GameSettings], 180h
        jne short .2
        mov esi, dword [ZoneTargetX]
        sar esi, 10h
        mov ebp, 6
        jmp short .3
.2:
        mov eax, dword [GameSettings]
        and eax, 180h
        cmp eax, 80h
        jne short .4
        mov esi, dword [ZoneTargetX]
        sar esi, 10h
        mov ebp, 0Ch
.3:
        mov edx, esi
        mov eax, esi
        sar edx, 1Fh
        idiv ebp
        add eax, esi
        mov word [ZoneTargetY], ax
.4:
        mov eax, dword [GameSettings]
        and eax, 180h
        cmp eax, 100h
        jne short .5
        mov esi, 8
        jmp short .7
.5:
        cmp eax, 80h
        jne short .6
        mov esi, 6
        jmp short .7
.6:
        mov esi, 3
.7:
        mov eax, dword [ZoneTargetX]
        sar eax, 10h
        call randomd0
        cwde
        cmp eax, esi
        jg near .12
.8:
        push dword [byte ecx+028h]
        mov eax, 2
        push dword [byte ecx+020h]
        call randomd0
        cwde
        mov edx, 64h
        add eax, 402h
        call PlaySfxVolume
        mov eax, dword [dword ecx+0A3h]
        mov esi, dword [dword ecx+0FEh]
        sar eax, 18h
        mov esi, dword [byte esi+eax*2+016h]
        xor eax, eax
        sar esi, 10h
        mov al, byte [dword ecx+0CBh]
        imul eax, esi
        sar eax, 0Ch
        mov esi, 24h
        cwde
        sub esi, eax
        mov dx, word [dword ecx+0A9h]
        mov dword [byte ecx+064h], esi
        test dx, dx
        jne short .9
        lea edx, [byte esi-0Ah]
        mov dword [byte ecx+064h], edx
.9:
        mov esi, dword [dword ebx+0A3h]
        mov eax, dword [dword ebx+0FEh]
        sar esi, 18h
        mov eax, dword [byte eax+esi*2+016h]
        sar eax, 10h
        movzx esi, byte [dword ebx+0CBh]
        imul eax, esi
        sar eax, 0Ch
        mov esi, 24h
        cwde
        sub esi, eax
        mov dword [byte ebx+064h], esi
        cmp word [dword ebx+0A9h], byte 0
        jne short .10
        sub dword [byte ebx+064h], byte 0Ah
.10:
        mov al, byte [PuckFlags]
        and al, 0FBh
        mov byte [PuckFlags], al
        test al, 8
        je short .11
        mov eax, ecx
        call StartOneTimerAnim
.11:
        mov dl, byte [PuckFlags]
        and dl, 0F7h
        mov eax, edi
        mov byte [PuckFlags], dl
        call DeflectPuck
        mov eax, ebx
        call CrowdForPuckZone
.12:
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.13:
        cmp word [OneTimerReady], byte 0
        je short .14
        xor eax, eax
        mov cx, word [onetimerplayer]
        mov al, byte [dword ebx+0A4h]
        cmp ax, cx
        je short .12
.14:
        mov eax, ebx
        mov edx, 64h
        call PlayerGetsPuck
        push dword [byte ebx+028h]
        mov eax, 405h
        push dword [byte ebx+020h]
        call PlaySfxVolume
        cmp word [dword ebx+0A9h], byte 0
        jle short .12
        mov eax, dword [PtrPuckFlags]
        mov word [byte eax+06Dh], 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PuckHitsGoalie                                  2AFD8  97 PC, low confidence
; From PuckPlayerContact: puck against the goalie: save, rebound or catch
; (sounds, play-by-play, a2touchpuck)
;-----------------------------------------------------------------------------
PuckHitsGoalie:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        mov esi, eax
        mov ecx, edx
        mov eax, dword [dword edx+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+028h]
        mov edx, dword [byte esi+024h]
        and eax, 0FFFFh
        cmp edx, 41C00000h
        jg near .10
        mov bh, byte [dword ecx+0A4h]
        mov edi, 415h
        cmp bh, 0Ch
        jne short .1
        cmp eax, byte 61h
        je near .14
        test byte [gmode2], 10h
        jne near .14
        mov eax, 5
        call randomd0
        test ax, ax
        jne near .14
        mov edx, dword [PtrPuckFlags]
        fld dword [byte edx+038h]
        fmul dword [F32_3_PuckHitsGoalie]
        fmul dword [F32_0p25_PuckHitsGoalie]
        fstp dword [byte edx+038h]
        fld dword [byte esi+020h]
        fsub dword [byte ecx+020h]
        fld dword [byte esi+028h]
        fsub dword [byte ecx+028h]
        fxch
        call IF@ATAN2
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+040h]
        mov dword [byte ecx+064h], 10h
        jmp near .13
.1:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+038h], 41A00000h
        jl near .6
        test byte [gmode2], 10h
        jne short .2
        cmp word [onetimerplayer], byte 0
        jl near .6
        xor eax, eax
        mov dx, word [onetimerplayer]
        mov al, bh
        cmp ax, dx
        je near .6
.2:
        mov eax, dword [GameSettings]
        and eax, 180h
        cmp eax, 100h
        jne short .3
        mov edx, 5
        jmp short .5
.3:
        cmp eax, 80h
        jne short .4
        mov edx, 0Ah
        jmp short .5
.4:
        mov edx, 0Fh
.5:
        xor eax, eax
        xor ebx, ebx
        mov al, byte [dword ecx+0CBh]
        mov bl, byte [dword ecx+0CFh]
        add eax, ebx
        cwde
        call randomd0
        cwde
        cmp eax, edx
        jle near .14
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+038h]
        fmul dword [F32_0p333333]
        fstp dword [byte eax+038h]
        fld dword [byte esi+020h]
        fsub dword [byte ecx+020h]
        fld dword [byte esi+028h]
        fsub dword [byte ecx+028h]
        fxch
        call IF@ATAN2
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+040h]
        mov dword [byte ecx+064h], 10h
        test byte [gmode2], 10h
        je near .13
        cmp byte [dword ecx+0A4h], 6
        setb al
        mov edx, eax
        mov bx, word [PassPending]
        and edx, 0FFh
        cmp bx, byte 6
        setl al
        and eax, 0FFh
        xor eax, edx
        je near .13
        mov eax, dword [dword ecx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        push dword 1001h
        mov bh, byte [dword ecx+0BFh]
        add edx, 0A3h
        push dword 0B000h
        add edx, eax
        test bh, 40h
        setne al
        and eax, 0FFh
        push eax
        push edx
        push dword 0A0000016h
        call CommentaryEvent
        add esp, byte 14h
        jmp near .13
.6:
        mov eax, dword [PtrPuckFlags]
        cmp byte [dword eax+0CEh], 0
        jne near .14
        test word [GameSettings], 180h
        jne short .7
        mov eax, 0Ah
        call randomd0
        cwde
        sub eax, byte 5
        mov dword [byte ebp-08h], eax
        fild dword [byte ebp-08h]
        fmul qword [F64_6p28319_PuckHitsGoalie]
        fmul qword [F64_0p00277778_PuckHitsGoalie]
        call __CHP
        fistp dword [byte ebp-04h]
        jmp short .9
.7:
        mov eax, dword [GameSettings]
        and eax, 180h
        cmp eax, 80h
        jne short .8
        mov eax, 6
        call randomd0
        cwde
        sub eax, byte 3
        mov dword [byte ebp-08h], eax
        fild dword [byte ebp-08h]
        fmul qword [F64_6p28319_PuckHitsGoalie]
        fmul qword [F64_0p00277778_PuckHitsGoalie]
        call __CHP
        fistp dword [byte ebp-04h]
        jmp short .9
.8:
        xor ebx, ebx
        mov dword [byte ebp-04h], ebx
.9:
        lea ebx, [byte ebp-014h]
        mov edx, dword [StickPointId]
        mov eax, ecx
        call ObjectFramePos
        fld dword [byte ecx+038h]
        fadd qword [F64_20]
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+038h]
        fld dword [byte ebp-0Ch]
        fsub dword [byte esi+028h]
        fld dword [byte ebp-014h]
        fsub dword [byte esi+020h]
        call IF@ATAN2
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+040h]
        mov eax, dword [PtrPuckFlags]
        fild dword [byte ebp-04h]
        fadd dword [byte eax+040h]
        fstp dword [byte eax+040h]
        mov eax, dword [PtrPuckFlags]
        mov byte [dword eax+0CEh], 14h
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+05Ah], 0FFFFFFECh
        jmp near .13
.10:
        lea ebx, [byte ebp-014h]
        mov edx, dword [PunchPointId]
        mov eax, ecx
        call ObjectFramePos
        fld dword [byte esi+024h]
        fcomp dword [byte ebp-010h]
        fnstsw ax
        sahf
        jae near .12
        test byte [gmode2], 10h
        je short .11
        mov eax, 5
        call randomd0
        test ax, ax
        jne near .14
.11:
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+038h]
        fmul dword [F32_0p166667_PuckHitsGoalie]
        fstp dword [byte eax+038h]
        fld dword [byte esi+020h]
        fsub dword [byte ecx+020h]
        fld dword [byte esi+028h]
        fsub dword [byte ecx+028h]
        fxch
        call IF@ATAN2
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+040h]
        mov eax, esi
        mov dword [byte ecx+064h], 10h
        call RandomPuckSpin
        mov dl, byte [gmode2]
        mov edi, 417h
        test dl, 10h
        je near .13
        cmp byte [dword ecx+0A4h], 6
        setb al
        mov edx, eax
        mov bx, word [PassPending]
        and edx, 0FFh
        cmp bx, byte 6
        setl al
        and eax, 0FFh
        xor eax, edx
        je near .13
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        mov edx, dword [dword ecx+0FEh]
        push dword 1001h
        mov edx, dword [dword edx+0108h]
        mov bl, byte [dword ecx+0BFh]
        add edx, 0A3h
        push dword 0B000h
        add edx, eax
        test bl, 40h
        setne al
        and eax, 0FFh
        push eax
        push edx
        push dword 0A0000016h
        call CommentaryEvent
        add esp, byte 14h
        jmp near .13
.12:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+038h], 42480000h
        jle near .13
        fld dword [byte ebp-010h]
        fadd dword [F32_48_PuckHitsGoalie]
        fcomp dword [byte esi+024h]
        fnstsw ax
        sahf
        jbe near .13
        fld dword [byte ebp-0Ch]
        fsub dword [byte esi+028h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte ebp-014h]
        fsub dword [byte esi+020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_24]
        fnstsw ax
        sahf
        jae short .13
        mov edx, 2
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceBlink
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+038h]
        fmul dword [F32_0p25_PuckHitsGoalie]
        fstp dword [byte eax+038h]
        fld dword [byte esi+020h]
        fsub dword [byte ecx+020h]
        fld dword [byte esi+028h]
        fsub dword [byte ecx+028h]
        fxch
        call IF@ATAN2
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+040h]
        mov dword [byte ecx+064h], 10h
        mov eax, dword [PtrPuckFlags]
        mov byte [dword eax+0CEh], 14h
        mov eax, esi
        mov edi, 41Ah
        call RandomPuckSpin
.13:
        push dword [byte esi+028h]
        mov edx, 64h
        mov eax, edi
        push dword [byte esi+020h]
        call PlaySfxVolume
        mov eax, dword [puckc]
        mov byte [eax], 0FFh
        cmp byte [dword ecx+0A4h], 0Ch
        je short .14
        mov eax, ecx
        call a2touchpuck
.14:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
PuckToStickJumpTable:                           ; jump table for the switch cases of PuckToStick
        dd PuckToStick_424
        dd PuckToStick_424
        dd PuckToStick_43B
        dd PuckToStick_43B
        dd PuckToStick_469
        dd PuckToStick_452
        dd PuckToStick_469
        dd PuckToStick_452
;-----------------------------------------------------------------------------
; PuckToStick                                     2B4D4  97 PC, low confidence
; From PuckPlayerContact: puck onto a skater's stick: pass reception /
; one-timer / take the puck (a2touchpuck, PlayerGetsPuck)
;-----------------------------------------------------------------------------
PuckToStick:
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 38h
        and esp, byte 0FFFFFFF8h
        mov dword [byte esp+0Ch], eax
        mov ecx, edx
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .1
        cmp byte [dword ecx+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [puckc]
        and edx, 0FFh
        cmp byte [eax], 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        je near PuckToStick_469.26
.1:
        xor eax, eax
        call DelayedPenaltyEnd
        mov eax, ecx
        call a2touchpuck
        mov eax, dword [dword ecx+0FEh]
        mov esi, dword [dword eax+0108h]
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        add esi, 1D42h
        mov edx, dword [puckc]
        add esi, eax
        mov al, byte [edx]
        test al, al
        jge near .7
        cmp byte [dword ecx+0D0h], 0
        setne al
        and eax, 0FFh
        cmp ebx, eax
        jne short .3
        mov eax, ecx
        mov edx, 64h
        call PlayerGetsPuck
        push dword [byte ecx+028h]
        mov eax, 418h
        push dword [byte ecx+020h]
        call PlaySfxVolume
        test byte [gmode], 1
        jne short .2
        cmp word [BreakawayFlag], byte 0
        jne short .2
        mov eax, dword [PtrPuckFlags]
        cmp word [byte eax+06Dh], byte 0
        jne short .2
        mov edx, dword [LastTouchPlayer]
        push edx
        push dword 4004h
        push esi
        push dword 0A0000006h
        call CommentaryEvent
        add esp, byte 10h
.2:
        mov eax, dword [PtrPuckFlags]
        mov word [byte eax+06Dh], 4
        jmp near PuckToStick_469.26
.3:
        cmp ebx, byte 2
        je short .4
        cmp ebx, byte 3
        jne near .9
.4:
        mov eax, dword [PtrPuckState]
        cmp word [eax], byte 18h
        jg near .9
        mov eax, 0Ah
        call randomd0
        cmp ax, 3
        jle short .5
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+038h], 42940000h
        jge near .9
.5:
        mov eax, ecx
        mov edx, 64h
        call PlayerGetsPuck
        push dword [byte ecx+028h]
        mov eax, 416h
        push dword [byte ecx+020h]
        call PlaySfxVolume
        test byte [gmode], 1
        jne short .6
        cmp word [BreakawayFlag], byte 0
        jne short .6
        mov eax, dword [PtrPuckFlags]
        cmp word [byte eax+06Dh], byte 0
        jne short .6
        mov eax, dword [LastTouchPlayer]
        push eax
        push dword 400Ah
        push esi
        push dword 0A0000006h
        call CommentaryEvent
        add esp, byte 10h
.6:
        mov eax, dword [PtrPuckFlags]
        mov word [byte eax+06Dh], 4
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.7:
        movsx eax, al
        mov dword [byte esp+08h], eax
        mov edi, dword [byte esp+08h]
        shl eax, 5
        add eax, edi
        mov dword [nosplit eax*8+PuckStickTimers], 14h
        test byte [PuckFlags], 8
        je short .8
        movsx edx, byte [edx]
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        call StartOneTimerAnim
.8:
        mov eax, dword [puckc]
        mov byte [eax], 0FFh
        mov dl, byte [PuckFlags]
        and dl, 0F3h
        mov eax, dword [PtrPuckFlags]
        mov byte [PuckFlags], dl
        cmp dword [byte eax+024h], 42C00000h
        jle short .9
        mov eax, dword [byte esp+0Ch]
        call RandomPuckSpin
.9:
        cmp ebx, byte 1
        jbe short .10
        cmp ebx, byte 3
        jbe short .11
        jmp near .16
.10:
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 418h
        jmp short .12
.11:
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 416h
.12:
        push dword [byte ecx+020h]
        call PlaySfxVolume
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+030h], 41A00000h
        jle near .16
        fldz
        fcomp dword [byte eax+040h]
        fnstsw ax
        sahf
        jbe short .13
        mov eax, 0Fh
        call randomd0
        mov dword [byte esp+014h], eax
        fild word [byte esp+014h]
        fmul qword [F64_3p14159_PuckToStick]
        fmul qword [F64_0p00555556]
        fadd qword [F64_0p698132]
        jmp short .14
.13:
        mov eax, 0Fh
        call randomd0
        mov dword [byte esp+014h], eax
        fild word [byte esp+014h]
        fmul qword [F64_3p14159_PuckToStick]
        fmul qword [F64_0p00555556]
        fsubr qword [F64_neg0p698132]
.14:
        fstp dword [byte esp+010h]
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+040h]
        fadd dword [byte esp+010h]
        fstp dword [byte eax+040h]
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+038h]
        fmul qword [F64_0p5_PuckToStick]
        fstp dword [byte eax+038h]
        mov edx, dword [PtrPuckFlags]
        fld qword [F64_6p28319_PuckToStick]
        fld dword [byte edx+040h]
        call IF@DFMOD
        fstp dword [byte edx+040h]
        mov edx, dword [PtrPuckFlags]
        fld dword [byte edx+040h]
        fst qword [byte esp+030h]
        fcomp qword [F64_3p14159_PuckToStick]
        fnstsw ax
        sahf
        jbe short .15
        fld qword [byte esp+030h]
        fadd qword [F64_neg6p28319_PuckToStick]
        fstp dword [byte edx+040h]
.15:
        mov edx, dword [PtrPuckFlags]
        fld dword [byte edx+040h]
        fst qword [byte esp+020h]
        fcomp qword [F64_neg3p14159_PuckToStick]
        fnstsw ax
        sahf
        jae near .20
        fld qword [byte esp+020h]
        fadd qword [F64_6p28319_PuckToStick]
        fstp dword [byte edx+040h]
        cmp ebx, byte 7
        ja near PuckToStick_469.21
        db 02Eh,0FFh,024h,09Dh                  ; insn: jmp dword [cs:ebx*4+PuckToStickJumpTable]
        dd PuckToStickJumpTable
.16:
        xor eax, eax
        mov al, byte [dword ecx+0A4h]
        mov word [PuckOwnerTeam], ax
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+038h]
        fmul dword [F32_0p142857]
        fstp dword [byte eax+038h]
        mov eax, 5Ah
        call randomd0
        mov dword [byte esp+014h], eax
        fild word [byte esp+014h]
        fmul qword [F64_0p0174533]
        fadd qword [F64_5p49779]
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+040h]
        test byte [dword ecx+0BFh], 80h
        jne short .17
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+040h]
        fld st0
        fadd qword [F64_3p14159_PuckToStick]
        fstp st1
        fstp dword [byte eax+040h]
.17:
        mov edx, dword [PtrPuckFlags]
        fld qword [F64_6p28319_PuckToStick]
        fld dword [byte edx+040h]
        call IF@DFMOD
        fstp dword [byte edx+040h]
        mov edx, dword [PtrPuckFlags]
        fld dword [byte edx+040h]
        fst qword [byte esp+018h]
        fcomp qword [F64_3p14159_PuckToStick]
        fnstsw ax
        sahf
        jbe short .18
        fld qword [byte esp+018h]
        fadd qword [F64_neg6p28319_PuckToStick]
        fstp dword [byte edx+040h]
.18:
        mov edx, dword [PtrPuckFlags]
        fld dword [byte edx+040h]
        fst qword [byte esp+028h]
        fcomp qword [F64_neg3p14159_PuckToStick]
        fnstsw ax
        sahf
        jae short .19
        fld qword [byte esp+028h]
        fadd qword [F64_6p28319_PuckToStick]
        fstp dword [byte edx+040h]
.19:
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+030h], 0C1200000h
.20:
        cmp ebx, byte 7
        ja near PuckToStick_469.21
        db 02Eh,0FFh,024h,09Dh                  ; insn: jmp dword [cs:ebx*4+PuckToStickJumpTable]
        dd PuckToStickJumpTable
PuckToStick_424:
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 418h
        push dword [byte ecx+020h]
        mov ebx, 4001h
        jmp short PuckToStick_469.22
PuckToStick_43B:
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 416h
        push dword [byte ecx+020h]
        mov ebx, 400Ah
        jmp short PuckToStick_469.22
PuckToStick_452:
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 415h
        push dword [byte ecx+020h]
        mov ebx, 4008h
        jmp short PuckToStick_469.22
PuckToStick_469:
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 419h
        push dword [byte ecx+020h]
        call PlaySfxVolume
        mov eax, 3
        call randomd0
        movsx ebx, ax
        add ebx, 4005h
        jmp short .23
.21:
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 417h
        push dword [byte ecx+020h]
        mov ebx, 4000h
.22:
        call PlaySfxVolume
.23:
        test byte [gmode], 1
        jne short .25
        cmp word [BreakawayFlag], byte 0
        jne short .25
        mov eax, dword [PtrPuckFlags]
        cmp word [byte eax+06Dh], byte 0
        jne short .25
        mov eax, 14h
        call randomd0
        test ax, ax
        jne short .24
        mov ebx, 4002h
.24:
        mov edi, dword [LastTouchPlayer]
        push edi
        push ebx
        push esi
        push dword 0A0000006h
        call CommentaryEvent
        add esp, byte 10h
.25:
        mov eax, dword [PtrPuckFlags]
        mov word [byte eax+06Dh], 3
        mov dword [byte ecx+064h], 0Ah
        mov eax, dword [puckc]
        mov byte [eax], 0FFh
.26:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ChkDelayedOffside                               2B9EC  95 PC, low confidence
; Offsides option with the warning on: the flagged team touching the puck
; inside the zone calls offsides (AddPenalty2 5)
;-----------------------------------------------------------------------------
ChkDelayedOffside:
        push ebx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 4
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        mov eax, dword [gameopts]
        test byte [byte eax+01h], 8
        je short .1
        test byte [gmode2], 80h
        je short .1
        cmp word [BenchRequest], byte 0
        jne short .1
        cmp word [penshotlive], byte 0
        je short .2
.1:
        xor eax, eax
        jmp near .7
.2:
        mov eax, dword [PtrPuckOwner]
        movsx eax, word [eax]
        test eax, eax
        jge short .3
        mov ebx, eax
        mov dword [esp], eax
        neg ebx
        mov dword [esp], ebx
        jmp short .4
.3:
        mov dword [esp], eax
.4:
        fild dword [esp]
        fadd qword [F64_12]
        fcomp qword [F64_4272_ChkDelayedOffside]
        fnstsw ax
        sahf
        jbe short .5
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ebx
        ret
.5:
        cmp byte [dword edx+0A4h], 6
        setb al
        xor edx, edx
        mov si, word [PuckOwnerTeam]
        mov dl, al
        cmp si, byte 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        jne short .6
        xor eax, edx
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ebx
        ret
.6:
        mov edx, dword [PuckOwner]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        xor ebx, ebx
        shl eax, 3
        mov edx, 5
        add eax, SortCords
        call AddPenalty2
        mov eax, 1
.7:
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PuckPlayerContact                               2BAC0  97 PC, low confidence
; (puck, player): puck near a player: picks the contact kind (goalie, stick,
; body) and its handler
;-----------------------------------------------------------------------------
PuckPlayerContact:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 1Ch
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov ecx, edx
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp eax, edx
        je near .12
        cmp dword [byte ecx+064h], byte 0
        jne near .12
        test byte [dword ecx+0BFh], 4
        jne near .12
        mov eax, dword [dword ecx+0F6h]
        mov eax, dword [eax]
        mov edx, dword [byte eax+028h]
        mov bl, byte [gmode2]
        and edx, 0FFFFh
        test bl, 10h
        je short .1
        cmp edx, byte 45h
        jl short .1
        cmp edx, byte 47h
        jg short .1
        mov eax, ecx
        call KnockPuckAway
        test eax, eax
        jne near .12
.1:
        mov eax, dword [dword ecx+0FAh]
        test byte [byte eax+031h], 1
        jne near .12
        mov bx, word [dword ecx+0A9h]
        test bx, bx
        jle near .7
        test byte [dword ecx+0C0h], 4
        jne near .7
        test bx, bx
        jl near .7
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+028h], 1
        jne near .7
        cmp byte [dword ecx+0A4h], 0Ch
        je near .7
        cmp edx, byte 29h
        jl short .2
        cmp edx, byte 2Dh
        jle near .12
.2:
        mov edx, ecx
        mov eax, esi
        call PuckBounceOffPlayer
        test eax, eax
        je near .7
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jge near .10
        test byte [gmode2], 10h
        je near .3
        xor eax, eax
        mov bx, word [PuckOwnerTeam]
        mov al, byte [dword ecx+0A4h]
        cmp ax, bx
        je near .3
        cmp al, 6
        setb al
        mov edx, eax
        and edx, 0FFh
        cmp bx, byte 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        jne near .12
        mov eax, ecx
        call a2touchpuck
        mov al, byte [gmode2]
        or al, 10h
        mov edx, dword [PtrPuckFlags]
        mov byte [gmode2], al
        fld dword [byte edx+038h]
        fmul dword [F32_7_PuckPlayerContact]
        fmul dword [F32_0p125_PuckPlayerContact]
        mov eax, 1Eh
        fstp dword [byte edx+038h]
        call randomd0
        cwde
        sub eax, byte 0Fh
        mov dword [byte esp+08h], eax
        fild dword [byte esp+08h]
        fmul qword [F64_6p28319_PuckPlayerContact]
        fmul qword [F64_0p00277778_PuckPlayerContact]
        fld dword [byte edx+040h]
        fxch
        fadd st1
        mov eax, 28h
        fstp st1
        fstp dword [byte edx+040h]
        call randomd0
        cwde
        sub eax, byte 14h
        mov dword [byte esp+0Ch], eax
        fild dword [byte esp+0Ch]
        fstp dword [byte edx+030h]
        mov eax, dword [puckc]
        mov byte [eax], 0FFh
        mov eax, ecx
        call CrowdForPuckZone
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.3:
        cmp dword [byte esi+05Ah], byte 0FFFFFFF1h
        jg near .12
        mov di, word [onetimerplayer]
        test di, di
        jl near .10
        cmp byte [dword ecx+0A4h], 6
        setb al
        and eax, 0FFh
        cmp di, byte 6
        setl dl
        and edx, 0FFh
        xor eax, edx
        je near .10
        mov eax, dword [byte esi+05Ah]
        xor edx, edx
        neg eax
        mov dl, byte [dword ecx+0CBh]
        mov di, word [GameSettings]
        add eax, edx
        test di, 180h
        jne short .4
        add eax, byte 0Ah
        jmp short .5
.4:
        mov edx, dword [GameSettings]
        and edx, 180h
        cmp edx, 80h
        jne short .5
        add eax, byte 5
.5:
        mov ebx, dword [PassReceiver]
        sar ebx, 10h
        mov edx, ebx
        shl edx, 5
        add edx, ebx
        test byte [nosplit edx*8+PlayerControlFlags], 8
        jne short .6
        add eax, byte 5
.6:
        movsx edx, ax
        mov eax, edx
        call randomd0
        cmp ax, 14h
        jge near .10
        mov eax, edx
        call randomd0
        cmp ax, 14h
        jge near .12
        mov eax, ecx
        call a2touchpuck
        mov dword [byte ecx+064h], 10h
        mov eax, dword [PtrPuckFlags]
        call DeflectPuck
        mov eax, ecx
        call CrowdForPuckZone
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.7:
        cmp word [dword ecx+0A9h], byte 0
        jne short .8
        mov eax, ecx
        call PuckDeflect
        mov ebx, eax
        test eax, eax
        jl near .12
        mov eax, ecx
        call ChkDelayedOffside
        mov edx, ecx
        mov eax, esi
        call PuckToStick
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.8:
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jge near .12
        mov eax, dword [byte ecx+050h]
        mov edx, dword [PtrPuckFlags]
        mov dword [byte esp+018h], eax
        call SpeedScale
        fcomp dword [byte edx+038h]
        fnstsw ax
        sahf
        jbe short .9
        fld dword [byte ecx+050h]
        fmul qword [F64_2]
        fstp dword [byte esp+018h]
.9:
        fld dword [byte ecx+020h]
        fsub dword [byte esi+020h]
        fabs
        fld dword [byte esp+018h]
        fstp qword [byte esp+010h]
        fcomp qword [byte esp+010h]
        fnstsw ax
        sahf
        ja short .12
        fld dword [byte ecx+028h]
        fsub dword [byte esi+028h]
        fabs
        fcomp qword [byte esp+010h]
        fnstsw ax
        sahf
        ja short .12
        xor eax, eax
        mov dx, word [onetimerplayer]
        mov al, byte [dword ecx+0A4h]
        cmp ax, dx
        jne short .11
.10:
        mov edx, ecx
        mov eax, esi
        call PuckHitsPlayer
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.11:
        mov edx, ecx
        mov eax, esi
        call PuckHitsGoalie
.12:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ChkPuckContacts                                 2BE2C  97 PC, low confidence
; From updateplayers: with the puck low (below 384), every one of the 13
; objects close enough (1E0h / 0F0h) gets PuckPlayerContact
;-----------------------------------------------------------------------------
ChkPuckContacts:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        cmp dword [byte eax+024h], 43C00000h
        jge near .7
        mov ebx, SortCords
        xor esi, esi
        xor edi, edi
.1:
        fld dword [byte ecx+020h]
        fsub dword [byte ebx+020h]
        fabs
        mov dx, word [dword ebx+0A9h]
        fstp qword [byte esp+0Ch]
        cmp di, dx
        sete al
        and eax, 0FFh
        mov dword [esp], eax
        fild dword [esp]
        fcomp qword [byte esp+0Ch]
        fnstsw ax
        sahf
        jbe short .2
        mov eax, 1E0h
        jmp short .3
.2:
        mov eax, 0F0h
.3:
        test eax, eax
        je short .6
        fld dword [byte ecx+028h]
        fsub dword [byte ebx+028h]
        fabs
        mov dx, word [dword ebx+0A9h]
        fstp qword [byte esp+04h]
        cmp di, dx
        sete al
        and eax, 0FFh
        mov dword [esp], eax
        fild dword [esp]
        fcomp qword [byte esp+04h]
        fnstsw ax
        sahf
        jbe short .4
        mov eax, 1E0h
        jmp short .5
.4:
        mov eax, 0F0h
.5:
        test eax, eax
        je short .6
        mov edx, ebx
        mov eax, ecx
        call PuckPlayerContact
.6:
        inc esi
        add ebx, 108h
        cmp esi, byte 0Dh
        jl near .1
.7:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ChkTwoLinePass                                        2BEF0  94G, low confidence
; (player) from a2touchpuck: offsides when the rule is on and
; the touching player's team is past the line
;-----------------------------------------------------------------------------
ChkTwoLinePass:
        push ebx
        push ecx
        push edx
        push esi
        mov edx, dword [gameopts]
        test byte [byte edx+01h], 10h
        jne short .1
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        test byte [dword eax+0C0h], 80h
        jne short .2
        mov cl, byte [dword eax+0BFh]
        xor ebx, ebx
        test cl, 80h
        sete bl
        mov edx, dword [PtrPuckOwner]
        cmp word [edx], byte 0
        setg dl
        and edx, 0FFh
        xor edx, ebx
        je short .2
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        xor edx, edx
        mov si, word [PuckOwnerTeam]
        mov dl, byte [dword eax+0A4h]
        cmp dx, si
        je short .3
        cmp dl, 6
        setb dl
        mov ebx, edx
        and ebx, 0FFh
        cmp si, byte 6
        setl dl
        and edx, 0FFh
        xor edx, ebx
        je short .4
.3:
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        test byte [dword eax+0BFh], 80h
        jne short .6
        cmp word [PassDistY], 570h
        jl short .5
        cmp word [byte eax+0Eh], byte 0
        jle short .8
.5:
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        mov edx, dword [PassDistX]
        sar edx, 10h
        cmp edx, 0FFFFFA90h
        jg short .7
        cmp word [byte eax+0Eh], byte 0
        jge short .8
.7:
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        mov eax, 1
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; a2offsides                                     2BFC4  94G, medium confidence
; (player touched the puck: offsides if his team is flagged,
; tmflags bit 4, and the puck is in the zone): AddPenalty 5
;-----------------------------------------------------------------------------
a2offsides:
        push ebx
        push ecx
        push edx
        push esi
        mov ecx, eax
        mov eax, dword [gameopts]
        test byte [byte eax+01h], 8
        jne short .1
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        cmp word [penshotlive], byte 0
        jne short .2
        cmp word [BenchRequest], byte 0
        je short .3
.2:
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov eax, dword [dword ecx+0FEh]
        test byte [byte eax+016h], 10h
        jne short .4
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov eax, dword [PtrPuckOwner]
        mov ax, word [eax]
        mov word [ZoneTargetY], ax
        test byte [dword ecx+0BFh], 80h
        jne short .5
        mov esi, eax
        neg esi
        mov word [ZoneTargetY], si
.5:
        fild word [ZoneTargetY]
        fadd qword [F64_neg12_a2offsides]
        fcomp qword [F64_1440]
        fnstsw ax
        sahf
        jae short .6
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        mov edx, 5
        mov eax, ecx
        xor ebx, ebx
        call AddPenalty
        mov eax, 1
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; a2touchpuck                                    2C064  94G, medium confidence
; (player) the player touches the puck: records the last touch (player PuckOwnerTeam,
; position), then checks offsides and the other rules
;-----------------------------------------------------------------------------
a2touchpuck:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ecx, eax
        mov ah, byte [dword eax+0BFh]
        xor edx, edx
        test ah, 40h
        sete al
        and eax, 0FFh
        xor ebx, ebx
        mov dword [nosplit eax*4+PuckChasers], ebx
        test byte [gmode], 1
        jne short .1
        cmp word [BreakawayFlag], byte 0
        jne short .1
        mov eax, ecx
        call ChkTwoLinePass
        mov edx, eax
        test ax, ax
        jne short .1
        mov al, byte [dword ecx+0A4h]
        mov word [PuckOwnerTeam], ax
        mov ax, word [byte ecx+06h]
        mov word [LastPlayerTouch], ax
        mov ax, word [byte ecx+0Eh]
        mov word [StoppageFlag], ax
        mov eax, dword [PtrPuckTarget]
        mov ax, word [eax]
        mov word [LastTouchTeam], ax
        mov eax, dword [PtrPuckOwner]
        mov ax, word [eax]
        mov word [PassDistY], ax
.1:
        mov eax, dword [dword ecx+0FEh]
        movsx bx, byte [dword ecx+0A6h]
        cmp bx, word [byte eax+08h]
        je short .4
        mov bh, byte [byte eax+016h]
        test bh, 8
        je short .2
        mov bl, bh
        and bl, 0F7h
        mov byte [byte eax+016h], bl
        jmp short .3
.2:
        mov bx, word [byte eax+0Ah]
        mov word [byte eax+0Ch], bx
        mov bx, word [byte eax+08h]
        mov word [byte eax+0Ah], bx
.3:
        movsx bx, byte [dword ecx+0A6h]
        mov di, word [byte eax+0Ch]
        mov word [byte eax+08h], bx
        cmp bx, di
        jne short .5
        mov word [byte eax+0Ch], 0FFFFh
        jmp short .5
.4:
        mov bh, byte [byte eax+016h]
        test bh, 8
        je short .5
        mov bl, bh
        and bl, 0F7h
        mov byte [byte eax+016h], bl
.5:
        cmp word [dword ecx+0A9h], byte 0
        je short .6
        and byte [gmode2], 0EFh
.6:
        mov eax, ecx
        call a2offsides
        test ax, ax
        jne short .7
        test dx, dx
        je short .7
        mov edx, dword [PuckOwner]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        xor ebx, ebx
        shl eax, 3
        mov edx, 6
        add eax, SortCords
        call AddPenalty
.7:
        cmp word [dword ecx+0A9h], byte 0
        je near .8
        mov al, byte [iflags]
        test al, 4
        je near .8
        test al, 1
        je near .8
        test byte [dword ecx+0BFh], 80h
        setne al
        mov edx, eax
        mov bl, byte [iflags]
        and edx, 0FFh
        test bl, 2
        setne al
        and eax, 0FFh
        xor eax, edx
        je near .8
        test byte [gmode], 1
        jne near .12
        cmp word [BreakawayFlag], byte 0
        jne near .12
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        mov edx, dword [dword ecx+0FEh]
        mov edx, dword [dword edx+0108h]
        add edx, 0A3h
        lea ebx, [edx+eax]
        xor edx, edx
        mov dl, byte [IcingTeam]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edi, dword [LastTouchPlayer]
        mov dl, byte [nosplit eax*8+PlayerControlFlags]
        push edi
        test dl, 40h
        setne al
        and eax, 0FFh
        mov dh, byte [dword ecx+0BFh]
        push eax
        test dh, 40h
        setne al
        and eax, 0FFh
        push eax
        push ebx
        push dword 0A0000021h
        mov edx, 4
        xor ecx, ecx
        call CommentaryEvent
        mov cl, byte [IcingTeam]
        mov bl, byte [iflags]
        mov eax, ecx
        add esp, byte 14h
        shl eax, 5
        or bl, 80h
        add eax, ecx
        mov byte [iflags], bl
        shl eax, 3
        xor ebx, ebx
        add eax, SortCords
        call AddPenalty
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        test byte [gmode], 1
        jne near .9
        cmp word [BreakawayFlag], byte 0
        jne near .9
        mov al, byte [iflags]
        test al, 4
        je near .9
        test al, 1
        je near .9
        test al, 80h
        jne near .9
        test byte [dword ecx+0BFh], 80h
        sete al
        mov edx, eax
        mov bl, byte [iflags]
        and edx, 0FFh
        test bl, 2
        setne al
        and eax, 0FFh
        xor eax, edx
        je near .9
        cmp word [dword ecx+0A9h], byte 0
        jle near .9
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+028h]
        fabs
        fcomp qword [F64_4272_a2touchpuck]
        fnstsw ax
        sahf
        jb short .9
        mov eax, dword [dword ecx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        add edx, 0A3h
        lea ebx, [edx+eax]
        xor edx, edx
        mov dl, byte [IcingTeam]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov esi, dword [LastTouchPlayer]
        mov dl, byte [nosplit eax*8+PlayerControlFlags]
        push esi
        test dl, 40h
        setne al
        and eax, 0FFh
        mov dh, byte [dword ecx+0BFh]
        push eax
        test dh, 40h
        setne al
        and eax, 0FFh
        push eax
        push ebx
        push dword 0A0000021h
        call CommentaryEvent
        add esp, byte 14h
.9:
        xor bl, bl
        mov byte [iflags], bl
        mov al, byte [dword ecx+0A4h]
        mov byte [IcingTeam], al
        mov eax, dword [PtrPuckOwner]
        mov ax, word [eax]
        mov word [ZoneTargetY], ax
        test byte [dword ecx+0BFh], 80h
        je short .10
        mov edi, eax
        mov al, 2
        neg edi
        mov byte [iflags], al
        mov word [ZoneTargetY], di
.10:
        cmp word [ZoneTargetY], byte 0
        jl short .12
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .12
        mov dx, word [AwPlayersInBox]
        mov ax, word [HmPlayersInBox]
        sub eax, edx
        mov word [ZoneTargetY], ax
        test byte [dword ecx+0BFh], 40h
        je short .11
        mov ebx, eax
        neg ebx
        mov word [ZoneTargetY], bx
.11:
        cmp word [ZoneTargetY], byte 0
        jl short .12
        mov eax, dword [gameopts]
        test byte [byte eax+01h], 20h
        je short .12
        or byte [iflags], 4
.12:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PuckIChk                                       2C42C  94G, medium confidence
; (icing check, from pucknorm): loose puck past the goal line
; within the posts sets the icing flag (iflags)
;-----------------------------------------------------------------------------
PuckIChk:
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 4
        and esp, byte 0FFFFFFF8h
        mov ah, byte [iflags]
        test ah, 4
        je near .6
        test ah, 1
        jne near .6
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jge near .6
        test byte [iflags], 2
        jne short .1
        mov eax, dword [PtrPuckOwner]
        fild word [eax]
        fadd qword [F64_12_PuckIChk]
        fcomp qword [F64_neg4276]
        fnstsw ax
        sahf
        jae short .6
        jmp short .2
.1:
        mov eax, dword [PtrPuckOwner]
        fild word [eax]
        fadd qword [F64_neg12_PuckIChk]
        fcomp qword [F64_4276]
        fnstsw ax
        sahf
        jbe short .6
.2:
        mov eax, dword [PtrPuckTarget]
        mov dx, word [eax]
        test dx, dx
        jge short .3
        movsx eax, dx
        mov edx, eax
        mov dword [esp], eax
        neg edx
        mov dword [esp], edx
        jmp short .4
.3:
        movsx eax, dx
        mov dword [esp], eax
.4:
        fild dword [esp]
        fadd qword [F64_neg12_PuckIChk]
        fcomp qword [F64_288_PuckIChk]
        fnstsw ax
        sahf
        ja short .5
        and byte [iflags], 0FBh
        mov esp, ebp
        pop ebp
        pop edx
        ret
.5:
        or byte [iflags], 1
.6:
        mov esp, ebp
        pop ebp
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PuckEntersZone                                  2C4E8  97 PC, low confidence
; Puck crossing a blue line: play-by-play 0Eh with the carrier, team
; zone-entry stat (+20DFh)
;-----------------------------------------------------------------------------
PuckEntersZone:
        push ebx
        push edx
        call CarrierInShotArea
        mov ax, word [PuckZone]
        mov word [OneTimerTarget], ax
        test ax, ax
        je near .4
        mov eax, 0Ch
        call SetCrowdMood
        cmp word [penshotlive], byte 0
        jne short .1
        cmp word [penshotmode], byte 0
        jne short .1
        mov eax, dword [puckc]
        movsx edx, byte [eax]
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        mov edx, dword [dword eax+0A3h]
        sar edx, 18h
        imul edx, dword 125h
        mov ebx, dword [dword eax+0FEh]
        mov ebx, dword [dword ebx+0108h]
        add ebx, 0A3h
        add edx, ebx
        mov ebx, 1001h
        mov dword [LastTouchPlayer], ebx
        push ebx
        test byte [dword eax+0BFh], 40h
        setne al
        and eax, 0FFh
        push eax
        push edx
        push dword 0A000000Eh
        call CommentaryEvent
        add esp, byte 10h
.1:
        cmp word [penshotmode], byte 0
        jne short .4
        cmp dword [ReplayPlaying], byte 0
        jne short .4
        mov eax, dword [puckc]
        cmp byte [eax], 5
        setg al
        and eax, 0FFh
        je short .2
        mov eax, awtmstruct
        jmp short .3
.2:
        mov eax, hmtmstruct
.3:
        mov eax, dword [dword eax+0108h]
        inc word [dword eax+020DFh]
.4:
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ChkOffsides                                                       2C5C8  94G
; (from pucknorm): drops a team's offsides flag (tmflags bit 4) when no one is past the
; line, flags the team when the puck crosses the blue line with a skater ahead (overlay 5)
;-----------------------------------------------------------------------------
ChkOffsides:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov eax, dword [gameopts]
        test byte [byte eax+01h], 8
        je near .8
        cmp word [penshotlive], byte 0
        jne near .20
        cmp word [BenchRequest], byte 0
        jne near .20
        mov esi, hmtmstruct
        xor edi, edi
        xor ebp, ebp
.1:
        test byte [byte esi+016h], 10h
        je near .7
        mov ecx, ebp
        mov ebx, dword [dword esi+0104h]
.2:
        cmp word [dword ebx+0A9h], byte 0
        jl short .5
        test byte [dword ebx+0BFh], 80h
        je short .3
        mov edx, 56Bh
        jmp short .4
.3:
        mov edx, 0FFFFFA95h
.4:
        mov eax, ebx
        call PlayerPastLine
        test eax, eax
        jne short .6
.5:
        inc ecx
        add ebx, 108h
        cmp ecx, byte 6
        jl short .2
.6:
        cmp ecx, byte 6
        jl short .7
        and byte [byte esi+016h], 0EFh
        mov eax, 5
        call RemoveOverlayPanel
        test byte [gmode], 8
        jne short .7
        mov eax, dword [PtrPuckObject]
        and byte [dword eax+0C1h], 0FDh
        mov eax, dword [PtrPuckObject]
        call StartWhistleStop
.7:
        inc edi
        mov esi, awtmstruct
        cmp edi, byte 2
        jl near .1
.8:
        mov word [ZoneTargetY], 56Bh
        mov edx, dword [PtrPuckOwner]
        fild word [edx]
        fadd qword [F64_neg12_ChkOffsides]
        fcomp qword [F64_1435_ChkOffsides]
        fnstsw ax
        sahf
        jb near .14
        mov eax, dword [PtrPuckFlags]
        fild word [byte eax+054h]
        fadd qword [F64_neg12_ChkOffsides]
        fcomp qword [F64_1435_ChkOffsides]
        fnstsw ax
        sahf
        jae near .20
        call PuckEntersZone
        mov eax, dword [gameopts]
        test byte [byte eax+01h], 8
        je near .20
        test byte [gmode], 2
        je short .9
        mov ecx, awtmstruct
        jmp short .10
.9:
        mov ecx, hmtmstruct
.10:
        mov ebx, dword [dword ecx+0104h]
        mov esi, ecx
        mov ah, byte [dword ebx+0A4h]
        xor edx, edx
        cmp ah, 6
        setb al
        mov di, word [PuckOwnerTeam]
        mov dl, al
        cmp di, byte 6
        setl al
        and eax, 0FFh
        xor eax, edx
        je short .11
        mov dl, byte [byte ecx+016h]
        and dl, 0EFh
        mov eax, 5
        mov byte [byte ecx+016h], dl
        call RemoveOverlayPanel
        test byte [gmode], 8
        jne near .20
        mov eax, dword [PtrPuckObject]
        and byte [dword eax+0C1h], 0FDh
        mov eax, dword [PtrPuckObject]
        call StartWhistleStop
        jmp near .20
.11:
        xor ecx, ecx
        mov edi, 56Bh
.12:
        cmp word [dword ebx+0A9h], byte 0
        jl short .13
        mov edx, edi
        mov eax, ebx
        call PlayerPastLine
        test eax, eax
        je short .13
        push byte 5
        mov ch, byte [byte esi+016h]
        push byte 0
        or ch, 10h
        push byte 0
        mov byte [byte esi+016h], ch
        call QueueOverlayPanel
        mov eax, dword [PtrPuckObject]
        or byte [dword eax+0C1h], 2
        add esp, byte 0Ch
        mov eax, dword [PtrPuckObject]
        call StartWhistleStop
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.13:
        inc ecx
        add ebx, 108h
        cmp ecx, byte 6
        jl short .12
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.14:
        mov word [ZoneTargetY], 0FA95h
        fild word [edx]
        fadd qword [F64_12_ChkOffsides]
        fcomp qword [F64_neg1435]
        fnstsw ax
        sahf
        ja near .20
        mov eax, dword [PtrPuckFlags]
        fild word [byte eax+054h]
        fadd qword [F64_12_ChkOffsides]
        fcomp qword [F64_neg1435]
        fnstsw ax
        sahf
        jbe near .20
        call PuckEntersZone
        mov eax, dword [gameopts]
        test byte [byte eax+01h], 8
        je near .20
        test byte [gmode], 2
        jne short .15
        mov ecx, awtmstruct
        jmp short .16
.15:
        mov ecx, hmtmstruct
.16:
        mov ebx, dword [dword ecx+0104h]
        mov ah, byte [dword ebx+0A4h]
        mov esi, ecx
        cmp ah, 6
        setb al
        mov di, word [PuckOwnerTeam]
        and eax, 0FFh
        cmp di, byte 6
        setl dl
        and edx, 0FFh
        xor eax, edx
        je short .17
        mov dl, byte [byte ecx+016h]
        and dl, 0EFh
        mov eax, 5
        mov byte [byte ecx+016h], dl
        call RemoveOverlayPanel
        test byte [gmode], 8
        jne near .20
        mov eax, dword [PtrPuckObject]
        and byte [dword eax+0C1h], 0FDh
        mov eax, dword [PtrPuckObject]
        call StartWhistleStop
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.17:
        xor ecx, ecx
        mov ebp, 0FFFFFA95h
        xor edi, edi
.18:
        cmp di, word [dword ebx+0A9h]
        jg short .19
        mov edx, ebp
        mov eax, ebx
        call PlayerPastLine
        test eax, eax
        je short .19
        push byte 5
        mov bh, byte [byte esi+016h]
        push byte 0
        or bh, 10h
        push byte 0
        mov byte [byte esi+016h], bh
        call QueueOverlayPanel
        mov eax, dword [PtrPuckObject]
        or byte [dword eax+0C1h], 2
        add esp, byte 0Ch
        mov eax, dword [PtrPuckObject]
        call StartWhistleStop
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.19:
        inc ecx
        add ebx, 108h
        cmp ecx, byte 6
        jl short .18
.20:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; MarkTwoLinePlayers                           2C900  95 PC, medium confidence
; Two-line pass option (bit 10h): as the puck crosses the red line marks the
; skaters past it (+0C0h bit 7)
;-----------------------------------------------------------------------------
MarkTwoLinePlayers:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 8
        and esp, byte 0FFFFFFF8h
        mov eax, dword [gameopts]
        test byte [byte eax+01h], 10h
        je near .10
        test byte [gmode], 2
        je short .1
        mov ebx, SortCords
        mov ecx, HomeTeamRecord+420h
        jmp short .2
.1:
        mov ebx, HomeTeamRecord+420h
        mov ecx, SortCords
.2:
        mov eax, dword [PtrPuckOwner]
        fild word [eax]
        fst qword [esp]
        fadd qword [F64_neg12_MarkTwoLinePlayers]
        fcomp qword [F64_24_MarkTwoLinePlayers]
        fnstsw ax
        sahf
        jbe short .6
        mov eax, dword [PtrPuckFlags]
        fild word [byte eax+054h]
        fadd qword [F64_neg12_MarkTwoLinePlayers]
        fcomp qword [F64_24_MarkTwoLinePlayers]
        fnstsw ax
        sahf
        ja near .10
        xor esi, esi
        xor edi, edi
.3:
        cmp di, word [dword ecx+0A9h]
        jg short .4
        mov edx, edi
        mov eax, ecx
        call PlayerPastLine
        test eax, eax
        je short .4
        or byte [dword ecx+0C0h], 80h
        jmp short .5
.4:
        and byte [dword ecx+0C0h], 7Fh
.5:
        inc esi
        mov ah, byte [dword ebx+0C0h]
        add ebx, 108h
        and ah, 7Fh
        add ecx, 108h
        mov byte [byte ebx-048h], ah
        cmp esi, byte 6
        jge near .10
        jmp short .3
.6:
        fld qword [esp]
        fadd qword [F64_12_MarkTwoLinePlayers]
        fcomp qword [F64_neg24]
        fnstsw ax
        sahf
        jae short .10
        mov eax, dword [PtrPuckFlags]
        fild word [byte eax+054h]
        fadd qword [F64_12_MarkTwoLinePlayers]
        fcomp qword [F64_neg24]
        fnstsw ax
        sahf
        jb short .10
        xor esi, esi
        xor edi, edi
.7:
        cmp di, word [dword ebx+0A9h]
        jg short .8
        mov edx, edi
        mov eax, ebx
        call PlayerPastLine
        test eax, eax
        je short .8
        or byte [dword ebx+0C0h], 80h
        jmp short .9
.8:
        and byte [dword ebx+0C0h], 7Fh
.9:
        inc esi
        mov dl, byte [dword ecx+0C0h]
        add ecx, 108h
        and dl, 7Fh
        add ebx, 108h
        mov byte [byte ecx-048h], dl
        cmp esi, byte 6
        jl short .7
.10:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; pucknorm_body                      2CA40  94G logic94.asm, medium confidence
;
; The body of pucknorm after its new-assignment part (ends in ass_popx): the puck's normal assignment.
; Counts down the two line-crossing timers (puckcross) and every 5 ticks recomputes them (temp1, findpc).
;
; A carried puck is pulled a quarter of the way toward its carrier's hot spot (a2touchpuck, GetHot into
; regd0 / regd1) and takes his velocity. Then the ice / offside / two-line checks (PuckIChk, ChkOffsides,
; MarkTwoLinePlayers).
;
; While the clock runs: a carried puck resets temp2 (78h) and the penalty-shot send count (psendcount); a
; loose one on a live penalty shot moving back toward the shooter's own end (puckvy by penshotteam and the
; gmode bit 1 rink flip) for 1Eh ticks ends the shot (EndPenaltyShot).
;
; A puck that has stopped (same position as last tick), outside the middle (x A3h, y 10Eh) or with hmtmnear
; / awtmnear at 14h or less, counts temp2 down and at 0 calls a delay of game (AddPenalty2 3); a moving one
; resets temp2.
;
; A puck almost still on the ice (z speed below 100h, z 0) is put flat (puckunflip); then the collisions
; (checkpuckcoll). p: the puck. No result.
;-----------------------------------------------------------------------------
pucknorm_body:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        mov dword [byte ebp-04h], eax
        mov edx, dword [puckc]
        mov ah, byte [edx]
        test ah, ah
        jl near .35
        movsx eax, ah
        mov edx, eax
        shl edx, 5
        add edx, eax
        mov edi, SortCords
        shl edx, 3
        add edi, edx
        mov eax, edi
        call a2touchpuck
        mov eax, dword [byte ebp-04h]
        mov byte [dword eax+0CEh], 0
        test byte [gmode], 1
        jne near .50
        cmp word [BreakawayFlag], byte 0
        jne near .50
        mov eax, dword [byte ebp-04h]
        cmp dword [byte eax+05Ah], byte 0
        jge short .1
        mov dword [byte eax+05Ah], 0
.1:
        mov eax, dword [byte ebp-04h]
        inc dword [byte eax+05Ah]
        cmp word [dword edi+0A9h], byte 0
        jle near .50
        cmp word [penshotlive], byte 0
        jne near .50
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+05Ah], byte 18h
        jne near .25
        call ReachScale
        fmul dword [F32_0p5_pucknorm_body]
        fcomp dword [byte edi+038h]
        fnstsw ax
        sahf
        ja near .25
        fld dword [byte edi+040h]
        fadd qword [F64_0p392699_pucknorm_body]
        fmul qword [F64_0p159155_pucknorm_body]
        fmul qword [F64_65536_pucknorm_body]
        call __CHP
        fistp dword [byte ebp-08h]
        mov eax, dword [byte ebp-08h]
        and eax, 0E000h
        mov edx, eax
        mov dword [byte ebp-08h], eax
        sar edx, 0Dh
        mov dword [byte ebp-08h], edx
        lea ebx, [byte edx+01h]
        mov dword [byte ebp-08h], ebx
        test ebx, ebx
        jge short .2
        lea esi, [byte ebx+08h]
        mov dword [byte ebp-08h], esi
.2:
        test byte [dword edi+0BFh], 80h
        jne short .3
        xor byte [byte ebp-08h], 4
.3:
        mov eax, dword [dword edi+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword edi+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        add edx, 0A3h
        mov ch, byte [dword edi+0BFh]
        add edx, eax
        test ch, 80h
        je near .13
        cmp dword [byte ebp-08h], byte 2
        jg near .13
        test byte [dword edi+0106h], 2
        je short .4
        fld dword [byte edi+028h]
        fcomp dword [F32_neg1152]
        fnstsw ax
        sahf
        jae short .4
        mov ebx, dword [LastTouchPlayer]
        push ebx
        test ch, 40h
        setne al
        and eax, 0FFh
        push eax
        push edx
        push dword 0A000000Fh
        jmp near .24
.4:
        fldz
        fcomp dword [byte edi+028h]
        fnstsw ax
        sahf
        jae near .25
        cmp dword [byte edi+028h], 44EA0000h
        jge near .25
        mov al, byte [dword edi+0A4h]
        xor esi, esi
        xor ecx, ecx
        cmp al, 6
        jae short .5
        xor eax, eax
        jmp short .6
.5:
        mov eax, 6
.6:
        mov edx, eax
        shl edx, 5
        add edx, eax
        shl edx, 3
        xor ebx, ebx
        add edx, SortCords
.7:
        cmp word [dword edx+0A9h], byte 0
        jle short .8
        cmp dword [byte edx+028h], 44AE0000h
        jl short .8
        inc esi
.8:
        inc ebx
        add edx, 108h
        cmp ebx, byte 6
        jl short .7
        cmp esi, byte 3
        jg near .25
        cmp byte [dword edi+0A4h], 6
        jae short .9
        mov eax, 6
        jmp short .10
.9:
        xor eax, eax
.10:
        mov edx, eax
        shl edx, 5
        add edx, eax
        shl edx, 3
        xor ebx, ebx
        add edx, SortCords
.11:
        cmp word [dword edx+0A9h], byte 0
        jle short .12
        cmp dword [byte edx+028h], 44AE0000h
        jle short .12
        inc ecx
.12:
        inc ebx
        add edx, 108h
        cmp ebx, byte 6
        jl short .11
        cmp esi, ecx
        jl near .25
        cmp ecx, byte 1
        jg near .25
        mov edx, dword [LastTouchPlayer]
        push edx
        push ecx
        push esi
        jmp near .23
.13:
        mov al, byte [dword edi+0BFh]
        test al, 80h
        jne near .25
        cmp dword [byte ebp-08h], byte 2
        jg near .25
        test byte [dword edi+0106h], 2
        je short .14
        cmp dword [byte edi+028h], 44900000h
        jle short .14
        mov esi, dword [LastTouchPlayer]
        push esi
        test al, 40h
        setne al
        and eax, 0FFh
        push eax
        push edx
        push dword 0A000000Fh
        jmp near .24
.14:
        fldz
        fcomp dword [byte edi+028h]
        fnstsw ax
        sahf
        jbe near .25
        fld dword [byte edi+028h]
        fcomp dword [F32_neg1872]
        fnstsw ax
        sahf
        jbe near .25
        mov dl, byte [dword edi+0A4h]
        xor ecx, ecx
        xor esi, esi
        cmp dl, 6
        jae short .15
        xor eax, eax
        jmp short .16
.15:
        mov eax, 6
.16:
        mov edx, eax
        shl edx, 5
        add edx, eax
        shl edx, 3
        xor ebx, ebx
        add edx, SortCords
.17:
        cmp word [dword edx+0A9h], byte 0
        jle short .18
        fld dword [byte edx+028h]
        fcomp dword [F32_neg1392_pucknorm_body]
        fnstsw ax
        sahf
        ja short .18
        inc ecx
.18:
        inc ebx
        add edx, 108h
        cmp ebx, byte 6
        jl short .17
        cmp ecx, byte 3
        jg near .25
        cmp byte [dword edi+0A4h], 6
        jae short .19
        mov eax, 6
        jmp short .20
.19:
        xor eax, eax
.20:
        mov edx, eax
        shl edx, 5
        add edx, eax
        shl edx, 3
        xor ebx, ebx
        add edx, SortCords
.21:
        cmp word [dword edx+0A9h], byte 0
        jle short .22
        fld dword [byte edx+028h]
        fcomp dword [F32_neg1392_pucknorm_body]
        fnstsw ax
        sahf
        jae short .22
        inc esi
.22:
        inc ebx
        add edx, 108h
        cmp ebx, byte 6
        jl short .21
        cmp ecx, esi
        jl short .25
        cmp esi, byte 1
        jg short .25
        mov eax, dword [LastTouchPlayer]
        push eax
        push esi
        push ecx
.23:
        push dword 0A0000013h
.24:
        call CommentaryEvent
        add esp, byte 10h
.25:
        mov bl, byte [dword edi+0BFh]
        test bl, 40h
        jne near .32
        mov cl, byte [gmode2]
        test cl, 20h
        je near .28
        test cl, 40h
        je near .28
        mov eax, dword [byte ebp-04h]
        cmp dword [byte eax+05Ah], byte 20h
        jne short .28
        cmp word [byte edi+0Eh], byte 0
        jge short .26
        mov eax, dword [byte edi+0Ch]
        sar eax, 10h
        neg eax
        jmp short .27
.26:
        mov eax, dword [byte edi+0Ch]
        sar eax, 10h
.27:
        cmp eax, 630h
        jle short .28
        mov ah, byte [dword edi+0BFh]
        xor edx, edx
        test ah, 80h
        setne al
        mov bx, word [byte edi+0Eh]
        mov dl, al
        test bx, bx
        setg al
        and eax, 0FFh
        xor eax, edx
        je short .28
        mov eax, 2
        call randomd0
        test ax, ax
        sete al
        and eax, 0FFh
        xor edx, edx
        add eax, 509h
        call PlaySfxOr
        jmp near .50
.28:
        mov eax, dword [byte ebp-04h]
        mov esi, dword [byte eax+05Ah]
        cmp esi, 0C8h
        jl near .50
        lea edx, [dword esi-0C8h]
        mov ebx, 0C8h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        test edx, edx
        jne near .50
        cmp word [byte edi+0Eh], byte 0
        jge short .29
        mov eax, dword [byte edi+0Ch]
        sar eax, 10h
        neg eax
        jmp short .30
.29:
        mov eax, dword [byte edi+0Ch]
        sar eax, 10h
.30:
        cmp eax, 630h
        jle near .50
        test byte [dword edi+0BFh], 80h
        setne al
        xor edx, edx
        mov si, word [byte edi+0Eh]
        mov dl, al
        test si, si
        setl al
        and eax, 0FFh
        xor eax, edx
        je near .50
        mov dh, byte [gmode2]
        test dh, 20h
        je short .31
        test dh, 40h
        jne short .31
        mov eax, 2
        call SetCrowdMood
        jmp near .50
.31:
        mov eax, 50Bh
        xor edx, edx
        call PlaySfxOr
        jmp near .50
.32:
        test bl, 40h
        je near .50
        mov eax, dword [byte ebp-04h]
        mov ebx, dword [byte eax+05Ah]
        cmp ebx, 0C8h
        jl near .50
        lea edx, [dword ebx-0C8h]
        mov ebx, 0C8h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        test edx, edx
        jne near .50
        mov eax, 2
        call randomd0
        test ax, ax
        je short .33
        mov eax, 508h
        jmp short .34
.33:
        mov eax, 502h
.34:
        call PlaySfxOr
        jmp near .50
.35:
        mov eax, dword [byte ebp-04h]
        cmp dword [byte eax+05Ah], byte 0
        jle short .36
        mov dword [byte eax+05Ah], 0
.36:
        mov eax, dword [byte ebp-04h]
        mov ecx, dword [byte eax+05Ah]
        dec ecx
        mov dword [byte eax+05Ah], ecx
        cmp ecx, 0FFFFFF00h
        jne short .37
        test byte [gmode], 1
        jne near .49
        cmp word [BreakawayFlag], byte 0
        jne near .49
        mov eax, dword [HmGoalieOnIce]
        sar eax, 10h
        mov edx, eax
        shl edx, 5
        add edx, eax
        cmp dword [nosplit edx*8+PuckPathTable], 1E0h
        jle near .49
        mov eax, dword [AwGoalieOnIce]
        sar eax, 10h
        mov edx, eax
        shl edx, 5
        add edx, eax
        cmp dword [nosplit edx*8+PuckPathTable], 1E0h
        jle near .49
        mov edx, dword [LastTouchPlayer]
        push edx
        push dword 0A0000012h
        call CommentaryEvent
        add esp, byte 8
        jmp near .49
.37:
        test byte [gmode], 1
        jne near .49
        cmp word [BreakawayFlag], byte 0
        jne near .49
        cmp ecx, byte 0FFFFFFC0h
        jne near .49
        cmp word [penshotlive], byte 0
        jne near .49
        mov si, word [byte eax+06Dh]
        cmp si, byte 5
        jne near .43
        fld dword [byte eax+028h]
        fabs
        fst qword [byte ebp-010h]
        fcomp qword [F64_1392]
        fnstsw ax
        sahf
        jae short .38
        mov ebx, 9001h
        jmp short .40
.38:
        fld qword [byte ebp-010h]
        fcomp qword [F64_4272_pucknorm_body]
        fnstsw ax
        sahf
        jbe short .40
        mov eax, dword [byte ebp-04h]
        fld dword [byte eax+020h]
        fabs
        fcomp qword [F64_1080_pucknorm_body]
        fnstsw ax
        sahf
        jbe short .39
        mov ebx, 9002h
        jmp short .40
.39:
        mov ebx, 9000h
.40:
        mov eax, dword [PuckOwner]
        sar eax, 10h
        mov edx, eax
        shl edx, 5
        add edx, eax
        shl edx, 3
        add edx, SortCords
        cmp word [dword edx+0A9h], byte 0
        jle short .41
        mov eax, dword [dword edx+0FEh]
        mov ecx, dword [dword eax+0108h]
        mov eax, dword [dword edx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        add ecx, 0A3h
        jmp short .42
.41:
        mov eax, dword [dword edx+0FEh]
        mov ecx, dword [dword eax+0108h]
        mov eax, dword [dword edx+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        add ecx, 1D42h
.42:
        add eax, ecx
        mov esi, dword [LastTouchPlayer]
        push esi
        mov ch, byte [dword edx+0BFh]
        push ebx
        test ch, 40h
        setne dl
        and edx, 0FFh
        push edx
        push eax
        push dword 0A0000011h
        jmp near .48
.43:
        cmp si, byte 2
        jne near .49
        mov eax, dword [PuckOwner]
        sar eax, 10h
        mov edx, eax
        shl edx, 5
        add edx, eax
        shl edx, 3
        add edx, SortCords
        test byte [dword edx+0BFh], 80h
        setne al
        xor ebx, ebx
        mov bl, al
        mov eax, dword [byte ebp-04h]
        fldz
        fcomp dword [byte eax+028h]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor eax, ebx
        je near .49
        mov eax, dword [byte ebp-04h]
        fld dword [byte eax+028h]
        fabs
        fcomp qword [F64_4272_pucknorm_body]
        fnstsw ax
        sahf
        jbe short .44
        mov eax, 8002h
        jmp short .45
.44:
        mov eax, 8000h
.45:
        cmp word [dword edx+0A9h], byte 0
        jle short .46
        mov ebx, dword [dword edx+0FEh]
        mov ecx, dword [dword ebx+0108h]
        mov ebx, dword [dword edx+0A3h]
        sar ebx, 18h
        imul ebx, dword 125h
        add ecx, 0A3h
        jmp short .47
.46:
        mov ebx, dword [dword edx+0FEh]
        mov ecx, dword [dword ebx+0108h]
        mov ebx, dword [dword edx+0A3h]
        sar ebx, 18h
        sub ebx, byte 19h
        imul ebx, dword 125h
        add ecx, 1D42h
.47:
        add ebx, ecx
        mov ecx, dword [LastTouchPlayer]
        push ecx
        mov cl, byte [dword edx+0BFh]
        push eax
        test cl, 40h
        setne al
        and eax, 0FFh
        push eax
        push ebx
        push dword 0A0000010h
.48:
        call CommentaryEvent
        add esp, byte 14h
.49:
        mov eax, dword [byte ebp-04h]
        mov dl, byte [dword eax+0CEh]
        test dl, dl
        jbe short .50
        mov dh, dl
        dec dh
        mov byte [dword eax+0CEh], dh
.50:
        call PuckIChk
        call ChkOffsides
        call MarkTwoLinePlayers
        cmp word [penshotlive], byte 0
        je near .55
        test byte [gmode], 2
        sete al
        mov edx, dword [puckx]
        and eax, 0FFh
        sar edx, 10h
        xor edx, eax
        mov eax, dword [byte ebp-04h]
        cmp dword [byte eax+05Ah], byte 0FFFFFFC0h
        jl near .54
        mov ebx, dword [PtrPuckFlags]
        fld dword [byte ebx+028h]
        fabs
        fcomp qword [F64_4284]
        fnstsw ax
        sahf
        ja near .54
        test edx, edx
        je short .51
        fldz
        fcomp dword [byte ebx+034h]
        fnstsw ax
        sahf
        jbe short .51
        fld dword [byte ebx+028h]
        fcomp dword [F32_neg1392_pucknorm_body]
        fnstsw ax
        sahf
        jb near .54
.51:
        test edx, edx
        jne short .52
        mov ebx, dword [PtrPuckFlags]
        fldz
        fcomp dword [byte ebx+034h]
        fnstsw ax
        sahf
        jae short .52
        cmp dword [byte ebx+028h], 44AE0000h
        jg short .54
.52:
        test edx, edx
        je short .53
        mov ebx, dword [PtrPuckFlags]
        fldz
        fcomp dword [byte ebx+034h]
        fnstsw ax
        sahf
        jbe short .53
        cmp dword [byte ebx+028h], 44AE0000h
        jg short .54
.53:
        test edx, edx
        jne short .55
        mov edx, dword [PtrPuckFlags]
        fldz
        fcomp dword [byte edx+034h]
        fnstsw ax
        sahf
        jae short .55
        fld dword [byte edx+028h]
        fcomp dword [F32_neg1392_pucknorm_body]
        fnstsw ax
        sahf
        jae short .55
.54:
        call EndPenaltyShot
        xor eax, eax
        mov word [OneTimerPasser], ax
        mov word [OneTimerReady], ax
        mov word [OneTimerTarget], ax
.55:
        mov eax, dword [byte ebp-04h]
        fld dword [byte eax+030h]
        fabs
        fld1
        fcompp
        fnstsw ax
        sahf
        jbe short .56
        mov eax, dword [byte ebp-04h]
        cmp dword [byte eax+024h], 3F800000h
        jge short .56
        call StopObject
.56:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; pucknorm                           2D308  94G logic94.asm, medium confidence
; Puck assignment slot 18h: clears the pfna flag and temp1, sets temp2 to 78h, then calls pucknorm_body
;-----------------------------------------------------------------------------
pucknorm:
        push edx
        mov dl, byte [dword eax+0BFh]
        test dl, 2
        je short .1
        mov dh, dl
        mov dword [byte eax+05Ah], 0
        and dh, 0FDh
        mov byte [dword eax+0BFh], dh
.1:
        call pucknorm_body
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; puckfaceoff2                          2D330  94G logic94.asm, low confidence
; Puck assignment table slot 28: the second faceoff assignment of the puck (low confidence)
;-----------------------------------------------------------------------------
puckfaceoff2:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 24h
        and esp, byte 0FFFFFFF8h
        mov edi, eax
        test byte [dword eax+0BFh], 2
        je near .43
        mov edx, dword [byte eax+060h]
        dec edx
        mov dword [byte eax+060h], edx
        test edx, edx
        jle short .2
        mov eax, dword [gameopts]
        test byte [byte eax+02h], 20h
        je short .1
        cmp word [penshotmode], byte 0
        je short .2
.1:
        cmp dword [InputActive], byte 0
        jne short .2
        cmp dword [RefState], byte 0
        jne short .2
        cmp dword [RefStep], byte 0
        jge near .45
        call AllInPlace
        test eax, eax
        je near .45
.2:
        cmp word [penshotmode], byte 0
        je short .3
        mov eax, dword [PtrPuckObject]
        cmp dword [byte eax+060h], byte 64h
        jne near .45
.3:
        call SetCameraMode
        mov eax, edi
        mov bl, byte [dword edi+0BFh]
        xor ecx, ecx
        and bl, 0FDh
        xor esi, esi
        mov byte [dword edi+0BFh], bl
        xor edx, edx
        mov word [BenchRequest], cx
        call StopObject
        mov bh, byte [PuckFlags]
        mov cl, byte [gmode2]
        mov word [PuckZone], si
        mov word [OneTimerTarget], si
        mov word [OneTimerPasser], si
        mov word [OneTimerReady], si
        xor eax, eax
        and bh, 0F3h
        and cl, 0EFh
        xor esi, esi
        mov byte [PuckFlags], bh
        xor ebx, ebx
        mov byte [gmode2], cl
        mov dword [FaceoffCenter], ebx
        mov dword [PuckChasers], ebx
        call SetPenaltyBoxDoor
        mov eax, 1
        xor edx, edx
        xor ecx, ecx
        call SetPenaltyBoxDoor
        call EndCrowdReaction
        mov dword [PuckHitFlag], ebx
        call ReleaseBoxToBench
        mov eax, dword [DelayedPen]
        xor ch, bh
        sar eax, 10h
        xor esi, ebx
        call RemoveOverlayPanel
        mov al, byte [gmode2]
        mov dl, byte [AwPlayerFlags]
        mov byte [iflags], ch
        mov dword [InputActive], ebx
        mov dword [RefState], ebx
        mov word [BreakawayFlag], si
        mov ecx, 0FFFFFFFFh
        and al, 7Ah
        and dl, 0EFh
        mov byte [gmode2], al
        mov word [onetimerplayer], cx
        mov byte [AwPlayerFlags], dl
        xor eax, eax
        mov dh, byte [gmode2]
        xor eax, ebx
        or dh, 5
        mov word [GoalLineFlag], ax
        mov ah, byte [HmPlayerFlags]
        mov ebx, 0FFFFFFFFh
        and ah, 0EFh
        mov byte [gmode2], dh
        mov byte [HmPlayerFlags], ah
        mov ax, word [FaceoffSpot]
        mov dx, word [penshotmode]
        mov word [LastPlayerTouch], ax
        mov word [LastTouchTeam], ax
        mov ax, word [FaceoffZone]
        mov dword [RefStep], ebx
        mov word [StoppageFlag], ax
        mov word [PassDistY], ax
        test dx, dx
        jne short .4
        mov eax, dword [PtrPuckTarget]
        mov dx, word [FaceoffSpot]
        mov word [eax], dx
        mov dword [byte esp+010h], edx
        mov eax, dword [PtrPuckFlags]
        fild word [byte esp+010h]
        fstp dword [byte eax+020h]
        mov eax, dword [PtrPuckState]
        mov word [eax], 0C0h
        mov ax, word [eax]
        mov dword [byte esp+010h], eax
        mov eax, dword [PtrPuckFlags]
        fild word [byte esp+010h]
        fstp dword [byte eax+024h]
        mov eax, dword [PtrPuckOwner]
        mov dx, word [FaceoffZone]
        mov word [eax], dx
        mov dword [byte esp+010h], edx
        mov eax, dword [PtrPuckFlags]
        fild word [byte esp+010h]
        fstp dword [byte eax+028h]
        mov eax, dword [puckc]
        mov byte [eax], 0Ch
.4:
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+038h], 0
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+018h], 0
        mov edx, dword [byte eax+018h]
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+014h], edx
        mov eax, edx
        mov edx, dword [PtrPuckFlags]
        mov dword [byte edx+010h], eax
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+034h], 0
        fld dword [byte eax+034h]
        mov eax, dword [PtrPuckFlags]
        fst dword [byte eax+030h]
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+02Ch]
        mov eax, dword [PtrAwayIce]
        mov dword [byte eax+038h], 0
        mov eax, dword [PtrHomeIce]
        xor ecx, ecx
        mov edx, esp
        mov dword [byte eax+038h], 0
        mov eax, 10B0h
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], eax
        xor eax, eax
        mov dword [esp], ecx
        call UpdateScoreboardPos
        mov edx, 0FFFFEF50h
        mov eax, 1
        mov dword [byte esp+08h], edx
        mov edx, esp
        call UpdateScoreboardPos
        mov eax, dword [PtrAwayIce]
        mov dword [byte eax+020h], ecx
        mov eax, dword [PtrAwayIce]
        mov dword [byte eax+028h], 45858000h
        mov eax, dword [PtrHomeIce]
        mov dword [byte eax+020h], ecx
        mov eax, dword [PtrHomeIce]
        mov dword [byte eax+028h], 0C5858000h
        mov eax, dword [PtrAwayIce]
        cmp byte [dword eax+0A4h], 0Fh
        jne short .5
        mov esi, 5A7ED197h
        mov eax, 400921FBh
        mov dword [byte esp+014h], esi
        mov dword [byte esp+018h], eax
        jmp short .6
.5:
        mov dword [byte esp+014h], ecx
        mov dword [byte esp+018h], ecx
.6:
        mov eax, dword [PtrAwayIce]
        fld qword [byte esp+014h]
        fstp dword [byte eax+01Ch]
        mov eax, dword [PtrAwayIce]
        sub esp, byte 4
        fld dword [byte eax+01Ch]
        fadd qword [F64_3p14159_puckfaceoff2]
        xor eax, eax
        fstp dword [esp]
        call UpdateScoreboardSpin
        mov eax, dword [PtrHomeIce]
        cmp byte [dword eax+0A4h], 0Fh
        jne short .7
        mov ecx, 5A7ED197h
        mov esi, 400921FBh
        mov dword [byte esp+01Ch], ecx
        mov dword [byte esp+020h], esi
        jmp short .8
.7:
        xor edx, edx
        mov dword [byte esp+01Ch], edx
        mov dword [byte esp+020h], edx
.8:
        mov eax, dword [PtrHomeIce]
        fld qword [byte esp+01Ch]
        fstp dword [byte eax+01Ch]
        mov eax, dword [PtrHomeIce]
        sub esp, byte 4
        fld dword [byte eax+01Ch]
        fadd qword [F64_3p14159_puckfaceoff2]
        mov eax, 1
        fstp dword [esp]
        call UpdateScoreboardSpin
        mov eax, dword [PtrAwayIce]
        mov eax, dword [dword eax+0FAh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [PtrHomeIce]
        mov eax, dword [dword eax+0FAh]
        mov dword [byte eax+0Ch], 0
        cmp word [penshotmode], byte 0
        je near .20
        mov dx, word [FaceoffRequest]
        mov cx, word [SlotAssign]
        xor eax, eax
        xor esi, esi
        cmp dx, cx
        je short .10
        mov dx, word [FaceoffRequest]
.9:
        add eax, byte 2
        inc esi
        cmp eax, byte 10h
        jge short .10
        cmp dx, word [dword eax+SlotAssign]
        jne short .9
.10:
        cmp esi, byte 8
        jl short .13
        xor eax, eax
        xor esi, esi
.11:
        mov edx, dword [puckx]
        mov ebx, dword [dword eax+SlotPuckPlayer]
        sar edx, 10h
        sar ebx, 10h
        inc edx
        cmp ebx, edx
        jne short .12
        mov edx, dword [penshottimer]
        mov eax, esi
        sar edx, 10h
        call SetSlotPlayer
        jmp short .13
.12:
        add eax, byte 2
        inc esi
        cmp eax, byte 10h
        jl short .11
.13:
        mov eax, SortCords
        xor esi, esi
        xor ecx, ecx
.14:
        cmp cx, word [dword eax+0A9h]
        jne short .15
        mov dh, byte [dword eax+0BFh]
        xor ebx, ebx
        test dh, 40h
        setne bl
        mov edx, dword [puckx]
        sar edx, 10h
        xor edx, ebx
        jne short .16
.15:
        inc esi
        add eax, 108h
        cmp esi, byte 0Ch
        jl short .14
.16:
        and byte [dword eax+0C0h], 0DBh
        mov bh, byte [dword eax+0BFh]
        and bh, 0FBh
        xor ecx, ecx
        mov byte [dword eax+0BFh], bh
        xor ebx, ebx
.17:
        mov edx, dword [dword ebx+SlotPuckPlayer]
        sar edx, 10h
        cmp word [pucky], byte 0
        sete al
        and eax, 0FFh
        inc eax
        cmp edx, eax
        jne short .19
        mov eax, dword [gameopts]
        test byte [byte eax+02h], 2
        je short .18
        mov edx, esi
        mov eax, ecx
        call SetSlotPlayer
        mov esi, 0FFFFFFFFh
        jmp short .19
.18:
        mov edx, 0FFFFFFFFh
        mov eax, ecx
        call SetSlotPlayer
.19:
        inc ecx
        add ebx, byte 2
        cmp ecx, byte 8
        jl short .17
        mov dh, byte [gmode2]
        mov bl, byte [gmode]
        and dh, 0FAh
        and bl, 0FEh
        mov byte [gmode2], dh
        mov byte [gmode], bl
        and byte [dword edi+0C0h], 0FEh
        or byte [holdreset], 10h
        mov edx, 41h
        mov ch, byte [dword edi+0BFh]
        mov eax, dword [dword edi+0AEh]
        and ch, 0FBh
        sar eax, 18h
        mov byte [dword edi+0BFh], ch
        mov byte [dword edi+eax+0B2h], dl
        or byte [dword edi+0BFh], 2
        call RestartGameMusic
        call PenShotStart
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.20:
        call ResetBench
        mov eax, hmtmstruct
        call setpersonel
        mov eax, hmtmstruct
        call forcepldata
        mov eax, awtmstruct
        mov ecx, SortCords
        call setpersonel
        mov eax, awtmstruct
        xor esi, esi
        call forcepldata
        call ReplaceFaceoffPlayers
.21:
        mov edx, 0FFFFFFFFh
        mov eax, ecx
        call SetPlayerTarget
        xor ebx, ebx
        mov edx, 0FFFFFFFFh
        mov eax, dword [dword ecx+0F2h]
        call SetTeamColours
        and byte [dword ecx+0C0h], 7Fh
        xor edx, edx
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov ax, word [dword ecx+0A9h]
        test ax, ax
        jl near .27
        jle near .26
        cmp ax, 4
        jne near .24
        mov eax, dword [dword ecx+0FEh]
        movsx dx, byte [dword ecx+0A6h]
        mov word [byte eax+0Ah], 0FFFFh
        mov word [byte eax+08h], dx
        mov dl, byte [byte eax+016h]
        mov word [byte eax+0Ch], 0FFFFh
        and dl, 0F7h
        mov byte [byte eax+016h], dl
        mov edx, dword [dword ecx+0AEh]
        sar edx, 18h
        mov ebx, 8
        movsx dx, byte [dword ecx+edx+0B2h]
        mov eax, ecx
        cmp dx, bx
        je short .22
        mov dl, byte [dword ecx+0B1h]
        dec dl
        and dl, 7
        mov byte [dword ecx+0B1h], dl
.22:
        movsx edx, bx
        call assreplace
        test byte [dword ecx+0BFh], 40h
        je short .23
        mov edx, dword [dword ecx+0A3h]
        sar edx, 18h
        imul edx, dword 125h
        mov eax, dword [dword ecx+0FEh]
        mov eax, dword [dword eax+0108h]
        add eax, 0A3h
        add eax, edx
        mov dword [FaceoffPuckY], eax
        jmp short .26
.23:
        mov eax, dword [dword ecx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        imul ebx, eax, dword 125h
        lea eax, [dword edx+0A3h]
        add eax, ebx
        mov dword [FaceoffPuckX], eax
        jmp short .26
.24:
        mov edx, dword [dword ecx+0AEh]
        sar edx, 18h
        mov ebx, 7
        movsx dx, byte [dword ecx+edx+0B2h]
        mov eax, ecx
        cmp dx, bx
        je short .25
        mov dl, byte [dword ecx+0B1h]
        dec dl
        and dl, 7
        mov byte [dword ecx+0B1h], dl
.25:
        movsx edx, bx
        call assreplace
.26:
        mov eax, ecx
        call FaceoffSpotPosition
        mov eax, dword [dword ecx+0EEh]
        fld dword [eax]
        call __CHP
        fistp dword [byte esp+0Ch]
        mov eax, dword [byte esp+0Ch]
        mov word [byte ecx+06h], ax
        fild word [byte ecx+06h]
        mov eax, dword [dword ecx+0EEh]
        fstp dword [byte ecx+020h]
        fld dword [byte eax+04h]
        call __CHP
        fistp dword [byte esp+0Ch]
        mov eax, dword [byte esp+0Ch]
        mov word [byte ecx+0Eh], ax
        fild word [byte ecx+0Eh]
        mov eax, ecx
        fstp dword [byte ecx+028h]
        call FaceoffPuckDrop
        and byte [dword ecx+0BFh], 0DBh
        and byte [dword ecx+0C0h], 0DBh
.27:
        inc esi
        add ecx, 108h
        cmp esi, byte 0Ch
        jl near .21
        mov eax, dword [PtrPuckObject]
        mov eax, dword [dword eax+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [PtrPuckObject]
        mov eax, dword [dword eax+0EEh]
        mov dword [byte eax+0Ch], 0
        cmp word [FaceoffSpot], byte 0
        jg short .28
        mov eax, dword [StatsPanelOn]
        sar eax, 10h
        sub eax, 90h
        mov dword [byte esp+0Ch], eax
        mov eax, dword [PtrPuckObject]
        mov eax, dword [dword eax+0EEh]
        fild dword [byte esp+0Ch]
        fst dword [eax]
        mov eax, dword [PtrPuckObject]
        fstp dword [byte eax+020h]
        mov eax, dword [PtrPuckObject]
        mov eax, dword [dword eax+0EEh]
        mov dword [byte eax+010h], 46800000h
        jmp short .29
.28:
        mov eax, dword [StatsPanelOn]
        sar eax, 10h
        add eax, 90h
        mov dword [byte esp+0Ch], eax
        mov eax, dword [PtrPuckObject]
        mov eax, dword [dword eax+0EEh]
        fild dword [byte esp+0Ch]
        fst dword [eax]
        mov eax, dword [PtrPuckObject]
        fstp dword [byte eax+020h]
        mov eax, dword [PtrPuckObject]
        mov eax, dword [dword eax+0EEh]
        mov dword [byte eax+010h], 0C6800000h
.29:
        mov eax, dword [PtrPuckObject]
        mov dword [byte eax+024h], 0
        mov eax, dword [PtrPuckObject]
        mov eax, dword [dword eax+0EEh]
        fild word [FaceoffZone]
        fst dword [byte eax+04h]
        mov eax, dword [PtrPuckObject]
        fstp dword [byte eax+028h]
        mov eax, dword [PtrPuckObject]
        mov edx, dword [dword eax+0AEh]
        sar edx, 18h
        mov ebx, 33h
        mov byte [dword edx+eax+0B2h], bl
        or byte [dword eax+0BFh], 2
        mov eax, dword [PtrPuckObject]
        call FaceoffPuckDrop
        mov eax, dword [PtrPuckObject]
        mov ch, byte [dword eax+0BFh]
        and ch, 0DFh
        mov esi, 0FFFFFFFFh
        mov byte [dword eax+0BFh], ch
        call FaceoffDropCameraScene
        xor eax, eax
        xor ecx, ecx
.30:
        add eax, byte 2
        add ecx, byte 4
        xor edx, edx
        mov word [dword eax+SlotPlayers], si
        mov dword [dword ecx+InputActive], edx
        cmp eax, byte 10h
        jne short .30
        xor esi, esi
        xor ecx, ecx
        mov ebx, 2
.31:
        mov ax, word [dword ecx+slotteam]
        test ax, ax
        je short .34
        movsx edx, si
        cmp bx, ax
        jne short .32
        mov eax, HomeTeamRecord+420h
        jmp short .33
.32:
        mov eax, SortCords
.33:
        call changeplayer
.34:
        inc esi
        add ecx, byte 2
        cmp esi, byte 8
        jl short .31
        mov eax, 78h
        call randomd0
        movsx edx, ax
        add edx, 0B4h
        mov eax, edx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov dword [byte edi+060h], eax
        cmp word [FaceoffSpot], byte 0
        jne short .35
        cmp word [FaceoffZone], byte 0
        je short .40
.35:
        cmp word [FaceoffSpot], byte 0
        jle short .36
        mov eax, dword [StatsPanelOn]
        sar eax, 10h
        jmp short .37
.36:
        mov eax, dword [StatsPanelOn]
        sar eax, 10h
        neg eax
.37:
        cmp eax, 420h
        jne short .41
        cmp word [FaceoffZone], byte 0
        jle short .38
        mov eax, dword [FaceoffSpot]
        sar eax, 10h
        jmp short .39
.38:
        mov eax, dword [FaceoffSpot]
        sar eax, 10h
        neg eax
.39:
        cmp eax, 0CF0h
        jne short .41
.40:
        mov eax, 1
        jmp short .42
.41:
        xor eax, eax
.42:
        mov ebx, dword [LastTouchPlayer]
        push ebx
        push eax
        mov ecx, dword [FaceoffPuckY]
        push ecx
        mov esi, dword [FaceoffPuckX]
        push esi
        push dword 0A0000018h
        call CommentaryEvent
        add esp, byte 14h
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.43:
        mov edx, dword [byte eax+060h]
        dec edx
        mov dword [byte eax+060h], edx
        cmp edx, byte 11h
        jg short .45
        jne short .44
        mov eax, dword [PtrPuckObject]
        call RefFaceoffAnim
.44:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+024h], 41C00000h
        jg short .45
        mov eax, edi
        call Endfaceoff
.45:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
