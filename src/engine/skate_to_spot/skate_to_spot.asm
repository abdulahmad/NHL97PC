; Skating to the bench or a spot, retrieving the puck and period end moves.
bits 32
%include "hockey.inc"
section s_72759 progbits alloc exec nowrite align=1
extern AdvanceMoveAnim, assreplace, BodyPointId, EndMove, F32_0p5_SkateToBenchStep, F64_3p14159_SkateToBenchStep, F64_3p14159_SkateToSpotStep, F64_6p28319_SkateToBenchStep
extern F64_6p28319_SkateToSpotStep, F64_neg3p14159_SkateToBenchStep, F64_neg3p14159_SkateToSpotStep, F64_neg6p28319_SkateToBenchStep, F64_neg6p28319_SkateToSpotStep, FaceoffSpot, FaceoffZone, GetAnimId
extern hypot_, IF@ATAN2, IF@DFMOD, IsCameraOnPuck, LimitSkateSpeed, MoveFlags, MovePlayer, ObjectFramePos
extern PeriodOver, PickSkateAnim, PlaySfxVolume, PtrPuckFlags, PtrPuckState, PtrPuckZone, ResetAnimTimer, SetModelHeading
extern SetSPA, SortCords, SpeedScale, StatsPanelOn, StepMove
global SkateToBenchStep, SkateToBenchMove, SimpleAnimMove, SkateToSpotStep, SkateToSpotMove, PuckRetrieveMove, PeriodEndMove, PeriodEndSkateMove
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SkateToBenchStep                                7275C  97 PC, low confidence
; Skates toward the bench
;-----------------------------------------------------------------------------
SkateToBenchStep:
        push ebx
        push ecx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 48h
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov ecx, edx
        mov edx, 3DB2B8C3h
        mov ebx, esp
        mov eax, ecx
        mov dword [byte esp+018h], edx
        mov edx, dword [BodyPointId]
        call ObjectFramePos
        fld dword [byte esi+028h]
        fld dword [byte esi+020h]
        fsub dword [esp]
        fxch
        fsub dword [byte esp+08h]
        fxch
        fstp dword [byte esp+044h]
        fst dword [byte esp+040h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+04Ch]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fstp dword [byte ecx+038h]
        call SpeedScale
        fmul dword [F32_0p5_SkateToBenchStep]
        fcomp dword [byte ecx+038h]
        fnstsw ax
        sahf
        jae short .1
        call SpeedScale
        fmul dword [F32_0p5_SkateToBenchStep]
        fstp dword [byte ecx+038h]
.1:
        fld dword [byte esp+040h]
        fld dword [byte esp+044h]
        call IF@ATAN2
        fld qword [F64_6p28319_SkateToBenchStep]
        fxch
        call IF@DFMOD
        fst dword [byte ecx+040h]
        fst qword [byte esp+034h]
        fcomp qword [F64_3p14159_SkateToBenchStep]
        fnstsw ax
        sahf
        jbe short .2
        fld qword [byte esp+034h]
        fadd qword [F64_neg6p28319_SkateToBenchStep]
        fstp dword [byte ecx+040h]
.2:
        fld dword [byte ecx+040h]
        fst qword [byte esp+024h]
        fcomp qword [F64_neg3p14159_SkateToBenchStep]
        fnstsw ax
        sahf
        jae short .3
        fld qword [byte esp+024h]
        fadd qword [F64_6p28319_SkateToBenchStep]
        fstp dword [byte ecx+040h]
.3:
        mov edx, dword [dword ecx+0F6h]
        mov edx, dword [edx]
        mov edx, dword [byte edx+028h]
        and edx, 0FFFFh
        cmp edx, 88h
        jne short .4
        fld dword [byte esi+040h]
        fadd qword [F64_3p14159_SkateToBenchStep]
        jmp short .5
.4:
        fld dword [byte esi+040h]
.5:
        fsub dword [byte ecx+01Ch]
        fstp dword [byte esp+03Ch]
        fld qword [F64_6p28319_SkateToBenchStep]
        fld dword [byte esp+03Ch]
        call IF@DFMOD
        fst dword [byte esp+03Ch]
        fst qword [byte esp+02Ch]
        fcomp qword [F64_3p14159_SkateToBenchStep]
        fnstsw ax
        sahf
        jbe short .6
        fld qword [byte esp+02Ch]
        fadd qword [F64_neg6p28319_SkateToBenchStep]
        fstp dword [byte esp+03Ch]
.6:
        fld dword [byte esp+03Ch]
        fst qword [byte esp+01Ch]
        fcomp qword [F64_neg3p14159_SkateToBenchStep]
        fnstsw ax
        sahf
        jae short .7
        fld qword [byte esp+01Ch]
        fadd qword [F64_6p28319_SkateToBenchStep]
        fstp dword [byte esp+03Ch]
.7:
        fldz
        lea esi, [byte ecx+01Ch]
        fcomp dword [byte esp+03Ch]
        fnstsw ax
        sahf
        jae short .10
        fld dword [byte esp+03Ch]
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        jbe short .8
        mov edx, dword [byte esp+018h]
        jmp short .9
.8:
        mov edx, dword [byte esp+03Ch]
.9:
        mov dword [byte esp+014h], edx
        fld dword [esi]
        fadd dword [byte esp+014h]
        jmp short .13
.10:
        fld dword [byte esp+03Ch]
        fld dword [byte esp+018h]
        fchs
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        jae short .11
        mov edx, dword [byte esp+010h]
        jmp short .12
.11:
        mov edx, dword [byte esp+03Ch]
.12:
        mov dword [byte esp+0Ch], edx
        fld dword [esi]
        fadd dword [byte esp+0Ch]
.13:
        fstp dword [esi]
        mov eax, ecx
        call MovePlayer
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SkateToBenchMove                                7291C  97 PC, low confidence
; Move handler for skating to the bench
;-----------------------------------------------------------------------------
SkateToBenchMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov esi, dword [dword ecx+0FAh]
        mov edx, dword [byte esi+020h]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edi, SortCords
        shl eax, 3
        add edi, eax
        mov eax, dword [byte ebx+028h]
        and eax, 0FFFFh
        cmp eax, byte 64h
        jl short .1
        cmp eax, byte 66h
        jg short .1
        test byte [byte ebx+01Ch], 80h
        jne short .1
        mov eax, ebx
        call GetAnimId
        test al, 1
        je short .1
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 425h
        push dword [byte ecx+020h]
        call PlaySfxVolume
.1:
        mov dl, byte [byte ebx+01Ch]
        test dl, 80h
        jne short .2
        test dl, 20h
        jne near .4
        mov eax, dword [byte ebx+028h]
        and eax, 0FFFFh
        mov al, byte [dword eax+MoveFlags]
        and eax, 0FFh
        cmp eax, dword [byte ebx+04h]
        jg short .4
        mov ebp, dword [byte esi+01Ch]
        test ebp, ebp
        je short .4
        cmp ebp, byte 1
        je short .4
.2:
        test byte [byte esi+031h], 10h
        je short .3
        mov eax, dword [dword edi+0FAh]
        test byte [byte eax+031h], 10h
        je short .3
        xor edx, edx
        mov ebp, dword [byte eax+020h]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, ebp
        jne short .3
        and byte [byte eax+031h], 0EFh
        and byte [dword edi+0BFh], 0DFh
.3:
        and byte [dword ecx+0BFh], 0DFh
        and byte [byte esi+031h], 0EFh
        mov eax, ebx
        call EndMove
        jmp near .7
.4:
        test byte [byte esi+031h], 10h
        je short .5
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        fld dword [byte ecx+040h]
        mov edx, esp
        fsub dword [byte ecx+01Ch]
        mov eax, ebx
        fstp dword [esp]
        call StepMove
        mov edx, edi
        mov eax, ecx
        call SkateToBenchStep
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        cmp dword [byte esi+024h], byte 0
        je short .6
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        fld dword [byte ecx+040h]
        mov edx, esp
        fsub dword [byte ecx+01Ch]
        mov eax, ebx
        fstp dword [esp]
        call StepMove
        cmp dword [byte esi+024h], byte 1
        jg short .7
        and byte [dword ecx+0BFh], 0DFh
        mov eax, ecx
        call PickSkateAnim
        add esp, byte 0Ch
        pop ebp
        pop edi
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
        call StepMove
.7:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SimpleAnimMove                                  72A84  97 PC, low confidence
; Move handler that plays an animation then ends
;-----------------------------------------------------------------------------
SimpleAnimMove:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        test byte [byte eax+01Ch], 80h
        je short .1
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov dl, byte [dword ecx+0BFh]
        xor ebx, ebx
        or dl, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], dl
        mov edx, 72h
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0FAh]
        or byte [byte eax+031h], 1
        or byte [dword ecx+0BFh], 20h
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
        pop ecx
        pop ebx
        ret
        db 00h,00h
;-----------------------------------------------------------------------------
; SkateToSpotStep                                 72AF0  97 PC, low confidence
; Skates toward a spot
;-----------------------------------------------------------------------------
SkateToSpotStep:
        push ebx
        push ecx
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        fld dword [byte ebx+044h]
        fsub dword [byte eax+01Ch]
        mov ecx, dword [dword eax+0FAh]
        fstp dword [byte ecx+014h]
        mov ecx, dword [dword eax+0FAh]
        fld qword [F64_6p28319_SkateToSpotStep]
        fld dword [byte ecx+014h]
        call IF@DFMOD
        fstp dword [byte ecx+014h]
        mov ecx, dword [dword ebx+0FAh]
        fld dword [byte ecx+014h]
        fst qword [esp]
        fcomp qword [F64_3p14159_SkateToSpotStep]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [esp]
        fadd qword [F64_neg6p28319_SkateToSpotStep]
        fstp dword [byte ecx+014h]
.1:
        mov ecx, dword [dword ebx+0FAh]
        fld dword [byte ecx+014h]
        fst qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_SkateToSpotStep]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+08h]
        fadd qword [F64_6p28319_SkateToSpotStep]
        fstp dword [byte ecx+014h]
.2:
        mov eax, ebx
        call LimitSkateSpeed
        mov esp, ebp
        pop ebp
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SkateToSpotMove                                 72B78  97 PC, low confidence
; Move handler for skating to a spot
;-----------------------------------------------------------------------------
SkateToSpotMove:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 0Ch
        mov ecx, eax
        mov esi, dword [byte eax+02Ch]
        mov eax, dword [byte eax+028h]
        and eax, 0FFFFh
        cmp eax, 146h
        jne short .3
        mov edx, dword [byte ecx+04h]
        cmp edx, byte 5
        jne short .1
        mov ebx, 2
        mov edx, 1
        mov eax, dword [dword esi+0F2h]
        jmp short .2
.1:
        cmp edx, byte 28h
        jne short .3
        mov edx, 1
        mov eax, dword [dword esi+0F2h]
        xor ebx, ebx
.2:
        call SetModelHeading
.3:
        test byte [byte ecx+01Ch], 80h
        je short .4
        mov eax, ecx
        call EndMove
        jmp short .5
.4:
        mov edx, esp
        mov eax, ecx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, esi
        call SkateToSpotStep
        mov edx, esp
        mov eax, ecx
        call StepMove
.5:
        add esp, byte 0Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PuckRetrieveMove                                72BF8  97 PC, low confidence
; Move handler for picking up the puck
;-----------------------------------------------------------------------------
PuckRetrieveMove:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 0Ch
        mov ecx, eax
        mov edx, dword [byte eax+04h]
        mov esi, dword [byte eax+02Ch]
        cmp edx, byte 0Fh
        jne short .2
        mov edx, 1
        mov eax, dword [dword esi+0F2h]
        xor ebx, ebx
        call SetModelHeading
        cmp dword [byte esi+064h], byte 1Eh
        jge short .1
        mov dword [byte esi+064h], 1Eh
.1:
        mov eax, dword [PtrPuckZone]
        mov byte [eax], 0FFh
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+030h], 0C1200000h
        call IsCameraOnPuck
.2:
        test byte [byte ecx+01Ch], 80h
        je short .3
        mov eax, ecx
        call EndMove
        jmp short .4
.3:
        mov edx, esp
        mov eax, ecx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ecx
        call StepMove
.4:
        add esp, byte 0Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PeriodEndMove                                   72C70  97 PC, low confidence
; Move handler for the end of a period
;-----------------------------------------------------------------------------
PeriodEndMove:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 14h
        mov ecx, eax
        mov edx, dword [byte eax+04h]
        mov esi, dword [byte eax+02Ch]
        cmp edx, byte 0Ah
        jne short .1
        mov eax, dword [dword esi+0FAh]
        mov dword [byte eax+0Ch], 0
.1:
        cmp dword [byte ecx+04h], byte 2Bh
        jne near .4
        mov eax, dword [PtrPuckZone]
        mov byte [eax], 0Ch
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+038h], 0
        mov eax, dword [PtrPuckState]
        mov word [eax], 0C0h
        mov ax, word [eax]
        mov edx, 32h
        mov dword [byte esp+010h], eax
        mov eax, dword [PtrPuckFlags]
        fild word [byte esp+010h]
        fstp dword [byte eax+024h]
        mov eax, esi
        mov ebx, 1
        call assreplace
        mov eax, dword [dword esi+0F2h]
        xor edx, edx
        call SetModelHeading
        call PeriodOver
        cmp word [FaceoffSpot], byte 0
        jg short .2
        mov eax, dword [StatsPanelOn]
        sar eax, 10h
        sub eax, 90h
        jmp short .3
.2:
        mov eax, dword [StatsPanelOn]
        sar eax, 10h
        add eax, 90h
.3:
        mov dword [byte esp+0Ch], eax
        mov eax, dword [dword esi+0EEh]
        fild dword [byte esp+0Ch]
        fstp dword [eax]
        mov eax, dword [dword esi+0EEh]
        fild word [FaceoffZone]
        fstp dword [byte eax+04h]
.4:
        test byte [byte ecx+01Ch], 80h
        je short .5
        mov dl, byte [dword esi+0BFh]
        and dl, 0FBh
        mov eax, ecx
        mov byte [dword esi+0BFh], dl
        call EndMove
        jmp short .6
.5:
        mov edx, esp
        mov eax, ecx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ecx
        call StepMove
.6:
        add esp, byte 14h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        jmp near LimitSkateSpeed
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PeriodEndSkateMove                              72D74  97 PC, low confidence
; Move handler for skating off at the end of a period
;-----------------------------------------------------------------------------
PeriodEndSkateMove:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 14h
        mov ecx, eax
        mov edx, dword [byte eax+04h]
        mov esi, dword [byte eax+02Ch]
        cmp edx, byte 0Fh
        jne near .3
        mov eax, dword [PtrPuckZone]
        mov byte [eax], 0Ch
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+038h], 0
        mov eax, dword [PtrPuckState]
        mov word [eax], 0C0h
        mov ax, word [eax]
        mov edx, 32h
        mov dword [byte esp+010h], eax
        mov eax, dword [PtrPuckFlags]
        fild word [byte esp+010h]
        fstp dword [byte eax+024h]
        mov eax, esi
        mov ebx, 1
        call assreplace
        mov eax, dword [dword esi+0F2h]
        xor edx, edx
        call SetModelHeading
        call PeriodOver
        cmp word [FaceoffSpot], byte 0
        jg short .1
        mov eax, dword [StatsPanelOn]
        sar eax, 10h
        sub eax, 90h
        jmp short .2
.1:
        mov eax, dword [StatsPanelOn]
        sar eax, 10h
        add eax, 90h
.2:
        mov dword [byte esp+0Ch], eax
        mov eax, dword [dword esi+0EEh]
        fild dword [byte esp+0Ch]
        fstp dword [eax]
        mov eax, dword [dword esi+0EEh]
        fild word [FaceoffZone]
        fstp dword [byte eax+04h]
.3:
        test byte [byte ecx+01Ch], 80h
        je short .4
        mov eax, ecx
        call EndMove
        jmp short .5
.4:
        mov edx, esp
        mov eax, ecx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, esi
        call LimitSkateSpeed
        mov edx, esp
        mov eax, ecx
        call StepMove
.5:
        add esp, byte 14h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
