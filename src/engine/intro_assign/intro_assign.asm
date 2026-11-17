; Intro and Stanley Cup assignments: standing, lines, positions and bench players.
bits 32
%include "hockey.inc"
section s_29F2F progbits alloc exec nowrite align=1
extern AllocMemBlock, AngleOfVector, AwAssignPlayer, BuildCupPatchArt, ClearObjectHidden, CupCelebration, CupFaceTextures, DrawJerseyLettering
extern FadeOut, FadePalette, FreeMemBlock, GetPaletteRange, HmAssignPlayer, hmtmstruct, HomeTeamRecord, IntroLineCount
extern IntroLineX, IntroLineY, KbdIdleCall, LoadCupArt, MusicPlaying, PickSkateAnim, PlayerControlFlags, PlayerPastLine_D1
extern PtrPuckFlags, PtrPuckObject, PuckCarrierPos, QueueMusicRestart, randomd0, ResetAnimTimer, SelectCameraView, SetModelSlotValue
extern SetSkateSpeedFromRating, SetSPA, SetupPlayerModel, SortCords, StanleyFlag, StanleyPlayer, StartCameraPath, str_Cuppal
extern str_Punct_assintrostand, TriggerCameraFlashes
global assintrostand, assintroline, asstakeposition, TakeBenchPlayer, assstanley
        db 090h
;-----------------------------------------------------------------------------
; assintrostand                                29F30  95 PC, medium confidence
; Asstab 25h (PreGameIntro): stands with a countdown in temp5, small random x jitter and random fidget
; animation (introstandanims_m2); when done assinsert 27h
;-----------------------------------------------------------------------------
assintrostand:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov eax, dword [dword eax+0EEh]
        mov dword [byte eax+028h], 100h
        mov edx, dword [PtrPuckFlags]
        mov eax, dword [dword edx+0AEh]
        sar eax, 18h
        cmp byte [dword edx+eax+0B2h], 40h
        je short .2
        and byte [dword ecx+0BFh], 0DFh
        mov eax, ecx
        call PickSkateAnim
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .1
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        mov edx, 32h
        mov byte [dword ecx+eax+0B2h], dl
        or byte [dword ecx+0BFh], 2
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov eax, dword [dword ecx+0AEh]
        sar eax, 18h
        mov edx, 6
        mov byte [dword ecx+eax+0B2h], dl
        or byte [dword ecx+0BFh], 2
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        test byte [dword ecx+0BFh], 20h
        jne short .3
        mov eax, 28h
        call randomd0
        movsx edx, ax
        cmp edx, byte 8
        jge short .3
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov al, byte [dword ecx+0BFh]
        or al, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], al
        mov eax, ecx
        mov edx, dword [nosplit edx*4+str_Punct_assintrostand]
        push dword 3F800000h
        call SetSPA
.3:
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; assintroline                                    2A000  95 PC, low confidence
; Asstab 26h (PreGameIntro): skates to the line-up spot (temp3 -0Fh,temp4), turns to face centre, marks
; temp5 -64h; when all 12 skaters are done sets seqtimer 0Ah; crowdlevel 320h
;-----------------------------------------------------------------------------
assintroline:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 0Ch
        mov esi, eax
        test byte [dword eax+0BFh], 2
        je short .1
        mov dword [byte esi+020h], 0C4870000h
        mov dword [byte esi+028h], 0
        mov dl, byte [dword esi+0BFh]
        mov dword [byte esi+01Ch], 40490FDBh
        and dl, 0FDh
        mov eax, dword [dword esi+0FAh]
        mov byte [dword esi+0BFh], dl
        call ResetAnimTimer
        mov dh, byte [dword esi+0BFh]
        mov ebx, 20h
        or dh, 20h
        mov eax, esi
        mov byte [dword esi+0BFh], dh
        mov edx, 17Bh
        push dword 3F800000h
        call SetSPA
.1:
        test byte [dword esi+0BFh], 20h
        jne near .5
        mov eax, 14h
        call randomd0
        cwde
        cmp eax, byte 2
        jge short .2
        test eax, eax
        sete al
        xor edx, edx
        mov dl, al
        mov eax, dword [dword esi+0FAh]
        call ResetAnimTimer
        mov bh, byte [dword esi+0BFh]
        add edx, 179h
        or bh, 20h
        mov eax, esi
        mov byte [dword esi+0BFh], bh
        xor ebx, ebx
        push dword 3F800000h
        call SetSPA
.2:
        mov eax, dword [dword esi+0FAh]
        cmp dword [byte eax+018h], 43700000h
        jge short .3
        inc dword [IntroLineCount]
.3:
        cmp dword [IntroLineCount], byte 0Eh
        jl short .4
        xor edi, edi
        mov dword [IntroLineCount], edi
.4:
        mov edx, dword [IntroLineCount]
        mov eax, dword [nosplit edx*8+IntroLineX]
        mov dword [byte esp+04h], eax
        mov eax, dword [nosplit edx*8+IntroLineY]
        mov dword [esp], eax
        mov eax, dword [byte esi+0Ch]
        mov edx, dword [esp]
        sar eax, 10h
        sub edx, eax
        push edx
        mov eax, dword [byte esi+04h]
        mov edx, dword [byte esp+08h]
        sar eax, 10h
        sub edx, eax
        push edx
        call AngleOfVector
        mov dword [byte esp+010h], eax
        add esp, byte 8
        mov eax, dword [dword esi+0EEh]
        fild dword [byte esp+08h]
        fstp dword [byte eax+010h]
        mov eax, dword [byte esi+0Ch]
        mov edx, dword [esp]
        sar eax, 10h
        sub edx, eax
        push edx
        mov eax, dword [byte esi+04h]
        mov edx, dword [byte esp+08h]
        sar eax, 10h
        sub edx, eax
        push edx
        call AngleOfVector
        mov dword [byte esp+010h], eax
        add esp, byte 8
        mov eax, dword [dword esi+0EEh]
        fild dword [byte esp+08h]
        fstp dword [byte eax+014h]
        mov eax, dword [dword esi+0EEh]
        fild dword [byte esp+04h]
        fstp dword [eax]
        mov eax, dword [dword esi+0EEh]
        fild dword [esp]
        fstp dword [byte eax+04h]
        mov eax, dword [dword esi+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+018h], 42480000h
        mov eax, esi
        call SetSkateSpeedFromRating
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+024h], 42480000h
.5:
        add esp, byte 0Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; asstakeposition                                 2A1C8  95 PC, low confidence
; Asstab 27h (assintrostand, assbench, PenShotStart/Assign): goalie -> 0Dh; else skates to the position slot
; from apl by position and team tmap, exits when done
;-----------------------------------------------------------------------------
asstakeposition:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 0Ch
        mov esi, eax
        mov ah, byte [dword eax+0BFh]
        mov ecx, SortCords
        test ah, 20h
        jne near .7
        mov dl, byte [dword esi+0BFh]
        test dl, 2
        je short .1
        mov dh, dl
        and dh, 0FDh
        mov eax, dword [dword esi+0FAh]
        mov byte [dword esi+0BFh], dh
        call ResetAnimTimer
        mov bl, byte [dword esi+0BFh]
        mov edx, 17Ch
        or bl, 20h
        mov eax, esi
        mov byte [dword esi+0BFh], bl
        xor ebx, ebx
        push dword 3F800000h
        call SetSPA
.1:
        mov eax, 14h
        call randomd0
        cwde
        cmp eax, byte 2
        jge short .4
        mov eax, dword [dword esi+0FAh]
        cmp dword [byte eax+01Ch], byte 2
        jne short .2
        mov edx, 4Ah
        jmp short .3
.2:
        mov edx, 48h
.3:
        mov eax, dword [dword esi+0FAh]
        call ResetAnimTimer
        mov bh, byte [dword esi+0BFh]
        or bh, 20h
        mov eax, esi
        mov byte [dword esi+0BFh], bh
        xor ebx, ebx
        push dword 3F800000h
        call SetSPA
.4:
        xor eax, eax
.5:
        mov edx, dword [dword ecx+0AEh]
        sar edx, 18h
        cmp byte [dword ecx+edx+0B2h], 20h
        je short .6
        inc eax
        add ecx, 108h
        cmp eax, byte 0Dh
        jl short .5
.6:
        mov eax, 14h
        call randomd0
        movsx edx, ax
        fld dword [byte ecx+020h]
        sub edx, byte 0Ah
        push eax
        fistp dword [esp]
        pop eax
        add eax, edx
        mov dword [byte esp+04h], eax
        mov eax, 14h
        call randomd0
        movsx edx, ax
        fld dword [byte ecx+028h]
        sub edx, byte 0Ah
        push eax
        fistp dword [esp]
        pop eax
        add eax, edx
        mov dword [esp], eax
        mov eax, dword [byte esi+0Ch]
        mov edx, dword [esp]
        sar eax, 10h
        sub edx, eax
        push edx
        mov eax, dword [byte esi+04h]
        mov edx, dword [byte esp+08h]
        sar eax, 10h
        sub edx, eax
        push edx
        call AngleOfVector
        mov dword [byte esp+010h], eax
        add esp, byte 8
        mov eax, dword [dword esi+0EEh]
        fild dword [byte esp+08h]
        fstp dword [byte eax+010h]
        mov eax, dword [byte esi+0Ch]
        mov edx, dword [esp]
        sar eax, 10h
        sub edx, eax
        push edx
        mov eax, dword [byte esi+04h]
        mov edx, dword [byte esp+08h]
        sar eax, 10h
        sub edx, eax
        push edx
        call AngleOfVector
        mov dword [byte esp+010h], eax
        add esp, byte 8
        mov eax, dword [dword esi+0EEh]
        fild dword [byte esp+08h]
        fstp dword [byte eax+014h]
        mov eax, dword [dword esi+0EEh]
        fild dword [byte esp+04h]
        fstp dword [eax]
        mov eax, dword [dword esi+0EEh]
        fild dword [esp]
        fstp dword [byte eax+04h]
        mov eax, dword [dword esi+0EEh]
        and byte [byte eax+028h], 7Fh
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+08h], 0
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+0Ch], 0
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+018h], 42480000h
        mov eax, esi
        call SetSkateSpeedFromRating
        mov eax, dword [dword esi+0EEh]
        mov dword [byte eax+024h], 42480000h
.7:
        add esp, byte 0Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; TakeBenchPlayer                                 2A3A0  97 PC, low confidence
; From assstanley: the team's first bench player (8002h) is marked on the ice
; (8001h)
;-----------------------------------------------------------------------------
TakeBenchPlayer:
        push ebx
        push ecx
        push esi
        mov ecx, eax
        mov eax, edx
        shl eax, 4
        add eax, edx
        shl eax, 2
        sub eax, edx
        mov ebx, hmtmstruct
        shl eax, 2
        add ebx, eax
        mov edx, ebx
        mov si, word [byte ebx+050h]
        xor eax, eax
        cmp si, 8002h
        jne short .2
.1:
        mov word [byte edx+050h], 8001h
        mov byte [dword ecx+0A7h], al
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        inc eax
        add edx, byte 2
        cmp eax, byte 19h
        jge near PlayerPastLine_D1
        cmp word [byte edx+050h], 8002h
        je short .1
        jmp short .2
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; assstanley                            2A3F4  94G logic94.asm, low confidence
; Player assignment routine table slot 8; probably the cup celebration assignment (low confidence)
;-----------------------------------------------------------------------------
assstanley:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov dword [esp], eax
        mov dl, byte [dword eax+0BFh]
        test dl, 2
        je near .5
        push byte 0
        mov bh, dl
        push dword 300h
        and bh, 0FDh
        push str_Cuppal
        mov byte [dword eax+0BFh], bh
        call AllocMemBlock
        add esp, byte 0Ch
        push eax
        push dword 100h
        push byte 0
        mov dword [StanleyPlayer], eax
        call GetPaletteRange
        add esp, byte 0Ch
        mov eax, 3
        call FadeOut
        mov eax, dword [AwAssignPlayer]
        mov edx, dword [HmAssignPlayer]
        sar eax, 10h
        sar edx, 10h
        sub edx, eax
        test edx, edx
        setl al
        and eax, 0FFh
        call CupCelebration
        mov edx, eax
        movsx ebx, ax
        mov word [byte esp+08h], ax
        mov eax, ebx
        shl eax, 4
        add eax, ebx
        shl eax, 2
        sub eax, ebx
        mov ebx, hmtmstruct
        shl eax, 2
        add ebx, eax
        mov dword [byte esp+04h], ebx
        test dx, dx
        je short .1
        mov ecx, SortCords
        jmp short .2
.1:
        mov ecx, HomeTeamRecord+420h
.2:
        xor ebp, ebp
.3:
        mov esi, dword [byte esp+06h]
        sar esi, 10h
        mov eax, ecx
        mov edx, esi
        call TakeBenchPlayer
        mov edi, dword [dword ecx+0A4h]
        sar edi, 18h
        imul edi, dword 125h
        mov eax, dword [byte esp+04h]
        mov eax, dword [dword eax+0108h]
        add eax, 0A3h
        xor ebx, ebx
        add edi, eax
        xor eax, eax
        mov edx, esi
        mov al, byte [dword ecx+0A4h]
        call CupFaceTextures
        lea edx, [byte edi+08h]
        xor ebx, ebx
        xor eax, eax
        mov bl, byte [dword edi+0BCh]
        mov al, byte [dword ecx+0A4h]
        call DrawJerseyLettering
        xor eax, eax
        lea edx, [byte edi+027h]
        mov al, byte [dword ecx+0A4h]
        inc ebp
        call SetupPlayerModel
        mov eax, esi
        add ecx, 108h
        call BuildCupPatchArt
        cmp ebp, byte 6
        jl short .3
        mov eax, dword [PtrPuckObject]
        mov dword [byte eax+020h], 0C57F0000h
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0A4h], 0Dh
        mov eax, dword [PtrPuckObject]
        mov word [dword eax+0A9h], 0FFFFh
        xor eax, eax
        mov al, byte [StanleyFlag]
        push dword 3F800000h
        call SetModelSlotValue
        xor eax, eax
        call LoadCupArt
        mov edx, dword [PuckCarrierPos]
        sar edx, 18h
        add edx, SortCords
        mov eax, 20h
        mov byte [dword edx+0B2h], al
        mov al, byte [PlayerControlFlags]
        or al, 2
        mov ecx, SortCords
        mov byte [PlayerControlFlags], al
        mov eax, 11EBh
        xor edx, edx
        call TriggerCameraFlashes
        mov eax, 4
        mov esi, 1
        call SelectCameraView
        mov eax, 4
        xor edx, edx
        add ecx, 108h
        call StartCameraPath
.4:
        mov eax, dword [dword ecx+0F2h]
        call ClearObjectHidden
        mov edx, dword [dword ecx+0AEh]
        sar edx, 18h
        mov eax, 21h
        mov byte [dword ecx+edx+0B2h], al
        mov ah, byte [dword ecx+0BFh]
        add ecx, 108h
        or ah, 2
        inc esi
        mov byte [byte ecx-049h], ah
        cmp esi, byte 0Ch
        jl short .4
        mov eax, dword [esp]
        mov dword [byte eax+060h], 2710h
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        cmp dword [byte eax+060h], 270Bh
        jne short .6
        mov ebx, 3
        mov edx, dword [StanleyPlayer]
        xor eax, eax
        call FadePalette
        mov ebx, dword [StanleyPlayer]
        push ebx
        call FreeMemBlock
        add esp, byte 4
.6:
        mov eax, dword [esp]
        mov ecx, dword [byte eax+060h]
        dec ecx
        mov dword [byte eax+060h], ecx
        test ecx, ecx
        jge short .7
        mov eax, dword [dword eax+0AEh]
        mov edi, dword [esp]
        sar eax, 18h
        add eax, edi
        mov edx, 42h
        mov byte [dword eax+0B2h], dl
        or byte [dword edi+0BFh], 2
.7:
        mov eax, dword [esp]
        cmp dword [byte eax+060h], 1B58h
        jne short .8
        call MusicPlaying
        test eax, eax
        je short .8
        call QueueMusicRestart
.8:
        call KbdIdleCall
        cmp eax, byte 1Bh
        jne short .9
        mov edx, dword [esp]
        mov edx, dword [dword edx+0AEh]
        mov ebx, dword [esp]
        sar edx, 18h
        add edx, ebx
        mov eax, 42h
        mov byte [dword edx+0B2h], al
        mov eax, ebx
        mov bl, byte [dword ebx+0BFh]
        or bl, 2
        mov byte [dword eax+0BFh], bl
.9:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
