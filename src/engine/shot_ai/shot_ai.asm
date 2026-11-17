; Shots: picking the target, updating and starting shots, shot assignments.
bits 32
%include "hockey.inc"
section s_2FFB8 progbits alloc exec nowrite align=1
extern assexit, assreplace, BreakawayFlag, CarrierInShotArea, CommentaryEvent, DefendFlags, F32_neg1392_PickShotTarget, F32_neg432
extern F64_105, F64_10_PickShotTarget, F64_130, F64_20_PickShotTarget, GameSettings, gmode, GoalieTarget, LastTouchPlayer
extern LastTouchTeam, onetimerplayer, OneTimerReady, OneTimerTarget, PassButtonTimes, PassDistX, PassDistY, PassReceiver
extern PtrPuckFlags, PtrPuckOwner, PtrPuckZone, PuckFlags, PuckZone, randomd0, regd1, SetCrowdMood
extern ShotAnimFrames, ShotPending, ShotSpeed, ShotState, ShotTarget, ShotTargetX, ShotTargetY, ShotTimer
extern ShotType, StartOneTimerAnim, StartShotAnim, StartWristShotAnim, ZoneTargetX, ZoneTargetY
global PickShotTarget, UpdateShot, StartShot, assshoot, ChkShoot, ForceShoot
;-----------------------------------------------------------------------------
; PickShotTarget                                  2FFB8  97 PC, low confidence
; Picks where a shot aims (PassReceiver corner 0-8, random unless a set play)
; and the target point at the goal (+-7F8h, +-10B0h)
;-----------------------------------------------------------------------------
PickShotTarget:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov ebx, eax
        mov ah, byte [dword eax+0BFh]
        xor esi, esi
        test ah, 8
        jne short .3
        cmp word [ShotType], byte 0
        jne short .1
        mov eax, dword [dword ebx+0102h]
        mov eax, dword [dword eax+0FAh]
        sar eax, 10h
        test eax, eax
        jge short .2
.1:
        mov word [PassReceiver], 8
        jmp short .3
.2:
        mov eax, 9
        call randomd0
        mov word [PassReceiver], ax
.3:
        mov edi, 0FFFFFFFFh
        mov ax, word [PassReceiver]
        mov word [onetimerplayer], di
        cmp ax, 8
        jle short .4
        mov word [PassReceiver], 8
.4:
        cmp word [ShotType], byte 0
        je near .15
        mov eax, dword [dword ebx+0102h]
        cmp word [byte eax+010h], byte 0
        jl near .15
        mov ax, word [PassReceiver]
        cmp ax, 8
        je short .5
        test byte [dword ebx+0BFh], 8
        jne short .8
.5:
        cmp word [byte ebx+06h], byte 0
        jl short .6
        mov eax, 7F8h
        jmp short .7
.6:
        mov eax, 0FFFFF808h
.7:
        mov word [ShotTimer], ax
        jmp short .11
.8:
        test ax, ax
        jne short .9
        mov ax, word [byte ebx+06h]
        mov word [ShotTimer], ax
        jmp short .11
.9:
        cmp ax, 4
        jle short .10
        mov word [ShotTimer], 0F808h
        jmp short .11
.10:
        mov word [ShotTimer], 7F8h
.11:
        sar word [PassDistX], 1
        mov dh, byte [dword ebx+0BFh]
        mov esi, 1
        test dh, 80h
        je short .12
        cmp dword [byte ebx+028h], 44AE0000h
        jg short .13
.12:
        test byte [dword ebx+0BFh], 80h
        jne short .14
        fld dword [byte ebx+028h]
        fcomp dword [F32_neg1392_PickShotTarget]
        fnstsw ax
        sahf
        jae short .14
.13:
        mov word [ShotTarget], 0C0h
        jmp short .15
.14:
        mov word [ShotTarget], 180h
.15:
        mov eax, 14h
        mov ecx, dword [PassDistY]
        xor edx, edx
        mov ebp, dword [ShotState]
        mov dl, byte [dword ebx+0C8h]
        sar ecx, 10h
        sub eax, edx
        mov edi, dword [nosplit ecx*8+ShotTargetX]
        mov edx, eax
        mov ecx, dword [nosplit ecx*8+ShotTargetY]
        cmp ebp, byte 2
        jne short .16
        lea edx, [eax+eax]
        cmp word [OneTimerReady], byte 0
        je short .16
        add edx, edx
.16:
        mov eax, dword [dword ebx+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+028h]
        and eax, 0FFFFh
        cmp eax, byte 2Dh
        je short .17
        cmp eax, byte 2Fh
        jne short .18
.17:
        add edx, edx
.18:
        mov eax, edx
        add eax, edx
        mov word [byte esp+0Ch], ax
        mov eax, dword [byte esp+0Ah]
        sar eax, 10h
        call randomd0
        cwde
        sub eax, edx
        mov dx, word [ShotTimer]
        add edi, eax
        add ecx, eax
        add edx, edi
        mov di, word [ShotTarget]
        add edi, ecx
        mov word [ShotTimer], dx
        mov word [ShotTarget], di
        test di, di
        jge short .19
        xor edx, edx
        mov word [ShotTarget], dx
.19:
        test esi, esi
        jne short .20
        add word [PassDistX], byte 28h
.20:
        cmp dword [ShotState], byte 2
        jne short .21
        xor eax, eax
        mov dx, word [PassDistX]
        mov al, byte [dword ebx+0C7h]
        jmp short .22
.21:
        xor edx, edx
        mov dl, byte [dword ebx+0C7h]
        mov eax, edx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov edx, dword [LastTouchTeam]
        sar edx, 10h
.22:
        imul edx, eax
        mov word [PassDistX], dx
        sar word [PassDistX], 5
        test esi, esi
        jne short .24
        fild word [PassDistX]
        mov eax, dword [PtrPuckFlags]
        fadd qword [F64_130]
        mov eax, dword [dword eax+0EEh]
        fstp dword [byte eax+08h]
        mov edx, dword [GameSettings]
        and edx, 180h
        cmp edx, 100h
        jne short .23
        mov eax, dword [PtrPuckFlags]
        mov eax, dword [dword eax+0EEh]
        fld dword [byte eax+08h]
        fld st0
        fadd qword [F64_20_PickShotTarget]
        fstp st1
        jmp short .25
.23:
        cmp edx, 80h
        jne short .26
        mov eax, dword [PtrPuckFlags]
        mov eax, dword [dword eax+0EEh]
        fld dword [byte eax+08h]
        fld st0
        fadd qword [F64_10_PickShotTarget]
        fstp st1
        jmp short .25
.24:
        fild word [PassDistX]
        mov eax, dword [PtrPuckFlags]
        fadd qword [F64_105]
        mov eax, dword [dword eax+0EEh]
.25:
        fstp dword [byte eax+08h]
.26:
        mov eax, dword [PtrPuckFlags]
        mov eax, dword [dword eax+0EEh]
        cmp dword [byte eax+08h], 43480000h
        jle short .27
        mov dword [byte eax+08h], 43480000h
.27:
        mov eax, 0C8h
        call randomd0
        cmp ax, word [OneTimerReady]
        jg short .28
        mov edx, 2
        jmp short .29
.28:
        xor edx, edx
.29:
        test edx, edx
        je short .30
        mov eax, dword [LastTouchTeam]
        sar eax, 10h
        sar eax, 1
        mov dword [byte esp+08h], eax
        mov eax, dword [PtrPuckFlags]
        mov eax, dword [dword eax+0EEh]
        fild dword [byte esp+08h]
        fstp dword [byte eax+08h]
.30:
        cmp word [OneTimerTarget], byte 0
        je short .31
        call CarrierInShotArea
        mov ax, word [PuckZone]
        mov word [OneTimerTarget], ax
.31:
        mov eax, ebx
        call StartWristShotAnim
        and byte [PuckFlags], 0F7h
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; UpdateShot                                      30300  97 PC, low confidence
; Shot animation (frames 29h-2Fh): winds up, aims (PickShotTarget), releases
; or gives up (assexit)
;-----------------------------------------------------------------------------
UpdateShot:
        push ebx
        push ecx
        push esi
        mov ebx, eax
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+028h]
        and eax, 0FFFFh
        cmp eax, byte 29h
        jl short .1
        cmp eax, byte 2Fh
        jle short .2
.1:
        and byte [PuckFlags], 0F7h
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        mov ecx, dword [byte ebx+060h]
        add ecx, byte 2
        mov dword [byte ebx+060h], ecx
        cmp ecx, 80h
        jge short .3
        test byte [dword ebx+0BFh], 8
        jne short .4
        test byte [regd1], 20h
        je short .4
.3:
        mov ax, word [byte ebx+060h]
        mov word [PassDistX], ax
        mov eax, ebx
        call PickShotTarget
        cmp edx, byte 0FFFFFFFFh
        jne near .18
        mov eax, ebx
        call assexit
        pop esi
        pop ecx
        pop ebx
        ret
.4:
        test byte [ZoneTargetY], 8
        jne short .5
        mov cx, word [ZoneTargetY]
        xor ch, ch
        and cl, 7
        mov word [PassReceiver], cx
        mov word [ZoneTargetY], cx
.5:
        mov al, byte [regd1]
        test al, 10h
        jne short .6
        test al, 40h
        jne short .6
        mov ecx, dword [PtrPuckZone]
        xor eax, eax
        movsx ecx, byte [ecx]
        mov al, byte [dword ebx+0A4h]
        cmp ecx, eax
        je near .10
.6:
        and byte [PuckFlags], 0F7h
        test edx, edx
        jl short .7
        mov dword [nosplit edx*4+PassButtonTimes], 1
.7:
        mov eax, ebx
        call StartOneTimerAnim
        xor edx, edx
        mov eax, dword [PtrPuckZone]
        mov dl, byte [dword ebx+0A4h]
        movsx eax, byte [eax]
        cmp edx, eax
        jne near .18
        test byte [gmode], 1
        jne near .18
        cmp word [BreakawayFlag], byte 0
        jne near .18
        cmp word [ShotType], byte 0
        jne near .18
        cmp word [dword ebx+0A9h], byte 0
        jne short .8
        mov eax, dword [dword ebx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ebx+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        add edx, 1D42h
        jmp short .9
.8:
        mov eax, dword [dword ebx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ebx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        add edx, 0A3h
.9:
        add eax, edx
        mov edx, dword [LastTouchPlayer]
        push edx
        push dword 3003h
        push dword 3001h
        lea edx, [byte ebx+028h]
        push edx
        lea edx, [byte ebx+020h]
        push edx
        push eax
        test byte [dword ebx+0BFh], 80h
        setne al
        and eax, 0FFh
        push eax
        push dword 0A0000004h
        call CommentaryEvent
        add esp, byte 20h
        pop esi
        pop ecx
        pop ebx
        ret
.10:
        test byte [gmode], 1
        jne near .16
        cmp word [BreakawayFlag], byte 0
        jne near .16
        cmp eax, eax
        jne near .16
        cmp dword [byte ebx+060h], byte 18h
        jne near .16
        test byte [dword ebx+0BFh], 8
        jne short .11
        cmp word [ShotType], byte 0
        jne short .11
        cmp word [ShotPending], byte 0
        jne short .11
        cmp dword [ShotState], byte 2
        je short .12
.11:
        test byte [dword ebx+0BFh], 8
        je near .16
        cmp word [ShotType], byte 0
        jne near .16
.12:
        cmp word [dword ebx+0A9h], byte 0
        jne short .13
        mov eax, dword [dword ebx+0FEh]
        mov ecx, dword [dword eax+0108h]
        mov eax, dword [dword ebx+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        add ecx, 1D42h
        jmp short .14
.13:
        mov eax, dword [dword ebx+0FEh]
        mov ecx, dword [dword eax+0108h]
        mov eax, dword [dword ebx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        add ecx, 0A3h
.14:
        add ecx, eax
        test byte [dword ebx+0BFh], 40h
        jne short .15
        mov eax, 8
        call SetCrowdMood
.15:
        mov esi, dword [LastTouchPlayer]
        push esi
        lea eax, [byte ebx+028h]
        push eax
        lea eax, [byte ebx+020h]
        push eax
        mov ah, byte [dword ebx+0BFh]
        push ecx
        test ah, 40h
        setne al
        and eax, 0FFh
        push eax
        push dword 0A0000003h
        call CommentaryEvent
        add esp, byte 18h
.16:
        test edx, edx
        jl short .18
        test byte [GoalieTarget], 20h
        jne short .17
        test byte [DefendFlags], 20h
        jne short .18
.17:
        mov ax, word [byte ebx+060h]
        mov word [PassDistX], ax
        mov eax, ebx
        call PickShotTarget
.18:
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StartShot                                       305D8  97 PC, low confidence
; Starts a shot: shot flag (PuckFlags 8), aim reset, goal line target
; (+-10B0h), shot animation
;-----------------------------------------------------------------------------
StartShot:
        push ebx
        push ecx
        push edx
        mov edx, eax
        mov ah, byte [PuckFlags]
        mov ebx, 8
        or ah, 8
        mov word [PassReceiver], bx
        mov byte [PuckFlags], ah
        mov bl, byte [dword edx+0BFh]
        mov dword [byte edx+060h], 0
        test bl, 8
        je short .3
        xor ecx, ecx
        mov word [ShotType], cx
        test byte [dword edx+0BFh], 80h
        je short .1
        cmp dword [byte edx+028h], 43D80000h
        jge short .3
        jmp short .2
.1:
        fld dword [byte edx+028h]
        fcomp dword [F32_neg432]
        fnstsw ax
        sahf
        jbe short .3
.2:
        mov word [ShotType], 1
.3:
        xor eax, eax
        mov word [ShotTarget], ax
        mov word [ShotTimer], ax
        test byte [dword edx+0BFh], 80h
        jne short .4
        mov eax, 0FFFFEF50h
        jmp short .5
.4:
        mov eax, 10B0h
.5:
        mov word [ShotSpeed], ax
        mov eax, edx
        call StartShotAnim
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; assshoot                                        30674  97 PC, low confidence
; Asstab 11h: the shooting assignment (StartShot, UpdateShot, slap shot hold
; timer)
;-----------------------------------------------------------------------------
assshoot:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 8
        mov ecx, eax
        mov esi, dword [dword eax+0F6h]
        mov ah, byte [dword eax+0BFh]
        mov esi, dword [esi]
        test ah, 20h
        jne near .9
        mov dl, byte [dword ecx+0BFh]
        test dl, 2
        je short .1
        mov ah, dl
        and ah, 0FDh
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        call StartShot
        jmp near .9
.1:
        test byte [PuckFlags], 8
        jne short .2
        mov eax, ecx
        call assexit
        add esp, byte 8
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        mov dx, word [dword ecx+0BCh]
        sub edx, byte 2
        mov word [dword ecx+0BCh], dx
        test dx, dx
        jge short .3
        mov word [dword ecx+0BCh], 0
.3:
        cmp word [dword ecx+0BCh], byte 0
        jne short .4
        mov eax, dword [dword ecx+0102h]
        cmp dword [dword eax+0FEh], 1E0h
        jge short .4
        mov eax, 14h
        call randomd0
        test ax, ax
        jne short .4
        mov word [dword ecx+0BCh], 12Ch
        or byte [regd1], 10h
        jmp short .5
.4:
        and byte [regd1], 0AFh
.5:
        mov ebx, esp
        mov eax, dword [byte esi+028h]
        lea edx, [byte esp+04h]
        and eax, 0FFFFh
        call ShotAnimFrames
        cmp word [ShotPending], byte 0
        je short .6
        cmp dword [byte esi+04h], byte 4
        jg short .7
.6:
        mov eax, dword [byte esi+04h]
        cmp eax, dword [byte esp+04h]
        jne short .8
.7:
        or byte [regd1], 20h
.8:
        mov edx, 0FFFFFFFFh
        mov eax, ecx
        call UpdateShot
.9:
        add esp, byte 8
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ChkShoot                                        30778  97 PC, low confidence
; Computer player decides to shoot from the distance to the goal line (10B0h
; - y < 3C0h) and chance, then assignment 11h
;-----------------------------------------------------------------------------
ChkShoot:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        test byte [PuckFlags], 8
        jne near .8
        mov eax, dword [PtrPuckOwner]
        mov ax, word [eax]
        mov word [ZoneTargetY], ax
        test byte [dword ebx+0BFh], 80h
        jne short .1
        mov edx, eax
        neg edx
        mov word [ZoneTargetY], dx
.1:
        mov eax, 10B0h
        mov cx, word [ZoneTargetY]
        sub eax, ecx
        mov word [ZoneTargetY], ax
        cmp ax, 3C0h
        jl short .2
        mov eax, 4
        call randomd0
        test ax, ax
        jne short .3
.2:
        xor ecx, ecx
        mov dword [ShotState], ecx
        jmp short .4
.3:
        mov dword [ShotState], 2
.4:
        cmp word [ZoneTargetY], 3C0h
        jl short .5
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        cmp byte [dword ebx+eax+0B2h], 1Bh
        jne short .6
.5:
        mov word [ShotPending], 1
        jmp short .7
.6:
        xor eax, eax
        mov word [ShotPending], ax
.7:
        mov eax, 0Ch
        call randomd0
        movsx edx, ax
        add edx, byte 3Ch
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, dword [ZoneTargetX]
        shl eax, 4
        sar edx, 10h
        cmp edx, eax
        setg al
        xor ah, ah
        mov edx, 11h
        mov word [ShotType], ax
        mov eax, ebx
        call assreplace
.8:
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ForceShoot                                      3085C  97 PC, low confidence
; Immediate shot: shot settings and assignment 11h unless a shot is already
; on
;-----------------------------------------------------------------------------
ForceShoot:
        push edx
        test byte [PuckFlags], 8
        jne short .1
        mov dword [ShotState], 2
        mov edx, 1
        mov word [ShotPending], dx
        mov word [ShotType], dx
        mov edx, 11h
        call assreplace
.1:
        pop edx
        ret
