; Puck chasing: offside checks, onside skating, the puck carrier and nearest player assignments.
bits 32
%include "hockey.inc"
section s_25894 progbits alloc exec nowrite align=1
extern AimAtPuckTarget, AIPassDecision, assexit, assextra3, assextra4, assgoalie, assreplace, AvgLineEnergy
extern AwPlayersInBox, awtmstruct, BenchRequest, BuildPassTargets, CanReceivePass, ChangePlayer, check4bench, ChkAIShoot
extern ChkForwardSwap, ChkPokeOrCheck, ChkSwapWithPartner, CompLine, CreaseBounds, DefendPuck, doplayeracc, F64_1435
extern F64_neg12, FaceoffRequest, FindManToCover, ForceShoot, gameclock, GameOptionFlags, GameSettings, GetDefensePartner
extern gmode, GoalieTarget, GoalLineY, HmPlayersInBox, hmtmstruct, iflags, KeepInsideRink, LineChangeCommentary
extern MessagePanel, NearestPlayer, ObjectFramePos, OneTimerPasser, onetimerplayer, OneTimerReady, OneTimerTarget, OnsideOffsetX
extern OnsideOffsetY, PassState, penshotlive, PlayerAssignWords, PlayFlags, PtrAwayIce, PtrHomeIce, PtrPuckFlags
extern PtrPuckObject, PtrPuckOwner, PtrPuckTarget, PtrPuckZone, PuckChaseOffsetX, PuckChaseOffsetY, PuckChasers, PuckOwnerTeam
extern QueueOverlayPanel, randomd0, regd1, RemoveOverlayPanel, setpersonel, SetSkateSpeedFromRating, ShootSpotY, SortCords
extern StartPass, StartWhistleStop, vtoa, ZoneFlags, ZoneTargetX, ZoneTargetY
global PlayerPastLine, PlayerPastLine_D1, checkob, GetLowestPen, chk4lc, SkateOnside, SkateToEndBoards, asspuckc
global ChkDefenseSwitch, ChasePuck, assnearest
;-----------------------------------------------------------------------------
; PlayerPastLine                                  25894  97 PC, low confidence
; (player, line y 0 / +-56Bh): whether both of the player's tracked points are past the line in his
; attacking direction (red line +-18h, blue line +-30h)
;-----------------------------------------------------------------------------
PlayerPastLine:
        push ebx
        push ecx
        push esi
        push edi
        sub esp, byte 24h
        mov ecx, eax
        mov dword [byte esp+020h], edx
        test byte [dword eax+0BFh], 80h
        je short .2
        test edx, edx
        jne short .1
        lea ebx, [byte edx+018h]
        mov dword [byte esp+020h], ebx
        jmp short .4
.1:
        cmp edx, 56Bh
        jne short .4
        add edx, byte 30h
        mov dword [byte esp+020h], edx
        jmp short .4
.2:
        test edx, edx
        jne short .3
        lea edi, [byte edx-018h]
        mov dword [byte esp+020h], edi
        jmp short .4
.3:
        cmp edx, 0FFFFFA95h
        jne short .4
        lea esi, [byte edx-030h]
        mov dword [byte esp+020h], esi
.4:
        mov ebx, esp
        mov edx, dword [CreaseBounds]
        mov eax, ecx
        call ObjectFramePos
        lea ebx, [byte esp+0Ch]
        mov edx, dword [GoalLineY]
        mov eax, ecx
        call ObjectFramePos
        test byte [dword ecx+0BFh], 80h
        je short .5
        fld dword [byte esp+08h]
        fild dword [byte esp+020h]
        fstp dword [byte esp+018h]
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        jbe short .6
        fld dword [byte esp+014h]
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        jbe short .6
        mov eax, 1
        jmp short .7
.5:
        fld dword [byte esp+08h]
        fild dword [byte esp+020h]
        fstp dword [byte esp+01Ch]
        fcomp dword [byte esp+01Ch]
        fnstsw ax
        sahf
        jae short .6
        fld dword [byte esp+014h]
        fcomp dword [byte esp+01Ch]
        fnstsw ax
        sahf
        jae short .6
        mov eax, 1
        jmp short .7
.6:
        xor eax, eax
.7:
        add esp, byte 24h
        pop edi
PlayerPastLine_D1:
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; checkob                                        2596C  94G, medium confidence
; (warning ref when a player on your team is over the blue line): offsides option, a teammate
; past the blue line as the carrier comes up sets PlayFlags 80h and shows overlay 5
;-----------------------------------------------------------------------------
checkob:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 4
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov eax, dword [GameOptionFlags]
        mov dl, byte [byte eax+01h]
        xor edi, edi
        test dl, 8
        je near .12
        cmp word [penshotlive], byte 0
        jne near .12
        cmp word [BenchRequest], byte 0
        jne near .12
        cmp byte [dword esi+0A4h], 6
        jae short .1
        xor edx, edx
        jmp short .2
.1:
        mov edx, 6
.2:
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov ebx, SortCords
        shl eax, 3
        add ebx, eax
        mov eax, dword [PtrPuckOwner]
        movsx eax, word [eax]
        mov cl, byte [dword esi+0BFh]
        mov dword [esp], eax
        test cl, 80h
        jne short .3
        mov edx, eax
        neg edx
        mov dword [esp], edx
.3:
        fild dword [esp]
        fadd qword [F64_neg12]
        fcomp qword [F64_1435]
        fnstsw ax
        sahf
        jae short .8
        xor ecx, ecx
.4:
        test byte [dword esi+0BFh], 80h
        je short .5
        mov edx, 56Bh
        jmp short .6
.5:
        mov edx, 0FFFFFA95h
.6:
        mov eax, ebx
        call PlayerPastLine
        test eax, eax
        je short .7
        mov edi, 1
        jmp short .8
.7:
        inc ecx
        add ebx, 108h
        cmp ecx, byte 6
        jl short .4
.8:
        test di, di
        je short .10
        mov bh, byte [PlayFlags]
        test bh, 80h
        jne near .12
        mov cl, bh
        or cl, 80h
        mov byte [PlayFlags], cl
        test byte [dword esi+0BFh], 80h
        setne al
        mov edx, eax
        mov eax, dword [PtrPuckOwner]
        mov cx, word [eax]
        and edx, 0FFh
        test cx, cx
        setl al
        and eax, 0FFh
        xor eax, edx
        je short .9
        cmp word [MessagePanel], byte 5
        jge short .9
        push byte 5
        push byte 0
        push byte 0
        call QueueOverlayPanel
        add esp, byte 0Ch
.9:
        mov eax, dword [PtrPuckObject]
        or byte [dword eax+0C1h], 2
        jmp short .11
.10:
        mov ah, byte [PlayFlags]
        test ah, 80h
        je short .12
        mov dl, ah
        and dl, 7Fh
        mov eax, 5
        mov byte [PlayFlags], dl
        call RemoveOverlayPanel
        test byte [gmode], 8
        jne short .12
        mov eax, dword [PtrPuckObject]
        and byte [dword eax+0C1h], 0FDh
.11:
        mov eax, dword [PtrPuckObject]
        call StartWhistleStop
.12:
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
; GetLowestPen                                                      25AEC  94G
; power play time left from the two teams' penalty box
; lists (coincidental entries skipped); 0 when the teams are even
;-----------------------------------------------------------------------------
GetLowestPen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 4
        mov dx, word [AwPlayersInBox]
        mov ax, word [HmPlayersInBox]
        sub eax, edx
        test ax, ax
        jle short .1
        mov ebx, awtmstruct
        mov edi, hmtmstruct
        mov dword [esp], ebx
        jmp short .3
.1:
        jl short .2
        xor eax, eax
        jmp near .10
.2:
        mov edx, hmtmstruct
        mov edi, awtmstruct
        mov dword [esp], edx
.3:
        mov edx, dword [esp]
        xor ebx, ebx
        xor ecx, ecx
        add edx, 88h
.4:
        movsx ax, byte [edx]
        inc edx
        test ax, ax
        jl short .5
        cwde
        mov esi, dword [esp]
        add eax, eax
        add eax, esi
        mov ax, word [byte eax+050h]
        movsx esi, ax
        test si, 8000h
        jne short .4
        test ah, 10h
        jne short .4
        and ah, 1
        sub eax, ecx
        mov ecx, eax
        add ebx, eax
        jmp short .4
.5:
        cmp word [byte edi+0Eh], byte 6
        jne short .6
        mov eax, ebx
        add esp, byte 4
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        lea edx, [dword edi+088h]
        sub ebx, ecx
.7:
        movsx ax, byte [edx]
        inc edx
        test ax, ax
        jge short .8
        mov eax, ebx
        add esp, byte 4
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        cwde
        mov ax, word [byte edi+eax*2+050h]
        movsx esi, ax
        test si, 8000h
        jne short .7
        test ah, 10h
        jne short .7
        and ah, 1
        cmp bx, ax
        jge short .9
        mov eax, ebx
        add esp, byte 4
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov eax, ebx
        add eax, ecx
.10:
        add esp, byte 4
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; chk4lc                                            25BD0  94G, low confidence
; (see if the computer should call a line change): line option 40h, puck in its own half, 1 in 4,
; enough clock and power play time, tired line (AvgLineEnergy > 800h) -> CompLine, setpersonel
;-----------------------------------------------------------------------------
chk4lc:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        and eax, 0C0h
        cmp eax, byte 40h
        jne short .1
        cmp word [penshotlive], byte 0
        je short .2
.1:
        xor eax, eax
        jmp near .13
.2:
        mov eax, dword [PtrPuckOwner]
        mov ax, word [eax]
        mov word [ZoneTargetY], ax
        test byte [dword ebx+0BFh], 80h
        jne short .3
        neg word [ZoneTargetY]
.3:
        mov si, word [ZoneTargetY]
        test si, si
        jl short .4
        cmp si, 570h
        jg short .4
        test byte [dword ebx+0C0h], 8
        jne short .4
        mov eax, 4
        call randomd0
        test ax, ax
        je short .5
.4:
        xor eax, eax
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov ecx, dword [dword ebx+0FEh]
        mov esi, dword [dword ebx+0102h]
        mov ax, word [byte ecx+0Eh]
        sub ax, word [byte esi+0Eh]
        mov di, word [gameclock]
        mov edx, eax
        cmp di, byte 0Fh
        jl short .6
        test ax, ax
        je short .7
        call GetLowestPen
        cmp ax, 0Fh
        jge short .7
.6:
        xor eax, eax
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        test byte [dword ecx+0A6h], 40h
        jne short .12
        mov eax, ecx
        call AvgLineEnergy
        mov edi, eax
        cmp ax, 800h
        jle short .8
        cmp word [gameclock], byte 1Eh
        jl short .11
.8:
        test dx, dx
        je short .9
        mov eax, 0F33h
        jmp short .10
.9:
        mov eax, dword [dword ecx+0A8h]
.10:
        movsx edx, di
        cmp edx, eax
        jbe short .12
.11:
        xor eax, eax
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.12:
        mov ah, byte [dword ebx+0C0h]
        or ah, 8
        mov edx, ecx
        mov byte [dword ebx+0C0h], ah
        mov eax, esi
        call CompLine
        mov eax, ecx
        call setpersonel
        mov eax, ebx
        call ForceShoot
        mov eax, dword [ecx]
        sar eax, 10h
        push eax
        push dword 12Ch
        cmp ecx, hmtmstruct
        setne al
        and eax, 0FFh
        add eax, byte 7
        push eax
        call QueueOverlayPanel
        add esp, byte 0Ch
        mov eax, 2
        xor edx, edx
        call randomd0
        test ax, ax
        sete al
        mov dl, al
        add edx, 0A005h
        mov eax, ebx
        call LineChangeCommentary
        mov eax, 1
.13:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SkateOnside                                     25D40  97 PC, low confidence
; Offside warning on (PlayFlags 80h): send the player to his onside spot
; (OnsideOffsetX table by formation, mirrored by team), speed 25
;-----------------------------------------------------------------------------
SkateOnside:
        push ebx
        push ecx
        push edx
        mov edx, eax
        test byte [PlayFlags], 80h
        je near .2
        mov ax, word [dword edx+0ABh]
        add eax, eax
        mov word [ZoneTargetY], ax
        mov eax, dword [ZoneTargetX]
        sar eax, 10h
        mov bx, word [nosplit eax*2+OnsideOffsetY]
        mov ax, word [nosplit eax*2+OnsideOffsetX]
        mov word [regd1], bx
        mov word [ZoneTargetY], ax
        test byte [dword edx+0BFh], 80h
        jne short .1
        mov cx, word [regd1]
        mov ebx, eax
        neg ecx
        neg ebx
        mov word [regd1], cx
        mov word [ZoneTargetY], bx
.1:
        mov eax, dword [dword edx+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword edx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword edx+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [dword edx+0EEh]
        mov ebx, dword [byte edx+038h]
        mov dword [byte eax+08h], ebx
        mov eax, dword [dword edx+0EEh]
        mov ebx, dword [byte edx+040h]
        mov dword [byte eax+0Ch], ebx
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+018h], 41C80000h
        mov eax, edx
        call SetSkateSpeedFromRating
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+024h], 42C80000h
        mov eax, edx
        call AimAtPuckTarget
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
        xor eax, eax
        ret
        db 090h
;-----------------------------------------------------------------------------
; SkateToEndBoards                                25E24  97 PC, low confidence
; Sends the player toward the end boards (y +-0F30h) when his slot neighbour
; is free, random approach angle
;-----------------------------------------------------------------------------
SkateToEndBoards:
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
        test byte [dword eax+0BFh], 80h
        je short .1
        mov eax, dword [PtrAwayIce]
        jmp short .2
.1:
        mov eax, dword [PtrHomeIce]
.2:
        mov dx, word [byte eax+0Eh]
        mov cx, word [byte ebx+0Eh]
        mov si, word [byte ebx+06h]
        mov ax, word [byte eax+06h]
        sub edx, ecx
        sub eax, esi
        movsx edx, dx
        cwde
        call vtoa
        mov dl, byte [dword ebx+0BFh]
        cwde
        test dl, 80h
        jne short .3
        xor al, 4
.3:
        cmp word [dword ebx+eax*2+08Fh], byte 0
        jl short .4
        and byte [byte ebx+06Dh], 0FEh
        xor eax, eax
        jmp near .8
.4:
        mov edx, 0F30h
        xor eax, eax
        mov word [regd1], dx
        mov word [ZoneTargetY], ax
        test byte [dword ebx+0BFh], 80h
        jne short .5
        mov word [regd1], 0F0D0h
.5:
        mov eax, dword [dword ebx+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword ebx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword ebx+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [dword ebx+0EEh]
        mov edx, dword [byte ebx+038h]
        mov dword [byte eax+08h], edx
        mov eax, 2
        call randomd0
        test ax, ax
        jne short .6
        mov esi, 5A7ED197h
        mov edi, 3FE921FBh
        mov dword [esp], esi
        mov dword [byte esp+04h], edi
        jmp short .7
.6:
        mov edx, 0EF2EF764h
        mov ecx, 4015FDBBh
        mov dword [esp], edx
        mov dword [byte esp+04h], ecx
.7:
        mov eax, dword [dword ebx+0EEh]
        fld qword [esp]
        fstp dword [byte eax+0Ch]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 41200000h
        mov eax, ebx
        call SetSkateSpeedFromRating
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42DC0000h
        mov eax, ebx
        call AimAtPuckTarget
        mov ch, byte [byte ebx+06Dh]
        or ch, 1
        mov eax, 1
        mov byte [byte ebx+06Dh], ch
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
; asspuckc                                          25F64  94G, low confidence
; Assignment 9, the computer puck carrier: steps out when its team does not have the puck (PtrPuckZone),
; runs its checks on a reaction timer (+56h), and goes to 1Bh when skating in close on the goal
;-----------------------------------------------------------------------------
asspuckc:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebx, eax
        xor edx, edx
        mov dl, byte [dword eax+0A4h]
        mov eax, dword [PtrPuckZone]
        movsx eax, byte [eax]
        cmp edx, eax
        je short .1
        mov al, byte [dword ebx+0B1h]
        mov dl, byte [dword ebx+0BFh]
        inc al
        or dl, 2
        and al, 7
        mov byte [dword ebx+0BFh], dl
        mov byte [dword ebx+0B1h], al
        jmp near .15
.1:
        mov ah, byte [dword ebx+0BFh]
        test ah, 20h
        jne near .15
        test byte [gmode], 1
        je short .2
        test ah, 20h
        jne near .15
        test ah, 8
        jne near .15
        mov edx, 8
        mov eax, ebx
        call doplayeracc
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        test ah, 8
        je short .3
        mov al, byte [dword ebx+0B1h]
        mov ch, byte [dword ebx+0BFh]
        inc al
        or ch, 2
        and al, 7
        mov byte [dword ebx+0BFh], ch
        mov byte [dword ebx+0B1h], al
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        test ah, 2
        je short .4
        mov word [dword ebx+0BCh], 0
        mov ch, ah
        mov dword [byte ebx+056h], 0
        and ch, 0FDh
        mov byte [dword ebx+0BFh], ch
.4:
        test byte [dword ebx+0BFh], 40h
        setne al
        and eax, 0FFh
        mov edi, eax
        shl eax, 2
        mov edx, dword [dword eax+PuckChasers]
        test edx, edx
        jne near .8
        mov ecx, dword [byte ebx+056h]
        sub ecx, byte 2
        mov dword [byte ebx+056h], ecx
        test ecx, ecx
        jge near .13
        xor eax, eax
        mov al, byte [dword ebx+0C5h]
        mov dword [byte ebx+056h], eax
        mov eax, ebx
        call BuildPassTargets
        mov eax, ebx
        call checkob
        cmp word [OneTimerTarget], byte 0
        je short .7
        cmp word [byte ebx+0Eh], byte 0
        jge short .5
        mov eax, dword [byte ebx+0Ch]
        sar eax, 10h
        neg eax
        jmp short .6
.5:
        mov eax, dword [byte ebx+0Ch]
        sar eax, 10h
.6:
        cmp eax, 1020h
        jge short .7
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 1Bh
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword ebx+0BFh], 2
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        mov eax, ebx
        call chk4lc
        test ax, ax
        jne near .15
        mov eax, ebx
        call ChkAIShoot
        test ax, ax
        jne near .15
        mov eax, ebx
        call AIPassDecision
        test ax, ax
        jne near .15
        mov eax, ebx
        call ChkForwardSwap
        jmp near .13
.8:
        cmp edx, byte 2
        jne short .13
        mov esi, dword [dword eax+ChangePlayer]
        test esi, esi
        jl short .12
        mov eax, esi
        shl eax, 5
        add eax, esi
        mov edx, SortCords
        shl eax, 3
        mov ecx, ebx
        add edx, eax
        mov eax, ebx
        mov esi, edx
        call CanReceivePass
        test ax, ax
        je short .9
        mov word [PassState], 2
        jmp short .10
.9:
        mov word [PassState], ax
.10:
        mov edx, esi
        mov eax, ecx
        call StartPass
        cmp word [dword ecx+0A9h], byte 0
        jle short .11
        mov eax, ecx
        call assexit
.11:
        xor ebp, ebp
        mov dword [nosplit edi*4+PuckChasers], ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.12:
        xor edx, edx
        mov dword [dword eax+PuckChasers], edx
.13:
        mov eax, ebx
        call SkateOnside
        test ax, ax
        jne near .15
        mov eax, ebx
        call SkateToEndBoards
        test ax, ax
        jne near .15
        mov ax, word [dword ebx+0ABh]
        add eax, eax
        mov word [ZoneTargetY], ax
        mov eax, dword [ZoneTargetX]
        sar eax, 10h
        mov dx, word [nosplit eax*2+PuckChaseOffsetY]
        mov ax, word [nosplit eax*2+PuckChaseOffsetX]
        mov word [regd1], dx
        mov word [ZoneTargetY], ax
        test byte [dword ebx+0BFh], 80h
        jne short .14
        mov cx, word [regd1]
        mov edx, eax
        neg ecx
        neg edx
        mov word [regd1], cx
        mov word [ZoneTargetY], dx
.14:
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
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+018h], 41C80000h
        mov eax, ebx
        call SetSkateSpeedFromRating
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42C80000h
        mov eax, ebx
        call AimAtPuckTarget
.15:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ChkDefenseSwitch                                2625C  97 PC, low confidence
; From assnearest: decides when a defenceman switches sides with his partner (SwapPosition helpers
; ChkSwapWithPartner / GetDefensePartner) by puck carrier, zone (0B10h, 0FC0h) and side
;-----------------------------------------------------------------------------
ChkDefenseSwitch:
        push ecx
        push esi
        push edi
        mov ecx, eax
        mov eax, ebx
        mov bx, word [dword ecx+0ABh]
        cmp bx, byte 1
        je short .1
        cmp bx, byte 2
        je short .1
        test eax, eax
        je near .17
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jge near .17
        test byte [iflags], 4
        jmp near .17
.1:
        test eax, eax
        je short .2
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jge short .2
        test byte [iflags], 4
        je short .2
        test byte [dword ecx+0BFh], 80h
        setne al
        mov ebx, eax
        mov di, word [dword ecx+0ABh]
        and ebx, 0FFh
        cmp di, byte 1
        sete al
        and eax, 0FFh
        xor ebx, eax
        test edx, edx
        setg al
        and eax, 0FFh
        xor eax, ebx
        je near .17
        mov eax, ecx
        call ChkSwapWithPartner
        mov eax, 1
        pop edi
        pop esi
        pop ecx
        ret
.2:
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jl near .9
        cmp word [byte ecx+06h], byte 0
        jge short .3
        mov eax, dword [byte ecx+04h]
        sar eax, 10h
        neg eax
        jmp short .4
.3:
        mov eax, dword [byte ecx+04h]
        sar eax, 10h
.4:
        cmp eax, 3C0h
        jge near .9
        cmp word [byte ecx+0Eh], byte 0
        jge short .5
        mov eax, dword [byte ecx+0Ch]
        sar eax, 10h
        neg eax
        jmp short .6
.5:
        mov eax, dword [byte ecx+0Ch]
        sar eax, 10h
.6:
        cmp eax, 0B10h
        jle near .9
        test byte [dword ecx+0BFh], 80h
        setne al
        mov ebx, eax
        mov si, word [byte ecx+0Eh]
        and ebx, 0FFh
        test si, si
        setg al
        and eax, 0FFh
        xor eax, ebx
        je short .9
        mov eax, dword [PtrPuckOwner]
        mov di, word [eax]
        test di, di
        jge short .7
        movsx eax, di
        neg eax
        jmp short .8
.7:
        movsx eax, di
.8:
        cmp eax, 0FC0h
        jle short .9
        test byte [dword ecx+0BFh], 80h
        setne al
        mov ebx, dword [PtrPuckOwner]
        mov si, word [ebx]
        and eax, 0FFh
        test si, si
        setg bl
        and ebx, 0FFh
        xor eax, ebx
        je short .9
        xor eax, eax
        pop edi
        pop esi
        pop ecx
        ret
.9:
        test byte [dword ecx+0BFh], 80h
        setne al
        mov di, word [dword ecx+0ABh]
        and eax, 0FFh
        cmp di, byte 1
        sete bl
        and ebx, 0FFh
        xor ebx, eax
        test edx, edx
        setg al
        and eax, 0FFh
        xor eax, ebx
        je near .17
        mov eax, ecx
        call GetDefensePartner
        mov edx, eax
        test eax, eax
        je short .12
        mov eax, dword [PtrPuckOwner]
        mov bx, word [eax]
        test bx, bx
        jge short .10
        movsx eax, bx
        neg eax
        jmp short .11
.10:
        movsx eax, bx
.11:
        cmp eax, 0FC0h
        jle short .13
        test byte [dword ecx+0BFh], 80h
        setne al
        mov ebx, eax
        mov eax, dword [PtrPuckOwner]
        mov si, word [eax]
        and ebx, 0FFh
        test si, si
        setg al
        and eax, 0FFh
        xor eax, ebx
        je short .13
.12:
        xor eax, eax
        pop edi
        pop esi
        pop ecx
        ret
.13:
        mov di, word [byte ecx+0Eh]
        mov ax, word [byte edx+0Eh]
        cmp ax, di
        setg al
        mov edx, eax
        mov ah, byte [dword ecx+0BFh]
        and edx, 0FFh
        test ah, 80h
        setne al
        and eax, 0FFh
        xor eax, edx
        je short .16
        test byte [dword ecx+0BFh], 80h
        setne al
        mov edx, eax
        and edx, 0FFh
        test di, di
        setg al
        and eax, 0FFh
        xor eax, edx
        je short .16
        test di, di
        jge short .14
        mov eax, dword [byte ecx+0Ch]
        sar eax, 10h
        neg eax
        jmp short .15
.14:
        mov eax, dword [byte ecx+0Ch]
        sar eax, 10h
.15:
        cmp eax, 570h
        jle short .16
        xor eax, eax
        pop edi
        pop esi
        pop ecx
        ret
.16:
        mov eax, ecx
        call ChkSwapWithPartner
.17:
        mov eax, 1
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ChasePuck                                       264CC  97 PC, low confidence
; From assnearest: aims the player at the puck (or its carrier) plus its
; velocity lead, speed by skill level (GameSettings bits 7-8)
;-----------------------------------------------------------------------------
ChasePuck:
        push ebx
        push ecx
        push edx
        sub esp, byte 4
        mov edx, eax
        mov eax, dword [PtrPuckZone]
        mov bl, byte [eax]
        test bl, bl
        jge short .1
        mov eax, dword [PtrPuckFlags]
        mov ecx, dword [PtrPuckTarget]
        mov ebx, dword [byte eax+010h]
        movsx ecx, word [ecx]
        sar ebx, 0Dh
        add ebx, ecx
        mov word [ZoneTargetY], bx
        mov ebx, dword [byte eax+018h]
        mov eax, dword [PtrPuckOwner]
        sar ebx, 0Dh
        movsx eax, word [eax]
        jmp short .2
.1:
        movsx ebx, bl
        mov eax, ebx
        shl eax, 5
        add eax, ebx
        shl eax, 3
        add eax, SortCords
        mov ebx, dword [byte eax+010h]
        mov ecx, dword [byte eax+04h]
        sar ebx, 0Dh
        sar ecx, 10h
        add ebx, ecx
        mov word [ZoneTargetY], bx
        mov ebx, dword [byte eax+018h]
        mov eax, dword [byte eax+0Ch]
        sar ebx, 0Dh
        sar eax, 10h
.2:
        add eax, ebx
        mov word [regd1], ax
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
        mov ebx, dword [byte edx+038h]
        mov dword [byte eax+08h], ebx
        mov eax, dword [dword edx+0EEh]
        mov ebx, dword [byte edx+040h]
        mov dword [byte eax+0Ch], ebx
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, edx
        call SetSkateSpeedFromRating
        test word [GameSettings], 180h
        jne short .3
        mov dword [esp], 43020000h
        jmp short .5
.3:
        mov eax, dword [GameSettings]
        and eax, 180h
        cmp eax, 80h
        jne short .4
        mov dword [esp], 430C0000h
        jmp short .5
.4:
        mov dword [esp], 43160000h
.5:
        mov eax, dword [dword edx+0EEh]
        mov ebx, dword [esp]
        mov dword [byte eax+024h], ebx
        mov eax, edx
        call AimAtPuckTarget
        mov eax, dword [dword edx+0EEh]
        and byte [byte eax+029h], 0FEh
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; assnearest                                     265FC  94G, medium confidence
; assignment 0Ah (AssignFuncTable), the main skater AI
; (forcepldata gives it to the centre)
;-----------------------------------------------------------------------------
assnearest:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov esi, eax
        mov edx, 0FFFFFFFFh
        mov ah, byte [dword eax+0BFh]
        mov dword [esp], edx
        test ah, 2
        je short .1
        mov dword [byte esi+05Ah], 0
        mov dl, byte [dword esi+0BFh]
        mov eax, dword [byte esi+05Ah]
        and dl, 0FDh
        mov dword [byte esi+056h], eax
        mov byte [dword esi+0BFh], dl
.1:
        xor eax, eax
        mov dx, word [onetimerplayer]
        mov al, byte [dword esi+0A4h]
        cmp ax, dx
        jne short .3
        cmp word [OneTimerReady], byte 0
        jne short .2
        cmp word [OneTimerPasser], byte 0
        je short .3
.2:
        xor edi, edi
        mov word [OneTimerReady], di
        mov word [OneTimerPasser], di
.3:
        mov eax, dword [PtrPuckZone]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword esi+0A4h]
        cmp edx, eax
        jne near .9
        cmp word [dword esi+0A9h], byte 0
        jne short .4
        mov eax, esi
        call assgoalie
        jmp near .87
.4:
        mov ch, byte [dword esi+0BFh]
        test ch, 8
        je short .5
        test ch, 40h
        setne al
        and eax, 0FFh
        cmp dword [nosplit eax*4+PuckChasers], byte 0
        je short .8
.5:
        mov eax, dword [dword esi+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+028h]
        and eax, 0FFFFh
        cmp eax, byte 25h
        jl short .6
        cmp eax, byte 31h
        jle near .87
.6:
        mov edx, dword [dword esi+0AEh]
        sar edx, 18h
        mov ebx, 9
        movsx dx, byte [dword edx+esi+0B2h]
        mov eax, esi
        cmp dx, bx
        je short .7
        mov dl, byte [dword esi+0B1h]
        dec dl
        and dl, 7
        mov byte [dword esi+0B1h], dl
.7:
        movsx edx, bx
        call assreplace
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        mov eax, esi
        call ChkForwardSwap
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov ebx, dword [byte esi+056h]
        sub ebx, byte 2
        mov dword [byte esi+056h], ebx
        test ebx, ebx
        jge near .47
        mov eax, dword [dword esi+0FEh]
        mov dword [byte esp+04h], eax
        xor eax, eax
        mov al, byte [dword esi+0C5h]
        mov dword [byte esi+056h], eax
        mov eax, dword [byte esp+04h]
        mov dword [byte eax+012h], 0
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jl short .10
        cmp byte [dword esi+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [PtrPuckZone]
        mov bh, byte [eax]
        and edx, 0FFh
        cmp bh, 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        jne short .10
        mov eax, dword [PtrPuckZone]
        movsx edx, byte [eax]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov ebp, SortCords
        shl eax, 3
        add ebp, eax
        jmp near .25
.10:
        mov edi, 0FFFFFFFFh
        mov edx, 6
        xor eax, eax
        mov bx, word [byte esi+0Eh]
        mov al, byte [dword esi+0A4h]
        mov dword [GoalieTarget], edi
        mov word [ShootSpotY], dx
        mov cl, byte [dword esi+0A4h]
        mov word [byte esp+08h], ax
        cmp cl, 6
        jae short .11
        xor edx, edx
        jmp short .12
.11:
        mov edx, 6
.12:
        mov eax, edx
        shl eax, 5
        mov cx, word [FaceoffRequest]
        add eax, edx
        xor edx, edx
        shl eax, 3
        mov dl, byte [dword esi+0A4h]
        add eax, SortCords
        cmp dx, cx
        je near .21
.13:
        cmp word [dword eax+0A9h], byte 0
        jle near .20
        test byte [dword eax+0C0h], 4
        jne near .20
        cmp dword [byte eax+064h], byte 0
        jne near .20
        cmp word [byte eax+0Eh], byte 0
        jge short .14
        mov edx, dword [byte eax+0Ch]
        sar edx, 10h
        neg edx
        jmp short .15
.14:
        mov edx, dword [byte eax+0Ch]
        sar edx, 10h
.15:
        cmp edx, 10B0h
        jge short .18
        test byte [dword esi+0BFh], 80h
        je short .16
        cmp bx, word [byte eax+0Eh]
        setge dl
        jmp short .17
.16:
        cmp bx, word [byte eax+0Eh]
        setle dl
.17:
        and edx, 0FFh
        je short .18
        xor edx, edx
        mov dl, byte [dword eax+0A4h]
        mov bx, word [byte eax+0Eh]
        mov word [byte esp+08h], dx
.18:
        mov edx, dword [PtrPuckFlags]
        mov ecx, dword [byte edx+010h]
        mov edi, dword [byte edx+04h]
        sar ecx, 0Dh
        sar edi, 10h
        add ecx, edi
        mov edi, dword [byte eax+04h]
        sar edi, 10h
        sub edi, ecx
        mov ecx, edi
        imul ecx, edi
        mov dword [ZoneTargetY], edi
        mov dword [ZoneTargetY], ecx
        mov ecx, dword [byte edx+018h]
        mov edx, dword [byte edx+0Ch]
        sar ecx, 0Dh
        sar edx, 10h
        add edx, ecx
        mov ecx, dword [byte eax+0Ch]
        sar ecx, 10h
        sub ecx, edx
        mov edx, ecx
        imul edx, ecx
        mov dword [regd1], ecx
        mov ecx, dword [ZoneTargetY]
        add ecx, edx
        mov dword [regd1], edx
        mov dword [ZoneTargetY], ecx
        mov edx, dword [dword eax+0AEh]
        sar edx, 18h
        cmp byte [dword edx+eax+0B2h], 0Eh
        je short .19
        test byte [dword eax+0BFh], 20h
        jne short .20
        mov edi, dword [GoalieTarget]
        mov edx, dword [ZoneTargetY]
        cmp edx, edi
        ja short .20
        mov dword [GoalieTarget], edx
        mov ebp, eax
        jmp short .20
.19:
        mov edx, dword [ZoneTargetY]
        mov dword [esp], edx
.20:
        mov di, word [ShootSpotY]
        add eax, 108h
        dec di
        mov word [ShootSpotY], di
        jne near .13
.21:
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jl short .22
        cmp byte [dword esi+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [PtrPuckZone]
        mov bl, byte [eax]
        and edx, 0FFh
        cmp bl, 6
        setl al
        and eax, 0FFh
        xor eax, edx
        jne short .23
.22:
        cmp byte [dword esi+0A4h], 6
        setb al
        mov edx, eax
        mov bx, word [PuckOwnerTeam]
        and edx, 0FFh
        cmp bx, byte 6
        setl al
        and eax, 0FFh
        xor eax, edx
        je short .24
.23:
        test byte [dword esi+0BFh], 40h
        setne al
        and eax, 0FFh
        mov dl, byte [byte esp+08h]
        mov byte [dword eax+NearestPlayer], dl
.24:
        mov eax, dword [GoalieTarget]
        test eax, eax
        jl near .27
        mov edx, dword [byte esp+04h]
        mov dword [byte edx+012h], eax
.25:
        cmp ebp, esi
        je near .27
        test byte [gmode], 1
        jne near .27
        cmp word [dword ebp+0A9h], byte 0
        jle short .27
        test byte [dword ebp+0C0h], 4
        jne short .27
        and byte [dword ebp+0BFh], 0FEh
        mov edx, dword [dword ebp+0AEh]
        sar edx, 18h
        mov ebx, 0Ah
        movsx dx, byte [dword edx+ebp+0B2h]
        mov eax, ebp
        cmp dx, bx
        je short .26
        mov dl, byte [dword ebp+0B1h]
        dec dl
        and dl, 7
        mov byte [dword ebp+0B1h], dl
.26:
        movsx edx, bx
        call assreplace
        mov al, byte [dword esi+0B1h]
        mov bl, byte [dword esi+0BFh]
        inc al
        or bl, 2
        and al, 7
        mov byte [dword esi+0BFh], bl
        mov byte [dword esi+0B1h], al
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.27:
        mov bh, byte [dword esi+0BFh]
        test bh, 20h
        jne near .87
        test byte [gmode], 1
        je short .28
        mov eax, esi
        call check4bench
        test ax, ax
        jne near .87
        mov cl, byte [dword esi+0BFh]
        test cl, 20h
        jne near .87
        test cl, 8
        jne near .87
        mov edx, 8
        mov eax, esi
        call doplayeracc
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.28:
        test bh, 8
        jne near .87
        mov di, word [onetimerplayer]
        test di, di
        jl short .30
        mov ah, byte [dword esi+0A4h]
        xor edx, edx
        cmp ah, 6
        setb dl
        cmp di, byte 6
        setl al
        and eax, 0FFh
        cmp edx, eax
        jne short .30
        mov eax, dword [esp]
        cmp eax, dword [GoalieTarget]
        ja short .30
        cmp word [dword esi+0ABh], byte 2
        jle short .29
        mov eax, esi
        call assextra4
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.29:
        mov eax, esi
        call DefendPuck
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.30:
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jge short .31
        test byte [iflags], 4
        je short .31
        mov dword [byte esi+060h], 3E8h
        jmp near .47
.31:
        mov ebx, 2
        mov ecx, dword [GoalieTarget]
        mov dword [regd1], ebx
        cmp ecx, 0F0h
        jl short .35
        cmp ecx, 2D0h
        jge short .32
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+038h], 41C80000h
        jl short .35
.32:
        cmp word [dword esi+0A9h], byte 2
        jle near .36
        test byte [dword esi+0BFh], 80h
        je short .33
        mov eax, dword [PtrPuckOwner]
        cmp word [eax], 570h
        setg al
        jmp short .34
.33:
        mov eax, dword [PtrPuckOwner]
        movsx eax, word [eax]
        cmp eax, 0FFFFFA90h
        setl al
.34:
        and eax, 0FFh
        je short .36
.35:
        xor eax, eax
        mov dword [regd1], eax
        cmp word [dword esi+0A9h], byte 2
        jg short .36
        xor eax, eax
        mov edx, dword [byte esp+08h]
        mov al, byte [dword esi+0A4h]
        cmp ax, dx
        je near .47
        xor eax, eax
        mov edx, 32h
        mov al, byte [dword esi+0CDh]
        sub edx, eax
        xor eax, eax
        mov al, byte [dword esi+0CFh]
        sub edx, eax
        mov eax, edx
        xor edx, edx
        mov dl, byte [dword esi+0C6h]
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        cwde
        call randomd0
        test ax, ax
        jne near .47
.36:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+038h], 41200000h
        jge short .37
        dec dword [regd1]
.37:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+05Ah], 0C8h
        jle short .38
        dec dword [regd1]
.38:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+05Ah], 190h
        jle short .39
        dec dword [regd1]
.39:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+05Ah], 258h
        jle short .40
        dec dword [regd1]
.40:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+05Ah], 320h
        jle short .41
        dec dword [regd1]
.41:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+05Ah], 3E8h
        jle short .42
        dec dword [regd1]
.42:
        test byte [PlayFlags], 20h
        je short .44
        sub dword [regd1], byte 2
        mov al, byte [dword esi+0BFh]
        and al, 40h
        mov dx, word [PlayFlags]
        xor dh, dh
        and dl, 40h
        and eax, 0FFh
        movsx edx, dx
        xor eax, edx
        je short .43
        add dword [regd1], byte 4
        jmp short .44
.43:
        dec dword [regd1]
        cmp word [dword esi+0ABh], byte 2
        jle short .44
        dec dword [regd1]
.44:
        cmp dword [regd1], byte 0
        jge short .45
        mov edx, 14h
        xor eax, eax
        mov ecx, dword [ZoneFlags]
        mov al, byte [dword esi+0CFh]
        sar ecx, 10h
        sub edx, eax
        neg ecx
        mov eax, edx
        sar eax, cl
        jmp short .46
.45:
        xor eax, eax
        mov edx, 14h
        mov al, byte [dword esi+0CFh]
        sub edx, eax
        mov cx, word [regd1]
        mov eax, edx
        shl eax, cl
.46:
        mov word [ZoneTargetY], ax
        mov eax, dword [ZoneTargetX]
        sar eax, 10h
        call randomd0
        cmp ax, 1
        jge short .47
        mov dword [byte esi+060h], 12Ch
.47:
        mov al, byte [dword esi+0BFh]
        test al, 20h
        jne near .87
        test byte [gmode], 1
        je short .48
        mov eax, esi
        call check4bench
        test ax, ax
        jne near .87
        mov bh, byte [dword esi+0BFh]
        test bh, 20h
        jne near .87
        test bh, 8
        jne near .87
        mov edx, 8
        mov eax, esi
        call doplayeracc
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.48:
        test al, 8
        jne near .87
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jl near .54
        cmp byte [dword esi+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [PtrPuckZone]
        mov bh, byte [eax]
        and edx, 0FFh
        cmp bh, 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        jne near .54
        mov eax, dword [PtrPuckZone]
        movsx edx, byte [eax]
        mov eax, edx
        shl eax, 5
        add eax, edx
        cmp word [nosplit eax*8+PlayerAssignWords], byte 0
        jne near .54
        mov cx, word [dword esi+0ABh]
        cmp cx, byte 1
        je short .49
        cmp cx, byte 2
        jne short .50
.49:
        mov eax, esi
        call FindManToCover
        jmp near .86
.50:
        cmp word [byte esi+06h], byte 0
        jge short .51
        mov eax, 0FFFFFC04h
        jmp short .52
.51:
        mov eax, 3FCh
.52:
        mov edx, 0E70h
        mov word [ZoneTargetY], ax
        mov word [regd1], dx
        test byte [dword esi+0BFh], 80h
        je short .53
        mov word [regd1], 0F190h
.53:
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
        mov dword [byte eax+018h], 41C80000h
        mov eax, esi
        call SetSkateSpeedFromRating
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+024h], 42C80000h
        mov eax, esi
        call ChkPokeOrCheck
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.54:
        mov eax, dword [dword esi+0FEh]
        test byte [byte eax+016h], 10h
        jne short .55
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jl short .56
        cmp byte [dword esi+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [PtrPuckZone]
        mov bl, byte [eax]
        and edx, 0FFh
        cmp bl, 6
        setl al
        and eax, 0FFh
        xor eax, edx
        je short .56
        mov eax, dword [byte esi+060h]
        dec eax
        mov dword [byte esi+060h], eax
        test eax, eax
        jge short .56
.55:
        mov dword [byte esi+060h], 0
        jmp short .58
.56:
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [byte eax+010h]
        mov eax, dword [PtrPuckTarget]
        sar edx, 0Ch
        movsx eax, word [eax]
        mov ebx, 1
        add edx, eax
        mov eax, esi
        call ChkDefenseSwitch
        test eax, eax
        je short .57
        mov eax, esi
        call ChasePuck
        mov eax, esi
        call ChkPokeOrCheck
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.57:
        mov dword [byte esi+060h], eax
.58:
        test byte [PlayFlags], 20h
        je near .61
        mov al, byte [dword esi+0BFh]
        xor edx, edx
        and al, 40h
        mov dl, al
        mov ax, word [PlayFlags]
        xor ah, ah
        and al, 40h
        cwde
        xor eax, edx
        je near .61
        mov eax, dword [PtrPuckOwner]
        mov dx, word [eax]
        test dx, dx
        jge short .59
        movsx eax, dx
        neg eax
        jmp short .60
.59:
        movsx eax, dx
.60:
        cmp eax, 570h
        jle short .61
        test byte [dword esi+0BFh], 80h
        setne al
        mov edx, eax
        mov eax, dword [PtrPuckOwner]
        mov bx, word [eax]
        and edx, 0FFh
        test bx, bx
        setg al
        and eax, 0FFh
        xor eax, edx
        je short .61
        mov cx, word [dword esi+0ABh]
        cmp cx, byte 1
        je short .61
        cmp cx, byte 2
        je short .61
        mov eax, esi
        call assextra3
        mov eax, esi
        call ChkPokeOrCheck
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.61:
        mov ecx, dword [PtrPuckFlags]
        mov eax, dword [PtrPuckTarget]
        mov edx, dword [byte ecx+010h]
        movsx eax, word [eax]
        sar edx, 0Ch
        add edx, eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, eax
        sar edx, 1Fh
        shl edx, 2
        LD sbb, eax, edx
        sar eax, 2
        mov dword [ZoneTargetY], eax
        mov edx, dword [byte ecx+018h]
        mov eax, dword [PtrPuckOwner]
        sar edx, 0Ch
        movsx eax, word [eax]
        add eax, edx
        mov dword [regd1], eax
        test byte [dword esi+0BFh], 80h
        je short .62
        mov eax, 0FFFFF040h
        jmp short .63
.62:
        mov eax, 0FC0h
.63:
        mov ebx, dword [regd1]
        sub eax, ebx
        sar eax, 1
        lea ecx, [ebx+eax]
        mov dword [regd1], ecx
        test byte [dword esi+0BFh], 80h
        je short .64
        cmp ecx, 540h
        jle short .65
        mov dword [regd1], 480h
        jmp short .65
.64:
        cmp ecx, 0FFFFFAC0h
        jge short .65
        mov dword [regd1], 0FFFFFB80h
.65:
        mov edx, dword [ZoneTargetY]
        mov eax, esi
        xor ebx, ebx
        call ChkDefenseSwitch
        test eax, eax
        jne short .66
        mov dword [ZoneTargetY], eax
.66:
        mov eax, dword [PtrPuckOwner]
        mov dx, word [eax]
        test dx, dx
        jge short .67
        movsx edx, dx
        neg edx
        jmp short .68
.67:
        movsx edx, dx
.68:
        mov ecx, dword [regd1]
        test ecx, ecx
        jge short .69
        mov eax, ecx
        neg eax
        jmp short .70
.69:
        mov eax, ecx
.70:
        cmp eax, edx
        jle near .85
        mov eax, dword [PtrPuckTarget]
        mov bx, word [eax]
        test bx, bx
        jge short .71
        movsx eax, bx
        neg eax
        jmp short .72
.71:
        movsx eax, bx
.72:
        cmp eax, 300h
        jge near .85
        mov eax, dword [PtrPuckOwner]
        mov edx, dword [regd1]
        movsx eax, word [eax]
        sub edx, eax
        mov eax, edx
        test edx, edx
        jge short .73
        neg eax
.73:
        cmp eax, 0F0h
        jle near .85
        mov edi, dword [ZoneTargetY]
        test edi, edi
        jge short .74
        mov eax, edi
        neg eax
        jmp short .75
.74:
        mov eax, edi
.75:
        cmp eax, 0F0h
        jge short .79
        mov ebx, dword [regd1]
        test ebx, ebx
        jge short .76
        mov eax, ebx
        neg eax
        jmp short .77
.76:
        mov eax, ebx
.77:
        cmp eax, 0E70h
        jle near .85
        cmp dword [regd1], byte 0
        jge short .78
        mov eax, 0FFFFF190h
        jmp short .84
.78:
        mov eax, 0E70h
        jmp short .84
.79:
        mov ebp, dword [ZoneTargetY]
        test ebp, ebp
        jge short .80
        mov eax, ebp
        neg eax
        jmp short .81
.80:
        mov eax, ebp
.81:
        cmp eax, 1E0h
        jge short .85
        mov eax, dword [regd1]
        test eax, eax
        jge short .82
        neg eax
.82:
        cmp eax, 0F90h
        jle short .85
        cmp dword [regd1], byte 0
        jge short .83
        mov eax, 0FFFFF070h
        jmp short .84
.83:
        mov eax, 0F90h
.84:
        mov dword [regd1], eax
.85:
        mov eax, dword [dword esi+0EEh]
        fild dword [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword esi+0EEh]
        fild dword [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword esi+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+018h], 41C80000h
        mov eax, esi
        call SetSkateSpeedFromRating
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+024h], 42A00000h
.86:
        mov eax, esi
        call ChkPokeOrCheck
.87:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
