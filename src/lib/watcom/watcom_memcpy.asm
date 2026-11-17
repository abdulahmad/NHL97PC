; Watcom C runtime: memcpy_.
bits 32
%include "hockey.inc"
section s_FC2FD progbits alloc exec nowrite align=1
global memcpy_
;-----------------------------------------------------------------------------
; memcpy_                                                       FC2FD  library
; Run-time library memcpy: copies a block of memory
;-----------------------------------------------------------------------------
memcpy_:
        push ecx
        push esi
        push edi
        mov ecx, ebx
        mov esi, edx
        mov edi, eax
        push es
        mov eax, ds
        mov es, eax
        push edi
        mov eax, ecx
        shr ecx, 2
        repne movsd
        LD mov, cl, al
        and cl, 3
        db 0F2h,0A4h                            ; insn: repne movsb
        db 05Fh                                 ; insn: pop edi
        db 07h                                  ; insn: pop es
        db 089h,0F8h                            ; insn: mov eax,edi
        pop edi
        pop esi
        pop ecx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
