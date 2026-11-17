; Collisions: boards contact, body checks, hits, falls, penalties and player contact.
bits 32
%include "hockey.inc"
section s_6B37F progbits alloc exec nowrite align=1
extern __CHP, AddPenalty2, checkfight, checkint, ChkPenaltyCall, CollideAnimsBack, CollideAnimsFront, CollideAnimsSide
extern CommentaryEvent, CrowdForPlayer, DodgeScale, F32_0p1_HitKnockback, F32_0p2, F32_0p5_HitKnockback, F32_10_ResolvePlayerContact, F32_124
extern F32_1272_BodyCollide, F32_1272_ResolveBodyCheck, F32_12_BodyBounce, F32_1392_ResolveBodyCheck, F32_144_CheckPlayerVsBoards, F32_16, F32_1848, F32_2040_BodyBounce
extern F32_2040_BodyCollide, F32_2_CheckContactForce, F32_2_CheckPlayerVsBoards, F32_32, F32_32_BodyBounce, F32_32_CheckPlayerVsBoards, F32_4032_BodyCollide, F32_4032_ResolveBodyCheck
extern F32_40_BodyBounce, F32_4608, F32_4800_BodyBounce, F32_4800_BodyCollide, F32_48_CheckPlayerVsBoards, F32_4_CheckContactForce, F32_4_CheckPlayerVsBoards, F32_541696
extern F32_768_BodyCollide, F32_768_StartHitAnim, F32_88, F32_neg124, F32_neg1272, F32_neg1848, F32_neg192, F32_neg4608
extern F32_neg4_CheckPlayerVsBoards, F32_neg88_CheckPlayerVsBoards, F64_0p0001_CheckContactForce, F64_0p0001_checkplcoll, F64_0p0001_HitKnockback, F64_0p0523599, F64_0p174533, F64_0p349066_checkcx
extern F64_0p349066_CheckForPenalty, F64_0p523599_BodyBounce, F64_0p523599_BodyCollide, F64_0p5_CheckContactForce, F64_0p5_checkplcoll, F64_0p785398_CheckBoardsContact, F64_0p785398_CheckContactForce, F64_0p785398_CheckContactVelocity
extern F64_0p785398_checkcx, F64_0p785398_HitDirection, F64_0p785398_ResolveBodyCheck, F64_0p785398_ResolvePlayerContact, F64_0p785398_StickContact, F64_10_StickContact, F64_180_CheckPlayerVsBoards, F64_1p0472_CheckForPenalty
extern F64_1p2_HitKnockback, F64_1p5708_checkcx, F64_1p5708_ResolvePlayerContact, F64_2008, F64_216, F64_2_CheckContactForce, F64_2_checkplcoll, F64_2p0944_StartFallAnim
extern F64_2p35619_checkcx, F64_2p35619_HitDirection, F64_2p35619_ResolveBodyCheck, F64_2p35619_ResolvePlayerContact, F64_3p14159_BodyBounce, F64_3p14159_BodyCollide, F64_3p14159_CheckBoardsContact, F64_3p14159_CheckContactForce
extern F64_3p14159_CheckContactVelocity, F64_3p14159_checkcx, F64_3p14159_CheckForPenalty, F64_3p14159_CheckPlayerVsBoards, F64_3p14159_HitDirection, F64_3p14159_HitKnockback, F64_3p14159_PlayerPush, F64_3p14159_ResolveBodyCheck
extern F64_3p14159_ResolvePlayerContact, F64_3p14159_StartFallAnim, F64_3p14159_StickContact, F64_4268, F64_4272_CheckPlayerVsBoards, F64_4280, F64_4_CheckPlayerVsBoards, F64_5
extern F64_6p28319_BodyBounce, F64_6p28319_BodyCollide, F64_6p28319_CheckBoardsContact, F64_6p28319_CheckContactForce, F64_6p28319_CheckContactVelocity, F64_6p28319_checkcx, F64_6p28319_CheckForPenalty, F64_6p28319_HitDirection
extern F64_6p28319_HitKnockback, F64_6p28319_ResolveBodyCheck, F64_6p28319_ResolvePlayerContact, F64_6p28319_StartFallAnim, F64_6p28319_StickContact, F64_neg0p0523599, F64_neg0p5_StickContact, F64_neg0p785398
extern F64_neg216, F64_neg2p35619, F64_neg3p14159_BodyBounce, F64_neg3p14159_BodyCollide, F64_neg3p14159_CheckBoardsContact, F64_neg3p14159_CheckContactForce, F64_neg3p14159_CheckContactVelocity, F64_neg3p14159_checkcx
extern F64_neg3p14159_CheckForPenalty, F64_neg3p14159_CheckPlayerVsBoards, F64_neg3p14159_HitDirection, F64_neg3p14159_HitKnockback, F64_neg3p14159_PlayerPush, F64_neg3p14159_ResolveBodyCheck, F64_neg3p14159_ResolvePlayerContact, F64_neg3p14159_StartFallAnim
extern F64_neg3p14159_StickContact, F64_neg4_CheckPlayerVsBoards, F64_neg6p28319_BodyBounce, F64_neg6p28319_BodyCollide, F64_neg6p28319_CheckBoardsContact, F64_neg6p28319_CheckContactForce, F64_neg6p28319_CheckContactVelocity, F64_neg6p28319_checkcx
extern F64_neg6p28319_CheckForPenalty, F64_neg6p28319_HitDirection, F64_neg6p28319_HitKnockback, F64_neg6p28319_ResolveBodyCheck, F64_neg6p28319_ResolvePlayerContact, F64_neg6p28319_StartFallAnim, F64_neg6p28319_StickContact, gmode
extern hypot_, IF@ATAN2, IF@DFMOD, MoveAnimIds, MoveContactFlags, ObjectFramePos, PlaySfxVolume, PtrAwayIce
extern PtrHomeIce, PtrPuckFlags, PtrPuckZone, PuckGroundHeight, PuckHeightAt, PuckHitsNet, PuckOwnerTeam, randomd0
extern ReplayPlaying, ResetAnimTimer, SetFaceBlink, SetFaceExpression, SetFaceMouth, SetSPA, SkateAnimSpeeds, SortCords
extern StartCheckedAnim, StickContactPts, StickPointId, str_Punct_LoadAnimData, StrideSpeeds, vecdist, VecDot
global CheckBoardsContact, CheckContactVelocity, CheckContactForce, BodyCollide, BodyBounce, CheckForPenalty, CheckPlayerVsBoards, PlayerBoardsTest
global PlayerCollisions, HitDirection, HitCrowdReaction, HitKnockback, StartHitAnim, ResolveBodyCheck, StartFallAnim, checkcx
global ResolvePlayerContact, StickContact, PlayerPush, ContactAngle, checkplcoll
        db 00h
;-----------------------------------------------------------------------------
; CheckBoardsContact                              6B380  97 PC, low confidence
; Body contact against the boards
;-----------------------------------------------------------------------------
CheckBoardsContact:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 114h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov edx, dword [dword eax+0EEh]
        test byte [byte edx+031h], 1
        jne near .35
        fldz
        fcomp dword [byte ecx+028h]
        fnstsw ax
        sahf
        jae short .1
        mov edx, dword [PtrAwayIce]
        jmp short .2
.1:
        mov edx, dword [PtrHomeIce]
.2:
        fldz
        fld dword [byte edx+020h]
        fsub dword [byte ecx+020h]
        mov ebx, edx
        fstp dword [dword esp+0F4h]
        fcomp dword [byte edx+028h]
        fnstsw ax
        sahf
        jae short .3
        mov dword [dword esp+08Ch], 58h
        jmp short .4
.3:
        mov dword [dword esp+08Ch], 0FFFFFFA8h
.4:
        fild dword [dword esp+08Ch]
        fld dword [dword esp+0F4h]
        mov edx, dword [StickPointId]
        mov eax, ecx
        fld st0
        fxch st2
        fadd dword [byte ebx+028h]
        lea ebx, [byte esp+060h]
        fxch st2
        fadd qword [F64_neg216]
        fxch
        fadd qword [F64_216]
        fxch
        fstp dword [dword esp+084h]
        fstp dword [dword esp+090h]
        fsub dword [byte ecx+028h]
        fld st0
        fadd dword [F32_neg124]
        fxch
        fadd dword [F32_124]
        fxch
        fstp dword [dword esp+080h]
        fstp dword [dword esp+094h]
        call ObjectFramePos
        fld dword [byte esp+068h]
        fsub dword [byte ecx+028h]
        fld st0
        fmul st1
        fld dword [byte esp+060h]
        fsub dword [byte ecx+020h]
        fld st0
        fld st3
        fxch
        call IF@ATAN2
        fstp st3
        fmul to st0
        mov edi, 461C4000h
        faddp
        xor edx, edx
        fstp dword [byte esp+07Ch]
        fstp dword [dword esp+098h]
.5:
        add edx, byte 4
        xor eax, eax
        mov dword [byte esp+edx+03Ch], eax
        mov dword [byte esp+edx-04h], edi
        mov eax, dword [byte esp+edx+03Ch]
        mov dword [byte esp+edx+01Ch], eax
        cmp edx, byte 20h
        jne short .5
        fldz
        fcomp dword [dword esp+090h]
        fnstsw ax
        sahf
        jae near .9
        fld dword [dword esp+084h]
        fmul st0
        mov edx, dword [dword esp+084h]
        fldz
        mov dword [byte esp+024h], edx
        fxch
        fsubr dword [byte esp+07Ch]
        mov dword [byte esp+020h], edx
        fstp dword [dword esp+0FCh]
        fcomp dword [dword esp+0FCh]
        fnstsw ax
        sahf
        ja near .9
        fld dword [dword esp+0FCh]
        fsqrt
        fldz
        fldz
        xor ebx, ebx
        fxch st2
        fst dword [dword esp+0FCh]
        mov edx, dword [dword esp+0FCh]
        fchs
        fstp dword [byte esp+044h]
        mov dword [byte esp+040h], edx
        fcomp dword [dword esp+084h]
        fnstsw ax
        sahf
        setb dl
        mov bl, dl
        fcomp dword [dword esp+090h]
        fnstsw ax
        sahf
        seta dl
        and edx, 0FFh
        xor edx, ebx
        jne short .6
        fld dword [dword esp+0FCh]
        fcomp dword [dword esp+080h]
        fnstsw ax
        sahf
        jbe short .6
        fld dword [dword esp+0FCh]
        fcomp dword [dword esp+094h]
        fnstsw ax
        sahf
        jb short .7
.6:
        fld dword [byte esp+040h]
        fld dword [byte esp+020h]
        call IF@ATAN2
        fstp dword [esp]
.7:
        fldz
        fldz
        xor ebx, ebx
        fxch
        fcomp dword [dword esp+084h]
        fnstsw ax
        sahf
        setb dl
        mov bl, dl
        fcomp dword [dword esp+090h]
        fnstsw ax
        sahf
        seta dl
        and edx, 0FFh
        xor edx, ebx
        jne short .8
        fld dword [byte esp+044h]
        fcomp dword [dword esp+080h]
        fnstsw ax
        sahf
        jbe short .8
        fld dword [byte esp+044h]
        fcomp dword [dword esp+094h]
        fnstsw ax
        sahf
        jb short .9
.8:
        fld dword [byte esp+044h]
        fld dword [byte esp+024h]
        call IF@ATAN2
        fstp dword [byte esp+04h]
.9:
        fldz
        fcomp dword [dword esp+084h]
        fnstsw ax
        sahf
        jbe near .13
        fld dword [dword esp+090h]
        fmul st0
        mov edx, dword [dword esp+090h]
        fldz
        mov dword [byte esp+02Ch], edx
        fxch
        fsubr dword [byte esp+07Ch]
        mov dword [byte esp+028h], edx
        fstp dword [dword esp+0F8h]
        fcomp dword [dword esp+0F8h]
        fnstsw ax
        sahf
        ja near .13
        fld dword [dword esp+0F8h]
        fsqrt
        fldz
        fldz
        xor ebx, ebx
        fxch st2
        fst dword [dword esp+0F8h]
        mov edx, dword [dword esp+0F8h]
        fchs
        fstp dword [byte esp+04Ch]
        mov dword [byte esp+048h], edx
        fcomp dword [dword esp+084h]
        fnstsw ax
        sahf
        setb dl
        mov bl, dl
        fcomp dword [dword esp+090h]
        fnstsw ax
        sahf
        seta dl
        and edx, 0FFh
        xor edx, ebx
        jne short .10
        fld dword [dword esp+0F8h]
        fcomp dword [dword esp+080h]
        fnstsw ax
        sahf
        jbe short .10
        fld dword [dword esp+0F8h]
        fcomp dword [dword esp+094h]
        fnstsw ax
        sahf
        jb short .11
.10:
        fld dword [byte esp+048h]
        fld dword [byte esp+028h]
        call IF@ATAN2
        fstp dword [byte esp+08h]
.11:
        fldz
        fcomp dword [dword esp+084h]
        fnstsw ax
        sahf
        setb dl
        fldz
        and edx, 0FFh
        fcomp dword [dword esp+090h]
        fnstsw ax
        sahf
        seta bl
        and ebx, 0FFh
        xor edx, ebx
        jne short .12
        fld dword [byte esp+04Ch]
        fcomp dword [dword esp+080h]
        fnstsw ax
        sahf
        jbe short .12
        fld dword [byte esp+04Ch]
        fcomp dword [dword esp+094h]
        fnstsw ax
        sahf
        jb short .13
.12:
        fld dword [byte esp+04Ch]
        fld dword [byte esp+02Ch]
        call IF@ATAN2
        fstp dword [byte esp+0Ch]
.13:
        fldz
        fcomp dword [dword esp+094h]
        fnstsw ax
        sahf
        jae near .17
        fld dword [dword esp+080h]
        fmul st0
        mov edx, dword [dword esp+080h]
        fldz
        mov dword [byte esp+054h], edx
        fxch
        fsubr dword [byte esp+07Ch]
        mov dword [byte esp+050h], edx
        fstp dword [dword esp+0100h]
        fcomp dword [dword esp+0100h]
        fnstsw ax
        sahf
        ja near .17
        fld dword [dword esp+0100h]
        fsqrt
        fldz
        fldz
        xor ebx, ebx
        fxch st2
        fst dword [dword esp+0100h]
        mov edx, dword [dword esp+0100h]
        fchs
        fstp dword [byte esp+034h]
        mov dword [byte esp+030h], edx
        fcomp dword [dword esp+080h]
        fnstsw ax
        sahf
        setb dl
        mov bl, dl
        fcomp dword [dword esp+094h]
        fnstsw ax
        sahf
        seta dl
        and edx, 0FFh
        xor edx, ebx
        jne short .14
        fld dword [dword esp+0100h]
        fcomp dword [dword esp+084h]
        fnstsw ax
        sahf
        jbe short .14
        fld dword [dword esp+0100h]
        fcomp dword [dword esp+090h]
        fnstsw ax
        sahf
        jb short .15
.14:
        fld dword [byte esp+050h]
        fld dword [byte esp+030h]
        call IF@ATAN2
        fstp dword [byte esp+010h]
.15:
        fldz
        fldz
        xor ebx, ebx
        fxch
        fcomp dword [dword esp+080h]
        fnstsw ax
        sahf
        setb dl
        mov bl, dl
        fcomp dword [dword esp+094h]
        fnstsw ax
        sahf
        seta dl
        and edx, 0FFh
        xor edx, ebx
        jne short .16
        fld dword [byte esp+034h]
        fcomp dword [dword esp+084h]
        fnstsw ax
        sahf
        jbe short .16
        fld dword [byte esp+034h]
        fcomp dword [dword esp+090h]
        fnstsw ax
        sahf
        jb short .17
.16:
        fld dword [byte esp+054h]
        fld dword [byte esp+034h]
        call IF@ATAN2
        fstp dword [byte esp+014h]
.17:
        fldz
        fcomp dword [dword esp+080h]
        fnstsw ax
        sahf
        jbe near .21
        fld dword [dword esp+094h]
        fmul st0
        mov edx, dword [dword esp+094h]
        fldz
        mov dword [byte esp+05Ch], edx
        fxch
        fsubr dword [byte esp+07Ch]
        mov dword [byte esp+058h], edx
        fstp dword [dword esp+0104h]
        fcomp dword [dword esp+0104h]
        fnstsw ax
        sahf
        ja near .21
        fld dword [dword esp+0104h]
        fsqrt
        fldz
        fldz
        xor ebx, ebx
        fxch st2
        fst dword [dword esp+0104h]
        mov edx, dword [dword esp+0104h]
        fchs
        fstp dword [byte esp+03Ch]
        mov dword [byte esp+038h], edx
        fcomp dword [dword esp+080h]
        fnstsw ax
        sahf
        setb dl
        mov bl, dl
        fcomp dword [dword esp+094h]
        fnstsw ax
        sahf
        seta dl
        and edx, 0FFh
        xor edx, ebx
        jne short .18
        fld dword [dword esp+0104h]
        fcomp dword [dword esp+084h]
        fnstsw ax
        sahf
        jbe short .18
        fld dword [dword esp+0104h]
        fcomp dword [dword esp+090h]
        fnstsw ax
        sahf
        jb short .19
.18:
        fld dword [byte esp+058h]
        fld dword [byte esp+038h]
        call IF@ATAN2
        fstp dword [byte esp+018h]
.19:
        fldz
        fldz
        xor ebx, ebx
        fxch
        fcomp dword [dword esp+080h]
        fnstsw ax
        sahf
        setb dl
        mov bl, dl
        fcomp dword [dword esp+094h]
        fnstsw ax
        sahf
        seta dl
        and edx, 0FFh
        xor edx, ebx
        jne short .20
        fld dword [byte esp+03Ch]
        fcomp dword [dword esp+084h]
        fnstsw ax
        sahf
        jbe short .20
        fld dword [byte esp+03Ch]
        fcomp dword [dword esp+090h]
        fnstsw ax
        sahf
        jb short .21
.20:
        fld dword [byte esp+05Ch]
        fld dword [byte esp+03Ch]
        call IF@ATAN2
        fstp dword [byte esp+01Ch]
.21:
        mov edx, 0FFFFFFFFh
        mov ebx, 461C4000h
        mov dword [dword esp+088h], edx
        mov edi, edx
        mov esi, edx
        mov dword [dword esp+0108h], ebx
        mov dword [dword esp+010Ch], ebx
        mov edx, 0C61C4000h
        xor ebx, ebx
        mov dword [dword esp+0110h], edx
        xor edx, edx
.22:
        cmp dword [esp+edx], 461C4000h
        jge near .27
        fld dword [esp+edx]
        fsub dword [dword esp+098h]
        fld qword [F64_6p28319_CheckBoardsContact]
        fxch
        call IF@DFMOD
        fst dword [esp+edx]
        fst qword [dword esp+0B4h]
        fcomp qword [F64_3p14159_CheckBoardsContact]
        fnstsw ax
        sahf
        jbe short .23
        fld qword [dword esp+0B4h]
        fadd qword [F64_neg6p28319_CheckBoardsContact]
        fstp dword [esp+edx]
.23:
        fld dword [esp+edx]
        fst qword [dword esp+09Ch]
        fcomp qword [F64_neg3p14159_CheckBoardsContact]
        fnstsw ax
        sahf
        jae short .24
        fld qword [dword esp+09Ch]
        fadd qword [F64_6p28319_CheckBoardsContact]
        fstp dword [esp+edx]
.24:
        fld dword [esp+edx]
        fabs
        fld dword [dword esp+0108h]
        fxch
        fstp qword [dword esp+0CCh]
        fcomp qword [dword esp+0CCh]
        fnstsw ax
        sahf
        jbe short .25
        fld qword [dword esp+0CCh]
        fstp dword [dword esp+0108h]
        mov dword [dword esp+088h], ebx
.25:
        fldz
        fcomp dword [esp+edx]
        fnstsw ax
        sahf
        ja short .26
        fld dword [esp+edx]
        fcomp dword [dword esp+010Ch]
        fnstsw ax
        sahf
        jae short .26
        mov eax, dword [esp+edx]
        mov esi, ebx
        mov dword [dword esp+010Ch], eax
.26:
        fldz
        fcomp dword [esp+edx]
        fnstsw ax
        sahf
        jb short .27
        fld dword [esp+edx]
        fcomp dword [dword esp+0110h]
        fnstsw ax
        sahf
        jbe short .27
        mov eax, dword [esp+edx]
        mov edi, ebx
        mov dword [dword esp+0110h], eax
.27:
        inc ebx
        add edx, byte 4
        cmp ebx, byte 8
        jl near .22
        mov edx, dword [dword ecx+0FAh]
        fld qword [F64_6p28319_CheckBoardsContact]
        fld dword [byte edx+014h]
        call IF@DFMOD
        fstp dword [byte edx+014h]
        mov edx, dword [dword ecx+0FAh]
        fld dword [byte edx+014h]
        fst qword [dword esp+0A4h]
        fcomp qword [F64_3p14159_CheckBoardsContact]
        fnstsw ax
        sahf
        jbe short .28
        fld qword [dword esp+0A4h]
        fadd qword [F64_neg6p28319_CheckBoardsContact]
        fstp dword [byte edx+014h]
.28:
        mov edx, dword [dword ecx+0FAh]
        fld dword [byte edx+014h]
        fst qword [dword esp+0E4h]
        fcomp qword [F64_neg3p14159_CheckBoardsContact]
        fnstsw ax
        sahf
        jae short .29
        fld qword [dword esp+0E4h]
        fadd qword [F64_6p28319_CheckBoardsContact]
        fstp dword [byte edx+014h]
.29:
        mov edx, dword [dword ecx+0FAh]
        fldz
        fcomp dword [byte edx+014h]
        fnstsw ax
        sahf
        ja near .31
        test esi, esi
        jl near .33
        fld dword [dword esp+010Ch]
        fabs
        fcomp qword [F64_0p785398_CheckBoardsContact]
        fnstsw ax
        sahf
        jae near .33
        fld dword [esp+esi*4]
        fadd dword [byte ecx+01Ch]
        fld qword [F64_6p28319_CheckBoardsContact]
        fxch
        call IF@DFMOD
        fst dword [byte ecx+01Ch]
        fst qword [dword esp+0C4h]
        fcomp qword [F64_3p14159_CheckBoardsContact]
        fnstsw ax
        sahf
        jbe short .30
        fld qword [dword esp+0C4h]
        fadd qword [F64_neg6p28319_CheckBoardsContact]
        fstp dword [byte ecx+01Ch]
.30:
        fld dword [byte ecx+01Ch]
        fst qword [dword esp+0ECh]
        fcomp qword [F64_neg3p14159_CheckBoardsContact]
        fnstsw ax
        sahf
        jae near .35
        fld qword [dword esp+0ECh]
        fadd qword [F64_6p28319_CheckBoardsContact]
        fstp dword [byte ecx+01Ch]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 4
.31:
        test edi, edi
        jl near .33
        fld dword [dword esp+0110h]
        fabs
        fcomp qword [F64_0p785398_CheckBoardsContact]
        fnstsw ax
        sahf
        jae short .33
        fld dword [esp+edi*4]
        fadd dword [byte ecx+01Ch]
        fld qword [F64_6p28319_CheckBoardsContact]
        fxch
        call IF@DFMOD
        fst dword [byte ecx+01Ch]
        fst qword [dword esp+0D4h]
        fcomp qword [F64_3p14159_CheckBoardsContact]
        fnstsw ax
        sahf
        jbe short .32
        fld qword [dword esp+0D4h]
        fadd qword [F64_neg6p28319_CheckBoardsContact]
        fstp dword [byte ecx+01Ch]
.32:
        fld dword [byte ecx+01Ch]
        fst qword [dword esp+0BCh]
        fcomp qword [F64_neg3p14159_CheckBoardsContact]
        fnstsw ax
        sahf
        jae near .35
        fld qword [dword esp+0BCh]
        fadd qword [F64_6p28319_CheckBoardsContact]
        fstp dword [byte ecx+01Ch]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 4
.33:
        mov ebx, dword [dword esp+088h]
        test ebx, ebx
        jl short .35
        mov edx, ebx
        fld dword [esp+edx*4]
        fadd dword [byte ecx+01Ch]
        fld qword [F64_6p28319_CheckBoardsContact]
        fxch
        call IF@DFMOD
        fst dword [byte ecx+01Ch]
        fst qword [dword esp+0ACh]
        fcomp qword [F64_3p14159_CheckBoardsContact]
        fnstsw ax
        sahf
        jbe short .34
        fld qword [dword esp+0ACh]
        fadd qword [F64_neg6p28319_CheckBoardsContact]
        fstp dword [byte ecx+01Ch]
.34:
        fld dword [byte ecx+01Ch]
        fst qword [dword esp+0DCh]
        fcomp qword [F64_neg3p14159_CheckBoardsContact]
        fnstsw ax
        sahf
        jae short .35
        fld qword [dword esp+0DCh]
        fadd qword [F64_6p28319_CheckBoardsContact]
        fstp dword [byte ecx+01Ch]
.35:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 4
        db 090h
;-----------------------------------------------------------------------------
; CheckContactVelocity                            6BC94  97 PC, low confidence
; Works out the speeds after body contact
;-----------------------------------------------------------------------------
CheckContactVelocity:
        push ebx
        push ecx
        push edx
        push edi
        push ebp
        mov ebp, esp
        sub esp, 94h
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        fld dword [byte ebp+018h]
        fsub dword [byte eax+020h]
        fld st0
        fld dword [byte ebp+01Ch]
        fsub dword [byte eax+028h]
        fld st0
        fxch st2
        fld st2
        fxch
        call IF@ATAN2
        fstp st2
        fld st2
        fmulp st3
        fmul to st0
        mov ebx, 44FB0000h
        mov ecx, 45950000h
        mov dword [byte esp+08h], ebx
        mov dword [byte esp+04h], ecx
        faddp st2
        mov eax, dword [dword edx+0EEh]
        fxch
        fstp dword [byte esp+0Ch]
        mov bl, byte [byte eax+031h]
        fstp dword [dword esp+090h]
        test bl, 1
        jne near .21
        fld dword [byte ebp+018h]
        fabs
        fcomp qword [F64_2008]
        fnstsw ax
        sahf
        jbe near .9
        fldz
        fcomp dword [byte ebp+018h]
        fnstsw ax
        sahf
        jbe short .1
        mov dword [byte esp+08h], 0C4FB0000h
.1:
        jae short .2
        mov ebx, 5A7ED197h
        mov ecx, 3FF921FBh
        mov dword [byte esp+018h], ebx
        mov dword [byte esp+01Ch], ecx
        jmp short .3
.2:
        mov edi, 5A7ED197h
        mov eax, 0BFF921FBh
        mov dword [byte esp+018h], edi
        mov dword [byte esp+01Ch], eax
.3:
        fld dword [byte esp+08h]
        fsub dword [byte edx+020h]
        fst dword [dword esp+08Ch]
        fmul dword [dword esp+08Ch]
        fld qword [byte esp+018h]
        fldz
        fxch st2
        fsubr dword [byte esp+0Ch]
        fxch
        fstp dword [byte esp+014h]
        fstp dword [dword esp+088h]
        fcomp dword [dword esp+088h]
        fnstsw ax
        sahf
        ja near .21
        fld dword [dword esp+088h]
        fsqrt
        fld dword [dword esp+090h]
        fsub dword [byte esp+014h]
        fld qword [F64_6p28319_CheckContactVelocity]
        fxch
        call IF@DFMOD
        fxch
        fstp dword [dword esp+088h]
        fst dword [byte esp+07Ch]
        fst qword [byte esp+070h]
        fcomp qword [F64_3p14159_CheckContactVelocity]
        fnstsw ax
        sahf
        jbe short .4
        fld qword [byte esp+070h]
        fadd qword [F64_neg6p28319_CheckContactVelocity]
        fstp dword [byte esp+07Ch]
.4:
        fld dword [byte esp+07Ch]
        fst qword [byte esp+060h]
        fcomp qword [F64_neg3p14159_CheckContactVelocity]
        fnstsw ax
        sahf
        jae short .5
        fld qword [byte esp+060h]
        fadd qword [F64_6p28319_CheckContactVelocity]
        fstp dword [byte esp+07Ch]
.5:
        fld dword [byte esp+07Ch]
        fabs
        fcomp qword [F64_0p785398_CheckContactVelocity]
        fnstsw ax
        sahf
        jae near .8
        mov eax, dword [dword edx+0FAh]
        fld dword [byte eax+010h]
        fsub dword [byte esp+014h]
        fld qword [F64_6p28319_CheckContactVelocity]
        fxch
        call IF@DFMOD
        fst dword [dword esp+084h]
        fst qword [byte esp+028h]
        fcomp qword [F64_3p14159_CheckContactVelocity]
        fnstsw ax
        sahf
        jbe short .6
        fld qword [byte esp+028h]
        fadd qword [F64_neg6p28319_CheckContactVelocity]
        fstp dword [dword esp+084h]
.6:
        fld dword [dword esp+084h]
        fst qword [byte esp+050h]
        fcomp qword [F64_neg3p14159_CheckContactVelocity]
        fnstsw ax
        sahf
        jae short .7
        fld qword [byte esp+050h]
        fadd qword [F64_6p28319_CheckContactVelocity]
        fstp dword [dword esp+084h]
.7:
        fldz
        fcomp dword [dword esp+084h]
        fnstsw ax
        sahf
        setb al
        mov ebx, eax
        fldz
        and ebx, 0FFh
        fcomp dword [byte ebp+018h]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor eax, ebx
        je near .19
        fld dword [dword esp+088h]
        fchs
        fstp dword [dword esp+088h]
        jmp near .19
.8:
        fld dword [byte ebp+01Ch]
        fcomp dword [byte edx+028h]
        fnstsw ax
        sahf
        jae near .19
        fld dword [dword esp+088h]
        fchs
        fstp dword [dword esp+088h]
        jmp near .19
.9:
        fldz
        fcomp dword [byte ebp+01Ch]
        fnstsw ax
        sahf
        jbe short .10
        mov dword [byte esp+04h], 0C5950000h
.10:
        jae short .11
        xor ebx, ebx
        mov dword [byte esp+040h], ebx
        mov dword [byte esp+044h], ebx
        jmp short .12
.11:
        mov edi, 5A7ED197h
        mov eax, 400921FBh
        mov dword [byte esp+040h], edi
        mov dword [byte esp+044h], eax
.12:
        fld dword [byte esp+04h]
        fsub dword [byte edx+028h]
        fst dword [dword esp+088h]
        fmul dword [dword esp+088h]
        fld qword [byte esp+040h]
        fldz
        fxch st2
        fsubr dword [byte esp+0Ch]
        fxch
        fstp dword [byte esp+010h]
        fstp dword [dword esp+08Ch]
        fcomp dword [dword esp+08Ch]
        fnstsw ax
        sahf
        ja near .21
        fld dword [dword esp+08Ch]
        fsqrt
        fld dword [dword esp+090h]
        fsub dword [byte esp+010h]
        fld qword [F64_6p28319_CheckContactVelocity]
        fxch
        call IF@DFMOD
        fxch
        fstp dword [dword esp+08Ch]
        fst dword [dword esp+080h]
        fst qword [byte esp+048h]
        fcomp qword [F64_3p14159_CheckContactVelocity]
        fnstsw ax
        sahf
        jbe short .13
        fld qword [byte esp+048h]
        fadd qword [F64_neg6p28319_CheckContactVelocity]
        fstp dword [dword esp+080h]
.13:
        fld dword [dword esp+080h]
        fst qword [byte esp+038h]
        fcomp qword [F64_neg3p14159_CheckContactVelocity]
        fnstsw ax
        sahf
        jae short .14
        fld qword [byte esp+038h]
        fadd qword [F64_6p28319_CheckContactVelocity]
        fstp dword [dword esp+080h]
.14:
        fld dword [dword esp+080h]
        fabs
        fcomp qword [F64_0p785398_CheckContactVelocity]
        fnstsw ax
        sahf
        jae near .17
        mov eax, dword [dword edx+0FAh]
        fld dword [byte eax+010h]
        fsub dword [byte esp+010h]
        fld qword [F64_6p28319_CheckContactVelocity]
        fxch
        call IF@DFMOD
        fst dword [byte esp+078h]
        fst qword [byte esp+020h]
        fcomp qword [F64_3p14159_CheckContactVelocity]
        fnstsw ax
        sahf
        jbe short .15
        fld qword [byte esp+020h]
        fadd qword [F64_neg6p28319_CheckContactVelocity]
        fstp dword [byte esp+078h]
.15:
        fld dword [byte esp+078h]
        fst qword [byte esp+058h]
        fcomp qword [F64_neg3p14159_CheckContactVelocity]
        fnstsw ax
        sahf
        jae short .16
        fld qword [byte esp+058h]
        fadd qword [F64_6p28319_CheckContactVelocity]
        fstp dword [byte esp+078h]
.16:
        fldz
        fldz
        xor ebx, ebx
        fxch
        fcomp dword [byte esp+078h]
        fnstsw ax
        sahf
        setb al
        mov bl, al
        fcomp dword [byte ebp+01Ch]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, ebx
        je short .19
        jmp short .18
.17:
        fld dword [byte ebp+018h]
        fcomp dword [byte edx+020h]
        fnstsw ax
        sahf
        jae short .19
.18:
        fld dword [dword esp+08Ch]
        fchs
        fstp dword [dword esp+08Ch]
.19:
        fld dword [dword esp+088h]
        fld dword [dword esp+08Ch]
        call IF@ATAN2
        fsub dword [dword esp+090h]
        fld dword [byte edx+01Ch]
        fxch
        fstp dword [dword esp+090h]
        fadd dword [dword esp+090h]
        fld qword [F64_6p28319_CheckContactVelocity]
        fxch
        call IF@DFMOD
        fst dword [byte edx+01Ch]
        fst qword [byte esp+030h]
        fcomp qword [F64_3p14159_CheckContactVelocity]
        fnstsw ax
        sahf
        jbe short .20
        fld qword [byte esp+030h]
        fadd qword [F64_neg6p28319_CheckContactVelocity]
        fstp dword [byte edx+01Ch]
.20:
        fld dword [byte edx+01Ch]
        fst qword [byte esp+068h]
        fcomp qword [F64_neg3p14159_CheckContactVelocity]
        fnstsw ax
        sahf
        jae short .21
        fld qword [byte esp+068h]
        fadd qword [F64_6p28319_CheckContactVelocity]
        fstp dword [byte edx+01Ch]
.21:
        mov esp, ebp
        pop ebp
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret 8
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CheckContactForce                               6C0FC  97 PC, low confidence
; Works out the force of body contact
;-----------------------------------------------------------------------------
CheckContactForce:
        push ebx
        push edx
        push ebp
        mov ebp, esp
        sub esp, 0D4h
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        fldz
        fcomp dword [byte ebp+010h]
        fnstsw ax
        sahf
        jae short .1
        mov dword [byte esp+010h], 4F8h
        jmp short .2
.1:
        mov dword [byte esp+010h], 0FFFFFB08h
.2:
        fild dword [byte esp+010h]
        fldz
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte ebp+014h]
        fnstsw ax
        sahf
        jae short .3
        mov dword [byte esp+014h], 0FC0h
        jmp short .4
.3:
        mov dword [byte esp+014h], 0FFFFF040h
.4:
        fld dword [byte ebp+010h]
        fsub dword [byte edx+020h]
        fld st0
        fmul st1
        fld dword [byte ebp+014h]
        fsub dword [byte edx+028h]
        fld st0
        fxch st3
        fld st3
        fxch
        call IF@ATAN2
        fstp st3
        fmul to st0
        fild dword [byte esp+014h]
        fld dword [byte edx+020h]
        fld dword [byte edx+028h]
        fxch st2
        fstp dword [byte esp+01Ch]
        fsub dword [byte esp+0Ch]
        fxch
        fsub dword [byte esp+01Ch]
        fxch
        fstp dword [dword esp+0B0h]
        fstp dword [dword esp+0D0h]
        faddp
        mov eax, dword [dword edx+0EEh]
        fstp dword [byte esp+024h]
        mov bl, byte [byte eax+031h]
        fstp dword [dword esp+0C0h]
        test bl, 1
        jne near .27
        fld dword [dword esp+0D0h]
        fst qword [byte esp+064h]
        fabs
        fld dword [dword esp+0B0h]
        fmul to st0
        fadd dword [F32_541696]
        fstp dword [byte esp+018h]
        fcomp qword [F64_0p0001_CheckContactForce]
        fnstsw ax
        sahf
        jae short .7
        fld dword [byte esp+018h]
        fsub dword [byte esp+024h]
        fld dword [dword esp+0B0h]
        fmul qword [F64_2_CheckContactForce]
        fdivp
        fst dword [byte esp+034h]
        fmul dword [byte esp+034h]
        fldz
        mov eax, dword [byte esp+034h]
        fxch
        fsubr dword [F32_541696]
        mov dword [dword esp+0A8h], eax
        fstp dword [dword esp+0ACh]
        fcomp dword [dword esp+0ACh]
        fnstsw ax
        sahf
        jbe short .5
        xor ebx, ebx
        mov dword [dword esp+0ACh], ebx
        jmp short .6
.5:
        fld dword [dword esp+0ACh]
        fsqrt
        fstp dword [dword esp+0ACh]
.6:
        fld dword [dword esp+0ACh]
        fchs
        jmp near .11
.7:
        fld dword [dword esp+0B0h]
        fabs
        fld dword [dword esp+0D0h]
        fmul to st0
        fstp dword [byte esp+020h]
        fcomp qword [F64_0p0001_CheckContactForce]
        fnstsw ax
        sahf
        jae near .10
        fld dword [byte esp+020h]
        fadd dword [F32_541696]
        fsub dword [byte esp+024h]
        fld qword [byte esp+064h]
        fmul qword [F64_2_CheckContactForce]
        fdivp
        fst dword [byte esp+030h]
        fmul dword [byte esp+030h]
        fldz
        mov eax, dword [byte esp+030h]
        fxch
        fsubr dword [F32_541696]
        mov dword [dword esp+0ACh], eax
        fstp dword [dword esp+0A8h]
        fcomp dword [dword esp+0A8h]
        fnstsw ax
        sahf
        jbe short .8
        xor eax, eax
        mov dword [dword esp+0A8h], eax
        jmp short .9
.8:
        fld dword [dword esp+0A8h]
        fsqrt
        fstp dword [dword esp+0A8h]
.9:
        fld dword [dword esp+0A8h]
        fchs
        fstp dword [byte esp+034h]
        jmp near .12
.10:
        fld dword [dword esp+0B0h]
        fchs
        fld1
        fdiv dword [dword esp+0D0h]
        fld dword [byte esp+018h]
        fadd dword [byte esp+020h]
        fsub dword [byte esp+024h]
        fmul qword [F64_0p5_CheckContactForce]
        fxch st2
        fmul st1
        fxch st2
        fmulp
        fxch
        fst dword [byte esp+02Ch]
        fmul dword [byte esp+02Ch]
        fxch
        fst dword [byte esp+038h]
        fmul dword [byte esp+038h]
        fld dword [byte esp+038h]
        fmul dword [F32_2_CheckContactForce]
        fld1
        faddp st3
        fxch
        fsub dword [F32_541696]
        fxch st2
        fst dword [dword esp+0A4h]
        fmul dword [F32_4_CheckContactForce]
        fxch
        fmul dword [byte esp+02Ch]
        fxch
        fmulp st2
        fst dword [byte esp+028h]
        fmul dword [byte esp+028h]
        fsubrp
        fldz
        fxch
        fstp dword [dword esp+0C4h]
        fcomp dword [dword esp+0C4h]
        fnstsw ax
        sahf
        ja near .27
        fld dword [dword esp+0C4h]
        fsqrt
        fst dword [dword esp+0C4h]
        fld dword [byte esp+028h]
        fxch
        fsub st1
        fld dword [dword esp+0A4h]
        fmul qword [F64_2_CheckContactForce]
        fld1
        fdivrp
        fxch st2
        fchs
        fsub dword [dword esp+0C4h]
        fxch
        fmul st2
        fxch
        fmulp st2
        fld dword [byte esp+02Ch]
        fld st0
        fxch st2
        fstp dword [dword esp+0A8h]
        fxch
        fmul dword [dword esp+0A8h]
        fxch st2
        fstp dword [byte esp+034h]
        fmul dword [byte esp+034h]
        fxch
        fld dword [byte esp+038h]
        fxch
        fadd st1
        fxch st2
        faddp
        fxch
        fstp dword [dword esp+0ACh]
.11:
        fstp dword [byte esp+030h]
.12:
        fld dword [dword esp+0B0h]
        fld dword [dword esp+0A8h]
        fsub st1
        fld dword [dword esp+0D0h]
        fld dword [dword esp+0ACh]
        fsub st1
        fxch st2
        fld st2
        fxch
        call IF@ATAN2
        fstp st2
        fld dword [byte esp+034h]
        fsubrp st3
        fsubr dword [byte esp+030h]
        fxch st2
        fld st2
        fxch
        call IF@ATAN2
        fstp st2
        fld dword [dword esp+0C0h]
        fxch
        fsub st1
        fld qword [F64_6p28319_CheckContactForce]
        fxch
        call IF@DFMOD
        fxch st2
        fsubrp
        fstp dword [dword esp+0C8h]
        fst dword [dword esp+0CCh]
        fst qword [byte esp+03Ch]
        fcomp qword [F64_3p14159_CheckContactForce]
        fnstsw ax
        sahf
        jbe short .13
        fld qword [byte esp+03Ch]
        fadd qword [F64_neg6p28319_CheckContactForce]
        fstp dword [dword esp+0CCh]
.13:
        fld dword [dword esp+0CCh]
        fst qword [byte esp+044h]
        fcomp qword [F64_neg3p14159_CheckContactForce]
        fnstsw ax
        sahf
        jae short .14
        fld qword [byte esp+044h]
        fadd qword [F64_6p28319_CheckContactForce]
        fstp dword [dword esp+0CCh]
.14:
        fld qword [F64_6p28319_CheckContactForce]
        fld dword [dword esp+0C8h]
        call IF@DFMOD
        fst dword [dword esp+0C8h]
        fst qword [dword esp+084h]
        fcomp qword [F64_3p14159_CheckContactForce]
        fnstsw ax
        sahf
        jbe short .15
        fld qword [dword esp+084h]
        fadd qword [F64_neg6p28319_CheckContactForce]
        fstp dword [dword esp+0C8h]
.15:
        fld dword [dword esp+0C8h]
        fst qword [byte esp+04Ch]
        fcomp qword [F64_neg3p14159_CheckContactForce]
        fnstsw ax
        sahf
        jae short .16
        fld qword [byte esp+04Ch]
        fadd qword [F64_6p28319_CheckContactForce]
        fstp dword [dword esp+0C8h]
.16:
        fld dword [byte ebp+010h]
        fsub dword [byte esp+0Ch]
        fld dword [byte ebp+014h]
        fsub dword [byte esp+01Ch]
        fxch
        call IF@ATAN2
        fsubr dword [dword esp+0C0h]
        fld qword [F64_6p28319_CheckContactForce]
        fxch
        call IF@DFMOD
        fst dword [dword esp+0B8h]
        fst qword [dword esp+08Ch]
        fcomp qword [F64_3p14159_CheckContactForce]
        fnstsw ax
        sahf
        jbe short .17
        fld qword [dword esp+08Ch]
        fadd qword [F64_neg6p28319_CheckContactForce]
        fstp dword [dword esp+0B8h]
.17:
        fld dword [dword esp+0B8h]
        fst qword [byte esp+07Ch]
        fcomp qword [F64_neg3p14159_CheckContactForce]
        fnstsw ax
        sahf
        jae short .18
        fld qword [byte esp+07Ch]
        fadd qword [F64_6p28319_CheckContactForce]
        fstp dword [dword esp+0B8h]
.18:
        fld dword [dword esp+0B8h]
        fabs
        fcomp qword [F64_0p785398_CheckContactForce]
        fnstsw ax
        sahf
        jae near .23
        fld dword [dword esp+0CCh]
        fadd dword [dword esp+0C0h]
        mov eax, dword [dword edx+0FAh]
        fsubr dword [byte eax+010h]
        fld qword [F64_6p28319_CheckContactForce]
        fxch
        call IF@DFMOD
        fst dword [dword esp+0B4h]
        fst qword [byte esp+06Ch]
        fcomp qword [F64_3p14159_CheckContactForce]
        fnstsw ax
        sahf
        jbe short .19
        fld qword [byte esp+06Ch]
        fadd qword [F64_neg6p28319_CheckContactForce]
        fstp dword [dword esp+0B4h]
.19:
        fld dword [dword esp+0B4h]
        fst qword [byte esp+074h]
        fcomp qword [F64_neg3p14159_CheckContactForce]
        fnstsw ax
        sahf
        jae short .20
        fld qword [byte esp+074h]
        fadd qword [F64_6p28319_CheckContactForce]
        fstp dword [dword esp+0B4h]
.20:
        fld dword [dword esp+0C8h]
        fadd dword [dword esp+0C0h]
        mov eax, dword [dword edx+0FAh]
        fsubr dword [byte eax+010h]
        fld qword [F64_6p28319_CheckContactForce]
        fxch
        call IF@DFMOD
        fst dword [dword esp+0BCh]
        fst qword [byte esp+05Ch]
        fcomp qword [F64_3p14159_CheckContactForce]
        fnstsw ax
        sahf
        jbe short .21
        fld qword [byte esp+05Ch]
        fadd qword [F64_neg6p28319_CheckContactForce]
        fstp dword [dword esp+0BCh]
.21:
        fld dword [dword esp+0BCh]
        fst qword [dword esp+094h]
        fcomp qword [F64_neg3p14159_CheckContactForce]
        fnstsw ax
        sahf
        jae short .22
        fld qword [dword esp+094h]
        fadd qword [F64_6p28319_CheckContactForce]
        fstp dword [dword esp+0BCh]
.22:
        fld dword [dword esp+0B4h]
        fabs
        fld dword [dword esp+0BCh]
        fabs
        fcompp
        fnstsw ax
        sahf
        jae short .25
        jmp short .24
.23:
        fld dword [dword esp+0C8h]
        fabs
        fld dword [dword esp+0CCh]
        fabs
        fcompp
        fnstsw ax
        sahf
        jbe short .25
.24:
        mov eax, dword [dword esp+0C8h]
        mov dword [dword esp+0CCh], eax
.25:
        fld dword [byte edx+01Ch]
        fadd dword [dword esp+0CCh]
        fld qword [F64_6p28319_CheckContactForce]
        fxch
        call IF@DFMOD
        fst dword [byte edx+01Ch]
        fst qword [byte esp+054h]
        fcomp qword [F64_3p14159_CheckContactForce]
        fnstsw ax
        sahf
        jbe short .26
        fld qword [byte esp+054h]
        fadd qword [F64_neg6p28319_CheckContactForce]
        fstp dword [byte edx+01Ch]
.26:
        fld dword [byte edx+01Ch]
        fst qword [dword esp+09Ch]
        fcomp qword [F64_neg3p14159_CheckContactForce]
        fnstsw ax
        sahf
        jae short .27
        fld qword [dword esp+09Ch]
        fadd qword [F64_6p28319_CheckContactForce]
        fstp dword [byte edx+01Ch]
.27:
        mov esp, ebp
        pop ebp
        pop edx
        pop ebx
        ret 8
        db 090h
;-----------------------------------------------------------------------------
; BodyCollide                                     6C73C  97 PC, low confidence
; Body collision between two players
;-----------------------------------------------------------------------------
BodyCollide:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 68h
        mov ecx, eax
        fld dword [byte ebp+024h]
        fadd dword [F32_1272_BodyCollide]
        fld dword [byte ebp+01Ch]
        fabs
        fcompp
        fnstsw ax
        sahf
        ja short .1
        xor eax, eax
        jmp near .22
.1:
        fld dword [byte ebp+024h]
        fadd dword [F32_4032_BodyCollide]
        fld dword [byte ebp+020h]
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
        pop ecx
        pop ebx
        ret 0Ch
.2:
        fldz
        fcomp dword [byte ebp+01Ch]
        fnstsw ax
        sahf
        jae short .3
        mov dword [byte ebp-018h], 4F8h
        jmp short .4
.3:
        mov dword [byte ebp-018h], 0FFFFFB08h
.4:
        fild dword [byte ebp-018h]
        fldz
        fxch
        fstp dword [byte ebp-02Ch]
        fcomp dword [byte ebp+020h]
        fnstsw ax
        sahf
        jae short .5
        mov dword [byte ebp-028h], 0FC0h
        jmp short .6
.5:
        mov dword [byte ebp-028h], 0FFFFF040h
.6:
        fild dword [byte ebp-028h]
        fld dword [byte ebp+020h]
        fld dword [byte ebp+01Ch]
        fsub dword [byte ebp-02Ch]
        fld dword [F32_768_BodyCollide]
        fxch
        fstp dword [byte ebp-01Ch]
        fxch
        fsubrp st2
        fld dword [byte ebp-01Ch]
        fxch st2
        fst dword [byte ebp-014h]
        fstp qword [byte ebp-04Ch]
        mov eax, dword [byte ebp-048h]
        mov edx, dword [byte ebp-04Ch]
        push eax
        fxch
        fstp qword [byte ebp-054h]
        push edx
        mov ebx, dword [byte ebp-050h]
        mov esi, dword [byte ebp-054h]
        push ebx
        fsub dword [byte ebp+024h]
        push esi
        fstp dword [byte ebp-0Ch]
        call hypot_
        fld dword [byte ebp-0Ch]
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
        pop ecx
        pop ebx
        ret 0Ch
.7:
        fld dword [byte ebp+024h]
        fcomp dword [F32_32]
        fnstsw ax
        sahf
        jne short .8
        push dword [byte ebp+020h]
        mov eax, ecx
        push dword [byte ebp+01Ch]
        call CheckContactForce
        jmp near .21
.8:
        fld qword [byte ebp-04Ch]
        fld qword [byte ebp-054h]
        call IF@ATAN2
        lea edi, [byte ebp-03Ch]
        lea esi, [byte ebp-038h]
        lea eax, [byte ebp-034h]
        fstp dword [byte ebp-034h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte ebp-0Ch]
        fld st0
        fmul dword [byte ebp-038h]
        fsub dword [byte ebp-01Ch]
        fadd dword [byte ecx+020h]
        fstp dword [byte ecx+020h]
        fmul dword [byte ebp-03Ch]
        fsub dword [byte ebp-014h]
        fadd dword [byte ecx+028h]
        mov dx, word [dword ecx+0A9h]
        fstp dword [byte ecx+028h]
        test dx, dx
        jl short .9
        test byte [dword ecx+0C0h], 1
        jne short .9
        lea ebx, [byte ebp-068h]
        mov edx, dword [StickPointId]
        mov eax, ecx
        call ObjectFramePos
        push dword 42000000h
        push dword [byte ebp-060h]
        mov eax, ecx
        push dword [byte ebp-068h]
        call BodyCollide
.9:
        mov eax, dword [byte ecx+038h]
        mov dword [byte ebp-038h], eax
        mov eax, dword [byte ecx+040h]
        mov dword [byte ebp-03Ch], eax
        mov eax, ecx
        push dword [byte ebp-034h]
        call PuckHitsNet
        test eax, eax
        je near .20
        cmp dword [byte ebp-038h], 41400000h
        jle near .14
        fld dword [byte ebp-03Ch]
        fsub dword [byte ebp-034h]
        fld qword [F64_6p28319_BodyCollide]
        fxch
        call IF@DFMOD
        fst dword [byte ebp-04h]
        fst qword [byte ebp-05Ch]
        fcomp qword [F64_3p14159_BodyCollide]
        fnstsw ax
        sahf
        jbe short .10
        fld qword [byte ebp-05Ch]
        fadd qword [F64_neg6p28319_BodyCollide]
        fstp dword [byte ebp-04h]
.10:
        fld dword [byte ebp-04h]
        fst qword [byte ebp-044h]
        fcomp qword [F64_neg3p14159_BodyCollide]
        fnstsw ax
        sahf
        jae short .11
        fld qword [byte ebp-044h]
        fadd qword [F64_6p28319_BodyCollide]
        fstp dword [byte ebp-04h]
.11:
        fld dword [byte ebp-04h]
        fabs
        fcomp qword [F64_0p523599_BodyCollide]
        fnstsw ax
        sahf
        jae short .14
        mov eax, dword [dword ecx+0FAh]
        fldz
        fcomp dword [eax]
        fnstsw ax
        sahf
        jb short .14
        cmp dword [byte ebp-038h], 42200000h
        jle short .12
        push dword [byte ecx+028h]
        mov eax, 2
        push dword [byte ecx+020h]
        mov edx, 64h
        call randomd0
        test ax, ax
        setne al
        and eax, 0FFh
        add eax, 421h
        jmp short .13
.12:
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 420h
        push dword [byte ecx+020h]
.13:
        call PlaySfxVolume
        mov eax, dword [dword ecx+0FAh]
        mov dword [eax], 41400000h
.14:
        fld dword [F32_2040_BodyCollide]
        fsub dword [byte ecx+050h]
        fld dword [byte ecx+020h]
        fxch
        fstp dword [byte ebp-010h]
        fcomp dword [byte ebp-010h]
        fnstsw ax
        sahf
        jbe short .15
        mov eax, dword [byte ebp-010h]
        jmp short .16
.15:
        fld dword [byte ecx+020h]
        fld dword [byte ebp-010h]
        fchs
        fstp dword [byte ebp-024h]
        fcomp dword [byte ebp-024h]
        fnstsw ax
        sahf
        jae short .17
        mov eax, dword [byte ebp-024h]
.16:
        mov dword [byte ecx+020h], eax
.17:
        fld dword [F32_4800_BodyCollide]
        fsub dword [byte ecx+050h]
        fld dword [byte ecx+028h]
        fxch
        fstp dword [byte ebp-08h]
        fcomp dword [byte ebp-08h]
        fnstsw ax
        sahf
        jbe short .18
        mov eax, dword [byte ebp-08h]
        jmp short .19
.18:
        fld dword [byte ecx+028h]
        fld dword [byte ebp-08h]
        fchs
        fstp dword [byte ebp-020h]
        fcomp dword [byte ebp-020h]
        fnstsw ax
        sahf
        jae short .20
        mov eax, dword [byte ebp-020h]
.19:
        mov dword [byte ecx+028h], eax
.20:
        mov eax, dword [dword ecx+0FAh]
        or byte [byte eax+030h], 8
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
        ret 0Ch
        db 090h
;-----------------------------------------------------------------------------
; BodyBounce                                      6CA24  97 PC, low confidence
; Bounce between two players
;-----------------------------------------------------------------------------
BodyBounce:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 6Ch
        mov ecx, eax
        fld dword [byte ebp+018h]
        fabs
        fld dword [F32_4800_BodyBounce]
        fld dword [byte ebp+020h]
        fld dword [F32_2040_BodyBounce]
        fsub st1
        fxch st2
        fsubrp
        fxch
        fstp dword [byte ebp-014h]
        fstp dword [byte ebp-010h]
        fld dword [byte ebp-014h]
        fcompp
        fnstsw ax
        sahf
        jb short .1
        fld dword [byte ebp+01Ch]
        fabs
        fld dword [byte ebp-010h]
        fcompp
        fnstsw ax
        sahf
        jb short .1
        xor eax, eax
        jmp near .30
.1:
        fld dword [dword ecx+0D2h]
        fabs
        fld dword [byte ebp-014h]
        fstp qword [byte ebp-040h]
        fcomp qword [byte ebp-040h]
        fnstsw ax
        sahf
        ja short .2
        fld dword [dword ecx+0DAh]
        fabs
        fld dword [byte ebp-010h]
        fcompp
        fnstsw ax
        sahf
        jae short .3
.2:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 0Ch
.3:
        fld dword [byte ebp+020h]
        fcomp dword [F32_32_BodyBounce]
        fnstsw ax
        sahf
        jne short .4
        push dword [byte ebp+01Ch]
        mov eax, ecx
        push dword [byte ebp+018h]
        call CheckContactVelocity
        jmp near .29
.4:
        fld dword [byte ebp+018h]
        fabs
        fcomp qword [byte ebp-040h]
        fnstsw ax
        sahf
        jbe short .7
        fld dword [byte ecx+020h]
        fabs
        fcomp qword [byte ebp-040h]
        fnstsw ax
        sahf
        jbe short .7
        fldz
        fcomp dword [byte ecx+020h]
        fnstsw ax
        sahf
        jae short .5
        mov eax, dword [byte ebp-014h]
        mov dword [byte ebp-024h], eax
        jmp short .6
.5:
        fld dword [byte ebp-014h]
        fchs
        fstp dword [byte ebp-024h]
.6:
        mov eax, dword [byte ebp-024h]
        mov dword [byte ecx+020h], eax
.7:
        fld dword [byte ebp+01Ch]
        fabs
        fld dword [byte ebp-010h]
        fstp qword [byte ebp-060h]
        fcomp qword [byte ebp-060h]
        fnstsw ax
        sahf
        jbe short .10
        fld dword [byte ecx+028h]
        fabs
        fcomp qword [byte ebp-060h]
        fnstsw ax
        sahf
        jbe short .10
        fldz
        fcomp dword [byte ecx+028h]
        fnstsw ax
        sahf
        jae short .8
        mov eax, dword [byte ebp-010h]
        mov dword [byte ebp-030h], eax
        jmp short .9
.8:
        fld dword [byte ebp-010h]
        fchs
        fstp dword [byte ebp-030h]
.9:
        mov eax, dword [byte ebp-030h]
        mov dword [byte ecx+028h], eax
.10:
        cmp word [dword ecx+0A9h], byte 0
        jl short .11
        test byte [dword ecx+0C0h], 1
        jne short .11
        lea ebx, [byte ebp-06Ch]
        mov edx, dword [StickPointId]
        mov eax, ecx
        call ObjectFramePos
        push dword 42000000h
        push dword [byte ebp-064h]
        mov eax, ecx
        push dword [byte ebp-06Ch]
        call BodyBounce
.11:
        fld dword [byte ebp+018h]
        fabs
        fld dword [byte ebp-014h]
        fcompp
        fnstsw ax
        sahf
        jae short .14
        fldz
        fcomp dword [byte ebp+018h]
        fnstsw ax
        sahf
        jae short .12
        mov ebx, 5A7ED197h
        mov esi, 3FF921FBh
        mov dword [byte ebp-058h], ebx
        mov dword [byte ebp-054h], esi
        jmp short .13
.12:
        mov eax, 83DF1D31h
        mov edx, 4012D97Ch
        mov dword [byte ebp-058h], eax
        mov dword [byte ebp-054h], edx
.13:
        fld qword [byte ebp-058h]
        jmp short .17
.14:
        fldz
        fcomp dword [byte ebp+01Ch]
        fnstsw ax
        sahf
        jae short .15
        xor esi, esi
        mov dword [byte ebp-038h], esi
        mov dword [byte ebp-034h], esi
        jmp short .16
.15:
        mov edx, 5A7ED197h
        mov ebx, 400921FBh
        mov dword [byte ebp-038h], edx
        mov dword [byte ebp-034h], ebx
.16:
        fld qword [byte ebp-038h]
.17:
        fstp dword [byte ebp-020h]
        mov eax, dword [byte ecx+038h]
        mov dword [byte ebp-01Ch], eax
        mov eax, dword [byte ecx+040h]
        mov dword [byte ebp-08h], eax
        mov eax, ecx
        push dword [byte ebp-020h]
        call PuckHitsNet
        test eax, eax
        je near .28
        fld dword [byte ebp-01Ch]
        fcomp dword [F32_12_BodyBounce]
        fnstsw ax
        sahf
        jbe near .22
        fld dword [byte ebp-08h]
        fsub dword [byte ebp-020h]
        fld qword [F64_6p28319_BodyBounce]
        fxch
        call IF@DFMOD
        fst dword [byte ebp-0Ch]
        fst qword [byte ebp-050h]
        fcomp qword [F64_3p14159_BodyBounce]
        fnstsw ax
        sahf
        jbe short .18
        fld qword [byte ebp-050h]
        fadd qword [F64_neg6p28319_BodyBounce]
        fstp dword [byte ebp-0Ch]
.18:
        fld dword [byte ebp-0Ch]
        fst qword [byte ebp-048h]
        fcomp qword [F64_neg3p14159_BodyBounce]
        fnstsw ax
        sahf
        jae short .19
        fld qword [byte ebp-048h]
        fadd qword [F64_6p28319_BodyBounce]
        fstp dword [byte ebp-0Ch]
.19:
        fld dword [byte ebp-0Ch]
        fabs
        fcomp qword [F64_0p523599_BodyBounce]
        fnstsw ax
        sahf
        jae short .22
        mov eax, dword [dword ecx+0FAh]
        fldz
        fcomp dword [eax]
        fnstsw ax
        sahf
        jb short .22
        fld dword [byte ebp-01Ch]
        fcomp dword [F32_40_BodyBounce]
        fnstsw ax
        sahf
        jbe short .20
        push dword [byte ecx+028h]
        mov eax, 2
        push dword [byte ecx+020h]
        mov edx, 64h
        call randomd0
        test ax, ax
        setne al
        and eax, 0FFh
        add eax, 421h
        jmp short .21
.20:
        push dword [byte ecx+028h]
        mov edx, 64h
        mov eax, 420h
        push dword [byte ecx+020h]
.21:
        call PlaySfxVolume
        mov eax, dword [dword ecx+0FAh]
        mov dword [eax], 41400000h
.22:
        fld dword [F32_2040_BodyBounce]
        fsub dword [byte ecx+050h]
        fld dword [byte ecx+020h]
        fxch
        fstp dword [byte ebp-018h]
        fcomp dword [byte ebp-018h]
        fnstsw ax
        sahf
        jbe short .23
        mov eax, dword [byte ebp-018h]
        jmp short .24
.23:
        fld dword [byte ecx+020h]
        fld dword [byte ebp-018h]
        fchs
        fstp dword [byte ebp-028h]
        fcomp dword [byte ebp-028h]
        fnstsw ax
        sahf
        jae short .25
        mov eax, dword [byte ebp-028h]
.24:
        mov dword [byte ecx+020h], eax
.25:
        fld dword [F32_4800_BodyBounce]
        fsub dword [byte ecx+050h]
        fld dword [byte ecx+028h]
        fxch
        fstp dword [byte ebp-04h]
        fcomp dword [byte ebp-04h]
        fnstsw ax
        sahf
        jbe short .26
        mov eax, dword [byte ebp-04h]
        jmp short .27
.26:
        fld dword [byte ecx+028h]
        fld dword [byte ebp-04h]
        fchs
        fstp dword [byte ebp-02Ch]
        fcomp dword [byte ebp-02Ch]
        fnstsw ax
        sahf
        jae short .28
        mov eax, dword [byte ebp-02Ch]
.27:
        mov dword [byte ecx+028h], eax
.28:
        mov eax, dword [dword ecx+0FAh]
        or byte [byte eax+030h], 8
.29:
        mov eax, 1
.30:
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 0Ch
;-----------------------------------------------------------------------------
; CheckForPenalty                                 6CD58  97 PC, low confidence
; Tests a hit for a penalty
;-----------------------------------------------------------------------------
CheckForPenalty:
        push ebx
        push ecx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 28h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov esi, edx
        xor eax, eax
        fld dword [byte ecx+040h]
        mov al, byte [dword ecx+0C2h]
        fsub dword [byte edx+01Ch]
        mov edx, 4Ah
        sub edx, eax
        mov dword [byte esp+08h], edx
        fstp dword [byte esp+024h]
        fild dword [byte esp+08h]
        fcomp dword [byte ecx+038h]
        fnstsw ax
        sahf
        ja short .1
        cmp word [dword ecx+0A9h], byte 0
        jne short .2
.1:
        xor eax, eax
        jmp near .11
.2:
        fld qword [F64_6p28319_CheckForPenalty]
        fld dword [byte ebp+014h]
        call IF@DFMOD
        fld dword [byte esp+024h]
        fsub dword [byte ebp+014h]
        fstp dword [byte esp+024h]
        fst dword [byte ebp+014h]
        fst qword [byte esp+014h]
        fcomp qword [F64_3p14159_CheckForPenalty]
        fnstsw ax
        sahf
        jbe short .3
        fld qword [byte esp+014h]
        fadd qword [F64_neg6p28319_CheckForPenalty]
        fstp dword [byte ebp+014h]
.3:
        fld dword [byte ebp+014h]
        fcomp qword [F64_neg3p14159_CheckForPenalty]
        fnstsw ax
        sahf
        fld qword [F64_6p28319_CheckForPenalty]
        fld dword [byte esp+024h]
        call IF@DFMOD
        fst dword [byte esp+024h]
        fst qword [byte esp+01Ch]
        fcomp qword [F64_3p14159_CheckForPenalty]
        fnstsw ax
        sahf
        jbe short .4
        fld qword [byte esp+01Ch]
        fadd qword [F64_neg6p28319_CheckForPenalty]
        fstp dword [byte esp+024h]
.4:
        fld dword [byte esp+024h]
        fst qword [byte esp+0Ch]
        fcomp qword [F64_neg3p14159_CheckForPenalty]
        fnstsw ax
        sahf
        jae short .5
        fld qword [byte esp+0Ch]
        fadd qword [F64_6p28319_CheckForPenalty]
        fstp dword [byte esp+024h]
.5:
        fld dword [byte esp+024h]
        fabs
        fcomp qword [F64_1p0472_CheckForPenalty]
        fnstsw ax
        sahf
        jbe short .6
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        pop ebx
        ret 4
.6:
        test byte [gmode], 1
        jne short .7
        mov edx, 0Ah
        mov eax, ecx
        xor ebx, ebx
        call AddPenalty2
.7:
        fld dword [byte esp+024h]
        fabs
        fld dword [byte ecx+038h]
        fmul dword [F32_0p2]
        fstp dword [byte esi+038h]
        mov eax, dword [byte ecx+040h]
        mov dword [byte esi+040h], eax
        fcomp qword [F64_0p349066_CheckForPenalty]
        fnstsw ax
        sahf
        jbe short .10
        fldz
        fcomp dword [byte esp+024h]
        fnstsw ax
        sahf
        jbe short .8
        mov eax, dword [dword esi+0FAh]
        fld dword [byte eax+0Ch]
        fld st0
        fadd qword [F64_0p0523599]
        fstp st1
        jmp short .9
.8:
        mov eax, dword [dword esi+0FAh]
        fld dword [byte eax+0Ch]
        fadd qword [F64_neg0p0523599]
.9:
        fstp dword [byte eax+0Ch]
.10:
        mov eax, 1
.11:
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        pop ebx
        ret 4
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CheckPlayerVsBoards                             6CED0  97 PC, low confidence
; Tests a player against the boards
;-----------------------------------------------------------------------------
CheckPlayerVsBoards:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 74h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov dword [byte esp+03Ch], edx
        cmp byte [dword edx+0A4h], 0Fh
        jne short .1
        mov esi, 5A7ED197h
        mov edi, 400921FBh
        mov dword [byte esp+050h], esi
        mov dword [byte esp+054h], edi
        jmp short .2
.1:
        xor edx, edx
        mov dword [byte esp+050h], edx
        mov dword [byte esp+054h], edx
.2:
        fld qword [byte esp+050h]
        mov eax, dword [byte esp+03Ch]
        fstp dword [byte esp+064h]
        fld dword [byte eax+01Ch]
        fcomp dword [byte esp+064h]
        fnstsw ax
        sahf
        setne al
        and eax, 0FFh
        mov dh, byte [gmode]
        mov ebx, eax
        test dh, 1
        je short .4
        test eax, eax
        jne short .3
        mov eax, dword [byte esp+03Ch]
        test dword [byte eax+020h], 7FFFFFFFh
        jne short .3
        fld dword [byte eax+028h]
        fabs
        fcomp qword [F64_4272_CheckPlayerVsBoards]
        fnstsw ax
        sahf
        je short .4
.3:
        mov eax, 1
        jmp short .5
.4:
        xor eax, eax
.5:
        fld dword [byte ebp+018h]
        mov edx, dword [byte esp+03Ch]
        fld dword [byte ebp+01Ch]
        fsub dword [byte edx+028h]
        fxch
        fsub dword [byte edx+020h]
        fxch
        fstp dword [byte esp+06Ch]
        mov dx, word [dword ecx+0A9h]
        fstp dword [byte esp+068h]
        test dx, dx
        jg near .9
        test eax, eax
        jne near .9
        fld dword [byte ebp+01Ch]
        fabs
        fcomp qword [F64_4272_CheckPlayerVsBoards]
        fnstsw ax
        sahf
        ja short .6
        fld dword [dword ecx+0DAh]
        fabs
        fcomp qword [F64_4272_CheckPlayerVsBoards]
        fnstsw ax
        sahf
        jbe near .25
.6:
        fld dword [byte ecx+050h]
        fadd dword [F32_144_CheckPlayerVsBoards]
        fld dword [byte ebp+018h]
        fabs
        fcompp
        fnstsw ax
        sahf
        ja near .9
        fld dword [byte ecx+028h]
        fabs
        fst qword [byte esp+058h]
        fcomp qword [F64_4280]
        fnstsw ax
        sahf
        ja short .9
        fld qword [byte esp+058h]
        fcomp qword [F64_4268]
        fnstsw ax
        sahf
        jb short .9
        fld dword [dword ecx+0DAh]
        fabs
        fcomp qword [byte esp+058h]
        fnstsw ax
        sahf
        jae short .9
        fldz
        fcomp dword [byte ecx+028h]
        fnstsw ax
        sahf
        jae short .7
        mov dword [byte esp+038h], 10B0h
        jmp short .8
.7:
        mov dword [byte esp+038h], 0FFFFEF50h
.8:
        fild dword [byte esp+038h]
        mov eax, dword [dword ecx+0FAh]
        fstp dword [byte ecx+028h]
        or byte [byte eax+030h], 10h
        mov eax, 1
        jmp near .26
.9:
        fld dword [byte esp+068h]
        fabs
        fld dword [byte ecx+050h]
        fadd dword [F32_88]
        fmul dword [F32_2_CheckPlayerVsBoards]
        fadd dword [F32_48_CheckPlayerVsBoards]
        fstp qword [byte esp+048h]
        fcomp qword [byte esp+048h]
        fnstsw ax
        sahf
        ja near .25
        fld dword [byte esp+06Ch]
        fabs
        fcomp qword [byte esp+048h]
        fnstsw ax
        sahf
        ja near .25
        test ebx, ebx
        jne short .10
        mov eax, dword [byte esp+03Ch]
        test dword [byte eax+01Ch], 7FFFFFFFh
        je short .11
.10:
        mov eax, dword [byte esp+03Ch]
        lea edi, [byte esp+01Ch]
        lea esi, [byte esp+024h]
        fld dword [byte eax+01Ch]
        fchs
        lea eax, [byte esp+064h]
        fstp dword [byte esp+064h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        mov eax, dword [byte esp+068h]
        fld dword [byte esp+068h]
        mov dword [byte esp+030h], eax
        fmul dword [byte esp+01Ch]
        fld dword [byte esp+030h]
        fchs
        fmul dword [byte esp+024h]
        fld dword [byte esp+06Ch]
        fmul dword [byte esp+024h]
        fld dword [byte esp+06Ch]
        fmul dword [byte esp+01Ch]
        fxch
        faddp st3
        faddp
        fxch
        fstp dword [byte esp+068h]
        fstp dword [byte esp+06Ch]
.11:
        fld dword [byte ecx+050h]
        fadd qword [F64_180_CheckPlayerVsBoards]
        fmul st0
        fld dword [byte esp+068h]
        fmul to st0
        fdivrp
        fld dword [byte esp+06Ch]
        fld dword [byte ecx+050h]
        fadd dword [F32_88]
        fxch
        fadd dword [F32_88]
        fxch
        fmul st0
        fxch
        fst dword [byte esp+06Ch]
        fmul dword [byte esp+06Ch]
        fdivrp
        faddp
        fld1
        fcompp
        fnstsw ax
        sahf
        jbe near .25
        fld dword [byte ebp+020h]
        fcomp dword [F32_32_CheckPlayerVsBoards]
        fnstsw ax
        sahf
        je near .24
        fld dword [byte esp+06Ch]
        fld dword [byte esp+068h]
        call IF@ATAN2
        mov edx, dword [byte esp+03Ch]
        fadd qword [F64_3p14159_CheckPlayerVsBoards]
        mov eax, ecx
        fstp dword [byte esp+064h]
        push dword [byte esp+064h]
        mov edi, dword [byte esp+06Ch]
        call CheckForPenalty
        test edi, 7FFFFFFFh
        jne short .14
        fldz
        fcomp dword [byte esp+06Ch]
        fnstsw ax
        sahf
        jae short .12
        fld dword [byte ecx+050h]
        fadd dword [F32_88]
        fadd dword [F32_4_CheckPlayerVsBoards]
        jmp short .13
.12:
        fld dword [byte ecx+050h]
        fadd dword [F32_88]
        fchs
        fadd dword [F32_neg4_CheckPlayerVsBoards]
.13:
        fstp dword [byte esp+034h]
        mov eax, dword [byte esp+034h]
        mov dword [byte esp+06Ch], eax
        jmp near .20
.14:
        test dword [byte esp+06Ch], 7FFFFFFFh
        jne short .17
        fldz
        fcomp dword [byte esp+068h]
        fnstsw ax
        sahf
        jae short .15
        fld dword [byte ecx+050h]
        fadd qword [F64_180_CheckPlayerVsBoards]
        fadd qword [F64_4_CheckPlayerVsBoards]
        jmp short .16
.15:
        fld dword [byte ecx+050h]
        fadd qword [F64_180_CheckPlayerVsBoards]
        fchs
        fadd qword [F64_neg4_CheckPlayerVsBoards]
.16:
        fstp qword [byte esp+040h]
        fld qword [byte esp+040h]
        fstp dword [byte esp+068h]
        jmp near .20
.17:
        fld dword [byte esp+06Ch]
        fdiv dword [byte esp+068h]
        fld dword [byte esp+064h]
        fadd qword [F64_neg3p14159_CheckPlayerVsBoards]
        fstp dword [byte esp+028h]
        fld dword [byte ecx+050h]
        fadd qword [F64_180_CheckPlayerVsBoards]
        fmul st0
        fld st0
        fxch st2
        fst dword [byte esp+060h]
        fxch st2
        fmul st2
        fmulp st2
        fld dword [byte ecx+050h]
        fadd dword [F32_88]
        fld st0
        fmul st1
        faddp st3
        fxch
        fmul st1
        fmulp
        fdivrp
        fldz
        fxch
        fstp dword [byte esp+070h]
        fcomp dword [byte esp+070h]
        fnstsw ax
        sahf
        jbe short .18
        xor esi, esi
        mov dword [byte esp+068h], esi
        jmp short .19
.18:
        fld dword [byte esp+070h]
        fsqrt
        fstp dword [byte esp+068h]
.19:
        fld dword [byte esp+060h]
        sub esp, byte 8
        fstp qword [esp]
        push dword 3FF00000h
        push byte 0
        call hypot_
        fmul dword [byte esp+068h]
        lea edi, [byte esp+01Ch]
        lea esi, [byte esp+024h]
        fadd qword [F64_4_CheckPlayerVsBoards]
        lea eax, [byte esp+028h]
        fstp dword [byte esp+020h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte esp+020h]
        fmul dword [byte esp+024h]
        fld dword [byte esp+020h]
        fmul dword [byte esp+01Ch]
        fxch
        fstp dword [byte esp+068h]
        fstp dword [byte esp+06Ch]
.20:
        fld dword [byte esp+06Ch]
        fadd dword [F32_neg88_CheckPlayerVsBoards]
        fstp dword [byte esp+06Ch]
        test ebx, ebx
        jne short .21
        mov eax, dword [byte esp+03Ch]
        test dword [byte eax+01Ch], 7FFFFFFFh
        je near .22
.21:
        mov eax, dword [byte esp+03Ch]
        lea edi, [byte esp+01Ch]
        lea esi, [byte esp+024h]
        add eax, byte 1Ch
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        mov eax, dword [byte esp+068h]
        fld dword [byte esp+068h]
        mov dword [byte esp+02Ch], eax
        fmul dword [byte esp+01Ch]
        fld dword [byte esp+02Ch]
        fchs
        fmul dword [byte esp+024h]
        fld dword [byte esp+06Ch]
        fmul dword [byte esp+024h]
        fld dword [byte esp+06Ch]
        fmul dword [byte esp+01Ch]
        fld dword [byte esp+064h]
        mov eax, dword [byte esp+03Ch]
        fxch st2
        faddp st4
        fxch
        fadd dword [byte eax+01Ch]
        fxch st3
        fstp dword [byte esp+068h]
        faddp
        fxch
        fstp dword [byte esp+064h]
        fstp dword [byte esp+06Ch]
.22:
        mov eax, ecx
        push dword [byte esp+064h]
        call PuckHitsNet
        mov eax, dword [byte esp+03Ch]
        fld dword [byte eax+020h]
        fadd dword [byte esp+068h]
        fstp dword [byte ecx+020h]
        fld dword [byte eax+028h]
        fadd dword [byte esp+06Ch]
        mov eax, dword [dword ecx+0FAh]
        fstp dword [byte ecx+028h]
        or byte [byte eax+030h], 10h
        cmp word [dword ecx+0A9h], byte 0
        jl short .23
        test byte [dword ecx+0C0h], 1
        jne short .23
        mov eax, dword [dword ecx+0F2h]
        cmp dword [byte eax+038h], byte 0
        je short .23
        mov ebx, esp
        mov edx, dword [StickPointId]
        mov eax, ecx
        call ObjectFramePos
        push dword 42000000h
        push dword [byte esp+0Ch]
        mov edx, dword [byte esp+044h]
        mov eax, ecx
        push dword [byte esp+08h]
        call CheckPlayerVsBoards
.23:
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 0Ch
.24:
        mov eax, ecx
        push dword [byte esp+064h]
        call CheckBoardsContact
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 0Ch
.25:
        xor eax, eax
.26:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 0Ch
;-----------------------------------------------------------------------------
; PlayerBoardsTest                                6D3E4  97 PC, low confidence
; Tests whether a player is near the boards
;-----------------------------------------------------------------------------
PlayerBoardsTest:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ecx, eax
        push dword [byte eax+050h]
        push dword [byte eax+028h]
        mov edx, dword [PtrAwayIce]
        push dword [byte eax+020h]
        call CheckPlayerVsBoards
        test eax, eax
        je short .1
        mov eax, 1
        jmp near .6
.1:
        push dword [byte ecx+050h]
        mov edx, dword [PtrHomeIce]
        push dword [byte ecx+028h]
        mov eax, ecx
        push dword [byte ecx+020h]
        call CheckPlayerVsBoards
        test eax, eax
        jne near .5
        cmp byte [dword ecx+0A4h], 0Ch
        je short .2
        test byte [dword ecx+0C0h], 1
        je short .3
.2:
        xor eax, eax
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov ebx, esp
        mov edx, dword [StickPointId]
        mov eax, ecx
        call ObjectFramePos
        push dword 42000000h
        push dword [byte esp+0Ch]
        mov edx, dword [PtrAwayIce]
        mov eax, ecx
        push dword [byte esp+08h]
        call CheckPlayerVsBoards
        test eax, eax
        je short .4
        mov eax, 1
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        push dword 42000000h
        push dword [byte esp+0Ch]
        mov edx, dword [PtrHomeIce]
        mov eax, ecx
        push dword [byte esp+08h]
        call CheckPlayerVsBoards
        test eax, eax
        je short .6
.5:
        mov eax, 2
.6:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PlayerCollisions                                6D4AC  97 PC, low confidence
; Runs the player collision tests
;-----------------------------------------------------------------------------
PlayerCollisions:
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ecx, eax
        mov eax, dword [dword eax+0FAh]
        and byte [byte eax+030h], 0F7h
        mov eax, dword [dword ecx+0FAh]
        and byte [byte eax+030h], 0EFh
        test byte [dword ecx+0BFh], 4
        je short .1
        xor eax, eax
        jmp near .5
.1:
        push dword [byte ecx+050h]
        push dword [byte ecx+028h]
        mov eax, ecx
        push dword [byte ecx+020h]
        call BodyCollide
        test eax, eax
        jne near .4
        mov ebx, esp
        mov edx, dword [StickPointId]
        mov eax, ecx
        call ObjectFramePos
        cmp byte [dword ecx+0A4h], 0Ch
        je short .2
        test byte [dword ecx+0C0h], 1
        jne short .2
        push dword 42000000h
        push dword [byte esp+0Ch]
        mov eax, ecx
        push dword [byte esp+08h]
        call BodyCollide
        test eax, eax
        jne short .4
.2:
        push dword [byte ecx+050h]
        push dword [byte ecx+028h]
        mov eax, ecx
        push dword [byte ecx+020h]
        call BodyBounce
        test eax, eax
        jne short .4
        cmp byte [dword ecx+0A4h], 0Ch
        je short .3
        test byte [dword ecx+0C0h], 1
        jne short .3
        push dword 42000000h
        push dword [byte esp+0Ch]
        mov eax, ecx
        push dword [byte esp+08h]
        call BodyBounce
        test eax, eax
        jne short .4
.3:
        mov eax, ecx
        call PlayerBoardsTest
        test eax, eax
        jne short .4
        mov eax, ecx
        call PuckGroundHeight
        xor eax, eax
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov eax, ecx
        call PuckGroundHeight
        mov eax, ecx
        call PuckHeightAt
        mov eax, 1
.5:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; HitDirection                                    6D59C  97 PC, low confidence
; Works out the direction of a hit
;-----------------------------------------------------------------------------
HitDirection:
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 1Ch
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        mov eax, dword [byte eax+01Ch]
        mov dword [byte esp+018h], eax
        fld dword [byte ebp+0Ch]
        fsub dword [byte esp+018h]
        fld qword [F64_6p28319_HitDirection]
        fxch
        call IF@DFMOD
        fst dword [byte esp+018h]
        fst qword [byte esp+08h]
        fcomp qword [F64_3p14159_HitDirection]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+08h]
        fadd qword [F64_neg6p28319_HitDirection]
        fstp dword [byte esp+018h]
.1:
        fld dword [byte esp+018h]
        fst qword [byte esp+010h]
        fcomp qword [F64_neg3p14159_HitDirection]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+010h]
        fadd qword [F64_6p28319_HitDirection]
        fstp dword [byte esp+018h]
.2:
        fld dword [byte esp+018h]
        fabs
        fst qword [esp]
        fcomp qword [F64_0p785398_HitDirection]
        fnstsw ax
        sahf
        jae short .3
        mov eax, 74h
        jmp short .6
.3:
        fld qword [esp]
        fcomp qword [F64_2p35619_HitDirection]
        fnstsw ax
        sahf
        jbe short .4
        mov eax, 73h
        mov esp, ebp
        pop ebp
        pop edx
        ret 4
.4:
        cmp byte [dword edx+0D0h], 0
        setne al
        xor edx, edx
        fldz
        mov dl, al
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor edx, eax
        je short .5
        mov eax, 76h
        mov esp, ebp
        pop ebp
        pop edx
        ret 4
.5:
        mov eax, 75h
.6:
        mov esp, ebp
        pop ebp
        pop edx
        ret 4
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; HitCrowdReaction                                6D678  97 PC, low confidence
; Crowd and commentary reaction to a hit
;-----------------------------------------------------------------------------
HitCrowdReaction:
        push ecx
        push esi
        push edi
        mov ecx, eax
        cmp byte [dword edx+0A4h], 0Ch
        jne short .1
        mov eax, edx
        call CrowdForPlayer
        pop edi
        pop esi
        pop ecx
        ret
.1:
        mov eax, dword [PtrPuckZone]
        cmp byte [eax], 0
        jge short .2
        xor eax, eax
        mov si, word [PuckOwnerTeam]
        mov al, byte [dword edx+0A4h]
        cmp ax, si
        jne near .10
        mov eax, dword [PtrPuckFlags]
        cmp dword [byte eax+05Ah], byte 0FFFFFFA0h
        jl near .10
.2:
        mov esi, 1000h
        cmp ebx, 6002h
        je short .3
        cmp ebx, 6001h
        jne short .5
.3:
        mov eax, edx
        call CrowdForPlayer
        mov di, word [byte ecx+06Ah]
        cmp di, byte 23h
        jle short .4
        mov esi, 1002h
        jmp short .5
.4:
        cmp di, byte 14h
        jle short .5
        mov esi, 1001h
.5:
        test byte [gmode], 1
        jne near .10
        cmp byte [dword ecx+0A4h], 6
        setb al
        mov edi, eax
        mov ah, byte [dword edx+0A4h]
        and edi, 0FFh
        cmp ah, 6
        setb al
        and eax, 0FFh
        xor eax, edi
        je near .10
        cmp word [dword ecx+0A9h], byte 0
        jne short .6
        mov eax, dword [dword ecx+0FEh]
        mov edi, dword [dword eax+0108h]
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        sub eax, byte 19h
        imul eax, dword 125h
        add edi, 1D42h
        jmp short .7
.6:
        mov eax, dword [dword ecx+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        mov edi, dword [dword ecx+0FEh]
        mov edi, dword [dword edi+0108h]
        add edi, 0A3h
.7:
        add eax, edi
        cmp word [dword edx+0A9h], byte 0
        jne short .8
        mov ecx, dword [dword edx+0FEh]
        mov edi, dword [dword ecx+0108h]
        mov ecx, dword [dword edx+0A3h]
        sar ecx, 18h
        sub ecx, byte 19h
        imul ecx, dword 125h
        add edi, 1D42h
        jmp short .9
.8:
        mov ecx, dword [dword edx+0A3h]
        sar ecx, 18h
        imul ecx, dword 125h
        mov edi, dword [dword edx+0FEh]
        mov edi, dword [dword edi+0108h]
        add edi, 0A3h
.9:
        add ecx, edi
        push esi
        push ebx
        lea ebx, [byte edx+028h]
        push ebx
        add edx, byte 20h
        push edx
        push ecx
        push eax
        push dword 0A0000008h
        call CommentaryEvent
        add esp, byte 1Ch
.10:
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; HitKnockback                                    6D7F8  97 PC, low confidence
; Knocks back a player that was hit
;-----------------------------------------------------------------------------
HitKnockback:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 2Ch
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov ecx, edx
        mov esi, ecx
        mov edx, dword [dword eax+0FAh]
        lea eax, [nosplit esi*8+00h]
        sub eax, esi
        mov eax, dword [nosplit eax*8+StrideSpeeds]
        lea esi, [nosplit ecx*4+00h]
        mov dword [byte esp+020h], eax
        fld dword [dword esi+str_Punct_LoadAnimData]
        fcomp dword [byte esp+020h]
        fnstsw ax
        sahf
        jbe short .1
        mov eax, dword [dword esi+str_Punct_LoadAnimData]
        mov dword [byte esp+020h], eax
.1:
        fld dword [byte esp+020h]
        fcomp qword [F64_0p0001_HitKnockback]
        fnstsw ax
        sahf
        jae short .2
        mov dword [byte esp+020h], 3F800000h
.2:
        fld dword [byte ebx+038h]
        fdiv dword [byte esp+020h]
        fst dword [byte esp+028h]
        fcomp dword [F32_0p5_HitKnockback]
        fnstsw ax
        sahf
        jae short .3
        mov dword [byte esp+028h], 3F000000h
.3:
        fld dword [byte esp+028h]
        fst qword [byte esp+010h]
        fcomp qword [F64_1p2_HitKnockback]
        fnstsw ax
        sahf
        jbe short .4
        fld dword [byte ebx+038h]
        fld qword [byte esp+010h]
        fmul qword [F64_1p2_HitKnockback]
        mov eax, 3F99999Ah
        fsubp
        mov dword [byte esp+028h], eax
        fstp dword [byte edx+08h]
        mov eax, dword [byte ebx+040h]
        mov dword [byte edx+034h], eax
.4:
        mov eax, dword [byte esp+028h]
        mov dword [byte edx+04h], eax
        fld dword [byte ebx+040h]
        lea eax, [nosplit ecx*8+00h]
        fsub dword [byte ebx+01Ch]
        sub eax, ecx
        fsub dword [nosplit eax*8+SkateAnimSpeeds]
        fld qword [F64_6p28319_HitKnockback]
        fxch
        call IF@DFMOD
        fst dword [byte esp+024h]
        fst qword [esp]
        fcomp qword [F64_3p14159_HitKnockback]
        fnstsw ax
        sahf
        jbe short .5
        fld qword [esp]
        fadd qword [F64_neg6p28319_HitKnockback]
        fstp dword [byte esp+024h]
.5:
        fld dword [byte esp+024h]
        fst qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_HitKnockback]
        fnstsw ax
        sahf
        jae short .6
        fld qword [byte esp+08h]
        fadd qword [F64_6p28319_HitKnockback]
        fstp dword [byte esp+024h]
.6:
        fld dword [byte esp+024h]
        fabs
        fcomp qword [F64_0p174533]
        fnstsw ax
        sahf
        jbe short .9
        fldz
        fcomp dword [byte esp+024h]
        fnstsw ax
        sahf
        jae short .7
        mov esi, 5070BA4Eh
        mov edi, 3FC65718h
        mov dword [byte esp+018h], esi
        mov dword [byte esp+01Ch], edi
        jmp short .8
.7:
        mov ebx, 5070BA4Eh
        mov ecx, 0BFC65718h
        mov dword [byte esp+018h], ebx
        mov dword [byte esp+01Ch], ecx
.8:
        fld qword [byte esp+018h]
        fstp dword [byte esp+024h]
.9:
        fld dword [byte esp+024h]
        fmul dword [F32_0p1_HitKnockback]
        mov eax, dword [byte edx+04h]
        mov dword [byte edx+038h], eax
        fstp dword [byte edx+0Ch]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StartHitAnim                                    6D980  97 PC, low confidence
; Starts the animation for a hit
;-----------------------------------------------------------------------------
StartHitAnim:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 28h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        fldz
        fcomp dword [byte eax+020h]
        fnstsw ax
        sahf
        jae short .1
        mov dword [byte esp+010h], 4F8h
        jmp short .2
.1:
        mov dword [byte esp+010h], 0FFFFFB08h
.2:
        fild dword [byte esp+010h]
        fldz
        fxch
        fstp dword [byte esp+08h]
        fcomp dword [byte ecx+028h]
        fnstsw ax
        sahf
        jae short .3
        mov dword [byte esp+0Ch], 0FC0h
        jmp short .4
.3:
        mov dword [byte esp+0Ch], 0FFFFF040h
.4:
        fild dword [byte esp+0Ch]
        fld dword [F32_768_StartHitAnim]
        fld dword [byte ecx+028h]
        fld dword [byte ecx+020h]
        fsub dword [byte esp+08h]
        fxch st2
        fsub dword [byte ecx+050h]
        fxch st2
        fstp dword [byte esp+024h]
        fsubrp st2
        fld dword [byte esp+024h]
        fxch st2
        fstp qword [byte esp+01Ch]
        mov eax, dword [byte esp+020h]
        mov edx, dword [byte esp+01Ch]
        push eax
        fxch
        fstp qword [byte esp+018h]
        push edx
        mov ebx, dword [byte esp+020h]
        mov esi, dword [byte esp+01Ch]
        push ebx
        fadd dword [F32_neg192]
        push esi
        fstp dword [byte esp+010h]
        call hypot_
        fcomp dword [esp]
        fnstsw ax
        sahf
        ja short .5
        xor eax, eax
        jmp short .6
.5:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov ah, byte [dword ecx+0BFh]
        fld qword [byte esp+01Ch]
        or ah, 20h
        fld qword [byte esp+014h]
        mov byte [dword ecx+0BFh], ah
        call IF@ATAN2
        push dword 3F800000h
        sub esp, byte 4
        fstp dword [esp]
        mov eax, ecx
        xor ebx, ebx
        call HitDirection
        mov edx, eax
        mov eax, ecx
        call SetSPA
        mov eax, dword [dword ecx+0FAh]
        or byte [byte eax+031h], 1
        xor edx, edx
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov ebx, 6001h
        shl eax, 3
        mov edx, ecx
        add eax, SortCords
        call HitCrowdReaction
        mov eax, 1
.6:
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ResolveBodyCheck                                6DAB0  97 PC, low confidence
; Resolves a body check: who falls and the penalty call
;-----------------------------------------------------------------------------
ResolveBodyCheck:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 38h
        and esp, byte 0FFFFFFF8h
        mov ebx, dword [byte ebp+01Ch]
        mov ecx, eax
        mov eax, dword [byte eax+020h]
        mov dword [byte esp+034h], eax
        mov eax, dword [byte ecx+028h]
        fld dword [byte esp+034h]
        mov dword [byte esp+030h], eax
        fabs
        fld dword [byte esp+030h]
        fabs
        mov edx, 2
        fxch
        fstp dword [esp]
        mov eax, dword [dword ecx+0F2h]
        fstp dword [byte esp+04h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov edx, 1
        mov eax, dword [dword ecx+0F2h]
        call SetFaceBlink
        mov eax, dword [dword ecx+0EEh]
        mov dl, byte [byte eax+031h]
        or dl, 1
        fld dword [esp]
        mov byte [byte eax+031h], dl
        fcomp dword [F32_1272_ResolveBodyCheck]
        fnstsw ax
        sahf
        ja short .1
        fld dword [byte esp+04h]
        fcomp dword [F32_4032_ResolveBodyCheck]
        fnstsw ax
        sahf
        jbe near .8
.1:
        fld dword [byte esp+034h]
        fcomp dword [F32_1272_ResolveBodyCheck]
        fnstsw ax
        sahf
        jbe near .3
        fld dword [byte esp+04h]
        fcomp dword [F32_4032_ResolveBodyCheck]
        fnstsw ax
        sahf
        jbe short .2
        mov eax, ecx
        push dword [byte ebp+018h]
        call StartHitAnim
        test eax, eax
        je near .8
        jmp near .35
.2:
        fld dword [byte ebp+018h]
        fst qword [byte esp+010h]
        fcomp qword [F64_neg0p785398]
        fnstsw ax
        sahf
        jae near .8
        fld qword [byte esp+010h]
        fcomp qword [F64_neg2p35619]
        fnstsw ax
        sahf
        jbe near .8
        fld dword [byte esp+034h]
        fcomp dword [F32_1848]
        fnstsw ax
        sahf
        jbe near .8
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov al, byte [dword ecx+0BFh]
        push dword 3F800000h
        or al, 20h
        push dword 3FC90FDBh
        mov byte [dword ecx+0BFh], al
        mov eax, ecx
        xor ebx, ebx
        call HitDirection
        mov edx, eax
        mov eax, ecx
        call SetSPA
        mov eax, dword [dword ecx+0FAh]
        or byte [byte eax+031h], 1
        xor edx, edx
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov ebx, 6001h
        shl eax, 3
        mov edx, ecx
        add eax, SortCords
        call HitCrowdReaction
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.3:
        fld dword [byte esp+034h]
        fcomp dword [F32_neg1272]
        fnstsw ax
        sahf
        jae near .6
        fld dword [byte esp+04h]
        fcomp dword [F32_4032_ResolveBodyCheck]
        fnstsw ax
        sahf
        jbe short .4
        mov eax, ecx
        push dword [byte ebp+018h]
        call StartHitAnim
        test eax, eax
        je near .8
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.4:
        fld dword [byte ebp+018h]
        fst qword [byte esp+028h]
        fcomp qword [F64_0p785398_ResolveBodyCheck]
        fnstsw ax
        sahf
        jbe near .8
        fld qword [byte esp+028h]
        fcomp qword [F64_2p35619_ResolveBodyCheck]
        fnstsw ax
        sahf
        jae near .8
        fld dword [byte esp+034h]
        fcomp dword [F32_neg1848]
        fnstsw ax
        sahf
        jae near .8
        mov eax, ecx
        push dword 0BFC90FDBh
        call HitDirection
        fld dword [byte esp+04h]
        mov ebx, eax
        mov edx, eax
        fcomp dword [F32_1392_ResolveBodyCheck]
        fnstsw ax
        sahf
        jae short .5
        lea edx, [byte ebx+04h]
.5:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov bl, byte [dword ecx+0BFh]
        or bl, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bl
        xor ebx, ebx
        push dword 3F800000h
        call SetSPA
        mov eax, dword [dword ecx+0FAh]
        mov bh, byte [byte eax+031h]
        or bh, 1
        xor edx, edx
        mov byte [byte eax+031h], bh
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov ebx, 6001h
        shl eax, 3
        mov edx, ecx
        add eax, SortCords
        call HitCrowdReaction
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.6:
        fld dword [byte esp+030h]
        fcomp dword [F32_4032_ResolveBodyCheck]
        fnstsw ax
        sahf
        jbe near .7
        fld dword [byte ebp+018h]
        fabs
        fcomp qword [F64_2p35619_ResolveBodyCheck]
        fnstsw ax
        sahf
        jbe near .8
        fld dword [byte esp+030h]
        fcomp dword [F32_4608]
        fnstsw ax
        sahf
        jbe near .8
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        push dword 3F800000h
        mov bh, byte [dword ecx+0BFh]
        push byte 0
        or bh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], bh
        call HitDirection
        mov edx, eax
        xor ebx, ebx
        mov eax, ecx
        call SetSPA
        mov eax, dword [dword ecx+0FAh]
        or byte [byte eax+031h], 1
        xor edx, edx
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov ebx, 6001h
        shl eax, 3
        mov edx, ecx
        add eax, SortCords
        call HitCrowdReaction
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.7:
        fld dword [byte ebp+018h]
        fabs
        fcomp qword [F64_0p785398_ResolveBodyCheck]
        fnstsw ax
        sahf
        jae near .8
        fld dword [byte esp+030h]
        fcomp dword [F32_neg4608]
        fnstsw ax
        sahf
        jae short .8
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        xor ebx, ebx
        push dword 3F800000h
        mov dh, byte [dword ecx+0BFh]
        push dword 40490FDBh
        or dh, 20h
        mov eax, ecx
        mov byte [dword ecx+0BFh], dh
        call HitDirection
        mov edx, eax
        mov eax, ecx
        call SetSPA
        mov eax, dword [dword ecx+0FAh]
        mov bl, byte [byte eax+031h]
        or bl, 1
        xor edx, edx
        mov byte [byte eax+031h], bl
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov ebx, 6001h
        shl eax, 3
        mov edx, ecx
        add eax, SortCords
        call HitCrowdReaction
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.8:
        fld dword [byte ebp+018h]
        fsub dword [byte ecx+01Ch]
        fld qword [F64_6p28319_ResolveBodyCheck]
        fxch
        call IF@DFMOD
        fst dword [byte ebp+018h]
        fst qword [byte esp+020h]
        fcomp qword [F64_3p14159_ResolveBodyCheck]
        fnstsw ax
        sahf
        jbe short .9
        fld qword [byte esp+020h]
        fadd qword [F64_neg6p28319_ResolveBodyCheck]
        fstp dword [byte ebp+018h]
.9:
        fld dword [byte ebp+018h]
        fst qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_ResolveBodyCheck]
        fnstsw ax
        sahf
        jae short .10
        fld qword [byte esp+08h]
        fadd qword [F64_6p28319_ResolveBodyCheck]
        fstp dword [byte ebp+018h]
.10:
        cmp word [byte ecx+06Ah], byte 28h
        jle near .16
        cmp dword [byte ecx+038h], 41F00000h
        jle near .16
        fld dword [byte ebp+018h]
        fabs
        fcomp qword [F64_0p785398_ResolveBodyCheck]
        fnstsw ax
        sahf
        jae short .14
        cmp ebx, 8Ch
        jl short .11
        cmp ebx, 8Eh
        jle short .12
.11:
        cmp ebx, 92h
        je short .12
        cmp ebx, 93h
        je short .12
        cmp ebx, 94h
        je short .12
        cmp ebx, 97h
        jl short .13
        cmp ebx, 99h
        jg short .13
.12:
        mov esi, 87h
        jmp near .34
.13:
        mov esi, 84h
        jmp near .34
.14:
        mov bh, byte [dword ecx+0D0h]
        xor edx, edx
        test bh, bh
        setne al
        fldz
        mov dl, al
        fcomp dword [byte ebp+018h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor edx, eax
        je short .15
        mov esi, 86h
        jmp near .34
.15:
        mov esi, 85h
        jmp near .34
.16:
        cmp ebx, 96h
        je short .17
        cmp ebx, 95h
        jne short .19
.17:
        mov bl, byte [dword ecx+0D0h]
        xor edx, edx
        test bl, bl
        setne al
        fldz
        mov dl, al
        fcomp dword [byte ebp+018h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        je short .18
        mov esi, 62h
        jmp near .34
.18:
        mov esi, 63h
        jmp near .34
.19:
        fld dword [byte ebp+018h]
        fabs
        fst qword [byte esp+018h]
        fcomp qword [F64_0p785398_ResolveBodyCheck]
        fnstsw ax
        sahf
        jae short .20
        mov esi, 6Ah
        jmp near .34
.20:
        fld qword [byte esp+018h]
        fcomp qword [F64_2p35619_ResolveBodyCheck]
        fnstsw ax
        sahf
        jbe short .24
        cmp ebx, 8Ch
        jl short .21
        cmp ebx, 8Eh
        jle short .22
.21:
        cmp ebx, 92h
        je short .22
        cmp ebx, 93h
        je short .22
        cmp ebx, 94h
        je short .22
        cmp ebx, 97h
        jl short .23
        cmp ebx, 99h
        jg short .23
.22:
        mov esi, 67h
        jmp near .34
.23:
        mov esi, 6Dh
        jmp near .34
.24:
        cmp byte [dword ecx+0D0h], 0
        setne al
        mov edx, eax
        fldz
        and edx, 0FFh
        fcomp dword [byte ebp+018h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        je short .29
        cmp ebx, 8Ch
        jl short .25
        cmp ebx, 8Eh
        jle short .26
.25:
        cmp ebx, 92h
        je short .26
        cmp ebx, 93h
        je short .26
        cmp ebx, 94h
        je short .26
        cmp ebx, 97h
        jl short .27
        cmp ebx, 99h
        jg short .27
.26:
        mov esi, 68h
        jmp near .34
.27:
        cmp word [byte ecx+06Ah], byte 1Eh
        jle short .28
        mov esi, 6Ch
        jmp near .34
.28:
        mov esi, 7Ch
        jmp short .34
.29:
        cmp ebx, 8Ch
        jl short .30
        cmp ebx, 8Eh
        jle short .31
.30:
        cmp ebx, 92h
        je short .31
        cmp ebx, 93h
        je short .31
        cmp ebx, 94h
        je short .31
        cmp ebx, 97h
        jl short .32
        cmp ebx, 99h
        jg short .32
.31:
        mov esi, 69h
        jmp short .34
.32:
        cmp word [byte ecx+06Ah], byte 1Eh
        jle short .33
        mov esi, 6Bh
        jmp short .34
.33:
        mov esi, 7Bh
.34:
        mov eax, dword [dword ecx+0FAh]
        call ResetAnimTimer
        mov edx, esi
        mov eax, ecx
        call HitKnockback
        xor eax, eax
        push byte 1
        mov al, byte [dword esi+MoveContactFlags]
        push eax
        mov eax, dword [dword ecx+0FAh]
        xor ebx, ebx
        mov edx, esi
        push dword [byte eax+038h]
        mov eax, ecx
        call StartCheckedAnim
        mov eax, dword [dword ecx+0FAh]
        or byte [byte eax+031h], 1
        xor edx, edx
        mov dl, byte [byte ecx+06Ch]
        mov eax, edx
        shl eax, 5
        add eax, edx
        mov ebx, 6002h
        shl eax, 3
        mov edx, ecx
        add eax, SortCords
        call HitCrowdReaction
        mov edx, dword [byte ecx+068h]
        mov eax, ecx
        sar edx, 10h
        call ChkPenaltyCall
.35:
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
;-----------------------------------------------------------------------------
; StartFallAnim                                   6E170  97 PC, low confidence
; Starts the fall animation
;-----------------------------------------------------------------------------
StartFallAnim:
        push ebx
        push ecx
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov esi, edx
        mov edx, 2
        mov eax, dword [dword eax+0F2h]
        call SetFaceExpression
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword ecx+0F2h]
        xor edx, edx
        call SetFaceBlink
        mov eax, dword [dword ecx+0FAh]
        mov dword [byte eax+038h], 3F800000h
        mov eax, dword [dword ecx+0FAh]
        mov edx, esi
        mov dword [byte eax+04h], 3F800000h
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        fld dword [byte ecx+038h]
        fsub dword [nosplit eax*8+StrideSpeeds]
        mov eax, dword [dword ecx+0FAh]
        fstp dword [byte eax+08h]
        mov eax, dword [dword ecx+0FAh]
        mov dword [byte eax+034h], 461C4000h
        mov ah, byte [dword ecx+0BFh]
        or ah, 20h
        xor ebx, ebx
        mov byte [dword ecx+0BFh], ah
        mov eax, ecx
        push dword 3F800000h
        call SetSPA
        fld dword [byte ecx+040h]
        fsub dword [byte ecx+01Ch]
        fld qword [F64_6p28319_StartFallAnim]
        fxch
        call IF@DFMOD
        fst dword [byte esp+010h]
        fst qword [esp]
        fcomp qword [F64_3p14159_StartFallAnim]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [esp]
        fadd qword [F64_neg6p28319_StartFallAnim]
        fstp dword [byte esp+010h]
.1:
        fld dword [byte esp+010h]
        fst qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_StartFallAnim]
        fnstsw ax
        sahf
        jae short .2
        fld qword [byte esp+08h]
        fadd qword [F64_6p28319_StartFallAnim]
        fstp dword [byte esp+010h]
.2:
        fld dword [byte esp+010h]
        fabs
        fcomp qword [F64_2p0944_StartFallAnim]
        fnstsw ax
        sahf
        jbe short .3
        mov eax, dword [dword ecx+0EEh]
        or byte [byte eax+031h], 8
        jmp short .4
.3:
        mov eax, dword [dword ecx+0EEh]
        and byte [byte eax+031h], 0F7h
.4:
        mov esp, ebp
        pop ebp
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; checkcx                                           6E290  94G, low confidence
; (player a3, player a2, ...) a collision between two players
; (x87): bounces, checking animations, interference (checkint), checkfight
;-----------------------------------------------------------------------------
checkcx:
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 50h
        and esp, byte 0FFFFFFF8h
        mov edi, eax
        mov esi, edx
        mov dword [esp], ebx
        test byte [dword eax+0BFh], 20h
        jne short .1
        test byte [dword edx+0BFh], 20h
        je short .2
.1:
        mov eax, dword [dword edi+0FAh]
        fld dword [byte eax+038h]
        fmul dword [byte edi+038h]
        fstp dword [byte edi+038h]
        mov eax, dword [dword esi+0FAh]
        fld dword [byte eax+038h]
        fmul dword [byte esi+038h]
        xor eax, eax
        fstp dword [byte esi+038h]
        jmp near .40
.2:
        fld dword [byte esi+020h]
        fsub dword [byte edi+020h]
        fld dword [byte esi+028h]
        fsub dword [byte edi+028h]
        fxch
        call IF@ATAN2
        fst dword [byte esp+040h]
        fsub dword [byte edi+01Ch]
        fld dword [byte esp+040h]
        fxch
        fld qword [F64_6p28319_checkcx]
        fxch
        call IF@DFMOD
        fxch
        fadd qword [F64_3p14159_checkcx]
        fstp dword [byte esp+04Ch]
        fst dword [byte esp+040h]
        fst qword [byte esp+024h]
        fcomp qword [F64_3p14159_checkcx]
        fnstsw ax
        sahf
        jbe short .3
        fld qword [byte esp+024h]
        fadd qword [F64_neg6p28319_checkcx]
        fstp dword [byte esp+040h]
.3:
        fld dword [byte esp+040h]
        fst qword [byte esp+01Ch]
        fcomp qword [F64_neg3p14159_checkcx]
        fnstsw ax
        sahf
        jae short .4
        fld qword [byte esp+01Ch]
        fadd qword [F64_6p28319_checkcx]
        fstp dword [byte esp+040h]
.4:
        fld dword [byte esp+04Ch]
        fsub dword [byte esi+01Ch]
        fld qword [F64_6p28319_checkcx]
        fxch
        call IF@DFMOD
        fst dword [byte esp+04Ch]
        fst qword [byte esp+014h]
        fcomp qword [F64_3p14159_checkcx]
        fnstsw ax
        sahf
        jbe short .5
        fld qword [byte esp+014h]
        fadd qword [F64_neg6p28319_checkcx]
        fstp dword [byte esp+04Ch]
.5:
        fld dword [byte esp+04Ch]
        fst qword [byte esp+034h]
        fcomp qword [F64_neg3p14159_checkcx]
        fnstsw ax
        sahf
        jae short .6
        fld qword [byte esp+034h]
        fadd qword [F64_6p28319_checkcx]
        fstp dword [byte esp+04Ch]
.6:
        fld dword [byte esp+040h]
        fabs
        fld dword [byte esp+04Ch]
        fabs
        mov eax, dword [dword edi+0EEh]
        fstp dword [byte esp+044h]
        mov dh, byte [byte eax+029h]
        fstp dword [byte esp+03Ch]
        test dh, 20h
        jne short .7
        mov eax, esi
        mov esi, edi
        mov edi, eax
        mov eax, dword [byte esp+040h]
        mov dword [byte esp+03Ch], eax
        mov eax, dword [byte esp+04Ch]
        mov dword [byte esp+040h], eax
        mov eax, dword [byte esp+03Ch]
        mov dword [byte esp+04Ch], eax
.7:
        or byte [dword esi+0BFh], 20h
        mov eax, dword [dword edi+0FAh]
        call ResetAnimTimer
        mov eax, dword [dword edi+0FAh]
        mov dword [byte eax+04h], 3F19999Ah
        cmp byte [dword edi+0A4h], 0Ch
        je near .19
        cmp word [dword edi+0A9h], byte 0
        je near .19
        mov eax, dword [dword edi+0EEh]
        test byte [byte eax+031h], 8
        je short .9
        fld dword [byte esp+03Ch]
        fst qword [byte esp+0Ch]
        fcomp qword [F64_0p349066_checkcx]
        fnstsw ax
        sahf
        jbe short .9
        fld qword [byte esp+0Ch]
        fcomp qword [F64_1p5708_checkcx]
        fnstsw ax
        sahf
        jae short .9
        mov dh, byte [dword edi+0D0h]
        xor ebx, ebx
        test dh, dh
        setne al
        fldz
        mov bl, al
        fcomp dword [byte esp+040h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, ebx
        je short .8
        mov ecx, 95h
        jmp near .18
.8:
        mov ecx, 96h
        jmp near .18
.9:
        fld dword [byte esp+03Ch]
        fcomp qword [F64_0p785398_checkcx]
        fnstsw ax
        sahf
        jae near .13
        fld dword [byte esp+044h]
        fcomp qword [F64_2p35619_checkcx]
        fnstsw ax
        sahf
        jbe short .10
        mov ecx, 8Eh
        jmp near .18
.10:
        cmp dword [esp], byte 1Eh
        jle short .11
        cmp dword [byte esi+038h], 41400000h
        jle short .11
        mov eax, dword [byte edi+018h]
        sar eax, 10h
        push eax
        mov eax, dword [byte edi+010h]
        sar eax, 10h
        push eax
        call vecdist
        add esp, byte 8
        cmp eax, byte 0Ch
        jbe short .11
        mov ecx, 99h
        jmp near .18
.11:
        mov eax, 64h
        call randomd0
        cmp ax, 45h
        jne short .12
        mov ecx, 8Fh
        jmp near .18
.12:
        mov eax, 3
        call randomd0
        cwde
        mov ecx, dword [nosplit eax*4+CollideAnimsFront]
        jmp near .18
.13:
        fld dword [byte esp+044h]
        fcomp qword [F64_2p35619_checkcx]
        fnstsw ax
        sahf
        jbe short .15
        mov dl, byte [dword edi+0D0h]
        xor ebx, ebx
        test dl, dl
        setne al
        fldz
        mov bl, al
        fcomp dword [byte esp+040h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, ebx
        je short .14
        mov ecx, 8Ch
        jmp near .18
.14:
        mov ecx, 8Dh
        jmp near .18
.15:
        cmp dword [esp], byte 1Eh
        jle short .16
        cmp dword [byte esi+038h], 41400000h
        jle short .16
        mov eax, dword [byte edi+018h]
        sar eax, 10h
        push eax
        mov eax, dword [byte edi+010h]
        sar eax, 10h
        push eax
        call vecdist
        add esp, byte 8
        cmp eax, byte 0Ch
        jbe short .16
        cmp ecx, byte 7
        jl short .16
        cmp ecx, byte 0Ah
        jg short .16
        cmp byte [dword edi+0D0h], 0
        setne al
        mov ebx, eax
        fldz
        and ebx, 0FFh
        fcomp dword [byte esp+040h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, ebx
        mov ecx, 97h
        jmp short .18
.16:
        cmp byte [dword edi+0D0h], 0
        setne al
        mov ebx, eax
        fldz
        and ebx, 0FFh
        fcomp dword [byte esp+040h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, ebx
        je short .17
        mov eax, 3
        call randomd0
        movsx ecx, ax
        mov ecx, dword [nosplit ecx*4+CollideAnimsSide]
        jmp short .18
.17:
        mov eax, 3
        call randomd0
        cwde
        mov ecx, dword [nosplit eax*4+CollideAnimsBack]
.18:
        mov eax, dword [dword edi+0FAh]
        or byte [byte eax+031h], 1
        mov eax, dword [dword edi+0FAh]
        mov dword [byte eax+038h], 3F800000h
        xor eax, eax
        push byte 0
        mov al, byte [dword ecx+MoveAnimIds]
        mov edx, ecx
        push eax
        xor ebx, ebx
        mov eax, edi
        push dword 3F19999Ah
        call StartCheckedAnim
.19:
        mov eax, dword [dword esi+0FAh]
        call ResetAnimTimer
        cmp word [dword esi+0A9h], byte 0
        jne near .23
        fld dword [byte esp+04Ch]
        fabs
        fcomp qword [F64_0p785398_checkcx]
        fnstsw ax
        sahf
        jae short .20
        mov ecx, 0B6h
        jmp short .22
.20:
        cmp byte [dword edi+0D0h], 0
        setne al
        mov ebx, eax
        fldz
        and ebx, 0FFh
        fcomp dword [byte esp+04Ch]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, ebx
        je short .21
        mov ecx, 0B7h
        jmp short .22
.21:
        mov ecx, 0B8h
.22:
        mov eax, dword [dword esi+0FAh]
        mov dword [byte eax+038h], 3F800000h
        mov al, byte [dword esi+0BFh]
        mov edx, ecx
        or al, 20h
        xor ebx, ebx
        mov byte [dword esi+0BFh], al
        mov eax, esi
        push dword 3F800000h
        call SetSPA
        mov eax, ecx
        shl ecx, 3
        sub ecx, eax
        fld dword [byte esi+038h]
        fsub dword [nosplit ecx*8+StrideSpeeds]
        mov eax, dword [dword esi+0FAh]
        fstp dword [byte eax+08h]
        mov eax, dword [dword esi+0FAh]
        mov dword [byte eax+034h], 461C4000h
        mov eax, dword [dword edi+0F6h]
        mov eax, dword [eax]
        call checkint
        or byte [dword esi+0BFh], 20h
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.23:
        mov eax, 5
        call randomd0
        test ax, ax
        je near .31
        xor ebx, ebx
        xor eax, eax
        mov bl, byte [dword esi+0C2h]
        mov al, byte [dword edi+0C2h]
        mov edx, dword [esp]
        sub eax, ebx
        add eax, edx
        cmp eax, byte 0Ah
        jg near .31
        mov eax, dword [PtrPuckZone]
        xor ebx, ebx
        movsx eax, byte [eax]
        mov bl, byte [dword esi+0A4h]
        cmp ebx, eax
        jne short .24
        cmp ecx, 9Ah
        jne short .24
        push dword [byte esi+028h]
        mov edx, 64h
        mov eax, 425h
        push dword [byte esi+020h]
        mov ecx, 83h
        call PlaySfxVolume
        jmp short .27
.24:
        fld dword [byte esp+04Ch]
        fabs
        fcomp qword [F64_0p785398_checkcx]
        fnstsw ax
        sahf
        jae short .25
        mov ecx, 66h
        jmp short .27
.25:
        cmp byte [dword edi+0D0h], 0
        setne al
        xor ebx, ebx
        fldz
        mov bl, al
        fcomp dword [byte esp+04Ch]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, ebx
        je short .26
        mov ecx, 64h
        jmp short .27
.26:
        mov ecx, 65h
.27:
        mov edx, ecx
        mov eax, esi
        call StartFallAnim
        xor ebx, ebx
        mov eax, dword [PtrPuckZone]
        mov bl, byte [dword esi+0A4h]
        movsx eax, byte [eax]
        cmp ebx, eax
        jne near .38
        mov eax, 64h
        call randomd0
        cmp ax, 28h
        jge short .28
        mov ebx, 6003h
        mov edx, esi
        mov eax, edi
        call HitCrowdReaction
        mov eax, dword [PtrPuckZone]
        mov byte [eax], 0FFh
        mov dword [byte esi+064h], 32h
        or byte [dword esi+0BFh], 20h
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.28:
        mov eax, 2
        call randomd0
        test ax, ax
        je short .29
        mov ebx, 6004h
        jmp short .30
.29:
        mov ebx, 6000h
.30:
        mov edx, esi
        mov eax, edi
        call HitCrowdReaction
        or byte [dword esi+0BFh], 20h
        mov eax, 1
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.31:
        mov edx, esi
        mov eax, edi
        call checkfight
        test eax, eax
        jne near .39
        cmp dword [byte esi+038h], 40C00000h
        jge short .32
        fld dword [byte edi+020h]
        fsub dword [byte esi+020h]
        fld dword [byte edi+028h]
        fsub dword [byte esi+028h]
        fxch
        call IF@ATAN2
        jmp short .33
.32:
        fld dword [byte esi+040h]
        fadd qword [F64_3p14159_checkcx]
.33:
        fstp dword [byte esp+048h]
        fld qword [F64_6p28319_checkcx]
        fld dword [byte esp+048h]
        call IF@DFMOD
        fst dword [byte esp+048h]
        fst qword [byte esp+02Ch]
        fcomp qword [F64_3p14159_checkcx]
        fnstsw ax
        sahf
        jbe short .34
        fld qword [byte esp+02Ch]
        fadd qword [F64_neg6p28319_checkcx]
        fstp dword [byte esp+048h]
.34:
        fld dword [byte esp+048h]
        fst qword [byte esp+04h]
        fcomp qword [F64_neg3p14159_checkcx]
        fnstsw ax
        sahf
        jae short .35
        fld qword [byte esp+04h]
        fadd qword [F64_6p28319_checkcx]
        fstp dword [byte esp+048h]
.35:
        cmp byte [dword esi+0A4h], 0Ch
        jne short .36
        test byte [dword edi+0BFh], 8
        je short .36
        inc byte [dword esi+0BEh]
.36:
        push ecx
        mov eax, esi
        push dword [byte esp+04Ch]
        call ResolveBodyCheck
        xor ecx, ecx
        mov eax, dword [PtrPuckZone]
        mov cl, byte [dword esi+0A4h]
        movsx ebx, byte [eax]
        cmp ecx, ebx
        jne short .37
        mov byte [eax], 0FFh
.37:
        mov dword [byte esi+064h], 32h
        test byte [gmode], 1
        jne short .38
        cmp dword [ReplayPlaying], byte 0
        jne short .38
        mov eax, dword [dword edi+0FEh]
        mov eax, dword [dword eax+0108h]
        inc word [dword eax+020E7h]
        cmp word [dword edi+0A9h], byte 0
        jle short .38
        cmp byte [dword edi+0A6h], 19h
        jge short .38
        mov eax, dword [dword edi+0A3h]
        sar eax, 18h
        imul eax, dword 125h
        mov ebx, dword [dword edi+0FEh]
        mov ebx, dword [dword ebx+0108h]
        inc word [dword ebx+eax+01B0h]
.38:
        or byte [dword esi+0BFh], 20h
.39:
        mov eax, 1
.40:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ResolvePlayerContact                            6E9A4  97 PC, low confidence
; Resolves contact between two players
;-----------------------------------------------------------------------------
ResolvePlayerContact:
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 90h
        and esp, byte 0FFFFFFF8h
        mov edi, eax
        mov esi, edx
        mov edx, 0FFFFFFFFh
        xor ecx, ecx
        mov ah, byte [dword eax+0BFh]
        mov dword [byte esp+010h], ecx
        mov dword [byte esp+08h], ecx
        mov dword [byte esp+014h], edx
        test ah, 20h
        jne short .1
        test byte [dword esi+0BFh], 20h
        je short .2
.1:
        mov eax, dword [dword edi+0FAh]
        fld dword [byte eax+038h]
        fmul dword [byte edi+038h]
        fstp dword [byte edi+038h]
        mov eax, dword [dword esi+0FAh]
        fld dword [byte eax+038h]
        fmul dword [byte esi+038h]
        xor eax, eax
        fstp dword [byte esi+038h]
        jmp near .46
.2:
        cmp ebx, byte 4Bh
        jge near .22
        fld dword [byte edi+040h]
        fsub dword [byte esi+040h]
        fld qword [F64_6p28319_ResolvePlayerContact]
        fxch
        call IF@DFMOD
        fld dword [byte edi+038h]
        fsub dword [byte esi+038h]
        fstp dword [dword esp+088h]
        fst dword [dword esp+080h]
        fst qword [byte esp+018h]
        fcomp qword [F64_3p14159_ResolvePlayerContact]
        fnstsw ax
        sahf
        jbe short .3
        fld qword [byte esp+018h]
        fadd qword [F64_neg6p28319_ResolvePlayerContact]
        fstp dword [dword esp+080h]
.3:
        fld dword [dword esp+080h]
        fst qword [byte esp+070h]
        fcomp qword [F64_neg3p14159_ResolvePlayerContact]
        fnstsw ax
        sahf
        jae short .4
        fld qword [byte esp+070h]
        fadd qword [F64_6p28319_ResolvePlayerContact]
        fstp dword [dword esp+080h]
.4:
        fld dword [dword esp+080h]
        fabs
        fcomp qword [F64_1p5708_ResolvePlayerContact]
        fnstsw ax
        sahf
        jae near .14
        fld dword [dword esp+088h]
        fabs
        fcomp qword [F64_5]
        fnstsw ax
        sahf
        jae near .14
        fldz
        lea edx, [byte edi+040h]
        fcomp dword [dword esp+080h]
        fnstsw ax
        sahf
        jae short .5
        mov ecx, 5A7ED197h
        mov eax, 3FE921FBh
        jmp short .6
.5:
        mov ecx, 5A7ED197h
        mov eax, 0BFE921FBh
.6:
        mov dword [byte esp+068h], ecx
        mov dword [byte esp+06Ch], eax
        fld dword [edx]
        fld st0
        fadd qword [byte esp+068h]
        fstp st1
        fstp dword [edx]
        fld qword [F64_6p28319_ResolvePlayerContact]
        fld dword [byte edi+040h]
        call IF@DFMOD
        fst dword [byte edi+040h]
        fst qword [byte esp+060h]
        fcomp qword [F64_3p14159_ResolvePlayerContact]
        fnstsw ax
        sahf
        jbe short .7
        fld qword [byte esp+060h]
        fadd qword [F64_neg6p28319_ResolvePlayerContact]
        fstp dword [byte edi+040h]
.7:
        fld dword [byte edi+040h]
        fst qword [byte esp+048h]
        fcomp qword [F64_neg3p14159_ResolvePlayerContact]
        fnstsw ax
        sahf
        jae short .8
        fld qword [byte esp+048h]
        fadd qword [F64_6p28319_ResolvePlayerContact]
        fstp dword [byte edi+040h]
.8:
        cmp dword [byte edi+038h], 40A00000h
        jge short .9
        mov dword [byte edi+038h], 40A00000h
.9:
        fldz
        lea edx, [byte esi+040h]
        fcomp dword [dword esp+080h]
        fnstsw ax
        sahf
        jbe short .10
        mov ecx, 5A7ED197h
        mov eax, 3FE921FBh
        jmp short .11
.10:
        mov ecx, 5A7ED197h
        mov eax, 0BFE921FBh
.11:
        mov dword [byte esp+058h], ecx
        mov dword [byte esp+05Ch], eax
        fld dword [edx]
        fld st0
        fadd qword [byte esp+058h]
        fstp st1
        fstp dword [edx]
        fld qword [F64_6p28319_ResolvePlayerContact]
        fld dword [byte esi+040h]
        call IF@DFMOD
        fst dword [byte esi+040h]
        fst qword [byte esp+030h]
        fcomp qword [F64_3p14159_ResolvePlayerContact]
        fnstsw ax
        sahf
        jbe short .12
        fld qword [byte esp+030h]
        fadd qword [F64_neg6p28319_ResolvePlayerContact]
        fstp dword [byte esi+040h]
.12:
        fld dword [byte esi+040h]
        fst qword [byte esp+040h]
        fcomp qword [F64_neg3p14159_ResolvePlayerContact]
        fnstsw ax
        sahf
        jae short .13
        fld qword [byte esp+040h]
        fadd qword [F64_6p28319_ResolvePlayerContact]
        fstp dword [byte esi+040h]
.13:
        cmp dword [byte esi+038h], 40A00000h
        jge short .14
        mov dword [byte esi+038h], 40A00000h
.14:
        cmp ebx, byte 1Eh
        jl short .15
        cmp dword [byte edi+038h], 41F00000h
        jge short .16
        cmp dword [byte esi+038h], 41F00000h
        jge short .16
.15:
        mov eax, dword [dword edi+0FAh]
        fld dword [byte eax+038h]
        fmul dword [byte edi+038h]
        fstp dword [byte edi+038h]
        mov eax, dword [dword esi+0FAh]
        fld dword [byte eax+038h]
        fmul dword [byte esi+038h]
        xor eax, eax
        fstp dword [byte esi+038h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.16:
        mov eax, 3
        call randomd0
        cwde
        mov dx, word [dword edi+0A9h]
        mov dword [byte esp+0Ch], eax
        test dx, dx
        je short .17
        mov eax, dword [byte edi+018h]
        sar eax, 10h
        push eax
        mov eax, dword [byte edi+010h]
        sar eax, 10h
        push eax
        call vecdist
        add esp, byte 8
        xor edx, edx
        mov dword [esp], eax
        mov dword [byte esp+04h], edx
        fild qword [esp]
        fadd dword [F32_10_ResolvePlayerContact]
        fcomp dword [byte edi+038h]
        fnstsw ax
        sahf
        jbe short .17
        mov ecx, 5
        mov edx, ebx
        mov eax, ebx
        sar edx, 1Fh
        idiv ecx
        mov edx, dword [dword edi+0FAh]
        mov dword [byte edx+024h], eax
        mov eax, dword [byte esp+0Ch]
        add eax, 81h
        mov ecx, 1
        mov dword [byte esp+014h], eax
        mov edx, eax
        mov eax, edi
        mov dword [byte esp+010h], ecx
        call StartFallAnim
.17:
        mov edx, dword [byte esp+0Ch]
        inc edx
        mov ecx, 3
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov cx, word [dword esi+0A9h]
        mov dword [byte esp+0Ch], edx
        test cx, cx
        je short .18
        mov eax, dword [byte esi+018h]
        sar eax, 10h
        push eax
        mov eax, dword [byte esi+010h]
        sar eax, 10h
        push eax
        call vecdist
        add esp, byte 8
        mov dword [esp], eax
        xor eax, eax
        mov dword [byte esp+04h], eax
        fild qword [esp]
        fadd dword [F32_10_ResolvePlayerContact]
        fcomp dword [byte esi+038h]
        fnstsw ax
        sahf
        jbe short .18
        mov ecx, 5
        mov edx, ebx
        mov eax, ebx
        sar edx, 1Fh
        idiv ecx
        mov edx, dword [dword esi+0FAh]
        mov dword [byte edx+024h], eax
        mov eax, dword [byte esp+0Ch]
        add eax, 81h
        mov dword [byte esp+014h], eax
        mov edx, eax
        mov eax, esi
        call StartFallAnim
        mov dword [byte esp+08h], 1
.18:
        cmp dword [byte esp+010h], byte 0
        je short .19
        cmp dword [byte esp+08h], byte 0
        jne short .21
.19:
        cmp dword [byte esp+010h], byte 0
        je short .20
        cmp word [dword esi+0A9h], byte 0
        je short .21
.20:
        cmp dword [byte esp+08h], byte 0
        je short .22
        cmp word [dword edi+0A9h], byte 0
        jne short .22
.21:
        push dword [byte esi+028h]
        mov edx, 64h
        mov eax, 425h
        push dword [byte esi+020h]
        call PlaySfxVolume
        jmp near .45
.22:
        fld dword [byte esi+020h]
        fsub dword [byte edi+020h]
        fld dword [byte esi+028h]
        fsub dword [byte edi+028h]
        fxch
        call IF@ATAN2
        fst dword [dword esp+08Ch]
        fadd qword [F64_3p14159_ResolvePlayerContact]
        mov bx, word [dword edi+0A9h]
        fstp dword [dword esp+084h]
        test bx, bx
        je near .30
        cmp dword [byte esp+010h], byte 0
        jne near .30
        fld dword [dword esp+08Ch]
        fsub dword [byte edi+01Ch]
        fld qword [F64_6p28319_ResolvePlayerContact]
        fxch
        call IF@DFMOD
        fst dword [dword esp+08Ch]
        fst qword [byte esp+020h]
        fcomp qword [F64_3p14159_ResolvePlayerContact]
        fnstsw ax
        sahf
        jbe short .23
        fld qword [byte esp+020h]
        fadd qword [F64_neg6p28319_ResolvePlayerContact]
        fstp dword [dword esp+08Ch]
.23:
        fld dword [dword esp+08Ch]
        fst qword [byte esp+028h]
        fcomp qword [F64_neg3p14159_ResolvePlayerContact]
        fnstsw ax
        sahf
        jae short .24
        fld qword [byte esp+028h]
        fadd qword [F64_6p28319_ResolvePlayerContact]
        fstp dword [dword esp+08Ch]
.24:
        fld dword [dword esp+08Ch]
        fabs
        fst qword [byte esp+078h]
        fcomp qword [F64_0p785398_ResolvePlayerContact]
        fnstsw ax
        sahf
        jae short .25
        mov dword [byte esp+014h], 6Ah
        jmp short .28
.25:
        fld qword [byte esp+078h]
        fcomp qword [F64_2p35619_ResolvePlayerContact]
        fnstsw ax
        sahf
        jbe short .26
        mov dword [byte esp+014h], 67h
        jmp short .28
.26:
        cmp byte [dword edi+0D0h], 0
        setne al
        xor edx, edx
        fldz
        mov dl, al
        fcomp dword [dword esp+08Ch]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        je short .27
        mov dword [byte esp+014h], 68h
        jmp short .28
.27:
        mov dword [byte esp+014h], 69h
.28:
        mov eax, dword [dword edi+0FAh]
        mov edx, dword [byte esp+014h]
        call ResetAnimTimer
        mov eax, edi
        call HitKnockback
        mov edx, dword [byte esp+014h]
        xor eax, eax
        push byte 1
        mov al, byte [dword edx+MoveContactFlags]
        push eax
        mov eax, dword [dword edi+0FAh]
        xor ebx, ebx
        push dword [byte eax+038h]
        mov eax, edi
        call StartCheckedAnim
        mov eax, dword [dword edi+0FAh]
        or byte [byte eax+031h], 1
        mov eax, dword [dword edi+0EEh]
        or byte [byte eax+031h], 1
        mov edx, 2
        mov eax, dword [dword edi+0F2h]
        call SetFaceExpression
        mov eax, dword [dword edi+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword edi+0F2h]
        xor edx, edx
        xor ebx, ebx
        call SetFaceBlink
        mov eax, dword [PtrPuckZone]
        mov bl, byte [dword edi+0A4h]
        movsx edx, byte [eax]
        cmp ebx, edx
        jne short .29
        mov byte [eax], 0FFh
.29:
        mov dword [byte edi+064h], 32h
.30:
        cmp word [dword esi+0A9h], byte 0
        je near .45
        cmp dword [byte esp+08h], byte 0
        jne near .45
        fld dword [dword esp+084h]
        fsub dword [byte esi+01Ch]
        fld qword [F64_6p28319_ResolvePlayerContact]
        fxch
        call IF@DFMOD
        fst dword [dword esp+084h]
        fst qword [byte esp+050h]
        fcomp qword [F64_3p14159_ResolvePlayerContact]
        fnstsw ax
        sahf
        jbe short .31
        fld qword [byte esp+050h]
        fadd qword [F64_neg6p28319_ResolvePlayerContact]
        fstp dword [dword esp+084h]
.31:
        fld dword [dword esp+084h]
        fst qword [byte esp+038h]
        fcomp qword [F64_neg3p14159_ResolvePlayerContact]
        fnstsw ax
        sahf
        jae short .32
        fld qword [byte esp+038h]
        fadd qword [F64_6p28319_ResolvePlayerContact]
        fstp dword [dword esp+084h]
.32:
        fld dword [dword esp+084h]
        fabs
        mov ecx, dword [byte esp+014h]
        fcomp qword [F64_0p785398_ResolvePlayerContact]
        fnstsw ax
        sahf
        jae short .36
        cmp ecx, byte 67h
        jl short .33
        cmp ecx, byte 6Ah
        jle short .34
.33:
        mov eax, 1
        jmp short .35
.34:
        xor eax, eax
.35:
        test eax, eax
        je short .36
        mov ecx, 6Ah
        jmp near .42
.36:
        fld dword [dword esp+084h]
        fabs
        fcomp qword [F64_2p35619_ResolvePlayerContact]
        fnstsw ax
        sahf
        jbe short .38
        cmp ecx, byte 67h
        jl short .37
        cmp ecx, byte 6Ah
        jg short .37
        mov ecx, 6Dh
        jmp short .42
.37:
        mov ecx, 67h
        jmp short .42
.38:
        mov ah, byte [dword esi+0D0h]
        xor edx, edx
        test ah, ah
        setne al
        fldz
        mov dl, al
        fcomp dword [dword esp+084h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, edx
        je short .40
        cmp ecx, byte 67h
        jl short .39
        cmp ecx, byte 6Ah
        jg short .39
        mov ecx, 7Ch
        jmp short .42
.39:
        mov ecx, 68h
        jmp short .42
.40:
        cmp ecx, byte 67h
        jl short .41
        cmp ecx, byte 6Ah
        jg short .41
        mov ecx, 7Bh
        jmp short .42
.41:
        mov ecx, 69h
.42:
        mov eax, dword [dword esi+0FAh]
        call ResetAnimTimer
        cmp word [dword edi+0A9h], byte 0
        je short .43
        cmp dword [byte esp+010h], byte 0
        jne short .43
        mov eax, dword [dword esi+0FAh]
        or byte [byte eax+031h], 20h
.43:
        mov edx, ecx
        mov eax, esi
        call HitKnockback
        xor eax, eax
        push byte 1
        mov al, byte [dword ecx+MoveContactFlags]
        push eax
        mov eax, dword [dword esi+0FAh]
        xor ebx, ebx
        mov edx, ecx
        push dword [byte eax+038h]
        mov eax, esi
        call StartCheckedAnim
        mov eax, dword [dword esi+0FAh]
        or byte [byte eax+031h], 1
        mov eax, dword [dword esi+0EEh]
        or byte [byte eax+031h], 1
        mov edx, 2
        mov eax, dword [dword esi+0F2h]
        call SetFaceExpression
        mov eax, dword [dword esi+0F2h]
        xor edx, edx
        call SetFaceMouth
        mov eax, dword [dword esi+0F2h]
        xor edx, edx
        call SetFaceBlink
        xor edx, edx
        mov eax, dword [PtrPuckZone]
        mov dl, byte [dword esi+0A4h]
        movsx ebx, byte [eax]
        cmp edx, ebx
        jne short .44
        mov byte [eax], 0FFh
.44:
        mov dword [byte esi+064h], 32h
.45:
        mov eax, 1
.46:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; StickContact                                    6F104  97 PC, low confidence
; Stick against a player
;-----------------------------------------------------------------------------
StickContact:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 38h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov edi, edx
        mov esi, dword [dword eax+0FAh]
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+028h]
        and eax, 0FFFFh
        cmp eax, byte 61h
        je near .13
        test byte [dword ecx+0BFh], 20h
        je short .1
        xor eax, eax
        jmp near .14
.1:
        mov eax, dword [PtrPuckZone]
        xor edx, edx
        movsx eax, byte [eax]
        mov dl, byte [dword ecx+0A4h]
        cmp edx, eax
        jne short .2
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        cmp dword [byte ecx+038h], 40C00000h
        jge short .3
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.3:
        fld dword [byte edi+020h]
        fsub dword [byte ecx+020h]
        fld dword [byte edi+028h]
        fsub dword [byte ecx+028h]
        fxch
        call IF@ATAN2
        fst dword [byte esp+034h]
        fsub dword [byte ecx+040h]
        fld qword [F64_6p28319_StickContact]
        fxch
        call IF@DFMOD
        fst dword [byte esp+030h]
        fst qword [byte esp+020h]
        fcomp qword [F64_3p14159_StickContact]
        fnstsw ax
        sahf
        jbe short .4
        fld qword [byte esp+020h]
        fadd qword [F64_neg6p28319_StickContact]
        fstp dword [byte esp+030h]
.4:
        fld dword [byte esp+030h]
        fst qword [byte esp+028h]
        fcomp qword [F64_neg3p14159_StickContact]
        fnstsw ax
        sahf
        jae short .5
        fld qword [byte esp+028h]
        fadd qword [F64_6p28319_StickContact]
        fstp dword [byte esp+030h]
.5:
        fld dword [byte esp+030h]
        fabs
        fcomp qword [F64_0p785398_StickContact]
        fnstsw ax
        sahf
        jbe short .6
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.6:
        fld dword [byte esp+034h]
        fsub dword [byte ecx+01Ch]
        fld qword [F64_6p28319_StickContact]
        fxch
        call IF@DFMOD
        fst dword [byte esp+034h]
        fst qword [byte esp+010h]
        fcomp qword [F64_3p14159_StickContact]
        fnstsw ax
        sahf
        jbe short .7
        fld qword [byte esp+010h]
        fadd qword [F64_neg6p28319_StickContact]
        fstp dword [byte esp+034h]
.7:
        fld dword [byte esp+034h]
        fst qword [byte esp+018h]
        fcomp qword [F64_neg3p14159_StickContact]
        fnstsw ax
        sahf
        jae short .8
        fld qword [byte esp+018h]
        fadd qword [F64_6p28319_StickContact]
        fstp dword [byte esp+034h]
.8:
        fld dword [byte esp+034h]
        fabs
        fcomp qword [F64_0p785398_StickContact]
        fnstsw ax
        sahf
        jbe short .9
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.9:
        mov ebx, esp
        mov edx, dword [StickContactPts]
        mov eax, edi
        call ObjectFramePos
        cmp dword [byte esp+04h], 43100000h
        jle short .10
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.10:
        mov eax, esi
        call ResetAnimTimer
        fld dword [byte ecx+038h]
        fdiv dword [DodgeScale]
        fstp dword [byte esi+04h]
        cmp dword [byte esi+04h], 3F800000h
        jle short .11
        mov dword [byte esi+04h], 3F800000h
.11:
        cmp dword [byte esi+04h], 3F000000h
        jge short .12
        mov dword [byte esi+04h], 3F000000h
.12:
        fld dword [byte esi+04h]
        fadd qword [F64_neg0p5_StickContact]
        fmul qword [F64_10_StickContact]
        push byte 1
        call __CHP
        fistp dword [byte esp+010h]
        mov edx, dword [byte esp+010h]
        mov eax, ecx
        push edx
        xor ebx, ebx
        mov edx, 61h
        push dword [byte esi+04h]
        call StartCheckedAnim
.13:
        mov eax, 1
.14:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PlayerPush                                      6F300  97 PC, low confidence
; Pushes two players apart
;-----------------------------------------------------------------------------
PlayerPush:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 2Ch
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        fld dword [byte ebx+028h]
        fld dword [byte ebx+020h]
        fsub dword [byte edx+020h]
        fxch
        fsub dword [byte edx+028h]
        fxch
        fstp dword [byte esp+028h]
        fld dword [byte esp+028h]
        call IF@ATAN2
        fstp dword [byte esp+024h]
        fld dword [byte ebx+050h]
        fadd dword [byte edx+050h]
        mov eax, dword [dword ebx+0FAh]
        fadd dword [F32_16]
        mov cl, byte [byte eax+030h]
        fstp dword [byte esp+020h]
        test cl, 18h
        jne short .1
        mov eax, dword [dword edx+0FAh]
        test byte [byte eax+030h], 18h
        jne near .2
        test dword [byte edx+038h], 7FFFFFFFh
        je short .1
        xor eax, eax
        movzx esi, byte [dword ebx+0A4h]
        mov al, byte [dword ebx+0C2h]
        movzx edi, byte [dword edx+0C2h]
        shl eax, 4
        shl edi, 4
        add eax, esi
        movzx esi, byte [dword edx+0A4h]
        add esi, edi
        cmp eax, esi
        jle near .2
.1:
        fld dword [byte esp+024h]
        lea edi, [byte esp+018h]
        lea esi, [byte esp+08h]
        fld st0
        fadd qword [F64_3p14159_PlayerPush]
        lea eax, [byte esp+024h]
        fstp st1
        fstp dword [byte esp+024h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte esp+020h]
        fld st0
        fld dword [byte edx+020h]
        fld dword [byte edx+028h]
        mov eax, dword [dword edx+0D2h]
        fxch
        fstp dword [dword edx+0D2h]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [dword edx+0DAh]
        fstp dword [dword edx+0DAh]
        fmul dword [byte esp+08h]
        fadd dword [byte ebx+020h]
        fstp dword [byte edx+020h]
        fmul dword [byte esp+018h]
        mov dword [byte esp+010h], eax
        fadd dword [byte ebx+028h]
        mov eax, edx
        fstp dword [byte edx+028h]
        call PlayerCollisions
        test eax, eax
        je near .3
        mov eax, dword [byte esp+0Ch]
        fld dword [dword edx+0D2h]
        mov dword [dword edx+0D2h], eax
        mov eax, dword [byte esp+010h]
        fld dword [dword edx+0DAh]
        mov dword [dword edx+0DAh], eax
        fxch
        fstp dword [byte edx+020h]
        fstp dword [byte edx+028h]
        fld dword [byte esp+024h]
        fadd qword [F64_neg3p14159_PlayerPush]
        fstp dword [byte esp+024h]
.2:
        lea edi, [byte esp+018h]
        lea esi, [byte esp+08h]
        lea eax, [byte esp+024h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte esp+020h]
        fld st0
        fld dword [byte ebx+020h]
        fld dword [byte ebx+028h]
        mov eax, dword [dword ebx+0D2h]
        fxch
        fstp dword [dword ebx+0D2h]
        mov dword [byte esp+014h], eax
        mov eax, dword [dword ebx+0DAh]
        fstp dword [dword ebx+0DAh]
        fmul dword [byte esp+08h]
        fadd dword [byte edx+020h]
        fstp dword [byte ebx+020h]
        fmul dword [byte esp+018h]
        mov dword [byte esp+01Ch], eax
        fadd dword [byte edx+028h]
        mov eax, ebx
        fstp dword [byte ebx+028h]
        call PlayerCollisions
        test eax, eax
        je near .3
        fld dword [dword ebx+0D2h]
        mov eax, dword [byte esp+014h]
        fld dword [dword ebx+0DAh]
        mov dword [dword ebx+0D2h], eax
        mov eax, dword [byte esp+01Ch]
        lea edi, [byte esp+018h]
        mov dword [dword ebx+0DAh], eax
        lea esi, [byte esp+08h]
        fxch
        fstp dword [byte ebx+020h]
        fstp dword [byte ebx+028h]
        fld dword [byte esp+024h]
        fld st0
        fadd qword [F64_3p14159_PlayerPush]
        lea eax, [byte esp+024h]
        fstp st1
        fstp dword [byte esp+024h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte esp+020h]
        fld st0
        fld dword [byte edx+028h]
        mov eax, dword [byte edx+020h]
        mov dword [dword edx+0D2h], eax
        fstp dword [dword edx+0DAh]
        fmul dword [byte esp+08h]
        fadd dword [byte ebx+020h]
        fstp dword [byte edx+020h]
        fmul dword [byte esp+018h]
        fadd dword [byte ebx+028h]
        mov eax, edx
        fstp dword [byte edx+028h]
        call PlayerCollisions
        test eax, eax
        je short .3
        fld dword [dword edx+0D2h]
        fld dword [dword edx+0DAh]
        mov eax, dword [byte esp+014h]
        fstp dword [byte edx+028h]
        mov dword [dword edx+0D2h], eax
        mov eax, dword [byte esp+01Ch]
        fstp dword [byte edx+020h]
        mov dword [dword edx+0DAh], eax
.3:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ContactAngle                                    6F55C  97 PC, low confidence
; Works out the contact angle
;-----------------------------------------------------------------------------
ContactAngle:
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        and esp, byte 0FFFFFFF8h
        mov edi, eax
        mov esi, edx
        mov eax, edx
        call VecDot
        fstp dword [byte esp+04h]
        cmp dword [byte esp+04h], 3F800000h
        jge short .1
        mov eax, dword [esi]
        mov dword [ebx], eax
        fld dword [ebx]
        mov eax, dword [byte esi+04h]
        mov dword [byte ebx+04h], eax
        mov eax, dword [byte esi+08h]
        mov dword [byte ebx+08h], eax
        fsub dword [edi]
        fstp dword [ecx]
        fld dword [byte ebx+04h]
        fsub dword [byte edi+04h]
        fstp dword [byte ecx+04h]
        fld dword [byte ebx+08h]
        xor ebx, ebx
        fsub dword [byte edi+08h]
        mov dword [byte esp+08h], ebx
        fstp dword [byte ecx+08h]
        jmp short .2
.1:
        mov edx, esi
        mov eax, edi
        call VecDot
        fdiv dword [byte esp+04h]
        fld dword [esi]
        fxch
        fstp dword [esp]
        fmul dword [esp]
        fstp dword [ebx]
        fld dword [byte esi+04h]
        fmul dword [esp]
        fstp dword [byte ebx+04h]
        fld dword [byte esi+08h]
        fmul dword [esp]
        fstp dword [byte ebx+08h]
        fld dword [edi]
        fsub dword [ebx]
        fstp dword [ecx]
        fld dword [byte edi+04h]
        fsub dword [byte ebx+04h]
        fstp dword [byte ecx+04h]
        fld dword [byte edi+08h]
        fsub dword [byte ebx+08h]
        mov ebx, dword [esp]
        fstp dword [byte ecx+08h]
        mov dword [byte esp+08h], ebx
.2:
        fld dword [byte esp+08h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; checkplcoll                                       6F604  94G, low confidence
; a player's collisions with the other players (checkcx,
; ResolvePlayerContact) and the rest
;-----------------------------------------------------------------------------
checkplcoll:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 0C0h
        and esp, byte 0FFFFFFF8h
        mov dword [dword esp+084h], eax
        mov dword [dword esp+080h], edx
        mov eax, edx
        fld dword [byte eax+020h]
        mov eax, dword [dword esp+084h]
        fsub dword [byte eax+020h]
        mov eax, edx
        fld dword [byte eax+028h]
        mov eax, dword [dword esp+084h]
        fxch
        fstp dword [dword esp+0B8h]
        fsub dword [byte eax+028h]
        fld dword [byte eax+050h]
        fxch
        fstp dword [dword esp+09Ch]
        fadd dword [byte edx+050h]
        mov dl, byte [dword eax+0BFh]
        fstp dword [dword esp+094h]
        test dl, 4
        jne short .1
        mov eax, dword [dword esp+080h]
        test byte [dword eax+0BFh], 4
        je short .2
.1:
        xor eax, eax
        jmp near .33
.2:
        mov eax, dword [dword esp+084h]
        test byte [dword eax+0C0h], 20h
        jne short .3
        mov eax, dword [dword esp+080h]
        test byte [dword eax+0C0h], 20h
        je short .4
.3:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.4:
        mov eax, dword [dword esp+084h]
        mov cl, byte [dword eax+0C0h]
        xor edx, edx
        test cl, 1
        setne dl
        mov eax, dword [dword esp+080h]
        test byte [dword eax+0C0h], 1
        setne al
        and eax, 0FFh
        xor eax, edx
        je short .5
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.5:
        mov eax, dword [dword esp+084h]
        test byte [dword eax+0C0h], 1
        jne short .6
        mov eax, dword [dword esp+080h]
        test byte [dword eax+0C0h], 1
        je short .8
.6:
        mov eax, dword [dword esp+084h]
        mov eax, dword [dword eax+0FAh]
        mov bl, byte [byte eax+030h]
        test bl, 2
        jne short .7
        test bl, 4
        jne short .7
        test bl, 2
        jne short .7
        test bl, 4
        je short .8
.7:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.8:
        fld dword [dword esp+0B8h]
        fabs
        fld dword [dword esp+094h]
        fstp qword [dword esp+088h]
        fcomp qword [dword esp+088h]
        fnstsw ax
        sahf
        jbe short .9
        fld dword [dword esp+09Ch]
        fabs
        fcomp qword [dword esp+088h]
        fnstsw ax
        sahf
        jbe short .9
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.9:
        fld dword [dword esp+09Ch]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [dword esp+0C0h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fld dword [dword esp+094h]
        fxch
        fstp dword [dword esp+0A8h]
        fsub dword [dword esp+0A8h]
        fldz
        fxch
        fstp dword [dword esp+094h]
        fcomp dword [dword esp+094h]
        fnstsw ax
        sahf
        jbe short .10
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.10:
        mov eax, dword [dword esp+084h]
        mov eax, dword [dword eax+0EEh]
        test byte [byte eax+031h], 1
        je short .12
        mov edx, dword [dword esp+080h]
        mov eax, dword [dword esp+084h]
        mov bl, byte [dword edx+0A4h]
        cmp bl, byte [byte eax+06Ch]
        jne short .11
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.11:
        mov edx, dword [dword esp+084h]
        mov eax, dword [dword esp+080h]
        call StickContact
        test eax, eax
        je short .12
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.12:
        mov eax, dword [dword esp+080h]
        mov eax, dword [dword eax+0EEh]
        test byte [byte eax+031h], 1
        je short .14
        mov edx, dword [dword esp+084h]
        mov eax, dword [dword esp+080h]
        mov cl, byte [dword edx+0A4h]
        cmp cl, byte [byte eax+06Ch]
        jne short .13
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.13:
        mov edx, dword [dword esp+080h]
        mov eax, dword [dword esp+084h]
        call StickContact
        test eax, eax
        je short .14
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.14:
        mov eax, dword [dword esp+084h]
        mov eax, dword [dword eax+0EEh]
        test byte [byte eax+029h], 20h
        jne short .15
        mov eax, dword [dword esp+080h]
        mov eax, dword [dword eax+0EEh]
        test byte [byte eax+029h], 20h
        je short .15
        mov edx, dword [dword esp+080h]
        mov eax, dword [dword esp+084h]
        mov dword [dword esp+084h], edx
        mov dword [dword esp+080h], eax
.15:
        mov eax, dword [dword esp+084h]
        xor edx, edx
        mov dl, byte [dword eax+0C2h]
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        add eax, eax
        add eax, byte 78h
        mov dword [byte esp+074h], eax
        mov eax, dword [dword esp+080h]
        xor edx, edx
        mov dl, byte [dword eax+0C2h]
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        add eax, eax
        add eax, byte 78h
        mov dword [byte esp+078h], eax
        mov eax, dword [dword esp+0B8h]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [dword esp+09Ch]
        fld dword [dword esp+0A8h]
        mov dword [byte esp+014h], eax
        fabs
        fild dword [byte esp+074h]
        fst dword [dword esp+0B4h]
        xor edx, edx
        fild dword [byte esp+078h]
        fstp dword [dword esp+0BCh]
        fadd dword [dword esp+0BCh]
        mov dword [byte esp+010h], edx
        fstp dword [dword esp+098h]
        fcomp qword [F64_0p0001_checkplcoll]
        fnstsw ax
        sahf
        jae short .16
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.16:
        mov eax, dword [dword esp+084h]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte esp+030h], eax
        mov eax, dword [dword esp+084h]
        mov dword [byte esp+034h], edx
        mov eax, dword [byte eax+034h]
        mov edx, dword [dword esp+084h]
        mov dword [byte esp+038h], eax
        mov edx, dword [dword edx+0FAh]
        cmp dword [byte edx+038h], 3F800000h
        je short .18
        fld dword [byte edx+038h]
        fcomp qword [F64_0p0001_checkplcoll]
        fnstsw ax
        sahf
        jae short .17
        mov dword [byte edx+038h], 3F800000h
.17:
        mov eax, dword [dword esp+084h]
        mov eax, dword [dword eax+0FAh]
        fld dword [byte esp+030h]
        fdiv dword [byte eax+038h]
        mov eax, dword [dword esp+084h]
        fstp dword [byte esp+030h]
        mov eax, dword [dword eax+0FAh]
        fld dword [byte esp+038h]
        fdiv dword [byte eax+038h]
        fstp dword [byte esp+038h]
.18:
        lea ecx, [byte esp+024h]
        lea ebx, [byte esp+018h]
        lea edx, [byte esp+0Ch]
        lea eax, [byte esp+030h]
        call ContactAngle
        mov eax, dword [dword esp+080h]
        mov eax, dword [byte eax+02Ch]
        xor esi, esi
        mov dword [byte esp+030h], eax
        mov eax, dword [dword esp+080h]
        mov dword [byte esp+034h], esi
        mov eax, dword [byte eax+034h]
        mov edx, dword [dword esp+080h]
        mov dword [byte esp+038h], eax
        mov edx, dword [dword edx+0FAh]
        mov edi, dword [byte edx+038h]
        fstp dword [dword esp+0A4h]
        cmp edi, 3F800000h
        je short .20
        fld dword [byte edx+038h]
        fcomp qword [F64_0p0001_checkplcoll]
        fnstsw ax
        sahf
        jae short .19
        mov dword [byte edx+038h], 3F800000h
.19:
        mov eax, dword [dword esp+080h]
        mov eax, dword [dword eax+0FAh]
        fld dword [byte esp+030h]
        fdiv dword [byte eax+038h]
        mov eax, dword [dword esp+080h]
        fstp dword [byte esp+030h]
        mov eax, dword [dword eax+0FAh]
        fld dword [byte esp+038h]
        fdiv dword [byte eax+038h]
        fstp dword [byte esp+038h]
.20:
        mov ecx, esp
        lea ebx, [byte esp+03Ch]
        lea edx, [byte esp+0Ch]
        lea eax, [byte esp+030h]
        call ContactAngle
        fld dword [dword esp+0A4h]
        fxch
        fstp dword [dword esp+0A0h]
        fsub dword [dword esp+0A0h]
        fmul dword [dword esp+0A8h]
        call __CHP
        fistp dword [byte esp+07Ch]
        cmp dword [byte esp+07Ch], byte 5
        jge short .21
        mov dword [byte esp+07Ch], 5
.21:
        mov ebx, dword [byte esp+07Ch]
        cmp ebx, byte 46h
        jle short .22
        mov dword [dword esp+090h], 3F4CCCCDh
        jmp short .24
.22:
        cmp ebx, byte 0Ah
        jge short .23
        mov dword [dword esp+090h], 3F000000h
        jmp short .24
.23:
        lea edx, [byte ebx-0Ah]
        mov ebx, 0C8h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov dword [byte esp+074h], eax
        fild dword [byte esp+074h]
        fadd qword [F64_0p5_checkplcoll]
        fstp dword [dword esp+090h]
.24:
        fld dword [dword esp+0B4h]
        fld st0
        fld dword [dword esp+0BCh]
        fxch
        fsub st1
        fld dword [dword esp+0A4h]
        fxch
        fmul st1
        fld st2
        fmul qword [F64_2_checkplcoll]
        fld dword [dword esp+0A0h]
        fst qword [byte esp+058h]
        fxch
        fmul qword [byte esp+058h]
        faddp st2
        fld dword [dword esp+098h]
        fld1
        fdivrp
        fxch st4
        fsub st5
        fmulp
        fxch st4
        fmul qword [F64_2_checkplcoll]
        fmul st2
        fxch st3
        fstp qword [byte esp+050h]
        fmul qword [byte esp+050h]
        fld dword [dword esp+090h]
        fld st0
        fld1
        fsubrp
        fxch st3
        fmul st3
        fxch st4
        faddp st5
        fld qword [byte esp+058h]
        fmulp st3
        fxch st4
        fmul qword [byte esp+050h]
        fld st1
        fmul st5
        fld st1
        fmulp st6
        faddp st4
        fld dword [byte esp+0Ch]
        fxch st4
        fstp st2
        fxch st3
        fmul st1
        fld dword [byte esp+014h]
        fmulp st2
        fxch st4
        faddp st2
        fld dword [byte esp+0Ch]
        fxch st2
        fstp st3
        fxch
        fmul st2
        fld dword [byte esp+014h]
        fmulp st3
        mov eax, dword [dword esp+084h]
        fxch st3
        fstp dword [byte esp+018h]
        fstp dword [byte esp+020h]
        fxch
        fstp dword [byte esp+03Ch]
        fld dword [byte esp+018h]
        fadd dword [byte esp+024h]
        fxch
        fstp dword [byte esp+044h]
        fstp dword [byte eax+02Ch]
        fld dword [byte esp+020h]
        fadd dword [byte esp+02Ch]
        fstp dword [byte eax+034h]
        fld dword [byte esp+03Ch]
        fadd dword [esp]
        mov eax, dword [dword esp+080h]
        fstp dword [byte eax+02Ch]
        fld dword [byte esp+044h]
        fadd dword [byte esp+08h]
        fstp dword [byte eax+034h]
        mov eax, dword [dword esp+084h]
        sub esp, byte 8
        fld dword [byte eax+034h]
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte eax+02Ch]
        fstp qword [esp]
        call hypot_
        mov eax, dword [dword esp+084h]
        fstp dword [byte eax+038h]
        mov eax, dword [dword esp+080h]
        sub esp, byte 8
        fld dword [byte eax+034h]
        fstp qword [esp]
        sub esp, byte 8
        fld dword [byte eax+02Ch]
        fstp qword [esp]
        call hypot_
        mov eax, dword [dword esp+080h]
        fstp dword [byte eax+038h]
        mov eax, dword [dword esp+084h]
        fld dword [byte eax+034h]
        fld dword [byte eax+02Ch]
        call IF@ATAN2
        mov eax, dword [dword esp+084h]
        fstp dword [byte eax+040h]
        mov eax, dword [dword esp+080h]
        fld dword [byte eax+034h]
        fld dword [byte eax+02Ch]
        call IF@ATAN2
        mov eax, dword [dword esp+080h]
        fstp dword [byte eax+040h]
        mov eax, dword [dword esp+084h]
        mov eax, dword [dword eax+0FAh]
        or byte [byte eax+030h], 20h
        mov eax, dword [dword esp+080h]
        mov eax, dword [dword eax+0FAh]
        or byte [byte eax+030h], 20h
        mov eax, dword [dword esp+084h]
        test byte [dword eax+0C0h], 1
        jne short .25
        mov eax, dword [dword esp+080h]
        test byte [dword eax+0C0h], 1
        je short .26
.25:
        mov edx, dword [dword esp+080h]
        mov eax, dword [dword esp+084h]
        call PlayerPush
        jmp near .32
.26:
        mov edx, dword [dword esp+084h]
        mov al, byte [dword eax+0A4h]
        mov byte [byte edx+06Ch], al
        mov al, byte [dword edx+0A4h]
        mov edx, dword [dword esp+080h]
        fld dword [dword esp+0B8h]
        mov byte [byte edx+06Ch], al
        mov eax, dword [byte esp+07Ch]
        mov edx, dword [dword esp+084h]
        fld dword [dword esp+09Ch]
        mov word [byte edx+06Ah], ax
        mov edx, dword [dword esp+080h]
        fxch
        mov word [byte edx+06Ah], ax
        call IF@ATAN2
        lea edi, [dword esp+0ACh]
        lea esi, [dword esp+0B0h]
        lea eax, [byte esp+070h]
        fstp dword [byte esp+070h]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [dword esp+094h]
        fmul qword [F64_0p5_checkplcoll]
        fld dword [dword esp+0B0h]
        fld st0
        fmul st2
        fld dword [dword esp+0ACh]
        fmul to st3
        fxch
        fstp st2
        fxch st2
        fstp st2
        fstp dword [dword esp+0B0h]
        fstp dword [dword esp+0ACh]
        fld dword [byte edx+020h]
        fadd dword [dword esp+0B0h]
        fld dword [byte edx+028h]
        fxch
        fstp dword [byte edx+020h]
        fadd dword [dword esp+0ACh]
        mov eax, edx
        fstp dword [byte edx+028h]
        call PuckGroundHeight
        mov eax, dword [dword esp+084h]
        fld dword [byte eax+020h]
        fsub dword [dword esp+0B0h]
        fld dword [byte eax+028h]
        fxch
        fstp dword [byte eax+020h]
        fsub dword [dword esp+0ACh]
        mov edx, dword [dword esp+084h]
        fstp dword [byte eax+028h]
        call PuckGroundHeight
        mov edx, dword [dword edx+0FAh]
        test byte [byte edx+031h], 10h
        je short .27
        mov ecx, dword [byte edx+020h]
        mov bl, byte [byte edx+031h]
        mov eax, ecx
        and bl, 0EFh
        shl eax, 5
        mov byte [byte edx+031h], bl
        mov edx, dword [dword esp+084h]
        add eax, ecx
        mov bh, byte [dword edx+0BFh]
        shl eax, 3
        and bh, 0DFh
        add eax, SortCords
        mov byte [dword edx+0BFh], bh
        mov edx, dword [dword eax+0FAh]
        and byte [byte edx+031h], 0EFh
        and byte [dword eax+0BFh], 0DFh
.27:
        mov edx, dword [dword esp+080h]
        mov edx, dword [dword edx+0FAh]
        test byte [byte edx+031h], 10h
        je short .28
        mov ecx, dword [byte edx+020h]
        mov bl, byte [byte edx+031h]
        mov eax, ecx
        and bl, 0EFh
        shl eax, 5
        mov byte [byte edx+031h], bl
        mov edx, dword [dword esp+080h]
        add eax, ecx
        mov bh, byte [dword edx+0BFh]
        shl eax, 3
        and bh, 0DFh
        add eax, SortCords
        mov byte [dword edx+0BFh], bh
        mov edx, dword [dword eax+0FAh]
        and byte [byte edx+031h], 0EFh
        and byte [dword eax+0BFh], 0DFh
.28:
        mov eax, dword [dword esp+084h]
        xor edx, edx
        mov ebx, dword [dword esp+080h]
        mov dl, byte [dword eax+0BFh]
        xor eax, eax
        mov al, byte [dword ebx+0BFh]
        xor eax, edx
        test al, 40h
        setne al
        and eax, 0FFh
        je short .31
        mov eax, dword [dword esp+084h]
        mov eax, dword [dword eax+0EEh]
        test byte [byte eax+029h], 20h
        jne short .29
        mov eax, dword [dword ebx+0EEh]
        test byte [byte eax+029h], 20h
        je short .30
.29:
        mov ebx, dword [byte esp+07Ch]
        mov edx, dword [dword esp+080h]
        mov eax, dword [dword esp+084h]
        call checkcx
        jmp short .31
.30:
        mov ebx, dword [byte esp+07Ch]
        mov edx, dword [dword esp+080h]
        mov eax, dword [dword esp+084h]
        call ResolvePlayerContact
.31:
        mov eax, dword [dword esp+084h]
        mov eax, dword [dword eax+0EEh]
        and byte [byte eax+029h], 0DFh
.32:
        mov eax, 1
.33:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
