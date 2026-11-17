; Rink lines and stands: clipped line drawing, circles, arcs, dots, nets, the rink view and markings.
bits 32
%include "hockey.inc"
section s_4CE91 progbits alloc exec nowrite align=1
extern __CHP, AddVecs, AngleOfVector, AwayBlueLineModel, BenchLineModel, BoardLinePolys, BoardsTopModel, BuildNetGeometry
extern CameraModeOn, CameraOnPuck, CameraStateRecords, CenterCircleModel, CenterSpotModel, CosInterp, CreaseArcModel, CreaseModel
extern CreasePolyModel, DrawEllipseSpans, DrawFixedLine, DrawFlatPoly, DrawPolyOutline, DrawRinkFan, DrawRinkLineFlat, DrawRinkRing
extern DrawSurfacePolys, DrawTexturedPoly, DrawTexturedQuad, EndSpotModels, F32_10_BuildRinkGeometry, F32_14, F32_1p0_View, F32_4
extern F32_600, F32_65536_InitRinkView, F32_65536_ScaleLineWidth, F32_6_BuildRinkGeometry, F32_8, F64_0p04, F64_0p31831, F64_0p5_ScaleLineWidth
extern F64_110, F64_1p5708_InitRinkView, F64_40, F64_65536_InitRinkView, F64_6p28319_BuildRinkGeometry, F64_6p28319_DrawCreaseArc, F64_80, FaceoffSpotModel
extern FillPolygon, FlashPolys, FlashSpots, HomeBlueLineModel, hypot_, IceCenterPoly, IceGeometryDef, IceLinePolys
extern IceSurfaceDef, IceSurfacePolys, IF@ATAN2, NetGeometry, NetShadowD, NetShadowH, NetShadowW, NetShadowX
extern NetShadowY, NetShadowZ, NetsHookPos, NetX, NetY, NetZ, NeutralSpotModel, ProjDetailScale
extern ProjectCoord, ProjectCoordInt, ProjectionCenter, ProjectionFar, ProjectionNear, ProjectModelBounds, ProjectPointFloat, ProjectPoints
extern ProjectPointsToScreen, ProjectRinkPoints, RinkAspect, RinkBlueLine, RinkCenterLine, RinkCorner, RinkFov, RinkGeometryBuilt
extern RinkGeometryCount, RinkGeometryData, RinkGeometryModel, RinkGeometryParts, RinkGoalLine, RinkLength, RinkLineWidth, RinkMarkingDefs
extern RinkMarkingGeometry, RinkMarkingModel, RinkModel, RinkPartModels, RinkTextureArt, RinkTextures, RinkViewCenter, RinkViewHeight
extern RinkViewTable, RinkViewWidth, RinkWidth, ScaleFloatsToInts, ScaleVec3, SetStandsClip, SetStandsDetail, SetTextureDetail
extern ShowCenterLogo, SinInterp, SpotModelData, StandsArt, StandsEndModel, StandsRowModel, str_Punct_DrawRinkSurface, SubVec3
extern TextureDetail, TexturePageBase, TextureTileSize, TransformRinkPoints, TransformVecs, UpdateCameraFlashes, VecAdd, vecdist
extern VecDistance, VecMulMat, ViewDistance
global ClipLinePoint, ProjectLinePoints, ClipLineSegment, LineSegmentLength, DrawRinkCircle, DrawRinkLine, ScaleLineWidth, SetLineWidth
global DrawRinkArc, DrawFaceoffDot, DrawLineSegment, SetNetPositions, DrawNets, DrawNetShadows, DrawNetsHook, InitRinkProjection
global PeriodOver, IsCameraOnPuck, SetCameraMode, InitRinkView, UpdateViewDistance, DrawStandsRow, DrawStandsSection, DrawStandsEnd
global DrawStandsSide, DrawHomeBlueLine, DrawAwayBlueLine, DrawCenterSpots, DrawEndSpots, DrawNeutralSpots, DrawCenterCircle, DrawCenterCircle_30
global SetRinkLineDetail, DrawCreaseArc, BuildRinkGeometry, DrawIceSurface, DrawCreases, DrawRinkMarkings, DrawBoardsLines, DrawGoalLines
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ClipLinePoint                                   4CE94  97 PC, low confidence
; Clips one point of a rink line
;-----------------------------------------------------------------------------
ClipLinePoint:
        push ecx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov edi, edx
        mov ebp, ebx
        mov ebx, dword [str_Punct_DrawRinkSurface]
        mov eax, dword [byte edx+08h]
        mov edx, dword [byte esi+08h]
        mov ecx, dword [byte esi+08h]
        sub eax, edx
        sub ebx, ecx
        mov edx, eax
        lea eax, [byte ebx+01h]
        mov ebx, edx
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        mov ebx, eax
        mov edx, dword [esi]
        mov eax, dword [edi]
        sub eax, edx
        mov edx, ebx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, eax
        mov eax, dword [esi]
        add eax, edx
        mov dword [byte ebp+00h], eax
        mov eax, dword [byte edi+04h]
        mov ecx, dword [byte esi+04h]
        mov edx, ebx
        sub eax, ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, eax
        mov eax, dword [byte esi+04h]
        add eax, edx
        mov dword [byte ebp+04h], eax
        mov ebx, dword [str_Punct_DrawRinkSurface]
        inc ebx
        mov dword [byte ebp+08h], ebx
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ProjectLinePoints                               4CF18  97 PC, low confidence
; Projects the points of a rink line
;-----------------------------------------------------------------------------
ProjectLinePoints:
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov edi, edx
        mov esi, ebx
        mov edx, dword [str_Punct_DrawRinkSurface]
        cmp edx, dword [byte ebx+08h]
        jl short .2
        cmp edx, dword [byte ecx+08h]
        jl short .1
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        ret
.1:
        mov edx, ecx
        mov eax, ebx
        call ClipLinePoint
        mov eax, 1
        mov ebx, ebp
        mov edx, esi
        jmp short .3
.2:
        cmp edx, dword [byte ecx+08h]
        jl short .4
        mov ebx, ecx
        mov edx, esi
        mov eax, ecx
        call ClipLinePoint
        mov eax, 1
        mov ebx, edi
        mov edx, ecx
.3:
        call ProjectPointsToScreen
.4:
        mov eax, 1
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ClipLineSegment                                 4CF74  97 PC, low confidence
; Clips a rink line segment to the view
;-----------------------------------------------------------------------------
ClipLineSegment:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 20h
        mov ebp, eax
        mov esi, edx
        mov edi, ebx
        mov edx, dword [ebx]
        mov ebx, dword [byte ebx+08h]
        xor eax, eax
        cmp edx, ebx
        jle near .2
        mov ebx, dword [byte esi+08h]
        mov edx, dword [esi]
        cmp edx, ebx
        jle short .1
        mov eax, 1
        jmp near .12
.1:
        mov ebx, dword [edi]
        sub ebx, edx
        mov dword [byte esp+08h], ebx
        mov edx, dword [byte esi+08h]
        mov ebx, dword [byte edi+08h]
        sub ebx, edx
        mov ecx, dword [byte esp+08h]
        mov dword [byte esp+04h], ebx
        sub ebx, ecx
        je near .5
        mov eax, dword [esi]
        sub eax, edx
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        mov edx, dword [byte esp+08h]
        mov ebx, eax
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, eax
        mov eax, dword [esi]
        add eax, edx
        mov dword [edi], eax
        mov edx, dword [byte edi+04h]
        mov ecx, dword [byte esi+04h]
        mov eax, ebx
        sub edx, ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, eax
        mov eax, dword [byte esi+04h]
        add eax, edx
        mov edx, dword [byte esp+04h]
        jmp near .4
.2:
        mov edx, dword [edi]
        mov ecx, dword [byte edi+08h]
        neg edx
        cmp edx, ecx
        jle near .5
        mov edx, dword [esi]
        mov ebx, dword [byte esi+08h]
        neg edx
        cmp edx, ebx
        jle short .3
        mov eax, 1
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.3:
        mov ecx, dword [esi]
        mov ebx, dword [edi]
        sub ebx, ecx
        mov edx, dword [byte esi+08h]
        mov dword [byte esp+018h], ebx
        mov ebx, dword [byte edi+08h]
        sub ebx, edx
        mov ecx, dword [byte esp+018h]
        mov dword [byte esp+01Ch], ebx
        neg ebx
        sub ebx, ecx
        je short .5
        mov eax, dword [esi]
        add eax, edx
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        mov edx, dword [byte esp+018h]
        mov ebx, eax
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, eax
        mov eax, dword [esi]
        add eax, edx
        mov dword [edi], eax
        mov edx, dword [byte edi+04h]
        mov ecx, dword [byte esi+04h]
        mov eax, ebx
        sub edx, ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, eax
        mov eax, dword [byte esi+04h]
        add eax, edx
        mov edx, dword [byte esp+01Ch]
.4:
        mov dword [byte edi+04h], eax
        mov eax, ebx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, eax
        mov eax, dword [byte esi+08h]
        add eax, edx
        mov dword [byte edi+08h], eax
        mov eax, 1
.5:
        mov ebx, dword [byte edi+08h]
        mov edx, dword [byte edi+04h]
        cmp edx, ebx
        jle near .7
        mov ebx, dword [byte esi+08h]
        mov edx, dword [byte esi+04h]
        cmp edx, ebx
        jle short .6
        mov eax, 1
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.6:
        mov ebx, dword [byte edi+04h]
        sub ebx, edx
        mov dword [byte esp+014h], ebx
        mov edx, dword [byte esi+08h]
        mov ebx, dword [byte edi+08h]
        sub ebx, edx
        mov ecx, dword [byte esp+014h]
        mov dword [esp], ebx
        sub ebx, ecx
        je near .10
        mov eax, dword [byte esi+04h]
        sub eax, edx
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        mov edx, dword [edi]
        sub edx, dword [esi]
        mov ebx, eax
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, eax
        mov eax, dword [esi]
        add eax, edx
        mov edx, dword [byte esp+014h]
        mov dword [edi], eax
        mov eax, ebx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, eax
        mov eax, dword [byte esi+04h]
        add eax, edx
        mov edx, dword [esp]
        jmp near .9
.7:
        neg edx
        cmp edx, ebx
        jle near .10
        mov edx, dword [byte esi+04h]
        mov ebx, dword [byte esi+08h]
        neg edx
        cmp edx, ebx
        jle short .8
        mov eax, 1
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.8:
        mov ecx, dword [byte esi+04h]
        mov ebx, dword [byte edi+04h]
        sub ebx, ecx
        mov edx, dword [byte esi+08h]
        mov dword [byte esp+010h], ebx
        mov ebx, dword [byte edi+08h]
        sub ebx, edx
        mov ecx, dword [byte esp+010h]
        mov dword [byte esp+0Ch], ebx
        neg ebx
        sub ebx, ecx
        je short .10
        mov eax, dword [byte esi+04h]
        add eax, edx
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        mov edx, dword [edi]
        sub edx, dword [esi]
        mov ebx, eax
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, eax
        mov eax, dword [esi]
        add eax, edx
        mov edx, dword [byte esp+010h]
        mov dword [edi], eax
        mov eax, ebx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, eax
        mov eax, dword [byte esi+04h]
        add eax, edx
        mov edx, dword [byte esp+0Ch]
.9:
        mov dword [byte edi+04h], eax
        mov eax, ebx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, eax
        mov eax, dword [byte esi+08h]
        add eax, edx
        mov dword [byte edi+08h], eax
        mov eax, 1
.10:
        test eax, eax
        je short .11
        mov eax, 1
        mov ebx, ebp
        mov edx, edi
        call ProjectPointsToScreen
.11:
        xor eax, eax
.12:
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LineSegmentLength                               4D230  97 PC, low confidence
; Returns the length of a line segment
;-----------------------------------------------------------------------------
LineSegmentLength:
        push ebx
        push ecx
        push esi
        mov esi, eax
        sar esi, 10h
        sar edx, 10h
        test esi, esi
        jne short .1
        xor eax, eax
        pop esi
        pop ecx
        pop ebx
        ret
.1:
        test edx, edx
        jne short .2
        mov eax, 10000h
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        push edx
        push esi
        call vecdist
        add esp, byte 8
        mov ebx, eax
        mov eax, esi
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawRinkCircle                                  4D27C  97 PC, low confidence
; Draws a circle painted on the ice
;-----------------------------------------------------------------------------
DrawRinkCircle:
        push esi
        push edi
        push ebp
        sub esp, byte 2Ch
        mov ebp, eax
        mov dword [byte esp+028h], ecx
        mov esi, dword [ebx]
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 2
        lea edi, [byte esp+0Ch]
        lea esi, [eax+ebp]
        movsd
        movsd
        movsd
        mov esi, dword [ebx]
        shl esi, 3
        lea edi, [byte esp+020h]
        add esi, edx
        movsd
        movsd
        mov esi, dword [byte ebx+04h]
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 2
        mov edi, esp
        lea esi, [eax+ebp]
        add ebx, byte 4
        movsd
        movsd
        movsd
        mov ecx, esp
        mov esi, dword [ebx]
        lea eax, [byte esp+020h]
        shl esi, 3
        lea edi, [byte esp+018h]
        add esi, edx
        lea ebx, [byte esp+0Ch]
        lea edx, [byte esp+018h]
        movsd
        movsd
        call ProjectLinePoints
        test eax, eax
        je near .5
        lea ebx, [byte esp+0Ch]
        mov edx, esp
        lea eax, [byte esp+020h]
        call ClipLineSegment
        test eax, eax
        jne near .5
        mov ebx, esp
        lea edx, [byte esp+0Ch]
        lea eax, [byte esp+018h]
        call ClipLineSegment
        test eax, eax
        jne near .5
        mov eax, dword [byte esp+08h]
        cmp eax, dword [str_Punct_DrawRinkSurface]
        jg short .1
        xor eax, eax
        jmp short .2
.1:
        fild dword [byte esp+03Ch]
        sub esp, byte 4
        fstp dword [esp]
        fild dword [byte esp+0Ch]
        sub esp, byte 4
        fstp dword [esp]
        call ProjectCoordInt
.2:
        mov ecx, dword [RinkLineWidth]
        mov ebx, eax
        test ecx, ecx
        jne short .4
        mov edx, dword [byte esp+024h]
        mov esi, dword [byte esp+01Ch]
        mov eax, dword [byte esp+020h]
        mov edi, dword [byte esp+018h]
        sub edx, esi
        sub eax, edi
        call LineSegmentLength
        test eax, eax
        jge short .3
        neg eax
.3:
        mov edx, 10000h
        sar eax, 1
        sub edx, eax
        mov eax, ebx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov ebx, eax
.4:
        push ebx
        push ebx
        mov ebp, dword [byte esp+030h]
        push ebp
        mov eax, dword [byte esp+028h]
        push eax
        mov edx, dword [byte esp+028h]
        push edx
        mov ebx, dword [byte esp+038h]
        push ebx
        mov ecx, dword [byte esp+038h]
        push ecx
        call DrawFixedLine
        add esp, byte 1Ch
.5:
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; DrawRinkLine                                    4D3B4  97 PC, low confidence
; Draws a line painted on the ice
;-----------------------------------------------------------------------------
DrawRinkLine:
        push esi
        push edi
        push ebp
        sub esp, byte 2Ch
        mov ebp, eax
        mov dword [byte esp+028h], ecx
        mov ecx, dword [ebx]
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        shl eax, 2
        lea edi, [byte esp+0Ch]
        lea esi, [eax+ebp]
        movsd
        movsd
        movsd
        mov esi, dword [ebx]
        shl esi, 3
        lea edi, [byte esp+018h]
        add esi, edx
        movsd
        movsd
        mov ecx, dword [byte ebx+04h]
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        shl eax, 2
        mov edi, esp
        lea esi, [eax+ebp]
        add ebx, byte 4
        movsd
        movsd
        movsd
        mov ecx, esp
        mov esi, dword [ebx]
        lea eax, [byte esp+018h]
        shl esi, 3
        lea edi, [byte esp+020h]
        add esi, edx
        lea ebx, [byte esp+0Ch]
        lea edx, [byte esp+020h]
        movsd
        movsd
        call ProjectLinePoints
        test eax, eax
        je near .7
        lea ebx, [byte esp+0Ch]
        mov edx, esp
        lea eax, [byte esp+018h]
        call ClipLineSegment
        test eax, eax
        jne near .7
        mov ebx, esp
        lea edx, [byte esp+0Ch]
        lea eax, [byte esp+020h]
        call ClipLineSegment
        test eax, eax
        jne near .7
        mov eax, dword [byte esp+014h]
        cmp eax, dword [str_Punct_DrawRinkSurface]
        jg short .1
        xor eax, eax
        jmp short .2
.1:
        fild dword [byte esp+03Ch]
        sub esp, byte 4
        fstp dword [esp]
        fild dword [byte esp+018h]
        sub esp, byte 4
        fstp dword [esp]
        call ProjectCoordInt
.2:
        mov ecx, dword [str_Punct_DrawRinkSurface]
        mov ebx, eax
        cmp ecx, dword [byte esp+08h]
        jl short .3
        xor eax, eax
        jmp short .4
.3:
        fild dword [byte esp+03Ch]
        sub esp, byte 4
        fstp dword [esp]
        fild dword [byte esp+0Ch]
        sub esp, byte 4
        fstp dword [esp]
        call ProjectCoordInt
.4:
        mov esi, dword [RinkLineWidth]
        mov ecx, eax
        test esi, esi
        jne short .6
        mov edx, dword [byte esp+01Ch]
        mov edi, dword [byte esp+024h]
        mov eax, dword [byte esp+018h]
        mov ebp, dword [byte esp+020h]
        sub edx, edi
        sub eax, ebp
        call LineSegmentLength
        mov edx, eax
        test eax, eax
        jge short .5
        neg edx
.5:
        mov eax, edx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov esi, 10000h
        sub esi, eax
        mov edx, esi
        mov eax, ebx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov ebx, eax
        mov edx, esi
        mov eax, ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov ecx, eax
.6:
        push ecx
        push ebx
        mov eax, dword [byte esp+030h]
        push eax
        mov edx, dword [byte esp+030h]
        push edx
        mov ebx, dword [byte esp+030h]
        push ebx
        mov ecx, dword [byte esp+030h]
        push ecx
        mov esi, dword [byte esp+030h]
        push esi
        call DrawFixedLine
        add esp, byte 1Ch
.7:
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ScaleLineWidth                                  4D534  97 PC, low confidence
; Scales a line width by distance
;-----------------------------------------------------------------------------
ScaleLineWidth:
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 2Ch
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov dword [byte esp+010h], ecx
        fild dword [byte ebx+08h]
        fld1
        fdivrp
        mov ecx, dword [str_Punct_DrawRinkSurface]
        mov eax, dword [byte ebx+08h]
        fstp dword [byte esp+014h]
        cmp eax, ecx
        jg short .1
        xor eax, eax
        jmp near .6
.1:
        mov eax, dword [byte esp+010h]
        cmp eax, dword [byte ebx+08h]
        jle short .2
        mov dword [byte esp+020h], 3F800000h
        jmp short .3
.2:
        fild dword [byte esp+010h]
        fmul dword [byte esp+014h]
        fstp dword [byte esp+020h]
.3:
        mov eax, dword [byte edx+04h]
        sub eax, dword [byte esi+04h]
        mov ecx, dword [esi]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [edx]
        sub eax, ecx
        mov dword [byte esp+08h], eax
        fild dword [byte esp+08h]
        fild dword [byte esp+0Ch]
        call IF@ATAN2
        fsin
        fabs
        fild dword [byte ebp+0Ch]
        fmul dword [ProjDetailScale]
        fmul dword [byte esp+014h]
        fld1
        fld dword [byte esp+020h]
        fxch
        fsub st1
        fxch st3
        fstp dword [byte esp+024h]
        fxch st2
        fmul dword [byte esp+024h]
        mov esi, dword [RinkLineWidth]
        faddp st2
        fstp dword [byte esp+028h]
        fstp dword [byte esp+018h]
        test esi, esi
        jne short .4
        fld1
        fadd dword [byte esp+024h]
        fmul qword [F64_0p5_ScaleLineWidth]
        fmul dword [byte esp+028h]
        fstp dword [byte esp+028h]
.4:
        fld dword [byte esp+028h]
        fmul dword [byte esp+018h]
        fst dword [byte esp+01Ch]
        fmul dword [F32_65536_ScaleLineWidth]
        push eax
        fistp dword [esp]
        pop eax
        test eax, eax
        jge short .5
        xor eax, eax
        mov esp, ebp
        pop ebp
        pop esi
        ret 4
.5:
        fld dword [byte esp+01Ch]
        fmul dword [F32_65536_ScaleLineWidth]
        push eax
        fistp dword [esp]
        pop eax
.6:
        mov esp, ebp
        pop ebp
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; SetLineWidth                                    4D62C  97 PC, low confidence
; Sets the width of the next rink line
;-----------------------------------------------------------------------------
SetLineWidth:
        push edi
        mov edi, dword [str_Punct_DrawRinkSurface]
        cmp edi, dword [byte ebx+08h]
        jl short .1
        xor eax, eax
        pop edi
        ret 8
.1:
        cmp edi, dword [byte ecx+08h]
        jl short .2
        xor eax, eax
        pop edi
        ret 8
.2:
        mov ecx, dword [byte esp+0Ch]
        push ecx
        mov ecx, dword [byte esp+0Ch]
        call ScaleLineWidth
        pop edi
        ret 8
        db 090h
;-----------------------------------------------------------------------------
; DrawRinkArc                                     4D65C  97 PC, low confidence
; Draws an arc painted on the ice
;-----------------------------------------------------------------------------
DrawRinkArc:
        push esi
        push edi
        push ebp
        sub esp, byte 2Ch
        mov dword [byte esp+028h], eax
        mov ebp, ecx
        mov esi, dword [ebx]
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        mov esi, dword [byte esp+028h]
        shl eax, 2
        lea edi, [byte esp+0Ch]
        add esi, eax
        movsd
        movsd
        movsd
        mov esi, dword [ebx]
        shl esi, 3
        lea edi, [byte esp+020h]
        add esi, edx
        movsd
        movsd
        mov esi, dword [byte ebx+04h]
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        mov esi, dword [byte esp+028h]
        shl eax, 2
        mov edi, esp
        add esi, eax
        add ebx, byte 4
        movsd
        movsd
        movsd
        mov ecx, esp
        mov esi, dword [ebx]
        lea eax, [byte esp+020h]
        shl esi, 3
        lea edi, [byte esp+018h]
        add esi, edx
        lea ebx, [byte esp+0Ch]
        lea edx, [byte esp+018h]
        movsd
        movsd
        call ProjectLinePoints
        test eax, eax
        je near .1
        mov ebx, esp
        lea edx, [byte esp+0Ch]
        lea eax, [byte esp+018h]
        call ClipLineSegment
        test eax, eax
        jne short .1
        lea ebx, [byte esp+0Ch]
        mov edx, esp
        lea eax, [byte esp+020h]
        call ClipLineSegment
        test eax, eax
        jne short .1
        mov edx, dword [byte esp+040h]
        lea ebx, [byte esp+0Ch]
        lea eax, [byte esp+020h]
        push edx
        mov ecx, ebp
        lea edx, [byte esp+01Ch]
        call ScaleLineWidth
        mov ebx, dword [byte esp+040h]
        lea edx, [byte esp+018h]
        mov esi, eax
        mov ecx, ebp
        push ebx
        lea eax, [byte esp+024h]
        lea ebx, [byte esp+04h]
        call ScaleLineWidth
        push eax
        push esi
        mov ecx, dword [byte esp+044h]
        push ecx
        mov esi, dword [byte esp+028h]
        push esi
        mov edi, dword [byte esp+028h]
        push edi
        mov ebp, dword [byte esp+038h]
        push ebp
        mov eax, dword [byte esp+038h]
        push eax
        call DrawFixedLine
        add esp, byte 1Ch
.1:
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        ret 8
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawFaceoffDot                                  4D75C  97 PC, low confidence
; Draws a faceoff dot
;-----------------------------------------------------------------------------
DrawFaceoffDot:
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ebp, eax
        mov edi, edx
        mov dword [byte esp+04h], ebx
        mov ebx, ecx
        mov edx, dword [byte esp+04h]
        xor esi, esi
        test edx, edx
        jle near .3
.1:
        mov edx, dword [ebx]
        imul eax, edx, byte 0Ch
        mov ecx, dword [str_Punct_DrawRinkSurface]
        cmp ecx, dword [byte eax+ebp+08h]
        jge short .2
        imul eax, dword [byte ebx+04h], byte 0Ch
        shl edx, 3
        mov ecx, dword [str_Punct_DrawRinkSurface]
        mov eax, dword [byte eax+ebp+08h]
        add edx, edi
        cmp eax, ecx
        jle short .2
        mov eax, dword [byte ebx+04h]
        lea ecx, [nosplit eax*4+00h]
        mov dword [esp], ecx
        mov ecx, dword [byte esp+01Ch]
        add ecx, dword [esp]
        push byte 0
        push dword [ecx]
        mov ecx, dword [ebx]
        shl ecx, 2
        mov dword [byte esp+08h], ecx
        mov ecx, dword [byte esp+024h]
        add ecx, dword [byte esp+08h]
        push dword [ecx]
        mov ecx, dword [byte esp+024h]
        push ecx
        mov ecx, dword [byte edi+eax*8+04h]
        push ecx
        mov ecx, dword [edi+eax*8]
        push ecx
        mov eax, dword [byte edx+04h]
        push eax
        mov ecx, dword [edx]
        push ecx
        call DrawEllipseSpans
        add esp, byte 20h
.2:
        mov ecx, dword [byte esp+04h]
        inc esi
        add ebx, byte 8
        cmp esi, ecx
        jl short .1
.3:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret 8
        db 090h
;-----------------------------------------------------------------------------
; DrawLineSegment                                 4D800  97 PC, low confidence
; Draws a line segment
;-----------------------------------------------------------------------------
DrawLineSegment:
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ebp, eax
        mov edi, edx
        mov dword [byte esp+04h], ebx
        mov ebx, ecx
        mov edx, dword [byte esp+04h]
        xor esi, esi
        test edx, edx
        jle near .3
.1:
        mov edx, dword [ebx]
        imul eax, edx, byte 0Ch
        mov ecx, dword [str_Punct_DrawRinkSurface]
        cmp ecx, dword [byte eax+ebp+08h]
        jge short .2
        lea eax, [nosplit edx*8+00h]
        imul edx, dword [byte ebx+04h], byte 0Ch
        mov ecx, dword [str_Punct_DrawRinkSurface]
        mov edx, dword [byte edx+ebp+08h]
        add eax, edi
        cmp edx, ecx
        jle short .2
        mov edx, dword [byte ebx+04h]
        lea ecx, [nosplit edx*4+00h]
        mov dword [esp], ecx
        mov ecx, dword [byte esp+01Ch]
        add ecx, dword [esp]
        push dword [ecx]
        mov ecx, dword [ebx]
        shl ecx, 2
        mov dword [byte esp+04h], ecx
        mov ecx, dword [byte esp+020h]
        add ecx, dword [byte esp+04h]
        push dword [ecx]
        mov ecx, dword [byte esp+020h]
        push ecx
        mov ecx, dword [byte edi+edx*8+04h]
        push ecx
        mov ecx, dword [edi+edx*8]
        push ecx
        mov edx, dword [byte eax+04h]
        push edx
        mov ecx, dword [eax]
        push ecx
        call DrawFixedLine
        add esp, byte 1Ch
.2:
        mov ecx, dword [byte esp+04h]
        inc esi
        add ebx, byte 8
        cmp esi, ecx
        jl short .1
.3:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret 8
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetNetPositions                                 4D8A8  97 PC, low confidence
; Sets the positions of the nets
;-----------------------------------------------------------------------------
SetNetPositions:
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov esi, eax
        mov dword [esp], edx
        mov edi, ebx
        mov dword [byte esp+04h], ecx
        xor ebx, ebx
        test edi, edi
        jle short .4
        mov edx, ecx
.1:
        imul eax, dword [edx], byte 0Ch
        add eax, esi
        mov ebp, dword [str_Punct_DrawRinkSurface]
        cmp ebp, dword [byte eax+08h]
        jge short .5
        mov ecx, dword [eax]
        test ecx, ecx
        jge short .2
        mov eax, ecx
        neg eax
        jmp short .3
.2:
        mov eax, ecx
.3:
        imul ecx, dword [edx], byte 0Ch
        cmp eax, dword [byte ecx+esi+08h]
        jg short .5
        inc ebx
        add edx, byte 4
        cmp ebx, edi
        jl short .1
.4:
        mov ecx, dword [byte esp+018h]
        mov ebx, dword [byte esp+04h]
        mov eax, dword [esp]
        mov edx, edi
        call BuildNetGeometry
.5:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret 4
        db 090h
        push edx
        xor edx, edx
        mov dword [NetX], edx
        mov dword [NetZ], edx
        mov dword [NetShadowY], edx
        mov dword [NetShadowH], edx
        mov dword [NetShadowZ], edx
        mov dword [NetShadowW], edx
        mov dword [NetShadowX], edx
        mov dword [NetShadowD], edx
        mov dword [NetY], edx
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawNets                                        4D948  97 PC, low confidence
; Draws the nets
;-----------------------------------------------------------------------------
DrawNets:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 120h
        mov edi, eax
        mov dword [dword esp+011Ch], edx
        mov eax, dword [str_Punct_DrawRinkSurface]
        add eax, byte 50h
        mov dword [dword esp+0118h], eax
        fild dword [dword esp+0118h]
        fcomp dword [byte edi+08h]
        fnstsw ax
        sahf
        jae near .7
        mov edx, dword [byte edi+08h]
        cmp edx, 459C4000h
        jle short .2
        mov ebx, dword [NetZ]
        mov ebp, NetGeometry+4C8h
        test ebx, ebx
        jne short .1
        mov ebx, CameraStateRecords+253h
        mov edx, NetGeometry+480h
        mov eax, 6
        mov ecx, ebp
        call TransformVecs
        mov dword [NetZ], 1
.1:
        mov esi, 6
        jmp near .6
.2:
        cmp edx, 451C4000h
        jle short .4
        mov eax, dword [NetX]
        mov ebp, NetGeometry+5B8h
        test eax, eax
        jne short .3
        mov ebx, CameraStateRecords+253h
        mov edx, NetGeometry+630h
        mov eax, 0Ah
        mov ecx, ebp
        call TransformVecs
        mov dword [NetX], 1
.3:
        mov esi, 0Ah
        jmp short .6
.4:
        mov ecx, dword [NetY]
        mov ebp, NetGeometry+510h
        test ecx, ecx
        jne short .5
        mov ebx, CameraStateRecords+253h
        mov edx, NetGeometry+6A8h
        mov eax, 0Eh
        mov ecx, ebp
        mov esi, 1
        call TransformVecs
        mov dword [NetY], esi
.5:
        mov esi, 0Eh
.6:
        mov ecx, esp
        mov ebx, edi
        mov edx, ebp
        mov eax, esi
        call AddVecs
        lea ebx, [dword esp+0A8h]
        mov edx, esp
        mov eax, esi
        mov edi, dword [dword esp+011Ch]
        call ProjectPoints
        test edi, edi
        setl al
        and eax, 0FFh
        push eax
        push byte 0FFFFFFFFh
        lea eax, [dword esp+0B0h]
        push eax
        push esi
        push edi
        call FillPolygon
        add esp, byte 14h
.7:
        add esp, 120h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawNetShadows                                  4DA84  97 PC, low confidence
; Draws the shadows of the nets
;-----------------------------------------------------------------------------
DrawNetShadows:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 120h
        mov edi, eax
        mov dword [dword esp+011Ch], edx
        mov eax, dword [str_Punct_DrawRinkSurface]
        add eax, byte 6Eh
        mov dword [dword esp+0118h], eax
        fild dword [dword esp+0118h]
        fcomp dword [byte edi+08h]
        fnstsw ax
        sahf
        jae near .7
        mov edx, dword [byte edi+08h]
        cmp edx, 459C4000h
        jle short .2
        mov ebx, dword [NetShadowZ]
        mov ebp, NetGeometry
        test ebx, ebx
        jne short .1
        mov ebx, CameraStateRecords+253h
        mov edx, NetGeometry+138h
        mov eax, 6
        mov ecx, ebp
        call TransformVecs
        mov dword [NetShadowZ], 1
.1:
        mov esi, 6
        jmp near .6
.2:
        cmp edx, 451C4000h
        jle short .4
        mov eax, dword [NetShadowH]
        mov ebp, NetGeometry+0C0h
        test eax, eax
        jne short .3
        mov ebx, CameraStateRecords+253h
        mov edx, NetGeometry+48h
        mov eax, 0Ah
        mov ecx, ebp
        call TransformVecs
        mov dword [NetShadowH], 1
.3:
        mov esi, 0Ah
        jmp short .6
.4:
        mov ecx, dword [NetShadowY]
        mov ebp, NetGeometry+288h
        test ecx, ecx
        jne short .5
        mov ebx, CameraStateRecords+253h
        mov edx, NetGeometry+3D8h
        mov eax, 0Eh
        mov ecx, ebp
        mov esi, 1
        call TransformVecs
        mov dword [NetShadowY], esi
.5:
        mov esi, 0Eh
.6:
        mov ecx, esp
        mov ebx, edi
        mov edx, ebp
        mov eax, esi
        call AddVecs
        lea ebx, [dword esp+0A8h]
        mov edx, esp
        mov eax, esi
        mov edi, dword [dword esp+011Ch]
        call ProjectPoints
        test edi, edi
        setl al
        and eax, 0FFh
        push eax
        push byte 0FFFFFFFFh
        lea eax, [dword esp+0B0h]
        push eax
        push esi
        push edi
        call FillPolygon
        add esp, byte 14h
.7:
        add esp, 120h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 0A8h
        mov edi, eax
        mov dword [dword esp+0A4h], edx
        mov eax, dword [str_Punct_DrawRinkSurface]
        add eax, byte 28h
        mov dword [dword esp+0A0h], eax
        fild dword [dword esp+0A0h]
        fcomp dword [byte edi+08h]
        fnstsw ax
        sahf
        jae near .11
        mov edx, dword [byte edi+08h]
        cmp edx, 459C4000h
        jle short .8
        mov esi, 4
        mov ecx, dword [NetShadowD]
        mov ebp, NetGeometry+3A8h
        test ecx, ecx
        jne near .10
        mov ebx, CameraStateRecords+253h
        mov edx, NetGeometry+330h
        mov ecx, ebp
        mov eax, esi
        call TransformVecs
        mov dword [NetShadowD], 1
        jmp short .10
.8:
        cmp edx, 451C4000h
        jle short .9
        mov esi, 6
        mov edx, dword [NetShadowX]
        mov ebp, NetGeometry+360h
        test edx, edx
        jne short .10
        mov ebx, CameraStateRecords+253h
        mov edx, NetGeometry+180h
        mov ecx, ebp
        mov eax, esi
        call TransformVecs
        mov dword [NetShadowX], 1
        jmp short .10
.9:
        mov esi, 8
        mov ecx, dword [NetShadowW]
        mov ebp, NetGeometry+228h
        test ecx, ecx
        jne short .10
        mov ebx, CameraStateRecords+253h
        mov edx, NetGeometry+1C8h
        mov ecx, ebp
        mov eax, esi
        call TransformVecs
        mov dword [NetShadowW], 1
.10:
        mov ecx, esp
        mov ebx, edi
        mov edx, ebp
        mov eax, esi
        call AddVecs
        lea ebx, [byte esp+060h]
        mov edx, esp
        mov eax, esi
        call ProjectPoints
        mov edx, dword [dword esp+0A4h]
        test edx, edx
        setl al
        and eax, 0FFh
        push eax
        push byte 0FFFFFFFFh
        lea eax, [byte esp+068h]
        push eax
        push esi
        push edx
        call FillPolygon
        add esp, byte 14h
.11:
        add esp, 0A8h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawNetsHook                                    4DCF0  97 PC, low confidence
; Draws the nets for the frame
;-----------------------------------------------------------------------------
DrawNetsHook:
        push edx
        cmp dword [CameraOnPuck], byte 0
        je short .1
        mov edx, 0FFFFFFFFh
        mov eax, NetsHookPos
        call DrawNets
.1:
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; InitRinkProjection                              4DD0C  97 PC, low confidence
; Projects the rink reference points
;-----------------------------------------------------------------------------
InitRinkProjection:
        push ebx
        push edx
        mov ebx, RinkFov
        mov edx, RinkPartModels+120h
        mov eax, ProjectionCenter
        call ProjectRinkPoints
        mov edx, NetsHookPos
        mov eax, ProjectionNear
        xor ebx, ebx
        call ProjectRinkPoints
        mov ebx, RinkViewCenter
        mov edx, RinkFov
        mov eax, 2
        call ScaleFloatsToInts
        xor edx, edx
        fld dword [RinkPartModels+128h]
        mov dword [NetY], edx
        mov dword [NetX], edx
        mov dword [NetZ], edx
        mov dword [NetShadowY], edx
        mov dword [NetShadowH], edx
        mov dword [NetShadowZ], edx
        mov dword [NetShadowW], edx
        mov dword [NetShadowX], edx
        mov dword [NetShadowD], edx
        push eax
        fistp dword [esp]
        pop eax
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PeriodOver                     4DD90  93G hockey93_06.asm, medium confidence
; Line change box reset, gsp+1, gmdir flips; after the 3rd period:
; overtime (gameopts+1 bit 1 = playoffs) or game over (gsp 4) unless tied; then PeriodOver_sp.
;-----------------------------------------------------------------------------
PeriodOver:
        push edx
        xor edx, edx
        mov dword [CameraOnPuck], edx
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; IsCameraOnPuck                                  4DD9C  97 PC, low confidence
; Returns whether the camera follows the puck
;-----------------------------------------------------------------------------
IsCameraOnPuck:
        push edx
        mov edx, 1
        mov dword [CameraModeOn], edx
        mov dword [CameraOnPuck], edx
        pop edx
        ret
;-----------------------------------------------------------------------------
; SetCameraMode                                   4DDB0  97 PC, low confidence
; Sets the camera follow mode
;-----------------------------------------------------------------------------
SetCameraMode:
        mov dword [CameraModeOn], 1
        ret
        db 090h
;-----------------------------------------------------------------------------
; InitRinkView                                    4DDBC  97 PC, low confidence
; Sets up the rink view
;-----------------------------------------------------------------------------
InitRinkView:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 0F8h
        and esp, byte 0FFFFFFF8h
        cmp dword [CameraOnPuck], byte 0
        je near .17
        fild dword [str_Punct_DrawRinkSurface]
        fcomp dword [RinkPartModels+128h]
        fnstsw ax
        sahf
        jae near .17
        cmp dword [ViewDistance], byte 0
        jne short .1
        mov dword [CameraModeOn], 1
.1:
        mov eax, dword [RinkViewWidth]
        sub eax, dword [RinkViewCenter]
        sar eax, 10h
        mov edx, dword [RinkModel]
        mov dword [dword esp+0DCh], eax
        mov eax, dword [RinkViewHeight]
        lea ebx, [dword esp+080h]
        sub eax, edx
        xor esi, esi
        sar eax, 10h
        mov edx, CameraStateRecords+253h
        mov dword [dword esp+0E0h], eax
        mov eax, RinkPartModels+134h
        mov dword [ViewDistance], esi
        call VecMulMat
        fld dword [dword esp+084h]
        fld dword [dword esp+088h]
        fstp qword [dword esp+08Ch]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [dword esp+088h]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fld qword [dword esp+08Ch]
        fxch
        call IF@ATAN2
        fchs
        fadd qword [F64_1p5708_InitRinkView]
        fmul qword [F64_0p31831]
        fmul qword [F64_65536_InitRinkView]
        push eax
        fistp dword [esp]
        pop eax
        mov edx, eax
        mov eax, 11h
        and edx, 0FFFFh
        lea ebx, [dword esp+080h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, RinkPartModels+120h
        mov ecx, dword [nosplit eax*4+RinkViewTable]
        lea eax, [dword esp+080h]
        call VecAdd
        lea edx, [dword esp+094h]
        lea eax, [dword esp+080h]
        call ProjectPointFloat
        fld dword [RinkAspect]
        fsub dword [dword esp+098h]
        fld dword [dword esp+094h]
        fsub dword [RinkFov]
        call IF@ATAN2
        lea edi, [dword esp+0A4h]
        lea esi, [dword esp+0A8h]
        mov ebx, dword [dword esp+0DCh]
        lea eax, [dword esp+09Ch]
        fstp dword [dword esp+09Ch]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        test ebx, ebx
        jge short .2
        mov eax, ebx
        neg eax
        jmp short .3
.2:
        mov eax, ebx
.3:
        cmp eax, byte 28h
        jge short .6
        mov esi, dword [dword esp+0E0h]
        test esi, esi
        jge short .4
        mov eax, esi
        neg eax
        jmp short .5
.4:
        mov eax, esi
.5:
        cmp eax, byte 28h
        jl short .7
.6:
        mov edi, dword [CameraModeOn]
        test edi, edi
        je near .9
.7:
        push dword 3EE66666h
        push dword [RinkPartModels+128h]
        call ProjectCoord
        fstp dword [dword esp+0F0h]
        mov eax, dword [RinkAspect]
        fld dword [dword esp+0F0h]
        mov dword [dword esp+0ACh], eax
        fcomp qword [F64_0p04]
        fnstsw ax
        sahf
        jae short .8
        mov dword [dword esp+0F0h], 3D23D70Ah
.8:
        fld dword [dword esp+0F0h]
        fild word [byte ecx+04h]
        fmul st1
        fild word [byte ecx+06h]
        fmulp st2
        fld st0
        fmul dword [dword esp+0A4h]
        fld st2
        fmul dword [dword esp+0A8h]
        fxch st2
        fmul dword [dword esp+0A8h]
        fxch st3
        fmul dword [dword esp+0A4h]
        fxch st3
        fmul dword [F32_1p0_View]
        fxch st3
        fmul dword [F32_1p0_View]
        fld dword [RinkFov]
        fxch st2
        fstp dword [dword esp+0C4h]
        fxch st2
        fstp dword [dword esp+0C0h]
        fsub dword [dword esp+0C4h]
        fxch st2
        fstp dword [dword esp+0BCh]
        fxch
        fsub dword [dword esp+0C0h]
        fxch
        fstp dword [dword esp+0B8h]
        push eax
        fistp dword [esp]
        pop eax
        fld dword [RinkFov]
        fadd dword [dword esp+0C4h]
        fsub dword [dword esp+0C0h]
        mov dword [byte esp+060h], eax
        push eax
        fistp dword [esp]
        pop eax
        fld dword [RinkFov]
        fadd dword [dword esp+0C4h]
        fadd dword [dword esp+0C0h]
        mov dword [byte esp+068h], eax
        push eax
        fistp dword [esp]
        pop eax
        fld dword [RinkFov]
        fsub dword [dword esp+0C4h]
        fadd dword [dword esp+0C0h]
        mov dword [byte esp+070h], eax
        push eax
        fistp dword [esp]
        pop eax
        fld dword [dword esp+0ACh]
        fsub dword [dword esp+0BCh]
        fst dword [dword esp+0C8h]
        fadd dword [dword esp+0B8h]
        mov dword [byte esp+078h], eax
        push eax
        fistp dword [esp]
        pop eax
        fld dword [dword esp+0ACh]
        fadd dword [dword esp+0BCh]
        fst dword [dword esp+0CCh]
        fadd dword [dword esp+0B8h]
        mov dword [byte esp+064h], eax
        push eax
        fistp dword [esp]
        pop eax
        fld dword [dword esp+0CCh]
        fsub dword [dword esp+0B8h]
        mov dword [byte esp+06Ch], eax
        push eax
        fistp dword [esp]
        pop eax
        fld dword [dword esp+0C8h]
        fsub dword [dword esp+0B8h]
        mov dword [byte esp+074h], eax
        push eax
        fistp dword [esp]
        pop eax
        mov dword [byte esp+07Ch], eax
        lea eax, [byte esp+060h]
        push eax
        push ecx
        call ProjectModelBounds
        add esp, byte 8
        jmp near .16
.9:
        push dword 3F0CCCCDh
        push dword [RinkPartModels+128h]
        call ProjectCoord
        fmul dword [F32_65536_InitRinkView]
        call __CHP
        fistp dword [dword esp+0F4h]
        fild dword [dword esp+0F4h]
        fcomp qword [F64_0p04]
        fnstsw ax
        sahf
        jae short .10
        mov dword [dword esp+0F4h], edi
.10:
        mov edx, dword [dword esp+0F4h]
        lea eax, [nosplit edx*4+00h]
        mov ebx, dword [dword esp+0F4h]
        sub eax, edx
        mov ecx, dword [RinkViewHeight]
        shl eax, 3
        mov esi, dword [RinkViewWidth]
        add edx, eax
        mov eax, ebx
        mov edi, dword [RinkModel]
        shl eax, 4
        sub esi, edx
        sub eax, ebx
        sar esi, 10h
        add ecx, eax
        mov dword [dword esp+0E8h], esi
        mov dword [dword esp+0D8h], ecx
        mov ecx, dword [RinkViewWidth]
        mov ebx, dword [RinkModel]
        add ecx, edx
        sub edi, eax
        mov dword [dword esp+0A0h], ecx
        mov ecx, dword [RinkViewCenter]
        add ebx, eax
        add ecx, edx
        sar ebx, 10h
        mov dword [dword esp+0D0h], ecx
        mov ecx, dword [RinkViewHeight]
        mov esi, dword [dword esp+0A0h]
        sub ecx, eax
        sar esi, 10h
        sar ecx, 10h
        mov eax, dword [RinkViewCenter]
        mov dword [dword esp+0E4h], ecx
        sub eax, edx
        mov ecx, dword [dword esp+0D0h]
        mov dword [dword esp+0D4h], eax
        mov edx, edi
        mov eax, dword [dword esp+0D8h]
        mov edi, dword [dword esp+0D4h]
        sar ecx, 10h
        sar edi, 10h
        sar edx, 10h
        mov dword [dword esp+0ECh], edi
        mov edi, dword [dword esp+0DCh]
        sar eax, 10h
        test edi, edi
        jle near .12
        cmp dword [dword esp+0E0h], byte 0
        jle short .11
        mov edi, dword [dword esp+0ECh]
        push byte 0
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ecx
        mov dword [byte esp+010h], edx
        mov dword [byte esp+014h], esi
        mov dword [byte esp+01Ch], esi
        mov dword [byte esp+020h], eax
        mov dword [byte esp+028h], eax
        push byte 0
        lea eax, [byte esp+08h]
        mov dword [byte esp+034h], ebx
        push eax
        mov edx, dword [dword esp+0F0h]
        mov dword [byte esp+0Ch], edi
        push byte 6
        mov dword [byte esp+024h], edx
        mov edx, dword [dword esp+0F8h]
        push byte 0
        mov dword [byte esp+03Ch], edi
        mov dword [byte esp+034h], edx
        jmp near .15
.11:
        mov edi, dword [dword esp+0ECh]
        push byte 0
        mov dword [byte esp+08h], edx
        mov dword [byte esp+014h], esi
        mov dword [byte esp+01Ch], esi
        mov dword [byte esp+020h], eax
        mov dword [byte esp+024h], ecx
        mov dword [byte esp+028h], ebx
        mov dword [byte esp+030h], ebx
        push byte 0
        lea eax, [byte esp+08h]
        mov edx, dword [dword esp+0F0h]
        push eax
        mov dword [byte esp+0Ch], edi
        mov dword [byte esp+034h], edi
        push byte 6
        mov dword [byte esp+018h], edx
        mov edx, dword [dword esp+0F4h]
        push byte 0
        mov dword [byte esp+020h], edx
        mov dword [byte esp+028h], edx
        jmp near .15
.12:
        cmp dword [dword esp+0E0h], byte 0
        jle short .13
        mov edi, dword [dword esp+0ECh]
        push byte 0
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ecx
        mov dword [byte esp+010h], edx
        mov dword [byte esp+020h], eax
        mov dword [byte esp+028h], eax
        mov dword [byte esp+030h], eax
        push byte 0
        lea eax, [byte esp+08h]
        mov dword [byte esp+018h], ecx
        push eax
        mov dword [byte esp+020h], ebx
        mov dword [byte esp+024h], esi
        push byte 6
        mov edx, dword [dword esp+0F8h]
        mov dword [byte esp+010h], edi
        push byte 0
        mov dword [byte esp+034h], edx
        jmp short .14
.13:
        mov edi, dword [dword esp+0E8h]
        push byte 0
        mov dword [byte esp+0Ch], esi
        mov dword [byte esp+014h], ecx
        mov dword [byte esp+018h], edx
        mov dword [byte esp+01Ch], ecx
        mov dword [byte esp+020h], ebx
        mov dword [byte esp+028h], ebx
        mov dword [byte esp+030h], eax
        mov edx, dword [dword esp+0F0h]
        push byte 0
        lea eax, [byte esp+08h]
        mov dword [byte esp+08h], edi
        push eax
        mov edi, dword [dword esp+0F0h]
        mov dword [byte esp+02Ch], edx
        push byte 6
        mov edx, dword [dword esp+0F8h]
        mov dword [byte esp+014h], edi
        push byte 0
        mov dword [byte esp+020h], edi
.14:
        mov dword [byte esp+03Ch], edx
.15:
        call FillPolygon
        add esp, byte 14h
.16:
        mov edi, RinkViewWidth
        xor edx, edx
        mov esi, RinkViewCenter
        mov dword [CameraModeOn], edx
        movsd
        movsd
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
; UpdateViewDistance                              4E3B0  97 PC, low confidence
; Updates the camera view distance
;-----------------------------------------------------------------------------
UpdateViewDistance:
        push ebx
        push ecx
        push esi
        push edi
        mov ebx, eax
        mov ecx, edx
        mov edx, ProjectionCenter
        call VecDistance
        fcomp dword [F32_600]
        fnstsw ax
        sahf
        jae short .1
        mov dword [CameraModeOn], 1
.1:
        mov esi, 1
        mov edi, ProjectionCenter
        mov dword [ViewDistance], esi
        mov esi, ebx
        movsd
        movsd
        movsd
        mov edi, ProjectionNear
        mov esi, ebx
        movsd
        movsd
        movsd
        xor edi, edi
        mov esi, ecx
        mov dword [ProjectionFar], edi
        mov edi, RinkPartModels+134h
        movsd
        movsd
        movsd
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawStandsRow                                   4E410  97 PC, low confidence
; Draws a row of the stands
;-----------------------------------------------------------------------------
DrawStandsRow:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 0D0h
        mov ebp, eax
        mov dword [dword esp+0CCh], edx
        mov dword [dword esp+0C8h], ebx
        xor ebx, ebx
        xor eax, eax
.1:
        imul ecx, dword [edx], byte 0Ch
        mov esi, dword [TextureDetail]
        lea edi, [esp+ebx]
        add esi, ecx
        movsd
        movsd
        movsd
        add eax, byte 8
        mov esi, dword [edx]
        mov ecx, dword [TexturePageBase]
        shl esi, 3
        lea edi, [byte esp+eax+070h]
        add esi, ecx
        add ebx, byte 0Ch
        add edx, byte 4
        movsd
        movsd
        cmp eax, byte 20h
        jne short .1
        mov edi, dword [dword esp+0C8h]
        push edi
        lea eax, [byte esp+04h]
        push eax
        lea eax, [dword esp+080h]
        push eax
        push ebp
        call DrawTexturedQuad
        add esp, byte 10h
        test eax, eax
        je short .5
        cmp dword [RinkPartModels+38h], byte 0
        je short .4
        xor ebp, ebp
.2:
        mov edx, dword [dword esp+0CCh]
        xor eax, eax
.3:
        imul ebx, dword [edx], byte 0Ch
        mov esi, dword [TextureDetail]
        lea edi, [esp+eax]
        add esi, ebx
        add eax, byte 0Ch
        add edx, byte 4
        movsd
        movsd
        movsd
        cmp eax, byte 30h
        jne short .3
        mov ecx, esp
        mov ebx, 4
        mov edx, dword [dword ebp+RinkTextures]
        mov eax, dword [dword ebp+RinkTextureArt]
        add ebp, byte 4
        call DrawSurfacePolys
        cmp ebp, byte 10h
        jne short .2
.4:
        mov eax, 1
.5:
        add esp, 0D0h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
        push ebx
        push edx
        mov ebx, 0FFFFFFFFh
        mov edx, dword [byte eax+08h]
        mov eax, dword [StandsRowModel]
        call DrawStandsRow
        xor eax, eax
        pop edx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawStandsSection                               4E500  97 PC, low confidence
; Draws a section of the stands
;-----------------------------------------------------------------------------
DrawStandsSection:
        push esi
        push edi
        push ebp
        sub esp, 128h
        mov dword [dword esp+0118h], eax
        mov dword [dword esp+0124h], edx
        mov esi, ebx
        mov dword [dword esp+011Ch], ecx
        mov edx, ebx
        add esi, byte 10h
        xor eax, eax
        xor ebp, ebp
        mov ebx, dword [dword esp+0124h]
        mov dword [dword esp+0120h], esi
.1:
        imul esi, dword [ebx], byte 0Ch
        mov ecx, dword [TextureDetail]
        lea edi, [esp+ebp]
        add esi, ecx
        movsd
        movsd
        movsd
        mov ecx, dword [ebx]
        mov esi, dword [TexturePageBase]
        shl ecx, 3
        lea edi, [byte esp+eax+078h]
        add esi, ecx
        movsd
        movsd
        mov ecx, dword [TextureTileSize]
        mov esi, dword [edx]
        mov ecx, dword [ecx+esi*8]
        shl ecx, 10h
        mov dword [dword esp+eax+0C8h], ecx
        add edx, byte 4
        mov esi, dword [TextureTileSize]
        mov ecx, dword [byte edx-04h]
        add eax, byte 8
        add ebp, byte 0Ch
        mov ecx, dword [byte esi+ecx*8+04h]
        add ebx, byte 4
        shl ecx, 10h
        mov esi, dword [dword esp+0120h]
        mov dword [dword esp+eax+0C4h], ecx
        cmp edx, esi
        jne short .1
        mov edi, dword [dword esp+011Ch]
        push edi
        lea eax, [byte esp+04h]
        push eax
        lea eax, [dword esp+080h]
        push eax
        lea eax, [dword esp+0D4h]
        push eax
        push byte 4
        mov ebp, dword [dword esp+012Ch]
        push ebp
        call DrawTexturedPoly
        add esp, byte 18h
        test eax, eax
        je short .5
        cmp dword [RinkPartModels+38h], byte 0
        je short .4
        xor ebp, ebp
.2:
        mov edx, dword [dword esp+0124h]
        xor eax, eax
.3:
        imul ebx, dword [edx], byte 0Ch
        mov esi, dword [TextureDetail]
        lea edi, [esp+eax]
        add esi, ebx
        add eax, byte 0Ch
        add edx, byte 4
        movsd
        movsd
        movsd
        cmp eax, byte 30h
        jne short .3
        mov ecx, esp
        mov ebx, 4
        mov edx, dword [dword ebp+RinkTextures]
        mov eax, dword [dword ebp+RinkTextureArt]
        add ebp, byte 4
        call DrawSurfacePolys
        cmp ebp, byte 10h
        jne short .2
.4:
        mov eax, 1
.5:
        add esp, 128h
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; DrawStandsEnd                                   4E630  97 PC, low confidence
; Draws the stands at one end
;-----------------------------------------------------------------------------
DrawStandsEnd:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        mov ecx, 1
        mov ebx, dword [byte eax+0Ch]
        mov edx, dword [byte eax+08h]
        mov eax, dword [StandsEndModel]
        call DrawStandsSection
        test eax, eax
        je short .1
        mov eax, dword [byte esi+08h]
        call UpdateCameraFlashes
.1:
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawStandsSide                                  4E660  97 PC, low confidence
; Draws the stands at one side
;-----------------------------------------------------------------------------
DrawStandsSide:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        mov esi, edx
        mov edi, dword [byte edx+08h]
        mov edx, dword [byte edi+08h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, dword [FlashSpots]
        shl eax, 2
        mov edx, dword [byte edx+07Ch]
        mov ebx, dword [byte edi+0Ch]
        lea ebp, [edx+eax]
        lea eax, [nosplit ebx*4+00h]
        add edi, byte 8
        sub eax, ebx
        add edi, byte 4
        shl eax, 2
        lea edi, [edx+eax]
        lea eax, [byte esp+0Ch]
        push eax
        push edi
        push ebp
        call SubVec3
        mov eax, dword [byte ebp+00h]
        add eax, dword [edi]
        add esp, byte 0Ch
        sar eax, 1
        mov ebx, dword [byte edi+04h]
        mov dword [esp], eax
        mov eax, dword [byte ebp+00h]
        add eax, ebx
        mov ecx, dword [byte edi+08h]
        sar eax, 1
        mov edi, dword [byte esp+0Ch]
        mov dword [byte esp+04h], eax
        mov eax, dword [byte ebp+00h]
        push edi
        add eax, ecx
        mov ebp, dword [byte esp+018h]
        sar eax, 1
        push ebp
        mov dword [byte esp+010h], eax
        call AngleOfVector
        add esp, byte 8
        mov ebx, eax
        mov eax, dword [esp]
        push eax
        mov edx, dword [byte esp+0Ch]
        push edx
        call AngleOfVector
        sub ebx, eax
        lea eax, [dword ebx+04000h]
        add esp, byte 8
        cmp eax, 0FFFF8000h
        jge short .1
        add eax, 10000h
        jmp short .2
.1:
        cmp eax, 8000h
        jle short .2
        sub eax, 10000h
.2:
        test eax, eax
        setg dl
        and edx, 0FFh
        mov edi, edx
        jne short .3
        neg eax
.3:
        sar eax, 0Bh
        cmp eax, byte 8
        jle short .4
        mov edx, 10h
        sub edx, eax
        mov eax, edx
.4:
        mov ebp, dword [nosplit eax*4+StandsArt]
        test eax, eax
        jne short .5
        xor edi, edi
.5:
        test edi, edi
        jne short .6
        mov eax, dword [byte esi+08h]
        mov edx, dword [byte eax+04h]
        mov ebx, dword [eax]
        mov ecx, dword [byte eax+04h]
        xor ebx, edx
        mov edx, dword [byte eax+0Ch]
        mov dword [eax], ebx
        xor ecx, ebx
        mov ebx, dword [eax]
        mov dword [byte eax+04h], ecx
        xor ebx, ecx
        mov ecx, dword [byte eax+08h]
        mov dword [eax], ebx
        xor ecx, edx
        mov ebx, dword [byte eax+0Ch]
        mov dword [byte eax+08h], ecx
        xor ebx, ecx
        mov ecx, dword [byte eax+08h]
        mov dword [byte eax+0Ch], ebx
        xor ecx, ebx
        mov dword [byte eax+08h], ecx
.6:
        test byte [byte esi+01h], 10h
        je short .9
        test edi, edi
        je short .7
        mov ecx, 0FFFFFFFFh
        jmp short .8
.7:
        mov ecx, 1
.8:
        mov eax, ebp
        mov ebx, dword [byte esi+0Ch]
        mov edx, dword [byte esi+08h]
        call DrawStandsSection
        jmp short .12
.9:
        test edi, edi
        je short .10
        mov ebx, 0FFFFFFFFh
        jmp short .11
.10:
        mov ebx, 1
.11:
        mov eax, ebp
        mov edx, dword [byte esi+08h]
        call DrawStandsRow
.12:
        mov ecx, eax
        test edi, edi
        jne short .13
        mov eax, dword [byte esi+08h]
        mov edx, dword [byte eax+04h]
        mov edi, dword [eax]
        mov ebp, dword [byte eax+04h]
        xor edi, edx
        mov edx, dword [byte eax+0Ch]
        mov dword [eax], edi
        xor ebp, edi
        mov ebx, dword [eax]
        mov edi, dword [byte eax+08h]
        mov dword [byte eax+04h], ebp
        xor ebx, ebp
        xor edi, edx
        mov dword [eax], ebx
        mov dword [byte eax+08h], edi
        mov ebp, dword [byte eax+0Ch]
        mov ebx, dword [byte eax+08h]
        xor ebp, edi
        xor ebx, ebp
        mov dword [byte eax+0Ch], ebp
        mov dword [byte eax+08h], ebx
.13:
        test ecx, ecx
        je short .14
        mov eax, dword [byte esi+08h]
        call UpdateCameraFlashes
.14:
        xor eax, eax
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawHomeBlueLine                                4E818  97 PC, low confidence
; Draws one blue line
;-----------------------------------------------------------------------------
DrawHomeBlueLine:
        push ebx
        push ecx
        mov ebx, dword [BenchLineModel]
        mov ecx, dword [HomeBlueLineModel]
        push ebx
        mov ebx, dword [byte edx+08h]
        mov edx, dword [dword eax+084h]
        mov eax, dword [byte eax+07Ch]
        call DrawRinkLine
        xor eax, eax
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawAwayBlueLine                                4E840  97 PC, low confidence
; Draws the other blue line
;-----------------------------------------------------------------------------
DrawAwayBlueLine:
        push ebx
        push ecx
        mov ebx, dword [BoardsTopModel]
        mov ecx, dword [AwayBlueLineModel]
        push ebx
        mov ebx, dword [byte edx+08h]
        mov edx, dword [dword eax+084h]
        mov eax, dword [byte eax+07Ch]
        call DrawRinkLine
        xor eax, eax
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawCenterSpots                                 4E868  97 PC, low confidence
; Draws the centre ice marks
;-----------------------------------------------------------------------------
DrawCenterSpots:
        push ebx
        push ecx
        mov ebx, dword [CenterSpotModel]
        push ebx
        mov ecx, dword [FaceoffSpotModel]
        push ecx
        mov ebx, dword [byte edx+08h]
        mov ecx, dword [SpotModelData]
        mov edx, dword [dword eax+084h]
        mov eax, dword [byte eax+07Ch]
        call DrawRinkArc
        xor eax, eax
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawEndSpots                                    4E894  97 PC, low confidence
; Draws the end zone marks
;-----------------------------------------------------------------------------
DrawEndSpots:
        push ebx
        push ecx
        mov ebx, dword [CenterSpotModel]
        push ebx
        mov ecx, dword [EndSpotModels]
        push ecx
        mov ebx, dword [byte edx+08h]
        mov ecx, dword [SpotModelData]
        mov edx, dword [dword eax+084h]
        mov eax, dword [byte eax+07Ch]
        call DrawRinkArc
        xor eax, eax
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawNeutralSpots                                4E8C0  97 PC, low confidence
; Draws the neutral zone marks
;-----------------------------------------------------------------------------
DrawNeutralSpots:
        push ebx
        push ecx
        mov ebx, dword [NeutralSpotModel]
        push ebx
        mov ecx, dword [FaceoffSpotModel]
        push ecx
        mov ebx, dword [byte edx+08h]
        mov ecx, dword [SpotModelData]
        mov edx, dword [dword eax+084h]
        mov eax, dword [byte eax+07Ch]
        call DrawRinkArc
        xor eax, eax
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawCenterCircle                                4E8EC  97 PC, low confidence
; Draws the centre circle
;-----------------------------------------------------------------------------
DrawCenterCircle:
        push ebx
        push ecx
        cmp dword [ShowCenterLogo], byte 0
        je short .1
        mov ecx, dword [CenterCircleModel]
        mov ebx, dword [byte edx+08h]
        push ecx
        mov edx, dword [dword eax+084h]
        mov ecx, dword [RinkPartModels+1A8h]
        mov eax, dword [byte eax+07Ch]
        call DrawRinkCircle
.1:
        xor eax, eax
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
DrawCenterCircle_30:
        push ecx
        cmp dword [ShowCenterLogo], byte 0
        je short .2
        mov ecx, dword [byte edx+08h]
        push ecx
        push byte 4
        call DrawRinkRing
        add esp, byte 8
.2:
        xor eax, eax
        pop ecx
        ret
;-----------------------------------------------------------------------------
; SetRinkLineDetail                               4E938  97 PC, low confidence
; Sets the detail of the rink lines
;-----------------------------------------------------------------------------
SetRinkLineDetail:
        push ebx
        push ecx
        push esi
        push edi
        mov edi, eax
        mov esi, edx
        mov ebx, dword [byte edx+08h]
        push ebx
        push byte 4
        call TransformRinkPoints
        add esp, byte 8
        test eax, eax
        jne short .3
        mov eax, dword [esi]
        mov edx, ebx
        and eax, byte 7
        call SetTextureDetail
        mov edx, eax
        mov eax, dword [esi]
        shl eax, 8
        shr eax, 18h
        cmp edx, 3E8h
        jge short .1
        add eax, byte 2
        jmp short .2
.1:
        cmp edx, 0FA0h
        jge short .2
        inc eax
.2:
        mov edx, eax
        shl eax, 2
        add eax, edx
        mov edx, dword [byte edi+014h]
        push ebx
        mov ebx, dword [byte edx+eax*4+0Ch]
        push ebx
        call DrawRinkLineFlat
        add esp, byte 8
.3:
        xor eax, eax
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawCreaseArc                                   4E9A0  97 PC, low confidence
; Draws the crease arc
;-----------------------------------------------------------------------------
DrawCreaseArc:
        push ebx
        push ecx
        push esi
        mov ebx, eax
        mov ecx, dword [byte edx+08h]
        mov eax, dword [edx]
        mov edx, dword [edx]
        push ecx
        shl edx, 8
        and eax, byte 7
        shr edx, 18h
        push eax
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        mov edx, dword [byte ebx+014h]
        mov esi, dword [byte edx+eax*4+04h]
        push esi
        call DrawRinkFan
        add esp, byte 0Ch
        xor eax, eax
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        mov ebx, dword [CreaseModel]
        mov ecx, dword [CreaseArcModel]
        push ebx
        mov ebx, dword [byte edx+08h]
        mov edx, dword [dword eax+084h]
        mov eax, dword [byte eax+07Ch]
        call DrawRinkCircle
        xor eax, eax
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push edx
        sub esp, byte 10h
        mov edx, eax
        fld dword [byte esp+018h]
        fld st0
        fmul qword [F64_6p28319_DrawCreaseArc]
        fstp st1
        fdiv dword [byte esp+01Ch]
        fst dword [byte esp+018h]
        fld st0
        fsin
        fxch
        fcos
        fld dword [byte esp+020h]
        fxch st2
        fmul st2
        mov dword [byte edx+04h], 0
        fxch
        fmulp st2
        fstp dword [edx]
        fstp dword [byte edx+08h]
        add esp, byte 10h
        pop edx
        ret 0Ch
        db 090h
;-----------------------------------------------------------------------------
; BuildRinkGeometry                               4EA44  97 PC, low confidence
; Builds the rink geometry
;-----------------------------------------------------------------------------
BuildRinkGeometry:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 58h
        and esp, byte 0FFFFFFF8h
        xor edx, edx
        mov ebx, NetGeometry+480h
        mov dword [byte esp+038h], edx
.1:
        fild dword [byte esp+038h]
        fld st0
        fmul qword [F64_6p28319_BuildRinkGeometry]
        fst st1
        fdiv dword [F32_6_BuildRinkGeometry]
        fst st1
        fsin
        fxch
        fcos
        fxch
        fmul qword [F64_80]
        fxch
        fmul qword [F64_80]
        mov ecx, dword [byte esp+038h]
        add ebx, byte 0Ch
        inc ecx
        mov dword [byte ebx-08h], 0
        mov dword [byte esp+038h], ecx
        fxch
        fstp dword [byte ebx-0Ch]
        fstp dword [byte ebx-04h]
        cmp ecx, byte 6
        jl short .1
        xor edi, edi
        mov ebx, NetGeometry+630h
        mov dword [byte esp+054h], edi
.2:
        fild dword [byte esp+054h]
        fld st0
        fmul qword [F64_6p28319_BuildRinkGeometry]
        fst st1
        fdiv dword [F32_10_BuildRinkGeometry]
        fst st1
        fsin
        fxch
        fcos
        fxch
        fmul qword [F64_80]
        fxch
        fmul qword [F64_80]
        add ebx, byte 0Ch
        mov eax, dword [byte esp+054h]
        mov dword [byte ebx-08h], 0
        inc eax
        fxch
        fstp dword [byte ebx-0Ch]
        mov dword [byte esp+054h], eax
        fstp dword [byte ebx-04h]
        cmp eax, byte 0Ah
        jl short .2
        xor ebx, ebx
        mov dword [byte esp+050h], ebx
        mov ebx, NetGeometry+6A8h
.3:
        fild dword [byte esp+050h]
        fld st0
        fmul qword [F64_6p28319_BuildRinkGeometry]
        fst st1
        fdiv dword [F32_14]
        fst st1
        fsin
        fxch
        fcos
        fxch
        fmul qword [F64_80]
        fxch
        fmul qword [F64_80]
        mov ecx, dword [byte esp+050h]
        add ebx, byte 0Ch
        inc ecx
        mov dword [byte ebx-08h], 0
        mov dword [byte esp+050h], ecx
        fxch
        fstp dword [byte ebx-0Ch]
        fstp dword [byte ebx-04h]
        cmp ecx, byte 0Eh
        jl short .3
        xor edi, edi
        mov ebx, NetGeometry+138h
        mov dword [byte esp+04Ch], edi
.4:
        fild dword [byte esp+04Ch]
        fld st0
        fmul qword [F64_6p28319_BuildRinkGeometry]
        fst st1
        fdiv dword [F32_6_BuildRinkGeometry]
        fst st1
        fsin
        fxch
        fcos
        fxch
        fmul qword [F64_110]
        fxch
        fmul qword [F64_110]
        add ebx, byte 0Ch
        mov eax, dword [byte esp+04Ch]
        mov dword [byte ebx-08h], 0
        inc eax
        fxch
        fstp dword [byte ebx-0Ch]
        mov dword [byte esp+04Ch], eax
        fstp dword [byte ebx-04h]
        cmp eax, byte 6
        jl short .4
        xor ebx, ebx
        mov dword [byte esp+040h], ebx
        mov ebx, NetGeometry+48h
.5:
        fild dword [byte esp+040h]
        fld st0
        fmul qword [F64_6p28319_BuildRinkGeometry]
        fst st1
        fdiv dword [F32_10_BuildRinkGeometry]
        fst st1
        fsin
        fxch
        fcos
        fxch
        fmul qword [F64_110]
        fxch
        fmul qword [F64_110]
        mov ecx, dword [byte esp+040h]
        add ebx, byte 0Ch
        inc ecx
        mov dword [byte ebx-08h], 0
        mov dword [byte esp+040h], ecx
        fxch
        fstp dword [byte ebx-0Ch]
        fstp dword [byte ebx-04h]
        cmp ecx, byte 0Ah
        jl short .5
        xor edi, edi
        mov ebx, NetGeometry+3D8h
        mov dword [byte esp+044h], edi
.6:
        fild dword [byte esp+044h]
        fld st0
        fmul qword [F64_6p28319_BuildRinkGeometry]
        fst st1
        fdiv dword [F32_14]
        fst st1
        fsin
        fxch
        fcos
        fxch
        fmul qword [F64_110]
        fxch
        fmul qword [F64_110]
        add ebx, byte 0Ch
        mov eax, dword [byte esp+044h]
        mov dword [byte ebx-08h], 0
        inc eax
        fxch
        fstp dword [byte ebx-0Ch]
        mov dword [byte esp+044h], eax
        fstp dword [byte ebx-04h]
        cmp eax, byte 0Eh
        jl short .6
        xor ebx, ebx
        mov dword [byte esp+03Ch], ebx
        mov ebx, NetGeometry+330h
.7:
        fild dword [byte esp+03Ch]
        fld st0
        fmul qword [F64_6p28319_BuildRinkGeometry]
        fst st1
        fdiv dword [F32_4]
        fst st1
        fsin
        fxch
        fcos
        fxch
        fmul qword [F64_40]
        fxch
        fmul qword [F64_40]
        mov ecx, dword [byte esp+03Ch]
        add ebx, byte 0Ch
        inc ecx
        mov dword [byte ebx-08h], 0
        mov dword [byte esp+03Ch], ecx
        fxch
        fstp dword [byte ebx-0Ch]
        fstp dword [byte ebx-04h]
        cmp ecx, byte 4
        jl short .7
        xor edi, edi
        mov ebx, NetGeometry+180h
        mov dword [byte esp+034h], edi
.8:
        fild dword [byte esp+034h]
        fld st0
        fmul qword [F64_6p28319_BuildRinkGeometry]
        fst st1
        fdiv dword [F32_6_BuildRinkGeometry]
        fst st1
        fsin
        fxch
        fcos
        fxch
        fmul qword [F64_40]
        fxch
        fmul qword [F64_40]
        add ebx, byte 0Ch
        mov eax, dword [byte esp+034h]
        mov dword [byte ebx-08h], 0
        inc eax
        fxch
        fstp dword [byte ebx-0Ch]
        mov dword [byte esp+034h], eax
        fstp dword [byte ebx-04h]
        cmp eax, byte 6
        jl short .8
        xor ebx, ebx
        mov dword [byte esp+048h], ebx
        mov ebx, NetGeometry+1C8h
.9:
        fild dword [byte esp+048h]
        fld st0
        fmul qword [F64_6p28319_BuildRinkGeometry]
        fst st1
        fdiv dword [F32_8]
        fst st1
        fsin
        fxch
        fcos
        fxch
        fmul qword [F64_40]
        fxch
        fmul qword [F64_40]
        mov ecx, dword [byte esp+048h]
        add ebx, byte 0Ch
        inc ecx
        mov dword [byte ebx-08h], 0
        mov dword [byte esp+048h], ecx
        fxch
        fstp dword [byte ebx-0Ch]
        fstp dword [byte ebx-04h]
        cmp ecx, byte 8
        jl short .9
        xor edi, edi
        xor esi, esi
        xor ebx, ebx
        mov dword [byte esp+028h], edi
.10:
        push edi
        call SinInterp
        mov ecx, dword [RinkGeometryModel]
        add esp, byte 4
        mov edx, eax
        mov eax, ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov dword [dword ebx+RinkMarkingGeometry+6F0h], eax
        xor eax, eax
        push edi
        mov dword [dword ebx+RinkMarkingGeometry+6F4h], eax
        call CosInterp
        mov ecx, dword [RinkGeometryModel]
        add esp, byte 4
        mov edx, eax
        mov eax, ecx
        add esi, byte 8
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov dword [dword ebx+RinkMarkingGeometry+6F8h], eax
        mov eax, dword [byte esp+028h]
        add ebx, byte 0Ch
        mov dword [dword esi+RinkMarkingGeometry+868h], eax
        inc eax
        add edi, 800h
        mov dword [byte esp+028h], eax
        mov dword [dword esi+RinkMarkingGeometry+86Ch], eax
        cmp eax, byte 20h
        jl short .10
        xor edx, edx
        xor esi, esi
        xor ebx, ebx
        xor edi, edi
        mov dword [byte esp+024h], edx
        mov dword [RinkGeometryCount], edx
.11:
        push edi
        call SinInterp
        mov ecx, dword [CreasePolyModel]
        add esp, byte 4
        mov edx, eax
        mov eax, ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        xor ecx, ecx
        mov dword [dword ebx+RinkMarkingGeometry+280h], eax
        push edi
        mov dword [dword ebx+RinkMarkingGeometry+284h], ecx
        call CosInterp
        mov ecx, dword [CreasePolyModel]
        add esp, byte 4
        mov edx, eax
        mov eax, ecx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov dword [dword ebx+RinkMarkingGeometry+288h], eax
        mov eax, dword [byte esp+024h]
        add ebx, byte 0Ch
        add edi, 2000h
        mov dword [dword eax+RinkMarkingGeometry], esi
        add eax, byte 4
        inc esi
        mov dword [byte esp+024h], eax
        cmp esi, byte 8
        jl short .11
        mov esi, 4000h
        xor ebx, ebx
.12:
        push esi
        call SinInterp
        mov ecx, dword [RinkGeometryData]
        add esp, byte 4
        mov edx, eax
        mov eax, ecx
        add ebx, byte 0Ch
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        xor edx, edx
        mov dword [dword ebx+RinkGoalLine], eax
        push esi
        mov dword [dword ebx+RinkBlueLine], edx
        call CosInterp
        mov ecx, dword [RinkGeometryData]
        add esp, byte 4
        mov edx, eax
        mov eax, ecx
        add esi, 1000h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov dword [dword ebx+RinkCenterLine], eax
        cmp esi, 0D000h
        jne short .12
        cmp dword [RinkGeometryBuilt], byte 0
        jne short .14
        mov ebx, IceGeometryDef
        lea esi, [byte ebx+060h]
.13:
        push ebx
        push dword 4CCCCh
        push ebx
        call ScaleVec3
        mov ecx, 1
        add esp, byte 0Ch
        add ebx, byte 0Ch
        mov dword [RinkGeometryBuilt], ecx
        cmp ebx, esi
        jne short .13
.14:
        mov esi, 4000h
        xor ebx, ebx
.15:
        push esi
        call SinInterp
        add ebx, byte 0Ch
        mov ecx, dword [RinkGeometryParts]
        add esp, byte 4
        mov edx, eax
        mov eax, ecx
        xor edi, edi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov dword [dword ebx+RinkCorner], eax
        push esi
        mov dword [dword ebx+RinkWidth], edi
        call CosInterp
        mov ecx, dword [RinkGeometryParts]
        add esp, byte 4
        mov edx, eax
        mov eax, ecx
        add esi, 1000h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov dword [dword ebx+RinkLength], eax
        cmp esi, 0D000h
        jne short .15
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
; DrawIceSurface                                  4EF68  97 PC, low confidence
; Draws the ice surface
;-----------------------------------------------------------------------------
DrawIceSurface:
        push ecx
        push edx
        push RinkMarkingGeometry+560h
        push FlashPolys
        push RinkMarkingGeometry+6F0h
        push byte 20h
        call DrawFlatPoly
        add esp, byte 10h
        push RinkMarkingGeometry+400h
        push FlashPolys
        push IceGeometryDef
        push byte 8
        call DrawFlatPoly
        add esp, byte 10h
        push IceLinePolys
        push FlashPolys
        push IceCenterPoly
        push byte 9
        call DrawFlatPoly
        add esp, byte 10h
        push RinkMarkingGeometry+220h
        push FlashPolys
        push IceSurfaceDef
        push byte 8
        call DrawFlatPoly
        add esp, byte 10h
        push RinkMarkingGeometry+3A0h
        push FlashPolys
        push RinkMarkingGeometry+280h
        push byte 8
        call DrawFlatPoly
        add esp, byte 10h
        push BoardLinePolys
        push FlashPolys
        push IceSurfacePolys
        push byte 9
        call DrawFlatPoly
        add esp, byte 10h
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawCreases                                     4F004  97 PC, low confidence
; Draws the creases
;-----------------------------------------------------------------------------
DrawCreases:
        push ebx
        push ecx
        push esi
        mov ebx, eax
        mov esi, edx
        mov edx, dword [str_Punct_DrawRinkSurface]
        mov eax, dword [CreasePolyModel]
        mov ecx, dword [byte ebx+08h]
        add eax, edx
        cmp eax, ecx
        jge short .1
        push RinkMarkingGeometry+340h
        push ebx
        push RinkMarkingGeometry+3A0h
        push byte 8
        mov ebx, RinkMarkingGeometry+1E0h
        call DrawPolyOutline
        mov edx, RinkMarkingGeometry+340h
        add esp, byte 10h
        mov eax, 8
        mov ecx, RinkMarkingGeometry
        call ProjectPointsToScreen
        mov ebx, 8
        push esi
        mov edx, RinkMarkingGeometry+1E0h
        mov eax, RinkMarkingGeometry+340h
        call SetNetPositions
.1:
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawRinkMarkings                                4F068  97 PC, low confidence
; Draws the rink markings
;-----------------------------------------------------------------------------
DrawRinkMarkings:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 0A8h
        mov dword [dword esp+0A4h], eax
        mov dword [dword esp+0A0h], edx
        mov edx, dword [RinkMarkingModel]
        cmp edx, dword [byte eax+08h]
        jg near .11
        push RinkMarkingGeometry+60h
        mov ebx, dword [dword esp+0A8h]
        push ebx
        push RinkMarkingGeometry+560h
        push byte 20h
        call DrawPolyOutline
        add esp, byte 10h
        mov edx, RinkMarkingGeometry+60h
        mov eax, 20h
        call SetStandsClip
        test eax, eax
        jne near .11
        mov ebx, RinkMarkingGeometry+460h
        mov edx, RinkMarkingGeometry+60h
        mov eax, 20h
        call ProjectPointsToScreen
        mov ebx, RinkMarkingGeometry+460h
        mov edx, RinkMarkingGeometry+60h
        mov eax, 20h
        call SetStandsDetail
        test eax, eax
        jne near .11
        mov ebx, RinkMarkingGeometry+60h
        mov eax, RinkMarkingGeometry+460h
        xor ebp, ebp
.1:
        mov ecx, dword [NeutralSpotModel]
        push ecx
        mov esi, dword [SpotModelData]
        lea edi, [byte ebx+0Ch]
        push esi
        lea esi, [byte eax+08h]
        mov ecx, edi
        mov edx, esi
        add ebp, byte 4
        call SetLineWidth
        mov ebx, edi
        mov dword [byte esp+ebp-04h], eax
        mov eax, esi
        cmp ebp, byte 7Ch
        jne short .1
        mov eax, dword [NeutralSpotModel]
        push eax
        mov edx, dword [SpotModelData]
        mov ecx, RinkMarkingGeometry+60h
        push edx
        mov eax, esi
        mov edx, RinkMarkingGeometry+460h
        call SetLineWidth
        mov dword [esp+ebp], eax
        mov eax, esp
        mov ecx, RinkMarkingGeometry+870h
        push eax
        mov ebx, dword [FaceoffSpotModel]
        mov edx, RinkMarkingGeometry+460h
        push ebx
        mov eax, RinkMarkingGeometry+60h
        mov ebx, 20h
        call DrawFaceoffDot
        cmp dword [dword esp+0A0h], byte 0
        je near .11
        push RinkMarkingGeometry+2E0h
        mov esi, dword [dword esp+0A8h]
        push esi
        push RinkMarkingGeometry+400h
        push byte 8
        mov ebx, RinkMarkingGeometry+20h
        call DrawPolyOutline
        add esp, byte 10h
        mov edx, RinkMarkingGeometry+2E0h
        mov eax, 8
        call ProjectPointsToScreen
        mov ecx, dword [SpotModelData]
        mov eax, dword [RinkMarkingGeometry+2E8h]
        mov edi, dword [str_Punct_DrawRinkSurface]
        mov ebx, dword [NeutralSpotModel]
        cmp eax, edi
        jg short .2
        xor ebx, ebx
        jmp short .4
.2:
        cmp edi, dword [RinkMarkingGeometry+2F4h]
        jl short .3
        xor ebx, ebx
        jmp short .4
.3:
        mov edx, RinkMarkingGeometry+28h
        push ebx
        mov eax, RinkMarkingGeometry+20h
        mov ebx, RinkMarkingGeometry+2E0h
        call ScaleLineWidth
        mov ebx, eax
.4:
        xor eax, eax
.5:
        add eax, byte 4
        mov dword [byte esp+eax+07Ch], ebx
        cmp eax, byte 10h
        jne short .5
        mov esi, 4
        mov ecx, dword [SpotModelData]
        mov eax, dword [RinkMarkingGeometry+318h]
        mov edx, dword [str_Punct_DrawRinkSurface]
        mov ebx, dword [NeutralSpotModel]
        cmp eax, edx
        jg short .6
        xor ebx, ebx
        jmp short .8
.6:
        cmp edx, dword [RinkMarkingGeometry+324h]
        jl short .7
        xor ebx, ebx
        jmp short .8
.7:
        mov edx, RinkMarkingGeometry+48h
        push ebx
        mov eax, RinkMarkingGeometry+40h
        mov ebx, RinkMarkingGeometry+310h
        call ScaleLineWidth
        mov ebx, eax
.8:
        cmp esi, byte 8
        jge short .10
        lea eax, [nosplit esi*4+00h]
.9:
        add eax, byte 4
        inc esi
        mov dword [byte esp+eax+07Ch], ebx
        cmp eax, byte 20h
        jl short .9
.10:
        lea eax, [dword esp+080h]
        mov ecx, RinkMarkingDefs
        push eax
        mov ebp, dword [FaceoffSpotModel]
        mov ebx, 4
        push ebp
        mov edx, RinkMarkingGeometry+20h
        mov eax, RinkMarkingGeometry+2E0h
        call DrawLineSegment
.11:
        add esp, 0A8h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawBoardsLines                                 4F294  97 PC, low confidence
; Draws the lines along the boards
;-----------------------------------------------------------------------------
DrawBoardsLines:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 2Ch
        push RinkMarkingGeometry+60h
        push eax
        push BoardLinePolys
        push byte 9
        call DrawPolyOutline
        add esp, byte 10h
        mov edx, RinkMarkingGeometry+60h
        mov eax, 9
        call SetStandsClip
        test eax, eax
        jne near .3
        mov ebx, RinkMarkingGeometry+460h
        mov edx, RinkMarkingGeometry+60h
        mov eax, 9
        call ProjectPointsToScreen
        mov ebx, RinkMarkingGeometry+460h
        mov edx, RinkMarkingGeometry+60h
        mov eax, 9
        call SetStandsDetail
        test eax, eax
        jne near .3
        mov eax, RinkMarkingGeometry+60h
        mov edx, 1Ch
        mov esi, RinkMarkingGeometry+460h
        xor edi, edi
        mov dword [byte esp+028h], edx
.1:
        mov ebx, dword [NeutralSpotModel]
        mov ecx, dword [SpotModelData]
        lea edx, [byte eax+0Ch]
        lea ebp, [byte esi+08h]
        push ebx
        add edi, byte 4
        mov dword [byte esp+028h], edx
        push ecx
        mov ebx, eax
        mov ecx, edx
        mov eax, esi
        mov edx, ebp
        add edi, byte 4
        call SetLineWidth
        mov esi, ebp
        mov dword [byte esp+edi-08h], eax
        add ebp, byte 8
        mov edx, dword [NeutralSpotModel]
        mov eax, dword [byte esp+024h]
        push edx
        mov ebx, dword [SpotModelData]
        lea ecx, [byte eax+0Ch]
        push ebx
        mov edx, ebp
        mov ebx, eax
        mov eax, esi
        mov dword [byte esp+02Ch], ecx
        call SetLineWidth
        mov esi, ebp
        mov dword [byte esp+edi-04h], eax
        mov ebp, dword [byte esp+028h]
        mov eax, dword [byte esp+024h]
        cmp edi, ebp
        jl short .1
.2:
        cmp edi, byte 20h
        jne short .4
        mov edx, dword [NeutralSpotModel]
        push edx
        mov ebx, dword [SpotModelData]
        lea ecx, [byte eax-0Ch]
        push ebx
        lea edx, [byte esi-08h]
        mov ebx, eax
        mov eax, esi
        call SetLineWidth
        mov dword [esp+edi], eax
        mov eax, esp
        mov ebx, 8
        push eax
        mov ecx, dword [FaceoffSpotModel]
        mov edx, RinkMarkingGeometry+460h
        push ecx
        mov eax, RinkMarkingGeometry+60h
        mov ecx, RinkMarkingGeometry+870h
        call DrawLineSegment
.3:
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov ebp, dword [NeutralSpotModel]
        push ebp
        mov edx, dword [SpotModelData]
        push edx
        lea edx, [byte eax+0Ch]
        lea ebp, [byte esi+08h]
        mov dword [byte esp+02Ch], edx
        mov ecx, edx
        mov ebx, eax
        mov edx, ebp
        mov eax, esi
        add edi, byte 4
        call SetLineWidth
        mov esi, ebp
        mov dword [byte esp+edi-04h], eax
        mov eax, dword [byte esp+024h]
        jmp near .2
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawGoalLines                                   4F404  97 PC, low confidence
; Draws the goal lines
;-----------------------------------------------------------------------------
DrawGoalLines:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 0B0h
        mov ebp, eax
        test edx, edx
        je short .3
        mov ebx, RinkMarkingGeometry+60h
        mov esi, IceLinePolys
        xor edi, edi
.1:
        push ebx
        push esi
        push ebp
        inc edi
        add ebx, byte 0Ch
        call SubVec3
        add esi, byte 0Ch
        add esp, byte 0Ch
        cmp edi, byte 9
        jl short .1
        mov esi, RinkMarkingGeometry+220h
        xor edi, edi
.2:
        push ebx
        push esi
        push ebp
        inc edi
        add ebx, byte 0Ch
        call SubVec3
        add esi, byte 0Ch
        add esp, byte 0Ch
        cmp edi, byte 8
        jge short .4
        jmp short .2
.3:
        push RinkMarkingGeometry+60h
        push eax
        push IceLinePolys
        push byte 9
        call DrawPolyOutline
        add esp, byte 10h
        push RinkMarkingGeometry+0CCh
        push ebp
        push RinkMarkingGeometry+220h
        push byte 8
        call DrawPolyOutline
        add esp, byte 10h
.4:
        mov edx, RinkMarkingGeometry+60h
        mov eax, 11h
        call SetStandsClip
        test eax, eax
        jne near .12
        mov ebx, RinkMarkingGeometry+460h
        mov edx, RinkMarkingGeometry+60h
        mov eax, 11h
        call ProjectPointsToScreen
        mov ebx, RinkMarkingGeometry+460h
        mov edx, RinkMarkingGeometry+60h
        mov eax, 11h
        call SetStandsDetail
        test eax, eax
        jne near .12
        mov ebx, RinkMarkingGeometry+60h
        mov edx, 1Ch
        mov eax, RinkMarkingGeometry+460h
        xor esi, esi
        mov dword [dword esp+0ACh], edx
.5:
        mov ecx, dword [NeutralSpotModel]
        push ecx
        mov edi, dword [SpotModelData]
        lea ebp, [byte eax+08h]
        push edi
        lea edi, [byte ebx+0Ch]
        mov edx, ebp
        mov ecx, edi
        add esi, byte 4
        call SetLineWidth
        mov dword [dword esp+esi+084h], eax
        mov ebx, edi
        mov edx, dword [NeutralSpotModel]
        mov ecx, dword [SpotModelData]
        mov eax, ebp
        push edx
        add edi, byte 0Ch
        add ebp, byte 8
        push ecx
        mov edx, ebp
        mov ecx, edi
        add esi, byte 4
        call SetLineWidth
        mov ebx, edi
        mov dword [dword esp+esi+084h], eax
        mov edi, dword [dword esp+0ACh]
        mov eax, ebp
        cmp esi, edi
        jl short .5
.6:
        cmp esi, byte 20h
        jne near .13
        mov ebp, dword [NeutralSpotModel]
        push ebp
        mov edx, dword [SpotModelData]
        push edx
        lea edx, [byte ebx-0Ch]
        lea edi, [byte eax-08h]
        mov ecx, ebx
        mov ebx, edx
        mov edx, eax
        mov eax, edi
        call SetLineWidth
        xor edx, edx
        mov dword [dword esp+esi+088h], eax
        xor ebx, ebx
        mov esi, dword [RinkMarkingGeometry+68h]
        mov ecx, dword [str_Punct_DrawRinkSurface]
        xor eax, eax
        cmp esi, ecx
        jle short .8
        mov ecx, dword [str_Punct_DrawRinkSurface]
.7:
        mov esi, dword [dword eax+RinkMarkingGeometry+460h]
        sar esi, 10h
        add ebx, byte 0Ch
        mov dword [esp+eax], esi
        mov esi, dword [dword eax+RinkMarkingGeometry+464h]
        add eax, byte 8
        sar esi, 10h
        inc edx
        mov dword [byte esp+eax-04h], esi
        cmp eax, byte 48h
        jge short .8
        cmp ecx, dword [dword ebx+RinkMarkingGeometry+68h]
        jl short .7
.8:
        cmp edx, byte 9
        jne short .9
        push byte 0
        push byte 0FFFFFFFFh
        lea eax, [byte esp+08h]
        push eax
        push edx
        mov esi, dword [RinkPartModels+14Ch]
        push esi
        call FillPolygon
        add esp, byte 14h
.9:
        lea eax, [dword esp+088h]
        mov ecx, RinkMarkingGeometry+870h
        push eax
        mov edi, dword [FaceoffSpotModel]
        mov ebx, 8
        push edi
        mov edx, RinkMarkingGeometry+460h
        mov eax, RinkMarkingGeometry+60h
        call DrawLineSegment
        mov ebx, 6Ch
        mov esi, dword [RinkMarkingGeometry+0D4h]
        mov ebp, dword [str_Punct_DrawRinkSurface]
        xor edx, edx
        xor eax, eax
        cmp esi, ebp
        jle short .11
        mov ecx, dword [str_Punct_DrawRinkSurface]
.10:
        mov esi, dword [dword eax+RinkMarkingGeometry+4A8h]
        sar esi, 10h
        add ebx, byte 0Ch
        mov dword [byte esp+eax+048h], esi
        mov esi, dword [dword eax+RinkMarkingGeometry+4ACh]
        add eax, byte 8
        sar esi, 10h
        inc edx
        mov dword [byte esp+eax+044h], esi
        cmp eax, byte 40h
        jge short .11
        cmp ecx, dword [dword ebx+RinkMarkingGeometry+68h]
        jl short .10
.11:
        cmp edx, byte 8
        jne short .12
        push byte 0
        push byte 1
        lea eax, [byte esp+050h]
        push eax
        push edx
        mov esi, dword [RinkPartModels+14Ch]
        push esi
        call FillPolygon
        add esp, byte 14h
.12:
        add esp, 0B0h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.13:
        mov edi, dword [NeutralSpotModel]
        push edi
        mov ebp, dword [SpotModelData]
        push ebp
        lea edi, [byte eax+08h]
        lea ebp, [byte ebx+0Ch]
        mov edx, edi
        mov ecx, ebp
        add esi, byte 4
        call SetLineWidth
        mov ebx, ebp
        mov dword [dword esp+esi+084h], eax
        mov eax, edi
        jmp near .6
