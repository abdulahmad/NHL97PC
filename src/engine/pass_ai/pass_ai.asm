; Pass and shot decisions: pass targets, credit, one-timers, rimming, AI passing and shooting.
bits 32
%include "hockey.inc"
section s_240CE progbits alloc exec nowrite align=1
extern __CHP, assreplace, AwayGoalieOff, BreakawayFlag, ChkOneTimerSpot, ChkShoot, ClearLastPasser, CommentaryEvent
extern CrowdForPuckZone, DefendFlags, doplayeracc, F32_0p166667, F64_0p785398_CanReceivePass, F64_0p785398_MakePass, F64_1080, F64_3p14159_CanReceivePass
extern F64_4272, F64_480, F64_576_RimPuck, ForceShoot, gameclock, GameOptionFlags, gmode, HomeGoalieOff
extern hypot_, IF@ATAN2, LastPlayerTouch, LastTouchPlayer, OneTimerPasser, onetimerplayer, OneTimerReady, onetimershot
extern OneTimerTarget, PassDistX, PassDistY, PassFrom, PassPending, PassReceiver, PassState, PassTarget
extern PassTargetAngle, PassTo, penshotlive, PickSkateAnim, PlayFlags, PtrAwayIce, PtrHomeIce, PtrPuckFlags
extern PtrPuckOwner, PtrPuckTarget, PtrPuckZone, PuckFlags, PuckOwner, PuckZone, randomd0, regd1
extern ReplayPlaying, RimTargetX, RimTargetY, ShootSpotX, ShootSpotY, SortCords, SpeedScale, StartDropPassAnim
extern StartPassAnim, StoppageFlag, vecdist, vtoa, ZoneFlags, ZoneTargetX, ZoneTargetY
global BuildPassTargets, CreditPass, assonetimer, CarrierInShotArea, CanReceivePass, MakePass, RimPuck, StartPass
global TargetInAngle, AIPassDecision, ChkAIShoot
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; BuildPassTargets                                240D0  97 PC, low confidence
; Fills a player's table of passing targets: each teammate's distance and
; lane, best target first
;-----------------------------------------------------------------------------
BuildPassTargets:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ebx, eax
        mov byte [dword eax+0A3h], 0FFh
        mov esi, eax
        mov dword [dword eax+09Fh], 7FFFFFFFh
        lea edx, [byte eax+010h]
.1:
        add eax, byte 2
        mov dword [byte esi+06Fh], 7FFFFFFFh
        add esi, byte 4
        mov word [dword eax+08Dh], 0FFFFh
        cmp eax, edx
        jne short .1
        cmp byte [dword ebx+0A4h], 6
        jae short .2
        mov edx, 6
        jmp short .3
.2:
        xor edx, edx
.3:
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov esi, SortCords
        shl eax, 3
        xor edi, edi
        add esi, eax
.4:
        cmp word [dword esi+0A9h], byte 0
        jle near .8
        mov eax, dword [dword esi+0EEh]
        test byte [byte eax+031h], 1
        jne near .8
        test byte [dword esi+0BFh], 20h
        jne near .8
        mov eax, dword [byte esi+04h]
        mov edx, dword [byte ebx+04h]
        sar eax, 10h
        sar edx, 10h
        sub eax, edx
        mov ecx, dword [byte ebx+0Ch]
        mov dword [esp], eax
        mov eax, dword [byte esi+0Ch]
        sar ecx, 10h
        sar eax, 10h
        sub eax, ecx
        mov ecx, eax
        movsx edx, ax
        mov eax, dword [byte esp-02h]
        sar eax, 10h
        call vtoa
        mov dl, byte [dword ebx+0BFh]
        mov byte [byte esp+04h], al
        test dl, 80h
        jne short .5
        xor al, 4
        mov byte [byte esp+04h], al
.5:
        push ecx
        mov edx, dword [byte esp+04h]
        push edx
        call vecdist
        add esp, byte 8
        xor edx, edx
        mov dl, byte [byte esp+04h]
        lea ecx, [nosplit edx*4+00h]
        add ecx, ebx
        mov ebp, eax
        cmp eax, dword [byte ecx+06Fh]
        jge short .6
        mov dword [byte ecx+06Fh], eax
        xor eax, eax
        mov al, byte [dword esi+0A4h]
        mov word [dword ebx+edx*2+08Fh], ax
.6:
        mov dh, byte [byte esp+04h]
        cmp dh, 6
        jae short .7
        cmp dh, 2
        ja short .8
.7:
        cmp ebp, dword [dword ebx+09Fh]
        jge short .8
        mov al, byte [byte esp+04h]
        mov dword [dword ebx+09Fh], ebp
        mov byte [dword ebx+0A3h], al
.8:
        inc edi
        add esi, 108h
        cmp edi, byte 6
        jl near .4
        mov eax, dword [dword ebx+09Fh]
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CreditPass                                      24220  97 PC, low confidence
; A teammate takes a pass: counts the completed pass for the team and calls
; the play-by-play
;-----------------------------------------------------------------------------
CreditPass:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 8
        mov edx, eax
        xor ebx, ebx
        mov si, word [onetimerplayer]
        mov word [OneTimerReady], bx
        mov word [OneTimerPasser], bx
        test si, si
        jl near .10
        mov eax, dword [PtrPuckFlags]
        mov di, word [byte eax+06Dh]
        cmp di, byte 1
        jne near .10
        cmp byte [dword edx+0A4h], 6
        setb al
        mov ebx, eax
        and ebx, 0FFh
        cmp si, byte 6
        setl al
        and eax, 0FFh
        cmp eax, ebx
        jne near .6
        cmp dword [ReplayPlaying], byte 0
        jne short .1
        mov eax, dword [dword edx+0FEh]
        mov eax, dword [dword eax+0108h]
        add word [dword eax+020EBh], di
.1:
        mov ebx, dword [PuckOwner]
        sar ebx, 10h
        mov eax, ebx
        shl eax, 5
        add eax, ebx
        shl eax, 3
        add eax, SortCords
        cmp word [dword eax+0A9h], byte 0
        jne short .2
        mov ebx, dword [dword eax+0A3h]
        sar ebx, 18h
        sub ebx, byte 19h
        imul ebx, dword 125h
        mov ecx, dword [dword eax+0FEh]
        mov ecx, dword [dword ecx+0108h]
        add ecx, 1D42h
        jmp short .3
.2:
        mov ebx, dword [dword eax+0FEh]
        mov ecx, dword [dword ebx+0108h]
        mov ebx, dword [dword eax+0A3h]
        sar ebx, 18h
        imul ebx, dword 125h
        add ecx, 0A3h
.3:
        add ecx, ebx
        cmp word [dword edx+0A9h], byte 0
        jne short .4
        mov ebx, dword [dword edx+0FEh]
        mov esi, dword [dword ebx+0108h]
        mov ebx, dword [dword edx+0A3h]
        sar ebx, 18h
        sub ebx, byte 19h
        imul ebx, dword 125h
        add esi, 1D42h
        jmp short .5
.4:
        mov esi, dword [dword edx+0A3h]
        sar esi, 18h
        imul esi, dword 125h
        mov ebx, dword [dword edx+0FEh]
        mov ebx, dword [dword ebx+0108h]
        add ebx, 0A3h
.5:
        add ebx, esi
        mov edi, dword [LastTouchPlayer]
        push edi
        mov esi, dword [PassFrom]
        push esi
        mov edi, dword [PassTo]
        push edi
        lea esi, [byte edx+028h]
        push esi
        lea esi, [byte edx+020h]
        push esi
        fild word [LastPlayerTouch]
        push ebx
        lea ebx, [byte ebp-08h]
        fild word [StoppageFlag]
        push ebx
        lea ebx, [byte ebp-04h]
        fxch
        fstp dword [byte ebp-04h]
        push ebx
        fstp dword [byte ebp-08h]
        push ecx
        test byte [dword eax+0BFh], 80h
        setne al
        and eax, 0FFh
        push eax
        push dword 0A0000002h
        call CommentaryEvent
        add esp, byte 2Ch
        mov eax, edx
        call CrowdForPuckZone
        mov word [onetimerplayer], 0FFFFh
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        cmp byte [dword edx+0A4h], 6
        setb al
        mov ebx, eax
        and ebx, 0FFh
        cmp si, byte 6
        setl al
        and eax, 0FFh
        xor eax, ebx
        je near .9
        cmp word [dword edx+0A9h], byte 0
        jne short .7
        mov eax, dword [dword edx+0FEh]
        mov ebx, dword [dword eax+0108h]
        mov eax, dword [dword edx+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        add ebx, 1D42h
        jmp short .8
.7:
        mov eax, dword [dword edx+0FEh]
        mov ebx, dword [dword eax+0108h]
        mov eax, dword [dword edx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        add ebx, 0A3h
.8:
        add ebx, eax
        mov ecx, dword [PuckOwner]
        sar ecx, 10h
        mov eax, ecx
        shl eax, 5
        add eax, ecx
        shl eax, 3
        add eax, SortCords
        cmp word [dword eax+0A9h], byte 0
        mov ecx, dword [LastTouchPlayer]
        mov eax, dword [PtrPuckFlags]
        fldz
        push ecx
        fcomp dword [byte eax+024h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        mov cl, byte [dword edx+0BFh]
        push eax
        test cl, 40h
        setne al
        and eax, 0FFh
        push eax
        push ebx
        push dword 0A000000Dh
        call CommentaryEvent
        add esp, byte 14h
.9:
        mov word [onetimerplayer], 0FFFFh
.10:
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
; assonetimer                                     244BC  97 PC, low confidence
; Asstab 0Eh: the one-timer: waits for the pass, then shoots (onetimershot)
;-----------------------------------------------------------------------------
assonetimer:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        mov eax, dword [PtrPuckZone]
        mov dl, byte [eax]
        test dl, dl
        jge near .7
        jge short .1
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [byte eax+060h]
        dec edx
        mov dword [byte eax+060h], edx
        cmp edx, byte 0FFFFFFFBh
        jl near .7
.1:
        mov cl, byte [dword ebx+0BFh]
        test cl, 20h
        jne near .13
        test byte [gmode], 1
        jne near .7
        test cl, 8
        je short .2
        mov eax, ebx
        call ClearLastPasser
        mov eax, ebx
        call onetimershot
        jmp near .13
.2:
        test cl, 2
        je short .5
        mov dl, cl
        and dl, 0FCh
        mov byte [dword ebx+0BFh], dl
        mov dh, dl
        or dh, 1
        mov byte [dword ebx+0BFh], dh
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jge short .5
        test dh, 40h
        je short .3
        mov ax, word [AwayGoalieOff]
        jmp short .4
.3:
        mov ax, word [HomeGoalieOff]
.4:
        test ax, ax
        jne short .5
        mov eax, ebx
        call ChkOneTimerSpot
        test ax, ax
        je short .5
        mov word [OneTimerReady], 1
.5:
        mov ax, word [regd1]
        mov cx, word [OneTimerReady]
        and al, 0AFh
        test cx, cx
        je short .6
        mov word [regd1], ax
        mov eax, ebx
        call onetimershot
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        cmp word [OneTimerPasser], byte 0
        je near .13
        mov word [regd1], ax
        mov eax, ebx
        call ClearLastPasser
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        and byte [dword ebx+0BFh], 0FCh
        mov al, byte [dword ebx+0B1h]
        inc al
        and al, 7
        mov byte [dword ebx+0B1h], al
        mov ah, byte [dword ebx+0BFh]
        or ah, 2
        mov byte [dword ebx+0BFh], ah
        test byte [gmode], 1
        je short .8
        test ah, 20h
        jne near .12
        test ah, 8
        jne near .12
        mov edx, 8
        mov eax, ebx
        call doplayeracc
        jmp near .12
.8:
        mov eax, dword [PtrPuckZone]
        xor ecx, ecx
        movsx edx, byte [eax]
        mov cl, byte [dword ebx+0A4h]
        cmp ecx, edx
        jne short .9
        mov eax, ebx
        call CreditPass
        jmp near .12
.9:
        cmp byte [eax], 0
        jge near .12
        cmp word [OneTimerReady], byte 0
        jne near .12
        cmp word [OneTimerPasser], byte 0
        jne near .12
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+028h]
        fsub dword [byte ebx+028h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte eax+020h]
        fsub dword [byte ebx+020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_480]
        fnstsw ax
        sahf
        jae short .12
        cmp word [dword ebx+0A9h], byte 0
        jne short .10
        mov edx, dword [dword ebx+0A3h]
        sar edx, 18h
        sub edx, byte 19h
        imul edx, dword 125h
        mov eax, dword [dword ebx+0FEh]
        mov eax, dword [dword eax+0108h]
        add eax, 1D42h
        jmp short .11
.10:
        mov eax, dword [dword ebx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ebx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        add edx, 0A3h
.11:
        add eax, edx
        mov esi, dword [LastTouchPlayer]
        mov cl, byte [dword ebx+0BFh]
        push esi
        xor ebx, ebx
        test cl, 40h
        setne bl
        push ebx
        push eax
        push dword 0A0000014h
        call CommentaryEvent
        add esp, byte 10h
.12:
        xor ebx, ebx
        mov edi, 0FFFFFFFFh
        mov word [OneTimerReady], bx
        mov word [OneTimerTarget], bx
        mov word [onetimerplayer], di
        mov word [OneTimerPasser], bx
.13:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CarrierInShotArea                               2471C  97 PC, low confidence
; Whether the puck carrier is in the area in front of the net he attacks
; (play running); returns nonzero if so
;-----------------------------------------------------------------------------
CarrierInShotArea:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        xor edx, edx
        mov eax, dword [PtrPuckZone]
        mov word [PuckZone], dx
        mov dl, byte [eax]
        test dl, dl
        jl short .1
        test byte [gmode], 1
        jne short .1
        cmp word [BreakawayFlag], byte 0
        je short .2
.1:
        xor eax, eax
        jmp near .17
.2:
        movsx edx, dl
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov ebx, SortCords
        shl eax, 3
        add ebx, eax
        mov eax, dword [byte ebx+04h]
        mov edi, dword [byte ebx+0Ch]
        mov cl, byte [dword ebx+0BFh]
        sar eax, 10h
        sar edi, 10h
        test cl, 80h
        je near .9
        test edi, edi
        jge short .3
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        push eax
        lea eax, [dword edi-01080h]
        push eax
        xor esi, esi
        add edi, byte 30h
        call vecdist
        mov ebp, eax
        mov al, byte [dword ebx+0A4h]
        add esp, byte 8
        cmp al, 6
        jae short .4
        mov eax, 6
        jmp short .5
.4:
        xor eax, eax
.5:
        mov edx, eax
        shl eax, 5
        add eax, edx
        mov ebx, SortCords
        shl eax, 3
        add ebx, eax
        cmp esi, byte 6
        jge near .16
.6:
        cmp word [dword ebx+0A9h], byte 0
        jle short .8
        mov edx, dword [byte ebx+0Ch]
        mov ecx, dword [byte ebx+04h]
        sar edx, 10h
        sar ecx, 10h
        cmp edx, edi
        jle short .7
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        fldz
        fcomp dword [byte ebx+034h]
        fnstsw ax
        sahf
        ja short .8
        push ecx
        sub edx, 10B0h
        push edx
        call vecdist
        add esp, byte 8
        cmp eax, ebp
        jg short .8
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        inc esi
        add ebx, 108h
        cmp esi, byte 6
        jl short .6
        jmp near .16
.9:
        test edi, edi
        jle short .10
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        push eax
        lea eax, [dword edi+01080h]
        push eax
        xor esi, esi
        sub edi, byte 30h
        call vecdist
        add esp, byte 8
        mov ch, byte [dword ebx+0A4h]
        mov ebp, eax
        cmp ch, 6
        jae short .11
        mov eax, 6
        jmp short .12
.11:
        xor eax, eax
.12:
        mov edx, eax
        shl eax, 5
        add eax, edx
        mov ebx, SortCords
        shl eax, 3
        add ebx, eax
        cmp esi, byte 6
        jge short .16
.13:
        cmp word [dword ebx+0A9h], byte 0
        jle short .15
        mov edx, dword [byte ebx+0Ch]
        mov ecx, dword [byte ebx+04h]
        sar edx, 10h
        sar ecx, 10h
        cmp edx, edi
        jge short .14
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.14:
        fldz
        fcomp dword [byte ebx+034h]
        fnstsw ax
        sahf
        jb short .15
        push ecx
        add edx, 10B0h
        push edx
        call vecdist
        add esp, byte 8
        cmp eax, ebp
        jg short .15
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.15:
        inc esi
        add ebx, 108h
        cmp esi, byte 6
        jl short .13
.16:
        mov edx, 1
        mov eax, 1
        mov word [PuckZone], dx
.17:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CanReceivePass                                  248E8  97 PC, low confidence
; Whether a teammate can take a pass: on the ice, open, close enough and
; ahead of the passer
;-----------------------------------------------------------------------------
CanReceivePass:
        push ebx
        push ecx
        mov ebx, eax
        cmp word [dword eax+0A9h], byte 0
        jne short .1
        xor eax, eax
        pop ecx
        pop ebx
        ret
.1:
        test byte [dword eax+0BFh], 8
        jne short .2
        call CarrierInShotArea
        test eax, eax
        je short .2
        xor eax, eax
        pop ecx
        pop ebx
        ret
.2:
        call SpeedScale
        fmul dword [F32_0p166667]
        fcomp dword [byte ebx+038h]
        fnstsw ax
        sahf
        jbe short .3
        xor eax, eax
        pop ecx
        pop ebx
        ret
.3:
        cmp dword [dword edx+0E2h], 5A0h
        jle short .4
        xor eax, eax
        pop ecx
        pop ebx
        ret
.4:
        test byte [dword ebx+0BFh], 80h
        je short .8
        cmp word [byte ebx+0Eh], 570h
        jge short .5
        xor eax, eax
        pop ecx
        pop ebx
        ret
.5:
        mov eax, dword [byte edx+0Ch]
        mov ecx, dword [byte edx+018h]
        sar eax, 10h
        sar ecx, 0Ah
        add eax, ecx
        cmp eax, 570h
        jge short .6
        xor eax, eax
        pop ecx
        pop ebx
        ret
.6:
        fld dword [byte ebx+040h]
        fabs
        fcomp qword [F64_0p785398_CanReceivePass]
        fnstsw ax
        sahf
        ja short .7
        fld dword [byte edx+040h]
        fabs
        fcomp qword [F64_0p785398_CanReceivePass]
        fnstsw ax
        sahf
        jbe short .12
.7:
        xor eax, eax
        pop ecx
        pop ebx
        ret
.8:
        mov eax, dword [byte ebx+0Ch]
        sar eax, 10h
        cmp eax, 0FFFFFA90h
        jle short .9
        xor eax, eax
        pop ecx
        pop ebx
        ret
.9:
        mov ecx, dword [byte edx+0Ch]
        mov eax, dword [byte edx+018h]
        sar ecx, 10h
        sar eax, 0Ah
        add eax, ecx
        cmp eax, 0FFFFFA90h
        jle short .10
        xor eax, eax
        pop ecx
        pop ebx
        ret
.10:
        fld dword [byte ebx+040h]
        fsubr qword [F64_3p14159_CanReceivePass]
        fabs
        fcomp qword [F64_0p785398_CanReceivePass]
        fnstsw ax
        sahf
        ja short .11
        fld dword [byte edx+040h]
        fsubr qword [F64_3p14159_CanReceivePass]
        fabs
        fcomp qword [F64_0p785398_CanReceivePass]
        fnstsw ax
        sahf
        jbe short .12
.11:
        xor eax, eax
        pop ecx
        pop ebx
        ret
.12:
        mov eax, 1
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; MakePass                                        249F8  97 PC, low confidence
; The passer lets the puck go: clears the carrier, sets the puck speed from
; the pass power, counts the pass and calls the play-by-play
;-----------------------------------------------------------------------------
MakePass:
        push ebx
        push ecx
        push esi
        push edi
        mov ecx, eax
        mov ebx, edx
        and byte [PuckFlags], 0F7h
        mov dword [byte ecx+064h], 10h
        mov eax, dword [PtrPuckZone]
        mov byte [eax], 0FFh
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+038h], 0
        fild word [PassReceiver]
        fmul qword [F64_0p785398_MakePass]
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+040h]
        test edx, edx
        je near .4
        cmp dword [ReplayPlaying], byte 0
        jne short .1
        mov eax, dword [dword ecx+0FEh]
        mov eax, dword [dword eax+0108h]
        inc word [dword eax+020E9h]
.1:
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+060h], 20h
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        mov esi, 0Eh
        movsx dx, byte [dword edx+ebx+0B2h]
        mov eax, ebx
        cmp dx, si
        je short .2
        mov dl, byte [dword ebx+0B1h]
        dec dl
        and dl, 7
        mov byte [dword ebx+0B1h], dl
.2:
        movsx edx, si
        call assreplace
        mov eax, dword [dword ebx+0FAh]
        mov dword [byte eax+01Ch], 0
        mov eax, ebx
        call PickSkateAnim
        fld dword [byte ecx+038h]
        fsub dword [byte ebx+038h]
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+038h]
        mov edx, dword [PtrPuckFlags]
        fldz
        fcomp dword [byte edx+038h]
        fnstsw ax
        sahf
        jbe short .3
        mov dword [byte edx+038h], 0
.3:
        test byte [gmode], 1
        jne near .4
        cmp word [BreakawayFlag], byte 0
        jne near .4
        mov edx, dword [dword ecx+0A3h]
        sar edx, 18h
        imul edx, dword 125h
        mov eax, dword [dword ecx+0FEh]
        mov eax, dword [dword eax+0108h]
        add eax, 0A3h
        lea esi, [eax+edx]
        mov eax, dword [dword ebx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ebx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        mov dword [PassTo], 2001h
        mov edi, dword [LastTouchPlayer]
        add edx, 0A3h
        push edi
        add edx, eax
        mov eax, 2005h
        push eax
        push dword 2001h
        mov dword [PassFrom], eax
        lea eax, [byte ebx+028h]
        push eax
        add ebx, byte 20h
        push ebx
        push edx
        lea eax, [byte ecx+028h]
        push eax
        lea eax, [byte ecx+020h]
        push eax
        mov dh, byte [dword ecx+0BFh]
        push esi
        test dh, 80h
        setne al
        and eax, 0FFh
        push eax
        push dword 0A0000001h
        call CommentaryEvent
        add esp, byte 2Ch
.4:
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        sub esp, byte 8
        mov ecx, eax
        mov ebx, edx
        mov word [onetimerplayer], 0FFFFh
        mov edx, ebx
        call StartPassAnim
        mov eax, dword [PtrPuckFlags]
        mov eax, dword [dword eax+0EEh]
        fild word [PassDistX]
        fstp dword [byte eax+08h]
        mov edx, dword [byte ebx+04h]
        mov eax, dword [byte ecx+04h]
        sar edx, 10h
        sar eax, 10h
        sub edx, eax
        mov dword [esp], edx
        mov eax, dword [byte ebx+0Ch]
        mov edx, dword [byte ecx+0Ch]
        sar eax, 10h
        sar edx, 10h
        sub eax, edx
        mov dword [byte esp+04h], eax
        fild dword [byte esp+04h]
        fild dword [esp]
        call IF@ATAN2
        mov eax, dword [PtrPuckFlags]
        mov eax, dword [dword eax+0EEh]
        fstp dword [byte eax+0Ch]
        add esp, byte 8
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; RimPuck                                         24C00  97 PC, low confidence
; Pass type 8: shoots the puck around the boards to a teammate
;-----------------------------------------------------------------------------
RimPuck:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 114h
        mov ebx, eax
        cmp word [PassReceiver], byte 8
        jne near .32
        test byte [dword eax+0106h], 4
        je near .14
        fld dword [byte ebx+020h]
        fabs
        fcomp qword [F64_576_RimPuck]
        fnstsw ax
        sahf
        jae short .3
        fld dword [byte ebx+028h]
        fabs
        fcomp qword [F64_4272]
        fnstsw ax
        sahf
        jbe short .3
        mov eax, 2
        call randomd0
        test ax, ax
        je short .1
        mov edx, 7F8h
        jmp short .2
.1:
        mov edx, 0FFFFF808h
.2:
        mov word [byte esp+06h], dx
        mov esi, 3Ch
        mov ax, word [byte ebx+0Eh]
        mov word [PassDistX], si
        mov esi, 9002h
        mov word [byte esp+0Eh], ax
        mov dword [PassTo], esi
        jmp near .33
.3:
        fld dword [byte ebx+020h]
        fabs
        fcomp qword [F64_1080]
        fnstsw ax
        sahf
        jbe near .11
        fld dword [byte ebx+028h]
        fabs
        fcomp qword [F64_4272]
        fnstsw ax
        sahf
        jbe near .11
        mov eax, 2
        call randomd0
        test ax, ax
        je short .6
        cmp word [byte ebx+06h], byte 0
        jle short .4
        mov edx, 7F8h
        jmp short .5
.4:
        mov edx, 0FFFFF808h
.5:
        mov ecx, 4Bh
        mov word [byte esp+06h], dx
        mov word [PassDistX], cx
        xor edx, edx
        mov ecx, 9000h
        mov word [byte esp+0Eh], dx
        mov dword [PassTo], ecx
        jmp near .33
.6:
        cmp word [byte ebx+06h], byte 0
        jle short .7
        mov edx, 0FFFFF808h
        jmp short .8
.7:
        mov edx, 7F8h
.8:
        mov word [byte esp+06h], dx
        test byte [dword ebx+0BFh], 80h
        je short .9
        mov edx, 0FFFFED40h
        jmp short .10
.9:
        mov edx, 12C0h
.10:
        mov edi, 4Bh
        mov word [byte esp+0Eh], dx
        mov edx, 9002h
        mov word [PassDistX], di
        mov dword [PassTo], edx
        jmp near .33
.11:
        cmp word [byte ebx+06h], byte 0
        jle short .12
        mov edx, 7F8h
        jmp short .13
.12:
        mov edx, 0FFFFF808h
.13:
        mov ecx, 28h
        mov eax, 9001h
        mov word [byte esp+06h], dx
        mov word [PassDistX], cx
        xor edx, edx
        mov dword [PassTo], eax
        mov word [byte esp+0Eh], dx
        jmp near .33
.14:
        mov dl, byte [dword ebx+0106h]
        test dl, 2
        je short .19
        fldz
        fcomp dword [byte ebx+020h]
        fnstsw ax
        sahf
        jae short .15
        mov edx, 7F8h
        jmp short .16
.15:
        mov edx, 0FFFFF808h
.16:
        mov word [byte esp+06h], dx
        test byte [dword ebx+0BFh], 80h
        je short .17
        mov edx, 930h
        jmp short .18
.17:
        mov edx, 0FFFFF6D0h
.18:
        mov edi, 41h
        mov ebp, 8000h
        mov word [byte esp+0Eh], dx
        mov word [PassDistX], di
        mov dword [PassTo], ebp
        jmp near .33
.19:
        test dl, 40h
        je short .24
        fldz
        fcomp dword [byte ebx+020h]
        fnstsw ax
        sahf
        jae short .20
        mov edx, 7F8h
        jmp short .21
.20:
        mov edx, 0FFFFF808h
.21:
        mov word [byte esp+06h], dx
        test byte [dword ebx+0BFh], 80h
        je short .22
        mov edx, 10B0h
        jmp short .23
.22:
        mov edx, 0FFFFEF50h
.23:
        mov esi, 50h
        mov edi, 8002h
        mov word [byte esp+0Eh], dx
        mov word [PassDistX], si
        mov dword [PassTo], edi
        jmp near .33
.24:
        fld dword [byte ebx+020h]
        fabs
        fcomp qword [F64_1080]
        fnstsw ax
        sahf
        jbe short .27
        fld dword [byte ebx+028h]
        fabs
        fcomp qword [F64_4272]
        fnstsw ax
        sahf
        jbe short .27
        cmp word [byte ebx+06h], byte 0
        jle short .25
        mov edx, 0FFFFF808h
        jmp short .26
.25:
        mov edx, 7F8h
.26:
        mov word [byte esp+06h], dx
        mov ecx, 46h
        mov ax, word [byte ebx+0Eh]
        mov esi, 8000h
        mov word [byte esp+0Eh], ax
        mov word [PassDistX], cx
        mov dword [PassTo], esi
        jmp near .33
.27:
        mov eax, 2
        call randomd0
        test ax, ax
        je short .28
        mov edx, 7F8h
        jmp short .29
.28:
        mov edx, 0FFFFF808h
.29:
        mov word [byte esp+06h], dx
        test byte [dword ebx+0BFh], 80h
        je short .30
        mov edx, 12C0h
        jmp short .31
.30:
        mov edx, 0FFFFED40h
.31:
        mov eax, 3Ch
        mov ecx, 8000h
        mov word [byte esp+0Eh], dx
        mov word [PassDistX], ax
        mov dword [PassTo], ecx
        jmp short .33
.32:
        mov edx, dword [PassDistY]
        sar edx, 10h
        mov ax, word [byte eax+06h]
        mov cx, word [nosplit edx*4+RimTargetX]
        mov edi, 55h
        add eax, ecx
        mov si, word [nosplit edx*4+RimTargetY]
        mov word [byte esp+06h], ax
        mov edx, 9000h
        mov ax, word [byte ebx+0Eh]
        mov word [PassDistX], di
        add eax, esi
        mov dword [PassTo], edx
        mov word [byte esp+0Eh], ax
.33:
        cmp word [dword ebx+0A9h], byte 0
        jne short .34
        call SpeedScale
        fild word [PassDistX]
        fcompp
        fnstsw ax
        sahf
        jbe short .34
        xor eax, eax
        mov al, byte [dword ebx+0CBh]
        mov dword [dword esp+0110h], eax
        fild word [dword esp+0110h]
        fstp dword [dword esp+0108h]
        call SpeedScale
        fadd dword [dword esp+0108h]
        call __CHP
        fistp dword [dword esp+010Ch]
        mov eax, dword [dword esp+010Ch]
        mov word [PassDistX], ax
.34:
        mov eax, 0FFFFFFFFh
        mov edx, esp
        mov word [onetimerplayer], ax
        mov eax, ebx
        call StartPassAnim
        mov edx, dword [PtrPuckFlags]
        mov eax, dword [dword edx+0EEh]
        fild word [PassDistX]
        fstp dword [byte eax+08h]
        mov edx, dword [byte esp+04h]
        mov eax, dword [byte ebx+04h]
        sar edx, 10h
        sar eax, 10h
        sub edx, eax
        mov eax, dword [byte esp+0Ch]
        mov dword [dword esp+0108h], edx
        mov edx, dword [byte ebx+0Ch]
        sar eax, 10h
        sar edx, 10h
        sub eax, edx
        mov dword [dword esp+010Ch], eax
        fild dword [dword esp+010Ch]
        fild dword [dword esp+0108h]
        call IF@ATAN2
        mov eax, dword [PtrPuckFlags]
        mov eax, dword [dword eax+0EEh]
        fstp dword [byte eax+0Ch]
        add esp, 114h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; StartPass                                       25010  97 PC, low confidence
; Starts a pass by its type (normal, flip, rim, drop) to the chosen teammate
;-----------------------------------------------------------------------------
StartPass:
        push ebx
        push ecx
        push edi
        sub esp, byte 8
        mov ecx, eax
        mov ah, byte [PuckFlags]
        xor ebx, ebx
        and ah, 0FBh
        mov word [OneTimerReady], bx
        mov byte [PuckFlags], ah
        mov ax, word [PassState]
        mov word [OneTimerPasser], bx
        cmp ax, 2
        jb short .1
        jbe short .3
        cmp ax, 0Ah
        jb near .6
        jbe short .5
        cmp ax, 63h
        je short .4
        jmp near .6
.1:
        test ax, ax
        jne near .6
        cmp dword [ReplayPlaying], byte 0
        jne short .2
        mov ebx, dword [dword ecx+0FEh]
        mov ebx, dword [dword ebx+0108h]
        inc word [dword ebx+020E9h]
.2:
        xor eax, eax
        mov al, byte [dword edx+0A4h]
        mov word [onetimerplayer], ax
        mov eax, ecx
        call StartPassAnim
        jmp near .6
.3:
        mov eax, ecx
        call MakePass
        jmp near .6
.4:
        mov eax, ecx
        call RimPuck
        jmp near .6
.5:
        mov edi, 0FFFFFFFFh
        mov ebx, dword [PassPending]
        mov edx, dword [PassTarget]
        mov eax, ecx
        sar ebx, 10h
        sar edx, 10h
        mov word [onetimerplayer], di
        call StartDropPassAnim
        mov edx, dword [PtrPuckFlags]
        mov edx, dword [dword edx+0EEh]
        fild word [PassDistX]
        fstp dword [byte edx+08h]
        mov ebx, dword [byte ecx+04h]
        mov edx, dword [PassTarget]
        sar ebx, 10h
        sar edx, 10h
        sub edx, ebx
        mov ebx, dword [PassPending]
        mov dword [esp], edx
        mov edx, dword [byte ecx+0Ch]
        sar ebx, 10h
        sar edx, 10h
        sub ebx, edx
        mov dword [byte esp+04h], ebx
        fild dword [byte esp+04h]
        fild dword [esp]
        call IF@ATAN2
        mov edx, dword [PtrPuckFlags]
        mov edx, dword [dword edx+0EEh]
        fstp dword [byte edx+0Ch]
.6:
        add esp, byte 8
        pop edi
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        mov ebx, eax
        mov ecx, edx
        call CanReceivePass
        test ax, ax
        je short .7
        mov word [PassState], 2
        jmp short .8
.7:
        mov word [PassState], ax
.8:
        mov edx, ecx
        mov eax, ebx
        call StartPass
        cmp word [dword ebx+0A9h], byte 0
        jle short .9
        mov al, byte [dword ebx+0B1h]
        inc al
        and al, 7
        mov byte [dword ebx+0B1h], al
        or byte [dword ebx+0BFh], 2
.9:
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; TargetInAngle                                   25188  97 PC, low confidence
; Whether a teammate lies within the given angle of the passer's heading and
; farther than him; returns 1 if so
;-----------------------------------------------------------------------------
TargetInAngle:
        push esi
        mov esi, dword [dword eax+0E2h]
        cmp esi, dword [dword edx+0E2h]
        jl short .4
        mov eax, dword [dword edx+0EAh]
        add eax, 8000h
        cmp eax, 8000h
        jle short .1
        sub eax, 10000h
.1:
        mov edx, dword [PassTargetAngle]
        sub edx, eax
        mov eax, edx
        cmp edx, 8000h
        jle short .2
        lea eax, [dword edx-010000h]
        jmp short .3
.2:
        cmp edx, 0FFFF8000h
        jge short .3
        lea eax, [dword edx+010000h]
.3:
        mov edx, ebx
        neg edx
        cmp eax, edx
        jle short .4
        cmp eax, ebx
        jge short .4
        mov eax, 1
        pop esi
        ret
.4:
        xor eax, eax
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; AIPassDecision                                  251F0  97 PC, low confidence
; Computer puck carrier decides to pass, shoot or keep skating; picks the
; receiver
;-----------------------------------------------------------------------------
AIPassDecision:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov ebp, eax
        xor edx, edx
        mov dword [byte esp+08h], edx
        mov edx, 0FFFFFFFFh
        mov eax, 5
        mov word [PassState], dx
        call randomd0
        movsx edx, ax
        cmp byte [dword ebp+0A4h], 6
        jae short .1
        xor eax, eax
        jmp short .2
.1:
        mov eax, 6
.2:
        mov ecx, eax
        shl ecx, 5
        add ecx, eax
        mov esi, SortCords
        shl ecx, 3
        add esi, ecx
        mov ecx, edx
        shl ecx, 5
        add ecx, edx
        shl ecx, 3
        add esi, ecx
        cmp dword [byte esi+064h], byte 0
        jne near .33
        cmp esi, ebp
        je near .33
        mov eax, dword [dword esi+0EEh]
        test byte [byte eax+031h], 1
        jne near .33
        cmp word [dword esi+0A9h], byte 0
        jle near .33
        test byte [dword esi+0BFh], 20h
        jne near .33
        test byte [dword esi+0C0h], 4
        jne near .33
        cmp word [dword ebp+0A9h], byte 0
        jne short .3
        cmp dword [dword esi+0E2h], 5A0h
        jg near .36
.3:
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 10h
        je short .4
        test byte [dword esi+0C0h], 80h
        jne near .33
.4:
        test byte [dword ebp+0106h], 1
        jne short .5
        test byte [dword esi+0106h], 1
        jne near .33
.5:
        mov eax, dword [dword esi+0EAh]
        add eax, 8000h
        mov dword [PassTargetAngle], eax
        cmp eax, 8000h
        jle short .6
        sub eax, 10000h
        mov dword [PassTargetAngle], eax
.6:
        mov ecx, dword [byte ebp+00h]
        mov eax, dword [PassTargetAngle]
        sar ecx, 10h
        sub eax, ecx
        mov ecx, eax
        cmp eax, 8000h
        jle short .7
        lea ecx, [dword eax-010000h]
        jmp short .8
.7:
        cmp eax, 0FFFF8000h
        jge short .8
        lea ecx, [dword eax+010000h]
.8:
        cmp ecx, 4000h
        jg short .9
        cmp ecx, 0FFFFC000h
        jge short .10
.9:
        mov edx, esi
        mov eax, ebp
        call CanReceivePass
        test ax, ax
        je near .33
        mov word [PassState], 2
        jmp near .35
.10:
        test byte [dword ebp+0106h], 1
        je short .11
        test byte [dword esi+0106h], 1
        je near .33
.11:
        test byte [dword ebp+0106h], 4
        je short .13
        mov bl, byte [dword esi+0106h]
        test bl, 4
        je short .13
        test byte [dword esi+0107h], 2
        je short .12
        test bl, 40h
        jne near .33
.12:
        mov eax, esi
        call BuildPassTargets
        cmp eax, 1E0h
        jle near .33
.13:
        test byte [dword ebp+0106h], 1
        jne near .16
        test byte [dword ebp+0BFh], 80h
        je short .14
        mov edx, dword [byte ebp+0Ch]
        mov eax, dword [byte esi+0Ch]
        sar edx, 10h
        sar eax, 10h
        add edx, 150h
        cmp eax, edx
        jl near .33
        jmp short .15
.14:
        mov eax, dword [byte ebp+0Ch]
        mov edx, dword [byte esi+0Ch]
        sar eax, 10h
        sar edx, 10h
        sub eax, 150h
        cmp edx, eax
        jg near .33
.15:
        mov ah, byte [dword esi+0106h]
        test ah, 2
        je short .16
        test ah, 10h
        je short .16
        test byte [dword esi+0BFh], 80h
        setne al
        xor edx, edx
        mov ebx, dword [byte esi+018h]
        mov dl, al
        test ebx, ebx
        setle al
        and eax, 0FFh
        xor eax, edx
        je short .16
        mov dword [byte esp+08h], 1
.16:
        cmp word [dword ebp+0A9h], byte 0
        jne short .17
        mov edi, 1000h
        jmp short .21
.17:
        mov bl, byte [dword ebp+0BFh]
        mov ecx, dword [PtrPuckOwner]
        test bl, 80h
        setne al
        xor edx, edx
        mov bx, word [ecx]
        mov dl, al
        test bx, bx
        setg al
        and eax, 0FFh
        xor edx, eax
        je short .20
        test bx, bx
        jge short .18
        movsx eax, bx
        neg eax
        jmp short .19
.18:
        movsx eax, bx
.19:
        cmp eax, 570h
        jle short .20
        mov edi, 0C00h
        jmp short .21
.20:
        mov edi, 800h
.21:
        cmp byte [dword esi+0A4h], 6
        jae short .22
        mov eax, 6
        jmp short .23
.22:
        xor eax, eax
.23:
        mov ecx, eax
        shl ecx, 5
        add ecx, eax
        shl ecx, 3
        xor eax, eax
        add ecx, SortCords
        mov word [DefendFlags], ax
.24:
        mov ebx, edi
        mov edx, ecx
        mov eax, esi
        call TargetInAngle
        test ax, ax
        jne near .31
        mov bx, word [DefendFlags]
        inc ebx
        add ecx, 108h
        mov word [DefendFlags], bx
        cmp bx, byte 6
        jl short .24
        test byte [dword esi+0BFh], 80h
        je short .25
        mov ecx, dword [PtrHomeIce]
        jmp short .26
.25:
        mov ecx, dword [PtrAwayIce]
.26:
        mov edx, dword [byte esi+0Ch]
        mov eax, dword [byte ebp+0Ch]
        sar edx, 10h
        sar eax, 10h
        sub edx, eax
        mov dword [esp], edx
        mov eax, dword [esp]
        mov edi, dword [byte ebp+04h]
        movsx edx, ax
        mov eax, dword [byte esi+04h]
        sar edi, 10h
        sar eax, 10h
        sub eax, edi
        mov edi, eax
        cwde
        call vtoa
        mov dword [byte esp+018h], eax
        mov ebx, dword [byte ecx+0Ch]
        mov eax, dword [byte ebp+0Ch]
        sar ebx, 10h
        sar eax, 10h
        sub ebx, eax
        mov eax, dword [byte ecx+04h]
        mov ecx, dword [byte ebp+04h]
        sar eax, 10h
        sar ecx, 10h
        sub eax, ecx
        mov word [byte esp+014h], ax
        mov ecx, eax
        mov eax, dword [byte esp+012h]
        sar eax, 10h
        movsx edx, bx
        call vtoa
        cmp ax, word [byte esp+018h]
        jne short .27
        push ebx
        push ecx
        call vecdist
        add esp, byte 8
        mov ebx, eax
        mov eax, dword [esp]
        push eax
        push edi
        add ebx, byte 30h
        call vecdist
        add esp, byte 8
        cmp eax, ebx
        ja near .31
.27:
        test byte [dword esi+0BFh], 80h
        je short .28
        mov ecx, dword [PtrAwayIce]
        jmp short .29
.28:
        mov ecx, dword [PtrHomeIce]
.29:
        mov eax, dword [byte esi+0Ch]
        mov edx, dword [byte ebp+0Ch]
        sar eax, 10h
        sar edx, 10h
        sub eax, edx
        mov dword [byte esp+010h], eax
        mov eax, dword [byte esp+010h]
        mov ebx, dword [byte esi+04h]
        movsx edx, ax
        mov eax, dword [byte ebp+04h]
        sar ebx, 10h
        sar eax, 10h
        sub ebx, eax
        mov dword [byte esp+0Ch], ebx
        mov eax, dword [byte esp+0Ch]
        cwde
        call vtoa
        mov edi, eax
        mov edx, dword [byte ebp+0Ch]
        mov eax, dword [byte ecx+0Ch]
        sar edx, 10h
        sar eax, 10h
        sub eax, edx
        mov dword [byte esp+04h], eax
        mov eax, dword [byte esp+04h]
        mov ebx, dword [byte ebp+04h]
        movsx edx, ax
        mov eax, dword [byte ecx+04h]
        sar ebx, 10h
        sar eax, 10h
        sub eax, ebx
        mov ebx, eax
        cwde
        call vtoa
        cmp di, ax
        jne short .30
        mov edx, dword [byte esp+04h]
        push edx
        push ebx
        call vecdist
        add esp, byte 8
        mov ecx, dword [byte esp+010h]
        push ecx
        mov edi, dword [byte esp+010h]
        mov ebx, eax
        push edi
        add ebx, byte 30h
        call vecdist
        add esp, byte 8
        cmp eax, ebx
        ja short .31
.30:
        xor ebx, ebx
        mov word [PassState], bx
        jmp near .35
.31:
        cmp dword [byte esp+08h], byte 0
        je short .33
        mov eax, ebp
        call ForceShoot
        xor eax, eax
        mov al, byte [dword esi+0A4h]
        mov word [onetimerplayer], ax
        mov edx, dword [dword esi+0AEh]
        sar edx, 18h
        mov ebx, 0Eh
        movsx dx, byte [dword edx+esi+0B2h]
        mov eax, esi
        cmp dx, bx
        je short .32
        mov dl, byte [dword esi+0B1h]
        dec dl
        and dl, 7
        mov byte [dword esi+0B1h], dl
.32:
        movsx edx, bx
        call assreplace
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+060h], 0A0h
        mov eax, 1
        jmp near .37
.33:
        cmp dword [dword ebp+09Fh], 150h
        jg short .35
        mov al, byte [dword ebp+0A3h]
        cmp al, 6
        jge short .34
        cmp al, 2
        jg short .35
.34:
        mov edi, 8
        mov ecx, 63h
        mov word [PassReceiver], di
        mov word [PassState], cx
.35:
        mov eax, dword [onetimerplayer]
        sar eax, 10h
        cmp eax, byte 0FFFFFFFFh
        je short .36
        mov edx, esi
        mov eax, ebp
        call StartPass
        mov ax, word [dword ebp+0A9h]
        test ax, ax
        je short .37
        mov al, byte [dword ebp+0B1h]
        mov dl, byte [dword ebp+0BFh]
        inc al
        or dl, 2
        and al, 7
        mov byte [dword ebp+0BFh], dl
        mov byte [dword ebp+0B1h], al
        mov eax, 1
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.36:
        xor eax, eax
.37:
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ChkAIShoot                                      25730  97 PC, low confidence
; Computer carrier decides to shoot from range and angle (always late in a
; period when behind)
;-----------------------------------------------------------------------------
ChkAIShoot:
        push ebx
        push ecx
        push edx
        push edi
        mov ebx, eax
        cmp word [penshotlive], byte 0
        jne short .1
        cmp word [gameclock], byte 4
        jge short .1
        mov eax, dword [dword eax+0FEh]
        mov edx, dword [dword ebx+0102h]
        mov ax, word [eax]
        cmp ax, word [edx]
        jl near .11
.1:
        test byte [dword ebx+0BFh], 80h
        jne short .2
        mov eax, dword [PtrPuckOwner]
        mov ax, word [eax]
        add eax, 10B0h
        mov word [regd1], ax
        jmp short .3
.2:
        mov eax, dword [PtrPuckOwner]
        mov edx, 10B0h
        mov ax, word [eax]
        sub edx, eax
        mov word [regd1], dx
.3:
        mov di, word [regd1]
        test di, di
        jg short .4
        xor eax, eax
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        cmp di, 10B0h
        jl short .5
        xor eax, eax
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov eax, dword [PtrPuckTarget]
        mov ax, word [eax]
        mov word [ZoneTargetY], ax
        mov eax, dword [ZoneFlags]
        sar eax, 10h
        push eax
        mov eax, dword [ZoneTargetX]
        sar eax, 10h
        push eax
        call vecdist
        xor dh, dh
        mov ecx, 20h
        mov dl, byte [dword ebx+0CAh]
        sub ecx, edx
        add esp, byte 8
        mov word [ShootSpotY], cx
        cmp eax, 5A0h
        jg short .7
        mov eax, dword [dword ebx+0102h]
        cmp word [byte eax+010h], byte 0
        jge short .6
        mov word [ShootSpotY], 1
        jmp short .9
.6:
        sar cx, 1
        mov word [ShootSpotY], cx
        test byte [byte ebx+06Dh], 1
        je short .9
        mov word [ShootSpotY], 1
        jmp short .9
.7:
        mov edx, dword [dword ebx+0102h]
        cmp word [byte edx+010h], byte 0
        jge short .8
        cmp eax, 3C0h
        jg short .8
        mov word [ShootSpotY], 1
        jmp short .9
.8:
        shl word [ShootSpotY], 4
.9:
        mov eax, dword [ShootSpotX]
        sar eax, 10h
        call randomd0
        cmp ax, 8
        jle short .10
        xor eax, eax
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        test byte [PlayFlags], 80h
        je short .11
        xor eax, eax
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        mov eax, ebx
        call ChkShoot
        mov eax, 1
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
