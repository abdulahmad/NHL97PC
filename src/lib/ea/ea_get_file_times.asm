; EA library: GetFileTimes, FileDateText, FreeArtArchive.
bits 32
%include "hockey.inc"
section s_11B993 progbits alloc exec nowrite align=1
extern ConvertArtSame, DrawShapeTriangleMapped, FreeMemBlock, SinCosLookup, str_Punct_FreeArtArchive
global GetFileTimes, FileDateText, FreeArtArchive
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; GetFileTimes                                   11B9A0  97 PC, low confidence
; Reads a file's date and time
;-----------------------------------------------------------------------------
GetFileTimes:
        push ebx
        sub esp, byte 8
        mov ebx, dword [byte esp+010h]
        lea eax, [byte esp+04h]
        push eax
        lea eax, [byte esp+04h]
        push eax
        mov edx, dword [byte esp+01Ch]
        push edx
        call SinCosLookup
        add esp, byte 0Ch
        mov eax, dword [byte esp+04h]
        mov dword [ebx], eax
        mov eax, dword [esp]
        mov dword [byte ebx+04h], eax
        mov ecx, eax
        mov dword [byte ebx+08h], eax
        neg ecx
        mov dword [byte ebx+08h], ecx
        mov eax, dword [byte esp+04h]
        mov dword [byte ebx+0Ch], eax
        add esp, byte 8
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        mov edx, dword [byte esp+08h]
        mov eax, dword [byte esp+0Ch]
        mov ebx, dword [edx]
        mov dword [eax], ebx
        mov ebx, dword [byte edx+08h]
        mov dword [byte eax+04h], ebx
        mov ebx, dword [byte edx+04h]
        mov dword [byte eax+08h], ebx
        mov edx, dword [byte edx+0Ch]
        mov dword [byte eax+0Ch], edx
        pop ebx
        ret
        db 00h,00h,00h
;-----------------------------------------------------------------------------
; FileDateText                                   11BA08  97 PC, low confidence
; Formats a file's date and time
;-----------------------------------------------------------------------------
FileDateText:
        push ebx
        push esi
        push edi
        push ebp
        mov ebx, dword [byte esp+018h]
        mov esi, dword [byte esp+014h]
        mov edi, dword [byte esp+01Ch]
        mov eax, dword [ebx]
        imul dword [esi]
        LD mov, ebp, eax
        LD mov, ecx, edx
        mov eax, dword [byte ebx+08h]
        imul dword [byte esi+04h]
        LD add, eax, ebp
        LD adc, edx, ecx
        shrd eax, edx, 10h
        mov dword [edi], eax
        mov eax, dword [byte ebx+04h]
        imul dword [esi]
        LD mov, ebp, eax
        LD mov, ecx, edx
        mov eax, dword [byte ebx+0Ch]
        imul dword [byte esi+04h]
        LD add, eax, ebp
        LD adc, edx, ecx
        shrd eax, edx, 10h
        mov dword [byte edi+04h], eax
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 00h
;-----------------------------------------------------------------------------
; FreeArtArchive                                 11BA50  97 PC, low confidence
; Frees an art archive
;-----------------------------------------------------------------------------
FreeArtArchive:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov ebx, dword [byte esp+044h]
        xor eax, eax
        mov esi, dword [ebx]
        mov al, byte [str_Punct_FreeArtArchive]
        and esi, 0FFh
        xor ebp, ebp
        cmp esi, eax
        je short .1
        xor eax, eax
        mov al, byte [str_Punct_FreeArtArchive]
        push eax
        push ebx
        call ConvertArtSame
        add esp, byte 8
        mov ebp, eax
        mov ebx, eax
.1:
        mov eax, dword [byte ebx+02h]
        sar eax, 10h
        mov edx, 1
        sub eax, byte 2
        mov esi, dword [byte ebx+04h]
        mov dword [byte esp+08h], eax
        mov edi, eax
        mov dword [byte esp+010h], eax
        mov eax, dword [byte esp+048h]
        sar esi, 10h
        push eax
        lea eax, [byte esp+04h]
        mov dword [byte esp+04h], edx
        push eax
        mov dword [byte esp+0Ch], edx
        sub esi, byte 2
        push ebx
        mov dword [byte esp+018h], edx
        mov dword [byte esp+020h], esi
        call DrawShapeTriangleMapped
        add esp, byte 0Ch
        mov edx, 1
        mov dword [esp], edi
        mov dword [byte esp+04h], esi
        mov dword [byte esp+08h], edx
        mov dword [byte esp+0Ch], esi
        mov dword [byte esp+010h], edx
        mov esi, dword [byte esp+048h]
        mov dword [byte esp+014h], edx
        lea edi, [byte esp+018h]
        lea esi, [byte esi+010h]
        movsd
        movsd
        mov esi, dword [byte esp+048h]
        lea eax, [byte esp+018h]
        lea edi, [byte esp+020h]
        lea esi, [byte esi+018h]
        push eax
        lea eax, [byte esp+04h]
        movsd
        movsd
        push eax
        lea edi, [byte esp+030h]
        mov esi, dword [byte esp+050h]
        push ebx
        movsd
        movsd
        call DrawShapeTriangleMapped
        add esp, byte 0Ch
        test ebp, ebp
        je short .2
        push ebp
        call FreeMemBlock
        add esp, byte 4
.2:
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 38h
        mov edi, dword [byte esp+04Ch]
        mov ebx, dword [byte esp+050h]
        mov esi, dword [byte esp+054h]
        xor eax, eax
        mov edx, dword [edi]
        mov al, byte [str_Punct_FreeArtArchive]
        and edx, 0FFh
        xor ebp, ebp
        cmp edx, eax
        je short .3
        xor eax, eax
        mov al, byte [str_Punct_FreeArtArchive]
        push eax
        push edi
        call ConvertArtSame
        add esp, byte 8
        mov ebp, eax
        mov edi, eax
.3:
        mov ecx, 1
        mov eax, dword [byte edi+02h]
        mov edx, dword [byte edi+04h]
        sar eax, 10h
        sar edx, 10h
        mov dword [esp], ecx
        mov dword [byte esp+04h], ecx
        mov dword [byte esp+0Ch], ecx
        sub eax, byte 2
        sub edx, byte 2
        mov dword [byte esp+08h], eax
        mov dword [byte esp+010h], eax
        mov dword [byte esp+014h], edx
        mov dword [byte esp+034h], eax
        mov eax, dword [esi]
        mov eax, dword [ebx+eax*8]
        mov dword [byte esp+018h], eax
        mov eax, dword [esi]
        mov eax, dword [byte ebx+eax*8+04h]
        mov dword [byte esp+01Ch], eax
        mov eax, dword [byte esi+04h]
        mov eax, dword [ebx+eax*8]
        mov dword [byte esp+020h], eax
        mov eax, dword [byte esi+04h]
        mov eax, dword [byte ebx+eax*8+04h]
        mov dword [byte esp+024h], eax
        mov eax, dword [byte esi+08h]
        mov eax, dword [ebx+eax*8]
        mov dword [byte esp+028h], eax
        mov eax, dword [byte esi+08h]
        mov eax, dword [byte ebx+eax*8+04h]
        mov dword [byte esp+02Ch], eax
        lea eax, [byte esp+018h]
        push eax
        lea eax, [byte esp+04h]
        push eax
        push edi
        mov dword [byte esp+03Ch], edx
        call DrawShapeTriangleMapped
        add esp, byte 0Ch
        mov edx, 1
        mov eax, dword [byte esp+034h]
        mov dword [byte esp+08h], edx
        mov dword [byte esp+010h], edx
        mov dword [esp], eax
        mov eax, dword [byte esp+030h]
        mov dword [byte esp+014h], edx
        mov dword [byte esp+04h], eax
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte esi+08h]
        mov eax, dword [ebx+eax*8]
        mov dword [byte esp+018h], eax
        mov eax, dword [byte esi+08h]
        mov eax, dword [byte ebx+eax*8+04h]
        mov dword [byte esp+01Ch], eax
        mov eax, dword [byte esi+0Ch]
        mov eax, dword [ebx+eax*8]
        mov dword [byte esp+020h], eax
        mov eax, dword [byte esi+0Ch]
        mov eax, dword [byte ebx+eax*8+04h]
        mov dword [byte esp+024h], eax
        mov eax, dword [esi]
        mov eax, dword [ebx+eax*8]
        mov dword [byte esp+028h], eax
        mov eax, dword [esi]
        mov eax, dword [byte ebx+eax*8+04h]
        mov dword [byte esp+02Ch], eax
        lea eax, [byte esp+018h]
        push eax
        lea eax, [byte esp+04h]
        push eax
        push edi
        call DrawShapeTriangleMapped
        add esp, byte 0Ch
        test ebp, ebp
        je short .4
        push ebp
        call FreeMemBlock
        add esp, byte 4
.4:
        add esp, byte 38h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
