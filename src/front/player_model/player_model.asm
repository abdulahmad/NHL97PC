; Player models: team colours, faces, jerseys and uniforms, model parts, markers and names.
bits 32
%include "hockey.inc"
section s_56AE3 progbits alloc exec nowrite align=1
extern __CHP, __STOSB, AddBankToRange, AddColorTable, AddModelName, AllocMemBlock, AllocSpriteBuffers, AngleOfVector
extern ApplyMorphTarget, ArenaArchive, ArmLodDist, AttachModel, bcopy, BeginOffscreenRender, BindModelShapes, BlitShape2
extern BlitShapeAt, BodyArt, BuildUniformArt, CameraStateRecords, CommonArt, CreateBitmapForArt, CreateModelInstance, DebugTagStr
extern DrawFuncTable, DrawGlyphFn, DrawLimbSegment, DrawLimbSegmentFlat, DrawModel, DrawNetShadows, DrawPartCount, DrawPartsDone
extern DrawPortraitModels, DrawShadowShape, DrawSortList, DrawTextAt, EndOffscreenRender, F32_1, F32_200, F32_2000_ScaleModelLods
extern F32_20_DrawPlayerMarkers, F32_30, F32_50_DrawPlayerModel, F32_50p0_View, F32_neg20_DrawPlayerMarkers, F32_neg30, F64_0p002, F64_0p159155_DrawModelParts
extern F64_0p6_FaceDistance, F64_0p6_SetModelHeading, F64_0p785398_DrawModelParts, F64_65536_DrawModelParts, F64_FaceDistance, FaceTextureCount, FillPolygon, FillPolygonPoints
extern FindInstanceShape, FindModelName, FindModelPartByName, FindModelShapeByName, FindShape, FixedSinCos, FloatsToInts, FontGlyphColors
extern FreeBitmap, FreeFaceTextures, FreeMemBlock, FreeModelFile, FreeModelInstance, FreeReplayMem, GloveArt, GoalieStickArt
extern GoalieStickModels, HeadArt, HeadDetail, HeadLodFar, HeadLodMid, HeadLodNear, HeadModelData, HelmetArt
extern hypot_, IdentityRemap, IF@ATAN2, InitModelInstance, LetterColors, LetterMasks, LetterOffsets, LoadFaceArt
extern LoadModelByName, LoadModelFile, LoadPlayerFace, LoadResourceDataShared, LodScale, MarkerColors, MarkerPoints, MarkPaletteDirty
extern MatchColor, MatMul, MatRotY, MeasureText, ModelFileCount, ModelLoadedFlags, ModelLodFar, ModelLodNear
extern ModelPairs, ModelPartLinksLeft, ModelPartLinksRight, ModelSlotTable, ModelViewDepth, ObjectPositions, OffsetVecs, OpenArtArchiveErr
extern OpenResourceArchive, PadArt, PerspectiveScale, PickMarkerShape, PlayerArtTables, PlayerDrawParams, PlayerLodFar, PlayerLodNear
extern PlayerModelData, PlayerModels, PlayerNamesOn, PlotPixelRGBAt, PortraitModels, ProjDetailScale, ProjectCoord, ProjectModelPoints
extern ProjectPointInt, ProjectPoints, PuckArrowArt, PuckArrowColors, Random32, RemapArtBank, RemapArtPixels, RemapBankToRange
extern RenderTimersOn, ReplayRegisterObjects, ReplayRegisterStates, ResetMorphVerts, RestorePortraitCamera, RinkLineArt, SavedPalette, SavedPaletteRemap
extern SavePortraitCamera, ScaleModelVerts, SeatModelCount, SeatModelFlag, SeatModels, SeatModelSlots, SeatModelsUsed, SelectFont
extern ServiceIdle, SetArtArchive, SetDrawTarget, SetModelShape, SetPortraitProjection, SetRangeColors, SetTextColors, ShadowArt
extern ShadowLodDist, ShapePixelSize, SkateArt, SkinModel, SkinModelVerts, SortIndices, sprintf_, StickArt
extern StickLodDist, StickModels, str_04d2, str_05dFsh, str_2d, str_A2zFfn, str_ABCDEFGHIJKLM, str_Back
extern str_BOGIE, str_Cup, str_CUPP, str_Cupp, str_Cuppatch, str_D_ProjectPointsPersp, str_Face, str_Faces
extern str_Fist, str_Fron, str_Front, str_Glleg, str_GllegFsh, str_Glove, str_Gmask, str_Grleg
extern str_GrlegFsh, str_Gstick0, str_Gstick1, str_Gstick2, str_Gstick2Fsh, str_Helmet0, str_Helmet0Fsh, str_Helmet1
extern str_Helmet2, str_Helmet2Fsh, str_HndfistFsh, str_Larm, str_Lblkr, str_LblkrFsh, str_Lleg, str_Lskate0
extern str_Lskate1, str_Lskate1Fsh, str_Lstick2, str_Ltrap2, str_Marks2, str_MASK02da, str_MASK02db, str_MASK02dc
extern str_MASKSVIV, str_NumbersFfn, str_Ori, str_PAL2, str_PD, str_Player2, str_PLYRCOMNVIV, str_PlyrcomnViv
extern str_Punct_DrawRinkSurface, str_Rblkr, str_Rskate0, str_Rskate1, str_Rtrap2, str_Rtrap2Fsh, str_SHPCOPY, str_Stick0
extern str_Stick1, str_Stick2, str_Stick2Fsh, str_TeampalFsh, str_Torso0, str_Torso1, str_Torso2, str_Torso2Fsh
extern str_Uarm, str_Uleg, str_Uni04dViv, strncmp_, strncpy_, strupr_, SubVecs, SwapFaceTexture
extern TeamColorRanges, TeamColorSet, TeamColorTable, TeamModelFlags, tickcount, TransformBoneVerts, TransformTranslateVecs, TransformVecs
extern UniformArtBuf, UniformFontColors, UniformFontShadow, UpdateModelFrame, UpdateModelInstance, VecAdd, VecCross, vecdist
extern VecDistance, VecMulMat, VecSub, ViewCenterY, ViewPixelHeight, ViewPixelWidth, WritePaletteRegs
global SetTeamColours, FaceDistance, SetFaceMouth, SetFaceExpression, SetFaceBlink, SetModelHeading, BuildFaceTexturesJumpTable, BuildFaceTextures
global BuildFaceTextures_C8, BuildFaceTextures_E3, BuildFaceTextures_114, BuildFaceTextures_18F, RefreshFaceTextures, CupFaceTextures, SetModelSlotValue, SetupPlayerModel
global SetupPlayerModel_CD, SetupPlayerModel_D8, LayoutJerseyNumber, BuildCupPatchArt, DrawJerseyLettering, FreeGoalieMask, LoadCupArt, LoadGoalieMask
global LoadPlayerCommonArt, LoadUniformArt, CopyShape, SetupJerseyBackTexture, InitPlayerModelSlots, LoadGameModels, SetupTeamModels, FreeGameModels
global UpdateViewMatrix, PoseAndDrawModel, DrawModelByDetail, DrawPlayerModel, DrawPlayerModel_BC, DrawObjectShadow, DrawHeadModel, DrawLeftArmModel
global DrawLeftArmModel_80, DrawRightArmModel, DrawRightArmModel_80, DrawRightArmModel_C0, DrawRightArmModel_100, DrawRightArmModel_140, DrawRightArmModel_180, DrawStickModel
global DrawGoalieStickModel, DrawLeftHandModel, DrawRightHandModel, ScaleModelLods, SetModelExtraFlags, DrawModelParts, DrawPlayersSorted, ClearObjectHidden
global SetObjectHidden, RenderModelPortrait, DrawPuckMarker, DrawPlayerMarkers, DrawIceMarkers, DrawPlayerNames, DrawPuckArrow, NoOpDraw
global CopyVec3, SetObjectHeight, LinkModelPair, ClearModelSlots, RestoreSavedPalette, SaveGamePalette
        db 090h
;-----------------------------------------------------------------------------
; SetTeamColours                                  56AE4  97 PC, low confidence
; Sets the team colours in the palette
;-----------------------------------------------------------------------------
SetTeamColours:
        push ecx
        push esi
        push edi
        mov edi, eax
        mov esi, edx
        test edx, edx
        jl short .3
        cmp edx, byte 8
        jg short .3
        mov ecx, esi
        lea eax, [nosplit ecx*4+00h]
        add edx, 0F0h
        sub eax, ecx
        test ebx, ebx
        je short .1
        cmp byte [dword esi+TeamColorSet], 0
        jne short .3
        add eax, TeamColorTable
        push eax
        push byte 1
        push edx
        call WritePaletteRegs
        mov ch, 1
        jmp short .2
.1:
        cmp byte [dword esi+TeamColorSet], 0
        je short .3
        add eax, TeamColorRanges
        push eax
        push byte 1
        push edx
        call WritePaletteRegs
        xor ch, ch
.2:
        add esp, byte 0Ch
        mov byte [dword esi+TeamColorSet], ch
.3:
        test ebx, ebx
        je short .4
        mov dword [PlayerArtTables+274h], edi
        mov eax, dword [tickcount]
        add eax, byte 64h
        mov dword [PlayerArtTables+260h], eax
.4:
        mov dword [dword edi+0744h], ebx
        mov dword [dword edi+0740h], esi
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
        push ecx
        push edx
        mov ecx, 8
        mov eax, TeamColorSet
        xor edx, edx
        call __STOSB
        mov edx, TeamColorRanges
        mov eax, dword [RinkLineArt]
        call SetRangeColors
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FaceDistance                                    56B98  97 PC, low confidence
; Works out the distance for a face texture
;-----------------------------------------------------------------------------
FaceDistance:
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ebp, ebx
        mov edi, ecx
        fild dword [byte esp+028h]
        fmul qword [F64_0p6_FaceDistance]
        fild dword [byte esp+030h]
        lea ebx, [nosplit edx*4+00h]
        fmul qword [F64_0p6_FaceDistance]
        sub ebx, edx
        shl ebx, 2
        add ebx, edx
        shl ebx, 2
        lea edx, [dword eax+0428h]
        add ebx, edx
        lea edx, [dword eax+0190h]
        lea ecx, [dword eax+0328h]
        add eax, 2C8h
        mov esi, dword [byte esp+024h]
        mov dword [esp], eax
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 2
        lea esi, [edx+eax]
        mov eax, dword [byte esp+02Ch]
        mov dword [byte esp+04h], eax
        mov dword [byte ebx+08h], esi
        mov esi, dword [byte esp+04h]
        shl eax, 2
        sub eax, esi
        shl eax, 2
        add edx, eax
        mov eax, dword [byte esp+024h]
        shl eax, 3
        mov dword [byte ebx+0Ch], edx
        lea edx, [ecx+eax]
        mov eax, dword [byte esp+02Ch]
        mov dword [ebx], edx
        shl eax, 3
        mov edx, dword [byte esp+020h]
        add ecx, eax
        lea eax, [nosplit edx*4+00h]
        mov dword [byte ebx+024h], edi
        sub eax, edx
        mov edx, dword [esp]
        shl eax, 2
        mov dword [byte ebx+030h], ebp
        add edx, eax
        mov eax, dword [byte esp+034h]
        mov dword [byte ebx+010h], edx
        mov dword [byte ebx+020h], eax
        mov eax, dword [byte esp+018h]
        mov dword [byte ebx+028h], eax
        mov eax, dword [byte esp+01Ch]
        mov dword [byte ebx+02Ch], eax
        fxch
        fstp dword [byte ebx+014h]
        fstp dword [byte ebx+018h]
        mov edx, dword [byte ebx+0Ch]
        mov eax, dword [byte ebx+08h]
        mov dword [byte ebx+04h], ecx
        call VecDistance
        fstp dword [byte ebx+01Ch]
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret 20h
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 8
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov dword [esp], ebx
        mov dword [byte esp+04h], ecx
        fild dword [esp]
        lea eax, [nosplit edx*4+00h]
        fmul qword [F64_FaceDistance]
        sub eax, edx
        fild dword [byte esp+04h]
        shl eax, 2
        add esi, 428h
        add eax, edx
        fmul qword [F64_FaceDistance]
        fxch
        fstp dword [byte esi+eax*4+014h]
        mov edx, dword [byte ebp+0Ch]
        fstp dword [byte esi+eax*4+018h]
        mov dword [byte esi+eax*4+030h], edx
        mov esp, ebp
        pop ebp
        pop esi
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetFaceMouth                                    56CD0  97 PC, low confidence
; Sets the face mouth morph and marks the model dirty
;-----------------------------------------------------------------------------
SetFaceMouth:
        cmp edx, dword [byte eax+040h]
        je short .1
        mov dword [dword eax+0758h], 1
.1:
        mov dword [byte eax+040h], edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetFaceExpression                               56CE4  97 PC, low confidence
; Sets the face expression morph and marks the model dirty
;-----------------------------------------------------------------------------
SetFaceExpression:
        cmp edx, dword [byte eax+044h]
        je short .1
        mov dword [dword eax+0758h], 1
.1:
        mov dword [byte eax+044h], edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetFaceBlink                                    56CF8  97 PC, low confidence
; Sets the face blink morph and marks the model dirty
;-----------------------------------------------------------------------------
SetFaceBlink:
        cmp edx, dword [byte eax+048h]
        je short .1
        mov dword [dword eax+0758h], 1
.1:
        mov dword [byte eax+048h], edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetModelHeading                                 56D0C  97 PC, low confidence
; Sets the heading of a model
;-----------------------------------------------------------------------------
SetModelHeading:
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 10h
        and esp, byte 0FFFFFFF8h
        mov ecx, eax
        mov esi, edx
        test edx, edx
        sete al
        and eax, 0FFh
        lea edx, [byte eax+08h]
        test ebx, ebx
        jbe short .1
        cmp ebx, byte 2
        ja short .5
        mov eax, 14h
        mov edi, dword [PlayerArtTables+88h]
        mov dword [byte esp+0Ch], eax
        jmp short .4
.1:
        mov eax, dword [dword ecx+074Ch]
        mov edi, dword [dword ecx+06F8h]
        test eax, eax
        je short .2
        xor eax, eax
        mov dword [esp], eax
        mov dword [byte esp+04h], 40340000h
        jmp short .3
.2:
        mov dword [esp], eax
        mov dword [byte esp+04h], 403E0000h
.3:
        fld qword [esp]
        call __CHP
        fistp dword [byte esp+0Ch]
        mov eax, dword [byte esp+0Ch]
.4:
        mov dword [byte esp+08h], eax
.5:
        fild dword [byte esp+08h]
        fmul qword [F64_0p6_SetModelHeading]
        fild dword [byte esp+0Ch]
        lea eax, [nosplit edx*4+00h]
        fmul qword [F64_0p6_SetModelHeading]
        sub eax, edx
        shl eax, 2
        add eax, edx
        shl eax, 2
        lea edx, [dword ecx+0428h]
        add eax, edx
        fxch
        fstp dword [byte eax+014h]
        fstp dword [byte eax+018h]
        mov dword [byte eax+030h], edi
        test esi, esi
        je short .6
        mov dword [byte ecx+030h], ebx
        jmp short .7
.6:
        mov dword [byte ecx+02Ch], ebx
.7:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
BuildFaceTexturesJumpTable:                     ; jump table for the switch cases of BuildFaceTextures
        dd BuildFaceTextures_E3
        dd BuildFaceTextures_114
        dd BuildFaceTextures_18F
        dd BuildFaceTextures_C8
;-----------------------------------------------------------------------------
; BuildFaceTextures                               56DDC  97 PC, low confidence
; Builds the face textures
;-----------------------------------------------------------------------------
BuildFaceTextures:
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 30h
        mov dword [byte ebp-08h], edx
        mov dword [byte ebp-0Ch], ebx
        mov ebx, eax
        shl eax, 4
        sub eax, ebx
        shl eax, 2
        sub eax, ebx
        mov esi, ObjectPositions
        shl eax, 5
        lea edi, [nosplit edx*4+00h]
        add esi, eax
        mov eax, dword [dword edi+PlayerArtTables+19Ch]
        mov ebx, dword [byte eax+02h]
        mov edx, dword [byte eax+04h]
        sar ebx, 10h
        sar edx, 10h
        imul edx, ebx
        add edx, byte 10h
        push edx
        mov edx, dword [dword esi+06E4h]
        push edx
        push eax
        mov ebx, esi
        call bcopy
        lea eax, [byte esi+0Ch]
        add esp, byte 0Ch
        mov dword [byte ebp-04h], eax
.1:
        mov ecx, dword [dword edi+PlayerArtTables+168h]
        push ecx
        push str_Front
        mov eax, dword [dword ebx+06D8h]
        push eax
        call FindInstanceShape
        add esp, byte 8
        push eax
        mov edx, dword [dword ebx+06D8h]
        push edx
        add ebx, byte 4
        call SetModelShape
        mov ecx, dword [byte ebp-04h]
        add esp, byte 0Ch
        cmp ebx, ecx
        jne short .1
        mov dword [dword esi+0750h], 0
        mov eax, dword [dword esi+0750h]
        mov dword [dword esi+074Ch], eax
        mov dword [byte esi+034h], eax
        mov eax, dword [byte ebp-08h]
        mov dword [dword esi+0700h], eax
        mov eax, dword [byte ebp-0Ch]
        cmp eax, byte 3
        ja near BuildFaceTextures_18F.9
        jmp dword [nosplit cs:eax*4+BuildFaceTexturesJumpTable]
BuildFaceTextures_C8:
        mov dword [dword esi+073Ch], 0
        mov dword [byte esi+0Ch], 3FC90FDBh
        mov dword [dword esi+0750h], 1
BuildFaceTextures_E3:
        cmp dword [byte esi+028h], byte 0
        je short .2
        mov eax, PlayerArtTables+8Ch
        jmp short .3
.2:
        mov eax, PlayerArtTables+24h
.3:
        mov ebx, dword [byte ebp-08h]
        mov dword [dword esi+06C0h], eax
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        mov edx, PlayerArtTables+0C8h
        shl eax, 2
        jmp near BuildFaceTextures_18F.8
BuildFaceTextures_114:
        mov eax, dword [dword edi+PlayerArtTables+60h]
        mov dword [dword esi+06C4h], eax
        mov eax, dword [dword edi+PlayerArtTables+140h]
        mov edx, dword [byte esi+028h]
        mov dword [dword esi+06C8h], eax
        test edx, edx
        je short .4
        mov eax, dword [dword edi+PlayerArtTables+0B0h]
        jmp short .5
.4:
        mov eax, dword [dword edi+PlayerArtTables+0F8h]
.5:
        mov dword [dword esi+06CCh], eax
        mov eax, dword [byte ebp-08h]
        mov ebx, dword [byte esi+028h]
        shl eax, 2
        test ebx, ebx
        je short .6
        mov eax, dword [dword eax+PlayerArtTables+7Ch]
        jmp short .7
.6:
        mov eax, dword [dword eax+PlayerArtTables+098h]
.7:
        mov dword [dword esi+06D0h], eax
        mov ebx, dword [byte ebp-08h]
        lea eax, [nosplit ebx*4+00h]
        mov edx, PlayerArtTables+110h
        sub eax, ebx
        mov dword [dword esi+06C0h], PlayerArtTables+0BCh
        shl eax, 2
        mov dword [byte esi+034h], 1
        jmp short BuildFaceTextures_18F.8
BuildFaceTextures_18F:
        mov ebx, dword [byte ebp-08h]
        lea eax, [nosplit ebx*4+00h]
        mov edx, PlayerArtTables+0C8h
        sub eax, ebx
        mov dword [dword esi+074Ch], 1
        shl eax, 2
        mov dword [byte esi+038h], 0
.8:
        add edx, eax
        mov dword [dword esi+06BCh], edx
.9:
        push byte 1
        push byte 1Fh
        push byte 4
        push byte 23h
        push byte 3
        mov ecx, 0FFFF87D1h
        push byte 3
        mov edi, dword [PlayerArtTables+4]
        mov edx, 2
        push edi
        mov eax, dword [PlayerArtTables]
        mov edi, dword [byte ebp-08h]
        push eax
        shl edi, 2
        mov eax, esi
        mov ebx, dword [dword edi+PlayerArtTables+104h]
        call FaceDistance
        push byte 0
        push byte 1Fh
        push byte 7
        push byte 23h
        push byte 6
        push byte 2
        mov edx, dword [PlayerArtTables+4]
        mov ecx, 0FFFF87D1h
        push edx
        mov ebx, dword [PlayerArtTables]
        mov eax, esi
        push ebx
        mov edx, 4
        mov ebx, dword [dword edi+PlayerArtTables+104h]
        call FaceDistance
        push byte 1
        push byte 12h
        push byte 5
        push byte 1Ah
        push byte 4
        push byte 3
        mov ecx, dword [PlayerArtTables+4]
        mov edx, 3
        push ecx
        mov eax, dword [PlayerArtTables]
        mov ebx, dword [dword edi+PlayerArtTables+0ECh]
        push eax
        mov ecx, 782Fh
        mov eax, esi
        call FaceDistance
        push byte 0
        push byte 12h
        push byte 8
        push byte 1Ah
        push byte 7
        push byte 2
        mov edx, dword [PlayerArtTables+4]
        mov ecx, 782Fh
        push edx
        mov ebx, dword [PlayerArtTables]
        mov eax, esi
        push ebx
        mov edx, 5
        mov ebx, dword [dword edi+PlayerArtTables+0ECh]
        call FaceDistance
        push byte 1
        push byte 34h
        push byte 0Dh
        push byte 39h
        push byte 0Ch
        push byte 1
        mov ecx, dword [PlayerArtTables+4]
        mov edx, 6
        push ecx
        mov eax, dword [PlayerArtTables]
        mov ebx, dword [dword edi+PlayerArtTables+70h]
        push eax
        mov ecx, 0FFFFF448h
        mov eax, esi
        call FaceDistance
        push byte 0
        push byte 34h
        push byte 0Ah
        push byte 39h
        push byte 9
        push byte 0
        mov edx, dword [PlayerArtTables+4]
        mov ecx, 0FFFFF448h
        push edx
        mov ebx, dword [PlayerArtTables]
        mov eax, esi
        push ebx
        mov edx, 7
        mov ebx, dword [dword edi+PlayerArtTables+70h]
        call FaceDistance
        push byte 1
        push byte 19h
        push byte 0Eh
        push byte 30h
        push byte 0Dh
        push byte 1
        mov ecx, dword [PlayerArtTables+4]
        mov eax, dword [PlayerArtTables]
        push ecx
        mov ebx, dword [dword edi+PlayerArtTables+54h]
        xor edx, edx
        push eax
        xor ecx, ecx
        mov eax, esi
        call FaceDistance
        push byte 0
        push byte 19h
        push byte 0Bh
        push byte 30h
        push byte 0Ah
        push byte 0
        mov edx, dword [PlayerArtTables+4]
        mov ebx, dword [PlayerArtTables]
        push edx
        mov eax, esi
        xor ecx, ecx
        push ebx
        mov edx, 1
        mov ebx, dword [dword edi+PlayerArtTables+54h]
        call FaceDistance
        mov eax, dword [dword edi+PlayerArtTables+3Ch]
        mov ecx, dword [dword esi+074Ch]
        mov dword [dword esi+06F8h], eax
        test ecx, ecx
        sete al
        and eax, 0FFh
        push eax
        test ecx, ecx
        je short .10
        xor ebx, ebx
        mov ecx, 40340000h
        mov dword [byte ebp-028h], ebx
        mov dword [byte ebp-024h], ecx
        jmp short .11
.10:
        mov edx, 403E0000h
        mov dword [byte ebp-028h], ecx
        mov dword [byte ebp-024h], edx
.11:
        fld qword [byte ebp-028h]
        call __CHP
        fistp dword [byte ebp-010h]
        mov edi, dword [byte ebp-010h]
        push edi
        mov eax, dword [dword esi+074Ch]
        push byte 13h
        test eax, eax
        je short .12
        xor ecx, ecx
        mov edi, 40340000h
        mov dword [byte ebp-018h], ecx
        mov dword [byte ebp-014h], edi
        jmp short .13
.12:
        mov ebx, 403E0000h
        mov dword [byte ebp-018h], eax
        mov dword [byte ebp-014h], ebx
.13:
        fld qword [byte ebp-018h]
        call __CHP
        fistp dword [byte ebp-010h]
        mov eax, dword [byte ebp-010h]
        push eax
        mov edx, dword [dword esi+074Ch]
        push byte 8
        test edx, edx
        je short .14
        mov eax, 6
        jmp short .15
.14:
        mov eax, 2
.15:
        mov edx, 9
        push eax
        mov ebx, dword [PlayerArtTables+4]
        mov ecx, dword [PlayerArtTables]
        push ebx
        mov eax, esi
        mov ebx, dword [byte ebp-08h]
        push ecx
        mov ecx, 782Fh
        mov ebx, dword [nosplit ebx*4+PlayerArtTables+3Ch]
        call FaceDistance
        mov edi, dword [dword esi+074Ch]
        test edi, edi
        setne al
        and eax, 0FFh
        push eax
        test edi, edi
        je short .16
        xor ecx, ecx
        mov edi, 40340000h
        mov dword [byte ebp-020h], ecx
        mov dword [byte ebp-01Ch], edi
        jmp short .17
.16:
        mov ebx, 403E0000h
        mov dword [byte ebp-020h], edi
        mov dword [byte ebp-01Ch], ebx
.17:
        fld qword [byte ebp-020h]
        call __CHP
        fistp dword [byte ebp-010h]
        mov eax, dword [byte ebp-010h]
        push eax
        mov edx, dword [dword esi+074Ch]
        push byte 12h
        test edx, edx
        je short .18
        xor edi, edi
        mov eax, 40340000h
        mov dword [byte ebp-030h], edi
        mov dword [byte ebp-02Ch], eax
        jmp short .19
.18:
        mov ecx, 403E0000h
        mov dword [byte ebp-030h], edx
        mov dword [byte ebp-02Ch], ecx
.19:
        fld qword [byte ebp-030h]
        call __CHP
        fistp dword [byte ebp-010h]
        mov edx, dword [byte ebp-010h]
        push edx
        mov ebx, dword [dword esi+074Ch]
        push byte 5
        test ebx, ebx
        je short .20
        mov eax, 7
        jmp short .21
.20:
        mov eax, 3
.21:
        mov ebx, dword [byte ebp-08h]
        push eax
        mov ecx, dword [PlayerArtTables+4]
        mov edx, 8
        push ecx
        mov edi, dword [PlayerArtTables]
        mov eax, esi
        push edi
        mov ebx, dword [nosplit ebx*4+PlayerArtTables+3Ch]
        mov ecx, 782Fh
        call FaceDistance
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; RefreshFaceTextures                             57298  97 PC, low confidence
; Refreshes the face textures
;-----------------------------------------------------------------------------
RefreshFaceTextures:
        push ebx
        push ecx
        mov ecx, eax
        mov ebx, edx
        mov edx, eax
        shl eax, 4
        sub eax, ecx
        shl eax, 2
        sub eax, ecx
        shl eax, 5
        add eax, ObjectPositions
        mov dword [byte eax+034h], ebx
        test ebx, ebx
        setne al
        xor ebx, ebx
        mov bl, al
        cmp ecx, byte 5
        setg al
        xor edx, ecx
        mov dl, al
        mov eax, ecx
        call BuildFaceTextures
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CupFaceTextures                                 572D4  97 PC, low confidence
; Builds the face textures for the cup celebration
;-----------------------------------------------------------------------------
CupFaceTextures:
        push ecx
        push esi
        mov ecx, eax
        mov esi, edx
        shl eax, 4
        sub eax, ecx
        shl eax, 2
        sub eax, ecx
        shl eax, 5
        add eax, ObjectPositions
        mov dword [byte eax+034h], ebx
        test ebx, ebx
        setne al
        xor ebx, ebx
        mov bl, al
        mov eax, ecx
        call BuildFaceTextures
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetModelSlotValue                               57304  97 PC, low confidence
; Sets a model slot value
;-----------------------------------------------------------------------------
SetModelSlotValue:
        push edx
        mov edx, eax
        shl eax, 4
        sub eax, edx
        shl eax, 2
        sub eax, edx
        shl eax, 5
        add eax, ObjectPositions
        mov edx, dword [byte esp+08h]
        mov dword [byte eax+03Ch], edx
        pop edx
        ret 4
;-----------------------------------------------------------------------------
; SetupPlayerModel                                57324  97 PC, low confidence
; Builds a player's 3D model: jersey, number and team textures for one roster
; slot
;-----------------------------------------------------------------------------
SetupPlayerModel:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, eax
        mov ecx, edx
        shl eax, 4
        sub eax, esi
        shl eax, 2
        sub eax, esi
        mov edi, ObjectPositions
        shl eax, 5
        add edi, eax
        lea ebp, [dword edi+06E8h]
        mov ebx, 5
        mov eax, ebp
        call strncmp_
        test eax, eax
        je near SetupPlayerModel_CD
        mov ebx, 5
        mov edx, ecx
        mov eax, ebp
        call strncpy_
        mov edx, 1
        mov ebx, esp
        mov eax, esi
        mov dword [ModelFileCount], edx
        mov edx, ecx
        call LoadPlayerFace
        mov ebx, PlayerModels
        mov dword [dword edi+06F0h], eax
        xor ecx, ecx
        mov edx, dword [esp]
        mov eax, dword [ArenaArchive]
        call RemapArtPixels
        mov eax, dword [FaceTextureCount]
        mov ebx, dword [dword edi+06F0h]
        mov dword [dword edi+06D4h], eax
        xor ebp, ebp
        mov edx, dword [byte edi+054h]
        mov ebx, dword [byte ebx+070h]
        xor esi, esi
        call SkinModelVerts
.1:
        mov ebx, esi
        mov ecx, dword [dword edi+06F0h]
        mov edx, ebp
        mov eax, dword [dword edi+06D4h]
        mov ecx, dword [byte ecx+070h]
        inc esi
        call TransformBoneVerts
        cmp esi, byte 5
        jl short .1
        mov ebx, dword [dword edi+06F0h]
        push ebx
        call ResetMorphVerts
        xor ecx, ecx
        add esp, byte 4
        mov dword [ModelFileCount], ecx
SetupPlayerModel_CD:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
SetupPlayerModel_D8:
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov esi, dword [byte esp+038h]
        mov dword [byte esp+014h], eax
        mov dword [byte esp+08h], edx
        mov edx, ecx
        xor ecx, ecx
        mov edi, dword [byte esp+034h]
        mov dword [byte esp+010h], ecx
        test edi, edi
        jle near .7
        mov eax, edx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov dword [byte esp+04h], esi
        mov dword [esp], eax
        imul eax, esi, byte 0
        add ebx, byte 10h
        add eax, ebx
        imul esi, dword [byte esp+02Ch]
        add eax, esi
        mov dword [byte esp+0Ch], eax
.2:
        mov esi, dword [byte esp+0Ch]
        mov ecx, dword [esp]
        mov edi, dword [byte esp+030h]
        xor ebx, ebx
        add esi, ecx
        test edi, edi
        jle near .6
        mov eax, dword [byte esp+08h]
        mov edx, dword [byte esp+010h]
        mov edi, dword [byte esp+014h]
        add eax, edx
        inc edi
        mov dword [byte esp+018h], eax
.3:
        xor eax, eax
        mov al, byte [esi]
        mov edx, eax
        inc esi
        and edx, 0F0h
        mov ebp, eax
        sar edx, 4
        and ebp, byte 0Fh
        test edx, edx
        je short .4
        shl edx, 2
        add edx, FontGlyphColors
        mov ecx, dword [edx]
        push ecx
        mov eax, dword [byte esp+01Ch]
        push eax
        mov eax, dword [byte esp+01Ch]
        add eax, ebx
        push eax
        call PlotPixelRGBAt
        add esp, byte 0Ch
.4:
        test ebp, ebp
        je short .5
        shl ebp, 2
        add ebp, FontGlyphColors
        mov edx, dword [byte ebp+00h]
        push edx
        mov ecx, dword [byte esp+01Ch]
        push ecx
        push edi
        call PlotPixelRGBAt
        add esp, byte 0Ch
.5:
        mov ebp, dword [byte esp+030h]
        add ebx, byte 2
        add edi, byte 2
        cmp ebx, ebp
        jl short .3
.6:
        mov eax, dword [byte esp+04h]
        mov ebp, dword [byte esp+0Ch]
        add ebp, eax
        mov eax, dword [byte esp+010h]
        mov edx, dword [byte esp+034h]
        inc eax
        mov dword [byte esp+0Ch], ebp
        mov dword [byte esp+010h], eax
        cmp eax, edx
        jl near .2
.7:
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        ret 10h
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LayoutJerseyNumber                              57504  97 PC, low confidence
; Lays out the digits of a jersey number on the back and sleeve texture
;-----------------------------------------------------------------------------
LayoutJerseyNumber:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov dword [byte esp+04h], eax
        mov dword [byte esp+08h], edx
        mov ebp, FontGlyphColors
        mov ebx, 1
        xor edx, edx
        mov esi, 5
        mov dword [FontGlyphColors], edx
        lea ecx, [byte ebp+04h]
.1:
        xor edx, edx
        mov dl, byte [byte esp+07h]
        imul edx, ebx
        mov eax, edx
        sar edx, 1Fh
        idiv esi
        xor edx, edx
        mov dl, byte [byte esp+06h]
        imul edx, ebx
        mov byte [byte ecx+03h], al
        mov eax, edx
        sar edx, 1Fh
        idiv esi
        xor edx, edx
        mov dl, byte [byte esp+05h]
        imul edx, ebx
        mov byte [byte ecx+02h], al
        mov eax, edx
        sar edx, 1Fh
        idiv esi
        xor edx, edx
        mov dl, byte [byte esp+04h]
        imul edx, ebx
        mov byte [byte ecx+01h], al
        mov eax, edx
        sar edx, 1Fh
        idiv esi
        add ecx, byte 4
        inc ebx
        mov byte [byte ecx-04h], al
        cmp ebx, byte 5
        jl short .1
        mov eax, dword [byte esp+04h]
        mov ebx, 1
        mov ecx, 5
        lea esi, [byte ebp+04h]
        mov dword [byte ebp+014h], eax
.2:
        xor edx, edx
        mov dl, byte [byte esp+07h]
        imul edx, ecx
        mov edi, 6
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        xor edx, edx
        mov dl, byte [byte esp+0Bh]
        imul edx, ebx
        mov dword [esp], 6
        mov edi, eax
        mov eax, edx
        sar edx, 1Fh
        idiv dword [esp]
        xor edx, edx
        mov dl, byte [byte esp+06h]
        imul edx, ecx
        add eax, edi
        mov edi, 6
        mov byte [byte esi+017h], al
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        xor edx, edx
        mov dl, byte [byte esp+0Ah]
        imul edx, ebx
        mov dword [esp], 6
        mov edi, eax
        mov eax, edx
        sar edx, 1Fh
        idiv dword [esp]
        xor edx, edx
        mov dl, byte [byte esp+05h]
        imul edx, ecx
        add eax, edi
        mov edi, 6
        mov byte [byte esi+016h], al
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        xor edx, edx
        mov dl, byte [byte esp+09h]
        imul edx, ebx
        mov dword [esp], 6
        mov edi, eax
        mov eax, edx
        sar edx, 1Fh
        idiv dword [esp]
        xor edx, edx
        mov dl, byte [byte esp+04h]
        imul edx, ecx
        add eax, edi
        mov edi, 6
        mov byte [byte esi+015h], al
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        xor edx, edx
        mov dl, byte [byte esp+08h]
        imul edx, ebx
        mov dword [esp], 6
        mov edi, eax
        mov eax, edx
        sar edx, 1Fh
        idiv dword [esp]
        add esi, byte 4
        dec ecx
        add eax, edi
        inc ebx
        mov byte [byte esi+010h], al
        cmp ebx, byte 6
        jl near .2
        mov eax, dword [byte esp+08h]
        lea ebx, [byte ebp+04h]
        mov ecx, 4
        lea esi, [byte ebp+014h]
        mov dword [byte ebp+02Ch], eax
        mov edi, 5
.3:
        xor edx, edx
        mov dl, byte [byte esp+0Bh]
        imul edx, ecx
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        xor edx, edx
        mov dl, byte [byte esp+0Ah]
        imul edx, ecx
        mov byte [byte ebx+02Fh], al
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        xor edx, edx
        mov dl, byte [byte esp+09h]
        imul edx, ecx
        mov byte [byte ebx+02Eh], al
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        xor edx, edx
        mov dl, byte [byte esp+08h]
        imul edx, ecx
        mov byte [byte ebx+02Dh], al
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        add ebx, byte 4
        dec ecx
        mov byte [byte ebx+028h], al
        cmp ebx, esi
        jne short .3
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; BuildCupPatchArt                                576EC  97 PC, low confidence
; Builds the championship patch art for the jersey
;-----------------------------------------------------------------------------
BuildCupPatchArt:
        push ebx
        push ecx
        push edx
        push byte 20h
        mov edx, dword [nosplit eax*4+PlayerArtTables+168h]
        push edx
        call CreateBitmapForArt
        add esp, byte 8
        push eax
        mov ebx, eax
        call SetDrawTarget
        add esp, byte 4
        push str_CUPP
        mov ecx, dword [PlayerArtTables+1ECh]
        push ecx
        call FindShape
        add esp, byte 8
        push eax
        call BlitShape2
        add esp, byte 4
        push ebx
        call FreeBitmap
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawJerseyLettering                             57738  97 PC, low confidence
; Draws the name and number lettering onto a jersey texture
;-----------------------------------------------------------------------------
DrawJerseyLettering:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov edi, edx
        mov ebp, ebx
        mov esi, eax
        shl esi, 4
        sub esi, eax
        shl esi, 2
        sub esi, eax
        shl esi, 5
        add esi, ObjectPositions
        cmp dword [dword esi+074Ch], byte 0
        jne near .1
        mov eax, dword [dword esi+0700h]
        mov eax, dword [nosplit eax*4+PlayerArtTables+19Ch]
        call ShapePixelSize
        push eax
        mov ebx, dword [dword esi+06E4h]
        mov eax, dword [dword esi+0700h]
        push ebx
        mov ecx, dword [nosplit eax*4+PlayerArtTables+19Ch]
        push ecx
        call bcopy
        add esp, byte 0Ch
        push byte 20h
        mov eax, dword [dword esi+06E4h]
        push eax
        call CreateBitmapForArt
        add esp, byte 8
        push eax
        mov dword [byte esp+08h], eax
        call SetDrawTarget
        mov eax, dword [dword esi+0700h]
        add esp, byte 4
        mov edx, dword [nosplit eax*4+PlayerArtTables+30h]
        push edx
        mov ebx, 14h
        call SelectFont
        add esp, byte 4
        lea ecx, [byte esi+014h]
        mov edx, edi
        mov eax, ecx
        call strncpy_
        mov eax, ecx
        mov byte [byte esi+027h], 0
        call strupr_
        push ecx
        call MeasureText
        mov edi, dword [dword esi+0700h]
        add esp, byte 4
        mov edi, dword [nosplit edi*4+PlayerArtTables+14Ch]
        push byte 0
        mov ecx, dword [nosplit edi*4+LetterColors]
        push ecx
        mov ebx, eax
        call MatchColor
        add esp, byte 4
        push eax
        call SetTextColors
        add esp, byte 8
        cmp edi, byte 1Fh
        sete al
        and eax, 0FFh
        shl eax, 3
        mov edx, ebx
        add eax, byte 0Ch
        sar edx, 1Fh
        push eax
        mov eax, ebx
        LD sub, eax, edx
        sar eax, 1
        mov edx, 29h
        sub edx, eax
        push edx
        lea eax, [byte esi+014h]
        push eax
        call DrawTextAt
        mov eax, dword [dword esi+0700h]
        add esp, byte 0Ch
        mov edx, dword [nosplit eax*4+PlayerArtTables+190h]
        push edx
        call SelectFont
        add esp, byte 4
        mov edx, dword [nosplit edi*8+LetterOffsets]
        mov eax, dword [nosplit edi*8+LetterMasks]
        call LayoutJerseyNumber
        push ebp
        mov ebx, SetupPlayerModel_D8
        push str_2d
        lea eax, [byte esp+08h]
        mov dword [DrawGlyphFn], ebx
        push eax
        mov dword [byte esi+010h], ebp
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        call MeasureText
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 4
        mov edx, 29h
        push byte 1Ah
        sub edx, eax
        push edx
        lea eax, [byte esp+08h]
        push eax
        call DrawTextAt
        add esp, byte 0Ch
        mov ecx, dword [byte esp+04h]
        push ecx
        call FreeBitmap
        add esp, byte 4
.1:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FreeGoalieMask                                  578D4  97 PC, low confidence
; Frees the goalie mask texture
;-----------------------------------------------------------------------------
FreeGoalieMask:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov esi, eax
        lea ebx, [nosplit eax*4+00h]
        sub ebx, eax
        lea esi, [nosplit ebx*4+00h]
        cmp dword [dword esi+PlayerArtTables+220h], byte 0
        je short .2
        mov ebx, esi
        add esi, byte 0Ch
.1:
        mov ecx, dword [dword ebx+PlayerArtTables+110h]
        push ecx
        call FreeModelInstance
        add esp, byte 4
        mov ebp, dword [dword ebx+PlayerArtTables+220h]
        xor edi, edi
        push ebp
        mov dword [dword ebx+PlayerArtTables+110h], edi
        call FreeModelFile
        add esp, byte 4
        mov edx, dword [dword ebx+PlayerArtTables+1B0h]
        add ebx, byte 4
        push edx
        mov dword [dword ebx+PlayerArtTables+21Ch], edi
        call FreeMemBlock
        add esp, byte 4
        mov dword [dword ebx+PlayerArtTables+1ACh], edi
        cmp ebx, esi
        jne short .1
.2:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LoadCupArt                                      5794C  97 PC, low confidence
; (team): loads the "cup" shape from PLYRCOMN.VIV into the team record
; (+6C0h)
;-----------------------------------------------------------------------------
LoadCupArt:
        push ebx
        push ecx
        push edx
        push esi
        mov edx, eax
        shl eax, 4
        sub eax, edx
        shl eax, 2
        sub eax, edx
        mov esi, ObjectPositions
        shl eax, 5
        add esi, eax
        mov eax, str_PLYRCOMNVIV
        xor edx, edx
        call SetArtArchive
        mov eax, str_Cup
        call LoadModelByName
        push eax
        mov dword [PlayerArtTables+21Ch], eax
        call InitModelInstance
        add esp, byte 4
        mov edx, dword [PlayerArtTables+264h]
        mov eax, dword [PlayerArtTables+21Ch]
        call AttachModel
        mov eax, dword [PlayerArtTables+21Ch]
        push byte 0
        add eax, byte 2Ch
        push eax
        xor ebx, ebx
        call OpenArtArchiveErr
        mov ecx, dword [ArenaArchive]
        add esp, byte 8
        mov dword [PlayerArtTables+1FCh], eax
        mov edx, eax
        mov eax, ecx
        call RemapBankToRange
        mov ebx, 0Ah
        mov eax, dword [PlayerArtTables+21Ch]
        xor edx, edx
        call CreateModelInstance
        mov dword [PlayerArtTables+17Ch], eax
        push eax
        mov dword [PlayerArtTables+178h], eax
        mov dword [PlayerArtTables+174h], eax
        call UpdateModelInstance
        add esp, byte 4
        mov edx, dword [PlayerArtTables+1FCh]
        push edx
        mov ebx, dword [PlayerArtTables+174h]
        push ebx
        call BindModelShapes
        add esp, byte 8
        push byte 0
        mov dword [dword esi+06C0h], PlayerArtTables+174h
        call OpenResourceArchive
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LoadGoalieMask                                  57A1C  97 PC, low confidence
; (team, mask): loads the MASK%02da/b/c shapes from MASKS.VIV ("gmask")
;-----------------------------------------------------------------------------
LoadGoalieMask:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 28h
        mov ebx, eax
        mov esi, edx
        shl eax, 2
        sub eax, ebx
        mov edx, 1
        mov ecx, dword [nosplit eax*4+PlayerArtTables+220h]
        mov dword [ModelFileCount], edx
        test ecx, ecx
        je short .1
        mov eax, ebx
        call FreeGoalieMask
        mov dword [byte esp+024h], edx
        jmp short .2
.1:
        mov dword [byte esp+024h], ecx
.2:
        mov eax, str_MASKSVIV
        call SetArtArchive
        push esi
        push str_MASK02da
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        xor edx, edx
        mov eax, esp
        call LoadModelByName
        mov edx, eax
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        push esi
        lea ebx, [nosplit eax*4+00h]
        push str_MASK02db
        lea eax, [byte esp+08h]
        push eax
        mov dword [dword ebx+PlayerArtTables+220h], edx
        call sprintf_
        add esp, byte 0Ch
        xor edx, edx
        mov eax, esp
        call LoadModelByName
        push esi
        mov dword [dword ebx+PlayerArtTables+224h], eax
        push str_MASK02dc
        lea eax, [byte esp+08h]
        mov edi, ebx
        push eax
        xor edx, edx
        mov esi, ebx
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        add ebx, byte 0Ch
        call LoadModelByName
        mov dword [byte esp+020h], ebx
        mov dword [dword ebx+PlayerArtTables+21Ch], eax
.3:
        mov eax, dword [dword esi+PlayerArtTables+220h]
        push eax
        call InitModelInstance
        add esp, byte 4
        mov edx, dword [PlayerArtTables+264h]
        mov eax, dword [dword esi+PlayerArtTables+220h]
        call AttachModel
        mov eax, dword [dword esi+PlayerArtTables+220h]
        push byte 0
        add eax, byte 2Ch
        push eax
        call OpenArtArchiveErr
        add esp, byte 8
        mov edx, eax
        mov ebp, eax
        mov ebx, dword [byte esp+024h]
        mov dword [dword esi+PlayerArtTables+1B0h], eax
        test ebx, ebx
        je short .4
        mov eax, dword [ArenaArchive]
        xor ebx, ebx
        call RemapBankToRange
        jmp short .5
.4:
        mov eax, dword [ArenaArchive]
        mov ebx, edx
        xor ecx, ecx
        mov edx, eax
        mov eax, str_Gmask
        call RemapArtBank
.5:
        mov ebx, 0Ah
        mov eax, dword [dword edi+PlayerArtTables+220h]
        xor edx, edx
        call CreateModelInstance
        push eax
        mov ebx, eax
        mov dword [dword edi+PlayerArtTables+110h], eax
        call UpdateModelInstance
        add esp, byte 4
        push ebp
        push ebx
        call BindModelShapes
        add esp, byte 8
        add edi, byte 4
        mov ecx, dword [byte esp+020h]
        add esi, byte 4
        cmp edi, ecx
        jne near .3
        push byte 0
        call OpenResourceArchive
        xor esi, esi
        add esp, byte 4
        mov dword [ModelFileCount], esi
        add esp, byte 28h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadPlayerCommonArt                             57BA4  97 PC, low confidence
; Loads plyrcomn.viv: team palette, fist and torso shapes
;-----------------------------------------------------------------------------
LoadPlayerCommonArt:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov eax, str_PlyrcomnViv
        call SetArtArchive
        push byte 20h
        push str_TeampalFsh
        call OpenArtArchiveErr
        add esp, byte 8
        push str_PAL2
        push eax
        mov ebp, eax
        call FindShape
        add esp, byte 8
        lea esi, [byte eax+010h]
        call ServiceIdle
        push byte 0
        push str_HndfistFsh
        mov ebx, PlayerArtTables+4
        call OpenArtArchiveErr
        add esp, byte 8
        mov edx, PlayerArtTables
        mov dword [PlayerArtTables+1E8h], eax
        call BuildUniformArt
        mov ecx, esi
        push byte 0
        mov ebx, dword [PlayerArtTables+1E8h]
        mov edx, dword [ArenaArchive]
        mov dword [PlayerArtTables+88h], eax
        mov eax, str_Fist
        call AddBankToRange
        call ServiceIdle
        mov eax, str_Torso0
        xor edx, edx
        call LoadModelByName
        mov dword [PlayerArtTables+284h], eax
        xor edx, edx
        mov eax, str_Torso1
        call LoadModelByName
        mov dword [PlayerArtTables+288h], eax
        xor edx, edx
        mov eax, str_Torso2
        xor esi, esi
        call LoadModelByName
        mov dword [PlayerArtTables+28Ch], eax
.1:
        mov edx, dword [dword esi+PlayerArtTables+284h]
        push edx
        call InitModelInstance
        mov edx, dword [PlayerArtTables+264h]
        add esp, byte 4
        mov eax, dword [dword esi+PlayerArtTables+284h]
        add esi, byte 4
        call AttachModel
        cmp esi, byte 0Ch
        jne short .1
        xor ebx, ebx
        xor esi, esi
.2:
        push esi
        push str_PD
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        mov ecx, dword [PlayerArtTables+28Ch]
        push ecx
        add ebx, byte 4
        inc esi
        call FindModelPartByName
        add esp, byte 8
        mov dword [dword ebx+BodyArt], eax
        cmp esi, byte 0Ah
        jl short .2
        call ServiceIdle
        mov eax, str_Helmet0
        xor edx, edx
        call LoadModelByName
        push str_Face
        push eax
        mov dword [PlayerArtTables+254h], eax
        call FindModelShapeByName
        add esp, byte 8
        mov dword [PlayerArtTables+290h], eax
        xor edx, edx
        mov eax, str_Helmet1
        call LoadModelByName
        push str_Face
        push eax
        mov dword [PlayerArtTables+258h], eax
        call FindModelShapeByName
        add esp, byte 8
        mov dword [HeadDetail], eax
        xor edx, edx
        mov eax, str_Helmet2
        call LoadModelByName
        push str_Face
        push eax
        xor esi, esi
        mov dword [PlayerArtTables+25Ch], eax
        call FindModelShapeByName
        add esp, byte 8
        mov dword [HeadModelData], eax
.3:
        mov edi, dword [dword esi+PlayerArtTables+254h]
        push edi
        call InitModelInstance
        mov edx, dword [PlayerArtTables+264h]
        add esp, byte 4
        mov eax, dword [dword esi+PlayerArtTables+254h]
        add esi, byte 4
        call AttachModel
        cmp esi, byte 0Ch
        jne short .3
        call ServiceIdle
        mov eax, str_Stick0
        xor edx, edx
        call LoadModelByName
        mov dword [SkateArt], eax
        xor edx, edx
        mov eax, str_Stick1
        call LoadModelByName
        mov dword [GloveArt], eax
        xor edx, edx
        mov eax, str_Stick2
        call LoadModelByName
        mov dword [HelmetArt], eax
        xor edx, edx
        mov eax, str_Lstick2
        xor esi, esi
        call LoadModelByName
        mov dword [PadArt], eax
.4:
        mov eax, dword [dword esi+SkateArt]
        push eax
        call InitModelInstance
        mov edx, dword [PlayerArtTables+264h]
        add esp, byte 4
        mov eax, dword [dword esi+SkateArt]
        add esi, byte 4
        call AttachModel
        cmp esi, byte 10h
        jne short .4
        call ServiceIdle
        push byte 0
        push str_Stick2Fsh
        call OpenArtArchiveErr
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        mov dword [PlayerArtTables+18Ch], eax
        mov edi, eax
        mov ebx, eax
        xor ecx, ecx
        mov eax, str_Ori
        xor esi, esi
        call RemapArtBank
.5:
        mov ebx, 0Ah
        mov eax, dword [dword esi+SkateArt]
        xor edx, edx
        call CreateModelInstance
        push edi
        add esi, byte 4
        push eax
        mov dword [dword esi+PlayerArtTables+20h], eax
        call BindModelShapes
        add esp, byte 8
        cmp esi, byte 0Ch
        jne short .5
        mov eax, dword [PlayerArtTables+24h]
        mov ebx, 0Ah
        mov dword [PlayerArtTables+8Ch], eax
        mov eax, dword [PlayerArtTables+28h]
        xor edx, edx
        mov dword [PlayerArtTables+090h], eax
        mov eax, dword [PadArt]
        call CreateModelInstance
        push edi
        push eax
        mov dword [PlayerArtTables+094h], eax
        call BindModelShapes
        add esp, byte 8
        mov eax, str_Gstick0
        xor edx, edx
        call LoadModelByName
        mov dword [PlayerArtTables+278h], eax
        xor edx, edx
        mov eax, str_Gstick1
        call LoadModelByName
        mov dword [PlayerArtTables+27Ch], eax
        xor edx, edx
        mov eax, str_Gstick2
        xor esi, esi
        call LoadModelByName
        mov dword [PlayerArtTables+280h], eax
.6:
        mov edx, dword [dword esi+PlayerArtTables+278h]
        push edx
        call InitModelInstance
        mov edx, dword [PlayerArtTables+264h]
        add esp, byte 4
        mov eax, dword [dword esi+PlayerArtTables+278h]
        add esi, byte 4
        call AttachModel
        cmp esi, byte 0Ch
        jne short .6
        call ServiceIdle
        push byte 0
        push str_Gstick2Fsh
        call OpenArtArchiveErr
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        mov dword [PlayerArtTables+218h], eax
        mov edi, eax
        mov ebx, eax
        xor ecx, ecx
        mov eax, str_Ori
        xor esi, esi
        call RemapArtBank
.7:
        mov ebx, 0Ah
        mov eax, dword [dword esi+PlayerArtTables+278h]
        xor edx, edx
        call CreateModelInstance
        push edi
        add esi, byte 4
        push eax
        mov dword [dword esi+PlayerArtTables+0B8h], eax
        call BindModelShapes
        add esp, byte 8
        cmp esi, byte 0Ch
        jne short .7
        mov eax, str_Glleg
        xor edx, edx
        call LoadModelByName
        push eax
        mov dword [PlayerArtTables+26Ch], eax
        call InitModelInstance
        add esp, byte 4
        mov edx, dword [PlayerArtTables+264h]
        mov eax, dword [PlayerArtTables+26Ch]
        call AttachModel
        call ServiceIdle
        mov eax, str_Grleg
        xor edx, edx
        call LoadModelByName
        push eax
        mov dword [PlayerArtTables+1D4h], eax
        call InitModelInstance
        add esp, byte 4
        mov edx, dword [PlayerArtTables+264h]
        mov eax, dword [PlayerArtTables+1D4h]
        call AttachModel
        mov eax, str_Rblkr
        xor edx, edx
        call LoadModelByName
        push eax
        mov dword [PlayerArtTables+1ACh], eax
        call InitModelInstance
        add esp, byte 4
        mov edx, dword [PlayerArtTables+264h]
        mov eax, dword [PlayerArtTables+1ACh]
        call AttachModel
        mov eax, str_Lblkr
        xor edx, edx
        call LoadModelByName
        push eax
        mov dword [PlayerArtTables+1A8h], eax
        call InitModelInstance
        add esp, byte 4
        mov edx, dword [PlayerArtTables+264h]
        mov eax, dword [PlayerArtTables+1A8h]
        call AttachModel
        call ServiceIdle
        mov eax, str_Ltrap2
        xor edx, edx
        call LoadModelByName
        push eax
        mov dword [PlayerArtTables+1E4h], eax
        call InitModelInstance
        add esp, byte 4
        mov edx, dword [PlayerArtTables+264h]
        mov eax, dword [PlayerArtTables+1E4h]
        call AttachModel
        mov eax, str_Rtrap2
        xor edx, edx
        call LoadModelByName
        push eax
        mov dword [PlayerArtTables+164h], eax
        call InitModelInstance
        add esp, byte 4
        mov edx, dword [PlayerArtTables+264h]
        mov eax, dword [PlayerArtTables+164h]
        call AttachModel
        call ServiceIdle
        mov eax, str_Lskate0
        xor edx, edx
        call LoadModelByName
        mov dword [HeadArt], eax
        xor edx, edx
        mov eax, str_Lskate1
        call LoadModelByName
        push byte 0
        push str_Lskate1Fsh
        mov dword [BodyArt], eax
        call OpenArtArchiveErr
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        mov dword [PlayerArtTables+14h], eax
        mov edi, eax
        mov ebx, eax
        xor ecx, ecx
        mov eax, str_Ori
        xor esi, esi
        call RemapArtBank
.8:
        mov ebx, dword [dword esi+HeadArt]
        push ebx
        call InitModelInstance
        mov edx, dword [PlayerArtTables+264h]
        add esp, byte 4
        mov eax, dword [dword esi+HeadArt]
        mov ebx, 0Ah
        call AttachModel
        mov eax, dword [dword esi+HeadArt]
        xor edx, edx
        call CreateModelInstance
        push edi
        add esi, byte 4
        push eax
        mov dword [dword esi+CommonArt], eax
        call BindModelShapes
        add esp, byte 8
        cmp esi, byte 8
        jne short .8
        call ServiceIdle
        mov eax, str_Rskate0
        xor edx, edx
        call LoadModelByName
        mov dword [ShadowArt], eax
        xor edx, edx
        mov eax, str_Rskate1
        xor esi, esi
        call LoadModelByName
        mov dword [PlayerModelData], eax
.9:
        mov ecx, dword [dword esi+ShadowArt]
        push ecx
        call InitModelInstance
        mov edx, dword [PlayerArtTables+264h]
        add esp, byte 4
        mov eax, dword [dword esi+ShadowArt]
        mov ebx, 0Ah
        call AttachModel
        mov eax, dword [dword esi+ShadowArt]
        xor edx, edx
        call CreateModelInstance
        push edi
        add esi, byte 4
        push eax
        mov dword [dword esi+StickArt], eax
        call BindModelShapes
        add esp, byte 8
        cmp esi, byte 8
        jne short .9
        push ebp
        call FreeMemBlock
        add esp, byte 4
        push byte 0
        call OpenResourceArchive
        add esp, byte 4
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
; LoadUniformArt                                  58144  97 PC, low confidence
; (team, uniform, ...): loads uni%04d.viv: team palette, numbers.ffn /
; a2z.ffn fonts, torso and cup patch shapes
;-----------------------------------------------------------------------------
LoadUniformArt:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 34h
        mov dword [byte esp+02Ch], eax
        mov dword [byte esp+028h], ebx
        push edx
        lea ebx, [nosplit eax*4+00h]
        push str_Uni04dViv
        lea eax, [byte esp+08h]
        push eax
        mov dword [dword ebx+PlayerArtTables+14Ch], edx
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        call SetArtArchive
        push byte 0
        push str_TeampalFsh
        call OpenArtArchiveErr
        add esp, byte 8
        push str_PAL2
        push eax
        mov dword [byte esp+02Ch], eax
        call FindShape
        add esp, byte 8
        add eax, byte 10h
        mov edx, dword [byte esp+028h]
        mov dword [byte esp+030h], eax
        call ServiceIdle
        test edx, edx
        jne short .1
        push edx
        push str_NumbersFfn
        call LoadResourceDataShared
        add esp, byte 8
        mov edi, dword [UniformFontColors]
        push eax
        mov esi, dword [UniformFontShadow]
        mov dword [dword ebx+PlayerArtTables+190h], eax
        call SelectFont
        add esp, byte 4
        mov edx, esi
        mov eax, edi
        call LayoutJerseyNumber
        push byte 0
        mov ecx, SetupPlayerModel_D8
        push str_A2zFfn
        mov dword [DrawGlyphFn], ecx
        call LoadResourceDataShared
        add esp, byte 8
        mov dword [dword ebx+PlayerArtTables+30h], eax
        jmp short .2
.1:
        push byte 0
        push str_Cuppatch
        call OpenArtArchiveErr
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        mov dword [PlayerArtTables+1ECh], eax
        mov ebx, eax
        push byte 0
        mov ecx, dword [byte esp+034h]
        mov eax, str_Cupp
        call AddBankToRange
.2:
        push byte 0
        push str_Torso2Fsh
        call OpenArtArchiveErr
        add esp, byte 8
        push str_Back
        mov esi, dword [byte esp+030h]
        push eax
        mov ebx, eax
        mov dword [nosplit esi*4+PlayerArtTables+244h], eax
        call FindShape
        add esp, byte 8
        push str_Fron
        push ebx
        mov dword [nosplit esi*4+PlayerArtTables+19Ch], eax
        call FindShape
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        xor ecx, ecx
        mov dword [nosplit esi*4+PlayerArtTables+168h], eax
        mov eax, str_Ori
        call RemapArtBank
        call ServiceIdle
        push byte 0
        push str_Helmet0Fsh
        call OpenArtArchiveErr
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        mov edi, eax
        mov ebx, eax
        xor ecx, ecx
        mov dword [nosplit esi*4+PlayerArtTables+1D8h], eax
        mov eax, str_Ori
        call RemapArtBank
        mov ebx, 0Ah
        mov eax, dword [PlayerArtTables+254h]
        xor edx, edx
        call CreateModelInstance
        mov ebx, eax
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 2
        push edi
        mov dword [byte esp+024h], eax
        mov dword [dword eax+PlayerArtTables+0C8h], ebx
        mov eax, ebx
        push eax
        call BindModelShapes
        add esp, byte 8
        push byte 0
        push str_Helmet2Fsh
        mov edi, 1
        call OpenArtArchiveErr
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        mov ebx, eax
        mov ebp, eax
        xor ecx, ecx
        mov dword [nosplit esi*4+PlayerArtTables+200h], eax
        mov eax, str_Ori
        mov esi, dword [byte esp+020h]
        call RemapArtBank
        add esi, byte 4
.3:
        mov ebx, 0Ah
        mov eax, dword [nosplit edi*4+PlayerArtTables+254h]
        xor edx, edx
        call CreateModelInstance
        push ebp
        add esi, byte 4
        push eax
        inc edi
        mov dword [dword esi+PlayerArtTables+0C4h], eax
        call BindModelShapes
        add esp, byte 8
        cmp edi, byte 3
        jl short .3
        mov esi, dword [byte esp+028h]
        call ServiceIdle
        test esi, esi
        jne near .4
        push esi
        push str_GllegFsh
        call OpenArtArchiveErr
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        mov edi, eax
        mov esi, dword [byte esp+02Ch]
        mov ebx, eax
        shl esi, 2
        xor ecx, ecx
        mov dword [dword esi+PlayerArtTables+20Ch], eax
        mov eax, str_Ori
        call RemapArtBank
        mov ebx, 0Ah
        mov eax, dword [PlayerArtTables+26Ch]
        xor edx, edx
        call CreateModelInstance
        push edi
        push eax
        mov dword [dword esi+PlayerArtTables+60h], eax
        call BindModelShapes
        add esp, byte 8
        push byte 0
        push str_GrlegFsh
        call OpenArtArchiveErr
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        mov edi, eax
        mov ebx, eax
        xor ecx, ecx
        mov dword [dword esi+PlayerArtTables+1F0h], eax
        mov eax, str_Ori
        call RemapArtBank
        mov ebx, 0Ah
        mov eax, dword [PlayerArtTables+1D4h]
        xor edx, edx
        call CreateModelInstance
        push edi
        push eax
        mov dword [dword esi+PlayerArtTables+140h], eax
        call BindModelShapes
        add esp, byte 8
        push byte 0
        push str_LblkrFsh
        call OpenArtArchiveErr
        add esp, byte 8
        mov edi, eax
        mov dword [dword esi+PlayerArtTables+158h], eax
        mov edx, dword [ArenaArchive]
        mov ebx, eax
        xor ecx, ecx
        mov eax, str_Ori
        call RemapArtBank
        call ServiceIdle
        mov ebx, 0Ah
        mov eax, dword [PlayerArtTables+1ACh]
        xor edx, edx
        call CreateModelInstance
        push edi
        push eax
        mov ebx, 0Ah
        mov dword [dword esi+PlayerArtTables+0F8h], eax
        call BindModelShapes
        add esp, byte 8
        mov eax, dword [PlayerArtTables+1A8h]
        xor edx, edx
        call CreateModelInstance
        push edi
        push eax
        mov dword [dword esi+PlayerArtTables+0B0h], eax
        call BindModelShapes
        add esp, byte 8
        push byte 0
        push str_Rtrap2Fsh
        call OpenArtArchiveErr
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        mov edi, eax
        mov ebx, eax
        xor ecx, ecx
        mov dword [dword esi+PlayerArtTables+180h], eax
        mov eax, str_Ori
        call RemapArtBank
        mov ebx, 0Ah
        mov eax, dword [PlayerArtTables+164h]
        xor edx, edx
        call CreateModelInstance
        push edi
        push eax
        mov ebx, 0Ah
        mov dword [dword esi+PlayerArtTables+7Ch], eax
        call BindModelShapes
        add esp, byte 8
        mov eax, dword [PlayerArtTables+1E4h]
        xor edx, edx
        call CreateModelInstance
        push edi
        push eax
        mov dword [dword esi+PlayerArtTables+098h], eax
        call BindModelShapes
        add esp, byte 8
.4:
        call ServiceIdle
        push byte 0
        push str_Uarm
        mov ebx, PlayerArtTables+4
        call OpenArtArchiveErr
        add esp, byte 8
        mov edx, PlayerArtTables
        mov esi, dword [byte esp+02Ch]
        mov edi, eax
        shl esi, 2
        mov ecx, dword [byte esp+030h]
        mov dword [dword esi+PlayerArtTables+48h], eax
        call BuildUniformArt
        push byte 0
        mov edx, dword [ArenaArchive]
        mov ebx, edi
        mov dword [dword esi+PlayerArtTables+104h], eax
        mov eax, str_Uarm
        call AddBankToRange
        push byte 0
        push str_Larm
        mov ebx, PlayerArtTables+4
        call OpenArtArchiveErr
        mov edx, PlayerArtTables
        add esp, byte 8
        mov edi, eax
        mov dword [dword esi+PlayerArtTables+0A4h], eax
        call BuildUniformArt
        push byte 0
        mov ecx, dword [byte esp+034h]
        mov edx, dword [ArenaArchive]
        mov ebx, edi
        mov dword [dword esi+PlayerArtTables+0ECh], eax
        mov eax, str_Larm
        call AddBankToRange
        call ServiceIdle
        push byte 0
        push str_Uleg
        call OpenArtArchiveErr
        add esp, byte 8
        mov edi, eax
        mov dword [dword esi+PlayerArtTables+134h], eax
        mov ebx, PlayerArtTables+4
        mov edx, PlayerArtTables
        mov ecx, dword [byte esp+030h]
        call BuildUniformArt
        push byte 0
        mov edx, dword [ArenaArchive]
        mov ebx, edi
        mov dword [dword esi+PlayerArtTables+70h], eax
        mov eax, str_Uleg
        call AddBankToRange
        push byte 0
        push str_Lleg
        mov ebx, PlayerArtTables+4
        call OpenArtArchiveErr
        mov edx, PlayerArtTables
        add esp, byte 8
        mov edi, eax
        mov dword [dword esi+PlayerArtTables+18h], eax
        call BuildUniformArt
        push byte 0
        mov ecx, dword [byte esp+034h]
        mov edx, dword [ArenaArchive]
        mov ebx, edi
        mov dword [dword esi+PlayerArtTables+54h], eax
        mov eax, str_Lleg
        call AddBankToRange
        call ServiceIdle
        push byte 0
        push str_Glove
        mov ebp, 1
        mov ebx, PlayerArtTables+4
        call OpenArtArchiveErr
        mov edx, PlayerArtTables
        add esp, byte 8
        mov edi, eax
        mov dword [UniformArtBuf], ebp
        mov dword [dword esi+PlayerArtTables+8], eax
        call BuildUniformArt
        mov ecx, dword [byte esp+030h]
        mov edx, dword [ArenaArchive]
        mov dword [dword esi+PlayerArtTables+3Ch], eax
        xor eax, eax
        mov ebx, edi
        push eax
        mov dword [UniformArtBuf], eax
        mov eax, str_Glove
        call AddBankToRange
        mov edx, dword [byte esp+024h]
        call ServiceIdle
        push edx
        call FreeMemBlock
        add esp, byte 4
        push byte 0
        call OpenResourceArchive
        add esp, byte 4
        add esp, byte 34h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CopyShape                                       58680  97 PC, low confidence
; Copies a shape (bitmap) into a new block
;-----------------------------------------------------------------------------
CopyShape:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        mov edi, dword [byte eax+02h]
        mov esi, dword [byte eax+04h]
        sar edi, 10h
        sar esi, 10h
        imul edi, esi
        push byte 0
        add edi, byte 10h
        push edi
        push str_SHPCOPY
        call AllocMemBlock
        add esp, byte 0Ch
        push edi
        push eax
        push ebx
        mov esi, eax
        call bcopy
        add esp, byte 0Ch
        mov eax, esi
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetupJerseyBackTexture                          586C0  97 PC, low confidence
; Picks and prepares the texture for the back of the jersey
;-----------------------------------------------------------------------------
SetupJerseyBackTexture:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, ebx
        mov ebx, eax
        shl eax, 4
        sub eax, ebx
        shl eax, 2
        sub eax, ebx
        mov ebp, ObjectPositions
        shl eax, 5
        add ebp, eax
        lea eax, [nosplit edx*4+00h]
        test esi, esi
        je short .1
        mov eax, dword [dword eax+PlayerArtTables+19Ch]
        call CopyShape
        jmp short .2
.1:
        mov eax, dword [dword eax+PlayerArtTables+19Ch]
.2:
        mov dword [dword ebp+06E4h], eax
        shl edx, 2
        mov esi, ebp
        xor edi, edi
        mov dword [esp], edx
.3:
        mov ebx, 0Ah
        mov eax, dword [nosplit edi*4+PlayerArtTables+284h]
        xor edx, edx
        call CreateModelInstance
        mov ebx, eax
        mov dword [dword esi+06D8h], eax
        mov eax, dword [esp]
        mov edx, dword [dword eax+PlayerArtTables+244h]
        push edx
        push ebx
        call BindModelShapes
        add esp, byte 8
        mov ecx, dword [dword ebp+06E4h]
        push ecx
        push str_Back
        push ebx
        call FindInstanceShape
        add esp, byte 8
        push eax
        push ebx
        add esi, byte 4
        inc edi
        call SetModelShape
        add esp, byte 0Ch
        cmp edi, byte 3
        jl short .3
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; InitPlayerModelSlots                            5876C  97 PC, low confidence
; Clears the table of player model slots
;-----------------------------------------------------------------------------
InitPlayerModelSlots:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov esi, ObjectPositions
        xor edi, edi
        mov ebp, 1
.1:
        mov eax, esi
        mov ebx, dword [byte esi+02Ch]
        xor edx, edx
        call SetModelHeading
        mov edx, ebp
        mov eax, esi
        mov ebx, dword [byte esi+030h]
        add esi, 760h
        inc edi
        call SetModelHeading
        mov dword [byte esi-08h], ebp
        cmp edi, byte 0Dh
        jl short .1
        mov ecx, 0FFFFFFFFh
        xor edx, edx
.2:
        mov ebx, dword [dword edx+SeatModelSlots]
        test ebx, ebx
        jl short .3
        mov eax, ebx
        call FindModelName
        mov dword [dword edx+SeatModelSlots], ecx
.3:
        add edx, byte 4
        cmp edx, byte 18h
        jne short .2
        xor ebp, ebp
        xor edi, edi
.4:
        cmp byte [dword edi+SeatModelCount], 0
        jne short .5
        mov eax, edi
        add eax, SeatModelCount
        push eax
        mov ecx, DrawPortraitModels
        mov ebx, ModelViewDepth
        push byte 3
        mov edx, esi
        mov eax, str_BOGIE
        call AddModelName
        mov byte [dword edi+SeatModelFlag], al
        movsx eax, al
        mov dword [dword ebp+SeatModelSlots], eax
.5:
        add ebp, byte 4
        add edi, byte 0Fh
        cmp ebp, byte 18h
        jne short .4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LoadGameModels                                  5881C  97 PC, low confidence
; Loads the player, goalie and referee models for a game
;-----------------------------------------------------------------------------
LoadGameModels:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 20h
        mov dword [byte esp+014h], eax
        mov dword [byte esp+0Ch], edx
        mov dword [byte esp+08h], ebx
        mov edx, 1
        xor ebx, ebx
        mov dword [ModelFileCount], edx
        mov dword [PlayerArtTables+274h], ebx
        call AllocSpriteBuffers
        mov eax, str_PlyrcomnViv
        call SetArtArchive
        call ServiceIdle
        push ebx
        push str_Marks2
        mov bl, 1
        call OpenArtArchiveErr
        mov ecx, 0FFFFFFFFh
        add esp, byte 8
        mov dword [PlayerArtTables+268h], eax
        xor edx, edx
        xor eax, eax
.1:
        add eax, byte 4
        add edx, byte 0Fh
        mov dword [dword eax+PlayerModelData], ecx
        mov byte [dword edx+TeamModelFlags], bl
        cmp eax, byte 18h
        jne short .1
        xor esi, esi
        xor ebx, ebx
.2:
        push ebx
        push str_04d2
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        mov edi, dword [PlayerArtTables+268h]
        push edi
        add esi, byte 4
        inc ebx
        call FindShape
        add esp, byte 8
        mov dword [dword esi+GoalieStickArt], eax
        cmp ebx, byte 4
        jl short .2
        mov eax, str_Player2
        xor edx, edx
        mov ecx, PlayerModels
        call LoadModelFile
        mov dword [PlayerArtTables+264h], eax
        call ScaleModelVerts
        call ServiceIdle
        mov eax, dword [PlayerArtTables+264h]
        mov ebx, 100h
        call LoadFaceArt
        push byte 0
        mov eax, str_Faces
        mov edx, dword [ArenaArchive]
        call AddColorTable
        mov eax, InitPlayerModelSlots
        mov ebx, 5Ah
        call ReplayRegisterObjects
        mov eax, SeatModelCount
        mov edx, ebx
        call ReplayRegisterStates
        mov eax, dword [byte esp+014h]
        xor ebp, ebp
        add eax, byte 2
        mov dword [byte esp+018h], ebp
        mov dword [byte esp+010h], eax
        mov eax, ObjectPositions
        mov edx, dword [byte esp+010h]
        mov dword [byte esp+01Ch], eax
        test edx, edx
        jle near .7
.3:
        mov eax, dword [byte esp+018h]
        mov edx, dword [byte esp+014h]
        mov ebp, dword [byte esp+01Ch]
        cmp eax, edx
        jge short .4
        lea edx, [byte ebp+054h]
        sub edx, ebp
        mov eax, ebp
        mov ebx, edx
        call ReplayRegisterStates
.4:
        mov eax, dword [PlayerArtTables+264h]
        mov dword [dword ebp+0740h], 0FFFFFFFFh
        mov dword [dword ebp+0744h], 0
        mov dword [byte ebp+04Ch], 0FFFFFFFFh
        mov dword [byte ebp+038h], 1
        mov dword [byte ebp+044h], 0
        mov dword [byte ebp+040h], 0
        mov dword [byte ebp+048h], 0
        mov dword [dword ebp+0758h], 1
        mov dword [byte ebp+054h], eax
        mov eax, dword [byte esp+018h]
        mov dword [dword ebp+073Ch], eax
        mov eax, dword [byte ebp+044h]
        mov ebx, ebp
        mov dword [byte ebp+030h], eax
        xor edx, edx
        mov dword [byte ebp+02Ch], eax
        xor eax, eax
        jmp short .6
.5:
        mov esi, dword [byte ecx+0Ch]
        lea edi, [byte ebx+058h]
        add ebx, byte 0Ch
        add esi, eax
        inc edx
        add eax, byte 0Ch
        movsd
        movsd
        movsd
.6:
        mov ecx, dword [byte ebp+054h]
        cmp edx, dword [ecx]
        jl short .5
        mov ebx, dword [byte esp+01Ch]
        mov ecx, dword [byte esp+018h]
        mov esi, dword [byte esp+010h]
        mov dword [byte ebp+03Ch], 3F800000h
        mov eax, dword [tickcount]
        add ebx, 760h
        inc ecx
        mov dword [dword ebp+075Ch], eax
        mov dword [byte esp+01Ch], ebx
        mov dword [byte esp+018h], ecx
        cmp ecx, esi
        jl near .3
.7:
        mov eax, dword [PlayerArtTables+264h]
        mov edi, dword [SeatModelsUsed]
        mov eax, dword [byte eax+0Ch]
        test edi, edi
        jne short .8
        call SaveGamePalette
.8:
        mov ebp, 1
        mov edx, dword [byte esp+0Ch]
        xor ebx, ebx
        mov dword [SeatModelsUsed], ebp
        call LoadPlayerCommonArt
        call ServiceIdle
        xor eax, eax
        call LoadUniformArt
        call ServiceIdle
        mov edx, dword [byte esp+08h]
        mov eax, ebp
        xor ebx, ebx
        call LoadUniformArt
        call ServiceIdle
        mov eax, 2
        mov ebx, ebp
        xor edx, edx
        call LoadUniformArt
        call ServiceIdle
        xor ebp, ebp
        mov ecx, 1
        xor esi, esi
.9:
        mov ebx, ecx
        mov edx, esi
        mov eax, ebp
        inc ebp
        call SetupJerseyBackTexture
        cmp ebp, byte 6
        jge short .11
        jmp short .9
.10:
        mov ebx, esi
        mov edx, esi
        mov eax, ebp
        call SetupJerseyBackTexture
        inc ebp
        jmp short .12
.11:
        mov esi, 1
.12:
        cmp ebp, byte 0Ch
        jl short .10
        mov edx, 2
        mov eax, 0Ch
        xor ebx, ebx
        call SetupJerseyBackTexture
        mov eax, 0Dh
        xor ebx, ebx
        xor edx, edx
        call SetupJerseyBackTexture
        mov edx, 1
        mov eax, 0Eh
        xor ebx, ebx
        xor ecx, ecx
        call SetupJerseyBackTexture
        xor esi, esi
.13:
        mov ebx, esi
        mov edx, esi
        mov eax, ecx
        inc ecx
        call BuildFaceTextures
        cmp ecx, byte 5
        jl short .13
        mov ebx, 1
        mov eax, 5
        xor edx, edx
        mov ecx, 6
        call BuildFaceTextures
        mov esi, 1
        xor ebp, ebp
.14:
        mov ebx, ebp
        mov edx, esi
        mov eax, ecx
        inc ecx
        call BuildFaceTextures
        cmp ecx, byte 0Bh
        jl short .14
        mov ebx, 1
        mov eax, 0Bh
        mov edx, ebx
        call BuildFaceTextures
        mov ebx, 2
        mov eax, 0Ch
        mov edx, ebx
        call BuildFaceTextures
        mov ebx, 3
        mov eax, 0Dh
        xor edx, edx
        call BuildFaceTextures
        mov ebx, 3
        mov edx, 1
        mov eax, 0Eh
        xor edi, edi
        call BuildFaceTextures
        push edi
        mov dword [ModelFileCount], edi
        call OpenResourceArchive
        add esp, byte 4
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetupTeamModels                                 58B80  97 PC, low confidence
; Sets up the models of both teams' players
;-----------------------------------------------------------------------------
SetupTeamModels:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov ebx, PlayerArtTables+24h
        xor esi, esi
.1:
        mov edx, dword [ebx]
        push edx
        add ebx, byte 4
        inc esi
        call UpdateModelInstance
        add esp, byte 4
        cmp esi, byte 3
        jl short .1
        mov ebx, dword [PlayerArtTables+094h]
        push ebx
        mov esi, PlayerArtTables+0BCh
        call UpdateModelInstance
        add esp, byte 4
        xor ebx, ebx
.2:
        mov ecx, dword [esi]
        push ecx
        add esi, byte 4
        inc ebx
        call UpdateModelInstance
        add esp, byte 4
        cmp ebx, byte 3
        jl short .2
        mov ebx, StickModels
        xor esi, esi
.3:
        mov edi, dword [ebx]
        push edi
        add ebx, byte 4
        inc esi
        call UpdateModelInstance
        add esp, byte 4
        cmp esi, byte 2
        jl short .3
        mov ebx, GoalieStickModels
        xor esi, esi
.4:
        mov ebp, dword [ebx]
        push ebp
        add ebx, byte 4
        inc esi
        call UpdateModelInstance
        add esp, byte 4
        cmp esi, byte 2
        jl short .4
        mov ebx, PlayerArtTables+110h
        xor esi, esi
.5:
        mov eax, dword [ebx]
        push eax
        add ebx, byte 4
        inc esi
        call UpdateModelInstance
        add esp, byte 4
        cmp esi, byte 6
        jl short .5
        push dword 0AF805Dh
        call MatchColor
        xor esi, esi
        add esp, byte 4
        mov dword [PlayerArtTables+270h], eax
.6:
        push byte 0
        push str_05dFsh
        lea eax, [byte esp+08h]
        push eax
        lea edx, [byte esp+0Ch]
        call sprintf_
        add esp, byte 0Ch
        mov eax, esi
        mov ebx, 63h
        call SetupPlayerModel
        call Random32
        xor edx, edx
        div ebx
        lea ebx, [byte edx+01h]
        mov eax, esi
        mov edx, str_ABCDEFGHIJKLM
        inc esi
        call DrawJerseyLettering
        cmp esi, byte 0Dh
        jl short .6
        mov ecx, 8
        mov eax, TeamColorSet
        xor edx, edx
        call __STOSB
        mov edx, TeamColorRanges
        mov eax, dword [RinkLineArt]
        call SetRangeColors
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FreeGameModels                                  58CA0  97 PC, low confidence
; Frees the models loaded for a game
;-----------------------------------------------------------------------------
FreeGameModels:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        call FreeReplayMem
        mov edx, dword [PlayerArtTables+268h]
        push edx
        call FreeMemBlock
        add esp, byte 4
        mov ebx, dword [PlayerArtTables+264h]
        push ebx
        call FreeMemBlock
        add esp, byte 4
        xor ebx, ebx
.1:
        mov ecx, dword [dword ebx+PlayerArtTables+190h]
        push ecx
        call FreeMemBlock
        add esp, byte 4
        mov esi, dword [dword ebx+PlayerArtTables+30h]
        push esi
        add ebx, byte 4
        call FreeMemBlock
        add esp, byte 4
        cmp ebx, byte 8
        jne short .1
        xor ebx, ebx
.2:
        mov edi, dword [dword ebx+PlayerArtTables+0C8h]
        push edi
        add ebx, byte 4
        call FreeModelInstance
        add esp, byte 4
        cmp ebx, byte 24h
        jne short .2
        xor ebx, ebx
.3:
        mov ebp, dword [dword ebx+PlayerArtTables+24h]
        push ebp
        add ebx, byte 4
        call FreeModelInstance
        add esp, byte 4
        cmp ebx, byte 0Ch
        jne short .3
        mov eax, dword [PlayerArtTables+094h]
        push eax
        xor ebx, ebx
        call FreeModelInstance
        add esp, byte 4
.4:
        mov edx, dword [dword ebx+PlayerArtTables+0BCh]
        push edx
        add ebx, byte 4
        call FreeModelInstance
        add esp, byte 4
        cmp ebx, byte 0Ch
        jne short .4
        xor ebx, ebx
.5:
        mov ecx, dword [dword ebx+PlayerArtTables+60h]
        push ecx
        add ebx, byte 4
        call FreeModelInstance
        add esp, byte 4
        cmp ebx, byte 8
        jne short .5
        xor ebx, ebx
.6:
        mov esi, dword [dword ebx+PlayerArtTables+140h]
        push esi
        add ebx, byte 4
        call FreeModelInstance
        add esp, byte 4
        cmp ebx, byte 8
        jne short .6
        xor ebx, ebx
.7:
        mov edi, dword [dword ebx+PlayerArtTables+0F8h]
        push edi
        add ebx, byte 4
        call FreeModelInstance
        add esp, byte 4
        cmp ebx, byte 8
        jne short .7
        xor ebx, ebx
.8:
        mov ebp, dword [dword ebx+PlayerArtTables+0B0h]
        push ebp
        add ebx, byte 4
        call FreeModelInstance
        add esp, byte 4
        cmp ebx, byte 8
        jne short .8
        xor ebx, ebx
.9:
        mov eax, dword [dword ebx+PlayerArtTables+7Ch]
        push eax
        add ebx, byte 4
        call FreeModelInstance
        add esp, byte 4
        cmp ebx, byte 8
        jne short .9
        xor ebx, ebx
.10:
        mov edx, dword [dword ebx+PlayerArtTables+098h]
        push edx
        add ebx, byte 4
        call FreeModelInstance
        add esp, byte 4
        cmp ebx, byte 8
        jne short .10
        xor ebx, ebx
.11:
        mov ecx, dword [dword ebx+StickModels]
        push ecx
        add ebx, byte 4
        call FreeModelInstance
        add esp, byte 4
        cmp ebx, byte 8
        jne short .11
        xor ebx, ebx
.12:
        mov esi, dword [dword ebx+GoalieStickModels]
        push esi
        add ebx, byte 4
        call FreeModelInstance
        add esp, byte 4
        cmp ebx, byte 8
        jne short .12
        cmp dword [PlayerArtTables+21Ch], byte 0
        je short .13
        mov ebp, dword [PlayerArtTables+174h]
        push ebp
        call FreeModelInstance
        add esp, byte 4
        mov eax, dword [PlayerArtTables+21Ch]
        push eax
        call FreeModelFile
        add esp, byte 4
        mov edx, dword [PlayerArtTables+1FCh]
        push edx
        call FreeMemBlock
        add esp, byte 4
.13:
        xor ebx, ebx
.14:
        mov ecx, dword [dword ebx+PlayerArtTables+284h]
        push ecx
        add ebx, byte 4
        call FreeModelFile
        add esp, byte 4
        cmp ebx, byte 0Ch
        jne short .14
        mov esi, dword [PlayerArtTables+26Ch]
        push esi
        call FreeModelFile
        add esp, byte 4
        mov edi, dword [PlayerArtTables+1D4h]
        push edi
        call FreeModelFile
        add esp, byte 4
        mov ebp, dword [PlayerArtTables+1ACh]
        push ebp
        call FreeModelFile
        add esp, byte 4
        mov eax, dword [PlayerArtTables+1A8h]
        push eax
        call FreeModelFile
        add esp, byte 4
        mov edx, dword [PlayerArtTables+164h]
        push edx
        call FreeModelFile
        add esp, byte 4
        mov ebx, dword [PlayerArtTables+1E4h]
        push ebx
        call FreeModelFile
        add esp, byte 4
        xor ebx, ebx
.15:
        mov ecx, dword [dword ebx+PlayerArtTables+254h]
        push ecx
        add ebx, byte 4
        call FreeModelFile
        add esp, byte 4
        cmp ebx, byte 0Ch
        jne short .15
        xor ebx, ebx
.16:
        mov esi, dword [dword ebx+SkateArt]
        push esi
        add ebx, byte 4
        call FreeModelFile
        add esp, byte 4
        cmp ebx, byte 10h
        jne short .16
        xor ebx, ebx
.17:
        mov edi, dword [dword ebx+PlayerArtTables+278h]
        push edi
        add ebx, byte 4
        call FreeModelFile
        add esp, byte 4
        cmp ebx, byte 0Ch
        jne short .17
        xor ebx, ebx
.18:
        mov ebp, dword [dword ebx+HeadArt]
        push ebp
        add ebx, byte 4
        call FreeModelFile
        add esp, byte 4
        cmp ebx, byte 8
        jne short .18
        xor ebx, ebx
.19:
        mov eax, dword [dword ebx+ShadowArt]
        push eax
        add ebx, byte 4
        call FreeModelFile
        add esp, byte 4
        cmp ebx, byte 8
        jne short .19
        mov edi, ObjectPositions
        xor ebp, ebp
.20:
        mov esi, edi
        cmp ebp, byte 0Ch
        jge short .21
        mov edx, dword [dword edi+06E4h]
        push edx
        call FreeMemBlock
        add esp, byte 4
.21:
        mov ebx, esi
        add esi, byte 0Ch
.22:
        mov ecx, dword [dword ebx+06D8h]
        push ecx
        add ebx, byte 4
        call FreeModelInstance
        add esp, byte 4
        cmp ebx, esi
        jne short .22
        inc ebp
        add edi, 760h
        cmp ebp, byte 0Fh
        jl short .20
        mov ebx, PlayerArtTables+244h
        xor esi, esi
.23:
        mov edi, dword [ebx]
        push edi
        add ebx, byte 4
        inc esi
        call FreeMemBlock
        add esp, byte 4
        cmp esi, byte 3
        jl short .23
        mov ebx, PlayerArtTables+1D8h
        xor esi, esi
.24:
        mov ebp, dword [ebx]
        push ebp
        add ebx, byte 4
        inc esi
        call FreeMemBlock
        add esp, byte 4
        cmp esi, byte 3
        jl short .24
        mov ebx, PlayerArtTables+200h
        xor esi, esi
.25:
        mov eax, dword [ebx]
        push eax
        add ebx, byte 4
        inc esi
        call FreeMemBlock
        add esp, byte 4
        cmp esi, byte 3
        jl short .25
        mov edx, dword [PlayerArtTables+218h]
        push edx
        call FreeMemBlock
        add esp, byte 4
        mov ebx, dword [PlayerArtTables+18Ch]
        push ebx
        call FreeMemBlock
        add esp, byte 4
        mov ecx, dword [PlayerArtTables+14h]
        push ecx
        call FreeMemBlock
        add esp, byte 4
        mov esi, dword [PlayerArtTables+1ECh]
        push esi
        xor ebx, ebx
        call FreeMemBlock
        add esp, byte 4
.26:
        mov edi, dword [dword ebx+PlayerArtTables+48h]
        push edi
        call FreeMemBlock
        add esp, byte 4
        mov ebp, dword [dword ebx+PlayerArtTables+0A4h]
        push ebp
        call FreeMemBlock
        add esp, byte 4
        mov eax, dword [dword ebx+PlayerArtTables+134h]
        push eax
        call FreeMemBlock
        add esp, byte 4
        mov edx, dword [dword ebx+PlayerArtTables+18h]
        push edx
        call FreeMemBlock
        add esp, byte 4
        mov ecx, dword [dword ebx+PlayerArtTables+8]
        push ecx
        call FreeMemBlock
        add esp, byte 4
        mov esi, dword [dword ebx+PlayerArtTables+104h]
        push esi
        call FreeMemBlock
        add esp, byte 4
        mov edi, dword [dword ebx+PlayerArtTables+0ECh]
        push edi
        call FreeMemBlock
        add esp, byte 4
        mov ebp, dword [dword ebx+PlayerArtTables+70h]
        push ebp
        call FreeMemBlock
        add esp, byte 4
        mov eax, dword [dword ebx+PlayerArtTables+54h]
        push eax
        call FreeMemBlock
        add esp, byte 4
        mov edx, dword [dword ebx+PlayerArtTables+3Ch]
        push edx
        add ebx, byte 4
        call FreeMemBlock
        add esp, byte 4
        cmp ebx, byte 0Ch
        jne near .26
        mov ebx, dword [PlayerArtTables+1E8h]
        push ebx
        call FreeMemBlock
        add esp, byte 4
        mov ecx, dword [PlayerArtTables+88h]
        push ecx
        xor ebx, ebx
        call FreeMemBlock
        add esp, byte 4
.27:
        mov esi, dword [dword ebx+PlayerArtTables+20Ch]
        push esi
        call FreeMemBlock
        add esp, byte 4
        mov edi, dword [dword ebx+PlayerArtTables+1F0h]
        push edi
        call FreeMemBlock
        add esp, byte 4
        mov ebp, dword [dword ebx+PlayerArtTables+158h]
        push ebp
        call FreeMemBlock
        add esp, byte 4
        mov eax, dword [dword ebx+PlayerArtTables+180h]
        push eax
        add ebx, byte 4
        call FreeMemBlock
        add esp, byte 4
        cmp ebx, byte 8
        jne short .27
        xor eax, eax
        call FreeGoalieMask
        mov eax, 1
        xor ebx, ebx
        call FreeGoalieMask
        call FreeFaceTextures
.28:
        add ebx, 760h
        xor ah, ah
        mov byte [dword ebx+ModelLoadedFlags], ah
        cmp ebx, 5FE0h
        jne short .28
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        push esi
        push edi
        sub esp, byte 18h
        mov esi, edx
        mov edi, ebx
        lea ebx, [byte esp+0Ch]
        call VecSub
        mov ebx, esp
        mov edx, esi
        mov eax, edi
        call VecSub
        mov edx, esp
        lea eax, [byte esp+0Ch]
        mov ebx, ecx
        call VecCross
        add esp, byte 18h
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; UpdateViewMatrix                                59174  97 PC, low confidence
; Builds the view matrix from the camera position and target
;-----------------------------------------------------------------------------
UpdateViewMatrix:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 14Ch
        and esp, byte 0FFFFFFF8h
        mov dword [dword esp+0148h], eax
        lea ebx, [byte esp+060h]
        mov edx, CameraStateRecords+7
        call VecSub
        mov ebx, dword [dword esp+0148h]
        mov edx, CameraStateRecords+253h
        lea eax, [byte esp+060h]
        add ebx, 41Ch
        call VecMulMat
        mov eax, dword [dword esp+0148h]
        cmp dword [dword eax+0424h], 43AF0000h
        setg al
        mov edx, dword [dword esp+0148h]
        and eax, 0FFh
        mov dword [dword edx+0748h], eax
        jne short .1
        fld dword [dword edx+0424h]
        call __CHP
        fistp dword [dword esp+0130h]
        jmp near .18
.1:
        fld dword [byte esp+068h]
        fld dword [byte esp+060h]
        call IF@ATAN2
        push dword [byte edx+0Ch]
        lea ebx, [dword edx+0698h]
        lea eax, [byte esp+04h]
        fstp dword [byte edx+050h]
        call MatRotY
        mov edx, CameraStateRecords+253h
        mov eax, esp
        call MatMul
        mov eax, dword [dword esp+0148h]
        cmp dword [byte eax+038h], byte 0
        jne short .2
        cmp dword [dword eax+074Ch], byte 0
        jne short .2
        mov esi, eax
        lea edi, [byte esp+024h]
        lea esi, [dword esi+025Ch]
        movsd
        movsd
        movsd
        mov esi, eax
        lea edi, [byte esp+030h]
        lea esi, [dword esi+0298h]
        movsd
        movsd
        movsd
        mov esi, eax
        lea edi, [byte esp+03Ch]
        lea esi, [dword esi+02A4h]
        movsd
        movsd
        movsd
.2:
        mov eax, dword [dword esp+0148h]
        mov ecx, dword [dword esp+0148h]
        mov ebx, dword [dword esp+0148h]
        add eax, 328h
        mov edx, dword [dword esp+0148h]
        push eax
        mov eax, dword [dword esp+014Ch]
        add ecx, 41Ch
        add eax, 190h
        add ebx, 698h
        push eax
        add edx, byte 58h
        mov eax, 1Ah
        call TransformTranslateVecs
        mov eax, dword [dword esp+0148h]
        cmp dword [byte eax+038h], byte 0
        jne short .3
        cmp dword [dword eax+074Ch], byte 0
        jne short .3
        mov edi, eax
        lea esi, [byte esp+024h]
        lea edi, [dword edi+025Ch]
        movsd
        movsd
        movsd
        mov edi, eax
        lea esi, [byte esp+030h]
        lea edi, [dword edi+0298h]
        movsd
        movsd
        movsd
        mov edi, eax
        lea esi, [byte esp+03Ch]
        lea edi, [dword edi+02A4h]
        movsd
        movsd
        movsd
.3:
        mov eax, dword [dword esp+0148h]
        fld dword [dword eax+0328h]
        fld dword [dword eax+032Ch]
        fld dword [dword eax+0198h]
        mov ebx, dword [byte eax+038h]
        fxch st2
        fstp dword [dword eax+03FCh]
        fstp dword [dword eax+0404h]
        fstp dword [dword eax+040Ch]
        fld dword [dword eax+03FCh]
        fld dword [dword eax+0404h]
        fld dword [dword eax+040Ch]
        fxch st2
        fstp dword [dword eax+03F8h]
        fstp dword [dword eax+0400h]
        fstp dword [dword eax+0408h]
        test ebx, ebx
        jne short .4
        mov esi, 16h
        jmp short .5
.4:
        mov esi, 18h
.5:
        mov edx, 1
        cmp esi, edx
        jle near .14
        mov ecx, dword [dword esp+0148h]
        mov ebx, dword [dword esp+0148h]
        add ecx, byte 0Ch
        add ebx, byte 8
.6:
        mov eax, dword [dword ebx+0328h]
        mov dword [dword esp+0140h], eax
        cmp edx, byte 11h
        jne short .7
        mov eax, dword [dword esp+0148h]
        cmp dword [byte eax+038h], byte 0
        je near .13
.7:
        mov eax, dword [dword esp+0148h]
        fld dword [dword esp+0140h]
        fcomp dword [dword eax+03F8h]
        fnstsw ax
        sahf
        jae short .8
        mov edi, dword [dword esp+0148h]
        mov eax, dword [dword esp+0140h]
        mov dword [dword edi+03F8h], eax
        jmp short .9
.8:
        mov eax, dword [dword esp+0148h]
        fld dword [dword esp+0140h]
        fcomp dword [dword eax+03FCh]
        fnstsw ax
        sahf
        jbe short .9
        mov edi, dword [dword esp+0148h]
        mov eax, dword [dword esp+0140h]
        mov dword [dword edi+03FCh], eax
.9:
        mov eax, dword [dword ebx+032Ch]
        mov dword [dword esp+0144h], eax
        mov eax, dword [dword esp+0148h]
        fld dword [dword esp+0144h]
        fcomp dword [dword eax+0400h]
        fnstsw ax
        sahf
        jae short .10
        mov edi, dword [dword esp+0148h]
        mov eax, dword [dword esp+0144h]
        mov dword [dword edi+0400h], eax
        jmp short .11
.10:
        mov eax, dword [dword esp+0148h]
        fld dword [dword esp+0144h]
        fcomp dword [dword eax+0404h]
        fnstsw ax
        sahf
        jbe short .11
        mov edi, dword [dword esp+0148h]
        mov eax, dword [dword esp+0144h]
        mov dword [dword edi+0404h], eax
.11:
        mov eax, dword [dword ecx+0198h]
        mov dword [dword esp+0114h], eax
        mov eax, dword [dword esp+0148h]
        fld dword [dword esp+0114h]
        fcomp dword [dword eax+0408h]
        fnstsw ax
        sahf
        jae short .12
        mov edi, dword [dword esp+0148h]
        mov eax, dword [dword esp+0114h]
        mov dword [dword edi+0408h], eax
        jmp short .13
.12:
        mov eax, dword [dword esp+0148h]
        fld dword [dword esp+0114h]
        fcomp dword [dword eax+040Ch]
        fnstsw ax
        sahf
        jbe short .13
        mov edi, dword [dword esp+0148h]
        mov eax, dword [dword esp+0114h]
        mov dword [dword edi+040Ch], eax
.13:
        add ebx, byte 8
        inc edx
        add ecx, byte 0Ch
        cmp edx, esi
        jl near .6
.14:
        mov eax, dword [dword esp+0148h]
        fldz
        fcomp dword [dword eax+03FCh]
        fnstsw ax
        sahf
        ja short .15
        mov eax, dword [dword esp+0148h]
        fild dword [ViewPixelWidth]
        fcomp dword [dword eax+03F8h]
        fnstsw ax
        sahf
        jbe short .15
        mov eax, dword [dword esp+0148h]
        fldz
        fcomp dword [dword eax+0404h]
        fnstsw ax
        sahf
        ja short .15
        mov eax, dword [dword esp+0148h]
        fild dword [ViewPixelHeight]
        fcomp dword [dword eax+0400h]
        fnstsw ax
        sahf
        jbe short .15
        mov eax, dword [dword esp+0148h]
        fld dword [dword eax+0408h]
        fcomp dword [F32_50p0_View]
        fnstsw ax
        sahf
        ja short .16
.15:
        mov eax, dword [dword esp+0148h]
        mov dword [dword eax+0748h], 0
        jmp near .17
.16:
        mov eax, dword [dword esp+0148h]
        mov edx, dword [dword esp+0148h]
        mov edi, dword [dword esp+0148h]
        mov ecx, dword [dword esp+0148h]
        lea ebx, [dword esp+0108h]
        mov esi, dword [dword esp+0148h]
        add eax, 1FCh
        add edx, 208h
        add edi, 214h
        mov dword [dword esp+013Ch], edx
        call VecSub
        lea ebx, [dword esp+09Ch]
        mov edx, dword [dword esp+013Ch]
        mov eax, edi
        add ecx, 2C8h
        call VecSub
        lea edx, [dword esp+09Ch]
        lea eax, [dword esp+0108h]
        mov ebx, ecx
        add esi, 238h
        call VecCross
        mov eax, dword [dword esp+0148h]
        mov edx, dword [dword esp+0148h]
        mov ecx, dword [dword esp+0148h]
        lea ebx, [byte esp+054h]
        add edx, 22Ch
        add eax, 220h
        mov dword [dword esp+0134h], edx
        call VecSub
        lea ebx, [byte esp+048h]
        mov edx, dword [dword esp+0134h]
        mov eax, esi
        add ecx, 2D4h
        call VecSub
        lea edx, [byte esp+048h]
        lea eax, [byte esp+054h]
        mov ebx, ecx
        call VecCross
        mov edx, dword [dword esp+0148h]
        mov eax, dword [dword esp+0148h]
        add edx, 1E4h
        mov ecx, dword [dword esp+0148h]
        mov dword [dword esp+011Ch], edx
        mov edx, dword [dword esp+0148h]
        lea ebx, [byte esp+078h]
        add edx, 2E0h
        add eax, 1D8h
        mov dword [dword esp+0118h], edx
        mov edx, dword [dword esp+011Ch]
        add ecx, 1F0h
        call VecSub
        lea ebx, [byte esp+06Ch]
        mov edx, dword [dword esp+011Ch]
        mov eax, ecx
        call VecSub
        mov ebx, dword [dword esp+0118h]
        lea edx, [byte esp+06Ch]
        lea eax, [byte esp+078h]
        call VecCross
        mov edx, dword [dword esp+0148h]
        add edx, 1C0h
        mov dword [dword esp+0120h], edx
        mov edx, dword [dword esp+0148h]
        add edx, 1CCh
        mov eax, dword [dword esp+0148h]
        mov dword [dword esp+0138h], edx
        mov edx, dword [dword esp+0148h]
        lea ebx, [dword esp+0B4h]
        add edx, 2ECh
        add eax, 1B4h
        mov dword [dword esp+0124h], edx
        mov edx, dword [dword esp+0120h]
        call VecSub
        lea ebx, [dword esp+0F0h]
        mov edx, dword [dword esp+0120h]
        mov eax, dword [dword esp+0138h]
        call VecSub
        mov ebx, dword [dword esp+0124h]
        lea edx, [dword esp+0F0h]
        lea eax, [dword esp+0B4h]
        call VecCross
        mov eax, dword [dword esp+0148h]
        add eax, 250h
        mov dword [dword esp+012Ch], eax
        mov eax, dword [dword esp+0148h]
        add eax, 2F8h
        mov dword [dword esp+0128h], eax
        lea ebx, [dword esp+0CCh]
        mov eax, dword [dword esp+013Ch]
        mov edx, edi
        call VecSub
        lea ebx, [dword esp+0C0h]
        mov eax, dword [dword esp+012Ch]
        mov edx, edi
        call VecSub
        mov ebx, dword [dword esp+0128h]
        lea edx, [dword esp+0C0h]
        lea eax, [dword esp+0CCh]
        mov edi, dword [dword esp+0148h]
        call VecCross
        mov eax, dword [dword esp+0148h]
        lea ebx, [dword esp+0A8h]
        add eax, 304h
        mov edx, esi
        mov dword [dword esp+0120h], eax
        mov eax, dword [dword esp+0134h]
        add edi, 244h
        call VecSub
        lea ebx, [dword esp+0D8h]
        mov edx, esi
        mov eax, edi
        call VecSub
        mov ebx, dword [dword esp+0120h]
        lea edx, [dword esp+0D8h]
        lea eax, [dword esp+0A8h]
        call VecCross
        mov eax, dword [dword esp+0148h]
        cmp dword [dword eax+074Ch], byte 0
        je near .17
        mov edi, dword [dword esp+0148h]
        lea ebx, [dword esp+090h]
        mov edx, dword [dword esp+0138h]
        add eax, 268h
        mov esi, dword [dword esp+0148h]
        call VecSub
        lea ebx, [dword esp+084h]
        add edi, 25Ch
        mov edx, dword [dword esp+0138h]
        mov eax, edi
        add esi, 31Ch
        call VecSub
        lea edx, [dword esp+084h]
        lea eax, [dword esp+090h]
        mov ebx, esi
        mov edi, dword [dword esp+0148h]
        call VecCross
        mov eax, dword [dword esp+0148h]
        mov esi, dword [dword esp+0148h]
        lea ebx, [dword esp+0E4h]
        mov edx, ecx
        add eax, 274h
        add esi, 298h
        call VecSub
        lea ebx, [dword esp+0FCh]
        mov edx, ecx
        mov eax, esi
        add edi, 310h
        call VecSub
        lea edx, [dword esp+0FCh]
        lea eax, [dword esp+0E4h]
        mov ebx, edi
        call VecCross
.17:
        mov eax, dword [dword esp+0148h]
        fld dword [dword eax+01A4h]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [dword esp+0130h], eax
.18:
        mov eax, dword [dword esp+0130h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 11Ch
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov edi, ebx
        mov eax, edx
        lea ebx, [byte esp+06Ch]
        mov edx, CameraStateRecords+7
        call VecSub
        lea ecx, [dword esi+041Ch]
        mov edx, CameraStateRecords+253h
        lea eax, [byte esp+06Ch]
        mov ebx, ecx
        call VecMulMat
        cmp dword [dword esi+0424h], 43AF0000h
        setg al
        and eax, 0FFh
        mov dword [dword esi+0748h], eax
        je near .28
        fld dword [byte esp+074h]
        fld dword [byte esp+06Ch]
        call IF@ATAN2
        push dword [byte esi+0Ch]
        lea ebx, [byte esp+028h]
        mov edx, CameraStateRecords+253h
        lea eax, [byte esp+04h]
        fstp dword [byte esi+050h]
        call MatRotY
        mov eax, esp
        call MatMul
        lea eax, [dword esi+0328h]
        push eax
        lea eax, [dword esi+0190h]
        lea ebx, [byte esp+028h]
        push eax
        mov edx, edi
        mov eax, 1Ah
        call TransformTranslateVecs
        fld dword [dword esi+0328h]
        fld dword [dword esi+032Ch]
        fld dword [dword esi+0198h]
        lea edx, [byte esi+08h]
        fxch st2
        fstp dword [dword esi+03FCh]
        fstp dword [dword esi+0404h]
        fstp dword [dword esi+040Ch]
        fld dword [dword esi+03FCh]
        fld dword [dword esi+0404h]
        fld dword [dword esi+040Ch]
        lea ebx, [byte esi+0Ch]
        fxch st2
        fstp dword [dword esi+03F8h]
        fstp dword [dword esi+0400h]
        fstp dword [dword esi+0408h]
        lea ecx, [dword esi+0C0h]
.19:
        mov eax, dword [dword edx+0328h]
        mov dword [dword esp+0114h], eax
        fld dword [dword esp+0114h]
        fcomp dword [dword esi+03F8h]
        fnstsw ax
        sahf
        jae short .20
        mov eax, dword [dword esp+0114h]
        mov dword [dword esi+03F8h], eax
        jmp short .21
.20:
        fld dword [dword esp+0114h]
        fcomp dword [dword esi+03FCh]
        fnstsw ax
        sahf
        jbe short .21
        mov eax, dword [dword esp+0114h]
        mov dword [dword esi+03FCh], eax
.21:
        mov eax, dword [dword edx+032Ch]
        mov dword [dword esp+0110h], eax
        fld dword [dword esp+0110h]
        fcomp dword [dword esi+0400h]
        fnstsw ax
        sahf
        jae short .22
        mov eax, dword [dword esp+0110h]
        mov dword [dword esi+0400h], eax
        jmp short .23
.22:
        fld dword [dword esp+0110h]
        fcomp dword [dword esi+0404h]
        fnstsw ax
        sahf
        jbe short .23
        mov eax, dword [dword esp+0110h]
        mov dword [dword esi+0404h], eax
.23:
        mov eax, dword [dword ebx+0198h]
        mov dword [dword esp+010Ch], eax
        fld dword [dword esp+010Ch]
        fcomp dword [dword esi+0408h]
        fnstsw ax
        sahf
        jae short .24
        mov eax, dword [dword esp+010Ch]
        mov dword [dword esi+0408h], eax
        jmp short .25
.24:
        fld dword [dword esp+010Ch]
        fcomp dword [dword esi+040Ch]
        fnstsw ax
        sahf
        jbe short .25
        mov eax, dword [dword esp+010Ch]
        mov dword [dword esi+040Ch], eax
.25:
        add edx, byte 8
        add ebx, byte 0Ch
        cmp edx, ecx
        jne near .19
        fldz
        fcomp dword [dword esi+03FCh]
        fnstsw ax
        sahf
        ja short .26
        fild dword [ViewPixelWidth]
        fcomp dword [dword esi+03F8h]
        fnstsw ax
        sahf
        jbe short .26
        fldz
        fcomp dword [dword esi+0404h]
        fnstsw ax
        sahf
        ja short .26
        fild dword [ViewPixelHeight]
        fcomp dword [dword esi+0400h]
        fnstsw ax
        sahf
        jbe short .26
        fldz
        fcomp dword [dword esi+0408h]
        fnstsw ax
        sahf
        jb short .27
.26:
        fld dword [dword esi+0424h]
        call __CHP
        mov dword [dword esi+0748h], 0
        jmp near .29
.27:
        lea eax, [dword esi+01FCh]
        lea edx, [dword esi+0208h]
        mov dword [dword esp+0100h], edx
        lea edx, [dword esi+0214h]
        lea ebx, [dword esp+0C0h]
        mov dword [dword esp+0104h], edx
        mov edx, dword [dword esp+0100h]
        call VecSub
        lea ebx, [dword esp+0D8h]
        mov edx, dword [dword esp+0100h]
        mov eax, dword [dword esp+0104h]
        lea ecx, [dword esi+02C8h]
        call VecSub
        lea edx, [dword esp+0D8h]
        lea eax, [dword esp+0C0h]
        mov ebx, ecx
        call VecCross
        lea eax, [dword esi+0220h]
        lea edi, [dword esi+022Ch]
        lea ecx, [dword esi+0238h]
        lea edx, [dword esi+02D4h]
        lea ebx, [byte esp+048h]
        mov dword [dword esp+0E8h], edx
        mov edx, edi
        call VecSub
        lea ebx, [dword esp+090h]
        mov edx, edi
        mov eax, ecx
        call VecSub
        mov ebx, dword [dword esp+0E8h]
        lea edx, [dword esp+090h]
        lea eax, [byte esp+048h]
        call VecCross
        lea eax, [dword esi+01D8h]
        lea edx, [dword esi+01E4h]
        mov dword [dword esp+0ECh], edx
        lea edx, [dword esi+01F0h]
        mov dword [dword esp+0F0h], edx
        lea edx, [dword esi+02E0h]
        lea ebx, [byte esp+054h]
        mov dword [dword esp+0E4h], edx
        mov edx, dword [dword esp+0ECh]
        call VecSub
        lea ebx, [dword esp+0CCh]
        mov edx, dword [dword esp+0ECh]
        mov eax, dword [dword esp+0F0h]
        call VecSub
        mov ebx, dword [dword esp+0E4h]
        lea edx, [dword esp+0CCh]
        lea eax, [byte esp+054h]
        call VecCross
        lea eax, [dword esi+01B4h]
        lea edx, [dword esi+01C0h]
        mov dword [dword esp+0E8h], edx
        lea edx, [dword esi+01CCh]
        mov dword [dword esp+0F4h], edx
        lea edx, [dword esi+02ECh]
        lea ebx, [dword esp+09Ch]
        mov dword [dword esp+0118h], edx
        mov edx, dword [dword esp+0E8h]
        call VecSub
        lea ebx, [byte esp+060h]
        mov edx, dword [dword esp+0E8h]
        mov eax, dword [dword esp+0F4h]
        call VecSub
        mov ebx, dword [dword esp+0118h]
        lea edx, [byte esp+060h]
        lea eax, [dword esp+09Ch]
        call VecCross
        lea eax, [dword esi+0250h]
        mov dword [dword esp+0FCh], eax
        lea eax, [dword esi+02F8h]
        mov dword [dword esp+0F8h], eax
        lea ebx, [dword esp+084h]
        mov edx, dword [dword esp+0104h]
        mov eax, dword [dword esp+0100h]
        call VecSub
        lea ebx, [byte esp+078h]
        mov edx, dword [dword esp+0104h]
        mov eax, dword [dword esp+0FCh]
        call VecSub
        mov ebx, dword [dword esp+0F8h]
        lea edx, [byte esp+078h]
        lea eax, [dword esp+084h]
        call VecCross
        lea eax, [dword esi+0244h]
        lea ebx, [dword esp+0B4h]
        mov dword [dword esp+0118h], eax
        lea eax, [dword esi+0304h]
        mov edx, ecx
        mov dword [dword esp+0F4h], eax
        mov eax, edi
        call VecSub
        lea ebx, [dword esp+0A8h]
        mov eax, dword [dword esp+0118h]
        mov edx, ecx
        call VecSub
        mov ebx, dword [dword esp+0F4h]
        lea edx, [dword esp+0A8h]
        lea eax, [dword esp+0B4h]
        call VecCross
.28:
        fld dword [dword esi+0424h]
        call __CHP
.29:
        fistp dword [dword esp+0108h]
        mov eax, dword [dword esp+0108h]
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PoseAndDrawModel                                59DB8  97 PC, low confidence
; Poses a model at its frame and draws it
;-----------------------------------------------------------------------------
PoseAndDrawModel:
        push ebx
        push ecx
        mov ebx, eax
        mov ecx, edx
        call UpdateModelFrame
        mov edx, ecx
        mov eax, ebx
        call SkinModel
        push ebx
        call ProjectModelPoints
        add esp, byte 4
        push ebx
        call DrawModel
        add esp, byte 4
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawModelByDetail                               59DE4  97 PC, low confidence
; Draws a model at the detail level picked from its distance
;-----------------------------------------------------------------------------
DrawModelByDetail:
        push ebx
        push ecx
        push edx
        sub esp, byte 8
        mov edx, eax
        fld dword [dword eax+02A0h]
        push eax
        fistp dword [esp]
        pop eax
        mov ebx, dword [str_Punct_DrawRinkSurface]
        mov dword [byte esp+04h], eax
        cmp eax, ebx
        jle short .4
        fild dword [byte esp+04h]
        fst dword [esp]
        fcomp dword [ModelLodNear]
        fnstsw ax
        sahf
        jbe short .1
        mov ebx, dword [dword edx+06C0h]
        mov ebx, dword [ebx]
        jmp short .3
.1:
        fld dword [esp]
        fcomp dword [ModelLodFar]
        fnstsw ax
        sahf
        jbe short .2
        mov ebx, dword [dword edx+06C0h]
        mov ebx, dword [byte ebx+04h]
        jmp short .3
.2:
        mov ebx, dword [dword edx+06C0h]
        mov ebx, dword [byte ebx+08h]
.3:
        lea ecx, [dword edx+0190h]
        mov eax, ebx
        mov edx, ecx
        call UpdateModelFrame
        mov edx, ecx
        mov eax, ebx
        call SkinModel
        push ebx
        call ProjectModelPoints
        add esp, byte 4
        push ebx
        call DrawModel
        add esp, byte 4
.4:
        add esp, byte 8
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawPlayerModel                                 59E74  97 PC, low confidence
; Draws one player model with its stick
;-----------------------------------------------------------------------------
DrawPlayerModel:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 8
        mov ebx, eax
        fld dword [dword eax+01A4h]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [esp], eax
        xor edi, edi
        fild dword [esp]
        fst dword [byte esp+04h]
        fcomp dword [PlayerLodNear]
        fnstsw ax
        sahf
        jbe short .1
        mov esi, dword [dword ebx+06D8h]
        jmp short .3
.1:
        fld dword [byte esp+04h]
        fcomp dword [PlayerLodFar]
        fnstsw ax
        sahf
        jbe short .2
        mov esi, dword [dword ebx+06DCh]
        jmp short .3
.2:
        fld dword [byte ebx+05Ch]
        fadd dword [F32_50_DrawPlayerModel]
        mov esi, dword [dword ebx+06E0h]
        fcomp dword [dword ebx+014Ch]
        fnstsw ax
        sahf
        jbe short .3
        mov edi, 1
.3:
        lea ecx, [dword ebx+0190h]
        mov eax, esi
        mov edx, ecx
        call UpdateModelFrame
        mov edx, ecx
        mov eax, esi
        call SkinModel
        push esi
        call ProjectModelPoints
        add esp, byte 4
        test edi, edi
        je short .4
        push byte 0
        push byte 0
        push PlayerDrawParams
        mov edx, dword [dword esi+080h]
        push edx
        push byte 0Ah
        push byte 0
        call FillPolygonPoints
        add esp, byte 18h
.4:
        mov dword [dword ebx+0738h], esi
        add esp, byte 8
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
DrawPlayerModel_BC:
        push ecx
        push edx
        mov edx, dword [dword eax+0738h]
        push edx
        call DrawModel
        add esp, byte 4
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; DrawObjectShadow                                59F44  97 PC, low confidence
; Draws the shadow of an object on the ice
;-----------------------------------------------------------------------------
DrawObjectShadow:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 28h
        mov ecx, eax
        mov edx, dword [dword eax+0288h]
        mov dword [byte esp+024h], edx
        fld dword [byte esp+024h]
        fcomp dword [ShadowLodDist]
        fnstsw ax
        sahf
        ja near .1
        mov ebx, esp
        mov eax, 2
        lea edx, [dword ecx+0330h]
        call FloatsToInts
        lea ebx, [byte esp+08h]
        mov eax, 2
        lea edx, [dword ecx+0338h]
        call FloatsToInts
        lea ebx, [byte esp+010h]
        mov eax, 2
        lea edx, [dword ecx+03C8h]
        call FloatsToInts
        lea ebx, [byte esp+018h]
        mov eax, 2
        lea edx, [dword ecx+03D0h]
        call FloatsToInts
        mov edx, dword [byte esp+08h]
        mov ebx, dword [byte esp+010h]
        sub edx, ebx
        sar edx, 1
        mov ecx, dword [byte esp+014h]
        lea ebp, [ebx+edx]
        mov edx, dword [byte esp+0Ch]
        sub edx, ecx
        sar edx, 1
        lea edi, [ecx+edx]
        mov edx, dword [esp]
        sub edx, ebx
        sar edx, 2
        lea esi, [ebx+edx]
        mov edx, dword [byte esp+04h]
        sub edx, ecx
        push dword 41960000h
        sar edx, 2
        mov ebx, dword [byte esp+0Ch]
        add ecx, edx
        mov edx, dword [byte esp+01Ch]
        mov eax, dword [byte esp+010h]
        sub edx, ebx
        mov ebx, dword [byte esp+020h]
        push dword [byte esp+028h]
        sub ebx, eax
        call ProjectCoord
        call __CHP
        fistp dword [byte esp+020h]
        mov eax, dword [byte esp+020h]
        sar ebx, 2
        push eax
        mov eax, dword [PlayerArtTables+270h]
        add ecx, ebx
        push eax
        sar edx, 2
        push ecx
        add esi, edx
        push esi
        add ebx, edi
        push ebx
        add edx, ebp
        push edx
        call DrawShadowShape
        add esp, byte 18h
.1:
        add esp, byte 28h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawHeadModel                                   5A048  97 PC, low confidence
; Draws a player's head model
;-----------------------------------------------------------------------------
DrawHeadModel:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov esi, eax
        fld dword [dword eax+01B0h]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [byte esp+04h], eax
        mov dword [esp], eax
        fild dword [byte esp+04h]
        fst dword [byte esp+08h]
        fcomp dword [HeadLodNear]
        fnstsw ax
        sahf
        jbe short .1
        mov edi, dword [dword esi+06BCh]
        mov edi, dword [edi]
        jmp short .4
.1:
        fld dword [byte esp+08h]
        fcomp dword [HeadLodFar]
        fnstsw ax
        sahf
        jbe short .2
        mov edi, dword [dword esi+06BCh]
        mov ebx, dword [byte esi+034h]
        mov edi, dword [byte edi+04h]
        test ebx, ebx
        jne short .4
        mov edx, dword [HeadDetail]
        jmp short .3
.2:
        mov edi, dword [dword esi+06BCh]
        mov edx, dword [byte esi+034h]
        mov edi, dword [byte edi+08h]
        test edx, edx
        jne short .4
        mov edx, dword [HeadModelData]
.3:
        mov eax, edi
        mov ebx, dword [dword esi+073Ch]
        call SwapFaceTexture
.4:
        lea ebx, [dword esi+0190h]
        mov eax, edi
        mov edx, ebx
        call UpdateModelFrame
        mov edx, ebx
        mov eax, edi
        call SkinModel
        push edi
        call ProjectModelPoints
        add esp, byte 4
        push edi
        call DrawModel
        mov ecx, dword [byte esi+034h]
        add esp, byte 4
        test ecx, ecx
        jne near .15
        mov edi, dword [dword esi+0750h]
        test edi, edi
        jne near .15
        fild dword [esp]
        fcomp dword [HeadLodMid]
        fnstsw ax
        sahf
        jae near .15
        cmp dword [RenderTimersOn], byte 0
        jne near .15
        mov eax, dword [byte esi+048h]
        mov ebx, dword [dword esi+06F0h]
        test eax, eax
        jne short .5
        mov eax, dword [tickcount]
        sub eax, dword [dword esi+075Ch]
        test eax, eax
        jle short .5
        cmp eax, byte 64h
        setl al
        movzx edi, al
        mov eax, dword [tickcount]
        mov ebp, eax
        call Random32
        mov edx, 190h
        and eax, 0FFFFh
        add ebp, byte 64h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        add ebp, eax
        mov dword [dword esi+075Ch], ebp
.5:
        cmp dword [dword esi+0758h], byte 0
        jne short .6
        test edi, edi
        je near .14
.6:
        push ebx
        call ResetMorphVerts
        mov ebp, dword [byte esi+044h]
        add esp, byte 4
        cmp ebp, byte 1
        jne short .7
        push dword 3F800000h
        push ebp
        jmp short .9
.7:
        cmp ebp, byte 2
        jne short .8
        push dword 3F800000h
        push byte 3
        jmp short .9
.8:
        cmp ebp, byte 3
        jne short .10
        push dword 3F800000h
        push byte 4
.9:
        push ebx
        call ApplyMorphTarget
        add esp, byte 0Ch
.10:
        cmp dword [byte esi+048h], byte 0
        jne short .11
        test edi, edi
        je short .12
.11:
        push dword 3F800000h
        push byte 0
        push ebx
        call ApplyMorphTarget
        add esp, byte 0Ch
.12:
        cmp dword [byte esi+040h], byte 0
        je short .13
        push dword 3F800000h
        push byte 2
        push ebx
        call ApplyMorphTarget
        add esp, byte 0Ch
.13:
        mov dword [dword esi+0758h], edi
.14:
        add esi, 190h
        mov eax, ebx
        mov edx, esi
        call UpdateModelFrame
        mov edx, esi
        mov eax, ebx
        call SkinModel
        push ebx
        call ProjectModelPoints
        add esp, byte 4
        push ebx
        call DrawModel
        add esp, byte 4
.15:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawLeftArmModel                                5A238  97 PC, low confidence
; Poses and draws one arm part of a player model (left side, probably)
;-----------------------------------------------------------------------------
DrawLeftArmModel:
        push ebx
        push ecx
        push edx
        sub esp, byte 4
        mov edx, eax
        cmp dword [byte eax+034h], byte 0
        je short .1
        lea ecx, [dword eax+0190h]
        mov ebx, dword [dword eax+06C8h]
        mov edx, ecx
        mov eax, ebx
        call UpdateModelFrame
        mov edx, ecx
        mov eax, ebx
        call SkinModel
        push ebx
        call ProjectModelPoints
        add esp, byte 4
        push ebx
        call DrawModel
        add esp, byte 4
        jmp short .3
.1:
        fld dword [dword eax+0228h]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [esp], eax
        add edx, 428h
        fild dword [esp]
        fcomp dword [ArmLodDist]
        fnstsw ax
        sahf
        jbe short .2
        mov eax, edx
        call DrawLimbSegmentFlat
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        mov eax, edx
        call DrawLimbSegment
.3:
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
DrawLeftArmModel_80:
        push edx
        sub esp, byte 4
        mov edx, eax
        fld dword [dword eax+0204h]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [esp], eax
        add edx, 560h
        fild dword [esp]
        fcomp dword [ArmLodDist]
        fnstsw ax
        sahf
        jbe short .4
        mov eax, edx
        call DrawLimbSegmentFlat
        add esp, byte 4
        pop edx
        ret
.4:
        mov eax, edx
        call DrawLimbSegment
        add esp, byte 4
        pop edx
        ret
;-----------------------------------------------------------------------------
; DrawRightArmModel                               5A2F8  97 PC, low confidence
; Poses and draws the other arm part of a player model (right side, probably)
;-----------------------------------------------------------------------------
DrawRightArmModel:
        push ebx
        push ecx
        push edx
        sub esp, byte 4
        mov edx, eax
        cmp dword [byte eax+034h], byte 0
        je short .1
        lea ecx, [dword eax+0190h]
        mov ebx, dword [dword eax+06C4h]
        mov edx, ecx
        mov eax, ebx
        call UpdateModelFrame
        mov edx, ecx
        mov eax, ebx
        call SkinModel
        push ebx
        call ProjectModelPoints
        add esp, byte 4
        push ebx
        call DrawModel
        add esp, byte 4
        jmp short .3
.1:
        fld dword [dword eax+0204h]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [esp], eax
        add edx, 45Ch
        fild dword [esp]
        fcomp dword [ArmLodDist]
        fnstsw ax
        sahf
        jbe short .2
        mov eax, edx
        call DrawLimbSegmentFlat
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        mov eax, edx
        call DrawLimbSegment
.3:
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
DrawRightArmModel_80:
        push edx
        sub esp, byte 4
        mov edx, eax
        fld dword [dword eax+0204h]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [esp], eax
        add edx, 594h
        fild dword [esp]
        fcomp dword [ArmLodDist]
        fnstsw ax
        sahf
        jbe short .4
        mov eax, edx
        call DrawLimbSegmentFlat
        add esp, byte 4
        pop edx
        ret
.4:
        mov eax, edx
        call DrawLimbSegment
        add esp, byte 4
        pop edx
        ret
DrawRightArmModel_C0:
        push edx
        sub esp, byte 4
        mov edx, eax
        fld dword [dword eax+01C8h]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [esp], eax
        add edx, 4C4h
        fild dword [esp]
        fcomp dword [ArmLodDist]
        fnstsw ax
        sahf
        jbe short .5
        mov eax, edx
        call DrawLimbSegmentFlat
        add esp, byte 4
        pop edx
        ret
.5:
        mov eax, edx
        call DrawLimbSegment
        add esp, byte 4
        pop edx
        ret
DrawRightArmModel_100:
        push edx
        sub esp, byte 4
        mov edx, eax
        fld dword [dword eax+01C8h]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [esp], eax
        add edx, 490h
        fild dword [esp]
        fcomp dword [ArmLodDist]
        fnstsw ax
        sahf
        jbe short .6
        mov eax, edx
        call DrawLimbSegmentFlat
        add esp, byte 4
        pop edx
        ret
.6:
        mov eax, edx
        call DrawLimbSegment
        add esp, byte 4
        pop edx
        ret
DrawRightArmModel_140:
        push edx
        sub esp, byte 4
        mov edx, eax
        fld dword [dword eax+01ECh]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [esp], eax
        add edx, 52Ch
        fild dword [esp]
        fcomp dword [ArmLodDist]
        fnstsw ax
        sahf
        jbe short .7
        mov eax, edx
        call DrawLimbSegmentFlat
        add esp, byte 4
        pop edx
        ret
.7:
        mov eax, edx
        call DrawLimbSegment
        add esp, byte 4
        pop edx
        ret
DrawRightArmModel_180:
        add eax, 4F8h
        jmp near DrawLimbSegment
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawStickModel                                  5A484  97 PC, low confidence
; Poses and draws a stick model
;-----------------------------------------------------------------------------
DrawStickModel:
        push ebx
        push ecx
        push edx
        sub esp, byte 4
        mov ecx, eax
        fld dword [dword eax+021Ch]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [esp], eax
        fild dword [esp]
        fcomp dword [StickLodDist]
        fnstsw ax
        sahf
        jbe short .1
        mov ebx, dword [StickModels]
        jmp short .2
.1:
        mov ebx, dword [StickArt]
.2:
        add ecx, 190h
        mov eax, ebx
        mov edx, ecx
        call UpdateModelFrame
        mov edx, ecx
        mov eax, ebx
        call SkinModel
        push ebx
        call ProjectModelPoints
        add esp, byte 4
        push ebx
        call DrawModel
        add esp, byte 4
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawGoalieStickModel                            5A4E8  97 PC, low confidence
; Poses and draws the goalie stick model
;-----------------------------------------------------------------------------
DrawGoalieStickModel:
        push ebx
        push ecx
        push edx
        sub esp, byte 4
        mov ecx, eax
        fld dword [dword eax+0240h]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [esp], eax
        fild dword [esp]
        fcomp dword [StickLodDist]
        fnstsw ax
        sahf
        jbe short .1
        mov ebx, dword [GoalieStickModels]
        jmp short .2
.1:
        mov ebx, dword [GoalieStickArt]
.2:
        add ecx, 190h
        mov eax, ebx
        mov edx, ecx
        call UpdateModelFrame
        mov edx, ecx
        mov eax, ebx
        call SkinModel
        push ebx
        call ProjectModelPoints
        add esp, byte 4
        push ebx
        call DrawModel
        add esp, byte 4
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
        push ebx
        push ecx
        push edx
        lea ecx, [dword eax+0190h]
        mov ebx, dword [dword eax+06CCh]
        mov edx, ecx
        mov eax, ebx
        call UpdateModelFrame
        mov edx, ecx
        mov eax, ebx
        call SkinModel
        push ebx
        call ProjectModelPoints
        add esp, byte 4
        push ebx
        call DrawModel
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
        push ebx
        push ecx
        push edx
        lea ecx, [dword eax+0190h]
        mov ebx, dword [dword eax+06D0h]
        mov edx, ecx
        mov eax, ebx
        call UpdateModelFrame
        mov edx, ecx
        mov eax, ebx
        call SkinModel
        push ebx
        call ProjectModelPoints
        add esp, byte 4
        push ebx
        call DrawModel
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawLeftHandModel                               5A5BC  97 PC, low confidence
; Poses and draws one hand of a player model
;-----------------------------------------------------------------------------
DrawLeftHandModel:
        push ebx
        push ecx
        push edx
        sub esp, byte 4
        mov edx, eax
        cmp dword [byte eax+034h], byte 0
        je short .2
        mov ecx, dword [byte edx+028h]
        add eax, 190h
        test ecx, ecx
        je short .1
        mov ebx, dword [dword edx+06CCh]
        mov edx, eax
        mov eax, ebx
        call PoseAndDrawModel
        jmp short .4
.1:
        mov ebx, dword [dword edx+06D0h]
        mov edx, eax
        mov eax, ebx
        call PoseAndDrawModel
        jmp short .4
.2:
        fld dword [dword eax+01F8h]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [esp], eax
        add edx, 5FCh
        fild dword [esp]
        fcomp dword [ArmLodDist]
        fnstsw ax
        sahf
        jbe short .3
        mov eax, edx
        call DrawLimbSegmentFlat
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov eax, edx
        call DrawLimbSegment
.4:
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawRightHandModel                              5A638  97 PC, low confidence
; Poses and draws the other hand of a player model
;-----------------------------------------------------------------------------
DrawRightHandModel:
        push ebx
        push ecx
        push edx
        sub esp, byte 4
        mov edx, eax
        cmp dword [byte eax+034h], byte 0
        je short .2
        mov ecx, dword [byte edx+028h]
        add eax, 190h
        test ecx, ecx
        je short .1
        mov ebx, dword [dword edx+06D0h]
        mov edx, eax
        mov eax, ebx
        call PoseAndDrawModel
        jmp short .4
.1:
        mov ebx, dword [dword edx+06CCh]
        mov edx, eax
        mov eax, ebx
        call PoseAndDrawModel
        jmp short .4
.2:
        fld dword [dword eax+01D4h]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [esp], eax
        add edx, 5C8h
        fild dword [esp]
        fcomp dword [ArmLodDist]
        fnstsw ax
        sahf
        jbe short .3
        mov eax, edx
        call DrawLimbSegmentFlat
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        mov eax, edx
        call DrawLimbSegment
.4:
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ScaleModelLods                                  5A6B4  97 PC, low confidence
; Scales the model detail distances by the view scale and detail setting
;-----------------------------------------------------------------------------
ScaleModelLods:
        fld dword [ProjDetailScale]
        fmul qword [F64_0p002]
        fmul dword [F32_1]
        xor eax, eax
.1:
        fld dword [dword eax+F32_2000_ScaleModelLods]
        fmul st1
        add eax, byte 4
        fstp dword [dword eax+LodScale]
        cmp eax, byte 28h
        jne short .1
        fstp st0
;-----------------------------------------------------------------------------
; SetModelExtraFlags                              5A6E0  97 PC, low confidence
; Small setters for two model fields (the first entry only returns)
;-----------------------------------------------------------------------------
SetModelExtraFlags:
        ret
        db 08Dh,040h,00h
        mov dword [dword eax+0740h], edx
        ret
        db 090h
        mov dword [dword eax+0744h], edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawModelParts                                  5A6F4  97 PC, low confidence
; Draws every part of a player model (body, arms, hands, stick)
;-----------------------------------------------------------------------------
DrawModelParts:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebp, eax
        mov esi, edx
        fld dword [byte ebp+050h]
        fsub dword [byte eax+0Ch]
        fadd qword [F64_0p785398_DrawModelParts]
        fmul qword [F64_0p159155_DrawModelParts]
        fmul qword [F64_65536_DrawModelParts]
        lea ecx, [dword eax+0190h]
        mov ebx, dword [DrawPartsDone]
        push eax
        fistp dword [esp]
        pop eax
        and eax, 0C000h
        sar eax, 0Eh
        mov edx, dword [byte ebp+034h]
        lea edi, [nosplit eax*4+00h]
        test edx, edx
        je short .1
        mov edi, dword [dword edi+ModelPartLinksLeft]
        jmp short .2
.1:
        mov edi, dword [dword edi+ModelPartLinksRight]
.2:
        fld dword [byte ecx+068h]
        push eax
        fistp dword [esp]
        pop eax
        mov edx, dword [edi]
        add edx, eax
        mov eax, dword [DrawPartsDone]
        mov dword [nosplit eax*4+DrawSortList], edx
        lea edx, [nosplit eax*4+00h]
        inc eax
        mov dword [dword edx+DrawFuncTable], DrawRightArmModel_140
        mov dword [DrawPartsDone], eax
        fld dword [byte ecx+05Ch]
        push eax
        fistp dword [esp]
        pop eax
        add eax, dword [byte edi+08h]
        mov edx, dword [DrawPartsDone]
        shl edx, 2
        mov dword [dword edx+DrawSortList], eax
        mov eax, dword [DrawPartsDone]
        lea edx, [nosplit eax*4+00h]
        inc eax
        mov dword [dword edx+DrawFuncTable], DrawRightArmModel_180
        mov dword [DrawPartsDone], eax
        fld dword [byte ecx+044h]
        push eax
        fistp dword [esp]
        pop eax
        mov edx, dword [byte edi+04h]
        add edx, eax
        mov eax, dword [DrawPartsDone]
        mov dword [nosplit eax*4+DrawSortList], edx
        lea edx, [nosplit eax*4+00h]
        inc eax
        mov dword [dword edx+DrawFuncTable], DrawRightArmModel_C0
        mov dword [DrawPartsDone], eax
        fld dword [byte ecx+038h]
        push eax
        fistp dword [esp]
        pop eax
        mov edx, dword [byte edi+0Ch]
        add edx, eax
        mov eax, dword [DrawPartsDone]
        mov dword [nosplit eax*4+DrawSortList], edx
        lea edx, [nosplit eax*4+00h]
        inc eax
        mov dword [dword edx+DrawFuncTable], DrawRightArmModel_100
        mov dword [DrawPartsDone], eax
        fld dword [dword ecx+080h]
        push eax
        fistp dword [esp]
        pop eax
        add eax, dword [byte edi+018h]
        mov edx, dword [DrawPartsDone]
        shl edx, 2
        mov dword [dword edx+DrawSortList], eax
        mov eax, dword [DrawPartsDone]
        lea edx, [nosplit eax*4+00h]
        inc eax
        mov dword [dword edx+DrawFuncTable], DrawRightArmModel
        mov dword [DrawPartsDone], eax
        fld dword [byte ecx+074h]
        push eax
        fistp dword [esp]
        pop eax
        add eax, dword [byte edi+010h]
        mov edx, dword [DrawPartsDone]
        shl edx, 2
        mov dword [dword edx+DrawSortList], eax
        mov eax, dword [DrawPartsDone]
        lea edx, [nosplit eax*4+00h]
        inc eax
        mov dword [dword edx+DrawFuncTable], DrawRightArmModel_80
        mov dword [DrawPartsDone], eax
        fld dword [dword ecx+0A4h]
        push eax
        fistp dword [esp]
        pop eax
        add eax, dword [byte edi+01Ch]
        mov edx, dword [DrawPartsDone]
        shl edx, 2
        mov dword [dword edx+DrawSortList], eax
        mov eax, dword [DrawPartsDone]
        lea edx, [nosplit eax*4+00h]
        inc eax
        mov dword [dword edx+DrawFuncTable], DrawLeftArmModel
        mov dword [DrawPartsDone], eax
        fld dword [dword ecx+098h]
        push eax
        fistp dword [esp]
        pop eax
        add eax, dword [byte edi+014h]
        mov edx, dword [DrawPartsDone]
        shl edx, 2
        mov dword [dword edx+DrawSortList], eax
        mov eax, dword [DrawPartsDone]
        lea edx, [nosplit eax*4+00h]
        inc eax
        mov dword [dword edx+DrawFuncTable], DrawLeftArmModel_80
        mov dword [DrawPartsDone], eax
        fld dword [byte ecx+020h]
        push eax
        fistp dword [esp]
        pop eax
        mov edx, dword [DrawPartsDone]
        shl edx, 2
        mov dword [dword edx+DrawSortList], eax
        mov eax, dword [DrawPartsDone]
        lea edx, [nosplit eax*4+00h]
        inc eax
        mov dword [dword edx+DrawFuncTable], DrawHeadModel
        mov dword [DrawPartsDone], eax
        fld dword [byte ecx+014h]
        push eax
        fistp dword [esp]
        pop eax
        mov edx, dword [DrawPartsDone]
        shl edx, 2
        mov dword [dword edx+DrawSortList], eax
        mov eax, dword [DrawPartsDone]
        lea edx, [nosplit eax*4+00h]
        inc eax
        mov dword [dword edx+DrawFuncTable], DrawPlayerModel_BC
        mov dword [DrawPartsDone], eax
        fld dword [byte ecx+044h]
        push eax
        fistp dword [esp]
        pop eax
        mov edx, dword [byte edi+024h]
        add edx, eax
        mov eax, dword [DrawPartsDone]
        mov dword [nosplit eax*4+DrawSortList], edx
        lea edx, [nosplit eax*4+00h]
        inc eax
        mov dword [dword edx+DrawFuncTable], DrawRightHandModel
        mov dword [DrawPartsDone], eax
        fld dword [byte ecx+068h]
        push eax
        fistp dword [esp]
        pop eax
        add eax, dword [byte edi+020h]
        mov edx, dword [DrawPartsDone]
        shl edx, 2
        mov dword [dword edx+DrawSortList], eax
        mov eax, dword [DrawPartsDone]
        lea edx, [nosplit eax*4+00h]
        inc eax
        mov dword [dword edx+DrawFuncTable], DrawLeftHandModel
        mov dword [DrawPartsDone], eax
        mov eax, dword [byte ebp+038h]
        test eax, eax
        je short .3
        mov eax, dword [byte ebp+028h]
        fld dword [dword ecx+0D4h]
        shl eax, 2
        fadd dword [dword ecx+0110h]
        lea edx, [edi+eax]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [esp], edx
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        mov edx, dword [esp]
        add eax, dword [byte edx+028h]
        mov dword [esp], eax
        mov eax, dword [DrawPartsDone]
        mov edx, dword [esp]
        mov dword [nosplit eax*4+DrawSortList], edx
        lea edx, [nosplit eax*4+00h]
        inc eax
        mov dword [dword edx+DrawFuncTable], DrawModelByDetail
        mov dword [DrawPartsDone], eax
.3:
        cmp dword [byte ebp+034h], byte 0
        jne short .4
        cmp dword [dword ebp+0750h], byte 0
        jne short .4
        fild dword [byte edi+034h]
        fadd dword [dword ecx+0B0h]
        push eax
        fistp dword [esp]
        pop eax
        mov edx, dword [DrawPartsDone]
        mov dword [nosplit edx*4+DrawSortList], eax
        mov eax, edx
        inc eax
        mov edx, DrawGoalieStickModel
        mov dword [DrawPartsDone], eax
        mov dword [nosplit eax*4+MarkerPoints+2Ch], edx
        fild dword [byte edi+030h]
        fadd dword [dword ecx+08Ch]
        push eax
        fistp dword [esp]
        pop eax
        mov edx, dword [DrawPartsDone]
        mov ecx, DrawStickModel
        mov dword [nosplit edx*4+DrawSortList], eax
        lea eax, [byte edx+01h]
        mov dword [nosplit edx*4+DrawFuncTable], ecx
        mov dword [DrawPartsDone], eax
.4:
        mov ecx, dword [DrawPartsDone]
        lea eax, [nosplit ebx*4+00h]
        shl ecx, 2
.5:
        cmp eax, ecx
        jge near SetupPlayerModel_CD
        mov edx, dword [dword eax+DrawSortList]
        add edx, edx
        add eax, byte 4
        add edx, esi
        inc ebx
        mov dword [dword eax+DrawPartCount], edx
        jmp short .5
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawPlayersSorted                               5AAB8  97 PC, low confidence
; Sorts the players by distance and draws each with its shadow
;-----------------------------------------------------------------------------
DrawPlayersSorted:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov esi, eax
        cmp dword [dword eax+0748h], byte 0
        je near .7
        mov ebx, dword [byte eax+04Ch]
        test ebx, ebx
        jl short .1
        mov eax, ebx
        shl eax, 4
        sub eax, ebx
        shl eax, 2
        sub eax, ebx
        mov edi, ObjectPositions
        shl eax, 5
        add edi, eax
        lea edx, [dword edi+041Ch]
        lea eax, [dword esi+041Ch]
        call VecDistance
        fcomp dword [F32_200]
        fnstsw ax
        sahf
        ja short .1
        fld dword [dword edi+0424h]
        fcomp dword [dword esi+0424h]
        fnstsw ax
        sahf
        ja near .7
        jmp short .2
.1:
        xor edi, edi
.2:
        mov eax, esi
        xor ecx, ecx
        xor edx, edx
        mov dword [DrawPartsDone], ecx
        call DrawPlayerModel
        mov eax, esi
        call DrawModelParts
        mov eax, esi
        call DrawObjectShadow
        test edi, edi
        je short .3
        mov eax, edi
        call DrawObjectShadow
        mov eax, edi
        mov edx, 1
        call DrawPlayerModel
        mov eax, edi
        call DrawModelParts
.3:
        push DrawFuncTable
        push DrawSortList
        mov ebp, dword [DrawPartsDone]
        push ebp
        xor ebx, ebx
        call SortIndices
        mov eax, dword [DrawPartsDone]
        add esp, byte 0Ch
        test eax, eax
        jle short .7
        xor edx, edx
.4:
        mov ah, byte [dword edx+DrawSortList]
        mov ecx, edx
        test ah, 1
        je short .5
        mov eax, edi
        jmp short .6
.5:
        mov eax, esi
.6:
        call dword [dword ecx+DrawFuncTable]
        mov ecx, dword [DrawPartsDone]
        inc ebx
        add edx, byte 4
        cmp ebx, ecx
        jl short .4
.7:
        pop ebp
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
        push ebp
        sub esp, byte 28h
        mov ebp, eax
        mov ecx, esp
        lea edx, [dword eax+0714h]
        mov ebx, CameraStateRecords+7
        mov eax, 3
        call SubVecs
        mov ecx, esp
        mov ebx, CameraStateRecords+253h
        mov edx, esp
        mov eax, 3
        mov esi, esp
        call TransformVecs
        lea edi, [dword ebp+025Ch]
        movsd
        movsd
        movsd
        lea esi, [byte esp+0Ch]
        lea edi, [dword ebp+0298h]
        movsd
        movsd
        movsd
        lea esi, [byte esp+018h]
        lea edi, [dword ebp+02A4h]
        movsd
        movsd
        movsd
        fld dword [byte esp+020h]
        call __CHP
        fistp dword [byte esp+024h]
        mov eax, dword [byte esp+024h]
        add esp, byte 28h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ClearObjectHidden                               5AC28  97 PC, low confidence
; Clears an object's hidden flag
;-----------------------------------------------------------------------------
ClearObjectHidden:
        mov dword [byte eax+038h], 0
        ret
;-----------------------------------------------------------------------------
; SetObjectHidden                                 5AC30  97 PC, low confidence
; Sets an object's hidden flag
;-----------------------------------------------------------------------------
SetObjectHidden:
        mov dword [byte eax+038h], 1
        ret
;-----------------------------------------------------------------------------
; RenderModelPortrait                             5AC38  97 PC, low confidence
; Renders a player model into an offscreen portrait
;-----------------------------------------------------------------------------
RenderModelPortrait:
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov edi, eax
        mov esi, edx
        mov ebp, ebx
        mov dword [byte esp+08h], ecx
        cmp dword [byte ebx+08h], 1F4h
        jl near .2
        mov ebx, dword [byte esi+08h]
        push ebx
        mov ecx, dword [esi]
        push ecx
        call AngleOfVector
        mov dword [byte esp+0Ch], eax
        add esp, byte 8
        mov eax, dword [byte esi+08h]
        push eax
        mov edx, dword [esi]
        push edx
        call vecdist
        add esp, byte 8
        push eax
        mov ebx, dword [byte esi+04h]
        push ebx
        call AngleOfVector
        mov dword [byte esp+08h], eax
        add esp, byte 8
        sub esp, byte 4
        fild dword [byte ebp+08h]
        fstp dword [esp]
        call PerspectiveScale
        sub esp, byte 4
        mov eax, edi
        mov ebx, dword [byte esp+08h]
        mov edx, dword [byte esp+04h]
        fstp dword [esp]
        call SavePortraitCamera
        mov ebx, eax
        test eax, eax
        jne near .1
        mov ecx, edi
        mov eax, ecx
        shl eax, 4
        sub eax, ecx
        fild dword [esi]
        shl eax, 2
        fld dword [CameraStateRecords+7]
        sub eax, ecx
        mov ecx, PortraitModels
        shl eax, 5
        faddp
        add ecx, eax
        fstp dword [ecx]
        fild dword [byte esi+04h]
        fadd dword [CameraStateRecords+0Bh]
        fstp dword [byte ecx+04h]
        fild dword [byte esi+08h]
        fadd dword [CameraStateRecords+0Fh]
        mov eax, ecx
        fstp dword [byte ecx+08h]
        call UpdateViewMatrix
        cmp dword [dword ecx+0748h], byte 0
        je short .2
        mov ebx, dword [byte esp+04h]
        mov edx, dword [esp]
        mov eax, edi
        lea esi, [dword ecx+0328h]
        call RestorePortraitCamera
        push esi
        push byte 1Ah
        sub esp, byte 4
        fild dword [byte ebp+08h]
        fstp dword [esp]
        mov edx, dword [byte esp+014h]
        mov ebx, eax
        call BeginOffscreenRender
        mov eax, ecx
        call DrawPlayersSorted
        call EndOffscreenRender
.1:
        sub esp, byte 4
        fild dword [byte ebp+08h]
        mov eax, ebx
        mov edx, dword [byte esp+0Ch]
        fstp dword [esp]
        call SetPortraitProjection
.2:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawPuckMarker                                  5AD54  97 PC, low confidence
; Draws the marker under the puck (projected onto the ice)
;-----------------------------------------------------------------------------
DrawPuckMarker:
        push esi
        push ebp
        mov ebp, esp
        sub esp, byte 68h
        and esp, byte 0FFFFFFF8h
        mov esi, eax
        mov dword [byte esp+054h], ecx
        mov eax, edx
        mov edx, ebx
        mov ebx, eax
        shl eax, 2
        sub eax, ebx
        lea ecx, [byte esi+058h]
        shl eax, 2
        lea ebx, [ecx+eax]
        mov eax, edx
        shl eax, 2
        sub eax, edx
        shl eax, 2
        lea edx, [ecx+eax]
        fld dword [byte edx+08h]
        fld dword [edx]
        fsub dword [ebx]
        fxch
        fsub dword [byte ebx+08h]
        fxch
        fstp dword [byte esp+064h]
        fst dword [byte esp+060h]
        sub esp, byte 8
        fstp qword [esp]
        fld dword [byte esp+06Ch]
        sub esp, byte 8
        fstp qword [esp]
        call hypot_
        fstp dword [byte esp+058h]
        test dword [byte esp+058h], 7FFFFFFFh
        je near .1
        fild dword [byte esp+054h]
        fld1
        fdiv dword [byte esp+058h]
        fxch
        fmul st1
        fld st0
        fmul dword [byte esp+064h]
        fld dword [ebx]
        fsub st1
        fld dword [byte esp+060h]
        fld st3
        fmul st1
        fxch st2
        fadd st2
        fstp dword [MarkerPoints]
        fld dword [byte ebx+08h]
        fsub st2
        fsub st3
        fild dword [byte ebp+0Ch]
        fxch
        fstp dword [MarkerPoints+8]
        fld dword [ebx]
        fsub st4
        fxch
        fmulp st6
        fsub st2
        fxch st5
        fstp st4
        fxch st4
        fstp dword [MarkerPoints+0Ch]
        fsubr dword [byte ebx+08h]
        fld st2
        fxch
        faddp st2
        fmul dword [byte esp+064h]
        fxch
        fstp dword [MarkerPoints+14h]
        fld dword [edx]
        fadd st1
        fxch st2
        fmulp st3
        fxch
        fsub st2
        fstp dword [MarkerPoints+18h]
        fld dword [byte edx+08h]
        fadd st2
        fadd st1
        fstp dword [MarkerPoints+20h]
        fld dword [edx]
        fadd st1
        mov ecx, esp
        fadd st2
        mov eax, 4
        fstp dword [MarkerPoints+24h]
        fld dword [byte edx+08h]
        faddp st2
        lea ebx, [dword esi+0698h]
        fsubp
        mov edx, MarkerPoints
        fstp dword [MarkerPoints+2Ch]
        call TransformVecs
        mov edx, esp
        mov eax, 4
        lea ebx, [dword esi+041Ch]
        call OffsetVecs
        lea ebx, [byte esp+030h]
        mov edx, esp
        mov eax, 4
        call ProjectPoints
        push byte 1
        push byte 0FFFFFFFFh
        lea eax, [byte esp+038h]
        push eax
        push byte 4
        push byte 0FFFFFFFFh
        call FillPolygon
        add esp, byte 14h
.1:
        mov esp, ebp
        pop ebp
        pop esi
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawPlayerMarkers                               5AEB8  97 PC, low confidence
; Draws the markers under the controlled players
;-----------------------------------------------------------------------------
DrawPlayerMarkers:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 50h
        mov edi, eax
        lea ecx, [dword eax+0A0h]
        lea edx, [byte eax+07Ch]
        lea ebx, [dword eax+0C4h]
        fld dword [ecx]
        lea esi, [dword eax+0E8h]
        fcomp dword [edx]
        fnstsw ax
        sahf
        jbe short .1
        mov eax, edx
        mov edx, ecx
        mov ecx, eax
.1:
        fld dword [ebx]
        fcomp dword [esi]
        fnstsw ax
        sahf
        jbe short .2
        mov edx, ebx
        mov ebx, esi
.2:
        fld dword [byte ecx+08h]
        fcomp dword [byte ebx+08h]
        fnstsw ax
        sahf
        jbe short .3
        fld dword [ebx]
        fadd dword [F32_neg30]
        fstp dword [MarkerPoints]
        fld dword [byte ebx+08h]
        fadd dword [F32_neg20_DrawPlayerMarkers]
        fstp dword [MarkerPoints+8]
        fld dword [ecx]
        fadd dword [F32_neg20_DrawPlayerMarkers]
        fstp dword [MarkerPoints+0Ch]
        fld dword [byte ecx+08h]
        fadd dword [F32_20_DrawPlayerMarkers]
        fstp dword [MarkerPoints+14h]
        jmp short .4
.3:
        fld dword [ebx]
        fadd dword [F32_neg30]
        fstp dword [MarkerPoints+0Ch]
        fld dword [byte ebx+08h]
        fadd dword [F32_20_DrawPlayerMarkers]
        fstp dword [MarkerPoints+14h]
        fld dword [ecx]
        fadd dword [F32_neg20_DrawPlayerMarkers]
        fstp dword [MarkerPoints]
        fld dword [byte ecx+08h]
        fadd dword [F32_neg20_DrawPlayerMarkers]
        fstp dword [MarkerPoints+8]
.4:
        fld dword [byte edx+08h]
        fcomp dword [byte esi+08h]
        fnstsw ax
        sahf
        jbe short .5
        fld dword [esi]
        fadd dword [F32_30]
        fstp dword [MarkerPoints+24h]
        fld dword [byte esi+08h]
        fadd dword [F32_neg20_DrawPlayerMarkers]
        fstp dword [MarkerPoints+2Ch]
        fld dword [edx]
        fadd dword [F32_20_DrawPlayerMarkers]
        fstp dword [MarkerPoints+18h]
        fld dword [byte edx+08h]
        fadd dword [F32_20_DrawPlayerMarkers]
        fstp dword [MarkerPoints+20h]
        jmp short .6
.5:
        fld dword [esi]
        fadd dword [F32_30]
        fstp dword [MarkerPoints+18h]
        fld dword [byte esi+08h]
        fadd dword [F32_20_DrawPlayerMarkers]
        fstp dword [MarkerPoints+20h]
        fld dword [edx]
        fadd dword [F32_20_DrawPlayerMarkers]
        fstp dword [MarkerPoints+24h]
        fld dword [byte edx+08h]
        fadd dword [F32_neg20_DrawPlayerMarkers]
        fstp dword [MarkerPoints+2Ch]
.6:
        mov ecx, esp
        mov edx, MarkerPoints
        mov eax, 4
        lea ebx, [dword edi+0698h]
        call TransformVecs
        mov edx, esp
        mov eax, 4
        lea ebx, [dword edi+041Ch]
        call OffsetVecs
        lea ebx, [byte esp+030h]
        mov edx, esp
        mov eax, 4
        call ProjectPoints
        lea edx, [byte esp+030h]
        mov eax, 4
        call PickMarkerShape
        cmp eax, byte 2
        jle short .7
        push byte 1
        push byte 0FFFFFFFFh
        lea eax, [byte esp+038h]
        push eax
        push byte 3
        push byte 0FFFFFFFFh
        call FillPolygon
        add esp, byte 14h
        push byte 1
        push byte 0FFFFFFFFh
        push MarkerColors
        lea eax, [byte esp+03Ch]
        push eax
        push byte 3
        push byte 0FFFFFFFFh
        call FillPolygonPoints
        add esp, byte 18h
        jmp short .8
.7:
        push byte 1
        push byte 0FFFFFFFFh
        lea eax, [byte esp+038h]
        push eax
        push byte 4
        push byte 0FFFFFFFFh
        call FillPolygon
        add esp, byte 14h
.8:
        add esp, byte 50h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawIceMarkers                                  5B090  97 PC, low confidence
; Draws the puck and player markers on the ice
;-----------------------------------------------------------------------------
DrawIceMarkers:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        cmp dword [dword eax+0748h], byte 0
        je near .5
        mov ecx, dword [dword eax+0740h]
        lea ebx, [dword eax+041Ch]
        test ecx, ecx
        jl short .1
        lea edx, [dword ecx+0F0h]
        mov eax, ebx
        call DrawNetShadows
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        cmp dword [dword eax+0744h], byte 0
        je short .2
        push byte 0FFFFFFFFh
        call MatchColor
        add esp, byte 4
        mov edx, eax
        mov eax, ebx
        call DrawNetShadows
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        call DrawPlayerMarkers
        push byte 0Fh
        mov ecx, 14h
        mov ebx, 8
        mov edx, 7
        mov eax, esi
        call DrawPuckMarker
        push byte 0Fh
        mov ecx, 14h
        mov ebx, 5
        mov edx, 4
        mov eax, esi
        call DrawPuckMarker
        cmp dword [byte esi+038h], byte 0
        je short .3
        push byte 8
        mov ecx, 8
        mov ebx, 16h
        mov edx, 11h
        mov eax, esi
        call DrawPuckMarker
.3:
        fld dword [dword esi+0424h]
        fcomp dword [PlayerLodNear]
        fnstsw ax
        sahf
        jae short .4
        push byte 14h
        mov ecx, 1Eh
        mov ebx, 0Bh
        mov edx, 9
        mov eax, esi
        call DrawPuckMarker
        push byte 14h
        mov ecx, 1Eh
        mov ebx, 0Eh
        mov edx, 0Ch
        mov eax, esi
        call DrawPuckMarker
.4:
        fld dword [dword esi+0424h]
        fcomp dword [PlayerLodNear]
        fnstsw ax
        sahf
        jae short .5
        push byte 0Fh
        mov ecx, 14h
        mov ebx, 7
        mov edx, 6
        mov eax, esi
        call DrawPuckMarker
        push byte 0Fh
        mov ecx, 14h
        mov ebx, 4
        mov edx, 3
        mov eax, esi
        call DrawPuckMarker
.5:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawPlayerNames                                 5B1C0  97 PC, low confidence
; Draws the names over the players
;-----------------------------------------------------------------------------
DrawPlayerNames:
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        cmp dword [PlayerArtTables+274h], byte 0
        je near .2
        cmp dword [PlayerNamesOn], byte 0
        je near .2
        mov eax, dword [tickcount]
        cmp eax, dword [PlayerArtTables+260h]
        jle short .1
        xor ebp, ebp
        mov dword [PlayerArtTables+274h], ebp
        jmp near .2
.1:
        mov eax, dword [PlayerArtTables+274h]
        fld dword [dword eax+0424h]
        fcomp dword [F32_50p0_View]
        fnstsw ax
        sahf
        jb near .2
        push DebugTagStr
        call SelectFont
        mov eax, dword [PlayerArtTables+274h]
        add esp, byte 4
        mov edx, esp
        add eax, 41Ch
        call ProjectPointInt
        mov eax, dword [PlayerArtTables+274h]
        add eax, byte 14h
        push eax
        call MeasureText
        mov edx, eax
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        add esp, byte 4
        mov esi, dword [esp]
        push dword 0FFh
        sub esi, eax
        push dword 0FF000000h
        mov dword [byte esp+08h], esi
        call MatchColor
        add esp, byte 4
        push eax
        call SetTextColors
        add esp, byte 8
        mov eax, dword [byte esp+04h]
        add eax, byte 6
        push eax
        mov edi, dword [byte esp+04h]
        mov eax, dword [PlayerArtTables+274h]
        push edi
        add eax, byte 14h
        push eax
        call DrawTextAt
        add esp, byte 0Ch
        push dword 0FFh
        push dword 0FFAAAAAAh
        call MatchColor
        add esp, byte 4
        push eax
        call SetTextColors
        add esp, byte 8
        mov eax, dword [byte esp+04h]
        add eax, byte 5
        push eax
        mov eax, dword [byte esp+04h]
        inc eax
        push eax
        mov eax, dword [PlayerArtTables+274h]
        add eax, byte 14h
        push eax
        call DrawTextAt
        add esp, byte 0Ch
.2:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawPuckArrow                                   5B2D4  97 PC, low confidence
; Draws the off-screen puck arrow
;-----------------------------------------------------------------------------
DrawPuckArrow:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov esi, eax
        cmp dword [dword eax+0748h], byte 0
        jne near .5
        cmp dword [dword eax+0740h], byte 0
        jl near .5
        fld dword [dword esi+041Ch]
        fld dword [dword eax+0420h]
        fchs
        call __CHP
        fistp dword [byte esp+08h]
        mov ecx, dword [byte esp+08h]
        call __CHP
        push ecx
        fistp dword [byte esp+0Ch]
        mov edi, dword [byte esp+0Ch]
        push edi
        call AngleOfVector
        xor edx, edx
        add esp, byte 8
        mov dl, byte [IdentityRemap]
        mov dword [byte esp+010h], edx
        xor edx, edx
        mov dl, byte [PuckArrowColors]
        mov dword [byte esp+0Ch], edx
        mov edx, esp
        push edx
        lea edx, [byte esp+08h]
        push edx
        mov edi, dword [ViewCenterY]
        push eax
        mov ebp, dword [str_D_ProjectPointsPersp]
        mov ebx, eax
        call FixedSinCos
        add esp, byte 0Ch
        mov edx, 3E8h
        mov eax, dword [byte esp+04h]
        sub edi, byte 8
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, 3E8h
        mov dword [byte esp+04h], eax
        mov eax, dword [esp]
        sub ebp, byte 8
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, dword [byte esp+04h]
        mov dword [esp], eax
        cmp edi, edx
        jl short .1
        neg edi
        cmp edi, edx
        jle short .2
.1:
        imul eax, edi
        mov edx, eax
        mov ecx, dword [byte esp+04h]
        sar edx, 1Fh
        mov dword [esp], eax
        idiv ecx
        mov dword [byte esp+04h], edi
        mov dword [esp], eax
.2:
        mov edi, dword [esp]
        cmp ebp, edi
        jl short .3
        neg ebp
        cmp ebp, edi
        jle short .4
.3:
        mov eax, dword [byte esp+04h]
        imul eax, ebp
        mov edx, eax
        sar edx, 1Fh
        mov dword [byte esp+04h], eax
        idiv edi
        mov dword [esp], ebp
        mov dword [byte esp+04h], eax
.4:
        mov al, byte [dword esi+0740h]
        add al, 0F0h
        push byte 0FFFFFFFFh
        mov byte [IdentityRemap], al
        call MatchColor
        add esp, byte 4
        mov byte [PuckArrowColors], al
        mov ebp, dword [esp]
        mov eax, dword [str_D_ProjectPointsPersp]
        sub ebx, 2000h
        add eax, ebp
        mov edx, dword [byte esp+04h]
        push eax
        mov eax, dword [ViewCenterY]
        and ebx, 0FFFFh
        add eax, edx
        sar ebx, 0Eh
        push eax
        mov ecx, dword [nosplit ebx*4+PuckArrowArt]
        push ecx
        call BlitShapeAt
        add esp, byte 0Ch
        mov al, byte [byte esp+010h]
        mov byte [IdentityRemap], al
        mov al, byte [byte esp+0Ch]
        mov byte [PuckArrowColors], al
.5:
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        lea eax, [byte eax+00h]
;-----------------------------------------------------------------------------
; NoOpDraw                                        5B450  97 PC, low confidence
; Does nothing (empty draw hook)
;-----------------------------------------------------------------------------
NoOpDraw:
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CopyVec3                                        5B454  97 PC, low confidence
; Copies a three-float vector; next entry adds two vectors
;-----------------------------------------------------------------------------
CopyVec3:
        push esi
        push edi
        mov edi, eax
        mov esi, edx
        movsd
        movsd
        movsd
        pop edi
        pop esi
        ret
        push ebx
        mov ebx, eax
        call VecAdd
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetObjectHeight                                 5B46C  97 PC, low confidence
; Sets the height of a vector; next entry adds to it
;-----------------------------------------------------------------------------
SetObjectHeight:
        push edx
        mov edx, dword [byte esp+08h]
        mov dword [byte eax+0Ch], edx
        pop edx
        ret 4
        fld dword [byte eax+0Ch]
        fadd dword [byte esp+04h]
        fstp dword [byte eax+0Ch]
        ret 4
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LinkModelPair                                   5B488  97 PC, low confidence
; Links two model slots to each other
;-----------------------------------------------------------------------------
LinkModelPair:
        push ecx
        mov ecx, eax
        shl eax, 4
        sub eax, ecx
        shl eax, 2
        sub eax, ecx
        shl eax, 5
        mov dword [dword eax+ModelPairs], edx
        mov eax, edx
        shl eax, 4
        sub eax, edx
        shl eax, 2
        sub eax, edx
        shl eax, 5
        mov dword [dword eax+ModelPairs], ecx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ClearModelSlots                                 5B4B8  97 PC, low confidence
; Marks every model slot as unused
;-----------------------------------------------------------------------------
ClearModelSlots:
        push edx
        mov edx, 0FFFFFFFFh
        xor eax, eax
.1:
        add eax, 760h
        mov dword [dword eax+ModelSlotTable], edx
        cmp eax, 5FE0h
        jne short .1
        pop edx
        ret
;-----------------------------------------------------------------------------
; RestoreSavedPalette                             5B4D4  97 PC, low confidence
; Restores the saved game palette
;-----------------------------------------------------------------------------
RestoreSavedPalette:
        push ecx
        push edx
        push dword 138h
        push SavedPalette
        push SeatModels
        call bcopy
        add esp, byte 0Ch
        push dword 138h
        push SavedPaletteRemap
        push SeatModels
        call bcopy
        add esp, byte 0Ch
        call MarkPaletteDirty
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; SaveGamePalette                                 5B50C  97 PC, low confidence
; Saves the current game palette
;-----------------------------------------------------------------------------
SaveGamePalette:
        push ecx
        push edx
        push dword 138h
        push SeatModels
        push eax
        call bcopy
        add esp, byte 0Ch
        push dword 138h
        push SavedPalette
        push SeatModels
        call bcopy
        add esp, byte 0Ch
        push dword 138h
        push SavedPaletteRemap
        push SeatModels
        call bcopy
        add esp, byte 0Ch
        call MarkPaletteDirty
        pop edx
        pop ecx
        ret
