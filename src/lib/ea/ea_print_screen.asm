; EA library: PrintScreen.
bits 32
%include "hockey.inc"
section s_12FACC progbits alloc exec nowrite align=1
extern BlitConverted, ConvertArtAt, SetScreenTarget
global PrintScreen
;-----------------------------------------------------------------------------
; PrintScreen                                    12FACC  97 PC, low confidence
; Calls the BIOS print-screen interrupt; followed by small screen helpers
;-----------------------------------------------------------------------------
PrintScreen:
        push ebx
        int 5
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        push ecx
        push esi
        push edi
        mov esi, eax
        mov edi, edx
        call SetScreenTarget
        push ebx
        push edi
        mov edx, dword [byte esi+02Ch]
        push edx
        call ConvertArtAt
        add esp, byte 0Ch
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
        push ecx
        push esi
        push edi
        mov esi, eax
        mov edi, edx
        call SetScreenTarget
        push ebx
        push edi
        mov edx, dword [byte esi+02Ch]
        push edx
        call BlitConverted
        add esp, byte 0Ch
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
