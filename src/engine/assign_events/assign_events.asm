; Event assignments: scoring, goalie pulls, benches and boxes, penalty shots, leaving the ice, penalties.
bits 32
%include "hockey.inc"
section s_2720F progbits alloc exec nowrite align=1
extern __CHP, AngleOfVector, assreplace, AwayEbenPlayer, AwayGoalieOff, AwayTeamRecord, BenchRequest, changeplayer
extern check4bench, ChkShoot, ClearPlayerFlags, CommentaryEvent, doplayeracc, F32_144, F32_144_assleavebox, F32_144_asspenalty
extern F32_144_asspsclear, F32_40, F32_48_assleavebox, F32_96, F32_96_assleaveice, F32_96_asspenalty, F32_96_asspsclear, F64_240
extern F64_3312, F64_720, FaceoffRequest, FaceoffZone, forcepldata, FreeBoxSeat, gameclock, GameOptionFlags
extern GetSeatPos, gmode, GoToBoxAnim, gsp, hmtmstruct, HomeEbenPlayer, HomeGoalieOff, HomeTeamRecord
extern LeaveBoxAnim, MoveBoxToBenchSeat, PassPending, PassPlayer, PenaltyAnimPos, PenaltyAnimTime, PenaltyBoxCount, PenaltyCameraScene
extern penshotlive, penshotmode, penshottimer, PickBoxSeat, PlayerAssignWords, PlayerPointsTable, PlayerScoreTable, PlayFlags
extern PlaySfxVolume, PtrPuckFlags, PtrPuckObject, PtrPuckZone, randomd0, regd1, ResetAnimTimer, SetCrowdMood
extern SetFaceBlink, SetFaceExpression, SetFaceMouth, SetPenaltyBoxDoor, Setplass, setplayer, SetPlayerTarget, SetSkateSpeedFromRating
extern SetSlotPlayer, SetSPA, SitDownAnim, SlotAssign, slotteam, SortCords, StandUpAnim, StatsPanelOn
extern StatsPanelPlayer, StopObject, UpdateLinesForAbsent, ZoneTargetX, ZoneTargetY
global StartScoreCelebration, assscore, ChkPullGoalieLate, assbench, PutBoxPlayerOnBench, ReleaseBoxToBench, assleavebox, asspsclear
global AssignControlSlots, PenShotStart, asspenshot, asseben, assleaveice, asspenalty, assdopen, assepen
global ResetFaceoffAssigns
        db 090h
;-----------------------------------------------------------------------------
; StartScoreCelebration                           27210  97 PC, low confidence
; From assscore: resets the motion and starts the celebration animation
; (SetSPA +48h), clears the stick sounds
;-----------------------------------------------------------------------------
StartScoreCelebration:
        push ebx
        push ecx
        mov ecx, eax
        mov eax, dword [dword eax+0FAh]
        call ResetAnimTimer
        mov eax, dword [dword ecx+0FAh]
        or byte [byte eax+031h], 1
        mov bh, byte [dword ecx+0BFh]
        add edx, byte 48h
        and bh, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        xor ebx, ebx
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; assscore                                          27274  94G, low confidence
; Assignment 18h (set by Goal): goal celebration: stops the puck (41h to 40h), a random celebration time,
; the scorer (PassPending) gets one of 5 celebrations (StartScoreCelebration)
;-----------------------------------------------------------------------------
assscore:
        push ebx
        push ecx
        push edx
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        xor ecx, ecx
        mov cl, byte [dword eax+0A4h]
        mov eax, dword [PtrPuckZone]
        movsx edx, byte [eax]
        cmp ecx, edx
        jne short .1
        mov byte [eax], 0FFh
        mov eax, dword [PtrPuckFlags]
        call StopObject
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [dword eax+0AEh]
        sar edx, 18h
        add edx, eax
        cmp byte [dword edx+0B2h], 41h
        jne short .1
        mov word [byte esp+0Ch], 40h
        mov cl, byte [byte esp+0Ch]
        mov byte [dword edx+0B2h], cl
        or byte [dword eax+0BFh], 2
.1:
        test byte [dword ebx+0BFh], 2
        je near .5
        mov edx, 0FFFFFFFFh
        mov eax, ebx
        call SetPlayerTarget
        mov dh, byte [dword ebx+0BFh]
        test dh, 20h
        jne near .18
        mov cl, dh
        and cl, 0FDh
        mov eax, 46h
        mov byte [dword ebx+0BFh], cl
        call randomd0
        cwde
        add eax, byte 40h
        mov dword [byte ebx+060h], eax
        mov di, word [PassPending]
        test di, di
        jl short .4
        mov edx, dword [PassPlayer]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        cmp word [nosplit eax*8+PlayerAssignWords], byte 0
        je short .4
        xor eax, eax
        mov al, byte [dword ebx+0A4h]
        cmp ax, di
        jne short .2
        mov eax, 5
        call randomd0
        movsx edx, ax
        inc edx
        jmp short .3
.2:
        xor edx, edx
.3:
        mov eax, ebx
        call StartScoreCelebration
        jmp near .18
.4:
        mov eax, ebx
        xor edx, edx
        call StartScoreCelebration
        mov esp, ebp
        pop ebp
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov eax, dword [dword ebx+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+028h]
        and eax, 0FFFFh
        cmp eax, byte 48h
        jl short .6
        cmp eax, byte 4Dh
        jle near .18
.6:
        mov eax, ebx
        call check4bench
        test ax, ax
        jne near .18
        cmp word [PassPending], byte 0
        jl short .7
        mov edx, dword [PassPlayer]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edx, dword [nosplit eax*8+PlayerPointsTable]
        mov eax, dword [nosplit eax*8+PlayerScoreTable]
        mov dword [esp], edx
        jmp short .13
.7:
        mov eax, dword [PassPlayer]
        sar eax, 10h
        cmp eax, byte 0FFFFFFFEh
        jne short .8
        xor edx, edx
        mov dword [esp], edx
        mov dword [byte esp+010h], edx
        jmp short .14
.8:
        test byte [dword ebx+0BFh], 40h
        je short .9
        mov eax, dword [AwayTeamRecord+20h]
        jmp short .10
.9:
        mov eax, dword [HomeTeamRecord+20h]
.10:
        mov dword [byte esp+08h], eax
        mov eax, dword [byte esp+08h]
        mov dl, byte [dword ebx+0BFh]
        mov dword [esp], eax
        test dl, 40h
        je short .11
        mov eax, dword [AwayTeamRecord+28h]
        jmp short .12
.11:
        mov eax, dword [HomeTeamRecord+28h]
.12:
        mov dword [byte esp+04h], eax
        mov eax, dword [byte esp+04h]
.13:
        mov dword [byte esp+010h], eax
.14:
        fld dword [byte esp+010h]
        fabs
        fcomp qword [F64_3312]
        fnstsw ax
        sahf
        jbe short .16
        fldz
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        jae short .15
        mov dword [byte esp+010h], 454F0000h
        jmp short .16
.15:
        mov dword [byte esp+010h], 0C54F0000h
.16:
        fld dword [byte ebx+020h]
        fsub dword [esp]
        fabs
        fcomp qword [F64_720]
        fnstsw ax
        sahf
        jae short .17
        fld dword [byte ebx+028h]
        fsub dword [byte esp+010h]
        fabs
        fcomp qword [F64_240]
        fnstsw ax
        sahf
        jae short .17
        mov eax, dword [byte ebx+060h]
        sub eax, byte 2
        mov dword [byte ebx+060h], eax
        test eax, eax
        jg short .18
        mov eax, 46h
        call randomd0
        cwde
        add eax, byte 40h
        xor edx, edx
        mov dword [byte ebx+060h], eax
        mov eax, ebx
        call StartScoreCelebration
        mov esp, ebp
        pop ebp
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.17:
        mov eax, dword [dword ebx+0EEh]
        mov edx, dword [esp]
        mov dword [eax], edx
        mov eax, dword [dword ebx+0EEh]
        mov edx, dword [byte esp+010h]
        mov dword [byte eax+04h], edx
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42480000h
.18:
        mov esp, ebp
        pop ebp
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ChkPullGoalieLate                            27500  95 PC, medium confidence
; Player logic caller: 0 unless 3rd period (gsp 2) with at most 60 s left and the team is not
; human-controlled; then a team-struct check (likely the score: pull the goalie late, not fully traced)
;-----------------------------------------------------------------------------
ChkPullGoalieLate:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edx, eax
        mov bx, word [gsp]
        mov cx, word [FaceoffZone]
        cmp bx, byte 2
        jne short .3
        cmp word [gameclock], byte 3Ch
        jg short .3
        test ax, ax
        je short .1
        mov ax, word [AwayGoalieOff]
        jmp short .2
.1:
        mov ax, word [HomeGoalieOff]
.2:
        test ax, ax
        je short .4
.3:
        xor eax, eax
        jmp near .9
.4:
        movsx ebx, dx
        mov eax, ebx
        shl eax, 4
        add eax, ebx
        shl eax, 2
        sub eax, ebx
        mov esi, hmtmstruct
        shl eax, 2
        xor ebx, ebx
        add esi, eax
        test dx, dx
        sete al
        mov bl, al
        mov eax, ebx
        shl eax, 4
        add eax, ebx
        shl eax, 2
        sub eax, ebx
        shl eax, 2
        add eax, hmtmstruct
        mov di, word [esi]
        mov ax, word [eax]
        sub eax, edi
        test ax, ax
        jle short .5
        cmp ax, 2
        jle short .6
.5:
        xor eax, eax
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        mov eax, dword [dword esi+0104h]
        test byte [dword eax+0BFh], 80h
        jne short .7
        neg ecx
.7:
        test cx, cx
        jge short .8
        xor eax, eax
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        mov eax, 1
.9:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; assbench                                       275C0  94G, medium confidence
; assignment 17h, skating off to the bench (check4bench gives
; it); setplayer for the replacement
;-----------------------------------------------------------------------------
assbench:
        push ebx
        push ecx
        push edx
        sub esp, byte 20h
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .22
        test byte [dword ebx+0C1h], 10h
        jne near .16
        mov eax, ebx
        call check4bench
        test ax, ax
        jne near .22
        test byte [dword ebx+0C0h], 10h
        jne short .1
        test byte [PlayFlags], 1
        je short .2
.1:
        mov al, byte [dword ebx+0BFh]
        test al, 20h
        jne near .22
        test al, 8
        jne near .22
        mov edx, 8
        mov eax, ebx
        call doplayeracc
        jmp near .22
.2:
        test byte [gmode], 1
        je near .4
        cmp word [dword ebx+0A9h], byte 0
        jne near .4
        mov eax, dword [dword ebx+0FEh]
        mov eax, dword [byte eax+0Eh]
        sar eax, 10h
        and eax, 0FFF0h
        cmp eax, 0FF00h
        jne near .4
        test byte [dword ebx+0BFh], 40h
        setne al
        xor ah, ah
        cwde
        call ChkPullGoalieLate
        test ax, ax
        jne short .4
        mov byte [dword ebx+0A8h], 0FFh
        mov al, byte [dword ebx+0A8h]
        mov byte [dword ebx+0A7h], al
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 2
        mov byte [dword ebx+eax+0B2h], dl
        mov ch, byte [dword ebx+0BFh]
        mov edx, dword [dword ebx+0AEh]
        or ch, 2
        sar edx, 18h
        mov byte [dword ebx+0BFh], ch
        mov ecx, 6
        movsx dx, byte [dword edx+ebx+0B2h]
        mov eax, ebx
        cmp dx, cx
        je short .3
        mov dl, byte [dword ebx+0B1h]
        dec dl
        and dl, 7
        mov byte [dword ebx+0B1h], dl
.3:
        movsx edx, cx
        call assreplace
        add esp, byte 20h
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov ch, byte [dword ebx+0BFh]
        test ch, 2
        je near .9
        mov al, ch
        mov edx, 0C4ED3D71h
        and al, 0FDh
        mov dword [byte esp+01Ch], edx
        mov byte [dword ebx+0BFh], al
        test al, 40h
        jne short .5
        mov eax, 0FFFFFD48h
        jmp short .6
.5:
        mov eax, 2B8h
.6:
        mov word [regd1], ax
        mov eax, 5
        mov edx, 2
        call randomd0
        sub edx, eax
        imul eax, edx, dword 90h
        add word [regd1], ax
        mov eax, dword [dword ebx+0EEh]
        mov edx, dword [byte esp+01Ch]
        mov dword [eax], edx
        mov eax, dword [dword ebx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+08h], 0
        push byte 0
        mov eax, dword [dword ebx+0EEh]
        push byte 0FFFFFF9Ch
        mov dword [byte eax+0Ch], 0
        call AngleOfVector
        mov dword [byte esp+010h], eax
        add esp, byte 8
        mov eax, dword [dword ebx+0EEh]
        fild dword [byte esp+08h]
        fstp dword [byte eax+010h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, ebx
        call SetSkateSpeedFromRating
        test byte [gmode], 1
        je short .7
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42480000h
        jmp short .8
.7:
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42F00000h
.8:
        mov eax, dword [dword ebx+0EEh]
        and byte [byte eax+028h], 7Fh
.9:
        mov cl, byte [dword ebx+0A7h]
        cmp cl, byte [dword ebx+0A6h]
        jne short .11
        mov ah, byte [dword ebx+0C0h]
        and ah, 0FBh
        mov dl, byte [dword ebx+0A7h]
        mov byte [dword ebx+0C0h], ah
        cmp dl, 19h
        setl al
        mov edx, eax
        mov cl, byte [dword ebx+0A8h]
        and edx, 0FFh
        test cl, cl
        sete al
        and eax, 0FFh
        xor eax, edx
        je short .10
        movsx ax, cl
        mov word [dword ebx+0A9h], ax
.10:
        mov eax, ebx
        call Setplass
        mov byte [dword ebx+0A8h], 0FFh
        mov al, byte [dword ebx+0A8h]
        mov byte [dword ebx+0A7h], al
        add esp, byte 20h
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        fild word [byte ebx+06h]
        fstp dword [byte esp+04h]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+04h]
        fsub dword [eax]
        fldz
        fxch
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        jbe short .12
        fld dword [byte esp+010h]
        fchs
        fstp dword [byte esp+0Ch]
        jmp short .13
.12:
        mov eax, dword [byte esp+010h]
        mov dword [byte esp+0Ch], eax
.13:
        fld dword [byte esp+0Ch]
        fcomp dword [F32_144]
        fnstsw ax
        sahf
        ja near .22
        fild word [byte ebx+0Eh]
        fstp dword [esp]
        mov eax, dword [dword ebx+0EEh]
        fld dword [esp]
        fsub dword [byte eax+04h]
        fldz
        fxch
        fstp dword [byte esp+018h]
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        jbe short .14
        fld dword [byte esp+018h]
        fchs
        fstp dword [byte esp+014h]
        jmp short .15
.14:
        mov eax, dword [byte esp+018h]
        mov dword [byte esp+014h], eax
.15:
        fld dword [byte esp+014h]
        fcomp dword [F32_96]
        fnstsw ax
        sahf
        ja near .22
        mov al, byte [dword ebx+0C1h]
        mov dword [byte ebx+020h], 0C4ED3D71h
        or al, 10h
        mov ch, byte [dword ebx+0BFh]
        mov byte [dword ebx+0C1h], al
        or ch, 4
        mov eax, dword [dword ebx+0EEh]
        mov byte [dword ebx+0BFh], ch
        mov edx, dword [byte eax+04h]
        mov dword [byte ebx+028h], edx
        mov eax, ebx
        mov dword [byte ebx+01Ch], 4096CBE4h
        call SitDownAnim
        add esp, byte 20h
        pop edx
        pop ecx
        pop ebx
        ret
.16:
        mov edx, dword [dword ebx+0A3h]
        sar edx, 18h
        mov eax, dword [dword ebx+0FEh]
        add edx, edx
        add edx, eax
        mov cx, word [byte edx+050h]
        test cx, cx
        je short .17
        cmp cx, 8001h
        jne short .18
.17:
        mov edx, dword [dword ebx+0A3h]
        sar edx, 18h
        mov word [byte eax+edx*2+050h], 8002h
.18:
        cmp byte [dword ebx+0A7h], 19h
        setl al
        mov edx, eax
        mov cl, byte [dword ebx+0A8h]
        and edx, 0FFh
        test cl, cl
        sete al
        and eax, 0FFh
        xor eax, edx
        je short .19
        movsx ax, cl
        mov word [dword ebx+0A9h], ax
.19:
        mov eax, ebx
        call Setplass
        test byte [gmode], 1
        je short .21
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        mov ecx, 6
        movsx dx, byte [dword edx+ebx+0B2h]
        mov eax, ebx
        cmp dx, cx
        je short .20
        mov dl, byte [dword ebx+0B1h]
        dec dl
        and dl, 7
        mov byte [dword ebx+0B1h], dl
.20:
        movsx edx, cx
        call assreplace
.21:
        mov edx, dword [dword ebx+0A4h]
        mov eax, ebx
        sar edx, 18h
        call setplayer
        mov byte [dword ebx+0A8h], 0FFh
        mov al, byte [dword ebx+0A8h]
        mov byte [dword ebx+0A7h], al
        and byte [dword ebx+0C1h], 0E7h
.22:
        add esp, byte 20h
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PutBoxPlayerOnBench                             27A00  97 PC, low confidence
; From assleavebox: the first roster entry flagged 8 goes to the bench spot
; (position 8002h, MoveBoxToBenchSeat), heading set
;-----------------------------------------------------------------------------
PutBoxPlayerOnBench:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        mov ecx, dword [dword eax+0FEh]
        xor eax, eax
.1:
        movsx ebx, ax
        lea edx, [nosplit ebx*2+00h]
        add edx, ecx
        test byte [byte edx+051h], 8
        je short .2
        mov eax, dword [dword esi+0EEh]
        mov dword [byte esi+020h], 0C4ED3D71h
        mov ecx, dword [byte eax+04h]
        mov dword [byte esi+028h], ecx
        mov eax, esi
        mov dword [byte esi+01Ch], 4096CBE4h
        call SitDownAnim
        or byte [dword esi+0C1h], 8
        mov word [byte edx+050h], 8002h
        test byte [dword esi+0BFh], 40h
        setne al
        and eax, 0FFh
        mov edx, ebx
        call MoveBoxToBenchSeat
        mov dword [byte esi+060h], ebx
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        inc eax
        cmp ax, 19h
        jl short .1
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ReleaseBoxToBench                               27A78  97 PC, low confidence
; From puckfaceoff2: every player flagged in the box (flag 8) on both teams
; goes to the bench (position 8002h), box counts PenaltyBoxCount down
;-----------------------------------------------------------------------------
ReleaseBoxToBench:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, hmtmstruct
        xor edi, edi
.1:
        movsx ebx, di
        xor ecx, ecx
.2:
        movsx edx, cx
        lea esi, [nosplit edx*2+00h]
        add esi, ebp
        test byte [byte esi+051h], 8
        je short .3
        mov eax, ebx
        call MoveBoxToBenchSeat
        mov word [byte esi+050h], 8002h
        mov dl, byte [dword ebx+PenaltyBoxCount]
        test dl, dl
        jle short .3
        mov dh, dl
        dec dh
        mov byte [dword ebx+PenaltyBoxCount], dh
.3:
        inc ecx
        cmp cx, byte 19h
        jl short .2
        inc edi
        add ebp, 10Ch
        cmp di, byte 2
        jl short .1
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; assleavebox                                  27AD8  95 PC, medium confidence
;
; Assignment 15h (inserted by ReleaseBoxPlayers): check4bench, skates from the penalty box spot by the side
; boards (as asspsclear) and brings the released player back on (assreplace 15h, setplayer)
; assleavebox
;-----------------------------------------------------------------------------
assleavebox:
        push ebx
        push ecx
        push edx
        sub esp, byte 20h
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .10
        mov eax, ebx
        call check4bench
        test ax, ax
        jne near .10
        mov dl, byte [dword ebx+0BFh]
        test dl, 2
        je near .3
        mov dh, dl
        and dh, 0FDh
        mov byte [dword ebx+0BFh], dh
        mov edx, 0C4ED3D71h
        mov cl, byte [dword ebx+0BFh]
        mov dword [esp], edx
        test cl, 40h
        jne short .1
        mov eax, 0FFFFFD48h
        jmp short .2
.1:
        mov eax, 2B8h
.2:
        mov word [regd1], ax
        mov eax, 5
        mov edx, 2
        call randomd0
        sub edx, eax
        imul eax, edx, dword 90h
        add word [regd1], ax
        mov eax, dword [dword ebx+0EEh]
        mov edx, dword [esp]
        mov dword [eax], edx
        mov eax, dword [dword ebx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword ebx+0EEh]
        mov ch, byte [byte eax+028h]
        push byte 0
        and ch, 7Fh
        push byte 0FFFFFF9Ch
        mov byte [byte eax+028h], ch
        call AngleOfVector
        mov dword [byte esp+0Ch], eax
        add esp, byte 8
        mov eax, dword [dword ebx+0EEh]
        fild dword [byte esp+04h]
        fstp dword [byte eax+010h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, ebx
        call SetSkateSpeedFromRating
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42480000h
        and byte [dword ebx+0C1h], 0E7h
.3:
        mov ah, byte [dword ebx+0C1h]
        test ah, 8
        je short .5
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        mov ecx, 15h
        movsx dx, byte [dword edx+ebx+0B2h]
        mov eax, ebx
        cmp dx, cx
        je short .4
        mov dl, byte [dword ebx+0B1h]
        dec dl
        and dl, 7
        mov byte [dword ebx+0B1h], dl
.4:
        movsx edx, cx
        call assreplace
        mov edx, dword [byte ebx+05Eh]
        mov eax, ebx
        sar edx, 10h
        call setplayer
        mov ch, byte [dword ebx+0C1h]
        mov dword [byte ebx+060h], 0
        and ch, 0E7h
        mov byte [dword ebx+0C1h], ch
        jmp near .10
.5:
        test ah, 10h
        jne near .10
        fild word [byte ebx+06h]
        fstp dword [byte esp+010h]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+010h]
        fsub dword [eax]
        fldz
        fxch
        fstp dword [byte esp+08h]
        fcomp dword [byte esp+08h]
        fnstsw ax
        sahf
        jbe short .6
        fld dword [byte esp+08h]
        fchs
        fstp dword [byte esp+018h]
        jmp short .7
.6:
        mov eax, dword [byte esp+08h]
        mov dword [byte esp+018h], eax
.7:
        fld dword [byte esp+018h]
        fcomp dword [F32_144_assleavebox]
        fnstsw ax
        sahf
        ja short .10
        fild word [byte ebx+0Eh]
        fstp dword [byte esp+014h]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+014h]
        fsub dword [byte eax+04h]
        fldz
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jbe short .8
        fld dword [byte esp+0Ch]
        fchs
        fstp dword [byte esp+01Ch]
        jmp short .9
.8:
        mov eax, dword [byte esp+0Ch]
        mov dword [byte esp+01Ch], eax
.9:
        fld dword [byte esp+01Ch]
        fcomp dword [F32_48_assleavebox]
        fnstsw ax
        sahf
        ja short .10
        mov dh, byte [dword ebx+0C0h]
        mov cl, byte [dword ebx+0C1h]
        or dh, 20h
        or cl, 10h
        mov byte [dword ebx+0C0h], dh
        mov eax, ebx
        mov byte [dword ebx+0C1h], cl
        call PutBoxPlayerOnBench
.10:
        add esp, byte 20h
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; asspsclear                                   27D10  95 PC, medium confidence
; Assignment 19h (from setpersonel): skaters clear to a spot by the side boards (x -1898, y +-2B8h plus a
; random multiple of 90h) and stop facing the play; the spot scaled to 97 units
;-----------------------------------------------------------------------------
asspsclear:
        push ebx
        push ecx
        push edx
        sub esp, byte 20h
        mov ebx, eax
        mov ah, byte [dword eax+0A4h]
        xor edx, edx
        cmp ah, 6
        setb al
        mov cx, word [FaceoffRequest]
        mov dl, al
        cmp cx, byte 6
        setl al
        and eax, 0FFh
        xor eax, edx
        je short .1
        cmp byte [dword ebx+0A8h], 0
        jne short .1
        mov eax, ebx
        call check4bench
        test ax, ax
        jne near .10
.1:
        mov dh, byte [dword ebx+0BFh]
        test dh, 20h
        jne near .10
        test dh, 2
        je near .4
        mov ch, dh
        mov edx, 0C4ED3D71h
        and ch, 0FDh
        mov dword [byte esp+014h], edx
        mov byte [dword ebx+0BFh], ch
        test ch, 40h
        jne short .2
        mov eax, 0FFFFFD48h
        jmp short .3
.2:
        mov eax, 2B8h
.3:
        mov word [regd1], ax
        mov eax, 5
        mov edx, 2
        call randomd0
        sub edx, eax
        imul eax, edx, dword 90h
        add word [regd1], ax
        mov eax, dword [dword ebx+0EEh]
        mov edx, dword [byte esp+014h]
        mov dword [eax], edx
        mov eax, dword [dword ebx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+08h], 0
        push byte 0
        mov eax, dword [dword ebx+0EEh]
        push byte 0FFFFFF9Ch
        mov dword [byte eax+0Ch], 0
        call AngleOfVector
        mov dword [byte esp+010h], eax
        add esp, byte 8
        mov eax, dword [dword ebx+0EEh]
        fild dword [byte esp+08h]
        fstp dword [byte eax+010h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, ebx
        call SetSkateSpeedFromRating
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42960000h
        mov eax, dword [dword ebx+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [dword ebx+0EEh]
        and byte [byte eax+029h], 0FEh
        mov edx, 0FFFFFFFFh
        mov eax, ebx
        call SetPlayerTarget
        mov cl, byte [dword ebx+0C1h]
        mov byte [dword ebx+0A7h], 0FFh
        and cl, 0EFh
        mov al, byte [dword ebx+0A7h]
        mov byte [dword ebx+0C1h], cl
        mov byte [dword ebx+0A8h], al
.4:
        test byte [dword ebx+0C1h], 10h
        jne near .9
        cmp word [penshotmode], byte 0
        je near .10
        fild word [byte ebx+06h]
        fstp dword [byte esp+04h]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+04h]
        fsub dword [eax]
        fldz
        fxch
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        jbe short .5
        fld dword [byte esp+010h]
        fchs
        fstp dword [byte esp+01Ch]
        jmp short .6
.5:
        mov eax, dword [byte esp+010h]
        mov dword [byte esp+01Ch], eax
.6:
        fld dword [byte esp+01Ch]
        fcomp dword [F32_144_asspsclear]
        fnstsw ax
        sahf
        ja near .10
        fild word [byte ebx+0Eh]
        fstp dword [esp]
        mov eax, dword [dword ebx+0EEh]
        fld dword [esp]
        fsub dword [byte eax+04h]
        fldz
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jbe short .7
        fld dword [byte esp+0Ch]
        fchs
        fstp dword [byte esp+018h]
        jmp short .8
.7:
        mov eax, dword [byte esp+0Ch]
        mov dword [byte esp+018h], eax
.8:
        fld dword [byte esp+018h]
        fcomp dword [F32_96_asspsclear]
        fnstsw ax
        sahf
        ja short .10
        mov ah, byte [dword ebx+0BFh]
        mov dword [byte ebx+020h], 0C4ED3D71h
        or ah, 4
        mov dl, byte [dword ebx+0C1h]
        mov byte [dword ebx+0BFh], ah
        or dl, 10h
        mov eax, dword [dword ebx+0EEh]
        mov byte [dword ebx+0C1h], dl
        mov edx, dword [byte eax+04h]
        mov dword [byte ebx+028h], edx
        mov eax, ebx
        mov dword [byte ebx+01Ch], 4096CBE4h
        call SitDownAnim
        jmp short .10
.9:
        mov dword [byte ebx+060h], 0FFFFFF9Ch
        mov al, byte [dword ebx+0C0h]
        mov word [dword ebx+0A9h], 0FFFFh
        or al, 4
        mov byte [dword ebx+0C0h], al
.10:
        add esp, byte 20h
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AssignControlSlots                              27F80  97 PC, low confidence
; From puckfaceoff: for each of the 8 control slots, the team's first free
; skater becomes the controlled player (restorepl via SetSlotPlayer)
;-----------------------------------------------------------------------------
AssignControlSlots:
        push ebx
        push edx
        push esi
        push edi
        xor esi, esi
        xor ebx, ebx
        xor edi, edi
.1:
        mov dx, word [dword esi+slotteam]
        cmp di, dx
        je short .6
        cmp di, word [dword esi+SlotAssign]
        jle short .6
        cmp dx, byte 1
        jne short .2
        mov eax, SortCords
        jmp short .3
.2:
        mov eax, HomeTeamRecord+420h
.3:
        mov edx, edi
.4:
        cmp di, word [dword eax+0A9h]
        jg short .5
        test byte [dword eax+0BFh], 8
        jne short .5
        xor edx, edx
        mov dl, byte [dword eax+0A4h]
        mov eax, ebx
        call SetSlotPlayer
        jmp short .6
.5:
        inc edx
        add eax, 108h
        cmp edx, byte 6
        jl short .4
.6:
        inc ebx
        add esi, byte 2
        cmp ebx, byte 8
        jl short .1
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PenShotStart                                 27FF0  95 PC, medium confidence
; From puckfaceoff2: penalty shot start: shooter faces the goal, assignment
; 1Bh, puck to him, penshottimer 3E8h, penshotlive on
;-----------------------------------------------------------------------------
PenShotStart:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 8
        and esp, byte 0FFFFFFF8h
        mov eax, dword [penshottimer]
        sar eax, 10h
        mov ebx, eax
        shl ebx, 5
        add ebx, eax
        shl ebx, 3
        add ebx, SortCords
        mov eax, dword [dword ebx+0EEh]
        fld dword [eax]
        mov eax, dword [dword ebx+0EEh]
        fstp dword [byte ebx+020h]
        fld dword [byte eax+04h]
        mov ah, byte [dword ebx+0BFh]
        fstp dword [byte ebx+028h]
        test ah, 80h
        je short .1
        xor esi, esi
        mov dword [esp], esi
        mov dword [byte esp+04h], esi
        jmp short .2
.1:
        mov edx, 5A7ED197h
        mov ecx, 400921FBh
        mov dword [esp], edx
        mov dword [byte esp+04h], ecx
.2:
        and byte [dword ebx+0C0h], 0DBh
        mov dh, byte [dword ebx+0BFh]
        mov dword [byte ebx+038h], 0
        and dh, 0FBh
        fld qword [esp]
        mov byte [dword ebx+0BFh], dh
        mov ecx, 1Bh
        mov edx, dword [dword ebx+0AEh]
        mov dword [byte ebx+064h], 0
        sar edx, 18h
        fstp dword [byte ebx+01Ch]
        movsx dx, byte [dword edx+ebx+0B2h]
        mov eax, ebx
        cmp dx, cx
        je short .3
        mov dl, byte [dword ebx+0B1h]
        dec dl
        and dl, 7
        mov byte [dword ebx+0B1h], dl
.3:
        movsx edx, cx
        call assreplace
        mov ebx, dword [dword ebx+0FEh]
        mov word [byte ebx+0Ch], 0FFFFh
        mov ax, word [byte ebx+0Ch]
        mov word [byte ebx+0Ah], ax
        mov word [byte ebx+08h], ax
        mov eax, 9
        call SetCrowdMood
        mov edx, dword [PtrPuckZone]
        mov al, byte [FaceoffRequest]
        mov ecx, 3E8h
        mov byte [edx], al
        mov edx, 1
        mov word [penshottimer], cx
        mov word [penshotlive], dx
        mov word [BenchRequest], dx
        call ClearPlayerFlags
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; asspenshot                                   28110  97 PC, medium confidence
; Asstab 1Bh (given by PenShotStart): the penalty shot shooter skates in on
; goal (y +-0F30h) and shoots
;-----------------------------------------------------------------------------
asspenshot:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 8
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        xor edx, edx
        mov dl, byte [dword eax+0A4h]
        mov eax, dword [PtrPuckZone]
        movsx eax, byte [eax]
        cmp edx, eax
        jne short .1
        mov ah, byte [dword ebx+0BFh]
        test ah, 8
        je short .2
.1:
        mov al, byte [dword ebx+0B1h]
        inc al
        and al, 7
        mov byte [dword ebx+0B1h], al
        or byte [dword ebx+0BFh], 2
        jmp near .10
.2:
        test ah, 20h
        jne near .10
        test byte [gmode], 1
        je short .3
        mov ch, byte [dword ebx+0BFh]
        mov dword [byte ebx+064h], 40h
        test ch, 20h
        jne near .10
        test ch, 8
        jne near .10
        mov edx, 8
        mov eax, ebx
        call doplayeracc
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov edx, dword [byte ebx+0Ch]
        sar edx, 10h
        test ah, 80h
        jne short .4
        neg edx
.4:
        mov ch, byte [dword ebx+0BFh]
        test ch, 2
        je near .9
        mov al, ch
        and al, 0FDh
        xor ecx, ecx
        mov byte [dword ebx+0BFh], al
        mov word [ZoneTargetY], cx
        test byte [dword ebx+0BFh], 80h
        je short .5
        mov eax, 0F30h
        jmp short .6
.5:
        mov eax, 0FFFFF0D0h
.6:
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
        mov dword [byte eax+024h], 43160000h
        mov eax, 2
        call randomd0
        test ax, ax
        jne short .7
        mov edi, 5A7ED197h
        mov eax, 3FF921FBh
        mov dword [esp], edi
        mov dword [byte esp+04h], eax
        jmp short .8
.7:
        mov ecx, 83DF1D31h
        mov esi, 4012D97Ch
        mov dword [esp], ecx
        mov dword [byte esp+04h], esi
.8:
        mov eax, dword [dword ebx+0EEh]
        fld qword [esp]
        fstp dword [byte eax+08h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, ebx
        call SetSkateSpeedFromRating
.9:
        cmp edx, 0B10h
        jle short .10
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42C80000h
        mov eax, 0Ah
        call randomd0
        cmp edx, 0CF0h
        jge short .10
        mov eax, ebx
        call ChkShoot
.10:
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
; asseben                                        282B8  94G, medium confidence
; assignment 16h, coming on from the bench (setplayer gives it
; for a player from the bench)
;-----------------------------------------------------------------------------
asseben:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 4
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .8
        mov dl, byte [dword ebx+0BFh]
        test dl, 2
        je short .2
        mov dword [byte ebx+038h], 0
        xor eax, eax
        and dl, 0FDh
        mov al, byte [dword ebx+0A4h]
        mov byte [dword ebx+0BFh], dl
        sub eax, byte 6
        mov word [ZoneTargetY], ax
        test ax, ax
        jl short .1
        mov esi, eax
        inc esi
        mov word [ZoneTargetY], si
.1:
        mov edx, dword [ZoneTargetX]
        sar edx, 10h
        lea eax, [nosplit edx*8+00h]
        add eax, edx
        mov dword [byte ebx+01Ch], 3FC90FDBh
        shl eax, 4
        mov dh, byte [dword ebx+0BFh]
        mov dword [esp], eax
        and dh, 0EFh
        fild dword [esp]
        mov eax, ebx
        fstp dword [byte ebx+028h]
        mov byte [dword ebx+0BFh], dh
        call StandUpAnim
        jmp near .8
.2:
        mov dh, dl
        mov cl, byte [dword ebx+0C0h]
        mov al, byte [dword ebx+0B1h]
        and cl, 0DBh
        and dh, 0F9h
        mov byte [dword ebx+0C0h], cl
        inc al
        mov byte [dword ebx+0BFh], dh
        and al, 7
        mov ch, byte [dword ebx+0BFh]
        mov byte [dword ebx+0B1h], al
        or ch, 2
        mov dx, word [dword ebx+0A9h]
        mov byte [dword ebx+0BFh], ch
        cmp dx, byte 6
        jne short .3
        push dword 0A0000025h
        call CommentaryEvent
        add esp, byte 4
.3:
        test byte [dword ebx+0BFh], 40h
        setne al
        mov cx, word [dword ebx+0A9h]
        and eax, 0FFh
        test cx, cx
        jle near .8
        mov edx, dword [dword ebx+0FEh]
        mov si, word [byte edx+010h]
        test si, si
        jge short .8
        setge dl
        mov ecx, dword [dword ebx+0FEh]
        mov ecx, dword [byte ecx+0Ch]
        and edx, 0FFh
        sar ecx, 10h
        sub ecx, edx
        test eax, eax
        je short .4
        mov dx, word [AwayGoalieOff]
        jmp short .5
.4:
        mov dx, word [HomeGoalieOff]
.5:
        movsx edx, dx
        cmp ecx, edx
        jne short .8
        test eax, eax
        je short .6
        mov ax, word [AwayEbenPlayer]
        jmp short .7
.6:
        mov ax, word [HomeEbenPlayer]
.7:
        cwde
        cmp word [nosplit eax*2+SlotAssign], byte 0
        jge short .8
        movsx edx, ax
        mov eax, ebx
        call changeplayer
.8:
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; assleaveice                                  2842C  95 PC, medium confidence
; Assignment 1Ah (set by InProgress): skates to the bench gate
; by the side boards, changeplayer, then assignment 1 (assbenchwait)
;-----------------------------------------------------------------------------
assleaveice:
        push ebx
        push ecx
        push edx
        sub esp, byte 20h
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .11
        mov dl, byte [dword ebx+0BFh]
        test dl, 2
        je near .3
        mov ch, dl
        mov al, byte [dword ebx+0C1h]
        mov edx, 0C4ED3D71h
        and al, 0EFh
        and ch, 0FDh
        mov byte [dword ebx+0C1h], al
        mov dword [byte esp+014h], edx
        mov ah, byte [dword ebx+0C0h]
        mov byte [dword ebx+0BFh], ch
        or ah, 4
        mov dl, byte [dword ebx+0BFh]
        mov byte [dword ebx+0C0h], ah
        test dl, 40h
        jne short .1
        mov eax, 0FFFFFD48h
        jmp short .2
.1:
        mov eax, 2B8h
.2:
        mov word [regd1], ax
        mov eax, 5
        mov edx, 2
        call randomd0
        sub edx, eax
        imul eax, edx, dword 90h
        add word [regd1], ax
        mov eax, dword [dword ebx+0EEh]
        mov edx, dword [byte esp+014h]
        mov dword [eax], edx
        mov eax, dword [dword ebx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+08h], 0
        push byte 0
        mov eax, dword [dword ebx+0EEh]
        push byte 0FFFFFF9Ch
        mov dword [byte eax+0Ch], 0
        call AngleOfVector
        mov dword [byte esp+08h], eax
        add esp, byte 8
        mov eax, dword [dword ebx+0EEh]
        fild dword [esp]
        fstp dword [byte eax+010h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, ebx
        call SetSkateSpeedFromRating
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42480000h
        mov edx, dword [dword ebx+0EEh]
        and byte [byte edx+028h], 7Fh
        add esp, byte 20h
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        test byte [dword ebx+0C1h], 10h
        jne near .9
        test dl, 8
        je short .4
        mov edx, dword [dword ebx+0B8h]
        mov eax, ebx
        sar edx, 10h
        call changeplayer
.4:
        fild word [byte ebx+06h]
        fstp dword [byte esp+01Ch]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+01Ch]
        fsub dword [eax]
        fldz
        fxch
        fstp dword [byte esp+08h]
        fcomp dword [byte esp+08h]
        fnstsw ax
        sahf
        jbe short .5
        fld dword [byte esp+08h]
        fchs
        fstp dword [byte esp+010h]
        jmp short .6
.5:
        mov eax, dword [byte esp+08h]
        mov dword [byte esp+010h], eax
.6:
        fld dword [byte esp+010h]
        fcomp dword [F32_96_assleaveice]
        fnstsw ax
        sahf
        ja near .11
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
        jbe short .7
        fld dword [byte esp+04h]
        fchs
        fstp dword [byte esp+018h]
        jmp short .8
.7:
        mov eax, dword [byte esp+04h]
        mov dword [byte esp+018h], eax
.8:
        fld dword [byte esp+018h]
        fcomp dword [F32_96_assleaveice]
        fnstsw ax
        sahf
        ja near .11
        mov dh, byte [dword ebx+0BFh]
        mov dword [byte ebx+020h], 0C4ED3D71h
        or dh, 4
        mov cl, byte [dword ebx+0C1h]
        mov byte [dword ebx+0BFh], dh
        or cl, 10h
        mov eax, dword [dword ebx+0EEh]
        mov byte [dword ebx+0C1h], cl
        mov edx, dword [byte eax+04h]
        mov dword [byte ebx+028h], edx
        mov eax, ebx
        mov dword [byte ebx+01Ch], 4096CBE4h
        call SitDownAnim
        add esp, byte 20h
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        cmp word [gsp], byte 4
        jge short .10
        test byte [gmode], 40h
        jne short .10
        mov edx, dword [dword ebx+0A3h]
        mov ch, byte [dword ebx+0BFh]
        sar edx, 18h
        test ch, 40h
        setne al
        xor ah, ah
        cwde
        call UpdateLinesForAbsent
.10:
        and byte [dword ebx+0C0h], 0EFh
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 1
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword ebx+0BFh], 2
.11:
        add esp, byte 20h
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; asspenalty                                     28698  94G, medium confidence
; assignment 12h, the penalised player skates to the penalty
; box (InProgress gives it)
;-----------------------------------------------------------------------------
asspenalty:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 28h
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .12
        mov dl, byte [dword ebx+0BFh]
        test dl, 2
        je near .6
        mov cl, byte [dword ebx+0C0h]
        mov dh, dl
        or cl, 24h
        and dh, 0F9h
        mov byte [dword ebx+0C0h], cl
        mov byte [dword ebx+0BFh], dh
        mov ch, byte [dword ebx+0BFh]
        or ch, 4
        mov byte [dword ebx+0BFh], ch
        test ch, 8
        je short .1
        mov edx, 0FFFFFFFFh
        mov eax, ebx
        call SetPlayerTarget
.1:
        mov eax, dword [PenaltyAnimPos]
        mov dword [byte esp+010h], eax
        mov eax, dword [PenaltyAnimTime]
        mov dword [byte esp+0Ch], eax
        mov ah, byte [dword ebx+0BFh]
        xor edx, edx
        test ah, 40h
        setne al
        and eax, 0FFh
        call GetSeatPos
        mov edx, eax
        mov ecx, eax
        mov eax, ebx
        call PickBoxSeat
        fld dword [byte esp+0Ch]
        call __CHP
        mov eax, dword [edx]
        fistp dword [esp]
        sub eax, dword [esp]
        add eax, byte 20h
        mov word [ZoneTargetY], ax
        cmp byte [dword ebx+0D0h], 0
        je short .2
        fld dword [byte esp+010h]
        fchs
        fstp dword [byte esp+014h]
        jmp short .3
.2:
        mov eax, dword [byte esp+010h]
        mov dword [byte esp+014h], eax
.3:
        fld dword [byte esp+014h]
        call __CHP
        mov edx, dword [byte ecx+08h]
        fistp dword [esp]
        mov esi, dword [esp]
        mov edi, dword [byte ecx+08h]
        sub edx, esi
        test edi, edi
        jge short .4
        mov eax, 30h
        jmp short .5
.4:
        mov eax, 0FFFFFFD0h
.5:
        add eax, edx
        mov word [regd1], ax
        mov eax, dword [dword ebx+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword ebx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword ebx+0EEh]
        mov dh, byte [byte eax+028h]
        push byte 0
        and dh, 7Fh
        push byte 64h
        mov byte [byte eax+028h], dh
        call AngleOfVector
        mov dword [byte esp+08h], eax
        add esp, byte 8
        mov eax, dword [dword ebx+0EEh]
        fild dword [esp]
        fstp dword [byte eax+010h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, ebx
        call SetSkateSpeedFromRating
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42480000h
        mov cl, byte [dword ebx+0BFh]
        xor edx, edx
        test cl, 40h
        setne dl
        xor eax, eax
        mov al, byte [dword ebx+0A4h]
        call PenaltyCameraScene
        mov edx, 1
        mov eax, dword [dword ebx+0F2h]
        call SetFaceExpression
        mov edx, 1
        mov eax, dword [dword ebx+0F2h]
        call SetFaceMouth
        mov eax, dword [dword ebx+0F2h]
        xor edx, edx
        call SetFaceBlink
.6:
        fild word [byte ebx+06h]
        fstp dword [byte esp+08h]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+08h]
        fsub dword [eax]
        fldz
        fxch
        fstp dword [byte esp+020h]
        fcomp dword [byte esp+020h]
        fnstsw ax
        sahf
        jbe short .7
        fld dword [byte esp+020h]
        fchs
        fstp dword [byte esp+018h]
        jmp short .8
.7:
        mov eax, dword [byte esp+020h]
        mov dword [byte esp+018h], eax
.8:
        fld dword [byte esp+018h]
        fcomp dword [F32_144_asspenalty]
        fnstsw ax
        sahf
        ja near .12
        fild word [byte ebx+0Eh]
        fstp dword [byte esp+04h]
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+04h]
        fsub dword [byte eax+04h]
        fldz
        fxch
        fstp dword [byte esp+024h]
        fcomp dword [byte esp+024h]
        fnstsw ax
        sahf
        jbe short .9
        fld dword [byte esp+024h]
        fchs
        fstp dword [byte esp+01Ch]
        jmp short .10
.9:
        mov eax, dword [byte esp+024h]
        mov dword [byte esp+01Ch], eax
.10:
        fld dword [byte esp+01Ch]
        fcomp dword [F32_96_asspenalty]
        fnstsw ax
        sahf
        ja near .12
        mov ch, byte [dword ebx+0BFh]
        mov edx, 0FFFFFFFFh
        or ch, 4
        mov eax, ebx
        mov byte [dword ebx+0BFh], ch
        call SetPlayerTarget
        and byte [dword ebx+0C0h], 0EFh
        mov eax, dword [dword ebx+0FEh]
        mov dx, word [byte eax+0Eh]
        cmp dx, byte 4
        jle short .11
        mov ecx, edx
        dec ecx
        mov word [byte eax+0Eh], cx
.11:
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        mov eax, 13h
        mov byte [dword edx+ebx+0B2h], al
        mov ah, byte [dword ebx+0BFh]
        or ah, 2
        mov edx, 1
        mov byte [dword ebx+0BFh], ah
        test ah, 40h
        setne al
        and eax, 0FFh
        call SetPenaltyBoxDoor
        push dword [byte ebx+028h]
        mov edx, 64h
        mov eax, 462h
        push dword [byte ebx+020h]
        call PlaySfxVolume
        mov eax, dword [dword ebx+0EEh]
        fld dword [eax]
        mov eax, dword [dword ebx+0EEh]
        fstp dword [byte ebx+020h]
        mov edx, dword [byte eax+04h]
        mov dword [byte ebx+028h], edx
        mov eax, ebx
        mov dword [byte ebx+01Ch], 3FC90FDBh
        call GoToBoxAnim
.12:
        add esp, byte 28h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; assdopen                              289AC  94G logic94.asm, low confidence
; asstab 0Dh (player goes to the penalty box). Bumps PBnum (home) or PBnum+1 (away).
;-----------------------------------------------------------------------------
assdopen:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne short .1
        mov cl, byte [dword ebx+0BFh]
        xor edx, edx
        test cl, 40h
        setne al
        and eax, 0FFh
        call SetPenaltyBoxDoor
        push dword [byte ebx+028h]
        mov edx, 64h
        mov eax, 463h
        push dword [byte ebx+020h]
        call PlaySfxVolume
        mov ch, byte [dword ebx+0BFh]
        xor edx, edx
        test ch, 40h
        setne dl
        inc byte [dword edx+PenaltyBoxCount]
        mov word [dword ebx+0A9h], 0FFFFh
.1:
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; assepen                                        28A08  94G, medium confidence
; assignment 14h, leaving the penalty box (setplayer gives it
; for a player from the box)
;-----------------------------------------------------------------------------
assepen:
        push ebx
        push ecx
        push edx
        sub esp, byte 4
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .10
        mov dl, byte [dword ebx+0BFh]
        test dl, 2
        je near .3
        mov ah, dl
        or ah, 4
        mov dl, ah
        mov byte [dword ebx+0BFh], ah
        and dl, 0EDh
        mov byte [dword ebx+0BFh], dl
        mov dh, byte [dword ebx+0C0h]
        or dh, 24h
        mov cl, byte [dword ebx+0BFh]
        mov byte [dword ebx+0C0h], dh
        xor edx, edx
        test cl, 40h
        setne al
        and eax, 0FFh
        call GetSeatPos
        fild dword [eax]
        fadd dword [F32_40]
        fstp dword [byte ebx+020h]
        mov ecx, dword [byte eax+08h]
        mov edx, eax
        test ecx, ecx
        jge short .1
        mov dword [esp], 30h
        jmp short .2
.1:
        mov dword [esp], 0FFFFFFD0h
.2:
        fild dword [esp]
        fild dword [byte edx+08h]
        faddp
        mov eax, ebx
        fstp dword [byte ebx+028h]
        call FreeBoxSeat
        test byte [dword ebx+0BFh], 40h
        setne al
        and eax, 0FFh
        dec byte [dword eax+PenaltyBoxCount]
        mov ch, byte [dword ebx+0BFh]
        mov edx, 1
        test ch, 40h
        setne al
        and eax, 0FFh
        call SetPenaltyBoxDoor
        push dword [byte ebx+028h]
        mov edx, 64h
        mov eax, 462h
        push dword [byte ebx+020h]
        call PlaySfxVolume
        mov dword [byte ebx+038h], 0
        mov eax, ebx
        mov dword [byte ebx+01Ch], 4096CBE4h
        call LeaveBoxAnim
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov edx, 0FFFFFFFFh
        mov byte [dword ebx+0A7h], 0FFh
        mov eax, ebx
        mov byte [dword ebx+0A8h], 0FFh
        call SetPlayerTarget
        mov dh, byte [dword ebx+0BFh]
        mov cl, byte [dword ebx+0C0h]
        mov al, byte [dword ebx+0B1h]
        and dh, 0F9h
        and cl, 0DBh
        mov byte [dword ebx+0BFh], dh
        inc al
        mov byte [dword ebx+0C0h], cl
        and al, 7
        mov ch, byte [dword ebx+0BFh]
        mov byte [dword ebx+0B1h], al
        or ch, 2
        xor edx, edx
        mov byte [dword ebx+0BFh], ch
        test ch, 40h
        setne al
        and eax, 0FFh
        call SetPenaltyBoxDoor
        push dword [byte ebx+028h]
        mov edx, 64h
        mov eax, 463h
        push dword [byte ebx+020h]
        call PlaySfxVolume
        mov eax, dword [dword ebx+0FEh]
        cmp word [byte eax+010h], byte 0
        setge al
        xor edx, edx
        mov dl, al
        mov eax, dword [dword ebx+0FEh]
        mov eax, dword [byte eax+0Ch]
        sar eax, 10h
        sub eax, edx
        mov cl, byte [dword ebx+0BFh]
        mov edx, eax
        test cl, 40h
        je short .4
        mov ax, word [AwayGoalieOff]
        jmp short .5
.4:
        mov ax, word [HomeGoalieOff]
.5:
        cwde
        cmp edx, eax
        jne short .10
        test byte [dword ebx+0BFh], 40h
        je short .6
        mov ax, word [AwayEbenPlayer]
        jmp short .7
.6:
        mov ax, word [HomeEbenPlayer]
.7:
        cwde
        cmp word [nosplit eax*2+SlotAssign], byte 0
        jge short .10
        test byte [dword ebx+0BFh], 40h
        je short .8
        mov ax, word [AwayEbenPlayer]
        jmp short .9
.8:
        mov ax, word [HomeEbenPlayer]
.9:
        movsx edx, ax
        mov eax, ebx
        call changeplayer
.10:
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ResetFaceoffAssigns                             28C0C  97 PC, low confidence
; From puckfaceoff: each idle skater of a team goes back to assignment 6; in
; a penalty shot the shooter keeps assignment 19h
;-----------------------------------------------------------------------------
ResetFaceoffAssigns:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 4
        cmp word [penshotmode], byte 0
        jne near .5
        movsx edx, ax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 4
        mov edx, eax
        shl eax, 5
        mov ebx, SortCords
        add eax, edx
        xor ecx, ecx
        add ebx, eax
.1:
        cmp word [BenchRequest], byte 0
        je short .2
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        cmp byte [dword ebx+eax+0B2h], 19h
        jne short .2
        mov word [esp], 1
        mov eax, dword [dword ebx+0AEh]
        mov dword [byte ebx+060h], 0
        sar eax, 18h
        mov dl, byte [esp]
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword ebx+0BFh], 2
        jmp near .4
.2:
        cmp word [dword ebx+0A9h], byte 0
        jl short .4
        mov eax, dword [dword ebx+0A5h]
        sar eax, 18h
        cmp eax, byte 0FFFFFFFFh
        jne short .4
        mov eax, dword [dword ebx+0A4h]
        sar eax, 18h
        cmp eax, byte 0FFFFFFFFh
        jne short .4
        cmp dword [byte ebx+060h], byte 0FFFFFF9Ch
        jne short .4
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        add eax, ebx
        cmp byte [dword eax+0B2h], 6
        je short .4
        mov edx, 6
        movsx ax, byte [dword eax+0B2h]
        mov esi, ebx
        cmp ax, dx
        je short .3
        mov al, byte [dword ebx+0B1h]
        dec al
        and al, 7
        mov byte [dword ebx+0B1h], al
.3:
        movsx edx, dx
        mov eax, esi
        call assreplace
.4:
        inc ecx
        add ebx, 108h
        cmp ecx, byte 6
        jl near .1
.5:
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
        push ebx
        push edx
        mov edx, dword [GameOptionFlags]
        test byte [byte edx+02h], 20h
        jne short .6
        cmp word [gsp], byte 0
        jne short .6
        mov bx, word [StatsPanelPlayer]
        cmp bx, word [gameclock]
        jne short .6
        cmp word [StatsPanelOn], byte 0
        jne short .6
        movsx edx, ax
        mov eax, edx
        shl eax, 4
        add eax, edx
        shl eax, 2
        sub eax, edx
        shl eax, 2
        add eax, hmtmstruct
        call forcepldata
.6:
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
        push edx
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 7
        jne short .7
        mov eax, dword [PtrPuckObject]
        mov edx, 1
        mov eax, dword [dword eax+0F2h]
        call SetFaceBlink
.7:
        pop edx
        ret
