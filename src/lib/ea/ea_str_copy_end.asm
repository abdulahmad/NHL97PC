; EA library: StrCopyEnd.
bits 32
%include "hockey.inc"
section s_11BFC5 progbits alloc exec nowrite align=1
global StrCopyEnd
;-----------------------------------------------------------------------------
; StrCopyEnd                                     11BFC5  97 PC, low confidence
; Copies a string and returns its end
;-----------------------------------------------------------------------------
StrCopyEnd:
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov esi, edx
        mov ecx, 0FFFFFFFFh
        mov edi, ebp
        xor al, al
        push es
        jecxz .1
        mov edx, ds
        mov es, edx
        repne scasb
        jne short .1
        dec edi
        db 066h
        db 0A9h
.1:
        mov edi, ecx
        pop es
        mov eax, edi
.2:
        test ebx, ebx
        je short .3
        mov dl, byte [esi]
        mov byte [eax], dl
        test dl, dl
        je short .3
        inc eax
        inc esi
        dec ebx
        jmp short .2
.3:
        mov byte [eax], 0
        mov eax, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
