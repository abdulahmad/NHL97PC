; Bench and penalty box seats.
bits 32
%include "hockey.inc"
section s_39CDF progbits alloc exec nowrite align=1
extern AddSeatModel, BenchSeats, BenchSlotTable, BoxSeatFlags, BoxSeatPlayer, BoxSeats, BoxSeatSlot, BoxSeatTeam
extern FindSeatModel, GetSeatPos, SeatTable, SortCords
global FindBenchSlot, GetSeatPosition, PickBoxSeat, FreeBoxSeat, PickBenchSeat, MoveBoxToBenchSeat
        db 00h
;-----------------------------------------------------------------------------
; FindBenchSlot                                   39CE0  97 PC, low confidence
; Returns the bench or penalty box seat a player has on his team's list, -1
; if none
;-----------------------------------------------------------------------------
FindBenchSlot:
        push ebx
        push ecx
        push esi
        mov ecx, eax
        mov esi, edx
        test edx, edx
        jl short .3
        mov edx, ecx
        xor eax, eax
        shl edx, 7
        jmp short .2
.1:
        mov ebx, dword [dword edx+BoxSeatFlags]
        sar ebx, 18h
        cmp ebx, esi
        je short .4
        inc eax
        add edx, byte 4
.2:
        mov ebx, dword [dword ecx+BenchSlotTable]
        sar ebx, 18h
        cmp eax, ebx
        jl short .1
.3:
        mov eax, 0FFFFFFFFh
.4:
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; GetSeatPosition                                 39D1C  97 PC, low confidence
; Fills a vector with the rink position of a bench or box seat
;-----------------------------------------------------------------------------
GetSeatPosition:
        push ecx
        sub esp, byte 8
        mov ecx, edx
        call GetSeatPos
        fild dword [eax]
        fstp dword [ebx]
        fild dword [byte eax+04h]
        fstp dword [byte ebx+04h]
        fild dword [byte eax+08h]
        fstp dword [byte ebx+08h]
        lea eax, [byte ebx+08h]
        test ecx, ecx
        jne short .3
        fldz
        mov ecx, eax
        fcomp dword [byte ebx+08h]
        fnstsw ax
        sahf
        jae short .1
        mov dword [esp], 0FFFFFFD0h
        jmp short .2
.1:
        mov dword [esp], 30h
.2:
        fild dword [esp]
        fadd dword [ecx]
        fstp dword [ecx]
        add esp, byte 8
        pop ecx
        ret
.3:
        cmp ecx, byte 2
        jne short .6
        fldz
        mov ecx, eax
        fcomp dword [byte ebx+08h]
        fnstsw ax
        sahf
        jae short .4
        mov dword [byte esp+04h], 30h
        jmp short .5
.4:
        mov dword [byte esp+04h], 0FFFFFFD0h
.5:
        fild dword [byte esp+04h]
        fadd dword [ecx]
        fstp dword [ecx]
        add esp, byte 8
        pop ecx
        ret
.6:
        jle short .7
        mov dword [byte ebx+08h], 46960000h
.7:
        add esp, byte 8
        pop ecx
        ret
;-----------------------------------------------------------------------------
; PickBoxSeat                                     39DA4  97 PC, low confidence
; A penalized player takes the first free seat in his team's penalty box
;-----------------------------------------------------------------------------
PickBoxSeat:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        mov dword [byte esp+010h], eax
        test byte [dword eax+0BFh], 40h
        setne al
        and eax, 0FFh
        mov esi, dword [dword eax+BenchSlotTable]
        sar esi, 18h
        mov ebp, eax
        dec esi
        shl eax, 7
        lea edi, [nosplit esi*4+00h]
        mov dword [byte esp+014h], eax
        add edi, eax
        jmp near .8
.1:
        lea ecx, [nosplit esi*4+00h]
        add ecx, eax
        inc byte [byte ecx+03h]
        cmp esi, byte 2
        jg near .7
        movsx eax, byte [byte ecx+02h]
        test eax, eax
        jl short .3
        call FindSeatModel
        cmp esi, byte 2
        jne short .2
        mov byte [byte ecx+02h], 0FFh
        jmp short .3
.2:
        mov ebx, esp
        mov edx, dword [ecx]
        mov eax, ebp
        sar edx, 18h
        call GetSeatPosition
        mov eax, esp
        mov edx, ebp
        call AddSeatModel
        mov byte [byte ecx+02h], al
.3:
        movsx eax, byte [ecx]
        test eax, eax
        jl short .7
        cmp eax, byte 0Ch
        jge short .7
        imul eax, dword 108h
        add eax, SortCords
        cmp esi, byte 2
        jne short .4
        mov dword [byte eax+028h], 46960000h
        jmp short .7
.4:
        fldz
        lea ecx, [byte eax+028h]
        fcomp dword [byte eax+028h]
        fnstsw ax
        sahf
        jae short .5
        mov dword [byte esp+0Ch], 0C6h
        jmp short .6
.5:
        mov dword [byte esp+0Ch], 0FFFFFF3Ah
.6:
        fild dword [byte esp+0Ch]
        fadd dword [ecx]
        fstp dword [ecx]
.7:
        sub edi, byte 4
        mov eax, dword [dword edi+BenchSeats]
        dec esi
        mov dword [dword edi+SeatTable], eax
.8:
        mov eax, BoxSeats
        add eax, dword [byte esp+014h]
        test esi, esi
        jge near .1
        mov edx, dword [byte esp+010h]
        mov dl, byte [dword edx+0A4h]
        mov byte [eax], dl
        mov edx, dword [byte esp+010h]
        mov dl, byte [dword edx+0A6h]
        mov byte [byte eax+02h], 0FFh
        mov byte [byte eax+03h], 0
        mov byte [byte eax+01h], dl
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FreeBoxSeat                                     39EC0  97 PC, low confidence
; A player leaving the penalty box gives up his seat and gets the gate
; position
;-----------------------------------------------------------------------------
FreeBoxSeat:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov dh, byte [dword eax+0BFh]
        xor ebx, ebx
        test dh, 40h
        setne bl
        mov edx, dword [dword ebx+BenchSlotTable]
        sar edx, 18h
        mov dword [byte esp+010h], edx
        mov edx, dword [dword eax+0A3h]
        sar edx, 18h
        mov eax, ebx
        mov esi, ebx
        call FindBenchSlot
        mov edi, eax
        test eax, eax
        jl near .10
        cmp dword [byte esp+010h], byte 1
        jl near .10
        shl ebx, 7
        shl eax, 2
        add ebx, BoxSeats
        add eax, ebx
        mov bl, byte [byte eax+02h]
        test bl, bl
        jl short .1
        movsx eax, bl
        call FindSeatModel
.1:
        mov eax, esi
        shl eax, 7
        mov dword [byte esp+0Ch], eax
        inc edi
        mov ebp, dword [byte esp+0Ch]
        lea eax, [nosplit edi*4+00h]
        mov ebx, dword [byte esp+010h]
        add ebp, eax
        cmp edi, ebx
        jge near .9
        mov ecx, BoxSeats
        add ecx, dword [byte esp+0Ch]
        add ecx, eax
.2:
        mov al, byte [byte ecx+03h]
        dec al
        mov dword [byte esp+014h], ecx
        mov byte [byte ecx+03h], al
        cmp edi, byte 3
        jne short .4
        cmp byte [ecx], 0
        jl short .3
        mov ebx, esp
        mov edx, dword [ecx]
        mov eax, esi
        sar edx, 18h
        call GetSeatPosition
        movsx eax, byte [ecx]
        imul eax, dword 108h
        mov edx, SortCords
        add edx, eax
        mov eax, dword [byte esp+08h]
        mov dword [byte edx+028h], eax
        jmp near .8
.3:
        mov ebx, esp
        mov edx, dword [ecx]
        mov eax, esi
        sar edx, 18h
        call GetSeatPosition
        mov eax, esp
        mov edx, esi
        call AddSeatModel
        mov byte [byte ecx+02h], al
        jmp near .8
.4:
        jge short .8
        movsx eax, byte [byte ecx+02h]
        test eax, eax
        jl short .5
        call FindSeatModel
        mov ebx, esp
        mov edx, dword [ecx]
        mov eax, esi
        sar edx, 18h
        call GetSeatPosition
        mov eax, esp
        mov edx, esi
        call AddSeatModel
        mov byte [byte ecx+02h], al
.5:
        mov eax, dword [byte esp+014h]
        movsx eax, byte [eax]
        test eax, eax
        jl short .8
        cmp eax, byte 0Ch
        jge short .8
        imul eax, dword 108h
        add eax, SortCords
        fldz
        lea edx, [byte eax+028h]
        fcomp dword [byte eax+028h]
        fnstsw ax
        sahf
        jae short .6
        mov dword [byte esp+018h], 0C6h
        jmp short .7
.6:
        mov dword [byte esp+018h], 0FFFFFF3Ah
.7:
        fild dword [byte esp+018h]
        fsubr dword [edx]
        fstp dword [edx]
.8:
        add ebp, byte 4
        mov eax, dword [dword ebp+BoxSeatTeam]
        inc edi
        mov dword [dword ebp+BoxSeatPlayer], eax
        mov eax, dword [byte esp+010h]
        add ecx, byte 4
        cmp edi, eax
        jl near .2
.9:
        mov eax, dword [byte esp+010h]
        mov edx, dword [byte esp+0Ch]
        shl eax, 2
        add eax, edx
        mov bh, 0FFh
        mov byte [dword eax+BoxSeatFlags], bh
        mov byte [dword eax+BoxSeatTeam], bh
        mov byte [dword eax+BoxSeatSlot], bh
.10:
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PickBenchSeat                                   3A06C  97 PC, low confidence
; A player going to the bench takes a free seat on his team's bench
;-----------------------------------------------------------------------------
PickBenchSeat:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov esi, eax
        mov word [byte esp+0Ch], dx
        mov ah, byte [dword eax+0BFh]
        xor ecx, ecx
        test ah, 40h
        setne al
        mov edx, dword [dword esi+0A3h]
        mov cl, al
        sar edx, 18h
        mov eax, ecx
        mov ebp, ecx
        call FindBenchSlot
        test eax, eax
        jl short .1
        mov ebx, dword [byte esp+0Ch]
        movsx dx, byte [dword esi+0A6h]
        cmp dx, bx
        je short .1
        mov edi, ecx
        shl edi, 7
        shl eax, 2
        add edi, BoxSeats
        add edi, eax
        cmp byte [byte edi+02h], 0
        jge short .1
        mov ebx, esp
        mov edx, dword [edi]
        mov eax, ecx
        sar edx, 18h
        call GetSeatPosition
        mov eax, esp
        mov edx, ecx
        call AddSeatModel
        mov byte [edi], 0FFh
        mov byte [byte edi+02h], al
.1:
        mov edx, dword [byte esp+0Ah]
        mov eax, ebp
        sar edx, 10h
        call FindBenchSlot
        test eax, eax
        jl short .3
        mov edx, BoxSeats
        shl ebp, 7
        shl eax, 2
        add edx, ebp
        add edx, eax
        cmp byte [edx], 0
        jl short .2
        xor ebx, ebx
        movsx eax, byte [edx]
        mov bl, byte [dword esi+0A4h]
        cmp eax, ebx
        je short .2
        mov ecx, eax
        shl ecx, 5
        add ecx, eax
        mov eax, SortCords
        shl ecx, 3
        add eax, ecx
        mov ebx, dword [dword eax+0AEh]
        sar ebx, 18h
        cmp byte [dword ebx+eax+0B2h], 13h
        jne short .2
        mov dword [byte eax+028h], 46960000h
.2:
        mov ch, byte [byte edx+02h]
        test ch, ch
        jl short .3
        movsx eax, ch
        call FindSeatModel
        mov byte [byte edx+02h], 0FFh
.3:
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; MoveBoxToBenchSeat                              3A164  97 PC, low confidence
; Moves a player from his penalty box seat to a bench seat
;-----------------------------------------------------------------------------
MoveBoxToBenchSeat:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov esi, eax
        movsx edx, dx
        mov ecx, BoxSeats
        call FindBenchSlot
        mov ebx, esi
        mov edi, eax
        shl ebx, 7
        lea edx, [nosplit eax*4+00h]
        add ecx, ebx
        add edx, ecx
        mov ah, byte [byte edx+02h]
        test ah, ah
        jl near .9
        movsx eax, ah
        call FindSeatModel
        mov byte [byte edx+02h], 0FFh
        mov eax, dword [dword esi+BenchSlotTable]
        sar eax, 18h
        mov dword [byte esp+014h], eax
        cmp eax, byte 1
        jl near .9
        inc edi
        lea eax, [nosplit edi*4+00h]
        mov dword [byte esp+010h], ebx
        lea ebp, [eax+ebx]
        cmp edi, dword [byte esp+014h]
        jge near .8
        add ecx, eax
.1:
        mov dh, byte [byte ecx+03h]
        dec dh
        mov dword [byte esp+0Ch], ecx
        mov byte [byte ecx+03h], dh
        cmp edi, byte 3
        jne short .3
        cmp byte [ecx], 0
        jl short .2
        mov ebx, esp
        mov edx, dword [ecx]
        mov eax, esi
        sar edx, 18h
        call GetSeatPosition
        movsx edx, byte [ecx]
        imul edx, dword 108h
        add edx, SortCords
        mov eax, dword [byte esp+08h]
        mov dword [byte edx+028h], eax
        jmp near .7
.2:
        mov ebx, esp
        mov edx, dword [ecx]
        mov eax, esi
        sar edx, 18h
        call GetSeatPosition
        mov eax, esp
        mov edx, esi
        call AddSeatModel
        mov byte [byte ecx+02h], al
        jmp near .7
.3:
        jge short .7
        movsx eax, byte [byte ecx+02h]
        test eax, eax
        jl short .4
        call FindSeatModel
        mov ebx, esp
        mov edx, dword [ecx]
        mov eax, esi
        sar edx, 18h
        call GetSeatPosition
        mov eax, esp
        mov edx, esi
        call AddSeatModel
        mov byte [byte ecx+02h], al
.4:
        mov eax, dword [byte esp+0Ch]
        movsx eax, byte [eax]
        test eax, eax
        jl short .7
        cmp eax, byte 0Ch
        jge short .7
        imul eax, dword 108h
        add eax, SortCords
        fldz
        lea edx, [byte eax+028h]
        fcomp dword [byte eax+028h]
        fnstsw ax
        sahf
        jae short .5
        mov dword [byte esp+018h], 0C6h
        jmp short .6
.5:
        mov dword [byte esp+018h], 0FFFFFF3Ah
.6:
        fild dword [byte esp+018h]
        fsubr dword [edx]
        fstp dword [edx]
.7:
        add ebp, byte 4
        mov eax, dword [dword ebp+BoxSeatTeam]
        inc edi
        mov dword [dword ebp+BoxSeatPlayer], eax
        mov eax, dword [byte esp+014h]
        add ecx, byte 4
        cmp edi, eax
        jl near .1
.8:
        mov eax, dword [byte esp+014h]
        mov edx, dword [byte esp+010h]
        shl eax, 2
        add eax, edx
        mov dl, 0FFh
        mov byte [dword eax+BoxSeatFlags], dl
        mov byte [dword eax+BoxSeatTeam], dl
        mov byte [dword eax+BoxSeatSlot], dl
.9:
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
