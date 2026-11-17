; Faceoff puck, penalty calls and chances, net crashes and body contact.
bits 32
%include "hockey.inc"
section s_2EEE8 progbits alloc exec nowrite align=1
extern AddPenalty, AddPenalty2, AssignControlSlots, AwayGoalieOff, AwFaceoffCenter, AwFaceoffWinger, AwPlayerFlags, awtmstruct
extern BenchRequest, BreakawayFlag, CarrierInShotArea, changeplayer, ChkTwoInBox, clockcont_0, CommentaryEvent, CompLine
extern DelayedPen, F64_480_PenaltyChance, FaceoffAwayPlayer, FaceoffCameraScene, FaceoffCameraScene2, FaceoffDropX, FaceoffDropY, FaceoffHomePlayer
extern FaceoffRequest, FaceoffSlots, FaceoffTakerAway, FaceoffTakers, FaceoffX, FaceoffY, ForcePenaltyCall, forcepldata
extern gameclock, GameOptionFlags, gmode, Goal, gsp, HmFaceoffCenter, HmFaceoffWinger, HmPlayerFlags
extern hmtmstruct, HomeControlSlot, HomeGoalieOff, HomeTeamRecord, LastTouchPlayer, OneTimerTarget, PassReceiver, PenaltyCallCameraScene
extern penshotmode, PtrAwayIce, PtrHomeIce, PtrPuckFlags, PtrPuckZone, PuckFlags, PuckZone, QueueOverlayPanel
extern randomd0, RefPlayer, RefState, RequestLineChange, RequestPauseMenu, ResetFaceoffAssigns, ReturnGoalies, SetCrowdMood
extern SetFaceBlink, SetFaceExpression, SetFaceMouth, setpersonel, ShotType, SlotAssign, SlotPlayers, slotteam
extern SortCords, StartFaceoffLineChange, StatsPanelOn, StatsPanelPlayer, Stop4Pen, StopObject, UpdateLinesForAbsent
global puckfaceoff, ChkPenaltyCall, PenaltyChance, ChkNetCrash, NetCollide, NetCollide2, ChkBodyContactJumpTable, ChkBodyContact
global ChkBodyContact_229, ChkBodyContact_2CE, ChkBodyContact_2EB, ChkBodyContact_30C, ChkBodyContact_32D, ChkBodyContact_370, checkint
;-----------------------------------------------------------------------------
; puckfaceoff                        2EEE8  94G logic94.asm, medium confidence
;
; (asstab 1Bh, puck assignment at a stoppage, 'this is where the action starts'): end of period
; (clockcont_0), penalties (Stop4Pen), computer line choice (CompLine, setpersonel), ReturnGoalies,
; restorepl, then the faceoff set-up. Then the penalty shot (PenShotStart) and ForceStartLineup.
;-----------------------------------------------------------------------------
puckfaceoff:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        test byte [dword eax+0BFh], 2
        je near .26
        mov edx, dword [PtrPuckZone]
        mov bl, byte [edx]
        cmp bl, 0Ch
        je short .3
        movsx ebx, bl
        mov eax, ebx
        shl eax, 5
        add eax, ebx
        shl eax, 3
        mov bh, byte [edx]
        add eax, SortCords
        test bh, bh
        jl short .1
        cmp word [BenchRequest], byte 0
        je short .1
        cmp word [dword eax+0A9h], byte 0
        jne short .1
        mov dword [byte eax+064h], 0
        mov dword [byte edi+038h], 0
.1:
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jl short .2
        mov eax, dword [PtrPuckFlags]
        call StopObject
.2:
        mov eax, dword [PtrPuckZone]
        mov byte [eax], 0FFh
.3:
        and byte [dword edi+0BFh], 0FDh
        mov eax, dword [PtrPuckFlags]
        mov word [byte eax+06Dh], 0FFFFh
        cmp word [gameclock], byte 0
        jne short .4
        cmp word [StatsPanelOn], byte 0
        je short .5
.4:
        test byte [gmode], 40h
        je short .6
.5:
        call RequestPauseMenu
        jmp near .33
.6:
        cmp word [gsp], byte 3
        jne short .7
        mov dx, word [awtmstruct]
        cmp dx, word [hmtmstruct]
        je short .7
        call clockcont_0
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        test byte [gmode], 8
        je short .8
        xor eax, eax
        call Stop4Pen
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        xor ebx, ebx
.9:
        movsx edx, bx
        lea eax, [nosplit edx*2+00h]
        mov cx, word [dword eax+slotteam]
        test cx, cx
        je short .12
        cmp cx, byte 2
        jne short .10
        mov eax, HomeTeamRecord+420h
        jmp short .11
.10:
        mov eax, SortCords
.11:
        call changeplayer
.12:
        inc ebx
        cmp bx, byte 8
        jl short .9
        cmp word [penshotmode], byte 0
        je short .13
        xor edx, edx
        mov word [FaceoffTakerAway], dx
        mov word [FaceoffHomePlayer], dx
        mov word [FaceoffTakers], dx
        mov word [FaceoffAwayPlayer], dx
        mov eax, dword [dword edi+0AEh]
        sar eax, 18h
        mov edx, 43h
        mov byte [dword edi+eax+0B2h], dl
        mov cl, byte [dword edi+0BFh]
        mov dword [byte edi+060h], 190h
        or cl, 2
        mov byte [dword edi+0BFh], cl
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.13:
        cmp word [BenchRequest], byte 0
        je short .14
        call AssignControlSlots
.14:
        call ReturnGoalies
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 0C0h
        jne short .15
        mov eax, hmtmstruct
        call setpersonel
        mov eax, awtmstruct
        call setpersonel
.15:
        mov esi, 0FFFFFFFFh
        mov eax, dword [GameOptionFlags]
        mov word [FaceoffY], si
        mov word [FaceoffX], si
        test byte [byte eax+01h], 0C0h
        je near .26
        and byte [HmPlayerFlags], 0FDh
        mov bh, byte [AwPlayerFlags]
        and bh, 0FDh
        mov edx, SortCords
        mov byte [AwPlayerFlags], bh
        call FaceoffCameraScene
        xor eax, eax
.16:
        mov ch, byte [dword edx+0C0h]
        add edx, 108h
        and ch, 0F7h
        inc eax
        mov byte [byte edx-048h], ch
        cmp eax, byte 0Ch
        jl short .16
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        and eax, 0C0h
        cmp eax, byte 40h
        jne near .24
        cmp word [HomeGoalieOff], byte 0
        je near .20
        mov edx, dword [AwayGoalieOff]
        sar edx, 10h
        cmp edx, byte 8
        jge near .20
        lea eax, [nosplit edx*2+00h]
.17:
        cmp word [dword eax+slotteam], byte 1
        jne near .19
        cmp word [dword eax+SlotAssign], byte 0
        jl short .19
        mov edx, dword [dword eax+SlotPlayers]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edx, SortCords
        shl eax, 3
        add edx, eax
        and byte [dword edx+0C0h], 0F7h
        mov eax, edx
        call StartFaceoffLineChange
        test byte [dword edx+0C0h], 8
        je short .20
        test byte [dword edx+0BFh], 40h
        je short .18
        mov word [FaceoffY], 168h
        xor eax, eax
        mov al, byte [dword edx+0A4h]
        mov word [FaceoffDropY], ax
        jmp short .20
.18:
        mov esi, 258h
        xor eax, eax
        mov word [FaceoffX], si
        mov al, byte [dword edx+0A4h]
        mov word [FaceoffDropX], ax
        jmp short .20
.19:
        add eax, byte 2
        inc edx
        cmp eax, byte 10h
        jl near .17
.20:
        cmp word [AwayGoalieOff], byte 0
        je near .24
        mov edx, dword [HomeControlSlot]
        sar edx, 10h
        cmp edx, byte 8
        jge near .24
        lea eax, [nosplit edx*2+00h]
.21:
        cmp word [dword eax+slotteam], byte 2
        jne near .23
        cmp word [dword eax+SlotAssign], byte 0
        jl near .23
        mov edx, dword [dword eax+SlotPlayers]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edx, SortCords
        shl eax, 3
        add edx, eax
        mov bh, byte [dword edx+0C0h]
        and bh, 0F7h
        mov eax, edx
        mov byte [dword edx+0C0h], bh
        call StartFaceoffLineChange
        test byte [dword edx+0C0h], 8
        je short .24
        test byte [dword edx+0BFh], 40h
        je short .22
        mov word [FaceoffY], 168h
        xor eax, eax
        mov al, byte [dword edx+0A4h]
        mov word [FaceoffDropY], ax
        jmp short .24
.22:
        mov esi, 258h
        xor eax, eax
        mov word [FaceoffX], si
        mov al, byte [dword edx+0A4h]
        mov word [FaceoffDropX], ax
        jmp short .24
.23:
        add eax, byte 2
        inc edx
        cmp eax, byte 10h
        jl near .21
.24:
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        and eax, 0C0h
        cmp eax, 80h
        je short .25
        cmp word [AwayGoalieOff], byte 0
        jne short .26
.25:
        mov edx, awtmstruct
        mov eax, hmtmstruct
        call CompLine
        mov eax, awtmstruct
        call setpersonel
        mov eax, 1
        call ResetFaceoffAssigns
        mov eax, dword [awtmstruct]
        sar eax, 10h
        push eax
        push dword 12Ch
        push byte 8
        call QueueOverlayPanel
        add esp, byte 0Ch
.26:
        xor esi, esi
.27:
        movsx edx, si
        lea eax, [nosplit edx*4+00h]
        cmp word [dword eax+FaceoffX], byte 0
        jl near .29
        mov ebx, dword [dword eax+FaceoffX]
        sar ebx, 10h
        imul ebx, dword 108h
        add ebx, SortCords
        test byte [dword ebx+0C0h], 8
        jne short .28
        mov word [dword eax+FaceoffX], 0FFFFh
        imul ebx, edx, dword 10Ch
        add ebx, hmtmstruct
        mov eax, ebx
        call setpersonel
        mov eax, edx
        call ResetFaceoffAssigns
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+02h], 20h
        jne short .29
        cmp word [gsp], byte 0
        jne short .29
        mov dx, word [StatsPanelPlayer]
        cmp dx, word [gameclock]
        jne short .29
        cmp word [StatsPanelOn], byte 0
        jne short .29
        mov eax, ebx
        call forcepldata
        jmp short .29
.28:
        mov cx, word [dword eax+FaceoffX]
        sub ecx, byte 2
        mov word [dword eax+FaceoffX], cx
        test cx, cx
        jge short .29
        test byte [dword ebx+0C0h], 8
        je short .29
        mov edx, dword [nosplit edx*2+FaceoffSlots]
        mov eax, ebx
        sar edx, 10h
        call RequestLineChange
.29:
        inc esi
        cmp si, byte 2
        jl near .27
        cmp word [FaceoffX], byte 0
        jge near .33
        cmp word [FaceoffY], byte 0
        jge near .33
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        and eax, 0C0h
        cmp eax, 80h
        je short .30
        cmp eax, byte 40h
        jne short .31
        cmp word [HomeGoalieOff], byte 0
        jne short .31
.30:
        mov edx, hmtmstruct
        mov eax, awtmstruct
        call CompLine
        mov eax, hmtmstruct
        call setpersonel
        xor eax, eax
        call ResetFaceoffAssigns
        mov eax, dword [hmtmstruct]
        sar eax, 10h
        push eax
        push dword 12Ch
        push byte 7
        call QueueOverlayPanel
        add esp, byte 0Ch
.31:
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 0C0h
        jne short .32
        xor eax, eax
        mov word [AwFaceoffCenter], ax
        mov word [HmFaceoffWinger], ax
        mov word [HmFaceoffCenter], ax
        mov word [AwFaceoffWinger], ax
.32:
        call FaceoffCameraScene2
        mov eax, dword [dword edi+0AEh]
        sar eax, 18h
        mov edx, 43h
        mov byte [dword edi+eax+0B2h], dl
        mov dh, byte [dword edi+0BFh]
        mov dword [byte edi+060h], 190h
        or dh, 2
        mov byte [dword edi+0BFh], dh
.33:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push edx
        mov edx, dword [dword eax+0A3h]
        sar edx, 18h
        mov eax, dword [dword eax+0FEh]
        mov ax, word [byte eax+edx*2+050h]
        cmp ax, 8004h
        jne short .34
        mov eax, 2
        pop edx
        ret
.34:
        cmp ax, 8003h
        jne short .35
        mov eax, 1
        pop edx
        ret
.35:
        xor eax, eax
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ChkPenaltyCall                                  2F4B8  97 PC, low confidence
; From a body check (ResolveBodyCheck): whether the referee calls a penalty on the hit (skill and energy
; chance), AddPenalty2, penalty camera (priority 4), overlay, line update
;-----------------------------------------------------------------------------
ChkPenaltyCall:
        push ebx
        push ecx
        mov ecx, eax
        cmp byte [dword eax+0A4h], 0Ch
        je near .7
        test byte [gmode], 1
        jne near .7
        cmp word [BreakawayFlag], byte 0
        jne near .7
        cmp word [ForcePenaltyCall], byte 0
        jne near .2
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+02h], 1
        je near .7
        call CarrierInShotArea
        mov ax, word [PuckZone]
        mov word [OneTimerTarget], ax
        test ax, ax
        je near .7
        cmp edx, byte 0Fh
        jle near .7
        mov al, byte [dword ecx+0BEh]
        test al, al
        je near .7
        cmp al, 64h
        je short .2
        mov eax, dword [dword ecx+0A3h]
        mov edx, dword [dword ecx+0FEh]
        sar eax, 18h
        mov eax, dword [byte edx+eax*2+016h]
        mov edx, 1000h
        sar eax, 10h
        sub edx, eax
        mov eax, edx
        xor edx, edx
        mov ebx, 42h
        mov dl, byte [dword ecx+0BEh]
        sub ebx, edx
        sar eax, 8
        mov edx, ebx
        sub edx, eax
        mov eax, edx
        test edx, edx
        jg short .1
        mov eax, 1
.1:
        cwde
        call randomd0
        test ax, ax
        jne near .7
.2:
        xor eax, eax
        mov word [ForcePenaltyCall], ax
        test byte [dword ecx+0C0h], 10h
        jne near .7
        mov eax, ecx
        call ChkTwoInBox
        test eax, eax
        je near .7
        mov eax, 2
        call randomd0
        test ax, ax
        sete al
        and eax, 0FFh
        add eax, byte 3
        call SetCrowdMood
        mov dh, byte [dword ecx+0C0h]
        or dh, 4
        mov bl, byte [dword ecx+0BEh]
        mov byte [dword ecx+0C0h], dh
        cmp bl, 4Bh
        jb short .3
        mov eax, dword [dword ecx+0A3h]
        mov edx, dword [dword ecx+0FEh]
        sar eax, 18h
        mov word [byte edx+eax*2+050h], 8004h
        jmp short .4
.3:
        mov eax, dword [dword ecx+0A3h]
        mov edx, dword [dword ecx+0FEh]
        sar eax, 18h
        mov word [byte edx+eax*2+050h], 8003h
.4:
        mov eax, dword [dword ecx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        or byte [dword edx+eax+0161h], 4
        cmp word [dword ecx+0A9h], byte 0
        jne short .5
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        mov edx, dword [dword ecx+0FEh]
        mov edx, dword [dword edx+0108h]
        add edx, 1D42h
        jmp short .6
.5:
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        mov edx, dword [dword ecx+0FEh]
        mov edx, dword [dword edx+0108h]
        add edx, 0A3h
.6:
        add eax, edx
        mov edx, dword [LastTouchPlayer]
        mov bh, byte [dword ecx+0BFh]
        push edx
        test bh, 40h
        setne dl
        and edx, 0FFh
        push edx
        push eax
        push dword 0A0000009h
        call CommentaryEvent
        add esp, byte 10h
        mov edx, 2
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceBlink
        xor eax, eax
        mov al, byte [dword ecx+0A4h]
        xor ebx, ebx
        add eax, byte 10h
        mov edx, 0Dh
        mov dword [RefState], eax
        mov eax, ecx
        call AddPenalty2
        xor eax, eax
        mov al, byte [dword ecx+0A4h]
        call PenaltyCallCameraScene
        xor eax, eax
        mov al, byte [dword ecx+0A4h]
        push eax
        mov ebx, 1F4h
        push ebx
        push byte 0Dh
        mov dword [RefPlayer], ebx
        call QueueOverlayPanel
        add esp, byte 0Ch
        mov edx, dword [dword ecx+0A3h]
        mov ah, byte [dword ecx+0BFh]
        sar edx, 18h
        test ah, 40h
        setne al
        xor ah, ah
        cwde
        call UpdateLinesForAbsent
.7:
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PenaltyChance                                   2F744  97 PC, low confidence
; Chance a referee sees an infraction: by the player's discipline (+0CDh),
; distance to the puck, period, score difference and play state
;-----------------------------------------------------------------------------
PenaltyChance:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        xor eax, eax
        mov edx, 14h
        mov al, byte [dword ebx+0CDh]
        sub edx, eax
        mov ah, byte [dword ebx+0BFh]
        shl edx, 4
        test ah, 8
        je short .1
        add edx, edx
.1:
        mov ecx, dword [PtrPuckFlags]
        fld dword [byte ebx+020h]
        fsub dword [byte ecx+020h]
        fabs
        fcomp qword [F64_480_PenaltyChance]
        fnstsw ax
        sahf
        ja short .2
        fld dword [byte ebx+028h]
        fsub dword [byte ecx+028h]
        fabs
        fcomp qword [F64_480_PenaltyChance]
        fnstsw ax
        sahf
        ja short .2
        sar edx, 2
.2:
        cmp word [gsp], byte 2
        jle short .3
        shl edx, 2
.3:
        mov ecx, dword [dword ebx+0102h]
        mov eax, dword [dword ebx+0FEh]
        mov ecx, dword [byte ecx+0Ch]
        mov eax, dword [byte eax+0Ch]
        sar ecx, 10h
        sar eax, 10h
        sub ecx, eax
        mov eax, ecx
        cmp ecx, byte 1
        jl short .4
        add edx, edx
.4:
        cmp eax, byte 2
        jl short .5
        add edx, edx
.5:
        test byte [gmode], 8
        je short .6
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jl short .6
        cmp byte [dword ebx+0A4h], 6
        setb al
        mov ebx, eax
        mov eax, dword [PtrPuckZone]
        mov cl, byte [eax]
        and ebx, 0FFh
        cmp cl, 6
        setl al
        and eax, 0FFh
        xor eax, ebx
        je short .6
        shl edx, 2
.6:
        movsx eax, dx
        call randomd0
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ChkNetCrash                                     2F818  97 PC, low confidence
; Puck carrier driving into the net: 63h when the net is empty (goal
; awarded), 1 when the goalie is hit
;-----------------------------------------------------------------------------
ChkNetCrash:
        push ebx
        push edx
        mov edx, eax
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 7
        je near .6
        mov ebx, dword [PtrPuckZone]
        xor eax, eax
        movsx ebx, byte [ebx]
        mov al, byte [dword edx+0A4h]
        cmp eax, ebx
        jne near .6
        cmp word [OneTimerTarget], byte 0
        je near .6
        test byte [dword edx+0BFh], 80h
        je short .1
        fldz
        fcomp dword [byte edx+034h]
        fnstsw ax
        sahf
        jb short .2
        xor eax, eax
        pop edx
        pop ebx
        ret
.1:
        fldz
        fcomp dword [byte edx+034h]
        fnstsw ax
        sahf
        jbe short .6
.2:
        call CarrierInShotArea
        mov ax, word [PuckZone]
        mov word [OneTimerTarget], ax
        test ax, ax
        je short .6
        cmp word [byte edx+0Eh], byte 0
        jge short .3
        mov eax, dword [byte edx+0Ch]
        sar eax, 10h
        neg eax
        jmp short .4
.3:
        mov eax, dword [byte edx+0Ch]
        sar eax, 10h
.4:
        cmp eax, 1080h
        jg short .6
        mov eax, dword [dword edx+0102h]
        cmp word [byte eax+010h], byte 0
        jge short .5
        mov eax, 63h
        pop edx
        pop ebx
        ret
.5:
        mov eax, dword [dword edx+0EEh]
        test byte [byte eax+031h], 1
        je short .6
        mov eax, 1
        pop edx
        pop ebx
        ret
.6:
        xor eax, eax
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; NetCollide                                      2F8D8  95 PC, low confidence
; From checkgoal: an object hits a net: goal awarded on an empty net (Goal)
; or goalie interference (AddPenalty 22h)
;-----------------------------------------------------------------------------
NetCollide:
        push ebx
        push ecx
        push edx
        push esi
        test byte [gmode], 1
        jne near .8
        cmp word [BreakawayFlag], byte 0
        jne near .8
        mov esi, dword [byte eax+02Ch]
        xor eax, eax
        mov al, byte [byte esi+06Ch]
        mov ecx, eax
        shl ecx, 5
        add ecx, eax
        shl ecx, 3
        add ecx, SortCords
        cmp byte [dword ecx+0A4h], 0Ch
        je near .8
        cmp word [dword ecx+0A9h], byte 0
        je near .8
        test byte [dword esi+0C0h], 10h
        jne near .8
        mov eax, dword [PtrPuckZone]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        jne short .1
        and byte [PuckFlags], 0F7h
.1:
        mov eax, ecx
        call ChkNetCrash
        test eax, eax
        je short .5
        cmp eax, byte 63h
        jne short .4
        test byte [dword ecx+0BFh], 80h
        je short .2
        mov eax, dword [PtrAwayIce]
        jmp short .3
.2:
        mov eax, dword [PtrHomeIce]
.3:
        call Goal
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        xor eax, eax
        mov al, byte [dword ecx+0A4h]
        mov word [FaceoffRequest], ax
        mov edx, 22h
        mov ax, word [dword ecx+0BAh]
        xor ebx, ebx
        mov word [DelayedPen], ax
        mov eax, esi
        call AddPenalty
        mov eax, dword [PtrPuckZone]
        mov byte [eax], 0FFh
        mov dword [byte ecx+064h], 20h
        mov eax, dword [byte ecx+064h]
        mov dword [byte esi+064h], eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov eax, esi
        call PenaltyChance
        test ax, ax
        jg short .8
        mov eax, 2
        mov ebx, 1
        call randomd0
        test ax, ax
        je short .6
        mov eax, 15h
        jmp short .7
.6:
        mov eax, 20h
.7:
        movsx edx, ax
        mov eax, esi
        call AddPenalty
.8:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; NetCollide2                                     2FA00  97 PC, low confidence
; From checkgoal: the same check for the other net
;-----------------------------------------------------------------------------
NetCollide2:
        push ebx
        push ecx
        push edx
        push esi
        test byte [gmode], 1
        jne near .6
        cmp word [BreakawayFlag], byte 0
        jne near .6
        mov esi, dword [byte eax+02Ch]
        xor eax, eax
        mov al, byte [byte esi+06Ch]
        mov ecx, eax
        shl ecx, 5
        add ecx, eax
        shl ecx, 3
        add ecx, SortCords
        cmp byte [dword ecx+0A4h], 0Ch
        je near .6
        cmp word [dword ecx+0A9h], byte 0
        je near .6
        test byte [dword esi+0C0h], 10h
        jne near .6
        mov eax, dword [PtrPuckZone]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        jne short .1
        and byte [PuckFlags], 0F7h
.1:
        mov eax, ecx
        call ChkNetCrash
        test eax, eax
        je short .5
        cmp eax, byte 63h
        jne short .4
        test byte [dword ecx+0BFh], 80h
        je short .2
        mov eax, dword [PtrAwayIce]
        jmp short .3
.2:
        mov eax, dword [PtrHomeIce]
.3:
        call Goal
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        xor eax, eax
        mov al, byte [dword ecx+0A4h]
        mov word [FaceoffRequest], ax
        mov edx, 22h
        mov ax, word [dword ecx+0BAh]
        xor ebx, ebx
        mov word [DelayedPen], ax
        mov eax, esi
        call AddPenalty
        mov eax, dword [PtrPuckZone]
        mov byte [eax], 0FFh
        mov dword [byte ecx+064h], 20h
        mov eax, dword [byte ecx+064h]
        mov dword [byte esi+064h], eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov eax, esi
        call PenaltyChance
        test ax, ax
        jg short .6
        mov eax, 0Ah
        call randomd0
        cmp ax, 2
        jg short .6
        mov ebx, 1
        mov edx, 12h
        mov eax, esi
        call AddPenalty
.6:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
ChkBodyContactJumpTable:                        ; jump table for the switch cases of ChkBodyContact
        dd ChkBodyContact_229
        dd ChkBodyContact_229
        dd ChkBodyContact_229
        dd ChkBodyContact_2CE
        dd ChkBodyContact_2EB
        dd ChkBodyContact_30C
        dd ChkBodyContact_32D
        dd ChkBodyContact_370
;-----------------------------------------------------------------------------
; ChkBodyContact                                  2FB40  97 PC, low confidence
; From an animation event: body contact between two players: goalie contact
; by strength, checkint, Goal / AddPenalty outcomes
;-----------------------------------------------------------------------------
ChkBodyContact:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        cmp dword [byte eax+04h], byte 0Ah
        jne near ChkBodyContact_370.26
        test byte [gmode], 1
        jne near ChkBodyContact_370.26
        cmp word [BreakawayFlag], byte 0
        jne near ChkBodyContact_370.26
        mov ecx, dword [byte ebx+02Ch]
        xor edx, edx
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov esi, SortCords
        shl eax, 3
        add esi, eax
        cmp word [dword esi+0A9h], byte 0
        je near ChkBodyContact_370.26
        test byte [dword ecx+0C0h], 10h
        jne near ChkBodyContact_370.26
        cmp byte [dword esi+0A4h], 0Ch
        jne short .4
        mov dl, byte [dword esi+0BEh]
        cmp dl, 3
        jb near ChkBodyContact_370.26
        jne short .1
        mov ebx, 1
        mov edx, 18h
        jmp near ChkBodyContact_370.25
.1:
        cmp dl, 6
        jne short .2
        mov ebx, 4
        mov edx, 18h
        jmp near ChkBodyContact_370.25
.2:
        cmp dl, 9
        jne short .3
        mov ebx, 10h
        mov edx, 18h
        jmp near ChkBodyContact_370.25
.3:
        jbe near ChkBodyContact_370.26
        mov ebx, 14h
        mov edx, 18h
        jmp near ChkBodyContact_370.25
.4:
        mov eax, ebx
        call checkint
        test byte [dword ecx+0C0h], 10h
        jne near ChkBodyContact_370.26
        mov eax, esi
        call ChkNetCrash
        test eax, eax
        je short .8
        cmp eax, byte 63h
        jne short .7
        test byte [dword esi+0BFh], 80h
        je short .5
        mov eax, dword [PtrAwayIce]
        jmp short .6
.5:
        mov eax, dword [PtrHomeIce]
.6:
        call Goal
        jmp near ChkBodyContact_370.26
.7:
        xor eax, eax
        mov al, byte [dword esi+0A4h]
        mov word [FaceoffRequest], ax
        mov edx, 22h
        mov ax, word [dword esi+0BAh]
        xor ebx, ebx
        mov word [DelayedPen], ax
        mov eax, ecx
        call AddPenalty
        mov eax, dword [PtrPuckZone]
        mov byte [eax], 0FFh
        mov dword [byte esi+064h], 20h
        mov eax, dword [byte esi+064h]
        mov dword [byte ecx+064h], eax
        jmp near ChkBodyContact_370.26
.8:
        mov eax, dword [dword esi+0EEh]
        test byte [byte eax+031h], 1
        je near ChkBodyContact_370.26
        mov eax, dword [dword esi+0A3h]
        mov edx, dword [dword esi+0FEh]
        sar eax, 18h
        mov ax, word [byte edx+eax*2+050h]
        cmp ax, 8004h
        jne short .9
        mov edx, 2
        jmp short .11
.9:
        cmp ax, 8003h
        jne short .10
        mov edx, 1
        jmp short .11
.10:
        xor edx, edx
.11:
        mov eax, dword [PtrPuckZone]
        movzx edi, byte [dword esi+0A4h]
        movsx eax, byte [eax]
        cmp edi, eax
        jne short .12
        and byte [PuckFlags], 0F7h
.12:
        mov edi, dword [byte ebx+028h]
        xor eax, eax
        mov ebx, 0C8h
        mov al, byte [dword ecx+0C2h]
        sub ebx, eax
        mov eax, ebx
        xor ebx, ebx
        mov bl, byte [dword esi+0C2h]
        add eax, ebx
        mov ebx, dword [byte ecx+068h]
        sar eax, 1
        sar ebx, 10h
        sub eax, ebx
        and edi, 0FFFFh
        mov ebx, eax
        test edx, edx
        jne short .13
        test eax, eax
        jle near ChkBodyContact_370.26
        cwde
        call randomd0
        movsx ebx, ax
        xor eax, eax
        mov al, byte [dword ecx+0CFh]
        cmp ebx, eax
        jle near ChkBodyContact_370.26
.13:
        mov eax, ecx
        call PenaltyChance
        movsx ebx, ax
        cmp ebx, byte 6
        jle short .14
        test edx, edx
        je near ChkBodyContact_370.26
.14:
        lea eax, [dword edi-08Ch]
        cmp eax, byte 7
        ja near ChkBodyContact_370.26
        jmp dword [nosplit cs:eax*4+ChkBodyContactJumpTable]
ChkBodyContact_229:
        mov eax, dword [dword esi+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+028h]
        and eax, 0FFFFh
        cmp eax, byte 74h
        je short .15
        cmp eax, byte 73h
        jne short .16
.15:
        mov eax, 1Ah
        jmp short .19
.16:
        cmp eax, byte 67h
        je short .17
        cmp eax, byte 6Dh
        jne short .18
.17:
        mov eax, 19h
        test edx, edx
        je short .20
        mov esi, 14h
        jmp near ChkBodyContact_370.24
.18:
        mov eax, 11h
.19:
        test edx, edx
        je short .20
        mov esi, 14h
        jmp near ChkBodyContact_370.24
.20:
        cmp word [byte esi+06Ah], byte 28h
        jle short .22
        cmp eax, byte 11h
        jne short .21
        mov esi, 2
        movsx ebx, si
        movsx edx, ax
        mov eax, ecx
        call AddPenalty
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.21:
        mov esi, 4
        movsx ebx, si
        movsx edx, ax
        mov eax, ecx
        call AddPenalty
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.22:
        mov esi, 1
        movsx ebx, si
        movsx edx, ax
        mov eax, ecx
        call AddPenalty
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
ChkBodyContact_2CE:
        mov esi, 14h
        mov eax, 21h
        movsx ebx, si
        movsx edx, ax
        mov eax, ecx
        call AddPenalty
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
ChkBodyContact_2EB:
        mov eax, 0Fh
        test edx, edx
        je short ChkBodyContact_229.22
        mov esi, 14h
        movsx ebx, si
        movsx edx, ax
        mov eax, ecx
        call AddPenalty
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
ChkBodyContact_30C:
        mov eax, 10h
        test edx, edx
        je short ChkBodyContact_229.22
        mov esi, 2
        movsx ebx, si
        movsx edx, ax
        mov eax, ecx
        call AddPenalty
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
ChkBodyContact_32D:
        mov eax, 16h
        cmp edx, byte 1
        jne short .23
        mov esi, 2
        movsx ebx, si
        movsx edx, ax
        mov eax, ecx
        call AddPenalty
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.23:
        cmp edx, byte 2
        jne near ChkBodyContact_229.22
        mov esi, 14h
        movsx ebx, si
        movsx edx, ax
        mov eax, ecx
        call AddPenalty
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
ChkBodyContact_370:
        mov eax, 17h
        test edx, edx
        je near ChkBodyContact_229.22
        mov esi, 4
.24:
        movsx ebx, si
        movsx edx, ax
.25:
        mov eax, ecx
        call AddPenalty
.26:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; checkint                                          2FED8  94G, low confidence
; interference: the hit player has no puck and is not the
; goalie; AddPenalty 14h by chance
;-----------------------------------------------------------------------------
checkint:
        push ebx
        push ecx
        push edx
        test byte [gmode], 1
        jne near .1
        cmp word [BreakawayFlag], byte 0
        jne near .1
        mov ecx, dword [byte eax+02Ch]
        xor edx, edx
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        mov dh, byte [dword eax+0A4h]
        cmp dh, 0Ch
        je short .1
        xor ebx, ebx
        mov bl, dh
        mov edx, dword [PtrPuckZone]
        movsx edx, byte [edx]
        cmp ebx, edx
        je short .1
        mov edx, dword [dword ecx+0102h]
        movsx ax, byte [dword eax+0A6h]
        cmp ax, word [byte edx+08h]
        je short .1
        cmp ax, word [byte edx+0Ah]
        je short .1
        cmp ax, word [byte edx+0Ch]
        je short .1
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+05Ah], byte 0FFFFFFC0h
        jge short .1
        mov eax, ecx
        call PenaltyChance
        cmp ax, 5
        jg short .1
        mov ebx, 1
        mov edx, 14h
        mov eax, ecx
        call AddPenalty
.1:
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        cmp word [ShotType], byte 0
        jne short .2
        mov eax, dword [dword eax+0102h]
        mov eax, dword [dword eax+0FAh]
        sar eax, 10h
        test eax, eax
        jge short .3
.2:
        mov word [PassReceiver], 8
        ret
.3:
        mov eax, 9
        call randomd0
        mov word [PassReceiver], ax
        ret
