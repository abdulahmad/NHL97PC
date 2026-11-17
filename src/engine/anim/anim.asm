; Animation engine: nodes, files, frames, poses, clocks, blends and states.
bits 32
%include "hockey.inc"
section s_75F11 progbits alloc exec nowrite align=1
extern __CHP, _makepath_, _splitpath_, AllocMemBlock, AnimBlend, AnimDecodeEnd, AnimDecodeFrame, AnimDecodePtr
extern AnimNodeFreeList, AnimNodePool, AnimNodesFree, AnimStateBlocks, AnimStateCount, AnimStatesReady, BitReaderBits, CreateModelInstance
extern F32_0, F64_0p00613592, F64_0p00613592_UpdateMovePose, F64_PoseScale, FreeMemBlock, hypot_, IF@ATAN2, InitModelInstance
extern LoadFileAlloc, LoadModelByName, MoveFuncPair, MoveFuncTable, ReadBits, ReplayRecordBuf, ReplayRegisterObjects, ReplayRegisterStates
extern ServiceIdle, SetBitReader, str_4da, str_ANIMSTAT, strnicmp_, UpdateModelInstance
global AllocAnimNode, InsertAnimNode, AddAnimNode, FreeAnimNode, ResetAnimBlend, LoadAnimFile, FindAnimByName, GetAnimEntry
global DecodeAnimTree, DecodeAnimChild, DecodeAnimFile, ReadAnimValue, DecodeAnimFrame, DecodeAnimDelta, GetAnimId, UpdateObjectPose
global UpdateMovePose, UpdateMovePose_31B, UpdateAllPoses, ScaleAnimTime, SetAnimClock, AddAnimClock, UpdateAnimBlends, AnimClockTick
global SetAnimFrame, SetAnimFlags, ClearAnimFlags, InitAnimState, AllocAnimStateBlocks, StartAnim, StartAnimNow, BlendToAnim
global ChangeAnim, InitAnimNodePool, FreeAnimStates, AllocAnimStates
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; AllocAnimNode                                   75F14  97 PC, low confidence
; Takes a node from the free animation node list
;-----------------------------------------------------------------------------
AllocAnimNode:
        push edx
        mov eax, dword [AnimNodeFreeList]
        mov edx, dword [byte eax+020h]
        mov dword [AnimNodeFreeList], edx
        mov dword [byte eax+024h], 0
        mov dword [byte eax+01Ch], 0
        mov edx, dword [byte eax+024h]
        mov dword [byte eax+020h], edx
        dec dword [AnimNodesFree]
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; InsertAnimNode                                  75F40  97 PC, low confidence
; Inserts an animation node after another
;-----------------------------------------------------------------------------
InsertAnimNode:
        push ebx
        push ecx
        push edx
        mov edx, eax
        call AllocAnimNode
        mov ebx, eax
        mov dword [byte eax+024h], edx
        test edx, edx
        je short .2
        mov ecx, dword [byte edx+020h]
        mov dword [byte eax+020h], ecx
        test ecx, ecx
        je short .1
        mov dword [byte ecx+024h], eax
.1:
        mov dword [byte edx+020h], ebx
        jmp short .3
.2:
        mov dword [byte eax+020h], edx
.3:
        mov eax, ebx
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AddAnimNode                                     75F70  97 PC, low confidence
; Adds an animation node to a list
;-----------------------------------------------------------------------------
AddAnimNode:
        push ebx
        push ecx
        push edx
        mov edx, eax
        call AllocAnimNode
        mov ebx, eax
        mov dword [byte eax+020h], edx
        test edx, edx
        je short .2
        mov ecx, dword [byte edx+024h]
        mov dword [byte eax+024h], ecx
        test ecx, ecx
        je short .1
        mov dword [byte ecx+020h], eax
.1:
        mov dword [byte edx+024h], ebx
        jmp short .3
.2:
        mov dword [byte eax+024h], edx
.3:
        mov eax, ebx
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FreeAnimNode                                    75FA0  97 PC, low confidence
; Returns an animation node to the free list
;-----------------------------------------------------------------------------
FreeAnimNode:
        push ebx
        push ecx
        push edx
        mov edx, dword [byte eax+020h]
        mov dword [eax], 0
        test edx, edx
        je short .1
        mov ebx, dword [byte eax+024h]
        mov dword [byte edx+024h], ebx
.1:
        mov ebx, dword [byte eax+024h]
        test ebx, ebx
        je short .2
        mov ecx, dword [byte eax+020h]
        mov dword [byte ebx+020h], ecx
.2:
        mov ebx, dword [AnimNodeFreeList]
        mov dword [byte eax+020h], ebx
        mov ecx, dword [AnimNodesFree]
        mov dword [AnimNodeFreeList], eax
        inc ecx
        mov eax, edx
        mov dword [AnimNodesFree], ecx
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ResetAnimBlend                                  75FE4  97 PC, low confidence
; Resets an animation blend and frees its children
;-----------------------------------------------------------------------------
ResetAnimBlend:
        push edx
        mov dl, byte [byte eax+01Dh]
        mov dword [byte eax+010h], 3F800000h
        and dl, 0FAh
        mov byte [byte eax+01Dh], dl
        mov eax, dword [byte eax+020h]
        test eax, eax
        je short .2
.1:
        test byte [byte eax+01Dh], 2
        je short .2
        call FreeAnimNode
        test eax, eax
        jne short .1
.2:
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LoadAnimFile                                 76010  97 PC, medium confidence
; (name, ...): loads a ".4da" animation file (_splitpath_ / _makepath_), from
; the InitAnimPoints loaders
;-----------------------------------------------------------------------------
LoadAnimFile:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 198h
        mov esi, edx
        lea edx, [dword esp+018Ch]
        lea ecx, [dword esp+0180h]
        push edx
        lea ebx, [byte esp+04h]
        lea edx, [dword esp+0198h]
        call _splitpath_
        push str_4da
        lea ecx, [dword esp+0184h]
        lea ebx, [byte esp+04h]
        lea edx, [dword esp+0198h]
        lea eax, [dword esp+0104h]
        call _makepath_
        call ServiceIdle
        push esi
        lea eax, [dword esp+0104h]
        push eax
        call LoadFileAlloc
        add esp, byte 8
        mov ecx, eax
        mov edx, eax
        call ServiceIdle
        mov ebx, dword [byte ecx+04h]
        add ebx, ecx
        mov esi, ecx
        mov dword [byte ecx+04h], ebx
        mov eax, ebx
        mov ecx, dword [ecx]
        xor ebx, ebx
        test ecx, ecx
        jle short .2
.1:
        mov edi, dword [byte eax+08h]
        mov ebp, dword [byte eax+010h]
        add eax, byte 24h
        add edi, edx
        add ebp, edx
        mov dword [byte eax-01Ch], edi
        mov dword [byte eax-014h], ebp
        mov edi, dword [byte eax-010h]
        mov ebp, dword [byte eax-0Ch]
        add edi, edx
        add ebp, edx
        mov dword [byte eax-010h], edi
        inc ebx
        mov dword [byte eax-0Ch], ebp
        cmp ebx, ecx
        jl short .1
.2:
        mov eax, esi
        add esp, 198h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FindAnimByName                                  760C8  97 PC, low confidence
; Finds an animation by name in an animation file
;-----------------------------------------------------------------------------
FindAnimByName:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov edi, edx
        mov ebp, dword [eax]
        mov ecx, dword [byte eax+04h]
        xor esi, esi
        test ebp, ebp
        jle short .3
.1:
        mov ebx, 8
        mov edx, edi
        mov eax, ecx
        call strnicmp_
        test eax, eax
        jne short .2
        mov eax, ecx
        jmp short .4
.2:
        inc esi
        add ecx, byte 24h
        cmp esi, ebp
        jl short .1
.3:
        xor eax, eax
.4:
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        mov ecx, dword [eax]
        mov ebx, dword [byte eax+04h]
        cmp edx, ecx
        jge short .5
        test edx, edx
        jge short .6
.5:
        xor eax, eax
        pop ecx
        pop ebx
        ret
.6:
        lea eax, [nosplit edx*8+00h]
        add eax, edx
        shl eax, 2
        add eax, ebx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        mov ebx, dword [byte eax+04h]
        lea eax, [nosplit edx*8+00h]
        add eax, edx
        shl eax, 2
        add eax, ebx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; GetAnimEntry                                    7613C  97 PC, low confidence
; Returns an entry of an animation table
;-----------------------------------------------------------------------------
GetAnimEntry:
        shl edx, 2
        mov eax, dword [byte eax+08h]
        add eax, edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DecodeAnimTree                                  76148  97 PC, low confidence
; Decodes an animation tree from the bit stream
;-----------------------------------------------------------------------------
DecodeAnimTree:
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov dword [byte esp+08h], eax
        mov ebp, ecx
        lea ecx, [nosplit edx*4+00h]
        mov eax, dword [byte eax+08h]
        add eax, ecx
        mov dword [byte esp+04h], eax
        lea eax, [nosplit ebx*4+00h]
        xor esi, esi
        sub eax, ebx
        test edx, edx
        jl short .1
        mov edi, dword [byte esp+08h]
        xor ecx, ecx
        mov cl, byte [byte edi+0Dh]
        cmp edx, ecx
        jl short .2
.1:
        xor eax, eax
        jmp near .10
.2:
        test ebx, ebx
        jl short .3
        xor edx, edx
        mov dl, byte [byte edi+0Ch]
        cmp ebx, edx
        jl short .4
.3:
        xor eax, eax
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret
.4:
        mov ebx, dword [byte edi+014h]
        mov ecx, dword [byte edi+010h]
.5:
        dec eax
        cmp eax, byte 0FFFFFFFFh
        je short .6
        xor edx, edx
        mov edi, ecx
        mov dl, byte [ecx]
        add ebx, byte 2
        add esi, edx
        mov dl, byte [edi]
        inc ecx
        test dl, dl
        je short .5
        add ebx, byte 2
        jmp short .5
.6:
        mov eax, dword [byte esp+04h]
        xor edx, edx
        mov dx, word [eax]
        mov eax, dword [byte esp+08h]
        mov eax, dword [byte eax+018h]
        add eax, edx
        mov edx, esi
        call SetBitReader
        fild word [ebx]
        fstp dword [byte ebp+00h]
        mov ah, byte [ecx]
        add ebx, byte 2
        test ah, ah
        je short .7
        xor eax, eax
        mov al, byte [ecx]
        movsx edx, word [ebx]
        call ReadBits
        imul edx, eax
        xor eax, eax
        mov dword [esp], edx
        mov al, byte [ecx]
        fild dword [esp]
        fmul dword [nosplit eax*4+F32_0]
        fadd dword [byte ebp+00h]
        add ebx, byte 2
        fstp dword [byte ebp+00h]
.7:
        fild word [ebx]
        inc ecx
        fstp dword [byte ebp+04h]
        mov dl, byte [ecx]
        add ebx, byte 2
        test dl, dl
        je short .8
        xor eax, eax
        mov al, byte [ecx]
        movsx edx, word [ebx]
        call ReadBits
        imul edx, eax
        xor eax, eax
        mov dword [esp], edx
        mov al, byte [ecx]
        fild dword [esp]
        fmul dword [nosplit eax*4+F32_0]
        fadd dword [byte ebp+04h]
        add ebx, byte 2
        fstp dword [byte ebp+04h]
.8:
        fild word [ebx]
        inc ecx
        fstp dword [byte ebp+08h]
        mov dh, byte [ecx]
        add ebx, byte 2
        test dh, dh
        je short .9
        xor eax, eax
        mov al, byte [ecx]
        movsx edx, word [ebx]
        call ReadBits
        imul edx, eax
        xor eax, eax
        mov dword [esp], edx
        mov al, byte [ecx]
        fild dword [esp]
        fmul dword [nosplit eax*4+F32_0]
        fadd dword [byte ebp+08h]
        fstp dword [byte ebp+08h]
.9:
        mov eax, 1
.10:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
        push ecx
        mov ecx, ebx
        mov ebx, 19h
        call DecodeAnimTree
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DecodeAnimChild                                 7629C  97 PC, low confidence
; Decodes one child of an animation tree
;-----------------------------------------------------------------------------
DecodeAnimChild:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov edi, eax
        mov dword [esp], edx
        mov ebp, ebx
        test edx, edx
        jl short .1
        xor ecx, ecx
        mov cl, byte [byte eax+0Ch]
        cmp ecx, edx
        jg short .2
.1:
        xor ecx, ecx
        jmp short .5
.2:
        xor esi, esi
        jmp short .4
.3:
        mov ebx, dword [esp]
        mov ecx, ebp
        mov edx, esi
        mov eax, edi
        call DecodeAnimTree
        add ebp, byte 0Ch
        inc esi
.4:
        xor ecx, ecx
        mov cl, byte [byte edi+0Dh]
        cmp esi, ecx
        jl short .3
.5:
        mov eax, ecx
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; DecodeAnimFile                                  762E4  97 PC, low confidence
; Decodes an animation file
;-----------------------------------------------------------------------------
DecodeAnimFile:
        push ebx
        push ecx
        push esi
        sub esp, byte 10h
        mov ecx, eax
        mov esi, edx
        mov ebx, edx
        mov edx, 19h
        call DecodeAnimChild
        mov eax, esi
        xor edx, edx
        jmp short .2
.1:
        fld dword [eax]
        fld st0
        fmul qword [F64_0p00613592]
        fld dword [byte eax+04h]
        fld st0
        fmul qword [F64_0p00613592]
        add eax, byte 0Ch
        inc edx
        fxch st2
        fstp st3
        fxch
        fstp st1
        fxch
        fstp dword [byte eax-0Ch]
        fstp dword [byte eax-08h]
.2:
        xor ebx, ebx
        mov bl, byte [byte ecx+0Dh]
        cmp edx, ebx
        jl short .1
        mov eax, edx
        add esp, byte 10h
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
        push ebx
        push edx
        mov ebx, eax
        mov eax, dword [dword eax+0354h]
        xor edx, edx
        mov dx, word [eax]
        mov eax, dword [ebx]
        mov eax, dword [byte eax+018h]
        add eax, edx
        xor edx, edx
        call SetBitReader
        mov eax, dword [ebx]
        mov eax, dword [byte eax+010h]
        mov dword [AnimDecodeFrame], eax
        mov eax, ebx
        add eax, 0D4h
        add ebx, 214h
        mov dword [AnimDecodeEnd], eax
        mov dword [AnimDecodePtr], ebx
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ReadAnimValue                                   76380  97 PC, low confidence
; Reads one value from the animation bit stream
;-----------------------------------------------------------------------------
ReadAnimValue:
        push ebp
        mov ebp, esp
        sub esp, byte 8
        and esp, byte 0FFFFFFF8h
        test al, al
        je short .1
        and eax, 0FFh
        call ReadBits
        mov dword [esp], eax
        fild dword [esp]
        fmul dword [byte ebp+0Ch]
        fadd dword [byte ebp+08h]
        fstp dword [byte esp+04h]
        jmp short .2
.1:
        mov eax, dword [byte ebp+08h]
        mov dword [byte esp+04h], eax
.2:
        fld dword [byte esp+04h]
        mov esp, ebp
        pop ebp
        ret 8
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DecodeAnimFrame                                 763BC  97 PC, low confidence
; Decodes one animation frame
;-----------------------------------------------------------------------------
DecodeAnimFrame:
        push esi
        push edi
        push ebp
        sub esp, byte 20h
        mov esi, eax
        mov edi, edx
        mov dword [byte esp+08h], ebx
        mov dword [byte esp+0Ch], ecx
        mov ebp, dword [byte eax+01Ch]
        mov eax, dword [eax]
        mov dl, byte [byte eax+0Dh]
        and ebp, byte 8
        cmp dl, 1
        seta al
        xor edx, edx
        mov dl, al
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        shl eax, 2
        mov dword [byte esp+014h], edx
        sub ebx, eax
        mov ecx, dword [byte esi+010h]
        mov dword [byte esp+08h], ebx
        test ecx, 7FFFFFFFh
        jne short .2
        mov ebx, dword [byte esp+030h]
        mov ebp, dword [byte esp+0Ch]
        cmp ebp, ebx
        jg near .16
        lea ebx, [nosplit ebp*4+00h]
        sub ebx, ebp
        mov edx, dword [byte esp+08h]
        shl ebx, 2
        mov eax, dword [byte esp+030h]
        add ebx, edx
.1:
        add ebx, byte 0Ch
        mov dword [byte ebx-04h], 0
        inc ebp
        mov edx, dword [byte ebx-04h]
        mov dword [byte ebx-08h], edx
        mov edx, dword [byte ebx-08h]
        mov dword [byte ebx-0Ch], edx
        cmp ebp, eax
        jg near .16
        jmp short .1
.2:
        test ebp, ebp
        je short .3
        mov eax, dword [byte edi+014h]
        mov dword [byte esp+04h], eax
        mov eax, dword [BitReaderBits]
        mov dword [byte esp+010h], eax
        jmp short .4
.3:
        mov edi, dword [byte esp+0Ch]
        test edi, edi
        je short .4
        test edx, edx
        je short .4
        lea eax, [nosplit edi*4+00h]
        sub eax, edi
        mov eax, dword [byte esi+eax*2+032h]
        sar eax, 10h
        mov edx, eax
        mov ebx, eax
        mov eax, dword [BitReaderBits]
        sar ebx, 3
        and edx, byte 7
        add eax, ebx
        call SetBitReader
.4:
        mov edx, dword [byte esp+030h]
        mov edi, dword [byte esp+0Ch]
        cmp edi, edx
        jg near .14
        lea eax, [edi+edi]
        mov dword [byte esp+018h], eax
        lea eax, [nosplit edi*4+00h]
        mov edx, dword [byte esp+04h]
        lea ecx, [nosplit edi*4+00h]
        mov ebx, dword [byte esp+08h]
        sub ecx, edi
        add eax, edx
        shl ecx, 2
        mov dword [byte esp+01Ch], eax
        add ecx, ebx
.5:
        test ebp, ebp
        je short .6
        mov ebx, dword [byte esp+01Ch]
        mov ebx, dword [ebx]
        lea eax, [nosplit ebx*2+00h]
        add ebx, eax
        cmp dword [byte esp+014h], byte 0
        je short .7
        mov eax, dword [byte esi+ebx*2+032h]
        sar eax, 10h
        mov edx, eax
        sar eax, 3
        mov dword [esp], eax
        mov eax, dword [byte esp+010h]
        and edx, byte 7
        add eax, dword [esp]
        call SetBitReader
        jmp short .7
.6:
        mov ebx, dword [byte esp+018h]
        add ebx, edi
.7:
        mov edx, dword [byte esp+014h]
        lea eax, [nosplit ebx*4+00h]
        test edx, edx
        je near .10
        test ebp, ebp
        je short .8
        mov edx, dword [AnimDecodePtr]
        add edx, eax
        push dword [edx]
        mov edx, dword [AnimDecodeEnd]
        add eax, edx
        push dword [eax]
        mov eax, dword [AnimDecodeFrame]
        mov al, byte [ebx+eax]
        and eax, 0FFh
        call ReadAnimValue
        fchs
        jmp short .9
.8:
        mov edx, dword [AnimDecodePtr]
        add edx, eax
        push dword [edx]
        mov edx, dword [AnimDecodeEnd]
        add eax, edx
        push dword [eax]
        mov eax, dword [AnimDecodeFrame]
        mov al, byte [ebx+eax]
        and eax, 0FFh
        call ReadAnimValue
.9:
        fstp dword [ecx]
        inc ebx
        mov edx, dword [AnimDecodePtr]
        lea eax, [nosplit ebx*4+00h]
        add edx, eax
        push dword [edx]
        mov edx, dword [AnimDecodeEnd]
        add eax, edx
        push dword [eax]
        mov eax, dword [AnimDecodeFrame]
        mov al, byte [ebx+eax]
        and eax, 0FFh
        inc ebx
        call ReadAnimValue
        fstp dword [byte ecx+04h]
        mov edx, dword [AnimDecodePtr]
        lea eax, [nosplit ebx*4+00h]
        add edx, eax
        push dword [edx]
        mov edx, dword [AnimDecodeEnd]
        add eax, edx
        push dword [eax]
        mov eax, dword [AnimDecodeFrame]
        mov al, byte [ebx+eax]
        and eax, 0FFh
        call ReadAnimValue
        fstp dword [byte ecx+08h]
        jmp short .13
.10:
        inc ebx
        test ebp, ebp
        je short .11
        mov edx, dword [AnimDecodeEnd]
        add eax, edx
        fld dword [eax]
        fchs
        fstp dword [ecx]
        jmp short .12
.11:
        mov edx, dword [AnimDecodeEnd]
        add eax, edx
        mov edx, dword [eax]
        mov dword [ecx], edx
.12:
        mov edx, dword [AnimDecodeEnd]
        lea eax, [nosplit ebx*4+00h]
        add eax, edx
        inc ebx
        fld dword [eax]
        fstp dword [byte ecx+04h]
        mov eax, dword [AnimDecodeEnd]
        mov edx, dword [eax+ebx*4]
        mov dword [byte ecx+08h], edx
.13:
        mov eax, dword [byte esp+018h]
        mov edx, dword [byte esp+01Ch]
        mov ebx, dword [byte esp+030h]
        add ecx, byte 0Ch
        inc edi
        add eax, byte 2
        add edx, byte 4
        mov dword [byte esp+018h], eax
        mov dword [byte esp+01Ch], edx
        cmp edi, ebx
        jle near .5
.14:
        cmp dword [byte esi+010h], 3F800000h
        je short .16
        mov edi, dword [byte esp+030h]
        mov ebp, dword [byte esp+0Ch]
        cmp ebp, edi
        jg short .16
        lea ebx, [nosplit ebp*4+00h]
        sub ebx, ebp
        mov edi, dword [byte esp+08h]
        shl ebx, 2
        mov ecx, dword [byte esp+030h]
        add ebx, edi
.15:
        fld dword [byte esi+010h]
        fmul dword [ebx]
        fstp dword [ebx]
        fld dword [byte esi+010h]
        fmul dword [byte ebx+04h]
        fstp dword [byte ebx+04h]
        fld dword [byte esi+010h]
        fmul dword [byte ebx+08h]
        add ebx, byte 0Ch
        inc ebp
        fstp dword [byte ebx-04h]
        cmp ebp, ecx
        jle short .15
.16:
        add esp, byte 20h
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DecodeAnimDelta                                 76698  97 PC, low confidence
; Decodes the changes between animation frames
;-----------------------------------------------------------------------------
DecodeAnimDelta:
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov dword [byte esp+0Ch], eax
        mov edi, dword [byte eax+01Ch]
        mov eax, dword [eax]
        and edi, byte 8
        cmp byte [byte eax+0Dh], 1
        seta al
        and eax, 0FFh
        mov dword [byte esp+010h], eax
        mov eax, dword [byte esp+0Ch]
        mov eax, dword [byte eax+010h]
        mov dword [byte esp+018h], eax
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        shl eax, 2
        sub ebx, eax
        mov eax, dword [byte esp+0Ch]
        test byte [byte eax+01Dh], 1
        je short .1
        fld dword [byte esp+018h]
        fmul dword [AnimBlend]
        fld dword [AnimBlend]
        fxch
        fstp dword [byte esp+018h]
        fsub dword [byte esp+018h]
        fstp dword [AnimBlend]
        jmp short .2
.1:
        test byte [byte eax+01Dh], 2
        je short .2
        mov eax, dword [AnimBlend]
        mov dword [byte esp+018h], eax
.2:
        fldz
        fcomp dword [byte esp+018h]
        fnstsw ax
        sahf
        jae near .14
        test edi, edi
        je short .3
        mov eax, dword [byte edx+014h]
        mov dword [byte esp+04h], eax
        mov eax, dword [BitReaderBits]
        mov dword [byte esp+08h], eax
        jmp short .4
.3:
        test ecx, ecx
        je short .4
        cmp dword [byte esp+010h], byte 0
        je short .4
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        mov esi, dword [byte esp+0Ch]
        add eax, eax
        add eax, esi
        mov eax, dword [byte eax+032h]
        sar eax, 10h
        mov edx, eax
        mov esi, eax
        mov eax, dword [BitReaderBits]
        sar esi, 3
        and edx, byte 7
        add eax, esi
        call SetBitReader
.4:
        mov ebp, dword [byte esp+02Ch]
        mov esi, ecx
        cmp ecx, ebp
        jg near .14
        lea eax, [nosplit ecx*2+00h]
        mov dword [byte esp+014h], eax
        lea ebp, [nosplit ecx*4+00h]
        add ebp, dword [byte esp+04h]
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        shl eax, 2
        add ebx, eax
.5:
        test edi, edi
        je short .6
        mov ecx, dword [byte ebp+00h]
        lea eax, [nosplit ecx*2+00h]
        mov edx, dword [byte esp+010h]
        add ecx, eax
        test edx, edx
        je short .7
        mov edx, dword [byte esp+0Ch]
        lea eax, [nosplit ecx*2+00h]
        add eax, edx
        mov eax, dword [byte eax+032h]
        sar eax, 10h
        mov edx, eax
        sar eax, 3
        mov dword [esp], eax
        mov eax, dword [byte esp+08h]
        and edx, byte 7
        add eax, dword [esp]
        call SetBitReader
        jmp short .7
.6:
        mov ecx, dword [byte esp+014h]
        add ecx, esi
.7:
        mov edx, dword [byte esp+010h]
        lea eax, [nosplit ecx*4+00h]
        test edx, edx
        je near .10
        test edi, edi
        je short .8
        mov edx, dword [AnimDecodePtr]
        add edx, eax
        push dword [edx]
        mov edx, dword [AnimDecodeEnd]
        add eax, edx
        push dword [eax]
        mov eax, dword [AnimDecodeFrame]
        mov al, byte [ecx+eax]
        and eax, 0FFh
        call ReadAnimValue
        fchs
        jmp short .9
.8:
        mov edx, dword [AnimDecodePtr]
        add edx, eax
        push dword [edx]
        mov edx, dword [AnimDecodeEnd]
        add eax, edx
        push dword [eax]
        mov eax, dword [AnimDecodeFrame]
        mov al, byte [ecx+eax]
        and eax, 0FFh
        call ReadAnimValue
.9:
        fmul dword [byte esp+018h]
        fadd dword [ebx]
        fstp dword [ebx]
        inc ecx
        mov edx, dword [AnimDecodePtr]
        lea eax, [nosplit ecx*4+00h]
        add edx, eax
        push dword [edx]
        mov edx, dword [AnimDecodeEnd]
        add eax, edx
        push dword [eax]
        mov eax, dword [AnimDecodeFrame]
        mov al, byte [ecx+eax]
        and eax, 0FFh
        call ReadAnimValue
        fmul dword [byte esp+018h]
        fadd dword [byte ebx+04h]
        inc ecx
        fstp dword [byte ebx+04h]
        mov edx, dword [AnimDecodePtr]
        lea eax, [nosplit ecx*4+00h]
        add edx, eax
        push dword [edx]
        mov edx, dword [AnimDecodeEnd]
        add eax, edx
        push dword [eax]
        mov eax, dword [AnimDecodeFrame]
        mov al, byte [ecx+eax]
        and eax, 0FFh
        call ReadAnimValue
        fmul dword [byte esp+018h]
        fadd dword [byte ebx+08h]
        jmp short .13
.10:
        inc ecx
        test edi, edi
        je short .11
        mov edx, dword [AnimDecodeEnd]
        add eax, edx
        fld dword [eax]
        fchs
        jmp short .12
.11:
        mov edx, dword [AnimDecodeEnd]
        add eax, edx
        fld dword [eax]
.12:
        fmul dword [byte esp+018h]
        fadd dword [ebx]
        fstp dword [ebx]
        lea eax, [nosplit ecx*4+00h]
        mov dword [esp], eax
        mov edx, dword [esp]
        mov eax, dword [AnimDecodeEnd]
        add eax, edx
        fld dword [byte esp+018h]
        fld dword [eax]
        fmul st1
        fadd dword [byte ebx+04h]
        fstp dword [byte ebx+04h]
        mov eax, dword [AnimDecodeEnd]
        fmul dword [byte eax+ecx*4+04h]
        fadd dword [byte ebx+08h]
        inc ecx
.13:
        fstp dword [byte ebx+08h]
        mov eax, dword [byte esp+014h]
        mov edx, dword [byte esp+02Ch]
        add ebp, byte 4
        add ebx, byte 0Ch
        add eax, byte 2
        inc esi
        mov dword [byte esp+014h], eax
        cmp esi, edx
        jle near .5
.14:
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        ret 4
        db 090h
;-----------------------------------------------------------------------------
; GetAnimId                                       76944  97 PC, low confidence
; Returns the id of the current animation
;-----------------------------------------------------------------------------
GetAnimId:
        mov eax, dword [dword eax+0354h]
        mov ax, word [byte eax+02h]
        and eax, 0FFFFh
        ret
;-----------------------------------------------------------------------------
; UpdateObjectPose                                76954  97 PC, low confidence
; Decodes the current pose of an object
;-----------------------------------------------------------------------------
UpdateObjectPose:
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, eax
        mov ebp, edx
        mov edi, ebx
        mov dword [esp], ecx
        mov eax, dword [dword eax+0354h]
        mov ax, word [eax]
        mov edx, dword [esi]
        and eax, 0FFFFh
        mov edx, dword [byte edx+018h]
        add eax, edx
        xor edx, edx
        call SetBitReader
        mov eax, dword [esi]
        mov eax, dword [byte eax+010h]
        mov dword [AnimDecodeFrame], eax
        mov eax, esi
        mov ecx, ebx
        add eax, 0D4h
        push ebx
        mov dword [AnimDecodeEnd], eax
        mov eax, esi
        mov edx, ebp
        add eax, 214h
        mov ebx, dword [byte esp+04h]
        mov dword [AnimDecodePtr], eax
        mov eax, esi
        call DecodeAnimFrame
        fld dword [byte esi+010h]
        fld1
        fsubrp
        fstp dword [AnimBlend]
.1:
        mov esi, dword [byte esi+020h]
        test esi, esi
        je short .2
        mov edx, dword [dword esi+0354h]
        mov dx, word [edx]
        mov eax, dword [esi]
        and edx, 0FFFFh
        mov eax, dword [byte eax+018h]
        add eax, edx
        xor edx, edx
        call SetBitReader
        mov eax, dword [esi]
        mov ebx, dword [esp]
        mov eax, dword [byte eax+010h]
        mov ecx, edi
        mov dword [AnimDecodeFrame], eax
        lea eax, [dword esi+0D4h]
        push edi
        mov dword [AnimDecodeEnd], eax
        lea eax, [dword esi+0214h]
        mov edx, ebp
        mov dword [AnimDecodePtr], eax
        mov eax, esi
        call DecodeAnimDelta
        jmp short .1
.2:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; UpdateMovePose                                  76A1C  97 PC, low confidence
; Decodes the pose of a move and its motion
;-----------------------------------------------------------------------------
UpdateMovePose:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov esi, eax
        mov ebp, edx
        mov edi, ebx
        mov eax, dword [dword eax+0354h]
        xor edx, edx
        mov dx, word [eax]
        mov eax, dword [esi]
        mov eax, dword [byte eax+018h]
        add eax, edx
        xor edx, edx
        call SetBitReader
        mov eax, dword [esi]
        mov eax, dword [byte eax+010h]
        mov dword [AnimDecodeFrame], eax
        mov eax, esi
        add eax, 0D4h
        mov ecx, 19h
        mov dword [AnimDecodeEnd], eax
        mov eax, esi
        push byte 19h
        add eax, 214h
        mov edx, ebp
        mov dword [AnimDecodePtr], eax
        mov eax, esi
        call DecodeAnimFrame
        fld dword [edi]
        fld st0
        fmul qword [F64_0p00613592_UpdateMovePose]
        mov eax, dword [byte esi+01Ch]
        fstp st1
        fstp dword [edi]
        and eax, byte 8
        je short .1
        fld dword [byte edi+04h]
        fchs
        fmul qword [F64_0p00613592_UpdateMovePose]
        jmp short .2
.1:
        fld dword [byte edi+04h]
        fld st0
        fmul qword [F64_0p00613592_UpdateMovePose]
        fstp st1
.2:
        fstp dword [byte edi+04h]
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 40h
        and esp, byte 0FFFFFFF8h
        mov dword [byte esp+034h], eax
        mov dword [byte esp+02Ch], edx
        mov dword [byte esp+030h], ebx
        mov eax, dword [dword eax+0354h]
        xor ebx, ebx
        mov bx, word [eax]
        mov eax, dword [byte esp+034h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+018h]
        xor edx, edx
        add eax, ebx
        call SetBitReader
        mov eax, dword [byte esp+034h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+010h]
        mov dword [AnimDecodeFrame], eax
        mov eax, dword [byte esp+034h]
        mov ecx, 19h
        add eax, 0D4h
        push byte 19h
        mov dword [AnimDecodeEnd], eax
        mov eax, dword [byte esp+038h]
        mov ebx, dword [byte esp+034h]
        add eax, 214h
        mov edx, dword [byte esp+030h]
        mov dword [AnimDecodePtr], eax
        mov eax, dword [byte esp+038h]
        call DecodeAnimFrame
        mov ebx, dword [byte esp+030h]
        fld dword [ebx]
        fld st0
        fmul qword [F64_PoseScale]
        mov eax, dword [byte esp+034h]
        xor edi, edi
        mov eax, dword [byte eax+01Ch]
        fstp st1
        fstp dword [ebx]
        and eax, byte 8
        je short .3
        fld dword [byte ebx+04h]
        fchs
        fmul qword [F64_PoseScale]
        jmp short .4
.3:
        fld dword [byte ebx+04h]
        fld st0
        fmul qword [F64_PoseScale]
        fstp st1
.4:
        fstp dword [byte ebx+04h]
        mov eax, dword [byte esp+034h]
        cmp dword [byte eax+020h], byte 0
        je near .13
        mov eax, dword [byte esp+030h]
        test dword [eax], 7FFFFFFFh
        je short .5
        lea edi, [byte esp+020h]
        lea esi, [byte esp+01Ch]
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        mov eax, dword [byte esp+030h]
        fld dword [byte esp+01Ch]
        fmul dword [byte eax+08h]
        fld dword [byte esp+020h]
        fmul dword [byte eax+08h]
        mov edi, 1
        fxch
        fstp dword [byte esp+03Ch]
        fstp dword [byte esp+038h]
        jmp short .6
.5:
        mov eax, dword [byte eax+08h]
        xor ecx, ecx
        mov dword [byte esp+038h], eax
        mov dword [byte esp+03Ch], ecx
.6:
        mov eax, dword [byte esp+034h]
        fld dword [byte eax+010h]
        fld1
        fsubrp
        fstp dword [AnimBlend]
.7:
        mov eax, dword [byte esp+034h]
        mov eax, dword [byte eax+020h]
        mov dword [byte esp+034h], eax
        test eax, eax
        je near .11
        mov esi, dword [byte eax+01Ch]
        mov eax, dword [dword eax+0354h]
        xor ebx, ebx
        mov bx, word [eax]
        mov eax, dword [byte esp+034h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+018h]
        xor edx, edx
        add eax, ebx
        call SetBitReader
        mov eax, dword [byte esp+034h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+010h]
        mov dword [AnimDecodeFrame], eax
        mov eax, dword [byte esp+034h]
        mov ecx, 19h
        add eax, 0D4h
        push byte 19h
        mov dword [AnimDecodeEnd], eax
        mov eax, dword [byte esp+038h]
        lea ebx, [byte esp+04h]
        add eax, 214h
        mov edx, dword [byte esp+030h]
        mov dword [AnimDecodePtr], eax
        mov eax, dword [byte esp+038h]
        call DecodeAnimFrame
        fld dword [esp]
        fld st0
        fmul qword [F64_PoseScale]
        and esi, byte 8
        fstp st1
        fstp dword [esp]
        test esi, esi
        je short .8
        fld dword [byte esp+04h]
        fchs
        fmul qword [F64_PoseScale]
        jmp short .9
.8:
        fld dword [byte esp+04h]
        fld st0
        fmul qword [F64_PoseScale]
        fstp st1
.9:
        fstp dword [byte esp+04h]
        mov eax, dword [byte esp+030h]
        fld dword [byte eax+04h]
        fadd dword [byte esp+04h]
        fstp dword [byte eax+04h]
        test dword [esp], 7FFFFFFFh
        je short .10
        lea edi, [byte esp+024h]
        lea esi, [byte esp+028h]
        mov eax, esp
        fld dword [eax]
        fsincos
        fstp dword [edi]
        fstp dword [esi]
        fld dword [byte esp+028h]
        fmul dword [byte esp+08h]
        fld dword [byte esp+024h]
        fmul dword [byte esp+08h]
        mov edi, 1
        fxch
        fadd dword [byte esp+03Ch]
        fxch
        fadd dword [byte esp+038h]
        fxch
        fstp dword [byte esp+03Ch]
        fstp dword [byte esp+038h]
        jmp near .7
.10:
        fld dword [byte esp+038h]
        fadd dword [byte esp+08h]
        fstp dword [byte esp+038h]
        jmp near .7
.11:
        test edi, edi
        je short .12
        fld dword [byte esp+038h]
        fld dword [byte esp+03Ch]
        fstp qword [byte esp+014h]
        fst qword [byte esp+0Ch]
        fld qword [byte esp+014h]
        call IF@ATAN2
        mov edi, dword [byte esp+010h]
        mov eax, dword [byte esp+030h]
        push edi
        fstp dword [eax]
        mov eax, dword [byte esp+010h]
        push eax
        mov edx, dword [byte esp+020h]
        push edx
        mov ebx, dword [byte esp+020h]
        push ebx
        call hypot_
        mov eax, dword [byte esp+030h]
        fstp dword [byte eax+08h]
        jmp short .13
.12:
        mov ebx, dword [byte esp+030h]
        mov eax, dword [byte esp+038h]
        mov dword [byte ebx+08h], eax
.13:
        mov esp, ebp
UpdateMovePose_31B:
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; UpdateAllPoses                                  76D3C  97 PC, low confidence
; Decodes the poses of every object
;-----------------------------------------------------------------------------
UpdateAllPoses:
        push ecx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov edi, edx
        mov ebp, ebx
        mov edx, dword [dword eax+0354h]
        mov dx, word [edx]
        mov eax, dword [eax]
        and edx, 0FFFFh
        mov eax, dword [byte eax+018h]
        add eax, edx
        xor edx, edx
        call SetBitReader
        mov eax, dword [esi]
        mov eax, dword [byte eax+010h]
        mov dword [AnimDecodeFrame], eax
        mov eax, esi
        add eax, 0D4h
        mov dword [AnimDecodeEnd], eax
        mov eax, esi
        add eax, 214h
        mov dword [AnimDecodePtr], eax
        mov eax, dword [esi]
        mov al, byte [byte eax+0Ch]
        and eax, 0FFh
        dec eax
        mov edx, edi
        push eax
        xor ecx, ecx
        mov eax, esi
        call DecodeAnimFrame
        fld dword [byte esi+010h]
        fld1
        fsubrp
        fstp dword [AnimBlend]
.1:
        mov esi, dword [byte esi+020h]
        test esi, esi
        je short UpdateMovePose_31B
        mov eax, dword [dword esi+0354h]
        xor edx, edx
        mov dx, word [eax]
        mov eax, dword [esi]
        mov eax, dword [byte eax+018h]
        add eax, edx
        xor edx, edx
        call SetBitReader
        mov eax, dword [esi]
        mov eax, dword [byte eax+010h]
        mov dword [AnimDecodeFrame], eax
        lea eax, [dword esi+0D4h]
        mov dword [AnimDecodeEnd], eax
        lea eax, [dword esi+0214h]
        mov dword [AnimDecodePtr], eax
        mov eax, dword [esi]
        mov al, byte [byte eax+0Ch]
        and eax, 0FFh
        mov ebx, ebp
        dec eax
        mov edx, edi
        push eax
        xor ecx, ecx
        mov eax, esi
        call DecodeAnimDelta
        jmp short .1
;-----------------------------------------------------------------------------
; ScaleAnimTime                                   76E04  97 PC, low confidence
; Scales the animation time
;-----------------------------------------------------------------------------
ScaleAnimTime:
        push edx
        mov edx, dword [eax]
        fild word [byte edx+020h]
        fmul dword [byte esp+08h]
        call __CHP
        fistp dword [byte eax+08h]
        pop edx
        ret 4
        db 08Bh,0C0h
        mov dword [byte eax+08h], edx
        ret
;-----------------------------------------------------------------------------
; SetAnimClock                                    76E20  97 PC, low confidence
; Sets the animation clock
;-----------------------------------------------------------------------------
SetAnimClock:
        mov dword [ReplayRecordBuf], eax
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AddAnimClock                                    76E28  97 PC, low confidence
; Adds to the animation clock
;-----------------------------------------------------------------------------
AddAnimClock:
        add dword [ReplayRecordBuf], eax
        ret
        db 090h
;-----------------------------------------------------------------------------
; UpdateAnimBlends                                76E30  97 PC, low confidence
; Updates the animation blends
;-----------------------------------------------------------------------------
UpdateAnimBlends:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edi, eax
        mov edx, dword [eax]
        mov ah, byte [byte edx+01Dh]
        test ah, 2
        jne near .15
        test ah, 1
        je short .1
        mov ebx, dword [byte edx+020h]
.1:
        mov ecx, dword [ReplayRecordBuf]
        mov eax, dword [byte edx+0Ch]
        mov esi, dword [edx]
        cmp eax, ecx
        jg near .15
.2:
        test byte [byte edx+01Ch], 40h
        je short .3
        mov eax, dword [edx]
        mov al, byte [byte eax+0Dh]
        and eax, 0FFh
        mov ecx, dword [byte edx+04h]
        dec eax
        cmp eax, ecx
        jne short .3
        or byte [byte edx+01Dh], 8
.3:
        test byte [byte edx+01Dh], 8
        jne near .6
        mov eax, dword [dword edx+0354h]
        add eax, byte 4
        mov ebp, dword [byte edx+04h]
        mov dword [dword edx+0354h], eax
        inc ebp
        mov cl, byte [byte edx+01Dh]
        mov dword [byte edx+04h], ebp
        test cl, 1
        je short .6
        mov eax, dword [ebx]
        xor ecx, ecx
        mov cl, byte [byte eax+0Dh]
        mov ebp, dword [byte ebx+04h]
        dec ecx
        cmp ecx, ebp
        jg short .5
        mov ch, byte [byte eax+0Eh]
        test ch, 10h
        je short .4
        mov eax, dword [ebx]
        mov dword [byte ebx+04h], 0
        mov eax, dword [byte eax+08h]
        mov dword [dword ebx+0354h], eax
        jmp short .6
.4:
        test ch, 20h
        jne short .6
        mov eax, edx
        call ResetAnimBlend
        jmp short .6
.5:
        mov ecx, dword [dword ebx+0354h]
        lea eax, [byte ebp+01h]
        add ecx, byte 4
        mov dword [byte ebx+04h], eax
        mov dword [dword ebx+0354h], ecx
.6:
        xor eax, eax
        mov ebp, dword [byte edx+04h]
        mov al, byte [byte esi+0Dh]
        cmp eax, ebp
        jg short .8
        mov ch, byte [byte edx+01Ch]
        test ch, 20h
        je short .7
        mov eax, dword [edx]
        mov dword [byte edx+04h], 0
        mov eax, dword [byte eax+08h]
        mov dword [dword edx+0354h], eax
        jmp short .8
.7:
        mov al, ch
        or al, 80h
        mov byte [byte edx+01Ch], al
.8:
        mov ecx, dword [byte edx+0Ch]
        add ecx, dword [byte edx+08h]
        mov ebp, dword [byte edx+030h]
        mov dword [byte edx+0Ch], ecx
        test ebp, ebp
        je short .9
        mov eax, edx
        call dword [byte edx+030h]
.9:
        test byte [byte edx+01Ch], 80h
        je short .11
        test byte [byte edx+01Dh], 1
        je short .10
        mov eax, edx
        call ResetAnimBlend
.10:
        mov esi, dword [edi]
        cmp edx, esi
        jne short .14
        mov eax, esi
        call FreeAnimNode
        mov dword [edi], eax
        jmp short .15
.11:
        mov cl, byte [byte edx+01Dh]
        test cl, 2
        jne short .15
        test cl, 4
        je short .13
        fld dword [byte edx+014h]
        fadd dword [byte edx+010h]
        fstp dword [byte edx+010h]
        cmp dword [byte edx+010h], 3F800000h
        jl short .12
        mov eax, edx
        call ResetAnimBlend
        mov dword [byte edx+010h], 3F800000h
        jmp short .13
.12:
        fldz
        fcomp dword [byte edx+010h]
        fnstsw ax
        sahf
        jae short .14
.13:
        mov ebp, dword [ReplayRecordBuf]
        cmp ebp, dword [byte edx+0Ch]
        jge near .2
        jmp short .15
.14:
        mov eax, edx
        call FreeAnimNode
.15:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; AnimClockTick                                   76FB4  97 PC, low confidence
; Advances the animation clock
;-----------------------------------------------------------------------------
AnimClockTick:
        push ebx
        push edx
        push esi
        push edi
        mov ebx, dword [eax]
        mov edx, eax
        test ebx, ebx
        je short .4
.1:
        mov eax, dword [edx]
        mov esi, dword [ReplayRecordBuf]
        cmp esi, dword [byte eax+0Ch]
        jl short .2
        mov eax, edx
        call UpdateAnimBlends
.2:
        mov edi, dword [edx]
        test edi, edi
        je short .3
        lea edx, [byte edi+020h]
.3:
        cmp dword [edx], byte 0
        jne short .1
.4:
        pop edi
        pop esi
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetAnimFrame                                    76FE8  97 PC, low confidence
; Sets an animation to a frame
;-----------------------------------------------------------------------------
SetAnimFrame:
        push ebx
        push ecx
        test edx, edx
        je short .1
        mov ebx, dword [eax]
        lea ecx, [nosplit edx*4+00h]
        mov ebx, dword [byte ebx+08h]
        add ebx, ecx
        jmp short .2
.1:
        mov ebx, dword [eax]
        mov ebx, dword [byte ebx+08h]
.2:
        mov dword [dword eax+0354h], ebx
        mov dword [byte eax+04h], edx
        and byte [byte eax+01Ch], 7Fh
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetAnimFlags                                    77014  97 PC, low confidence
; Sets animation flags
;-----------------------------------------------------------------------------
SetAnimFlags:
        or dword [byte eax+01Ch], edx
        ret
;-----------------------------------------------------------------------------
; ClearAnimFlags                                  77018  97 PC, low confidence
; Clears animation flags; next entry sets the blend weight
;-----------------------------------------------------------------------------
ClearAnimFlags:
        not edx
        and dword [byte eax+01Ch], edx
        ret
        db 08Bh,0C0h
        push edx
        mov edx, dword [byte esp+08h]
        mov dword [byte eax+010h], edx
        test byte [byte eax+01Dh], 1
        je short .2
.1:
        mov eax, dword [byte eax+020h]
        test eax, eax
        je short .2
        test byte [byte eax+01Dh], 2
        je short .1
        fld1
        fsub dword [byte esp+08h]
        fstp dword [byte eax+010h]
.2:
        pop edx
        ret 4
;-----------------------------------------------------------------------------
; InitAnimState                                   77048  97 PC, low confidence
; Initialises an animation state
;-----------------------------------------------------------------------------
InitAnimState:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        mov dword [byte esp+0Ch], eax
        lea esi, [dword eax+0D4h]
        add eax, 214h
        mov dword [byte esp+04h], eax
        mov eax, dword [byte esp+0Ch]
        mov ecx, dword [byte esp+0Ch]
        mov eax, dword [eax]
        xor edi, edi
        mov dword [byte esp+08h], eax
        add ecx, byte 34h
        mov edx, dword [byte esp+08h]
        mov ebx, dword [byte eax+010h]
        mov eax, dword [byte eax+014h]
        cmp byte [byte edx+0Dh], 1
        jbe near .5
        mov dword [byte esp+014h], ecx
        xor edx, edx
        jmp short .4
.1:
        mov ecx, dword [byte esp+0Ch]
        mov ecx, dword [byte ecx+018h]
        mov dword [esp], ecx
.2:
        fild word [eax]
        fmul dword [esp]
        lea ebp, [nosplit edx*4+00h]
        fstp dword [esi]
        mov cl, byte [ebx]
        add eax, byte 2
        test cl, cl
        je short .3
        xor ecx, ecx
        mov cl, byte [ebx]
        fild word [eax]
        fmul dword [nosplit ecx*4+F32_0]
        fmul dword [esp]
        mov ecx, dword [byte esp+04h]
        add eax, byte 2
        fstp dword [ecx+ebp]
.3:
        mov ecx, dword [byte esp+014h]
        mov ebp, dword [byte esp+014h]
        add esi, byte 4
        inc edx
        inc ebx
        mov word [ecx], di
        xor ecx, ecx
        add ebp, byte 2
        mov cl, byte [byte ebx-01h]
        mov dword [byte esp+014h], ebp
        add edi, ecx
.4:
        mov ebp, dword [byte esp+08h]
        xor ecx, ecx
        mov cl, byte [byte ebp+0Ch]
        lea ecx, [ecx+ecx*2]
        cmp edx, ecx
        jge short .10
        cmp edx, byte 4Bh
        jl short .1
        mov dword [esp], 3F800000h
        jmp short .2
.5:
        mov ecx, dword [byte esp+08h]
        xor edx, edx
        jmp short .9
.6:
        cmp edx, byte 4Bh
        jl short .7
        mov dword [byte esp+010h], 3F800000h
        jmp short .8
.7:
        mov ebx, dword [byte esp+0Ch]
        mov ebx, dword [byte ebx+018h]
        mov dword [byte esp+010h], ebx
.8:
        fild word [eax]
        fmul dword [byte esp+010h]
        add esi, byte 4
        inc edx
        add eax, byte 2
        fstp dword [byte esi-04h]
.9:
        xor ebx, ebx
        mov bl, byte [byte ecx+0Ch]
        lea ebx, [ebx+ebx*2]
        cmp edx, ebx
        jl short .6
.10:
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push edx
        mov edx, dword [AnimNodePool]
        mov eax, dword [AnimStateCount]
        sub eax, edx
        mov dword [AnimStatesReady], eax
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; AllocAnimStateBlocks                            7716C  97 PC, low confidence
; Allocates the animation state blocks
;-----------------------------------------------------------------------------
AllocAnimStateBlocks:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edx, dword [AnimNodePool]
        mov eax, dword [AnimStateCount]
        sub eax, edx
        mov dword [AnimStatesReady], eax
        mov edx, eax
        je short .4
        mov ebx, dword [AnimNodePool]
        add ebx, eax
        mov dword [AnimNodePool], ebx
        mov ebx, dword [AnimNodeFreeList]
        add ebx, eax
        mov ecx, dword [AnimStateBlocks]
        mov dword [AnimNodeFreeList], ebx
        xor ebx, ebx
        test ecx, ecx
        jle short .4
        xor ecx, ecx
.1:
        mov edx, dword [AnimNodePool]
        add edx, ecx
        mov edi, dword [byte edx+020h]
        test edi, edi
        je short .2
        lea esi, [edi+eax]
        mov dword [byte edx+020h], esi
.2:
        mov ebp, dword [byte edx+024h]
        test ebp, ebp
        je short .3
        lea esi, [eax+ebp]
        mov dword [byte edx+024h], esi
.3:
        mov esi, dword [AnimStateBlocks]
        inc ebx
        add ecx, 358h
        cmp ebx, esi
        jl short .1
.4:
        mov eax, dword [AnimStateBlocks]
        xor ebx, ebx
        test eax, eax
        jle short .7
        xor ecx, ecx
.5:
        mov edx, dword [AnimNodePool]
        add edx, ecx
        cmp dword [edx], byte 0
        je short .6
        mov eax, dword [byte edx+028h]
        mov eax, dword [nosplit eax*4+MoveFuncPair]
        mov dword [edx], eax
        mov eax, dword [byte edx+028h]
        mov eax, dword [nosplit eax*4+MoveFuncTable]
        mov dword [byte edx+030h], eax
        mov eax, edx
        call InitAnimState
        mov esi, dword [byte edx+04h]
        mov eax, dword [edx]
        shl esi, 2
        mov eax, dword [byte eax+08h]
        add eax, esi
        mov dword [dword edx+0354h], eax
.6:
        mov edx, dword [AnimStateBlocks]
        inc ebx
        add ecx, 358h
        cmp ebx, edx
        jl short .5
.7:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; StartAnim                                       7724C  97 PC, low confidence
; Starts an animation
;-----------------------------------------------------------------------------
StartAnim:
        push ebx
        push ecx
        push esi
        mov ebx, eax
        mov esi, dword [byte eax+01Ch]
        mov eax, dword [edx]
        mov dword [byte ebx+028h], eax
        mov eax, dword [byte edx+04h]
        mov dword [byte ebx+02Ch], eax
        mov eax, dword [byte edx+08h]
        mov dword [ebx], eax
        fld dword [byte edx+014h]
        mov eax, ebx
        fstp dword [byte ebx+018h]
        call InitAnimState
        mov eax, dword [byte edx+010h]
        mov dword [byte ebx+04h], eax
        mov ecx, dword [byte edx+08h]
        shl eax, 2
        mov ecx, dword [byte ecx+08h]
        add eax, ecx
        mov dword [dword ebx+0354h], eax
        mov eax, dword [byte edx+08h]
        fild word [byte eax+020h]
        fmul dword [byte edx+018h]
        call __CHP
        fistp dword [byte ebx+08h]
        mov eax, dword [byte edx+024h]
        mov dword [byte ebx+030h], eax
        mov eax, dword [byte edx+0Ch]
        and esi, 510h
        mov edx, eax
        mov dword [byte ebx+01Ch], eax
        or edx, esi
        mov dword [byte ebx+01Ch], edx
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; StartAnimNow                                    772B8  97 PC, low confidence
; Starts an animation without blending
;-----------------------------------------------------------------------------
StartAnimNow:
        push ebx
        push ecx
        push esi
        push edi
        mov ebx, eax
        mov ecx, dword [eax]
        test ecx, ecx
        jne short .1
        call AllocAnimNode
        mov dword [ebx], eax
        jmp short .2
.1:
        mov eax, ecx
        call ResetAnimBlend
.2:
        mov ebx, dword [ebx]
        mov eax, ebx
        call StartAnim
        mov eax, dword [ReplayRecordBuf]
        mov esi, dword [byte ebx+08h]
        mov dword [byte ebx+010h], 3F800000h
        add eax, esi
        mov dx, word [byte ebx+01Ch]
        mov dword [byte ebx+0Ch], eax
        and edx, 0FFFFFAEFh
        mov edi, dword [byte ebx+030h]
        mov word [byte ebx+01Ch], dx
        test edi, edi
        je short .3
        mov eax, ebx
        call dword [byte ebx+030h]
.3:
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; BlendToAnim                                     77310  97 PC, low confidence
; Blends into a new animation
;-----------------------------------------------------------------------------
BlendToAnim:
        push ebx
        push ecx
        push edi
        mov ecx, dword [byte eax+020h]
        mov ebx, eax
        test ecx, ecx
        je short .2
.1:
        mov ebx, dword [byte ebx+020h]
        cmp dword [byte ebx+020h], byte 0
        jne short .1
.2:
        mov eax, ebx
        call InsertAnimNode
        mov ecx, eax
        mov ebx, eax
        call StartAnim
        mov eax, dword [ReplayRecordBuf]
        mov edi, dword [byte ecx+08h]
        add eax, edi
        mov dword [byte ecx+0Ch], eax
        mov eax, dword [byte esp+010h]
        mov dword [byte ecx+010h], eax
        cmp eax, 3F800000h
        je short .3
        or byte [byte ecx+01Ch], 10h
.3:
        cmp dword [byte ebx+030h], byte 0
        je short .4
        mov eax, ebx
        call dword [byte ebx+030h]
.4:
        pop edi
        pop ecx
        pop ebx
        ret 4
        db 08Dh,040h,00h
        push ebx
        push ecx
        mov ebx, eax
        test eax, eax
        je short .7
        mov ecx, dword [ebx]
        mov eax, dword [byte edx+08h]
        mov cl, byte [byte ecx+0Dh]
        cmp cl, byte [byte eax+0Dh]
        jne short .7
        test byte [byte ebx+01Dh], 1
        je short .5
        mov ecx, dword [byte ebx+020h]
        jmp short .6
.5:
        mov eax, ebx
        call InsertAnimNode
        mov ecx, eax
        or byte [byte ebx+01Dh], 1
.6:
        fld1
        mov eax, dword [byte ebx+04h]
        fsub dword [byte esp+0Ch]
        mov dword [byte edx+010h], eax
        mov eax, ecx
        fstp dword [byte ebx+010h]
        call StartAnim
        mov dl, byte [byte ecx+01Dh]
        mov eax, dword [byte esp+0Ch]
        or dl, 2
        mov dword [byte ecx+010h], eax
        mov byte [byte ecx+01Dh], dl
.7:
        pop ecx
        pop ebx
        ret 4
;-----------------------------------------------------------------------------
; ChangeAnim                                      773C0  97 PC, low confidence
; Changes a player's animation
;-----------------------------------------------------------------------------
ChangeAnim:
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        and esp, byte 0FFFFFFF8h
        mov edi, eax
        mov esi, edx
        mov dword [byte esp+08h], ebx
        mov ecx, dword [byte edx+08h]
        mov edx, dword [eax]
        test edx, edx
        jne short .1
        mov edx, esi
        call StartAnimNow
        jmp near .14
.1:
        mov eax, dword [edx]
        mov ebx, edx
        mov dl, byte [byte eax+0Eh]
        test dl, 10h
        je short .3
        test byte [byte ebx+01Ch], 80h
        je short .2
        mov eax, dword [byte eax+08h]
        mov dh, byte [byte ebx+01Ch]
        mov dword [byte ebx+04h], 0
        and dh, 7Fh
        mov dword [dword ebx+0354h], eax
        mov byte [byte ebx+01Ch], dh
.2:
        test byte [byte ecx+0Eh], 10h
        je near .7
        mov edx, dword [ebx]
        mov al, byte [byte ecx+0Dh]
        cmp al, byte [byte edx+0Dh]
        jne short .7
        mov eax, dword [byte ebx+04h]
        mov dword [byte esi+010h], eax
        jmp short .7
.3:
        test dl, 20h
        je short .6
        test byte [byte ebx+01Ch], 80h
        je short .7
        xor edx, edx
        mov dl, byte [byte eax+0Dh]
        mov ecx, ebx
        dec edx
        mov dword [esp], edx
        je short .4
        call GetAnimEntry
        jmp short .5
.4:
        mov eax, dword [byte eax+08h]
.5:
        mov dword [dword ebx+0354h], eax
        mov eax, dword [esp]
        mov dword [byte ecx+04h], eax
        and byte [byte ecx+01Ch], 7Fh
        or byte [byte ebx+01Dh], 8
        jmp short .7
.6:
        mov al, byte [byte eax+0Dh]
        and eax, 0FFh
        mov ecx, dword [byte ebx+04h]
        mov edx, dword [byte esp+08h]
        sub eax, ecx
        cmp eax, edx
        jg short .7
        mov dword [byte esp+08h], eax
.7:
        cmp dword [byte esp+08h], byte 0
        jg short .8
        mov edx, esi
        mov eax, ebx
        call StartAnim
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.8:
        mov eax, ebx
        call AddAnimNode
        mov dword [edi], eax
        mov dl, byte [byte ebx+01Dh]
        or dl, 2
        mov ecx, eax
        mov byte [byte ebx+01Dh], dl
        mov edx, esi
        mov dword [byte esp+04h], eax
        call StartAnim
        fild dword [byte esp+08h]
        fld1
        fdivrp
        or word [byte ecx+01Ch], 510h
        fst dword [byte ecx+014h]
        fstp dword [byte ecx+010h]
        mov eax, dword [byte ebx+0Ch]
        mov edx, dword [byte ecx+020h]
        mov dword [byte ecx+0Ch], eax
        mov eax, 2
        test edx, edx
        je short .10
.9:
        inc eax
        mov edx, dword [byte edx+020h]
        cmp eax, byte 4
        jge short .10
        test edx, edx
        jne short .9
.10:
        test edx, edx
        je short .13
.11:
        mov esi, dword [byte edx+020h]
        test esi, esi
        je short .12
        mov eax, esi
        call FreeAnimNode
        jmp short .11
.12:
        and byte [byte edx+01Dh], 0FEh
.13:
        mov eax, dword [byte esp+04h]
        cmp dword [byte eax+030h], byte 0
        je short .14
        mov edx, eax
        call dword [byte edx+030h]
.14:
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        push ebx
        sub esp, byte 4
        mov ebx, eax
        mov dword [esp], edx
        mov eax, dword [eax]
        mov dl, byte [byte eax+0Eh]
        test dl, 10h
        je short .15
        or byte [byte ebx+01Ch], 20h
        jmp short .17
.15:
        test dl, 20h
        je short .16
        or byte [byte ebx+01Ch], 40h
        jmp short .17
.16:
        mov al, byte [byte eax+0Dh]
        and eax, 0FFh
        mov edx, dword [byte ebx+04h]
        sub eax, edx
        mov dword [esp], eax
.17:
        cmp dword [esp], byte 0
        jg short .18
        mov eax, ebx
        call FreeAnimNode
        add esp, byte 4
        pop ebx
        ret
.18:
        fld dword [byte ebx+010h]
        fchs
        fild dword [esp]
        fdivp
        mov dx, word [byte ebx+01Ch]
        mov dword [byte ebx+030h], 0
        or edx, 410h
        mov word [byte ebx+01Ch], dx
        fst dword [byte ebx+014h]
        fadd dword [byte ebx+010h]
        mov eax, ebx
        fstp dword [byte ebx+010h]
        add esp, byte 4
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; InitAnimNodePool                                77590  97 PC, low confidence
; Sets up the free animation node list
;-----------------------------------------------------------------------------
InitAnimNodePool:
        push ebx
        push ecx
        push edx
        mov ebx, dword [AnimStateBlocks]
        xor edx, edx
        test ebx, ebx
        jle short .2
        xor eax, eax
.1:
        mov ebx, dword [AnimNodePool]
        add ebx, eax
        lea ecx, [dword ebx+0358h]
        mov dword [byte ebx+020h], ecx
        mov ebx, dword [AnimNodePool]
        mov dword [byte ebx+eax+01Ch], 0
        mov ebx, dword [AnimNodePool]
        mov dword [ebx+eax], 0
        inc edx
        mov ecx, dword [AnimStateBlocks]
        add eax, 358h
        cmp edx, ecx
        jl short .1
.2:
        mov eax, dword [AnimStateBlocks]
        dec eax
        imul edx, eax, dword 358h
        mov eax, dword [AnimNodePool]
        mov dword [byte edx+eax+020h], 0
        mov eax, dword [AnimStateBlocks]
        mov dword [AnimNodesFree], eax
        mov eax, dword [AnimNodePool]
        mov dword [AnimNodeFreeList], eax
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FreeAnimStates                                  77610  97 PC, low confidence
; Frees the animation states
;-----------------------------------------------------------------------------
FreeAnimStates:
        push ebx
        push ecx
        push edx
        mov ebx, dword [AnimNodePool]
        xor edx, edx
        push ebx
        mov dword [AnimStateBlocks], edx
        call FreeMemBlock
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AllocAnimStates                                 77630  97 PC, low confidence
; (count): allocates the "ANIMSTAT" block (count x 358h) and clears it
;-----------------------------------------------------------------------------
AllocAnimStates:
        push ebx
        push ecx
        push esi
        push edi
        mov dword [AnimStateBlocks], eax
        imul eax, dword 358h
        push edx
        push eax
        push str_ANIMSTAT
        mov ebx, 10h
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [AnimNodePool], eax
        mov dword [AnimStateCount], eax
        lea ecx, [byte eax+034h]
        mov edx, ebx
        sub ecx, eax
        mov eax, AnimStateBlocks
        call ReplayRegisterStates
        mov edx, dword [AnimStateBlocks]
        xor edi, edi
        test edx, edx
        jle short .2
        xor esi, esi
.1:
        mov eax, dword [AnimNodePool]
        mov ebx, ecx
        mov edx, ecx
        add eax, esi
        inc edi
        call ReplayRegisterStates
        mov ebx, dword [AnimStateBlocks]
        add esi, 358h
        cmp edi, ebx
        jl short .1
.2:
        mov eax, AllocAnimStateBlocks
        call ReplayRegisterObjects
        call InitAnimNodePool
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        push ecx
        push esi
        push edi
        mov esi, edx
        mov edi, ebx
        xor edx, edx
        call LoadModelByName
        push eax
        mov ebx, 8
        mov dword [esi], eax
        call InitModelInstance
        add esp, byte 4
        mov eax, dword [esi]
        xor edx, edx
        call CreateModelInstance
        push eax
        mov dword [edi], eax
        call UpdateModelInstance
        add esp, byte 4
        pop edi
        pop esi
        pop ecx
        ret
