; Assignments: replace, insert and exit, poke checks, bench checks, position swaps and coverage.
bits 32
%include "hockey.inc"
section s_1E207 progbits alloc exec nowrite align=1
extern __CHP, AIBodyCheck, AngleOfVector, BenchRequest, doplayeracc, F32_10_CanReachPuck, F32_1392, F32_24
extern F32_4272, F32_neg1392, F32_neg4272, F64_0p159155_ChkPokeOrCheck, F64_0p392699_ChkPokeOrCheck, F64_65536_ChkPokeOrCheck, F64_768, FaceoffRequest
extern FaceoffTakers, FindManToCover, gameclock, GameOptionFlags, GameSettings, gmode, hypot_, PassPending
extern PassPlayer, PlayerAssignOrder, PlayerAssignPtrs, PlayFlags, PokeCheckAnim, PtrPuckFlags, PtrPuckObject, PtrPuckOwner
extern PtrPuckTarget, PtrPuckZone, randomd0, regd1, SetSkateSpeedFromRating, SortCords, StatsPanelOn, StatsPanelPlayer
extern StickReach, vtoa, ZoneFlags, ZoneTargetX, ZoneTargetY
global assreplace, assinsert, assexit, AimAtPuckTarget, SetZoneFlags, CanReachPuck, TryPokePuck, RandomPokeCheck
global ChkPokeOrCheck, check4bench, SwapPosition, SwapPositionJumpTable, ChkForwardSwap, GetDefensePartner, ChkSwapWithPartner, asscoverdefd
global asscoverdefo, Setplass
        db 090h
;-----------------------------------------------------------------------------
; assreplace                                                        1E208  94G
; (player, assignment) replaces the current assignment (+0B2h
; list at index +0B1h) and sets the new-assignment flag (+0BFh bit 1)
;-----------------------------------------------------------------------------
assreplace:
        push ebx
        mov ebx, dword [dword eax+0AEh]
        sar ebx, 18h
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword eax+0BFh], 2
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; assinsert                                      1E224  94G, medium confidence
; (player, assignment) pushes a new assignment (index - 1)
; unless it is already the current one, then as assreplace
;-----------------------------------------------------------------------------
assinsert:
        push ebx
        mov ebx, dword [dword eax+0AEh]
        sar ebx, 18h
        movsx bx, byte [dword ebx+eax+0B2h]
        cmp dx, bx
        je short .1
        mov bl, byte [dword eax+0B1h]
        dec bl
        and bl, 7
        mov byte [dword eax+0B1h], bl
.1:
        mov ebx, dword [dword eax+0AEh]
        sar ebx, 18h
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword eax+0BFh], 2
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; assexit                                                           1E268  94G
; ends the current assignment (index + 1) and sets the
; new-assignment flag
;-----------------------------------------------------------------------------
assexit:
        push edx
        mov dl, byte [dword eax+0B1h]
        inc dl
        and dl, 7
        mov byte [dword eax+0B1h], dl
        or byte [dword eax+0BFh], 2
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; AimAtPuckTarget                                 1E284  97 PC, low confidence
; Turns a player toward the puck carrier, or toward the goal he attacks when
; he carries the puck himself; sets the motion heading
;-----------------------------------------------------------------------------
AimAtPuckTarget:
        push ebx
        push ecx
        push edx
        sub esp, byte 4
        mov ebx, eax
        mov eax, dword [PtrPuckZone]
        mov dl, byte [eax]
        test dl, dl
        jge short .1
        mov eax, dword [PtrPuckFlags]
        jmp short .2
.1:
        movsx edx, dl
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
.2:
        mov edx, dword [PtrPuckZone]
        xor ecx, ecx
        movsx edx, byte [edx]
        mov cl, byte [dword ebx+0A4h]
        cmp ecx, edx
        jne short .3
        mov ecx, 10B0h
        xor edx, edx
        mov word [regd1], cx
        mov word [ZoneTargetY], dx
        test byte [dword ebx+0BFh], 80h
        jne short .4
        mov word [regd1], 0EF50h
        jmp short .4
.3:
        mov dx, word [byte eax+06h]
        mov word [ZoneTargetY], dx
        mov ax, word [byte eax+0Eh]
        mov word [regd1], ax
.4:
        mov eax, dword [byte ebx+0Ch]
        mov edx, dword [ZoneFlags]
        sar eax, 10h
        sar edx, 10h
        sub edx, eax
        mov eax, dword [ZoneTargetX]
        push edx
        mov edx, dword [byte ebx+04h]
        sar eax, 10h
        sar edx, 10h
        sub eax, edx
        push eax
        call AngleOfVector
        mov dword [byte esp+08h], eax
        add esp, byte 8
        mov eax, dword [dword ebx+0EEh]
        fild dword [esp]
        fstp dword [byte eax+010h]
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+014h], 0
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetZoneFlags                                    1E354  97 PC, low confidence
; Sets a player's rink zone flags from his position seen from his attacking
; end: side (left, middle, right) and depth (own end to deep offensive zone)
;-----------------------------------------------------------------------------
SetZoneFlags:
        push ebx
        push ecx
        push edx
        push edi
        mov dx, word [byte eax+06h]
        mov word [dword eax+0106h], 0
        mov word [ZoneTargetY], dx
        mov dx, word [byte eax+0Eh]
        mov word [regd1], dx
        test byte [dword eax+0BFh], 80h
        jne short .1
        mov bx, word [regd1]
        mov dx, word [ZoneTargetY]
        neg ebx
        neg edx
        mov word [regd1], bx
        mov word [ZoneTargetY], dx
.1:
        mov edx, dword [ZoneTargetX]
        sar edx, 10h
        cmp edx, 0FFFFFC04h
        jge short .2
        or byte [dword eax+0107h], 4
        jmp short .4
.2:
        cmp word [ZoneTargetY], 3FCh
        jge short .3
        or byte [dword eax+0107h], 2
        jmp short .4
.3:
        or byte [dword eax+0107h], 1
.4:
        mov edx, dword [ZoneFlags]
        sar edx, 10h
        cmp edx, 0FFFFFA90h
        jge short .7
        or byte [dword eax+0106h], 4
        mov edx, dword [ZoneFlags]
        sar edx, 10h
        cmp edx, 0FFFFF010h
        jge short .5
        or byte [dword eax+0106h], 40h
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        cmp edx, 0FFFFF7C0h
        jge short .6
        or byte [dword eax+0106h], 20h
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        or byte [dword eax+0106h], 10h
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        cmp word [regd1], 570h
        jge short .9
        mov bl, byte [dword eax+0106h]
        or bl, 2
        mov byte [dword eax+0106h], bl
        mov edx, dword [ZoneFlags]
        sar edx, 10h
        cmp edx, 0FFFFFC70h
        jge short .8
        mov ch, bl
        jmp short .12
.8:
        cmp word [regd1], 390h
        jge short .6
        or byte [dword eax+0106h], 20h
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov cl, byte [dword eax+0106h]
        or cl, 1
        mov byte [dword eax+0106h], cl
        mov di, word [regd1]
        cmp di, 840h
        jge short .10
        mov dh, cl
        or dh, 10h
        mov byte [dword eax+0106h], dh
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        cmp di, 0FF0h
        jge short .11
        mov dl, cl
        or dl, 20h
        mov byte [dword eax+0106h], dl
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        mov ch, cl
.12:
        or ch, 40h
        mov byte [dword eax+0106h], ch
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        mov ebx, edx
        mov edx, dword [dword eax+0EEh]
        or byte [byte edx+029h], 20h
        mov edx, dword [dword eax+0EEh]
        mov al, byte [dword ebx+0A4h]
        mov byte [byte edx+02Ch], al
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CanReachPuck                                    1E4E4  97 PC, low confidence
; Whether a player can play the loose or carried puck: not his own team's carrier, play running, puck speed
; in range and moving his way; returns nonzero if so
;-----------------------------------------------------------------------------
CanReachPuck:
        push ebx
        push ecx
        push edx
        sub esp, byte 18h
        mov ebx, eax
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jl short .1
        cmp byte [dword ebx+0A4h], 6
        setb al
        xor edx, edx
        mov dl, al
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        je short .2
.1:
        test byte [gmode], 1
        je short .3
.2:
        xor eax, eax
        jmp near .24
.3:
        mov edx, dword [PtrPuckFlags]
        fld dword [byte edx+028h]
        fabs
        fst dword [esp]
        fcomp dword [F32_4272]
        fnstsw ax
        sahf
        ja short .4
        fld dword [esp]
        fcomp dword [F32_1392]
        fnstsw ax
        sahf
        jae short .5
.4:
        xor eax, eax
        add esp, byte 18h
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        test byte [dword ebx+0BFh], 80h
        jne short .6
        fldz
        fcomp dword [byte edx+034h]
        fnstsw ax
        sahf
        jbe short .6
        xor eax, eax
        add esp, byte 18h
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        test byte [dword ebx+0BFh], 80h
        je short .7
        mov eax, dword [PtrPuckFlags]
        fldz
        fcomp dword [byte eax+034h]
        fnstsw ax
        sahf
        jae short .7
        xor eax, eax
        add esp, byte 18h
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        mov eax, dword [byte ebx+028h]
        mov dl, byte [dword ebx+0BFh]
        mov dword [byte esp+04h], eax
        test dl, 80h
        jne short .9
        fld dword [byte esp+04h]
        fcomp dword [F32_4272]
        fnstsw ax
        sahf
        ja short .8
        fld dword [byte esp+04h]
        fcomp dword [F32_1392]
        fnstsw ax
        sahf
        jb short .8
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+034h]
        fmul dword [F32_10_CanReachPuck]
        fadd dword [byte eax+028h]
        fcomp dword [byte esp+04h]
        fnstsw ax
        sahf
        jbe short .11
.8:
        xor eax, eax
        add esp, byte 18h
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        fld dword [byte esp+04h]
        fcomp dword [F32_neg4272]
        fnstsw ax
        sahf
        jb short .10
        fld dword [byte esp+04h]
        fcomp dword [F32_neg1392]
        fnstsw ax
        sahf
        ja short .10
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+034h]
        fmul dword [F32_10_CanReachPuck]
        fadd dword [byte eax+028h]
        fcomp dword [byte esp+04h]
        fnstsw ax
        sahf
        jae short .11
.10:
        xor eax, eax
        add esp, byte 18h
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        test byte [dword ebx+0BFh], 80h
        je short .12
        mov dword [byte esp+08h], 0FFFFEF50h
        jmp short .13
.12:
        mov dword [byte esp+08h], 10B0h
.13:
        fild word [byte ebx+0Eh]
        fild dword [byte esp+08h]
        fstp dword [byte esp+0Ch]
        fsubr dword [byte esp+0Ch]
        call __CHP
        fistp dword [byte esp+010h]
        mov eax, dword [byte esp+010h]
        mov word [byte esp+014h], ax
        mov edx, dword [byte esp+012h]
        mov eax, dword [byte ebx+04h]
        sar edx, 10h
        sar eax, 10h
        call vtoa
        movsx ecx, ax
        cmp ecx, byte 2
        je short .14
        cmp ecx, byte 6
        jne short .15
.14:
        xor eax, eax
        add esp, byte 18h
        pop edx
        pop ecx
        pop ebx
        ret
.15:
        mov eax, dword [PtrPuckOwner]
        fild word [eax]
        fsubr dword [byte esp+0Ch]
        call __CHP
        fistp dword [byte esp+010h]
        mov eax, dword [byte esp+010h]
        mov word [byte esp+014h], ax
        mov edx, dword [byte esp+012h]
        mov eax, dword [PtrPuckTarget]
        sar edx, 10h
        movsx eax, word [eax]
        call vtoa
        cwde
        sub ecx, eax
        lea eax, [byte ecx+01h]
        and eax, byte 7
        cmp eax, byte 1
        jle short .16
        xor eax, eax
        add esp, byte 18h
        pop edx
        pop ecx
        pop ebx
        ret
.16:
        mov eax, dword [PtrPuckZone]
        mov cl, byte [eax]
        test cl, cl
        jge short .19
        cmp word [PassPending], byte 0
        jl short .17
        cmp byte [dword ebx+0A4h], 6
        setb al
        mov edx, eax
        mov cx, word [PassPending]
        and edx, 0FFh
        cmp cx, byte 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        jne short .18
.17:
        xor eax, eax
        add esp, byte 18h
        pop edx
        pop ecx
        pop ebx
        ret
.18:
        mov edx, dword [PassPlayer]
        sar edx, 10h
        jmp short .20
.19:
        movsx edx, cl
.20:
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        mov edx, dword [dword eax+0F6h]
        mov edx, dword [edx]
        mov edx, dword [byte edx+028h]
        and edx, 0FFFFh
        cmp edx, byte 29h
        jl short .21
        cmp edx, byte 2Fh
        jle short .22
.21:
        xor eax, eax
        add esp, byte 18h
        pop edx
        pop ecx
        pop ebx
        ret
.22:
        fld dword [byte ebx+028h]
        fsub dword [byte eax+028h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte ebx+020h]
        fsub dword [byte eax+020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_768]
        fnstsw ax
        sahf
        jae short .23
        xor eax, eax
        add esp, byte 18h
        pop edx
        pop ecx
        pop ebx
        ret
.23:
        mov eax, dword [PtrPuckFlags]
        lea edx, [byte eax+034h]
        push edx
        lea edx, [byte eax+02Ch]
        push edx
        push dword 432F0000h
        push dword [byte eax+028h]
        push dword [byte eax+020h]
        push byte 0
        push byte 0
        push dword [byte esp+028h]
        push byte 0
        call StickReach
        fstp st0
        mov eax, 1
.24:
        add esp, byte 18h
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; TryPokePuck                                     1E7C4  97 PC, low confidence
; Starts a poke check when the player can reach the puck; keeps the puck's
; motion as it was; returns nonzero when started
;-----------------------------------------------------------------------------
TryPokePuck:
        push ebx
        push edx
        sub esp, byte 8
        mov edx, eax
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [byte eax+02Ch]
        mov eax, dword [byte eax+034h]
        mov dword [esp], eax
        mov eax, edx
        mov dword [byte esp+04h], ebx
        call CanReachPuck
        mov ebx, eax
        test eax, eax
        je short .1
        mov eax, edx
        call PokeCheckAnim
.1:
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [byte esp+04h]
        mov dword [byte eax+02Ch], edx
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [esp]
        mov dword [byte eax+034h], edx
        mov eax, ebx
        add esp, byte 8
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; RandomPokeCheck                                 1E810  97 PC, low confidence
; Computer players poke at the puck now and then, more often against the
; other team and with higher checking skill
;-----------------------------------------------------------------------------
RandomPokeCheck:
        push ebx
        push ecx
        push edx
        sub esp, byte 8
        mov edx, eax
        mov bl, byte [PlayFlags]
        mov eax, 8
        test bl, 20h
        je short .1
        mov bl, byte [dword edx+0BFh]
        xor ecx, ecx
        and bl, 40h
        mov cl, bl
        mov bx, word [PlayFlags]
        xor bh, bh
        and bl, 40h
        movsx ebx, bx
        xor ebx, ecx
        je short .1
        mov eax, 4
.1:
        xor ebx, ebx
        mov ecx, 0Fh
        mov bl, byte [dword edx+0C6h]
        sub ecx, ebx
        add eax, ecx
        sar eax, 1
        cwde
        call randomd0
        cmp ax, 1
        jg short .3
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [byte eax+02Ch]
        mov eax, dword [byte eax+034h]
        mov dword [esp], eax
        mov eax, edx
        mov dword [byte esp+04h], ebx
        call CanReachPuck
        test eax, eax
        je short .2
        mov eax, edx
        call PokeCheckAnim
.2:
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [byte esp+04h]
        mov dword [byte eax+02Ch], edx
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [esp]
        mov dword [byte eax+034h], edx
.3:
        add esp, byte 8
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ChkPokeOrCheck                                  1E8B0  97 PC, low confidence
; Defender decides to poke check, hook or body check the carrier from
; distance, angle, skill and difficulty
;-----------------------------------------------------------------------------
ChkPokeOrCheck:
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
        test byte [dword eax+0BFh], 8
        jne near .12
        xor eax, eax
        mov edx, 14h
        mov al, byte [dword ecx+0CFh]
        sub edx, eax
        mov eax, edx
        mov edx, dword [GameOptionFlags]
        test byte [byte edx+01h], 7
        je short .1
        mov edx, eax
        sar edx, 1
        add eax, edx
.1:
        mov bh, byte [dword ecx+0BFh]
        shl eax, 2
        test bh, 80h
        setne dl
        mov si, word [byte ecx+0Eh]
        and edx, 0FFh
        test si, si
        setg bl
        and ebx, 0FFh
        xor edx, ebx
        je near .11
        cmp word [byte ecx+06h], byte 0
        jge short .2
        mov edx, dword [byte ecx+04h]
        sar edx, 10h
        neg edx
        jmp short .3
.2:
        mov edx, dword [byte ecx+04h]
        sar edx, 10h
.3:
        cmp edx, 240h
        jge short .6
        cmp word [byte ecx+0Eh], byte 0
        jge short .4
        mov edx, dword [byte ecx+0Ch]
        sar edx, 10h
        neg edx
        jmp short .5
.4:
        mov edx, dword [byte ecx+0Ch]
        sar edx, 10h
.5:
        cmp edx, 0E70h
        jle short .6
        sar eax, 1
.6:
        cmp word [byte ecx+06h], byte 0
        jge short .7
        mov edx, dword [byte ecx+04h]
        sar edx, 10h
        neg edx
        jmp short .8
.7:
        mov edx, dword [byte ecx+04h]
        sar edx, 10h
.8:
        cmp edx, 180h
        jge short .11
        cmp word [byte ecx+0Eh], byte 0
        jge short .9
        mov edx, dword [byte ecx+0Ch]
        sar edx, 10h
        neg edx
        jmp short .10
.9:
        mov edx, dword [byte ecx+0Ch]
        sar edx, 10h
.10:
        cmp edx, 0F30h
        jle short .11
        sar eax, 1
.11:
        cwde
        call randomd0
        cmp ax, 10h
        jg near .32
.12:
        cmp byte [dword ecx+0A4h], 6
        jae short .13
        mov eax, 6
        jmp short .14
.13:
        xor eax, eax
.14:
        mov edx, eax
        shl eax, 5
        add eax, edx
        mov ebx, SortCords
        shl eax, 3
        xor esi, esi
        add ebx, eax
        xor edi, edi
.15:
        cmp esi, byte 6
        jl short .16
        mov ah, byte [dword ecx+0BFh]
        mov ebx, dword [PtrPuckObject]
        test ah, 8
        je near .31
.16:
        test byte [dword ecx+0BFh], 8
        jne near .23
        mov eax, dword [PtrPuckZone]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ebx+0A4h]
        cmp edx, eax
        setne al
        and eax, 0FFh
        je near .23
        test byte [dword ebx+0BFh], 80h
        setne al
        xor edx, edx
        mov dl, al
        cmp di, word [byte ebx+0Eh]
        setg al
        and eax, 0FFh
        xor eax, edx
        je short .23
        cmp di, word [byte ebx+06h]
        jle short .17
        mov eax, dword [byte ebx+04h]
        sar eax, 10h
        neg eax
        jmp short .18
.17:
        mov eax, dword [byte ebx+04h]
        sar eax, 10h
.18:
        cmp eax, 180h
        jge near .31
        cmp di, word [byte ebx+0Eh]
        jle short .19
        mov eax, dword [byte ebx+0Ch]
        sar eax, 10h
        neg eax
        jmp short .20
.19:
        mov eax, dword [byte ebx+0Ch]
        sar eax, 10h
.20:
        cmp eax, 0F30h
        jle near .31
        cmp di, word [byte ebx+0Eh]
        jle short .21
        mov edx, dword [byte ebx+0Ch]
        sar edx, 10h
        neg edx
        jmp short .22
.21:
        mov edx, dword [byte ebx+0Ch]
        sar edx, 10h
.22:
        cmp edx, 10B0h
        jge near .31
.23:
        cmp di, word [dword ebx+0A9h]
        je near .31
        test byte [dword ebx+0BFh], 20h
        jne near .31
        test byte [dword ebx+0C0h], 1
        jne near .31
        mov eax, dword [dword ebx+0EEh]
        test byte [byte eax+031h], 1
        jne near .31
        fld dword [byte ebx+028h]
        fsub dword [byte ecx+028h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte ebx+020h]
        fsub dword [byte ecx+020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fld dword [byte ecx+050h]
        fadd dword [byte ebx+050h]
        fld dword [byte ecx+038h]
        fadd dword [byte ebx+038h]
        faddp
        fadd dword [F32_24]
        fcompp
        fnstsw ax
        sahf
        jb near .31
        fld dword [byte ecx+01Ch]
        fadd qword [F64_0p392699_ChkPokeOrCheck]
        fmul qword [F64_0p159155_ChkPokeOrCheck]
        fmul qword [F64_65536_ChkPokeOrCheck]
        fld dword [byte ebx+028h]
        fld dword [byte ebx+020h]
        fsub dword [byte ecx+020h]
        fxch
        fsub dword [byte ecx+028h]
        fxch
        call __CHP
        fxch st2
        call __CHP
        fistp dword [byte esp+04h]
        mov edx, dword [byte esp+04h]
        call __CHP
        and edx, 0E000h
        fistp dword [byte esp+08h]
        mov eax, edx
        mov dword [byte esp+04h], edx
        sar eax, 0Dh
        fistp dword [byte esp+0Ch]
        mov dword [byte esp+04h], eax
        cmp edi, eax
        jle short .24
        add eax, byte 8
        mov dword [byte esp+04h], eax
.24:
        mov edx, dword [byte esp+06h]
        mov eax, dword [byte esp+0Ah]
        sar edx, 10h
        sar eax, 10h
        call vtoa
        mov edx, dword [byte esp+04h]
        cwde
        sub eax, edx
        inc eax
        and eax, byte 7
        cmp eax, byte 3
        jge near .31
        test word [GameSettings], 180h
        jne short .25
        mov edx, 19h
        jmp short .27
.25:
        mov eax, dword [GameSettings]
        and eax, 180h
        cmp eax, 80h
        jne short .26
        mov edx, 23h
        jmp short .27
.26:
        mov edx, 2Dh
.27:
        mov al, byte [dword ecx+0BFh]
        test al, 8
        jne short .29
        test al, 8
        jne short .28
        cmp dword [byte ebx+038h], 41700000h
        jl short .29
.28:
        mov eax, 64h
        call randomd0
        cwde
        cmp eax, edx
        jge short .30
.29:
        mov eax, dword [dword ecx+0EEh]
        or byte [byte eax+029h], 20h
        mov edx, dword [dword ecx+0EEh]
        mov al, byte [dword ebx+0A4h]
        mov byte [byte edx+02Ch], al
        jmp short .32
.30:
        cmp byte [dword ebx+0A4h], 0Ch
        je short .31
        cmp dword [byte ebx+038h], 42480000h
        jl short .31
        mov edx, ebx
        mov eax, ecx
        call AIBodyCheck
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.31:
        inc esi
        add ebx, 108h
        cmp esi, byte 7
        jl near .15
        mov eax, dword [dword ecx+0EEh]
        and byte [byte eax+029h], 0DFh
        mov eax, ecx
        call RandomPokeCheck
.32:
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
; check4bench                                    1EC5C  94G, medium confidence
; whether player a3 should go to the bench; if so assreplace with assbench (17h); 0 when he
; stays (joystick-controlled, penalty shot, ...)
;-----------------------------------------------------------------------------
check4bench:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        test byte [gmode], 1
        jne short .1
        test byte [dword ebx+0BFh], 8
        jne short .2
.1:
        test byte [dword ebx+0C0h], 10h
        je short .3
.2:
        xor eax, eax
        jmp near .21
.3:
        xor eax, eax
        mov dx, word [FaceoffRequest]
        mov al, byte [dword ebx+0A4h]
        cmp ax, dx
        jne short .4
        xor eax, edx
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        cmp word [BenchRequest], byte 0
        je short .6
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        add eax, ebx
        mov cl, byte [dword eax+0B2h]
        cmp cl, 18h
        je short .5
        cmp cl, 16h
        jne short .6
.5:
        xor eax, eax
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        cmp byte [dword ebx+0A8h], 0
        jge short .7
        cmp byte [dword ebx+0A7h], 0
        jge short .7
        xor eax, eax
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        mov si, word [StatsPanelPlayer]
        cmp si, word [gameclock]
        jne near .9
        cmp word [StatsPanelOn], byte 0
        jne near .9
        mov dx, word [dword ebx+0A9h]
        movsx ax, byte [dword ebx+0A8h]
        cmp ax, dx
        jne short .8
        mov dl, byte [dword ebx+0A6h]
        cmp dl, byte [dword ebx+0A7h]
        jne short .8
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        cmp byte [dword ebx+eax+0B2h], 6
        jne short .8
        xor eax, eax
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        test byte [dword ebx+0BFh], 40h
        setne al
        and eax, 0FFh
        cmp word [nosplit eax*2+FaceoffTakers], byte 0
        je short .9
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        cmp byte [dword ebx+eax+0B2h], 1
        jne short .9
        xor eax, eax
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov al, byte [dword ebx+0A7h]
        cmp al, byte [dword ebx+0A6h]
        jne short .10
        cmp word [BenchRequest], byte 0
        je near .13
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        add eax, ebx
        mov dl, byte [dword eax+0B2h]
        cmp dl, 1
        je short .10
        cmp dl, 19h
        jne near .13
.10:
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        cmp byte [dword ebx+eax+0B2h], 17h
        jne short .11
        xor eax, eax
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        mov eax, dword [PtrPuckZone]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ebx+0A4h]
        cmp edx, eax
        jne short .12
        xor eax, eax
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.12:
        mov cl, byte [dword ebx+0BFh]
        mov dh, byte [dword ebx+0C0h]
        mov eax, dword [dword ebx+0AEh]
        and cl, 0FBh
        or dh, 4
        mov byte [dword ebx+0BFh], cl
        sar eax, 18h
        mov ch, byte [dword ebx+0C1h]
        mov byte [dword ebx+0C0h], dh
        and ch, 0E7h
        mov edx, 17h
        mov byte [dword ebx+0C1h], ch
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword ebx+0BFh], 2
        mov eax, 1
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.13:
        and byte [dword ebx+0C0h], 0FBh
        mov ch, byte [dword ebx+0BFh]
        and ch, 0FBh
        mov al, byte [dword ebx+0A8h]
        mov byte [dword ebx+0BFh], ch
        test al, al
        jl short .14
        mov ah, byte [dword ebx+0A6h]
        xor edx, edx
        cmp ah, 19h
        setl al
        mov cl, byte [dword ebx+0A8h]
        mov dl, al
        test cl, cl
        sete al
        and eax, 0FFh
        xor eax, edx
        je short .14
        movsx ax, cl
        mov word [dword ebx+0A9h], ax
.14:
        mov eax, ebx
        call Setplass
        test byte [gmode], 1
        je near .20
        mov di, word [StatsPanelPlayer]
        cmp di, word [gameclock]
        jne short .15
        cmp word [StatsPanelOn], byte 0
        je short .16
.15:
        mov eax, 1
        jmp short .17
.16:
        xor eax, eax
.17:
        test eax, eax
        je near .20
        mov al, byte [dword ebx+0C1h]
        and al, 0E7h
        mov dx, word [dword ebx+0A9h]
        mov byte [dword ebx+0C1h], al
        test dx, dx
        jle short .18
        test byte [dword ebx+0BFh], 40h
        setne al
        and eax, 0FFh
        cmp word [nosplit eax*2+FaceoffTakers], byte 0
        je short .18
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        mov ecx, 15h
        movsx dx, byte [dword edx+ebx+0B2h]
        mov eax, ebx
        cmp dx, cx
        je short .19
        mov dl, byte [dword ebx+0B1h]
        dec dl
        and dl, 7
        mov byte [dword ebx+0B1h], dl
        jmp short .19
.18:
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        mov ecx, 6
        movsx dx, byte [dword edx+ebx+0B2h]
        mov eax, ebx
        cmp dx, cx
        je short .19
        mov dl, byte [dword ebx+0B1h]
        dec dl
        and dl, 7
        mov byte [dword ebx+0B1h], dl
.19:
        movsx edx, cx
        call assreplace
.20:
        mov byte [dword ebx+0A8h], 0FFh
        mov byte [dword ebx+0A7h], 0FFh
        mov eax, 1
.21:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SwapPosition                                 1EF88  96 PC, medium confidence
; Gives the player (eax) position edx and hands his old position to the
; teammate who held it (struct +66h, team position map +102h)
;-----------------------------------------------------------------------------
SwapPosition:
        push ebx
        push ecx
        push esi
        push edi
        mov esi, eax
        mov ecx, edx
        mov edi, dword [dword eax+0A9h]
        sar edi, 10h
        cmp edi, edx
        jne short .1
        xor eax, eax
        mov al, byte [dword esi+0A4h]
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.1:
        cmp byte [dword eax+0A4h], 6
        jae short .2
        xor edx, edx
        jmp short .3
.2:
        mov edx, 6
.3:
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        xor edx, edx
        add eax, SortCords
.4:
        mov ebx, dword [dword eax+0A9h]
        sar ebx, 10h
        cmp ebx, ecx
        jne short .5
        mov word [dword eax+0ABh], di
        mov ebx, dword [dword esi+0FEh]
        add edi, ebx
        mov bl, byte [dword eax+0A4h]
        mov byte [dword edi+0ECh], bl
        jmp short .6
.5:
        inc edx
        add eax, 108h
        cmp edx, byte 6
        jl short .4
.6:
        mov ebx, dword [dword esi+0FEh]
        mov word [dword esi+0ABh], cx
        add ecx, ebx
        mov bl, byte [dword esi+0A4h]
        mov byte [dword ecx+0ECh], bl
        cmp edx, byte 6
        jl short .7
        xor eax, eax
        mov al, bl
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.7:
        mov al, byte [dword eax+0A4h]
        and eax, 0FFh
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
SwapPositionJumpTable:                          ; jump table for the switch cases
        dd .4
        dd .6
        dd .13
        dd .8
        dd .16
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 20h
        mov ebx, dword [byte eax+04h]
        mov edx, dword [dword eax+0A9h]
        mov cl, byte [dword eax+0BFh]
        sar ebx, 10h
        sar edx, 10h
        test cl, 80h
        jne short .1
        neg ebx
.1:
        cmp edx, byte 1
        je short .2
        cmp edx, byte 2
        jne near .21
.2:
        cmp edx, byte 1
        sete cl
        and ecx, 0FFh
        test ebx, ebx
        setle bl
        and ebx, 0FFh
        xor ebx, ecx
        je near .21
        cmp edx, byte 1
        sete dl
        xor ecx, ecx
        mov eax, dword [dword eax+0FEh]
        mov cl, dl
        mov si, word [byte eax+010h]
        mov edx, ecx
        test si, si
        setge bl
        movzx esi, bl
        mov ebx, dword [byte eax+0Ch]
        sar ebx, 10h
        sub ebx, esi
        mov eax, dword [dword eax+0104h]
        mov esi, ebx
        xor ebx, ebx
        cmp esi, byte 4
        setl byte [byte esp+010h]
        cmp esi, byte 4
        setge byte [byte esp+01Ch]
        test ecx, ecx
        setne byte [byte esp+014h]
        test ecx, ecx
        setne byte [byte esp+018h]
.3:
        mov cx, word [dword eax+0ABh]
        dec ecx
        cmp cx, byte 4
        ja near .20
        and ecx, 0FFFFh
        jmp dword [nosplit cs:ecx*4+SwapPositionJumpTable]
.4:
        test edx, edx
        je short .5
        mov word [dword eax+0ABh], 2
        jmp near .20
.5:
        xor ecx, ecx
        mov cl, byte [byte esp+010h]
        add ecx, byte 3
        mov word [dword eax+0ABh], cx
        jmp near .20
.6:
        test edx, edx
        je short .7
        xor ecx, ecx
        mov cl, byte [byte esp+01Ch]
        add ecx, byte 4
        mov word [dword eax+0ABh], cx
        jmp near .20
.7:
        mov word [dword eax+0ABh], 1
        jmp near .20
.8:
        test edx, edx
        je short .10
        cmp esi, byte 4
        jl short .9
        mov ecx, 3
        jmp short .12
.9:
        mov ecx, 1
        jmp short .12
.10:
        cmp esi, byte 5
        jl short .11
        mov ecx, 5
        jmp short .12
.11:
        mov ecx, 2
.12:
        mov word [dword eax+0ABh], cx
        cmp word [dword eax+0ABh], byte 2
        jg near .20
        mov ecx, 0Fh
        mov edi, dword [dword eax+0AEh]
        mov word [byte esp+08h], cx
        sar edi, 18h
        mov cl, byte [byte esp+08h]
        mov byte [dword edi+eax+0B2h], cl
        or byte [dword eax+0BFh], 2
        xor ecx, ecx
        mov cl, byte [byte esp+014h]
        lea edi, [byte ecx+01h]
        mov ecx, dword [dword eax+0FEh]
        mov ecx, dword [dword ecx+edi+0E9h]
        sar ecx, 18h
        mov dword [dword eax+0ADh], ecx
        xor ecx, ecx
        mov cl, byte [byte esp+018h]
        inc ecx
        mov dword [esp], ecx
        mov ecx, dword [dword eax+0FEh]
        add ecx, dword [esp]
        mov ecx, dword [dword ecx+0E9h]
        jmp near .19
.13:
        test edx, edx
        je short .14
        mov word [dword eax+0ABh], 1
        jmp short .15
.14:
        mov word [dword eax+0ABh], 4
.15:
        cmp word [dword eax+0ABh], byte 2
        jg near .20
        mov word [byte esp+04h], 0Fh
        mov ecx, dword [dword eax+0AEh]
        sar ecx, 18h
        lea edi, [eax+ecx]
        mov cl, byte [byte esp+04h]
        mov byte [dword edi+0B2h], cl
        or byte [dword eax+0BFh], 2
        mov ecx, dword [dword eax+0FEh]
        mov ecx, dword [dword ecx+0EBh]
        sar ecx, 18h
        mov dword [dword eax+0ADh], ecx
        mov ecx, dword [dword eax+0FEh]
        mov ecx, dword [dword ecx+0EBh]
        jmp short .19
.16:
        test edx, edx
        je short .17
        mov word [dword eax+0ABh], 4
        jmp short .18
.17:
        mov word [dword eax+0ABh], 2
.18:
        cmp word [dword eax+0ABh], byte 2
        jg short .20
        mov word [byte esp+0Ch], 0Fh
        mov ecx, dword [dword eax+0AEh]
        sar ecx, 18h
        lea edi, [eax+ecx]
        mov cl, byte [byte esp+0Ch]
        mov byte [dword edi+0B2h], cl
        or byte [dword eax+0BFh], 2
        mov ecx, dword [dword eax+0FEh]
        mov ecx, dword [dword ecx+0EAh]
        sar ecx, 18h
        mov dword [dword eax+0ADh], ecx
        mov ecx, dword [dword eax+0FEh]
        mov ecx, dword [dword ecx+0EAh]
.19:
        sar ecx, 18h
        imul ecx, dword 108h
        movzx edi, byte [dword eax+0A4h]
        mov dword [dword ecx+PlayerAssignPtrs], edi
.20:
        mov ecx, dword [dword eax+0A9h]
        mov edi, dword [dword eax+0FEh]
        sar ecx, 10h
        inc ebx
        add edi, ecx
        mov cl, byte [dword eax+0A4h]
        add eax, 108h
        mov byte [dword edi+0ECh], cl
        cmp ebx, byte 6
        jl near .3
        mov eax, 1
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.21:
        xor eax, eax
        add esp, byte 20h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ChkForwardSwap                                  1F32C  97 PC, low confidence
; A defenseman caught deep in the offensive zone swaps position with a
; forward (left wing, center or right wing by side)
;-----------------------------------------------------------------------------
ChkForwardSwap:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        mov edx, dword [byte eax+0Ch]
        mov ah, byte [dword eax+0BFh]
        sar edx, 10h
        test ah, 80h
        jne short .1
        neg edx
.1:
        mov eax, dword [byte ebx+04h]
        mov cl, byte [dword ebx+0BFh]
        sar eax, 10h
        test cl, 80h
        jne short .2
        neg eax
.2:
        mov esi, dword [dword ebx+0A9h]
        mov cx, word [dword ebx+0A9h]
        sar esi, 10h
        cmp cx, byte 1
        je short .3
        cmp cx, byte 2
        jne near .10
.3:
        cmp esi, byte 1
        je short .4
        cmp esi, byte 2
        jne near .10
.4:
        cmp edx, 840h
        jl near .14
        mov edx, dword [dword ebx+0FEh]
        mov di, word [byte edx+010h]
        xor ecx, ecx
        test di, di
        setge dl
        mov cl, dl
        mov edx, dword [dword ebx+0FEh]
        mov edx, dword [byte edx+0Ch]
        sar edx, 10h
        sub edx, ecx
        cmp eax, 0FFFFFD58h
        jge short .5
        cmp edx, byte 4
        jl short .5
        mov edx, 3
        jmp short .7
.5:
        cmp eax, 2A8h
        jle short .6
        cmp edx, byte 5
        jl short .6
        mov edx, 5
        jmp short .7
.6:
        mov edx, 4
.7:
        mov eax, ebx
        call SwapPosition
        xor edx, edx
        mov dl, byte [dword ebx+0A4h]
        cmp eax, edx
        je near .14
        mov ecx, eax
        shl ecx, 5
        add ecx, eax
        shl ecx, 3
        add ecx, SortCords
        test byte [dword ecx+0C0h], 4
        je short .8
        mov edx, esi
        jmp near .13
.8:
        mov edx, dword [dword ecx+0AEh]
        sar edx, 18h
        mov esi, 0Fh
        movsx dx, byte [dword ecx+edx+0B2h]
        mov eax, ecx
        cmp dx, si
        je short .9
        mov dl, byte [dword ecx+0B1h]
        dec dl
        and dl, 7
        mov byte [dword ecx+0B1h], dl
.9:
        movsx edx, si
        call assreplace
        xor eax, eax
        mov al, byte [dword ecx+0A4h]
        mov dword [dword ebx+0ADh], eax
        xor eax, eax
        mov al, byte [dword ebx+0A4h]
        mov dword [dword ecx+0ADh], eax
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        cmp esi, byte 3
        jl near .14
        cmp esi, byte 5
        jg short .14
        mov edx, dword [dword ebx+0FEh]
        cmp word [byte edx+010h], byte 0
        setge dl
        xor ecx, ecx
        mov cl, dl
        mov edx, dword [dword ebx+0FEh]
        mov edx, dword [byte edx+0Ch]
        sar edx, 10h
        sub edx, ecx
        cmp eax, 0FFFFFD58h
        jge short .11
        cmp edx, byte 4
        jl short .11
        mov edx, 3
        mov eax, ebx
        call SwapPosition
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        cmp eax, 2A8h
        jle short .12
        cmp edx, byte 5
        jl short .12
        mov edx, 5
        mov eax, ebx
        call SwapPosition
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.12:
        mov edx, 4
.13:
        mov eax, ebx
        call SwapPosition
.14:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; GetDefensePartner                               1F4EC  97 PC, low confidence
; Returns the object of the other defenseman of a defenseman's line, 0 for a
; forward
;-----------------------------------------------------------------------------
GetDefensePartner:
        push ebx
        push edx
        mov edx, eax
        mov eax, dword [dword eax+0A9h]
        sar eax, 10h
        cmp eax, byte 1
        je short .1
        cmp eax, byte 2
        je short .1
        xor eax, eax
        pop edx
        pop ebx
        ret
.1:
        cmp eax, byte 1
        sete al
        and eax, 0FFh
        lea ebx, [byte eax+01h]
        mov eax, dword [dword edx+0FEh]
        mov eax, dword [dword ebx+eax+0E9h]
        sar eax, 18h
        mov edx, eax
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ChkSwapWithPartner                              1F538  97 PC, low confidence
; Two defensemen on the wrong sides swap positions; returns 1 when they
; swapped
;-----------------------------------------------------------------------------
ChkSwapWithPartner:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        call GetDefensePartner
        mov ecx, eax
        test eax, eax
        je short .1
        mov edx, dword [byte eax+010h]
        mov eax, dword [byte eax+04h]
        sar edx, 0Bh
        sar eax, 10h
        add edx, eax
        mov eax, dword [byte ebx+04h]
        sar eax, 10h
        cmp eax, edx
        setge al
        mov esi, eax
        xor edx, edx
        mov ah, byte [dword ebx+0BFh]
        and esi, 0FFh
        test ah, 80h
        setne al
        mov di, word [dword ebx+0ABh]
        mov dl, al
        cmp di, byte 1
        sete al
        and eax, 0FFh
        xor eax, edx
        xor eax, esi
        je short .1
        mov edx, dword [dword ecx+0A9h]
        mov eax, ebx
        sar edx, 10h
        call SwapPosition
        mov eax, 1
        jmp short .2
.1:
        xor eax, eax
.2:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; asscoverdefd                                    1F5B4  96 PC, low confidence
; Assignment 10h (set by asscoverdefo): the defending half of the cover,
; SwapPosition back when it ends
;-----------------------------------------------------------------------------
asscoverdefd:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .8
        mov eax, ebx
        call check4bench
        test ax, ax
        jne near .8
        test byte [gmode], 1
        je short .1
        mov ah, byte [dword ebx+0BFh]
        test ah, 20h
        jne near .8
        test ah, 8
        jne near .8
        mov edx, 8
        mov eax, ebx
        call doplayeracc
        jmp near .8
.1:
        mov dh, byte [dword ebx+0BFh]
        test dh, 8
        jne near .8
        test dh, 2
        je short .2
        mov dword [byte ebx+05Ah], 0
        mov ch, dh
        mov eax, dword [byte ebx+05Ah]
        and ch, 0FDh
        mov dword [byte ebx+056h], eax
        mov byte [dword ebx+0BFh], ch
.2:
        mov edx, dword [dword ebx+0ADh]
        test edx, edx
        jge short .3
        mov edx, dword [dword ebx+0A7h]
        mov eax, ebx
        sar edx, 10h
        mov dword [dword ebx+0ADh], 0FFFFFFFFh
        call SwapPosition
        mov al, byte [dword ebx+0B1h]
        inc al
        and al, 7
        mov byte [dword ebx+0B1h], al
        or byte [dword ebx+0BFh], 2
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edx, dword [PtrPuckZone]
        shl eax, 3
        mov cl, byte [edx]
        add eax, SortCords
        test cl, cl
        jl near .5
        cmp byte [dword ebx+0A4h], 6
        setb dl
        xor ecx, ecx
        mov cl, dl
        mov edx, dword [PtrPuckZone]
        cmp byte [edx], 6
        setl dl
        and edx, 0FFh
        cmp edx, ecx
        jne short .5
        cmp dword [dword ebx+0ADh], byte 0
        jl short .4
        mov di, word [dword eax+0ABh]
        mov dword [dword eax+0ADh], 0FFFFFFFFh
        cmp di, byte 2
        jle short .4
        mov edx, dword [dword eax+0A7h]
        sar edx, 10h
        call SwapPosition
.4:
        mov al, byte [dword ebx+0B1h]
        mov ch, byte [dword ebx+0BFh]
        mov dword [dword ebx+0ADh], 0FFFFFFFFh
        inc al
        or ch, 2
        and al, 7
        mov byte [dword ebx+0BFh], ch
        mov byte [dword ebx+0B1h], al
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        cmp dword [dword ebx+0ADh], byte 0
        jl near .6
        mov cx, word [byte eax+0Eh]
        mov dx, word [byte ebx+0Eh]
        cmp dx, cx
        setl dl
        mov ecx, edx
        mov dh, byte [dword ebx+0BFh]
        and ecx, 0FFh
        test dh, 80h
        setne dl
        and edx, 0FFh
        xor edx, ecx
        je short .6
        cmp word [dword eax+0ABh], byte 2
        jle short .6
        mov dword [dword ebx+0ADh], 0FFFFFFFFh
        mov edx, dword [dword eax+0A7h]
        sar edx, 10h
        mov dword [dword eax+0ADh], 0FFFFFFFFh
        call SwapPosition
        mov al, byte [dword ebx+0B1h]
        mov cl, byte [dword ebx+0BFh]
        inc al
        or cl, 2
        and al, 7
        mov byte [dword ebx+0BFh], cl
        mov byte [dword ebx+0B1h], al
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        mov esi, dword [byte ebx+05Ah]
        sub esi, byte 2
        mov dword [byte ebx+05Ah], esi
        test esi, esi
        jge short .7
        xor eax, eax
        mov al, byte [dword ebx+0C6h]
        mov dword [byte ebx+05Ah], eax
        mov eax, ebx
        call FindManToCover
.7:
        mov eax, ebx
        call ChkPokeOrCheck
.8:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; asscoverdefo                                    1F7D0  96 PC, low confidence
; Assignment 0Fh (given from the Setplass jump table): a forward covering a defence spot; uses SwapPosition
; and moves on to 10h (asscoverdefd) / asscoverdefd
;-----------------------------------------------------------------------------
asscoverdefo:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        test byte [dword eax+0BFh], 20h
        jne near .17
        mov eax, ebx
        call check4bench
        test ax, ax
        jne near .17
        test byte [gmode], 1
        je short .1
        mov dh, byte [dword ebx+0BFh]
        test dh, 20h
        jne near .17
        test dh, 8
        jne near .17
        mov edx, 8
        mov eax, ebx
        call doplayeracc
        jmp near .17
.1:
        mov dh, byte [dword ebx+0BFh]
        test dh, 8
        jne near .17
        test dh, 2
        je short .2
        mov dword [byte ebx+05Ah], 0
        mov eax, dword [byte ebx+05Ah]
        mov ch, dh
        mov dword [byte ebx+056h], eax
        and ch, 0FDh
        mov eax, dword [dword ebx+0EEh]
        mov byte [dword ebx+0BFh], ch
        and byte [byte eax+029h], 0DFh
.2:
        mov edx, dword [dword ebx+0ADh]
        test edx, edx
        jge short .3
        mov edx, dword [dword ebx+0A7h]
        mov eax, ebx
        sar edx, 10h
        mov dword [dword ebx+0ADh], 0FFFFFFFFh
        call SwapPosition
        mov al, byte [dword ebx+0B1h]
        mov dl, byte [dword ebx+0BFh]
        inc al
        or dl, 2
        and al, 7
        mov byte [dword ebx+0BFh], dl
        mov byte [dword ebx+0B1h], al
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        mov dx, word [byte ebx+0Eh]
        cmp dx, word [byte eax+0Eh]
        setl dl
        mov ecx, edx
        mov dh, byte [dword ebx+0BFh]
        and ecx, 0FFh
        test dh, 80h
        setne dl
        and edx, 0FFh
        xor edx, ecx
        je short .4
        cmp word [dword eax+0A9h], byte 2
        jle short .4
        mov dword [dword ebx+0ADh], 0FFFFFFFFh
        mov edx, dword [dword eax+0A7h]
        mov dword [dword eax+0ADh], 0FFFFFFFFh
        sar edx, 10h
        mov eax, ebx
        call SwapPosition
        mov al, byte [dword ebx+0B1h]
        inc al
        and al, 7
        mov byte [dword ebx+0B1h], al
        or byte [dword ebx+0BFh], 2
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov ecx, dword [byte ebx+05Ah]
        sub ecx, byte 2
        mov dword [byte ebx+05Ah], ecx
        test ecx, ecx
        jge near .11
        xor eax, eax
        mov al, byte [dword ebx+0C6h]
        mov dword [byte ebx+05Ah], eax
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jl short .5
        cmp byte [dword ebx+0A4h], 6
        setb al
        mov edx, dword [PtrPuckZone]
        mov cl, byte [edx]
        and eax, 0FFh
        cmp cl, 6
        setl dl
        and edx, 0FFh
        cmp edx, eax
        jne short .5
        test byte [PlayFlags], 80h
        je short .5
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 10h
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword ebx+0BFh], 2
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov eax, dword [PtrPuckOwner]
        mov ax, word [eax]
        mov word [regd1], ax
        test byte [dword ebx+0BFh], 80h
        jne short .6
        neg word [regd1]
.6:
        cmp word [regd1], 5A0h
        jl near .10
        test byte [PlayFlags], 20h
        je short .7
        mov al, byte [dword ebx+0BFh]
        xor edx, edx
        and al, 40h
        mov dl, al
        mov ax, word [PlayFlags]
        xor ah, ah
        and al, 40h
        cwde
        xor eax, edx
        je short .8
.7:
        mov eax, 1
.8:
        test eax, eax
        jne short .9
        cmp word [regd1], 750h
        jge near .17
.9:
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jl near .17
        cmp byte [dword ebx+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [PtrPuckZone]
        mov cl, byte [eax]
        and edx, 0FFh
        cmp cl, 6
        setl al
        and eax, 0FFh
        xor eax, edx
        je near .17
.10:
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov edx, 10h
        mov byte [dword ebx+eax+0B2h], dl
        or byte [dword ebx+0BFh], 2
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        mov edi, dword [byte ebx+056h]
        sub edi, byte 2
        mov dword [byte ebx+056h], edi
        test edi, edi
        jge near .17
        xor eax, eax
        mov al, byte [dword ebx+0C5h]
        mov di, word [dword ebx+0ABh]
        mov dword [byte ebx+056h], eax
        cmp di, byte 2
        jne short .12
        mov eax, 3FCh
        jmp short .13
.12:
        mov eax, 0FFFFFC04h
.13:
        mov word [ZoneTargetY], ax
        mov word [regd1], 5D0h
        test byte [dword ebx+0BFh], 80h
        jne short .14
        mov dx, word [ZoneTargetY]
        mov ecx, 0FFFFFA30h
        neg edx
        mov word [regd1], cx
        mov word [ZoneTargetY], dx
.14:
        mov eax, dword [PtrPuckTarget]
        mov edx, dword [ZoneTargetX]
        movsx ecx, word [eax]
        sar edx, 10h
        mov esi, ecx
        xor esi, edx
        test esi, esi
        jl short .15
        mov ax, word [eax]
        mov word [ZoneTargetY], ax
        jmp short .16
.15:
        sar ecx, 1
        add edx, ecx
        mov word [ZoneTargetY], dx
.16:
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
        mov dword [byte eax+018h], 42480000h
        mov eax, ebx
        call SetSkateSpeedFromRating
        mov eax, dword [dword ebx+0EEh]
        mov dword [byte eax+024h], 42C80000h
        mov eax, ebx
        call AimAtPuckTarget
.17:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; Setplass                                       1FB6C  94G, medium confidence
; sets the player's starting assignment by position from the list PlayerAssignOrder (goalie 2,
; defence 3, wings 4, centre 5), after SwapPosition
;-----------------------------------------------------------------------------
Setplass:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        mov dx, word [dword eax+0A9h]
        test dx, dx
        jl short .2
        cmp dx, byte 6
        jg short .2
        cmp dword [dword eax+0ADh], byte 0
        jl short .1
        mov edx, dword [dword eax+0A7h]
        sar edx, 10h
        call SwapPosition
        mov edx, dword [dword ebx+0ADh]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov ecx, 0FFFFFFFFh
        mov dword [nosplit eax*8+PlayerAssignPtrs], ecx
        mov dword [dword ebx+0ADh], ecx
.1:
        mov edx, dword [dword ebx+0A7h]
        mov eax, ebx
        sar edx, 10h
        call SwapPosition
        mov eax, dword [dword ebx+0A7h]
        sar eax, 10h
        mov al, byte [dword eax+PlayerAssignOrder]
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        mov byte [dword edx+ebx+0B2h], al
        or byte [dword ebx+0BFh], 2
.2:
        pop edx
        pop ecx
        pop ebx
        ret
