; Skating and gliding with the puck.
bits 32
%include "hockey.inc"
section s_6B13E progbits alloc exec nowrite align=1
extern ApplySkateAccel, BlockReach, F64_384_GlideWithPuckMove, F64_384_SkateWithPuckMove, F64_4272_GlideWithPuckMove, F64_4272_SkateWithPuckMove, F64_4448_GlideWithPuckMove, F64_4448_SkateWithPuckMove
extern F64_864_GlideWithPuckMove, F64_864_SkateWithPuckMove, GlideForwardMove, hypot_, PickSkateAnim, PtrPuckZone, SkateForwardMove, StartPuckReceiveAnim
extern SteerTowardTarget, StepMove
global SkateWithPuckMove, GlideWithPuckMove
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SkateWithPuckMove                               6B140  97 PC, low confidence
; Move handler for skating with the puck
;-----------------------------------------------------------------------------
SkateWithPuckMove:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 18h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov ebx, dword [byte eax+02Ch]
        mov dx, word [dword ebx+0A9h]
        mov esi, dword [dword ebx+0FAh]
        test dx, dx
        jle short .1
        mov edx, dword [PtrPuckZone]
        xor eax, eax
        movsx edx, byte [edx]
        mov al, byte [dword ebx+0A4h]
        cmp eax, edx
        jne short .1
        test byte [byte esi+030h], 1
        jne short .1
        mov eax, ebx
        call StartPuckReceiveAnim
.1:
        cmp word [dword ebx+0A9h], byte 0
        jne short .2
        mov eax, dword [PtrPuckZone]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ebx+0A4h]
        cmp edx, eax
        je short .2
        mov eax, ebx
        call PickSkateAnim
        jmp near .7
.2:
        cmp word [dword ebx+0A9h], byte 0
        jne near .6
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        cmp byte [dword edx+ebx+0B2h], 17h
        je near .6
        fld dword [byte ebx+028h]
        fabs
        fst qword [byte esp+010h]
        fcomp qword [F64_4272_SkateWithPuckMove]
        fnstsw ax
        sahf
        jbe short .3
        fld qword [byte esp+010h]
        fcomp qword [F64_4448_SkateWithPuckMove]
        fnstsw ax
        sahf
        ja short .6
        fld dword [byte ebx+020h]
        fabs
        fcomp qword [F64_384_SkateWithPuckMove]
        fnstsw ax
        sahf
        ja short .6
.3:
        test byte [dword ebx+0BFh], 80h
        je short .4
        mov dword [byte esp+0Ch], 0FFFFEF50h
        jmp short .5
.4:
        mov dword [byte esp+0Ch], 10B0h
.5:
        fild dword [byte esp+0Ch]
        fsubr dword [byte ebx+028h]
        sub esp, byte 8
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte ebx+020h]
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_864_SkateWithPuckMove]
        fnstsw ax
        sahf
        ja short .6
        mov edx, esp
        mov eax, ebx
        call BlockReach
        mov edx, esp
        mov eax, ecx
        call StepMove
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        mov eax, ecx
        call SkateForwardMove
.7:
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        mov ebx, eax
        mov ecx, edx
        call ApplySkateAccel
        mov edx, ecx
        mov eax, ebx
        call SteerTowardTarget
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; GlideWithPuckMove                               6B28C  97 PC, low confidence
; Move handler for gliding with the puck
;-----------------------------------------------------------------------------
GlideWithPuckMove:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov edx, dword [byte eax+02Ch]
        mov cx, word [dword edx+0A9h]
        mov eax, dword [dword edx+0FAh]
        test cx, cx
        jle short .1
        mov ecx, dword [PtrPuckZone]
        movzx esi, byte [dword edx+0A4h]
        movsx ecx, byte [ecx]
        cmp esi, ecx
        jne short .1
        test byte [byte eax+030h], 1
        jne short .1
        mov eax, edx
        call StartPuckReceiveAnim
.1:
        cmp word [dword edx+0A9h], byte 0
        jne near .5
        mov eax, dword [dword edx+0AEh]
        sar eax, 18h
        cmp byte [dword edx+eax+0B2h], 17h
        je near .5
        fld dword [byte edx+028h]
        fabs
        fst qword [byte esp+04h]
        fcomp qword [F64_4272_GlideWithPuckMove]
        fnstsw ax
        sahf
        jbe short .2
        fld qword [byte esp+04h]
        fcomp qword [F64_4448_GlideWithPuckMove]
        fnstsw ax
        sahf
        ja short .5
        fld dword [byte edx+020h]
        fabs
        fcomp qword [F64_384_GlideWithPuckMove]
        fnstsw ax
        sahf
        ja short .5
.2:
        test byte [dword edx+0BFh], 80h
        je short .3
        mov dword [esp], 0FFFFEF50h
        jmp short .4
.3:
        mov dword [esp], 10B0h
.4:
        fild dword [esp]
        fsubr dword [byte edx+028h]
        sub esp, byte 8
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte edx+020h]
        fstp qword [esp]
        call hypot_
        fcomp qword [F64_864_GlideWithPuckMove]
        fnstsw ax
        sahf
        ja short .5
        mov eax, edx
        call PickSkateAnim
        jmp short .6
.5:
        mov eax, ebx
        call GlideForwardMove
.6:
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
