; EA library: CreateBitmapForArt.
bits 32
%include "hockey.inc"
section s_11582A progbits alloc exec nowrite align=1
extern CreateBitmapDefault, CreateBitmapFromBlock, ShadeTable
global CreateBitmapForArt
        db 00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; CreateBitmapForArt                             115830  97 PC, low confidence
; Graphics library: creates a bitmap the size and depth of an art
;-----------------------------------------------------------------------------
CreateBitmapForArt:
        push ebx
        push esi
        mov esi, dword [byte esp+0Ch]
        mov ecx, dword [byte esp+010h]
        mov eax, esi
        push ecx
        mov edx, dword [byte esi+02h]
        mov ebx, dword [byte esi+04h]
        mov eax, dword [eax]
        and eax, byte 7Fh
        mov al, byte [dword eax+ShadeTable]
        push eax
        sar ebx, 10h
        push ebx
        sar edx, 10h
        push edx
        call CreateBitmapDefault
        add esp, byte 10h
        push byte 38h
        push eax
        mov ebx, eax
        mov dword [byte eax+02Ch], esi
        call CreateBitmapFromBlock
        add esp, byte 8
        mov eax, ebx
        pop esi
        pop ebx
        ret
