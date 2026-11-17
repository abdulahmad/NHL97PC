; Passing animations and moves.
bits 32
%include "hockey.inc"
section s_69B94 progbits alloc exec nowrite align=1
extern __CHP, AdvanceMoveAnim, assinsert, BlendToAnim, BreakawayFlag, ClearAnimFlags, CommentaryEvent, EndMove
extern F64_0p6_StartDropPassAnim, F64_0p6_StartPassAnim, F64_0p785398_StartPassAnim, F64_1p5708_StartPassAnim, F64_25_PassMove, F64_3p14159_StartDropPassAnim, F64_3p14159_StartPassAnim, F64_3p14159_StartShotAnim
extern F64_6p28319_StartDropPassAnim, F64_6p28319_StartPassAnim, F64_6p28319_StartShotAnim, F64_neg3p14159_StartDropPassAnim, F64_neg3p14159_StartPassAnim, F64_neg3p14159_StartShotAnim, F64_neg6p28319_StartDropPassAnim, F64_neg6p28319_StartPassAnim
extern F64_neg6p28319_StartShotAnim, GetAnimId, gmode, IF@ATAN2, IF@DFMOD, IsCameraOnPuck, LastTouchPlayer, MoveFuncPair
extern MoveFuncTable, MoveState, onetimerplayer, OneTimerReady, PassFrom, PassReceiver, PassTo, PickSkateAnim
extern PlaySfxVolume, PtrPuckFlags, PtrPuckZone, randomd0, ResetAnimTimer, SetAnimFrame, SetFaceBlink, SetFaceExpression
extern SetFaceMouth, SetSPA, ShotAnimFrames, ShotState, ShotTarget, ShotType, SortCords, SpeedScale
extern StepMove, StrideSpeeds, TryStickTouch
global StartPassAnim, PassAnimFrame, StartDropPassAnim, StartShotAnim, StartOneTimerAnim, StartWristShotAnim, StartPuckReceiveAnim, ReceivePassMove
global PassAnimFrameForType, PassMove
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; StartPassAnim                                   69BA0  97 PC, low confidence
; Starts the passing animation
;-----------------------------------------------------------------------------
StartPassAnim:
        push ebx
        push ecx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 24h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov eax, dword [byte edx+04h]
        mov ebx, dword [byte ecx+04h]
        sar eax, 10h
        sar ebx, 10h
        sub eax, ebx
        mov edx, dword [byte edx+0Ch]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte ecx+0Ch]
        sar edx, 10h
        sar eax, 10h
        sub edx, eax
        mov dword [byte esp+08h], edx
        fild dword [byte esp+08h]
        fild dword [byte esp+0Ch]
        call IF@ATAN2
        fsub dword [byte ecx+01Ch]
        fld qword [F64_6p28319_StartPassAnim]
        fxch
        call IF@DFMOD
        mov edx, dword [dword ecx+0FAh]
        fst dword [byte esp+020h]
        fst qword [byte esp+010h]
        fcomp qword [F64_3p14159_StartPassAnim]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+010h]
        fadd qword [F64_neg6p28319_StartPassAnim]
        fstp dword [byte esp+020h]
.1:
        fld dword [byte esp+020h]
        fst qword [byte esp+018h]
        fcomp qword [F64_neg3p14159_StartPassAnim]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+018h]
        fadd qword [F64_6p28319_StartPassAnim]
        fstp dword [byte esp+020h]
.2:
        cmp word [dword ecx+0A9h], byte 0
        jne near .7
        fld dword [byte esp+020h]
        fabs
        fcomp qword [F64_0p785398_StartPassAnim]
        fnstsw ax
        sahf
        jae short .3
        mov esi, 0FEh
        jmp short .6
.3:
        cmp byte [dword ecx+0D0h], 0
        setne al
        xor ebx, ebx
        fldz
        mov bl, al
        fcomp dword [byte esp+020h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, ebx
        je short .5
        fld dword [byte esp+020h]
        fabs
        fcomp qword [F64_1p5708_StartPassAnim]
        fnstsw ax
        sahf
        jae short .4
        mov esi, 0FCh
        and byte [byte edx+031h], 0FDh
        call IsCameraOnPuck
        jmp near .11
.4:
        mov esi, 0FBh
        and byte [byte edx+031h], 0FDh
        call IsCameraOnPuck
        jmp near .11
.5:
        mov esi, 0FDh
.6:
        and byte [byte edx+031h], 0FDh
        call IsCameraOnPuck
        jmp short .11
.7:
        mov ah, byte [dword ecx+0D0h]
        xor ebx, ebx
        test ah, ah
        setne al
        fldz
        mov bl, al
        fcomp dword [byte esp+020h]
        fnstsw ax
        sahf
        setbe al
        and eax, 0FFh
        xor eax, ebx
        je short .9
        fld dword [byte esp+020h]
        fabs
        fcomp qword [F64_0p785398_StartPassAnim]
        fnstsw ax
        sahf
        jbe short .8
        mov esi, 27h
        jmp short .11
.8:
        mov esi, 28h
        jmp short .11
.9:
        fld dword [byte esp+020h]
        fabs
        fcomp qword [F64_0p785398_StartPassAnim]
        fnstsw ax
        sahf
        jbe short .10
        mov esi, 25h
        jmp short .11
.10:
        mov esi, 26h
.11:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov ebx, esi
        lea eax, [nosplit esi*8+00h]
        sub eax, esi
        fld dword [byte ecx+038h]
        fsub dword [nosplit eax*8+StrideSpeeds]
        mov dword [byte edx+034h], 461C4000h
        fld st0
        fmul qword [F64_0p6_StartPassAnim]
        mov dword [byte edx+04h], 3F19999Ah
        fstp st1
        fstp dword [byte edx+08h]
        mov al, byte [dword ecx+0BFh]
        xor ebx, esi
        and al, 0DFh
        mov edx, esi
        mov byte [dword ecx+0BFh], al
        mov eax, ecx
        push dword 3F19999Ah
        call SetSPA
        mov eax, dword [dword ecx+0FAh]
        and byte [byte eax+030h], 0FEh
        mov eax, ecx
        call PassAnimFrame
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PassAnimFrame                                   69D98  97 PC, low confidence
; Picks the frame of the passing animation
;-----------------------------------------------------------------------------
PassAnimFrame:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 4
        mov ebx, dword [dword eax+0F6h]
        xor edx, edx
        mov ebx, dword [ebx]
        mov esi, dword [PtrPuckZone]
        mov dl, byte [dword eax+0A4h]
        mov ecx, dword [byte ebx+028h]
        movsx esi, byte [esi]
        and ecx, 0FFFFh
        cmp edx, esi
        jne short .1
        test byte [dword eax+0BFh], 20h
        jne short .1
        mov edx, esp
        mov eax, ecx
        call PassAnimFrameForType
        mov edx, dword [esp]
        test edx, edx
        jl short .1
        cmp edx, dword [byte ebx+04h]
        jle short .1
        dec edx
        mov eax, ebx
        call SetAnimFrame
.1:
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; StartDropPassAnim                               69DF4  97 PC, low confidence
; Starts the drop pass animation
;-----------------------------------------------------------------------------
StartDropPassAnim:
        push ecx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 24h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov eax, dword [byte eax+04h]
        sar eax, 10h
        sub edx, eax
        mov eax, dword [byte ecx+0Ch]
        sar eax, 10h
        sub ebx, eax
        mov dword [byte esp+0Ch], edx
        mov dword [byte esp+08h], ebx
        fild dword [byte esp+08h]
        fild dword [byte esp+0Ch]
        call IF@ATAN2
        fsub dword [byte ecx+01Ch]
        fld qword [F64_6p28319_StartDropPassAnim]
        fxch
        call IF@DFMOD
        mov edx, dword [dword ecx+0FAh]
        fst dword [byte esp+020h]
        fst qword [byte esp+010h]
        fcomp qword [F64_3p14159_StartDropPassAnim]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+010h]
        fadd qword [F64_neg6p28319_StartDropPassAnim]
        fstp dword [byte esp+020h]
.1:
        fld dword [byte esp+020h]
        fst qword [byte esp+018h]
        fcomp qword [F64_neg3p14159_StartDropPassAnim]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+018h]
        fadd qword [F64_6p28319_StartDropPassAnim]
        fstp dword [byte esp+020h]
.2:
        cmp word [dword ecx+0A9h], byte 0
        jne short .3
        mov bl, byte [byte edx+031h]
        and bl, 0FDh
        mov esi, 0FFh
        mov byte [byte edx+031h], bl
        call IsCameraOnPuck
        jmp short .5
.3:
        mov ah, byte [dword ecx+0D0h]
        xor ebx, ebx
        test ah, ah
        setne al
        fldz
        mov bl, al
        fcomp dword [byte esp+020h]
        fnstsw ax
        sahf
        setbe al
        and eax, 0FFh
        xor eax, ebx
        je short .4
        mov esi, 31h
        jmp short .5
.4:
        mov esi, 30h
.5:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        lea eax, [nosplit esi*8+00h]
        sub eax, esi
        fld dword [byte ecx+038h]
        fsub dword [nosplit eax*8+StrideSpeeds]
        mov dword [byte edx+034h], 461C4000h
        fld st0
        fmul qword [F64_0p6_StartDropPassAnim]
        mov dword [byte edx+04h], 3F19999Ah
        fstp st1
        fstp dword [byte edx+08h]
        mov bh, byte [dword ecx+0BFh]
        mov eax, ecx
        and bh, 0DFh
        mov edx, esi
        mov byte [dword ecx+0BFh], bh
        xor ebx, ebx
        push dword 3F19999Ah
        call SetSPA
        mov eax, dword [dword ecx+0FAh]
        and byte [byte eax+030h], 0FEh
        mov eax, ecx
        call PassAnimFrame
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; StartShotAnim                                   69F3C  97 PC, low confidence
; Starts the shooting animation
;-----------------------------------------------------------------------------
StartShotAnim:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 1Ch
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov eax, dword [byte eax+04h]
        mov edx, dword [ShotTarget]
        sar eax, 10h
        sar edx, 10h
        sub edx, eax
        mov dword [byte esp+04h], edx
        mov eax, dword [byte ecx+0Ch]
        mov edx, dword [ShotType]
        sar eax, 10h
        sar edx, 10h
        sub edx, eax
        mov dword [esp], edx
        fild dword [esp]
        fild dword [byte esp+04h]
        call IF@ATAN2
        fsub dword [byte ecx+01Ch]
        fld qword [F64_6p28319_StartShotAnim]
        fxch
        call IF@DFMOD
        mov esi, dword [dword ecx+0FAh]
        fst dword [byte esp+018h]
        fst qword [byte esp+08h]
        fcomp qword [F64_3p14159_StartShotAnim]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+08h]
        fadd qword [F64_neg6p28319_StartShotAnim]
        fstp dword [byte esp+018h]
.1:
        fld dword [byte esp+018h]
        fst qword [byte esp+010h]
        fcomp qword [F64_neg3p14159_StartShotAnim]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+010h]
        fadd qword [F64_6p28319_StartShotAnim]
        fstp dword [byte esp+018h]
.2:
        cmp dword [ShotState], byte 0
        jne short .4
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
        je short .3
        mov edx, 2Fh
        jmp short .7
.3:
        mov edx, 2Eh
        jmp short .7
.4:
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
        je short .5
        mov edx, 2Dh
        jmp short .7
.5:
        cmp dword [byte ecx+038h], 41400000h
        jge short .6
        mov edx, 29h
        jmp short .7
.6:
        mov edx, 2Ah
.7:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov eax, dword [dword ecx+0FAh]
        mov dword [byte eax+020h], 1
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        fld dword [byte ecx+038h]
        fsub dword [nosplit eax*8+StrideSpeeds]
        mov dword [byte esi+034h], 461C4000h
        fstp dword [byte esi+08h]
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        xor ebx, ebx
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0FAh]
        and byte [byte eax+030h], 0FEh
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; StartOneTimerAnim                               6A0BC  97 PC, low confidence
; Starts the one-timer animation
;-----------------------------------------------------------------------------
StartOneTimerAnim:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov eax, dword [dword eax+0FAh]
        mov dword [byte eax+020h], 0
        mov eax, dword [dword ecx+0F6h]
        mov edx, 800h
        mov eax, dword [eax]
        call ClearAnimFlags
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        mov ebx, 20h
        and ah, 0DFh
        mov edx, 32h
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        xor edx, edx
        mov eax, dword [PtrPuckZone]
        mov dl, byte [dword ecx+0A4h]
        movsx eax, byte [eax]
        cmp edx, eax
        jne short .1
        mov eax, dword [dword ecx+0FAh]
        test byte [byte eax+030h], 1
        jne short .1
        mov eax, ecx
        call StartPuckReceiveAnim
.1:
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; StartWristShotAnim                              6A13C  97 PC, low confidence
; Starts the wrist shot animation
;-----------------------------------------------------------------------------
StartWristShotAnim:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov ecx, eax
        mov esi, dword [dword eax+0F6h]
        mov edx, dword [PtrPuckZone]
        mov esi, dword [esi]
        movsx edx, byte [edx]
        xor eax, eax
        mov edi, dword [byte esi+028h]
        mov al, byte [dword ecx+0A4h]
        and edi, 0FFFFh
        cmp eax, edx
        je short .1
        cmp word [OneTimerReady], byte 0
        je near .3
.1:
        test byte [dword ecx+0BFh], 20h
        jne near .3
        mov ebx, esp
        lea edx, [byte esp+04h]
        mov eax, edi
        call ShotAnimFrames
        cmp dword [byte esp+04h], byte 0
        jl near .3
        mov eax, dword [dword ecx+0FAh]
        mov edx, 800h
        mov dword [byte eax+020h], 0
        mov eax, esi
        call ClearAnimFlags
        mov ebx, dword [byte esp+04h]
        mov edx, dword [byte esi+04h]
        cmp edx, ebx
        jge near .3
        mov eax, dword [esp]
        mov ebp, ebx
        sub eax, ebx
        sub ebx, edx
        imul eax, ebx
        mov dword [byte esp+08h], eax
        fild dword [byte esp+08h]
        fild dword [byte esp+04h]
        fdivp
        mov edx, ebp
        call __CHP
        fistp dword [byte esp+08h]
        add edx, dword [byte esp+08h]
        dec edx
        mov eax, esi
        call SetAnimFrame
        cmp edi, byte 29h
        je short .2
        cmp edi, byte 2Bh
        je short .2
        cmp edi, byte 2Ch
        je short .2
        cmp edi, byte 2Ah
        jne short .3
.2:
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
.3:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StartPuckReceiveAnim                            6A244  97 PC, low confidence
; Starts the animation for receiving the puck
;-----------------------------------------------------------------------------
StartPuckReceiveAnim:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 4
        mov ecx, eax
        mov edi, dword [dword eax+0F6h]
        mov edi, dword [edi]
        mov esi, MoveState
        mov edx, dword [byte edi+028h]
        mov bx, word [dword eax+0A9h]
        and edx, 0FFFFh
        test bx, bx
        jne short .1
        mov eax, dword [dword eax+0FAh]
        test byte [byte eax+031h], 2
        jne near .22
.1:
        mov bh, byte [dword ecx+0A4h]
        cmp bh, 0Ch
        je near .22
        xor eax, eax
        mov al, bh
        mov dword [byte ebp-04h], eax
        mov eax, dword [PtrPuckZone]
        mov ebx, dword [byte ebp-04h]
        movsx eax, byte [eax]
        cmp eax, ebx
        jne near .22
        mov eax, dword [dword ecx+0FAh]
        test byte [byte eax+030h], 1
        jne near .22
        cmp edx, byte 1Ch
        jb near .5
        cmp edx, byte 1Fh
        jbe near .16
        cmp edx, 9Dh
        jb short .3
        cmp edx, 9Eh
        jbe near .12
        cmp edx, 0A3h
        jb short .2
        jbe near .10
        cmp edx, 0A4h
        jbe near .9
        cmp edx, 0BAh
        je near .11
        jmp near .22
.2:
        cmp edx, 0A0h
        je near .12
        jmp near .22
.3:
        cmp edx, byte 33h
        jb short .4
        jbe near .14
        cmp edx, 9Bh
        je near .12
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        cmp edx, byte 32h
        je near .16
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        cmp edx, byte 9
        jb short .7
        cmp edx, byte 0Ah
        jbe near .14
        cmp edx, byte 11h
        jb short .6
        jbe near .15
        cmp edx, byte 12h
        jbe near .13
        cmp edx, byte 14h
        jb near .22
        cmp edx, byte 15h
        jbe near .19
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        cmp edx, byte 0Ch
        jbe near .15
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        cmp edx, byte 4
        jb short .8
        cmp edx, byte 6
        jbe near .13
        jmp near .18
.8:
        cmp edx, byte 1
        jb near .22
        cmp edx, byte 2
        jbe near .15
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        call ResetAnimTimer
        mov al, byte [dword ecx+0BFh]
        mov ebx, 20h
        and al, 0DFh
        mov edx, 0A6h
        mov byte [dword ecx+0BFh], al
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
.10:
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        mov ebx, 20h
        and ah, 0DFh
        mov edx, 0A5h
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
.11:
        call ResetAnimTimer
        mov bh, byte [dword ecx+0BFh]
        mov edx, 100h
        and bh, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        mov ebx, 20h
        push dword 3F800000h
        call SetSPA
        mov eax, dword [byte edi+04h]
        mov dword [byte esi+010h], eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.12:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov dl, byte [dword ecx+0BFh]
        mov ebx, 20h
        and dl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], dl
        mov edx, 9Ch
        push dword 3F800000h
        call SetSPA
        mov dword [byte esi+010h], 0
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.13:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov al, byte [dword ecx+0BFh]
        mov ebx, 20h
        and al, 0DFh
        mov edx, 33h
        mov byte [dword ecx+0BFh], al
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
.14:
        mov eax, dword [byte edi+04h]
        mov dword [byte esi+010h], eax
        jmp near .17
.15:
        mov eax, ecx
        call PickSkateAnim
.16:
        mov dword [byte esi+010h], 0
.17:
        mov eax, dword [dword ecx+0FAh]
        test byte [byte eax+030h], 1
        jne near .22
        mov dword [esi], 34h
        mov eax, dword [esi]
        mov eax, dword [nosplit eax*4+MoveFuncPair]
        mov dword [byte esi+018h], 3F800000h
        mov dword [byte esi+08h], eax
        mov eax, dword [dword ecx+0F2h]
        fld dword [byte eax+03Ch]
        mov dword [byte esi+0Ch], 20h
        mov dword [byte esi+04h], ecx
        mov eax, dword [esi]
        fstp dword [byte esi+014h]
        mov eax, dword [nosplit eax*4+MoveFuncTable]
        mov dword [byte esi+024h], eax
        cmp byte [dword ecx+0D0h], 0
        je near .20
        or byte [byte esi+0Ch], 8
        jmp near .21
.18:
        call ResetAnimTimer
        mov bh, byte [dword ecx+0BFh]
        and bh, 0DFh
        push dword 3F800000h
        mov byte [dword ecx+0BFh], bh
        mov ebx, 20h
        cmp edx, byte 7
        setne al
        xor edx, edx
        mov dl, al
        add edx, byte 35h
        mov eax, ecx
        call SetSPA
        mov dword [byte esi+010h], 0
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.19:
        call ResetAnimTimer
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        push dword 3F800000h
        mov byte [dword ecx+0BFh], bl
        mov ebx, 20h
        cmp edx, byte 14h
        setne al
        xor edx, edx
        mov dl, al
        add edx, byte 39h
        mov eax, ecx
        call SetSPA
        mov dword [byte esi+010h], 0
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.20:
        and byte [byte esi+0Ch], 0F7h
.21:
        mov eax, dword [dword ecx+0FAh]
        or byte [byte eax+030h], 1
        mov eax, dword [dword ecx+0F6h]
        mov edx, esi
        mov eax, dword [eax]
        push dword 3F800000h
        call BlendToAnim
.22:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReceivePassMove                                 6A604  97 PC, low confidence
; Move handler for receiving a pass
;-----------------------------------------------------------------------------
ReceivePassMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edx, eax
        mov ecx, dword [byte eax+02Ch]
        mov eax, dword [dword ecx+0F6h]
        mov esi, dword [PtrPuckZone]
        mov ebx, dword [dword ecx+0FAh]
        mov eax, dword [eax]
        movzx edi, byte [dword ecx+0A4h]
        mov eax, dword [byte eax+028h]
        movsx esi, byte [esi]
        and eax, 0FFFFh
        cmp edi, esi
        jne near .2
        cmp word [dword ecx+0A9h], byte 0
        jne short .1
        test byte [byte ebx+031h], 2
        jne near .2
.1:
        test byte [byte ebx+030h], 1
        je near .2
        cmp eax, byte 29h
        je near .2
        cmp eax, byte 2Bh
        je near .2
        cmp eax, byte 2Ch
        je near .2
        cmp eax, byte 2Ah
        je near .2
        cmp eax, byte 2Eh
        je short .2
        cmp eax, byte 2Fh
        je short .2
        cmp eax, byte 25h
        je short .2
        cmp eax, byte 26h
        je short .2
        cmp eax, byte 27h
        je short .2
        cmp eax, byte 28h
        je short .2
        cmp eax, byte 30h
        je short .2
        cmp eax, byte 31h
        je short .2
        cmp eax, 0FBh
        je short .2
        cmp eax, 0FDh
        je short .2
        cmp eax, 0FCh
        je short .2
        cmp eax, 0FEh
        je short .2
        cmp eax, 0FFh
        jne short .3
.2:
        or byte [byte edx+01Ch], 80h
        and byte [byte ebx+030h], 0FEh
.3:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PassAnimFrameForType                            6A6D8  97 PC, low confidence
; Returns the animation frame for a pass type
;-----------------------------------------------------------------------------
PassAnimFrameForType:
        cmp eax, byte 31h
        jb short .2
        jbe near .5
        cmp eax, 0FDh
        jb short .1
        jbe near .9
        cmp eax, 0FEh
        jbe near .10
        cmp eax, 0FFh
        je near .11
        jmp near .12
.1:
        cmp eax, 0FBh
        jb short .12
        jbe short .7
        jmp short .8
.2:
        cmp eax, byte 27h
        jb short .3
        jbe short .4
        cmp eax, byte 28h
        jbe short .4
        cmp eax, byte 30h
        je short .6
        mov dword [edx], 0FFFFFFFFh
        ret
.3:
        cmp eax, byte 25h
        jb short .12
        mov dword [edx], 6
        ret
.4:
        mov dword [edx], 0Ch
        ret
.5:
        mov dword [edx], 21h
        ret
.6:
        mov dword [edx], 3
        ret
.7:
        mov dword [edx], 1Ah
        ret
.8:
        mov dword [edx], 15h
        ret
.9:
        mov dword [edx], 11h
        ret
.10:
        mov dword [edx], 23h
        ret
.11:
        mov dword [edx], 27h
        ret
.12:
        mov dword [edx], 0FFFFFFFFh
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PassMove                                        6A77C  97 PC, low confidence
; Move handler for a pass
;-----------------------------------------------------------------------------
PassMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 20h
        mov ecx, eax
        mov edi, dword [byte eax+028h]
        lea edx, [byte ebp-014h]
        and edi, 0FFFFh
        mov ebx, dword [byte eax+02Ch]
        mov eax, edi
        call PassAnimFrameForType
        xor edx, edx
        mov eax, dword [PtrPuckZone]
        mov dl, byte [dword ebx+0A4h]
        movsx eax, byte [eax]
        cmp edx, eax
        je short .1
        cmp dword [byte ebp-014h], byte 0FFFFFFFFh
        jne near .28
        or byte [byte ecx+01Ch], 80h
        jmp near .28
.1:
        test byte [byte ecx+01Ch], 80h
        je short .2
        xor eax, eax
        jmp short .3
.2:
        mov eax, ecx
        call GetAnimId
.3:
        mov edx, eax
        cmp edi, byte 31h
        je short .4
        cmp edi, byte 30h
        je short .4
        cmp edi, 0FBh
        je short .4
        cmp edi, 0FCh
        je short .4
        cmp edi, 0FDh
        je short .4
        cmp edi, 0FEh
        je short .4
        cmp edi, 0FFh
        jne short .5
.4:
        mov eax, dword [byte ecx+04h]
        cmp eax, dword [byte ebp-014h]
        je short .6
.5:
        test dl, 2
        je near .28
.6:
        mov eax, dword [PtrPuckZone]
        mov byte [eax], 0FFh
        mov eax, dword [dword ebx+0FAh]
        mov dword [byte ebx+064h], 10h
        or byte [byte eax+031h], 1
        cmp word [onetimerplayer], byte 0
        jl short .7
        mov edx, dword [PassReceiver]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov esi, SortCords
        shl eax, 3
        add esi, eax
        mov edx, esi
        mov eax, ebx
        call TryStickTouch
        mov edx, dword [PtrPuckFlags]
        mov dword [byte edx+060h], eax
        jmp short .8
.7:
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+060h], 0FFFFFFFFh
.8:
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [dword eax+0EEh]
        fld dword [byte edx+08h]
        fstp dword [byte eax+038h]
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [dword eax+0EEh]
        fld dword [byte edx+0Ch]
        fstp dword [byte eax+040h]
        mov edx, dword [PtrPuckFlags]
        fld dword [byte edx+040h]
        fsin
        fmul dword [byte edx+038h]
        fstp dword [byte edx+02Ch]
        mov edx, dword [PtrPuckFlags]
        fld dword [byte edx+040h]
        fcos
        fmul dword [byte edx+038h]
        fstp dword [byte edx+034h]
        cmp edi, byte 31h
        je short .9
        cmp edi, byte 30h
        jne short .10
.9:
        mov eax, 0Fh
        call randomd0
        mov dword [byte ebp-04h], eax
        fild word [byte ebp-04h]
        fadd qword [F64_25_PassMove]
        mov eax, dword [PtrPuckFlags]
        jmp short .11
.10:
        mov eax, 19h
        call randomd0
        mov dword [byte ebp-04h], eax
        mov eax, dword [PtrPuckFlags]
        fild word [byte ebp-04h]
.11:
        fstp dword [byte eax+030h]
        cmp word [dword ebx+0A9h], byte 0
        jne near .15
        cmp byte [dword ebx+0D0h], 0
        je short .12
        mov eax, dword [PtrPuckFlags]
        mov dword [byte ebp-08h], eax
        xor eax, eax
        mov al, byte [dword ebx+0CEh]
        mov edx, 0Fh
        call randomd0
        cwde
        sub edx, eax
        mov dword [byte ebp-010h], edx
        mov eax, dword [byte ebp-08h]
        fild dword [byte ebp-010h]
        jmp short .13
.12:
        mov eax, dword [PtrPuckFlags]
        mov dword [byte ebp-010h], eax
        xor eax, eax
        mov al, byte [dword ebx+0C9h]
        mov edx, 0Fh
        call randomd0
        cwde
        sub edx, eax
        mov dword [byte ebp-08h], edx
        mov eax, dword [byte ebp-010h]
        fild dword [byte ebp-08h]
.13:
        fadd dword [byte eax+030h]
        fstp dword [byte eax+030h]
        cmp edi, 0FFh
        jne short .14
        mov eax, 40Ah
        jmp short .16
.14:
        mov eax, 408h
        jmp short .16
.15:
        mov eax, 404h
.16:
        mov edx, dword [PtrPuckFlags]
        push dword [byte edx+028h]
        push dword [byte edx+020h]
        mov edx, 64h
        call PlaySfxVolume
        cmp word [onetimerplayer], byte 0
        jl near .27
        mov eax, dword [PtrPuckFlags]
        mov edx, 0Eh
        mov word [byte eax+06Dh], 1
        mov eax, esi
        call assinsert
        mov eax, dword [dword esi+0FAh]
        mov dword [byte eax+01Ch], 0
        mov eax, esi
        call PickSkateAnim
        test byte [gmode], 1
        jne near .28
        cmp word [BreakawayFlag], byte 0
        jne near .28
        cmp word [dword ebx+0A9h], byte 0
        jne short .17
        mov eax, dword [dword ebx+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        mov edi, dword [dword ebx+0FEh]
        mov edi, dword [dword edi+0108h]
        add edi, 1D42h
        add edi, eax
        jmp short .18
.17:
        mov eax, dword [dword ebx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ebx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        add edx, 0A3h
        lea edi, [edx+eax]
.18:
        cmp word [dword esi+0A9h], byte 0
        jne short .19
        mov edx, dword [dword esi+0A3h]
        sar edx, 18h
        sub edx, byte 19h
        imul edx, dword 125h
        mov eax, dword [dword esi+0FEh]
        mov eax, dword [dword eax+0108h]
        add eax, 1D42h
        jmp short .20
.19:
        mov edx, dword [dword esi+0A3h]
        sar edx, 18h
        imul edx, dword 125h
        mov eax, dword [dword esi+0FEh]
        mov eax, dword [dword eax+0108h]
        add eax, 0A3h
.20:
        add edx, eax
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+05Ah], byte 4
        jge short .21
        mov eax, 2002h
        jmp short .22
.21:
        mov eax, 2000h
.22:
        mov dword [PassTo], eax
        mov eax, dword [PtrPuckFlags]
        mov dword [byte ebp-0Ch], eax
        cmp dword [byte eax+030h], 41B80000h
        jl short .23
        mov dword [PassFrom], 2004h
        jmp short .26
.23:
        call SpeedScale
        mov eax, dword [byte ebp-0Ch]
        fcomp dword [byte eax+038h]
        fnstsw ax
        sahf
        jb short .24
        mov dword [PassFrom], 2005h
        jmp short .26
.24:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+05Ah], byte 10h
        jge short .25
        mov dword [PassFrom], 2006h
        jmp short .26
.25:
        mov dword [PassFrom], 2003h
.26:
        mov eax, dword [LastTouchPlayer]
        push eax
        mov eax, dword [PassFrom]
        push eax
        mov eax, dword [PassTo]
        push eax
        lea eax, [byte esi+028h]
        push eax
        add esi, byte 20h
        push esi
        push edx
        lea eax, [byte ebx+028h]
        push eax
        lea eax, [byte ebx+020h]
        push eax
        mov ah, byte [dword ebx+0BFh]
        push edi
        test ah, 80h
        setne al
        and eax, 0FFh
        push eax
        push dword 0A0000001h
        call CommentaryEvent
        add esp, byte 2Ch
        jmp short .28
.27:
        mov eax, dword [PtrPuckFlags]
        mov word [byte eax+06Dh], 2
.28:
        test byte [byte ecx+01Ch], 80h
        je short .29
        mov eax, ecx
        call EndMove
        jmp short .30
.29:
        lea edx, [byte ebp-020h]
        mov eax, ecx
        call AdvanceMoveAnim
        lea edx, [byte ebp-020h]
        mov eax, ecx
        call StepMove
.30:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
