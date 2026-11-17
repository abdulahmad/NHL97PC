; Celebrations, dejected skating and cheers.
bits 32
%include "hockey.inc"
section s_71FCB progbits alloc exec nowrite align=1
extern AdvanceMoveAnim, ApplyMoveMotion, EndMove, F32_neg3, F32_neg3_CelebrationJumpMove, F64_0p785398_CelebrationJumpMove, GetAnimId, gmode
extern MoveFlags, MovePlayer, PlaySfxVolume, randomd0, ResetAnimTimer, SetFaceBlink, SetFaceExpression, SetFaceMouth
extern SetSPA, SpeedTowardSpot, StartBenchCheer, StepMove, tickcount
global PlayCelebrationSound, CelebrationMove, CelebrationJumpMove, CelebrationEndMove, DejectedMove, DejectedSkateMove, CheerMove, BenchCheerMove
        db 00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; PlayCelebrationSound                            71FD0  97 PC, low confidence
; Plays a celebration sound
;-----------------------------------------------------------------------------
PlayCelebrationSound:
        push ebx
        push ecx
        push ebp
        mov ebp, esp
        sub esp, byte 4
        mov dword [byte ebp-04h], eax
        mov ebx, edx
        mov ah, byte [byte ebp-04h]
        xor ecx, ecx
        test ah, 1
        je short .2
        mov eax, dword [dword edx+0FAh]
        mov dl, byte [byte eax+031h]
        test dl, 20h
        je short .1
        mov dh, dl
        and dh, 0DFh
        mov byte [byte eax+031h], dh
        jmp short .2
.1:
        push dword [byte ebx+028h]
        mov eax, 2
        push dword [byte ebx+020h]
        mov edx, 64h
        call randomd0
        test ax, ax
        setne al
        and eax, 0FFh
        add eax, 426h
        inc ecx
        call PlaySfxVolume
.2:
        test byte [byte ebp-04h], 2
        je short .3
        push dword [byte ebx+028h]
        mov edx, 64h
        mov eax, 423h
        push dword [byte ebx+020h]
        call PlaySfxVolume
        inc ecx
.3:
        mov eax, ecx
        mov esp, ebp
        pop ebp
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CelebrationMove                                 72050  97 PC, low confidence
; Move handler for a goal celebration
;-----------------------------------------------------------------------------
CelebrationMove:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        call GetAnimId
        mov dl, byte [byte ebx+01Ch]
        mov esi, dword [dword ecx+0FAh]
        test dl, 80h
        jne short .1
        mov edx, ecx
        call PlayCelebrationSound
.1:
        test byte [byte ebx+01Ch], 80h
        je near .7
        mov eax, esi
        call ResetAnimTimer
        mov eax, dword [dword ecx+0A3h]
        mov edx, dword [dword ecx+0FEh]
        sar eax, 18h
        mov ax, word [byte edx+eax*2+050h]
        and eax, 0FFFFh
        cmp eax, 8003h
        je short .2
        cmp eax, 8004h
        jne short .3
.2:
        mov edx, 80h
        jmp short .6
.3:
        test byte [gmode], 1
        je short .5
        mov eax, 2
        call randomd0
        test ax, ax
        je short .4
        mov edx, 80h
        jmp short .6
.4:
        mov edx, 7Eh
        jmp short .6
.5:
        mov edx, 7Fh
.6:
        mov bh, byte [dword ecx+0BFh]
        or bh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        xor ebx, ebx
        push dword 3F800000h
        call SetSPA
        or byte [byte esi+031h], 1
        or byte [dword ecx+0BFh], 20h
        add esp, byte 0Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        cmp dword [byte ebx+04h], byte 0Ah
        jl short .8
        mov dword [byte esi+0Ch], 0
.8:
        fldz
        fcomp dword [byte esi+08h]
        fnstsw ax
        sahf
        jae short .9
        fld dword [byte esi+08h]
        fadd dword [F32_neg3]
        fldz
        fxch
        fstp dword [byte esi+08h]
        fcomp dword [byte esi+08h]
        fnstsw ax
        sahf
        jbe short .9
        mov dword [byte esi+08h], 0
.9:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ebx
        call ApplyMoveMotion
        mov eax, ecx
        call SpeedTowardSpot
        mov eax, ecx
        call MovePlayer
        add esp, byte 0Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CelebrationJumpMove                             72170  97 PC, low confidence
; Move handler for a celebration jump
;-----------------------------------------------------------------------------
CelebrationJumpMove:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        call GetAnimId
        mov dl, byte [byte ebx+01Ch]
        mov esi, dword [dword ecx+0FAh]
        test dl, 80h
        jne short .1
        mov edx, ecx
        call PlayCelebrationSound
.1:
        test byte [byte ebx+01Ch], 80h
        je near .7
        mov eax, dword [dword ecx+0A3h]
        mov edx, dword [dword ecx+0FEh]
        sar eax, 18h
        mov ax, word [byte edx+eax*2+050h]
        mov bl, byte [gmode]
        and eax, 0FFFFh
        test bl, 1
        jne short .2
        cmp eax, 8003h
        je short .2
        cmp eax, 8004h
        jne short .3
.2:
        mov eax, esi
        call ResetAnimTimer
        mov dh, byte [dword ecx+0BFh]
        xor ebx, ebx
        or dh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], dh
        mov edx, 71h
        push dword 3F800000h
        call SetSPA
        or byte [byte esi+031h], 1
        or byte [dword ecx+0BFh], 20h
        jmp near .10
.3:
        mov eax, dword [byte esi+014h]
        mov dword [byte esp+0Ch], eax
        fld dword [byte esp+0Ch]
        fabs
        fcomp qword [F64_0p785398_CelebrationJumpMove]
        fnstsw ax
        sahf
        jae short .4
        mov edx, 6Eh
        jmp short .6
.4:
        cmp byte [dword ecx+0D0h], 0
        setne al
        mov edx, eax
        fldz
        and edx, 0FFh
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        je short .5
        mov edx, 6Fh
        jmp short .6
.5:
        mov edx, 70h
.6:
        mov eax, esi
        call ResetAnimTimer
        mov al, byte [dword ecx+0BFh]
        or al, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], al
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        or byte [byte esi+031h], 1
        or byte [dword ecx+0BFh], 20h
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        cmp dword [byte ebx+04h], byte 0Ah
        jl short .8
        mov dword [byte esi+0Ch], 0
.8:
        fldz
        fcomp dword [byte esi+08h]
        fnstsw ax
        sahf
        jae short .9
        fld dword [byte esi+08h]
        fadd dword [F32_neg3_CelebrationJumpMove]
        fldz
        fxch
        fstp dword [byte esi+08h]
        fcomp dword [byte esi+08h]
        fnstsw ax
        sahf
        jbe short .9
        mov dword [byte esi+08h], 0
.9:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ebx
        call ApplyMoveMotion
        mov eax, ecx
        call SpeedTowardSpot
        mov eax, ecx
        call MovePlayer
.10:
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CelebrationEndMove                              72324  97 PC, low confidence
; Move handler for the end of a celebration
;-----------------------------------------------------------------------------
CelebrationEndMove:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        test byte [byte eax+01Ch], 80h
        je near .3
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        lea edx, [nosplit eax*2+00h]
        mov eax, dword [dword ecx+0FEh]
        mov ax, word [byte edx+eax+050h]
        and eax, 0FFFFh
        cmp eax, 8003h
        je short .1
        cmp eax, 8004h
        jne short .2
.1:
        mov bh, byte [dword ecx+0BFh]
        mov edx, 7Dh
        or bh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        mov ebx, 20h
        push dword 3F800000h
        call SetSPA
        mov ebx, dword [dword ecx+0FAh]
        or byte [byte ebx+031h], 1
        or byte [dword ecx+0BFh], 20h
        jmp near .4
.2:
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
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov eax, dword [dword ecx+0FAh]
        or byte [byte eax+031h], 1
        or byte [dword ecx+0BFh], 20h
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ebx
        call StepMove
.4:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DejectedMove                                    7242C  97 PC, low confidence
; Move handler for a dejected player
;-----------------------------------------------------------------------------
DejectedMove:
        push ebx
        push ecx
        push edx
        push edi
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov dl, byte [byte ebx+01Ch]
        mov eax, dword [dword ecx+0FAh]
        test dl, 80h
        jne short .1
        test dl, 20h
        jne short .2
        mov edx, dword [byte ebx+028h]
        and edx, 0FFFFh
        mov dl, byte [dword edx+MoveFlags]
        and edx, 0FFh
        cmp edx, dword [byte ebx+04h]
        jg short .2
        mov edi, dword [byte eax+01Ch]
        test edi, edi
        je short .2
        cmp edi, byte 1
        je short .2
.1:
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceExpression
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov eax, dword [dword ecx+0EEh]
        and byte [byte eax+031h], 0FEh
        mov eax, ebx
        call EndMove
        jmp short .3
.2:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ebx
        call StepMove
.3:
        add esp, byte 0Ch
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DejectedSkateMove                               724C8  97 PC, low confidence
; Move handler for a dejected player skating away
;-----------------------------------------------------------------------------
DejectedSkateMove:
        push ebx
        push ecx
        push edx
        push edi
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov dl, byte [byte ebx+01Ch]
        mov eax, dword [dword ecx+0FAh]
        test dl, 80h
        jne short .1
        test dl, 20h
        jne short .2
        mov edx, dword [byte ebx+028h]
        and edx, 0FFFFh
        mov dl, byte [dword edx+MoveFlags]
        and edx, 0FFh
        cmp edx, dword [byte ebx+04h]
        jg short .2
        mov edi, dword [byte eax+01Ch]
        test edi, edi
        je short .2
        cmp edi, byte 1
        je short .2
.1:
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceExpression
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov eax, dword [dword ecx+0EEh]
        and byte [byte eax+031h], 0FEh
        mov eax, ebx
        call EndMove
        jmp short .3
.2:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ebx
        call StepMove
.3:
        add esp, byte 0Ch
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CheerMove                                       72564  97 PC, low confidence
; Move handler for cheering
;-----------------------------------------------------------------------------
CheerMove:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        call GetAnimId
        mov dl, byte [byte ebx+01Ch]
        mov dword [byte ebp-04h], eax
        test dl, 80h
        jne short .1
        mov edx, ecx
        call PlayCelebrationSound
.1:
        test byte [byte ebp-04h], 4
        je short .2
        push dword [byte ecx+028h]
        mov eax, 2
        push dword [byte ecx+020h]
        mov edx, 64h
        call randomd0
        test ax, ax
        setne al
        and eax, 0FFh
        add eax, 421h
        call PlaySfxVolume
.2:
        mov al, byte [byte ebx+01Ch]
        test al, 80h
        jne short .3
        test al, 20h
        jne short .4
        mov eax, dword [byte ebx+028h]
        and eax, 0FFFFh
        mov al, byte [dword eax+MoveFlags]
        and eax, 0FFh
        cmp eax, dword [byte ebx+04h]
        jg short .4
        mov eax, dword [dword ecx+0FAh]
        mov esi, dword [byte eax+01Ch]
        test esi, esi
        je short .4
        cmp esi, byte 1
        je short .4
.3:
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceExpression
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov eax, dword [dword ecx+0EEh]
        and byte [byte eax+031h], 0FEh
        mov eax, ebx
        call EndMove
        jmp short .5
.4:
        lea edx, [byte ebp-010h]
        mov eax, ebx
        call AdvanceMoveAnim
        lea edx, [byte ebp-010h]
        mov eax, ebx
        call StepMove
.5:
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; BenchCheerMove                                  72648  97 PC, low confidence
; Move handler for cheering on the bench
;-----------------------------------------------------------------------------
BenchCheerMove:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 18h
        mov ecx, eax
        mov esi, dword [byte eax+02Ch]
        call GetAnimId
        mov dl, byte [byte ecx+01Ch]
        mov ebx, eax
        test dl, 80h
        jne short .1
        mov edx, esi
        call PlayCelebrationSound
.1:
        test bl, 4
        je short .2
        push dword [byte esi+028h]
        mov eax, 2
        push dword [byte esi+020h]
        mov edx, 64h
        call randomd0
        test ax, ax
        setne al
        and eax, 0FFh
        add eax, 421h
        call PlaySfxVolume
        mov eax, dword [byte esi+04h]
        xor edx, edx
        sar eax, 10h
        mov dword [byte ebp-08h], edx
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [byte esi+0Ch]
        sar eax, 10h
        mov edx, 28000h
        mov dword [byte ebp-04h], eax
        mov eax, dword [tickcount]
        mov ebx, eax
        lea eax, [byte ebp-0Ch]
        call StartBenchCheer
.2:
        mov dh, byte [byte ecx+01Ch]
        test dh, 80h
        jne short .3
        test dh, 20h
        jne short .4
        mov eax, dword [byte ecx+028h]
        and eax, 0FFFFh
        mov al, byte [dword eax+MoveFlags]
        and eax, 0FFh
        cmp eax, dword [byte ecx+04h]
        jg short .4
        mov eax, dword [dword esi+0FAh]
        mov edi, dword [byte eax+01Ch]
        test edi, edi
        je short .4
        cmp edi, byte 1
        je short .4
.3:
        mov eax, dword [dword esi+0F2h]
        xor edx, edx
        call SetFaceExpression
        mov edx, 1
        mov eax, dword [dword esi+0F2h]
        call SetFaceMouth
        mov eax, dword [dword esi+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov eax, dword [dword esi+0EEh]
        and byte [byte eax+031h], 0FEh
        mov eax, ecx
        call EndMove
        jmp short .5
.4:
        lea edx, [byte ebp-018h]
        mov eax, ecx
        call AdvanceMoveAnim
        lea edx, [byte ebp-018h]
        mov eax, ecx
        call StepMove
.5:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
