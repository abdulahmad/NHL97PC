; Video: SaveTextMode, RestoreTextMode.
bits 32
%include "hockey.inc"
section s_126480 progbits alloc exec nowrite align=1
extern AddExitHandler, SavedTextColumns, SavedTextMode, SavedTextPage, SavedTextRows
global SaveTextMode, RestoreTextMode
;-----------------------------------------------------------------------------
; SaveTextMode                                126480  96 PC, medium confidence
; Saves the BIOS text mode, page, columns and rows before the game changes the screen
;-----------------------------------------------------------------------------
SaveTextMode:
        push ebx
        cmp byte [SavedTextMode], 0
        jne short .1
        mov ah, 0Fh
        int 10h
        mov byte [SavedTextMode], al
        mov al, byte [0410h]
        mov byte [SavedTextPage], al
        mov ax, word [044Ah]
        mov word [SavedTextColumns], ax
        mov al, byte [0484h]
        mov byte [SavedTextRows], al
        push RestoreTextMode
        call AddExitHandler
        add esp, byte 4
.1:
        pop ebx
        ret
;-----------------------------------------------------------------------------
; RestoreTextMode                             1264C2  96 PC, medium confidence
; Restores the text mode saved by SaveTextMode
;-----------------------------------------------------------------------------
RestoreTextMode:
        pusha
        cmp byte [SavedTextMode], 0
        je near .4
        mov al, byte [SavedTextPage]
        mov byte [0410h], al
        cmp byte [SavedTextMode], 3
        jne near .2
        cmp word [SavedTextColumns], byte 50h
        jne near .2
        cmp byte [SavedTextRows], 2Ah
        jb near .2
        cmp byte [SavedTextRows], 31h
        ja near .2
        je short .1
        mov ax, 1201h
        mov bl, 30h
        int 10h
        LD xor, eax, eax
        mov al, byte [SavedTextMode]
        int 10h
        mov ax, 1112h
        LD xor, ebx, ebx
        int 10h
        mov word [044Ah], 50h
        mov byte [0484h], 2Ah
        mov byte [0485h], 8
        mov word [0460h], 507h
        mov word [044Ch], 1AE0h
        mov cx, 507h
        mov ah, 1
        int 10h
        jmp short .3
.1:
        mov ax, 1202h
        mov bl, 30h
        int 10h
        LD xor, eax, eax
        mov al, byte [SavedTextMode]
        int 10h
        mov ax, 1112h
        LD xor, ebx, ebx
        db 0CDh,010h                            ; insn: int 10h
        db 066h,0C7h,05h,04Ah,04h,00h,00h,050h,00h ; insn: mov word [44Ah],50h
        mov byte [0484h], 31h
        mov byte [0485h], 8
        mov word [0460h], 507h
        mov word [044Ch], 1F40h
        mov cx, 507h
        mov ah, 1
        int 10h
        jmp short .3
.2:
        LD xor, eax, eax
        mov al, byte [SavedTextMode]
        int 10h
.3:
        mov al, byte [SavedTextPage]
        mov byte [0410h], al
        mov byte [SavedTextMode], 0
.4:
        popa
        ret
