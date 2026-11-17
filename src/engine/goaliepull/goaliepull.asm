; Goalie pull: pulling and returning goalies.
bits 32
%include "hockey.inc"
section s_2DCC5 progbits alloc exec nowrite align=1
extern AwayGoalieOff, awtmstruct, CommentaryEvent, FaceoffSpot, gameclock, gmode, goalieflags, GoalieOut
extern gsp, hmtmstruct, HomeGoalieOff, penshotmode, PtrPuckOwner, puckc, setpersonel
global CPgoalie, ChkGoalies, ReturnGoalies
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CPgoalie                                       2DCC8  94G, medium confidence
; pulls the computer team's goalie late in the
; third period
;-----------------------------------------------------------------------------
CPgoalie:
        push ecx
        cmp word [penshotmode], byte 0
        jne near .2
        cmp word [gsp], byte 2
        jne near .2
        cmp word [gameclock], byte 3Ch
        jg short .2
        mov ecx, dword [dword eax+0104h]
        test byte [dword ecx+0BFh], 80h
        jne short .1
        neg ebx
.1:
        test bx, bx
        jl short .2
        mov bx, word [eax]
        mov dx, word [edx]
        sub edx, ebx
        test dx, dx
        jle short .2
        cmp dx, byte 2
        jg short .2
        mov dl, byte [byte eax+011h]
        mov ebx, dword [dword eax+0FAh]
        or dl, 0FFh
        sar ebx, 10h
        mov byte [byte eax+011h], dl
        mov edx, ebx
        shl edx, 5
        add edx, ebx
        cmp eax, awtmstruct
        sete bl
        and ebx, 0FFh
        mov dl, byte [nosplit edx*8+goalieflags]
        mov byte [dword ebx+GoalieOut], dl
        call setpersonel
.2:
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ChkGoalies                                                        2DD54  94G
;
; (computer pulls goalie on delayed penalty): from periodicevents; per team, no goalie pull
; when the team has the puck; on a delayed penalty sets no goalie (setpersonel) and calls the PA event, else
; CPgoalie for a computer team
;-----------------------------------------------------------------------------
ChkGoalies:
        push ebx
        push ecx
        push edx
        push esi
        test byte [gmode], 1
        jne near .6
        mov eax, hmtmstruct
        mov edx, awtmstruct
        xor ecx, ecx
.1:
        cmp word [byte eax+010h], byte 0
        jl near .5
        mov esi, dword [puckc]
        mov bl, byte [esi]
        test bl, bl
        jl near .5
        cmp bl, 6
        setl bl
        movzx esi, bl
        test cx, cx
        sete bl
        and ebx, 0FFh
        xor ebx, esi
        jne near .5
        test byte [gmode], 8
        je short .2
        mov bh, byte [byte eax+011h]
        mov edx, dword [dword eax+0FAh]
        or bh, 0FFh
        sar edx, 10h
        mov byte [byte eax+011h], bh
        imul ebx, edx, dword 108h
        cmp eax, awtmstruct
        sete dl
        and edx, 0FFh
        mov bl, byte [dword ebx+goalieflags]
        mov byte [dword edx+GoalieOut], bl
        call setpersonel
        push dword 0A0000024h
        call CommentaryEvent
        add esp, byte 4
        jmp short .5
.2:
        test cx, cx
        je short .3
        mov bx, word [AwayGoalieOff]
        jmp short .4
.3:
        mov bx, word [HomeGoalieOff]
.4:
        test bx, bx
        jne short .5
        mov ebx, dword [PtrPuckOwner]
        movsx ebx, word [ebx]
        call CPgoalie
.5:
        mov edx, hmtmstruct
        inc ecx
        mov eax, awtmstruct
        cmp cx, byte 2
        jl near .1
.6:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ReturnGoalies                    2DE3C  93G logic93_4.asm, medium confidence
; (computer returns a pulled goalie), from puckfaceoff.
;-----------------------------------------------------------------------------
ReturnGoalies:
        push ebx
        push ecx
        push edx
        mov eax, hmtmstruct
        mov edx, awtmstruct
        xor ecx, ecx
.1:
        test byte [byte eax+010h], 0F0h
        jne short .4
        mov byte [byte eax+011h], 0
        test cx, cx
        je short .2
        mov bx, word [AwayGoalieOff]
        jmp short .3
.2:
        mov bx, word [HomeGoalieOff]
.3:
        test bx, bx
        jne short .4
        mov ebx, dword [FaceoffSpot]
        sar ebx, 10h
        call CPgoalie
.4:
        mov edx, hmtmstruct
        inc ecx
        mov eax, awtmstruct
        cmp cx, byte 2
        jl short .1
        pop edx
        pop ecx
        pop ebx
        ret
