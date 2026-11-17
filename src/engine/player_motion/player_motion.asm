; Player motion: depth sort, animation poses and facing.
bits 32
%include "hockey.inc"
section s_6FF1B progbits alloc exec nowrite align=1
extern BodyPointId, DepthSortCount, DepthSortKeys, DepthSortList, DepthSortOrder, F64_0p00436332, F64_0p785398_FaceAngleDelta, F64_0p785398_FacePlayerToward
extern F64_3p14159_FaceAngleDelta, F64_3p14159_FacePlayerToward, F64_3p14159_MoveToAnimPose, F64_3p14159_UpdatePlayerMotion, F64_6p28319_FaceAngleDelta, F64_6p28319_FacePlayerToward, F64_6p28319_MoveToAnimPose, F64_6p28319_UpdatePlayerMotion
extern F64_neg0p00436332, F64_neg0p2_UpdatePlayerMotion, F64_neg3p14159_FaceAngleDelta, F64_neg3p14159_FacePlayerToward, F64_neg3p14159_MoveToAnimPose, F64_neg3p14159_UpdatePlayerMotion, F64_neg6p28319_FaceAngleDelta, F64_neg6p28319_FacePlayerToward
extern F64_neg6p28319_MoveToAnimPose, F64_neg6p28319_UpdatePlayerMotion, IF@ATAN2, IF@DFMOD, MovePlayer, ObjectSortCount, PtrPuckFlags, SortCords
extern SortIndices, UpdateObjectPose
global UpdatePlayerMotion, SortPlayersByDepth, SortPlayersByDepthJumpTable, MoveToAnimPose, FaceAngleDelta, FacePlayerToward
        db 090h
;-----------------------------------------------------------------------------
; UpdatePlayerMotion                              6FF1C  97 PC, low confidence
; Moves the players and updates their motion
;-----------------------------------------------------------------------------
UpdatePlayerMotion:
        push ebx
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 18h
        and esp, byte 0FFFFFFF8h
        mov edx, eax
        mov ebx, dword [dword eax+0FAh]
        test dword [byte ebx+0Ch], 7FFFFFFFh
        jne short .1
        test dword [byte eax+038h], 7FFFFFFFh
        je near .7
.1:
        fldz
        fcomp dword [byte edx+038h]
        fnstsw ax
        sahf
        jae short .2
        mov eax, edx
        call MovePlayer
        fld dword [byte edx+038h]
        fadd qword [F64_neg0p2_UpdatePlayerMotion]
        fldz
        fxch
        fstp dword [byte edx+038h]
        fcomp dword [byte edx+038h]
        fnstsw ax
        sahf
        jbe short .2
        mov dword [byte edx+038h], 0
.2:
        test dword [byte ebx+0Ch], 7FFFFFFFh
        je near .7
        fld dword [byte ebx+0Ch]
        fadd dword [byte edx+01Ch]
        fldz
        fxch
        fstp dword [byte edx+01Ch]
        fcomp dword [byte ebx+0Ch]
        fnstsw ax
        sahf
        jae short .3
        fld dword [byte ebx+0Ch]
        fadd qword [F64_neg0p00436332]
        fldz
        fxch
        fstp dword [byte ebx+0Ch]
        fcomp dword [byte ebx+0Ch]
        fnstsw ax
        sahf
        jbe short .5
        jmp short .4
.3:
        jbe short .5
        fld dword [byte ebx+0Ch]
        fld st0
        fadd qword [F64_0p00436332]
        fldz
        fxch
        fstp st2
        fxch
        fstp dword [byte ebx+0Ch]
        fcomp dword [byte ebx+0Ch]
        fnstsw ax
        sahf
        jae short .5
.4:
        mov dword [byte ebx+0Ch], 0
.5:
        fld qword [F64_6p28319_UpdatePlayerMotion]
        fld dword [byte edx+01Ch]
        call IF@DFMOD
        fst dword [byte edx+01Ch]
        fst qword [byte esp+08h]
        fcomp qword [F64_3p14159_UpdatePlayerMotion]
        fnstsw ax
        sahf
        jbe short .6
        fld qword [byte esp+08h]
        fadd qword [F64_neg6p28319_UpdatePlayerMotion]
        fstp dword [byte edx+01Ch]
.6:
        fld dword [byte edx+01Ch]
        fst qword [byte esp+010h]
        fcomp qword [F64_neg3p14159_UpdatePlayerMotion]
        fnstsw ax
        sahf
        jae short .7
        fld qword [byte esp+010h]
        fadd qword [F64_6p28319_UpdatePlayerMotion]
        fstp dword [byte edx+01Ch]
.7:
        mov esp, ebp
        pop ebp
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SortPlayersByDepth                              7002C  97 PC, low confidence
; Sorts the players by depth for drawing
;-----------------------------------------------------------------------------
SortPlayersByDepth:
        push ebx
        push ecx
        push edx
        mov ecx, SortCords
        xor edx, edx
        xor ebx, ebx
.1:
        fld dword [byte ecx+028h]
        add ebx, byte 4
        push eax
        fistp dword [esp]
        pop eax
        add ecx, 108h
        mov dword [dword ebx+ObjectSortCount], edx
        inc edx
        mov dword [dword ebx+DepthSortCount], eax
        cmp edx, byte 0Dh
        jl short .1
        push DepthSortOrder
        push DepthSortKeys
        push byte 0Dh
        xor ebx, ebx
        call SortIndices
        add esp, byte 0Ch
        xor edx, edx
.2:
        mov eax, dword [dword ebx+DepthSortOrder]
        mov dword [nosplit eax*4+DepthSortList], edx
        inc edx
        add ebx, byte 4
        cmp edx, byte 0Dh
        jl short .2
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h
        cmp dword [byte eax+056h], byte 0
        setle al
        and eax, 0FFh
        ret
        db 08Dh,040h,00h
SortPlayersByDepthJumpTable:                    ; jump table for the switch cases
        dd .1
        dd .2
        dd .2
        dd .3
        dd .4
        lea eax, [byte ebx-01h]
        cmp eax, byte 4
        ja short .5
        jmp dword [nosplit cs:eax*4+SortPlayersByDepthJumpTable]
.1:
        dec dword [byte edx+056h]
        ret
.2:
        sub dword [byte edx+056h], byte 2
        ret
.3:
        sub dword [byte edx+056h], byte 3
        ret
.4:
        sub dword [byte edx+056h], byte 4
.5:
        ret
        db 090h
;-----------------------------------------------------------------------------
; MoveToAnimPose                                  700D8  97 PC, low confidence
; Moves the player to the pose of its animation
;-----------------------------------------------------------------------------
MoveToAnimPose:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 28h
        and esp, byte 0FFFFFFF8h
        mov edi, eax
        xor ebx, ebx
        mov bl, byte [byte eax+06Ch]
        mov esi, ebx
        shl esi, 5
        add esi, ebx
        mov edx, SortCords
        shl esi, 3
        add edx, esi
        fld dword [byte edx+020h]
        fsub dword [byte eax+020h]
        fld dword [byte edx+028h]
        fsub dword [byte eax+028h]
        mov esi, dword [dword eax+0FAh]
        fxch
        call IF@ATAN2
        mov ah, byte [byte esi+030h]
        fstp dword [byte esp+024h]
        test ah, 2
        jne short .1
        test ah, 4
        je short .2
.1:
        mov ecx, esp
        mov edx, dword [dword edi+0F2h]
        mov eax, dword [dword edi+0F6h]
        mov ebx, dword [BodyPointId]
        mov edx, dword [byte edx+054h]
        mov eax, dword [eax]
        call UpdateObjectPose
        fld dword [byte esp+08h]
        fld dword [esp]
        call IF@ATAN2
        fsubr dword [byte esp+024h]
        fstp dword [byte esp+024h]
.2:
        fld dword [byte edi+01Ch]
        fsubr dword [byte esp+024h]
        fld qword [F64_6p28319_MoveToAnimPose]
        fxch
        call IF@DFMOD
        fst dword [byte esi+014h]
        fst qword [byte esp+014h]
        fcomp qword [F64_3p14159_MoveToAnimPose]
        fnstsw ax
        sahf
        jbe short .3
        fld qword [byte esp+014h]
        fadd qword [F64_neg6p28319_MoveToAnimPose]
        fstp dword [byte esi+014h]
.3:
        fld dword [byte esi+014h]
        fst qword [byte esp+01Ch]
        fcomp qword [F64_neg3p14159_MoveToAnimPose]
        fnstsw ax
        sahf
        jae short .4
        fld qword [byte esp+01Ch]
        fadd qword [F64_6p28319_MoveToAnimPose]
        fstp dword [byte esi+014h]
.4:
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
; FaceAngleDelta                                  701B8  97 PC, low confidence
; Works out the turn to face a direction
;-----------------------------------------------------------------------------
FaceAngleDelta:
        push ebx
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov ebx, dword [dword eax+0EEh]
        test dword [byte ebx+024h], 7FFFFFFFh
        je near .4
        fld dword [byte ebx+0Ch]
        fsub dword [byte eax+01Ch]
        fld qword [F64_6p28319_FaceAngleDelta]
        fxch
        call IF@DFMOD
        fst dword [byte esp+010h]
        fst qword [byte esp+08h]
        fcomp qword [F64_3p14159_FaceAngleDelta]
        fnstsw ax
        sahf
        jbe short .1
        fld qword [byte esp+08h]
        fadd qword [F64_neg6p28319_FaceAngleDelta]
        fstp dword [byte esp+010h]
.1:
        fld dword [byte esp+010h]
        fst qword [esp]
        fcomp qword [F64_neg3p14159_FaceAngleDelta]
        fnstsw ax
        sahf
        jae short .2
        fld qword [esp]
        fadd qword [F64_6p28319_FaceAngleDelta]
        fstp dword [byte esp+010h]
.2:
        fld dword [byte esp+010h]
        fabs
        fcomp qword [F64_0p785398_FaceAngleDelta]
        fnstsw ax
        sahf
        jae short .3
        mov dword [byte edx+08h], 40A00000h
        mov dword [edx], 0
        mov esp, ebp
        pop ebp
        pop ebx
        ret
.3:
        mov dword [byte edx+08h], 40A00000h
        mov dword [edx], 40490FDBh
.4:
        mov esp, ebp
        pop ebp
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FacePlayerToward                                70260  97 PC, low confidence
; Turns a player toward a point
;-----------------------------------------------------------------------------
FacePlayerToward:
        push ebx
        push edx
        push ebp
        mov ebp, esp
        sub esp, byte 14h
        and esp, byte 0FFFFFFF8h
        mov bl, byte [dword eax+0C0h]
        mov edx, dword [dword eax+0EEh]
        test bl, 1
        je short .1
        mov ebx, dword [PtrPuckFlags]
        test byte [dword ebx+0C0h], 1
        jne short .2
.1:
        mov eax, 1
        jmp near .7
.2:
        test dword [byte edx+024h], 7FFFFFFFh
        jne short .3
        mov eax, 158h
        mov esp, ebp
        pop ebp
        pop edx
        pop ebx
        ret
.3:
        fld dword [byte edx+0Ch]
        fsub dword [byte eax+01Ch]
        fld qword [F64_6p28319_FacePlayerToward]
        fxch
        call IF@DFMOD
        fst dword [byte esp+010h]
        fst qword [esp]
        fcomp qword [F64_3p14159_FacePlayerToward]
        fnstsw ax
        sahf
        jbe short .4
        fld qword [esp]
        fadd qword [F64_neg6p28319_FacePlayerToward]
        fstp dword [byte esp+010h]
.4:
        fld dword [byte esp+010h]
        fst qword [byte esp+08h]
        fcomp qword [F64_neg3p14159_FacePlayerToward]
        fnstsw ax
        sahf
        jae short .5
        fld qword [byte esp+08h]
        fadd qword [F64_6p28319_FacePlayerToward]
        fstp dword [byte esp+010h]
.5:
        fld dword [byte esp+010h]
        fabs
        fcomp qword [F64_0p785398_FacePlayerToward]
        fnstsw ax
        sahf
        jae short .6
        mov eax, 169h
        mov esp, ebp
        pop ebp
        pop edx
        pop ebx
        ret
.6:
        mov eax, 16Ah
.7:
        mov esp, ebp
        pop ebp
        pop edx
        pop ebx
        ret
