; Rink model: lines, model, background and surface, benches, seats and portrait models.
bits 32
%include "hockey.inc"
section s_52E89 progbits alloc exec nowrite align=1
extern __CHP, AddModelName, AngleFromDelta, ArenaArchive, ArenaArchiveHandle, ArenaArt, ArenaModel, ArtBankCount
extern ArtBankEntry, AwayBenchModels, AwayBlueLineModel, bcopy, BenchCheerArt, BenchCheerData, BenchCheerFrames, BenchCheerModel
extern BenchCheerOn, BenchCheerParts, BenchDetail, BenchLineModel, BenchModel, BenchModelData, BenchModelParts, BenchPalette
extern BenchRemap, BenchSideIndex, BenchSideModel, BindModelShapes, BoardAdModel, BoardsTopModel, BoxModelData, BoxModels
extern BuildAntiAliasTable, BuildRangePaletteBuf, BuildReciprocalTable, BuildRinkGeometry, BuildRinkPalette, BuildRinkSides, BytesPerPixelForDepth, CameraFlashOn
extern CameraModeOn, CameraScenesEnabled, CameraStateRecords, CenterCircleModel, CenterSpotModel, ClearCrowdReaction, ClearScreen, ClipBottomEdge
extern ClipLeft, ClipPolyToNear, ClipRightEdge, ClipTop, CopyRangePalette, CreaseModel, CreasePolyModel, CreateModelInstance
extern CrowdCenter, CrowdModel, CrowdReactCount, CrowdReactLevel, CrowdReactOn, CrowdReactPos, CrowdReactStart, DrawAwayBlueLine
extern DrawBenchArea, DrawBenchDoors, DrawBenches, DrawBenchLines, DrawBenchPlayers, DrawBoardsLines, DrawBoardsTop, DrawCameraFlashes
extern DrawCenterCircle, DrawCenterCircle_30, DrawCenterSpots, DrawCreaseArc, DrawCreases, DrawEndSpots, DrawFlashSprite, DrawGlass
extern DrawGoalLight, DrawGoalLines, DrawHomeBlueLine, DrawIceSpans, DrawIceSurface, DrawModel, DrawModelInstance, DrawModelList
extern DrawNeutralSpots, DrawOverlayModels, DrawPenaltyBox, DrawPlayersSorted, DrawRinkLine, DrawRinkMarkings, DrawRinkObjectPolys, DrawRinkPolyList
extern DrawRinkPolys, DrawRinkPolyStrip, DrawStandsSides, DrawSurfacePolys, EndSpotModels, F64_3p14159_DrawPortraitModels, F64_neg3p14159_DrawPortraitModels, FaceoffSpotModel
extern FadeGamePalette, FarSideData, FarSideModel, FarSideParts, FillPolygon, FillRect, FindInstanceGroup, FindInstancePart
extern FindInstanceShape, FindModelName, FindShape, FlashModel, FlashPolys, FlashSpotPos, FlashSpots, FlashSpotTable
extern FlashTimer, FreeMemBlock, FreeModelFile, FreeModelInstance, FreeOverlaySlots, GetInstanceGroupEntry, GetRemapTable, GlassModel
extern GlassParts, GlassRemap, GoalCheerOn, GoalCheerTeam, GoalLightArt, GoalLightModel, GoalLightModelFar, GoalLightModelNear
extern GoalLightSpinFar, GoalLightSpinNear, GoalLightState, HomeBenchModels, HomeBlueLineModel, IntsToFloats, LoadArenaArt, LoadLogos
extern LoadModelByName, LoadNetArt, LoadRinkTextures, LogosLoaded, MatchColor, NearSideModel, NearSideParts, NeutralSpotModel
extern OpenArtArchiveErr, OpeningArt, OpeningArtPalette, OpeningArtSize, OpenResourceArchive, OverlayFrame, OverlayFrameSize, OverlayFrameStride
extern PauseArtModel, PortraitModels, ProjectCoord, ProjectOverlayPoint, ProjectPointsWithZ, ProjectRinkObjectPoints, Random32, RemapArtBank
extern RemapRangeColors, RenderModelPortrait, ReplayRegisterObjects, ReplayRegisterStates, RestoreSavedPalette, RinkCameraPoints, RinkColorUsed, RinkCorner
extern RinkExtraModel, RinkGeometryData, RinkGeometryModel, RinkGeometryParts, RinkLength, RinkLineArt, RinkLineData, RinkLineModel
extern RinkLinesLoaded, RinkMarkingGeometry, RinkMarkingModel, RinkModel, RinkModelBounds, RinkModelBuffer, RinkModelData, RinkModelFlags
extern RinkModelHeader, RinkModelNormals, RinkModelParts, RinkModelPieces, RinkModelPolys, RinkModelSize, RinkModelState, RinkModelTexInfo
extern RinkModelVerts, RinkOverlayModel, RinkPaletteData, RinkPaletteRemap, RinkPartModels, RinkPassCount, RinkSideGeometry, RinkSidesData
extern RinkSidesModel, RinkSurfaceDrawn, RinkTextureArt, RinkTextureInfo, RinkTexturePtrs, RinkTextureRows, RinkTextures, RinkViewPoints
extern RinkWidth, ScoreboardFrames, ScoreboardSpin, SeatModelBase, SeatModelCount, SeatModelFlag, SeatModelList, SeatModels
extern SeatModelSlots, SeatModelsUsed, SeatModelTeam, SeatPositions, ServiceIdle, SetArtArchive, SetModelPartName, SetRemapTable
extern SetRinkMatrix, SetRinkTranslation, ShowBenches, ShowCenterLogo, ShowOverlay, ShowRink, ShowShadows, ShowStands
extern SideParts, SinInterp, SinTable, sprintf_, StandsDetail, StandsDetailLevel, StandsPalette, StartCrowdReaction
extern str_04d, str_ArenaViv2, str_B00, str_Benchbk, str_Benchdiv, str_Benchx, str_Benchz0, str_Benchz1
extern str_Boardback, str_BOGIE, str_Botboards, str_Boxback, str_C0, str_C1, str_C2, str_C3
extern str_Center, str_Crease, str_Door00, str_Door01, str_Door02, str_Door10, str_Door11, str_Door12
extern str_DoorZ0, str_DoorZ1, str_FaceoffD, str_FatBlueLines, str_FatRedLines, str_Fla0, str_Fla1, str_Flash
extern str_Flatboards, str_Floor, str_FLOOR, str_Fx, str_Glass, str_Glassline, str_Glite0, str_Glite1
extern str_Goal0, str_Goal1, str_Grnlite, str_Gt004, str_Gt007, str_Gt302, str_Gt304, str_Hinet
extern str_IceLine, str_L0, str_L1, str_L2, str_L3, str_Light, str_Light6, str_Lites
extern str_Lonet, str_Maxx, str_Maxz, str_Minx, str_Minz, str_Net, str_PAL, str_Pbench0D
extern str_Pbench1D, str_Penback, str_Penbox0D, str_Penbox1D, str_Penboxt0, str_Penboxt1, str_Penboxz0, str_Penboxz1
extern str_Puck2, str_Punct_DrawRinkSurface, str_R02d, str_Redlite, str_Rink, str_Rlite0, str_Rlite1, str_Score
extern str_STAND, str_STAND2ND, str_Stands2, str_Strobe, str_ThinRedLines, str_Topboards, str_WALL, str_XD
extern SubVec3, TextureDetail, TransformRink, TransformRinkPoints, UpdateModelInstance, UpdateRinkPalette, UpdateScoreboardPos, UpdateScoreboardSpin
extern UpdateViewMatrix, VecMulMat, VecSub, ViewHeight, ViewOriginX, ViewOriginY, ViewScreenHeight, ViewScreenWidth
extern ViewWidth
global LoadRinkLines, SetupRinkModel, LoadRinkModel, FreeRinkModel, SetRinkTransform, DrawRinkBackground, DrawRinkSurface, LoadOpeningArt
global DrawRinkOverlay, DrawBenchModels, DrawBenchSide, GetSeatPos, SetBoxDoor, SetBoxDoor_105, SetBoxDoor_115, SetBoxDoor_11A
global SetPenaltyBoxDoor, SetBoxDoorState, DrawBenchRow, DrawBenchSection, DrawRinkPass, DrawNearSide, DrawFarSide, SaveViewOrigin
global UniformFontColors, UniformFontShadow, ShapePixelSize, DrawShadowShape, ModelViewDepth, DrawPortraitModels, AddSeatModel, FindSeatModel
global PickMarkerShape
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LoadRinkLines                                   52E8C  97 PC, low confidence
; From InitGameGraphics: the rink line and board shapes (boardback, crease,
; flatboards, fat red / blue lines, glassline, top / bottom boards)
;-----------------------------------------------------------------------------
LoadRinkLines:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 300h
        call BuildRinkPalette
        mov edx, dword [CrowdCenter]
        push edx
        call UpdateModelInstance
        add esp, byte 4
        mov ebx, dword [FlashSpots]
        push ebx
        call UpdateModelInstance
        add esp, byte 4
        mov ecx, dword [RinkOverlayModel]
        push ecx
        call UpdateModelInstance
        add esp, byte 4
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        xor ebx, ebx
        call UpdateModelInstance
        add esp, byte 4
.1:
        mov edi, dword [dword ebx+ScoreboardSpin]
        push edi
        call UpdateModelInstance
        add esp, byte 4
        mov ebp, dword [dword ebx+ScoreboardFrames]
        push ebp
        add ebx, byte 4
        call UpdateModelInstance
        add esp, byte 4
        cmp ebx, byte 8
        jne short .1
        push str_Boardback
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstanceShape
        mov dword [RinkLinesLoaded], eax
        mov edx, eax
        shl eax, 2
        mov ebx, dword [CrowdCenter]
        add eax, edx
        mov edx, dword [byte ebx+014h]
        add esp, byte 8
        mov eax, dword [byte edx+eax*4+04h]
        mov edx, esp
        mov dword [RinkLineData], eax
        mov eax, dword [ArenaArchive]
        call BuildRangePaletteBuf
        mov edx, esp
        mov eax, dword [ArenaArt]
        call CopyRangePalette
        mov edx, esp
        mov eax, dword [RinkLineArt]
        call CopyRangePalette
        push str_Crease
        mov edx, dword [CrowdCenter]
        push edx
        call FindInstanceShape
        mov ebx, dword [CrowdCenter]
        mov edx, eax
        shl eax, 2
        add esp, byte 8
        add edx, eax
        mov eax, dword [byte ebx+014h]
        shl edx, 2
        push str_Flatboards
        mov eax, dword [byte edx+eax+04h]
        push ebx
        mov dword [RinkPartModels+14Ch], eax
        call FindInstanceShape
        mov edx, eax
        shl eax, 2
        mov ebx, dword [CrowdCenter]
        add eax, edx
        mov edx, dword [byte ebx+014h]
        add esp, byte 8
        mov eax, dword [byte edx+eax*4+04h]
        push dword 0FF000000h
        mov dword [GlassModel], eax
        call MatchColor
        add esp, byte 4
        push str_FatRedLines
        mov ebx, dword [CrowdCenter]
        push ebx
        mov dword [RinkPartModels+130h], eax
        call FindInstanceShape
        mov edx, eax
        shl eax, 2
        mov ebx, dword [CrowdCenter]
        add edx, eax
        add esp, byte 8
        shl edx, 2
        mov eax, dword [byte ebx+014h]
        push byte 0
        add eax, edx
        xor ebx, ebx
        xor edx, edx
        mov bl, byte [eax]
        mov dl, byte [byte eax+01h]
        mov al, byte [byte eax+02h]
        lea ecx, [byte esp+04h]
        and eax, 0FFh
        call BuildAntiAliasTable
        mov dword [FaceoffSpotModel], eax
        push str_FatBlueLines
        mov ecx, dword [CrowdCenter]
        push ecx
        call FindInstanceShape
        mov edx, eax
        shl eax, 2
        mov ebx, dword [CrowdCenter]
        add edx, eax
        add esp, byte 8
        shl edx, 2
        mov eax, dword [byte ebx+014h]
        push byte 0
        add eax, edx
        xor ebx, ebx
        xor edx, edx
        mov bl, byte [eax]
        mov dl, byte [byte eax+01h]
        mov al, byte [byte eax+02h]
        lea ecx, [byte esp+04h]
        and eax, 0FFh
        call BuildAntiAliasTable
        push str_Crease
        mov esi, dword [CrowdCenter]
        push esi
        mov dword [EndSpotModels], eax
        call FindInstanceShape
        add esp, byte 8
        push str_Glassline
        mov edi, dword [CrowdCenter]
        push edi
        call FindInstanceShape
        add esp, byte 8
        push DrawCenterCircle
        push eax
        mov ebp, dword [CrowdCenter]
        push ebp
        mov ebx, eax
        call SetModelPartName
        mov eax, ebx
        mov edx, dword [CrowdCenter]
        shl eax, 2
        add esp, byte 0Ch
        add eax, ebx
        mov edx, dword [byte edx+014h]
        shl eax, 2
        push byte 0
        add eax, edx
        xor ebx, ebx
        xor edx, edx
        mov bl, byte [eax]
        mov dl, byte [byte eax+01h]
        mov al, byte [byte eax+02h]
        lea ecx, [byte esp+04h]
        and eax, 0FFh
        call BuildAntiAliasTable
        push byte 0
        lea ecx, [byte esp+04h]
        mov ebx, 0F0h
        mov dword [BenchModelParts], eax
        mov edx, ebx
        mov eax, ebx
        call BuildAntiAliasTable
        push str_Topboards
        mov dword [GlassParts], eax
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstanceShape
        add esp, byte 8
        mov edx, eax
        shl eax, 2
        add edx, eax
        mov ebx, dword [CrowdCenter]
        shl edx, 2
        mov eax, dword [byte ebx+014h]
        push byte 0
        add eax, edx
        xor ebx, ebx
        xor edx, edx
        mov bl, byte [eax]
        mov dl, byte [byte eax+01h]
        mov al, byte [byte eax+02h]
        lea ecx, [byte esp+04h]
        and eax, 0FFh
        call BuildAntiAliasTable
        push str_Botboards
        mov edx, dword [CrowdCenter]
        push edx
        mov dword [HomeBlueLineModel], eax
        call FindInstanceShape
        mov edx, eax
        shl eax, 2
        mov ebx, dword [CrowdCenter]
        add eax, edx
        add esp, byte 8
        shl eax, 2
        mov edx, dword [byte ebx+014h]
        push byte 0
        add eax, edx
        xor ebx, ebx
        xor edx, edx
        mov bl, byte [eax]
        mov dl, byte [byte eax+01h]
        mov al, byte [byte eax+02h]
        lea ecx, [byte esp+04h]
        and eax, 0FFh
        call BuildAntiAliasTable
        mov ebx, 0E8h
        mov edx, dword [BoardAdModel]
        mov dword [AwayBlueLineModel], eax
        mov eax, dword [ArenaArt]
        mov dword [RinkLineModel], ebx
        xor ebx, ebx
        call RemapRangeColors
        mov ecx, dword [ArenaModel]
        test ecx, ecx
        je short .2
        mov eax, dword [ArenaArt]
        mov edx, ecx
        xor ebx, ebx
        call RemapRangeColors
.2:
        xor ebp, ebp
        jmp near .9
.3:
        push ebp
        mov edi, dword [BoardAdModel]
        push edi
        call ArtBankEntry
        add esp, byte 8
        push byte 8
        mov ebx, eax
        mov esi, eax
        call BytesPerPixelForDepth
        mov edx, dword [ebx]
        and edx, 0FFh
        add esp, byte 4
        cmp edx, eax
        jne short .8
        mov cl, 1
        lea edx, [byte ebx+010h]
        xor edi, edi
        jmp short .7
.4:
        xor eax, eax
        jmp short .6
.5:
        xor ebx, ebx
        mov bl, byte [edx]
        inc edx
        inc eax
        mov byte [dword ebx+RinkColorUsed], cl
.6:
        mov ebx, dword [byte esi+04h]
        sar ebx, 10h
        cmp eax, ebx
        jl short .5
        inc edi
.7:
        mov eax, dword [byte esi+02h]
        sar eax, 10h
        cmp edi, eax
        jl short .4
.8:
        mov eax, dword [FaceoffSpotModel]
        mov al, byte [eax]
        and eax, 0FFh
        mov dl, 1
        mov byte [dword eax+RinkColorUsed], dl
        mov eax, dword [EndSpotModels]
        mov al, byte [eax]
        and eax, 0FFh
        mov byte [dword eax+RinkColorUsed], dl
        mov eax, dword [RinkPartModels+14Ch]
        inc ebp
        mov byte [dword eax+RinkColorUsed], dl
.9:
        mov esi, dword [BoardAdModel]
        push esi
        call ArtBankCount
        add esp, byte 4
        cmp ebp, eax
        jl near .3
        add esp, 300h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetupRinkModel                                  53260  97 PC, low confidence
; Sets up the rink model and crowd
;-----------------------------------------------------------------------------
SetupRinkModel:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov eax, dword [BenchModel]
        test eax, eax
        je short .1
        xor eax, eax
        call SetBoxDoor
        jmp short .2
.1:
        call SetBoxDoorState
.2:
        mov eax, dword [BenchDetail]
        test eax, eax
        je short .3
        mov eax, 1
        call SetBoxDoor
        jmp short .4
.3:
        mov eax, 1
        call SetBoxDoorState
.4:
        mov edx, 0FFFFFFFFh
        xor eax, eax
.5:
        add eax, 88h
        mov dword [dword eax+RinkSideGeometry+3ACh], edx
        cmp eax, 990h
        jne short .5
        mov ebx, dword [CrowdReactOn]
        test ebx, ebx
        je short .6
        mov eax, CrowdReactPos
        mov ebx, dword [CrowdReactStart]
        mov edx, dword [CrowdReactLevel]
        call StartCrowdReaction
        jmp short .8
.6:
        je short .7
        mov esi, dword [CrowdModel]
        push esi
        call FreeMemBlock
        add esp, byte 4
        mov dword [CrowdModel], ebx
.7:
        xor ebp, ebp
        mov eax, 0FFFFFFFFh
        mov dword [CrowdReactOn], ebp
        mov dword [CrowdReactCount], eax
        call ClearCrowdReaction
.8:
        mov dword [CameraModeOn], 1
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadRinkModel                                   53314  97 PC, low confidence
; From InitGameGraphics: the rink model from arena.viv (rink, stands, floor,
; score, puck, nets, goals, extents, lights, glass, boards)
;-----------------------------------------------------------------------------
LoadRinkModel:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 64h
        mov dword [byte esp+05Ch], eax
        mov eax, str_ArenaViv2
        call SetArtArchive
        mov dword [LogosLoaded], edx
        call BuildReciprocalTable
        mov edx, 4CCCCh
        mov eax, 4
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, 4CCCCh
        mov dword [NeutralSpotModel], eax
        mov eax, 0Ah
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, 4CCCCh
        mov dword [CenterSpotModel], eax
        mov eax, 4
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, 4CCCCh
        mov dword [BenchLineModel], eax
        mov eax, 6
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, 4CCCCh
        mov dword [BoardsTopModel], eax
        mov eax, 2
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, 4CCCCh
        mov dword [CenterCircleModel], eax
        mov eax, 0Ah
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, 4CCCCh
        mov dword [CreasePolyModel], eax
        mov eax, 96h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, 4CCCCh
        mov dword [RinkGeometryModel], eax
        mov eax, 3Ch
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, 4CCCCh
        mov dword [RinkGeometryData], eax
        mov eax, 64h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edx, 4CCCCh
        mov dword [RinkGeometryParts], eax
        mov eax, 0FFFFFF7Eh
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov dword [RinkMarkingModel], eax
        mov edx, 4CCCCh
        mov eax, 3
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov dword [CreaseModel], eax
        call ServiceIdle
        xor edx, edx
        mov eax, str_Rink
        call LoadModelByName
        push byte 0
        mov dword [RinkSidesData], eax
        add eax, byte 2Ch
        push eax
        call OpenArtArchiveErr
        mov ecx, 1
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        mov dword [RinkModelPieces], eax
        mov ebx, eax
        mov eax, str_Rink
        call RemapArtBank
        mov ebx, 4
        mov eax, dword [RinkSidesData]
        xor edx, edx
        call CreateModelInstance
        mov edx, dword [RinkModelPieces]
        push edx
        push eax
        mov dword [CrowdCenter], eax
        call BindModelShapes
        mov eax, dword [CrowdCenter]
        mov dl, byte [byte eax+010h]
        or dl, 2
        add esp, byte 8
        mov byte [byte eax+010h], dl
        call ServiceIdle
        mov eax, str_Stands2
        xor edx, edx
        mov ebx, 4
        call LoadModelByName
        xor edx, edx
        mov dword [RinkSidesModel], eax
        call CreateModelInstance
        mov dword [FlashSpots], eax
        or byte [byte eax+010h], 2
        push str_Floor
        mov ebx, dword [FlashSpots]
        push ebx
        call FindInstanceShape
        add esp, byte 8
        push DrawCreaseArc
        push eax
        mov ecx, dword [FlashSpots]
        push ecx
        call SetModelPartName
        add esp, byte 0Ch
        call ServiceIdle
        xor edx, edx
        mov eax, str_Score
        call LoadModelByName
        push byte 0
        mov dword [RinkExtraModel], eax
        add eax, byte 2Ch
        push eax
        call OpenArtArchiveErr
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        mov dword [PauseArtModel], eax
        mov ebx, eax
        xor ecx, ecx
        mov eax, str_Score
        call RemapArtBank
        mov ebx, 4
        mov eax, dword [RinkExtraModel]
        xor edx, edx
        call CreateModelInstance
        mov esi, dword [PauseArtModel]
        push esi
        push eax
        mov dword [RinkOverlayModel], eax
        call BindModelShapes
        mov eax, dword [RinkOverlayModel]
        mov bl, byte [byte eax+010h]
        or bl, 2
        add esp, byte 8
        mov byte [byte eax+010h], bl
        call ServiceIdle
        push byte 0
        push str_Puck2
        xor edi, edi
        xor esi, esi
        call OpenArtArchiveErr
        add esp, byte 8
        mov dword [RinkModelData], eax
.1:
        push esi
        push str_04d
        lea eax, [byte esp+030h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+028h]
        push eax
        mov ebp, dword [RinkModelData]
        push ebp
        add edi, byte 4
        inc esi
        call FindShape
        add esp, byte 8
        mov dword [dword edi+RinkModel], eax
        cmp esi, byte 12h
        jl short .1
        call ServiceIdle
        mov eax, str_Lonet
        xor edx, edx
        call LoadModelByName
        mov dword [RinkPartModels+1A4h], eax
        xor edx, edx
        mov eax, str_Hinet
        call LoadModelByName
        push byte 0
        mov dword [RinkPartModels+140h], eax
        add eax, byte 2Ch
        push eax
        mov edi, 8
        call OpenArtArchiveErr
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        mov dword [RinkPartModels+12Ch], eax
        mov ebx, eax
        xor ecx, ecx
        mov eax, str_Net
        xor esi, esi
        call RemapArtBank
        xor ebp, ebp
.2:
        mov eax, dword [RinkPartModels+1A4h]
        mov ebx, edi
        mov edx, ebp
        call CreateModelInstance
        mov dword [dword esi+ScoreboardSpin], eax
        mov eax, dword [RinkPartModels+12Ch]
        push eax
        mov edx, dword [dword esi+ScoreboardSpin]
        push edx
        mov ebx, edi
        call BindModelShapes
        add esp, byte 8
        mov eax, dword [RinkPartModels+140h]
        mov edx, ebp
        call CreateModelInstance
        mov ebx, dword [RinkPartModels+12Ch]
        push ebx
        push eax
        mov dword [dword esi+ScoreboardFrames], eax
        call BindModelShapes
        mov eax, dword [dword esi+ScoreboardFrames]
        mov bh, byte [byte eax+010h]
        add esi, byte 4
        or bh, 2
        add esp, byte 8
        mov byte [byte eax+010h], bh
        cmp esi, byte 8
        jne short .2
        push str_Goal0
        mov esi, dword [CrowdCenter]
        push esi
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        sub eax, edx
        mov edx, dword [CrowdCenter]
        shl eax, 2
        mov edx, dword [byte edx+074h]
        add esp, byte 8
        add edx, eax
        xor eax, eax
        call UpdateScoreboardPos
        xor eax, eax
        push byte 0
        call UpdateScoreboardSpin
        push str_Goal1
        mov edi, dword [CrowdCenter]
        push edi
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        sub eax, edx
        lea edx, [nosplit eax*4+00h]
        mov eax, dword [CrowdCenter]
        mov eax, dword [byte eax+074h]
        add esp, byte 8
        add edx, eax
        mov eax, 1
        call UpdateScoreboardPos
        mov eax, 1
        push dword 40490FDBh
        call UpdateScoreboardSpin
        xor eax, eax
        call LoadNetArt
        mov eax, 1
        call LoadNetArt
        push str_Minx
        mov eax, dword [CrowdCenter]
        push eax
        mov edx, dword [byte eax+07Ch]
        mov esi, dword [byte eax+074h]
        mov dword [byte esp+068h], edx
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        add esp, byte 8
        sub eax, edx
        push str_Maxx
        mov ebp, dword [CrowdCenter]
        mov eax, dword [esi+eax*4]
        push ebp
        mov dword [RinkPartModels+0FCh], eax
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        sub eax, edx
        add esp, byte 8
        mov eax, dword [esi+eax*4]
        push str_Minz
        mov dword [RinkPartModels+0F4h], eax
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        sub eax, edx
        mov eax, dword [byte esi+eax*4+08h]
        add esp, byte 8
        mov dword [RinkPartModels+100h], eax
        push str_Maxz
        mov edx, dword [CrowdCenter]
        push edx
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        add esp, byte 8
        sub eax, edx
        push str_Rlite1
        mov ebx, dword [CrowdCenter]
        mov eax, dword [byte esi+eax*4+08h]
        push ebx
        mov dword [RinkPartModels+090h], eax
        call FindInstancePart
        add esp, byte 8
        mov edx, eax
        push str_Gt304
        shl eax, 2
        mov ecx, dword [CrowdCenter]
        sub eax, edx
        push ecx
        mov edi, dword [byte esi+eax*4+04h]
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        sub eax, edx
        add esp, byte 8
        mov eax, dword [esi+eax*4]
        mov dword [GoalLightModelFar], edi
        mov dword [GoalLightModelNear], edi
        sub edi, byte 3Ch
        push str_Strobe
        mov dword [GoalLightSpinFar], edi
        mov dword [GoalLightSpinNear], edi
        mov edi, dword [CrowdCenter]
        push edi
        mov dword [GoalLightModel], eax
        call FindInstanceShape
        mov edx, dword [CrowdCenter]
        mov ebx, eax
        shl eax, 2
        add esp, byte 8
        add eax, ebx
        mov ebx, dword [byte edx+014h]
        push str_Glass
        mov eax, dword [byte ebx+eax*4+0Ch]
        push edx
        mov dword [GoalLightArt], eax
        call FindInstanceShape
        add esp, byte 8
        push DrawCenterCircle_30
        push eax
        mov ebp, dword [CrowdCenter]
        push ebp
        call SetModelPartName
        add esp, byte 0Ch
        push str_Boardback
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstanceShape
        mov ebx, dword [CrowdCenter]
        mov dword [RinkLinesLoaded], eax
        mov edx, eax
        shl eax, 2
        add esp, byte 8
        add eax, edx
        mov edx, dword [byte ebx+014h]
        push str_Flatboards
        mov eax, dword [byte edx+eax*4+04h]
        push ebx
        mov dword [RinkLineData], eax
        call FindInstanceShape
        mov edx, eax
        shl eax, 2
        add edx, eax
        mov ebx, dword [CrowdCenter]
        shl edx, 2
        mov eax, dword [byte ebx+014h]
        mov eax, dword [byte edx+eax+04h]
        add esp, byte 8
        mov dword [GlassModel], eax
        push str_STAND
        mov edx, dword [FlashSpots]
        push edx
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+11Ch
        push RinkPartModels+110h
        push eax
        mov ebx, dword [FlashSpots]
        push ebx
        call GetInstanceGroupEntry
        add esp, byte 10h
        push str_FLOOR
        mov ecx, dword [FlashSpots]
        push ecx
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+0C8h
        push RinkPartModels+114h
        push eax
        mov edi, dword [FlashSpots]
        push edi
        call GetInstanceGroupEntry
        add esp, byte 10h
        push str_STAND2ND
        mov ebp, dword [FlashSpots]
        push ebp
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+0F8h
        push RinkPartModels+0ECh
        push eax
        mov eax, dword [FlashSpots]
        push eax
        call GetInstanceGroupEntry
        add esp, byte 10h
        push str_WALL
        mov edx, dword [FlashSpots]
        push edx
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+0E0h
        push RinkPartModels+0E4h
        push eax
        mov ebx, dword [FlashSpots]
        push ebx
        call GetInstanceGroupEntry
        add esp, byte 10h
        push str_Rlite0
        mov ecx, dword [CrowdCenter]
        push ecx
        call FindInstancePart
        add esp, byte 8
        push str_Rlite1
        mov edi, dword [CrowdCenter]
        push edi
        mov dword [FarSideParts], eax
        call FindInstancePart
        add esp, byte 8
        push str_Redlite
        mov ebp, dword [CrowdCenter]
        push ebp
        mov dword [NearSideParts], eax
        call FindInstanceShape
        lea ebx, [nosplit eax*4+00h]
        add ebx, eax
        mov eax, dword [CrowdCenter]
        shl ebx, 2
        mov edx, dword [byte eax+014h]
        mov edx, dword [byte edx+ebx+0Ch]
        add esp, byte 8
        mov dword [NearSideModel], edx
        push str_Glite0
        push eax
        call FindInstancePart
        add esp, byte 8
        push str_Glite1
        mov dword [SideParts], eax
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstancePart
        add esp, byte 8
        push str_Grnlite
        mov edx, dword [CrowdCenter]
        push edx
        mov dword [FarSideModel], eax
        call FindInstanceShape
        mov edx, eax
        shl eax, 2
        add edx, eax
        mov eax, dword [CrowdCenter]
        add esp, byte 8
        mov ebx, dword [byte eax+014h]
        shl edx, 2
        push str_Lites
        mov edx, dword [byte edx+ebx+0Ch]
        push eax
        mov dword [FarSideData], edx
        call FindInstanceGroup
        add esp, byte 8
        push str_Penboxz0
        mov ebx, dword [CrowdCenter]
        push ebx
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+64h
        push RinkPartModels+0A8h
        push eax
        mov ecx, dword [CrowdCenter]
        push ecx
        call GetInstanceGroupEntry
        add esp, byte 10h
        push str_Penboxz1
        mov edi, dword [CrowdCenter]
        push edi
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+60h
        push RinkPartModels+0ACh
        push eax
        mov ebp, dword [CrowdCenter]
        push ebp
        call GetInstanceGroupEntry
        add esp, byte 10h
        push str_Penboxt0
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+70h
        push RinkPartModels+0B8h
        push eax
        mov edx, dword [CrowdCenter]
        push edx
        call GetInstanceGroupEntry
        add esp, byte 10h
        push str_Penboxt1
        mov ebx, dword [CrowdCenter]
        push ebx
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+40h
        push RinkPartModels+0BCh
        push eax
        mov ecx, dword [CrowdCenter]
        push ecx
        call GetInstanceGroupEntry
        add esp, byte 10h
        push str_Penback
        mov edi, dword [CrowdCenter]
        push edi
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+58h
        push RinkPartModels+68h
        push eax
        mov ebp, dword [CrowdCenter]
        push ebp
        call GetInstanceGroupEntry
        add esp, byte 10h
        push str_Penboxt0
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        add esp, byte 8
        sub eax, edx
        push str_Penboxz0
        mov edx, dword [CrowdCenter]
        mov eax, dword [esi+eax*4]
        push edx
        mov dword [RinkPartModels+0C0h], eax
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        add esp, byte 8
        sub eax, edx
        push str_Penboxz1
        mov ebx, dword [CrowdCenter]
        mov eax, dword [byte esi+eax*4+08h]
        push ebx
        mov dword [RinkPartModels+7Ch], eax
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        add esp, byte 8
        sub eax, edx
        push str_Penboxt0
        mov ecx, dword [CrowdCenter]
        mov eax, dword [byte esi+eax*4+08h]
        push ecx
        mov dword [RinkPartModels+78h], eax
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        add esp, byte 8
        sub eax, edx
        push str_Penboxt1
        mov edi, dword [CrowdCenter]
        mov eax, dword [byte esi+eax*4+08h]
        push edi
        mov dword [RinkPartModels+098h], eax
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        sub eax, edx
        xor ebp, ebp
        mov eax, dword [byte esi+eax*4+08h]
        add esp, byte 8
        mov dword [RinkPartModels+094h], eax
        mov dword [RinkPartModels+5Ch], ebp
.3:
        mov eax, dword [RinkPartModels+5Ch]
        push eax
        push str_Penbox0D
        lea eax, [byte esp+03Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+034h]
        push eax
        mov edx, dword [CrowdCenter]
        push edx
        call FindInstancePart
        add esp, byte 8
        test eax, eax
        jl short .4
        mov edx, dword [RinkPartModels+5Ch]
        push edx
        push str_Penbox1D
        mov dword [nosplit edx*4+SeatPositions], eax
        lea eax, [byte esp+03Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+034h]
        push eax
        mov ecx, dword [CrowdCenter]
        push ecx
        call FindInstancePart
        add esp, byte 8
        test eax, eax
        jl short .4
        mov edx, dword [RinkPartModels+5Ch]
        lea edi, [byte edx+01h]
        mov dword [nosplit edx*4+BoxModels], eax
        mov dword [RinkPartModels+5Ch], edi
        cmp edi, byte 3
        jl near .3
.4:
        push str_DoorZ0
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstancePart
        add esp, byte 8
        push str_DoorZ1
        mov edx, dword [CrowdCenter]
        push edx
        mov dword [BenchSideModel], eax
        call FindInstancePart
        add esp, byte 8
        push str_Door00
        mov ebx, dword [CrowdCenter]
        push ebx
        mov dword [BoxModelData], eax
        call FindInstancePart
        add esp, byte 8
        push str_Door01
        mov ecx, dword [CrowdCenter]
        push ecx
        mov dword [RinkPartModels], eax
        call FindInstancePart
        add esp, byte 8
        push str_Door02
        mov edi, dword [CrowdCenter]
        push edi
        mov dword [RinkPartModels+4], eax
        call FindInstancePart
        add esp, byte 8
        push str_Door10
        mov ebp, dword [CrowdCenter]
        push ebp
        mov dword [RinkPartModels+8], eax
        call FindInstancePart
        add esp, byte 8
        push str_Door11
        mov dword [RinkPartModels+10h], eax
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstancePart
        add esp, byte 8
        push str_Door12
        mov edx, dword [CrowdCenter]
        push edx
        mov dword [RinkPartModels+14h], eax
        call FindInstancePart
        add esp, byte 8
        push str_Benchz0
        mov ebx, dword [CrowdCenter]
        push ebx
        mov dword [RinkPartModels+18h], eax
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+0B0h
        push RinkPartModels+0A0h
        push eax
        mov ecx, dword [CrowdCenter]
        push ecx
        call GetInstanceGroupEntry
        add esp, byte 10h
        push str_Benchz1
        mov edi, dword [CrowdCenter]
        push edi
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+0B4h
        push RinkPartModels+0A4h
        push eax
        mov ebp, dword [CrowdCenter]
        push ebp
        call GetInstanceGroupEntry
        add esp, byte 10h
        push str_Benchdiv
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+6Ch
        push RinkPartModels+09Ch
        push eax
        mov edx, dword [CrowdCenter]
        push edx
        call GetInstanceGroupEntry
        add esp, byte 10h
        push str_Benchbk
        mov ebx, dword [CrowdCenter]
        push ebx
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+80h
        push RinkPartModels+74h
        push eax
        mov ecx, dword [CrowdCenter]
        push ecx
        call GetInstanceGroupEntry
        add esp, byte 10h
        push str_Benchx
        mov edi, dword [CrowdCenter]
        push edi
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        add esp, byte 8
        sub eax, edx
        push str_Benchz0
        mov ebp, dword [CrowdCenter]
        mov eax, dword [esi+eax*4]
        push ebp
        mov dword [RinkPartModels+84h], eax
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        sub eax, edx
        add esp, byte 8
        mov eax, dword [byte esi+eax*4+08h]
        push str_Benchz1
        mov dword [RinkPartModels+8Ch], eax
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        add esp, byte 8
        sub eax, edx
        push str_Boxback
        mov edx, dword [CrowdCenter]
        mov eax, dword [byte esi+eax*4+08h]
        push edx
        mov dword [RinkPartModels+88h], eax
        call FindInstanceShape
        add esp, byte 8
        push DrawCreaseArc
        push eax
        mov ebx, dword [CrowdCenter]
        push ebx
        call SetModelPartName
        xor ecx, ecx
        add esp, byte 0Ch
        mov dword [RinkPartModels+44h], ecx
.5:
        mov edi, dword [RinkPartModels+44h]
        push edi
        push str_Pbench0D
        lea eax, [byte esp+048h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+040h]
        push eax
        mov ebp, dword [CrowdCenter]
        push ebp
        call FindInstancePart
        add esp, byte 8
        test eax, eax
        jl short .6
        mov edx, dword [RinkPartModels+44h]
        push edx
        push str_Pbench1D
        mov dword [nosplit edx*4+HomeBenchModels], eax
        lea eax, [byte esp+048h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+040h]
        push eax
        mov edx, dword [CrowdCenter]
        push edx
        call FindInstancePart
        add esp, byte 8
        test eax, eax
        jl short .6
        mov edx, dword [RinkPartModels+44h]
        lea ebx, [byte edx+01h]
        mov dword [nosplit edx*4+AwayBenchModels], eax
        mov dword [RinkPartModels+44h], ebx
        cmp ebx, byte 7
        jl near .5
.6:
        push str_B00
        mov edi, dword [CrowdCenter]
        push edi
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        sub eax, edx
        add esp, byte 8
        mov ebp, dword [CrowdCenter]
        mov eax, dword [byte esi+eax*4+04h]
        push str_Gt007
        sar eax, 2
        push ebp
        mov dword [BenchCheerFrames], eax
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        sub eax, edx
        mov eax, dword [byte esi+eax*4+08h]
        add esp, byte 8
        sar eax, 2
        push str_Gt004
        mov dword [BenchCheerModel], eax
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        add esp, byte 8
        sub eax, edx
        push str_Gt302
        mov eax, dword [byte esi+eax*4+08h]
        mov edx, dword [CrowdCenter]
        sar eax, 2
        push edx
        mov dword [BenchCheerData], eax
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        sub eax, edx
        add esp, byte 8
        mov ebx, dword [CrowdCenter]
        mov eax, dword [byte esi+eax*4+04h]
        push str_Gt004
        sar eax, 2
        push ebx
        mov dword [BenchCheerArt], eax
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        sub eax, edx
        mov eax, dword [byte esi+eax*4+04h]
        sar eax, 2
        add esp, byte 8
        mov dword [BenchCheerParts], eax
        mov eax, dword [byte esp+05Ch]
        call LoadArenaArt
        push str_Crease
        mov ecx, dword [CrowdCenter]
        push ecx
        call FindInstanceShape
        mov edx, eax
        shl eax, 2
        mov ebx, dword [CrowdCenter]
        add eax, edx
        mov edx, dword [byte ebx+014h]
        xor esi, esi
        mov eax, dword [byte edx+eax*4+04h]
        add esp, byte 8
        mov dword [RinkPartModels+14Ch], eax
        mov dword [RinkModelBuffer], esi
.7:
        mov edi, dword [RinkModelBuffer]
        push edi
        push str_R02d
        lea eax, [byte esp+054h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+04Ch]
        push eax
        mov ebp, dword [CrowdCenter]
        push ebp
        call FindInstancePart
        add esp, byte 8
        test eax, eax
        jl short .8
        mov edx, dword [RinkModelBuffer]
        mov dword [nosplit edx*4+RinkModelParts], eax
        lea eax, [byte edx+01h]
        mov dword [RinkModelBuffer], eax
        cmp eax, byte 10h
        jl short .7
.8:
        xor ebx, ebx
        mov dword [RinkPassCount], ebx
.9:
        mov ecx, dword [RinkPassCount]
        push ecx
        push str_XD
        lea eax, [byte esp+05Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+054h]
        push eax
        mov esi, dword [FlashSpots]
        push esi
        call FindInstancePart
        add esp, byte 8
        test eax, eax
        jl short .10
        mov edx, dword [RinkPassCount]
        lea edi, [byte edx+01h]
        mov dword [nosplit edx*4+RinkPartModels+150h], eax
        mov dword [RinkPassCount], edi
        cmp edi, byte 15h
        jle short .9
.10:
        push str_C3
        mov eax, dword [RinkPartModels+1ACh]
        push eax
        call FindInstancePart
        add esp, byte 8
        push str_C2
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        mov dword [RinkModelTexInfo], eax
        call FindInstancePart
        add esp, byte 8
        push str_C1
        mov ebx, dword [RinkPartModels+1ACh]
        push ebx
        mov dword [RinkModelBounds], eax
        call FindInstancePart
        add esp, byte 8
        push str_C0
        mov ecx, dword [RinkPartModels+1ACh]
        push ecx
        mov dword [RinkModelSize], eax
        call FindInstancePart
        add esp, byte 8
        push str_L3
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        mov dword [RinkModelFlags], eax
        call FindInstancePart
        add esp, byte 8
        push str_L2
        mov edi, dword [RinkPartModels+1ACh]
        push edi
        mov dword [RinkModelHeader], eax
        call FindInstancePart
        add esp, byte 8
        push str_L1
        mov ebp, dword [RinkPartModels+1ACh]
        push ebp
        mov dword [RinkModelVerts], eax
        call FindInstancePart
        add esp, byte 8
        push str_L0
        mov dword [RinkModelPolys], eax
        mov eax, dword [RinkPartModels+1ACh]
        push eax
        call FindInstancePart
        add esp, byte 8
        mov dword [RinkModelNormals], eax
        call BuildRinkGeometry
        push str_Goal0
        mov edx, dword [CrowdCenter]
        push edx
        call FindInstancePart
        mov edx, eax
        shl eax, 2
        sub eax, edx
        lea edx, [nosplit eax*4+00h]
        mov eax, dword [CrowdCenter]
        mov eax, dword [byte eax+074h]
        add esp, byte 8
        add edx, eax
        xor eax, eax
        call UpdateScoreboardPos
        push str_Center
        mov ebx, dword [CrowdCenter]
        push ebx
        call FindInstancePart
        add esp, byte 8
        mov edx, eax
        shl eax, 2
        sub eax, edx
        mov edx, dword [byte esp+060h]
        shl eax, 2
        mov ebx, RinkCameraPoints
        add edx, eax
        mov esi, RinkCameraPoints
        mov dword [RinkModelState], edx
        mov edx, dword [CrowdCenter]
        mov edi, 4
        xor ebp, ebp
        mov edx, dword [byte edx+074h]
        add ebx, eax
        add edx, eax
        mov eax, 3
        add esi, byte 0Ch
        call IntsToFloats
.11:
        push ebp
        push str_FaceoffD
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        mov ecx, dword [CrowdCenter]
        push ecx
        call FindInstancePart
        imul eax, byte 0Ch
        add esp, byte 8
        mov edx, dword [byte esp+060h]
        add edx, eax
        mov dword [dword edi+RinkModelState], edx
        mov edx, dword [CrowdCenter]
        mov ebx, esi
        add edi, byte 4
        mov edx, dword [byte edx+074h]
        add esi, byte 0Ch
        add edx, eax
        mov eax, 3
        inc ebp
        call IntsToFloats
        cmp edi, byte 14h
        jne short .11
        mov ebp, 4
        mov edi, RinkViewPoints
        xor esi, esi
.12:
        push ebp
        push str_FaceoffD
        lea eax, [byte esp+01Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+014h]
        push eax
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstancePart
        imul edx, eax, byte 0Ch
        add esp, byte 8
        mov eax, dword [byte esp+060h]
        add eax, edx
        mov dword [dword esi+RinkMarkingGeometry+6E0h], eax
        mov eax, dword [CrowdCenter]
        mov ebx, edi
        add esi, byte 4
        mov eax, dword [byte eax+074h]
        add edi, byte 0Ch
        add edx, eax
        mov eax, 3
        inc ebp
        call IntsToFloats
        cmp esi, byte 10h
        jne short .12
        push str_Goal0
        mov edx, dword [CrowdCenter]
        push edx
        call FindInstancePart
        add esp, byte 8
        mov edx, eax
        shl eax, 2
        push str_Goal1
        sub eax, edx
        mov edx, dword [byte esp+064h]
        shl eax, 2
        mov ebx, dword [CrowdCenter]
        add edx, eax
        push ebx
        mov dword [RinkLength], edx
        call FindInstancePart
        add esp, byte 8
        mov edx, eax
        shl eax, 2
        push str_Maxx
        sub eax, edx
        mov edx, dword [byte esp+064h]
        shl eax, 2
        mov ecx, dword [CrowdCenter]
        add edx, eax
        push ecx
        mov dword [RinkWidth], edx
        call FindInstancePart
        add esp, byte 8
        mov edx, eax
        shl eax, 2
        push str_IceLine
        sub eax, edx
        mov edx, dword [byte esp+064h]
        shl eax, 2
        mov esi, dword [CrowdCenter]
        add edx, eax
        push esi
        mov dword [RinkCorner], edx
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+0CCh
        push RinkPartModels+0D8h
        push eax
        mov edi, dword [CrowdCenter]
        push edi
        call GetInstanceGroupEntry
        add esp, byte 10h
        push str_FatRedLines
        mov ebp, dword [CrowdCenter]
        push ebp
        call FindInstanceShape
        add esp, byte 8
        push DrawCenterSpots
        push eax
        mov eax, dword [CrowdCenter]
        push eax
        call SetModelPartName
        add esp, byte 0Ch
        push str_FatBlueLines
        mov edx, dword [CrowdCenter]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push DrawEndSpots
        push eax
        mov ebx, dword [CrowdCenter]
        push ebx
        call SetModelPartName
        add esp, byte 0Ch
        push str_Glassline
        mov ecx, dword [CrowdCenter]
        push ecx
        call FindInstanceShape
        add esp, byte 8
        push DrawCenterCircle
        push eax
        mov esi, dword [CrowdCenter]
        push esi
        call SetModelPartName
        add esp, byte 0Ch
        push str_Topboards
        mov edi, dword [CrowdCenter]
        push edi
        call FindInstanceShape
        add esp, byte 8
        push DrawHomeBlueLine
        push eax
        mov ebp, dword [CrowdCenter]
        push ebp
        call SetModelPartName
        add esp, byte 0Ch
        push str_Botboards
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstanceShape
        add esp, byte 8
        push DrawAwayBlueLine
        push eax
        mov edx, dword [CrowdCenter]
        push edx
        call SetModelPartName
        add esp, byte 0Ch
        push str_ThinRedLines
        mov ebx, dword [CrowdCenter]
        push ebx
        call FindInstanceShape
        add esp, byte 8
        push DrawNeutralSpots
        push eax
        mov ecx, dword [CrowdCenter]
        push ecx
        call SetModelPartName
        add esp, byte 0Ch
        xor esi, esi
        mov edi, 1
        call BuildRinkSides
        call ServiceIdle
        mov dword [StandsDetail], esi
.13:
        add esi, byte 14h
        mov dword [dword esi+StandsDetailLevel], edi
        cmp esi, 190h
        jne short .13
        push byte 0
        push str_Flash
        call OpenArtArchiveErr
        add esp, byte 8
        push str_Fla0
        push eax
        mov dword [RinkPartModels+3Ch], eax
        call FindShape
        add esp, byte 8
        push str_Fla1
        mov ebp, dword [RinkPartModels+3Ch]
        push ebp
        mov dword [FlashModel], eax
        call FindShape
        mov ebx, dword [RinkPartModels+3Ch]
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        mov dword [BenchModelData], eax
        xor ecx, ecx
        mov eax, str_Fx
        call RemapArtBank
        call ServiceIdle
        call LoadRinkTextures
        mov ecx, 0FFFFFFFFh
        push str_PAL
        xor eax, eax
        mov edi, dword [RinkModelPieces]
        mov dword [GoalCheerTeam], eax
        mov dword [GoalLightState], eax
        mov dword [BenchCheerOn], eax
        push edi
        mov dword [CrowdReactCount], ecx
        mov dword [CrowdReactOn], eax
        call FindShape
        add esp, byte 8
        lea edx, [byte eax+010h]
        mov eax, dword [byte esp+05Ch]
        mov ebx, 60h
        call LoadLogos
        mov eax, GoalCheerTeam
        mov edx, ebx
        call ReplayRegisterStates
        mov eax, SetupRinkModel
        xor esi, esi
        call ReplayRegisterObjects
        push esi
        call OpenResourceArchive
        add esp, byte 4
        add esp, byte 64h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FreeRinkModel                                5454C  96 PC, medium confidence
; From FreeGameView: frees the rink models and art LoadRinkModel loaded
;-----------------------------------------------------------------------------
FreeRinkModel:
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
        xor esi, esi
        mov edi, 0FFFFFFFFh
        mov dword [CrowdReactOn], esi
        mov dword [CrowdReactCount], edi
        call ClearCrowdReaction
        mov ebp, dword [RinkSidesData]
        push ebp
        call FreeMemBlock
        add esp, byte 4
        mov eax, dword [CrowdCenter]
        push eax
        call FreeMemBlock
        add esp, byte 4
        mov edx, dword [RinkModelPieces]
        push edx
        call FreeMemBlock
        add esp, byte 4
        mov ebx, dword [RinkPartModels+144h]
        push ebx
        call FreeMemBlock
        add esp, byte 4
        mov ecx, dword [RinkSidesModel]
        push ecx
        call FreeMemBlock
        add esp, byte 4
        mov esi, dword [FlashSpots]
        push esi
        call FreeMemBlock
        add esp, byte 4
        mov edi, dword [ArenaArchiveHandle]
        push edi
        call FreeMemBlock
        add esp, byte 4
        mov ebp, dword [RinkExtraModel]
        push ebp
        call FreeMemBlock
        add esp, byte 4
        mov eax, dword [RinkOverlayModel]
        push eax
        call FreeMemBlock
        add esp, byte 4
        mov edx, dword [PauseArtModel]
        push edx
        call FreeMemBlock
        add esp, byte 4
        mov ebx, dword [RinkModelData]
        push ebx
        call FreeMemBlock
        add esp, byte 4
        xor ebx, ebx
.2:
        mov ecx, dword [dword ebx+ScoreboardFrames]
        push ecx
        call FreeModelInstance
        add esp, byte 4
        mov esi, dword [dword ebx+ScoreboardSpin]
        push esi
        add ebx, byte 4
        call FreeModelInstance
        add esp, byte 4
        cmp ebx, byte 8
        jne short .2
        mov edi, dword [RinkPartModels+140h]
        push edi
        call FreeModelFile
        add esp, byte 4
        mov ebp, dword [RinkPartModels+1A4h]
        push ebp
        call FreeModelFile
        add esp, byte 4
        mov eax, dword [RinkPartModels+12Ch]
        push eax
        call FreeMemBlock
        add esp, byte 4
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call FreeModelInstance
        add esp, byte 4
        mov ebx, dword [RinkPartModels+148h]
        push ebx
        call FreeModelFile
        add esp, byte 4
        mov ecx, dword [BoardAdModel]
        push ecx
        call FreeMemBlock
        mov esi, dword [ArenaModel]
        add esp, byte 4
        test esi, esi
        je short .3
        push esi
        call FreeMemBlock
        add esp, byte 4
.3:
        mov ebp, dword [RinkPartModels+3Ch]
        push ebp
        call FreeMemBlock
        mov eax, dword [RinkPartModels+38h]
        add esp, byte 4
        test eax, eax
        je short .4
        mov edx, dword [RinkPartModels+34h]
        push edx
        call FreeMemBlock
        add esp, byte 4
        mov ebx, dword [RinkPartModels+30h]
        push ebx
        call FreeMemBlock
        add esp, byte 4
.4:
        call FreeOverlaySlots
        mov ecx, dword [BenchModelParts]
        push ecx
        call FreeMemBlock
        add esp, byte 4
        mov esi, dword [GlassParts]
        push esi
        call FreeMemBlock
        add esp, byte 4
        mov edi, dword [FaceoffSpotModel]
        push edi
        call FreeMemBlock
        add esp, byte 4
        mov ebp, dword [EndSpotModels]
        push ebp
        call FreeMemBlock
        add esp, byte 4
        mov eax, dword [HomeBlueLineModel]
        push eax
        call FreeMemBlock
        add esp, byte 4
        mov edx, dword [AwayBlueLineModel]
        push edx
        call FreeMemBlock
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SetRinkTransform                                5475C  97 PC, low confidence
; Sets the rink transform
;-----------------------------------------------------------------------------
SetRinkTransform:
        push ebx
        push ecx
        push esi
        push edi
        mov ebx, edx
        mov edi, CameraFlashOn
        mov esi, eax
        movsd
        movsd
        movsd
        mov ecx, 9
        mov edi, FlashPolys
        mov esi, edx
        push eax
        rep movsd
        call SetRinkTranslation
        add esp, byte 4
        push ebx
        call SetRinkMatrix
        add esp, byte 4
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawRinkBackground                              54794  97 PC, low confidence
; Draws the rink background
;-----------------------------------------------------------------------------
DrawRinkBackground:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 248h
        mov ebx, 0FFFFD8F1h
        mov edx, 270Fh
        mov ecx, dword [RinkModelBuffer]
        mov dword [dword esp+023Ch], ebx
        mov dword [dword esp+0244h], edx
        test ecx, ecx
        jle short .2
        shl ecx, 2
        xor ebx, ebx
        xor edx, edx
        xor eax, eax
        mov dword [dword esp+0238h], ecx
.1:
        imul ecx, dword [dword edx+RinkModelParts], byte 0Ch
        mov esi, dword [CrowdCenter]
        mov esi, dword [byte esi+07Ch]
        lea edi, [esp+ebx]
        add esi, ecx
        movsd
        movsd
        movsd
        mov esi, dword [dword edx+RinkModelParts]
        mov ecx, dword [CrowdCenter]
        shl esi, 3
        mov ecx, dword [dword ecx+080h]
        lea edi, [dword esp+eax+0F0h]
        add esi, ecx
        add eax, byte 8
        movsd
        movsd
        add ebx, byte 0Ch
        mov edi, dword [dword esp+eax+0ECh]
        add edx, byte 4
        sub edi, byte 2
        mov ecx, dword [dword esp+0238h]
        mov dword [dword esp+eax+0ECh], edi
        cmp edx, ecx
        jl short .1
.2:
        mov esi, dword [str_Punct_DrawRinkSurface]
        push esi
        lea eax, [dword esp+0F4h]
        push eax
        lea eax, [byte esp+08h]
        push eax
        mov edi, dword [RinkModelBuffer]
        push edi
        call ClipPolyToNear
        add esp, byte 10h
        mov dword [dword esp+0240h], eax
        test eax, eax
        jne short .3
        push eax
        call ClearScreen
        add esp, byte 4
        jmp near .18
.3:
        xor edx, edx
        test eax, eax
        jle short .7
        xor eax, eax
.4:
        mov ecx, dword [dword esp+0244h]
        mov ebx, dword [dword esp+eax+0F4h]
        cmp ebx, ecx
        jge short .5
        mov dword [dword esp+0234h], edx
        mov dword [dword esp+0244h], ebx
.5:
        mov esi, dword [dword esp+023Ch]
        mov ebx, dword [dword esp+eax+0F4h]
        cmp ebx, esi
        jle short .6
        mov ebp, edx
        mov dword [dword esp+023Ch], ebx
.6:
        mov ebx, dword [dword esp+0240h]
        inc edx
        add eax, byte 8
        cmp edx, ebx
        jl short .4
.7:
        mov eax, dword [dword esp+0244h]
        cmp eax, dword [ViewScreenHeight]
        jge short .8
        cmp dword [dword esp+023Ch], byte 0
        jg short .9
.8:
        push byte 0
        call ClearScreen
        add esp, byte 4
        add esp, 248h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        test eax, eax
        jle short .10
        mov eax, dword [RinkPartModels+130h]
        push eax
        mov edx, dword [dword esp+0248h]
        push edx
        mov ebx, dword [ViewScreenWidth]
        push ebx
        push byte 0
        push byte 0
        call FillRect
        add esp, byte 14h
.10:
        mov eax, dword [dword esp+023Ch]
        mov ecx, dword [ViewScreenHeight]
        cmp eax, ecx
        jge short .11
        mov edi, dword [dword esp+0244h]
        mov esi, dword [RinkPartModels+130h]
        mov eax, ecx
        push esi
        sub eax, edi
        push eax
        mov eax, dword [ViewScreenWidth]
        push eax
        mov edx, dword [dword esp+0248h]
        push edx
        push byte 0
        call FillRect
        add esp, byte 14h
.11:
        mov eax, dword [dword esp+0234h]
        mov ebx, dword [dword esp+0240h]
        xor edx, edx
        test ebx, ebx
        jle short .14
        mov ecx, dword [dword esp+0240h]
        xor ebx, ebx
        shl ecx, 3
.12:
        cmp eax, dword [dword esp+0240h]
        jl short .13
        xor eax, eax
.13:
        lea edi, [dword esp+ebx+0190h]
        lea esi, [dword esp+eax*8+0F0h]
        add ebx, byte 8
        inc edx
        movsd
        movsd
        cmp eax, ebp
        je short .14
        inc eax
        cmp ebx, ecx
        jl short .12
.14:
        inc edx
        inc edx
        mov eax, 0FFFFFC19h
        mov ebx, dword [dword esp+023Ch]
        mov dword [dword esp+edx*8+0180h], eax
        push byte 0
        mov dword [dword esp+edx*8+0188h], ebx
        push byte 0FFFFFFFFh
        mov dword [dword esp+edx*8+0190h], eax
        lea eax, [dword esp+0198h]
        mov ebx, dword [dword esp+024Ch]
        push eax
        mov dword [dword esp+edx*8+0198h], ebx
        push edx
        mov ecx, dword [RinkPartModels+130h]
        push ecx
        call FillPolygon
        add esp, byte 14h
        xor edx, edx
        mov esi, dword [dword esp+0240h]
        mov eax, dword [dword esp+0234h]
        test esi, esi
        jle short .17
        lea ebx, [byte esi-01h]
        mov dword [dword esp+0230h], ebx
        lea ecx, [nosplit esi*8+00h]
        xor ebx, ebx
.15:
        test eax, eax
        jge short .16
        mov eax, dword [dword esp+0230h]
.16:
        lea edi, [dword esp+ebx+0190h]
        lea esi, [dword esp+eax*8+0F0h]
        add ebx, byte 8
        inc edx
        movsd
        movsd
        cmp eax, ebp
        je short .17
        dec eax
        cmp ebx, ecx
        jl short .15
.17:
        mov edi, 3E7h
        inc edx
        mov ebx, dword [dword esp+023Ch]
        inc edx
        push byte 0
        lea eax, [dword esp+0194h]
        mov dword [dword esp+edx*8+0184h], edi
        push byte 1
        mov dword [dword esp+edx*8+018Ch], ebx
        mov ebx, dword [dword esp+024Ch]
        mov dword [dword esp+edx*8+0190h], edi
        push eax
        mov dword [dword esp+edx*8+0198h], ebx
        push edx
        mov eax, dword [RinkPartModels+130h]
        push eax
        call FillPolygon
        add esp, byte 14h
.18:
        add esp, 248h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawRinkSurface                                 54A8C  97 PC, low confidence
; Draws the rink surface and markings
;-----------------------------------------------------------------------------
DrawRinkSurface:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 32Ch
        mov eax, dword [CrowdCenter]
        and byte [byte eax+010h], 0FDh
        cmp dword [ShowStands], byte 0
        je near .3
        cmp dword [RinkSurfaceDrawn], byte 0
        jne short .1
        mov edx, 1
        mov eax, dword [RinkPaletteData]
        call UpdateRinkPalette
.1:
        mov edx, dword [RinkPartModels+1ACh]
        mov eax, 1
        push edx
        mov dword [RinkSurfaceDrawn], eax
        call DrawRinkObjectPolys
        add esp, byte 4
        mov ebx, dword [RinkPartModels+1ACh]
        push ebx
        call ProjectRinkObjectPoints
        add esp, byte 4
        xor edx, edx
        xor ebx, ebx
        xor eax, eax
.2:
        imul ebp, dword [dword eax+RinkModelTexInfo], byte 0Ch
        mov ecx, dword [RinkPartModels+1ACh]
        mov esi, dword [byte ecx+07Ch]
        lea edi, [dword esp+ebx+0280h]
        add esi, ebp
        movsd
        movsd
        movsd
        add edx, byte 8
        mov esi, dword [dword eax+RinkModelTexInfo]
        mov ecx, dword [RinkPartModels+1ACh]
        shl esi, 3
        mov ecx, dword [dword ecx+080h]
        lea edi, [dword esp+edx+02D8h]
        add esi, ecx
        add ebx, byte 0Ch
        add eax, byte 4
        movsd
        movsd
        cmp eax, byte 10h
        jne short .2
        lea eax, [dword esp+02E0h]
        push eax
        lea eax, [dword esp+0284h]
        push eax
        push byte 4
        call DrawIceSpans
        add esp, byte 0Ch
        mov esi, dword [RinkPartModels+118h]
        push esi
        mov edi, dword [RinkPartModels+0F0h]
        push edi
        mov ebp, dword [RinkPartModels+1ACh]
        push ebp
        call DrawModelInstance
        add esp, byte 0Ch
        jmp near .8
.3:
        cmp dword [ShowRink], byte 0
        je near .6
        cmp dword [LogosLoaded], byte 0
        je near .6
        lea eax, [dword esp+0C0h]
        push eax
        mov edi, dword [str_Punct_DrawRinkSurface]
        mov eax, dword [CrowdCenter]
        push edi
        mov ebp, dword [dword eax+080h]
        push ebp
        mov edx, dword [byte eax+07Ch]
        push edx
        push RinkModelParts
        mov ebx, dword [RinkModelBuffer]
        push ebx
        call DrawRinkPolyList
        add esp, byte 18h
        cmp eax, byte 2
        jle short .4
        push byte 0
        push byte 1
        lea edx, [dword esp+0C8h]
        push edx
        push eax
        mov ecx, dword [RinkLineModel]
        push ecx
        call FillPolygon
        add esp, byte 14h
.4:
        cmp dword [RinkSurfaceDrawn], byte 0
        je short .5
        mov edx, 1
        mov eax, dword [RinkPaletteData]
        call UpdateRinkPalette
.5:
        mov ebp, dword [RinkPartModels+1ACh]
        xor edi, edi
        push ebp
        mov dword [RinkSurfaceDrawn], edi
        call DrawRinkObjectPolys
        add esp, byte 4
        mov eax, dword [RinkPartModels+1ACh]
        push eax
        call ProjectRinkObjectPoints
        mov eax, dword [RinkPartModels+1ACh]
        add esp, byte 4
        mov edx, dword [dword eax+080h]
        push edx
        mov ebx, dword [byte eax+07Ch]
        push ebx
        push byte 0Ch
        call DrawIceSpans
        add esp, byte 0Ch
        mov ecx, dword [RinkPartModels+10Ch]
        push ecx
        mov esi, dword [RinkPartModels+104h]
        push esi
        mov edi, dword [RinkPartModels+1ACh]
        push edi
        call DrawModelInstance
        add esp, byte 0Ch
        jmp short .8
.6:
        lea eax, [dword esp+0160h]
        push eax
        mov esi, dword [str_Punct_DrawRinkSurface]
        mov eax, dword [CrowdCenter]
        push esi
        mov edi, dword [dword eax+080h]
        push edi
        mov ebp, dword [byte eax+07Ch]
        push ebp
        push RinkModelParts
        mov eax, dword [RinkModelBuffer]
        push eax
        call DrawRinkPolyList
        mov edx, dword [RinkSurfaceDrawn]
        add esp, byte 18h
        mov ebx, eax
        test edx, edx
        je short .7
        mov edx, 1
        mov eax, dword [RinkPaletteData]
        call UpdateRinkPalette
.7:
        xor ecx, ecx
        mov dword [RinkSurfaceDrawn], ecx
        cmp ebx, byte 2
        jle short .8
        push ecx
        push byte 1
        lea eax, [dword esp+0168h]
        push eax
        push ebx
        mov esi, dword [RinkLineModel]
        push esi
        call FillPolygon
        add esp, byte 14h
.8:
        call DrawIceSurface
        mov eax, dword [RinkLength]
        mov ebx, dword [str_Punct_DrawRinkSurface]
        cmp ebx, dword [byte eax+08h]
        jge short .11
        mov ecx, dword [byte eax+04h]
        test ecx, ecx
        jge short .9
        mov edx, ecx
        neg edx
        jmp short .10
.9:
        mov edx, ecx
.10:
        mov eax, dword [RinkLength]
        cmp edx, dword [byte eax+08h]
        jge short .11
        xor edx, edx
        call DrawGoalLines
.11:
        mov eax, dword [RinkWidth]
        mov edi, dword [str_Punct_DrawRinkSurface]
        cmp edi, dword [byte eax+08h]
        jge short .14
        mov ebp, dword [byte eax+04h]
        test ebp, ebp
        jge short .12
        mov edx, ebp
        neg edx
        jmp short .13
.12:
        mov edx, ebp
.13:
        mov eax, dword [RinkWidth]
        cmp edx, dword [byte eax+08h]
        jge short .14
        mov edx, 1
        call DrawGoalLines
.14:
        mov eax, dword [RinkCorner]
        call DrawBoardsLines
        mov ecx, dword [RinkPartModels+0CCh]
        push ecx
        mov esi, dword [RinkPartModels+0D8h]
        push esi
        mov edi, dword [CrowdCenter]
        push edi
        call DrawModelInstance
        mov eax, dword [CrowdCenter]
        mov dh, byte [byte eax+010h]
        or dh, 2
        mov ebx, 1
        mov byte [byte eax+010h], dh
        add esp, byte 0Ch
        mov eax, dword [RinkModelState]
        xor edx, edx
        mov esi, 4
        call DrawRinkMarkings
.15:
        mov edx, ebx
        mov eax, dword [dword esi+RinkModelState]
        call DrawRinkMarkings
        inc ebx
        add esi, byte 4
        cmp ebx, byte 5
        jl short .15
        mov edx, dword [EndSpotModels]
        mov eax, dword [RinkModelState]
        mov ebx, 4
        call DrawCreases
.16:
        mov edx, dword [FaceoffSpotModel]
        mov eax, dword [dword ebx+RinkModelState]
        add ebx, byte 4
        call DrawCreases
        cmp ebx, byte 14h
        jne short .16
        xor ebx, ebx
.17:
        mov edx, dword [FaceoffSpotModel]
        mov eax, dword [dword ebx+RinkMarkingGeometry+6E0h]
        add ebx, byte 4
        call DrawCreases
        cmp ebx, byte 10h
        jne short .17
        cmp dword [ShowShadows], byte 0
        je near .22
        mov eax, RinkSideGeometry+410h
        push StandsPalette
        mov dword [dword esp+0328h], eax
        call SetRemapTable
        add esp, byte 4
        xor edx, edx
        mov dword [dword esp+0320h], edx
.18:
        mov eax, dword [dword esp+0324h]
        cmp dword [eax], byte 0
        je near .21
        cmp dword [byte eax+04h], byte 0
        je near .21
        mov ebp, dword [byte eax+018h]
        mov edi, dword [byte eax+0Ch]
        xor esi, esi
        shl ebp, 2
        mov dword [dword esp+0328h], esi
        add ebp, RinkSideGeometry+0DA0h
        test edi, edi
        jle near .21
.19:
        mov eax, dword [byte ebp+00h]
        mov ecx, dword [byte eax+08h]
        push ecx
        push byte 4
        call TransformRinkPoints
        add esp, byte 8
        test eax, eax
        jne near .20
        mov eax, dword [byte ebp+00h]
        mov eax, dword [byte eax+08h]
        imul esi, dword [eax], byte 0Ch
        mov eax, dword [TextureDetail]
        lea edi, [dword esp+02B0h]
        add esi, eax
        movsd
        movsd
        movsd
        mov edx, dword [byte ebp+00h]
        mov edx, dword [byte edx+08h]
        imul esi, dword [byte edx+04h], byte 0Ch
        lea edi, [dword esp+02BCh]
        add esi, eax
        movsd
        movsd
        movsd
        mov edx, dword [byte ebp+00h]
        mov edx, dword [byte edx+08h]
        imul esi, dword [byte edx+08h], byte 0Ch
        lea edi, [dword esp+02C8h]
        add esi, eax
        movsd
        movsd
        movsd
        mov edx, dword [byte ebp+00h]
        mov edx, dword [byte edx+08h]
        imul esi, dword [byte edx+0Ch], byte 0Ch
        lea edi, [dword esp+02D4h]
        add esi, eax
        movsd
        movsd
        movsd
        mov eax, dword [dword esp+02D8h]
        mov edx, dword [dword esp+02B4h]
        sub eax, edx
        add eax, eax
        mov ecx, dword [dword esp+02C0h]
        lea ebx, [edx+eax]
        mov eax, dword [dword esp+02CCh]
        lea edx, [dword esp+02B0h]
        sub eax, ecx
        mov dword [dword esp+02B4h], ebx
        add eax, eax
        lea ebx, [dword esp+0300h]
        lea esi, [ecx+eax]
        mov eax, 4
        mov dword [dword esp+02C0h], esi
        call ProjectPointsWithZ
        push byte 1
        push byte 0
        lea eax, [dword esp+0308h]
        push eax
        push byte 4
        push dword 270Fh
        call FillPolygon
        add esp, byte 14h
.20:
        mov eax, dword [dword esp+0328h]
        mov edx, dword [dword esp+0324h]
        add ebp, byte 4
        inc eax
        mov ebx, dword [byte edx+0Ch]
        mov dword [dword esp+0328h], eax
        cmp eax, ebx
        jl near .19
.21:
        mov ebp, dword [dword esp+0324h]
        mov edi, dword [dword esp+0320h]
        add ebp, 88h
        inc edi
        mov dword [dword esp+0324h], ebp
        mov dword [dword esp+0320h], edi
        cmp edi, byte 12h
        jl near .18
.22:
        cmp dword [RinkPartModels+38h], byte 0
        je short .24
        push RinkPaletteRemap
        call SetRemapTable
        xor esi, esi
        add esp, byte 4
.23:
        push dword 0C0h
        lea eax, [byte esp+04h]
        push eax
        mov eax, dword [CrowdCenter]
        mov ebx, dword [byte eax+07Ch]
        push ebx
        call bcopy
        add esp, byte 0Ch
        mov ecx, dword [str_Punct_DrawRinkSurface]
        push ecx
        lea eax, [dword esp+0204h]
        push eax
        lea eax, [byte esp+08h]
        push eax
        push byte 10h
        call ClipPolyToNear
        lea ecx, [byte esp+010h]
        add esp, byte 10h
        mov ebx, eax
        mov ebp, dword [dword esi+RinkTextureArt]
        mov edx, dword [dword esi+RinkTextures]
        mov eax, ebp
        add esi, byte 4
        call DrawSurfacePolys
        cmp esi, byte 10h
        jne short .23
.24:
        add esp, 32Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LoadOpeningArt                                  55000  97 PC, low confidence
; Loads the opening sequence art
;-----------------------------------------------------------------------------
LoadOpeningArt:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 8
        mov ebx, eax
        mov edx, dword [RinkPartModels+38h]
        cmp eax, edx
        je near .4
        test edx, edx
        je short .1
        mov esi, dword [RinkPartModels+34h]
        push esi
        call FreeMemBlock
        add esp, byte 4
        mov edi, dword [RinkPartModels+30h]
        push edi
        call FreeMemBlock
        add esp, byte 4
.1:
        mov eax, 64h
        mov dword [RinkPartModels+38h], ebx
        test ebx, ebx
        je short .2
        mov edx, 0C000h
        jmp short .3
.2:
        mov edx, 10000h
.3:
        mov ebx, eax
        mov eax, 0FFh
        call FadeGamePalette
        cmp dword [RinkPartModels+38h], byte 0
        je near .4
        mov edi, esp
        mov esi, str_Light
        mov ebx, 6
        movsd
        movsd
        call Random32
        xor edx, edx
        div ebx
        add edx, byte 30h
        mov eax, str_ArenaViv2
        mov byte [byte esp+05h], dl
        call SetArtArchive
        push byte 20h
        lea eax, [byte esp+04h]
        push eax
        call OpenArtArchiveErr
        add esp, byte 8
        mov dword [RinkPartModels+34h], eax
        call ServiceIdle
        push byte 20h
        push str_Light6
        call OpenArtArchiveErr
        add esp, byte 8
        mov dword [RinkPartModels+30h], eax
        call ServiceIdle
        push byte 0
        call OpenResourceArchive
        add esp, byte 4
        push byte 0
        mov eax, dword [RinkPartModels+34h]
        push eax
        call ArtBankEntry
        add esp, byte 8
        push byte 0
        mov edx, dword [RinkPartModels+30h]
        push edx
        mov dword [OpeningArtPalette], eax
        mov dword [RinkTextureArt], eax
        call ArtBankEntry
        add esp, byte 8
        mov dword [OpeningArtSize], eax
        mov dword [OpeningArt], eax
.4:
        add esp, byte 8
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawRinkOverlay                                 55110  97 PC, low confidence
; Draws the rink overlay
;-----------------------------------------------------------------------------
DrawRinkOverlay:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edx, dword [CrowdCenter]
        push edx
        call DrawRinkObjectPolys
        add esp, byte 4
        mov ebx, dword [CrowdCenter]
        push ebx
        call ProjectRinkObjectPoints
        mov ecx, dword [ShowOverlay]
        add esp, byte 4
        test ecx, ecx
        je short .1
        mov esi, dword [FlashSpots]
        push esi
        call DrawRinkObjectPolys
        add esp, byte 4
        mov edi, dword [FlashSpots]
        push edi
        call ProjectRinkObjectPoints
        add esp, byte 4
.1:
        cmp dword [CameraScenesEnabled], byte 0
        je short .2
        mov eax, dword [RinkOverlayModel]
        push eax
        call DrawRinkObjectPolys
        add esp, byte 4
        mov edx, dword [RinkOverlayModel]
        push edx
        call ProjectRinkObjectPoints
        add esp, byte 4
.2:
        cmp dword [RinkPartModels+38h], byte 0
        je near .5
        cmp dword [FlashTimer], byte 0
        jne short .4
        xor esi, esi
.3:
        mov edx, dword [OverlayFrame]
        imul edx, dword [dword esi+OverlayFrameStride]
        push edx
        mov ebx, dword [dword esi+RinkTextureRows]
        call SinInterp
        mov edx, eax
        sar edx, 1Fh
        shl edx, 4
        LD sbb, eax, edx
        sar eax, 4
        mov ebp, dword [dword esi+OverlayFrameSize]
        mov edx, dword [OverlayFrame]
        imul edx, ebp
        add esp, byte 4
        add ebx, 1999h
        push edx
        add ebx, eax
        call SinInterp
        mov edx, eax
        mov ecx, 6
        sar edx, 1Fh
        idiv ecx
        mov edx, dword [dword esi+RinkTexturePtrs]
        add esp, byte 4
        add edx, eax
        mov eax, dword [dword esi+RinkTextureInfo]
        add esi, byte 4
        call ProjectOverlayPoint
        cmp esi, byte 10h
        jne short .3
        inc dword [OverlayFrame]
.4:
        mov edx, FlashPolys
        mov eax, CameraFlashOn
        call DrawOverlayModels
.5:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawBenchModels                                 55228  97 PC, low confidence
; Draws the players on the bench
;-----------------------------------------------------------------------------
DrawBenchModels:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov dword [byte esp+0Ch], eax
        mov dword [byte esp+010h], edx
        cmp dword [ShowBenches], byte 0
        je near .5
        mov edx, eax
        shl eax, 3
        sub eax, edx
        mov esi, HomeBenchModels
        shl eax, 2
        mov ebx, dword [byte esp+010h]
        add esi, eax
        test ebx, ebx
        jg short .1
        add esi, byte 18h
.1:
        xor edi, edi
.2:
        mov edx, dword [esi]
        lea ebp, [nosplit edx*8+00h]
        imul edx, byte 0Ch
        mov eax, dword [CrowdCenter]
        mov ecx, esp
        mov ebx, dword [dword eax+080h]
        push ecx
        add ebp, ebx
        mov ebx, dword [byte eax+07Ch]
        mov eax, dword [byte eax+074h]
        push CameraFlashOn
        add eax, edx
        push eax
        add ebx, edx
        call SubVec3
        add esp, byte 0Ch
        mov ecx, ebp
        mov edx, eax
        mov eax, dword [byte esp+0Ch]
        call RenderModelPortrait
        cmp dword [byte esp+010h], byte 0
        jle short .3
        add esi, byte 4
        jmp short .4
.3:
        sub esi, byte 4
.4:
        inc edi
        cmp edi, byte 7
        jl short .2
.5:
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ecx
        push ebx
        mov ebx, dword [RinkPartModels+0FCh]
        lea eax, [dword ebx-01F4h]
        mov ecx, edx
        mov edx, eax
        xor eax, eax
        call DrawModelList
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawBenchSide                                552E0  96 PC, medium confidence
; Draws the bench side of the rink (DrawRinkPlayers, DrawBenchPlayers)
;-----------------------------------------------------------------------------
DrawBenchSide:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 100h
        mov edx, esp
        push edx
        call GetRemapTable
        add esp, byte 4
        push GlassRemap
        call SetRemapTable
        mov edx, dword [GlassParts]
        mov ebx, dword [RinkPartModels+84h]
        mov dword [RinkPartModels+1A8h], edx
        mov edx, dword [CameraFlashOn]
        add esp, byte 4
        cmp edx, ebx
        jle short .1
        mov edx, dword [CrowdCenter]
        and byte [byte edx+010h], 0FDh
        mov ecx, dword [RinkPartModels+80h]
        push ecx
        mov esi, dword [RinkPartModels+74h]
        push esi
        mov edi, dword [CrowdCenter]
        push edi
        call DrawModelInstance
        mov edx, dword [CrowdCenter]
        mov bl, byte [byte edx+010h]
        or bl, 2
        add esp, byte 0Ch
        mov byte [byte edx+010h], bl
.1:
        mov ebp, dword [BenchSideIndex]
        test ebp, ebp
        jg near .3
        mov edi, dword [RinkPartModels+0B4h]
        push edi
        mov ebp, dword [RinkPartModels+0A4h]
        push ebp
        mov eax, dword [CrowdCenter]
        push eax
        call DrawModelInstance
        add esp, byte 0Ch
        mov edx, 0FFFFFFFFh
        mov eax, 1
        call DrawBenchModels
        xor ecx, ecx
        mov edx, dword [RinkPartModels+88h]
        mov ebx, dword [RinkPartModels+0FCh]
        push edx
        xor eax, eax
        lea edx, [dword ebx-01F4h]
        call DrawModelList
        mov edx, dword [RinkPartModels+6Ch]
        push edx
        mov ebx, dword [RinkPartModels+09Ch]
        push ebx
        mov ecx, dword [CrowdCenter]
        push ecx
        call DrawModelInstance
        mov edx, dword [BenchSideIndex]
        mov esi, dword [RinkPartModels+8Ch]
        add esp, byte 0Ch
        cmp edx, esi
        jge short .2
        mov edx, 1
        xor eax, eax
        call DrawBenchModels
        push byte 0
        mov ecx, dword [RinkPartModels+8Ch]
        mov ebx, dword [RinkPartModels+0FCh]
        xor eax, eax
        lea edx, [dword ebx-01F4h]
        call DrawModelList
        push BenchRemap
        call SetRemapTable
        mov edx, dword [BenchModelParts]
        add esp, byte 4
        mov dword [RinkPartModels+1A8h], edx
.2:
        mov edi, dword [RinkPartModels+0B0h]
        push edi
        mov ebp, dword [RinkPartModels+0A0h]
        push ebp
        mov eax, dword [CrowdCenter]
        push eax
        call DrawModelInstance
        mov edx, dword [BenchSideIndex]
        mov ebx, dword [RinkPartModels+8Ch]
        add esp, byte 0Ch
        cmp edx, ebx
        jl near .6
        mov edx, 1
        xor eax, eax
        call DrawBenchModels
        push byte 0
        mov ecx, dword [RinkPartModels+8Ch]
        mov ebx, dword [RinkPartModels+0FCh]
        jmp near .5
.3:
        jle near .6
        mov edx, dword [RinkPartModels+0B0h]
        push edx
        mov ebx, dword [RinkPartModels+0A0h]
        push ebx
        mov ecx, dword [CrowdCenter]
        push ecx
        call DrawModelInstance
        add esp, byte 0Ch
        mov edx, 0FFFFFFFFh
        xor eax, eax
        call DrawBenchModels
        push byte 0
        mov ecx, dword [RinkPartModels+8Ch]
        mov ebx, dword [RinkPartModels+0FCh]
        xor eax, eax
        lea edx, [dword ebx-01F4h]
        call DrawModelList
        mov esi, dword [RinkPartModels+6Ch]
        push esi
        mov edi, dword [RinkPartModels+09Ch]
        push edi
        mov ebp, dword [CrowdCenter]
        push ebp
        call DrawModelInstance
        mov edx, dword [BenchSideIndex]
        mov eax, dword [RinkPartModels+88h]
        add esp, byte 0Ch
        cmp edx, eax
        jle short .4
        mov edx, 1
        mov eax, edx
        xor ecx, ecx
        call DrawBenchModels
        mov edx, dword [RinkPartModels+88h]
        mov ebx, dword [RinkPartModels+0FCh]
        push edx
        xor eax, eax
        lea edx, [dword ebx-01F4h]
        call DrawModelList
        push BenchRemap
        call SetRemapTable
        mov edx, dword [BenchModelParts]
        add esp, byte 4
        mov dword [RinkPartModels+1A8h], edx
.4:
        mov edx, dword [RinkPartModels+0B4h]
        push edx
        mov ebx, dword [RinkPartModels+0A4h]
        push ebx
        mov ecx, dword [CrowdCenter]
        push ecx
        call DrawModelInstance
        mov edx, dword [BenchSideIndex]
        mov esi, dword [RinkPartModels+88h]
        add esp, byte 0Ch
        cmp edx, esi
        jg short .6
        mov edx, 1
        mov eax, edx
        xor ecx, ecx
        call DrawBenchModels
        mov edx, dword [RinkPartModels+88h]
        mov ebx, dword [RinkPartModels+0FCh]
        push edx
.5:
        xor eax, eax
        lea edx, [dword ebx-01F4h]
        call DrawModelList
.6:
        mov ecx, dword [RinkPartModels+84h]
        cmp ecx, dword [CameraFlashOn]
        jl short .7
        push BenchRemap
        call SetRemapTable
        mov edx, dword [BenchModelParts]
        mov ebx, dword [CrowdCenter]
        mov dword [RinkPartModels+1A8h], edx
        and byte [byte ebx+010h], 0FDh
        add esp, byte 4
        mov esi, dword [RinkPartModels+80h]
        push esi
        mov edi, dword [RinkPartModels+74h]
        push edi
        mov ebp, dword [CrowdCenter]
        push ebp
        call DrawModelInstance
        mov edx, dword [CrowdCenter]
        mov ch, byte [byte edx+010h]
        or ch, 2
        add esp, byte 0Ch
        mov byte [byte edx+010h], ch
.7:
        mov edx, esp
        push edx
        call SetRemapTable
        add esp, byte 4
        add esp, 100h
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
        test eax, eax
        je short .8
        mov edx, 384h
        mov ecx, 12Ch
        jmp short .9
.8:
        mov edx, 0FFFFFED4h
        mov ecx, 0FFFFFC7Ch
.9:
        mov ebx, dword [RinkPartModels+0F4h]
        push edx
        xor eax, eax
        mov edx, dword [RinkPartModels+0F4h]
        add ebx, 1F4h
        call DrawModelList
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
        push edx
        shl eax, 4
        mov edx, dword [dword eax+BenchSideModel]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, dword [CrowdCenter]
        shl eax, 2
        mov edx, dword [byte edx+074h]
        add eax, edx
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; GetSeatPos                                      55648  97 PC, low confidence
; Returns the position of a seat
;-----------------------------------------------------------------------------
GetSeatPos:
        shl eax, 4
        mov edx, dword [dword eax+edx*4+SeatPositions]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        lea edx, [nosplit eax*4+00h]
        mov eax, dword [CrowdCenter]
        mov eax, dword [byte eax+074h]
        add eax, edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetBoxDoor                                      55670  97 PC, low confidence
; Opens or closes a penalty box door
;-----------------------------------------------------------------------------
SetBoxDoor:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov edx, eax
        test eax, eax
        je short .1
        mov eax, RinkPartModels+10h
        jmp short .2
.1:
        mov eax, RinkPartModels
.2:
        test edx, edx
        je short .3
        mov edx, 1
        jmp short .4
.3:
        mov edx, 0FFFFFFFFh
.4:
        mov ecx, dword [eax]
        mov edi, dword [CrowdCenter]
        lea ebx, [nosplit ecx*4+00h]
        mov esi, dword [RinkPartModels+0F4h]
        sub ebx, ecx
        mov ecx, dword [byte edi+074h]
        add esi, byte 78h
        mov dword [ecx+ebx*4], esi
        lea ebx, [nosplit edx*4+00h]
        add ebx, edx
        shl ebx, 2
        mov edx, ebx
        shl ebx, 4
        mov ecx, dword [eax]
        sub ebx, edx
        lea edx, [nosplit ecx*4+00h]
        sub edx, ecx
        lea ecx, [nosplit edx*4+00h]
        mov edx, dword [CrowdCenter]
        mov edx, dword [byte edx+074h]
        mov dword [byte ecx+edx+08h], ebx
        mov ecx, dword [byte eax+04h]
        mov esi, dword [CrowdCenter]
        lea edx, [nosplit ecx*4+00h]
        mov edi, dword [RinkPartModels+0F4h]
        sub edx, ecx
        mov ecx, dword [byte esi+074h]
        add edi, byte 78h
        mov dword [ecx+edx*4], edi
        mov ecx, dword [byte eax+04h]
        lea edx, [nosplit ecx*4+00h]
        sub edx, ecx
        lea ecx, [nosplit edx*4+00h]
        mov edx, dword [CrowdCenter]
        mov edx, dword [byte edx+074h]
        add eax, byte 4
        mov dword [byte ecx+edx+08h], ebx
        mov ecx, dword [byte eax+04h]
        mov esi, dword [CrowdCenter]
        lea edx, [nosplit ecx*4+00h]
        mov edi, dword [RinkPartModels+0F4h]
        sub edx, ecx
        mov ecx, dword [byte esi+074h]
        add edi, byte 78h
        add eax, byte 4
        mov dword [ecx+edx*4], edi
        mov edx, dword [eax]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        lea edx, [nosplit eax*4+00h]
        mov eax, dword [CrowdCenter]
        mov eax, dword [byte eax+074h]
        mov dword [byte edx+eax+08h], ebx
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
SetBoxDoor_105:
        mov eax, RinkPartModels
        test edx, edx
        je short SetBoxDoor_115
        mov edx, 1
        jmp short SetBoxDoor_11A
SetBoxDoor_115:
        mov edx, 0FFFFFFFFh
SetBoxDoor_11A:
        mov ecx, dword [eax]
        lea ebx, [nosplit ecx*4+00h]
        sub ebx, ecx
        mov esi, dword [CrowdCenter]
        shl ebx, 2
        mov ecx, dword [byte esi+074h]
        add ecx, ebx
        mov ebx, dword [RinkPartModels+0F4h]
        mov dword [ecx], ebx
        mov ebx, edx
        shl edx, 4
        sub edx, ebx
        mov ecx, dword [eax]
        mov ebx, edx
        lea edx, [nosplit ecx*4+00h]
        sub edx, ecx
        mov ecx, dword [CrowdCenter]
        mov ecx, dword [byte ecx+074h]
        shl ebx, 5
        mov dword [byte ecx+edx*4+08h], ebx
        mov ecx, dword [byte eax+04h]
        lea edx, [nosplit ecx*4+00h]
        sub edx, ecx
        mov esi, dword [CrowdCenter]
        shl edx, 2
        mov ecx, dword [byte esi+074h]
        add edx, ecx
        mov ecx, dword [RinkPartModels+0F4h]
        mov dword [edx], ecx
        mov ecx, dword [byte eax+04h]
        lea edx, [nosplit ecx*4+00h]
        sub edx, ecx
        lea ecx, [nosplit edx*4+00h]
        mov edx, dword [CrowdCenter]
        mov edx, dword [byte edx+074h]
        mov dword [byte ecx+edx+08h], ebx
        mov ecx, dword [byte eax+08h]
        lea edx, [nosplit ecx*4+00h]
        sub edx, ecx
        mov esi, dword [CrowdCenter]
        shl edx, 2
        mov ecx, dword [byte esi+074h]
        add eax, byte 4
        add edx, ecx
        mov ecx, dword [RinkPartModels+0F4h]
        add eax, byte 4
        mov dword [edx], ecx
        mov edx, dword [eax]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        lea edx, [nosplit eax*4+00h]
        mov eax, dword [CrowdCenter]
        mov eax, dword [byte eax+074h]
        mov dword [byte edx+eax+08h], ebx
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SetPenaltyBoxDoor                            5585C  96 PC, medium confidence
; (team, open): from asspenalty, assdopen, assepen and puckfaceoff2: opens or
; closes a penalty box door
;-----------------------------------------------------------------------------
SetPenaltyBoxDoor:
        mov dword [nosplit eax*4+BenchModel], edx
        test edx, edx
        jne near SetBoxDoor
        nop
;-----------------------------------------------------------------------------
; SetBoxDoorState                                 5586C  97 PC, low confidence
; Sets the state of the penalty box door
;-----------------------------------------------------------------------------
SetBoxDoorState:
        push ebx
        push ecx
        push edx
        push esi
        mov edx, eax
        test eax, eax
        je near SetBoxDoor_105
        mov eax, RinkPartModels+10h
        test edx, edx
        je near SetBoxDoor_115
        mov edx, 1
        jmp near SetBoxDoor_11A
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawBenchRow                                    55894  97 PC, low confidence
; Draws a row of the bench
;-----------------------------------------------------------------------------
DrawBenchRow:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 100h
        mov esi, eax
        mov edi, dword [CrowdCenter]
        shl esi, 4
        mov ebp, dword [dword edi+084h]
        add esi, eax
        mov eax, esp
        shl esi, 3
        push eax
        add esi, RinkSideGeometry+0C90h
        mov edi, dword [byte edi+07Ch]
        call GetRemapTable
        mov edx, dword [esi]
        add esp, byte 4
        test edx, edx
        je near .7
        cmp dword [ShowCenterLogo], byte 0
        je short .4
        mov ebx, dword [byte esi+020h]
        shl ebx, 2
        add ebx, RinkSideGeometry+0E68h
        mov eax, dword [ebx]
        mov ecx, dword [byte eax+08h]
        push ecx
        push byte 4
        call TransformRinkPoints
        add esp, byte 8
        test eax, eax
        jne short .4
        cmp dword [byte esi+04h], byte 0
        je short .1
        push GlassRemap
        call SetRemapTable
        mov eax, dword [GlassParts]
        jmp short .2
.1:
        push BenchRemap
        call SetRemapTable
        mov eax, dword [BenchModelParts]
.2:
        add esp, byte 4
        mov dword [RinkPartModels+1A8h], eax
        cmp dword [byte esi+024h], byte 0
        jne short .3
        call DrawBenchPlayers
        jmp short .4
.3:
        mov eax, dword [ebx]
        mov ebx, dword [byte eax+08h]
        push ebx
        push byte 4
        call DrawRinkPolys
        add esp, byte 8
.4:
        mov ebx, dword [byte esi+018h]
        shl ebx, 2
        add ebx, RinkSideGeometry+0DA0h
        mov eax, dword [ebx]
        mov ecx, dword [byte eax+08h]
        push ecx
        push byte 4
        call TransformRinkPoints
        add esp, byte 8
        test eax, eax
        jne short .6
        cmp dword [byte esi+04h], byte 0
        je short .5
        mov eax, dword [ebx]
        mov ebx, dword [byte eax+08h]
        push ebx
        push byte 4
        mov ecx, dword [GlassModel]
        push ecx
        call DrawRinkPolyStrip
        add esp, byte 0Ch
        jmp short .6
.5:
        push BenchPalette
        call SetRemapTable
        mov eax, dword [ebx]
        add esp, byte 4
        mov edx, dword [byte eax+08h]
        push edx
        push byte 4
        call DrawRinkPolys
        add esp, byte 8
.6:
        mov eax, dword [BenchLineModel]
        mov ecx, dword [HomeBlueLineModel]
        lea ebx, [byte esi+030h]
        push eax
        mov edx, ebp
        mov eax, edi
        call DrawRinkLine
        cmp dword [byte esi+04h], byte 0
        je short .7
        mov ebx, dword [BoardsTopModel]
        mov ecx, dword [AwayBlueLineModel]
        mov edx, ebp
        push ebx
        mov eax, edi
        lea ebx, [byte esi+048h]
        call DrawRinkLine
.7:
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
        ret
        db 090h
        push ebx
        push ecx
        push edx
        mov edx, dword [RinkPartModels+60h]
        push edx
        mov ebx, dword [RinkPartModels+0ACh]
        push ebx
        mov ecx, dword [CrowdCenter]
        push ecx
        call DrawModelInstance
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        mov edx, dword [RinkPartModels+64h]
        push edx
        mov ebx, dword [RinkPartModels+0A8h]
        push ebx
        mov ecx, dword [CrowdCenter]
        push ecx
        call DrawModelInstance
        add esp, byte 0Ch
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
        cmp dword [BenchDetail], byte 0
        je short .8
        mov ebx, dword [RinkPartModels+094h]
        cmp ebx, dword [BenchSideIndex]
        jle short .8
        mov eax, 1
        call DrawBenchRow
.8:
        mov ecx, dword [RinkPartModels+40h]
        push ecx
        mov esi, dword [RinkPartModels+0BCh]
        push esi
        mov edi, dword [CrowdCenter]
        push edi
        call DrawModelInstance
        mov ebp, dword [BenchDetail]
        add esp, byte 0Ch
        test ebp, ebp
        je short .9
        mov edx, dword [RinkPartModels+094h]
        cmp edx, dword [BenchSideIndex]
        jg short .9
        mov eax, 1
        call DrawBenchRow
.9:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp dword [BenchModel], byte 0
        je short .10
        mov ebx, dword [RinkPartModels+098h]
        cmp ebx, dword [BenchSideIndex]
        jg short .10
        xor eax, eax
        call DrawBenchRow
.10:
        mov ecx, dword [RinkPartModels+70h]
        push ecx
        mov esi, dword [RinkPartModels+0B8h]
        push esi
        mov edi, dword [CrowdCenter]
        push edi
        call DrawModelInstance
        mov ebp, dword [BenchModel]
        add esp, byte 0Ch
        test ebp, ebp
        je short .11
        mov edx, dword [RinkPartModels+098h]
        cmp edx, dword [BenchSideIndex]
        jle short .11
        xor eax, eax
        call DrawBenchRow
.11:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawBenchSection                                55B14  97 PC, low confidence
; Draws a section of the bench
;-----------------------------------------------------------------------------
DrawBenchSection:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebx, dword [RinkPartModels+0F4h]
        cmp ebx, dword [CameraFlashOn]
        jg short .2
        cmp dword [BenchDetail], byte 0
        jne short .1
        mov eax, 1
        call DrawBenchRow
.1:
        cmp dword [BenchModel], byte 0
        jne short .2
        xor eax, eax
        call DrawBenchRow
.2:
        mov edi, dword [RinkPartModels+0C0h]
        cmp edi, dword [CameraFlashOn]
        jle short .3
        mov edx, dword [CrowdCenter]
        and byte [byte edx+010h], 0FDh
        mov ebp, dword [RinkPartModels+58h]
        push ebp
        mov eax, dword [RinkPartModels+68h]
        push eax
        mov edx, dword [CrowdCenter]
        push edx
        call DrawModelInstance
        mov edx, dword [CrowdCenter]
        mov bl, byte [byte edx+010h]
        or bl, 2
        add esp, byte 0Ch
        mov byte [byte edx+010h], bl
.3:
        cmp dword [BenchSideIndex], byte 0
        jg near .11
        mov edx, dword [RinkPartModels+60h]
        push edx
        mov ebx, dword [RinkPartModels+0ACh]
        push ebx
        mov ecx, dword [CrowdCenter]
        push ecx
        call DrawModelInstance
        mov ecx, 12Ch
        add esp, byte 0Ch
        mov ebx, dword [RinkPartModels+0F4h]
        mov edx, dword [RinkPartModels+0F4h]
        push dword 384h
        xor eax, eax
        add ebx, 1F4h
        call DrawModelList
        cmp dword [BenchDetail], byte 0
        je short .4
        mov edi, dword [RinkPartModels+094h]
        cmp edi, dword [BenchSideIndex]
        jle short .4
        mov eax, 1
        call DrawBenchRow
.4:
        mov ebp, dword [RinkPartModels+40h]
        push ebp
        mov eax, dword [RinkPartModels+0BCh]
        push eax
        mov edx, dword [CrowdCenter]
        push edx
        call DrawModelInstance
        mov ebx, dword [BenchDetail]
        add esp, byte 0Ch
        test ebx, ebx
        je short .5
        mov ecx, dword [RinkPartModels+094h]
        cmp ecx, dword [BenchSideIndex]
        jg short .5
        mov eax, 1
        call DrawBenchRow
.5:
        mov esi, dword [RinkPartModels+098h]
        mov edx, dword [BenchSideIndex]
        cmp edx, esi
        jge short .7
        cmp dword [BenchModel], byte 0
        je short .6
        cmp edx, esi
        jl short .6
        xor eax, eax
        call DrawBenchRow
.6:
        mov eax, dword [RinkPartModels+70h]
        push eax
        mov edx, dword [RinkPartModels+0B8h]
        push edx
        mov ebx, dword [CrowdCenter]
        push ebx
        call DrawModelInstance
        mov ecx, dword [BenchModel]
        add esp, byte 0Ch
        test ecx, ecx
        je short .7
        mov esi, dword [RinkPartModels+098h]
        cmp esi, dword [BenchSideIndex]
        jle short .7
        xor eax, eax
        call DrawBenchRow
.7:
        mov edi, dword [RinkPartModels+7Ch]
        cmp edi, dword [BenchSideIndex]
        jle short .8
        push dword 0FFFFFED4h
        mov ecx, 0FFFFFC7Ch
        mov ebx, dword [RinkPartModels+0F4h]
        mov edx, dword [RinkPartModels+0F4h]
        xor eax, eax
        add ebx, 1F4h
        call DrawModelList
.8:
        mov ebp, dword [RinkPartModels+64h]
        push ebp
        mov eax, dword [RinkPartModels+0A8h]
        push eax
        mov edx, dword [CrowdCenter]
        push edx
        call DrawModelInstance
        mov edx, dword [BenchSideIndex]
        mov ebx, dword [RinkPartModels+7Ch]
        add esp, byte 0Ch
        cmp edx, ebx
        jl short .9
        push dword 0FFFFFED4h
        mov ecx, 0FFFFFC7Ch
        mov ebx, dword [RinkPartModels+0F4h]
        mov edx, dword [RinkPartModels+0F4h]
        xor eax, eax
        add ebx, 1F4h
        call DrawModelList
.9:
        mov ecx, dword [RinkPartModels+098h]
        mov edx, dword [BenchSideIndex]
        cmp edx, ecx
        jl near .20
        cmp dword [BenchModel], byte 0
        je short .10
        cmp edx, ecx
        jl short .10
        xor eax, eax
        call DrawBenchRow
.10:
        mov ebp, dword [RinkPartModels+70h]
        push ebp
        mov eax, dword [RinkPartModels+0B8h]
        push eax
        mov edx, dword [CrowdCenter]
        push edx
        call DrawModelInstance
        mov ebx, dword [BenchModel]
        add esp, byte 0Ch
        test ebx, ebx
        je near .20
        mov ecx, dword [RinkPartModels+098h]
        cmp ecx, dword [BenchSideIndex]
        jle near .20
        xor eax, eax
        jmp near .19
.11:
        mov ecx, dword [RinkPartModels+64h]
        push ecx
        mov esi, dword [RinkPartModels+0A8h]
        push esi
        mov edi, dword [CrowdCenter]
        push edi
        call DrawModelInstance
        mov ecx, 0FFFFFC7Ch
        add esp, byte 0Ch
        mov ebx, dword [RinkPartModels+0F4h]
        mov edx, dword [RinkPartModels+0F4h]
        push dword 0FFFFFED4h
        xor eax, eax
        add ebx, 1F4h
        call DrawModelList
        cmp dword [BenchModel], byte 0
        je short .12
        mov eax, dword [RinkPartModels+098h]
        cmp eax, dword [BenchSideIndex]
        jg short .12
        xor eax, eax
        call DrawBenchRow
.12:
        mov edx, dword [RinkPartModels+70h]
        push edx
        mov ebx, dword [RinkPartModels+0B8h]
        push ebx
        mov ecx, dword [CrowdCenter]
        push ecx
        call DrawModelInstance
        mov esi, dword [BenchModel]
        add esp, byte 0Ch
        test esi, esi
        je short .13
        mov edi, dword [RinkPartModels+098h]
        cmp edi, dword [BenchSideIndex]
        jle short .13
        xor eax, eax
        call DrawBenchRow
.13:
        mov ebp, dword [RinkPartModels+094h]
        mov edx, dword [BenchSideIndex]
        cmp edx, ebp
        jle short .15
        cmp dword [BenchDetail], byte 0
        je short .14
        cmp edx, ebp
        jge short .14
        mov eax, 1
        call DrawBenchRow
.14:
        mov ecx, dword [RinkPartModels+40h]
        push ecx
        mov esi, dword [RinkPartModels+0BCh]
        push esi
        mov edi, dword [CrowdCenter]
        push edi
        call DrawModelInstance
        mov ebp, dword [BenchDetail]
        add esp, byte 0Ch
        test ebp, ebp
        je short .15
        mov eax, dword [RinkPartModels+094h]
        cmp eax, dword [BenchSideIndex]
        jg short .15
        mov eax, 1
        call DrawBenchRow
.15:
        mov ebx, dword [RinkPartModels+78h]
        cmp ebx, dword [BenchSideIndex]
        jge short .16
        push dword 384h
        mov ecx, 12Ch
        mov ebx, dword [RinkPartModels+0F4h]
        mov edx, dword [RinkPartModels+0F4h]
        xor eax, eax
        add ebx, 1F4h
        call DrawModelList
.16:
        mov ecx, dword [RinkPartModels+60h]
        push ecx
        mov esi, dword [RinkPartModels+0ACh]
        push esi
        mov edi, dword [CrowdCenter]
        push edi
        call DrawModelInstance
        mov edx, dword [BenchSideIndex]
        mov ebp, dword [RinkPartModels+78h]
        add esp, byte 0Ch
        cmp edx, ebp
        jg short .17
        push dword 384h
        mov ecx, 12Ch
        mov ebx, dword [RinkPartModels+0F4h]
        mov edx, dword [RinkPartModels+0F4h]
        xor eax, eax
        add ebx, 1F4h
        call DrawModelList
.17:
        mov eax, dword [RinkPartModels+094h]
        cmp eax, dword [BenchSideIndex]
        jl short .20
        cmp dword [BenchDetail], byte 0
        je short .18
        cmp eax, dword [BenchSideIndex]
        jle short .18
        mov eax, 1
        call DrawBenchRow
.18:
        mov ecx, dword [RinkPartModels+40h]
        push ecx
        mov esi, dword [RinkPartModels+0BCh]
        push esi
        mov edi, dword [CrowdCenter]
        push edi
        call DrawModelInstance
        mov ebp, dword [BenchDetail]
        add esp, byte 0Ch
        test ebp, ebp
        je short .20
        mov eax, dword [RinkPartModels+094h]
        cmp eax, dword [BenchSideIndex]
        jg short .20
        mov eax, 1
.19:
        call DrawBenchRow
.20:
        mov esi, dword [RinkPartModels+0F4h]
        cmp esi, dword [CameraFlashOn]
        jle short .22
        cmp dword [BenchDetail], byte 0
        jne short .21
        mov eax, 1
        call DrawBenchRow
.21:
        cmp dword [BenchModel], byte 0
        jne short .22
        xor eax, eax
        call DrawBenchRow
.22:
        mov eax, dword [RinkPartModels+0C0h]
        cmp eax, dword [CameraFlashOn]
        jg short .23
        mov edx, dword [CrowdCenter]
        and byte [byte edx+010h], 0FDh
        mov edx, dword [RinkPartModels+58h]
        push edx
        mov ebx, dword [RinkPartModels+68h]
        push ebx
        mov ecx, dword [CrowdCenter]
        push ecx
        call DrawModelInstance
        mov edx, dword [CrowdCenter]
        mov cl, byte [byte edx+010h]
        or cl, 2
        add esp, byte 0Ch
        mov byte [byte edx+010h], cl
.23:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawRinkPass                                    55FE4  97 PC, low confidence
; Draws the rink for the frame
;-----------------------------------------------------------------------------
DrawRinkPass:
        call DrawRinkSurface
        cmp dword [ShowOverlay], byte 0
        je near DrawRinkBackground
        LD mov, eax, eax
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 280h
        cmp dword [RinkPassCount], byte 0
        jle short .2
        mov ebp, dword [RinkPassCount]
        xor ebx, ebx
        xor eax, eax
        xor edx, edx
        shl ebp, 2
.1:
        imul ecx, dword [dword eax+RinkPartModels+150h], byte 0Ch
        mov esi, dword [FlashSpots]
        mov esi, dword [byte esi+07Ch]
        lea edi, [esp+ebx]
        add esi, ecx
        movsd
        movsd
        movsd
        add edx, byte 8
        mov ecx, dword [dword eax+RinkPartModels+150h]
        mov esi, dword [FlashSpots]
        shl ecx, 3
        mov esi, dword [dword esi+080h]
        lea edi, [dword esp+edx+0178h]
        add esi, ecx
        add ebx, byte 0Ch
        add eax, byte 4
        movsd
        movsd
        cmp eax, ebp
        jl short .1
.2:
        mov edi, dword [str_Punct_DrawRinkSurface]
        push edi
        lea eax, [dword esp+0184h]
        push eax
        lea eax, [byte esp+08h]
        push eax
        mov ebp, dword [RinkPassCount]
        push ebp
        call ClipPolyToNear
        add esp, byte 10h
        push byte 0
        push byte 0FFFFFFFFh
        lea edx, [dword esp+0188h]
        push edx
        push eax
        mov eax, dword [RinkPartModels+130h]
        push eax
        call FillPolygon
        add esp, byte 14h
        add esp, 280h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawNearSide                                    560AC  97 PC, low confidence
; Draws the near side of the rink
;-----------------------------------------------------------------------------
DrawNearSide:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        call TransformRink
        mov eax, dword [FlashSpots]
        and byte [byte eax+010h], 0FDh
        cmp dword [ShowOverlay], byte 0
        je short .1
        mov ebx, dword [RinkPartModels+0C8h]
        push ebx
        mov ecx, dword [RinkPartModels+114h]
        push ecx
        mov esi, dword [FlashSpots]
        push esi
        call DrawModelInstance
        add esp, byte 0Ch
.1:
        cmp dword [ShowOverlay], byte 0
        je short .5
        cmp dword [RinkPartModels+38h], byte 0
        je short .2
        push RinkPaletteRemap
        call SetRemapTable
        add esp, byte 4
.2:
        xor eax, eax
        call DrawStandsSides
        mov eax, 1
        xor edx, edx
        call DrawStandsSides
.3:
        cmp dword [dword edx+FlashSpotTable], byte 0
        jne short .4
        mov eax, edx
        add eax, FlashSpotPos
        call DrawCameraFlashes
.4:
        add edx, byte 14h
        cmp edx, 190h
        jne short .3
.5:
        mov eax, dword [FlashSpots]
        or byte [byte eax+010h], 2
        mov eax, dword [CameraFlashOn]
        cmp eax, dword [RinkPartModels+0F4h]
        jg short .6
        call DrawBenchSection
.6:
        mov ebx, dword [RinkPartModels+0FCh]
        cmp ebx, dword [CameraFlashOn]
        jg short .7
        call DrawBenchSide
.7:
        mov ecx, dword [RinkPartModels+090h]
        cmp ecx, dword [BenchSideIndex]
        jl near .10
        cmp dword [CameraFlashOn], byte 0
        jg short .8
        push dword 40000000h
        mov esi, dword [NearSideModel]
        mov ecx, dword [NearSideParts]
        mov edx, dword [CrowdCenter]
        shl ecx, 3
        mov eax, dword [dword edx+080h]
        mov ebx, dword [NearSideParts]
        add ecx, eax
        lea eax, [nosplit ebx*4+00h]
        mov edx, dword [byte edx+07Ch]
        sub eax, ebx
        sub esp, byte 4
        fild dword [byte edx+eax*4+08h]
        fstp dword [esp]
        call ProjectCoord
        mov edi, dword [byte ecx+04h]
        push edi
        mov ebp, dword [ecx]
        push ebp
        push esi
        fstp dword [byte esp+0Ch]
        push dword [byte esp+0Ch]
        call DrawFlashSprite
.8:
        push dword 40000000h
        mov ecx, dword [FarSideModel]
        mov ebx, dword [CrowdCenter]
        shl ecx, 3
        mov eax, dword [dword ebx+080h]
        mov edx, dword [FarSideModel]
        add ecx, eax
        lea eax, [nosplit edx*4+00h]
        mov esi, dword [FarSideData]
        sub eax, edx
        mov edx, dword [byte ebx+07Ch]
        sub esp, byte 4
        fild dword [byte edx+eax*4+08h]
        fstp dword [esp]
        call ProjectCoord
        mov eax, dword [byte ecx+04h]
        push eax
        mov edx, dword [ecx]
        push edx
        push esi
        fstp dword [byte esp+010h]
        push dword [byte esp+010h]
        call DrawFlashSprite
        cmp dword [CameraFlashOn], byte 0
        jle short .9
        mov ebx, dword [NearSideParts]
        mov ecx, dword [CrowdCenter]
        shl ebx, 3
        mov eax, dword [dword ecx+080h]
        mov edx, dword [NearSideParts]
        add ebx, eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        push dword 40000000h
        lea edx, [nosplit eax*4+00h]
        mov esi, dword [NearSideModel]
        mov eax, dword [byte ecx+07Ch]
        sub esp, byte 4
        fild dword [byte edx+eax+08h]
        fstp dword [esp]
        call ProjectCoord
        mov ecx, dword [byte ebx+04h]
        push ecx
        mov edi, dword [ebx]
        push edi
        push esi
        fstp dword [byte esp+014h]
        push dword [byte esp+014h]
        call DrawFlashSprite
.9:
        cmp dword [GoalLightState], byte 0
        je short .10
        cmp dword [GoalCheerOn], byte 0
        jne short .10
        call DrawGoalLight
.10:
        mov edx, dword [RinkPartModels+100h]
        cmp edx, dword [BenchSideIndex]
        jg near .13
        cmp dword [CameraFlashOn], byte 0
        jg short .11
        push dword 40000000h
        mov esi, dword [FarSideData]
        mov ebx, dword [SideParts]
        mov edx, dword [CrowdCenter]
        shl ebx, 3
        mov eax, dword [dword edx+080h]
        mov ecx, dword [SideParts]
        add ebx, eax
        lea eax, [nosplit ecx*4+00h]
        mov edx, dword [byte edx+07Ch]
        sub eax, ecx
        sub esp, byte 4
        fild dword [byte edx+eax*4+08h]
        fstp dword [esp]
        call ProjectCoord
        mov ecx, dword [byte ebx+04h]
        push ecx
        mov edi, dword [ebx]
        push edi
        push esi
        fstp dword [byte esp+018h]
        push dword [byte esp+018h]
        call DrawFlashSprite
.11:
        push dword 40000000h
        mov ecx, dword [FarSideParts]
        mov ebx, dword [CrowdCenter]
        shl ecx, 3
        mov eax, dword [dword ebx+080h]
        mov edx, dword [FarSideParts]
        add ecx, eax
        lea eax, [nosplit edx*4+00h]
        mov esi, dword [NearSideModel]
        sub eax, edx
        mov edx, dword [byte ebx+07Ch]
        sub esp, byte 4
        fild dword [byte edx+eax*4+08h]
        fstp dword [esp]
        call ProjectCoord
        mov ebp, dword [byte ecx+04h]
        push ebp
        mov eax, dword [ecx]
        push eax
        push esi
        fstp dword [byte esp+01Ch]
        push dword [byte esp+01Ch]
        call DrawFlashSprite
        cmp dword [CameraFlashOn], byte 0
        jle short .12
        mov ecx, dword [SideParts]
        mov ebx, dword [CrowdCenter]
        shl ecx, 3
        mov eax, dword [dword ebx+080h]
        mov edx, dword [SideParts]
        add ecx, eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        push dword 40000000h
        lea edx, [nosplit eax*4+00h]
        mov esi, dword [FarSideData]
        mov eax, dword [byte ebx+07Ch]
        sub esp, byte 4
        fild dword [byte edx+eax+08h]
        fstp dword [esp]
        call ProjectCoord
        mov ebx, dword [byte ecx+04h]
        push ebx
        mov edi, dword [ecx]
        push edi
        push esi
        fstp dword [byte esp+020h]
        push dword [byte esp+020h]
        call DrawFlashSprite
.12:
        cmp dword [GoalLightState], byte 0
        je short .13
        cmp dword [GoalCheerOn], byte 0
        je short .13
        call DrawGoalLight
.13:
        cmp dword [ShowCenterLogo], byte 0
        je short .14
        push GlassRemap
        call SetRemapTable
        mov eax, dword [GlassParts]
        add esp, byte 4
        mov dword [RinkPartModels+1A8h], eax
        mov eax, 1
        call DrawBenchArea
.14:
        call DrawGlass
        mov eax, 1
        call DrawBoardsTop
        call DrawBenchDoors
        mov eax, 1
        call DrawBenchLines
        cmp dword [ShowCenterLogo], byte 0
        je short .15
        mov eax, 1
        call DrawPenaltyBox
.15:
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DrawFarSide                                     56464  97 PC, low confidence
; Draws the far side of the rink
;-----------------------------------------------------------------------------
DrawFarSide:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        call DrawBenches
        mov eax, dword [CameraFlashOn]
        cmp eax, dword [RinkPartModels+0F4h]
        jle short .1
        call DrawBenchSection
.1:
        mov ebx, dword [RinkPartModels+0FCh]
        cmp ebx, dword [CameraFlashOn]
        jle short .2
        call DrawBenchSide
.2:
        mov ecx, dword [RinkPartModels+090h]
        cmp ecx, dword [BenchSideIndex]
        jge near .5
        cmp dword [GoalLightState], byte 0
        je short .3
        cmp dword [GoalCheerOn], byte 0
        jne short .3
        call DrawGoalLight
.3:
        cmp dword [CameraFlashOn], byte 0
        jg short .4
        push dword 40000000h
        mov esi, dword [NearSideModel]
        mov ebx, dword [NearSideParts]
        mov edx, dword [CrowdCenter]
        shl ebx, 3
        mov eax, dword [dword edx+080h]
        mov ecx, dword [NearSideParts]
        add ebx, eax
        lea eax, [nosplit ecx*4+00h]
        mov edx, dword [byte edx+07Ch]
        sub eax, ecx
        sub esp, byte 4
        fild dword [byte edx+eax*4+08h]
        fstp dword [esp]
        call ProjectCoord
        mov eax, dword [byte ebx+04h]
        push eax
        mov edx, dword [ebx]
        push edx
        push esi
        fstp dword [byte esp+0Ch]
        push dword [byte esp+0Ch]
        call DrawFlashSprite
.4:
        push dword 40000000h
        mov edx, dword [FarSideModel]
        mov ecx, dword [CrowdCenter]
        shl edx, 3
        mov eax, dword [dword ecx+080h]
        mov ebx, dword [FarSideModel]
        add edx, eax
        lea eax, [nosplit ebx*4+00h]
        mov esi, dword [FarSideData]
        sub eax, ebx
        mov ebx, dword [byte ecx+07Ch]
        sub esp, byte 4
        fild dword [byte ebx+eax*4+08h]
        fstp dword [esp]
        call ProjectCoord
        mov ebx, dword [byte edx+04h]
        push ebx
        mov ecx, dword [edx]
        push ecx
        push esi
        fstp dword [byte esp+010h]
        push dword [byte esp+010h]
        call DrawFlashSprite
        cmp dword [CameraFlashOn], byte 0
        jle short .5
        push dword 40000000h
        mov ebx, dword [NearSideParts]
        mov ecx, dword [CrowdCenter]
        shl ebx, 3
        mov eax, dword [dword ecx+080h]
        mov edx, dword [NearSideParts]
        add ebx, eax
        lea eax, [nosplit edx*4+00h]
        mov esi, dword [NearSideModel]
        sub eax, edx
        mov edx, dword [byte ecx+07Ch]
        sub esp, byte 4
        fild dword [byte edx+eax*4+08h]
        fstp dword [esp]
        call ProjectCoord
        mov edi, dword [byte ebx+04h]
        push edi
        mov ebp, dword [ebx]
        push ebp
        push esi
        fstp dword [byte esp+014h]
        push dword [byte esp+014h]
        call DrawFlashSprite
.5:
        mov edx, dword [RinkPartModels+100h]
        cmp edx, dword [BenchSideIndex]
        jle near .8
        cmp dword [GoalLightState], byte 0
        je short .6
        cmp dword [GoalCheerOn], byte 0
        je short .6
        call DrawGoalLight
.6:
        cmp dword [CameraFlashOn], byte 0
        jg short .7
        push dword 40000000h
        mov esi, dword [FarSideData]
        mov ebx, dword [SideParts]
        mov edx, dword [CrowdCenter]
        shl ebx, 3
        mov eax, dword [dword edx+080h]
        mov ecx, dword [SideParts]
        add ebx, eax
        lea eax, [nosplit ecx*4+00h]
        mov edx, dword [byte edx+07Ch]
        sub eax, ecx
        sub esp, byte 4
        fild dword [byte edx+eax*4+08h]
        fstp dword [esp]
        call ProjectCoord
        mov edi, dword [byte ebx+04h]
        push edi
        mov ebp, dword [ebx]
        push ebp
        push esi
        fstp dword [byte esp+018h]
        push dword [byte esp+018h]
        call DrawFlashSprite
.7:
        push dword 40000000h
        mov ecx, dword [FarSideParts]
        mov ebx, dword [CrowdCenter]
        shl ecx, 3
        mov eax, dword [dword ebx+080h]
        mov edx, dword [FarSideParts]
        add ecx, eax
        lea eax, [nosplit edx*4+00h]
        mov esi, dword [NearSideModel]
        sub eax, edx
        mov edx, dword [byte ebx+07Ch]
        sub esp, byte 4
        fild dword [byte edx+eax*4+08h]
        fstp dword [esp]
        call ProjectCoord
        mov eax, dword [byte ecx+04h]
        push eax
        mov edx, dword [ecx]
        push edx
        push esi
        fstp dword [byte esp+01Ch]
        push dword [byte esp+01Ch]
        call DrawFlashSprite
        cmp dword [CameraFlashOn], byte 0
        jle short .8
        push dword 40000000h
        mov esi, dword [FarSideData]
        mov ecx, dword [SideParts]
        mov edx, dword [CrowdCenter]
        shl ecx, 3
        mov eax, dword [dword edx+080h]
        mov ebx, dword [SideParts]
        add ecx, eax
        lea eax, [nosplit ebx*4+00h]
        mov edx, dword [byte edx+07Ch]
        sub eax, ebx
        sub esp, byte 4
        fild dword [byte edx+eax*4+08h]
        fstp dword [esp]
        call ProjectCoord
        mov edi, dword [byte ecx+04h]
        push edi
        mov ebp, dword [ecx]
        push ebp
        push esi
        fstp dword [byte esp+020h]
        push dword [byte esp+020h]
        call DrawFlashSprite
.8:
        cmp dword [CameraScenesEnabled], byte 0
        je short .9
        mov edx, dword [RinkOverlayModel]
        push edx
        call DrawModel
        add esp, byte 4
.9:
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SaveViewOrigin                                  56740  97 PC, low confidence
; Saves the view origin
;-----------------------------------------------------------------------------
SaveViewOrigin:
        mov eax, dword [ClipLeft]
        sar eax, 10h
        shl eax, 10h
        mov dword [ViewHeight], eax
        mov eax, dword [ClipRightEdge]
        sar eax, 10h
        shl eax, 10h
        mov dword [ViewOriginX], eax
        mov eax, dword [ClipTop]
        sar eax, 10h
        shl eax, 10h
        mov dword [ViewWidth], eax
        mov eax, dword [ClipBottomEdge]
        sar eax, 10h
        shl eax, 10h
        mov dword [ViewOriginY], eax
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
UniformFontColors:                              ; used by LoadUniformArt
        db 0FFh,028h,028h,0FFh
UniformFontShadow:                              ; used by LoadUniformArt
        db 0FFh,0FFh,0FFh,0FFh
;-----------------------------------------------------------------------------
; ShapePixelSize                                  56798  97 PC, low confidence
; Returns the pixel size of a shape
;-----------------------------------------------------------------------------
ShapePixelSize:
        push edx
        mov edx, dword [byte eax+02h]
        mov eax, dword [byte eax+04h]
        sar edx, 10h
        sar eax, 10h
        imul eax, edx
        add eax, byte 10h
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DrawShadowShape                                 567B0  97 PC, low confidence
; Draws a shadow shape
;-----------------------------------------------------------------------------
DrawShadowShape:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 20h
        mov ebp, dword [byte esp+040h]
        mov edi, dword [byte esp+048h]
        mov eax, dword [byte esp+03Ch]
        mov ecx, dword [byte esp+038h]
        mov ebx, ebp
        mov edx, dword [byte esp+034h]
        sub ebx, ecx
        sub eax, edx
        mov edx, ebx
        sar edx, 2
        add ebx, edx
        push ebx
        push eax
        call AngleFromDelta
        add esp, byte 8
        mov ebx, eax
        lea ecx, [dword eax+0100h]
        shl ch, 7
        sbb edx, edx
        add ch, ch
        sbb ecx, ecx
        xor eax, ecx
        and eax, 0FFh
        sub eax, ecx
        mov eax, dword [nosplit eax*4+SinTable]
        xor eax, edx
        sub eax, edx
        mov edx, eax
        neg edx
        mov eax, edi
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov esi, eax
        mov eax, ebx
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
        mov edx, eax
        mov ebx, eax
        sar edx, 2
        sar eax, 4
        sub ebx, edx
        lea edx, [ebx+eax]
        mov eax, esi
        mov edi, dword [byte esp+034h]
        sar eax, 1
        mov ebx, edx
        add edi, eax
        sar ebx, 1
        mov dword [esp], edi
        mov edi, dword [byte esp+038h]
        add edi, ebx
        mov dword [byte esp+04h], edi
        mov edi, dword [byte esp+03Ch]
        sub esi, eax
        add edi, eax
        lea eax, [ebx+ebp]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte esp+03Ch]
        sub eax, esi
        mov dword [byte esp+010h], eax
        mov eax, dword [byte esp+034h]
        sub eax, esi
        sub edx, ebx
        mov dword [byte esp+018h], eax
        mov eax, dword [byte esp+038h]
        push byte 0
        sub eax, edx
        push byte 0
        mov dword [byte esp+024h], eax
        lea eax, [byte esp+08h]
        push eax
        push byte 4
        mov esi, dword [byte esp+054h]
        sub ebp, edx
        push esi
        mov dword [byte esp+01Ch], edi
        mov dword [byte esp+028h], ebp
        call FillPolygon
        add esp, byte 14h
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ModelViewDepth                                  568CC  97 PC, low confidence
; Works out the view depth of a model
;-----------------------------------------------------------------------------
ModelViewDepth:
        push ebx
        push edx
        sub esp, byte 1Ch
        mov ebx, esp
        mov edx, CameraStateRecords+7
        add eax, byte 3
        call VecSub
        lea ebx, [byte esp+0Ch]
        mov edx, CameraStateRecords+253h
        mov eax, esp
        call VecMulMat
        fld dword [byte esp+014h]
        call __CHP
        fistp dword [byte esp+018h]
        mov eax, dword [byte esp+018h]
        add esp, byte 1Ch
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawPortraitModels                              56908  97 PC, low confidence
; Draws the models for a portrait
;-----------------------------------------------------------------------------
DrawPortraitModels:
        push ebx
        push edx
        push esi
        push edi
        sub esp, byte 8
        movsx ebx, byte [byte eax+01h]
        mov edx, ebx
        shl edx, 4
        sub edx, ebx
        shl edx, 2
        sub edx, ebx
        shl edx, 5
        add edx, PortraitModels
        lea esi, [byte eax+03h]
        mov edi, edx
        movsd
        movsd
        movsd
        fld dword [byte edx+0Ch]
        fld st0
        fadd qword [F64_3p14159_DrawPortraitModels]
        mov eax, edx
        fstp st1
        fstp dword [byte edx+0Ch]
        call UpdateViewMatrix
        cmp dword [dword edx+0748h], byte 0
        je short .1
        mov eax, edx
        call DrawPlayersSorted
.1:
        fld dword [byte edx+0Ch]
        fadd qword [F64_neg3p14159_DrawPortraitModels]
        fstp dword [byte edx+0Ch]
        add esp, byte 8
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; AddSeatModel                                    5696C  97 PC, low confidence
; Adds a seat model
;-----------------------------------------------------------------------------
AddSeatModel:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, eax
        mov ebx, edx
        mov dl, byte [SeatModelCount]
        xor eax, eax
        xor ebp, ebp
        test dl, dl
        jne short .2
.1:
        add eax, byte 0Fh
        inc ebp
        cmp eax, byte 5Ah
        jge short .2
        cmp byte [dword eax+SeatModelCount], 0
        je short .1
.2:
        cmp ebp, byte 6
        jne short .3
        mov eax, 0FFFFFFFFh
        jmp short .4
.3:
        mov eax, ebp
        shl eax, 4
        mov edx, SeatModelCount
        sub eax, ebp
        mov ecx, DrawPortraitModels
        mov dword [esp], eax
        add edx, eax
        mov edi, eax
        push edx
        mov byte [dword eax+SeatModelTeam], bl
        xor bl, bl
        push byte 3
        mov byte [dword eax+SeatModelCount], bl
        add edx, byte 3
        lea edi, [dword edi+SeatModelList]
        mov ebx, ModelViewDepth
        mov eax, str_BOGIE
        movsd
        movsd
        movsd
        call AddModelName
        mov edx, dword [esp]
        mov byte [dword edx+SeatModelFlag], al
        movsx eax, al
        mov dword [nosplit ebp*4+SeatModelSlots], eax
        mov eax, ebp
.4:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FindSeatModel                                   56A08  97 PC, low confidence
; Finds a seat model
;-----------------------------------------------------------------------------
FindSeatModel:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        test eax, eax
        jl short .1
        cmp eax, byte 6
        jge short .1
        mov edx, eax
        shl edx, 4
        sub edx, eax
        cmp byte [dword edx+SeatModelCount], 0
        jne short .1
        mov byte [dword edx+SeatModelCount], 1
        mov eax, dword [dword edx+SeatModelBase]
        sar eax, 18h
        mov ch, 0FFh
        call FindModelName
        movsx eax, ch
        mov byte [dword edx+SeatModelFlag], ch
        mov dword [nosplit ebx*4+SeatModelSlots], eax
.1:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ecx
        push edx
        cmp dword [SeatModelsUsed], byte 0
        jne short .2
        push dword 138h
        push SeatModels
        push eax
        call bcopy
        add esp, byte 0Ch
        call RestoreSavedPalette
.2:
        mov dword [SeatModelsUsed], 1
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; PickMarkerShape                                 56A84  97 PC, low confidence
; Picks the marker shape
;-----------------------------------------------------------------------------
PickMarkerShape:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov edi, eax
        mov ebp, edx
        mov ebx, 1
        mov esi, dword [byte edx+04h]
        mov edx, dword [byte ebp+edi*8-04h]
        xor ecx, ecx
        sub esi, edx
        cmp eax, ebx
        jle short .2
        lea eax, [byte ebp+08h]
.1:
        mov edx, dword [byte eax+04h]
        sub edx, dword [byte eax-04h]
        xor esi, edx
        test esi, esi
        setl byte [esp]
        add eax, byte 8
        movzx esi, byte [esp]
        inc ebx
        add ecx, esi
        mov esi, edx
        cmp ebx, edi
        jl short .1
.2:
        mov eax, dword [byte ebp+04h]
        sub eax, dword [byte ebp+edi*8-04h]
        xor eax, esi
        test eax, eax
        setl al
        and eax, 0FFh
        add eax, ecx
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
