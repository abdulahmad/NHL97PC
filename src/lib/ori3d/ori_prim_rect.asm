; 3D library: PrimRect, PrimRectDebug, PrimTriFlat, PrimTriLitCcw, PrimTriShade and 63 more.
bits 32
%include "hockey.inc"
section s_11320D progbits alloc exec nowrite align=1
extern AddVecs, AllocMemBlock, ClipLeftCol, ClipRight, ClipTopRow, ConvertColor555, CreateBitmapFromBlock, DrawDestBuffer
extern DrawDestOffset, DrawDestPitch, DrawPolyArray, F64_0p1_ScaleModelVerts, F64_1p25_ScaleModelVerts, FillPolygon, FillRectColor, LoadResourceData
extern MakeColor, MatTranspose, memcpy_, ModelFileCount, ModelSetupMode, PartFuncTable, PlotPixel, PlotPixelClipped
extern PrimColor, Random32, ScreenBitsPerPixel, ScreenBuffer, ScreenHeight, str_4db, str_PRIMLIST, strcat_
extern strcpy_, strlen_, strncpy_, strnicmp_, TransformVecs, VecAdd, VecCross, VecCrossUnit
extern VecNormalize, VecScale, VecSub
global PrimRect, PrimRectDebug, PrimRectDebug_30, PrimTriFlat, PrimTriLitCcw, PrimTriShade, PrimTriShadeBlend, PrimTriShadeCcw
global PrimTriDebug, PrimTriDebugCw, PrimTriDebugCcw, CopyTriScreenVerts, TriVertsIfCw, TriVertsIfCcw, CopyTriTexVerts, TriTexVertsIfCw
global TriTexVertsIfCcw, CopyTriShadeVerts, TriShadeVertsIfCw, TriShadeVertsIfCcw, PrimTriTex, PrimTriTexCw, PrimTriTexCcw, PrimTriTexCcw_6C
global PrimTriTexClearCw, PrimTriTexClearCcw, PrimTriTexShade, PrimTriTexShadeCw, PrimTriTexShadeCcw, PrimQuadDebug, PrimQuadDebugCw, PrimQuadDebugCcw
global PrimQuadDebugCcw_80, PrimQuadFlat, PrimQuadLitCcw, PrimQuadShade, PrimQuadShadeCw, PrimQuadShadeBlendCcw, PrimQuadSplit, PrimQuadSplit_EC
global PrimQuadTexCw, PrimQuadTexCcw, PrimQuadTexCcw_6C, PrimQuadTexShadeCw, PrimQuadTexShadeCcw, PrimQuadTexClear, PrimQuadTexClearCw, PrimQuadTexClearCcw
global PrimQuadRandomFill, PrimQuadRandomFillCw, PrimQuadRandomFillCcw, DrawPrimListJumpTable, DrawPrimList, DrawPrimList_A3, DrawPrimList_D6, DrawPrimList_10C
global DrawPrimList_1A6, DrawPrimList_39E, DrawPrimList_401, DrawPrimList_48F, DrawPrimList_53A, DrawPrimList_607, DrawPrimList_65B, DrawPrimList_6FD
global GetModelVertex, TransformModelPartsJumpTable, TransformModelParts, TransformModelParts_5F, TransformModelParts_6C, TransformModelParts_D3, TransformModelParts_DF, TransformModelParts_EA
global TransformModelParts_EF, TransformModelPartsWithJumpTable, TransformModelPartsWith, TransformModelPartsWith_9F, TransformModelPartsWith_BF, TransformModelPartsWith_DD, UpdateModelParts, CallModelPartFuncs
global CallAllPartFuncs, BuildFrameFromPoints, TransformBoneVerts, SkinModelVerts, AttachModelFrame, AttachModelFrame_4C, AttachModel, UpdateModelFrame
global SkinModel, ScaleModelVerts, FixupModelOffsets, LoadModelFile, FindModelPart, ResetMorphVerts, ApplyMorphTarget, PlotPixelRGB
global PlotPixelRGBAt
        db 00h,00h,00h
;-----------------------------------------------------------------------------
; PrimRect                                       113210  97 PC, low confidence
; Model renderer: draws a filled rectangle primitive
;-----------------------------------------------------------------------------
PrimRect:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edx, dword [byte eax+01Ch]
        push edx
        mov edx, dword [byte eax+018h]
        mov ebx, dword [byte edx+04h]
        push ebx
        mov ecx, dword [edx]
        mov eax, dword [byte eax+014h]
        push ecx
        mov esi, dword [byte eax+04h]
        push esi
        mov edi, dword [eax]
        push edi
        call FillRectColor
        add esp, byte 14h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PrimRectDebug                                  11323C  97 PC, low confidence
; Model renderer: draws a rectangle primitive in a random colour (debug view)
;-----------------------------------------------------------------------------
PrimRectDebug:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        call Random32
        push eax
        mov eax, dword [byte ebx+018h]
        mov edx, dword [byte eax+04h]
        push edx
        mov ecx, dword [eax]
        mov eax, dword [byte ebx+014h]
        push ecx
        mov esi, dword [byte eax+04h]
        push esi
        mov edi, dword [eax]
        push edi
        call FillRectColor
        add esp, byte 14h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
PrimRectDebug_30:
        push ecx
        push edx
        push esi
        push edi
        mov esi, dword [byte eax+01Ch]
        lea edi, [byte eax+04h]
        movsd
        movsd
        mov esi, dword [byte eax+020h]
        lea edi, [byte eax+0Ch]
        movsd
        movsd
        mov esi, dword [byte eax+024h]
        lea edi, [byte eax+014h]
        push byte 0
        movsd
        movsd
        push byte 0
        lea esi, [byte eax+04h]
        push esi
        push byte 3
        mov edx, dword [byte eax+028h]
        push edx
        call FillPolygon
        add esp, byte 14h
        pop edi
        pop esi
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PrimTriFlat                                    1132A4  97 PC, low confidence
; Model renderer: draws a flat triangle when it faces the camera
;-----------------------------------------------------------------------------
PrimTriFlat:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        mov esi, dword [byte ebp+01Ch]
        lea edi, [byte ebp+04h]
        movsd
        movsd
        mov esi, dword [byte ebp+020h]
        lea edi, [byte ebp+0Ch]
        push byte 0
        lea edx, [byte ebp+04h]
        movsd
        movsd
        push byte 0FFFFFFFFh
        mov esi, dword [byte ebp+024h]
        lea edi, [byte ebp+014h]
        push edx
        movsd
        movsd
        push byte 3
        mov ecx, dword [byte ebp+028h]
        push ecx
        call FillPolygon
        add esp, byte 14h
.1:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PrimTriLitCcw                                  113324  97 PC, low confidence
; Model renderer: draws a lit triangle when it is wound the other way
; (mirrored model)
;-----------------------------------------------------------------------------
PrimTriLitCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        mov esi, dword [byte ebp+01Ch]
        lea edi, [byte ebp+04h]
        movsd
        movsd
        push edx
        mov esi, dword [byte ebp+020h]
        lea edi, [byte ebp+0Ch]
        push byte 1
        movsd
        movsd
        lea edx, [byte ebp+04h]
        mov esi, dword [byte ebp+024h]
        lea edi, [byte ebp+014h]
        push edx
        movsd
        movsd
        push byte 3
        mov ecx, dword [byte ebp+028h]
        push ecx
        call FillPolygon
        add esp, byte 14h
.1:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimTriShade                                   1133A0  97 PC, low confidence
; Model renderer: draws a shaded triangle from both sides
;-----------------------------------------------------------------------------
PrimTriShade:
        push ecx
        push edx
        push esi
        push edi
        mov esi, dword [byte eax+01Ch]
        lea edi, [byte eax+04h]
        movsd
        movsd
        mov esi, dword [byte eax+020h]
        lea edi, [byte eax+0Ch]
        movsd
        movsd
        mov esi, dword [byte eax+024h]
        lea edi, [byte eax+014h]
        push byte 1
        movsd
        movsd
        push byte 0
        lea esi, [byte eax+04h]
        push esi
        push byte 3
        mov edx, dword [byte eax+028h]
        push edx
        call FillPolygon
        add esp, byte 14h
        pop edi
        pop esi
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PrimTriShadeBlend                              1133D8  97 PC, low confidence
; Model renderer: draws a shaded, blended triangle when it faces the camera
;-----------------------------------------------------------------------------
PrimTriShadeBlend:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        mov esi, dword [byte ebp+01Ch]
        lea edi, [byte ebp+04h]
        movsd
        movsd
        mov esi, dword [byte ebp+020h]
        lea edi, [byte ebp+0Ch]
        push byte 1
        lea edx, [byte ebp+04h]
        movsd
        movsd
        push byte 1
        mov esi, dword [byte ebp+024h]
        lea edi, [byte ebp+014h]
        push edx
        movsd
        movsd
        push byte 3
        mov ecx, dword [byte ebp+028h]
        push ecx
        call FillPolygon
        add esp, byte 14h
.1:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PrimTriShadeCcw                                113458  97 PC, low confidence
; Model renderer: draws a shaded triangle when it is wound the other way
;-----------------------------------------------------------------------------
PrimTriShadeCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        mov esi, dword [byte ebp+01Ch]
        lea edi, [byte ebp+04h]
        movsd
        movsd
        mov esi, dword [byte ebp+020h]
        lea edi, [byte ebp+0Ch]
        push byte 1
        lea edx, [byte ebp+04h]
        movsd
        movsd
        push byte 0FFFFFFFFh
        mov esi, dword [byte ebp+024h]
        lea edi, [byte ebp+014h]
        push edx
        movsd
        movsd
        push byte 3
        mov ecx, dword [byte ebp+028h]
        push ecx
        call FillPolygon
        add esp, byte 14h
.1:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PrimTriDebug                                   1134D8  97 PC, low confidence
; Model renderer: draws a triangle in a random colour (debug view)
;-----------------------------------------------------------------------------
PrimTriDebug:
        push ecx
        push edx
        push esi
        push edi
        mov esi, dword [byte eax+01Ch]
        lea edi, [byte eax+04h]
        movsd
        movsd
        push byte 0
        mov esi, dword [byte eax+020h]
        lea edi, [byte eax+0Ch]
        add eax, byte 4
        push byte 0
        movsd
        movsd
        push eax
        mov esi, dword [byte eax+020h]
        lea edi, [byte eax+010h]
        push byte 3
        movsd
        movsd
        call Random32
        push eax
        call FillPolygon
        add esp, byte 14h
        pop edi
        pop esi
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PrimTriDebugCw                                 113514  97 PC, low confidence
; Model renderer: random-colour triangle when it faces the camera
;-----------------------------------------------------------------------------
PrimTriDebugCw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        mov eax, edi
        call PrimTriDebug
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimTriDebugCcw                                113568  97 PC, low confidence
; Model renderer: random-colour triangle when it is wound the other way
;-----------------------------------------------------------------------------
PrimTriDebugCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        mov eax, edi
        call PrimTriDebug
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CopyTriScreenVerts                             1135BC  97 PC, low confidence
; Model renderer: copies the three projected vertices of a triangle primitive
;-----------------------------------------------------------------------------
CopyTriScreenVerts:
        push esi
        push edi
        lea edi, [byte eax+04h]
        mov esi, dword [byte eax+01Ch]
        movsd
        movsd
        mov esi, dword [byte eax+020h]
        lea edi, [byte eax+0Ch]
        movsd
        movsd
        mov esi, dword [byte eax+024h]
        lea edi, [byte eax+014h]
        movsd
        movsd
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; TriVertsIfCw                                   1135DC  97 PC, low confidence
; Model renderer: copies a triangle's projected vertices when it faces the
; camera
;-----------------------------------------------------------------------------
TriVertsIfCw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        mov eax, edi
        call CopyTriScreenVerts
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; TriVertsIfCcw                                  113630  97 PC, low confidence
; Model renderer: copies a triangle's projected vertices when it is wound the
; other way
;-----------------------------------------------------------------------------
TriVertsIfCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        mov eax, edi
        call CopyTriScreenVerts
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CopyTriTexVerts                                113684  97 PC, low confidence
; Model renderer: copies the three textured vertices of a triangle primitive
;-----------------------------------------------------------------------------
CopyTriTexVerts:
        push esi
        push edi
        lea edi, [byte eax+04h]
        mov esi, dword [byte eax+01Ch]
        movsd
        movsd
        mov esi, dword [byte eax+020h]
        lea edi, [byte eax+0Ch]
        movsd
        movsd
        mov esi, dword [byte eax+024h]
        lea edi, [byte eax+014h]
        movsd
        movsd
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; TriTexVertsIfCw                                1136A4  97 PC, low confidence
; Model renderer: copies a triangle's textured vertices when it faces the
; camera
;-----------------------------------------------------------------------------
TriTexVertsIfCw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        mov eax, edi
        call CopyTriTexVerts
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; TriTexVertsIfCcw                               1136F8  97 PC, low confidence
; Model renderer: copies a triangle's textured vertices when it is wound the
; other way
;-----------------------------------------------------------------------------
TriTexVertsIfCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        mov eax, edi
        call CopyTriTexVerts
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CopyTriShadeVerts                              11374C  97 PC, low confidence
; Model renderer: copies the three shaded vertices of a triangle primitive
;-----------------------------------------------------------------------------
CopyTriShadeVerts:
        push esi
        push edi
        lea edi, [byte eax+04h]
        mov esi, dword [byte eax+01Ch]
        movsd
        movsd
        mov esi, dword [byte eax+020h]
        lea edi, [byte eax+0Ch]
        movsd
        movsd
        mov esi, dword [byte eax+024h]
        lea edi, [byte eax+014h]
        movsd
        movsd
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; TriShadeVertsIfCw                              11376C  97 PC, low confidence
; Model renderer: copies a triangle's shaded vertices when it faces the
; camera
;-----------------------------------------------------------------------------
TriShadeVertsIfCw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        mov eax, edi
        call CopyTriShadeVerts
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; TriShadeVertsIfCcw                             1137C0  97 PC, low confidence
; Model renderer: copies a triangle's shaded vertices when it is wound the
; other way
;-----------------------------------------------------------------------------
TriShadeVertsIfCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        mov eax, edi
        call CopyTriShadeVerts
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimTriTex                                     113814  97 PC, low confidence
; Model renderer: draws a textured triangle from both sides
;-----------------------------------------------------------------------------
PrimTriTex:
        push ecx
        push edx
        push byte 0
        push byte 0
        lea edx, [byte eax+01Ch]
        push edx
        lea edx, [byte eax+028h]
        push edx
        push byte 3
        mov edx, dword [byte eax+040h]
        push edx
        call DrawPolyArray
        add esp, byte 18h
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PrimTriTexCw                                   113834  97 PC, low confidence
; Model renderer: draws a textured triangle when it faces the camera
;-----------------------------------------------------------------------------
PrimTriTexCw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        push byte 0
        mov ecx, dword [PrimColor]
        push ecx
        lea edx, [byte edi+01Ch]
        push edx
        lea edx, [byte edi+028h]
        push edx
        push byte 3
        mov esi, dword [byte edi+040h]
        push esi
        call DrawPolyArray
        add esp, byte 18h
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimTriTexCcw                                  1138A0  97 PC, low confidence
; Model renderer: draws a textured triangle when it is wound the other way
;-----------------------------------------------------------------------------
PrimTriTexCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        push edx
        mov ecx, dword [PrimColor]
        push ecx
        lea edx, [byte edi+01Ch]
        push edx
        lea edx, [byte edi+028h]
        push edx
        push byte 3
        mov esi, dword [byte edi+040h]
        push esi
        call DrawPolyArray
        add esp, byte 18h
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
PrimTriTexCcw_6C:
        push ecx
        push edx
        push byte 1
        push byte 0
        lea edx, [byte eax+01Ch]
        push edx
        lea edx, [byte eax+028h]
        push edx
        push byte 3
        mov edx, dword [byte eax+040h]
        push edx
        call DrawPolyArray
        add esp, byte 18h
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PrimTriTexClearCw                              11392C  97 PC, low confidence
; Model renderer: draws a textured triangle with transparent texels when it
; faces the camera
;-----------------------------------------------------------------------------
PrimTriTexClearCw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        push byte 1
        mov ecx, dword [PrimColor]
        push ecx
        lea edx, [byte edi+01Ch]
        push edx
        lea edx, [byte edi+028h]
        push edx
        push byte 3
        mov esi, dword [byte edi+040h]
        push esi
        call DrawPolyArray
        add esp, byte 18h
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimTriTexClearCcw                             113998  97 PC, low confidence
; Model renderer: draws a textured triangle with transparent texels when it
; is wound the other way
;-----------------------------------------------------------------------------
PrimTriTexClearCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        push byte 1
        mov ecx, dword [PrimColor]
        push ecx
        lea edx, [byte edi+01Ch]
        push edx
        lea edx, [byte edi+028h]
        push edx
        push byte 3
        mov esi, dword [byte edi+040h]
        push esi
        call DrawPolyArray
        add esp, byte 18h
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimTriTexShade                                113A04  97 PC, low confidence
; Model renderer: draws a shaded textured triangle from both sides
;-----------------------------------------------------------------------------
PrimTriTexShade:
        push ecx
        push edx
        push byte 2
        push byte 0
        lea edx, [byte eax+01Ch]
        push edx
        lea edx, [byte eax+028h]
        push edx
        push byte 3
        mov edx, dword [byte eax+040h]
        push edx
        call DrawPolyArray
        add esp, byte 18h
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PrimTriTexShadeCw                              113A24  97 PC, low confidence
; Model renderer: draws a shaded textured triangle when it faces the camera
;-----------------------------------------------------------------------------
PrimTriTexShadeCw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        push byte 2
        mov ecx, dword [PrimColor]
        push ecx
        lea edx, [byte edi+01Ch]
        push edx
        lea edx, [byte edi+028h]
        push edx
        push byte 3
        mov esi, dword [byte edi+040h]
        push esi
        call DrawPolyArray
        add esp, byte 18h
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimTriTexShadeCcw                             113A90  97 PC, low confidence
; Model renderer: draws a shaded textured triangle when it is wound the other
; way
;-----------------------------------------------------------------------------
PrimTriTexShadeCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        push byte 2
        mov ecx, dword [PrimColor]
        push ecx
        lea edx, [byte edi+01Ch]
        push edx
        lea edx, [byte edi+028h]
        push edx
        push byte 3
        mov esi, dword [byte edi+040h]
        push esi
        call DrawPolyArray
        add esp, byte 18h
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimQuadDebug                                  113AFC  97 PC, low confidence
; Model renderer: draws a quad in a random colour (debug view)
;-----------------------------------------------------------------------------
PrimQuadDebug:
        push ecx
        push edx
        push esi
        push edi
        mov esi, dword [byte eax+01Ch]
        lea edi, [byte eax+04h]
        movsd
        movsd
        push byte 0
        mov esi, dword [byte eax+020h]
        lea edi, [byte eax+0Ch]
        add eax, byte 4
        push byte 0
        movsd
        movsd
        push eax
        mov esi, dword [byte eax+020h]
        lea edi, [byte eax+010h]
        push byte 3
        movsd
        movsd
        call Random32
        push eax
        call FillPolygon
        add esp, byte 14h
        pop edi
        pop esi
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PrimQuadDebugCw                                113B38  97 PC, low confidence
; Model renderer: random-colour quad when it faces the camera
;-----------------------------------------------------------------------------
PrimQuadDebugCw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl al
        mov edx, dword [ModelSetupMode]
        and eax, 0FFh
        xor eax, edx
        je short .1
        mov esi, dword [byte ebp+01Ch]
        lea edi, [byte ebp+04h]
        movsd
        movsd
        push byte 0
        mov esi, dword [byte ebp+020h]
        lea edi, [byte ebp+0Ch]
        add ebp, byte 4
        push byte 0FFFFFFFFh
        movsd
        movsd
        push ebp
        mov esi, dword [byte ebp+020h]
        lea edi, [byte ebp+010h]
        push byte 3
        movsd
        movsd
        call Random32
        push eax
        call FillPolygon
        add esp, byte 14h
.1:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PrimQuadDebugCcw                               113BB8  97 PC, low confidence
; Model renderer: random-colour quad when it is wound the other way
;-----------------------------------------------------------------------------
PrimQuadDebugCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov ebx, dword [byte eax+024h]
        mov esi, dword [byte eax+020h]
        mov edx, dword [byte eax+01Ch]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl al
        mov edx, dword [ModelSetupMode]
        and eax, 0FFh
        xor eax, edx
        jne short .1
        mov esi, dword [byte ebp+01Ch]
        lea edi, [byte ebp+04h]
        movsd
        movsd
        push eax
        mov esi, dword [byte ebp+020h]
        lea edi, [byte ebp+0Ch]
        add ebp, byte 4
        push byte 0FFFFFFFFh
        movsd
        movsd
        push ebp
        mov esi, dword [byte ebp+020h]
        lea edi, [byte ebp+010h]
        push byte 3
        movsd
        movsd
        call Random32
        push eax
        call FillPolygon
        add esp, byte 14h
.1:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
PrimQuadDebugCcw_80:
        push ecx
        push edx
        push esi
        push edi
        mov esi, dword [byte eax+024h]
        lea edi, [byte eax+04h]
        movsd
        movsd
        mov esi, dword [byte eax+028h]
        lea edi, [byte eax+0Ch]
        movsd
        movsd
        mov esi, dword [byte eax+02Ch]
        lea edi, [byte eax+014h]
        movsd
        movsd
        mov esi, dword [byte eax+030h]
        lea edi, [byte eax+01Ch]
        push byte 0
        movsd
        movsd
        push byte 0
        lea esi, [byte eax+04h]
        push esi
        push byte 4
        mov edx, dword [byte eax+034h]
        push edx
        call FillPolygon
        add esp, byte 14h
        pop edi
        pop esi
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PrimQuadFlat                                   113C78  97 PC, low confidence
; Model renderer: draws a flat quad when it faces the camera
;-----------------------------------------------------------------------------
PrimQuadFlat:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov edx, dword [byte eax+024h]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        mov esi, dword [byte ebp+024h]
        lea edi, [byte ebp+04h]
        movsd
        movsd
        mov esi, dword [byte ebp+028h]
        lea edi, [byte ebp+0Ch]
        movsd
        movsd
        mov esi, dword [byte ebp+02Ch]
        lea edi, [byte ebp+014h]
        push byte 0
        lea edx, [byte ebp+04h]
        movsd
        movsd
        push byte 0FFFFFFFFh
        mov esi, dword [byte ebp+030h]
        lea edi, [byte ebp+01Ch]
        push edx
        movsd
        movsd
        push byte 4
        mov ecx, dword [byte ebp+034h]
        push ecx
        call FillPolygon
        add esp, byte 14h
.1:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PrimQuadLitCcw                                 113D00  97 PC, low confidence
; Model renderer: draws a lit quad when it is wound the other way
;-----------------------------------------------------------------------------
PrimQuadLitCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov edx, dword [byte eax+024h]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        mov esi, dword [byte ebp+024h]
        lea edi, [byte ebp+04h]
        movsd
        movsd
        mov esi, dword [byte ebp+028h]
        lea edi, [byte ebp+0Ch]
        movsd
        movsd
        push edx
        mov esi, dword [byte ebp+02Ch]
        lea edi, [byte ebp+014h]
        push byte 1
        movsd
        movsd
        lea edx, [byte ebp+04h]
        mov esi, dword [byte ebp+030h]
        lea edi, [byte ebp+01Ch]
        push edx
        movsd
        movsd
        push byte 4
        mov ecx, dword [byte ebp+034h]
        push ecx
        call FillPolygon
        add esp, byte 14h
.1:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimQuadShade                                  113D84  97 PC, low confidence
; Model renderer: draws a shaded quad from both sides
;-----------------------------------------------------------------------------
PrimQuadShade:
        push ecx
        push edx
        push esi
        push edi
        mov esi, dword [byte eax+024h]
        lea edi, [byte eax+04h]
        movsd
        movsd
        mov esi, dword [byte eax+028h]
        lea edi, [byte eax+0Ch]
        movsd
        movsd
        mov esi, dword [byte eax+02Ch]
        lea edi, [byte eax+014h]
        movsd
        movsd
        mov esi, dword [byte eax+030h]
        lea edi, [byte eax+01Ch]
        push byte 1
        movsd
        movsd
        push byte 0
        lea esi, [byte eax+04h]
        push esi
        push byte 4
        mov edx, dword [byte eax+034h]
        push edx
        call FillPolygon
        add esp, byte 14h
        pop edi
        pop esi
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PrimQuadShadeCw                                113DC4  97 PC, low confidence
; Model renderer: draws a shaded quad when it faces the camera
;-----------------------------------------------------------------------------
PrimQuadShadeCw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov edx, dword [byte eax+024h]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        mov esi, dword [byte ebp+024h]
        lea edi, [byte ebp+04h]
        movsd
        movsd
        mov esi, dword [byte ebp+028h]
        lea edi, [byte ebp+0Ch]
        movsd
        movsd
        mov esi, dword [byte ebp+02Ch]
        lea edi, [byte ebp+014h]
        push byte 1
        lea edx, [byte ebp+04h]
        movsd
        movsd
        push byte 0FFFFFFFFh
        mov esi, dword [byte ebp+030h]
        lea edi, [byte ebp+01Ch]
        push edx
        movsd
        movsd
        push byte 4
        mov ecx, dword [byte ebp+034h]
        push ecx
        call FillPolygon
        add esp, byte 14h
.1:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PrimQuadShadeBlendCcw                          113E4C  97 PC, low confidence
; Model renderer: draws a shaded, blended quad when it is wound the other way
;-----------------------------------------------------------------------------
PrimQuadShadeBlendCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov edx, dword [byte eax+024h]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        mov esi, dword [byte ebp+024h]
        lea edi, [byte ebp+04h]
        movsd
        movsd
        mov esi, dword [byte ebp+028h]
        lea edi, [byte ebp+0Ch]
        movsd
        movsd
        mov esi, dword [byte ebp+02Ch]
        lea edi, [byte ebp+014h]
        push byte 1
        lea edx, [byte ebp+04h]
        movsd
        movsd
        push byte 1
        mov esi, dword [byte ebp+030h]
        lea edi, [byte ebp+01Ch]
        push edx
        movsd
        movsd
        push byte 4
        mov ecx, dword [byte ebp+034h]
        push ecx
        call FillPolygon
        add esp, byte 14h
.1:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PrimQuadSplit                                  113ED4  97 PC, low confidence
; Model renderer: draws a quad as two random-colour triangles (debug view)
;-----------------------------------------------------------------------------
PrimQuadSplit:
        push ecx
        push edx
        push esi
        push edi
        mov esi, dword [byte eax+024h]
        lea edi, [byte eax+04h]
        movsd
        movsd
        mov esi, dword [byte eax+028h]
        lea edi, [byte eax+0Ch]
        movsd
        movsd
        push byte 0
        mov esi, dword [byte eax+02Ch]
        lea edi, [byte eax+014h]
        add eax, byte 4
        push byte 0
        movsd
        movsd
        push eax
        mov esi, dword [byte eax+02Ch]
        lea edi, [byte eax+018h]
        push byte 4
        movsd
        movsd
        call Random32
        push eax
        call FillPolygon
        add esp, byte 14h
        pop edi
        pop esi
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov edx, dword [byte eax+024h]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        mov eax, edi
        call PrimQuadSplit
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov edx, dword [byte eax+024h]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .2
        mov eax, edi
        call PrimQuadSplit
.2:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PrimQuadSplit_EC:
        push ecx
        push edx
        push byte 0
        push byte 0
        lea edx, [byte eax+024h]
        push edx
        lea edx, [byte eax+034h]
        push edx
        push byte 4
        mov edx, dword [byte eax+054h]
        push edx
        call DrawPolyArray
        add esp, byte 18h
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PrimQuadTexCw                                  113FE0  97 PC, low confidence
; Model renderer: draws a textured quad when it faces the camera
;-----------------------------------------------------------------------------
PrimQuadTexCw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov edx, dword [byte eax+024h]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        push byte 0
        mov ecx, dword [PrimColor]
        push ecx
        lea edx, [byte edi+024h]
        push edx
        lea edx, [byte edi+034h]
        push edx
        push byte 4
        mov esi, dword [byte edi+054h]
        push esi
        call DrawPolyArray
        add esp, byte 18h
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimQuadTexCcw                                 11404C  97 PC, low confidence
; Model renderer: draws a textured quad when it is wound the other way
;-----------------------------------------------------------------------------
PrimQuadTexCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov edx, dword [byte eax+024h]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        push edx
        mov ecx, dword [PrimColor]
        push ecx
        lea edx, [byte edi+024h]
        push edx
        lea edx, [byte edi+034h]
        push edx
        push byte 4
        mov esi, dword [byte edi+054h]
        push esi
        call DrawPolyArray
        add esp, byte 18h
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
PrimQuadTexCcw_6C:
        push ecx
        push edx
        push byte 2
        push byte 0
        lea edx, [byte eax+024h]
        push edx
        lea edx, [byte eax+034h]
        push edx
        push byte 4
        mov edx, dword [byte eax+054h]
        push edx
        call DrawPolyArray
        add esp, byte 18h
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PrimQuadTexShadeCw                             1140D8  97 PC, low confidence
; Model renderer: draws a shaded textured quad when it faces the camera
;-----------------------------------------------------------------------------
PrimQuadTexShadeCw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov edx, dword [byte eax+024h]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        push byte 2
        mov ecx, dword [PrimColor]
        push ecx
        lea edx, [byte edi+024h]
        push edx
        lea edx, [byte edi+034h]
        push edx
        push byte 4
        mov esi, dword [byte edi+054h]
        push esi
        call DrawPolyArray
        add esp, byte 18h
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimQuadTexShadeCcw                            114144  97 PC, low confidence
; Model renderer: draws a shaded textured quad when it is wound the other way
;-----------------------------------------------------------------------------
PrimQuadTexShadeCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov edx, dword [byte eax+024h]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        push byte 2
        mov ecx, dword [PrimColor]
        push ecx
        lea edx, [byte edi+024h]
        push edx
        lea edx, [byte edi+034h]
        push edx
        push byte 4
        mov esi, dword [byte edi+054h]
        push esi
        call DrawPolyArray
        add esp, byte 18h
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimQuadTexClear                               1141B0  97 PC, low confidence
; Model renderer: draws a textured quad with transparent texels from both
; sides
;-----------------------------------------------------------------------------
PrimQuadTexClear:
        push ecx
        push edx
        push byte 1
        push byte 0
        lea edx, [byte eax+024h]
        push edx
        lea edx, [byte eax+034h]
        push edx
        push byte 4
        mov edx, dword [byte eax+054h]
        push edx
        call DrawPolyArray
        add esp, byte 18h
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PrimQuadTexClearCw                             1141D0  97 PC, low confidence
; Model renderer: draws a textured quad with transparent texels when it faces
; the camera
;-----------------------------------------------------------------------------
PrimQuadTexClearCw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov edx, dword [byte eax+024h]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        push byte 1
        mov ecx, dword [PrimColor]
        push ecx
        lea edx, [byte edi+024h]
        push edx
        lea edx, [byte edi+034h]
        push edx
        push byte 4
        mov esi, dword [byte edi+054h]
        push esi
        call DrawPolyArray
        add esp, byte 18h
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimQuadTexClearCcw                            11423C  97 PC, low confidence
; Model renderer: draws a textured quad with transparent texels when it is
; wound the other way
;-----------------------------------------------------------------------------
PrimQuadTexClearCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov edx, dword [byte eax+024h]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        push byte 1
        mov ecx, dword [PrimColor]
        push ecx
        lea edx, [byte edi+024h]
        push edx
        lea edx, [byte edi+034h]
        push edx
        push byte 4
        mov esi, dword [byte edi+054h]
        push esi
        call DrawPolyArray
        add esp, byte 18h
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimQuadRandomFill                             1142A8  97 PC, low confidence
; Model renderer: fills a quad in a random colour (debug view)
;-----------------------------------------------------------------------------
PrimQuadRandomFill:
        push ecx
        push edx
        push esi
        push edi
        mov esi, dword [byte eax+024h]
        lea edi, [byte eax+04h]
        movsd
        movsd
        mov esi, dword [byte eax+028h]
        lea edi, [byte eax+0Ch]
        movsd
        movsd
        push byte 0
        mov esi, dword [byte eax+02Ch]
        lea edi, [byte eax+014h]
        add eax, byte 4
        push byte 0
        movsd
        movsd
        push eax
        mov esi, dword [byte eax+02Ch]
        lea edi, [byte eax+018h]
        push byte 4
        movsd
        movsd
        call Random32
        push eax
        call FillPolygon
        add esp, byte 14h
        pop edi
        pop esi
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PrimQuadRandomFillCw                           1142EC  97 PC, low confidence
; Model renderer: random-colour quad fill when it faces the camera
;-----------------------------------------------------------------------------
PrimQuadRandomFillCw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov edx, dword [byte eax+024h]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        je short .1
        mov eax, edi
        call PrimQuadRandomFill
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PrimQuadRandomFillCcw                          114340  97 PC, low confidence
; Model renderer: random-colour quad fill when it is wound the other way
;-----------------------------------------------------------------------------
PrimQuadRandomFillCcw:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edi, eax
        mov ebx, dword [byte eax+02Ch]
        mov esi, dword [byte eax+028h]
        mov edx, dword [byte eax+024h]
        mov eax, dword [ebx]
        mov ebx, dword [byte ebx+04h]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, dword [esi]
        sub ebx, dword [byte esi+04h]
        sub ecx, dword [esi]
        sub edx, dword [byte esi+04h]
        imul eax, edx
        imul ebx, ecx
        sub ebx, eax
        mov dword [PrimColor], ebx
        test ebx, ebx
        setl dl
        mov ebx, dword [ModelSetupMode]
        and edx, 0FFh
        xor edx, ebx
        jne short .1
        mov eax, edi
        call PrimQuadRandomFill
.1:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
DrawPrimListJumpTable:                          ; jump table for the switch cases of DrawPrimList
        dd DrawPrimList_A3
        dd DrawPrimList_D6
        dd DrawPrimList_10C
        dd DrawPrimList_6FD
        dd DrawPrimList_1A6
        dd DrawPrimList_6FD
        dd DrawPrimList_6FD
        dd DrawPrimList_39E
        dd DrawPrimList_401
        dd DrawPrimList_48F
        dd DrawPrimList_6FD
        dd DrawPrimList_53A
        dd DrawPrimList_6FD
        dd DrawPrimList_6FD
        dd DrawPrimList_607
        dd DrawPrimList_65B
;-----------------------------------------------------------------------------
; DrawPrimList                                   1143D4  97 PC, low confidence
; Model renderer: builds the primitive list of a model ("PRIMLIST"), sorts it
; by depth and draws each primitive by type
;-----------------------------------------------------------------------------
DrawPrimList:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov esi, eax
        push edx
        push dword 2710h
        mov edi, dword [eax]
        mov eax, dword [byte eax+08h]
        push str_PRIMLIST
        mov ebx, dword [byte edi+028h]
        mov dword [byte esp+01Ch], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov edx, eax
        mov dword [byte esp+08h], eax
        add eax, byte 4
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte esp+010h]
        mov ecx, dword [byte esp+0Ch]
        shl eax, 2
        add ecx, eax
        mov dword [byte esp+014h], ecx
        mov ecx, dword [dword esi+080h]
        mov dword [byte esp+018h], ecx
        mov ecx, dword [byte esp+010h]
        mov eax, dword [byte edi+020h]
        mov dword [edx], ecx
.1:
        mov edx, dword [byte esp+010h]
        lea ecx, [byte edx-01h]
        mov dword [byte esp+010h], ecx
        test edx, edx
        jle near DrawPrimList_6FD.58
        mov edi, esp
        mov esi, ebx
        mov ecx, dword [byte esp+0Ch]
        movsd
        movsd
        mov edx, dword [byte esp+014h]
        mov edi, dword [byte ebx+08h]
        mov dword [ecx], edx
        mov edx, dword [byte esp+04h]
        and edx, 0FFh
        lea esi, [byte ecx+04h]
        dec edx
        mov dword [byte esp+0Ch], esi
        cmp edx, byte 0Fh
        ja near DrawPrimList_6FD
        jmp dword [nosplit cs:edx*4+DrawPrimListJumpTable]
DrawPrimList_A3:
        mov edx, dword [byte esp+014h]
        lea ecx, [byte edx+020h]
        mov dword [edx], PrimRect
        mov dword [byte esp+014h], ecx
        mov ecx, dword [edi]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+014h], esi
        mov ecx, dword [byte edi+04h]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+018h], esi
        add ebx, byte 10h
        jmp short DrawPrimList.1
DrawPrimList_D6:
        mov edx, dword [byte esp+014h]
        lea ecx, [byte edx+024h]
        mov dword [edx], PrimRectDebug
        mov dword [byte esp+014h], ecx
        mov ecx, dword [edi]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+014h], esi
        mov ecx, dword [byte edi+04h]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+018h], esi
        add ebx, byte 10h
        jmp near DrawPrimList.1
DrawPrimList_10C:
        mov edx, dword [byte esp+014h]
        lea ecx, [byte edx+02Ch]
        mov dword [byte esp+014h], ecx
        mov cl, byte [byte esp+01h]
        test cl, 1
        je short .3
        mov ecx, dword [esp]
        and ecx, byte 78h
        cmp ecx, byte 10h
        jne short .2
        mov dword [edx], PrimTriShade
        jmp short .5
.2:
        mov dword [edx], PrimRectDebug_30
        jmp short .5
.3:
        test cl, 2
        je short .5
        mov ecx, dword [esp]
        and ecx, byte 78h
        cmp ecx, byte 10h
        jne short .4
        mov dword [edx], PrimTriShadeBlend
        jmp short .5
.4:
        mov dword [edx], PrimTriFlat
.5:
        mov ecx, dword [esp]
        and ecx, byte 78h
        cmp ecx, byte 10h
        jne short .6
        mov dword [edx], PrimTriShadeCcw
        jmp short .7
.6:
        mov dword [edx], PrimTriLitCcw
.7:
        mov ecx, dword [edi]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+01Ch], esi
        mov ecx, dword [byte edi+04h]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+020h], esi
        mov ecx, dword [byte edi+08h]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+024h], esi
        add ebx, byte 10h
        jmp near DrawPrimList.1
DrawPrimList_1A6:
        mov ebp, dword [byte esp+014h]
        lea edx, [byte ebp+044h]
        mov dword [byte esp+014h], edx
        cmp dword [ModelFileCount], byte 0
        je near .18
        mov cl, byte [byte esp+01h]
        test cl, 1
        je short .10
        mov edx, dword [esp]
        and edx, byte 78h
        cmp edx, byte 10h
        jne short .8
        mov dword [byte ebp+00h], PrimTriTexShade
        jmp near .16
.8:
        mov edx, dword [esp]
        and edx, byte 78h
        cmp edx, byte 8
        jne short .9
        mov dword [byte ebp+00h], PrimTriTexCcw_6C
        jmp near .16
.9:
        mov dword [byte ebp+00h], PrimTriTex
        jmp near .16
.10:
        test cl, 2
        je short .13
        mov edx, dword [esp]
        and edx, byte 78h
        cmp edx, byte 10h
        jne short .11
        mov dword [byte ebp+00h], PrimTriTexShadeCw
        jmp short .16
.11:
        mov edx, dword [esp]
        and edx, byte 78h
        cmp edx, byte 8
        jne short .12
        mov dword [byte ebp+00h], PrimTriTexClearCw
        jmp short .16
.12:
        mov dword [byte ebp+00h], PrimTriTexCw
        jmp short .16
.13:
        mov edx, dword [esp]
        and edx, byte 78h
        cmp edx, byte 10h
        jne short .14
        mov dword [byte ebp+00h], PrimTriTexShadeCcw
        jmp short .16
.14:
        mov edx, dword [esp]
        and edx, byte 78h
        cmp edx, byte 8
        jne short .15
        mov dword [byte ebp+00h], PrimTriTexClearCcw
        jmp short .16
.15:
        mov dword [byte ebp+00h], PrimTriTexCcw
.16:
        mov ecx, ebp
        xor edx, edx
.17:
        mov esi, dword [byte ebx+0Ch]
        mov esi, dword [edx+esi]
        mov esi, dword [eax+esi*8]
        shl esi, 10h
        mov dword [byte ecx+028h], esi
        mov esi, dword [byte ebx+0Ch]
        mov esi, dword [edx+esi]
        mov esi, dword [byte eax+esi*8+04h]
        add ecx, byte 8
        shl esi, 10h
        add edx, byte 4
        mov dword [byte ecx+024h], esi
        cmp edx, byte 0Ch
        je near .29
        jmp short .17
.18:
        mov dl, byte [byte esp+01h]
        test dl, 1
        je short .21
        mov edx, dword [esp]
        and edx, byte 78h
        cmp edx, byte 10h
        jne short .19
        mov dword [byte ebp+00h], CopyTriShadeVerts
        jmp near .27
.19:
        mov edx, dword [esp]
        and edx, byte 78h
        cmp edx, byte 8
        jne short .20
        mov dword [byte ebp+00h], CopyTriTexVerts
        jmp near .27
.20:
        mov dword [byte ebp+00h], CopyTriScreenVerts
        jmp near .27
.21:
        test dl, 2
        je short .24
        mov edx, dword [esp]
        and edx, byte 78h
        cmp edx, byte 10h
        jne short .22
        mov dword [byte ebp+00h], TriShadeVertsIfCw
        jmp short .27
.22:
        mov edx, dword [esp]
        and edx, byte 78h
        cmp edx, byte 8
        jne short .23
        mov dword [byte ebp+00h], TriTexVertsIfCw
        jmp short .27
.23:
        mov dword [byte ebp+00h], TriVertsIfCw
        jmp short .27
.24:
        mov edx, dword [esp]
        and edx, byte 78h
        cmp edx, byte 10h
        jne short .25
        mov dword [byte ebp+00h], TriShadeVertsIfCcw
        jmp short .27
.25:
        mov edx, dword [esp]
        and edx, byte 78h
        cmp edx, byte 8
        jne short .26
        mov dword [byte ebp+00h], TriTexVertsIfCcw
        jmp short .27
.26:
        mov dword [byte ebp+00h], TriVertsIfCcw
.27:
        mov ecx, ebp
        xor edx, edx
.28:
        mov esi, dword [byte ebx+0Ch]
        mov esi, dword [edx+esi]
        mov esi, dword [eax+esi*8]
        mov dword [byte ecx+028h], esi
        mov esi, dword [byte ebx+0Ch]
        mov esi, dword [edx+esi]
        add ecx, byte 8
        mov esi, dword [byte eax+esi*8+04h]
        add edx, byte 4
        mov dword [byte ecx+024h], esi
        cmp edx, byte 0Ch
        jne short .28
.29:
        mov edx, dword [edi]
        mov ecx, dword [byte esp+018h]
        shl edx, 3
        add ecx, edx
        mov dword [byte ebp+01Ch], ecx
        mov edx, dword [byte edi+04h]
        mov ecx, dword [byte esp+018h]
        shl edx, 3
        add ecx, edx
        mov dword [byte ebp+020h], ecx
        mov edx, dword [byte edi+08h]
        mov ecx, dword [byte esp+018h]
        shl edx, 3
        add ecx, edx
        mov dword [byte ebp+024h], ecx
        add ebx, byte 10h
        jmp near DrawPrimList.1
DrawPrimList_39E:
        mov edx, dword [byte esp+014h]
        lea ecx, [byte edx+034h]
        mov dword [byte esp+014h], ecx
        mov cl, byte [byte esp+01h]
        test cl, 1
        je short .30
        mov dword [edx], PrimTriDebug
        jmp short .32
.30:
        test cl, 2
        je short .31
        mov dword [edx], PrimTriDebugCw
        jmp short .32
.31:
        mov dword [edx], PrimTriDebugCcw
.32:
        mov ecx, dword [edi]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+01Ch], esi
        mov ecx, dword [byte edi+04h]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+020h], esi
        mov ecx, dword [byte edi+08h]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+024h], esi
        add ebx, byte 10h
        jmp near DrawPrimList.1
DrawPrimList_401:
        mov ebp, dword [byte esp+014h]
        lea edx, [byte ebp+050h]
        mov dword [byte esp+014h], edx
        mov dl, byte [byte esp+01h]
        test dl, 1
        je short .33
        mov dword [byte ebp+00h], PrimQuadDebug
        jmp short .35
.33:
        test dl, 2
        je short .34
        mov dword [byte ebp+00h], PrimQuadDebugCw
        jmp short .35
.34:
        mov dword [byte ebp+00h], PrimQuadDebugCcw
.35:
        mov ecx, ebp
        xor edx, edx
.36:
        mov esi, dword [byte ebx+0Ch]
        mov esi, dword [edx+esi]
        mov esi, dword [eax+esi*8]
        mov dword [byte ecx+028h], esi
        mov esi, dword [byte ebx+0Ch]
        mov esi, dword [edx+esi]
        add ecx, byte 8
        mov esi, dword [byte eax+esi*8+04h]
        add edx, byte 4
        mov dword [byte ecx+024h], esi
        cmp edx, byte 0Ch
        jne short .36
        mov edx, dword [edi]
        mov ecx, dword [byte esp+018h]
        shl edx, 3
        add ecx, edx
        mov dword [byte ebp+01Ch], ecx
        mov edx, dword [byte edi+04h]
        mov ecx, dword [byte esp+018h]
        shl edx, 3
        add ecx, edx
        mov dword [byte ebp+020h], ecx
        mov edx, dword [byte edi+08h]
        mov ecx, dword [byte esp+018h]
        shl edx, 3
        add ecx, edx
        mov dword [byte ebp+024h], ecx
        add ebx, byte 10h
        jmp near DrawPrimList.1
DrawPrimList_48F:
        mov edx, dword [byte esp+014h]
        lea ebp, [byte edx+038h]
        mov cl, byte [byte esp+01h]
        mov dword [byte esp+014h], ebp
        test cl, 1
        je short .38
        mov ecx, dword [esp]
        and ecx, byte 78h
        cmp ecx, byte 10h
        jne short .37
        mov dword [edx], PrimQuadShade
        jmp short .42
.37:
        mov dword [edx], PrimQuadDebugCcw_80
        jmp short .42
.38:
        test cl, 2
        je short .40
        mov ecx, dword [esp]
        and ecx, byte 78h
        cmp ecx, byte 10h
        jne short .39
        mov dword [edx], PrimQuadShadeCw
        jmp short .42
.39:
        mov dword [edx], PrimQuadFlat
        jmp short .42
.40:
        mov ecx, dword [esp]
        and ecx, byte 78h
        cmp ecx, byte 10h
        jne short .41
        mov dword [edx], PrimQuadShadeBlendCcw
        jmp short .42
.41:
        mov dword [edx], PrimQuadLitCcw
.42:
        mov ecx, dword [edi]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+024h], esi
        mov ecx, dword [byte edi+04h]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+028h], esi
        mov ecx, dword [byte edi+08h]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+02Ch], esi
        mov ecx, dword [byte edi+0Ch]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+030h], esi
        add ebx, byte 10h
        jmp near DrawPrimList.1
DrawPrimList_53A:
        mov ebp, dword [byte esp+014h]
        mov edx, dword [esp]
        mov ch, byte [byte esp+01h]
        lea esi, [byte ebp+058h]
        and edx, byte 78h
        mov dword [byte esp+014h], esi
        test ch, 1
        je short .45
        cmp edx, byte 10h
        jne short .43
        mov dword [byte ebp+00h], PrimQuadTexCcw_6C
        jmp near .51
.43:
        cmp edx, byte 8
        jne short .44
        mov dword [byte ebp+00h], PrimQuadTexClear
        jmp short .51
.44:
        mov dword [byte ebp+00h], PrimQuadSplit_EC
        jmp short .51
.45:
        test ch, 2
        je short .48
        cmp edx, byte 10h
        jne short .46
        mov dword [byte ebp+00h], PrimQuadTexShadeCw
        jmp short .51
.46:
        cmp edx, byte 8
        jne short .47
        mov dword [byte ebp+00h], PrimQuadTexClearCw
        jmp short .51
.47:
        mov dword [byte ebp+00h], PrimQuadTexCw
        jmp short .51
.48:
        cmp edx, byte 10h
        jne short .49
        mov dword [byte ebp+00h], PrimQuadTexShadeCcw
        jmp short .51
.49:
        cmp edx, byte 8
        jne short .50
        mov dword [byte ebp+00h], PrimQuadTexClearCcw
        jmp short .51
.50:
        mov dword [byte ebp+00h], PrimQuadTexCcw
.51:
        test byte [byte esp+01h], 10h
        je near DrawPrimList_65B.57
        mov ecx, ebp
        xor edx, edx
.52:
        mov esi, dword [byte ebx+0Ch]
        mov esi, dword [edx+esi]
        mov esi, dword [eax+esi*8]
        shl esi, 10h
        mov dword [byte ecx+034h], esi
        mov esi, dword [byte ebx+0Ch]
        mov esi, dword [edx+esi]
        mov esi, dword [byte eax+esi*8+04h]
        add ecx, byte 8
        shl esi, 10h
        add edx, byte 4
        mov dword [byte ecx+030h], esi
        cmp edx, byte 10h
        jne short .52
        jmp near DrawPrimList_65B.57
DrawPrimList_607:
        mov edx, dword [byte esp+014h]
        lea ecx, [byte edx+044h]
        mov dword [edx], PrimQuadSplit
        mov dword [byte esp+014h], ecx
        mov ecx, dword [edi]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+024h], esi
        mov ecx, dword [byte edi+04h]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+028h], esi
        mov ecx, dword [byte edi+08h]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+02Ch], esi
        mov ecx, dword [byte edi+0Ch]
        mov esi, dword [byte esp+018h]
        shl ecx, 3
        add esi, ecx
        mov dword [byte edx+030h], esi
        add ebx, byte 10h
        jmp near DrawPrimList.1
DrawPrimList_65B:
        mov ebp, dword [byte esp+014h]
        lea edx, [byte ebp+068h]
        mov dword [byte esp+014h], edx
        mov dl, byte [byte esp+01h]
        test dl, 1
        je short .53
        mov dword [byte ebp+00h], PrimQuadRandomFill
        jmp short .55
.53:
        test dl, 2
        je short .54
        mov dword [byte ebp+00h], PrimQuadRandomFillCw
        jmp short .55
.54:
        mov dword [byte ebp+00h], PrimQuadRandomFillCcw
.55:
        test byte [byte esp+01h], 10h
        je short .57
        mov ecx, ebp
        xor edx, edx
.56:
        mov esi, dword [byte ebx+0Ch]
        mov esi, dword [edx+esi]
        mov esi, dword [eax+esi*8]
        shl esi, 10h
        mov dword [byte ecx+034h], esi
        mov esi, dword [byte ebx+0Ch]
        mov esi, dword [edx+esi]
        mov esi, dword [byte eax+esi*8+04h]
        add ecx, byte 8
        shl esi, 10h
        add edx, byte 4
        mov dword [byte ecx+030h], esi
        cmp edx, byte 10h
        jne short .56
.57:
        mov edx, dword [edi]
        mov ecx, dword [byte esp+018h]
        shl edx, 3
        add ecx, edx
        mov dword [byte ebp+024h], ecx
        mov edx, dword [byte edi+04h]
        mov ecx, dword [byte esp+018h]
        shl edx, 3
        add ecx, edx
        mov dword [byte ebp+028h], ecx
        mov edx, dword [byte edi+08h]
        mov ecx, dword [byte esp+018h]
        shl edx, 3
        add ecx, edx
        mov dword [byte ebp+02Ch], ecx
        mov edx, dword [byte edi+0Ch]
        mov ecx, dword [byte esp+018h]
        shl edx, 3
        add ecx, edx
        mov dword [byte ebp+030h], ecx
DrawPrimList_6FD:
        add ebx, byte 10h
        jmp near DrawPrimList.1
.58:
        mov eax, dword [byte esp+014h]
        mov ebx, dword [byte esp+08h]
        sub eax, ebx
        push eax
        push ebx
        call CreateBitmapFromBlock
        add esp, byte 8
        mov eax, ebx
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; GetModelVertex                                 114AF8  97 PC, low confidence
; Model library: copies one vertex of a model part
;-----------------------------------------------------------------------------
GetModelVertex:
        push ecx
        push esi
        push edi
        sub esp, byte 8
        mov esi, edx
        mov ecx, dword [eax]
        shl esi, 4
        mov edi, dword [byte ecx+028h]
        mov eax, dword [dword eax+090h]
        add esi, edi
        mov edi, esp
        shl edx, 2
        add eax, byte 4
        movsd
        movsd
        add eax, edx
        mov edx, dword [byte esp+04h]
        and edx, 0FFh
        cmp edx, byte 0Ch
        jb short .2
        jbe short .1
        cmp edx, byte 10h
        jne short .2
.1:
        mov eax, dword [eax]
        mov dword [byte eax+034h], 0
        mov dword [byte eax+038h], 0
        mov dword [byte eax+054h], ebx
        mov edx, dword [byte ebx+02h]
        sar edx, 10h
        shl edx, 10h
        mov dword [byte eax+040h], 0
        dec edx
        mov dword [byte eax+03Ch], edx
        mov edx, dword [byte ebx+02h]
        sar edx, 10h
        shl edx, 10h
        dec edx
        mov dword [byte eax+044h], edx
        mov edx, dword [byte ebx+04h]
        sar edx, 10h
        shl edx, 10h
        mov dword [byte eax+04Ch], 0
        dec edx
        mov dword [byte eax+048h], edx
        mov edx, dword [byte ebx+04h]
        sar edx, 10h
        dec edx
        shl edx, 10h
        mov dword [byte eax+050h], edx
.2:
        add esp, byte 8
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
TransformModelPartsJumpTable:                   ; jump table for the switch cases of TransformModelParts
        dd TransformModelParts_5F
        dd TransformModelParts_DF
        dd TransformModelParts_DF
        dd TransformModelParts_DF
        dd TransformModelParts_5F
        dd TransformModelParts_DF
        dd TransformModelParts_DF
        dd TransformModelParts_6C
        dd TransformModelParts_DF
        dd TransformModelParts_DF
        dd TransformModelParts_DF
        dd TransformModelParts_D3
;-----------------------------------------------------------------------------
; TransformModelParts                            114BC0  97 PC, low confidence
; Model library: transforms the vertices of every part of a model
;-----------------------------------------------------------------------------
TransformModelParts:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov dword [byte esp+08h], edx
        mov edx, dword [dword eax+090h]
        mov ecx, dword [eax]
        mov ebp, dword [byte eax+08h]
        add edx, byte 4
        mov ecx, dword [byte ecx+028h]
.1:
        mov eax, ebp
        dec ebp
        test eax, eax
        jle near TransformModelParts_EA
        mov edi, esp
        mov esi, ecx
        movsd
        movsd
        mov eax, dword [esp]
        shl eax, 8
        mov esi, dword [byte esp+08h]
        shr eax, 18h
        cmp eax, esi
        jne near TransformModelParts_DF
        mov eax, dword [byte esp+04h]
        and eax, 0FFh
        sub eax, byte 5
        cmp eax, byte 0Bh
        ja near TransformModelParts_DF
        jmp dword [nosplit cs:eax*4+TransformModelPartsJumpTable]
TransformModelParts_5F:
        mov eax, dword [edx]
        mov dword [byte eax+040h], ebx
        add edx, byte 4
        add ecx, byte 10h
        jmp short TransformModelParts.1
TransformModelParts_6C:
        mov eax, dword [edx]
        test byte [byte esp+01h], 10h
        jne short TransformModelParts_D3.3
.2:
        mov dword [byte eax+034h], 0
        mov dword [byte eax+038h], 0
        mov dword [byte eax+054h], ebx
        mov esi, dword [byte ebx+02h]
        sar esi, 10h
        shl esi, 10h
        mov dword [byte eax+040h], 0
        dec esi
        mov dword [byte eax+03Ch], esi
        mov esi, dword [byte ebx+02h]
        sar esi, 10h
        shl esi, 10h
        dec esi
        mov dword [byte eax+044h], esi
        mov esi, dword [byte ebx+04h]
        sar esi, 10h
        shl esi, 10h
        mov dword [byte eax+04Ch], 0
        dec esi
        mov dword [byte eax+048h], esi
        mov esi, dword [byte ebx+04h]
        sar esi, 10h
        dec esi
        shl esi, 10h
        mov dword [byte eax+050h], esi
        add edx, byte 4
        add ecx, byte 10h
        jmp near TransformModelParts.1
TransformModelParts_D3:
        mov eax, dword [edx]
        test byte [byte esp+01h], 10h
        je short TransformModelParts_6C.2
.3:
        mov dword [byte eax+054h], ebx
TransformModelParts_DF:
        add edx, byte 4
        add ecx, byte 10h
        jmp near TransformModelParts.1
TransformModelParts_EA:
        add esp, byte 0Ch
        pop ebp
        pop edi
TransformModelParts_EF:
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
TransformModelPartsWithJumpTable:               ; jump table for the switch cases of TransformModelPartsWith
        dd TransformModelPartsWith_9F
        dd TransformModelPartsWith_DD
        dd TransformModelPartsWith_DD
        dd TransformModelPartsWith_DD
        dd TransformModelPartsWith_9F
        dd TransformModelPartsWith_DD
        dd TransformModelPartsWith_DD
        dd TransformModelPartsWith_BF
        dd TransformModelPartsWith_DD
        dd TransformModelPartsWith_DD
        dd TransformModelPartsWith_DD
        dd TransformModelPartsWith_BF
;-----------------------------------------------------------------------------
; TransformModelPartsWith                        114CE4  97 PC, low confidence
; Model library: transforms the vertices of every part of a model by a given
; matrix and offset
;-----------------------------------------------------------------------------
TransformModelPartsWith:
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        mov dword [byte esp+08h], edx
        mov ebp, ebx
        mov dword [byte esp+014h], ecx
        mov edx, dword [byte eax+08h]
        mov ebx, dword [eax]
        mov eax, dword [dword eax+090h]
        mov dword [byte esp+0Ch], edx
        add eax, byte 4
        mov ebx, dword [byte ebx+028h]
        mov dword [byte esp+010h], eax
.1:
        mov eax, dword [byte esp+0Ch]
        lea edx, [byte eax-01h]
        mov dword [byte esp+0Ch], edx
        test eax, eax
        jle near TransformModelPartsWith_DD.5
        mov edi, esp
        mov esi, ebx
        movsd
        movsd
        mov eax, dword [esp]
        shl eax, 8
        mov ecx, dword [byte esp+08h]
        shr eax, 18h
        cmp eax, ecx
        jne near TransformModelPartsWith_DD
        test byte [byte ebx+01h], 10h
        je near TransformModelPartsWith_DD
        xor edx, edx
        xor eax, eax
        jmp short .3
.2:
        mov ecx, dword [byte ebx+08h]
        cmp ebp, dword [ecx+edx]
        je short .4
        inc eax
        add edx, byte 4
.3:
        mov ecx, dword [ebx]
        and ecx, byte 7
        cmp eax, ecx
        jb short .2
.4:
        mov edx, dword [ebx]
        and edx, byte 7
        cmp eax, edx
        jae short TransformModelPartsWith_DD
        mov edx, dword [byte esp+04h]
        and edx, 0FFh
        sub edx, byte 5
        cmp edx, byte 0Bh
        ja short TransformModelPartsWith_DD
        jmp dword [nosplit cs:edx*4+TransformModelPartsWithJumpTable]
TransformModelPartsWith_9F:
        mov edx, dword [byte esp+010h]
        shl eax, 3
        mov edx, dword [edx]
        add eax, edx
        mov edx, dword [byte esp+014h]
        mov edx, dword [edx]
        mov dword [byte eax+028h], edx
        mov edx, dword [byte esp+014h]
        mov edx, dword [byte edx+04h]
        mov dword [byte eax+02Ch], edx
        jmp short TransformModelPartsWith_DD
TransformModelPartsWith_BF:
        mov edx, dword [byte esp+010h]
        shl eax, 3
        mov edx, dword [edx]
        add eax, edx
        mov edx, dword [byte esp+014h]
        mov edx, dword [edx]
        mov dword [byte eax+034h], edx
        mov edx, dword [byte esp+014h]
        mov edx, dword [byte edx+04h]
        mov dword [byte eax+038h], edx
TransformModelPartsWith_DD:
        mov edi, dword [byte esp+010h]
        add edi, byte 4
        add ebx, byte 10h
        mov dword [byte esp+010h], edi
        jmp near TransformModelPartsWith.1
.5:
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        ret
        db 090h
;-----------------------------------------------------------------------------
; UpdateModelParts                               114DDC  97 PC, low confidence
; Model library: runs the per-frame update of every part of a model
;-----------------------------------------------------------------------------
UpdateModelParts:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov dword [byte esp+08h], edx
        mov ecx, ebx
        mov ebx, dword [eax]
        mov ebp, dword [byte eax+08h]
        mov eax, dword [dword eax+090h]
        mov ebx, dword [byte ebx+028h]
        add eax, byte 4
.1:
        mov edx, ebp
        dec ebp
        test edx, edx
        jle near TransformModelParts_EA
        mov edi, esp
        mov esi, ebx
        movsd
        movsd
        mov edx, dword [esp]
        shl edx, 8
        mov esi, dword [byte esp+08h]
        shr edx, 18h
        cmp edx, esi
        jne short .5
        mov edx, dword [byte esp+04h]
        and edx, 0FFh
        cmp edx, byte 3
        jb short .2
        jbe short .3
        cmp edx, byte 0Ah
        je short .4
        jmp short .5
.2:
        cmp edx, byte 1
        jne short .5
        mov edx, dword [eax]
        mov dword [byte edx+01Ch], ecx
        jmp short .5
.3:
        mov edx, dword [eax]
        mov dword [byte edx+028h], ecx
        jmp short .5
.4:
        mov edx, dword [eax]
        mov dword [byte edx+034h], ecx
.5:
        add eax, byte 4
        add ebx, byte 10h
        jmp short .1
;-----------------------------------------------------------------------------
; CallModelPartFuncs                             114E54  97 PC, low confidence
; Model library: calls the function of each listed model part
;-----------------------------------------------------------------------------
CallModelPartFuncs:
        push ecx
        push esi
        mov ecx, edx
        mov esi, dword [dword eax+090h]
        add esi, byte 4
.1:
        mov edx, ecx
        dec ecx
        test edx, edx
        jle near TransformModelParts_EF
        mov edx, dword [ebx]
        mov edx, dword [esi+edx*4]
        mov eax, edx
        add ebx, byte 4
        call dword [edx]
        jmp short .1
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CallAllPartFuncs                               114E7C  97 PC, low confidence
; Model library: calls the function of every model part
;-----------------------------------------------------------------------------
CallAllPartFuncs:
        push ebx
        push ecx
        push edx
        mov ebx, dword [dword eax+090h]
        add ebx, byte 4
        mov ecx, dword [byte ebx-04h]
.1:
        mov edx, dword [ebx]
        add ebx, byte 4
        mov eax, edx
        dec ecx
        call dword [edx]
        test ecx, ecx
        jg short .1
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h
        push ebx
        mov edx, dword [byte esp+08h]
        mov ebx, 28h
        mov eax, PartFuncTable
        call strncpy_
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; BuildFrameFromPoints                           114EB8  97 PC, low confidence
; Model library: builds an orientation matrix from three points of a model
;-----------------------------------------------------------------------------
BuildFrameFromPoints:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 38h
        mov ecx, eax
        mov esi, edx
        mov ebp, ebx
        mov edi, ebx
        mov ebx, dword [byte ecx+010h]
        mov edx, dword [byte eax+08h]
        add ebx, esi
        mov eax, dword [byte eax+0Ch]
        mov dword [byte esp+034h], ebx
        mov ebx, dword [byte ecx+014h]
        add edx, esi
        add ebx, esi
        add eax, esi
        mov dword [byte esp+030h], ebx
        lea ebx, [byte esp+024h]
        call VecSub
        cmp dword [ecx], byte 2
        jne short .1
        lea ebx, [byte esp+018h]
        mov edx, dword [byte ecx+018h]
        mov eax, dword [byte ecx+01Ch]
        add edx, esi
        add eax, esi
        call VecSub
        lea edx, [byte esp+024h]
        lea eax, [byte esp+018h]
        mov ebx, ebp
        call VecCrossUnit
        jmp short .2
.1:
        lea eax, [byte esp+024h]
        mov edx, ebp
        call VecNormalize
.2:
        mov ebx, dword [ecx]
        test ebx, ebx
        jne short .3
        lea ebx, [byte esp+024h]
        mov edx, dword [byte esp+034h]
        mov eax, dword [byte esp+030h]
        call VecSub
        jmp short .5
.3:
        cmp ebx, byte 3
        jne short .4
        mov ebx, esp
        mov edx, dword [byte ecx+018h]
        mov eax, dword [byte ecx+01Ch]
        add edx, esi
        add eax, esi
        call VecSub
        lea ebx, [byte esp+0Ch]
        mov edx, dword [byte esp+034h]
        mov ecx, eax
        mov eax, dword [byte esp+030h]
        call VecSub
        lea ebx, [byte esp+024h]
        mov edx, ecx
        call VecCross
        jmp short .5
.4:
        cmp ebx, byte 1
        jne short .5
        lea ebx, [byte esp+024h]
        mov edx, dword [byte ecx+018h]
        mov eax, dword [byte ecx+01Ch]
        add edx, esi
        add eax, esi
        call VecSub
        lea ebx, [byte esp+024h]
        mov edx, dword [byte esp+034h]
        mov ecx, eax
        mov eax, dword [byte esp+030h]
        call VecSub
        lea ebx, [byte esp+024h]
        mov edx, ecx
        call VecAdd
.5:
        lea ecx, [byte edi+0Ch]
        lea edx, [byte esp+024h]
        mov ebx, ecx
        mov eax, edi
        call VecCrossUnit
        lea ebx, [byte edi+018h]
        mov edx, ecx
        mov eax, edi
        call VecCross
        mov eax, 1
        add esp, byte 38h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; TransformBoneVerts                             114FD0  97 PC, low confidence
; Model library: transforms the vertices attached to a bone
;-----------------------------------------------------------------------------
TransformBoneVerts:
        push esi
        push edi
        mov esi, eax
        mov edi, edx
        mov edx, ecx
        lea eax, [nosplit ebx*4+00h]
        add eax, ebx
        mov ecx, dword [byte esi+044h]
        shl eax, 2
        add ecx, eax
        mov ebx, dword [byte ecx+010h]
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        shl eax, 2
        mov ebx, edi
        add edx, eax
        lea eax, [nosplit ebx*8+00h]
        add eax, ebx
        shl eax, 2
        mov ebx, dword [byte esi+074h]
        add ebx, eax
        mov eax, dword [byte ecx+08h]
        mov ecx, edx
        call TransformVecs
        mov eax, 1
        pop edi
        pop esi
        ret
        db 090h
;-----------------------------------------------------------------------------
; SkinModelVerts                                 115020  97 PC, low confidence
; Model library: moves the vertices attached to each anchor point with it
;-----------------------------------------------------------------------------
SkinModelVerts:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 24h
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte eax+064h]
        mov dword [byte esp+01Ch], eax
        test eax, eax
        je near .3
        mov eax, dword [byte esp+0Ch]
        mov eax, dword [byte eax+074h]
        mov dword [byte esp+018h], eax
        mov eax, dword [byte esp+0Ch]
        mov eax, dword [byte eax+068h]
        mov dword [byte esp+020h], eax
        mov eax, dword [byte edx+0Ch]
        mov dword [byte esp+014h], ebx
        mov dword [byte esp+010h], eax
.1:
        mov esi, dword [byte esp+01Ch]
        dec esi
        mov dword [byte esp+01Ch], esi
        cmp esi, byte 0FFFFFFFFh
        je near .2
        mov ebp, dword [byte esp+014h]
        mov eax, dword [byte esp+020h]
        mov esi, dword [byte esp+010h]
        mov edi, esp
        mov edx, dword [byte eax+020h]
        mov ebx, dword [byte eax+04h]
        add ebp, edx
        add esi, ebx
        mov ebx, esp
        mov ecx, ebp
        movsd
        movsd
        movsd
        mov edx, ebp
        fld dword [esp]
        fld dword [byte esp+04h]
        fld dword [byte esp+08h]
        mov esi, dword [byte esp+020h]
        fxch st2
        fchs
        fxch
        fchs
        fxch st2
        fchs
        fxch
        fstp dword [esp]
        fxch
        fstp dword [byte esp+04h]
        mov eax, dword [byte esp+020h]
        fstp dword [byte esp+08h]
        mov eax, dword [byte eax+024h]
        add esi, byte 28h
        call AddVecs
        mov ebx, dword [byte esp+018h]
        mov eax, dword [byte esp+020h]
        mov edx, ebp
        lea ecx, [byte ebx+024h]
        mov eax, dword [byte eax+024h]
        mov dword [byte esp+018h], ecx
        mov ecx, ebp
        mov dword [byte esp+020h], esi
        call TransformVecs
        jmp near .1
.2:
        mov eax, dword [byte esp+0Ch]
        mov eax, dword [byte eax+064h]
.3:
        add esp, byte 24h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AttachModelFrame                               1150FC  97 PC, low confidence
; Model library: sets a model's frame from its anchor points; returns 0 when
; it has none
;-----------------------------------------------------------------------------
AttachModelFrame:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 28h
        mov dword [byte esp+024h], eax
        mov esi, dword [byte eax+064h]
        test esi, esi
        jne short .1
        xor eax, eax
        jmp short .4
.1:
        mov ecx, dword [byte eax+068h]
        mov ebp, dword [byte edx+0Ch]
        mov edi, dword [byte eax+074h]
.2:
        dec esi
        cmp esi, byte 0FFFFFFFFh
        je short .3
        mov ebx, esp
        mov edx, ebp
        mov eax, ecx
        call BuildFrameFromPoints
        mov eax, esp
        mov edx, edi
        call MatTranspose
        add ecx, byte 28h
        add edi, byte 24h
        jmp short .2
.3:
        mov eax, dword [byte esp+024h]
        mov eax, dword [byte eax+064h]
.4:
        add esp, byte 28h
AttachModelFrame_4C:
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AttachModel                                    115150  97 PC, low confidence
; Model library: attaches a model to its anchor points and moves its vertices
;-----------------------------------------------------------------------------
AttachModel:
        push ebx
        push ecx
        push esi
        mov ecx, eax
        mov esi, edx
        call AttachModelFrame
        test eax, eax
        je short .1
        mov edx, esi
        mov eax, ecx
        mov ebx, dword [byte ecx+018h]
        call SkinModelVerts
.1:
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; UpdateModelFrame                               115170  97 PC, low confidence
; Model library: rebuilds the frames of a model's anchor points
;-----------------------------------------------------------------------------
UpdateModelFrame:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, edx
        mov esi, dword [eax]
        mov ecx, dword [byte esi+064h]
        test ecx, ecx
        je short AttachModelFrame_4C
        mov edi, dword [dword eax+08Ch]
        mov esi, dword [byte esi+068h]
.1:
        dec ecx
        cmp ecx, byte 0FFFFFFFFh
        je short AttachModelFrame_4C
        mov ebx, edi
        mov eax, esi
        mov edx, ebp
        call BuildFrameFromPoints
        add edi, byte 24h
        add esi, byte 28h
        jmp short .1
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SkinModel                                      1151A4  97 PC, low confidence
; Model library: moves the vertices of a model with its anchor points
;-----------------------------------------------------------------------------
SkinModel:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov dword [esp], edx
        mov esi, dword [eax]
        mov ebp, dword [byte esi+064h]
        test ebp, ebp
        je short .2
        mov edx, dword [dword eax+08Ch]
        mov esi, dword [byte esi+068h]
        mov dword [byte esp+0Ch], edx
        mov edx, dword [byte eax+074h]
        mov eax, dword [byte eax+07Ch]
        mov dword [byte esp+08h], edx
        mov dword [byte esp+04h], eax
.1:
        dec ebp
        cmp ebp, byte 0FFFFFFFFh
        je short .2
        mov edx, dword [byte esp+08h]
        mov ebx, dword [byte esi+020h]
        mov edi, dword [byte esp+04h]
        add edx, ebx
        add edi, ebx
        mov ebx, dword [byte esp+0Ch]
        lea ecx, [byte ebx+024h]
        mov eax, dword [byte esi+024h]
        mov dword [byte esp+0Ch], ecx
        mov ecx, edi
        call TransformVecs
        mov ebx, dword [esp]
        mov ecx, edi
        mov eax, dword [byte esi+04h]
        mov edx, edi
        add ebx, eax
        mov eax, dword [byte esi+024h]
        add esi, byte 28h
        call AddVecs
        jmp short .1
.2:
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ScaleModelVerts                                115220  97 PC, low confidence
; Model library: converts a model's fixed-point vertices to floats
;-----------------------------------------------------------------------------
ScaleModelVerts:
        push ebx
        push ecx
        push edx
        push esi
        mov ecx, eax
        mov ebx, dword [eax]
        xor edx, edx
        test ebx, ebx
        jle short .2
        xor ebx, ebx
.1:
        mov eax, dword [byte ecx+0Ch]
        fild dword [ebx+eax]
        fmul qword [F64_0p1_ScaleModelVerts]
        fild dword [byte ebx+eax+04h]
        fmul qword [F64_0p1_ScaleModelVerts]
        fild dword [byte ebx+eax+08h]
        fmul qword [F64_0p1_ScaleModelVerts]
        fxch st2
        fmul qword [F64_1p25_ScaleModelVerts]
        fxch
        fmul qword [F64_1p25_ScaleModelVerts]
        fxch st2
        fmul qword [F64_1p25_ScaleModelVerts]
        inc edx
        fxch
        fstp dword [ebx+eax]
        fxch
        fstp dword [byte ebx+eax+04h]
        fstp dword [byte ebx+eax+08h]
        mov esi, dword [ecx]
        add ebx, byte 0Ch
        cmp edx, esi
        jl short .1
.2:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FixupModelOffsets                              115288  97 PC, low confidence
; Model library: turns the offsets of a loaded model file into pointers
;-----------------------------------------------------------------------------
FixupModelOffsets:
        push edx
        mov edx, dword [byte eax+08h]
        add edx, eax
        mov dword [byte eax+08h], edx
        mov edx, dword [byte eax+010h]
        add edx, eax
        mov dword [byte eax+010h], edx
        mov edx, dword [byte eax+0Ch]
        add edx, eax
        mov dword [byte eax+0Ch], edx
        mov edx, dword [byte eax+014h]
        add edx, eax
        mov dword [byte eax+014h], edx
        mov dword [byte eax+018h], edx
        pop edx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LoadModelFile                                  1152B0  97 PC, low confidence
; Model library: builds the path of a model file (".4db"), loads it and fixes
; its offsets
;-----------------------------------------------------------------------------
LoadModelFile:
        push ebx
        push ecx
        sub esp, byte 50h
        mov ebx, eax
        mov ecx, edx
        mov edx, PartFuncTable
        mov eax, esp
        call strcpy_
        mov eax, esp
        mov edx, ebx
        call strcat_
        xor edx, edx
        jmp short .3
.1:
        cmp byte [esp+edx], 2Eh
        jne short .2
        xor bl, bl
        mov byte [esp+edx], bl
        jmp short .4
.2:
        inc edx
.3:
        mov eax, esp
        call strlen_
        cmp edx, eax
        jb short .1
.4:
        mov edx, str_4db
        mov eax, esp
        call strcat_
        push ecx
        lea eax, [byte esp+04h]
        push eax
        call LoadResourceData
        add esp, byte 8
        mov edx, eax
        test eax, eax
        je short .5
        call FixupModelOffsets
.5:
        mov eax, edx
        add esp, byte 50h
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FindModelPart                                  115318  97 PC, low confidence
; Model library: returns the index of a model part by its 8-character name,
; -1 if none
;-----------------------------------------------------------------------------
FindModelPart:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov edi, edx
        mov edx, dword [eax]
        mov ecx, dword [byte eax+08h]
        xor esi, esi
        test edx, edx
        jle short .3
.1:
        mov ebx, 8
        mov edx, edi
        mov eax, ecx
        call strnicmp_
        test eax, eax
        jne short .2
        mov eax, esi
        jmp short .4
.2:
        inc esi
        mov ebx, dword [byte ebp+00h]
        add ecx, byte 8
        cmp esi, ebx
        jl short .1
.3:
        mov eax, 0FFFFFFFFh
.4:
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h
        push ebx
        push esi
        push edi
        push ebp
        mov edi, dword [byte esp+018h]
        mov ebp, dword [byte esp+014h]
        mov ebp, dword [byte ebp+00h]
        xor esi, esi
        mov edx, dword [byte ebp+040h]
        mov ecx, dword [byte ebp+044h]
        test edx, edx
        jle short .7
.5:
        mov ebx, 8
        mov edx, edi
        mov eax, ecx
        call strnicmp_
        test eax, eax
        jne short .6
        mov eax, esi
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.6:
        inc esi
        mov ebx, dword [byte ebp+040h]
        add ecx, byte 14h
        cmp esi, ebx
        jl short .5
.7:
        mov eax, 0FFFFFFFFh
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ResetMorphVerts                                1153AC  97 PC, low confidence
; Model library: copies a model's base vertices back before the morph targets
; are added
;-----------------------------------------------------------------------------
ResetMorphVerts:
        push ebx
        push esi
        mov ecx, dword [byte esp+0Ch]
        mov ah, byte [byte ecx+010h]
        mov esi, dword [byte ecx+070h]
        test ah, 10h
        je short .1
        mov edx, dword [byte ecx+04h]
        lea ebx, [nosplit edx*4+00h]
        sub ebx, edx
        mov eax, dword [byte ecx+074h]
        shl ebx, 2
        mov edx, esi
        call memcpy_
.1:
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ApplyMorphTarget                               1153DC  97 PC, low confidence
; Model library: adds a weighted morph target (face expression) to a model's
; vertices
;-----------------------------------------------------------------------------
ApplyMorphTarget:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov ebp, dword [byte esp+024h]
        mov ebx, dword [byte esp+028h]
        lea eax, [nosplit ebx*4+00h]
        mov edx, dword [byte ebp+00h]
        add eax, ebx
        mov esi, dword [byte edx+044h]
        shl eax, 2
        add esi, eax
        mov edi, dword [byte esi+0Ch]
        mov ecx, dword [byte edx+050h]
        shl edi, 2
        add edi, ecx
        mov ecx, dword [byte esi+010h]
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        shl eax, 2
        mov ecx, dword [byte ebp+070h]
        add ecx, eax
        mov eax, dword [byte ebp+074h]
        mov esi, dword [byte esi+08h]
        mov dword [byte esp+0Ch], eax
        test ebx, ebx
        jl near .3
        cmp ebx, dword [byte edx+040h]
        jge short .3
        mov edx, dword [byte esp+02Ch]
        test edx, 7FFFFFFFh
        je short .3
        cmp edx, 3F800000h
        jne short .2
.1:
        dec esi
        cmp esi, byte 0FFFFFFFFh
        je short .3
        mov eax, dword [edi]
        imul eax, byte 0Ch
        add eax, dword [byte esp+0Ch]
        mov edx, ecx
        mov ebx, eax
        add edi, byte 4
        call VecAdd
        add ecx, byte 0Ch
        jmp short .1
.2:
        dec esi
        cmp esi, byte 0FFFFFFFFh
        je short .3
        mov ebp, dword [edi]
        imul ebp, byte 0Ch
        add ebp, dword [byte esp+0Ch]
        mov eax, esp
        push eax
        add edi, byte 4
        push dword [byte esp+030h]
        mov eax, ecx
        mov ebx, ebp
        call VecScale
        mov edx, eax
        mov eax, ebp
        add ecx, byte 0Ch
        call VecAdd
        jmp short .2
.3:
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov esi, dword [byte esp+028h]
        mov edi, dword [byte esp+02Ch]
        lea eax, [nosplit edi*4+00h]
        mov edx, dword [esi]
        add eax, edi
        mov ebp, dword [byte edx+044h]
        shl eax, 2
        add ebp, eax
        mov ebx, dword [byte edx+050h]
        mov ecx, dword [byte ebp+0Ch]
        mov eax, dword [byte esi+070h]
        shl ecx, 2
        mov dword [byte esp+010h], eax
        mov eax, dword [byte esi+074h]
        add ecx, ebx
        mov ebx, dword [byte ebp+010h]
        mov dword [byte esp+0Ch], eax
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        mov esi, dword [byte esp+010h]
        shl eax, 2
        mov ebp, dword [byte ebp+08h]
        add esi, eax
        test edi, edi
        jl near .8
        cmp edi, dword [byte edx+040h]
        jge near .8
        mov edx, dword [byte esp+030h]
        test edx, 7FFFFFFFh
        jne short .5
.4:
        dec ebp
        cmp ebp, byte 0FFFFFFFFh
        je near .8
        mov eax, dword [ecx]
        imul eax, byte 0Ch
        mov esi, dword [byte esp+010h]
        mov edi, dword [byte esp+0Ch]
        add esi, eax
        add edi, eax
        add ecx, byte 4
        movsd
        movsd
        movsd
        jmp short .4
.5:
        cmp edx, 3F800000h
        jne short .7
        mov edi, dword [byte esp+010h]
.6:
        dec ebp
        cmp ebp, byte 0FFFFFFFFh
        je short .8
        mov eax, dword [ecx]
        imul eax, byte 0Ch
        mov ebx, dword [byte esp+0Ch]
        add ecx, byte 4
        mov edx, esi
        add ebx, eax
        add eax, edi
        add esi, byte 0Ch
        call VecAdd
        jmp short .6
.7:
        dec ebp
        cmp ebp, byte 0FFFFFFFFh
        je short .8
        mov edi, dword [ecx]
        imul edi, byte 0Ch
        mov eax, esp
        push eax
        mov ebx, dword [byte esp+010h]
        mov edx, dword [byte esp+014h]
        push dword [byte esp+034h]
        mov eax, esi
        add ecx, byte 4
        call VecScale
        add ebx, edi
        add edi, edx
        mov edx, eax
        mov eax, edi
        add esi, byte 0Ch
        call VecAdd
        jmp short .7
.8:
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; PlotPixelRGB                                   1155B0  97 PC, low confidence
; Graphics library: plots a pixel of an RGB colour, clipped to the window
;-----------------------------------------------------------------------------
PlotPixelRGB:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov esi, dword [byte esp+030h]
        mov edi, dword [byte esp+034h]
        mov ecx, dword [byte esp+038h]
        cmp esi, dword [ClipTopRow]
        jl near .12
        cmp esi, dword [ClipRight]
        jge near .12
        cmp edi, dword [ClipLeftCol]
        jl near .12
        cmp edi, dword [ScreenHeight]
        jge near .12
        cmp byte [ScreenBitsPerPixel], 10h
        jne near .3
        cmp dword [ScreenBuffer], byte 0
        jne near .3
        mov ebx, edi
        mov eax, esi
        mov edx, dword [DrawDestOffset]
        mov eax, dword [edx+eax*4]
        mov edx, dword [DrawDestBuffer]
        add eax, dword [edx+ebx*4]
        add eax, dword [DrawDestPitch]
        mov ebx, ecx
        mov esi, eax
        cmp ebx, 1000000h
        jb short .2
        cmp ebx, 0FF000000h
        jae short .1
        mov ax, word [esi]
        mov ecx, ebx
        mov edx, eax
        xor ecx, byte 0FFFFFFFFh
        shl eax, 10h
        mov al, dl
        and edx, 7E0h
        shl edx, 8
        and eax, 0F800001Fh
        shr ecx, 18h
        add eax, edx
        mul ecx
        shl edx, 10h
        mov ecx, eax
        shr ecx, 5
        add ebx, edx
        shr eax, 0Bh
        and ecx, 0FFh
        and eax, 0FF00h
        add ebx, ecx
        add ebx, eax
.1:
        mov eax, ebx
        and ebx, 0F80000h
        shr ebx, 8
        mov edx, eax
        shr eax, 3
        and edx, 0FC00h
        shr edx, 5
        and eax, byte 1Fh
        add ebx, eax
        add ebx, edx
        mov word [esi], bx
.2:
        lea esi, [byte esi+02h]
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.3:
        mov ebp, ecx
        shr ebp, 18h
        and ebp, 0FFh
        cmp ebp, 0FFh
        jne short .4
        push ecx
        jmp near .11
.4:
        test ebp, ebp
        je near .12
        mov eax, ecx
        shr eax, 10h
        and eax, 0FFh
        mov ebx, ebp
        mov dword [byte esp+08h], eax
        mov eax, ecx
        push edi
        shr eax, 8
        shl ebx, 8
        and eax, 0FFh
        push esi
        mov dword [byte esp+020h], eax
        mov eax, 10000h
        and ecx, 0FFh
        sub eax, ebx
        mov dword [byte esp+014h], ecx
        mov ebx, eax
        call PlotPixelClipped
        add esp, byte 8
        push eax
        call ConvertColor555
        mov ecx, eax
        sar ecx, 10h
        add esp, byte 4
        and ecx, 0FFh
        mov dword [byte esp+014h], ecx
        mov ecx, eax
        sar ecx, 8
        and ecx, 0FFh
        mov edx, ebx
        mov dword [byte esp+010h], ecx
        mov ecx, eax
        mov eax, dword [byte esp+014h]
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        add eax, dword [byte esp+08h]
        and ecx, 0FFh
        cmp eax, 0FFh
        jle short .5
        mov eax, 0FFh
        jmp short .6
.5:
        mov eax, dword [byte esp+014h]
        mov edx, ebx
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        add eax, dword [byte esp+08h]
.6:
        mov dword [byte esp+04h], eax
        mov edx, ebx
        mov eax, dword [byte esp+010h]
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        add eax, dword [byte esp+018h]
        cmp eax, 0FFh
        jle short .7
        mov eax, 0FFh
        jmp short .8
.7:
        mov eax, dword [byte esp+010h]
        mov edx, ebx
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        add eax, dword [byte esp+018h]
.8:
        mov dword [esp], eax
        mov edx, ebx
        mov eax, ecx
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        add eax, dword [byte esp+0Ch]
        cmp eax, 0FFh
        jle short .9
        mov eax, 0FFh
        jmp short .10
.9:
        mov edx, ebx
        mov eax, ecx
        mov ebx, dword [byte esp+0Ch]
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        add eax, ebx
.10:
        mov ebx, ebp
        mov ecx, dword [byte esp+04h]
        shl ebx, 18h
        shl ecx, 10h
        or ebx, ecx
        mov ecx, dword [esp]
        shl ecx, 8
        or ebx, ecx
        or eax, ebx
        push eax
.11:
        call MakeColor
        add esp, byte 4
        push eax
        push edi
        push esi
        call PlotPixel
        add esp, byte 0Ch
.12:
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PlotPixelRGBAt                                 115810  97 PC, low confidence
; Graphics library: (x, y, colour) entry of PlotPixelRGB
;-----------------------------------------------------------------------------
PlotPixelRGBAt:
        push ebx
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        mov ecx, dword [byte esp+010h]
        push ecx
        call PlotPixelRGB
        add esp, byte 0Ch
        pop ebx
        ret
