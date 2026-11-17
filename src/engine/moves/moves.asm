; Moves: faceoff stance, shouts, strides, box animations, ref dodging, checks and steering.
bits 32
%include "hockey.inc"
section s_3A2E7 progbits alloc exec nowrite align=1
extern AdvanceMoveAnim, BoxAnimFrames, BoxAnimIndex, ChkBodyContact, ClearModelSlots, DodgeScale, EndMove, F32_0p0666667
extern F32_0p5_RefDodgePuck, F32_10_RefDodgePuck, F32_144_PokeCheckAnim, F32_144_TryBodyCheck, F32_15, F32_192_TryBodyCheck, F32_336, F32_3_RefDodgePuck
extern F64_0p0001, F64_0p00347222, F64_0p2_RefDodgePuck, F64_0p349066, F64_0p6, F64_0p7, F64_0p785398_ReachForPuckAnim, F64_0p785398_TryBodyCheck
extern F64_0p8, F64_1p0472, F64_1p2_PokeCheckAnim, F64_1p5708, F64_3p14159_ReachForPuckAnim, F64_3p14159_TryBodyCheck, F64_6p28319_ReachForPuckAnim, F64_6p28319_TryBodyCheck
extern F64_96, F64_neg3p14159_GoToBoxAnim, F64_neg3p14159_ReachForPuckAnim, F64_neg3p14159_TryBodyCheck, F64_neg6p28319_ReachForPuckAnim, F64_neg6p28319_TryBodyCheck, GetAnimId, GetStickBladePos
extern gmode, hypot_, IF@ATAN2, IF@DFMOD, LimitSkateSpeed, MoveFlags, NetCollide, NetCollide2
extern PickSaveAnim, PickSkateAnim, PlaySfxAt, PlaySfxVolume, PtrPuckFlags, puckc, randomd0, ResetAnimTimer
extern SaveDirection, SetFaceBlink, SetFaceExpression, SetFaceMouth, SetModelHeading, SetObjectHidden, SetSPA, SetSPAInPlace
extern SortCords, SteerAndAccel, StepMove, str_C_FaceoffSwipeAnim, str_O_FaceoffStanceMove, str_U_FaceoffDrawAnim, StrideSpeeds, TryPokePuck
global FaceoffStanceMove, RunSimpleMove, FaceoffMoveResult, FaceoffMove, MoveWithSfx, RandomFollowMove, ShoutMove, BodyMove
global TakePositionMove, SkateStrideMove, CoastMove, BackStrideMove, FaceoffSwipeAnim, FaceoffDrawAnim, SitDownAnim, StandUpAnim
global GoToBoxAnim, LeaveBoxAnim, RefDodgePuck, checkgoal, CheckMove, SteerMove, ReachForPuckAnim, PokeCheckAnim
global TryBodyCheck, DoCheckButton, AIBodyCheck
        db 090h
;-----------------------------------------------------------------------------
; FaceoffStanceMove                               3A2E8  97 PC, low confidence
; Move handler for the faceoff stance moves: stick down, random stance
; animation, face morphs
;-----------------------------------------------------------------------------
FaceoffStanceMove:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 0Ch
        mov ebx, eax
        mov esi, dword [byte eax+028h]
        and esi, 0FFFFh
        mov ecx, dword [byte eax+02Ch]
        cmp esi, byte 40h
        jne short .3
        test byte [byte eax+04h], 8
        je short .1
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        jmp short .2
.1:
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
.2:
        call SetFaceMouth
.3:
        test byte [byte ebx+01Ch], 80h
        je short .5
        cmp esi, byte 40h
        jne short .4
        mov ebx, dword [dword ecx+0FAh]
        mov dword [byte ebx+01Ch], 0
        mov dword [byte ebx+018h], 0
        mov dword [byte ebx+014h], 0
        and byte [dword ecx+0BFh], 0DFh
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceMouth
        mov eax, ebx
        call ResetAnimTimer
        and byte [dword ecx+0BFh], 0DFh
        mov eax, 6
        push dword 3F800000h
        call randomd0
        cwde
        xor ebx, ebx
        mov edx, dword [nosplit eax*4+str_O_FaceoffStanceMove]
        mov eax, ecx
        call SetSPA
        jmp short .7
.4:
        mov eax, ebx
        call EndMove
        jmp short .7
.5:
        test byte [byte ebx+01Dh], 8
        je short .6
        and byte [dword ecx+0BFh], 0DFh
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
        call StepMove
.7:
        add esp, byte 0Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; RunSimpleMove                                   3A3C8  97 PC, low confidence
; Move handler for plain moves: plays the animation and picks the next move
; when it ends
;-----------------------------------------------------------------------------
RunSimpleMove:
        push ebx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov dl, byte [byte ebx+01Ch]
        mov eax, dword [byte eax+02Ch]
        test dl, 80h
        je short .1
        and byte [dword eax+0BFh], 0FBh
        mov eax, ebx
        call EndMove
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
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FaceoffMoveResult                               3A404  97 PC, low confidence
; Returns the faceoff result code of a faceoff move (win forward, win back,
; tie), -1 for others
;-----------------------------------------------------------------------------
FaceoffMoveResult:
        cmp eax, byte 42h
        jb short .1
        jbe short .2
        cmp eax, byte 43h
        jbe short .3
        cmp eax, byte 54h
        jb short .5
        cmp eax, byte 55h
        jbe short .4
        jmp short .5
.1:
        cmp eax, byte 41h
        je short .3
        jmp short .5
.2:
        mov dword [edx], 0Ch
        ret
.3:
        mov dword [edx], 0Eh
        ret
.4:
        mov dword [edx], 0Ah
        ret
.5:
        mov dword [edx], 0FFFFFFFFh
        ret
        db 090h
;-----------------------------------------------------------------------------
; FaceoffMove                                     3A440  97 PC, low confidence
; Move handler for the faceoff draw moves; at the end starts the follow
; animation
;-----------------------------------------------------------------------------
FaceoffMove:
        push ebx
        push ecx
        push edx
        push ebp
        sub esp, byte 10h
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov eax, dword [byte eax+028h]
        mov dl, byte [byte ebx+01Ch]
        and eax, 0FFFFh
        test dl, 80h
        je short .1
        mov dh, byte [dword ecx+0BFh]
        and dh, 0DFh
        mov eax, dword [dword ecx+0FAh]
        mov byte [dword ecx+0BFh], dh
        call ResetAnimTimer
        mov bl, byte [dword ecx+0BFh]
        mov edx, 0Ch
        and bl, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        mov ebx, 20h
        push dword 3F800000h
        call SetSPA
        jmp near .11
.1:
        lea edx, [byte esp+0Ch]
        cmp eax, byte 42h
        jb short .2
        jbe short .3
        cmp eax, byte 43h
        jbe short .4
        cmp eax, byte 54h
        jb short .6
        cmp eax, byte 55h
        jbe short .5
        jmp short .6
.2:
        cmp eax, byte 41h
        je short .4
        jmp short .6
.3:
        mov dword [byte esp+0Ch], 0Ch
        jmp short .7
.4:
        mov dword [byte esp+0Ch], 0Eh
        jmp short .7
.5:
        mov dword [byte esp+0Ch], 0Ah
        jmp short .7
.6:
        mov dword [edx], 0FFFFFFFFh
.7:
        mov ebp, dword [byte esp+0Ch]
        cmp ebp, dword [byte ebx+04h]
        jne short .10
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+024h], 41C00000h
        jg short .8
        push dword [byte eax+028h]
        push dword [byte eax+020h]
        mov eax, 2
        call randomd0
        cwde
        mov edx, 64h
        add eax, 400h
        jmp short .9
.8:
        push dword [byte eax+028h]
        push dword [byte eax+020h]
        mov eax, 2
        call randomd0
        cwde
        mov edx, 64h
        add eax, 402h
.9:
        call PlaySfxVolume
.10:
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+024h], 42400000h
        jg short .11
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, ebx
        call StepMove
.11:
        add esp, byte 10h
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; MoveWithSfx                                     3A564  97 PC, low confidence
; Move handler for moves that play a sound at a set frame (stick and body
; sounds)
;-----------------------------------------------------------------------------
MoveWithSfx:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 0Ch
        mov esi, eax
        mov edx, dword [byte eax+028h]
        mov ecx, dword [byte eax+02Ch]
        mov ah, byte [byte eax+01Ch]
        and edx, 0FFFFh
        test ah, 80h
        je short .4
        mov bl, byte [dword ecx+0BFh]
        and bl, 0DFh
        mov eax, dword [dword ecx+0FAh]
        mov byte [dword ecx+0BFh], bl
        call ResetAnimTimer
        cmp edx, byte 5Eh
        jne short .1
        mov edx, 59h
        jmp short .3
.1:
        cmp edx, byte 5Ch
        jne short .2
        mov edx, 5Ah
        jmp short .3
.2:
        mov edx, 4Eh
.3:
        mov bh, byte [dword ecx+0BFh]
        and bh, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        mov ebx, 20h
        push dword 3F800000h
        call SetSPA
        jmp near .9
.4:
        mov eax, esi
        call GetAnimId
        mov ebx, eax
        test al, 1
        je short .7
        cmp edx, byte 4Fh
        jne short .5
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 413h
        jmp short .6
.5:
        cmp edx, byte 50h
        jne short .7
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 420h
.6:
        push dword [byte ecx+020h]
        call PlaySfxVolume
.7:
        test bl, 2
        je short .8
        push dword [byte ecx+028h]
        mov eax, 5
        push dword [byte ecx+020h]
        mov ebx, 64h
        call randomd0
        cwde
        xor edx, edx
        add eax, 520h
        call PlaySfxAt
.8:
        mov edx, esp
        mov eax, esi
        call AdvanceMoveAnim
        mov edx, esp
        mov eax, esi
        call StepMove
.9:
        add esp, byte 0Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RandomFollowMove                                3A65C  97 PC, low confidence
; Move handler that starts a random follow-up animation when the move ends
;-----------------------------------------------------------------------------
RandomFollowMove:
        push ebx
        push ecx
        push edx
        mov edx, dword [byte eax+028h]
        mov bl, byte [byte eax+01Ch]
        mov ecx, dword [byte eax+02Ch]
        and edx, 0FFFFh
        test bl, 80h
        je short .1
        mov eax, ecx
        call PickSkateAnim
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        cmp edx, byte 59h
        jne short .2
        mov eax, 1Eh
        call randomd0
        test ax, ax
        jne near .7
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        mov edx, 5Dh
        and ah, 0DFh
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F800000h
        jmp near .6
.2:
        cmp edx, byte 5Ah
        jne short .3
        mov eax, 1Eh
        call randomd0
        test ax, ax
        jne near .7
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov al, byte [dword ecx+0BFh]
        mov edx, 5Bh
        and al, 0DFh
        xor ebx, ebx
        mov byte [dword ecx+0BFh], al
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov eax, 28h
        call randomd0
        movsx edx, ax
        cmp edx, byte 2
        jge short .7
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov bh, byte [dword ecx+0BFh]
        and bh, 0DFh
        push dword 3F800000h
        mov byte [dword ecx+0BFh], bh
        xor ebx, ebx
        test edx, edx
        je short .4
        mov edx, 5Ch
        jmp short .5
.4:
        mov edx, 5Eh
.5:
        mov eax, ecx
.6:
        call SetSPA
.7:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ShoutMove                                       3A75C  97 PC, low confidence
; Move handler for moves with face morphs (open mouth, expression) chosen at
; random
;-----------------------------------------------------------------------------
ShoutMove:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 0Ch
        mov ecx, eax
        mov esi, dword [byte eax+02Ch]
        mov edx, dword [byte eax+04h]
        mov ebx, dword [dword esi+0F2h]
        test edx, edx
        jne short .1
        mov eax, ebx
        call SetFaceExpression
        mov eax, ebx
        xor edx, edx
        call SetFaceMouth
        mov eax, ebx
        xor edx, edx
        call SetFaceBlink
        mov edx, 1
        mov eax, ebx
        call SetFaceBlink
.1:
        test byte [byte ecx+04h], 3
        jne short .4
        mov eax, 2
        call randomd0
        test ax, ax
        je short .2
        mov eax, ebx
        xor edx, edx
        jmp short .3
.2:
        mov edx, 1
        mov eax, ebx
.3:
        call SetFaceMouth
.4:
        test byte [byte ecx+01Ch], 80h
        je short .5
        mov eax, ebx
        xor edx, edx
        call SetFaceExpression
        mov eax, ebx
        xor edx, edx
        call SetFaceMouth
        mov eax, ebx
        xor edx, edx
        call SetFaceBlink
        mov edx, dword [dword esi+0EEh]
        mov bl, byte [byte edx+031h]
        and bl, 0FEh
        mov eax, ecx
        mov byte [byte edx+031h], bl
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
        add esp, byte 0Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; BodyMove                                        3A814  97 PC, low confidence
; Move handler for body moves that clear the busy flags when they end
;-----------------------------------------------------------------------------
BodyMove:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte ebx+028h]
        mov eax, dword [byte eax+02Ch]
        and ecx, 0FFFFh
        mov edx, dword [dword eax+0FAh]
        cmp ecx, byte 45h
        je short .1
        cmp ecx, byte 47h
        jne short .2
.1:
        cmp dword [byte ebx+04h], byte 37h
        jne short .2
        mov dword [byte edx+04h], 3F800000h
.2:
        test byte [byte ebx+01Ch], 80h
        je short .3
        and byte [byte edx+031h], 0FEh
        mov edx, dword [dword eax+0EEh]
        and byte [byte edx+031h], 0FEh
        and byte [dword eax+0BFh], 0DFh
        mov eax, ebx
        call EndMove
        jmp short .4
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
; TakePositionMove                                3A884  97 PC, low confidence
; Move handler that ends in the stand animation when the player is taking his
; position
;-----------------------------------------------------------------------------
TakePositionMove:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov eax, dword [byte eax+028h]
        mov ecx, dword [byte ebx+02Ch]
        mov dl, byte [byte ebx+01Ch]
        and eax, 0FFFFh
        test dl, 80h
        je short .2
        mov eax, dword [dword ecx+0FAh]
        and byte [byte eax+031h], 0FEh
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        cmp byte [dword ecx+eax+0B2h], 21h
        jne short .1
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov dh, byte [dword ecx+0BFh]
        mov ebx, 20h
        and dh, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], dh
        mov edx, 17Ch
        push dword 3F800000h
        call SetSPA
        jmp short .5
.1:
        mov eax, ebx
        call EndMove
        jmp short .5
.2:
        cmp eax, byte 48h
        jne short .3
        mov edx, esp
        mov eax, ecx
        call LimitSkateSpeed
        jmp short .4
.3:
        mov edx, esp
        mov eax, ebx
        call AdvanceMoveAnim
.4:
        mov edx, esp
        mov eax, ebx
        call StepMove
.5:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SkateStrideMove                                 3A920  97 PC, low confidence
; Move handler for forward skating strides: alternates the two stride
; animations
;-----------------------------------------------------------------------------
SkateStrideMove:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        mov ebx, eax
        mov edx, dword [byte eax+028h]
        mov ecx, dword [byte eax+02Ch]
        and edx, 0FFFFh
        mov eax, dword [dword ecx+0FAh]
        test byte [byte ebx+01Ch], 80h
        je short .1
        mov eax, ecx
        call PickSkateAnim
        jmp near .5
.1:
        mov esi, dword [byte eax+01Ch]
        cmp esi, byte 2
        je short .2
        cmp esi, byte 6
        jne short .3
.2:
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        push dword 3F800000h
        and ah, 0DFh
        mov ebx, 20h
        mov byte [dword ecx+0BFh], ah
        cmp edx, 17Bh
        setne al
        xor edx, edx
        mov dl, al
        add edx, 177h
        mov eax, ecx
        call SetSPA
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        lea edx, [byte ebp-0Ch]
        mov dword [byte eax+01Ch], 0
        mov eax, ecx
        call LimitSkateSpeed
        cmp dword [byte ebp-04h], 41400000h
        jle short .4
        mov dword [byte ebp-04h], 41400000h
.4:
        lea edx, [byte ebp-0Ch]
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
; CoastMove                                       3A9D0  97 PC, low confidence
; Move handler for coasting: steers and keeps the speed under the coasting
; limit
;-----------------------------------------------------------------------------
CoastMove:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov dl, byte [byte ebx+01Ch]
        mov eax, dword [dword ecx+0FAh]
        test dl, 80h
        je short .1
        call ResetAnimTimer
        mov dh, byte [dword ecx+0BFh]
        mov ebx, 20h
        and dh, 0DFh
        mov eax, ecx
        mov byte [dword ecx+0BFh], dh
        mov edx, 17Bh
        push dword 3F800000h
        call SetSPA
        jmp short .3
.1:
        mov edx, esp
        mov dword [byte eax+01Ch], 0
        mov eax, ecx
        call LimitSkateSpeed
        cmp dword [byte esp+08h], 41400000h
        jle short .2
        mov dword [byte esp+08h], 41400000h
.2:
        mov edx, esp
        mov eax, ebx
        call StepMove
.3:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; BackStrideMove                                  3AA48  97 PC, low confidence
; Move handler for backward skating strides: alternates the two backward
; stride animations
;-----------------------------------------------------------------------------
BackStrideMove:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        mov ebx, eax
        mov edx, dword [byte eax+028h]
        mov ecx, dword [byte eax+02Ch]
        and edx, 0FFFFh
        mov eax, dword [dword ecx+0FAh]
        test byte [byte ebx+01Ch], 80h
        je short .1
        mov eax, ecx
        call PickSkateAnim
        jmp short .3
.1:
        mov esi, dword [byte eax+01Ch]
        cmp esi, byte 2
        je short .2
        cmp esi, byte 6
        je short .2
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        push dword 3F800000h
        and ah, 0DFh
        mov ebx, 20h
        mov byte [dword ecx+0BFh], ah
        cmp edx, 177h
        setne al
        xor edx, edx
        mov dl, al
        add edx, 17Bh
        mov eax, ecx
        call SetSPA
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        lea edx, [byte ebp-0Ch]
        mov eax, ebx
        call AdvanceMoveAnim
        lea edx, [byte ebp-0Ch]
        mov eax, ecx
        call SteerAndAccel
        lea edx, [byte ebp-0Ch]
        mov eax, ebx
        call StepMove
.3:
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FaceoffSwipeAnim                                3AAE8  97 PC, low confidence
; Starts the faceoff swipe animation in the given direction
;-----------------------------------------------------------------------------
FaceoffSwipeAnim:
        push ebx
        push ecx
        mov ecx, eax
        mov eax, dword [dword eax+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        or ah, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        mov edx, dword [nosplit edx*4+str_C_FaceoffSwipeAnim]
        push dword 3F800000h
        call SetSPA
        or byte [dword ecx+0BFh], 20h
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FaceoffDrawAnim                                 3AB28  97 PC, low confidence
; Starts the slower faceoff draw animation in the given direction
;-----------------------------------------------------------------------------
FaceoffDrawAnim:
        push ebx
        push ecx
        mov ecx, eax
        mov eax, dword [dword eax+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        or ah, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        mov edx, dword [nosplit edx*4+str_U_FaceoffDrawAnim]
        push dword 3F000000h
        call SetSPA
        or byte [dword ecx+0BFh], 20h
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SitDownAnim                                     3AB68  97 PC, low confidence
; Stops the player and starts the sit-down animation on the bench or in the
; box
;-----------------------------------------------------------------------------
SitDownAnim:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov dword [byte eax+038h], 0
        mov eax, dword [dword eax+0FAh]
        call ResetAnimTimer
        mov eax, dword [dword ecx+0FAh]
        mov dword [byte eax+04h], 3F4CCCCDh
        mov ah, byte [dword ecx+0BFh]
        mov ebx, 40h
        or ah, 20h
        mov edx, 3Fh
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F19999Ah
        call SetSPA
        or byte [dword ecx+0BFh], 24h
        mov dh, byte [dword ecx+0C1h]
        or dh, 1
        mov eax, dword [dword ecx+0FAh]
        mov byte [dword ecx+0C1h], dh
        or byte [byte eax+031h], 1
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StandUpAnim                                     3ABD8  97 PC, low confidence
; Starts the stand-up animation of a player leaving the bench
;-----------------------------------------------------------------------------
StandUpAnim:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov eax, dword [dword eax+0FAh]
        call ResetAnimTimer
        mov eax, dword [dword ecx+0FAh]
        mov dword [byte eax+04h], 3F4CCCCDh
        mov ah, byte [dword ecx+0BFh]
        mov edx, 3Eh
        or ah, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F19999Ah
        call SetSPAInPlace
        or byte [dword ecx+0BFh], 20h
        mov dh, byte [dword ecx+0C1h]
        and dh, 0FEh
        mov eax, dword [dword ecx+0FAh]
        mov byte [dword ecx+0C1h], dh
        or byte [byte eax+031h], 1
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; GoToBoxAnim                                     3AC3C  97 PC, low confidence
; Starts the skate-to-penalty-box animation with a turn rate from the box
; distance
;-----------------------------------------------------------------------------
GoToBoxAnim:
        push ebx
        push ecx
        push edx
        sub esp, byte 8
        mov ecx, eax
        mov edx, dword [BoxAnimIndex]
        xor eax, eax
        mov al, byte [byte edx+0Dh]
        mov dword [byte esp+04h], eax
        fild word [byte esp+04h]
        fld dword [BoxAnimFrames]
        fsubr qword [F64_neg3p14159_GoToBoxAnim]
        fdivrp
        mov eax, dword [dword ecx+0FAh]
        mov dword [byte ecx+038h], 0
        fstp dword [esp]
        call ResetAnimTimer
        cmp byte [dword ecx+0D0h], 0
        je short .1
        fld dword [esp]
        fchs
        mov eax, dword [dword ecx+0FAh]
        fstp dword [byte eax+0Ch]
        jmp short .2
.1:
        mov eax, dword [dword ecx+0FAh]
        mov edx, dword [esp]
        mov dword [byte eax+0Ch], edx
.2:
        mov dl, byte [dword ecx+0BFh]
        mov eax, ecx
        or dl, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], dl
        mov edx, 40h
        push dword 3F19999Ah
        call SetSPA
        mov dh, byte [dword ecx+0BFh]
        or dh, 24h
        mov bl, byte [dword ecx+0C1h]
        mov byte [dword ecx+0BFh], dh
        or bl, 1
        mov eax, dword [dword ecx+0FAh]
        mov byte [dword ecx+0C1h], bl
        or byte [byte eax+031h], 1
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetObjectHidden
        xor ebx, ebx
        mov eax, dword [dword ecx+0F2h]
        call SetModelHeading
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        xor ebx, ebx
        call SetModelHeading
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceExpression
        call ClearModelSlots
        add esp, byte 8
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LeaveBoxAnim                                    3AD34  97 PC, low confidence
; Starts the animation of a player stepping out of the penalty box
;-----------------------------------------------------------------------------
LeaveBoxAnim:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov edx, dword [byte ecx+020h]
        mov dword [dword eax+0D2h], edx
        mov edx, dword [byte ecx+028h]
        mov dword [dword eax+0DAh], edx
        mov eax, dword [dword eax+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        mov edx, 58h
        or ah, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F19999Ah
        call SetSPAInPlace
        or byte [dword ecx+0BFh], 20h
        mov dh, byte [dword ecx+0C1h]
        and dh, 0FEh
        mov eax, dword [dword ecx+0FAh]
        mov byte [dword ecx+0C1h], dh
        or byte [byte eax+031h], 1
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; RefDodgePuck                                    3AD9C  97 PC, low confidence
; The referee steps out of the way of a slow loose puck heading at him
;-----------------------------------------------------------------------------
RefDodgePuck:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 3Ch
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        test byte [gmode], 1
        jne near .4
        test byte [dword esi+0BFh], 20h
        jne near .4
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jge near .4
        mov edx, dword [PtrPuckFlags]
        cmp dword [byte edx+024h], 41C00000h
        jg near .4
        fld dword [byte esi+020h]
        fsub dword [byte edx+020h]
        fld dword [byte esi+02Ch]
        fmul dword [F32_10_RefDodgePuck]
        faddp
        fstp dword [esp]
        fld dword [byte edx+024h]
        fchs
        fstp dword [byte esp+04h]
        fld dword [byte esi+028h]
        fsub dword [byte edx+028h]
        fld dword [byte esi+034h]
        fmul dword [F32_10_RefDodgePuck]
        faddp
        fstp dword [byte esp+08h]
        mov eax, dword [byte edx+02Ch]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte edx+030h]
        lea ecx, [byte esp+018h]
        mov dword [byte esp+010h], eax
        lea ebx, [byte esp+024h]
        mov eax, dword [byte edx+034h]
        lea edx, [byte esp+0Ch]
        mov dword [byte esp+014h], eax
        mov eax, esp
        call SaveDirection
        fst dword [byte esp+038h]
        fcomp dword [F32_3_RefDodgePuck]
        fnstsw ax
        sahf
        jbe near .4
        fld dword [byte esp+038h]
        fcomp dword [F32_15]
        fnstsw ax
        sahf
        ja near .4
        fld dword [byte esp+020h]
        fld dword [byte esi+050h]
        fstp qword [byte esp+030h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fcomp qword [byte esp+030h]
        fnstsw ax
        sahf
        jae near .4
        mov edx, dword [dword esi+0FAh]
        mov eax, edx
        call ResetAnimTimer
        fld dword [byte esp+038h]
        fmul dword [F32_0p0666667]
        fst dword [byte esp+038h]
        fcomp dword [F32_0p5_RefDodgePuck]
        fnstsw ax
        sahf
        jae short .1
        mov dword [byte esp+038h], 3F000000h
.1:
        fld dword [byte esi+038h]
        fdiv dword [DodgeScale]
        fmul dword [byte esp+038h]
        fstp dword [byte edx+04h]
        cmp dword [byte edx+04h], 3F800000h
        jle short .2
        mov dword [byte edx+04h], 3F800000h
.2:
        fld dword [byte edx+04h]
        fcomp qword [F64_0p2_RefDodgePuck]
        fnstsw ax
        sahf
        jae short .3
        mov dword [byte edx+04h], 3E4CCCCDh
.3:
        mov bl, byte [dword esi+0BFh]
        mov edx, 61h
        or bl, 20h
        mov eax, esi
        mov byte [dword esi+0BFh], bl
        xor ebx, ebx
        push dword [byte esp+038h]
        call SetSPA
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h
;-----------------------------------------------------------------------------
; checkgoal                                         3AF30  94G, low confidence
; From the MoveFuncTable handler table: the puck against a net; the two net checks (NetCollide /
; NetCollide2) call Goal does for the puck
;-----------------------------------------------------------------------------
checkgoal:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edx, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [dword ebx+0FAh]
        mov ecx, dword [byte esi+020h]
        mov eax, ecx
        shl eax, 5
        add eax, ecx
        mov ecx, SortCords
        shl eax, 3
        add ecx, eax
        test byte [byte esi+031h], 10h
        je short .1
        mov eax, dword [dword ecx+0FAh]
        test byte [byte eax+031h], 10h
        jne short .2
.1:
        mov eax, edx
        call EndMove
        jmp short .6
.2:
        test byte [byte edx+01Ch], 80h
        je short .4
        test byte [byte eax+031h], 10h
        je short .3
        mov edi, dword [byte eax+020h]
        movzx esi, byte [dword ebx+0A4h]
        cmp esi, edi
        jne short .3
        and byte [byte eax+031h], 0EFh
        and byte [dword ecx+0BFh], 0DFh
.3:
        and byte [dword ebx+0BFh], 0DFh
        mov eax, dword [dword ebx+0FAh]
        and byte [byte eax+031h], 0EFh
        mov eax, edx
        call EndMove
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov eax, 2
        call randomd0
        test ax, ax
        je short .5
        mov eax, edx
        call NetCollide
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov eax, edx
        call NetCollide2
.6:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CheckMove                                       3AFDC  97 PC, low confidence
; Move handler for a body check: tests contact each frame, ends when the hit
; is done
;-----------------------------------------------------------------------------
CheckMove:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        sub esp, byte 0Ch
        mov ebx, eax
        mov ecx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+04h]
        mov edx, dword [dword ecx+0FAh]
        cmp esi, byte 14h
        jl short .1
        and byte [byte edx+031h], 0FEh
.1:
        mov eax, ebx
        call ChkBodyContact
        mov al, byte [byte ebx+01Ch]
        test al, 80h
        jne short .2
        test al, 20h
        jne short .3
        mov eax, dword [byte ebx+028h]
        and eax, 0FFFFh
        mov al, byte [dword eax+MoveFlags]
        and eax, 0FFh
        cmp eax, dword [byte ebx+04h]
        jg short .3
        mov ebp, dword [byte edx+01Ch]
        test ebp, ebp
        je short .3
        cmp ebp, byte 1
        je short .3
.2:
        mov eax, ebx
        call EndMove
        jmp short .4
.3:
        mov eax, ecx
        mov dword [byte edx+01Ch], 0
        mov edx, esp
        call LimitSkateSpeed
        mov edx, esp
        mov eax, ebx
        call StepMove
.4:
        add esp, byte 0Ch
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SteerMove                                       3B05C  97 PC, low confidence
; Move handler that steers the player until the move ends
;-----------------------------------------------------------------------------
SteerMove:
        push ebx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        mov dl, byte [byte ebx+01Ch]
        mov eax, dword [byte eax+02Ch]
        test dl, 80h
        je short .1
        mov eax, ebx
        call EndMove
        jmp short .2
.1:
        mov edx, dword [dword eax+0FAh]
        mov dword [byte edx+01Ch], 0
        mov edx, esp
        call LimitSkateSpeed
        mov edx, esp
        mov eax, ebx
        call StepMove
.2:
        add esp, byte 0Ch
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ReachForPuckAnim                                3B09C  97 PC, low confidence
; Turns a player toward the puck and starts the reach animation when the
; control switches to him
;-----------------------------------------------------------------------------
ReachForPuckAnim:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 28h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov edx, dword [dword eax+0FAh]
        mov eax, dword [PtrPuckFlags]
        fld dword [byte eax+020h]
        fsub dword [byte ecx+020h]
        fld dword [byte eax+028h]
        fsub dword [byte ecx+028h]
        fxch
        call IF@ATAN2
        fsub dword [byte ecx+01Ch]
        fld qword [F64_6p28319_ReachForPuckAnim]
        fxch
        call IF@DFMOD
        fst dword [byte esp+024h]
        fst qword [byte esp+014h]
        fcomp qword [F64_3p14159_ReachForPuckAnim]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+014h]
        fadd qword [F64_neg6p28319_ReachForPuckAnim]
        fstp dword [byte esp+024h]
.1:
        fld dword [byte esp+024h]
        fst qword [byte esp+01Ch]
        fcomp qword [F64_neg3p14159_ReachForPuckAnim]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+01Ch]
        fadd qword [F64_6p28319_ReachForPuckAnim]
        fstp dword [byte esp+024h]
.2:
        fld dword [byte esp+024h]
        fabs
        fcomp qword [F64_0p785398_ReachForPuckAnim]
        fnstsw ax
        sahf
        jbe short .5
        fldz
        fcomp dword [byte esp+024h]
        fnstsw ax
        sahf
        jae short .3
        mov edi, 5A7ED197h
        mov eax, 3FE921FBh
        mov dword [byte esp+0Ch], edi
        mov dword [byte esp+010h], eax
        jmp short .4
.3:
        mov ebx, 5A7ED197h
        mov esi, 0BFE921FBh
        mov dword [byte esp+0Ch], ebx
        mov dword [byte esp+010h], esi
.4:
        fld qword [byte esp+0Ch]
        fstp dword [byte esp+024h]
.5:
        fld dword [byte ecx+01Ch]
        fadd dword [byte esp+024h]
        mov eax, ecx
        fstp dword [byte ecx+01Ch]
        call GetStickBladePos
        fstp dword [byte esp+08h]
        fld dword [byte edx+038h]
        fcomp qword [F64_0p0001]
        fnstsw ax
        sahf
        jae short .6
        mov dword [byte edx+038h], 3F800000h
.6:
        fld dword [byte edx+038h]
        fdivr dword [byte ecx+038h]
        fst dword [byte ecx+038h]
        fcomp dword [byte esp+08h]
        fnstsw ax
        sahf
        jbe short .7
        mov eax, dword [byte esp+08h]
        mov dword [byte ecx+038h], eax
.7:
        fld dword [byte ecx+038h]
        fld st0
        fmul qword [F64_0p6]
        mov eax, edx
        fstp st1
        fstp dword [byte ecx+038h]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        xor ebx, ebx
        and ah, 0DFh
        mov edx, 9Ah
        mov byte [dword ecx+0BFh], ah
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
        db 090h
;-----------------------------------------------------------------------------
; PokeCheckAnim                                   3B1EC  97 PC, low confidence
; Starts the poke check animation (left, right or straight) toward the puck
;-----------------------------------------------------------------------------
PokeCheckAnim:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        lea ebx, [byte esp+08h]
        mov edx, esp
        mov esi, dword [dword eax+0FAh]
        call PickSaveAnim
        fldz
        fxch
        fstp dword [byte esp+04h]
        fcomp dword [byte esp+04h]
        fnstsw ax
        sahf
        ja near .7
        mov eax, esi
        call ResetAnimTimer
        fld dword [byte esp+08h]
        fabs
        fcomp qword [F64_96]
        fnstsw ax
        sahf
        jae short .1
        mov dword [byte esp+04h], 3F800000h
        mov al, byte [dword ecx+0BFh]
        mov edx, 46h
        or al, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], al
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        jmp near .6
.1:
        mov edx, dword [PtrPuckFlags]
        fld dword [byte esp+04h]
        fmul dword [byte edx+030h]
        fadd dword [byte edx+024h]
        fcomp dword [F32_144_PokeCheckAnim]
        fnstsw ax
        sahf
        jae near .6
        cmp byte [dword ecx+0D0h], 0
        setne dl
        mov ebx, edx
        fldz
        and ebx, 0FFh
        fcomp dword [byte esp+08h]
        fnstsw ax
        sahf
        setb dl
        and edx, 0FFh
        xor edx, ebx
        je short .2
        mov edx, 45h
        jmp short .3
.2:
        mov edx, 47h
.3:
        fld dword [byte esp+08h]
        fabs
        fmul qword [F64_0p00347222]
        fst dword [byte esp+04h]
        fcomp qword [F64_0p8]
        fnstsw ax
        sahf
        jae short .4
        mov dword [byte esp+04h], 3F4CCCCDh
.4:
        fld dword [byte esp+04h]
        fcomp qword [F64_1p2_PokeCheckAnim]
        fnstsw ax
        sahf
        jbe short .5
        mov dword [byte esp+04h], 3F99999Ah
.5:
        mov bl, byte [dword ecx+0BFh]
        or bl, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        xor ebx, ebx
        push dword 3F19999Ah
        call SetSPA
        mov edx, dword [dword ecx+0EEh]
        or byte [byte edx+031h], 1
.6:
        mov ah, byte [byte esi+031h]
        mov edx, dword [byte esp+04h]
        or ah, 1
        mov dword [byte esi+04h], edx
        mov byte [byte esi+031h], ah
.7:
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; TryBodyCheck                                    3B334  97 PC, low confidence
; One player tries to body check another: range, angle and speed checks, then
; the check animation; returns nonzero if started
;-----------------------------------------------------------------------------
TryBodyCheck:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 38h
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov ecx, edx
        mov edx, dword [dword eax+0FAh]
        test byte [dword eax+0BFh], 20h
        je short .1
        xor eax, eax
        jmp near .19
.1:
        cmp word [dword esi+0A9h], byte 0
        jle short .2
        cmp word [dword ecx+0A9h], byte 0
        jg short .3
.2:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.3:
        test byte [byte edx+031h], 10h
        jne short .4
        mov eax, dword [dword ecx+0FAh]
        test byte [byte eax+031h], 10h
        je short .5
.4:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.5:
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
        fst dword [byte esp+04h]
        fsub dword [byte esi+01Ch]
        fld qword [F64_6p28319_TryBodyCheck]
        fxch
        call IF@DFMOD
        fxch
        fstp dword [byte esp+08h]
        fst dword [byte esp+034h]
        fst qword [byte esp+020h]
        fcomp qword [F64_3p14159_TryBodyCheck]
        fnstsw ax
        sahf
        jbe short .6
        fld qword [byte esp+020h]
        fadd qword [F64_neg6p28319_TryBodyCheck]
        fstp dword [byte esp+034h]
.6:
        fld dword [byte esp+034h]
        fst qword [byte esp+010h]
        fcomp qword [F64_neg3p14159_TryBodyCheck]
        fnstsw ax
        sahf
        jae short .7
        fld qword [byte esp+010h]
        fadd qword [F64_6p28319_TryBodyCheck]
        fstp dword [byte esp+034h]
.7:
        fld dword [byte esp+034h]
        fabs
        fcomp qword [F64_1p0472]
        fnstsw ax
        sahf
        jbe short .8
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.8:
        fld dword [byte ecx+040h]
        fsub dword [byte esp+04h]
        fld qword [F64_6p28319_TryBodyCheck]
        fxch
        call IF@DFMOD
        fst dword [byte esp+030h]
        fst qword [byte esp+028h]
        fcomp qword [F64_3p14159_TryBodyCheck]
        fnstsw ax
        sahf
        jbe short .9
        fld qword [byte esp+028h]
        fadd qword [F64_neg6p28319_TryBodyCheck]
        fstp dword [byte esp+030h]
.9:
        fld dword [byte esp+030h]
        fst qword [byte esp+018h]
        fcomp qword [F64_neg3p14159_TryBodyCheck]
        fnstsw ax
        sahf
        jae short .10
        fld qword [byte esp+018h]
        fadd qword [F64_6p28319_TryBodyCheck]
        fstp dword [byte esp+030h]
.10:
        fld dword [byte esp+030h]
        fabs
        fcomp qword [F64_1p5708]
        fnstsw ax
        sahf
        jbe short .12
        fld dword [byte esp+08h]
        fcomp dword [F32_144_TryBodyCheck]
        fnstsw ax
        sahf
        jb short .11
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.11:
        mov edi, 88h
        jmp near .18
.12:
        fld dword [byte esp+08h]
        fcomp dword [F32_336]
        fnstsw ax
        sahf
        jb short .13
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.13:
        mov ah, byte [dword esi+0D0h]
        xor ebx, ebx
        test ah, ah
        setne al
        fldz
        mov bl, al
        fcomp dword [byte esp+034h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, ebx
        je short .16
        fld dword [byte esp+034h]
        fabs
        fcomp qword [F64_0p349066]
        fnstsw ax
        sahf
        jbe short .14
        fld dword [byte esp+08h]
        fcomp dword [F32_336]
        fnstsw ax
        sahf
        jae short .14
        mov edi, 89h
        jmp short .18
.14:
        fld dword [byte esp+034h]
        fabs
        fcomp qword [F64_0p785398_TryBodyCheck]
        fnstsw ax
        sahf
        jbe short .15
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.15:
        fld dword [byte esp+08h]
        fcomp dword [F32_192_TryBodyCheck]
        fnstsw ax
        sahf
        jae short .17
        mov edi, 8Ah
        jmp short .18
.16:
        fld dword [byte esp+08h]
        fcomp dword [F32_192_TryBodyCheck]
        fnstsw ax
        sahf
        jae short .17
        mov edi, 8Ah
        jmp short .18
.17:
        mov edi, 8Bh
.18:
        mov eax, dword [dword ecx+0FAh]
        or byte [byte eax+031h], 10h
        mov bh, byte [byte edx+031h]
        or bh, 10h
        xor eax, eax
        mov byte [byte edx+031h], bh
        mov al, byte [dword ecx+0A4h]
        mov dword [byte edx+020h], eax
        xor ebx, ebx
        mov eax, dword [dword ecx+0FAh]
        mov bl, byte [dword esi+0A4h]
        mov dword [byte eax+020h], ebx
        mov eax, edx
        call ResetAnimTimer
        mov al, byte [dword esi+0BFh]
        xor ebx, ebx
        or al, 20h
        mov edx, edi
        mov byte [dword esi+0BFh], al
        mov eax, esi
        push dword 3F333333h
        call SetSPA
        mov eax, dword [dword ecx+0FAh]
        xor edx, edx
        call ResetAnimTimer
        mov dl, byte [dword esi+0C2h]
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        add eax, eax
        xor edx, edx
        add eax, byte 78h
        mov dl, byte [dword ecx+0C2h]
        mov dword [byte esp+0Ch], eax
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        add eax, eax
        add eax, byte 78h
        mov dword [esp], eax
        fild dword [byte esp+0Ch]
        fild dword [esp]
        fadd st1
        fdivr st1
        fld dword [byte ecx+038h]
        fxch
        fstp st2
        fmulp
        mov eax, dword [dword ecx+0FAh]
        fstp dword [byte ecx+038h]
        mov dword [byte eax+04h], 3F333333h
        lea eax, [nosplit edi*8+00h]
        sub eax, edi
        fld dword [nosplit eax*8+StrideSpeeds]
        fmul qword [F64_0p7]
        fsubr dword [byte ecx+038h]
        mov eax, dword [dword ecx+0FAh]
        fstp dword [byte eax+08h]
        mov eax, dword [dword ecx+0FAh]
        mov dword [byte eax+034h], 461C4000h
        or byte [dword ecx+0BFh], 20h
        mov eax, 3
        push dword 3F333333h
        call randomd0
        movsx edx, ax
        xor ebx, ebx
        add edx, 81h
        mov eax, ecx
        call SetSPA
        mov eax, 1
.19:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DoCheckButton                                   3B690  97 PC, low confidence
; The human player presses check: poke check, or body check the carrier, or
; the nearest opponent
;-----------------------------------------------------------------------------
DoCheckButton:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        call TryPokePuck
        test eax, eax
        jne near .5
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .1
        cmp byte [dword esi+0A4h], 6
        setb al
        xor edx, edx
        mov dl, al
        mov eax, dword [puckc]
        cmp byte [eax], 6
        setl al
        and eax, 0FFh
        xor eax, edx
        je short .1
        mov edx, dword [puckc]
        movsx edx, byte [edx]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov edx, SortCords
        shl eax, 3
        add edx, eax
        mov eax, esi
        call TryBodyCheck
        test eax, eax
        jne short .5
.1:
        cmp byte [dword esi+0A4h], 6
        jae short .2
        mov ebx, 6
        jmp short .3
.2:
        xor ebx, ebx
.3:
        mov eax, ebx
        shl eax, 5
        add eax, ebx
        mov ebx, SortCords
        shl eax, 3
        xor ecx, ecx
        add ebx, eax
.4:
        mov edx, ebx
        mov eax, esi
        call TryBodyCheck
        test eax, eax
        jne short .5
        inc ecx
        add ebx, 108h
        cmp ecx, byte 6
        jl short .4
.5:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; AIBodyCheck                                     3B738  97 PC, low confidence
; A computer player body checks the given opponent
;-----------------------------------------------------------------------------
AIBodyCheck:
        push ebx
        push ecx
        mov ebx, dword [dword eax+0EEh]
        or byte [byte ebx+029h], 20h
        mov ecx, dword [dword eax+0EEh]
        mov bl, byte [dword edx+0A4h]
        mov byte [byte ecx+02Ch], bl
        call TryBodyCheck
        pop ecx
        pop ebx
        ret
