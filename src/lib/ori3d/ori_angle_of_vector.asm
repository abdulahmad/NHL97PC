; 3D library: AngleOfVector, SinInterp, CosInterp, IF@DFMOD.
bits 32
%include "hockey.inc"
section s_100700 progbits alloc exec nowrite align=1
extern __fprem_chk, AngleOfVectorJumpTable, AtanTable, Div64By32, MathErrorFlags, Shl64, SinTable, str_Punct_AngleOfVector
global AngleOfVector, AngleOfVector_91, AngleOfVector_93, AngleOfVector_9A, AngleOfVector_A3, AngleOfVector_A7, AngleOfVector_AE, AngleOfVector_B0
global AngleOfVector_B5, SinInterp, CosInterp, IF@DFMOD
;-----------------------------------------------------------------------------
; AngleOfVector                                  100700  97 PC, low confidence
; Returns the angle of a 2D vector in 1024ths of a turn, by octant
;-----------------------------------------------------------------------------
AngleOfVector:
        push ebx
        push esi
        sub esp, byte 8
        mov eax, dword [byte esp+014h]
        mov edx, dword [byte esp+018h]
        xor ebx, ebx
        test edx, edx
        jge short .1
        mov ebx, 2
        neg edx
.1:
        test eax, eax
        jge short .2
        or bl, 4
        neg eax
.2:
        cmp eax, edx
        jne short .3
        mov eax, 2000h
        jmp short .5
.3:
        cmp edx, eax
        jge short .4
        mov esi, eax
        or bl, 1
        mov eax, edx
        mov edx, esi
.4:
        push edx
        lea esi, [byte esp+04h]
        mov edx, 20h
        call Shl64
        mov edx, dword [byte esp+08h]
        push edx
        mov ecx, dword [byte esp+08h]
        push ecx
        call Div64By32
        mov esi, eax
        shr eax, 18h
        lea edx, [nosplit eax*4+00h]
        shr esi, 8
        mov eax, dword [dword edx+AtanTable]
        mov edx, dword [dword edx+str_Punct_AngleOfVector]
        and esi, 0FFFFh
        sub edx, eax
        imul edx, esi
        shr edx, 10h
        add eax, edx
.5:
        cmp ebx, byte 7
        ja short AngleOfVector_B5
        jmp dword [nosplit cs:ebx*4+AngleOfVectorJumpTable]
AngleOfVector_91:
        neg eax
AngleOfVector_93:
        add eax, 4000h
        jmp short AngleOfVector_B5
AngleOfVector_9A:
        neg eax
        add eax, 8000h
        jmp short AngleOfVector_B5
AngleOfVector_A3:
        neg eax
        jmp short AngleOfVector_B5
AngleOfVector_A7:
        add eax, 0FFFF8000h
        jmp short AngleOfVector_B5
AngleOfVector_AE:
        neg eax
AngleOfVector_B0:
        sub eax, 4000h
AngleOfVector_B5:
        add esp, byte 8
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; SinInterp                                      1007C0  97 PC, low confidence
; Returns the sine of a fine angle, interpolating between table entries
;-----------------------------------------------------------------------------
SinInterp:
        push ebx
        push esi
        mov ebx, dword [byte esp+0Ch]
        sar ebx, 6
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
        mov esi, eax
        mov eax, ebx
        mov ebx, dword [byte esp+0Ch]
        and ebx, byte 3Fh
        imul ebx, dword 6487Eh
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
        sar eax, 2
        sar ebx, 9
        imul eax, ebx
        sar eax, 15h
        add eax, esi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CosInterp                                      100830  97 PC, low confidence
; Returns the cosine of a fine angle, interpolating between table entries
;-----------------------------------------------------------------------------
CosInterp:
        push ebx
        push esi
        mov ebx, dword [byte esp+0Ch]
        sar ebx, 6
        mov eax, ebx
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
        mov ebx, eax
        mov eax, dword [byte esp+0Ch]
        and eax, byte 3Fh
        imul eax, dword 6487Eh
        neg ebx
        sar ebx, 2
        sar eax, 9
        imul eax, ebx
        sar eax, 15h
        add eax, esi
        pop esi
        pop ebx
        ret
        db 00h
;-----------------------------------------------------------------------------
; IF@DFMOD                                                     1008A2  library
; Run-time library fmod core: x87 partial remainder (checked version when the FDIV workaround is on)
;-----------------------------------------------------------------------------
IF@DFMOD:
        test byte [MathErrorFlags], 1
        jne short .1
        fprem
        jmp short .2
.1:
        call __fprem_chk
.2:
        fnstsw ax
        sahf
        jp short IF@DFMOD
        fstp st1
        ret
        fld qword [byte esp+0Ch]
        fld qword [byte esp+04h]
        call IF@DFMOD
        ret 10h
