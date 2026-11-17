; Palette fades.
bits 32
%include "hockey.inc"
section s_D67D1 progbits alloc exec nowrite align=1
extern CountFrameTick, FadePaletteBuffer, GetPaletteRange, IntroPalette, memcpy_, memset_, ServiceIdle, WaitRetraceEdges
global FadePalette, FadeOut
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FadePalette                                  D67D4  96 PC, medium confidence
; (out, palette, steps): fades the screen palette from or to black
;-----------------------------------------------------------------------------
FadePalette:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov edi, edx
        mov dword [esp], ebx
        test ebx, ebx
        jne short .1
        inc ebx
        mov dword [esp], ebx
.1:
        test eax, eax
        jne short .2
        mov ebx, 300h
        mov eax, FadePaletteBuffer
        mov edx, edi
        call memcpy_
        push edi
        push dword 100h
        push byte 0
        call GetPaletteRange
        add esp, byte 0Ch
        jmp short .3
.2:
        mov ebx, 300h
        mov eax, FadePaletteBuffer
        xor edx, edx
        call memset_
.3:
        mov ebp, 1
.4:
        mov edx, FadePaletteBuffer
        mov eax, edi
        xor ebx, ebx
        xor esi, esi
.5:
        mov cl, byte [eax]
        mov ch, byte [edx]
        cmp cl, ch
        jae short .7
        xor ecx, ecx
        mov esi, dword [esp]
        mov cl, byte [eax]
        add ecx, esi
        movzx esi, byte [edx]
        cmp ecx, esi
        jle short .6
        mov cl, byte [edx]
        mov byte [eax], cl
        jmp short .9
.6:
        mov cl, byte [esp]
        add byte [eax], cl
        jmp short .9
.7:
        jbe short .10
        xor ecx, ecx
        mov esi, dword [esp]
        mov cl, byte [eax]
        sub ecx, esi
        mov esi, ecx
        xor ecx, ecx
        mov cl, byte [edx]
        cmp esi, ecx
        jge short .8
        mov byte [eax], cl
        jmp short .9
.8:
        mov cl, byte [esp]
        sub byte [eax], cl
.9:
        mov esi, ebp
.10:
        inc edx
        inc ebx
        inc eax
        cmp ebx, 300h
        jl short .5
        test esi, esi
        je short .11
        call WaitRetraceEdges
        push edi
        push dword 100h
        push byte 0
        call CountFrameTick
        add esp, byte 0Ch
.11:
        call ServiceIdle
        test esi, esi
        jne short .4
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FadeOut                                      D68AC  96 PC, medium confidence
; (steps): fades the current palette to black
;-----------------------------------------------------------------------------
FadeOut:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        push IntroPalette
        push dword 100h
        push byte 0
        call GetPaletteRange
        add esp, byte 0Ch
        test ebx, ebx
        jne short .1
        inc ebx
.1:
        mov edx, IntroPalette
        mov eax, 1
        call FadePalette
        pop edx
        pop ecx
        pop ebx
        ret
