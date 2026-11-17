; Animation files: skate, shot, action, fall, goalie, referee, fight and cup animations.
bits 32
%include "hockey.inc"
section s_65475 progbits alloc exec nowrite align=1
extern ActAnimData, ActAnimFrames, ActAnimIndex, ActAnimNames, AllocMemBlock, AnimDataBase, AnimPointIds, AnimPointNames
extern AnimPointTable, AnimPointUnset, BodyPointId, CupAnimData, CupAnimFrames, CupAnimIndex, CupAnimNames, DecodeAnimFile
extern DecodeAnimTree, F32_0p5_LoadSkateAnims, F64_0p6_LoadGoalieAnimFile, FallAnimData, FallAnimFrames, FallAnimIndex, FallAnimNames, FallAnimPtrs
extern FallAnimSlots, FightAnimData, FightAnimFrames, FightAnimIndex, FightAnimNames, FindAnimByName, FindModelPart, FistPointId
extern FreeMemBlock, GetAnimEntry, GoalieAnimData, GoalieAnimDataPtr, GoalieAnimFiles, GoalieAnimFrame, GoalieAnimFrames, GoalieAnimIndex
extern GoalieAnimNames, GoalieAnimPoses, GoalieAnimTime, GoalieMoveLimit, GoalieReachLimit, HeadPointId, hypot_, IF@ATAN2
extern InterferAnimData, InterferAnimFrames, InterferAnimIndex, InterferAnimNames, LoadAnimFile, MoveAnimIds, MoveContactFlags, MoveFlags
extern MoveFuncPair, MoveState, OpenResourceArchive, PlayerAnimBase, PlayerAnimMove, PlayerAnimScale, PlayerAnimSet, PlayerAnimSize
extern PlayerAnimTable, PunchPointId, RefAmbiAnimData, RefAmbiAnimFrames, RefAmbiAnimIndex, RefAmbiAnimNames, RefCallAnimData, RefCallAnimFrames
extern RefCallAnimIndex, RefCallAnimNames, RefSkateAnimData, RefSkateAnimFrames, RefSkateAnimIndex, RefSkateAnimNames, ReplayFrames, ResetAnimTimer
extern SaveGamePalette, SetArtArchive, ShotAnimData, ShotAnimIndex, ShotAnimNames, ShotAnimPoses, SkateAnimBase, SkateAnimCount
extern SkateAnimData, SkateAnimFrames, SkateAnimIndex, SkateAnimMem, SkateAnimMemSize, SkateAnimNames, SkateAnimScale, SkateAnimSteps
extern SkateAnimStops, SkateAnimTurns, SkateForwardMove, StartAnimNow, StickPointId, StopTableBackward, StopTableForward, str_ANIMSVIV
extern str_Chin, str_Cup2, str_Fight, str_Goalie, str_Interfer, str_Lshldr, str_Origin, str_PlAct
extern str_PlFall, str_Puck3, str_Puckh, str_Punct_LoadAnimData, str_Refambi, str_Refcalls, str_Refskate, str_Rhand
extern str_Rshldr, str_Skate, str_Stickheel, str_Stop, str_Tmp, SwingPointId, UpdateAllPoses, ZeroMem
global GoalieAnimBlank, LoadAnimData, LoadAnimData_228, GetStopTable, LoadSkateAnimFile, LoadAnimByName, ShotAnimFramesJumpTable, ShotAnimFrames
global ShotAnimFrames_10, ShotAnimFrames_1D, ShotAnimFrames_25, ShotAnimFrames_32, ShotAnimFrames_3F, ShotAnimFrames_4C, ShotAnimFrames_59, LoadSkateAnims
global LoadShotAnims, LoadShotAnims_2B, LoadActAnims, LoadFallAnims, LoadInterferAnims, LoadGoalieAnimFile, LoadGoalieAnimFile_167, LoadGoalieAnimFile_168
global LoadGoalieAnims, LoadRefSkateAnims, LoadRefCallAnims, LoadRefAmbiAnims, LoadFightAnims, LoadCupAnims, InitAnimPoints, FreeAnimTables
global InitPlayerAnims
GoalieAnimBlank:                                ; used by LoadGoalieAnimFile
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; LoadAnimData                                    65481  97 PC, low confidence
; Loads an animation file into memory
;-----------------------------------------------------------------------------
LoadAnimData:
        push ebx
        push ecx
        push esi
        push edi
        enter 20h, 0
        push eax
        mov ebx, edx
        movzx eax, byte [byte eax+0Dh]
        mov dword [byte ebp-01Ch], eax
        mov eax, edx
        mov ecx, 38h
        sub eax, AnimDataBase
        xor edx, edx
        div ecx
        push ecx
        push ebx
        mov dword [byte ebp-04h], eax
        call ZeroMem
        imul eax, dword [byte ebp-01Ch], byte 0Ch
        add esp, byte 8
        push byte 20h
        push eax
        push str_Tmp
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp-014h], eax
        mov ecx, eax
        mov edx, eax
        mov eax, dword [byte ebp-024h]
        call DecodeAnimFile
        mov eax, dword [byte ebp-04h]
        mov byte [dword eax+MoveFlags], 0FFh
        cmp eax, byte 62h
        jl short .1
        cmp eax, 88h
        jge short .1
        mov dword [nosplit eax*4+str_Punct_LoadAnimData], 0
.1:
        mov dword [byte ebp-018h], 0
        jmp near .9
.2:
        mov edx, eax
        mov eax, dword [byte ebp-024h]
        call GetAnimEntry
        mov edx, dword [byte ebp-04h]
        movzx eax, word [byte eax+02h]
        cmp byte [dword edx+MoveFlags], 0FFh
        jne short .3
        test al, 10h
        je short .3
        mov esi, dword [byte ebp-04h]
        mov dl, byte [byte ebp-018h]
        mov byte [dword esi+MoveFlags], dl
.3:
        cmp dword [byte ebp-04h], byte 62h
        jl short .5
        cmp dword [byte ebp-04h], 88h
        jge short .5
        test al, 1
        je short .4
        cmp dword [byte ebp-018h], byte 1
        jle short .4
        mov al, byte [byte ebp-018h]
        mov edx, dword [byte ebp-04h]
        dec al
        mov byte [dword edx+MoveContactFlags], al
.4:
        mov edx, dword [byte ebp-04h]
        shl edx, 2
        fld dword [byte ecx+08h]
        fcomp dword [dword edx+str_Punct_LoadAnimData]
        fnstsw ax
        sahf
        jbe short .6
        mov eax, dword [byte ecx+08h]
        mov dword [dword edx+str_Punct_LoadAnimData], eax
        jmp short .6
.5:
        cmp dword [byte ebp-04h], 88h
        jl short .6
        cmp dword [byte ebp-04h], 9Bh
        jge short .6
        test al, 1
        je short .6
        cmp dword [byte ebp-018h], byte 1
        jle short .6
        mov al, byte [byte ebp-018h]
        mov edx, dword [byte ebp-04h]
        dec al
        mov byte [dword edx+MoveAnimIds], al
.6:
        fld dword [byte ecx+04h]
        fadd dword [byte ebx+0Ch]
        fst dword [byte ebx+0Ch]
        fadd dword [ecx]
        fstp dword [byte ebp-020h]
        fld dword [byte ecx+08h]
        fadd dword [byte ebx+010h]
        fstp dword [byte ebx+010h]
        cmp dword [byte ebp-018h], byte 0
        jne short .7
        mov eax, dword [byte ecx+08h]
        mov dword [byte ebx+028h], eax
        mov eax, dword [ecx]
        mov dword [byte ebx+02Ch], eax
        jmp short .8
.7:
        mov eax, dword [byte ebp-01Ch]
        dec eax
        cmp eax, dword [byte ebp-018h]
        jne short .8
        mov eax, dword [byte ecx+08h]
        mov dword [byte ebx+030h], eax
        mov eax, dword [byte ebp-020h]
        mov dword [byte ebx+034h], eax
.8:
        lea edi, [byte ebp-08h]
        lea esi, [byte ebp-0Ch]
        lea eax, [byte ebp-020h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte ecx+08h]
        fmul dword [byte ebp-0Ch]
        fld dword [byte ecx+08h]
        fxch
        fstp dword [ecx]
        fmul dword [byte ebp-08h]
        fld dword [ecx]
        fxch
        fstp dword [byte ecx+08h]
        fadd dword [ebx]
        inc dword [byte ebp-018h]
        fstp dword [ebx]
        fld dword [byte ecx+08h]
        fadd dword [byte ebx+08h]
        add ecx, byte 0Ch
        fstp dword [byte ebx+08h]
.9:
        mov eax, dword [byte ebp-018h]
        cmp eax, dword [byte ebp-01Ch]
        jl near .2
        mov eax, dword [byte ebp-04h]
        cmp byte [dword eax+MoveFlags], 0FFh
        jne short .11
        cmp dword [byte ebp-01Ch], byte 5
        jl short .10
        mov al, byte [byte ebp-01Ch]
        mov edx, dword [byte ebp-04h]
        sub al, 5
        mov byte [dword edx+MoveFlags], al
        jmp short .11
.10:
        mov byte [dword eax+MoveFlags], 0
.11:
        fld dword [byte ebx+08h]
        fld dword [ebx]
        call IF@ATAN2
        sub esp, byte 8
        fld dword [byte ebx+08h]
        fxch
        fstp dword [byte ebx+04h]
        fstp qword [esp]
        sub esp, byte 8
        fld dword [ebx]
        fstp qword [esp]
        call hypot_
        fstp dword [byte ebx+018h]
        cmp dword [byte ebp-01Ch], byte 0
        jne short .12
        mov dword [byte ebp-01Ch], 1
.12:
        fild dword [byte ebp-01Ch]
        fld dword [ebx]
        fld1
        fdivrp st2
        fmul st1
        fld dword [byte ebx+08h]
        fmul st2
        fld dword [byte ebx+0Ch]
        fmul st3
        fld dword [byte ebx+010h]
        fmulp st4
        push dword [byte ebp-014h]
        fxch st2
        fstp dword [byte ebx+014h]
        fstp dword [byte ebx+01Ch]
        fstp dword [byte ebx+020h]
        fstp dword [byte ebx+024h]
LoadAnimData_228:
        call FreeMemBlock
        add esp, byte 4
        leave
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; GetStopTable                                    656B7  97 PC, low confidence
; Returns an entry of one of the two stop tables
;-----------------------------------------------------------------------------
GetStopTable:
        push ebx
        mov ebx, eax
        cmp edx, byte 0Fh
        jne short .1
        mov eax, dword [StopTableForward]
        fld dword [eax+ebx*4]
        pop ebx
        ret
.1:
        mov eax, dword [StopTableBackward]
        fld dword [eax+ebx*4]
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadSkateAnimFile                               656D3  97 PC, low confidence
; Loads the skating animation file
;-----------------------------------------------------------------------------
LoadSkateAnimFile:
        push ebx
        push ecx
        push esi
        push edi
        enter 8, 0
        mov ebx, eax
        mov edi, edx
        movzx esi, byte [byte eax+0Dh]
        imul eax, esi, byte 0Ch
        push byte 20h
        push eax
        push str_Tmp
        call AllocMemBlock
        mov ecx, eax
        add esp, byte 0Ch
        mov dword [byte ebp-08h], eax
        mov edx, eax
        mov eax, ebx
        call DecodeAnimFile
        lea eax, [byte esi-01h]
        imul ebx, eax, byte 0Ch
        add ecx, ebx
        mov ebx, esi
        shl ebx, 2
        mov dword [byte ebp-04h], 0
        sub ebx, byte 4
        mov esi, eax
        add ebx, edi
        jmp short .2
.1:
        fld dword [byte ebp-04h]
        fadd dword [byte ecx+08h]
        dec esi
        fstp dword [byte ebp-04h]
        mov eax, dword [byte ebp-04h]
        sub ecx, byte 0Ch
        mov dword [ebx], eax
        sub ebx, byte 4
.2:
        test esi, esi
        jge short .1
        push dword [byte ebp-08h]
        jmp near LoadAnimData_228
;-----------------------------------------------------------------------------
; LoadAnimByName                                  65742  97 PC, low confidence
; Finds an animation by name and loads it
;-----------------------------------------------------------------------------
LoadAnimByName:
        push esi
        push edi
        enter 0Ch, 0
        mov esi, eax
        mov edi, edx
        mov dword [byte ebp-04h], ebx
        xor ebx, ebx
        jmp short .3
.1:
        mov eax, ebx
        shl eax, 2
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [byte ebp-04h]
        add eax, dword [byte ebp-0Ch]
        mov edx, dword [eax]
        mov eax, esi
        call FindAnimByName
        mov edx, eax
        mov eax, dword [byte ebp-0Ch]
        mov dword [ecx+eax], edx
        mov eax, edx
        movsx edx, word [byte eax+0Eh]
        mov dword [byte ebp-08h], edx
        test byte [byte ebp-08h], 10h
        jne short .2
        or byte [byte eax+0Eh], 20h
.2:
        imul edx, ebx, byte 38h
        mov eax, ebx
        shl eax, 2
        add edx, dword [byte ebp+010h]
        mov eax, dword [ecx+eax]
        inc ebx
        call LoadAnimData
.3:
        cmp ebx, edi
        jl short .1
        leave
        pop edi
        pop esi
        ret 4
ShotAnimFramesJumpTable:                        ; jump table for the switch cases of ShotAnimFrames
        dd ShotAnimFrames_10
        dd ShotAnimFrames_1D
        dd ShotAnimFrames_25
        dd ShotAnimFrames_32
        dd ShotAnimFrames_3F
        dd ShotAnimFrames_4C
        dd ShotAnimFrames_59
;-----------------------------------------------------------------------------
; ShotAnimFrames                                  657BF  97 PC, low confidence
; Returns the shot animation frames for a shot type
;-----------------------------------------------------------------------------
ShotAnimFrames:
        sub eax, byte 29h
        cmp eax, byte 6
        ja short ShotAnimFrames_59.2
        jmp dword [nosplit cs:eax*4+ShotAnimFramesJumpTable]
ShotAnimFrames_10:
        mov dword [edx], 15h
.1:
        mov dword [ebx], 1Eh
        ret
ShotAnimFrames_1D:
        mov dword [edx], 14h
        jmp short ShotAnimFrames_10.1
ShotAnimFrames_25:
        mov dword [edx], 12h
        mov dword [ebx], 1Dh
        ret
ShotAnimFrames_32:
        mov dword [edx], 10h
        mov dword [ebx], 1Ah
        ret
ShotAnimFrames_3F:
        mov dword [edx], 0Fh
        mov dword [ebx], 13h
        ret
ShotAnimFrames_4C:
        mov dword [edx], 0Bh
        mov dword [ebx], 14h
        ret
ShotAnimFrames_59:
        mov dword [edx], 0Dh
        mov dword [ebx], 10h
        ret
.2:
        mov dword [ebx], 0FFFFFFFFh
        mov eax, dword [ebx]
        mov dword [edx], eax
        ret
;-----------------------------------------------------------------------------
; LoadSkateAnims                               65830  97 PC, medium confidence
; InitAnimPoints: loads the "skate" animations (and "stop")
;-----------------------------------------------------------------------------
LoadSkateAnims:
        push ebx
        push ecx
        push edx
        mov edx, 20h
        mov eax, str_Skate
        mov ecx, MoveFuncPair
        mov ebx, SkateAnimNames
        call LoadAnimFile
        push AnimDataBase
        mov edx, 25h
        mov dword [SkateAnimData], eax
        call LoadAnimByName
        fld dword [SkateAnimTurns]
        fld dword [SkateAnimSteps]
        fadd dword [SkateAnimStops]
        fxch
        fadd dword [SkateAnimFrames]
        fxch
        fmul dword [F32_0p5_LoadSkateAnims]
        fxch
        fmul dword [F32_0p5_LoadSkateAnims]
        mov eax, dword [SkateAnimCount]
        fxch
        fstp dword [SkateAnimScale]
        fstp dword [SkateAnimBase]
        movzx eax, byte [byte eax+0Dh]
        push byte 20h
        shl eax, 2
        push eax
        push str_Stop
        call AllocMemBlock
        mov edx, eax
        mov dword [StopTableForward], eax
        mov eax, dword [SkateAnimCount]
        movzx ebx, byte [byte eax+0Dh]
        add esp, byte 0Ch
        mov dword [SkateAnimMem], ebx
        call LoadSkateAnimFile
        mov eax, dword [SkateAnimIndex]
        movzx eax, byte [byte eax+0Dh]
        push byte 20h
        shl eax, 2
        push eax
        push str_Stop
        call AllocMemBlock
        mov edx, eax
        mov dword [StopTableBackward], eax
        mov eax, dword [SkateAnimIndex]
        movzx ebx, byte [byte eax+0Dh]
        add esp, byte 0Ch
        mov dword [SkateAnimMemSize], ebx
        call LoadSkateAnimFile
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadShotAnims                                   6590A  97 PC, medium confidence
; Loads the shot animations from the puckh animation file into ShotAnimData
; and their poses by name
;-----------------------------------------------------------------------------
LoadShotAnims:
        push ebx
        push ecx
        push edx
        mov edx, 20h
        mov eax, str_Puckh
        mov ecx, ShotAnimIndex
        mov ebx, ShotAnimNames
        call LoadAnimFile
        push ShotAnimPoses
        mov edx, 19h
        mov dword [ShotAnimData], eax
LoadShotAnims_2B:
        call LoadAnimByName
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadActAnims                                 6593E  97 PC, medium confidence
; InitAnimPoints: loads the "pl_act" animations
;-----------------------------------------------------------------------------
LoadActAnims:
        push ebx
        push ecx
        push edx
        mov edx, 20h
        mov eax, str_PlAct
        mov ecx, ActAnimIndex
        mov ebx, ActAnimNames
        call LoadAnimFile
        push ActAnimFrames
        mov edx, 24h
        mov dword [ActAnimData], eax
        jmp short LoadShotAnims_2B
;-----------------------------------------------------------------------------
; LoadFallAnims                                6596B  97 PC, medium confidence
; InitAnimPoints: loads the "pl_fall" animations
;-----------------------------------------------------------------------------
LoadFallAnims:
        push ebx
        push ecx
        push edx
        push esi
        mov edx, 20h
        mov eax, str_PlFall
        mov ecx, FallAnimIndex
        mov ebx, FallAnimNames
        call LoadAnimFile
        xor esi, esi
        push FallAnimFrames
        mov edx, 26h
        mov dword [FallAnimData], eax
        call LoadAnimByName
.1:
        imul ecx, esi, byte 0Ch
        mov ebx, dword [BodyPointId]
        mov eax, dword [nosplit esi*4+FallAnimPtrs]
        xor edx, edx
        add ecx, FallAnimSlots
        inc esi
        call DecodeAnimTree
        cmp esi, byte 8
        jl short .1
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadInterferAnims                            659C6  97 PC, medium confidence
; InitAnimPoints: loads the "interfer" animations
;-----------------------------------------------------------------------------
LoadInterferAnims:
        push ebx
        push ecx
        push edx
        mov edx, 20h
        mov eax, str_Interfer
        mov ecx, InterferAnimIndex
        mov ebx, InterferAnimNames
        call LoadAnimFile
        push InterferAnimFrames
        mov edx, 13h
        mov dword [InterferAnimData], eax
        jmp near LoadShotAnims_2B
;-----------------------------------------------------------------------------
; LoadGoalieAnimFile                              659F6  97 PC, low confidence
; Loads the goalie animation file
;-----------------------------------------------------------------------------
LoadGoalieAnimFile:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 38h, 0
        push eax
        lea edi, [byte ebp-038h]
        mov eax, dword [nosplit eax*4+MoveAnimIds]
        mov esi, GoalieAnimBlank
        mov dword [byte ebp-014h], 0
        mov eax, dword [nosplit eax*4+MoveFuncPair]
        movsd
        movsd
        movsd
        mov dword [byte ebp-08h], eax
        movzx eax, byte [byte eax+0Dh]
        mov dword [byte ebp-0Ch], eax
        imul eax, byte 0Ch
        push byte 20h
        push eax
        push str_Tmp
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte ebp-010h], eax
        mov ebx, eax
        mov edx, eax
        mov eax, dword [byte ebp-08h]
        mov dword [byte ebp-04h], 0
        call DecodeAnimFile
        jmp short .2
.1:
        lea edi, [byte ebp-020h]
        mov edx, eax
        mov eax, dword [byte ebp-08h]
        lea esi, [byte ebp-018h]
        call GetAnimEntry
        fld dword [byte ebp-014h]
        fadd dword [byte ebx+04h]
        movzx ecx, word [byte eax+02h]
        fst dword [byte ebp-014h]
        fadd dword [ebx]
        lea eax, [byte ebp-01Ch]
        fstp dword [byte ebp-01Ch]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte ebx+08h]
        fmul dword [byte ebp-018h]
        fld dword [byte ebx+08h]
        fxch
        fstp dword [ebx]
        fmul dword [byte ebp-020h]
        fld dword [byte ebp-030h]
        fld dword [byte ebp-038h]
        fadd dword [ebx]
        fxch st2
        fstp dword [byte ebx+08h]
        fadd dword [byte ebx+08h]
        fxch
        fstp dword [byte ebp-038h]
        fstp dword [byte ebp-030h]
        test cl, 1
        jne short .3
        inc dword [byte ebp-04h]
        add ebx, byte 0Ch
.2:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [byte ebp-0Ch]
        jl short .1
.3:
        mov eax, dword [byte ebp-04h]
        cmp eax, dword [byte ebp-0Ch]
        jl short .4
        mov eax, dword [byte ebp-0Ch]
        dec eax
        mov dword [byte ebp-04h], eax
.4:
        fild dword [byte ebp-04h]
        fmul qword [F64_0p6_LoadGoalieAnimFile]
        mov ebx, dword [byte ebp-03Ch]
        mov eax, dword [byte ebp-04h]
        lea ecx, [byte ebp-02Ch]
        mov edx, eax
        mov dword [nosplit ebx*4+GoalieAnimFiles], eax
        fstp dword [nosplit ebx*4+GoalieAnimData]
        mov eax, dword [byte ebp-08h]
        mov ebx, dword [BodyPointId]
        call DecodeAnimTree
        imul ebx, dword [byte ebp-03Ch], byte 0Ch
        lea edi, [byte ebp-020h]
        lea esi, [byte ebp-018h]
        lea eax, [byte ebp-014h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte ebp-024h]
        fmul dword [byte ebp-018h]
        fld dword [byte ebp-024h]
        fmul dword [byte ebp-020h]
        fld dword [byte ebp-02Ch]
        fmul dword [byte ebp-020h]
        mov eax, dword [byte ebp-028h]
        fld dword [byte ebp-02Ch]
        mov dword [dword ebx+GoalieAnimFrame], eax
        fchs
        fmul dword [byte ebp-018h]
        push dword [byte ebp-010h]
        fxch
        faddp st3
        faddp
        fxch
        fadd dword [byte ebp-038h]
        fxch
        fadd dword [byte ebp-030h]
        fxch
        fstp dword [dword ebx+GoalieAnimTime]
        fstp dword [dword ebx+GoalieAnimPoses]
        call FreeMemBlock
        add esp, byte 4
LoadGoalieAnimFile_167:
        leave
LoadGoalieAnimFile_168:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadGoalieAnims                              65B64  97 PC, medium confidence
; InitAnimPoints: loads the "goalie" animations
;-----------------------------------------------------------------------------
LoadGoalieAnims:
        push ebx
        push ecx
        push edx
        mov edx, 20h
        mov eax, str_Goalie
        mov ecx, GoalieAnimIndex
        mov ebx, GoalieAnimNames
        call LoadAnimFile
        push GoalieAnimFrames
        mov edx, 6Ch
        mov dword [GoalieAnimDataPtr], eax
        call LoadAnimByName
        mov dword [GoalieReachLimit], 461C4000h
        mov dword [GoalieMoveLimit], 0BF800000h
        xor edx, edx
.1:
        mov ebx, edx
        mov eax, edx
        shl ebx, 2
        call LoadGoalieAnimFile
        fld dword [dword ebx+GoalieAnimData]
        fcomp dword [GoalieMoveLimit]
        fnstsw ax
        sahf
        jbe short .2
        mov eax, dword [dword ebx+GoalieAnimData]
        mov dword [GoalieMoveLimit], eax
.2:
        mov ebx, edx
        shl ebx, 2
        fld dword [dword ebx+GoalieAnimData]
        fcomp dword [GoalieReachLimit]
        fnstsw ax
        sahf
        jae short .3
        mov eax, dword [dword ebx+GoalieAnimData]
        mov dword [GoalieReachLimit], eax
.3:
        inc edx
        cmp edx, byte 22h
        jl short .1
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadRefSkateAnims                            65BFD  97 PC, medium confidence
; InitAnimPoints: loads the "refskate" animations
;-----------------------------------------------------------------------------
LoadRefSkateAnims:
        push ebx
        push ecx
        push edx
        mov edx, 20h
        mov eax, str_Refskate
        mov ecx, RefSkateAnimIndex
        mov ebx, RefSkateAnimNames
        call LoadAnimFile
        push RefSkateAnimFrames
        mov edx, 3Ch
        mov dword [RefSkateAnimData], eax
        jmp near LoadShotAnims_2B
;-----------------------------------------------------------------------------
; LoadRefCallAnims                             65C2D  97 PC, medium confidence
; InitAnimPoints: loads the "refcalls" animations
;-----------------------------------------------------------------------------
LoadRefCallAnims:
        push ebx
        push ecx
        push edx
        mov edx, 20h
        mov eax, str_Refcalls
        mov ecx, RefCallAnimIndex
        mov ebx, RefCallAnimNames
        call LoadAnimFile
        push RefCallAnimFrames
        mov edx, 0Fh
        mov dword [RefCallAnimData], eax
        jmp near LoadShotAnims_2B
;-----------------------------------------------------------------------------
; LoadRefAmbiAnims                             65C5D  97 PC, medium confidence
; InitAnimPoints: loads the "refambi" animations
;-----------------------------------------------------------------------------
LoadRefAmbiAnims:
        push ebx
        push ecx
        push edx
        mov edx, 20h
        mov eax, str_Refambi
        mov ecx, RefAmbiAnimIndex
        mov ebx, RefAmbiAnimNames
        call LoadAnimFile
        push RefAmbiAnimFrames
        mov edx, 6
        mov dword [RefAmbiAnimData], eax
        jmp near LoadShotAnims_2B
;-----------------------------------------------------------------------------
; LoadFightAnims                               65C8D  97 PC, medium confidence
; InitAnimPoints: loads the "fight" animations
;-----------------------------------------------------------------------------
LoadFightAnims:
        push ebx
        push ecx
        push edx
        mov edx, 20h
        mov eax, str_Fight
        mov ecx, FightAnimIndex
        mov ebx, FightAnimNames
        call LoadAnimFile
        push FightAnimFrames
        mov edx, 1Fh
        mov dword [FightAnimData], eax
        jmp near LoadShotAnims_2B
;-----------------------------------------------------------------------------
; LoadCupAnims                                 65CBD  97 PC, medium confidence
; Loads the "cup" animations (Stanley Cup presentation, from clockcont_0)
;-----------------------------------------------------------------------------
LoadCupAnims:
        push ebx
        push ecx
        push edx
        mov edx, 20h
        mov eax, str_Cup2
        mov ecx, CupAnimIndex
        mov ebx, CupAnimNames
        call LoadAnimFile
        push CupAnimFrames
        mov edx, 6
        mov dword [CupAnimData], eax
        jmp near LoadShotAnims_2B
;-----------------------------------------------------------------------------
; InitAnimPoints                                  65CED  97 PC, low confidence
; Looks up the animation attachment points (puck, stickheel, origin, chin,
; rhand, lshldr, rshldr) and loads ANIMS.VIV
;-----------------------------------------------------------------------------
InitAnimPoints:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ecx, 0Ah
        mov ebx, dword [ReplayFrames]
        mov edi, MoveState
        mov esi, AnimPointTable
        mov edx, str_Puck3
        mov eax, ebx
        rep movsd
        call FindModelPart
        mov edx, str_Stickheel
        mov dword [BodyPointId], eax
        mov eax, ebx
        call FindModelPart
        mov edx, str_Origin
        mov dword [StickPointId], eax
        mov eax, ebx
        call FindModelPart
        mov edx, str_Chin
        mov dword [AnimPointUnset], eax
        mov eax, ebx
        call FindModelPart
        mov edx, str_Rhand
        mov dword [PunchPointId], eax
        mov eax, ebx
        call FindModelPart
        mov edx, str_Lshldr
        mov dword [HeadPointId], eax
        mov eax, ebx
        call FindModelPart
        mov edx, str_Rshldr
        mov dword [SwingPointId], eax
        mov eax, ebx
        xor esi, esi
        call FindModelPart
        mov dword [FistPointId], eax
.1:
        mov eax, ebx
        mov edx, dword [nosplit esi*4+AnimPointNames]
        inc esi
        call FindModelPart
        mov dword [nosplit esi*4+AnimPointIds], eax
        cmp esi, byte 0Fh
        jl short .1
        mov eax, str_ANIMSVIV
        call SetArtArchive
        call LoadSkateAnims
        call LoadShotAnims
        call LoadActAnims
        call LoadFallAnims
        call LoadInterferAnims
        call LoadGoalieAnims
        call LoadRefSkateAnims
        call LoadRefAmbiAnims
        call LoadRefCallAnims
        call LoadFightAnims
        push byte 0
        call OpenResourceArchive
        add esp, byte 4
        jmp near LoadGoalieAnimFile_168
;-----------------------------------------------------------------------------
; FreeAnimTables                                  65DE8  97 PC, low confidence
; Frees the animation tables
;-----------------------------------------------------------------------------
FreeAnimTables:
        push ebx
        push ecx
        push edx
        push esi
        xor esi, esi
.1:
        mov ebx, esi
        shl ebx, 2
        cmp dword [dword ebx+SkateAnimData], byte 0
        je short .2
        push dword [dword ebx+SkateAnimData]
        call FreeMemBlock
        add esp, byte 4
        mov dword [dword ebx+SkateAnimData], 0
.2:
        inc esi
        cmp esi, byte 0Bh
        jl short .1
        push dword [StopTableForward]
        call FreeMemBlock
        add esp, byte 4
        push dword [StopTableBackward]
        call FreeMemBlock
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; InitPlayerAnims                                 65E3B  97 PC, low confidence
; Sets up the starting animations of the players
;-----------------------------------------------------------------------------
InitPlayerAnims:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 4, 0
        mov esi, eax
        push byte 3Ch
        mov edi, dword [dword eax+0F2h]
        mov eax, dword [dword eax+0F6h]
        push dword [dword esi+0FAh]
        mov dword [byte ebp-04h], eax
        call ZeroMem
        add esp, byte 8
        mov eax, dword [dword esi+0FAh]
        call ResetAnimTimer
        mov ecx, dword [dword esi+0FAh]
        mov dword [byte ecx+030h], 0
        mov ecx, dword [dword esi+0FAh]
        mov dword [byte ecx+038h], 3F800000h
        mov dword [dword edi+0754h], 0
        cmp byte [dword esi+0A4h], 0
        jne short .1
        mov dword [MoveState], 4Eh
        mov dword [PlayerAnimMove], 0
        mov eax, dword [PlayerAnimTable]
        mov dword [PlayerAnimBase], esi
        mov dword [PlayerAnimSize], eax
        mov ecx, dword [dword esi+0F2h]
        mov edx, MoveState
        mov eax, dword [byte ebp-04h]
        mov ebx, dword [byte ecx+03Ch]
        mov dword [PlayerAnimScale], ebx
        call StartAnimNow
        lea ecx, [byte edi+058h]
        mov eax, dword [byte ebp-04h]
        mov edx, dword [byte edi+054h]
        mov ebx, ecx
        mov eax, dword [eax]
        call UpdateAllPoses
        mov eax, ecx
        call SaveGamePalette
.1:
        mov dword [MoveState], 2
        mov dword [PlayerAnimMove], SkateForwardMove
        mov eax, dword [PlayerAnimSet]
        mov dword [PlayerAnimBase], esi
        mov dword [PlayerAnimSize], eax
        mov ecx, dword [dword esi+0F2h]
        mov edx, MoveState
        mov eax, dword [byte ebp-04h]
        mov ebx, dword [byte ecx+03Ch]
        mov dword [PlayerAnimScale], ebx
        call StartAnimNow
        mov eax, dword [byte ebp-04h]
        lea ebx, [byte edi+058h]
        mov edx, dword [byte edi+054h]
        mov eax, dword [eax]
        call UpdateAllPoses
        jmp near LoadGoalieAnimFile_167
