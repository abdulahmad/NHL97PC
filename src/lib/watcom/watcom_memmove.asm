; Watcom C runtime: memmove_, memcmp_, cget_string_, uncget_string_, vsscanf_ and 2 more.
bits 32
%include "hockey.inc"
section s_11BC80 progbits alloc exec nowrite align=1
extern __fprtf_, ScanFormat
global memmove_, memcmp_, cget_string_, uncget_string_, vsscanf_, sscanf_, fprintf_
;-----------------------------------------------------------------------------
; memmove_                                                     11BC80  library
; Run-time library memmove: copies a block that may overlap
;-----------------------------------------------------------------------------
memmove_:
        push ecx
        push esi
        push edi
        mov ecx, ebx
        cmp edx, eax
        je short .2
        jae short .1
        lea edi, [edx+ebx]
        cmp edi, eax
        jbe short .1
        lea esi, [byte edi-01h]
        lea edi, [eax+ebx]
        mov edx, ds
        dec edi
        push es
        mov es, edx
        std
        dec esi
        dec edi
        shr ecx, 1
        db 066h,0F3h,0A5h                       ; insn: rep movsw
        adc ecx, ecx
        inc esi
        inc edi
        db 066h,0F3h,0A4h                       ; insn: rep movsb
        pop es
        cld
        pop edi
        pop esi
        pop ecx
        ret
.1:
        mov esi, edx
        mov edi, eax
        mov edx, ds
        push es
        mov es, edx
        push ecx
        shr ecx, 2
        rep movsd
        pop ecx
        and ecx, byte 3
        rep movsb
        pop es
.2:
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; memcmp_                                                      11BCCD  library
; Run-time library memcmp: compares two blocks
;-----------------------------------------------------------------------------
memcmp_:
        push ecx
        push esi
        push edi
        mov ecx, ebx
        mov edi, edx
        mov esi, eax
        push es
        mov eax, ds
        mov es, eax
        xor eax, eax
        repe cmpsb
        je short .1
        sbb eax, eax
        sbb eax, byte 0FFFFFFFFh
.1:
        pop es
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; cget_string_                                                 11BCEB  library
; Run-time library: reads the next character of a string (sscanf input)
;-----------------------------------------------------------------------------
cget_string_:
        push ebx
        push edx
        mov ebx, dword [byte eax+08h]
        xor edx, edx
        mov dl, byte [ebx]
        test edx, edx
        je short .1
        inc ebx
        mov dword [byte eax+08h], ebx
        mov eax, edx
        pop edx
        pop ebx
        ret
.1:
        mov bl, byte [byte eax+010h]
        or bl, 2
        mov edx, 0FFFFFFFFh
        mov byte [byte eax+010h], bl
        mov eax, edx
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; uncget_string_                                               11BD14  library
; Run-time library: puts a character back (sscanf input)
;-----------------------------------------------------------------------------
uncget_string_:
        dec dword [byte edx+08h]
        ret
;-----------------------------------------------------------------------------
; vsscanf_                                                     11BD18  library
; Run-time library vsscanf: reads formatted data from a string
;-----------------------------------------------------------------------------
vsscanf_:
        push ecx
        push esi
        sub esp, byte 14h
        db 0B9h                                 ; insn: mov ecx,cget_string_
        dd cget_string_
        db 0BEh                                 ; insn: mov esi,uncget_string_
        dd uncget_string_
        mov dword [byte esp+08h], eax
        mov eax, esp
        mov dword [esp], ecx
        mov dword [byte esp+04h], esi
        call ScanFormat
        add esp, byte 14h
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; sscanf_                                                      11BD3F  library
; Run-time library sscanf: reads formatted data from a string
;-----------------------------------------------------------------------------
sscanf_:
        push ebx
        push edx
        sub esp, byte 4
        lea eax, [byte esp+018h]
        mov ebx, esp
        mov edx, dword [byte esp+014h]
        mov dword [esp], eax
        mov eax, dword [byte esp+010h]
        call vsscanf_
        add esp, byte 4
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; fprintf_                                                     11BD60  library
; Run-time library fprintf: formats to a stream
;-----------------------------------------------------------------------------
fprintf_:
        push ebx
        push edx
        sub esp, byte 4
        lea eax, [byte esp+018h]
        mov ebx, esp
        mov edx, dword [byte esp+014h]
        mov dword [esp], eax
        mov eax, dword [byte esp+010h]
        call __fprtf_
        add esp, byte 4
        pop edx
        pop ebx
        ret
