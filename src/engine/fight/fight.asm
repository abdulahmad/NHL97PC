; Fights: grabs, punches, blocks, ducks, hits and falls.
bits 32
%include "hockey.inc"
section s_70323 progbits alloc exec nowrite align=1
extern AdvanceMoveAnim, ApplySkateAccel, BodyPointId, ClearObjectHidden, F64_0p5_FightSwingMove, F64_3p14159_FightPositionMove, F64_6p28319_FightPositionMove, F64_96_FightSwingMove
extern F64_neg3p14159_FightPositionMove, F64_neg6p28319_FightPositionMove, FaceAngleDelta, FacePlayerToward, FistPointId, GetAnimId, HeadPointId, hypot_
extern IF@ATAN2, IF@DFMOD, LinkModelPair, MovePlayer, MoveToAnimPose, ObjectFramePos, PlaySfxVolume, PtrPuckFlags
extern PunchPointId, randomd0, ResetAnimTimer, SetAnimFlags, SetAnimFrame, SetCrowdMood, SetFaceBlink, SetFaceExpression
extern SetFaceMouth, SetModelHeading, SetSPA, SetSPAInPlace, SortCords, StepMove, SwingPointId
global StartFightAnimMove, FightGrabMove, FightHoldMove, FightPunchMoveJumpTable, FightPunchHitJumpTable, FightPunchMove, FightPunchMove_1B3, FightPunchMove_1B8
global FightPunchMove_1BE, FightPunchMove_1C4, FightPunchMove_288, FightPunchMove_28D, FightPunchMove_293, FightPunchMove_299, FightIdleMove, FightEndMove
global FightBlockMove, FightDuckMove, FightHitMove, FightPauseMove, FightJerseyMove, FightPositionMove, FightStepMove, FightSwingMove
global FightUppercutMove, FightStaggerMove, FightFaceMove, FightStartMove, FightCircleMove, FightThrowMove, FightFallMove, StartFightPunchJumpTable
global StartFightPunchHitJumpTable, StartFightPunch, StartFightPunch_86, StartFightPunch_8B, StartFightPunch_91, StartFightPunch_97, StartFightPunch_186, StartFightPunch_18B
global StartFightPunch_191, StartFightPunch_197, StartFightBlockJumpTable, StartFightBlockHitJumpTable, StartFightBlock, StartFightBlock_86, StartFightBlock_8B, StartFightBlock_91
global StartFightBlock_97, StartFightBlock_186, StartFightBlock_18B, StartFightBlock_191, StartFightBlock_197, StartFightGrab, StartFightPull, StartFightAnim
        db 090h
;-----------------------------------------------------------------------------
; StartFightAnimMove                              70324  97 PC, low confidence
; Starts a fight animation move
;-----------------------------------------------------------------------------
StartFightAnimMove:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov eax, dword [dword eax+0FAh]
        call ResetAnimTimer
        mov eax, ecx
        call FacePlayerToward
        mov edx, dword [dword ecx+0F6h]
        mov edx, dword [edx]
        mov edx, dword [byte edx+028h]
        and edx, 0FFFFh
        cmp eax, edx
        je short .1
        mov dl, byte [dword ecx+0BFh]
        and dl, 0DFh
        mov ebx, 20h
        mov byte [dword ecx+0BFh], dl
        mov edx, eax
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
.1:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FightGrabMove                                   70378  97 PC, low confidence
; Move handler for grabbing in a fight
;-----------------------------------------------------------------------------
FightGrabMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov edi, dword [byte eax+028h]
        mov eax, ecx
        mov edx, dword [dword ecx+0FAh]
        call FacePlayerToward
        and edi, 0FFFFh
        mov esi, eax
        cmp eax, edi
        jne short .1
        test byte [byte ebx+01Ch], 80h
        je short .3
.1:
        cmp esi, 158h
        jne short .2
        cmp dword [byte ebx+04h], byte 0
        je short .2
        test byte [byte ebx+01Ch], 80h
        je short .3
.2:
        mov eax, edx
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        mov ebx, 20h
        and ah, 0DFh
        mov edx, esi
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        jmp short .5
.3:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov eax, ecx
        mov edx, esp
        call MoveToAnimPose
        mov eax, ecx
        call ApplySkateAccel
        cmp esi, 158h
        jne short .4
        xor ebp, ebp
        mov dword [byte esp+08h], ebp
.4:
        mov edx, esp
        mov eax, ebx
        call StepMove
.5:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FightHoldMove                                   70424  97 PC, low confidence
; Move handler for holding in a fight
;-----------------------------------------------------------------------------
FightHoldMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov edi, dword [byte eax+028h]
        mov eax, ecx
        mov edx, dword [dword ecx+0FAh]
        call FacePlayerToward
        and edi, 0FFFFh
        mov esi, eax
        cmp eax, edi
        jne short .1
        test byte [byte ebx+01Ch], 80h
        je short .2
.1:
        mov eax, edx
        call ResetAnimTimer
        mov dl, byte [dword ecx+0BFh]
        mov ebx, 20h
        and dl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], dl
        mov edx, esi
        push dword 3F800000h
        call SetSPA
        jmp short .3
.2:
        xor edx, edx
        mov dword [esp], edx
        mov eax, dword [byte ecx+038h]
        mov dword [byte esp+08h], eax
        mov eax, ecx
        mov edx, esp
        call MoveToAnimPose
        mov eax, ecx
        call ApplySkateAccel
        mov edx, esp
        mov eax, ebx
        call StepMove
.3:
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
FightPunchMoveJumpTable:                        ; jump table for the switch cases of FightPunchMove
        dd FightPunchMove_1B3
        dd FightPunchMove_1B8
        dd FightPunchMove_1B8
        dd FightPunchMove_1BE
        dd FightPunchMove_1C4
FightPunchHitJumpTable:                         ; jump table for the switch cases of FightPunchMove
        dd FightPunchMove_288
        dd FightPunchMove_28D
        dd FightPunchMove_28D
        dd FightPunchMove_293
        dd FightPunchMove_299
;-----------------------------------------------------------------------------
; FightPunchMove                                  704D4  97 PC, low confidence
; Move handler for a punch (crowd and sound)
;-----------------------------------------------------------------------------
FightPunchMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 30h
        mov dword [byte ebp-010h], eax
        mov eax, dword [byte eax+028h]
        and eax, 0FFFFh
        mov esi, dword [byte ebp-010h]
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [byte ebp-010h]
        mov esi, dword [byte esi+02Ch]
        mov dl, byte [byte eax+01Ch]
        mov edi, dword [dword esi+0FAh]
        test dl, 80h
        je short .1
        xor edx, edx
        jmp short .2
.1:
        call GetAnimId
        mov edx, eax
.2:
        xor eax, eax
        mov al, byte [byte esi+06Ch]
        mov ecx, eax
        shl ecx, 5
        add ecx, eax
        shl ecx, 3
        add ecx, SortCords
        test dl, 1
        je near FightPunchMove_299.19
        mov dh, byte [byte edi+030h]
        test dh, 40h
        jne near FightPunchMove_299.19
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 1
        jne near FightPunchMove_299.18
        cmp dword [byte ebp-0Ch], 15Ch
        jne short .3
        mov dword [byte ebp-08h], 40h
        jmp short .4
.3:
        mov dword [byte ebp-08h], 78h
.4:
        fild dword [byte ebp-08h]
        lea ebx, [byte ebp-030h]
        mov edx, dword [HeadPointId]
        mov eax, esi
        fstp dword [byte ebp-04h]
        call ObjectFramePos
        lea ebx, [byte ebp-024h]
        mov edx, dword [PunchPointId]
        mov eax, ecx
        call ObjectFramePos
        fld dword [byte ebp-024h]
        fsub dword [byte ebp-030h]
        fabs
        fild dword [byte ebp-08h]
        fcompp
        fnstsw ax
        sahf
        jbe near FightPunchMove_299.17
        fld dword [byte ebp-020h]
        fsub dword [byte ebp-02Ch]
        fabs
        fld dword [byte ebp-04h]
        fstp qword [byte ebp-018h]
        fcomp qword [byte ebp-018h]
        fnstsw ax
        sahf
        jae near FightPunchMove_299.17
        fld dword [byte ebp-01Ch]
        fsub dword [byte ebp-028h]
        fabs
        fcomp qword [byte ebp-018h]
        fnstsw ax
        sahf
        jae near FightPunchMove_299.17
        mov bh, byte [byte edi+030h]
        or bh, 40h
        mov al, bh
        mov byte [byte edi+030h], bh
        and al, 7Fh
        mov edx, dword [byte ebp-0Ch]
        mov byte [byte edi+030h], al
        cmp edx, 15Ch
        jne near FightPunchMove_1C4.10
        test byte [dword ecx+0BFh], 40h
        je short .5
        mov eax, 8
        call SetCrowdMood
.5:
        push dword [byte ecx+028h]
        mov eax, 2
        push dword [byte ecx+020h]
        mov edx, 64h
        call randomd0
        test ax, ax
        sete al
        and eax, 0FFh
        add eax, 440h
        call PlaySfxVolume
        mov edx, 1
        mov eax, dword [dword esi+0F2h]
        call SetFaceExpression
        mov eax, dword [dword esi+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword esi+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov edx, 2
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        xor edx, edx
        mov eax, ecx
        jmp dword [dword cs:edx+FightPunchMoveJumpTable]
FightPunchMove_1B3:
        dec dword [byte ecx+056h]
        jmp short FightPunchMove_1C4.6
FightPunchMove_1B8:
        sub dword [byte eax+056h], byte 2
        jmp short FightPunchMove_1C4.6
FightPunchMove_1BE:
        sub dword [byte ecx+056h], byte 3
        jmp short FightPunchMove_1C4.6
FightPunchMove_1C4:
        sub dword [byte ecx+056h], byte 4
.6:
        cmp dword [byte ecx+056h], byte 0
        setle al
        and eax, 0FFh
        je short .9
        test byte [dword ecx+0BFh], 40h
        je short .7
        mov eax, 0Ah
        jmp short .8
.7:
        mov eax, 1
.8:
        call SetCrowdMood
        mov eax, dword [dword ecx+0EEh]
        mov dl, byte [byte eax+031h]
        or dl, 1
        mov edi, 15Bh
        mov byte [byte eax+031h], dl
        jmp near FightPunchMove_299.16
.9:
        mov edi, 15Ah
        jmp near FightPunchMove_299.16
.10:
        test byte [dword ecx+0BFh], 40h
        je short .11
        mov eax, 9
        call SetCrowdMood
.11:
        push dword [byte ecx+028h]
        mov eax, 2
        push dword [byte ecx+020h]
        mov edx, 64h
        call randomd0
        test ax, ax
        sete al
        and eax, 0FFh
        add eax, 440h
        call PlaySfxVolume
        mov edx, 1
        mov eax, dword [dword esi+0F2h]
        call SetFaceExpression
        mov eax, dword [dword esi+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword esi+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov edx, 4
        mov eax, ecx
        jmp dword [dword cs:edx+FightPunchHitJumpTable]
FightPunchMove_288:
        dec dword [byte ecx+056h]
        jmp short FightPunchMove_299.12
FightPunchMove_28D:
        sub dword [byte eax+056h], byte 2
        jmp short FightPunchMove_299.12
FightPunchMove_293:
        sub dword [byte ecx+056h], byte 3
        jmp short FightPunchMove_299.12
FightPunchMove_299:
        sub dword [byte ecx+056h], edx
.12:
        cmp dword [byte ecx+056h], byte 0
        setle al
        and eax, 0FFh
        je short .15
        test byte [dword ecx+0BFh], 40h
        je short .13
        mov eax, 0Ah
        jmp short .14
.13:
        mov eax, 1
.14:
        call SetCrowdMood
        mov edx, 2
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceBlink
        mov eax, dword [dword ecx+0EEh]
        mov dh, byte [byte eax+031h]
        or dh, 1
        mov edi, 15Fh
        mov byte [byte eax+031h], dh
        jmp short .16
.15:
        mov edx, 2
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        mov edi, 15Eh
        call SetFaceBlink
.16:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov dh, byte [dword ecx+0BFh]
        xor ebx, ebx
        or dh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], dh
        mov edx, edi
        push dword 3F800000h
        call SetSPA
        or byte [dword ecx+0BFh], 20h
        jmp short .20
.17:
        or byte [byte edi+030h], 80h
        jmp short .20
.18:
        or dh, 80h
        mov byte [byte edi+030h], dh
        jmp short .20
.19:
        mov bl, byte [byte edi+030h]
        test bl, 80h
        je short .20
        test bl, 40h
        jne short .20
        push dword [byte esi+028h]
        mov edx, 64h
        mov eax, 443h
        push dword [byte esi+020h]
        call PlaySfxVolume
        and byte [byte edi+030h], 7Fh
.20:
        mov eax, dword [byte ebp-010h]
        test byte [byte eax+01Ch], 80h
        je short .21
        mov eax, esi
        call StartFightAnimMove
        jmp short .22
.21:
        lea edx, [byte ebp-024h]
        call AdvanceMoveAnim
        mov eax, esi
        lea edx, [byte ebp-024h]
        call MoveToAnimPose
        mov eax, esi
        call ApplySkateAccel
        lea edx, [byte ebp-024h]
        mov eax, dword [byte ebp-010h]
        call StepMove
.22:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FightIdleMove                                   708B0  97 PC, low confidence
; Move handler for the fight idle
;-----------------------------------------------------------------------------
FightIdleMove:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        test byte [byte eax+01Ch], 80h
        je short .1
        mov eax, ecx
        call StartFightAnimMove
        jmp short .2
.1:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov eax, ecx
        mov edx, esp
        call MoveToAnimPose
        mov eax, ecx
        call ApplySkateAccel
        mov edx, esp
        mov eax, ebx
        call StepMove
.2:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FightEndMove                                    708F4  97 PC, low confidence
; Move handler for the end of a fight
;-----------------------------------------------------------------------------
FightEndMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov esi, eax
        mov ecx, dword [byte eax+02Ch]
        xor edx, edx
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edi, SortCords
        shl eax, 3
        mov edx, dword [byte esi+04h]
        add edi, eax
        cmp edx, byte 25h
        jne short .1
        mov ebx, 1
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetModelHeading
        mov ebx, 1
        mov eax, dword [dword ecx+0F2h]
        mov edx, ebx
        call SetModelHeading
.1:
        test byte [byte esi+01Ch], 80h
        je short .3
        mov eax, dword [dword ecx+0F2h]
        call ClearObjectHidden
        xor edx, edx
        xor eax, eax
        mov dl, byte [dword edi+0A4h]
        mov al, byte [dword ecx+0A4h]
        call LinkModelPair
        cmp byte [dword ecx+0D0h], 0
        je short .2
        push dword 3F800000h
        mov dh, byte [dword ecx+0BFh]
        mov eax, ecx
        and dh, 0DFh
        xor ebx, ebx
        mov byte [dword ecx+0BFh], dh
        mov edx, 158h
        mov byte [dword ecx+0D0h], 0
        call SetSPAInPlace
.2:
        mov eax, ecx
        call StartFightAnimMove
        jmp short .4
.3:
        mov edx, esp
        mov eax, esi
        call AdvanceMoveAnim
        mov eax, ecx
        mov edx, esp
        call MoveToAnimPose
        mov eax, ecx
        call ApplySkateAccel
        mov edx, esp
        mov eax, esi
        call StepMove
.4:
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FightBlockMove                                  709D0  97 PC, low confidence
; Move handler for blocking in a fight
;-----------------------------------------------------------------------------
FightBlockMove:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        test byte [byte eax+01Ch], 80h
        je short .1
        mov eax, ecx
        call StartFightAnimMove
        jmp short .2
.1:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov eax, ecx
        mov edx, esp
        call MoveToAnimPose
        mov eax, ecx
        call ApplySkateAccel
        mov edx, esp
        mov eax, ebx
        call StepMove
.2:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FightDuckMove                                   70A14  97 PC, low confidence
; Move handler for ducking in a fight
;-----------------------------------------------------------------------------
FightDuckMove:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        test byte [byte eax+01Ch], 80h
        je short .1
        mov eax, ecx
        call StartFightAnimMove
        jmp short .2
.1:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov eax, ecx
        mov edx, esp
        call MoveToAnimPose
        mov eax, ecx
        call ApplySkateAccel
        mov edx, esp
        mov eax, ebx
        call StepMove
.2:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FightHitMove                                    70A58  97 PC, low confidence
; Move handler for being hit in a fight (sound)
;-----------------------------------------------------------------------------
FightHitMove:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov ah, byte [byte eax+01Ch]
        mov esi, dword [dword ecx+0FAh]
        test ah, 80h
        je short .1
        xor eax, eax
        jmp short .2
.1:
        mov eax, ebx
        call GetAnimId
.2:
        test al, 2
        je short .3
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 423h
        push dword [byte ecx+020h]
        call PlaySfxVolume
        mov edx, 2
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
.3:
        test byte [byte ebx+01Ch], 80h
        je short .4
        mov eax, esi
        call ResetAnimTimer
        mov dh, byte [dword ecx+0BFh]
        xor ebx, ebx
        or dh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], dh
        mov edx, 160h
        push dword 3F800000h
        call SetSPA
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        jmp short .5
.4:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ebx
        call StepMove
.5:
        add esp, byte 0Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FightPauseMove                                  70B38  97 PC, low confidence
; Move handler for a pause in a fight
;-----------------------------------------------------------------------------
FightPauseMove:
        push ebx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov dl, byte [byte ebx+01Ch]
        mov eax, dword [byte eax+02Ch]
        test dl, 80h
        je short .1
        mov ebx, dword [dword eax+0EEh]
        and byte [byte ebx+031h], 0FEh
        call StartFightAnimMove
        jmp short .2
.1:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ebx
        call StepMove
.2:
        add esp, byte 0Ch
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FightJerseyMove                                 70B74  97 PC, low confidence
; Move handler for a jersey pull (sound)
;-----------------------------------------------------------------------------
FightJerseyMove:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        test byte [byte eax+01Ch], 80h
        je short .1
        xor eax, eax
        jmp short .2
.1:
        mov eax, ebx
        call GetAnimId
.2:
        test al, 2
        je short .3
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 423h
        push dword [byte ecx+020h]
        call PlaySfxVolume
.3:
        test byte [byte ebx+01Ch], 80h
        je short .4
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov dh, byte [dword ecx+0BFh]
        xor ebx, ebx
        or dh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], dh
        mov edx, 175h
        push dword 3F800000h
        call SetSPA
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        jmp short .5
.4:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ebx
        call StepMove
.5:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FightPositionMove                               70C24  97 PC, low confidence
; Places the fighters toward each other
;-----------------------------------------------------------------------------
FightPositionMove:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 44h
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov ecx, edx
        mov ebx, esp
        mov edx, dword [BodyPointId]
        call ObjectFramePos
        fld dword [esp]
        fld dword [byte esp+08h]
        fsub dword [byte ecx+028h]
        fstp qword [byte esp+0Ch]
        mov edx, dword [byte esp+010h]
        mov ebx, dword [byte esp+0Ch]
        push edx
        fsub dword [byte ecx+020h]
        push ebx
        fstp qword [byte esp+01Ch]
        mov edi, dword [byte esp+020h]
        push edi
        mov eax, dword [byte esp+020h]
        push eax
        call hypot_
        fld qword [byte esp+0Ch]
        fld qword [byte esp+014h]
        call IF@ATAN2
        fld qword [F64_6p28319_FightPositionMove]
        fxch
        call IF@DFMOD
        fxch
        fstp dword [byte ecx+038h]
        fst dword [byte ecx+040h]
        fst qword [byte esp+024h]
        fcomp qword [F64_3p14159_FightPositionMove]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+024h]
        fadd qword [F64_neg6p28319_FightPositionMove]
        fstp dword [byte ecx+040h]
.1:
        fld dword [byte ecx+040h]
        fst qword [byte esp+03Ch]
        fcomp qword [F64_neg3p14159_FightPositionMove]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+03Ch]
        fadd qword [F64_6p28319_FightPositionMove]
        fstp dword [byte ecx+040h]
.2:
        mov eax, ecx
        call MoveToAnimPose
        mov edx, dword [dword ecx+0FAh]
        fld dword [byte edx+014h]
        fadd dword [byte ecx+01Ch]
        fld qword [F64_6p28319_FightPositionMove]
        fxch
        call IF@DFMOD
        fst dword [byte ecx+01Ch]
        fst qword [byte esp+02Ch]
        fcomp qword [F64_3p14159_FightPositionMove]
        fnstsw ax
        sahf
        jbe short .3
        fld qword [byte esp+02Ch]
        fadd qword [F64_neg6p28319_FightPositionMove]
        fstp dword [byte ecx+01Ch]
.3:
        fld dword [byte ecx+01Ch]
        fst qword [byte esp+034h]
        fcomp qword [F64_neg3p14159_FightPositionMove]
        fnstsw ax
        sahf
        jae short .4
        fld qword [byte esp+034h]
        fadd qword [F64_6p28319_FightPositionMove]
        fstp dword [byte ecx+01Ch]
.4:
        mov eax, ecx
        call MovePlayer
        fld dword [byte ecx+020h]
        fld dword [byte ecx+028h]
        fld dword [byte esi+020h]
        fld dword [byte esi+028h]
        fxch st3
        fsub dword [esp]
        fxch st2
        fsub dword [byte esp+08h]
        fxch
        faddp st2
        faddp st2
        fstp dword [byte esi+020h]
        fstp dword [byte esi+028h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FightStepMove                                   70D60  97 PC, low confidence
; Move handler for stepping in a fight
;-----------------------------------------------------------------------------
FightStepMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        xor edx, edx
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edi, SortCords
        shl eax, 3
        add edi, eax
        mov eax, dword [ebx]
        mov esi, dword [dword ecx+0FAh]
        mov al, byte [byte eax+0Dh]
        and eax, 0FFh
        mov edx, dword [byte ebx+04h]
        dec eax
        cmp eax, edx
        jne short .2
        mov edx, 800h
        mov eax, ebx
        call SetAnimFlags
        test byte [byte esi+030h], 2
        je short .1
        test byte [dword ecx+0C0h], 1
        je short .1
        mov eax, dword [PtrPuckFlags]
        test byte [dword eax+0C0h], 1
        jne short .2
.1:
        and byte [byte esi+030h], 0FDh
        mov eax, esi
        call ResetAnimTimer
        mov dl, byte [dword ecx+0BFh]
        xor ebx, ebx
        or dl, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], dl
        mov edx, 170h
        push dword 3F800000h
        call SetSPA
        jmp short .4
.2:
        test byte [byte ebx+01Ch], 80h
        je short .3
        mov eax, ecx
        call StartFightAnimMove
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov eax, ecx
        mov edx, esp
        call MoveToAnimPose
        mov eax, ecx
        call ApplySkateAccel
        mov edx, esp
        mov eax, ecx
        call FaceAngleDelta
        mov edx, esp
        mov eax, ebx
        call StepMove
        mov edx, edi
        mov eax, ecx
        call FightPositionMove
.4:
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FightSwingMove                                  70E48  97 PC, low confidence
; Move handler for a swing in a fight
;-----------------------------------------------------------------------------
FightSwingMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov esi, eax
        test byte [byte eax+01Ch], 80h
        je short .1
        xor eax, eax
        jmp short .2
.1:
        mov eax, esi
        call GetAnimId
.2:
        mov ecx, dword [byte esi+02Ch]
        xor edx, edx
        mov dl, byte [byte ecx+06Ch]
        mov edi, edx
        shl edi, 5
        add edi, edx
        shl edi, 3
        add edi, SortCords
        mov edx, dword [dword edi+0F6h]
        mov edx, dword [edx]
        mov edx, dword [byte edx+028h]
        and edx, 0FFFFh
        mov ebp, dword [dword ecx+0FAh]
        test al, 1
        je near .6
        cmp edx, 162h
        je near .6
        mov eax, dword [dword edi+0EEh]
        test byte [byte eax+031h], 1
        jne near .4
        lea ebx, [byte esp+018h]
        mov edx, dword [HeadPointId]
        mov eax, ecx
        call ObjectFramePos
        mov ebx, esp
        mov edx, dword [SwingPointId]
        mov eax, edi
        call ObjectFramePos
        lea ebx, [byte esp+024h]
        mov edx, dword [FistPointId]
        mov eax, edi
        call ObjectFramePos
        fld dword [esp]
        fadd dword [byte esp+024h]
        fmul qword [F64_0p5_FightSwingMove]
        fst dword [byte esp+0Ch]
        fsub dword [byte esp+018h]
        fabs
        fld dword [byte esp+08h]
        fld dword [byte esp+04h]
        fadd dword [byte esp+028h]
        fxch
        fadd dword [byte esp+02Ch]
        fxch
        fmul qword [F64_0p5_FightSwingMove]
        fxch
        fmul qword [F64_0p5_FightSwingMove]
        fxch
        fstp dword [byte esp+010h]
        fstp dword [byte esp+014h]
        fcomp qword [F64_96_FightSwingMove]
        fnstsw ax
        sahf
        jae short .3
        fld dword [byte esp+010h]
        fsub dword [byte esp+01Ch]
        fabs
        fcomp qword [F64_96_FightSwingMove]
        fnstsw ax
        sahf
        jae short .3
        fld dword [byte esp+014h]
        fsub dword [byte esp+020h]
        fabs
        fcomp qword [F64_96_FightSwingMove]
        fnstsw ax
        sahf
        jb near .5
.3:
        mov eax, ebp
        mov esi, dword [byte esi+04h]
        call ResetAnimTimer
        mov bh, byte [dword ecx+0BFh]
        mov edx, 172h
        or bh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        xor ebx, ebx
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0F6h]
        mov edx, esi
        mov eax, dword [eax]
        call SetAnimFrame
        or byte [dword ecx+0BFh], 20h
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov eax, ebp
        mov esi, dword [byte esi+04h]
        call ResetAnimTimer
        mov dh, byte [dword ecx+0BFh]
        xor ebx, ebx
        or dh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], dh
        mov edx, 172h
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0F6h]
        mov edx, esi
        mov eax, dword [eax]
        call SetAnimFrame
        or byte [dword ecx+0BFh], 20h
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov eax, dword [dword edi+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword edi+0BFh]
        mov ebx, 40h
        or ah, 20h
        mov edx, 162h
        mov byte [dword edi+0BFh], ah
        mov eax, edi
        push dword 3F800000h
        call SetSPA
        or byte [dword edi+0BFh], 20h
        or byte [byte ebp+030h], 2
        mov edx, dword [dword edi+0FAh]
        or byte [byte edx+030h], 2
        mov dword [byte ecx+05Ah], 64h
        mov dword [byte edi+05Ah], 0FFFFFF9Ch
.6:
        mov eax, dword [esi]
        mov al, byte [byte eax+0Dh]
        and eax, 0FFh
        mov ebx, dword [byte esi+04h]
        dec eax
        cmp eax, ebx
        jne short .8
        mov edx, 800h
        mov eax, esi
        call SetAnimFlags
        and byte [dword ecx+0BFh], 0DFh
        test byte [byte ebp+030h], 2
        je short .7
        test byte [dword ecx+0C0h], 1
        je short .7
        mov eax, dword [PtrPuckFlags]
        test byte [dword eax+0C0h], 1
        jne short .8
.7:
        mov bl, byte [byte ebp+030h]
        and bl, 0FDh
        mov eax, ebp
        mov byte [byte ebp+030h], bl
        call ResetAnimTimer
        mov bh, byte [dword ecx+0BFh]
        mov edx, 171h
        or bh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        xor ebx, ebx
        push dword 3F800000h
        call SetSPA
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        test byte [byte ebp+030h], 2
        jne short .9
        lea edx, [byte esp+024h]
        mov eax, esi
        call AdvanceMoveAnim
        mov eax, ecx
        lea edx, [byte esp+024h]
        call MoveToAnimPose
        mov eax, ecx
        call ApplySkateAccel
        lea edx, [byte esp+024h]
        mov eax, esi
        call StepMove
.9:
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FightUppercutMove                               71108  97 PC, low confidence
; Move handler for an uppercut
;-----------------------------------------------------------------------------
FightUppercutMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 10h
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov ah, byte [byte eax+01Ch]
        mov esi, dword [dword ecx+0FAh]
        test ah, 80h
        je short .1
        xor edx, edx
        mov dword [byte esp+0Ch], edx
        jmp short .2
.1:
        mov eax, ebx
        call GetAnimId
        mov dword [byte esp+0Ch], eax
.2:
        xor edx, edx
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edi, SortCords
        shl eax, 3
        mov dl, byte [byte esp+0Ch]
        add edi, eax
        test dl, 1
        je short .3
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 442h
        push dword [byte ecx+020h]
        call PlaySfxVolume
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov edx, 2
        mov eax, dword [dword edi+0F2h]
        call SetFaceExpression
        mov eax, dword [dword edi+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword edi+0F2h]
        xor edx, edx
        call SetFaceBlink
.3:
        test byte [byte ebx+01Ch], 80h
        je near .5
        mov eax, esi
        call ResetAnimTimer
        test byte [byte esi+030h], 2
        jne short .4
        mov dh, byte [dword ecx+0BFh]
        mov eax, ecx
        or dh, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], dh
        mov edx, 171h
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
        jmp short .6
.4:
        mov dl, byte [dword ecx+0BFh]
        mov ebx, 840h
        or dl, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], dl
        mov edx, 161h
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0F6h]
        mov eax, dword [eax]
        mov edx, dword [eax]
        mov dl, byte [byte edx+0Dh]
        and edx, 0FFh
        dec edx
        call SetAnimFrame
        add esp, byte 10h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        test byte [byte esi+030h], 2
        jne short .6
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov eax, ecx
        mov edx, esp
        call MoveToAnimPose
        mov eax, ecx
        call ApplySkateAccel
        mov edx, esp
        mov eax, ebx
        call StepMove
.6:
        add esp, byte 10h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FightStaggerMove                                71298  97 PC, low confidence
; Move handler for staggering
;-----------------------------------------------------------------------------
FightStaggerMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        xor edx, edx
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edi, SortCords
        shl eax, 3
        add edi, eax
        mov ah, byte [byte ebx+01Ch]
        mov esi, dword [dword ecx+0FAh]
        test ah, 80h
        je short .1
        mov eax, esi
        call ResetAnimTimer
        mov dh, byte [dword ecx+0BFh]
        mov ebx, 840h
        or dh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], dh
        mov edx, 162h
        push dword 3F800000h
        call SetSPA
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov eax, dword [dword ecx+0F6h]
        mov eax, dword [eax]
        mov edx, dword [eax]
        mov dl, byte [byte edx+0Dh]
        and edx, 0FFh
        dec edx
        call SetAnimFrame
        jmp short .2
.1:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov eax, ecx
        mov edx, esp
        call MoveToAnimPose
        mov eax, ecx
        call ApplySkateAccel
        mov edx, esp
        mov eax, ecx
        call FaceAngleDelta
        mov edx, esp
        mov eax, ebx
        call StepMove
        test byte [byte esi+030h], 2
        je short .2
        mov edx, edi
        mov eax, ecx
        call FightPositionMove
.2:
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FightFaceMove                                   71380  97 PC, low confidence
; Move handler with face morphs in a fight
;-----------------------------------------------------------------------------
FightFaceMove:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        test byte [byte eax+01Ch], 80h
        je short .1
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov eax, ecx
        call StartFightAnimMove
        jmp short .2
.1:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ebx
        call StepMove
.2:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FightStartMove                                  713E0  97 PC, low confidence
; Move handler for the start of a fight
;-----------------------------------------------------------------------------
FightStartMove:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        mov ecx, dword [byte eax+02Ch]
        mov eax, dword [eax]
        mov ebx, dword [dword ecx+0FAh]
        mov al, byte [byte eax+0Dh]
        and eax, 0FFh
        mov edx, dword [byte esi+04h]
        dec eax
        cmp eax, edx
        jne short .2
        mov edx, 800h
        mov eax, esi
        call SetAnimFlags
        and byte [dword ecx+0BFh], 0DFh
        test byte [byte ebx+030h], 4
        je short .1
        test byte [dword ecx+0C0h], 1
        je short .1
        mov eax, dword [PtrPuckFlags]
        test byte [dword eax+0C0h], 1
        jne short .2
.1:
        and byte [byte ebx+030h], 0F9h
        mov eax, ebx
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        mov edx, 174h
        or ah, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        test byte [byte esi+01Ch], 80h
        je short .3
        mov eax, ebx
        call ResetAnimTimer
        mov eax, ecx
        call StartFightAnimMove
.3:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FightCircleMove                                 7147C  97 PC, low confidence
; Move handler for circling in a fight
;-----------------------------------------------------------------------------
FightCircleMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        xor edx, edx
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edi, SortCords
        shl eax, 3
        add edi, eax
        mov eax, dword [ebx]
        mov esi, dword [dword ecx+0FAh]
        mov al, byte [byte eax+0Dh]
        and eax, 0FFh
        mov edx, dword [byte ebx+04h]
        dec eax
        cmp eax, edx
        jne short .2
        mov edx, 800h
        mov eax, ebx
        call SetAnimFlags
        test byte [byte esi+030h], 4
        je short .1
        test byte [dword ecx+0C0h], 1
        je short .1
        mov eax, dword [PtrPuckFlags]
        test byte [dword eax+0C0h], 1
        jne short .2
.1:
        mov dl, byte [byte esi+030h]
        and dl, 0F9h
        mov eax, esi
        mov byte [byte esi+030h], dl
        call ResetAnimTimer
        mov dh, byte [dword ecx+0BFh]
        xor ebx, ebx
        or dh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], dh
        mov edx, 173h
        push dword 3F800000h
        call SetSPA
        jmp short .4
.2:
        test byte [byte ebx+01Ch], 80h
        je short .3
        mov eax, esi
        call ResetAnimTimer
        mov eax, ecx
        call StartFightAnimMove
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov eax, ecx
        mov edx, esp
        call MoveToAnimPose
        mov eax, ecx
        call ApplySkateAccel
        mov edx, esp
        mov eax, ecx
        call FaceAngleDelta
        mov edx, esp
        mov eax, ebx
        call StepMove
        test byte [byte esi+030h], 4
        je short .4
        mov edx, edi
        mov eax, ecx
        call FightPositionMove
.4:
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FightThrowMove                                  71574  97 PC, low confidence
; Move handler for a throw
;-----------------------------------------------------------------------------
FightThrowMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        xor edx, edx
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edi, SortCords
        shl eax, 3
        add edi, eax
        mov ah, byte [byte ebx+01Ch]
        mov esi, dword [dword ecx+0FAh]
        test ah, 80h
        je short .1
        xor eax, eax
        jmp short .2
.1:
        mov eax, ebx
        call GetAnimId
.2:
        test al, 1
        je short .3
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 442h
        push dword [byte ecx+020h]
        call PlaySfxVolume
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov edx, 2
        mov eax, dword [dword edi+0F2h]
        call SetFaceExpression
        mov eax, dword [dword edi+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword edi+0F2h]
        xor edx, edx
        call SetFaceBlink
.3:
        test byte [byte ebx+01Ch], 80h
        je near .5
        mov eax, esi
        call ResetAnimTimer
        test byte [byte esi+030h], 4
        jne short .4
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov al, byte [dword ecx+0BFh]
        xor ebx, ebx
        or al, 20h
        mov edx, 174h
        mov byte [dword ecx+0BFh], al
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        jmp short .6
.4:
        mov bh, byte [dword ecx+0BFh]
        mov edx, 16Bh
        or bh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        mov ebx, 840h
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0F6h]
        mov eax, dword [eax]
        mov edx, dword [eax]
        mov dl, byte [byte edx+0Dh]
        and edx, 0FFh
        dec edx
        call SetAnimFrame
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        test byte [byte esi+030h], 4
        jne short .6
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov eax, ecx
        mov edx, esp
        call MoveToAnimPose
        mov eax, ecx
        call ApplySkateAccel
        mov edx, esp
        mov eax, ebx
        call StepMove
.6:
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FightFallMove                                   716F8  97 PC, low confidence
; Move handler for falling in a fight
;-----------------------------------------------------------------------------
FightFallMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        xor edx, edx
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edi, SortCords
        shl eax, 3
        add edi, eax
        mov ah, byte [byte ebx+01Ch]
        mov esi, dword [dword ecx+0FAh]
        test ah, 80h
        je short .1
        mov eax, esi
        call ResetAnimTimer
        mov dh, byte [dword ecx+0BFh]
        mov ebx, 840h
        or dh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], dh
        mov edx, 16Ch
        push dword 3F800000h
        call SetSPA
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov eax, dword [dword ecx+0F6h]
        mov eax, dword [eax]
        mov edx, dword [eax]
        mov dl, byte [byte edx+0Dh]
        and edx, 0FFh
        dec edx
        call SetAnimFrame
        jmp short .2
.1:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov eax, ecx
        mov edx, esp
        call MoveToAnimPose
        mov eax, ecx
        call ApplySkateAccel
        mov edx, esp
        mov eax, ecx
        call FaceAngleDelta
        mov edx, esp
        mov eax, ebx
        call StepMove
        test byte [byte esi+030h], 4
        je short .2
        mov edx, edi
        mov eax, ecx
        call FightPositionMove
.2:
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
StartFightPunchJumpTable:                       ; jump table for the switch cases of StartFightPunch
        dd StartFightPunch_86
        dd StartFightPunch_8B
        dd StartFightPunch_8B
        dd StartFightPunch_91
        dd StartFightPunch_97
StartFightPunchHitJumpTable:                    ; jump table for the switch cases of StartFightPunch
        dd StartFightPunch_186
        dd StartFightPunch_18B
        dd StartFightPunch_18B
        dd StartFightPunch_191
        dd StartFightPunch_197
;-----------------------------------------------------------------------------
; StartFightPunch                                 71808  97 PC, low confidence
; Starts a punch in a fight
;-----------------------------------------------------------------------------
StartFightPunch:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov esi, eax
        xor eax, eax
        mov al, byte [byte esi+06Ch]
        mov ecx, eax
        mov edi, dword [dword esi+0FAh]
        shl ecx, 5
        mov dl, byte [byte edi+030h]
        add ecx, eax
        mov eax, dword [dword esi+0F6h]
        and dl, 0BFh
        mov eax, dword [eax]
        shl ecx, 3
        mov eax, dword [byte eax+028h]
        add ecx, SortCords
        and eax, 0FFFFh
        mov byte [byte edi+030h], dl
        cmp eax, 161h
        jne near StartFightPunch_97.5
        test dl, 2
        je near StartFightPunch_197.12
        mov eax, edi
        mov edx, 163h
        call ResetAnimTimer
        mov bh, byte [dword esi+0BFh]
        push dword 3F800000h
        or bh, 20h
        mov eax, esi
        mov byte [dword esi+0BFh], bh
        xor ebx, ebx
        mov esi, 8
        call SetSPA
        mov eax, ecx
        jmp dword [dword cs:esi+StartFightPunchJumpTable]
StartFightPunch_86:
        dec dword [byte ecx+056h]
        jmp short StartFightPunch_97.1
StartFightPunch_8B:
        sub dword [byte eax+056h], byte 2
        jmp short StartFightPunch_97.1
StartFightPunch_91:
        sub dword [byte ecx+056h], byte 3
        jmp short StartFightPunch_97.1
StartFightPunch_97:
        sub dword [byte ecx+056h], byte 4
.1:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        cmp dword [byte ecx+056h], byte 0
        setle al
        and eax, 0FFh
        je short .4
        test byte [dword ecx+0BFh], 40h
        je short .2
        mov eax, 0Ah
        jmp short .3
.2:
        mov eax, 1
.3:
        call SetCrowdMood
        mov dl, byte [dword ecx+0BFh]
        mov eax, ecx
        or dl, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], dl
        mov edx, 167h
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0EEh]
        or byte [byte eax+031h], 1
        or byte [dword ecx+0BFh], 20h
        and byte [byte edi+030h], 0FDh
        mov eax, dword [dword ecx+0FAh]
        and byte [byte eax+030h], 0FDh
        jmp near StartFightPunch_197.12
.4:
        mov al, byte [dword ecx+0BFh]
        mov edx, 165h
        or al, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], al
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        cmp eax, 16Bh
        jne near StartFightPunch_197.10
        test dl, 4
        je near StartFightPunch_197.12
        mov eax, edi
        mov edx, 16Dh
        call ResetAnimTimer
        mov bh, byte [dword esi+0BFh]
        push dword 3F800000h
        or bh, 20h
        mov eax, esi
        mov byte [dword esi+0BFh], bh
        xor ebx, ebx
        mov esi, 10h
        call SetSPA
        mov eax, ecx
        jmp dword [dword cs:esi+StartFightPunchHitJumpTable]
StartFightPunch_186:
        dec dword [byte ecx+056h]
        jmp short StartFightPunch_197.6
StartFightPunch_18B:
        sub dword [byte eax+056h], byte 2
        jmp short StartFightPunch_197.6
StartFightPunch_191:
        sub dword [byte ecx+056h], byte 3
        jmp short StartFightPunch_197.6
StartFightPunch_197:
        sub dword [byte ecx+056h], byte 4
.6:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        cmp dword [byte ecx+056h], byte 0
        setle al
        and eax, 0FFh
        je short .9
        test byte [dword ecx+0BFh], 40h
        je short .7
        mov eax, 0Ah
        jmp short .8
.7:
        mov eax, 1
.8:
        call SetCrowdMood
        mov dl, byte [dword ecx+0BFh]
        mov eax, ecx
        or dl, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], dl
        mov edx, 16Fh
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0EEh]
        or byte [byte eax+031h], 1
        or byte [dword ecx+0BFh], 20h
        and byte [byte edi+030h], 0F9h
        mov eax, dword [dword ecx+0FAh]
        and byte [byte eax+030h], 0FBh
        mov eax, dword [dword ecx+0FAh]
        and byte [byte eax+030h], 0FDh
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov al, byte [dword ecx+0BFh]
        mov edx, 16Eh
        or al, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], al
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        cmp eax, 158h
        je short .11
        cmp eax, 169h
        je short .11
        cmp eax, 16Ah
        jne short .12
.11:
        mov eax, edi
        call ResetAnimTimer
        mov dh, byte [dword esi+0BFh]
        xor ebx, ebx
        or dh, 20h
        mov eax, esi
        mov byte [dword esi+0BFh], dh
        mov edx, 15Ch
        push dword 3F800000h
        call SetSPA
.12:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
StartFightBlockJumpTable:                       ; jump table for the switch cases of StartFightBlock
        dd StartFightBlock_86
        dd StartFightBlock_8B
        dd StartFightBlock_8B
        dd StartFightBlock_91
        dd StartFightBlock_97
StartFightBlockHitJumpTable:                    ; jump table for the switch cases of StartFightBlock
        dd StartFightBlock_186
        dd StartFightBlock_18B
        dd StartFightBlock_18B
        dd StartFightBlock_191
        dd StartFightBlock_197
;-----------------------------------------------------------------------------
; StartFightBlock                                 71ABC  97 PC, low confidence
; Starts a block in a fight
;-----------------------------------------------------------------------------
StartFightBlock:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov esi, eax
        xor eax, eax
        mov al, byte [byte esi+06Ch]
        mov ecx, eax
        mov edi, dword [dword esi+0FAh]
        shl ecx, 5
        mov dl, byte [byte edi+030h]
        add ecx, eax
        mov eax, dword [dword esi+0F6h]
        and dl, 0BFh
        mov eax, dword [eax]
        shl ecx, 3
        mov eax, dword [byte eax+028h]
        add ecx, SortCords
        and eax, 0FFFFh
        mov byte [byte edi+030h], dl
        cmp eax, 161h
        jne near StartFightBlock_97.5
        test dl, 2
        je near StartFightBlock_197.12
        mov eax, edi
        mov edx, 164h
        call ResetAnimTimer
        mov bh, byte [dword esi+0BFh]
        push dword 3F800000h
        or bh, 20h
        mov eax, esi
        mov byte [dword esi+0BFh], bh
        xor ebx, ebx
        mov esi, 0Ch
        call SetSPA
        mov eax, ecx
        jmp dword [dword cs:esi+StartFightBlockJumpTable]
StartFightBlock_86:
        dec dword [byte ecx+056h]
        jmp short StartFightBlock_97.1
StartFightBlock_8B:
        sub dword [byte eax+056h], byte 2
        jmp short StartFightBlock_97.1
StartFightBlock_91:
        sub dword [byte ecx+056h], byte 3
        jmp short StartFightBlock_97.1
StartFightBlock_97:
        sub dword [byte ecx+056h], byte 4
.1:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        cmp dword [byte ecx+056h], byte 0
        setle al
        and eax, 0FFh
        je short .4
        test byte [dword ecx+0BFh], 40h
        je short .2
        mov eax, 0Ah
        jmp short .3
.2:
        mov eax, 1
.3:
        call SetCrowdMood
        mov dl, byte [dword ecx+0BFh]
        mov eax, ecx
        or dl, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], dl
        mov edx, 168h
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0EEh]
        or byte [byte eax+031h], 1
        or byte [dword ecx+0BFh], 20h
        and byte [byte edi+030h], 0FDh
        mov eax, dword [dword ecx+0FAh]
        and byte [byte eax+030h], 0FDh
        jmp near StartFightBlock_197.12
.4:
        mov al, byte [dword ecx+0BFh]
        mov edx, 166h
        or al, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], al
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        cmp eax, 16Bh
        jne near StartFightBlock_197.10
        test dl, 4
        je near StartFightBlock_197.12
        mov eax, edi
        mov edx, 16Dh
        call ResetAnimTimer
        mov bh, byte [dword esi+0BFh]
        push dword 3F800000h
        or bh, 20h
        mov eax, esi
        mov byte [dword esi+0BFh], bh
        xor ebx, ebx
        mov esi, 10h
        call SetSPA
        mov eax, ecx
        jmp dword [dword cs:esi+StartFightBlockHitJumpTable]
StartFightBlock_186:
        dec dword [byte ecx+056h]
        jmp short StartFightBlock_197.6
StartFightBlock_18B:
        sub dword [byte eax+056h], byte 2
        jmp short StartFightBlock_197.6
StartFightBlock_191:
        sub dword [byte ecx+056h], byte 3
        jmp short StartFightBlock_197.6
StartFightBlock_197:
        sub dword [byte ecx+056h], byte 4
.6:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        cmp dword [byte ecx+056h], byte 0
        setle al
        and eax, 0FFh
        je short .9
        test byte [dword ecx+0BFh], 40h
        je short .7
        mov eax, 0Ah
        jmp short .8
.7:
        mov eax, 1
.8:
        call SetCrowdMood
        mov dl, byte [dword ecx+0BFh]
        mov eax, ecx
        or dl, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], dl
        mov edx, 16Fh
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0EEh]
        or byte [byte eax+031h], 1
        or byte [dword ecx+0BFh], 20h
        and byte [byte edi+030h], 0F9h
        mov eax, dword [dword ecx+0FAh]
        and byte [byte eax+030h], 0FDh
        mov eax, dword [dword ecx+0FAh]
        and byte [byte eax+030h], 0FBh
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov al, byte [dword ecx+0BFh]
        mov edx, 16Eh
        or al, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], al
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        cmp eax, 158h
        je short .11
        cmp eax, 169h
        je short .11
        cmp eax, 16Ah
        jne short .12
.11:
        mov eax, edi
        call ResetAnimTimer
        mov dh, byte [dword esi+0BFh]
        xor ebx, ebx
        or dh, 20h
        mov eax, esi
        mov byte [dword esi+0BFh], dh
        mov edx, 15Dh
        push dword 3F800000h
        call SetSPA
.12:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; StartFightGrab                                  71D48  97 PC, low confidence
; Starts a grab in a fight
;-----------------------------------------------------------------------------
StartFightGrab:
        push ebx
        push ecx
        push edx
        push esi
        mov ecx, eax
        xor edx, edx
        mov dl, byte [byte eax+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov esi, SortCords
        shl eax, 3
        add esi, eax
        mov eax, dword [dword ecx+0F6h]
        mov eax, dword [eax]
        mov edx, dword [byte eax+028h]
        and edx, 0FFFFh
        mov eax, dword [dword ecx+0FAh]
        cmp edx, 161h
        jne near .1
        mov dl, byte [byte eax+030h]
        test dl, 2
        je near .3
        mov dh, dl
        or dh, 4
        mov byte [byte eax+030h], dh
        call ResetAnimTimer
        mov bl, byte [dword ecx+0BFh]
        mov edx, 16Bh
        or bl, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        mov ebx, 40h
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword esi+0FAh]
        or byte [byte eax+030h], 4
        mov eax, dword [dword esi+0FAh]
        call ResetAnimTimer
        mov al, byte [dword esi+0BFh]
        mov edx, 16Ch
        or al, 20h
        mov ebx, 40h
        mov byte [dword esi+0BFh], al
        mov eax, esi
        push dword 3F800000h
        call SetSPA
        mov dword [byte ecx+05Ah], 3E8h
        mov dword [byte esi+05Ah], 0FFFFFC18h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        cmp edx, 158h
        je short .2
        cmp edx, 169h
        je short .2
        cmp edx, 16Ah
        jne short .3
.2:
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        mov ebx, 40h
        or ah, 20h
        mov edx, 161h
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
.3:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; StartFightPull                                  71E58  97 PC, low confidence
; Starts a jersey pull in a fight
;-----------------------------------------------------------------------------
StartFightPull:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        xor edx, edx
        mov dl, byte [byte eax+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov ecx, SortCords
        shl eax, 3
        add ecx, eax
        mov eax, dword [dword esi+0FAh]
        mov dl, byte [byte eax+030h]
        test dl, 4
        je short .1
        and dl, 0F9h
        mov byte [byte eax+030h], dl
        mov edx, dword [dword ecx+0FAh]
        and byte [byte edx+030h], 0FBh
        mov edx, dword [dword ecx+0FAh]
        and byte [byte edx+030h], 0FDh
        call ResetAnimTimer
        mov al, byte [dword esi+0BFh]
        mov edx, 173h
        or al, 20h
        xor ebx, ebx
        mov byte [dword esi+0BFh], al
        mov eax, esi
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        mov edx, 174h
        jmp short .2
.1:
        test dl, 2
        je short .3
        mov bl, dl
        and bl, 0FDh
        mov byte [byte eax+030h], bl
        mov edx, dword [dword ecx+0FAh]
        and byte [byte edx+030h], 0FDh
        call ResetAnimTimer
        mov al, byte [dword esi+0BFh]
        mov edx, 170h
        or al, 20h
        xor ebx, ebx
        mov byte [dword esi+0BFh], al
        mov eax, esi
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        mov edx, 171h
.2:
        or ah, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
.3:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StartFightAnim                                  71F4C  97 PC, low confidence
; From StartFight: the fighter's start move (SPA 176h or 159h by +0D0h)
;-----------------------------------------------------------------------------
StartFightAnim:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov eax, dword [dword eax+0FAh]
        call ResetAnimTimer
        xor ebx, ebx
        mov ah, byte [dword ecx+0BFh]
        push dword 3F800000h
        or ah, 20h
        mov dl, byte [dword ecx+0D0h]
        mov byte [dword ecx+0BFh], ah
        test dl, dl
        je short .1
        mov edx, 176h
        jmp short .2
.1:
        mov edx, 159h
.2:
        mov eax, ecx
        call SetSPA
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov eax, dword [dword ecx+0F2h]
        call ClearObjectHidden
        pop edx
        pop ecx
        pop ebx
        ret
