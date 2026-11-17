; Crowd chants and game music restarts.
bits 32
%include "hockey.inc"
section s_1120A progbits alloc exec nowrite align=1
extern __STOSB, awtmstruct, BreakawayFlag, ChantIndex, ChantPlayed, ChantState, ChkMenuMusic, CrowdChantTable
extern forcepldata, GameOptionFlags, gsp, hmtmstruct, MusicFileName, QueueMusicRestart, rand_, ReplayPlaying
extern RequestMusicStop, SetCrowdMood, setpersonel, StartMusicTrack
global PickCrowdChant, StartCrowdMusicJumpTable, StartCrowdMusic, StartCrowdMusic_26, StartCrowdMusic_4F, StartCrowdMusic_78, StartCrowdMusic_A6, RestartGameMusic
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PickCrowdChant                                  1120C  97 PC, low confidence
; Picks a crowd chant
;-----------------------------------------------------------------------------
PickCrowdChant:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, eax
        mov word [esp], dx
        mov edi, edx
        xor ebx, ebx
        and edi, 7FFFh
        mov ebp, 3Fh
.1:
        mov ah, byte [byte esp+01h]
        mov word [esi], 44h
        test ah, 80h
        je short .2
        call rand_
        mov edx, eax
        mov ecx, 0Ah
        sar edx, 1Fh
        idiv ecx
        test edx, edx
        jne short .2
        call rand_
        mov edx, eax
        mov ecx, 2
        sar edx, 1Fh
        idiv ecx
        test edx, edx
        sete dl
        and edx, 0FFh
        add edx, byte 41h
        mov word [esi], dx
.2:
        cmp word [esi], byte 44h
        jne short .3
        test di, di
        jbe short .3
        call rand_
        mov edx, eax
        mov ecx, 8
        sar edx, 1Fh
        idiv ecx
        test edx, edx
        jne short .3
        mov word [esi], di
.3:
        cmp word [esi], byte 44h
        jne short .5
        xor ebx, ebx
.4:
        call rand_
        mov edx, eax
        sar edx, 1Fh
        idiv ebp
        mov word [esi], dx
        xor edx, edx
        mov dx, word [esi]
        cmp byte [dword edx+ChantPlayed], 0
        je short .5
        inc ebx
        cmp ebx, byte 5
        jl short .4
.5:
        cmp ebx, byte 5
        jl short .6
        mov eax, ChantPlayed
        mov ecx, ebp
        xor edx, edx
        call __STOSB
        xor al, al
        mov edx, dword [GameOptionFlags]
        mov byte [ChantState], al
        mov edx, dword [byte edx+01h]
        shl edx, 0Ch
        shr edx, 1Ah
        mov dx, word [nosplit edx*2+CrowdChantTable]
        mov word [ChantIndex], dx
        jmp near .1
.6:
        mov di, word [esi]
        cmp di, byte 3Fh
        jae short .7
        xor edx, edx
        mov dx, di
        mov byte [dword edx+ChantPlayed], 1
.7:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
StartCrowdMusicJumpTable:                       ; jump table for the switch cases of StartCrowdMusic
        dd StartCrowdMusic_26
        dd StartCrowdMusic_4F
        dd StartCrowdMusic_78
        dd StartCrowdMusic_A6
;-----------------------------------------------------------------------------
; StartCrowdMusic                                 11328  97 PC, low confidence
; Starts the crowd music or chant
;-----------------------------------------------------------------------------
StartCrowdMusic:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 54h
        mov ecx, eax
        db 081h,0E8h,00h,01h,00h,00h            ; insn: sub eax,100h
        cmp ax, 3
        ja near StartCrowdMusic_A6.1
        and eax, 0FFFFh
        jmp dword [nosplit cs:eax*4+StartCrowdMusicJumpTable]
StartCrowdMusic_26:
        mov eax, 0Dh
        call SetCrowdMood
        mov eax, 5Bh
        mov ch, 1
        call StartMusicTrack
        mov byte [ChantState], ch
        call RequestMusicStop
        add esp, byte 54h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
StartCrowdMusic_4F:
        mov eax, 0Dh
        call SetCrowdMood
        mov eax, 5Ah
        mov cl, 1
        call StartMusicTrack
        mov byte [ChantState], cl
        call RequestMusicStop
        add esp, byte 54h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
StartCrowdMusic_78:
        call rand_
        mov edx, eax
        mov ebx, 4
        sar edx, 1Fh
        idiv ebx
        lea eax, [byte edx+05Dh]
        mov bh, 1
        call StartMusicTrack
        mov byte [ChantState], bh
        call RequestMusicStop
        add esp, byte 54h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
StartCrowdMusic_A6:
        mov eax, 61h
        mov bl, 1
        call StartMusicTrack
        mov byte [ChantState], bl
        call RequestMusicStop
        add esp, byte 54h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov eax, 8
        call SetCrowdMood
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+02h], 20h
        jne near .6
        cmp dword [ReplayPlaying], byte 0
        jne near .6
        mov dx, word [BreakawayFlag]
        cmp dx, byte 5
        je short .2
        cmp dx, byte 6
        je short .2
        cmp dx, byte 4
        je short .2
        cmp dx, byte 0Ah
        je short .2
        cmp dx, byte 9
        je short .2
        cmp dx, byte 8
        jne near .6
.2:
        mov ebx, dword [gsp]
        sar ebx, 10h
        mov esi, 3Ch
        mov edx, ebx
        mov eax, ebx
        sar edx, 1Fh
        idiv esi
        test eax, eax
        jne short .3
        mov edx, ebx
        mov eax, ebx
        sar edx, 1Fh
        idiv esi
        cmp edx, byte 14h
        jl short .6
.3:
        mov bx, word [awtmstruct]
        mov dx, word [hmtmstruct]
        sub edx, ebx
        movsx eax, dx
        cmp eax, byte 0FFFFFFFFh
        je short .4
        cmp eax, byte 0FFFFFFFEh
        jne short .5
.4:
        or ch, 80h
.5:
        xor edx, edx
        lea eax, [byte esp+050h]
        mov dx, cx
        call PickCrowdChant
        xor eax, eax
        mov edx, esp
        mov ax, word [byte esp+050h]
        call MusicFileName
        mov eax, esp
        mov dh, 1
        call ChkMenuMusic
        mov byte [ChantState], dh
        call RequestMusicStop
.6:
        add esp, byte 54h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; RestartGameMusic                                114C4  97 PC, low confidence
; Restarts the game music and refreshes the players
;-----------------------------------------------------------------------------
RestartGameMusic:
        push edx
        cmp byte [ChantState], 0
        je short .1
        xor dl, dl
        call QueueMusicRestart
        mov byte [ChantState], dl
.1:
        pop edx
        ret
        db 08Dh,040h,00h
        mov eax, hmtmstruct
        call setpersonel
        mov eax, hmtmstruct
        call forcepldata
        mov eax, awtmstruct
        call setpersonel
        mov eax, awtmstruct
        nop
