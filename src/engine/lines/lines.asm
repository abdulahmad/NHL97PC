; Lines: sorting by position, building team lines, auto lines and replacements.
bits 32
%include "hockey.inc"
section s_3088F progbits alloc exec nowrite align=1
extern AutoLineData, AwScore, awtmstruct, CentersByDefense, CentersByOffense, DefenseByDefense, DefenseByOffense, ForwardsByDefense
extern ForwardsByOffense, HmScore, hmtmstruct, homelines, LeftWingsByDefense, LeftWingsByOffense, LineBuildLine, LineBuildPlayer
extern LineBuildSlot, LineReplaceOrder, lineslotgroupstart, lineslotgroups, LineSlotPositions, LineSlotStart, LineSlotTaken, LineSortIndex
extern LineSortKeys, LineSortOrder, RightWingsByDefense, RightWingsByOffense, SortIndices
global PositionSlotJumpTable, PositionSlot, PositionSlot_1D, PositionSlot_21, PositionSlot_25, PositionSlot_29, PositionSlot_2D, PositionSlot_31
global PositionSlot_35, SortByPosition, SortForwards, BuildTeamLines, SetupAutoLines, CanPlayLineSlot, FindLinePlayer, PickLineReplacement
global CopyGoalieSlot, FixLineSlot, RebuildLines, UpdateLinesForAbsent, InitGameLines
        db 00h
PositionSlotJumpTable:                          ; jump table for the switch cases of PositionSlot
        dd PositionSlot_2D
        dd PositionSlot_29
        dd PositionSlot_31
        dd PositionSlot_21
        dd PositionSlot_35
        dd PositionSlot_25
        dd PositionSlot_1D
;-----------------------------------------------------------------------------
; PositionSlot                                    308AC  97 PC, low confidence
; (position word 8001h-8007h): the line slot number of a roster position code
;-----------------------------------------------------------------------------
PositionSlot:
        push edx
        mov edx, eax
        sub edx, 8001h
        cmp dx, byte 6
        ja short PositionSlot_35.1
        and edx, 0FFFFh
        jmp dword [nosplit cs:edx*4+PositionSlotJumpTable]
PositionSlot_1D:
        xor al, al
        pop edx
        ret
PositionSlot_21:
        mov al, 1
        pop edx
        ret
PositionSlot_25:
        mov al, 2
        pop edx
        ret
PositionSlot_29:
        mov al, 3
        pop edx
        ret
PositionSlot_2D:
        mov al, 4
        pop edx
        ret
PositionSlot_31:
        mov al, 6
        pop edx
        ret
PositionSlot_35:
        mov al, 8
        pop edx
        ret
.1:
        test ah, 8
        je short .2
        mov al, 7
        pop edx
        ret
.2:
        mov al, 5
        pop edx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SortByPosition                                  308F4  97 PC, low confidence
; Sorts the team's dressed players of one position letter by rating
; (SortIndices)
;-----------------------------------------------------------------------------
SortByPosition:
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov edi, eax
        mov ebp, edx
        mov esi, ebx
        mov byte [esp], cl
        lea ebx, [dword eax+0A3h]
        xor edx, edx
        xor eax, eax
.1:
        mov dword [dword eax+LineSortOrder], edx
        mov ecx, dword [dword edi+09Fh]
        sar ecx, 10h
        cmp edx, ecx
        jge short .2
        mov cl, byte [dword ebx+0BDh]
        cmp cl, byte [esp]
        je short .3
.2:
        mov dword [dword eax+LineSortKeys], 0FFFFFFFFh
        jmp short .4
.3:
        movsx ecx, word [esi]
        mov dword [dword eax+LineSortKeys], ecx
.4:
        add esi, byte 2
        add eax, byte 4
        inc edx
        add ebx, 125h
        cmp edx, byte 19h
        jl short .1
        push LineSortOrder
        push LineSortKeys
        push byte 19h
        call SortIndices
        add esp, byte 0Ch
        mov edx, ebp
        xor eax, eax
.5:
        cmp dword [dword eax+LineSortKeys], byte 0
        jge short .6
        mov ebx, 0FFFFFFFFh
        jmp short .7
.6:
        mov ebx, dword [dword eax+LineSortIndex]
        sar ebx, 18h
.7:
        inc edx
        add eax, byte 4
        mov byte [byte edx-01h], bl
        cmp eax, byte 64h
        jne short .5
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SortForwards                                    30998  97 PC, low confidence
; Sorts the team's dressed non-defencemen by rating (SortIndices)
;-----------------------------------------------------------------------------
SortForwards:
        push ecx
        push esi
        push edi
        push ebp
        mov edi, eax
        mov ebp, edx
        mov esi, ebx
        lea ebx, [dword eax+0A3h]
        xor edx, edx
        xor eax, eax
.1:
        mov dword [dword eax+LineSortOrder], edx
        mov ecx, dword [dword edi+09Fh]
        sar ecx, 10h
        cmp edx, ecx
        jge short .2
        cmp byte [dword ebx+0BDh], 44h
        jne short .3
.2:
        mov dword [dword eax+LineSortKeys], 0FFFFFFFFh
        jmp short .4
.3:
        movsx ecx, word [esi]
        mov dword [dword eax+LineSortKeys], ecx
.4:
        add esi, byte 2
        add eax, byte 4
        inc edx
        add ebx, 125h
        cmp edx, byte 19h
        jl short .1
        push LineSortOrder
        push LineSortKeys
        push byte 19h
        call SortIndices
        add esp, byte 0Ch
        mov edx, ebp
        xor eax, eax
.5:
        cmp dword [dword eax+LineSortKeys], byte 0
        jge short .6
        mov ebx, 0FFFFFFFFh
        jmp short .7
.6:
        mov ebx, dword [dword eax+LineSortIndex]
        sar ebx, 18h
.7:
        inc edx
        add eax, byte 4
        mov byte [byte edx-01h], bl
        cmp eax, byte 64h
        jne short .5
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; BuildTeamLines                                  30A34  97 PC, low confidence
; Builds a team's line table (+20EDh) from the sorted player lists
;-----------------------------------------------------------------------------
BuildTeamLines:
        push esi
        push edi
        push ebp
        sub esp, byte 4Ch
        mov dword [byte esp+044h], ebx
        mov dword [byte esp+040h], ecx
        add edx, 20EDh
        mov dword [byte esp+02Ch], edx
        test ax, ax
        jle short .1
        mov eax, awtmstruct
        jmp short .2
.1:
        mov eax, hmtmstruct
.2:
        mov ebx, 0FFFFFFECh
        mov dword [byte esp+030h], eax
        xor edx, edx
        mov dword [byte esp+020h], eax
        mov dword [byte esp+048h], edx
        mov edx, dword [byte esp+02Ch]
        xor ecx, ecx
        add edx, byte 12h
        mov dword [byte esp+034h], ebx
        mov dword [byte esp+028h], edx
        mov edx, dword [byte esp+02Ch]
        mov dword [byte esp+038h], ecx
        add edx, byte 26h
        mov dword [byte esp+03Ch], ecx
        mov dword [byte esp+024h], edx
.3:
        mov eax, dword [byte esp+03Ch]
        xor edi, edi
        mov ebp, dword [byte esp+048h]
        mov dword [esp+eax], edi
        cmp ebp, byte 4
        jge short .4
        mov eax, dword [byte esp+02Ch]
        mov ecx, dword [byte esp+038h]
        mov esi, 3
        add eax, ecx
        jmp short .6
.4:
        cmp ebp, byte 6
        jge short .5
        mov eax, dword [byte esp+028h]
        mov ebx, dword [byte esp+034h]
        mov esi, 5
        add eax, ebx
        jmp short .6
.5:
        mov edx, dword [byte esp+024h]
        sub eax, byte 18h
        mov esi, 4
        add eax, edx
.6:
        mov edi, dword [byte esp+03Ch]
        xor edx, edx
        test esi, esi
        jle short .10
.7:
        mov ebx, edi
        inc eax
        xor ecx, ecx
        mov ebp, dword [byte esp+048h]
        mov cl, byte [byte eax-01h]
        lea ebx, [esp+ebx]
        add ecx, ecx
        cmp ebp, byte 6
        jge short .8
        add ecx, dword [byte esp+044h]
        jmp short .9
.8:
        add ecx, dword [byte esp+040h]
.9:
        mov cx, word [ecx]
        movsx ecx, cx
        mov ebp, dword [ebx]
        add ebp, ecx
        inc edx
        mov dword [ebx], ebp
        cmp edx, esi
        jl short .7
.10:
        mov ebx, dword [byte esp+03Ch]
        mov ecx, dword [byte esp+030h]
        mov esi, dword [byte esp+048h]
        mov eax, dword [byte esp+048h]
        mov edx, dword [byte esp+030h]
        add ebx, byte 4
        inc ecx
        inc esi
        mov dword [dword edi+LineSortOrder], eax
        mov al, byte [byte esp+048h]
        mov dword [byte esp+03Ch], ebx
        mov dword [byte esp+030h], ecx
        mov dword [byte esp+048h], esi
        mov byte [dword edx+0ACh], al
        mov eax, dword [byte esp+034h]
        mov edx, dword [byte esp+038h]
        add eax, byte 5
        add edx, byte 3
        mov dword [byte esp+034h], eax
        mov dword [byte esp+038h], edx
        cmp esi, byte 8
        jl near .3
        mov eax, dword [byte esp+01Ch]
        cmp eax, dword [byte esp+018h]
        jle short .11
        mov eax, dword [byte esp+020h]
        mov byte [dword eax+0B3h], 6
        mov byte [dword eax+0B2h], 7
.11:
        mov eax, dword [byte esp+014h]
        cmp eax, dword [byte esp+010h]
        jle short .12
        mov eax, dword [byte esp+020h]
        mov byte [dword eax+0B1h], 4
        mov byte [dword eax+0B0h], 5
.12:
        push LineSortOrder
        lea eax, [byte esp+04h]
        push eax
        push byte 4
        call SortIndices
        add esp, byte 0Ch
        xor ecx, ecx
        mov ebx, dword [byte esp+020h]
.13:
        inc ebx
        mov al, byte [dword ecx+LineSortOrder]
        add ecx, byte 4
        mov byte [dword ebx+0ABh], al
        cmp ecx, byte 10h
        jne short .13
        add esp, byte 4Ch
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; SetupAutoLines                                  30BD8  97 PC, low confidence
; From StartGame: rates both rosters and builds their lines (SortByPosition,
; SortForwards, BuildTeamLines)
;-----------------------------------------------------------------------------
SetupAutoLines:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 0E4h
        mov edi, AutoLineData
        xor esi, esi
.1:
        lea eax, [dword edi+0A3h]
        xor edx, edx
        mov dword [dword esp+0D4h], eax
.2:
        movsx ebx, dx
        imul eax, ebx, dword 125h
        add eax, dword [dword esp+0D4h]
        cmp dx, word [dword edi+0A1h]
        jge short .3
        test byte [dword eax+0BEh], 6
        je short .4
.3:
        movsx ebx, si
        imul ebx, byte 32h
        movsx eax, dx
        add eax, eax
        add eax, ebx
        mov ebx, 0FFFFFFFFh
        mov word [byte esp+eax+064h], bx
        mov word [esp+eax], bx
        jmp near .5
.4:
        movsx ebp, si
        imul ebp, byte 32h
        xor ecx, ecx
        mov cl, byte [dword eax+0E7h]
        mov dword [dword esp+0E0h], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0E8h]
        mov dword [dword esp+0DCh], ecx
        mov ecx, dword [dword esp+0E0h]
        add ecx, dword [dword esp+0DCh]
        mov dword [dword esp+0E0h], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0EAh]
        mov dword [dword esp+0DCh], ecx
        mov ecx, dword [dword esp+0E0h]
        add ecx, dword [dword esp+0DCh]
        mov dword [dword esp+0E0h], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0ECh]
        mov dword [dword esp+0DCh], ecx
        mov ecx, dword [dword esp+0E0h]
        add ecx, dword [dword esp+0DCh]
        mov dword [dword esp+0DCh], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0EEh]
        mov dword [dword esp+0E0h], ecx
        mov ecx, dword [dword esp+0DCh]
        add ecx, dword [dword esp+0E0h]
        mov dword [dword esp+0DCh], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0EFh]
        mov dword [dword esp+0E0h], ecx
        mov ecx, dword [dword esp+0DCh]
        add ecx, dword [dword esp+0E0h]
        mov dword [dword esp+0E0h], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0E9h]
        mov dword [dword esp+0DCh], ecx
        mov ecx, dword [dword esp+0E0h]
        add ecx, dword [dword esp+0DCh]
        mov dword [dword esp+0DCh], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0F2h]
        mov dword [dword esp+0E0h], ecx
        mov ecx, dword [dword esp+0DCh]
        add ebx, ebx
        add ecx, dword [dword esp+0E0h]
        add ebx, ebp
        mov word [esp+ebx], cx
        xor ecx, ecx
        mov cl, byte [dword eax+0E7h]
        mov dword [dword esp+0E0h], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0E8h]
        mov dword [dword esp+0DCh], ecx
        mov ecx, dword [dword esp+0E0h]
        add ecx, dword [dword esp+0DCh]
        mov dword [dword esp+0E0h], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0EAh]
        mov dword [dword esp+0DCh], ecx
        mov ecx, dword [dword esp+0E0h]
        add ecx, dword [dword esp+0DCh]
        mov dword [dword esp+0E0h], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0ECh]
        mov dword [dword esp+0DCh], ecx
        mov ecx, dword [dword esp+0E0h]
        add ecx, dword [dword esp+0DCh]
        mov dword [dword esp+0E0h], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0EEh]
        mov dword [dword esp+0DCh], ecx
        mov ecx, dword [dword esp+0E0h]
        add ecx, dword [dword esp+0DCh]
        mov dword [dword esp+0DCh], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0F0h]
        mov dword [dword esp+0E0h], ecx
        mov ecx, dword [dword esp+0DCh]
        add ecx, dword [dword esp+0E0h]
        mov dword [dword esp+0DCh], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0EBh]
        mov dword [dword esp+0E0h], ecx
        mov ecx, dword [dword esp+0DCh]
        add ecx, dword [dword esp+0E0h]
        mov dword [dword esp+0DCh], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0F1h]
        mov dword [dword esp+0E0h], ecx
        mov ecx, dword [dword esp+0DCh]
        add ecx, dword [dword esp+0E0h]
        mov dword [dword esp+0DCh], ecx
        xor ecx, ecx
        mov cl, byte [dword eax+0E9h]
        mov dword [dword esp+0E0h], ecx
        mov ecx, dword [dword esp+0DCh]
        add eax, 0E6h
        add ecx, dword [dword esp+0E0h]
        mov al, byte [byte eax+0Ch]
        xor ah, ah
        add eax, ecx
        mov word [byte esp+ebx+064h], ax
.5:
        inc edx
        cmp dx, byte 19h
        jl near .2
        movsx ebp, si
        imul eax, ebp, byte 32h
        imul ebp, byte 19h
        mov dword [dword esp+0D8h], eax
        mov eax, esp
        mov edx, dword [dword esp+0D8h]
        add edx, eax
        mov ecx, 44h
        mov dword [dword esp+0C8h], edx
        mov eax, edi
        mov edx, DefenseByOffense
        mov ebx, dword [dword esp+0C8h]
        add edx, ebp
        call SortByPosition
        mov edx, RightWingsByOffense
        mov ecx, 52h
        mov ebx, dword [dword esp+0C8h]
        mov eax, edi
        add edx, ebp
        call SortByPosition
        mov edx, LeftWingsByOffense
        mov ecx, 4Ch
        mov ebx, dword [dword esp+0C8h]
        mov eax, edi
        add edx, ebp
        call SortByPosition
        mov edx, CentersByOffense
        mov ecx, 43h
        mov ebx, dword [dword esp+0C8h]
        mov eax, edi
        add edx, ebp
        call SortByPosition
        lea eax, [byte esp+064h]
        mov edx, dword [dword esp+0D8h]
        add edx, eax
        mov ecx, 44h
        mov dword [dword esp+0CCh], edx
        mov eax, edi
        mov edx, DefenseByDefense
        mov ebx, dword [dword esp+0CCh]
        add edx, ebp
        call SortByPosition
        mov edx, RightWingsByDefense
        mov ecx, 52h
        mov ebx, dword [dword esp+0CCh]
        mov eax, edi
        add edx, ebp
        call SortByPosition
        mov edx, LeftWingsByDefense
        mov ecx, 4Ch
        mov ebx, dword [dword esp+0CCh]
        mov eax, edi
        add edx, ebp
        call SortByPosition
        mov edx, CentersByDefense
        mov ecx, 43h
        mov ebx, dword [dword esp+0CCh]
        mov eax, edi
        add edx, ebp
        call SortByPosition
        mov edx, ForwardsByOffense
        mov ebx, dword [dword esp+0C8h]
        mov eax, edi
        add edx, ebp
        call SortForwards
        mov edx, ForwardsByDefense
        mov ebx, dword [dword esp+0CCh]
        mov eax, edi
        add edx, ebp
        call SortForwards
        test si, si
        je short .6
        mov eax, awtmstruct
        jmp short .7
.6:
        mov eax, hmtmstruct
.7:
        mov dword [dword esp+0D0h], eax
        xor edx, edx
.8:
        movsx ebx, dx
        mov ebp, dword [dword esp+0D0h]
        lea eax, [nosplit ebx*2+00h]
        add eax, ebp
        mov eax, dword [byte eax+04Eh]
        sar eax, 10h
        call PositionSlot
        movzx ebp, al
        movsx eax, si
        imul eax, byte 19h
        add ebx, eax
        mov al, byte [dword ebp+LineSlotPositions]
        inc edx
        mov byte [dword ebx+LineSlotTaken], al
        cmp dx, byte 19h
        jl short .8
        movsx ebp, si
        lea eax, [dword edi+020EDh]
        xor edx, edx
.9:
        imul ebx, ebp, byte 19h
        xor ecx, ecx
        mov cl, byte [eax]
        inc eax
        add ebx, ecx
        xor ch, ch
        inc edx
        mov byte [dword ebx+LineSlotTaken], ch
        cmp dx, byte 12h
        jl short .9
        imul ebx, ebp, byte 32h
        lea ecx, [byte esp+064h]
        mov eax, esp
        mov edx, edi
        inc esi
        add ecx, ebx
        add ebx, eax
        mov eax, ebp
        mov edi, homelines
        call BuildTeamLines
        cmp si, byte 2
        jl near .1
        add esp, 0E4h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CanPlayLineSlot                                 31070  97 PC, low confidence
; Whether a player may take a line slot (position class table LineSlotPositions,
; availability LineSlotTaken)
;-----------------------------------------------------------------------------
CanPlayLineSlot:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov word [byte esp+0Ch], ax
        mov ecx, edx
        mov esi, ebx
        test ax, ax
        je short .1
        mov edx, awtmstruct
        jmp short .2
.1:
        mov edx, hmtmstruct
.2:
        movsx ebx, si
        mov dword [esp], edx
        mov eax, dword [byte edx+ebx*2+04Eh]
        mov edi, dword [dword edx+0108h]
        sar eax, 10h
        add edi, 20EDh
        call PositionSlot
        and eax, 0FFh
        mov al, byte [dword eax+LineSlotPositions]
        xor ah, ah
        test ax, ax
        jne short .3
        xor edx, edx
        jmp near .41
.3:
        cmp ax, 2
        jne short .4
        mov ebp, dword [byte esp+0Ah]
        sar ebp, 10h
        lea edx, [nosplit ebp*4+00h]
        sub edx, ebp
        shl edx, 3
        add edx, ebp
        cmp byte [dword edx+ebx+LineSlotTaken], 2
        je short .4
        xor edx, edx
        mov eax, edx
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.4:
        movsx edx, si
        imul edx, dword 125h
        mov eax, dword [esp]
        mov eax, dword [dword eax+0108h]
        mov al, byte [dword edx+eax+0160h]
        xor ah, ah
        cmp cx, byte 0Ch
        jge near .9
        xor ebx, ebx
        mov dword [byte esp+018h], ebx
.5:
        movsx edx, bx
        mov ebp, 3
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        mov ebp, edx
        movsx edx, cx
        mov dword [byte esp+04h], 3
        mov eax, edx
        sar edx, 1Fh
        idiv dword [byte esp+04h]
        cmp ebp, edx
        jne short .6
        cmp bx, cx
        jge short .7
.6:
        movsx edx, bx
        mov dl, byte [edx+edi]
        xor dh, dh
        cmp dx, si
        jne short .7
        inc dword [byte esp+018h]
.7:
        inc ebx
        cmp bx, byte 0Ch
        jl short .5
        cmp word [byte esp+018h], byte 2
        jl short .8
        cmp word [LineBuildLine], byte 6
        jle short .8
        xor edx, edx
        mov eax, edx
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.8:
        movsx edx, cx
        mov ebx, 3
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        lea edx, [nosplit eax*4+00h]
        sub edx, eax
        mov eax, edx
        add eax, 2
        mov dword [byte esp+08h], edx
        mov dword [byte esp+010h], eax
        jmp near .33
.9:
        cmp cx, byte 12h
        jge near .14
        cmp word [LineBuildSlot], byte 3
        jl short .13
        xor edx, edx
        mov ebx, 0Ch
        mov dword [byte esp+014h], edx
.10:
        movsx edx, bx
        mov ebp, 2
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        mov ebp, edx
        movsx edx, cx
        mov dword [byte esp+04h], 2
        mov eax, edx
        sar edx, 1Fh
        idiv dword [byte esp+04h]
        cmp ebp, edx
        jne short .11
        cmp bx, cx
        jge short .12
.11:
        movsx edx, bx
        mov dl, byte [edx+edi]
        xor dh, dh
        cmp dx, si
        jne short .12
        inc dword [byte esp+014h]
.12:
        inc ebx
        cmp bx, byte 12h
        jl short .10
        cmp word [byte esp+014h], byte 2
        jl short .13
        xor edx, edx
        mov eax, edx
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.13:
        mov eax, ecx
        and al, 0FEh
        mov dword [byte esp+08h], eax
        inc eax
        mov dword [byte esp+010h], eax
        jmp near .33
.14:
        cmp cx, byte 1Ch
        jge short .20
        cmp ax, 44h
        jne short .15
        cmp word [LineBuildSlot], byte 4
        jl short .16
.15:
        cmp ax, 44h
        je short .19
        cmp word [LineBuildLine], byte 6
        jge short .19
.16:
        cmp cx, byte 17h
        jge short .17
        mov eax, 12h
        jmp short .18
.17:
        mov eax, 17h
.18:
        mov dword [byte esp+08h], eax
        add eax, 4
        mov dword [byte esp+010h], eax
        jmp near .33
.19:
        mov ebx, 1Bh
        mov edx, 12h
        mov dword [byte esp+010h], ebx
        mov dword [byte esp+08h], edx
        jmp near .33
.20:
        cmp cx, byte 24h
        jge short .24
        cmp ax, 44h
        jne short .23
        cmp word [LineBuildSlot], byte 4
        jge short .23
        cmp cx, byte 20h
        jge short .21
        mov eax, 1Ch
        jmp short .22
.21:
        mov eax, 20h
.22:
        mov dword [byte esp+08h], eax
        add eax, 3
        mov dword [byte esp+010h], eax
        jmp near .33
.23:
        mov edx, 23h
        mov eax, 1Ch
        jmp near .32
.24:
        cmp cx, byte 2Eh
        jge short .28
        cmp ax, 44h
        jne short .27
        cmp word [LineBuildSlot], byte 4
        jge short .27
        cmp cx, byte 2Ah
        jge short .25
        mov eax, 26h
        jmp short .26
.25:
        mov eax, 2Ah
.26:
        mov dword [byte esp+08h], eax
        add eax, 3
        mov dword [byte esp+010h], eax
        jmp short .33
.27:
        mov edx, 2Dh
        mov eax, 26h
        jmp short .32
.28:
        cmp cx, byte 34h
        jge short .33
        cmp ax, 44h
        jne short .31
        cmp word [LineBuildSlot], byte 4
        jge short .31
        cmp cx, byte 31h
        jge short .29
        mov eax, 2Eh
        jmp short .30
.29:
        mov eax, 31h
.30:
        mov dword [byte esp+08h], eax
        add eax, 2
        mov dword [byte esp+010h], eax
        jmp short .33
.31:
        mov edx, 33h
        mov eax, 2Eh
.32:
        mov dword [byte esp+010h], edx
        mov dword [byte esp+08h], eax
.33:
        mov ebx, dword [byte esp+010h]
        mov eax, dword [byte esp+08h]
        cmp ax, bx
        jg near .40
.34:
        cmp ax, cx
        je short .39
        cmp cx, byte 2Eh
        jl short .35
        movsx edx, cx
        movsx ebp, ax
        add edx, byte 3
        jmp short .37
.35:
        cmp cx, byte 1Ch
        jl short .36
        movsx edx, cx
        movsx ebp, ax
        add edx, byte 4
        jmp short .37
.36:
        cmp cx, byte 12h
        jl short .38
        movsx edx, cx
        movsx ebp, ax
        add edx, byte 5
.37:
        cmp ebp, edx
        je short .39
.38:
        movsx edx, ax
        mov dl, byte [edx+edi]
        xor dh, dh
        cmp dx, si
        jne short .39
        xor dl, dl
        mov eax, edx
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.39:
        mov edx, dword [byte esp+010h]
        inc eax
        cmp ax, dx
        jle short .34
.40:
        mov edx, 1
.41:
        mov eax, edx
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FindLinePlayer                                  313F4  97 PC, low confidence
; First player of a list who can play a slot (CanPlayLineSlot)
;-----------------------------------------------------------------------------
FindLinePlayer:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov dword [byte esp+04h], eax
        mov word [byte esp+0Ch], dx
        mov word [byte esp+010h], bx
        test dx, dx
        je short .1
        mov eax, awtmstruct
        jmp near .2
.1:
        mov eax, hmtmstruct
.2:
        mov dword [esp], eax
        mov eax, dword [dword eax+0108h]
        xor esi, esi
        mov dword [byte esp+08h], eax
.3:
        mov edx, dword [byte esp+04h]
        movsx eax, si
        add eax, edx
        movsx di, byte [eax]
        test di, di
        jge short .4
        mov eax, 0FFFFFFFFh
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.4:
        mov eax, dword [byte esp+0Ah]
        sar eax, 10h
        imul ebp, eax, byte 19h
        movsx ecx, di
        add ebp, ecx
        cmp byte [dword ebp+LineSlotTaken], 0
        je near .8
        mov edx, dword [byte esp+0Eh]
        mov ebx, ecx
        sar edx, 10h
        call CanPlayLineSlot
        test ax, ax
        je near .8
        cmp byte [dword ebp+LineSlotTaken], 2
        jne near .7
        cmp word [LineBuildPlayer], byte 12h
        jge near .8
        imul eax, ecx, dword 125h
        add eax, dword [byte esp+08h]
        cmp byte [dword eax+0160h], 44h
        je short .5
        cmp word [LineBuildLine], byte 0Ch
        jge short .8
.5:
        movsx ecx, di
        mov esi, dword [esp]
        lea eax, [nosplit ecx*2+00h]
        mov edx, dword [byte esp+0Ah]
        add eax, esi
        sar edx, 10h
        mov word [byte eax+050h], 8002h
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        mov byte [dword ecx+eax+LineSlotTaken], 1
        imul ecx, dword 125h
        mov si, word [LineBuildPlayer]
        mov ebp, dword [byte esp+08h]
        inc esi
        add ecx, ebp
        mov word [LineBuildPlayer], si
        cmp byte [dword ecx+0160h], 44h
        jne short .6
        inc word [LineBuildSlot]
        jmp short .7
.6:
        inc word [LineBuildLine]
.7:
        mov eax, edi
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.8:
        inc esi
        cmp si, byte 19h
        jl near .3
        mov eax, 0FFFFFFFFh
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PickLineReplacement                             31540  97 PC, low confidence
; Picks a replacement for a line slot from the position order lists
; (lineslotgroups, lineslotgroupstart)
;-----------------------------------------------------------------------------
PickLineReplacement:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov edi, eax
        mov ecx, edx
        test ax, ax
        je short .1
        mov eax, awtmstruct
        jmp short .2
.1:
        mov eax, hmtmstruct
.2:
        mov dword [esp], eax
        mov ebp, dword [dword eax+0108h]
        movsx eax, cx
        add ebp, 20EDh
        mov al, byte [dword eax+lineslotgroupstart]
        xor ah, ah
        mov dword [byte esp+014h], eax
        mov esi, eax
.3:
        movsx eax, si
        movsx ax, byte [dword eax+lineslotgroups]
        cmp ax, cx
        je short .4
        inc esi
        jmp short .3
.4:
        inc esi
        movsx eax, si
        cmp byte [dword eax+lineslotgroups], 0
        jl short .5
        mov eax, dword [dword eax+LineReplaceOrder]
        sar eax, 18h
        xor edx, edx
        mov dl, byte [eax+ebp]
        xor ebx, ebx
        mov dword [byte esp+010h], edx
        mov bl, dl
        movsx eax, di
        movsx edx, cx
        call CanPlayLineSlot
        test ax, ax
        je short .4
        mov eax, dword [byte esp+010h]
        jmp near .47
.5:
        movsx eax, cx
        mov dl, byte [eax+ebp]
        and edx, 0FFh
        imul edx, dword 125h
        mov ebx, dword [esp]
        mov ebx, dword [dword ebx+0108h]
        mov dl, byte [dword edx+ebx+0160h]
        xor dh, dh
        mov dword [byte esp+08h], edx
        cmp dx, byte 44h
        jne short .8
        movsx esi, di
        mov ebx, eax
        cmp cx, byte 12h
        jl short .6
        cmp cx, byte 23h
        jg short .6
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 3
        add eax, esi
        add eax, DefenseByOffense
        jmp short .7
.6:
        movsx edx, di
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        add eax, DefenseByDefense
.7:
        mov edx, esi
        call FindLinePlayer
        test ax, ax
        jl near .29
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.8:
        cmp dx, byte 43h
        jne near .15
        movsx esi, di
        mov ebx, eax
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 3
        add eax, esi
        cmp cx, byte 26h
        jge short .9
        add eax, CentersByOffense
        jmp short .10
.9:
        add eax, CentersByDefense
.10:
        mov edx, esi
        call FindLinePlayer
        test ax, ax
        jge near .47
        movsx esi, di
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 3
        movsx ebx, cx
        add eax, esi
        cmp cx, byte 26h
        jge short .11
        add eax, LeftWingsByOffense
        jmp short .12
.11:
        add eax, LeftWingsByDefense
.12:
        mov edx, esi
        call FindLinePlayer
        test ax, ax
        jge near .47
        movsx esi, di
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 3
        movsx ebx, cx
        add eax, esi
        cmp cx, byte 26h
        jge short .13
        add eax, RightWingsByOffense
        jmp short .14
.13:
        add eax, RightWingsByDefense
.14:
        mov edx, esi
        call FindLinePlayer
        test ax, ax
        jl near .29
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.15:
        cmp dx, byte 52h
        jne near .22
        movsx edx, di
        mov esi, eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        cmp cx, byte 26h
        jge short .16
        add eax, RightWingsByOffense
        jmp short .17
.16:
        add eax, RightWingsByDefense
.17:
        mov ebx, esi
        call FindLinePlayer
        test ax, ax
        jge near .47
        movsx edx, di
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        movsx esi, cx
        add eax, edx
        cmp cx, byte 26h
        jge short .18
        add eax, LeftWingsByOffense
        jmp short .19
.18:
        add eax, LeftWingsByDefense
.19:
        mov ebx, esi
        call FindLinePlayer
        test ax, ax
        jge near .47
        movsx edx, di
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        movsx esi, cx
        add eax, edx
        cmp cx, byte 26h
        jge short .20
        add eax, CentersByOffense
        jmp short .21
.20:
        add eax, CentersByDefense
.21:
        mov ebx, esi
        call FindLinePlayer
        test ax, ax
        jl near .29
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.22:
        cmp dx, byte 4Ch
        jne near .29
        movsx edx, di
        mov esi, eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        cmp cx, byte 26h
        jge short .23
        add eax, LeftWingsByOffense
        jmp short .24
.23:
        add eax, LeftWingsByDefense
.24:
        mov ebx, esi
        call FindLinePlayer
        test ax, ax
        jge near .47
        movsx esi, di
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 3
        movsx ebx, cx
        add eax, esi
        cmp cx, byte 26h
        jge short .25
        add eax, RightWingsByOffense
        jmp short .26
.25:
        add eax, RightWingsByDefense
.26:
        mov edx, esi
        call FindLinePlayer
        test ax, ax
        jge near .47
        movsx edx, di
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        movsx esi, cx
        add eax, edx
        cmp cx, byte 26h
        jge short .27
        add eax, CentersByOffense
        jmp short .28
.27:
        add eax, CentersByDefense
.28:
        mov ebx, esi
        call FindLinePlayer
        test ax, ax
        jge near .47
.29:
        mov esi, dword [byte esp+014h]
.30:
        movsx eax, si
        movsx dx, byte [dword eax+lineslotgroups]
        cmp dx, cx
        je short .32
        mov eax, dword [dword eax+LineReplaceOrder]
        sar eax, 18h
        xor edx, edx
        mov dl, byte [eax+ebp]
        xor ebx, ebx
        mov dword [byte esp+0Ch], edx
        mov bl, dl
        movsx eax, di
        movsx edx, cx
        call CanPlayLineSlot
        test ax, ax
        je short .31
        mov eax, dword [byte esp+0Ch]
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.31:
        inc esi
        jmp short .30
.32:
        cmp word [byte esp+08h], byte 44h
        jne short .34
        cmp cx, byte 12h
        jl short .33
        cmp cx, byte 23h
        jg short .33
        movsx edx, di
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        add eax, DefenseByOffense
        jmp short .36
.33:
        movsx edx, di
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        add eax, DefenseByDefense
        jmp short .36
.34:
        cmp cx, byte 26h
        jge short .35
        movsx edx, di
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        add eax, ForwardsByOffense
        jmp short .36
.35:
        movsx edx, di
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        add eax, ForwardsByDefense
.36:
        mov ebp, eax
        xor esi, esi
.37:
        movsx eax, si
        movsx ax, byte [eax+ebp]
        mov word [byte esp+018h], ax
        test ax, ax
        jl short .39
        mov ebx, dword [byte esp+016h]
        movsx edx, cx
        movsx eax, di
        sar ebx, 10h
        call CanPlayLineSlot
        test ax, ax
        je short .38
        mov eax, dword [byte esp+018h]
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.38:
        inc esi
        cmp si, byte 19h
        jl short .37
.39:
        cmp word [byte esp+08h], byte 44h
        jne short .41
        cmp cx, byte 12h
        jl short .40
        cmp cx, byte 23h
        jg short .40
        movsx edx, di
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        add eax, ForwardsByOffense
        jmp short .43
.40:
        movsx edx, di
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        add eax, ForwardsByDefense
        jmp short .43
.41:
        cmp cx, byte 26h
        jge short .42
        movsx edx, di
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        add eax, DefenseByOffense
        jmp short .43
.42:
        movsx edx, di
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        add eax, DefenseByDefense
.43:
        mov ebp, eax
        xor esi, esi
.44:
        movsx eax, si
        movsx ax, byte [eax+ebp]
        mov word [byte esp+04h], ax
        test ax, ax
        jl short .46
        mov ebx, dword [byte esp+02h]
        movsx edx, cx
        movsx eax, di
        sar ebx, 10h
        call CanPlayLineSlot
        test ax, ax
        je short .45
        mov eax, dword [byte esp+04h]
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.45:
        inc esi
        cmp si, byte 19h
        jl short .44
.46:
        xor eax, eax
.47:
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CopyGoalieSlot                                  31A2C  97 PC, low confidence
; Copies the starting / backup goalie line byte (+34h / +35h) over the other
;-----------------------------------------------------------------------------
CopyGoalieSlot:
        test ax, ax
        je short .1
        mov eax, awtmstruct
        jmp short .2
.1:
        mov eax, hmtmstruct
.2:
        mov eax, dword [dword eax+0108h]
        add eax, 20EDh
        cmp dx, byte 34h
        jne short .3
        mov dl, byte [byte eax+035h]
        mov byte [byte eax+034h], dl
        ret
.3:
        mov dl, byte [byte eax+034h]
        mov byte [byte eax+035h], dl
        ret
;-----------------------------------------------------------------------------
; FixLineSlot                                     31A5C  97 PC, low confidence
; Repairs a line slot after a change (slot 24h special case), PositionSlot
; checks
;-----------------------------------------------------------------------------
FixLineSlot:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov word [esp], ax
        test ax, ax
        je short .1
        mov esi, awtmstruct
        jmp short .2
.1:
        mov esi, hmtmstruct
.2:
        mov ebp, dword [byte esp-02h]
        sar ebp, 10h
        lea eax, [nosplit ebp*4+00h]
        sub eax, ebp
        mov ecx, esi
        shl eax, 3
        mov edi, dword [dword esi+0108h]
        add eax, ebp
        mov ebp, ForwardsByOffense
        add edi, 20EDh
        add ebp, eax
        cmp dx, byte 24h
        jne short .6
        xor edx, edx
        xor eax, eax
        mov dl, byte [byte edi+025h]
        mov al, dl
        mov eax, dword [byte esi+eax*2+04Eh]
        sar eax, 10h
        call PositionSlot
        and eax, 0FFh
        cmp byte [dword eax+LineSlotPositions], 1
        jne short .3
        mov byte [byte edi+025h], dl
        jmp short .6
.3:
        xor ebx, ebx
.4:
        movsx eax, bx
        movsx dx, byte [eax+ebp]
        test dx, dx
        jl short .6
        movsx eax, dx
        mov eax, dword [byte ecx+eax*2+04Eh]
        sar eax, 10h
        call PositionSlot
        movzx esi, al
        cmp byte [dword esi+LineSlotPositions], 1
        jne short .5
        mov byte [byte edi+024h], dl
        jmp short .6
.5:
        inc ebx
        cmp bx, byte 19h
        jl short .4
.6:
        mov esi, dword [byte esp-02h]
        sar esi, 10h
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 3
        mov ebp, ForwardsByOffense
        add eax, esi
        xor ebx, ebx
        add ebp, eax
.7:
        movsx eax, bx
        movsx dx, byte [eax+ebp]
        test dx, dx
        jl short .9
        movsx eax, dx
        mov eax, dword [byte ecx+eax*2+04Eh]
        sar eax, 10h
        call PositionSlot
        movzx esi, al
        cmp byte [dword esi+LineSlotPositions], 1
        jne short .8
        xor eax, eax
        mov al, byte [byte edi+024h]
        cmp dx, ax
        je short .8
        mov byte [byte edi+025h], dl
        jmp short .9
.8:
        inc ebx
        cmp bx, byte 19h
        jl short .7
.9:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; RebuildLines                                    31B6C  97 PC, low confidence
; Refills a team's line slots from a start index (PickLineReplacement),
; availability table LineSlotTaken
;-----------------------------------------------------------------------------
RebuildLines:
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov word [byte esp+04h], ax
        mov esi, edx
        mov edi, ebx
        mov dword [esp], ecx
        test ax, ax
        je short .1
        mov ebx, dword [AwScore]
        jmp short .2
.1:
        mov ebx, dword [HmScore]
.2:
        add ebx, 20EDh
        movsx eax, si
        mov ebp, ebx
        mov al, byte [ebx+eax]
        mov ecx, dword [byte esp+02h]
        sar ecx, 10h
        lea ebx, [nosplit ecx*4+00h]
        sub ebx, ecx
        shl ebx, 3
        and eax, 0FFh
        add ebx, ecx
        xor dl, dl
        mov byte [dword ebx+eax+LineSlotTaken], dl
        cmp di, word [esp]
        jge short .5
.3:
        mov ebx, dword [byte esp+02h]
        movsx ecx, si
        sar ebx, 10h
        mov edx, ecx
        mov eax, ebx
        add ecx, ebp
        call PickLineReplacement
        mov byte [ecx], al
        cmp si, byte 12h
        jge short .4
        mov cl, al
        imul ebx, byte 19h
        and ecx, 0FFh
        xor dh, dh
        mov byte [dword ecx+ebx+LineSlotTaken], dh
.4:
        mov ecx, dword [byte esp+018h]
        mov eax, dword [esp]
        inc edi
        add esi, ecx
        cmp di, ax
        jl short .3
.5:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; UpdateLinesForAbsent                            31C14  97 PC, low confidence
; Recounts the available players and rebuilds the lines when a player leaves
; (penalty, injury, ice exit)
;-----------------------------------------------------------------------------
UpdateLinesForAbsent:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 38h
        mov word [byte esp+08h], ax
        mov word [byte esp+030h], dx
        test ax, ax
        je short .1
        mov eax, awtmstruct
        jmp short .2
.1:
        mov eax, hmtmstruct
.2:
        mov edx, dword [byte esp+02Eh]
        sar edx, 10h
        imul edx, dword 125h
        mov ebx, eax
        mov eax, dword [dword eax+0108h]
        mov cl, byte [dword edx+eax+0160h]
        lea edi, [dword eax+020EDh]
        cmp cl, 44h
        jne short .5
        xor esi, esi
        xor edx, edx
        mov word [LineBuildSlot], si
.3:
        mov eax, dword [byte esp+06h]
        sar eax, 10h
        imul ecx, eax, byte 19h
        movsx eax, dx
        movsx ax, byte [dword ecx+eax+DefenseByDefense]
        test ax, ax
        jl near .8
        cwde
        mov eax, dword [byte ebx+eax*2+04Eh]
        sar eax, 10h
        call PositionSlot
        and eax, 0FFh
        cmp byte [dword eax+LineSlotPositions], 1
        jne short .4
        inc word [LineBuildSlot]
.4:
        inc edx
        cmp dx, byte 19h
        jl short .3
        jmp short .8
.5:
        xor ecx, ecx
        xor edx, edx
        mov word [LineBuildLine], cx
.6:
        mov eax, dword [byte esp+06h]
        sar eax, 10h
        imul ecx, eax, byte 19h
        movsx eax, dx
        movsx ax, byte [dword ecx+eax+ForwardsByOffense]
        test ax, ax
        jl short .8
        cwde
        mov eax, dword [byte ebx+eax*2+04Eh]
        sar eax, 10h
        call PositionSlot
        and eax, 0FFh
        cmp byte [dword eax+LineSlotPositions], 1
        jne short .7
        inc word [LineBuildLine]
.7:
        inc edx
        cmp dx, byte 19h
        jl short .6
.8:
        xor esi, esi
        mov word [byte esp+010h], si
        mov ebp, 3
.9:
        xor edx, edx
        mov dword [byte esp+024h], edx
.10:
        xor eax, eax
        mov ebx, dword [byte esp+030h]
        mov al, byte [edi]
        inc edi
        cmp ax, bx
        jne short .11
        push byte 3
        mov ebx, dword [byte esp+012h]
        mov eax, dword [byte esp+0Ah]
        mov ecx, 4
        movsx edx, si
        sar ebx, 10h
        sar eax, 10h
        call RebuildLines
.11:
        mov ecx, dword [byte esp+024h]
        inc ecx
        inc esi
        mov dword [byte esp+024h], ecx
        cmp cx, byte 3
        jl short .10
        mov edx, dword [byte esp+010h]
        inc edx
        mov word [byte esp+010h], dx
        cmp dx, byte 4
        jl short .9
        xor ecx, ecx
        mov word [byte esp+034h], cx
        mov ebp, 2
.12:
        xor eax, eax
        mov dword [byte esp+028h], eax
.13:
        xor eax, eax
        mov edx, dword [byte esp+030h]
        mov al, byte [edi]
        inc edi
        cmp ax, dx
        jne short .14
        push byte 2
        mov ebx, dword [byte esp+036h]
        mov eax, dword [byte esp+0Ah]
        mov ecx, 3
        movsx edx, si
        sar ebx, 10h
        sar eax, 10h
        call RebuildLines
.14:
        mov ebx, dword [byte esp+028h]
        inc ebx
        inc esi
        mov dword [byte esp+028h], ebx
        cmp bx, byte 2
        jl short .13
        mov eax, dword [byte esp+034h]
        inc eax
        mov word [byte esp+034h], ax
        cmp ax, 3
        jl short .12
        xor ebx, ebx
        mov ebp, 5
        mov word [byte esp+0Ch], bx
.15:
        xor ecx, ecx
        mov dword [esp], ecx
.16:
        xor eax, eax
        mov edx, dword [byte esp+030h]
        mov al, byte [edi]
        inc edi
        cmp ax, dx
        jne short .17
        push byte 5
        mov ebx, dword [byte esp+0Eh]
        mov eax, dword [byte esp+0Ah]
        mov ecx, 2
        movsx edx, si
        sar ebx, 10h
        sar eax, 10h
        call RebuildLines
.17:
        mov ebx, dword [esp]
        inc ebx
        inc esi
        mov dword [esp], ebx
        cmp bx, byte 5
        jl short .16
        mov eax, dword [byte esp+0Ch]
        inc eax
        mov word [byte esp+0Ch], ax
        cmp ax, 2
        jl short .15
        xor ebx, ebx
        mov ebp, 4
        mov word [byte esp+014h], bx
.18:
        xor ecx, ecx
        mov dword [byte esp+02Ch], ecx
.19:
        xor eax, eax
        mov edx, dword [byte esp+030h]
        mov al, byte [edi]
        inc edi
        cmp ax, dx
        jne short .20
        push byte 4
        mov ebx, dword [byte esp+016h]
        mov eax, dword [byte esp+0Ah]
        mov ecx, 2
        movsx edx, si
        sar ebx, 10h
        sar eax, 10h
        call RebuildLines
.20:
        mov ebx, dword [byte esp+02Ch]
        inc ebx
        inc esi
        mov dword [byte esp+02Ch], ebx
        cmp bx, byte 4
        jl short .19
        mov eax, dword [byte esp+014h]
        inc eax
        mov word [byte esp+014h], ax
        cmp ax, 2
        jl short .18
        mov ecx, dword [byte esp+030h]
        xor ebx, ebx
.21:
        xor eax, eax
        mov al, byte [edi]
        inc edi
        cmp ax, cx
        jne short .22
        mov eax, dword [byte esp+06h]
        movsx edx, si
        sar eax, 10h
        call FixLineSlot
.22:
        inc ebx
        inc esi
        cmp bx, byte 2
        jl short .21
        xor eax, eax
        mov ebp, 4
        mov word [byte esp+04h], ax
.23:
        xor edx, edx
        mov dword [byte esp+020h], edx
.24:
        xor eax, eax
        mov ebx, dword [byte esp+030h]
        mov al, byte [edi]
        inc edi
        cmp ax, bx
        jne short .25
        push byte 4
        mov ebx, dword [byte esp+06h]
        mov eax, dword [byte esp+0Ah]
        mov ecx, 2
        movsx edx, si
        sar ebx, 10h
        sar eax, 10h
        call RebuildLines
.25:
        mov ecx, dword [byte esp+020h]
        inc ecx
        inc esi
        mov dword [byte esp+020h], ecx
        cmp cx, byte 4
        jl short .24
        mov edx, dword [byte esp+04h]
        inc edx
        mov word [byte esp+04h], dx
        cmp dx, byte 2
        jl short .23
        xor ecx, ecx
        mov ebp, 3
        mov word [byte esp+018h], cx
.26:
        xor eax, eax
        mov dword [byte esp+01Ch], eax
.27:
        xor eax, eax
        mov edx, dword [byte esp+030h]
        mov al, byte [edi]
        inc edi
        cmp ax, dx
        jne short .28
        push byte 3
        mov ebx, dword [byte esp+01Ah]
        mov eax, dword [byte esp+0Ah]
        mov ecx, 2
        movsx edx, si
        sar ebx, 10h
        sar eax, 10h
        call RebuildLines
.28:
        mov ebx, dword [byte esp+01Ch]
        inc ebx
        inc esi
        mov dword [byte esp+01Ch], ebx
        cmp bx, byte 3
        jl short .27
        mov eax, dword [byte esp+018h]
        inc eax
        mov word [byte esp+018h], ax
        cmp ax, 2
        jl short .26
        xor ecx, ecx
        xor ebp, ebp
.29:
        xor eax, eax
        mov ebx, dword [byte esp+030h]
        mov al, byte [edi]
        inc edi
        cmp ax, bx
        jne short .30
        mov eax, dword [byte esp+06h]
        movsx edx, si
        mov ebx, ebp
        sar eax, 10h
        call CopyGoalieSlot
.30:
        inc ecx
        inc esi
        cmp cx, byte 2
        jl short .29
        add esp, byte 38h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; InitGameLines                                   31F88  97 PC, low confidence
; From StartGame: counts the available players per team and fills the lines
;-----------------------------------------------------------------------------
InitGameLines:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ecx, eax
        test ax, ax
        je short .1
        mov eax, awtmstruct
        jmp short .2
.1:
        mov eax, hmtmstruct
.2:
        mov esi, eax
        mov edi, dword [dword eax+0108h]
        xor edx, edx
        xor ebx, ebx
        add edi, 20EDh
        mov word [LineBuildSlot], dx
.3:
        movsx eax, cx
        imul eax, byte 19h
        movsx edx, bx
        movsx ax, byte [dword edx+eax+DefenseByDefense]
        test ax, ax
        jl short .5
        cwde
        mov eax, dword [byte esi+eax*2+04Eh]
        sar eax, 10h
        call PositionSlot
        and eax, 0FFh
        cmp byte [dword eax+LineSlotPositions], 1
        jne short .4
        inc word [LineBuildSlot]
.4:
        inc ebx
        cmp bx, byte 19h
        jl short .3
.5:
        xor edx, edx
        xor ebx, ebx
        mov word [LineBuildLine], dx
.6:
        movsx eax, cx
        imul edx, eax, byte 19h
        movsx eax, bx
        movsx ax, byte [dword edx+eax+ForwardsByOffense]
        test ax, ax
        jl short .8
        cwde
        mov eax, dword [byte esi+eax*2+04Eh]
        sar eax, 10h
        call PositionSlot
        and eax, 0FFh
        cmp byte [dword eax+LineSlotPositions], 1
        jne short .7
        inc word [LineBuildLine]
.7:
        inc ebx
        cmp bx, byte 19h
        jl short .6
.8:
        mov dx, word [LineBuildSlot]
        mov ax, word [LineBuildLine]
        add eax, edx
        xor ebx, ebx
        mov word [LineBuildPlayer], ax
.9:
        movsx eax, bx
        xor edx, edx
        inc ebx
        mov dword [nosplit eax*4+LineSortKeys], edx
        cmp bx, byte 19h
        jl short .9
        mov ebp, 1
        xor ebx, ebx
.10:
        movsx eax, bx
        mov al, byte [edi+eax]
        and eax, 0FFh
        inc ebx
        mov dword [nosplit eax*4+LineSortKeys], ebp
        cmp bx, byte 24h
        jl short .10
        xor ebx, ebx
        xor edi, edi
.11:
        movsx edx, bx
        mov eax, dword [byte esi+edx*2+04Eh]
        sar eax, 10h
        call PositionSlot
        mov ebp, dword [nosplit edx*4+LineSortKeys]
        xor ah, ah
        cmp edi, ebp
        je short .13
        test ax, ax
        je short .12
        cmp ax, 1
        jne short .13
.12:
        movsx edx, bx
        movsx eax, cx
        call UpdateLinesForAbsent
.13:
        inc ebx
        cmp bx, byte 19h
        jl short .11
        mov ebx, 24h
        xor edi, edi
        mov word [esp], bx
.14:
        movsx eax, di
        mov eax, dword [dword esi+eax*2+080h]
        sar eax, 10h
        call PositionSlot
        xor ah, ah
        test ax, ax
        je short .15
        cmp ax, 1
        jne short .16
.15:
        mov edx, dword [byte esp-02h]
        mov ebx, 1
        movsx eax, cx
        sar edx, 10h
        call CopyGoalieSlot
.16:
        mov eax, dword [esp]
        inc eax
        inc edi
        mov word [esp], ax
        cmp di, byte 2
        jl short .14
        xor ebx, ebx
.17:
        movsx eax, cx
        imul eax, byte 19h
        movsx edx, bx
        add eax, edx
        cmp byte [dword eax+LineSlotTaken], 1
        sete dl
        inc ebx
        mov byte [dword eax+LineSlotTaken], dl
        cmp bx, byte 19h
        jl short .17
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        xor edx, edx
.18:
        movsx eax, dx
        cmp byte [dword eax+LineSlotTaken], 1
        sete bl
        mov cl, byte [dword eax+LineSlotStart]
        mov byte [dword eax+LineSlotTaken], bl
        cmp cl, 1
        sete bl
        inc edx
        mov byte [dword eax+LineSlotStart], bl
        cmp dx, byte 19h
        jl short .18
        pop edx
        pop ecx
        pop ebx
        ret
