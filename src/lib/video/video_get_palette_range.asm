; Video: GetPaletteRange.
bits 32
%include "hockey.inc"
section s_1008CC progbits alloc exec nowrite align=1
extern MenuScreenBitmap, PaletteWords
global GetPaletteRange
;-----------------------------------------------------------------------------
; GetPaletteRange                                1008CC  97 PC, low confidence
; Reads a range of palette entries from the VGA DAC into a buffer
;-----------------------------------------------------------------------------
GetPaletteRange:
        push ebp
        LD mov, ebp, esp
        push ebx
        push edi
        cmp dword [MenuScreenBitmap], byte 8
        jg short .2
        mov edi, dword [byte ebp+010h]
        mov edx, 3C7h
        mov eax, dword [byte ebp+08h]
        out dx, al
        mov ebx, dword [byte ebp+0Ch]
        lea ecx, [ebx+ebx*2]
        mov edx, 3C9h
.1:
        in al, dx
        mov byte [edi], al
        inc edi
        dec ecx
        jne short .1
        pop edi
        pop ebx
        leave
        ret
.2:
        mov edi, dword [byte ebp+010h]
        mov eax, dword [byte ebp+08h]
        lea ebx, [nosplit eax*4+PaletteWords]
        mov ecx, dword [byte ebp+0Ch]
.3:
        mov al, byte [byte ebx+02h]
        shr al, 2
        mov byte [edi], al
        mov al, byte [byte ebx+01h]
        shr al, 2
        mov byte [byte edi+01h], al
        mov al, byte [ebx]
        shr al, 2
        mov byte [byte edi+02h], al
        sub ecx, byte 1
        lea ebx, [byte ebx+04h]
        lea edi, [byte edi+03h]
        jg short .3
        pop edi
        pop ebx
        leave
        ret
