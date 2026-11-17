; Camera debug view and AI icons.
bits 32
%include "hockey.inc"
section s_776F6 progbits alloc exec nowrite align=1
extern AiIconArt, AiIconCount, AiIconSize, CameraDebugArt, CameraDebugLoaded, CameraStateRecords, CreateModelInstance, DrawModel
extern DrawTextAt, FillRect, FillRectColor, FloatsToInts, FreeModelFile, FreeModelInstance, InitModelInstance, LoadModelByName
extern MatMul, MatRotY, memcpy_, OpenResourceArchive, ProjectPoints, SetArtArchive, str_AiconsViv, str_Cross
extern TransformTranslateVecs, UpdateModelInstance, UpdateModelPart, VecMulMat, VecScale, VecSub
global BuildCameraDebugView, DrawCameraPath, LoadAiIcons, FreeCameraDebug
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; BuildCameraDebugView                            776F8  97 PC, low confidence
; Builds the camera debug view
;-----------------------------------------------------------------------------
BuildCameraDebugView:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, 2E0h
        mov esi, eax
        mov eax, dword [byte eax+04h]
        lea ebx, [nosplit eax*4+00h]
        mov edx, dword [byte esi+074h]
        sub ebx, eax
        mov eax, esp
        shl ebx, 2
        call memcpy_
        mov edx, dword [byte esi+04h]
        xor ebx, ebx
        test edx, edx
        jle short .2
        mov edx, esp
.1:
        push edx
        mov eax, edx
        push dword [dword esp+0304h]
        inc ebx
        call VecScale
        mov ecx, dword [byte esi+04h]
        add edx, byte 0Ch
        cmp ebx, ecx
        jl short .1
.2:
        mov edi, dword [dword esp+0304h]
        push edi
        push byte 0
        push esi
        lea ebx, [dword esp+02D4h]
        call UpdateModelPart
        add esp, byte 0Ch
        mov edx, CameraStateRecords+7
        mov eax, dword [dword esp+02FCh]
        call VecSub
        lea ebx, [dword esp+02D4h]
        mov edx, CameraStateRecords+253h
        lea eax, [dword esp+02C8h]
        call VecMulMat
        cmp dword [dword esp+02DCh], 43480000h
        jl near .3
        push dword [dword esp+02F8h]
        lea eax, [dword esp+02A8h]
        lea ebx, [dword esp+0284h]
        mov edx, CameraStateRecords+253h
        call MatRotY
        lea eax, [dword esp+02A4h]
        call MatMul
        lea eax, [dword esp+01E0h]
        lea ecx, [dword esp+02D4h]
        push eax
        lea eax, [dword esp+0F4h]
        lea ebx, [dword esp+0284h]
        push eax
        lea edx, [byte esp+08h]
        mov eax, dword [byte esi+04h]
        call TransformTranslateVecs
        mov eax, dword [byte esi+04h]
        lea edx, [nosplit eax*4+00h]
        sub edx, eax
        mov ebx, dword [byte esi+07Ch]
        mov eax, edx
        lea edx, [dword esp+0F0h]
        call FloatsToInts
        lea edx, [dword esp+01E0h]
        mov eax, dword [byte esi+04h]
        mov ebx, dword [dword esi+080h]
        add eax, eax
        call FloatsToInts
        push esi
        call DrawModel
        add esp, byte 4
.3:
        add esp, 2E0h
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 10h
        db 090h
;-----------------------------------------------------------------------------
; DrawCameraPath                                  77838  97 PC, low confidence
; Draws the camera path (debug)
;-----------------------------------------------------------------------------
DrawCameraPath:
        push ebx
        push edx
        mov edx, dword [byte esp+018h]
        push edx
        mov ebx, dword [byte esp+014h]
        push dword [byte esp+018h]
        push ebx
        mov eax, dword [CameraDebugArt]
        push dword [byte esp+018h]
        call BuildCameraDebugView
        pop edx
        pop ebx
        ret 10h
        db 090h
        push ebx
        push edx
        mov edx, dword [byte esp+018h]
        push edx
        mov ebx, dword [byte esp+014h]
        push dword [byte esp+018h]
        push ebx
        mov eax, dword [AiIconCount]
        push dword [byte esp+018h]
        call BuildCameraDebugView
        pop edx
        pop ebx
        ret 10h
        db 090h
        push ebx
        push edx
        mov edx, dword [byte esp+018h]
        push edx
        mov ebx, dword [byte esp+014h]
        push dword [byte esp+018h]
        push ebx
        mov eax, dword [AiIconSize]
        push dword [byte esp+018h]
        call BuildCameraDebugView
        pop edx
        pop ebx
        ret 10h
        db 090h
        push ebx
        push edx
        mov edx, dword [byte esp+018h]
        push edx
        mov ebx, dword [byte esp+014h]
        push dword [byte esp+018h]
        push ebx
        mov eax, dword [AiIconArt]
        push dword [byte esp+018h]
        call BuildCameraDebugView
        pop edx
        pop ebx
        ret 10h
        db 090h
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 34h
        mov ecx, edx
        mov esi, ebx
        mov ebx, esp
        mov edx, CameraStateRecords+7
        call VecSub
        lea ebx, [byte esp+0Ch]
        mov edx, CameraStateRecords+253h
        mov eax, esp
        call VecMulMat
        mov ebx, esp
        mov edx, CameraStateRecords+7
        mov eax, ecx
        call VecSub
        lea ebx, [byte esp+018h]
        mov edx, CameraStateRecords+253h
        mov eax, esp
        call VecMulMat
        cmp dword [byte esp+014h], 42C80000h
        jl short .1
        cmp dword [byte esp+020h], 42C80000h
        jl short .1
        lea ebx, [byte esp+024h]
        lea edx, [byte esp+0Ch]
        mov eax, 1
        call ProjectPoints
        lea ebx, [byte esp+02Ch]
        lea edx, [byte esp+018h]
        mov eax, 1
        call ProjectPoints
        push esi
        mov ecx, dword [byte esp+034h]
        push ecx
        mov esi, dword [byte esp+034h]
        push esi
        mov edi, dword [byte esp+034h]
        push edi
        mov ebp, dword [byte esp+034h]
        push ebp
        call FillRectColor
        add esp, byte 14h
.1:
        add esp, byte 34h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push esi
        sub esp, byte 20h
        mov ecx, edx
        mov ebx, esp
        mov edx, CameraStateRecords+7
        call VecSub
        lea ebx, [byte esp+0Ch]
        mov edx, CameraStateRecords+253h
        mov eax, esp
        call VecMulMat
        cmp dword [byte esp+014h], 42C80000h
        jl short .2
        lea ebx, [byte esp+018h]
        lea edx, [byte esp+0Ch]
        mov eax, 1
        call ProjectPoints
        mov ebx, dword [byte esp+01Ch]
        push ebx
        mov esi, dword [byte esp+01Ch]
        push esi
        push ecx
        call DrawTextAt
        add esp, byte 0Ch
.2:
        add esp, byte 20h
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LoadAiIcons                                     779C8  97 PC, low confidence
; Loads the "cross" icon shapes from aicons.viv
;-----------------------------------------------------------------------------
LoadAiIcons:
        push ebx
        push ecx
        push edx
        mov eax, str_AiconsViv
        call SetArtArchive
        xor edx, edx
        mov eax, str_Cross
        call LoadModelByName
        push eax
        mov ebx, 8
        mov dword [CameraDebugLoaded], eax
        call InitModelInstance
        add esp, byte 4
        mov eax, dword [CameraDebugLoaded]
        xor edx, edx
        call CreateModelInstance
        push eax
        mov dword [CameraDebugArt], eax
        call UpdateModelInstance
        add esp, byte 4
        mov eax, dword [CameraDebugArt]
        push byte 0
        mov dword [AiIconArt], eax
        mov dword [AiIconSize], eax
        mov dword [AiIconCount], eax
        call OpenResourceArchive
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FreeCameraDebug                                 77A30  97 PC, low confidence
; Frees the camera debug view
;-----------------------------------------------------------------------------
FreeCameraDebug:
        push ebx
        push ecx
        push edx
        mov edx, dword [CameraDebugLoaded]
        push edx
        call FreeModelFile
        add esp, byte 4
        mov ebx, dword [CameraDebugArt]
        push ebx
        call FreeModelInstance
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        push ebx
        push esi
        push edi
        mov edx, dword [byte esp+020h]
        push edx
        mov ebx, dword [byte esp+020h]
        push ebx
        mov ecx, dword [byte esp+020h]
        push ecx
        mov esi, dword [byte esp+020h]
        push esi
        mov edi, dword [byte esp+020h]
        push edi
        call FillRect
        add esp, byte 14h
        pop edi
        pop esi
        pop ebx
        ret
