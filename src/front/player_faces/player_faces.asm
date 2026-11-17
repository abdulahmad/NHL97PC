; Player faces: face textures and face art.
bits 32
%include "hockey.inc"
section s_5B557 progbits alloc exec nowrite align=1
extern AttachModelFrame, AwayFaceSwap, AwayFaceTextures, BuildFaceTextures, CreateModelInstance, F32_65536_LoadFaceTexture, FaceArtCount, FaceTextureCount
extern FindInstanceShape, FindShape, FreeMemBlock, FreeModelFile, FreeModelInstance, HomeFaceSwap, HomeFaceTextures, InitModelInstance
extern LoadModelByName, memcpy_, ModelFileCount, ObjectPositions, OpenArtArchive, OpenArtArchiveErr, OpenResourceArchive, PlayerArtTables
extern PlayerModels, ServiceIdle, SetArtArchive, SetModelShape, SetModelShapeWith, str_FAC, str_Fac00000, str_Face2
extern str_Face3, str_Facepal, str_FacesViv, str_Pal2, strcpy_
global UpdateFaceTextures, LoadFaceTexture, FindChunkByIndex, LoadFaceArt, FreeFaceTextures, SwapFaceTexture, LoadPlayerFace
        db 090h
;-----------------------------------------------------------------------------
; UpdateFaceTextures                              5B558  97 PC, low confidence
; Updates the face textures of the players on screen
;-----------------------------------------------------------------------------
UpdateFaceTextures:
        push ebx
        push ecx
        mov ecx, eax
        mov ebx, edx
        shl eax, 4
        sub eax, ecx
        shl eax, 2
        sub eax, ecx
        shl eax, 5
        add eax, ObjectPositions
        mov dword [byte eax+028h], edx
        cmp dword [byte eax+034h], byte 0
        je short .1
        mov ebx, 1
        mov edx, dword [dword eax+0700h]
        mov eax, ecx
        call BuildFaceTextures
        pop ecx
        pop ebx
        ret
.1:
        test ebx, ebx
        je short .2
        mov dword [dword eax+06C0h], PlayerArtTables+8Ch
        pop ecx
        pop ebx
        ret
.2:
        mov dword [dword eax+06C0h], PlayerArtTables+24h
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h
        push ecx
.3:
        dec eax
        cmp eax, byte 0FFFFFFFFh
        je short .4
        fld dword [edx]
        add edx, byte 8
        fstp dword [ebx]
        add ebx, byte 0Ch
        mov ecx, dword [byte edx-04h]
        mov dword [byte ebx-08h], ecx
        jmp short .3
.4:
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LoadFaceTexture                                 5B5CC  97 PC, low confidence
; Loads one player's face texture
;-----------------------------------------------------------------------------
LoadFaceTexture:
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 18h
        mov dword [byte ebp-010h], eax
        mov dword [byte ebp-08h], edx
        mov dword [byte ebp-04h], ebx
        mov dword [byte ebp-0Ch], ecx
        xor esi, esi
        test edx, edx
        jle short .4
        mov edi, dword [byte ebp-04h]
        mov ebx, dword [byte ebp+010h]
.1:
        fld dword [ebx]
        fmul dword [F32_65536_LoadFaceTexture]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [byte ebp-018h], eax
        fld dword [byte ebx+04h]
        fmul dword [F32_65536_LoadFaceTexture]
        push eax
        fistp dword [esp]
        pop eax
        mov dword [byte ebp-014h], eax
        lea eax, [byte ebp-018h]
        mov ecx, dword [byte ebp-04h]
        push eax
        test ecx, ecx
        je short .2
        mov eax, dword [edi]
        jmp short .3
.2:
        mov eax, esi
.3:
        push eax
        mov ecx, dword [byte ebp-0Ch]
        push ecx
        mov eax, dword [byte ebp-010h]
        add ebx, byte 8
        push eax
        add edi, byte 4
        inc esi
        call SetModelShapeWith
        mov edx, dword [byte ebp-08h]
        add esp, byte 10h
        cmp esi, edx
        jl short .1
.4:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FindChunkByIndex                                5B648  97 PC, low confidence
; Walks a chunked block to the chunk with the given index
;-----------------------------------------------------------------------------
FindChunkByIndex:
        mov ebx, dword [eax]
        sar ebx, 8
        test ebx, ebx
        je short .1
        dec edx
        add eax, ebx
        test edx, edx
        jne short FindChunkByIndex
        add eax, byte 8
        ret
.1:
        xor eax, eax
        ret
        db 090h
;-----------------------------------------------------------------------------
; LoadFaceArt                                     5B660  97 PC, low confidence
; Loads faces.viv: the face palette and the face2 shape set
;-----------------------------------------------------------------------------
LoadFaceArt:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov edx, 1
        mov eax, str_FacesViv
        mov ebp, dword [ModelFileCount]
        mov dword [ModelFileCount], edx
        call SetArtArchive
        push byte 0
        push str_Facepal
        call OpenArtArchiveErr
        add esp, byte 8
        mov edi, eax
        call ServiceIdle
        push str_Pal2
        push edi
        call FindShape
        add esp, byte 8
        lea edx, [byte eax+010h]
        mov ebx, 300h
        mov eax, PlayerModels
        call memcpy_
        push edi
        call FreeMemBlock
        add esp, byte 4
        mov eax, str_Face2
        xor edx, edx
        call LoadModelByName
        mov dword [FaceTextureCount], eax
        call ServiceIdle
        mov ebx, dword [FaceTextureCount]
        push ebx
        call InitModelInstance
        add esp, byte 4
        test esi, esi
        je short .1
        mov eax, dword [FaceTextureCount]
        mov edx, esi
        call AttachModelFrame
.1:
        xor ecx, ecx
        mov esi, 0Bh
        xor edi, edi
.2:
        mov eax, dword [FaceTextureCount]
        mov ebx, esi
        mov edx, edi
        add ecx, byte 4
        call CreateModelInstance
        mov dword [dword ecx+FaceArtCount], eax
        cmp ecx, byte 34h
        jne short .2
        push byte 0
        mov dword [ModelFileCount], ebp
        call OpenResourceArchive
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FreeFaceTextures                                5B734  97 PC, low confidence
; Frees the loaded face textures
;-----------------------------------------------------------------------------
FreeFaceTextures:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        xor ebx, ebx
.1:
        mov edx, dword [dword ebx+HomeFaceTextures]
        push edx
        call FreeModelInstance
        add esp, byte 4
        xor ecx, ecx
        mov esi, dword [dword ebx+AwayFaceTextures]
        mov dword [dword ebx+HomeFaceTextures], ecx
        test esi, esi
        je short .2
        push esi
        call FreeMemBlock
        xor ebp, ebp
        add esp, byte 4
        mov dword [dword ebx+AwayFaceTextures], ebp
.2:
        add ebx, byte 4
        cmp ebx, byte 34h
        jne short .1
        mov eax, dword [FaceTextureCount]
        push eax
        call FreeModelFile
        add esp, byte 4
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SwapFaceTexture                                 5B78C  97 PC, low confidence
; Swaps a player's face texture for another
;-----------------------------------------------------------------------------
SwapFaceTexture:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, eax
        mov edi, edx
        mov ebp, dword [byte eax+08h]
        mov dword [esp], ebp
        lea ebp, [nosplit ebx*4+00h]
        mov dword [byte eax+08h], 2
        mov edx, dword [dword ebp+AwayFaceSwap]
        mov ecx, edi
        push edx
        xor ebx, ebx
        mov edx, 6
        call LoadFaceTexture
        mov ebx, dword [dword ebp+HomeFaceSwap]
        push ebx
        push edi
        push esi
        call SetModelShape
        add esp, byte 0Ch
        mov ebx, dword [esp]
        mov dword [byte esi+08h], ebx
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LoadPlayerFace                                  5B7E0  97 PC, low confidence
; (slot, name): loads one player's face shape ("FAC" + name, fallback
; fac00000)
;-----------------------------------------------------------------------------
LoadPlayerFace:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 20h
        mov dword [byte esp+018h], eax
        mov edi, edx
        lea edx, [nosplit eax*4+00h]
        mov ebp, dword [FaceTextureCount]
        mov eax, str_FacesViv
        mov ebp, dword [byte ebp+014h]
        mov esi, dword [dword edx+HomeFaceTextures]
        call SetArtArchive
        mov ecx, dword [dword edx+AwayFaceTextures]
        test ecx, ecx
        je short .1
        push ecx
        call FreeMemBlock
        add esp, byte 4
.1:
        mov edx, str_FAC
        mov eax, esp
        call strcpy_
        lea eax, [byte esp+03h]
        mov edx, edi
        call strcpy_
        push byte 0
        lea eax, [byte esp+04h]
        push eax
        call OpenArtArchive
        add esp, byte 8
        mov dword [byte esp+01Ch], eax
        test eax, eax
        jne short .2
        push eax
        push str_Fac00000
        call OpenArtArchiveErr
        add esp, byte 8
        mov dword [byte esp+01Ch], eax
.2:
        push str_Face3
        mov edx, dword [byte esp+020h]
        push edx
        call FindShape
        mov edi, eax
        add esp, byte 8
        mov dword [ebx], eax
        mov edx, dword [byte esp+018h]
        push str_Face3
        shl edx, 2
        push esi
        mov dword [dword edx+HomeFaceSwap], eax
        mov eax, dword [byte esp+024h]
        mov dword [byte esp+01Ch], edx
        mov dword [dword edx+AwayFaceTextures], eax
        call FindInstanceShape
        mov dword [byte esp+018h], eax
        add esp, byte 8
        push edi
        push eax
        push esi
        mov ebx, ebp
        call SetModelShape
        add esp, byte 0Ch
        mov edx, 2
        mov eax, edi
        call FindChunkByIndex
        mov ecx, dword [byte esp+010h]
        push eax
        mov edx, ebp
        xor ebx, ebx
        mov eax, esi
        call LoadFaceTexture
        mov ebx, 6
        mov edx, 1
        mov eax, edi
        call FindChunkByIndex
        mov edx, dword [byte esp+014h]
        mov dword [dword edx+AwayFaceSwap], eax
        mov dword [byte eax+04h], 0
        mov eax, dword [dword edx+AwayFaceSwap]
        lea ebx, [nosplit ebp*4+00h]
        mov dword [byte eax+0Ch], 0
        sub ebx, ebp
        mov edx, dword [FaceTextureCount]
        shl ebx, 2
        mov eax, dword [byte esi+070h]
        mov edx, dword [byte edx+018h]
        call memcpy_
        mov ebx, dword [esi]
        mov edx, 3
        mov eax, edi
        mov ebx, dword [byte ebx+010h]
        call FindChunkByIndex
        mov ebx, dword [esi]
        mov edi, dword [byte esi+070h]
        mov edx, eax
        mov eax, edi
        mov ebx, dword [byte ebx+010h]
.3:
        dec ebx
        cmp ebx, byte 0FFFFFFFFh
        je short .4
        fld dword [edx]
        add edx, byte 8
        fstp dword [eax]
        add eax, byte 0Ch
        mov ecx, dword [byte edx-04h]
        mov dword [byte eax-08h], ecx
        jmp short .3
.4:
        push byte 0
        call OpenResourceArchive
        add esp, byte 4
        mov eax, esi
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
