; Name index files: new, load, save, remove and count.
bits 32
%include "hockey.inc"
section s_862F8 progbits alloc exec nowrite align=1
extern AllocMemBlock, FreeMemBlock, LoadFileAllocQuiet, memcpy_, memset_, SaveDataFile, ServiceIdle, str_backslash3
extern str_NAMEINDEX, strcat_, strcmp_, strcpy_, strlen_
global NameIndexNew, NameIndexLoad, NameIndexSave, NameIndexFree, LoadNameIndex, NameIndexRemove, NameIndexCount, NameIndexPath
global NameIndexLimit
        db 00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; NameIndexNew                                 86300  96 PC, medium confidence
; (name, dir): a new NAMEINDEX block (magic 2C093h, directory, title, no
; entries, first id 1000)
;-----------------------------------------------------------------------------
NameIndexNew:
        push ebx
        push ecx
        push esi
        mov esi, eax
        mov ebx, edx
        push byte 20h
        push dword 0A4h
        push str_NAMEINDEX
        call AllocMemBlock
        mov ecx, eax
        add esp, byte 0Ch
        test eax, eax
        je short .1
        mov dword [eax], 2C093h
        add eax, byte 8
        mov edx, ebx
        mov dword [byte eax-04h], 0
        call strcpy_
        lea eax, [byte ecx+015h]
        mov edx, esi
        mov ebx, 36h
        call strcpy_
        lea eax, [byte ecx+06Eh]
        mov dword [byte ecx+066h], 0
        xor edx, edx
        mov dword [byte ecx+06Ah], 3E8h
        call memset_
        mov eax, ecx
.1:
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; NameIndexLoad                                86368  96 PC, medium confidence
; (dir, file): loads a NAMEINDEX file (dir\file), checks its magic; 0 when
; missing or bad
;-----------------------------------------------------------------------------
NameIndexLoad:
        push ebx
        push ecx
        push esi
        push edi
        sub esp, byte 64h
        mov ebx, eax
        mov esi, edx
        mov edx, eax
        mov eax, esp
        call strcpy_
        mov eax, esp
        call strlen_
        cmp byte [byte esp+eax-01h], 5Ch
        je short .1
        mov edx, str_backslash3
        mov eax, esp
        call strcat_
.1:
        mov eax, esp
        mov edx, esi
        call strcat_
        call ServiceIdle
        push byte 20h
        lea eax, [byte esp+04h]
        push eax
        call LoadFileAllocQuiet
        add esp, byte 8
        mov edx, eax
        mov edi, eax
        call ServiceIdle
        test edx, edx
        jne short .2
        xor eax, eax
        jmp short .6
.2:
        cmp dword [edx], 2C093h
        je short .3
        push edx
        call FreeMemBlock
        add esp, byte 4
        xor eax, eax
        add esp, byte 64h
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.3:
        lea ecx, [byte edx+015h]
        mov dword [byte edx+04h], 1
        mov edx, ebx
        mov eax, ecx
        call strcmp_
        test eax, eax
        je short .4
        mov edx, ebx
        mov eax, ecx
        call strcpy_
.4:
        lea ebx, [byte edi+08h]
        mov edx, esi
        mov eax, ebx
        call strcmp_
        test eax, eax
        je short .5
        mov edx, esi
        mov eax, ebx
        call strcpy_
.5:
        mov eax, edi
.6:
        add esp, byte 64h
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; NameIndexSave                                86424  96 PC, medium confidence
; Writes a changed NAMEINDEX block back to its file (header plus 36h-byte
; entries)
;-----------------------------------------------------------------------------
NameIndexSave:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 64h
        mov ebx, eax
        test eax, eax
        je near .6
        cmp dword [eax], 2C093h
        je short .1
        xor eax, eax
        jmp near .6
.1:
        cmp dword [byte eax+04h], byte 0
        je short .2
        mov eax, 1
        add esp, byte 64h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        lea edx, [byte eax+015h]
        mov eax, esp
        call strcpy_
        mov eax, esp
        call strlen_
        cmp byte [byte esp+eax-01h], 5Ch
        je short .3
        mov edx, str_backslash3
        mov eax, esp
        call strcat_
.3:
        mov eax, esp
        lea edx, [byte ebx+08h]
        call strcat_
        mov esi, dword [byte ebx+066h]
        test esi, esi
        jle short .4
        lea edx, [byte esi-01h]
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        shl eax, 2
        sub eax, edx
        add eax, eax
        add eax, 0A4h
        push eax
        jmp short .5
.4:
        push dword 0A4h
.5:
        push ebx
        lea eax, [byte esp+08h]
        push eax
        call SaveDataFile
        add esp, byte 0Ch
.6:
        add esp, byte 64h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; NameIndexFree                                864C4  96 PC, medium confidence
; (save, index): saves the index when asked and changed, then frees it
;-----------------------------------------------------------------------------
NameIndexFree:
        push ecx
        test edx, edx
        jne short .1
        xor eax, eax
        pop ecx
        ret
.1:
        cmp dword [edx], 2C093h
        je short .2
        xor eax, eax
        pop ecx
        ret
.2:
        cmp dword [byte edx+04h], byte 0
        jne short .3
        test eax, eax
        je short .3
        mov eax, edx
        call NameIndexSave
        test eax, eax
        je short .4
.3:
        push edx
        call FreeMemBlock
        mov eax, 1
        add esp, byte 4
.4:
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LoadNameIndex                                   86500  97 PC, low confidence
; Loads a name index file
;-----------------------------------------------------------------------------
LoadNameIndex:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, eax
        mov dword [esp], edx
        mov ebp, ebx
        test edx, edx
        je near .3
        test ebx, ebx
        je near .3
        test eax, eax
        je near .3
        cmp dword [eax], 2C093h
        jne near .4
        mov ecx, dword [byte eax+066h]
        test ecx, ecx
        je short .1
        lea eax, [nosplit ecx*8+00h]
        sub eax, ecx
        shl eax, 2
        sub eax, ecx
        add eax, eax
        push byte 20h
        add eax, 0A4h
        push eax
        push str_NAMEINDEX
        call AllocMemBlock
        mov edx, dword [byte esi+066h]
        mov ecx, eax
        dec edx
        mov edi, eax
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        shl eax, 2
        sub eax, edx
        add eax, eax
        add esp, byte 0Ch
        lea ebx, [dword eax+0A4h]
        mov edx, esi
        mov eax, ecx
        call memcpy_
        push esi
        call FreeMemBlock
        add esp, byte 4
        jmp short .2
.1:
        mov edi, eax
.2:
        mov eax, dword [byte edi+066h]
        inc eax
        mov ecx, dword [byte edi+066h]
        mov dword [byte edi+066h], eax
        lea eax, [nosplit ecx*8+00h]
        mov esi, dword [byte edi+06Ah]
        sub eax, ecx
        inc esi
        shl eax, 2
        mov dword [byte edi+06Ah], esi
        sub eax, ecx
        lea esi, [byte edi+06Eh]
        add eax, eax
        add esi, eax
        mov edx, dword [esp]
        mov eax, esi
        mov dword [byte edi+04h], 0
        call strcpy_
        lea eax, [byte esi+0Dh]
        mov edx, ebp
        call strcpy_
        mov eax, edi
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.3:
        mov eax, esi
.4:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
        push ecx
        push esi
        mov ecx, ebx
        test eax, eax
        je short .9
        cmp dword [eax], 2C093h
        jne short .5
        mov esi, dword [byte eax+066h]
        test esi, esi
        jne short .6
.5:
        xor eax, eax
        pop esi
        pop ecx
        ret
.6:
        sub edx, 3E8h
        test edx, edx
        jl short .7
        lea ebx, [byte esi-01h]
        cmp edx, ebx
        jle short .8
.7:
        xor eax, eax
        pop esi
        pop ecx
        ret
.8:
        lea ebx, [byte eax+06Eh]
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        shl eax, 2
        sub eax, edx
        add eax, eax
        add ebx, eax
        mov edx, ecx
        lea eax, [byte ebx+0Dh]
        call strcpy_
        mov eax, 1
.9:
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; NameIndexRemove                              86644  96 PC, medium confidence
; (index, id): removes the entry with that id (1000 + n); returns the new
; block
;-----------------------------------------------------------------------------
NameIndexRemove:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov dword [byte esp+04h], eax
        mov dword [esp], edx
        test eax, eax
        je near .6
        cmp dword [eax], 2C093h
        jne near .6
        mov ecx, dword [byte eax+066h]
        cmp ecx, byte 1
        jne short .1
        mov ebp, eax
        jmp near .5
.1:
        lea eax, [byte ecx-01h]
        lea ecx, [nosplit eax*4+00h]
        add ecx, eax
        shl ecx, 3
        add ecx, eax
        push byte 20h
        shl ecx, 2
        push ecx
        push str_NAMEINDEX
        mov ebx, 0A4h
        xor edi, edi
        call AllocMemBlock
        add esp, byte 0Ch
        mov ebp, eax
        mov edx, dword [byte esp+04h]
        mov ecx, ebp
        call memcpy_
        mov eax, ebp
        mov esi, dword [byte esp+04h]
        add ecx, byte 6Eh
        mov edx, dword [byte eax+066h]
        add esi, byte 6Eh
        test edx, edx
        jle short .4
        mov eax, dword [esp]
        sub eax, 3E8h
        mov dword [byte esp+08h], eax
.2:
        cmp edi, dword [byte esp+08h]
        je short .3
        mov ebx, 36h
        mov edx, esi
        mov eax, ecx
        call memcpy_
        add ecx, byte 36h
.3:
        inc edi
        mov ebx, dword [byte ebp+066h]
        add esi, byte 36h
        cmp edi, ebx
        jl short .2
.4:
        mov ecx, dword [byte esp+04h]
        push ecx
        call FreeMemBlock
        add esp, byte 4
.5:
        mov edx, dword [byte ebp+066h]
        mov dword [byte ebp+04h], 0
        dec edx
        mov eax, ebp
        mov dword [byte ebp+066h], edx
.6:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; NameIndexCount                                  86718  97 PC, low confidence
; Returns the number of entries in a name index
;-----------------------------------------------------------------------------
NameIndexCount:
        push ecx
        test eax, eax
        jne short .1
        mov eax, 0FFFFFFFFh
        pop ecx
        ret
.1:
        cmp dword [eax], 2C093h
        jne short .2
        mov ecx, dword [byte eax+066h]
        test ecx, ecx
        jne short .3
.2:
        mov eax, 0FFFFFFFFh
        pop ecx
        ret
.3:
        test edx, edx
        jl short .4
        lea eax, [byte ecx-01h]
        cmp edx, eax
        jle short .5
.4:
        mov eax, 0FFFFFFFFh
        pop ecx
        ret
.5:
        lea eax, [dword edx+03E8h]
        pop ecx
        ret
;-----------------------------------------------------------------------------
; NameIndexPath                                86754  96 PC, medium confidence
; (index, id, out): dir\file of an entry; 0 when the id is not in the index
;-----------------------------------------------------------------------------
NameIndexPath:
        push ecx
        push esi
        mov ecx, eax
        test eax, eax
        je near .6
        cmp dword [eax], 2C093h
        jne short .1
        cmp dword [byte eax+066h], byte 0
        jne short .2
.1:
        xor eax, eax
        pop esi
        pop ecx
        ret
.2:
        lea eax, [dword edx-03E8h]
        test eax, eax
        jl short .3
        mov edx, dword [byte ecx+066h]
        dec edx
        cmp eax, edx
        jle short .4
.3:
        xor eax, eax
        pop esi
        pop ecx
        ret
.4:
        mov edx, eax
        shl eax, 3
        sub eax, edx
        shl eax, 2
        sub eax, edx
        lea esi, [byte ecx+06Eh]
        add eax, eax
        lea edx, [byte ecx+015h]
        add esi, eax
        mov eax, ebx
        call strcpy_
        mov eax, ebx
        call strlen_
        cmp byte [byte ebx+eax-01h], 5Ch
        je short .5
        mov edx, str_backslash3
        mov eax, ebx
        call strcat_
.5:
        mov edx, esi
        mov eax, ebx
        call strcat_
        mov eax, 1
.6:
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; NameIndexLimit                                  867D4  97 PC, low confidence
; Returns the entry limit of a name index
;-----------------------------------------------------------------------------
NameIndexLimit:
        test eax, eax
        jne short .1
        mov eax, 3E8h
        ret
.1:
        cmp dword [eax], 2C093h
        je short .2
        mov eax, 0FFFFFFFFh
        ret
.2:
        mov eax, dword [byte eax+06Ah]
        ret
