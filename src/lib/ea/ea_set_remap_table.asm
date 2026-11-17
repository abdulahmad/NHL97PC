; EA library: SetRemapTable, GetRemapTable.
bits 32
%include "hockey.inc"
section s_102CDA progbits alloc exec nowrite align=1
extern RemapTable
global SetRemapTable, GetRemapTable
        db 00h,00h
;-----------------------------------------------------------------------------
; SetRemapTable                                  102CDC  97 PC, low confidence
; Copies a 256-entry colour remap table into the current one
;-----------------------------------------------------------------------------
SetRemapTable:
        push ebp
        LD mov, ebp, esp
        push esi
        push edi
        mov ecx, 40h
        mov esi, dword [byte ebp+08h]
        mov edi, RemapTable
        rep movsd
        pop edi
        pop esi
        leave
        ret
;-----------------------------------------------------------------------------
; GetRemapTable                                  102CF4  97 PC, low confidence
; Copies the current 256-entry colour remap table out
;-----------------------------------------------------------------------------
GetRemapTable:
        push ebp
        LD mov, ebp, esp
        push esi
        push edi
        mov edi, dword [byte ebp+08h]
        mov esi, RemapTable
        mov ecx, 40h
        rep movsd
        pop edi
        pop esi
        leave
        ret
        push ebp
        LD mov, ebp, esp
        push ebx
        push esi
        push edi
        mov ecx, dword [byte ebp+0Ch]
        mov esi, dword [byte ebp+010h]
        mov edi, RemapTable
        mov ebx, dword [byte ebp+08h]
        lea edi, [ebx+edi]
        shr ecx, 2
        rep movsd
        mov ecx, dword [byte ebp+0Ch]
        and ecx, byte 3
        rep movsb
        pop edi
        pop esi
        pop ebx
        leave
        ret
        db 00h,00h,00h
        mov eax, dword [byte esp+04h]
