; Crowd and commentary cues for the puck zone, shot chances and line changes.
bits 32
%include "hockey.inc"
section s_1DEE1 progbits alloc exec nowrite align=1
extern __CHP, BreakawayFlag, CommentaryEvent, F64_576, gmode, holdreset, LastTouchPlayer, OneTimerTarget
extern PlayerControlFlags, gmode2, PtrPuckFlags, puckc, randomd0, SetCrowdMood, SimFrames, SortCords
extern StoppageFlag, vecdist
global CrowdForPuckZone, CrowdForPlayer, ShotChanceCommentary, LineChangeCommentary
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CrowdForPuckZone                                1DEE4  97 PC, low confidence
; Sets the crowd mood from where the player touching the puck is: own zone, neutral zone, deep, or near the
; net on a fast puck; nothing while the puck is in its faceoff state
;-----------------------------------------------------------------------------
CrowdForPuckZone:
        push ebx
        push ecx
        push edx
        sub esp, byte 4
        mov edx, dword [PtrPuckFlags]
        mov ebx, dword [dword edx+0AEh]
        sar ebx, 18h
        cmp byte [dword edx+ebx+0B2h], 44h
        je near .8
        fld dword [byte eax+028h]
        call __CHP
        mov ch, byte [dword eax+0BFh]
        fistp dword [esp]
        test ch, 80h
        jne short .1
        neg dword [esp]
.1:
        mov ebx, dword [esp]
        cmp ebx, 0FFFFFA90h
        jge short .2
        mov eax, 5
        jmp short .7
.2:
        cmp ebx, 570h
        jge short .3
        mov eax, 6
        call SetCrowdMood
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        cmp ebx, 10B0h
        jg short .4
        cmp ebx, 930h
        jge short .5
.4:
        mov eax, 7
        call SetCrowdMood
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        fld dword [byte eax+020h]
        fabs
        fcomp qword [F64_576]
        fnstsw ax
        sahf
        jbe short .6
        mov eax, 8
        call SetCrowdMood
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        mov eax, 9
.7:
        call SetCrowdMood
.8:
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CrowdForPlayer                                  1DFA0  97 PC, low confidence
; Sets the crowd mood when a player gets the puck: by which team and whether
; he is past the blue line
;-----------------------------------------------------------------------------
CrowdForPlayer:
        push ebx
        push edx
        sub esp, byte 4
        mov edx, dword [PtrPuckFlags]
        mov ebx, dword [dword edx+0AEh]
        sar ebx, 18h
        cmp byte [dword edx+ebx+0B2h], 44h
        je short .6
        cmp byte [dword eax+0A4h], 0Ch
        jne short .1
        mov eax, 9
        jmp short .5
.1:
        mov dl, byte [dword eax+0BFh]
        test dl, 40h
        je short .4
        fld dword [byte eax+028h]
        call __CHP
        fistp dword [esp]
        test dl, 80h
        jne short .2
        neg dword [esp]
.2:
        cmp dword [esp], 570h
        jle short .3
        mov eax, 9
        jmp short .5
.3:
        mov eax, 8
        jmp short .5
.4:
        mov eax, 3
.5:
        call SetCrowdMood
.6:
        add esp, byte 4
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ShotChanceCommentary                            1E014  97 PC, low confidence
; Each frame: rates how close the carrier is to a scoring chance (distance to
; the goal) and sets the crowd mood and the play-by-play excitement level
;-----------------------------------------------------------------------------
ShotChanceCommentary:
        push ebx
        push ecx
        push edx
        mov edx, 1000h
        mov ah, byte [gmode]
        mov dword [LastTouchPlayer], edx
        test ah, 1
        jne near .7
        cmp word [BreakawayFlag], byte 0
        jne near .7
        cmp word [OneTimerTarget], byte 0
        jne near .7
        mov eax, dword [SimFrames]
        mov edx, dword [StoppageFlag]
        sar eax, 10h
        sar edx, 10h
        test eax, eax
        jge short .1
        neg eax
.1:
        cmp eax, 570h
        jle near .5
        mov ebx, 10B0h
        sub ebx, eax
        push ebx
        push edx
        call vecdist
        add esp, byte 8
        mov ebx, eax
        cmp eax, 780h
        jge short .2
        mov dword [LastTouchPlayer], 1001h
.2:
        test byte [holdreset], 40h
        je short .5
        mov eax, dword [puckc]
        mov dh, byte [eax]
        test dh, dh
        jl short .5
        movsx edx, dh
        mov eax, edx
        shl eax, 5
        add eax, edx
        test byte [nosplit eax*8+PlayerControlFlags], 80h
        setne al
        mov edx, eax
        mov cx, word [StoppageFlag]
        and edx, 0FFh
        test cx, cx
        setl al
        and eax, 0FFh
        xor eax, edx
        je short .5
        cmp ebx, 5A0h
        jge short .3
        mov eax, 7
        jmp short .4
.3:
        cmp ebx, 0B40h
        jge short .5
        mov eax, 6
.4:
        call SetCrowdMood
.5:
        mov eax, dword [PtrPuckFlags]
        mov edx, dword [byte eax+04h]
        mov eax, dword [byte eax+0Ch]
        sar eax, 10h
        sar edx, 10h
        test eax, eax
        jge short .6
        neg eax
.6:
        mov ebx, 10B0h
        sub ebx, eax
        push ebx
        push edx
        call vecdist
        add esp, byte 8
        cmp eax, 0D20h
        jae short .7
        mov eax, dword [puckc]
        mov ch, byte [eax]
        test ch, ch
        jl short .9
        movsx edx, ch
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        test byte [dword eax+0BFh], 80h
        setne dl
        fldz
        and edx, 0FFh
        fcomp dword [byte eax+028h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        jne short .7
        push byte 1
        jmp short .8
.7:
        push byte 0
.8:
        push dword 0A000002Fh
        call CommentaryEvent
        add esp, byte 8
.9:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LineChangeCommentary                            1E184  97 PC, low confidence
; Play-by-play call for a line change of the given player's team (more often
; while play is stopped)
;-----------------------------------------------------------------------------
LineChangeCommentary:
        push ebx
        push ecx
        mov ebx, eax
        test byte [gmode], 1
        jne short .3
        cmp word [BreakawayFlag], byte 0
        jne short .3
        mov cl, byte [gmode2]
        test cl, 20h
        je short .4
        test byte [dword ebx+0BFh], 40h
        je short .1
        test cl, 40h
        jne short .2
.1:
        test byte [dword ebx+0BFh], 40h
        jne short .4
        test byte [gmode2], 40h
        jne short .4
.2:
        mov edx, 0A001h
        jmp short .4
.3:
        mov eax, 5
        call randomd0
        test ax, ax
        jne short .5
.4:
        mov ecx, dword [LastTouchPlayer]
        push ecx
        mov ch, byte [dword ebx+0BFh]
        push byte 0
        test ch, 40h
        setne al
        xor ebx, ebx
        mov bl, al
        push ebx
        push edx
        push dword 0A0000015h
        call CommentaryEvent
        add esp, byte 14h
.5:
        pop ecx
        pop ebx
        ret
