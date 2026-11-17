; File I/O: exists, delete, create, open, seek, read, write and close.
bits 32
%include "hockey.inc"
section s_E2375 progbits alloc exec nowrite align=1
extern DosFileInfo, fclose_, fopen_, fread_, fseek_, ftell_, fwrite_, str_FILEclose
extern str_FILEcreate, str_FILEdelete, str_FILEopen, str_FILEread, str_FILEseek, str_FILEseekend, str_RB, str_WB
extern UnlinkJump
global FileExists, FileDelete, FileCreate, FileOpen, FileSeek, FileSeekEnd, FileTell, FileReadRecord
global FileWriteRecord, FileClose, FileLength
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FileExists                                      E2378  97 PC, low confidence
; (path): 1 when the file exists (DosFileInfo)
;-----------------------------------------------------------------------------
FileExists:
        push ecx
        push edx
        push eax
        call DosFileInfo
        add esp, byte 4
        pop edx
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FileDelete                                   E2388  97 PC, medium confidence
; Deletes a file; returns 1, or 0 with the error text "FILEdelete" in eax
;-----------------------------------------------------------------------------
FileDelete:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        push eax
        call DosFileInfo
        add esp, byte 4
        test eax, eax
        je short .2
        mov eax, ebx
        call UnlinkJump
        test eax, eax
        jne short .1
        mov eax, str_FILEdelete
        xor eax, eax
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov eax, 1
.2:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FileCreate                                   E23BC  97 PC, medium confidence
; Fopen "w+b"; returns 1, or 0 with the error text "FILEcreate"
;-----------------------------------------------------------------------------
FileCreate:
        push ebx
        mov ebx, edx
        mov edx, str_WB
        call fopen_
        mov dword [ebx], eax
        test eax, eax
        jne short .1
        mov eax, str_FILEcreate
        xor eax, eax
        pop ebx
        ret
.1:
        mov eax, 1
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FileOpen                                     E23E0  97 PC, medium confidence
; Fopen "r+b"; returns 1, or 0 with the error text "FILEopen"
;-----------------------------------------------------------------------------
FileOpen:
        push ebx
        mov ebx, edx
        mov edx, str_RB
        call fopen_
        mov dword [ebx], eax
        test eax, eax
        jne short .1
        mov eax, str_FILEopen
        xor eax, eax
        pop ebx
        ret
.1:
        mov eax, 1
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FileSeek                                     E2404  97 PC, medium confidence
; Fseek from the start; returns 1, or 0 with the error text "FILEseek"
;-----------------------------------------------------------------------------
FileSeek:
        push ebx
        xor ebx, ebx
        call fseek_
        test eax, eax
        je short .1
        mov eax, str_FILEseek
        xor eax, eax
        pop ebx
        ret
.1:
        mov eax, 1
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FileSeekEnd                                  E2420  97 PC, medium confidence
; Fseek to the end of the file; returns 1, or 0 with the error text
; "FILEseekend"
;-----------------------------------------------------------------------------
FileSeekEnd:
        push ebx
        push edx
        mov ebx, 2
        xor edx, edx
        call fseek_
        test eax, eax
        je short .1
        mov eax, str_FILEseekend
        xor eax, eax
        pop edx
        pop ebx
        ret
.1:
        mov eax, 1
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FileTell                                     E2444  97 PC, medium confidence
; (file, &pos): ftell; returns 0 on error
;-----------------------------------------------------------------------------
FileTell:
        call ftell_
        mov dword [edx], eax
        cmp eax, byte 0FFFFFFFFh
        setne al
        and eax, 0FFh
        ret
        db 090h
;-----------------------------------------------------------------------------
; FileReadRecord                               E2458  97 PC, medium confidence
; Freads one record; returns 1, or 0 with the error text "FILEread"
;-----------------------------------------------------------------------------
FileReadRecord:
        push ecx
        push esi
        mov esi, eax
        mov eax, edx
        mov edx, ebx
        mov ebx, 1
        mov ecx, esi
        call fread_
        cmp eax, byte 1
        je short .1
        mov eax, str_FILEread
        xor eax, eax
        pop esi
        pop ecx
        ret
.1:
        test byte [byte esi+0Ch], 20h
        je short .2
        mov eax, str_FILEread
        xor eax, eax
        pop esi
        pop ecx
        ret
.2:
        mov eax, 1
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FileWriteRecord                              E2494  97 PC, medium confidence
; Fwrites one record; returns 1, or 0 with the error text "FILEread" (the
; game reuses the read message)
;-----------------------------------------------------------------------------
FileWriteRecord:
        push ecx
        push esi
        mov esi, eax
        mov eax, edx
        mov edx, ebx
        mov ebx, 1
        mov ecx, esi
        call fwrite_
        cmp eax, byte 1
        je short .1
        mov eax, str_FILEread
        xor eax, eax
        pop esi
        pop ecx
        ret
.1:
        test byte [byte esi+0Ch], 20h
        je short .2
        mov eax, str_FILEread
        xor eax, eax
        pop esi
        pop ecx
        ret
.2:
        mov eax, 1
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FileClose                                    E24D0  97 PC, medium confidence
; Fclose; returns 1, or 0 with the error text "FILEclose"
;-----------------------------------------------------------------------------
FileClose:
        push edx
        mov edx, eax
        mov eax, dword [eax]
        call fclose_
        test eax, eax
        je short .1
        mov eax, str_FILEclose
        xor eax, eax
        pop edx
        ret
.1:
        mov dword [edx], eax
        mov eax, 1
        pop edx
        ret
;-----------------------------------------------------------------------------
; FileLength                                   E24F0  97 PC, medium confidence
; (file): the file's length (ftell at the end), keeping the position
;-----------------------------------------------------------------------------
FileLength:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ecx, eax
        call ftell_
        mov ebx, 2
        mov esi, eax
        xor edx, edx
        mov eax, ecx
        call fseek_
        mov eax, ecx
        call ftell_
        mov edx, esi
        xor ebx, ebx
        mov edi, eax
        mov eax, ecx
        call fseek_
        mov eax, edi
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        push esi
        push edi
        sub esp, byte 4
        mov ebx, eax
        push eax
        call DosFileInfo
        add esp, byte 4
        test eax, eax
        je short .1
        mov edx, esp
        mov eax, ebx
        call FileOpen
        test eax, eax
        je short .1
        mov ecx, dword [esp]
        mov ebx, 2
        mov eax, ecx
        xor edx, edx
        call ftell_
        mov esi, eax
        mov eax, ecx
        call fseek_
        mov eax, ecx
        call ftell_
        mov edx, esi
        xor ebx, ebx
        mov edi, eax
        mov eax, ecx
        call fseek_
        mov eax, esp
        call FileClose
        mov eax, edi
.1:
        add esp, byte 4
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
