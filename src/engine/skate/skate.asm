; Skating moves: idle, stride, glide, turns, stops, crossovers and skate speed.
bits 32
%include "hockey.inc"
section s_60D6B progbits alloc exec nowrite align=1
extern __CHP, F32_0p1, F32_0p1_SetSkateSpeedFromRating, F32_0p1_SkateBackwardMove, F32_0p1_SkateForwardMove, F32_0p5_PickStrideAnim, F32_12_LimitSkateSpeed, F32_12_SkateBackwardMove
extern F32_12_SkateForwardMove, F32_12_SteerTowardTarget, F32_2_SteerTowardTarget, F32_2_TurnStickPos, F32_2p5, F32_3p95_LimitSkateSpeed, F32_48_SetSkateSpeedFromRating, F32_4_SetSkateSpeedFromRating
extern F32_4_StopSkidDistance, F32_neg0p125664, F32_neg0p125664_StandMove, F32_neg0p5, F64_0p0001_PickBackwardTurn, F64_0p0001_PickForwardTurn, F64_0p04_LimitSkateSpeed, F64_0p0628319
extern F64_0p0628319_PickGlideAnim, F64_0p125664, F64_0p1_StopSkidDistance, F64_0p2_LimitSkateSpeed, F64_0p2_PickBackwardTurn, F64_0p2_PickForwardTurn, F64_0p2_StopSkidDistance, F64_0p2_TurnStickPos
extern F64_0p523599, F64_0p5_PickBackwardTurn, F64_0p5_PickForwardTurn, F64_0p63662, F64_0p63662_SkateBackwardMove, F64_0p785398_GlideForwardMove, F64_0p785398_PickStrideAnim, F64_0p7_SkateBackwardMove
extern F64_0p7_SkateForwardMove, F64_1272_GlideForwardMove, F64_1p0472_GlideForwardMove, F64_1p1_PickStrideAnim, F64_1p2_StopSkidDistance, F64_1p33, F64_1p33_TurnLeanAngle, F64_1p39626
extern F64_1p39626_SkateBackwardMove, F64_1p5, F64_1p52588eneg05_FaceoffPuckDrop, F64_1p5708_PickGlideAnim, F64_1p5708_SkateBackwardMove, F64_1p5708_SkateForwardMove, F64_1p5708_StopForwardMove, F64_1p8
extern F64_1p8_PickBackwardTurn, F64_2_ApplySkateAccel, F64_2_TurnLeanAngle, F64_2_TurnStickPos, F64_2p35619_GlideForwardMove, F64_2p35619_PickStrideAnim, F64_2p35619_PickTurnAnim, F64_2p5_TurnStickPos
extern F64_2p82743_StopSkidDistance, F64_384, F64_384_EndMove, F64_3p14159_ApplyMoveMotion, F64_3p14159_FaceoffPuckDrop, F64_3p14159_GlideForwardMove, F64_3p14159_LimitSkateSpeed, F64_3p14159_PickBackwardTurn
extern F64_3p14159_PickForwardTurn, F64_3p14159_PickStrideAnim, F64_3p14159_SkateBackwardMove, F64_3p14159_SkateForwardMove, F64_3p14159_SpeedTowardSpot, F64_3p14159_StopForwardMove, F64_4032_GlideForwardMove, F64_4272_EndMove
extern F64_4272_PickSkateAnim, F64_4448, F64_4448_EndMove, F64_6p28319_ApplyMoveMotion, F64_6p28319_FaceoffPuckDrop, F64_6p28319_GlideForwardMove, F64_6p28319_LimitSkateSpeed, F64_6p28319_PickBackwardTurn
extern F64_6p28319_PickForwardTurn, F64_6p28319_PickStrideAnim, F64_6p28319_SkateBackwardMove, F64_6p28319_SkateForwardMove, F64_6p28319_SpeedTowardSpot, F64_6p28319_StopForwardMove, F64_864, F64_864_EndMove
extern F64_neg0p1_StopSkidDistance, F64_neg3p14159_ApplyMoveMotion, F64_neg3p14159_FaceoffPuckDrop, F64_neg3p14159_GlideForwardMove, F64_neg3p14159_LimitSkateSpeed, F64_neg3p14159_PickBackwardTurn, F64_neg3p14159_PickForwardTurn, F64_neg3p14159_PickStrideAnim
extern F64_neg3p14159_SkateBackwardMove, F64_neg3p14159_SkateForwardMove, F64_neg3p14159_SpeedTowardSpot, F64_neg3p14159_StopForwardMove, F64_neg3p75, F64_neg3p75_TurnStickPos, F64_neg6p28319_ApplyMoveMotion, F64_neg6p28319_FaceoffPuckDrop
extern F64_neg6p28319_GlideForwardMove, F64_neg6p28319_LimitSkateSpeed, F64_neg6p28319_PickBackwardTurn, F64_neg6p28319_PickForwardTurn, F64_neg6p28319_PickStrideAnim, F64_neg6p28319_SkateBackwardMove, F64_neg6p28319_SkateForwardMove, F64_neg6p28319_SpeedTowardSpot
extern F64_neg6p28319_StopForwardMove, GetStickBladePos, GetStopTable, gmode, GoalieAI, hypot_, IdleAnims, IF@ATAN2
extern IF@DFMOD, IsStopAnim, MoveFuncPair, MovePlayer, gmode2, PlaySfxVolume, PtrPuckFlags, PtrPuckOwner
extern puckc, PuckOnStickPhysics, randomd0, ScaleAnimTime, SetFaceMouth, SetSPA, SetSPAInPlace, SkateAnimAccel
extern SkateAnimSpeeds, SkateMoveTable, SkateStrideTable, SpeedScale, StartNextMove, StickHandleSpeed, StickHandleTarget, StrideSpeeds
extern TurnAnimAngles, TurnRateForSpeed, UpdateMovePose
global ResetAnimTimer, PickIdleAnim, PickSkateAnim, EndMove, AdvanceMoveAnim, ApplyMoveMotion, StepMove, HoldPoseMove
global SteerTowardTarget, ApplySkateAccel, SteerAndAccel, PickTurnAnim, PickStopAnim, PickCrossoverAnim, PickGlideAnim, PickStrideAnim
global PickForwardTurn, PickBackwardTurn, GlideForwardMoveJumpTable, GlideForwardMove, GlideForwardMove_220, GlideForwardMove_230, GlideForwardMove_240, GlideForwardMove_250
global GlideForwardMove_260, LimitSkateSpeed, SkateForwardMoveJumpTable, SkateForwardMove, SkateForwardMove_89, SkateForwardMove_99, SkateForwardMove_A9, SkateForwardMove_3AE
global SkateForwardMove_3E0, SkateForwardMove_41B, SkateBackwardMoveJumpTable, SkateBackwardMove, SkateBackwardMove_31, SkateBackwardMove_41, SkateBackwardMove_51, SkateBackwardMove_345
global SkateBackwardMove_377, SkateBackwardMove_3B2, TurnLeanAngle, TurnStickPos, TurnForwardMoveJumpTable, TurnForwardMove, TurnForwardMove_31, TurnForwardMove_41
global TurnForwardMove_51, TurnForwardMove_61, TurnForwardMove_71, TurnForwardMove_BC, TurnForwardMove_C2, StopSkidDistance, StopForwardMove, StandMove
global SpeedTowardSpot, StartMoveAtSpeed, CrossoverMove, GoalieSlideMove, GoalieStanceMove, SlowSkateMove, GlideBackwardMoveJumpTable, GlideBackwardMove
global GlideBackwardMove_23, GlideBackwardMove_2F, GlideBackwardMove_3B, GlideBackwardMove_47, GlideBackwardMove_53, TurnBackwardMoveJumpTable, TurnBackwardMove, TurnBackwardMove_31
global TurnBackwardMove_41, TurnBackwardMove_51, TurnBackwardMove_61, TurnBackwardMove_71, TurnBackwardMove_BC, TurnBackwardMove_C2, StopBackwardMove, FaceoffPuckDrop
global SetSkateSpeedFromRating
        db 090h
;-----------------------------------------------------------------------------
; ResetAnimTimer                                  60D6C  97 PC, low confidence
; Resets a player's animation timer
;-----------------------------------------------------------------------------
ResetAnimTimer:
        mov dword [byte eax+04h], 3F800000h
        mov dword [byte eax+0Ch], 0
        mov dword [byte eax+08h], 0
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PickIdleAnim                                    60D84  97 PC, low confidence
; Picks the idle animation for a player
;-----------------------------------------------------------------------------
PickIdleAnim:
        push ebx
        push ecx
        push edx
        push esi
        mov ecx, eax
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov ebx, dword [dword ecx+0FAh]
        mov esi, dword [byte eax+028h]
        mov ah, byte [dword ecx+0A4h]
        and esi, 0FFFFh
        cmp ah, 0Ch
        jne short .3
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        jne short .1
        test byte [byte eax+028h], 80h
        je short .2
        cmp dword [byte ecx+038h], 3F800000h
        jge short .2
.1:
        test byte [dword ecx+0C1h], 2
        setne al
        and eax, 0FFh
        lea edx, [dword eax+013Dh]
        jmp near .12
.2:
        test byte [dword ecx+0C1h], 2
        setne al
        and eax, 0FFh
        lea edx, [dword eax+010Fh]
        jmp near .12
.3:
        cmp word [dword ecx+0A9h], byte 0
        jne short .5
        mov edx, dword [puckc]
        xor eax, eax
        movsx edx, byte [edx]
        mov al, byte [dword ecx+0A4h]
        cmp eax, edx
        jne short .4
        test byte [byte ebx+031h], 2
        jne short .4
        mov edx, 100h
        cmp edx, esi
        jne near .13
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov edx, 0BAh
        cmp edx, esi
        jne near .13
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        jne short .6
        test byte [byte eax+028h], 80h
        je short .7
        cmp dword [byte ecx+038h], 3F800000h
        jge short .7
.6:
        mov edx, 12h
        cmp edx, esi
        jne near .13
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        jne short .8
        mov edx, 33h
        cmp edx, esi
        jne near .13
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        mov eax, dword [dword ecx+0F2h]
        cmp dword [byte eax+038h], byte 0
        jne short .9
        mov edx, 10Fh
        cmp edx, esi
        jne short .13
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 2
        jne short .10
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        jne short .11
.10:
        mov edx, 6
        cmp edx, esi
        jne short .13
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        mov eax, 3
        call randomd0
        cwde
        mov edx, dword [nosplit eax*4+IdleAnims]
.12:
        cmp edx, esi
        jne short .13
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.13:
        mov dword [byte ebx+08h], 0
        mov dword [byte ebx+04h], 3F800000h
        mov dword [byte ebx+0Ch], 0
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        mov ebx, 20h
        push dword 3F800000h
        call SetSPA
        mov eax, 1
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PickSkateAnim                                   60F48  97 PC, low confidence
; Picks the skating animation for a player
;-----------------------------------------------------------------------------
PickSkateAnim:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov ebx, dword [byte eax+028h]
        mov ah, byte [dword ecx+0A4h]
        and ebx, 0FFFFh
        cmp ah, 0Ch
        jne short .3
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .1
        test byte [dword ecx+0C1h], 2
        setne al
        and eax, 0FFh
        lea edx, [dword eax+012Fh]
        jmp near .32
.1:
        test byte [gmode], 1
        jne short .2
        test byte [dword ecx+0C1h], 2
        setne al
        and eax, 0FFh
        lea edx, [dword eax+0107h]
        jmp near .32
.2:
        test byte [dword ecx+0C1h], 2
        setne al
        and eax, 0FFh
        lea edx, [dword eax+0109h]
        jmp near .32
.3:
        cmp word [dword ecx+0A9h], byte 0
        jne near .17
        test byte [gmode2], 1
        je short .5
.4:
        mov edx, 9Eh
        jmp near .32
.5:
        xor edx, edx
        mov dl, ah
        mov eax, dword [puckc]
        movsx eax, byte [eax]
        cmp edx, eax
        jne short .6
        mov eax, dword [dword ecx+0FAh]
        test byte [byte eax+031h], 2
        jne short .6
        mov edx, 9Ch
        jmp near .32
.6:
        test byte [gmode], 1
        jne near .16
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 17h
        je near .15
        fld dword [byte ecx+028h]
        fabs
        fst qword [byte esp+04h]
        fcomp qword [F64_4272_PickSkateAnim]
        fnstsw ax
        sahf
        jbe short .7
        fld qword [byte esp+04h]
        fcomp qword [F64_4448]
        fnstsw ax
        sahf
        ja near .15
        fld dword [byte ecx+020h]
        fabs
        fcomp qword [F64_384]
        fnstsw ax
        sahf
        ja near .15
.7:
        test byte [dword ecx+0BFh], 80h
        je short .8
        mov dword [esp], 0FFFFEF50h
        jmp short .9
.8:
        mov dword [esp], 10B0h
.9:
        fild dword [esp]
        fsubr dword [byte ecx+028h]
        sub esp, byte 8
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte ecx+020h]
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_864]
        fnstsw ax
        sahf
        ja near .15
        test byte [dword ecx+0BFh], 80h
        setne al
        mov edx, eax
        mov eax, dword [PtrPuckOwner]
        mov si, word [eax]
        and edx, 0FFh
        test si, si
        setg al
        and eax, 0FFh
        xor eax, edx
        je near .4
        mov edx, dword [PtrPuckOwner]
        mov di, word [edx]
        test di, di
        jge short .10
        movsx eax, di
        neg eax
        jmp short .11
.10:
        movsx eax, di
.11:
        cmp eax, 570h
        jle near .4
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .12
        cmp byte [dword ecx+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [puckc]
        and edx, 0FFh
        cmp byte [eax], 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        je short .13
.12:
        mov eax, 1
        jmp short .14
.13:
        xor eax, edx
.14:
        test eax, eax
        je near .4
        mov edx, 9Dh
        jmp near .32
.15:
        mov edx, 9Bh
        jmp near .32
.16:
        cmp dword [byte ecx+038h], 41400000h
        jg short .15
        mov edx, 0A0h
        jmp near .32
.17:
        test byte [gmode2], 1
        je short .19
        cmp word [dword ecx+0A9h], byte 4
        jne short .18
        mov edx, 0Bh
        jmp near .32
.18:
        mov edx, 0Ch
        jmp near .32
.19:
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .23
        cmp word [dword ecx+0A9h], byte 0
        jle short .20
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        je short .21
.20:
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        je short .21
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 2
        je short .22
.21:
        mov edx, 38h
        jmp near .32
.22:
        mov edx, 11h
        jmp near .32
.23:
        cmp word [dword ecx+0A9h], byte 0
        jle short .24
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        je short .25
.24:
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        je short .25
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 2
        je short .28
.25:
        test byte [gmode], 1
        jne short .26
        mov eax, dword [dword ecx+0EEh]
        cmp dword [byte eax+024h], 42200000h
        jge short .27
.26:
        mov edx, 37h
        jmp short .32
.27:
        mov edx, 32h
        jmp short .32
.28:
        mov edx, dword [dword ecx+0F2h]
        cmp dword [byte edx+038h], byte 0
        jne short .29
        mov edx, 109h
        jmp short .32
.29:
        test byte [gmode], 1
        jne short .30
        cmp dword [byte eax+024h], 42200000h
        jge short .31
.30:
        mov edx, 1
        jmp short .32
.31:
        mov edx, 2
.32:
        cmp edx, ebx
        je short .33
        mov eax, dword [dword ecx+0FAh]
        mov dword [byte eax+08h], 0
        mov dword [byte eax+04h], 3F800000h
        mov dword [byte eax+0Ch], 0
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        mov ebx, 20h
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0FAh]
        and byte [byte eax+031h], 0F7h
.33:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; EndMove                                         612E4  97 PC, low confidence
; Ends the current move
;-----------------------------------------------------------------------------
EndMove:
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        and esp, byte 0FFFFFFF8h
        mov edx, dword [byte eax+02Ch]
        cmp dword [byte edx+038h], 40C00000h
        jl near .4
        cmp word [dword edx+0A9h], byte 0
        jne near .5
        mov eax, dword [dword edx+0AEh]
        sar eax, 18h
        cmp byte [dword edx+eax+0B2h], 17h
        je near .5
        fld dword [byte edx+028h]
        fabs
        fst qword [byte esp+04h]
        fcomp qword [F64_4272_EndMove]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+04h]
        fcomp qword [F64_4448_EndMove]
        fnstsw ax
        sahf
        ja short .5
        fld dword [byte edx+020h]
        fabs
        fcomp qword [F64_384_EndMove]
        fnstsw ax
        sahf
        ja short .5
.1:
        test byte [dword edx+0BFh], 80h
        je short .2
        mov dword [esp], 0FFFFEF50h
        jmp short .3
.2:
        mov dword [esp], 10B0h
.3:
        fild dword [esp]
        fsubr dword [byte edx+028h]
        sub esp, byte 8
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte edx+020h]
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_864_EndMove]
        fnstsw ax
        sahf
        ja short .5
.4:
        mov eax, edx
        call PickSkateAnim
        mov esp, ebp
        pop ebp
        pop edx
        ret
.5:
        mov eax, edx
        call PickIdleAnim
        mov esp, ebp
        pop ebp
        pop edx
        ret
;-----------------------------------------------------------------------------
; AdvanceMoveAnim                                 613AC  97 PC, low confidence
; Advances the move's animation one frame
;-----------------------------------------------------------------------------
AdvanceMoveAnim:
        push ebx
        push ecx
        push esi
        mov ecx, eax
        mov esi, edx
        mov edx, dword [byte eax+02Ch]
        mov edx, dword [dword edx+0F2h]
        mov ebx, esi
        mov edx, dword [byte edx+054h]
        call UpdateMovePose
        mov edx, dword [byte ecx+010h]
        cmp edx, 3F800000h
        je short .1
        test edx, 7FFFFFFFh
        je short .1
        fld dword [byte ecx+010h]
        fdivr dword [esi]
        fstp dword [esi]
        fld dword [byte ecx+010h]
        fdivr dword [byte esi+04h]
        fstp dword [byte esi+04h]
        fld dword [byte ecx+010h]
        fdivr dword [byte esi+08h]
        fstp dword [byte esi+08h]
.1:
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ApplyMoveMotion                                 613F8  97 PC, low confidence
; Applies the move's motion to the player
;-----------------------------------------------------------------------------
ApplyMoveMotion:
        push ebx
        push ecx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 24h
        and esp, byte 0FFFFFFF8h
        mov ebx, edx
        mov edx, dword [byte eax+02Ch]
        mov eax, edx
        mov ecx, dword [dword edx+0FAh]
        call GetStickBladePos
        mov esi, dword [byte ecx+0Ch]
        fstp dword [esp]
        test esi, 7FFFFFFFh
        je short .1
        fld dword [byte ecx+0Ch]
        fadd dword [byte ebx+04h]
        fstp dword [byte ebx+04h]
.1:
        test dword [byte ecx+08h], 7FFFFFFFh
        je short .3
        cmp dword [byte ecx+034h], 461C4000h
        jl short .3
        fld dword [byte ecx+08h]
        fadd dword [byte ebx+08h]
        fldz
        fxch
        fstp dword [byte ebx+08h]
        fcomp dword [byte ebx+08h]
        fnstsw ax
        sahf
        jbe short .2
        mov dword [byte ebx+08h], 0
.2:
        fld dword [byte ebx+08h]
        fcomp dword [esp]
        fnstsw ax
        sahf
        jbe short .3
        mov eax, dword [esp]
        mov dword [byte ebx+08h], eax
.3:
        cmp dword [byte ecx+04h], 3F800000h
        je short .4
        fld dword [byte ecx+04h]
        fmul dword [byte ebx+08h]
        fstp dword [byte ebx+08h]
.4:
        fld dword [byte ebx+04h]
        fadd dword [byte edx+01Ch]
        fld qword [F64_6p28319_ApplyMoveMotion]
        fxch
        call IF@DFMOD
        fst dword [byte edx+01Ch]
        fst qword [byte esp+01Ch]
        fcomp qword [F64_3p14159_ApplyMoveMotion]
        fnstsw ax
        sahf
        jbe short .5
        fld qword [byte esp+01Ch]
        fadd qword [F64_neg6p28319_ApplyMoveMotion]
        fstp dword [byte edx+01Ch]
.5:
        fld dword [byte edx+01Ch]
        fst qword [byte esp+0Ch]
        fcomp qword [F64_neg3p14159_ApplyMoveMotion]
        fnstsw ax
        sahf
        jae short .6
        fld qword [byte esp+0Ch]
        fadd qword [F64_6p28319_ApplyMoveMotion]
        fstp dword [byte edx+01Ch]
.6:
        fld dword [byte edx+01Ch]
        fadd dword [ebx]
        fld qword [F64_6p28319_ApplyMoveMotion]
        fxch
        call IF@DFMOD
        fst dword [byte edx+040h]
        fst qword [byte esp+04h]
        fcomp qword [F64_3p14159_ApplyMoveMotion]
        fnstsw ax
        sahf
        jbe short .7
        fld qword [byte esp+04h]
        fadd qword [F64_neg6p28319_ApplyMoveMotion]
        fstp dword [byte edx+040h]
.7:
        fld dword [byte edx+040h]
        fst qword [byte esp+014h]
        fcomp qword [F64_neg3p14159_ApplyMoveMotion]
        fnstsw ax
        sahf
        jae short .8
        fld qword [byte esp+014h]
        fadd qword [F64_6p28319_ApplyMoveMotion]
        fstp dword [byte edx+040h]
.8:
        mov eax, dword [byte ebx+08h]
        mov dword [byte edx+038h], eax
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; StepMove                                        6152C  97 PC, low confidence
; Steps a move one frame
;-----------------------------------------------------------------------------
StepMove:
        push ebx
        mov ebx, dword [byte eax+02Ch]
        call ApplyMoveMotion
        mov eax, ebx
        call MovePlayer
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; HoldPoseMove                                    61540  97 PC, low confidence
; Move handler that keeps the player in place until the animation ends
;-----------------------------------------------------------------------------
HoldPoseMove:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ecx, eax
        mov dl, byte [byte ecx+01Ch]
        mov eax, dword [byte eax+02Ch]
        test dl, 80h
        je short .1
        mov edx, dword [dword eax+0EEh]
        mov bl, byte [byte edx+031h]
        and bl, 0FEh
        mov eax, ecx
        mov byte [byte edx+031h], bl
        call EndMove
        jmp short .3
.1:
        mov edx, dword [dword eax+0F2h]
        mov ebx, esp
        mov eax, ecx
        mov edx, dword [byte edx+054h]
        call UpdateMovePose
        mov edx, dword [byte ecx+010h]
        cmp edx, 3F800000h
        je short .2
        test edx, 7FFFFFFFh
        je short .2
        fld dword [esp]
        fdiv dword [byte ecx+010h]
        fld dword [byte esp+04h]
        fxch
        fstp dword [esp]
        fdiv dword [byte ecx+010h]
        fld dword [byte esp+08h]
        fxch
        fstp dword [byte esp+04h]
        fdiv dword [byte ecx+010h]
        fstp dword [byte esp+08h]
.2:
        mov edx, esp
        mov eax, ecx
        mov ebx, dword [byte ecx+02Ch]
        call ApplyMoveMotion
        mov eax, ebx
        call MovePlayer
.3:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SteerTowardTarget                               615D0  97 PC, low confidence
; Turns the player toward its target
;-----------------------------------------------------------------------------
SteerTowardTarget:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov ebx, eax
        mov ecx, edx
        mov esi, 40200000h
        mov edi, 40700000h
        mov edx, dword [dword eax+0FAh]
        mov eax, dword [byte eax+038h]
        mov dword [esp], esi
        mov dword [byte esp+0Ch], eax
        mov eax, ebx
        mov dword [byte esp+04h], edi
        call GetStickBladePos
        mov ebp, dword [byte edx+018h]
        fstp dword [byte esp+08h]
        test ebp, 7FFFFFFFh
        je near .5
        cmp ebp, 43700000h
        jle short .1
        fld dword [byte ebx+038h]
        fcomp dword [byte esp+08h]
        fnstsw ax
        sahf
        jae short .1
        cmp dword [byte edx+01Ch], byte 5
        je short .1
        fld dword [byte esp+0Ch]
        fadd dword [F32_2p5]
        fst dword [byte esp+0Ch]
        fcomp dword [byte esp+08h]
        fnstsw ax
        sahf
        jbe near .5
        mov eax, dword [byte esp+08h]
        mov dword [byte esp+0Ch], eax
        jmp near .5
.1:
        cmp dword [byte edx+018h], 42400000h
        jle short .2
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte edx+018h]
        fcomp dword [byte eax+01Ch]
        fnstsw ax
        sahf
        jbe short .2
        mov eax, ebx
        call TurnRateForSpeed
        fadd dword [byte ebx+038h]
        fadd dword [esp]
        fcomp dword [byte edx+018h]
        fnstsw ax
        sahf
        jae short .2
        mov ebp, dword [byte edx+01Ch]
        cmp ebp, byte 5
        je short .2
        cmp ebp, byte 3
        je short .2
        fld dword [byte esp+0Ch]
        fadd dword [esp]
        fst dword [byte esp+0Ch]
        fcomp dword [byte esp+08h]
        fnstsw ax
        sahf
        jbe near .5
        mov eax, dword [byte esp+08h]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte esp+0Ch]
        mov dword [byte ecx+08h], eax
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        cmp dword [byte edx+01Ch], byte 3
        jne short .3
        cmp dword [byte edx+018h], 43700000h
        jg short .3
        mov eax, ebx
        call TurnRateForSpeed
        fadd dword [byte ebx+038h]
        fadd dword [byte esp+04h]
        fcomp dword [byte edx+018h]
        fnstsw ax
        sahf
        jbe short .3
        fld dword [byte esp+04h]
        fmul dword [F32_2_SteerTowardTarget]
        fstp dword [byte esp+04h]
.3:
        mov eax, dword [dword ebx+0EEh]
        test dword [byte eax+08h], 7FFFFFFFh
        jne short .4
        cmp dword [byte edx+018h], 42400000h
        jge short .4
        fld dword [byte esp+0Ch]
        fcomp dword [F32_12_SteerTowardTarget]
        fnstsw ax
        sahf
        jae short .4
        xor ebx, ebx
        mov dword [byte esp+0Ch], ebx
        mov eax, dword [byte esp+0Ch]
        mov dword [byte ecx+08h], eax
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.4:
        fld dword [byte esp+0Ch]
        fsub dword [byte esp+04h]
        fldz
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jbe short .5
        xor edx, edx
        mov dword [byte esp+0Ch], edx
.5:
        mov eax, dword [byte esp+0Ch]
        mov dword [byte ecx+08h], eax
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ApplySkateAccel                                 61764  97 PC, low confidence
; Speeds the player up toward its skating speed
;-----------------------------------------------------------------------------
ApplySkateAccel:
        push ebx
        push ecx
        sub esp, byte 10h
        mov ecx, eax
        mov ebx, edx
        mov edx, dword [dword eax+0FAh]
        call SpeedScale
        fdivr dword [byte ecx+038h]
        fmul qword [F64_1p33]
        fsubr qword [F64_2_ApplySkateAccel]
        fmul qword [F64_0p0628319]
        fldz
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte edx+014h]
        fnstsw ax
        sahf
        ja short .3
        fld dword [byte edx+014h]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jbe short .1
        mov edx, dword [byte esp+0Ch]
        jmp short .2
.1:
        mov edx, dword [byte edx+014h]
.2:
        mov dword [byte esp+08h], edx
        mov edx, dword [byte esp+08h]
        jmp short .6
.3:
        fld dword [byte edx+014h]
        fld dword [byte esp+0Ch]
        fchs
        fstp dword [byte esp+04h]
        fcomp dword [byte esp+04h]
        fnstsw ax
        sahf
        jae short .4
        mov edx, dword [byte esp+04h]
        jmp short .5
.4:
        mov edx, dword [byte edx+014h]
.5:
        mov dword [esp], edx
        mov edx, dword [esp]
.6:
        mov dword [byte ebx+04h], edx
        add esp, byte 10h
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SteerAndAccel                                   617EC  97 PC, low confidence
; Turns toward the target and speeds up
;-----------------------------------------------------------------------------
SteerAndAccel:
        push ebx
        push ecx
        mov ebx, eax
        mov ecx, edx
        call ApplySkateAccel
        mov edx, ecx
        mov eax, ebx
        call SteerTowardTarget
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PickTurnAnim                                    61804  97 PC, low confidence
; Picks a turning animation
;-----------------------------------------------------------------------------
PickTurnAnim:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov ebx, dword [dword eax+0FAh]
        mov eax, dword [byte ebx+014h]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [dword ecx+0F6h]
        mov eax, dword [eax]
        mov edx, 0Ah
        mov esi, dword [byte eax+028h]
        mov di, word [dword ecx+0A9h]
        and esi, 0FFFFh
        test di, di
        jne near .6
        cmp byte [dword ecx+0D0h], 0
        setne al
        mov edx, eax
        fldz
        and edx, 0FFh
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor eax, edx
        je short .2
        mov edx, dword [puckc]
        xor eax, eax
        movsx edx, byte [edx]
        mov al, byte [dword ecx+0A4h]
        cmp eax, edx
        jne short .1
        mov edx, 0A6h
        jmp short .4
.1:
        mov edx, 0A4h
        jmp short .4
.2:
        mov edx, dword [puckc]
        mov al, byte [dword ecx+0A4h]
        movsx edx, byte [edx]
        cmp eax, edx
        jne short .3
        mov edx, 0A5h
        jmp short .4
.3:
        mov edx, 0A3h
.4:
        cmp edx, esi
        je short .5
        mov dword [byte ebx+08h], 0
        mov dword [byte ebx+04h], 3F800000h
        mov dword [byte ebx+0Ch], 0
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        mov ebx, 20h
        push dword 3F800000h
        call SetSPA
.5:
        mov edx, 1
        mov eax, edx
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .7
        mov edx, 22h
.7:
        mov eax, edx
        shl edx, 3
        sub edx, eax
        fld dword [nosplit edx*8+TurnAnimAngles]
        fabs
        fld dword [byte esp+0Ch]
        fabs
        fxch
        fdivr st1
        fmul dword [byte ecx+038h]
        fmul qword [F64_1p5]
        fstp dword [byte esp+08h]
        fcomp qword [F64_2p35619_PickTurnAnim]
        fnstsw ax
        sahf
        ja short .8
        fld dword [byte esp+08h]
        fcomp dword [byte ebx+018h]
        fnstsw ax
        sahf
        jbe near .32
        cmp dword [byte ecx+038h], 41400000h
        jle near .32
.8:
        cmp byte [dword ecx+0D0h], 0
        setne al
        mov edx, eax
        fldz
        and edx, 0FFh
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor edx, eax
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        setne al
        and eax, 0FFh
        xor eax, edx
        je near .19
        mov dl, byte [dword ecx+0A4h]
        cmp dl, 0Ch
        jne short .10
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .9
        test byte [dword ecx+0C1h], 2
        setne al
        and eax, 0FFh
        lea edx, [dword eax+0131h]
        jmp near .30
.9:
        test byte [dword ecx+0C1h], 2
        setne al
        and eax, 0FFh
        lea edx, [dword eax+010Bh]
        jmp near .30
.10:
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .14
        cmp word [dword ecx+0A9h], byte 0
        jle short .11
        xor eax, eax
        mov al, dl
        mov edx, dword [puckc]
        movsx edx, byte [edx]
        cmp eax, edx
        je short .12
.11:
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        je short .12
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 2
        je short .13
.12:
        mov edx, 39h
        jmp near .30
.13:
        mov edx, 14h
        jmp near .30
.14:
        mov eax, dword [dword ecx+0F2h]
        cmp dword [byte eax+038h], byte 0
        jne short .15
        mov edx, 10Bh
        jmp near .30
.15:
        cmp word [dword ecx+0A9h], byte 0
        jle short .16
        mov edx, dword [puckc]
        xor eax, eax
        movsx edx, byte [edx]
        mov al, byte [dword ecx+0A4h]
        cmp eax, edx
        je short .17
.16:
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        je short .17
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 2
        je short .18
.17:
        mov edx, 35h
        jmp near .30
.18:
        mov edx, 7
        jmp near .30
.19:
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .21
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .20
        mov ah, byte [dword ecx+0C1h]
        xor edx, edx
        test ah, 2
        setne dl
        add edx, 133h
        jmp near .30
.20:
        test byte [dword ecx+0C1h], 2
        setne al
        xor edx, edx
        mov dl, al
        add edx, 10Dh
        jmp near .30
.21:
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .25
        cmp word [dword ecx+0A9h], byte 0
        jle short .22
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        je short .23
.22:
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        je short .23
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 2
        je short .24
.23:
        mov edx, 3Ah
        jmp near .30
.24:
        mov edx, 15h
        jmp short .30
.25:
        mov eax, dword [dword ecx+0F2h]
        cmp dword [byte eax+038h], byte 0
        jne short .26
        mov edx, 10Dh
        jmp short .30
.26:
        cmp word [dword ecx+0A9h], byte 0
        jle short .27
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        je short .28
.27:
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        je short .28
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 2
        je short .29
.28:
        mov edx, 36h
        jmp short .30
.29:
        mov edx, 8
.30:
        cmp edx, esi
        je short .31
        mov dword [byte ebx+08h], 0
        mov dword [byte ebx+04h], 3F800000h
        mov dword [byte ebx+0Ch], 0
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        mov ebx, 20h
        push dword 3F800000h
        call SetSPA
.31:
        mov edx, 1
        mov eax, edx
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.32:
        xor edx, edx
        mov eax, edx
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PickStopAnim                                    61BF8  97 PC, low confidence
; Picks a stopping animation
;-----------------------------------------------------------------------------
PickStopAnim:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 4
        mov ecx, eax
        mov ebx, dword [dword eax+0FAh]
        mov eax, dword [byte ebx+014h]
        mov dword [esp], eax
        mov eax, dword [dword ecx+0F6h]
        mov eax, dword [eax]
        mov esi, dword [byte eax+028h]
        mov dx, word [dword ecx+0A9h]
        and esi, 0FFFFh
        test dx, dx
        jne near .5
        cmp byte [dword ecx+0D0h], 0
        setne al
        mov edx, eax
        fldz
        and edx, 0FFh
        fcomp dword [esp]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor eax, edx
        je short .2
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        jne short .1
        mov edx, 0A6h
        jmp short .4
.1:
        mov edx, 0A4h
        jmp short .4
.2:
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        jne short .3
        mov edx, 0A5h
        jmp short .4
.3:
        mov edx, 0A3h
.4:
        cmp edx, esi
        je near .28
        mov dword [byte ebx+08h], 0
        mov dword [byte ebx+04h], 3F800000h
        mov dword [byte ebx+0Ch], 0
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        mov ebx, 20h
        push dword 3F800000h
        call SetSPA
        mov eax, 1
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        cmp byte [dword ecx+0D0h], 0
        setne al
        mov edx, eax
        fldz
        and edx, 0FFh
        fcomp dword [esp]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor edx, eax
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        setne al
        and eax, 0FFh
        xor eax, edx
        je near .16
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .7
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .6
        test byte [dword ecx+0C1h], 2
        setne al
        and eax, 0FFh
        lea edx, [dword eax+0131h]
        jmp near .27
.6:
        test byte [dword ecx+0C1h], 2
        setne al
        and eax, 0FFh
        lea edx, [dword eax+010Bh]
        jmp near .27
.7:
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .11
        cmp word [dword ecx+0A9h], byte 0
        jle short .8
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        je short .9
.8:
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        je short .9
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 2
        je short .10
.9:
        mov edx, 39h
        jmp near .27
.10:
        mov edx, 14h
        jmp near .27
.11:
        mov eax, dword [dword ecx+0F2h]
        cmp dword [byte eax+038h], byte 0
        jne short .12
        mov edx, 10Bh
        jmp near .27
.12:
        cmp word [dword ecx+0A9h], byte 0
        jle short .13
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        je short .14
.13:
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        je short .14
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 2
        je short .15
.14:
        mov edx, 35h
        jmp near .27
.15:
        mov edx, 7
        jmp near .27
.16:
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .18
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .17
        mov ah, byte [dword ecx+0C1h]
        xor edx, edx
        test ah, 2
        setne dl
        add edx, 133h
        jmp near .27
.17:
        test byte [dword ecx+0C1h], 2
        setne al
        xor edx, edx
        mov dl, al
        add edx, 10Dh
        jmp near .27
.18:
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .22
        cmp word [dword ecx+0A9h], byte 0
        jle short .19
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        je short .20
.19:
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        je short .20
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 2
        je short .21
.20:
        mov edx, 3Ah
        jmp near .27
.21:
        mov edx, 15h
        jmp short .27
.22:
        mov eax, dword [dword ecx+0F2h]
        cmp dword [byte eax+038h], byte 0
        jne short .23
        mov edx, 10Dh
        jmp short .27
.23:
        cmp word [dword ecx+0A9h], byte 0
        jle short .24
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        je short .25
.24:
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        je short .25
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 2
        je short .26
.25:
        mov edx, 36h
        jmp short .27
.26:
        mov edx, 8
.27:
        cmp edx, esi
        je short .28
        mov dword [byte ebx+08h], 0
        mov dword [byte ebx+04h], 3F800000h
        mov dword [byte ebx+0Ch], 0
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        mov ebx, 20h
        push dword 3F800000h
        call SetSPA
        mov eax, 1
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.28:
        xor eax, eax
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PickCrossoverAnim                               61F78  97 PC, low confidence
; Picks a crossover animation from the turn
;-----------------------------------------------------------------------------
PickCrossoverAnim:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 4
        mov ecx, eax
        mov ebx, dword [dword eax+0FAh]
        mov eax, dword [byte ebx+014h]
        mov dword [esp], eax
        mov eax, dword [dword ecx+0F6h]
        mov eax, dword [eax]
        mov esi, dword [byte eax+028h]
        mov eax, ecx
        and esi, 0FFFFh
        call PickTurnAnim
        test eax, eax
        jne near .11
        cmp byte [dword ecx+0D0h], 0
        setne al
        mov edx, eax
        fldz
        and edx, 0FFh
        fcomp dword [esp]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor edx, eax
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        setne al
        and eax, 0FFh
        xor eax, edx
        je near .5
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .2
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .1
        test byte [dword ecx+0C1h], 2
        setne al
        and eax, 0FFh
        lea edx, [dword eax+013Fh]
        jmp near .10
.1:
        test byte [dword ecx+0C1h], 2
        setne al
        and eax, 0FFh
        lea edx, [dword eax+0111h]
        jmp near .10
.2:
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .3
        mov edx, 21h
        jmp near .10
.3:
        mov eax, dword [dword ecx+0F2h]
        cmp dword [byte eax+038h], byte 0
        jne short .4
        mov edx, 111h
        jmp near .10
.4:
        mov edx, 9
        jmp near .10
.5:
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .7
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .6
        test byte [dword ecx+0C1h], 2
        setne al
        and eax, 0FFh
        lea edx, [dword eax+0141h]
        jmp short .10
.6:
        test byte [dword ecx+0C1h], 2
        setne al
        and eax, 0FFh
        lea edx, [dword eax+0113h]
        jmp short .10
.7:
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 8
        je short .8
        mov edx, 22h
        jmp short .10
.8:
        mov eax, dword [dword ecx+0F2h]
        cmp dword [byte eax+038h], byte 0
        jne short .9
        mov edx, 113h
        jmp short .10
.9:
        mov edx, 0Ah
.10:
        cmp edx, esi
        je short .11
        mov dword [byte ebx+08h], 0
        mov dword [byte ebx+04h], 3F800000h
        mov dword [byte ebx+0Ch], 0
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        mov ebx, 20h
        push dword 3F800000h
        call SetSPA
.11:
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PickGlideAnim                                   6211C  97 PC, low confidence
; Picks a glide animation
;-----------------------------------------------------------------------------
PickGlideAnim:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 8
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov ebx, dword [dword eax+0FAh]
        mov edx, dword [byte ebx+014h]
        mov dword [byte esp+04h], edx
        mov edx, dword [dword eax+0EEh]
        mov ah, byte [byte edx+031h]
        fld dword [byte esp+04h]
        test ah, 8
        setne dl
        fabs
        movzx esi, dl
        mov edx, dword [dword ecx+0F6h]
        mov edx, dword [edx]
        mov edi, dword [byte edx+028h]
        and edi, 0FFFFh
        fcomp qword [F64_0p0628319_PickGlideAnim]
        fnstsw ax
        sahf
        ja short .1
        fld dword [byte ecx+01Ch]
        fadd dword [byte esp+04h]
        fstp dword [byte ecx+01Ch]
        jmp near .15
.1:
        cmp byte [dword ecx+0D0h], 0
        setne dl
        fldz
        and edx, 0FFh
        fcomp dword [byte esp+04h]
        fnstsw ax
        sahf
        seta byte [esp]
        xor eax, eax
        mov al, byte [esp]
        xor edx, eax
        je near .7
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .3
        fld dword [byte esp+04h]
        fabs
        fcomp qword [F64_1p5708_PickGlideAnim]
        fnstsw ax
        sahf
        jae short .2
        test byte [dword ecx+0C1h], 2
        setne dl
        and edx, 0FFh
        add edx, 11Fh
        jmp near .13
.2:
        test byte [dword ecx+0C1h], 2
        setne dl
        and edx, 0FFh
        add edx, 123h
        jmp near .13
.3:
        mov edx, dword [dword ecx+0F2h]
        cmp dword [byte edx+038h], byte 0
        jne short .5
        fld dword [byte esp+04h]
        fabs
        fcomp qword [F64_1p5708_PickGlideAnim]
        fnstsw ax
        sahf
        jae short .4
        mov edx, 11Fh
        jmp near .13
.4:
        mov edx, 123h
        jmp near .13
.5:
        fld dword [byte esp+04h]
        fabs
        fcomp qword [F64_1p5708_PickGlideAnim]
        fnstsw ax
        sahf
        jae short .6
        mov edx, 1Ch
        jmp near .13
.6:
        mov edx, 1Eh
        jmp near .13
.7:
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .9
        fld dword [byte esp+04h]
        fabs
        fcomp qword [F64_1p5708_PickGlideAnim]
        fnstsw ax
        sahf
        jae short .8
        test byte [dword ecx+0C1h], 2
        setne dl
        and edx, 0FFh
        add edx, 121h
        jmp short .13
.8:
        test byte [dword ecx+0C1h], 2
        setne dl
        and edx, 0FFh
        add edx, 125h
        jmp short .13
.9:
        mov edx, dword [dword ecx+0F2h]
        cmp dword [byte edx+038h], byte 0
        jne short .11
        fld dword [byte esp+04h]
        fabs
        fcomp qword [F64_1p5708_PickGlideAnim]
        fnstsw ax
        sahf
        jae short .10
        mov edx, 121h
        jmp short .13
.10:
        mov edx, 125h
        jmp short .13
.11:
        fld dword [byte esp+04h]
        fabs
        fcomp qword [F64_1p5708_PickGlideAnim]
        fnstsw ax
        sahf
        jae short .12
        mov edx, 1Dh
        jmp short .13
.12:
        mov edx, 1Fh
.13:
        cmp edx, edi
        je short .15
        mov dword [byte ebx+08h], 0
        mov dword [byte ebx+04h], 3F800000h
        mov dword [byte ebx+0Ch], 0
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        xor ebx, ebx
        push dword 3F800000h
        call SetSPA
        test esi, esi
        je short .14
        mov edx, dword [dword ecx+0EEh]
        or byte [byte edx+031h], 8
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.14:
        mov edx, dword [dword ecx+0EEh]
        and byte [byte edx+031h], 0F7h
.15:
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
; PickStrideAnim                                  62340  97 PC, low confidence
; Picks the stride animation from the speed
;-----------------------------------------------------------------------------
PickStrideAnim:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 24h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov edi, dword [byte eax+028h]
        mov eax, ecx
        mov edx, dword [dword ecx+0FAh]
        call StickHandleTarget
        fld dword [byte edx+014h]
        mov esi, eax
        fabs
        and edi, 0FFFFh
        fcomp qword [F64_2p35619_PickStrideAnim]
        fnstsw ax
        sahf
        jbe short .1
        or byte [byte edx+031h], 8
.1:
        mov eax, dword [byte ecx+038h]
        mov dword [byte esp+04h], eax
        lea eax, [nosplit esi*8+00h]
        sub eax, esi
        fld dword [byte esp+04h]
        fdiv dword [nosplit eax*8+StrideSpeeds]
        fst dword [byte esp+020h]
        fcomp dword [F32_0p5_PickStrideAnim]
        fnstsw ax
        sahf
        jae short .2
        mov dword [byte esp+020h], 3F000000h
.2:
        fld dword [byte esp+020h]
        fcomp qword [F64_1p1_PickStrideAnim]
        fnstsw ax
        sahf
        jbe short .3
        mov dword [byte esp+020h], 3F8CCCCDh
.3:
        mov eax, dword [byte esp+020h]
        mov dword [esp], eax
        mov dword [byte edx+04h], eax
        cmp esi, edi
        je near .10
        mov dword [byte edx+04h], 3F800000h
        mov dword [byte edx+0Ch], 0
        mov bl, byte [byte edx+031h]
        mov dword [byte edx+08h], 0
        test bl, 8
        jne near .9
        fld dword [byte edx+014h]
        fabs
        mov eax, dword [byte edx+014h]
        mov dword [byte edx+0Ch], eax
        fcomp qword [F64_0p785398_PickStrideAnim]
        fnstsw ax
        sahf
        jbe short .6
        fldz
        fcomp dword [byte edx+014h]
        fnstsw ax
        sahf
        jae short .4
        mov eax, 5A7ED197h
        mov ebx, 3FE921FBh
        mov dword [byte esp+08h], eax
        mov dword [byte esp+0Ch], ebx
        jmp short .5
.4:
        mov ebx, 5A7ED197h
        mov edi, 0BFE921FBh
        mov dword [byte esp+08h], ebx
        mov dword [byte esp+0Ch], edi
.5:
        fld qword [byte esp+08h]
        fstp dword [byte edx+0Ch]
.6:
        fld qword [F64_6p28319_PickStrideAnim]
        fld dword [byte edx+0Ch]
        call IF@DFMOD
        fst dword [byte edx+0Ch]
        fst qword [byte esp+018h]
        fcomp qword [F64_3p14159_PickStrideAnim]
        fnstsw ax
        sahf
        jbe short .7
        fld qword [byte esp+018h]
        fadd qword [F64_neg6p28319_PickStrideAnim]
        fstp dword [byte edx+0Ch]
.7:
        fld dword [byte edx+0Ch]
        fst qword [byte esp+010h]
        fcomp qword [F64_neg3p14159_PickStrideAnim]
        fnstsw ax
        sahf
        jae short .8
        fld qword [byte esp+010h]
        fadd qword [F64_6p28319_PickStrideAnim]
        fstp dword [byte edx+0Ch]
.8:
        fld dword [byte edx+0Ch]
        fmul dword [F32_0p1]
        fstp dword [byte edx+0Ch]
.9:
        mov eax, dword [esp]
        mov dword [byte edx+04h], eax
        push eax
        mov bh, byte [dword ecx+0BFh]
        mov edx, esi
        and bh, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        xor ebx, ebx
        call SetSPA
.10:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PickForwardTurn                                 624D0  97 PC, low confidence
; Picks the forward turning animation from the angle to the target
;-----------------------------------------------------------------------------
PickForwardTurn:
        push ebx
        push ecx
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 20h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov ebx, dword [byte eax+028h]
        mov eax, dword [puckc]
        mov dl, byte [eax]
        and ebx, 0FFFFh
        test dl, dl
        jl short .1
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+020h]
        fsub dword [byte ecx+020h]
        fld dword [byte eax+028h]
        fsub dword [byte ecx+028h]
        jmp short .2
.1:
        fld dword [byte ecx+020h]
        fchs
        fld dword [byte ecx+028h]
        fchs
.2:
        fxch
        call IF@ATAN2
        fsub dword [byte ecx+01Ch]
        fstp dword [byte esp+01Ch]
        fld qword [F64_6p28319_PickForwardTurn]
        fld dword [byte esp+01Ch]
        call IF@DFMOD
        fst dword [byte esp+01Ch]
        fst qword [byte esp+010h]
        fcomp qword [F64_3p14159_PickForwardTurn]
        fnstsw ax
        sahf
        jbe short .3
        fld qword [byte esp+010h]
        fadd qword [F64_neg6p28319_PickForwardTurn]
        fstp dword [byte esp+01Ch]
.3:
        fld dword [byte esp+01Ch]
        fst qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_PickForwardTurn]
        fnstsw ax
        sahf
        jae short .4
        fld qword [byte esp+08h]
        fadd qword [F64_6p28319_PickForwardTurn]
        fstp dword [byte esp+01Ch]
.4:
        cmp byte [dword ecx+0D0h], 0
        setne al
        xor edx, edx
        fldz
        mov dl, al
        fcomp dword [byte esp+01Ch]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        je short .6
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .5
        test byte [dword ecx+0C1h], 2
        setne al
        xor edx, edx
        mov dl, al
        add edx, 129h
        jmp short .8
.5:
        mov edx, 17h
        jmp short .8
.6:
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .7
        mov ah, byte [dword ecx+0C1h]
        xor edx, edx
        test ah, 2
        setne dl
        add edx, 127h
        jmp short .8
.7:
        mov edx, 16h
.8:
        cmp edx, ebx
        je near .12
        mov eax, dword [dword ecx+0FAh]
        mov dword [byte eax+08h], 0
        mov dword [byte eax+04h], 3F800000h
        mov dword [byte eax+0Ch], 0
        mov ebx, dword [dword ecx+0FAh]
        fld dword [byte ebx+038h]
        fcomp qword [F64_0p0001_PickForwardTurn]
        fnstsw ax
        sahf
        jae short .9
        mov dword [byte ebx+038h], 3F800000h
.9:
        mov eax, dword [dword ecx+0FAh]
        fld dword [byte ecx+038h]
        fdiv dword [byte eax+038h]
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        fdiv dword [nosplit eax*8+StrideSpeeds]
        fst dword [byte esp+018h]
        fcomp qword [F64_0p2_PickForwardTurn]
        fnstsw ax
        sahf
        jae short .10
        mov dword [byte esp+018h], 3E4CCCCDh
.10:
        fld dword [byte esp+018h]
        fcomp qword [F64_1p8]
        fnstsw ax
        sahf
        jbe short .11
        mov dword [byte esp+018h], 3FE66666h
.11:
        mov eax, dword [dword ecx+0FAh]
        mov ebx, dword [byte esp+018h]
        mov dword [byte eax+04h], ebx
        mov eax, dword [dword ecx+0FAh]
        fld dword [byte eax+04h]
        fld st0
        fmul qword [F64_0p5_PickForwardTurn]
        fstp st1
        fstp dword [byte eax+04h]
        mov bl, byte [dword ecx+0BFh]
        or bl, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        xor ebx, ebx
        push dword 3F000000h
        call SetSPA
        or byte [dword ecx+0BFh], 20h
.12:
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PickBackwardTurn                                626BC  97 PC, low confidence
; Picks the backward turning animation from the angle to the target
;-----------------------------------------------------------------------------
PickBackwardTurn:
        push ebx
        push ecx
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 20h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov ebx, dword [byte eax+028h]
        mov eax, dword [puckc]
        mov dl, byte [eax]
        and ebx, 0FFFFh
        test dl, dl
        jl short .1
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+020h]
        fsub dword [byte ecx+020h]
        fld dword [byte eax+028h]
        fsub dword [byte ecx+028h]
        jmp short .2
.1:
        fld dword [byte ecx+020h]
        fchs
        fld dword [byte ecx+028h]
        fchs
.2:
        fxch
        call IF@ATAN2
        fsub dword [byte ecx+01Ch]
        fstp dword [byte esp+01Ch]
        fld qword [F64_6p28319_PickBackwardTurn]
        fld dword [byte esp+01Ch]
        call IF@DFMOD
        fst dword [byte esp+01Ch]
        fst qword [byte esp+010h]
        fcomp qword [F64_3p14159_PickBackwardTurn]
        fnstsw ax
        sahf
        jbe short .3
        fld qword [byte esp+010h]
        fadd qword [F64_neg6p28319_PickBackwardTurn]
        fstp dword [byte esp+01Ch]
.3:
        fld dword [byte esp+01Ch]
        fst qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_PickBackwardTurn]
        fnstsw ax
        sahf
        jae short .4
        fld qword [byte esp+08h]
        fadd qword [F64_6p28319_PickBackwardTurn]
        fstp dword [byte esp+01Ch]
.4:
        cmp byte [dword ecx+0D0h], 0
        setne al
        xor edx, edx
        fldz
        mov dl, al
        fcomp dword [byte esp+01Ch]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        je short .6
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .5
        test byte [dword ecx+0C1h], 2
        setne al
        xor edx, edx
        mov dl, al
        add edx, 12Dh
        jmp short .8
.5:
        mov edx, 19h
        jmp short .8
.6:
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .7
        mov ah, byte [dword ecx+0C1h]
        xor edx, edx
        test ah, 2
        setne dl
        add edx, 12Bh
        jmp short .8
.7:
        mov edx, 18h
.8:
        cmp edx, ebx
        je near .12
        mov eax, dword [dword ecx+0FAh]
        mov dword [byte eax+08h], 0
        mov dword [byte eax+04h], 3F800000h
        mov dword [byte eax+0Ch], 0
        mov ebx, dword [dword ecx+0FAh]
        fld dword [byte ebx+038h]
        fcomp qword [F64_0p0001_PickBackwardTurn]
        fnstsw ax
        sahf
        jae short .9
        mov dword [byte ebx+038h], 3F800000h
.9:
        mov eax, dword [dword ecx+0FAh]
        fld dword [byte ecx+038h]
        fdiv dword [byte eax+038h]
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        fdiv dword [nosplit eax*8+StrideSpeeds]
        fst dword [byte esp+018h]
        fcomp qword [F64_0p2_PickBackwardTurn]
        fnstsw ax
        sahf
        jae short .10
        mov dword [byte esp+018h], 3E4CCCCDh
.10:
        fld dword [byte esp+018h]
        fcomp qword [F64_1p8_PickBackwardTurn]
        fnstsw ax
        sahf
        jbe short .11
        mov dword [byte esp+018h], 3FE66666h
.11:
        mov eax, dword [dword ecx+0FAh]
        mov ebx, dword [byte esp+018h]
        mov dword [byte eax+04h], ebx
        mov eax, dword [dword ecx+0FAh]
        fld dword [byte eax+04h]
        fld st0
        fmul qword [F64_0p5_PickBackwardTurn]
        fstp st1
        fstp dword [byte eax+04h]
        mov bl, byte [dword ecx+0BFh]
        or bl, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        xor ebx, ebx
        push dword 3F000000h
        call SetSPA
        or byte [dword ecx+0BFh], 20h
.12:
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
GlideForwardMoveJumpTable:                      ; jump table for the switch cases of GlideForwardMove
        dd GlideForwardMove_240
        dd GlideForwardMove_260
        dd GlideForwardMove_250
        dd GlideForwardMove_220
        dd GlideForwardMove_240
        dd GlideForwardMove_260
        dd GlideForwardMove_230
;-----------------------------------------------------------------------------
; GlideForwardMove                                628C4  97 PC, low confidence
; Move handler for gliding forward
;-----------------------------------------------------------------------------
GlideForwardMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 44h
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov edx, dword [byte eax+028h]
        mov ecx, dword [byte eax+02Ch]
        and edx, 0FFFFh
        mov bx, word [dword ecx+0A9h]
        mov edi, dword [dword ecx+0FAh]
        test bx, bx
        jle short .1
        xor eax, eax
        mov al, byte [dword ecx+0A4h]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [puckc]
        movsx eax, byte [eax]
        mov dword [byte esp+010h], eax
        mov eax, dword [byte esp+0Ch]
        cmp eax, dword [byte esp+010h]
        je short .2
.1:
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        je short .2
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 2
        je short .3
.2:
        cmp edx, 10Fh
        je short .3
        cmp edx, 110h
        je short .3
        cmp edx, byte 6
        je short .3
        cmp edx, byte 33h
        je short .3
        mov eax, ecx
        call PickIdleAnim
        test eax, eax
        jne near GlideForwardMove_260.21
.3:
        cmp edx, byte 5
        jne near .14
        fld dword [byte ecx+020h]
        fabs
        fcomp qword [F64_1272_GlideForwardMove]
        fnstsw ax
        sahf
        jbe short .4
        mov edx, 1
        jmp short .5
.4:
        xor edx, edx
.5:
        fld dword [byte ecx+028h]
        fabs
        fcomp qword [F64_4032_GlideForwardMove]
        fnstsw ax
        sahf
        jbe short .6
        mov eax, 1
        jmp short .7
.6:
        xor eax, eax
.7:
        mov ebx, eax
        test edx, edx
        jne short .8
        test eax, eax
        je near .14
.8:
        fld dword [byte ecx+028h]
        fld dword [byte ecx+020h]
        call IF@ATAN2
        fld dword [byte ecx+040h]
        fxch
        fstp dword [byte esp+03Ch]
        fsub dword [byte esp+03Ch]
        fld qword [F64_6p28319_GlideForwardMove]
        fxch
        call IF@DFMOD
        fst dword [byte esp+040h]
        fst qword [byte esp+034h]
        fcomp qword [F64_3p14159_GlideForwardMove]
        fnstsw ax
        sahf
        jbe short .9
        fld qword [byte esp+034h]
        fadd qword [F64_neg6p28319_GlideForwardMove]
        fstp dword [byte esp+040h]
.9:
        fld dword [byte esp+040h]
        fst qword [byte esp+024h]
        fcomp qword [F64_neg3p14159_GlideForwardMove]
        fnstsw ax
        sahf
        jae short .10
        fld qword [byte esp+024h]
        fadd qword [F64_6p28319_GlideForwardMove]
        fstp dword [byte esp+040h]
.10:
        fld dword [byte esp+03Ch]
        fabs
        fld dword [byte esp+040h]
        fabs
        fxch
        fstp dword [byte esp+03Ch]
        fcomp qword [F64_0p785398_GlideForwardMove]
        fnstsw ax
        sahf
        jae near .14
        test edx, edx
        je short .11
        test ebx, ebx
        jne short .13
.11:
        test edx, edx
        je short .12
        fld dword [byte esp+03Ch]
        fst qword [byte esp+02Ch]
        fcomp qword [F64_0p523599]
        fnstsw ax
        sahf
        jbe short .12
        fld qword [byte esp+02Ch]
        fcomp qword [F64_1p0472_GlideForwardMove]
        fnstsw ax
        sahf
        jb short .13
.12:
        test ebx, ebx
        je short .14
        fld dword [byte esp+03Ch]
        fst qword [byte esp+01Ch]
        fcomp qword [F64_0p785398_GlideForwardMove]
        fnstsw ax
        sahf
        jb short .13
        fld qword [byte esp+01Ch]
        fcomp qword [F64_2p35619_GlideForwardMove]
        fnstsw ax
        sahf
        jbe short .14
.13:
        mov eax, dword [byte esi+02Ch]
        mov ebx, dword [dword eax+0FAh]
        fild dword [byte esi+01Ch]
        mov edx, 4
        mov ebx, dword [byte ebx+038h]
        fstp dword [byte esp+018h]
        mov dword [byte esp+014h], ebx
        mov bh, byte [dword eax+0BFh]
        mov ecx, dword [byte esi+04h]
        test bh, 20h
        setne bl
        and ebx, 0FFh
        fld dword [byte esp+018h]
        push ebx
        call __CHP
        push ecx
        fistp dword [byte esp+018h]
        mov ebx, dword [byte esp+018h]
        push dword [byte esp+01Ch]
        call StartNextMove
        jmp near GlideForwardMove_260.21
.14:
        mov eax, dword [byte edi+01Ch]
        dec eax
        cmp eax, byte 6
        ja short GlideForwardMove_260
        jmp dword [nosplit cs:eax*4+GlideForwardMoveJumpTable]
GlideForwardMove_220:
        mov eax, ecx
        call PickStrideAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
GlideForwardMove_230:
        mov eax, ecx
        call PickForwardTurn
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
GlideForwardMove_240:
        mov eax, ecx
        call PickSkateAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
GlideForwardMove_250:
        mov eax, ecx
        call PickCrossoverAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
GlideForwardMove_260:
        test byte [gmode], 1
        je short .17
        test byte [dword ecx+0C0h], 10h
        je short .17
        mov eax, dword [byte esi+04h]
        mov edx, eax
        mov ebx, 7
        sar edx, 1Fh
        idiv ebx
        test al, 1
        je short .15
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        jmp short .16
.15:
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
.16:
        call SetFaceMouth
.17:
        test byte [byte esi+01Ch], 80h
        je short .19
        test byte [gmode], 1
        je short .18
        test byte [dword ecx+0C0h], 10h
        je short .18
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceMouth
.18:
        mov eax, esi
        call EndMove
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.19:
        mov eax, dword [byte esi+02Ch]
        mov edx, dword [dword eax+0F2h]
        mov ebx, esp
        mov eax, esi
        mov edx, dword [byte edx+054h]
        call UpdateMovePose
        mov edi, dword [byte esi+010h]
        cmp edi, 3F800000h
        je short .20
        test edi, 7FFFFFFFh
        je short .20
        fld dword [esp]
        fdiv dword [byte esi+010h]
        fld dword [byte esp+04h]
        fxch
        fstp dword [esp]
        fdiv dword [byte esi+010h]
        fld dword [byte esp+08h]
        fxch
        fstp dword [byte esp+04h]
        fdiv dword [byte esi+010h]
        fstp dword [byte esp+08h]
.20:
        mov edx, esp
        mov eax, ecx
        call ApplySkateAccel
        mov edx, esp
        mov eax, ecx
        call SteerTowardTarget
        mov edx, esp
        mov eax, esi
        mov ebx, dword [byte esi+02Ch]
        call ApplyMoveMotion
        mov eax, ebx
        call MovePlayer
.21:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LimitSkateSpeed                                 62C14  97 PC, low confidence
; Keeps the player's speed under its limit
;-----------------------------------------------------------------------------
LimitSkateSpeed:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 34h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov ecx, dword [dword eax+0FAh]
        mov esi, dword [byte eax+038h]
        mov dword [byte edx+04h], 0
        mov dword [byte esp+02Ch], esi
        mov esi, dword [byte edx+04h]
        mov dword [edx], esi
        mov esi, dword [dword eax+0EEh]
        test byte [byte esi+031h], 8
        je short .1
        mov dword [edx], 40490FDBh
.1:
        mov esi, dword [byte ecx+01Ch]
        cmp esi, byte 5
        jne near .5
        mov esi, dword [dword ebx+0EEh]
        test dword [byte esi+08h], 7FFFFFFFh
        jne short .2
        cmp dword [byte ecx+018h], 42400000h
        jge short .2
        fld dword [byte esp+02Ch]
        fcomp dword [F32_12_LimitSkateSpeed]
        fnstsw ax
        sahf
        jae short .2
        xor eax, eax
        mov dword [byte esp+02Ch], eax
        jmp short .4
.2:
        mov eax, ebx
        call TurnRateForSpeed
        fadd dword [byte ebx+038h]
        fcomp dword [byte ecx+018h]
        fnstsw ax
        sahf
        jbe short .3
        fld dword [byte esp+02Ch]
        fsub dword [F32_3p95_LimitSkateSpeed]
        fldz
        fxch
        fstp dword [byte esp+02Ch]
        fcomp dword [byte esp+02Ch]
        fnstsw ax
        sahf
        jbe short .4
        xor edi, edi
        mov dword [byte esp+02Ch], edi
        jmp short .4
.3:
        fld dword [byte esp+02Ch]
        fld st0
        fadd qword [F64_0p2_LimitSkateSpeed]
        fstp st1
        fstp dword [byte esp+02Ch]
.4:
        cmp dword [byte ecx+018h], 42400000h
        jl near .15
        mov esi, dword [dword ebx+0EEh]
        fld dword [byte ecx+018h]
        fcomp dword [byte esi+01Ch]
        fnstsw ax
        sahf
        jbe near .15
        fld dword [byte esp+02Ch]
        fcomp qword [F64_0p2_LimitSkateSpeed]
        fnstsw ax
        sahf
        ja near .15
        fld dword [byte esi+04h]
        fsub dword [byte ebx+028h]
        fld dword [esi]
        fsub dword [byte ebx+020h]
        call IF@ATAN2
        mov edi, 3ECCCCCDh
        fsub dword [byte ebx+01Ch]
        mov dword [byte esp+02Ch], edi
        fstp dword [edx]
        mov ebx, dword [byte esp+02Ch]
        mov dword [byte edx+08h], ebx
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.5:
        cmp esi, byte 1
        jne near .15
        mov esi, dword [dword ebx+0EEh]
        test byte [byte esi+029h], 1
        je short .6
        test dword [byte esi+024h], 7FFFFFFFh
        jne short .6
        fld dword [byte ebx+038h]
        fmul qword [F64_0p04_LimitSkateSpeed]
        fsubr dword [byte esp+02Ch]
        fldz
        fxch
        fstp dword [byte esp+02Ch]
        fcomp dword [byte esp+02Ch]
        fnstsw ax
        sahf
        jbe near .15
        xor edi, edi
        mov dword [byte esp+02Ch], edi
        jmp near .15
.6:
        mov esi, dword [dword ebx+0EEh]
        test dword [byte esi+08h], 7FFFFFFFh
        jne near .14
        cmp dword [byte ecx+018h], 42400000h
        jge near .14
        fld dword [byte esp+02Ch]
        fcomp dword [F32_12_LimitSkateSpeed]
        fnstsw ax
        sahf
        jae near .14
        xor ecx, ecx
        mov dword [byte esp+02Ch], ecx
        test byte [gmode], 1
        je near .15
        fld dword [byte ebx+044h]
        fsub dword [byte ebx+01Ch]
        fld qword [F64_6p28319_LimitSkateSpeed]
        fxch
        call IF@DFMOD
        mov dword [byte esp+014h], 3D80ADFDh
        fst dword [byte esp+030h]
        fst qword [byte esp+01Ch]
        fcomp qword [F64_3p14159_LimitSkateSpeed]
        fnstsw ax
        sahf
        jbe short .7
        fld qword [byte esp+01Ch]
        fadd qword [F64_neg6p28319_LimitSkateSpeed]
        fstp dword [byte esp+030h]
.7:
        fld dword [byte esp+030h]
        fst qword [byte esp+024h]
        fcomp qword [F64_neg3p14159_LimitSkateSpeed]
        fnstsw ax
        sahf
        jae short .8
        fld qword [byte esp+024h]
        fadd qword [F64_6p28319_LimitSkateSpeed]
        fstp dword [byte esp+030h]
.8:
        fldz
        lea ebx, [byte edx+04h]
        fcomp dword [byte esp+030h]
        fnstsw ax
        sahf
        jae short .11
        fld dword [byte esp+030h]
        fcomp dword [byte esp+014h]
        fnstsw ax
        sahf
        jbe short .9
        mov ecx, dword [byte esp+014h]
        jmp short .10
.9:
        mov ecx, dword [byte esp+030h]
.10:
        mov dword [byte esp+0Ch], ecx
        fld dword [ebx]
        fadd dword [byte esp+0Ch]
        fstp dword [ebx]
        mov ebx, dword [byte esp+02Ch]
        mov dword [byte edx+08h], ebx
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.11:
        fld dword [byte esp+030h]
        fld dword [byte esp+014h]
        fchs
        fstp dword [byte esp+018h]
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        jae short .12
        mov ecx, dword [byte esp+018h]
        jmp short .13
.12:
        mov ecx, dword [byte esp+030h]
.13:
        mov dword [byte esp+08h], ecx
        fld dword [ebx]
        fadd dword [byte esp+08h]
        fstp dword [ebx]
        mov ebx, dword [byte esp+02Ch]
        mov dword [byte edx+08h], ebx
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.14:
        mov esi, dword [dword ebx+0EEh]
        test byte [byte esi+029h], 1
        jne short .15
        cmp dword [byte ecx+018h], 42400000h
        jle short .15
        fld dword [byte ecx+018h]
        fcomp dword [byte esi+01Ch]
        fnstsw ax
        sahf
        jbe short .15
        fld dword [byte esp+02Ch]
        fcomp qword [F64_0p2_LimitSkateSpeed]
        fnstsw ax
        sahf
        ja short .15
        fld dword [byte esi+04h]
        fsub dword [byte ebx+028h]
        mov eax, 3ECCCCCDh
        fld dword [esi]
        fsub dword [byte ebx+020h]
        mov dword [byte esp+02Ch], eax
        call IF@ATAN2
        fsub dword [byte ebx+01Ch]
        fstp dword [edx]
.15:
        mov ebx, dword [byte esp+02Ch]
        mov dword [byte edx+08h], ebx
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
SkateForwardMoveJumpTable:                      ; jump table for the switch cases of SkateForwardMove
        dd SkateForwardMove_3E0
        dd SkateForwardMove_A9
        dd SkateForwardMove_3AE
        dd SkateForwardMove_99
        dd SkateForwardMove_41B
        dd SkateForwardMove_41B
        dd SkateForwardMove_89
;-----------------------------------------------------------------------------
; SkateForwardMove                                62F14  97 PC, low confidence
; Move handler for skating forward
;-----------------------------------------------------------------------------
SkateForwardMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 78h
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov ecx, dword [byte esi+02Ch]
        mov ebx, dword [dword ecx+0FAh]
        mov eax, dword [byte eax+028h]
        mov edx, dword [byte ebx+024h]
        and eax, 0FFFFh
        test edx, edx
        je short .1
        fld dword [byte ecx+040h]
        xor eax, eax
        fsub dword [byte ecx+01Ch]
        mov dword [byte esp+04h], eax
        fstp dword [esp]
        mov eax, dword [byte ecx+038h]
        mov edx, esp
        mov dword [byte esp+08h], eax
        mov eax, esi
        mov edi, dword [byte esi+02Ch]
        call ApplyMoveMotion
        mov eax, edi
        call MovePlayer
        cmp dword [byte ebx+024h], byte 1
        jg near SkateForwardMove_41B.22
        and byte [dword ecx+0BFh], 0DFh
        jmp near SkateForwardMove_41B.22
.1:
        test byte [gmode2], 1
        jne near SkateForwardMove_41B.22
        mov edx, dword [byte ebx+01Ch]
        dec edx
        cmp edx, byte 6
        ja near SkateForwardMove_41B
        jmp dword [nosplit cs:edx*4+SkateForwardMoveJumpTable]
SkateForwardMove_89:
        mov eax, ecx
        call PickForwardTurn
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
SkateForwardMove_99:
        mov eax, ecx
        call PickStrideAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
SkateForwardMove_A9:
        mov eax, ecx
        call PuckOnStickPhysics
        mov esi, eax
        mov edx, eax
        mov eax, dword [byte ecx+038h]
        mov dword [byte esp+018h], eax
        mov eax, ecx
        call PuckOnStickPhysics
        mov edi, dword [nosplit eax*4+MoveFuncPair]
        mov dword [byte esp+030h], eax
        xor eax, eax
        mov al, byte [byte edi+0Dh]
        mov dword [byte esp+038h], eax
        mov eax, dword [byte esp+030h]
        fild word [byte esp+038h]
        mov dword [byte esp+030h], eax
        fmul dword [byte esp+018h]
        mov edi, dword [byte esp+030h]
        shl eax, 3
        fstp dword [byte esp+01Ch]
        sub eax, edi
        fld dword [byte esp+01Ch]
        fadd dword [nosplit eax*8+SkateStrideTable]
        fstp dword [byte esp+01Ch]
        mov eax, dword [byte esp+01Ch]
        mov dword [byte esp+024h], eax
        lea eax, [nosplit esi*8+00h]
        sub eax, esi
        fld dword [byte ecx+038h]
        fadd dword [nosplit eax*8+SkateMoveTable]
        mov eax, dword [dword ecx+0EEh]
        mov esi, dword [byte eax+08h]
        fstp dword [byte esp+028h]
        cmp esi, 41400000h
        jge short .2
        fld dword [byte esp+028h]
        fsub dword [byte eax+08h]
        fcomp dword [F32_12_SkateForwardMove]
        fnstsw ax
        sahf
        jbe short .2
        mov eax, ecx
        call StickHandleTarget
        push eax
        push dword [byte esp+02Ch]
        mov esi, eax
        call StickHandleSpeed
        mov eax, esi
        shl eax, 3
        fstp dword [byte esp+014h]
        sub eax, esi
        fld dword [byte esp+014h]
        fmul dword [nosplit eax*8+SkateStrideTable]
        fstp dword [byte esp+014h]
        mov eax, dword [byte esp+014h]
        mov dword [byte esp+034h], eax
        jmp short .3
.2:
        xor edi, edi
        mov dword [byte esp+034h], edi
.3:
        test byte [byte ebx+031h], 8
        je short .4
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 1
        jne short .5
.4:
        cmp dword [byte ecx+038h], 41400000h
        jge near .16
        fld dword [byte esp+024h]
        fadd dword [byte esp+034h]
        fcomp dword [byte ebx+018h]
        fnstsw ax
        sahf
        jb short .5
        mov eax, dword [dword ecx+0EEh]
        cmp dword [byte eax+08h], 41400000h
        jle near .16
        fld dword [byte eax+08h]
        fsub dword [byte ecx+038h]
        fcomp dword [F32_12_SkateForwardMove]
        fnstsw ax
        sahf
        jbe near .16
.5:
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        shl eax, 3
        cmp byte [dword ecx+0D0h], 0
        je short .6
        fld dword [dword eax+SkateAnimAccel]
        fchs
        fstp dword [byte esp+02Ch]
        jmp short .7
.6:
        mov eax, dword [dword eax+SkateAnimAccel]
        mov dword [byte esp+02Ch], eax
.7:
        fld dword [byte ebx+010h]
        fsub dword [byte esp+02Ch]
        mov eax, edx
        fstp qword [byte esp+044h]
        call IsStopAnim
        test eax, eax
        je short .8
        mov esi, 5A7ED197h
        mov edi, 400921FBh
        mov dword [byte esp+064h], esi
        mov dword [byte esp+068h], edi
        jmp short .9
.8:
        mov dword [byte esp+064h], eax
        mov dword [byte esp+068h], eax
.9:
        mov dword [byte ebx+08h], 0
        mov dword [byte ebx+04h], 3F800000h
        lea eax, [nosplit edx*8+00h]
        mov dword [byte ebx+0Ch], 0
        sub eax, edx
        fld qword [byte esp+044h]
        mov eax, dword [nosplit eax*8+SkateAnimSpeeds]
        fadd qword [byte esp+064h]
        mov dword [byte esp+074h], eax
        mov ah, byte [dword ecx+0D0h]
        fstp dword [byte esp+020h]
        test ah, ah
        je short .10
        fld dword [byte esp+074h]
        fchs
        fstp dword [byte esp+074h]
.10:
        fld dword [byte esp+074h]
        fsub dword [byte ecx+040h]
        fld qword [F64_6p28319_SkateForwardMove]
        fxch
        call IF@DFMOD
        fst dword [byte esp+074h]
        fst qword [byte esp+05Ch]
        fcomp qword [F64_3p14159_SkateForwardMove]
        fnstsw ax
        sahf
        jbe short .11
        fld qword [byte esp+05Ch]
        fadd qword [F64_neg6p28319_SkateForwardMove]
        fstp dword [byte esp+074h]
.11:
        fld dword [byte esp+074h]
        fst qword [byte esp+054h]
        fcomp qword [F64_neg3p14159_SkateForwardMove]
        fnstsw ax
        sahf
        jae short .12
        fld qword [byte esp+054h]
        fadd qword [F64_6p28319_SkateForwardMove]
        fstp dword [byte esp+074h]
.12:
        fld dword [byte esp+074h]
        fabs
        fst dword [byte esp+074h]
        fst qword [byte esp+04Ch]
        fcomp qword [F64_1p39626]
        fnstsw ax
        sahf
        jae short .13
        fld dword [byte ecx+038h]
        fld qword [F64_1p5708_SkateForwardMove]
        fsub qword [byte esp+04Ch]
        fmulp
        fmul qword [F64_0p63662]
        fst dword [byte ebx+08h]
        fld st0
        fmul qword [F64_0p7_SkateForwardMove]
        mov eax, dword [byte ecx+040h]
        mov dword [byte ebx+034h], eax
        fstp st1
        fstp dword [byte ebx+08h]
.13:
        fld dword [byte ecx+01Ch]
        fsubr dword [byte esp+020h]
        fld qword [F64_6p28319_SkateForwardMove]
        fxch
        call IF@DFMOD
        fst dword [byte ebx+0Ch]
        fst qword [byte esp+03Ch]
        fcomp qword [F64_3p14159_SkateForwardMove]
        fnstsw ax
        sahf
        jbe short .14
        fld qword [byte esp+03Ch]
        fadd qword [F64_neg6p28319_SkateForwardMove]
        fstp dword [byte ebx+0Ch]
.14:
        fld dword [byte ebx+0Ch]
        fst qword [byte esp+06Ch]
        fcomp qword [F64_neg3p14159_SkateForwardMove]
        fnstsw ax
        sahf
        jae short .15
        fld qword [byte esp+06Ch]
        fadd qword [F64_6p28319_SkateForwardMove]
        fstp dword [byte ebx+0Ch]
.15:
        fld dword [byte ebx+0Ch]
        fmul dword [F32_0p1_SkateForwardMove]
        fstp dword [byte ebx+0Ch]
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        xor ebx, ebx
        push dword 3F333333h
        call SetSPA
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.16:
        mov eax, ecx
        call PickIdleAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
SkateForwardMove_3AE:
        cmp dword [byte ebx+018h], 43C00000h
        jle short .17
        cmp dword [byte ecx+038h], 40C00000h
        jle short .17
        mov eax, ecx
        call PickCrossoverAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.17:
        mov eax, ecx
        call PickGlideAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
SkateForwardMove_3E0:
        cmp word [dword ecx+0A9h], byte 0
        jne short SkateForwardMove_41B
        test byte [gmode], 1
        je short SkateForwardMove_41B
        mov edx, dword [dword ecx+0EEh]
        test dword [byte edx+08h], 7FFFFFFFh
        jne short SkateForwardMove_41B
        test dword [byte ecx+038h], 7FFFFFFFh
        jne short SkateForwardMove_41B
        mov eax, ecx
        call PickSkateAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
SkateForwardMove_41B:
        test byte [byte esi+01Ch], 80h
        je short .18
        mov eax, esi
        call EndMove
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.18:
        cmp word [dword ecx+0A9h], byte 0
        jle short .19
        mov edx, dword [puckc]
        xor ebx, ebx
        movsx edx, byte [edx]
        mov bl, byte [dword ecx+0A4h]
        cmp ebx, edx
        je short .20
.19:
        mov edx, dword [dword ecx+0AEh]
        sar edx, 18h
        cmp byte [dword ecx+edx+0B2h], 0Eh
        je short .20
        mov edx, dword [dword ecx+0EEh]
        test byte [byte edx+029h], 2
        je short .21
.20:
        cmp eax, byte 0Ch
        je short .21
        cmp eax, byte 32h
        je short .21
        cmp eax, byte 37h
        je short .21
        mov eax, ecx
        call PickSkateAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.21:
        mov edx, esp
        mov eax, ecx
        call LimitSkateSpeed
        mov edx, esp
        mov eax, esi
        mov ebx, dword [byte esi+02Ch]
        call ApplyMoveMotion
        mov eax, ebx
        call MovePlayer
.22:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
SkateBackwardMoveJumpTable:                     ; jump table for the switch cases of SkateBackwardMove
        dd SkateBackwardMove_377
        dd SkateBackwardMove_51
        dd SkateBackwardMove_345
        dd SkateBackwardMove_41
        dd SkateBackwardMove_3B2
        dd SkateBackwardMove_3B2
        dd SkateBackwardMove_3B2
        dd SkateBackwardMove_31
;-----------------------------------------------------------------------------
; SkateBackwardMove                               633E8  97 PC, low confidence
; Move handler for skating backward
;-----------------------------------------------------------------------------
SkateBackwardMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 80h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov edx, dword [dword ecx+0FAh]
        mov eax, dword [byte edx+01Ch]
        dec eax
        cmp eax, byte 7
        ja near SkateBackwardMove_3B2
        jmp dword [nosplit cs:eax*4+SkateBackwardMoveJumpTable]
SkateBackwardMove_31:
        mov eax, ecx
        call PickBackwardTurn
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
SkateBackwardMove_41:
        mov eax, ecx
        call PickStrideAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
SkateBackwardMove_51:
        mov eax, ecx
        call PuckOnStickPhysics
        mov edi, eax
        mov esi, eax
        mov eax, dword [byte ecx+038h]
        mov dword [byte esp+020h], eax
        mov eax, ecx
        call PuckOnStickPhysics
        mov ebx, dword [nosplit eax*4+MoveFuncPair]
        mov dword [byte esp+014h], eax
        xor eax, eax
        mov al, byte [byte ebx+0Dh]
        mov dword [byte esp+040h], eax
        fild word [byte esp+040h]
        mov eax, dword [byte esp+014h]
        fmul dword [byte esp+020h]
        lea ebx, [nosplit eax*8+00h]
        fstp dword [byte esp+01Ch]
        sub ebx, eax
        fld dword [byte esp+01Ch]
        fadd dword [nosplit ebx*8+SkateStrideTable]
        fld dword [byte ecx+038h]
        fxch
        fstp dword [byte esp+01Ch]
        lea ebx, [nosplit edi*8+00h]
        mov eax, dword [byte esp+01Ch]
        sub ebx, edi
        mov dword [byte esp+028h], eax
        mov eax, dword [dword ecx+0EEh]
        fadd dword [nosplit ebx*8+SkateMoveTable]
        mov ebx, dword [byte eax+08h]
        fstp dword [byte esp+038h]
        cmp ebx, 41400000h
        jge short .1
        fld dword [byte esp+038h]
        fsub dword [byte eax+08h]
        fcomp dword [F32_12_SkateBackwardMove]
        fnstsw ax
        sahf
        jbe short .1
        mov eax, ecx
        call StickHandleTarget
        push eax
        push dword [byte esp+03Ch]
        mov ebx, eax
        call StickHandleSpeed
        mov eax, ebx
        shl ebx, 3
        fstp dword [byte esp+018h]
        sub ebx, eax
        fld dword [byte esp+018h]
        fmul dword [nosplit ebx*8+SkateStrideTable]
        fstp dword [byte esp+018h]
        mov eax, dword [byte esp+018h]
        mov dword [byte esp+030h], eax
        jmp short .2
.1:
        xor edi, edi
        mov dword [byte esp+030h], edi
.2:
        cmp dword [byte ecx+038h], 41400000h
        jge near .14
        fld dword [byte esp+028h]
        fadd dword [byte esp+030h]
        fcomp dword [byte edx+018h]
        fnstsw ax
        sahf
        jb short .3
        mov eax, dword [dword ecx+0EEh]
        cmp dword [byte eax+08h], 41400000h
        jle near .14
        fld dword [byte eax+08h]
        fsub dword [byte ecx+038h]
        fcomp dword [F32_12_SkateBackwardMove]
        fnstsw ax
        sahf
        jbe near .14
.3:
        lea ebx, [nosplit esi*8+00h]
        sub ebx, esi
        mov ah, byte [dword ecx+0D0h]
        shl ebx, 3
        test ah, ah
        je short .4
        fld dword [dword ebx+SkateAnimAccel]
        fchs
        fstp dword [byte esp+034h]
        jmp short .5
.4:
        mov eax, dword [dword ebx+SkateAnimAccel]
        mov dword [byte esp+034h], eax
.5:
        fld dword [byte edx+010h]
        fsub dword [byte esp+034h]
        mov eax, esi
        fstp qword [byte esp+05Ch]
        call IsStopAnim
        test eax, eax
        je short .6
        mov ebx, 5A7ED197h
        mov edi, 400921FBh
        mov dword [byte esp+074h], ebx
        mov dword [byte esp+078h], edi
        jmp short .7
.6:
        mov dword [byte esp+074h], eax
        mov dword [byte esp+078h], eax
.7:
        mov dword [byte edx+08h], 0
        fld qword [byte esp+05Ch]
        mov dword [byte edx+04h], 3F800000h
        lea ebx, [nosplit esi*8+00h]
        mov dword [byte edx+0Ch], 0
        fadd qword [byte esp+074h]
        sub ebx, esi
        fstp dword [byte esp+024h]
        mov eax, dword [nosplit ebx*8+SkateAnimSpeeds]
        mov bl, byte [dword ecx+0D0h]
        mov dword [byte esp+07Ch], eax
        test bl, bl
        je short .8
        fld dword [byte esp+07Ch]
        fchs
        fstp dword [byte esp+07Ch]
.8:
        fld dword [byte esp+07Ch]
        fsub dword [byte ecx+040h]
        fld qword [F64_6p28319_SkateBackwardMove]
        fxch
        call IF@DFMOD
        fst dword [byte esp+07Ch]
        fst qword [byte esp+044h]
        fcomp qword [F64_3p14159_SkateBackwardMove]
        fnstsw ax
        sahf
        jbe short .9
        fld qword [byte esp+044h]
        fadd qword [F64_neg6p28319_SkateBackwardMove]
        fstp dword [byte esp+07Ch]
.9:
        fld dword [byte esp+07Ch]
        fst qword [byte esp+06Ch]
        fcomp qword [F64_neg3p14159_SkateBackwardMove]
        fnstsw ax
        sahf
        jae short .10
        fld qword [byte esp+06Ch]
        fadd qword [F64_6p28319_SkateBackwardMove]
        fstp dword [byte esp+07Ch]
.10:
        fld dword [byte esp+07Ch]
        fabs
        fst dword [byte esp+07Ch]
        fst qword [byte esp+04Ch]
        fcomp qword [F64_1p39626_SkateBackwardMove]
        fnstsw ax
        sahf
        jae short .11
        fld dword [byte ecx+038h]
        fld qword [F64_1p5708_SkateBackwardMove]
        fsub qword [byte esp+04Ch]
        fmulp
        fmul qword [F64_0p63662_SkateBackwardMove]
        fst dword [byte edx+08h]
        fld st0
        fmul qword [F64_0p7_SkateBackwardMove]
        mov eax, dword [byte ecx+040h]
        mov dword [byte edx+034h], eax
        fstp st1
        fstp dword [byte edx+08h]
.11:
        fld dword [byte ecx+01Ch]
        fsubr dword [byte esp+024h]
        fld qword [F64_6p28319_SkateBackwardMove]
        fxch
        call IF@DFMOD
        fst dword [byte edx+0Ch]
        fst qword [byte esp+064h]
        fcomp qword [F64_3p14159_SkateBackwardMove]
        fnstsw ax
        sahf
        jbe short .12
        fld qword [byte esp+064h]
        fadd qword [F64_neg6p28319_SkateBackwardMove]
        fstp dword [byte edx+0Ch]
.12:
        fld dword [byte edx+0Ch]
        fst qword [byte esp+054h]
        fcomp qword [F64_neg3p14159_SkateBackwardMove]
        fnstsw ax
        sahf
        jae short .13
        fld qword [byte esp+054h]
        fadd qword [F64_6p28319_SkateBackwardMove]
        fstp dword [byte edx+0Ch]
.13:
        fld dword [byte edx+0Ch]
        fmul dword [F32_0p1_SkateBackwardMove]
        fstp dword [byte edx+0Ch]
        mov bh, byte [dword ecx+0BFh]
        mov eax, ecx
        and bh, 0DFh
        mov edx, esi
        mov byte [dword ecx+0BFh], bh
        xor ebx, ebx
        push dword 3F333333h
        call SetSPA
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.14:
        mov eax, ecx
        call PickIdleAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
SkateBackwardMove_345:
        cmp dword [byte edx+018h], 43C00000h
        jle short .15
        cmp dword [byte ecx+038h], 40C00000h
        jle short .15
        mov eax, ecx
        call PickCrossoverAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.15:
        mov eax, ecx
        call PickGlideAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
SkateBackwardMove_377:
        cmp word [dword ecx+0A9h], byte 0
        jne short SkateBackwardMove_3B2
        test byte [gmode], 1
        je short SkateBackwardMove_3B2
        mov eax, dword [dword ecx+0EEh]
        test dword [byte eax+08h], 7FFFFFFFh
        jne short SkateBackwardMove_3B2
        test dword [byte ecx+038h], 7FFFFFFFh
        jne short SkateBackwardMove_3B2
        mov eax, ecx
        call PickSkateAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
SkateBackwardMove_3B2:
        test byte [byte ebx+01Ch], 80h
        je short .16
        mov eax, ebx
        call EndMove
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.16:
        cmp word [dword ecx+0A9h], byte 0
        jle short .17
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        je short .18
.17:
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        je short .18
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 2
        je short .19
.18:
        mov eax, dword [byte ebx+028h]
        and eax, 0FFFFh
        cmp eax, byte 38h
        je short .19
        mov eax, dword [byte ebx+02Ch]
        fild dword [byte ebx+01Ch]
        mov ecx, dword [byte ebx+04h]
        mov ebx, dword [dword eax+0FAh]
        mov ebx, dword [byte ebx+038h]
        mov edx, 38h
        mov dword [byte esp+03Ch], ebx
        mov bh, byte [dword eax+0BFh]
        fstp dword [byte esp+02Ch]
        test bh, 20h
        setne bl
        and ebx, 0FFh
        fld dword [byte esp+02Ch]
        push ebx
        call __CHP
        push ecx
        fistp dword [byte esp+028h]
        mov ebx, dword [byte esp+028h]
        push dword [byte esp+044h]
        call StartNextMove
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.19:
        mov edx, esp
        mov eax, ecx
        call LimitSkateSpeed
        mov edx, esp
        mov eax, ebx
        mov ecx, dword [byte ebx+02Ch]
        call ApplyMoveMotion
        mov eax, ecx
        call MovePlayer
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; TurnLeanAngle                                   63878  97 PC, low confidence
; Works out the lean angle for a turn
;-----------------------------------------------------------------------------
TurnLeanAngle:
        push ebx
        push ecx
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov ecx, edx
        mov edx, dword [dword eax+0FAh]
        mov eax, dword [byte eax+038h]
        mov dword [byte esp+010h], eax
        call SpeedScale
        fdivr dword [byte ebx+038h]
        fmul qword [F64_1p33_TurnLeanAngle]
        fsubr qword [F64_2_TurnLeanAngle]
        fmul qword [F64_0p125664]
        fldz
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte edx+014h]
        fnstsw ax
        sahf
        ja short .3
        fld dword [byte edx+014h]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jbe short .1
        mov eax, dword [byte esp+0Ch]
        jmp short .2
.1:
        mov eax, dword [byte edx+014h]
.2:
        mov dword [byte esp+08h], eax
        mov eax, dword [byte esp+08h]
        jmp short .6
.3:
        fld dword [byte edx+014h]
        fld dword [byte esp+0Ch]
        fchs
        fstp dword [esp]
        fcomp dword [esp]
        fnstsw ax
        sahf
        jae short .4
        mov eax, dword [esp]
        jmp short .5
.4:
        mov eax, dword [byte edx+014h]
.5:
        mov dword [byte esp+04h], eax
        mov eax, dword [byte esp+04h]
.6:
        mov dword [byte ecx+04h], eax
        mov eax, dword [dword ebx+0EEh]
        test byte [byte eax+031h], 8
        je short .7
        mov dword [ecx], 40490FDBh
.7:
        mov eax, dword [dword ebx+0EEh]
        cmp dword [byte eax+08h], 41400000h
        jge short .9
        fld dword [byte eax+08h]
        fcomp dword [byte ebx+038h]
        fnstsw ax
        sahf
        jae short .9
        mov edi, dword [byte edx+018h]
        cmp edi, 43700000h
        jle short .8
        cmp word [dword ebx+0A9h], byte 0
        jne short .9
        cmp edi, 44700000h
        jge short .9
.8:
        fld dword [byte esp+010h]
        fadd qword [F64_neg3p75]
        fldz
        fxch
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        jbe short .9
        xor edx, edx
        mov dword [byte esp+010h], edx
.9:
        mov eax, dword [byte esp+010h]
        mov dword [byte ecx+08h], eax
        mov esp, ebp
        pop ebp
        pop edi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; TurnStickPos                                    63980  97 PC, low confidence
; Places the stick during a turn
;-----------------------------------------------------------------------------
TurnStickPos:
        push ebx
        push ecx
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov ebx, dword [dword eax+0FAh]
        mov ecx, dword [byte eax+038h]
        call GetStickBladePos
        fldz
        fxch
        fstp dword [byte esp+08h]
        mov dword [byte esp+010h], ecx
        fcomp dword [byte ebx+018h]
        fnstsw ax
        sahf
        jae near .3
        cmp dword [byte ebx+018h], 44700000h
        jle short .1
        fld dword [byte esp+010h]
        fcomp dword [byte esp+08h]
        fnstsw ax
        sahf
        jae short .1
        fld dword [byte esp+010h]
        fld st0
        fadd qword [F64_2p5_TurnStickPos]
        fstp st1
        fst dword [byte esp+010h]
        fcomp dword [byte esp+08h]
        fnstsw ax
        sahf
        jbe short .3
        mov eax, dword [byte esp+08h]
        mov dword [byte esp+010h], eax
        jmp short .3
.1:
        cmp dword [byte ebx+018h], 43700000h
        jg short .2
        fld dword [byte esp+010h]
        fadd qword [F64_neg3p75_TurnStickPos]
        fldz
        fxch
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        jbe short .3
        xor edi, edi
        mov dword [byte esp+010h], edi
        jmp short .3
.2:
        fld dword [byte esp+010h]
        fld st0
        fadd qword [F64_0p2_TurnStickPos]
        fstp st1
        fstp dword [byte esp+010h]
.3:
        fldz
        fcomp dword [byte edx+08h]
        fnstsw ax
        sahf
        jae short .6
        fld dword [byte esp+010h]
        fdiv dword [byte edx+08h]
        fsubr qword [F64_2_TurnStickPos]
        fst dword [byte esp+0Ch]
        fcomp dword [F32_2_TurnStickPos]
        fnstsw ax
        sahf
        jbe short .4
        mov dword [byte esp+0Ch], 40000000h
.4:
        fld dword [byte esp+0Ch]
        fcomp dword [F32_neg0p5]
        fnstsw ax
        sahf
        jae short .5
        mov dword [byte esp+0Ch], 3F000000h
.5:
        fld dword [byte edx+04h]
        fmul dword [byte esp+0Ch]
        fstp dword [byte edx+04h]
.6:
        mov eax, dword [byte esp+010h]
        mov dword [byte edx+08h], eax
        mov esp, ebp
        pop ebp
        pop edi
        pop ecx
        pop ebx
        ret
TurnForwardMoveJumpTable:                       ; jump table for the switch cases of TurnForwardMove
        dd TurnForwardMove_51
        dd TurnForwardMove_61
        dd TurnForwardMove_71
        dd TurnForwardMove_41
        dd TurnForwardMove_C2
        dd TurnForwardMove_BC
        dd TurnForwardMove_31
;-----------------------------------------------------------------------------
; TurnForwardMove                                 63AA4  97 PC, low confidence
; Move handler for turning while skating forward
;-----------------------------------------------------------------------------
TurnForwardMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 20h
        mov esi, eax
        mov ecx, dword [byte eax+02Ch]
        mov edi, dword [byte eax+028h]
        mov eax, dword [dword ecx+0FAh]
        mov eax, dword [byte eax+01Ch]
        dec eax
        and edi, 0FFFFh
        cmp eax, byte 6
        ja near TurnForwardMove_BC
        jmp dword [nosplit cs:eax*4+TurnForwardMoveJumpTable]
TurnForwardMove_31:
        mov eax, ecx
        call PickForwardTurn
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
TurnForwardMove_41:
        mov eax, ecx
        call PickStrideAnim
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
TurnForwardMove_51:
        mov eax, ecx
        call PickSkateAnim
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
TurnForwardMove_61:
        mov eax, ecx
        call PickIdleAnim
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
TurnForwardMove_71:
        cmp dword [byte ecx+038h], 40C00000h
        jge short .1
        mov eax, ecx
        call PickGlideAnim
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        cmp edi, byte 9
        je short .2
        cmp edi, byte 0Ah
        je short .2
        cmp edi, 111h
        jl short .3
        cmp edi, 114h
        jg short .3
.2:
        mov eax, ecx
        call PickTurnAnim
        jmp short .4
.3:
        mov eax, ecx
        call PickStopAnim
.4:
        test eax, eax
        jne near TurnForwardMove_C2.15
TurnForwardMove_BC:
        test byte [byte esi+01Ch], 80h
        je short TurnForwardMove_C2.5
TurnForwardMove_C2:
        mov eax, esi
        call EndMove
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        cmp word [dword ecx+0A9h], byte 0
        jle short .6
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        je short .7
.6:
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        je short .7
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+029h], 2
        je near .10
.7:
        cmp edi, byte 7
        jb near .10
        jbe short .8
        cmp edi, byte 8
        je short .9
        jmp near .10
.8:
        mov eax, dword [byte esi+02Ch]
        mov ebx, dword [dword eax+0FAh]
        fild dword [byte esi+01Ch]
        mov edx, 35h
        mov ebx, dword [byte ebx+038h]
        fstp dword [byte esp+018h]
        mov dword [byte esp+01Ch], ebx
        mov bh, byte [dword eax+0BFh]
        mov ecx, dword [byte esi+04h]
        test bh, 20h
        setne bl
        and ebx, 0FFh
        fld dword [byte esp+018h]
        push ebx
        call __CHP
        push ecx
        fistp dword [byte esp+014h]
        mov ebx, dword [byte esp+014h]
        push dword [byte esp+024h]
        call StartNextMove
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov eax, dword [byte esi+02Ch]
        mov ebx, dword [dword eax+0FAh]
        fild dword [byte esi+01Ch]
        mov edx, 36h
        mov ebx, dword [byte ebx+038h]
        fstp dword [byte esp+010h]
        mov dword [byte esp+014h], ebx
        mov bh, byte [dword eax+0BFh]
        mov ecx, dword [byte esi+04h]
        test bh, 20h
        setne bl
        and ebx, 0FFh
        fld dword [byte esp+010h]
        push ebx
        call __CHP
        push ecx
        fistp dword [byte esp+014h]
        mov ebx, dword [byte esp+014h]
        push dword [byte esp+01Ch]
        call StartNextMove
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        mov eax, dword [byte esi+02Ch]
        mov edx, dword [dword eax+0F2h]
        mov ebx, esp
        mov eax, esi
        mov edx, dword [byte edx+054h]
        call UpdateMovePose
        mov ebx, dword [byte esi+010h]
        cmp ebx, 3F800000h
        je short .11
        test ebx, 7FFFFFFFh
        je short .11
        fld dword [esp]
        fdiv dword [byte esi+010h]
        fld dword [byte esp+04h]
        fxch
        fstp dword [esp]
        fdiv dword [byte esi+010h]
        fld dword [byte esp+08h]
        fxch
        fstp dword [byte esp+04h]
        fdiv dword [byte esi+010h]
        fstp dword [byte esp+08h]
.11:
        cmp word [dword ecx+0A9h], byte 0
        je short .12
        cmp edi, byte 7
        je short .12
        cmp edi, byte 8
        je short .12
        cmp edi, byte 35h
        je short .12
        cmp edi, byte 36h
        je short .12
        cmp edi, 10Bh
        jl short .13
        cmp edi, 10Eh
        jg short .13
.12:
        mov edx, esp
        mov eax, ecx
        call TurnLeanAngle
        jmp short .14
.13:
        mov edx, esp
        mov eax, ecx
        call TurnStickPos
.14:
        mov edx, esp
        mov eax, esi
        mov ecx, dword [byte esi+02Ch]
        call ApplyMoveMotion
        mov eax, ecx
        call MovePlayer
.15:
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StopSkidDistance                                63D24  97 PC, low confidence
; Works out how far a stopping player skids
;-----------------------------------------------------------------------------
StopSkidDistance:
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 38h
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov edi, ebx
        mov edx, ecx
        mov ebx, dword [dword eax+0FAh]
        fld dword [byte ebx+014h]
        fabs
        fcomp qword [F64_2p82743_StopSkidDistance]
        fnstsw ax
        sahf
        ja near .9
        test byte [byte ebx+031h], 8
        jne near .9
        mov eax, dword [dword esi+0EEh]
        test byte [byte eax+029h], 1
        jne near .9
        fld dword [byte eax+04h]
        fsub dword [byte esi+028h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [eax]
        fsub dword [byte esi+020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        mov eax, edi
        fstp dword [byte esp+0Ch]
        call GetStopTable
        fst dword [byte esp+08h]
        fcomp dword [F32_4_StopSkidDistance]
        fnstsw ax
        sahf
        jb near .9
        fld dword [byte esp+0Ch]
        fdiv dword [byte esp+08h]
        mov eax, dword [byte ebx+04h]
        mov dword [byte esp+030h], eax
        fsub dword [byte esp+030h]
        fldz
        fxch
        fstp dword [byte esp+034h]
        fcomp dword [byte esp+034h]
        fnstsw ax
        sahf
        ja short .3
        fld dword [byte esp+034h]
        fst qword [byte esp+018h]
        fcomp qword [F64_0p1_StopSkidDistance]
        fnstsw ax
        sahf
        jbe short .1
        mov esi, 9999999Ah
        mov edi, 3FB99999h
        mov dword [byte esp+020h], esi
        mov dword [byte esp+024h], edi
        jmp short .2
.1:
        mov eax, dword [byte esp+018h]
        mov dword [byte esp+020h], eax
        mov eax, dword [byte esp+01Ch]
        mov dword [byte esp+024h], eax
.2:
        fld dword [byte esp+030h]
        fld st0
        fadd qword [byte esp+020h]
        jmp short .6
.3:
        fld dword [byte esp+034h]
        fst qword [byte esp+010h]
        fcomp qword [F64_neg0p1_StopSkidDistance]
        fnstsw ax
        sahf
        jae short .4
        mov edx, 9999999Ah
        mov ecx, 0BFB99999h
        mov dword [byte esp+028h], edx
        mov dword [byte esp+02Ch], ecx
        jmp short .5
.4:
        mov eax, dword [byte esp+010h]
        mov dword [byte esp+028h], eax
        mov eax, dword [byte esp+014h]
        mov dword [byte esp+02Ch], eax
.5:
        fld dword [byte esp+030h]
        fld st0
        fadd qword [byte esp+028h]
.6:
        fstp st1
        fstp dword [byte esp+030h]
        fld dword [byte esp+030h]
        fcomp qword [F64_1p2_StopSkidDistance]
        fnstsw ax
        sahf
        jbe short .7
        mov dword [byte esp+030h], 3F99999Ah
.7:
        fld dword [byte esp+030h]
        fcomp qword [F64_0p2_StopSkidDistance]
        fnstsw ax
        sahf
        jae short .8
        mov dword [byte esp+030h], 3E4CCCCDh
.8:
        mov eax, dword [byte esp+030h]
        mov dword [byte ebx+04h], eax
.9:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; StopForwardMove                                 63E8C  97 PC, low confidence
; Move handler for stopping from forward skating (plays the skid sound)
;-----------------------------------------------------------------------------
StopForwardMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 24h
        mov esi, eax
        mov ecx, dword [byte eax+028h]
        mov edi, dword [byte eax+02Ch]
        and ecx, 0FFFFh
        mov eax, dword [dword edi+0FAh]
        mov dx, word [dword edi+0A9h]
        mov dword [byte ebp-08h], eax
        test dx, dx
        jle near .4
        mov eax, dword [byte eax+01Ch]
        cmp eax, byte 1
        jbe near .4
        cmp eax, byte 4
        jb short .1
        cmp eax, byte 5
        jbe short .4
.1:
        mov eax, dword [byte ebp-08h]
        fld dword [byte eax+010h]
        fsub dword [byte edi+040h]
        fld qword [F64_6p28319_StopForwardMove]
        fxch
        call IF@DFMOD
        fst dword [byte ebp-04h]
        fst qword [byte ebp-010h]
        fcomp qword [F64_3p14159_StopForwardMove]
        fnstsw ax
        sahf
        jbe short .2
        fld qword [byte ebp-010h]
        fadd qword [F64_neg6p28319_StopForwardMove]
        fstp dword [byte ebp-04h]
.2:
        fld dword [byte ebp-04h]
        fst qword [byte ebp-018h]
        fcomp qword [F64_neg3p14159_StopForwardMove]
        fnstsw ax
        sahf
        jae short .3
        fld qword [byte ebp-018h]
        fadd qword [F64_6p28319_StopForwardMove]
        fstp dword [byte ebp-04h]
.3:
        fld dword [byte ebp-04h]
        fabs
        fcomp qword [F64_1p5708_StopForwardMove]
        fnstsw ax
        sahf
        ja short .4
        mov eax, edi
        call PickSkateAnim
        jmp near .16
.4:
        test byte [byte esi+01Ch], 80h
        je short .5
        mov eax, edi
        mov dword [byte edi+038h], 0
        call PickSkateAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov edx, dword [byte esi+02Ch]
        mov edx, dword [dword edx+0F2h]
        lea ebx, [byte ebp-024h]
        mov eax, esi
        mov edx, dword [byte edx+054h]
        call UpdateMovePose
        mov edx, dword [byte esi+010h]
        cmp edx, 3F800000h
        je short .6
        test edx, 7FFFFFFFh
        je short .6
        fld dword [byte ebp-024h]
        fdiv dword [byte esi+010h]
        fld dword [byte ebp-020h]
        fxch
        fstp dword [byte ebp-024h]
        fdiv dword [byte esi+010h]
        fld dword [byte ebp-01Ch]
        fxch
        fstp dword [byte ebp-020h]
        fdiv dword [byte esi+010h]
        fstp dword [byte ebp-01Ch]
.6:
        lea edx, [byte ebp-024h]
        mov eax, edi
        mov ebx, dword [byte esi+04h]
        call StopSkidDistance
        mov eax, dword [byte ebp-08h]
        push dword [byte eax+04h]
        mov eax, esi
        call ScaleAnimTime
        cmp dword [byte esi+04h], byte 0Ah
        jne short .7
        mov eax, dword [byte ebp-08h]
        mov dword [byte eax+0Ch], 0
.7:
        cmp dword [byte esi+04h], byte 2
        jne near .15
        cmp word [dword edi+0A9h], byte 0
        jne short .10
        mov eax, dword [puckc]
        xor edx, edx
        push dword [byte edi+028h]
        mov dl, byte [dword edi+0A4h]
        movsx eax, byte [eax]
        push dword [byte edi+020h]
        cmp edx, eax
        jne short .8
        mov edx, 55h
        jmp short .9
.8:
        mov edx, 0Ch
.9:
        mov eax, 430h
        jmp short .14
.10:
        mov eax, dword [puckc]
        xor edx, edx
        push dword [byte edi+028h]
        mov dl, byte [dword edi+0A4h]
        movsx eax, byte [eax]
        push dword [byte edi+020h]
        cmp edx, eax
        je short .11
        cmp dl, 0Ch
        jne short .12
.11:
        mov edx, 55h
        jmp short .13
.12:
        mov edx, 0Ch
.13:
        mov eax, 4
        call randomd0
        cwde
        add eax, 431h
.14:
        call PlaySfxVolume
.15:
        lea edx, [byte ebp-024h]
        mov eax, esi
        mov edi, dword [byte esi+02Ch]
        call ApplyMoveMotion
        mov eax, edi
        call MovePlayer
.16:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        sub esp, byte 8
        mov ebx, edx
        mov edx, dword [dword eax+0FAh]
        fldz
        fcomp dword [byte edx+014h]
        fnstsw ax
        sahf
        ja short .19
        mov ecx, dword [byte edx+014h]
        cmp ecx, 3E00ADFDh
        jle short .17
        mov dword [byte esp+04h], 3E00ADFDh
        jmp short .18
.17:
        mov dword [byte esp+04h], ecx
.18:
        mov eax, dword [byte esp+04h]
        jmp short .22
.19:
        fld dword [byte edx+014h]
        fcomp dword [F32_neg0p125664]
        fnstsw ax
        sahf
        jae short .20
        mov dword [esp], 0BE00ADFDh
        jmp short .21
.20:
        mov eax, dword [byte edx+014h]
        mov dword [esp], eax
.21:
        mov eax, dword [esp]
.22:
        mov dword [byte ebx+04h], eax
        add esp, byte 8
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; StandMove                                       640D0  97 PC, low confidence
; Move handler for standing in place
;-----------------------------------------------------------------------------
StandMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 18h
        mov ecx, eax
        mov esi, dword [byte eax+02Ch]
        mov edx, dword [byte eax+028h]
        mov eax, dword [dword esi+0FAh]
        mov ebx, dword [byte eax+01Ch]
        and edx, 0FFFFh
        cmp ebx, byte 2
        jb near .6
        jbe short .1
        cmp ebx, byte 3
        je short .2
        jmp near .6
.1:
        mov eax, esi
        call PickIdleAnim
        jmp near .16
.2:
        mov dword [byte eax+08h], 0
        mov dword [byte eax+04h], 3F800000h
        mov dword [byte eax+0Ch], 0
        mov ebx, dword [byte eax+014h]
        mov ah, byte [dword esi+0D0h]
        mov dword [byte esp+0Ch], ebx
        test ah, ah
        setne al
        xor ebx, ebx
        fldz
        mov bl, al
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor eax, ebx
        je short .4
        cmp edx, byte 1Fh
        je short .3
        cmp edx, byte 1Dh
        je short .3
        cmp edx, 121h
        je short .3
        cmp edx, 122h
        je short .3
        cmp edx, 125h
        je short .3
        cmp edx, 126h
        jne short .7
.3:
        mov eax, esi
        call PickGlideAnim
        add esp, byte 18h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        cmp edx, byte 1Eh
        je short .5
        cmp edx, byte 1Ch
        je short .5
        cmp edx, 11Fh
        je short .5
        cmp edx, 120h
        je short .5
        cmp edx, 123h
        je short .5
        cmp edx, 124h
        jne short .7
.5:
        mov eax, esi
        call PickGlideAnim
        add esp, byte 18h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        mov eax, esi
        call PickSkateAnim
        add esp, byte 18h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        test byte [byte ecx+01Ch], 80h
        je short .8
        mov eax, ecx
        call EndMove
        add esp, byte 18h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        mov edx, dword [byte ecx+02Ch]
        mov edx, dword [dword edx+0F2h]
        mov ebx, esp
        mov eax, ecx
        mov edx, dword [byte edx+054h]
        call UpdateMovePose
        mov edx, dword [byte ecx+010h]
        cmp edx, 3F800000h
        je short .9
        test edx, 7FFFFFFFh
        je short .9
        fld dword [esp]
        fdiv dword [byte ecx+010h]
        fld dword [byte esp+04h]
        fxch
        fstp dword [esp]
        fdiv dword [byte ecx+010h]
        fld dword [byte esp+08h]
        fxch
        fstp dword [byte esp+04h]
        fdiv dword [byte ecx+010h]
        fstp dword [byte esp+08h]
.9:
        mov edx, dword [dword esi+0FAh]
        fldz
        mov ebx, esp
        fcomp dword [byte edx+014h]
        fnstsw ax
        sahf
        ja short .12
        mov edi, dword [byte edx+014h]
        cmp edi, 3E00ADFDh
        jle short .10
        mov dword [byte esp+010h], 3E00ADFDh
        jmp short .11
.10:
        mov dword [byte esp+010h], edi
.11:
        mov eax, dword [byte esp+010h]
        jmp short .15
.12:
        fld dword [byte edx+014h]
        fcomp dword [F32_neg0p125664_StandMove]
        fnstsw ax
        sahf
        jae short .13
        mov dword [byte esp+014h], 0BE00ADFDh
        jmp short .14
.13:
        mov eax, dword [byte edx+014h]
        mov dword [byte esp+014h], eax
.14:
        mov eax, dword [byte esp+014h]
.15:
        mov dword [byte ebx+04h], eax
        mov edx, esp
        mov eax, ecx
        mov ebx, dword [byte ecx+02Ch]
        call ApplyMoveMotion
        mov eax, ebx
        call MovePlayer
.16:
        add esp, byte 18h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SpeedTowardSpot                                 642A8  97 PC, low confidence
; Works out the speed to reach a spot
;-----------------------------------------------------------------------------
SpeedTowardSpot:
        push ebx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 20h
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        mov ebx, dword [dword eax+0FAh]
        test dword [byte ebx+08h], 7FFFFFFFh
        je near .3
        cmp dword [byte ebx+034h], 461C4000h
        jge near .3
        mov edi, esp
        lea esi, [byte esp+04h]
        lea eax, [byte ebx+034h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte ebx+08h]
        fmul dword [byte esp+04h]
        fld dword [byte ebx+08h]
        fmul dword [esp]
        mov edi, esp
        lea esi, [byte esp+04h]
        lea eax, [byte edx+040h]
        fxch
        fstp dword [byte esp+01Ch]
        fstp dword [byte esp+018h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte edx+038h]
        fmul dword [byte esp+04h]
        fld dword [byte edx+038h]
        fmul dword [esp]
        fxch
        fadd dword [byte esp+01Ch]
        fxch
        fadd dword [byte esp+018h]
        fxch
        fstp dword [byte esp+01Ch]
        fst dword [byte esp+018h]
        fld dword [byte esp+01Ch]
        call IF@ATAN2
        fld qword [F64_6p28319_SpeedTowardSpot]
        fxch
        call IF@DFMOD
        fst dword [byte edx+040h]
        fst qword [byte esp+08h]
        fcomp qword [F64_3p14159_SpeedTowardSpot]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+08h]
        fadd qword [F64_neg6p28319_SpeedTowardSpot]
        fstp dword [byte edx+040h]
.1:
        fld dword [byte edx+040h]
        fst qword [byte esp+010h]
        fcomp qword [F64_neg3p14159_SpeedTowardSpot]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+010h]
        fadd qword [F64_6p28319_SpeedTowardSpot]
        fstp dword [byte edx+040h]
.2:
        fld dword [byte esp+018h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+024h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fstp dword [byte edx+038h]
.3:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; StartMoveAtSpeed                                643AC  97 PC, low confidence
; Starts the next move at the player's speed
;-----------------------------------------------------------------------------
StartMoveAtSpeed:
        push ebx
        push ecx
        mov ebx, edx
        mov edx, dword [dword eax+0FAh]
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov ecx, dword [byte eax+04h]
        mov eax, dword [byte eax+028h]
        and eax, 0FFFFh
        cmp eax, byte 3
        je short .1
        cmp eax, byte 3Bh
        jne short .2
.1:
        mov dword [byte ebx+04h], 0
.2:
        cmp ecx, byte 0Ah
        jge short .3
        test dword [byte edx+0Ch], 7FFFFFFFh
        je short .4
        fldz
        fldz
        xor ecx, ecx
        fxch
        fcomp dword [byte edx+0Ch]
        fnstsw ax
        sahf
        setb al
        mov cl, al
        fcomp dword [byte edx+014h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor ecx, eax
        jne short .3
        fld dword [byte edx+0Ch]
        fabs
        fld dword [byte edx+014h]
        fabs
        fcompp
        fnstsw ax
        sahf
        jae short .4
        fld dword [byte edx+014h]
        fadd dword [byte ebx+04h]
        fstp dword [byte ebx+04h]
        mov dword [byte edx+0Ch], ecx
        pop ecx
        pop ebx
        ret
.3:
        mov dword [byte edx+0Ch], 0
.4:
        pop ecx
        pop ebx
        ret
        db 090h
        push ebx
        push ecx
        sub esp, byte 0Ch
        mov ebx, eax
        mov eax, dword [byte eax+02Ch]
        fild dword [byte ebx+01Ch]
        mov ecx, dword [byte ebx+04h]
        mov ebx, dword [dword eax+0FAh]
        mov ebx, dword [byte ebx+038h]
        mov dword [byte esp+04h], ebx
        mov bh, byte [dword eax+0BFh]
        fstp dword [byte esp+08h]
        test bh, 20h
        setne bl
        and ebx, 0FFh
        fld dword [byte esp+08h]
        push ebx
        call __CHP
        push ecx
        fistp dword [byte esp+08h]
        mov ebx, dword [byte esp+08h]
        push dword [byte esp+0Ch]
        call StartNextMove
        add esp, byte 0Ch
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CrossoverMove                                   64490  97 PC, low confidence
; Move handler for crossovers
;-----------------------------------------------------------------------------
CrossoverMove:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 28h
        mov ecx, eax
        mov eax, dword [byte eax+028h]
        mov esi, dword [byte ecx+02Ch]
        and eax, 0FFFFh
        mov ebx, dword [dword esi+0FAh]
        cmp eax, byte 23h
        je short .1
        cmp eax, 11Bh
        je short .1
        cmp eax, byte 3Ch
        je short .1
        cmp eax, 11Ch
        jne short .4
.1:
        cmp dword [byte ecx+04h], byte 18h
        jl short .4
        mov edx, dword [byte ebx+01Ch]
        cmp edx, byte 1
        jb short .4
        jbe short .3
        cmp edx, byte 4
        jne short .4
.2:
        mov eax, esi
        call PickStrideAnim
        jmp near .16
.3:
        mov eax, esi
        call PickSkateAnim
        jmp near .16
.4:
        test byte [byte ecx+01Ch], 80h
        je short .8
        mov eax, dword [byte ebx+01Ch]
        cmp eax, byte 3
        jb short .5
        jbe short .6
        cmp eax, byte 4
        je short .2
        jmp short .7
.5:
        cmp eax, byte 1
        je short .3
        jmp short .7
.6:
        mov eax, esi
        call PickCrossoverAnim
        add esp, byte 28h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        mov eax, esi
        call PickIdleAnim
        add esp, byte 28h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        cmp word [dword esi+0A9h], byte 0
        jle short .9
        mov edx, dword [puckc]
        xor ebx, ebx
        movsx edx, byte [edx]
        mov bl, byte [dword esi+0A4h]
        cmp ebx, edx
        je short .10
.9:
        mov edx, dword [dword esi+0AEh]
        sar edx, 18h
        cmp byte [dword edx+esi+0B2h], 0Eh
        je short .10
        mov edx, dword [dword esi+0EEh]
        test byte [byte edx+029h], 2
        je near .14
.10:
        cmp eax, byte 23h
        jb short .11
        jbe short .12
        cmp eax, byte 24h
        je near .13
        jmp near .14
.11:
        cmp eax, byte 3
        jne near .14
        mov eax, dword [byte ecx+02Ch]
        mov ebx, dword [dword eax+0FAh]
        fild dword [byte ecx+01Ch]
        mov edx, 3Bh
        mov ebx, dword [byte ebx+038h]
        fstp dword [byte esp+01Ch]
        mov dword [byte esp+010h], ebx
        mov bh, byte [dword eax+0BFh]
        mov esi, dword [byte ecx+04h]
        test bh, 20h
        setne bl
        and ebx, 0FFh
        fld dword [byte esp+01Ch]
        push ebx
        call __CHP
        push esi
        fistp dword [byte esp+014h]
        mov ebx, dword [byte esp+014h]
        push dword [byte esp+018h]
        call StartNextMove
        add esp, byte 28h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.12:
        mov eax, dword [byte ecx+02Ch]
        fild dword [byte ecx+01Ch]
        mov edx, 3Ch
        mov ebx, dword [dword eax+0FAh]
        fstp dword [byte esp+024h]
        mov esi, dword [byte ecx+04h]
        mov ebx, dword [byte ebx+038h]
        mov ch, byte [dword eax+0BFh]
        mov dword [byte esp+020h], ebx
        test ch, 20h
        setne bl
        and ebx, 0FFh
        fld dword [byte esp+024h]
        push ebx
        call __CHP
        push esi
        fistp dword [byte esp+014h]
        mov ebx, dword [byte esp+014h]
        push dword [byte esp+028h]
        call StartNextMove
        add esp, byte 28h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.13:
        mov eax, dword [byte ecx+02Ch]
        fild dword [byte ecx+01Ch]
        mov edx, 3Dh
        mov ebx, dword [dword eax+0FAh]
        fstp dword [byte esp+014h]
        mov esi, dword [byte ecx+04h]
        mov ebx, dword [byte ebx+038h]
        mov cl, byte [dword eax+0BFh]
        mov dword [byte esp+018h], ebx
        test cl, 20h
        setne bl
        and ebx, 0FFh
        fld dword [byte esp+014h]
        push ebx
        call __CHP
        push esi
        fistp dword [byte esp+014h]
        mov ebx, dword [byte esp+014h]
        push dword [byte esp+020h]
        call StartNextMove
        add esp, byte 28h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.14:
        mov eax, dword [byte ecx+02Ch]
        mov edx, dword [dword eax+0F2h]
        mov ebx, esp
        mov eax, ecx
        mov edx, dword [byte edx+054h]
        call UpdateMovePose
        mov ebx, dword [byte ecx+010h]
        cmp ebx, 3F800000h
        je short .15
        test ebx, 7FFFFFFFh
        je short .15
        fld dword [esp]
        fdiv dword [byte ecx+010h]
        fld dword [byte esp+04h]
        fxch
        fstp dword [esp]
        fdiv dword [byte ecx+010h]
        fld dword [byte esp+08h]
        fxch
        fstp dword [byte esp+04h]
        fdiv dword [byte ecx+010h]
        fstp dword [byte esp+08h]
.15:
        mov edx, esp
        mov eax, esi
        call StartMoveAtSpeed
        mov edx, esp
        mov eax, ecx
        call ApplyMoveMotion
        mov eax, esi
        call SpeedTowardSpot
        mov eax, esi
        call MovePlayer
.16:
        add esp, byte 28h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; GoalieSlideMove                                 64700  97 PC, low confidence
; Move handler for the goalie sliding across the crease
;-----------------------------------------------------------------------------
GoalieSlideMove:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        mov esi, eax
        mov ecx, dword [byte eax+02Ch]
        test byte [byte eax+01Ch], 80h
        je near .5
        mov edx, dword [dword ecx+0EEh]
        mov bl, byte [byte edx+031h]
        or bl, 8
        mov eax, ecx
        mov byte [byte edx+031h], bl
        call GoalieAI
        mov edx, dword [dword ecx+0FAh]
        mov dword [byte edx+08h], 0
        mov dword [byte edx+04h], 3F800000h
        mov dword [byte edx+0Ch], 0
        mov bh, byte [dword ecx+0BFh]
        push dword 3F800000h
        and bh, 0DFh
        mov dx, word [dword ecx+0A9h]
        mov byte [dword ecx+0BFh], bh
        mov ebx, 20h
        test dx, dx
        jle short .1
        mov edx, dword [puckc]
        movzx esi, byte [dword ecx+0A4h]
        movsx edx, byte [edx]
        cmp esi, edx
        je short .2
.1:
        mov edx, dword [dword ecx+0AEh]
        sar edx, 18h
        cmp byte [dword ecx+edx+0B2h], 0Eh
        je short .2
        mov edx, dword [dword ecx+0EEh]
        test byte [byte edx+029h], 2
        je short .3
.2:
        mov edx, 38h
        jmp short .4
.3:
        mov edx, 11h
.4:
        mov eax, ecx
        call SetSPA
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov edx, dword [dword ecx+0F2h]
        lea ebx, [byte ebp-0Ch]
        mov eax, esi
        mov edx, dword [byte edx+054h]
        call UpdateMovePose
        mov edx, dword [byte esi+010h]
        cmp edx, 3F800000h
        je short .6
        test edx, 7FFFFFFFh
        je short .6
        fld dword [byte ebp-0Ch]
        fdiv dword [byte esi+010h]
        fld dword [byte ebp-08h]
        fxch
        fstp dword [byte ebp-0Ch]
        fdiv dword [byte esi+010h]
        fld dword [byte ebp-04h]
        fxch
        fstp dword [byte ebp-08h]
        fdiv dword [byte esi+010h]
        fstp dword [byte ebp-04h]
.6:
        lea edx, [byte ebp-0Ch]
        mov eax, esi
        mov ebx, dword [byte esi+02Ch]
        call ApplyMoveMotion
        mov eax, ebx
        call MovePlayer
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; GoalieStanceMove                                64820  97 PC, low confidence
; Move handler for the goalie stance
;-----------------------------------------------------------------------------
GoalieStanceMove:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ecx, eax
        mov edx, dword [byte eax+02Ch]
        test byte [byte eax+01Ch], 80h
        je short .1
        mov ecx, dword [dword edx+0EEh]
        mov bl, byte [byte ecx+031h]
        and bl, 0F7h
        mov eax, edx
        mov byte [byte ecx+031h], bl
        call GoalieAI
        mov eax, edx
        call PickSkateAnim
        jmp short .3
.1:
        mov edx, dword [dword edx+0F2h]
        mov ebx, esp
        mov eax, ecx
        mov edx, dword [byte edx+054h]
        call UpdateMovePose
        mov edx, dword [byte ecx+010h]
        cmp edx, 3F800000h
        je short .2
        test edx, 7FFFFFFFh
        je short .2
        fld dword [esp]
        fdiv dword [byte ecx+010h]
        fld dword [byte esp+04h]
        fxch
        fstp dword [esp]
        fdiv dword [byte ecx+010h]
        fld dword [byte esp+08h]
        fxch
        fstp dword [byte esp+04h]
        fdiv dword [byte ecx+010h]
        fstp dword [byte esp+08h]
.2:
        mov edx, esp
        mov eax, ecx
        mov ebx, dword [byte ecx+02Ch]
        call ApplyMoveMotion
        mov eax, ebx
        call MovePlayer
.3:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SlowSkateMove                                   648B4  97 PC, low confidence
; Move handler for slow skating
;-----------------------------------------------------------------------------
SlowSkateMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov ecx, eax
        mov eax, dword [byte eax+028h]
        mov esi, dword [byte ecx+02Ch]
        and eax, 0FFFFh
        mov edx, dword [dword esi+0FAh]
        cmp eax, byte 1Ah
        je short .1
        cmp eax, 139h
        je short .1
        cmp eax, 13Ah
        jne short .4
.1:
        cmp dword [byte ecx+04h], byte 18h
        jl short .4
        mov eax, dword [byte edx+01Ch]
        cmp eax, byte 1
        jb short .4
        jbe short .3
        cmp eax, byte 4
        jne short .4
.2:
        mov eax, esi
        call PickStrideAnim
        jmp near .10
.3:
        mov eax, esi
        call PickSkateAnim
        jmp near .10
.4:
        test byte [byte ecx+01Ch], 80h
        je short .8
        mov eax, dword [byte edx+01Ch]
        cmp eax, byte 3
        jb short .5
        jbe short .6
        cmp eax, byte 4
        je short .2
        jmp short .7
.5:
        cmp eax, byte 1
        je short .3
        jmp short .7
.6:
        mov eax, esi
        call PickCrossoverAnim
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        mov eax, esi
        call PickIdleAnim
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        mov eax, dword [byte ecx+02Ch]
        mov edx, dword [dword eax+0F2h]
        mov ebx, esp
        mov eax, ecx
        mov edx, dword [byte edx+054h]
        call UpdateMovePose
        mov edi, dword [byte ecx+010h]
        cmp edi, 3F800000h
        je short .9
        test edi, 7FFFFFFFh
        je short .9
        fld dword [esp]
        fdiv dword [byte ecx+010h]
        fld dword [byte esp+04h]
        fxch
        fstp dword [esp]
        fdiv dword [byte ecx+010h]
        fld dword [byte esp+08h]
        fxch
        fstp dword [byte esp+04h]
        fdiv dword [byte ecx+010h]
        fstp dword [byte esp+08h]
.9:
        mov edx, esp
        mov eax, esi
        call StartMoveAtSpeed
        mov edx, esp
        mov eax, ecx
        mov esi, dword [byte ecx+02Ch]
        call ApplyMoveMotion
        mov eax, esi
        call MovePlayer
.10:
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
GlideBackwardMoveJumpTable:                     ; jump table for the switch cases of GlideBackwardMove
        dd GlideBackwardMove_3B
        dd GlideBackwardMove_53
        dd GlideBackwardMove_47
        dd GlideBackwardMove_23
        dd GlideBackwardMove_3B
        dd GlideBackwardMove_53
        dd GlideBackwardMove_53
        dd GlideBackwardMove_2F
;-----------------------------------------------------------------------------
; GlideBackwardMove                               649E0  97 PC, low confidence
; Move handler for gliding backward
;-----------------------------------------------------------------------------
GlideBackwardMove:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 0Ch
        mov ecx, eax
        mov esi, dword [byte eax+02Ch]
        mov edx, dword [dword esi+0FAh]
        mov edx, dword [byte edx+01Ch]
        dec edx
        cmp edx, byte 7
        ja short GlideBackwardMove_53
        jmp dword [nosplit cs:edx*4+GlideBackwardMoveJumpTable]
GlideBackwardMove_23:
        mov eax, esi
        call PickStrideAnim
        jmp near GlideBackwardMove_53.3
GlideBackwardMove_2F:
        mov eax, esi
        call PickBackwardTurn
        jmp near GlideBackwardMove_53.3
GlideBackwardMove_3B:
        mov eax, esi
        call PickSkateAnim
        jmp near GlideBackwardMove_53.3
GlideBackwardMove_47:
        mov eax, esi
        call PickCrossoverAnim
        jmp near GlideBackwardMove_53.3
GlideBackwardMove_53:
        test byte [byte ecx+01Ch], 80h
        je short .1
        mov eax, ecx
        call EndMove
        add esp, byte 0Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov edx, dword [byte ecx+02Ch]
        mov edx, dword [dword edx+0F2h]
        mov ebx, esp
        mov eax, ecx
        mov edx, dword [byte edx+054h]
        call UpdateMovePose
        mov edx, dword [byte ecx+010h]
        cmp edx, 3F800000h
        je short .2
        test edx, 7FFFFFFFh
        je short .2
        fld dword [esp]
        fdiv dword [byte ecx+010h]
        fld dword [byte esp+04h]
        fxch
        fstp dword [esp]
        fdiv dword [byte ecx+010h]
        fld dword [byte esp+08h]
        fxch
        fstp dword [byte esp+04h]
        fdiv dword [byte ecx+010h]
        fstp dword [byte esp+08h]
.2:
        mov edx, esp
        mov eax, esi
        call ApplySkateAccel
        mov edx, esp
        mov eax, esi
        call SteerTowardTarget
        mov edx, esp
        mov eax, ecx
        mov esi, dword [byte ecx+02Ch]
        call ApplyMoveMotion
        mov eax, esi
        call MovePlayer
.3:
        add esp, byte 0Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
TurnBackwardMoveJumpTable:                      ; jump table for the switch cases of TurnBackwardMove
        dd TurnBackwardMove_51
        dd TurnBackwardMove_61
        dd TurnBackwardMove_71
        dd TurnBackwardMove_41
        dd TurnBackwardMove_C2
        dd TurnBackwardMove_BC
        dd TurnBackwardMove_BC
        dd TurnBackwardMove_31
;-----------------------------------------------------------------------------
; TurnBackwardMove                                64AE0  97 PC, low confidence
; Move handler for turning while skating backward
;-----------------------------------------------------------------------------
TurnBackwardMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 20h
        mov ecx, eax
        mov esi, dword [byte eax+02Ch]
        mov edi, dword [byte eax+028h]
        mov eax, dword [dword esi+0FAh]
        mov eax, dword [byte eax+01Ch]
        dec eax
        and edi, 0FFFFh
        cmp eax, byte 7
        ja near TurnBackwardMove_BC
        jmp dword [nosplit cs:eax*4+TurnBackwardMoveJumpTable]
TurnBackwardMove_31:
        mov eax, esi
        call PickBackwardTurn
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
TurnBackwardMove_41:
        mov eax, esi
        call PickStrideAnim
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
TurnBackwardMove_51:
        mov eax, esi
        call PickSkateAnim
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
TurnBackwardMove_61:
        mov eax, esi
        call PickIdleAnim
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
TurnBackwardMove_71:
        cmp dword [byte esi+038h], 40C00000h
        jge short .1
        mov eax, esi
        call PickGlideAnim
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        cmp edi, byte 21h
        je short .2
        cmp edi, byte 22h
        je short .2
        cmp edi, 13Fh
        jl short .3
        cmp edi, 142h
        jg short .3
.2:
        mov eax, esi
        call PickTurnAnim
        jmp short .4
.3:
        mov eax, esi
        call PickStopAnim
.4:
        test eax, eax
        jne near TurnBackwardMove_C2.15
TurnBackwardMove_BC:
        test byte [byte ecx+01Ch], 80h
        je short TurnBackwardMove_C2.5
TurnBackwardMove_C2:
        mov eax, ecx
        call EndMove
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        cmp word [dword esi+0A9h], byte 0
        jle short .6
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword esi+0A4h]
        cmp edx, eax
        je short .7
.6:
        mov eax, dword [dword esi+0AEh]
        sar eax, 18h
        cmp byte [dword esi+eax+0B2h], 0Eh
        je short .7
        mov eax, dword [dword esi+0EEh]
        test byte [byte eax+029h], 2
        je near .10
.7:
        cmp edi, byte 14h
        jb near .10
        jbe short .8
        cmp edi, byte 15h
        je short .9
        jmp near .10
.8:
        mov eax, dword [byte ecx+02Ch]
        fild dword [byte ecx+01Ch]
        mov edx, 39h
        mov ebx, dword [dword eax+0FAh]
        fstp dword [byte esp+018h]
        mov esi, dword [byte ecx+04h]
        mov ebx, dword [byte ebx+038h]
        mov cl, byte [dword eax+0BFh]
        mov dword [byte esp+01Ch], ebx
        test cl, 20h
        setne bl
        and ebx, 0FFh
        fld dword [byte esp+018h]
        push ebx
        call __CHP
        push esi
        fistp dword [byte esp+014h]
        mov ebx, dword [byte esp+014h]
        push dword [byte esp+024h]
        call StartNextMove
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov eax, dword [byte ecx+02Ch]
        mov ebx, dword [dword eax+0FAh]
        fild dword [byte ecx+01Ch]
        mov edx, 3Ah
        mov ebx, dword [byte ebx+038h]
        fstp dword [byte esp+010h]
        mov dword [byte esp+014h], ebx
        mov bh, byte [dword eax+0BFh]
        mov esi, dword [byte ecx+04h]
        test bh, 20h
        setne bl
        and ebx, 0FFh
        fld dword [byte esp+010h]
        push ebx
        call __CHP
        push esi
        fistp dword [byte esp+014h]
        mov ebx, dword [byte esp+014h]
        push dword [byte esp+01Ch]
        call StartNextMove
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        mov eax, dword [byte ecx+02Ch]
        mov edx, dword [dword eax+0F2h]
        mov ebx, esp
        mov eax, ecx
        mov edx, dword [byte edx+054h]
        call UpdateMovePose
        mov ebx, dword [byte ecx+010h]
        cmp ebx, 3F800000h
        je short .11
        test ebx, 7FFFFFFFh
        je short .11
        fld dword [esp]
        fdiv dword [byte ecx+010h]
        fld dword [byte esp+04h]
        fxch
        fstp dword [esp]
        fdiv dword [byte ecx+010h]
        fld dword [byte esp+08h]
        fxch
        fstp dword [byte esp+04h]
        fdiv dword [byte ecx+010h]
        fstp dword [byte esp+08h]
.11:
        cmp edi, byte 14h
        je short .12
        cmp edi, byte 15h
        je short .12
        cmp edi, byte 39h
        je short .12
        cmp edi, byte 3Ah
        je short .12
        cmp edi, 131h
        jl short .13
        cmp edi, 134h
        jg short .13
.12:
        mov edx, esp
        mov eax, esi
        call TurnLeanAngle
        jmp short .14
.13:
        mov edx, esp
        mov eax, esi
        call TurnStickPos
.14:
        mov edx, esp
        mov eax, ecx
        mov esi, dword [byte ecx+02Ch]
        call ApplyMoveMotion
        mov eax, esi
        call MovePlayer
.15:
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; StopBackwardMove                                64D54  97 PC, low confidence
; Move handler for stopping from backward skating (plays the skid sound)
;-----------------------------------------------------------------------------
StopBackwardMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        mov esi, eax
        mov edi, dword [byte eax+02Ch]
        mov ecx, dword [byte eax+028h]
        mov edx, dword [byte esi+04h]
        mov eax, dword [dword edi+0FAh]
        and ecx, 0FFFFh
        mov dword [byte ebp-04h], eax
        cmp edx, byte 19h
        jl short .2
        mov eax, dword [byte eax+01Ch]
        cmp eax, byte 1
        jbe short .2
        cmp eax, byte 4
        jb short .1
        cmp eax, byte 5
        jbe short .2
.1:
        mov eax, edi
        call PickSkateAnim
        jmp near .13
.2:
        test byte [byte esi+01Ch], 80h
        je short .3
        mov eax, edi
        mov dword [byte edi+038h], 0
        call PickSkateAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov eax, dword [byte esi+02Ch]
        mov edx, dword [dword eax+0F2h]
        lea ebx, [byte ebp-010h]
        mov eax, esi
        mov edx, dword [byte edx+054h]
        call UpdateMovePose
        mov ebx, dword [byte esi+010h]
        cmp ebx, 3F800000h
        je short .4
        test ebx, 7FFFFFFFh
        je short .4
        fld dword [byte ebp-010h]
        fdiv dword [byte esi+010h]
        fld dword [byte ebp-0Ch]
        fxch
        fstp dword [byte ebp-010h]
        fdiv dword [byte esi+010h]
        fld dword [byte ebp-08h]
        fxch
        fstp dword [byte ebp-0Ch]
        fdiv dword [byte esi+010h]
        fstp dword [byte ebp-08h]
.4:
        lea edx, [byte ebp-010h]
        mov eax, edi
        mov ebx, dword [byte esi+04h]
        call StopSkidDistance
        mov eax, dword [byte ebp-04h]
        push dword [byte eax+04h]
        mov eax, esi
        call ScaleAnimTime
        cmp dword [byte esi+04h], byte 2
        jne near .12
        cmp word [dword edi+0A9h], byte 0
        jne short .7
        mov eax, dword [puckc]
        xor edx, edx
        push dword [byte edi+028h]
        mov dl, byte [dword edi+0A4h]
        movsx eax, byte [eax]
        push dword [byte edi+020h]
        cmp edx, eax
        jne short .5
        mov edx, 55h
        jmp short .6
.5:
        mov edx, 0Ch
.6:
        mov eax, 430h
        jmp short .11
.7:
        mov eax, dword [puckc]
        xor edx, edx
        push dword [byte edi+028h]
        mov dl, byte [dword edi+0A4h]
        movsx eax, byte [eax]
        push dword [byte edi+020h]
        cmp edx, eax
        je short .8
        cmp dl, 0Ch
        jne short .9
.8:
        mov edx, 55h
        jmp short .10
.9:
        mov edx, 0Ch
.10:
        mov eax, 4
        call randomd0
        cwde
        add eax, 431h
.11:
        call PlaySfxVolume
.12:
        lea edx, [byte ebp-010h]
        mov eax, esi
        mov edi, dword [byte esi+02Ch]
        call ApplyMoveMotion
        mov eax, edi
        call MovePlayer
.13:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FaceoffPuckDrop                                 64EBC  97 PC, low confidence
; Places the puck for a faceoff drop
;-----------------------------------------------------------------------------
FaceoffPuckDrop:
        push ebx
        push ecx
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov dword [byte eax+034h], 0
        mov edx, dword [byte eax+034h]
        mov dword [byte eax+02Ch], edx
        mov edx, dword [byte eax+02Ch]
        mov dword [byte eax+038h], edx
        mov edx, dword [byte ecx+020h]
        mov dword [dword eax+0D2h], edx
        mov edx, dword [byte ecx+028h]
        mov dword [dword eax+0DAh], edx
        mov eax, dword [dword eax+0EEh]
        fld dword [byte eax+010h]
        fmul qword [F64_6p28319_FaceoffPuckDrop]
        fmul qword [F64_1p52588eneg05_FaceoffPuckDrop]
        fld qword [F64_6p28319_FaceoffPuckDrop]
        fxch
        call IF@DFMOD
        fst dword [byte esp+010h]
        fst qword [esp]
        fcomp qword [F64_3p14159_FaceoffPuckDrop]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [esp]
        fadd qword [F64_neg6p28319_FaceoffPuckDrop]
        fstp dword [byte esp+010h]
.1:
        fld dword [byte esp+010h]
        fst qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_FaceoffPuckDrop]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+08h]
        fadd qword [F64_6p28319_FaceoffPuckDrop]
        fstp dword [byte esp+010h]
.2:
        mov eax, dword [byte esp+010h]
        mov dword [byte ecx+044h], eax
        mov eax, dword [dword ecx+0FAh]
        mov edx, dword [byte ecx+044h]
        mov dword [byte eax+010h], edx
        mov edx, dword [byte eax+010h]
        mov dword [byte ecx+040h], edx
        fld dword [byte ecx+040h]
        mov eax, dword [dword ecx+0FAh]
        fstp dword [byte ecx+01Ch]
        mov dword [byte eax+01Ch], 0
        mov eax, dword [dword ecx+0FAh]
        mov dword [byte eax+018h], 0
        fld dword [byte eax+018h]
        mov eax, dword [dword ecx+0FAh]
        fst dword [byte eax+028h]
        mov eax, dword [dword ecx+0FAh]
        fst dword [byte eax+02Ch]
        mov eax, dword [dword ecx+0FAh]
        fstp dword [byte eax+014h]
        mov eax, dword [dword ecx+0EEh]
        and byte [byte eax+031h], 0FEh
        mov eax, dword [dword ecx+0EEh]
        and byte [byte eax+031h], 0F7h
        mov eax, dword [dword ecx+0FAh]
        mov dword [byte eax+030h], 0
        mov eax, dword [dword ecx+0FAh]
        mov dword [byte eax+08h], 0
        mov dword [byte eax+04h], 3F800000h
        mov dword [byte eax+0Ch], 0
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .3
        mov dl, byte [dword ecx+0BFh]
        mov ebx, 20h
        and dl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], dl
        mov edx, 109h
        jmp near .6
.3:
        mov dx, word [dword ecx+0A9h]
        test dx, dx
        jne short .4
        mov ah, byte [dword ecx+0BFh]
        mov edx, 0A7h
        and ah, 0DFh
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F800000h
        call SetSPAInPlace
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        cmp dx, byte 4
        jne short .5
        mov al, byte [dword ecx+0BFh]
        mov ebx, 20h
        and al, 0DFh
        mov edx, 0Bh
        mov byte [dword ecx+0BFh], al
        mov eax, ecx
        push dword 3F800000h
        call SetSPAInPlace
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        test dx, dx
        jle short .7
        mov bh, byte [dword ecx+0BFh]
        mov edx, 0Ch
        and bh, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        mov ebx, 20h
.6:
        push dword 3F800000h
        call SetSPAInPlace
.7:
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SetSkateSpeedFromRating                         650A4  97 PC, low confidence
; Sets a player's top speed from its rating
;-----------------------------------------------------------------------------
SetSkateSpeedFromRating:
        push edx
        sub esp, byte 4
        mov edx, eax
        mov eax, dword [dword eax+0EEh]
        fld dword [byte eax+018h]
        fmul dword [F32_48_SetSkateSpeedFromRating]
        fmul dword [F32_0p1_SetSkateSpeedFromRating]
        fst dword [esp]
        fcomp dword [F32_4_SetSkateSpeedFromRating]
        fnstsw ax
        sahf
        jae short .1
        mov dword [esp], 40800000h
.1:
        mov edx, dword [dword edx+0EEh]
        mov eax, dword [esp]
        mov dword [byte edx+01Ch], eax
        add esp, byte 4
        pop edx
        ret
