; Database files: pages and B-tree index keys.
bits 32
%include "hockey.inc"
section s_D7A70 progbits alloc exec nowrite align=1
extern AllocClearBlock, CompareKeyBytes, CopyAndClear, CopyBytesOk, DbFlags, DbPageBuffer, DbPageEnd, DbPageNext
extern DbPageSlots, DbPageStack, DbPageWanted, FileClose, FileCreate, FileOpen, FileReadRecord, FileSeek
extern FileWriteRecord, FreePtr, str_PAGESTACK, ZeroBytesOk
global AllocPageStack, FreeDbPages, OldestDbPageSlot, ReadDbPage, WriteDbPage, GetDbPage, InitDbFileHeader, CreateDbFile
global OpenDbFile, CloseDbFile, CopyIndexNode, FlushDbPage, SplitIndexNode, InsertKeyUp, CompareIndexKey, InsertKeyInNode
global AddIndexKey, MergeIndexNodes, RemoveKeyFromNode, DeleteKeyFromNode, DeleteIndexKey, SearchIndexNode, FindIndexKey, LeftmostKey
global RightmostKey, FirstOrLastKey, FindLastKey, FindFirstKey, PrevKeyInNode, NextKeyInNode, StepIndexKey, NextIndexKey
global PrevIndexKey, BuildKey, BuildKeyFromLong, BuildKeyFromString, ParseKey, KeyToLong
;-----------------------------------------------------------------------------
; AllocPageStack                                  D7A70  97 PC, low confidence
; Allocates the front end's "PAGESTACK" block
;-----------------------------------------------------------------------------
AllocPageStack:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        mov edx, 20h
        mov eax, DbPageSlots
        call ZeroBytesOk
        test ebx, ebx
        jge short .1
        xor ebx, ebx
.1:
        add ebx, byte 16h
        mov edx, dword [DbPageStack]
        mov dword [DbPageNext], ebx
        test edx, edx
        jne near .4
        mov edx, ebx
        shl edx, 8
        add edx, ebx
        shl edx, 2
        mov eax, str_PAGESTACK
        sub edx, ebx
        mov ebx, DbPageStack
        shl edx, 2
        call AllocClearBlock
        test eax, eax
        je near .5
        mov ebx, dword [DbPageNext]
        mov edx, ebx
        shl edx, 8
        add edx, ebx
        shl edx, 2
        sub edx, ebx
        mov eax, dword [DbPageStack]
        shl edx, 2
        call ZeroBytesOk
        mov ebx, dword [DbPageNext]
        mov eax, dword [DbPageStack]
        shl ebx, 0Ch
        add eax, ebx
        mov dword [DbPageBuffer], eax
        mov eax, dword [DbPageNext]
        mov ebx, dword [DbPageBuffer]
        shl eax, 2
        add ebx, eax
        xor edx, edx
        mov dword [DbPageEnd], ebx
        jmp short .3
.2:
        mov ecx, dword [DbPageBuffer]
        mov dword [ecx+eax*4], 0FFFFFFFFh
        mov ebx, dword [DbPageEnd]
        mov dword [ebx+eax*8], 0
        mov ebx, dword [DbPageEnd]
        inc edx
        mov dword [byte ebx+eax*8+04h], 0FFFFFFFFh
.3:
        mov ebx, dword [DbPageNext]
        movsx eax, dx
        cmp eax, ebx
        jl short .2
        or byte [DbFlags], 1
        mov eax, 1
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        xor eax, eax
.5:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; FreeDbPages                                     D7B64  97 PC, low confidence
; Frees the database page cache
;-----------------------------------------------------------------------------
FreeDbPages:
        push edx
        test byte [DbFlags], 1
        je short .1
        mov eax, DbPageStack
        call FreePtr
        mov dl, byte [DbFlags]
        and dl, 0FEh
        mov eax, 1
        mov byte [DbFlags], dl
        pop edx
        ret
.1:
        xor eax, eax
        pop edx
        ret
        db 08Bh,0C0h
        push ebx
        push edx
        test eax, eax
        je short .2
        mov ebx, 20h
        mov edx, eax
        mov eax, DbPageSlots
        call CopyBytesOk
.2:
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; OldestDbPageSlot                                D7BB0  97 PC, low confidence
; Database page cache: the slot to reuse (a free one, else the least recently
; used by the counters at DbPageBuffer)
;-----------------------------------------------------------------------------
OldestDbPageSlot:
        push ebx
        push ecx
        push edx
        push esi
        mov eax, dword [DbPageBuffer]
        cmp dword [eax], byte 0FFFFFFFFh
        jne short .1
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov eax, 1
        mov ebx, dword [DbPageNext]
        xor ecx, ecx
        cmp ebx, eax
        jle short .4
.2:
        mov ebx, dword [DbPageBuffer]
        lea edx, [nosplit eax*4+00h]
        lea esi, [nosplit ecx*4+00h]
        add edx, ebx
        add esi, ebx
        mov ebx, dword [edx]
        cmp ebx, dword [esi]
        jge short .3
        mov ecx, eax
        cmp ebx, byte 0FFFFFFFFh
        jne short .3
        mov eax, dword [DbPageNext]
.3:
        mov esi, dword [DbPageNext]
        inc eax
        cmp eax, esi
        jl short .2
.4:
        mov eax, ecx
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ReadDbPage                                   D7C14  97 PC, medium confidence
; Database page cache: (db, page, slot) seeks to page * 1000h and reads the
; 1000h-byte page into cache slot (DbPageStack)
;-----------------------------------------------------------------------------
ReadDbPage:
        push ecx
        push esi
        mov ecx, eax
        test ebx, ebx
        jl short .1
        cmp ebx, dword [DbPageNext]
        jl short .2
.1:
        xor eax, eax
        pop esi
        pop ecx
        ret
.2:
        test edx, edx
        jl short .3
        mov eax, dword [dword eax+01F1h]
        sar eax, 10h
        cmp edx, eax
        jl short .4
.3:
        xor eax, eax
        pop esi
        pop ecx
        ret
.4:
        mov esi, dword [DbPageStack]
        shl edx, 0Ch
        mov eax, dword [ecx]
        shl ebx, 0Ch
        call FileSeek
        add esi, ebx
        test eax, eax
        je short .5
        mov ebx, 1000h
        mov edx, esi
        mov eax, dword [ecx]
        call FileReadRecord
        test eax, eax
        je short .5
        mov eax, 1
.5:
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; WriteDbPage                                  D7C74  97 PC, medium confidence
; Database page cache: (db, page, slot) seeks to page * 1000h and writes the
; cache slot back
;-----------------------------------------------------------------------------
WriteDbPage:
        push ecx
        push esi
        mov ecx, eax
        test ebx, ebx
        jl short .1
        cmp ebx, dword [DbPageNext]
        jl short .2
.1:
        xor eax, eax
        pop esi
        pop ecx
        ret
.2:
        test edx, edx
        jl short .3
        mov eax, dword [dword eax+01F1h]
        sar eax, 10h
        cmp edx, eax
        jl short .4
.3:
        xor eax, eax
        pop esi
        pop ecx
        ret
.4:
        mov esi, dword [DbPageStack]
        shl edx, 0Ch
        mov eax, dword [ecx]
        shl ebx, 0Ch
        call FileSeek
        add esi, ebx
        test eax, eax
        je short .5
        mov ebx, 1000h
        mov edx, esi
        mov eax, dword [ecx]
        call FileWriteRecord
        test eax, eax
        je short .5
        mov eax, 1
.5:
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; GetDbPage                                       D7CD4  97 PC, low confidence
; Database page cache: finds a db file's page in the cache slots (DbPageEnd) or reads it in (ReadDbPage),
; bumps its use counter, returns the slot
;-----------------------------------------------------------------------------
GetDbPage:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ecx, eax
        mov dword [esp], ebx
        mov esi, edx
        mov dword [ebx], 0FFFFFFFFh
        mov eax, ebx
        mov edx, dword [DbPageNext]
        sar esi, 3
        xor eax, ebx
        test edx, edx
        jle near .5
.1:
        mov edx, dword [DbPageEnd]
        lea edi, [nosplit eax*8+00h]
        add edx, edi
        mov ebx, dword [edx]
        lea ebp, [nosplit eax*4+00h]
        test ebx, ebx
        je short .2
        cmp ecx, ebx
        jne short .4
        cmp esi, dword [byte edx+04h]
        jne short .4
        mov edx, dword [esp]
        mov dword [edx], eax
        mov eax, dword [DbPageBuffer]
        add ebp, eax
        mov edx, dword [DbPageWanted]
        cmp edx, dword [byte ebp+00h]
        je short .3
        lea ebx, [byte edx+01h]
        mov dword [DbPageWanted], ebx
        mov dword [byte ebp+00h], ebx
        jmp short .3
.2:
        mov edx, dword [esp]
        mov ebx, eax
        mov dword [edx], eax
        mov edx, esi
        mov eax, ecx
        call ReadDbPage
        test eax, eax
        je near .8
        mov eax, dword [DbPageEnd]
        mov dword [edi+eax], ecx
        mov eax, dword [DbPageEnd]
        mov dword [byte edi+eax+04h], esi
        mov edi, dword [DbPageWanted]
        mov eax, dword [DbPageBuffer]
        inc edi
        add ebp, eax
        mov dword [DbPageWanted], edi
        mov dword [byte ebp+00h], edi
.3:
        mov eax, dword [DbPageNext]
.4:
        mov ebx, dword [DbPageNext]
        inc eax
        cmp eax, ebx
        jl near .1
.5:
        cmp eax, dword [DbPageNext]
        jne short .6
        call OldestDbPageSlot
        mov edi, eax
        mov ebx, eax
        mov edx, esi
        mov eax, ecx
        call ReadDbPage
        test eax, eax
        je short .8
        mov edx, dword [DbPageEnd]
        mov dword [byte edx+edi*8+04h], esi
        mov edx, dword [DbPageEnd]
        mov dword [edx+edi*8], ecx
        mov eax, dword [DbPageBuffer]
        mov ebp, dword [DbPageWanted]
        lea edx, [nosplit edi*4+00h]
        inc ebp
        add eax, edx
        mov dword [DbPageWanted], ebp
        mov dword [eax], ebp
        mov eax, dword [esp]
        mov dword [eax], edi
.6:
        mov eax, dword [esp]
        cmp dword [eax], byte 0FFFFFFFFh
        jne short .7
        xor eax, eax
        jmp short .8
.7:
        mov eax, 1
.8:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; InitDbFileHeader                                D7E08  97 PC, low confidence
; Writes the header page of a new database file
;-----------------------------------------------------------------------------
InitDbFileHeader:
        push ecx
        push esi
        push edi
        sub esp, byte 4
        mov ecx, eax
        mov edi, edx
        call OldestDbPageSlot
        mov dword [ebx], eax
        mov ax, word [dword ecx+01F3h]
        mov edx, eax
        inc edx
        cwde
        mov word [dword ecx+01F3h], dx
        mov dword [edi], eax
        mov esi, dword [ebx]
        mov eax, dword [DbPageStack]
        shl esi, 0Ch
        add esi, eax
        mov edx, 1000h
        mov eax, esi
        call ZeroBytesOk
        mov dword [dword esi+0FF2h], 0FFFFFFFFh
        mov edx, dword [edi]
        mov eax, dword [ecx]
        shl edx, 0Ch
        call FileSeek
        test eax, eax
        je short .3
        mov ebx, 1000h
        mov edx, esi
        mov eax, dword [ecx]
        call FileWriteRecord
        test eax, eax
        je short .3
        mov ebx, esp
        mov eax, ecx
        xor edx, edx
        call GetDbPage
        test eax, eax
        jne short .1
        dec word [dword ecx+01F3h]
        jmp short .3
.1:
        mov edx, dword [esp]
        mov eax, dword [DbPageStack]
        shl edx, 0Ch
        mov ebx, 1FEh
        add edx, eax
        mov eax, ecx
        call CopyBytesOk
        mov ebx, dword [esp]
        mov eax, ecx
        xor edx, edx
        call WriteDbPage
        test eax, eax
        jne short .2
        dec word [dword ecx+01F3h]
        jmp short .3
.2:
        mov eax, 1
.3:
        add esp, byte 4
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CreateDbFile                                    D7EC8  97 PC, low confidence
; Database: creates a db file (FileCreate) with its header and first pages
;-----------------------------------------------------------------------------
CreateDbFile:
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov edi, eax
        mov ebp, edx
        mov esi, ebx
        mov dword [byte esp+08h], ecx
        xor edx, edx
        mov ebx, dword [dword eax+01F5h]
        mov dword [byte esp+0Ch], edx
        test ebx, ebx
        jge short .1
        lea edx, [byte esp+04h]
        mov ebx, ebp
        call InitDbFileHeader
        test eax, eax
        je near .7
        mov ecx, 1
        mov eax, dword [byte esp+04h]
        mov dword [byte esp+0Ch], ecx
        mov dword [dword edi+01F5h], eax
.1:
        mov ebx, ebp
        mov edx, dword [dword edi+01F5h]
        mov eax, edi
        shl edx, 3
        call GetDbPage
        test eax, eax
        je near .7
        mov eax, dword [byte ebp+00h]
        mov edx, dword [DbPageStack]
        shl eax, 0Ch
        add edx, eax
        xor eax, eax
        mov dword [esi], edx
.2:
        mov ebx, dword [esi]
        mov bx, word [dword ebx+0FF0h]
        mov edx, 1
        mov cl, al
        and ebx, 0FFFFh
        shl edx, cl
        test ebx, edx
        je short .3
        inc eax
        jmp short .2
.3:
        cmp eax, byte 8
        jl short .4
        xor eax, eax
        jmp near .7
.4:
        mov edx, dword [dword edi+01F5h]
        shl edx, 3
        mov ebx, dword [byte esp+08h]
        add edx, eax
        mov dword [ebx], edx
        mov eax, 1
        mov edx, dword [esi]
        shl eax, cl
        or word [dword edx+0FF0h], ax
        mov eax, edi
        mov ebx, dword [byte ebp+00h]
        mov edx, dword [dword edi+01F5h]
        call WriteDbPage
        test eax, eax
        je near .7
        mov eax, dword [esi]
        cmp word [dword eax+0FF0h], 0FFh
        jne short .5
        mov ebp, 1
        mov eax, dword [dword eax+0FF2h]
        mov dword [byte esp+0Ch], ebp
        mov dword [dword edi+01F5h], eax
.5:
        cmp dword [byte esp+0Ch], byte 0
        je short .6
        mov ebx, esp
        mov eax, edi
        xor edx, edx
        call GetDbPage
        test eax, eax
        je short .7
        mov eax, dword [esp]
        mov edx, dword [DbPageStack]
        shl eax, 0Ch
        mov ebx, 1FEh
        add edx, eax
        mov eax, edi
        call CopyBytesOk
        mov ebx, dword [esp]
        mov eax, edi
        xor edx, edx
        call WriteDbPage
        test eax, eax
        je short .7
.6:
        mov edx, dword [byte esp+08h]
        mov edx, dword [edx]
        and edx, byte 7
        mov eax, edx
        shl eax, 8
        sub eax, edx
        mov edx, dword [esi]
        add eax, eax
        add edx, eax
        mov eax, dword [byte esp+020h]
        mov dword [eax], edx
        mov eax, 1
.7:
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        sub esp, byte 0Ch
        mov ecx, eax
        lea ebx, [byte esp+08h]
        mov edx, 1FEh
        call AllocClearBlock
        test eax, eax
        je near .11
        mov edx, 1FEh
        mov eax, dword [byte esp+08h]
        call ZeroBytesOk
        mov edx, dword [byte esp+08h]
        mov eax, ecx
        call FileCreate
        test eax, eax
        jne short .8
        lea eax, [byte esp+08h]
        call FreePtr
        xor eax, eax
        jmp near .11
.8:
        mov eax, dword [byte esp+08h]
        mov word [dword eax+01F3h], 0
        mov eax, dword [byte esp+08h]
        lea ebx, [byte esp+04h]
        mov dword [dword eax+01F5h], 0
        mov edx, esp
        mov eax, dword [byte esp+08h]
        call InitDbFileHeader
        test eax, eax
        jne short .9
        mov eax, dword [byte esp+08h]
        call FileClose
        lea eax, [byte esp+08h]
        call FreePtr
        xor eax, eax
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
.9:
        mov eax, dword [byte esp+04h]
        mov edx, dword [DbPageStack]
        shl eax, 0Ch
        add edx, eax
        or byte [dword edx+0FF0h], 1
        mov ebx, 1FEh
        mov eax, dword [byte esp+08h]
        call CopyBytesOk
        mov ebx, dword [byte esp+04h]
        mov eax, dword [byte esp+08h]
        xor edx, edx
        call WriteDbPage
        test eax, eax
        jne short .10
        mov eax, dword [byte esp+08h]
        call FileClose
        lea eax, [byte esp+08h]
        call FreePtr
        xor eax, eax
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
.10:
        mov eax, dword [byte esp+08h]
        call FileClose
        lea eax, [byte esp+08h]
        call FreePtr
        mov eax, 1
.11:
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; OpenDbFile                                      D8130  97 PC, low confidence
; Database: opens a db file and reads its 1FEh-byte header into a new block
;-----------------------------------------------------------------------------
OpenDbFile:
        push ebx
        push ecx
        push esi
        sub esp, byte 4
        mov ecx, eax
        mov esi, edx
        mov edx, esp
        mov eax, esi
        call FileOpen
        test eax, eax
        je near .3
        mov edx, 1FEh
        mov ebx, ecx
        mov eax, esi
        call AllocClearBlock
        test eax, eax
        jne short .1
        mov eax, esp
        call FileClose
        xor eax, eax
        jmp short .3
.1:
        mov eax, dword [esp]
        xor edx, edx
        call FileSeek
        test eax, eax
        je short .3
        mov ebx, 1FEh
        mov eax, dword [esp]
        mov edx, dword [ecx]
        call FileReadRecord
        test eax, eax
        jne short .2
        mov eax, esp
        call FileClose
        mov eax, ecx
        call FreePtr
        xor eax, eax
        add esp, byte 4
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        mov edx, dword [ecx]
        mov eax, dword [esp]
        mov dword [edx], eax
        mov eax, dword [ecx]
        mov edx, 0B4h
        add eax, 0E5h
        call ZeroBytesOk
        mov eax, dword [ecx]
        mov edx, 5Ah
        add eax, 199h
        call ZeroBytesOk
        mov eax, 1
.3:
        add esp, byte 4
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CloseDbFile                                     D81D8  97 PC, low confidence
; Database: writes the header back into page 0 (WriteDbPage), closes the file
; and frees the header
;-----------------------------------------------------------------------------
CloseDbFile:
        push ebx
        push ecx
        push edx
        sub esp, byte 4
        mov ecx, eax
        mov edx, dword [eax]
        test edx, edx
        jne short .1
        xor eax, eax
        jmp short .2
.1:
        lea eax, [dword edx+0E5h]
        mov edx, 0B4h
        call ZeroBytesOk
        mov eax, dword [ecx]
        mov edx, 5Ah
        add eax, 199h
        mov ebx, esp
        call ZeroBytesOk
        mov eax, dword [ecx]
        xor edx, edx
        call GetDbPage
        test eax, eax
        je short .2
        mov ebx, dword [esp]
        mov eax, dword [ecx]
        xor edx, edx
        call WriteDbPage
        test eax, eax
        je short .2
        mov eax, dword [ecx]
        mov edx, 1FEh
        call FileClose
        mov eax, dword [ecx]
        call ZeroBytesOk
        mov eax, ecx
        call FreePtr
        mov eax, 1
.2:
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
        movsx edx, dx
        mov byte [byte edx+eax+04h], bl
        mov eax, 1
        ret
        db 08Dh,040h,00h
        movsx edx, dx
        mov al, byte [byte edx+eax+04h]
        mov byte [ebx], al
        mov eax, 1
        ret
        db 090h
;-----------------------------------------------------------------------------
; CopyIndexNode                                   D8270  97 PC, low confidence
; Copies an index node
;-----------------------------------------------------------------------------
CopyIndexNode:
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov dword [byte esp+0Ch], eax
        mov dword [esp], edx
        mov dword [byte esp+010h], ebx
        mov dword [byte esp+04h], ecx
        cmp word [byte eax+04h], byte 0Ah
        je short .1
        mov edx, dword [byte eax+02h]
        sar edx, 10h
        cmp edx, ebx
        jge short .2
.1:
        xor eax, eax
        jmp near .5
.2:
        mov ebp, edx
        add eax, byte 6
        lea ecx, [nosplit edx*4+00h]
        mov dword [byte esp+08h], eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        sub eax, edx
        mov esi, dword [byte esp+0Ch]
        add eax, eax
        mov ebx, dword [byte esp+08h]
        lea edi, [byte eax-02Eh]
        add ecx, esi
        add edi, ebx
        lea esi, [ebx+eax]
        cmp edx, dword [byte esp+010h]
        jle short .4
.3:
        mov ebx, 2Eh
        mov edx, esi
        mov eax, edi
        call CopyAndClear
        sub ecx, byte 4
        dec ebp
        mov edx, dword [byte esp+010h]
        sub edi, byte 2Eh
        mov eax, dword [dword ecx+01D6h]
        sub esi, byte 2Eh
        mov dword [dword ecx+01DAh], eax
        cmp ebp, edx
        jg short .3
.4:
        mov eax, dword [byte esp+010h]
        mov ebx, dword [byte esp+0Ch]
        shl eax, 2
        add eax, ebx
        mov edx, dword [byte esp+04h]
        mov dword [dword eax+01D6h], edx
        mov edx, dword [byte esp+010h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        sub eax, edx
        mov edx, dword [byte esp+08h]
        add eax, eax
        mov ebx, 2Eh
        add edx, eax
        mov eax, dword [esp]
        call CopyBytesOk
        mov edx, dword [byte esp+0Ch]
        mov bx, word [byte edx+04h]
        inc ebx
        mov eax, 1
        mov word [byte edx+04h], bx
.5:
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; FlushDbPage                                     D8358  97 PC, low confidence
; Writes a database page back
;-----------------------------------------------------------------------------
FlushDbPage:
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov edi, eax
        mov ebp, edx
        mov esi, ebx
.1:
        mov eax, ebp
        dec ebp
        test eax, eax
        jle short .2
        mov edx, dword [esi]
        test edx, edx
        je short .2
        mov ebx, esp
        mov eax, edi
        call GetDbPage
        test eax, eax
        je short .3
        mov edx, dword [esp]
        mov eax, dword [DbPageStack]
        shl edx, 0Ch
        add edx, eax
        mov eax, dword [esi]
        and eax, byte 7
        imul eax, dword 1FEh
        mov dword [edx+eax], ecx
        mov ebx, dword [esp]
        mov edx, dword [esi]
        mov eax, edi
        sar edx, 3
        call WriteDbPage
        test eax, eax
        je short .3
        add esi, byte 4
        jmp short .1
.2:
        mov eax, 1
.3:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SplitIndexNode                                  D83C0  97 PC, low confidence
; Splits a full index node in two
;-----------------------------------------------------------------------------
SplitIndexNode:
        push esi
        push edi
        push ebp
        sub esp, byte 3Ch
        mov edi, dword [byte esp+05Ch]
        mov esi, dword [byte esp+06Ch]
        mov dword [byte esp+030h], eax
        mov word [byte esp+038h], dx
        mov ebp, ebx
        mov dword [byte esp+034h], ecx
        mov edx, dword [byte esp+060h]
        mov ebx, dword [byte esp+064h]
        push esi
        mov ecx, dword [byte esp+06Ch]
        call CreateDbFile
        test eax, eax
        je near .6
        mov edx, dword [byte esp+034h]
        cmp edx, byte 5
        jne short .1
        mov ebx, 0E6h
        mov edx, dword [esi]
        mov eax, dword [edi]
        add edx, byte 6
        add eax, 0ECh
        call CopyAndClear
        mov eax, dword [edi]
        mov word [byte eax+04h], 5
        mov eax, dword [esi]
        mov edx, dword [byte esp+04Ch]
        mov dword [dword eax+01D2h], edx
        mov ebx, 14h
        mov edx, dword [esi]
        mov eax, dword [edi]
        add edx, 1D6h
        add eax, 1EAh
        call CopyAndClear
        mov eax, dword [esi]
        mov word [byte eax+04h], 5
        jmp near .5
.1:
        jge short .2
        mov ebx, 0E6h
        mov edx, dword [esi]
        mov eax, dword [edi]
        add edx, byte 6
        add eax, 0ECh
        call CopyAndClear
        mov ebx, 18h
        mov edx, dword [esi]
        mov eax, dword [edi]
        add edx, 1D2h
        add eax, 1E6h
        call CopyAndClear
        mov ebx, 2Eh
        mov eax, dword [edi]
        mov edx, esp
        add eax, 0BEh
        call CopyAndClear
        mov eax, dword [edi]
        mov word [byte eax+04h], 4
        mov eax, dword [esi]
        mov ecx, dword [byte esp+04Ch]
        mov ebx, dword [byte esp+034h]
        mov word [byte eax+04h], 5
        mov edx, ebp
        mov eax, dword [edi]
        call CopyIndexNode
        test eax, eax
        jne near .4
        jmp near .6
.2:
        mov eax, dword [byte esp+036h]
        mov ecx, dword [byte esp+030h]
        sar eax, 10h
        add eax, ecx
        cmp byte [byte eax+04h], 1
        jne near .3
        mov eax, dword [edi]
        mov eax, dword [byte eax+02h]
        mov edx, dword [byte esp+034h]
        sar eax, 10h
        cmp eax, edx
        jne near .3
        mov ebx, 2Eh
        mov edx, dword [esi]
        mov eax, ebp
        add edx, byte 6
        call CopyBytesOk
        mov eax, dword [edi]
        mov ebx, dword [byte eax+02h]
        mov edx, dword [esi]
        sar ebx, 10h
        add eax, 1D2h
        shl ebx, 2
        add edx, 1D2h
        add eax, ebx
        mov ebx, 4
        call CopyAndClear
        mov eax, dword [esi]
        mov edx, dword [byte esp+04Ch]
        mov dword [dword eax+01D6h], edx
        mov eax, dword [esi]
        mov word [byte eax+04h], 1
        mov ebx, dword [edi]
        mov eax, dword [byte ebx+02h]
        sar eax, 10h
        lea edx, [byte eax-01h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        sub eax, edx
        add ebx, byte 6
        add eax, eax
        mov edx, ebp
        add eax, ebx
        mov ebx, 2Eh
        call CopyAndClear
        mov eax, dword [edi]
        dec word [byte eax+04h]
        jmp short .5
.3:
        mov ebx, 0B8h
        mov edx, dword [esi]
        mov eax, dword [edi]
        add edx, byte 6
        add eax, 11Ah
        call CopyAndClear
        mov ebx, 14h
        mov edx, dword [esi]
        mov eax, dword [edi]
        add edx, 1D2h
        add eax, 1EAh
        call CopyAndClear
        mov ebx, 2Eh
        mov eax, dword [edi]
        mov edx, esp
        add eax, 0ECh
        call CopyAndClear
        mov eax, dword [edi]
        mov word [byte eax+04h], 5
        mov ecx, dword [byte esp+04Ch]
        mov eax, dword [esi]
        mov ebx, dword [byte esp+034h]
        mov edx, ebp
        mov word [byte eax+04h], 4
        sub ebx, byte 6
        mov eax, dword [esi]
        call CopyIndexNode
        test eax, eax
        je short .6
.4:
        mov ebx, 2Eh
        mov eax, esp
        mov edx, ebp
        call CopyBytesOk
.5:
        mov eax, dword [esi]
        mov ecx, dword [byte esp+068h]
        lea ebx, [dword eax+01D2h]
        mov edx, dword [byte eax+02h]
        mov ecx, dword [ecx]
        sar edx, 10h
        mov eax, dword [byte esp+030h]
        inc edx
        call FlushDbPage
        test eax, eax
        je short .6
        mov eax, 1
.6:
        add esp, byte 3Ch
        pop ebp
        pop edi
        pop esi
        ret 24h
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; InsertKeyUp                                     D8614  97 PC, low confidence
; Inserts a key into the parent node after a split
;-----------------------------------------------------------------------------
InsertKeyUp:
        push esi
        push edi
        push ebp
        sub esp, byte 40h
        mov esi, eax
        mov word [byte esp+03Ch], dx
        mov edi, ebx
        mov dword [byte esp+030h], ecx
        mov ecx, dword [byte esp+050h]
        mov eax, dword [byte esp+03Ah]
        sar eax, 10h
        shl eax, 2
        lea ebp, [esi+eax]
        lea ebx, [byte esp+02Ch]
        mov eax, esi
        mov edx, dword [byte ebp+031h]
        call GetDbPage
        test eax, eax
        je near .6
        mov edx, dword [byte esp+02Ch]
        mov eax, dword [DbPageStack]
        shl edx, 0Ch
        add eax, edx
        mov dword [byte esp+014h], eax
        mov ebp, dword [byte ebp+031h]
        mov edx, ebp
        and edx, byte 7
        mov eax, edx
        shl eax, 8
        sub eax, edx
        mov edx, dword [byte esp+014h]
        add eax, eax
        add edx, eax
        mov dword [byte esp+08h], edx
        test ecx, ecx
        je short .1
        cmp dword [dword edx+01D2h], byte 0
        jne short .1
        xor eax, eax
        jmp near .6
.1:
        mov eax, ebp
        sar eax, 3
        mov dword [byte esp+038h], eax
        mov eax, dword [byte esp+08h]
        cmp word [byte eax+04h], byte 0Ah
        jne near .4
        lea eax, [byte esp+04h]
        push eax
        lea eax, [byte esp+02Ch]
        push eax
        lea eax, [byte esp+018h]
        push eax
        lea eax, [byte esp+030h]
        push eax
        lea eax, [byte esp+018h]
        push eax
        push ebp
        lea eax, [byte esp+02Ch]
        push eax
        lea eax, [byte esp+048h]
        push eax
        mov ebx, edi
        mov eax, dword [byte esp+05Ah]
        push ecx
        sar eax, 10h
        mov ecx, dword [byte esp+054h]
        mov dword [byte esp+058h], eax
        mov edx, eax
        mov eax, esi
        call SplitIndexNode
        mov eax, esp
        lea ecx, [byte esp+01Ch]
        lea ebx, [byte esp+0Ch]
        push eax
        lea edx, [byte esp+024h]
        mov eax, esi
        call CreateDbFile
        test eax, eax
        je near .6
        mov edx, dword [byte esp+04h]
        mov eax, dword [byte esp+01Ch]
        mov dword [edx], eax
        mov edx, dword [byte esp+08h]
        mov dword [edx], eax
        mov eax, dword [esp]
        mov dword [eax], 0
        mov eax, dword [esp]
        mov word [byte eax+04h], 1
        mov ebx, 2Eh
        mov edx, dword [esp]
        mov eax, edi
        add edx, byte 6
        call CopyBytesOk
        mov eax, dword [esp]
        mov dword [dword eax+01D2h], ebp
        mov edx, dword [esp]
        mov eax, dword [byte esp+028h]
        mov dword [dword edx+01D6h], eax
        mov eax, dword [byte esp+034h]
        shl eax, 2
        lea edx, [esi+eax]
        mov eax, dword [byte esp+01Ch]
        lea ebx, [byte esp+018h]
        mov dword [byte edx+031h], eax
        mov eax, esi
        xor edx, edx
        call GetDbPage
        test eax, eax
        je near .6
        mov edx, dword [byte esp+018h]
        mov eax, dword [DbPageStack]
        shl edx, 0Ch
        mov ebx, 1FEh
        add edx, eax
        mov eax, esi
        call CopyBytesOk
        mov edx, dword [byte esp+01Ch]
        mov ebx, dword [byte esp+020h]
        mov eax, esi
        sar edx, 3
        call WriteDbPage
        test eax, eax
        je near .6
        mov eax, dword [byte esp+01Ch]
        mov ebx, dword [byte esp+038h]
        sar eax, 3
        cmp eax, ebx
        je short .2
        mov ebx, dword [byte esp+02Ch]
        mov edx, dword [byte esp+038h]
        mov eax, esi
        call WriteDbPage
        test eax, eax
        je near .6
.2:
        mov eax, dword [byte esp+01Ch]
        mov edx, dword [byte esp+028h]
        sar eax, 3
        sar edx, 3
        cmp edx, eax
        je short .3
        mov eax, ebp
        sar eax, 3
        cmp edx, eax
        je short .3
        mov ebx, dword [byte esp+024h]
        mov eax, esi
        call WriteDbPage
        test eax, eax
        je short .6
.3:
        mov eax, dword [byte esp+01Ch]
        sar eax, 3
        test eax, eax
        je short .5
        sar ebp, 3
        test ebp, ebp
        je short .5
        mov eax, dword [byte esp+028h]
        sar eax, 3
        test eax, eax
        je short .5
        mov ebx, dword [byte esp+018h]
        mov eax, esi
        xor edx, edx
        call WriteDbPage
        test eax, eax
        jne short .5
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        ret 4
.4:
        mov ebx, dword [byte esp+030h]
        mov edx, edi
        call CopyIndexNode
        test eax, eax
        je short .6
        mov ebx, dword [byte esp+02Ch]
        mov edx, dword [byte esp+038h]
        mov eax, esi
        call WriteDbPage
        test eax, eax
        je short .6
.5:
        mov eax, 1
.6:
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        ret 4
        db 090h
;-----------------------------------------------------------------------------
; CompareIndexKey                                 D8860  97 PC, low confidence
; Compares a key with an index entry
;-----------------------------------------------------------------------------
CompareIndexKey:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov ebp, eax
        mov dword [byte esp+0Ch], edx
        mov dword [byte esp+04h], ebx
        cmp word [byte edx+04h], byte 0
        jne short .1
        mov eax, 1
        mov dword [ebx], 0
        jmp near .8
.1:
        mov edi, dword [byte esp+0Ch]
        mov di, word [byte edi+04h]
        movsx ecx, di
        sar ecx, 1
        movsx edx, cx
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        sub eax, edx
        mov edx, dword [byte esp+0Ch]
        mov ebx, 2Ah
        add edx, byte 6
        add eax, eax
        mov dword [esp], edx
        add edx, eax
        mov eax, ebp
        xor esi, esi
        call CompareKeyBytes
        mov edx, eax
        test eax, eax
        jne short .3
.2:
        mov edx, dword [byte esp+04h]
        movsx eax, cx
        mov dword [edx], eax
        xor eax, eax
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.3:
        mov eax, dword [esp]
        mov dword [byte esp+08h], eax
        test edx, edx
        jge short .4
        mov edi, ecx
        jmp short .5
.4:
        mov esi, ecx
        inc esi
.5:
        movsx eax, di
        movsx ebx, si
        add eax, ebx
        sar eax, 1
        mov ecx, eax
        mov eax, dword [byte esp+0Ch]
        cmp cx, word [byte eax+04h]
        jge short .6
        movsx edx, cx
        imul edx, byte 2Eh
        mov ebx, dword [byte esp+08h]
        mov eax, ebp
        add edx, ebx
        mov ebx, 2Ah
        call CompareKeyBytes
        mov edx, eax
.6:
        cmp si, di
        jge short .7
        test edx, edx
        je short .2
        test edx, edx
        jge short .4
        mov edi, ecx
        jmp short .5
.7:
        mov ebx, dword [byte esp+04h]
        movsx eax, si
        mov dword [ebx], eax
        mov eax, edx
.8:
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; InsertKeyInNode                                 D8944  97 PC, low confidence
; Inserts a key into an index node
;-----------------------------------------------------------------------------
InsertKeyInNode:
        push esi
        push edi
        push ebp
        sub esp, byte 28h
        mov esi, eax
        mov word [byte esp+024h], dx
        mov edi, ebx
        mov ebp, ecx
        lea ebx, [byte esp+018h]
        mov edx, ecx
        call GetDbPage
        test eax, eax
        je near .4
        mov edx, dword [byte esp+018h]
        mov eax, dword [DbPageStack]
        shl edx, 0Ch
        add eax, edx
        mov edx, ecx
        and edx, byte 7
        mov dword [byte esp+0Ch], eax
        mov eax, edx
        shl eax, 8
        sub eax, edx
        mov edx, dword [byte esp+0Ch]
        add eax, eax
        lea ebx, [byte esp+014h]
        add edx, eax
        mov eax, edi
        mov dword [byte esp+04h], edx
        call CompareIndexKey
        test eax, eax
        je near .4
        mov eax, dword [byte esp+04h]
        cmp dword [dword eax+01D2h], byte 0
        je near .1
        mov eax, dword [byte esp+038h]
        cmp dword [eax], byte 0
        jne short .1
        mov eax, dword [byte esp+03Ch]
        push eax
        mov eax, dword [byte esp+018h]
        mov ebx, dword [byte esp+08h]
        shl eax, 2
        add eax, ebx
        mov edx, dword [byte esp+03Ch]
        mov ecx, dword [dword eax+01D2h]
        mov eax, dword [byte esp+026h]
        push edx
        sar eax, 10h
        mov ebx, edi
        mov dword [byte esp+024h], eax
        mov edx, eax
        mov eax, esi
        call InsertKeyInNode
        test eax, eax
        je near .4
        mov eax, dword [byte esp+038h]
        cmp dword [eax], byte 0
        je near .3
        mov ebx, 2Eh
        mov eax, dword [byte esp+03Ch]
        mov edx, edi
        call CopyBytesOk
        mov eax, dword [byte esp+03Ch]
        mov ecx, ebp
        push eax
        mov edx, dword [byte esp+03Ch]
        mov ebx, edi
        push edx
        mov eax, esi
        mov edx, dword [byte esp+024h]
        call InsertKeyInNode
        jmp near .3
.1:
        mov eax, ebp
        sar eax, 3
        mov dword [byte esp+020h], eax
        mov eax, dword [byte esp+04h]
        cmp word [byte eax+04h], byte 0Ah
        jne near .2
        mov ebx, 2Eh
        mov edx, dword [byte esp+03Ch]
        mov eax, edi
        call CopyBytesOk
        mov eax, esp
        push eax
        mov ecx, dword [byte esp+03Ch]
        push ecx
        lea eax, [byte esp+010h]
        push eax
        lea eax, [byte esp+01Ch]
        push eax
        lea eax, [byte esp+014h]
        push eax
        mov edx, dword [byte esp+036h]
        push ebp
        lea eax, [byte esp+024h]
        mov ebx, dword [byte esp+054h]
        push eax
        lea eax, [byte esp+034h]
        mov edi, dword [ecx]
        push eax
        sar edx, 10h
        push edi
        mov ecx, dword [byte esp+038h]
        mov eax, esi
        call SplitIndexNode
        test eax, eax
        je near .4
        mov eax, dword [byte esp+04h]
        mov edx, dword [eax]
        mov eax, dword [esp]
        mov dword [eax], edx
        mov ebx, dword [byte esp+018h]
        mov edx, dword [byte esp+020h]
        mov eax, esi
        call WriteDbPage
        test eax, eax
        je short .4
        mov edx, dword [byte esp+038h]
        mov edx, dword [edx]
        mov ebp, dword [byte esp+020h]
        sar edx, 3
        cmp edx, ebp
        je short .3
        mov ebx, dword [byte esp+010h]
        mov eax, esi
        call WriteDbPage
        test eax, eax
        jne short .3
        jmp short .4
.2:
        mov ecx, dword [byte esp+038h]
        mov ebx, dword [byte esp+014h]
        mov edx, edi
        mov ecx, dword [ecx]
        call CopyIndexNode
        test eax, eax
        je short .4
        mov ebx, dword [byte esp+018h]
        mov edx, dword [byte esp+020h]
        mov eax, esi
        call WriteDbPage
        test eax, eax
        je short .4
        mov eax, dword [byte esp+038h]
        mov dword [eax], 0
.3:
        mov eax, 1
.4:
        add esp, byte 28h
        pop ebp
        pop edi
        pop esi
        ret 8
;-----------------------------------------------------------------------------
; AddIndexKey                                     D8B20  97 PC, low confidence
; Adds a key to the index
;-----------------------------------------------------------------------------
AddIndexKey:
        push esi
        push edi
        push ebp
        sub esp, byte 78h
        mov esi, eax
        mov word [byte esp+074h], dx
        mov eax, ebx
        mov ebx, 2Ah
        lea edx, [byte esp+030h]
        call CopyBytesOk
        mov eax, dword [byte esp+072h]
        sar eax, 10h
        mov edi, esi
        shl eax, 2
        mov dword [byte esp+05Ah], ecx
        lea ecx, [esi+eax]
        mov edx, dword [byte ecx+031h]
        mov dword [dword ecx+0E5h], 0
        test edx, edx
        jne short .1
        lea edx, [byte esp+06Ch]
        lea ebx, [byte esp+070h]
        lea ecx, [byte esi+031h]
        push edx
        add ecx, eax
        lea edx, [byte esp+06Ch]
        mov eax, esi
        call CreateDbFile
        test eax, eax
        je near .5
        lea ebx, [byte esp+060h]
        mov eax, esi
        xor edx, edx
        call GetDbPage
        test eax, eax
        je near .5
        mov edx, dword [byte esp+060h]
        mov eax, dword [DbPageStack]
        shl edx, 0Ch
        mov ebx, 1FEh
        add edx, eax
        mov eax, esi
        call CopyBytesOk
        mov ebx, dword [byte esp+060h]
        mov eax, esi
        xor edx, edx
        call WriteDbPage
        test eax, eax
        jne short .2
        jmp near .5
.1:
        lea ebx, [byte esp+068h]
        mov eax, esi
        call GetDbPage
        test eax, eax
        je near .5
        mov eax, dword [byte esp+068h]
        mov edx, dword [DbPageStack]
        shl eax, 0Ch
        add edx, eax
        mov dword [byte esp+070h], edx
        mov ebx, dword [byte ecx+031h]
        and ebx, byte 7
        mov eax, ebx
        shl eax, 8
        sub eax, ebx
        add eax, eax
        add edx, eax
        mov dword [byte esp+06Ch], edx
.2:
        lea ebx, [byte esp+060h]
        mov edx, dword [byte esp+06Ch]
        lea eax, [byte esp+030h]
        call CompareIndexKey
        test eax, eax
        je near .5
        xor ebx, ebx
        mov eax, dword [byte esp+06Ch]
        mov dword [byte esp+064h], ebx
        cmp dword [dword eax+01D2h], byte 0
        jne short .3
        mov edx, dword [byte esp+072h]
        mov ecx, dword [byte esp+060h]
        push ebx
        mov eax, edi
        lea ebx, [byte esp+034h]
        sar edx, 10h
        call InsertKeyUp
        test eax, eax
        jne short .4
        add esp, byte 78h
        pop ebp
        pop edi
        pop esi
        ret
.3:
        mov eax, esp
        mov ecx, dword [byte esp+060h]
        mov esi, dword [byte esp+06Ch]
        lea ebx, [byte esp+030h]
        push eax
        shl ecx, 2
        lea eax, [byte esp+068h]
        add ecx, esi
        mov esi, dword [byte esp+076h]
        push eax
        mov ecx, dword [dword ecx+01D2h]
        sar esi, 10h
        mov eax, edi
        mov edx, esi
        call InsertKeyInNode
        test eax, eax
        je short .5
        mov ebp, dword [byte esp+064h]
        test ebp, ebp
        je short .4
        mov ecx, dword [byte esp+060h]
        mov ebx, esp
        push ebp
        mov edx, esi
        mov eax, edi
        call InsertKeyUp
        test eax, eax
        je short .5
.4:
        mov eax, 1
.5:
        add esp, byte 78h
        pop ebp
        pop edi
        pop esi
        ret
        db 090h
;-----------------------------------------------------------------------------
; MergeIndexNodes                                 D8CAC  97 PC, low confidence
; Merges two index nodes after a delete
;-----------------------------------------------------------------------------
MergeIndexNodes:
        push esi
        push edi
        push ebp
        sub esp, byte 7Ch
        mov edi, dword [dword esp+094h]
        mov dword [byte esp+040h], eax
        mov word [byte esp+078h], dx
        mov dword [byte esp+024h], ebx
        mov dword [byte esp+02Ch], ecx
        mov eax, dword [dword esp+090h]
        mov eax, dword [eax]
        mov eax, dword [byte eax+02h]
        xor edx, edx
        sar eax, 10h
        mov dword [byte esp+028h], edx
        cmp edi, eax
        jne short .1
        dec eax
        mov dword [byte esp+074h], eax
        jmp short .2
.1:
        mov dword [byte esp+074h], edi
.2:
        mov eax, dword [byte esp+074h]
        mov edx, dword [dword esp+090h]
        shl eax, 2
        mov edx, dword [edx]
        add eax, edx
        mov edx, dword [dword eax+01D6h]
        mov eax, dword [dword eax+01D2h]
        lea ebx, [byte esp+04h]
        mov dword [byte esp+034h], eax
        mov eax, dword [byte esp+040h]
        mov dword [byte esp+03Ch], edx
        call GetDbPage
        test eax, eax
        jne short .3
        xor edi, edi
        jmp near .36
.3:
        lea ebx, [byte esp+08h]
        mov edx, dword [byte esp+034h]
        mov eax, dword [byte esp+040h]
        call GetDbPage
        test eax, eax
        jne short .4
        xor edi, edi
        mov eax, edi
        add esp, byte 7Ch
        pop ebp
        pop edi
        pop esi
        ret 10h
.4:
        mov edx, dword [byte esp+04h]
        mov eax, dword [DbPageStack]
        shl edx, 0Ch
        lea ebx, [eax+edx]
        mov edx, dword [byte esp+08h]
        shl edx, 0Ch
        add eax, edx
        mov edx, dword [byte esp+03Ch]
        and edx, byte 7
        mov dword [byte esp+038h], eax
        mov eax, edx
        shl eax, 8
        mov dword [byte esp+020h], ebx
        sub eax, edx
        mov edx, dword [byte esp+034h]
        add eax, eax
        and edx, byte 7
        lea ebp, [ebx+eax]
        mov eax, edx
        shl eax, 8
        sub eax, edx
        mov ecx, dword [byte esp+038h]
        add eax, eax
        mov ebx, dword [byte esp+074h]
        add ecx, eax
        cmp edi, ebx
        jne short .5
        mov ax, word [byte ebp+04h]
        jmp short .6
.5:
        mov ax, word [byte ecx+04h]
.6:
        lea edx, [byte ebp+06h]
        mov dword [byte esp+030h], edx
        cmp ax, 5
        jne near .19
        mov edx, dword [byte ebp+02h]
        sar edx, 10h
        lea ebx, [nosplit edx*4+00h]
        sub ebx, edx
        shl ebx, 3
        sub ebx, edx
        mov edx, dword [byte ebp+02h]
        mov eax, 0Ah
        sar edx, 10h
        sub eax, edx
        mov edx, eax
        shl eax, 2
        sub eax, edx
        shl eax, 3
        sub eax, edx
        mov edx, dword [byte esp+030h]
        add eax, eax
        add ebx, ebx
        add edx, eax
        mov eax, dword [byte esp+030h]
        call CopyAndClear
        mov eax, 0Ah
        lea edx, [byte ebp+028h]
.7:
        mov esi, dword [byte ebp+02h]
        mov edi, 0Ah
        sar esi, 10h
        lea ebx, [nosplit eax*4+00h]
        sub edi, esi
        cmp eax, edi
        jl short .8
        add esi, eax
        mov ebx, dword [dword ebp+esi*4+01AAh]
        jmp short .9
.8:
        mov ebx, dword [dword ecx+ebx+01D2h]
.9:
        mov dword [dword edx+01D2h], ebx
        dec eax
        sub edx, byte 4
        test eax, eax
        jge short .7
        mov edx, dword [byte ecx+02h]
        sar edx, 10h
        lea ebx, [nosplit edx*4+00h]
        sub ebx, edx
        lea esi, [byte ebp+06h]
        shl ebx, 3
        lea eax, [byte ecx+06h]
        sub ebx, edx
        mov edx, esi
        add ebx, ebx
        call CopyAndClear
        mov edx, dword [byte ecx+02h]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        sub eax, edx
        add eax, eax
        mov edx, dword [byte esp+074h]
        add esi, eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        mov ebx, dword [dword esp+090h]
        sub eax, edx
        mov ebx, dword [ebx]
        lea edx, [eax+eax]
        lea eax, [byte ebx+06h]
        mov ebx, 2Eh
        add eax, edx
        mov edx, esi
        call CopyBytesOk
        mov word [byte ebp+04h], 0Ah
        mov eax, dword [byte esp+040h]
        mov edx, dword [byte ecx+02h]
        lea ebx, [dword ebp+01D2h]
        sar edx, 10h
        mov ecx, dword [byte esp+03Ch]
        inc edx
        call FlushDbPage
        test eax, eax
        jne short .10
        xor edi, edi
        mov eax, edi
        add esp, byte 7Ch
        pop ebp
        pop edi
        pop esi
        ret 10h
.10:
        mov edx, dword [byte esp+074h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        sub eax, edx
        add eax, eax
        lea edi, [byte eax+02Eh]
        lea esi, [nosplit edx*4+00h]
        mov ecx, eax
.11:
        mov eax, dword [dword esp+090h]
        mov eax, dword [eax]
        mov ebx, dword [byte eax+02h]
        mov edx, dword [byte esp+074h]
        sar ebx, 10h
        cmp ebx, edx
        jle short .14
        dec ebx
        add eax, byte 6
        cmp ebx, edx
        jle short .12
        lea edx, [eax+ecx]
        mov ebx, 2Eh
        add eax, edi
        call CopyAndClear
        jmp short .13
.12:
        imul ebx, byte 2Eh
        mov edx, 2Eh
        add eax, ebx
        call ZeroBytesOk
.13:
        mov eax, dword [dword esp+090h]
        mov ebx, dword [byte esp+074h]
        add edi, byte 2Eh
        add esi, byte 4
        mov eax, dword [eax]
        add ecx, byte 2Eh
        inc ebx
        mov edx, dword [dword esi+eax+01D2h]
        mov dword [byte esp+074h], ebx
        mov dword [dword esi+eax+01CEh], edx
        jmp short .11
.14:
        mov ecx, dword [byte esp+034h]
        mov dword [dword eax+edx*4+01D2h], 0
        mov eax, dword [byte esp+038h]
        xor esi, esi
        and cl, 7
        mov si, word [dword eax+0FF0h]
        mov eax, 1
        mov edx, dword [byte esp+038h]
        shl eax, cl
        mov bx, word [dword edx+0FF0h]
        not eax
        and ebx, eax
        mov word [dword edx+0FF0h], bx
        cmp esi, 0FFh
        jne short .15
        mov eax, dword [byte esp+040h]
        mov eax, dword [dword eax+01F5h]
        mov dword [dword edx+0FF2h], eax
        mov edx, dword [byte esp+040h]
        mov eax, dword [byte esp+08h]
        mov dword [dword edx+01F5h], eax
.15:
        mov eax, dword [dword esp+090h]
        mov eax, dword [eax]
        dec word [byte eax+04h]
        mov eax, dword [dword esp+090h]
        mov eax, dword [eax]
        cmp dword [eax], byte 0
        jne near .17
        cmp word [byte eax+04h], byte 0
        jne near .17
        mov edx, dword [byte esp+076h]
        sar edx, 10h
        mov ecx, dword [byte esp+040h]
        shl edx, 2
        mov eax, dword [byte esp+02Ch]
        add edx, ecx
        xor esi, esi
        mov eax, dword [eax]
        mov cx, word [byte edx+031h]
        mov edx, 1
        and cl, 7
        mov si, word [dword eax+0FF0h]
        shl edx, cl
        mov edi, esi
        not edx
        and edi, edx
        mov word [dword eax+0FF0h], di
        cmp esi, 0FFh
        jne short .16
        mov edx, dword [byte esp+02Ch]
        mov eax, dword [byte esp+040h]
        mov edx, dword [edx]
        mov eax, dword [dword eax+01F5h]
        mov dword [dword edx+0FF2h], eax
        mov eax, dword [dword esp+08Ch]
        mov eax, dword [eax]
        mov edx, dword [byte esp+040h]
        sar eax, 3
        mov dword [dword edx+01F5h], eax
.16:
        mov eax, dword [byte esp+076h]
        sar eax, 10h
        mov esi, dword [byte esp+040h]
        shl eax, 2
        add eax, esi
        mov edx, dword [byte esp+03Ch]
        mov edi, 1
        mov dword [byte eax+031h], edx
        mov dword [byte esp+028h], edi
        mov dword [byte ebp+00h], 0
.17:
        mov ebx, esp
        mov eax, dword [byte esp+040h]
        xor edx, edx
        call GetDbPage
        test eax, eax
        jne short .18
        xor edi, edi
        mov eax, edi
        add esp, byte 7Ch
        pop ebp
        pop edi
        pop esi
        ret 10h
.18:
        mov eax, dword [esp]
        mov edx, dword [DbPageStack]
        shl eax, 0Ch
        mov ebx, 1FEh
        add edx, eax
        mov eax, dword [byte esp+040h]
        call CopyBytesOk
        mov ebx, dword [esp]
        mov eax, dword [byte esp+040h]
        xor edx, edx
        call WriteDbPage
        test eax, eax
        jne near .31
        xor edi, edi
        mov eax, edi
        add esp, byte 7Ch
        pop ebp
        pop edi
        pop esi
        ret 10h
.19:
        mov eax, dword [byte ebp+02h]
        mov edx, dword [byte ecx+02h]
        sar eax, 10h
        sar edx, 10h
        lea esi, [edx+eax]
        mov ebx, dword [byte esp+074h]
        sar esi, 1
        cmp edi, ebx
        jne near .25
        sub eax, esi
        mov esi, eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        sub eax, edx
        lea edx, [byte ecx+06h]
        add eax, eax
        mov dword [byte esp+01Ch], edx
        lea edi, [edx+eax]
        mov edx, dword [byte esp+074h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov ebx, dword [dword esp+090h]
        shl eax, 3
        mov ebx, dword [ebx]
        sub eax, edx
        add ebx, byte 6
        add eax, eax
        mov edx, edi
        add eax, ebx
        mov ebx, 2Eh
        call CopyBytesOk
        mov eax, dword [byte esp+01Ch]
        mov dword [byte esp+050h], eax
        mov eax, esi
        dec eax
        mov dword [byte esp+060h], ebp
        mov dword [byte esp+04Ch], eax
        mov eax, dword [byte esp+030h]
        xor edi, edi
        mov dword [byte esp+010h], eax
.20:
        mov eax, dword [byte ecx+02h]
        sar eax, 10h
        add eax, edi
        shl eax, 2
        lea edx, [ecx+eax]
        mov eax, dword [byte esp+060h]
        mov eax, dword [dword eax+01D2h]
        mov dword [dword edx+01D6h], eax
        cmp edi, dword [byte esp+04Ch]
        jge short .21
        mov eax, dword [byte ecx+02h]
        sar eax, 10h
        inc eax
        add eax, edi
        imul edx, eax, byte 2Eh
        mov ebx, dword [byte esp+050h]
        mov eax, dword [byte esp+010h]
        add edx, ebx
        mov ebx, 2Eh
        call CopyBytesOk
.21:
        mov edx, dword [byte esp+010h]
        mov eax, dword [byte esp+060h]
        inc edi
        add edx, byte 2Eh
        add eax, byte 4
        mov dword [byte esp+010h], edx
        mov dword [byte esp+060h], eax
        cmp edi, esi
        jl short .20
        mov ebx, dword [dword esp+090h]
        mov edx, dword [byte esp+074h]
        mov di, word [byte ecx+04h]
        lea eax, [nosplit edx*4+00h]
        add edi, esi
        sub eax, edx
        mov word [byte ecx+04h], di
        shl eax, 3
        mov ebx, dword [ebx]
        sub eax, edx
        add ebx, byte 6
        add eax, eax
        lea edx, [byte esi-01h]
        lea edi, [ebx+eax]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        mov ebx, 2Eh
        sub eax, edx
        lea edx, [byte ebp+06h]
        add eax, eax
        mov dword [byte esp+01Ch], edx
        add eax, edx
        mov edx, edi
        call CopyBytesOk
        mov eax, dword [byte esp+01Ch]
        mov edi, esi
        mov dword [byte esp+048h], eax
        lea eax, [nosplit esi*4+00h]
        lea edx, [eax+ebp]
        neg eax
        add eax, edx
        mov dword [byte esp+0Ch], eax
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 3
        mov dword [byte esp+070h], edx
        sub eax, esi
        mov edx, dword [byte esp+01Ch]
        add eax, eax
        add eax, edx
        mov dword [byte esp+06Ch], eax
        jmp short .24
.22:
        mov eax, dword [byte esp+070h]
        mov ebx, dword [byte esp+0Ch]
        mov eax, dword [dword eax+01D2h]
        mov dword [dword ebx+01D2h], eax
        mov eax, dword [byte esp+070h]
        mov dword [dword eax+01D2h], 0
        mov eax, dword [byte ebp+02h]
        mov edx, edi
        sar eax, 10h
        sub edx, esi
        cmp edi, eax
        jge short .23
        imul edx, byte 2Eh
        mov ebx, dword [byte esp+048h]
        mov eax, dword [byte esp+06Ch]
        add edx, ebx
        mov ebx, 2Eh
        call CopyAndClear
.23:
        mov edx, dword [byte esp+070h]
        mov ebx, dword [byte esp+06Ch]
        mov eax, dword [byte esp+0Ch]
        inc edi
        add edx, byte 4
        add ebx, byte 2Eh
        add eax, byte 4
        mov dword [byte esp+070h], edx
        mov dword [byte esp+06Ch], ebx
        mov dword [byte esp+0Ch], eax
.24:
        mov eax, dword [byte ebp+02h]
        sar eax, 10h
        cmp edi, eax
        jle short .22
        sub word [byte ebp+04h], si
        mov ebx, dword [byte ecx+02h]
        sar ebx, 10h
        add ecx, 1D2h
        sub ebx, esi
        mov eax, dword [byte esp+040h]
        shl ebx, 2
        lea edx, [byte esi+01h]
        add ebx, ecx
        mov ecx, dword [byte esp+034h]
        call FlushDbPage
        test eax, eax
        jne near .31
        xor edi, edi
        mov eax, edi
        add esp, byte 7Ch
        pop ebp
        pop edi
        pop esi
        ret 10h
.25:
        sub edx, esi
        lea edi, [eax+edx]
        mov esi, edx
        mov eax, dword [byte esp+030h]
        lea edx, [nosplit edi*4+00h]
        mov dword [byte esp+054h], eax
        lea eax, [nosplit esi*4+00h]
        add edx, ebp
        neg eax
        add eax, edx
        mov dword [byte esp+018h], eax
        lea eax, [nosplit edi*4+00h]
        sub eax, edi
        shl eax, 3
        mov dword [byte esp+014h], edx
        sub eax, edi
        mov edx, dword [byte esp+030h]
        add eax, eax
        add eax, edx
        mov dword [byte esp+064h], eax
        cmp edi, esi
        jl short .28
        mov eax, esi
        neg eax
        add eax, edi
        mov dword [byte esp+068h], eax
.26:
        mov eax, dword [byte esp+018h]
        mov edx, dword [byte esp+014h]
        mov eax, dword [dword eax+01D2h]
        mov dword [dword edx+01D2h], eax
        mov eax, dword [byte ebp+02h]
        sar eax, 10h
        add eax, esi
        cmp edi, eax
        jge short .27
        imul eax, dword [byte esp+068h], byte 2Eh
        mov ebx, dword [byte esp+054h]
        mov edx, dword [byte esp+064h]
        add eax, ebx
        mov ebx, 2Eh
        call CopyAndClear
.27:
        mov ebx, dword [byte esp+014h]
        mov eax, dword [byte esp+018h]
        mov edx, dword [byte esp+064h]
        dec edi
        sub ebx, byte 4
        sub eax, byte 4
        sub edx, byte 2Eh
        mov dword [byte esp+014h], ebx
        mov ebx, dword [byte esp+068h]
        mov dword [byte esp+018h], eax
        dec ebx
        mov dword [byte esp+064h], edx
        mov dword [byte esp+068h], ebx
        cmp edi, esi
        jge short .26
.28:
        lea eax, [byte esi-01h]
        mov dword [byte esp+01Ch], eax
        mov edx, eax
        shl eax, 2
        sub eax, edx
        shl eax, 3
        sub eax, edx
        mov edi, dword [byte esp+054h]
        add eax, eax
        mov edx, dword [byte esp+074h]
        add edi, eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov ebx, dword [dword esp+090h]
        shl eax, 3
        mov ebx, dword [ebx]
        sub eax, edx
        add ebx, byte 6
        add eax, eax
        mov edx, edi
        add eax, ebx
        mov ebx, 2Eh
        call CopyBytesOk
        lea eax, [byte ecx+06h]
        lea edx, [nosplit esi*4+00h]
        mov dword [byte esp+044h], eax
        lea eax, [byte ebp-04h]
        add eax, edx
        mov dword [byte esp+05Ch], eax
        mov eax, dword [byte esp+01Ch]
        mov dword [byte esp+01Ch], eax
        mov ebx, dword [byte esp+01Ch]
        shl eax, 2
        sub eax, ebx
        shl eax, 3
        sub eax, ebx
        lea edx, [byte ebp-028h]
        add eax, eax
        add edx, eax
        mov edi, 1
        mov dword [byte esp+058h], edx
.29:
        mov eax, dword [byte ecx+02h]
        sar eax, 10h
        inc eax
        sub eax, edi
        mov edx, dword [byte esp+05Ch]
        mov eax, dword [dword ecx+eax*4+01D2h]
        mov dword [dword edx+01D2h], eax
        mov eax, dword [byte ecx+02h]
        sar eax, 10h
        inc eax
        sub eax, edi
        mov dword [dword ecx+eax*4+01D2h], 0
        cmp edi, esi
        jge short .30
        mov eax, dword [byte ecx+02h]
        sar eax, 10h
        sub eax, edi
        imul eax, byte 2Eh
        mov edx, dword [byte esp+044h]
        mov ebx, 2Eh
        add eax, edx
        mov edx, dword [byte esp+058h]
        call CopyAndClear
.30:
        mov eax, dword [byte esp+058h]
        mov ebx, dword [byte esp+05Ch]
        inc edi
        sub eax, byte 2Eh
        sub ebx, byte 4
        mov dword [byte esp+058h], eax
        mov dword [byte esp+05Ch], ebx
        cmp edi, esi
        jle short .29
        add word [byte ebp+04h], si
        mov edx, dword [byte esp+074h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov ebx, dword [dword esp+090h]
        shl eax, 3
        mov ebx, dword [ebx]
        sub eax, edx
        mov edx, dword [byte ecx+02h]
        add ebx, byte 6
        sar edx, 10h
        add eax, eax
        sub edx, esi
        lea edi, [ebx+eax]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        sub eax, edx
        lea edx, [byte ecx+06h]
        add eax, eax
        mov ebx, 2Eh
        add eax, edx
        mov edx, edi
        call CopyAndClear
        mov bx, word [byte ecx+04h]
        mov eax, dword [byte esp+040h]
        sub ebx, esi
        lea edx, [byte esi+01h]
        mov word [byte ecx+04h], bx
        mov ecx, dword [byte esp+03Ch]
        lea ebx, [dword ebp+01D2h]
        call FlushDbPage
        test eax, eax
        jne short .31
        xor edi, edi
        mov eax, edi
        add esp, byte 7Ch
        pop ebp
        pop edi
        pop esi
        ret 10h
.31:
        mov edx, dword [dword esp+08Ch]
        mov ebx, dword [byte esp+024h]
        mov eax, dword [byte esp+040h]
        mov edx, dword [edx]
        mov ebx, dword [ebx]
        sar edx, 3
        call WriteDbPage
        test eax, eax
        jne short .32
        xor edi, edi
        mov eax, edi
        add esp, byte 7Ch
        pop ebp
        pop edi
        pop esi
        ret 10h
.32:
        mov eax, dword [dword esp+08Ch]
        mov edx, dword [byte esp+03Ch]
        mov eax, dword [eax]
        sar edx, 3
        sar eax, 3
        cmp edx, eax
        je short .33
        mov ebx, dword [byte esp+04h]
        mov eax, dword [byte esp+040h]
        call WriteDbPage
        test eax, eax
        jne short .33
        xor edi, edi
        mov eax, edi
        add esp, byte 7Ch
        pop ebp
        pop edi
        pop esi
        ret 10h
.33:
        mov eax, dword [byte esp+03Ch]
        mov edx, dword [byte esp+034h]
        sar eax, 3
        sar edx, 3
        cmp edx, eax
        je short .34
        mov eax, dword [dword esp+08Ch]
        mov eax, dword [eax]
        sar eax, 3
        cmp edx, eax
        je short .34
        mov ebx, dword [byte esp+08h]
        mov eax, dword [byte esp+040h]
        call WriteDbPage
        test eax, eax
        jne short .34
        xor edi, edi
        mov eax, edi
        add esp, byte 7Ch
        pop ebp
        pop edi
        pop esi
        ret 10h
.34:
        cmp dword [byte esp+028h], byte 0
        je short .35
        mov eax, dword [dword esp+090h]
        mov edx, dword [dword esp+08Ch]
        mov dword [eax], ebp
        mov eax, dword [byte esp+03Ch]
        mov dword [edx], eax
        mov edx, dword [byte esp+02Ch]
        mov eax, dword [byte esp+020h]
        mov dword [edx], eax
        mov edx, dword [byte esp+024h]
        mov eax, dword [byte esp+04h]
        mov dword [edx], eax
.35:
        mov edi, 1
.36:
        mov eax, edi
        add esp, byte 7Ch
        pop ebp
        pop edi
        pop esi
        ret 10h
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; RemoveKeyFromNode                               D9614  97 PC, low confidence
; Removes a key from an index node
;-----------------------------------------------------------------------------
RemoveKeyFromNode:
        push esi
        push edi
        push ebp
        sub esp, byte 40h
        mov esi, eax
        mov ebp, edx
        mov edi, ebx
        mov dword [byte esp+03Ch], ecx
        mov ebx, 2Ah
        mov edx, esp
        mov eax, edi
        lea ecx, [byte esp+038h]
        call CopyBytesOk
        lea eax, [byte esp+034h]
        mov ebx, esp
        push eax
        mov edx, ebp
        mov eax, esi
        call SearchIndexNode
        test eax, eax
        je near .1
        mov ebx, 2Ah
        mov edx, esp
        mov eax, edi
        call CompareKeyBytes
        test eax, eax
        jne near .1
        mov edx, dword [byte esp+038h]
        cmp edx, dword [byte edi+02Ah]
        jne near .1
        lea ebx, [byte esp+030h]
        mov edx, dword [byte esp+034h]
        mov eax, esi
        call GetDbPage
        test eax, eax
        je near .2
        mov eax, dword [byte esp+030h]
        mov edx, dword [DbPageStack]
        shl eax, 0Ch
        lea ecx, [edx+eax]
        mov edx, dword [byte esp+034h]
        and edx, byte 7
        mov eax, edx
        shl eax, 8
        sub eax, edx
        add eax, eax
        lea ebx, [byte esp+02Ch]
        add ecx, eax
        mov eax, esp
        mov edx, ecx
        call CompareIndexKey
        test eax, eax
        jne short .1
        mov edi, dword [byte esp+02Ch]
        lea eax, [nosplit edi*4+00h]
        sub eax, edi
        shl eax, 3
        sub eax, edi
        lea edx, [byte ecx+06h]
        add eax, eax
        mov ebx, 2Eh
        add edx, eax
        mov eax, dword [byte esp+03Ch]
        call CopyBytesOk
        mov edx, dword [byte esp+034h]
        mov ebx, dword [byte esp+030h]
        mov eax, esi
        sar edx, 3
        call WriteDbPage
        test eax, eax
        je short .2
        mov eax, 1
        jmp short .2
.1:
        xor eax, eax
.2:
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; DeleteKeyFromNode                               D9708  97 PC, low confidence
; Deletes a key and rebalances the node
;-----------------------------------------------------------------------------
DeleteKeyFromNode:
        push esi
        push edi
        push ebp
        sub esp, byte 50h
        mov esi, eax
        mov dword [byte esp+030h], edx
        mov word [byte esp+04Ch], bx
        mov edi, ecx
        test edx, edx
        je near .9
        lea ebx, [byte esp+048h]
        call GetDbPage
        test eax, eax
        je near .10
        mov eax, dword [byte esp+048h]
        mov edx, dword [DbPageStack]
        shl eax, 0Ch
        add edx, eax
        mov dword [byte esp+038h], edx
        mov edx, dword [byte esp+030h]
        and edx, byte 7
        mov eax, edx
        shl eax, 8
        sub eax, edx
        mov edx, dword [byte esp+038h]
        add eax, eax
        lea ebx, [byte esp+044h]
        add edx, eax
        mov eax, ecx
        mov dword [byte esp+034h], edx
        call CompareIndexKey
        mov ebx, dword [byte esp+044h]
        mov ecx, dword [byte esp+034h]
        shl ebx, 2
        add ebx, ecx
        test eax, eax
        jne near .7
        mov edx, dword [byte esp+044h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        sub eax, edx
        add eax, eax
        add eax, ecx
        mov ebp, dword [byte edi+02Ah]
        cmp ebp, dword [byte eax+030h]
        jne near .9
        cmp dword [dword ecx+01D2h], byte 0
        jne short .3
        mov edx, dword [byte ecx+02h]
        sar edx, 10h
        mov ebx, dword [byte esp+044h]
        dec edx
        cmp edx, ebx
        je short .2
        mov ecx, 2Eh
.1:
        mov eax, dword [byte esp+034h]
        mov eax, dword [byte eax+02h]
        sar eax, 10h
        mov edi, dword [byte esp+044h]
        dec eax
        cmp eax, edi
        jle near .6
        imul edx, edi, byte 2Eh
        lea ebx, [byte edi+01h]
        imul ebx, byte 2Eh
        mov eax, dword [byte esp+034h]
        add eax, byte 6
        add edx, eax
        add eax, ebx
        mov ebx, ecx
        call CopyAndClear
        inc dword [byte esp+044h]
        jmp short .1
.2:
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        shl eax, 3
        sub eax, ebx
        lea edx, [byte ecx+06h]
        add eax, eax
        add eax, edx
        mov edx, 2Eh
        call ZeroBytesOk
        jmp near .6
.3:
        mov ecx, dword [dword ebx+01D6h]
        xor ebp, ebp
.4:
        lea ebx, [byte esp+03Ch]
        mov edx, ecx
        mov eax, esi
        call GetDbPage
        test eax, eax
        je near .10
        mov edx, dword [byte esp+03Ch]
        mov eax, dword [DbPageStack]
        shl edx, 0Ch
        add eax, edx
        mov edx, ecx
        and edx, byte 7
        imul edx, dword 1FEh
        add eax, edx
        mov edx, dword [dword eax+01D2h]
        cmp ebp, edx
        je short .5
        mov ecx, edx
.5:
        cmp ebp, dword [dword eax+01D2h]
        jne short .4
        mov ebx, 2Eh
        mov edx, esp
        add eax, byte 6
        mov ebp, dword [byte esp+04Ah]
        call CopyBytesOk
        mov ecx, dword [byte esp+02Ah]
        mov ebx, esp
        sar ebp, 10h
        mov eax, esi
        mov edx, ebp
        call DeleteIndexKey
        mov ecx, esp
        mov ebx, edi
        mov edx, ebp
        mov eax, esi
        call RemoveKeyFromNode
        test eax, eax
        je near .10
        mov eax, dword [byte esp+060h]
        mov dword [eax], 0Ah
        mov eax, 1
        add esp, byte 50h
        pop ebp
        pop edi
        pop esi
        ret 4
.6:
        mov eax, dword [byte esp+034h]
        dec word [byte eax+04h]
        mov edx, dword [byte esp+030h]
        mov ebx, dword [byte esp+048h]
        mov eax, esi
        sar edx, 3
        call WriteDbPage
        test eax, eax
        jne short .8
        add esp, byte 50h
        pop ebp
        pop edi
        pop esi
        ret 4
.7:
        cmp dword [dword ecx+01D2h], byte 0
        je short .9
        lea eax, [byte esp+040h]
        mov ebp, dword [byte esp+04Ah]
        mov ecx, edi
        mov edx, dword [dword ebx+01D2h]
        sar ebp, 10h
        push eax
        mov ebx, ebp
        mov eax, esi
        call DeleteKeyFromNode
        test eax, eax
        je short .10
        mov eax, dword [byte esp+040h]
        cmp eax, byte 5
        jge short .8
        push eax
        mov ebx, dword [byte esp+048h]
        push ebx
        lea eax, [byte esp+03Ch]
        lea ecx, [byte esp+040h]
        push eax
        lea eax, [byte esp+03Ch]
        mov edx, ebp
        push eax
        lea ebx, [byte esp+058h]
        mov eax, esi
        call MergeIndexNodes
.8:
        mov eax, dword [byte esp+034h]
        mov eax, dword [byte eax+02h]
        mov edx, dword [byte esp+060h]
        sar eax, 10h
        mov dword [edx], eax
        mov eax, 1
        add esp, byte 50h
        pop ebp
        pop edi
        pop esi
        ret 4
.9:
        xor eax, eax
.10:
        add esp, byte 50h
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DeleteIndexKey                                  D9960  97 PC, low confidence
; Deletes a key from the index
;-----------------------------------------------------------------------------
DeleteIndexKey:
        push esi
        push edi
        push ebp
        sub esp, byte 3Ch
        mov edi, eax
        mov word [byte esp+038h], dx
        mov eax, ebx
        mov ebx, 2Ah
        mov edx, esp
        call CopyBytesOk
        mov ebx, dword [byte esp+036h]
        sar ebx, 10h
        lea ebp, [nosplit ebx*4+00h]
        add ebp, edi
        mov dword [byte esp+02Ah], ecx
        mov esi, edi
        mov edx, dword [byte ebp+031h]
        mov dword [dword ebp+0E5h], 0
        test edx, edx
        je near .2
        lea eax, [byte esp+034h]
        push eax
        lea ecx, [byte esp+04h]
        mov eax, edi
        call DeleteKeyFromNode
        test eax, eax
        je near .4
        cmp dword [byte esp+034h], byte 0
        jne near .3
        lea ebx, [byte esp+030h]
        mov eax, edi
        mov edx, dword [byte ebp+031h]
        call GetDbPage
        test eax, eax
        je near .4
        mov edx, dword [byte esp+030h]
        mov eax, dword [DbPageStack]
        shl edx, 0Ch
        add edx, eax
        xor eax, eax
        mov ax, word [dword edx+0FF0h]
        mov dword [byte esp+034h], eax
        mov cx, word [byte ebp+031h]
        mov eax, 1
        and cl, 7
        shl eax, cl
        mov bx, word [dword edx+0FF0h]
        not eax
        and ebx, eax
        mov word [dword edx+0FF0h], bx
        cmp dword [byte esp+034h], 0FFh
        jne short .1
        mov eax, dword [dword edi+01F5h]
        mov dword [dword edx+0FF2h], eax
        mov eax, dword [byte esp+030h]
        mov dword [dword edi+01F5h], eax
.1:
        mov eax, dword [byte esp+036h]
        sar eax, 10h
        shl eax, 2
        lea ecx, [esi+eax]
        mov ebx, dword [byte esp+030h]
        mov edx, dword [byte ecx+031h]
        mov eax, esi
        sar edx, 3
        call WriteDbPage
        test eax, eax
        je short .4
        lea ebx, [byte esp+030h]
        mov eax, esi
        xor edx, edx
        mov dword [byte ecx+031h], 0
        call GetDbPage
        test eax, eax
        je short .4
        mov edx, dword [byte esp+030h]
        mov eax, dword [DbPageStack]
        shl edx, 0Ch
        mov ebx, 1FEh
        add edx, eax
        mov eax, esi
        call CopyBytesOk
        mov ebx, dword [byte esp+030h]
        mov eax, esi
        xor edx, edx
        call WriteDbPage
        test eax, eax
        jne short .3
        jmp short .4
.2:
        xor eax, eax
        jmp short .4
.3:
        mov eax, 1
.4:
        add esp, byte 3Ch
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SearchIndexNode                                 D9AB4  97 PC, low confidence
; Searches an index node for a key
;-----------------------------------------------------------------------------
SearchIndexNode:
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov edi, eax
        mov word [byte esp+018h], dx
        mov ebp, ebx
        mov dword [byte esp+08h], ecx
        mov eax, dword [byte esp+016h]
        sar eax, 10h
        shl eax, 2
        add eax, edi
        mov esi, dword [byte eax+031h]
        mov dword [dword eax+0E5h], 0
        test esi, esi
        je near .7
        xor edx, edx
        mov dword [byte esp+010h], edx
        mov dword [byte esp+0Ch], edx
        mov dword [byte esp+014h], edx
.1:
        lea ebx, [byte esp+04h]
        mov edx, esi
        mov eax, edi
        call GetDbPage
        test eax, eax
        je near .8
        mov ecx, esi
        and ecx, byte 7
        imul ecx, dword 1FEh
        mov eax, dword [byte esp+04h]
        mov ebx, dword [DbPageStack]
        shl eax, 0Ch
        add eax, ebx
        add ecx, eax
        mov ebx, esp
        mov edx, ecx
        mov eax, ebp
        call CompareIndexKey
        lea ebx, [byte ecx+06h]
        test eax, eax
        jne short .2
        mov eax, dword [byte esp+016h]
        sar eax, 10h
        lea edx, [nosplit eax*4+00h]
        add edx, edi
        add eax, eax
        mov dword [dword edx+0E5h], esi
        add edi, eax
        mov eax, dword [esp]
        mov word [dword edi+0199h], ax
        mov edi, dword [esp]
        lea eax, [nosplit edi*4+00h]
        sub eax, edi
        shl eax, 3
        sub eax, edi
        add eax, eax
        mov edx, ebp
        add eax, ebx
        mov ebx, 2Ah
        call CopyBytesOk
        mov ebx, dword [esp]
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        shl eax, 3
        sub eax, ebx
        mov edx, dword [byte esp+08h]
        mov eax, dword [byte ecx+eax*2+030h]
        mov dword [edx], eax
        mov eax, dword [byte esp+02Ch]
        mov dword [eax], esi
        mov eax, 1
        jmp near .8
.2:
        mov eax, dword [esp]
        cmp dword [dword ecx+eax*4+01D2h], byte 0
        jne near .5
        mov eax, dword [byte ecx+02h]
        mov edx, dword [esp]
        sar eax, 10h
        cmp eax, edx
        jle short .3
        mov eax, dword [byte esp+016h]
        sar eax, 10h
        lea edx, [nosplit eax*4+00h]
        add edx, edi
        add eax, eax
        mov dword [dword edx+0E5h], esi
        add edi, eax
        mov eax, dword [esp]
        mov word [dword edi+0199h], ax
        mov edi, dword [esp]
        lea eax, [nosplit edi*4+00h]
        sub eax, edi
        shl eax, 3
        sub eax, edi
        add eax, eax
        mov edx, ebp
        add eax, ebx
        mov ebx, 2Ah
        call CopyBytesOk
        mov ebx, dword [esp]
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        shl eax, 3
        sub eax, ebx
        mov edx, dword [byte esp+08h]
        mov eax, dword [byte ecx+eax*2+030h]
        mov dword [edx], eax
        mov eax, dword [byte esp+02Ch]
        mov dword [eax], esi
        mov eax, 1
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        ret 4
.3:
        cmp dword [byte esp+014h], byte 0
        je short .4
        mov eax, dword [byte esp+016h]
        mov ecx, dword [byte esp+0Ch]
        mov edx, dword [byte esp+010h]
        sar eax, 10h
        mov ebx, dword [byte esp+010h]
        mov dword [dword edi+eax*4+0E5h], ecx
        lea ecx, [nosplit ebx*4+00h]
        mov word [dword edi+eax*2+0199h], dx
        sub ecx, ebx
        mov eax, dword [byte esp+014h]
        shl ecx, 3
        mov edx, ebp
        sub ecx, ebx
        add eax, byte 6
        add ecx, ecx
        mov ebx, 2Ah
        add eax, ecx
        call CopyBytesOk
        mov eax, dword [byte esp+014h]
        mov edx, dword [byte esp+08h]
        mov eax, dword [byte ecx+eax+030h]
        mov dword [edx], eax
        mov edx, dword [byte esp+02Ch]
        mov eax, dword [byte esp+0Ch]
        mov dword [edx], eax
        mov eax, 1
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        ret 4
.4:
        mov eax, dword [byte esp+016h]
        sar eax, 10h
        lea edx, [nosplit eax*4+00h]
        add edx, edi
        add eax, eax
        mov dword [dword edx+0E5h], esi
        mov dx, word [byte ecx+04h]
        add edi, eax
        dec edx
        mov word [dword edi+0199h], dx
        mov eax, dword [byte ecx+02h]
        sar eax, 10h
        lea edi, [byte eax-01h]
        lea eax, [nosplit edi*4+00h]
        sub eax, edi
        shl eax, 3
        sub eax, edi
        add eax, eax
        mov edx, ebp
        add eax, ebx
        mov ebx, 2Ah
        call CopyBytesOk
        mov ebx, dword [byte ecx+02h]
        sar ebx, 10h
        dec ebx
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        shl eax, 3
        sub eax, ebx
        mov edx, dword [byte esp+08h]
        mov eax, dword [byte ecx+eax*2+030h]
        mov dword [edx], eax
        mov eax, dword [byte esp+02Ch]
        mov dword [eax], esi
        mov eax, 1
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        ret 4
.5:
        mov eax, dword [byte ecx+02h]
        mov ebx, dword [esp]
        sar eax, 10h
        cmp eax, ebx
        jle short .6
        mov dword [byte esp+014h], ecx
        mov dword [byte esp+010h], ebx
        mov dword [byte esp+0Ch], esi
.6:
        mov eax, dword [esp]
        mov esi, dword [dword ecx+eax*4+01D2h]
        jmp near .1
.7:
        mov dword [dword eax+0E5h], esi
        mov byte [ebx], 0
        mov eax, ecx
        mov dword [ecx], 0FFFFFFFFh
        xor eax, ecx
.8:
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        ret 4
        db 090h
;-----------------------------------------------------------------------------
; FindIndexKey                                    D9D74  97 PC, low confidence
; Finds a key in the index
;-----------------------------------------------------------------------------
FindIndexKey:
        push esi
        sub esp, byte 4
        mov esi, esp
        push esi
        movsx edx, dx
        call SearchIndexNode
        add esp, byte 4
        pop esi
        ret
        push esi
        push edi
        push ebp
        sub esp, byte 40h
        mov edi, eax
        mov word [byte esp+03Ch], dx
        mov esi, ebx
        mov ebp, ecx
        mov ebx, 2Ah
        xor edx, edx
        mov dword [byte esp+034h], eax
        mov dword [byte esp+038h], edx
        mov eax, esi
        mov edx, esp
        lea ecx, [byte esp+02Ch]
        call CopyBytesOk
        lea eax, [byte esp+030h]
        mov edx, dword [byte esp+03Ah]
        mov ebx, esp
        push eax
        sar edx, 10h
        mov eax, edi
        call SearchIndexNode
        test eax, eax
        je short .3
        mov ebx, 2Ah
        mov edx, esp
        mov eax, esi
        call CompareKeyBytes
        test eax, eax
        jne short .1
        cmp ebp, dword [byte esp+02Ch]
        jne short .1
        mov dword [byte esp+038h], 1
        jmp short .2
.1:
        mov eax, dword [byte esp+03Ah]
        sar eax, 10h
        mov ecx, dword [byte esp+034h]
        shl eax, 2
        add eax, ecx
        mov dword [dword eax+0E5h], 0
.2:
        mov eax, dword [byte esp+038h]
.3:
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LeftmostKey                                     D9E18  97 PC, low confidence
; Walks down to the first key of a subtree
;-----------------------------------------------------------------------------
LeftmostKey:
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov esi, eax
        mov word [byte esp+04h], dx
        mov edi, ebx
        mov ebp, ecx
        mov ebx, esp
        mov edx, dword [byte esp+018h]
        call GetDbPage
        test eax, eax
        jne short .1
        mov eax, dword [byte esp+02h]
        sar eax, 10h
        mov dword [dword esi+eax*4+0E5h], 0
        xor eax, eax
        jmp near .3
.1:
        mov edx, dword [esp]
        mov ecx, dword [byte esp+018h]
        mov eax, dword [DbPageStack]
        shl edx, 0Ch
        and ecx, byte 7
        add edx, eax
        mov eax, ecx
        shl eax, 8
        sub eax, ecx
        add eax, eax
        lea ecx, [edx+eax]
        mov edx, dword [dword ecx+01D2h]
        test edx, edx
        jne short .2
        mov ebx, 2Ah
        lea eax, [byte ecx+06h]
        mov edx, edi
        call CopyBytesOk
        mov eax, dword [byte ecx+030h]
        mov dword [byte ebp+00h], eax
        mov eax, dword [byte esp+02h]
        sar eax, 10h
        mov ebx, dword [byte esp+018h]
        mov dword [dword esi+eax*4+0E5h], ebx
        mov word [dword esi+eax*2+0199h], 0
        mov eax, 1
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret 4
.2:
        push edx
        mov ecx, ebp
        mov ebx, edi
        mov edx, dword [byte esp+06h]
        mov eax, esi
        sar edx, 10h
        call LeftmostKey
.3:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; RightmostKey                                    D9ED8  97 PC, low confidence
; Walks down to the last key of a subtree
;-----------------------------------------------------------------------------
RightmostKey:
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov esi, eax
        mov word [byte esp+04h], dx
        mov edi, ebx
        mov ebp, ecx
        mov ebx, esp
        mov edx, dword [byte esp+018h]
        call GetDbPage
        test eax, eax
        jne short .1
        mov eax, dword [byte esp+02h]
        sar eax, 10h
        mov dword [dword esi+eax*4+0E5h], 0
        xor eax, eax
        jmp near .3
.1:
        mov eax, dword [esp]
        mov edx, dword [DbPageStack]
        shl eax, 0Ch
        lea ecx, [edx+eax]
        mov edx, dword [byte esp+018h]
        and edx, byte 7
        mov eax, edx
        shl eax, 8
        sub eax, edx
        add eax, eax
        add ecx, eax
        mov edx, dword [byte ecx+02h]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        add eax, ecx
        cmp dword [dword eax+01CEh], byte 0
        jne short .2
        dec edx
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        sub eax, edx
        lea edx, [eax+eax]
        lea eax, [byte ecx+06h]
        mov ebx, 2Ah
        add eax, edx
        mov edx, edi
        call CopyBytesOk
        mov eax, dword [byte ecx+02h]
        sar eax, 10h
        lea edx, [byte eax-01h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        sub eax, edx
        mov eax, dword [byte ecx+eax*2+030h]
        mov dword [byte ebp+00h], eax
        mov eax, dword [byte esp+02h]
        sar eax, 10h
        mov ebx, dword [byte esp+018h]
        mov dword [dword esi+eax*4+0E5h], ebx
        mov dx, word [byte ecx+04h]
        dec edx
        mov word [dword esi+eax*2+0199h], dx
        mov eax, 1
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret 4
.2:
        mov edx, dword [byte esp+02h]
        mov ecx, dword [dword eax+01D2h]
        mov ebx, edi
        push ecx
        sar edx, 10h
        mov eax, esi
        mov ecx, ebp
        call RightmostKey
.3:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; FirstOrLastKey                                  D9FDC  97 PC, low confidence
; Finds the first or the last key of the index
;-----------------------------------------------------------------------------
FirstOrLastKey:
        push esi
        movsx edx, dx
        mov esi, dword [byte eax+edx*4+031h]
        mov dword [dword eax+edx*4+0E5h], 0
        test esi, esi
        je short .2
        cmp dword [byte esp+08h], byte 0
        je short .1
        push esi
        call LeftmostKey
        pop esi
        ret 4
.1:
        push esi
        call RightmostKey
        pop esi
        ret 4
.2:
        mov byte [ebx], 0
        mov eax, 1
        mov dword [ecx], 0FFFFFFFFh
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; FindLastKey                                     DA020  97 PC, low confidence
; Finds the last key of the index (probably)
;-----------------------------------------------------------------------------
FindLastKey:
        push byte 1
        movsx edx, dx
        call FirstOrLastKey
        ret
        db 090h
;-----------------------------------------------------------------------------
; FindFirstKey                                    DA02C  97 PC, low confidence
; Finds the first key of the index (probably)
;-----------------------------------------------------------------------------
FindFirstKey:
        push byte 0
        movsx edx, dx
        call FirstOrLastKey
        ret
        db 090h
;-----------------------------------------------------------------------------
; PrevKeyInNode                                   DA038  97 PC, low confidence
; Steps to the previous key in a node
;-----------------------------------------------------------------------------
PrevKeyInNode:
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov edi, eax
        mov word [byte esp+08h], dx
        mov esi, ebx
        mov ebp, ecx
        lea ebx, [byte esp+04h]
        mov edx, dword [byte esp+01Ch]
        call GetDbPage
        test eax, eax
        jne short .1
        mov eax, dword [byte esp+06h]
        sar eax, 10h
        mov dword [dword edi+eax*4+0E5h], 0
        xor eax, eax
        jmp near .4
.1:
        mov eax, dword [byte esp+04h]
        mov edx, dword [DbPageStack]
        shl eax, 0Ch
        lea ecx, [edx+eax]
        mov edx, dword [byte esp+01Ch]
        and edx, byte 7
        mov eax, edx
        shl eax, 8
        sub eax, edx
        add eax, eax
        add ecx, eax
        mov ebx, esp
        mov edx, ecx
        mov eax, esi
        call CompareIndexKey
        test eax, eax
        je near .4
        mov edx, dword [esp]
        test edx, edx
        jne short .3
        mov eax, dword [ecx]
        test eax, eax
        je short .2
        mov edx, dword [byte esp+06h]
        push eax
        mov ecx, ebp
        mov ebx, esi
        sar edx, 10h
        mov eax, edi
        call PrevKeyInNode
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret 4
.2:
        mov dword [byte ebp+00h], 0FFFFFFFFh
        mov eax, 1
        mov byte [esi], 0
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret 4
.3:
        lea ebx, [byte edx-01h]
        mov dword [esp], ebx
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        shl eax, 3
        sub eax, ebx
        lea edx, [byte ecx+06h]
        add eax, eax
        mov ebx, 2Ah
        add eax, edx
        mov edx, esi
        call CopyBytesOk
        mov esi, dword [esp]
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 3
        sub eax, esi
        mov eax, dword [byte ecx+eax*2+030h]
        mov dword [byte ebp+00h], eax
        mov eax, dword [byte esp+06h]
        sar eax, 10h
        mov ebx, dword [byte esp+01Ch]
        mov dword [dword edi+eax*4+0E5h], ebx
        add eax, eax
        add edi, eax
        mov eax, dword [esp]
        mov word [dword edi+0199h], ax
        mov eax, 1
.4:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; NextKeyInNode                                   DA158  97 PC, low confidence
; Steps to the next key in a node
;-----------------------------------------------------------------------------
NextKeyInNode:
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov esi, eax
        mov word [byte esp+08h], dx
        mov edi, ebx
        mov ebp, ecx
        lea ebx, [byte esp+04h]
        mov edx, dword [byte esp+01Ch]
        call GetDbPage
        test eax, eax
        jne short .1
        mov eax, dword [byte esp+06h]
        sar eax, 10h
        mov dword [dword esi+eax*4+0E5h], 0
        xor eax, eax
        jmp near .4
.1:
        mov ecx, dword [byte esp+04h]
        mov edx, dword [byte esp+01Ch]
        mov eax, dword [DbPageStack]
        shl ecx, 0Ch
        and edx, byte 7
        add ecx, eax
        mov eax, edx
        shl eax, 8
        sub eax, edx
        add eax, eax
        add ecx, eax
        mov ebx, esp
        mov edx, ecx
        mov eax, edi
        call CompareIndexKey
        test eax, eax
        je near .4
        mov eax, dword [byte ecx+02h]
        mov edx, dword [esp]
        sar eax, 10h
        cmp eax, edx
        jg short .3
        mov ebx, dword [ecx]
        test ebx, ebx
        je short .2
        mov edx, dword [byte esp+06h]
        push ebx
        mov ecx, ebp
        mov eax, esi
        sar edx, 10h
        mov ebx, edi
        call NextKeyInNode
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret 4
.2:
        mov dword [byte ebp+00h], 0FFFFFFFFh
        mov eax, 1
        mov byte [edi], 0
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret 4
.3:
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        sub eax, edx
        lea edx, [byte ecx+06h]
        add eax, eax
        mov ebx, 2Ah
        add eax, edx
        mov edx, edi
        call CopyBytesOk
        mov edx, dword [esp]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        sub eax, edx
        mov eax, dword [byte ecx+eax*2+030h]
        mov dword [byte ebp+00h], eax
        mov eax, dword [byte esp+06h]
        sar eax, 10h
        mov ebx, dword [byte esp+01Ch]
        mov dword [dword esi+eax*4+0E5h], ebx
        add eax, eax
        add esi, eax
        mov eax, dword [esp]
        mov word [dword esi+0199h], ax
        mov eax, 1
.4:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; StepIndexKey                                    DA274  97 PC, low confidence
; Steps to the next or previous key of the index
;-----------------------------------------------------------------------------
StepIndexKey:
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        mov edi, eax
        mov word [byte esp+014h], dx
        mov esi, ebx
        mov ebp, ecx
        mov eax, dword [byte esp+012h]
        sar eax, 10h
        mov edx, edi
        mov dword [byte esp+010h], eax
        shl eax, 2
        add edx, eax
        mov ecx, dword [dword edx+0E5h]
        mov dword [byte esp+08h], edx
        test ecx, ecx
        je near .9
        mov ebx, esp
        mov edx, ecx
        mov eax, edi
        call GetDbPage
        test eax, eax
        jne short .1
        mov eax, dword [byte esp+08h]
        mov dword [dword eax+0E5h], 0
        jmp near .9
.1:
        mov edx, dword [esp]
        mov eax, dword [DbPageStack]
        mov ebx, ecx
        shl edx, 0Ch
        and ebx, byte 7
        add edx, eax
        mov eax, ebx
        shl eax, 8
        sub eax, ebx
        add eax, eax
        lea ecx, [edx+eax]
        mov eax, dword [byte esp+010h]
        add eax, eax
        add eax, edi
        mov dx, word [byte ecx+04h]
        mov bx, word [dword eax+0199h]
        cmp bx, dx
        jge near .9
        cmp dword [dword ecx+01D2h], byte 0
        jne near .7
        lea edx, [byte ecx+06h]
        mov dword [byte esp+0Ch], edx
        cmp dword [byte esp+028h], byte 0
        je short .4
        mov ebx, dword [byte ecx+02h]
        mov edx, dword [dword eax+0197h]
        sar ebx, 10h
        sar edx, 10h
        dec ebx
        cmp edx, ebx
        jne short .3
        cmp dword [ecx], byte 0
        je short .2
        mov ebx, 2Ah
        mov eax, dword [byte esp+0Ch]
        mov edx, esi
        call CopyBytesOk
        mov edx, dword [byte esp+010h]
        mov ebx, dword [ecx]
        mov eax, edi
        push ebx
        mov ecx, ebp
        mov ebx, esi
        call NextKeyInNode
        jmp near .10
.2:
        mov dword [byte ebp+00h], 0FFFFFFFFh
        mov eax, 1
        mov byte [esi], 0
        jmp near .10
.3:
        inc word [dword eax+0199h]
        jmp short .6
.4:
        cmp bx, byte 1
        jge short .5
        cmp dword [ecx], byte 0
        je short .2
        mov ebx, 2Ah
        mov eax, dword [byte esp+0Ch]
        mov edx, esi
        call CopyBytesOk
        mov edx, dword [byte esp+010h]
        mov eax, dword [ecx]
        mov ebx, esi
        push eax
        mov ecx, ebp
        mov eax, edi
        call PrevKeyInNode
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        ret 4
.5:
        mov edx, ebx
        dec edx
        mov word [dword eax+0199h], dx
.6:
        mov eax, dword [byte esp+012h]
        sar eax, 10h
        add eax, eax
        add edi, eax
        mov dword [byte esp+04h], edi
        mov edi, dword [dword edi+0197h]
        sar edi, 10h
        lea edx, [nosplit edi*4+00h]
        sub edx, edi
        shl edx, 3
        sub edx, edi
        lea eax, [byte ecx+06h]
        add edx, edx
        mov ebx, 2Ah
        add eax, edx
        mov edx, esi
        mov esi, dword [byte esp+04h]
        call CopyBytesOk
        mov esi, dword [dword esi+0197h]
        sar esi, 10h
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 3
        sub eax, esi
        mov eax, dword [byte ecx+eax*2+030h]
        mov dword [byte ebp+00h], eax
        mov eax, 1
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        ret 4
.7:
        cmp dword [byte esp+028h], byte 0
        je short .8
        mov eax, dword [dword eax+0197h]
        sar eax, 10h
        mov ebx, dword [dword ecx+eax*4+01D6h]
        mov edx, dword [byte esp+010h]
        push ebx
        mov ecx, ebp
        mov eax, edi
        mov ebx, esi
        call LeftmostKey
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        ret 4
.8:
        mov eax, dword [dword eax+0197h]
        sar eax, 10h
        mov edx, dword [dword ecx+eax*4+01D2h]
        mov ebx, esi
        push edx
        mov ecx, ebp
        mov eax, edi
        mov edx, dword [byte esp+014h]
        call RightmostKey
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        ret 4
.9:
        xor eax, eax
.10:
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; NextIndexKey                                    DA48C  97 PC, low confidence
; Steps to the next key of the index
;-----------------------------------------------------------------------------
NextIndexKey:
        push byte 1
        movsx edx, dx
        call StepIndexKey
        ret
        db 090h
;-----------------------------------------------------------------------------
; PrevIndexKey                                    DA498  97 PC, low confidence
; Steps to the previous key of the index
;-----------------------------------------------------------------------------
PrevIndexKey:
        push byte 0
        movsx edx, dx
        call StepIndexKey
        ret
        db 090h
;-----------------------------------------------------------------------------
; BuildKey                                        DA4A4  97 PC, low confidence
; Builds an index key from a number or string
;-----------------------------------------------------------------------------
BuildKey:
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        mov edi, eax
        mov esi, ebx
        mov eax, edx
        cmp edi, byte 1
        jl short .1
        cmp edi, byte 7
        jle short .2
.1:
        xor eax, eax
        jmp near .6
.2:
        mov edx, esp
        mov ebx, edi
        call CopyBytesOk
        test ecx, ecx
        je short .3
        add byte [byte esp+edi-01h], 80h
.3:
        mov eax, 7
        mov edx, esi
        xor cl, cl
        xor ebx, ebx
        jmp short .5
.4:
        mov ecx, edi
        inc esi
        sub ecx, esi
        mov esi, ecx
        xor ecx, ecx
        mov cl, byte [esp+esi]
        mov dword [byte esp+010h], ecx
        mov esi, dword [byte esp+010h]
        mov cl, al
        shl esi, cl
        mov word [byte esp+0Ch], si
        mov esi, dword [byte esp+0Ah]
        xor ecx, ecx
        sar esi, 10h
        mov cl, byte [byte esp+014h]
        sar esi, 7
        or ecx, esi
        mov dword [byte esp+08h], ecx
        inc ebx
        mov cl, byte [byte esp+08h]
        dec eax
        mov byte [edx], cl
        mov cl, byte [byte esp+0Ch]
        mov edx, ebp
.5:
        or cl, 1
        lea ebp, [byte edx+01h]
        movsx esi, bx
        mov byte [byte esp+014h], cl
        cmp esi, edi
        jl short .4
        mov byte [edx], cl
        mov eax, 1
        mov byte [byte ebp+00h], 0
.6:
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; BuildKeyFromLong                                DA544  97 PC, low confidence
; Builds an index key from a number (two entries)
;-----------------------------------------------------------------------------
BuildKeyFromLong:
        push ecx
        xor ecx, ecx
        call BuildKey
        pop ecx
        ret
        db 08Bh,0C0h
        push ecx
        mov ecx, 1
        call BuildKey
        pop ecx
        ret
        db 08Dh,040h,00h
        push esi
        mov esi, eax
        cmp byte [ebx], 0
        je short .2
.1:
        mov al, byte [byte ebx+01h]
        inc ebx
        test al, al
        jne short .1
.2:
        mov eax, esi
        call BuildKey
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; BuildKeyFromString                              DA57C  97 PC, low confidence
; Builds an index key from a string
;-----------------------------------------------------------------------------
BuildKeyFromString:
        push ecx
        push esi
        mov ecx, eax
        mov eax, ebx
        mov esi, ecx
        xor ecx, ecx
        cmp byte [ebx], 0
        je short .2
.1:
        mov ah, byte [byte ebx+01h]
        inc ebx
        test ah, ah
        jne short .1
.2:
        mov eax, esi
        call BuildKey
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
        push ecx
        push esi
        mov ecx, eax
        mov eax, ebx
        mov esi, ecx
        mov ecx, 1
        cmp byte [ebx], 0
        je short .4
.3:
        mov ah, byte [byte ebx+01h]
        inc ebx
        test ah, ah
        jne short .3
.4:
        mov eax, esi
        call BuildKey
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; ParseKey                                        DA5C4  97 PC, low confidence
; Reads a number back from an index key
;-----------------------------------------------------------------------------
ParseKey:
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov esi, eax
        mov edi, ebx
        mov ebp, ecx
        mov eax, edx
        cmp esi, byte 1
        jl short .1
        cmp esi, byte 7
        jle short .2
.1:
        xor eax, eax
        jmp short .6
.2:
        mov edx, esp
        lea ebx, [byte esi+01h]
        call CopyBytesOk
        mov edx, esi
        mov ebx, edi
        dec edx
        mov cl, byte [esp+esi]
        test dx, dx
        jl short .4
.3:
        movsx eax, dx
        mov ch, byte [esp+eax]
        and ch, 0FEh
        movzx si, ch
        shl esi, 7
        xor ch, ch
        or esi, ecx
        movsx esi, si
        mov ecx, 7
        mov edi, esi
        sub ecx, eax
        sar edi, cl
        mov ecx, edi
        mov byte [ebx], cl
        mov ecx, 0Fh
        sub ecx, eax
        sar esi, cl
        mov ecx, 8
        sub ecx, eax
        inc ebx
        shl esi, cl
        dec edx
        mov ecx, esi
        test dx, dx
        jge short .3
.4:
        test ebp, ebp
        je short .5
        mov ah, byte [byte ebx-01h]
        dec ebx
        sub ah, 80h
        mov byte [ebx], ah
.5:
        mov eax, 1
.6:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; KeyToLong                                       DA654  97 PC, low confidence
; Reads a number back from an index key (two entries)
;-----------------------------------------------------------------------------
KeyToLong:
        push ecx
        xor ecx, ecx
        call ParseKey
        pop ecx
        ret
        db 08Bh,0C0h
        push ecx
        mov ecx, 1
        call ParseKey
        pop ecx
        ret
