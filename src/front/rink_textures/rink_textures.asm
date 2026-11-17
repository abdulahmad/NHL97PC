; Rink textures: texture pages and tiles, ice textures, board ads and arena art.
bits 32
%include "hockey.inc"
section s_4C0CA progbits alloc exec nowrite align=1
extern AddArtToRange, AimOverlayModel, AllocOverlayModel, AllocOverlaySlot, ArenaArchive, ArenaArt, ArenaArtParts, ArenaArtSize
extern ArenaColorB, ArenaColorG, ArenaColorR, ArenaModel, ArenaPalette, ArenaPaletteRange, BindModelShapes, BoardAdArt
extern BoardAdModel, CreateModelInstance, DrawTilePage, DrawTileTexture, FindInstanceGroup, FindInstanceShape, FindShape, GetInstanceGroupEntry
extern IceTextures, LoadModelByName, LogosLoaded, memcpy_, ModelSlots, OpenArtArchiveErr, RinkPartModels, RinkTextureCount
extern RinkTextureDefs, RinkTextureInfo, RinkTexturePtrs, RinkTextureRows, RinkTextures, ServiceIdle, SetModelPartName, SetModelShape
extern SetOverlayCentre, SetOverlayPosition, SetRangeColors, sprintf_, str_0ice0, str_0ice1, str_0ice2, str_0ice3
extern str_C100, str_C200, str_C201, str_C210, str_C211, str_C300, str_C301, str_C302
extern str_C303, str_C310, str_C311, str_C312, str_C313, str_C320, str_C321, str_C322
extern str_C323, str_C330, str_C331, str_C332, str_C333, str_Center, str_Center02dFsh, str_Dice
extern str_Flatice, str_Ice0, str_Ice1, str_Ice2, str_Ice22, str_Ice3, str_Icepolys, str_Newice
extern str_Pal, str_Punct_DrawRinkSurface, TextureDetail, TexturePageBase, TextureTileSize, ViewScreenWidth
global LoadRinkTextures, BuildTexturePage, BuildTextureTile, SetTextureDetail, SetupIceTextures, SetupBoardAds, LoadArenaArt
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LoadRinkTextures                                4C0CC  97 PC, low confidence
; Loads the rink textures
;-----------------------------------------------------------------------------
LoadRinkTextures:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov esi, RinkTextureDefs
        xor ecx, ecx
.1:
        xor eax, eax
        call AllocOverlayModel
        mov edx, esi
        mov dword [dword ecx+RinkTextureInfo], eax
        call SetOverlayPosition
        mov edx, ModelSlots
        mov eax, dword [dword ecx+RinkTextureInfo]
        call AimOverlayModel
        mov eax, dword [dword ecx+RinkTextureInfo]
        add dword [byte eax+020h], 200h
        mov eax, dword [dword ecx+RinkTextureInfo]
        mov edi, dword [byte eax+01Ch]
        mov dword [dword ecx+RinkTexturePtrs], edi
        mov edi, dword [byte eax+020h]
        mov dword [dword ecx+RinkTextureRows], edi
        call AllocOverlaySlot
        mov dword [dword ecx+RinkTextures], eax
        mov eax, dword [ViewScreenWidth]
        mov edx, eax
        sar edx, 1Fh
        shl edx, 2
        LD sbb, eax, edx
        sar eax, 2
        add ecx, byte 4
        mov edi, dword [dword ecx+RinkTextureCount]
        mov ebx, eax
        mov edx, eax
        mov eax, edi
        add esi, byte 0Ch
        call SetOverlayCentre
        cmp ecx, byte 10h
        jne near .1
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; BuildTexturePage                                4C164  97 PC, low confidence
; Builds a texture page
;-----------------------------------------------------------------------------
BuildTexturePage:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 68h
        mov ebp, eax
        mov dword [byte esp+064h], ebx
        mov esi, dword [edx]
        mov ecx, dword [TexturePageBase]
        shl esi, 3
        lea edi, [byte esp+03Ch]
        add esi, ecx
        movsd
        movsd
        mov ebx, dword [edx]
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        mov ebx, dword [TextureDetail]
        shl eax, 2
        mov edi, esp
        lea esi, [ebx+eax]
        movsd
        movsd
        movsd
        mov esi, dword [byte edx+04h]
        shl esi, 3
        lea edi, [byte esp+044h]
        add esi, ecx
        movsd
        movsd
        mov esi, dword [byte edx+04h]
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 2
        lea edi, [byte esp+0Ch]
        lea esi, [ebx+eax]
        movsd
        movsd
        movsd
        mov esi, dword [byte edx+08h]
        shl esi, 3
        lea edi, [byte esp+04Ch]
        add esi, ecx
        movsd
        movsd
        mov esi, dword [byte edx+08h]
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 2
        lea edi, [byte esp+018h]
        lea esi, [ebx+eax]
        add edx, byte 4
        movsd
        movsd
        movsd
        mov esi, dword [byte edx+08h]
        add edx, byte 4
        shl esi, 3
        lea edi, [byte esp+054h]
        add esi, ecx
        add edx, byte 4
        movsd
        movsd
        mov edx, dword [edx]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, dword [byte esp+064h]
        shl eax, 2
        push edx
        lea esi, [ebx+eax]
        lea eax, [byte esp+04h]
        push eax
        lea eax, [byte esp+044h]
        push eax
        lea edi, [byte esp+030h]
        push ebp
        movsd
        movsd
        movsd
        call DrawTilePage
        add esp, byte 10h
        add esp, byte 68h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; BuildTextureTile                                4C240  97 PC, low confidence
; Builds one texture tile
;-----------------------------------------------------------------------------
BuildTextureTile:
        push esi
        push edi
        push ebp
        sub esp, 10Ch
        mov dword [dword esp+0100h], eax
        mov dword [dword esp+0FCh], edx
        mov esi, ebx
        xor edx, edx
        mov dword [dword esp+0108h], edx
        test eax, eax
        jle near .2
        mov ebx, 10h
        mov edi, dword [dword esp+0120h]
        mov edx, esi
        xor ebp, ebp
        xor eax, eax
        mov dword [dword esp+0104h], ebp
        sub ebx, edi
        mov ebp, ecx
.1:
        mov esi, dword [byte ebp+00h]
        mov ecx, dword [TexturePageBase]
        shl esi, 3
        lea edi, [dword esp+eax+0B4h]
        add esi, ecx
        movsd
        movsd
        imul ecx, dword [byte ebp+00h], byte 0Ch
        mov edi, dword [dword esp+0104h]
        mov esi, dword [TextureDetail]
        lea edi, [esp+edi]
        add esi, ecx
        movsd
        movsd
        movsd
        mov ecx, dword [edx]
        mov esi, dword [TextureTileSize]
        shl ecx, 3
        add esi, ecx
        mov cl, bl
        mov esi, dword [esi]
        add eax, byte 8
        shl esi, cl
        add edx, byte 4
        mov dword [byte esp+eax+064h], esi
        add ebp, byte 4
        mov ecx, dword [byte edx-04h]
        mov esi, dword [TextureTileSize]
        shl ecx, 3
        mov edi, dword [dword esp+0104h]
        add esi, ecx
        add edi, byte 0Ch
        mov cl, bl
        mov esi, dword [byte esi+04h]
        mov dword [dword esp+0104h], edi
        shl esi, cl
        mov ecx, dword [dword esp+0108h]
        mov dword [byte esp+eax+068h], esi
        inc ecx
        mov esi, dword [dword esp+0100h]
        mov dword [dword esp+0108h], ecx
        cmp ecx, esi
        jl near .1
.2:
        mov eax, dword [dword esp+011Ch]
        push eax
        lea eax, [byte esp+04h]
        push eax
        lea eax, [dword esp+0BCh]
        push eax
        lea eax, [byte esp+078h]
        push eax
        mov edx, dword [dword esp+0110h]
        push edx
        mov ebx, dword [dword esp+0110h]
        push ebx
        call DrawTileTexture
        add esp, byte 18h
        add esp, 10Ch
        pop ebp
        pop edi
        pop esi
        ret 8
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetTextureDetail                                4C360  97 PC, low confidence
; Sets the texture detail level
;-----------------------------------------------------------------------------
SetTextureDetail:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov ebx, eax
        mov eax, edx
        mov edx, dword [byte eax+ebx*4-04h]
        mov ecx, dword [TexturePageBase]
        shl edx, 3
        add edx, ecx
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        mov dword [byte esp+08h], ecx
        mov dword [byte esp+04h], edx
        xor edx, edx
.1:
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je short .3
        imul edi, dword [eax], byte 0Ch
        mov esi, dword [TexturePageBase]
        mov ecx, dword [eax]
        mov dword [esp], edi
        shl ecx, 3
        mov ebp, dword [esp]
        mov edi, dword [TextureDetail]
        add ecx, esi
        add edi, ebp
        mov esi, dword [ecx]
        mov ebp, dword [str_Punct_DrawRinkSurface]
        mov edi, dword [byte edi+08h]
        mov ecx, dword [byte ecx+04h]
        cmp edi, ebp
        jg short .2
        mov edi, 9C40h
        jmp short .5
.2:
        mov edi, dword [byte esp+04h]
        imul edi, esi
        add edx, edi
        mov edi, dword [byte esp+08h]
        imul edi, ecx
        add eax, byte 4
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+08h], esi
        sub edx, edi
        jmp short .1
.3:
        mov eax, edx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        test eax, eax
        jge short .4
        neg eax
.4:
        mov edi, eax
.5:
        mov eax, edi
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetupIceTextures                                4C404  97 PC, low confidence
; Sets up the ice textures
;-----------------------------------------------------------------------------
SetupIceTextures:
        push ebx
        push ecx
        push esi
        mov ebx, edx
        mov eax, dword [edx]
        shl eax, 8
        shr eax, 18h
        mov esi, IceTextures
        shl eax, 4
        add esi, eax
        mov eax, dword [edx]
        mov ecx, dword [byte edx+08h]
        and eax, byte 7
        mov edx, ecx
        call SetTextureDetail
        cmp eax, 1000h
        jle short .1
        xor eax, eax
        jmp short .4
.1:
        cmp eax, 400h
        jle short .2
        mov eax, 1
        jmp short .4
.2:
        cmp eax, 100h
        jle short .3
        mov eax, 2
        jmp short .4
.3:
        mov eax, 3
.4:
        mov dl, byte [byte ebx+01h]
        mov esi, dword [esi+eax*4]
        test dl, 10h
        je short .5
        push eax
        mov edx, dword [byte ebx+0Ch]
        mov eax, dword [ebx]
        push byte 0FFFFFFFFh
        and eax, byte 7
        mov ebx, edx
        mov edx, esi
        call BuildTextureTile
        jmp short .6
.5:
        mov ebx, 0FFFFFFFFh
        mov edx, ecx
        mov eax, esi
        call BuildTexturePage
.6:
        xor eax, eax
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetupBoardAds                                   4C48C  97 PC, low confidence
; Sets up the board advertisement textures
;-----------------------------------------------------------------------------
SetupBoardAds:
        push ebx
        push ecx
        push esi
        mov esi, edx
        mov eax, dword [edx]
        mov ecx, dword [byte edx+08h]
        and eax, byte 7
        mov edx, ecx
        call SetTextureDetail
        cmp eax, 1000h
        jge short .1
        mov ebx, 0FFFFFFFFh
        mov eax, dword [BoardAdArt]
        mov edx, ecx
        call BuildTexturePage
        jmp short .5
.1:
        cmp eax, 4000h
        jge short .3
        mov ecx, 4
        add esi, byte 10h
.2:
        mov ebx, 0FFFFFFFFh
        mov edx, dword [byte esi+08h]
        mov eax, dword [dword ecx+BoardAdArt]
        call BuildTexturePage
        add ecx, byte 4
        add esi, byte 10h
        cmp ecx, byte 14h
        je short .5
        jmp short .2
.3:
        mov ecx, 14h
        add esi, byte 50h
.4:
        mov ebx, 0FFFFFFFFh
        mov edx, dword [byte esi+08h]
        mov eax, dword [dword ecx+BoardAdArt]
        call BuildTexturePage
        add ecx, byte 4
        add esi, byte 10h
        cmp ecx, byte 54h
        jne short .4
.5:
        xor eax, eax
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        push esi
        push edi
        mov esi, eax
        mov edi, edx
        push eax
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push esi
        mov ecx, dword [ArenaModel]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        mov dword [nosplit edi*4+BoardAdArt], eax
        call SetModelShape
        add esp, byte 0Ch
        mov eax, ebx
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        push esi
        mov esi, edx
        push eax
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push esi
        mov ecx, dword [BoardAdModel]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        call SetModelShape
        add esp, byte 0Ch
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadArenaArt                                    4C5A0  97 PC, low confidence
; Loads the arena art and palette ranges
;-----------------------------------------------------------------------------
LoadArenaArt:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov dword [byte esp+0Ch], eax
        call ServiceIdle
        mov edx, dword [LogosLoaded]
        test edx, edx
        je short .1
        mov eax, str_Ice2
        xor edx, edx
        jmp short .2
.1:
        mov eax, str_Flatice
.2:
        call LoadModelByName
        mov dword [RinkPartModels+148h], eax
        call ServiceIdle
        push byte 0
        push str_Ice2
        call OpenArtArchiveErr
        add esp, byte 8
        mov dword [BoardAdModel], eax
        call ServiceIdle
        push str_Pal
        mov ebx, dword [BoardAdModel]
        push ebx
        call FindShape
        add esp, byte 8
        lea edx, [byte eax+010h]
        mov ebx, 18h
        mov eax, ArenaPalette
        call memcpy_
        mov ebx, 4
        mov eax, dword [RinkPartModels+148h]
        xor edx, edx
        call CreateModelInstance
        mov ecx, dword [BoardAdModel]
        push ecx
        push eax
        mov dword [RinkPartModels+1ACh], eax
        call BindModelShapes
        mov eax, dword [RinkPartModels+1ACh]
        mov dl, byte [byte eax+010h]
        and dl, 0FDh
        add esp, byte 8
        mov byte [byte eax+010h], dl
        push str_0ice0
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        call FindInstanceShape
        add esp, byte 8
        push str_Ice0
        mov edi, dword [BoardAdModel]
        push edi
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov ebp, dword [RinkPartModels+1ACh]
        push ebp
        call SetModelShape
        add esp, byte 0Ch
        push str_0ice1
        mov eax, dword [RinkPartModels+1ACh]
        push eax
        call FindInstanceShape
        add esp, byte 8
        push str_Ice1
        mov edx, dword [BoardAdModel]
        push edx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov ebx, dword [RinkPartModels+1ACh]
        push ebx
        call SetModelShape
        add esp, byte 0Ch
        push str_0ice2
        mov ecx, dword [RinkPartModels+1ACh]
        push ecx
        call FindInstanceShape
        add esp, byte 8
        push str_Ice22
        mov esi, dword [BoardAdModel]
        push esi
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov edi, dword [RinkPartModels+1ACh]
        push edi
        call SetModelShape
        add esp, byte 0Ch
        push str_0ice3
        mov ebp, dword [RinkPartModels+1ACh]
        push ebp
        call FindInstanceShape
        add esp, byte 8
        push str_Ice3
        mov ebx, eax
        mov eax, dword [BoardAdModel]
        push eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call SetModelShape
        add esp, byte 0Ch
        push str_Newice
        mov ebx, dword [RinkPartModels+1ACh]
        push ebx
        call FindInstanceShape
        mov ebx, eax
        shl eax, 2
        mov edx, dword [RinkPartModels+1ACh]
        add eax, ebx
        mov ebx, dword [byte edx+014h]
        add esp, byte 8
        mov bl, byte [byte ebx+eax*4+02h]
        and ebx, 0FFh
        mov dword [RinkPartModels+24h], ebx
        mov ebx, dword [byte edx+014h]
        mov bl, byte [byte ebx+eax*4+01h]
        and ebx, 0FFh
        mov dword [RinkPartModels+1Ch], ebx
        mov edx, dword [byte edx+014h]
        mov al, byte [edx+eax*4]
        and eax, 0FFh
        mov dword [RinkPartModels+20h], eax
        xor eax, eax
.3:
        add eax, byte 3
        mov dl, byte [RinkPartModels+24h]
        mov byte [dword eax+ArenaColorR], dl
        mov dl, byte [RinkPartModels+1Ch]
        mov byte [dword eax+ArenaColorG], dl
        mov dl, byte [RinkPartModels+20h]
        mov byte [dword eax+ArenaColorB], dl
        cmp eax, byte 18h
        jne short .3
        mov edx, ArenaPaletteRange
        mov eax, dword [ArenaArt]
        call SetRangeColors
        push str_Icepolys
        mov ecx, dword [RinkPartModels+1ACh]
        push ecx
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+118h
        push RinkPartModels+0F0h
        push eax
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        call GetInstanceGroupEntry
        mov edi, dword [LogosLoaded]
        add esp, byte 10h
        test edi, edi
        je short .4
        push str_Center
        mov ebp, dword [RinkPartModels+1ACh]
        push ebp
        call FindInstanceGroup
        add esp, byte 8
        push RinkPartModels+10Ch
        push RinkPartModels+104h
        push eax
        mov eax, dword [RinkPartModels+1ACh]
        push eax
        call GetInstanceGroupEntry
        add esp, byte 10h
.4:
        xor edi, edi
.5:
        push edi
        push str_Dice
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call FindInstanceShape
        add esp, byte 8
        mov dword [byte esp+010h], eax
        test eax, eax
        jl short .7
        mov esi, eax
        xor ebx, ebx
        shl esi, 4
.6:
        mov al, bl
        add al, 30h
        mov byte [byte esp+04h], al
        mov eax, esp
        push eax
        mov ecx, dword [RinkPartModels+1ACh]
        xor dh, dh
        push ecx
        mov byte [byte esp+0Dh], dh
        call FindInstanceShape
        imul ecx, eax, byte 14h
        mov edx, dword [RinkPartModels+1ACh]
        mov eax, dword [byte edx+014h]
        add esi, byte 4
        inc ebx
        mov eax, dword [byte ecx+eax+0Ch]
        add esp, byte 8
        mov dword [dword esi+ArenaArtSize], eax
        cmp ebx, byte 4
        jl short .6
        push SetupIceTextures
        mov esi, dword [byte esp+014h]
        push esi
        push edx
        inc edi
        call SetModelPartName
        add esp, byte 0Ch
        cmp edi, byte 0Ah
        jl near .5
.7:
        mov edi, dword [LogosLoaded]
        test edi, edi
        je near .8
        mov eax, dword [byte esp+0Ch]
        push eax
        push str_Center02dFsh
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        call ServiceIdle
        push byte 0
        lea eax, [byte esp+04h]
        push eax
        call OpenArtArchiveErr
        add esp, byte 8
        push byte 0
        push byte 20h
        push byte 8
        push str_Pal
        push eax
        mov dword [ArenaModel], eax
        call FindShape
        mov ebx, dword [ArenaModel]
        add esp, byte 8
        lea ecx, [byte eax+010h]
        mov edx, dword [ArenaArchive]
        mov eax, str_Center
        call AddArtToRange
        push str_C100
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push str_C100
        mov ecx, dword [ArenaModel]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        mov dword [BoardAdArt], eax
        call SetModelShape
        add esp, byte 0Ch
        push SetupBoardAds
        push ebx
        mov edi, dword [RinkPartModels+1ACh]
        push edi
        call SetModelPartName
        add esp, byte 0Ch
        push str_C200
        mov ebp, dword [RinkPartModels+1ACh]
        push ebp
        call FindInstanceShape
        add esp, byte 8
        push str_C200
        mov ebx, eax
        mov eax, dword [ArenaModel]
        push eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        mov dword [ArenaArtParts], eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C201
        mov ebx, dword [RinkPartModels+1ACh]
        push ebx
        call FindInstanceShape
        add esp, byte 8
        push str_C201
        mov ecx, dword [ArenaModel]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        mov dword [ArenaArtParts+4], eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C210
        mov edi, dword [RinkPartModels+1ACh]
        push edi
        call FindInstanceShape
        add esp, byte 8
        push str_C210
        mov ebp, dword [ArenaModel]
        push ebp
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov dword [ArenaArtParts+8], eax
        mov eax, dword [RinkPartModels+1ACh]
        push eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C211
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push str_C211
        mov ecx, dword [ArenaModel]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        mov dword [ArenaArtParts+0Ch], eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C300
        mov edi, dword [RinkPartModels+1ACh]
        push edi
        call FindInstanceShape
        add esp, byte 8
        push str_C300
        mov ebp, dword [ArenaModel]
        push ebp
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov dword [ArenaArtParts+10h], eax
        mov eax, dword [RinkPartModels+1ACh]
        push eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C301
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push str_C301
        mov ecx, dword [ArenaModel]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        mov dword [ArenaArtParts+14h], eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C302
        mov edi, dword [RinkPartModels+1ACh]
        push edi
        call FindInstanceShape
        add esp, byte 8
        push str_C302
        mov ebp, dword [ArenaModel]
        push ebp
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov dword [ArenaArtParts+18h], eax
        mov eax, dword [RinkPartModels+1ACh]
        push eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C303
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push str_C303
        mov ecx, dword [ArenaModel]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        mov dword [ArenaArtParts+1Ch], eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C310
        mov edi, dword [RinkPartModels+1ACh]
        push edi
        call FindInstanceShape
        add esp, byte 8
        push str_C310
        mov ebp, dword [ArenaModel]
        push ebp
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov dword [ArenaArtParts+20h], eax
        mov eax, dword [RinkPartModels+1ACh]
        push eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C311
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push str_C311
        mov ecx, dword [ArenaModel]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        mov dword [ArenaArtParts+24h], eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C312
        mov edi, dword [RinkPartModels+1ACh]
        push edi
        call FindInstanceShape
        add esp, byte 8
        push str_C312
        mov ebp, dword [ArenaModel]
        push ebp
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov dword [ArenaArtParts+28h], eax
        mov eax, dword [RinkPartModels+1ACh]
        push eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C313
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push str_C313
        mov ecx, dword [ArenaModel]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        mov dword [ArenaArtParts+2Ch], eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C320
        mov edi, dword [RinkPartModels+1ACh]
        push edi
        call FindInstanceShape
        add esp, byte 8
        push str_C320
        mov ebp, dword [ArenaModel]
        push ebp
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov dword [ArenaArtParts+30h], eax
        mov eax, dword [RinkPartModels+1ACh]
        push eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C321
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push str_C321
        mov ecx, dword [ArenaModel]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        mov dword [ArenaArtParts+34h], eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C322
        mov edi, dword [RinkPartModels+1ACh]
        push edi
        call FindInstanceShape
        add esp, byte 8
        push str_C322
        mov ebp, dword [ArenaModel]
        push ebp
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov dword [ArenaArtParts+38h], eax
        mov eax, dword [RinkPartModels+1ACh]
        push eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C323
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push str_C323
        mov ecx, dword [ArenaModel]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        mov dword [ArenaArtParts+3Ch], eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C330
        mov edi, dword [RinkPartModels+1ACh]
        push edi
        call FindInstanceShape
        add esp, byte 8
        push str_C330
        mov ebp, dword [ArenaModel]
        push ebp
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov dword [ArenaArtParts+40h], eax
        mov eax, dword [RinkPartModels+1ACh]
        push eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C331
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push str_C331
        mov ecx, dword [ArenaModel]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        mov dword [ArenaArtParts+44h], eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C332
        mov edi, dword [RinkPartModels+1ACh]
        push edi
        call FindInstanceShape
        add esp, byte 8
        push str_C332
        mov ebp, dword [ArenaModel]
        push ebp
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov dword [ArenaArtParts+48h], eax
        mov eax, dword [RinkPartModels+1ACh]
        push eax
        call SetModelShape
        add esp, byte 0Ch
        push str_C333
        mov edx, dword [RinkPartModels+1ACh]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push str_C333
        mov ecx, dword [ArenaModel]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        push eax
        push ebx
        mov esi, dword [RinkPartModels+1ACh]
        push esi
        mov dword [ArenaArtParts+4Ch], eax
        call SetModelShape
        add esp, byte 0Ch
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.8:
        mov dword [ArenaModel], edi
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
