; Shot reach and shot moves.
bits 32
%include "hockey.inc"
section s_6AB85 progbits alloc exec nowrite align=1
extern a2touchpuck, AdvanceMoveAnim, BreakawayFlag, ClearAnimFlags, CommentaryEvent, EndMove, F32_2_ShotMove, F32_6_ShotMove
extern F64_120, gmode, hypot_, IF@ATAN2, LastTouchPlayer, MoveFlags, NearestPlayer, ObjectFramePos
extern OneTimerPasser, OneTimerReady, PickSkateAnim, PlayFlags, PlaySfxVolume, PtrPuckFlags, PtrPuckZone, PuckFlags
extern randomd0, ReplayPlaying, SetAnimFlags, SetAnimFrame, SetFaceBlink, SetFaceExpression, SetFaceMouth, ShotAnimFrames
extern ShotSpeed, ShotTarget, ShotTimer, StepMove, StickPointId, StickReach
global ShotReach, ShotMove
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ShotReach                                       6AB88  97 PC, low confidence
; Works out where a shot meets the puck
;-----------------------------------------------------------------------------
ShotReach:
        push ebx
        push ecx
        sub esp, byte 0Ch
        mov ecx, eax
        mov eax, edx
        mov ebx, esp
        mov edx, dword [StickPointId]
        call ObjectFramePos
        fld dword [byte ecx+024h]
        fsub dword [byte esp+04h]
        fabs
        fcomp qword [F64_120]
        fnstsw ax
        sahf
        jae short .1
        fld dword [byte ecx+028h]
        fsub dword [byte esp+08h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte ecx+020h]
        fsub dword [byte esp+08h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_120]
        fnstsw ax
        sahf
        ja short .1
        mov eax, 1
        jmp short .2
.1:
        xor eax, eax
.2:
        add esp, byte 0Ch
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ShotMove                                        6ABEC  97 PC, low confidence
; Move handler for a shot
;-----------------------------------------------------------------------------
ShotMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 34h
        mov esi, eax
        lea ebx, [byte ebp-028h]
        mov edi, dword [byte eax+028h]
        mov ecx, dword [byte eax+02Ch]
        xor edx, edx
        and edi, 0FFFFh
        mov dword [byte ebp-018h], edx
        mov eax, dword [dword ecx+0FAh]
        lea edx, [byte ebp-024h]
        mov dword [byte ebp-08h], eax
        mov eax, edi
        call ShotAnimFrames
        test byte [byte esi+01Ch], 80h
        je short .1
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceExpression
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov eax, esi
        call EndMove
        jmp near .40
.1:
        cmp word [OneTimerReady], byte 0
        je short .4
        mov eax, dword [PtrPuckFlags]
        mov edx, ecx
        call ShotReach
        test eax, eax
        je short .3
        mov edx, dword [byte ebp-028h]
        cmp edx, dword [byte esi+04h]
        jle short .2
        mov eax, esi
        call SetAnimFrame
.2:
        mov eax, ecx
        mov ebx, 1
        call a2touchpuck
        mov dword [byte ebp-018h], ebx
        jmp short .4
.3:
        mov eax, dword [byte ebp-028h]
        mov ebx, dword [byte esi+04h]
        add eax, byte 4
        cmp eax, ebx
        jne short .4
        xor ebx, ebx
        mov word [OneTimerReady], bx
.4:
        mov eax, dword [PtrPuckZone]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        jne short .5
        mov edx, dword [byte ebp-028h]
        cmp edx, dword [byte esi+04h]
        je short .6
.5:
        cmp word [OneTimerReady], byte 0
        je near .35
        cmp dword [byte ebp-018h], byte 0
        je near .35
.6:
        cmp word [OneTimerReady], byte 0
        je short .7
        cmp dword [ReplayPlaying], byte 0
        jne short .7
        mov eax, dword [dword ecx+0FEh]
        mov eax, dword [dword eax+0108h]
        inc word [dword eax+020DBh]
.7:
        and byte [PuckFlags], 0F7h
        mov dh, byte [PlayFlags]
        or dh, 10h
        mov eax, dword [PtrPuckZone]
        mov byte [PlayFlags], dh
        mov byte [eax], 0FFh
        cmp word [ShotTimer], byte 0
        jge short .8
        mov eax, dword [ShotTarget]
        sar eax, 10h
        neg eax
        jmp short .9
.8:
        mov eax, dword [ShotTarget]
        sar eax, 10h
.9:
        cmp eax, 2D0h
        jge short .10
        mov eax, dword [PtrPuckFlags]
        mov word [byte eax+06Dh], 0
        jmp short .11
.10:
        mov eax, dword [PtrPuckFlags]
        mov word [byte eax+06Dh], 2
.11:
        mov eax, dword [dword ecx+0FAh]
        mov dword [byte ecx+064h], 10h
        or byte [byte eax+031h], 1
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [dword eax+0EEh]
        mov ebx, dword [byte edx+08h]
        mov dword [byte eax+038h], ebx
        lea eax, [byte ebp-020h]
        push eax
        lea eax, [byte ebp-01Ch]
        push eax
        mov eax, dword [PtrPuckFlags]
        push dword [byte eax+038h]
        push dword [byte eax+028h]
        push dword [byte eax+020h]
        push byte 0
        push byte 0
        sub esp, byte 4
        fild word [ShotSpeed]
        fstp dword [esp]
        sub esp, byte 4
        fild word [ShotTimer]
        fstp dword [esp]
        call StickReach
        fldz
        fxch
        fstp dword [byte ebp-0Ch]
        fcomp dword [byte ebp-0Ch]
        fnstsw ax
        sahf
        jae short .12
        fld dword [byte ebp-020h]
        fld dword [byte ebp-01Ch]
        call IF@ATAN2
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+040h]
        fild word [ShotTarget]
        fdiv dword [byte ebp-0Ch]
        fmul dword [F32_2_ShotMove]
        mov eax, dword [PtrPuckFlags]
        fstp dword [byte eax+030h]
        mov eax, 0Ah
        mov edx, dword [PtrPuckFlags]
        call randomd0
        mov dword [byte ebp-04h], eax
        fld dword [byte ebp-0Ch]
        fild word [byte ebp-04h]
        fadd dword [byte edx+030h]
        fxch
        fmul dword [F32_6_ShotMove]
        fxch
        fstp dword [byte edx+030h]
        mov edx, dword [PtrPuckFlags]
        fstp dword [byte ebp-014h]
        fld dword [byte edx+030h]
        fcomp dword [byte ebp-014h]
        fnstsw ax
        sahf
        jbe short .12
        mov eax, dword [byte ebp-014h]
        mov dword [byte edx+030h], eax
.12:
        mov ebx, dword [PtrPuckFlags]
        fld dword [byte ebx+040h]
        fsin
        fmul dword [byte ebx+038h]
        fstp dword [byte ebx+02Ch]
        mov ebx, dword [PtrPuckFlags]
        fld dword [byte ebx+040h]
        fcos
        fmul dword [byte ebx+038h]
        fstp dword [byte ebx+034h]
        cmp edi, byte 29h
        jl short .15
        cmp edi, byte 2Dh
        jg short .15
        cmp word [dword ecx+0A9h], byte 0
        jne short .13
        mov eax, 408h
        jmp short .14
.13:
        mov eax, 406h
.14:
        mov ebx, 3005h
        jmp short .18
.15:
        cmp word [dword ecx+0A9h], byte 0
        jne short .16
        mov eax, 40Ah
        jmp short .17
.16:
        mov eax, 407h
.17:
        mov ebx, 3004h
.18:
        mov edx, dword [PtrPuckFlags]
        push dword [byte edx+028h]
        push dword [byte edx+020h]
        mov edx, 64h
        call PlaySfxVolume
        test byte [gmode], 1
        jne near .34
        cmp word [BreakawayFlag], byte 0
        jne near .34
        cmp word [dword ecx+0A9h], byte 0
        jne short .19
        mov eax, dword [dword ecx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        add edx, 1D42h
        jmp short .20
.19:
        mov eax, dword [dword ecx+0FEh]
        mov edx, dword [dword eax+0108h]
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        add edx, 0A3h
.20:
        lea edi, [edx+eax]
        mov eax, dword [PtrPuckFlags]
        cmp word [byte eax+06Dh], byte 0
        jne near .33
        mov edx, dword [byte eax+038h]
        cmp edx, 42C80000h
        jg short .21
        mov dword [byte ebp-010h], 3000h
        mov eax, 1000h
        jmp short .23
.21:
        cmp edx, 432F0000h
        jl short .22
        mov edx, 3002h
        mov eax, 1001h
        mov dword [byte ebp-010h], edx
        jmp short .23
.22:
        mov dword [byte ebp-010h], 3001h
        mov eax, 1002h
.23:
        cmp word [OneTimerReady], byte 0
        je short .24
        mov ebx, 3006h
        cmp eax, 1000h
        je short .26
        jmp short .25
.24:
        mov edx, dword [PtrPuckFlags]
        cmp dword [byte edx+05Ah], byte 20h
        jg short .26
        mov ebx, 3007h
        cmp eax, 1000h
        je short .26
.25:
        mov eax, 1001h
.26:
        push eax
        cmp word [ShotTimer], byte 0
        jge short .27
        mov eax, dword [ShotTarget]
        sar eax, 10h
        neg eax
        jmp short .28
.27:
        mov eax, dword [ShotTarget]
        sar eax, 10h
.28:
        cmp eax, 90h
        jg short .31
        cmp word [ShotTarget], byte 0
        jge short .29
        mov eax, dword [NearestPlayer]
        sar eax, 10h
        neg eax
        jmp short .30
.29:
        mov eax, dword [NearestPlayer]
        sar eax, 10h
.30:
        cmp eax, 0C0h
        jg short .31
        mov eax, 1
        jmp short .32
.31:
        xor eax, eax
.32:
        push eax
        push ebx
        mov edx, dword [byte ebp-010h]
        push edx
        lea eax, [byte ecx+028h]
        push eax
        lea eax, [byte ecx+020h]
        push eax
        mov dl, byte [dword ecx+0BFh]
        push edi
        test dl, 80h
        setne al
        and eax, 0FFh
        push eax
        push dword 0A0000004h
        call CommentaryEvent
        add esp, byte 24h
        jmp short .34
.33:
        mov edx, dword [LastTouchPlayer]
        push edx
        mov ah, byte [dword ecx+0BFh]
        push dword 8000h
        test ah, 40h
        setne al
        and eax, 0FFh
        push eax
        push edi
        push dword 0A0000010h
        call CommentaryEvent
        add esp, byte 14h
.34:
        xor ebx, ebx
        mov word [OneTimerReady], bx
        mov word [OneTimerPasser], bx
.35:
        mov ebx, dword [byte ebp-024h]
        cmp ebx, dword [byte esi+04h]
        jne short .37
        mov eax, dword [byte ebp-08h]
        cmp dword [byte eax+020h], byte 0
        je short .37
        mov eax, dword [PtrPuckZone]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        je short .36
        cmp word [OneTimerReady], byte 0
        jne short .36
        mov eax, dword [byte ebp-08h]
        mov edx, 800h
        mov dword [byte eax+020h], 0
        mov eax, esi
        call ClearAnimFlags
        jmp short .37
.36:
        mov edx, 800h
        mov eax, esi
        call SetAnimFlags
.37:
        mov dh, byte [byte esi+01Ch]
        test dh, 80h
        jne short .38
        test dh, 20h
        jne short .39
        mov eax, dword [byte esi+028h]
        and eax, 0FFFFh
        mov al, byte [dword eax+MoveFlags]
        and eax, 0FFh
        cmp eax, dword [byte esi+04h]
        jg short .39
        mov eax, dword [byte ebp-08h]
        mov ebx, dword [byte eax+01Ch]
        test ebx, ebx
        je short .39
        cmp ebx, byte 1
        je short .39
.38:
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceExpression
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov eax, ecx
        call PickSkateAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.39:
        lea edx, [byte ebp-034h]
        mov eax, esi
        call AdvanceMoveAnim
        lea edx, [byte ebp-034h]
        mov eax, esi
        call StepMove
.40:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
