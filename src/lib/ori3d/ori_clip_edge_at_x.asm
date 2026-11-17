; 3D library: ClipEdgeAtX, ClipEdgeAtY, ClipPolyLeft, ClipPolyRight, ClipPolyTop and 1 more.
bits 32
%include "hockey.inc"
section s_12300C progbits alloc exec nowrite align=1
extern ClipLeftCol, ClipRight, ClipTopRow, FixedLerp, PolyClipBottomBuf, PolyClipLeftBuf, PolyClipRightBuf, PolyClipTopBuf
extern ScreenHeight
global ClipEdgeAtX, ClipEdgeAtY, ClipPolyLeft, ClipPolyLeft_B8, ClipPolyRight, ClipPolyTop, ClipPolyBottom
        db 00h,00h,00h,00h
;-----------------------------------------------------------------------------
; ClipEdgeAtX                                    123010  97 PC, low confidence
; Clips a polygon edge at a vertical line and outputs the intersection point
;-----------------------------------------------------------------------------
ClipEdgeAtX:
        push ebx
        push esi
        push edi
        push ebp
        mov esi, dword [byte esp+014h]
        mov edi, dword [byte esp+01Ch]
        mov ebp, dword [byte esp+020h]
        mov ebx, dword [byte esp+018h]
        mov eax, ebp
        mov edx, dword [esi]
        mov ebx, dword [ebx]
        sub eax, edx
        sub ebx, edx
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        push eax
        mov eax, dword [byte esp+01Ch]
        mov edx, dword [byte eax+04h]
        push edx
        mov ebx, dword [byte esi+04h]
        push ebx
        call FixedLerp
        mov dword [byte edi+04h], eax
        mov ecx, dword [esi]
        add esp, byte 0Ch
        cmp ebp, ecx
        jne short .1
        mov edx, dword [byte esi+04h]
        cmp eax, edx
        jne short .1
        xor eax, edx
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.1:
        mov eax, 1
        mov dword [edi], ebp
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ClipEdgeAtY                                    12307C  97 PC, low confidence
; Clips a polygon edge at a horizontal line and outputs the intersection
; point
;-----------------------------------------------------------------------------
ClipEdgeAtY:
        push ebx
        push esi
        push edi
        push ebp
        mov esi, dword [byte esp+014h]
        mov edi, dword [byte esp+01Ch]
        mov ebp, dword [byte esp+020h]
        mov ebx, dword [byte esp+018h]
        mov eax, ebp
        mov edx, dword [byte esi+04h]
        mov ebx, dword [byte ebx+04h]
        sub eax, edx
        sub ebx, edx
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        push eax
        mov eax, dword [byte esp+01Ch]
        mov edx, dword [eax]
        push edx
        mov ebx, dword [esi]
        push ebx
        call FixedLerp
        mov dword [edi], eax
        mov ecx, dword [byte esi+04h]
        add esp, byte 0Ch
        cmp ebp, ecx
        jne short .1
        mov edx, dword [esi]
        cmp eax, edx
        jne short .1
        xor eax, edx
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.1:
        mov eax, 1
        mov dword [byte edi+04h], ebp
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ClipPolyLeft                                   1230E8  97 PC, low confidence
; Clips a polygon against the left edge of the clip window
;-----------------------------------------------------------------------------
ClipPolyLeft:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ebx, dword [byte esp+020h]
        mov eax, dword [ebx]
        xor ebp, ebp
        mov dword [esp], eax
        mov dword [ebx], PolyClipLeftBuf
        lea edx, [byte eax+08h]
        mov ebx, dword [ebx]
.1:
        mov dword [byte esp+04h], edx
.2:
        mov ecx, dword [ClipTopRow]
        cmp ecx, dword [eax]
        jle short .4
        mov edx, dword [byte esp+04h]
        cmp ecx, dword [edx]
        jg short .6
        push ecx
        push ebx
        push eax
        mov edi, dword [byte esp+010h]
        push edi
        call ClipEdgeAtX
        add esp, byte 10h
        test eax, eax
        je short .6
        add ebx, byte 8
.3:
        inc ebp
        jmp short .6
.4:
        mov edx, dword [byte esp+04h]
        cmp ecx, dword [edx]
        jle short .5
        mov edi, ebx
        mov esi, eax
        movsd
        movsd
        mov edi, dword [ClipTopRow]
        push edi
        add ebx, byte 8
        push ebx
        mov edx, dword [byte esp+0Ch]
        push edx
        push eax
        call ClipEdgeAtX
        add esp, byte 10h
        test eax, eax
        je short .3
        add ebx, byte 8
        add ebp, byte 2
        jmp short .6
.5:
        mov edi, ebx
        mov esi, eax
        inc ebp
        add ebx, byte 8
        movsd
        movsd
.6:
        mov eax, dword [byte esp+01Ch]
        dec eax
        mov dword [byte esp+01Ch], eax
        test eax, eax
        jle short ClipPolyLeft_B8
        mov ecx, dword [byte esp+01Ch]
        mov eax, dword [byte esp+04h]
        cmp ecx, byte 1
        jne short .7
        mov edx, dword [esp]
        jmp near .1
.7:
        lea esi, [byte eax+08h]
        mov dword [byte esp+04h], esi
        jmp near .2
ClipPolyLeft_B8:
        mov eax, ebp
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ClipPolyRight                                  1231AC  97 PC, low confidence
; Clips a polygon against the right edge of the clip window
;-----------------------------------------------------------------------------
ClipPolyRight:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ebx, dword [byte esp+020h]
        mov eax, dword [ebx]
        mov dword [esp], eax
        lea edx, [byte eax+08h]
        mov dword [ebx], PolyClipRightBuf
        mov dword [byte esp+04h], edx
        mov edx, dword [ClipRight]
        xor ebp, ebp
        dec edx
        mov ebx, dword [ebx]
        mov dword [ClipRight], edx
.1:
        mov ecx, dword [ClipRight]
        cmp ecx, dword [eax]
        jg short .3
        mov edx, dword [byte esp+04h]
        cmp ecx, dword [edx]
        jle short .5
        push ecx
        push ebx
        push eax
        mov edi, dword [byte esp+010h]
        push edi
        call ClipEdgeAtX
        add esp, byte 10h
        test eax, eax
        je short .5
        add ebx, byte 8
.2:
        inc ebp
        jmp short .5
.3:
        mov edx, dword [byte esp+04h]
        cmp ecx, dword [edx]
        jg short .4
        mov edi, ebx
        mov esi, eax
        movsd
        movsd
        mov edi, dword [ClipRight]
        push edi
        add ebx, byte 8
        push ebx
        mov edx, dword [byte esp+0Ch]
        push edx
        push eax
        call ClipEdgeAtX
        add esp, byte 10h
        test eax, eax
        je short .2
        add ebp, byte 2
        add ebx, byte 8
        jmp short .5
.4:
        mov edi, ebx
        mov esi, eax
        inc ebp
        add ebx, byte 8
        movsd
        movsd
.5:
        mov eax, dword [byte esp+01Ch]
        dec eax
        mov dword [byte esp+01Ch], eax
        test eax, eax
        jle short .7
        mov ecx, dword [byte esp+01Ch]
        mov eax, dword [byte esp+04h]
        cmp ecx, byte 1
        jne short .6
        mov edx, dword [esp]
        mov dword [byte esp+04h], edx
        jmp near .1
.6:
        lea esi, [byte eax+08h]
        mov dword [byte esp+04h], esi
        jmp near .1
.7:
        mov edi, dword [ClipRight]
        inc edi
        mov eax, ebp
        mov dword [ClipRight], edi
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ClipPolyTop                                    12328C  97 PC, low confidence
; Clips a polygon against the top edge of the clip window
;-----------------------------------------------------------------------------
ClipPolyTop:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ebx, dword [byte esp+020h]
        mov eax, dword [ebx]
        xor ebp, ebp
        mov dword [esp], eax
        mov dword [ebx], PolyClipTopBuf
        lea edx, [byte eax+08h]
        mov ebx, dword [ebx]
.1:
        mov dword [byte esp+04h], edx
.2:
        mov ecx, dword [ClipLeftCol]
        cmp ecx, dword [byte eax+04h]
        jle short .3
        mov edx, dword [byte esp+04h]
        cmp ecx, dword [byte edx+04h]
        jg short .6
        push ecx
        push ebx
        push eax
        mov edi, dword [byte esp+010h]
        push edi
        call ClipEdgeAtY
        add esp, byte 10h
        test eax, eax
        je short .6
        inc ebp
        add ebx, byte 8
        jmp short .6
.3:
        mov edx, dword [byte esp+04h]
        cmp ecx, dword [byte edx+04h]
        jle short .5
        mov edi, ebx
        mov esi, eax
        movsd
        movsd
        mov edi, dword [ClipLeftCol]
        push edi
        add ebx, byte 8
        push ebx
        mov edx, dword [byte esp+0Ch]
        push edx
        push eax
        call ClipEdgeAtY
        add esp, byte 10h
        test eax, eax
        je short .4
        add ebp, byte 2
        add ebx, byte 8
        jmp short .6
.4:
        inc ebp
        jmp short .6
.5:
        mov edi, ebx
        mov esi, eax
        inc ebp
        add ebx, byte 8
        movsd
        movsd
.6:
        mov eax, dword [byte esp+01Ch]
        dec eax
        mov dword [byte esp+01Ch], eax
        test eax, eax
        jle near ClipPolyLeft_B8
        mov ecx, dword [byte esp+01Ch]
        mov eax, dword [byte esp+04h]
        cmp ecx, byte 1
        jne short .7
        mov edx, dword [esp]
        jmp near .1
.7:
        lea esi, [byte eax+08h]
        mov dword [byte esp+04h], esi
        jmp near .2
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ClipPolyBottom                                 123350  97 PC, low confidence
; Clips a polygon against the bottom edge of the clip window
;-----------------------------------------------------------------------------
ClipPolyBottom:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ebx, dword [byte esp+020h]
        mov eax, dword [ebx]
        xor ebp, ebp
        mov dword [esp], eax
        mov dword [ebx], PolyClipBottomBuf
        lea edx, [byte eax+08h]
        mov ebx, dword [ebx]
.1:
        mov dword [byte esp+04h], edx
.2:
        mov ecx, dword [ScreenHeight]
        cmp ecx, dword [byte eax+04h]
        jg short .3
        mov edx, dword [byte esp+04h]
        cmp ecx, dword [byte edx+04h]
        jle short .6
        push ecx
        push ebx
        push eax
        mov edi, dword [byte esp+010h]
        push edi
        call ClipEdgeAtY
        add esp, byte 10h
        test eax, eax
        je short .6
        inc ebp
        add ebx, byte 8
        jmp short .6
.3:
        mov edx, dword [byte esp+04h]
        cmp ecx, dword [byte edx+04h]
        jg short .5
        mov edi, ebx
        mov esi, eax
        movsd
        movsd
        mov edi, dword [ScreenHeight]
        push edi
        add ebx, byte 8
        push ebx
        mov edx, dword [byte esp+0Ch]
        push edx
        push eax
        call ClipEdgeAtY
        add esp, byte 10h
        test eax, eax
        je short .4
        add ebp, byte 2
        add ebx, byte 8
        jmp short .6
.4:
        inc ebp
        jmp short .6
.5:
        mov edi, ebx
        mov esi, eax
        inc ebp
        add ebx, byte 8
        movsd
        movsd
.6:
        mov eax, dword [byte esp+01Ch]
        dec eax
        mov dword [byte esp+01Ch], eax
        test eax, eax
        jle near ClipPolyLeft_B8
        mov ecx, dword [byte esp+01Ch]
        mov eax, dword [byte esp+04h]
        cmp ecx, byte 1
        jne short .7
        mov edx, dword [esp]
        jmp near .1
.7:
        lea esi, [byte eax+08h]
        mov dword [byte esp+04h], esi
        jmp near .2
        db 00h,00h
