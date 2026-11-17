; Blocking shots: kneeling and sliding.
bits 32
%include "hockey.inc"
section s_73B3C progbits alloc exec nowrite align=1
extern BlockShotAnims, BlockShotMoveLeft, BlockShotMoveRight, EndMove, F32_0p1_BlockShotMove, F32_0p5_BlockReach, F32_120, F32_12_BlockShotMove
extern F32_168, F64_0p0628319_BlockReach, F64_0p785398_StartBlockAnim, F64_0p8_BlockReach, F64_1p33_BlockReach, F64_1p52588eneg05_BlockReach, F64_24_BlockShotMove, F64_2_BlockReach
extern F64_2p35619_StartBlockAnim, F64_384_BlockShotMove, F64_384_BlockSlideMove, F64_3p14159_BlockReach, F64_3p14159_BlockShotMove, F64_3p14159_StartBlockAnim, F64_4272_BlockShotMove, F64_4272_BlockSlideMove
extern F64_4288, F64_4448_BlockShotMove, F64_4448_BlockSlideMove, F64_5_BlockReach, F64_6p28319_BlockReach, F64_6p28319_BlockShotMove, F64_6p28319_StartBlockAnim, F64_864_BlockShotMove
extern F64_864_BlockSlideMove, F64_neg3p14159_BlockReach, F64_neg3p14159_BlockShotMove, F64_neg3p14159_StartBlockAnim, F64_neg6p28319_BlockReach, F64_neg6p28319_BlockShotMove, F64_neg6p28319_StartBlockAnim, gmode
extern hypot_, IF@ATAN2, IF@DFMOD, LimitSkateSpeed, PickCrossoverAnim, PickGlideAnim, PickSkateAnim, PickStrideAnim
extern gmode2, PtrPuckFlags, PtrPuckOwner, puckc, PuckOnStickFromState, PuckOnStickPhysics, randomd0, ResetAnimTimer
extern SetSPA, SkateAnimAccel, SkateMoveTable, SpeedScale, StepMove, StickHandleScaled
global StartBlockAnim, BlockReach, KneelMove, BlockShotMoveJumpTable, BlockShotMove, BlockShotMove_471, BlockShotMove_481, BlockShotMove_63F
global BlockShotMove_671, BlockSlideMove
;-----------------------------------------------------------------------------
; StartBlockAnim                                  73B3C  97 PC, low confidence
; Starts a shot block animation
;-----------------------------------------------------------------------------
StartBlockAnim:
        push ebx
        push ecx
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 1Ch
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        fld dword [byte ecx+040h]
        fsub dword [byte eax+01Ch]
        fld qword [F64_6p28319_StartBlockAnim]
        fxch
        call IF@DFMOD
        fst dword [byte esp+018h]
        fst qword [byte esp+010h]
        fcomp qword [F64_3p14159_StartBlockAnim]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+010h]
        fadd qword [F64_neg6p28319_StartBlockAnim]
        fstp dword [byte esp+018h]
.1:
        fld dword [byte esp+018h]
        fst qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_StartBlockAnim]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+08h]
        fadd qword [F64_6p28319_StartBlockAnim]
        fstp dword [byte esp+018h]
.2:
        mov edx, dword [byte ecx+038h]
        cmp edx, 40A00000h
        jle near .7
        fld dword [byte esp+018h]
        fabs
        fst qword [esp]
        fcomp qword [F64_2p35619_StartBlockAnim]
        fnstsw ax
        sahf
        jbe short .3
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
        sete al
        and eax, 0FFh
        lea edx, [dword eax+0C1h]
        jmp near .6
.3:
        fld qword [esp]
        fcomp qword [F64_0p785398_StartBlockAnim]
        fnstsw ax
        sahf
        jae short .4
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
        sete al
        and eax, 0FFh
        lea edx, [dword eax+0BFh]
        jmp short .6
.4:
        cmp edx, 41700000h
        jle short .5
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
        sete al
        xor edx, edx
        mov dl, al
        add edx, 0BDh
        jmp short .6
.5:
        mov ah, byte [dword ecx+0D0h]
        xor edx, edx
        test ah, ah
        setne al
        fldz
        mov dl, al
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        sete al
        and eax, 0FFh
        lea edx, [dword eax+0BBh]
.6:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov bh, byte [dword ecx+0BFh]
        and bh, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        xor ebx, ebx
        push dword 3F800000h
        call SetSPA
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; BlockReach                                      73CE8  97 PC, low confidence
; Works out the reach of a block
;-----------------------------------------------------------------------------
BlockReach:
        push ebx
        push ecx
        push ebp
        mov ebp, esp
        sub esp, byte 4Ch
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov ecx, dword [dword eax+0FAh]
        mov eax, dword [dword eax+0EEh]
        fld dword [byte eax+010h]
        fmul qword [F64_6p28319_BlockReach]
        fmul qword [F64_1p52588eneg05_BlockReach]
        fsub dword [byte ebx+01Ch]
        fstp dword [byte esp+048h]
        call SpeedScale
        fld qword [F64_6p28319_BlockReach]
        fld dword [byte esp+048h]
        call IF@DFMOD
        fxch
        fdivr dword [byte ebx+038h]
        fmul qword [F64_1p33_BlockReach]
        fsubr qword [F64_2_BlockReach]
        mov dword [byte edx+04h], 0
        fmul qword [F64_0p0628319_BlockReach]
        mov eax, dword [byte edx+04h]
        mov dword [edx], eax
        mov eax, dword [byte ebx+038h]
        mov dword [byte edx+08h], eax
        fstp dword [byte esp+010h]
        fst dword [byte esp+048h]
        fst qword [byte esp+028h]
        fcomp qword [F64_3p14159_BlockReach]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+028h]
        fadd qword [F64_neg6p28319_BlockReach]
        fstp dword [byte esp+048h]
.1:
        fld dword [byte esp+048h]
        fst qword [byte esp+030h]
        fcomp qword [F64_neg3p14159_BlockReach]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+030h]
        fadd qword [F64_6p28319_BlockReach]
        fstp dword [byte esp+048h]
.2:
        fldz
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        ja short .5
        fld dword [byte esp+048h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        jbe short .3
        mov eax, dword [byte esp+010h]
        jmp short .4
.3:
        mov eax, dword [byte esp+048h]
.4:
        mov dword [byte esp+08h], eax
        mov eax, dword [byte esp+08h]
        jmp short .8
.5:
        fld dword [byte esp+048h]
        fld dword [byte esp+010h]
        fchs
        fstp dword [byte esp+0Ch]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jae short .6
        mov eax, dword [byte esp+0Ch]
        jmp short .7
.6:
        mov eax, dword [byte esp+048h]
.7:
        mov dword [byte esp+014h], eax
        mov eax, dword [byte esp+014h]
.8:
        mov dword [byte edx+04h], eax
        mov eax, dword [dword ebx+0EEh]
        fld dword [byte eax+04h]
        fsub dword [byte ebx+028h]
        fld dword [eax]
        fsub dword [byte ebx+020h]
        call IF@ATAN2
        fstp dword [edx]
        fld dword [byte ebx+01Ch]
        fadd dword [byte edx+04h]
        fsubr dword [edx]
        fstp dword [edx]
        mov eax, dword [dword ebx+0EEh]
        test byte [byte eax+029h], 1
        je short .9
        test dword [byte eax+024h], 7FFFFFFFh
        jne short .9
        fld dword [byte edx+08h]
        fld st0
        fmul qword [F64_0p8_BlockReach]
        fstp st1
        fstp dword [byte edx+08h]
        call SpeedScale
        fmul dword [F32_0p5_BlockReach]
        fcomp dword [byte edx+08h]
        fnstsw ax
        sahf
        jae near .17
        jmp near .16
.9:
        fld dword [byte ecx+018h]
        fcomp dword [byte ebx+038h]
        fnstsw ax
        sahf
        ja short .10
        mov eax, dword [byte ecx+018h]
        mov dword [byte edx+08h], eax
        jmp near .17
.10:
        fld dword [byte ecx+018h]
        fld dword [byte ebx+038h]
        fstp qword [byte esp+020h]
        fstp qword [byte esp+018h]
        fld qword [byte esp+020h]
        fadd qword [F64_5_BlockReach]
        fld qword [byte esp+018h]
        fxch
        fstp qword [byte esp+040h]
        fcomp qword [byte esp+040h]
        fnstsw ax
        sahf
        jbe short .11
        fld qword [byte esp+040h]
        jmp short .14
.11:
        cmp dword [byte ebx+038h], 40200000h
        jge short .15
        cmp dword [byte ecx+018h], 40200000h
        jle short .12
        mov eax, dword [byte esp+018h]
        mov dword [byte esp+038h], eax
        mov eax, dword [byte esp+01Ch]
        mov dword [byte esp+03Ch], eax
        jmp short .13
.12:
        xor ebx, ebx
        mov ecx, 40040000h
        mov dword [byte esp+038h], ebx
        mov dword [byte esp+03Ch], ecx
.13:
        fld qword [byte esp+038h]
.14:
        fstp dword [byte edx+08h]
.15:
        call SpeedScale
        fmul dword [F32_0p5_BlockReach]
        fcomp dword [byte edx+08h]
        fnstsw ax
        sahf
        jae short .17
.16:
        call SpeedScale
        fmul dword [F32_0p5_BlockReach]
        fstp dword [byte edx+08h]
.17:
        mov esp, ebp
        pop ebp
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; KneelMove                                       73F00  97 PC, low confidence
; Move handler for kneeling
;-----------------------------------------------------------------------------
KneelMove:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        mov ebx, eax
        mov edx, dword [byte eax+028h]
        mov ecx, dword [byte eax+02Ch]
        and edx, 0FFFFh
        mov eax, dword [dword ecx+0FAh]
        test byte [gmode], 1
        jne short .1
        movzx esi, byte [dword ecx+0A4h]
        mov dword [byte ebp-08h], esi
        mov esi, dword [puckc]
        movsx esi, byte [esi]
        mov dword [byte ebp-04h], esi
        mov esi, dword [byte ebp-08h]
        cmp esi, dword [byte ebp-04h]
        je short .5
.1:
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        push dword 3F800000h
        or ah, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        cmp edx, 102h
        je short .2
        cmp edx, 0E4h
        jne short .3
.2:
        mov edx, 103h
        jmp short .4
.3:
        mov edx, 106h
.4:
        mov eax, ecx
        call SetSPA
        jmp short .6
.5:
        fld dword [byte ecx+040h]
        xor eax, eax
        fsub dword [byte ecx+01Ch]
        mov dword [byte ebp-010h], eax
        fstp dword [byte ebp-014h]
        mov eax, dword [byte ecx+038h]
        lea edx, [byte ebp-014h]
        mov dword [byte ebp-0Ch], eax
        mov eax, ebx
        call StepMove
.6:
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
BlockShotMoveJumpTable:                         ; jump table for the switch cases of BlockShotMove
        dd BlockShotMove_671
        dd BlockShotMove_481
        dd BlockShotMove_63F
        dd BlockShotMove_471
;-----------------------------------------------------------------------------
; BlockShotMove                                   73FBC  97 PC, low confidence
; Move handler for blocking a shot
;-----------------------------------------------------------------------------
BlockShotMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 54h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov edi, dword [byte eax+028h]
        mov eax, dword [dword ecx+0AEh]
        and edi, 0FFFFh
        sar eax, 18h
        mov edx, dword [dword ecx+0FAh]
        cmp byte [dword ecx+eax+0B2h], 17h
        je near .20
        fld dword [byte ecx+028h]
        fabs
        fst qword [byte esp+048h]
        fcomp qword [F64_4272_BlockShotMove]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+048h]
        fcomp qword [F64_4448_BlockShotMove]
        fnstsw ax
        sahf
        ja near .20
        fld dword [byte ecx+020h]
        fabs
        fcomp qword [F64_384_BlockShotMove]
        fnstsw ax
        sahf
        ja near .20
.1:
        test byte [dword ecx+0BFh], 80h
        je short .2
        mov dword [byte esp+030h], 0FFFFEF50h
        jmp short .3
.2:
        mov dword [byte esp+030h], 10B0h
.3:
        fild dword [byte esp+030h]
        fsubr dword [byte ecx+028h]
        sub esp, byte 8
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte ecx+020h]
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_864_BlockShotMove]
        fnstsw ax
        sahf
        ja near .20
        test byte [gmode], 1
        jne near .16
        mov eax, ecx
        call StartBlockAnim
        test eax, eax
        jne near BlockShotMove_671.36
        test byte [dword ecx+0BFh], 80h
        setne al
        and eax, 0FFh
        mov dword [byte esp+018h], eax
        mov eax, dword [PtrPuckOwner]
        cmp word [eax], byte 0
        setg al
        mov esi, dword [byte esp+018h]
        and eax, 0FFh
        xor eax, esi
        je near .12
        mov esi, dword [PtrPuckOwner]
        mov ax, word [esi]
        test ax, ax
        jge short .4
        movsx esi, ax
        neg esi
        jmp short .5
.4:
        movsx esi, ax
.5:
        cmp esi, 570h
        jle near .12
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .6
        cmp byte [dword ecx+0A4h], 6
        setb al
        mov esi, eax
        mov eax, dword [puckc]
        and esi, 0FFh
        cmp byte [eax], 6
        setl al
        and eax, 0FFh
        cmp eax, esi
        je short .7
.6:
        mov eax, 1
        jmp short .8
.7:
        xor eax, esi
.8:
        test eax, eax
        je near .12
        fld dword [byte ecx+020h]
        fabs
        mov esi, 9Dh
        mov al, byte [dword ecx+0BFh]
        fstp dword [byte esp+014h]
        test al, 80h
        je short .9
        mov dword [byte esp+028h], 0FFFFEF50h
        jmp short .10
.9:
        mov dword [byte esp+028h], 10B0h
.10:
        fild dword [byte esp+028h]
        fsubr dword [byte ecx+028h]
        fld dword [byte esp+014h]
        fxch
        fstp dword [byte esp+050h]
        fcomp dword [F32_120]
        fnstsw ax
        sahf
        jbe near .11
        fld dword [byte esp+014h]
        fcomp dword [F32_168]
        fnstsw ax
        sahf
        jae short .11
        fld dword [byte esp+050h]
        fabs
        fcomp qword [F64_24_BlockShotMove]
        fnstsw ax
        sahf
        jae short .11
        fld dword [byte ecx+028h]
        fabs
        fcomp qword [F64_4288]
        fnstsw ax
        sahf
        jae short .11
        fldz
        fcomp dword [byte ecx+020h]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        mov dword [byte esp+010h], eax
        test byte [dword ecx+0BFh], 80h
        setne al
        mov esi, dword [byte esp+010h]
        and eax, 0FFh
        xor esi, eax
        mov ah, byte [dword ecx+0D0h]
        test ah, ah
        setne al
        and eax, 0FFh
        xor eax, esi
        sete al
        mov esi, eax
        and esi, 0FFh
        add esi, 0A1h
.11:
        cmp edi, esi
        je near .18
        mov eax, edx
        call ResetAnimTimer
        mov dh, byte [dword ecx+0BFh]
        mov ebx, 20h
        and dh, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], dh
        mov edx, esi
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
.12:
        test byte [dword ecx+0BFh], 80h
        setne al
        and eax, 0FFh
        mov dword [byte esp+020h], eax
        mov eax, dword [PtrPuckOwner]
        cmp word [eax], byte 0
        setl al
        mov esi, dword [byte esp+020h]
        and eax, 0FFh
        xor eax, esi
        je near .15
        mov esi, dword [PtrPuckOwner]
        mov ax, word [esi]
        test ax, ax
        jge short .13
        cwde
        neg eax
        jmp short .14
.13:
        cwde
.14:
        cmp eax, 570h
        jle short .15
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .15
        cmp byte [dword ecx+0A4h], 6
        setb al
        mov esi, eax
        mov eax, dword [puckc]
        and esi, 0FFh
        cmp byte [eax], 6
        setl al
        and eax, 0FFh
        cmp eax, esi
        jne short .15
        mov eax, 3
        call randomd0
        movsx esi, ax
        mov eax, edx
        mov esi, dword [nosplit esi*4+BlockShotMoveRight]
        call ResetAnimTimer
        mov dh, byte [dword ecx+0BFh]
        xor ebx, ebx
        and dh, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], dh
        mov edx, esi
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
.15:
        cmp edi, 9Eh
        je near .18
        mov eax, edx
        call ResetAnimTimer
        mov dl, byte [dword ecx+0BFh]
        mov ebx, 20h
        and dl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], dl
        mov edx, 9Eh
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
.16:
        test byte [gmode2], 1
        jne near .18
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 1Eh
        je near .18
        test byte [byte edx+031h], 2
        je short .17
        mov eax, 3
        call randomd0
        cwde
        mov esi, dword [nosplit eax*4+BlockShotMoveLeft]
        mov eax, edx
        call ResetAnimTimer
        mov dl, byte [dword ecx+0BFh]
        xor ebx, ebx
        and dl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], dl
        mov edx, esi
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
.17:
        mov eax, ecx
        call StartBlockAnim
        test eax, eax
        jne near BlockShotMove_671.36
        mov eax, 32h
        call randomd0
        movsx esi, ax
        cmp esi, byte 9
        jge short .18
        mov eax, edx
        mov esi, dword [nosplit esi*4+BlockShotAnims]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        xor ebx, ebx
        and ah, 0DFh
        mov edx, esi
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
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
.18:
        test byte [byte ebx+01Ch], 80h
        je short .19
        mov eax, ebx
        call EndMove
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.19:
        mov edx, esp
        mov eax, ecx
        call BlockReach
        mov edx, esp
        mov eax, ebx
        call StepMove
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.20:
        mov eax, dword [byte edx+01Ch]
        dec eax
        cmp eax, byte 3
        ja near BlockShotMove_671.34
        jmp dword [nosplit cs:eax*4+BlockShotMoveJumpTable]
BlockShotMove_471:
        mov eax, ecx
        call PickStrideAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
BlockShotMove_481:
        mov eax, ecx
        call PuckOnStickPhysics
        mov ebx, eax
        mov esi, eax
        mov eax, ecx
        push dword [byte ecx+038h]
        call PuckOnStickFromState
        mov eax, ebx
        shl ebx, 3
        fstp dword [byte esp+01Ch]
        sub ebx, eax
        fld dword [byte ecx+038h]
        mov eax, dword [dword ecx+0EEh]
        fadd dword [nosplit ebx*8+SkateMoveTable]
        mov edi, dword [byte eax+08h]
        fstp dword [byte esp+02Ch]
        cmp edi, 41400000h
        jge short .21
        fld dword [byte esp+02Ch]
        fsub dword [byte eax+08h]
        fcomp dword [F32_12_BlockShotMove]
        fnstsw ax
        sahf
        jbe short .21
        mov eax, ecx
        push dword [byte esp+02Ch]
        call StickHandleScaled
        fstp dword [byte esp+0Ch]
        jmp short .22
.21:
        xor eax, eax
        mov dword [byte esp+0Ch], eax
.22:
        cmp dword [byte ecx+038h], 41400000h
        jge near .29
        fld dword [byte esp+01Ch]
        fadd dword [byte esp+0Ch]
        fcomp dword [byte edx+018h]
        fnstsw ax
        sahf
        jb short .23
        mov eax, dword [dword ecx+0EEh]
        cmp dword [byte eax+08h], 41400000h
        jle near .29
        fld dword [byte eax+08h]
        fsub dword [byte ecx+038h]
        fcomp dword [F32_12_BlockShotMove]
        fnstsw ax
        sahf
        jbe near .29
.23:
        lea ebx, [nosplit esi*8+00h]
        sub ebx, esi
        mov al, byte [dword ecx+0D0h]
        shl ebx, 3
        test al, al
        je short .24
        fld dword [dword ebx+SkateAnimAccel]
        fchs
        fstp dword [byte esp+034h]
        jmp short .25
.24:
        mov eax, dword [dword ebx+SkateAnimAccel]
        mov dword [byte esp+034h], eax
.25:
        fld dword [byte edx+010h]
        fsub dword [byte esp+034h]
        mov eax, edx
        fstp dword [byte esp+024h]
        call ResetAnimTimer
        fldz
        fcomp dword [byte ecx+038h]
        fnstsw ax
        sahf
        jae short .26
        mov eax, dword [byte ecx+038h]
        mov dword [byte edx+08h], eax
        mov eax, dword [byte ecx+01Ch]
        mov dword [byte edx+034h], eax
.26:
        fld dword [byte ecx+01Ch]
        fsubr dword [byte esp+024h]
        fld qword [F64_6p28319_BlockShotMove]
        fxch
        call IF@DFMOD
        fst dword [byte edx+0Ch]
        fst qword [byte esp+038h]
        fcomp qword [F64_3p14159_BlockShotMove]
        fnstsw ax
        sahf
        jbe short .27
        fld qword [byte esp+038h]
        fadd qword [F64_neg6p28319_BlockShotMove]
        fstp dword [byte edx+0Ch]
.27:
        fld dword [byte edx+0Ch]
        fst qword [byte esp+040h]
        fcomp qword [F64_neg3p14159_BlockShotMove]
        fnstsw ax
        sahf
        jae short .28
        fld qword [byte esp+040h]
        fadd qword [F64_6p28319_BlockShotMove]
        fstp dword [byte edx+0Ch]
.28:
        fld dword [byte edx+0Ch]
        fmul dword [F32_0p1_BlockShotMove]
        fstp dword [byte edx+0Ch]
        mov ah, byte [dword ecx+0BFh]
        xor ebx, ebx
        and ah, 0DFh
        mov edx, esi
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
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
.29:
        mov eax, edx
        call ResetAnimTimer
        mov dl, byte [dword ecx+0BFh]
        mov ebx, 20h
        and dl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], dl
        mov edx, 6
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
BlockShotMove_63F:
        cmp dword [byte edx+018h], 43C00000h
        jle short .30
        cmp dword [byte ecx+038h], 41400000h
        jle short .30
        mov eax, ecx
        call PickCrossoverAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.30:
        mov eax, ecx
        call PickGlideAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
BlockShotMove_671:
        test byte [gmode], 1
        je near .34
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 1Eh
        je near .34
        mov esi, dword [PtrPuckFlags]
        mov eax, dword [dword esi+0AEh]
        sar eax, 18h
        cmp byte [dword esi+eax+0B2h], 43h
        jne short .31
        test byte [dword esi+0BFh], 2
        je short .34
.31:
        test byte [byte edx+031h], 2
        je short .32
        mov eax, 3
        call randomd0
        cwde
        mov esi, dword [nosplit eax*4+BlockShotMoveLeft]
        jmp short .33
.32:
        mov eax, 9
        call randomd0
        cwde
        mov esi, dword [nosplit eax*4+BlockShotAnims]
.33:
        mov eax, edx
        call ResetAnimTimer
        mov bh, byte [dword ecx+0BFh]
        mov edx, esi
        and bh, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        xor ebx, ebx
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
.34:
        test byte [byte ebx+01Ch], 80h
        je short .35
        mov eax, ebx
        call EndMove
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.35:
        test byte [gmode2], 1
        jne short .36
        mov edx, esp
        mov eax, ecx
        call LimitSkateSpeed
        mov edx, esp
        mov eax, ebx
        call StepMove
.36:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; BlockSlideMove                                  74708  97 PC, low confidence
; Move handler for sliding to block
;-----------------------------------------------------------------------------
BlockSlideMove:
        push ebx
        push ecx
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 18h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov ebx, dword [byte eax+02Ch]
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        cmp byte [dword ebx+eax+0B2h], 17h
        je near .4
        fld dword [byte ebx+028h]
        fabs
        fst qword [byte esp+010h]
        fcomp qword [F64_4272_BlockSlideMove]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+010h]
        fcomp qword [F64_4448_BlockSlideMove]
        fnstsw ax
        sahf
        ja short .4
        fld dword [byte ebx+020h]
        fabs
        fcomp qword [F64_384_BlockSlideMove]
        fnstsw ax
        sahf
        ja short .4
.1:
        test byte [dword ebx+0BFh], 80h
        je short .2
        mov dword [byte esp+0Ch], 0FFFFEF50h
        jmp short .3
.2:
        mov dword [byte esp+0Ch], 10B0h
.3:
        fild dword [byte esp+0Ch]
        fsubr dword [byte ebx+028h]
        sub esp, byte 8
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte ebx+020h]
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_864_BlockSlideMove]
        fnstsw ax
        sahf
        jbe short .5
.4:
        mov eax, ebx
        call PickSkateAnim
        jmp short .7
.5:
        test byte [byte ecx+01Ch], 80h
        je short .6
        mov eax, ebx
        call StartBlockAnim
        test eax, eax
        jne short .7
        mov eax, ecx
        call EndMove
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        mov edx, esp
        mov eax, ebx
        call BlockReach
        mov edx, esp
        mov eax, ecx
        call StepMove
.7:
        mov esp, ebp
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
