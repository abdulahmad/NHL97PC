; Stands detail and the camera flashes in the crowd.
bits 32
%include "hockey.inc"
section s_4BD09 progbits alloc exec nowrite align=1
extern AddVec3, CameraCosYaw, CameraFlags, CameraFlashOn, CameraSinYaw, DrawSpriteScaled, F32_1p0_View, FlashModel
extern FlashPolys, FlashSpotPos, FlashSpots, FlashSpotTable, FlashSpotTime, FlashTimer, ProjectCoord, Random32
extern ScaleVec3, StandsDetail, StandsDetailLevel, str_D_ProjectPointsPersp, str_Punct_DrawRinkSurface, SubVec3, TransformVecFull, ViewCenterY
extern ViewOriginY, ViewWidth
global SetStandsClip, SetStandsDetail, PickFlashSpot, StartCameraFlash, UpdateCameraFlashes, DrawFlashSprite, DrawCameraFlashes, TriggerCameraFlashes
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetStandsClip                                   4BD0C  97 PC, low confidence
; Sets the clip for drawing the stands
;-----------------------------------------------------------------------------
SetStandsClip:
        push ebx
        push ecx
        push esi
        push edi
        mov ecx, eax
        mov eax, edx
        xor edx, edx
        test ecx, ecx
        jle short .3
        mov esi, dword [str_Punct_DrawRinkSurface]
.1:
        cmp esi, dword [byte eax+08h]
        jge short .2
        mov ebx, dword [byte eax+04h]
        mov edi, dword [byte eax+08h]
        neg ebx
        cmp ebx, edi
        jge short .2
        xor ebx, ebx
        jmp short .4
.2:
        inc edx
        add eax, byte 0Ch
        cmp edx, ecx
        jl short .1
.3:
        mov ebx, 1
.4:
        mov eax, ebx
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetStandsDetail                                 4BD4C  97 PC, low confidence
; Sets the detail level for drawing the stands
;-----------------------------------------------------------------------------
SetStandsDetail:
        push ecx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov ecx, edx
        mov eax, ebx
        xor edx, edx
        test esi, esi
        jle short .3
        mov ebp, dword [ViewOriginY]
        mov ebx, ecx
.1:
        mov edi, dword [str_Punct_DrawRinkSurface]
        cmp edi, dword [byte ebx+08h]
        jge short .2
        mov ecx, dword [byte eax+04h]
        cmp ecx, ebp
        jge short .2
        cmp ecx, dword [ViewWidth]
        jl short .2
        xor ecx, ecx
        jmp short .4
.2:
        add ebx, byte 0Ch
        inc edx
        add eax, byte 8
        cmp edx, esi
        jl short .1
.3:
        mov ecx, 1
.4:
        mov eax, ecx
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
        push ebx
        push edx
        mov ebx, 1
        xor edx, edx
        xor eax, eax
        mov dword [StandsDetail], edx
.5:
        add eax, byte 14h
        mov dword [dword eax+StandsDetailLevel], ebx
        cmp eax, 190h
        jne short .5
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PickFlashSpot                                   4BDC0  97 PC, low confidence
; Picks a spot in the stands for a camera flash
;-----------------------------------------------------------------------------
PickFlashSpot:
        push ebx
        push edx
        push esi
        mov ebx, dword [FlashSpotTable]
        xor eax, eax
        xor edx, edx
        test ebx, ebx
        jne short .2
.1:
        add eax, byte 14h
        inc edx
        cmp eax, 190h
        jge short .2
        cmp dword [dword eax+FlashSpotTable], byte 0
        je short .1
.2:
        cmp edx, byte 14h
        jne short .3
        xor eax, eax
        pop esi
        pop edx
        pop ebx
        ret
.3:
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        shl eax, 2
        xor esi, esi
        mov dword [dword eax+FlashSpotTable], esi
        mov dword [dword eax+FlashSpotTime], esi
        add eax, FlashSpotPos
        pop esi
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; StartCameraFlash                                4BE14  97 PC, low confidence
; Starts a camera flash in the stands
;-----------------------------------------------------------------------------
StartCameraFlash:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 54h
        mov ebx, eax
        mov ebp, edx
        mov edx, ebx
        xor eax, eax
.1:
        imul esi, dword [edx], byte 0Ch
        mov ebx, dword [FlashSpots]
        mov ebx, dword [byte ebx+074h]
        lea edi, [esp+eax]
        add esi, ebx
        add eax, byte 0Ch
        add edx, byte 4
        movsd
        movsd
        movsd
        cmp eax, byte 30h
        jne short .1
        call Random32
        mov ebx, 9999h
        xor edx, edx
        div ebx
        lea eax, [byte esp+03Ch]
        push eax
        lea eax, [byte esp+04Ch]
        push eax
        lea ebx, [dword edx+03333h]
        push ebx
        push eax
        lea eax, [byte esp+010h]
        push eax
        lea eax, [byte esp+020h]
        push eax
        call SubVec3
        add esp, byte 0Ch
        push eax
        call ScaleVec3
        add esp, byte 0Ch
        push eax
        lea eax, [byte esp+08h]
        push eax
        call AddVec3
        add esp, byte 0Ch
        lea eax, [byte esp+030h]
        push eax
        lea eax, [byte esp+04Ch]
        push eax
        push ebx
        push eax
        lea eax, [byte esp+034h]
        push eax
        lea eax, [byte esp+02Ch]
        push eax
        call SubVec3
        add esp, byte 0Ch
        push eax
        call ScaleVec3
        add esp, byte 0Ch
        push eax
        lea eax, [byte esp+02Ch]
        push eax
        call AddVec3
        add esp, byte 0Ch
        mov ebx, 9999h
        call Random32
        xor edx, edx
        div ebx
        push ebp
        lea eax, [byte esp+04Ch]
        push eax
        lea ebx, [dword edx+03333h]
        push ebx
        push eax
        lea eax, [byte esp+04Ch]
        push eax
        lea eax, [byte esp+044h]
        push eax
        call SubVec3
        add esp, byte 0Ch
        push eax
        call ScaleVec3
        add esp, byte 0Ch
        push eax
        lea eax, [byte esp+044h]
        push eax
        call AddVec3
        add esp, byte 0Ch
        add esp, byte 54h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; UpdateCameraFlashes                             4BF10  97 PC, low confidence
; Starts random camera flashes in the stands
;-----------------------------------------------------------------------------
UpdateCameraFlashes:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        cmp dword [StandsDetail], byte 0
        je short .1
        cmp dword [FlashTimer], byte 0
        jne short .1
        call Random32
        mov esi, dword [StandsDetail]
        and eax, 0FFFFh
        cmp eax, esi
        jae short .1
        call PickFlashSpot
        test eax, eax
        je short .1
        mov edx, eax
        mov eax, ebx
        call StartCameraFlash
.1:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawFlashSprite                                 4BF54  97 PC, low confidence
; Draws one camera flash
;-----------------------------------------------------------------------------
DrawFlashSprite:
        push ebx
        push ecx
        push edx
        mov edx, dword [byte esp+014h]
        fild word [byte edx+06h]
        mov ebx, dword [byte esp+01Ch]
        mov ecx, dword [byte esp+018h]
        push ebx
        fmul dword [byte esp+014h]
        push ecx
        fmul dword [F32_1p0_View]
        push edx
        push eax
        fistp dword [esp]
        pop eax
        fild word [byte edx+04h]
        fmul dword [byte esp+01Ch]
        push eax
        push eax
        fistp dword [esp]
        pop eax
        push eax
        call DrawSpriteScaled
        add esp, byte 14h
        pop edx
        pop ecx
        pop ebx
        ret 10h
;-----------------------------------------------------------------------------
; DrawCameraFlashes                               4BF94  97 PC, low confidence
; Draws the camera flashes in the stands
;-----------------------------------------------------------------------------
DrawCameraFlashes:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 24h
        mov ebx, eax
        mov eax, esp
        push eax
        push CameraFlashOn
        push ebx
        call SubVec3
        add esp, byte 0Ch
        lea eax, [byte esp+0Ch]
        push eax
        push FlashPolys
        lea eax, [byte esp+08h]
        push eax
        call TransformVecFull
        mov edx, dword [byte ebx+0Ch]
        add esp, byte 0Ch
        test edx, edx
        jle short .1
        mov dword [byte ebx+010h], 1
.1:
        mov eax, dword [byte ebx+0Ch]
        lea esi, [nosplit eax*4+00h]
        inc eax
        mov dword [byte ebx+0Ch], eax
        mov eax, dword [byte esp+014h]
        mov ecx, dword [str_Punct_DrawRinkSurface]
        mov ebx, dword [dword esi+FlashModel]
        cmp eax, ecx
        jle near .4
        push dword 41200000h
        fild dword [byte esp+018h]
        sub esp, byte 4
        lea edi, [byte esp+020h]
        fstp dword [esp]
        lea esi, [byte esp+014h]
        call ProjectCoord
        fstp dword [byte esp+020h]
        cmp dword [byte esi+08h], byte 0
        jle short .2
        mov eax, dword [esi]
        imul dword [CameraSinYaw]
        idiv dword [byte esi+08h]
        add eax, dword [ViewCenterY]
        mov dword [edi], eax
        mov eax, dword [byte esi+04h]
        imul dword [CameraCosYaw]
        idiv dword [byte esi+08h]
        add eax, dword [str_D_ProjectPointsPersp]
        mov dword [byte edi+04h], eax
        jmp short .3
.2:
        mov dword [edi], 80000000h
        mov dword [byte edi+04h], 80000000h
        or dword [CameraFlags], byte 1
.3:
        fild word [byte ebx+06h]
        mov esi, dword [byte esp+01Ch]
        mov edi, dword [byte esp+018h]
        push esi
        fmul dword [byte esp+024h]
        push edi
        fmul dword [F32_1p0_View]
        push ebx
        push eax
        fistp dword [esp]
        pop eax
        fild word [byte ebx+04h]
        fmul dword [byte esp+02Ch]
        push eax
        push eax
        fistp dword [esp]
        pop eax
        push eax
        call DrawSpriteScaled
        add esp, byte 14h
.4:
        add esp, byte 24h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push edx
        xor edx, edx
.5:
        cmp dword [dword edx+FlashSpotTable], byte 0
        jne short .6
        mov eax, edx
        add eax, FlashSpotPos
        call DrawCameraFlashes
.6:
        add edx, byte 14h
        cmp edx, 190h
        jne short .5
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; TriggerCameraFlashes                            4C0C4  97 PC, low confidence
; Turns on the camera flashes (goals, celebrations)
;-----------------------------------------------------------------------------
TriggerCameraFlashes:
        mov dword [StandsDetail], eax
        ret
