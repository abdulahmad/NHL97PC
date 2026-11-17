; EA library: SetClipWindow, ResetClipWindow.
bits 32
%include "hockey.inc"
section s_102BB8 progbits alloc exec nowrite align=1
extern ClipBottom, ClipLeftCol, ClipRight, ClipTopRow, ScreenHeight, ScreenWidth
global SetClipWindow, ResetClipWindow
;-----------------------------------------------------------------------------
; SetClipWindow                               102BB8  96 PC, medium confidence
; (x0, y0, x1, y1): sets the drawing clip window, limited to the screen
;-----------------------------------------------------------------------------
SetClipWindow:
        push ebx
        mov eax, dword [byte esp+08h]
        mov edx, dword [byte esp+0Ch]
        mov ecx, dword [byte esp+010h]
        mov ebx, dword [byte esp+014h]
        cmp eax, byte 0
        jge short .1
        LD xor, eax, eax
.1:
        cmp ecx, byte 0
        jge short .2
        LD xor, ecx, ecx
.2:
        cmp edx, dword [ScreenWidth]
        jle short .3
        mov edx, dword [ScreenWidth]
.3:
        cmp ebx, dword [ClipBottom]
        jle short .4
        mov ebx, dword [ClipBottom]
.4:
        mov dword [ClipTopRow], eax
        mov dword [ClipLeftCol], ecx
        mov dword [ClipRight], edx
        mov dword [ScreenHeight], ebx
        pop ebx
        ret
        db 00h,00h,00h,00h
;-----------------------------------------------------------------------------
; ResetClipWindow                                102C10  97 PC, low confidence
; Sets the clip window back to the whole screen
;-----------------------------------------------------------------------------
ResetClipWindow:
        push ebx
        mov edx, dword [ClipBottom]
        push edx
        push byte 0
        mov ebx, dword [ScreenWidth]
        push ebx
        push byte 0
        call SetClipWindow
        add esp, byte 10h
        pop ebx
        ret
