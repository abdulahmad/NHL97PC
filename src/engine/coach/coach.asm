; Coach: line changes, line slots, energy and coach modes.
bits 32
%include "hockey.inc"
section s_2DE92 progbits alloc exec nowrite align=1
extern __CHP, AwayGoalieOff, AwCoachDefense, AwCoachGoalie, AwCoachLines, AwCoachOffense, AwCoachTimer, awtmstruct
extern CommentaryEvent, CompLineTable, DelayedPen, F32_0p01, F32_40_ChkTiredPlayer, FaceoffDropX, FaceoffDropY, FaceoffSlots
extern FaceoffX, FaceoffY, gameclock, GameOptionFlags, gmode, GoalieOut, gsp, HmCoachDefense
extern HmCoachGoalie, HmCoachLines, HmCoachOffense, HmCoachTimer, HmLineState, hmtmstruct, HomeGoalieOff, HomeSkaters
extern LastTouchPlayer, MessagePanel, PuckFlags, QueueOverlayPanel, randomd0, RemoveOverlayPanel, setpersonel, SortCords
extern StatsPanelPlayer
global CoachLineChange, CoachLineChange_1A5, CoachLineChange_259, TeamLineSlots, LineSlotsPtr, LineSlotsPtr_33, RestoreBenchEnergy, ChkTiredPlayer
global AvgLineEnergy, CompLine, SetCoachMode, ResetCoachModes, UpdateCoachModes, StartFaceoffLineChange
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CoachLineChange                                 2DE94  97 PC, low confidence
; Computer coach changes a team's line when the line is tired or the
; situation changes (power play, empty net)
;-----------------------------------------------------------------------------
CoachLineChange:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebx, eax
        movsx edx, ax
        mov eax, edx
        shl eax, 4
        add eax, edx
        shl eax, 2
        sub eax, edx
        mov si, word [nosplit eax*4+HmLineState]
        test bx, bx
        je short .1
        mov ax, word [AwayGoalieOff]
        jmp short .2
.1:
        mov ax, word [HomeGoalieOff]
.2:
        test ax, ax
        je near .7
        movsx eax, si
        and eax, 0FFF0h
        cmp eax, 0FF00h
        je near .7
        test si, si
        setge al
        xor edx, edx
        mov cx, word [MessagePanel]
        mov dl, al
        cmp dx, cx
        jg short .3
        cmp cx, byte 1
        jg short .4
.3:
        mov eax, dword [DelayedPen]
        sar eax, 10h
        call RemoveOverlayPanel
        movsx eax, dx
        push eax
        push byte 50h
        push byte 0
        call QueueOverlayPanel
        add esp, byte 0Ch
.4:
        movsx edi, bx
        mov eax, edi
        shl eax, 4
        add eax, edi
        shl eax, 2
        sub eax, edi
        mov edx, hmtmstruct
        shl eax, 2
        add edx, eax
        mov eax, ebx
        xor al, 1
        movsx ecx, ax
        mov eax, ecx
        shl eax, 4
        add eax, ecx
        shl eax, 2
        sub eax, ecx
        mov ebp, hmtmstruct
        shl eax, 2
        add ebp, eax
        test si, si
        jge short .5
        mov cx, word [byte edx+010h]
        xor ch, ch
        and cl, 0Fh
        mov word [byte edx+010h], cx
        jmp short .6
.5:
        mov ax, word [byte edx+010h]
        mov ecx, dword [dword edx+0FAh]
        or eax, 0FFF0h
        sar ecx, 10h
        mov word [byte edx+010h], ax
        mov eax, ecx
        shl eax, 5
        add eax, ecx
        shl eax, 3
        add eax, SortCords
        mov cl, byte [dword eax+0A6h]
        mov byte [dword edi+GoalieOut], cl
        mov eax, dword [dword eax+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        mov ecx, dword [dword edx+0108h]
        add ecx, 1D42h
        add ecx, eax
        mov ax, word [edx]
        cmp ax, word [byte ebp+00h]
        setge al
        mov edx, dword [LastTouchPlayer]
        push edx
        and eax, 0FFh
        push eax
        push ecx
        push dword 0A000002Eh
        call CommentaryEvent
        add esp, byte 10h
.6:
        movsx edx, bx
        mov eax, edx
        shl eax, 4
        add eax, edx
        shl eax, 2
        sub eax, edx
        shl eax, 2
        add eax, hmtmstruct
        call setpersonel
.7:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        mov ebx, dword [dword eax+0108h]
        movsx edx, dx
        add ebx, 20F9h
        add edx, edx
        add edx, ebx
        xor ebx, ebx
        mov bl, byte [edx]
        inc edx
        mov bx, word [byte eax+ebx*2+018h]
        mov dl, byte [edx]
        and edx, 0FFh
        add bx, word [byte eax+edx*2+018h]
        movsx edx, bx
        mov eax, edx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        pop ebx
        ret
CoachLineChange_1A5:
        cmp dx, byte 6
        jge short .9
        cmp word [byte eax+010h], byte 0
        setge al
        mov edx, dword [byte esi+0Ch]
        and eax, 0FFh
        sar edx, 10h
        sub edx, eax
        cmp edx, byte 4
        jne short .8
        movsx eax, di
        shl eax, 2
        mov ecx, dword [dword esi+0108h]
        lea edx, [byte eax-010h]
        lea eax, [dword ecx+02109h]
        jmp near .11
.8:
        movsx eax, di
        lea edx, [byte eax-04h]
        mov ecx, dword [dword esi+0108h]
        lea eax, [nosplit edx*4+00h]
        add ecx, 20FFh
        add eax, edx
        mov edi, 5
        add eax, ecx
        jmp short CoachLineChange_259.12
.9:
        cmp word [byte eax+010h], byte 0
        setge al
        mov edx, dword [byte esi+0Ch]
        and eax, 0FFh
        sar edx, 10h
        sub edx, eax
        cmp edx, byte 3
        jne short .10
        movsx eax, di
        lea edx, [byte eax-06h]
        lea eax, [nosplit edx*4+00h]
        mov ecx, dword [dword esi+0108h]
        sub eax, edx
        lea edx, [dword ecx+0211Bh]
        mov edi, 3
        jmp short CoachLineChange_259
.10:
        movsx eax, di
        mov edx, dword [dword esi+0108h]
        shl eax, 2
        add edx, 2113h
        sub eax, byte 18h
.11:
        mov edi, 4
CoachLineChange_259:
        add eax, edx
.12:
        xor edx, edx
        xor ebx, ebx
        test di, di
        jle short .14
.13:
        xor ecx, ecx
        mov cl, byte [eax]
        inc eax
        inc edx
        add bx, word [byte esi+ecx*2+018h]
        cmp dx, di
        jl short .13
.14:
        movsx edx, bx
        movsx ecx, di
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; TeamLineSlots                                   2E11C  97 PC, low confidence
; Picks the team (away when the argument is positive, else home) and falls
; into LineSlotsPtr
;-----------------------------------------------------------------------------
TeamLineSlots:
        movsx edx, dx
        test ax, ax
        jle short LineSlotsPtr_33
        mov eax, awtmstruct
        lea eax, [byte eax+00h]
;-----------------------------------------------------------------------------
; LineSlotsPtr                                    2E12C  97 PC, low confidence
; Returns a pointer to the player slots of a team's line
;-----------------------------------------------------------------------------
LineSlotsPtr:
        push ebx
        push ecx
        push esi
        push edi
        mov esi, eax
        mov edi, edx
        cmp dx, byte 4
        jge near CoachLineChange_1A5
        movsx edx, dx
        mov ecx, dword [dword eax+0108h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, eax
        lea eax, [dword ecx+020EDh]
        mov edi, 3
        jmp short CoachLineChange_259
;-----------------------------------------------------------------------------
; LineSlotsPtr_33                                          2E15F  97 PC, low confidence
; Entry inside LineSlotsPtr for the home team: loads the home team record and joins it
;-----------------------------------------------------------------------------
LineSlotsPtr_33:
        mov eax, hmtmstruct
        jmp short LineSlotsPtr
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; RestoreBenchEnergy                             2E168  94G, medium confidence
; from periodicevents; every bench player (position
; 8002h) gains 5 energy, capped at 1000h
;-----------------------------------------------------------------------------
RestoreBenchEnergy:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, hmtmstruct
        xor ecx, ecx
        mov esi, 1000h
.1:
        xor edx, edx
.2:
        movsx eax, dx
        add eax, eax
        add eax, ebx
        cmp word [byte eax+050h], 8002h
        jne short .3
        mov di, word [byte eax+018h]
        add edi, byte 5
        mov word [byte eax+018h], di
        cmp si, di
        jge short .3
        mov word [byte eax+018h], si
.3:
        inc edx
        cmp dx, byte 1Ch
        jl short .2
        inc ecx
        add ebx, 10Ch
        cmp cx, byte 2
        jl short .1
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        push edx
        mov edx, dword [GameOptionFlags]
        test byte [byte edx+01h], 0C0h
        je short .6
        mov edx, dword [dword eax+0A3h]
        sar edx, 18h
        lea ebx, [nosplit edx*2+00h]
        mov edx, dword [dword eax+0FEh]
        mov dx, word [byte edx+ebx+018h]
        sub edx, byte 64h
        test dx, dx
        jge short .4
        xor edx, edx
        jmp short .5
.4:
        movsx edx, dx
.5:
        mov ebx, dword [dword eax+0A3h]
        sar ebx, 18h
        mov eax, dword [dword eax+0FEh]
        mov word [byte eax+ebx*2+018h], dx
.6:
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ChkTiredPlayer                                  2E208  97 PC, low confidence
; With line changes on: now and then a tired skater loses speed
;-----------------------------------------------------------------------------
ChkTiredPlayer:
        push ebx
        push ecx
        push edx
        sub esp, byte 8
        mov edx, eax
        test byte [gmode], 1
        jne near .7
        cmp word [dword edx+0A9h], byte 0
        je near .7
        cmp byte [dword edx+0A4h], 0Ch
        je near .7
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 0C0h
        je near .7
        mov eax, 28h
        call randomd0
        test ax, ax
        jne near .7
        mov eax, dword [dword edx+0A3h]
        mov ebx, dword [dword edx+0FEh]
        sar eax, 18h
        mov ebx, dword [byte ebx+eax*2+016h]
        mov eax, dword [dword edx+0EEh]
        fld dword [byte eax+024h]
        fmul dword [F32_40_ChkTiredPlayer]
        fmul dword [F32_0p01]
        call __CHP
        fistp dword [esp]
        mov eax, dword [esp]
        mov word [byte esp+04h], ax
        mov eax, dword [byte esp+02h]
        sar ebx, 10h
        sar eax, 10h
        sub ebx, eax
        mov eax, ebx
        cmp bx, 0C00h
        jge short .3
        test bx, bx
        jge short .1
        xor eax, ebx
        jmp short .2
.1:
        movsx eax, bx
.2:
        mov ebx, eax
        mov eax, dword [dword edx+0A3h]
        sar eax, 18h
        mov edx, dword [dword edx+0FEh]
        mov word [byte edx+eax*2+018h], bx
        jmp short .7
.3:
        xor ebx, ebx
        mov bl, byte [dword edx+0CCh]
        add eax, ebx
        cmp ax, 1000h
        jle short .4
        mov eax, 1000h
.4:
        test ax, ax
        jge short .5
        xor eax, eax
        jmp short .6
.5:
        cwde
.6:
        mov ecx, eax
        mov eax, dword [dword edx+0A3h]
        sar eax, 18h
        lea ebx, [nosplit eax*2+00h]
        mov eax, dword [dword edx+0FEh]
        mov word [byte ebx+eax+018h], cx
.7:
        add esp, byte 8
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AvgLineEnergy                                   2E310  97 PC, low confidence
; Returns the average energy of a team's skaters on the ice
;-----------------------------------------------------------------------------
AvgLineEnergy:
        push ebx
        push edx
        push esi
        push edi
        push ebp
        mov edi, eax
        mov eax, dword [dword eax+0104h]
        xor edx, edx
        xor esi, esi
        xor ebx, ebx
.1:
        cmp word [dword eax+0A9h], byte 0
        jle short .4
        cmp byte [dword eax+0A7h], 0
        jl short .2
        mov ebp, dword [dword eax+0A4h]
        jmp short .3
.2:
        mov ebp, dword [dword eax+0A3h]
.3:
        sar ebp, 18h
        add dx, word [byte edi+ebp*2+018h]
        inc esi
.4:
        inc ebx
        add eax, 108h
        cmp bx, byte 6
        jl short .1
        test si, si
        je short .5
        movsx edx, dx
        movsx edi, si
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        jmp short .6
.5:
        xor eax, eax
.6:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CompLine                                       2E378  94G, medium confidence
; (team, other team) picks the line for the computer team to
; change to (0F33h threshold)
;-----------------------------------------------------------------------------
CompLine:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov esi, eax
        mov ebx, edx
        cmp word [gsp], byte 0
        jg short .1
        mov di, word [StatsPanelPlayer]
        cmp di, word [gameclock]
        jle near .37
.1:
        mov dx, word [byte esi+0Eh]
        mov ax, word [byte ebx+0Eh]
        sub ax, dx
        je short .7
        test ax, ax
        jge short .2
        mov ecx, 6
        jmp short .3
.2:
        mov ecx, 4
.3:
        test byte [gmode], 1
        je short .4
        mov ebp, 190h
        jmp short .5
.4:
        xor ebp, ebp
.5:
        movsx edx, cx
        mov eax, ebx
        call LineSlotsPtr
        add ebp, 0F33h
        mov esi, eax
        cwde
        cmp eax, ebp
        jge short .6
        mov edi, ecx
        inc edi
        mov eax, ebx
        movsx edx, di
        call LineSlotsPtr
        cmp si, ax
        jge short .6
        mov ecx, edi
.6:
        mov ah, byte [dword ebx+0A6h]
        mov word [byte ebx+02h], cx
        and ah, 0BFh
        mov byte [dword ebx+0A6h], ah
        jmp near .38
.7:
        mov ah, byte [dword ebx+0A6h]
        test ah, 1
        je near .15
        mov dl, byte [gmode]
        mov cx, word [byte ebx+02h]
        test dl, 1
        je short .12
        cmp cx, byte 4
        jge short .12
        test ah, 40h
        jne short .12
        mov eax, ebx
        call AvgLineEnergy
        mov edi, eax
        mov dx, word [byte esi+0Eh]
        cmp dx, word [byte ebx+0Eh]
        jne short .8
        mov eax, dword [dword ebx+0A8h]
        jmp short .9
.8:
        mov eax, 0F33h
.9:
        mov edx, eax
        test byte [gmode], 1
        je short .10
        mov eax, 190h
        jmp short .11
.10:
        xor eax, eax
.11:
        movsx edx, dx
        add eax, edx
        movsx edx, di
        cmp edx, eax
        jg near .38
.12:
        cmp cx, byte 3
        jle short .13
        mov ecx, 3
.13:
        cmp byte [dword ebx+0A7h], 6
        jne short .18
        cmp cx, byte 4
        jl short .14
        cmp cx, byte 5
        jle short .18
.14:
        mov ecx, 3
        jmp short .18
.15:
        cmp word [gsp], byte 0
        jg short .16
        mov dx, word [StatsPanelPlayer]
        cmp dx, word [gameclock]
        jle short .18
.16:
        mov cx, word [byte esi+02h]
        cmp cx, byte 6
        jl short .17
        sub ecx, byte 6
        jmp short .18
.17:
        cmp cx, byte 4
        jl short .18
        sub ecx, byte 4
.18:
        cmp byte [dword ebx+0A7h], 1
        jne short .19
        test byte [dword ebx+0A6h], 80h
        je short .19
        add ecx, byte 4
.19:
        mov edx, dword [dword ebx+0A4h]
        movsx eax, cx
        sar edx, 18h
        shl eax, 2
        mov esi, dword [nosplit edx*4+CompLineTable]
        add esi, eax
        mov ax, word [byte ebx+02h]
        mov word [byte esp+0Ch], ax
        mov edx, dword [byte esp+0Ah]
        mov eax, ebx
        sar edx, 10h
        xor edi, edi
        call LineSlotsPtr
        mov dword [byte esp+08h], eax
.20:
        xor ecx, ecx
        mov cl, byte [esi]
        inc esi
        test cx, cx
        jl short .24
        movsx eax, cx
        mov dh, byte [gmode]
        movsx cx, byte [dword ebx+eax+0ACh]
        test dh, 1
        je short .21
        mov eax, 190h
        jmp short .22
.21:
        xor eax, eax
.22:
        mov ebp, dword [dword ebx+0A8h]
        movsx edx, cx
        add ebp, eax
        mov eax, ebx
        call LineSlotsPtr
        movsx edx, ax
        cmp ebp, edx
        jb short .24
        cmp ax, word [byte esp+08h]
        jle short .23
        mov word [byte esp+0Ch], cx
        mov dword [byte esp+08h], eax
.23:
        inc edi
        mov ecx, 0FFFFFFFFh
        cmp di, byte 4
        jl short .20
.24:
        test cx, cx
        jge short .25
        mov ecx, dword [byte esp+0Ch]
.25:
        cmp cx, word [byte ebx+02h]
        setne al
        xor ah, ah
        mov edx, eax
        test ax, ax
        je short .26
        mov al, byte [dword ebx+0A7h]
        mov word [byte ebx+02h], cx
        cmp al, 1
        jne short .26
        cmp cx, byte 2
        jne short .26
        xor byte [dword ebx+0A6h], 80h
.26:
        test dx, dx
        jne short .27
        test byte [gmode], 1
        je near .37
.27:
        mov ax, word [byte ebx+04h]
        mov word [byte esp+04h], ax
        mov ecx, eax
        mov eax, dword [byte esp+02h]
        mov edx, dword [dword ebx+0108h]
        sar eax, 10h
        add edx, 20F9h
        add eax, eax
        add eax, edx
        xor edx, edx
        mov dl, byte [eax]
        inc eax
        mov dx, word [byte ebx+edx*2+018h]
        mov al, byte [eax]
        and eax, 0FFh
        add dx, word [byte ebx+eax*2+018h]
        movsx edx, dx
        mov eax, edx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov dh, byte [gmode]
        mov edi, eax
        test dh, 1
        je short .28
        mov eax, 190h
        jmp short .29
.28:
        xor eax, eax
.29:
        mov edx, dword [dword ebx+0A8h]
        add edx, eax
        movsx eax, di
        cmp eax, edx
        jae near .37
        mov eax, dword [dword ebx+0108h]
        add eax, 20F9h
        xor esi, esi
        mov dword [esp], eax
.30:
        inc ecx
        cmp cx, byte 3
        jl short .31
        sub ecx, byte 3
.31:
        movsx eax, cx
        mov ebp, dword [esp]
        add eax, eax
        add eax, ebp
        xor edx, edx
        mov dl, byte [eax]
        inc eax
        mov dx, word [byte ebx+edx*2+018h]
        mov al, byte [eax]
        and eax, 0FFh
        add dx, word [byte ebx+eax*2+018h]
        movsx edx, dx
        mov eax, edx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        test byte [gmode], 1
        je short .32
        mov edx, 190h
        jmp short .33
.32:
        xor edx, edx
.33:
        add edx, dword [dword ebx+0A8h]
        movsx ebp, ax
        cmp edx, ebp
        jae short .34
        mov word [byte ebx+04h], cx
        jmp short .36
.34:
        cmp ax, di
        jle short .35
        mov word [byte esp+04h], cx
        mov edi, eax
.35:
        inc esi
        cmp si, byte 2
        jl short .30
.36:
        cmp si, byte 2
        jl short .37
        mov eax, dword [byte esp+04h]
        mov word [byte ebx+04h], ax
.37:
        and byte [dword ebx+0A6h], 0BFh
.38:
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetCoachMode                                 2E6D4  95 PC, medium confidence
; Sets a team's coach AI mode (team D2h..D6h fields)
;-----------------------------------------------------------------------------
SetCoachMode:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edx, eax
        mov bx, word [awtmstruct]
        mov ax, word [hmtmstruct]
        sub eax, ebx
        test dx, dx
        jne short .3
        mov dl, byte [HmCoachGoalie]
        movsx ebx, ax
        and dl, 0FEh
        cmp ebx, byte 0FFFFFFFFh
        jge short .1
        mov byte [HmCoachGoalie], dl
        mov byte [HmCoachLines], 5
        jmp near .6
.1:
        cmp ax, 3
        jle short .2
        mov al, 4
        mov edi, 0D9Ah
        mov byte [HmCoachGoalie], dl
        mov dl, 2
        mov byte [HmCoachLines], al
        mov dword [HmCoachTimer], edi
        mov ah, 3
        mov byte [HmCoachDefense], dl
        mov byte [HmCoachOffense], ah
        jmp near .6
.2:
        mov esi, 0CCCh
        xor ch, ch
        mov byte [HmCoachGoalie], dl
        mov byte [HmCoachLines], ch
        mov dword [HmCoachTimer], esi
        jmp short .6
.3:
        mov dl, byte [AwCoachGoalie]
        or dl, 1
        cmp ax, 1
        jle short .4
        mov cl, 8
        mov byte [AwCoachGoalie], dl
        mov byte [AwCoachLines], cl
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        cwde
        cmp eax, byte 0FFFFFFFDh
        jge short .5
        mov dh, 3
        mov bl, 2
        mov ecx, 0D9Ah
        mov byte [AwCoachOffense], dh
        mov byte [AwCoachDefense], bl
        mov byte [AwCoachGoalie], dl
        mov bh, 1
        mov dword [AwCoachTimer], ecx
        mov byte [AwCoachLines], bh
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov ah, 1
        mov ebx, 0CCCh
        mov byte [AwCoachGoalie], dl
        mov byte [AwCoachLines], ah
        mov dword [AwCoachTimer], ebx
.6:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ResetCoachModes                                 2E7D8  97 PC, low confidence
; Sets the coach modes of both teams to their defaults for the game type
;-----------------------------------------------------------------------------
ResetCoachModes:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edx, awtmstruct
        mov ch, 3
        xor ah, ah
        mov ebx, hmtmstruct
        mov byte [AwCoachGoalie], ah
        mov byte [HmCoachGoalie], ah
        mov byte [AwCoachOffense], ch
        mov byte [HmCoachOffense], ch
        mov ah, 2
        mov cx, word [gsp]
        mov byte [AwCoachDefense], ah
        mov byte [HmCoachDefense], ah
        cmp cx, byte 2
        jle short .1
        mov edi, 0D9Ah
        mov cl, 1
        mov byte [HmCoachLines], ah
        mov dword [AwCoachTimer], edi
        xor al, al
        mov byte [AwCoachGoalie], cl
        mov byte [HmCoachGoalie], al
        mov ah, 8
        mov dword [HmCoachTimer], edi
        mov byte [AwCoachLines], ah
        jmp short .3
.1:
        jne short .2
        xor eax, eax
        call SetCoachMode
        mov eax, 1
        call SetCoachMode
        jmp short .3
.2:
        mov ecx, 0CCCh
        mov esi, 0CCCh
        mov ah, 1
        mov dword [HmCoachTimer], ecx
        xor ch, ch
        mov dword [AwCoachTimer], esi
        mov byte [HmCoachLines], ch
        mov byte [HmCoachGoalie], ch
        mov cl, 81h
        mov byte [AwCoachLines], ah
        mov byte [AwCoachGoalie], cl
.3:
        mov word [byte edx+02h], 0
        mov ax, word [byte edx+02h]
        mov word [byte ebx+02h], ax
        mov word [byte edx+04h], 0
        mov ax, word [byte edx+04h]
        mov word [byte ebx+04h], ax
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 0C0h
        je short .5
        cmp word [gsp], byte 0
        jle short .5
        cmp word [AwayGoalieOff], byte 0
        je short .4
        mov eax, dword [byte eax+01h]
        and eax, 0C0h
        cmp eax, 80h
        jne short .5
.4:
        mov word [byte edx+02h], 3
.5:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; UpdateCoachModes                             2E8F0  95 PC, medium confidence
; coach AI, once a second from ClockTick. Picks each team's mode (team D2h..D6h) from the
; score difference, time left and penalties (details not traced).
;-----------------------------------------------------------------------------
UpdateCoachModes:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov bx, word [awtmstruct]
        mov dx, word [hmtmstruct]
        mov cx, word [gsp]
        sub edx, ebx
        cmp cx, byte 1
        jne near .6
        cmp word [gameclock], 258h
        jg near .6
        xor eax, eax
        mov bl, byte [HmCoachLines]
        call SetCoachMode
        mov ecx, dword [HmCoachOffense]
        xor eax, eax
        sar ecx, 18h
        mov al, bl
        cmp ecx, eax
        je short .1
        or byte [HmCoachGoalie], 40h
.1:
        mov eax, 1
        mov cl, byte [AwCoachLines]
        call SetCoachMode
        mov ebx, dword [AwCoachOffense]
        xor eax, eax
        sar ebx, 18h
        mov al, cl
        cmp ebx, eax
        je short .2
        or byte [AwCoachGoalie], 40h
.2:
        cmp word [gameclock], 258h
        jne near .26
        movsx eax, dx
        cmp eax, byte 0FFFFFFFFh
        jge short .4
        mov ah, byte [HmCoachOffense]
        cmp ah, 4
        jae short .3
        mov bl, ah
        inc bl
        mov byte [HmCoachOffense], bl
.3:
        mov bh, byte [HmCoachDefense]
        cmp bh, 1
        jbe short .4
        mov cl, bh
        dec cl
        mov byte [HmCoachDefense], cl
.4:
        cmp dx, byte 1
        jle near .26
        mov ch, byte [AwCoachOffense]
        cmp ch, 4
        jae short .5
        mov al, ch
        inc al
        mov byte [AwCoachOffense], al
.5:
        mov ah, byte [AwCoachDefense]
        cmp ah, 1
        jbe near .26
        mov dl, ah
        dec dl
        mov byte [AwCoachDefense], dl
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        cmp word [gsp], byte 2
        jl near .26
        mov ax, word [gameclock]
        mov cl, byte [HmCoachLines]
        cmp ax, 3Ch
        jg short .7
        movsx eax, dx
        cmp eax, byte 0FFFFFFFFh
        jg short .7
        mov bl, 6
        mov ch, 1
        mov ah, byte [HmCoachGoalie]
        mov esi, 0B33h
        or ah, 1
        mov byte [HmCoachLines], bl
        mov byte [HmCoachDefense], ch
        mov dword [HmCoachTimer], esi
        mov bh, 4
        mov byte [HmCoachGoalie], ah
        mov byte [HmCoachOffense], bh
        jmp near .15
.7:
        cmp word [gameclock], byte 78h
        jg short .8
        cmp dx, byte 1
        jge short .8
        mov ebx, 0B33h
        mov ch, 4
        mov dword [HmCoachTimer], ebx
        mov bl, byte [HmCoachGoalie]
        mov al, 1
        or bl, 1
        mov byte [HmCoachOffense], ch
        mov byte [HmCoachGoalie], bl
        mov bh, 6
        mov byte [HmCoachDefense], al
        mov byte [HmCoachLines], bh
        jmp near .15
.8:
        cmp word [gameclock], 0B4h
        jg short .9
        movsx eax, dx
        cmp eax, byte 0FFFFFFFFh
        jg short .9
        mov eax, 0B33h
        mov ch, 7
        mov bh, byte [HmCoachGoalie]
        mov dword [HmCoachTimer], eax
        or bh, 1
        mov al, 4
        mov byte [HmCoachLines], ch
        mov byte [HmCoachOffense], al
        mov ah, 1
        mov byte [HmCoachGoalie], bh
        mov byte [HmCoachDefense], ah
        jmp near .15
.9:
        cmp word [gameclock], 12Ch
        jg short .10
        movsx eax, dx
        cmp eax, byte 0FFFFFFFFh
        jge short .10
        mov al, 7
        mov bl, 1
        mov ch, byte [HmCoachGoalie]
        mov ebp, 0B33h
        or ch, 1
        mov byte [HmCoachLines], al
        mov byte [HmCoachDefense], bl
        mov dword [HmCoachTimer], ebp
        mov ah, 4
        mov byte [HmCoachGoalie], ch
        mov byte [HmCoachOffense], ah
        jmp near .15
.10:
        cmp word [gameclock], 258h
        jg near .14
        movsx eax, dx
        cmp eax, byte 0FFFFFFFFh
        jge short .11
        mov bl, 4
        mov al, byte [HmCoachGoalie]
        mov edi, 0B33h
        or al, 1
        mov byte [HmCoachOffense], bl
        mov dword [HmCoachTimer], edi
        mov bh, 1
        mov byte [HmCoachGoalie], al
        mov ah, 0Ah
        mov byte [HmCoachDefense], bh
        mov byte [HmCoachLines], ah
        jmp short .15
.11:
        cmp dx, byte 2
        jle short .12
        mov dword [HmCoachTimer], 0CCCh
        jmp short .13
.12:
        mov dword [HmCoachTimer], 0D9Ah
.13:
        mov bl, 3
        mov ah, byte [HmCoachGoalie]
        mov ch, 2
        and ah, 0FEh
        mov byte [HmCoachLines], bl
        mov byte [HmCoachOffense], bl
        mov byte [HmCoachDefense], ch
        mov byte [HmCoachGoalie], ah
        jmp short .15
.14:
        xor eax, eax
        call SetCoachMode
.15:
        xor eax, eax
        mov ebx, dword [HmCoachOffense]
        mov al, cl
        sar ebx, 18h
        cmp ebx, eax
        je short .16
        or byte [HmCoachGoalie], 40h
.16:
        mov cx, word [gameclock]
        mov bl, byte [AwCoachLines]
        cmp cx, byte 3Ch
        jg short .17
        cmp dx, byte 1
        jl short .17
        mov dl, 6
        mov bh, 1
        mov ah, byte [AwCoachGoalie]
        mov edi, 0B33h
        or ah, 1
        mov byte [AwCoachLines], dl
        mov byte [AwCoachDefense], bh
        mov dword [AwCoachTimer], edi
        mov dh, 4
        mov byte [AwCoachGoalie], ah
        mov byte [AwCoachOffense], dh
        jmp near .25
.17:
        cmp word [gameclock], byte 78h
        jg short .18
        cmp dx, byte 1
        jle short .18
        mov cl, 6
        mov al, 1
        mov bh, byte [AwCoachGoalie]
        mov esi, 0B33h
        or bh, 1
        mov byte [AwCoachLines], cl
        mov byte [AwCoachDefense], al
        mov dword [AwCoachTimer], esi
        mov ch, 4
        mov byte [AwCoachGoalie], bh
        mov byte [AwCoachOffense], ch
        jmp near .25
.18:
        cmp word [gameclock], 0B4h
        jg short .19
        cmp dx, byte 1
        jle short .19
        mov dl, 4
        mov al, byte [AwCoachGoalie]
        mov ecx, 0B33h
        or al, 1
        mov byte [AwCoachOffense], dl
        mov dword [AwCoachTimer], ecx
        mov dh, 1
        mov byte [AwCoachGoalie], al
        mov ah, 7
        mov byte [AwCoachDefense], dh
        mov byte [AwCoachLines], ah
        jmp near .25
.19:
        cmp word [gameclock], 12Ch
        jg short .20
        cmp dx, byte 1
        jle short .20
        mov edx, 0B33h
        mov bh, 7
        mov cl, 4
        mov dword [AwCoachTimer], edx
        mov byte [AwCoachLines], bh
        mov byte [AwCoachOffense], cl
        mov dh, byte [AwCoachGoalie]
        mov ch, 1
        or dh, 1
        mov byte [AwCoachDefense], ch
        mov byte [AwCoachGoalie], dh
        jmp near .25
.20:
        cmp word [gameclock], 258h
        jg near .24
        cmp dx, byte 1
        jle short .21
        mov eax, 0B33h
        mov dl, 1
        mov ch, byte [AwCoachGoalie]
        mov dword [AwCoachTimer], eax
        or ch, 1
        mov al, 0Ah
        mov byte [AwCoachDefense], dl
        mov byte [AwCoachLines], al
        mov ah, 4
        mov byte [AwCoachGoalie], ch
        mov byte [AwCoachOffense], ah
        jmp short .25
.21:
        movsx eax, dx
        cmp eax, byte 0FFFFFFFEh
        jge short .22
        mov dl, 9
        mov ebp, 0CCCh
        mov byte [AwCoachLines], dl
        mov dword [AwCoachTimer], ebp
        jmp short .23
.22:
        mov ah, 8
        mov edi, 0D9Ah
        mov byte [AwCoachLines], ah
        mov dword [AwCoachTimer], edi
.23:
        mov bh, 3
        mov dh, byte [HmCoachGoalie]
        mov cl, 2
        or dh, 1
        mov byte [HmCoachOffense], bh
        mov byte [HmCoachDefense], cl
        mov byte [HmCoachGoalie], dh
        jmp short .25
.24:
        mov eax, 1
        call SetCoachMode
.25:
        mov eax, dword [AwCoachOffense]
        sar eax, 18h
        and ebx, 0FFh
        cmp eax, ebx
        je short .26
        or byte [AwCoachGoalie], 40h
.26:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; StartFaceoffLineChange                            2EDB8  94G, low confidence
; starts a team's faceoff line change (once per
; stoppage: team flag +16h bit 1) when line changes are on
;-----------------------------------------------------------------------------
StartFaceoffLineChange:
        push ebx
        push ecx
        push edx
        push esi
        mov edx, dword [GameOptionFlags]
        test byte [byte edx+01h], 0C0h
        je near .5
        mov edx, dword [dword eax+0FEh]
        mov bh, byte [byte edx+016h]
        test bh, 2
        jne near .5
        mov cl, bh
        or cl, 2
        mov byte [byte edx+016h], cl
        and byte [PuckFlags], 0F3h
        or byte [dword eax+0C0h], 8
        mov ecx, dword [dword eax+0102h]
        mov bh, byte [dword eax+0BFh]
        mov ecx, dword [byte ecx+0Ch]
        test bh, 40h
        setne bl
        sar ecx, 10h
        mov eax, dword [byte edx+0Ch]
        movzx esi, bl
        sar eax, 10h
        mov ebx, esi
        sub ecx, eax
        lea eax, [nosplit esi*2+00h]
        mov dx, word [byte edx+02h]
        mov word [dword eax+HomeSkaters], dx
        test ecx, ecx
        jle short .1
        cmp dx, byte 6
        jge short .4
        mov word [dword eax+HomeSkaters], 6
        jmp short .4
.1:
        test ecx, ecx
        jge short .3
        cmp dx, byte 4
        jl short .2
        cmp dx, byte 5
        jle short .4
.2:
        mov word [nosplit ebx*2+HomeSkaters], 4
        jmp short .4
.3:
        cmp dx, byte 4
        jl short .4
        xor ecx, ecx
        mov word [dword eax+HomeSkaters], cx
.4:
        mov eax, dword [nosplit ebx*2+FaceoffSlots]
        sar eax, 10h
        push eax
        push byte 0
        test ebx, ebx
        setne al
        and eax, 0FFh
        add eax, byte 9
        push eax
        call QueueOverlayPanel
        add esp, byte 0Ch
.5:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
        and byte [dword edx+0C0h], 0F7h
        mov eax, edx
        call StartFaceoffLineChange
        test byte [dword edx+0C0h], 8
        je short .7
        test byte [dword edx+0BFh], 40h
        je short .6
        mov word [FaceoffY], 168h
        mov dl, byte [dword edx+0A4h]
        xor dh, dh
        mov word [FaceoffDropY], dx
        ret
.6:
        mov word [FaceoffX], 258h
        mov dl, byte [dword edx+0A4h]
        xor dh, dh
        mov word [FaceoffDropX], dx
.7:
        ret
        db 08Bh,0C0h
