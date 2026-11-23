; Player control: switching, pad slots, joysticks, line change input, skating, pass and shot buttons.
bits 32
%include "hockey.inc"
section s_34324 progbits alloc exec nowrite align=1
extern __CHP, assexit, AwayControlSlot, AwayEbenPlayer, AwayGoalieOff, AwPlayerEnergy, bholdtimer, CanReceivePass
extern ChangePlayer, checkob, ChkPokeOrCheck, CreditPass, DefendFlags, DoCheckButton, F64_0p159155_ChkPassTo, F64_0p159155_doinput
extern F64_0p159155_DoPassButton, F64_0p159155_DoShootButton, F64_0p159155_FaceDirFromMotion, F64_0p159155_JoySkate, F64_0p392699_ChkPassTo, F64_0p392699_doinput, F64_0p392699_DoPassButton, F64_0p392699_DoShootButton
extern F64_0p392699_FaceDirFromMotion, F64_0p392699_JoySkate, F64_0p75, F64_0p785398_doplayeracc, F64_0p785398_SetSkateDir, F64_240_ChkGrabPuckOnSwitch, F64_65536_ChkPassTo, F64_65536_doinput
extern F64_65536_DoPassButton, F64_65536_DoShootButton, F64_65536_FaceDirFromMotion, F64_65536_JoySkate, FaceoffDrawAnim, FaceoffSlots, FaceoffSwipeAnim, FaceoffWinner
extern FaceoffX, FaceoffY, fofdata2, gameopts, gmode, GoalieTarget, HmLineState, HmPlayerEnergy
extern HmPlayersInBox, HomeControlSlot, HomeEbenPlayer, HomeGoalieOff, HomeSkaters, HomeTeamRecord, HumanStickAction, hypot_
extern InputActive, InputButtons, InputDir, InputSlotPlayers, InputState, JoyButtonsTable, JoyStateTable, LineChangeAway
extern LineChangeCommentary, LineChangeHome, LineChangeKeys, ObjectFramePos, OneTimerPasser, onetimerplayer, OneTimerReady, PadSlotA
extern PadSlotB, PadStates, PassButtonHeld, PassButtonTimes, PassDistX, PassDistY, PassPlayer, PassReceiver
extern PassState, PassTarget, penshotlive, penshotmode, PickShotTarget, PlayerControlFlags, PlayerControlWords, PlayerStateFlags
extern gmode2, PtrPuckFlags, PtrPuckMotion, PtrPuckOwner, PtrPuckTarget, puckc, PuckChasers, PuckFlags
extern PuckOwnerTeam, QueueOverlayPanel, randomd0, ReachForPuckAnim, regd1, ReplayPlaying, RimTargetX, dirtab_y
extern SetAnimFrame, setpersonel, ShootButtonTime, ShotAnimFrames, ShotSpeed, ShotState, ShotTarget, ShotTimer
extern ShotType, SlotAssign, SlotJoyMap, SlotPlayers, slotteam, SortCords, SpeedScale, StartFaceoffLineChange
extern StartOneTimerAnim, StartPass, StartShot, StickPointId, StickReachX, UpdateShot, vtoa, ZoneFlags
extern ZoneTargetX, ZoneTargetY
global SetPlayerTarget, restorepl, SetSlotPlayer, GiveControl, ChkGrabPuckOnSwitch, changeplayer, AutoSwitchToCarrier, InitPadSlots
global SlotToJoy, ReadJoy1, RequestLineChange, LineChangeKey, DoLineChangeInput, faceoffinput, FaceDirFromMotion, doplayeracc
global SetSkateDir, JoySkate, JoyDirSkate, FindPassTarget, FindPassTarget_E0, ChkPassTo, DoPassButton, ShotAimDir
global DoShootButton, ChkOneTimerSpot, ClearLastPasser, onetimershot, doinput, CountTeamSlots, DebugRestoreEnergy
%if VERSION = 11
        add byte [eax], al
        add byte [eax], al
        add byte [eax], al
        add byte [eax], al
%else
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
%endif
;-----------------------------------------------------------------------------
; SetPlayerTarget                                 34330  97 PC, low confidence
; (player, object): sets the player's target object (+0BAh) and its flag
; (+0BFh bit 3)
;-----------------------------------------------------------------------------
SetPlayerTarget:
        test edx, edx
        jge short .1
        and byte [dword eax+0BFh], 0F7h
        jmp short .2
.1:
        or byte [dword eax+0BFh], 8
.2:
        mov word [dword eax+0BAh], dx
        ret
;-----------------------------------------------------------------------------
; restorepl                        3434C  93G logic93_1.asm, medium confidence
; eax = new controlled player, edx = old one.
;-----------------------------------------------------------------------------
restorepl:
        push ebx
        push ecx
        push esi
        mov ebx, eax
        mov esi, edx
        movsx ecx, dx
        mov cx, word [nosplit ecx*2+SlotAssign]
        test cx, cx
        jl short .1
        cmp cx, byte 0Bh
        jg short .1
        movsx edx, cx
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        or byte [dword eax+0BFh], 2
        mov edx, 0FFFFFFFFh
        and byte [dword eax+0BFh], 0F7h
        mov word [dword eax+0BAh], dx
.1:
        test bx, bx
        jl short .5
        cmp bx, byte 0Bh
        jg short .5
        movsx edx, bx
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edx, SortCords
        shl eax, 3
        movsx ecx, cx
        add edx, eax
        mov eax, ecx
        shl eax, 5
        add eax, ecx
        test byte [nosplit eax*8+PlayerStateFlags], 8
        je short .2
        or byte [dword edx+0C0h], 8
.2:
        movsx eax, si
        mov esi, edx
        mov ecx, eax
        test eax, eax
        jge short .3
        and byte [dword edx+0BFh], 0F7h
        jmp short .4
.3:
        or byte [dword edx+0BFh], 8
.4:
        mov word [dword esi+0BAh], cx
.5:
        mov eax, ebx
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetSlotPlayer                                   343F8  97 PC, low confidence
; (slot, player): gives a control slot a new player (restorepl) when it
; changes
;-----------------------------------------------------------------------------
SetSlotPlayer:
        push ebx
        push ecx
        lea ecx, [nosplit eax*2+00h]
        mov ebx, dword [dword ecx+SlotPlayers]
        sar ebx, 10h
        cmp edx, ebx
        je short .1
        cwde
        movsx ebx, dx
        mov edx, eax
        mov eax, ebx
        call restorepl
        mov word [dword ecx+SlotAssign], ax
.1:
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; GiveControl                                  34428  95 PC, medium confidence
; Physics caller: gives the human the player who got the puck (restorepl)
;-----------------------------------------------------------------------------
GiveControl:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov esi, eax
        movsx edx, ax
        mov eax, edx
        shl eax, 5
        add eax, edx
        cmp word [nosplit eax*8+PlayerControlWords], byte 0
        jge near .8
        cmp si, byte 6
        jge short .1
        cmp word [HomeGoalieOff], byte 0
        je near .8
        mov word [regd1], 1
        jmp short .2
.1:
        cmp word [AwayGoalieOff], byte 0
        je near .8
        mov word [regd1], 2
.2:
        cmp si, byte 6
        jge short .3
        mov ax, word [HomeControlSlot]
        jmp short .4
.3:
        mov ax, word [AwayControlSlot]
.4:
        movsx ecx, ax
        mov edx, ecx
        cmp ecx, byte 8
        jge short .7
        lea eax, [nosplit ecx*2+00h]
.5:
        mov di, word [regd1]
        cmp di, word [dword eax+slotteam]
        jne short .6
        mov bx, word [PuckOwnerTeam]
        cmp bx, word [dword eax+SlotAssign]
        jne short .6
        mov ecx, edx
        jmp short .7
.6:
        add eax, byte 2
        inc edx
        cmp eax, byte 10h
        jl short .5
.7:
        test ecx, ecx
        jl short .8
        mov ebx, ecx
        add ecx, ecx
        mov edx, dword [dword ecx+SlotPlayers]
        movsx eax, si
        sar edx, 10h
        mov esi, eax
        cmp eax, edx
        je short .8
        movsx edx, bx
        cwde
        call restorepl
        mov word [dword ecx+SlotAssign], ax
.8:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ChkGrabPuckOnSwitch                             34500  97 PC, low confidence
; From changeplayer: the new controlled player close enough to the puck takes
; it (ReachForPuckAnim)
;-----------------------------------------------------------------------------
ChkGrabPuckOnSwitch:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ecx, eax
        cmp word [dword eax+0A9h], byte 0
        jle short .1
        mov ebx, esp
        mov edx, dword [StickPointId]
        call ObjectFramePos
        mov ebx, dword [PtrPuckFlags]
        fld dword [byte esp+08h]
        fsub dword [byte ebx+028h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+08h]
        fsub dword [byte ebx+020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_240_ChkGrabPuckOnSwitch]
        fnstsw ax
        sahf
        ja short .1
        mov eax, ecx
        call ReachForPuckAnim
.1:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; changeplayer                     34560  93G logic93_1.asm, medium confidence
; Human control moves to the best teammate (Sweepcheck); restorepl gives
; the old player his assignment back. Callers: input, physics, player logic, assignments.
;-----------------------------------------------------------------------------
changeplayer:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov ebp, eax
        mov word [byte esp+08h], dx
        mov ecx, edx
        test byte [dword eax+0BFh], 40h
        setne al
        and eax, 0FFh
        mov dh, byte [gmode]
        mov ebx, eax
        test dh, 1
        je short .1
        mov edx, dword [byte esp+06h]
        xor esi, esi
        sar edx, 10h
        mov dword [nosplit eax*4+PuckChasers], esi
        mov dword [nosplit edx*4+PassButtonTimes], esi
.1:
        movsx eax, cx
        shl eax, 2
        mov edx, dword [dword eax+PassButtonTimes]
        test edx, edx
        je short .2
        xor ebp, ebp
        mov dword [dword eax+PassButtonTimes], ebp
        jmp near .23
.2:
        lea eax, [nosplit ebx*4+00h]
        cmp dword [dword eax+PuckChasers], byte 0
        je short .3
        mov esi, dword [dword eax+ChangePlayer]
        mov dl, byte [dword ebp+0A4h]
        cmp edx, esi
        jne short .3
        mov dword [dword eax+PuckChasers], 2
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.3:
        mov eax, ebx
        shl eax, 4
        add eax, ebx
        shl eax, 2
        sub eax, ebx
        cmp word [nosplit eax*4+HmLineState], byte 0
        setge dl
        mov ax, word [nosplit eax*4+HmPlayersInBox]
        xor dh, dh
        sub eax, edx
        mov edx, dword [dword ebp+0AEh]
        sar edx, 18h
        cmp byte [dword edx+ebp+0B2h], 12h
        jne short .4
        dec eax
.4:
        test ebx, ebx
        je short .5
        mov dx, word [AwayGoalieOff]
        jmp short .6
.5:
        mov dx, word [HomeGoalieOff]
.6:
        cmp ax, dx
        jge near .14
        test ebx, ebx
        je short .7
        mov ax, word [AwayEbenPlayer]
        jmp short .8
.7:
        mov ax, word [HomeEbenPlayer]
.8:
        cmp ax, word [byte esp+08h]
        jne near .14
        mov eax, dword [gameopts]
        test byte [byte eax+02h], 2
        je near .13
        mov eax, dword [byte esp+06h]
        sar eax, 10h
        cmp word [nosplit eax*2+slotteam], byte 2
        jne short .9
        mov eax, HomeTeamRecord+420h
        jmp short .10
.9:
        mov eax, SortCords
.10:
        xor edx, edx
.11:
        cmp word [dword eax+0A9h], byte 0
        jne short .12
        mov ebx, dword [byte esp+06h]
        mov al, byte [dword eax+0A4h]
        sar ebx, 10h
        mov esi, ebx
        add ebx, ebx
        mov edx, dword [dword ebx+SlotPlayers]
        and eax, 0FFh
        sar edx, 10h
        mov ecx, eax
        cmp eax, edx
        je near .23
        movsx edx, si
        cwde
        call restorepl
        mov word [dword ebx+SlotAssign], ax
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.12:
        inc edx
        add eax, 108h
        cmp dx, byte 6
        jl short .11
.13:
        mov ebx, dword [byte esp+06h]
        sar ebx, 10h
        add ebx, ebx
        cmp word [dword ebx+SlotAssign], byte 0
        jl near .23
        mov edx, dword [dword ebx+SlotPlayers]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        mov edi, 0FFFFFFFFh
        add eax, SortCords
        mov word [dword ebx+SlotAssign], di
        mov edx, 0FFFFFFFFh
        mov cl, byte [dword eax+0BFh]
        mov word [dword eax+0BAh], dx
        and cl, 0F7h
        mov byte [dword eax+0BFh], cl
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.14:
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [PtrPuckTarget]
        mov edx, dword [byte eax+010h]
        movsx ebx, word [ebx]
        sar edx, 0Dh
        add edx, ebx
        mov eax, dword [byte eax+018h]
        mov word [byte esp+0Ch], dx
        mov edx, dword [PtrPuckOwner]
        sar eax, 0Dh
        movsx edx, word [edx]
        add eax, edx
        mov word [esp], ax
        mov eax, dword [byte esp+06h]
        sar eax, 10h
        cmp word [nosplit eax*2+slotteam], byte 2
        jne short .15
        mov eax, HomeTeamRecord+420h
        jmp short .16
.15:
        mov eax, SortCords
.16:
        xor edx, edx
        mov dl, byte [dword ebp+0A4h]
        mov esi, 7FFFFFFFh
        mov word [byte esp+04h], dx
        xor edx, edx
.17:
        cmp word [dword eax+0A9h], byte 0
        jle short .19
        test byte [dword eax+0C0h], 4
        jne short .19
        test byte [dword eax+0BFh], 20h
        jne short .19
        mov ecx, dword [byte esp+0Ah]
        mov ebx, dword [byte eax+04h]
        sar ecx, 10h
        sar ebx, 10h
        sub ecx, ebx
        mov edi, dword [byte esp-02h]
        mov ebx, ecx
        mov ecx, dword [byte eax+0Ch]
        sar edi, 10h
        sar ecx, 10h
        sub edi, ecx
        mov ecx, edi
        mov edi, ebx
        imul edi, edi
        mov ebx, ecx
        imul ebx, ebx
        add ebx, edi
        cmp ebx, esi
        jg short .19
        mov cx, word [dword eax+0BAh]
        test cx, cx
        jl short .18
        cmp cx, word [byte esp+08h]
        jne short .19
.18:
        mov esi, ebx
        xor ebx, ebx
        mov bl, byte [dword eax+0A4h]
        mov word [byte esp+04h], bx
.19:
        inc edx
        add eax, 108h
        cmp dx, byte 6
        jl short .17
        mov edx, dword [byte esp+02h]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edx, SortCords
        shl eax, 3
        add edx, eax
        mov eax, dword [byte esp+06h]
        sar eax, 10h
        mov ebx, dword [byte esp+04h]
        cmp bx, word [nosplit eax*2+SlotAssign]
        jne short .20
        cmp word [dword ebp+0A9h], byte 0
        je short .20
        mov eax, ebp
        call ChkGrabPuckOnSwitch
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.20:
        cmp word [dword edx+0BAh], byte 0
        jl short .21
        mov edx, dword [byte esp+08h]
        cmp dx, word [dword ebp+0BAh]
        jne short .22
.21:
        mov ebx, dword [byte esp+06h]
        sar ebx, 10h
        mov ecx, ebx
        add ebx, ebx
        mov eax, dword [byte esp+02h]
        mov edx, dword [dword ebx+SlotPlayers]
        sar eax, 10h
        sar edx, 10h
        mov esi, eax
        cmp eax, edx
        je short .23
        movsx edx, cx
        cwde
        call restorepl
        mov word [dword ebx+SlotAssign], ax
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.22:
        mov eax, dword [byte esp+06h]
        sar eax, 10h
        mov word [nosplit eax*2+SlotAssign], 0FFFFh
.23:
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AutoSwitchToCarrier                             348DC  97 PC, low confidence
; Auto-switch option (gameopts +2 bit 1): the control slot moves to the
; team's puck carrier
;-----------------------------------------------------------------------------
AutoSwitchToCarrier:
        push ebx
        push ecx
        push esi
        mov ecx, edx
        mov edx, dword [gameopts]
        test byte [byte edx+02h], 2
        je short .1
        mov edx, dword [dword eax+0FEh]
        mov edx, dword [dword edx+0FAh]
        sar edx, 10h
        test edx, edx
        jl short .1
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        test byte [dword eax+PlayerControlFlags], 8
        jne short .1
        test byte [dword eax+PlayerStateFlags], 4
        jne short .1
        movsx eax, cx
        mov esi, eax
        lea ebx, [nosplit eax*2+00h]
        mov eax, dword [dword ebx+SlotPlayers]
        sar eax, 10h
        mov ecx, edx
        cmp edx, eax
        je short .1
        movsx edx, si
        movsx eax, cx
        call restorepl
        mov word [dword ebx+SlotAssign], ax
.1:
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; InitPadSlots                                    34950  97 PC, low confidence
; From InitGameVars: resets the 8 joystick slot records
;-----------------------------------------------------------------------------
InitPadSlots:
        push ecx
        push edx
        mov edx, 8
        xor eax, eax
.1:
        add eax, byte 10h
        mov dword [dword eax+PadSlotB], edx
        xor ecx, ecx
        mov dword [dword eax+PadSlotA], edx
        mov dword [dword eax+FaceoffX], ecx
        mov dword [dword eax+FaceoffY], ecx
        cmp eax, 80h
        jne short .1
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; SlotToJoy                                    34980  96 PC, medium confidence
; Called from ReadJoy1: SlotButtons of one slot to a direction and button
; bits
;-----------------------------------------------------------------------------
SlotToJoy:
        push ebx
        push edx
        xor edx, edx
        mov dx, word [nosplit eax*2+PadStates]
        mov ebx, eax
        mov eax, edx
        shl ebx, 4
        and eax, byte 0Fh
        add ebx, JoyStateTable
        mov al, byte [dword eax+SlotJoyMap]
        and eax, 0FFh
        test dl, 40h
        je short .1
        mov dword [byte ebx+0Ch], 4
        mov dword [byte ebx+04h], eax
        jmp short .2
.1:
        mov dword [byte ebx+0Ch], 0
.2:
        test dl, 20h
        je short .3
        test dl, 10h
        je short .3
        or al, 40h
        pop edx
        pop ebx
        ret
.3:
        test dl, 20h
        je short .4
        or al, 20h
        pop edx
        pop ebx
        ret
.4:
        test dl, 10h
        je short .5
        or al, 10h
.5:
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ReadJoy1                          349E4  94G middle94.asm, medium confidence
; ReadJoy1 ReadJoy2 = ReadJoy1/2, reading byte 0 1 of joyrec instead of the pad.
;-----------------------------------------------------------------------------
ReadJoy1:
        push ebx
        push ecx
        push edx
        mov edx, eax
        call SlotToJoy
        mov ebx, eax
        xor bh, ah
        and bl, 70h
        mov word [regd1], bx
        mov bx, word [nosplit edx*2+JoyButtonsTable]
        mov word [GoalieTarget], bx
        mov bx, word [regd1]
        mov word [DefendFlags], bx
        mov word [nosplit edx*2+JoyButtonsTable], bx
        mov edx, ebx
        mov bx, word [GoalieTarget]
        mov ecx, edx
        xor ebx, edx
        mov word [ZoneTargetY], ax
        and ecx, ebx
        mov word [GoalieTarget], bx
        mov word [regd1], cx
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; RequestLineChange                               34A48  95 PC, low confidence
; (player, line): sets the team's next line (+2), cycles the line count, PA /
; play-by-play event, setpersonel
;-----------------------------------------------------------------------------
RequestLineChange:
        push ebx
        push ecx
        push esi
        mov ecx, eax
        mov ebx, dword [dword eax+0FEh]
        mov ah, byte [dword eax+0C0h]
        and ah, 0F7h
        mov byte [dword ecx+0C0h], ah
        or byte [dword ecx+0BFh], 8
        and byte [byte ebx+016h], 0FDh
        mov eax, dword [ebx]
        sar eax, 10h
        cmp eax, edx
        je short .5
        mov word [byte ebx+02h], dx
        cmp dx, byte 4
        jge short .1
        mov si, word [byte ebx+04h]
        inc esi
        mov word [byte ebx+04h], si
        cmp si, byte 2
        jle short .1
        mov eax, esi
        sub eax, byte 3
        mov word [byte ebx+04h], ax
.1:
        test byte [gmode], 1
        jne short .2
        mov edx, 0A002h
        jmp short .4
.2:
        mov eax, 2
        call randomd0
        test ax, ax
        je short .3
        mov edx, 0A000h
        jmp short .4
.3:
        mov edx, 0A003h
.4:
        mov eax, ecx
        call LineChangeCommentary
.5:
        mov eax, ebx
        call setpersonel
        test byte [dword ecx+0BFh], 40h
        jne short .6
        mov edx, dword [ebx]
        sar edx, 10h
        push edx
        push dword 12Ch
        push byte 7
        jmp short .7
.6:
        mov edx, dword [ebx]
        sar edx, 10h
        push edx
        push dword 12Ch
        push byte 8
.7:
        call QueueOverlayPanel
        add esp, byte 0Ch
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LineChangeKey                                   34B04  97 PC, low confidence
; From doinput: line change key: picks the line (power play +6, penalty kill
; +4) or StartFaceoffLineChange
;-----------------------------------------------------------------------------
LineChangeKey:
        push ebx
        push ecx
        mov ebx, dword [gameopts]
        test byte [byte ebx+01h], 0C0h
        jne short .1
        xor eax, eax
        pop ecx
        pop ebx
        ret
.1:
        test byte [dword eax+0C0h], 8
        jne short .2
        call StartFaceoffLineChange
        xor eax, eax
        pop ecx
        pop ebx
        ret
.2:
        mov ebx, dword [dword eax+0102h]
        mov ecx, dword [dword eax+0FEh]
        mov bx, word [byte ebx+0Eh]
        sub bx, word [byte ecx+0Eh]
        je short .3
        cmp dx, byte 1
        jg short .4
.3:
        test bx, bx
        jne short .5
        cmp dx, byte 3
        jle short .5
.4:
        xor eax, eax
        pop ecx
        pop ebx
        ret
.5:
        test bx, bx
        jge short .6
        add edx, byte 4
        jmp short .7
.6:
        jle short .7
        add edx, byte 6
.7:
        movsx edx, dx
        call RequestLineChange
        mov eax, 1
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DoLineChangeInput                               34B78  97 PC, low confidence
; From doinput: line change buttons and the line select table (LineChangeKeys)
;-----------------------------------------------------------------------------
DoLineChangeInput:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        mov eax, dword [dword eax+0FEh]
        mov dl, byte [byte eax+016h]
        test dl, 1
        je short .1
        mov dh, dl
        and dh, 0FEh
        mov byte [byte eax+016h], dh
.1:
        test byte [dword ebx+0BFh], 40h
        setne al
        mov ch, byte [regd1]
        xor ah, ah
        test ch, 20h
        je short .2
        cwde
        mov edx, dword [nosplit eax*2+FaceoffSlots]
        sar edx, 10h
        mov eax, ebx
        call RequestLineChange
        jmp short .3
.2:
        test ch, 10h
        je short .3
        cwde
        mov edx, dword [nosplit eax*2+FaceoffSlots]
        sar edx, 10h
        mov dx, word [nosplit edx*2+LineChangeKeys]
        mov word [nosplit eax*2+HomeSkaters], dx
.3:
        test byte [dword ebx+0BFh], 8
        je short .4
        cmp dword [bholdtimer], byte 0
        jne short .4
        test byte [dword ebx+0BFh], 20h
        jne short .4
        test byte [dword ebx+0C0h], 1
        jne short .4
        mov edx, dword [ZoneTargetX]
        mov eax, ebx
        sar edx, 10h
        call doplayeracc
.4:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; faceoffinput                                    34C18  97 PC, low confidence
; From doinput: the controlled faceoff player's joystick direction
; (assignment 8)
;-----------------------------------------------------------------------------
faceoffinput:
        push ebx
        push ecx
        push edx
        mov dx, word [ZoneTargetY]
        mov ebx, dword [dword eax+0AEh]
        xor dh, dh
        sar ebx, 18h
        and dl, 0Fh
        mov cl, byte [dword ebx+eax+0B2h]
        movsx edx, dx
        cmp cl, 8
        jne near .11
        mov ch, byte [dword eax+0BFh]
        test ch, 20h
        jne near .11
        test byte [regd1], 10h
        je near .11
        cmp edx, byte 8
        jge short .7
        test ch, 80h
        jne short .1
        xor dl, 4
        mov word [fofdata2], dx
        jmp short .2
.1:
        mov word [FaceoffWinner], dx
.2:
        cmp edx, byte 4
        jne short .3
        xor edx, edx
        jmp short .9
.3:
        jge short .5
        cmp byte [dword eax+0D0h], 0
        je short .4
        mov edx, 0FFFFFFFFh
        jmp short .9
.4:
        mov edx, 1
        jmp short .9
.5:
        cmp byte [dword eax+0D0h], 0
        je short .6
        mov edx, 1
        jmp short .9
.6:
        mov edx, 0FFFFFFFFh
        jmp short .9
.7:
        xor edx, edx
        test ch, 80h
        je short .8
        xor ecx, ecx
        mov word [FaceoffWinner], cx
        jmp short .9
.8:
        xor ebx, ebx
        mov word [fofdata2], bx
.9:
        mov ebx, dword [PtrPuckFlags]
        cmp dword [byte ebx+060h], byte 11h
        jge short .10
        call FaceoffSwipeAnim
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        call FaceoffDrawAnim
.11:
        pop edx
        pop ecx
        pop ebx
        lea eax, [byte eax+00h]
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FaceDirFromMotion                               34CF4  97 PC, low confidence
; The 8-way facing direction from the player's heading (+40h)
;-----------------------------------------------------------------------------
FaceDirFromMotion:
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
        mov eax, dword [puckc]
        movsx eax, byte [eax]
        cmp edx, eax
        je near .7
        fld dword [byte ebx+040h]
        call __CHP
        fistp dword [esp]
        mov eax, dword [esp]
        mov word [byte esp+04h], ax
        fild word [byte esp+04h]
        fadd qword [F64_0p392699_FaceDirFromMotion]
        fmul qword [F64_0p159155_FaceDirFromMotion]
        fmul qword [F64_65536_FaceDirFromMotion]
        call __CHP
        fistp dword [esp]
        mov eax, dword [esp]
        mov edx, eax
        xor dl, al
        and dh, 0E0h
        mov word [byte esp+04h], ax
        mov ecx, edx
        mov word [byte esp+04h], dx
        sar cx, 0Dh
        mov word [byte esp+04h], cx
        test cx, cx
        jge short .1
        mov edi, ecx
        add edi, byte 8
        mov word [byte esp+04h], di
.1:
        mov ecx, dword [byte ebx+04h]
        mov eax, dword [PtrPuckTarget]
        sar ecx, 10h
        movsx eax, word [eax]
        sub eax, ecx
        mov ecx, eax
        mov eax, dword [PtrPuckMotion]
        mov esi, dword [eax]
        mov eax, dword [PtrPuckOwner]
        sar esi, 0Dh
        movsx eax, word [eax]
        add esi, eax
        mov eax, dword [byte ebx+0Ch]
        mov edi, dword [byte esp+04h]
        sar eax, 10h
        mov dh, byte [dword ebx+0BFh]
        sub esi, eax
        test dh, 80h
        jne short .2
        mov dl, byte [byte esp+04h]
        neg esi
        neg eax
        xor dl, 4
        neg ecx
        mov byte [byte esp+04h], dl
.2:
        mov edx, dword [dword ebx+0EEh]
        test byte [byte edx+031h], 8
        jne short .3
        test eax, eax
        jge short .4
        cmp word [byte esp+04h], byte 4
        jne short .4
        movsx edx, si
        movsx eax, cx
        call vtoa
        cwde
        inc eax
        and eax, byte 7
        cmp eax, byte 2
        jg short .4
.3:
        mov eax, dword [dword ebx+0EEh]
        test byte [byte eax+031h], 8
        je near .5
        mov eax, dword [byte esp+02h]
        sar eax, 10h
        sub eax, byte 3
        and eax, byte 7
        cmp eax, byte 2
        jg short .4
        movsx edx, si
        movsx eax, cx
        call vtoa
        cwde
        add eax, byte 2
        and eax, byte 7
        cmp eax, byte 4
        jle short .5
.4:
        mov eax, dword [dword ebx+0EEh]
        and byte [byte eax+028h], 7Fh
        mov cl, byte [dword ebx+0BFh]
        test cl, 8
        jne near .8
        mov eax, dword [PtrPuckOwner]
        mov dx, word [byte ebx+0Eh]
        mov ax, word [eax]
        cmp ax, dx
        setg al
        mov edx, eax
        and edx, 0FFh
        test cl, 80h
        setne al
        and eax, 0FFh
        xor eax, edx
        je near .8
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 43160000h
        jmp short .8
.5:
        mov eax, dword [dword ebx+0EEh]
        test byte [byte eax+031h], 8
        jne short .8
        cmp byte [dword ebx+0A4h], 0Ch
        je short .8
        test byte [gmode], 1
        jne short .8
        test dword [byte ebx+038h], 7FFFFFFFh
        jne short .6
        mov edx, dword [byte ebx+016h]
        mov eax, dword [byte ebx+0Eh]
        sar edx, 10h
        sar eax, 10h
        call vtoa
        movsx edx, ax
        movsx eax, di
        sub edx, eax
        lea eax, [byte edx+01h]
        and eax, byte 7
        cmp eax, byte 2
        jg short .8
.6:
        mov eax, dword [dword ebx+0EEh]
        or byte [byte eax+028h], 80h
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        mov eax, dword [dword ebx+0EEh]
        and byte [byte eax+028h], 7Fh
.8:
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
; doplayeracc                                    34EF8  94G, medium confidence
; (player, direction 0-7, 8+ = none) the player accelerates
; toward the direction (x87 heading, FaceDirFromMotion)
;-----------------------------------------------------------------------------
doplayeracc:
        push ebp
        mov ebp, esp
        sub esp, byte 4
        and esp, byte 0FFFFFFF8h
        mov dword [esp], edx
        xor dh, dh
        and dl, 0Fh
        mov dword [esp], edx
        cmp dx, byte 7
        jle short .1
        cmp word [byte eax+05Eh], byte 0
        jg short .2
        mov edx, dword [dword eax+0EEh]
        mov dword [byte edx+024h], 0
        jmp short .2
.1:
        fild word [esp]
        fmul qword [F64_0p785398_doplayeracc]
        mov edx, dword [dword eax+0EEh]
        fstp dword [byte edx+0Ch]
        cmp word [byte eax+05Eh], byte 0
        jg short .2
        mov edx, dword [dword eax+0EEh]
        mov dword [byte edx+024h], 42C80000h
.2:
        call FaceDirFromMotion
        mov esp, ebp
        pop ebp
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetSkateDir                                     34F58  97 PC, low confidence
; (player, dir 0-7): heading and speed toward a joystick direction, limited
; by the top speed
;-----------------------------------------------------------------------------
SetSkateDir:
        push ebx
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov dword [byte esp+0Ch], edx
        cmp word [byte eax+05Eh], byte 0
        jg short .2
        and dword [byte esp+0Ch], byte 7
        fild dword [byte esp+0Ch]
        fmul qword [F64_0p785398_SetSkateDir]
        mov eax, dword [dword eax+0EEh]
        fstp dword [byte eax+0Ch]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 43480000h
        fld dword [byte ebx+038h]
        fld st0
        fmul qword [F64_0p75]
        faddp
        mov eax, ebx
        fstp dword [byte ebx+038h]
        call StickReachX
        fstp dword [byte esp+08h]
        fld dword [byte ebx+038h]
        fcomp dword [byte esp+08h]
        fnstsw ax
        sahf
        jbe short .1
        mov eax, dword [byte esp+08h]
        mov dword [byte ebx+038h], eax
.1:
        mov word [byte ebx+05Eh], 1Ch
.2:
        mov esp, ebp
        pop ebp
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; JoySkate                                        34FD0  97 PC, low confidence
; From doinput: skating from the joystick direction (SetSkateDir,
; doplayeracc)
;-----------------------------------------------------------------------------
JoySkate:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        sub esp, byte 4
        mov ebx, eax
        test byte [dword eax+0BFh], 8
        je short .1
        mov edx, dword [InputDir]
        cmp edx, byte 8
        jge short .1
        mov eax, edx
        and eax, byte 7
        mov dword [esp], eax
        jmp short .2
.1:
        fld dword [byte ebx+01Ch]
        fadd qword [F64_0p392699_JoySkate]
        fmul qword [F64_0p159155_JoySkate]
        fmul qword [F64_65536_JoySkate]
        call __CHP
        fistp dword [esp]
        mov ecx, dword [esp]
        and ecx, 0E000h
        mov esi, ecx
        mov dword [esp], ecx
        sar esi, 0Dh
        mov dword [esp], esi
        test esi, esi
        jge short .2
        lea ebp, [byte esi+08h]
        mov dword [esp], ebp
.2:
        mov edx, dword [esp]
        mov eax, ebx
        call SetSkateDir
        mov edx, dword [byte esp-02h]
        mov eax, ebx
        sar edx, 10h
        call doplayeracc
        mov eax, ebx
        call ChkPokeOrCheck
        add esp, byte 4
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; JoyDirSkate                                     3505C  97 PC, low confidence
; From doinput: skating from a slot's pad direction (JoyStateTable)
;-----------------------------------------------------------------------------
JoyDirSkate:
        push ebx
        push ecx
        mov ebx, eax
        movsx edx, dx
        mov ecx, JoyStateTable
        shl edx, 4
        add ecx, edx
        cmp dword [byte ecx+0Ch], byte 4
        jne short .1
        mov ecx, dword [byte ecx+04h]
        and ecx, byte 0Fh
        cmp ecx, byte 8
        jge short .1
        mov edx, ecx
        call SetSkateDir
        movsx edx, cx
        mov eax, ebx
        call doplayeracc
        mov eax, 1
        pop ecx
        pop ebx
        ret
.1:
        xor eax, eax
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FindPassTarget                                  3509C  97 PC, low confidence
; Nearest open teammate in the pass direction from the puck (skips the
; passer, off-ice and busy players)
;-----------------------------------------------------------------------------
FindPassTarget:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebp, eax
        mov esi, edx
        cmp byte [dword eax+0A4h], 6
        jae short .1
        xor edx, edx
        jmp short .2
.1:
        mov edx, 6
.2:
        mov ebx, SortCords
        mov eax, edx
        mov dword [esi], 7FFFFFFFh
        shl eax, 5
        xor ecx, ecx
        add eax, edx
        xor edx, edx
        shl eax, 3
        mov dword [esp], edx
        add ebx, eax
.3:
        cmp ebx, ebp
        je near .5
        cmp word [dword ebx+0A9h], byte 0
        jle near .5
        test byte [dword ebx+0C0h], 4
        jne near .5
        test byte [dword ebx+0BFh], 20h
        jne short .5
        mov eax, dword [dword ebx+0EEh]
        test byte [byte eax+031h], 1
        jne short .5
        mov edx, dword [byte ebx+04h]
        mov eax, dword [PtrPuckTarget]
        sar edx, 10h
        movsx eax, word [eax]
        sub edx, eax
        mov edi, dword [byte ebx+0Ch]
        mov eax, edx
        mov edx, dword [PtrPuckOwner]
        sar edi, 10h
        movsx edx, word [edx]
        sub edi, edx
        cwde
        movsx edx, di
        call vtoa
        movsx edx, ax
        mov eax, dword [PassDistY]
        sar eax, 10h
        sub edx, eax
        mov eax, edx
        and eax, byte 7
        cmp eax, byte 1
        jle short .4
        cmp eax, byte 7
        jne short .5
.4:
        mov edi, dword [esi]
        mov eax, dword [dword ebx+0E2h]
        cmp eax, edi
        jg short .5
        mov dword [esp], ebx
        mov dword [esi], eax
.5:
        inc ecx
        add ebx, 108h
        cmp ecx, byte 6
        jl near .3
        mov eax, dword [esp]
FindPassTarget_E0:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ChkPassTo                                       35188  97 PC, low confidence
; Pass target found and lane open (CanReceivePass): pass direction
;-----------------------------------------------------------------------------
ChkPassTo:
        push ebx
        push ecx
        push edi
        push ebp
        sub esp, byte 8
        mov ecx, eax
        mov ebx, edx
        mov edx, esp
        call FindPassTarget
        mov dword [ebx], eax
        test eax, eax
        je near .3
        je short .1
        cmp word [dword eax+0A9h], byte 0
        je near .3
.1:
        mov eax, ecx
        mov edx, dword [ebx]
        call CanReceivePass
        test ax, ax
        je short .3
        fld dword [byte ecx+040h]
        fadd qword [F64_0p392699_ChkPassTo]
        fmul qword [F64_0p159155_ChkPassTo]
        fmul qword [F64_65536_ChkPassTo]
        call __CHP
        fistp dword [byte esp+04h]
        mov edi, dword [byte esp+04h]
        and edi, 0E000h
        mov ebp, edi
        mov dword [byte esp+04h], edi
        sar ebp, 0Dh
        mov dword [byte esp+04h], ebp
        test ebp, ebp
        jge short .2
        lea edx, [byte ebp+08h]
        mov dword [byte esp+04h], edx
.2:
        xor byte [byte esp+04h], 4
        mov eax, dword [PassDistY]
        mov edx, dword [byte esp+04h]
        sar eax, 10h
        sub edx, eax
        lea eax, [byte edx+01h]
        and eax, byte 7
        cmp eax, byte 2
        jge short .3
        mov eax, 1
        jmp short .4
.3:
        xor eax, eax
.4:
        add esp, byte 8
        pop ebp
        pop edi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DoPassButton                                    35234  97 PC, low confidence
; From doinput: pass button: target, pass kind (PassState), StartPass
;-----------------------------------------------------------------------------
DoPassButton:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebx, eax
        test byte [GoalieTarget], 10h
        je short .5
        test byte [DefendFlags], 10h
        jne short .5
.1:
        mov edx, esp
        mov eax, ebx
        call ChkPassTo
        test ax, ax
        je short .2
        mov word [PassState], 2
        jmp short .4
.2:
        cmp dword [esp], byte 0
        je short .3
        xor edi, edi
        mov word [PassState], di
        jmp short .4
.3:
        mov word [PassState], 63h
.4:
        mov edx, dword [esp]
        mov eax, ebx
        call StartPass
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.5:
        test byte [DefendFlags], 10h
        jne short .6
        and byte [PuckFlags], 0FBh
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.6:
        test byte [ZoneTargetY], 8
        jne near FindPassTarget_E0
        mov ax, word [ZoneTargetY]
        xor ah, ah
        and al, 7
        cmp ax, 8
        jge near FindPassTarget_E0
        mov word [PassReceiver], ax
        or byte [ZoneTargetY], 8
        cmp word [dword ebx+0A9h], byte 0
        je near .1
        cmp dword [nosplit edx*4+PassButtonHeld], byte 10h
        jle near .1
        test byte [dword ebx+0BFh], 40h
        setne al
        and eax, 0FFh
        mov esi, 1
        mov dword [nosplit eax*4+PuckChasers], esi
        xor ecx, ecx
        mov ah, byte [dword ebx+0BFh]
        mov cl, byte [dword ebx+0A4h]
        test ah, 40h
        setne al
        and eax, 0FFh
        xor ebp, ebp
        mov dword [nosplit edx*4+PassButtonTimes], esi
        mov dword [nosplit eax*4+ChangePlayer], ecx
        mov dword [nosplit edx*4+PassButtonHeld], ebp
        jmp near .1
        db 08Dh,040h,00h
        push ebx
        push edx
        push esi
        sub esp, byte 4
        fld dword [byte eax+01Ch]
        fadd qword [F64_0p392699_DoPassButton]
        fmul qword [F64_0p159155_DoPassButton]
        fmul qword [F64_65536_DoPassButton]
        call __CHP
        fistp dword [esp]
        mov eax, dword [esp]
        mov edx, eax
        xor dl, al
        and dh, 0E0h
        mov word [PassReceiver], ax
        mov ebx, edx
        mov word [PassReceiver], dx
        sar bx, 0Dh
        mov word [PassReceiver], bx
        test bx, bx
        jge short .7
        mov esi, ebx
        add esi, byte 8
        mov word [PassReceiver], si
.7:
        or byte [PuckFlags], 4
        add esp, byte 4
        pop esi
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ShotAimDir                                      353B4  97 PC, low confidence
; Shot direction from the joystick and the shooter's hand (PassReceiver)
;-----------------------------------------------------------------------------
ShotAimDir:
        push ebx
        push ecx
        push edx
        mov dx, word [byte eax+02h]
        cmp dx, byte 1
        jl short .1
        cmp dx, byte 3
        jg short .1
        test byte [dword eax+0BFh], 80h
        je short .4
        mov eax, 1
        jmp near .7
.1:
        cmp dx, byte 5
        jl short .3
        cmp dx, byte 7
        jg short .3
        test byte [dword eax+0BFh], 80h
        je short .2
        mov eax, 7
        jmp short .7
.2:
        mov eax, 5
        jmp short .7
.3:
        cmp byte [dword eax+0D0h], 0
        sete bl
        mov ecx, ebx
        and ecx, 0FFh
        xor ebx, ebx
        test dx, dx
        sete dl
        mov bl, dl
        xor ebx, ecx
        je short .5
        test byte [dword eax+0BFh], 80h
        je short .4
        mov eax, 1
        jmp short .7
.4:
        mov eax, 3
        mov word [PassReceiver], ax
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        test byte [dword eax+0BFh], 80h
        je short .6
        mov eax, 7
        mov word [PassReceiver], ax
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        mov eax, 5
.7:
        mov word [PassReceiver], ax
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DoShootButton                                   35464  97 PC, low confidence
; From doinput: shoot button: aim, power, target point, StartPass
;-----------------------------------------------------------------------------
DoShootButton:
        push ebx
        push ecx
        push edx
        sub esp, byte 4
        mov ebx, eax
        test byte [dword eax+0BFh], 8
        jne short .1
        mov eax, ebx
        call ShotAimDir
.1:
        mov word [PassState], 0Ah
        call SpeedScale
        call __CHP
        fistp dword [esp]
        mov eax, dword [esp]
        mov word [PassDistX], ax
        mov eax, dword [PassDistY]
        sar eax, 10h
        mov dx, word [byte ebx+06h]
        mov cx, word [nosplit eax*4+RimTargetX]
        add edx, ecx
        mov word [ShootButtonTime], dx
        mov ax, word [nosplit eax*4+dirtab_y]
        mov dx, word [byte ebx+0Eh]
        add eax, edx
        mov word [PassTarget], ax
        xor edx, edx
        mov eax, ebx
        call StartPass
        and byte [PuckFlags], 0F7h
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
        push ebx
        push edx
        test byte [GoalieTarget], 20h
        je short .2
        call DoShootButton
        pop edx
        pop ebx
        ret
.2:
        mov dh, byte [ZoneTargetY]
        test dh, 8
        jne short .3
        mov ax, word [ZoneTargetY]
        mov bl, dh
        xor ah, ah
        or bl, 8
        and al, 7
        mov byte [ZoneTargetY], bl
        mov word [PassReceiver], ax
.3:
        pop edx
        pop ebx
        ret
        push ebx
        push edx
        push esi
        sub esp, byte 4
        fld dword [byte eax+01Ch]
        fadd qword [F64_0p392699_DoShootButton]
        fmul qword [F64_0p159155_DoShootButton]
        fmul qword [F64_65536_DoShootButton]
        call __CHP
        fistp dword [esp]
        mov eax, dword [esp]
        mov edx, eax
        xor dl, al
        and dh, 0E0h
        mov word [PassReceiver], ax
        mov ebx, edx
        mov word [PassReceiver], dx
        sar bx, 0Dh
        mov word [PassReceiver], bx
        test bx, bx
        jge short .4
        mov esi, ebx
        add esi, byte 8
        mov word [PassReceiver], si
.4:
        or byte [PuckFlags], 8
        add esp, byte 4
        pop esi
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ChkOneTimerSpot                                 35588  97 PC, low confidence
; In the attacking zone (570h-1050h) with a teammate ready: one-timer chance
;-----------------------------------------------------------------------------
ChkOneTimerSpot:
        push ebx
        push ecx
        push edx
        push edi
        mov ebx, eax
        cmp word [byte eax+0Eh], byte 0
        jge short .1
        mov eax, dword [byte eax+0Ch]
        sar eax, 10h
        neg eax
        jmp short .2
.1:
        mov eax, dword [byte eax+0Ch]
        sar eax, 10h
.2:
        cmp eax, 570h
        jle near .10
        cmp eax, 1050h
        jge near .10
        mov cx, word [byte ebx+0Eh]
        xor edx, edx
        test cx, cx
        setl al
        mov dl, al
        test byte [dword ebx+0BFh], 80h
        setne al
        and eax, 0FFh
        xor eax, edx
        je near .10
        mov eax, dword [dword ebx+0102h]
        cmp word [byte eax+010h], byte 0
        jl near .10
        cmp byte [dword ebx+0A4h], 6
        jae short .3
        mov eax, 6
        jmp short .4
.3:
        xor eax, eax
.4:
        mov edx, eax
        shl eax, 5
        add eax, edx
        mov edx, SortCords
        shl eax, 3
        add edx, eax
        mov di, word [dword edx+0A9h]
        xor eax, eax
        test di, di
        je short .6
.5:
        inc eax
        add edx, 108h
        cmp eax, byte 6
        jge short .6
        cmp word [dword edx+0A9h], byte 0
        jne short .5
.6:
        mov ecx, dword [byte ebx+04h]
        mov ebx, dword [byte edx+04h]
        sar ecx, 10h
        sar ebx, 10h
        mov eax, 3
        xor ecx, ebx
        je short .9
        cmp word [byte edx+06h], byte 0
        jge short .7
        neg ebx
.7:
        cmp ebx, 90h
        jle short .8
        mov eax, 1
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        cmp ebx, byte 30h
        jle short .9
        mov eax, 2
.9:
        cwde
        call randomd0
        test ax, ax
        jne short .10
        mov eax, 1
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        xor eax, eax
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ClearLastPasser                                 35690  97 PC, low confidence
; Clears OneTimerPasser
;-----------------------------------------------------------------------------
ClearLastPasser:
        push ebx
        cmp word [OneTimerPasser], byte 0
        je short .1
        xor ebx, ebx
        mov word [OneTimerPasser], bx
.1:
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; onetimershot                                    356A8  97 PC, low confidence
; From assonetimer: the one-timer shot itself (CreditPass, assexit)
;-----------------------------------------------------------------------------
onetimershot:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ecx, eax
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov edx, dword [puckc]
        mov eax, dword [byte eax+028h]
        mov bl, byte [edx]
        and eax, 0FFFFh
        test bl, bl
        jge short .1
        mov edx, dword [PtrPuckFlags]
        cmp dword [byte edx+060h], byte 0FFFFFFE0h
        jge near .7
.1:
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        jne short .2
        mov eax, ecx
        call CreditPass
        jmp short .3
.2:
        mov word [onetimerplayer], 0FFFFh
.3:
        and byte [dword ecx+0BFh], 0FEh
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 0Eh
        jne short .4
        mov eax, ecx
        call assexit
.4:
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        je short .5
        test byte [dword ecx+0BFh], 40h
        setne al
        and eax, 0FFh
        xor edi, edi
        mov dword [nosplit eax*4+PuckChasers], edi
.5:
        cmp word [OneTimerReady], byte 0
        je short .6
        mov eax, dword [dword ecx+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+028h]
        and eax, 0FFFFh
        cmp eax, byte 29h
        jl short .6
        cmp eax, byte 2Dh
        jg short .6
        mov eax, ecx
        call StartOneTimerAnim
.6:
        xor edi, edi
        mov word [OneTimerReady], di
        mov word [OneTimerPasser], di
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        cmp word [OneTimerReady], byte 0
        je near .13
        cmp eax, byte 29h
        jl near .11
        cmp eax, byte 2Dh
        jg near .11
        mov ebx, esp
        lea edx, [byte esp+04h]
        call ShotAnimFrames
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [esp]
        mov ebx, dword [byte esp+04h]
        mov esi, dword [byte eax+060h]
        sub edx, ebx
        cmp edx, esi
        jle short .8
        mov ebx, dword [dword ecx+0FAh]
        cmp dword [byte ebx+020h], byte 0
        je short .8
        mov dword [byte eax+060h], edx
.8:
        mov edx, dword [PtrPuckFlags]
        mov eax, dword [esp]
        mov ebp, dword [byte esp+04h]
        mov ebx, dword [byte edx+060h]
        sub eax, ebp
        cmp eax, ebx
        jne near .13
        mov eax, dword [dword ecx+0FAh]
        cmp dword [byte eax+020h], byte 0
        je near .13
        xor esi, esi
        mov word [ShotTarget], si
        mov word [ShotTimer], si
        test byte [dword ecx+0BFh], 80h
        jne short .9
        mov eax, 0FFFFEF50h
        jmp short .10
.9:
        mov eax, 10B0h
.10:
        mov word [ShotSpeed], ax
        mov eax, 40h
        xor edx, edx
        mov word [PassDistX], ax
        mov eax, ecx
        mov word [ShotType], dx
        call PickShotTarget
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+060h], byte 0
        jl short .13
        mov edi, 2
        mov eax, ecx
        mov dword [ShotState], edi
        call StartShot
        mov esi, dword [dword ecx+0F6h]
        mov esi, dword [esi]
        mov ebx, esp
        mov eax, dword [byte esi+028h]
        lea edx, [byte esp+04h]
        and eax, 0FFFFh
        call ShotAnimFrames
        mov ebp, dword [byte esp+04h]
        test ebp, ebp
        jle short .12
        mov edx, dword [PtrPuckFlags]
        mov eax, dword [esp]
        mov edi, dword [byte edx+060h]
        sub eax, ebp
        cmp eax, edi
        jle short .12
        mov edx, dword [esp]
        mov eax, esi
        dec edx
        call SetAnimFrame
.12:
        cmp dword [ReplayPlaying], byte 0
        jne short .13
        mov eax, dword [dword ecx+0FEh]
        mov eax, dword [dword eax+0108h]
        inc word [dword eax+020D9h]
.13:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; doinput                                        358E4  94G, medium confidence
; (from updateplayers): a human player's pad: line changes,
; skating, pass / shoot / check buttons, control switch
;-----------------------------------------------------------------------------
doinput:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebx, eax
        mov ecx, edx
        test byte [dword eax+0BFh], 40h
        setne al
        mov esi, eax
        mov eax, dword [ZoneFlags]
        sar eax, 10h
        mov dword [InputState], eax
        mov ax, word [ZoneTargetY]
        xor ah, ah
        and al, 0Fh
        mov dx, word [penshotmode]
        cwde
        and esi, 0FFh
        mov dword [InputDir], eax
        test dx, dx
        jne short .1
        cmp word [penshotlive], byte 0
        je short .2
.1:
        test byte [gmode], 1
        jne near .55
.2:
        cmp word [nosplit esi*2+LineChangeHome], byte 0
        je near .10
        cmp word [penshotlive], byte 0
        jne near .10
        test esi, esi
        je short .3
        mov eax, dword [HomeGoalieOff]
        sar eax, 10h
        jmp short .4
.3:
        cmp word [HomeGoalieOff], byte 1
        sete al
        and eax, 0FFh
.4:
        test eax, eax
        jne short .7
        test esi, esi
        je short .5
        mov eax, dword [HomeControlSlot]
        sar eax, 10h
        jmp short .6
.5:
        cmp cx, word [HomeControlSlot]
        sete al
        and eax, 0FFh
.6:
        test eax, eax
        je short .10
.7:
        test byte [gmode], 1
        je short .8
        test byte [dword ebx+0C0h], 8
        je short .9
.8:
        mov edx, dword [nosplit esi*2+LineChangeAway]
        mov eax, ebx
        sar edx, 10h
        call LineChangeKey
.9:
        xor edi, edi
        mov word [nosplit esi*2+LineChangeHome], di
.10:
        test byte [gmode2], 1
        je short .11
        mov eax, ebx
        call faceoffinput
        jmp near .55
.11:
        test byte [dword ebx+0C0h], 8
        je short .12
        test byte [gmode], 1
        je short .12
        mov eax, ebx
        call DoLineChangeInput
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.12:
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [dword eax+0AEh]
        sar edx, 18h
        cmp byte [dword edx+eax+0B2h], 43h
        jne short .13
        cmp word [penshotmode], byte 0
        jne short .13
        test byte [regd1], 40h
        je near .55
        mov dword [InputActive], 1
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.13:
        test byte [dword ebx+0BFh], 8
        je near .55
        mov eax, dword [dword ebx+0EEh]
        or byte [byte eax+029h], 1
        test byte [dword ebx+0C0h], 1
        je short .14
        movsx edx, cx
        mov eax, ebx
        call HumanStickAction
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.14:
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        cmp byte [dword ebx+eax+0B2h], 1Dh
        je near .55
        mov dh, byte [DefendFlags]
        test dh, 10h
        je near .19
        test byte [regd1], 10h
        je short .17
        test byte [GoalieTarget], 40h
        je short .15
        test dh, 40h
        je short .16
.15:
        movsx eax, cx
        xor edx, edx
        mov dword [nosplit eax*4+PassButtonTimes], edx
.16:
        movsx eax, cx
        xor edi, edi
        mov dword [nosplit eax*4+PassButtonHeld], edi
        jmp near .19
.17:
        cmp word [dword ebx+0A9h], byte 0
        je short .19
        movsx eax, cx
        shl eax, 2
        cmp dword [dword eax+PassButtonTimes], byte 0
        jne short .18
        inc dword [dword eax+PassButtonHeld]
.18:
        cmp dword [bholdtimer], byte 0
        jne short .19
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ebx+0A4h]
        cmp edx, eax
        je short .19
        cmp dword [nosplit esi*4+PuckChasers], byte 0
        jne short .19
        movsx edx, cx
        lea edi, [nosplit edx*4+00h]
        cmp dword [dword edi+PassButtonHeld], byte 10h
        jle short .19
        mov eax, ebx
        call AutoSwitchToCarrier
        mov dword [dword edi+PassButtonTimes], 1
.19:
        test byte [dword ebx+0BFh], 20h
        je near .28
        mov edx, dword [puckc]
        movzx edi, byte [dword ebx+0A4h]
        movsx eax, byte [edx]
        cmp edi, eax
        je near .55
        cmp dword [bholdtimer], byte 0
        jne near .55
        test byte [GoalieTarget], 10h
        je near .24
        test byte [DefendFlags], 10h
        jne near .55
        cmp word [ZoneTargetY], byte 8
        jge near .23
        cmp byte [edx], 0
        jl short .20
        cmp byte [dword ebx+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [puckc]
        and edx, 0FFh
        cmp byte [eax], 6
        setl al
        and eax, 0FFh
        xor eax, edx
        jne short .21
.20:
        mov eax, 1
        jmp short .22
.21:
        xor eax, eax
.22:
        test eax, eax
        je near .23
        cmp dword [nosplit esi*4+PuckChasers], byte 0
        jne near .23
        cmp word [onetimerplayer], byte 0
        jl short .23
        cmp byte [dword ebx+0A4h], 6
        setb al
        mov edx, eax
        mov si, word [onetimerplayer]
        and edx, 0FFh
        cmp si, byte 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        jne short .23
        mov edi, 1
        mov dh, byte [ZoneTargetY]
        mov bl, byte [InputDir]
        mov ax, word [ZoneTargetY]
        or dh, 8
        or bl, 8
        xor ah, ah
        mov word [OneTimerPasser], di
        and al, 7
        mov byte [ZoneTargetY], dh
        mov byte [InputDir], bl
        mov word [PassReceiver], ax
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.23:
        movsx edx, cx
        mov eax, ebx
        call changeplayer
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.24:
        xor eax, eax
        mov di, word [onetimerplayer]
        mov al, byte [dword ebx+0A4h]
        cmp ax, di
        jne short .26
        test byte [regd1], 20h
        je short .25
        test byte [dword ebx+0C0h], 4
        jne short .25
        cmp byte [edx], 0
        jge short .25
        mov word [OneTimerReady], 1
.25:
        cmp word [OneTimerReady], byte 0
        je near .55
        mov ax, word [InputDir]
        mov word [PassReceiver], ax
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.26:
        mov esi, dword [PassReceiver]
        sar esi, 10h
        mov eax, esi
        shl eax, 5
        add eax, esi
        shl eax, 3
        add eax, SortCords
        cmp byte [edx], 0
        jge near .55
        test byte [regd1], 20h
        je near .55
        test di, di
        jl near .55
        cmp word [dword eax+0A9h], byte 0
        jle near .55
        cmp byte [dword ebx+0A4h], 6
        setb dl
        mov ebx, edx
        and ebx, 0FFh
        cmp di, byte 6
        setl dl
        and edx, 0FFh
        cmp edx, ebx
        jne near .55
        test byte [dword eax+0BFh], 8
        jne near .55
        test byte [dword eax+0C0h], 4
        jne near .55
        movsx edx, cx
        mov al, byte [dword eax+0A4h]
        mov esi, edx
        lea ebx, [nosplit edx*2+00h]
        mov edx, dword [dword ebx+SlotPlayers]
        and eax, 0FFh
        sar edx, 10h
        mov edi, eax
        cmp eax, edx
        je short .27
        movsx edx, si
        cwde
        call restorepl
        mov word [dword ebx+SlotAssign], ax
.27:
        mov word [OneTimerReady], 1
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.28:
        mov eax, dword [puckc]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ebx+0A4h]
        cmp edx, eax
        jne near .41
        mov eax, ebx
        call checkob
        cmp word [dword ebx+0A9h], byte 0
        jne short .29
        test byte [dword ebx+0C0h], 2
        jne near .55
.29:
        mov ah, byte [PuckFlags]
        test ah, 4
        je short .30
        movsx edx, cx
        mov eax, ebx
        call DoPassButton
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.30:
        test ah, 8
        je short .33
        cmp word [dword ebx+0A9h], byte 0
        jne short .32
        test byte [GoalieTarget], 20h
        je short .31
        mov eax, ebx
        call DoShootButton
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.31:
        mov bl, byte [ZoneTargetY]
        test bl, 8
        jne near .55
        mov ax, word [ZoneTargetY]
        mov bh, bl
        xor ah, ah
        or bh, 8
        and al, 7
        mov byte [ZoneTargetY], bh
        mov word [PassReceiver], ax
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.32:
        movsx edx, cx
        mov eax, ebx
        call UpdateShot
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.33:
        test byte [regd1], 10h
        je short .35
        test byte [GoalieTarget], 40h
        jne short .35
        fld dword [byte ebx+01Ch]
        fadd qword [F64_0p392699_doinput]
        fmul qword [F64_0p159155_doinput]
        fmul qword [F64_65536_doinput]
        call __CHP
        fistp dword [esp]
        mov eax, dword [esp]
        mov word [PassReceiver], ax
        xor al, al
        and ah, 0E0h
        mov edx, eax
        mov word [PassReceiver], ax
        sar dx, 0Dh
        mov word [PassReceiver], dx
        test dx, dx
        jge short .34
        mov ecx, edx
        add ecx, byte 8
        mov word [PassReceiver], cx
.34:
        or byte [PuckFlags], 4
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.35:
        cmp word [dword ebx+0A9h], byte 0
        je near .39
        test byte [regd1], 20h
        je short .36
        movsx eax, cx
        xor edi, edi
        mov dword [nosplit eax*4+InputSlotPlayers], edi
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.36:
        test byte [DefendFlags], 20h
        je short .37
        movsx edx, cx
        shl edx, 2
        mov ebp, dword [dword edx+InputSlotPlayers]
        inc ebp
        mov dword [dword edx+InputSlotPlayers], ebp
        cmp ebp, byte 8
        jle near .55
        mov ecx, 2
        mov esi, 0FFFFFFFFh
        mov eax, ebx
        mov dword [ShotState], ecx
        call StartShot
        mov dword [dword edx+InputSlotPlayers], esi
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.37:
        movsx edx, cx
        shl edx, 2
        cmp dword [dword edx+InputSlotPlayers], byte 0
        jl short .38
        test byte [GoalieTarget], 20h
        je short .38
        mov edi, 0FFFFFFFFh
        xor esi, esi
        mov eax, ebx
        mov dword [ShotState], esi
        call StartShot
        mov dword [dword edx+InputSlotPlayers], edi
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.38:
        movsx edx, cx
        mov ecx, 0FFFFFFFFh
        mov eax, ebx
        mov dword [nosplit edx*4+InputSlotPlayers], ecx
        call JoyDirSkate
        test ax, ax
        jne near .55
        jmp near .54
.39:
        test byte [regd1], 20h
        je near .54
        fld dword [byte ebx+01Ch]
        fadd qword [F64_0p392699_doinput]
        fmul qword [F64_0p159155_doinput]
        fmul qword [F64_65536_doinput]
        call __CHP
        fistp dword [esp]
        mov eax, dword [esp]
        mov ebx, eax
        xor bl, al
        and bh, 0E0h
        mov word [PassReceiver], ax
        mov ecx, ebx
        mov word [PassReceiver], bx
        sar cx, 0Dh
        mov word [PassReceiver], cx
        test cx, cx
        jge short .40
        mov edi, ecx
        add edi, byte 8
        mov word [PassReceiver], di
.40:
        or byte [PuckFlags], 8
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.41:
        cmp dword [bholdtimer], byte 0
        jne near .55
        movsx eax, cx
        mov dword [nosplit eax*4+InputSlotPlayers], 0FFFFFFFFh
        cmp word [dword ebx+0A9h], byte 0
        je short .42
        test byte [regd1], 40h
        je short .42
        mov eax, ebx
        call DoCheckButton
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.42:
        test byte [GoalieTarget], 10h
        je near .46
        test byte [DefendFlags], 10h
        jne near .55
        cmp word [ZoneTargetY], byte 8
        jge near .23
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .43
        cmp byte [dword ebx+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [puckc]
        and edx, 0FFh
        cmp byte [eax], 6
        setl al
        and eax, 0FFh
        xor eax, edx
        jne short .44
.43:
        mov eax, 1
        jmp short .45
.44:
        xor eax, eax
.45:
        test eax, eax
        je near .23
        cmp dword [nosplit esi*4+PuckChasers], byte 0
        jne near .23
        cmp word [onetimerplayer], byte 0
        jl near .23
        cmp byte [dword ebx+0A4h], 6
        setb al
        mov edx, eax
        mov si, word [onetimerplayer]
        and edx, 0FFh
        cmp si, byte 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        jne near .23
        mov edi, 1
        mov dl, byte [ZoneTargetY]
        mov ax, word [ZoneTargetY]
        or dl, 8
        mov word [OneTimerPasser], di
        xor ah, ah
        mov byte [ZoneTargetY], dl
        mov dh, byte [InputDir]
        and al, 7
        or dh, 8
        mov word [PassReceiver], ax
        mov byte [InputDir], dh
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.46:
        cmp word [dword ebx+0A9h], byte 0
        je near .54
        mov edx, dword [PassReceiver]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        mov si, word [onetimerplayer]
        add eax, edx
        xor edx, edx
        shl eax, 3
        mov dl, byte [dword ebx+0A4h]
        add eax, SortCords
        cmp dx, si
        jne near .50
        test byte [dword ebx+0C0h], 4
        jne short .47
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jge short .47
        test byte [regd1], 20h
        je short .48
        mov word [OneTimerReady], 1
        jmp short .48
.47:
        test byte [regd1], 20h
        je short .48
        mov eax, ebx
        call JoySkate
.48:
        cmp word [OneTimerReady], byte 0
        je short .49
        mov ax, word [InputDir]
        mov word [PassReceiver], ax
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.49:
        cmp dword [bholdtimer], byte 0
        jne near .55
        movsx edx, cx
        mov eax, ebx
        call JoyDirSkate
        test ax, ax
        jne near .55
        jmp near .54
.50:
        mov edx, dword [puckc]
        cmp byte [edx], 0
        jge near .52
        test byte [regd1], 20h
        je near .52
        test si, si
        jl near .52
        cmp byte [dword ebx+0A4h], 6
        setb dl
        mov di, word [onetimerplayer]
        movzx esi, dl
        cmp di, byte 6
        setl dl
        and edx, 0FFh
        cmp edx, esi
        jne short .52
        test byte [dword eax+0BFh], 8
        jne short .52
        test byte [dword eax+0C0h], 4
        jne short .52
        movsx edx, cx
        xor eax, eax
        mov esi, edx
        mov al, byte [dword ebx+0A4h]
        lea ebx, [nosplit edx*2+00h]
        mov edx, dword [dword ebx+SlotPlayers]
        sar edx, 10h
        mov edi, eax
        cmp eax, edx
        je short .51
        movsx edx, si
        cwde
        call restorepl
        mov word [dword ebx+SlotAssign], ax
.51:
        mov word [OneTimerReady], 1
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.52:
        test byte [regd1], 20h
        je short .53
        mov eax, ebx
        call JoySkate
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.53:
        cmp dword [bholdtimer], byte 0
        jne short .55
        movsx edx, cx
        mov eax, ebx
        call JoyDirSkate
        test ax, ax
        jne short .55
.54:
        mov edx, dword [InputButtons]
        mov eax, ebx
        sar edx, 10h
        call doplayeracc
.55:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CountTeamSlots                               362E0  96 PC, medium confidence
; Counts the controller slots of each team and notes the first slot of each
;-----------------------------------------------------------------------------
CountTeamSlots:
        push ebx
        push ecx
        push edx
        mov ecx, 0FFFFFFFFh
        xor edx, edx
        xor eax, eax
        mov word [HomeGoalieOff], dx
        mov word [AwayGoalieOff], dx
        mov word [AwayControlSlot], cx
        mov word [HomeControlSlot], cx
        mov word [AwayEbenPlayer], cx
        mov word [HomeEbenPlayer], cx
        xor edx, edx
.1:
        mov bx, word [dword edx+slotteam]
        cmp bx, byte 1
        jne short .3
        cmp word [HomeControlSlot], byte 0
        jge short .2
        mov word [HomeControlSlot], ax
.2:
        inc word [HomeGoalieOff]
        jmp short .5
.3:
        cmp bx, byte 2
        jne short .5
        cmp word [AwayControlSlot], byte 0
        jge short .4
        mov word [AwayControlSlot], ax
.4:
        inc word [AwayGoalieOff]
.5:
        inc eax
        add edx, byte 2
        cmp eax, byte 8
        jl short .1
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; DebugRestoreEnergy                              36370  97 PC, low confidence
; From DebugKeys: every player back to full energy (100), counter PassPlayer
; 3E8h
;-----------------------------------------------------------------------------
DebugRestoreEnergy:
        push edx
        mov edx, 3E8h
        xor eax, eax
        mov word [PassPlayer], dx
        mov dl, 64h
.1:
        inc eax
        mov byte [dword eax+HmPlayerEnergy], dl
        mov byte [dword eax+AwPlayerEnergy], dl
        cmp eax, byte 1Ch
        jl short .1
        pop edx
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        push edx
        mov ebx, dword [dword eax+0A3h]
        mov edx, dword [dword eax+0FEh]
        sar ebx, 18h
        inc byte [dword edx+ebx+0D0h]
        mov bx, word [PassPlayer]
        inc ebx
        mov dx, word [PassPlayer]
        mov word [PassPlayer], bx
        mov cx, word [dword eax+0A9h]
        add edx, byte 2
        test cx, cx
        je short .2
        cmp byte [dword eax+0CEh], 0
        jne short .3
.2:
        mov word [PassPlayer], dx
.3:
        pop edx
        pop ecx
        pop ebx
        ret
