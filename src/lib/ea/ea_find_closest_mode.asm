; EA library: FindClosestMode.
bits 32
%include "hockey.inc"
section s_103066 progbits alloc exec nowrite align=1
extern ModeTableBpp, ModeTableHeight, ModeTableWidth
global FindClosestMode
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FindClosestMode                                103068  97 PC, low confidence
; Picks the video mode closest to a wanted resolution
;-----------------------------------------------------------------------------
FindClosestMode:
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, eax
        mov edi, edx
        mov ebp, eax
        shl ebp, 4
        mov eax, edx
        mov ebp, dword [dword ebp+ModeTableWidth]
        sub eax, ebp
        cdq
        xor eax, edx
        sub eax, edx
        mov edx, 5000h
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov edx, eax
        cmp edi, ebp
        jge short .1
        lea edx, [nosplit eax*2+00h]
.1:
        mov edi, esi
        shl edi, 4
        mov eax, ebx
        mov edi, dword [dword edi+ModeTableHeight]
        sub eax, edi
        mov ebp, edx
        cdq
        xor eax, edx
        sub eax, edx
        mov edx, 8000h
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov edx, eax
        cmp ebx, edi
        jge short .2
        lea edx, [nosplit eax*2+00h]
.2:
        mov edi, esi
        shl edi, 4
        mov eax, ecx
        mov edi, dword [dword edi+ModeTableBpp]
        sub eax, edi
        mov dword [esp], edx
        cdq
        xor eax, edx
        sub eax, edx
        mov edx, 1E000h
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov ebx, eax
        cmp ecx, edi
        jge short .3
        lea eax, [nosplit ebx*2+00h]
.3:
        shl esi, 4
        mov ebx, dword [dword esi+ModeTableBpp]
        mov edx, eax
        cmp ebx, byte 8
        jg short .4
        cmp ecx, byte 8
        jle short .4
        add eax, eax
        lea edx, [dword eax+0C8h]
.4:
        mov eax, dword [esp]
        add eax, ebp
        add eax, edx
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        ret
