; Referee assignments: penalty shot, signals, whistle, goal, follow, drop and at the dot.
bits 32
%include "hockey.inc"
section s_28D87 progbits alloc exec nowrite align=1
extern AimAtPuckTarget, AllInPlace, AngleOfVector, AssistOne, AssistTwo, awtmstruct, BreakawayFlag, F32_96_assrefdrop
extern F32_96_assrefgoalline, F32_96_assrefpenshot, F32_96_assrefsignal, F32_96_assrefwhistle, F64_2040, F64_4800, FaceoffSpot, FaceoffWinner
extern FaceoffZone, gameclock, GameOptionFlags, gameover, GoalJudgeTest, GoalLineFlag, GoalLinePuckTest, GoalScorer
extern gsp, hmtmstruct, IsCameraOnPuck, PaEvent, PenaltyShotCameraScene, penshotmode, penshottimer, PeriodOver
extern PlaySfxVolume, PtrPuckFlags, PtrPuckObject, PtrPuckOwner, PtrPuckState, PtrPuckTarget, PtrPuckZone, QueueOverlayPanel
extern randomd0, RefAtDotAnim, RefDodgePuck, RefGoalLineAnim, RefGoalPaAnim, RefPlayer, RefSignal, RefSignalAnim
extern RefState, RefTarget, RefWhistleAnim, regd1, ReleaseBoxPlayers, SetFaceBlink, SetSkateSpeedFromRating, SortCords
extern StartCrowdMusic, StartWhistleStop, StatsPanelOn, StatsPanelPlayer, StopObject, TriggerCameraFlashes, WhistleTime, ZoneFlags
extern ZoneTargetX, ZoneTargetY
global assrefpenshot, assrefsignal, assrefwhistle, assrefgoalpa, assrefgoalline, assreffollow, assrefdrop, assrefatdot
        db 090h
;-----------------------------------------------------------------------------
; assrefpenshot                                   28D88  95 PC, low confidence
; Asstab 2Ch (assrefdrop in penshotmode): places the puck at centre (puckc
; 10h), waits for penshotplayer, then drops it; with no shooter goes to 21h
;-----------------------------------------------------------------------------
assrefpenshot:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        sub esp, byte 1Ch
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .12
        mov dl, byte [dword ebx+0BFh]
        test dl, 2
        je near .4
        mov dh, dl
        and dh, 0FDh
        mov byte [dword ebx+0BFh], dh
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 7
        jne short .1
        mov eax, dword [PtrPuckObject]
        mov edx, 1
        mov eax, dword [dword eax+0F2h]
        call SetFaceBlink
.1:
        mov ch, byte [dword ebx+0C0h]
        or ch, 20h
        mov eax, dword [dword ebx+0EEh]
        mov byte [dword ebx+0C0h], ch
        mov dword [eax], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+04h], 0
        mov eax, dword [dword ebx+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [PtrPuckObject]
        fldz
        fcomp dword [byte eax+020h]
        fnstsw ax
        sahf
        ja short .2
        mov dword [byte esp+010h], 0FFFFC000h
        jmp short .3
.2:
        mov dword [byte esp+010h], 4000h
.3:
        mov eax, dword [dword ebx+0EEh]
        fild dword [byte esp+010h]
        fstp dword [byte eax+010h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42C80000h
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, ebx
        call SetSkateSpeedFromRating
        mov dword [byte ebx+060h], 0
        mov edx, dword [penshottimer]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        xor edx, edx
        mov cl, byte [dword eax+0BFh]
        mov dl, byte [dword eax+0A4h]
        test cl, 80h
        sete al
        and eax, 0FFh
        call PenaltyShotCameraScene
.4:
        mov eax, dword [penshottimer]
        sar eax, 10h
        cmp eax, byte 0FFFFFFFFh
        jne short .5
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        mov eax, 34h
        mov byte [dword edx+ebx+0B2h], al
        or byte [dword ebx+0BFh], 2
        jmp near .12
.5:
        mov esi, dword [byte ebx+060h]
        cmp esi, byte 64h
        je near .12
        cmp esi, byte 1
        jne near .6
        lea ebp, [esi+esi]
        mov dword [byte ebx+060h], ebp
        mov eax, dword [PtrPuckZone]
        mov byte [eax], 0FFh
        mov eax, dword [PtrPuckFlags]
        call StopObject
        call IsCameraOnPuck
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+028h], 0
        fld dword [byte eax+028h]
        mov eax, dword [PtrPuckFlags]
        fst dword [byte eax+024h]
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+020h]
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+038h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [eax], 44F30000h
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+04h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+010h], 0C6800000h
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+0Ch], 0
.6:
        fild word [byte ebx+06h]
        fstp dword [byte esp+04h]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+04h]
        fsub dword [eax]
        fldz
        fxch
        fstp dword [byte esp+018h]
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        jbe short .7
        fld dword [byte esp+018h]
        fchs
        fstp dword [byte esp+0Ch]
        jmp short .8
.7:
        mov eax, dword [byte esp+018h]
        mov dword [byte esp+0Ch], eax
.8:
        fld dword [byte esp+0Ch]
        fcomp dword [F32_96_assrefpenshot]
        fnstsw ax
        sahf
        ja near .12
        fild word [byte ebx+0Eh]
        fstp dword [byte esp+08h]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+08h]
        fsub dword [byte eax+04h]
        fldz
        fxch
        fstp dword [esp]
        fcomp dword [esp]
        fnstsw ax
        sahf
        jbe short .9
        fld dword [esp]
        fchs
        fstp dword [byte esp+014h]
        jmp short .10
.9:
        mov eax, dword [esp]
        mov dword [byte esp+014h], eax
.10:
        fld dword [byte esp+014h]
        fcomp dword [F32_96_assrefpenshot]
        fnstsw ax
        sahf
        ja short .12
        mov eax, dword [byte ebx+060h]
        test eax, eax
        jne short .11
        lea ecx, [byte eax+01h]
        mov dword [byte ebx+038h], eax
        mov dword [byte ebx+060h], ecx
        mov dword [RefTarget], eax
        add esp, byte 1Ch
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        call AllInPlace
        test eax, eax
        je short .12
        push dword [byte ebx+028h]
        mov edx, 64h
        mov eax, 461h
        push dword [byte ebx+020h]
        call PlaySfxVolume
        mov edx, 0FFFFFFFFh
        mov dword [byte ebx+060h], 64h
        mov dword [RefTarget], edx
.12:
        add esp, byte 1Ch
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; assrefsignal                                    29064  95 PC, low confidence
; Referee assignment 37h: plays move 0A3Dh, skates to the signalling spot, queues the overlay panel, then
; moves on to assignment 34h and calls the goal PA (PaEvent 0C0000001h) with the scorer's jersey
;-----------------------------------------------------------------------------
assrefsignal:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 1Ch
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .16
        mov dl, byte [dword ebx+0BFh]
        test dl, 2
        je near .5
        mov dh, dl
        and dh, 0FDh
        mov eax, 0A3Dh
        mov byte [dword ebx+0BFh], dh
        call TriggerCameraFlashes
        or byte [dword ebx+0C0h], 20h
        fldz
        fcomp dword [byte ebx+020h]
        fnstsw ax
        sahf
        jae short .1
        mov eax, 180h
        jmp short .2
.1:
        mov eax, 0FFFFFE80h
.2:
        mov word [ZoneTargetY], ax
        mov eax, dword [PtrPuckFlags]
        fldz
        fcomp dword [byte eax+028h]
        fnstsw ax
        sahf
        jae short .3
        mov eax, 10B0h
        jmp short .4
.3:
        mov eax, 0FFFFEF50h
.4:
        mov word [regd1], ax
        mov eax, dword [dword ebx+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword ebx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword ebx+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [ZoneTargetX]
        sar eax, 10h
        push byte 0
        neg eax
        push eax
        call AngleOfVector
        mov dword [byte esp+08h], eax
        add esp, byte 8
        mov eax, dword [dword ebx+0EEh]
        fild dword [esp]
        fstp dword [byte eax+010h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+014h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, ebx
        call SetSkateSpeedFromRating
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42FA0000h
        mov eax, dword [FaceoffWinner]
        sar eax, 10h
        push eax
        mov eax, dword [gameover]
        sar eax, 10h
        push eax
        mov eax, dword [AssistTwo]
        sar eax, 10h
        push eax
        mov eax, dword [AssistOne]
        sar eax, 10h
        push eax
        mov eax, dword [StatsPanelPlayer]
        sar eax, 10h
        push eax
        push dword 1F4h
        push byte 5
        mov edx, 320h
        call QueueOverlayPanel
        add esp, byte 1Ch
        mov dword [RefPlayer], edx
.5:
        fild word [byte ebx+06h]
        fstp dword [byte esp+08h]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+08h]
        fsub dword [eax]
        fldz
        fxch
        fstp dword [byte esp+014h]
        fcomp dword [byte esp+014h]
        fnstsw ax
        sahf
        jbe short .6
        fld dword [byte esp+014h]
        fchs
        fstp dword [byte esp+010h]
        jmp short .7
.6:
        mov eax, dword [byte esp+014h]
        mov dword [byte esp+010h], eax
.7:
        fld dword [byte esp+010h]
        fcomp dword [F32_96_assrefsignal]
        fnstsw ax
        sahf
        ja near .16
        fild word [byte ebx+0Eh]
        fstp dword [byte esp+04h]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+04h]
        fsub dword [byte eax+04h]
        fldz
        fxch
        fstp dword [byte esp+018h]
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        jbe short .8
        fld dword [byte esp+018h]
        fchs
        fstp dword [byte esp+0Ch]
        jmp short .9
.8:
        mov eax, dword [byte esp+018h]
        mov dword [byte esp+0Ch], eax
.9:
        fld dword [byte esp+0Ch]
        fcomp dword [F32_96_assrefsignal]
        fnstsw ax
        sahf
        ja near .16
        mov eax, ebx
        mov dword [byte ebx+038h], 0
        call RefSignalAnim
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 34h
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword ebx+0BFh], 2
        mov eax, dword [FaceoffWinner]
        sar eax, 10h
        mov ebx, eax
        shl ebx, 4
        add ebx, eax
        xor esi, esi
        shl ebx, 2
        xor ecx, ecx
        sub ebx, eax
        mov edx, dword [StatsPanelPlayer]
        shl ebx, 2
        sar edx, 10h
        add ebx, hmtmstruct
        cmp edx, byte 0FFFFFFFFh
        je near .16
        mov di, word [AssistOne]
        xor eax, eax
        cmp di, byte 19h
        jge short .10
        imul edx, dword 125h
        mov edi, dword [dword ebx+0108h]
        add edi, 0A3h
        jmp short .11
.10:
        sub edx, byte 19h
        imul edx, dword 125h
        mov edi, dword [dword ebx+0108h]
        add edi, 1D42h
.11:
        add edi, edx
        mov edx, dword [AssistOne]
        sar edx, 10h
        cmp edx, byte 0FFFFFFFFh
        je near .15
        mov si, word [AssistTwo]
        inc eax
        cmp si, byte 19h
        jge short .12
        imul edx, dword 125h
        mov esi, dword [dword ebx+0108h]
        add esi, 0A3h
        jmp short .13
.12:
        sub edx, byte 19h
        imul edx, dword 125h
        mov esi, dword [dword ebx+0108h]
        add esi, 1D42h
.13:
        add esi, edx
        mov edx, dword [AssistTwo]
        sar edx, 10h
        cmp edx, byte 0FFFFFFFFh
        je short .15
        mov cx, word [GoalScorer]
        inc eax
        cmp cx, byte 19h
        jge short .14
        imul edx, dword 125h
        mov ebx, dword [dword ebx+0108h]
        add ebx, 0A3h
        lea ecx, [ebx+edx]
        jmp short .15
.14:
        sub edx, byte 19h
        imul ecx, edx, dword 125h
        mov ebx, dword [dword ebx+0108h]
        add ebx, 1D42h
        add ecx, ebx
.15:
        push ecx
        push esi
        mov edx, dword [FaceoffWinner]
        push edi
        sar edx, 10h
        push edx
        push eax
        push dword 0C0000001h
        call PaEvent
        add esp, byte 18h
.16:
        add esp, byte 1Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; assrefwhistle                                293A8  95 PC, medium confidence
;
; Referee assignment 35h: on a stoppage (clock 0, or a tie broken in the last period) sets RefStep
; (RefTarget) -1, the puck to assignment 42h (puckfaceoff) and the referee to 33h (assrefatdot); otherwise
; skates the referee along
;-----------------------------------------------------------------------------
assrefwhistle:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 1Ch
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .9
        test byte [dword ebx+0BFh], 2
        je near .4
        cmp dword [RefState], byte 0
        jne short .2
        cmp word [gameclock], byte 0
        jne short .1
        cmp word [StatsPanelOn], byte 0
        je short .2
.1:
        cmp word [gsp], byte 3
        jne short .3
        mov di, word [awtmstruct]
        cmp di, word [hmtmstruct]
        je short .3
.2:
        mov eax, dword [PtrPuckFlags]
        mov ecx, dword [dword eax+0AEh]
        sar ecx, 18h
        mov edx, 42h
        mov byte [dword ecx+eax+0B2h], dl
        or byte [dword eax+0BFh], 2
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        mov eax, 33h
        mov byte [dword edx+ebx+0B2h], al
        mov dh, byte [dword ebx+0BFh]
        or dh, 2
        mov esi, 0FFFFFFFFh
        mov byte [dword ebx+0BFh], dh
        mov dword [RefTarget], esi
        jmp near .9
.3:
        mov dh, byte [dword ebx+0BFh]
        and dh, 0FDh
        mov ecx, 1
        mov byte [dword ebx+0BFh], dh
        mov dword [RefTarget], ecx
        mov eax, dword [dword ebx+0EEh]
        mov dword [eax], 44FF0000h
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+04h], 0
        mov eax, dword [dword ebx+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+08h], 0
        push byte 0
        mov eax, dword [dword ebx+0EEh]
        push dword 7F8h
        mov dword [byte eax+0Ch], 0
        call AngleOfVector
        mov dword [byte esp+0Ch], eax
        add esp, byte 8
        mov eax, dword [dword ebx+0EEh]
        fild dword [byte esp+04h]
        fstp dword [byte eax+010h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+014h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, ebx
        call SetSkateSpeedFromRating
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42FA0000h
        test byte [dword ebx+0C1h], 10h
        jne short .4
        call ReleaseBoxPlayers
        mov eax, dword [WhistleTime]
        sar eax, 10h
        call StartCrowdMusic
        and byte [dword ebx+0C1h], 0FDh
        mov eax, ebx
        call StartWhistleStop
.4:
        fild word [byte ebx+06h]
        fstp dword [esp]
        mov eax, dword [dword ebx+0EEh]
        fld dword [esp]
        fsub dword [eax]
        fldz
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jbe short .5
        fld dword [byte esp+0Ch]
        fchs
        fstp dword [byte esp+010h]
        jmp short .6
.5:
        mov eax, dword [byte esp+0Ch]
        mov dword [byte esp+010h], eax
.6:
        fld dword [byte esp+010h]
        fcomp dword [F32_96_assrefwhistle]
        fnstsw ax
        sahf
        ja short .9
        fild word [byte ebx+0Eh]
        fstp dword [byte esp+014h]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+014h]
        fsub dword [byte eax+04h]
        fldz
        fxch
        fstp dword [byte esp+018h]
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        jbe short .7
        fld dword [byte esp+018h]
        fchs
        fstp dword [byte esp+08h]
        jmp short .8
.7:
        mov eax, dword [byte esp+018h]
        mov dword [byte esp+08h], eax
.8:
        fld dword [byte esp+08h]
        fcomp dword [F32_96_assrefwhistle]
        fnstsw ax
        sahf
        ja short .9
        mov eax, ebx
        mov dword [byte ebx+038h], 0
        call RefWhistleAnim
.9:
        add esp, byte 1Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; assrefgoalpa                                 295CC  95 PC, medium confidence
; Referee assignment 34h: set by assrefsignal, assrefpenshot and EndPenaltyShot; after the goal
; call sends the referee on (32h / 33h / 35h) and the puck to 42h (puckfaceoff)
;-----------------------------------------------------------------------------
assrefgoalpa:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 8
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .13
        cmp dword [RefPlayer], byte 0
        jge near .13
        mov edx, dword [PtrPuckFlags]
        fld dword [byte edx+020h]
        fabs
        fcomp qword [F64_2040]
        fnstsw ax
        sahf
        ja short .1
        fld dword [byte edx+028h]
        fabs
        fcomp qword [F64_4800]
        fnstsw ax
        sahf
        jbe short .2
.1:
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 35h
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword ebx+0BFh], 2
        jmp near .13
.2:
        test byte [dword ebx+0BFh], 2
        je near .6
        cmp dword [RefState], byte 0
        jne short .4
        cmp word [gameclock], byte 0
        jne short .3
        cmp word [StatsPanelOn], byte 0
        je short .4
.3:
        cmp word [gsp], byte 3
        jne short .5
        mov di, word [awtmstruct]
        cmp di, word [hmtmstruct]
        je short .5
.4:
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [dword eax+0AEh]
        sar edx, 18h
        mov ecx, 42h
        mov byte [dword edx+eax+0B2h], cl
        or byte [dword eax+0BFh], 2
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 33h
        mov byte [dword ebx+eax+0B2h], dl
        mov ch, byte [dword ebx+0BFh]
        or ch, 2
        mov eax, 0FFFFFFFFh
        mov byte [dword ebx+0BFh], ch
        mov dword [RefTarget], eax
        add esp, byte 8
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov eax, 51Eh
        call TriggerCameraFlashes
        mov dh, byte [dword ebx+0BFh]
        and dh, 0FDh
        mov esi, 1
        mov byte [dword ebx+0BFh], dh
        mov dword [RefTarget], esi
        mov dword [byte ebx+060h], 0
        call ReleaseBoxPlayers
        mov eax, dword [WhistleTime]
        sar eax, 10h
        call StartCrowdMusic
        mov cl, byte [dword ebx+0C1h]
        and cl, 0FDh
        mov eax, ebx
        mov byte [dword ebx+0C1h], cl
        call StartWhistleStop
        or byte [dword ebx+0C1h], 10h
.6:
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jl short .7
        mov byte [eax], 0FFh
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [dword eax+0AEh]
        sar edx, 18h
        add edx, eax
        cmp byte [dword edx+0B2h], 41h
        jne short .7
        mov word [byte esp+04h], 40h
        mov cl, byte [byte esp+04h]
        mov byte [dword edx+0B2h], cl
        or byte [dword eax+0BFh], 2
.7:
        cmp dword [byte ebx+060h], 1E0h
        jl short .8
        mov eax, dword [PtrPuckZone]
        mov byte [eax], 0Ch
        call PeriodOver
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+038h], 0
        mov eax, dword [PtrPuckState]
        mov word [eax], 0C0h
        mov ax, word [eax]
        mov dword [esp], eax
        mov eax, dword [PtrPuckFlags]
        fild word [esp]
        fstp dword [byte eax+024h]
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 32h
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword ebx+0BFh], 2
        add esp, byte 8
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        mov eax, dword [PtrPuckFlags]
        call GoalLinePuckTest
        test eax, eax
        je short .10
        mov eax, dword [PtrPuckTarget]
        mov ax, word [eax]
        mov word [ZoneTargetY], ax
        mov eax, dword [PtrPuckOwner]
        cmp word [eax], byte 0
        jge short .9
        mov eax, 0FFFFEF80h
        jmp short .11
.9:
        mov eax, 1080h
        jmp short .11
.10:
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [PtrPuckTarget]
        mov ecx, dword [byte eax+018h]
        movsx edx, word [edx]
        sar ecx, 0Ch
        add edx, ecx
        mov word [ZoneTargetY], dx
        mov edx, dword [byte eax+018h]
        mov eax, dword [PtrPuckOwner]
        sar edx, 0Ch
        movsx eax, word [eax]
        add eax, edx
.11:
        mov word [regd1], ax
        mov edx, dword [PtrPuckFlags]
        mov eax, ebx
        call GoalJudgeTest
        test eax, eax
        je short .12
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+038h], 0
        mov eax, ebx
        mov dword [byte ebx+038h], 0
        call RefGoalPaAnim
        add esp, byte 8
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.12:
        add dword [byte ebx+060h], byte 2
        mov eax, dword [dword ebx+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword ebx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword ebx+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [dword ebx+0EEh]
        mov ecx, dword [byte eax+038h]
        mov dword [byte edx+08h], ecx
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [dword ebx+0EEh]
        mov ecx, dword [byte eax+040h]
        mov dword [byte edx+0Ch], ecx
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, ebx
        call SetSkateSpeedFromRating
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42FA0000h
        mov eax, ebx
        call AimAtPuckTarget
.13:
        add esp, byte 8
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; assrefgoalline                                  298E8  95 PC, low confidence
; Referee assignment 36h, set by nothing: skates the referee to
; a fixed spot at one end and then to 34h
;-----------------------------------------------------------------------------
assrefgoalline:
        push ebx
        push ecx
        push edx
        sub esp, byte 18h
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .8
        mov dl, byte [dword ebx+0BFh]
        test dl, 2
        je near .1
        mov dh, dl
        and dh, 0FDh
        mov byte [dword ebx+0BFh], dh
        cmp word [BreakawayFlag], byte 0Eh
        jl near .7
        mov eax, dword [dword ebx+0EEh]
        mov dword [eax], 44ED0000h
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+04h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+010h], 0C6800000h
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, ebx
        call SetSkateSpeedFromRating
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42FA0000h
        mov cl, byte [dword ebx+0C1h]
        and cl, 0FDh
        mov eax, ebx
        mov byte [dword ebx+0C1h], cl
        call StartWhistleStop
        and byte [dword ebx+0C1h], 0EFh
.1:
        fild word [byte ebx+06h]
        fstp dword [byte esp+0Ch]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+0Ch]
        fsub dword [eax]
        fldz
        fxch
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        jbe short .2
        fld dword [byte esp+010h]
        fchs
        fstp dword [esp]
        jmp short .3
.2:
        mov eax, dword [byte esp+010h]
        mov dword [esp], eax
.3:
        fld dword [esp]
        fcomp dword [F32_96_assrefgoalline]
        fnstsw ax
        sahf
        ja near .8
        fild word [byte ebx+0Eh]
        fstp dword [byte esp+08h]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+08h]
        fsub dword [byte eax+04h]
        fldz
        fxch
        fstp dword [byte esp+014h]
        fcomp dword [byte esp+014h]
        fnstsw ax
        sahf
        jbe short .4
        fld dword [byte esp+014h]
        fchs
        fstp dword [byte esp+04h]
        jmp short .5
.4:
        mov eax, dword [byte esp+014h]
        mov dword [byte esp+04h], eax
.5:
        fld dword [byte esp+04h]
        fcomp dword [F32_96_assrefgoalline]
        fnstsw ax
        sahf
        ja short .8
        mov al, byte [dword ebx+0C1h]
        mov dword [byte ebx+038h], 0
        test al, 10h
        jne short .6
        mov dh, al
        or dh, 10h
        mov byte [dword ebx+0C1h], dh
        mov edx, dword [GoalLineFlag]
        mov eax, ebx
        sar edx, 10h
        call RefGoalLineAnim
        jmp short .8
.6:
        cmp byte [RefSignal], 0
        jne short .8
.7:
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 34h
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword ebx+0BFh], 2
.8:
        add esp, byte 18h
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; assreffollow                                    29A90  95 PC, low confidence
; Referee assignment 31h: while the clock runs, picks a spot from the puck's
; side and position and skates the referee there
;-----------------------------------------------------------------------------
assreffollow:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 4
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .7
        cmp word [gameclock], byte 0
        jne short .1
        cmp word [StatsPanelOn], byte 0
        je near .7
.1:
        mov dl, byte [dword ebx+0BFh]
        and dl, 0FDh
        mov si, word [byte ebx+06h]
        mov byte [dword ebx+0BFh], dl
        test si, si
        jle short .2
        mov eax, 5FAh
        jmp short .3
.2:
        mov eax, 0FFFFFA06h
.3:
        mov word [ZoneTargetY], ax
        mov eax, dword [PtrPuckOwner]
        mov dx, word [eax]
        mov word [regd1], dx
        test dx, dx
        jge short .4
        add edx, 1E0h
        mov word [regd1], dx
        jmp short .5
.4:
        mov eax, edx
        db 081h,0E8h,0E0h,01h,00h,00h           ; insn: sub eax,1E0h
        mov word [regd1], ax
.5:
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 7
        jne short .6
        mov eax, dword [PtrPuckObject]
        mov edx, 1
        mov eax, dword [dword eax+0F2h]
        call SetFaceBlink
.6:
        mov eax, ebx
        call RefDodgePuck
        mov eax, dword [dword ebx+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword ebx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword ebx+0EEh]
        and byte [byte eax+028h], 7Fh
        mov edx, dword [PtrPuckFlags]
        mov eax, dword [dword ebx+0EEh]
        mov ecx, dword [byte edx+038h]
        mov dword [byte eax+08h], ecx
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [dword ebx+0EEh]
        mov ecx, dword [byte eax+040h]
        mov dword [byte edx+0Ch], ecx
        mov eax, dword [byte ebx+0Ch]
        mov edx, dword [ZoneFlags]
        sar eax, 10h
        sar edx, 10h
        sub edx, eax
        mov eax, dword [ZoneTargetX]
        push edx
        mov edx, dword [byte ebx+04h]
        sar eax, 10h
        sar edx, 10h
        sub eax, edx
        push eax
        call AngleOfVector
        mov dword [byte esp+08h], eax
        add esp, byte 8
        mov eax, dword [dword ebx+0EEh]
        fild dword [esp]
        fstp dword [byte eax+010h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+014h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 42480000h
        mov eax, ebx
        call SetSkateSpeedFromRating
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42C80000h
.7:
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; assrefdrop                                      29BFC  95 PC, low confidence
; Referee assignment 32h (after assintrostand and assrefgoalpa): in a penalty
; shot goes to 38h (assrefpenshot), else to 33h (assrefatdot) for the faceoff
;-----------------------------------------------------------------------------
assrefdrop:
        push ebx
        push ecx
        push edx
        sub esp, byte 1Ch
        mov ebx, eax
        cmp word [penshotmode], byte 0
        je short .1
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        mov eax, 38h
        mov byte [dword edx+ebx+0B2h], al
        or byte [dword ebx+0BFh], 2
        jmp near .12
.1:
        test byte [dword eax+0BFh], 20h
        jne near .12
        mov dl, byte [dword ebx+0BFh]
        test dl, 2
        je near .7
        mov cl, dl
        and cl, 0FDh
        mov byte [dword ebx+0BFh], cl
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 7
        jne short .2
        mov eax, dword [PtrPuckObject]
        mov edx, 1
        mov eax, dword [dword eax+0F2h]
        call SetFaceBlink
.2:
        cmp word [FaceoffSpot], byte 0
        jg short .3
        mov eax, dword [StatsPanelOn]
        sar eax, 10h
        sub eax, 90h
        jmp short .4
.3:
        mov eax, dword [StatsPanelOn]
        sar eax, 10h
        add eax, 90h
.4:
        mov word [ZoneTargetY], ax
        mov ax, word [FaceoffZone]
        mov word [regd1], ax
        mov eax, dword [dword ebx+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword ebx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword ebx+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+0Ch], 0
        cmp word [FaceoffSpot], byte 0
        jg short .5
        mov dword [byte esp+014h], 4000h
        jmp short .6
.5:
        mov dword [byte esp+014h], 0FFFFC000h
.6:
        mov eax, dword [dword ebx+0EEh]
        fild dword [byte esp+014h]
        fstp dword [byte eax+010h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+014h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, ebx
        call SetSkateSpeedFromRating
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42FA0000h
        mov dh, byte [dword ebx+0C1h]
        and dh, 0FDh
        mov eax, ebx
        mov byte [dword ebx+0C1h], dh
        call StartWhistleStop
        mov eax, dword [PtrPuckZone]
        mov byte [eax], 0Ch
        call PeriodOver
        add esp, byte 1Ch
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        fild word [byte ebx+06h]
        fstp dword [byte esp+08h]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+08h]
        fsub dword [eax]
        fldz
        fxch
        fstp dword [byte esp+018h]
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        jbe short .8
        fld dword [byte esp+018h]
        fchs
        fstp dword [esp]
        jmp short .9
.8:
        mov eax, dword [byte esp+018h]
        mov dword [esp], eax
.9:
        fld dword [esp]
        fcomp dword [F32_96_assrefdrop]
        fnstsw ax
        sahf
        ja short .12
        fild word [byte ebx+0Eh]
        fstp dword [byte esp+0Ch]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+0Ch]
        fsub dword [byte eax+04h]
        fldz
        fxch
        fstp dword [byte esp+04h]
        fcomp dword [byte esp+04h]
        fnstsw ax
        sahf
        jbe short .10
        fld dword [byte esp+04h]
        fchs
        fstp dword [byte esp+010h]
        jmp short .11
.10:
        mov eax, dword [byte esp+04h]
        mov dword [byte esp+010h], eax
.11:
        fld dword [byte esp+010h]
        fcomp dword [F32_96_assrefdrop]
        fnstsw ax
        sahf
        ja short .12
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 33h
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword ebx+0BFh], 2
        mov dword [RefTarget], 0FFFFFFFFh
.12:
        add esp, byte 1Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; assrefatdot                                  29E2C  95 PC, medium confidence
; Referee assignment 33h: holds the referee at the faceoff spot while play is
; stopped, with a random idle timer; assrefwhistle puts the referee here
;-----------------------------------------------------------------------------
assrefatdot:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .4
        cmp dword [RefState], byte 0
        jne near .4
        cmp word [gameclock], byte 0
        jne short .1
        cmp word [StatsPanelOn], byte 0
        je near .4
.1:
        mov dl, byte [dword ebx+0BFh]
        test dl, 2
        je near .3
        mov dh, dl
        and dh, 0FDh
        mov eax, ebx
        mov byte [dword ebx+0BFh], dh
        call RefAtDotAnim
        mov cl, byte [dword ebx+0C1h]
        and cl, 0FDh
        mov eax, ebx
        mov byte [dword ebx+0C1h], cl
        call StartWhistleStop
        call PeriodOver
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 7
        jne short .2
        mov eax, dword [PtrPuckObject]
        mov edx, 1
        mov eax, dword [dword eax+0F2h]
        call SetFaceBlink
.2:
        and byte [dword ebx+0C1h], 0EFh
        mov ah, byte [dword ebx+0BFh]
        mov dl, byte [dword ebx+0C0h]
        and ah, 0FBh
        and dl, 0DFh
        mov byte [dword ebx+0BFh], ah
        mov eax, 3E8h
        mov byte [dword ebx+0C0h], dl
        call randomd0
        movsx edx, ax
        mov eax, edx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov dword [byte ebx+060h], eax
.3:
        mov ecx, dword [byte ebx+060h]
        dec ecx
        mov dword [byte ebx+060h], ecx
        test ecx, ecx
        jge short .4
        mov eax, 3
        call randomd0
        mov eax, 3E8h
        call randomd0
        movsx edx, ax
        mov eax, edx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov dword [byte ebx+060h], eax
.4:
        pop edx
        pop ecx
        pop ebx
        ret
