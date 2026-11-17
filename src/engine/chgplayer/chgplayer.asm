; Player switching: the controlled player.
bits 32
%include "hockey.inc"
section s_5ED7E progbits alloc exec nowrite align=1
extern ChangeAnim, gmode, IsSkateAnim, IsStopAnim, MoveFuncPair, MoveFuncTable, MoveState, SpaEnabled
extern StartAnim, StartAnimNow
global SetSPA, SetSPAInPlace
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetSPA                                         5ED80  94G, medium confidence
; (player, animation 0-17Ch, flags, speed) sets the player's
; animation; restarts it unless it is already playing
;-----------------------------------------------------------------------------
SetSPA:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov esi, eax
        mov ecx, edx
        mov edi, ebx
        mov ebx, dword [dword eax+0F6h]
        mov ebx, dword [ebx]
        mov eax, dword [byte ebx+028h]
        and eax, 0FFFFh
        mov edx, MoveState
        mov dword [byte esp+04h], eax
        cmp ecx, eax
        jne short .1
        test byte [byte ebx+01Ch], 80h
        je near .15
.1:
        mov eax, dword [dword esi+0FAh]
        mov ebp, dword [byte esp+01Ch]
        mov dword [byte eax+038h], ebp
        mov eax, dword [dword esi+0FAh]
        and byte [byte eax+031h], 0FEh
        cmp ecx, 17Dh
        jl short .2
        xor ecx, ecx
.2:
        mov eax, ecx
        call IsSkateAnim
        test eax, eax
        je short .3
        mov eax, dword [dword esi+0EEh]
        or byte [byte eax+031h], 1
        jmp short .4
.3:
        mov eax, dword [dword esi+0EEh]
        and byte [byte eax+031h], 0FEh
.4:
        mov eax, ecx
        call IsStopAnim
        test eax, eax
        je short .5
        mov eax, dword [dword esi+0EEh]
        or byte [byte eax+031h], 8
        jmp short .6
.5:
        mov eax, dword [dword esi+0EEh]
        and byte [byte eax+031h], 0F7h
.6:
        mov dword [byte edx+010h], 0
        mov eax, dword [nosplit ecx*4+MoveFuncPair]
        test byte [byte eax+0Eh], 10h
        je short .7
        mov eax, dword [byte esp+04h]
        mov eax, dword [nosplit eax*4+MoveFuncPair]
        test byte [byte eax+0Eh], 10h
        je short .7
        mov eax, dword [byte ebx+04h]
        mov dword [byte edx+010h], eax
.7:
        mov eax, dword [nosplit ecx*4+MoveFuncPair]
        mov al, byte [byte eax+0Dh]
        and eax, 0FFh
        mov dword [esp], eax
        mov ebp, dword [esp]
        cmp ebp, dword [byte edx+010h]
        jg short .8
        mov dword [byte edx+010h], 0
.8:
        mov dword [edx], ecx
        mov eax, dword [nosplit ecx*4+MoveFuncPair]
        mov dword [byte edx+08h], eax
        mov dword [byte edx+04h], esi
        mov eax, dword [byte esp+01Ch]
        mov dword [byte edx+018h], eax
        mov eax, dword [dword esi+0F2h]
        fld dword [byte eax+03Ch]
        mov dword [byte edx+0Ch], 0
        fstp dword [byte edx+014h]
        mov eax, dword [nosplit ecx*4+MoveFuncTable]
        mov dword [byte edx+024h], eax
        cmp byte [dword esi+0D0h], 0
        je short .9
        or byte [byte edx+0Ch], 8
        jmp short .10
.9:
        and byte [byte edx+0Ch], 0F7h
.10:
        test edi, edi
        je short .11
        or dword [byte edx+0Ch], edi
.11:
        cmp dword [SpaEnabled], byte 0
        je short .14
        test byte [gmode], 1
        je short .12
        mov ebx, 8
        jmp short .13
.12:
        mov ebx, 4
.13:
        mov eax, dword [dword esi+0F6h]
        call ChangeAnim
        jmp short .15
.14:
        mov eax, ebx
        call StartAnim
.15:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret 4
;-----------------------------------------------------------------------------
; SetSPAInPlace                                   5EEEC  97 PC, low confidence
; Sets an animation without moving the player
;-----------------------------------------------------------------------------
SetSPAInPlace:
        push ecx
        push esi
        push edi
        push ebp
        mov ecx, eax
        mov esi, edx
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov edi, dword [byte eax+028h]
        mov eax, dword [dword ecx+0FAh]
        mov edx, MoveState
        and edi, 0FFFFh
        and byte [byte eax+031h], 0FEh
        cmp esi, 17Dh
        jl short .1
        xor esi, esi
.1:
        mov eax, esi
        call IsSkateAnim
        test eax, eax
        je short .2
        mov eax, dword [dword ecx+0EEh]
        or byte [byte eax+031h], 1
        jmp short .3
.2:
        mov eax, dword [dword ecx+0EEh]
        and byte [byte eax+031h], 0FEh
.3:
        mov eax, esi
        call IsStopAnim
        test eax, eax
        je short .4
        mov eax, dword [dword ecx+0EEh]
        or byte [byte eax+031h], 8
        jmp short .5
.4:
        mov eax, dword [dword ecx+0EEh]
        and byte [byte eax+031h], 0F7h
.5:
        mov eax, dword [dword ecx+0FAh]
        mov ebp, dword [byte esp+014h]
        mov dword [byte eax+038h], ebp
        mov dword [byte edx+010h], 0
        mov eax, dword [nosplit esi*4+MoveFuncPair]
        test byte [byte eax+0Eh], 10h
        je short .6
        mov eax, dword [nosplit edi*4+MoveFuncPair]
        test byte [byte eax+0Eh], 10h
        je short .6
        mov eax, dword [dword ecx+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+04h]
        mov dword [byte edx+010h], eax
.6:
        mov eax, dword [nosplit esi*4+MoveFuncPair]
        mov al, byte [byte eax+0Dh]
        and eax, 0FFh
        cmp eax, dword [byte edx+010h]
        jg short .7
        mov dword [byte edx+010h], 0
.7:
        mov dword [edx], esi
        mov eax, dword [nosplit esi*4+MoveFuncPair]
        mov dword [byte edx+08h], eax
        mov dword [byte edx+04h], ecx
        mov eax, dword [byte esp+014h]
        mov dword [byte edx+018h], eax
        mov eax, dword [dword ecx+0F2h]
        fld dword [byte eax+03Ch]
        mov dword [byte edx+0Ch], 0
        fstp dword [byte edx+014h]
        mov eax, dword [nosplit esi*4+MoveFuncTable]
        mov dword [byte edx+024h], eax
        cmp byte [dword ecx+0D0h], 0
        je short .8
        or byte [byte edx+0Ch], 8
        jmp short .9
.8:
        and byte [byte edx+0Ch], 0F7h
.9:
        test ebx, ebx
        je short .10
        or dword [byte edx+0Ch], ebx
.10:
        mov eax, dword [dword ecx+0F6h]
        call StartAnimNow
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret 4
