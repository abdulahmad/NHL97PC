; The scoreboard and the net art.
bits 32
%include "hockey.inc"
section s_51405 progbits alloc exec nowrite align=1
extern __CHP, AddModelName, AddVec3, AngleOfVector, ArenaArchive, BenchSideIndex, BindModelShapes, CameraFlashOn
extern CreateModelInstance, DrawModel, DrawModelSorted, DrawRinkObjectPolys, F64_0p00138889, F64_0p31831_UpdateScoreboardSpin, F64_0p5_UpdateScoreboardSpin, F64_65536_DrawScoreboard
extern F64_65536_UpdateScoreboardSpin, FindModelGroupByName, FindModelName, FreeMemBlock, FreeModelFile, FreeModelInstance, GetModelGroupEntry, GetModelMatrixEntry
extern GetModelPartEntry, InitModelParts, IntsToFloats, LoadModelByName, NetArt, NetArtBack, NetArtDefs, NetArtFront
extern NetDistance, NetFrameData, NetFrames, OpenArtArchive, OpenResourceArchive, ProjectRinkObjectPoints, RemapBankToRange, RotateModelPoint
extern ScoreboardAngle, ScoreboardArt, ScoreboardAway, ScoreboardBounds, ScoreboardBuffer, ScoreboardClock, ScoreboardCorners, ScoreboardDigits
extern ScoreboardFrame, ScoreboardFrameNo, ScoreboardFrames, ScoreboardHeight, ScoreboardHome, ScoreboardLoaded, ScoreboardLogo, ScoreboardOn
extern ScoreboardPeriod, ScoreboardPitch, ScoreboardPos, ScoreboardScore, ScoreboardSize, ScoreboardSpin, ScoreboardText, ScoreboardTick
extern ScoreboardTime, ScoreboardZeroVector, ServiceIdle, SetArtArchive, SetModelMatrix, SetModelPosition, str_ArenaViv2, str_Netback
extern str_Netfrnt, str_Zamboni, str_Zambpath, str_Zamtrack, TransformVecFull, UpdateModelInstance, vecdist
global ScoreboardTransform, LoadScoreboardArt, DrawScoreboard, NetFrameDistance, SetupNetArt, SetupNetArt_58, ResetNetArt, ResetNetArt_50
global UpdateScoreboardPos, UpdateScoreboardSpin, LoadNetArt
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ScoreboardTransform                             51408  97 PC, low confidence
; Sets up the scoreboard transform
;-----------------------------------------------------------------------------
ScoreboardTransform:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        push eax
        call DrawRinkObjectPolys
        add esp, byte 4
        push ebx
        mov esi, eax
        call ProjectRinkObjectPoints
        add esp, byte 4
        push ebx
        call DrawModelSorted
        add esp, byte 4
        mov eax, esi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LoadScoreboardArt                               51434  97 PC, low confidence
; Loads the scoreboard art
;-----------------------------------------------------------------------------
LoadScoreboardArt:
        push ecx
        push edx
        push eax
        call DrawModel
        add esp, byte 4
        pop edx
        pop ecx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp dword [ScoreboardOn], byte 0
        jne near .1
        mov eax, str_ArenaViv2
        mov edx, 20h
        call SetArtArchive
        call ServiceIdle
        mov eax, str_Zamboni
        call LoadModelByName
        mov dword [ScoreboardLogo], eax
        call ServiceIdle
        mov eax, dword [ScoreboardLogo]
        push byte 0
        add eax, byte 2Ch
        push eax
        call OpenArtArchive
        add esp, byte 8
        xor ebx, ebx
        mov dword [ScoreboardArt], eax
        call ServiceIdle
        mov edx, dword [ScoreboardArt]
        mov eax, dword [ArenaArchive]
        call RemapBankToRange
        mov ebx, 8
        mov edx, 20h
        mov eax, dword [ScoreboardLogo]
        call CreateModelInstance
        push eax
        mov dword [ScoreboardDigits], eax
        call UpdateModelInstance
        add esp, byte 4
        mov ebx, dword [ScoreboardArt]
        push ebx
        mov ecx, dword [ScoreboardDigits]
        push ecx
        call BindModelShapes
        mov eax, dword [ScoreboardDigits]
        or byte [byte eax+010h], 2
        add esp, byte 8
        mov esi, dword [ScoreboardDigits]
        push esi
        mov ebx, ScoreboardTransform
        mov ecx, LoadScoreboardArt
        push byte 4
        mov eax, str_Zamboni
        xor edx, edx
        call AddModelName
        mov edx, 20h
        mov dword [ScoreboardLoaded], eax
        mov eax, str_Zamtrack
        xor edi, edi
        call LoadModelByName
        mov dword [ScoreboardClock], eax
        mov dword [ScoreboardBuffer], edi
        push str_Zambpath
        mov edx, dword [byte eax+024h]
        push eax
        mov dword [ScoreboardAway], edx
        call FindModelGroupByName
        add esp, byte 8
        push ScoreboardHome
        push ScoreboardAway
        push eax
        mov ebp, dword [ScoreboardClock]
        push ebp
        call GetModelGroupEntry
        mov edx, dword [ScoreboardBuffer]
        mov eax, dword [ScoreboardHome]
        add esp, byte 10h
        mov edx, dword [eax+edx*4]
        mov eax, dword [ScoreboardClock]
        call GetModelMatrixEntry
        mov edx, dword [byte eax+08h]
        mov ebx, eax
        mov eax, dword [ScoreboardClock]
        mov edx, dword [edx]
        mov edi, ScoreboardSize
        call GetModelPartEntry
        mov esi, eax
        movsd
        movsd
        movsd
        mov edx, dword [byte ebx+08h]
        mov eax, dword [ScoreboardClock]
        mov edx, dword [byte edx+04h]
        call GetModelPartEntry
        push ScoreboardSize
        mov esi, eax
        mov eax, dword [ScoreboardDigits]
        mov edi, ScoreboardBounds
        push eax
        movsd
        movsd
        movsd
        call SetModelPosition
        mov eax, dword [ScoreboardTime]
        mov edx, dword [ScoreboardFrame]
        add esp, byte 8
        sub eax, edx
        mov ebx, dword [ScoreboardBounds]
        push eax
        mov eax, dword [ScoreboardSize]
        sub eax, ebx
        push eax
        call AngleOfVector
        mov ecx, eax
        add esp, byte 8
        neg ecx
        push ecx
        mov dword [ScoreboardScore], eax
        push ScoreboardText
        mov dword [ScoreboardScore], ecx
        mov dword [ScoreboardPeriod], ecx
        call RotateModelPoint
        add esp, byte 8
        push ScoreboardText
        mov edi, dword [ScoreboardDigits]
        push edi
        mov ebx, 1
        call SetModelMatrix
        mov ebp, dword [ScoreboardSize]
        mov eax, dword [ScoreboardFrame]
        add esp, byte 8
        mov dword [ScoreboardOn], ebx
        xor edx, edx
        shl ebp, 10h
        shl eax, 10h
        mov dword [ScoreboardPitch], edx
        push edx
        mov dword [ScoreboardSize], ebp
        mov dword [ScoreboardFrame], eax
        call OpenResourceArchive
        add esp, byte 4
.1:
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
        push esi
        push edi
        mov edx, dword [ScoreboardClock]
        push edx
        call FreeModelFile
        add esp, byte 4
        mov ebx, dword [ScoreboardDigits]
        push ebx
        call FreeModelInstance
        add esp, byte 4
        mov ecx, dword [ScoreboardLogo]
        push ecx
        call FreeModelFile
        add esp, byte 4
        mov esi, dword [ScoreboardArt]
        push esi
        call FreeMemBlock
        add esp, byte 4
        mov eax, dword [ScoreboardLoaded]
        xor edi, edi
        call FindModelName
        mov dword [ScoreboardOn], edi
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawScoreboard                                  516B8  97 PC, low confidence
; Draws the scoreboard
;-----------------------------------------------------------------------------
DrawScoreboard:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov ebx, eax
        lea edi, [byte esp+0Ch]
        mov esi, ScoreboardZeroVector
        movsd
        movsd
        movsd
        cmp dword [ScoreboardOn], byte 0
        je near .19
        mov eax, dword [ScoreboardSize]
        mov ecx, dword [ScoreboardBounds]
        sar eax, 10h
        cmp eax, ecx
        jne near .3
        mov eax, dword [ScoreboardFrame]
        mov esi, dword [ScoreboardTime]
        sar eax, 10h
        cmp eax, esi
        jne near .3
        mov edi, dword [ScoreboardBuffer]
        mov eax, dword [ScoreboardAway]
        inc edi
        dec eax
        mov dword [ScoreboardBuffer], edi
        cmp eax, edi
        jg short .1
        mov dword [ScoreboardBuffer], 2
.1:
        mov eax, dword [ScoreboardBounds]
        mov dword [ScoreboardSize], eax
        mov eax, dword [ScoreboardTime]
        mov edx, dword [ScoreboardHome]
        mov dword [ScoreboardFrame], eax
        mov eax, dword [ScoreboardBuffer]
        mov edx, dword [edx+eax*4]
        mov eax, dword [ScoreboardClock]
        call GetModelMatrixEntry
        mov edx, dword [byte eax+08h]
        mov eax, dword [ScoreboardClock]
        mov edx, dword [byte edx+04h]
        mov edi, ScoreboardBounds
        call GetModelPartEntry
        mov esi, eax
        movsd
        movsd
        movsd
        mov eax, dword [ScoreboardTime]
        sub eax, dword [ScoreboardFrame]
        mov ecx, dword [ScoreboardBounds]
        push eax
        mov eax, dword [ScoreboardSize]
        sub eax, ecx
        push eax
        call AngleOfVector
        mov esi, eax
        mov dword [ScoreboardPeriod], eax
        neg esi
        add esp, byte 8
        mov dword [ScoreboardPeriod], esi
        cmp esi, 0FFFF8000h
        jne short .2
        inc word [ScoreboardTick]
.2:
        mov eax, dword [ScoreboardFrame]
        mov ebp, dword [ScoreboardSize]
        shl eax, 10h
        shl ebp, 10h
        mov dword [ScoreboardFrame], eax
        mov dword [ScoreboardSize], ebp
.3:
        mov edx, dword [ScoreboardPeriod]
        cmp edx, dword [ScoreboardScore]
        je near .6
        mov ecx, dword [ScoreboardPitch]
        mov eax, ebx
        sub eax, ecx
        mov dword [byte esp+018h], eax
        fild dword [byte esp+018h]
        fmul qword [F64_0p00138889]
        fmul qword [F64_65536_DrawScoreboard]
        mov esi, dword [ScoreboardScore]
        call __CHP
        fistp dword [byte esp+018h]
        mov eax, dword [byte esp+018h]
        add esi, eax
        mov dword [ScoreboardScore], esi
        cmp esi, 8000h
        jl short .4
        lea eax, [dword edx-010000h]
        lea ebp, [dword esi-010000h]
        mov dword [ScoreboardPeriod], eax
        mov dword [ScoreboardScore], ebp
.4:
        mov edx, dword [ScoreboardPeriod]
        cmp edx, dword [ScoreboardScore]
        jge short .5
        mov dword [ScoreboardScore], edx
.5:
        mov ecx, dword [ScoreboardScore]
        push ecx
        push ScoreboardText
        call RotateModelPoint
        add esp, byte 8
        push ScoreboardText
        mov esi, dword [ScoreboardDigits]
        push esi
        call SetModelMatrix
        add esp, byte 8
.6:
        sub ebx, dword [ScoreboardPitch]
        cmp ebx, byte 2
        jge short .7
        mov dword [byte esp+014h], 20000h
        jmp short .8
.7:
        shl ebx, 10h
        mov dword [byte esp+014h], ebx
.8:
        mov eax, esp
        push eax
        push ScoreboardText
        lea eax, [byte esp+014h]
        push eax
        call TransformVecFull
        add esp, byte 0Ch
        push ScoreboardSize
        lea eax, [byte esp+04h]
        push eax
        push ScoreboardSize
        call AddVec3
        mov eax, dword [ScoreboardSize]
        mov edx, dword [ScoreboardBounds]
        mov ebx, dword [ScoreboardScore]
        add esp, byte 0Ch
        sar eax, 10h
        shl edx, 10h
        cmp ebx, 4000h
        jl short .10
        cmp eax, dword [ScoreboardBounds]
        jle short .9
        mov dword [ScoreboardSize], edx
.9:
        mov eax, dword [ScoreboardFrame]
        mov edx, dword [ScoreboardTime]
        sar eax, 10h
        cmp eax, edx
        jge near .18
        jmp near .16
.10:
        test ebx, ebx
        jl short .12
        cmp eax, dword [ScoreboardBounds]
        jle short .11
        mov dword [ScoreboardSize], edx
.11:
        mov eax, dword [ScoreboardFrame]
        mov edi, dword [ScoreboardTime]
        sar eax, 10h
        cmp eax, edi
        jle short .18
        mov eax, edi
        jmp short .17
.12:
        cmp ebx, 0FFFFC000h
        jg short .14
        cmp eax, dword [ScoreboardBounds]
        jge short .13
        mov dword [ScoreboardSize], edx
.13:
        mov eax, dword [ScoreboardFrame]
        mov ecx, dword [ScoreboardTime]
        sar eax, 10h
        cmp eax, ecx
        jge short .18
        mov eax, ecx
        jmp short .17
.14:
        test ebx, ebx
        jg short .18
        cmp eax, dword [ScoreboardBounds]
        jge short .15
        mov dword [ScoreboardSize], edx
.15:
        mov eax, dword [ScoreboardFrame]
        mov edx, dword [ScoreboardTime]
        sar eax, 10h
        cmp eax, edx
        jle short .18
.16:
        mov eax, edx
.17:
        shl eax, 10h
        mov dword [ScoreboardFrame], eax
.18:
        mov ecx, 43960000h
        mov eax, dword [ScoreboardSize]
        mov esi, dword [ScoreboardDigits]
        xor ebx, ebx
        sar eax, 10h
        mov dword [byte esp+010h], ebx
        mov dword [byte esp+0Ch], eax
        mov eax, dword [ScoreboardFrame]
        mov dword [ScoreboardFrameNo], ecx
        sar eax, 10h
        fild dword [byte esp+0Ch]
        mov dword [byte esp+014h], eax
        lea eax, [byte esp+0Ch]
        fstp dword [ScoreboardAngle]
        push eax
        fild dword [byte esp+018h]
        push esi
        fstp dword [ScoreboardHeight]
        call SetModelPosition
        add esp, byte 8
.19:
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
; NetFrameDistance                                519E0  97 PC, low confidence
; Returns the distance to the net frame
;-----------------------------------------------------------------------------
NetFrameDistance:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebx, eax
        mov edx, dword [eax]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        lea edx, [nosplit eax*4+00h]
        mov eax, dword [BenchSideIndex]
        mov edi, dword [dword edx+NetFrameData]
        mov esi, dword [CameraFlashOn]
        sub eax, edi
        mov ecx, dword [dword edx+NetDistance]
        push eax
        sub esi, ecx
        push esi
        call vecdist
        add esp, byte 8
        cmp eax, 0BB8h
        jae short .1
        mov eax, dword [ebx]
        mov edx, dword [nosplit eax*4+ScoreboardFrames]
        jmp short .2
.1:
        mov eax, dword [ebx]
        mov edx, dword [nosplit eax*4+ScoreboardSpin]
.2:
        mov dword [nosplit eax*4+NetFrames], edx
        mov eax, dword [ebx]
        mov ebp, dword [nosplit eax*4+NetFrames]
        push ebp
        call DrawRinkObjectPolys
        mov esi, eax
        mov eax, dword [ebx]
        add esp, byte 4
        mov edx, dword [nosplit eax*4+NetFrames]
        push edx
        call ProjectRinkObjectPoints
        add esp, byte 4
        lea eax, [byte esi+028h]
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetupNetArt                                     51A74  97 PC, low confidence
; Sets up the net art
;-----------------------------------------------------------------------------
SetupNetArt:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebx, eax
        call NetFrameDistance
        mov ecx, dword [ebx]
        mov ecx, dword [nosplit ecx*4+NetFrames]
        mov ebx, dword [byte ecx+018h]
        mov edx, 0FFFFD8F1h
        cmp ebx, 190h
        jle short .3
        mov esi, dword [byte ecx+04h]
        mov eax, dword [byte ecx+07Ch]
        xor ebx, ebx
        test esi, esi
        jle short .4
.1:
        mov ebp, dword [byte eax+08h]
        cmp edx, ebp
        jg short .2
        mov edx, ebp
.2:
        inc ebx
        mov edi, dword [byte ecx+04h]
        add eax, byte 0Ch
        cmp ebx, edi
        jl short .1
        jmp short .4
.3:
        mov edx, 0FFFFFFFFh
.4:
        mov eax, edx
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
SetupNetArt_58:
        push ecx
        push edx
        mov eax, dword [eax]
        mov eax, dword [nosplit eax*4+NetFrames]
        cmp dword [byte eax+018h], 190h
        jle short .5
        push eax
        call InitModelParts
        add esp, byte 4
.5:
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; ResetNetArt                                     51AEC  97 PC, low confidence
; Resets the net art
;-----------------------------------------------------------------------------
ResetNetArt:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ecx, dword [eax]
        mov ecx, dword [nosplit ecx*4+NetFrames]
        mov ebx, dword [byte ecx+018h]
        mov edx, 270Fh
        cmp ebx, 190h
        jle short .3
        mov esi, dword [byte ecx+04h]
        mov eax, dword [byte ecx+07Ch]
        xor ebx, ebx
        test esi, esi
        jle short .4
.1:
        mov ebp, dword [byte eax+08h]
        cmp edx, ebp
        jl short .2
        mov edx, ebp
.2:
        inc ebx
        mov edi, dword [byte ecx+04h]
        add eax, byte 0Ch
        cmp ebx, edi
        jl short .1
        jmp short .4
.3:
        mov edx, 0FFFFFFFFh
.4:
        mov eax, edx
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
ResetNetArt_50:
        push ecx
        push edx
        mov eax, dword [eax]
        mov eax, dword [nosplit eax*4+NetFrames]
        cmp dword [byte eax+018h], 190h
        jle short .5
        push eax
        call DrawModel
        add esp, byte 4
.5:
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; UpdateScoreboardPos                             51B5C  97 PC, low confidence
; Updates the scoreboard position
;-----------------------------------------------------------------------------
UpdateScoreboardPos:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ecx, eax
        mov ebp, edx
        test eax, eax
        jl short .1
        cmp eax, byte 1
        jg short .1
        shl eax, 2
        sub eax, ecx
        shl eax, 2
        mov ebx, ScoreboardCorners
        mov dword [esp], eax
        add ebx, eax
        mov eax, 3
        mov edi, dword [esp]
        mov esi, ebp
        call IntsToFloats
        lea edi, [dword edi+NetDistance]
        mov eax, dword [esp]
        lea ebx, [nosplit ecx*4+00h]
        movsd
        movsd
        movsd
        push ebp
        mov ecx, dword [dword ebx+ScoreboardSpin]
        fild dword [byte ebp+08h]
        push ecx
        fstp dword [dword eax+ScoreboardPos]
        call SetModelPosition
        add esp, byte 8
        push ebp
        mov esi, dword [dword ebx+ScoreboardFrames]
        push esi
        call SetModelPosition
        add esp, byte 8
.1:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; UpdateScoreboardSpin                            51BD8  97 PC, low confidence
; Updates the scoreboard spin
;-----------------------------------------------------------------------------
UpdateScoreboardSpin:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 28h
        mov ebx, eax
        test eax, eax
        jl short .1
        cmp eax, byte 1
        jg short .1
        fld dword [byte esp+03Ch]
        fmul qword [F64_0p31831_UpdateScoreboardSpin]
        fmul qword [F64_0p5_UpdateScoreboardSpin]
        fmul qword [F64_65536_UpdateScoreboardSpin]
        call __CHP
        fistp dword [byte esp+024h]
        mov edx, dword [byte esp+024h]
        push edx
        lea eax, [byte esp+04h]
        push eax
        call RotateModelPoint
        add esp, byte 8
        mov eax, esp
        push eax
        mov ecx, dword [nosplit ebx*4+ScoreboardSpin]
        push ecx
        call SetModelMatrix
        add esp, byte 8
        mov eax, esp
        push eax
        mov esi, dword [nosplit ebx*4+ScoreboardFrames]
        push esi
        call SetModelMatrix
        add esp, byte 8
.1:
        add esp, byte 28h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 4
        db 090h
;-----------------------------------------------------------------------------
; LoadNetArt                                      51C4C  97 PC, low confidence
; Loads the goal net art ("netback", "netfrnt")
;-----------------------------------------------------------------------------
LoadNetArt:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, NetArtDefs
        mov ecx, SetupNetArt_58
        lea edi, [nosplit eax*4+00h]
        mov ebx, SetupNetArt
        mov esi, eax
        add ebp, edi
        shl eax, 2
        push ebp
        sub eax, esi
        mov esi, NetArt
        shl eax, 2
        push byte 0
        add esi, eax
        mov eax, str_Netback
        mov edx, esi
        call AddModelName
        mov ecx, ResetNetArt_50
        push ebp
        mov ebx, ResetNetArt
        mov edx, esi
        push byte 0
        mov dword [dword edi+NetArtFront], eax
        mov eax, str_Netfrnt
        call AddModelName
        mov dword [dword edi+NetArtBack], eax
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
