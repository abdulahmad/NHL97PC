; Rink sides: boards, glass, benches, bench players and the penalty box.
bits 32
%include "hockey.inc"
section s_507E1 progbits alloc exec nowrite align=1
extern AwayBlueLineModel, BenchDoorArt, BenchLineModel, BenchModelParts, BenchPalette, BenchRemap, BenchSideIndex, BoardsTopModel
extern CameraFlashOn, CenterCircleModel, CrowdCenter, Crowdframe, CrowdFrameTime, CrowdReactLevel, CrowdReactType, DrawFlatPoly
extern DrawPolyOutline, DrawRinkLine, DrawRinkPolys, DrawRinkPolyStrip, DrawRinkRing, DrawStandsEnd, DrawStandsRow, DrawStandsSide
extern EndSpotModels, FaceoffSpotModel, FillPolygon, FlashPolys, FlashSpots, GetRemapTable, GlassModel, GlassParts
extern GlassRemap, HomeBlueLineModel, ModelSlots, ProjectPointsWithZ, ProjectRinkObject, RinkPartModels, RinkSideGeometry, SetNetPositions
extern SetRemapTable, SetRinkLineDetail, SetRinkView, ShowCenterLogo, ShowCrowd, ShowFrameRate, StandsRowModel, SubVec3
extern TransformRinkPoints, TransformVecFull
global TransformRink, DrawBenchLines, DrawBoardsTop, DrawBoardsTop_184, DrawStandsSides, DrawBenchDoors, DrawGlass, DrawBenchPlayers
global DrawBenchArea, DrawPenaltyBox, DrawBenches
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; TransformRink                                507E4  96 PC, medium confidence
; Transforms the rink vertices and sets which rink ends face the camera
;-----------------------------------------------------------------------------
TransformRink:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov eax, dword [CrowdCenter]
        push byte 0
        mov edx, dword [dword eax+080h]
        push edx
        mov ebx, dword [byte eax+07Ch]
        push ebx
        call SetRinkView
        mov eax, dword [CameraFlashOn]
        mov ecx, dword [RinkPartModels+0FCh]
        add esp, byte 0Ch
        cmp eax, ecx
        setge al
        and eax, 0FFh
        mov esi, dword [RinkPartModels+100h]
        mov dword [RinkSideGeometry+414h], eax
        mov eax, dword [BenchSideIndex]
        cmp eax, esi
        setge al
        and eax, 0FFh
        mov edi, dword [RinkPartModels+0F4h]
        mov dword [RinkSideGeometry+49Ch], eax
        mov eax, dword [CameraFlashOn]
        cmp eax, edi
        setle al
        and eax, 0FFh
        mov ebp, dword [RinkPartModels+090h]
        mov dword [RinkSideGeometry+524h], eax
        mov eax, dword [BenchSideIndex]
        cmp eax, ebp
        setle al
        mov ebx, RinkSideGeometry+410h
        and eax, 0FFh
        xor ebp, ebp
        mov dword [RinkSideGeometry+5ACh], eax
.1:
        mov edi, dword [byte ebx+018h]
        mov eax, dword [byte ebx+0Ch]
        mov dword [ebx], 0
        shl edi, 2
        xor esi, esi
        add edi, RinkSideGeometry+0DA0h
        test eax, eax
        jle short .3
.2:
        mov eax, dword [edi]
        mov ecx, dword [byte eax+08h]
        push ecx
        push byte 4
        call TransformRinkPoints
        add esp, byte 8
        test eax, eax
        sete al
        and eax, 0FFh
        mov dword [ebx], eax
        jne short .3
        inc esi
        mov edx, dword [byte ebx+0Ch]
        add edi, byte 4
        cmp esi, edx
        jl short .2
.3:
        cmp dword [byte ebx+04h], byte 0
        sete al
        add ebx, 88h
        and eax, 0FFh
        inc ebp
        mov dword [byte ebx-080h], eax
        cmp ebp, byte 4
        jge short .6
        jmp short .1
.4:
        mov esi, dword [byte ebx+018h]
        mov esi, dword [nosplit esi*4+RinkSideGeometry+0DA0h]
        mov eax, dword [byte esi+08h]
        push eax
        push byte 4
        call TransformRinkPoints
        add esp, byte 8
        test eax, eax
        sete al
        and eax, 0FFh
        mov dword [ebx], eax
        je short .5
        mov edx, dword [byte esi+08h]
        push edx
        call ProjectRinkObject
        add esp, byte 4
        test eax, eax
        setl al
        and eax, 0FFh
        mov dword [byte ebx+04h], eax
.5:
        add ebx, 88h
        inc ebp
        mov dword [byte ebx-080h], edi
        jmp short .7
.6:
        xor edi, edi
.7:
        cmp ebp, byte 12h
        jl short .4
        cmp dword [RinkSideGeometry+418h], byte 0
        jne short .8
        cmp dword [RinkSideGeometry+4A0h], byte 0
        je short .10
.8:
        mov eax, 220h
        mov ebx, 1
.9:
        add eax, 88h
        mov dword [dword eax+RinkSideGeometry+390h], ebx
        cmp eax, 3B8h
        jne short .9
.10:
        cmp dword [RinkSideGeometry+4A0h], byte 0
        jne short .11
        cmp dword [RinkSideGeometry+528h], byte 0
        je short .13
.11:
        mov eax, 3B8h
        mov edi, 1
.12:
        add eax, 88h
        mov dword [dword eax+RinkSideGeometry+390h], edi
        cmp eax, 550h
        jne short .12
.13:
        cmp dword [RinkSideGeometry+528h], byte 0
        jne short .14
        cmp dword [RinkSideGeometry+5B0h], byte 0
        je short .16
.14:
        mov eax, 550h
        mov edx, 1
.15:
        add eax, 88h
        mov dword [dword eax+RinkSideGeometry+390h], edx
        cmp eax, 6E8h
        jne short .15
.16:
        cmp dword [RinkSideGeometry+5B0h], byte 0
        jne short .17
        cmp dword [RinkSideGeometry+418h], byte 0
        je short .19
.17:
        mov eax, 6E8h
        mov esi, 1
.18:
        add eax, 88h
        mov dword [dword eax+RinkSideGeometry+390h], esi
        cmp eax, 880h
        jne short .18
.19:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawBenchLines                                  509E8  97 PC, low confidence
; Draws the bench lines
;-----------------------------------------------------------------------------
DrawBenchLines:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov dword [esp], eax
        mov ecx, dword [CrowdCenter]
        mov edx, RinkSideGeometry+410h
        xor ebx, ebx
        mov ebp, dword [dword ecx+084h]
        mov ecx, dword [byte ecx+07Ch]
        mov dword [byte esp+010h], edx
        mov dword [byte esp+0Ch], ecx
        lea ecx, [byte edx+030h]
        mov dword [byte esp+08h], ebx
        mov dword [byte esp+04h], ecx
.1:
        mov ecx, dword [byte esp+010h]
        mov esi, dword [esp]
        cmp esi, dword [byte ecx+04h]
        jne short .3
        mov ecx, dword [byte esp+010h]
        mov eax, dword [byte ecx+028h]
        xor edi, edi
        test eax, eax
        jle short .3
        mov esi, dword [byte esp+04h]
.2:
        mov eax, dword [byte esp+0Ch]
        mov edx, dword [BenchLineModel]
        mov ecx, dword [HomeBlueLineModel]
        push edx
        mov ebx, esi
        mov edx, ebp
        call DrawRinkLine
        mov ecx, dword [byte esp+010h]
        inc edi
        mov ebx, dword [byte ecx+028h]
        add esi, byte 8
        cmp edi, ebx
        jl short .2
.3:
        mov esi, dword [byte esp+04h]
        mov edi, dword [byte esp+010h]
        mov ecx, dword [byte esp+08h]
        add esi, 88h
        add edi, 88h
        inc ecx
        mov dword [byte esp+04h], esi
        mov dword [byte esp+010h], edi
        mov dword [byte esp+08h], ecx
        cmp ecx, byte 4
        jge short .6
        jmp short .1
.4:
        mov ecx, dword [byte esp+010h]
        mov ebx, dword [esp]
        cmp ebx, dword [byte ecx+04h]
        jne short .5
        mov ecx, dword [byte esp+010h]
        cmp dword [ecx], byte 0
        je short .5
        mov eax, dword [byte esp+0Ch]
        mov edx, dword [BenchLineModel]
        mov ecx, dword [HomeBlueLineModel]
        push edx
        mov ebx, esi
        mov edx, ebp
        call DrawRinkLine
.5:
        mov ecx, dword [byte esp+010h]
        mov ebx, dword [byte esp+08h]
        add esi, 88h
        add ecx, edi
        inc ebx
        mov dword [byte esp+010h], ecx
        mov dword [byte esp+08h], ebx
        jmp short .7
.6:
        lea esi, [byte edi+030h]
        mov edi, 88h
.7:
        cmp dword [byte esp+08h], byte 10h
        jl short .4
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawBoardsTop                                   50AF4  97 PC, low confidence
; Draws the top of the boards
;-----------------------------------------------------------------------------
DrawBoardsTop:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov dword [esp], eax
        mov ecx, dword [CrowdCenter]
        mov edx, RinkSideGeometry+410h
        xor ebx, ebx
        mov ebp, dword [dword ecx+084h]
        mov ecx, dword [byte ecx+07Ch]
        mov dword [byte esp+010h], edx
        mov dword [byte esp+0Ch], ecx
        lea ecx, [byte edx+048h]
        mov dword [byte esp+08h], ebx
        mov dword [byte esp+04h], ecx
.1:
        mov ecx, dword [byte esp+010h]
        mov esi, dword [esp]
        cmp esi, dword [byte ecx+04h]
        jne short .3
        mov ecx, dword [byte esp+010h]
        mov eax, dword [byte ecx+02Ch]
        xor edi, edi
        test eax, eax
        jle short .3
        mov esi, dword [byte esp+04h]
.2:
        mov eax, dword [byte esp+0Ch]
        mov edx, dword [BoardsTopModel]
        mov ecx, dword [AwayBlueLineModel]
        push edx
        mov ebx, esi
        mov edx, ebp
        call DrawRinkLine
        mov ecx, dword [byte esp+010h]
        inc edi
        mov ebx, dword [byte ecx+02Ch]
        add esi, byte 8
        cmp edi, ebx
        jl short .2
.3:
        mov esi, dword [byte esp+04h]
        mov edi, dword [byte esp+010h]
        mov ecx, dword [byte esp+08h]
        add esi, 88h
        add edi, 88h
        inc ecx
        mov dword [byte esp+04h], esi
        mov dword [byte esp+010h], edi
        mov dword [byte esp+08h], ecx
        cmp ecx, byte 4
        jge short .6
        jmp short .1
.4:
        mov ecx, dword [byte esp+010h]
        cmp dword [ecx], byte 0
        je short .5
        mov eax, dword [esp]
        cmp eax, dword [byte ecx+04h]
        jne short .5
        mov eax, dword [byte esp+0Ch]
        mov edx, dword [BoardsTopModel]
        mov ecx, dword [AwayBlueLineModel]
        push edx
        mov ebx, esi
        mov edx, ebp
        call DrawRinkLine
.5:
        mov ecx, dword [byte esp+010h]
        mov ebx, dword [byte esp+08h]
        add esi, 88h
        add ecx, edi
        inc ebx
        mov dword [byte esp+010h], ecx
        mov dword [byte esp+08h], ebx
        jmp short .7
.6:
        lea esi, [byte edi+048h]
        mov edi, 88h
.7:
        cmp dword [byte esp+08h], byte 10h
        jl short .4
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        mov ebx, dword [byte esp+08h]
        cmp dword [ebx], byte 0
        je short .10
        mov ebp, dword [esp]
        cmp ebp, dword [byte ebx+04h]
        jne short .10
        mov ebp, dword [byte esp+08h]
        mov ebx, dword [byte esp+08h]
        xor eax, eax
        mov ebp, dword [byte ebp+01Ch]
        mov dword [byte esp+010h], eax
        shl ebp, 2
        mov edx, dword [byte ebx+010h]
        add ebp, RinkSideGeometry
        test edx, edx
        jle short .10
.9:
        mov ebx, dword [CenterCircleModel]
        mov ecx, dword [RinkPartModels+1A8h]
        push ebx
        mov ebx, dword [byte ebp+00h]
        mov edx, esi
        mov eax, edi
        mov ebx, dword [byte ebx+08h]
        call DrawRinkLine
        mov ecx, dword [byte esp+010h]
        inc ecx
        mov dword [byte esp+010h], ecx
        mov ebx, ecx
        mov ecx, dword [byte esp+08h]
        mov eax, dword [byte ecx+010h]
        add ebp, byte 4
        cmp ebx, eax
        jl short .9
.10:
        mov ebx, dword [byte esp+08h]
        mov edx, dword [byte esp+04h]
        add ebx, 88h
        inc edx
        mov dword [byte esp+08h], ebx
        mov dword [byte esp+04h], edx
DrawBoardsTop_184:
        cmp dword [byte esp+04h], byte 10h
        jl near DrawBoardsTop.8
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawStandsSides                              50C90  96 PC, medium confidence
; (half): draws the stands of the rink sides on one half
;-----------------------------------------------------------------------------
DrawStandsSides:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov dword [esp], eax
        mov eax, dword [FlashSpots]
        mov edx, dword [eax]
        mov ebx, dword [byte edx+020h]
        push ebx
        mov ecx, dword [dword eax+080h]
        push ecx
        mov esi, dword [byte eax+07Ch]
        push esi
        mov edi, RinkSideGeometry+410h
        xor ebp, ebp
        call SetRinkView
        add esp, byte 0Ch
.1:
        cmp dword [edi], byte 0
        je near .9
        mov edx, dword [esp]
        cmp edx, dword [byte edi+08h]
        jne short .2
        cmp ebp, byte 4
        jl short .3
.2:
        cmp ebp, byte 4
        jl near .9
        cmp dword [esp], byte 0
        je near .9
.3:
        mov ecx, dword [byte edi+070h]
        mov eax, dword [byte edi+074h]
        shl ecx, 2
        xor esi, esi
        add ecx, RinkSideGeometry+348h
        test eax, eax
        jle short .5
.4:
        mov edx, dword [ecx]
        mov ebx, 0FFFFFFFFh
        mov eax, dword [StandsRowModel]
        mov edx, dword [byte edx+08h]
        inc esi
        call DrawStandsRow
        mov edx, dword [byte edi+074h]
        add ecx, byte 4
        cmp esi, edx
        jl short .4
.5:
        mov ebx, dword [byte edi+068h]
        mov esi, dword [byte edi+06Ch]
        shl ebx, 2
        xor ecx, ecx
        add ebx, RinkSideGeometry+258h
        test esi, esi
        jle short .9
.6:
        cmp ebp, byte 4
        jge short .7
        mov eax, dword [FlashSpots]
        mov edx, dword [ebx]
        call DrawStandsSide
        jmp short .8
.7:
        mov eax, dword [ebx]
        call DrawStandsEnd
.8:
        inc ecx
        mov eax, dword [byte edi+06Ch]
        add ebx, byte 4
        cmp ecx, eax
        jl short .6
.9:
        inc ebp
        add edi, 88h
        cmp ebp, byte 10h
        jl near .1
        cmp dword [ShowCrowd], byte 0
        je short .15
        mov esi, RinkSideGeometry+410h
        xor ebp, ebp
        xor edi, edi
.10:
        cmp edi, dword [esi]
        je short .14
        mov ebx, dword [esp]
        cmp ebx, dword [byte esi+08h]
        jne short .11
        cmp ebp, byte 4
        jl short .12
.11:
        cmp ebp, byte 4
        jl short .14
        cmp edi, dword [esp]
        je short .14
.12:
        mov ebx, dword [byte esi+078h]
        mov ecx, edi
        shl ebx, 2
        mov eax, dword [byte esi+07Ch]
        add ebx, RinkSideGeometry+0FF8h
        cmp edi, eax
        jge short .14
.13:
        mov eax, dword [FlashSpots]
        mov edx, dword [ebx]
        call DrawStandsSide
        inc ecx
        mov edx, dword [byte esi+07Ch]
        add ebx, byte 4
        cmp ecx, edx
        jl short .13
.14:
        inc ebp
        add esi, 88h
        cmp ebp, byte 10h
        jl short .10
.15:
        mov eax, dword [CrowdCenter]
        push byte 0
        mov ebx, dword [dword eax+080h]
        push ebx
        mov ecx, dword [byte eax+07Ch]
        push ecx
        call SetRinkView
        add esp, byte 0Ch
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawBenchDoors                                  50DF4  97 PC, low confidence
; Draws the bench doors
;-----------------------------------------------------------------------------
DrawBenchDoors:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        xor edx, edx
        mov ebp, RinkSideGeometry+410h
        mov dword [esp], edx
.1:
        mov ebx, dword [byte ebp+060h]
        test ebx, ebx
        jle near .6
        cmp dword [byte ebp+04h], byte 0
        je near .6
        mov esi, dword [byte ebp+064h]
        shl esi, 2
        xor edi, edi
        add esi, RinkSideGeometry+320h
        test ebx, ebx
        jle short .6
.2:
        mov eax, dword [esi]
        mov ebx, dword [byte eax+08h]
        push ebx
        push byte 4
        call TransformRinkPoints
        add esp, byte 8
        test eax, eax
        jne short .5
        mov eax, dword [esi]
        mov edx, dword [eax]
        shl edx, 8
        mov ecx, dword [BenchDoorArt]
        shr edx, 18h
        cmp edx, ecx
        jne short .3
        mov ebx, dword [FaceoffSpotModel]
        mov ecx, dword [byte eax+08h]
        push ebx
        mov ebx, dword [eax]
        mov eax, dword [CrowdCenter]
        jmp short .4
.3:
        mov edx, dword [EndSpotModels]
        mov ecx, dword [byte eax+08h]
        mov ebx, dword [eax]
        mov eax, dword [CrowdCenter]
        push edx
.4:
        and ebx, byte 7
        mov edx, dword [dword eax+084h]
        mov eax, dword [byte eax+07Ch]
        call SetNetPositions
.5:
        inc edi
        mov edx, dword [byte ebp+060h]
        add esi, byte 4
        cmp edi, edx
        jl short .2
.6:
        mov ecx, dword [esp]
        inc ecx
        add ebp, 88h
        mov dword [esp], ecx
        cmp ecx, byte 10h
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
; DrawGlass                                       50EB8  97 PC, low confidence
; Draws the glass
;-----------------------------------------------------------------------------
DrawGlass:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edi, RinkSideGeometry+410h
        xor ebp, ebp
.1:
        cmp dword [edi], byte 0
        je near .5
        cmp dword [byte edi+04h], byte 0
        je near .5
        mov ebx, dword [byte edi+018h]
        mov ecx, dword [byte edi+0Ch]
        shl ebx, 2
        xor esi, esi
        add ebx, RinkSideGeometry+0DA0h
        test ecx, ecx
        jle short .5
.2:
        cmp dword [ShowFrameRate], byte 0
        je short .3
        mov eax, dword [ebx]
        test byte [eax], 80h
        je short .3
        mov ecx, dword [CrowdCenter]
        mov edx, eax
        mov eax, ecx
        call SetRinkLineDetail
        jmp short .4
.3:
        mov eax, dword [ebx]
        mov ecx, dword [byte eax+08h]
        push ecx
        push byte 4
        call TransformRinkPoints
        add esp, byte 8
        test eax, eax
        jne short .4
        mov eax, dword [ebx]
        mov edx, dword [byte eax+08h]
        push edx
        push byte 4
        mov ecx, dword [GlassModel]
        push ecx
        call DrawRinkPolyStrip
        add esp, byte 0Ch
.4:
        inc esi
        mov eax, dword [byte edi+0Ch]
        add ebx, byte 4
        cmp esi, eax
        jl short .2
.5:
        inc ebp
        add edi, 88h
        cmp ebp, byte 10h
        jl near .1
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
        push ecx
        push edx
        test eax, eax
        je short .6
        push GlassRemap
        call SetRemapTable
        mov eax, dword [GlassParts]
        jmp short .7
.6:
        push BenchRemap
        call SetRemapTable
        mov eax, dword [BenchModelParts]
.7:
        add esp, byte 4
        mov dword [RinkPartModels+1A8h], eax
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawBenchPlayers                                50F90  97 PC, low confidence
; Draws the players on the bench
;-----------------------------------------------------------------------------
DrawBenchPlayers:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 124h
        mov edx, esp
        push edx
        call GetRemapTable
        add esp, byte 4
        lea edx, [dword esp+0118h]
        push edx
        push FlashPolys
        push CameraFlashOn
        call TransformVecFull
        add esp, byte 0Ch
        mov edx, dword [CrowdFrameTime]
        push edx
        push FlashPolys
        mov ebx, dword [Crowdframe]
        push ebx
        mov ebx, dword [CrowdReactType]
        lea edx, [nosplit ebx*4+00h]
        sub edx, ebx
        push edx
        call DrawFlatPoly
        add esp, byte 10h
        lea edx, [dword esp+0118h]
        push edx
        push edx
        push ModelSlots
        call SubVec3
        add esp, byte 0Ch
        mov ecx, dword [CrowdFrameTime]
        push ecx
        lea edx, [dword esp+011Ch]
        mov ebx, dword [CrowdReactType]
        push edx
        lea edx, [nosplit ebx*4+00h]
        push ecx
        sub edx, ebx
        push edx
        xor ebp, ebp
        xor esi, esi
        call DrawPolyOutline
        mov edi, dword [CrowdReactType]
        add esp, byte 10h
        test edi, edi
        jle near .6
        xor edi, edi
.1:
        lea ebx, [dword esp+0100h]
        mov edx, dword [CrowdFrameTime]
        mov eax, 3
        add edx, edi
        call ProjectPointsWithZ
        cmp esi, byte 4
        jl short .4
        mov ebx, 6
        mov edx, esi
        mov eax, esi
        sar edx, 1Fh
        idiv ebx
        test edx, edx
        je short .2
        push GlassRemap
        mov ebp, 1
        call SetRemapTable
        jmp short .3
.2:
        test ebp, ebp
        je short .4
        push BenchRemap
        call SetRemapTable
        xor ebp, ebp
.3:
        add esp, byte 4
.4:
        push byte 1
        push byte 0
        lea edx, [dword esp+0108h]
        push edx
        push byte 3
        push byte 0
        call FillPolygon
        mov edx, dword [CrowdReactLevel]
        add esp, byte 14h
        cmp edx, byte 4
        jne short .5
        cmp esi, edx
        jge short .5
        push byte 1
        push byte 0
        lea edx, [dword esp+0108h]
        push edx
        push byte 3
        push byte 0
        call FillPolygon
        add esp, byte 14h
.5:
        mov eax, dword [CrowdReactType]
        inc esi
        add edi, byte 24h
        cmp esi, eax
        jl near .1
.6:
        mov edx, esp
        push edx
        call SetRemapTable
        add esp, byte 4
        add esp, 124h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawBenchArea                                   510FC  97 PC, low confidence
; Draws the bench area
;-----------------------------------------------------------------------------
DrawBenchArea:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov dword [esp], eax
        mov edi, RinkSideGeometry+410h
        xor ebp, ebp
.1:
        cmp dword [edi], byte 0
        je short .5
        mov ebx, dword [esp]
        cmp ebx, dword [byte edi+04h]
        jne short .5
        mov esi, dword [byte edi+020h]
        mov ecx, dword [byte edi+014h]
        shl esi, 2
        xor ebx, ebx
        add esi, RinkSideGeometry+0E68h
        test ecx, ecx
        jle short .5
.2:
        cmp ebx, dword [byte edi+024h]
        jne short .3
        mov eax, dword [esi]
        mov edx, dword [byte eax+08h]
        push edx
        push byte 4
        call TransformRinkPoints
        add esp, byte 8
        test eax, eax
        jne short .4
        call DrawBenchPlayers
        jmp short .4
.3:
        mov eax, dword [esi]
        mov ecx, dword [byte eax+08h]
        push ecx
        push byte 4
        call DrawRinkRing
        add esp, byte 8
.4:
        inc ebx
        mov eax, dword [byte edi+014h]
        add esi, byte 4
        cmp ebx, eax
        jl short .2
.5:
        inc ebp
        add edi, 88h
        cmp ebp, byte 10h
        jl short .1
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
.6:
        ret
        db 08Bh,0C0h
        mov eax, 1
        call DrawBoardsTop
        call DrawBenchDoors
        mov eax, 1
        call DrawBenchLines
        cmp dword [ShowCenterLogo], byte 0
        je short .6
        mov eax, 1
        nop
;-----------------------------------------------------------------------------
; DrawPenaltyBox                                  511AC  97 PC, low confidence
; Draws the penalty box
;-----------------------------------------------------------------------------
DrawPenaltyBox:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov dword [esp], eax
        mov edx, RinkSideGeometry+410h
        xor ebx, ebx
        mov edi, dword [CrowdCenter]
        mov dword [byte esp+04h], ebx
        mov dword [byte esp+08h], edx
        mov esi, dword [dword edi+084h]
        mov edi, dword [byte edi+07Ch]
.1:
        mov ebx, dword [byte esp+08h]
        mov ecx, dword [esp]
        cmp ecx, dword [byte ebx+04h]
        jne short .3
        mov ebx, dword [byte esp+08h]
        mov ebx, dword [byte ebx+01Ch]
        shl ebx, 2
        add ebx, RinkSideGeometry
        mov dword [byte esp+0Ch], ebx
        mov ebx, dword [byte esp+08h]
        mov eax, dword [byte ebx+010h]
        xor ebp, ebp
        test eax, eax
        jle short .3
.2:
        mov ebx, dword [byte esp+0Ch]
        mov edx, dword [CenterCircleModel]
        mov ecx, dword [RinkPartModels+1A8h]
        mov eax, edi
        mov ebx, dword [ebx]
        push edx
        mov edx, esi
        mov ebx, dword [byte ebx+08h]
        call DrawRinkLine
        add dword [byte esp+0Ch], byte 4
        mov ebx, dword [byte esp+08h]
        inc ebp
        cmp ebp, dword [byte ebx+010h]
        jl short .2
.3:
        mov eax, dword [byte esp+08h]
        mov ebp, dword [byte esp+04h]
        add eax, 88h
        inc ebp
        mov dword [byte esp+08h], eax
        mov dword [byte esp+04h], ebp
        cmp ebp, byte 4
        jge near DrawBoardsTop_184
        jmp short .1
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawBenches                                     51254  97 PC, low confidence
; Draws the benches
;-----------------------------------------------------------------------------
DrawBenches:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 100h
        mov eax, dword [CrowdCenter]
        push byte 0
        mov edx, dword [dword eax+080h]
        push edx
        mov ebx, dword [byte eax+07Ch]
        push ebx
        call SetRinkView
        add esp, byte 0Ch
        mov eax, esp
        push eax
        call GetRemapTable
        add esp, byte 4
        push BenchPalette
        mov edi, RinkSideGeometry+410h
        xor ebp, ebp
        call SetRemapTable
        add esp, byte 4
.1:
        cmp dword [edi], byte 0
        je short .4
        mov esi, dword [byte edi+04h]
        test esi, esi
        jne short .4
        mov ebx, dword [byte edi+018h]
        shl ebx, 2
        mov eax, dword [byte edi+0Ch]
        add ebx, RinkSideGeometry+0DA0h
        test eax, eax
        jle short .4
.2:
        mov eax, dword [ebx]
        mov ecx, dword [byte eax+08h]
        push ecx
        push byte 4
        call TransformRinkPoints
        add esp, byte 8
        test eax, eax
        jne short .3
        mov eax, dword [ebx]
        mov edx, dword [byte eax+08h]
        push edx
        push byte 4
        call DrawRinkPolys
        add esp, byte 8
.3:
        inc esi
        mov edx, dword [byte edi+0Ch]
        add ebx, byte 4
        cmp esi, edx
        jl short .2
.4:
        inc ebp
        add edi, 88h
        cmp ebp, byte 10h
        jl short .1
        mov ebx, dword [RinkSideGeometry+410h]
        mov edi, RinkSideGeometry+410h
        test ebx, ebx
        je short .7
        cmp dword [RinkSideGeometry+414h], byte 0
        jne short .7
        mov ebx, dword [RinkSideGeometry+474h]
        mov ebp, dword [RinkSideGeometry+470h]
        shl ebx, 2
        xor esi, esi
        add ebx, RinkSideGeometry+320h
        test ebp, ebp
        jle short .7
.5:
        mov eax, dword [ebx]
        mov edx, dword [byte eax+08h]
        push edx
        push byte 4
        call TransformRinkPoints
        add esp, byte 8
        test eax, eax
        jne short .6
        mov eax, dword [ebx]
        mov ecx, dword [byte eax+08h]
        push ecx
        push byte 4
        call DrawRinkPolys
        add esp, byte 8
.6:
        inc esi
        mov eax, dword [byte edi+060h]
        add ebx, byte 4
        cmp esi, eax
        jl short .5
.7:
        mov esi, dword [RinkSideGeometry+520h]
        mov edi, RinkSideGeometry+520h
        test esi, esi
        je short .10
        cmp dword [RinkSideGeometry+524h], byte 0
        jne short .10
        mov ebx, dword [RinkSideGeometry+584h]
        mov eax, dword [RinkSideGeometry+580h]
        shl ebx, 2
        xor esi, esi
        add ebx, RinkSideGeometry+320h
        test eax, eax
        jle short .10
.8:
        mov eax, dword [ebx]
        mov ecx, dword [byte eax+08h]
        push ecx
        push byte 4
        call TransformRinkPoints
        add esp, byte 8
        test eax, eax
        jne short .9
        mov eax, dword [ebx]
        mov ebp, dword [byte eax+08h]
        push ebp
        push byte 4
        call DrawRinkPolys
        add esp, byte 8
.9:
        inc esi
        mov edx, dword [byte edi+060h]
        add ebx, byte 4
        cmp esi, edx
        jl short .8
.10:
        xor eax, eax
        call DrawBenchLines
        cmp dword [ShowCenterLogo], byte 0
        je short .11
        push BenchRemap
        call SetRemapTable
        mov eax, dword [BenchModelParts]
        add esp, byte 4
        mov dword [RinkPartModels+1A8h], eax
        xor eax, eax
        call DrawBenchArea
        xor eax, eax
        call DrawPenaltyBox
.11:
        mov eax, esp
        push eax
        call SetRemapTable
        add esp, byte 4
        add esp, 100h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        LD mov, eax, eax
        ret
