; Stat tables: cells, columns, sorting, drawing and CSV export.
bits 32
%include "hockey.inc"
section s_AC799 progbits alloc exec nowrite align=1
extern AllocMemBlock, BlitArt, BlitClippedY, CreateBitmap, DrawListHighlight, DrawScrollBar, DrawTextAligned, EditTextField
extern fclose_, fopen_, fprintf_, FreeBitmap, FreeMemBlock, FreeScrollList, GetLangText, InitScrollList
extern InitScrollTable, MakeColor, qsort_, ScrollDown, ScrollToMouse, ScrollUp, SetDrawTarget, SetListSelection
extern SetRegionRect, SetScrollBarPos, ShowMessageBoxNoWait, sprintf_, sscanf_, StatExportSeparator, StatTableAlpha, StatTableColumns
extern StatTableRows, StatTableSortColumn, StatTableSortKeys, StatTableSortText, str_03d, str_D, str_D01d2, str_D02d
extern str_D_ExportStatTable, str_DD2, str_DDD4, str_DS3, str_NA, str_Punct_ExportStatTable, str_Punct_WriteCsvLine, str_Rt
extern str_S_ExportStatTable, str_Statthingy, str_StatthingyAlpha, str_StatthingyCol, str_StatthingyColNames, str_StatthingyFlg, str_StatthingyNames, str_StatthingySort
extern str_StatthingySort2, str_StatthingyStringsort, str_Wt, strcmp_, strlen_, TeamStatsScreen_13C3
global AllocStatTable, AllocStatTable_2AA, FreeStatTable, SetStatCell, SetStatCellFlag, SetStatColumn, SetStatRowWidth, SortStatTableBy
global CompareStatNumber, CompareStatText, CompareStatTextDown, CompareStatName, SortStatTableJumpTable, SortStatTable, SortStatTable_301, SortStatTable_303
global SortStatTable_310, SortStatTable_321, SortStatTable_323, SortStatTable_36B, DrawStatTableRowsJumpTable, DrawStatTableRows, DrawStatTableRows_2A9, DrawStatTableRows_2C4
global DrawStatTableRows_2ED, DrawStatTableRows_34B, DrawStatTableRows_36C, DrawStatTableRows_3D1, DrawStatTableRows_3FD, DrawStatTableRows_435, DrawStatTableRows_470, DrawStatTableRows_48D
global DrawStatTableRows_4D7, DrawStatTableArt, WriteCsvField, WriteCsvLine, AskExportFile, ExportStatTableJumpTable, ExportStatTable, ExportStatTable_19A
global ExportStatTable_1BA, ExportStatTable_1EB, ExportStatTable_221, ExportStatTable_26D, ExportStatTable_2D9, ExportStatTable_304, ExportStatTable_344, ExportStatTable_36C
global ExportStatTable_38A
;-----------------------------------------------------------------------------
; AllocStatTable                                  AC799  97 PC, low confidence
; Allocates the "statthingy" list tables (flags, columns, sort, names, alpha,
; string sort) for a stats list
;-----------------------------------------------------------------------------
AllocStatTable:
        push esi
        push edi
        enter 20h, 0
        mov esi, eax
        mov dword [byte ebp-08h], edx
        mov byte [byte ebp-04h], cl
        mov dword [eax], edx
        mov dword [byte eax+04h], edx
        mov dword [byte eax+08h], ebx
        mov edi, edx
        mov byte [byte eax+0Ch], cl
        mov al, byte [byte ebp+010h]
        shl edi, 2
        mov byte [byte esi+0Dh], al
        mov eax, edi
        imul eax, ebx
        push byte 0
        push eax
        push str_Statthingy
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte esi+012h], eax
        mov eax, dword [byte ebp-08h]
        push byte 0
        add eax, eax
        push eax
        push str_StatthingyFlg
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push ebx
        push str_StatthingyCol
        mov dword [StatTableColumns], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        mov dword [byte esi+022h], 0
        push edi
        mov dword [byte esi+01Eh], 0
        push str_StatthingySort
        mov dword [byte esi+0Eh], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push edi
        push str_StatthingyNames
        mov dword [byte esi+01Ah], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push edi
        push str_StatthingyAlpha
        mov dword [StatTableAlpha], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        push edi
        push str_StatthingyStringsort
        mov dword [StatTableSortText], eax
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [StatTableSortKeys], eax
        mov eax, ebx
        push byte 0
        shl eax, 2
        push eax
        push str_StatthingyColNames
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte esi+027h], eax
        mov eax, dword [byte ebp+01Ch]
        mov dword [byte esi+02Bh], eax
        mov eax, dword [byte ebp+020h]
        mov dword [byte esi+02Fh], eax
        mov eax, dword [byte ebp+02Ch]
        mov dword [byte esi+033h], eax
        mov eax, dword [byte ebp+024h]
        mov dword [byte esi+037h], eax
        mov eax, dword [byte ebp+028h]
        mov dword [byte esi+03Bh], eax
        movzx eax, byte [byte ebp-04h]
        mov edx, dword [byte ebp+02Ch]
        mov dword [byte ebp-020h], eax
        inc eax
        inc eax
        imul edx, eax
        push byte 0
        mov dword [byte ebp-01Ch], edx
        lea eax, [byte edx+0Eh]
        push eax
        movzx eax, byte [byte ebp+010h]
        mov dword [byte ebp-018h], eax
        imul eax, dword [byte ebp+028h]
        mov dword [byte ebp-010h], eax
        mov eax, dword [byte ebp+024h]
        add eax, dword [byte ebp-010h]
        mov dword [byte ebp-014h], eax
        add eax, byte 22h
        mov dword [dword esi+023Fh], 0
        push eax
        mov dword [dword esi+0243h], 0
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [dword esi+0247h], eax
        mov eax, dword [byte ebp+030h]
        push dword [dword esi+0247h]
        mov dword [dword esi+024Bh], eax
        call SetDrawTarget
        mov eax, dword [byte ebp+030h]
        movsx eax, word [byte eax+0Eh]
        add esp, byte 4
        sub eax, dword [byte ebp+020h]
        push eax
        mov eax, dword [byte ebp+030h]
        movsx eax, word [byte eax+0Ch]
        sub eax, dword [byte ebp+01Ch]
        push eax
        push dword [byte ebp+030h]
        call BlitClippedY
        add esp, byte 0Ch
        push dword [byte ebp+020h]
        push dword [byte ebp+01Ch]
        push dword [byte ebp-010h]
        push dword [byte ebp-01Ch]
        mov eax, dword [dword esi+0247h]
        push dword [byte ebp+024h]
        mov edx, dword [byte ebp-020h]
        push dword [byte eax+02Ch]
        mov eax, dword [byte ebp-018h]
        inc edx
        inc eax
        imul edx, eax
        mov dword [byte ebp-010h], edx
        imul edx, byte 52h
        mov ecx, dword [byte ebp-018h]
        push byte 0
        lea eax, [byte esi+03Fh]
        add edx, dword [byte ebp+014h]
        call InitScrollTable
        mov eax, dword [byte ebp-020h]
        imul eax, dword [byte ebp+02Ch]
        push dword [byte ebp+020h]
        push dword [byte ebp+01Ch]
        push eax
        mov eax, dword [byte ebp-014h]
        push dword [byte ebp+02Ch]
        add eax, byte 14h
        push eax
        mov eax, dword [dword esi+0247h]
        push dword [byte eax+02Ch]
        mov eax, dword [byte ebp-010h]
        add eax, byte 3
        imul eax, byte 52h
        mov edx, dword [byte ebp+014h]
        mov ecx, dword [byte ebp-020h]
        mov ebx, dword [byte ebp-08h]
        push byte 0
        add edx, eax
        lea eax, [dword esi+013Fh]
        call InitScrollList
        push byte 0
        push edi
        push str_StatthingySort2
        call AllocMemBlock
        xor edi, edi
        add esp, byte 0Ch
        mov dword [StatTableRows], eax
        jmp short .2
.1:
        mov eax, edi
        mov edx, dword [byte esi+01Ah]
        mov dword [edx+eax*4], edi
        inc edi
.2:
        cmp edi, dword [byte ebp-08h]
        jl short .1
        xor edi, edi
        xor esi, esi
        jmp short .8
.3:
        mov dword [byte ebp-0Ch], 0
        jmp short .7
.4:
        mov ebx, dword [byte ebp+02Ch]
        imul ebx, edi
        mov eax, esi
        shl eax, 6
        add eax, dword [byte ebp+018h]
        add ebx, dword [byte ebp+020h]
        cmp dword [byte ebp-0Ch], byte 0
        jne short .5
        push dword [byte ebp+02Ch]
        mov ecx, dword [byte ebp+024h]
        mov edx, dword [byte ebp+01Ch]
        jmp short .6
.5:
        mov edx, dword [byte ebp-0Ch]
        dec edx
        imul edx, dword [byte ebp+028h]
        mov ecx, dword [byte ebp+01Ch]
        add ecx, dword [byte ebp+024h]
        push dword [byte ebp+02Ch]
        add edx, ecx
        mov ecx, dword [byte ebp+028h]
.6:
        call SetRegionRect
        imul ebx, esi, byte 52h
        inc dword [byte ebp-0Ch]
        mov eax, esi
        add ebx, dword [byte ebp+014h]
        shl eax, 6
        mov dword [byte ebx+010h], 4
        add eax, dword [byte ebp+018h]
        inc esi
        mov dword [byte ebx+014h], eax
.7:
        movzx eax, byte [byte ebp+010h]
        inc eax
        cmp eax, dword [byte ebp-0Ch]
        jg short .4
        inc edi
.8:
        movzx eax, byte [byte ebp-04h]
        inc eax
        cmp edi, eax
        jl short .3
AllocStatTable_2AA:
        leave
        pop edi
        pop esi
        ret 24h
;-----------------------------------------------------------------------------
; FreeStatTable                                   ACA49  97 PC, low confidence
; Frees a stat table and its bitmap
;-----------------------------------------------------------------------------
FreeStatTable:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        push dword [byte eax+012h]
        call FreeMemBlock
        add esp, byte 4
        push dword [StatTableColumns]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebx+0Eh]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebx+01Ah]
        call FreeMemBlock
        add esp, byte 4
        push dword [StatTableAlpha]
        call FreeMemBlock
        add esp, byte 4
        push dword [StatTableSortText]
        call FreeMemBlock
        add esp, byte 4
        push dword [byte ebx+027h]
        call FreeMemBlock
        add esp, byte 4
        push dword [dword ebx+0247h]
        call FreeBitmap
        add esp, byte 4
        lea eax, [byte ebx+03Fh]
        call FreeScrollList
        lea eax, [dword ebx+013Fh]
        call FreeScrollList
        push dword [StatTableRows]
        call FreeMemBlock
        add esp, byte 4
        push dword [StatTableSortKeys]
        call FreeMemBlock
        add esp, byte 4
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; SetStatCell                                     ACAE5  97 PC, low confidence
; Sets a cell of a stat table
;-----------------------------------------------------------------------------
SetStatCell:
        imul edx, dword [byte eax+08h]
        mov eax, dword [byte eax+012h]
        add ebx, edx
        mov dword [eax+ebx*4], ecx
        ret
;-----------------------------------------------------------------------------
; SetStatCellFlag                                 ACAF2  97 PC, low confidence
; Sets the flag byte of a stat table cell
;-----------------------------------------------------------------------------
SetStatCellFlag:
        push esi
        enter 4, 0
        mov byte [byte ebp-04h], bl
        mov esi, ecx
        mov ebx, dword [byte eax+0Eh]
        mov cl, byte [byte ebp-04h]
        mov byte [edx+ebx], cl
        mov eax, dword [byte eax+027h]
        mov dword [eax+edx*4], esi
        leave
        pop esi
        ret
;-----------------------------------------------------------------------------
; SetStatColumn                                   ACB0E  97 PC, low confidence
; Sets a column of the stat table
;-----------------------------------------------------------------------------
SetStatColumn:
        mov eax, dword [StatTableAlpha]
        mov dword [eax+edx*4], ebx
        mov eax, dword [StatTableSortText]
        add ebx, ecx
        mov dword [eax+edx*4], ebx
        ret
;-----------------------------------------------------------------------------
; SetStatRowWidth                                 ACB21  97 PC, low confidence
; Sets the width of a stat table row
;-----------------------------------------------------------------------------
SetStatRowWidth:
        mov eax, dword [StatTableColumns]
        mov word [eax+edx*2], bx
        ret
;-----------------------------------------------------------------------------
; SortStatTableBy                                 ACB2B  97 PC, low confidence
; Sorts a stat table by a column
;-----------------------------------------------------------------------------
SortStatTableBy:
        push ebx
        push ecx
        push esi
        mov esi, eax
        mov word [StatTableSortColumn], dx
        mov eax, dword [byte eax+01Eh]
        push byte 0
        sub eax, dword [dword esi+0243h]
        xor ecx, ecx
        lea edx, [byte eax+01h]
        xor ebx, ebx
        mov eax, esi
        call SortStatTable
        mov dword [byte esi+04h], 0
        xor eax, eax
        jmp short .3
.1:
        mov ebx, dword [StatTableColumns]
        mov edx, eax
        movsx ebx, word [ebx+edx*2]
        movsx edx, word [StatTableSortColumn]
        and ebx, edx
        cmp ebx, edx
        jne short .2
        inc dword [byte esi+04h]
.2:
        inc eax
.3:
        cmp eax, dword [esi]
        jl short .1
        lea eax, [dword esi+013Fh]
        mov edx, dword [byte esi+04h]
        call SetListSelection
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CompareStatNumber                               ACB8E  97 PC, low confidence
; Sort helper: compares two stat cells as numbers
;-----------------------------------------------------------------------------
CompareStatNumber:
        push ebx
        enter 18h, 0
        lea ebx, [byte ebp-010h]
        push ebx
        lea ebx, [byte ebp-0Ch]
        push ebx
        lea ebx, [byte ebp-08h]
        push ebx
        push str_DDD4
        mov ebx, dword [eax]
        mov eax, dword [StatTableSortKeys]
        push dword [eax+ebx*4]
        call sscanf_
        add esp, byte 14h
        lea eax, [byte ebp-04h]
        push eax
        lea eax, [byte ebp-018h]
        push eax
        lea eax, [byte ebp-014h]
        push eax
        push str_DDD4
        mov eax, dword [edx]
        mov edx, dword [StatTableSortKeys]
        push dword [edx+eax*4]
        call sscanf_
        mov eax, dword [byte ebp-08h]
        mov edx, dword [byte ebp-010h]
        add eax, eax
        add edx, eax
        mov eax, dword [byte ebp-014h]
        add eax, eax
        add eax, dword [byte ebp-04h]
        movsx ebx, ax
        movsx eax, dx
        sub ebx, eax
        add esp, byte 14h
        mov eax, ebx
        leave
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CompareStatText                                 ACBF9  97 PC, low confidence
; Sort helper: compares two stat cells as text
;-----------------------------------------------------------------------------
CompareStatText:
        push ebx
        push ecx
        push esi
        mov ecx, dword [StatTableColumns]
        mov ebx, dword [eax]
        movsx ecx, word [ecx+ebx*2]
        movsx ebx, word [StatTableSortColumn]
        and ecx, ebx
        cmp ecx, ebx
        sete bl
        mov esi, dword [edx]
        mov cl, bl
        mov ebx, dword [StatTableColumns]
        movsx esi, word [ebx+esi*2]
        movsx ebx, word [StatTableSortColumn]
        and esi, ebx
        cmp esi, ebx
        sete bl
        cmp cl, bl
        je short .1
        movzx edx, cl
        movzx eax, bl
        sub eax, edx
        pop esi
        pop ecx
        pop ebx
        ret
.1:
        mov ebx, dword [StatTableRows]
        mov esi, dword [edx]
        mov ecx, dword [eax]
        shl esi, 2
        shl ecx, 2
        lea edx, [ebx+esi]
        lea eax, [ebx+ecx]
        mov ebx, dword [edx]
        cmp ebx, dword [eax]
        je short .2
        mov edx, ebx
        sub edx, dword [eax]
        mov eax, edx
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        mov edx, dword [StatTableSortText]
        mov ebx, dword [edx+esi]
        mov eax, dword [ecx+edx]
        mov edx, ebx
        call strcmp_
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CompareStatTextDown                             ACC7F  97 PC, low confidence
; Sort helper: compares two stat cells as text, descending
;-----------------------------------------------------------------------------
CompareStatTextDown:
        push ebx
        push ecx
        push esi
        mov ecx, dword [StatTableColumns]
        mov ebx, dword [eax]
        movsx ecx, word [ecx+ebx*2]
        movsx ebx, word [StatTableSortColumn]
        and ecx, ebx
        cmp ecx, ebx
        sete bl
        mov esi, dword [edx]
        mov cl, bl
        mov ebx, dword [StatTableColumns]
        movsx esi, word [ebx+esi*2]
        movsx ebx, word [StatTableSortColumn]
        and esi, ebx
        cmp esi, ebx
        sete bl
        cmp cl, bl
        je short .1
        movzx edx, bl
        movzx eax, cl
        sub eax, edx
        pop esi
        pop ecx
        pop ebx
        ret
.1:
        mov ebx, dword [StatTableRows]
        mov esi, dword [edx]
        mov ecx, dword [eax]
        shl esi, 2
        shl ecx, 2
        lea edx, [ebx+esi]
        lea eax, [ebx+ecx]
        mov ebx, dword [edx]
        cmp ebx, dword [eax]
        je short .2
        mov eax, dword [eax]
        sub eax, ebx
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        mov edx, dword [StatTableSortText]
        mov ebx, dword [ecx+edx]
        mov eax, dword [edx+esi]
        mov edx, ebx
        call strcmp_
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CompareStatName                                 ACD03  97 PC, low confidence
; Sort helper: compares two stat cells by name
;-----------------------------------------------------------------------------
CompareStatName:
        push ebx
        push ecx
        push esi
        mov ecx, eax
        mov ebx, edx
        mov edx, dword [eax]
        mov eax, dword [StatTableColumns]
        movsx edx, word [eax+edx*2]
        movsx eax, word [StatTableSortColumn]
        and edx, eax
        cmp edx, eax
        sete al
        mov esi, dword [ebx]
        mov dl, al
        mov eax, dword [StatTableColumns]
        movsx esi, word [eax+esi*2]
        movsx eax, word [StatTableSortColumn]
        and esi, eax
        cmp esi, eax
        sete al
        cmp dl, al
        je short .1
        movzx ebx, al
        movzx eax, dl
        sub ebx, eax
        mov eax, ebx
        pop esi
        pop ecx
        pop ebx
        ret
.1:
        mov esi, dword [StatTableSortKeys]
        mov eax, dword [ebx]
        mov edx, dword [esi+eax*4]
        mov eax, dword [ecx]
        mov eax, dword [esi+eax*4]
        call strcmp_
        test eax, eax
        je short .2
        mov edx, dword [StatTableSortKeys]
        mov eax, dword [ebx]
        mov ebx, dword [edx+eax*4]
        mov eax, dword [ecx]
        mov eax, dword [edx+eax*4]
        mov edx, ebx
        jmp short .3
.2:
        mov eax, dword [ebx]
        mov ebx, dword [StatTableSortText]
        mov edx, dword [ebx+eax*4]
        mov eax, dword [ecx]
        mov eax, dword [ebx+eax*4]
.3:
        call strcmp_
        pop esi
        pop ecx
        pop ebx
        ret
SortStatTableJumpTable:                         ; jump table for the switch cases of SortStatTable
        dd SortStatTable_301
        dd SortStatTable_310
        dd SortStatTable_321
        dd SortStatTable_303
        dd SortStatTable_36B
        dd SortStatTable_323
;-----------------------------------------------------------------------------
; SortStatTable                                   ACDAE  97 PC, low confidence
; Sorts a stat table and resets its scroll
;-----------------------------------------------------------------------------
SortStatTable:
        push esi
        push edi
        enter 14h, 0
        mov esi, eax
        mov edi, edx
        mov dword [byte ebp-010h], ebx
        mov dword [byte ebp-08h], ecx
        mov ecx, dword [byte ebp+010h]
        movzx ebx, byte [byte eax+0Dh]
        movzx eax, byte [byte eax+0Ch]
        inc ebx
        inc eax
        mov edx, ebx
        imul edx, eax
        cmp edi, edx
        jge near .39
        mov eax, edi
        cdq
        idiv ebx
        mov eax, edi
        mov dword [byte ebp-04h], edx
        cdq
        idiv ebx
        mov edi, eax
        cmp dword [byte ebp-04h], byte 0
        je short .1
        mov edx, dword [byte ebp-04h]
        mov eax, dword [dword esi+0243h]
        dec edx
        add edx, eax
        mov dword [byte esi+01Eh], edx
.1:
        test edi, edi
        je short .2
        mov eax, dword [byte esi+04h]
        sub eax, dword [dword esi+023Fh]
        cmp edi, eax
        jg short .2
        lea edx, [byte edi-01h]
        mov eax, dword [dword esi+023Fh]
        add edx, eax
        mov dword [byte esi+022h], edx
.2:
        mov eax, dword [byte esi+0Eh]
        add eax, dword [byte esi+01Eh]
        mov al, byte [eax]
        cmp al, 8
        jb short .4
        jbe near .20
        cmp al, 0Bh
        jb short .3
        jbe short .6
        cmp al, 0Ch
        jbe near .20
        cmp al, 0Dh
        je near .14
        jmp near .23
.3:
        cmp al, 9
        jbe short .6
        jmp short .9
.4:
        cmp al, 4
        jb short .5
        jbe short .6
        cmp al, 5
        jbe near .17
        jmp short .6
.5:
        cmp al, 1
        jb near .23
        cmp al, 2
        ja near .23
.6:
        xor eax, eax
        jmp short .8
.7:
        mov edx, dword [byte esi+08h]
        imul edx, eax
        mov ebx, dword [byte esi+012h]
        add edx, dword [byte esi+01Eh]
        mov edx, dword [ebx+edx*4]
        movsx edx, word [edx]
        mov dword [byte ebp-014h], edx
        mov edx, eax
        mov ebx, dword [StatTableRows]
        shl edx, 2
        add edx, ebx
        mov ebx, dword [byte ebp-014h]
        inc eax
        mov dword [edx], ebx
.8:
        cmp eax, dword [esi]
        jl short .7
        jmp near .23
.9:
        xor eax, eax
        jmp short .13
.10:
        mov ebx, dword [byte esi+08h]
        imul ebx, eax
        add ebx, dword [byte esi+01Eh]
        mov edx, dword [byte esi+012h]
        shl ebx, 2
        mov edx, dword [edx+ebx]
        mov ebx, eax
        movsx edx, word [edx]
        shl ebx, 2
        cmp edx, byte 0FFFFFFFFh
        je short .11
        mov ecx, edx
        mov edx, dword [StatTableRows]
        neg ecx
        mov dword [edx+ebx], ecx
        jmp short .12
.11:
        mov edx, dword [StatTableRows]
        mov dword [edx+ebx], 0FFFFD8F1h
.12:
        inc eax
.13:
        cmp eax, dword [esi]
        jl short .10
        jmp near .23
.14:
        xor eax, eax
        jmp short .16
.15:
        mov edx, dword [byte esi+08h]
        imul edx, eax
        mov ebx, dword [byte esi+012h]
        add edx, dword [byte esi+01Eh]
        mov edx, dword [ebx+edx*4]
        mov ebx, eax
        shl ebx, 2
        mov dword [byte ebp-014h], ebx
        mov ebx, dword [StatTableRows]
        add ebx, dword [byte ebp-014h]
        mov edx, dword [edx]
        inc eax
        mov dword [ebx], edx
.16:
        cmp eax, dword [esi]
        jl short .15
        jmp short .23
.17:
        xor eax, eax
        jmp short .19
.18:
        mov edx, dword [byte esi+08h]
        imul edx, eax
        mov ebx, dword [byte esi+012h]
        add edx, dword [byte esi+01Eh]
        mov edx, dword [ebx+edx*4]
        movzx edx, byte [edx]
        mov dword [byte ebp-014h], edx
        mov edx, eax
        mov ebx, dword [StatTableRows]
        shl edx, 2
        add edx, ebx
        mov ebx, dword [byte ebp-014h]
        inc eax
        mov dword [edx], ebx
.19:
        cmp eax, dword [esi]
        jl short .18
        jmp short .23
.20:
        xor eax, eax
        jmp short .22
.21:
        mov edx, dword [byte esi+08h]
        imul edx, eax
        add edx, dword [byte esi+01Eh]
        mov ebx, dword [byte esi+012h]
        shl edx, 2
        add ebx, edx
        mov edx, eax
        shl edx, 2
        mov dword [byte ebp-014h], edx
        mov edx, dword [StatTableSortKeys]
        add edx, dword [byte ebp-014h]
        mov ebx, dword [ebx]
        inc eax
        mov dword [edx], ebx
.22:
        cmp eax, dword [esi]
        jl short .21
.23:
        mov eax, dword [byte esi+01Ah]
        mov edx, dword [byte esi+022h]
        mov eax, dword [eax+edx*4]
        mov dword [byte ebp-0Ch], eax
        test edi, edi
        jne short .26
        cmp dword [byte ebp-04h], byte 0
        jne short .26
        xor eax, eax
        jmp short .25
.24:
        mov ebx, dword [StatTableRows]
        mov edx, eax
        inc eax
        mov dword [ebx+edx*4], 0
.25:
        cmp eax, dword [esi]
        jl short .24
        mov dword [byte esi+01Eh], 0FFFFFFFFh
.26:
        mov eax, dword [byte esi+0Eh]
        add eax, dword [byte esi+01Eh]
        cmp byte [eax], 8
        jne short .27
        mov ecx, CompareStatName
        jmp short .31
.27:
        cmp byte [eax], 0Ch
        jne short .28
        mov ecx, CompareStatNumber
        jmp short .31
.28:
        cmp byte [eax], 0Bh
        je short .29
        cmp byte [eax], 2
        jne short .30
.29:
        mov ecx, CompareStatTextDown
        jmp short .31
.30:
        mov ecx, CompareStatText
.31:
        mov ebx, 4
        mov edx, dword [esi]
        mov eax, dword [byte esi+01Ah]
        call qsort_
        test edi, edi
        jne short .32
        cmp dword [byte ebp-04h], byte 0
        je short .32
        mov eax, dword [byte esi+01Ah]
        mov eax, dword [eax]
        mov dword [byte ebp-0Ch], eax
.32:
        xor eax, eax
        jmp short .35
.33:
        mov edx, eax
        mov ebx, dword [byte esi+01Ah]
        mov edx, dword [ebx+edx*4]
        cmp edx, dword [byte ebp-0Ch]
        jne short .34
        mov dword [byte esi+022h], eax
        jmp short .36
.34:
        inc eax
.35:
        cmp eax, dword [esi]
        jl short .33
.36:
        mov eax, dword [byte esi+022h]
        cmp eax, dword [dword esi+023Fh]
        jge short .37
        sub eax, byte 3
        mov dword [dword esi+023Fh], eax
        test eax, eax
        jge short .38
        mov dword [dword esi+023Fh], 0
        jmp short .38
.37:
        mov edx, dword [dword esi+023Fh]
        movzx eax, byte [byte esi+0Ch]
        add edx, eax
        cmp edx, dword [byte esi+022h]
        jge short .38
        mov edx, dword [byte esi+022h]
        sub edx, eax
        lea eax, [byte edx+03h]
        mov dword [dword esi+023Fh], eax
        mov edx, dword [esi]
        movzx eax, byte [byte esi+0Ch]
        sub edx, eax
        mov eax, edx
        cmp edx, dword [dword esi+023Fh]
        jge short .38
        mov dword [dword esi+023Fh], edx
.38:
        lea eax, [dword esi+013Fh]
        mov ebx, dword [dword esi+0247h]
        mov edx, dword [dword esi+023Fh]
        call SetScrollBarPos
        jmp short SortStatTable_323.42
.39:
        sub edi, edx
        mov edx, edi
        cmp edi, byte 5
        ja short SortStatTable_323.41
        lea edi, [byte esi+03Fh]
        lea eax, [dword esi+013Fh]
        jmp dword [nosplit cs:edx*4+SortStatTableJumpTable]
SortStatTable_301:
        mov eax, edi
SortStatTable_303:
        mov edx, dword [dword esi+0247h]
        call ScrollUp
        jmp short SortStatTable_323.41
SortStatTable_310:
        mov ebx, ecx
        mov eax, edi
.40:
        mov edx, dword [dword esi+0247h]
        call ScrollToMouse
        jmp short SortStatTable_323.41
SortStatTable_321:
        mov eax, edi
SortStatTable_323:
        mov edx, dword [dword esi+0247h]
        call ScrollDown
.41:
        mov eax, dword [dword esi+0163h]
        mov dword [dword esi+023Fh], eax
        mov eax, dword [byte esi+063h]
        mov dword [dword esi+0243h], eax
.42:
        cmp dword [byte ebp-010h], byte 0
        je short .43
        mov eax, dword [byte esi+01Ah]
        mov edx, dword [byte esi+022h]
        mov eax, dword [eax+edx*4]
        mov edx, dword [byte ebp-010h]
        mov dword [edx], eax
.43:
        cmp dword [byte ebp-08h], byte 0
        je short .44
        mov edx, dword [byte ebp-08h]
        mov eax, dword [byte esi+01Eh]
        mov dword [edx], eax
.44:
        leave
        pop edi
        pop esi
        ret 4
SortStatTable_36B:
        mov ebx, ecx
        jmp short SortStatTable_310.40
DrawStatTableRowsJumpTable:                     ; jump table for the switch cases of DrawStatTableRows
        dd DrawStatTableRows_2A9
        dd DrawStatTableRows_2A9
        dd DrawStatTableRows_2ED
        dd DrawStatTableRows_2C4
        dd DrawStatTableRows_470
        dd DrawStatTableRows_435
        dd DrawStatTableRows_3FD
        dd DrawStatTableRows_48D
        dd DrawStatTableRows_3D1
        dd DrawStatTableRows_36C
        dd DrawStatTableRows_2C4
        dd DrawStatTableRows_48D
        dd DrawStatTableRows_34B
;-----------------------------------------------------------------------------
; DrawStatTableRows                               AD151  97 PC, low confidence
; Draws the rows of a stat table
;-----------------------------------------------------------------------------
DrawStatTableRows:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 74h, 0
        mov esi, eax
        push dword [dword eax+0247h]
        call SetDrawTarget
        mov eax, dword [dword esi+024Bh]
        movsx edx, word [byte eax+0Eh]
        add esp, byte 4
        sub edx, dword [byte esi+02Fh]
        push edx
        movsx edx, word [byte eax+0Ch]
        sub edx, dword [byte esi+02Bh]
        push edx
        push eax
        call BlitArt
        add esp, byte 0Ch
        lea eax, [byte esi+03Fh]
        mov edx, dword [dword esi+0247h]
        call DrawScrollBar
        lea eax, [dword esi+013Fh]
        mov edx, dword [dword esi+0247h]
        call DrawScrollBar
        mov eax, dword [byte esi+033h]
        mov dword [byte ebp-08h], eax
        mov eax, dword [byte esi+01Eh]
        mov dword [byte ebp-0Ch], 0
        cmp eax, dword [dword esi+0243h]
        jl near .3
        movzx eax, byte [byte esi+0Dh]
        add eax, dword [dword esi+0243h]
        cmp eax, dword [byte esi+01Eh]
        jle near .3
        movzx eax, byte [byte esi+0Ch]
        cmp eax, dword [byte esi+04h]
        jg short .1
        inc eax
        imul eax, dword [byte ebp-08h]
        push eax
        mov eax, dword [byte esi+01Eh]
        mov edx, dword [byte esi+03Bh]
        sub eax, dword [dword esi+0243h]
        imul edx, eax
        mov eax, dword [byte esi+03Bh]
        mov edi, dword [byte esi+037h]
        add eax, dword [byte esi+037h]
        push dword 800000h
        lea ebx, [eax+edx]
        add edi, edx
        call MakeColor
        add esp, byte 4
        mov ecx, ebx
        mov edx, edi
        xor ebx, ebx
        jmp short .2
.1:
        mov eax, dword [byte esi+04h]
        inc eax
        imul eax, dword [byte ebp-08h]
        push eax
        mov eax, dword [byte esi+01Eh]
        mov ebx, dword [byte esi+03Bh]
        sub eax, dword [dword esi+0243h]
        imul ebx, eax
        mov eax, dword [byte esi+03Bh]
        add eax, dword [byte esi+037h]
        lea edi, [eax+ebx]
        mov eax, dword [byte esi+037h]
        add eax, ebx
        push dword 800000h
        mov dword [byte ebp-04h], eax
        call MakeColor
        xor ebx, ebx
        add esp, byte 4
        mov edx, dword [byte ebp-04h]
        mov ecx, edi
.2:
        call DrawListHighlight
.3:
        mov eax, dword [byte esi+022h]
        cmp eax, dword [dword esi+023Fh]
        jl short .4
        movzx eax, byte [byte esi+0Ch]
        add eax, dword [dword esi+023Fh]
        cmp eax, dword [byte esi+022h]
        jle short .4
        mov eax, dword [byte esi+022h]
        sub eax, dword [dword esi+023Fh]
        lea edx, [byte eax+02h]
        imul edx, dword [byte esi+033h]
        mov edi, dword [byte esi+033h]
        inc eax
        imul edi, eax
        push edx
        movzx edx, byte [byte esi+0Dh]
        imul edx, dword [byte esi+03Bh]
        mov ebx, dword [byte esi+037h]
        push dword 800000h
        add ebx, edx
        call MakeColor
        add esp, byte 4
        mov ecx, ebx
        xor edx, edx
        mov ebx, edi
        call DrawListHighlight
.4:
        mov edi, dword [dword esi+023Fh]
        jmp near DrawStatTableRows_2ED.20
.5:
        cmp edi, dword [byte esi+04h]
        jge near DrawStatTableRows_2ED.19
        mov eax, edi
        mov edx, dword [byte esi+01Ah]
        mov ebx, dword [edx+eax*4]
        mov eax, dword [StatTableAlpha]
        shl ebx, 2
        add eax, ebx
        mov edx, dword [StatTableSortText]
        mov ecx, dword [eax]
        add ebx, edx
        lea edx, [byte edi+01h]
        cmp ecx, dword [ebx]
        jne short .6
        push ecx
        push edx
        push str_DS3
        lea eax, [byte ebp-074h]
        push eax
        call sprintf_
        add esp, byte 10h
        lea eax, [byte ebp-074h]
        push eax
        push dword [byte ebp-08h]
        push byte 0
        jmp near .12
.6:
        push edx
        push str_D
        lea eax, [byte ebp-074h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte ebp-074h]
        push eax
        push dword [byte ebp-08h]
        push byte 0
        push byte 0
        mov dword [byte ebp-010h], 14h
        xor ebx, ebx
        call DrawTextAligned
        add esp, byte 10h
        jmp short .10
.7:
        mov eax, dword [eax]
        mov edx, dword [byte ebp-0Ch]
        mov al, byte [ebx+eax]
        mov byte [byte edx+ebp-074h], al
        cmp al, 20h
        jne short .8
        lea eax, [byte ebp-074h]
        push eax
        mov eax, dword [byte ebp-010h]
        push dword [byte ebp-08h]
        add eax, byte 0Fh
        push eax
        mov dword [byte ebp-0Ch], 0
        push byte 1
        mov byte [byte edx+ebp-074h], 0
        add dword [byte ebp-010h], byte 1Eh
        call DrawTextAligned
        add esp, byte 10h
        jmp short .9
.8:
        inc dword [byte ebp-0Ch]
.9:
        inc ebx
.10:
        mov eax, edi
        mov edx, dword [byte esi+01Ah]
        mov eax, dword [edx+eax*4]
        mov ecx, dword [StatTableSortText]
        shl eax, 2
        mov edx, dword [StatTableAlpha]
        add ecx, eax
        add eax, edx
        mov ecx, dword [ecx]
        sub ecx, dword [eax]
        cmp ebx, ecx
        jl short .7
        test ecx, ecx
        je short .11
        add dword [byte ebp-010h], byte 0Ah
.11:
        mov eax, edi
        mov edx, dword [byte esi+01Ah]
        mov edx, dword [edx+eax*4]
        mov eax, dword [StatTableSortText]
        push dword [eax+edx*4]
        push dword [byte ebp-08h]
        push dword [byte ebp-010h]
.12:
        push byte 0
        call DrawTextAligned
        add esp, byte 10h
        mov eax, dword [byte esi+03Bh]
        mov edx, dword [byte esi+037h]
        sar eax, 1
        add edx, eax
        mov ebx, dword [dword esi+0243h]
        mov dword [byte ebp-010h], edx
        jmp near DrawStatTableRows_2ED.18
.13:
        mov eax, dword [byte esi+0Eh]
        mov al, byte [ebx+eax]
        dec al
        cmp al, 0Ch
        ja near DrawStatTableRows_2ED
        movzx ecx, al
        mov eax, edi
        shl eax, 2
        jmp dword [nosplit cs:ecx*4+DrawStatTableRowsJumpTable]
DrawStatTableRows_2A9:
        mov eax, edi
        mov edx, dword [byte esi+01Ah]
        mov edx, dword [edx+eax*4]
        imul edx, dword [byte esi+08h]
        add edx, ebx
        mov eax, dword [byte esi+012h]
        shl edx, 2
        mov eax, dword [edx+eax]
        push dword [eax]
        jmp short DrawStatTableRows_2C4.16
DrawStatTableRows_2C4:
        mov eax, edi
        mov edx, dword [byte esi+01Ah]
        mov eax, dword [edx+eax*4]
        imul eax, dword [byte esi+08h]
        mov edx, dword [byte esi+012h]
        add eax, ebx
        mov eax, dword [edx+eax*4]
.14:
        movsx eax, word [eax]
.15:
        push eax
.16:
        push str_D_ExportStatTable
.17:
        lea eax, [byte ebp-074h]
        push eax
        call sprintf_
        add esp, byte 0Ch
DrawStatTableRows_2ED:
        lea eax, [byte ebp-074h]
        push eax
        push dword [byte ebp-08h]
        push dword [byte ebp-010h]
        push byte 1
        inc ebx
        call DrawTextAligned
        mov eax, dword [byte esi+03Bh]
        add esp, byte 10h
        add dword [byte ebp-010h], eax
.18:
        movzx eax, byte [byte esi+0Dh]
        add eax, dword [dword esi+0243h]
        cmp ebx, eax
        jl near DrawStatTableRows.13
        mov eax, dword [byte esi+033h]
        add dword [byte ebp-08h], eax
.19:
        inc edi
.20:
        movzx eax, byte [byte esi+0Ch]
        add eax, dword [dword esi+023Fh]
        cmp edi, eax
        jl near DrawStatTableRows.5
        mov eax, dword [byte esi+03Bh]
        mov edx, dword [byte esi+037h]
        sar eax, 1
        add edx, eax
        mov edi, dword [dword esi+0243h]
        mov dword [byte ebp-010h], edx
        jmp near DrawStatTableRows_48D.25
DrawStatTableRows_34B:
        mov edx, dword [byte esi+01Ah]
        mov eax, dword [edx+eax]
        imul eax, dword [byte esi+08h]
        mov edx, dword [byte esi+012h]
        add eax, ebx
        mov eax, dword [edx+eax*4]
        mov eax, dword [eax]
        mov ecx, 3Ch
        cdq
        idiv ecx
        jmp near DrawStatTableRows_2C4.15
DrawStatTableRows_36C:
        mov edx, dword [byte esi+01Ah]
        mov edx, dword [edx+eax]
        imul edx, dword [byte esi+08h]
        add edx, ebx
        mov eax, dword [byte esi+012h]
        shl edx, 2
        mov ecx, dword [edx+eax]
        movsx ecx, word [ecx]
        cmp ecx, byte 0FFFFFFFFh
        jne short .22
        push str_NA
.21:
        lea eax, [byte ebp-074h]
        push eax
        call sprintf_
        add esp, byte 8
        jmp near DrawStatTableRows_2ED
.22:
        mov eax, ecx
        mov dword [byte ebp-04h], 64h
        cdq
        idiv dword [byte ebp-04h]
        mov dword [byte ebp-04h], 64h
        mov eax, ecx
        push edx
        cdq
        idiv dword [byte ebp-04h]
        push eax
        push str_D02d
.23:
        lea eax, [byte ebp-074h]
        push eax
        call sprintf_
        add esp, byte 10h
        jmp near DrawStatTableRows_2ED
DrawStatTableRows_3D1:
        mov edx, dword [byte esi+01Ah]
        mov edx, dword [edx+eax]
        imul edx, dword [byte esi+08h]
        add edx, ebx
        mov eax, dword [byte esi+012h]
        shl edx, 2
        mov eax, dword [edx+eax]
        cmp word [eax], byte 0
        jne near DrawStatTableRows_2C4.14
        mov eax, 1AEh
        call GetLangText
        push eax
        jmp short DrawStatTableRows_36C.21
DrawStatTableRows_3FD:
        mov edx, dword [byte esi+01Ah]
        mov eax, dword [edx+eax]
        imul eax, dword [byte esi+08h]
        mov ecx, dword [byte esi+012h]
        add eax, ebx
        mov ecx, dword [ecx+eax*4]
        movsx ecx, word [ecx]
        mov eax, ecx
        mov dword [byte ebp-04h], 0Ch
        cdq
        idiv dword [byte ebp-04h]
        mov dword [byte ebp-04h], 0Ch
        mov eax, ecx
        push edx
        cdq
        idiv dword [byte ebp-04h]
        push eax
        push str_DD2
        jmp short DrawStatTableRows_36C.23
DrawStatTableRows_435:
        mov edx, dword [byte esi+01Ah]
        mov eax, dword [edx+eax]
        imul eax, dword [byte esi+08h]
        mov edx, dword [byte esi+012h]
        add eax, ebx
        mov ecx, dword [edx+eax*4]
        movsx ecx, word [ecx]
        mov eax, ecx
        mov dword [byte ebp-04h], 0Ah
        cdq
        idiv dword [byte ebp-04h]
        mov dword [byte ebp-04h], 0Ah
        mov eax, ecx
        push edx
        cdq
        idiv dword [byte ebp-04h]
        push eax
        push str_D01d2
        jmp near DrawStatTableRows_36C.23
DrawStatTableRows_470:
        mov edx, dword [byte esi+01Ah]
        mov edx, dword [edx+eax]
        imul edx, dword [byte esi+08h]
        add edx, ebx
        mov eax, dword [byte esi+012h]
        shl edx, 2
        mov eax, dword [edx+eax]
        movzx eax, byte [eax]
        jmp near DrawStatTableRows_2C4.15
DrawStatTableRows_48D:
        mov eax, edi
        mov edx, dword [byte esi+01Ah]
        mov eax, dword [edx+eax*4]
        imul eax, dword [byte esi+08h]
        mov edx, dword [byte esi+012h]
        add eax, ebx
        push dword [edx+eax*4]
        push str_S_ExportStatTable
        jmp near DrawStatTableRows_2C4.17
.24:
        mov edx, edi
        mov eax, dword [byte esi+027h]
        push dword [eax+edx*4]
        push byte 0
        push dword [byte ebp-010h]
        push byte 1
        inc edi
        call DrawTextAligned
        mov eax, dword [byte esi+03Bh]
        add esp, byte 10h
        add dword [byte ebp-010h], eax
.25:
        movzx eax, byte [byte esi+0Dh]
        add eax, dword [dword esi+0243h]
        cmp edi, eax
        jl short .24
DrawStatTableRows_4D7:
        leave
        jmp near TeamStatsScreen_13C3
;-----------------------------------------------------------------------------
; DrawStatTableArt                                AD62E  97 PC, low confidence
; Draws the art of a stat table
;-----------------------------------------------------------------------------
DrawStatTableArt:
        push ecx
        push edx
        push dword [byte eax+02Fh]
        push dword [byte eax+02Bh]
        mov eax, dword [dword eax+0247h]
        push dword [byte eax+02Ch]
        call BlitArt
        add esp, byte 0Ch
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; WriteCsvField                                   AD64A  97 PC, low confidence
; Writes one field to the export file
;-----------------------------------------------------------------------------
WriteCsvField:
        push ecx
        mov ecx, eax
        push edx
        push eax
        call fprintf_
        add esp, byte 8
        mov eax, edx
        call strlen_
        mov edx, eax
        jmp short .2
.1:
        push str_Punct_WriteCsvLine
        push ecx
        inc edx
        call fprintf_
        add esp, byte 8
.2:
        cmp dx, bx
        jl short .1
        pop ecx
        ret
;-----------------------------------------------------------------------------
; WriteCsvLine                                    AD678  97 PC, low confidence
; Writes one line to the export file
;-----------------------------------------------------------------------------
WriteCsvLine:
        push ecx
        push esi
        push edi
        mov esi, eax
        mov ecx, edx
        mov eax, edx
        movsx edx, bx
        call strlen_
        sub edx, eax
        shr edx, 1
        mov edi, edx
        xor edx, edx
        jmp short .2
.1:
        push str_Punct_WriteCsvLine
        push esi
        inc edx
        call fprintf_
        add esp, byte 8
.2:
        cmp dx, di
        jl short .1
        push ecx
        push esi
        call fprintf_
        add esp, byte 8
        mov eax, ecx
        mov edx, edi
        call strlen_
        add edx, eax
        jmp short .4
.3:
        push str_Punct_WriteCsvLine
        push esi
        inc edx
        call fprintf_
        add esp, byte 8
.4:
        cmp dx, bx
        jl short .3
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; AskExportFile                                   AD6D6  97 PC, low confidence
; Asks for the export file name and opens it
;-----------------------------------------------------------------------------
AskExportFile:
        push ebx
        push ecx
        push esi
        push edi
        enter 4, 0
        mov esi, edx
        mov edi, 0FFFFFFFFh
.1:
        cmp edi, byte 0FFFFFFFFh
        jne near .5
        push byte 0
        mov eax, 104h
        mov ecx, 2
        mov edx, 1Eh
        call GetLangText
        mov ebx, eax
        mov eax, esi
        call EditTextField
        test eax, eax
        je short .4
        mov eax, esi
        call strlen_
        test eax, eax
        jbe short .4
        mov edx, str_Rt
        mov eax, esi
        call fopen_
        mov dword [byte ebp-04h], eax
        test eax, eax
        je short .2
        push byte 1
        mov eax, 226h
        mov ecx, 1
        mov edx, 2
        xor ebx, ebx
        call GetLangText
        call ShowMessageBoxNoWait
        test eax, eax
        je short .3
.2:
        mov edi, 1
.3:
        mov eax, dword [byte ebp-04h]
        call fclose_
        jmp short .1
.4:
        xor edi, edi
        jmp short .1
.5:
        mov eax, edi
        leave
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
ExportStatTableJumpTable:                       ; jump table for the switch cases of ExportStatTable
        dd ExportStatTable_19A
        dd ExportStatTable_19A
        dd ExportStatTable_221
        dd ExportStatTable_1BA
        dd ExportStatTable_36C
        dd ExportStatTable_344
        dd ExportStatTable_304
        dd ExportStatTable_38A
        dd ExportStatTable_2D9
        dd ExportStatTable_26D
        dd ExportStatTable_1BA
        dd ExportStatTable_38A
        dd ExportStatTable_1EB
;-----------------------------------------------------------------------------
; ExportStatTable                                 AD79F  97 PC, low confidence
; Exports a stat table to a text file
;-----------------------------------------------------------------------------
ExportStatTable:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        enter 0E0h, 0
        mov ecx, eax
        xor edx, edx
        jmp short .2
.1:
        movsx eax, dx
        inc edx
        mov byte [byte eax+ebp-02Ch], 0
.2:
        cmp dx, byte 1Fh
        jl short .1
        lea edx, [byte ebp-02Ch]
        mov eax, 1Eh
        call AskExportFile
        test eax, eax
        je near DrawStatTableRows_4D7
        xor edx, edx
        jmp short .4
.3:
        movsx eax, dx
        inc edx
        mov word [dword ebp+eax*2-0E0h], 0
.4:
        cmp dx, byte 32h
        jl short .3
        mov edx, str_Wt
        lea eax, [byte ebp-02Ch]
        call fopen_
        mov esi, eax
        test eax, eax
        jne short .5
        push byte 1
        mov eax, 103h
        mov edx, 1
        xor ecx, ecx
        xor ebx, ebx
        call GetLangText
        call ShowMessageBoxNoWait
        jmp near DrawStatTableRows_4D7
.5:
        xor edx, edx
        jmp short .7
.6:
        mov eax, ebx
        mov edi, dword [byte ecx+027h]
        shl eax, 2
        add eax, edi
        mov eax, dword [eax]
        call strlen_
        add eax, 6
        inc edx
        mov dword [byte ebp-04h], eax
        mov eax, ebx
        mov ebx, dword [byte ebp-04h]
        mov word [dword ebp+eax*2-0E0h], bx
.7:
        movsx ebx, dx
        cmp ebx, dword [byte ecx+08h]
        jl short .6
        push str_Punct_WriteCsvLine
        lea eax, [byte ebp-07Ch]
        push eax
        mov ebx, 23h
        lea edx, [byte ebp-07Ch]
        call sprintf_
        add esp, byte 8
        mov eax, esi
        xor edi, edi
        call WriteCsvField
        jmp short .9
.8:
        mov eax, ebx
        mov edx, dword [byte ecx+027h]
        shl eax, 2
        add eax, edx
        push dword [eax]
        push str_S_ExportStatTable
        lea eax, [byte ebp-07Ch]
        push eax
        lea edx, [byte ebp-07Ch]
        call sprintf_
        add esp, byte 0Ch
        mov eax, esi
        movsx ebx, word [dword ebp+ebx*2-0E0h]
        inc edi
        call WriteCsvLine
.9:
        movsx ebx, di
        cmp ebx, dword [byte ecx+08h]
        jl short .8
        push str_Punct_ExportStatTable
        push esi
        mov dword [byte ebp-08h], 0
        jmp near ExportStatTable_221.16
.10:
        lea eax, [byte edi+01h]
        push eax
        push str_D
        lea eax, [byte ebp-07Ch]
        push eax
        mov ebx, 5
        call sprintf_
        add esp, byte 0Ch
        lea edx, [byte ebp-07Ch]
        mov eax, esi
        call WriteCsvField
        mov eax, edi
        mov edx, dword [byte ecx+01Ah]
        mov eax, dword [edx+eax*4]
        mov edx, dword [StatTableAlpha]
        push dword [edx+eax*4]
        push str_S_ExportStatTable
        lea eax, [byte ebp-07Ch]
        push eax
        mov ebx, 1Eh
        lea edx, [byte ebp-07Ch]
        call sprintf_
        add esp, byte 0Ch
        mov eax, esi
        xor edi, edi
        call WriteCsvField
        jmp near ExportStatTable_221.15
.11:
        mov ebx, dword [byte ecx+0Eh]
        mov dl, byte [ebx+eax]
        dec dl
        cmp dl, 0Ch
        ja near ExportStatTable_221
        movzx edx, dl
        mov ebx, edx
        shl ebx, 2
        jmp dword [dword cs:ebx+ExportStatTableJumpTable]
ExportStatTable_19A:
        movsx edx, word [byte ebp-08h]
        mov eax, dword [byte ecx+01Ah]
        shl edx, 2
        mov eax, dword [edx+eax]
        imul eax, dword [byte ecx+08h]
        movsx edx, di
        add eax, edx
        mov edx, dword [byte ecx+012h]
        mov eax, dword [edx+eax*4]
        push dword [eax]
        jmp short ExportStatTable_1EB.13
ExportStatTable_1BA:
        movsx edx, word [byte ebp-08h]
        mov eax, dword [byte ecx+01Ah]
        shl edx, 2
        mov edx, dword [edx+eax]
        imul edx, dword [byte ecx+08h]
        movsx eax, di
        add eax, edx
        mov edx, dword [byte ecx+012h]
        mov eax, dword [edx+eax*4]
        movsx eax, word [eax]
        push eax
        push str_D_ExportStatTable
        lea eax, [byte ebp-07Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
ExportStatTable_1EB:
        movsx eax, word [byte ebp-08h]
        mov edx, dword [byte ecx+01Ah]
        mov eax, dword [edx+eax*4]
        imul eax, dword [byte ecx+08h]
        movsx edx, di
        add eax, edx
        mov edx, dword [byte ecx+012h]
        mov eax, dword [edx+eax*4]
        movsx eax, word [eax]
        mov ebx, 3Ch
        cdq
        idiv ebx
.12:
        push eax
.13:
        push str_D_ExportStatTable
.14:
        lea eax, [byte ebp-07Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
ExportStatTable_221:
        movsx eax, di
        lea edx, [byte ebp-07Ch]
        movsx ebx, word [dword ebp+eax*2-0E0h]
        mov eax, esi
        inc edi
        call WriteCsvLine
.15:
        movsx eax, di
        cmp eax, dword [byte ecx+08h]
        jl near ExportStatTable.11
        push StatExportSeparator
        push esi
        inc dword [byte ebp-08h]
.16:
        call fprintf_
        add esp, byte 8
        movsx edi, word [byte ebp-08h]
        cmp edi, dword [byte ecx+04h]
        jl near ExportStatTable.10
        mov eax, esi
        call fclose_
        jmp near DrawStatTableRows_4D7
ExportStatTable_26D:
        mov ebx, dword [byte ecx+01Ah]
        movsx edx, word [byte ebp-08h]
        mov ebx, dword [ebx+edx*4]
        imul ebx, dword [byte ecx+08h]
        mov edx, dword [byte ecx+012h]
        add eax, ebx
        mov ebx, dword [edx+eax*4]
        movsx ebx, word [ebx]
        cmp ebx, byte 0FFFFFFFFh
        jne short .18
        mov eax, 1ADh
.17:
        call GetLangText
        push eax
        lea eax, [byte ebp-07Ch]
        push eax
        call sprintf_
        add esp, byte 8
        jmp near ExportStatTable_221
.18:
        mov eax, ebx
        mov dword [byte ebp-0Ch], 64h
        cdq
        idiv dword [byte ebp-0Ch]
        mov dword [byte ebp-0Ch], 64h
        mov eax, ebx
        push edx
        cdq
        idiv dword [byte ebp-0Ch]
        push eax
        push str_D02d
.19:
        lea eax, [byte ebp-07Ch]
        push eax
        call sprintf_
        add esp, byte 10h
        jmp near ExportStatTable_221
ExportStatTable_2D9:
        mov ebx, dword [byte ecx+01Ah]
        movsx edx, word [byte ebp-08h]
        mov ebx, dword [ebx+edx*4]
        imul ebx, dword [byte ecx+08h]
        mov edx, dword [byte ecx+012h]
        add eax, ebx
        mov eax, dword [edx+eax*4]
        cmp word [eax], byte 0
        jne short .20
        mov eax, 1AEh
        jmp short ExportStatTable_26D.17
.20:
        movsx eax, word [eax]
        jmp near ExportStatTable_1EB.12
ExportStatTable_304:
        movsx ebx, word [byte ebp-08h]
        mov edx, dword [byte ecx+01Ah]
        shl ebx, 2
        add ebx, edx
        mov ebx, dword [ebx]
        imul ebx, dword [byte ecx+08h]
        mov edx, dword [byte ecx+012h]
        add eax, ebx
        mov ebx, dword [edx+eax*4]
        movsx ebx, word [ebx]
        mov eax, ebx
        mov dword [byte ebp-0Ch], 0Ch
        cdq
        idiv dword [byte ebp-0Ch]
        mov dword [byte ebp-0Ch], 0Ch
        mov eax, ebx
        push edx
        cdq
        idiv dword [byte ebp-0Ch]
        push eax
        push str_DD2
        jmp short ExportStatTable_26D.19
ExportStatTable_344:
        movsx edx, word [byte ebp-08h]
        mov ebx, dword [byte ecx+01Ah]
        shl edx, 2
        add ebx, edx
        mov ebx, dword [ebx]
        imul ebx, dword [byte ecx+08h]
        mov edx, dword [byte ecx+012h]
        add eax, ebx
        mov eax, dword [edx+eax*4]
        movsx eax, word [eax]
        push eax
        push str_03d
        jmp near ExportStatTable_1EB.14
ExportStatTable_36C:
        mov ebx, dword [byte ecx+01Ah]
        movsx edx, word [byte ebp-08h]
        mov ebx, dword [ebx+edx*4]
        imul ebx, dword [byte ecx+08h]
        mov edx, dword [byte ecx+012h]
        add eax, ebx
        mov eax, dword [edx+eax*4]
        movzx eax, byte [eax]
        jmp near ExportStatTable_1EB.12
ExportStatTable_38A:
        movsx eax, word [byte ebp-08h]
        mov edx, dword [byte ecx+01Ah]
        mov edx, dword [edx+eax*4]
        imul edx, dword [byte ecx+08h]
        movsx eax, di
        add edx, eax
        shl edx, 2
        mov eax, dword [byte ecx+012h]
        push dword [edx+eax]
        push str_S_ExportStatTable
        jmp near ExportStatTable_1EB.14
