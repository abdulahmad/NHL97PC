; Goalie moves: cover, recover, idle, saves, stances and puck deflections.
bits 32
%include "hockey.inc"
section s_747E5 progbits alloc exec nowrite align=1
extern AdvanceMoveAnim, BodyPointId, DeflectAnims, F32_10_GoalieSave, F32_144_GoalieMoves, F32_240, F32_24_GoalieMoves, F32_2_GoalieMoves
extern F32_480_GoalieMoves, F32_672, F32_7p84727eneg44, F32_96_GoalieSave, F32_neg1_GoalieMoves, F64_0p0001_GoalieMoves, F64_0p349066_GoalieMoves, F64_0p6_GoalieMoves
extern F64_0p785398_GoalieSave, F64_144_GoalieMoves, F64_144_PickSaveAnim, F64_1p0472_GoalieSave, F64_240_GoalieMoves, F64_240_PickSaveAnim, F64_2832, F64_2_GoalieMoves
extern F64_384_GoalieSave, F64_3p14159_GoalieMoves, F64_3p14159_GoalieSave, F64_4272_GoalieMoves, F64_4272_GoalieSave, F64_48, F64_480_PuckDeflect, F64_48_GoalieMoves
extern F64_576_GoalieMoves, F64_6p28319_GoalieMoves, F64_6p28319_GoalieSave, F64_72, F64_72_GoalieSave, F64_neg0p785398_GoalieSave, F64_neg3p14159_GoalieMoves, F64_neg3p14159_GoalieSave
extern F64_neg6p28319_GoalieMoves, F64_neg6p28319_GoalieSave, GameSettings, GetAnimId, gmode, GoalieAnimData, GoalieAnimFiles, GoalieAnimFrame
extern GoalieAnimPoses, GoalieAnimTime, GoalieMoveLimit, GoalieMoveTable, GoaliePosTarget, hypot_, IF@ATAN2, IF@DFMOD
extern IsCameraOnPuck, MoveAnimIds, ObjectFramePos, onetimerplayer, OneTimerReady, PassReceiver, PeriodOver, PickSkateAnim
extern PlayerGetsPuck, PlaySfxVolume, PtrPuckFlags, PtrPuckOwner, PtrPuckTarget, puckc, PuckOwnerTeam, ReachScale
extern ResetAnimTimer, SetSPA, SortCords, StepMove, str_FADING, str_LOOP, str_MASTER, str_MIRROR
extern str_SCALED, str_SLAVE, VecDot, VecLength
global GoalieCoverMove, GoalieRecoverMove, GoalieIdleMove, StartGoalieSave, StartGoalieStance, PickSaveAnim, SaveDirection, goaliesave
global GoalieMoves, PuckDeflectAngle, PuckDeflect
%if VERSION = 11
extern F64_48_GoalieMoves2, GoalieMoveDist, GoalieTickCount
%endif
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; GoalieCoverMove                                 747E8  97 PC, low confidence
; Move handler for the goalie covering the puck
;-----------------------------------------------------------------------------
GoalieCoverMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov ecx, eax
        mov edi, dword [byte eax+028h]
        and edi, 0FFFFh
        mov esi, dword [byte eax+02Ch]
        cmp edi, 101h
        jne short .2
        cmp word [dword esi+0A9h], byte 0
        jne short .2
        mov ebx, dword [byte eax+04h]
        cmp ebx, byte 5
        je short .1
        cmp ebx, byte 1Dh
        je short .1
        cmp ebx, byte 35h
        je short .1
        cmp ebx, byte 50h
        je short .1
        cmp ebx, byte 6Eh
        je short .1
        cmp ebx, 8Ah
        jne near .7
.1:
        push dword [byte esi+028h]
        mov edx, 25h
        mov eax, 430h
        push dword [byte esi+020h]
        call PlaySfxVolume
        jmp short .7
.2:
        cmp edi, 0CCh
        jne short .3
        cmp dword [byte ecx+04h], byte 10h
        jne short .7
        push dword [byte esi+028h]
        mov edx, 64h
        mov eax, 409h
        push dword [byte esi+020h]
        call PlaySfxVolume
        jmp short .7
.3:
        cmp edi, 0CAh
        jne short .7
        mov edx, dword [byte ecx+04h]
        cmp edx, byte 0Fh
        je short .4
        cmp edx, byte 1Eh
        jne short .5
.4:
        call IsCameraOnPuck
        jmp short .7
.5:
        cmp edx, byte 13h
        je short .6
        cmp edx, byte 25h
        jne short .7
.6:
        call PeriodOver
.7:
        cmp edi, 0C5h
        jl near .10
        cmp edi, 0C8h
        jg near .10
        mov eax, ecx
        call GetAnimId
        test al, 2
        je near .10
        mov eax, dword [dword esi+0FAh]
        and byte [byte eax+031h], 0FDh
        mov eax, dword [dword esi+0FAh]
        or byte [byte eax+031h], 1
        test byte [gmode], 1
        je short .8
        mov eax, 0BB8h
        jmp short .9
.8:
        mov eax, 14h
.9:
        mov dword [byte esi+064h], eax
        xor edx, edx
        mov eax, dword [puckc]
        mov dl, byte [dword esi+0A4h]
        movsx ebx, byte [eax]
        cmp edx, ebx
        jne near .10
        mov byte [eax], 0FFh
        mov ebx, esp
        mov edx, dword [BodyPointId]
        mov eax, esi
        call ObjectFramePos
        mov edx, dword [PtrPuckFlags]
        mov eax, dword [esp]
        mov dword [dword edx+0D2h], eax
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [dword edx+0D2h]
        mov dword [byte eax+020h], ebx
        mov edx, dword [PtrPuckFlags]
        mov eax, dword [byte esp+04h]
        mov dword [dword edx+0D6h], eax
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [dword edx+0D6h]
        mov dword [byte eax+024h], ebx
        mov edx, dword [PtrPuckFlags]
        mov eax, dword [byte esp+08h]
        mov dword [dword edx+0DAh], eax
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [dword edx+0DAh]
        mov dword [byte eax+028h], ebx
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+034h], 0
        fld dword [byte eax+034h]
        mov eax, dword [PtrPuckFlags]
        fst dword [byte eax+030h]
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+02Ch]
        call IsCameraOnPuck
.10:
        test byte [byte ecx+01Ch], 80h
        je short .14
        cmp edi, 0C6h
        jl short .11
        cmp edi, 0C8h
        jg short .11
        mov eax, dword [dword esi+0FAh]
        and byte [byte eax+031h], 0FDh
        jmp short .13
.11:
        cmp edi, 0CAh
        je short .12
        cmp edi, 0C9h
        jne short .13
.12:
        mov eax, dword [dword esi+0FAh]
        mov edx, 0C8h
        call ResetAnimTimer
        xor ebx, ebx
        mov cl, byte [dword esi+0BFh]
        push dword 3F800000h
        and cl, 0DFh
        mov eax, esi
        mov byte [dword esi+0BFh], cl
        call SetSPA
        jmp short .15
.13:
        mov eax, esi
        call PickSkateAnim
        jmp short .15
.14:
        mov edx, esp
        mov eax, ecx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ecx
        call StepMove
.15:
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; GoalieRecoverMove                               74A20  97 PC, low confidence
; Move handler for the goalie getting up
;-----------------------------------------------------------------------------
GoalieRecoverMove:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 20h
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov ah, byte [byte eax+01Ch]
        and esi, 0FFFFh
        test ah, 80h
        je near .5
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jge near .2
        mov ebx, dword [PtrPuckFlags]
        fld dword [byte ebx+020h]
        fsub dword [byte ecx+020h]
        fstp dword [byte ebp-014h]
        fld dword [byte ebx+028h]
        fsub dword [byte ecx+028h]
        sub esp, byte 8
        fst dword [byte ebp-0Ch]
        fld dword [byte ebx+050h]
        fadd dword [byte ecx+050h]
        fxch
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte ebp-014h]
        fstp qword [esp]
        fstp qword [byte ebp-08h]
        call hypot_
        fcomp qword [byte ebp-08h]
        fnstsw ax
        sahf
        jae short .1
        mov eax, dword [puckc]
        mov dl, byte [dword ecx+0A4h]
        mov byte [eax], dl
        jmp short .2
.1:
        cmp byte [dword ecx+0D0h], 0
        setne al
        and eax, 0FFh
        lea ebx, [byte ebp-014h]
        mov edx, dword [nosplit eax*4+DeflectAnims]
        mov eax, ecx
        call ObjectFramePos
        mov edx, dword [PtrPuckFlags]
        fld dword [byte ebp-014h]
        fsub dword [byte edx+020h]
        fld dword [byte ebp-0Ch]
        fxch
        fstp dword [byte ebp-014h]
        fsub dword [byte edx+028h]
        sub esp, byte 8
        fst dword [byte ebp-0Ch]
        fld dword [byte edx+050h]
        fadd dword [byte ecx+050h]
        fxch
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte ebp-014h]
        fstp qword [esp]
        fstp qword [byte ebp-08h]
        call hypot_
        fcomp qword [byte ebp-08h]
        fnstsw ax
        sahf
        jae short .2
        mov edx, dword [puckc]
        mov al, byte [dword ecx+0A4h]
        mov byte [edx], al
.2:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov bl, byte [dword ecx+0BFh]
        or bl, 20h
        push dword 3F800000h
        mov byte [dword ecx+0BFh], bl
        mov ebx, 20h
        cmp esi, 105h
        jne short .3
        mov edx, 104h
        jmp short .4
.3:
        mov edx, 0E4h
.4:
        mov eax, ecx
        call SetSPA
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        lea edx, [byte ebp-020h]
        mov eax, ebx
        call AdvanceMoveAnim
        lea edx, [byte ebp-020h]
        mov eax, ebx
        call StepMove
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; GoalieIdleMove                                  74B74  97 PC, low confidence
; Move handler for the goalie idle
;-----------------------------------------------------------------------------
GoalieIdleMove:
        push ebx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov dl, byte [byte ebx+01Ch]
        mov eax, dword [byte eax+02Ch]
        test dl, 80h
        je short .1
        call PickSkateAnim
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
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StartGoalieSave                                 74BA8  97 PC, low confidence
; Starts a goalie save animation
;-----------------------------------------------------------------------------
StartGoalieSave:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov edx, dword [byte eax+028h]
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        and edx, 0FFFFh
        test ah, 20h
        jne near .7
        mov eax, dword [dword ecx+0EEh]
        test byte [byte eax+031h], 1
        jne near .7
        cmp edx, 105h
        jl short .1
        cmp edx, 106h
        jle near .7
.1:
        cmp edx, 0E4h
        je short .7
        cmp edx, 102h
        jl short .2
        cmp edx, 103h
        jle short .7
.2:
        cmp edx, 0EDh
        jl short .3
        cmp edx, 0F7h
        jle short .4
.3:
        cmp edx, 0A8h
        je short .4
        cmp edx, 9Fh
        jne short .5
.4:
        mov edx, 105h
        jmp short .6
.5:
        mov edx, 102h
.6:
        mov bh, byte [dword ecx+0BFh]
        or bh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        xor ebx, ebx
        push dword 3F800000h
        call SetSPA
.7:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StartGoalieStance                               74C64  97 PC, low confidence
; Starts a goalie stance animation
;-----------------------------------------------------------------------------
StartGoalieStance:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+028h]
        and eax, 0FFFFh
        cmp eax, 104h
        je short .1
        cmp eax, 105h
        jne short .2
.1:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov dl, byte [dword ecx+0BFh]
        xor ebx, ebx
        or dl, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], dl
        mov edx, 106h
        jmp short .4
.2:
        cmp eax, 0E4h
        je short .3
        cmp eax, 102h
        jne short .5
.3:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        mov edx, 103h
        or ah, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
.4:
        push dword 3F800000h
        call SetSPA
.5:
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PickSaveAnim                                    74CEC  97 PC, low confidence
; Picks the goalie save animation from the shot
;-----------------------------------------------------------------------------
PickSaveAnim:
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 50h
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov ecx, edx
        mov edx, dword [PtrPuckFlags]
        fld dword [byte edx+020h]
        fld dword [byte edx+028h]
        fsub dword [byte eax+028h]
        fxch
        fsub dword [byte eax+020h]
        mov eax, dword [byte edx+02Ch]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte edx+034h]
        fstp dword [byte esp+028h]
        mov dword [byte esp+03Ch], eax
        mov ah, byte [dword esi+0BFh]
        fstp dword [byte esp+024h]
        test ah, 80h
        je short .1
        mov dword [byte esp+018h], 0FFFFEF50h
        jmp short .2
.1:
        mov dword [byte esp+018h], 10B0h
.2:
        fild dword [byte esp+018h]
        mov al, byte [gmode]
        fstp dword [byte esp+038h]
        test al, 1
        je short .3
        mov dword [byte esp+048h], 0BF800000h
        jmp near .16
.3:
        fldz
        fcomp dword [byte edx+028h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        fldz
        mov dword [byte esp+010h], eax
        fcomp dword [byte esp+038h]
        fnstsw ax
        sahf
        setb al
        mov edi, dword [byte esp+010h]
        and eax, 0FFh
        xor eax, edi
        je short .4
        mov dword [byte esp+048h], 0BF800000h
        fld dword [byte esp+048h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.4:
        fldz
        fcomp dword [byte esp+03Ch]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        fldz
        mov dword [byte esp+014h], eax
        fcomp dword [byte esp+038h]
        fnstsw ax
        sahf
        setb al
        mov edi, dword [byte esp+014h]
        and eax, 0FFh
        xor eax, edi
        je short .5
        mov dword [byte esp+048h], 0BF800000h
        fld dword [byte esp+048h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.5:
        test dword [byte esp+03Ch], 7FFFFFFFh
        jne short .6
        mov dword [byte esp+048h], 0BF800000h
        fld dword [byte esp+048h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.6:
        fld dword [byte esp+038h]
        fsub dword [byte edx+028h]
        fdiv dword [byte esp+03Ch]
        fldz
        fxch
        fstp dword [byte esp+030h]
        fcomp dword [byte esp+030h]
        fnstsw ax
        sahf
        jbe short .7
        mov dword [byte esp+048h], 0BF800000h
        fld dword [byte esp+048h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.7:
        fld dword [byte esp+030h]
        fmul dword [byte esp+0Ch]
        fadd dword [byte edx+020h]
        fabs
        fcomp qword [F64_240_PickSaveAnim]
        fnstsw ax
        sahf
        jbe short .8
        mov dword [byte esp+048h], 0BF800000h
        fld dword [byte esp+048h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.8:
        fld dword [byte esi+01Ch]
        lea edi, [byte esp+08h]
        fchs
        mov esi, esp
        lea eax, [byte esp+04h]
        fstp dword [byte esp+04h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte esp+028h]
        fld st0
        fmul dword [byte esp+08h]
        fld dword [byte edx+02Ch]
        fmul dword [byte esp+08h]
        fxch st2
        fchs
        fmul dword [esp]
        fld dword [byte edx+02Ch]
        fchs
        fmul dword [esp]
        fld dword [byte esp+024h]
        fld st0
        fmul dword [esp]
        fld dword [byte edx+034h]
        fmul dword [esp]
        fxch
        faddp st5
        fxch
        fmul dword [byte esp+08h]
        fxch st4
        fstp dword [byte esp+04Ch]
        fld dword [byte edx+034h]
        fxch
        faddp st5
        fmul dword [byte esp+08h]
        fxch st4
        fstp dword [byte esp+020h]
        faddp st3
        faddp
        fxch
        fstp dword [byte esp+02Ch]
        mov edx, dword [byte esp+02Ch]
        fstp dword [byte esp+01Ch]
        test edx, 7FFFFFFFh
        jne short .9
        mov dword [byte esp+048h], 0BF800000h
        fld dword [byte esp+048h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.9:
        fld dword [byte esp+01Ch]
        fchs
        fdiv dword [byte esp+02Ch]
        fldz
        fxch
        fstp dword [byte esp+034h]
        fcomp dword [byte esp+034h]
        fnstsw ax
        sahf
        jbe short .10
        mov dword [byte esp+048h], 0BF800000h
        fld dword [byte esp+048h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.10:
        fld dword [byte esp+034h]
        fmul dword [byte esp+020h]
        fadd dword [byte esp+04Ch]
        fst dword [byte esp+04Ch]
        fabs
        fst qword [byte esp+040h]
        fcomp qword [F64_72]
        fnstsw ax
        sahf
        jae short .11
        mov dword [ecx], 0
        jmp short .15
.11:
        fld qword [byte esp+040h]
        fcomp qword [F64_144_PickSaveAnim]
        fnstsw ax
        sahf
        jae short .13
        fldz
        fcomp dword [byte esp+04Ch]
        fnstsw ax
        sahf
        jae short .12
        mov dword [ecx], 3F490FDBh
        jmp short .15
.12:
        mov dword [ecx], 0BF490FDBh
        jmp short .15
.13:
        fldz
        fcomp dword [byte esp+04Ch]
        fnstsw ax
        sahf
        jae short .14
        mov dword [ecx], 3FC90FDBh
        jmp short .15
.14:
        mov dword [ecx], 0BFC90FDBh
.15:
        mov eax, dword [byte esp+04Ch]
        mov dword [ebx], eax
        mov eax, dword [byte esp+034h]
        mov dword [byte esp+048h], eax
.16:
        fld dword [byte esp+048h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; SaveDirection                                   74FA4  97 PC, low confidence
; Works out the direction of a save
;-----------------------------------------------------------------------------
SaveDirection:
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        and esp, byte 0FFFFFFF8h
        mov edi, eax
        mov esi, edx
        mov eax, edx
        call VecDot
        fstp dword [byte esp+04h]
        cmp dword [byte esp+04h], 3F800000h
        jge short .1
        mov eax, dword [esi]
        mov dword [ebx], eax
        fld dword [ebx]
        mov eax, dword [byte esi+04h]
        mov dword [byte ebx+04h], eax
        mov eax, dword [byte esi+08h]
        mov dword [byte ebx+08h], eax
        fsub dword [edi]
        fstp dword [ecx]
        fld dword [byte ebx+04h]
        fsub dword [byte edi+04h]
        fstp dword [byte ecx+04h]
        fld dword [byte ebx+08h]
        mov ebx, 0BF800000h
        jmp short .4
.1:
        mov edx, esi
        mov eax, edi
        call VecDot
        fdiv dword [byte esp+04h]
        fldz
        fxch
        fstp dword [esp]
        fcomp dword [esp]
        fnstsw ax
        sahf
        jbe short .2
        mov eax, dword [esi]
        mov dword [ebx], eax
        fld dword [ebx]
        mov eax, dword [byte esi+04h]
        mov dword [byte ebx+04h], eax
        mov eax, dword [byte esi+08h]
        mov dword [byte ebx+08h], eax
        jmp short .3
.2:
        fld dword [esi]
        fmul dword [esp]
        fstp dword [ebx]
        fld dword [byte esi+04h]
        fmul dword [esp]
        fstp dword [byte ebx+04h]
        fld dword [byte esi+08h]
        fmul dword [esp]
        fld dword [ebx]
        fxch
        fstp dword [byte ebx+08h]
.3:
        fsub dword [edi]
        fstp dword [ecx]
        fld dword [byte ebx+04h]
        fsub dword [byte edi+04h]
        fstp dword [byte ecx+04h]
        fld dword [byte ebx+08h]
        mov ebx, dword [esp]
.4:
        fsub dword [byte edi+08h]
        mov dword [byte esp+08h], ebx
        fstp dword [byte ecx+08h]
        fld dword [byte esp+08h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; goaliesave                                      75068  97 PC, low confidence
; Goalie save: picks the save and starts it
;-----------------------------------------------------------------------------
goaliesave:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 68h
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov eax, dword [puckc]
        mov dl, byte [eax]
        mov ecx, dword [PtrPuckFlags]
        test dl, dl
        jge near .15
        call ReachScale
        fcomp dword [byte ecx+038h]
        fnstsw ax
        sahf
        jae near .1
        cmp word [onetimerplayer], byte 0
        jl near .1
        mov edx, dword [PassReceiver]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        mov edi, SortCords
        add eax, edx
        lea ebx, [byte esp+08h]
        shl eax, 3
        lea edx, [byte esp+0Ch]
        add edi, eax
        mov eax, esi
        call PickSaveAnim
        fldz
        fcompp
        fnstsw ax
        sahf
        jbe near .1
        mov eax, dword [byte edi+028h]
        mov bx, word [OneTimerReady]
        mov dword [byte esp+064h], eax
        test bx, bx
        je near .1
        cmp word [onetimerplayer], byte 0
        jl near .1
        mov edx, dword [byte ecx+060h]
        test edx, edx
        jle near .1
        cmp edx, byte 1Eh
        jge near .1
        cmp byte [dword esi+0A4h], 6
        setb al
        xor edx, edx
        mov bx, word [onetimerplayer]
        mov dl, al
        cmp bx, byte 6
        setl al
        and eax, 0FFh
        xor eax, edx
        je near .1
        fldz
        fldz
        xor edx, edx
        fxch
        fcomp dword [byte esi+028h]
        fnstsw ax
        sahf
        seta al
        mov dl, al
        fcomp dword [byte esp+064h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        je near .1
        fld dword [byte esp+064h]
        fabs
        fst qword [byte esp+030h]
        fcomp qword [F64_4272_GoalieSave]
        fnstsw ax
        sahf
        ja near .1
        fld qword [byte esp+030h]
        fcomp qword [F64_2832]
        fnstsw ax
        sahf
        jbe near .1
        fld dword [byte esi+020h]
        fabs
        fcomp qword [F64_72_GoalieSave]
        fnstsw ax
        sahf
        jbe near .1
        fld dword [byte edi+02Ch]
        fild dword [byte ecx+060h]
        fstp dword [byte esp+014h]
        fmul dword [byte esp+014h]
        fldz
        fxch
        fadd dword [byte edi+020h]
        xor edx, edx
        fldz
        fcompp
        fnstsw ax
        sahf
        setb al
        mov dl, al
        fcomp dword [byte esi+020h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        je near .1
        cmp byte [dword esi+0D0h], 0
        setne al
        xor edx, edx
        mov bh, byte [dword esi+0BFh]
        mov dl, al
        test bh, 80h
        setne al
        and eax, 0FFh
        fldz
        xor edx, eax
        fcomp dword [byte esi+020h]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor eax, edx
        setne al
        xor edx, edx
        mov dl, al
        add edx, byte 12h
        shl edx, 2
        fld dword [dword edx+GoalieAnimData]
        fadd dword [F32_10_GoalieSave]
        fcomp dword [byte esp+014h]
        fnstsw ax
        sahf
        jbe short .1
        mov eax, dword [dword esi+0FAh]
        call ResetAnimTimer
        mov cl, byte [dword esi+0BFh]
        or cl, 20h
        xor ebx, ebx
        mov byte [dword esi+0BFh], cl
        mov eax, esi
        mov edx, dword [dword edx+MoveAnimIds]
        push dword 3F19999Ah
        call SetSPA
        mov eax, 1
        jmp near .16
.1:
        cmp dword [byte ecx+038h], 41400000h
        jg near .15
        cmp dword [byte ecx+024h], 41800000h
        jge near .12
        fldz
        fcomp dword [byte ecx+030h]
        fnstsw ax
        sahf
        jb near .12
        fld dword [byte ecx+028h]
        fsub dword [byte esi+028h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte ecx+020h]
        fsub dword [byte esi+020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fld dword [byte ecx+020h]
        fsub dword [byte esi+020h]
        fld dword [byte ecx+028h]
        fsub dword [byte esi+028h]
        fxch
        call IF@ATAN2
        fsub dword [byte esi+01Ch]
        fld qword [F64_6p28319_GoalieSave]
        fxch
        call IF@DFMOD
        fxch
        fstp dword [byte esp+018h]
        fst dword [byte esp+058h]
        fst qword [byte esp+028h]
        fcomp qword [F64_3p14159_GoalieSave]
        fnstsw ax
        sahf
        jbe short .2
        fld qword [byte esp+028h]
        fadd qword [F64_neg6p28319_GoalieSave]
        fstp dword [byte esp+058h]
.2:
        fld dword [byte esp+058h]
        fst qword [byte esp+040h]
        fcomp qword [F64_neg3p14159_GoalieSave]
        fnstsw ax
        sahf
        jae short .3
        fld qword [byte esp+040h]
        fadd qword [F64_6p28319_GoalieSave]
        fstp dword [byte esp+058h]
.3:
        fld dword [byte esp+018h]
        fcomp dword [F32_96_GoalieSave]
        fnstsw ax
        sahf
        jb short .4
        fld dword [byte esp+018h]
        fcomp dword [F32_240]
        fnstsw ax
        sahf
        jae near .12
        fld dword [byte esp+058h]
        fabs
        fcomp qword [F64_1p0472_GoalieSave]
        fnstsw ax
        sahf
        jae near .12
.4:
        fld dword [byte esp+018h]
        fcomp dword [F32_96_GoalieSave]
        fnstsw ax
        sahf
        jb near .11
        fldz
        lea edx, [byte esi+01Ch]
        fcomp dword [byte esp+058h]
        fnstsw ax
        sahf
        ja short .7
        fld dword [byte esp+058h]
        fst qword [byte esp+048h]
        fcomp qword [F64_0p785398_GoalieSave]
        fnstsw ax
        sahf
        jbe short .5
        mov edi, 5A7ED197h
        mov eax, 3FE921FBh
        mov dword [byte esp+020h], edi
        jmp short .6
.5:
        mov eax, dword [byte esp+048h]
        mov dword [byte esp+020h], eax
        mov eax, dword [byte esp+04Ch]
.6:
        mov dword [byte esp+024h], eax
        fld dword [edx]
        fld st0
        fadd qword [byte esp+020h]
        jmp short .10
.7:
        fld dword [byte esp+058h]
        fst qword [byte esp+038h]
        fcomp qword [F64_neg0p785398_GoalieSave]
        fnstsw ax
        sahf
        jae short .8
        mov ebx, 5A7ED197h
        mov ecx, 0BFE921FBh
        mov dword [byte esp+050h], ebx
        mov dword [byte esp+054h], ecx
        jmp short .9
.8:
        mov eax, dword [byte esp+038h]
        mov dword [byte esp+050h], eax
        mov eax, dword [byte esp+03Ch]
        mov dword [byte esp+054h], eax
.9:
        fld dword [edx]
        fld st0
        fadd qword [byte esp+050h]
.10:
        fstp st1
        fstp dword [edx]
.11:
        mov eax, esi
        call StartGoalieSave
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.12:
        fld dword [byte ecx+020h]
        fabs
        fcomp qword [F64_384_GoalieSave]
        fnstsw ax
        sahf
        ja near .15
        mov ebx, 0B4h
        mov edx, 3Ch
.13:
        fld dword [dword edx+GoalieAnimData]
        fmul dword [byte ecx+02Ch]
        fld dword [byte esi+020h]
        fadd dword [dword ebx+GoalieAnimTime]
        fxch
        fadd dword [byte ecx+020h]
        fld st0
        fsub st2
        fstp st1
        fabs
        fld dword [dword edx+GoalieAnimData]
        fmul dword [byte ecx+030h]
        fld dword [dword edx+GoalieAnimData]
        fmul dword [byte ecx+034h]
        fxch
        fadd dword [byte ecx+024h]
        fxch
        fadd dword [byte ecx+028h]
        fxch
        fsub st3
        fxch
        fsubrp st3
        fstp dword [byte esp+05Ch]
        fxch
        fstp dword [byte esp+060h]
        fcomp qword [F64_48]
        fnstsw ax
        sahf
        jae short .14
        fld dword [byte esp+05Ch]
        fabs
        fcomp qword [F64_48]
        fnstsw ax
        sahf
        jae short .14
        fld dword [byte esp+060h]
        fabs
        fcomp qword [F64_48]
        fnstsw ax
        sahf
        jae short .14
        mov eax, dword [dword esi+0FAh]
        call ResetAnimTimer
        mov ch, byte [dword esi+0BFh]
        or ch, 20h
        xor ebx, ebx
        mov byte [dword esi+0BFh], ch
        mov eax, esi
        mov edx, dword [dword edx+MoveAnimIds]
        push dword 3F19999Ah
        call SetSPA
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.14:
        add edx, byte 4
        add ebx, byte 0Ch
        cmp edx, byte 48h
        jl near .13
.15:
        xor eax, eax
.16:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
%if VERSION = 11
;-----------------------------------------------------------------------------
; GoalieMoves                                     75AF0  97 PC, low confidence
; Goalie movement and saves
;-----------------------------------------------------------------------------
GoalieMoves:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 0B4h
        sub ebp, 82h
        mov dword [byte ebp+07Ah], eax
        test byte [dword eax+0BFh], 80h
        je short .1
        mov dword [byte ebp+042h], 0FFFFEF50h
        jmp short .2
.1:
        mov dword [byte ebp+042h], 10B0h
.2:
        fild dword [byte ebp+042h]
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [PtrPuckOwner]
        mov dword [byte ebp+04Eh], eax
        mov eax, dword [byte eax+02Ch]
        mov edx, dword [PtrPuckTarget]
        mov dword [byte ebp+032h], eax
        mov eax, dword [byte ebp+04Eh]
        movsx ebx, word [ebx]
        mov eax, dword [byte eax+034h]
        movsx edx, word [edx]
        mov dword [byte ebp+046h], eax
        mov eax, dword [byte ebp+07Ah]
        fstp dword [byte ebp+04Ah]
        call GoaliePosTarget
        mov eax, dword [byte ebp+07Ah]
        test byte [dword eax+0BFh], 20h
        jne near .26
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+028h]
        and eax, 0FFFFh
        mov dword [byte ebp+07Eh], eax
        cmp eax, 0FBh
        jl short .3
        cmp eax, 0FFh
        jg short .3
        mov eax, dword [byte ebp+07Ah]
        cmp byte [dword eax+0A4h], 6
        setb al
        xor edx, edx
        mov bx, word [PuckOwnerTeam]
        mov dl, al
        cmp bx, byte 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        je near .26
.3:
        test byte [gmode], 1
        jne near .26
        mov eax, dword [puckc]
        mov cl, byte [eax]
        test cl, cl
        jl short .4
        mov edx, dword [byte ebp+07Ah]
        cmp byte [dword edx+0A4h], 6
        setb dl
        and edx, 0FFh
        cmp cl, 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        je near .26
.4:
        fldz
        mov eax, dword [byte ebp+04Eh]
        fldz
        xor edx, edx
        fxch
        fcomp dword [byte eax+028h]
        fnstsw ax
        sahf
        setb al
        mov dl, al
        fcomp dword [byte ebp+04Ah]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        jne near .26
        mov eax, dword [byte ebp+07Ah]
        call goaliesave
        test eax, eax
        jne near .26
        fldz
        fldz
        xor edx, edx
        fxch
        fcomp dword [byte ebp+046h]
        fnstsw ax
        sahf
        setb al
        mov dl, al
        fcomp dword [byte ebp+04Ah]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        jne near .26
        fld dword [byte ebp+046h]
        fabs
        fcomp qword [F64_0p0001_GoalieMoves]
        fnstsw ax
        sahf
        jbe short .5
        mov eax, dword [byte ebp+04Eh]
        fld dword [byte ebp+04Ah]
        fsub dword [byte eax+028h]
        fdiv dword [byte ebp+046h]
        fldz
        fxch
        fstp dword [byte ebp+03Ah]
        fcomp dword [byte ebp+03Ah]
        fnstsw ax
        sahf
        ja near .26
        fld dword [byte ebp+03Ah]
        fmul dword [byte ebp+032h]
        mov eax, dword [byte ebp+04Eh]
        fadd dword [byte eax+020h]
        fabs
        fcomp qword [F64_240_GoalieMoves]
        fnstsw ax
        sahf
        jmp short .7
.5:
        mov eax, dword [byte ebp+04Eh]
        cmp dword [byte eax+038h], 41400000h
        jle short .6
        fld dword [byte eax+028h]
        mov eax, dword [byte ebp+07Ah]
        fsub dword [byte eax+028h]
        fabs
        fcomp qword [F64_144_GoalieMoves]
        fnstsw ax
        sahf
        ja near .26
.6:
        mov eax, dword [byte ebp+04Eh]
        fld dword [byte eax+028h]
        mov eax, dword [byte ebp+07Ah]
        sub esp, byte 8
        fsub dword [byte eax+028h]
        mov eax, dword [byte ebp+04Eh]
        fstp qword [esp]
        fld dword [byte eax+020h]
        mov eax, dword [byte ebp+07Ah]
        fsub dword [byte eax+020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_576_GoalieMoves]
        fnstsw ax
        sahf
        ja near .26
        mov eax, dword [byte ebp+04Eh]
        fld dword [byte eax+028h]
        fabs
        fcomp qword [F64_4272_GoalieMoves]
        fnstsw ax
        sahf
.7:
        ja near .26
        mov eax, dword [byte ebp+07Ah]
        mov edx, dword [PtrPuckFlags]
        fld dword [byte eax+020h]
        fsub dword [byte edx+020h]
        fstp dword [byte ebp-032h]
        fld dword [byte edx+024h]
        fchs
        mov eax, dword [byte ebp+07Ah]
        fstp dword [byte ebp-02Eh]
        fld dword [byte eax+028h]
        fsub dword [byte edx+028h]
        fstp dword [byte ebp-02Ah]
        mov eax, dword [byte edx+02Ch]
        mov dword [byte ebp-026h], eax
        mov eax, dword [byte edx+030h]
        lea ecx, [byte ebp-01Ah]
        mov dword [byte ebp-022h], eax
        lea ebx, [byte ebp-0Eh]
        mov eax, dword [byte edx+034h]
        lea edx, [byte ebp-026h]
        mov dword [byte ebp-01Eh], eax
        lea eax, [byte ebp-032h]
        call SaveDirection
        fld1
        fxch
        fstp dword [byte ebp+05Ah]
        mov eax, 1
        fadd dword [GoalieTickCount]
        mov dword [byte ebp+036h], eax
        fcomp dword [byte ebp+05Ah]
        fnstsw ax
        sahf
        jb near .26
        mov eax, dword [byte ebp+07Ah]
        lea edi, [byte ebp+026h]
        lea esi, [byte ebp+02Ah]
        fld dword [byte eax+01Ch]
        fchs
        lea eax, [byte ebp+02Eh]
        fstp dword [byte ebp+02Eh]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte ebp-012h]
        mov eax, dword [byte ebp-016h]
        fmul dword [byte ebp+026h]
        mov dword [byte ebp+05Eh], eax
        fld dword [byte ebp-01Ah]
        fchs
        mov eax, dword [byte ebp+04Eh]
        fld dword [byte eax+020h]
        mov eax, dword [byte ebp+07Ah]
        fsub dword [byte eax+020h]
        mov eax, dword [byte ebp+04Eh]
        fld dword [byte eax+028h]
        mov eax, dword [byte ebp+07Ah]
        fsub dword [byte eax+028h]
        fxch
        call IF@ATAN2
        mov eax, dword [byte ebp+07Ah]
        fsub dword [byte eax+01Ch]
        fld qword [F64_6p28319_GoalieMoves]
        fxch
        call IF@DFMOD
        fld dword [byte ebp-012h]
        fmul dword [byte ebp+02Ah]
        fld dword [byte ebp-01Ah]
        fmul dword [byte ebp+026h]
        fxch st3
        fmul dword [byte ebp+02Ah]
        fxch st3
        faddp
        fxch st2
        faddp st3
        fxch
        fstp dword [byte ebp+06Ah]
        fxch
        fstp dword [byte ebp+066h]
        fst dword [byte ebp+02Eh]
        fst qword [byte ebp+06h]
        fcomp qword [F64_3p14159_GoalieMoves]
        fnstsw ax
        sahf
        jbe short .8
        fld qword [byte ebp+06h]
        fadd qword [F64_neg6p28319_GoalieMoves]
        fstp dword [byte ebp+02Eh]
.8:
        fld dword [byte ebp+02Eh]
        fst qword [byte ebp+0Eh]
        fcomp qword [F64_neg3p14159_GoalieMoves]
        fnstsw ax
        sahf
        jae short .9
        fld qword [byte ebp+0Eh]
        fadd qword [F64_6p28319_GoalieMoves]
        fstp dword [byte ebp+02Eh]
.9:
        fld dword [byte ebp+02Eh]
        fabs
        fcomp qword [F64_0p349066_GoalieMoves]
        fnstsw ax
        sahf
        jae near .13
        sub esp, byte 8
        fld dword [byte ebp+066h]
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte ebp+06Ah]
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_48_GoalieMoves2]
        fnstsw ax
        sahf
        jae near .13
        fld dword [byte ebp+05Eh]
        fcomp dword [F32_144_GoalieMoves]
        fnstsw ax
        sahf
        jbe short .10
        mov esi, 1
        jmp short .27
.10:
        fld dword [byte ebp+05Eh]
        fcomp dword [F32_24_GoalieMoves]
        fnstsw ax
        sahf
        jae short .11
        mov esi, 14h
        jmp short .27
.11:
        xor esi, esi
.27:
        lea eax, [dword esi*4+00h]
        sub eax, esi
        lea edx, [dword eax*4+00h]
        fld dword [dword edx+GoalieAnimFrame]
        fsub dword [byte ebp+05Eh]
        fabs
        fmul qword [F64_2_GoalieMoves]
        sub esp, byte 8
        fld dword [dword edx+GoalieAnimPoses]
        fsub dword [byte ebp+066h]
        mov eax, dword [byte ebp+07Ah]
        fstp qword [esp]
        mov bh, byte [dword eax+0D0h]
        fstp qword [byte ebp-02h]
        test bh, bh
        je short .28
        fld dword [dword edx+GoalieAnimTime]
        fchs
        fstp dword [byte ebp+03Eh]
        jmp short .29
.28:
        mov eax, dword [dword edx+GoalieAnimTime]
        mov dword [byte ebp+03Eh], eax
.29:
        fld dword [byte ebp+03Eh]
        fsub dword [byte ebp+06Ah]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fadd qword [byte ebp-02h]
        fst dword [dword esi*4+GoalieMoveDist]
        fstp dword [byte ebp+06Eh]
        jmp near .22
.13:
        mov edx, 47C35000h
        xor esi, esi
        xor ebx, ebx
        mov dword [byte ebp+062h], edx
        mov dword [byte ebp+06Eh], edx
        mov dword [byte ebp+07Eh], esi
        xor edx, edx
        xor cl, cl
.14:
        mov edi, dword [byte ebp+07Eh]
        cmp edi, byte 0Fh
        jl short .15
        cmp edi, byte 13h
        jg short .15
        mov eax, dword [puckc]
        cmp cl, byte [eax]
        jle near .21
.15:
        fld dword [dword edx+GoalieAnimFrame]
        fsub dword [byte ebp+05Eh]
        fabs
        fmul qword [F64_2_GoalieMoves]
        sub esp, byte 8
        fld dword [dword edx+GoalieAnimPoses]
        fsub dword [byte ebp+066h]
        mov eax, dword [byte ebp+07Ah]
        fstp qword [esp]
        mov ch, byte [dword eax+0D0h]
        fstp qword [byte ebp+016h]
        cmp cl, ch
        je short .16
        fld dword [dword edx+GoalieAnimTime]
        fchs
        fstp dword [byte ebp+076h]
        jmp short .30
.16:
        mov eax, dword [dword edx+GoalieAnimTime]
        mov dword [byte ebp+076h], eax
.30:
        fld dword [byte ebp+076h]
        fsub dword [byte ebp+06Ah]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fadd qword [byte ebp+016h]
        fst dword [dword ebx+GoalieMoveDist]
        fcomp dword [byte ebp+06Eh]
        fnstsw ax
        sahf
        ja short .20
        mov eax, dword [dword ebx+GoalieMoveDist]
        mov dword [byte ebp+06Eh], eax
        mov eax, dword [byte ebp+07Ah]
        mov ch, byte [dword eax+0D0h]
        mov esi, dword [byte ebp+07Eh]
        cmp cl, ch
        je short .18
        fld dword [dword edx+GoalieAnimTime]
        fchs
        fstp dword [byte ebp+072h]
        jmp short .31
.18:
        mov eax, dword [dword edx+GoalieAnimTime]
        mov dword [byte ebp+072h], eax
.31:
        fld dword [byte ebp+06Ah]
        fld dword [byte ebp+066h]
        fsub dword [dword edx+GoalieAnimPoses]
        fxch
        fsub dword [byte ebp+072h]
        fxch
        fstp dword [byte ebp+052h]
        fstp dword [byte ebp+056h]
.20:
        fld dword [dword ebx+GoalieMoveDist]
        fcomp dword [byte ebp+062h]
        fnstsw ax
        sahf
        ja short .21
        fld dword [dword ebx+GoalieAnimData]
        fadd dword [F32_neg1_GoalieMoves]
        fcomp dword [byte ebp+05Ah]
        fnstsw ax
        sahf
        jae short .21
        mov eax, dword [dword ebx+GoalieMoveDist]
        mov dword [byte ebp+062h], eax
.21:
        mov edi, dword [byte ebp+07Eh]
        add ebx, byte 4
        inc edi
        add edx, byte 0Ch
        mov dword [byte ebp+07Eh], edi
        cmp edi, byte 15h
        jl near .14
.22:
        fld dword [byte ebp+05Ah]
        fsub dword [dword esi*4+GoalieAnimData]
        mov edx, dword [byte ebp+07Eh]
        fstp dword [byte ebp+02Eh]
        cmp edx, byte 5
        jl short .23
        cmp edx, byte 7
        jg short .23
        fld dword [byte ebp+02Eh]
        fadd dword [F32_2_GoalieMoves]
        fstp dword [byte ebp+02Eh]
.23:
        fild dword [byte ebp+036h]
        fcomp dword [byte ebp+02Eh]
        fnstsw ax
        sahf
        jbe near .26
        fld dword [byte ebp+06Eh]
        fcomp dword [F32_480_GoalieMoves]
        fnstsw ax
        sahf
        jae near .26
        mov eax, dword [byte ebp+07Ah]
        mov eax, dword [dword eax+0FAh]
        call ResetAnimTimer
        lea eax, [dword esi*4+00h]
        cmp dword [dword eax+GoalieAnimFiles], byte 1
        jle near .25
        fld dword [byte ebp+052h]
        sub esp, byte 8
        fild dword [dword eax+GoalieAnimFiles]
        fxch
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte ebp+056h]
        fstp qword [esp]
        fstp qword [byte ebp+01Eh]
        call hypot_
        fdiv qword [byte ebp+01Eh]
        mov eax, dword [byte ebp+07Ah]
        mov eax, dword [dword eax+0FAh]
        fstp dword [byte eax+08h]
        mov eax, dword [byte ebp+07Ah]
        mov eax, dword [dword eax+0FAh]
        fld dword [byte eax+08h]
        fld st0
        fmul qword [F64_0p6_GoalieMoves]
        fstp st1
        fstp dword [byte eax+08h]
        mov eax, dword [byte ebp+07Ah]
        mov eax, dword [dword eax+0FAh]
        cmp dword [byte eax+08h], 41400000h
        jle short .24
        mov dword [byte eax+08h], 41400000h
.24:
        fld dword [byte ebp+052h]
        fld dword [byte ebp+056h]
        call IF@ATAN2
        mov eax, dword [byte ebp+07Ah]
        fadd dword [byte eax+01Ch]
        mov eax, dword [dword eax+0FAh]
        fstp dword [byte eax+034h]
.25:
        mov eax, dword [byte ebp+07Ah]
        or byte [dword eax+0BFh], 20h
        xor ebx, ebx
        mov edx, dword [dword esi*4+MoveAnimIds]
        push dword 3F19999Ah
        call SetSPA
.26:
        lea esp, [dword ebp+082h]
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        LD mov, eax, eax
;-----------------------------------------------------------------------------
; PuckDeflectAngle                                7614C  97 PC, low confidence
; Works out the angle of a deflection
;-----------------------------------------------------------------------------
PuckDeflectAngle:
        push ebx
        push ecx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov esi, dword [byte ebp+018h]
        mov ecx, eax
        mov ebx, edx
        cmp dword [byte ebp+014h], 3F800000h
        jge short .1
        fld dword [ebx]
        mov eax, ecx
        fstp dword [esi]
        mov edx, dword [byte ebx+04h]
        mov dword [byte esi+04h], edx
        mov edx, dword [byte ebx+08h]
        mov dword [byte esi+08h], edx
        jmp short .4
.1:
        mov edx, ebx
        mov eax, ecx
        call VecDot
        fdiv dword [byte ebp+014h]
        fldz
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        ja short .2
        cmp dword [byte esp+0Ch], 3F800000h
        jle short .3
.2:
        mov dword [byte esp+010h], 461C4000h
        jmp short .5
.3:
        fld dword [byte esp+0Ch]
        fld dword [ebx]
        fmul st1
        fstp dword [esi]
        fld dword [byte ebx+04h]
        fmul st1
        fstp dword [byte esi+04h]
        fmul dword [byte ebx+08h]
        fstp dword [byte esi+08h]
        fld dword [ecx]
        fsub dword [esi]
        fstp dword [esp]
        fld dword [byte ecx+04h]
        fsub dword [byte esi+04h]
        fstp dword [byte esp+04h]
        fld dword [byte ecx+08h]
        fsub dword [byte esi+08h]
        mov eax, esp
        fstp dword [byte esp+08h]
.4:
        call VecLength
        fstp dword [byte esp+010h]
.5:
        fld dword [byte esp+010h]
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        pop ebx
        ret 8
;-----------------------------------------------------------------------------
; PuckDeflect                                     761F8  97 PC, low confidence
; Deflects the puck off a player
;-----------------------------------------------------------------------------
PuckDeflect:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4Ch
        mov ebp, eax
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [byte eax+020h]
        mov dword [byte esp+024h], edx
        mov edx, dword [byte eax+024h]
        mov dword [byte esp+02Ch], edx
        mov edx, dword [byte eax+028h]
        mov dword [byte esp+028h], edx
        mov edx, dword [dword eax+0D2h]
        fld dword [byte esp+02Ch]
        mov dword [byte esp+040h], edx
        mov edx, dword [dword eax+0D6h]
        mov eax, dword [dword eax+0DAh]
        mov dword [byte esp+03Ch], edx
        mov dword [byte esp+044h], eax
        fcomp dword [F32_672]
        fnstsw ax
        sahf
        ja near .9
        fld dword [byte ebp+020h]
        fsub dword [byte esp+024h]
        fabs
        fcomp qword [F64_480_PuckDeflect]
        fnstsw ax
        sahf
        ja near .9
        fld dword [byte ebp+028h]
        fsub dword [byte esp+028h]
        fabs
        fcomp qword [F64_480_PuckDeflect]
        fnstsw ax
        sahf
        ja near .9
        fld dword [byte esp+024h]
        fld dword [byte esp+02Ch]
        fld dword [byte esp+028h]
        mov edx, esp
        mov eax, esp
        fxch st2
        fsub dword [byte esp+040h]
        fxch
        fsub dword [byte esp+03Ch]
        fxch st2
        fsub dword [byte esp+044h]
        fxch
        fstp dword [esp]
        fxch
        fstp dword [byte esp+04h]
        fstp dword [byte esp+08h]
        call VecDot
        mov dx, word [dword ebp+0A9h]
        fstp dword [byte esp+034h]
        test dx, dx
        jne near .1
        mov eax, dword [dword ebp+0FAh]
        and byte [byte eax+031h], 0FBh
        mov dh, byte [dword ebp+0D0h]
        xor ecx, ecx
        test dh, dh
        setne cl
        lea ebx, [byte esp+0Ch]
        mov eax, ebp
        mov edx, dword [dword ecx*4+DeflectAnims]
        mov dword [byte esp+038h], ecx
        call ObjectFramePos
        fld dword [byte esp+0Ch]
        fld dword [byte esp+010h]
        fld dword [byte esp+014h]
        lea eax, [byte esp+018h]
        mov edx, esp
        fxch st2
        fsub dword [byte esp+040h]
        fxch
        fsub dword [byte esp+03Ch]
        push eax
        fxch st2
        fsub dword [byte esp+048h]
        push dword [byte esp+038h]
        fxch
        fstp dword [byte esp+014h]
        fxch
        fstp dword [byte esp+018h]
        lea eax, [byte esp+014h]
        fstp dword [byte esp+01Ch]
        call PuckDeflectAngle
        fldz
        fxch
        fstp dword [byte esp+030h]
        fcomp dword [byte esp+030h]
        fnstsw ax
        sahf
        ja short .2
        mov eax, dword [GameSettings]
        shl eax, 17h
        shr eax, 1Eh
        fild dword [dword eax*4+F32_7p84727eneg44]
        fcomp dword [byte esp+030h]
        fnstsw ax
        sahf
        jbe short .2
        mov eax, dword [dword ebp+0FAh]
        or byte [byte eax+031h], 4
        fld dword [byte esp+018h]
        fadd dword [byte esp+040h]
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+020h]
        fld dword [byte esp+01Ch]
        fadd dword [byte esp+03Ch]
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+024h]
        fld dword [byte esp+020h]
        fadd dword [byte esp+044h]
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+028h]
        mov eax, ecx
        jmp near .10
.1:
        mov dword [byte esp+038h], 0FFFFFFFFh
.2:
        mov ecx, 4
        xor edi, edi
.3:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+030h], 41A00000h
        jle short .4
        mov ebx, 0Fh
        mov edx, ecx
        mov eax, ecx
        sar edx, 1Fh
        idiv ebx
        mov esi, edx
        jmp short .5
.4:
        mov esi, edi
.5:
        cmp esi, dword [byte esp+038h]
        je near .8
        lea ebx, [byte esp+0Ch]
        mov eax, ebp
        mov edx, dword [dword esi*4+DeflectAnims]
        call ObjectFramePos
        fld dword [byte esp+0Ch]
        fld dword [byte esp+010h]
        fld dword [byte esp+014h]
        lea eax, [byte esp+018h]
        mov edx, esp
        fxch st2
        fsub dword [byte esp+040h]
        fxch
        fsub dword [byte esp+03Ch]
        push eax
        fxch st2
        fsub dword [byte esp+048h]
        push dword [byte esp+038h]
        fxch
        fstp dword [byte esp+014h]
        fxch
        fstp dword [byte esp+018h]
        lea eax, [byte esp+014h]
        fstp dword [byte esp+01Ch]
        call PuckDeflectAngle
        fldz
        fxch
        fstp dword [byte esp+048h]
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        ja near .8
        mov eax, dword [GameSettings]
        shl eax, 17h
        shr eax, 1Eh
        fild dword [dword eax*4+F32_7p84727eneg44]
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        jbe near .8
        mov eax, dword [dword ebp+0F6h]
        fld dword [byte esp+018h]
        mov edx, dword [PtrPuckFlags]
        mov eax, dword [eax]
        fadd dword [byte esp+040h]
        mov eax, dword [byte eax+028h]
        fstp dword [byte edx+020h]
        fld dword [byte esp+01Ch]
        fadd dword [byte esp+03Ch]
        mov edx, dword [PtrPuckFlags]
        fstp dword [byte edx+024h]
        fld dword [byte esp+020h]
        mov edx, dword [PtrPuckFlags]
        fadd dword [byte esp+044h]
        and eax, 0FFFFh
        fstp dword [byte edx+028h]
        cmp eax, 102h
        je short .6
        cmp eax, 0E4h
        je short .6
        cmp eax, 105h
        je short .6
        cmp eax, 104h
        jne short .7
.6:
        mov eax, ebp
        call PlayerGetsPuck
        mov eax, dword [PtrPuckFlags]
        mov word [byte eax+06Dh], 4
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+056h], byte 0
        jge short .9
        mov dword [byte eax+056h], 5Ah
        jmp short .9
.7:
        mov eax, esi
        add esp, byte 4Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        inc edi
        inc ecx
        cmp edi, byte 0Fh
        jl near .3
.9:
        mov eax, 0FFFFFFFFh
.10:
        add esp, byte 4Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        add byte [eax], al
        add byte [eax], al
        add byte [eax], al
        add byte [eax], al
        add byte [eax], al
        add byte [eax], al
        add byte [eax], al
        ret
        lea eax, [byte eax+00h]
        push ebx
        push edx
        mov ebx, eax
        test eax, eax
        je short .12
.11:
        mov edx, dword [byte ebx+01Ch]
        mov eax, str_MIRROR
        and edx, byte 8
        mov edx, dword [byte ebx+01Ch]
        mov eax, str_SCALED
        and edx, byte 10h
        mov edx, dword [byte ebx+01Ch]
        mov eax, str_LOOP
        and edx, byte 20h
        mov edx, dword [byte ebx+01Ch]
        mov eax, str_MASTER
        and edx, 100h
        mov edx, dword [byte ebx+01Ch]
        mov eax, str_SLAVE
        and edx, 200h
        mov edx, dword [byte ebx+01Ch]
        mov eax, str_FADING
        and edx, 400h
        mov ebx, dword [byte ebx+020h]
        test ebx, ebx
        jne short .11
.12:
        pop edx
        pop ebx
        ret
%else
;-----------------------------------------------------------------------------
; GoalieMoves                                     75500  97 PC, low confidence
; Goalie movement and saves
;-----------------------------------------------------------------------------
GoalieMoves:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 0A8h
        sub ebp, 82h
        mov dword [byte ebp+07Ah], eax
        test byte [dword eax+0BFh], 80h
        je short .1
        mov dword [byte ebp+03Ah], 0FFFFEF50h
        jmp short .2
.1:
        mov dword [byte ebp+03Ah], 10B0h
.2:
        fild dword [byte ebp+03Ah]
        mov eax, dword [PtrPuckFlags]
        mov ebx, dword [PtrPuckOwner]
        mov dword [byte ebp+04Eh], eax
        mov eax, dword [byte eax+02Ch]
        mov edx, dword [PtrPuckTarget]
        mov dword [byte ebp+032h], eax
        mov eax, dword [byte ebp+04Eh]
        movsx ebx, word [ebx]
        mov eax, dword [byte eax+034h]
        movsx edx, word [edx]
        mov dword [byte ebp+046h], eax
        mov eax, dword [byte ebp+07Ah]
        fstp dword [byte ebp+04Ah]
        call GoaliePosTarget
        mov eax, dword [byte ebp+07Ah]
        test byte [dword eax+0BFh], 20h
        jne near .26
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+028h]
        and eax, 0FFFFh
        mov dword [byte ebp+07Eh], eax
        cmp eax, 0FBh
        jl short .3
        cmp eax, 0FFh
        jg short .3
        mov eax, dword [byte ebp+07Ah]
        cmp byte [dword eax+0A4h], 6
        setb al
        xor edx, edx
        mov bx, word [PuckOwnerTeam]
        mov dl, al
        cmp bx, byte 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        je near .26
.3:
        test byte [gmode], 1
        jne near .26
        mov eax, dword [puckc]
        mov cl, byte [eax]
        test cl, cl
        jl short .4
        mov edx, dword [byte ebp+07Ah]
        cmp byte [dword edx+0A4h], 6
        setb dl
        and edx, 0FFh
        cmp cl, 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        je near .26
.4:
        fldz
        mov eax, dword [byte ebp+04Eh]
        fldz
        xor edx, edx
        fxch
        fcomp dword [byte eax+028h]
        fnstsw ax
        sahf
        setb al
        mov dl, al
        fcomp dword [byte ebp+04Ah]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        jne near .26
        mov eax, dword [byte ebp+07Ah]
        call goaliesave
        test eax, eax
        jne near .26
        fldz
        fldz
        xor edx, edx
        fxch
        fcomp dword [byte ebp+046h]
        fnstsw ax
        sahf
        setb al
        mov dl, al
        fcomp dword [byte ebp+04Ah]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        jne near .26
        fld dword [byte ebp+046h]
        fabs
        fcomp qword [F64_0p0001_GoalieMoves]
        fnstsw ax
        sahf
        jbe short .5
        mov eax, dword [byte ebp+04Eh]
        fld dword [byte ebp+04Ah]
        fsub dword [byte eax+028h]
        fdiv dword [byte ebp+046h]
        fldz
        fxch
        fstp dword [byte ebp+03Eh]
        fcomp dword [byte ebp+03Eh]
        fnstsw ax
        sahf
        ja near .26
        fld dword [byte ebp+03Eh]
        fmul dword [byte ebp+032h]
        mov eax, dword [byte ebp+04Eh]
        fadd dword [byte eax+020h]
        fabs
        fcomp qword [F64_240_GoalieMoves]
        fnstsw ax
        sahf
        jmp short .7
.5:
        mov eax, dword [byte ebp+04Eh]
        cmp dword [byte eax+038h], 41400000h
        jle short .6
        fld dword [byte eax+028h]
        mov eax, dword [byte ebp+07Ah]
        fsub dword [byte eax+028h]
        fabs
        fcomp qword [F64_144_GoalieMoves]
        fnstsw ax
        sahf
        ja near .26
.6:
        mov eax, dword [byte ebp+04Eh]
        fld dword [byte eax+028h]
        mov eax, dword [byte ebp+07Ah]
        sub esp, byte 8
        fsub dword [byte eax+028h]
        mov eax, dword [byte ebp+04Eh]
        fstp qword [esp]
        fld dword [byte eax+020h]
        mov eax, dword [byte ebp+07Ah]
        fsub dword [byte eax+020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_576_GoalieMoves]
        fnstsw ax
        sahf
        ja near .26
        mov eax, dword [byte ebp+04Eh]
        fld dword [byte eax+028h]
        fabs
        fcomp qword [F64_4272_GoalieMoves]
        fnstsw ax
        sahf
.7:
        ja near .26
        mov eax, dword [byte ebp+07Ah]
        mov edx, dword [PtrPuckFlags]
        fld dword [byte eax+020h]
        fsub dword [byte edx+020h]
        fstp dword [byte ebp-01Ah]
        fld dword [byte edx+024h]
        fchs
        mov eax, dword [byte ebp+07Ah]
        fstp dword [byte ebp-016h]
        fld dword [byte eax+028h]
        fsub dword [byte edx+028h]
        fstp dword [byte ebp-012h]
        mov eax, dword [byte edx+02Ch]
        mov dword [byte ebp-0Eh], eax
        mov eax, dword [byte edx+030h]
        lea ecx, [byte ebp-026h]
        mov dword [byte ebp-0Ah], eax
        lea ebx, [byte ebp-02h]
        mov eax, dword [byte edx+034h]
        lea edx, [byte ebp-0Eh]
        mov dword [byte ebp-06h], eax
        lea eax, [byte ebp-01Ah]
        call SaveDirection
        fld1
        fxch
        fstp dword [byte ebp+05Ah]
        mov eax, 1
        fadd dword [GoalieMoveLimit]
        mov dword [byte ebp+036h], eax
        fcomp dword [byte ebp+05Ah]
        fnstsw ax
        sahf
        jb near .26
        mov eax, dword [byte ebp+07Ah]
        lea edi, [byte ebp+042h]
        lea esi, [byte ebp+02Ah]
        fld dword [byte eax+01Ch]
        fchs
        lea eax, [byte ebp+02Eh]
        fstp dword [byte ebp+02Eh]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte ebp-01Eh]
        mov eax, dword [byte ebp-022h]
        fmul dword [byte ebp+042h]
        mov dword [byte ebp+05Eh], eax
        fld dword [byte ebp-026h]
        fchs
        mov eax, dword [byte ebp+04Eh]
        fld dword [byte eax+020h]
        mov eax, dword [byte ebp+07Ah]
        fsub dword [byte eax+020h]
        mov eax, dword [byte ebp+04Eh]
        fld dword [byte eax+028h]
        mov eax, dword [byte ebp+07Ah]
        fsub dword [byte eax+028h]
        fxch
        call IF@ATAN2
        mov eax, dword [byte ebp+07Ah]
        fsub dword [byte eax+01Ch]
        fld qword [F64_6p28319_GoalieMoves]
        fxch
        call IF@DFMOD
        fld dword [byte ebp-01Eh]
        fmul dword [byte ebp+02Ah]
        fld dword [byte ebp-026h]
        fmul dword [byte ebp+042h]
        fxch st3
        fmul dword [byte ebp+02Ah]
        fxch st3
        faddp
        fxch st2
        faddp st3
        fxch
        fstp dword [byte ebp+066h]
        fxch
        fstp dword [byte ebp+06Ah]
        fst dword [byte ebp+02Eh]
        fst qword [byte ebp+0Ah]
        fcomp qword [F64_3p14159_GoalieMoves]
        fnstsw ax
        sahf
        jbe short .8
        fld qword [byte ebp+0Ah]
        fadd qword [F64_neg6p28319_GoalieMoves]
        fstp dword [byte ebp+02Eh]
.8:
        fld dword [byte ebp+02Eh]
        fst qword [byte ebp+012h]
        fcomp qword [F64_neg3p14159_GoalieMoves]
        fnstsw ax
        sahf
        jae short .9
        fld qword [byte ebp+012h]
        fadd qword [F64_6p28319_GoalieMoves]
        fstp dword [byte ebp+02Eh]
.9:
        fld dword [byte ebp+02Eh]
        fabs
        fcomp qword [F64_0p349066_GoalieMoves]
        fnstsw ax
        sahf
        jae short .13
        sub esp, byte 8
        fld dword [byte ebp+06Ah]
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte ebp+066h]
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_48_GoalieMoves]
        fnstsw ax
        sahf
        jae short .13
        fld dword [byte ebp+05Eh]
        fcomp dword [F32_144_GoalieMoves]
        fnstsw ax
        sahf
        jbe short .10
        mov esi, 1
        jmp short .12
.10:
        fld dword [byte ebp+05Eh]
        fcomp dword [F32_24_GoalieMoves]
        fnstsw ax
        sahf
        jae short .11
        mov esi, 14h
        jmp short .12
.11:
        xor esi, esi
.12:
        mov eax, dword [nosplit esi*4+GoalieMoveTable]
        mov dword [byte ebp+06Eh], eax
        jmp near .22
.13:
        mov edx, 47C35000h
        xor esi, esi
        xor ebx, ebx
        mov dword [byte ebp+062h], edx
        mov dword [byte ebp+06Eh], edx
        mov dword [byte ebp+07Eh], esi
        xor edx, edx
        xor cl, cl
.14:
        mov edi, dword [byte ebp+07Eh]
        cmp edi, byte 0Fh
        jl short .15
        cmp edi, byte 13h
        jg short .15
        mov eax, dword [puckc]
        cmp cl, byte [eax]
        jle near .21
.15:
        fld dword [dword edx+GoalieAnimFrame]
        fsub dword [byte ebp+05Eh]
        fabs
        fmul qword [F64_2_GoalieMoves]
        sub esp, byte 8
        fld dword [dword edx+GoalieAnimPoses]
        fsub dword [byte ebp+06Ah]
        mov eax, dword [byte ebp+07Ah]
        fstp qword [esp]
        mov ch, byte [dword eax+0D0h]
        fstp qword [byte ebp+01Ah]
        cmp cl, ch
        je short .16
        fld dword [dword edx+GoalieAnimTime]
        fchs
        fstp dword [byte ebp+072h]
        jmp short .17
.16:
        mov eax, dword [dword edx+GoalieAnimTime]
        mov dword [byte ebp+072h], eax
.17:
        fld dword [byte ebp+072h]
        fsub dword [byte ebp+066h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fadd qword [byte ebp+01Ah]
        fst dword [dword ebx+GoalieMoveTable]
        fcomp dword [byte ebp+06Eh]
        fnstsw ax
        sahf
        ja short .20
        mov eax, dword [dword ebx+GoalieMoveTable]
        mov dword [byte ebp+06Eh], eax
        mov eax, dword [byte ebp+07Ah]
        mov ch, byte [dword eax+0D0h]
        mov esi, dword [byte ebp+07Eh]
        cmp cl, ch
        je short .18
        fld dword [dword edx+GoalieAnimTime]
        fchs
        fstp dword [byte ebp+076h]
        jmp short .19
.18:
        mov eax, dword [dword edx+GoalieAnimTime]
        mov dword [byte ebp+076h], eax
.19:
        fld dword [byte ebp+066h]
        fld dword [byte ebp+06Ah]
        fsub dword [dword edx+GoalieAnimPoses]
        fxch
        fsub dword [byte ebp+076h]
        fxch
        fstp dword [byte ebp+056h]
        fstp dword [byte ebp+052h]
.20:
        fld dword [dword ebx+GoalieMoveTable]
        fcomp dword [byte ebp+062h]
        fnstsw ax
        sahf
        ja short .21
        fld dword [dword ebx+GoalieAnimData]
        fadd dword [F32_neg1_GoalieMoves]
        fcomp dword [byte ebp+05Ah]
        fnstsw ax
        sahf
        jae short .21
        mov eax, dword [dword ebx+GoalieMoveTable]
        mov dword [byte ebp+062h], eax
.21:
        mov edi, dword [byte ebp+07Eh]
        add ebx, byte 4
        inc edi
        add edx, byte 0Ch
        mov dword [byte ebp+07Eh], edi
        cmp edi, byte 15h
        jl near .14
.22:
        fld dword [byte ebp+05Ah]
        fsub dword [nosplit esi*4+GoalieAnimData]
        mov edx, dword [byte ebp+07Eh]
        fstp dword [byte ebp+02Eh]
        cmp edx, byte 5
        jl short .23
        cmp edx, byte 7
        jg short .23
        fld dword [byte ebp+02Eh]
        fadd dword [F32_2_GoalieMoves]
        fstp dword [byte ebp+02Eh]
.23:
        fild dword [byte ebp+036h]
        fcomp dword [byte ebp+02Eh]
        fnstsw ax
        sahf
        jbe near .26
        fld dword [byte ebp+06Eh]
        fcomp dword [F32_480_GoalieMoves]
        fnstsw ax
        sahf
        jae near .26
        mov eax, dword [byte ebp+07Ah]
        mov eax, dword [dword eax+0FAh]
        call ResetAnimTimer
        lea eax, [nosplit esi*4+00h]
        cmp dword [dword eax+GoalieAnimFiles], byte 1
        jle near .25
        fld dword [byte ebp+056h]
        sub esp, byte 8
        fild dword [dword eax+GoalieAnimFiles]
        fxch
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte ebp+052h]
        fstp qword [esp]
        fstp qword [byte ebp+022h]
        call hypot_
        fdiv qword [byte ebp+022h]
        mov eax, dword [byte ebp+07Ah]
        mov eax, dword [dword eax+0FAh]
        fstp dword [byte eax+08h]
        mov eax, dword [byte ebp+07Ah]
        mov eax, dword [dword eax+0FAh]
        fld dword [byte eax+08h]
        fld st0
        fmul qword [F64_0p6_GoalieMoves]
        fstp st1
        fstp dword [byte eax+08h]
        mov eax, dword [byte ebp+07Ah]
        mov eax, dword [dword eax+0FAh]
        cmp dword [byte eax+08h], 41400000h
        jle short .24
        mov dword [byte eax+08h], 41400000h
.24:
        fld dword [byte ebp+056h]
        fld dword [byte ebp+052h]
        call IF@ATAN2
        mov eax, dword [byte ebp+07Ah]
        fadd dword [byte eax+01Ch]
        mov eax, dword [dword eax+0FAh]
        fstp dword [byte eax+034h]
.25:
        mov eax, dword [byte ebp+07Ah]
        or byte [dword eax+0BFh], 20h
        xor ebx, ebx
        mov edx, dword [nosplit esi*4+MoveAnimIds]
        push dword 3F19999Ah
        call SetSPA
.26:
        lea esp, [dword ebp+082h]
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PuckDeflectAngle                                75AE8  97 PC, low confidence
; Works out the angle of a deflection
;-----------------------------------------------------------------------------
PuckDeflectAngle:
        push ebx
        push ecx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov esi, dword [byte ebp+018h]
        mov ecx, eax
        mov ebx, edx
        cmp dword [byte ebp+014h], 3F800000h
        jge short .1
        fld dword [ebx]
        mov eax, ecx
        fstp dword [esi]
        mov edx, dword [byte ebx+04h]
        mov dword [byte esi+04h], edx
        mov edx, dword [byte ebx+08h]
        mov dword [byte esi+08h], edx
        jmp short .4
.1:
        mov edx, ebx
        mov eax, ecx
        call VecDot
        fdiv dword [byte ebp+014h]
        fldz
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        ja short .2
        cmp dword [byte esp+0Ch], 3F800000h
        jle short .3
.2:
        mov dword [byte esp+010h], 461C4000h
        jmp short .5
.3:
        fld dword [byte esp+0Ch]
        fld dword [ebx]
        fmul st1
        fstp dword [esi]
        fld dword [byte ebx+04h]
        fmul st1
        fstp dword [byte esi+04h]
        fmul dword [byte ebx+08h]
        fstp dword [byte esi+08h]
        fld dword [ecx]
        fsub dword [esi]
        fstp dword [esp]
        fld dword [byte ecx+04h]
        fsub dword [byte esi+04h]
        fstp dword [byte esp+04h]
        fld dword [byte ecx+08h]
        fsub dword [byte esi+08h]
        mov eax, esp
        fstp dword [byte esp+08h]
.4:
        call VecLength
        fstp dword [byte esp+010h]
.5:
        fld dword [byte esp+010h]
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        pop ebx
        ret 8
;-----------------------------------------------------------------------------
; PuckDeflect                                     75B94  97 PC, low confidence
; Deflects the puck off a player
;-----------------------------------------------------------------------------
PuckDeflect:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4Ch
        mov ebp, eax
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [byte eax+020h]
        mov dword [byte esp+024h], edx
        mov edx, dword [byte eax+024h]
        mov dword [byte esp+02Ch], edx
        mov edx, dword [byte eax+028h]
        mov dword [byte esp+028h], edx
        mov edx, dword [dword eax+0D2h]
        fld dword [byte esp+02Ch]
        mov dword [byte esp+040h], edx
        mov edx, dword [dword eax+0D6h]
        mov eax, dword [dword eax+0DAh]
        mov dword [byte esp+03Ch], edx
        mov dword [byte esp+044h], eax
        fcomp dword [F32_672]
        fnstsw ax
        sahf
        ja near .9
        fld dword [byte ebp+020h]
        fsub dword [byte esp+024h]
        fabs
        fcomp qword [F64_480_PuckDeflect]
        fnstsw ax
        sahf
        ja near .9
        fld dword [byte ebp+028h]
        fsub dword [byte esp+028h]
        fabs
        fcomp qword [F64_480_PuckDeflect]
        fnstsw ax
        sahf
        ja near .9
        fld dword [byte esp+024h]
        fld dword [byte esp+02Ch]
        fld dword [byte esp+028h]
        mov edx, esp
        mov eax, esp
        fxch st2
        fsub dword [byte esp+040h]
        fxch
        fsub dword [byte esp+03Ch]
        fxch st2
        fsub dword [byte esp+044h]
        fxch
        fstp dword [esp]
        fxch
        fstp dword [byte esp+04h]
        fstp dword [byte esp+08h]
        call VecDot
        mov dx, word [dword ebp+0A9h]
        fstp dword [byte esp+034h]
        test dx, dx
        jne near .1
        mov eax, dword [dword ebp+0FAh]
        and byte [byte eax+031h], 0FBh
        mov dh, byte [dword ebp+0D0h]
        xor ecx, ecx
        test dh, dh
        setne cl
        lea ebx, [byte esp+0Ch]
        mov eax, ebp
        mov edx, dword [nosplit ecx*4+DeflectAnims]
        mov dword [byte esp+038h], ecx
        call ObjectFramePos
        fld dword [byte esp+0Ch]
        fld dword [byte esp+010h]
        fld dword [byte esp+014h]
        lea eax, [byte esp+018h]
        mov edx, esp
        fxch st2
        fsub dword [byte esp+040h]
        fxch
        fsub dword [byte esp+03Ch]
        push eax
        fxch st2
        fsub dword [byte esp+048h]
        push dword [byte esp+038h]
        fxch
        fstp dword [byte esp+014h]
        fxch
        fstp dword [byte esp+018h]
        lea eax, [byte esp+014h]
        fstp dword [byte esp+01Ch]
        call PuckDeflectAngle
        fldz
        fxch
        fstp dword [byte esp+030h]
        fcomp dword [byte esp+030h]
        fnstsw ax
        sahf
        ja short .2
        mov eax, dword [GameSettings]
        shl eax, 17h
        shr eax, 1Eh
        fild dword [nosplit eax*4+F32_7p84727eneg44]
        fcomp dword [byte esp+030h]
        fnstsw ax
        sahf
        jbe short .2
        mov eax, dword [dword ebp+0FAh]
        or byte [byte eax+031h], 4
        fld dword [byte esp+018h]
        fadd dword [byte esp+040h]
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+020h]
        fld dword [byte esp+01Ch]
        fadd dword [byte esp+03Ch]
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+024h]
        fld dword [byte esp+020h]
        fadd dword [byte esp+044h]
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+028h]
        mov eax, ecx
        jmp near .10
.1:
        mov dword [byte esp+038h], 0FFFFFFFFh
.2:
        mov ecx, 4
        xor edi, edi
.3:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+030h], 41A00000h
        jle short .4
        mov ebx, 0Fh
        mov edx, ecx
        mov eax, ecx
        sar edx, 1Fh
        idiv ebx
        mov esi, edx
        jmp short .5
.4:
        mov esi, edi
.5:
        cmp esi, dword [byte esp+038h]
        je near .8
        lea ebx, [byte esp+0Ch]
        mov eax, ebp
        mov edx, dword [nosplit esi*4+DeflectAnims]
        call ObjectFramePos
        fld dword [byte esp+0Ch]
        fld dword [byte esp+010h]
        fld dword [byte esp+014h]
        lea eax, [byte esp+018h]
        mov edx, esp
        fxch st2
        fsub dword [byte esp+040h]
        fxch
        fsub dword [byte esp+03Ch]
        push eax
        fxch st2
        fsub dword [byte esp+048h]
        push dword [byte esp+038h]
        fxch
        fstp dword [byte esp+014h]
        fxch
        fstp dword [byte esp+018h]
        lea eax, [byte esp+014h]
        fstp dword [byte esp+01Ch]
        call PuckDeflectAngle
        fldz
        fxch
        fstp dword [byte esp+048h]
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        ja near .8
        mov eax, dword [GameSettings]
        shl eax, 17h
        shr eax, 1Eh
        fild dword [nosplit eax*4+F32_7p84727eneg44]
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        jbe near .8
        mov eax, dword [dword ebp+0F6h]
        fld dword [byte esp+018h]
        mov edx, dword [PtrPuckFlags]
        mov eax, dword [eax]
        fadd dword [byte esp+040h]
        mov eax, dword [byte eax+028h]
        fstp dword [byte edx+020h]
        fld dword [byte esp+01Ch]
        fadd dword [byte esp+03Ch]
        mov edx, dword [PtrPuckFlags]
        fstp dword [byte edx+024h]
        fld dword [byte esp+020h]
        mov edx, dword [PtrPuckFlags]
        fadd dword [byte esp+044h]
        and eax, 0FFFFh
        fstp dword [byte edx+028h]
        cmp eax, 102h
        je short .6
        cmp eax, 0E4h
        je short .6
        cmp eax, 105h
        je short .6
        cmp eax, 104h
        jne short .7
.6:
        mov eax, ebp
        call PlayerGetsPuck
        mov eax, dword [PtrPuckFlags]
        mov word [byte eax+06Dh], 4
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+056h], byte 0
        jge short .9
        mov dword [byte eax+056h], 5Ah
        jmp short .9
.7:
        mov eax, esi
        add esp, byte 4Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        inc edi
        inc ecx
        cmp edi, byte 0Fh
        jl near .3
.9:
        mov eax, 0FFFFFFFFh
.10:
        add esp, byte 4Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h
        ret
        db 08Dh,040h,00h
        push ebx
        push edx
        mov ebx, eax
        test eax, eax
        je short .12
.11:
        mov edx, dword [byte ebx+01Ch]
        mov eax, str_MIRROR
        and edx, byte 8
        mov edx, dword [byte ebx+01Ch]
        mov eax, str_SCALED
        and edx, byte 10h
        mov edx, dword [byte ebx+01Ch]
        mov eax, str_LOOP
        and edx, byte 20h
        mov edx, dword [byte ebx+01Ch]
        mov eax, str_MASTER
        and edx, 100h
        mov edx, dword [byte ebx+01Ch]
        mov eax, str_SLAVE
        and edx, 200h
        mov edx, dword [byte ebx+01Ch]
        mov eax, str_FADING
        and edx, 400h
        mov ebx, dword [byte ebx+020h]
        test ebx, ebx
        jne short .11
.12:
        pop edx
        pop ebx
        ret
%endif
