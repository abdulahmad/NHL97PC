; Puck physics: stick touches, bounces, posts, nets, boards and glass, the puck carrier and the goal judge.
bits 32
%include "hockey.inc"
section s_65F4B progbits alloc exec nowrite align=1
extern __CHP, AddPenalty, AddPenalty2, BodyPointId, BreakawayFlag, CommentaryEvent, DebugModelRefresh, EndPenaltyShot
extern F32_10000, F32_1272_PuckGroundHeight, F32_1272_PuckHitsBoards, F32_12_PuckInNetDepth, F32_144_GoalJudgeTest, F32_180, F32_180_GoalLinePuckTest, F32_180_PuckBehindNet
extern F32_180_PuckInAwayNet, F32_191, F32_191_PuckBehindNet, F32_191_PuckInAwayNet, F32_192_PuckBehindNet, F32_192_PuckInAwayNet, F32_192_PuckInHomeNet, F32_193
extern F32_193_PuckBehindNet, F32_193_PuckInAwayNet, F32_201p5, F32_201p5_PuckBehindNet, F32_201p5_PuckInAwayNet, F32_2040_PuckHitsBoards, F32_2040_PuckHitsGlass, F32_22p5625
extern F32_22p5625_PuckOffCrossbar, F32_2_NetCollisionPoint, F32_2_PuckBounceOffPlayer, F32_2_PuckOffCrossbar, F32_2_PuckOffPost, F32_2_StickReach, F32_4032_PuckGroundHeight, F32_4032_PuckHitsBoards
extern F32_4272_PuckInHomeNet, F32_4448, F32_4800_PuckHitsBoards, F32_4800_PuckHitsGlass, F32_4_NetCollisionPoint, F32_4_PuckHitsBoards, F32_4_PuckOffCrossbar, F32_4_PuckOffPost
extern F32_4_StickReach, F32_65536_PuckHeightAt, F32_65536_TryStickTouch, F32_768_PuckGroundHeight, F32_768_PuckHitsBoards, F32_neg1024, F32_neg12_PuckInNetWidth, F32_neg176
extern F32_neg176_GoalLinePuckTest, F32_neg180, F32_neg180_GoalLinePuckTest, F32_neg180_PuckBehindNet, F32_neg180_PuckInAwayNet, F32_neg3000, F32_neg4272_PuckInAwayNet, F32_neg4448
extern F32_neg5760, F64_0p0001_PuckOffCrossbar, F64_0p0001_PuckOffPost, F64_0p02, F64_0p0631313, F64_0p0833333, F64_0p0872665, F64_0p159155_PuckHeightAt
extern F64_0p25_PuckHitsNet, F64_0p3, F64_0p3_PuckOffCrossbar, F64_0p5_PuckBehindNet, F64_0p5_PuckInAwayNet, F64_0p5_PuckInHomeNet, F64_0p785398_GoalJudgeTest, F64_0p8_PuckHitsNet
extern F64_0p9, F64_0p985, F64_0p99, F64_0p9_PuckBehindNet, F64_0p9_PuckInAwayNet, F64_108, F64_108_PuckBehindNet, F64_108_PuckInAwayNet
extern F64_110_NetCollisionPoint, F64_12100, F64_132, F64_1392_PuckBounceOffPlayer, F64_1392_PuckHitsNet, F64_144, F64_144_PuckBehindNet, F64_144_PuckInAwayNet
extern F64_153p5, F64_153p5_PuckBehindNet, F64_153p5_PuckInAwayNet, F64_168, F64_180_NetCollisionPoint, F64_1p5708_PuckHitsNet, F64_1p7, F64_1p74533
extern F64_1p74533_PlayNetSound, F64_1p74533_PuckHitsGlass, F64_1p8_TryStickTouch, F64_228, F64_228_GoalLinePuckTest, F64_228_PuckBehindNet, F64_228_PuckInAwayNet, F64_25
extern F64_2_PuckHitsBoards, F64_2_PuckOffCrossbar, F64_2_PuckOffPost, F64_2p0944, F64_32400, F64_3360, F64_3360_PuckHitsNet, F64_3p08642eneg05
extern F64_3p08642eneg05_GoalLinePuckTest, F64_3p08642eneg05_PuckBehindNet, F64_3p08642eneg05_PuckInAwayNet, F64_3p08642eneg05_PuckInHomeNet, F64_3p14159_GoalJudgeTest, F64_3p14159_PlayNetSound, F64_3p14159_PuckBehindNet, F64_3p14159_PuckHitsBoards
extern F64_3p14159_PuckHitsGlass, F64_3p14159_PuckHitsNet, F64_3p14159_PuckInAwayNet, F64_3p14159_PuckInHomeNet, F64_3p14159_PuckOffCrossbar, F64_3p14159_PuckOffPost, F64_3p14159_RandomPuckSpin, F64_4272_PuckHitsNet
extern F64_4338, F64_64800, F64_65536_PuckHeightAt, F64_66, F64_66_GoalLinePuckTest, F64_66_PuckBehindNet, F64_6p28319_GoalJudgeTest, F64_6p28319_PlayNetSound
extern F64_6p28319_PuckHitsBoards, F64_6p28319_PuckHitsGlass, F64_6p28319_PuckHitsNet, F64_6p28319_PuckOffCrossbar, F64_6p28319_PuckOffPost, F64_8p26446eneg05, F64_8p26446eneg05_GoalLinePuckTest, F64_8p26446eneg05_PuckBehindNet
extern F64_8p26446eneg05_PuckInAwayNet, F64_96_PuckBounceOffPlayer, F64_neg0p0872665, F64_neg0p1_GoalLinePuckTest, F64_neg12100, F64_neg3p14159_GoalJudgeTest, F64_neg3p14159_PlayNetSound, F64_neg3p14159_PuckHitsBoards
extern F64_neg3p14159_PuckHitsGlass, F64_neg3p14159_PuckHitsNet, F64_neg3p14159_PuckOffCrossbar, F64_neg3p14159_PuckOffPost, F64_neg4338, F64_neg4338_PuckInAwayNet, F64_neg66, F64_neg6p28319_GoalJudgeTest
extern F64_neg6p28319_PlayNetSound, F64_neg6p28319_PuckHitsBoards, F64_neg6p28319_PuckHitsGlass, F64_neg6p28319_PuckHitsNet, F64_neg6p28319_PuckOffCrossbar, F64_neg6p28319_PuckOffPost, gmode, Goal
extern GoalieTarget, hypot_, IF@ATAN2, IF@DFMOD, LastTouchPlayer, OneTimerPasser, onetimerplayer, OneTimerReady
extern OneTimerTarget, gmode2, PlaySfxVolume, PtrAwayIce, PtrHomeIce, PtrPuckFlags, puckc, PuckHitFlag
extern PuckOwner, randomd0, ReachScale, regd1, SetCrowdMood, SortCords, SpeedScale, StartCrowdReaction
extern StickPointId, tickcount, UpdateObjectPose
global StickReach, PuckHeightAt, ObjectFramePos, TryStickTouch, PuckBounceOffPlayer, PlayPostSound, PuckHitsNet, PuckHitsBoards
global PuckHitsGlass, NetCollisionPoint, PuckInNetDepth, PuckInNetWidth, PlayNetSound, CommentNetHit, PuckOffPost, PuckOffCrossbar
global PuckInHomeNet, PuckInAwayNet, PuckBehindNet, CheckPuckNets, GoalLinePuckTest, UpdatePuckCarrier, PuckGroundHeight, PuckBounceIce
global UpdatePuck, GoalJudgeTest, RandomPuckSpin, StopObject
        db 00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; StickReach                                      65F50  97 PC, low confidence
; Works out how far a player's stick reaches
;-----------------------------------------------------------------------------
StickReach:
        push eax
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 3Ch
        and esp, byte 0FFFFFFF8h
        fld dword [byte ebp+010h]
        fsub dword [byte ebp+020h]
        fst dword [byte esp+030h]
        fmul dword [byte ebp+01Ch]
        fld dword [byte ebp+014h]
        fsub dword [byte ebp+024h]
        fld dword [byte esp+030h]
        fmul st0
        fxch
        fst dword [byte esp+024h]
        fmul dword [byte esp+024h]
        fld dword [byte esp+024h]
        fmul dword [F32_2_StickReach]
        fld dword [byte esp+024h]
        fmul dword [byte ebp+018h]
        fld dword [byte ebp+028h]
        fld st4
        fmul st1
        fxch st4
        faddp st5
        fmulp st3
        fxch st3
        fst dword [byte esp+010h]
        fmul dword [F32_4_StickReach]
        fxch st3
        fsubp st4
        fld st3
        fmul st4
        fxch
        fmulp st4
        fsubrp
        fmulp
        fxch
        fst dword [byte esp+01Ch]
        fmul dword [byte esp+01Ch]
        mov eax, dword [byte ebp+018h]
        fldz
        mov dword [byte esp+018h], eax
        mov eax, dword [byte ebp+01Ch]
        fxch
        fsubrp st2
        mov dword [byte esp+0Ch], eax
        fxch
        fstp dword [byte esp+034h]
        fcomp dword [byte esp+034h]
        fnstsw ax
        sahf
        jbe short .1
        mov dword [byte esp+038h], 0BF800000h
        jmp near .9
.1:
        fld dword [byte esp+034h]
        fsqrt
        fst dword [byte esp+034h]
        fld dword [byte esp+01Ch]
        fxch
        fsub st1
        fld dword [byte esp+010h]
        fmul dword [F32_2_StickReach]
        fld1
        fdivrp
        fxch st2
        fchs
        fsub dword [byte esp+034h]
        fxch
        fmul st2
        fxch
        fmulp st2
        fstp dword [byte esp+02Ch]
        fstp dword [byte esp+014h]
        fld dword [byte esp+02Ch]
        fcomp dword [byte ebp+018h]
        fnstsw ax
        sahf
        jne short .2
        mov dword [byte esp+020h], 49742400h
        jmp short .3
.2:
        fld dword [byte esp+02Ch]
        fsub dword [byte ebp+018h]
        fdivr dword [byte esp+030h]
        fstp dword [byte esp+020h]
.3:
        fld dword [byte esp+014h]
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        jne short .4
        mov dword [byte esp+028h], 49742400h
        jmp short .5
.4:
        fld dword [byte esp+014h]
        fsub dword [byte esp+018h]
        fdivr dword [byte esp+030h]
        fstp dword [byte esp+028h]
.5:
        fldz
        fcomp dword [byte esp+020h]
        fnstsw ax
        sahf
        jbe short .6
        fldz
        fcomp dword [byte esp+028h]
        fnstsw ax
        sahf
        jb short .7
.6:
        fld dword [byte esp+020h]
        fcomp dword [byte esp+028h]
        fnstsw ax
        sahf
        jbe short .8
        fldz
        fcomp dword [byte esp+028h]
        fnstsw ax
        sahf
        jae short .8
.7:
        mov eax, dword [byte esp+014h]
        mov dword [byte esp+02Ch], eax
        mov eax, dword [byte esp+028h]
        mov dword [byte esp+020h], eax
.8:
        fld dword [byte esp+02Ch]
        fsub dword [byte esp+018h]
        fmul dword [byte esp+024h]
        fld dword [byte esp+030h]
        fld st0
        fmul dword [byte esp+0Ch]
        faddp st2
        fdivp
        mov edx, dword [byte ebp+02Ch]
        mov eax, dword [byte esp+02Ch]
        mov dword [edx], eax
        mov eax, dword [byte ebp+030h]
        fstp dword [eax]
        mov eax, dword [byte esp+020h]
        mov dword [byte esp+038h], eax
.9:
        fld dword [byte esp+038h]
        mov esp, ebp
        pop ebp
        pop edx
        pop eax
        ret 24h
;-----------------------------------------------------------------------------
; PuckHeightAt                                    660F0  97 PC, low confidence
; Works out the puck height at a point
;-----------------------------------------------------------------------------
PuckHeightAt:
        push edx
        sub esp, byte 4
        fld dword [byte eax+020h]
        fmul dword [F32_65536_PuckHeightAt]
        fld dword [byte eax+024h]
        fmul dword [F32_65536_PuckHeightAt]
        fld dword [byte eax+028h]
        fmul dword [F32_65536_PuckHeightAt]
        fld dword [byte eax+02Ch]
        fmul dword [F32_65536_PuckHeightAt]
        fld dword [byte eax+030h]
        fmul dword [F32_65536_PuckHeightAt]
        fld dword [byte eax+01Ch]
        fmul qword [F64_0p159155_PuckHeightAt]
        fld dword [byte eax+034h]
        fmul dword [F32_65536_PuckHeightAt]
        fxch
        fmul qword [F64_65536_PuckHeightAt]
        fxch st6
        call __CHP
        fxch st5
        call __CHP
        fxch st4
        call __CHP
        fxch st3
        call __CHP
        fxch st2
        call __CHP
        fxch
        call __CHP
        fxch st4
        fistp dword [byte eax+08h]
        fxch st2
        fistp dword [byte eax+0Ch]
        fistp dword [byte eax+010h]
        fistp dword [byte eax+014h]
        fxch st2
        call __CHP
        fistp dword [esp]
        mov edx, dword [esp]
        fxch
        fistp dword [byte eax+018h]
        and edx, 0FFFFh
        fistp dword [byte eax+04h]
        mov word [byte eax+02h], dx
        add esp, byte 4
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ObjectFramePos                                  6619C  97 PC, low confidence
; Returns an object's position at its current animation frame
;-----------------------------------------------------------------------------
ObjectFramePos:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        mov ebp, eax
        mov dword [byte esp+014h], ebx
        mov esi, dword [dword eax+0F2h]
        mov ecx, esp
        mov esi, dword [byte esi+054h]
        mov eax, dword [dword eax+0F6h]
        mov ebx, edx
        mov edx, esi
        mov eax, dword [eax]
        lea edi, [byte esp+010h]
        call UpdateObjectPose
        lea esi, [byte esp+0Ch]
        lea eax, [byte ebp+01Ch]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte esp+08h]
        fmul dword [byte esp+0Ch]
        fld dword [esp]
        fmul dword [byte esp+010h]
        faddp
        fadd dword [byte ebp+020h]
        mov eax, dword [byte esp+014h]
        fstp dword [eax]
        fld dword [byte ebp+024h]
        fadd dword [byte esp+04h]
        fstp dword [byte eax+04h]
        fld dword [byte esp+08h]
        fmul dword [byte esp+010h]
        fld dword [esp]
        fchs
        fmul dword [byte esp+0Ch]
        faddp
        fadd dword [byte ebp+028h]
        mov eax, dword [byte esp+014h]
        fstp dword [byte eax+08h]
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; TryStickTouch                                   66224  97 PC, low confidence
; Tests whether the stick touches the puck
;-----------------------------------------------------------------------------
TryStickTouch:
        push ebx
        push ecx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 50h
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov ecx, edx
        fld dword [byte esi+020h]
        fsub dword [byte edx+020h]
        fstp dword [byte esp+048h]
        fld dword [byte esi+028h]
        fsub dword [byte edx+028h]
        fst dword [byte esp+044h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+050h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fmul qword [F64_0p0631313]
        mov dx, word [dword esi+0A9h]
        fstp dword [byte esp+04Ch]
        test dx, dx
        jne short .1
        call SpeedScale
        fcomp dword [byte esp+04Ch]
        fnstsw ax
        sahf
        jae short .4
        xor eax, eax
        mov al, byte [dword esi+0CBh]
        mov dword [byte esp+038h], eax
        fild word [byte esp+038h]
        fstp dword [byte esp+024h]
        call SpeedScale
        fadd dword [byte esp+024h]
        jmp short .3
.1:
        call SpeedScale
        fmul qword [F64_1p8_TryStickTouch]
        fld dword [byte esp+04Ch]
        fstp qword [byte esp+03Ch]
        fcomp qword [byte esp+03Ch]
        fnstsw ax
        sahf
        jae short .2
        call SpeedScale
        fmul qword [F64_1p8_TryStickTouch]
        jmp short .3
.2:
        call ReachScale
        fmul qword [F64_1p7]
        fcomp qword [byte esp+03Ch]
        fnstsw ax
        sahf
        jbe short .4
        call ReachScale
        fmul qword [F64_1p7]
.3:
        fstp dword [byte esp+04Ch]
.4:
        lea ebx, [byte esp+018h]
        mov edx, dword [StickPointId]
        mov eax, ecx
        call ObjectFramePos
        lea ebx, [byte esp+0Ch]
        mov edx, dword [StickPointId]
        mov eax, esi
        call ObjectFramePos
        mov eax, dword [byte ecx+02Ch]
        mov dword [esp], eax
        mov eax, dword [byte ecx+034h]
        mov edx, dword [byte ecx+038h]
        mov dword [byte esp+08h], eax
        cmp edx, 41400000h
        jge short .5
        xor ebx, ebx
        mov dword [byte esp+08h], ebx
        mov dword [esp], ebx
.5:
        lea eax, [byte esp+044h]
        push eax
        lea eax, [byte esp+04Ch]
        push eax
        push dword [byte esp+054h]
        push dword [byte esp+020h]
        push dword [byte esp+01Ch]
        push dword [byte esp+01Ch]
        push dword [byte esp+018h]
        push dword [byte esp+03Ch]
        push dword [byte esp+038h]
        call StickReach
        fldz
        fxch
        fstp dword [byte esp+02Ch]
        fcomp dword [byte esp+02Ch]
        fnstsw ax
        sahf
        ja near .9
        cmp word [dword esi+0A9h], byte 0
        jne short .6
        xor eax, eax
        mov edx, 0Fh
        mov al, byte [dword esi+0CBh]
        sub edx, eax
        mov dword [byte esp+024h], edx
        fild dword [byte esp+024h]
        fmul qword [F64_0p02]
        fstp dword [byte esp+034h]
        jmp short .7
.6:
        xor ebx, ebx
        mov dword [byte esp+034h], ebx
.7:
        mov eax, 2
        call randomd0
        test ax, ax
        jne short .8
        fld dword [byte esp+034h]
        fchs
        fstp dword [byte esp+034h]
.8:
        mov eax, dword [PtrPuckFlags]
        mov eax, dword [dword eax+0EEh]
        mov edx, dword [byte esp+04Ch]
        mov dword [byte eax+08h], edx
        fld dword [byte esp+034h]
        fld dword [byte esp+048h]
        fadd st1
        fld dword [byte esp+044h]
        faddp st2
        call IF@ATAN2
        mov eax, dword [PtrPuckFlags]
        mov eax, dword [dword eax+0EEh]
        fstp dword [byte eax+0Ch]
        jmp near .14
.9:
        call SpeedScale
        lea eax, [byte esp+044h]
        fmul qword [F64_1p8_TryStickTouch]
        push eax
        lea eax, [byte esp+04Ch]
        push eax
        fstp dword [byte esp+030h]
        push dword [byte esp+030h]
        push dword [byte esp+020h]
        push dword [byte esp+01Ch]
        push dword [byte ecx+034h]
        push dword [byte ecx+02Ch]
        push dword [byte esp+03Ch]
        push dword [byte esp+038h]
        call StickReach
        fldz
        fxch
        fstp dword [byte esp+02Ch]
        fcomp dword [byte esp+02Ch]
        fnstsw ax
        sahf
        ja near .13
        cmp word [dword esi+0A9h], byte 0
        jne short .10
        xor eax, eax
        mov edx, 0Fh
        mov al, byte [dword esi+0CBh]
        sub edx, eax
        mov dword [byte esp+024h], edx
        fild dword [byte esp+024h]
        fmul qword [F64_0p02]
        fstp dword [byte esp+030h]
        jmp short .11
.10:
        xor edx, edx
        mov dword [byte esp+030h], edx
.11:
        mov eax, 2
        call randomd0
        test ax, ax
        jne short .12
        fld dword [byte esp+030h]
        fchs
        fstp dword [byte esp+030h]
.12:
        mov eax, dword [PtrPuckFlags]
        mov eax, dword [dword eax+0EEh]
        mov edx, dword [byte esp+028h]
        mov dword [byte eax+08h], edx
        fld dword [byte esp+030h]
        fld dword [byte esp+048h]
        fadd st1
        fld dword [byte esp+044h]
        faddp st2
        call IF@ATAN2
        mov eax, dword [PtrPuckFlags]
        mov eax, dword [dword eax+0EEh]
        fstp dword [byte eax+0Ch]
        jmp short .14
.13:
        fld dword [byte ecx+038h]
        mov eax, dword [PtrPuckFlags]
        fadd qword [F64_25]
        mov eax, dword [dword eax+0EEh]
        fstp dword [byte eax+08h]
        fld dword [byte ecx+020h]
        fsub dword [byte esi+020h]
        fld dword [byte ecx+028h]
        fsub dword [byte esi+028h]
        fxch
        call IF@ATAN2
        mov eax, dword [PtrPuckFlags]
        mov eax, dword [dword eax+0EEh]
        fstp dword [byte eax+0Ch]
        xor eax, eax
        mov dword [byte esp+02Ch], eax
.14:
        fld dword [byte esp+02Ch]
        fmul dword [F32_65536_TryStickTouch]
        call __CHP
        fistp dword [byte esp+024h]
        mov eax, dword [byte esp+024h]
        sar eax, 10h
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PuckBounceOffPlayer                             66524  97 PC, low confidence
; Bounces the puck off a player's body
;-----------------------------------------------------------------------------
PuckBounceOffPlayer:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 28h
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov ecx, edx
        mov ebx, esp
        mov edx, dword [StickPointId]
        mov eax, ecx
        call ObjectFramePos
        fld dword [byte esi+024h]
        fsub dword [byte esp+04h]
        mov ah, byte [dword ecx+0A4h]
        fstp dword [byte esp+01Ch]
        cmp ah, 0Ch
        je short .1
        call SpeedScale
        fmul dword [F32_2_PuckBounceOffPlayer]
        fcomp dword [byte esi+038h]
        fnstsw ax
        sahf
        jbe short .1
        fld dword [byte esp+01Ch]
        fabs
        fcomp qword [F64_96_PuckBounceOffPlayer]
        fnstsw ax
        sahf
        jbe short .2
.1:
        xor eax, eax
        jmp near .9
.2:
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .3
        test byte [gmode], 1
        je short .3
        xor edi, edi
        mov eax, 3FE00000h
        mov dword [byte esp+014h], edi
        mov dword [byte esp+018h], eax
        jmp short .4
.3:
        xor edx, edx
        mov ebx, 3FF00000h
        mov dword [byte esp+014h], edx
        mov dword [byte esp+018h], ebx
.4:
        fld qword [byte esp+014h]
        fmul qword [F64_132]
        fld dword [byte esi+028h]
        fsub dword [byte esp+08h]
        fxch
        fstp qword [byte esp+0Ch]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esi+020h]
        fsub dword [byte esp+08h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fst dword [byte esp+024h]
        fcomp qword [byte esp+0Ch]
        fnstsw ax
        sahf
        jbe short .8
        xor eax, eax
        mov dx, word [onetimerplayer]
        mov al, byte [dword ecx+0A4h]
        cmp ax, dx
        je short .5
        call SpeedScale
        fcomp dword [byte esi+038h]
        fnstsw ax
        sahf
        jbe near .1
.5:
        cmp byte [dword ecx+0A4h], 0Ch
        jne short .6
        test byte [gmode], 1
        je short .6
        mov dword [byte esp+020h], 2
        jmp short .7
.6:
        mov dword [byte esp+020h], 1
.7:
        fild dword [byte esp+020h]
        fmul qword [F64_168]
        fld dword [byte esp+024h]
        fcompp
        fnstsw ax
        sahf
        jae near .1
.8:
        mov eax, 1
.9:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push eax
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        and esp, byte 0FFFFFFF8h
        fld dword [byte ebp+010h]
        fabs
        fst qword [esp]
        fcomp qword [F64_3360]
        fnstsw ax
        sahf
        jb short .10
        mov dword [byte esp+08h], 43F00000h
        jmp short .12
.10:
        fldz
        fcomp dword [byte ebp+0Ch]
        fnstsw ax
        sahf
        jb short .11
        fld qword [esp]
        fcomp qword [F64_1392_PuckBounceOffPlayer]
        fnstsw ax
        sahf
        jae short .11
        mov dword [byte esp+08h], 43280000h
        fld dword [byte esp+08h]
        mov esp, ebp
        pop ebp
        pop eax
        ret 8
.11:
        mov dword [byte esp+08h], 43C00000h
.12:
        fld dword [byte esp+08h]
        mov esp, ebp
        pop ebp
        pop eax
        ret 8
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PlayPostSound                                   666CC  97 PC, low confidence
; Plays the sound of the puck hitting the post
;-----------------------------------------------------------------------------
PlayPostSound:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ebx, eax
        cmp word [DebugModelRefresh], byte 0
        je short .1
        mov dword [byte eax+038h], 43520000h
        xor ecx, ecx
        mov word [DebugModelRefresh], cx
.1:
        cmp dword [byte ebx+038h], 43480000h
        jl short .2
        mov eax, 32h
        call randomd0
        cmp ax, 24h
        jne short .2
        push dword [byte ebx+028h]
        mov edx, 64h
        mov eax, 460h
        push dword [byte ebx+020h]
        call PlaySfxVolume
        mov eax, dword [byte ebx+04h]
        xor ecx, ecx
        sar eax, 10h
        mov dword [byte esp+04h], ecx
        mov dword [esp], eax
        mov eax, dword [byte ebx+0Ch]
        sar eax, 10h
        mov edx, 4
        mov dword [byte esp+08h], eax
        mov eax, dword [tickcount]
        mov ebx, eax
        mov eax, esp
        call StartCrowdReaction
        mov eax, 1
        jmp short .3
.2:
        xor eax, eax
.3:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PuckHitsNet                                     66758  97 PC, low confidence
; Puck against the net: post, crossbar, goal or save
;-----------------------------------------------------------------------------
PuckHitsNet:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 0BCh
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        fld dword [byte ebp+01Ch]
        fld st0
        fsin
        fxch
        fcos
        fst dword [byte esp+01Ch]
        fmul dword [byte edx+034h]
        fld dword [byte esp+01Ch]
        fmul dword [byte edx+02Ch]
        fxch st2
        fchs
        fst dword [byte esp+020h]
        fmul dword [byte edx+02Ch]
        fld dword [byte esp+020h]
        fmul dword [byte edx+034h]
        mov ebx, dword [byte edx+024h]
        fxch
        fsubp st2
        faddp st2
        fchs
        fxch
        fstp dword [dword esp+0B8h]
        fstp dword [dword esp+0B4h]
        cmp ebx, 43280000h
        jle near .8
        mov eax, dword [dword edx+0FAh]
        test byte [byte eax+030h], 10h
        jne near .8
        mov eax, dword [byte edx+020h]
        mov dword [byte esp+014h], eax
        mov eax, dword [byte edx+028h]
        mov dword [dword esp+0B0h], eax
        fld dword [dword esp+0B0h]
        fabs
        fst qword [byte esp+05Ch]
        fcomp qword [F64_3360_PuckHitsNet]
        fnstsw ax
        sahf
        jb short .1
        mov dword [byte esp+018h], 43F00000h
        jmp short .3
.1:
        fldz
        fcomp dword [byte esp+014h]
        fnstsw ax
        sahf
        jb short .2
        fld qword [byte esp+05Ch]
        fcomp qword [F64_1392_PuckHitsNet]
        fnstsw ax
        sahf
        jae short .2
        mov dword [byte esp+018h], 43280000h
        jmp short .3
.2:
        mov dword [byte esp+018h], 43C00000h
.3:
        fld dword [byte edx+024h]
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        jbe near .7
        mov eax, dword [PuckOwner]
        sar eax, 10h
        mov edx, eax
        shl edx, 5
        add edx, eax
        mov ecx, SortCords
        shl edx, 3
        mov al, byte [gmode]
        add ecx, edx
        test al, 1
        jne short .6
        cmp word [dword ecx+0A9h], byte 0
        jne short .5
        mov eax, dword [PtrPuckFlags]
        mov bx, word [byte eax+06Dh]
        cmp bx, byte 1
        je short .4
        cmp bx, byte 2
        jne short .5
.4:
        mov ebx, 1
        mov edx, 1Bh
        mov eax, ecx
        call AddPenalty
.5:
        mov edx, 8
        mov eax, ecx
        xor ebx, ebx
        call AddPenalty2
.6:
        call EndPenaltyShot
        xor edi, edi
        xor eax, eax
        mov word [OneTimerPasser], di
        mov word [OneTimerReady], di
        mov word [OneTimerTarget], di
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 4
.7:
        mov eax, edx
        call PlayPostSound
        test eax, eax
        je short .8
        mov eax, dword [PuckOwner]
        mov edx, 1
        sar eax, 10h
        mov dword [PuckHitFlag], edx
        mov edx, eax
        shl edx, 5
        add edx, eax
        mov eax, SortCords
        shl edx, 3
        xor ebx, ebx
        add eax, edx
        mov edx, 8
        xor esi, esi
        call AddPenalty2
        call EndPenaltyShot
        mov word [OneTimerPasser], si
        mov word [OneTimerReady], si
        mov word [OneTimerTarget], si
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 4
.8:
        fldz
        fcomp dword [dword esp+0B4h]
        fnstsw ax
        sahf
        ja short .10
        cmp byte [dword edx+0A4h], 0Dh
        jne short .9
        fld dword [byte edx+038h]
        fld st0
        fmul qword [F64_0p99]
        fstp st1
        fstp dword [byte edx+038h]
.9:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 4
.10:
        fld dword [dword esp+0B4h]
        fld st0
        fmul qword [F64_0p25_PuckHitsNet]
        fld dword [dword esp+0B8h]
        fld st0
        fmul qword [F64_0p985]
        mov bh, byte [dword edx+0A4h]
        fxch st2
        fstp st3
        fxch
        fstp st1
        fxch
        fstp dword [dword esp+0B4h]
        fstp dword [dword esp+0B8h]
        cmp bh, 0Ch
        jae short .11
        fld dword [dword esp+0B8h]
        fld st0
        fmul qword [F64_0p8_PuckHitsNet]
        fstp st1
        fstp dword [dword esp+0B8h]
.11:
        fld dword [byte esp+01Ch]
        fld st0
        fld dword [dword esp+0B8h]
        fxch
        fmul st1
        fld dword [byte esp+020h]
        fmul to st2
        fld dword [dword esp+0B4h]
        fxch
        fmul st1
        fxch st4
        fmulp
        mov cl, byte [dword edx+0A4h]
        faddp st2
        fsubrp st2
        fstp dword [byte edx+034h]
        fstp dword [byte edx+02Ch]
        cmp cl, 0Dh
        jae near .31
        test byte [dword edx+0C0h], 1
        jne near .31
        mov ecx, dword [dword edx+0FAh]
        fldz
        fcomp dword [byte ecx+08h]
        fnstsw ax
        sahf
        jae near .17
        mov eax, dword [byte ecx+034h]
        mov dword [dword esp+0A4h], eax
        fld dword [dword esp+0A4h]
        fcomp dword [F32_10000]
        fnstsw ax
        sahf
        jb short .12
        mov eax, dword [byte edx+040h]
        mov dword [dword esp+0A4h], eax
.12:
        fld dword [dword esp+0A4h]
        fsub dword [byte ebp+01Ch]
        fld qword [F64_6p28319_PuckHitsNet]
        fxch
        call IF@DFMOD
        fst dword [dword esp+0A4h]
        fst qword [byte esp+034h]
        fcomp qword [F64_3p14159_PuckHitsNet]
        fnstsw ax
        sahf
        jbe short .13
        fld qword [byte esp+034h]
        fadd qword [F64_neg6p28319_PuckHitsNet]
        fstp dword [dword esp+0A4h]
.13:
        fld dword [dword esp+0A4h]
        fst qword [byte esp+074h]
        fcomp qword [F64_neg3p14159_PuckHitsNet]
        fnstsw ax
        sahf
        jae short .14
        fld qword [byte esp+074h]
        fadd qword [F64_6p28319_PuckHitsNet]
        fstp dword [dword esp+0A4h]
.14:
        fld dword [dword esp+0A4h]
        fabs
        fcomp qword [F64_1p5708_PuckHitsNet]
        fnstsw ax
        sahf
        jae short .17
        fldz
        fcomp dword [dword esp+0A4h]
        fnstsw ax
        sahf
        jae short .15
        mov esi, 5A7ED197h
        mov edi, 3FF921FBh
        mov dword [byte esp+024h], esi
        mov dword [byte esp+028h], edi
        jmp short .16
.15:
        mov ebx, 5A7ED197h
        mov ecx, 0BFF921FBh
        mov dword [byte esp+024h], ebx
        mov dword [byte esp+028h], ecx
.16:
        fld dword [byte ebp+01Ch]
        mov eax, dword [dword edx+0FAh]
        fadd qword [byte esp+024h]
        fld dword [dword esp+0A4h]
        fxch
        fstp dword [byte eax+034h]
        fsin
        mov ecx, dword [dword edx+0FAh]
        fmul dword [byte ecx+08h]
        fstp dword [byte ecx+08h]
.17:
        fld dword [byte edx+034h]
        fld dword [byte edx+02Ch]
        call IF@ATAN2
        fsub dword [byte edx+040h]
        fst dword [dword esp+0ACh]
        fld qword [F64_6p28319_PuckHitsNet]
        fxch
        call IF@DFMOD
        fld dword [byte edx+040h]
        fadd dword [dword esp+0ACh]
        fstp dword [byte edx+040h]
        fst dword [dword esp+0ACh]
        fst qword [dword esp+08Ch]
        fcomp qword [F64_3p14159_PuckHitsNet]
        fnstsw ax
        sahf
        jbe short .18
        fld qword [dword esp+08Ch]
        fadd qword [F64_neg6p28319_PuckHitsNet]
        fstp dword [dword esp+0ACh]
.18:
        fld dword [dword esp+0ACh]
        fst qword [byte esp+04Ch]
        fcomp qword [F64_neg3p14159_PuckHitsNet]
        fnstsw ax
        sahf
        jae short .19
        fld qword [byte esp+04Ch]
        fadd qword [F64_6p28319_PuckHitsNet]
        fstp dword [dword esp+0ACh]
.19:
        fldz
        lea ecx, [byte edx+01Ch]
        fcomp dword [dword esp+0ACh]
        fnstsw ax
        sahf
        ja short .22
        fld dword [dword esp+0ACh]
        fst qword [byte esp+054h]
        fcomp qword [F64_0p0872665]
        fnstsw ax
        sahf
        jbe short .20
        mov esi, 5070BA4Eh
        mov edi, 3FB65718h
        mov dword [byte esp+044h], esi
        mov dword [byte esp+048h], edi
        jmp short .21
.20:
        mov eax, dword [byte esp+054h]
        mov dword [byte esp+044h], eax
        mov eax, dword [byte esp+058h]
        mov dword [byte esp+048h], eax
.21:
        fld dword [ecx]
        fld st0
        fadd qword [byte esp+044h]
        jmp short .25
.22:
        fld dword [dword esp+0ACh]
        fst qword [byte esp+06Ch]
        fcomp qword [F64_neg0p0872665]
        fnstsw ax
        sahf
        jae short .23
        mov eax, 5070BA4Eh
        mov ebx, 0BFB65718h
        mov dword [dword esp+084h], eax
        mov dword [dword esp+088h], ebx
        jmp short .24
.23:
        mov eax, dword [byte esp+06Ch]
        mov dword [dword esp+084h], eax
        mov eax, dword [byte esp+070h]
        mov dword [dword esp+088h], eax
.24:
        fld dword [ecx]
        fld st0
        fadd qword [dword esp+084h]
.25:
        fstp st1
        fstp dword [ecx]
        fld qword [F64_6p28319_PuckHitsNet]
        fld dword [byte edx+01Ch]
        call IF@DFMOD
        fst dword [byte edx+01Ch]
        fst qword [byte esp+064h]
        fcomp qword [F64_3p14159_PuckHitsNet]
        fnstsw ax
        sahf
        jbe short .26
        fld qword [byte esp+064h]
        fadd qword [F64_neg6p28319_PuckHitsNet]
        fstp dword [byte edx+01Ch]
.26:
        fld dword [byte edx+01Ch]
        fst qword [byte esp+07Ch]
        fcomp qword [F64_neg3p14159_PuckHitsNet]
        fnstsw ax
        sahf
        jae short .27
        fld qword [byte esp+07Ch]
        fadd qword [F64_6p28319_PuckHitsNet]
        fstp dword [byte edx+01Ch]
.27:
        fld dword [byte edx+040h]
        fsub dword [byte edx+01Ch]
        fld qword [F64_6p28319_PuckHitsNet]
        fxch
        call IF@DFMOD
        fst dword [dword esp+0A8h]
        fst qword [dword esp+09Ch]
        fcomp qword [F64_3p14159_PuckHitsNet]
        fnstsw ax
        sahf
        jbe short .28
        fld qword [dword esp+09Ch]
        fadd qword [F64_neg6p28319_PuckHitsNet]
        fstp dword [dword esp+0A8h]
.28:
        fld dword [dword esp+0A8h]
        fst qword [byte esp+02Ch]
        fcomp qword [F64_neg3p14159_PuckHitsNet]
        fnstsw ax
        sahf
        jae short .29
        fld qword [byte esp+02Ch]
        fadd qword [F64_6p28319_PuckHitsNet]
        fstp dword [dword esp+0A8h]
.29:
        fld dword [dword esp+0A8h]
        fabs
        fcomp qword [F64_2p0944]
        fnstsw ax
        sahf
        jbe short .30
        mov eax, dword [dword edx+0EEh]
        or byte [byte eax+031h], 8
        jmp short .32
.30:
        mov eax, dword [dword edx+0EEh]
        and byte [byte eax+031h], 0F7h
        jmp short .32
.31:
        fld dword [byte edx+034h]
        fld dword [byte edx+02Ch]
        call IF@ATAN2
        fstp dword [byte edx+040h]
.32:
        fld qword [F64_6p28319_PuckHitsNet]
        fld dword [byte edx+040h]
        call IF@DFMOD
        fst dword [byte edx+040h]
        fst qword [dword esp+094h]
        fcomp qword [F64_3p14159_PuckHitsNet]
        fnstsw ax
        sahf
        jbe short .33
        fld qword [dword esp+094h]
        fadd qword [F64_neg6p28319_PuckHitsNet]
        fstp dword [byte edx+040h]
.33:
        fld dword [byte edx+040h]
        fst qword [byte esp+03Ch]
        fcomp qword [F64_neg3p14159_PuckHitsNet]
        fnstsw ax
        sahf
        jae short .34
        fld qword [byte esp+03Ch]
        fadd qword [F64_6p28319_PuckHitsNet]
        fstp dword [byte edx+040h]
.34:
        sub esp, byte 8
        fld dword [byte edx+034h]
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte edx+02Ch]
        fstp qword [esp]
        call hypot_
        mov cl, byte [dword edx+0A4h]
        fstp dword [byte edx+038h]
        cmp cl, 0Dh
        jne near .38
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jge short .35
        mov eax, dword [dword edx+0FAh]
        test byte [byte eax+030h], 10h
        jne short .35
        fld dword [dword esp+0B4h]
        fcomp dword [F32_neg1024]
        fnstsw ax
        sahf
        jae short .35
        mov eax, 8
        call randomd0
        cwde
        mov dword [byte esp+010h], eax
        neg eax
        mov dword [byte esp+010h], eax
        fild dword [byte esp+010h]
        mov eax, edx
        fstp dword [byte edx+030h]
        call RandomPuckSpin
.35:
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .36
        fld dword [byte edx+028h]
        fabs
        fcomp qword [F64_4272_PuckHitsNet]
        fnstsw ax
        sahf
        jbe short .37
.36:
        call EndPenaltyShot
.37:
        xor edx, edx
        mov word [OneTimerReady], dx
        mov word [OneTimerTarget], dx
        mov word [OneTimerPasser], dx
.38:
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PuckHitsBoards                                  66E38  97 PC, low confidence
; Puck against the boards: bounce and sound
;-----------------------------------------------------------------------------
PuckHitsBoards:
        push ebx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 64h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        fld dword [byte eax+050h]
        fadd dword [F32_1272_PuckHitsBoards]
        fld dword [byte eax+020h]
        fabs
        fcompp
        fnstsw ax
        sahf
        ja short .1
        xor eax, eax
        jmp near .26
.1:
        fld dword [byte ebx+050h]
        fadd dword [F32_4032_PuckHitsBoards]
        fld dword [byte ebx+028h]
        fabs
        fcompp
        fnstsw ax
        sahf
        ja short .2
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
.2:
        fldz
        fcomp dword [byte ebx+020h]
        fnstsw ax
        sahf
        jae short .3
        mov dword [esp], 4F8h
        jmp short .4
.3:
        mov dword [esp], 0FFFFFB08h
.4:
        fild dword [esp]
        fldz
        fxch
        fstp dword [byte esp+020h]
        fcomp dword [byte ebx+028h]
        fnstsw ax
        sahf
        jae short .5
        mov dword [byte esp+04h], 0FC0h
        jmp short .6
.5:
        mov dword [byte esp+04h], 0FFFFF040h
.6:
        fild dword [byte esp+04h]
        fld dword [F32_768_PuckHitsBoards]
        fld dword [byte ebx+020h]
        fld dword [byte ebx+028h]
        fxch st3
        fstp dword [byte esp+01Ch]
        fsub dword [byte esp+020h]
        fxch
        fsub dword [byte ebx+050h]
        fxch
        fstp dword [byte esp+050h]
        fxch
        fsub dword [byte esp+01Ch]
        fxch
        fstp dword [byte esp+044h]
        fst dword [byte esp+054h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+058h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fld dword [byte esp+044h]
        fcompp
        fnstsw ax
        sahf
        jb short .7
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
.7:
        fld dword [byte esp+050h]
        fld dword [byte esp+054h]
        fld dword [dword ebx+0DAh]
        fld dword [dword ebx+0D2h]
        fsub dword [byte esp+020h]
        fxch
        fsub dword [byte esp+01Ch]
        fxch
        fstp dword [byte esp+058h]
        fstp dword [byte esp+040h]
        fxch
        fsub dword [byte esp+058h]
        fxch
        fsub dword [byte esp+040h]
        fxch
        fst dword [byte esp+028h]
        fmul dword [byte esp+028h]
        fxch
        fst dword [byte esp+02Ch]
        fmul dword [byte esp+02Ch]
        faddp
        fldz
        fxch
        fstp dword [byte esp+04Ch]
        fcomp dword [byte esp+04Ch]
        fnstsw ax
        sahf
        jb short .8
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
.8:
        fld dword [byte esp+058h]
        fld dword [byte esp+028h]
        fmul st1
        fld st1
        fmulp st2
        fld dword [byte esp+04Ch]
        fmul dword [F32_4_PuckHitsBoards]
        fld dword [byte esp+040h]
        fld st0
        fmul st1
        fld dword [byte esp+02Ch]
        fxch
        faddp st5
        fmulp
        fld dword [byte esp+044h]
        fmul st0
        fxch
        faddp st3
        fsubp st3
        fxch
        fmul qword [F64_2_PuckHitsBoards]
        fxch st2
        fstp dword [byte esp+044h]
        fmul dword [byte esp+044h]
        fxch
        fst dword [byte esp+024h]
        fmul dword [byte esp+024h]
        fsubrp
        fldz
        fxch
        fstp dword [byte esp+05Ch]
        fcomp dword [byte esp+05Ch]
        fnstsw ax
        sahf
        jbe short .9
        xor edi, edi
        mov dword [byte esp+060h], edi
        jmp short .12
.9:
        fld dword [byte esp+05Ch]
        fsqrt
        fst dword [byte esp+05Ch]
        fsub dword [byte esp+024h]
        fld dword [byte esp+04Ch]
        fmul qword [F64_2_PuckHitsBoards]
        fdivp
        fldz
        fxch
        fstp dword [byte esp+060h]
        fcomp dword [byte esp+060h]
        fnstsw ax
        sahf
        ja short .10
        cmp dword [byte esp+060h], 3F800000h
        jle short .12
.10:
        fld dword [byte esp+024h]
        fchs
        fsub dword [byte esp+05Ch]
        fld dword [byte esp+04Ch]
        fmul qword [F64_2_PuckHitsBoards]
        fdivp
        fldz
        fxch
        fstp dword [byte esp+060h]
        fcomp dword [byte esp+060h]
        fnstsw ax
        sahf
        ja short .11
        cmp dword [byte esp+060h], 3F800000h
        jle short .12
.11:
        xor esi, esi
        mov dword [byte esp+060h], esi
.12:
        fld dword [byte esp+060h]
        fld st0
        fmul dword [byte esp+028h]
        mov eax, dword [puckc]
        fxch
        fmul dword [byte esp+02Ch]
        mov dl, byte [eax]
        fadd dword [byte esp+040h]
        fxch
        fadd dword [byte esp+058h]
        fxch
        fstp dword [byte esp+040h]
        fstp dword [byte esp+058h]
        test dl, dl
        jl short .13
        fld dword [byte esp+020h]
        fld dword [byte esp+01Ch]
        mov eax, 1
        fadd dword [byte esp+040h]
        fxch
        fadd dword [byte esp+058h]
        fxch
        fstp dword [byte ebx+028h]
        fstp dword [byte ebx+020h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
.13:
        fld dword [byte esp+040h]
        fld dword [byte esp+058h]
        call IF@ATAN2
        fstp dword [byte esp+08h]
        mov eax, ebx
        push dword [byte esp+08h]
        call PuckHitsNet
        fld dword [byte esp+060h]
        fld dword [byte esp+020h]
        fld dword [byte esp+01Ch]
        fld1
        fxch st2
        fadd dword [byte esp+058h]
        fxch st2
        fsubrp st3
        fadd dword [byte esp+040h]
        fxch st2
        fst dword [byte esp+060h]
        fmul dword [byte esp+028h]
        fld dword [byte esp+060h]
        fmul dword [byte esp+02Ch]
        fxch
        faddp st2
        faddp st2
        fstp dword [byte ebx+020h]
        fstp dword [byte ebx+028h]
        test eax, eax
        je near .25
        fld dword [byte ebx+040h]
        fsub dword [byte esp+08h]
        fld qword [F64_6p28319_PuckHitsBoards]
        fxch
        call IF@DFMOD
        fst dword [byte esp+048h]
        fst qword [byte esp+038h]
        fcomp qword [F64_3p14159_PuckHitsBoards]
        fnstsw ax
        sahf
        jbe short .14
        fld qword [byte esp+038h]
        fadd qword [F64_neg6p28319_PuckHitsBoards]
        fstp dword [byte esp+048h]
.14:
        fld dword [byte esp+048h]
        fst qword [byte esp+030h]
        fcomp qword [F64_neg3p14159_PuckHitsBoards]
        fnstsw ax
        sahf
        jae short .15
        fld qword [byte esp+030h]
        fadd qword [F64_6p28319_PuckHitsBoards]
        fstp dword [byte esp+048h]
.15:
        fld dword [byte esp+048h]
        fabs
        fcomp qword [F64_1p74533]
        fnstsw ax
        sahf
        jbe short .19
        mov eax, dword [byte ebx+024h]
        cmp eax, 43400000h
        jle short .16
        push dword [byte ebx+028h]
        mov edx, 64h
        mov eax, 413h
        jmp short .18
.16:
        cmp eax, 41C00000h
        jge short .17
        push dword [byte ebx+028h]
        mov edx, 64h
        mov eax, 412h
        jmp short .18
.17:
        push dword [byte ebx+028h]
        mov edx, 64h
        mov eax, 411h
.18:
        push dword [byte ebx+020h]
        call PlaySfxVolume
.19:
        fld dword [F32_2040_PuckHitsBoards]
        fsub dword [byte ebx+050h]
        fld dword [byte ebx+020h]
        fxch
        fstp dword [byte esp+014h]
        fcomp dword [byte esp+014h]
        fnstsw ax
        sahf
        jbe short .20
        mov eax, dword [byte esp+014h]
        jmp short .21
.20:
        fld dword [byte ebx+020h]
        fld dword [byte esp+014h]
        fchs
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        jae short .22
        mov eax, dword [byte esp+010h]
.21:
        mov dword [byte ebx+020h], eax
.22:
        fld dword [F32_4800_PuckHitsBoards]
        fsub dword [byte ebx+050h]
        fld dword [byte ebx+028h]
        fxch
        fstp dword [byte esp+018h]
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        jbe short .23
        mov eax, dword [byte esp+018h]
        jmp short .24
.23:
        fld dword [byte ebx+028h]
        fld dword [byte esp+018h]
        fchs
        fstp dword [byte esp+0Ch]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jae short .25
        mov eax, dword [byte esp+0Ch]
.24:
        mov dword [byte ebx+028h], eax
.25:
        mov eax, 1
.26:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PuckHitsGlass                                   67248  97 PC, low confidence
; Puck against the glass: bounce and sound
;-----------------------------------------------------------------------------
PuckHitsGlass:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 48h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov eax, dword [byte eax+02Ch]
        mov dword [byte esp+030h], eax
        mov eax, dword [byte ebx+034h]
        mov dword [byte esp+028h], eax
        mov eax, dword [byte ebx+020h]
        mov dword [byte esp+038h], eax
        mov eax, dword [byte ebx+028h]
        fld dword [byte esp+038h]
        mov dword [byte esp+034h], eax
        fabs
        fld dword [F32_4800_PuckHitsGlass]
        fld dword [F32_2040_PuckHitsGlass]
        fsub dword [byte ebx+050h]
        fxch
        fsub dword [byte ebx+050h]
        fxch
        fstp dword [byte esp+040h]
        fstp dword [byte esp+044h]
        fld dword [byte esp+040h]
        fcompp
        fnstsw ax
        sahf
        jb short .1
        fld dword [byte esp+034h]
        fabs
        fld dword [byte esp+044h]
        fcompp
        fnstsw ax
        sahf
        jb short .1
        xor eax, eax
        jmp near .22
.1:
        fld dword [byte esp+038h]
        fabs
        fld dword [byte esp+040h]
        fcompp
        fnstsw ax
        sahf
        jae near .5
        mov edi, 3FC90FDBh
        mov edx, dword [byte esp+030h]
        mov dword [byte esp+014h], edi
        test edx, 7FFFFFFFh
        jne short .2
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        fldz
        fcomp dword [byte esp+038h]
        fnstsw ax
        sahf
        jbe short .3
        fld dword [byte esp+040h]
        mov ecx, 4096CBE4h
        fchs
        fstp dword [byte esp+040h]
        mov dword [byte esp+014h], ecx
.3:
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .4
        mov eax, dword [byte esp+040h]
        mov dword [byte ebx+020h], eax
        jmp near .21
.4:
        fld dword [byte esp+038h]
        fsub dword [byte esp+040h]
        fdiv dword [byte esp+030h]
        fst dword [byte esp+02Ch]
        fmul dword [byte esp+028h]
        fsubr dword [byte esp+034h]
        fstp dword [byte esp+044h]
        jmp short .9
.5:
        xor edx, edx
        mov ecx, dword [byte esp+028h]
        mov dword [byte esp+014h], edx
        test ecx, 7FFFFFFFh
        jne short .6
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        fldz
        fcomp dword [byte esp+034h]
        fnstsw ax
        sahf
        jbe short .7
        fld dword [byte esp+044h]
        mov esi, 40490FDBh
        fchs
        fstp dword [byte esp+044h]
        mov dword [byte esp+014h], esi
.7:
        mov eax, dword [puckc]
        cmp byte [eax], 0
        jl short .8
        mov eax, dword [byte esp+044h]
        jmp near .20
.8:
        fld dword [byte esp+034h]
        fsub dword [byte esp+044h]
        fdiv dword [byte esp+028h]
        fst dword [byte esp+02Ch]
        fmul dword [byte esp+030h]
        fsubr dword [byte esp+038h]
        fstp dword [byte esp+040h]
.9:
        mov eax, ebx
        push dword [byte esp+014h]
        call PuckHitsNet
        fld dword [byte esp+02Ch]
        fld1
        mov edx, dword [byte ebx+02Ch]
        fsubrp
        mov dword [esp], edx
        fstp dword [byte esp+02Ch]
        mov edx, dword [byte ebx+034h]
        fld dword [byte esp+02Ch]
        fmul dword [esp]
        mov dword [esp], edx
        fld dword [byte esp+02Ch]
        fmul dword [esp]
        fxch
        fadd dword [byte esp+040h]
        fxch
        fadd dword [byte esp+044h]
        fxch
        fstp dword [byte ebx+020h]
        fstp dword [byte ebx+028h]
        test eax, eax
        je near .21
        fld dword [byte ebx+040h]
        fsub dword [byte esp+014h]
        fld qword [F64_6p28319_PuckHitsGlass]
        fxch
        call IF@DFMOD
        fst dword [byte esp+03Ch]
        fst qword [byte esp+020h]
        fcomp qword [F64_3p14159_PuckHitsGlass]
        fnstsw ax
        sahf
        jbe short .10
        fld qword [byte esp+020h]
        fadd qword [F64_neg6p28319_PuckHitsGlass]
        fstp dword [byte esp+03Ch]
.10:
        fld dword [byte esp+03Ch]
        fst qword [byte esp+018h]
        fcomp qword [F64_neg3p14159_PuckHitsGlass]
        fnstsw ax
        sahf
        jae short .11
        fld qword [byte esp+018h]
        fadd qword [F64_6p28319_PuckHitsGlass]
        fstp dword [byte esp+03Ch]
.11:
        fld dword [byte esp+03Ch]
        fabs
        fcomp qword [F64_1p74533_PuckHitsGlass]
        fnstsw ax
        sahf
        jbe short .15
        mov esi, dword [byte ebx+024h]
        cmp esi, 43400000h
        jle short .12
        push dword [byte ebx+028h]
        mov edx, 64h
        mov eax, 413h
        jmp short .14
.12:
        cmp esi, 41C00000h
        jge short .13
        push dword [byte ebx+028h]
        mov edx, 64h
        mov eax, 412h
        jmp short .14
.13:
        push dword [byte ebx+028h]
        mov edx, 64h
        mov eax, 411h
.14:
        push dword [byte ebx+020h]
        call PlaySfxVolume
.15:
        fld dword [F32_2040_PuckHitsGlass]
        fsub dword [byte ebx+050h]
        fld dword [byte ebx+020h]
        fxch
        fstp dword [byte esp+010h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        jbe short .16
        mov eax, dword [byte esp+010h]
        jmp short .17
.16:
        fld dword [byte ebx+020h]
        fld dword [byte esp+010h]
        fchs
        fstp dword [byte esp+08h]
        fcomp dword [byte esp+08h]
        fnstsw ax
        sahf
        jae short .18
        mov eax, dword [byte esp+08h]
.17:
        mov dword [byte ebx+020h], eax
.18:
        fld dword [F32_4800_PuckHitsGlass]
        fsub dword [byte ebx+050h]
        fld dword [byte ebx+028h]
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jbe short .19
        mov eax, dword [byte esp+0Ch]
        mov dword [byte ebx+028h], eax
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.19:
        fld dword [byte ebx+028h]
        fld dword [byte esp+0Ch]
        fchs
        fstp dword [byte esp+04h]
        fcomp dword [byte esp+04h]
        fnstsw ax
        sahf
        jae short .21
        mov eax, dword [byte esp+04h]
.20:
        mov dword [byte ebx+028h], eax
.21:
        mov eax, 1
.22:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; NetCollisionPoint                               67540  97 PC, low confidence
; Works out where the puck meets the net
;-----------------------------------------------------------------------------
NetCollisionPoint:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 68h
        and esp, byte 0FFFFFFF8h
        mov edx, dword [byte ebp+028h]
        fld dword [byte eax+020h]
        fld dword [byte eax+028h]
        fld dword [dword eax+0D2h]
        fld dword [dword eax+0DAh]
        fxch st3
        fld dword [byte ebp+01Ch]
        fxch
        fsub st1
        fxch st3
        fld dword [byte ebp+020h]
        fxch
        fsub st1
        fxch st3
        fsubrp st2
        fsubp st4
        fxch st2
        fstp dword [byte esp+064h]
        fstp dword [byte esp+028h]
        fstp dword [byte esp+038h]
        fstp dword [byte esp+034h]
        fld dword [byte esp+028h]
        fsub dword [byte esp+034h]
        fld dword [byte esp+064h]
        fxch
        fstp dword [byte esp+01Ch]
        fcomp dword [byte esp+038h]
        fnstsw ax
        sahf
        jne near .17
        fld dword [byte esp+028h]
        fcomp dword [byte esp+034h]
        fnstsw ax
        sahf
        jne short .1
        xor eax, eax
        jmp near .35
.1:
        fld dword [byte esp+064h]
        fabs
        fcomp qword [F64_180_NetCollisionPoint]
        fnstsw ax
        sahf
        jb short .2
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.2:
        fld dword [byte esp+064h]
        fmul st0
        fmul qword [F64_3p08642eneg05]
        fld1
        fsubrp
        fsqrt
        fmul qword [F64_110_NetCollisionPoint]
        fst dword [byte esp+058h]
        fld dword [byte esp+034h]
        fxch
        fsub st1
        fld1
        fdiv dword [byte esp+01Ch]
        mov eax, dword [byte esp+064h]
        mov dword [edx], eax
        fld dword [byte esp+058h]
        fchs
        fst dword [byte esp+014h]
        fsubrp st3
        fxch
        fmul st1
        fxch st2
        fmulp
        mov edi, dword [byte ebp+024h]
        fxch
        fstp dword [byte esp+04Ch]
        fstp dword [byte esp+050h]
        test edi, edi
        je near .8
        fld dword [byte esp+04Ch]
        fcomp dword [byte esp+050h]
        fnstsw ax
        sahf
        jbe short .5
        fldz
        fcomp dword [byte esp+04Ch]
        fnstsw ax
        sahf
        ja short .3
        mov ecx, dword [byte esp+04Ch]
        cmp ecx, 3F800000h
        jle short .4
.3:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.4:
        mov eax, dword [byte esp+058h]
        mov dword [byte edx+04h], ecx
        mov dword [byte edx+08h], eax
        jmp near .34
.5:
        fldz
        fcomp dword [byte esp+050h]
        fnstsw ax
        sahf
        ja short .6
        mov ebx, dword [byte esp+050h]
        cmp ebx, 3F800000h
        jle short .7
.6:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.7:
        fld dword [byte esp+058h]
        mov dword [byte edx+04h], ebx
        fchs
        fstp dword [byte edx+08h]
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.8:
        fld dword [byte esp+04Ch]
        fcomp dword [byte esp+050h]
        fnstsw ax
        sahf
        jae near .13
        fldz
        fcomp dword [byte esp+04Ch]
        fnstsw ax
        sahf
        ja short .9
        mov esi, dword [byte esp+04Ch]
        cmp esi, 3F800000h
        jle short .12
.9:
        fldz
        fcomp dword [byte esp+050h]
        fnstsw ax
        sahf
        ja short .10
        mov edi, dword [byte esp+050h]
        cmp edi, 3F800000h
        jle short .11
.10:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.11:
        fld dword [byte esp+058h]
        mov dword [byte edx+04h], edi
        fchs
        fstp dword [byte edx+08h]
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.12:
        mov eax, dword [byte esp+058h]
        mov dword [byte edx+04h], esi
        mov dword [byte edx+08h], eax
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.13:
        fldz
        fcomp dword [byte esp+050h]
        fnstsw ax
        sahf
        ja short .14
        mov ebx, dword [byte esp+050h]
        cmp ebx, 3F800000h
        jle short .16
.14:
        fldz
        fcomp dword [byte esp+04Ch]
        fnstsw ax
        sahf
        ja short .15
        mov ecx, dword [byte esp+04Ch]
        cmp ecx, 3F800000h
        jle near .4
.15:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.16:
        mov eax, dword [byte esp+014h]
        mov dword [byte edx+04h], ebx
        mov dword [byte edx+08h], eax
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.17:
        fld dword [byte esp+064h]
        fld st0
        fsub dword [byte esp+038h]
        fld1
        fxch
        fstp dword [byte esp+010h]
        fdiv dword [byte esp+010h]
        fld dword [byte esp+01Ch]
        fxch
        fstp dword [byte esp+02Ch]
        fmul dword [byte esp+02Ch]
        fst dword [byte esp+054h]
        fmulp
        fld dword [byte esp+054h]
        fld st0
        fmul qword [F64_32400]
        fxch st2
        fsubr dword [byte esp+028h]
        fxch st2
        fmul st1
        fxch st2
        fst dword [byte esp+05Ch]
        fmul qword [F64_64800]
        fld dword [byte esp+05Ch]
        fmul st0
        fxch
        fmulp st2
        fadd qword [F64_neg12100]
        fxch st2
        fadd qword [F64_12100]
        fxch st2
        fmul qword [F64_180_NetCollisionPoint]
        fxch st2
        fst dword [byte esp+024h]
        fmul dword [F32_4_NetCollisionPoint]
        fxch st2
        fmul qword [F64_180_NetCollisionPoint]
        fmulp st2
        fst dword [byte esp+030h]
        fmul dword [byte esp+030h]
        fsubrp
        fldz
        fxch
        fstp dword [byte esp+060h]
        fcomp dword [byte esp+060h]
        fnstsw ax
        sahf
        jbe short .18
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.18:
        fld dword [byte esp+060h]
        fsqrt
        fst dword [byte esp+060h]
        fld dword [byte esp+030h]
        fxch
        fsub st1
        fld dword [byte esp+024h]
        fmul dword [F32_2_NetCollisionPoint]
        fld1
        fdivrp
        fxch st2
        fchs
        fsub dword [byte esp+060h]
        fxch
        fmul st2
        fxch
        fmulp st2
        fst dword [byte esp+040h]
        fld dword [byte esp+054h]
        fxch
        fmul st1
        fxch st2
        fst dword [byte esp+03Ch]
        fmulp
        fld dword [byte esp+03Ch]
        fld dword [byte esp+038h]
        fld dword [byte esp+040h]
        fsub st1
        fxch st2
        fsubrp
        fxch
        fld dword [byte esp+02Ch]
        fxch
        fmul st1
        fxch st2
        fmulp
        mov ebx, dword [byte ebp+024h]
        fxch st3
        fstp dword [byte esp+020h]
        fxch
        fstp dword [byte esp+018h]
        fstp dword [byte esp+044h]
        fstp dword [byte esp+048h]
        test ebx, ebx
        je short .23
        fld dword [byte esp+044h]
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        jbe short .21
        fldz
        fcomp dword [byte esp+044h]
        fnstsw ax
        sahf
        ja short .19
        mov esi, dword [byte esp+044h]
        cmp esi, 3F800000h
        jle short .20
.19:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.20:
        fld dword [byte esp+020h]
        mov eax, dword [byte esp+040h]
        mov dword [byte edx+04h], esi
        jmp near .33
.21:
        fldz
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        ja short .22
        mov ecx, dword [byte esp+048h]
        cmp ecx, 3F800000h
        jle near .32
.22:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.23:
        fld dword [byte esp+044h]
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        jae near .28
        fldz
        fcomp dword [byte esp+044h]
        fnstsw ax
        sahf
        ja short .24
        mov edi, dword [byte esp+044h]
        cmp edi, 3F800000h
        jle short .27
.24:
        fldz
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        ja short .25
        mov ebx, dword [byte esp+048h]
        cmp ebx, 3F800000h
        jle short .26
.25:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.26:
        fld dword [byte esp+03Ch]
        mov eax, dword [byte esp+03Ch]
        mov dword [byte edx+04h], ebx
        fmul dword [byte esp+054h]
        mov dword [edx], eax
        fadd dword [byte esp+05Ch]
        mov eax, 1
        fstp dword [byte edx+08h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.27:
        fld dword [byte esp+020h]
        mov eax, dword [byte esp+040h]
        mov dword [byte edx+04h], edi
        jmp near .33
.28:
        fldz
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        ja short .29
        mov ecx, dword [byte esp+048h]
        cmp ecx, 3F800000h
        jle short .32
.29:
        fldz
        fcomp dword [byte esp+044h]
        fnstsw ax
        sahf
        ja short .30
        mov esi, dword [byte esp+044h]
        cmp esi, 3F800000h
        jle short .31
.30:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.31:
        fld dword [byte esp+040h]
        mov eax, dword [byte esp+040h]
        mov dword [byte edx+04h], esi
        fmul dword [byte esp+054h]
        mov dword [edx], eax
        fadd dword [byte esp+05Ch]
        mov eax, 1
        fstp dword [byte edx+08h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
.32:
        fld dword [byte esp+018h]
        mov eax, dword [byte esp+03Ch]
        mov dword [byte edx+04h], ecx
.33:
        fadd dword [byte esp+05Ch]
        mov dword [edx], eax
        fstp dword [byte edx+08h]
.34:
        mov eax, 1
.35:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
        db 090h
;-----------------------------------------------------------------------------
; PuckInNetDepth                                  67A30  97 PC, low confidence
; Tests whether the puck is deep in the net
;-----------------------------------------------------------------------------
PuckInNetDepth:
        push edx
        push esi
        push edi
        sub esp, byte 10h
        mov edx, eax
        fld dword [byte eax+08h]
        fld dword [eax]
        call IF@ATAN2
        fstp dword [byte esp+08h]
        sub esp, byte 8
        fld dword [byte edx+08h]
        fstp qword [esp]
        lea edi, [byte esp+014h]
        sub esp, byte 8
        fld dword [edx]
        fstp qword [esp]
        lea esi, [byte esp+010h]
        call hypot_
        fadd dword [F32_12_PuckInNetDepth]
        lea eax, [byte esp+08h]
        fstp dword [byte esp+04h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte esp+04h]
        fmul dword [esp]
        fld dword [byte esp+04h]
        fxch
        fstp dword [edx]
        fmul dword [byte esp+0Ch]
        fstp dword [byte edx+08h]
        add esp, byte 10h
        pop edi
        pop esi
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PuckInNetWidth                                  67A98  97 PC, low confidence
; Tests whether the puck is inside the posts
;-----------------------------------------------------------------------------
PuckInNetWidth:
        push ebx
        push edx
        push esi
        push edi
        sub esp, byte 10h
        mov edx, eax
        fld dword [byte eax+08h]
        fld dword [eax]
        call IF@ATAN2
        fstp dword [byte esp+04h]
        sub esp, byte 8
        fld dword [byte edx+08h]
        fstp qword [esp]
        sub esp, byte 8
        fld dword [edx]
        fstp qword [esp]
        call hypot_
        fadd dword [F32_neg12_PuckInNetWidth]
        fldz
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jbe short .1
        xor ebx, ebx
        mov dword [byte esp+0Ch], ebx
.1:
        mov edi, esp
        lea esi, [byte esp+08h]
        lea eax, [byte esp+04h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte esp+0Ch]
        fld st0
        fmul dword [byte esp+08h]
        fstp dword [edx]
        fmul dword [esp]
        fstp dword [byte edx+08h]
        add esp, byte 10h
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PlayNetSound                                    67B10  97 PC, low confidence
; Plays the sound of the puck in the net
;-----------------------------------------------------------------------------
PlayNetSound:
        push ebx
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        fld dword [byte eax+040h]
        mov eax, dword [puckc]
        fsub dword [byte ebp+010h]
        mov bl, byte [eax]
        fstp dword [byte esp+010h]
        test bl, bl
        jge near .3
        cmp dword [byte edx+024h], 41000000h
        jg near .3
        cmp dword [byte edx+038h], 41400000h
        jl near .3
        fld qword [F64_6p28319_PlayNetSound]
        fld dword [byte esp+010h]
        call IF@DFMOD
        fst dword [byte esp+010h]
        fst qword [esp]
        fcomp qword [F64_3p14159_PlayNetSound]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [esp]
        fadd qword [F64_neg6p28319_PlayNetSound]
        fstp dword [byte esp+010h]
.1:
        fld dword [byte esp+010h]
        fst qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_PlayNetSound]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+08h]
        fadd qword [F64_6p28319_PlayNetSound]
        fstp dword [byte esp+010h]
.2:
        fld dword [byte esp+010h]
        fabs
        fcomp qword [F64_1p74533_PlayNetSound]
        fnstsw ax
        sahf
        jbe short .3
        push dword [byte edx+028h]
        mov eax, 41Bh
        push dword [byte edx+020h]
        mov edx, 64h
        call PlaySfxVolume
.3:
        mov esp, ebp
        pop ebp
        pop edx
        pop ebx
        ret 4
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CommentNetHit                                   67BD0  97 PC, low confidence
; Calls the commentary for a shot off the net
;-----------------------------------------------------------------------------
CommentNetHit:
        push ebx
        push edx
        mov ebx, eax
        mov edx, dword [PuckOwner]
        sar edx, 10h
        mov eax, edx
        shl eax, 5
        add eax, edx
        shl eax, 3
        add eax, SortCords
        test byte [dword eax+0BFh], 80h
        sete dl
        and edx, 0FFh
        xor ebx, edx
        je near .3
        cmp word [dword eax+0A9h], byte 0
        jne short .1
        mov edx, dword [dword eax+0A3h]
        sar edx, 18h
        sub edx, byte 19h
        imul edx, dword 125h
        mov ebx, dword [dword eax+0FEh]
        mov ebx, dword [dword ebx+0108h]
        add ebx, 1D42h
        jmp short .2
.1:
        mov edx, dword [dword eax+0A3h]
        sar edx, 18h
        imul edx, dword 125h
        mov ebx, dword [dword eax+0FEh]
        mov ebx, dword [dword ebx+0108h]
        add ebx, 0A3h
.2:
        add edx, ebx
        mov ebx, 1001h
        mov dword [LastTouchPlayer], ebx
        push ebx
        mov bh, byte [dword eax+0BFh]
        push dword 0B005h
        test bh, 40h
        setne al
        and eax, 0FFh
        push eax
        push edx
        push dword 0A0000017h
        call CommentaryEvent
        add esp, byte 14h
        pop edx
        pop ebx
        ret
.3:
        mov edx, 1000h
        mov dword [LastTouchPlayer], edx
        push edx
        mov bl, byte [dword eax+0BFh]
        push dword 0B001h
        test bl, 40h
        setne al
        and eax, 0FFh
        push eax
        push byte 0
        push dword 0A0000016h
        call CommentaryEvent
        add esp, byte 14h
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PuckOffPost                                     67CC0  97 PC, low confidence
; Bounces the puck off a post
;-----------------------------------------------------------------------------
PuckOffPost:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 58h
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        fld dword [dword eax+0D6h]
        fld dword [dword eax+0DAh]
        fld dword [byte eax+030h]
        fabs
        fxch st2
        fsub dword [byte ebp+020h]
        fxch
        fsub dword [byte ebp+024h]
        fxch
        fstp dword [byte esp+024h]
        fstp dword [byte esp+028h]
        fcomp qword [F64_0p0001_PuckOffPost]
        fnstsw ax
        sahf
        jae short .3
        fld dword [byte esp+024h]
        fmul st0
        mov eax, dword [byte esp+024h]
        fldz
        mov dword [byte esp+01Ch], eax
        fxch
        fsubr dword [F32_22p5625]
        mov dword [byte esp+044h], eax
        fstp dword [byte esp+040h]
        fcomp dword [byte esp+040h]
        fnstsw ax
        sahf
        jbe short .1
        xor ecx, ecx
        mov dword [byte esp+040h], ecx
        jmp short .2
.1:
        fld dword [byte esp+040h]
        fsqrt
        fstp dword [byte esp+040h]
.2:
        fld dword [byte esp+040h]
        fchs
        jmp near .8
.3:
        fild dword [byte edx+018h]
        fabs
        fcomp qword [F64_0p0001_PuckOffPost]
        fnstsw ax
        sahf
        jae short .6
        fld dword [byte esp+028h]
        fmul st0
        mov eax, dword [byte esp+028h]
        fldz
        mov dword [byte esp+018h], eax
        fxch
        fsubr dword [F32_22p5625]
        mov dword [byte esp+040h], eax
        fstp dword [byte esp+044h]
        fcomp dword [byte esp+044h]
        fnstsw ax
        sahf
        jbe short .4
        xor ebx, ebx
        mov dword [byte esp+044h], ebx
        jmp short .5
.4:
        fld dword [byte esp+044h]
        fsqrt
        fstp dword [byte esp+044h]
.5:
        fld dword [byte esp+044h]
        fchs
        fstp dword [byte esp+01Ch]
        jmp near .9
.6:
        fld dword [byte edx+034h]
        fdiv dword [byte edx+030h]
        fst dword [byte esp+020h]
        fmul dword [byte esp+024h]
        fld dword [byte esp+020h]
        fxch
        fsubr dword [byte esp+028h]
        fxch
        fmul dword [byte esp+020h]
        fxch
        fst dword [byte esp+010h]
        fmul dword [byte esp+010h]
        fld dword [byte esp+010h]
        fmul dword [F32_2_PuckOffPost]
        fld1
        faddp st3
        fxch
        fsub dword [F32_22p5625]
        fxch st2
        fst dword [byte esp+050h]
        fmul dword [F32_4_PuckOffPost]
        fxch
        fmul dword [byte esp+020h]
        fxch
        fmulp st2
        fst dword [byte esp+014h]
        fmul dword [byte esp+014h]
        fsubrp
        fldz
        fxch
        fstp dword [byte esp+048h]
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        jbe short .7
        xor eax, eax
        jmp near .13
.7:
        fld dword [byte esp+048h]
        fsqrt
        fst dword [byte esp+048h]
        fld dword [byte esp+014h]
        fxch
        fsub st1
        fld dword [byte esp+050h]
        fmul qword [F64_2_PuckOffPost]
        fld1
        fdivrp
        fxch st2
        fchs
        fsub dword [byte esp+048h]
        fxch
        fmul st2
        fxch
        fmulp st2
        fld dword [byte esp+020h]
        fld st0
        fxch st2
        fstp dword [byte esp+044h]
        fxch
        fmul dword [byte esp+044h]
        fxch st2
        fstp dword [byte esp+01Ch]
        fmul dword [byte esp+01Ch]
        fxch
        fadd dword [byte esp+010h]
        fxch
        fadd dword [byte esp+010h]
        fxch
        fstp dword [byte esp+040h]
.8:
        fstp dword [byte esp+018h]
.9:
        fld dword [byte esp+040h]
        fsub dword [byte esp+028h]
        sub esp, byte 8
        fld dword [byte esp+04Ch]
        fxch
        fstp qword [esp]
        fsub dword [byte esp+02Ch]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fld dword [byte esp+018h]
        fxch
        call __CHP
        fistp dword [byte esp+02Ch]
        mov eax, dword [byte esp+02Ch]
        fsub dword [byte esp+028h]
        sub esp, byte 8
        mov word [regd1], ax
        fld dword [byte esp+024h]
        fxch
        fstp qword [esp]
        fsub dword [byte esp+02Ch]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        call __CHP
        fistp dword [byte esp+02Ch]
        mov eax, dword [byte esp+02Ch]
        mov bx, word [regd1]
        mov word [GoalieTarget], ax
        cmp ax, bx
        jge short .10
        mov eax, dword [byte esp+01Ch]
        mov dword [byte esp+044h], eax
        mov eax, dword [byte esp+018h]
        mov dword [byte esp+040h], eax
.10:
        fld dword [byte esp+044h]
        fld st0
        fld dword [byte esp+040h]
        fld st0
        fxch st2
        fld st2
        fxch
        call IF@ATAN2
        fstp st2
        fxch st2
        fadd dword [byte ebp+020h]
        fxch st2
        fadd dword [byte ebp+024h]
        fxch st2
        fstp dword [byte edx+024h]
        fxch
        fstp dword [byte edx+028h]
        fstp dword [byte esp+04Ch]
        fld dword [byte edx+034h]
        fld dword [byte edx+030h]
        call IF@ATAN2
        fld dword [byte esp+04Ch]
        fadd qword [F64_3p14159_PuckOffPost]
        fsubrp
        fld qword [F64_6p28319_PuckOffPost]
        fxch
        call IF@DFMOD
        fst dword [byte esp+054h]
        fst qword [byte esp+038h]
        fcomp qword [F64_3p14159_PuckOffPost]
        fnstsw ax
        sahf
        jbe short .11
        fld qword [byte esp+038h]
        fadd qword [F64_neg6p28319_PuckOffPost]
        fstp dword [byte esp+054h]
.11:
        fld dword [byte esp+054h]
        fst qword [byte esp+030h]
        fcomp qword [F64_neg3p14159_PuckOffPost]
        fnstsw ax
        sahf
        jae short .12
        fld qword [byte esp+030h]
        fadd qword [F64_6p28319_PuckOffPost]
        fstp dword [byte esp+054h]
.12:
        fld dword [byte esp+04Ch]
        fadd dword [byte esp+054h]
        fstp dword [byte esp+04Ch]
        sub esp, byte 8
        fld dword [byte edx+034h]
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte edx+030h]
        fstp qword [esp]
        call hypot_
        fld st0
        fmul qword [F64_0p3]
        lea edi, [byte esp+010h]
        lea esi, [byte esp+08h]
        lea eax, [byte esp+04Ch]
        fstp st1
        fstp dword [byte esp+0Ch]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte esp+0Ch]
        fmul dword [byte esp+08h]
        fld dword [byte esp+0Ch]
        fxch
        fstp dword [byte edx+030h]
        fmul dword [byte esp+010h]
        sub esp, byte 8
        fst dword [byte edx+034h]
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte edx+02Ch]
        fstp qword [esp]
        call hypot_
        fld dword [byte edx+034h]
        fld dword [byte edx+02Ch]
        call IF@ATAN2
        fxch
        fstp dword [byte edx+038h]
        fstp dword [byte edx+040h]
        mov eax, 1
.13:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 0Ch
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PuckOffCrossbar                                 68030  97 PC, low confidence
; Bounces the puck off the crossbar
;-----------------------------------------------------------------------------
PuckOffCrossbar:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 54h
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        fld dword [dword eax+0D2h]
        fld dword [dword eax+0DAh]
        fld dword [byte eax+02Ch]
        fabs
        fxch st2
        fsub dword [byte ebp+01Ch]
        fxch
        fsub dword [byte ebp+024h]
        fxch
        fstp dword [byte esp+020h]
        fstp dword [byte esp+01Ch]
        fcomp qword [F64_0p0001_PuckOffCrossbar]
        fnstsw ax
        sahf
        jae short .3
        fld dword [byte esp+020h]
        fmul st0
        mov eax, dword [byte esp+020h]
        fldz
        mov dword [byte esp+014h], eax
        fxch
        fsubr dword [F32_22p5625_PuckOffCrossbar]
        mov dword [byte esp+03Ch], eax
        fstp dword [byte esp+048h]
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        jbe short .1
        xor ecx, ecx
        mov dword [byte esp+048h], ecx
        jmp short .2
.1:
        fld dword [byte esp+048h]
        fsqrt
        fstp dword [byte esp+048h]
.2:
        fld dword [byte esp+048h]
        fchs
        jmp near .8
.3:
        fild dword [byte edx+018h]
        fabs
        fcomp qword [F64_0p0001_PuckOffCrossbar]
        fnstsw ax
        sahf
        jae short .6
        fld dword [byte esp+01Ch]
        fmul st0
        mov eax, dword [byte esp+01Ch]
        fldz
        mov dword [byte esp+028h], eax
        fxch
        fsubr dword [F32_22p5625_PuckOffCrossbar]
        mov dword [byte esp+048h], eax
        fstp dword [byte esp+03Ch]
        fcomp dword [byte esp+03Ch]
        fnstsw ax
        sahf
        jbe short .4
        xor ebx, ebx
        mov dword [byte esp+03Ch], ebx
        jmp short .5
.4:
        fld dword [byte esp+03Ch]
        fsqrt
        fstp dword [byte esp+03Ch]
.5:
        fld dword [byte esp+03Ch]
        fchs
        fstp dword [byte esp+014h]
        jmp near .9
.6:
        fld dword [byte edx+034h]
        fdiv dword [byte edx+02Ch]
        fst dword [byte esp+018h]
        fmul dword [byte esp+020h]
        fld dword [byte esp+018h]
        fxch
        fsubr dword [byte esp+01Ch]
        fxch
        fmul dword [byte esp+018h]
        fxch
        fst dword [byte esp+08h]
        fmul dword [byte esp+08h]
        fld dword [byte esp+08h]
        fmul dword [F32_2_PuckOffCrossbar]
        fld1
        faddp st3
        fxch
        fsub dword [F32_22p5625_PuckOffCrossbar]
        fxch st2
        fst dword [byte esp+044h]
        fmul dword [F32_4_PuckOffCrossbar]
        fxch
        fmul dword [byte esp+018h]
        fxch
        fmulp st2
        fst dword [byte esp+010h]
        fmul dword [byte esp+010h]
        fsubrp
        fldz
        fxch
        fstp dword [byte esp+040h]
        fcomp dword [byte esp+040h]
        fnstsw ax
        sahf
        jbe short .7
        xor eax, eax
        jmp near .13
.7:
        fld dword [byte esp+040h]
        fsqrt
        fst dword [byte esp+040h]
        fld dword [byte esp+010h]
        fxch
        fsub st1
        fld dword [byte esp+044h]
        fmul qword [F64_2_PuckOffCrossbar]
        fld1
        fdivrp
        fxch st2
        fchs
        fsub dword [byte esp+040h]
        fxch
        fmul st2
        fxch
        fmulp st2
        fld dword [byte esp+018h]
        fld st0
        fxch st2
        fstp dword [byte esp+03Ch]
        fxch
        fmul dword [byte esp+03Ch]
        fxch st2
        fstp dword [byte esp+014h]
        fmul dword [byte esp+014h]
        fxch
        fadd dword [byte esp+08h]
        fxch
        fadd dword [byte esp+08h]
        fxch
        fstp dword [byte esp+048h]
.8:
        fstp dword [byte esp+028h]
.9:
        fld dword [byte esp+048h]
        fsub dword [byte esp+01Ch]
        sub esp, byte 8
        fld dword [byte esp+044h]
        fxch
        fstp qword [esp]
        fsub dword [byte esp+028h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fld dword [byte esp+028h]
        fxch
        call __CHP
        fistp dword [byte esp+024h]
        mov eax, dword [byte esp+024h]
        fsub dword [byte esp+01Ch]
        sub esp, byte 8
        mov word [regd1], ax
        fld dword [byte esp+01Ch]
        fxch
        fstp qword [esp]
        fsub dword [byte esp+028h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        call __CHP
        fistp dword [byte esp+024h]
        mov eax, dword [byte esp+024h]
        mov bx, word [regd1]
        mov word [GoalieTarget], ax
        cmp ax, bx
        jge short .10
        mov eax, dword [byte esp+014h]
        mov dword [byte esp+03Ch], eax
        mov eax, dword [byte esp+028h]
        mov dword [byte esp+048h], eax
.10:
        fld dword [byte esp+03Ch]
        fld st0
        fld dword [byte esp+048h]
        fld st0
        fxch st2
        fld st2
        fxch
        call IF@ATAN2
        fstp st2
        fxch st2
        fadd dword [byte ebp+01Ch]
        fxch st2
        fadd dword [byte ebp+024h]
        fxch st2
        fstp dword [byte edx+020h]
        fxch
        fstp dword [byte edx+028h]
        fstp dword [byte esp+050h]
        fld dword [byte edx+040h]
        fld dword [byte esp+050h]
        fadd qword [F64_3p14159_PuckOffCrossbar]
        fsubrp
        fld qword [F64_6p28319_PuckOffCrossbar]
        fxch
        call IF@DFMOD
        fst dword [byte esp+04Ch]
        fst qword [byte esp+034h]
        fcomp qword [F64_3p14159_PuckOffCrossbar]
        fnstsw ax
        sahf
        jbe short .11
        fld qword [byte esp+034h]
        fadd qword [F64_neg6p28319_PuckOffCrossbar]
        fstp dword [byte esp+04Ch]
.11:
        fld dword [byte esp+04Ch]
        fst qword [byte esp+02Ch]
        fcomp qword [F64_neg3p14159_PuckOffCrossbar]
        fnstsw ax
        sahf
        jae short .12
        fld qword [byte esp+02Ch]
        fadd qword [F64_6p28319_PuckOffCrossbar]
        fstp dword [byte esp+04Ch]
.12:
        fld dword [byte esp+050h]
        fadd dword [byte esp+04Ch]
        fstp dword [byte esp+050h]
        fld dword [byte edx+038h]
        fld st0
        fmul qword [F64_0p3_PuckOffCrossbar]
        lea edi, [byte esp+08h]
        mov eax, dword [byte esp+050h]
        lea esi, [byte esp+0Ch]
        mov dword [byte edx+040h], eax
        lea eax, [byte esp+050h]
        fstp st1
        fstp dword [byte edx+038h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte edx+038h]
        fmul dword [byte esp+0Ch]
        fld dword [byte edx+038h]
        fxch
        fstp dword [byte edx+02Ch]
        fmul dword [byte esp+08h]
        mov eax, 14h
        fstp dword [byte edx+034h]
        call randomd0
        cwde
        sub eax, byte 0Ah
        mov dword [byte esp+024h], eax
        fild dword [byte esp+024h]
        mov eax, 1
        fstp dword [byte edx+030h]
.13:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 0Ch
        db 090h
;-----------------------------------------------------------------------------
; PuckInHomeNet                                   68378  97 PC, low confidence
; Puck against the home team's net: goal, post or save
;-----------------------------------------------------------------------------
PuckInHomeNet:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 58h
        mov ecx, eax
        mov eax, dword [byte eax+020h]
        mov dword [byte ebp-018h], eax
        mov eax, dword [byte ecx+024h]
        mov dword [byte ebp-04h], eax
        mov eax, dword [byte ecx+028h]
        mov dword [byte ebp-010h], eax
        mov eax, dword [dword ecx+0D2h]
        xor esi, esi
        mov dword [byte ebp-014h], eax
        mov eax, dword [dword ecx+0D6h]
        xor edi, edi
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [dword ecx+0DAh]
        fld dword [byte ebp-04h]
        mov dword [byte ebp-08h], eax
        fcomp dword [F32_192_PuckInHomeNet]
        fnstsw ax
        sahf
        jbe short .1
        fld dword [byte ebp-0Ch]
        fcomp dword [F32_192_PuckInHomeNet]
        fnstsw ax
        sahf
        jbe short .1
        xor eax, eax
        jmp near .27
.1:
        fld dword [byte ebp-010h]
        fcomp dword [F32_4272_PuckInHomeNet]
        fnstsw ax
        sahf
        jae short .2
        fld dword [byte ebp-08h]
        fcomp dword [F32_4272_PuckInHomeNet]
        fnstsw ax
        sahf
        jb short .5
.2:
        fld dword [byte ebp-010h]
        fcomp dword [F32_4448]
        fnstsw ax
        sahf
        jbe short .3
        fld dword [byte ebp-08h]
        fcomp dword [F32_4448]
        fnstsw ax
        sahf
        ja short .5
.3:
        fld dword [byte ebp-018h]
        fcomp dword [F32_180]
        fnstsw ax
        sahf
        jbe short .4
        fld dword [byte ebp-014h]
        fcomp dword [F32_180]
        fnstsw ax
        sahf
        ja short .5
.4:
        fld dword [byte ebp-018h]
        fcomp dword [F32_neg180]
        fnstsw ax
        sahf
        jae short .6
        fld dword [byte ebp-014h]
        fcomp dword [F32_neg180]
        fnstsw ax
        sahf
        jae short .6
.5:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        fld dword [byte ebp-04h]
        fld dword [byte ebp-0Ch]
        xor edx, edx
        fxch
        fcomp dword [F32_192_PuckInHomeNet]
        fnstsw ax
        sahf
        seta al
        mov dl, al
        fcomp dword [F32_192_PuckInHomeNet]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor eax, edx
        je near .10
        fld dword [byte ebp-04h]
        fld dword [F32_192_PuckInHomeNet]
        fld dword [byte ecx+030h]
        fchs
        fxch st2
        fld dword [byte ebp-0Ch]
        fxch
        fsub st1
        fxch st2
        fsub st1
        fxch st3
        fmul qword [F64_0p5_PuckInHomeNet]
        fxch st3
        fdivrp st2
        fld st1
        fld1
        fsubrp
        fxch st3
        fstp dword [byte ecx+030h]
        fxch st2
        fstp st1
        fmul dword [byte ecx+030h]
        fadd dword [F32_192_PuckInHomeNet]
        fstp dword [byte ebp-04h]
        fcomp dword [F32_192_PuckInHomeNet]
        fnstsw ax
        sahf
        jbe short .8
        cmp dword [byte ecx+030h], 40800000h
        jge short .7
        mov edx, 8
        mov eax, ecx
        xor ebx, ebx
        mov dword [byte ecx+038h], 0
        call AddPenalty2
.7:
        fld dword [byte ebp-04h]
        fcomp dword [F32_193]
        fnstsw ax
        sahf
        jae short .9
        mov dword [byte ebp-04h], 43410000h
        jmp short .9
.8:
        fld dword [byte ebp-04h]
        fcomp dword [F32_191]
        fnstsw ax
        sahf
        jbe short .9
        mov dword [byte ebp-04h], 433F0000h
.9:
        mov eax, dword [byte ebp-04h]
        fld dword [byte ebp-04h]
        mov dword [byte ecx+024h], eax
        fcomp dword [F32_192_PuckInHomeNet]
        fnstsw ax
        sahf
        jb short .10
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        fld dword [byte ebp-010h]
        fcomp dword [byte ebp-08h]
        fnstsw ax
        sahf
        je near .18
        fld dword [byte ebp-08h]
        fcomp dword [F32_4272_PuckInHomeNet]
        fnstsw ax
        sahf
        ja near .17
        fld dword [byte ebp-010h]
        fcomp dword [F32_4272_PuckInHomeNet]
        fnstsw ax
        sahf
        jbe near .17
        fld dword [byte ebp-08h]
        fld dword [byte ebp-010h]
        fsub st1
        fld dword [byte ebp-018h]
        fld dword [F32_4272_PuckInHomeNet]
        fsubrp st3
        fld dword [byte ebp-014h]
        fxch
        fsub st1
        fxch st3
        fdivrp st2
        fxch st2
        fmul st1
        faddp st2
        fxch
        fst dword [byte ebp-028h]
        fabs
        fld dword [byte ebp-0Ch]
        fld dword [byte ebp-04h]
        fsub st1
        fmulp st3
        faddp st2
        fxch
        fstp dword [byte ebp-020h]
        fcomp qword [F64_144]
        fnstsw ax
        sahf
        jae short .11
        fld dword [byte ebp-020h]
        fcomp dword [F32_192_PuckInHomeNet]
        fnstsw ax
        sahf
        jae short .11
        mov eax, dword [PtrAwayIce]
        mov esi, 1
        call Goal
        jmp near .16
.11:
        fld dword [byte ebp-028h]
        fabs
        fcomp qword [F64_153p5]
        fnstsw ax
        sahf
        jae near .16
        fld dword [byte ebp-020h]
        fcomp dword [F32_201p5]
        fnstsw ax
        sahf
        jae near .16
        mov eax, ecx
        mov edx, 64h
        call RandomPuckSpin
        push dword [byte ebp-010h]
        mov eax, 414h
        push dword [byte ebp-018h]
        call PlaySfxVolume
        mov ah, byte [gmode]
        mov edi, 1
        test ah, 1
        jne short .12
        mov eax, 4
        call SetCrowdMood
        mov eax, edi
        call CommentNetHit
.12:
        fld dword [byte ebp-020h]
        fcomp dword [F32_192_PuckInHomeNet]
        fnstsw ax
        sahf
        jb short .13
        push dword 45858000h
        push dword [byte ebp-020h]
        mov eax, ecx
        push dword [byte ebp-028h]
        call PuckOffPost
        jmp short .16
.13:
        push dword 45858000h
        fldz
        push dword [byte ebp-020h]
        fcomp dword [byte ebp-028h]
        fnstsw ax
        sahf
        jae short .14
        xor eax, eax
        mov edx, 40629800h
        mov dword [byte ebp-04Ch], eax
        mov dword [byte ebp-048h], edx
        jmp short .15
.14:
        xor edx, edx
        mov ebx, 0C0629800h
        mov dword [byte ebp-04Ch], edx
        mov dword [byte ebp-048h], ebx
.15:
        fld qword [byte ebp-04Ch]
        sub esp, byte 4
        mov eax, ecx
        fstp dword [esp]
        call PuckOffCrossbar
.16:
        xor edx, edx
        call EndPenaltyShot
        mov word [OneTimerPasser], dx
        mov word [OneTimerReady], dx
        mov word [OneTimerTarget], dx
        test edi, edi
        je near .18
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.17:
        fld dword [byte ebp-010h]
        fcomp dword [F32_4272_PuckInHomeNet]
        fnstsw ax
        sahf
        ja near .18
        fld dword [byte ebp-08h]
        fcomp dword [F32_4272_PuckInHomeNet]
        fnstsw ax
        sahf
        jbe short .18
        fld dword [byte ebp-08h]
        fcomp dword [F32_4448]
        fnstsw ax
        sahf
        ja short .18
        fld dword [byte ebp-08h]
        fld dword [byte ebp-010h]
        fsub st1
        fld dword [byte ebp-018h]
        fld dword [F32_4272_PuckInHomeNet]
        fsubrp st3
        fld dword [byte ebp-014h]
        fxch
        fsub st1
        fxch st3
        fdivrp st2
        fxch st2
        fmul st1
        faddp st2
        fxch
        fabs
        fld dword [byte ebp-0Ch]
        fld dword [byte ebp-04h]
        fsub st1
        fmulp st3
        faddp st2
        fxch
        fstp dword [byte ebp-034h]
        fcomp qword [F64_144]
        fnstsw ax
        sahf
        jae short .18
        fld dword [byte ebp-034h]
        fcomp dword [F32_192_PuckInHomeNet]
        fnstsw ax
        sahf
        jae short .18
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.18:
        lea eax, [byte ebp-058h]
        push eax
        push esi
        push dword 45879000h
        mov eax, ecx
        push byte 0
        call NetCollisionPoint
        test eax, eax
        je near .27
        fld dword [byte ebp-050h]
        fld dword [byte ebp-058h]
        call IF@ATAN2
        fld dword [byte ebp-054h]
        fld1
        fsubrp
        fstp dword [byte ebp-054h]
        fld dword [dword ecx+0DAh]
        fadd qword [F64_neg4338]
        fstp dword [byte ebp-030h]
        mov eax, dword [dword ecx+0D2h]
        fstp dword [byte ebp-01Ch]
        mov dword [byte ebp-02Ch], eax
        test esi, esi
        je short .19
        xor edi, edi
        mov dword [byte ebp-024h], edi
        jmp short .23
.19:
        test byte [gmode], 1
        jne short .20
        mov dword [byte ebp-024h], 40000000h
        jmp short .23
.20:
        fld dword [byte ebp-02Ch]
        fabs
        fcomp qword [F64_228]
        fnstsw ax
        sahf
        ja short .21
        fld dword [byte ebp-030h]
        fabs
        fcomp qword [F64_228]
        fnstsw ax
        sahf
        jbe short .22
.21:
        mov dword [byte ebp-024h], 40000000h
        jmp short .23
.22:
        fld dword [byte ebp-02Ch]
        fmul to st0
        fmul qword [F64_3p08642eneg05_PuckInHomeNet]
        fld dword [byte ebp-030h]
        fmul to st0
        fmul qword [F64_8p26446eneg05]
        faddp
        fstp dword [byte ebp-024h]
.23:
        fld dword [byte ebp-058h]
        fabs
        fcomp qword [F64_108]
        fnstsw ax
        sahf
        jae short .24
        xor eax, eax
        mov dword [byte ebp-01Ch], eax
.24:
        cmp dword [byte ebp-024h], 3F800000h
        jle short .25
        lea eax, [byte ebp-058h]
        call PuckInNetDepth
        fld dword [byte ebp-01Ch]
        fld st0
        fadd qword [F64_3p14159_PuckInHomeNet]
        fstp st1
        fstp dword [byte ebp-01Ch]
        jmp short .26
.25:
        lea eax, [byte ebp-058h]
        call PuckInNetWidth
.26:
        mov eax, dword [dword ecx+0FAh]
        or byte [byte eax+030h], 10h
        mov eax, ecx
        push dword [byte ebp-01Ch]
        call PuckHitsNet
        mov eax, ecx
        push dword [byte ebp-01Ch]
        call PlayNetSound
        fld dword [byte ecx+038h]
        fld st0
        fmul qword [F64_0p9]
        fstp st1
        fstp dword [byte ecx+038h]
        mov eax, dword [byte ebp-058h]
        mov dword [byte ecx+020h], eax
        fld dword [byte ebp-050h]
        fadd dword [F32_4272_PuckInHomeNet]
        fadd qword [F64_66]
        mov eax, 1
        fstp dword [byte ecx+028h]
.27:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PuckInAwayNet                                   6889C  97 PC, low confidence
; Puck against the away team's net: goal, post or save
;-----------------------------------------------------------------------------
PuckInAwayNet:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 58h
        mov ecx, eax
        mov eax, dword [byte eax+020h]
        mov dword [byte ebp-018h], eax
        mov eax, dword [byte ecx+024h]
        mov dword [byte ebp-04h], eax
        mov eax, dword [byte ecx+028h]
        mov dword [byte ebp-010h], eax
        mov eax, dword [dword ecx+0D2h]
        xor esi, esi
        mov dword [byte ebp-014h], eax
        mov eax, dword [dword ecx+0D6h]
        xor edi, edi
        mov dword [byte ebp-0Ch], eax
        mov eax, dword [dword ecx+0DAh]
        fld dword [byte ebp-04h]
        mov dword [byte ebp-08h], eax
        fcomp dword [F32_192_PuckInAwayNet]
        fnstsw ax
        sahf
        jbe short .1
        fld dword [byte ebp-0Ch]
        fcomp dword [F32_192_PuckInAwayNet]
        fnstsw ax
        sahf
        jbe short .1
        xor eax, eax
        jmp near .27
.1:
        fld dword [byte ebp-010h]
        fcomp dword [F32_neg4272_PuckInAwayNet]
        fnstsw ax
        sahf
        jbe short .2
        fld dword [byte ebp-08h]
        fcomp dword [F32_neg4272_PuckInAwayNet]
        fnstsw ax
        sahf
        ja short .5
.2:
        fld dword [byte ebp-010h]
        fcomp dword [F32_neg4448]
        fnstsw ax
        sahf
        jae short .3
        fld dword [byte ebp-08h]
        fcomp dword [F32_neg4448]
        fnstsw ax
        sahf
        jb short .5
.3:
        fld dword [byte ebp-018h]
        fcomp dword [F32_180_PuckInAwayNet]
        fnstsw ax
        sahf
        jbe short .4
        fld dword [byte ebp-014h]
        fcomp dword [F32_180_PuckInAwayNet]
        fnstsw ax
        sahf
        ja short .5
.4:
        fld dword [byte ebp-018h]
        fcomp dword [F32_neg180_PuckInAwayNet]
        fnstsw ax
        sahf
        jae short .6
        fld dword [byte ebp-014h]
        fcomp dword [F32_neg180_PuckInAwayNet]
        fnstsw ax
        sahf
        jae short .6
.5:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.6:
        fld dword [byte ebp-04h]
        fcomp dword [F32_192_PuckInAwayNet]
        fnstsw ax
        sahf
        seta al
        mov edx, eax
        fld dword [byte ebp-0Ch]
        and edx, 0FFh
        fcomp dword [F32_192_PuckInAwayNet]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor eax, edx
        je near .10
        fld dword [byte ebp-04h]
        fld dword [F32_192_PuckInAwayNet]
        fld dword [byte ecx+030h]
        fchs
        fxch st2
        fld dword [byte ebp-0Ch]
        fxch
        fsub st1
        fxch st2
        fsub st1
        fxch st3
        fmul qword [F64_0p5_PuckInAwayNet]
        fxch st3
        fdivrp st2
        fld st1
        fld1
        fsubrp
        fxch st3
        fstp dword [byte ecx+030h]
        fxch st2
        fstp st1
        fmul dword [byte ecx+030h]
        fadd dword [F32_192_PuckInAwayNet]
        fstp dword [byte ebp-04h]
        fcomp dword [F32_192_PuckInAwayNet]
        fnstsw ax
        sahf
        jbe short .8
        cmp dword [byte ecx+030h], 40800000h
        jge short .7
        mov edx, 8
        mov eax, ecx
        xor ebx, ebx
        mov dword [byte ecx+038h], 0
        call AddPenalty2
.7:
        fld dword [byte ebp-04h]
        fcomp dword [F32_193_PuckInAwayNet]
        fnstsw ax
        sahf
        jae short .9
        mov dword [byte ebp-04h], 43410000h
        jmp short .9
.8:
        fld dword [byte ebp-04h]
        fcomp dword [F32_191_PuckInAwayNet]
        fnstsw ax
        sahf
        jbe short .9
        mov dword [byte ebp-04h], 433F0000h
.9:
        mov eax, dword [byte ebp-04h]
        fld dword [byte ebp-04h]
        mov dword [byte ecx+024h], eax
        fcomp dword [F32_192_PuckInAwayNet]
        fnstsw ax
        sahf
        jb short .10
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        fld dword [byte ebp-010h]
        fcomp dword [byte ebp-08h]
        fnstsw ax
        sahf
        je near .18
        fld dword [byte ebp-08h]
        fcomp dword [F32_neg4272_PuckInAwayNet]
        fnstsw ax
        sahf
        jb near .17
        fld dword [byte ebp-010h]
        fcomp dword [F32_neg4272_PuckInAwayNet]
        fnstsw ax
        sahf
        jae near .17
        fld dword [byte ebp-08h]
        fld dword [byte ebp-010h]
        fsub st1
        fld dword [byte ebp-018h]
        fld dword [F32_neg4272_PuckInAwayNet]
        fsubrp st3
        fld dword [byte ebp-014h]
        fxch
        fsub st1
        fxch st3
        fdivrp st2
        fxch st2
        fmul st1
        faddp st2
        fxch
        fst dword [byte ebp-028h]
        fabs
        fld dword [byte ebp-0Ch]
        fld dword [byte ebp-04h]
        fsub st1
        fmulp st3
        faddp st2
        fxch
        fstp dword [byte ebp-020h]
        fcomp qword [F64_144_PuckInAwayNet]
        fnstsw ax
        sahf
        jae short .11
        fld dword [byte ebp-020h]
        fcomp dword [F32_192_PuckInAwayNet]
        fnstsw ax
        sahf
        jae short .11
        mov eax, dword [PtrHomeIce]
        mov esi, 1
        call Goal
        jmp near .16
.11:
        fld dword [byte ebp-028h]
        fabs
        fcomp qword [F64_153p5_PuckInAwayNet]
        fnstsw ax
        sahf
        jae near .16
        fld dword [byte ebp-020h]
        fcomp dword [F32_201p5_PuckInAwayNet]
        fnstsw ax
        sahf
        jae near .16
        mov eax, ecx
        mov edx, 64h
        call RandomPuckSpin
        push dword [byte ebp-010h]
        mov eax, 414h
        push dword [byte ebp-018h]
        call PlaySfxVolume
        mov ah, byte [gmode]
        mov edi, 1
        test ah, 1
        jne short .12
        mov eax, 4
        call SetCrowdMood
        xor eax, eax
        call CommentNetHit
.12:
        fld dword [byte ebp-020h]
        fcomp dword [F32_192_PuckInAwayNet]
        fnstsw ax
        sahf
        jb short .13
        push dword 0C5858000h
        push dword [byte ebp-020h]
        mov eax, ecx
        push dword [byte ebp-028h]
        call PuckOffPost
        jmp short .16
.13:
        push dword 0C5858000h
        fldz
        push dword [byte ebp-020h]
        fcomp dword [byte ebp-028h]
        fnstsw ax
        sahf
        jae short .14
        xor eax, eax
        mov edx, 40629800h
        mov dword [byte ebp-04Ch], eax
        mov dword [byte ebp-048h], edx
        jmp short .15
.14:
        xor edx, edx
        mov ebx, 0C0629800h
        mov dword [byte ebp-04Ch], edx
        mov dword [byte ebp-048h], ebx
.15:
        fld qword [byte ebp-04Ch]
        sub esp, byte 4
        mov eax, ecx
        fstp dword [esp]
        call PuckOffCrossbar
.16:
        xor edx, edx
        call EndPenaltyShot
        mov word [OneTimerPasser], dx
        mov word [OneTimerReady], dx
        mov word [OneTimerTarget], dx
        test edi, edi
        je near .18
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.17:
        fld dword [byte ebp-010h]
        fcomp dword [F32_neg4272_PuckInAwayNet]
        fnstsw ax
        sahf
        jbe near .18
        fld dword [byte ebp-08h]
        fcomp dword [F32_neg4272_PuckInAwayNet]
        fnstsw ax
        sahf
        jae short .18
        fld dword [byte ebp-08h]
        fcomp dword [F32_neg4448]
        fnstsw ax
        sahf
        jb short .18
        fld dword [byte ebp-08h]
        fld dword [byte ebp-010h]
        fsub st1
        fld dword [byte ebp-018h]
        fld dword [F32_neg4272_PuckInAwayNet]
        fsubrp st3
        fld dword [byte ebp-014h]
        fxch
        fsub st1
        fxch st3
        fdivrp st2
        fxch st2
        fmul st1
        faddp st2
        fxch
        fabs
        fld dword [byte ebp-0Ch]
        fld dword [byte ebp-04h]
        fsub st1
        fmulp st3
        faddp st2
        fxch
        fstp dword [byte ebp-034h]
        fcomp qword [F64_144_PuckInAwayNet]
        fnstsw ax
        sahf
        jae short .18
        fld dword [byte ebp-034h]
        fcomp dword [F32_192_PuckInAwayNet]
        fnstsw ax
        sahf
        jae short .18
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.18:
        lea eax, [byte ebp-058h]
        push eax
        push esi
        push dword 0C5879000h
        mov eax, ecx
        push byte 0
        call NetCollisionPoint
        test eax, eax
        je near .27
        fld dword [byte ebp-050h]
        fld dword [byte ebp-058h]
        call IF@ATAN2
        fld dword [byte ebp-054h]
        fld1
        fsubrp
        fstp dword [byte ebp-054h]
        fld dword [dword ecx+0DAh]
        fadd qword [F64_4338]
        fstp dword [byte ebp-030h]
        mov eax, dword [dword ecx+0D2h]
        fstp dword [byte ebp-01Ch]
        mov dword [byte ebp-02Ch], eax
        test esi, esi
        je short .19
        xor edi, edi
        mov dword [byte ebp-024h], edi
        jmp short .23
.19:
        test byte [gmode], 1
        jne short .20
        mov dword [byte ebp-024h], 40000000h
        jmp short .23
.20:
        fld dword [byte ebp-02Ch]
        fabs
        fcomp qword [F64_228_PuckInAwayNet]
        fnstsw ax
        sahf
        ja short .21
        fld dword [byte ebp-030h]
        fabs
        fcomp qword [F64_228_PuckInAwayNet]
        fnstsw ax
        sahf
        jbe short .22
.21:
        mov dword [byte ebp-024h], 40000000h
        jmp short .23
.22:
        fld dword [byte ebp-02Ch]
        fmul to st0
        fmul qword [F64_3p08642eneg05_PuckInAwayNet]
        fld dword [byte ebp-030h]
        fmul to st0
        fmul qword [F64_8p26446eneg05_PuckInAwayNet]
        faddp
        fstp dword [byte ebp-024h]
.23:
        fld dword [byte ebp-058h]
        fabs
        fcomp qword [F64_108_PuckInAwayNet]
        fnstsw ax
        sahf
        jae short .24
        mov dword [byte ebp-01Ch], 40490FDBh
.24:
        cmp dword [byte ebp-024h], 3F800000h
        jle short .25
        lea eax, [byte ebp-058h]
        call PuckInNetDepth
        fld dword [byte ebp-01Ch]
        fld st0
        fadd qword [F64_3p14159_PuckInAwayNet]
        fstp st1
        fstp dword [byte ebp-01Ch]
        jmp short .26
.25:
        lea eax, [byte ebp-058h]
        call PuckInNetWidth
.26:
        mov eax, dword [dword ecx+0FAh]
        or byte [byte eax+030h], 10h
        mov eax, ecx
        push dword [byte ebp-01Ch]
        call PuckHitsNet
        mov eax, ecx
        push dword [byte ebp-01Ch]
        call PlayNetSound
        fld dword [byte ecx+038h]
        fld st0
        fmul qword [F64_0p9_PuckInAwayNet]
        fstp st1
        fstp dword [byte ecx+038h]
        mov eax, dword [byte ebp-058h]
        mov dword [byte ecx+020h], eax
        fld dword [byte ebp-050h]
        fadd qword [F64_neg4338_PuckInAwayNet]
        mov eax, 1
        fstp dword [byte ecx+028h]
.27:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PuckBehindNet                                   68DBC  97 PC, low confidence
; Puck against the back of a net
;-----------------------------------------------------------------------------
PuckBehindNet:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 6Ch
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov ecx, edx
        fld dword [byte ebx+020h]
        fld dword [byte ebx+028h]
        fld dword [dword ebx+0D2h]
        mov eax, dword [byte eax+024h]
        fld dword [dword ebx+0DAh]
        mov dword [byte esp+048h], eax
        fxch st3
        fsub dword [byte edx+020h]
        fxch st2
        fsub dword [byte edx+028h]
        fxch
        fsub dword [byte edx+020h]
        fxch st3
        fsub dword [byte edx+028h]
        fld dword [byte esp+048h]
        fxch st3
        fstp dword [byte esp+03Ch]
        fxch
        fstp dword [byte esp+044h]
        fxch st2
        fstp dword [byte esp+068h]
        fxch
        fstp dword [byte esp+060h]
        mov eax, dword [dword ebx+0D6h]
        xor edx, edx
        mov dword [byte esp+040h], eax
        mov dword [byte esp+01Ch], edx
        fcomp dword [F32_192_PuckBehindNet]
        fnstsw ax
        sahf
        jbe short .1
        fld dword [byte esp+040h]
        fcomp dword [F32_192_PuckBehindNet]
        fnstsw ax
        sahf
        jbe short .1
        xor eax, eax
        jmp near .27
.1:
        cmp byte [dword ecx+0A4h], 0Fh
        jne short .2
        mov eax, 5A7ED197h
        mov edx, 400921FBh
        mov dword [byte esp+050h], eax
        mov dword [byte esp+054h], edx
        jmp short .3
.2:
        xor esi, esi
        mov dword [byte esp+050h], esi
        mov dword [byte esp+054h], esi
.3:
        fld qword [byte esp+050h]
        fstp dword [byte esp+05Ch]
        cmp byte [dword ecx+0A4h], 0Fh
        jne short .4
        mov dword [byte esp+030h], 10B0h
        jmp short .5
.4:
        mov dword [byte esp+030h], 0FFFFEF50h
.5:
        fild dword [byte esp+030h]
        mov eax, dword [byte ecx+020h]
        fstp dword [byte esp+02Ch]
        test eax, 7FFFFFFFh
        jne short .7
        fld dword [byte ecx+028h]
        fcomp dword [byte esp+02Ch]
        fnstsw ax
        sahf
        jne short .7
        fld dword [byte ecx+01Ch]
        fcomp dword [byte esp+05Ch]
        fnstsw ax
        sahf
        jne short .7
        cmp ecx, dword [PtrAwayIce]
        jne short .6
        mov eax, ebx
        call PuckInHomeNet
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.6:
        mov eax, ebx
        call PuckInAwayNet
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.7:
        fld dword [byte ecx+01Ch]
        lea edi, [byte esp+014h]
        lea esi, [byte esp+018h]
        fchs
        lea eax, [byte esp+05Ch]
        fstp dword [byte esp+05Ch]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte esp+068h]
        fmul dword [byte esp+014h]
        fld dword [byte esp+03Ch]
        fmul dword [byte esp+014h]
        mov eax, dword [byte esp+068h]
        fld dword [byte esp+060h]
        fmul dword [byte esp+018h]
        mov dword [byte esp+04Ch], eax
        fld dword [byte esp+044h]
        fmul dword [byte esp+018h]
        fld dword [byte esp+04Ch]
        fchs
        fmul dword [byte esp+018h]
        mov eax, dword [byte esp+03Ch]
        fld dword [byte esp+060h]
        mov dword [byte esp+04Ch], eax
        fmul dword [byte esp+014h]
        fld dword [byte esp+04Ch]
        fxch st4
        faddp st6
        fxch st3
        fchs
        fmul dword [byte esp+018h]
        fxch st5
        fstp dword [byte esp+068h]
        fld dword [byte esp+044h]
        fmul dword [byte esp+014h]
        fxch st2
        faddp st4
        fldz
        fxch st4
        fstp dword [byte esp+03Ch]
        faddp st2
        faddp st3
        fstp dword [byte esp+060h]
        fxch
        fstp dword [byte esp+044h]
        fcomp dword [byte esp+044h]
        fnstsw ax
        sahf
        jae short .8
        fldz
        fcomp dword [byte esp+060h]
        fnstsw ax
        sahf
        jb short .11
.8:
        fld dword [byte esp+044h]
        fcomp dword [F32_neg176]
        fnstsw ax
        sahf
        jae short .9
        fld dword [byte esp+060h]
        fcomp dword [F32_neg176]
        fnstsw ax
        sahf
        jb short .11
.9:
        fld dword [byte esp+03Ch]
        fcomp dword [F32_180_PuckBehindNet]
        fnstsw ax
        sahf
        jbe short .10
        fld dword [byte esp+068h]
        fcomp dword [F32_180_PuckBehindNet]
        fnstsw ax
        sahf
        ja short .11
.10:
        fld dword [byte esp+03Ch]
        fcomp dword [F32_neg180_PuckBehindNet]
        fnstsw ax
        sahf
        jae short .12
        fld dword [byte esp+068h]
        fcomp dword [F32_neg180_PuckBehindNet]
        fnstsw ax
        sahf
        jae short .12
.11:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.12:
        fld dword [byte esp+040h]
        fld dword [byte esp+048h]
        fcomp dword [F32_192_PuckBehindNet]
        fnstsw ax
        sahf
        seta al
        movzx esi, al
        fcomp dword [F32_192_PuckBehindNet]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor eax, esi
        je near .15
        fld dword [byte esp+048h]
        fld dword [F32_192_PuckBehindNet]
        fld dword [byte ebx+030h]
        fchs
        fxch st2
        fld dword [byte esp+040h]
        fxch
        fsub st1
        fxch st2
        fsub st1
        fxch st3
        fmul qword [F64_0p5_PuckBehindNet]
        fxch st3
        fdivrp st2
        fld st1
        fld1
        fsubrp
        fxch st3
        fstp dword [byte ebx+030h]
        fxch st2
        fstp st1
        fmul dword [byte ebx+030h]
        fadd dword [F32_192_PuckBehindNet]
        fstp dword [byte esp+048h]
        fcomp dword [F32_192_PuckBehindNet]
        fnstsw ax
        sahf
        jbe short .13
        fld dword [byte esp+048h]
        fcomp dword [F32_193_PuckBehindNet]
        fnstsw ax
        sahf
        jae short .14
        mov dword [byte esp+048h], 43410000h
        jmp short .14
.13:
        fld dword [byte esp+048h]
        fcomp dword [F32_191_PuckBehindNet]
        fnstsw ax
        sahf
        jbe short .14
        mov dword [byte esp+048h], 433F0000h
.14:
        mov eax, dword [byte esp+048h]
        fld dword [byte esp+048h]
        mov dword [byte ebx+024h], eax
        fcomp dword [F32_192_PuckBehindNet]
        fnstsw ax
        sahf
        jb short .15
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.15:
        fld dword [byte esp+044h]
        fcomp dword [byte esp+060h]
        fnstsw ax
        sahf
        je near .18
        fldz
        fcomp dword [byte esp+060h]
        fnstsw ax
        sahf
        ja near .19
        fldz
        fcomp dword [byte esp+044h]
        fnstsw ax
        sahf
        jbe near .19
        fld dword [byte esp+03Ch]
        fld dword [byte esp+060h]
        fld dword [byte esp+044h]
        fsub st1
        fxch st2
        fld dword [byte esp+068h]
        fxch
        fsub st1
        fxch st2
        fchs
        fdivrp st3
        fxch
        fmul st2
        faddp
        fst dword [byte esp+058h]
        fabs
        fld dword [byte esp+040h]
        fld dword [byte esp+048h]
        fsub st1
        fmulp st3
        faddp st2
        fxch
        fstp dword [byte esp+034h]
        fcomp qword [F64_144_PuckBehindNet]
        fnstsw ax
        sahf
        jae short .16
        fld dword [byte esp+034h]
        fcomp dword [F32_192_PuckBehindNet]
        fnstsw ax
        sahf
        jae short .16
        mov dword [byte esp+01Ch], 1
        jmp short .17
.16:
        fld dword [byte esp+058h]
        fabs
        fcomp qword [F64_153p5_PuckBehindNet]
        fnstsw ax
        sahf
        jae short .17
        fld dword [byte esp+034h]
        fcomp dword [F32_201p5_PuckBehindNet]
        fnstsw ax
        sahf
        jae short .17
        mov eax, 14h
        call randomd0
        cwde
        sub eax, byte 0Ah
        mov dword [byte esp+024h], eax
        mov edx, 64h
        fild dword [byte esp+024h]
        mov eax, ebx
        fstp dword [byte ebx+030h]
        call RandomPuckSpin
        push dword [byte ebx+028h]
        mov eax, 414h
        push dword [byte ebx+020h]
        call PlaySfxVolume
        test byte [gmode], 1
        jne short .17
        mov eax, 4
        call SetCrowdMood
        xor eax, eax
        call CommentNetHit
.17:
        xor edx, edx
        call EndPenaltyShot
        mov word [OneTimerPasser], dx
        mov word [OneTimerReady], dx
        mov word [OneTimerTarget], dx
.18:
        mov eax, esp
        push eax
        mov eax, dword [byte esp+020h]
        push eax
        push dword 0C2840000h
        mov eax, ebx
        push byte 0
        call NetCollisionPoint
        test eax, eax
        je near .27
        fld dword [byte esp+08h]
        fld dword [esp]
        call IF@ATAN2
        fld dword [byte esp+04h]
        fld dword [byte esp+060h]
        fld1
        mov edx, dword [byte esp+01Ch]
        fxch
        fadd qword [F64_66_PuckBehindNet]
        fxch
        fsubrp st2
        fstp dword [byte esp+064h]
        fstp dword [byte esp+04h]
        fstp dword [byte esp+05Ch]
        test edx, edx
        je near .20
        xor edi, edi
        mov dword [byte esp+038h], edi
        jmp near .23
.19:
        fldz
        fcomp dword [byte esp+044h]
        fnstsw ax
        sahf
        jae short .18
        fldz
        fcomp dword [byte esp+060h]
        fnstsw ax
        sahf
        jbe short .18
        fld dword [byte esp+060h]
        fcomp dword [F32_neg176]
        fnstsw ax
        sahf
        jb near .18
        fld dword [byte esp+03Ch]
        fld dword [byte esp+060h]
        fld dword [byte esp+044h]
        fsub st1
        fxch st2
        fld dword [byte esp+068h]
        fxch
        fsub st1
        fxch st2
        fchs
        fdivrp st3
        fxch
        fmul st2
        faddp
        fabs
        fld dword [byte esp+040h]
        fld dword [byte esp+048h]
        fsub st1
        fmulp st3
        faddp st2
        fxch
        fstp dword [byte esp+028h]
        fcomp qword [F64_144_PuckBehindNet]
        fnstsw ax
        sahf
        jae near .18
        fld dword [byte esp+028h]
        fcomp dword [F32_192_PuckBehindNet]
        fnstsw ax
        sahf
        jae near .18
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.20:
        fld dword [byte esp+068h]
        fabs
        fcomp qword [F64_228_PuckBehindNet]
        fnstsw ax
        sahf
        ja short .21
        fld dword [byte esp+064h]
        fabs
        fcomp qword [F64_228_PuckBehindNet]
        fnstsw ax
        sahf
        jbe short .22
.21:
        mov dword [byte esp+038h], 40000000h
        jmp short .23
.22:
        fld dword [byte esp+068h]
        fmul to st0
        fmul qword [F64_3p08642eneg05_PuckBehindNet]
        fld dword [byte esp+064h]
        fmul to st0
        fmul qword [F64_8p26446eneg05_PuckBehindNet]
        faddp
        fstp dword [byte esp+038h]
.23:
        fld dword [esp]
        fabs
        fcomp qword [F64_108_PuckBehindNet]
        fnstsw ax
        sahf
        jae short .24
        mov dword [byte esp+05Ch], 40490FDBh
.24:
        cmp dword [byte esp+038h], 3F800000h
        jle short .25
        mov eax, esp
        call PuckInNetDepth
        fld dword [byte esp+05Ch]
        fld st0
        fadd qword [F64_3p14159_PuckBehindNet]
        fstp st1
        fstp dword [byte esp+05Ch]
        jmp short .26
.25:
        mov eax, esp
        call PuckInNetWidth
.26:
        fld dword [esp]
        fmul dword [byte esp+014h]
        fld dword [byte esp+08h]
        fld dword [byte esp+018h]
        fchs
        fld st1
        mov eax, dword [esp]
        fxch
        fstp dword [byte esp+018h]
        mov dword [byte esp+024h], eax
        fadd qword [F64_neg66]
        fld dword [byte esp+024h]
        fchs
        fmul dword [byte esp+018h]
        fxch
        fstp st2
        fxch
        fst dword [byte esp+08h]
        fmul dword [byte esp+018h]
        fld dword [byte esp+08h]
        fmul dword [byte esp+014h]
        fld dword [byte esp+05Ch]
        fxch st2
        faddp st4
        faddp st2
        fxch st2
        fstp dword [esp]
        fstp dword [byte esp+08h]
        fadd dword [byte ecx+01Ch]
        fstp dword [byte esp+05Ch]
        mov eax, dword [dword ebx+0FAh]
        or byte [byte eax+030h], 10h
        mov eax, ebx
        push dword [byte esp+05Ch]
        call PuckHitsNet
        mov eax, ebx
        push dword [byte esp+05Ch]
        call PlayNetSound
        fld dword [byte ebx+038h]
        fld st0
        fmul qword [F64_0p9_PuckBehindNet]
        fstp st1
        fstp dword [byte ebx+038h]
        fld dword [byte ecx+020h]
        fadd dword [esp]
        fstp dword [byte ebx+020h]
        fld dword [byte ecx+028h]
        fadd dword [byte esp+08h]
        mov eax, 1
        fstp dword [byte ebx+028h]
.27:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CheckPuckNets                                   69410  97 PC, low confidence
; Checks the puck against both nets
;-----------------------------------------------------------------------------
CheckPuckNets:
        push ebx
        push edx
        mov ebx, eax
        test byte [gmode], 1
        jne short .2
        mov eax, ebx
        call PuckInHomeNet
        test eax, eax
        je short .1
        mov eax, 1
        pop edx
        pop ebx
        ret
.1:
        mov eax, ebx
        call PuckInAwayNet
        test eax, eax
        je short .4
        mov eax, 2
        pop edx
        pop ebx
        ret
.2:
        mov edx, dword [PtrAwayIce]
        mov eax, ebx
        call PuckBehindNet
        test eax, eax
        je short .3
        mov eax, 1
        pop edx
        pop ebx
        ret
.3:
        mov edx, dword [PtrHomeIce]
        mov eax, ebx
        call PuckBehindNet
        test eax, eax
        je short .4
        mov eax, 2
        pop edx
        pop ebx
        ret
.4:
        xor eax, eax
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; GoalLinePuckTest                                6947C  97 PC, low confidence
; Tests whether the puck crossed the goal line (for the goal judge)
;-----------------------------------------------------------------------------
GoalLinePuckTest:
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 24h
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        fldz
        fcomp dword [byte eax+028h]
        fnstsw ax
        sahf
        jae short .1
        mov eax, dword [PtrAwayIce]
        jmp short .2
.1:
        mov eax, dword [PtrHomeIce]
.2:
        fld dword [byte edx+020h]
        fld dword [byte edx+028h]
        fld dword [byte eax+01Ch]
        lea edi, [byte esp+0Ch]
        lea esi, [byte esp+018h]
        fxch st2
        fsub dword [byte eax+020h]
        fxch
        fsub dword [byte eax+028h]
        fxch
        fstp dword [byte esp+020h]
        fstp dword [byte esp+01Ch]
        fchs
        lea eax, [byte esp+08h]
        fstp dword [byte esp+08h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        mov eax, dword [byte esp+020h]
        fld dword [byte esp+020h]
        mov dword [byte esp+010h], eax
        fmul dword [byte esp+0Ch]
        fld dword [byte esp+010h]
        fchs
        fmul dword [byte esp+018h]
        fld dword [byte esp+01Ch]
        fmul dword [byte esp+018h]
        fld dword [byte esp+01Ch]
        fmul dword [byte esp+0Ch]
        fldz
        fxch st2
        faddp st4
        faddp st2
        fxch st2
        fstp dword [byte esp+020h]
        fstp dword [byte esp+01Ch]
        fcomp dword [byte esp+01Ch]
        fnstsw ax
        sahf
        jb short .3
        fld dword [byte esp+01Ch]
        fcomp dword [F32_neg176_GoalLinePuckTest]
        fnstsw ax
        sahf
        jb short .3
        fld dword [byte esp+020h]
        fcomp dword [F32_180_GoalLinePuckTest]
        fnstsw ax
        sahf
        ja short .3
        fld dword [byte esp+020h]
        fcomp dword [F32_neg180_GoalLinePuckTest]
        fnstsw ax
        sahf
        jae short .4
.3:
        xor eax, eax
        jmp near .9
.4:
        fld dword [byte esp+020h]
        fabs
        fld dword [byte esp+01Ch]
        fld st0
        fadd qword [F64_66_GoalLinePuckTest]
        fstp st1
        fstp dword [byte esp+01Ch]
        fcomp qword [F64_228_GoalLinePuckTest]
        fnstsw ax
        sahf
        ja short .5
        fld dword [byte esp+01Ch]
        fabs
        fcomp qword [F64_228_GoalLinePuckTest]
        fnstsw ax
        sahf
        jbe short .6
.5:
        mov dword [byte esp+014h], 40000000h
        jmp short .7
.6:
        fld dword [byte esp+020h]
        fmul to st0
        fmul qword [F64_3p08642eneg05_GoalLinePuckTest]
        fld dword [byte esp+01Ch]
        fmul to st0
        fmul qword [F64_8p26446eneg05_GoalLinePuckTest]
        faddp
        fstp dword [byte esp+014h]
.7:
        cmp dword [byte esp+014h], 3F800000h
        jle short .8
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        ret
.8:
        mov eax, 1
.9:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        ret
        db 090h
        push edx
        mov edx, eax
        fld dword [byte eax+038h]
        fadd qword [F64_neg0p1_GoalLinePuckTest]
        fldz
        fxch
        fstp dword [byte eax+038h]
        fcomp dword [byte eax+038h]
        fnstsw ax
        sahf
        jbe short .10
        mov dword [byte edx+038h], 0
.10:
        fld dword [byte edx+040h]
        fsincos
        fld dword [byte edx+038h]
        fmulp st2
        fmul dword [byte edx+038h]
        fld dword [byte edx+038h]
        fadd qword [F64_neg0p1_GoalLinePuckTest]
        fldz
        fxch
        fstp dword [byte edx+038h]
        fxch st2
        fstp dword [byte edx+02Ch]
        fstp dword [byte edx+034h]
        fcomp dword [byte edx+038h]
        fnstsw ax
        sahf
        jbe short .11
        mov dword [byte edx+038h], 0
.11:
        mov ax, word [byte edx+0Eh]
        mov word [byte edx+054h], ax
        fld dword [byte edx+02Ch]
        fld dword [byte edx+034h]
        mov eax, dword [byte edx+040h]
        mov dword [byte edx+01Ch], eax
        fxch
        fadd dword [byte edx+020h]
        fxch
        fadd dword [byte edx+028h]
        fxch
        fstp dword [byte edx+020h]
        mov eax, edx
        fstp dword [byte edx+028h]
        call PuckHeightAt
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; UpdatePuckCarrier                               69654  97 PC, low confidence
; Keeps the puck with its carrier
;-----------------------------------------------------------------------------
UpdatePuckCarrier:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 0Ch
        mov eax, dword [puckc]
        movsx edx, byte [eax]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov esi, SortCords
        shl eax, 3
        add esi, eax
        mov eax, dword [dword esi+0F6h]
        mov eax, dword [eax]
        mov ecx, dword [PtrPuckFlags]
        mov edx, dword [byte eax+028h]
        mov bx, word [dword esi+0A9h]
        and edx, 0FFFFh
        test bx, bx
        jne short .2
        mov eax, dword [dword esi+0FAh]
        test byte [byte eax+031h], 2
        je short .2
        cmp edx, 0CAh
        jne short .1
        mov edx, dword [BodyPointId]
        jmp short .5
.1:
        cmp byte [dword esi+0D0h], 0
        setne al
        mov edx, eax
        and edx, 0FFh
        jmp short .5
.2:
        cmp edx, byte 3Eh
        jl short .3
        cmp edx, 81h
        jl short .4
        cmp edx, 83h
        jg short .4
.3:
        mov edx, dword [BodyPointId]
        jmp short .5
.4:
        mov edx, dword [StickPointId]
.5:
        mov ebx, esp
        mov eax, esi
        call ObjectFramePos
        mov eax, dword [esp]
        mov dword [byte ecx+020h], eax
        cmp word [dword esi+0A9h], byte 0
        jne short .6
        mov eax, dword [dword esi+0FAh]
        test byte [byte eax+031h], 2
        je short .6
        mov eax, dword [byte esp+04h]
        mov dword [byte ecx+024h], eax
        jmp short .7
.6:
        mov dword [byte ecx+024h], 0
.7:
        mov eax, dword [byte esp+08h]
        mov dword [byte ecx+028h], eax
        fld dword [byte esi+02Ch]
        mov dword [byte ecx+030h], 0
        mov ax, word [byte ecx+0Eh]
        fstp dword [byte ecx+02Ch]
        fld dword [byte esi+034h]
        mov word [byte ecx+054h], ax
        mov eax, ecx
        fstp dword [byte ecx+034h]
        call PuckHeightAt
        add esp, byte 0Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PuckGroundHeight                                69750  97 PC, low confidence
; Works out the puck's height over the ice
;-----------------------------------------------------------------------------
PuckGroundHeight:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 40h
        mov edx, eax
        fld dword [F32_1272_PuckGroundHeight]
        fsub dword [byte eax+050h]
        fld dword [byte eax+020h]
        fabs
        mov ebx, 449F0000h
        mov ecx, 457C0000h
        mov dword [byte ebp-04h], ebx
        mov dword [byte ebp-08h], ecx
        fcompp
        fnstsw ax
        sahf
        jbe near .9
        fld dword [F32_4032_PuckGroundHeight]
        fsub dword [byte edx+050h]
        fld dword [byte edx+028h]
        fabs
        fcompp
        fnstsw ax
        sahf
        jbe near .9
        fldz
        fcomp dword [byte edx+028h]
        fnstsw ax
        sahf
        jae short .1
        mov dword [byte ebp-018h], ecx
        jmp short .2
.1:
        mov dword [byte ebp-018h], 0C57C0000h
.2:
        sub esp, byte 8
        fld dword [byte edx+028h]
        fsub dword [byte ebp-018h]
        fldz
        fxch
        fstp qword [esp]
        fcomp dword [byte edx+020h]
        fnstsw ax
        sahf
        jae short .3
        mov eax, dword [byte ebp-04h]
        mov dword [byte ebp-020h], eax
        jmp short .4
.3:
        fld dword [byte ebp-04h]
        fchs
        fstp dword [byte ebp-020h]
.4:
        fld dword [byte edx+020h]
        fsub dword [byte ebp-020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fld dword [F32_768_PuckGroundHeight]
        fsub dword [byte edx+050h]
        fcompp
        fnstsw ax
        sahf
        jae near .16
        fldz
        fcomp dword [byte edx+020h]
        fnstsw ax
        sahf
        jae short .5
        mov eax, dword [byte ebp-04h]
        mov dword [byte ebp-01Ch], eax
        jmp short .6
.5:
        fld dword [byte ebp-04h]
        fchs
        fstp dword [byte ebp-01Ch]
.6:
        mov eax, dword [byte ebp-01Ch]
        fldz
        mov dword [byte ebp-010h], eax
        fcomp dword [byte edx+028h]
        fnstsw ax
        sahf
        jae short .7
        mov eax, dword [byte ebp-08h]
        mov dword [byte ebp-0Ch], eax
        jmp short .8
.7:
        fld dword [byte ebp-08h]
        fchs
        fstp dword [byte ebp-0Ch]
.8:
        fld dword [byte edx+020h]
        fsub dword [byte ebp-010h]
        fld dword [byte edx+028h]
        fsub dword [byte ebp-0Ch]
        fxch
        call IF@ATAN2
        lea edi, [byte ebp-02Ch]
        lea esi, [byte ebp-028h]
        lea eax, [byte ebp-034h]
        fstp dword [byte ebp-034h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [F32_768_PuckGroundHeight]
        fsub dword [byte edx+050h]
        fld st0
        fmul dword [byte ebp-028h]
        fadd dword [byte ebp-010h]
        fstp dword [byte edx+020h]
        fmul dword [byte ebp-02Ch]
        fadd dword [byte ebp-0Ch]
        fstp dword [byte edx+028h]
        mov edx, dword [dword edx+0FAh]
        or byte [byte edx+030h], 8
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        fld dword [byte edx+020h]
        fabs
        fld dword [byte ebp-04h]
        fld dword [byte ebp-08h]
        fld dword [F32_768_PuckGroundHeight]
        fsub dword [byte edx+050h]
        fxch st2
        fadd st2
        fxch
        faddp st2
        fstp dword [byte ebp-04h]
        fstp dword [byte ebp-08h]
        fld dword [byte ebp-04h]
        fcompp
        fnstsw ax
        sahf
        jb short .10
        fld dword [byte edx+028h]
        fabs
        fld dword [byte ebp-08h]
        fcompp
        fnstsw ax
        sahf
        jae near .16
.10:
        fld dword [dword edx+0D2h]
        fabs
        fld dword [byte ebp-04h]
        fstp qword [byte ebp-040h]
        fcomp qword [byte ebp-040h]
        fnstsw ax
        sahf
        ja near .16
        fld dword [dword edx+0DAh]
        fabs
        fld dword [byte ebp-08h]
        fcompp
        fnstsw ax
        sahf
        jb short .16
        mov eax, dword [dword edx+0FAh]
        or byte [byte eax+030h], 8
        fld dword [byte edx+020h]
        fabs
        fcomp qword [byte ebp-040h]
        fnstsw ax
        sahf
        jbe short .13
        fldz
        fcomp dword [byte edx+020h]
        fnstsw ax
        sahf
        jae short .11
        mov eax, dword [byte ebp-04h]
        mov dword [byte ebp-024h], eax
        jmp short .12
.11:
        fld dword [byte ebp-04h]
        fchs
        fstp dword [byte ebp-024h]
.12:
        mov eax, dword [byte ebp-024h]
        mov dword [byte edx+020h], eax
.13:
        fld dword [byte edx+028h]
        fabs
        fld dword [byte ebp-08h]
        fcompp
        fnstsw ax
        sahf
        jae short .16
        fldz
        fcomp dword [byte edx+028h]
        fnstsw ax
        sahf
        jae short .14
        mov eax, dword [byte ebp-08h]
        mov dword [byte ebp-014h], eax
        jmp short .15
.14:
        fld dword [byte ebp-08h]
        fchs
        fstp dword [byte ebp-014h]
.15:
        mov eax, dword [byte ebp-014h]
        mov dword [byte edx+028h], eax
.16:
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
; PuckBounceIce                                   69970  97 PC, low confidence
; Bounces the puck off the ice
;-----------------------------------------------------------------------------
PuckBounceIce:
        push edx
        mov edx, eax
        test byte [gmode], 1
        je short .4
        cmp dword [byte edx+020h], 453B8000h
        jle short .1
        mov dword [byte edx+020h], 453B8000h
.1:
        fld dword [byte edx+020h]
        fcomp dword [F32_neg3000]
        fnstsw ax
        sahf
        jae short .2
        mov dword [byte edx+020h], 0C53B8000h
.2:
        cmp dword [byte edx+028h], 45B40000h
        jle short .3
        mov dword [byte edx+028h], 45B40000h
.3:
        fld dword [byte edx+028h]
        fcomp dword [F32_neg5760]
        fnstsw ax
        sahf
        jae short .5
        mov dword [byte edx+028h], 0C5B40000h
        pop edx
        ret
.4:
        mov eax, edx
        call PuckGroundHeight
.5:
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; UpdatePuck                                      699D4  97 PC, low confidence
; Moves the puck and tests it against the boards, glass and nets
;-----------------------------------------------------------------------------
UpdatePuck:
        push edx
        mov edx, dword [PtrPuckFlags]
        mov eax, dword [dword edx+0FAh]
        and byte [byte eax+030h], 0F7h
        mov eax, dword [dword edx+0FAh]
        and byte [byte eax+030h], 0EFh
        mov eax, dword [puckc]
        cmp byte [eax], 0Ch
        je short .3
        cmp word [BreakawayFlag], byte 8
        je short .2
        mov eax, edx
        call PuckHitsBoards
        test eax, eax
        jne short .1
        mov eax, edx
        call PuckHitsGlass
        test eax, eax
        jne short .1
        mov eax, edx
        call CheckPuckNets
        test eax, eax
        jne short .1
        mov eax, edx
        call PuckGroundHeight
        pop edx
        ret
.1:
        and byte [gmode2], 0EFh
.2:
        mov eax, edx
        call PuckBounceIce
        mov eax, edx
        call PuckHeightAt
.3:
        pop edx
        ret
;-----------------------------------------------------------------------------
; GoalJudgeTest                                   69A44  97 PC, low confidence
; Tests a goal for the goal judge
;-----------------------------------------------------------------------------
GoalJudgeTest:
        push ebx
        push ebp
        mov ebp, esp
        sub esp, byte 18h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        fld dword [byte edx+028h]
        fsub dword [byte eax+028h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte edx+020h]
        fsub dword [byte eax+020h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fld dword [byte edx+020h]
        fsub dword [byte ebx+020h]
        fld dword [byte edx+028h]
        fsub dword [byte ebx+028h]
        fxch
        call IF@ATAN2
        fsub dword [byte ebx+01Ch]
        fld qword [F64_6p28319_GoalJudgeTest]
        fxch
        call IF@DFMOD
        fxch
        fstp dword [esp]
        fst dword [byte esp+014h]
        fst qword [byte esp+04h]
        fcomp qword [F64_3p14159_GoalJudgeTest]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+04h]
        fadd qword [F64_neg6p28319_GoalJudgeTest]
        fstp dword [byte esp+014h]
.1:
        fld dword [byte esp+014h]
        fst qword [byte esp+0Ch]
        fcomp qword [F64_neg3p14159_GoalJudgeTest]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+0Ch]
        fadd qword [F64_6p28319_GoalJudgeTest]
        fstp dword [byte esp+014h]
.2:
        fld dword [byte esp+014h]
        fabs
        fcomp qword [F64_0p785398_GoalJudgeTest]
        fnstsw ax
        sahf
        jae short .3
        fld dword [esp]
        fcomp dword [F32_144_GoalJudgeTest]
        fnstsw ax
        sahf
        jae short .3
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop ebx
        ret
.3:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; RandomPuckSpin                                  69B08  97 PC, low confidence
; Gives the puck a random spin
;-----------------------------------------------------------------------------
RandomPuckSpin:
        push ebx
        push ecx
        push edx
        sub esp, byte 4
        mov edx, eax
        mov ecx, dword [byte eax+038h]
        mov ebx, dword [dword eax+0FAh]
        cmp ecx, 41200000h
        jge short .1
        cmp dword [byte eax+024h], 3F800000h
        jge short .1
        mov dword [byte ebx+08h], 0
        mov dword [byte ebx+04h], 0
        mov dword [byte ebx+0Ch], 0
        jmp short .2
.1:
        fld dword [byte edx+038h]
        push eax
        fistp dword [esp]
        pop eax
        cwde
        call randomd0
        fld dword [byte edx+038h]
        fld1
        faddp
        mov dword [esp], eax
        fild word [esp]
        fdivrp
        fld1
        faddp
        fmul qword [F64_3p14159_RandomPuckSpin]
        fmul qword [F64_0p0833333]
        fstp dword [byte ebx+0Ch]
.2:
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; StopObject                                      69B78  97 PC, low confidence
; Stops an object
;-----------------------------------------------------------------------------
StopObject:
        mov eax, dword [dword eax+0FAh]
        mov dword [byte eax+0Ch], 0
        mov dword [byte eax+08h], 0
        mov dword [byte eax+04h], 0
        ret
