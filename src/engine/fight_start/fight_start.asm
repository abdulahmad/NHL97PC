; Fight starts: fight odds, starting fights and fight assignments.
bits 32
%include "hockey.inc"
section s_363EA progbits alloc exec nowrite align=1
extern __CHP, AddPenalty2, assexit, assinsert, AwPlayerEnergy, BreakawayFlag, CommentaryEvent, F32_144_assfwatch
extern F32_48_assfwatch, F64_0p159155_HumanStickAction, F64_0p392699_HumanStickAction, F64_1392_assfwatch, F64_153p6, F64_65536_HumanStickAction, FightCameraScene, gameopts
extern GameSettings, GiveControl, gmode, HmPlayerEnergy, IF@ATAN2, InputDir, InputState, JoyStateTable
extern PassPlayer, PickSkateAnim, PtrPuckFlags, puckc, PuckFlags, randomd0, regd1, SetCrowdMood
extern SetFightCameraReady, SetSkateSpeedFromRating, ShotPending, SortCords, StartFightAnim, StartFightBlock, StartFightGrab, StartFightPull
extern StartFightPunch, vecdist, ZoneTargetY
global CheckFightOdds, StartFight, checkfight, ResetPlayerCounters, HumanStickAction, assfight, assfwatch, assfwatch_1EC
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CheckFightOdds                                  363EC  97 PC, low confidence
; (player, other) from checkfight: both skaters on the ice, play live, enough
; hits (PassPlayer >= 50h): rolls the fight chance
;-----------------------------------------------------------------------------
CheckFightOdds:
        push ebx
        push ecx
        push esi
        push edi
        mov esi, eax
        cmp word [dword eax+0A9h], byte 0
        je near .3
        cmp word [dword edx+0A9h], byte 0
        je near .3
        mov ah, byte [gmode]
        test ah, 1
        jne near .3
        cmp word [BreakawayFlag], byte 0
        jne near .3
        test ah, 8
        jne near .3
        cmp byte [dword esi+0CEh], 0
        je near .3
        cmp byte [dword edx+0CEh], 0
        je near .3
        cmp word [PassPlayer], byte 50h
        jl near .3
        mov ebx, dword [ShotPending]
        mov eax, 0F0h
        sar ebx, 10h
        sub eax, ebx
        mov ebx, eax
        test eax, eax
        jge short .1
        xor ebx, eax
.1:
        sar ebx, 2
        add ebx, byte 0Ah
        xor ecx, ecx
        movsx eax, bx
        mov cl, byte [dword edx+0CEh]
        call randomd0
        cwde
        cmp eax, ecx
        jge short .2
        movsx eax, cx
        call randomd0
        test ax, ax
        je short .2
        mov eax, dword [dword edx+0A3h]
        mov edi, dword [dword edx+0FEh]
        sar eax, 18h
        mov al, byte [dword edi+eax+0D0h]
        and eax, 0FFh
        call randomd0
        cwde
        cmp eax, ecx
        jge short .2
        mov eax, 2
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        xor ecx, ecx
        movsx eax, bx
        mov cl, byte [dword esi+0CEh]
        call randomd0
        cwde
        cmp eax, ecx
        jge short .3
        movsx eax, cx
        call randomd0
        test ax, ax
        je short .3
        mov eax, dword [dword edx+0A3h]
        mov ebx, dword [dword edx+0FEh]
        sar eax, 18h
        mov al, byte [dword ebx+eax+0D0h]
        and eax, 0FFh
        call randomd0
        cwde
        cmp eax, ecx
        jge short .3
        mov eax, 1
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.3:
        xor eax, eax
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; StartFight                                   36524  97 PC, medium confidence
; (player, other): marks both fighters, gives each a fighting penalty
; (AddPenalty2 1Ch) and assfight (1Ch), user control, commentary
;-----------------------------------------------------------------------------
StartFight:
        push ecx
        push esi
        mov esi, eax
        mov ecx, edx
        mov ah, byte [dword eax+0C0h]
        or ah, 1
        mov byte [dword esi+0C0h], ah
        mov dl, byte [dword edx+0C0h]
        or dl, 1
        mov byte [dword ecx+0C0h], dl
        mov eax, dword [PtrPuckFlags]
        or byte [dword eax+0C0h], 1
        mov al, byte [dword ecx+0A4h]
        mov byte [byte esi+06Ch], al
        mov ebx, 4
        mov al, byte [dword esi+0A4h]
        mov edx, 1Ch
        mov byte [byte ecx+06Ch], al
        mov eax, esi
        call AddPenalty2
        mov ebx, 4
        mov edx, 1Ch
        mov eax, ecx
        call AddPenalty2
        mov edx, 1Ch
        mov eax, esi
        call assinsert
        mov edx, 1Ch
        mov eax, ecx
        call assinsert
        xor eax, eax
        mov al, byte [dword esi+0A4h]
        call GiveControl
        xor eax, eax
        mov al, byte [dword ecx+0A4h]
        call GiveControl
        mov eax, esi
        call StartFightAnim
        mov eax, ecx
        call StartFightAnim
        mov eax, dword [PtrPuckFlags]
        push dword 0A000001Dh
        xor edx, edx
        mov dword [byte eax+05Ah], 3E8h
        call CommentaryEvent
        add esp, byte 4
        xor eax, eax
        mov dl, byte [dword ecx+0A4h]
        mov al, byte [dword esi+0A4h]
        call FightCameraScene
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; checkfight                                     365FC  93G, medium confidence
; (player a3, player a2) after a hit, with fighting on in the options: counts the hits
; and may start a fight (StartFight); the others get assfwatch (1Dh)
;-----------------------------------------------------------------------------
checkfight:
        push ebx
        push ecx
        push esi
        push edi
        mov ecx, eax
        mov esi, edx
        mov dx, word [PassPlayer]
        xor ebx, ebx
        cmp dx, 3E8h
        jge near .3
        test dx, dx
        jl near .7
        mov eax, dword [gameopts]
        test byte [byte eax+02h], 4
        je near .7
        cmp byte [dword ecx+0A4h], 0Ch
        jae near .7
        cmp byte [dword esi+0A4h], 0Ch
        jae near .7
        mov ebx, dword [dword esi+0A3h]
        mov eax, dword [dword esi+0FEh]
        sar ebx, 18h
        inc byte [dword ebx+eax+0D0h]
        mov di, word [PassPlayer]
        inc edi
        mov ax, word [PassPlayer]
        mov word [PassPlayer], di
        mov dx, word [dword esi+0A9h]
        add eax, 2
        test dx, dx
        je short .1
        cmp byte [dword esi+0CEh], 0
        jne short .2
.1:
        mov word [PassPlayer], ax
.2:
        mov edx, esi
        mov eax, ecx
        call CheckFightOdds
        mov ebx, eax
        test ax, ax
        jle near .7
.3:
        test byte [gmode], 1
        jne near .7
        cmp word [BreakawayFlag], byte 0
        jne near .7
        and byte [PuckFlags], 0F3h
        mov eax, dword [puckc]
        mov byte [eax], 0FFh
        mov edx, 40h
        mov eax, dword [PtrPuckFlags]
        call assinsert
        mov eax, 9
        movsx ebx, bx
        call SetCrowdMood
        mov edx, esi
        mov eax, ecx
        call StartFight
        mov ecx, SortCords
        xor ebx, ebx
        xor esi, esi
.4:
        test byte [dword ecx+0C0h], 1
        jne short .6
        mov dx, word [dword ecx+0A9h]
        cmp si, dx
        jl short .5
        jne short .6
.5:
        test byte [dword ecx+0C0h], 4
        jne short .6
        mov edx, 1Dh
        mov eax, ecx
        call assinsert
.6:
        inc ebx
        add ecx, 108h
        cmp bx, byte 0Ch
        jl short .4
        mov word [PassPlayer], 0FFFFh
        mov eax, 1
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.7:
        xor eax, eax
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ResetPlayerCounters                             36754  97 PC, low confidence
; From StartGame: clears the per-player bytes HmPlayerEnergy / AwPlayerEnergy and
; PassPlayer
;-----------------------------------------------------------------------------
ResetPlayerCounters:
        push edx
        xor edx, edx
        xor eax, eax
        mov word [PassPlayer], dx
.1:
        inc eax
        xor dl, dl
        mov byte [dword eax+HmPlayerEnergy], dl
        mov byte [dword eax+AwPlayerEnergy], dl
        cmp eax, byte 1Ch
        jl short .1
        pop edx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; HumanStickAction                                36778  97 PC, low confidence
; From doinput: the controlled player's stick / check move against his target
; (puck flag, partner object +6Ch)
;-----------------------------------------------------------------------------
HumanStickAction:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov esi, edx
        mov eax, dword [PtrPuckFlags]
        mov dl, byte [dword eax+0C0h]
        xor ecx, ecx
        test dl, 1
        je near .20
        xor edx, edx
        mov dl, byte [byte ebx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edx, SortCords
        shl eax, 3
        add edx, eax
        mov eax, dword [byte edx+04h]
        sar eax, 10h
        mov dword [esp], eax
        mov eax, dword [byte ebx+04h]
        mov edi, dword [esp]
        sar eax, 10h
        sub edi, eax
        mov eax, dword [byte edx+0Ch]
        sar eax, 10h
        mov dword [esp], edi
        mov dword [byte esp+04h], eax
        mov eax, dword [byte ebx+0Ch]
        mov edi, dword [byte esp+04h]
        sar eax, 10h
        sub edi, eax
        mov dword [byte esp+04h], edi
        fild dword [byte esp+04h]
        fild dword [esp]
        call IF@ATAN2
        fst dword [byte esp+0Ch]
        fadd qword [F64_0p392699_HumanStickAction]
        fmul qword [F64_0p159155_HumanStickAction]
        fmul qword [F64_65536_HumanStickAction]
        call __CHP
        fistp dword [byte esp+08h]
        mov edi, dword [byte esp+08h]
        and edi, 0E000h
        mov eax, edi
        mov dword [byte esp+08h], edi
        sar eax, 0Dh
        mov dword [byte esp+08h], eax
        test eax, eax
        jge short .1
        add eax, byte 8
        mov dword [byte esp+08h], eax
.1:
        mov eax, dword [dword ebx+0F6h]
        shl esi, 4
        mov eax, dword [eax]
        add esi, JoyStateTable
        mov eax, dword [byte eax+028h]
        mov edi, dword [byte esi+0Ch]
        and eax, 0FFFFh
        cmp edi, byte 4
        jne short .2
        mov edi, dword [byte esp+08h]
        mov esi, dword [byte esi+04h]
        sub esi, edi
        inc esi
        and esi, byte 7
        cmp esi, byte 2
        jg short .2
        mov ecx, 1
.2:
        cmp eax, 161h
        je short .3
        cmp eax, 16Bh
        jne near .7
.3:
        mov esi, dword [dword ebx+0FAh]
        test byte [byte esi+030h], 2
        je near .20
        test ecx, ecx
        je short .4
        cmp eax, 161h
        jne short .4
        test byte [byte esi+030h], 4
        jne short .4
        cmp dword [byte edx+056h], byte 5
        jge near .20
        mov eax, ebx
        call StartFightGrab
        jmp near .20
.4:
        mov eax, dword [byte esp+08h]
        mov edi, dword [InputDir]
        xor al, 4
        cmp eax, edi
        jne short .5
        mov eax, edx
        call StartFightPull
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.5:
        mov al, byte [InputState]
        test al, 10h
        je short .6
        mov eax, ebx
        call StartFightPunch
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.6:
        test al, 20h
        je near .20
        mov eax, ebx
        call StartFightBlock
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.7:
        cmp eax, 162h
        jne near .12
        cmp dword [byte ebx+05Ah], byte 0
        jl short .8
        mov eax, ebx
        call StartFightPull
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.8:
        mov eax, dword [byte esp+08h]
        mov esi, dword [InputDir]
        xor al, 4
        cmp eax, esi
        jne short .11
        mov ecx, dword [byte edx+056h]
        cmp ecx, dword [byte ebx+056h]
        jle short .9
        mov eax, 64h
        call randomd0
        cwde
        cmp eax, dword [byte ebx+056h]
        jge short .10
.9:
        mov eax, ebx
        call StartFightPull
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.10:
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+0Ch]
        mov dword [byte eax+024h], 437A0000h
        fchs
        mov eax, dword [dword ebx+0EEh]
        fstp dword [byte eax+0Ch]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.11:
        mov edi, dword [byte esp+08h]
        mov eax, esi
        sub eax, edi
        inc eax
        and eax, byte 7
        cmp eax, byte 2
        jg near .20
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 437A0000h
        mov eax, dword [dword ebx+0EEh]
        mov edx, dword [byte esp+0Ch]
        mov dword [byte eax+0Ch], edx
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.12:
        cmp eax, 158h
        je short .13
        cmp eax, 169h
        je short .13
        cmp eax, 16Ah
        jne near .19
.13:
        mov dword [byte ebx+05Ah], 0
        test ecx, ecx
        je short .14
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+05Ah], 3E8h
        mov eax, ebx
        call StartFightGrab
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.14:
        mov edx, dword [byte esp+08h]
        mov eax, dword [InputDir]
        sub eax, edx
        lea edx, [byte eax+02h]
        and edx, byte 7
        cmp edx, byte 5
        jl short .15
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+0Ch]
        mov dword [byte eax+024h], 437A0000h
        fchs
        mov eax, dword [dword ebx+0EEh]
        fstp dword [byte eax+0Ch]
        jmp short .17
.15:
        inc eax
        and eax, byte 7
        cmp eax, byte 2
        jg short .16
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 437A0000h
        mov eax, dword [dword ebx+0EEh]
        mov edx, dword [byte esp+0Ch]
        mov dword [byte eax+0Ch], edx
        jmp short .17
.16:
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], ecx
.17:
        mov dh, byte [InputState]
        test dh, 10h
        je short .18
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+05Ah], 3E8h
        mov eax, ebx
        call StartFightPunch
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.18:
        test dh, 20h
        je short .20
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+05Ah], 3E8h
        mov eax, ebx
        call StartFightBlock
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.19:
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 0
.20:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; assfight                                       36AB0  93G, medium confidence
; assignment 1Ch (StartFight gives it to both fighters),
; the fighting logic
;-----------------------------------------------------------------------------
assfight:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov edx, dword [byte eax+05Ah]
        test edx, edx
        jle short .1
        lea edi, [byte edx-01h]
        mov dword [byte eax+05Ah], edi
        jmp short .2
.1:
        jge short .2
        lea esi, [byte edx+01h]
        mov dword [byte eax+05Ah], esi
.2:
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [byte eax+05Ah]
        dec edx
        mov dword [byte eax+05Ah], edx
        test edx, edx
        jg short .3
        mov eax, dword [PtrPuckFlags]
        and byte [dword eax+0C0h], 0FEh
.3:
        mov eax, dword [dword ebx+0EEh]
        or byte [byte eax+029h], 1
        xor edx, edx
        mov dl, byte [byte ebx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov esi, SortCords
        shl eax, 3
        add esi, eax
        mov edx, dword [byte esi+04h]
        mov eax, dword [byte ebx+04h]
        sar edx, 10h
        sar eax, 10h
        sub edx, eax
        mov dword [esp], edx
        mov eax, dword [byte ebx+0Ch]
        mov edx, dword [byte esi+0Ch]
        sar eax, 10h
        sar edx, 10h
        sub edx, eax
        mov dword [byte esp+04h], edx
        fild dword [byte esp+04h]
        fild dword [esp]
        call IF@ATAN2
        push edx
        mov eax, dword [byte esp+04h]
        push eax
        fstp dword [byte esp+010h]
        call vecdist
        add esp, byte 8
        mov dword [byte esp+0Ch], eax
        mov eax, dword [dword ebx+0F6h]
        mov eax, dword [eax]
        mov ecx, dword [dword ebx+0FAh]
        mov eax, dword [byte eax+028h]
        mov dl, byte [dword ebx+0BFh]
        and eax, 0FFFFh
        test dl, 2
        je short .5
        mov dh, dl
        and dh, 0FDh
        mov byte [dword ebx+0BFh], dh
        mov edx, dword [dword ebx+0A3h]
        sar edx, 18h
        mov edi, dword [dword ebx+0FEh]
        add edx, edx
        add edx, edi
        mov edx, dword [byte edx+016h]
        movzx edi, byte [dword ebx+0CEh]
        sar edx, 10h
        imul edx, edi
        sar edx, 0Ah
        cmp edx, byte 0Ah
        jge short .4
        mov edx, 0Ah
.4:
        mov dword [byte ebx+05Ah], 0
        mov dword [byte ebx+056h], edx
.5:
        mov edx, dword [PtrPuckFlags]
        test byte [dword edx+0C0h], 1
        je short .6
        mov edx, dword [dword ebx+0EEh]
        test byte [byte edx+031h], 1
        je short .7
.6:
        mov eax, dword [PtrPuckFlags]
        and byte [dword eax+0C0h], 0FEh
        test byte [dword ebx+0BFh], 20h
        jne near .25
        mov cl, byte [dword ebx+0C0h]
        and cl, 0FEh
        mov eax, ebx
        mov byte [dword ebx+0C0h], cl
        call assexit
        mov eax, ebx
        call PickSkateAnim
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+028h], 0
        test byte [dword esi+0C0h], 1
        je near .25
        push dword 0A000001Eh
        call CommentaryEvent
        add esp, byte 4
        call SetFightCameraReady
        jmp near .25
.7:
        test byte [dword ebx+0BFh], 8
        jne near .25
        cmp eax, 161h
        je short .8
        cmp eax, 16Bh
        jne near .12
.8:
        cmp dword [byte ebx+056h], byte 5
        jge short .9
        cmp eax, 161h
        jne short .9
        test byte [byte ecx+030h], 2
        je short .9
        mov eax, dword [dword ebx+0FAh]
        test byte [byte eax+030h], 4
        jne short .9
        mov eax, ebx
        call StartFightGrab
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        test byte [byte ecx+030h], 2
        je short .10
        mov eax, 64h
        call randomd0
        cmp ax, 3Ch
        jl short .11
.10:
        test byte [byte ecx+030h], 4
        je near .25
.11:
        mov eax, 2
        call randomd0
        test ax, ax
        jne near .22
        mov eax, ebx
        call StartFightBlock
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.12:
        cmp eax, 162h
        je short .13
        cmp eax, 16Ch
        jne short .16
.13:
        mov edx, dword [dword ebx+0EEh]
        mov dword [byte edx+024h], 0
        cmp eax, 162h
        jne short .14
        mov edx, dword [byte esi+056h]
        cmp edx, dword [byte ebx+056h]
        jg short .14
        mov eax, 64h
        call randomd0
        cwde
        cmp eax, dword [byte ebx+056h]
        jl short .15
.14:
        cmp dword [byte ebx+05Ah], byte 0
        jl near .25
.15:
        mov eax, ebx
        call StartFightPull
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.16:
        cmp eax, 158h
        je short .17
        cmp eax, 169h
        je short .17
        cmp eax, 16Ah
        jne near .25
.17:
        fild dword [byte esp+0Ch]
        mov dword [byte ebx+05Ah], 0
        fcomp qword [F64_153p6]
        fnstsw ax
        sahf
        jbe near .24
        cmp dword [byte esp+0Ch], 108h
        jl short .18
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 437A0000h
        mov eax, dword [dword ebx+0EEh]
        mov edx, dword [byte esp+08h]
        mov dword [byte eax+0Ch], edx
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.18:
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 0
        mov eax, dword [GameSettings]
        and eax, 180h
        mov edx, 64h
        cmp eax, 80h
        jne short .19
        mov edx, 50h
        jmp short .20
.19:
        cmp eax, 100h
        jne short .20
        mov edx, 3Ch
.20:
        xor eax, eax
        mov al, byte [dword ebx+0CEh]
        sub edx, eax
        movsx eax, dx
        call randomd0
        movsx edx, ax
        cmp edx, byte 0Ah
        jge short .21
        mov eax, ebx
        call StartFightGrab
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.21:
        cmp edx, byte 1Eh
        jge short .23
.22:
        mov eax, ebx
        call StartFightPunch
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.23:
        cmp edx, byte 28h
        jge short .24
        mov eax, ebx
        call StartFightBlock
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.24:
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte esp+08h]
        mov dword [byte eax+024h], 437A0000h
        fchs
        mov eax, dword [dword ebx+0EEh]
        fstp dword [byte eax+0Ch]
.25:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; assfwatch                                      36E34  93G, medium confidence
; assignment 1Dh (checkfight gives it to the others),
; players watching the fight
;-----------------------------------------------------------------------------
assfwatch:
        push ebx
        push edx
        sub esp, byte 18h
        mov edx, eax
        test byte [dword eax+0BFh], 20h
        jne near .13
        mov bl, byte [dword edx+0BFh]
        test bl, 2
        je near .7
        mov bh, bl
        and bh, 0FDh
        mov byte [dword edx+0BFh], bh
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+028h]
        fabs
        fcomp qword [F64_1392_assfwatch]
        fnstsw ax
        sahf
        jbe short .3
        mov word [ZoneTargetY], 0F868h
        test byte [dword edx+0BFh], 40h
        jne short .1
        mov eax, 0FFFFFD48h
        jmp short .2
.1:
        mov eax, 2B8h
.2:
        mov word [regd1], ax
        mov eax, 5
        mov ebx, 2
        call randomd0
        sub ebx, eax
        imul eax, ebx, dword 90h
        add word [regd1], ax
        jmp short .6
.3:
        mov ax, word [byte edx+06h]
        mov word [ZoneTargetY], ax
        test byte [dword edx+0BFh], 80h
        je short .4
        mov eax, 0FFFFF910h
        jmp short .5
.4:
        mov eax, 6F0h
.5:
        mov word [regd1], ax
        mov eax, 64h
        call randomd0
        mov bx, word [regd1]
        sub eax, byte 32h
        add ebx, eax
        mov word [regd1], bx
.6:
        mov eax, dword [dword edx+0EEh]
        fild word [ZoneTargetY]
        fstp dword [eax]
        mov eax, dword [dword edx+0EEh]
        fild word [regd1]
        fstp dword [byte eax+04h]
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+024h], 42C80000h
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+018h], 0
        mov eax, edx
        call SetSkateSpeedFromRating
        mov eax, dword [dword edx+0EEh]
        and byte [byte eax+028h], 7Fh
        and byte [dword edx+0C1h], 0EFh
.7:
        test byte [dword edx+0C1h], 10h
        jne near .12
        fild word [byte edx+06h]
        fstp dword [byte esp+0Ch]
        mov eax, dword [dword edx+0EEh]
        fld dword [byte esp+0Ch]
        fsub dword [eax]
        fldz
        fxch
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        jbe short .8
        fld dword [byte esp+010h]
        fchs
        fstp dword [byte esp+04h]
        jmp short .9
.8:
        mov eax, dword [byte esp+010h]
        mov dword [byte esp+04h], eax
.9:
        fld dword [byte esp+04h]
        fcomp dword [F32_144_assfwatch]
        fnstsw ax
        sahf
        ja short .13
        fild word [byte edx+0Eh]
        fstp dword [esp]
        mov eax, dword [dword edx+0EEh]
        fld dword [esp]
        fsub dword [byte eax+04h]
        fldz
        fxch
        fstp dword [byte esp+014h]
        fcomp dword [byte esp+014h]
        fnstsw ax
        sahf
        jbe short .10
        fld dword [byte esp+014h]
        fchs
        fstp dword [byte esp+08h]
        jmp short .11
.10:
        mov eax, dword [byte esp+014h]
        mov dword [byte esp+08h], eax
.11:
        fld dword [byte esp+08h]
        fcomp dword [F32_48_assfwatch]
        fnstsw ax
        sahf
        ja short .13
        or byte [dword edx+0C1h], 10h
        jmp short .13
.12:
        mov eax, dword [dword edx+0EEh]
        mov dword [byte eax+010h], 0
.13:
        add esp, byte 18h
        pop edx
        pop ebx
        ret
        db 00h,00h,00h,00h
assfwatch_1EC:
        xor eax, eax
        ret
        db 090h
        push ebx
        mov edx, dword [byte esp+010h]
        mov eax, edx
        mov ebx, dword [byte esp+08h]
        not eax
        mov ecx, dword [byte esp+0Ch]
        and eax, ebx
        or eax, ecx
        cmp eax, ebx
        jae short .14
        inc edx
        add eax, edx
.14:
        pop ebx
        ret
