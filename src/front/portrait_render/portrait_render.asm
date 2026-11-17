; Off-screen rendering and the portrait camera.
bits 32
%include "hockey.inc"
section s_5CCDE progbits alloc exec nowrite align=1
extern __CHP, AllocMemBlock, BytesPerPixelForDepth, CreateBitmapForArt, DrawSpriteScaledFlip, F32_4096, F32_464, F32_65536_BeginOffscreenRender
extern F32_65536_SetPortraitProjection, F64_1p25, FillMem, FreeBitmap, OffscreenAspect, OffscreenFar, OffscreenFov, OffscreenNear
extern OffscreenState, OffscreenTarget, PaletteDirtyFlag, PerspectiveScale, PortraitCamera, ProjAspect, ProjDetailScale, ProjOffsetX
extern ProjOffsetY, RestoreDrawContext, SaveDrawContext, SetClipWindow, SetDrawTarget, SpriteBuffersOn, str_RSPRITE
global AllocSpriteBuffers, MarkPaletteDirty, BeginOffscreenRender, SavePortraitCamera, RestorePortraitCamera, EndOffscreenRender, SetPortraitProjection
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AllocSpriteBuffers                              5CCE0  97 PC, low confidence
; Allocates the "RSPRITE" block (0C240h): 12 sprite buffers of 1010h bytes
;-----------------------------------------------------------------------------
AllocSpriteBuffers:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push byte 0
        push dword 0C240h
        push str_RSPRITE
        xor esi, esi
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [PaletteDirtyFlag], eax
        lea edi, [dword eax+0180h]
.1:
        mov ebx, dword [PaletteDirtyFlag]
        mov dword [byte esi+ebx+01Ch], edi
        mov edx, dword [edi]
        and edx, 0FFh
        push byte 8
        mov dword [edi], edx
        call BytesPerPixelForDepth
        mov edx, eax
        mov eax, dword [byte esi+ebx+01Ch]
        mov byte [eax], 0
        mov eax, dword [byte esi+ebx+01Ch]
        and edx, 0FFh
        mov ecx, dword [eax]
        add esi, byte 20h
        or ecx, edx
        add edi, 1010h
        mov dword [eax], ecx
        add esp, byte 4
        mov dword [byte esi+ebx-08h], 0FFFFFFFFh
        cmp esi, 180h
        jne short .1
        mov dword [SpriteBuffersOn], 1
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; MarkPaletteDirty                                5CD68  97 PC, low confidence
; Marks the palette for reloading
;-----------------------------------------------------------------------------
MarkPaletteDirty:
        push edx
        cmp dword [SpriteBuffersOn], byte 0
        je short .2
        xor eax, eax
.1:
        mov edx, dword [PaletteDirtyFlag]
        add eax, byte 20h
        mov dword [byte edx+eax-08h], 0FFFFFFFFh
        cmp eax, 180h
        jne short .1
.2:
        pop edx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; BeginOffscreenRender                            5CD90  97 PC, low confidence
; Switches drawing to an offscreen bitmap
;-----------------------------------------------------------------------------
BeginOffscreenRender:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov ebx, dword [byte esp+04Ch]
        mov edi, dword [byte esp+050h]
        mov esi, eax
        fld dword [ProjOffsetY]
        fld dword [ProjOffsetX]
        fld dword [ProjDetailScale]
        mov eax, dword [edx]
        fld dword [ProjAspect]
        mov dword [byte esp+08h], eax
        mov eax, dword [byte edx+04h]
        fxch st3
        fstp dword [OffscreenFov]
        fxch
        fstp dword [OffscreenAspect]
        fstp dword [OffscreenNear]
        fstp dword [OffscreenFar]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [edi]
        mov dword [byte esp+01Ch], eax
        mov dword [byte esp+028h], eax
        mov eax, dword [byte edi+04h]
        mov ecx, 1
        mov dword [byte esp+018h], eax
        mov dword [byte esp+024h], eax
        cmp ebx, ecx
        jle short .6
        lea edx, [byte edi+08h]
.1:
        fld dword [edx]
        fcomp dword [byte esp+01Ch]
        fnstsw ax
        sahf
        jbe short .2
        mov eax, dword [edx]
        mov dword [byte esp+01Ch], eax
        jmp short .3
.2:
        fld dword [edx]
        fcomp dword [byte esp+028h]
        fnstsw ax
        sahf
        jae short .3
        mov eax, dword [edx]
        mov dword [byte esp+028h], eax
.3:
        fld dword [byte edx+04h]
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        jbe short .4
        mov eax, dword [byte edx+04h]
        mov dword [byte esp+018h], eax
        jmp short .5
.4:
        fld dword [byte edx+04h]
        fcomp dword [byte esp+024h]
        fnstsw ax
        sahf
        jae short .5
        mov eax, dword [byte edx+04h]
        mov dword [byte esp+024h], eax
.5:
        inc ecx
        add edx, byte 8
        cmp ecx, ebx
        jl short .1
.6:
        fld dword [byte esp+018h]
        fld dword [byte esp+01Ch]
        fsub dword [byte esp+028h]
        fxch
        fsub dword [byte esp+024h]
        fld1
        fld1
        fxch
        faddp st3
        faddp
        fxch
        call __CHP
        fxch
        call __CHP
        fxch
        fistp dword [byte esp+014h]
        fistp dword [byte esp+010h]
        mov eax, dword [byte esp+014h]
        mov edx, dword [byte esp+010h]
        imul eax, edx
        mov dword [byte esp+04h], eax
        cmp eax, 1000h
        jle short .7
        fild dword [byte esp+04h]
        fdivr dword [F32_4096]
        fsqrt
        fild dword [byte esp+014h]
        fld st0
        fxch st2
        fstp dword [byte esp+020h]
        fxch
        fmul dword [byte esp+020h]
        fild dword [byte esp+010h]
        fld st0
        fmul dword [byte esp+020h]
        mov ecx, 1
        fxch st2
        fstp st3
        fxch
        fstp st1
        fxch
        call __CHP
        fxch
        call __CHP
        fxch
        fistp dword [byte esp+014h]
        fistp dword [byte esp+010h]
        jmp short .8
.7:
        xor ecx, ecx
.8:
        mov edx, dword [byte esi+01Ch]
        mov eax, dword [byte esp+014h]
        mov word [byte edx+04h], ax
        mov edx, dword [byte esi+01Ch]
        mov eax, dword [byte esp+010h]
        mov word [byte edx+06h], ax
        xor edx, edx
        test ebx, ebx
        jle short .10
        fld dword [byte esp+024h]
        fld dword [byte esp+028h]
        mov eax, edi
.9:
        fld dword [eax]
        fld dword [byte eax+04h]
        add eax, byte 8
        inc edx
        fxch
        fsub st2
        fxch
        fsub st3
        fxch
        fstp dword [byte eax-08h]
        fstp dword [byte eax-04h]
        cmp edx, ebx
        jl short .9
        fstp st0
        fstp st0
.10:
        fild dword [byte esp+08h]
        fild dword [byte esp+0Ch]
        fld dword [ProjOffsetY]
        fld dword [ProjOffsetX]
        fld st3
        fld st3
        fxch st3
        fld dword [byte esp+028h]
        fxch
        fsub st1
        fxch st3
        fsub dword [byte esp+024h]
        fxch st3
        fstp dword [ProjOffsetY]
        fxch st2
        fstp dword [ProjOffsetX]
        fsubrp
        fxch
        fsub dword [byte esp+024h]
        fxch
        fstp st3
        fstp st1
        fxch
        call __CHP
        fxch
        call __CHP
        fxch
        fistp dword [byte esp+08h]
        fistp dword [byte esp+0Ch]
        test ecx, ecx
        je near .13
        fld dword [byte esp+020h]
        fld dword [ProjDetailScale]
        fmul st1
        fld dword [ProjAspect]
        fmul st2
        fld dword [ProjOffsetY]
        fmul st3
        fld dword [ProjOffsetX]
        fmulp st4
        xor edx, edx
        fxch
        fstp dword [ProjAspect]
        fstp dword [ProjOffsetY]
        fxch
        fstp dword [ProjOffsetX]
        fstp dword [ProjDetailScale]
        test ebx, ebx
        jle short .12
        fld dword [byte esp+020h]
        mov eax, edi
.11:
        fld dword [eax]
        fmul st1
        fld dword [byte eax+04h]
        fmul st2
        add eax, byte 8
        inc edx
        fxch
        fstp dword [byte eax-08h]
        fstp dword [byte eax-04h]
        cmp edx, ebx
        jl short .11
        fstp st0
.12:
        fild dword [byte esp+08h]
        fld st0
        fld dword [byte esp+020h]
        fxch
        fmul st1
        fild dword [byte esp+0Ch]
        fmul to st2
        push dword [byte esp+048h]
        fxch
        fstp st3
        fxch
        fstp st1
        fxch
        call __CHP
        fxch
        call __CHP
        fxch
        fistp dword [byte esp+0Ch]
        fistp dword [byte esp+010h]
        call PerspectiveScale
        fstp dword [esi]
        mov dword [byte esi+04h], 4B18967Fh
        jmp short .14
.13:
        push dword [byte esp+048h]
        call PerspectiveScale
        fst dword [esi]
        fmul qword [F64_1p25]
        fstp dword [byte esi+04h]
.14:
        push byte 20h
        mov edi, dword [byte esi+01Ch]
        push edi
        call CreateBitmapForArt
        add esp, byte 8
        push OffscreenState
        mov dword [OffscreenTarget], eax
        call SaveDrawContext
        add esp, byte 4
        mov ebp, dword [OffscreenTarget]
        push ebp
        call SetDrawTarget
        add esp, byte 4
        mov eax, dword [byte esp+010h]
        push eax
        push byte 0
        mov edx, dword [byte esp+01Ch]
        push edx
        push byte 0
        call SetClipWindow
        add esp, byte 10h
        mov eax, dword [byte esp+014h]
        imul eax, dword [byte esp+010h]
        push dword 0FFh
        push eax
        mov eax, dword [byte esi+01Ch]
        add eax, byte 10h
        push eax
        call FillMem
        add esp, byte 0Ch
        fild dword [byte esp+014h]
        fdivr dword [F32_464]
        mov edx, dword [byte esi+01Ch]
        mov eax, dword [byte esp+08h]
        mov word [byte edx+08h], ax
        mov eax, dword [byte esp+0Ch]
        mov edx, dword [byte esi+01Ch]
        fmul dword [F32_65536_BeginOffscreenRender]
        mov word [byte edx+0Ah], ax
        push eax
        fistp dword [esp]
        pop eax
        mov dword [byte esi+010h], eax
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 0Ch
        db 090h
;-----------------------------------------------------------------------------
; SavePortraitCamera                              5D100  97 PC, low confidence
; Saves the camera before a portrait render
;-----------------------------------------------------------------------------
SavePortraitCamera:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov ebp, eax
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], ebx
        mov edx, dword [PaletteDirtyFlag]
        xor ebx, ebx
.1:
        cmp ebp, dword [byte edx+018h]
        jne short .4
        mov eax, dword [byte esp+08h]
        sub eax, dword [byte edx+08h]
        test eax, eax
        jge short .2
        neg eax
.2:
        mov esi, eax
        cmp eax, 648h
        jg short .4
        mov eax, dword [byte esp+0Ch]
        sub eax, dword [byte edx+0Ch]
        test eax, eax
        jge short .3
        neg eax
.3:
        mov edi, eax
        cmp eax, 648h
        jg short .4
        fld dword [byte esp+024h]
        fcomp dword [byte edx+04h]
        fnstsw ax
        sahf
        jbe short .5
.4:
        inc ebx
        add edx, byte 20h
        cmp ebx, byte 0Ch
        jl short .1
        xor eax, eax
        jmp near .12
.5:
        mov dword [esp], edx
        cmp ebx, byte 0Ch
        jge short .11
.6:
        cmp ebp, dword [byte edx+018h]
        jne short .10
        mov eax, dword [byte esp+08h]
        sub eax, dword [byte edx+08h]
        test eax, eax
        jge short .7
        neg eax
.7:
        mov dword [byte esp+04h], eax
        cmp eax, esi
        jg short .10
        mov eax, dword [byte esp+0Ch]
        sub eax, dword [byte edx+0Ch]
        test eax, eax
        jge short .8
        mov ecx, eax
        neg ecx
        jmp short .9
.8:
        mov ecx, eax
.9:
        cmp ecx, edi
        jg short .10
        fld dword [byte esp+024h]
        fcomp dword [byte edx+04h]
        fnstsw ax
        sahf
        ja short .10
        mov esi, dword [byte esp+04h]
        mov edi, ecx
        mov dword [esp], edx
.10:
        inc ebx
        add edx, byte 20h
        cmp ebx, byte 0Ch
        jl short .6
.11:
        mov eax, dword [PortraitCamera]
        lea edx, [byte eax+01h]
        mov dword [PortraitCamera], edx
        mov edx, dword [esp]
        mov dword [byte edx+014h], eax
        mov eax, edx
.12:
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret 4
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; RestorePortraitCamera                           5D1E0  97 PC, low confidence
; Restores the camera after a portrait render
;-----------------------------------------------------------------------------
RestorePortraitCamera:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov dword [esp], eax
        mov edi, edx
        mov esi, ebx
        mov eax, dword [PaletteDirtyFlag]
        mov edx, 1
        mov ecx, eax
        mov ebx, dword [byte eax+014h]
        add eax, byte 20h
.1:
        mov ebp, dword [byte eax+014h]
        cmp ebx, ebp
        jle short .2
        mov ecx, eax
        mov ebx, ebp
.2:
        inc edx
        add eax, byte 20h
        cmp edx, byte 0Ch
        jl short .1
        mov eax, dword [PortraitCamera]
        lea edx, [byte eax+01h]
        mov dword [PortraitCamera], edx
        mov dword [byte ecx+014h], eax
        mov dword [byte ecx+08h], edi
        mov dword [byte ecx+0Ch], esi
        mov eax, dword [esp]
        mov dword [byte ecx+018h], eax
        mov eax, ecx
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; EndOffscreenRender                              5D23C  97 PC, low confidence
; Switches drawing back to the screen
;-----------------------------------------------------------------------------
EndOffscreenRender:
        push ecx
        push edx
        fld dword [OffscreenFov]
        fld dword [OffscreenAspect]
        fld dword [OffscreenNear]
        fld dword [OffscreenFar]
        mov edx, dword [OffscreenTarget]
        fxch st3
        fstp dword [ProjOffsetY]
        fxch
        fstp dword [ProjOffsetX]
        fstp dword [ProjDetailScale]
        push edx
        fstp dword [ProjAspect]
        call FreeBitmap
        add esp, byte 4
        push OffscreenState
        call RestoreDrawContext
        add esp, byte 4
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetPortraitProjection                           5D294  97 PC, low confidence
; Sets the projection used for portraits
;-----------------------------------------------------------------------------
SetPortraitProjection:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebx, eax
        push dword [byte esp+01Ch]
        call PerspectiveScale
        push dword [byte esp+01Ch]
        fstp dword [byte esp+04h]
        call PerspectiveScale
        fdiv dword [ebx]
        fmul dword [F32_65536_SetPortraitProjection]
        push eax
        fistp dword [esp]
        pop eax
        cmp eax, dword [byte ebx+010h]
        jg short .1
        mov esi, dword [byte edx+04h]
        push esi
        mov edi, dword [edx]
        push edi
        mov ebp, dword [byte ebx+01Ch]
        push ebp
        push eax
        call DrawSpriteScaledFlip
        add esp, byte 10h
.1:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 4
