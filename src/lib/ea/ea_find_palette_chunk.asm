; EA library: FindPaletteChunk, ExpandPalette6To8, CopyPaletteRGB.
bits 32
%include "hockey.inc"
section s_1261A1 progbits alloc exec nowrite align=1
global FindPaletteChunk, ExpandPalette6To8, CopyPaletteRGB
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FindPaletteChunk                               1261A4  97 PC, low confidence
; Walks a shape's attached chunks and returns the first palette chunk
;-----------------------------------------------------------------------------
FindPaletteChunk:
        mov edx, dword [byte esp+04h]
        test edx, edx
        je short .5
.1:
        mov eax, dword [edx]
        and eax, 0FFh
        cmp eax, byte 22h
        je short .2
        cmp eax, byte 24h
        je short .2
        cmp eax, byte 23h
        je short .2
        cmp eax, byte 29h
        je short .2
        cmp eax, byte 2Ah
        jne short .3
.2:
        mov eax, edx
        ret
.3:
        mov eax, dword [edx]
        sar eax, 8
        test eax, eax
        je short .4
        add eax, edx
.4:
        mov edx, eax
        test eax, eax
        jne short .1
.5:
        xor eax, eax
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        push ebx
        push esi
        push edi
        push ebp
        mov edi, dword [byte esp+014h]
        xor esi, esi
        test edi, edi
        jle short .7
        mov ebx, dword [byte esp+01Ch]
        mov ecx, dword [byte esp+018h]
        mov ebp, 3Fh
.6:
        xor eax, eax
        mov al, byte [ecx]
        imul eax, dword 0FFh
        lea edx, [byte eax+020h]
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        xor edx, edx
        mov byte [ebx], al
        mov dl, byte [byte ecx+01h]
        imul edx, dword 0FFh
        add edx, byte 20h
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        mov byte [byte ebx+01h], al
        xor eax, eax
        mov al, byte [byte ecx+02h]
        imul eax, dword 0FFh
        lea edx, [byte eax+020h]
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        add ebx, byte 3
        add ecx, byte 3
        inc esi
        mov byte [byte ebx-01h], al
        cmp esi, edi
        jl short .6
.7:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ExpandPalette6To8                              126264  97 PC, low confidence
; Expands a 6-bit-per-component palette to 8-bit RGBA entries
;-----------------------------------------------------------------------------
ExpandPalette6To8:
        push ebx
        push esi
        push edi
        push ebp
        mov edi, dword [byte esp+014h]
        xor esi, esi
        test edi, edi
        jle near .4
        mov ecx, dword [byte esp+018h]
        mov ebx, dword [byte esp+01Ch]
        mov ebp, 3Fh
.1:
        cmp esi, 0FFh
        jne short .2
        xor eax, eax
        jmp short .3
.2:
        mov eax, 0FFh
.3:
        xor edx, edx
        mov byte [byte ebx+03h], al
        mov dl, byte [ecx]
        imul edx, dword 0FFh
        add edx, byte 20h
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        mov byte [byte ebx+02h], al
        xor eax, eax
        mov al, byte [byte ecx+01h]
        imul eax, dword 0FFh
        lea edx, [byte eax+020h]
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        mov byte [byte ebx+01h], al
        xor eax, eax
        mov al, byte [byte ecx+02h]
        imul eax, dword 0FFh
        lea edx, [byte eax+020h]
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        add ebx, byte 4
        add ecx, byte 3
        inc esi
        mov byte [byte ebx-04h], al
        cmp esi, edi
        jl short .1
.4:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push esi
        push edi
        push ebp
        mov edi, dword [byte esp+014h]
        xor esi, esi
        test edi, edi
        jle short .6
        mov ebx, dword [byte esp+01Ch]
        mov ecx, dword [byte esp+018h]
        mov ebp, 0FFh
.5:
        xor eax, eax
        mov al, byte [ecx]
        imul eax, byte 3Fh
        lea edx, [dword eax+080h]
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        xor edx, edx
        mov byte [ebx], al
        mov dl, byte [byte ecx+01h]
        imul edx, byte 3Fh
        add edx, 80h
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        mov byte [byte ebx+01h], al
        xor eax, eax
        mov al, byte [byte ecx+02h]
        imul eax, byte 3Fh
        lea edx, [dword eax+080h]
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        add ebx, byte 3
        add ecx, byte 3
        inc esi
        mov byte [byte ebx-01h], al
        cmp esi, edi
        jl short .5
.6:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CopyPaletteRGB                                 126364  97 PC, low confidence
; Copies an 8-bit-per-component palette into RGBA entries
;-----------------------------------------------------------------------------
CopyPaletteRGB:
        push ebx
        push esi
        push edi
        sub esp, byte 4
        mov esi, dword [byte esp+014h]
        xor ebx, ebx
        test esi, esi
        jle short .4
        mov edx, dword [byte esp+018h]
        mov eax, dword [byte esp+01Ch]
.1:
        cmp ebx, 0FFh
        jne short .2
        xor edi, edi
        mov dword [esp], edi
        jmp short .3
.2:
        mov dword [esp], 0FFh
.3:
        mov cl, byte [esp]
        mov byte [byte eax+03h], cl
        mov cl, byte [edx]
        mov byte [byte eax+02h], cl
        mov cl, byte [byte edx+01h]
        add edx, byte 3
        mov byte [byte eax+01h], cl
        add eax, byte 4
        mov cl, byte [byte edx-01h]
        inc ebx
        mov byte [byte eax-04h], cl
        cmp ebx, esi
        jl short .1
.4:
        add esp, byte 4
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
        push ebx
        push esi
        push edi
        push ebp
        mov edi, dword [byte esp+014h]
        xor esi, esi
        test edi, edi
        jle short .6
        mov ecx, dword [byte esp+01Ch]
        mov ebx, dword [byte esp+018h]
        mov ebp, 0FFh
.5:
        xor edx, edx
        mov dl, byte [byte ebx+02h]
        imul edx, byte 3Fh
        add edx, 80h
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        xor edx, edx
        mov byte [ecx], al
        mov dl, byte [byte ebx+01h]
        imul edx, byte 3Fh
        add edx, 80h
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        mov byte [byte ecx+01h], al
        xor eax, eax
        mov al, byte [ebx]
        imul eax, byte 3Fh
        lea edx, [dword eax+080h]
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        add ecx, byte 3
        add ebx, byte 4
        inc esi
        mov byte [byte ecx-01h], al
        cmp esi, edi
        jl short .5
.6:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push esi
        mov esi, dword [byte esp+0Ch]
        xor ebx, ebx
        test esi, esi
        jle short .8
        mov eax, dword [byte esp+014h]
        mov edx, dword [byte esp+010h]
.7:
        mov cl, byte [byte edx+02h]
        mov byte [eax], cl
        mov cl, byte [byte edx+01h]
        add edx, byte 4
        mov byte [byte eax+01h], cl
        add eax, byte 3
        mov cl, byte [byte edx-04h]
        inc ebx
        mov byte [byte eax-01h], cl
        cmp ebx, esi
        jl short .7
.8:
        pop esi
        pop ebx
        ret
