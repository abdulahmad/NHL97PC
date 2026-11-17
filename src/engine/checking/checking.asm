; Stick checks: poke check, slash, sweep check, hook and dive.
bits 32
%include "hockey.inc"
section s_73069 progbits alloc exec nowrite align=1
extern AdvanceMoveAnim, ApplyMoveMotion, BlockReach, EndMove, F32_30_HookMove, F32_30_PokeCheckMove, F32_30_SweepCheckMove, F32_96_PokeCheckMove
extern F64_0p523599_PokeCheckMove, F64_0p6_HookMove, F64_0p785398_StartPokeAnim, F64_0p785398_SweepCheckMove, F64_144_PokeCheckMove, F64_1p22173, F64_3p14159_StartPokeAnim, F64_3p14159_SweepCheckMove
extern F64_6p28319_StartPokeAnim, F64_6p28319_SweepCheckMove, F64_neg3p14159_StartPokeAnim, F64_neg3p14159_SweepCheckMove, F64_neg6p28319_StartPokeAnim, F64_neg6p28319_SweepCheckMove, GetAnimId, gmode
extern GoalieAnimFiles, GoalieFreezeAnims, HoldPoseMove, hypot_, IF@DFMOD, MoveFuncPair, MovePlayer, PickSaveAnim
extern PickSkateAnim, PlaySfxAt, PlaySfxVolume, PtrPuckFlags, PtrPuckState, PtrPuckZone, randomd0, ResetAnimTimer
extern SetSPA, SortCords, SpeedTowardSpot, StepMove
global SkateMoveStep, StartPokeAnim, PokeCheckMove, StickSlashMove, SweepCheckMove, HookMove, DiveMove, HoldPoseMoveJump
global GoalieFreezeMove
        db 00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; SkateMoveStep                                   73070  97 PC, low confidence
; Steps a skating move
;-----------------------------------------------------------------------------
SkateMoveStep:
        push ebx
        push ecx
        mov ecx, eax
        mov ebx, dword [byte eax+02Ch]
        call ApplyMoveMotion
        mov eax, ebx
        call SpeedTowardSpot
        mov eax, dword [dword ebx+0FAh]
        cmp dword [byte eax+034h], 461C4000h
        jge short .1
        mov eax, ecx
        call GetAnimId
        test al, 1
        je short .1
        mov eax, dword [dword ebx+0FAh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword ebx+0FAh]
        mov dword [byte eax+034h], 461C4000h
.1:
        mov eax, ebx
        call MovePlayer
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StartPokeAnim                                   730C4  97 PC, low confidence
; Starts a poke check animation
;-----------------------------------------------------------------------------
StartPokeAnim:
        push ebx
        push edx
        cmp byte [dword eax+0A4h], 6
        jae short .1
        mov eax, 6
        jmp short .2
.1:
        xor eax, eax
.2:
        mov edx, eax
        shl eax, 5
        add eax, edx
        shl eax, 3
        xor edx, edx
        add eax, SortCords
.3:
        mov ebx, dword [dword eax+0AEh]
        sar ebx, 18h
        cmp byte [dword ebx+eax+0B2h], 18h
        jne short .4
        mov eax, 1
        pop edx
        pop ebx
        ret
.4:
        inc edx
        add eax, 108h
        cmp edx, byte 6
        jl short .3
        xor eax, eax
        pop edx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov ebx, dword [dword eax+0FAh]
        test byte [byte ebx+031h], 2
        je near .11
        fld dword [byte ebp+018h]
        fsub dword [byte ecx+01Ch]
        fld qword [F64_6p28319_StartPokeAnim]
        fxch
        call IF@DFMOD
        fst dword [byte ebp+018h]
        fst qword [esp]
        fcomp qword [F64_3p14159_StartPokeAnim]
        fnstsw ax
        sahf
        jbe short .5
        fld qword [esp]
        fadd qword [F64_neg6p28319_StartPokeAnim]
        fstp dword [byte ebp+018h]
.5:
        fld dword [byte ebp+018h]
        fst qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_StartPokeAnim]
        fnstsw ax
        sahf
        jae short .6
        fld qword [byte esp+08h]
        fadd qword [F64_6p28319_StartPokeAnim]
        fstp dword [byte ebp+018h]
.6:
        test byte [gmode], 1
        je short .9
        fld dword [byte ebp+018h]
        fabs
        fcomp qword [F64_0p785398_StartPokeAnim]
        fnstsw ax
        sahf
        jae short .7
        mov edx, 0C7h
        jmp short .10
.7:
        cmp byte [dword ecx+0D0h], 0
        setne dl
        mov esi, edx
        fldz
        and esi, 0FFh
        fcomp dword [byte ebp+018h]
        fnstsw ax
        sahf
        setb dl
        and edx, 0FFh
        xor edx, esi
        je short .8
        mov edx, 0C5h
        jmp short .10
.8:
        mov edx, 0C6h
        jmp short .10
.9:
        mov edx, 0C8h
.10:
        mov eax, ebx
        call ResetAnimTimer
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        xor ebx, ebx
        push dword 3F19999Ah
        call SetSPA
.11:
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PokeCheckMove                                   7320C  97 PC, low confidence
; Move handler for a poke check
;-----------------------------------------------------------------------------
PokeCheckMove:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 1Ch
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        test byte [byte eax+01Ch], 80h
        je near .16
        test byte [gmode], 1
        je near .5
        mov eax, ecx
        mov esi, 0ACh
        call StartPokeAnim
        test eax, eax
        je near .15
        cmp byte [dword ecx+0A4h], 6
        jae short .1
        mov eax, 6
        jmp short .2
.1:
        xor eax, eax
.2:
        mov edx, eax
        shl edx, 5
        add edx, eax
        mov ebx, SortCords
        shl edx, 3
        add ebx, edx
        xor edx, edx
.3:
        fld dword [byte ebx+028h]
        fsub dword [byte ecx+028h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte ebx+020h]
        fsub dword [byte ecx+020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_144_PokeCheckMove]
        fnstsw ax
        sahf
        jae short .4
        mov esi, 0F2h
        jmp near .15
.4:
        inc edx
        cmp edx, byte 6
        jl short .3
        jmp near .15
.5:
        lea ebx, [byte esp+0Ch]
        lea edx, [byte esp+018h]
        mov eax, ecx
        call PickSaveAnim
        fldz
        fxch
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        ja short .6
        fld dword [byte esp+010h]
        fcomp dword [F32_30_PokeCheckMove]
        fnstsw ax
        sahf
        ja short .6
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jl short .7
        cmp byte [dword ecx+0A4h], 6
        setb al
        mov edx, eax
        mov eax, dword [PtrPuckZone]
        mov bh, byte [eax]
        and edx, 0FFh
        cmp bh, 6
        setl al
        and eax, 0FFh
        cmp eax, edx
        jne short .7
.6:
        mov esi, 0A9h
        jmp near .15
.7:
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jl short .8
        mov eax, 2
        call randomd0
        test ax, ax
        setne al
        and eax, 0FFh
        lea esi, [dword eax+0F0h]
        jmp near .15
.8:
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+030h]
        fmul dword [byte esp+010h]
        fld dword [byte esp+018h]
        fxch
        fadd dword [byte eax+024h]
        fxch
        fabs
        fxch
        fstp dword [byte esp+014h]
        fcomp qword [F64_0p523599_PokeCheckMove]
        fnstsw ax
        sahf
        jae short .10
        fld dword [byte esp+014h]
        fcomp dword [F32_96_PokeCheckMove]
        fnstsw ax
        sahf
        jae short .10
        mov eax, 2
        call randomd0
        test ax, ax
        je short .9
        mov esi, 0ADh
        jmp near .15
.9:
        mov esi, 0F3h
        jmp near .15
.10:
        cmp byte [dword ecx+0D0h], 0
        setne al
        mov edx, eax
        fldz
        and edx, 0FFh
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        je short .13
        fld dword [byte esp+018h]
        fabs
        fcomp qword [F64_1p22173]
        fnstsw ax
        sahf
        jbe short .11
        mov esi, 0EEh
        jmp short .15
.11:
        fld dword [byte esp+014h]
        fcomp dword [F32_96_PokeCheckMove]
        fnstsw ax
        sahf
        jbe short .12
        mov esi, 0F4h
        jmp short .15
.12:
        mov esi, 0F5h
        jmp short .15
.13:
        fld dword [byte esp+018h]
        fabs
        fcomp qword [F64_1p22173]
        fnstsw ax
        sahf
        jbe short .14
        mov esi, 0EFh
        jmp short .15
.14:
        mov esi, 0EDh
.15:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov bh, byte [dword ecx+0BFh]
        mov edx, esi
        or bh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        xor ebx, ebx
        push dword 3F19999Ah
        call SetSPA
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.16:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ebx
        call SkateMoveStep
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StickSlashMove                                  73464  97 PC, low confidence
; Move handler for a slash (sound)
;-----------------------------------------------------------------------------
StickSlashMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov esi, eax
        mov edi, dword [byte eax+028h]
        and edi, 0FFFFh
        mov ecx, dword [byte eax+02Ch]
        cmp edi, 0F7h
        jne short .1
        cmp dword [byte eax+04h], byte 1Ah
        jne short .1
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 409h
        push dword [byte ecx+020h]
        call PlaySfxVolume
        jmp short .4
.1:
        cmp edi, 0F7h
        jne short .2
        cmp dword [byte esi+04h], byte 23h
        je short .3
.2:
        cmp edi, 0F6h
        jne short .4
        cmp dword [byte esi+04h], byte 1Ch
        jne short .4
.3:
        push dword [byte ecx+028h]
        mov eax, 5
        push dword [byte ecx+020h]
        mov ebx, 64h
        call randomd0
        cwde
        xor edx, edx
        add eax, 520h
        call PlaySfxAt
.4:
        test byte [byte esi+01Ch], 80h
        je near .7
        cmp edi, 0F6h
        je short .5
        cmp edi, 0F7h
        je short .5
        mov eax, ecx
        mov edx, 0B3h
        call StartPokeAnim
        test eax, eax
        je short .6
        mov eax, 2
        call randomd0
        test ax, ax
        sete al
        and eax, 0FFh
        lea edx, [dword eax+0F6h]
        jmp short .6
.5:
        mov edx, 0B3h
.6:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov bl, byte [dword ecx+0BFh]
        or bl, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        xor ebx, ebx
        push dword 3F19999Ah
        call SetSPA
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        mov edx, esp
        mov eax, esi
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, esi
        call StepMove
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SweepCheckMove                                  73578  97 PC, low confidence
; Move handler for a sweep check
;-----------------------------------------------------------------------------
SweepCheckMove:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 28h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov ah, byte [byte eax+01Ch]
        mov esi, dword [dword ecx+0FAh]
        test ah, 80h
        je near .9
        test byte [gmode], 1
        jne near .7
        lea ebx, [byte esp+0Ch]
        lea edx, [byte esp+024h]
        mov eax, ecx
        call PickSaveAnim
        fldz
        fxch
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        ja short .2
        fld dword [byte esp+010h]
        fcomp dword [F32_30_SweepCheckMove]
        fnstsw ax
        sahf
        ja short .2
        mov edx, dword [PtrPuckZone]
        cmp byte [edx], 0
        jl short .1
        cmp byte [dword ecx+0A4h], 6
        setb dl
        mov ebx, dword [PtrPuckZone]
        mov al, byte [ebx]
        and edx, 0FFh
        cmp al, 6
        setl bl
        and ebx, 0FFh
        cmp ebx, edx
        je short .2
.1:
        mov edx, dword [PtrPuckState]
        cmp word [edx], 90h
        jge near .7
.2:
        fld dword [byte ecx+044h]
        fsub dword [byte ecx+01Ch]
        fld qword [F64_6p28319_SweepCheckMove]
        fxch
        call IF@DFMOD
        fst dword [byte esp+024h]
        fst qword [byte esp+014h]
        fcomp qword [F64_3p14159_SweepCheckMove]
        fnstsw ax
        sahf
        jbe short .3
        fld qword [byte esp+014h]
        fadd qword [F64_neg6p28319_SweepCheckMove]
        fstp dword [byte esp+024h]
.3:
        fld dword [byte esp+024h]
        fst qword [byte esp+01Ch]
        fcomp qword [F64_neg3p14159_SweepCheckMove]
        fnstsw ax
        sahf
        jae short .4
        fld qword [byte esp+01Ch]
        fadd qword [F64_6p28319_SweepCheckMove]
        fstp dword [byte esp+024h]
.4:
        fld dword [byte esp+024h]
        fabs
        fcomp qword [F64_0p785398_SweepCheckMove]
        fnstsw ax
        sahf
        ja short .5
        mov edx, 0B2h
        jmp short .8
.5:
        cmp byte [dword ecx+0D0h], 0
        setne dl
        mov ebx, edx
        fldz
        and ebx, 0FFh
        fcomp dword [byte esp+024h]
        fnstsw ax
        sahf
        setb dl
        and edx, 0FFh
        xor ebx, edx
        je short .6
        mov edx, 0B4h
        jmp short .8
.6:
        mov edx, 0B5h
        jmp short .8
.7:
        mov edx, 0B1h
.8:
        mov eax, esi
        call ResetAnimTimer
        mov bl, byte [dword ecx+0BFh]
        or bl, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        xor ebx, ebx
        push dword 3F19999Ah
        call SetSPA
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ebx
        call StepMove
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; HookMove                                        7370C  97 PC, low confidence
; Move handler for a hook (sound)
;-----------------------------------------------------------------------------
HookMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 34h
        and esp, byte 0FFFFFFF8h
        mov edi, eax
        mov esi, dword [byte eax+028h]
        mov ecx, dword [byte eax+02Ch]
        mov ah, byte [byte eax+01Ch]
        and esi, 0FFFFh
        test ah, 80h
        jne short .1
        mov eax, edi
        call GetAnimId
        test al, 2
        je short .1
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 423h
        push dword [byte ecx+020h]
        call PlaySfxVolume
.1:
        test byte [byte edi+01Ch], 80h
        je near .11
        cmp esi, 0E8h
        jb short .2
        cmp esi, 0E9h
        jbe near .8
        cmp esi, 0ECh
        jb short .5
        jbe near .8
        cmp esi, 0EEh
        jb near .10
        jbe near .8
        cmp esi, 0EFh
        je short .5
        jmp near .10
.2:
        cmp esi, 0E6h
        jb short .3
        jbe short .4
        jmp short .5
.3:
        cmp esi, 0ADh
        jne near .10
.4:
        mov edx, 0AEh
        jmp near .7
.5:
        test byte [gmode], 1
        jne short .6
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jge short .6
        lea ebx, [byte esp+010h]
        lea edx, [byte esp+0Ch]
        mov eax, ecx
        call PickSaveAnim
        fldz
        fxch
        fstp dword [byte esp+024h]
        fcomp dword [byte esp+024h]
        fnstsw ax
        sahf
        jae short .6
        fld dword [byte esp+024h]
        fcomp dword [F32_30_HookMove]
        fnstsw ax
        sahf
        jae short .6
        mov edx, 0EAh
        jmp near .7
.6:
        mov edx, 0AFh
.7:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov al, byte [dword ecx+0BFh]
        or al, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], al
        mov eax, ecx
        push dword 3F19999Ah
        call SetSPA
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        test byte [gmode], 1
        jne short .9
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jge short .9
        lea ebx, [byte esp+020h]
        lea edx, [byte esp+014h]
        mov eax, ecx
        call PickSaveAnim
        fldz
        fxch
        fstp dword [byte esp+028h]
        fcomp dword [byte esp+028h]
        fnstsw ax
        sahf
        jae short .9
        fld dword [byte esp+028h]
        fcomp dword [F32_30_HookMove]
        fnstsw ax
        sahf
        jae short .9
        mov edx, 0E9h
        jmp short .7
.9:
        mov edx, 0B0h
        jmp short .7
.10:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov bh, byte [dword ecx+0BFh]
        mov edx, 9Dh
        and bh, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        mov ebx, 20h
        push dword 3F800000h
        call SetSPA
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        cmp esi, 0EAh
        je short .12
        cmp esi, 0E9h
        jne near .15
.12:
        lea ebx, [byte esp+018h]
        lea edx, [byte esp+01Ch]
        mov eax, ecx
        call PickSaveAnim
        fstp dword [byte esp+030h]
        cmp esi, 0EAh
        setne al
        and eax, 0FFh
        mov bl, byte [gmode]
        lea edx, [dword eax+0AFh]
        test bl, 1
        jne short .14
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jl short .13
        mov ah, byte [dword ecx+0A4h]
        xor ebx, ebx
        cmp ah, 6
        setb bl
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 6
        setl al
        and eax, 0FFh
        cmp eax, ebx
        je short .14
.13:
        fldz
        fcomp dword [byte esp+030h]
        fnstsw ax
        sahf
        ja short .14
        mov ebx, dword [nosplit edx*4+MoveFuncPair]
        xor eax, eax
        mov al, byte [byte ebx+0Dh]
        mov dword [byte esp+02Ch], eax
        fild word [byte esp+02Ch]
        fmul qword [F64_0p6_HookMove]
        fld dword [byte esp+030h]
        fcompp
        fnstsw ax
        sahf
        jbe short .15
.14:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov bl, byte [dword ecx+0BFh]
        or bl, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        xor ebx, ebx
        push dword 3F19999Ah
        call SetSPA
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.15:
        mov edx, esp
        mov eax, edi
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, edi
        call SkateMoveStep
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
; DiveMove                                        739B8  97 PC, low confidence
; Move handler for a dive
;-----------------------------------------------------------------------------
DiveMove:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov eax, dword [byte eax+028h]
        mov dl, byte [byte ebx+01Ch]
        and eax, 0FFFFh
        test dl, 80h
        je short .4
        cmp eax, 0AAh
        jb short .2
        jbe short .1
        cmp eax, 0ABh
        jne short .2
        mov edx, 0A2h
        jmp short .3
.1:
        mov edx, 0A1h
        jmp short .3
.2:
        mov edx, 9Dh
.3:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        mov ebx, 20h
        push dword 3F19999Ah
        call SetSPA
        jmp short .8
.4:
        cmp eax, 0A1h
        je short .5
        cmp eax, 0A2h
        jne short .6
.5:
        mov edx, esp
        mov eax, ecx
        call BlockReach
        jmp short .7
.6:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
.7:
        mov edx, esp
        mov eax, ebx
        call StepMove
.8:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; HoldPoseMoveJump                                73A58  97 PC, low confidence
; Jumps to the hold pose move
;-----------------------------------------------------------------------------
HoldPoseMoveJump:
        jmp near HoldPoseMove
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; GoalieFreezeMove                                73A60  97 PC, low confidence
; Move handler for the goalie freezing the puck
;-----------------------------------------------------------------------------
GoalieFreezeMove:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 0Ch
        mov ebx, eax
        mov edx, dword [byte ebx+028h]
        mov cl, byte [byte ebx+01Ch]
        mov eax, dword [byte eax+02Ch]
        and edx, 0FFFFh
        test cl, 80h
        je short .1
        mov eax, ebx
        call EndMove
        jmp near .7
.1:
        cmp edx, 0D6h
        jne short .2
        mov edx, dword [GoalieAnimFiles]
        add edx, byte 8
        jmp short .4
.2:
        cmp edx, 0D7h
        jne short .3
        mov edx, dword [GoalieFreezeAnims]
        add edx, byte 8
        jmp short .4
.3:
        mov edx, dword [ebx]
        mov dl, byte [byte edx+0Dh]
        and edx, 0FFh
        sub edx, byte 5
.4:
        cmp edx, dword [byte ebx+04h]
        jne short .5
        mov ecx, dword [PtrPuckZone]
        movzx esi, byte [dword eax+0A4h]
        movsx ecx, byte [ecx]
        cmp esi, ecx
        je short .5
        and byte [dword eax+0BFh], 0DFh
.5:
        cmp edx, dword [byte ebx+04h]
        jge short .6
        mov edx, dword [PtrPuckZone]
        cmp byte [edx], 0
        jl short .6
        cmp byte [dword eax+0A4h], 6
        setb dl
        mov ecx, edx
        mov edx, dword [PtrPuckZone]
        and ecx, 0FFh
        cmp byte [edx], 6
        setl dl
        and edx, 0FFh
        xor edx, ecx
        je short .6
        call PickSkateAnim
        add esp, byte 0Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ebx
        call SkateMoveStep
.7:
        add esp, byte 0Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
