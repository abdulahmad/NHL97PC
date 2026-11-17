; Game and period set-up: teams, benches and penalty boxes, lines on the ice, the clock and starting goalies.
bits 32
%include "hockey.inc"
section s_11504 progbits alloc exec nowrite align=1
extern __STOSB, assinsert, asspsclear, assreplace, AutoLineData, AwayControlSlot, AwayGoalieOff, AwayIceSlots
extern AwayTeamRecord, AwCounters, AwLineState, AwPlayerSlots, AwRosterMap, AwScore, AwTeamData, awtmstruct
extern BenchPlayerTable, BenchRequest, ChantState, ClearOverlayWindows, CommentaryEvent, DebugModelIndex, DebugModelRefresh, DefendFlags
extern DefenseByDefense, DefenseByOffense, DoGameFrame, DrawJerseyLettering, EndPenaltyShot, F64_0p01, F64_0p013, FaceoffRequest
extern FaceoffSpot, FaceoffSpotPosition, FaceoffZone, ForwardsByDefense, ForwardsByOffense, gameclock, GameObjects, GameOptionFlags
extern GameSettings, GameTick, GetPlayerJerseyNumber, gmode, GoalieTarget, gsp, HmCounters, HmLineState
extern HmPlayerSlots, HmRosterMap, HmScore, HmTeamData, hmtmstruct, holdreset, HomeControlSlot, HomeGoalieOff
extern HomeIceSlots, homelines, HomeTeamRecord, InitPlayerAnims, LastPlayerTouch, LastTouchPlayer, LineChangeAway, LineChangeHome
extern LinePickOrder, LinePlayerOffsets, LinePlayerOrder, LinePlayersAway, LinePlayersHome, LinePlayerSlots, LoadGoalieMask, LogPeriodEnd
extern ObjectPositions, OneTimerTarget, PaEvent, PassState, PenaltyBoxCount, PenaltyPending, PenaltyTeam, penshotlive
extern penshotmode, penshottimer, PeriodLength, PeriodLengths, PersonnelTable, PickBenchSeat, PlayerAssignWords, PlayerControlWords
extern PlayerPointsTable, PlayerStartDist, PlayerStartRecords, PlayerStartScale, PlayFlags, PtrPuckFlags, PtrPuckObject, PtrPuckOwner
extern PtrPuckState, PtrPuckTarget, PtrPuckZone, PuckFlags, PuckOwnerTeam, puckx, PuckZone, QueueMusicRestart
extern randomd0, RefreshFaceTextures, regd1, ReplayPlaying, ResetAnimTimer, ResetCoachModes, ResetPlayerSpots, ResetSceneCamera
extern SeasonActive, SetCameraMode, SetModelSlotValue, Setplass, SetPlayerTarget, SetupPlayerModel, ShootSpotY, ShowCameraView
extern SlotAssign, SortCords, StatsPanelOn, StatsPanelPlayer, StopAllSfx, UpdateCoachModes, UpdateFaceTextures, UpdateGameDisplay
extern UpdateRinkPalette, ZoneTargetY
global forcepldata, forcepldata_E, SetupFaceoffPlayers, ClearPlayerFlags, clearteams, ResetTeamStats, ResetBench, IsPlayoffGame
global RefreshPlayerModel, setplayer, reenergizeteam, SetupTeamForIntermission, ResetForIntermission, SeatBenchPlayer, ResetPlayers, ResetPlayersForPeriod
global ReplaceFaceoffPlayers, ReplaceFaceoffPlayers_62, ReplaceFaceoffPlayers_81, PlayerInLine, PickLinePlayers, setpersonel, PeriodLengthSetting, RefreshRinkPalette
global ClockTick, StartPeriod, FindStartingGoalies, ReleaseBoxPlayers
;-----------------------------------------------------------------------------
; forcepldata                                    11504  94G, medium confidence
; (team) faceoffs only: puts each player straight into his
; requested position (+0A8h -> +0A9h), assnearest for the centre, setplayer
;-----------------------------------------------------------------------------
forcepldata:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        mov ebx, dword [dword eax+0104h]
        xor ecx, ecx
forcepldata_E:
        movsx dx, byte [dword ebx+0A8h]
        mov word [dword ebx+0A9h], dx
        test dx, dx
        jl near ReplaceFaceoffPlayers_62
        mov eax, ebx
        call Setplass
        cmp word [dword ebx+0A9h], byte 4
        jne short .1
        mov edx, 0Ah
        mov eax, ebx
        call assinsert
.1:
        mov edx, dword [dword ebx+0A4h]
        sar edx, 18h
        mov word [byte esi+edx*2+050h], 8001h
        mov edx, dword [dword ebx+0A4h]
        mov eax, ebx
        sar edx, 18h
        call setplayer
        and byte [dword ebx+0C1h], 0FEh
        jmp near ReplaceFaceoffPlayers_81
        db 090h
;-----------------------------------------------------------------------------
; SetupFaceoffPlayers                             11574  97 PC, low confidence
; Places the players for the opening faceoff
;-----------------------------------------------------------------------------
SetupFaceoffPlayers:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 4
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+02h], 20h
        jne near .3
        mov eax, hmtmstruct
        call setpersonel
        mov eax, hmtmstruct
        call forcepldata
        mov eax, awtmstruct
        call setpersonel
        mov eax, awtmstruct
        xor edx, edx
        call forcepldata
        mov eax, dword [PtrPuckTarget]
        mov word [FaceoffSpot], dx
        mov word [eax], dx
        mov dword [esp], edx
        mov eax, dword [PtrPuckFlags]
        fild word [esp]
        fstp dword [byte eax+020h]
        mov eax, dword [PtrPuckState]
        mov word [eax], 0C0h
        mov ax, word [eax]
        mov dword [esp], eax
        mov eax, dword [PtrPuckFlags]
        fild word [esp]
        fstp dword [byte eax+024h]
        mov eax, dword [PtrPuckOwner]
        mov word [FaceoffZone], dx
        mov word [eax], dx
        mov dword [esp], edx
        mov eax, dword [PtrPuckFlags]
        fild word [esp]
        fstp dword [byte eax+028h]
        mov eax, dword [PtrPuckZone]
        mov byte [eax], 0Ch
        mov eax, dword [PtrPuckFlags]
        mov dword [byte eax+038h], 0
        mov eax, dword [PtrPuckFlags]
        mov ebx, SortCords
        xor ecx, ecx
        mov dword [byte eax+030h], 0
.1:
        mov si, word [dword ebx+0A9h]
        xor edx, edx
        cmp si, byte 4
        sete al
        mov dl, al
        add edx, byte 7
        mov eax, ebx
        movsx edx, dx
        call assinsert
        cmp word [dword ebx+0A9h], byte 0
        jl short .2
        mov eax, ebx
        call FaceoffSpotPosition
        mov edx, dword [dword ebx+0EEh]
        fld dword [edx]
        mov edx, dword [dword ebx+0EEh]
        fstp dword [byte ebx+020h]
        mov eax, dword [byte edx+04h]
        mov dword [byte ebx+028h], eax
        mov dword [byte ebx+038h], 0
.2:
        mov al, byte [dword ebx+0C0h]
        add ebx, 108h
        and al, 0FBh
        mov dh, byte [byte ebx-047h]
        mov byte [byte ebx-048h], al
        and dh, 0FEh
        mov ah, byte [byte ebx-049h]
        mov byte [byte ebx-047h], dh
        and ah, 0DFh
        inc ecx
        mov byte [byte ebx-049h], ah
        cmp ecx, byte 0Ch
        jl short .1
.3:
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ClearPlayerFlags                                116B0  97 PC, low confidence
; Clears the player flags
;-----------------------------------------------------------------------------
ClearPlayerFlags:
        push ebx
        push edx
        xor eax, eax
.1:
        movsx edx, ax
        lea edx, [edx+edx*2]
        xor bl, bl
        mov byte [dword edx+PenaltyTeam], bl
        inc eax
        mov byte [dword edx+PenaltyPending], bl
        cmp ax, 20h
        jl short .1
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push edx
        xor edx, edx
        xor ah, ah
        mov dword [DefendFlags], edx
        mov dword [GoalieTarget], edx
        mov dword [regd1], edx
        mov dword [ZoneTargetY], edx
        mov dword [ShootSpotY], edx
        mov byte [gmode], ah
        xor edx, edx
        xor al, al
        mov word [FaceoffSpot], dx
        mov word [FaceoffZone], dx
        mov word [holdreset], dx
        mov word [PlayFlags], dx
        mov word [PuckFlags], dx
.2:
        movsx edx, ax
        lea edx, [edx+edx*2]
        xor bl, bl
        mov byte [dword edx+PenaltyTeam], bl
        inc eax
        mov byte [dword edx+PenaltyPending], bl
        cmp ax, 20h
        jl short .2
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; clearteams                                   11744  95 PC, medium confidence
; Zero both team structs (200h bytes) and store their data pointers (tmsort, tmlines, tmroster,...).
;-----------------------------------------------------------------------------
clearteams:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 10h
        xor edx, edx
.1:
        movsx eax, dx
        mov bl, byte [dword eax+HmRosterMap]
        mov byte [esp+eax], bl
        mov bl, byte [dword eax+AwRosterMap]
        inc edx
        mov byte [byte esp+eax+08h], bl
        cmp dx, byte 8
        jl short .1
        mov eax, hmtmstruct
        xor edx, edx
        jmp short .3
.2:
        inc edx
        mov byte [eax], 0
        inc eax
.3:
        movsx ebx, dx
        cmp ebx, 218h
        jb short .2
        mov edx, SortCords
        mov ebx, AutoLineData
        mov ah, 0FFh
        mov ecx, HomeTeamRecord+420h
        mov esi, homelines
        mov dword [HmTeamData], edx
        mov dword [HmScore], ebx
        mov byte [HmPlayerSlots], ah
        mov dword [AwTeamData], ecx
        mov dword [AwScore], esi
        mov byte [AwPlayerSlots], ah
        xor edx, edx
        mov ebx, 0FFFFFFFFh
        mov word [HmLineState], dx
        mov word [HmCounters], bx
        mov word [AwLineState], dx
        mov word [AwCounters], bx
.4:
        movsx eax, dx
        mov bl, byte [esp+eax]
        mov byte [dword eax+HmRosterMap], bl
        mov bl, byte [byte esp+eax+08h]
        inc edx
        mov byte [dword eax+AwRosterMap], bl
        cmp dx, byte 8
        jl short .4
        add esp, byte 10h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ResetTeamStats                                  11808  97 PC, low confidence
; Resets the team game stats
;-----------------------------------------------------------------------------
ResetTeamStats:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        xor edx, edx
        mov ebp, hmtmstruct
        mov dword [esp], edx
.1:
        mov edi, dword [dword ebp+0108h]
        mov word [byte ebp+0Eh], 6
        lea ebx, [dword edi+0A3h]
        lea eax, [byte ebp+050h]
        mov di, word [dword edi+0A1h]
        xor edx, edx
        test di, di
        jle short .6
.2:
        mov cl, byte [dword ebx+0BEh]
        lea esi, [byte eax+02h]
        test cl, 2
        je short .3
        mov word [eax], 8006h
        jmp short .5
.3:
        test cl, 4
        je short .4
        mov word [eax], 8004h
        jmp short .5
.4:
        mov word [eax], 8002h
.5:
        mov eax, esi
        inc edx
        add ebx, 125h
        cmp dx, di
        jl short .2
.6:
        mov ebx, edx
        inc edx
        cmp bx, byte 19h
        jge short .7
        mov word [eax], 8007h
        add eax, byte 2
        jmp short .6
.7:
        mov edi, dword [dword ebp+0108h]
        lea ebx, [dword edi+01D42h]
        mov di, word [dword edi+01D40h]
        xor edx, edx
        test di, di
        jle short .12
.8:
        mov cl, byte [dword ebx+0BEh]
        lea esi, [byte eax+02h]
        test cl, 2
        je short .9
        mov word [eax], 8006h
        jmp short .11
.9:
        test cl, 4
        je short .10
        mov word [eax], 8004h
        jmp short .11
.10:
        mov word [eax], 8002h
.11:
        mov eax, esi
        inc edx
        add ebx, 125h
        cmp dx, di
        jl short .8
.12:
        mov ebx, edx
        inc edx
        cmp bx, byte 3
        jge short .13
        mov word [eax], 8007h
        add eax, byte 2
        jmp short .12
.13:
        mov ebx, dword [esp]
        inc ebx
        mov ebp, awtmstruct
        mov dword [esp], ebx
        cmp bx, byte 2
        jl near .1
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ResetBench                                     11908  94G, medium confidence
; the bench and penalty box state of both teams'
; rosters
;-----------------------------------------------------------------------------
ResetBench:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, hmtmstruct
        xor ecx, ecx
        mov esi, 200h
.1:
        movsx eax, cx
        xor dl, dl
        mov byte [dword eax+PenaltyBoxCount], dl
        mov edx, 1Bh
.2:
        movsx eax, dx
        add eax, eax
        add eax, ebx
        test byte [byte eax+051h], 80h
        jne short .4
        mov di, word [byte eax+050h]
        test si, di
        je short .3
        test di, 1FFh
        je short .6
.3:
        movsx eax, cx
        inc byte [dword eax+PenaltyBoxCount]
        jmp short .6
.4:
        mov di, word [byte eax+050h]
        test di, di
        je short .5
        cmp di, 8001h
        jne short .6
.5:
        movsx eax, dx
        mov word [byte ebx+eax*2+050h], 8002h
.6:
        dec edx
        test dx, dx
        jge short .2
        inc ecx
        mov ebx, awtmstruct
        cmp cx, byte 2
        jl short .1
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; IsPlayoffGame                                   11984  97 PC, low confidence
; Game mode check (GameSettings bits 4-6 = 20h, or 10h with SeasonActive
; set); clockcont_0 and the cup code use it
;-----------------------------------------------------------------------------
IsPlayoffGame:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 20h
        je short .1
        cmp eax, byte 10h
        jne short .2
        cmp dword [SeasonActive], byte 0
        je short .2
.1:
        mov eax, 1
        ret
.2:
        xor eax, eax
        ret
;-----------------------------------------------------------------------------
; RefreshPlayerModel                              119A8  97 PC, low confidence
; Refreshes a player's model and textures
;-----------------------------------------------------------------------------
RefreshPlayerModel:
        push ecx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 8
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov esi, edx
        mov word [byte esp+04h], bx
        cmp word [dword eax+0A9h], byte 0
        jne short .1
        xor eax, eax
        mov edx, 1
        mov al, byte [dword ecx+0A4h]
        call RefreshFaceTextures
        cmp byte [dword ecx+0D0h], 0
        sete al
        xor edx, edx
        mov dl, al
        xor eax, eax
        mov al, byte [dword ecx+0A4h]
        xor ebx, ebx
        call UpdateFaceTextures
        lea edx, [byte esi+08h]
        xor eax, eax
        mov bl, byte [dword esi+0BCh]
        mov al, byte [dword ecx+0A4h]
        call DrawJerseyLettering
        mov eax, ecx
        call GetPlayerJerseyNumber
        mov bl, byte [dword ecx+0BFh]
        mov edx, eax
        test bl, 40h
        setne al
        and eax, 0FFh
        call LoadGoalieMask
        jmp near .9
.1:
        xor eax, eax
        xor edx, edx
        mov al, byte [dword ecx+0A4h]
        call RefreshFaceTextures
        xor edx, edx
        xor eax, eax
        mov dl, byte [dword ecx+0D0h]
        mov al, byte [dword ecx+0A4h]
        xor ebx, ebx
        call UpdateFaceTextures
        lea edx, [byte esi+08h]
        xor eax, eax
        mov bl, byte [dword esi+0BCh]
        mov al, byte [dword ecx+0A4h]
        call DrawJerseyLettering
        test byte [gmode], 1
        jne short .2
        cmp dword [ReplayPlaying], byte 0
        je short .3
.2:
        xor eax, eax
        lea edx, [byte esi+027h]
        mov al, byte [dword ecx+0A4h]
        call SetupPlayerModel
.3:
        mov eax, 48h
        mov ebx, dword [byte esp+04h]
        sub eax, ebx
        mov word [byte esp+04h], ax
        cmp ax, 6
        jle short .4
        mov word [byte esp+04h], 6
        jmp short .5
.4:
        mov eax, dword [byte esp+02h]
        sar eax, 10h
        cmp eax, byte 0FFFFFFFAh
        jge short .5
        mov word [byte esp+04h], 0FFFAh
.5:
        fild word [byte esp+04h]
        fmul qword [F64_0p013]
        fld1
        fsubrp
        mov dx, word [DebugModelIndex]
        fstp dword [esp]
        cmp dx, byte 14h
        jl short .6
        cmp dx, byte 32h
        jl short .7
        mov word [DebugModelIndex], 32h
        jmp short .7
.6:
        mov eax, dword [DebugModelRefresh]
        sar eax, 10h
        cmp eax, byte 0FFFFFFECh
        jg short .8
        cmp eax, byte 0FFFFFFCEh
        jg short .7
        mov word [DebugModelIndex], 0FFCEh
.7:
        fild word [DebugModelIndex]
        fmul qword [F64_0p01]
        fld1
        fsubrp
        fmul dword [esp]
        fstp dword [esp]
.8:
        xor eax, eax
        mov al, byte [dword ecx+0A4h]
        push dword [esp]
        call SetModelSlotValue
.9:
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; setplayer                                      11B38  94G, medium confidence
; (player, roster index) brings a player onto the ice: pnum
; (+0A6h), marks him in the team's line table (+50h, 8001h / 8002h)
;-----------------------------------------------------------------------------
setplayer:
        push ebx
        push ecx
        push esi
        push edi
        sub esp, byte 4
        mov ecx, eax
        mov ebx, edx
        mov ah, byte [dword eax+0C0h]
        movsx edi, dx
        and ah, 0BEh
        mov edx, edi
        mov byte [dword ecx+0C0h], ah
        mov eax, ecx
        call PickBenchSeat
        mov esi, dword [dword ecx+0FEh]
        mov byte [dword ecx+0A6h], bl
        mov ax, word [byte esi+edi*2+050h]
        test ah, 80h
        jne short .1
        mov edx, 14h
        jmp short .2
.1:
        cmp ax, 8002h
        jne short .3
        mov edx, 16h
.2:
        mov eax, ecx
        call assinsert
        and byte [dword ecx+0BFh], 0DFh
.3:
        movsx eax, bx
        mov word [byte esi+eax*2+050h], 8001h
        cmp bx, byte 19h
        jge near .14
        imul eax, dword 125h
        mov edx, dword [dword esi+0108h]
        add edx, 0A3h
        lea esi, [edx+eax]
        mov al, byte [dword esi+0BEh]
        xor ebx, ebx
        and al, 1
        lea edx, [dword esi+0E6h]
        mov bl, al
        mov ah, byte [edx]
        test ah, ah
        sete al
        mov byte [dword ecx+0D0h], al
        mov al, byte [byte edx+01h]
        mov byte [dword ecx+0C4h], al
        test ebx, ebx
        je short .4
        test al, al
        jbe short .4
        mov ah, al
        dec ah
        mov byte [dword ecx+0C4h], ah
.4:
        mov al, byte [byte edx+02h]
        mov byte [dword ecx+0C3h], al
        test ebx, ebx
        je short .5
        test al, al
        jbe short .5
        mov ah, al
        dec ah
        mov byte [dword ecx+0C3h], ah
.5:
        mov al, byte [byte edx+03h]
        mov byte [dword ecx+0C2h], al
        mov al, byte [byte edx+04h]
        mov byte [dword ecx+0C7h], al
        test ebx, ebx
        je short .6
        test al, al
        jbe short .6
        mov ah, al
        dec ah
        mov byte [dword ecx+0C7h], ah
.6:
        mov al, byte [byte edx+05h]
        mov byte [dword ecx+0CFh], al
        test ebx, ebx
        je short .7
        test al, al
        jbe short .7
        mov ah, al
        dec ah
        mov byte [dword ecx+0CFh], ah
.7:
        mov al, byte [byte edx+06h]
        mov byte [dword ecx+0CBh], al
        test ebx, ebx
        je short .8
        test al, al
        jbe short .8
        mov ah, al
        dec ah
        mov byte [dword ecx+0CBh], ah
.8:
        mov al, byte [byte edx+07h]
        mov byte [dword ecx+0C8h], al
        mov al, byte [byte edx+08h]
        mov byte [dword ecx+0C9h], al
        mov al, byte [byte edx+09h]
        mov byte [dword ecx+0C5h], al
        xor al, 0Fh
        and eax, 0FFh
        add eax, byte 0Fh
        sar eax, 1
        mov dword [esp], eax
        mov al, byte [esp]
        mov byte [dword ecx+0C5h], al
        mov al, byte [byte edx+0Ah]
        mov byte [dword ecx+0C6h], al
        xor al, 0Fh
        and eax, 0FFh
        add eax, byte 0Fh
        sar eax, 1
        mov dword [esp], eax
        mov al, byte [esp]
        mov byte [dword ecx+0C6h], al
        mov al, byte [byte edx+0Bh]
        mov byte [dword ecx+0CDh], al
        mov al, byte [byte edx+0Ch]
        mov byte [dword ecx+0CCh], al
        test ebx, ebx
        je short .9
        test al, al
        jbe short .9
        mov ah, al
        dec ah
        mov byte [dword ecx+0CCh], ah
.9:
        mov al, byte [byte edx+0Fh]
        mov byte [dword ecx+0D1h], al
        mov al, byte [byte edx+0Dh]
        mov byte [dword ecx+0CAh], al
        mov al, byte [byte edx+010h]
        mov byte [dword ecx+0CEh], al
        cmp al, 7
        jbe short .10
        mov byte [dword ecx+0CEh], 7
.10:
        mov ah, byte [byte edx+016h]
        test ah, ah
        je short .11
        mov byte [dword ecx+0BEh], 64h
        jmp short .13
.11:
        mov al, byte [byte edx+0Eh]
        imul eax, eax
        cwde
        call randomd0
        cwde
        sar eax, 2
        test ebx, ebx
        je short .12
        add eax, byte 0Ah
.12:
        mov byte [dword ecx+0BEh], al
.13:
        mov ebx, dword [byte edx+0Fh]
        mov eax, ecx
        sar ebx, 10h
        mov edx, esi
        call RefreshPlayerModel
        add esp, byte 4
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.14:
        sub eax, byte 19h
        imul eax, dword 125h
        mov edx, dword [dword esi+0108h]
        add edx, 1D42h
        add eax, edx
        mov bl, byte [dword eax+0BEh]
        and bl, 1
        lea edx, [dword eax+0E6h]
        movzx esi, bl
        mov bh, byte [edx]
        test bh, bh
        sete bl
        mov byte [dword ecx+0D0h], bl
        mov bl, byte [byte edx+01h]
        mov byte [dword ecx+0CEh], bl
        mov bl, byte [byte edx+02h]
        mov byte [dword ecx+0C9h], bl
        mov bl, byte [byte edx+03h]
        mov byte [dword ecx+0CAh], bl
        mov bl, byte [byte edx+04h]
        mov byte [dword ecx+0CCh], bl
        test esi, esi
        je short .18
        mov bl, byte [dword ecx+0CEh]
        test bl, bl
        jbe short .15
        mov bh, bl
        dec bh
        mov byte [dword ecx+0CEh], bh
.15:
        mov bl, byte [dword ecx+0C9h]
        test bl, bl
        jbe short .16
        mov bh, bl
        dec bh
        mov byte [dword ecx+0C9h], bh
.16:
        mov bl, byte [dword ecx+0CAh]
        test bl, bl
        jbe short .17
        mov bh, bl
        dec bh
        mov byte [dword ecx+0CAh], bh
.17:
        mov bl, byte [dword ecx+0CCh]
        test bl, bl
        jbe short .18
        mov bh, bl
        dec bh
        mov byte [dword ecx+0CCh], bh
.18:
        mov bl, byte [byte edx+0Ch]
        mov byte [dword ecx+0CBh], bl
        test esi, esi
        je short .19
        test bl, bl
        jbe short .19
        mov bh, bl
        dec bh
        mov byte [dword ecx+0CBh], bh
.19:
        mov bl, byte [byte edx+05h]
        mov byte [dword ecx+0C4h], bl
        test esi, esi
        je short .20
        test bl, bl
        jbe short .20
        mov bh, bl
        dec bh
        mov byte [dword ecx+0C4h], bh
.20:
        mov bl, byte [byte edx+06h]
        mov byte [dword ecx+0C3h], bl
        test esi, esi
        je short .21
        test bl, bl
        jbe short .21
        mov bh, bl
        dec bh
        mov byte [dword ecx+0C3h], bh
.21:
        mov bl, byte [byte edx+07h]
        mov byte [dword ecx+0C2h], bl
        mov bl, byte [byte edx+08h]
        mov byte [dword ecx+0C5h], bl
        xor bl, 0Fh
        and ebx, 0FFh
        add ebx, byte 0Fh
        sar ebx, 1
        mov dword [esp], ebx
        mov bl, byte [esp]
        mov byte [dword ecx+0C5h], bl
        mov bl, byte [byte edx+09h]
        mov byte [dword ecx+0C6h], bl
        xor bl, 0Fh
        and ebx, 0FFh
        add ebx, byte 0Fh
        sar ebx, 1
        mov dword [esp], ebx
        mov bl, byte [esp]
        mov byte [dword ecx+0C6h], bl
        mov bl, byte [byte edx+0Ah]
        mov byte [dword ecx+0CDh], bl
        mov bl, byte [byte edx+0Ch]
        mov byte [dword ecx+0C7h], bl
        mov bl, byte [byte edx+012h]
        test bl, bl
        je short .22
        mov byte [dword ecx+0BEh], 64h
        jmp short .23
.22:
        mov byte [dword ecx+0BEh], bl
.23:
        mov edx, eax
        xor ebx, ebx
        mov eax, ecx
        call RefreshPlayerModel
        add esp, byte 4
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; reenergizeteam                                 11ED8  94G, medium confidence
; every player's energy back to 1000h
;-----------------------------------------------------------------------------
reenergizeteam:
        push ebx
        push ecx
        push edx
        push esi
        mov ecx, eax
        lea edx, [byte eax+018h]
        xor eax, eax
.1:
        movsx ebx, ax
        add ebx, ebx
        add ebx, ecx
        mov word [edx], 1000h
        mov si, word [byte ebx+050h]
        add edx, byte 2
        cmp si, 8003h
        jne short .2
        mov word [byte ebx+050h], 8002h
.2:
        inc eax
        cmp ax, 1Ch
        jl short .1
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetupTeamForIntermission       11F10  93G penalty93_2.asm, medium confidence
; ResetBench, reenergizeteam both teams, tmline
; 0/3/5 by tmap difference
;-----------------------------------------------------------------------------
SetupTeamForIntermission:
        push ebx
        push ecx
        push edx
        push esi
        call ResetBench
        mov edx, hmtmstruct
        mov ecx, awtmstruct
        xor ebx, ebx
.1:
        mov eax, edx
        call reenergizeteam
        mov word [byte edx+02h], 0
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 0C0h
        je short .3
        mov si, word [byte ecx+0Eh]
        mov ax, word [byte edx+0Eh]
        sub ax, si
        je short .3
        test ax, ax
        jle short .2
        mov word [byte edx+02h], 4
        jmp short .3
.2:
        mov word [byte edx+02h], 6
.3:
        mov ecx, hmtmstruct
        inc ebx
        mov edx, awtmstruct
        cmp bx, byte 2
        jl short .1
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ResetForIntermission                            11F74  97 PC, low confidence
; Resets the scene for the intermission
;-----------------------------------------------------------------------------
ResetForIntermission:
        push ebx
        push edx
        call SetupTeamForIntermission
        mov ebx, 0C57F0000h
        xor eax, eax
.1:
        movsx edx, ax
        imul edx, dword 108h
        inc eax
        mov dword [dword edx+PlayerPointsTable], ebx
        cmp ax, 0Dh
        jl short .1
        call ResetSceneCamera
        mov edx, dword [PtrPuckObject]
        cmp dword [byte edx+05Ah], byte 0FFFFFFFFh
        je short .2
        xor eax, eax
        call UpdateGameDisplay
.2:
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SeatBenchPlayer                                 11FB4  97 PC, low confidence
; Seats a player on the bench
;-----------------------------------------------------------------------------
SeatBenchPlayer:
        push ebx
        push edx
        push esi
        xor ebx, ebx
        xor esi, esi
.1:
        cmp esi, byte 0Ch
        jge short .2
        cmp word [dword ebx+PlayerAssignWords], byte 0
        jge short .2
        mov eax, ebx
        mov edx, 0FFFFFFFFh
        add eax, SortCords
        call PickBenchSeat
.2:
        mov eax, ebx
        xor edx, edx
        add eax, SortCords
.3:
        inc edx
        mov byte [eax], 0
        inc eax
        cmp edx, 108h
        jb short .3
        inc esi
        add ebx, 108h
        cmp esi, byte 10h
        jl short .1
        xor ebx, ebx
.4:
        mov edx, ebx
        xor eax, eax
        add edx, BenchPlayerTable
.5:
        inc eax
        mov byte [edx], 0
        inc edx
        cmp eax, byte 39h
        jb short .5
        add ebx, byte 39h
        cmp ebx, 390h
        jne short .4
        pop esi
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ResetPlayers                                    12024  97 PC, low confidence
; Resets the players and their animations
;-----------------------------------------------------------------------------
ResetPlayers:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        and esp, byte 0FFFFFFF8h
        call SeatBenchPlayer
        mov ebx, ResetPlayerSpots
        mov edx, SortCords
        xor ecx, ecx
        xor esi, esi
        xor edi, edi
        mov dword [byte esp+04h], ecx
        mov dword [esp], ecx
.1:
        mov byte [dword edx+0A6h], 0FFh
        mov byte [dword edx+0A7h], 0FFh
        mov byte [dword edx+0A8h], 0FFh
        mov eax, BenchPlayerTable
        mov byte [dword edx+0A4h], cl
        add eax, dword [byte esp+04h]
        mov dword [dword edx+0EEh], eax
        mov ax, word [ebx]
        add ebx, byte 2
        mov word [byte edx+06h], ax
        cmp ecx, byte 0Ch
        jge short .2
        mov word [byte edx+06h], 0EEA8h
.2:
        mov ax, word [ebx]
        add ebx, byte 2
        mov word [byte edx+0Ah], ax
        mov ax, word [ebx]
        add ebx, byte 2
        mov word [byte edx+0Eh], ax
        cmp ecx, byte 0Dh
        jne short .3
        mov dword [byte edx+050h], 40C00000h
        jmp short .4
.3:
        cmp ecx, byte 0Ch
        jge short .4
        sub word [byte edx+06h], 90h
        mov ah, byte [dword edx+0C1h]
        mov dword [byte edx+050h], 42900000h
        or ah, 1
        mov byte [dword edx+0C1h], ah
.4:
        fild word [byte edx+06h]
        fild word [byte edx+0Ah]
        fild word [byte edx+0Eh]
        fild word [byte edx+06h]
        mov eax, dword [dword edx+0EEh]
        fxch st3
        fstp dword [byte edx+020h]
        fxch
        fstp dword [byte edx+024h]
        fstp dword [byte edx+028h]
        fstp dword [eax]
        mov eax, dword [dword edx+0EEh]
        fild word [byte edx+0Eh]
        fstp dword [byte eax+04h]
        mov al, byte [ebx]
        mov byte [dword edx+0B2h], al
        mov al, byte [byte ebx+02h]
        add ebx, byte 2
        mov byte [dword edx+0BFh], al
        or al, 2
        add ebx, byte 2
        mov byte [dword edx+0BFh], al
        test al, 40h
        je short .5
        mov eax, awtmstruct
        jmp short .6
.5:
        mov eax, hmtmstruct
.6:
        mov dword [dword edx+0FEh], eax
        test byte [dword edx+0BFh], 40h
        je short .7
        mov eax, hmtmstruct
        jmp short .8
.7:
        mov eax, awtmstruct
.8:
        mov dword [dword edx+0102h], eax
        cmp ecx, byte 0Dh
        jge short .9
        mov eax, ObjectPositions
        add eax, dword [esp]
        mov dword [dword edx+0F2h], eax
        mov eax, GameObjects
        add eax, edi
        mov dword [dword edx+0F6h], eax
        mov eax, PlayerStartRecords
        add eax, esi
        mov dword [dword edx+0FAh], eax
        call ResetAnimTimer
        mov dword [dword esi+PlayerStartScale], 3F800000h
        mov dword [dword esi+PlayerStartDist], 461C4000h
        mov eax, edx
        call InitPlayerAnims
        jmp near .13
.9:
        mov dword [dword edx+0F2h], 0
        mov eax, PlayerStartRecords
        mov dword [dword edx+0F6h], 0
        add eax, esi
        mov dword [dword edx+0FAh], eax
        call ResetAnimTimer
        mov dword [dword esi+PlayerStartScale], 3F800000h
        mov dword [dword esi+PlayerStartDist], 461C4000h
        cmp ecx, byte 0Fh
        je short .10
        cmp ecx, byte 0Eh
        jne short .13
.10:
        cmp byte [dword edx+0A4h], 0Fh
        jne short .11
        mov dword [byte esp+08h], 5A7ED197h
        mov dword [byte esp+0Ch], 400921FBh
        jmp short .12
.11:
        xor eax, eax
        mov dword [byte esp+08h], eax
        mov dword [byte esp+0Ch], eax
.12:
        fld qword [byte esp+08h]
        fstp dword [byte edx+01Ch]
.13:
        mov eax, dword [byte esp+04h]
        add esi, byte 3Ch
        add eax, byte 39h
        add edi, byte 4
        mov dword [byte esp+04h], eax
        mov eax, dword [esp]
        inc ecx
        add eax, 760h
        add edx, 108h
        mov dword [esp], eax
        cmp ecx, byte 10h
        jl near .1
        mov eax, dword [PtrPuckObject]
        mov word [dword eax+0A9h], 0FFFFh
        mov eax, dword [PtrPuckObject]
        mov dword [byte eax+050h], 42900000h
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0D0h], 0
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0C4h], 0Ah
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0C3h], 0Ah
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0C2h], 5
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0C7h], 0Ah
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0CFh], 0Ah
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0CBh], 0Ah
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0C8h], 0Ah
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0C9h], 0Ah
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0C5h], 0Ah
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0C6h], 0Ah
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0CDh], 0Ah
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0CCh], 0Ah
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0D1h], 0Ah
        mov eax, dword [PtrPuckObject]
        mov byte [dword eax+0CAh], 2
        mov eax, dword [PtrPuckObject]
        mov edx, 0FFFFFFFFh
        mov byte [dword eax+0CEh], 0
        mov word [HomeIceSlots], dx
        mov word [AwayIceSlots], dx
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ResetPlayersForPeriod                           12334  97 PC, low confidence
; Resets the players for a new period
;-----------------------------------------------------------------------------
ResetPlayersForPeriod:
        push ebx
        push ecx
        push edx
        call ResetPlayers
        test byte [gmode], 2
        je short .2
        mov eax, SortCords
        xor edx, edx
.1:
        mov bl, byte [dword eax+0BFh]
        add eax, 108h
        xor bl, 80h
        inc edx
        mov byte [byte eax-049h], bl
        cmp dx, byte 0Ch
        jl short .1
.2:
        mov ebx, 0FFFFFFFFh
        xor eax, eax
.3:
        movsx edx, ax
        inc eax
        mov word [nosplit edx*2+SlotAssign], bx
        cmp ax, 8
        jl short .3
        mov ecx, 0FFFFFFFFh
        xor eax, eax
.4:
        movsx edx, ax
        imul edx, dword 108h
        inc eax
        mov word [dword edx+PlayerControlWords], cx
        cmp ax, 10h
        jl short .4
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReplaceFaceoffPlayers                           123A0  97 PC, low confidence
; Replaces the faceoff players
;-----------------------------------------------------------------------------
ReplaceFaceoffPlayers:
        push ebx
        push ecx
        push edx
        push esi
        mov edx, hmtmstruct
        xor ebx, ebx
        xor esi, esi
.1:
        mov cl, byte [byte edx+016h]
        and cl, 0EFh
        mov eax, dword [dword edx+0104h]
        mov byte [byte edx+016h], cl
        mov edx, esi
.2:
        mov cx, word [dword eax+0A9h]
        mov byte [dword eax+0C0h], 0
        test cx, cx
        jl short .3
        mov ch, byte [dword eax+0BFh]
        mov dword [byte eax+064h], 0
        and ch, 0C2h
        mov byte [dword eax+0BFh], ch
.3:
        inc edx
        add eax, 108h
        cmp edx, byte 6
        jl short .2
        inc ebx
        mov edx, awtmstruct
        cmp ebx, byte 2
        jl short .1
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
ReplaceFaceoffPlayers_62:
        mov edx, dword [dword ebx+0AEh]
        sar edx, 18h
        cmp byte [dword edx+ebx+0B2h], 13h
        je short ReplaceFaceoffPlayers_81
        mov edx, 1
        mov eax, ebx
        call assreplace
ReplaceFaceoffPlayers_81:
        add ebx, 108h
        mov byte [byte ebx-060h], 0FFh
        inc ecx
        mov byte [byte ebx-061h], 0FFh
        cmp ecx, byte 6
        jl near forcepldata_E
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PlayerInLine                                    12440  97 PC, low confidence
; Returns whether a player is in a line
;-----------------------------------------------------------------------------
PlayerInLine:
        push ecx
        mov ecx, edx
        movsx edx, dx
        mov ax, word [byte eax+edx*2+050h]
        test byte [gmode], 1
        jne short .1
        test ah, 8
        jne short .2
.1:
        movsx edx, ax
        test dh, 80h
        je short .2
        xor ah, ah
        and al, 0Fh
        cmp ax, 3
        jl short .3
.2:
        xor eax, eax
        pop ecx
        ret
.3:
        mov eax, 5
.4:
        cmp ax, bx
        je short .5
        movsx edx, ax
        movsx dx, byte [dword edx+LinePlayersHome]
        cmp cx, dx
        jne short .5
        xor eax, eax
        pop ecx
        ret
.5:
        dec eax
        test ax, ax
        jge short .4
        movsx eax, bx
        mov byte [dword eax+LinePlayersHome], cl
        mov eax, 1
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PickLinePlayers                                 124A4  97 PC, low confidence
; Picks the players of the current line
;-----------------------------------------------------------------------------
PickLinePlayers:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        mov esi, eax
        mov bl, 0FFh
        mov ax, word [byte eax+02h]
        mov ebp, dword [dword esi+0108h]
        xor edx, edx
        mov dword [byte esp+0Ch], eax
        add ebp, 20EDh
        mov word [byte esp+08h], dx
        xor eax, eax
.1:
        movsx edx, ax
        inc eax
        mov byte [dword edx+LinePlayersHome], bl
        cmp ax, 6
        jl short .1
        cmp word [penshotmode], byte 0
        je short .2
        cmp esi, awtmstruct
        sete al
        mov edx, dword [puckx]
        and eax, 0FFh
        sar edx, 10h
        cmp edx, eax
        jne short .3
.2:
        cmp word [byte esi+010h], byte 0
        jge short .3
        mov word [byte esp+08h], 1
        jmp short .4
.3:
        mov word [byte esi+06h], 0FFFFh
.4:
        mov di, word [byte esi+0Eh]
.5:
        dec edi
        test di, di
        jl near .13
        mov ebx, dword [byte esp+06h]
        movsx edx, di
        sar ebx, 10h
        movsx ax, byte [dword edx+ebx+LinePickOrder]
        mov bl, byte [dword edx+ebx+LinePickOrder]
        mov byte [dword edx+LinePlayersAway], bl
        test ax, ax
        jne short .6
        movsx ebx, ax
        mov ax, word [byte esi+010h]
        xor ah, ah
        mov ebx, dword [nosplit ebx*2+LinePlayerSlots]
        and al, 1
        sar ebx, 10h
        cwde
        mov eax, dword [dword ebx+eax+LinePlayerOffsets]
        sar eax, 18h
        mov al, byte [eax+ebp]
        mov bh, al
        mov byte [dword edx+LinePlayersHome], al
        add bh, 19h
        mov byte [dword edx+LinePlayersHome], bh
        jmp short .5
.6:
        cmp ax, 6
        jne short .7
        mov al, byte [byte ebp+024h]
        mov byte [dword edx+LinePlayersHome], al
        jmp short .5
.7:
        cmp word [byte esp+0Ch], byte 4
        jge short .8
        cmp ax, 2
        jg short .8
        cwde
        mov ebx, dword [nosplit eax*2+LinePlayerSlots]
        mov eax, dword [byte esi+02h]
        sar ebx, 10h
        sar eax, 10h
        mov eax, dword [dword ebx+eax+LinePlayerOffsets]
        sar eax, 18h
        mov al, byte [eax+ebp]
        mov byte [dword edx+LinePlayersHome], al
        jmp near .5
.8:
        mov edx, dword [byte esp+0Ch]
        cmp dx, byte 4
        jl short .9
        cmp dx, byte 5
        jg short .9
        cmp word [byte esi+010h], byte 0
        setge bl
        mov ecx, dword [byte esi+0Ch]
        sar ecx, 10h
        and ebx, 0FFh
        sub ecx, ebx
        cmp ecx, byte 5
        jge short .9
        cmp ax, 5
        jl short .10
.9:
        cmp word [byte esp+0Ch], byte 6
        jl short .11
        cmp word [byte esi+010h], byte 0
        setge bl
        mov ecx, dword [byte esi+0Ch]
        sar ecx, 10h
        and ebx, 0FFh
        sub ecx, ebx
        cmp ecx, byte 4
        jge short .11
        cmp ax, 5
        jge short .11
        cmp ax, 3
        je short .11
.10:
        add edx, byte 2
.11:
        cmp word [byte esp+0Ch], byte 6
        jl short .12
        cmp ax, 5
        jge short .12
        add edx, byte 2
.12:
        cwde
        mov ebx, dword [nosplit eax*2+LinePlayerSlots]
        sar ebx, 10h
        movsx eax, dx
        mov eax, dword [dword ebx+eax+LinePlayerOffsets]
        sar eax, 18h
        movsx edx, di
        mov al, byte [eax+ebp]
        mov byte [dword edx+LinePlayersHome], al
        jmp near .5
.13:
        mov edi, 5
        cmp esi, awtmstruct
        sete byte [byte esp+010h]
.14:
        movsx ebx, di
        movsx cx, byte [dword ebx+LinePlayersHome]
        test cx, cx
        jl near .29
        movsx ax, byte [dword ebx+LinePlayersAway]
        movsx edx, cx
        mov word [byte esp+04h], ax
        mov eax, esi
        call PlayerInLine
        test ax, ax
        jne near .28
        mov eax, dword [byte esp+02h]
        sar eax, 10h
        mov ecx, dword [nosplit eax*2+LinePlayerSlots]
        sar ecx, 10h
        add ecx, LinePlayerOrder
.15:
        mov al, byte [ecx]
        inc ecx
        test al, al
        jge near .27
        xor dh, dh
        mov dl, byte [byte esp+010h]
        mov ecx, dword [byte esp+04h]
        mov eax, edx
        cmp cx, byte 6
        je short .16
        cmp word [byte esp+0Ch], byte 6
        jge short .20
.16:
        mov ecx, dword [byte esp+04h]
        cmp cx, byte 1
        je short .17
        cmp cx, byte 2
        jne short .18
.17:
        cwde
        imul eax, byte 19h
        mov edx, DefenseByOffense
        jmp short .19
.18:
        cwde
        imul eax, byte 19h
        mov edx, ForwardsByOffense
.19:
        add edx, eax
        jmp short .23
.20:
        cmp cx, byte 1
        je short .21
        cmp cx, byte 2
        jne short .22
.21:
        movsx edx, ax
        imul edx, byte 19h
        add edx, DefenseByDefense
        jmp short .23
.22:
        movsx eax, dx
        imul eax, byte 19h
        mov edx, ForwardsByDefense
        add edx, eax
.23:
        mov dword [esp], edx
        xor ecx, ecx
.24:
        mov ebx, dword [esp]
        movsx edx, cx
        add edx, ebx
        mov al, byte [edx]
        inc ecx
        mov byte [byte esp+014h], al
        test al, al
        jge short .26
        mov ecx, 18h
.25:
        mov byte [byte esp+014h], cl
        dec ecx
        test cx, cx
        jl short .28
        mov edx, dword [byte esp+011h]
        movsx ebx, di
        mov eax, esi
        sar edx, 18h
        call PlayerInLine
        test ax, ax
        je short .25
.26:
        mov edx, dword [byte esp+011h]
        movsx ebx, di
        mov eax, esi
        sar edx, 18h
        call PlayerInLine
        test ax, ax
        je short .24
        jmp short .28
.27:
        movsx edx, al
        mov al, byte [edx+ebp]
        movsx ebx, di
        movsx edx, al
        mov eax, esi
        call PlayerInLine
        test ax, ax
        je near .15
.28:
        cmp word [byte esp+04h], byte 6
        jne short .29
        movsx eax, di
        movsx ax, byte [dword eax+LinePlayersHome]
        mov word [byte esi+06h], ax
.29:
        dec edi
        test di, di
        jge near .14
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; setpersonel                                    127D4  94G, medium confidence
; clears the team's 6 on-ice slots and sets the
; personnel
;-----------------------------------------------------------------------------
setpersonel:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov eax, dword [dword eax+0104h]
        xor edx, edx
.1:
        add eax, 108h
        mov byte [byte eax-061h], 0FFh
        mov bl, byte [byte eax-061h]
        inc edx
        mov byte [byte eax-060h], bl
        cmp edx, byte 6
        jl short .1
        mov ecx, 7
        mov edx, 0FFFFFFFFh
        lea eax, [dword ebp+0ECh]
        call __STOSB
        mov eax, ebp
        mov edi, 5
        call PickLinePlayers
.2:
        mov ecx, dword [dword edi+PersonnelTable]
        sar ecx, 18h
        test ecx, ecx
        jl short .5
        mov ebx, dword [dword ebp+0104h]
        xor eax, eax
        sub ebx, 108h
.3:
        mov edx, dword [dword ebx+01ABh]
        sar edx, 18h
        add ebx, 108h
        cmp ecx, edx
        jne short .4
        mov al, byte [dword edi+LinePlayersAway]
        mov byte [dword ebx+0A8h], al
        mov byte [dword ebx+0A7h], dl
        mov byte [dword edi+LinePlayersHome], 0FFh
        mov eax, dword [dword ebx+0A5h]
        sar eax, 18h
        lea edx, [eax+ebp]
        mov al, byte [dword ebx+0A4h]
        mov byte [dword edx+0ECh], al
        jmp short .5
.4:
        inc eax
        cmp eax, byte 6
        jl short .3
.5:
        dec edi
        cmp edi, byte 0FFFFFFFFh
        jne short .2
        mov edi, 5
.6:
        mov ecx, dword [dword edi+PersonnelTable]
        sar ecx, 18h
        test ecx, ecx
        jl near .13
        mov ebx, dword [dword ebp+0104h]
        xor eax, eax
        sub ebx, 108h
.7:
        mov dl, byte [dword ebx+01AFh]
        add ebx, 108h
        test dl, dl
        jge short .8
        mov dx, word [dword ebx+0A9h]
        mov esi, ebx
        test dx, dx
        jge short .9
.8:
        inc eax
        cmp eax, byte 6
        jl short .7
.9:
        cmp word [dword esi+0A9h], byte 0
        jge short .12
        movsx edx, cx
        mov eax, esi
        call PickBenchSeat
        cmp word [penshotmode], byte 0
        je short .10
        mov edx, 19h
        mov dword [byte ebx+028h], 0
        mov eax, esi
        fld dword [byte ebx+028h]
        fstp dword [byte ebx+020h]
        call assreplace
        mov eax, esi
        call asspsclear
        jmp short .11
.10:
        mov edx, 1
        mov eax, esi
        mov dword [byte esi+020h], 0C58AC000h
        call assreplace
.11:
        mov word [dword esi+0A9h], 5
.12:
        mov al, byte [dword edi+LinePlayersAway]
        mov byte [dword esi+0A8h], al
        mov dh, 0FFh
        mov byte [dword esi+0A7h], cl
        mov byte [dword edi+LinePlayersHome], dh
        mov eax, dword [dword esi+0A5h]
        sar eax, 18h
        lea edx, [eax+ebp]
        mov al, byte [dword esi+0A4h]
        mov byte [dword edx+0ECh], al
.13:
        dec edi
        cmp edi, byte 0FFFFFFFFh
        jne near .6
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PeriodLengthSetting                             12970  97 PC, low confidence
; Returns the period length setting
;-----------------------------------------------------------------------------
PeriodLengthSetting:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 20h
        je short .1
        cmp eax, byte 10h
        jne short .2
        cmp dword [SeasonActive], byte 0
        je short .2
.1:
        mov eax, 1
        jmp short .3
.2:
        xor eax, eax
.3:
        test eax, eax
        jne short .4
        cmp word [gsp], byte 3
        jl short .4
        mov ax, word [PeriodLengths]
        ret
.4:
        mov eax, dword [GameOptionFlags]
        mov eax, dword [byte eax+01h]
        shl eax, 13h
        shr eax, 1Eh
        mov ax, word [nosplit eax*2+PeriodLengths]
        ret
        push ebx
        push edx
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 40h
        jne short .5
        mov eax, 12Ch
        jmp short .6
.5:
        call PeriodLengthSetting
        cwde
.6:
        mov ebx, 0Fh
        mov word [StatsPanelPlayer], ax
        mov word [gameclock], ax
        xor edx, edx
        mov ah, byte [gmode]
        mov word [StatsPanelOn], dx
        or ah, 1
        mov word [PeriodLength], bx
        mov byte [gmode], ah
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; RefreshRinkPalette                              12A10  97 PC, low confidence
; Refreshes the rink palette
;-----------------------------------------------------------------------------
RefreshRinkPalette:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        test eax, eax
        je short .1
        cmp word [gameclock], byte 0
        jne short .1
        cmp word [StatsPanelOn], byte 0
        jne short .1
        xor eax, eax
        jmp short .2
.1:
        mov ebx, dword [gsp]
        mov eax, dword [PassState]
        sar ebx, 10h
        sar eax, 10h
        sub eax, ebx
.2:
        mov ebx, dword [PassState]
        sar ebx, 10h
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        mov edx, esi
        call UpdateRinkPalette
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ClockTick                                    12A70  95 PC, medium confidence
; run from the main loop. Counts clockticks (18h per second) and gameclock down; horn sfx 97h at 60 s
; (unless music plays), UpdateCoachModes each second. Debug playback (penshotlive) ends via EndPenaltyShot.
;-----------------------------------------------------------------------------
ClockTick:
        push ebx
        push ecx
        push edx
        push esi
        cmp word [penshotlive], byte 0
        je short .1
        mov cx, word [penshottimer]
        dec ecx
        mov word [penshottimer], cx
        test cx, cx
        jg near .10
        call EndPenaltyShot
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        cmp word [gameclock], byte 0
        jne short .2
        cmp word [StatsPanelOn], byte 0
        je near .10
.2:
        mov si, word [StatsPanelOn]
        dec esi
        mov word [StatsPanelOn], si
        test si, si
        jge near .10
        mov ax, word [gameclock]
        test ax, ax
        jle short .3
        mov ecx, esi
        mov ebx, eax
        add ecx, byte 10h
        dec ebx
        mov word [StatsPanelOn], cx
        mov word [gameclock], bx
        jmp short .4
.3:
        xor edx, edx
        mov word [StatsPanelOn], dx
.4:
        cmp word [gameclock], byte 78h
        jge short .5
        mov edx, dword [LastTouchPlayer]
        mov eax, dword [gsp]
        push edx
        sar eax, 10h
        push eax
        mov eax, dword [LastPlayerTouch]
        sar eax, 10h
        push eax
        push dword 0A000001Ah
        call CommentaryEvent
        add esp, byte 10h
.5:
        cmp word [gameclock], byte 3Ch
        jne short .6
        mov eax, dword [LastPlayerTouch]
        sar eax, 10h
        push eax
        push dword 0C0000004h
        call PaEvent
        add esp, byte 8
.6:
        mov ebx, dword [PassState]
        mov eax, dword [gsp]
        sar ebx, 10h
        sar eax, 10h
        mov edx, ebx
        sub edx, eax
        mov eax, edx
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        xor edx, edx
        call UpdateRinkPalette
        mov edx, dword [gsp]
        sar edx, 10h
        mov ebx, 3Ch
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        test edx, edx
        jne short .9
        cmp word [gsp], byte 2
        jne short .7
        mov dx, word [gameclock]
        cmp dx, byte 3Ch
        je short .8
        cmp dx, byte 78h
        je short .8
        cmp dx, 0B4h
        je short .8
        cmp dx, 12Ch
        je short .8
        cmp dx, 258h
        je short .8
.7:
        cmp word [gsp], byte 1
        jne short .9
        cmp word [gameclock], 258h
        jne short .9
.8:
        call UpdateCoachModes
.9:
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 40h
        jne short .10
        cmp word [gameclock], byte 0
        jle short .10
        mov edx, dword [gsp]
        sar edx, 10h
        mov ebx, 5Ah
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        test edx, edx
        jne short .10
        mov eax, 7
        call randomd0
        cwde
        call ShowCameraView
.10:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StartPeriod                                     12C2C  97 PC, low confidence
; Starts a period
;-----------------------------------------------------------------------------
StartPeriod:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        cmp byte [ChantState], 0
        je short .1
        xor dl, dl
        call QueueMusicRestart
        mov byte [ChantState], dl
.1:
        xor edx, edx
        call StopAllSfx
        mov word [LineChangeAway], dx
        mov word [LineChangeHome], dx
        call ResetCoachModes
        call ResetPlayersForPeriod
        mov eax, dword [GameSettings]
        and eax, byte 70h
        cmp eax, byte 40h
        jne short .2
        mov eax, 12Ch
        jmp short .3
.2:
        call PeriodLengthSetting
        cwde
.3:
        mov esi, 0Fh
        mov dh, byte [gmode]
        mov di, word [gsp]
        mov word [StatsPanelPlayer], ax
        xor ecx, ecx
        mov word [gameclock], ax
        mov word [StatsPanelOn], cx
        or dh, 1
        mov word [PeriodLength], si
        mov byte [gmode], dh
        test di, di
        jle short .4
        mov eax, dword [LastPlayerTouch]
        sar eax, 10h
        inc eax
        push eax
        push dword 0A0000029h
        call CommentaryEvent
        add esp, byte 8
.4:
        mov eax, dword [PuckOwnerTeam]
        xor edx, edx
        sar eax, 10h
        call LogPeriodEnd
        cmp word [HomeGoalieOff], byte 0
        je short .5
        mov eax, dword [AwayGoalieOff]
        sar eax, 10h
        mov word [nosplit eax*2+SlotAssign], 2
        mov edx, 0FFFFFFFFh
        mov eax, HomeTeamRecord
        call SetPlayerTarget
        mov ax, word [HomeControlSlot]
        mov word [HomeTeamRecord+0BAh], ax
.5:
        cmp word [AwayGoalieOff], byte 0
        je short .6
        mov eax, dword [HomeControlSlot]
        mov ecx, 8
        sar eax, 10h
        mov edx, 0FFFFFFFFh
        mov word [nosplit eax*2+SlotAssign], cx
        mov eax, AwayTeamRecord
        call SetPlayerTarget
        mov ax, word [AwayControlSlot]
        mov word [AwayTeamRecord+0BAh], ax
.6:
        xor esi, esi
        mov ecx, 0FFFFFFFFh
        mov word [penshotmode], si
        mov word [penshotlive], si
        mov word [BenchRequest], si
        mov word [PuckZone], si
        mov word [OneTimerTarget], si
        mov word [FaceoffRequest], cx
        call ClearOverlayWindows
        mov ax, word [gsp]
        mov word [FaceoffZone], si
        mov word [FaceoffSpot], si
        test ax, ax
        jne short .7
        mov edx, 40h
        jmp short .8
.7:
        mov edx, 42h
.8:
        mov eax, dword [PtrPuckFlags]
        call assreplace
        call SetCameraMode
        mov bl, byte [PlayFlags]
        or bl, 4
        mov edx, 1
        mov byte [PlayFlags], bl
        call DoGameFrame
        call DoGameFrame
        mov dword [GameTick], edx
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FindStartingGoalies                             12DE8  97 PC, low confidence
; Finds the starting goalies
;-----------------------------------------------------------------------------
FindStartingGoalies:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edi, 0FFFFFFFFh
        mov ebp, hmtmstruct
        xor esi, esi
.1:
        mov edx, 6
        lea eax, [byte ebp+036h]
        lea ebx, [dword esi+0630h]
        lea ecx, [byte ebp-02h]
.2:
        test byte [byte eax+051h], 80h
        jne short .3
        test byte [byte eax+051h], 10h
        jne short .3
        cmp edx, byte 4
        jle short .3
        sub ebx, 108h
        dec edx
        mov word [dword ebx+PlayerAssignWords], di
.3:
        sub eax, byte 2
        cmp eax, ecx
        jne short .2
        add esi, 630h
        mov word [byte ebp+0Eh], dx
        mov ebp, awtmstruct
        cmp esi, 0C60h
        jne short .1
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReleaseBoxPlayers                               12E50  97 PC, low confidence
; At a stoppage (assrefwhistle, assrefgoalpa): players whose penalty is over
; get assignment 15h (assleavebox) inserted
;-----------------------------------------------------------------------------
ReleaseBoxPlayers:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov dx, word [penshotmode]
        mov ebx, SortCords
        test dx, dx
        je near .9
        xor ecx, ecx
        mov edi, 19h
        mov esi, 6
.1:
        mov ax, word [dword ebx+0A9h]
        test ax, ax
        jle short .4
        mov eax, dword [penshottimer]
        sar eax, 10h
        cmp ecx, eax
        je short .2
        cmp ecx, byte 6
        setl al
        xor edx, edx
        mov dl, al
        cmp si, word [FaceoffRequest]
        setg al
        and eax, 0FFh
        xor eax, edx
        je short .3
        cmp byte [dword ebx+0A8h], 0
        jne short .3
.2:
        mov edx, esi
        jmp short .6
.3:
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        add eax, ebx
        mov dl, byte [dword eax+0B2h]
        cmp dl, 1
        je short .8
        cmp dl, 1Ah
        je short .8
        jmp short .5
.4:
        jne short .8
        test byte [dword ebx+0BFh], 40h
        setne al
        xor edx, edx
        mov dl, al
        mov eax, dword [puckx]
        sar eax, 10h
        xor eax, edx
        je short .5
        mov edx, esi
        mov byte [dword ebx+0A7h], 0FFh
        mov eax, ebx
        mov byte [dword ebx+0A8h], 0FFh
        jmp short .7
.5:
        mov edx, edi
.6:
        mov eax, ebx
.7:
        call assinsert
.8:
        inc ecx
        add ebx, 108h
        cmp ecx, byte 0Ch
        jge near .20
        jmp near .1
.9:
        xor ecx, ecx
        mov edi, 6
        xor esi, esi
.10:
        cmp si, word [BenchRequest]
        je near .13
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        add eax, ebx
        cmp byte [dword eax+0B2h], 19h
        jne short .11
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 0C0h
        jne near .19
        mov edx, edi
        mov eax, ebx
        call assinsert
        mov edx, 16h
        jmp near .18
.11:
        mov dx, word [dword ebx+0A9h]
        cmp si, dx
        jge short .12
        mov byte [dword ebx+0A8h], 0FFh
        mov al, byte [dword ebx+0A8h]
        mov edx, 15h
        mov byte [dword ebx+0A7h], al
        jmp near .18
.12:
        jne near .19
        cmp byte [dword eax+0B2h], 1
        je near .19
        jmp near .17
.13:
        test byte [dword ebx+0C0h], 4
        jne near .19
        mov dx, word [dword ebx+0A9h]
        cmp si, dx
        jge short .16
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov dword [byte ebx+060h], esi
        mov eax, dword [dword ebx+eax+0AFh]
        sar eax, 18h
        cmp eax, byte 1
        je short .19
        cmp eax, byte 1Ah
        je short .19
        mov eax, dword [GameOptionFlags]
        test byte [byte eax+01h], 0C0h
        jne short .14
        mov eax, edi
        jmp short .15
.14:
        mov eax, 15h
.15:
        movsx edx, ax
        jmp short .18
.16:
        jne short .19
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        mov dword [byte ebx+060h], esi
        cmp byte [dword ebx+eax+0B2h], 1
        je short .19
.17:
        mov edx, edi
.18:
        mov eax, ebx
        call assinsert
.19:
        inc ecx
        add ebx, 108h
        cmp ecx, byte 0Ch
        jl near .10
.20:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
