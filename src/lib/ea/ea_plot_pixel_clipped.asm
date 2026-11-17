; EA library: PlotPixelClipped.
bits 32
%include "hockey.inc"
section s_12D513 progbits alloc exec nowrite align=1
extern bcopy, ClipLeftCol, ClipRight, ClipTopRow, DrawDestBuffer, DrawDestOffset, DrawDestPitch, ScreenBitsPerPixel
extern ScreenBuffer, ScreenHeight, VesaSetBank
global PlotPixelClipped
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; PlotPixelClipped                               12D520  97 PC, low confidence
; Plots one pixel when it lies inside the clip window
;-----------------------------------------------------------------------------
PlotPixelClipped:
        push ebx
        push esi
        push edi
        sub esp, byte 4
        mov eax, dword [byte esp+018h]
        mov edx, dword [byte esp+014h]
        mov ecx, dword [ClipTopRow]
        xor ebx, ebx
        cmp edx, ecx
        jl near .10
        cmp edx, dword [ClipRight]
        jge near .10
        cmp eax, dword [ClipLeftCol]
        jl near .10
        cmp eax, dword [ScreenHeight]
        jge near .10
        db 08Bh,015h                            ; insn: mov edx,[DrawDestBuffer]
        dd DrawDestBuffer
        db 0C1h,0E0h,02h                        ; insn: shl eax,2
        lea esi, [edx+eax]
        mov eax, dword [byte esp+014h]
        mov edx, dword [DrawDestOffset]
        shl eax, 2
        add eax, edx
        mov edx, dword [esi]
        mov ecx, dword [eax]
        mov esi, dword [ScreenBuffer]
        add edx, ecx
        test esi, esi
        je short .1
        mov edi, edx
        sar edi, 10h
        mov esi, 10000h
        mov eax, edi
        and edx, 0FFFFh
        call VesaSetBank
        sub esi, edx
        xor eax, eax
        lea ecx, [nosplit esi*8+00h]
        mov al, byte [ScreenBitsPerPixel]
        cmp ecx, eax
        jge short .1
        mov eax, dword [DrawDestPitch]
        push esi
        add eax, edx
        lea edx, [byte esp+04h]
        push edx
        push eax
        call bcopy
        mov edx, 4
        add esp, byte 0Ch
        lea eax, [byte edi+01h]
        sub edx, esi
        call VesaSetBank
        push edx
        lea edx, [byte esp+04h]
        add edx, esi
        push edx
        mov eax, dword [DrawDestPitch]
        push eax
        call bcopy
        lea eax, [byte esp+0Ch]
        add esp, byte 0Ch
        jmp short .2
.1:
        mov eax, dword [DrawDestPitch]
        add eax, edx
.2:
        mov dl, byte [ScreenBitsPerPixel]
        cmp dl, 0Fh
        jb short .3
        cmp dl, 10h
        jbe short .7
        cmp dl, 18h
        jb near .10
        jbe short .8
        cmp dl, 20h
        je short .9
        jmp short .10
.3:
        cmp dl, 4
        jb short .10
        jbe short .4
        cmp dl, 8
        je short .6
        jmp short .10
.4:
        test byte [byte esp+014h], 1
        je short .5
        mov al, byte [eax]
        mov ebx, eax
        and ebx, 0FFh
        sar ebx, 4
        and ebx, byte 0Fh
        jmp short .10
.5:
        xor ebx, ebx
        mov bl, byte [eax]
        and ebx, byte 0Fh
        jmp short .10
.6:
        xor ebx, ebx
        mov bl, byte [eax]
        jmp short .10
.7:
        xor ebx, ebx
        mov bx, word [eax]
        jmp short .10
.8:
        mov ecx, 3
        mov eax, dword [byte ecx+eax-04h]
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov ebx, eax
        jmp short .10
.9:
        mov ebx, dword [eax]
.10:
        mov eax, ebx
        add esp, byte 4
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        mov edx, dword [byte esp+0Ch]
        push edx
        mov ebx, dword [byte esp+0Ch]
        push ebx
        call PlotPixelClipped
        add esp, byte 8
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h
