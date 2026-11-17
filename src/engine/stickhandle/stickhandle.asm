; Stick handling: blade position, skate sounds, moving players and the puck on the stick.
bits 32
%include "hockey.inc"
section s_5DF43 progbits alloc exec nowrite align=1
extern ChangeAnim, checkplcoll, F32_0p5_StickHandleScaled, F32_0p5_StickHandleSpeed, F32_neg10_PlaySkateSounds, F64_0p00872665, F64_0p25_PlaySkateSounds, F64_0p2_PlaySkateSounds
extern F64_0p785398_PuckOnStickPhysics, F64_1p1, F64_1p1_StickHandleSpeed, F64_2p35619, F64_neg0p00872665, F64_neg0p1, F64_neg0p2, F64_neg1p6
extern gmode, MoveFuncPair, MoveFuncTable, MoveState, PlayerCollisions, PlaySfxVolume, PtrPuckZone, PuckHeightAt
extern SkateStrideTable, SortCords, StartAnimNow, StickReachX, StickReachY, StickReachZ, StrideSpeeds
global GetStickBladePos, PlaySkateSounds, MovePlayer, PuckOnStickPhysics, PuckOnStickFromState, StickHandleTarget, StickHandleScaled, StickHandleSpeed
global IsSkateAnim, IsStopAnim, StartCheckedAnim, StartNextMove
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; GetStickBladePos                                5DF50  97 PC, low confidence
; Returns the position of a player's stick blade
;-----------------------------------------------------------------------------
GetStickBladePos:
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 4
        and esp, byte 0FFFFFFF8h
        mov edx, dword [dword eax+0EEh]
        test byte [byte edx+029h], 1
        je short .2
        cmp dword [byte edx+024h], 43480000h
        jne short .1
        call StickReachX
        jmp short .3
.1:
        call StickReachY
        jmp short .3
.2:
        call StickReachZ
.3:
        fstp dword [esp]
        fld dword [esp]
        mov esp, ebp
        pop ebp
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PlaySkateSounds                                 5DF90  97 PC, low confidence
; Plays the skate sounds of a moving player
;-----------------------------------------------------------------------------
PlaySkateSounds:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 18h
        mov ebx, eax
        fld dword [byte ebx+020h]
        lea edi, [byte esp+0Ch]
        mov edx, dword [dword eax+0FAh]
        fstp dword [dword eax+0D2h]
        mov ecx, dword [byte ebx+028h]
        mov dword [dword eax+0DAh], ecx
        mov eax, dword [byte eax+040h]
        lea esi, [byte esp+08h]
        mov dword [byte esp+010h], eax
        lea eax, [byte esp+010h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fldz
        fcomp dword [byte ebx+038h]
        fnstsw ax
        sahf
        jbe short .1
        mov dword [byte ebx+038h], 0
.1:
        cmp byte [dword ebx+0A4h], 0Dh
        jne near .7
        fld dword [byte ebx+038h]
        fadd qword [F64_neg0p1]
        fldz
        fxch
        fstp dword [byte esp+014h]
        fcomp dword [byte ebx+030h]
        fnstsw ax
        sahf
        jbe short .2
        cmp dword [byte ebx+024h], 3F800000h
        jge short .2
        fld dword [dword ebx+0D6h]
        fcomp dword [byte ebx+024h]
        fnstsw ax
        sahf
        ja short .2
        mov dword [byte ebx+030h], 0
.2:
        fldz
        fcomp dword [byte esp+014h]
        fnstsw ax
        sahf
        jbe short .3
        xor esi, esi
        mov dword [byte esp+014h], esi
.3:
        fld dword [byte esp+014h]
        fld st0
        fmul dword [byte esp+08h]
        fstp dword [byte ebx+02Ch]
        fmul dword [byte esp+0Ch]
        fldz
        fxch
        fstp dword [byte ebx+034h]
        fcomp dword [byte edx+0Ch]
        fnstsw ax
        sahf
        jae short .4
        fld dword [byte edx+0Ch]
        fadd qword [F64_neg0p00872665]
        fldz
        fxch
        fstp dword [byte edx+0Ch]
        fcomp dword [byte edx+0Ch]
        fnstsw ax
        sahf
        jbe short .6
        mov dword [byte edx+0Ch], 0
        jmp short .6
.4:
        jbe short .5
        fld dword [byte edx+0Ch]
        fld st0
        fadd qword [F64_0p00872665]
        fldz
        fxch
        fstp st2
        fxch
        fstp dword [byte edx+0Ch]
        fcomp dword [byte edx+0Ch]
        fnstsw ax
        sahf
        jae short .6
        mov dword [byte edx+0Ch], 0
        jmp short .6
.5:
        cmp dword [byte ebx+024h], 3F800000h
        jge short .6
        mov dword [byte edx+08h], 0
.6:
        test dword [byte edx+0Ch], 7FFFFFFFh
        je short .8
        fld dword [byte edx+0Ch]
        fadd dword [byte edx+08h]
        fstp dword [byte edx+08h]
        jmp short .8
.7:
        fld dword [byte ebx+038h]
        fmul dword [byte esp+08h]
        fld dword [byte ebx+038h]
        fxch
        fstp dword [byte ebx+02Ch]
        fmul dword [byte esp+0Ch]
        fstp dword [byte ebx+034h]
.8:
        test dword [byte ebx+030h], 7FFFFFFFh
        jne short .9
        fldz
        fcomp dword [byte ebx+024h]
        fnstsw ax
        sahf
        jae near .12
.9:
        fld dword [byte ebx+030h]
        fadd qword [F64_neg1p6]
        fst dword [byte ebx+030h]
        fadd dword [byte ebx+024h]
        fldz
        fxch
        fstp dword [byte ebx+024h]
        fcomp dword [byte ebx+024h]
        fnstsw ax
        sahf
        jbe short .11
        fld dword [byte ebx+030h]
        fcomp dword [F32_neg10_PlaySkateSounds]
        fnstsw ax
        sahf
        jae short .10
        push dword [byte ebx+028h]
        mov edx, 64h
        mov eax, 410h
        push dword [byte ebx+020h]
        call PlaySfxVolume
.10:
        fld dword [byte ebx+030h]
        fchs
        fmul qword [F64_0p25_PlaySkateSounds]
        fstp dword [byte ebx+030h]
        mov edx, dword [byte ebx+030h]
        mov dword [byte ebx+024h], 0
        cmp edx, 40800000h
        jge short .11
        mov dword [byte ebx+030h], 0
.11:
        fldz
        fcomp dword [byte ebx+024h]
        fnstsw ax
        sahf
        jae short .12
        fld dword [byte ebx+038h]
        fld st0
        fadd qword [F64_0p2_PlaySkateSounds]
        fstp st1
        fstp dword [byte ebx+038h]
.12:
        fld dword [byte ebx+038h]
        fadd qword [F64_neg0p2]
        fldz
        fxch
        fstp dword [byte ebx+038h]
        fcomp dword [byte ebx+038h]
        fnstsw ax
        sahf
        jbe short .13
        mov dword [byte ebx+038h], 0
.13:
        fld dword [byte ebx+02Ch]
        fld dword [byte ebx+034h]
        fadd dword [byte ebx+028h]
        fxch
        fadd dword [byte ebx+020h]
        fxch
        fstp dword [byte ebx+028h]
        fstp dword [byte ebx+020h]
        add esp, byte 18h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; MovePlayer                                      5E1B0  97 PC, low confidence
; Moves a player by its velocity for one frame
;-----------------------------------------------------------------------------
MovePlayer:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        call PlaySkateSounds
        cmp byte [dword ebx+0A4h], 0Ch
        ja short .5
        mov eax, ebx
        mov ecx, SortCords
        call PlayerCollisions
        xor esi, esi
.1:
        xor eax, eax
        mov al, byte [dword ebx+0A4h]
        cmp esi, eax
        je short .4
        mov eax, dword [dword ebx+0FAh]
        test byte [byte eax+030h], 20h
        jne short .2
        cmp dword [byte eax+024h], byte 0
        je short .3
.2:
        mov dh, byte [dword ecx+0A4h]
        cmp dh, byte [byte ebx+06Ch]
        je short .4
.3:
        mov edx, ecx
        mov eax, ebx
        call checkplcoll
.4:
        inc esi
        add ecx, 108h
        cmp esi, byte 0Ch
        jle short .1
.5:
        mov ax, word [byte ebx+0Eh]
        mov word [byte ebx+054h], ax
        mov eax, ebx
        call PuckHeightAt
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PuckOnStickPhysics                              5E224  97 PC, low confidence
; Keeps the puck on a skating player's stick
;-----------------------------------------------------------------------------
PuckOnStickPhysics:
        push ebx
        push ecx
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 4
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        mov eax, dword [dword eax+0FAh]
        mov eax, dword [byte eax+014h]
        mov bx, word [dword edx+0A9h]
        mov dword [esp], eax
        test bx, bx
        jne short .2
        mov dl, byte [dword edx+0A4h]
        mov eax, dword [PtrPuckZone]
        and edx, 0FFh
        movsx eax, byte [eax]
        cmp edx, eax
        jne short .1
        mov eax, 0F9h
        jmp near .47
.1:
        mov eax, 0B9h
        jmp near .47
.2:
        mov eax, dword [dword edx+0EEh]
        test byte [byte eax+028h], 80h
        je near .14
        test byte [byte eax+031h], 8
        je near .8
        fld dword [esp]
        fabs
        fcomp qword [F64_0p785398_PuckOnStickPhysics]
        fnstsw ax
        sahf
        jae short .4
        cmp byte [dword edx+0A4h], 0Ch
        jne short .3
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 137h
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov eax, 20h
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        cmp byte [dword edx+0D0h], 0
        setne al
        mov ebx, eax
        fldz
        and ebx, 0FFh
        fcomp dword [esp]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor eax, ebx
        je short .6
        cmp byte [dword edx+0A4h], 0Ch
        jne short .5
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 13Bh
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov eax, 1Bh
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        cmp byte [dword edx+0A4h], 0Ch
        jne short .7
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 139h
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        mov eax, 1Ah
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        fld dword [esp]
        fabs
        fcomp qword [F64_2p35619]
        fnstsw ax
        sahf
        jbe short .10
        cmp byte [dword edx+0A4h], 0Ch
        jne short .9
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 137h
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov eax, 20h
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        cmp byte [dword edx+0D0h], 0
        setne al
        mov ebx, eax
        fldz
        and ebx, 0FFh
        fcomp dword [esp]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor eax, ebx
        je short .12
        cmp byte [dword edx+0A4h], 0Ch
        jne short .11
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 139h
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        mov eax, 1Ah
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.12:
        cmp byte [dword edx+0A4h], 0Ch
        jne short .13
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 13Bh
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.13:
        mov eax, 1Bh
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.14:
        test byte [byte eax+031h], 8
        je near .29
        fld dword [esp]
        fabs
        fcomp qword [F64_2p35619]
        fnstsw ax
        sahf
        jbe near .19
        cmp byte [dword edx+0A4h], 0Ch
        jne short .15
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 119h
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.15:
        cmp word [dword edx+0A9h], byte 0
        jle short .16
        mov eax, dword [PtrPuckZone]
        xor ebx, ebx
        movsx eax, byte [eax]
        mov bl, byte [dword edx+0A4h]
        cmp ebx, eax
        je short .17
.16:
        mov eax, dword [dword edx+0AEh]
        sar eax, 18h
        cmp byte [dword edx+eax+0B2h], 0Eh
        je short .17
        mov eax, dword [dword edx+0EEh]
        test byte [byte eax+029h], 2
        je short .18
.17:
        mov eax, 3Bh
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.18:
        mov eax, 3
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.19:
        mov ah, byte [dword edx+0D0h]
        xor ebx, ebx
        test ah, ah
        setne al
        fldz
        mov bl, al
        fcomp dword [esp]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, ebx
        je near .24
        mov al, byte [dword edx+0A4h]
        cmp al, 0Ch
        jne short .20
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 11Bh
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.20:
        cmp word [dword edx+0A9h], byte 0
        jle short .21
        xor ebx, ebx
        mov bl, al
        mov eax, dword [PtrPuckZone]
        movsx eax, byte [eax]
        cmp ebx, eax
        je short .22
.21:
        mov eax, dword [dword edx+0AEh]
        sar eax, 18h
        cmp byte [dword edx+eax+0B2h], 0Eh
        je short .22
        mov eax, dword [dword edx+0EEh]
        test byte [byte eax+029h], 2
        je short .23
.22:
        mov eax, 3Ch
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.23:
        mov eax, 23h
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.24:
        cmp byte [dword edx+0A4h], 0Ch
        jne short .25
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 11Dh
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.25:
        cmp word [dword edx+0A9h], byte 0
        jle short .26
        mov eax, dword [PtrPuckZone]
        xor ebx, ebx
        movsx eax, byte [eax]
        mov bl, byte [dword edx+0A4h]
        cmp ebx, eax
        je short .27
.26:
        mov eax, dword [dword edx+0AEh]
        sar eax, 18h
        cmp byte [dword edx+eax+0B2h], 0Eh
        je short .27
        mov eax, dword [dword edx+0EEh]
        test byte [byte eax+029h], 2
        je short .28
.27:
        mov eax, 3Dh
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.28:
        mov eax, 24h
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.29:
        cmp byte [dword edx+0A4h], 0Ch
        je short .32
        mov eax, dword [dword edx+0F2h]
        cmp dword [byte eax+038h], byte 0
        jne short .32
        fld dword [esp]
        fabs
        fcomp qword [F64_0p785398_PuckOnStickPhysics]
        fnstsw ax
        sahf
        jae short .30
        mov eax, 119h
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.30:
        cmp byte [dword edx+0D0h], 0
        setne al
        xor edx, edx
        fldz
        mov dl, al
        fcomp dword [esp]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        je short .31
        mov eax, 11Dh
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.31:
        mov eax, 11Bh
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.32:
        fld dword [esp]
        fabs
        fcomp qword [F64_0p785398_PuckOnStickPhysics]
        fnstsw ax
        sahf
        jae near .37
        mov ch, byte [dword edx+0A4h]
        cmp ch, 0Ch
        jne short .33
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 119h
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.33:
        cmp word [dword edx+0A9h], byte 0
        jle short .34
        xor ebx, ebx
        mov eax, dword [PtrPuckZone]
        mov bl, ch
        movsx eax, byte [eax]
        cmp ebx, eax
        je short .35
.34:
        mov eax, dword [dword edx+0AEh]
        sar eax, 18h
        cmp byte [dword edx+eax+0B2h], 0Eh
        je short .35
        mov eax, dword [dword edx+0EEh]
        test byte [byte eax+029h], 2
        je short .36
.35:
        mov eax, 3Bh
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.36:
        mov eax, 3
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.37:
        cmp byte [dword edx+0D0h], 0
        setne al
        mov ebx, eax
        fldz
        and ebx, 0FFh
        fcomp dword [esp]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, ebx
        je near .42
        mov ch, byte [dword edx+0A4h]
        cmp ch, 0Ch
        jne short .38
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 11Dh
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.38:
        cmp word [dword edx+0A9h], byte 0
        jle short .39
        xor ebx, ebx
        mov eax, dword [PtrPuckZone]
        mov bl, ch
        movsx eax, byte [eax]
        cmp ebx, eax
        je short .40
.39:
        mov eax, dword [dword edx+0AEh]
        sar eax, 18h
        cmp byte [dword edx+eax+0B2h], 0Eh
        je short .40
        mov eax, dword [dword edx+0EEh]
        test byte [byte eax+029h], 2
        je short .41
.40:
        mov eax, 3Dh
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.41:
        mov eax, 24h
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.42:
        mov al, byte [dword edx+0A4h]
        cmp al, 0Ch
        jne short .43
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 11Bh
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.43:
        cmp word [dword edx+0A9h], byte 0
        jle short .44
        xor ebx, ebx
        mov bl, al
        mov eax, dword [PtrPuckZone]
        movsx eax, byte [eax]
        cmp ebx, eax
        je short .45
.44:
        mov eax, dword [dword edx+0AEh]
        sar eax, 18h
        cmp byte [dword edx+eax+0B2h], 0Eh
        je short .45
        mov eax, dword [dword edx+0EEh]
        test byte [byte eax+029h], 2
        je short .46
.45:
        mov eax, 3Ch
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.46:
        mov eax, 23h
.47:
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PuckOnStickFromState                            5E7D8  97 PC, low confidence
; Keeps the puck on the stick using the saved stick state
;-----------------------------------------------------------------------------
PuckOnStickFromState:
        push ebx
        push edx
        sub esp, byte 4
        call PuckOnStickPhysics
        mov ebx, dword [nosplit eax*4+MoveFuncPair]
        mov edx, eax
        xor eax, eax
        mov al, byte [byte ebx+0Dh]
        mov dword [esp], eax
        fild word [esp]
        mov eax, edx
        fmul dword [byte esp+010h]
        shl eax, 3
        fstp dword [byte esp+010h]
        sub eax, edx
        fld dword [byte esp+010h]
        fadd dword [nosplit eax*8+SkateStrideTable]
        fst dword [byte esp+010h]
        add esp, byte 4
        pop edx
        pop ebx
        ret 4
;-----------------------------------------------------------------------------
; StickHandleTarget                               5E81C  97 PC, low confidence
; Works out where the stick carries the puck
;-----------------------------------------------------------------------------
StickHandleTarget:
        push ebx
        push ecx
        push edx
        mov edx, eax
        mov cx, word [dword eax+0A9h]
        mov ebx, dword [dword eax+0FAh]
        test cx, cx
        jne short .2
        mov dl, byte [dword eax+0A4h]
        mov eax, dword [PtrPuckZone]
        and edx, 0FFh
        movsx eax, byte [eax]
        cmp edx, eax
        jne short .1
        mov eax, 0FAh
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov eax, 0C3h
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        mov eax, dword [dword eax+0EEh]
        test byte [byte eax+031h], 8
        je short .4
        cmp byte [dword edx+0A4h], 0Ch
        jne short .3
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 135h
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov eax, 13h
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        fldz
        fcomp dword [byte ebx+014h]
        fnstsw ax
        sahf
        seta al
        xor ebx, ebx
        mov ch, byte [dword edx+0D0h]
        mov bl, al
        test ch, ch
        setne al
        and eax, 0FFh
        xor eax, ebx
        je short .7
        cmp byte [dword edx+0A4h], 0Ch
        jne short .5
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 115h
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov eax, dword [dword edx+0F2h]
        cmp dword [byte eax+038h], byte 0
        je short .6
        mov eax, 0Fh
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        mov eax, 115h
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        cmp byte [dword edx+0A4h], 0Ch
        jne short .8
        test byte [dword edx+0C1h], 2
        setne al
        and eax, 0FFh
        add eax, 117h
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        mov eax, dword [dword edx+0F2h]
        cmp dword [byte eax+038h], byte 0
        je short .9
        mov eax, 10h
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov eax, 117h
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; StickHandleScaled                               5E934  97 PC, low confidence
; Stick handling with a scaled reach
;-----------------------------------------------------------------------------
StickHandleScaled:
        push ebx
        push ebp
        mov ebp, esp
        sub esp, byte 4
        and esp, byte 0FFFFFFF8h
        call StickHandleTarget
        mov ebx, eax
        shl eax, 3
        sub eax, ebx
        fld dword [byte ebp+0Ch]
        fdiv dword [nosplit eax*8+StrideSpeeds]
        fst dword [esp]
        fcomp dword [F32_0p5_StickHandleScaled]
        fnstsw ax
        sahf
        jae short .1
        mov dword [esp], 3F000000h
.1:
        fld dword [esp]
        fcomp qword [F64_1p1]
        fnstsw ax
        sahf
        jbe short .2
        mov dword [esp], 3F8CCCCDh
.2:
        lea eax, [nosplit ebx*8+00h]
        sub eax, ebx
        fld dword [esp]
        fmul dword [nosplit eax*8+SkateStrideTable]
        mov esp, ebp
        pop ebp
        pop ebx
        ret 4
;-----------------------------------------------------------------------------
; StickHandleSpeed                                5E998  97 PC, low confidence
; Stick handling speed factor for the player
;-----------------------------------------------------------------------------
StickHandleSpeed:
        push eax
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 4
        and esp, byte 0FFFFFFF8h
        mov edx, dword [byte ebp+014h]
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        fld dword [byte ebp+010h]
        fdiv dword [nosplit eax*8+StrideSpeeds]
        fst dword [esp]
        fcomp dword [F32_0p5_StickHandleSpeed]
        fnstsw ax
        sahf
        jae short .1
        mov dword [esp], 3F000000h
.1:
        fld dword [esp]
        fcomp qword [F64_1p1_StickHandleSpeed]
        fnstsw ax
        sahf
        jbe short .2
        mov dword [esp], 3F8CCCCDh
.2:
        fld dword [esp]
        mov esp, ebp
        pop ebp
        pop edx
        pop eax
        ret 8
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; IsSkateAnim                                     5E9F0  97 PC, low confidence
; Returns whether the current animation is a skating one
;-----------------------------------------------------------------------------
IsSkateAnim:
        cmp eax, byte 45h
        jne short .1
        cmp eax, byte 47h
        jne short .1
        mov eax, 1
        ret
.1:
        cmp eax, byte 62h
        jl short .2
        cmp eax, byte 63h
        jg short .2
        mov eax, 1
        ret
.2:
        cmp eax, byte 67h
        jl short .3
        cmp eax, 80h
        jg short .3
        mov eax, 1
        ret
.3:
        cmp eax, 84h
        jl short .4
        cmp eax, 87h
        jg short .4
        mov eax, 1
        ret
.4:
        cmp eax, 158h
        jle short .6
        cmp eax, 15Bh
        je short .5
        cmp eax, 15Fh
        je short .5
        cmp eax, 160h
        je short .5
        cmp eax, 167h
        je short .5
        cmp eax, 168h
        je short .5
        cmp eax, 16Fh
        je short .5
        cmp eax, 175h
        jne short .6
.5:
        mov eax, 1
        ret
.6:
        xor eax, eax
        ret
        db 090h
;-----------------------------------------------------------------------------
; IsStopAnim                                      5EA78  97 PC, low confidence
; Returns whether the current animation is a stop
;-----------------------------------------------------------------------------
IsStopAnim:
        cmp eax, byte 11h
        jl short .1
        cmp eax, byte 17h
        jg short .1
        mov eax, 1
        ret
.1:
        cmp eax, byte 1Ah
        je short .2
        cmp eax, byte 1Bh
        jne short .3
.2:
        mov eax, 1
        ret
.3:
        cmp eax, byte 20h
        jl short .4
        cmp eax, byte 22h
        jg short .4
        mov eax, 1
        ret
.4:
        cmp eax, 127h
        jl short .5
        cmp eax, 12Ah
        jg short .5
        mov eax, 1
        ret
.5:
        cmp eax, 12Fh
        jl short .6
        cmp eax, 142h
        jg short .6
        mov eax, 1
        ret
.6:
        cmp eax, 143h
        jne short .7
        mov eax, 1
        ret
.7:
        cmp eax, byte 38h
        jl short .8
        cmp eax, byte 3Ah
        jg short .8
        mov eax, 1
        ret
.8:
        cmp eax, 88h
        jne short .9
        mov eax, 1
        ret
.9:
        cmp eax, 95h
        je short .10
        cmp eax, 96h
        jne short .11
.10:
        mov eax, 1
        ret
.11:
        xor eax, eax
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StartCheckedAnim                                5EB14  97 PC, low confidence
; Starts an animation if the player may change animation
;-----------------------------------------------------------------------------
StartCheckedAnim:
        push ecx
        push esi
        push edi
        mov ecx, eax
        mov esi, edx
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov edi, dword [byte eax+028h]
        and edi, 0FFFFh
        mov edx, MoveState
        cmp esi, edi
        jne short .1
        test byte [byte eax+01Ch], 80h
        je near .15
.1:
        mov eax, dword [dword ecx+0FAh]
        mov edi, dword [byte esp+010h]
        mov dword [byte eax+038h], edi
        cmp dword [byte esp+018h], byte 0
        je short .2
        or byte [dword ecx+0BFh], 20h
        jmp short .3
.2:
        and byte [dword ecx+0BFh], 0DFh
.3:
        mov eax, dword [dword ecx+0FAh]
        and byte [byte eax+031h], 0FEh
        cmp esi, 17Dh
        jl short .4
        xor esi, esi
.4:
        mov eax, esi
        call IsSkateAnim
        test eax, eax
        je short .5
        mov eax, dword [dword ecx+0EEh]
        or byte [byte eax+031h], 1
        jmp short .6
.5:
        mov eax, dword [dword ecx+0EEh]
        and byte [byte eax+031h], 0FEh
.6:
        mov eax, esi
        call IsStopAnim
        test eax, eax
        je short .7
        mov eax, dword [dword ecx+0EEh]
        or byte [byte eax+031h], 8
        jmp short .8
.7:
        mov eax, dword [dword ecx+0EEh]
        and byte [byte eax+031h], 0F7h
.8:
        mov eax, dword [byte esp+014h]
        mov dword [byte edx+010h], eax
        mov eax, dword [nosplit esi*4+MoveFuncPair]
        mov al, byte [byte eax+0Dh]
        and eax, 0FFh
        cmp eax, dword [byte edx+010h]
        jg short .9
        mov dword [byte edx+010h], 0
.9:
        mov dword [edx], esi
        mov eax, dword [nosplit esi*4+MoveFuncPair]
        mov dword [byte edx+08h], eax
        mov dword [byte edx+04h], ecx
        mov eax, dword [byte esp+010h]
        mov dword [byte edx+018h], eax
        mov eax, dword [dword ecx+0F2h]
        fld dword [byte eax+03Ch]
        mov dword [byte edx+0Ch], 0
        fstp dword [byte edx+014h]
        mov eax, dword [nosplit esi*4+MoveFuncTable]
        mov dword [byte edx+024h], eax
        cmp byte [dword ecx+0D0h], 0
        je short .10
        or byte [byte edx+0Ch], 8
        jmp short .11
.10:
        and byte [byte edx+0Ch], 0F7h
.11:
        test ebx, ebx
        je short .12
        or dword [byte edx+0Ch], ebx
.12:
        test byte [gmode], 1
        je short .13
        mov ebx, 8
        jmp short .14
.13:
        mov ebx, 5
.14:
        mov eax, dword [dword ecx+0F6h]
        call ChangeAnim
.15:
        pop edi
        pop esi
        pop ecx
        ret 0Ch
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; StartNextMove                                   5EC50  97 PC, low confidence
; Starts the move that follows the current one
;-----------------------------------------------------------------------------
StartNextMove:
        push ecx
        push esi
        push edi
        mov ecx, eax
        mov esi, edx
        mov edi, dword [byte esp+018h]
        mov edx, MoveState
        test edi, edi
        je short .1
        mov al, byte [dword eax+0BFh]
        or al, 20h
        mov byte [dword ecx+0BFh], al
        jmp short .2
.1:
        mov ah, byte [dword eax+0BFh]
        and ah, 0DFh
        mov byte [dword ecx+0BFh], ah
.2:
        mov eax, esi
        call IsStopAnim
        test eax, eax
        je short .3
        mov eax, dword [dword ecx+0EEh]
        or byte [byte eax+031h], 8
        jmp short .4
.3:
        mov eax, dword [dword ecx+0EEh]
        and byte [byte eax+031h], 0F7h
.4:
        mov eax, esi
        call IsSkateAnim
        test eax, eax
        je short .5
        mov eax, dword [dword ecx+0EEh]
        or byte [byte eax+031h], 1
        jmp short .6
.5:
        mov eax, dword [dword ecx+0EEh]
        and byte [byte eax+031h], 0FEh
.6:
        mov eax, dword [byte esp+014h]
        mov dword [byte edx+010h], eax
        mov eax, dword [nosplit esi*4+MoveFuncPair]
        mov al, byte [byte eax+0Dh]
        and eax, 0FFh
        cmp eax, dword [byte edx+010h]
        jg short .7
        mov dword [byte edx+010h], 0
.7:
        cmp esi, 17Dh
        jl short .8
        xor esi, esi
.8:
        mov eax, dword [dword ecx+0FAh]
        mov edi, dword [byte esp+010h]
        mov dword [byte eax+038h], edi
        mov eax, dword [byte esp+014h]
        mov dword [byte edx+010h], eax
        mov eax, dword [nosplit esi*4+MoveFuncPair]
        mov al, byte [byte eax+0Dh]
        and eax, 0FFh
        cmp eax, dword [byte edx+010h]
        jg short .9
        mov dword [byte edx+010h], 0
.9:
        mov dword [edx], esi
        mov eax, dword [nosplit esi*4+MoveFuncPair]
        mov dword [byte edx+08h], eax
        mov dword [byte edx+04h], ecx
        mov eax, dword [byte esp+010h]
        mov dword [byte edx+018h], eax
        mov eax, dword [dword ecx+0F2h]
        fld dword [byte eax+03Ch]
        mov dword [byte edx+0Ch], 0
        fstp dword [byte edx+014h]
        mov eax, dword [nosplit esi*4+MoveFuncTable]
        mov dword [byte edx+024h], eax
        cmp byte [dword ecx+0D0h], 0
        je short .10
        or byte [byte edx+0Ch], 8
        jmp short .11
.10:
        and byte [byte edx+0Ch], 0F7h
.11:
        test ebx, ebx
        je short .12
        or dword [byte edx+0Ch], ebx
.12:
        mov eax, dword [dword ecx+0F6h]
        call StartAnimNow
        pop edi
        pop esi
        pop ecx
        ret 0Ch
