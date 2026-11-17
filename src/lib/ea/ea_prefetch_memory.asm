; EA library: PrefetchMemory, PrefetchShape, CopyMemFast.
bits 32
%include "hockey.inc"
section s_1265C5 progbits alloc exec nowrite align=1
extern ShapeRowBytes
global PrefetchMemory, PrefetchShape, CopyMemFast
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; PrefetchMemory                                 1265D0  97 PC, low confidence
; Touches a range of memory every cache line to bring it into the cache
;-----------------------------------------------------------------------------
PrefetchMemory:
        push ebx
        mov ecx, dword [byte esp+08h]
        mov edx, dword [byte esp+0Ch]
        add edx, ecx
        lea ebx, [dword edx-0100h]
        mov eax, ecx
        cmp ecx, ebx
        jae short .2
.1:
        mov al, byte [eax]
        mov al, byte [byte eax+024h]
        mov al, byte [byte eax+040h]
        mov al, byte [byte eax+064h]
        mov al, byte [dword eax+080h]
        mov al, byte [dword eax+0A4h]
        mov al, byte [dword eax+0C0h]
        mov al, byte [dword eax+0E4h]
        add eax, 100h
        cmp eax, ebx
        jb short .1
.2:
        cmp eax, edx
        jae short .4
.3:
        mov bl, byte [eax]
        add eax, byte 20h
        cmp eax, edx
        jb short .3
.4:
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PrefetchShape                                  126624  97 PC, low confidence
; Touches the pixels of a shape to bring them into the cache
;-----------------------------------------------------------------------------
PrefetchShape:
        push ebx
        push esi
        mov esi, dword [byte esp+0Ch]
        mov ebx, dword [byte esi+04h]
        push esi
        sar ebx, 10h
        call ShapeRowBytes
        imul eax, ebx
        add esp, byte 4
        push eax
        lea eax, [byte esi+010h]
        push eax
        call PrefetchMemory
        add esp, byte 8
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CopyMemFast                                    12664C  97 PC, low confidence
; Copies memory with 64-bit FPU loads and stores
;-----------------------------------------------------------------------------
CopyMemFast:
        test eax, 7
        jne short .8
.1:
        sub ebx, byte 8
        js short .3
.2:
        fld qword [edx]
        fstp qword [eax]
        lea edx, [byte edx+08h]
        lea eax, [byte eax+08h]
        sub ebx, byte 8
        jns short .2
.3:
        add ebx, byte 8
        jne short .4
        ret
.4:
        push ecx
        cmp ebx, byte 4
        jb short .5
        mov ecx, dword [edx]
        mov dword [eax], ecx
        lea edx, [byte edx+04h]
        lea eax, [byte eax+04h]
        sub ebx, byte 4
.5:
        cmp ebx, byte 2
        jb short .6
        mov cx, word [edx]
        mov word [eax], cx
        lea edx, [byte edx+02h]
        lea eax, [byte eax+02h]
        sub ebx, byte 2
.6:
        cmp ebx, byte 1
        jb short .7
        mov cl, byte [edx]
        mov byte [eax], cl
        lea edx, [byte edx+01h]
        lea eax, [byte eax+01h]
        sub ebx, byte 1
.7:
        pop ecx
        ret
.8:
        push ecx
        test eax, 1
        je short .9
        cmp ebx, byte 1
        jl short .9
        mov cl, byte [edx]
        mov byte [eax], cl
        lea edx, [byte edx+01h]
        lea eax, [byte eax+01h]
        sub ebx, byte 1
.9:
        test eax, 2
        je short .10
        cmp ebx, byte 2
        jl short .10
        mov cx, word [edx]
        mov word [eax], cx
        lea edx, [byte edx+02h]
        lea eax, [byte eax+02h]
        sub ebx, byte 2
.10:
        test eax, 4
        je short .11
        cmp ebx, byte 4
        jl short .11
        mov ecx, dword [edx]
        mov dword [eax], ecx
        lea edx, [byte edx+04h]
        lea eax, [byte eax+04h]
        sub ebx, byte 4
.11:
        pop ecx
        jmp near .1
