; Goalie AI: reading the shot, angles, covering the post and the goalie tick.
bits 32
%include "hockey.inc"
section s_5F016 progbits alloc exec nowrite align=1
extern AnimClockTick, F32_12, F32_176, F32_288, F32_2_GoalieReadShot, F32_30_UpdateGoalie, F32_3p95, F32_480
extern F32_4_GoalieReadShot, F32_neg12, F32_neg1_UpdateGoalie, F32_neg4, F32_neg4272_GoalieReadShot, F32_neg88, F64_0p2_UpdateGoalie, F64_0p392699_UpdateGoalie
extern F64_0p785398_GoalieReadShot, F64_0p785398_UpdateGoalie, F64_1272, F64_180, F64_1896, F64_1p52588eneg05, F64_1p975, F64_240_GoalieReadShot
extern F64_2p35619_UpdateGoalie, F64_2p82743, F64_3p14159_GoalieAI, F64_3p14159_GoalieAngle, F64_3p14159_GoalieCoverPost, F64_3p14159_GoalieReadShot, F64_4032, F64_4656
extern F64_6p28319_GoalieAI, F64_6p28319_GoalieAngle, F64_6p28319_GoalieCoverPost, F64_6p28319_GoalieReadShot, F64_neg1, F64_neg3p14159_GoalieAI, F64_neg3p14159_GoalieAngle, F64_neg3p14159_GoalieCoverPost
extern F64_neg3p14159_GoalieReadShot, F64_neg6p28319_GoalieAI, F64_neg6p28319_GoalieAngle, F64_neg6p28319_GoalieCoverPost, F64_neg6p28319_GoalieReadShot, gmode, GoalieTickCount, GoalieTickData
extern hypot_, IF@ATAN2, IF@DFMOD, PickSkateAnim, PtrAwayIce, PtrHomeIce, SkateStrideTable, StickHandleSpeed
extern StickHandleTarget
global GoalieReadShot, GoalieAngle, GoalieCoverPost, GoalieAI, TurnRateForSpeed, UpdateGoalie, GoalieTick
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; GoalieReadShot                                  5F018  97 PC, low confidence
; Goalie AI: reads the shot and picks the save position
;-----------------------------------------------------------------------------
GoalieReadShot:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 138h
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        fldz
        mov ebx, 43853333h
        mov ecx, 0C3853333h
        mov esi, 4582CCCDh
        mov eax, dword [byte eax+020h]
        mov edi, 458DB333h
        mov dword [dword esp+0130h], eax
        mov dword [byte esp+05Ch], ebx
        mov dword [byte esp+058h], ecx
        mov dword [byte esp+064h], esi
        mov eax, dword [byte edx+028h]
        mov dword [byte esp+060h], edi
        mov dword [dword esp+0134h], eax
        mov eax, dword [byte edx+048h]
        mov ecx, 45858000h
        mov dword [dword esp+0108h], eax
        mov eax, dword [byte edx+04Ch]
        xor ebx, ebx
        mov dword [dword esp+011Ch], eax
        mov eax, 45858CCDh
        mov dword [dword esp+0114h], ecx
        mov dword [dword esp+0110h], eax
        fcomp dword [dword esp+0134h]
        fnstsw ax
        sahf
        jae short .1
        mov eax, dword [PtrAwayIce]
        jmp short .2
.1:
        mov eax, dword [PtrHomeIce]
.2:
        mov esi, dword [dword edx+0FAh]
        and byte [byte esi+030h], 0EFh
        mov ecx, eax
        test byte [gmode], 1
        je near .6
        test dword [byte eax+020h], 7FFFFFFFh
        jne short .5
        fldz
        fcomp dword [dword esp+0134h]
        fnstsw ax
        sahf
        jae short .3
        mov dword [byte esp+040h], 10B0h
        jmp short .4
.3:
        mov dword [byte esp+040h], 0FFFFEF50h
.4:
        fild dword [byte esp+040h]
        fcomp dword [byte ecx+028h]
        fnstsw ax
        sahf
        je short .6
.5:
        fld dword [byte ecx+028h]
        fabs
        fld dword [byte esp+05Ch]
        fld dword [byte esp+058h]
        fld dword [byte esp+064h]
        fld dword [byte esp+060h]
        fld dword [dword esp+0110h]
        fxch st4
        fadd dword [byte ecx+020h]
        fxch st3
        fadd dword [byte ecx+020h]
        fxch st3
        fstp dword [byte esp+05Ch]
        fxch st2
        fstp dword [byte esp+058h]
        fxch st3
        fst dword [dword esp+0114h]
        fadd dword [F32_neg4272_GoalieReadShot]
        fxch st3
        fadd st3
        fxch
        fadd st3
        fxch st2
        faddp st3
        fstp dword [byte esp+064h]
        fstp dword [byte esp+060h]
        fstp dword [dword esp+0110h]
.6:
        cmp word [dword edx+0A9h], byte 0
        jne short .7
        fld dword [dword esp+0134h]
        fabs
        fld dword [dword esp+0114h]
        fstp qword [dword esp+0E0h]
        fcomp qword [dword esp+0E0h]
        fnstsw ax
        sahf
        ja short .7
        fld dword [dword esp+011Ch]
        fabs
        fcomp qword [dword esp+0E0h]
        fnstsw ax
        sahf
        ja short .7
        xor eax, eax
        jmp near .85
.7:
        cmp byte [dword edx+0A4h], 0Ch
        jne short .8
        test byte [gmode], 1
        je short .8
        fld dword [dword esp+0134h]
        fabs
        fld dword [dword esp+0114h]
        fstp qword [byte esp+070h]
        fcomp qword [byte esp+070h]
        fnstsw ax
        sahf
        ja short .8
        fld dword [dword esp+011Ch]
        fabs
        fcomp qword [byte esp+070h]
        fnstsw ax
        sahf
        ja short .8
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        fldz
        fcomp dword [dword esp+0134h]
        fnstsw ax
        sahf
        jae near .16
        fld dword [dword esp+0134h]
        fcomp dword [byte esp+064h]
        fnstsw ax
        sahf
        jae short .9
        fld dword [dword esp+011Ch]
        fcomp dword [byte esp+064h]
        fnstsw ax
        sahf
        jb short .12
.9:
        fld dword [dword esp+0134h]
        fcomp dword [byte esp+060h]
        fnstsw ax
        sahf
        jbe short .10
        fld dword [dword esp+011Ch]
        fcomp dword [byte esp+060h]
        fnstsw ax
        sahf
        ja short .12
.10:
        fld dword [dword esp+0130h]
        fcomp dword [byte esp+05Ch]
        fnstsw ax
        sahf
        jbe short .11
        fld dword [dword esp+0108h]
        fcomp dword [byte esp+05Ch]
        fnstsw ax
        sahf
        ja short .12
.11:
        fld dword [dword esp+0130h]
        fcomp dword [byte esp+058h]
        fnstsw ax
        sahf
        jae short .13
        fld dword [dword esp+0108h]
        fcomp dword [byte esp+058h]
        fnstsw ax
        sahf
        jae short .13
.12:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.13:
        fld dword [dword esp+011Ch]
        fcomp dword [byte esp+064h]
        fnstsw ax
        sahf
        jb near .24
        fld dword [dword esp+011Ch]
        fcomp dword [byte esp+060h]
        fnstsw ax
        sahf
        ja near .24
        fld dword [dword esp+0108h]
        fcomp dword [byte esp+05Ch]
        fnstsw ax
        sahf
        ja near .24
        fld dword [dword esp+0108h]
        fcomp dword [byte esp+058h]
        fnstsw ax
        sahf
        jb near .24
        fld dword [dword esp+0110h]
        fld dword [dword esp+011Ch]
        fsub st1
        fld dword [dword esp+0108h]
        call IF@ATAN2
        fld dword [dword esp+0134h]
        fsubrp st2
        fld st1
        fld dword [dword esp+0130h]
        call IF@ATAN2
        fstp st2
        fsubp
        fld qword [F64_6p28319_GoalieReadShot]
        fxch
        call IF@DFMOD
        fst dword [dword esp+010Ch]
        fst qword [dword esp+088h]
        fcomp qword [F64_3p14159_GoalieReadShot]
        fnstsw ax
        sahf
        jbe short .14
        fld qword [dword esp+088h]
        fadd qword [F64_neg6p28319_GoalieReadShot]
        fstp dword [dword esp+010Ch]
.14:
        fld dword [dword esp+010Ch]
        fst qword [dword esp+090h]
        fcomp qword [F64_neg3p14159_GoalieReadShot]
        fnstsw ax
        sahf
        jae short .15
        fld qword [dword esp+090h]
        fadd qword [F64_6p28319_GoalieReadShot]
        fstp dword [dword esp+010Ch]
.15:
        fld dword [dword esp+010Ch]
        fabs
        fcomp qword [F64_0p785398_GoalieReadShot]
        fnstsw ax
        sahf
        jae near .24
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.16:
        fld dword [byte esp+064h]
        fld dword [byte esp+060h]
        fld dword [dword esp+0110h]
        fld dword [dword esp+0134h]
        fxch st3
        fchs
        fxch st2
        fchs
        fxch
        fchs
        fxch st2
        fstp dword [byte esp+064h]
        fstp dword [byte esp+060h]
        fstp dword [dword esp+0110h]
        fcomp dword [byte esp+064h]
        fnstsw ax
        sahf
        jbe short .17
        fld dword [dword esp+011Ch]
        fcomp dword [byte esp+064h]
        fnstsw ax
        sahf
        ja short .20
.17:
        fld dword [dword esp+0134h]
        fcomp dword [byte esp+060h]
        fnstsw ax
        sahf
        jae short .18
        fld dword [dword esp+011Ch]
        fcomp dword [byte esp+060h]
        fnstsw ax
        sahf
        jb short .20
.18:
        fld dword [dword esp+0130h]
        fcomp dword [byte esp+05Ch]
        fnstsw ax
        sahf
        jbe short .19
        fld dword [dword esp+0108h]
        fcomp dword [byte esp+05Ch]
        fnstsw ax
        sahf
        ja short .20
.19:
        fld dword [dword esp+0130h]
        fcomp dword [byte esp+058h]
        fnstsw ax
        sahf
        jae short .21
        fld dword [dword esp+0108h]
        fcomp dword [byte esp+058h]
        fnstsw ax
        sahf
        jae short .21
.20:
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.21:
        fld dword [dword esp+011Ch]
        fcomp dword [byte esp+064h]
        fnstsw ax
        sahf
        ja near .24
        fld dword [dword esp+011Ch]
        fcomp dword [byte esp+060h]
        fnstsw ax
        sahf
        jb near .24
        fld dword [dword esp+0108h]
        fcomp dword [byte esp+05Ch]
        fnstsw ax
        sahf
        ja near .24
        fld dword [dword esp+0108h]
        fcomp dword [byte esp+058h]
        fnstsw ax
        sahf
        jb near .24
        fld dword [dword esp+0110h]
        fld dword [dword esp+011Ch]
        fsub st1
        fld dword [dword esp+0108h]
        call IF@ATAN2
        fld dword [dword esp+0134h]
        fsubrp st2
        fld st1
        fld dword [dword esp+0130h]
        call IF@ATAN2
        fstp st2
        fstp dword [byte esp+020h]
        fsub dword [byte esp+020h]
        fld qword [F64_6p28319_GoalieReadShot]
        fxch
        call IF@DFMOD
        fst dword [dword esp+0104h]
        fst qword [dword esp+0A0h]
        fcomp qword [F64_3p14159_GoalieReadShot]
        fnstsw ax
        sahf
        jbe short .22
        fld qword [dword esp+0A0h]
        fadd qword [F64_neg6p28319_GoalieReadShot]
        fstp dword [dword esp+0104h]
.22:
        fld dword [dword esp+0104h]
        fst qword [dword esp+098h]
        fcomp qword [F64_neg3p14159_GoalieReadShot]
        fnstsw ax
        sahf
        jae short .23
        fld qword [dword esp+098h]
        fadd qword [F64_6p28319_GoalieReadShot]
        fstp dword [dword esp+0104h]
.23:
        fld dword [dword esp+0104h]
        fabs
        fcomp qword [F64_0p785398_GoalieReadShot]
        fnstsw ax
        sahf
        jae short .24
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.24:
        fld dword [dword esp+0130h]
        fsub dword [byte ecx+020h]
        fabs
        fcomp qword [F64_180]
        fnstsw ax
        sahf
        ja near .38
        fld dword [dword esp+0134h]
        fabs
        fld dword [dword esp+0110h]
        fabs
        fxch
        fst dword [dword esp+0FCh]
        fcompp
        fnstsw ax
        sahf
        jbe short .25
        mov eax, 1
        jmp short .26
.25:
        xor eax, eax
.26:
        mov ecx, eax
        test eax, eax
        je short .27
        mov eax, dword [byte esp+060h]
        jmp short .28
.27:
        mov eax, dword [byte esp+064h]
.28:
        mov dword [dword esp+0F8h], eax
        mov eax, dword [dword esp+0F8h]
        fld dword [dword esp+0F8h]
        mov dword [byte esp+01Ch], eax
        fabs
        fld dword [dword esp+0F8h]
        fld st0
        fadd dword [F32_neg4]
        fxch
        fadd dword [F32_4_GoalieReadShot]
        fxch
        fstp dword [byte esp+03Ch]
        fstp dword [byte esp+028h]
        fld st0
        fadd dword [F32_4_GoalieReadShot]
        fxch
        fadd dword [F32_neg4]
        fxch
        fstp dword [byte esp+030h]
        fstp dword [byte esp+044h]
        test ecx, ecx
        je short .32
        fld dword [dword esp+0FCh]
        fcomp dword [byte esp+044h]
        fnstsw ax
        sahf
        jae short .29
        mov ebx, 1
        jmp near .37
.29:
        fld dword [dword esp+0FCh]
        fcomp dword [byte esp+030h]
        fnstsw ax
        sahf
        jae near .37
        fldz
        fcomp dword [dword esp+0134h]
        fnstsw ax
        sahf
        jbe short .30
        mov eax, dword [byte esp+03Ch]
        jmp short .31
.30:
        mov eax, dword [byte esp+028h]
.31:
        mov dword [byte esp+02Ch], eax
        mov eax, dword [byte esp+02Ch]
        jmp short .36
.32:
        fld dword [dword esp+0FCh]
        fcomp dword [byte esp+030h]
        fnstsw ax
        sahf
        jbe short .33
        mov ebx, 1
        jmp short .37
.33:
        fld dword [dword esp+0FCh]
        fcomp dword [byte esp+044h]
        fnstsw ax
        sahf
        jbe short .37
        fldz
        fcomp dword [dword esp+0134h]
        fnstsw ax
        sahf
        jbe short .34
        mov eax, dword [byte esp+028h]
        jmp short .35
.34:
        mov eax, dword [byte esp+03Ch]
.35:
        mov dword [byte esp+048h], eax
        mov eax, dword [byte esp+048h]
.36:
        mov dword [dword esp+0134h], eax
.37:
        fld dword [dword esp+0130h]
        fld dword [byte esp+05Ch]
        fsub st1
        fld dword [byte esp+01Ch]
        fsub dword [dword esp+0134h]
        fld st0
        fxch st2
        fld st2
        fxch
        call IF@ATAN2
        fstp st2
        fld dword [byte esp+058h]
        fsubrp st3
        fxch st2
        fld st2
        fxch
        call IF@ATAN2
        fstp st2
        fxch
        jmp near .48
.38:
        fld dword [dword esp+0134h]
        fabs
        fld dword [dword esp+0114h]
        fxch
        fstp qword [dword esp+080h]
        fcomp qword [dword esp+080h]
        fnstsw ax
        sahf
        ja near .45
        fld dword [dword esp+0114h]
        fadd dword [F32_176]
        fcomp qword [dword esp+080h]
        fnstsw ax
        sahf
        jb near .45
        fldz
        fcomp dword [dword esp+0130h]
        fnstsw ax
        sahf
        jae short .39
        mov eax, dword [byte esp+05Ch]
        jmp short .40
.39:
        mov eax, dword [byte esp+058h]
.40:
        mov dword [byte esp+038h], eax
        fld dword [byte esp+05Ch]
        mov eax, dword [byte esp+038h]
        fadd dword [F32_neg4]
        mov dword [byte esp+018h], eax
        fld dword [dword esp+0130h]
        fabs
        fstp qword [dword esp+0A8h]
        fcomp qword [dword esp+0A8h]
        fnstsw ax
        sahf
        jbe short .41
        mov ebx, 1
        jmp short .44
.41:
        fld dword [byte esp+05Ch]
        fadd dword [F32_4_GoalieReadShot]
        fst dword [dword esp+0F4h]
        fcomp qword [dword esp+0A8h]
        fnstsw ax
        sahf
        jbe short .44
        fldz
        fcomp dword [dword esp+0130h]
        fnstsw ax
        sahf
        jbe short .42
        fld dword [byte esp+058h]
        fadd dword [F32_neg4]
        fstp dword [byte esp+04Ch]
        jmp short .43
.42:
        mov eax, dword [dword esp+0F4h]
        mov dword [byte esp+04Ch], eax
.43:
        mov eax, dword [byte esp+04Ch]
        mov dword [dword esp+0130h], eax
.44:
        fld dword [byte esp+018h]
        fld dword [dword esp+0134h]
        fld dword [byte esp+064h]
        fsub st1
        fxch st2
        fsub dword [dword esp+0130h]
        fld st0
        fld st3
        fxch
        call IF@ATAN2
        fstp st3
        fld dword [byte esp+060h]
        fsubrp st2
        call IF@ATAN2
        fxch
        fstp dword [dword esp+0128h]
        fstp dword [dword esp+012Ch]
        jmp near .49
.45:
        fldz
        fldz
        xor ecx, ecx
        fxch
        fld dword [dword esp+0130h]
        fxch
        fcomp
        fnstsw ax
        sahf
        setb al
        mov cl, al
        fxch
        fld dword [dword esp+0134h]
        fxch
        fcomp
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        fld st0
        xor ecx, eax
        fcomp dword [dword esp+0110h]
        fnstsw ax
        sahf
        seta al
        fld dword [byte esp+060h]
        fld dword [byte esp+058h]
        fld dword [byte esp+064h]
        fld dword [byte esp+05Ch]
        and eax, 0FFh
        fxch st3
        fsub st4
        fxch st2
        fsub st5
        fxch
        fsubrp st4
        fxch st2
        fsubrp st4
        fstp dword [dword esp+0124h]
        fstp dword [dword esp+0E8h]
        fstp dword [dword esp+0120h]
        fstp dword [dword esp+0118h]
        xor eax, ecx
        je short .46
        fld dword [dword esp+0120h]
        fld dword [dword esp+0118h]
        call IF@ATAN2
        fld dword [dword esp+0124h]
        jmp short .47
.46:
        fld dword [dword esp+0124h]
        fld dword [dword esp+0118h]
        call IF@ATAN2
        fld dword [dword esp+0120h]
.47:
        fld dword [dword esp+0E8h]
        call IF@ATAN2
.48:
        fstp dword [dword esp+012Ch]
        fstp dword [dword esp+0128h]
.49:
        test ebx, ebx
        je short .50
        mov eax, dword [dword edx+0FAh]
        or byte [byte eax+030h], 10h
.50:
        fld dword [dword esp+0108h]
        fsub dword [dword esp+0130h]
        fld dword [dword esp+011Ch]
        fsub dword [dword esp+0134h]
        fxch
        call IF@ATAN2
        fstp dword [dword esp+0ECh]
        mov eax, dword [byte edx+01Ch]
        mov dword [dword esp+0100h], eax
        mov eax, dword [dword edx+0EEh]
        test byte [byte eax+031h], 8
        je short .51
        fld dword [dword esp+0100h]
        fld st0
        fadd qword [F64_3p14159_GoalieReadShot]
        fstp st1
        fstp dword [dword esp+0100h]
.51:
        cmp dword [byte edx+038h], 41400000h
        jl short .52
        mov eax, dword [byte edx+040h]
        mov dword [dword esp+0100h], eax
.52:
        fld qword [F64_6p28319_GoalieReadShot]
        fld dword [dword esp+0128h]
        call IF@DFMOD
        fld dword [dword esp+0100h]
        fld dword [dword esp+012Ch]
        fld dword [dword esp+0ECh]
        fxch st2
        fsub dword [dword esp+0ECh]
        fxch
        fsub dword [dword esp+0128h]
        fxch st2
        fsub dword [dword esp+0128h]
        fxch
        fstp dword [dword esp+0F0h]
        fxch
        fstp dword [dword esp+012Ch]
        fstp dword [dword esp+0ECh]
        fst dword [dword esp+0128h]
        fst qword [byte esp+068h]
        fcomp qword [F64_3p14159_GoalieReadShot]
        fnstsw ax
        sahf
        jbe short .53
        fld qword [byte esp+068h]
        fadd qword [F64_neg6p28319_GoalieReadShot]
        fstp dword [dword esp+0128h]
.53:
        fld dword [dword esp+0128h]
        fst qword [dword esp+0C0h]
        fcomp qword [F64_neg3p14159_GoalieReadShot]
        fnstsw ax
        sahf
        jae short .54
        fld qword [dword esp+0C0h]
        fadd qword [F64_6p28319_GoalieReadShot]
        fstp dword [dword esp+0128h]
.54:
        fld qword [F64_6p28319_GoalieReadShot]
        fld dword [dword esp+012Ch]
        call IF@DFMOD
        fst dword [dword esp+012Ch]
        fst qword [dword esp+0C8h]
        fcomp qword [F64_3p14159_GoalieReadShot]
        fnstsw ax
        sahf
        jbe short .55
        fld qword [dword esp+0C8h]
        fadd qword [F64_neg6p28319_GoalieReadShot]
        fstp dword [dword esp+012Ch]
.55:
        fld dword [dword esp+012Ch]
        fst qword [byte esp+078h]
        fcomp qword [F64_neg3p14159_GoalieReadShot]
        fnstsw ax
        sahf
        jae short .56
        fld qword [byte esp+078h]
        fadd qword [F64_6p28319_GoalieReadShot]
        fstp dword [dword esp+012Ch]
.56:
        fld qword [F64_6p28319_GoalieReadShot]
        fld dword [dword esp+0ECh]
        call IF@DFMOD
        fst dword [dword esp+0ECh]
        fst qword [dword esp+0B0h]
        fcomp qword [F64_3p14159_GoalieReadShot]
        fnstsw ax
        sahf
        jbe short .57
        fld qword [dword esp+0B0h]
        fadd qword [F64_neg6p28319_GoalieReadShot]
        fstp dword [dword esp+0ECh]
.57:
        fld dword [dword esp+0ECh]
        fst qword [dword esp+0B8h]
        fcomp qword [F64_neg3p14159_GoalieReadShot]
        fnstsw ax
        sahf
        jae short .58
        fld qword [dword esp+0B8h]
        fadd qword [F64_6p28319_GoalieReadShot]
        fstp dword [dword esp+0ECh]
.58:
        fld qword [F64_6p28319_GoalieReadShot]
        fld dword [dword esp+0F0h]
        call IF@DFMOD
        fst dword [dword esp+0F0h]
        fst qword [dword esp+0D8h]
        fcomp qword [F64_3p14159_GoalieReadShot]
        fnstsw ax
        sahf
        jbe short .59
        fld qword [dword esp+0D8h]
        fadd qword [F64_neg6p28319_GoalieReadShot]
        fstp dword [dword esp+0F0h]
.59:
        fld dword [dword esp+0F0h]
        fst qword [dword esp+0D0h]
        fcomp qword [F64_neg3p14159_GoalieReadShot]
        fnstsw ax
        sahf
        jae short .60
        fld qword [dword esp+0D0h]
        fadd qword [F64_6p28319_GoalieReadShot]
        fstp dword [dword esp+0F0h]
.60:
        fldz
        fcomp dword [dword esp+012Ch]
        fnstsw ax
        sahf
        jbe near .66
        fldz
        fcomp dword [dword esp+0ECh]
        fnstsw ax
        sahf
        jbe short .61
        fld dword [dword esp+0ECh]
        fcomp dword [dword esp+012Ch]
        fnstsw ax
        sahf
        ja short .62
.61:
        mov eax, 1
        jmp short .63
.62:
        xor eax, eax
.63:
        test eax, eax
        setne al
        and eax, 0FFh
        xor eax, ebx
        je short .64
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.64:
        fldz
        fcomp dword [dword esp+0F0h]
        fnstsw ax
        sahf
        setb al
        and eax, 0FFh
        xor eax, ebx
        je short .65
        mov eax, dword [dword esp+0128h]
        mov ecx, 3E20D97Ch
        mov dword [dword esp+0ECh], eax
        mov dword [byte esp+054h], ecx
        jmp near .73
.65:
        fld dword [dword esp+0128h]
        mov eax, 0BE20D97Ch
        fadd dword [dword esp+012Ch]
        mov dword [byte esp+054h], eax
        jmp near .72
.66:
        fldz
        fcomp dword [dword esp+0ECh]
        fnstsw ax
        sahf
        jae short .67
        fld dword [dword esp+0ECh]
        fcomp dword [dword esp+012Ch]
        fnstsw ax
        sahf
        jb short .68
.67:
        mov eax, 1
        jmp short .69
.68:
        xor eax, eax
.69:
        test eax, eax
        setne al
        and eax, 0FFh
        xor eax, ebx
        je short .70
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.70:
        fldz
        fcomp dword [dword esp+0F0h]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor eax, ebx
        je short .71
        mov eax, dword [dword esp+0128h]
        mov edi, 0BE20D97Ch
        mov dword [dword esp+0ECh], eax
        mov dword [byte esp+054h], edi
        jmp short .73
.71:
        fld dword [dword esp+0128h]
        mov esi, 3E20D97Ch
        fadd dword [dword esp+012Ch]
        mov dword [byte esp+054h], esi
.72:
        fstp dword [dword esp+0ECh]
.73:
        test ebx, ebx
        je short .74
        fld dword [byte esp+054h]
        fchs
        fstp dword [byte esp+054h]
.74:
        fld dword [dword esp+0110h]
        fsub dword [dword esp+0134h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [dword esp+0138h]
        sub esp, byte 8
        fchs
        fstp qword [esp]
        call hypot_
        fadd qword [F64_240_GoalieReadShot]
        fst dword [byte esp+050h]
        fcomp dword [F32_480]
        fnstsw ax
        sahf
        jae short .76
        fld dword [dword esp+0114h]
        fadd dword [F32_288]
        fld dword [dword esp+0134h]
        fabs
        fcompp
        fnstsw ax
        sahf
        jbe short .75
        fld dword [byte esp+054h]
        fmul dword [F32_2_GoalieReadShot]
        fld dword [dword esp+0ECh]
        fxch
        fstp dword [byte esp+054h]
        jmp short .77
.75:
        fld dword [dword esp+0134h]
        fsub dword [dword esp+0110h]
        fld dword [dword esp+0130h]
        call IF@ATAN2
        mov dword [byte esp+050h], 43B40000h
        jmp short .78
.76:
        fld dword [dword esp+0ECh]
.77:
        fadd dword [byte esp+054h]
.78:
        fstp dword [dword esp+0ECh]
        lea edi, [byte esp+0Ch]
        lea esi, [byte esp+08h]
        lea eax, [dword esp+0ECh]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte esp+050h]
        fld st0
        fmul dword [byte esp+08h]
        fadd dword [dword esp+0130h]
        fst dword [dword esp+0130h]
        fabs
        fxch
        fmul dword [byte esp+0Ch]
        fadd dword [dword esp+0134h]
        fstp dword [dword esp+0134h]
        fcomp qword [F64_1896]
        fnstsw ax
        sahf
        jbe short .81
        fldz
        fcomp dword [dword esp+0130h]
        fnstsw ax
        sahf
        jae short .79
        mov dword [byte esp+034h], 768h
        jmp short .80
.79:
        mov dword [byte esp+034h], 0FFFFF898h
.80:
        fild dword [byte esp+034h]
        fstp dword [dword esp+0130h]
.81:
        fld dword [dword esp+0134h]
        fabs
        fcomp qword [F64_4656]
        fnstsw ax
        sahf
        jbe short .84
        fldz
        fcomp dword [dword esp+0134h]
        fnstsw ax
        sahf
        jae short .82
        mov dword [byte esp+024h], 1230h
        jmp short .83
.82:
        mov dword [byte esp+024h], 0FFFFEDD0h
.83:
        fild dword [byte esp+024h]
        fstp dword [dword esp+0134h]
.84:
        mov eax, dword [dword esp+0130h]
        mov dword [byte edx+048h], eax
        mov eax, dword [dword esp+0134h]
        mov dword [byte edx+04Ch], eax
        mov eax, 1
.85:
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
; GoalieAngle                                     5FE2C  97 PC, low confidence
; Goalie AI: angle to the puck
;-----------------------------------------------------------------------------
GoalieAngle:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 4Ch
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov edx, dword [dword eax+0FAh]
        mov eax, dword [byte eax+020h]
        mov dword [byte esp+044h], eax
        mov eax, dword [byte ebx+028h]
        fld dword [byte esp+044h]
        mov dword [byte esp+048h], eax
        fabs
        fcomp qword [F64_1272]
        fnstsw ax
        sahf
        jbe near .5
        fld dword [byte esp+048h]
        fabs
        fcomp qword [F64_4032]
        fnstsw ax
        sahf
        jbe short .5
        fldz
        fcomp dword [byte esp+044h]
        fnstsw ax
        sahf
        jbe short .1
        mov dword [byte esp+04h], 0FFFFFB08h
        jmp short .2
.1:
        mov dword [byte esp+04h], 4F8h
.2:
        fild dword [byte esp+04h]
        fsubr dword [byte esp+044h]
        fldz
        fxch
        fstp dword [byte esp+044h]
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        jbe short .3
        mov dword [esp], 0FFFFF040h
        jmp short .4
.3:
        mov dword [esp], 0FC0h
.4:
        fild dword [esp]
        fsubr dword [byte esp+048h]
        fld dword [byte esp+044h]
        fxch
        fst dword [byte esp+048h]
        fxch
        call IF@ATAN2
        jmp near .11
.5:
        fld dword [byte esp+044h]
        fabs
        fcomp qword [F64_1272]
        fnstsw ax
        sahf
        ja short .8
        fldz
        fcomp dword [byte esp+048h]
        fnstsw ax
        sahf
        jae short .6
        xor edi, edi
        mov dword [byte esp+010h], edi
        mov dword [byte esp+014h], edi
        jmp short .7
.6:
        mov ecx, 5A7ED197h
        mov esi, 400921FBh
        mov dword [byte esp+010h], ecx
        mov dword [byte esp+014h], esi
.7:
        fld qword [byte esp+010h]
        jmp short .11
.8:
        fldz
        fcomp dword [byte esp+044h]
        fnstsw ax
        sahf
        jae short .9
        mov edi, 5A7ED197h
        mov eax, 3FF921FBh
        mov dword [byte esp+038h], edi
        mov dword [byte esp+03Ch], eax
        jmp short .10
.9:
        mov ecx, 83DF1D31h
        mov esi, 4012D97Ch
        mov dword [byte esp+038h], ecx
        mov dword [byte esp+03Ch], esi
.10:
        fld qword [byte esp+038h]
.11:
        fstp dword [byte esp+040h]
        fld dword [byte esp+040h]
        fsub dword [byte ebx+01Ch]
        fld qword [F64_6p28319_GoalieAngle]
        fxch
        call IF@DFMOD
        fst dword [byte esp+040h]
        fst qword [byte esp+030h]
        fcomp qword [F64_3p14159_GoalieAngle]
        fnstsw ax
        sahf
        jbe short .12
        fld qword [byte esp+030h]
        fadd qword [F64_neg6p28319_GoalieAngle]
        fstp dword [byte esp+040h]
.12:
        fld dword [byte esp+040h]
        fst qword [byte esp+028h]
        fcomp qword [F64_neg3p14159_GoalieAngle]
        fnstsw ax
        sahf
        jae short .13
        fld qword [byte esp+028h]
        fadd qword [F64_6p28319_GoalieAngle]
        fstp dword [byte esp+040h]
.13:
        fldz
        fcomp dword [byte edx+014h]
        fnstsw ax
        sahf
        setb al
        mov ecx, eax
        fldz
        and ecx, 0FFh
        fcomp dword [byte esp+040h]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor eax, ecx
        je near .17
        fld dword [byte edx+014h]
        fabs
        fld dword [byte esp+040h]
        fabs
        fcompp
        fnstsw ax
        sahf
        jae near .17
        fldz
        fcomp dword [byte edx+014h]
        fnstsw ax
        sahf
        jae short .14
        mov edi, 0CD31506Dh
        mov eax, 0C008FE3Ch
        mov dword [byte esp+020h], edi
        mov dword [byte esp+024h], eax
        jmp short .15
.14:
        mov ecx, 0CD31506Dh
        mov esi, 4008FE3Ch
        mov dword [byte esp+020h], ecx
        mov dword [byte esp+024h], esi
.15:
        fld qword [byte esp+020h]
        fst dword [byte edx+014h]
        fadd dword [byte ebx+01Ch]
        fld qword [F64_6p28319_GoalieAngle]
        fxch
        call IF@DFMOD
        fst dword [byte edx+010h]
        fst qword [byte esp+018h]
        fcomp qword [F64_3p14159_GoalieAngle]
        fnstsw ax
        sahf
        jbe short .16
        fld qword [byte esp+018h]
        fadd qword [F64_neg6p28319_GoalieAngle]
        fstp dword [byte edx+010h]
.16:
        fld dword [byte edx+010h]
        fst qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_GoalieAngle]
        fnstsw ax
        sahf
        jae short .17
        fld qword [byte esp+08h]
        fadd qword [F64_6p28319_GoalieAngle]
        fstp dword [byte edx+010h]
.17:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; GoalieCoverPost                                 60078  97 PC, low confidence
; Goalie AI: covers the post
;-----------------------------------------------------------------------------
GoalieCoverPost:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 3Ch
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
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
        mov esi, dword [byte eax+020h]
        mov ecx, dword [byte eax+01Ch]
        mov dword [byte esp+08h], esi
        mov esi, dword [byte eax+028h]
        mov edx, dword [dword ebx+0FAh]
        mov dword [byte esp+0Ch], esi
        test ecx, 7FFFFFFFh
        je short .3
        lea edi, [byte esp+04h]
        mov esi, esp
        add eax, byte 1Ch
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [esp]
        fmul dword [F32_neg88]
        fld dword [byte esp+04h]
        fmul dword [F32_neg88]
        fxch
        fadd dword [byte esp+08h]
        fxch
        fadd dword [byte esp+0Ch]
        fxch
        fstp dword [byte esp+08h]
        jmp short .4
.3:
        fld dword [byte esp+0Ch]
        fadd dword [F32_neg88]
.4:
        fstp dword [byte esp+0Ch]
        fld dword [byte esp+08h]
        fsub dword [byte ebx+020h]
        fld dword [byte esp+0Ch]
        fsub dword [byte ebx+028h]
        fxch
        call IF@ATAN2
        fsub dword [byte ebx+01Ch]
        fld qword [F64_6p28319_GoalieCoverPost]
        fxch
        call IF@DFMOD
        fst dword [byte esp+038h]
        fst qword [byte esp+018h]
        fcomp qword [F64_3p14159_GoalieCoverPost]
        fnstsw ax
        sahf
        jbe short .5
        fld qword [byte esp+018h]
        fadd qword [F64_neg6p28319_GoalieCoverPost]
        fstp dword [byte esp+038h]
.5:
        fld dword [byte esp+038h]
        fst qword [byte esp+030h]
        fcomp qword [F64_neg3p14159_GoalieCoverPost]
        fnstsw ax
        sahf
        jae short .6
        fld qword [byte esp+030h]
        fadd qword [F64_6p28319_GoalieCoverPost]
        fstp dword [byte esp+038h]
.6:
        fldz
        fcomp dword [byte edx+014h]
        fnstsw ax
        sahf
        setb al
        mov esi, eax
        fldz
        and esi, 0FFh
        fcomp dword [byte esp+038h]
        fnstsw ax
        sahf
        seta al
        and eax, 0FFh
        xor eax, esi
        je near .10
        fld dword [byte edx+014h]
        fabs
        fld dword [byte esp+038h]
        fabs
        fcompp
        fnstsw ax
        sahf
        jae near .10
        fldz
        fcomp dword [byte edx+014h]
        fnstsw ax
        sahf
        jae short .7
        mov eax, 0CD31506Dh
        mov ecx, 0C008FE3Ch
        mov dword [byte esp+028h], eax
        mov dword [byte esp+02Ch], ecx
        jmp short .8
.7:
        mov esi, 0CD31506Dh
        mov edi, 4008FE3Ch
        mov dword [byte esp+028h], esi
        mov dword [byte esp+02Ch], edi
.8:
        fld qword [byte esp+028h]
        fst dword [byte edx+014h]
        fadd dword [byte ebx+01Ch]
        fld qword [F64_6p28319_GoalieCoverPost]
        fxch
        call IF@DFMOD
        fst dword [byte edx+010h]
        fst qword [byte esp+020h]
        fcomp qword [F64_3p14159_GoalieCoverPost]
        fnstsw ax
        sahf
        jbe short .9
        fld qword [byte esp+020h]
        fadd qword [F64_neg6p28319_GoalieCoverPost]
        fstp dword [byte edx+010h]
.9:
        fld dword [byte edx+010h]
        fst qword [byte esp+010h]
        fcomp qword [F64_neg3p14159_GoalieCoverPost]
        fnstsw ax
        sahf
        jae short .10
        fld qword [byte esp+010h]
        fadd qword [F64_6p28319_GoalieCoverPost]
        fstp dword [byte edx+010h]
.10:
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
; GoalieAI                                        6023C  97 PC, low confidence
; Goalie AI for one frame
;-----------------------------------------------------------------------------
GoalieAI:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 88h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov ecx, dword [dword eax+0EEh]
        mov edx, dword [dword eax+0FAh]
        mov esi, dword [ecx]
        mov dword [byte eax+048h], esi
        mov esi, dword [byte ecx+04h]
        mov dword [byte eax+04Ch], esi
        test byte [byte ecx+029h], 1
        je near .17
        cmp word [dword ebx+0A9h], byte 0
        je near .17
        mov eax, dword [byte ecx+0Ch]
        mov dword [byte edx+010h], eax
        test dword [byte ecx+024h], 7FFFFFFFh
        jne short .1
        mov dword [byte edx+014h], 0
        mov dword [byte edx+02Ch], 0
        mov dword [byte edx+018h], 43700000h
        mov eax, dword [byte edx+02Ch]
        mov dword [byte edx+028h], eax
        jmp near .41
.1:
        mov eax, dword [byte ebx+040h]
        mov edi, dword [byte ebx+038h]
        mov dword [byte esp+07Ch], eax
        test edi, 7FFFFFFFh
        jne short .2
        mov eax, dword [byte ebx+01Ch]
        mov dword [byte esp+07Ch], eax
        test byte [byte ecx+031h], 8
        je short .2
        fld dword [byte esp+07Ch]
        fld st0
        fadd qword [F64_3p14159_GoalieAI]
        fstp st1
        fstp dword [byte esp+07Ch]
.2:
        test byte [byte ecx+031h], 8
        je short .3
        fld dword [byte edx+010h]
        fsub dword [byte esp+07Ch]
        jmp short .4
.3:
        fld dword [byte edx+010h]
        fsub dword [byte ebx+01Ch]
.4:
        fstp dword [byte edx+014h]
        fld qword [F64_6p28319_GoalieAI]
        fld dword [byte edx+014h]
        call IF@DFMOD
        fst dword [byte edx+014h]
        fst qword [byte esp+038h]
        fcomp qword [F64_3p14159_GoalieAI]
        fnstsw ax
        sahf
        jbe short .5
        fld qword [byte esp+038h]
        fadd qword [F64_neg6p28319_GoalieAI]
        fstp dword [byte edx+014h]
.5:
        fld dword [byte edx+014h]
        fst qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_GoalieAI]
        fnstsw ax
        sahf
        jae short .6
        fld qword [byte esp+08h]
        fadd qword [F64_6p28319_GoalieAI]
        fstp dword [byte edx+014h]
.6:
        mov ah, byte [byte edx+030h]
        test ah, 8
        je short .7
        mov eax, ebx
        call GoalieAngle
        jmp short .8
.7:
        test ah, 10h
        je short .8
        mov eax, ebx
        call GoalieCoverPost
.8:
        fld dword [byte edx+010h]
        fsub dword [byte ebx+040h]
        fld qword [F64_6p28319_GoalieAI]
        fxch
        call IF@DFMOD
        fst dword [byte edx+02Ch]
        fst qword [byte esp+020h]
        fcomp qword [F64_3p14159_GoalieAI]
        fnstsw ax
        sahf
        jbe short .9
        fld qword [byte esp+020h]
        fadd qword [F64_neg6p28319_GoalieAI]
        fstp dword [byte edx+02Ch]
.9:
        fld dword [byte edx+02Ch]
        fst qword [byte esp+070h]
        fcomp qword [F64_neg3p14159_GoalieAI]
        fnstsw ax
        sahf
        jae short .10
        fld qword [byte esp+070h]
        fadd qword [F64_6p28319_GoalieAI]
        fstp dword [byte edx+02Ch]
.10:
        test byte [byte ecx+031h], 8
        je short .11
        fld dword [byte edx+010h]
        fadd qword [F64_3p14159_GoalieAI]
        jmp short .12
.11:
        fld dword [byte edx+010h]
.12:
        fsub dword [byte ebx+01Ch]
        fstp dword [byte edx+028h]
        fld qword [F64_6p28319_GoalieAI]
        fld dword [byte edx+028h]
        call IF@DFMOD
        fst dword [byte edx+028h]
        fst qword [byte esp+030h]
        fcomp qword [F64_3p14159_GoalieAI]
        fnstsw ax
        sahf
        jbe short .13
        fld qword [byte esp+030h]
        fadd qword [F64_neg6p28319_GoalieAI]
        fstp dword [byte edx+028h]
.13:
        fld dword [byte edx+028h]
        fst qword [byte esp+050h]
        fcomp qword [F64_neg3p14159_GoalieAI]
        fnstsw ax
        sahf
        jae short .14
        fld qword [byte esp+050h]
        fadd qword [F64_6p28319_GoalieAI]
        fstp dword [byte edx+028h]
.14:
        cmp dword [byte ecx+024h], 43480000h
        je short .15
        test byte [byte edx+031h], 8
        je short .16
.15:
        mov dword [byte edx+018h], 44F00000h
        cmp dword [byte ecx+08h], 41400000h
        jge near .41
        mov dword [byte ecx+08h], 41500000h
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.16:
        mov dword [byte edx+018h], 44700000h
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.17:
        mov eax, ebx
        call GoalieReadShot
        fld dword [byte ecx+010h]
        fmul qword [F64_6p28319_GoalieAI]
        fmul qword [F64_1p52588eneg05]
        fld dword [byte ebx+04Ch]
        fld dword [byte ebx+048h]
        fsub dword [byte ebx+020h]
        fxch
        fsub dword [byte ebx+028h]
        fxch
        fstp dword [byte esp+078h]
        fstp dword [dword esp+080h]
        fstp dword [byte ebx+044h]
        fld dword [byte ecx+04h]
        fsub dword [byte ebx+028h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [ecx]
        fsub dword [byte ebx+020h]
        sub esp, byte 8
        fstp qword [esp]
        mov esi, eax
        call hypot_
        fstp dword [byte edx+018h]
        cmp dword [byte edx+018h], 42400000h
        jl short .18
        fld dword [byte edx+018h]
        fcomp dword [byte ecx+01Ch]
        fnstsw ax
        sahf
        jae short .19
.18:
        mov eax, dword [byte ebx+044h]
        mov dword [byte edx+010h], eax
        test byte [byte ecx+031h], 8
        je short .21
        fld dword [byte edx+010h]
        fld st0
        fadd qword [F64_3p14159_GoalieAI]
        fstp st1
        jmp short .20
.19:
        fld dword [dword esp+080h]
        fld dword [byte esp+078h]
        call IF@ATAN2
.20:
        fstp dword [byte edx+010h]
.21:
        fld qword [F64_6p28319_GoalieAI]
        fld dword [byte edx+010h]
        call IF@DFMOD
        fst dword [byte edx+010h]
        fst qword [byte esp+028h]
        fcomp qword [F64_3p14159_GoalieAI]
        fnstsw ax
        sahf
        jbe short .22
        fld qword [byte esp+028h]
        fadd qword [F64_neg6p28319_GoalieAI]
        fstp dword [byte edx+010h]
.22:
        fld dword [byte edx+010h]
        fst qword [byte esp+048h]
        fcomp qword [F64_neg3p14159_GoalieAI]
        fnstsw ax
        sahf
        jae short .23
        fld qword [byte esp+048h]
        fadd qword [F64_6p28319_GoalieAI]
        fstp dword [byte edx+010h]
.23:
        mov eax, dword [byte ebx+040h]
        mov dword [dword esp+084h], eax
        mov eax, dword [dword ebx+0F6h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+028h]
        mov edi, dword [byte ebx+038h]
        and eax, 0FFFFh
        test edi, 7FFFFFFFh
        je short .26
        cmp eax, byte 1Ch
        jl short .24
        cmp eax, byte 1Fh
        jle short .26
.24:
        cmp byte [dword ebx+0A4h], 0Ch
        jne short .25
        cmp eax, 11Fh
        jl short .25
        cmp eax, 126h
        jle short .26
.25:
        test byte [byte ecx+031h], 8
        je short .27
        test byte [byte ecx+028h], 80h
        jne short .27
.26:
        mov eax, dword [byte ebx+01Ch]
        mov dword [dword esp+084h], eax
        test byte [byte ecx+031h], 8
        je short .27
        fld dword [dword esp+084h]
        fld st0
        fadd qword [F64_3p14159_GoalieAI]
        fstp st1
        fstp dword [dword esp+084h]
.27:
        test byte [byte ecx+031h], 8
        je short .28
        fld dword [byte edx+010h]
        fsub dword [dword esp+084h]
        jmp short .29
.28:
        fld dword [byte edx+010h]
        fsub dword [byte ebx+01Ch]
.29:
        fstp dword [byte edx+014h]
        fld qword [F64_6p28319_GoalieAI]
        fld dword [byte edx+014h]
        call IF@DFMOD
        fst dword [byte edx+014h]
        fst qword [byte esp+018h]
        fcomp qword [F64_3p14159_GoalieAI]
        fnstsw ax
        sahf
        jbe short .30
        fld qword [byte esp+018h]
        fadd qword [F64_neg6p28319_GoalieAI]
        fstp dword [byte edx+014h]
.30:
        fld dword [byte edx+014h]
        fst qword [byte esp+068h]
        fcomp qword [F64_neg3p14159_GoalieAI]
        fnstsw ax
        sahf
        jae short .31
        fld qword [byte esp+068h]
        fadd qword [F64_6p28319_GoalieAI]
        fstp dword [byte edx+014h]
.31:
        test byte [byte edx+030h], 8
        je short .32
        mov eax, ebx
        call GoalieAngle
.32:
        test esi, esi
        jne short .33
        fldz
        fcomp dword [byte ecx+08h]
        fnstsw ax
        sahf
        jae short .34
.33:
        cmp dword [byte edx+018h], 44700000h
        jge short .34
        fld dword [byte ecx+0Ch]
        jmp short .35
.34:
        fld dword [byte edx+010h]
.35:
        fsub dword [dword esp+084h]
        fstp dword [byte edx+02Ch]
        fld qword [F64_6p28319_GoalieAI]
        fld dword [byte edx+02Ch]
        call IF@DFMOD
        fst dword [byte edx+02Ch]
        fst qword [byte esp+040h]
        fcomp qword [F64_3p14159_GoalieAI]
        fnstsw ax
        sahf
        jbe short .36
        fld qword [byte esp+040h]
        fadd qword [F64_neg6p28319_GoalieAI]
        fstp dword [byte edx+02Ch]
.36:
        fld dword [byte edx+02Ch]
        fst qword [byte esp+058h]
        fcomp qword [F64_neg3p14159_GoalieAI]
        fnstsw ax
        sahf
        jae short .37
        fld qword [byte esp+058h]
        fadd qword [F64_6p28319_GoalieAI]
        fstp dword [byte edx+02Ch]
.37:
        test byte [byte ecx+031h], 8
        je short .38
        fld dword [byte edx+010h]
        fadd qword [F64_3p14159_GoalieAI]
        jmp short .39
.38:
        fld dword [byte edx+010h]
.39:
        fsub dword [byte ebx+01Ch]
        fstp dword [byte edx+028h]
        fld qword [F64_6p28319_GoalieAI]
        fld dword [byte edx+028h]
        call IF@DFMOD
        fst dword [byte edx+028h]
        fst qword [byte esp+010h]
        fcomp qword [F64_3p14159_GoalieAI]
        fnstsw ax
        sahf
        jbe short .40
        fld qword [byte esp+010h]
        fadd qword [F64_neg6p28319_GoalieAI]
        fstp dword [byte edx+028h]
.40:
        fld dword [byte edx+028h]
        fst qword [byte esp+060h]
        fcomp qword [F64_neg3p14159_GoalieAI]
        fnstsw ax
        sahf
        jae short .41
        fld qword [byte esp+060h]
        fadd qword [F64_6p28319_GoalieAI]
        fstp dword [byte edx+028h]
.41:
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
; TurnRateForSpeed                                60710  97 PC, low confidence
; Returns the turn rate allowed at the player's speed
;-----------------------------------------------------------------------------
TurnRateForSpeed:
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov edx, dword [dword eax+0EEh]
        mov eax, dword [byte eax+038h]
        mov dword [byte esp+08h], eax
        fld dword [byte esp+08h]
        fsub dword [byte edx+08h]
        fdiv dword [F32_3p95]
        fldz
        fxch
        fstp dword [byte esp+0Ch]
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jbe short .1
        xor edx, edx
        mov dword [byte esp+010h], edx
        jmp short .2
.1:
        fld dword [byte esp+0Ch]
        fld st0
        fld st0
        fmul qword [F64_1p975]
        fxch
        fadd qword [F64_neg1]
        fmulp
        fld dword [byte esp+08h]
        fmulp st2
        faddp
        fstp dword [byte esp+010h]
.2:
        fld dword [byte esp+010h]
        mov esp, ebp
        pop ebp
        pop edx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; UpdateGoalie                                    6077C  97 PC, low confidence
; Moves and animates the goalie
;-----------------------------------------------------------------------------
UpdateGoalie:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 28h
        and esp, byte 0FFFFFFF8h
        mov ebx, eax
        mov ecx, dword [dword eax+0EEh]
        mov edx, dword [dword eax+0FAh]
        mov eax, dword [dword eax+0F6h]
        mov eax, dword [eax]
        mov esi, dword [byte eax+028h]
        mov edi, dword [byte edx+024h]
        and esi, 0FFFFh
        test edi, edi
        jle short .1
        lea eax, [byte edi-01h]
        mov dword [byte edx+024h], eax
.1:
        fldz
        fcomp dword [edx]
        fnstsw ax
        sahf
        jae short .2
        fld dword [edx]
        fadd dword [F32_neg1_UpdateGoalie]
        fldz
        fxch
        fstp dword [edx]
        fcomp dword [edx]
        fnstsw ax
        sahf
        jbe short .2
        mov dword [edx], 0
.2:
        mov eax, dword [dword ebx+0AEh]
        sar eax, 18h
        cmp byte [dword ebx+eax+0B2h], 0Eh
        jne short .3
        test byte [byte ecx+029h], 1
        jne short .3
        mov dword [byte edx+01Ch], 0
        fld dword [byte ebx+038h]
        fld st0
        fadd qword [F64_0p2_UpdateGoalie]
        fstp st1
        fstp dword [byte ebx+038h]
        jmp near .31
.3:
        mov eax, ebx
        call GoalieAI
        test byte [dword ebx+0C0h], 1
        jne near .31
        mov dword [byte edx+01Ch], 1
        test byte [byte ecx+028h], 80h
        je near .9
        test byte [byte ecx+031h], 8
        jne near .16
        cmp dword [byte ebx+038h], 41400000h
        jge short .7
        test byte [dword ebx+0BFh], 20h
        jne short .6
        cmp esi, byte 25h
        jl short .5
        cmp esi, 107h
        jl short .4
        cmp esi, 149h
        jl short .5
.4:
        cmp esi, byte 32h
        jl short .6
        cmp esi, byte 3Dh
        jg short .6
.5:
        fld dword [byte edx+014h]
        fabs
        fcomp qword [F64_0p785398_UpdateGoalie]
        fnstsw ax
        sahf
        jbe short .6
        mov dword [byte ebx+038h], 0
        or byte [byte ecx+031h], 8
        mov eax, ebx
        call GoalieAI
        mov eax, ebx
        call PickSkateAnim
.6:
        mov dword [byte edx+01Ch], 2
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        fld dword [byte edx+028h]
        fabs
        fcomp qword [F64_0p785398_UpdateGoalie]
        fnstsw ax
        sahf
        jae short .8
        fld dword [byte edx+02Ch]
        fabs
        fcomp qword [F64_0p785398_UpdateGoalie]
        fnstsw ax
        sahf
        jae short .8
        fld dword [byte edx+014h]
        fabs
        fcomp qword [F64_0p785398_UpdateGoalie]
        fnstsw ax
        sahf
        jae short .8
        mov dword [byte edx+01Ch], 7
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        cmp dword [byte edx+018h], 44700000h
        jle near .26
        fld dword [byte edx+028h]
        fabs
        fcomp qword [F64_2p35619_UpdateGoalie]
        fnstsw ax
        sahf
        jae near .26
        fld dword [byte edx+02Ch]
        fabs
        fcomp qword [F64_2p35619_UpdateGoalie]
        fnstsw ax
        sahf
        jae near .26
        fld dword [byte edx+014h]
        fabs
        fcomp qword [F64_2p35619_UpdateGoalie]
        fnstsw ax
        sahf
        jae near .26
        mov dword [byte edx+01Ch], 3
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        test byte [byte ecx+031h], 8
        je near .16
        cmp dword [byte ebx+038h], 41400000h
        jge short .13
        test byte [dword ebx+0BFh], 20h
        jne short .12
        cmp esi, byte 25h
        jl short .11
        cmp esi, 107h
        jl short .10
        cmp esi, 149h
        jl short .11
.10:
        cmp esi, byte 32h
        jl short .12
        cmp esi, byte 3Dh
        jg short .12
.11:
        mov dword [byte ebx+038h], 0
        and byte [byte ecx+031h], 0F7h
        mov eax, ebx
        call GoalieAI
        mov eax, ebx
        call PickSkateAnim
.12:
        mov dword [byte edx+01Ch], 2
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.13:
        fld dword [byte edx+028h]
        fabs
        fcomp qword [F64_0p785398_UpdateGoalie]
        fnstsw ax
        sahf
        jae short .14
        fld dword [byte edx+02Ch]
        fabs
        fcomp qword [F64_0p785398_UpdateGoalie]
        fnstsw ax
        sahf
        jae short .14
        fld dword [byte edx+014h]
        fabs
        fcomp qword [F64_0p785398_UpdateGoalie]
        fnstsw ax
        sahf
        jae short .14
        mov dword [byte edx+01Ch], 8
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.14:
        cmp dword [byte edx+018h], 44700000h
        jle near .26
        fld dword [byte edx+028h]
        fabs
        fcomp qword [F64_2p35619_UpdateGoalie]
        fnstsw ax
        sahf
        jae near .26
        fld dword [byte edx+02Ch]
        fabs
        fcomp qword [F64_2p35619_UpdateGoalie]
        fnstsw ax
        sahf
        jae near .26
        fld dword [byte edx+014h]
        fabs
        fcomp qword [F64_2p35619_UpdateGoalie]
        fnstsw ax
        sahf
        jae near .26
.15:
        mov dword [byte edx+01Ch], 3
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.16:
        mov eax, dword [byte edx+014h]
        mov dword [byte esp+024h], eax
        test byte [byte ecx+029h], 1
        je near .19
        cmp word [dword ebx+0A9h], byte 0
        je near .19
        test dword [byte ecx+024h], 7FFFFFFFh
        je near .31
        fld dword [byte esp+024h]
        fabs
        fst qword [byte esp+01Ch]
        fcomp qword [F64_2p35619_UpdateGoalie]
        fnstsw ax
        sahf
        jbe short .17
        fld qword [byte esp+01Ch]
        fcomp qword [F64_2p82743]
        fnstsw ax
        sahf
        jbe short .15
        test byte [byte ecx+031h], 8
        jne short .15
        cmp dword [byte ebx+038h], 41400000h
        jle short .15
        mov dword [byte edx+01Ch], 4
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.17:
        fld qword [byte esp+01Ch]
        fcomp qword [F64_0p392699_UpdateGoalie]
        fnstsw ax
        sahf
        jb near .12
        test byte [byte edx+031h], 8
        jne near .12
.18:
        mov dword [byte edx+01Ch], 3
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.19:
        fld dword [byte esp+024h]
        fabs
        fst qword [byte esp+014h]
        fcomp qword [F64_2p35619_UpdateGoalie]
        fnstsw ax
        sahf
        jbe near .22
        cmp dword [byte edx+018h], 43C00000h
        jle short .20
        cmp dword [byte ebx+038h], 41400000h
        jle short .20
        fld qword [byte esp+014h]
        fcomp qword [F64_2p82743]
        fnstsw ax
        sahf
        jbe short .18
        test byte [byte ecx+031h], 8
        jne short .18
        mov dword [byte edx+01Ch], 4
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.20:
        mov ecx, dword [byte edx+018h]
        cmp ecx, 43C00000h
        jle short .18
        cmp dword [byte ebx+038h], 41400000h
        jge short .18
        cmp ecx, 44700000h
        jg short .21
        mov ecx, dword [dword ebx+0EEh]
        cmp dword [byte ecx+08h], 41400000h
        jle near .18
        fld dword [byte ecx+08h]
        fsub dword [byte ebx+038h]
        fcomp dword [F32_12]
        fnstsw ax
        sahf
        jbe near .18
.21:
        mov dword [byte edx+01Ch], 2
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.22:
        fld qword [byte esp+014h]
        fcomp qword [F64_0p785398_UpdateGoalie]
        fnstsw ax
        sahf
        jbe short .24
        mov esi, dword [byte edx+018h]
        cmp esi, 43C00000h
        jle near .18
        cmp dword [byte ebx+038h], 41400000h
        jge near .18
        cmp esi, 44700000h
        jg short .23
        mov ecx, dword [dword ebx+0EEh]
        cmp dword [byte ecx+08h], 41400000h
        jle near .18
        fld dword [byte ecx+08h]
        fsub dword [byte ebx+038h]
        fcomp dword [F32_12]
        fnstsw ax
        sahf
        jbe near .18
.23:
        mov dword [byte edx+01Ch], 2
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.24:
        mov ecx, dword [dword ebx+0EEh]
        fld dword [byte ecx+08h]
        fsub dword [byte ebx+038h]
        mov esi, dword [byte ecx+08h]
        fstp dword [byte esp+0Ch]
        cmp esi, 41400000h
        jle short .25
        fldz
        fcomp dword [byte esp+0Ch]
        fnstsw ax
        sahf
        jbe short .25
        fld dword [byte esp+0Ch]
        fcomp dword [F32_neg12]
        fnstsw ax
        sahf
        jbe short .25
        cmp dword [byte edx+018h], 44700000h
        jge short .25
        mov dword [byte edx+01Ch], 5
.25:
        mov eax, dword [byte ebx+038h]
        mov dword [byte esp+08h], eax
        mov eax, ebx
        call StickHandleTarget
        push eax
        push dword [byte esp+0Ch]
        mov ecx, eax
        call StickHandleSpeed
        mov esi, ecx
        shl ecx, 3
        fstp dword [byte esp+010h]
        sub ecx, esi
        fld dword [byte esp+010h]
        fmul dword [nosplit ecx*8+SkateStrideTable]
        mov eax, dword [byte edx+018h]
        fstp dword [byte esp+010h]
        cmp eax, 43C00000h
        jle short .27
        fld dword [byte edx+018h]
        fcomp dword [byte esp+010h]
        fnstsw ax
        sahf
        ja short .27
        mov ecx, dword [dword ebx+0EEh]
        cmp dword [byte ecx+08h], 41400000h
        jge short .27
        fld dword [byte esp+0Ch]
        fcomp dword [F32_neg12]
        fnstsw ax
        sahf
        ja short .27
.26:
        mov dword [byte edx+01Ch], 4
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.27:
        mov edi, dword [byte edx+018h]
        cmp edi, 43C00000h
        jle short .28
        mov dword [byte edx+01Ch], 2
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.28:
        cmp edi, 42400000h
        jle short .30
        mov ecx, dword [dword ebx+0EEh]
        fld dword [byte edx+018h]
        fcomp dword [byte ecx+01Ch]
        fnstsw ax
        sahf
        jbe short .30
        test dword [byte ebx+038h], 7FFFFFFFh
        je short .29
        fld dword [byte edx+018h]
        fdiv dword [byte ebx+038h]
        fcomp dword [F32_30_UpdateGoalie]
        fnstsw ax
        sahf
        jbe short .30
.29:
        mov dword [byte edx+01Ch], 2
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.30:
        mov ecx, dword [dword ebx+0EEh]
        fld dword [byte ecx+08h]
        fcomp dword [byte ebx+038h]
        fnstsw ax
        sahf
        jae short .31
        mov dword [byte edx+01Ch], 5
.31:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
%if VERSION = 11
;-----------------------------------------------------------------------------
; GoalieTick                                      612E8  97 PC, low confidence
; Runs the goalie and animation clock for one frame
;-----------------------------------------------------------------------------
GoalieTick:
        push edx
        mov edx, eax
        call UpdateGoalie
        mov eax, dword [dword edx+0F6h]
        call AnimClockTick
        pop edx
        ret
%else
;-----------------------------------------------------------------------------
; GoalieTick                                      60D28  97 PC, low confidence
; Runs the goalie and animation clock for one frame
;-----------------------------------------------------------------------------
GoalieTick:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        rdtsc
        mov ecx, eax
        mov eax, ebx
        mov esi, dword [GoalieTickData]
        call UpdateGoalie
        mov eax, dword [dword ebx+0F6h]
        call AnimClockTick
        rdtsc
        sub eax, ecx
        mov edx, dword [GoalieTickData]
        add eax, esi
        mov ebx, dword [GoalieTickCount]
        sub eax, edx
        add ebx, eax
        mov dword [GoalieTickCount], ebx
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
%endif
