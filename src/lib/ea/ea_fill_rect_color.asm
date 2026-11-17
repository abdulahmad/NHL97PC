; EA library: FillRectColor, FillRowColor, FillRect.
bits 32
%include "hockey.inc"
section s_FDC67 progbits alloc exec nowrite align=1
extern BlitCore, FillColor, FillMemPattern, FillRectSpans, FillRowFuncTable, ScreenBitsPerPixel, SetupRectFill, StoreLittleEndian
extern str_Punct_FreeArtArchive
global FillRectColor, FillRectColor_48, FillRectColor_5C, FillRectColor_6C, FillRectColor_80, FillRowColor, FillRect
        db 00h
;-----------------------------------------------------------------------------
; FillRectColor                                   FDC68  97 PC, low confidence
; Clips a rectangle to the screen and fills it with a colour; followed by the
; row fillers
;-----------------------------------------------------------------------------
FillRectColor:
        push ebp
        LD mov, ebp, esp
        add esp, byte 0FFFFFFC8h
        push ebx
        lea eax, [byte ebp-038h]
        push eax
        push dword [byte ebp+014h]
        push dword [byte ebp+010h]
        push dword [byte ebp+0Ch]
        push dword [byte ebp+08h]
        call SetupRectFill
        add esp, byte 14h
        LD or, eax, eax
        jne short .1
        lea ebx, [byte ebp-038h]
        cmp dword [byte ebx+018h], byte 0
        jle short .1
        mov eax, dword [byte ebp+018h]
        mov dword [byte ebx+01Ch], eax
        push ebx
        call FillRectSpans
        add esp, byte 4
.1:
        pop ebx
        leave
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
FillRectColor_48:
        mov eax, edx
        mov edx, ebx
        mov ebx, dword [FillColor]
        sar edx, 1
        jmp near FillMemPattern
        db 08Dh,040h,00h
FillRectColor_5C:
        mov eax, edx
        mov edx, ebx
        mov ebx, dword [FillColor]
        jmp near FillMemPattern
        db 090h
FillRectColor_6C:
        mov eax, edx
        mov edx, ebx
        mov ebx, dword [FillColor]
        add edx, edx
        jmp near FillMemPattern
        db 08Dh,040h,00h
FillRectColor_80:
        push ecx
        push esi
        mov esi, edx
.2:
        push byte 3
        mov edx, dword [FillColor]
        push edx
        push esi
        call StoreLittleEndian
        add esp, byte 0Ch
        add esi, byte 3
        dec ebx
        jne short .2
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FillRowColor                                    FDD08  97 PC, low confidence
; Fills one row of pixels with a colour
;-----------------------------------------------------------------------------
FillRowColor:
        mov eax, edx
        mov edx, ebx
        mov ebx, dword [FillColor]
        shl edx, 2
        jmp near FillMemPattern
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FillRect                                     FDD1C  95 PC, medium confidence
; Graphics library: fill a rectangle (x, y, w, h, colour) on the current draw
; target, by pixel depth
;-----------------------------------------------------------------------------
FillRect:
        push ebx
        sub esp, byte 14h
        mov eax, dword [byte esp+02Ch]
        mov dl, byte [ScreenBitsPerPixel]
        cmp dl, 8
        jb short .1
        jbe short .2
        cmp dl, 0Fh
        jb short .6
        cmp dl, 10h
        jbe short .3
        jmp short .6
.1:
        cmp dl, 4
        je short .4
        jmp short .6
.2:
        and eax, 0FFh
        mov edx, eax
        shl edx, 8
        or eax, edx
        mov edx, eax
        shl edx, 10h
        jmp short .5
.3:
        and eax, 0FFFFh
        mov edx, eax
        shl edx, 10h
        jmp short .5
.4:
        and eax, byte 0Fh
        mov edx, eax
        shl edx, 4
.5:
        or eax, edx
.6:
        mov dword [FillColor], eax
        xor dl, dl
        xor eax, eax
        mov byte [esp], dl
        mov al, byte [str_Punct_FreeArtArchive]
        mov edx, dword [esp]
        and eax, 0FFh
        mov ecx, FillRowFuncTable
        or edx, eax
        mov eax, dword [byte esp+024h]
        mov dword [esp], edx
        mov ebx, edx
        mov edx, dword [byte esp+01Ch]
        and ebx, 0FFh
        mov word [byte esp+04h], ax
        mov eax, dword [byte esp+028h]
        mov dword [esp], ebx
        mov ebx, dword [byte esp+020h]
        mov word [byte esp+06h], ax
        mov eax, esp
        call BlitCore
        add esp, byte 14h
        pop ebx
        ret
