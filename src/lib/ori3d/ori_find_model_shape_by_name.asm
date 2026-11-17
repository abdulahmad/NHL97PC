; 3D library: FindModelShapeByName, FindInstanceShape, BindModelShapes, UpdateModelInstance and 4 more.
bits 32
%include "hockey.inc"
section s_10FB49 progbits alloc exec nowrite align=1
extern FindShapeQuiet, GetModelVertex, GetPaletteEntries, MatchColor, ModelPartName, strncpy_, strnicmp_, TransformModelParts
extern TransformModelPartsWith, UpdateModelParts
global FindModelShapeByName, FindInstanceShape, BindModelShapes, UpdateModelInstance, UpdateModelPart, SetModelShape, SetModelShapeWith, SetModelPartName
        db 00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; FindModelShapeByName                           10FB50  97 PC, low confidence
; Model library: finds a shape of a model by name
;-----------------------------------------------------------------------------
FindModelShapeByName:
        push ebx
        push esi
        push edi
        push ebp
        mov ebp, dword [byte esp+014h]
        mov edi, dword [byte esp+018h]
        mov edx, dword [byte ebp+038h]
        mov ecx, dword [byte ebp+03Ch]
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
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.2:
        inc esi
        mov ebx, dword [byte ebp+038h]
        add ecx, byte 18h
        cmp esi, ebx
        jl short .1
.3:
        mov eax, 0FFFFFFFFh
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FindInstanceShape                              10FB98  97 PC, low confidence
; Model library: finds a shape of a model instance by name
;-----------------------------------------------------------------------------
FindInstanceShape:
        mov edx, dword [byte esp+08h]
        mov eax, dword [byte esp+04h]
        push edx
        mov eax, dword [eax]
        push eax
        call FindModelShapeByName
        add esp, byte 8
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; BindModelShapes                                10FBB0  97 PC, low confidence
; Model library: binds the shapes of a model to its art
;-----------------------------------------------------------------------------
BindModelShapes:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 24h
        mov esi, dword [byte esp+038h]
        mov eax, dword [esi]
        mov dword [byte esp+010h], eax
        mov eax, dword [byte esi+014h]
        mov dword [byte esp+014h], eax
        mov eax, dword [byte esp+010h]
        mov eax, dword [byte eax+03Ch]
        xor edx, edx
        mov dword [byte esp+08h], eax
        mov eax, dword [byte esp+010h]
        mov dword [byte esp+0Ch], edx
        mov ecx, dword [byte eax+038h]
        mov dword [byte esp+01Ch], edx
        test ecx, ecx
        jle near .7
        mov eax, dword [byte esp+08h]
        add eax, byte 8
        mov dword [byte esp+018h], eax
.1:
        mov eax, dword [byte esp+08h]
        test byte [byte eax+0Ch], 2
        jne short .2
        mov ebx, 4
        mov edx, dword [byte esp+018h]
        mov eax, esp
        call strncpy_
        mov eax, esp
        push eax
        mov ecx, dword [byte esp+040h]
        xor dh, dh
        push ecx
        mov byte [byte esp+0Ch], dh
        call FindShapeQuiet
        add esp, byte 8
        test eax, eax
        je near .6
        mov edx, dword [byte esp+014h]
        mov edi, dword [byte esp+0Ch]
        mov dword [byte edx+0Ch], eax
        inc edi
        mov bl, byte [byte esi+011h]
        mov dword [byte esp+0Ch], edi
        test bl, 1
        je near .6
        mov edx, dword [byte esp+01Ch]
        mov ebx, eax
        mov eax, esi
        call TransformModelParts
        jmp short .6
.2:
        mov eax, dword [byte eax+0Ch]
        shl eax, 14h
        mov edi, dword [byte esp+010h]
        shr eax, 16h
        mov edi, dword [byte edi+070h]
        shl eax, 3
        add edi, eax
        lea eax, [byte edi+04h]
        xor ebp, ebp
        mov dword [byte esp+020h], eax
        jmp short .5
.3:
        test byte [byte esi+011h], 1
        je short .4
        mov eax, dword [byte esp+020h]
        push eax
        mov edx, dword [byte esp+040h]
        push edx
        call FindShapeQuiet
        add esp, byte 8
        mov ebx, eax
        mov edx, dword [edi]
        mov eax, esi
        call GetModelVertex
.4:
        mov ebx, dword [byte esp+020h]
        add edi, byte 8
        add ebx, byte 8
        inc ebp
        mov dword [byte esp+020h], ebx
.5:
        mov eax, dword [byte esp+08h]
        mov eax, dword [byte eax+0Ch]
        shl eax, 0Ah
        shr eax, 16h
        cmp ebp, eax
        jb short .3
.6:
        mov edi, dword [byte esp+01Ch]
        mov ebp, dword [byte esp+014h]
        mov eax, dword [byte esp+018h]
        mov edx, dword [byte esp+08h]
        inc edi
        add ebp, byte 14h
        add edx, byte 18h
        add eax, byte 18h
        mov dword [byte esp+08h], edx
        mov edx, dword [byte esp+010h]
        mov dword [byte esp+01Ch], edi
        mov dword [byte esp+014h], ebp
        mov ebx, dword [byte edx+038h]
        mov dword [byte esp+018h], eax
        cmp edi, ebx
        jl near .1
.7:
        mov eax, dword [byte esp+0Ch]
        add esp, byte 24h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        mov edx, dword [byte esp+04h]
        push edx
        call MatchColor
        add esp, byte 4
        ret
        db 08Bh,0C0h
        push ebx
        push esi
        push edi
        mov esi, dword [byte esp+010h]
        mov edi, dword [byte esp+014h]
        lea eax, [nosplit edi*4+00h]
        add eax, edi
        mov ebx, dword [byte esi+014h]
        shl eax, 2
        add ebx, eax
        mov eax, dword [ebx]
        push eax
        call MatchColor
        mov dword [byte ebx+04h], eax
        mov ah, byte [byte esi+011h]
        add esp, byte 4
        test ah, 1
        je short .8
        mov edx, edi
        mov eax, esi
        mov ebx, dword [byte ebx+04h]
        call UpdateModelParts
.8:
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; UpdateModelInstance                            10FD58  97 PC, low confidence
; Model library: updates a model instance
;-----------------------------------------------------------------------------
UpdateModelInstance:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebp, dword [byte esp+018h]
        mov eax, dword [byte ebp+00h]
        mov esi, dword [byte ebp+014h]
        mov eax, dword [byte eax+03Ch]
        xor edi, edi
        mov dword [esp], eax
        mov eax, dword [byte ebp+00h]
        cmp edi, dword [byte eax+038h]
        jl short .1
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.1:
        mov eax, dword [esp]
        mov eax, dword [byte eax+010h]
        push eax
        mov dword [esi], eax
        call MatchColor
        mov dword [byte esi+04h], eax
        mov ah, byte [byte ebp+011h]
        add esp, byte 4
        test ah, 1
        je short .2
        mov edx, edi
        mov eax, ebp
        mov ebx, dword [byte esi+04h]
        call UpdateModelParts
.2:
        mov ebx, dword [esp]
        add esi, byte 14h
        add ebx, byte 18h
        inc edi
        mov dword [esp], ebx
        mov eax, dword [byte ebp+00h]
        cmp edi, dword [byte eax+038h]
        jl short .1
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push esi
        push edi
        mov esi, dword [byte esp+010h]
        mov edi, dword [byte esp+014h]
        lea eax, [nosplit edi*4+00h]
        add eax, edi
        mov ebx, dword [byte esi+014h]
        shl eax, 2
        add ebx, eax
        mov eax, dword [byte esp+018h]
        push eax
        mov dword [ebx], eax
        call MatchColor
        mov dword [byte ebx+04h], eax
        mov ah, byte [byte esi+011h]
        add esp, byte 4
        test ah, 1
        je short .3
        mov edx, edi
        mov eax, esi
        mov ebx, dword [byte ebx+04h]
        call UpdateModelParts
.3:
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; UpdateModelPart                                10FE10  97 PC, low confidence
; Model library: updates one part of a model
;-----------------------------------------------------------------------------
UpdateModelPart:
        push ebx
        push esi
        mov esi, dword [byte esp+0Ch]
        mov edx, dword [byte esp+010h]
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        mov ecx, dword [byte esi+014h]
        shl eax, 2
        add ecx, eax
        mov eax, dword [byte esp+014h]
        mov dword [byte ecx+04h], eax
        test byte [byte esi+011h], 1
        je short .1
        mov eax, esi
        mov ebx, dword [byte ecx+04h]
        call UpdateModelParts
.1:
        push ecx
        push byte 1
        mov edx, dword [byte esp+01Ch]
        push edx
        call GetPaletteEntries
        add esp, byte 0Ch
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetModelShape                                  10FE58  97 PC, low confidence
; Model library: sets a model part's shape
;-----------------------------------------------------------------------------
SetModelShape:
        push ebx
        push esi
        mov ecx, dword [byte esp+0Ch]
        mov esi, dword [byte esp+010h]
        mov ebx, dword [byte esp+014h]
        lea eax, [nosplit esi*4+00h]
        mov edx, dword [byte ecx+014h]
        add eax, esi
        mov dword [byte edx+eax*4+0Ch], ebx
        test byte [byte ecx+011h], 1
        je short .1
        mov edx, esi
        mov eax, ecx
        call TransformModelParts
.1:
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SetModelShapeWith                              10FE88  97 PC, low confidence
; Model library: sets a model part's shape with a transform
;-----------------------------------------------------------------------------
SetModelShapeWith:
        push ebx
        mov eax, dword [byte esp+08h]
        mov edx, dword [byte esp+0Ch]
        mov ecx, dword [byte esp+014h]
        test byte [byte eax+011h], 1
        je short .1
        mov ebx, dword [byte esp+010h]
        call TransformModelPartsWith
.1:
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetModelPartName                               10FEA8  97 PC, low confidence
; Model library: sets a model part's name
;-----------------------------------------------------------------------------
SetModelPartName:
        mov edx, dword [byte esp+08h]
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        mov edx, dword [byte esp+04h]
        shl eax, 2
        mov edx, dword [byte edx+014h]
        add eax, edx
        mov edx, dword [byte esp+0Ch]
        mov dword [byte eax+010h], edx
        ret
        db 00h,00h,00h,00h,00h,00h,00h
        push ebx
        mov edx, dword [byte esp+08h]
        mov ebx, 28h
        mov eax, ModelPartName
        call strncpy_
        pop ebx
        ret
        db 08Bh,0C0h
