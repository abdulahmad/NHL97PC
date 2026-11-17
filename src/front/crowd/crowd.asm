; Crowd and bench reactions, cheers and the goal light.
bits 32
%include "hockey.inc"
section s_4F6A9 progbits alloc exec nowrite align=1
extern AllocMemBlock, BenchCheerArt, BenchCheerCount, BenchCheerData, BenchCheerFirst, BenchCheerFrame, BenchCheerFrames, BenchCheerLast
extern BenchCheerModel, BenchCheerOn, BenchCheerParts, BenchCheerTeam, BenchCheerTimer, CameraFlashOn, CosInterp, CrowdCenter
extern CrowdDelay, Crowdframe, CrowdFrameTime, CrowdModel, CrowdReactCount, CrowdReactEnd, CrowdReactLevel, CrowdReactList
extern CrowdReactOn, CrowdReactPos, CrowdReactStart, CrowdReactTime, CrowdReactType, DrawFlatPoly, DrawPolyList, DrawSpriteScaled
extern F32_1p0_View, FixedLerp, FlashPolys, FreeMemBlock, GoalCheerOn, GoalCheerState, GoalCheerTeam, GoalCheerTimer
extern GoalLightArt, GoalLightFrame, GoalLightModel, GoalLightOn, GoalLightState, GoalLightTimerFar, GoalLightTimerNear, ProjectCoord
extern ProjectPointsWithZ, Random32, RinkPartModels, RinkSideGeometry, SinInterp, SinTable, str_GLASS, str_Punct_DrawRinkSurface
extern SubVec3, TransformVecFull, vecdist
global CrowdDistanceTo, CrowdRandomPose, CrowdRandomDelay, CrowdReactionStep, BuildCrowdReaction, StartCrowdReaction, ClearCrowdReaction, EndCrowdReaction
global EndCrowdReaction_59, NoOpCrowdHook, UpdateCrowdReaction, FindNearestBenchPlayer, StartBenchCheer, BenchCheerStep, UpdateBenchCheer, PickBenchCheerers
global GoalCrowdCheer, UpdateGoalLight, DrawGoalLight
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CrowdDistanceTo                                 4F6AC  97 PC, low confidence
; Returns the distance from a crowd member to a point
;-----------------------------------------------------------------------------
CrowdDistanceTo:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 3Ch
        mov dword [byte esp+038h], eax
        mov dword [byte esp+028h], edx
        mov dword [byte esp+024h], ebx
        mov ebx, 7FFFFFFFh
        mov eax, dword [byte esp+028h]
        mov edx, RinkSideGeometry+410h
        xor ecx, ecx
        mov dword [byte esp+034h], ebx
        mov dword [eax], 0FFFFFFFFh
        mov eax, dword [byte esp+024h]
        mov dword [byte esp+02Ch], ecx
        mov dword [byte esp+030h], edx
        mov dword [eax], 0FFFFFFFFh
.1:
        mov ebp, dword [byte esp+030h]
        mov eax, dword [byte esp+030h]
        mov ebp, dword [byte ebp+020h]
        xor ebx, ebx
        shl ebp, 2
        mov esi, dword [byte eax+014h]
        add ebp, RinkSideGeometry+0E68h
        test esi, esi
        jle near .4
.2:
        mov eax, dword [byte ebp+00h]
        mov eax, dword [byte eax+08h]
        imul esi, dword [eax], byte 0Ch
        mov edx, dword [CrowdCenter]
        mov edx, dword [byte edx+074h]
        mov edi, esp
        add esi, edx
        movsd
        movsd
        movsd
        imul esi, dword [byte eax+04h], byte 0Ch
        lea edi, [byte esp+018h]
        add esi, edx
        add eax, byte 4
        movsd
        movsd
        movsd
        mov eax, dword [esp]
        add eax, dword [byte esp+018h]
        sar eax, 1
        mov ecx, dword [byte esp+01Ch]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte esp+04h]
        add eax, ecx
        sar eax, 1
        mov esi, dword [byte esp+020h]
        mov dword [byte esp+010h], eax
        mov eax, dword [byte esp+08h]
        add eax, esi
        mov edx, dword [byte esp+038h]
        sar eax, 1
        mov edi, dword [byte edx+08h]
        mov dword [byte esp+014h], eax
        sub eax, edi
        mov ecx, dword [edx]
        push eax
        mov eax, dword [byte esp+010h]
        sub eax, ecx
        push eax
        call vecdist
        add esp, byte 8
        cmp eax, dword [byte esp+034h]
        jge short .3
        mov esi, dword [byte esp+028h]
        mov edx, dword [byte esp+02Ch]
        mov dword [esi], edx
        mov edx, dword [byte esp+024h]
        mov dword [byte esp+034h], eax
        mov dword [edx], ebx
.3:
        mov eax, dword [byte esp+030h]
        inc ebx
        mov edi, dword [byte eax+014h]
        add ebp, byte 4
        cmp ebx, edi
        jl near .2
.4:
        mov eax, dword [byte esp+030h]
        mov ebp, dword [byte esp+02Ch]
        add eax, 88h
        inc ebp
        mov dword [byte esp+030h], eax
        mov dword [byte esp+02Ch], ebp
        cmp ebp, byte 12h
        jl near .1
        add esp, byte 3Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
        push ecx
        push esi
        mov esi, dword [edx]
        mov ecx, dword [eax]
        add ecx, esi
        sar ecx, 1
        mov dword [ebx], ecx
        mov ecx, dword [byte eax+04h]
        add ecx, dword [byte edx+04h]
        sar ecx, 1
        mov dword [byte ebx+04h], ecx
        mov eax, dword [byte eax+08h]
        add eax, dword [byte edx+08h]
        sar eax, 1
        mov dword [byte ebx+08h], eax
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CrowdRandomPose                                 4F7FC  97 PC, low confidence
; Picks a random crowd pose
;-----------------------------------------------------------------------------
CrowdRandomPose:
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov edi, eax
        mov dword [byte esp+010h], edx
        mov ebp, ebx
        mov dword [byte esp+0Ch], ecx
        call Random32
        mov ebx, 0Bh
        xor edx, edx
        div ebx
        mov eax, edx
        mov ebx, 0A0000h
        shl eax, 10h
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        mov ebx, 0Bh
        mov dword [byte esp+08h], eax
        mov esi, eax
        call Random32
        xor edx, edx
        div ebx
        mov eax, edx
        mov ebx, 0A0000h
        shl eax, 10h
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
        add edx, eax
        mov ebx, eax
        cmp edx, 10000h
        jle short .1
        mov ebx, 10000h
        mov esi, 10000h
        mov edx, dword [byte esp+08h]
        sub ebx, eax
        sub esi, edx
.1:
        mov ecx, 10000h
        sub ecx, esi
        sub ecx, ebx
        mov edx, dword [edi]
        mov eax, ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, dword [byte esp+010h]
        mov dword [esp], eax
        mov eax, esi
        mov edx, dword [edx]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, dword [esp]
        add edx, eax
        mov dword [esp], edx
        mov eax, ebx
        mov edx, dword [byte ebp+00h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov dword [byte esp+04h], eax
        mov eax, dword [esp]
        add eax, dword [byte esp+04h]
        mov edx, dword [byte esp+0Ch]
        mov dword [edx], eax
        mov eax, ecx
        mov edx, dword [byte edi+04h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, dword [byte esp+010h]
        mov dword [esp], eax
        mov eax, esi
        mov edx, dword [byte edx+04h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, dword [esp]
        add edx, eax
        mov dword [byte esp+04h], edx
        mov eax, ebx
        mov edx, dword [byte ebp+04h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov dword [esp], eax
        mov eax, dword [byte esp+04h]
        add eax, dword [esp]
        mov edx, dword [byte esp+0Ch]
        mov dword [byte edx+04h], eax
        mov eax, ecx
        mov edx, dword [byte edi+08h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, dword [byte esp+010h]
        mov ecx, eax
        mov eax, esi
        mov edx, dword [byte edx+08h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, dword [byte ebp+08h]
        add ecx, eax
        mov eax, ebx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        add ecx, eax
        mov eax, dword [byte esp+0Ch]
        mov dword [byte eax+08h], ecx
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CrowdRandomDelay                                4F978  97 PC, low confidence
; Picks a random crowd delay
;-----------------------------------------------------------------------------
CrowdRandomDelay:
        push ecx
        push esi
        push edi
        mov esi, eax
        mov ecx, dword [CrowdReactType]
        cmp ecx, byte 6Ch
        jge near .1
        lea eax, [nosplit ecx*8+00h]
        add ecx, eax
        mov eax, dword [CrowdReactEnd]
        shl ecx, 2
        add eax, ecx
        mov edi, eax
        movsd
        movsd
        movsd
        mov esi, edx
        lea edi, [byte eax+0Ch]
        movsd
        movsd
        movsd
        mov esi, ebx
        lea edi, [byte eax+018h]
        movsd
        movsd
        movsd
        call Random32
        and eax, byte 3
        mov edx, dword [CrowdReactType]
        lea ebx, [byte eax-02h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, dword [CrowdDelay]
        mov dword [edx+eax*4], ebx
        call Random32
        and eax, byte 3
        mov edx, dword [CrowdReactType]
        lea ebx, [byte eax-02h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, dword [CrowdDelay]
        mov dword [byte edx+eax*4+08h], ebx
        call Random32
        and eax, byte 3Fh
        mov edx, dword [CrowdReactType]
        lea ebx, [byte eax-020h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, dword [CrowdDelay]
        mov dword [byte edx+eax*4+04h], ebx
        inc dword [CrowdReactType]
.1:
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CrowdReactionStep                               4FA2C  97 PC, low confidence
; Steps one crowd reaction
;-----------------------------------------------------------------------------
CrowdReactionStep:
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov ebp, eax
        mov esi, edx
        mov edi, ebx
        mov dword [byte esp+010h], ecx
        cmp ecx, byte 1
        jg short .1
        call CrowdRandomDelay
        jmp short .2
.1:
        mov ecx, esp
        call CrowdRandomPose
        mov ebx, dword [byte esp+010h]
        mov edx, esi
        dec ebx
        mov eax, ebp
        mov dword [byte esp+0Ch], ebx
        mov ecx, ebx
        mov ebx, esp
        call CrowdReactionStep
        mov ecx, dword [byte esp+0Ch]
        mov ebx, esp
        mov edx, edi
        mov eax, esi
        call CrowdReactionStep
        mov ecx, dword [byte esp+0Ch]
        mov ebx, esp
        mov edx, ebp
        mov eax, edi
        call CrowdReactionStep
.2:
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; BuildCrowdReaction                              4FA8C  97 PC, low confidence
; Builds a crowd reaction
;-----------------------------------------------------------------------------
BuildCrowdReaction:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 60h
        xor edx, edx
        mov dword [CrowdReactType], edx
        mov edx, dword [CrowdReactCount]
        mov eax, edx
        shl eax, 4
        add eax, edx
        shl eax, 3
        add eax, RinkSideGeometry+410h
        mov edx, dword [CrowdReactList]
        mov dword [byte eax+024h], edx
        mov eax, dword [byte eax+020h]
        shl eax, 2
        add eax, RinkSideGeometry+0E68h
        mov edx, dword [eax+edx*4]
        mov edx, dword [byte edx+08h]
        xor eax, eax
.1:
        imul esi, dword [edx], byte 0Ch
        mov ebx, dword [CrowdCenter]
        mov ebx, dword [byte ebx+074h]
        lea edi, [esp+eax]
        add esi, ebx
        add edx, byte 4
        add eax, byte 0Ch
        movsd
        movsd
        movsd
        cmp eax, byte 30h
        jne short .1
        lea ecx, [byte esp+054h]
        lea ebx, [byte esp+018h]
        lea edx, [byte esp+0Ch]
        mov eax, esp
        call CrowdRandomPose
        mov eax, dword [byte esp+024h]
        mov ecx, dword [byte esp+054h]
        add eax, ecx
        sar eax, 1
        mov esi, dword [byte esp+058h]
        mov dword [byte esp+030h], eax
        mov eax, dword [byte esp+028h]
        add eax, esi
        sar eax, 1
        mov edi, dword [byte esp+05Ch]
        mov dword [byte esp+034h], eax
        mov eax, dword [byte esp+02Ch]
        add eax, edi
        sar eax, 1
        mov dword [byte esp+038h], eax
        mov eax, dword [byte esp+018h]
        add eax, ecx
        sar eax, 1
        mov dword [byte esp+03Ch], eax
        mov eax, dword [byte esp+01Ch]
        add eax, esi
        sar eax, 1
        mov dword [byte esp+040h], eax
        mov eax, dword [byte esp+020h]
        add eax, edi
        sar eax, 1
        mov ecx, dword [CrowdReactLevel]
        mov dword [byte esp+044h], eax
        cmp ecx, byte 4
        jne near .3
        mov eax, dword [CrowdReactTime]
        mov dword [byte esp+034h], eax
        mov eax, dword [byte esp+040h]
        mov esi, dword [byte esp+034h]
        cmp eax, esi
        jge short .2
        mov dword [byte esp+040h], esi
.2:
        lea ebx, [byte esp+030h]
        lea edx, [byte esp+024h]
        mov eax, esp
        call CrowdRandomDelay
        lea ebx, [byte esp+030h]
        lea edx, [byte esp+0Ch]
        mov eax, esp
        call CrowdRandomDelay
        lea ebx, [byte esp+03Ch]
        lea edx, [byte esp+030h]
        lea eax, [byte esp+0Ch]
        call CrowdRandomDelay
        lea ebx, [byte esp+03Ch]
        lea edx, [byte esp+018h]
        lea eax, [byte esp+0Ch]
        mov ecx, 4
        call CrowdRandomDelay
        lea ebx, [byte esp+03Ch]
        lea edx, [byte esp+024h]
        lea eax, [byte esp+018h]
        call CrowdReactionStep
        mov ecx, 4
        lea ebx, [byte esp+03Ch]
        lea edx, [byte esp+030h]
        lea eax, [byte esp+024h]
        call CrowdReactionStep
        add esp, byte 60h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov ecx, 4
        lea ebx, [byte esp+030h]
        lea edx, [byte esp+024h]
        mov eax, esp
        call CrowdReactionStep
        mov ecx, 4
        lea ebx, [byte esp+030h]
        lea edx, [byte esp+0Ch]
        mov eax, esp
        call CrowdReactionStep
        mov ecx, 4
        lea ebx, [byte esp+030h]
        lea edx, [byte esp+018h]
        lea eax, [byte esp+0Ch]
        call CrowdReactionStep
        mov ecx, 4
        lea ebx, [byte esp+030h]
        lea edx, [byte esp+024h]
        lea eax, [byte esp+018h]
        call CrowdReactionStep
        add esp, byte 60h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StartCrowdReaction                              4FC50  97 PC, low confidence
; Starts a crowd reaction (near misses, hits)
;-----------------------------------------------------------------------------
StartCrowdReaction:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ebp, eax
        mov dword [byte esp+04h], edx
        mov dword [esp], ebx
        mov edi, CrowdReactPos
        mov esi, eax
        mov ebx, CrowdReactList
        mov edx, CrowdReactCount
        movsd
        movsd
        movsd
        call CrowdDistanceTo
        cmp dword [CrowdReactCount], byte 0FFFFFFFFh
        je near .2
        cmp dword [CrowdReactOn], byte 0
        jne short .1
        cmp dword [CrowdModel], byte 0
        jne short .1
        push byte 20h
        push dword 32A0h
        push str_GLASS
        call AllocMemBlock
        mov dword [CrowdModel], eax
        mov dword [CrowdReactEnd], eax
        add eax, 0F30h
        mov dword [Crowdframe], eax
        add eax, 0F30h
        mov dword [CrowdFrameTime], eax
        add eax, 0F30h
        add esp, byte 0Ch
        mov dword [CrowdDelay], eax
.1:
        mov eax, dword [esp]
        mov esi, 1
        mov dword [CrowdReactStart], eax
        mov eax, dword [byte esp+04h]
        mov dword [CrowdReactOn], esi
        mov dword [CrowdReactLevel], eax
        mov eax, dword [byte ebp+04h]
        mov dword [CrowdReactTime], eax
        call BuildCrowdReaction
.2:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ClearCrowdReaction                              4FD08  97 PC, low confidence
; Clears the crowd reaction
;-----------------------------------------------------------------------------
ClearCrowdReaction:
        push edx
        mov edx, 0FFFFFFFFh
        xor eax, eax
.1:
        add eax, 88h
        mov dword [dword eax+RinkSideGeometry+3ACh], edx
        cmp eax, 990h
        jne short .1
        pop edx
        ret
;-----------------------------------------------------------------------------
; EndCrowdReaction                                4FD24  97 PC, low confidence
; Ends the crowd reaction and frees its memory
;-----------------------------------------------------------------------------
EndCrowdReaction:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp dword [CrowdReactOn], byte 0
        je short .1
        mov ebx, dword [CrowdModel]
        push ebx
        call FreeMemBlock
        xor ecx, ecx
        add esp, byte 4
        mov dword [CrowdModel], ecx
.1:
        mov edi, 0FFFFFFFFh
        mov ebp, 0FFFFFFFFh
        xor esi, esi
        xor eax, eax
        mov dword [CrowdReactCount], edi
        mov dword [CrowdReactOn], esi
.2:
        add eax, 88h
        mov dword [dword eax+RinkSideGeometry+3ACh], ebp
        cmp eax, 990h
        jne short .2
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
EndCrowdReaction_59:
        mov eax, dword [CrowdReactEnd]
        mov edx, dword [Crowdframe]
        xor ebx, ebx
        mov ecx, dword [CrowdReactType]
        mov dword [byte esp+018h], ebx
        mov dword [byte esp+010h], eax
        test ecx, ecx
        jle near .17
        mov dword [byte esp+0Ch], ebx
.3:
        mov ecx, 9
        mov esi, dword [byte esp+010h]
        mov edi, edx
        rep movsd
        mov eax, dword [byte esp+018h]
        cmp eax, dword [CrowdReactLevel]
        jl near .10
        mov ecx, dword [byte esp+0Ch]
        mov esi, dword [CrowdDelay]
        mov edi, esp
        add esi, ecx
        xor ebx, ebx
        movsd
        movsd
        movsd
        test ebp, ebp
        jle near .10
.4:
        mov esi, dword [byte esp+04h]
        mov eax, dword [byte edx+04h]
        sub esi, byte 2
        mov edi, dword [byte edx+01Ch]
        mov dword [byte esp+04h], esi
        cmp eax, edi
        jg short .5
        cmp edi, dword [byte edx+010h]
        jge short .6
.5:
        mov eax, dword [esp]
        mov ecx, dword [edx]
        mov esi, dword [byte edx+04h]
        mov edi, dword [byte edx+08h]
        add ecx, eax
        mov eax, dword [byte esp+08h]
        mov dword [edx], ecx
        mov ecx, dword [byte esp+04h]
        add edi, eax
        mov eax, dword [esp]
        sar ecx, 4
        mov dword [byte edx+08h], edi
        add esi, ecx
        mov edi, dword [byte edx+010h]
        mov dword [byte edx+04h], esi
        add edi, ecx
        mov esi, dword [byte edx+0Ch]
        mov ecx, dword [byte edx+014h]
        mov dword [byte edx+010h], edi
        add esi, eax
        mov eax, dword [byte esp+08h]
        mov dword [byte edx+0Ch], esi
        add ecx, eax
        mov dword [byte edx+014h], ecx
        jmp near .9
.6:
        cmp dword [byte edx+04h], byte 0
        jle short .7
        mov eax, dword [esp]
        mov edi, dword [edx]
        mov ecx, dword [byte edx+04h]
        add edi, eax
        mov eax, dword [byte esp+04h]
        mov esi, dword [byte edx+08h]
        sar eax, 4
        mov dword [edx], edi
        add ecx, eax
        mov eax, dword [byte esp+08h]
        mov dword [byte edx+04h], ecx
        add esi, eax
        mov dword [byte edx+08h], esi
.7:
        cmp dword [byte edx+010h], byte 0
        jle short .8
        mov eax, dword [esp]
        mov ecx, dword [byte edx+0Ch]
        mov esi, dword [byte edx+010h]
        add ecx, eax
        mov eax, dword [byte esp+04h]
        mov edi, dword [byte edx+014h]
        sar eax, 4
        mov dword [byte edx+0Ch], ecx
        add esi, eax
        mov eax, dword [byte esp+08h]
        mov dword [byte edx+010h], esi
        add edi, eax
        mov dword [byte edx+014h], edi
.8:
        cmp dword [byte edx+01Ch], byte 0
        jle short .9
        mov eax, dword [esp]
        mov ecx, dword [byte edx+018h]
        mov esi, dword [byte edx+01Ch]
        add ecx, eax
        mov eax, dword [byte esp+04h]
        mov edi, dword [byte edx+020h]
        sar eax, 4
        mov dword [byte edx+018h], ecx
        add esi, eax
        mov eax, dword [byte esp+08h]
        mov dword [byte edx+01Ch], esi
        add edi, eax
        mov dword [byte edx+020h], edi
.9:
        inc ebx
        cmp ebx, ebp
        jl near .4
.10:
        cmp dword [byte edx+04h], byte 0
        jge short .11
        mov dword [byte edx+04h], 0
        jmp short .12
.11:
        mov dword [byte esp+014h], 1
.12:
        cmp dword [byte edx+010h], byte 0
        jge short .13
        mov dword [byte edx+010h], 0
        jmp short .14
.13:
        mov dword [byte esp+014h], 1
.14:
        cmp dword [byte edx+01Ch], byte 0
        jge short .15
        mov dword [byte edx+01Ch], 0
        jmp short .16
.15:
        mov dword [byte esp+014h], 1
.16:
        mov edi, dword [byte esp+0Ch]
        mov eax, dword [byte esp+018h]
        mov ebx, dword [byte esp+010h]
        mov ecx, dword [CrowdReactType]
        add edx, byte 24h
        add edi, byte 0Ch
        inc eax
        add ebx, byte 24h
        mov dword [byte esp+0Ch], edi
        mov dword [byte esp+018h], eax
        mov dword [byte esp+010h], ebx
        cmp eax, ecx
        jl near .3
.17:
        mov esi, dword [byte esp+014h]
        test esi, esi
        jne short .18
        mov dword [CrowdReactOn], esi
.18:
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
;-----------------------------------------------------------------------------
; NoOpCrowdHook                                   4FF55  97 PC, low confidence
; Does nothing (empty crowd hook)
;-----------------------------------------------------------------------------
NoOpCrowdHook:
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; UpdateCrowdReaction                             4FF58  97 PC, low confidence
; Updates the crowd reaction
;-----------------------------------------------------------------------------
UpdateCrowdReaction:
        cmp dword [CrowdReactOn], byte 0
        je short NoOpCrowdHook
        sub eax, dword [CrowdReactStart]
        nop
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov ebp, eax
        xor edx, edx
        mov dword [byte esp+014h], edx
        cmp eax, 0C8h
        jle near EndCrowdReaction_59
        mov dword [CrowdReactOn], edx
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FindNearestBenchPlayer                          4FF94  97 PC, low confidence
; Finds the nearest player on the bench
;-----------------------------------------------------------------------------
FindNearestBenchPlayer:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov edi, eax
        mov dword [byte esp+04h], edx
        mov dword [esp], ebx
        mov eax, dword [byte esp+04h]
        mov edx, RinkSideGeometry+410h
        mov dword [eax], 0FFFFFFFFh
        mov ebp, 7FFFFFFFh
        mov dword [ebx], 0FFFFFFFFh
        xor ebx, ebx
        mov dword [byte esp+0Ch], edx
        mov dword [byte esp+08h], ebx
.1:
        mov esi, dword [byte esp+0Ch]
        mov eax, dword [byte esp+0Ch]
        mov esi, dword [dword esi+080h]
        xor ebx, ebx
        shl esi, 2
        mov ecx, dword [dword eax+084h]
        add esi, RinkSideGeometry+10C0h
        test ecx, ecx
        jle short .4
.2:
        mov edx, dword [esi]
        mov ecx, dword [byte edi+08h]
        mov eax, dword [byte edx+08h]
        sub eax, ecx
        push eax
        mov eax, dword [edx]
        sub eax, dword [edi]
        push eax
        call vecdist
        add esp, byte 8
        cmp eax, ebp
        jge short .3
        mov ebp, dword [byte esp+04h]
        mov edx, dword [byte esp+08h]
        mov dword [byte ebp+00h], edx
        mov edx, dword [esp]
        mov ebp, eax
        mov dword [edx], ebx
.3:
        mov eax, dword [byte esp+0Ch]
        inc ebx
        mov edx, dword [dword eax+084h]
        add esi, byte 4
        cmp ebx, edx
        jl short .2
.4:
        mov ecx, dword [byte esp+0Ch]
        mov ebx, dword [byte esp+08h]
        add ecx, 88h
        inc ebx
        mov dword [byte esp+0Ch], ecx
        mov dword [byte esp+08h], ebx
        cmp ebx, byte 4
        jl short .1
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; StartBenchCheer                                 50050  97 PC, low confidence
; Starts a bench cheer
;-----------------------------------------------------------------------------
StartBenchCheer:
        push ecx
        push esi
        push edi
        sub esp, byte 8
        mov ecx, eax
        mov esi, edx
        mov edi, ebx
        test edx, edx
        jle near .8
        mov edx, dword [byte eax+08h]
        mov eax, dword [eax]
        call PickBenchCheerers
        cmp eax, dword [BenchCheerFrames]
        jle near .8
        mov ebx, esp
        lea edx, [byte esp+04h]
        mov eax, ecx
        call CrowdDistanceTo
        mov ebx, dword [byte esp+04h]
        cmp ebx, byte 0FFFFFFFFh
        je near .8
        cmp ebx, byte 4
        jge near .8
        cmp dword [BenchCheerOn], byte 0
        je short .1
        xor edx, edx
        mov dword [BenchCheerOn], edx
        call BenchCheerStep
.1:
        mov ebx, BenchCheerTimer
        mov edx, BenchCheerTeam
        mov eax, ecx
        call FindNearestBenchPlayer
        mov ebx, dword [BenchCheerTeam]
        cmp ebx, byte 0FFFFFFFFh
        je near .8
        mov ecx, ebx
        shl ecx, 4
        add ecx, ebx
        shl ecx, 3
        add ecx, RinkSideGeometry+410h
        test ebx, ebx
        jne short .3
        mov eax, dword [BenchCheerTimer]
        cmp eax, byte 4
        jl short .3
        lea edx, [byte eax-02h]
        cmp edx, byte 4
        jge short .2
        mov edx, 4
.2:
        mov dword [BenchCheerFrame], edx
        jmp short .5
.3:
        mov eax, dword [BenchCheerTimer]
        sub eax, byte 2
        test eax, eax
        jge short .4
        xor eax, eax
.4:
        mov dword [BenchCheerFrame], eax
.5:
        cmp dword [BenchCheerTeam], byte 0
        jne short .6
        mov ebx, dword [BenchCheerTimer]
        cmp ebx, byte 4
        jge short .6
        lea eax, [byte ebx+02h]
        cmp eax, byte 4
        jle short .7
        mov eax, 4
        jmp short .7
.6:
        mov eax, dword [BenchCheerTimer]
        mov edx, dword [dword ecx+084h]
        add eax, byte 2
        dec edx
        cmp edx, eax
        jge short .7
        mov eax, edx
.7:
        mov dword [BenchCheerCount], eax
        mov ecx, 1
        mov dword [BenchCheerLast], edi
        mov dword [BenchCheerFirst], esi
        mov dword [BenchCheerOn], ecx
.8:
        add esp, byte 8
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; BenchCheerStep                                  50174  97 PC, low confidence
; Steps a bench cheer
;-----------------------------------------------------------------------------
BenchCheerStep:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edi, RinkSideGeometry+410h
        xor edx, edx
        xor ebp, ebp
.1:
        mov eax, dword [dword edi+080h]
        mov ebx, ebp
        shl eax, 2
        mov ecx, dword [dword edi+084h]
        add eax, RinkSideGeometry+10C0h
        cmp ebp, ecx
        jge short .7
.2:
        test edx, edx
        jne short .3
        mov esi, dword [eax]
        mov ecx, dword [RinkPartModels+0FCh]
        mov dword [esi], ecx
        jmp short .6
.3:
        cmp edx, byte 1
        jne short .4
        mov esi, dword [eax]
        mov ecx, dword [RinkPartModels+100h]
        mov dword [byte esi+08h], ecx
        jmp short .6
.4:
        cmp edx, byte 2
        jne short .5
        mov ecx, dword [eax]
        mov esi, dword [RinkPartModels+0F4h]
        mov dword [ecx], esi
        jmp short .6
.5:
        mov ecx, dword [eax]
        mov esi, dword [RinkPartModels+090h]
        mov dword [byte ecx+08h], esi
.6:
        inc ebx
        mov esi, dword [dword edi+084h]
        add eax, byte 4
        cmp ebx, esi
        jl short .2
.7:
        inc edx
        add edi, 88h
        cmp edx, byte 4
        jl short .1
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        cmp dword [BenchCheerOn], byte 0
        je short .8
        xor ebx, ebx
        mov dword [BenchCheerOn], ebx
        call BenchCheerStep
.8:
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; UpdateBenchCheer                                50218  97 PC, low confidence
; Updates the bench cheer
;-----------------------------------------------------------------------------
UpdateBenchCheer:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp dword [BenchCheerOn], byte 0
        je near .10
        mov ebx, dword [BenchCheerLast]
        mov ebp, eax
        sub ebp, ebx
        lea eax, [nosplit ebp*4+00h]
        add eax, ebp
        shl eax, 3
        mov edx, eax
        shl eax, 4
        sub eax, edx
        mov edx, dword [BenchCheerFirst]
        sub edx, eax
        test edx, edx
        jge short .1
        cmp dword [BenchCheerOn], byte 0
        je near .10
        xor edi, edi
        mov dword [BenchCheerOn], edi
        call BenchCheerStep
        jmp near .10
.1:
        mov ebx, dword [BenchCheerTeam]
        mov eax, ebx
        shl eax, 4
        add eax, ebx
        shl eax, 3
        add eax, RinkSideGeometry+410h
        mov ebx, dword [dword eax+080h]
        shl ebx, 2
        mov eax, dword [BenchCheerFrame]
        add ebx, RinkSideGeometry+10C0h
        shl eax, 2
        add ebx, eax
        mov eax, 0Ah
        shl ebp, 4
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov esi, dword [BenchCheerFrame]
        mov ecx, dword [BenchCheerCount]
        mov edi, eax
        cmp esi, ecx
        jg near .10
.2:
        mov edx, dword [BenchCheerTimer]
        mov eax, esi
        sub eax, edx
        test eax, eax
        jge short .3
        neg eax
.3:
        shl eax, 7
        mov edx, ebp
        sub edx, eax
        mov eax, edx
        shl ah, 7
        sbb edx, edx
        add ah, ah
        sbb ecx, ecx
        xor eax, ecx
        and eax, 0FFh
        sub eax, ecx
        mov eax, dword [nosplit eax*4+SinTable]
        xor eax, edx
        sub eax, edx
        mov edx, eax
        mov eax, edi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, dword [BenchCheerTimer]
        mov ecx, eax
        mov eax, esi
        sub eax, edx
        test eax, eax
        jge short .4
        neg eax
.4:
        imul eax, dword 1388h
        mov edx, 10000h
        sub edx, eax
        mov eax, ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov ecx, dword [BenchCheerTeam]
        test ecx, ecx
        jne short .5
        mov edx, dword [RinkPartModels+0FCh]
        sub edx, eax
        mov eax, edx
        mov edx, dword [ebx]
        mov dword [edx], eax
        jmp short .9
.5:
        cmp ecx, byte 1
        jne short .6
        mov edx, dword [RinkPartModels+100h]
        sub edx, eax
        mov eax, edx
        mov edx, dword [ebx]
        jmp short .8
.6:
        cmp ecx, byte 2
        jne short .7
        add eax, dword [RinkPartModels+0F4h]
        mov edx, dword [ebx]
        mov dword [edx], eax
        jmp short .9
.7:
        cmp ecx, byte 3
        jne short .9
        mov ecx, dword [RinkPartModels+090h]
        mov edx, dword [ebx]
        add eax, ecx
.8:
        mov dword [byte edx+08h], eax
.9:
        mov eax, dword [BenchCheerCount]
        inc esi
        add ebx, byte 4
        cmp esi, eax
        jle near .2
.10:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PickBenchCheerers                               503A0  97 PC, low confidence
; Picks the players on the bench that cheer
;-----------------------------------------------------------------------------
PickBenchCheerers:
        push ebx
        mov ebx, eax
        movsx eax, dx
        mov edx, dword [BenchCheerModel]
        cmp eax, edx
        jl short .1
        mov eax, dword [BenchCheerArt]
        pop ebx
        ret
.1:
        neg edx
        cmp eax, edx
        jg short .2
        mov eax, dword [BenchCheerArt]
        pop ebx
        ret
.2:
        test bx, bx
        jg short .3
        mov ebx, dword [BenchCheerData]
        cmp eax, ebx
        jge short .3
        mov edx, ebx
        neg edx
        cmp eax, edx
        jle short .3
        mov eax, dword [BenchCheerFrames]
        pop ebx
        ret
.3:
        mov eax, dword [BenchCheerParts]
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 20h
        mov esi, eax
        mov ecx, edx
        mov edx, dword [byte eax+06h]
        sar edx, 10h
        movsx eax, word [eax]
        call PickBenchCheerers
        mov edx, dword [BenchCheerFrames]
        cmp eax, edx
        jne short .4
        xor eax, edx
        jmp near .6
.4:
        mov dword [byte ecx+08h], 0
        mov eax, dword [byte ecx+08h]
        lea ebx, [byte esp+01Ch]
        mov dword [byte ecx+04h], eax
        lea edx, [byte esp+018h]
        mov dword [ecx], eax
        mov eax, esi
        call CrowdDistanceTo
        mov ebx, dword [byte esp+018h]
        cmp ebx, byte 0FFFFFFFFh
        jne short .5
        xor eax, eax
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.5:
        mov eax, ebx
        shl eax, 4
        add eax, ebx
        shl eax, 3
        add eax, RinkSideGeometry+410h
        mov eax, dword [byte eax+020h]
        shl eax, 2
        mov edx, dword [byte esp+01Ch]
        add eax, RinkSideGeometry+0E68h
        mov edx, dword [eax+edx*4]
        mov edx, dword [byte edx+08h]
        mov esi, dword [edx]
        lea eax, [nosplit esi*4+00h]
        mov ebx, dword [CrowdCenter]
        sub eax, esi
        mov ebx, dword [byte ebx+074h]
        shl eax, 2
        lea edi, [byte esp+0Ch]
        lea esi, [ebx+eax]
        add edx, byte 4
        movsd
        movsd
        movsd
        mov edx, dword [edx]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 2
        mov edi, esp
        lea esi, [ebx+eax]
        movsd
        movsd
        movsd
        mov eax, dword [byte esp+0Ch]
        add eax, dword [esp]
        sar eax, 1
        mov edi, dword [byte esp+04h]
        mov dword [ecx], eax
        mov eax, dword [byte esp+010h]
        add eax, edi
        sar eax, 1
        mov ebp, dword [byte esp+08h]
        mov dword [byte ecx+04h], eax
        mov eax, dword [byte esp+014h]
        add eax, ebp
        sar eax, 1
        mov dword [byte ecx+08h], eax
        mov eax, 1
.6:
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; GoalCrowdCheer                                  504E0  97 PC, low confidence
; Starts the crowd cheer for a goal
;-----------------------------------------------------------------------------
GoalCrowdCheer:
        push ebx
        push ecx
        push esi
        mov ebx, eax
        mov esi, 1
        mov dword [GoalCheerOn], eax
        mov dword [GoalCheerState], edx
        xor ecx, ecx
        mov dword [GoalCheerTeam], esi
        mov dword [GoalLightState], ecx
        xor eax, eax
.1:
        test ebx, ebx
        je short .2
        mov edx, dword [RinkPartModels+100h]
        jmp short .3
.2:
        mov edx, dword [RinkPartModels+090h]
.3:
        add eax, byte 0Ch
        mov dword [dword eax+GoalCheerTimer], edx
        cmp eax, byte 30h
        jne short .1
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push edx
        xor edx, edx
        mov dword [GoalLightState], edx
        mov dword [GoalCheerTeam], edx
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; UpdateGoalLight                              50540  96 PC, medium confidence
; (ticks): from DrawGameFrame: the goal light's flashing, off after 258h
; ticks
;-----------------------------------------------------------------------------
UpdateGoalLight:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp dword [GoalCheerTeam], byte 0
        je near .9
        mov ebx, dword [GoalCheerState]
        mov edx, eax
        sub edx, ebx
        cmp edx, 258h
        jle short .1
        xor ebx, ebx
        mov dword [GoalLightState], ebx
        mov dword [GoalCheerTeam], ebx
        jmp near .9
.1:
        lea esi, [nosplit edx*4+00h]
        sub esi, edx
        shl esi, 4
        add esi, edx
        shl esi, 2
        push esi
        call SinInterp
        add esp, byte 4
        mov ebx, eax
        test eax, eax
        jge short .2
        neg eax
.2:
        push eax
        push dword 0FFh
        push dword 0C8h
        call FixedLerp
        add esp, byte 0Ch
        test ebx, ebx
        jge short .3
        mov edx, ebx
        neg edx
        jmp short .4
.3:
        mov edx, ebx
.4:
        mov eax, 0C8h
        xor ecx, ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov dword [GoalLightState], ecx
        test ebx, ebx
        je near .9
        lea ebp, [dword esi+01999h]
        push ebp
        call SinInterp
        add esp, byte 4
        mov edi, eax
        test eax, eax
        je near .9
        push esi
        call CosInterp
        add esp, byte 4
        push ebp
        mov esi, eax
        call CosInterp
        add esp, byte 4
        mov ebp, eax
        test ebx, ebx
        setg al
        and eax, 0FFh
        test edi, edi
        setg dl
        and edx, 0FFh
        cmp eax, edx
        jne near .9
        mov edx, esi
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        shl eax, 3
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        mov edx, ebp
        mov esi, eax
        lea eax, [nosplit edx*4+00h]
        mov ebx, edi
        add eax, edx
        mov edi, 1
        shl eax, 3
        sar esi, 10h
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        mov ebp, dword [GoalLightModel]
        sar eax, 10h
        mov dword [GoalLightState], edi
        cmp esi, ebp
        jle short .5
        mov esi, ebp
        jmp short .6
.5:
        mov edx, ebp
        neg edx
        cmp esi, edx
        jge short .6
        mov esi, edx
.6:
        mov edx, dword [GoalLightModel]
        cmp eax, edx
        jg short .7
        neg edx
        cmp eax, edx
        jge short .8
.7:
        mov eax, edx
.8:
        mov dword [GoalLightTimerNear], eax
        mov dword [GoalLightTimerFar], eax
        mov dword [GoalLightFrame], esi
        mov dword [GoalLightOn], esi
.9:
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
        push esi
        sub esp, byte 4
        mov ebx, eax
        mov ecx, dword [edx]
        mov esi, dword [CrowdCenter]
        shl ecx, 3
        mov eax, dword [dword esi+080h]
        mov edx, dword [edx]
        add ecx, eax
        lea eax, [nosplit edx*4+00h]
        push dword 40000000h
        sub eax, edx
        mov edx, dword [byte esi+07Ch]
        sub esp, byte 4
        fild dword [byte edx+eax*4+08h]
        fstp dword [esp]
        call ProjectCoord
        fstp dword [esp]
        fild word [byte ebx+06h]
        mov eax, dword [byte ecx+04h]
        mov edx, dword [ecx]
        push eax
        fmul dword [byte esp+04h]
        push edx
        fmul dword [F32_1p0_View]
        push ebx
        push eax
        fistp dword [esp]
        pop eax
        fild word [byte ebx+04h]
        fmul dword [byte esp+0Ch]
        push eax
        push eax
        fistp dword [esp]
        pop eax
        push eax
        call DrawSpriteScaled
        add esp, byte 14h
        add esp, byte 4
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawGoalLight                                50740  96 PC, medium confidence
; Draws the lit goal light (4 points in FlashPolys)
;-----------------------------------------------------------------------------
DrawGoalLight:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 5Ch
        cmp dword [GoalLightState], byte 0
        je near .2
        lea eax, [byte esp+050h]
        push eax
        push FlashPolys
        push CameraFlashOn
        call TransformVecFull
        add esp, byte 0Ch
        mov eax, esp
        push eax
        push FlashPolys
        push GoalLightOn
        push byte 4
        lea esi, [byte esp+010h]
        xor ebx, ebx
        call DrawFlatPoly
        add esp, byte 10h
.1:
        imul edi, ebx, byte 0Ch
        push esi
        lea eax, [byte esp+054h]
        push eax
        push esi
        call SubVec3
        add esp, byte 0Ch
        mov ecx, dword [str_Punct_DrawRinkSurface]
        cmp ecx, dword [byte esp+edi+08h]
        jg short .2
        inc ebx
        add esi, byte 0Ch
        cmp ebx, byte 4
        jl short .1
        lea ebx, [byte esp+030h]
        mov edx, esp
        mov eax, 4
        call ProjectPointsWithZ
        push byte 1
        push byte 0
        lea eax, [byte esp+038h]
        push eax
        mov esi, dword [GoalLightArt]
        push esi
        call DrawPolyList
        add esp, byte 10h
.2:
        add esp, byte 5Ch
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
